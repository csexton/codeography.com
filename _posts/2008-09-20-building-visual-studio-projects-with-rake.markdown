---
title: Building Visual Studio Projects with Rake
tags: tech
layout: post
---
We are building a Rails applicaiton that has a C++ client developed under windows, and needed a nice way to script things.  Since the web side of the project was in rails it seemed natural to use rake to build the C++ stuff.  Pretty simple, but in order for the devenv to get loaded we had to load some of the envorment varables up for rake. Once that was done everyting has been easy.

My Rakefile:

    # Visual Studio 2008 Environment Settings:
    ENV["VSINSTALLDIR"] = 'C:\Program Files\Microsoft Visual Studio 9.0'
    ENV["VCINSTALLDIR"] = 'C:\Program Files\Microsoft Visual Studio 9.0\VC'
    ENV["DevEnvDir"] = 'C:\Program Files\Microsoft Visual Studio 9.0\Common7\IDE'
    ENV["PATH"] = 'C:\Program Files\Microsoft Visual Studio 9.0\Common7\IDE;C:\Program Files\Microsoft Visual Studio 9.0\VC\BIN;C:\Program Files\Microsoft Visual Studio 9.0\Common7\Tools;C:\WINDOWS\Microsoft.NET\Framework\v3.5;C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727;C:\Program Files\Microsoft Visual Studio 9.0\VC\VCPackages;' + ENV["PATH"]
    ENV["INCLUDE"] = 'C:\Program Files\Microsoft Visual Studio 9.0\VC\ATLMFC\INCLUDE;C:\Program Files\Microsoft Visual Studio 9.0\VC\INCLUDE;C:\Program Files\boost\boost_1_35_0'
    ENV["LIB"] = 'C:\Program Files\Microsoft Visual Studio 9.0\VC\ATLMFC\LIB;C:\Program Files\Microsoft Visual Studio 9.0\VC\LIB;C:\Program Files\boost\boost_1_35_0\lib'
    ENV["LIBPATH"] = 'C:\WINDOWS\Microsoft.NET\Framework\v3.5;C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727;C:\Program Files\Microsoft Visual Studio 9.0\VC\ATLMFC\LIB;C:\Program Files\Microsoft Visual Studio 9.0\VC\LIB'
    
    # WiX Environment Settings
    WIX_PATH="\"C:/Program Files/Windows Installer XML v3/bin\""
    CANDLE= WIX_PATH + "candle"
    LIGHT = WIX_PATH + "light"
    desc "Build the project in release"
    task 'release' do
      system 'VCBuild path/to/project.vcproj  Release /rebuild /nologo'
    end
    task :default => [:release]

