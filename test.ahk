#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include SendMouse.ahk
#Include PlayerMovement.ahk
#Include ReadMemory.ahk
#Include Segments.ahk

Hotkey, Pause, EarlyTerm     ;;;QUICK KILL COMMAND. *HIT Pause KEY ON KEYBOARD AT ANY TIME TO KILL THIS SCRIPT

^r::reload
^p::pause

^d::
  Beginning2()
return 

^y::
  yaw := GetFixedYaw()
  MsgBox, YAW: %yaw%
return

EarlyTerm:     ;;;STEP TO END THE HOTKEY FROM RUNNING
ExitApp         ;;;ENDS HOTKEY APPLICATION FROM RUNNING, ITS REMOVED FROM TOOL TRAY