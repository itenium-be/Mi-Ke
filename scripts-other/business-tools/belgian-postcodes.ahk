CalculatePostcode(city) {
	FileRead, postcodesFileContent, %A_ScriptDir%\resources\postcodes-belgium.json
	postcodes := JSON.parse(postcodesFileContent, true)

	; Could add fuzzy matching with Levenshtein
	; Already included: LDistance() & DLDistance()
	; Might want to take into account: é/e, dashes, 's, ...

	foundCount := 0
	results :=

	city := Trim(city, " `t`n`r")

	for index, element in postcodes
	{
	 	if (city = element.city or StrReplace(city, " ", "-") = element.city) {
	 		foundCount += 1
	 		results .= element.city " (" element.province "): " element.postcode "`n"
			clipboard := element.postcode
		}
	}

	if (foundCount = 0) {
		Notify("Postcode not found", city)
	} else {
		StringUpper results, results, T
		results := Trim(results, "`n")
		Notify("Postcode(s) " city, results, 5)
	}
}
