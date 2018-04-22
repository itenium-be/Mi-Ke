TODO
====

**Usually this stuff should be posted here:**  
https://github.com/itenium-be/Mi-Ke/issues

```
Print dates in interesting formats  
--> Timestamp a selected file?

https://autohotkey.com/docs/Hotstrings.htm  
:*:]d::  ; This hotstring replaces "]d" with the current date and time via the commands below.  
FormatTime, CurrentDateTime,, M/d/yyyy h:mm tt  ; It will look like 9/1/2005 3:53 PM  
SendInput %CurrentDateTime%  
Calculate current week nr
```

Other custom libraries
----------------------

https://github.com/theborg3of5/ahk
- dateTime.ahk - generate dates / sql server & other dbs, ...
- debug.ahk - generate form with keys pressed etc?
- saveClipboardToFile, readFileToClipboard, 
- mainConfig loadSettingFromFile has an IniObject which might be what I need for the hotkeys?
- launch.ahk: openAllSites ..
- screen.ahk: alwaysontop, enable with mouse, hibernate shortcut..., centerWindow, ...

https://autohotkey.com/docs/scripts/


https://github.com/lipkau/7plus
--> https://code.google.com/archive/p/7plus/wikis/Features.wiki

https://github.com/RaptorX/AHK-ToolKit
--> Guis to create hotkeys and hotstrings

https://github.com/ewerybody/a2
--> 800 commits...


## Script ideas

Disable Left Win going into Metro mode  
Also disables shortcuts using Win key  
LWin::Return  


## Unused snippets

Alot of incredible Autohotkey scripts have been written but unfortunately
most of them are found on the Autohotkey forums which contains only links
to the sources and the downloads are pretty much all broken.


Gui Creator?  
https://autohotkey.com/boards/viewtopic.php?f=6&t=303&sid=4f44b6b191c1f6fe0df4f93944c39aa6  
https://github.com/maestrith/GUI_Creator

## Window moving

https://github.com/ahkscript/awesome-AutoHotkey#window-management

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
