; Start scripts with saving clipboard and copying selected text.
; Stop scripts with restoring the clipboard.

; TODO: The quickStartz should be classes so that we can TemplateMethod this

oldClipboard :=

CopyAndSaveClip() {
	global oldClipboard
	oldClipboard := clipboard

	clipboard =
	Send, ^c
	ClipWait, 3
	return clipboard
}

RestoreClip() {
	global oldClipboard
	clipboard := oldClipboard
}
