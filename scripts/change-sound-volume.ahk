; The images are stored in scripts\change-sound-volume\*.jpg

GetBigStep()
{
	return ReadMikeIni("change-sound-volume", "step-big")
}

GetSmallStep()
{
	return ReadMikeIni("change-sound-volume", "step-small")
}

; Change music volume
; Hotkey: Windows+PageUp/Down
ChangeSoundVolumeAddBig:
SetAndDisplaySoundVolume("big", "+", true)
return

ChangeSoundVolumeMinBig:
SetAndDisplaySoundVolume("big", "-", true)
return

; Windows + Home
ChangeSoundVolumeSee:
DisplaySoundVolume()
return

lastVolumeLevel :=
ToggleMute(notify) {
	global lastVolumeLevel
	if (lastVolumeLevel) {
		SetAndDisplaySoundVolume(lastVolumeLevel, "", notify)
		lastVolumeLevel :=
	} else {
		SoundGetWaveVolume, volume
		SetAndDisplaySoundVolume(0, "", notify)
		lastVolumeLevel := volume
	}
}

; Windows + End
ChangeSoundToggleMute:
ToggleMute(true)
return

; Ctrl+Win+Alt: +/-1
ChangeSoundVolumeNoImageAddSmall:
SetAndDisplaySoundVolume("small", "+", false)
return

ChangeSoundVolumeNoImageMinSmall:
SetAndDisplaySoundVolume("small", "-", false)
return

; +Control: Without the fancy image but better response
ChangeSoundVolumeNoImageAddBig:
SetAndDisplaySoundVolume("big", "+", false)
return

ChangeSoundVolumeNoImageMinBig:
SetAndDisplaySoundVolume("big", "-", false)
return

ChangeSoundNoImageToggleMute:
ToggleMute(false)
return

SetAndDisplaySoundVolume(volumeMod, operator, notify)
{
	; volumeMod: "big", "small" or a number
	; operator: "+", "-" for big+small. Unused when volumeMod is a number

	if (volumeMod = "big" or volumeMod = "small") {
		volumeMod := volumeMod = "big" ? GetBigStep() : GetSmallStep()
		volumeMod := operator volumeMod
	}

	SoundSetWaveVolume, % volumeMod
	if notify
		DisplaySoundVolume()
}

DisplaySoundVolume()
{
	SoundGetWaveVolume, volume
	new PleasantNotify(volume, "")
}






