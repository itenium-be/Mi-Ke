---
layout: home
title: Mi-Ke
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
git clone https://github.com/itenium-be/Mi-Ke
cd Mi-Ke

# Start
.\mike.ahk
```

Run `.\init.ps1` to create some personal customization example files.


# The scripts


## Diff 2 files in Windows explorer or the selected text elsewhere

[memory-diff.ahk](https://github.com/itenium-be/Mi-Ke/blob/master/scripts-other/memory-diff.ahk)

{% include kbd k="Control+Win+Left" l="Put selected text in Desktop\left.txt" %}
{% include kbd k="Control+Win+Down" l="Put selected text in Desktop\right.txt and open Diff tool" %}
{% include kbd k="Control+Win+Up" l="Show current clipboard content" %}
{% include kbd k="Control+Win+Right" l="Open Diff tool with current left/right.txt" %}
{% include kbd k="Control+Win+Numpad0" l="Open Diff tool with a Dropbox conflicted file vs the original" %}


## Windows Explorer enhancements

{% include kbd k="AltGr+Win+D" l="Open 2 explorers, one in download folder, one with USB stick" github="scripts-windows-explorer/windows-explorer-copy-download-to-usb" %}

[windows-explorer](https://github.com/itenium-be/Mi-Ke/blob/master/scripts-windows-explorer)

{% include kbd k="2x Esc" l="Close active Explorer window" %}
{% include kbd k="2x Capslock" l="Put full directory of selected file/folder to clipboard" %}
{% include kbd k="2x Shift+Capslock" l="Put full selected filename to clipboard" %}
{% include kbd k="Control+Capslock" l="Open the path currently on the clipboard in Explorer" %}

{% include kbd k="Control+Shift+N" l="New directory (builtin)" %}
{% include kbd k="Control+Shift+F" l="New file" %}
{% include kbd k="Control+Shift+T" l="New txt file" %}

Switch views:  
{% include kbd k="Control+Shift+3" l="View => small icons" %}
{% include kbd k="Control+Shift+4" l="View => three columns" %}
{% include kbd k="Control+Shift+6" l="View => details list" %}


## Start programs with hotkeys

Quick starters are defined in `config\*.yml`  
Default behavior can be overwritten in `config\_custom.yml` (create it by running `init.ps1`)

### Some default configurations

{% include kbd k="Control+Win+C" l="Start calculator (2x esc to close)" %}
```yml
Calculator:
  hotkey: ^#c
  path: <A_WINDIR>\System32\calc.exe
  titleMatcher: ahk_class CalcFrame
  doublePressCloseHotkey: ~ESC
  menu: Applications
```


{% include kbd k="Win+C" l="Start Notepad++" %}

```yml
Notepad++:
  hotkey: "#c"
  path:
    - C:\Program Files (x86)\Notepad++\Notepad++.exe
    - C:\Program Files\Notepad++\Notepad++.exe

  # Open file(s) selected in Windows Explorer.
  passExplorerPathAsArgument: file
  explorerFilesSeparator: \"
  # Need to escape the quote there
  menu: Editors
```

### Example configuration

{% include kbd k="Shift+Win+Alt+P" l="Open PowerShell" %}
```yml
PowerShell (Admin):
  hotkey: +!#p
  titleMatcher: ahk_exe powershell.exe
  path: <A_WINDIR>\System32\WindowsPowerShell\v1.0\powershell.exe
  menu: Consoles

  # When inside Windows Explorer, open in the current path
  passExplorerPathAsArgument: dir
  openWithPathArgs: <exe> -noexit -command "cd '<path>'"

  # RunAs Administrator
  asAdmin: 1
```

{% include kbd k="Alt+Win+R" l="Open PowerShell ISE" %}

```yml
PowerShell ISE:
  hotkey: !#r
  titleMatcher: ahk_exe powershell_ise.exe
  path: <A_WINDIR>\System32\WindowsPowerShell\v1.0\powershell_ise.exe
  menu: Editors

  # When inside Windows Explorer, open the selected files
  passExplorerPathAsArgument: file
  openWithPathArgs: <exe> -file "<path>"
  explorerFilesSeparator: ,
```


## Browsers

[Browser](https://github.com/itenium-be/Mi-Ke/blob/master/scripts-other/browser.ahk)

{% include kbd k="Capslock & W" l="Open browser" %}
{% include kbd k="Capslock & X" l="Google selected text" %}
{% include kbd k="Capslock & A" l="Google selected text + autohotkey" %}
{% include kbd k="Chrome F1" l="Open chrome://extensions in new tab" %}

## change-sound-volume

[Change sound volume](https://github.com/itenium-be/Mi-Ke/blob/master/scripts-other/change-sound-volume.ahk) with 'funny' images.  

{% include kbd k="Win+PgUp" l="Volume +10" %}
{% include kbd k="Win+PgDn" l="Volume -10" %}
{% include kbd k="Win+Ctrl+PgDn/Up" l="Volume +/-10 without images" %}
{% include kbd k="Win+Ctrl+Alt PgDn/Up" l="Volume +/-1 without images" %}
{% include kbd k="Win+End" l="Mute/Restore" %}
{% include kbd k="Win+Home" l="Show sound volume" %}


# Other resources

Looking for even more little productivity boosters?

Look no further!

<ul>
{% include github-stars.html url="ahkscript/awesome-AutoHotkey" %}
{% include github-stars.html url="Drugoy/Autohotkey-scripts-.ahk" %}
{% include github-stars.html url="denolfe/AutoHotkey" %}
{% include github-stars.html url="camerb/AHKs" %}
{% include github-stars.html url="cocobelgica/AutoHotkey-Util" %}
{% include github-stars.html url="jNizM/AHK_Scripts" %}
{% include github-stars.html url="theborg3of5/ahk" %}
</ul>

Developer tooling

<ul>
{% include github-stars.html url="babin101/DevKeyboard" %}
{% include github-stars.html url="7plus/7plus" %}
{% include github-stars.html url="RaptorX/AHK-ToolKit" %}
</ul>


Outside Github:

- [Skrommel scripts](http://www.donationcoder.com/Software/Skrommel/index.html)
	- [GoneIn60s](http://www.donationcoder.com/Software/Skrommel/index.html#GoneIn60s): Recover closed applications
	- [IpUpload](http://www.donationcoder.com/Software/Skrommel/index.html#IpUpload): Upload current IP address to a FTP server
	- [NoClose](http://www.donationcoder.com/Software/Skrommel/index.html#NoClose): Disable the Close button (X) of selected windows
	- [MoveInactiveWin](http://www.donationcoder.com/Software/Skrommel/index.html#MoveInactiveWin): Move a window without activating it
	- [WhatColor](http://www.donationcoder.com/Software/Skrommel/index.html#WhatColor): Show and copy the RRGGBB color under the cursor
- [Jack's Autohotkey Blog](http://www.computoredge.com/AutoHotkey/Free_AutoHotkey_Scripts_and_Apps_for_Learning_and_Generating_Ideas.html)
