---
layout: post
title: Detecting native ruby gems with the wrong archetecture
---

Having recently upgraded to Snow Leopard I have found myself going between my ruby projects and running the tests only to find that the gems I have installed are not 64 bit binaries. Since I am running the ruby that shipped with 10.6 I am running as 64 bit and I would get some nasty wrong archetecture errors. Well I wanted to find a way to go figure out all the gems that did not have `x86_64` binary libraries. 

Here is the ruby script I came up with:

	Gem::all_load_paths.each do |p| 
	  Dir["#{p}/../ext/*.bundle"].each do |f|
	    s = `file #{f}`
	    if (!s.include? "for architecture x86_64")
	      puts s
	    end
	  end
	end

Nice thing about this is it uses `all_load_paths` to find where the gems are located, so if you have them installed im multiple places (like `/Library/Ruby/Gems/` and `~/.gems`) it should find them.

Now if you find gems that are not supported it is normally pretty easy to fix. Here is what I did to fix nokogiri:

	# Copy the gem to temp
	cp -r /Library/Ruby/Gems/1.8/gems/nokogiri-1.3.1/ /tmp/nokogiri
	cd /tmp/ext/nokogiri
	# Add our archetecture 
	sed "s/i386/i386 \-arch x86_64/" Makefile > Makefile
	make clean
	make 
	# Replace the old binary
	sudo cp nokogiri.bundle /Library/Ruby/Gems/1.8/gems/nokogiri-1.3.1/lib/nokogiri/nokogiri.bundle

