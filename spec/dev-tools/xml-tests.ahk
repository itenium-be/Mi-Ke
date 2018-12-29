SetWorkingDir, %A_ScriptDir%\..\..\
#Include ..\Yunit\Yunit.ahk
; #Include ..\Yunit\Window.ahk
#Include ..\Yunit\StdOut.ahk
; #Include ..\Yunit\JUnit.ahk
; #Include ..\Yunit\OutputDebug.ahk

Notify(msg, title = "", time = 1) {
}

#Include ..\..\scripts-dev-tools\xml.ahk

; Yunit.Use(YunitStdOut, YunitWindow, YunitJUnit, YunitOutputDebug).Test(FormatMobileNumberTestSuite)
Yunit.Use(YunitPorcelainStdOut).Test(XmlSuite)

class XmlSuite
{
	Begin()
	{
		this.ugly := "<xml><yaye>test</yaye></xml>"
		this.pretty := "<xml>`n`t<yaye>test</yaye>`n</xml>"
	}

	Test_Prettify()
	{
		; last argument "" is params (not used)
		result := XmlPrettify(this.ugly, "")
		Yunit.assert(result = this.pretty)
	}

	Test_Uglify()
	{
		result := XmlUglify(this.pretty, "")
		Yunit.assert(result = this.ugly)
	}
}
