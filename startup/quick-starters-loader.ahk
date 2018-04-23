quickStarterz := []

qsYaml := Yaml("", 0)
Loop, Files, %A_Scriptdir%\config\*.yml
{
	if (A_LoopFileName = "_custom.yml")
		continue

	fileYaml := Yaml(A_LoopFileFullPath)
	Yaml_Merge(qsYaml, fileYaml)
}


; customConfig = Yaml(A_Scriptdir "\config\_custom.yml")
; Yaml_Merge(qsYaml, customConfig)

; Notify("DBeaver", qsYaml.DBeaver.Dump(), 8)


ConvertYamlToQuickStarters(qsYaml)


; uhoh := GetQuickStarterInfoByName("Calculator")
; Notify("wuuk", uhoh.name ": " uhoh.hotkey)
