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
a.log("DEBUG: " DEBUG "`nEDITOR_NAME: " EDITOR_NAME "`nDOWNLOAD_FOLDER: " DOWNLOAD_FOLDER)
; a.show()


Base64Chars = ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/


#Include hotkeys-loader.ahk
#Include keyboard-lockstate.ahk
#Include mike-menu.ahk
