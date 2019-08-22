---
layout: post
title: Installing Rails 6 on Heroku Revisited
---


In my [original post](/2019/08/02/rails-6-on-heroku.html) I outlined a solution that involved adding a Heroku build pack. But after a discussion on [`rails/webpacker`](https://github.com/rails/webpacker/pull/2206) found a better way to handle this error.

So if you see this:

```
 Compilation failed:

 !
 !     Precompiling assets failed.
 !
 !     Push rejected, failed to compile Ruby app.
 !     Push failed
 ```

I was able to fix the issue by moving the sass packages into the production dependencies instead of the `devDependencies`

I moved the two Sass packages to `dependencies`, and it worked:

```diff
   "dependencies": {
     "@rails/actioncable": "^6.0.0",
     "@rails/activestorage": "^6.0.0",
     "@rails/ujs": "^6.0.0",
     "@rails/webpacker": "^4.0.2",
     "turbolinks": "^5.2.0",
+    "node-sass": "^4.12.0",
+    "sass-loader": "^7.1.0"
   },
   "devDependencies": {
-    "node-sass": "^4.12.0",
-    "sass-loader": "^7.1.0",
     "webpack-dev-server": "^3.3.1"
   },
```

This winds up being a better solution because:

1. It doesn't rerun the yarn install (which can take a while, [even if it is supposed to be fast on subsuquent runs](https://github.com/rails/webpacker/pull/2206#issuecomment-519980678))
2. Uses the libraries I expected
3. Works with the default Heroku buildpack

Thanks to [Brian](https://github.com/bbugh) and [Jake](https://github.com/jakeNiemiec) for helping me get this sorted. Still a learning process with NPM, Webpack, and friends.
