; Ctrl+Win+X: Translate C:\Users\ to /c/Users/
PathWinToUnix:
	clipVal := CopyAndSaveClip()

	; Replace c:\path\ with c:/path/
	StringReplace, path, clipVal, \, /, All

	; Replace C:/ with c/
	StringReplace, path, path, :

	path = /%path%

	; Quote directories with spaces in them
	path := RegExReplace(path, "(?<=/)(([^\\/:*?""<>|]+) (?2))(?=/)" , """$1""")

	Notify("New path", path)
	clipboard = %path%
return
