; Don't go into metro mode when I accidently
; press the left Windows button
; TODO: This should only be active in Windows 8
~LWin Up::
If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 800) {
	; Press again to still go into metro mode
	Send {RWIN}
}
return



~XButton1::
If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500) {
	Send #e
}
return


~XButton2::
If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500) {
	Run, http://192.168.1.27:8009/
}
return



; Laptop has a problem with switching tab status
^CAPSLOCK::
if GetKeyState("CapsLock", "T") = 1
	SetCapsLockState AlwaysOff
else
	SetCapsLockState AlwaysOn
return


; Laptop has problem with a locked AltGr or something?
; AltGr + E results in trying to translate Chrome tab.
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
	Google("vscode+")
return
