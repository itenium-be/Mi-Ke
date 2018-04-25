; Control+Win+T: Change casing of selected text
; Follow with t (Title Case), u (UPPER CASE), l (lower case)
TextTransform:
	titleCaseKey = t
	upperCaseKey = u
	lowerCaseKey = l

	clipVal := CopyAndSaveClip()

	Input key, I L1
	if (key = %titleCaseKey%) {
		StringUpper caseChanged, clipVal, T
	} else if (key = upperCaseKey) {
		StringUpper caseChanged, clipVal
	} else if (key = lowerCaseKey) {
		StringLower caseChanged, clipVal
	} else {
		Notify("TextTransform: wrong key" key)
	}

	; Notify(key " resulted in " caseChanged, clipVal)

	Send %caseChanged%
	RestoreClip()
Return
