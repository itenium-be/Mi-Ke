; Alt+Win+c: Surround selected text with Markdown code block
!#c::
oldClip := clipboard
Send ^c
ClipWait
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


; Ctrl+Alt+Win+c: New Markdown code block
!^#c::
Send, {enter}
Send, ``````{space}
Send, {enter}{enter}
Send, ``````{space}
Send, {up}
return