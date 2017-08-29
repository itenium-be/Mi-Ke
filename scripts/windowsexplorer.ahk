#IfWinActive ahk_class CabinetWClass

; TODO: Subtitles: script to rename srt that looks like selected file to match selected file exactly
; or if only one srt in directory, rename to same as selected file
; http://www.yifysubtitles.com/
; http://www.ondertitel.com/

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
	curPath := Explorer_GetPath()
	ToClipboardAndNotify(curPath)
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
	if IsFunc("Notify")
		Notify("Path Copied", toClipboard)
}


; Alt + Enter for ContextMenu.Properties does not work for a Drive
!enter::
selectedFiles := ActiveFolderPath()
isDrive := RegExMatch(selectedFiles, "\w:\\")
if isDrive {
	Run, properties "%selectedFiles%"
}
return


#IfWinActive
; From here: Hotkeys active when NOT within Explorer:


; 2x Control+Capslock: Open path on the clipboard in Explorer
Control & CapsLock::
if (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500 and FileExist(clipboard))
{
	explorerCmd := "explorer /select," clipboard
	Run, %explorerCmd%
	Sleep 250
	Send {Enter}
}
Return
