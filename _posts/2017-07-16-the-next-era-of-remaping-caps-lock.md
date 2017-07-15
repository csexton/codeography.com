---
layout: post
title: The Next Era of Remaping Caps Lock
---

I had previously [written](/2010/12/02/remap-capslock-to-control-on-a-mac.html) about [remaping](/2013/06/26/remapping-caps-lock-was-only-the-beginning.html) parts of the keyboard, but most of those techniques had stopped working as Apple continued to evolve the Mac.

The latest generation of Apple products was threatening my precious keyboard control. The TouchBar on make `esc` an awkward virtual key, and macOS Sierra broke Karabiner. It was a little rough there for a while. Shortly after Sierra was released Takayama Fumihiko created the [Karabiner-Elements](https://github.com/tekezo/Karabiner-Elements) project, but it lacked much of the functionality of the original. Necessary step back to move forward, but no fun.

But that is all a thing of the past, the new era has arrived. Karabiner-Elements now supports complex rules.

### Magic Mapping #1: Caps Lock

The most important complex rule for me, especially for any Mac with a TouchBar, is the dual function `caps_lock` key.

1. Act like `control` when pressed with any other key. So if you use it in a chord it will just be control, e.g. `control-c` but with the Caps lock key.
1. Act like `esc` if you press and release the key. So if you just tap the key it will send `esc`.

### Magic Mapping #2: Vim Arrows

The other mapping that I love having is `control+h/j/k/l` to be the arrow keys. This way I have vim-like navigation in every app. Some apps on Mac already map `control-j/k` to `up/down`, but if you remap it to the arrows it will just work like you expect everywhere.

### How to set up these custom mappings

Karabiner-Elements has a fantastic way to import custom rules. If you have the app installed just click the following link and it will open automatically.

[Add Rules to Karabiner](karabiner://karabiner/assets/complex_modifications/import?url=https%3A%2F%2Fraw.githubusercontent.com%2Fcsexton%2Fcsexton.github.com%2Fmaster%2Fkarabiner%2Frules.json)

You will see a confirmation asking you to open it in the app:

![Confirmation Dialog](/images/karabiner-1.png)

It will confirm the rules you are importing:

![Import Dialog](/images/karabiner-2.png)

Then give you the option to add the ones you want.

![Karabiner Complex Rules](/images/karabiner-3.png)

Let me know if this is helpful, or if you have slightly different configurations you prefer.


