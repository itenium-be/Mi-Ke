; Ctrl+Win+X: Translate C:\Users\ to /c/Users/

^#x::
Send, ^c
Sleep, 100

StringReplace, path, clipboard, \, /, All
StringReplace, path, path, :,
path = /%path%

clipboard = %path%

return