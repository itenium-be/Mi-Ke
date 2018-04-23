quickStarterz := []

configFile = %A_Scriptdir%\config\quick-starters.yml
IfNotExist %configFile%
	configFile = %A_Scriptdir%\config\quick-starters.default.yml

ConvertYamlToQuickStarters(configFile)


ConvertYamlToQuickStarters(A_Scriptdir "\config\browsers.yml")
