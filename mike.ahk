; Global entry point
; Mi-Ke: Be nice to me or I will throw rocks at you

; TODO: update docs...
; A few #Include files are not in the git repository
; Create them by running .\init.ps1
; (mike.ahk will not run as long as these files do not exist!)

; .\hotkeys\_includes.ahk and .\hotstrings\_includes.ahk
; are two entry points you can use to start experimenting.
; Activate/deactivate and configure the scripts in config\mike.ini and _custom.yml files

; Reload this script with Control+Win+R for ahk and config changes to have effect
; (might happen automatically on Control+S in IDE - see config\dev-tools\dev-tools.yml)

; All code that needs to be executed
; automatically should be above this

#Persistent
#SingleInstance force
SetTitleMatchMode RegEx
SendMode Input
SetWorkingDir %A_ScriptDir%

; Dynamic #Includes:
#Include %A_ScriptDir%\Include.ahk
if (A_AhkVersion < "2") {
	A_Args := []
	Loop %0%
		A_Args[A_Index] := %A_Index%
}
if (A_Args[1] != "is_included") {
	Include("config\includes", "is_included")
}
