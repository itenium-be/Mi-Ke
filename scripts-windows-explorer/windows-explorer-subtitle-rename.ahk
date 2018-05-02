; Control + Shift + S: Rename subtitles to selected file
ExplorerRenameSubtitle:
selectedFile := Explorer_GetSelectedArray()[1]
SplitPath, selectedFile, name, dir, ext, name_no_ext, drive

; Loop, Files, %dir%\%name_no_ext%.*
; {
; 	if (A_LoopFileLongPath = selectedFile) {
; 		continue
; 	}

; 	FormatTime, CurrentDateTime,, yyyy-MM-ddTHHmmss
; }

Loop, Files, %dir%\*.*
{
	; TODO: If the %dir%\%name_no_ext%.srt/sub/idx already exists
	;       then rename it + do a continue when the srt/sub name
	;       is the same as the selectedFile
	if (A_LoopFileExt = "srt") {
		FileMove, %A_LoopFileLongPath%, %dir%\%name_no_ext%.srt
		break
	}

	if (A_LoopFileExt = "sub") {
		FileMove, %A_LoopFileLongPath%, %dir%\%name_no_ext%.sub

		SplitPath, A_LoopFileLongPath, , , , subNameNoExt
		FileMove, %dir%\%subNameNoExt%.idx, %dir%\%name_no_ext%.idx
		break
	}
}

Return
