; Surround selected text with Markdown code block
MdCodeBlockSurround(highlighted) {
	highlighted := RegExReplace(highlighted, "\r\n?|\n\r?", "`n")

	if InStr(highlighted, "`n") > 0 {
		; Multiline
		Send, ``````{space}{enter}
		Send, %highlighted%
		Send, {enter}``````{space}
		Send, {enter}
	} else {
		; Single line
		Send, ``{space}%highlighted%``{space}
	}
}


; New Markdown code block
MdCodeBlockNew:
	Send, ``````{space}
	Send, {shift down}{enter}{enter}{shift up}
	; Without the sleep in VSCode: 6 backticks on one line...
	Sleep, 80
	Send, ``````{space}
	Send, {up}{up}{end}
return


MdBold(string) {
	Send **%string%**
}


MdCodeSurround(string) {
	Send ``%string%``%A_SPACE%
}


MdCodeEmpty() {
	Send, ````{space}{BS}{Left}
}

MdPicture() {
	SendInput, {!}[]()
	Send {LEFt}
}



; Double µ for a ``
$µ::
    KeyWait, µ
    KeyWait, µ, D T0.2
    if ErrorLevel
        Send µ
    Else
        SendInput ````{LEFT}
Return




; Stuff for the itenium bliki :)

BlogIncludeGithub() {
	SendRaw, {`% include github-stars.html url="" desc="" `%}
	Send {LEFT 12}
}

BlogIncludeHideFromExcerpt() {
	SendRaw, {: .hide-from-excerpt}
	Send {ENTER}
}

BlogIncludeShortcut() {
	SendRaw, {`% include kbd k="Control+O,Control+F" l="" `%}
	Send {LEFT 4}
}

BlogIncludeImageInline() {
	SendInput, {!}[](/assets/blog-images/)
	Send {LEFT}
}

BlogIncludeImage() {
	SendRaw, {`% include post/image.html file="" alt="" title="" desc="" maxWidth="360px" `%}
	Send {LEFT 38}
}

BlogIncludeYoutube() {
	SendRaw, {`% include post/youtube.html id="" desc="" `%}
	Send {LEFT 12}
}

BlogOpenBrowserWindows() {
	Run, https://itenium.be/blog/productivity/create-blog-post/
	Run, https://gist.github.com/endolith/157796#file-unicode-official-emojis-txt
	Run, https://glyphsearch.com/?library=font-awesome
	Run, https://unsplash.com/
}
