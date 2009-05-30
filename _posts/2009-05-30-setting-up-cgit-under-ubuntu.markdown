---
layout: post
title: Setting up cgit under Ubuntu
---

I tried gitweb and wasted most of a day trying to get apache to stop escaping ";" with "%3", took a hack at a few of the php based git browsers -- no luck. That was until I came accross cgit.

First setup the prereques. I had most of what I needed but was missing libcurl, so I ran the following command to add that.  I am sure you will need a few other like git-core and build-essentials.
    sudo apt-get install libcurl4-openssl-dev

Building cgit
-------------
    git clone git://github.com/metajack/cgit.git
    cd cgit/
    git submodule init
    git submodule update
    make

I skip the make install step because I put the binary in a seprate cgi-bin directory anyway. 

    sudo cp ./cgit /usr/lib/cgi-bin/cgit.cgi

Of course if you use a different location for your cgi-bin you will want to put that in the above command

If /var/www/htdocs/ is your docroot (which mine is) you will want to move the css and png files there:

    cp ./cgit.css /var/www/htdocs/
    cp ./cgit.png /var/www/htdocs/git-logo.png # the default logo

Configure cgit
--------------

Create a file at /etc/cgit and add the following:

    virtual-root=/git/
    enable-index-links=1
    enable-log-filecount=1
    enable-log-linecount=1
    snapshots=tar.gz tar.bz zip

    # List of repositories
    repo.url=red_baron
    repo.path=/home/git/repositories/red_baron.git
    repo.desc=Ace of the skies
    repo.owner=Reb Baron

    repo.group=project1
    repo.url=sub1
    repo.path=/home/git/repositories/sub1.git
    repo.desc=Sub1 of Project1
    repo.owner=Joe Cool

    repo.url=sub1
    repo.path=/home/git/repositories/sub1.git
    repo.desc=Sub2 of Project1
    repo.owner=Snoopy


Configure Apache
----------------

Add the following under your virtual host tag:

       # Add the cgi-bin if you don't have one already
       ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
       # Add the trailing slash
       RewriteRule ^/git$ /git/ [R]
       # Pretty urls
       RewriteRule ^/git/(.*)$ /cgi-bin/cgit.cgi/$1 [PT]


At this point you should be able to restart apache and browse to your git repos at http://hostname/git


