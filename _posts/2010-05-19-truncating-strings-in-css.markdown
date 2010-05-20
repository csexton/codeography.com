---
layout: post
title: "Truncating strings in css"
published: true
---

Filed under "Stupid CSS Tricks"

I had no idea you could insert an ellipises into html with css, and combined with overflow and white-space directives you can very politely clip a string.

    row_title {
      text-overflow: ellipsis;
      overflow: hidden;
      white-space: nowrap;
    }

So instead of this:

<div style="margin: 1em;width:30em; border:thin dotted red; overflow: hidden; white-space: nowrap;">
I saw the best minds of my generation Destroyed by madness, starving, hysterical
</div>

Or this:

<div style="margin: 1em;width:30em; border:thin dotted red; white-space: nowrap;">
I saw the best minds of my generation Destroyed by madness, starving, hysterical
</div>

You get this sexxy beast:

<div style="margin: 1em;width:30em; border:thin dotted red; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
I saw the best minds of my generation Destroyed by madness, starving, hysterical
</div>



