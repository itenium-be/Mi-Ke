; Telephone number - always format as +32 (0)xxx xx xx xx
FormatMobileNumber(input, params) {
	commonPattern := "(\d{3})\D{0,3}?(\d{2})\D?(\d{2})\D?(\d{2})"

	; Input: 0476403542
	; Input: 0476 40.35 42
	; Input: 0476 / 40.35.42
	withoutCountryCodePattern := "^\s*0" commonPattern "\s*$"
	FoundPos := RegExMatch(input, withoutCountryCodePattern)
	if FoundPos {
		input := "+" params.defaultCountryPrefix " " input
	}


	; Input: 0032 0476 403542
	; Input: +32 476 403542
	withCountryCodePattern := "^\s*(?:00|\+)?(\d{1,3})\D?\(?0?\)?" commonPattern "\s*$"
	FoundPos := RegExMatch(input, withCountryCodePattern)
	if FoundPos {
		input := RegExReplace(input, withCountryCodePattern, params.pattern)
		return input
	}


	; Output: +32 (0)476 40 35 42
	return input
}
