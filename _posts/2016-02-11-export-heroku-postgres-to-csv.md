---
layout: post
title: Export Heroku Postgres to CSV
---

I needed to export a table in a Heroku Postgres table. But the `COPY` query requires administrator privileges, and I don't have those on heroku. Luckily you can use the `\COPY` command:

```
% heroku pg:psql --app my-app-production
---> Connecting to DATABASE_URL
my-app-production::DATABASE=> select count(*) from some_table;
 count
-------
 20910
(1 row)

my-app-production::DATABASE=> \copy (SELECT * FROM some_table) TO some_table.csv CSV DELIMITER ','
COPY 20910
```

This writes the contents of `some_table` to `some_table.csv` in your working directory.
