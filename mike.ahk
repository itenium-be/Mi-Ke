; Global entry point
; Mi-Ke: Be nice to me or I will throw rocks at you

; A few #Include files are not in the git repository
; Create them by running .\init.ps1

; .\hotkeys\_includes.ahk and .\hotstrings\_includes.ahk
; are two entry points you can use to start experimenting.
; Activate/deactivate and configure the scripts in mike.ini

; Reload this script with Control+Win+R for ahk and ini changes to have effect

#Persistent
#SingleInstance force
SetTitleMatchMode RegEx
SendMode Input
SetWorkingDir %A_ScriptDir%

; Configure your env in mike.ini
EDITOR := ReadMikeIni("core", "editor", true)
EDITOR_TITLEMATCHER := ReadMikeIni("core", "editor-title-matcher", true)
BROWSER := ReadMikeIni("core", "browser", true)
BROWSER_NEWFLAG := ReadMikeIni("core", "browser-new-window-flag")

; Load scripts from mike.ini
#Include %A_Scriptdir%\mike-loader.ahk
#Include %A_Scriptdir%\utilities\quick-start-programs-loader.ahk
#Include %A_Scriptdir%\mike-menu.ahk

; All code that needs to be executed
; automatically should be above this

; A place to put your very own scripts!
#Include %A_Scriptdir%\hotkeys\hotkey-loader.ahk
return
#Include %A_Scriptdir%\hotstrings\hotstring-loader.ahk

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
#Include %A_Scriptdir%\utilities\system-info.ahk

; Vendor
#Include %A_Scriptdir%\vendor\WindowPad\source\WindowPad.ahk
#Include %A_Scriptdir%\vendor\notify.ahk
#Include %A_Scriptdir%\vendor\windows-explorer-util.ahk
