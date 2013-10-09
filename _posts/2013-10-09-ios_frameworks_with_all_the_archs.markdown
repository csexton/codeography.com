---
title: iOS Frameworks with both 64 bit and 32 bit ARCHs
layout: post
date: 2013-10-09 12:12
---

I recently had to package up a static library for iOS as a framework bundle. This is something I had been doing for years for Mac application, but turned into a week long yak shave to get things working properly for iOS.


Originally I followed [Jeff Verkoeyen's iOS Framework](https://github.com/jverkoey/iOS-Framework) guide, however with the new 64 bit archetecutres that Apple introduced with the new iPhone this broke down.

The reason this broke down is because Xcode has a bit of magic when it comes to building the simulator target -- it does some juju around the `ARCH`s it wants to build. And provides no way to edit that in the build settings gui that xcode has. Luckily I batteled this back when OS X learned how to speak with 64 bits, but there was some added complicaitons. Eventually I abandoned Jeff's bash scripts in favor of ruby, due to the complexity of the entire thing.

To remember how this all works, and document it for my personal use in the future I put the scripts in a github repo, [iOS Framework Buidler](https://github.com/csexton/ios-framework-builder/). With the scripts in git I hope the community could help keep the scripts in tip top shape. They work great for me, but I am sure they could be more flexible and versitle.

If you need to build an iOS Framework Bundle, check out the [How To Guide](https://github.com/csexton/ios-framework-builder/blob/master/HOWTO.md).

Many thanks to Jeff Verkoeyen and the other folks to helped blaze the path to getting frameworks figured out.

