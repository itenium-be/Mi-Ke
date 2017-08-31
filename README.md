Mi-Ke
=====
This Mike is not exactly Mycroft Holmes but rather a collection of Autohotkey scripts.

# Why



# Install

%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\

## Executable

Download the zip from the [release tab](https://github.com/Laoujin/Mi-Ke/releases)  
- Extract it
- Run mike.exe
- Much win


## From source

Requires Autohotkey_L

PowerShell:
```ps
git clone https://github.com/Laoujin/Mi-Ke
cd Mi-Ke

# Create an initial setup
.\init.ps1

# Start
.\mike.ahk
```



# The scripts

Two fancy ones:

**Control + Win + Z**: Zips the entire folder, or just the selected files, in Windows Explorer. (apps/windows-explorer-zip-directory)  
**Win + Alt + D**: Minimize all windows on monitor of active Window. Press again to restore. (windows-min-max)  

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


Other resources
---------------
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


TODO
----
Build a script that creates the exe, zipped with the ini files
--> This should be added to releases in Github

- some gui screen with all active hotkeys
- Waiting for windows -> use hwnd for more reliability
- Also check about doing something waiting for other stuff (clipboard, ...)
- Script to create a kramdown table from tabbed data
- Make ctrl+a work when changing filename with f2 (take into account multi line when on desktop:)

Bootloader
- init.ahk/ps1: script to "get started"
- it could check what software is installed on the pc...
- Exercise: New docker, git clone, init.ahk, and it should just work?

Included but not yet bound to a shortcut:  
utilities/base64.ahk  
utilities/eol-convert.ahk  

Disable Left Win going into Metro mode  
TODO: Also disables shortcuts using Win key  
LWin::Return  

Sitez:  
- https://jacksautohotkeyblog.wordpress.com (http://www.computoredge.com/AutoHotkey/Downloads/)
- https://github.com/jNizM/AHK_Scripts

Need to put all config in ini files  
https://autohotkey.com/board/topic/33506-read-ini-file-in-one-go/


Gui Creator?  
https://autohotkey.com/boards/viewtopic.php?f=6&t=303&sid=4f44b6b191c1f6fe0df4f93944c39aa6  
https://github.com/maestrith/GUI_Creator

### Window moving

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
