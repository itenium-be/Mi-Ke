; https://github.com/russelldavis/AutoHotkey-Scripts/blob/master/WinSwitch.ahk

;;; Switch between windows of the same class (usually equivalent to same app) using Alt+CapsLock
;;; More or less equivalent to Mac's Command+` (backtick)
WinSwitch(offset) {
  ; winSwitchList won't retain its value between calls when declared as static (bug in AHK)
  global winSwitchIsActive, winSwitchIndex, winSwitchList
  ToolTip
  if (!winSwitchIsActive) {
    WinGetClass winSwitchClass, A
    WinGet winSwitchList, List, ahk_class %winSwitchClass%
    winSwitchIndex := 1
    winSwitchIsActive := True
  }
  ; Add the size of the list to the dividend so it won't go negative when offset is -1
  winSwitchIndex := Mod(winSwitchList + winSwitchIndex + offset - 1, winSwitchList) + 1
  WinActivate % "ahk_id" winSwitchList%winSwitchIndex%
}
;;; Don't use the hotkeys when Remote Desktop client is active because CapsLock
;;; is one of the few keys it lets escape, and if we swallow it, it doesn't get sent
;;; to the remote machine.
#IfWinNotActive ahk_class TscShellContainerClass
  !+CapsLock::WinSwitch(-1)
  !CapsLock::WinSwitch(1)
  ;;; The generic ~Alt Up form is broken by other hotkeys such as "RAlt::LAlt"
  ~RAlt Up::
  ~LAlt Up::winSwitchIsActive := False
#IfWinNotActive

;;; Close the active window and switch to the next window of the same class
^+q::
  WinGetClass winSwitchClass, A
  WinWait A ; Set the last-found window
  Send !{F4}
  WinWaitClose, , , 5
  if (!ErrorLevel)
    WinActivate ahk_class %winSwitchClass%
return
