#Persistent
#SingleInstance force
SetTitleMatchMode RegEx

; Reload script with Control+Win+R (default shortcut)

; Recommended for new scripts due to its superior speed and reliability.
SendMode Input

; Ensure a consistent starting directory.
SetWorkingDir %A_ScriptDir%

; #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #WinActivateForce
; DetectHiddenWindows, On

EDITOR := ReadMikeIni("core", "editor", true)
BROWSER := ReadMikeIni("core", "browser", true)
BROWSER_NEWFLAG := ReadMikeIni("core", "browser-new-window-flag")

; Load scripts from mike.ini
#Include %A_Scriptdir%\mike-loader.ahk
#Include %A_Scriptdir%\utilities\quick-start-programs-loader.ahk
#Include %A_Scriptdir%\mike-menu.ahk

; All code that needs to be executed
; automatically should be above this

; Load hotstrings
#Include %A_Scriptdir%\hotstrings\hotstring-loader.ahk
return

; Scripts
#Include %A_Scriptdir%\scripts\change-sound-volume.ahk
#Include %A_Scriptdir%\scripts\memory-diff.ahk
#Include %A_Scriptdir%\scripts\snippets.ahk
#Include %A_Scriptdir%\scripts\windows-min-max.ahk

#Include %A_Scriptdir%\scripts\apps\autohotkey-debugging.ahk
#Include %A_Scriptdir%\scripts\apps\chrome.ahk
#Include %A_Scriptdir%\scripts\apps\windows-cmd.ahk
#Include %A_Scriptdir%\scripts\apps\windows-explorer-builtin.ahk
#Include %A_Scriptdir%\scripts\apps\windows-explorer-copy-download-to-usb.ahk
#Include %A_Scriptdir%\scripts\apps\windows-explorer-zip-directory.ahk
#Include %A_Scriptdir%\scripts\apps\windows-explorer.ahk

; Utilities
#Include %A_Scriptdir%\utilities\ini-reader.ahk
#Include %A_Scriptdir%\utilities\quick-start-programs.ahk

; Vendor
#Include %A_Scriptdir%\vendor\WindowPad\source\WindowPad.ahk
#Include %A_Scriptdir%\vendor\notify.ahk
#Include %A_Scriptdir%\vendor\windows-explorer-util.ahk
