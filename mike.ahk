; Global entry point
; Mi-Ke: Be nice to me or I will throw rocks at you

; A few #Include files are not in the git repository
; Create them by running .\init.ps1
; (mike.ahk will not run as long as these files do not exist!)

; .\hotkeys\_includes.ahk and .\hotstrings\_includes.ahk
; are two entry points you can use to start experimenting.
; Activate/deactivate and configure the scripts in config ini and yml files

; Reload this script with Control+Win+R for ahk and ini changes to have effect
; (might happen automatically on Control+S in IDE - see scripts\apps\autohotkey-debugging.ahk)

#Persistent
#SingleInstance force
SetTitleMatchMode RegEx
SendMode Input
SetWorkingDir %A_ScriptDir%

; Configure your env in mike.ini
EDITOR_NAME := ReadMikeIni("core", "editor", true)
EDITOR :=

; Load configuration & Startup stuff
#Include %A_Scriptdir%\startup\mike-loader.ahk

; All code that needs to be executed
; automatically should be above this

; A place to put your very own scripts!
#Include %A_Scriptdir%\hotkeys\hotkey-loader.ahk
return
#Include %A_Scriptdir%\hotstrings\hotstring-loader.ahk

; Startup helpers
#Include %A_Scriptdir%\startup\helpers
#Include quick-starters-exec.ahk
#Include quick-starters-menu.ahk
#Include quick-starters-read-config.ahk

; Scripts
#Include %A_Scriptdir%\scripts\
#Include change-sound-volume.ahk
#Include developer.ahk
#Include memory-diff.ahk
#Include snippets.ahk
#Include windows-min-max.ahk

#Include %A_Scriptdir%\scripts\apps\
#Include autohotkey-debugging.ahk
#Include browsers.ahk
#Include windows-cmd.ahk
#Include windows-explorer-builtin.ahk
#Include windows-explorer-copy-download-to-usb.ahk
#Include windows-explorer-zip-directory.ahk
#Include windows-explorer.ahk

; Utilities
#Include %A_Scriptdir%\utilities\
#Include auto-byte-format.ahk
#Include hotkey-to-string.ahk
#Include ini-reader.ahk
#Include path-replacements.ahk
#Include system-info.ahk

; Vendor
#Include %A_Scriptdir%\vendor\
#Include WindowPad\source\WindowPad.ahk
#Include base64.ahk
#Include Gdip2.ahk
#Include guid.ahk
#Include notify.ahk
#Include windows-explorer-util.ahk
#Include yaml.ahk
