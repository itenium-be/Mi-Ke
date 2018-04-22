; Reads config\mike.ini to configure Mi-Ke at startup

; ----- Keyboard
; Numlock, Capslock, ScrollLock
lockStates := ReadMikeIni("keyboard-lockstate")
Loop, parse, lockStates, `n
{
	StringSplit, keyValue, A_LoopField, =
	key := keyValue1
	value := keyValue2

	if (value) {
		if (key = "NumlockState") {
			SetNumlockState %value%
		} else if (key = "CapsLockState") {
			SetCapsLockState %value%
		} else if (key = "ScrollLockState") {
			SetScrollLockState %value%
		}
	}
}


; ----- Hotkeyed scripts
; Hotkey mapping to their source code labels

CreateMikeHotkey(sectionName, key)
{
	; Assumed that key is both the ini key and the Autohotkey label name
	value := ReadMikeIni(sectionName, key)
	if value
		Hotkey, %value%, %key%
}


CreateSingleMikeHotkey(sectionName)
{
	; Assumed that ini sectionName is also the Autohotkey label name
	if ReadMikeIni(sectionName, "active") {
		CreateMikeHotkey(sectionName, "hotkey")
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

CreateSingleMikeHotkey("WindowsMinMax")


; snippets
CreateSingleMikeHotkey("AppendToClipboard")
CreateSingleMikeHotkey("ConvertToTitleCase")
CreateSingleMikeHotkey("ExplorerLastDownloadedFile")
CreateSingleMikeHotkey("PathWinToUnix")
CreateSingleMikeHotkey("MdCodeBlockSurround")
CreateSingleMikeHotkey("MdCodeBlockNew")


; -- apps
; browser
CreateMikeHotkey("core", "BrowserOpen")
CreateMikeHotkey("core", "BrowserSearch")
CreateMikeHotkey("core", "BrowserSearchAutohotkey")

; windows-cmd

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

; DEV stuff
CreateSingleMikeHotkey("DevReloadScript")
CreateSingleMikeHotkey("DevListVars")
CreateSingleMikeHotkey("DevKeyHistory")
CreateSingleMikeHotkey("DevReloadScriptWhenSaved")
