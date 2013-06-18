---
layout: post
title: replacing all the things with unite.vim
---

Recently started using [Unite.vim](https://github.com/Shougo/unite.vim) and have really been liking it. I found it through a blog post by [Bailey Ling](http://bling.github.io//blog/2013/06/02/unite-dot-vim-the-plugin-you-didnt-know-you-need/#comment-919769841) where he describes how he replaced a number of his plugins with Unite. So I gave it a go, and sure enough I was able to replace Command-T, Yankstack and BufExplorer.

That last one surprised even me, I've been using BufExplorer for more than a decade and swore I was never gonna give it up.

First my rationale behind loving this lil plugin. Not only is it a powerful interface for navigating my code, but it is a consistant interface. Once I get the muscle memory for navigating one thing (say buffers), I can use that to navigate all the things (say yank history).

And the other, and this was killer for me, it can be modal. This doesn't sound like a big deal, but I feel this is how vim is supposed to work -- it is a modal editor dammit. Instead of popping open a split for the search list at the top or bottom of the window, Unite can be told to open in the active pane. This means when you invoke it unite will open in the pane you are operating on. Which is what I care about. No guessing, it just pops open right where I was looking to start with.

To show you what I mean:

<div class="vimwin">
<div class="vimhead"> VIM </div>
<div class="vimbody"><img src="/images/unite-modal-c.gif" /></div>
</div>

One of the things I like about unite is that it does not come with default keybindings out of the box. You have to (you get to?) set them up yourself. But starting with a good example never hurts, so here is what I have in my `.vimrc` if you would like some insperation:


    " Unite
    let g:unite_source_history_yank_enable = 1
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    nnoremap <leader>t :Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
    nnoremap <leader>f :Unite -no-split -buffer-name=files   -start-insert file<cr>
    nnoremap <leader>r :Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
    nnoremap <leader>o :Unite -no-split -buffer-name=outline -start-insert outline<cr>
    nnoremap <leader>y :Unite -no-split -buffer-name=yank    history/yank<cr>
    nnoremap <leader>e :Unite -no-split -buffer-name=buffer  buffer<cr>

    " Custom mappings for the unite buffer
    autocmd FileType unite call s:unite_settings()
    function! s:unite_settings()
      let b:SuperTabDisabled=1
      " Enable navigation with control-j and control-k in insert mode
      imap <buffer> <C-j>   <Plug>(unite_select_next_line)
      imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
    endfunction

Hopefully this gives you a decent place to start building an awesome vimming rig.
