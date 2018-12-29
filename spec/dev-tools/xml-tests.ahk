SetWorkingDir, %A_ScriptDir%\..\..\
#Include ..\Yunit\Yunit.ahk
; #Include ..\Yunit\Window.ahk
#Include ..\Yunit\StdOut.ahk
; #Include ..\Yunit\JUnit.ahk
; #Include ..\Yunit\OutputDebug.ahk

Notify(msg, title = "", time = 1) {
}

#Include ..\..\scripts-dev-tools\xml.ahk

; Yunit.Use(YunitStdOut, YunitWindow, YunitJUnit, YunitOutputDebug).Test(FormatMobileNumberTests)
Yunit.Use(YunitPorcelainStdOut).Test(XmlTests)

class XmlTests
{
	Begin()
	{
		this.ugly := "<xml><yaye>test</yaye></xml>"
		this.pretty := "<xml>`n`t<yaye>test</yaye>`n</xml>"
	}

	Prettify()
	{
		; last argument "" is params (not used)
		result := XmlPrettify(this.ugly, "")
		Yunit.that(result, this.pretty)
	}

	Uglify()
	{
		result := XmlUglify(this.pretty, "")
		Yunit.that(result, this.ugly)
	}
}
