; Improving upon things already present in Windows Explorer

#IfWinActive ahk_class CabinetWClass

; Control + Shift + 6: Details View
; ~ = Do not block native function
; Resize columns so that filenames are completely visible
~^+6::Send {Control Down}{NumpadAdd}{Control Up}



; Esc twice to close open Windows Explorer
Esc::
	If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
		WinClose
	Else
		Send, {Esc}
Return



; Alt + Enter for ContextMenu.Properties does not work for a Drive
!enter::
selectedFiles := ActiveFolderPath()
isDrive := RegExMatch(selectedFiles, "\w:\\")
if isDrive {
	Run, properties "%selectedFiles%"
}
return



#IfWinActive
