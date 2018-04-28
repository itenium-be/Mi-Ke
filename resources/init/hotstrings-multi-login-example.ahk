; A multi login script!
; Logs you in depending on browser used and site title
:*:loginAdv::
	WinGetTitle, title, A

	; These logins work only in Chrome
	#IfWinActive, ahk_class Chrome_WidgetWin
	IfInString, title, ProjectTitle1
		SendInput login1@evilcorp.com{tab}pwd{enter}

	Else IfInString, title, ProjectTitle2
		SendInput login2@evilcorp.com{tab}pwd{enter}

	Else
		SendInput login3@evilcorp.com{tab}pwd{enter}
	#IfWinActive

	; Firefox
	#IfWinActive, ahk_class MozillaWindowClass
	IfInString, title, ProjectTitle1
		SendInput login1@malware.com{tab}pwd{enter}

	Else IfInString, title, ProjectTitle2
		SendInput login2@malware.com{tab}pwd{enter}

	Else
		SendInput login3@malware.com{tab}pwd{enter}
	#IfWinActive
Return

; To find out your ahk_class, startup "Window Spy" which came with your Autohotkey installation
; Perhaps at: c:\Program Files\AutoHotkey\AU3_Spy.exe
; Default shortcut: Alt + F12
