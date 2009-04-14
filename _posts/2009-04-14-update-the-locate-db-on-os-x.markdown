---
layout: post
title: Update the locate DB on OS X

---

Turns out OS X does not have an `updatedb` command like linux has, so I was stumped on how to update the locate database.

After a little digging I found the command we needed:

    sudo /usr/libexec/locate.updatedb

It is a little paranoid about revealing file names, but it is happy to index everything for you.
