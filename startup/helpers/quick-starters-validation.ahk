ValidateNotify(qs, qsYaml, str, notifyAlso := true) {
	a.log(qs.name "`n" str "`n`n" qsYaml.Dump())
	if notifyAlso {
		Notify(qs.name, str "`n`n" qsYaml.Dump(), 8)
		; if DEBUG {
		; 	a.show()
		; }
	}
}



ValidateQuickStarter(qs, qsYaml) {
	if (qs.active = 0) {
		return false
	}

	if (qs.machine and not IsInArray(qs.machine, A_ComputerName)) {
		return false
	}
	if (qs.machineExclude and IsInArray(qs.machineExclude, A_ComputerName)) {
		return false
	}

	if (qs.label and not IsLabel(qs.label)) {
		ValidateNotify(qs, qsYaml, "Label '" qs.label "' does not exist")
		return false
	}

	if (qs.path and not FileExist(qs.path)) {
		ValidateNotify(qs, qsYaml, "Path does not exist:`n" qs.path, false)
		return false
	}

	; if (qs.path and qs.label) {
	; 	ValidateNotify(qs, qsYaml, "Can't have both path && label")
	; 	return false
	; }

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
