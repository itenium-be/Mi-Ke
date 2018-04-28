; Get output of running ipconfig.exe
; http://msdn.microsoft.com/en-us/library/cbxxzwb5%28v=VS.85%29.aspx
; http://technet.microsoft.com/en-us/library/ee156605.aspx
; GetIpConfig() {
; 	objShell := ComObjCreate("WScript.Shell")
; 	objExec := objShell.Exec("ipconfig.exe")

; 	While !objExec.Status
; 		Sleep 100

; 	result := objExec.StdOut.ReadAll()
; 	return result
; }


GetMyIps() {
	result := "Public IP: " GetPublicIP()
	result .= "`nPrivate IP: " GetLocalIPByAdaptor("Ethernet")
	For AdaptorName, IP in GetLocalIPs() {
		result .= "`n" AdaptorName ": " IP
	}
	return result
}


Ping(url) {
	; a.log("start" url)
	; objExec := objShell.Exec("cmd /c ping -n 3 -w 1000 www.google.com")
	; ; strLine := objExec.StdOut.ReadAll()
	; ; msgbox % strLine
	; ; return strLine

	; a.log("aarg" url)

	; While !objExec.Status
	; 	Sleep 100

	; ; While !objExec.StdOut.AtEndOfStream {
	; ; 	line := "`n" objExec.StdOut.ReadLine()
	; ; 	if InStr(line, "Reply") {
	; ; 		result .= "`n" line
	; ; 	}
	; ; }

	; result := objExec.StdOut.ReadAll()

	; msgbox % result
	; return result
}

; TODO: tracert



GetPublicIP() {
	; IP Services:
	; - https://api.ipify.org
	; - http://www.netikus.net/show_ip.html
	; - https://www.google.com/search?q=what+is+my+ip&num=1

	MyExternalIP = 0.0.0.0
	TmpFile = %WinDir%\TEMP\IPAddress.TMP
	UrlDownloadToFile, https://api.ipify.org, %TmpFile%
	FileReadLine, MyExternalIP, %TmpFile%, 1
	FileDelete, %TmpFile%
	return MyExternalIP
}
; GetPublicIPFromGoogle() {
; 	HttpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
; 	HttpObj.Open("GET", "https://www.google.com/search?q=what+is+my+ip&num=1")
; 	HttpObj.Send()
; 	RegexMatch(HttpObj.ResponseText,"Client IP address: ([\d\.]+)",match)
; 	Return match1
; }


GetLocalIPByAdaptor(adaptorName) {
	objWMIService := ComObjGet("winmgmts:{impersonationLevel = impersonate}!\\.\root\cimv2")
	colItems := objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapter WHERE NetConnectionID = '" adaptorName "'")._NewEnum, colItems[objItem]
	colItems := objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE InterfaceIndex = '" objItem.InterfaceIndex "'")._NewEnum, colItems[objItem]
	Return objItem.IPAddress[0]
}


GetLocalIPs() {
	adaptors := Object()
	ips := Object()
	objWMIService := ComObjGet("winmgmts:{impersonationLevel = impersonate}!\\.\root\cimv2")
	colItems := objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapter")._NewEnum, colItems[objItem]
	While (colItems[objItem])
		adaptors.Insert(objItem.InterfaceIndex,objItem.NetConnectionID)
	For index, name in adaptors {
		colItems := objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE InterfaceIndex = '" index "'")._NewEnum, colItems[objItem]
		If (name && objItem.IPAddress[0])
			ips.Insert(name,objItem.IPAddress[0])
	}
	Return ips
}
