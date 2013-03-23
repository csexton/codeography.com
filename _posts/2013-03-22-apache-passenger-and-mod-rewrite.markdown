---
layout: post
title: Apache, Passenger and mod rewrite
---

After spending entirely too much time batteling with `mod_rewrite` I figured I would document how I solved my problem.

Basically I wanted different paths for my apis based on the host name. Turns out the hard part was figuring out how to convince apache to rewrite the urls so that Rails would be happy. Here is the entire apache config file (aside from the ssl and assets VirtualHosts):

    # Passenger

    LoadModule passenger_module /usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.18/ext/apache2/mod_passenger.so
    PassengerRoot /usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.18
    PassengerRuby /usr/local/bin/ruby_with_env

    <VirtualHost *:80>
        <IfModule mod_rewrite.c>
            RewriteEngine On
            RewriteCond %{HTTP_HOST} ^api [NC]
            RewriteCond %{REQUEST_URI} !^/api [NC]
            RewriteRule ^/(.*) /api/$1 [PT,L,QSA]
        </IfModule>
        ServerName app.messageradius.com
        DocumentRoot /var/www/passenger/current/public
        <Directory   /var/www/passenger/current/public>
           AllowOverride all
           Options -MultiViews
        </Directory>
    </VirtualHost>

The break down:

    RewriteCond %{HTTP_HOST} ^api [NC]

This matches any domains that start with "api"

    RewriteCond %{REQUEST_URI} !^/api [NC]

This will match any paths that do not start with "/api"

    RewriteRule ^/(.*) /api/$1 [PT,L,QSA]

Here is the part that too me so much effort. The [options passed into the RewriteRule](http://httpd.apache.org/docs/2.2/mod/mod_rewrite.html). You need at least `PT` and `L` for Passenger to mangle the url and pass it to your app.

* `PT` - Forces the resulting URI to be passed back to the URL mapping engine for processing of other URI-to-filename translators
* `L` - Stop the rewriting process immediately and don't apply any more rules.
* `QSA` - Appends any query string from the original request URL to any query string created in the rewrite target.

I went ahead an added `QSA` to merge query parameters. I am not sure it is required, but seems to work.



