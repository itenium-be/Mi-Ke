; --------------------------------------------------------------------- PARTENA

::pemail::
SendInput, bart.moonen@partena.be{TAB} Bader.Bouich@partena.be{TAB} Florentina.Saceanu@partena.be{TAB} Sam.VanCutsem@partena.be{TAB}
SendInput, maarten.debal@partena.be{TAB} Filip.Vanhoorelbeke@partena.be{TAB} pierre.leroy@partena.be{TAB}
SendInput, mahmoud.karoui@partena.be{TAB} philippe.lichtert@partena.be{TAB} Raul.Martinez@partena.be{TAB}
Sleep, 500
SendInput, {TAB}
SendInput, christophe.carmeliet@partena.be{TAB}{TAB}
return

; Username:
:*:iptn::c21913
:*:iptf::DA_Famil\c21913

; Some easy to remember NISS
:*:issn::12121212178

; Some IBAN
:*:piban::BE68539007547034




; ----------------------------------------------------------- CreateWorkerWizard

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
