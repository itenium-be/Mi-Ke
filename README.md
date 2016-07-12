Mi-Ke
=====
This Mike is not exactly Mycroft Holmes but rather a collection of Autohotkey scripts.


Script: memory-diff
-------------------
**Control + Win + Left**: Put selected text in Desktop\left.txt  
**Control + Win + Down**: Put selected text in Desktop\right.txt and open Diff tool  

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
**Win + End**: Mute  
**Win + Home**: Show sound volume  

Combine with `Control` to skip the images.


Script: quick-start-programs
----------------------------
**Control + Win + S**: Start Sublime Text. When in Explorer: Open with active folder in Side Bar.  
**Control + Win + C**: Start Cmder  
**Win + C**: Start Notepad++  
**Control + Win + F**: Start FileZilla (or activate existing Window)


Other Scripts
-------------
**AltGr + Win + D**: Open 2 explorers, one in download folder, one with USB stick (copy-download-to-usb)  
**Control + Win + X**: Put selected text to clipboard. Convert windows path to Unix style path (path-wintounix)  
