#IfWinActive ahk_class CabinetWClass

; Esc twice to close open Windows Explorer
Esc::
	If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
		WinClose
	Else
		Send, {Esc}
	Return

; Press capslock twice to put full path of selected file to the clipboard
CapsLock::
If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
{
	toClipboard := Explorer_GetPath()
	ToClipboardAndNotify(toClipboard)
}
Return

; Double capslock with shift: put full filename to clipboard
Shift & CapsLock::
If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
{
	SelectedFiles := Explorer_GetSelected()
	StringSplit, selectedFile, SelectedFiles, `n
	;SplitPath, selectedFile1, name, dir, ext, name_no_ext, drive
	ToClipboardAndNotify(selectedFile1)
}
Return

ToClipboardAndNotify(toClipboard)
{
	clipboard := toClipboard
	Sleep, 150
	if IsFunc("Notify")
		Notify("Path Copied", clipboard)
}

#IfWinActive