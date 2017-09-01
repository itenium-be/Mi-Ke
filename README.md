Mi-Ke
=====
This Mike is not exactly Mycroft Holmes but rather a collection of Autohotkey scripts.

Two fancy ones:

**Control + Win + Z**: Zips the entire folder, or just the selected files, in Windows Explorer. (apps/windows-explorer-zip-directory)  
**Win + Alt + D**: Minimize all windows on monitor of active Window. Press again to restore. (windows-min-max)  

# What

A script running in the background with little productivity boosters.

- Hotstrings to reduce amount of typing (atm -> at the moment)
- Shortcuts to start programs (win+o -> open solitaire.exe)
- Enhancements to programs (cmd, windows explorer, ...)
- Random scripts to do something I often do (did?) manually


# Install


## Executable

Download the zip from the [release tab](https://github.com/Laoujin/Mi-Ke/releases)  
- Extract it
- Run mike.exe
- Much win

ATTN: While you'll be able to customize the shortcuts in mike.ini,
you will not be able to define any hotstrings and have the script
pick them up.



## From source

Requires [Autohotkey_L](https://autohotkey.com/download)

PowerShell:
```ps
git clone https://github.com/Laoujin/Mi-Ke
cd Mi-Ke

# Create an initial setup with some examples
.\init.ps1

# If you do want examples run the following instead
# It will create the file(s) required to start only
.\init.ps1 -bare

# Start
.\mike.ahk
```


## Persist

To start Mi-Ke when Windows starts:

Put a `mike.ahk.lnk` in `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup`.  
In the right click contextmenu of the Mi-Ke tray icon there is also an option to do this for you.



# Customization


## Hotstrings

Start from `hotstrings\_includes.ahk`.


## Scripts

Edit `mike.ini`.




# The scripts


Script: memory-diff
-------------------
**Control + Win + Left**: Put selected text in Desktop\left.txt  
**Control + Win + Down**: Put selected text in Desktop\right.txt and open Diff tool  
**Control + Win + Up**: Show current clipboard content  
**Control + Win + Right**: Open Diff tool with current left/right.txt  
**Control + Win + Numpad0**: Open Diff tool with a Dropbox conflicted file vs the original  

Script: apps/windows-explorer
-----------------------------
**AltGr + Win + D**: Open 2 explorers, one in download folder, one with USB stick (apps/windows-explorer-copy-download-to-usb)  

**2x Esc**: Close active Explorer window  
**2x Capslock**: Put full directory of selected file/folder to clipboard  
**2x Shift + Capslock**: Put full selected filename to clipboard  
**2x Control + Capslock**: Open the path currently on the clipboard in Explorer  

**Control + Shift + N**: New directory (=Windows shortcut)  
**Control + Shift + F**: New file  
**Control + Shift + T**: New txt file  

**Control + Shift + 3**: View => small icons  
**Control + Shift + 4**: View => three columns  
**Control + Shift + 6**: View => details list  


Script: quick-start-programs
----------------------------
**Control + Win + S**: Start Sublime Text. When in Explorer: Open with active folder in Side Bar.  
**Alt + Win + C**: Start Cmder  
**Control + Win + C**: Start calculator (2x esc to close)  
**Win + C**: Start Notepad++  
**Control + Win + F**: Start FileZilla (or activate existing Window)  
**CapsLock & S**: Start HeidiSql  
**CapsLock & Q**: Start Robomongo  
**Capslock & W**: New Chrome window  
**Capslock & X**: Google selected text  


Other Scripts
-------------
**Chrome F1**: Open chrome://extensions in new tab (apps/chrome.ahk)  

**scripts\snippets.ahk**:  

**Control + Shift + Win + C**: Append to clipboard (append-to-clipboard) 
**Control + Win + X**: Put selected text to clipboard. Convert windows path to Unix style path (path-win-to-unix)  
**Win + Alt + M**: Put selected text in Markdown code block (md-code-block-surround)  
**Control + Win + Alt + M**: Create new Markdown code block (md-code-block-new)  


Script: change-sound-volume
---------------------------
Change sound volume with 'funny' images.  

**Win + PgUp**: Volume +10  
**Win + PgDn**: Volume -10  
**Win + Ctrl + PgDn/Up**: Volume +/-10 without images  
**Win + Ctrl + + Alt PgDn/Up**: Volume +/-1 without images  
**Win + End**: Mute/Restore  
**Win + Home**: Show sound volume  


Dev Stuff
---------
**Control + Win + R**: Reload script  
**Shift + F11**: Open ListVars window  
**Alt + F12**: Window Spy
**Capslock & A**: Google selected text + "autohotkey"  


# Other resources

Looking for even more little productivity boosters?

Look no further!

- [Drugoy/Autohotkey-scripts-.ahk](https://github.com/Drugoy/Autohotkey-scripts-.ahk)
- [denolfe/AutoHotkey](https://github.com/denolfe/AutoHotkey)
- [Skrommel scripts](http://www.donationcoder.com/Software/Skrommel/index.html)
	- [GoneIn60s](http://www.donationcoder.com/Software/Skrommel/index.html#GoneIn60s): Recover closed applications
	- [IpUpload](http://www.donationcoder.com/Software/Skrommel/index.html#IpUpload): Upload current IP address to a FTP server
	- [NoClose](http://www.donationcoder.com/Software/Skrommel/index.html#NoClose): Disable the Close button (X) of selected windows
	- [MoveInactiveWin](http://www.donationcoder.com/Software/Skrommel/index.html#MoveInactiveWin): Move a window without activating it
	- [WhatColor](http://www.donationcoder.com/Software/Skrommel/index.html#WhatColor): Show and copy the RRGGBB color under the cursor
- [Jack's Autohotkey Blog](http://www.computoredge.com/AutoHotkey/Free_AutoHotkey_Scripts_and_Apps_for_Learning_and_Generating_Ideas.html)
- [camerb/AHKs](https://github.com/camerb/AHKs)
- [AutoHotkey-Util](https://github.com/cocobelgica/AutoHotkey-Util)

And of course there is an [Awesome AutoHotkey](https://github.com/ahkscript/awesome-AutoHotkey)!


# TODO

## Script ideas

- Script to create a kramdown table from tabbed data
- Make ctrl+a work when changing filename with f2 (take into account multi line when on desktop:)
- hotstrings :A_SPACE:x:: so that you can choose not to expand (instead of the arrowing around atm)
- Convert an ahk to exe
- DynaRun: copy some Autohotkey and run it

Subtitles: script to rename srt that looks like selected file to match selected file exactly  
or if only one srt in directory, rename to same as selected file  
http://www.yifysubtitles.com/  
http://www.ondertitel.com/  

Print dates in interesting formats :)  
https://autohotkey.com/docs/Hotstrings.htm  
:*:]d::  ; This hotstring replaces "]d" with the current date and time via the commands below.  
FormatTime, CurrentDateTime,, M/d/yyyy h:mm tt  ; It will look like 9/1/2005 3:53 PM  
SendInput %CurrentDateTime%  
return  




## Accessibility

Build a script that creates the exe, zipped with the ini files  
--> 2 zips (ahk/exe) should be added to releases in Github

- this readme is too long -> put stuff in gh-pages branch:  
https://stackoverflow.com/questions/31969868/how-to-store-github-wiki-as-part-of-source

- some gui screen with all active hotkeys
- init.ps1 Exercise: New docker, git clone, init.ps1, and it should just work?
	- Check that mike.ahk.lnk works on diff versions of Windows

- apps-windows-explorer: double-tap=1 instead of hardcoded 2x capslock as is now
- label= A HotKey label that should be executed... (could setup same way as hotstrings?)
- If title-matcher is not provided, get the ahk_exe after opening for first time (is title-matcher used atm to )
- <A_PROGRAMFILES>\Robo 3T 1.1.1\robo3t.exe -> support wildcards for versions...

## Quick start programs

- If title matcher is not provided, get the ahk_exe after opening for first time?

## Improvements

- Waiting for windows -> use hwnd for more reliability
- Also check about doing something waiting for other stuff (clipboard, ...)

## Unused snippets

Included but not yet bound to a shortcut:  
utilities/base64.ahk  
utilities/eol-convert.ahk  

Disable Left Win going into Metro mode  
Also disables shortcuts using Win key  
LWin::Return  

Sitez:  
- https://jacksautohotkeyblog.wordpress.com (http://www.computoredge.com/AutoHotkey/Downloads/)
- https://github.com/jNizM/AHK_Scripts

https://autohotkey.com/board/topic/33506-read-ini-file-in-one-go/


Gui Creator?  
https://autohotkey.com/boards/viewtopic.php?f=6&t=303&sid=4f44b6b191c1f6fe0df4f93944c39aa6  
https://github.com/maestrith/GUI_Creator

## Window moving

- [bug.n](https://github.com/fuhsjr00/bug.n): Tiling Window Manager for Windows
- [Min2Tray](http://junyx.breadfan.de/Min2Tray): Minimize window to tray & more
- [NiftyWindows](http://www.enovatic.org/products/niftywindows/download): control of all basic window interactions such as snap-to-grid, "keep window aspect ratio", rolling up a window to its title bar, transparency control.
- [WindowPad](https://github.com/hoppfrosch/WindowPadX)

Window mover: Use https://github.com/fuhsjr00/bug.n  ?  
Window mover: resize so not below taskbar or above screen (or left/right:)  
Window mover: take away from all the edges a bit  
Window mover: center at "semi" full screen  
Window mover: for when screen has some weird size: take up half left/right of screen depending on where it currently is  
--> https://github.com/nimdahk/FillX-Windows/blob/master/FillX.ahk ?  
