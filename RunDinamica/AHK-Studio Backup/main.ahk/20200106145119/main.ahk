#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Include, Gdip_All.ahk
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


getPNGSize(imgPath, ByRef w, ByRef h) {
	pToken := Gdip_StartUp()
	pBitmap := Gdip_CreateBitmapFromFile(filePath)
	Gdip_GetImageDimensions(pBitmap, w, h)
	Gdip_DisposeImage(pBitmap)
	Gdip_ShutDown(pToken)
	MsgBox, % "Width: " w " Height: " h
	return
}

clickAtImageCenter(imgPath) {
	coordMode,pixel
	ImageSearch,ix,iy,0,0,a_screenHeight,a_screenWidth,imgPath
	getPNGSize(imgPath, w, h)
	MouseClick, left,  ix+(w/2), iy+(h/2)
	return
}

selectDinamica() {
	SetTitleMatchMode, 1
	WinActivate , Dinamica EGO 5
}


stdout := FileOpen("*", "w")

stdout.Write("qasvasbasbasbasb")
okBtn := "C:\\Danilo\\Trampo\\AutoHotkey\\RunDinamica\\ok_btn.png"
selectDinamica()
clickAtImageCenter(okBtn)