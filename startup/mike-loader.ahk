; Reads config\* to configure Mi-Ke at startup

#Include %A_Scriptdir%\startup\
#Include quick-starters-loader.ahk


; Configure your env in mike.ini
EDITOR_NAME := ReadMikeIni("core", "editor")
EDITOR := GetQuickStarterInfoByName(EDITOR_NAME)
DOWNLOAD_FOLDER := ReadMikeIni("core", "download-folder", true)
global DEBUG := ReadMikeIni("core", "DEBUG")
Base64Chars = ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/


#Include hotkeys-loader.ahk
#Include keyboard-lockstate.ahk
#Include mike-menu.ahk
