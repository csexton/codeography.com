---
title: How do you write great commit messages?
layout: post
date: 2015-02-17
---

The best way to learn to write great commit messages is to go back and read them.

When reading code take a moment and go look at the git history every time you mutter "why did they do that." That's the point in time when you want to know the real "why" behind the change. If you don't already know how to to that, take moment to figure out a way quickly to access the history of a line in [your](https://magit.github.io/) [editor](https://github.com/tpope/vim-fugitive) or in [your](https://github.com/blog/228-playing-the-blame-game) [repo](http://git-scm.com/docs/git-blame), the less friction the easier it is to go back and read about the changes.

If you make a habit out of this, you will quickly learn what is helpful and what is not. Then, if you are like me, you'll want to go back to slap your past-self for being lazy and giving a few bullet points of "what" was changed and not "why" it was changed.

Sound good? You in? Cool.

To get started just add the word "[because](https://twitter.com/sarahmei/status/566667320425066497)" to your commits.

Lets look at an example.

```diff
Changed the post title font size

Changed 0.8em 16px.

h2 {
-  font-size: 0.8em;
+  font-size: 16px;
}
```

And what if I ever come across this file, I might wonder why this person strayed from the convention of using relative font sizes to pixels. I would would mutter "wtf" to myself and pop open the `git blame` in my editor for that line and read the commit message. This right here is the point that I want to know why.


```diff
Changed the post title font size

Fixed it to 16 pixels because when we increased the overall font size on
the blog the titles were wrapping on mobile views.

h2 {
-  font-size: 0.8em;
+  font-size: 16px;
}
```

Now this is helpful. It gives me context. I get clues on what changed in this code and what might break. And I can see that it wasn't some arbitrary change. Me in 6 months will appreciate this.

A commit already contains a `diff`, so it shows what was changed. No reason to write that up again. But nothing explains why you made that horrible hack or sweeping change.

Communicating the current reasoning to your future self is a super power.

----


### Further Reading

There have been many posts about commit message from formatting to content. Here are a few of my favorite, should you want to level up:

Tim Pope's [A Note About Git Commit Messages](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html). This is formatting and syntax, but if you follow this I will be much, much happier.

Caleb Thompson's [5 Useful Tips For A Better Commit Message](http://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message). A bit vim-centric, but great guidelines.

Stephen Ball's [Deliberate Git](http://rakeroutes.com/blog/deliberate-git/). An in depth guide to commit messages. Worth the time to read and understand.

Keavy McMinn's [How to write the perfect pull request](https://github.com/blog/1943-how-to-write-the-perfect-pull-request). Slightly different than commit messages, but they really go well together.





