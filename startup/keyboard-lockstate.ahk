; Lock Numlock, Capslock, ScrollLock
lockStates := ReadMikeIni("keyboard-lockstate")
Loop, parse, lockStates, `n
{
	StringSplit, keyValue, A_LoopField, =
	key := keyValue1
	value := keyValue2

	if (value) {
		if (key = "NumlockState") {
			SetNumlockState %value%
		} else if (key = "CapsLockState") {
			SetCapsLockState %value%
		} else if (key = "ScrollLockState") {
			SetScrollLockState %value%
		}
	}
}
