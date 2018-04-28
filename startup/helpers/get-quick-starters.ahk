GetQuickStarterInfoByName(name) {
	global quickStarterz
	For index, quickStarter in quickStarterz
	{
		if (quickStarter.name = name) {
			return quickStarter
		}
	}
}


GetQuickStarterInfoByLabel(lbl) {
	global quickStarterz
	For index, quickStarter in quickStarterz
	{
		if (quickStarter.label = lbl) {
			return quickStarter
		}
	}
}


GetQuickStarterInfoByHotkey() {
	global quickStarterz
	For index, quickStarter in quickStarterz
	{
		if (quickStarter.hotkey = A_ThisHotkey) {
			return quickStarter
		}
	}
}


GetQuickStarterInfoByMenuItem() {
	global quickStarterz
	For index, quickStarter in quickStarterz
	{
		name := GetMenuName(quickStarter)
		if (name = A_ThisMenuItem) {
			return quickStarter
		}
	}
}
