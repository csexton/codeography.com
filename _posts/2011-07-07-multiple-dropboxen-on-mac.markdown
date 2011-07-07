---
layout: post
title: "Multiple Dropboxen on Mac the right way"
published: true
---

I really didn't like the way other people explained setting up multiple dropboxen on a mac, which involved creating multiple directories and files, incliuding, of all things, faux app bundles. This bugged me, so I made a new launchd.plist and drive it all from that one config file.

First, create a file in `~/Library/LaunchAgents/com.dropbox.alt.plist` with the following contents, updating the USERNAME for your username.

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>com.dropbox.alt</string>
        <key>LowPriorityIO</key>
        <true/>
        <key>EnvironmentVariables</key>
        <dict>
          <key>HOME</key>
          <string>/Users/USERNAME/.dropbox-alt</string>
        </dict>
        <key>ProgramArguments</key>
        <array>
          <string>/Applications/Dropbox.app/Contents/MacOS/Dropbox</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
      </dict>
    </plist>

Second, run the following commands:

    launchctl load ~/Library/LaunchAgents/com.dropbox.alt.plist
    launchctl start com.dropbox.alt

The Dropbox dialog will appear. On the "Setup Type" screen of their installer make sure you change the folder to a custom location that makes sense for you (otherwise it will put it in ~/.dropbox-alt/Dropbox).

![Dropbox Installer](/images/dropbox01.png)

Done. No faux app bundles. Everything is controled by launchd, just the way it should be.
