; Click the "Are you sure you want to change the extension" away
ExplorerNoRenameWarning:
	While, 1
	{
		WinWaitActive, Rename ahk_class #32770
		; BUG: Keeps sending "y" if a window satisfies the
		; condition but y doesn't actually close the window
		if not WinActive("ahk_exe eclipse.exe") and not WinActive("ahk_exe SumatraPDF.exe")
			Send y
	}
return




; Control + Shift + N: New directory (builtin)
; Control + Shift + F: New file
ExplorerNewFile:
	DeselectSelectedFiles()
	Send {Appskey}
	Send w
	Send t
	Send ^a
Return


; Control + Shift + T: New txt file
ExplorerNewTextFile:
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



; Control + Alt + D: Open last downloaded file
ExplorerLastDownloadedFile:
	File := GetLastDownloadedFile()
	Run, explorer.exe /select`,"%File%"
Return


CopyLastDownloadedFileToExplorerPath:
	File := GetLastDownloadedFile()
	Dest := Explorer_GetPath()
	FileCopy, %File%, %Dest%
	If ErrorLevel
		Notify("Destination already existed", "Source=" File "`nDestination=" Dest)
Return

GetLastDownloadedFile() {
	Loop, Files, %DOWNLOAD_FOLDER%\*, DF
	{
		FileGetTime, Time, %A_LoopFileFullPath%, C
		If (Time > Time_Orig)
		{
			Time_Orig := Time
			File := A_LoopFileFullPath
		}
	}
	return File
}


; 2x Capslock: put path of selected file to clipboard
ExplorerSelectedFileDirToClipboard:
	If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
	{
		curPath := Explorer_GetPath()
		ToClipboardAndNotify(curPath)
	}
Return


; 2x Shift+Capslock: put path + filename to clipboard
ExplorerSelectedFilePathToClipboard:
	If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
	{
		SelectedFiles := Explorer_GetSelected()
		StringSplit, selectedFile, SelectedFiles, `n
		SplitPath, selectedFile1, name, dir, ext, name_no_ext, drive
		ToClipboardAndNotify(selectedFile1)
	}
Return


ToClipboardAndNotify(toClipboard)
{
	clipboard := toClipboard
	Notify("Path Copied", toClipboard)
}


; Open selected text clipboard in Explorer
; Infos: https://ss64.com/nt/explorer.html
OpenExplorerInClipboardPath:
	clipVal := CopyAndSaveClip(1)

	fileExists := FileExist(clipVal)
	if (fileExists = "D") {
		; Enter directory
		Run % "explorer.exe /root," clipVal

	} else if (fileExists) {
		; Select file
		Run % "explorer.exe /select," clipVal

	} else {
		startupPath := ReadMikeIni("windows-explorer", "StartupPath")
		if (startupPath) {
			Run % "explorer.exe /root," startupPath
		} else {
			Send #e
		}
	}

	RestoreClip()
Return
