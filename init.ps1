# Script to get you up and running
# .\init.ps1 -bare to create without example hotstrings
param ([switch]$bare = $false)

function Create-File($file, $initial = "") {
	if (-not (Test-Path $file)) {
		echo $file
		$initial | Out-File $file -Encoding UTF8
	}
}

$path = Split-Path $SCRIPT:MyInvocation.MyCommand.Path -Parent

Create-File "$($path)\hotkeys\_auto-execute.ahk" @"
;
; Auto-execute section
;
; More info in the docs about "the auto-execute section"
; https://autohotkey.com/docs/Scripts.htm#auto
;
; Everything before the first return will be executed
; at script startup

; Notify("Starting Mi-Ke...")

return
"@


Create-File "$($path)\hotkeys\_includes.ahk" @"
;
; Your scripts here
;

; !F5::Msgbox Pressed %A_ThisHotkey%
"@

if ($bare) {
	Create-File "$($path)\hotstrings\_includes.ahk" ""
	return
}


# Create config files
$iniPath = "$($path)\config\mike.ini"
if (-not (Test-Path -Path $iniPath -PathType Leaf)) {
	echo "Creating config\mike.ini"
	Create-File "$($path)\config\mike.ini" @"
; Use Control+Win+R to reload the script
; Configure your editor to reload the script on save (expects A_SCRIPTDIR in the window title)

; Paths supports some substitutions
; Defined in path-replacements.ahk
; <A_DESKTOP>, <A_TEMP>, <A_SCRIPTDIR>, <USERPROFILE>, <A_APPDATA>, <A_PROGRAMFILES>

; Hotkey syntax:
; ^ = Control
; # = Win
; + = Shift
; ! = Alt
; <# = Left Win
; #> = Right Win
; <^>! = AltGr

; Prefix a hotkey with ~ to not block the native function
; Numpad0 & Numpad2 = When pressed together

[core]
editor=<A_PROGRAMFILES>\Sublime Text 3\sublime_text.exe
; Discover ahk_class with Window Spy (Alt+F12)
; c:\Program Files\AutoHotkey\AU3_Spy.exe
editor-titleMatcher=ahk_class PX_WINDOW_CLASS
editor-openWithPathArgs=<exe> --new-window "<path>"
"@
	# Copy-Item "$($path)\config\mike.default.ini" $iniPath
}

$qsPath = "$($path)\config\quick-starters.yml"
if (-not (Test-Path -Path $qsPath -PathType Leaf)) {
	echo "Creating config\quick-starters.yml"
	Copy-Item "$($path)\config\quick-starters.default.yml" $qsPath
}



echo "Creating some sample hotstrings"

Create-File "$($path)\hotstrings\_includes.ahk" @"
; Include more files here

; A few basic examples
#Include %A_Scriptdir%\hotstrings\sample.ahk

; ex: Expand common abbreviations
#Include %A_Scriptdir%\hotstrings\misc.ahk

; ex: Multi login script
#Include %A_Scriptdir%\hotstrings\work.ahk

; Empty
#Include %A_Scriptdir%\hotstrings\personal.ahk
#Include %A_Scriptdir%\hotstrings\project1.ahk
"@



Create-File "$($path)\hotstrings\sample.ahk" @"
; Type atm anywhere and have it expanded to "at the moment" immediately
:*:atm::at the moment

; Trigger hotstring only if followed by one of the EndChars
::devlogin::tyler@company.com{tab}superSecretPassword{enter}
; #Hotstring EndChars -()[]{}:;'"/\,.?!`n `t

; Expand imail only after pressing tab
:``t:imail:your.name@glogle.com
"@



Create-File "$($path)\hotstrings\misc.ahk" @"
:*:btw::by the way
"@



Create-File "$($path)\hotstrings\work.ahk" @"
; A multi login script!
; Logs you in depending on browser used and site title
:*:loginAdv::
	WinGetTitle, title, A

	; These logins work only in Chrome
	#IfWinActive, ahk_class Chrome_WidgetWin
	IfInString, title, ProjectTitle1
		SendInput login1@evilcorp.com{tab}pwd{enter}

	Else IfInString, title, ProjectTitle2
		SendInput login2@evilcorp.com{tab}pwd{enter}

	Else
		SendInput login3@evilcorp.com{tab}pwd{enter}
	#IfWinActive

	; Firefox
	#IfWinActive, ahk_class MozillaWindowClass
	IfInString, title, ProjectTitle1
		SendInput login1@malware.com{tab}pwd{enter}

	Else IfInString, title, ProjectTitle2
		SendInput login2@malware.com{tab}pwd{enter}

	Else
		SendInput login3@malware.com{tab}pwd{enter}
	#IfWinActive
Return

; To find out your ahk_class, startup "Window Spy" which came with your Autohotkey installation
; Perhaps at: c:\Program Files\AutoHotkey\AU3_Spy.exe
"@



Create-File "$($path)\hotstrings\personal.ahk" @"
; Personal info
; :`t:itel::0475009854
; :`t:iname::Joh Doe"
"@



Create-File "$($path)\hotstrings\project1.ahk" ""

echo "Done"
echo ""
echo "Run mike.ahk to launch the Autohotkey script"
echo "It will run in the tray menu"
echo "Configure hotkeys by modifying config\mike.ini"
echo "Check the samples created to get started with hotstrings"
