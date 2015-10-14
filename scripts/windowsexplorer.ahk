#IfWinActive ahk_class CabinetWClass

; Esc twice to close open Windows Explorer
Esc::
	If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
		WinClose
	Else
		Send, {Esc}
	Return

; Press capslock twice to put full directory path of selected file to the clipboard
CapsLock::
If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
{
	SelectedPath := Explorer_GetPath()
	clipboard := SelectedPath
	ClipWait
	if IsFunc("Notify")
		Notify("Path Copied", clipboard)
}
Return

#IfWinActive