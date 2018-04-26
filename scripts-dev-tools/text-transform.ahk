; AltGr + C: Change casing of selected text
; Follow with t (Title Case), u (UPPER CASE), l (lower case)

ToTitleCase(clipVal) {
	StringUpper caseChanged, clipVal, T
	return caseChanged
}

ToUpperCase(clipVal) {
	StringUpper caseChanged, clipVal
	return caseChanged
}

ToLowerCase(clipVal) {
	StringLower caseChanged, clipVal
	return caseChanged
}



Slugify(str) {
	str := Trim(Format("{:L}", str))
	str := RegexReplace(str, "\s+", "-")
	str := RegexReplace(str, "[^\w-]+", "")
	str := RegexReplace(str, "--+", "-")
	str := RegexReplace(str, "-+$", "")
	str := RegexReplace(str, "^-+", "")
	return str
}
