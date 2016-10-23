; Control+Win+S: SublimeText
^#s::
editorPath = C:\Program Files\Sublime Text 3\sublime_text.exe
editorWinName = Sublime Text

IfWinActive ahk_class CabinetWClass
{
	; Start Editor with current Windows Explorer path opened
	SelectedPath := Explorer_GetPath()
	Run %editorPath% %SelectedPath%
}
Else
{
	; Just start the editor
	IfWinExist, %editorWinName%
	{
		Run %editorPath% --new-window
	}
	else
	{
		Run %editorPath%
	}
}
return

; Control+Win+C: Open calculator
^#c::Run C:\Windows\System32\calc.exe
; Esc twice to close calculator
#IfWinActive Calculator
	Esc::
		If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
			WinClose
		Else
			Send, {Esc}
		Return
#IfWinActive

; Alt+Win+C: Open cmder
; TODO: cant open cmder with specific path: https://github.com/cmderdev/cmder/issues/91
!#c::
cmdPath = C:\bin\cmder\Cmder.exe

IfWinActive ahk_class CabinetWClass
{
	SelectedPath := Explorer_GetPath()
	MsgBox %SelectedPath%
	Run %cmdPath% /start %SelectedPath%
}
Else
{
	Run %cmdPath%
}
return

; Win+C: Open notepad++. C=Code? :) (N is already mapped to OneNote)
#c::Run C:\Program Files (x86)\Notepad++\Notepad++.exe
; Control+Win+C: Open new N++ instance
;^#c::Run C:\Program Files (x86)\Notepad++\Notepad++.exe -multiInst


; Control+Win+F: FileZilla
^#f::
IfWinExist, FileZilla$
	WinActivate
else
	Run C:\Program Files\FileZilla FTP Client\filezilla.exe
return


; CapsLock & S: HeidiSql
CapsLock & S::
IfWinExist, HeidiSQL\s*\d+(\.\d+)+$
	WinActivate
else
	Run C:\Program Files\HeidiSQL\heidisql.exe
return
