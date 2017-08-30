; Control+Shift+C: Append to clipboard
^+c::
bak = %clipboard%
Send, ^c
Sleep, 50
clipboard = %bak%`r`n%clipboard%
Notify("Appended to Clipboard")
Return

; TODO: Print dates in interesting formats :)
; https://autohotkey.com/docs/Hotstrings.htm
; :*:]d::  ; This hotstring replaces "]d" with the current date and time via the commands below.
; FormatTime, CurrentDateTime,, M/d/yyyy h:mm tt  ; It will look like 9/1/2005 3:53 PM
; SendInput %CurrentDateTime%
; return