Class PleasantNotify
{
	__New(volume, message, pnW=650, pnH=241, position="b r", time=400)
	{
		Critical
		lastfound := WinExist()

		imgPath = %A_ScriptDir%\scripts\change-sound-volume\change-sound-volume

		textX = 20
		textY = 12
		if volume >= 91
		{
			; Nice to have: show animated gif
			; http://www.autohotkey.com/board/topic/17722-show-animated-gifs-in-your-gui/
			Image = %imgPath%-60.gif
			pnW = 350
			pnH = 281
		}
		else if volume >= 81
		{
			Image = %imgPath%-90.jpg
			pnW = 510
			pnH = 319
		}
		else if volume >= 71
		{
			Image = %imgPath%-80.jpg
			pnW = 570
			pnH = 241
		}
		else if volume >= 61
		{
			Image = %imgPath%-70.jpg
			pnW = 313
			pnH = 393
		}
		else if volume >= 41
		{
			Image = %imgPath%-41.jpg
			pnW = 524
			pnH = 393
			textY = 250
		}
		else if volume >= 21
		{
			Image = %imgPath%-21.jpg
			pnW = 590
			pnH = 393
			textY = 340
		}
		else if volume >= 11
		{
			Image = %imgPath%-11.jpg
			pnW = 642
			pnH = 361
			textY = 310
		}
		else if volume > 0
		{
			Image = %imgPath%-1.jpg
			pnW = 590
			pnH = 393
		}
		else if volume = 0
		{
			Image = %imgPath%-0.jpg
			pnW = 500
			pnH = 250
		}


		title := "Volume " Round(volume)

		Gui, New, % "HwndPN_hwnd"
		this.PN_hwnd := PN_hwnd
		Gui, % PN_hwnd ": Default"
		Gui, % PN_hwnd ": +AlwaysOnTop +ToolWindow -SysMenu -Caption +LastFound"
		WinSet, Transparent, 0
		Gui, % PN_hwnd ": Color", 0xF2F2F0
		Gui, % PN_hwnd ": Font", c0x07D82F s18 wBold, Segoe UI
		Gui, % PN_hwnd ": Add", Text, % " x" textX " y" textY " w" 150 " hwndTitleHwnd", % title
		this.TitleHwnd := TitleHwnd
		Gui, % PN_hwnd ": Font", cBlack s15 wRegular

		Gui, Add, Picture, % " x" 0 " y" 0 " w" pnW " h" pnH " +0x4000000", %Image%

		;Gui, % PN_hwnd ": Add", Text, % " BackgroundTrans x" textX " y" textY " w" pnW " h" pnH-56 " hwndMessageHwnd", % message

		this.MessageHwnd := MessageHwnd
		RealW := pnW + 50
		RealH := pnH + 20
		Gui, % PN_hwnd ": Show", W%RealW% H%RealH% NoActivate
		this.WinMove(PN_hwnd, position)
		if A_ScreenDPI = 96
			WinSet, Region,0-0 w%pnW% h%pnH% R40-40,%A_ScriptName%

		Critical Off
		this.winfade("ahk_id " PN_hwnd, 210, 5)
		fn := bind("_NotifyTimer", this)
		SetTimer %fn%, % time * -1

		if (WinExist(lastfound))
		{
			Gui, % lastfound ":Default"
		}
	}

	__Delete()
	{
		this.Destroy()
	}

	TimerExpired()
	{
		this.winfade("ahk_id " this.PN_hwnd,0,5)
		Gui, % this.PN_Hwnd ": Destroy"
	}

	OKClicked()
	{
		this.Destroy()
	}

	Destroy()
	{
		this.winfade("ahk_id " PN_hwnd,0,5)
		Gui, % this.PN_Hwnd ": Destroy"
	}

	WinMove(hwnd,position)
	{
		SysGet, Mon, MonitorWorkArea
		WinGetPos,ix,iy,w,h, ahk_id %hwnd%
		x := InStr(position,"l") ? MonLeft : InStr(position,"hc") ?  (MonRight-w)/2 : InStr(position,"r") ? MonRight - w : ix
		y := InStr(position,"t") ? MonTop : InStr(position,"vc") ?  (MonBottom-h)/2 : InStr(position,"b") ? MonBottom - h : iy
		WinMove, ahk_id %hwnd%,,x,y
	}

	winfade(w:="",t:=128,i:=1,d:=10)
	{
		w:=(w="")?("ahk_id " WinActive("A")):w
		t:=(t>255)?255:(t<0)?0:t
		WinGet,s,Transparent,%w%
		s:=(s="")?255:s ;prevent trans unset bug
		WinSet,Transparent,%s%,%w%
		i:=(s<t)?abs(i):-1*abs(i)
		while(k:=(i<0)?(s>t):(s<t)&&WinExist(w))
		{
			WinGet,s,Transparent,%w%
			s+=i
			WinSet,Transparent,%s%,%w%
			sleep %d%
		}
	}
}

; Obj is the instance of the class that the timer expired on.
_NotifyTimer(obj)
{
	obj.TimerExpired()
}

; Obj is the instance of the class that OK was clicked in.
_NotifyOK(obj)
{
	obj.OKClicked()
}

pn_mod_title(title)
{
	global pn_title
	GuiControl, Notify: Text,pn_title, % title
}

pn_mod_msg(message)
{
	global pn_msg
	GuiControl, Notify: Text,pn_msg, % message
}

; bind v1.1 by Lexikos
; Requires test build of AHK? Will soon become part of AHK
; See http://ahkscript.org/boards/viewtopic.php?f=24&t=5802
bind(fn, args*)
{
	try bound := fn.bind(args*)  ; Func.Bind() not yet implemented.
	return bound ? bound : new BoundFunc(fn, args*)
}

class BoundFunc
{
	__New(fn, args*)
	{
		this.fn := IsObject(fn) ? fn : Func(fn)
		this.args := args
	}
	__Call(callee)
	{
		if (callee = "" || callee = "call" || IsObject(callee))
		{  ; IsObject allows use as a method.
			fn := this.fn
			return %fn%(this.args*)
		}
	}
}
