quickStarterz := []

qsYaml := Yaml("", 0)
Loop, Files, %A_Scriptdir%\config\*.yml, R
{
	if (A_LoopFileName = "_custom.yml")
		continue

	fileYaml := Yaml(A_LoopFileFullPath)
	Yaml_Merge(qsYaml, fileYaml)
}


customConfig := Yaml(A_Scriptdir "\config\_custom.yml")
Yaml_Merge(qsYaml, customConfig)

; Notify("customConfig", customConfig.Dump(), 8)


ConvertYamlToQuickStarters(qsYaml)


; shouldHaveChanged := GetQuickStarterInfoByName("Calculator")
; Notify("Calculator", shouldHaveChanged.name ": " shouldHaveChanged.hotkey)
