; Don't go into metro mode when I accidently
; press the left Windows button

; TODO: This should only be active in Windows 8
~LWin Up::
If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 800) {
	; Press again to still go into metro mode
	Send {RWIN}
}
return


; Laptop has a problem with switching tab status
^CAPSLOCK::
if GetKeyState("CapsLock", "T") = 1
	SetCapsLockState AlwaysOff
else
	SetCapsLockState AlwaysOn
return


CapsLock & E::
SendInput {U+20AC}
return


CAPSLOCK & Z::
	Run, https://www.wunderlist.com/webapp
	Run, https://trello.com/b/Y6Oe6aoI/kandidaten
	Run, https://www.bullhorn.com/client-login/
	Run, https://linkedin.com/
    Run, https://gmail.com
return

CAPSLOCK & D::
	Google("visual+studio+code+")
return
