
GoToEditEnvironmentVariables() {
	Run % "control.exe sysdm.cpl,System,3"
	WinWaitActive System Properties ahk_class #32770, ,2
	; Send {ALT DOWN}n{ALT UP}
	; Send !n!sp
}
