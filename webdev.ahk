#Persistent
#SingleInstance force

#Include hotstrings\email.ahk
#Include hotstrings\misc.ahk

#Include scripts\change-sound-volume.ahk
#Include scripts\memory-diff.ahk

#Include scripts\quick-start-programs.ahk

; AltGr+Win: Go directly to special folders
; +C: Dropbox
; +W: WWW Folder
; +T: Temp folder
; +L: Leeching folder
<^>!#c::Run C:\CloudDrives\Dropbox\Personal\Programming
<^>!#w::Run C:\unix\wamp\www
<^>!#t::Run C:\temp
<^>!#l::Run H:\!Download
