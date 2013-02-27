---
layout: post
title: localtime directive for angularjs
---

A little while back I wrote about a [jQuery plugin](http://www.codeography.com/2012/10/11/convert-timestamps-localtime-jquery.html) I had that would convert UTC time stamps to the local timezone of the browser. Since then I have been experimenting a bit with [AngularJS](http://angularjs.org/) and wanted the same thing but in an angly way. Here is my attempt at porting that code over.

First I made a module that declared a directive:

    @angular.module('localtime').directive 'localtime', ->
      # Makes a string with only two characters, adding a leading zero
      fmtZero = (str) ->
        ('0' + str).slice(-2)
      # This is the function to change if you want to customize the format of the date
      fmtDate= (d) ->
        # format the date
        hour = d.getHours()
        if hour < 12
          meridiem = "AM"
        else
          meridiem = "PM"
        hour = 12  if hour is 0
        hour = hour - 12  if hour > 12
        hour + ":" + fmtZero(d.getMinutes()) + " " + meridiem + " " + (d.getMonth()+1)+ "/" + d.getDate() + "/" + d.getFullYear()

      restrict: 'E'
      link: (scope, element, attrs) ->
        tagText = element.html()
        element.html fmtDate(new Date(tagText))
        element.attr "title", tagText

The real magic is in the `link` function that grabs the current html content for the element and overwrites it. To help with debugging I stick the original timestamp in the `title` attribute -- which you can see when you mouse over a date.

Then in my angular app, I just include the module:

    @myApp = angular.module('myApp', ['localtime'])

Now, in my markup I simply wrap the timestamps I care about in `<localtime>` tags and they get switched over to a nicely formatted string in the user's local time zone.

The end result is string going from this:

<localtime>2013-02-26T17:53:00+00:00</localtime>

To this:

<localtime title="2013-02-26T17:53:00+00:00">12:53 PM 2/26/2013</localtime>


