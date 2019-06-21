:*:wzh::// TODO: we zaten hier:{space}

:*:mss::misschien
:*:wnn::wanneer
:*:wss::waarschijnlijk
:*:ivm::in verband met
:*:idd::inderdaad
:*:ipv::in plaats van
:*:adhv::aan de hand van

; I mail dutch/english?
:*:imld::Beste ,{enter}{enter}{enter}{enter}Mvg,{enter}Wouter{up}{up}{up}{up}{up}{end}{left}
:*:imle::Dear ,{enter}{enter}{enter}{enter}Cheers,{enter}Wouter{up}{up}{up}{up}{up}{end}{left}



; µ::
; ; KeyWait, µ
; If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
;     send ``
; }
; return

; ; Wait for 'c' to be pressed down again (option "d")
; ; But timeout after T0.5 seconds (If DoubleClickTime is 500)
; KeyWait, c, % "d T"DoubleClickTime/1000
; If ! Errorlevel
;     Msgbox Doublepress
; else
;     Msgbox Singlepress
; Return


:*:atm::at the moment

; :`t:btw::by the way ; BTW is a word... only expand on tab or something?; 


; $e::
; KeyWait, e, T0.2
; If ErrorLevel {
; 	; Timeout = longpress
; 	SendInput {U+20AC}
; 	KeyWait, e
; } Else
; 	Send e
; Return


; a#::
; DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
; ; Wait for 'c' to be released
; KeyWait, a
; if (A_TimeSinceThisHotkey > DoubleClickTime) {
;     Msgbox Longpress
;     return
; }

; ; Wait for 'c' to be pressed down again (option "d")
; ; But timeout after T0.5 seconds (If DoubleClickTime is 500)
; KeyWait, a, % "d T"DoubleClickTime/1000
; If ! Errorlevel
;     Msgbox Doublepress
; else
;     Msgbox Singlepress
; Return
