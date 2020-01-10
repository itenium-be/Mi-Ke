; --------------------------------------------------------------------- PARTENA

::pemail::
SendInput, bart.moonen@partena.be
Sleep 100
SendInput {TAB}
; Bader.Bouich@partena.be{TAB} Florentina.Saceanu@partena.be{TAB} Sam.VanCutsem@partena.be{TAB}
; SendInput, maarten.debal@partena.be{TAB} Filip.Vanhoorelbeke@partena.be{TAB} pierre.leroy@partena.be{TAB}
; SendInput, mahmoud.karoui@partena.be{TAB} philippe.lichtert@partena.be{TAB} Raul.Martinez@partena.be{TAB}
; Sleep, 500
; SendInput, {TAB}
; SendInput, christophe.carmeliet@partena.be{TAB}{TAB}
return

; Username:
:*:iptn::c21913
:*:iptf::DA_Famil\c21913

; Some easy to remember NISS
:*:issn::12121212178

; Some IBAN
:*:piban::BE68539007547034

:*:plogin::c21913{tab}


; ----------------------------------------------------------- FeatureTeam 2

:*:pteam::van havermaet, ruben;vansteenkiste, tim;ribbens,joris; Ozdemir Gurbuz;ver eecke, truus; loockx helga; van der hoeven, Domien;robijns, steven


; ----------------------------------------------------------- CreateWorkerWizard

; cww == Create Worker Wizard
; :*:cww::
; ; Name, FirstName, NationalNumber, Nationality:
; Send, {tab}Lastname{tab}Firstname{tab}12121212178{tab}{space}{down}{enter}

; ; Dossier, PayrollGroup, StartDate
; FormatTime, StartDate,, dd/MM/yyyy
; Send, {tab}{tab}{space}{down}{enter}{tab}{space}{down}{enter}{tab}%StartDate%

; ; Exit field so that WorkerTypes are fetched
; Send, {shift down}{tab}{shift up}
; ; Wait a bit for WorkerType to become enabled
; sleep, 1000
; Send, {tab}{tab}

; ; Worker Type
; sleep, 800
; Send, {space}{down}{enter}

; ; Specific Statute
; Send, {tab}
; sleep, 800
; Send, {space}{down}{enter}

; Send {tab}
; return



; ; cw2 == Create Worker Wizard (page 2)
; :*:cw2::
; ; Language, Education Level
; Send, {tab}{space}{down}{enter}{tab}{space}{down}{enter}

; ; Birth country (Germany), PostalCode, BirthCity
; ; ATTN: does not always work. Bug logged: TFS ID 61208
; Send, {tab}{space}{down}{down}{enter}{tab}{tab}1000{tab}Berlin


; ; Contact (street, number, box, country, postalcode, city)
; Send, {tab}Street{tab}42{tab}a{tab}{space}{down}{down}{enter}{tab}{tab}1000{tab}City
; return

:*:cww::
Wait = 750
FormatTime, CurrentDateTime,, dd/MM/yyyy
Name = LastName
FirstName = FirstName
Inss = aaa83072919944
Send {tab}                ; go to last name
Send %Name%                ; send last bame
Send {tab}                ; go to first name
Send %FirstName%        ; send first name
Send {tab}                ; go to inss
Sleep %Wait%
Send %Inss%                ; send inss
Send {tab}                ; go to country
Send {down}                ; first country
Send {tab}                ; go to payroll group
Sleep %Wait%
Send {down}{down}                ; payroll group BESTUURDERS
Send {tab}                        ; go to startdate
SendInput %CurrentDateTime%        ; send start contract date
Send {Shift Down}{tab}{Shift Up}                ; go to category
Sleep %Wait%
Send {tab}{tab}
Send {down}{enter}                ; first category
Send {tab}                ; go to subcategory
Sleep %Wait%
Send {down}                ; first sub-category
send {enter}

; Submit form
; send {tab}
; send {enter}
return


:*:cw2::
Wait = 500
Street = MyStreet
Number = 12
Box = box
Send {tab}                ; go to language
Sleep %Wait%
Send {down}                ; first language

; ATTN: Currently selecting BESTUURDERS - for which the education level is not visible
; Send {tab}                ; go to eduction level
; Sleep %Wait%
; Send {down}
; Send {down}                ; first eduction level

Send {tab}                ; go to birthcountry

; ATTN: Belgium is already selected as birthcountry
; Sleep %Wait%
; Send {down}                ; first birthcountry

Send {tab}                ; go to birthcity
Send Brus
Sleep %Wait%
Send {down}
Send {down}                ; first birthcity
send {enter}
Sleep %Wait%
Send {tab}
Send {tab}                ; go to street
Send %Street%            ; send street
Send {tab}                ; go to number
Send %Number%            ; send number
Send {tab}                ; go to box
Send %Box%                ; send box
Send {tab}                ; go to country (selected by default)
Send {tab}                ; go to city
Send Bru
Sleep %Wait%
Send {down}
Send {down}                ; first city
send {enter}

Send {tab}
Send {tab}
Send {tab}
Send {tab}
Send {tab}
Send {tab}
Send {tab}
Send {tab}
Send {tab}
Send {tab}
Send {tab}
Send {down}
return


:*:cw3::
Wait = 500
Send {tab}
Sleep %Wait%
Send {down}
Send {down}
Send {tab}
Send Chief Energy Officer
Send {tab}
Send {tab}
Send {down}
return



:*:cwv::
Wait = 500
Send {tab}{tab}{tab}{tab}
Send AAA123
Send {tab}{tab}
Send 01/05/2019
Send {tab}
Send 15000
Send {tab}{tab}
Send 110
return


:*:cw4::
Send {tab}
Send {space}{down}{down}{enter}
send {tab}2800
send {tab}{space}{down}{enter}
send {tab}01012020
send {tab}
return
