; quick-start-programs
; WinActive("ahk_class CabinetWClass") or WinActive("ahk_class ExploreWClass")

QuickStarterInfoExecutor:
quickStarter := GetQuickStarterInfo()
if quickStarter
	RunHotkey(quickStarter)
else
	Notify(A_ThisHotkey " not found")
return

GetQuickStarterInfo()
{
	global quickStarterz
	For index, quickStarter in quickStarterz
	{
		if (quickStarter.hotkey = A_ThisHotkey) {
			return quickStarter
		}
	}
}

RunHotkeyCore(path, quickStarter)
{
	;Notify("Run", path)
	if (quickStarter.asAdmin and not A_IsAdmin) {
			try {
				Run *RunAs "%path%"
			}
		} else {
			Run %path%
		}
}


BuildHotkeyArgs(quickStarter, selectedFiles := "")
{
	newWindowFlag := quickStarter.newWindowFlag

	if not selectedFiles {
		return quickStarter.path
	}

	if InStr(newWindowFlag, "<path>") {
		flag := StrReplace(newWindowFlag, "<path>", selectedFiles)
	} else {
		flag = %newWindowFlag% %selectedFiles%
	}
	return quickStarter.path " " flag
}


RunHotkey(quickStarter) {
	if (quickStarter.passExplorerPathAsArgument and WinActive("ahk_class (CabinetWClass|ExploreWClass)"))
	{
		; Start with current Windows Explorer path opened
		if quickStarter.passExplorerPathAsArgument = "dir"
			selected := Explorer_GetPath()
		else
			selected := Explorer_GetSelected()

		toRun := BuildHotkeyArgs(quickStarter, selected)
		RunHotkeyCore(toRun, quickStarter)
		return
	}

	titleMatcher := quickStarter.titleMatcher
	if (titleMatcher and WinExist(titleMatcher)) {
		if quickStarter.newWindowFlag {
			toRun := BuildHotkeyArgs(quickStarter)
			RunHotkeyCore(toRun, quickStarter)
		} else {
			WinActivate
		}
		return
	}

	RunHotkeyCore(quickStarter.path, quickStarter)
}

QuickStarterInfoCloserExecutor:
	If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
		WinClose
	Else
		Send, %A_ThisHotKey%
Return
