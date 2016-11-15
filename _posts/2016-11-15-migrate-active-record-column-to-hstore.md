---
layout: post
title: Migrate ActiveRecord column to an hstore key in Rails
---


I really do like [PostgreSQL's `hstore` type](https://www.postgresql.org/docs/current/static/hstore.html), espcially when I have some configuration properties that I don't need to query or index. But ran into a problem when I needed to migrate data. I needed to move a column to an hstore within the same row (and back again).

Knowing that migrating data with ruby models is fragile and WILL break when you change your models -- I wanted the data munging to be done in raw SQL.

Say I have a `url` column in `my_table`. I want to move that to the 'url' key in a new `hstore` column called (helpfully) `my_hstore`. This migration will add the new column, migrate the data and drop the old column. If nervous about that and want to keep the column around just delete the `remove_column` bit.

First, generate the migration:

```
rails generate migration move_url_to_my_hstore
```

Then, update it to add the column, migrate the data, and drop the column. Then reverse the entire process in the `down` method:

```ruby
class MoveUrlToMyHstore < ActiveRecord::Migration[5.0]
  def up
    add_column :my_table, :my_hstore, :hstore
    execute <<~END
      UPDATE my_table
      SET my_hstore = hstore('url', subquery.url)
      FROM (SELECT id, url FROM my_table) as subquery
      WHERE my_table.id=subquery.id;
    END
    remove_column :my_table, :url, :string
  end

  def down
    add_column :my_table, :url, :string
    execute <<~END
      UPDATE my_table
      SET url = subquery.turl FROM (SELECT id, my_hstore->'url' as turl FROM my_table) as subquery
      WHERE my_table.id=subquery.id;
    END
    remove_column :my_table, :my_hstore
  end
end
```

Hope this is helpful to someone out there.
