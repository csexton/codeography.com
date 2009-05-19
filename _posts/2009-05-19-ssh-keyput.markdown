---
layout: post
title: ssh-keyput
---

That's pronounced "shush-kaput"

If there is one thing I like it is setting up ssh to use my public key so that I don't have to type a password when login to a server. This wasn't too hard, but since OSX does not have ssh-copy-id by default I would have to pull up the instructions every time to make sure I remembered the file names and permissions just right.

So last night I made a ruby gem to remember how to do it for me, ssh-keyput

Now all I's got to do to copy my public key is:

    $ ssh-keyput chris@server.com


To install all you need is a simple gem install:

    $ gem install csexton-ssh-keyput -s http://gems.github.com

It is nothing but a glorified wrapper for a few shell commands, but it is much easier to remember
