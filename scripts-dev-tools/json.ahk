JsonBeautify(input) {
	value := JSON.parse(input, true)
	str := JSON.stringify(value, "   ")
	return str
}

JsonUglify(input) {
	value := JSON.parse(input, true)
	str := JSON.stringify(value, "")
	return str
}
