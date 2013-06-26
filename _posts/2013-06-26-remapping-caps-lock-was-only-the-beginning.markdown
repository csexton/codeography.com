---
layout: post
title: Remapping Caps Lock was only the Beginning
---

It seems that remapping caps lock has finally caught on. The only valid(ish) argument I see happening is which key to remap it to. I have been firmly in the camp that it should be remapped to `control` however, there seems to be a strong contengent of people who inisit it should be `esc`. Aside from them being wrong, it occurs to me that reaching up for `esc` was a bit of a stretch. So why not both.

I want `caps lock` to be control when pressed with another key, and `esc` when pressed alone.

Well linux folks got [xcape](https://github.com/alols/xcape), and us mac fans have [keyremap4macbook](https://pqrs.org/macosx/keyremap4macbook/). It just was a little round about to make `caps lock` be dual function (neither of which was the original function)

First, configure `caps lock` to be control with [System Preferences -> Keyboard -> Modifier Keys...](/2010/12/02/remap-capslock-to-control-on-a-mac.html)

Now that it done, go grab a copy of keyremap4macbook, install it and run it.

When it first launches you will see a list of a bajillion options.

![keyremap4macbook](/images/capslock-02.png)

You can either scroll down looking for "Control\_L" or just search for "Control\_L escape"

![keyremap4macbook](/images/capslock-03.png)

Now you can check the box that reads "Control\_L to Control\_L (+ When you type Control\_L only, send Escape)"

You should be set. Now you just have to retrain you hands to stop reaching for `esc` all the time.

### Bonus:

I also like to change the right `command` key to act at `enter` when pressed alone. I think it is a little bit easier on my hands to mash that with my thumb in leu of the pinky reaching over to the normal `enter` key.

![keyremap4macbook](/images/capslock-04.png)

keyremap4macbook does a ton of other very cool tricks, explore and see what works for you. If you find something cool [let me know](http://twitter.com/crsexton).

