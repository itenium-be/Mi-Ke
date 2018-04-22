; Stuff to help during doing Autohotkey :)


DevReloadScript:
Notify("Script Reloaded")
Reload
return


DevListVars:
ListVars
return


DevKeyHistory:
KeyHistory
return


DevListHotkeys:
ListHotkeys
return


DevSuspend:
Suspend
quickStarter := GetQuickStarterInfoByMenuItem()
menuText := GetMenuName(quickStarter)
Menu, Tray, ToggleCheck, %menuText%
return


; Control + S: Auto-reload script when it's saved.
; (we assume the file path is in the Window title)
DevReloadScriptWhenSaved:
if (!WinActive(EDITOR_TITLEMATCHER))
	return

WinGetActiveTitle, winTitle
if (InStr(winTitle, A_Scriptdir))
	Goto DevReloadScript
return


; Capslock & A: Copy and google Autohotkey
BrowserSearchAutohotkey:
clipboard =
Send, ^c
ClipWait, 2
Run, http://www.google.com/search?q=autohotkey+%clipboard%
return
