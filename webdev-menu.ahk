Menu, Tray, NoStandard

Menu, Tray, Icon, %A_ScriptDir%\iseedeadcode.ico,, 1
Menu, Tray, Tip, MiKe

Menu, Tray, MainWindow
Menu, Tray, Add, &Reload, MiKeTrayReload
Menu, Tray, Add, &Suspend, MiKeTraySuspend
Menu, Tray, Add, E&xit, MiKeTrayExit
Menu, Tray, Default, &Reload

Goto, MiKeContinue

; Tray menu subroutines
MiKeTrayReload:
  Reload
  return
MiKeTraySuspend:
  Suspend
  Menu, Tray, % A_IsSuspended ? "Check" : "Uncheck", &Suspend
  return
MiKeTrayExit:
  ExitApp

MiKeContinue: