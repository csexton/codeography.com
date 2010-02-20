---
layout: post
title: Convert ugly HTML links to pretty Markdown links
---

Recently I have been converting a large number of old blog posts to [markdown](http://daringfireball.net/projects/markdown/), and have been writing a bunch of little one off scripts to handle this. One of the things I needed to do was convert a bunch of oddly formatted HTML links to their shiny clean markdown equivalent. 


    #!/usr/bin/env ruby
    # Convert HTML links to Markdown links
    ARGF.each do |line|
        puts line.gsub /<a [^h]*href=["']([^"']*)["'][^>]*>([^<]*)<\/a>/, "[\\2](\\1)"
    end

My script follows the standard unix convention, and reads from standard in or a file, and outputs to standard out. To use it you could do something like:

    ruby html_links_to_markdown.rb <file.html> > file.markdown

I should note, there are a few minor caveats. It will not:

 * replace multi line links
 * replace links with nested tags. e.g. images `<a href="#"><imr src="fail.png" /></a>`
 * match any links that have an attribute that starts with 'h' before href. I don't think this is a very high use case.  e.g.: `<a height="4" href="#">fail</a>`

Those cases should just result in the original *ugly* links remaining in the document, which can be manually fixed. I thought it was helpful, and handled many of the badly formatted &gt;a&lt; tags that haunted my old posts.

