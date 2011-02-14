---
layout: post
title: "Focus on a test in Vim"
published: true
---

I have found myself in the situation where I would have Vim running in one wondow, and a terminal open on the other monitor with my tests. And noticed I was constantly `⌘-tab;⌃-p;↩;⌘-tab` (switch windows to terminal; previous command; enter; switch windows to vim). Of course this muscle memory was broken when I switched to my browser inbetween. I wanted to automate this.

I could use autotest, but our test suite is slow to start up and I wanted to focus on one test.

I could run that test within Vim, but MacVim does not show the color escapes when running a command, plus it blocks my editing while I wait for the tests to run. 

I could use Vim in the terminal, but I like my ⌘ key mappings and colors.

My solution:

 1. Run the command from Vim in the background and redirect the output to a file
 2. Tail the log in Terminal

How to do it:

Run your test in vim, the line I would use is something like this (just replace the the command bit with the one you want to run):

    map <D-r> :silent execute "!ruby test/unit/post_test.rb &> /tmp/vim.log &" <cr>

And tail the logs:

    $ tail -f /tmp/vim.log

Now when ever I press `⌘-r` I can keep on tinkering with the code while the tests run on the other monitor.

I don't keep that command in my `.vimrc` file because I am constantly going back and changing the command -- this has become a macro that I change around as I am focusing on diffrent parts of my code.

Protip: use `q:` to interactivly edit and run past Vim commands.

Beauty of this is it works on any command, in any language I am programming in.
