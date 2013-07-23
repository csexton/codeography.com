---
layout: post
title: Navigating Vim and Tmux Splits
---

So I read this awesome blog post on the [Thoughtbot Blog](http://robots.thoughtbot.com/post/53022241323/seamlessly-navigate-vim-and-tmux-splits), that was just a write up of [Mislav's technique](https://gist.github.com/mislav/5189704), but it didn't work for me. Disallusioned and desolate I figured my fate was sealed. I would have to navigate splits in two totally different ways.

But what's this? [Aaron Jensen](https://github.com/aaronjensen) has another solution? Yes. Yes, he does. Does this one work? Like the wind.

This code is almost entirely taken from Aaron's dot files (see [vimrc](https://github.com/aaronjensen/vimfiles/blob/66b7da914b403c7885db87123068c1f7dc71c0eb/vimrc#L468-L502) and [tmux.conf](https://github.com/aaronjensen/dotfiles/blob/ebfacc5fba0eca45c592e465e6ed211350a4bce2/tmux.conf#L103-L109)). I am putting it here so i have things all in one place that I can find later when I want to set this up again.

Add this to your `.tmux.conf`:

```bash
bind -n C-h run "(tmux display-message -p '#{pane_title}' | grep -iq vim && tmux send-keys C-h) || tmux select-pane -L"
bind -n C-j run "(tmux display-message -p '#{pane_title}' | grep -iq vim && tmux send-keys C-j) || tmux select-pane -D"
bind -n C-k run "(tmux display-message -p '#{pane_title}' | grep -iq vim && tmux send-keys C-k) || tmux select-pane -U"
bind -n C-l run "(tmux display-message -p '#{pane_title}' | grep -iq vim && tmux send-keys C-l) || tmux select-pane -R"
```

And add this to your `.vimrc`:

```
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif
```

The cool thing about this approach is that vim detects if it is running in tmux and will set the pane title. Then tmux will inspect the pane title when you try to switch and pass the key press on through. I think Mislav's approach wasn't working for me because tmux would intercept the key before vim had a chance.

