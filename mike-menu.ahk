; Config: mike.ini [tray-menu]
; https://autohotkey.com/docs/commands/Menu.htm

Menu, Tray, NoStandard

trayIconPath := ReadMikeIni("tray-menu", "icon", true)

Menu, Tray, Icon, %trayIconPath%,, 1
Menu, Tray, Tip, Be nice to me or I will throw rocks to you

Menu, Tray, MainWindow
Menu, Tray, Add, &Reload script and ini, MiKeTrayReload
Menu, Tray, Add
Menu, Tray, Add, View source (Explorer), MiKeTraySource
Menu, Tray, Add, View source (IDE), MiKeTraySourceEditor
Menu, Tray, Add, View source (Github), MiKeTraySourceGithub
Menu, Tray, Add
Menu, Tray, Add, &Debug window, MiKeTrayDebug
Menu, Tray, Add, Spy window, MiKeTraySpyWindow
Menu, Tray, Add, &Suspend script, MiKeTraySuspend
Menu, Tray, Add

; Start Mi-Ke when windows starts
; Startup path = %APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
startupItem = Start Mi-Ke when computer starts
startupLink := A_Startup "\mike.ahk.lnk"
Menu, Tray, Add, %startupItem%, MikeToggleStartupShortcut
Menu, Tray, Add
IfExist %startupLink%
{
	Menu, Tray, ToggleCheck, %startupItem%
}

Menu, Tray, Add, E&xit, MiKeTrayExit
Menu, Tray, Default, &Reload script and ini

Goto, MiKeContinue

; Tray menu subroutines
MiKeTrayDebug:
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
  Menu, Tray, % A_IsSuspended ? "Check" : "Uncheck", &Suspend
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
