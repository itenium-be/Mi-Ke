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
BROWSER_NEWFLAG := ReadMikeIni("core", "browser-new-window-flag", false)

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
#Include %A_Scriptdir%\scripts\path-wintounix.ahk
#Include %A_Scriptdir%\scripts\copy-download-to-usb.ahk
#Include %A_Scriptdir%\scripts\zip-directory.ahk
#Include %A_Scriptdir%\scripts\md-code-block.ahk
#Include %A_Scriptdir%\scripts\windows-min-max.ahk
#Include %A_Scriptdir%\scripts\quick-start-programs.ahk
#Include %A_Scriptdir%\scripts\windowsexplorer.ahk
#Include %A_Scriptdir%\scripts\WindowPad\source\WindowPad.ahk
#Include %A_Scriptdir%\scripts\snippets.ahk

#Include %A_Scriptdir%\scripts\apps\chrome.ahk
#Include %A_Scriptdir%\scripts\apps\cmd.ahk

#Include %A_Scriptdir%\utilities\windowsexplorer.ahk
#Include %A_Scriptdir%\utilities\notify.ahk

; Debugging:
; Some weird stuff...
; A MsgBox shows when placed below #Include mike-menu but not when placed below #Include personal.ahk..?
; Putting these 2 lines above #Include mike-menu.ahk and the default menu is loaded instead..?
!F11::ListVars

^#r::
Notify("Script Reloaded")
Reload
return

; Disable Left Win going into Metro mode
; TODO: Also disables shortcuts using Win key
; LWin::Return
