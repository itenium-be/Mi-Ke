; Config: mike.ini [memory-diff]
; Dependencies: vendor/windows-explorer-util.ahk, utilities/ini-reader.ahk, notify.ahk

; Copy two blocks of text and compare them in a diff program
; Select a file/folder in Explorer to compare the contents

; Control + Windows + Left Arrow: Copy selected text and put in %A_Desktop%\left.txt
; Control + Windows + Down Arrow: Copy selected text in %A_Desktop%\right.txt and open diff program
; Control + Windows + Right Arrow: open diff program with left vs right
; Control + Windows + Up: show current clipboard content
; Control + Windows + 0: select a file with Dropbox conflict to compare it with the original file


GetLeft()
{
	return ReadMikeIni("memory-diff", "leftFile", true)
}

GetRight()
{
	return ReadMikeIni("memory-diff", "rightFile", true)
}

PasteClipboardToFile(file, clipContent)
{
	IfExist, %clipContent%
	{
		If (InStr(FileExist(clipContent), "D"))
		{
			return "DIRECTORY-COMPARE"
		}
		fileName := clipContent
		FileRead, clipContent, %clipContent%
		clipContent = %fileName%`n%clipContent%
	}

	; MsgBox %clipboard%
	FileDelete, %file%
	FileAppend, %clipContent%, %file%
}

DiffMergeOpenAppl(left := "", right := "")
{
	if (!left and !right) {
		left := GetLeft()
		right := GetRight()
	}

	mergeTool := ReadMikeIni("memory-diff", "merge-tool", true)
	StringReplace, mergeTool, mergeTool, <left>, %left%
	StringReplace, mergeTool, mergeTool, <right>, %right%
	Run %mergeTool%
}

; Control + Win + Left: Clipboard to left.txt
MemoryDiffSaveLeft:
clipboard =
Send, ^c
ClipWait, 3
PasteClipboardToFile(GetLeft(), clipboard)
diffMergeContentLeftFile := clipboard

if IsFunc("Notify")
{
	trimmedContent := TrimContent(diffMergeContentLeftFile)
	Notify("left.txt", trimmedContent)
}
return


; Control + Win + Down: Clipboard to right.txt and open diff tool
MemoryDiffSaveRightAndOpen:
clipboard =
Send, ^c
ClipWait, 3
doCompare = false
if (clipboard = diffMergeContentLeftFile)
{
	MsgBox, 4, Identical, Clipboards are identical. Do you want to open diff anyway?, 1
	IfMsgBox, Yes
		doCompare = true
}
else
	doCompare = true

if doCompare = true
{
	result := PasteClipboardToFile(GetRight(), clipboard)
	if (result = "DIRECTORY-COMPARE" and InStr(FileExist(diffMergeContentLeftFile), "D")) {
		DiffMergeOpenAppl(diffMergeContentLeftFile, clipboard)
	} else {
		DiffMergeOpenAppl()
	}
}
return


; Control + Win + Right: Open diff tool
MemoryDiffOpen:
DiffMergeOpenAppl()
return


; Control + Win + 0: Compare with Dropbox unconflicted file
; In Windows Explorer, compare original file against "someFile (Bert's conflicted copy 2017-07-07).ext"
MemoryDiffDropboxOpen:
clipboard =
Send, ^c
ClipWait, 3
clipContent := clipboard
IfExist, %clipContent%
{
	fileConflictRegex := ReadMikeIni("memory-diff", "dropbox-conflict-regex")
	isConflictFile := RegExMatch(clipContent, fileConflictRegex)
	if isConflictFile
	{
		PasteClipboardToFile(GetRight(), clipContent)

		originalFileName := RegExReplace(clipContent, fileConflictRegex, "")
		PasteClipboardToFile(GetLeft(), originalFileName)

		DiffMergeOpenAppl()
	}
}
return


; Control + Win + Up: See clipboard
MemoryDiffSee:
if IsFunc("Notify")
{
	trimmedContent := TrimContent(Clipboard)
	Notify("Clipboard contents", trimmedContent)
}


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


return
