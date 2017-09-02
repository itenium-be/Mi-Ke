---
layout: default
---
This Mike is not exactly Mycroft Holmes but rather a collection of Autohotkey scripts.

Two fancy ones:

**Control+Win+Z**: Zips the entire folder, or just the selected files, in Windows Explorer. (apps/windows-explorer-zip-directory)  
**Win+Alt+D**: Minimize all windows on monitor of active Window. Press again to restore. (windows-min-max)  

# What

A script running in the background (tray icon) with little productivity boosters.

- Hotstrings to reduce amount of typing (atm -> at the moment)
- Shortcuts to start programs (win+o -> open solitaire.exe)
- Enhancements to programs (cmd, windows explorer, ...)
- Random scripts to do something I often do (did?) manually

# Install

## From source

Requires [Autohotkey_L](https://autohotkey.com/download).

PowerShell:
```ps
git clone https://github.com/Laoujin/Mi-Ke
cd Mi-Ke

# Create an initial setup with some examples
.\init.ps1

# If you do not want examples run the following instead
# It will create the file(s) required to start only
.\init.ps1 -bare

# Start
.\mike.ahk
```


# The scripts


Script: memory-diff
-------------------
**Control+Win+Left**: Put selected text in Desktop\left.txt  
**Control+Win+Down**: Put selected text in Desktop\right.txt and open Diff tool  
**Control+Win+Up**: Show current clipboard content  
**Control+Win+Right**: Open Diff tool with current left/right.txt  
**Control+Win+Numpad0**: Open Diff tool with a Dropbox conflicted file vs the original  

Script: apps/windows-explorer
-----------------------------
**AltGr+Win+D**: Open 2 explorers, one in download folder, one with USB stick (apps/windows-explorer-copy-download-to-usb)  

**2x Esc**: Close active Explorer window  
**2x Capslock**: Put full directory of selected file/folder to clipboard  
**2x Shift+Capslock**: Put full selected filename to clipboard  
**2x Control+Capslock**: Open the path currently on the clipboard in Explorer  

**Control+Shift+N**: New directory (=Windows shortcut)  
**Control+Shift+F**: New file  
**Control+Shift+T**: New txt file  

**Control+Shift+3**: View => small icons  
**Control+Shift+4**: View => three columns  
**Control+Shift+6**: View => details list  


Script: quick-start-programs
----------------------------
**Control+Win+S**: Start Sublime Text. When in Explorer: Open with active folder in Side Bar.  
**Alt+Win+C**: Start Cmder  
**Control+Win+C**: Start calculator (2x esc to close)  
**Win+C**: Start Notepad++  
**Control+Win+F**: Start FileZilla (or activate existing Window)  
**CapsLock & S**: Start HeidiSql  
**CapsLock & Q**: Start Robomongo  
**Capslock & W**: New Chrome window  
**Capslock & X**: Google selected text  


Other Scripts
-------------
**Chrome F1**: Open chrome://extensions in new tab (apps/chrome.ahk)  

**scripts\snippets.ahk**:  

**Control+Shift+Win+C**: Append to clipboard (append-to-clipboard)  
**Control+Win+X**: Put selected text to clipboard. Convert windows path to Unix style path (path-win-to-unix)  
**Win+Alt+M**: Put selected text in Markdown code block (md-code-block-surround)  
**Control+Win+Alt+M**: Create new Markdown code block (md-code-block-new)  


Script: change-sound-volume
---------------------------
Change sound volume with 'funny' images.  

**Win+PgUp**: Volume +10  
**Win+PgDn**: Volume -10  
**Win+Ctrl+PgDn/Up**: Volume +/-10 without images  
**Win+Ctrl+Alt PgDn/Up**: Volume +/-1 without images  
**Win+End**: Mute/Restore  
**Win+Home**: Show sound volume  


Dev Stuff
---------
**Control+Win+R**: Reload script  
**Shift+F11**: Open ListVars window  
**Alt+F12**: Window Spy  
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
