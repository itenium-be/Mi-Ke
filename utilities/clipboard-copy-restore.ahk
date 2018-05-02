; Start scripts with saving clipboard and copying selected text.
; Stop scripts with restoring the clipboard.


oldClipboard :=

CopyAndSaveClip(clipWaitTime := 3) {
	global oldClipboard
	oldClipboard := clipboard

	clipboard =
	Send, ^c
	ClipWait, %clipWaitTime%
	return clipboard
}

RestoreClip() {
	global oldClipboard
	clipboard := oldClipboard
}
