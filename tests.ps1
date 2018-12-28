function Run-AllTests() {
	Get-ChildItem spec/*-tests.ahk -Recurse | % {
		Run-TestFile $_
	}
}


function Run-TestFile($file) {
	Push-Location $file.Directory.FullName

	$test = & Autohotkey $file.FullName
	$arr = $test -split "`n"

	foreach ($test in $arr) {
		if ($test -like "FAIL*") {
			Write-Host $test -ForegroundColor Magenta
		} else {
			Write-Host $test -ForegroundColor Green
		}
	}

	Pop-Location
}


function Run-Watcher() {
	# Blocking function!
	$watcher = New-Object System.IO.FileSystemWatcher
	$watcher.Path = get-location
	$watcher.IncludeSubdirectories = $true
	$watcher.EnableRaisingEvents = $false
	$watcher.NotifyFilter = [System.IO.NotifyFilters]::LastWrite -bor [System.IO.NotifyFilters]::FileName

	while ($TRUE) {
		$result = $watcher.WaitForChanged([System.IO.WatcherChangeTypes]::Changed -bor [System.IO.WatcherChangeTypes]::Renamed -bOr [System.IO.WatcherChangeTypes]::Created, 1000);
		if ($result.TimedOut) {
			continue;
		}

		if ($result.Name -like ".git*") {
			continue;
		}

		cls
		Write-Host "Change in" $result.Name "on" (get-date -f F)
		Run-AllTests
	}
}


# Execute
Run-AllTests
Run-Watcher
