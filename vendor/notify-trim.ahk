TrimContent(content)
{
	maxLineSize := 50

	StringMid, partialContent, content, 1, 500
	Loop, Parse, partialContent, `n, `r
	{
		StringReplace, trimmedLine, A_LoopField, %A_TAB%, %A_SPACE% %A_SPACE%, All

		if StrLen(trimmedLine) > maxLineSize
		{
			StringMid, trimmedLine, trimmedLine, 1, maxLineSize
			trimmedLine .= "..."
		}

		trimmedContent .= trimmedLine "`n"
	}
	return Trim(trimmedContent)
}
