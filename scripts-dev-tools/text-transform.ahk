; Control+Win+T: To TitleCase
ConvertToTitleCase:
	clipboard =
	Send, ^c
	ClipWait, 3
	StringUpper titleCased, Clipboard, T
	Send %titleCased%
Return
