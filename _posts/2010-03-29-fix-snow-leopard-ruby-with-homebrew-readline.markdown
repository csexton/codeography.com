---
layout: post
title: "Fix Snow Leopard's ruby line editor with homebrew's readline"
published: true
---

This is just a very slight adoption of [Jorge Bernal's awesome post](http://www.jorgebernal.info/development/fixing-snow-leopard-ruby-readline), the only real difference is I use Homebrew to install readline. 

First setup [homebrew](http://github.com/mxcl/homebrew/).

Then install readline:

    brew install readline

Wasn't that nice?

Now, onto fixing Snow Leopard's Ruby:

    curl -O http://www.opensource.apple.com/tarballs/ruby/ruby-75.tar.gz
    tar xvf ruby-75.tar.gz
    cd ruby-75/ext/readline/
    ruby extconf.rb
    make

If you get an error Jorge Bernal suggests telling gcc to use the readline in /usr/local

    make readline.o CFLAGS='-I/usr/local/include -DHAVE_RL_USERNAME_COMPLETION_FUNCTION'
    cc -arch i386 -arch x86_64 -pipe -bundle -undefined dynamic_lookup -o readline.bundle readline.o -L/usr/local/lib -L/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib -L. -arch i386 -arch x86_64 -lruby -lreadline -lncurses -lpthread -ldl

You might want to check that bundle with `otool`:

    otool -L readline.bundle

When I run that I see the following:

    readline.bundle:
       /System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/libruby.1.dylib (compatibility version 1.8.0, current version 1.8.7)
       /usr/lib/libedit.2.dylib (compatibility version 2.0.0, current version 2.11.0)
       /usr/lib/libncurses.5.4.dylib (compatibility version 5.4.0, current version 5.4.0)
       /usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 125.0.0)

Which happens to be slightly different from Jorge's, but everything seems to work for me.

Move the existing file out of the way, and replace it with our shiny new bundle:

    mv /System/Library/Frameworks/Ruby.framework/Versions/Current/usr/lib/ruby/1.8/universal-darwin10.0/readline.bundle /System/Library/Frameworks/Ruby.framework/Versions/Current/usr/lib/ruby/1.8/universal-darwin10.0/readline.bundle.libedit
    cp readline.bundle /System/Library/Frameworks/Ruby.framework/Versions/Current/usr/lib/ruby/1.8/universal-darwin10.0/

This was 

