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

; Control+Win+C: Open cmder
^#c::
cmdPath = C:\tools\cmder\Cmder.exe

IfWinActive ahk_class CabinetWClass
{
	SelectedPath := Explorer_GetPath()
	Run %cmdPath% /start %SelectedPath%
	; TODO: doesn't work
	; https://github.com/cmderdev/cmder/issues/91
	; TODO: start cmder with SelectedPath (or even better a new tab?)
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