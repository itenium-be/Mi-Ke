; Control+Shift+C: Append to clipboard
^+c::
bak = %clipboard%
Send, ^c
Sleep, 50
clipboard = %bak%`r`n%clipboard%
Notify("Appended to Clipboard")
Return
