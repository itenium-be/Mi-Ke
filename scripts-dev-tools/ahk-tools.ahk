; Stuff to help during doing Autohotkey :)


DevEmergencyExit:
Notify("Emergency exit!")
ExitApp
return


DynaRun:
clipVal := CopyAndSaveClip()
DynaRun(clipVal, "Dynarun")
RestoreClip()
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


OpenConsoleLogWindow:
a.show()
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


; TODO: If ahk AND ico files are selected, pass like:
; Ahk2Exe.exe /in "MyScript.ahk" /icon "MyIcon.ico"
ConvertAhkToExe:
qs := GetQuickStarterInfoByLabel("ConvertAhkToExe")

selectedFiles := Explorer_GetSelectedArray()
selectedFile := selectedFiles[1]
if (selectedFile) {
	Run % qs.path " /in """ selectedFile """"
} else {
	Run % qs.path
}
return
