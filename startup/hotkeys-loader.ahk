; Hotkey mapping to their source code labels

CreateMikeHotkey(sectionName, key, labelName := "")
{
	; Assumed that key is both the ini key and the Autohotkey label name
	if (!labelName) {
		labelName := key
	}
	value := ReadMikeIni(sectionName, key)
	if value
		Hotkey, %value%, %labelName%
}


CreateSingleMikeHotkey(sectionName)
{
	; Assumed that ini sectionName is also the Autohotkey label name
	if ReadMikeIni(sectionName, "active") {
		CreateMikeHotkey(sectionName, "hotkey", sectionName)
	}
}


if ReadMikeIni("change-sound-volume", "active") {
	CreateMikeHotkey("change-sound-volume", "ChangeSoundVolumeAddBig")
	CreateMikeHotkey("change-sound-volume", "ChangeSoundVolumeMinBig")
	CreateMikeHotkey("change-sound-volume", "ChangeSoundVolumeSee")
	CreateMikeHotkey("change-sound-volume", "ChangeSoundToggleMute")

	CreateMikeHotkey("change-sound-volume", "ChangeSoundVolumeNoImageAddBig")
	CreateMikeHotkey("change-sound-volume", "ChangeSoundVolumeNoImageMinBig")
	CreateMikeHotkey("change-sound-volume", "ChangeSoundNoImageToggleMute")

	CreateMikeHotkey("change-sound-volume", "ChangeSoundVolumeNoImageAddSmall")
	CreateMikeHotkey("change-sound-volume", "ChangeSoundVolumeNoImageMinSmall")
}

if ReadMikeIni("memory-diff", "active") {
	CreateMikeHotkey("memory-diff", "MemoryDiffSaveLeft")
	CreateMikeHotkey("memory-diff", "MemoryDiffSaveRightAndOpen")
	CreateMikeHotkey("memory-diff", "MemoryDiffOpen")
	CreateMikeHotkey("memory-diff", "MemoryDiffDropboxOpen")
	CreateMikeHotkey("memory-diff", "MemoryDiffSee")
}



; windows-explorer
CreateSingleMikeHotkey("CopyDownloadToUsb")
CreateSingleMikeHotkey("OpenExplorerInClipboardPath")

Hotkey, IfWinActive, ahk_class (CabinetWClass|ExploreWClass)
CreateSingleMikeHotkey("ZipDirectory")
CreateSingleMikeHotkey("ExplorerNewFile")
CreateSingleMikeHotkey("ExplorerNewTextFile")
CreateSingleMikeHotkey("ExplorerSelectedFileDirToClipboard")
CreateSingleMikeHotkey("ExplorerSelectedFilePathToClipboard")
Hotkey, IfWinActive
