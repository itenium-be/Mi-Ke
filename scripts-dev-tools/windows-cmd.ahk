#IfWinActive ahk_class ConsoleWindowClass

; Control + V works...
^V::SendInput {Raw}%clipboard%

; ESC clears the current line (Control+Home)
; Builtin: Control + End: clear after cursor
ESC::
Send ^{Home}
Send ^{End}
return

#IfWinActive
