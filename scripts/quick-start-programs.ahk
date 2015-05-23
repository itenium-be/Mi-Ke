; Control+Win+S: SublimeText
^#s::
SetTitleMatchMode RegEx
IfWinExist, Sublime Text
	Run C:\Program Files\Sublime Text 3\sublime_text.exe --new-window
else
	Run C:\Program Files\Sublime Text 3\sublime_text.exe
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