#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include PlayerMovement.ahk

TowerDoorToLedge() {
  ; ------------
  ; Goes through tower door and jumps up the ledge
  ; ------------
  SendInput, {Shift down}
  MoveTo(270.47, 87.29)
  MoveTo(264, 87.29)
  MoveTo(262, 90.13)
  MoveTo(261, 92)
  MoveTo(260.585, 94.185)
  SetPitchTo(28)
  SetYawTo(-185.5)
  Sleep 10
  SendInput, {w down}
  Sleep 20 ; 25 or 20?
  SendInput, {Space down}
  ; TODO: Wait until player is fully up instead of sleeping
  Sleep 1500
  SendInput, {w up}{Space up}
  SendInput, {Shift up}
}