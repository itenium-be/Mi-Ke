; Control + Shift + S: Rename subtitles to selected file
ExplorerRenameSubtitle:
selectedFile := Explorer_GetSelectedArray()[1]
SplitPath, selectedFile, name, dir, ext, name_no_ext, drive

; TODO: if resulting srt file exists, rename existing one:
; Loop, Files, %dir%\%name_no_ext%.*
; {
; 	if (A_LoopFileLongPath = selectedFile) {
; 		continue
; 	}

; 	FormatTime, CurrentDateTime,, yyyy-MM-ddTHHmmss
; }

; TODO: if multiple subtitles: go for the one with ENG in it
; TODO: should work when selecting srt and for video extensions

videoExts := "avi,flv,wmv,mov,mp4,mkv,vob,ogg,ogv,m4p,m4v,mpeg,mpg"

if (dir in "subs,subtitles") {
	videoDir := SubStr(dir, 1, InStr(SubStr(dir,1,-1), "\", 0, 0)-1)
	Loop, Files, %videoDir%\*.*
	{
		if (Instr(videoExts, A_LoopFileExt) and not Instr(A_LoopFileName, "sample"))
		{
			SplitPath, A_LoopFileName, , , , name_no_ext
			; msgbox %videoDir%\%name_no_ext%.%ext%
			FileMove, %selectedFile%, %videoDir%\%name_no_ext%.%ext%
			break
		}
	}
	return
}


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
