---
layout: post
title: Getting Started with Jekyll
---

Install jekyll

    $ sudo gem install mojombo-jekyll -s http://gems.github.com/ -s http://gems.rubyforge.org/

Setup a site

    $ mkdir site
    $ cd site

Make the base layout

    $ mkdir _layouts

Create a file called base.html in site/\_layouts:

    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <title>{ {; page.title }}</title>
        </head>
        <body>
            <div class="container">  
                { { content }}
            </div>
        </body>
    </html>

Make an about page:

    mkdir about

Create a file called index.html in site/about:

    ---
    layout: base
    ---
    <h1>Getting started with Jekyll</h1>

    <p>I am not afraid of the command line</p>

Now you should be able to run jekyll from your site directory

    jekyll

If that works, try running the built in server and take a look

    jekyll --server

And browse to [http://localhost:4000/about](http://localhost:4000/about)

Add some style
--------------

Well that's not very pretty, but shows that it works. Lets add some style. I like to use [Blueprint CSS](http://blueprintcss.org/), so I will add that. Feel free to use your own stylesheets, but this will give you a good starting point. You can download them from their website, or use the following wget's to just get up and running quick:

    mkdir stylesheets
    cd stylesheets
    wget http://blueprintcss.org/blueprint/screen.css
    wget http://blueprintcss.org/blueprint/print.css
    wget http://blueprintcss.org/blueprint/ie.css 
    cd ..


Add some syntax highlighting
----------------------------

    sudo port install py-pygments
    cd stylesheets
    wget http://tom.preston-werner.com/css/syntax.css


Add a feed
----------

In the root of your site folder, create an 'atom.xml' file with the following:

<pre>
---
layout: nil
---
&#60;?xml version="1.0" encoding="utf-8"?>
&#60;feed xmlns="http://www.w3.org/2005/Atom">

  &#60;title>Codeography&#60;/title>
  &#60;link href="http://codeography.com/atom.xml" rel="self"/>
  &#60;link href="http://codeography.com/"/>
  &#60;updated>&#123;&#123;site.time | date_to_xmlschema }}&#60;/updated>
  &#60;id>http://codeography.com/&#60;/id>
  &#60;author>
    &#60;name>Christopher Sexton&#60;/name>
    &#60;email>&#60;/email>
  &#60;/author>
  &#123;% for post in site.posts %}
  &#60;entry>
    &#60;title>&#123;&#123; post.title }}&#60;/title>
    &#60;link href="http://codeography.com{{ post.url }}"/>
    &#60;updated>&#123;&#123;post.date | date_to_xmlschema }}&#60;/updated>
    &#60;id>http://codeography.com&#123;&#123; post.id }}&#60;/id>
    &#60;content type="html">{&#123; post.content | xml_escape }}&#60;/content>
  &#60;/entry>
  &#123;% endfor %}
&#60;/feed>
</pre>

