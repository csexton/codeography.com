---
layout: post
title: "Zsh trick: restart pow with command completion"
published: true
---

Recently I started using the zero configuraiton web server [pow](http://pow.cx/) from the good folks at 37signals and absolutly love it. I really like how restarting the server is as simple as touching `restart.txt` to the `tmp` directory. However I have been working on a feature that requires frequent restarts of the server and found it repetitive. Since I was being lazy about typing in the path to `restart.txt` I decided to automate it a little. And add command completion.

Got those with the following zsh script:

    kapow(){
      touch ~/.pow/$1/tmp/restart.txt;
      if [ $? -eq 0 ]; then; echo "pow: restarting $1" ; fi
    }
    compctl -W ~/.pow -/ kapow

This gives me a `kapow` command that will restart the app for me.

I also put it up in a [gist](https://gist.github.com/965032), if you would like to fork it and make changes.
