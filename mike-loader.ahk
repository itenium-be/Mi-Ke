CreateMikeHotkey(sectionName, key, labelName)
{
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
	CreateMikeHotkey("change-sound-volume", "hotkey-add-big", "ChangeSoundVolumeAddBig")
	CreateMikeHotkey("change-sound-volume", "hotkey-min-big", "ChangeSoundVolumeMinBig")
	CreateMikeHotkey("change-sound-volume", "hotkey-see", "ChangeSoundVolumeSee")
	CreateMikeHotkey("change-sound-volume", "hotkey-toggle-mute", "ChangeSoundToggleMute")

	CreateMikeHotkey("change-sound-volume", "hotkey-no-image-add-big", "ChangeSoundVolumeNoImageAddBig")
	CreateMikeHotkey("change-sound-volume", "hotkey-no-image-min-big", "ChangeSoundVolumeNoImageMinBig")
	CreateMikeHotkey("change-sound-volume", "hotkey-no-image-toggle-mute", "ChangeSoundNoImageToggleMute")

	CreateMikeHotkey("change-sound-volume", "hotkey-no-image-add-small", "ChangeSoundVolumeNoImageAddSmall")
	CreateMikeHotkey("change-sound-volume", "hotkey-no-image-min-small", "ChangeSoundVolumeNoImageMinSmall")
}

if ReadMikeIni("memory-diff", "active") {
	CreateMikeHotkey("memory-diff", "hotkey-left", "MemoryDiffSaveLeft")
	CreateMikeHotkey("memory-diff", "hotkey-right-and-open", "MemoryDiffSaveRightAndOpen")
	CreateMikeHotkey("memory-diff", "hotkey-open", "MemoryDiffOpen")
	CreateMikeHotkey("memory-diff", "hotkey-dropbox-open", "MemoryDiffDropboxOpen")
	CreateMikeHotkey("memory-diff", "hotkey-see", "MemoryDiffSee")
}

CreateSingleMikeHotkey("windows-min-max", "WindowsMinMax")

; quick-start-programs

; snippets
CreateSingleMikeHotkey("snippets-append-to-clipboard", "AppendToClipboard")
CreateSingleMikeHotkey("snippets-path-win-to-unix", "PathWinToUnix")
CreateSingleMikeHotkey("snippets-md-code-block-surround", "MdCodeBlockSurround")
CreateSingleMikeHotkey("snippets-md-code-block-new", "MdCodeBlockNew")


; -- apps
; chrome
; windows-cmd
CreateSingleMikeHotkey("apps-windows-explorer-copy-download-to-usb", "CopyDownloadToUsb")
CreateSingleMikeHotkey("apps-windows-explorer-zip-directory", "ZipDirectory")

; windows-explorer
CreateSingleMikeHotkey("apps-windows-explorer-new-file", "ExplorerNewFile")
CreateSingleMikeHotkey("apps-windows-explorer-new-txt-file", "ExplorerNewTextFile")
CreateSingleMikeHotkey("apps-windows-explorer-selected-file-dir-to-clipboard", "ExplorerSelectedFileDirToClipboard")
CreateSingleMikeHotkey("apps-windows-explorer-selected-file-path-to-clipboard", "ExplorerSelectedFilePathToClipboard")
CreateSingleMikeHotkey("apps-windows-open-explorer-in-clipboard-path", "OpenExplorerInClipboardPath")

; DEV stuff
CreateSingleMikeHotkey("dev-reload-script", "DevReloadScript")
CreateSingleMikeHotkey("dev-list-vars", "DevListVars")
