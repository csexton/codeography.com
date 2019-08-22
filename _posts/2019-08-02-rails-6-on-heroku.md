---
layout: post
title: Installing Rails 6 on Heroku
---

# Update: there is a better way!

After some discussion on the `rails/webpacker` issues I have a better solution for this. See the [updated post](/2019/08/02/rails-6-on-heroku-revisited.html) for details.

----

Ran into a problem installing Rails 6.0.0.rc2 on Heroku. Being a good Rails citizen I was trying use Webpacker and all it's JS goodness.

Then I spent two days trying to figure out why assets wouldn't compile when deploying to heroku. And I got this frustratingly vague error:

```
 Compilation failed:

 !
 !     Precompiling assets failed.
 !
 !     Push rejected, failed to compile Ruby app.
 !     Push failed
 ```

 After some digging I [found out](https://github.com/rails/webpacker/blob/master/docs/troubleshooting.md#compilation-fails-silently) you can enable errors in Webpacker by editing `config/webpacker.yml`:

```diff
-  webpack_compile_output: false
+  webpack_compile_output: true
```

Which showed errors (yay!):

```
ERROR in ./app/javascript/theme/style.scss (./node_modules/css-loader/dist/cjs.js??ref--7-1!./node_modules/postcss-loader/src??ref--7-2!./node_modules/sass-loader/lib/loader.js??ref--7-3!./app/javascript/theme/style.scss)
Module build failed (from ./node_modules/sass-loader/lib/loader.js):
Error: ENOENT: no such file or directory, scandir '/tmp/build_b6d942494af54889b656091b0e3a440f/node_modules/node-sass/vendor'
```

See [this gist](https://gist.github.com/csexton/7872e358e4d4294d9dffd489ca31b49c) for the full log.


Turns out this is due to a strange bug with node-sass where it needs to be re-built after updating modules. The [solution](https://help.heroku.com/LRB0A1Q8/why-are-my-builds-failing-with-a-node-sass-error) is is to add a postinstall script to your `package.json`:

```json
"scripts": {
  "postinstall": "npm rebuild node-sass"
}
```

Cool, thought this would fix it. But still got the same error above. When I connected to a bash terminal in teh heroku console I found a weird error:

```
~ $ npm rebuild node-sass
bash: npm: command not found
```

Wut? I thougth node was part of the [Ruby build pack](https://github.com/heroku/heroku-buildpack-ruby) on Heroku. Turns out, we [need](https://github.com/rails/webpacker/issues/395#issuecomment-302024296) the [Node.js buildpack](https://github.com/heroku/heroku-buildpack-nodejs) to get a `npm` binary.

So I added the buildpack, making sure to put the node one earlier in the list.

![Node.js build pack on Heroku dashboard](/images/rails6-heroku.png)

Then I got a sweet green "Build Succeeded" message in Heroku.


![Build Succeeded on Heroku dashboard](/images/rails6-heroku-build.png)



