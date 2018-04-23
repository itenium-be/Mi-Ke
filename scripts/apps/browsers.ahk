#IfWinActive, ahk_class Chrome_WidgetWin

; F1: Open chrome://extensions
F1::
IfWinActive, New Tab
	; Focus address bar
	Send ^l
else
	; Open new tab
	Send ^t

SendInput chrome`:`/`/extensions`/{Enter}

; Other chrome:// uris
; chrome://settings
; chrome://history
; chrome://downloads
; chrome://bookmarks
; chrome://flags --> Enable experimental features
; Complete list: chrome://chrome-urls
; Blog post: https://fossbytes.com/complete-list-of-secret-chrome-urls-uses
Return


; Alt + Left/Right: history.back() / forward()
; Backspace for history.back() was removed from Chrome
;Backspace::Send !{Left} ; Haha, also blocks backspace in the address bar :)


#IfWinActive


BrowserOpenEdge:
Run microsoft-edge:
; RUN microsoft-edge:http://google.com
return



BrowserOpen:
oldClip := clipboard
clipboard :=
Send, ^c
ClipWait, 2
if RegExMatch(clipboard, "^(https?://|www\.)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(/\S*)?$") {
	; Goto url
	Run % clipboard

} else {
	; Open new tab
	Run, http://
}
Clipboard := oldClip
return


; Capslock & W: Copy and open Google search
BrowserSearch:
Google()
return


; Capslock & A: Copy and google Autohotkey
BrowserSearchAutohotkey:
Google("autohotkey+")
return


Google(prefix := "") {
	oldClip := clipboard
	clipboard :=
	Send, ^c
	ClipWait, 2
	Run, http://www.google.com/search?q=%prefix%%clipboard%
	clipboard := oldClip
}


MiKeTraySourceGithub:
githubUri := ReadMikeIni("tray-menu", "github-url")
; run % BROWSER ( winExist("ahk_class Chrome_WidgetWin_1") ? " " BROWSER_NEWFLAG " " : " " ) githubUri
Run % githubUri
return
