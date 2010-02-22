---
layout: post
title: Nice syntax highlighting in Xcode
---

I am a big fan of vibrant ink color scheme, and have spent more than a little time so that I can have similar colors when I am looking at code outside of textmate. I have my version of the scheme in Vim, Visual Studio, Trac and now Xcode.

<img src="/media/ristoink_xcode.png" />

I couldn't find anyway to export the color schemes in the Xcode properties so I went poking around. Turns out it is exactly where you would expect it:

    ~/Library/Application Support/Xcode/Color Themes

It has a simple xml plist file, perfect for version control.  So I copied it to my dotfiles git repository and symlinked it. So if you want my latest color scheme head over to github and take a look. Or you could just [download it](http://github.com/csexton/dotfiles/raw/master/xcode/RistoInk.xccolortheme).

To install it just drop it into the library directory above.

