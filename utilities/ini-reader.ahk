FileReplacements(fileName)
{
	; https://autohotkey.com/docs/Variables.htm#os
	StringReplace, fileName, fileName, <A_DESKTOP>, %A_DESKTOP%
	StringReplace, fileName, fileName, <A_TEMP>, %A_TEMP%
	StringReplace, fileName, fileName, <A_SCRIPTDIR>, %A_SCRIPTDIR%
	StringReplace, fileName, fileName, <USERPROFILE>, %USERPROFILE%
	StringReplace, fileName, fileName, <A_WINDIR>, %A_WINDIR%
	StringReplace, fileName, fileName, <A_PROGRAMFILES>, %A_PROGRAMFILES%
	StringReplace, fileName, fileName, <A_APPDATA>, %A_APPDATA%
	StringReplace, fileName, fileName, <A_MYDOCUMENTS>, %A_MYDOCUMENTS%

	SplitPath, A_AHKPATH, name, dir, ext, name_no_ext, drive
	StringReplace, fileName, fileName, <A_AHKPATH>, %dir%

	return fileName
}


ReadMikeIni(sectionName, key := "", replacePaths := false)
{
	ini = %A_Scriptdir%\mike.ini
	IfExist %ini%
	{
		IniRead, value, %ini%, %sectionName%, %key%
	}
	else
	{
		IniRead, value, %A_Scriptdir%\mike.default.ini, %sectionName%, %key%
		if (value = "ERROR") {
			IniRead, value, %ini%, %sectionName%, %key%
		}
	}

	if (value = "ERROR" or (value = "" and key = "")) {
		MsgBox Error reading from ini. Section="%sectionName%", Key="%key%"

	} else {
		if replacePaths
			value := FileReplacements(value)
		return value
	}
}

WriteMikeIni(value, sectionName, key)
{
	ini = %A_Scriptdir%\mike.ini
	IfNotExist %ini%
		ini = %A_Scriptdir%\mike.default.ini

	IniWrite, %value%, %ini%, %sectionName%, %key%
}
