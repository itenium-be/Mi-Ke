
; Username:
:*:irdn::wvsbi42




; Execute query in SQL Server Management Studio
; TODO: Add Ssms to "QuickStarters" and also add this script...
#IfWinActive, ahk_exe Ssms.exe

F9::
; Poor mans "execute statement the cursor is currently on"
; --> It breaks down as soon as the SQL spans more than one line...
; Send, {Control Down}KU{Control Up}
Send {Home}{Shift Down}{End}{Shift Up}
Send {F5}
return

#IfWinActive
