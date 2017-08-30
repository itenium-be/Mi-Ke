#Persistent
#SingleInstance force
SetTitleMatchMode RegEx

; Recommended for new scripts due to its superior speed and reliability.
SendMode Input

; Ensure a consistent starting directory.
SetWorkingDir %A_ScriptDir%

; #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #WinActivateForce
; DetectHiddenWindows, On

; Numlock, Capslock, ScrollLock
; TODO: Put in config... uhoh what have I gotten myself into
SetNumlockState, on
SetNumlockState, AlwaysOn


#Include %A_Scriptdir%\utilities\ini-reader.ahk
EDITOR := ReadMikeIni("core", "editor", true)
BROWSER := ReadMikeIni("core", "browser", true)
BROWSER_NEWFLAG := ReadMikeIni("core", "browser-new-window-flag")

; Load scripts from mike.ini
#Include %A_Scriptdir%\mike-loader.ahk

; ATTN: Do not put shortcuts/hotstrings above the mike-menu
; (or it will show the default menu instead)
#Include %A_Scriptdir%\mike-menu.ahk

#Include %A_Scriptdir%\hotstrings\_start.ahk

; TODO: SetWorkingDir for consistent path in \scripts folder?
; https://autohotkey.com/docs/commands/SetWorkingDir.htm
#Include %A_Scriptdir%\scripts\change-sound-volume.ahk
#Include %A_Scriptdir%\scripts\memory-diff.ahk
#Include %A_Scriptdir%\scripts\quick-start-programs.ahk
#Include %A_Scriptdir%\scripts\snippets.ahk
#Include %A_Scriptdir%\scripts\windows-min-max.ahk

#Include %A_Scriptdir%\scripts\apps\chrome.ahk
#Include %A_Scriptdir%\scripts\apps\windows-cmd.ahk
#Include %A_Scriptdir%\scripts\apps\windows-explorer-builtin.ahk
#Include %A_Scriptdir%\scripts\apps\windows-explorer-copy-download-to-usb.ahk
#Include %A_Scriptdir%\scripts\apps\windows-explorer-zip-directory.ahk
#Include %A_Scriptdir%\scripts\apps\windows-explorer.ahk

#Include %A_Scriptdir%\vendor\WindowPad\source\WindowPad.ahk

#Include %A_Scriptdir%\utilities\windowsexplorer.ahk
#Include %A_Scriptdir%\utilities\notify.ahk

; Debugging:
; Some weird stuff...
; A MsgBox shows when placed below #Include mike-menu but not when placed below #Include personal.ahk..?
; Putting these lines above #Include mike-menu.ahk and the default menu is loaded instead..?
; (is it because of stopping execution after the first "return"?)

DevReloadScript:
;^#r::
Notify("Script Reloaded")
Reload
return

DevListVars:
;!F11::
ListVars
return
