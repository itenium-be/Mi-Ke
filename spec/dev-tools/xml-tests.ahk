SetWorkingDir, %A_ScriptDir%\..\..\
#Include ..\lib\Yunit.ahk
; #Include ..\lib\Window.ahk
#Include ..\lib\StdOut.ahk
; #Include ..\lib\JUnit.ahk
; #Include ..\lib\OutputDebug.ahk

Notify(msg, title = "", time = 1) {
}

#Include ..\..\scripts-dev-tools\xml.ahk

; Yunit.Use(YunitStdOut, YunitWindow, YunitJUnit, YunitOutputDebug).Test(FormatMobileNumberTestSuite)
Yunit.Use(YunitStdOut).Test(XmlSuite)

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
