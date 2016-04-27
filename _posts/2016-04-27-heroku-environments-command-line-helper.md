---
layout: post
title: Heroku CLI Environments Wrapper
---

I was pretty annoyed at this message:

```
% heroku logs
 ▸    Error: Multiple apps in git remotes
 ▸    Usage: heroku logs --remote production
 ▸       or: heroku logs --app my-app-production
 ▸
 ▸    Your local git repository has more than 1 app referenced in git remotes.
 ▸    Because of this, we can't determine which app you want to run this command against.
 ▸    Specify the app you want with --app or --remote.
 ▸
 ▸    Heroku remotes in repo:
 ▸    production      (my-app-production)
 ▸    staging         (my-app-staging)
 ▸
 ▸    https://devcenter.heroku.com/articles/multiple-environments
```

I'd found the `--app` flag to the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-command) to be a bit cumbersome. In particular using the command history in the terminal to be pretty awkward, plus it made it easier to mix up environment names.

Nearly all of my dozen or so apps hosted on heroku have multiple environments. So I am probably dealing with this more than most folks would. But like a good yak-shaver, any chance I get to automate away an annoyance I go for it.


What I wanted was a command that matched my environment name. Instead of:

```
heroku logs --app my-app-production
```

I would use:

```
production logs
```

The my solution was a little wrapper script that would look at the git config to find the git remote name, and use that to grab the app name from the git URL and re-write my command to use that as the `--app` parameter.

The way this script works is:

1. Inspect the name of the command run, in the above example that would be "production"
1. Look in the git config for a remote named "production"
1. Grab the git URL for that remote and take the repo name
1. Run the `heroku` command with that repo name as the name

Since I have multiple environment names like "production" and "staging" I install this script and make symlinks to it with those matching names. You could also duplicate it or make copies. So to install it, just copy it locally and symlink it to the appropriate names:

```
cd /path/to/bin
curl -O https://raw.githubusercontent.com/csexton/dotfiles/master/bin/heroku-environments
ln -s heroku-enviroments staging
ln -s heroku-enviroments production
```

An just add symlinks for any environment names you might want.

Hope someone else finds this useful. I've quickly become addicted to using it.

You can find the lastest and greatest version of [the `heroku-environments` script in my dotfiles](https://github.com/csexton/dotfiles/blob/master/bin/heroku-environments), and the version at the time of this writing is availabe in [this gist](https://gist.github.com/csexton/a59e3c6b45ecd181c4ad3e7d21463258)
