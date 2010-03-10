---
layout: post
title: "RVM info in your prompt"
published: true
---

Having jumped on the [RVM](http://rvm.beginrescueend.com/) bandwagon, I noticed I was constantly typing `rvm info` to see what I was using in any particular instance of the terminal. Which is when I decided I would like to add that info to my prompt -- and since I use zsh the RPROMPT seemed like a great place to put this.

![RPROMPT with RVM info](/media/rvm-zsh-rprompt.png)

I wrote a little function to gather the current ruby version, and it will only show the prompt when RVM is installed and you are using a RVM installed ruby. I still have the system instaled ruby as the default, and didn't want this information to show up when I was using that.

    function rvm_ruby_prompt {
      if (declare -f rvm > /dev/null) {
          if [[ -x $MY_RUBY_HOME ]]
          then ruby -v | sed 's/\([^(]*\).*/\1/'
          fi
      }
    }
    # Rubies are red, and my rprompt is too
    RPROMPT='%{$fg[red]%}$(rvm_ruby_prompt)%{$reset_color%}%'

Fun fact: "RPROMPT" stands for Ruby Prompt.

