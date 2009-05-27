---
layout: post
title: "Speedy Bash Prompt: Git and Subversion Integration"
---

I had tried using a [number](http://www.entropy.ch/blog/Developer/2009/03/30/Git-and-SVN-Status-in-the-Bash-Prompt.html) of [other](http://ciaranm.wordpress.com/2008/07/16/git-and-subversion-information-in-the-bash-prompt/) bash scripts to display git and svn info in the prompt, but things had become pretty sluggish. Sure things would cache after the first time I cd'd into the directory, but often I was stuck waiting while that first try happened.  I couldn't take it any more.  I wanted some info still in the prompt, but I didn't need that much, so I trimmed things down.  


    scm_ps1() {
        local s=
        if [[ -d ".svn" ]] ; then
            s=\(svn:$(svn info | sed -n -e '/^Revision: \([0-9]*\).*$/s//\1/p' )\)
        else
            s=$(__git_ps1 "(git:%s)")
        fi
        echo -n "$s"
    }
    export PS1="\[\033[00;32m\]\u\[\033[00;32m\]@\[\033[00;32m\]\h:\[\033[01;34m\]\w \[\033[31m\]\$(scm_ps1)\[\033[00m\]$\[\033[00m\] "

This requires you have the git bash compleation script installed for the `__git_ps1` command.  Which I have on OS X from MacPorts (if you used the +bash\_compleation option) and from Apt on Ubuntu.

You will need to source these in your .bash\_login.

For all the bashy compleations:

    if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
    fi

Just for git:

    if [ -f /opt/local/etc/bash_completion.d/git ]; then
    . /opt/local/etc/bash_completion.d/git
    fi

If interested check out the home/bash\_login script in my [dotfiles project](http://github.com/csexton/dotfiles/tree/).
