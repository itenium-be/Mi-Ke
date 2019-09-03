; Capslock & W: Copy and open Google search
BrowserOpen:
clipVal := Trim(CopyAndSaveClip())

openUrl = false

; http://www.bing.com
; www.google.com
; github.com/MunGell/awesome-for-beginners
if RegExMatch(clipVal, "^(https?://|www\.)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(/\S*)?$") {
	openUrl = true

} else if RegExMatch(clipVal, "^[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(/\S*)?$") {
	openUrl = true

; 127.0.0.1:4000
} else if RegExMatch(clipVal, "^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}:\d+$") {
	openUrl = true
}


if (openUrl) {
	if (SubStr(clipVal, 1, 4) != "http") {
		clipVal = http://%clipVal%
	}
	Run % clipVal

} else {
	; Open new tab
	Run, http://
}
RestoreClip()
return


; Capslock & X: Copy and open Google search
BrowserSearch:
Google()
return


; Capslock & A: Copy and google Autohotkey
BrowserSearchAutohotkey:
ahkCommands =
( LTRIM
	Break,Catch,Click,ClipWait,Continue,Control,ControlClick,ControlFocus,ControlGet,ControlGetFocus,
	ControlGetPos,ControlGetText,ControlMove,ControlSend,ControlSendRaw,ControlSetText,CoordMode,Critical,
	DetectHiddenText,Drive,DriveGet,DriveSpaceFree,Edit,Else,EnvAdd,EnvDiv,EnvGet,EnvMult,EnvSet,EnvSub,
	EnvUpdate,Exit,ExitApp,FileAppend,FileCopy,FileCopyDir,FileCreateDir,FileCreateShortcut,FileDelete,
	FileInstall,FileGetAttrib,FileGetShortcut,FileGetSize,fileGetVersion,FileMove,FileMoveDir,FileOpen,
	FileRead,FileReadLine,FileRecycle,FileRecycleEmpty,FileRemoveDir,FileSelectFile,FileSelectFolder,
	FileSetAttrib,FileSetTime,Finally,For,Format,FormatTime,GetKeyState,Gosub,Goto,GroupActive,GroupAdd,
	GroupClose,GroupDeactivate,Gui,GuiControl,GuiControlGet,Hotkey,if,IfEqual,IfNotEqual,IfExist,IfNotExist,
	IfGreater,IfGreaterOrEqual,IfInString,IfNotInString,IfLess,IfLessOrEqual,IfMsgBox,IfWinActive,IfWinNotActive,
	IfWinExist,IfWinNotExist,ImageSearch,IniDelete,IniRead,IniWrite,Input,InputBox,KeyHistory,KeyWait,ListHotkeys,
	ListLines,ListVars,Loop,Menu,MenuGetHandle,MenuGetName,MouseClick,MouseClickDrag,MouseGetPos,MouseMove,MsgBox,
	OnExit,OutputDebug,Pause,PixelGetColor,PixelSearch,PostMessage,Process,Progress,Random,RegDelete,RegRead,RegWrite,
	Reload,Return,Run,RunAs,RunWait,Send,SendRaw,SendInput,SendPlay,SendEvent,SendLevel,SendMessage,SendMode,
	SetBatchLines,SetCapsLockState,SetControlDelay,SetDefaultMouseSpeed,SetEnv,SetFormat,SetKeyDelay,SetMouseDelay,
	SetNumLockState,SetScrollLockState,SetregView,SetStoreCapsLockMode,SetTimer,SetTitleMatchMode,SetWinDelay,
	SetWorkingDir,Shutdown,Sleep,Sort,SoundBeep,SoundGet,SoundGetWaveVolume,SoundPlay,SoundSet,SoundSetWaveVolume,
	SplashImage,SplashTextOn,SplashTextOff,SplitPath,StatusBarGetText,StatusBarWait,StringCaseSense,StringLeft,
	StringRight,StringLower,StringReplace,StringSplit,StringTrimLeft,StringTrimRight,StringUpper,Suspend,SysGet,
	Thread,Throw,ToolTip,Transform,TrayTip,Until,UrlDownloadToFile,While,WinActivate,WinActivateBottom,WinClose,
	WinGetActiveStats,WinGetActiveTitle,WinGetClass,WinGet,WinGetPos,WinGetText,WinGetTitle,WinHide,WinKill,WinMaximize,
	WinMenuSelectItem,WinMinimize,WinMinimizeAll,WinMinimizeAllUndo,WinMove,WinRestore,WinSet,WinSetTitle,WinShow,
	WinWait,WinWaitActive,WinWaitClose,WinWaitNotActive,ClipboardTimeout,CommentFlag,Delimiter,DerefChar,ErrorStdOut,
	EscapeChar,HotkeyInterval,HotkeyModifierTimeout,Hotstring,Include,IncludeAgain,InputLevel,InstallKeybdHook,
	InstallMouseHook,LTrim,MaxHotkeysPerInterval,MaxMem,MaxThreads,MaxThreadsBuffer,MaxThreadsPerHotkey,
	MenuMaskKey,NoEnv,NoTrayIcon,Persistent,SingleInstance,UseHook,Warn,WinActivateForce
)

