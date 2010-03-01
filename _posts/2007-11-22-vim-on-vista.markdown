---
title: Vim on Vista
tags: tech
layout: post
---
Ok, so I wasted a good part of thanksgiving day trying to get vim workign again on vista.  I am not sure what happened, but it went nuts.  It may have been the recent windows updates or the face that I in stalled .NET 3.5, but it was unusable.  None of the plugins/syntax highlighting/menus that I have grown to love.  So here is what I did:

Vim on Vista

Installed gvim71-2.exe to C:\vim (<a href="http://hasno.info/2007/5/18/windows-vim-7-1-2">from here</a>)

Copy the folling files into C:\vim\vim71\

 * iconv.dll (<a href="http://sourceforge.net/projects/gettext">from here</a> You can find the dll file in the bin directory of the "libiconv-win32" archive.)
 * libintl.dll (<a href="http://sourceforge.net/projects/gettext">from here</a> Get "intl.dll" from the bin directory in the gettext-win32 archive and store it as "libintl.dll" in the same directory as gvim.exe, overwriting the file that may already be there.)
 * gvimext.dll (<a href="http://www.vim.org/scripts/script.php?script_id=1720">from here</a>)

Here is the thing that stuck me for hours, if you had previously installed vim

to the recommended location of C:\Program Files you won't be able to associate

files with the new location until you edit the registry.  Go to:

    HKEY_CLASSES_ROOT\Applications\gvim.exe

Make sure the edit\command and open\command Keys have the following default value:

    C:\vim\vim71\gvim.exe "%1"

If you want the  "Edit with vim" in windows explorer:

 *  Run C:\vim\vim71\install.exe
 * Choose no when asked if you want to uninstall, then enter "d 14"If you get a gvim not in your path error with the "Edit with vim" shell ext, make sure you don't have gvim.exe set to run as Administrator, as that will break it.

If you don't want to run around and get those files, you can download them <a href="http://www.blogger.com/files/vimvista.zip">here</a>.

Also, I added my suite of vim files <a href="http://www.blogger.com/files/vimfiles.zip">here</a>.
