require 'erb'
require 'time'
require 'cgi' #for CGI.escape

DEFAULT_POST_TEMPLATE = <<EOS
---
layout: post
published: true
title: <%= title %>
---

EOS

module Jekyll 

  class PostGenerator
    attr_accessor :title

    def initialize(source)
      @source_path = source || Dir.pwd
    end

    def dasherize(camel_cased_word)
      camel_cased_word.to_s.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("_", "-").
        tr(" ", "-").
        downcase
    end

    def h1(title)
      "#{title}\n#{"=" * title.length}"
    end

    def prompt_user(prompt_text)
      print "#{prompt_text}: "
      user_input = gets
      user_input.strip
    end

    def read_template
      template_file = File.join @source_path, "_templates", "post.markdown.erb"
      if File.exists?(template_file)
        @template = ERB.new(File.read template_file)
      else
        @template = ERB.new(DEFAULT_POST_TEMPLATE)
      end
    end

    def file_name
      CGI.escape(DateTime.now.strftime("%Y-%m-%d-#{dasherize(title)}.markdown"))
    end

    def result
      @template.result(binding)
    end

    def generate(title=nil)
      if title.nil? || title.empty?
        @title = prompt_user("Title") 
      else 
        @title = title
      end
      read_template
      full_path_to_file = File.join(@source_path, "_posts", file_name)
      File.open(full_path_to_file, 'w') {|f| f.write(result) }
      full_path_to_file
    end
  end
end

