ConvertYamlToQuickStarters(yaml) {
	global quickStarterz

	; TODO: check for double entries

	for key in yaml
	{
		quickStarterInfo := {}
		quickStarterInfo.name := key

		qs := yaml[key]
		quickStarterInfo.hotkey := qs.hotkey
		quickStarterInfo.pathParams := qs.pathParams
		quickStarterInfo.doublePressCloseHotkey := qs.doublePressCloseHotkey
		quickStarterInfo.titleMatcher := qs.titleMatcher
		quickStarterInfo.active := qs.active
		quickStarterInfo.openWithPathArgs := qs.openWithPathArgs
		quickStarterInfo.asAdmin := qs.asAdmin
		quickStarterInfo.explorerFilesSeparator := qs.explorerFilesSeparator
		quickStarterInfo.menu := qs.menu
		quickStarterInfo.label := qs.label
		quickStarterInfo.passExplorerPathAsArgument := qs.passExplorerPathAsArgument
		quickStarterInfo.ico := qs.ico
		quickStarterInfo.context := qs.context

		value := qs.passExplorerPathAsArgument
		if (value <> "" and value <> "dir" and value <> "file") {
			Notify("Unknown value passExplorerPathAsArgument: " value)
		}

		if (qs.path) {
			if qs.path.() {
				; Path array
				Loop % qs.path.()
				{
					path := PathReplacements(qs.path.(A_INDEX))
					if (FileExist(path))
						quickStarterInfo.path := path
				}
			} else {
				; Path string
				quickStarterInfo.path := PathReplacements(qs.path)
			}
		}

		if ((quickStarterInfo.path or quickStarterInfo.label) and quickStarterInfo.active != 0) {
			if (quickStarterInfo.path <> "" and not FileExist(quickStarterInfo.path)) {
				Notify("Path does not exist", quickStarterInfo.path)
			} else if (quickStarterInfo.label <> "" and not IsLabel(quickStarterInfo.label)) {
				Notify("Label '" quickStarterInfo.label "' does not exist", quickStarterInfo.name)
			} else {
				quickStarterz.Push(quickStarterInfo)

				if (quickStarterInfo.doublePressCloseHotkey and quickStarterInfo.titleMatcher) {
					; Double press close app
					ahkClass := quickStarterInfo.titleMatcher

					Hotkey, IfWinActive, %ahkClass%
					thaHotkey := quickStarterInfo.doublePressCloseHotkey
					Hotkey, %thaHotkey%, QuickStarterInfoCloserExecutor
					Hotkey, IfWinActive
				}

				; Notify(quickStarterInfo.hotkey " => " quickStarterInfo.path)
				; Notify(quickStarterInfo.doublePressCloseHotkey " => " quickStarterInfo.path)

				thaHotkey := quickStarterInfo.hotkey
				if (thaHotkey) {
					thaLabel := quickStarterInfo.label <> "" ? quickStarterInfo.label : "QuickStarterInfoExecutor"

					if (quickStarterInfo.context) {
						context := TranslateIfWinActive(quickStarterInfo.context)
						Hotkey, IfWinActive, %context%
					}

					Hotkey, %thaHotkey%, %thaLabel%

					if (quickStarterInfo.context) {
						Hotkey, IfWinActive
					}
				}
			}
		}
	}
}


TranslateIfWinActive(context) {
	if (context = "explorer") {
		return "ahk_class (CabinetWClass|ExploreWClass)"
	}

	return context
}
