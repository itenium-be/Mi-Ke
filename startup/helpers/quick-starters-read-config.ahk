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
		quickStarterInfo.asAdmin := qs.asAdmin
		quickStarterInfo.explorerFilesSeparator := qs.explorerFilesSeparator
		quickStarterInfo.menu := qs.menu
		quickStarterInfo.label := qs.label
		quickStarterInfo.passExplorerPathAsArgument := qs.passExplorerPathAsArgument
		quickStarterInfo.ico := qs.ico
		quickStarterInfo.context := qs.context
		quickStarterInfo.readFrom := Yaml_ToArray(qs.readFrom)
		quickStarterInfo.writeTo := qs.writeTo
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


		if (quickStarterInfo.path) {
			BindQuickStarter(quickStarterInfo, "QuickStarterInfoExecutor")

		} else if (quickStarterInfo.label) {
			BindQuickStarter(quickStarterInfo, quickStarterInfo.label)

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



ValidateQuickStarter(qs, qsYaml) {
	if (qs.active = 0) {
		return false
	}

	if (qs.label and not IsLabel(qs.label)) {
		ValidateNotify(qs, qsYaml, "Label '" qs.label "' does not exist")
		return false
	}

	if (qs.path and not FileExist(qs.path)) {
		ValidateNotify(qs, qsYaml, "Path does not exist:`n" qs.path)
		return false
	}

	if (qs.path and qs.label) {
		ValidateNotify(qs, qsYaml, "Can't have both path && label")
		return false
	}

	if (qs.followedBy) {
		Loop % qs.followedBy.() {
			execInfo := qs.followedBy.(A_INDEX)
			if (!IsFunc(execInfo.fn)) {
				ValidateNotify(qs, qsYaml, execInfo.fn " is not a function?")
				break
			}
		}
	}

	value := qs.passExplorerPathAsArgument
	if (value <> "" and value <> "dir" and value <> "file") {
		ValidateNotify(qs, qsYaml, "Unknown value passExplorerPathAsArgument: " value)
	}

	return true
}


ValidateQuickStartCollection(quickStarters) {
	checkArr := []
	For index, qs in quickStarters {
		hotkey := qs.hotkey
		if (hotkey and IsInArray(checkArr, hotkey)) {
			Notify("Double hotkey mapping", qs.name "`nHotkey: " hotkey)
		}
		checkArr.Push(hotkey)
	}
}

IsInArray(arr, needle) {
	For key, value in arr {
		if (value = needle) {
			return true
		}
	}
	return false
}


ValidateNotify(qs, qsYaml, str) {
	if DEBUG {
		Notify(qs.name, str "`n`n" qsYaml.Dump(), 8)
	}
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


FollowedByHotkeyExec(qs) {
	if DEBUG {
		Notify(qs.name, "Press one of:" qs.followedByInfo, 7)
	}

	; Read a key and find the function to execute
	Input key, I L1
	Loop % qs.followedBy.() {
		execInfo := qs.followedBy.(A_INDEX)
		; Notify(qs.name, execInfo.key ": " execInfo.fn)
		if (IsInArray(execInfo.key, key)) {
			funcName := execInfo.fn
			break
		}
	}
	if (!funcName) {
		errorMsg := "Key '" key "' is not bound to anything."
		if DEBUG {
			Notify("", errorMsg)
		} else {
			Notify(qs.name, errorMsg "`n" qs.followedByInfo, 7)
		}
	}


	for index, value in qs.readFrom {
		if (value = "explorer-file" and isExplorerLike()) {
			readFrom := value
			break
		}
		if (value = "selectedText") {
			readFrom := value
			break
		}
	}


	; Flow: readFrom, call funcName, qs.writeTo
	inputArray := GetHotkeyInputDataArray(readFrom)
	for index, inputValue in inputArray
	{
		if (readFrom = "explorer-file") {
			FileRead, fileContent, %inputValue%
			result := %funcName%(fileContent)

		} else {
			result := %funcName%(inputValue)
		}
		if result {
			WriteHotkeyOutputData(qs, inputValue, result, readFrom)
		}
	}
}


GetHotkeyInputDataArray(readFrom) {
	if (readFrom = "explorer-file") {
		fileNames := Explorer_GetSelectedArray()
		return %fileNames%
	}

	Array := []
	if (readFrom = "selectedText") {
		Array.Push(CopyAndSaveClip())
	}
	return Array
}


WriteHotkeyOutputData(qs, inputValue, result, readFrom) {
	writeTo := qs.writeTo ? qs.writeTo : readFrom

	if (writeTo = "clipboard") {
		Notify("To clipboard:", result)
		clipboard := result
	}
	else if (writeTo = "selectedText") {
		Send % result
	}
	else if (writeTo = "explorer-file") {
		; Notify(inputValue, result)
		FileDelete % inputValue
		FileAppend, %result%, % inputValue
	}
	else {
		Notify(qs.name, "Unknown writeTo: " writeTo)
	}

	if (readFrom = "selectedText" and writeTo <> "clipboard") {
		RestoreClip()
	}
}
