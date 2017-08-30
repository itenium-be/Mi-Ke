; Config: TODO: config
; Dependencies: utilities/windowsexplorer.ahk, ini-reader.ahk, notify.ahk


; TODO: Subtitles: script to rename srt that looks like selected file to match selected file exactly
; or if only one srt in directory, rename to same as selected file
; http://www.yifysubtitles.com/
; http://www.ondertitel.com/



; Control + Shift + N: New directory (builtin)
; Control + Shift + F: New file
; ^+f::
ExplorerNewFile:
if WinActive("ahk_class CabinetWClass") {
	DeselectSelectedFiles()
	Send {Appskey}
	Send w
	Send t
	Send ^a
}
Return


; Control + Shift + T: New txt file
; ^+t::
ExplorerNewTextFile:
if WinActive("ahk_class CabinetWClass") {
	DeselectSelectedFiles()
	Send {Appskey}
	Send w
	Send t
}
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





; 2x Capslock: put path of selected file to clipboard
;CapsLock::
ExplorerSelectedFileDirToClipboard:
if WinActive("ahk_class CabinetWClass") {
	If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
	{
		curPath := Explorer_GetPath()
		ToClipboardAndNotify(curPath)
	}
}
Return


; 2x Shift+Capslock: put path + filename to clipboard
; Shift & CapsLock::
ExplorerSelectedFilePathToClipboard:
if WinActive("ahk_class CabinetWClass") {
	If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
	{
		SelectedFiles := Explorer_GetSelected()
		StringSplit, selectedFile, SelectedFiles, `n
		;SplitPath, selectedFile1, name, dir, ext, name_no_ext, drive
		ToClipboardAndNotify(selectedFile1)
	}
}
Return


ToClipboardAndNotify(toClipboard)
{
	clipboard := toClipboard
	if IsFunc("Notify")
		Notify("Path Copied", toClipboard)
}



; 2x Control+Capslock: Open path on the clipboard in Explorer
;Control & CapsLock::
OpenExplorerInClipboardPath:
	if (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500 and FileExist(clipboard))
	{
		explorerCmd := "explorer /select," clipboard
		Run, %explorerCmd%
		Sleep 400
		Send {Enter}
	}
Return
