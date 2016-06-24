---
title: Vim on Vista
tags: tech
layout: post
---

Turns out you can have fenced code blocks in ordered lists with Github Flavored Markdown. Just the formatting was a little picky.

- Prefix the line with 4 spaces for every level in the list
- Empty lines before and after the code block


So that means if the list has only one level just prefix it with 4 spaces:

```
1. First Item
1. Second Item

    ```
    # My codes
    ```

1. Third Item
```


If it is a nested list

```
1. First Parent Item

    ```
    # Parent codes
    ```

1. Second Parent Item
  1. First Child Item

        ```
        # Child codes
        ```

  1. Second Child Item
1. Third Parent Item
```
