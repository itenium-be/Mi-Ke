ReadMikeIni(sectionName, key := "", replacePaths := false)
{
	ini = %A_Scriptdir%\config\mike.ini
	IfExist %ini%
	{
		IniRead, value, %ini%, %sectionName%, %key%
	}

	if (value = "ERROR" or value = "")
	{
		IniRead, value, %A_Scriptdir%\config\mike.default.ini, %sectionName%, %key%
	}

	if (value = "ERROR" or (value = "" and key = "")) {
		MsgBox Error reading from ini. Section="%sectionName%", Key="%key%"

	} else {
		if replacePaths
			value := PathReplacements(value)
		return value
	}
}

WriteMikeIni(value, sectionName, key)
{
	; mike.ini should've been created with init.ps1
	ini = %A_Scriptdir%\config\mike.ini
	IfNotExist %ini%
		FileAppend, `; Overwrite settings here, %ini%
		; ini = %A_Scriptdir%\config\mike.default.ini

	IniWrite, %value%, %ini%, %sectionName%, %key%
}
