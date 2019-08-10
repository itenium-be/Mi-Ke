; LALT & PAUSE
GoToEditEnvironmentVariables:
	Run % "rundll32 sysdm.cpl,EditEnvironmentVariables"
	WinWait Environment Variables
	WinActivate Environment Variables
	Send, P
return



WindowsServices:
	Run services.msc
return


WindowsLocalCertificates:
	Run certlm.msc
return


WindowsInstallPrograms:
	Run % "rundll32.exe shell32.dll,Control_RunDLL appwiz.cpl"
	Sleep 500
	Send {TAB 3}
return									



OpenEventViewerInApplicationLogs:
	Run %A_WinDir%\system32\eventvwr.msc /c:Application
return



OpenRemoteDesktop:
	path := PathReplacements("<A_WINDIR>\system32\mstsc.exe")
	Run % path

	; TODO: RemoteDesktop: Could check if selected text is an IP:Port or an url:port
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
return
