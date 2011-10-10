---
layout: post
title: "Making ARC and non-ARC files play nice together"
published: true
---

If you want to exclude a file from being compiled with ARC you can do so by setting a flag on the .m file:

Click the Project -> Build Phases Tab -> Compile Sources Section -> Double Click on the file name

Then add `-fno-objc-arc` to the popup window.

Likewise, if you want to include a file in ARC, you can use the `-fobjc-arc` flag.

<img alt="Xcode Screen Shot" src="/images/arc-compiler-flag.png" style="width: 100%;">

See the [clang docs](http://clang.llvm.org/docs/AutomaticReferenceCounting.html) for more details.

A helpful trick is to use the `__has_feature` language extension to throw errors when this is not set properly.

Enforce a file is ARC:

    #if ! __has_feature(objc_arc)
    #error This file must be compiled with ARC. Either turn on ARC for the project or use -fobjc-arc flag
    #endif

The inverse:

    #if __has_feature(objc_arc)
    #error This file cannot be compiled with ARC. Either turn off ARC for the project or use -fno-objc-arc flag
    #endif

This was adapted from a [post by Greg Parker]( http://lists.apple.com/archives/objc-language/2011/Aug/msg00036.html ) on the  on the Objective-C mailing list. He goes on to point out the following:

You should be careful with the interface to your shared code such that ARC and non-ARC clients can use it freely.
* Conform to Cocoa's memory management conventions even though an all-ARC or no-ARC project would not require it
* Don't use object pointers inside C structs
* Avoid CF types


