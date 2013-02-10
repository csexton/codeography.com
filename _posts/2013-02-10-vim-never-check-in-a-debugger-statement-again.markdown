---
layout: post
title: Vim - highlight debugger statements
---

<img src="/images/vim-debugger.png" style="height:447px;" />

I know some folks thoroughly disapprove of using debugger, but in the context of a big app, using a framework or libraries you didn't write I find them crazy helpful. Plus you can drop into your unit tests to track down a failure so easy.

My problem is I have been known to check in code that has a debugger statement. Only to end up with a git log like this:

    * 0f93265 Remove debugging statements.

I used a git pre-commit hook for a while to stop me from checking bad things in, and that did the job but I found it to be jarring. Really what I needed was to make it painfully obvious when I had dropped one into my code. This gets the job done nicely in vim:


    " Make those debugger statements painfully obvious
    au BufEnter *.rb syn match error contained "\<binding.pry\>"
    au BufEnter *.rb syn match error contained "\<debugger\>"

Also in a [gist](https://gist.github.com/csexton/4742417).
