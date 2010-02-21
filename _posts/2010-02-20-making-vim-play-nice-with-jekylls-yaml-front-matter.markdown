---
layout: post
title: Making Vim play nice with Jekyll's YAML Front Matter
---

![vim-jekyll-yaml-ugly](/media/vim-jekyll-yaml-ugly.png)

This just looks bad.

I had a little Vim script adventure tonight. I wanted to make the highlighting of the yaml front matter work as it should for Jekyll.

First thing I got hung up on was figuring out how to match multiline regex's. Which is when I found out about the `\_` escape that Vim has, which adds an end of line to the character class it is adjacent to. Now could use the following search to select the yaml:

    /^---\_.{-}---$/

Which would also find other `---` markers in the document, which was no good.

More vimdocs and I finally came across `\%^` which conveniently matches start-of-file. Progress!

Once I plug that in, and go look at a few of the built Vim syntax scripts, I discover that I can put them in one handy `syntax match` command:

    syntax match Comment /\%^---\_.\{-}---$/

I discover I can do the same thing with `syntax region`:

    syntax region Comment start=/\%^---$/ end=/^---$/

And even enable spell checking of my title by tacking on the contains param:

    syntax match Comment /\%^---\_.\{-}---$/ contains=@Spell

But now that I figured out how to highlight the text that I care about, I need to figure out which file types use that syntax.

Just apply it to all the markdown files:

    autocmd BufNewFile,BufRead *.markdown syntax match Comment /\%^---\_.\{-}---$/

My first take, and it didn't seem like the best solution. Plus if the markdown file is not in a jekyll blog I don't want it to highlight the `---`'s (since it is probably not yaml)

I try to get tricky, look at the path and if it looks like a jekyll blog I invoke it, and try include the textile file type.

    autocmd BufNewFile,BufRead */_posts/*.textile,*/_posts/*.markdown syntax match Comment /\%^---\_.\{-}---$/

Damn, Jekyll allows you to put yaml at the top of any templates, layouts or any other text file you have -- and I want those files to work.

Then it dawned on me, I have the jekyll_path defined in my plugin, I just need a way to use that variable in the file pattern. Seems like the only way to do that is construct the command in a string and exec the bad boy. Which lead me to my final solution:

    execute "autocmd BufNewFile,BufRead " . g:jekyll_path . "/* syn match jekyllYamlFrontmatter /\\%^---\\_.\\{-}---$/ contains=@Spell"

![vim-jekyll-yaml-pretty](/media/vim-jekyll-yaml-pretty.png)

Much Better.
