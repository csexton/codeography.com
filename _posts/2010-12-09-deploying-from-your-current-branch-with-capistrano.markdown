---
layout: post
title: "Deploying from your current branch with Capistrano"
published: true
---

In some of the Rails projets I have worked on, I have found my self having to juggle multiple enviroments and often want to shuffle around which branch is deployed to which envrioment. I use CApistrano Multistage to handle all the diffrent envrioments, but didn't want to have to edit the deploy ocnfiguration every time I wanted to deploy. So I came up with a way to deploy from whatever my current local branch. Assuming this branch is on the remote git server, capistrano would deploy from there. 

In your `config/deploy.rb` file, add 

    # Bonus! Colors are pretty!
    def red(str)
      "\e[31m#{str}\e[0m"
    end

    # Figure out the name of the current local branch
    def current_git_branch
      branch = `git symbolic-ref HEAD 2> /dev/null`.strip.gsub(/^refs\/heads\//, '')
      puts "Deploying branch #{red branch}"
      branch
    end

    # Set the deploy branch to the current branch
    set :branch, current_git_branch


The really cool thing about this ishow intuitive it is to use. Goes something like this:

PM: Hey, can you deploy feature-x to staging! NOW!
Me: K, `git checkout feature-x && cap deploy staging`

That just feelis natural.

On other alternertive was to setup a remote branch in git that matches each enviroment, and go a `git reset --hard` when you want to change things around. But with as often as we were redeploying that seemed burdensome. 
