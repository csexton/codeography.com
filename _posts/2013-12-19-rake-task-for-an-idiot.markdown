---
layout: post
title: Most useful rake task for an idiot
---

I am not the smartest. I frequently get things wrong. This is why I like programming, you can go fix things when you mess up. I would make a really bad surgon.

Given that, I love this rake task. I didn't come up with the idea, but not sure exactly where it came from.

```ruby
mespace :db do
  task :dev_only do
    raise "You can only use this in dev!" unless Rails.env == 'development'
  end

  desc "Drop, create, migrate, seed the development database. Then prepare the test database."
  task fuckit: [
    'environment',
    'db:dev_only',
    'db:reset',
    'db:seed',
    'db:test:prepare'
  ]
end
```

Now when you mess up your database, or get migrations out of sync you can just run `rake db:fuckit` and keep moving.

