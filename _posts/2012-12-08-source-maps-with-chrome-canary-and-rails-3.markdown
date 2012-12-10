---
layout: post
title: Source Maps with Chrome Canary and Rails
---

I was having problem piecing together all the steps to enabling source maps in Chrome Canary. I really wanted to get it working with the rails-sass gem that comes with Rails 3, and the Asset Pipeline.

Eventually I got things working, this is what I did:

## Step 1:

In [Chrome Canary](https://tools.google.com/dlpage/chromesxs) navigate to `chrome://flags/`

## Step 2:

Search for "Developer Tools experiments" and enable

<img src="/images/source-map-01.png" style="height:500px;" />

## Step 3:

Enable sass support in the developer tools:

1. View-&gt;Developer-&gt;Developer Tools.
1. Click the gear in the bottom right.
1. Choose the Experimental Tab.

Settings:

<img src="/images/source-map-02.png" style="height:500px;" />

Experiments tab:

<img src="/images/source-map-03.png" style="height:500px;" />


## Step 4:

In `config/enviroments/development.rb` Add `config.sass.debug_info = true` inside the `Application.configure` block.

    MyApp::Application.configure do
      # Settings specified here will take precedence over those in config/application.rb

      # ...

      # Do not compress assets
      config.assets.compress = false

      # Expands the lines which load the assets
      config.assets.debug = true

      # Enable source maps in the browser
      config.sass.debug_info = true
    end

This should cause rails-sass to include the `@media -sass-debug-info` statements in your generated application.css file. I found it helpful to visit `/assets/application.css` directly on the rails app to make sure that was working.

## Step 5:

Reboot all the things. Reload rails server. Reload the browser.

## Step 6:

Now the developer tools links to your sass files directly. Huzzah!

<img src="/images/source-map-04.png" style="height:500px;" />
