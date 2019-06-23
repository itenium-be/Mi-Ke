ConvertYamlToQuickStarters(yaml) {
	global quickStarterz

	for key in yaml
	{
		quickStarterInfo := {}
		quickStarterInfo.name := key

		qs := yaml[key]
		quickStarterInfo.hotkey := qs.hotkey
		quickStarterInfo.desc := qs.desc
		quickStarterInfo.pathParams := qs.pathParams
		quickStarterInfo.doublePressCloseHotkey := qs.doublePressCloseHotkey
		quickStarterInfo.titleMatcher := qs.titleMatcher
		quickStarterInfo.active := qs.active
		quickStarterInfo.openWithPathArgs := qs.openWithPathArgs
		quickStarterInfo.mergePathArgs := qs.mergePathArgs
		quickStarterInfo.openForFiles := qs.openForFiles
		quickStarterInfo.asAdmin := qs.asAdmin
		quickStarterInfo.explorerFilesSeparator := qs.explorerFilesSeparator
		quickStarterInfo.menu := qs.menu
		quickStarterInfo.label := qs.label
		quickStarterInfo.fn := qs.fn
		quickStarterInfo.notify := qs.notify
		quickStarterInfo.passExplorerPathAsArgument := qs.passExplorerPathAsArgument
		quickStarterInfo.ico := qs.ico
		quickStarterInfo.context := qs.context
		quickStarterInfo.readFrom := Yaml_ToArray(qs.readFrom)
		quickStarterInfo.writeTo := qs.writeTo
		quickStarterInfo.machine := Yaml_ToArray(qs.machine)
		quickStarterInfo.machineExclude := Yaml_ToArray(qs.machineExclude)
		quickStarterInfo.params := qs.params
		if (qs.followedBy) {
			quickStarterInfo.followedBy := Yaml("", 0)
			Yaml_Merge(quickStarterInfo.followedBy, qs.followedBy)

			Loop % quickStarterInfo.followedBy.() {
				execInfo := quickStarterInfo.followedBy.(A_INDEX)
				quickStarterInfo.followedByInfo .= "`n" execInfo.key " => " execInfo.desc
				execInfo.key := StrSplit(execInfo.key, "|")
			}
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
				if (!quickStarterInfo.path) {
					; Does not exist but validation will pick it up
					quickStarterInfo.path := qs.path.(1)
				}
			} else {
				; Path string
				quickStarterInfo.path := PathReplacements(qs.path)
			}
		}


		; if (qs.label = "DevListVars") {
		; ; TODO: find a way to convert any obj to string...
		; 	a.log(qs)
		; }


		if (!ValidateQuickStarter(quickStarterInfo, qs)) {
			continue
		}


		quickStarterz.Push(quickStarterInfo)


		; Double press close app
		if (quickStarterInfo.doublePressCloseHotkey and quickStarterInfo.titleMatcher) {
			ahkClass := quickStarterInfo.titleMatcher
			Hotkey, IfWinActive, %ahkClass%
			thaHotkey := quickStarterInfo.doublePressCloseHotkey
			Hotkey, %thaHotkey%, QuickStarterInfoCloserExecutor
			Hotkey, IfWinActive
		}


		if (quickStarterInfo.label) {
			BindQuickStarter(quickStarterInfo, quickStarterInfo.label)

		} else if (quickStarterInfo.fn) {
			BindQuickStarter(quickStarterInfo, "", "HotkeyExec")

		} else if (quickStarterInfo.path) {
			BindQuickStarter(quickStarterInfo, "QuickStarterInfoExecutor")

		} else if (quickStarterInfo.followedBy) {
			BindQuickStarter(quickStarterInfo, "", "FollowedByHotkeyExec")

		} else if (!quickStarterInfo.doublePressCloseHotkey) {
			Notify(quickStarterInfo.name, "Unsupported configuration`n" qs.Dump())
		}
	}

	ValidateQuickStartCollection(quickStarterz)
}

Yaml_ToArray(yaml) {
	if (!yaml) {
		return
	}

	arr := []
	if (yaml is string) {
		arr.Push(yaml)
		return arr
	}

	Loop % yaml.() {
		value := yaml.(A_INDEX)
		arr.Push(value)
	}
	return arr
}


IsInArray(arr, needle) {
	For key, value in arr {
		if (value = needle) {
			return true
		}
	}
	return false
}


CheckHotkeyContext(context) {
	if (context) {
		WinGetClass, window, A

		if (context = "explorer") {
			if (window ~= "CabinetWClass|ExploreWClass|Progman|WorkerW")
				return 1

			return OpenSaveFileDialogActive()
		}

		return window ~= context
	}
	return 1
}



BindQuickStarter(qs, thaLabel, functionName := "") {
	; Notify(qs.hotkey " => " qs.path)
	thaHotkey := qs.hotkey
	if (thaHotkey) {
		if (qs.context) {
			fn := Func("CheckHotkeyContext").Bind(qs.context)
			Hotkey, If, % fn
		}

		if thaLabel {
			; Notify("Binding " qs.name, qs.label "`n" qs.path)
			Hotkey, %thaHotkey%, %thaLabel%
		} else {
			fn := Func(functionName).Bind(qs)
			Hotkey, %thaHotkey%, % fn
		}

		if (qs.context) {
			HotKey, If
		}
	}
}
