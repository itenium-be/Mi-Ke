SetWorkingDir, %A_ScriptDir%\..\..\
#Include ..\Yunit\Yunit.ahk
; #Include ..\Yunit\Window.ahk
#Include ..\Yunit\StdOut.ahk
; #Include ..\Yunit\JUnit.ahk
; #Include ..\Yunit\OutputDebug.ahk

Notify(msg, title = "", time = 1) {
}

#Include ..\..\utilities\path-replacements.ahk

; Yunit.Use(YunitStdOut, YunitWindow, YunitJUnit, YunitOutputDebug).Test(PathReplacementsTests)
Yunit.Use(YunitPorcelainStdOut).Test(PathReplacementsTests)

class PathReplacementsTests
{
	Begin()
	{
		this.git := "c:\program files (x86)\Git\bin\git.exe"
	}

	WithoutReplacements()
	{
		result := PathReplacements("c:\test.txt")
		Yunit.that("c:\test.txt", result)
	}

	WithProgramFiles()
	{
		; ATTN: UnitWhat? Hard FileSystem dependency here! We probably have git installed? :)
		result := PathReplacements("<A_PROGRAMFILES>\Git\bin\git.exe")
		Yunit.that(this.git, result)
	}

	WithRegex()
	{
		result := PathReplacements("<A_WINDIR>\expl/[or]{2}/er.exe")
		Yunit.that("c:\windows\explorer.exe", result)
	}

	WithRegexAndProgramFiles()
	{
		result := PathReplacements("<A_PROGRAMFILES>\Git\bi/(n|[0-9])/\git.exe")
		Yunit.assert(this.git, result)

		result := PathReplacements("<A_PROGRAMFILES>\Git\etc\ss/h/\ssh_config")
		Yunit.that("c:\program files (x86)\Git\etc\ssh\ssh_config", result)
	}


	WithRobo3T()
	{
		result := PathReplacements("<A_PROGRAMFILES>\Robo 3T 1.1./[0-9]/\robo3t.exe")
		Yunit.that("c:\Program Files\Robo 3T 1.1.1\robo3t.exe", result)
	}
}
