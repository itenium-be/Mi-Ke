; Global Entry Point
; Mi-Ke: Be nice to me or I will throw rocks at you

; Put your own scripts in .\userland\
; The folders .\userland\hotkeys and .\userland\hotstrings are two entry points you can use to start experimenting.

; Configure existing scripts in config\mike.ini and config\_custom.yml

; No idea how to get started with custom scripts
; Run `.\init.ps1` to create some example files!

; Encoded in UTF8 with BOM for Unicode support

#Persistent
#SingleInstance force
SetTitleMatchMode RegEx
SendMode Input
SetWorkingDir %A_ScriptDir%

global DEBUG := 1

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
