; Config: mike.ini [tray-menu]
; Dependencies: utilities/ini-read.ahk

Menu, Tray, NoStandard

trayIconPath := ReadMikeIni("tray-menu", "icon", true)

Menu, Tray, Icon, %trayIconPath%,, 1
Menu, Tray, Tip, MiKe

Menu, Tray, MainWindow
Menu, Tray, Add, &Reload, MiKeTrayReload
Menu, Tray, Add
Menu, Tray, Add, Source (Explorer), MiKeTraySource
Menu, Tray, Add, Source (IDE), MiKeTraySourceEditor
Menu, Tray, Add, Source (Github), MiKeTraySourceGithub
Menu, Tray, Add
Menu, Tray, Add, &Debug, MiKeTrayDebug
Menu, Tray, Add, &Suspend, MiKeTraySuspend
Menu, Tray, Add, E&xit, MiKeTrayExit
Menu, Tray, Default, &Reload

Goto, MiKeContinue

; Tray menu subroutines
MiKeTrayDebug:
  ListHotkeys
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
  githubUri := ReadMikeIni("tray-menu", "github-url", false)
  run % BROWSER ( winExist("ahk_class Chrome_WidgetWin_1") ? " " BROWSER_NEWFLAG " " : " " ) githubUri
  return

MiKeContinue:
