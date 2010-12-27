---
layout: post
title: "Conditionally Colorful Test Unit"
published: true
---

I like to use the redgreen gem to make my tests colorful, but hardly want to make this a hard requirement to work with the project, so I tend to add this one-liner to the top of test\_helper.rb -- now I get red and green output but the other guys on the team don't have to deal with installing the gem.

    begin; require 'redgreen'; rescue Exception=>e;end
    
