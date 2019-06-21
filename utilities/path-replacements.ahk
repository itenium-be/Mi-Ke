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
	
	IfInString, fileName, LOCALAPP
	{
		EnvGet, LOCALAPPDATA, LOCALAPPDATA
		StringReplace, fileName, fileName, <A_LOCALAPPDATA>, %LOCALAPPDATA%
	}

	

	SplitPath, A_AHKPATH, name, dir, ext, name_no_ext, drive
	StringReplace, fileName, fileName, <A_AHKPATH>, %dir%
	StringReplace, fileName, fileName, <A_AHKEXEPATH>, %A_AHKPATH%

	; Resolve regex (ex: "[0-9].[0-9]/" to match "4.2")
	; ATTN: Don't use "\" in the regex! Will implement if ever needed? :)
	if (InStr(fileName, "/")) {
		; Turn the path parts into an array: ['c:', 'temp', 'test.txt']
		pathParts := []
		fullPath := fileName

		while (InStr(fullPath, "\")) {
			; This is actually splitting on each \ in the regex aswell
			leftPart := SubStr(fullPath, 1, InStr(fullPath, "\") - 1)
			pathParts.Push(leftPart)
			fullPath := SubStr(fullPath, InStr(fullPath, "\") + 1)
		}
		pathParts.Push(fullPath)


		; Calculate the largest path that exists (=without regex)
		originalFullPath := fileName
		originalPath := originalFullPath
		largestExistingPath := originalFullPath
		largestExistingPathParts := pathParts.MaxIndex() + 1
		while (!FileExist(ResolveProgramFiles(largestExistingPath)) and InStr(largestExistingPath, "\")) {
			; This is actually splitting on each \ in the regex aswell
			originalPath := GetParentPath(originalPath)
			largestExistingPath := originalPath

			largestExistingPathParts--
		}


		; Find the matching file
		loopCount := pathParts.MaxIndex() - largestExistingPathParts + 1
		Loop, %loopCount%
		{
			partIndex := pathParts.MaxIndex() - (loopCount - A_Index)
			part := pathParts[partIndex]

			basePath := largestExistingPath "\" part

			findDirectory := partIndex < pathParts.MaxIndex()
			fileMode := findDirectory ? "D" : "F"

			if (findDirectory) {
				pathFound := FindInFiles(ResolveProgramFiles64(largestExistingPath), "D", ResolveProgramFiles64(basePath))
				if (!pathFound) {
					pathFound := FindInFiles(ResolveProgramFiles86(largestExistingPath), "D", ResolveProgramFiles86(basePath))
				}
				if (pathFound) {
					largestExistingPath := pathFound
				}

			} else {
				basePath := largestExistingPath "\" part
				path64 := DoublePathSeparators(ResolveProgramFiles64(basePath))
				path86 := DoublePathSeparators(ResolveProgramFiles86(basePath))

				Loop Files, %largestExistingPath%\*.*, %fileMode%
				{
					if (RegExMatch(A_LoopFileLongPath, path64) or RegExMatch(A_LoopFileLongPath, path86)) {
						; Don't return: If this is a application
						; version regex, take the latest version
						largestExistingPath := A_LoopFileLongPath
					}
				}
			}
		}
		fileName := largestExistingPath
	}
	else
	{
		fileName := ResolveProgramFiles(fileName)
	}

	return fileName
}

FindInFiles(findInPath, fileMode, pathSoFar) {
	pathSoFar := DoublePathSeparators(pathSoFar)
	Loop Files, %findInPath%\*.*, %fileMode%
	{
		if (RegExMatch(A_LoopFileLongPath, pathSoFar)) {
			pathFound := A_LoopFileLongPath
			return pathFound
		}
	}
}


GetParentPath(path) {
	return SubStr(path, 1, InStr(SubStr(path, 1, -1), "\", 0, 0) - 1)
}


; The regex cannot contain "/" or this will break horribly
; But since a path cannot contain a "/", that's just fine.
DoublePathSeparators(fileName) {
	; RegEx "O)" --> turns outputVar "match" into an object
	foundPos := RegExMatch(fileName, "O)([^/]*)/([^/]*)/([^/]*)", match)
	if (!foundPos) {
		return EscapeRegexChars(fileName)
	}

	part1 := EscapeRegexChars(match.Value(1))
	if (match.Value(2)) {
		part2 := match.Value(2)
	}
	if (match.Value(3)) {
		part3 := EscapeRegexChars(match.Value(3))
	}
	return % part1 part2 part3
}


EscapeRegexChars(path) {
	; Regex escapes (valid path chars only)
	path := StrReplace(path, "\", "\\")
	path := StrReplace(path, ".", "\.")
	path := StrReplace(path, "+", "\+")
	path := StrReplace(path, "^", "\^")
	path := StrReplace(path, "$", "\$")
	path := StrReplace(path, "(", "\(")
	path := StrReplace(path, ")", "\)")
	path := StrReplace(path, "[", "\[")
	path := StrReplace(path, "]", "\]")

	; Autohotkey escapes
	path := StrReplace(path, "`", "``")
	return path
}


; Resolve "c:\program files" vs "c:\program files (x86)"
ResolveProgramFiles(fileName) {
	if (InStr(fileName, "<A_PROGRAMFILES>")) {
		originalName := fileName

		fileName := ResolveProgramFiles86(originalName)
		if (!FileExist(fileName)) {
			fileName := ResolveProgramFiles64(originalName)
		}
	}
	return fileName
}
ResolveProgramFiles86(path) {
	EnvGet, pf86, ProgramFiles(x86)
	path := StrReplace(path, "<A_PROGRAMFILES>", pf86)
	return path
}
ResolveProgramFiles64(path) {
	EnvGet, pf64, ProgramFiles
	path := StrReplace(path, "<A_PROGRAMFILES>", pf64)
	return path
}
