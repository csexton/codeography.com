---
layout: post
title: "Project specific git author, without the gas pains"
published: true
---

I heard about a git-related project called GAS, the [Git Author Switcher](https://github.com/walle/gas), on that [Ruby5](http://ruby5.envylabs.com/) podcast--and initially I was intrigued. But once I thought about it, I think there is a better way to handle this. With just plain ole git.

Why don't I like having GAS? Well, it changes the author globally -- and you have to remember to switch it up when changing projects. I would prefer to set it on a per project basis, then forget about it.

So my setup is to put my personal user and email (i.e. the one I use on github) in the global config, which most anyone using git should have setup already:

    git config --global user.name "Chris"
    git config --global user.email "chris@personal.dev"

Then in my work projects, I use a different email address, so I change it in that repo by running:

    git config user.email "chris@work.dev"

Luckily, I don't use a different name at work, so there is no need to override that setting. Although I could if I really wanted to.

If you have to to this frequently, I think a simple git alias is pretty nice for streamlining this:

    git config --global alias.workprofile 'config user.email "chris@work.dev"'

Then when you clone a new work project, just run `git workprofile` and it will be configured to use that email.

Admittedly, if you are using a shared machine or are pairing (or pairing on a shared machine), then GAS might be exactly what you need. Just use the right tool for the job.
