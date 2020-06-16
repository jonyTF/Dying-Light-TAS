#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include PlayerMovement.ahk

Beginning() {
  ; ------------
  ; After Crane wakes up at beginning
  ; ------------
  
  ; Start Position
  ; X: 256.83, Y: 53.88, Z: 233.87
  MoveTo(252.19, 54.15)
  MoveTo(251.38, 55.19)
  MoveTo(252.85, 57.14)
  MoveTo(253.29, 57.88)
}

Beginning2() {
  ; ------------
  ; Walking to Breckens office
  ; ------------

  ; Start Position
  ; X: 250.61, Y: 61.09, Z: 233.87
  MoveTo(250.61, 61.09)
  MoveTo(248.62, 61.52)
  MoveTo(247.47, 63.31)
  ; JUMP
  SendInput, {Space}
  MoveTo(246.56, 65.1)
  MoveTo(246.23, 68.99)
  MoveTo(246.51, 70.68)
  MoveTo(249.33, 72.6)
  MoveTo(263.68, 72.73)
  MoveTo(265.07, 72.17)
  MoveTo(265.16, 70.63) ; At bottom of stairs
  MoveTo(260.91, 68.72)
  SendInput, {Space}
  MoveTo(260.6, 67.04)


  MoveTo(266.6, 66.2)
  SendInput, fff
  MoveTo(268.72, 65.74)
  MoveTo(271.64, 63.45)
  MoveTo(273.84, 61.55)
  ; Jump over desk
  SendInput, {Space}
  MoveTo(276.15, 60.13)
  SendInput, {w down}
  ;SpamKey("f", 5000, 10)
  Sleep 1000
  SendInput, {w up}
}

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