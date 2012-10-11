---
layout: post
title: Convert timestamps to localtime with jQuery
---

Dealing with dates and times is a real pain. Everything is an edgecase. Having lived through a good deal of pain working with this suff I have made a rule: All times stored in the database shall be in UTC.

This makes many things much easier, but that sure makes for ugly dates to show an end user. And more importantly I can never do the conversion in my head between timezones. I just think in my local timezone, and in a 12 hour clock. So I would like to see my dates that way.

There are other solutions for this out there, but many of them involve too much gymnastics. I don't want to make a TimeZoneOffset controller and inject a bit of JS into my page to post to it and set a session variables. I don't want to store the user's timezone in the database. And really I don't want my server converting 1000's of timestamps when I could have the browser do it for me.

So my solution was to write a jQuery plugin. Add a little view helper to keep things clean.

The code:

    (function() {
      (function($) {
        return $.fn.localtime = function() {
          var fmtDate, fmtZero;
          fmtZero = function(str) {
            return ('0' + str).slice(-2);
          };
          fmtDate = function(d) {
            var hour, meridiem;
            hour = d.getHours();
            if (hour < 12) {
              meridiem = "AM";
            } else {
              meridiem = "PM";
            }
            if (hour === 0) { hour = 12; }
            if (hour > 12) { hour = hour - 12; }
            return hour + ":" + fmtZero(d.getMinutes()) + " " + meridiem + " " + (d.getMonth() + 1) + "/" + d.getDate() + "/" + d.getFullYear();
          };
          return this.each(function() {
            var tagText;
            tagText = $(this).html();
            $(this).html(fmtDate(new Date(tagText)));
            return $(this).attr("title", tagText);
          });
        };
      })(jQuery);
    }).call(this);

This was originally written in coffeescript, so grab [that](https://gist.github.com/3874031) if you prefer.

Load the plugin, and have it find the matching tags in your document ready block:

    $(document).ready(function() {
      $("span.localtime").localtime();
    });

Then you just wrap dates in a span with class of 'localtime':

    <span class="localtime">2012-10-10 06:42:47 UTC</span>

And the dates get converted to this:

    <span class="localtime" title="2012-10-10T06:42:47+0000">2:42 AM 10/10/2012</span>

Which looks nice and readable to me:

    2:42 AM 10/10/2012

Adding a little sugar - View helper

I wanted to keep my markup nice an neat so I made a `localtime_tag` helper to clean things up a little. Here is how I implemented it in ruby:

    def localtime_tag(time)
      time = Time.parse(time) unless time.respond_to? :strftime
      formatted_str = time.strftime('%Y-%m-%dT%H:%M:%S%z')
      content_tag :span, formatted_str, class: 'localtime'
    end

It will take the date and format it into a timestamp that will include timezone so that the JS `Date` parser will be able to convert it to the local time.
