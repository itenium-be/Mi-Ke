GetSystemInformation() {
	inputStr := "Computer: <A_ComputerName>`nUser: <A_UserName>@<A_DomainName>"

	result := ReplaceSystemInfo(inputStr)
	result .= (A_IsAdmin ? " (admin)" : "")
	result .= ReplaceSystemInfo("`nOS: <A_OSVersion> (<A_Is64bitOS>bit)")

	; A_Language: http://msdn.microsoft.com/en-us/library/aa912040
	result .= ReplaceSystemInfo("`nLang: <A_Language>`nScreen size: <A_ScreenWidth>x<A_ScreenHeight>")

	; Snippet to retrieve screen size of non primary monitors:
	; https://autohotkey.com/docs/commands/SysGet.htm
	; SysGet, MonitorCount, MonitorCount
	; SysGet, MonitorPrimary, MonitorPrimary
	; MsgBox, Monitor Count:`t%MonitorCount%`nPrimary Monitor:`t%MonitorPrimary%
	; Loop, %MonitorCount%
	; {
	;     SysGet, MonitorName, MonitorName, %A_Index%
	;     SysGet, Monitor, Monitor, %A_Index%
	;     SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%
	;     MsgBox, Monitor:`t#%A_Index%`nName:`t%MonitorName%`nLeft:`t%MonitorLeft% (%MonitorWorkAreaLeft% work)`nTop:`t%MonitorTop% (%MonitorWorkAreaTop% work)`nRight:`t%MonitorRight% (%MonitorWorkAreaRight% work)`nBottom:`t%MonitorBottom% (%MonitorWorkAreaBottom% work)
	; }

	result .= ReplaceSystemInfo("`nUptime: <UpTime> hours (<UpTimeDays> days)")

	return result
}


ReplaceSystemInfo(inputStr) {
	if (InStr(inputStr, "<CPULoad>")) {
		inputStr := StrReplace(inputStr, "<CPULoad>", CPULoad())
	}

	if (InStr(inputStr, "<ramUsed>") or InStr(inputStr, "<ramTotal>") or InStr(inputStr, "<ramUsed%>")) {
		memory := GetMemoryStatus()
		inputStr := StrReplace(inputStr, "<ramUsed>", memory.ramPhysicalUsed)
		inputStr := StrReplace(inputStr, "<ramTotal>", memory.ramPhysicalTotal)
		inputStr := StrReplace(inputStr, "<ramUsed%>", memory.ramPhysicalPercentage)
	}

	inputStr := StrReplace(inputStr, "<A_ComputerName>", A_ComputerName)
	inputStr := StrReplace(inputStr, "<A_UserName>", A_UserName)
	EnvGet, Domain, USERDOMAIN
	inputStr := StrReplace(inputStr, "<A_DomainName>", Domain)
	inputStr := StrReplace(inputStr, "<A_OSVersion>", A_OSVersion)
	inputStr := StrReplace(inputStr, "<A_IsAdmin>", A_IsAdmin)
	inputStr := StrReplace(inputStr, "<A_Is64bitOS>", (A_Is64bitOS ? "64" : "32"))
	inputStr := StrReplace(inputStr, "<A_Language>", A_Language)
	inputStr := StrReplace(inputStr, "<A_ScreenWidth>", A_ScreenWidth)
	inputStr := StrReplace(inputStr, "<A_ScreenHeight>", A_ScreenHeight)

	UpTime := Floor(((A_TickCount / 1000) / 60) / 60)
	UpTimeDays := Round(UpTime / 24, 1)
	inputStr := StrReplace(inputStr, "<Uptime>", UpTime)
	inputStr := StrReplace(inputStr, "<UptimeDays>", UpTimeDays)

	if (InStr(inputStr, "<PublicIP>")) {
		; Takes some time and when used for tray tooltip
		; It might display 'mike.ahk' on the first hover
		inputStr := StrReplace(inputStr, "<PublicIP>", GetPublicIP())
	}
	if (InStr(inputStr, "<PrivateIP>")) {
		inputStr := StrReplace(inputStr, "<PrivateIP>", GetLocalIPByAdaptor("Ethernet"))
	}

	return inputStr
}



; Interesting links
; https://autohotkey.com/board/topic/60968-wmi-tasks-com-with-ahk-l/
; https://github.com/jNizM/AHK_Process_Explorer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; -- RAM
; Excerpt from htopmini v0.8.3
; by jNizM
; http://ahkscript.org/boards/viewtopic.php?f=6&t=254
; https://github.com/jNizM/htopmini/blob/master/src/htopmini.ahk
GetMemoryStatus()
{
	GMSEx := GetRawMemoryStatus()
	GMSExM01 := Round(GMSEx[2], 1)            ; Total Physical Memory in bytes
	GMSExM02 := Round(GMSEx[3], 1)            ; Available Physical Memory in bytes
	GMSExM03 := Round(GMSExM01 - GMSExM02, 1)           ; Used Physical Memory in bytes
	GMSExM04 := Round(GMSExM03 / GMSExM01 * 100, 1)     ; Used Physical Memory in %
	GMSExS01 := Round(GMSEx[4] / 1024**2, 1)            ; Total PageFile in bytes
	GMSExS02 := Round(GMSEx[5] / 1024**2, 1)            ; Available PageFile in bytes
	GMSExS03 := Round(GMSExS01 - GMSExS02, 1)           ; Used PageFile in bytes
	GMSExS04 := Round(GMSExS03 / GMSExS01 * 100, 1)     ; Used PageFile in %

	retValue := {}
	retValue.ramPhysicalTotal := autoByteFormat(GMSExM01, 0)
	retValue.ramPhysicalUsed := autoByteFormat(GMSExM03, 1)
	retValue.ramPhysicalPercentage := GMSExM04
	return, retValue
}

GetRawMemoryStatus() {
	static MEMORYSTATUSEX, init := VarSetCapacity(MEMORYSTATUSEX, 64, 0) && NumPut(64, MEMORYSTATUSEX, "UInt")
	if (DllCall("Kernel32.dll\GlobalMemoryStatusEx", "Ptr", &MEMORYSTATUSEX))
	{
		return { 2 : NumGet(MEMORYSTATUSEX, 8, "UInt64")
			, 3 : NumGet(MEMORYSTATUSEX, 16, "UInt64")
			, 4 : NumGet(MEMORYSTATUSEX, 24, "UInt64")
			, 5 : NumGet(MEMORYSTATUSEX, 32, "UInt64") }
	}
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; -- CPU

CPULoad() ; by SKAN
{
	static PIT, PKT, PUT
	if (Pit = "")
	{
		return 0, DllCall("GetSystemTimes", "Int64P", PIT, "Int64P", PKT, "Int64P", PUT)
	}
	DllCall("GetSystemTimes", "Int64P", CIT, "Int64P", CKT, "Int64P", CUT)
	IdleTime := PIT - CIT, KernelTime := PKT - CKT, UserTime := PUT - CUT
	SystemTime := KernelTime + UserTime
	return ((SystemTime - IdleTime) * 100) // SystemTime, PIT := CIT, PKT := CKT, PUT := CUT
}
