; Global entry point
; Mi-Ke: Be nice to me or I will throw rocks at you

; A few #Include files are not in the git repository
; Create them by running .\init.ps1
; (mike.ahk will not run as long as these files do not exist!)

; .\hotkeys\_includes.ahk and .\hotstrings\_includes.ahk
; are two entry points you can use to start experimenting.
; Activate/deactivate and configure the scripts in config\mike.ini and _custom.yml files

; Reload this script with Control+Win+R for ahk and ini changes to have effect
; (might happen automatically on Control+S in IDE - see scripts\apps\autohotkey-debugging.ahk)

#Persistent
#SingleInstance force
SetTitleMatchMode RegEx
SendMode Input
SetWorkingDir %A_ScriptDir%

; Configure your env in mike.ini
EDITOR_NAME := ReadMikeIni("core", "editor")
EDITOR :=
DOWNLOAD_FOLDER := ReadMikeIni("core", "download-folder", true)
global DEBUG := ReadMikeIni("core", "DEBUG")
Base64Chars = ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/

; Load configuration & Startup stuff
#Include %A_Scriptdir%\startup\mike-loader.ahk

; All code that needs to be executed
; automatically should be above this

; https://github.com/cocobelgica/AutoHotkey-Util/blob/master/Include.ahk
; TODO: load everything below here dynamically... ?
; lorem ipsum


; ------------------------------------------------------ USER SPACE
; A place to put your very own scripts!
; Put your personal customization here:
#Include %A_Scriptdir%\hotkeys\hotkey-loader.ahk
return
#Include %A_Scriptdir%\hotstrings\hotstring-loader.ahk
; ------------------------------------------------------ USER SPACE

; Startup helpers
#Include %A_Scriptdir%\startup\helpers
#Include quick-starters-exec.ahk
#Include quick-starters-menu.ahk
#Include quick-starters-read-config.ahk

; ------------------------------------------------------- THE SCRIPTS
#Include %A_Scriptdir%\scripts-dev-tools\
#Include ahk-tools.ahk
#Include base64.ahk
#Include eol-convert.ahk
#Include guids.ahk
#Include md-tools.ahk
#Include path-win-to-unix.ahk
#Include text-transform.ahk
#Include uri-encode.ahk
#Include windows-cmd.ahk

#Include %A_Scriptdir%\scripts-other\
#Include browsers.ahk
#Include change-sound-volume.ahk
#Include clipboard.ahk
#Include memory-diff.ahk
#Include windows-min-max.ahk

#Include %A_Scriptdir%\scripts-windows-explorer\
#Include windows-explorer-util.ahk
#Include windows-explorer-builtin.ahk
#Include windows-explorer-copy-download-to-usb.ahk
#Include windows-explorer-zip-directory.ahk
#Include windows-explorer.ahk
#Include image-dimensions.ahk


; Utilities
#Include %A_Scriptdir%\utilities\
#Include auto-byte-format.ahk
#Include clipboard-copy-restore.ahk
#Include hotkey-to-string.ahk
#Include ini-reader.ahk
#Include path-replacements.ahk
#Include system-info.ahk

; Vendor
#Include %A_Scriptdir%\vendor\
#Include WindowPad\source\WindowPad.ahk
#Include Gdip2.ahk
#Include notify.ahk
#Include yaml.ahk
