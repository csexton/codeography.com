---
layout: post
title: Vim Tip - VimGrep and QuickList
---

I have known about the vimgrep command for a while, but it was always a little awkward. Well that has all changed now that I know about the QuickFix window.

Take a gem project, I want to search through all the ruby files:

    :vimgrep my_method **/*.rb

Which jumps to the first one.  But (unbeknownst to me) it also populates the quick list.  You can bring up this fancy window with a `:cw`

Then you can simply navigate to the line you want to look at and hit `enter`. 

Suh-weet.

But it gets better. Often I want to look for a couple of keywords. I can keep adding to the quick list by using `vimgrepadd`:

    :vimgrep your_method **/*.rb

Then you end up with the results of both in your quick list window, which is a simple `C-w C-w` away.
