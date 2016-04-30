---
layout: post
title: Automatically attach to tmux when connecting via ssh
---

Recently I have needed to keep a long running sessions open on a server. And I have been using [tmux](https://tmux.github.io/) for this purpose for quite some time. However, my internet connection has been flaky, so I've been dropping the connection very frequently. So I wanted to automate the steps. I also had the requirement that the server would have no custom configuration for tmux.

What I came up with was the following command:

```
ssh -t example.com "tmux attach-session -t chris || tmux new-session -s chris"
```

- The `-t` option tells ssh to treat the command like a pseudo-terminal, so you can run interactive commands.

- The two or'd tmux commands will connect to a new session if it exists, or create a new one if it doesn't.

When I roll that up into a little bash script that will name the session the name of my user on my local machine:

```bash
#!/bin/bash
set -e

server=$1
if [ -z "$1" ] ; then
  echo "Usage: $(basename $0) hostname [session name]"
  exit 1
fi

name=$2
if [ -z "$2" ] ; then
  name=$(whoami)
fi

ssh -t $server "tmux attach-session -t $name || tmux new-session -s $name"
```

