; Ctrl+Win+X: Translate C:\Users\ to /c/Users/

^#x::
Send, ^c
Sleep, 100

; Replace c:\path\ with c/path/
StringReplace, path, clipboard, \, /, All

; Replace C:/ with c/
StringReplace, path, path, :

path = /%path%/

; Quote directories with spaces in them
path := RegExReplace(path, "(?<=/)((?:[^\\/:*?""<>|])+ (?:[^\\/:*?""<>|])+)(?=/)" , """$1""")

clipboard = %path%

return