; Alt+Win+D: minimize all/restore minimized windows on active monitor
minimizedWindows :=
minimizedWindowCount :=

!#D::
; Determine which monitor contains the center of the active window
WinGetPos, x, y, w, h, A
activeMonitor := wp_GetMonitorAt(x+w/2, y+h/2)
; A better implementation for 'GetMonitor' is at:
; https://autohotkey.com/board/topic/94735-get-active-monitor/

If minimizedWindowCount =
{
	; Minimize and remember
	minimizedWindows := Object()
	minimizedWindowCount := 0

	WinGet windows, List
	Loop %windows%
	{
		id := windows%A_Index%

		WinGetTitle title, ahk_id %id%
		If (title <> "" and title <> "mike.ahk")
		{
			WinGetPos, x, y, w, h, ahk_id %id%
			monitor := wp_GetMonitorAt(x+w/2, y+h/2)
			If (monitor = activeMonitor)
			{
				WinGet isMinimized, MinMax, ahk_id %id%
				If (isMinimized = 0)
				{
					WinMinimize, ahk_id %id%
					minimizedWindows.Insert(id)
					minimizedWindowCount++
				}
			}
		}
	}
}
else
{
	; Restore
	for index, element in minimizedWindows
	{
		WinRestore, ahk_id %element%
	}

	minimizedWindowCount :=
}
return
