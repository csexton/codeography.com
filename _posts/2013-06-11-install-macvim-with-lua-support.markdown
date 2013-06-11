---
layout: post
title: install macvim with lua support
---

If you use the amazing [unite.vim](https://github.com/Shougo/unite.vim) plugin and noticed it being anything less than snappy, then you need to make sure you have vim with lua support enabled.

You can see if you copy of vim has it enabled by running `:version` and looking for `+lua`. If you see `-lua` it is not enabled. The main download binary for MacVim does not have it enabled.

The solution for this is simple, install MacVim from Homebrew with the `--with-lua` flag. The exact command I use is:

    brew install macvim --with-cscope --with-lua --override-system-vim

That will install with lua and cscope, and will put a symlink in `/usr/local/bin` that will shadow your system command line vim. All good things. To see the other options check out the [homebrew formula](https://github.com/mxcl/homebrew/blob/master/Library/Formula/macvim.rb).
