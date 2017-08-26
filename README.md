Mi-Ke
=====
This Mike is not exactly Mycroft Holmes but rather a collection of Autohotkey scripts.

TODO
----
- Copy path and open explorer with path
- in file dialog, the path should not be selected

Window mover: resize so not below taskbar or above screen (or left/right:)
Window mover: take away from all the edges a bit
Window mover: center at "semi" full screen
Window mover: for when screen has some weird size: take up half left/right of screen depending on where it currently is

Script: memory-diff
-------------------
**Control + Win + Left**: Put selected text in Desktop\left.txt  
**Control + Win + Down**: Put selected text in Desktop\right.txt and open Diff tool  
**Control + Win + Up**: Show current clipboard content  
**Control + Win + Right**: Open Diff tool with current left/right.txt  
**Control + Win + Numpad0**: Open Diff tool with a Dropbox conflicted file vs the original  

**Configuration**: left.txt, right.txt and Diff tool path  


Script: zip-directory
---------------------
**Control + Win + Z**: Zips the entire folder, or just the selected files, in Windows Explorer  

**Configuration**: Path to 7zip.exe  
**Dependencies**: utilities/windowsexplorer.ahk


Script: windowsexplorer
-----------------------
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

**Dependencies**: utilities/windowsexplorer.ahk


Script: change-sound-volume
---------------------------
Change sound volume with 'funny' images.  

**Win + PgUp**: Volume +10  
**Win + PgDn**: Volume -10  
**Win + Ctrl + PgDn/Up: Volume +/-10 without images  
**Win + Ctrl + + Alt PgDn/Up: Volume +/-1 without images  
**Win + End**: Mute/Restore  
**Win + Home**: Show sound volume  


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
**Win + Alt + D**: Minimize all windows on monitor of active Window. Press again to restore. (windows-min-max)  
**AltGr + Win + D**: Open 2 explorers, one in download folder, one with USB stick (copy-download-to-usb)  
**Control + Win + X**: Put selected text to clipboard. Convert windows path to Unix style path (path-wintounix)  
**Win + Alt + M**: Put selected text in Markdown code block (md-code-block)  
**Control + Win + Alt + M**: Create new Markdown code block (md-code-block)  

In app scripts
--------------
**Chrome F1**: Open chrome://extensions in new tab (apps/chrome.ahk)  
**Chrome Alt + Left/Right**: Builtin for history.back/forward(). Reinstated Backspace. (apps/chrome.ahk)  

Dev Stuff
---------
**Control + Win + R**: Reload script  
**Shift + F11**: Open ListVars window  
