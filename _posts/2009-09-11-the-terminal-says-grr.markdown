---
layout: post
title: The terminal says Grr
---

I have been building a few things that take a while to compile *cough*llvm*cough* and started using growl to let me know to stop reading hacker news and go back to doing something useful.

    $ make ; growlnotify -m "All done!"

Then it dawned on me, I should make some aliases. I made two: Yay, for when things were happy to finish. Boo for when I didn't want something to stop.

I put this in my .bash_login:

    alias yay="growlnotify -m Yay!"
    alias boo="growlnotify -m Boo!"

Now when I run make I can just do a `make ; yay` and it will cheer when it is done. Likewise if I am running one of my deamons that is not supposed to stop running (aka crash) I will do a `server ; boo`.

I'ts like decorating the homely terminal with some pretty golden growl messages. Suddenly everything is pretty!
