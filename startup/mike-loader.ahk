; Reads config\* to configure Mi-Ke at startup

#Include %A_Scriptdir%\startup\
#Include quick-starters-loader.ahk


; Default editor/IDE
EDITOR := GetQuickStarterInfoByName(EDITOR_NAME)


#Include hotkeys-loader.ahk
#Include keyboard-lockstate.ahk
#Include mike-menu.ahk
