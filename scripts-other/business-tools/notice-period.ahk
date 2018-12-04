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
