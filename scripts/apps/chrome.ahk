#IfWinActive, ahk_class Chrome_WidgetWin

; Alt + Left/Right: history.back() / forward()
; Backspace for history.back() was removed from Chrome
; Oh no you don't!
Backspace::Send !{Left}


; F1: Open chrome://extensions
F1::
IfWinActive, New Tab
	; Focus address bar
	Send ^l
else
	; Open new tab
	Send ^t

SendInput chrome`:`/`/chrome`/extensions`/{Enter}

; Other chrome:// uris
; chrome://settings
; chrome://history
; chrome://downloads
; chrome://bookmarks
; chrome://flags --> Enable experimental features
; Complete list: chrome://chrome-urls
; Blog post: https://fossbytes.com/complete-list-of-secret-chrome-urls-uses
Return


#IfWinActive