; ------------------------------------------------------
; ------------- RETRIEVE CONSOLE'S OUTPUTS -------------
; ------------------------------------------------------
;http://msdn.microsoft.com/en-us/library/cbxxzwb5%28v=VS.85%29.aspx
;http://technet.microsoft.com/en-us/library/ee156605.aspx
objShell := ComObjCreate("WScript.Shell")
objExec := objShell.Exec("ipconfig.exe")
While !objExec.Status	;wait until ipconfig.exe starts
    Sleep 100
strLine := objExec.StdOut.ReadAll()	;read the output at once
msgbox % strLine

; ping
objExec := objShell.Exec("cmd /c ping -n 3 -w 1000 www.google.com")
While !objExec.StdOut.AtEndOfStream ;read the output line by line
	if InStr(objExec.StdOut.ReadLine(), "Reply") {
		Msgbox Reply received.
		Break
	}
