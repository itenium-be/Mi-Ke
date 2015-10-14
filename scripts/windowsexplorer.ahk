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
	SelectedPath := Explorer_GetSelectedFile()
	SplitPath, SelectedPath, name, dir, ext, name_no_ext, drive
	clipboard := dir
	ClipWait
	Notify("Path Copied", clipboard, -1, "Style=Mine")
}
Return

#IfWinActive

; TODO: move to utilities\windows.ahk?
MouseIsOver(Wintitle) {
	MouseGetPos,,, Win
	return WinExist(Wintitle . " ahk_id " . Win)
}