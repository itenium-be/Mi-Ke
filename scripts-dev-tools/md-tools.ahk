; Surround selected text with Markdown code block
MdCodeBlockSurround(highlighted) {
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
}


; New Markdown code block
MdCodeBlockNew:
	Send, ``````{space}
	Send, {enter}{enter}
	Send, ``````{space}
	Send, {up}{up}{end}
return


MdBold(string) {
	Send **%string%**
}


MdCodeSurround(string) {
	Send ``%string%``%A_SPACE%
}


; ATTN: Don't attempt to do this again. I just doesn't work with
; Belgian keyboard because it waits for for another keystroke to
; form something like "à". It does not look like there is a way
; around this behavior?
MdCodeEmpty(string) {
	Send ``
	; Send ``
	; Send %A_SPACE%
		; Sleep 50
	; SendInput %LEFT%
}
