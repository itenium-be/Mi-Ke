#SingleInstance force

; automatisch comparer openen met links en rechts op desktop
; When we want to do this some more:
; - Open the current URL in all 4 browsers
; - When no URL on clipboard: ask for input



; Hotstrings: imail+TAB
:`t:imail::laoujin@hotmail.com
:`t:nimail::woutervs@hotmail.com
:`t:gimail::laoujin@gmail.com
:`t:wimail::wouter.vanschandevijl@ypto.be

; Change music volume
;#Home::
;SoundSetWaveVolume, +10
;SoundGetWaveVolume, OutputVar
;return

; Control+Win+Arrows: DiffMerge
; Left Arrow: delete left and paste cliboard
; Down: delete right, paste clipboard and compare with left file
#Persistent

GetLeft()
{
	return A_Desktop . "\left.txt"
}

GetRight()
{
	return A_Desktop . "\right.txt"
}

PasteClipboardToFile(file)
{
	;MsgBox %file%
	FileDelete, %file%
	FileAppend, %clipboard%, %file%
}

DiffMergeOpenAppl(left, right)
{
	Run C:\Program Files\SourceGear\Common\DiffMerge\sgdm.exe -nosplash "%left%" "%right%"
}
	
^#Left::
Send, ^c
;Use CopyToClipboard
;http://www.autohotkey.com/board/topic/79494-go-to-anything-browseexploregoogle-the-selected-text/
PasteClipboardToFile(GetLeft())
diffMergeContentLeftFile := clipboard
return

^#Down::
Send, ^c
doCompare = false
if (clipboard = diffMergeContentLeftFile)
{
	MsgBox, 4, Identical, Clipboards are identical. Do you want to open DiffMerge anyway?, 3
	IfMsgBox, Yes
		doCompare = true
}
else
	doCompare = true
	
if doCompare = true
{
	PasteClipboardToFile(GetRight())
	DiffMergeOpenAppl(GetLeft(), GetRight())
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



