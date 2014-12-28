; Open Explorers
; Newly downloaded files directory on the left
; USB drive on the right
; Hotkey: AltGr+Win+D
<^>!#d::
SetTitleMatchMode RegEx
IfWinNotExist !Download
{
	Run H:\!Download
	Sleep, 400
	WindowPadMove(-1, -1, 0.5, 1, "")

	Run J:\
	Sleep, 400
	WindowPadMove(1, 0, 0.5, 1, "")
}
else
{
	WinClose

	IfWinExist \(J:\)
	{
		WinClose
	}
}


return