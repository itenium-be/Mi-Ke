; Reads config\* to configure Mi-Ke at startup

#Include %A_Scriptdir%\startup\
#Include quick-starters-loader.ahk


; Default editor/IDE
For index, quickStarter in quickStarterz
{
	if (quickStarter.name = EDITOR_NAME) {
		EDITOR := quickStarter
	}
}


#Include hotkeys-loader.ahk
#Include keyboard-lockstate.ahk
#Include mike-menu.ahk
