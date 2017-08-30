; Hotstring example
:*:atm::at the moment
; Type atm anywhere and have it expanded to "at the moment" immediately

; Trigger hotstring only if followed by one of the EndChars
::devlogin::tyler@company.com{tab}superSecretPassword{enter}
; #Hotstring EndChars -()[]{}:;'"/\,.?!`n `t

; Expand imail only after pressing tab
:´t:imail::your.name@glogle.com


; Include more hotstrings here:
#Include %A_Scriptdir%\hotstrings\personal.ahk
; #Include %A_Scriptdir%\hotstrings\misc.ahk
; #Include %A_Scriptdir%\hotstrings\work.ahk


; A multi login script!
; Logs you in depending on browser used and site title
; :*:loginAdv::
; 	WinGetTitle, title, A

; 	; These logins work only in Chrome
; 	#IfWinActive, ahk_class Chrome_WidgetWin
; 		IfInString, title, ProjectTitle1
; 			SendInput login1@evilcorp.com{tab}pwd{enter}

; 		Else IfInString, title, ProjectTitle2
; 			SendInput login2@evilcorp.com{tab}pwd{enter}

; 		Else
; 			SendInput login3@evilcorp.com{tab}pwd{enter}
; 	#IfWinActive

; 	; Firefox
; 	#IfWinActive, ahk_class MozillaWindowClass
; 		IfInString, title, ProjectTitle1
; 			SendInput login1@malware.com{tab}pwd{enter}

; 		Else IfInString, title, ProjectTitle2
; 			SendInput login2@malware.com{tab}pwd{enter}

; 		Else
; 			SendInput login3@malware.com{tab}pwd{enter}
; 	#IfWinActive
; Return

; To find out your ahk_class, startup "Window Spy" which came with your Autohotkey installation
; Perhaps at: c:\Program Files\AutoHotkey\AU3_Spy.exe
