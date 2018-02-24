; Config: mike.ini [tray-menu]
; https://autohotkey.com/docs/commands/Menu.htm

Menu, Tray, NoStandard

; ------------------------------------------------------------------------------------------------------------ TRAY ICON
trayIconPath := ReadMikeIni("tray-menu", "icon", true)
IfNotExist, %trayIconPath%
	trayIconPath = <A_ScriptDir>\iseedeadcode.ico

trayIconPath := FileReplacements(trayIconPath)
Menu, Tray, Icon, %trayIconPath%,, 1

; --------------------------------------------------------------------------------------------------------- TRAY TOOLTIP
; https://autohotkey.com/docs/commands/OnMessage.htm
; https://autohotkey.com/docs/misc/SendMessageList.htm
OnMessage(0x404, "AHK_NOTIFYICON")
AHK_NOTIFYICON(wParam, lParam)
{
	if (lParam = 0x200) ; WM_MOUSEMOVE
	{
		SetTimer, MikeTrayTooltip, -1
		return 0
	}
}


; ------------------------------------------------------------------------------------------------------------ TRAY MENU

Menu, Tray, MainWindow

Menu, Tray, Add, &Reload script and ini, MiKeTrayReload
Menu, Tray, Add, &Suspend script, MiKeTraySuspend
Menu, Tray, Add

; Start Mi-Ke when windows starts
; Startup path = %APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
startupItem = Start Mi-Ke when computer starts
startupLink := A_Startup "\mike.ahk.lnk"
Menu, Tray, Add, %startupItem%, MikeToggleStartupShortcut
IfExist %startupLink%
{
	Menu, Tray, ToggleCheck, %startupItem%
}
Menu, Tray, Add, Choose Tray Icon, MikeChooseTrayIcon
Menu, Tray, Add

Menu, Tray, Add, View source (Explorer), MiKeTraySource
Menu, Tray, Add, View source (IDE), MiKeTraySourceEditor
Menu, Tray, Add, View source (Github), MiKeTraySourceGithub
Menu, Tray, Add

Menu, Tray, Add, &List hotkeys, MiKeListHotkeys



CreateQuickStartsMenuItem("Tray", "Spy window")
Menu, Tray, Add

Menu, tray, Add, System information, MikeTraySysInfo

CreateQuickStartersMenu("Applications")
CreateQuickStartersMenu("Consoles")

Menu, Tray, Add

Menu, Tray, Add, E&xit, MiKeTrayExit

; 1=For one click to activate default (2=double click=default)
Menu, Tray, Click, 1
Menu, Tray, Default, System information

; Code if we want to do different things for tray single/double click
; OnMessage(0x404, "AHK_NOTIFYICON")
; AHK_NotifyIcon(wParam, lParam) {
; 	static Delay := 300, TimeSinceLastClick := A_TickCount
; 	if (lParam = 0x202 && A_TickCount - TimeSinceLastClick > Delay) { ; WM_LBUTTONUP
; 		TimeSinceLastClick := A_TickCount
; 		Menu, Tray, Show   ; Show the menu
; 	}
; }




Goto, MiKeContinue



; ----------------------------------------------------------------------------------------------------- Tray Subroutines

QuickStarterConsoles:
	Msgbox wheee
	return


MikeTraySysInfo:
	return


MikeTrayTooltip:
	memory := GetMemoryStatus()
	; TODO: Put this sentence in ini file.
	; Could configure lots of stuff like: CPU/Memory Usage? User/Domain? CPU Temperature?
	trayContent := "CPU: " . CPULoad() . "%"
	trayContent .= " | "
	trayContent .= "RAM: " memory.ramPhysicalUsed . " of " . memory.ramPhysicalTotal . " (" . memory.ramPhysicalPercentage . "%)"
	Menu, Tray, Tip, %trayContent%
	return


MikeChooseTrayIcon:
	FileSelectFile, trayIconPath, 3, , Pick new tray icon, Icons (*.ico)
	if trayIconPath {
		customTrayIconPath = %A_ScriptDir%\mike.ico
		FileCopy, %trayIconPath%, %customTrayIconPath%, 1
		Menu, Tray, Icon, %customTrayIconPath%,, 1
		WriteMikeIni("<A_ScriptDir>\mike.ico", "tray-menu", "icon")
	}
	return

MiKeListHotkeys:
	; TODO: Create a better hotkey display...
	ListHotkeys
	return

MiKeTraySpyWindow:
	spyWindow := FileReplacements("<A_AHKPATH>\AU3_Spy.exe")
	Run %spyWindow%
	return

MiKeTrayReload:
	Reload
	return

MiKeTraySuspend:
	Suspend
	Menu, Tray, ToggleCheck, &Suspend script
	return

MiKeTrayExit:
	ExitApp

MiKeTraySource:
	Run, explore %A_ScriptDir%
	return

MiKeTraySourceEditor:
	Run, "%EDITOR%" %A_ScriptDir%
	return

MiKeTraySourceGithub:
	githubUri := ReadMikeIni("tray-menu", "github-url")
	run % BROWSER ( winExist("ahk_class Chrome_WidgetWin_1") ? " " BROWSER_NEWFLAG " " : " " ) githubUri
	return

MikeToggleStartupShortcut:
	IfNotExist %startupLink%
	{
		FileCreateShortcut, %A_ScriptFullPath%, %startupLink%
	}
	else
	{
		FileDelete, %startupLink%
	}
	Menu, Tray, ToggleCheck, %startupItem%
	return

MiKeContinue:
