; The quick-start.programs.ini is read by quick-start-programs-loader.ahk
; which creates hotkeys bound to the labels in these files (QuickStarterInfoExecutor and QuickStarterInfoCloserExecutor)
; The loader converts the ini to "quickStarterz" objects (with props: hotkey, path, active, titleMatcher, ...)
; The QuickStarterInfoExecutor finds the right quickStarter and converts the props to a Run Autohotkey command

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
	;MsgBox %path%
	;Notify("Run", path)
	if (quickStarter.asAdmin and not A_IsAdmin) {
			try {
				; Start as admin with UAC dialog
				Run *RunAs "%path%"
			}
		} else {
			Run %path%
		}
}


BuildHotkeyArgs(quickStarter, selectedFiles := "")
{
	newWindowFlag := quickStarter.newWindowFlag
	if selectedFiles {
		; selectedFiles = current path in Windows Explorer
		; Attempt to pass the path/files as argument to the app to start
		if InStr(newWindowFlag, "<path>") {
			flag := StrReplace(newWindowFlag, "<path>", selectedFiles)

		} else if newWindowFlag {
			flag = %newWindowFlag% %selectedFiles%

		} else {
			flag := selectedFiles
		}

	} else if newWindowFlag {
		flag := newWindowFlag
	}

	if not flag {
		return quickStarter.path
	}
	return quickStarter.path " " flag
}


RunHotkey(quickStarter) {
	if (quickStarter.passExplorerPathAsArgument and WinActive("ahk_class (CabinetWClass|ExploreWClass)"))
	{
		; Start with current Windows Explorer path opened
		if quickStarter.passExplorerPathAsArgument = "dir"
			selected := Explorer_GetPath()
		else {
			if quickStarter.explorerFilesSeparator = """" {
				quickStarter.explorerFilesSeparator := """ """
				Notify(quickStarter.explorerFilesSeparator)
			}
			selected := Explorer_GetSelected("", quickStarter.explorerFilesSeparator)
			if quickStarter.explorerFilesSeparator = """ """ {
				Notify(selected)
				selected := """" selected """"
				Notify(selected)
			}
		}

		toRun := BuildHotkeyArgs(quickStarter, selected)
		RunHotkeyCore(toRun, quickStarter)
		return
	}

	titleMatcher := quickStarter.titleMatcher
	if (titleMatcher and WinExist(titleMatcher)) {
		if quickStarter.newWindowFlag {
			; Open new instance of app
			toRun := BuildHotkeyArgs(quickStarter)
			RunHotkeyCore(toRun, quickStarter)
		} else {
			; Bring the existing window to the front
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
