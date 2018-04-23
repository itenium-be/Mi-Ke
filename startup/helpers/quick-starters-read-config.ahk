ConvertYamlToQuickStarters(yamlFile) {
	global quickStarterz

	content := Yaml(yamlFile)
	; Notify("aargh", content.Dump())

	for key in content
	{
		quickStarterInfo := {}
		quickStarterInfo.name := key

		qs := content[key]
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

		value := qs.passExplorerPathAsArgument
		if (value <> "" and value <> "dir" and value <> "file") {
			Notify("Unknown value passExplorerPathAsArgument: " value)
		}

		if (qs.path) {
			if qs.path.() {
				; Path array
				Loop % qs.path.()
				{
					path := FileReplacements(qs.path.(A_INDEX))
					if (FileExist(path))
						quickStarterInfo.path := path
				}
			} else {
				; Path string
				quickStarterInfo.path := FileReplacements(qs.path)
			}
		}

		if (qs.editor = 1) {
			quickStarterInfo.path := EDITOR
			quickStarterInfo.titleMatcher := ReadMikeIni("core", "editor-titleMatcher")
			quickStarterInfo.openWithPathArgs := ReadMikeIni("core", "editor-openWithPathArgs")
		}


		if ((quickStarterInfo.path or quickStarterInfo.label) and quickStarterInfo.active != 0) {
			if (quickStarterInfo.path <> "" and not FileExist(quickStarterInfo.path)) {
				Notify("Path does not exist", quickStarterInfo.path)
			} else if (quickStarterInfo.label <> "" and not IsLabel(quickStarterInfo.label)) {
				Notify("Label does not exist", quickStarterInfo.label)
			} else {
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
				if (thaHotkey) {
					thaLabel := quickStarterInfo.label <> "" ? quickStarterInfo.label : "QuickStarterInfoExecutor"
					Hotkey, %thaHotkey%, %thaLabel%
				}
			}
		}
	}
}
