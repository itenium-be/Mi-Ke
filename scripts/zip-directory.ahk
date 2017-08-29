; Put all files in Windows Explorer path to new zip file
; Named as parent directory name.zip
; Select just a few files to put those only to the zip archive
; Control + Win + Z
^#z::
GroupAdd, ExplorerGroup, ahk_class CabinetWClass
GroupAdd, ExplorerGroup, ahk_class ExploreWClass

#IfWinActive ahk_group ExplorerGroup
currentPath := ActiveFolderPath()
if currentPath =
	return

selectedFiles := Explorer_GetSelected()

; If one file selected, probably by accident?, default to zipping entire directory
if selectedFiles
{
	StringReplace, selectedFiles, selectedFiles, `n, `n, UseErrorLevel
	selectedFilesCount := ErrorLevel + 1
	if (selectedFilesCount = 1) {
		MsgBox, 4, Zippy, Selected one file:`n%selectedFiles%`n`nNo to zip just this file`nYes to zip the entire folder instead., 5
		IfMsgBox, Yes
			selectedFiles :=
	}
}

if selectedFiles
{
	; Zip selected file(s)
	toZip =
	Loop, Parse, selectedFiles, `n
	{
		toZip .= """" A_LoopField """ "
	}
}
else
{
	; Zip entire directory
	toZip := """" currentPath "\*"""
}


If selectedFilesCount = 1
{
	; One filename: use that filename for the zip
	SplitPath, selectedFiles, , , , selectedFileName
	zipFileName := selectedFileName
}
else
{
	; Use active directory name as name for the zip
	SplitPath, currentPath, topDirName


	; .NET: If bin/debug/release foldername, go up for full .net name
	; I assume that adding the AssemblyVersion is overkill for this script? :)
	if (topDirName = "Debug" or topDirName = "Release" or topDirName = "bin")
	{
		parentDirectory := GetParentDirectoryName(currentPath)
		SplitPath, parentDirectory, topDirName
		if (topDirName = "bin")
		{
			parentDirectory := GetParentDirectoryName(parentDirectory)
			SplitPath, parentDirectory, topDirName
		}
	}
	zipFileName := topDirName


	; If the target zip already exists?
	; Simply continuating would overwrite the existing zip with the original zip inside it (ie doubling size because 7zip doesn't see what happened)
	fullZipName = %currentPath%\%topDirName%.zip
	if FileExist(fullZipName)
	{
		MsgBox, 4, Zippy already exists?, %topDirName%.zip already exists!`n`nYes to delete it.`nNo to abort
		IfMsgBox, Yes
			FileDelete %fullZipName%
		IfMsgBox, No
			return
	}
}

; The actual zipping :)
fullZipName = %currentPath%\%zipFileName%.zip

IniRead, downloadPath, %A_SCRIPTDIR%\scripts\zip-directory.ini, zip, cmd
StringReplace, downloadPath, downloadPath, <fullZipName>, %fullZipName%
StringReplace, downloadPath, downloadPath, <toZip>, %toZip%

RunWait, %downloadPath%

; RunWait so that we can determine file size
; Which works - sometimes :p
FileGetSize, zipFileSize, %fullZipName%, M
if IsFunc("Notify")
	Notify(zipFileName ".zip created", "Size: " zipFileSize "MB")

#IfWinActive
return

GetParentDirectoryName(path)
{
	return SubStr(path, 1, InStr(SubStr(path, 1, -1), "\", 0, 0) - 1)
}
