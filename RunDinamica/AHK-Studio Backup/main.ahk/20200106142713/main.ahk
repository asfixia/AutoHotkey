#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.




coordMode,pixel
ImageSearch,ix,iy,0,0,a_screenHeight,a_screenWidth,.\ok_btn.png
MouseClick, left,  ix+20, iy+20
