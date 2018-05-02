; Reads config\* to configure Mi-Ke at startup

#Include %A_Scriptdir%\startup\

global a :=
Class_Console("a", 100, 100, 900, 700)

#Include quick-starters-loader.ahk

; Configure your env in mike.ini
global EDITOR_NAME := ReadMikeIni("core", "editor")
global EDITOR := GetQuickStarterInfoByName(EDITOR_NAME)
global DOWNLOAD_FOLDER := ReadMikeIni("core", "download-folder", true)
DEBUG := ReadMikeIni("core", "DEBUG")


a.log(GetSystemInformation())
; TODO: Add Autohotkey path & version
; Uptime in days also
; A_AhkVersion, A_AhkPath
; A_AppData & A_StartMenu & A_Startup
a.log("DEBUG: " DEBUG "`nEDITOR_NAME: " EDITOR_NAME "`nDOWNLOAD_FOLDER: " DOWNLOAD_FOLDER)
; a.show()

; TODO: followedBy should have a timeout
; Notify("Timed out, press " A_Hotkey " again to try again")
; Also ESC should always be accepted to cancel it

; Discoverability:
; Press the AppsKey, Windows, ... and when pressed for a while, display the options...

; Configurable?
; AppsKey => Dev tools
; Windows => Custom scripts
; Alt + F5-12 => Autohotkey
; --> And then a starter info stuffy, start with one of these keys to figure out more
; --> Could print that to a different console perhaps?

; But obviously we need a GUI to do that editing...


Base64Chars = ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/


#Include hotkeys-loader.ahk
#Include keyboard-lockstate.ahk
#Include mike-menu.ahk
