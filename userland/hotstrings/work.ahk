; --------------------------------------------------------------------- PARTENA

::pemail::
SendInput, bart.moonen@partena.be{TAB} Bader.Bouich@partena.be{TAB} Florentina.Saceanu@partena.be{TAB} Sam.VanCutsem@partena.be{TAB}
SendInput, maarten.debal@partena.be{TAB} Filip.Vanhoorelbeke@partena.be{TAB} pierre.leroy@partena.be{TAB}
SendInput, mahmoud.karoui@partena.be{TAB} philippe.lichtert@partena.be{TAB}
Sleep, 500
SendInput, {TAB}
SendInput, christophe.carmeliet@partena.be{TAB}
return

; Username:
:*:iptn::c21913
:*:iptf::DA_Famil\c21913

; Some easy to remember NISS
:*:issn::12121212178

; CreateWorkerWizard

; cww == Create Worker Wizard
:*:cww::
; Name, FirstName, NationalNumber, Nationality:
Send, {tab}Lastname{tab}Firstname{tab}12121212178{tab}{space}{down}{enter}

; Dossier, PayrollGroup, StartDate
FormatTime, StartDate,, dd/MM/yyyy
Send, {tab}{tab}{space}{down}{enter}{tab}{space}{down}{enter}{tab}%StartDate%

; Exit field so that WorkerTypes are fetched
Send, {shift down}{tab}{shift up}
; Wait a bit for WorkerType to become enabled
sleep, 1000
Send, {tab}{tab}

; Worker Type
sleep, 800
Send, {space}{down}{enter}

; Specific Statute
Send, {tab}
sleep, 800
Send, {space}{down}{enter}

Send {tab}
return



; cw2 == Create Worker Wizard (page 2)
:*:cw2::
; Language, Education Level
Send, {tab}{space}{down}{enter}{tab}{space}{down}{enter}

; Birth country (Germany), PostalCode, BirthCity
; ATTN: does not always work. Bug logged: TFS ID 61208
Send, {tab}{space}{down}{down}{enter}{tab}{tab}1000{tab}Berlin


; Contact (street, number, box, country, postalcode, city)
Send, {tab}Street{tab}42{tab}a{tab}{space}{down}{down}{enter}{tab}{tab}1000{tab}City
return






:*:piban::BE68539007547034


; --------------------------------------------------------------------- ITENIUM

:*:iim::Dear,`n`nFor our internal positions, we are, unfortunately, looking for native Dutch speaking candidates only.

::iibtw::BE0687800967
::iiaddress::Linde 11, 1840 Londerzeel
::iiiban::BE84 7370 4817 1859


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
