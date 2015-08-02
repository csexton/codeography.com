---
title: Playing Minecraft when the Port is Blocked
layout: post
date: 2015-08-02
---

I was at a conference this last weekend and the network blocked the port that minecraft needed to connect to the server. So I spent longer than I would like to admit setting up a ssh tunnel. Here's what I did:

### 1) Create the tunnel

```
ssh -L 8080:yourminecraftserver.club:25565 -p 22 -l yoursshuser -N yoursshserver.com
```

This will stay running in the terminal. Just leave it going while you play.

### 2) Configure minecraft to use that tunnel

Create a new server by selecting "Multiplayer -> Add Server" and use the following settings:

```
Server Name:
Proxy
Server Address:
localhost:8080
```

Now you should be able to connect and build that dirt hobble you've been planning.
