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


RunHotkey(quickStarter) {
	path := quickStarter.path
	titleMatcher := quickStarter.titleMatcher
	newWindowFlag := quickStarter.newWindowFlag

	if (quickStarter.passExplorerPathAsArgument and WinActive("ahk_class (CabinetWClass|ExploreWClass)"))
	{
		; Start with current Windows Explorer path opened
		if quickStarter.passExplorerPathAsArgument = "dir"
			selected := Explorer_GetPath()
		else
			selected := Explorer_GetSelected()

		if InStr(newWindowFlag, "<path>") {
			flag := StrReplace(newWindowFlag, "<path>", selected)
		} else {
			flag = %newWindowFlag% %selected%
		}
		Run %path% %flag%
		return
	}

	if (titleMatcher and WinExist(titleMatcher)) {
		if newWindowFlag {
			Run %path% %newWindowFlag%
		} else {
			WinActivate
		}
		return
	}

	; Notify("Run", path)
	Run %path%
	; WinActivate
}

QuickStarterInfoCloserExecutor:
	If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
		WinClose
	Else
		Send, {Esc}
Return
