; Stuff to help during doing Autohotkey :)


DevEmergencyExit:
Suspend, Permit
Notify("Emergency exit!")
ExitApp
return


lastDynaRun :=

DynaRun:
Suspend, Permit
clipVal := CopyAndSaveClip()

dynaRunName = Dynarun
if (lastDynaRun) {
	Process, Exist, %lastDynaRun%
	if (ErrorLevel > 0) {
		MsgBox, 4, Existing DynaRun, Replace last DynaRun?`nYes: Replace instance.`nNo: New instance., 1
		IfMsgBox, No
		{
			Random, rnd, 1, 100
			dynaRunName .= rnd
		}
		else
		{
			Process, Close, %lastDynaRun%
		}
	}
}

lastDynaRun := DynaRun(clipVal, dynaRunName)
RestoreClip()
return


DevReloadScript:
Suspend, Permit
Notify("Script Reloaded")
Reload
return


DevListVars:
Suspend, Permit
ListVars
return


DevListLines:
Suspend, Permit
ListLines
return


DevKeyHistory:
Suspend, Permit
KeyHistory
return


DevListHotkeys:
Suspend, Permit
ListHotkeys
return


OpenConsoleLogWindow:
Suspend, Permit
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
Suspend, Permit
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
