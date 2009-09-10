---
layout: post
title: Automating Apple's PackageMaker
---

This article should have a sub title:

Automating Apple's PackageMaker: A wonderful way to punish the well intensioned developer.

It seems like PackageMaker is very much an incomplete and buggy tool.  I know we are suposed to use drag-n-drop installs, but sometimes that just isn't a good option. Like if you were creating a system daemon. 

Even trying to use the option documented in the usage message fail:

    $ Flat\ Package\ Editor --extract /tmp/fpm -f test.pkg
    Extraction not supported from the command line yet.

Granded that is the Flat Package Editor, but as you can see it is just part of PackageMaker, and seemed to have an option I needed -- only it is not implemented.

Initially I wanted to make a ruby library to automate creating the pmdoc contents xml files, and possibly some generator scripts. This seemed like it would be straight forward, but I kept running into gotchas. 

Amoung my list of complaints when trying to work with a pmdoc:

The relocatable checkbox (and occationally the require reboot option) magically get selected when editing other properties. I notced this every time I would alter the path to the bundle. If I changed "Release" to "Debug" all the other properties would be altered. This got old.

Can't relaiably track changes in version control, because just opening the package in PackageMaker changes every line in every file contained in the pmdoc bundle. 

While you can mark certian paths as relitive, not all of them could be. So you are forced to use absolute paths in some places. If you use a relitive one PackageMaker will crash when trying to build.

This just seemed like a rat hole I would be stuck in, so I abandoned this in favor of a straight command line build.

This means you have to create the root directory, copy all the files into a directory structure that you want for the target and bundle it up. You can specify the recources and scripts directory for the bundle that get included. In theory if you put the right files with the right names in the right place in these directories then they will get use appropratly. This does not always seem to be true.

For example:

I have a scripts folder with a postinstall script:

    Scripts/postinstall

and I include that on the command line

    packagemaker --scripts ./scripts/ ...

It will get run after the install. Yay!

BUT, if I want a background image I should just have to put the file in the right place

    Resources/background.png

And include that resources in the command

    packagemaker --resources ./scripts/ ...

But no dice. If I want the background image to show up I have to un-xar the pkg file:

    xar -xf <path_to_pkg> -C <work_dir>

Edit the Distribution file

    <background file='background.png' alignment='bottomleft' scaling='none'/>

Re-xar the file

    cd <work_dir>
    xar -cf my_installer.pkg .

Currently I have given up on any custom modifacations (like background images), and can do this a a few steps.

Clean up, create the root and populate it with the approprate files

    find ./scripts/ -name '*.DS_Store' -type f -delete
    find ./resources/ -name '*.DS_Store' -type f -delete
    rm -rf <package_path>
    mkdir -p <package_root_path>
    cp -R build/<build_dir>/MyApp.app <package_root_path>
    cp -R build/<build_dir>/MySecondApp.app <package_root_path>
    cp any/requred/files <package_root_path>

Change the permission to what they should be on the target:

    sudo chown -R root:admin <package_root_path>
    sudo chmod -R g+w <package_root_path>

Run the package maker build on the command line:

    /Developer/usr/bin/packagemaker \
    --title "My Installer" \
    --version 1.0 \
    --filter "\.DS_Store" \
    --resources ./resources/ \
    --scripts ./scripts/ \
    --root-volume-only \
    --domain system \
    --verbose \
    --no-relocate \
    -l "/Library/Application Settings/MyApp" \
    --target 10.5 \
    --id com.example.my_installer.pkg \
    --root <package_root_path> \
    --out <my_installer.pkg>

This will put everything that was in the package_root_path into "/Library/Application Settings/MyApp" on the target. I was doing this because all my files needed to be in that directory. If you need multiple locations through out the drive you can always set -l to "/", and create the directory tree of the target under your package_root_path.

    If you wanted to do that the directory tree would look something like this:

    package_root_path/
                     /Applicatons/
                                 /MyApp.app
                     /Library/
                             /MyApp
