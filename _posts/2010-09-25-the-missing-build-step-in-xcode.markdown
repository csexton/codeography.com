---
layout: post
title: "Zip for Distribution: The missing build step in Xcode"
published: true
---

I have worked on a couple teams that have submitted iPhone Apps to the iTunes store, however I had never gone through the process on my own until this week. Well, turns out you need to use Apple's "Application Loader.app" to submit your app. So I fired it up, and was unable to select my .app bundle. This confused me, and the documentation probably mentions how to do this, but I just took a swing in the dark and zipped the file. This worked.

While right clicking on the file and selecting "compress" is pretty easy, I also had to rename my file to remove any spaces. Well this has become too many steps for any self respecting programmer. My solution is a custom post build phase:

![Custom Build Phase Screenshot](/images/xcode-add-custom-build-phase.png)

Then I add the following script (making sure the `shell` is set to /bin/sh):

    # We only want to build the zip file when we build for distribution
    if [ "$CONFIGURATION" = "Distribution" ]
    then
       # Create a short name with no spaces and remove the ".app" from the end
       SHORT_NAME=`echo "$EXECUTABLE_FOLDER_PATH" | sed 's/ //g' | sed 's/\.app$//g'`
    
       # Zip the file
       zip -u -1 "$TARGET_BUILD_DIR/$SHORT_NAME.zip" "$TARGET_BUILD_DIR/$EXECUTABLE_FOLDER_PATH"
    
       # Tell us what happened
       echo "Built distribution zip file: $TARGET_BUILD_DIR/$SHORT_NAME.zip"
    fi

At this point I like to right click on the build step and rename it to something useful, something like "Zip App Bundle for Distribution", but hey, that's me.


