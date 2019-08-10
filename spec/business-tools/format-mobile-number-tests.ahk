SetWorkingDir, %A_ScriptDir%\..\..\
#Include ..\Yunit\Yunit.ahk
; #Include ..\Yunit\Window.ahk
#Include ..\Yunit\StdOut.ahk
; #Include ..\Yunit\JUnit.ahk
; #Include ..\Yunit\OutputDebug.ahk

#Include ..\..\vendor\yaml.ahk

Notify(msg, title = "", time = 1) {
}

#Include ..\..\scripts-other\business-tools\format-mobile-number.ahk

; Yunit.Use(YunitStdOut, YunitWindow, YunitJUnit, YunitOutputDebug).Test(FormatMobileNumberTests)
Yunit.Use(YunitPorcelainStdOut).Test(FormatMobileNumberTests)

class FormatMobileNumberTests
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

		NumbersOnly()
		{
			formatted := FormatMobileNumber("0476403542", this.params)
			Yunit.that(this.result, formatted)
		}

		WithSeparators()
		{
			formatted := FormatMobileNumber("0476 40.35 42", this.params)
			Yunit.that(this.result, formatted)
		}

		WithPrefixSeparator()
		{
			formatted := FormatMobileNumber("0476 / 40.35.42", this.params)
			Yunit.that(this.result, formatted)
		}
	}

	class WithCountryPrefix
	{
		Begin()
		{
			config := Yaml(A_Workingdir "\config\business-tools.yml")
			mobileConfig := config["Format mobile number"]
			this.params := mobileConfig.params
			this.result := "+32 (0)476 40 35 42"
		}

		WithPlus()
		{
			formatted := FormatMobileNumber("+32 476 403542", this.params)
			Yunit.that(this.result, formatted)
		}

		WithZeroZero()
		{
			formatted := FormatMobileNumber("0032 4 76 403 542", this.params)
			Yunit.that(this.result, formatted)
		}

		WithZeroZeroAndExtraZoneZero()
		{
			formatted := FormatMobileNumber("0032 0476 403 542", this.params)
			Yunit.that(this.result, formatted)
		}

		WithZeroZeroAndCountrySeparator()
		{
			formatted := FormatMobileNumber("0032/ 4 76.403.542", this.params)
			Yunit.that(this.result, formatted)
		}
	}
}
