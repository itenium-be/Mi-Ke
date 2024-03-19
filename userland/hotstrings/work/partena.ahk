; --------------------------------------------------------------------- PARTENA


; Username:
; :*:iptn::c21913
; :*:iptf::DA_Famil\c21913

; ; Some easy to remember NISS
; :*:issn::12121212178

; ; Some IBAN
; :*:piban::BE68539007547034

; :*:plogin::c21913{tab}



; :*:tracequery::
; send SELECT TOP (1000) *
; send `n  FROM [DBWageDetermination].[Barema].[WageCalculationTrace]
; send `n-- where payrollunit='' and worker=''
; send `norder by id desc
; return


; :*:createcobra::
; Send insert into [CobraSyncMessage] values ('0461840952', '', 'New', 'Updated', 0, CURRENT_TIMESTAMP);
; return



; :*:aic::
; Send {tab}
; Send First naamie
; Send {tab}
; Send last naamie
; Send {tab}{space}{down}{enter}
; sleep 200
; Send {tab}{space}{down}{enter}
; sleep 200
; Send {tab}
; Send 054980544
; Send {tab}
; Send email@email.com
; return
