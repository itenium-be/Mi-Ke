; Control+Win+S: SublimeText
^#s::
editorPath = C:\Program Files\Sublime Text 3\sublime_text.exe

IfWinActive ahk_class CabinetWClass
{
	; Start Editor with current Windows Explorer path opened
	SelectedPath := Explorer_GetPath()
	Run %editorPath% %SelectedPath%
}
Else
{
	; Just start the editor
	SetTitleMatchMode RegEx
	IfWinExist, Sublime Text
		Run %editorPath% --new-window
	else
		Run %editorPath%
}
return

; Win+C: Open notepad++. C=Code? :) (N is already mapped to OneNote)
#c::Run C:\Program Files (x86)\Notepad++\Notepad++.exe

; Control+Win+C: Open new N++ instance
^#c::Run C:\Program Files (x86)\Notepad++\Notepad++.exe -multiInst

; Control+Win+F: FileZilla
^#f::
SetTitleMatchMode RegEx
IfWinExist, FileZilla$
	WinActivate
else
	Run C:\Program Files\FileZilla FTP Client\filezilla.exe
return