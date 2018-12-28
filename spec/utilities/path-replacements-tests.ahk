SetWorkingDir, %A_ScriptDir%\..\..\
#Include ..\lib\Yunit.ahk
; #Include ..\lib\Window.ahk
#Include ..\lib\StdOut.ahk
; #Include ..\lib\JUnit.ahk
; #Include ..\lib\OutputDebug.ahk

Notify(msg, title = "", time = 1) {
}

#Include ..\..\utilities\path-replacements.ahk

; Yunit.Use(YunitStdOut, YunitWindow, YunitJUnit, YunitOutputDebug).Test(PathReplacementsTestSuite)
Yunit.Use(YunitStdOut).Test(PathReplacementsTestSuite)

class PathReplacementsTestSuite
{
	Test_WithoutReplacements()
	{
		result := PathReplacements("c:\test.txt")
		Yunit.assert(result = "c:\test.txt")
	}

	Test_WithProgramFiles()
	{
		; ATTN: UnitWhat? Hard FileSystem dependency here! We probably have git installed? :)
		result := PathReplacements("<A_PROGRAMFILES>\Git\bin\git.exe")
		Yunit.assert(result = "c:\program files\Git\bin\git.exe" or result = "c:\program files (x86)\Git\bin\git.exe")
	}

	Test_WithRegex()
	{
		result := PathReplacements("<A_WINDIR>\expl/[or]{2}/er.exe")
		Yunit.assert(result = "c:\windows\explorer.exe")
	}

	Test_WithRegexAndProgramFiles()
	{
		result := PathReplacements("<A_PROGRAMFILES>\Git\bi/(n|[0-9])/\git.exe")
		Yunit.assert(result = "c:\program files\Git\bin\git.exe" or result = "c:\program files (x86)\Git\bin\git.exe")

		result := PathReplacements("<A_PROGRAMFILES>\Git\etc\ss/h/\ssh_config")
		Yunit.assert(result = "c:\program files\Git\etc\ssh\ssh_config" or result = "c:\program files (x86)\Git\etc\ssh\ssh_config")
	}


	Test_WithRobo3T()
	{
		result := PathReplacements("<A_PROGRAMFILES>\Robo 3T 1.1./[0-9]/\robo3t.exe")
		Yunit.assert(result = "c:\Program Files\Robo 3T 1.1.1\robo3t.exe")
	}
}
