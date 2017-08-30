; Local, Dev, Test logins
:*:lmac::
WinGetTitle, title, A
IfInString, title, Showroom
	SendInput wouter.van.schandevijl@macadam.eu{tab}showroom{enter}
Else
	SendInput wouter.van.schandevijl@macadam.eu{tab}pitstop{enter}
Return

:*:lsmac::leaseplanrentalbrk@macadam.eu{tab}pitstop{enter}
:*:lpmac::poolbeheer@leaseplan.be{tab}pitstop{enter}
:*:lrmac::anneke.geerdink@leaseplan.nl{tab}pitstop{enter}

; Search NL Postcode
:*:snlp::2408zc{tab}3{tab}{enter}

; Nieuwe berijder
:*:newber::Naam{tab}Achternaam{tab}{tab}054321855{tab}email@host.com
:*:newaddr::Straat{tab}37{tab}B{tab}9300{tab}Aalst
