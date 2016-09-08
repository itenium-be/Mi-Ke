#Persistent
#SingleInstance force
SetTitleMatchMode RegEx

; Recommended for new scripts due to its superior speed and reliability.
SendMode Input

; #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #WinActivateForce
; SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; DetectHiddenWindows, On

; Numlock, Capslock, ScrollLock
SetNumlockState, on
SetNumlockState, AlwaysOn

#Include mike-menu.ahk

#Include hotstrings\personal.ahk
#Include hotstrings\misc.ahk

#Include scripts\change-sound-volume.ahk
#Include scripts\memory-diff.ahk
#Include scripts\path-wintounix.ahk
#Include scripts\copy-download-to-usb.ahk
#Include scripts\zip-directory.ahk
#Include scripts\md-code-block.ahk
#Include scripts\windows-min-max.ahk

#Include scripts\quick-start-programs.ahk
#Include scripts\windowsexplorer.ahk

#Include scripts\WindowPad\source\WindowPad.ahk
#Include utilities\windowsexplorer.ahk
#Include utilities\notify.ahk

; Debugging:
; Some weird stuff...
; A MsgBox shows when placed below #Include mike-menu but not when placed below #Include personal.ahk..?
; Putting these 2 lines above #Include mike-menu.ahk and the default menu is loaded instead..?
!F11::ListVars
^#r::Reload