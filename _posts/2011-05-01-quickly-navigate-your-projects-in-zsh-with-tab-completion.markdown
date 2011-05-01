---
layout: post
title: "Quickly navigate your projects in zsh, with tab completion"
published: true
---


I find my self having to frequently jump between projects in the terminal, or opening new tabs in Terminal and needing to navigate to the project I am working on. I know there are some other tricks for doing this, some of the optimized for certain cases (like a new tab in the current directory), but I found this to be the most useful for how I work.

Since I keep all my projects in a directory called `~/src` I created a function called `src` that would get me there quickly, so instead of this:

    $ cd ~/src/my-web-site

I can do this:

    $ src my-seb-site

Well, that's nice and all, but with out tab completion I would never use it. Turns out that is stupid simple to solve with zsh's rad completion system. My final solution looks something like this.


    src(){cd ~/src/$1;}
    compctl -W ~/src -/ src

Just drop that into your `~/.zshrc` file and you should be good to go. Feel free to replace `src` with what ever you name your projects directory (Projects, source, awesome-stuff).


If you have not enabled zsh's completion somewhere else in your configs, you may need to add the following before the compctl call:

    autoload -U compinit
    compinit -i

Of course, if that's the case, I recommend installing [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh) and getting all sorts of goodness.

