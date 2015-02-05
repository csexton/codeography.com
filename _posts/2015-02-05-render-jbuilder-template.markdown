---
title: Render JBuilder Template
layout: post
date: 2015-02-05
---


I like to use the built-in JBuilder for rendering JSON in my Rails apps. I particularly like that it is an actual view template, gives you the control and tools you need to easily build up the document. There is no need to teach your models about icky things like URLs and hostnames -- that can be rendered with view helpers as part of the request.

The one problem is there is no easy way to use those templates outside of a Rails response. But luckily [Aaron](https://github.com/cupakromer) came up with a helpful class to setup everything properly and mimic the `Request`. He even added support for setting things like the `location` header.

To use it in a service object (like say a rake task that runs on a worker process):

```ruby
# Create the object
json_view = JsonView.new

# Set any headers that matter, where `posts` is the obligatory example resource.
location = json_view.location_url(posts)

# Render the template
payload = json_view.render(:show, posts: posts)
```

Pretty cool, eh?

His implmentation that takes care of all the details of the request:


```ruby
class JsonView
  attr_reader :controller
  def initialize(env = {})
    @controller = API::V1::BeaconsController.new
    controller.request = ActionDispatch::Request.new(default_env.merge(env))
  end

  def render(view, **locals)
    controller.render_to_string(view, locals: locals)
  end

  def https?
    @_https ||= ENV.fetch("SERVER_HTTPS") {
      Rails.application.config.force_ssl
    }
  end

  def default_env
    {
      "SERVER_NAME"     => ENV.fetch("SERVER_NAME") {
        abort "Missing environment key: SERVER_NAME"
      },
      "SERVER_PORT"     => https? ? "443" : "80",
      "HTTPS"           => https? ? "on" : "off",
      "rack.url_scheme" => https? ? "https" : "http",
      "CONTENT_TYPE"   => "application/json",
      "HTTP_ACCEPT"    => "application/json",
    }
  end

  # Helpful shim reaching into the controller private stuff
  def location_url(beacons)
    controller.send(:location_url, beacons)
  end

  def respond_to_missing?(meth, include_all)
    controller.respond_to?(meth) || super
  end

  def method_missing(sym, *args, &block)
    if controller.respond_to?(sym)
      controller.send(sym, *args, &block)
    else
      super
    end
  end
end
```


