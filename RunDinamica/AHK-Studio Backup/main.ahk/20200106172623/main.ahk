#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Include, Gdip_All.ahk
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


/*
ImageSearchc - alternative to ImageSearch (uses GDI+; requires Gdip.ahk by Tic and Gdip_ImageSearch (put inside Gdip.ahk) by MasterFocus)
    Param1 - found x-coord
    Param2 - found y-coord
    Param3 - top x corner of area to search
    Param4 - top y corner of area to search
    Param5 - bottom x corner of area to search
    Param6 - bottom y corner of area to search
    Param7 - file of image to search for
    Param8 - variation (see doc for ImageSearch)
        Default: 0
    Param9 - transcolor (see doc for ImageSearch)
        Default: ""
    Param10 - relative (base coords off active window) (boolean)
        Default: 0
    Param11 - Search direction
        Vertical preference:
           1 = top->left->right->bottom
           2 = bottom->left->right->top
           3 = bottom->right->left->top
           4 = top->right->left->bottom
         Horizontal preference:
           5 = left->top->bottom->right
           6 = left->bottom->top->right
           7 = right->bottom->top->left
           8 = right->top->bottom->left
        Default: 5
    Param12 - save captured screen to active directory for debugging (boolean)
        Default: 0
*/
 
ImageSearchc(ByRef out1, ByRef out2, x1, y1, x2, y2, image, vari=0, trans="", rela=0, direction=5, debug=0){
	dxoff:=0
	dyoff:=0
	if(rela)
	{
		WinGetPos,xoff,yoff,woff,hoff,A
		x2=x2 > woff ? woff : x2
		y2=y2 > hoff ? hoff : y2
		x1+=xoff,x2+=xoff
		y1+=yoff,y2+=yoff
	}
	
	ptok:=Gdip_Startup()
	imageB:=Gdip_CreateBitmapFromFile(image)
	Scrn:=Gdip_Bitmapfromscreen(x1 "|" y1 "|" x2 - x1 "|" y2 - y1)
	if(debug)
		Gdip_SaveBitmapToFile(Scrn, a_now ".png")
	Errorlev:=Gdip_ImageSearch(Scrn,imageB,tempxy,0,0,0,0,vari,trans,direction)
	Gdip_DisposeImage(Scrn)
	Gdip_DisposeImage(imageB)
	Gdip_Shutdown(ptok)
	if(Errorlev > 0)
	{
		out:=StrSplit(tempxy,"`,")
		out1:=out[1] + x1 - dxoff
		out2:=out[2] + y1 - dyoff
		return % Errorlev
	}
	return 0
}

getPNGSize(imgPath, ByRef w, ByRef h) {
	pToken := Gdip_Startup()
	Gdip_GetDimensions(pBitmap := Gdip_CreateBitmapFromFile(imgPath), w, h)
	Gdip_DisposeImage(pBitmap)
	logMsg("`nWidth: " . w . "`nHeight: " . h)
	Gdip_ShutDown(pToken)
	return
}

clickAtImageCenter(imgPath) {
	coordMode,pixel
	ImageSearch,ix,iy,0,0,a_screenWidth,a_screenHeight,imgPath
	getPNGSize(imgPath, w, h)
	logMsg("FOUND : " . ix . " " . iy )
	MouseClick, left,  ix+(w/2), iy+(h/2)
	return
}

selectDinamica() {
	SetTitleMatchMode, 1
	WinActivate , Dinamica EGO 5
	Sleep, 300
}

logMsg(stringValue) {
	DebugWindow(stringValue,Clear:=0,LineBreak:=1,Sleep=500)
	stdout := FileOpen("*", "w")
	stdout.Write(stringValue)
	file.Close()
;Obj2String(Obj)
;log?
}

backToAHK() {
	Sleep, 1000
	SetTitleMatchMode, 1
	WinActivate , AHK Studio
	
}

okBtn := %A_ScriptDir%. "\ok_btn.jpg"
logMsg("Screen W: " . A_ScreenWidth . " H: " . a_screenHeight)
logMsg(okBtn)
logMsg(FileExist(okBtn))
selectDinamica()
clickAtImageCenter(okBtn)


ImageSearch, iX, iY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, okBtn
logMsg(iX . %iX%)
SendInput, {Click, %iX%, %iY%, Left}

imageSearchC(ix,iy,0,0,a_screenWidth,a_screenHeight,"C:\Users\joc191\Downloads\2016-09-14_12-33-00.png",,,,1)

backToAHK()