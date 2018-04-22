quickStarterz := []

Loop, 1000 {
	sectionName = qs%A_Index%

	ini = %A_Scriptdir%\config\quick-start-programs.ini
	IfNotExist %ini%
		ini = %A_Scriptdir%\config\quick-start-programs.default.ini

	IniRead, quickStarter, %ini%, %sectionName%
	if (quickStarter = "ERROR") {
		break

	} else {
		quickStarterInfo := {}

		Loop, parse, quickStarter, `n
		{
			StringSplit, keyValue, A_LoopField, =
			key := keyValue1
			value := keyValue2

			; quickStarterInfo.sectionName = %sectionName%
			if (key = "hotkey") {
				quickStarterInfo.hotkey := value

			} else if (key = "path") {
				if FileExist(FileReplacements(value))
					quickStarterInfo.path := FileReplacements(value)

			} else if (key = "editor" and value = 1) {
				quickStarterInfo.path := EDITOR
				quickStarterInfo.titleMatcher := ReadMikeIni("core", "editor-title-matcher")
				quickStarterInfo.newWindowFlag := ReadMikeIni("core", "editor-new-window-flag")

			} else if (key = "double-press-closes") {
				quickStarterInfo.doublePressCloseHotkey := value

			} else if (key = "title-matcher") {
				quickStarterInfo.titleMatcher := value

			} else if (key = "active") {
				quickStarterInfo.active := value

			} else if (key = "explorer-path-flag" and (value = "dir" or value = "file")) {
				quickStarterInfo.passExplorerPathAsArgument := value

			} else if (key = "new-window-flag") {
				quickStarterInfo.newWindowFlag := value

			} else if (key = "elevate" and value = 1) {
				quickStarterInfo.asAdmin := true

			} else if (key = "explorer-files-separator") {
				quickStarterInfo.explorerFilesSeparator := value

			} else if (key = "menu") {
				quickStarterInfo.menu := value

			} else if (key = "name") {
				quickStarterInfo.name := value
			}
		}

		if (quickStarterInfo.hotkey and quickStarterInfo.path and quickStarterInfo.active != 0) {
			if not FileExist(quickStarterInfo.path) {
				Notify("Path does not exist", quickStarterInfo.path)
			}

			quickStarterz.Push(quickStarterInfo)

			if (quickStarterInfo.doublePressCloseHotkey and quickStarterInfo.titleMatcher) {
				ahkClass := quickStarterInfo.titleMatcher
				Hotkey, IfWinActive, %ahkClass%

				thaHotkey := quickStarterInfo.doublePressCloseHotkey
				Hotkey, %thaHotkey%, QuickStarterInfoCloserExecutor

				Hotkey, IfWinActive
			}

			; Notify(quickStarterInfo.hotkey " => " quickStarterInfo.path)
			; Notify(quickStarterInfo.doublePressCloseHotkey " => " quickStarterInfo.path)

			thaHotkey := quickStarterInfo.hotkey
			Hotkey, %thaHotkey%, QuickStarterInfoExecutor
		}
	}
}
