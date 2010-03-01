---
title: Dynamic Cheese Grater
tags: tech
layout: post
---
I decided I'd like to access my home computer from work, specifically I wanted to be able to ssh into the machine. I used to do this by setting up a dynamic host name and just leaving my computer on all day long, but that hardly seemed like the best way to deal with it.  More specifically, I didn't really want to pay for the electricity of running that thing all day long.  So I decided to look into what I needed to do to get Wake-on-LAN to work with my Power Mac and FiOS modem.

 * First was to go back to Dyndns.com and get a hostname for my compy. I like the "homeip.net" ones, cause, it is in my home. 
 * Configure my router to port forward ssh (tcp on port 22) 
 * And wake-on-lan (udp on port 9) to my desktop.
* Configure OS X to allow ssh (System Prefrences - Sharing - Check "Remote Login") 
 * And to allow wake-on-lan (System Prefrences - Energy Saver - Show Details - Check "Wake for Ethernet..."

Now I just needed a way to wake it up. First I played with <a href="http://www.dslreports.com/wakeup">this web page</a>, which worked, but required me to type in my Desktop's MAC address every time.  Uncool.  Then I found a little perl script that could do it, sorta.  At that point I realized this was a job for ruby. And lo and behold I found K. Kodama <a href="http://www.math.kobe-u.ac.jp/~kodama/tips-WakeOnLAN.html">WOL Class</a>, which did nearly exactly what I wanted.    I took that and hacked it up so my settings were all hard coded, added a she-bang, made it executable and linked to it from somewhere in my path.  Now I can simply type "wakebold" and it will wake up my desktop at home (whom  have affectionally named "bold").

My changes were really easy:

    # Configure the IP and MAC address for the computer you want here:

    SETTINGS = { :mac_addr => "00:00:00:00:00:00", :host_name => "example.homeip.net"}

    if $0 == __FILE__
      wol=WakeOnLan.new
      wol.wake(SETTINGS[:mac_addr], "255.255.255.255", SETTINGS[:host_name])
      wol.close
      puts "Waking up #{SETTINGS[:host_name]}"
    end

My hacked version can be found in my <a href="http://www.fuzzymonk.com/svn/wakeywakey">svn repo</a>.

To do all this, you can do the following:

    svn co http://www.fuzzymonk.com/svn/wakeywakey
    chmod +x wakeywakey/wakey.rb
    ln -s wakeywakey/wakey.rb /usr/local/bin/wakebold # or elsewhere in your path

