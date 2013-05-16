---
layout: post
title: Fancy tmux keybindings with iTerm
---

I wanted to bind `⌘-{` and `⌘-}` to switch windows in tmux (window:tmux is tab:everything else). Turns out tmux won't let you [bind to ⌘](http://superuser.com/a/259622/70029). I was able to solve this with a little hack in iTerm.

In iTerm preferences, click Profiles in the toolbar, then the Keys tab. You'll see a lieelte `+` button there:

<img src="/images/tmux-keybindings-01.png" style="height:500px;" />

Click in the "Keyboard Shortcut" field, and mash the shortcut you want to use (in my case `command-shift-[`).

Here is the real trick, choose "Send Hex Code" as the action.

<img src="/images/tmux-keybindings-02.png" style="height:500px;" />

Then in the field you want to enter the [ascii code](http://www.columbia.edu/kermit/ascii.html) for what you want to send to tmux. In my case I used:

<table>
  <tr>
    <td>`⌘-{`</td>
    <td>`0x02 0x70`</td>
    <td>`control-b,p`</td>
  </tr>
  <tr>
    <td>`⌘-}`</td>
    <td>`0x02 0x6E`</td>
    <td>`control-b,n`</td>
  </tr>
</table>

The other thing that makes this easier to keep tmux and iterm working nicely is to use the `prefix2` setting in tmux. That lets you keep `control-b` working as a prefix binding, but you can also use a more comfortable binding when you are typing.

    # Set C-f to prefix, but leave C-b in place
    set -g prefix2 C-f
    bind C-f send-prefix
    bind C-f last-window

I think this is a nice little trick that would work for more things than just tmux. Let me know if you find other clever uses for it.
