require "rubygems"
require "rake"
require "active_support"

desc "Deploy to codeography.com"
task :deploy do
  sh "jekyll"
  sh "scp -r _site/* codeography.com:codeography.com/"
end

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
    system ("git add #{post_file}") 
  end
end

