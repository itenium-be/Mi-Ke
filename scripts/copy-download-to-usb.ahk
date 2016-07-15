; Open Explorers
; Newly downloaded files directory on the left
; USB drive on the right
; Hotkey: AltGr+Win+D
; Requires: WindowPad
<^>!#d::
usbDrive := GetUsbDrive()
If usbDrive
{
	downloadPath = C:\Users\Wouter\Downloads

	IfWinNotExist Downloads
	{
		Run %downloadPath%
		;Run %downloadPath%
		;WinWait ahk_pid %downloadWindow%
		Sleep, 500
		WindowPadMove(-1, -1, 0.5, 1, "")

		Run %usbDrive%
		Sleep, 500
		WindowPadMove(1, 0, 0.5, 1, "")
	}
	else
	{
		WinClose

		; TitleMatchMode == RegEx
		usbDrive := StrReplace(usbDrive, "\", "\\")
		IfWinExist %usbDrive%
		{
			WinClose
		}
	}
}
else
{
	if IsFunc("Notify")
	{
		Notify("No Usb drive?")
	}
}

GetUsbDrive()
{
	DriveGet, list, list
	Loop, Parse, list
	{
		drive = %A_LoopField%:\

		;DriveGet, cap, capacity, %drive%
		;DrivespaceFree, free, %drive%
		DriveGet, fs, fs, %drive%
		;DriveGet, label, label, %drive%
		;DriveGet, serial, serial, %drive%
		DriveGet, type, type, %drive%
		DriveGet, status, status, %drive%

		if type = Removable
		{
			if status = Ready
			{
				return %drive%
			}
		}
	}
}

return