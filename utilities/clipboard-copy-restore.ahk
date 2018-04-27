; Start scripts with saving clipboard and copying selected text.
; Stop scripts with restoring the clipboard.


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
