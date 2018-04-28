; http://www.computoredge.com/AutoHotkey/Downloads/CPULoad.ahk
;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
#NoEnv
#SingleInstance, Force
ListLines, Off
OnExit, GuiClose

OnMessage( 0xF, "WM_PAINT")

Gui +AlwaysOnTop
Gui, Margin, 10, 10
Gui, Font, s8, Verdana
Loop, % 11 + ( Y := 15 ) - 15 ; Loop 11 times
 Gui, Add, Text, xm y%y% w22 h10 0x200 Right, % 125 - (Y += 10)

ColumnW := 10

hBM := XGraph_MakeGrid(  ColumnW, 10, 40, 12, 0x008000, 0, GraphW, GraphH )
Gui, Add, Text, % "xm+25 ym w" ( GraphW + 2 ) " h" ( GraphH + 2 ) " 0x1000" ; SS_SUNKEN := 0x1000
Gui, Add, Text, xp+1 yp+1 w%GraphW% h%GraphH% hwndhGraph gXGraph_GetVal 0xE, pGraph
pGraph := XGraph( hGraph, hBM, ColumnW, "1,10,0,10", 0x00FF00, 1, True )

Gui, Add, StatusBar
SB_SetParts( 100, 150 )
Gui, Show,, CPU Load Monitor ( One minute window )

SetTimer, XGraph_Plot, 1500
GoTo, XGraph_Plot

F1::MsgbOx, 0x1040, XGraph, % XGraph_Info( pGraph )                   ; // end of auto-execute section //
F2::MsgbOx, 0x1040, XGraph - Array, % XGraph_Info( pGraph, "0.2" )

XGraph_GetVal:
 Value := XGraph_GetVal( pGraph )
 If ( Col := ErrorLevel )
   SB_SetText( "`tColumn : " Col, 1 ), SB_SetText( "`tValue : " Value, 2 )
Return

XGraph_Paint:
 Sleep -1
 XGraph_Plot( pGraph )
Return

XGraph_Plot:
  CPUL := CPULoad()
  XGraph_Plot( pGraph, 100 - CPUL, CPUL )
Return

GuiClose:
 OnExit
 ExitApp

; -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -

WM_PAINT() {
 IfEqual, A_GuiControl, pGraph, SetTimer, XGraph_Paint, -1
}

; -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -

CPULoad() { ; By SKAN, CD:22-Apr-2014 / MD:05-May-2014. Thanks to ejor, Codeproject: http://goo.gl/epYnkO
Static PIT, PKT, PUT                           ; http://ahkscript.org/boards/viewtopic.php?p=17166#p17166
  IfEqual, PIT,, Return 0, DllCall( "GetSystemTimes", "Int64P",PIT, "Int64P",PKT, "Int64P",PUT )

  DllCall( "GetSystemTimes", "Int64P",CIT, "Int64P",CKT, "Int64P",CUT )
, IdleTime := PIT - CIT,    KernelTime := PKT - CKT,    UserTime := PUT - CUT
, SystemTime := KernelTime + UserTime

Return ( ( SystemTime - IdleTime ) * 100 ) // SystemTime,    PIT := CIT,    PKT := CKT,    PUT := CUT
}

; -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -

#Include xGraph.ahk
