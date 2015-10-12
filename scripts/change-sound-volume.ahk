; Change music volume
; Hotkey: Windows+PageUp/Down
#PgUp::SetAndDisplaySoundVolume("+10")
#PgDn::SetAndDisplaySoundVolume("-10")
#End::SetAndDisplaySoundVolume(0)

; +Control: Without the fancy image but better response
^#PgUp::SoundSetWaveVolume, +10
^#PgDn::SoundSetWaveVolume, -10
^#End::SoundSetWaveVolume, 0

SetAndDisplaySoundVolume(volume)
{
	SoundSetWaveVolume, % volume
	SoundGetWaveVolume, volume
	volume := "Volume " Round(volume)
	new PleasantNotify(volume, "")
}






Class PleasantNotify
{
	__New(title, message, pnW=570, pnH=241, position="b r", time=200)
	{
		Critical
		lastfound := WinExist()

		Gui, New, % "HwndPN_hwnd"
		this.PN_hwnd := PN_hwnd
		Gui, % PN_hwnd ": Default"
		Gui, % PN_hwnd ": +AlwaysOnTop +ToolWindow -SysMenu -Caption +LastFound"
		;WinSet, ExStyle, +0x20
		WinSet, Transparent, 0
		Gui, % PN_hwnd ": Color", 0xF2F2F0
		Gui, % PN_hwnd ": Font", c0x07D82F s18 wBold, Segoe UI
		Gui, % PN_hwnd ": Add", Text, % " x" 20 " y" 12 " w" 150 " hwndTitleHwnd", % title
		this.TitleHwnd := TitleHwnd
		Gui, % PN_hwnd ": Font", cBlack s15 wRegular

		Image = %A_ScriptDir%\scripts\change-sound-volume-max.jpg
		Gui, Add, Picture, x0 y0 w610 h385 +0x4000000, %Image%

		Gui, % PN_hwnd ": Add", Text, % " BackgroundTrans x" 20 " y" 56 " w" pnW " h" pnH-56 " hwndMessageHwnd", % message

		if (time = "P")
		{
			Gui, % PN_hwnd ": Add", Button, % " x" pnW - 80 " y" pnH - 50 " w50 h25 ", OK
			; When OK is clicked, call this instance of the class
			fn := bind("_NotifyOK", this)
			GuiControl +g, OK, %fn%
		}
		this.MessageHwnd := MessageHwnd
		RealW := pnW + 50
		RealH := pnH + 20
		Gui, % PN_hwnd ": Show", W%RealW% H%RealH% NoActivate
		this.WinMove(PN_hwnd, position)
		;Gui, % PN_Hwnd ": +Parent" A_ScriptHwnd
		if A_ScreenDPI = 96
			WinSet, Region,0-0 w%pnW% h%pnH% R40-40,%A_ScriptName%
		/* For Screen text size 125%
		if A_ScreenDPI = 120
			WinSet, Region, 0-0 w800 h230 R40-40, %A_ScriptName%
		*/
		Critical Off
		this.winfade("ahk_id " PN_hwnd,210,5)
		if (time != "P")
		{
			; Bind this class to the timer.
			fn := bind("_NotifyTimer", this)
			SetTimer %fn%, % time * -1
		}

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