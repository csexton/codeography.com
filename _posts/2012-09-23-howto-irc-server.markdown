---
layout: post
title: Howto setup the Ultimate IRC Server
---

While I like Campfire and HipChat and those other tools for group collaboration there is just something nice about using an IRC channel. Probably the most compelling reason is that I am going to have my IRC client running anyway for other channels -- so it would be nice to just add a server and use the same client I am already using.

At Radius we had been using a public server for a little bit of communication, but the converstaions starting becoming more technical and wasn't happy having things go through someone else's server, and be unencrypted. So I decided to setup my own. I give you the ultimate irc setup:

## The Ultimate IRC Server

The ultimate server consists of a few components:

* The IRC server itself (ircd-hybrid)
* an IRC bouncer (ZNC)
* a way to tunnel port 443 to the bouncer
* and maybe a bot that can post funny pictures of cats for you

### Spin up a new server (or use one you already have)

I am using Ubuntu Server 12.04.1 LTS (ami-137bcf7a) running on a micro instance.

### Install the IRC Server

    sudo apt-get install ircd-hybrid
    sudo vim /etc/ircd-hybrid/ircd.motd

Create the password required to be the Oper:

_WARNING: Please do not mix up the `mkpasswd` program from `/usr/sbin` with this one. If you are root, typing `mkpasswd` will run that one instead and you will receive a strange error._
    /usr/bin/mkpasswd super-secret

Edit the config file, this is well documented and there are plenty of little tweaks you can make but the only thing you need to do is comment out the `host` parameter in the `listen` section (about line 130 in the default ubuntu config)
    sudo vim /etc/ircd-hybrid/ircd.conf

    host = “127.0.0.1″;

to

    #host = “127.0.0.1″;


This will open the server up to external connections (Note: if you are using EC2 you will also need to open up the ports to allow these connections)

Now restart the server

    sudo /etc/init.d/ircd-hybrid restart

Now you should be able to fire up your favorite client and see if you can get it to connect to the server. Once you have proven it works, time to move onto the bouncer.

### Install the IRC Bouncer

Originally I followed the guide from [Dustin Davis](http://www.nerdydork.com/setting-up-a-znc-irc-bouncer.html) but have a few tweaks:

    sudo apt-get install znc
    znc --makeconf

Follow the guides to setup the server. I mostly choose the defaults, and enabled all the modules

    What port would you like ZNC to listen on? (1025 to 65535): 6664
    Would you like ZNC to listen using SSL? (yes/no) [no]: yes
    Would you like to create a new pem file now? (yes/no) [yes]: yes
    Listen Host (Blank for all ips):
    Number of lines to buffer per channel [50]: 1000
    Would you like to keep buffers after replay? (yes/no) [no]: yes

Configure ZNC to use the brand new IRC server that we just installed:

    IRC server (host only): 127.0.0.1
    [127.0.0.1] Port (1 to 65535) [6667]: 6667
    [127.0.0.1] Password (probably empty):
    Does this server use SSL? (yes/no) [no]:
    Would you like to add another server for this IRC network? (yes/no) [no]: no
    Would you like to add a channel for ZNC to automatically join? (yes/no) [yes]: yes
    Would you like to add another channel? (yes/no) [no]: no
    Would you like to set up another user (e.g. for connecting to another network)? (yes/no) [no]: no
    Launch ZNC now? (yes/no) [yes]: no

Now you can run ZNC as that user and verify it works, and make tweaks to the config.

    vi .znc/configs/znc.conf

or with the webadmin module by pointing a browser to

    https://yourhostname:6664

To verify that this works with your local client you should just have to change the port from 6667 to 6664. If you want to compare settings my initial config file looked something like [this](https://gist.github.com/3773180).

### Make ZNC a system daemon

At the end of the config keep it running and connect to it from your local IRC client to make sure things are working. Once you have proven it works time to set it up as a daemon that starts at boot.

    killall znc # just to make sure

Create the user and group

    sudo addgroup --system znc
    sudo adduser --system --no-create-home --ingroup znc znc

Create the init script, I have the one I use up [here](https://gist.github.com/3772971)

    sudo vim /etc/init.d/znc

It's pretty big, so you may want to curl it down

    curl https://raw.github.com/gist/3772971/efbe88004be70cb7f157e30aa1183ea5867d8de6 > /etc/init.d/znc

Copy over the znc config files etc, and update permissions

    sudo mkdir /etc/znc
    sudo mv /home/$USER/.znc/* /etc/znc/
    rm -R /home/$USER/.znc
    chown -R znc:znc /etc/znc
    sudo chown -R znc:znc /etc/znc
    sudo chmod +x /etc/init.d/znc

Start 'er up

    sudo /etc/init.d/znc start

### Setup port forwarding

Forward from 443 to 6664 to work around firewalls.

This step is not required if your network does not block the ports we are using. But it is still nice to use in case you ever find yourself on one. Also you would not want to do this on a server that is serving webpages over https.

    sudo apt-get install rinetd
    sudo vim /etc/rinetd.conf

Edit that file to include a new forwarding rule

   0.0.0.0 443 127.0.0.1 6664

Restart rinetd

   sudo /etc/init.d/rinetd restart

If you enabled the webadmin module in znc you should now be able to point your browser to `https://yourhostname` and edit your znc config (and let folks edit their accounts, configure modules and change passwords). Yes, znc uses the same port for IRC connections and for the admin page.

### Recap

Now you should have an irc server running on port 6667, a bouncer running on port 6664, and a tunnel for the bouncer from port 443.

I just used the web admin module to setup accounts for everyone on my team. I wound up turning off external access to 6667 so that I didn't have to secure ircd, and everyone just goes through znc.

You might want to setup an bot to do your bidding, I use [radbot](http://github.com/csexton/radbot)

I run this on a micro instance on Amazon's EC2, so it costs us about $14/month -- but given that I use the server for other things as well it doesn't _really_ cost the full $14.
