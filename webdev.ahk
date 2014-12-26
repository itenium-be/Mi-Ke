#Persistent
#SingleInstance force

#Include hotstrings\email.ahk
#Include hotstrings\misc.ahk

#Include scripts\change-sound-volume.ahk
#Include scripts\memory-diff.ahk

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
	Run C:\Program Files (x86)\FileZilla FTP Client\filezilla.exe
return


; AltGr+Win: Go directly to special folders
; +C: Dropbox
; +W: WWW Folder
; +T: Temp folder
; +L: Leeching folder
<^>!#c::Run C:\CloudDrives\Dropbox\Personal\Programming
<^>!#w::Run C:\unix\wamp\www
<^>!#t::Run C:\temp
<^>!#l::Run H:\!Download
