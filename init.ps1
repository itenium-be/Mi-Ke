# Script to get you up and running
# .\init.ps1 -bare to create without example hotstrings
param ([switch]$bare = $false)

# function Create-File($file, $initial = "") {
# 	if (-not (Test-Path $file)) {
# 		echo $file
# 		$initial | Out-File $file -Encoding UTF8
# 	}
# }

function Copy-File($fileName, $moveTo) {
	$destination = $fileName.Replace("-example.", ".")
	$destination = "$($path)\$moveTo\$destination"

	if (-not (Test-Path $destination)) {
		echo $file
		Copy-Item "$($path)\resources\init\$fileName" -Destination $destination
	}
}

$path = Split-Path $SCRIPT:MyInvocation.MyCommand.Path -Parent

# Copy-File "auto-execute-example.ahk" "userland"
Copy-File "_custom-example.yml" "config"
Copy-File "mike-example.ini" "config"


if (!$bare) {
	Copy-File "hotstrings-example.ahk" "userland\hotstrings"
	Copy-File "hotstrings-multi-login-example.ahk" "userland\hotstrings"

	Copy-File "hotkeys-example.ahk" "userland\hotkeys"
}

echo "Done"
echo ""
echo "Run mike.ahk to launch the Autohotkey script"
echo "It will run in the tray menu"

if (!$bare) {
	echo "Check the samples created in .\userland\ to get started with customization"
}
