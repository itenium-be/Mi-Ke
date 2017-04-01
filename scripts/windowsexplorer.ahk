#IfWinActive ahk_class CabinetWClass

; Control + Shift + N: New directory
; Control + Shift + F: New file
^+f::
	Send ^{Space}
	Send {Appskey}
	Send w
	Send t
	Send ^a
	Return

; Control + Shift + T: New txt file
^+t::
	Send ^{Space}
	Send {Appskey}
	Send w
	Send t
	Return

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