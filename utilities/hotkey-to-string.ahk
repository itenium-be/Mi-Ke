HotkeyToString(hotkey) {
	StringUpper, hotkey, hotkey
	StringReplace, hotkey, hotkey, +, Shift +
	StringReplace, hotkey, hotkey, !, Alt +
	StringReplace, hotkey, hotkey, ^, Control +
	StringReplace, hotkey, hotkey, #, Win +
	StringReplace, hotkey, hotkey, &, &&
	return hotkey
}
