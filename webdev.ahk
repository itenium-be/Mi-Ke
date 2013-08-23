#SingleInstance force

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
; Left/Right Arrow: open left/right file and paste cliboard
; Down: compare left/right file
#Persistent
diffMergeFilePath := A_Desktop
diffMergePathLeft := diffMergeFilePath . "\left.txt"
diffMergePathRight := diffMergeFilePath . "\right.txt"
diffMergeContentLeftFile := ""
return

PasteClipboardToFile(file)
{
	MsgBox blah %file%
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
PasteClipboardToFile(diffMergePathLeft)
diffMergeContentLeftFile := clipboard
return

^#Right::
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
	PasteClipboardToFile(diffMergePathRight)
	DiffMergeOpenAppl(diffMergePathLeft, diffMergePathRight)
}
return

^#Down::
DiffMergeOpenAppl(diffMergePathLeft, diffMergePathRight)
return


; Win+C: Open notepad++. C=Code? :) (N is already mapped to OneNote)
#c::Run C:\Program Files (x86)\Notepad++\Notepad++

; Control+Win+C: Open new N++ instance
^#c::Run Notepad -multiInst

; Control+Win+F: FileZilla
^#f::
SetTitleMatchMode RegEx
IfWinExist, FileZilla$
	WinActivate
else
	Run C:\Program Files (x86)\FileZilla FTP Client\filezilla.exe
return





; AltGr+Win: Go directly to special folders
; +D: Dropbox
; +W: WWW Folder
; +T: Temp folder
; +L: Leeching folder
<^>!#d::Run C:\Dropbox\Personal
<^>!#w::Run C:\wamp\www
<^>!#t::Run C:\temp
<^>!#l::Run C:\Download

; Window "Save As"
; -> insert bookmarks


; When we want to do this some more:
; - Open the current URL in all 4 browsers
; - When no URL on clipboard: ask for input


