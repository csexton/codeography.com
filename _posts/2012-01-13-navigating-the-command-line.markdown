---
layout: post
title: Navigating the Command Line
tags: tech
---

When learning to love the command line, nothing made a bigger difference to me than when I discovered I could edit commands with out pressing and holding the arrow keys. That was just slow and awkward. There is a better way. Really you only need two or three little tricks and you will be in a whole new world of productivity.

If you can only learn one thing, learn these two keyboard shortcuts:


<style>
  .key-image { margin-top: 10px; height: 60px; }
  table.keys { vertical-align:top; }
  table.keys h2 { margin-bottom: 0; }
  table.keys, td, th { vertical-align: top; }
  table.keys td.col1 { width:141px; }
</style>
<table class="keys">
  <tr>
    <td class="col1"><img src="/images/c-a.png" align="left" class="key-image" /></td>
    <td class="col2">
      <h2>Jump to the beginning</h2>
      Pressing <code>control-a</code> will jump the cursor to the beginning of the line.
      <br>
      Mnemonic: Control-<em>Awesome</em> I can move back to the beginning with out holding the arrow key.
      <br>
      Also I find I remember this because the A key is the furthest left key on the home row.
    </td>
  </tr>


  <tr>
    <td class="col1"><img src="/images/c-e.png" align="left" class="key-image" /></td>
    <td class="col2">
      <h2>Jump to the end</h2>
      Pressing <code>control-e</code> will jump the cursor to the end of the line.
      <br>
      Mnemonic: Control-<em>End</em>
    </td>
  </tr>

</table>

Now, take a few minutes to go give those a try. I'll wait.

Want some more? Rad. But a little caution if you are just learning these things: just pick a couple and find ways to use them until they are second nature. Practice. If you think you are ready for more, here you go. I think these are the next most useful:

<table class="keys">
  <tr>
    <td class="col1"><img src="/images/c-w.png" align="left" class="key-image" /></td>
    <td class="col2">
      <h2>Delete Back a Word</h2>
      Pressing <code>control-w</code> will delete the word before the cursor.
      <br>
      Mnemonic: Control-<em>W</em>hy did I type that <em>Word</em>
    </td>
  </tr>


  <tr>
    <td class="col1"><img src="/images/c-k.png" align="left" class="key-image" /></td>
    <td class="col2">
      <h2>Delete to the End</h2>
      Pressing <code>control-k</code> will delete from the cursor to the end of the line
      <br>
      Mnemonic: Control-<em>Kill</em> to the end of the line
    </td>
  </tr>


  <tr>
    <td><img src="/images/c-u.png" align="left" class="key-image" /></td>
    <td>
      <h2>Delete to the Beginning</h2>
      Pressing <code>control-u</code> will delete from the cursor to the end of the line
      <br>
      Mnemonic: Control-<em>Uhh</em> that wasn't right
    </td>
  </tr>

</table>


I think these are the most critical shortcuts to learn, and have made life on the command line damn nice.


## A Bit About Input Modes

Really I should end this post here, but am somehow compelled to mention this thing called input modes.

There are twon input modes that a command line will use: vi or emacs.

The examples above assume you are using emacs mode for your shell. This is the default for bash and most other shells. If you are having problems with them you may need to set the input mode. In bash you can simply run `set -o emacs`

I can hear you asking "But wait, you are a vim guy, why do you use emacs mode for your shell?"

Well, it wasn't an easy choice. I thought I would like vi mode on the command line. And I tried to use it. I wanted to want to. But in the end it was just never felt right.

My reasons:

1. It is the default on most systems. Nice to open a new term on a strange server and have things Just Work™.
1. Anywhere libreadline is used these things will work. Basically this is the line editing library that most terminal based apps will use. This includes your shell, bash, irb, ipython, irc clients and the like.
1. I use a Mac, and there is a decent overlap between the default keyboard shortcuts in Cocoa and emacs mode.
1. On the command line I can quickly edit the command in vim by mashing `Control-X Control-E` or running `fc`.
1. And probably the most critical reason is I have the [exact same keybindings](https://github.com/csexton/viceroy/blob/master/plugin/mappings.vim#L14) in Vim's insert and command modes.

## Ignore Advice from Blog Articles
The only thing you should do is pick some tools and learn them. Don't worry about what some random blog article says. Don't worry about those kids on irc demanding you use zsh. Don't worry about editors -- learn something. It will all translate in some way, won't be wasted effort. Most important thing you can do as a developer is train how to use your tools.

## What do you use?

What command line tricks do you use to make your day happier?

