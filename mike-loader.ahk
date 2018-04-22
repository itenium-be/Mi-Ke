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

CreateMikeHotkey(sectionName, key, labelName := "")
{
	if (!labelName) {
		; Assume the key is both the ini key and the Autohotkey label name
		labelName := key
	}

	value := ReadMikeIni(sectionName, key)
	if value
		Hotkey, %value%, %labelName%
}


CreateSingleMikeHotkey(sectionName, labelName)
{
	if ReadMikeIni(sectionName, "active") {
		CreateMikeHotkey(sectionName, "hotkey", labelName)
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

CreateSingleMikeHotkey("windows-min-max", "WindowsMinMax")


; snippets
CreateSingleMikeHotkey("snippets-append-to-clipboard", "AppendToClipboard")
CreateSingleMikeHotkey("snippets-convert-to-title-case", "ConvertToTitleCase")
CreateSingleMikeHotkey("snippets-explorer-last-downloaded-file", "ExplorerLastDownloadedFile")
CreateSingleMikeHotkey("snippets-path-win-to-unix", "PathWinToUnix")
CreateSingleMikeHotkey("snippets-md-code-block-surround", "MdCodeBlockSurround")
CreateSingleMikeHotkey("snippets-md-code-block-new", "MdCodeBlockNew")


; -- apps
; browser
CreateMikeHotkey("core", "BrowserOpen")
CreateMikeHotkey("core", "BrowserSearch")
CreateMikeHotkey("core", "BrowserSearchAutohotkey")

; windows-cmd

; windows-explorer
CreateSingleMikeHotkey("apps-windows-explorer-copy-download-to-usb", "CopyDownloadToUsb")
CreateSingleMikeHotkey("apps-windows-open-explorer-in-clipboard-path", "OpenExplorerInClipboardPath")

Hotkey, IfWinActive, ahk_class (CabinetWClass|ExploreWClass)
CreateSingleMikeHotkey("apps-windows-explorer-zip-directory", "ZipDirectory")
CreateSingleMikeHotkey("apps-windows-explorer-new-file", "ExplorerNewFile")
CreateSingleMikeHotkey("apps-windows-explorer-new-txt-file", "ExplorerNewTextFile")
CreateSingleMikeHotkey("apps-windows-explorer-selected-file-dir-to-clipboard", "ExplorerSelectedFileDirToClipboard")
CreateSingleMikeHotkey("apps-windows-explorer-selected-file-path-to-clipboard", "ExplorerSelectedFilePathToClipboard")
Hotkey, IfWinActive

; DEV stuff
CreateSingleMikeHotkey("dev-reload-script", "DevReloadScript")
CreateSingleMikeHotkey("dev-list-vars", "DevListVars")
CreateSingleMikeHotkey("dev-key-history", "DevKeyHistory")
CreateSingleMikeHotkey("dev-reload-script-on-save", "DevReloadScriptWhenSaved")