clipVal := Trim(CopyAndSaveClip())
if (IsFunc(clipVal) or InStr(ahkCommands, clipVal)) {
	Run https://autohotkey.com/docs/commands/%clipVal%.htm
} else {
	Google("autohotkey+")
}
return


Google(prefix := "") {
	clipVal := CopyAndSaveClip()
	Run, https://www.google.com/search?q=%prefix%%clipVal%
	RestoreClip()
}

OpenGoogleMaps(place) {
	Run, https://maps.google.com/?q=%place%
}

OpenGoogleTranslate:
	sentence := Trim(CopyAndSaveClip())
	; sl = start language
	; tl = to language
	Run https://translate.google.com/#view=home&op=translate&sl=auto&tl=en&text=%sentence%
	RestoreClip()
return


MiKeTraySourceGithub:
githubUri := ReadMikeIni("tray-menu", "github-url")
; run % BROWSER ( winExist("ahk_class Chrome_WidgetWin_1") ? " " BROWSER_NEWFLAG " " : " " ) githubUri
Run % githubUri
return


BrowserOpenEdge:
Run microsoft-edge:
; RUN microsoft-edge:http://google.com
return


BrowserCopyCurrentUrl:
If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
{
	Send ^l
	Sleep 300
	Send ^c
	Sleep 200
	Send {ESC}{TAB}{TAB}
	ClipWait
	Notify("Copied", clipboard)
}
return


; -----------------------------------------------------------------------------------------------------------CHROME ONLY


#IfWinActive, ahk_class Chrome_WidgetWin

; Other chrome:// uris
; chrome://settings
; chrome://history == Control + H
; chrome://downloads == Control + J
; chrome://bookmarks
; chrome://flags --> Enable experimental features
; Complete list: chrome://chrome-urls
; Blog post: https://fossbytes.com/complete-list-of-secret-chrome-urls-uses
openChromePageInNewTab(chromePage) {
	IfWinActive, New Tab
		; Focus address bar
		Send ^l
	else
		; Open new tab
		Send ^t

	SendInput chrome`:`/`/%chromePage%`/{Enter}
}


; F1: Open chrome://extensions
F1::
openChromePageInNewTab("extensions")
Return


; Alt + Left/Right: history.back() / forward()
; Backspace for history.back() was removed from Chrome
;Backspace::Send !{Left} ; Haha, also blocks backspace in the address bar :)


~Esc::
; Esc twice to open/close DevTools
; Default shortcut: Control + Shift + J
If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
    Send {F12}
Return



~^!J::
; Control + Alt + J: Close the bottom Download Bar
Send ^j
WinWait, Downloads
Send ^w
return


#IfWinActive
