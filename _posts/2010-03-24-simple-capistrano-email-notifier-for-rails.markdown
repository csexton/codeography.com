---
layout: post
title: "Simple Capistrano email notifier for rails"
published: true
---

I needed to send out emails every time I deployed a rails app, and wanted to use the libraries that were already included with rails -- e.g. ActionMailer.

My solution was based on some ideas from [capistrano-mailer](http://github.com/pboling/capistrano_mailer) and [Mislav Marohnić](http://pastie.org/146264) example, but I felt both were overkill for what I need, so here is my very simple, very customizable solution.

Create a file `config/deploy/notifier.rb` with the following contents:

    $:.unshift File.dirname(__FILE__) + '/../../vendor/rails/actionmailer/lib'
    require File.dirname(__FILE__) + '/../../vendor/rails/actionmailer/lib/actionmailer.rb'

    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.raise_delivery_errors = true
    ActionMailer::Base.default_charset = "utf-8"
    ActionMailer::Base.smtp_settings = {
      :address        => "mail.example.com",
      :port           => 25,
      :domain         => 'example.com',
      :perform_deliveries => true,
      :user_name      => 'user',
      :password       => 'secret',
      :authentication => :login }

    class Notifier < ActionMailer::Base
      def deploy_notification(cap_vars)
        now = Time.now
        recipients cap_vars.notify_emails
        from     "App Deployments <app_deployments@example.com>"
        subject  "Deployed to #{cap_vars.host}"

        body <<-MSG
          Performed a deploy operation on #{now.strftime("%m/%d/%Y")} at #{now.strftime("%I:%M %p")} to #{cap_vars.host}

          Deployed to: https://#{cap_vars.host}
        MSG
      end
    end

Which is stupid easy to customize, if you'd like to include the multistage info in the email body just edit the MSG and add `#{cap_vars.stage}` or any [other variable](http://labs.peritor.com/webistrano/wiki/ConfigurationParameter) that was set in the cap file.

Now to get it hooked into your cap file. Simply edit `config/deploy.rb` and add the following


    require 'config/deploy/notifier.rb'

    # Setup the emails, and after deploy hook

    set :notify_emails, ["ampere@example.com", "henry@example.com]
    after "deploy", "deploy:notify"

    # Create the task to send the notification

    namespace :deploy do
      desc "Email notifier"
      task :notify
        Notifier.deliver_deploy_notification(self)
      end
    end

This is not really rails specific, but if I were using Sinatra I would probably not use ActionMailer -- something like [Pony](http://github.com/benprew/pony) would be a little prettier -- but the Capistrano configuration would work just fine.
