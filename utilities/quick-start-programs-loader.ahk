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

			} else if (key = "pathParams") {
				quickStarterInfo.pathParams := value

			} else if (key = "editor" and value = 1) {
				quickStarterInfo.path := EDITOR
				quickStarterInfo.titleMatcher := ReadMikeIni("core", "editor-titleMatcher")
				quickStarterInfo.openWithPathArgs := ReadMikeIni("core", "editor-openWithPathArgs")

			} else if (key = "doublePressCloseHotkey") {
				quickStarterInfo.doublePressCloseHotkey := value

			} else if (key = "titleMatcher") {
				quickStarterInfo.titleMatcher := value

			} else if (key = "active") {
				quickStarterInfo.active := value

			} else if (key = "passExplorerPathAsArgument" and (value = "dir" or value = "file")) {
				quickStarterInfo.passExplorerPathAsArgument := value

			} else if (key = "openWithPathArgs") {
				quickStarterInfo.openWithPathArgs := value

			} else if (key = "asAdmin" and value = 1) {
				quickStarterInfo.asAdmin := true

			} else if (key = "explorerFilesSeparator") {
				quickStarterInfo.explorerFilesSeparator := value

			} else if (key = "menu") {
				quickStarterInfo.menu := value

			} else if (key = "name") {
				quickStarterInfo.name := value

			} else if (key = "label") {
				quickStarterInfo.label := value

			} else {
				Notify("Didn't find key", key "=" value)
			}

		}

		if ((quickStarterInfo.path or quickStarterInfo.label) and quickStarterInfo.active != 0) {
			if (quickStarterInfo.path <> "" and not FileExist(quickStarterInfo.path)) {
				Notify("Path does not exist", quickStarterInfo.path)
			} else if (quickStarterInfo.label <> "" and not IsLabel(quickStarterInfo.label)) {
				Notify("Label does not exist", quickStarterInfo.label)
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
			thaLabel := quickStarterInfo.label <> "" ? quickStarterInfo.label : "QuickStarterInfoExecutor"
			Hotkey, %thaHotkey%, %thaLabel%
		}
	}
}
