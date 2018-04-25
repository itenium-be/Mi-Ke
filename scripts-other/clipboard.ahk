; Control+Shift+Win+C: Append to clipboard
AppendToClipboard:
	bak = %clipboard%
	clipboard =
	Send, ^c
	ClipWait, 3
	clipboard = %bak%`r`n%clipboard%
	Notify("Appended to Clipboard", clipboard)
Return
