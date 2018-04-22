; The quick-start.programs.ini is read by quick-start-programs-loader.ahk
; which creates hotkeys bound to the labels in these files (QuickStarterInfoExecutor and QuickStarterInfoCloserExecutor)
; The loader converts the ini to "quickStarterz" objects (with props: hotkey, path, active, titleMatcher, ...)
; The QuickStarterInfoExecutor finds the right quickStarter and converts the props to a Run Autohotkey command

QuickStarterInfoExecutor:
quickStarter := GetQuickStarterInfoByHotkey()
if quickStarter
	RunHotkey(quickStarter)
else
	Notify(A_ThisHotkey " not found")
return

MenuQuickStarterInfoExecutor:
quickStarter := GetQuickStarterInfoByMenuItem()
if quickStarter
	RunHotkey(quickStarter)
else
	Notify(A_ThisMenuItem " not found")
return

GetQuickStarterInfoByHotkey()
{
	global quickStarterz
	For index, quickStarter in quickStarterz
	{
		if (quickStarter.hotkey = A_ThisHotkey) {
			return quickStarter
		}
	}
}

GetQuickStarterInfoByMenuItem()
{
	global quickStarterz
	For index, quickStarter in quickStarterz
	{
		name := GetMenuName(quickStarter)
		if (name = A_ThisMenuItem) {
			return quickStarter
		}
	}
}


CreateQuickStartsMenuItem(menu, name)
{
	global quickStarterz
	For index, quickStarter in quickStarterz
	{
		if (quickStarter.name = name) {
			name := GetMenuName(quickStarter)
			Menu, %menu%, add, %name%, MenuQuickStarterInfoExecutor
			return
		}
	}
}

CreateMenuItemFromIni(iniName, name)
{
	hotkey := ReadMikeIni(iniName, "hotkey")
	if hotkey
		name .= "`t" . HotkeyToString(hotkey)

	Menu, Tray, Add, %name%, %iniName%
}

GetMenuName(quickStarter)
{
	name := quickStarter.name
	if quickStarter.hotkey
		name .= "`t" . HotkeyToString(quickStarter.hotkey)
	return, name
}

CreateQuickStartersMenu(menu)
{
	global quickStarterz
	For index, quickStarter in quickStarterz
	{
		if (quickStarter.menu = menu and quickStarter.active) {
			addMenu = true
			name := GetMenuName(quickStarter)
			Menu, %menu%, add, %name%, MenuQuickStarterInfoExecutor
		}
	}

	if addMenu
		Menu, tray, Add, %menu%, :%menu%
}

HotkeyToString(hotkey)
{
	StringUpper, hotkey, hotkey
	StringReplace, hotkey, hotkey, +, Shift +
	StringReplace, hotkey, hotkey, !, Alt +
	StringReplace, hotkey, hotkey, ^, Control +
	StringReplace, hotkey, hotkey, #, Win +
	StringReplace, hotkey, hotkey, &, &&
	return hotkey
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
			WinActivate
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
				selected := """" selected """"
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
