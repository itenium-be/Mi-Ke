:*:wzh::// TODO: we zaten hier:{space}

:*:mss::misschien
:*:wnn::wanneer
:*:wss::waarschijnlijk
:*:ivm::in verband met
:*:idd::inderdaad
:*:ipv::in plaats van
:*:adhv::aan de hand van

; I mail dutch/english?
:*:imld::
IfWinActive, ahk_exe OUTLOOK.EXE
{
	; ol:=COM_GetActiveObject("Outlook.Application").ActiveInspector.CurrentItem
	; From:=ol.SenderName
	; Subj:=ol.Subject
	; MsgBox % From "`n" Subj

	ControlGetText, toName, RichEdit20WPT1, Untitled - Message (HTML)

	msgbox % toName

	Send Beste ,{enter}{enter}{enter}{enter}met vriendelijke groet,{enter}Wouter{up}{up}{up}{up}{up}{end}{left}
}
return

:*:imle::Dear ,{enter}{enter}{enter}{enter}Cheers,{enter}Wouter{up}{up}{up}{up}{up}{end}{left}

:*:atm::at the moment

; :`t:btw::by the way ; BTW is a word... only expand on tab or something?
