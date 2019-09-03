
if ReadMikeIni("windows-explorer", "ExplorerNoRenameWarning") {
	; Infinite loop with SetTimer; otherwise the auto-execute section would end
	SetTimer, ExplorerNoRenameWarning, -2000
}
