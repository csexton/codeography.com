---
layout: post
title: "Howto: Mirror Git to Subversion"
published: true
---

I recently had to setup read only Subversion mirrors for a few Git repositories, and quickly notice the was no consensus on how to do this. Not really happy with the other solutions I found I decided to roll my own using the tools that git already provides. And some cron. Sweet, sweet cron.

A couple of assumptions:

 * `/var/svn` - The location of your subversion repositories
 * `/home/git/repositories` - the Location of your git repositories
 * `/home/git/svn` - location of a work repo, actually performs the pull from the origin, merges, and dcommits to subversion.

You could easily move these elsewhere if you want, nothing special about their location.

# Creating the Mirror

Lets say we have a project, called Ampere, and we want to setup a mirror.

You have two situations here. Either you are starting with a Subversion repository that you want to move to git, and maintain as a read only mirror. Or you want to create a new Subversion mirror from an existing Git repository.

## Option 1: Create a git repo from an existing svn repository

How I exported all of ampere from Subversion and add it to Git, then created a Subversion mirror.

    mkdir /home/git/svn
    cd /home/git/svn
    git svn clone file:///var/svn/ampere/web -T trunk -b branches -t tags ampere
    git remote add origin git@example.com:ampere.git
    git push origin master

## Option 2: Import git repository into a new subversion repository

With a little help from [Kerry Buckley's Guide](http://www.kerrybuckley.org/2009/10/06/maintaining-a-read-only-svn-mirror-of-a-git-repository/) I did the following:

    mkdir /home/git/svn
    cd /home/git/svn
    git clone /home/git/repositories/ampere.git
    cd ampere/
    vim .git/config

Add the following content to that file:

    [svn-remote "svn"]
        url = https://example.com/svn/ampere/trunk/
        fetch = :refs/remotes/git-svn

Then merge the master into the new branch:

    git svn fetch svn
    git checkout -b svn git-svn
    git merge master
    git svn dcommit

Then rebase that branch to the master, and you can dcommit from the master to svn

    git checkout master
    git rebase svn
    git branch -d svn
    git svn dcommit

# Make Subversion read-only

Made a pre-commit hook that would prevent updating the trunk:

    cd /var/svn/ampere/hooks
    vim pre-commit

Created the file with these contents

    #!/bin/sh

    REPOS="$1"
    TXN="$2"

    SVNLOOK=/usr/bin/svnlook

    # Allow the git user
    $SVNLOOK author -t "$TXN" "$REPOS" | /bin/grep "git" && exit 0

    # Committing to trunk is not allowed
    $SVNLOOK changed -t "$TXN" "$REPOS" | /bin/grep "^U\W.*ampere\/trunk\/" && /bin/echo "Error: ampere/trunk is read-only" 1>&2 && exit 1

    # All checks passed, so allow the commit.
    exit 0

Then made that file executable:

    chmod +x pre-commit

# Merging into the mirror

In the repository you want to mirror, set the following to force all the merges to be the files from the origin server.

I do this with a copy-merge strategy, this is done with a [custom merge driver](http://stackoverflow.com/questions/1910444/git-merge-s-theirs-needed-but-i-know-it-doesnt-exist/1911370#1911370). Since this is done on the work repository I just set it globally.

    cd /home/git/svn/ampere
    git config merge.copy-merge.name   'Copy Merge'
    git config merge.copy-merge.driver 'mv %B %A'
    git config merge.default copy-merge

# Add a cron job

I figured checking for changes once an hour would be plenty:

    30 * * * * /usr/bin/ruby /home/git/svn/mirror.rb ampere >>/home/git/log/mirror-ampere.log 2>&1

# Update: The missing mirror.rb file

Not sure how I forgot this, nor do I have an excuse why it took me so long to add it here.

`mirror.rb`
    #!/usr/bin/env ruby
    require 'date'
    require "time"

    def usage
      puts "mirrortosvn <repo-name>"
    end

    def git(cmd)
      system("/usr/bin/git #{cmd}")
    end

    def start_sync_log(name)
      str = "#{DateTime.now.to_s} Sync #{name}\n"
      str += "=" * (str.length-1)
    end

    name = ARGV[0]
    usage if name == nil

    puts
    puts start_sync_log name
    Dir.chdir "/home/git/svn/#{name}"
    git "pull origin master"
    git "svn dcommit"
