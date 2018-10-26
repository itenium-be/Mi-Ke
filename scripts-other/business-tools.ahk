ValidIBANAndInform(n) {
	isValid := ValidIBAN(n)
	Notify(isValid ? "VALID IBAN" : "INVALID IBAN", n "`n" (isValid ? "Is valid" : "Is not valid"))
}

ValidIBAN(n) {
	static CC := {AL:28, AD:24, AT:20, AZ:28, BH:22, BE:16, BA:20, BR:29, BG:22, CR:21
		    , HR:21, CY:28, CZ:24, DK:18, DO:28, EE:20, FO:18, FI:18, FR:27, GE:22
		    , DE:22, GI:23, GR:27, GL:18, GT:28, HU:28, IS:26, IE:22, IL:23, IT:27
		    , JO:30, KZ:20, KW:30, LV:21, LB:28, LI:21, LT:20, LU:20, MK:19, MT:31
		    , MR:27, MU:30, MC:27, MD:24, ME:22, NL:18, NO:15, PK:24, PS:29, PL:28
		    , PT:25, QA:29, RO:24, SM:27, SA:24, RS:22, SK:24, SI:19, ES:24, SE:24
		    , CH:21, TN:24, TR:26, AE:23, GB:22, VG:24}
	StringReplace, n, n, % A_Space,, A
	;Check that the total IBAN length is correct as per the country
	if (StrLen(n) != CC[SubStr(n, 1, 2)])
		return false
	StringUpper, n, n
	;Move the four initial characters to the end of the string
	n := SubStr(n, 5) SubStr(n, 1, 4)
	;Replace each letter in the string with two digits
	Loop, Parse, n
	{
		if A_LoopField is alpha
			nn .= Asc(A_LoopField) - 55
		else
			nn .= A_LoopField
	}
	return Mod97(nn) = 1
}


Mod97(a) {
	while a {
		rem := Mod(rem SubStr(a, 1, 15), 97)
		a := SubStr(a, 16)
	}
	return rem
}




global EmployeeStartDate

; Accepts a year, a year+month or a year+month+day as input
; ex: 2015, 2015-09, 2015-09-01, 2018-06-01
CalculateNoticePeriod(input) {
	input := RegExReplace(input, "\D" , "")
	if (StrLen(input) = 4) {
		input .= "0101"
	}
	else if (StrLen(input) = 6) {
		input .= "01"
	}

	Gui, Add, Text,, Please enter employee start date:
	Gui, Add, MonthCal, vEmployeeStartDate, %input%
	Gui, Add, Button, Default, &OK
	Gui, Show
}

GuiClose:
ButtonOK:
Gui, Submit

FormatTime, CurrentDate,, yyyyMMdd
EnvSub, CurrentDate, %EmployeeStartDate%, days

daysEmployed := CurrentDate
monthsEmployed := daysEmployed / 30

if (monthsEmployed < 3) {
	weeksNotice := 1
} else if (monthsEmployed < 6) {
	weeksNotice := 2
} else if (monthsEmployed < 12) {
	weeksNotice := 3
} else if (monthsEmployed < 18) {
	weeksNotice := 4
} else if (monthsEmployed < 24) {
	weeksNotice := 5
} else if (monthsEmployed < 4 * 12) {
	weeksNotice := 6
} else if (monthsEmployed < 5 * 12) {
	weeksNotice := 7
} else if (monthsEmployed < 6 * 12) {
	weeksNotice := 9
} else if (monthsEmployed < 7 * 12) {
	weeksNotice := 10
} else if (monthsEmployed < 8 * 12) {
	weeksNotice := 12
} else {
	weeksNotice := 13
}

yearsEmployed := Floor(monthsEmployed / 12)
monthsEmployed := Round(monthsEmployed - (yearsEmployed * 12), 1)

employedForDesc := ""
if (yearsEmployed > 0) {
	employedForDesc := yearsEmployed " year(s)"
	if (monthsEmployed > 0) {
		employedForDesc .= " and "
	}
}
if (monthsEmployed > 0) {
	employedForDesc .= Round(monthsEmployed, 1) " month(s)"
}

Gui, Destroy

Notify("Notice period: " weeksNotice " weeks", "Employed for " employedForDesc)
return

; Anciënniteit
; Opzegging door de werknemer (in weken)
; Van 0 tot minder dan drie maanden => 1
; Van drie maanden tot minder dan zes maanden => 2
; Van zes maanden tot minder dan twaalf maanden => 3
; Van twaalf maanden tot minder dan 18 maanden => 4
; Van 18 maanden tot minder dan 24 maanden => 5
; Van 2 jaar tot minder dan 4 jaar => 6
; Van 4 jaar tot minder dan 5 jaar => 7
; Van 5 jaar tot minder dan 6 jaar => 9
; Van 6 jaar tot minder dan 7 jaar => 10
; Van 7 jaar tot minder dan 8 jaar => 12
; Vanaf 8 jaar => 13



CalculatePostcode(city) {
	FileRead, postcodesFileContent, %A_ScriptDir%\resources\postcodes-belgium.json
	postcodes := JSON.parse(postcodesFileContent, true)

	; TODO: Fuzzy matching with Levenshtein?
	; Already included: LDistance() & DLDistance()
	; Might want to take into account: é/e, dashes, 's, ...

	foundCount := 0
	results :=

	city := Trim(city, " `t`n`r")

	for index, element in postcodes
	{
	 	if (city = element.city or StrReplace(city, " ", "-") = element.city) {
	 		foundCount += 1
	 		results .= element.city " (" element.province "): " element.postcode "`n"
			clipboard := element.postcode
		}
	}

	if (foundCount = 0) {
		Notify("Postcode not found", city)
	} else {
		StringUpper results, results, T
		results := Trim(results, "`n")
		Notify("Postcode(s) " city, results, 5)
	}
}
