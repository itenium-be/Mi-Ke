; Run quickstarter when pressed a hotkey
QuickStarterInfoExecutor:
	quickStarter := GetQuickStarterInfoByHotkey()
	if quickStarter
		RunHotkey(quickStarter)
	else
		Notify(A_ThisHotkey " not found")
return


; Run quickstarter when clicked a MenuItem
MenuQuickStarterInfoExecutor:
	quickStarter := GetQuickStarterInfoByMenuItem()
	if quickStarter
		RunHotkey(quickStarter)
	else
		Notify(A_ThisMenuItem " not found")
return


; Close app with 2x ESC (or other key)
QuickStarterInfoCloserExecutor:
	If (A_PriorHotKey = A_ThisHotkey and A_TimeSincePriorHotkey < 500)
		WinClose

Return



BuildHotkeyArgs(quickStarter, selected := "") {
	openWithPathArgs := quickStarter.openWithPathArgs
	if (selected and openWithPathArgs) {
		; selected: {path, files} = as currently selected in Windows Explorer (or in Window Title)
		; Attempt to pass the path/files as argument to the app to start

		result := openWithPathArgs
		result := StrReplace(result, "<selectedFiles>", selected.files)
		result := StrReplace(result, "<path>", selected.path)
		result := StrReplace(result, "<exe>", quickStarter.path)
		result := StrReplace(result, "<exeParams>", quickStarter.pathParams)

		return result

	} else if quickStarter.pathParams {
		return quickStarter.path " " PathReplacements(quickStarter.pathParams)
	}

	return quickStarter.path
}


RunHotkey(quickStarter) {
	if (quickStarter.passExplorerPathAsArgument)
	{
		if (WinActive("ahk_class (CabinetWClass|ExploreWClass|Progman|WorkerW)")) {
			; Start with current what is currently selected in Windows Explorer
			selected := {}
			selected.path := Explorer_GetPath()
			if (quickStarter.passExplorerPathAsArgument = "file") {
				selected.files := Explorer_GetSelected("", quickStarter.explorerFilesSeparator)
			}

		} else {
			selected := {}

			WinGetTitle, winTitle, A
			SplitPath, winTitle, name, dir, ext, name_no_ext
			selected.path := dir

			FoundPos := InStr(ext, " ")
			FoundPos := FoundPos = 0 ? 3 : FoundPos
			StringMid, ext, ext, 1, FoundPos - 1

			fullPath := dir "\" name_no_ext "." ext
			if (FileExist(fullPath) and (!quickStarter.openForFiles or Instr(quickStarter.openForFiles, ext))) {
				selected.files := fullPath
			}
		}

		toRun := BuildHotkeyArgs(quickStarter, selected)
		RunHotkeyCore(toRun, quickStarter)
		return
	}

	titleMatcher := quickStarter.titleMatcher
	if (titleMatcher and WinExist(titleMatcher)) {
		; Bring the existing window to the front
		WinActivate
		return
	}

	toRun := BuildHotkeyArgs(quickStarter)
	RunHotkeyCore(toRun, quickStarter)
}


RunHotkeyCore(path, quickStarter) {
	; MsgBox %path%
	; Notify("Run", quickStarter.name "`n" quickStarter.path)
	if (quickStarter.asAdmin and not A_IsAdmin) {
		try {
			; Start as admin with UAC dialog
			Run *RunAs %path%
		}
	} else {
		Run %path%
	}

	if (quickStarter.titleMatcher) {
		WinWait % quickStarter.titleMatcher
	}
	WinActivate
}
