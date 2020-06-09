#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include <classMemory> ;Include the memory class from the lib folder

; Not required - Just checks if you copied the class correctly
if (_ClassMemory.__Class != "_ClassMemory")
    msgbox class memory not correctly installed. Or the (global class) variable "_ClassMemory" has been overwritten

; Create an object to read the games memory
; The process/game must be running.
; If the process closes/restarts, then you need to call this line again.... You can call it before every read if you really want.
mem := new _ClassMemory("ahk_exe DyingLightGame.exe", "", hProcessCopy) 
gameDLLBase := mem.getModuleBaseAddress("gamedll_x64_rwdi.dll")

;not required, but If it fails get the reason why
if !isObject(mem) 
{
    msgbox failed to open a handle
    if (hProcessCopy = 0)
        msgbox The program isn't running (not found) or you passed an incorrect program identifier parameter. 
    else if (hProcessCopy = "")
        msgbox OpenProcess failed. If the target process has admin rights, then the script also needs to be ran as admin. Consult A_LastError for more information.
    ExitApp
}

GetMem() {
  global mem
  return mem
}

GetGameDLLAddr() {
  global gameDLLBase
  return gameDLLBase
}