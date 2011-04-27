---
layout: post
title: "Keeping track of deploys: Make an about.txt with Capistrano"
published: true
---

I wrote this for an app couple years ago and needed it agian -- so I went and dug it up. I am certinan could be done in a more elegent way, but this works well and gives the information I needed about each deploy. Plus I know that both PM and QA folks understand how this works with very minimal guidence. Makes triaging issues go much smoother.


    namespace :deploy do
      desc "Create about and revision files."
      task :after_update_code, :roles => :app do
        run "echo \"Version Info\" > #{release_path}/public/about.txt"
        run "echo \"============\" >> #{release_path}/public/about.txt"
        run "echo \"Version: `cat #{release_path}/VERSION`\" >> #{release_path}/public/about.txt"
        run "echo \"Deploy Date: `date`\" >> #{release_path}/public/about.txt"
        run "cd #{release_path} && echo \"Ref: `git rev-parse --short HEAD`\" >> #{release_path}/public/about.txt"
        run "echo \"Branch: #{revision}\" >> #{release_path}/public/about.txt"
        run "echo \"Installer Info: see /download/about.txt\" >> #{release_path}/public/about.txt"
        run "echo \"#{revision}\" > #{release_path}/public/revision.txt"
      end
    end


You can find the gist up on [github](https://gist.github.com/941035).
