---
layout: post
title: Getting irb with readline support on Mac
---

I tend to install unix software on the mac the old school way by grabbing the tarball and building it. Well that was fun an all until I discovered that irb didn't like to honor backspace. Turns out I needed to build and install readline.


    curl -O ftp://ftp.cwru.edu/pub/bash/readline-6.1.tar.gz
    curl -O ftp://ftp.ruby-lang.org/pub/ruby/1.8/ruby-1.8.7-p248.tar.gz
    tar -zxvf readline-6.1.tar.gz
    cd readline-6.1
    ./configure
    make
    sudo make install
    cd ..
    tar -zxvf ruby-1.8.7-p248.tar.gz
    cd ruby-1.8.7-p248
    ./configure --with-readline-dir=/usr/local --enable-pthread
    make
    sudo make install
    sudo make install-doc
    ruby --version
    # woohoo!
