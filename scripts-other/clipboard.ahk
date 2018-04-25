; Control+Shift+Win+C: Append to clipboard
AppendToClipboard:
	clipVal := CopyAndSaveClip()
	clipboard = %clipVal%`r`n%clipboard%
	Notify("Appended to Clipboard", clipboard)
Return
