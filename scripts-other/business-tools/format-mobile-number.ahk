; Telephone number - always format as +32 (0)xxx xx xx xx
; FormatMobileNumber:
; input := clipboard
; input := FormatMobileNumberFn(input)
; Notify(input)
; clipboard := input
; return

FormatMobileNumber(input) {
	msgbox % input
	; Input: 0476403542
	input := RegExReplace(input, "0(\d{3})(\d{2})(\d{2})(\d{2})", "+32 (0)$1 $2 $3 $4")

	; input := RegExReplace(input, "(\+?32|31)?\D?\(0", "")
	return input
}
