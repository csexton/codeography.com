---
layout: post
title: Blogging with Vim
---

I was inspired by [Jack Moffitt](http://metajack.im/2009/01/02/manage-jekyll-from-emacs/), and his Jekyll glue for Emacs.

Not willing to let Emacs win this one, I busted out a `:h script` and dove into the bizarre world of vim script. And unlike other forays into wacky programming languages, this actually resulted in something that I find useful.

Basically I have two functions, a way to list all the posts in my jekyll blog and a way to make a new post.

`:JekyllPost` Create a new post, which will create a new buffer populated with a basic template. This does not actually write the file, so if you are like me you can start a post, change your mine and `:q!` and have no regrets.

`:JekyllList` List the posts, opens the vim file system browser in the posts directory. Which lets you quickly search and open any of you previous entries.

If you use git to store you Jekyll blog (and who doesn't?),  you can use the following:

`:JekyllCommit` Adds and commits all the modified posts in your jekyll blog.

`:JekyllPublish` Pushes the changes to the remote origin.

I also made a couple of short cuts that save those precious few keystrokes:

    map <Leader>jn  :JekyllPost<CR>
    map <Leader>jl  :JekyllList<CR>
    map <Leader>jc  :JekyllCommit<CR>
    map <Leader>jp  :JekyllPublish<CR>

You can grab a copy over on [github](http://github.com/csexton/jekyll.vim).
