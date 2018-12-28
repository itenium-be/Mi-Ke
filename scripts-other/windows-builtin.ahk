; LAlt & PAUSE
GoToEditEnvironmentVariables:
Run % "rundll32 sysdm.cpl,EditEnvironmentVariables"
WinActivate
return



GoToServicesMsc() {
	Run services.msc
}




OpenRemoteDesktop(input, params) {
	path := PathReplacements(params.path)
	Run % path

	; Checking clipboard might copy unwanted stuff
	; And we get crashes on IP resolve etc.
	; clipVal := CopyAndSaveClip()
	; if (clipVal) {
	; 	Run % path " /v:" clipVal
	; } else {
	; 	Run % path
	; }
	; RestoreClip()

	; Full CLI:
	; mstsc.exe {ConnectionFile | /v:ServerName[:Port]} [/console] [/f] [/w:Width/h:Height]
	; /v - specifies the remote computer and port (optional) you wish to connect to
	; /console – connects to the console of a Windows Server 2003 based system
	; /f – starts the remote desktop connection in full screen mode
	; /w & /h – specifies the width and height of the remote desktop connection
}
