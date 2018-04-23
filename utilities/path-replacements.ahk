PathReplacements(fileName)
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
	StringReplace, fileName, fileName, <A_AHKEXEPATH>, %A_AHKPATH%

	return fileName
}
