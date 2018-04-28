; Reads config\* to configure Mi-Ke at startup

#Include %A_Scriptdir%\startup\
#Include quick-starters-loader.ahk


; Configure your env in mike.ini
global EDITOR_NAME := ReadMikeIni("core", "editor")
global EDITOR := GetQuickStarterInfoByName(EDITOR_NAME)
global DOWNLOAD_FOLDER := ReadMikeIni("core", "download-folder", true)
DEBUG := ReadMikeIni("core", "DEBUG")

Base64Chars = ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/


#Include hotkeys-loader.ahk
#Include keyboard-lockstate.ahk
#Include mike-menu.ahk
