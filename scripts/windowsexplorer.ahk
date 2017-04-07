#IfWinActive ahk_class CabinetWClass

; Control + Shift + 6: Details View
; ~ = Do not block native function
~^+6::
	; Resize columns so that filenames are completely visible
	Send {Control Down}{NumpadAdd}{Control Up}
	Return


; Control + Shift + N: New directory
; Control + Shift + F: New file
^+f::
	DeselectSelectedFiles()
	Send {Appskey}
	Send w
	Send t
	Send ^a
	Return

; Control + Shift + T: New txt file
^+t::
	DeselectSelectedFiles()
	Send {Appskey}
	Send w
	Send t
	Return

DeselectSelectedFiles()
{
	selectedFiles := Explorer_GetSelected()
	if selectedFiles
	{
		; If no file is selected, ^Space may actually select it
		; after which {AppsKey} will open the wrong ContextMenu
		Send ^{Space}
	}
}

; Esc twice to close open Windows Explorer
Esc::
	If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
		WinClose
	Else
		Send, {Esc}
	Return


; 2x Capslock: put path of selected file to clipboard
CapsLock::
If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
{
	toClipboard := Explorer_GetPath()
	ToClipboardAndNotify(toClipboard)
}
Return


; 2x Shift+Capslock: put path + filename to clipboard
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