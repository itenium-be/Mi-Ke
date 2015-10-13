; Put all files in Windows Explorer path to new zip file
; Named to parent directory name
; Control + Win + Z
^#z::
GroupAdd, ExplorerGroup, ahk_class CabinetWClass
GroupAdd, ExplorerGroup, ahk_class ExploreWClass

#IfWinActive ahk_group ExplorerGroup
currentPath := ActiveFolderPath()
if currentPath =
	return

SplitPath, currentPath, topDirName

Run, "C:\Program Files\7-Zip\7z.exe" a "%currentPath%\%topDirName%.zip" "%currentPath%\*"
#IfWinActive
return


ActiveFolderPath()
{
	return PathCreateFromURL(ExplorerPath(WinExist("A")))
}

ExplorerPath(_hwnd)
{
	for Item in ComObjCreate("Shell.Application").Windows
		if (Item.hwnd = _hwnd)
			return, Item.LocationURL
}

PathCreateFromURL(URL)
{
	VarSetCapacity(fPath, Sz := 2084, 0)
	DllCall("shlwapi\PathCreateFromUrl" (A_IsUnicode ? "W" : "A" ), Str, URL, Str, fPath, UIntP,Sz, UInt, 0)
	return fPath
}