; Control+Shift+Win+C: Append to clipboard
; ^+#c::
AppendToClipboard:
	bak = %clipboard%
	Send, ^c
	Sleep, 50
	clipboard = %bak%`r`n%clipboard%
	Notify("Appended to Clipboard")
Return



; Ctrl+Win+X: Translate C:\Users\ to /c/Users/
; ^#x::
PathWinToUnix:
	Send, ^c
	Sleep, 100

	; Replace c:\path\ with c:/path/
	StringReplace, path, clipboard, \, /, All

	; Replace C:/ with c/
	StringReplace, path, path, :

	path = /%path%/

	; Quote directories with spaces in them
	path := RegExReplace(path, "(?<=/)(([^\\/:*?""<>|]+) (?2))(?=/)" , """$1""")

	clipboard = %path%
return



; Alt+Win+m: Surround selected text with Markdown code block
; !#m::
MdCodeBlockSurround:
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


; Ctrl+Win+Alt+m: New Markdown code block
; ^#!m::
MdCodeBlockNew:
	Send, {enter}
	Send, ``````{space}
	Send, {enter}{enter}
	Send, ``````{space}
	Send, {up}
return
