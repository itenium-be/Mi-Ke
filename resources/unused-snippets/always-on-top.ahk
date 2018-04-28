; http://www.computoredge.com/AutoHotkey/Downloads/Always_on_Top.ahk
;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         Jack Dunning https://jacksautohotkeyblog.wordpress.com/
;
; Script Function:
;	This script contains a few window manipulation Hotkeys using the WinSet command
;
; CTRL+WIN+F8 Toggles the active window always-on-top on and off
; CTRL+WIN+F9 Makes the active window semi-transparent
; CTRL+WIN+F10 Makes the active window opaque
; CTRL+WIN+F11 Brings up a selection menu of four levels of opaqueness
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; The original alwayw-on-top Hotkey in one line:
; ^#F8::WinSet, AlwaysOnTop, toggle, A

: Add ToolTip to tell whether always-on-top turned on or off
^#F8::
  WinSet, AlwaysOnTop, toggle, A
  WinGet, ExStyle, ExStyle, A
  Tooltip,  % (ExStyle & 0x8 = 0) ? "Always-On-Top OFF" : "Always-On-Top ON"
  Sleep, 1500
  ToolTip
Return

^#F9::WinSet, Transparent, 125, A

^#F10::WinSet, Transparent, 255, A

^#F11::
  Menu, Transparency, Add, 255, SetTrans
  Menu, Transparency, Add, 190, SetTrans
  Menu, Transparency, Add, 125, SetTrans
  Menu, Transparency, Add, 65, SetTrans
  Menu, Transparency, Show
Return

SetTrans:
  Sleep 100
  WinSet, Transparent, %A_ThisMenuItem%, A
Return
