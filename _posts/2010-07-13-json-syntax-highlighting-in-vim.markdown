---
layout: post
title: "Don't need no json.vim, get json syntax highlighting for free"
published: true
---

Recently I needed to work with some .json files and notice vim didn't know how to highlight them. A little baffled I turned to google and discovered json.vim. Installed it, setup the autocommand to reconize .json files as json and was set.

But being stingy about what plugins I load, it dawned on me -- vim supports JavaScript, why not just use that for highlighting my json files? doing so was stupid-easy. Just add this line to your .vimrc:

    autocmd BufNewFile,BufRead *.json set ft=javascript

Done and done. Got good-enough hihglighting and only added one line of vimscript.
    
