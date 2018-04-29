CreateQuickStartersMenu(menu, addToMenu := "") {
	; addToMenu: If provided, add to that menu. If not, create a submenu called %menu%

	global quickStarterz
	For index, quickStarter in quickStarterz
	{
		if (quickStarter.menu = menu and quickStarter.active != 0) {
			name := GetMenuName(quickStarter)
			thaLabel := quickStarter.label <> "" ? quickStarter.label : "MenuQuickStarterInfoExecutor"

			addTo := addToMenu ? addToMenu : menu

			Menu, %addTo%, add, %name%, %thaLabel%
			icon := GetMenuIcon(quickStarter)
			if (icon) {
				try {
					Menu, %addTo%, Icon, %name%, %icon%, 1
				} catch {
					a.log("Couldn't load icon for " quickStarter.name, quickStarter.path)
				}
			}
		}
	}

	if !addToMenu
		Menu, tray, Add, %menu%, :%menu%
}


CreateQuickStartersMenuItem(labelName, menu := "Tray") {
	global quickStarterz
	For index, quickStarter in quickStarterz
	{
		if (quickStarter.label = labelName || quickStarter.name = labelName) {
			labelName := GetMenuName(quickStarter)
			thaLabel := quickStarter.label <> "" ? quickStarter.label : "MenuQuickStarterInfoExecutor"
			Menu, %menu%, add, %labelName%, %thaLabel%
			return
		}
	}
}


GetMenuName(quickStarter) {
	name := quickStarter.name
	if quickStarter.hotkey
		name .= "`t" . HotkeyToString(quickStarter.hotkey)
	return, name
}


GetMenuIcon(quickStarter) {
	if (quickStarter.ico and FileExist(quickStarter.ico)) {
		return quickStarter.ico
	} else if (quickStarter.path) {
		path := quickStarter.path
		SplitPath, path, , , OutExtension
		if (OutExtension = "ahk") {
			return %A_AHKPATH%

		} else if (OutExtension = "bat") {
			return %A_WINDIR% "\System32\cmd.exe"

		} else if (FileExist(path)) {
			return %path%
		}
	}
}
