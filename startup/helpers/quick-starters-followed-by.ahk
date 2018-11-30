FollowedByHotkeyExec(qs) {
	if DEBUG {
		Notify(qs.name, "Press one of:" qs.followedByInfo, 7)
	}

	; Read a key and find the function to execute
	Input key, I L1 T4, {Enter}{Space}{BS}{ESC}
	If (ErrorLevel = "Timeout" or InStr(ErrorLevel, "EndKey:")) {
		Notify("Cancelled")
		return
	}

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

	if (!readFrom) {
		; Force the function to execute once when readFrom is not relevant
		Array.Push("")
	}
	return Array
}



WriteHotkeyOutputData(qs, inputValue, result, readFrom) {
	writeTo := qs.writeTo ? qs.writeTo : readFrom

	if (writeTo = "clipboard") {
		Notify("To clipboard:", TrimContent(result))
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
	else if (writeTo = "console") {
		a.log(result)
		a.show()
	}
	else if (writeTo = "none") {
		; Do nothing
	}
	else {
		Notify(qs.name, "Unknown writeTo: " writeTo)
	}

	if (readFrom = "selectedText" and writeTo <> "clipboard") {
		RestoreClip()
	}
}
