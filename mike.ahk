; Global Entry Point
; Mi-Ke: Be nice to me or I will throw rocks at you

; You own scripts: .\userland\
; The folders .\userland\hotkeys and .\userland\hotstrings are two entry points you can use to start experimenting.
; All code that needs to be executed automatically can be placed in .\userland\auto-execute.ahk

; Configure existing scripts: config\mike.ini and _custom.yml

; If you have no idea, how to get started then run .\init.ps1 to create some example files


#Persistent
#SingleInstance force
SetTitleMatchMode RegEx
SendMode Input
SetWorkingDir %A_ScriptDir%

; Dynamic #Includes:
#Include %A_ScriptDir%\startup\Include.ahk
if (A_AhkVersion < "2") {
	A_Args := []
	Loop %0%
		A_Args[A_Index] := %A_Index%
}
if (A_Args[1] != "is_included") {
	Include("startup\includes.txt", "is_included")
}
