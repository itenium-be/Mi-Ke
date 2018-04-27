; Improving upon things already present in Windows Explorer

; ------------------------------------------------------------------------ WITHIN EXPLORER
#IfWinActive ahk_class CabinetWClass|ExploreWClass


; Alt + Enter for ContextMenu.Properties does not work for a Drive
; $ so that we can still use Send !{enter}
$!enter::
selectedFiles := Explorer_GetSelected()
if (selectedFiles)
{
	Send !{enter}
}
else
{
	selectedFiles := ActiveFolderPath()
	isDrive := RegExMatch(selectedFiles, "\w:\\")
	if isDrive {
		Run, properties "%selectedFiles%"
	}
}
return



#IfWinActive



; ------------------------------------------------------------------------ WITHIN EXPLORER AND OPEN/SAVE FILE DIALOGS


; Control + Shift + 6: Switch to Details View (builtin)
; ~ = Do not block native function
; Resize first column so that filenames are completely visible
SwitchToDetailsView:
Send {Control Down}{NumpadAdd}{Control Up}
ResizeOpenSaveFileDialog()
return


ResizeOpenSaveFileDialog() {
	iniSectionName = apps-windows-explorer-open-save-dialog-size
	if (ReadMikeIni(iniSectionName, "active") and OpenSaveFileDialogActive()) {
		minWidth := ReadMikeIni(iniSectionName, "min-width")
		minHeight := ReadMikeIni(iniSectionName, "min-height")

		WinGetPos x, y, width, height, A
		if (width < minWidth or height < minHeight) {
			WinMove, A,, (A_ScreenWidth/2)-(minWidth/2), (A_ScreenHeight/2)-(minHeight/2), minWidth, minHeight
		}
	}
}
