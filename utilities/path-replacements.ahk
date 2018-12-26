PathReplacements(fileName)
{
	; https://autohotkey.com/docs/Variables.htm#os
	StringReplace, fileName, fileName, <A_DESKTOP>, %A_DESKTOP%
	StringReplace, fileName, fileName, <A_TEMP>, %A_TEMP%
	StringReplace, fileName, fileName, <A_SCRIPTDIR>, %A_SCRIPTDIR%
	StringReplace, fileName, fileName, <USERPROFILE>, %USERPROFILE%
	StringReplace, fileName, fileName, <A_WINDIR>, %A_WINDIR%
	StringReplace, fileName, fileName, <A_APPDATA>, %A_APPDATA%
	StringReplace, fileName, fileName, <A_MYDOCUMENTS>, %A_MYDOCUMENTS%

	SplitPath, A_AHKPATH, name, dir, ext, name_no_ext, drive
	StringReplace, fileName, fileName, <A_AHKPATH>, %dir%
	StringReplace, fileName, fileName, <A_AHKEXEPATH>, %A_AHKPATH%

	; Resolve regex (ex: "/\s\d\.\d/" to match " 4.2")
	if (InStr(fileName, "/")) {
		; The regex cannot contain "/" or this will break horribly
		; But since a path cannot contain a "/", that's just fine.
		originalFullPath := DoublePathSeparators(fileName)
		originalPath := originalFullPath
		actualPath := originalFullPath
		while (!FileExist(actualPath) and InStr(actualPath, "\") ) {
			; This is actually splitting on each \ in the regex aswell
			originalPath := GetParentPath(originalPath)
			actualPath := ResolveProgramFiles(originalPath)
		}


		; msgbox % originalFullPath "`n" originalPath "`n" actualPath
		Loop Files, %actualPath%\*.*, DF
		{
			fullPath := A_LoopFileLongPath
			if (RegExMatch(fullPath, originalFullPath)) {
				; Don't return: If this is a application
				; version regex, take the latest version
				fileName := fullPath
			}
		}

		; msgbox % "result: " fileName
	}
	else
	{
		fileName := ResolveProgramFiles(fileName)
	}

	return fileName
}

GetParentPath(path) {
	return SubStr(path, 1, InStr(SubStr(path, 1, -1), "\", 0, 0) - 1)
}

DoublePathSeparators(path) {
	; RegEx "O)" --> turns outputVar "match" into an object
	foundPos := RegExMatch(path, "O)(.*)/(.*)/(.*)", match)

	; Should probably escape other characters aswell? for regex: .+$^()[] and for Autohotkey: `
	path1 := StrReplace(match.Value(1), "\", "\\")
	path2 := match.Value(2)
	path3 := StrReplace(match.Value(3), "\", "\\")
	return % path1 path2 path3
}


; Resolve "c:\program files" vs "c:\program files (x86)"
ResolveProgramFiles(fileName) {
	if (InStr(fileName, "<A_PROGRAMFILES>")) {
		originalName := fileName

		EnvGet, pf86, ProgramFiles(x86)
		EnvGet, pf64, ProgramFiles

		StringReplace, fileName, fileName, <A_PROGRAMFILES>, %pf86%
		if (!FileExist(fileName)) {
			StringReplace, fileName, originalName, <A_PROGRAMFILES>, %pf64%
		}
	}
	return fileName
}
