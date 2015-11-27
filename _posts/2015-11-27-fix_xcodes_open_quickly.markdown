---
title: Fix Xcode's Open Quickly Navigation
layout: post
date: 2015-11-27
---

Open quickly is one of the best features in Xcode. It saves you haveing to move your hand to the mouse and select a different file. But there is no way to navigate through the selection unless you use the arrow keys. The arrow keys that are so, so far from the home row. It baffels me that `Control-N` and `Control-P`, which are normal Cocoa controls for next and previous (try this in Safari for example).

I knew [Karabiner](https://pqrs.org/osx/karabiner/index.html.en) should be able to fix this. It took a little tinkering, but I got it. It is so nice. Also added `Control-J` and `Control-K` to appease my vim habbits.

Add the following XML to `~/Library/Application\ Support/Karabiner/private.xml`, then search for "Xcode" and enable them in Karabiner:

![karabiner](/images/karabiner-xcode.png)

```xml
<?xml version="1.0"?>
<root>

<appdef>
  <appname>XCODE</appname>
  <equal>com.apple.dt.Xcode</equal>
</appdef>

<item>
  <name>Remap Control+N to Down in Xcode</name>
  <appendix>Active in Xcode</appendix>
  <identifier>private.xcodeNDown</identifier>
  <only>XCODE</only>

  <autogen>
    __KeyToKey__
    KeyCode::N, MODIFIERFLAG_EITHER_LEFT_OR_RIGHT_CONTROL,
    KeyCode::CURSOR_DOWN
  </autogen>
</item>

<item>
  <name>Remap Control+P to Up in Xcode</name>
  <appendix>Active in Xcode</appendix>
  <identifier>private.xcodePUp</identifier>
  <only>XCODE</only>

  <autogen>
    __KeyToKey__
    KeyCode::P, MODIFIERFLAG_EITHER_LEFT_OR_RIGHT_CONTROL,
    KeyCode::CURSOR_UP
  </autogen>
</item>

<item>
  <name>Remap Control+J to Down in Xcode</name>
  <appendix>Active in Xcode</appendix>
  <identifier>private.xcodeJDown</identifier>
  <only>XCODE</only>

  <autogen>
    __KeyToKey__
    KeyCode::J, MODIFIERFLAG_EITHER_LEFT_OR_RIGHT_CONTROL,
    KeyCode::CURSOR_DOWN
  </autogen>
</item>

<item>
  <name>Remap Control+K to Up in Xcode</name>
  <appendix>Active in Xcode</appendix>
  <identifier>private.xcodeKUp</identifier>
  <only>XCODE</only>

  <autogen>
    __KeyToKey__
    KeyCode::K, MODIFIERFLAG_EITHER_LEFT_OR_RIGHT_CONTROL,
    KeyCode::CURSOR_UP
  </autogen>
</item>
</root>
```

You can find all my Karabiner settings in my [dotfiles repo](https://github.com/csexton/dotfiles/tree/master/karabiner) on GitHub.
