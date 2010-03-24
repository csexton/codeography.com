---
layout: post
title: "Running git-daemon on Ubuntu"
published: true
---

I needed a simple init script for running git daemon under ubuntu 9.10, and after a little searching and tweaking I wound up with the following.

Create a /etc/init.d/git-daemon:

    #!/bin/sh
    test -f /usr/bin/git || exit 0
    . /lib/lsb/init-functions
    GITDAEMON_OPTIONS="daemon --reuseaddr --verbose --base-path=/home/git/repositories/ --detach"
    case "$1" in
        start)  log_daemon_msg "Starting git-daemon"
        start-stop-daemon --start -c git:git --quiet --background \
        --exec /usr/bin/git -- ${GITDAEMON_OPTIONS}
        log_end_msg $?
        ;;
        stop)   log_daemon_msg "Stopping git-daemon"
        start-stop-daemon --stop --quiet --name git-daemon
        log_end_msg $?
        ;;
        *)      log_action_msg "Usage: /etc/init.d/git-daemon {start|stop}"
        exit 2
        ;;
    esac
    exit 0

Then you can install and start it:

    sudo update-rc.d git-daemon defaults
    sudo /etc/init.d/git-deamon start
