; Stuff to help during doing Autohotkey :)

DevReloadScript:
;^#r::
; Double click tray icon to reload also
Notify("Script Reloaded")
Reload
return


DevListVars:
;!F11::
ListVars
return


; Capslock & A: Copy and google Autohotkey
BrowserSearchAutohotkey:
Send, ^c
Sleep 50
Run, http://www.google.com/search?q=autohotkey+%clipboard%
return
