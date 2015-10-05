; Open Explorers
; Newly downloaded files directory on the left
; USB drive on the right
; Hotkey: AltGr+Win+D
GetUsbDrive() {
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

<^>!#d::
usbDrive := GetUsbDrive()
If usbDrive
{
	SetTitleMatchMode RegEx
	IfWinNotExist !Download
	{
		Run C:\Users\Wouter\Downloads
		Sleep, 400
		WindowPadMove(-1, -1, 0.5, 1, "")

		Run %usbDrive%
		Sleep, 400
		WindowPadMove(1, 0, 0.5, 1, "")
	}
	else
	{
		WinClose

		IfWinExist \(%usbDrive%)
		{
			WinClose
		}
	}
}
else
{
	MsgBox No Usb drive?
}
return