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


; https://autohotkey.com/board/topic/24431-convert-text-uppercase-lowercase-capitalized-or-inverted
ToSentenceCaseBlend(str) {
	str := ToLowerCase(str)
	return RegExReplace(str, "(((^|([.!?]\s+))[a-z])| i | i')", "$u1")
}


ToSentenceCase(str) {
	X = I,AHK,AutoHotkey

	str := RegExReplace(str, "[\.\!\?]\s+|\R+", "$0þ") ; mark 1st letters of sentences with char 254
	Loop Parse, str, þ
	{
		StringLower L, A_LoopField
		I := Chr(Asc(A_LoopField))
		StringUpper I, I
		S .= I SubStr(L,2)
	}
	Loop Parse, X, `,
		S := RegExReplace(S,"i)\b" A_LoopField "\b", A_LoopField)

	return S
}


InvertCase(str) {
	Lab_Invert_Char_Out := ""
	Loop % Strlen(str) {
		Lab_Invert_Char := Substr(str, A_Index, 1)
		if Lab_Invert_Char is upper
			Lab_Invert_Char_Out := Lab_Invert_Char_Out Chr(Asc(Lab_Invert_Char) + 32)
		else if Lab_Invert_Char is lower
			Lab_Invert_Char_Out := Lab_Invert_Char_Out Chr(Asc(Lab_Invert_Char) - 32)
		else
			Lab_Invert_Char_Out := Lab_Invert_Char_Out Lab_Invert_Char
	}
	RETURN Lab_Invert_Char_Out
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
