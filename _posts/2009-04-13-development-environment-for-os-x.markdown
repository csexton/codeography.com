---
layout: post
title: Development environment for OS X

---


I recently blew away all my developer tools, /usr/local and /opt (mac ports), and wanted to start with a clean install of my development tools. The following is my configuration for Ruby, Rails, iPhone and C++ development:

Cleanup was done by removing the developer tools with the include perl script:

	sudo /Developer/Library/uninstall-devtools --mode=all

Then I deleted /opt, which nuked all of the old macports I had installed.

Then I cleaned out everything I thought I could from /usr/local/.  I was mostly interested in removing the include, share, and lib folders from there.  Just to be safe I didn't delete them outright, rather I moved them to a 'deleteme' directory while I made sure I could get everything working again.

Once cleanup was done, it was onto the reinstall.

Install the developer tools, I grabbed the latest by downloading the iPhone SDK from the [ADC](http://developer.apple.com/iphone/)

Install MacPorts
----------------

	sudo port -v selfupdate

Install the ports
-----------------

	sudo port install subversion +bash_completion git-core +bash_completion+doc+gitweb+svn ruby rb-rubygems rb-rake curl xercesc boost log4cpp cppunit mysql +server 

Install the gems
----------------

	sudo gem install rails 
