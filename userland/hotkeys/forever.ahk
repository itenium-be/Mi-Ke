﻿KeepForeverRunning:
	Process, Exist, Ditto.exe
	if (ErrorLevel = 0)
	{
		Notify("Starting Ditto")
		if (FileExist("C:\Program Files (x86)\Ditto\Ditto.exe")) {
			Run, C:\Program Files (x86)\Ditto\Ditto.exe
		} else {
			Run, C:\Program Files\Ditto\Ditto.exe
		}
	}


	if (A_Hour > 2 and A_Hour < 7)
	{
		Process, Exist, Dropbox.exe
		if (ErrorLevel = 0)
		{
			Notify("Starting Dropbox")
			Run, C:\Program Files (x86)\Dropbox\Client\Dropbox.exe
		}
	}
return
