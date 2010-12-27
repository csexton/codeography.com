---
layout: post
title: "rvm and vim combined: tastes like awesome"
published: true
---

After a [tweet](http://twitter.com/bryanl/status/17013225815) about vim status lines by non other than [Bryan Lyles](http://smartic.us/) I set out to get git and rvm info in vim's status line. Well, git was easy since I was using Tim Pope's fugitive plugin:

    set statusline+=%{fugitive#statusline()}

But had no such luck with rvm, so I decided to roll my own. And thus we have [rvm.vim](http://github.com/csexton/rvm.vim). Which will report the ruby interperter you are using, the version of that guy and the active gemset (if you have one). It does assume you start vim from the terminal, but what self respecting vim user dosen't live on the command line all day long?

Installation is easy, just go back to the aforementioned command line and paste this in:

    curl http://github.com/csexton/rvm.vim/raw/master/plugin/rvm.vim > ~/.vim/plugin/rvm.vim

Or if you are one of the cool kids and use [pathogen](http://github.com/tpope/vim-pathogen) you can just clone the repo into your bundle directory:

    git clone http://github.com/csexton/rvm.vim.git ~/.vim/bundle

And this will give you a similar status line trick to fugitive:

    set statusline+=%{rvm#statusline()}

What good is this hotness with out a screen shot?

![rvm statusline](/images/vimrvm.png)

If you want your status line to look just like this, this is how to do it:

    set statusline=[%n]\ %<%.99f\ %h%w%m%r%y%{exists('g:loaded_fugitive')?fugitive#statusline():''}%{exists('g:loaded_rvm')?rvm#statusline():''}%=%-16(\ %l,%c-%v\ %)%P

What's on your vim status line?
