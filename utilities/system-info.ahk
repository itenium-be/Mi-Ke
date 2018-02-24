; Interesting links
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


; TODO: Also cover:
; -- Disk usage
; -- OS info


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; -- Helpers

;converts Size (in bytes) to byte(s)/KB/MB/GB/TB (uses best option)
;decimalPlaces is the number of decimal places to round
autoByteFormat(size, decimalPlaces = 2)
{
	static size1 = "KB", size2 = "MB", size3 = "GB", size4 = "TB"
	sizeIndex := 0

	while (size >= 1024)
	{
		sizeIndex++
		size /= 1024.0

		if (sizeIndex = 4)
			break
	}

	return (sizeIndex = 0) ? size " byte" . (size != 1 ? "s" : "") : round(size, decimalPlaces) . size%sizeIndex%
}
