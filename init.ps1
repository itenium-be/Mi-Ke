# Script to get you up and running
# .\init.ps1 -bare to create without example hotstrings
param ([switch]$bare = $false)

function Create-File($file, $initial = "") {
	if (-not (Test-Path $file)) {
		echo $file
		$initial | Out-File $file -Encoding UTF8
	}
}

function Copy-File($fileName, $moveTo) {
	if (-not (Test-Path $file)) {
		echo $file
		$realFileName = $fileName.Replace("-example.", ".")
		Copy-Item "$($path)\resources\init\$fileName" -Destination "$($path)\$moveTo\$realFileName"
	}
}

$path = Split-Path $SCRIPT:MyInvocation.MyCommand.Path -Parent

Copy-File("auto-execute-example.ahk", "userland")

exit

# Copy-Item "$($path)\resources\init\auto-execute-example.ahk" -Destination "$($path)\userland\auto-execute.ahk"

# Create-File "$($path)\hotkeys\_includes.ahk" @"
# ;
# ; Your scripts here
# ;

# ; !F5::Msgbox Pressed %A_ThisHotkey%
# "@

# Create config files
$iniPath = "$($path)\config\mike.ini"
if (-not (Test-Path -Path $iniPath -PathType Leaf)) {
	echo "Creating config\mike.ini"
	Copy-Item "$($path)\resources\init\mike-example.ini" -Destination "$($path)\config\mike.ini"
}



if ($bare) {
	# Create-File "$($path)\hotstrings\_includes.ahk" ""
	return
}





$qsPath = "$($path)\config\_custom.yml"
if (-not (Test-Path -Path $qsPath -PathType Leaf)) {
	echo "Creating config\_custom.yml"
	Create-File $qsPath @""@
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
; Default shortcut: Alt + F12
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
