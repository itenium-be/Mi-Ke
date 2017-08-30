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
#Include %A_Scriptdir%\hotstrings\misc.ahk
#Include %A_Scriptdir%\hotstrings\work.ahk
#Include %A_Scriptdir%\hotstrings\pongit.ahk
