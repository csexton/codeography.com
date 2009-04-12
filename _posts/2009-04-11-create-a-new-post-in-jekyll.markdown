---
layout: post
title: Create a new post in Jekyll
---

Worst thing about Jekyll is making a blog post by hand, so I wanted a clever way to automate it.  I started with modifying jekyll it self to have a --post option, but that didn't feel like the right place to put things.  I am currently using a rake task that I borrowed from Dr. Nic's [jekyll-generator](http://github.com/drnic/jekyll_generator/tree/master), the extended it a little bit.  The biggest improvement is looking for the EDITOR variable and loading the new post in that editor for quick editing. 

	desc "Creates a new _posts file using TITLE='the title' and today's date. JEKYLL_EXT=markdown by default"
	task :post do
	  ext = ENV['JEKYLL_EXT'] || "markdown"
	  unless title = ENV['TITLE']
		puts "USAGE: rake post TITLE='the post title'"
		exit(1)
	  end
	  post_title = "#{Date.today.to_s(:db)}-#{title.downcase.gsub(/[^\w]+/, '-')}"
	  post_file = File.dirname(__FILE__) + "/_posts/#{post_title}.#{ext}"
	  File.open(post_file, "w") do |f|
		f << <<-EOS.gsub(/^    /, '')
		---
		layout: post
		title: #{title}
		---
		
		EOS
	  end
	  if (ENV['EDITOR'])
		system ("#{ENV['EDITOR']} #{post_file}") 
	  end
	end


