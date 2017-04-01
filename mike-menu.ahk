Menu, Tray, NoStandard

Menu, Tray, Icon, %A_ScriptDir%\iseedeadcode.ico,, 1
Menu, Tray, Tip, MiKe

Menu, Tray, MainWindow
Menu, Tray, Add, &Reload, MiKeTrayReload
Menu, Tray, Add
Menu, Tray, Add, Source (Explorer), MiKeTraySource
Menu, Tray, Add, Source (Sublime), MiKeTraySourceEditor
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
  Run, "C:\Program Files\Sublime Text 3\subl.exe" %A_ScriptDir%
  return

MiKeTraySourceGithub:
  run % "chrome.exe" ( winExist("ahk_class Chrome_WidgetWin_1") ? " -new " : " " ) "https://github.com/laoujin/Mi-Ke"
  return

MiKeContinue: