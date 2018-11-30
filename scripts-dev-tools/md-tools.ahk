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


MdCodeEmpty() {
	Send, ````{space}{BS}{Left}
}
