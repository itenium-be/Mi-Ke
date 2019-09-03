KeepForeverRunning:
	Process, Exist, Ditto.exe
	if (ErrorLevel = 0)
	{
		Notify("Starting Ditto")
		Run, C:\Program Files (x86)\Ditto\Ditto.exe
	}
return
