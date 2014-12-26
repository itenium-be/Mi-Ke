; Copy two blocks of text and compare them in diff program
; Control + Windows + Left Arrow: Put left part in %A_Desktop%\left.txt
; Control + Windows + Down Arrow: Put right part in %A_Desktop%\right.txt and open diff program
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
	; MsgBox %clipboard%
	FileDelete, %file%
	FileAppend, %clipboard%, %file%
}

DiffMergeOpenAppl(left, right)
{
	; DiffMerge
	;Run C:\Program Files\SourceGear\Common\DiffMerge\sgdm.exe -nosplash "%left%" "%right%"

	; Beyond compare
	Run C:\Program Files (x86)\Beyond Compare 3\BCompare.exe "%left%" "%right%"
}

^#Left::
Send, ^c
Sleep, 150
PasteClipboardToFile(GetLeft())
diffMergeContentLeftFile := clipboard
return

^#Down::
Send, ^c
Sleep, 150
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