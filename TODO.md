---
layout: default
---

# TODO

Interactive debugging?  
https://autohotkey.com/docs/AHKL_DBGPClients.htm

Top Autohotkey directives.. no idea what they do really :)
NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.  
WinActivateForce  

## Script ideas

- Shortcut to open contextmenu (also available from MiKe tray) to open favorite locations
	- With button to go to GitHub, Explorer, IDE
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

gui for managing favourite locations  
can define shortcut for opening location in explorer  
or menu accessible from contextmenu  

Disable Left Win going into Metro mode  
Also disables shortcuts using Win key  
LWin::Return  

## Accessibility

Use a more convention based setup:  
The ini, the labels, the quickstarter variables, they should all match...

Build a script that creates the exe, zipped with the ini files  
--> 2 zips (ahk/exe) should be added to releases in Github

- this readme is too long -> put stuff in gh-pages branch:  
https://stackoverflow.com/questions/31969868/how-to-store-github-wiki-as-part-of-source

disable anything not generic by default (active=0)

- some gui screen with all active hotkeys
- init.ps1 Exercise: New docker, git clone, init.ps1, and it should just work?
	- Check that mike.ahk.lnk works on diff versions of Windows

- apps-windows-explorer: double-tap=1 instead of hardcoded 2x capslock as is now
- label= A HotKey label that should be executed... (could setup same way as hotstrings?)
- If title-matcher is not provided, get the ahk_exe after opening for first time (is title-matcher used atm to )
- <A_PROGRAMFILES>\Robo 3T 1.1.1\robo3t.exe -> support wildcards for versions...

## Quick start programs

- If title matcher is not provided, get the ahk_exe after opening for first time?
- Shortcuts to open services.msc, uninstall software etc...?

## Improvements

- Waiting for windows to start -> use hwnd for more reliability?
- Also check other sleeps, there might be a more reliable way to do it (clipboard, ...)
- The configuration is nice but quick-start-programs will become unwieldly pretty rapidly
	- Some tests are in order there...
	- There is already some weird mapping from ini -> behavior

## Unused snippets

Alot of incredible Autohotkey scripts have been written but unfortunately
most of them are found on the Autohotkey forums which contains only links
to the sources and the downloads are pretty much all broken.

Any script that may not be of use right away should be stored here
as they could come in handy later...

Included but not yet bound to a shortcut:  
utilities/base64.ahk  
utilities/eol-convert.ahk  

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
