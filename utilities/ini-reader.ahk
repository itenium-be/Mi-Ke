FileReplacements(fileName)
{
	; https://autohotkey.com/docs/Variables.htm
	StringReplace, fileName, fileName, <A_DESKTOP>, %A_DESKTOP%
	StringReplace, fileName, fileName, <A_TEMP>, %A_TEMP%
	StringReplace, fileName, fileName, <A_SCRIPTDIR>, %A_SCRIPTDIR%
	StringReplace, fileName, fileName, <USERPROFILE>, %USERPROFILE%
	return fileName
}


ReadMikeIni(sectionName, key, replacePaths)
{
	IniRead, value, %A_Scriptdir%\mike.ini, %sectionName%, %key%
	if replacePaths
		value := FileReplacements(value)
	return value
}
