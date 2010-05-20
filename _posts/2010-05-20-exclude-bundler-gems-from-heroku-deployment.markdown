---
layout: post
title: "Exclude bundler gems from Heroku deployment"
published: true
---

I had some gems that I only needed for development on my mac, and did not want them to be installed to my Heroku slug. I didn't want them installed because they would break the deployment.

Everything was fine until I wanted to use autotest with my Rails 3 app that is hosted on Heroku. I got this error when I tried to deploy:

    ERROR: Failed to build gem native extension. (Gem::Installer::ExtensionBuildError)
       /usr/ruby1.9.1/bin/ruby extconf.rb
       extconf.rb:19:in `<main>': Only Darwin (Mac OS X) systems are supported (RuntimeError)
       Gem files will remain installed in /disk1/tmp/12479_23567910067960/.bundle/gems/gems/autotest-fsevent-0.2.2 for inspection.


As they call out in their [documentation](http://docs.heroku.com/bundler), "Heroku does not specify any groups during bundle installation, so all gems from all groups will be bundled with your application." I needed to find a way to exclude some libraries from being installed.

Based on a tip from the Heroku [mailing list](http://groups.google.com/group/heroku/browse_frm/thread/2a533b210b400e69/c9d753e89758ed57?hl=en&lnk=gst&) I found that the following worked:

    gem "autotest-fsevent" if RUBY_PLATFORM =~ /darwin/

But if I was going to exclude one gem, I figured I could exclude all my development gems, so I wound up doing this:

    if RUBY_PLATFORM =~ /darwin/
      group :test do
        gem "rspec-rails", ">= 2.0.0.beta.8"
        gem 'factory_girl', :git => 'git://github.com/thoughtbot/factory_girl.git', :branch => 'rails3'
        gem 'autotest-rails'
        gem 'autotest'
        gem 'autotest-fsevent'
        gem 'autotest-growl'
      end
    end

So I made that change, and deployment was still failing. I removed my Gemfile.lock and everything worked. 

This presents a complication, which according to [Yehuda](http://yehudakatz.com/2010/04/), "because gems no longer live in your application, we needed a way to snapshot the list of all versions of all gems used at a particular time, to ensure consistent versions across machines and across deployments."

To work around this I am specifying exact versions of the gems in my Gemfile. 

Of course if Heroku added support for `bundle install --without test`, everything would _work just as it should_&trade;.

Added Bonus: My compiled slug size went from 19.6MB to 5.1MB.
