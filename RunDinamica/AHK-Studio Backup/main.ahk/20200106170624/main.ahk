#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Include, Gdip_All.ahk
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


getPNGSize(imgPath, ByRef w, ByRef h) {
	pToken := Gdip_Startup()
	Gdip_GetDimensions(pBitmap := Gdip_CreateBitmapFromFile(imgPath), w1, h1)
	Gdip_DisposeImage(pBitmap)
	MsgBox, % "Time taken: " A_TickCount-t "`nWidth: " w1 "`nHeight: " h
	Gdip_ShutDown(pToken)
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

logMsg(stringValue) {
	DebugWindow(stringValue,Clear:=0,LineBreak:=1,Sleep=500)
	stdout := FileOpen("*", "w")
	stdout.Write(stringValue)
	file.Close()
;Obj2String(Obj)
;log?
}


okBtn := "ok_btn.png"
;logMsg(okBtn)
;logMsg(FileExist(okBtn))
;selectDinamica()
;hImg := LoadPicture(okBtn)
;clickAtImageCenter(okBtn)
getPNGSize(okBtn, w, h)

