---
layout: post
title: Open Xcode Project from the Command line
---

<pre class="prettyprint">
def self.joe()
  # This is for joe
  puts "I am joe"
end
</pre>
When I start to work on a programmign project I am conditioned to open terminal and change to that directory. And when working in xcode I used to run `open MyBigLongProjectName.xcodeproj`, but have to deal with the fact that I normally have other files in that directory that start with MyBigLongProjectName--making tab compleation annoying. The solution to this was to make an xcode alias:

    alias xcode="open *.xcodeproj"

Now I can switch from terminal to xcode and back with out breaking my pace.
