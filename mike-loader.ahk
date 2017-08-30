CreateMikeHotkey(sectionName, key, labelName)
{
	IniRead, value, %A_Scriptdir%\mike.ini, %sectionName%, %key%
	Hotkey, %value%, %labelName%
}

if ReadMikeIni("memory-diff", "active", false) {
	CreateMikeHotkey("memory-diff", "hotkey-left", "MemoryDiffSaveLeft")
	CreateMikeHotkey("memory-diff", "hotkey-right-and-open", "MemoryDiffSaveRightAndOpen")
	CreateMikeHotkey("memory-diff", "hotkey-open", "MemoryDiffOpen")
	CreateMikeHotkey("memory-diff", "hotkey-dropbox-open", "MemoryDiffDropboxOpen")
	CreateMikeHotkey("memory-diff", "hotkey-see", "MemoryDiffSee")
}

