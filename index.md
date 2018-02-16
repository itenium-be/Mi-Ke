---
layout: home
title: test
---

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
```bash
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


## Diff 2 files in Windows explorer or the selected text elsewhere

[scripts/memory-diff.ahk](https://github.com/Laoujin/Mi-Ke/blob/master/scripts/memory-diff.ahk)

{% include kbd k="Control+Win+Left" l="Put selected text in Desktop\left.txt" %}
{% include kbd k="Control+Win+Down" l="Put selected text in Desktop\right.txt and open Diff tool" %}
{% include kbd k="Control+Win+Up" l="Show current clipboard content" %}
{% include kbd k="Control+Win+Right" l="Open Diff tool with current left/right.txt" %}
{% include kbd k="Control+Win+Numpad0" l="Open Diff tool with a Dropbox conflicted file vs the original" %}


## Windows Explorer enhancements

{% include kbd k="AltGr+Win+D" l="Open 2 explorers, one in download folder, one with USB stick" github="apps/windows-explorer-copy-download-to-usb" %}

[scripts/apps/windows-explorer](https://github.com/Laoujin/Mi-Ke/blob/master/scripts/apps/windows-explorer.ahk)

{% include kbd k="2x Esc" l="Close active Explorer window" %}
{% include kbd k="2x Capslock" l="Put full directory of selected file/folder to clipboard" %}
{% include kbd k="2x Shift+Capslock" l="Put full selected filename to clipboard" %}
{% include kbd k="2x Control+Capslock" l="Open the path currently on the clipboard in Explorer" %}

{% include kbd k="Control+Shift+N" l="New directory (builtin)" %}
{% include kbd k="Control+Shift+F" l="New file" %}
{% include kbd k="Control+Shift+T" l="New txt file" %}

Switch views:  
{% include kbd k="Control+Shift+3" l="View => small icons" %}
{% include kbd k="Control+Shift+4" l="View => three columns" %}
{% include kbd k="Control+Shift+6" l="View => details list" %}


## Start programs with hotkeys

What quick starters are currently active is configured in [quick-start-programs.ini](https://github.com/Laoujin/Mi-Ke/blob/master/quick-start-programs.default.ini)

If you do not have a custom `quick-start-programs.ini`, the default shortcuts as defined in `quick-start-programs.default.ini` will be loaded.

### Some default configurations

{% include kbd k="Control+Win+C" l="Start calculator (2x esc to close)" %}
```ini
hotkey=^#c
path=<A_WINDIR>\System32\calc.exe
double-press-closes=ESC
```


{% include kbd k="Win+C" l="Start Notepad++" %}

```ini
hotkey=#c
path=C:\Program Files (x86)\Notepad++\Notepad++.exe

; Open file(s) selected in Windows Explorer.
explorer-path-flag=file
explorer-files-separator="
```

### Example configuration

{% include kbd k="Alt+Win+R" l="Open PowerShell" %}
```ini
hotkey=!#r
title-matcher=ahk_exe powershell.exe
path=<A_WINDIR>\System32\WindowsPowerShell\v1.0\powershell.exe

; When inside Windows Explorer, open in the current path
explorer-path-flag=dir
new-window-flag=-noexit -command "cd '<path>'"

; RunAs Administrator
elevate=1
```

{% include kbd k="Control+Shift+R" l="Open PowerShell ISE" %}

```ini
hotkey=^+R
title-matcher=ahk_exe powershell_ise.exe
path=<A_WINDIR>\System32\WindowsPowerShell\v1.0\powershell_ise.exe

; When inside Windows Explorer, open the selected files
explorer-path-flag=file
new-window-flag=-file "<path>"
explorer-files-separator=,
```


## Other Scripts

[Chrome](https://github.com/Laoujin/Mi-Ke/blob/master/scripts/apps/chrome.ahk)

{% include kbd k="Chrome F1" l="Open chrome://extensions in new tab" %}
{% include kbd k="Capslock & W" l="New Chrome window" %}
{% include kbd k="Capslock & X" l="Google selected text" %}

[scripts\snippets.ahk](https://github.com/Laoujin/Mi-Ke/blob/master/scripts/snippets.ahk)

{% include kbd k="Control+Shift+Win+C" l="Append to clipboard" %}
{% include kbd k="Control+Win+X" l="Put selected text to clipboard. Convert windows path to Unix style path" %}
{% include kbd k="Win+Alt+M" l="Put selected text in Markdown code block" %}
{% include kbd k="Control+Win+Alt+M" l="Create new Markdown code block" %}


## change-sound-volume

[Change sound volume](https://github.com/Laoujin/Mi-Ke/blob/master/scripts/change-sound-volume.ahk) with 'funny' images.  

{% include kbd k="Win+PgUp" l="Volume +10" %}
{% include kbd k="Win+PgDn" l="Volume -10" %}
{% include kbd k="Win+Ctrl+PgDn/Up" l="Volume +/-10 without images" %}
{% include kbd k="Win+Ctrl+Alt PgDn/Up" l="Volume +/-1 without images" %}
{% include kbd k="Win+End" l="Mute/Restore" %}
{% include kbd k="Win+Home" l="Show sound volume" %}


Dev Stuff
---------

[apps/autohotkey-debugging.ahk](https://github.com/Laoujin/Mi-Ke/blob/master/scripts/apps/autohotkey-debugging.ahk)

{% include kbd k="Control+Win+R" l="Reload script" %}
{% include kbd k="Shift+F11" l="Open ListVars window" %}
{% include kbd k="Alt+F12" l="Window Spy" %}
{% include kbd k="Capslock & A" l="Google selected text + autohotkey" %}


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
