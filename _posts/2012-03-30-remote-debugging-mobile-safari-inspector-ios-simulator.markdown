---
layout: post
title: Mobile Safari Inspector with the iPhone Simulator
---

Thanks in large part do other folks (well, mostly [Nathan](http://atnan.com/blog/2011/11/17/enabling-remote-debugging-via-private-apis-in-mobile-safari/)) who dug in and figured out the private API to enable this in WebKit, we can actually use the web inspector from the desktop Safari browser to investigate pages we are viewing on the iPhone simulator. This has been huge when I have a strange bug in the layout of a page on the iPad and can't easily determine which element it is.

Here is my version of the script that takes things a bit further:

    d=$(ps x | egrep "MobileSafari|Web.app" | grep -v grep | awk '{ print $1 }')

    if [ "$pid" == "" ]; then
      echo "Safari.app must be running in the Simulator to enable the remote inspector."
    else

      cat <<EOS | gdb -quiet > /dev/null
        attach $pid
        p (void *)[WebView _enableRemoteInspector]
        detach
    EOS

      osascript <<EOS > /dev/null 2>&1
        tell application "Safari"
          activate
          do JavaScript "window.open('http://localhost:9999')" in document 1
        end tell
    EOS

    fi

Since I use chrome as my default browser, I quickly found that the remote inspector didn't always work with it - so I open safari automatically and load the inspector. Just one less step to worry about. I wanted to have it open the simulator and run Safari as well, but that turned out to require other tools to be installed so I punted. This is really the most common case for me anyway.

If you want a copy locally I recommend grabbing the one from my [dotfiles](https://github.com/csexton/dotfiles/blob/master/bin/mobile-safari-inspector), which I will keep up-to-date if I make any tweaks and changes.



