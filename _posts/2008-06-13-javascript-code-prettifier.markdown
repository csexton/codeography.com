---
title: Javascript Code Prettifier
tags: tech
layout: post
---
I really liked the idea of the <a href="http://google-code-prettify.googlecode.com/svn/trunk/README.html">Javascript Code Prettifier</a>, and I really like my <a href="http://www.fuzzymonk.com/svn/settings/vim/vimfiles/colors/ristoink.vim">personal color scheme</a>, so I wanted to combine them.  I thought it was turned out pretty neat, espcially since it only took about 20 min of tinkering to get everything sorted out, so I wanted to contribute back to the author -- but he provides no simple way to do that, so I will tell you about it. You who are prolly only coming here for the pics of Leah (see previous post).

Here is my color scheme for JS Prettifier:

    .str { color: #66FF00; }
    .kwd { color: #AAAAAA; }
    .com { color: #AA66FF; }
    .typ { color: #DDE93D; }
    .lit { color: #339999; }
    .pun { color: #AAAAAA; }
    .pln { color: #FFFFFF; }
    .tag { color: #AAFFFF; }
    .atn { color: #FF6600; }
    .atv { color: #66FF00; }
    .dec { color: #FF6600; }
    pre.prettyprint { padding: 2px; border: 1px solid #888; background-color: #000000;}

The only other change is, I wanted the tags surrounding the code to be &lt;pre class="code"&gt; instead of &lt;pre class="prettyprint"&gt;, because I just type raw html and that would be shorter and easier to remember (at least for me).

You can see those files directly:

 * <a href="http://www.fuzzymonk.com/styles/prettify.css">prettify.css</a>
 * <a href="http://www.fuzzymonk.com/js/prettify.js">prettify.js</a>

Check out some fun ruby code (and it's whitespace independence):

    hash = { :water => 'wet', :fire => 'hot' }
    puts hash[:fire] # Prints:  hot
    hash.each_pair do |key, value| # Or:  hash.each do |key, value|
           puts "#{key} is #{value}"
    end
    # Prints:  water is wet
    #          fire is hot
    hash.delete :water # Deletes :water => 'wet'
    hash.delete_if {|k,value| value=='hot'} # Deletes :fire => 'hot'
