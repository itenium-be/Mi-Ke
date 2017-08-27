; Copy two blocks of text and compare them in a diff program
; Select a file in Explorer to compare the contents

; Control + Windows + Left Arrow: Copy selected text and put in %A_Desktop%\left.txt
; Control + Windows + Down Arrow: Copy selected text in %A_Desktop%\right.txt and open diff program
; Control + Windows + Right Arrow: open diff program with left vs right
; Control + Windows + Up: show current clipboard content
; Control + Windows + 0: select a file with Dropbox conflict to compare it with the original file

GetLeft()
{
	return A_Desktop . "\left.txt"
}

GetRight()
{
	return A_Desktop . "\right.txt"
}

PasteClipboardToFile(file, clipContent)
{
	IfExist, %clipContent%
	{
		fileName := clipContent
		FileRead, clipContent, %clipContent%
		clipContent = %fileName%`n%clipContent%
	}

	; MsgBox %clipboard%
	FileDelete, %file%
	FileAppend, %clipContent%, %file%
}

DiffMergeOpenAppl()
{
	left := GetLeft()
	right := GetRight()

	; DiffMerge
	;Run C:\Program Files\SourceGear\Common\DiffMerge\sgdm.exe -nosplash "%left%" "%right%"

	; Beyond compare
	Run C:\Program Files (x86)\Beyond Compare 3\BCompare.exe "%left%" "%right%"
}



^#Left::
Send, ^c
Sleep, 150
PasteClipboardToFile(GetLeft(), clipboard)
diffMergeContentLeftFile := clipboard

if IsFunc("Notify")
{
	trimmedContent := TrimContent(diffMergeContentLeftFile)
	Notify("left.txt", trimmedContent)
}
return



^#Down::
Send, ^c
Sleep, 150
doCompare = false
if (clipboard = diffMergeContentLeftFile)
{
	MsgBox, 4, Identical, Clipboards are identical. Do you want to open DiffMerge anyway?, 1
	IfMsgBox, Yes
		doCompare = true
}
else
	doCompare = true

if doCompare = true
{
	PasteClipboardToFile(GetRight(), clipboard)
	DiffMergeOpenAppl()
}
return



^#Right::
DiffMergeOpenAppl()
return



^#Numpad0::
; English Dropbox conflict filename: \(.*'s conflicted copy \d{4}-\d{2}-\d{2}\)
Send, ^c
Sleep, 150
clipContent := clipboard
IfExist, %clipContent%
{
	IfInString, clipContent, (Exemplaar met conflict van
	{
		PasteClipboardToFile(GetRight(), clipContent)

		originalFileName := RegExReplace(clipContent, " \(Exemplaar met conflict van .* \d{4}-\d{2}-\d{2}\)(?=\.)", "")
		PasteClipboardToFile(GetLeft(), originalFileName)

		DiffMergeOpenAppl()
	}
}
return



TrimContent(content)
{
	maxLineSize := 50

	StringMid, partialContent, content, 1, 500
	Loop, Parse, partialContent, `n, `r
	{
		StringReplace, trimmedLine, A_LoopField, %A_TAB%, %A_SPACE% %A_SPACE%, All

		if StrLen(trimmedLine) > maxLineSize
		{
			StringMid, trimmedLine, trimmedLine, 1, maxLineSize
			trimmedLine .= "..."
		}

		trimmedContent .= trimmedLine "`n"
	}
	return Trim(trimmedContent)
}

^#Up::
if IsFunc("Notify")
{
	trimmedContent := TrimContent(Clipboard)
	Notify("Clipboard contents", trimmedContent)
}
return
