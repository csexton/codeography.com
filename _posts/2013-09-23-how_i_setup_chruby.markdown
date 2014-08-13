---
title: How I setup chruby
layout: post
date: 2013-09-23
---

**Update 8/13/2014: I updated the paths and the .zshenv script for latest version in homebrew**

After having another battle with pow and rvm I thought I would give [chruby](https://github.com/postmodern/chruby) a go. So my little experiment went something like this:

```bash
brew install chruby
brew install ruby-install
ruby-install ruby 1.9.3
ruby-install ruby 2.0
```

Then I load chruby in my `.zshenv` file.


```bash
if [[ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]]; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh
  source /usr/local/opt/chruby/share/chruby/auto.sh
else
  echo "Ain't got no chruby"
fi

```

Fun Fact: We want to use the `.zshenv` and not the `.zshrc`. This is because `.zshrc` is for interactive shell configuration, whereas `.zshenv` is always sourced.

This should have you up and running now, but I have added two other steps to my normal process.

### Bundler

First of all, for bundler I now use the `--path` option when I am first installing the gems for a project.

```bash
bundle install --path ./vendor/bundle
```

You only have to use that option once per project then bundler will remember where you put things (check out `.bundle/config` for details). But this is essentially the same thing I used RVM's awesome gemsets for in the past.

### Pow

I use the hell out of the zero-conf web server [pow](http://pow.cx/). Now to configure the zero configure webserver I create a `.powenv` file in each of my projects that looks like this:

```
source /usr/local/opt/chruby/share/chruby/chruby.sh
chruby $(cat .ruby-version)
```

According to the pow folks `.powrc` file are for checking into source control, and `.powenv` are for local settings.

----

I am massivly grateful for RVM, and ruby wouldn't be where it is today with out it. I love that project, and may go back to RVM. But for now I am seeing how a few lines of shell script can hold up. My only real complaint is having to use `ruby-install` or `ruby-build` or `curl/tar/make` when we already have homebrew.
