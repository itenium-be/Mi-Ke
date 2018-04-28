
GoToEditEnvironmentVariables() {
	Run % "control.exe sysdm.cpl,System,3"
	WinWaitActive System Properties ahk_class #32770, ,2
	; Send {ALT DOWN}n{ALT UP}
	; Send !n!sp
}



OpenRemoteDesktop:
qs := GetQuickStarterInfoByLabel("OpenRemoteDesktop")

clipVal := CopyAndSaveClip()
if (clipVal) {
	Run % qs.path " /v:" clipVal
} else {
	Run % qs.path
}
RestoreClip()

; Full CLI:
; mstsc.exe {ConnectionFile | /v:ServerName[:Port]} [/console] [/f] [/w:Width/h:Height]
; /v - specifies the remote computer and port (optional) you wish to connect to
; /console – connects to the console of a Windows Server 2003 based system
; /f – starts the remote desktop connection in full screen mode
; /w & /h – specifies the width and height of the remote desktop connection
return
