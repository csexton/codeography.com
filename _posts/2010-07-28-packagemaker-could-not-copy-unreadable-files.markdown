---
layout: post
title: "PackageMaker could not copy unreadable files"
published: true
---


I was getting a bizarre error with Apple's PackageMaker

    % /Developer/usr/bin/packagemaker --filter "\.DS_Store" --root-volume-only --domain system --verbose --no-relocate -l "/" --target 10.5 --id com.codeography.program.pkg --resources build/Release/Package/resources --scripts build/Release/Package/scripts --title "Program Name 2.1.10" --version 2.1.10 --root build/Release/Package/root --out installer.pkg                                                                 
    Preverifying root
      Preverifying root
      Checking bundle identifiers
      Checking package configuration
      Checking contents
      Loading contents
      Applying Recommended Permissions
      Checking for ZeroLink
    Preverifying Program Name 2.1.10
      Preverifying Program Name 2.1.10
    Building root
      Building root
      Copying Scripts
      Copying unreadable files to temporary location
        ERROR: Could not copy unreadable files.
      Renaming package files

After hours of searching I found that I had a vim swap file that wasn't world readable. And when I change the owner of the files that I need to package to be root, my user no longer had read permissions. Finding this was pretty easy using the `find` command.

    % find . \! -perm -444
    installer/config/.Info.plist.swp

Deleted that file and everything worked.
