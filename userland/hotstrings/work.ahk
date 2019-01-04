; --------------------------------------------------------------------- PARTENA

; Username:
:*:iptn::c21913
:*:iptf::DA_Famil\c21913

; Some easy to remember NISS
:*:issn::12121212178

; CreateWorkerWizard
:*:cww::{tab}Lastname{tab}Firstname{tab}12121212178



; ------------------------------------------------------------------------ BASF

;:*:funcloc::BE51-V161-TESTY

;:*:basfuserid::17058


; --------------------------------------------------------------------- MACADAM
; ; Local, Dev, Test logins
; :*:lmac::
; WinGetTitle, title, A
; IfInString, title, Showroom
; 	SendInput wouter.van.schandevijl@macadam.eu{tab}showroom{enter}
; Else
; 	SendInput wouter.van.schandevijl@macadam.eu{tab}pitstoppitstop{enter}
; Return

; :*:lsmac::pitstop@macadam.eu{tab}pitstop2017{enter}

; ; Search NL Postcode
; :*:snlp::2408zc{tab}3{tab}{enter}

; ; Nieuwe berijder
; :*:newber::Naam{tab}Achternaam{tab}{tab}054321855{tab}email@host.com
; :*:newaddr::Straat{tab}37{tab}B{tab}9300{tab}Aalst
