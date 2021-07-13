;
; Your scripts here
; Any Ahk file in userland\hotkeys will be included into the script
;

; !F5::
; Msgbox Pressed %A_ThisHotkey% (Alt + F5)
; return


; Hotkey syntax:
; ^ = Control
; # = Win
; + = Shift
; ! = Alt
; <# = Left Win
; #> = Right Win
; <^>! = AltGr

; Prefix a hotkey with ~ to not block the native function
; Numpad0 & Numpad2 = When pressed together

; More fun combinations possible:
; https://autohotkey.com/docs/KeyList.htm

^!w::
Run, "C:\Users\robij\Google Drive (robijns.steven@gmail.com)\Private\P\Consultancy"
Return

^!x::
Run, "C:\Users\robij\OneDrive - itenium.be\itenium"
Return

^!q::
Send, is:unread category:primary {enter}
Return

