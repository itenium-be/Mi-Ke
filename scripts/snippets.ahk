; Control+Shift+Win+C: Append to clipboard
; ^+#c::
AppendToClipboard:
	bak = %clipboard%
	clipboard =
	Send, ^c
	ClipWait, 3
	clipboard = %bak%`r`n%clipboard%
	Notify("Appended to Clipboard")
Return


; ^#t
ConvertToTitleCase:
	clipboard =
	Send, ^c
	ClipWait, 3
	StringUpper titleCased, Clipboard, T
	Send %titleCased%
Return



; Ctrl+Win+X: Translate C:\Users\ to /c/Users/
; ^#x::
PathWinToUnix:
	clipboard =
	Send, ^c
	ClipWait, 3

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
	clipboard =
	Send, ^c
	ClipWait, 3
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
