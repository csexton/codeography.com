---
layout: post
title: Use pow to serve your static html
---

I love [Pow](http://pow.cx/), and use it with Rails and Sinatra all the time. However I also maintain a few sites that are just plain old HTML files. Or generate plan old HTML files like Jekyll and Middleman.

I thought it would be nice to do local development on these using Pow, since it is on my machine already.

Turns out it is really easy.

1. In `.pow` make a directory with the project name
1. Create a symlink called `public` to the static content

Say I wanted to view this site locally at `http://codeography.dev/` this is what I would do:

```
cd ~/.pow
mkdir codeography
ln -s ~/src/codeography/_site codeography/public
```

And now Pow will serve up the site locally for me at `http://codeography.dev`. Awesome.


### Wait, wut?

How does this work?

Pow will serve static content from the public directory under your project. Normally you link to the top level directory and it happens to have a `public` folder contained -- per the Rails convention. Well, I just tricked pow.

See, pow just looks in `~/.pow` for projects it can serve. It know to follow symlinks.

Instead of this:

```
~/.pow/(myproj --> ~/src/myproj)/public/index.html`
```

I just put make a folder and stick a public symlink:

```
~/.pow/myproj/(public --> ~/src/myproj)/index.html`
```

Pretty handy little trick. And this way don't have to remember which port Jekyll or Middleman uses.

You should remember this won't re-generate your site if you are using tools like Jekyll and Middleman, you still have to run that manually.
