SetWorkingDir, %A_ScriptDir%\..\..\
#Include ..\lib\Yunit.ahk
#Include ..\lib\Window.ahk
#Include ..\lib\StdOut.ahk
#Include ..\lib\JUnit.ahk
#Include ..\lib\OutputDebug.ahk

#Include ..\..\vendor\yaml.ahk

Notify(msg, title = "", time = 1) {
}

#Include ..\..\scripts-other\business-tools\format-mobile-number.ahk

Yunit.Use(YunitStdOut, YunitWindow, YunitJUnit, YunitOutputDebug).Test(FormatMobileNumberTestSuite)
; Yunit.Use(YunitStdOut).Test(FormatMobileNumberTestSuite)

class FormatMobileNumberTestSuite
{
	class WithoutCountryPrefix
	{
		Begin()
		{
			config := Yaml(A_WorkingDir "\config\business-tools.yml")
			mobileConfig := config["Format mobile number"]
			; msgbox % mobileConfig.params.Dump()
			this.params := mobileConfig.params
			this.result := "+32 (0)476 40 35 42"
		}

		Test_NumbersOnly()
		{
			formatted := FormatMobileNumber("0476403542", this.params)
			Yunit.assert(formatted = this.result)
		}

		Test_WithSeparators()
		{
			formatted := FormatMobileNumber("0476 40.35 42", this.params)
			Yunit.assert(formatted = this.result)
		}

		Test_WithPrefixSeparator()
		{
			formatted := FormatMobileNumber("0476 / 40.35.42", this.params)
			Yunit.assert(formatted = this.result)
		}
	}

	class WithCountryPrefix
	{
		Begin()
		{
			config := Yaml(A_Workingdir "\config\business-tools.yml")
			mobileConfig := config["Format mobile number"]
			; msgbox % mobileConfig.params.Dump()
			this.params := mobileConfig.params
			this.result := "+32 (0)476 40 35 42"
		}

		Test_WithPlus()
		{
			formatted := FormatMobileNumber("+32 476 403542", this.params)
			Yunit.assert(formatted = this.result)
		}

		Test_WithZeroZero()
		{
			formatted := FormatMobileNumber("0032 4 76 403 542", this.params)
			Yunit.assert(formatted = this.result)
		}

		Test_WithZeroZeroAndExtraZoneZero()
		{
			formatted := FormatMobileNumber("0032 0476 403 542", this.params)
			Yunit.assert(formatted = this.result)
		}

		Test_WithZeroZeroAndCountrySeparator()
		{
			formatted := FormatMobileNumber("0032/ 4 76.403.542", this.params)
			Yunit.assert(formatted = this.result)
		}
	}

	; End() {}
}
