; Windows + Enter
; See image dimensions and file size
; Press again to copy dimensions to clipboard
lastImagePath :=
lastImageSize :=

; NotImplemented: An icon can have multiple dimensions inside
SeeImageDimensions:
selectedFiles := Explorer_GetSelectedArray()
selectedFile := selectedFiles[1]
if (selectedFile <> "" and selectedFile <> "ERROR") {
	If (lastImagePath = selectedFile and A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 2000) {
		clipboard := lastImageSize
		Notify("On Clipboard", lastImageSize)
		return
	}


	gdip1 := new Gdip()
	bitmap1 := Gdip.BitmapFromFile(selectedFile)
	if !bitmap1.Pointer
	{
		Notify("Image loading error!", selectedFile)
		return
	}


	lastImagePath := selectedFile
	lastImageSize := bitmap1.size.width "x" bitmap1.size.height

	FileGetSize, imageFileSize, %selectedFile%
	imageFileSize := "Size: " autoByteFormat(imageFileSize) "`n"

	imgInfo := lastImageSize
	Notify(imgInfo, imageFileSize "`n" selectedFile, 5)

	bitmap1 :=
	gdip1 :=
}
return
