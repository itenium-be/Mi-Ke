; Stuff to help during doing Autohotkey :)

; TODO: DynaRun: copy some Autohotkey and run it
; TODO: Convert an ahk to exe

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
