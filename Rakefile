desc "Deploy to codeography.com"
task :deploy do
    sh "scp -r _site/* codeography.com:codeography.com/"
end

desc "New post"
task :post do
  load '_scripts/post_generator.rb'
  gets
  pg = Jekyll::PostGenerator.new('_posts')
  path_to_post = pg.generate

  if (ENV['EDITOR'])
    system ("#{ENV['EDITOR']} #{path_to_post}") 
  end
  puts "Successfully generated new post: #{path_to_post}"
end

