---
layout: captured_narrow
title: Captured - How to take a Screen Capture on Mac OS X
---
## Captured Frequently Asked Questions

Captured aims to be as intuative as possible, however some of the more advance funcitonality can be a little confusing. Below you'll find a few tips for getting things working best for you.

## SFTP Configuration

Because FTP is inherently insecure, Captured only allows for SFTP uploads. Luckily most hosting providers or sysadmins provide this protocol.

![SFTP Perference Panel](images/sftp-config.png)

 * Username and Password: Pretty self explanatory.
 * Hostname: The hostname of the SFTP Server.
 * Path on server: The directory on the server that captured should upload the images to. This is a relative path by default, but if you prefix it with a slash it will be absolute (e.g. /var/www-data/captured)
 * Public URL: This is the URL to the host and directory that can be accessed over the web. The host in this URL will probably be the same as the SFTP Hostname, and the path should correspond to the public web folder.

## System Screen Shots

By default OS X will take a screen shot when you press the keyboard shortcut ⌘⇧4, and normally captured will upload those screen shots. However, Captured also introduces a ⌘⇧5 option that will skip the desktop and just upload the image directly.

Captured can be configured to only respond to the



One of the most powerful preferences in Captured is the "Only Upload on ⌘⇧5"
![Preferences Panel](images/genaral-config.png)

