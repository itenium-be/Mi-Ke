; No dependencies

minimizedWindows :=
minimizedWindowCount :=
windowThatWasActive :=

; Alt+Win+D: minimize all/restore minimized windows on active monitor
!#D::
; Determine which monitor contains the center of the active window
WinGetPos, x, y, w, h, A
activeMonitor := wp_GetMonitorAt(x+w/2, y+h/2)
; A better implementation for 'GetMonitor' is at:
; https://autohotkey.com/board/topic/94735-get-active-monitor/

If minimizedWindowCount =
{
	WinGet, windowThatWasActive, ID, A

	; Minimize and remember
	minimizedWindows := Object()
	minimizedWindowCount := 0

	WinGet windows, List
	Loop %windows%
	{
		id := windows%A_Index%

		WinGetTitle title, ahk_id %id%
		;Notify(A_ScriptName) ; = mike.ahk
		If (title <> "" and title <> A_ScriptName)
		{
			WinGetPos, x, y, w, h, ahk_id %id%
			monitor := wp_GetMonitorAt(x+w/2, y+h/2)
			If (monitor = activeMonitor)
			{
				WinGet windowState, MinMax, ahk_id %id%
				; Window state: 1=max, 0=normal, -1=min
				If (windowState = 0 or windowState = 1)
				{
					WinMinimize, ahk_id %id%
					If (windowState = 1) {
						WinMinimize, ahk_id %id%
					}
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
	WinActivate ahk_id %windowThatWasActive%

	minimizedWindowCount :=
}
return
