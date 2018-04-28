SetWorkingDir %A_ScriptDir%
#Include Include.ahk
#SingleInstance force ;// you might have to use this to avoid the dialog


if (A_AhkVersion < "2") {
	A_Args := []
	Loop %0% {
		A_Args[A_Index] := %A_Index%
	}
}

; lnt := A_Args.Length()
; msgbox start with %lnt%

; MsgBox % "This script requires at least 3 parameters but it only received " A_Args.Length() "."


;// we check if Include() has been called
if (A_Args[1] != "is_included") {
	Include("config\includes", "is_included")
}


; EDITOR_NAME := ReadMikeIni("core", "editor")
; EDITOR :=
; DOWNLOAD_FOLDER := ReadMikeIni("core", "download-folder", true)
; global DEBUG := ReadMikeIni("core", "DEBUG")
; Base64Chars = ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/

; Load configuration & Startup stuff
; #Include %A_Scriptdir%\startup\mike-loader.ahk

; #Include %A_Scriptdir%\vendor\
; #Include WindowPad\source\WindowPad.ahk
