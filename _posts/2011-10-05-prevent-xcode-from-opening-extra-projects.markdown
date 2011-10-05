---
layout: post
title: Prevent Xcode from opening extra projects
---

Insistent I don't want persistence.

I've been a little annoyed with Xcode on Lion. Every time I open a project it also opens the last project I was working on. This might be fine if I was only working on one project -- but recently I have been working on Captured in the evenings, and Zippy's iPhone app during the day. I don't want to open the project for Captured when I get to work in the morning. Plus it is particularly frustrating when one of those projects is a workspace, if you create a new project Xcode insists on adding it to the current workspace.

The solution: fix my `xcode` script, by passing in a user defaults flag.

I have been using a helper function to load xcode from the command line for a while now, and really it is the primary way that I open a project. Maybe I am in minority for Cocoa developers, but I live on the command line -- so this is better for me.

    #!/usr/bin/env ruby
    f = []
    f.concat Dir["*.xcworkspace"]
    f.concat Dir["*.xcodeproj"]

    if f.length > 0
      puts "opening #{f.first}"
      `open -a /Developer/Applications/Xcode.app #{f.first} --args -ApplePersistenceIgnoreState YES`
      exit 0
    end

    puts "No Xcode projects found"
    exit 1

The trick is the `ApplePersistenceIgnoreState` option passed in to Xcode, this overrides the NSUserDefault for the app persistence.

If you want to use this, just create a file `xcode` somewhere in your path and then set it to be executable `chmod +x xcode`. Then opening project is as simple as:

    cd path/to/proj
    xcode

Refreshing.
