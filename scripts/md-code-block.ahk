; Alt+Win+m: Surround selected text with Markdown code block
!#m::
oldClip := clipboard
Send ^c
Sleep, 150
highlighted := clipboard
highlighted := RegExReplace(highlighted, "\r\n?|\n\r?", "`n")

if InStr(highlighted, "`n") > 0 {
	; Multiline
	Send, ``````{space}{enter}
	Send, %highlighted%
	Send, {enter}``````{space}
	Send, {enter}
} else {
	; Single line
	Send, ``{space}%highlighted%``{space}
}
clipboard := oldClip
return


; Ctrl+Alt+Win+m: New Markdown code block
!^#m::
Send, {enter}
Send, ``````{space}
Send, {enter}{enter}
Send, ``````{space}
Send, {up}
return