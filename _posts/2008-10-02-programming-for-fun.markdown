---
title: Programming for fun?
tags: tech
layout: post
---
I've been working on the cookbook application for the wife and couple interesting things.

I use Dreamhost, and while they rock in alot of ways they won't let me have any long running processes.  I wanted to add full text search to my cookbook (because if you can't find the recipe you want, what good is a cookbook) and I couldn't use the likes of Sphinx or Ferret.  But if I changed my DB to MySQL (which dreamhost does provide) I can use the built in fulltext search.  It is a little hackish, and MySQL specific but it works and is plenty fast for my needs.

I had to do two things:

1) Add a FULLTEXT index to my migration

      def self.up
        ...
        execute 'ALTER TABLE recipes ENGINE = MyISAM'
        execute 'CREATE FULLTEXT INDEX ft_idx_recipes ON recipes(title,ingredients,directions)'
      end
    
      def self.down
        execute 'ALTER TABLE recipes DROP INDEX ft_idx_recipes'
        execute 'ALTER TABLE recipes ENGINE = InnoDB'
        drop_table :recipes
      end


2) In my recipes controller in the search action I have the following line

     @recipes = Recipe.find_by_sql("SELECT \* FROM recipes WHERE MATCH (title, ingredients, directions) AGAINST ('#{query.gsub(/'/, "''")}');")

The gsub bit is to sanitize the sql. Pretty simple really, and if I ever want to replace it all I need to do is modify the controller.

I found out today that the Bort guys added OpenID support to the project. Which would normally involve some obscure svn/patch hijinks to deal with, but thanks to git I can just grab their changes (I did fork <a href="http://github.com/csexton/cookbook/tree/master">my project</a> from theirs to start with).

     git branch openid # incase I screw things up
     git checkout openid # use the new branch
     git pull git://github.com/fudgestudios/bort.git master
     # Fix any conflicts and merge back to master

Finally, did everyone know you can put alias in the .gitconfig file?  Well, you never told me.

     [alias]
       co = checkout
       ci = commit
       st = status
