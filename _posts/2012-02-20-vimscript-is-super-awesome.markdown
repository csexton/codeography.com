---
layout: post
title: Vimscript is Super Awesome
---

OK, sure it could be a little prettier, and yeah, it make simple things awkward. But it has one killer feature that I think is often overlooked. Vimscript uses the same commands that you use when editing a file.

This is actually really cool. Basically if you can do something while using the editor you can do it in a script. Think about that, you can really automate everything you already do, and since you already do it--you know how to automate it. The inverse is true as well, if you read it in a script you can do that while editing.

A quick example. Strip trailing white space. I've done this often, open a file with a ton of garbage whitespace, and want to strip it out. Open google and search for "vim remove trailing whitespace" and use some reqular expression in a search and replace command. But this can be automated easily.

Instead of having to remember this command:

    :%s/\s\+$//e

I make a command that will do it:

    command Trim %s/\s\+$//e

Now I just have to remember the command, and `Trim` is much easier for me to remember.

Or get make a funciton that I can call from other vim script:

    function! Trim()
        %s/\s\+$//e
    endfunction

It just keeps building on the same commands. And really, what could go wrong?

If you want to learn more, I hightly recomend Steve Losh's [Learn Vimscript the Hard Way](http://learnvimscriptthehardway.stevelosh.com/). I also have a more robust version of the [trim command](https://github.com/csexton/trailertrash.vim).
