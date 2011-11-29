---
layout: post
title: Install git man pages the easy way
---

There seems to be a few ways to install the git man pages, but these seems to involve some wacky tricks with a copy of the git repo checked out. I wanted to make sure I had the man pages for my exact version of git and just wanted them in place so I could do `git help command` and see some pretty helps.

First, figure out your version number. Mine was 1.6.4.2 

    git --version

Then download the tarball for that version and unzip to your manpage dir:

    curl -O "http://git-core.googlecode.com/files/git-manpages-1.7.7.4.tar.gz"
    sudo tar xjv -C /usr/local/share/man -f git-manpages-1.7.7.4.tar.gz

If you really don't want to think, cut-n-paste the following:

    cd /tmp
    curl -O "http://git-core.googlecode.com/files/git-manpages-`git --version | awk '{print $3}'`.tar.gz"
    sudo mkdir -p /usr/local/share/man
    sudo tar xjv -C /usr/local/share/man -f git-manpages-`git --version | awk '{print $3}'`.tar.bz2

