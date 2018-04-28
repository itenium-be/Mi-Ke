; Stuff to help during doing Autohotkey :)


DevEmergencyExit:
Notify("Emergency exit!")
ExitApp
return


DevReloadScript:
Notify("Script Reloaded")
Reload
return


DevListVars:
ListVars
return


DevListLines:
ListLines
return


DevKeyHistory:
KeyHistory
return


DevListHotkeys:
ListHotkeys
return


DevSuspend:
Suspend
Notify("Script is now " (A_IsSuspended ? "suspended" : "running"))
quickStarter := GetQuickStarterInfoByLabel("DevSuspend")
menuText := GetMenuName(quickStarter)
Menu, Tray, ToggleCheck, %menuText%
return


; Control + S: Auto-reload script when it's saved.
; (we assume the file path is in the Window title)
DevReloadScriptWhenSaved:
global EDITOR
if (!EDITOR or !WinActive(EDITOR.titleMatcher))
	return

WinGetActiveTitle, winTitle
if (InStr(winTitle, A_Scriptdir))
	Goto DevReloadScript
return
