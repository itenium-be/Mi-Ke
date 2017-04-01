Mi-Ke
=====
This Mike is not exactly Mycroft Holmes but rather a collection of Autohotkey scripts.

To learn:
- miles, pounds, feet... (imperial system)
- International Phonetic Alphabet (IPA)

Window mover: resize so not below taskbar or above screen (or left/right:)
Window mover: take away from all the edges a bit
Window mover: center at "semi" full screen
Window mover: for when screen has some weird size: take up half left/right of screen depending on where it currently is

Chrome extension: DevSearch (or DefSearch)
- take over native F3 / Ctrl+F
- if text is selected on the keyboard, put it in automatically
- have dropdownlist with previous search terms
- search case insensitive, with regex (check how sublime text search looks like)
- highlight found keywords whilst they are being typed
- possibility to put overlay screen at the bottom of the page with all matches with some context
- display how many matches on the page
- jump to the first match right away? when no more matches: clear red indication + stay located at last match
--- double clicking on a match/context jumps to that part of the page (+ highlight that entire section on the screen for a moment)
--- would be great if there was a sublime like part at left to indicate where the matches are located on the page
----- or perhaps that can be done on the vertical scrollbar?

TODO: Explorer: shortcut for "list view" (and details view etc? cycle?)
--> List: Control + Shift + 5
--> Details: Control + Shift + 6 --> Make a hotkey anyhow: the name column needs to be made larger so that all filenames are fully visible

Script: memory-diff
-------------------
**Control + Win + Left**: Put selected text in Desktop\left.txt  
**Control + Win + Down**: Put selected text in Desktop\right.txt and open Diff tool  
**Control + Win + Up**: Show current clipboard content  
**Control + Win + Right**: Open Diff tool with current left/right.txt  

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
**Control + Win + C**: Start Cmder  
**Win + C**: Start Notepad++  
**Control + Win + F**: Start FileZilla (or activate existing Window)  
**CapsLock & S**: Start HeidiSql  

Other Scripts
-------------
**Win + Alt + D**: Minimize all windows on monitor of active Window. Press again to restore. (windows-min-max)  
**AltGr + Win + D**: Open 2 explorers, one in download folder, one with USB stick (copy-download-to-usb)  
**Control + Win + X**: Put selected text to clipboard. Convert windows path to Unix style path (path-wintounix)  
**Win + Alt + M**: Put selected text in Markdown code block (md-code-block)
**Control + Win + Alt + M**: Create new Markdown code block (md-code-block)
