#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include SendMouse.ahk
#Include ReadMemory.ahk
;360 degrees yaw is mouse movement of 1440 horizontally
;-700 vertically moves pitch all the way up to 89
;90 degrees pitch is mouse movement of 360 vertically

;----------------
; CONSTANTS
;----------------
YAW360 := 1440
PITCH90 := 360
POS_TOLERANCE := 0.5 ;how much off you can be off the destination position

;----------------
; Global vars
;----------------
gamePtrs:= {}
gamePtrs.Health := [GetGameDLLAddr() + 0x1C9B460, "Float", 0x122C],
gamePtrs.PlayerX := [GetGameDLLAddr() + 0x1C9B460, "Float", 0x1168],
gamePtrs.PlayerY := [GetGameDLLAddr() + 0x1C9B460, "Float", 0x1170],
gamePtrs.PlayerZ := [GetGameDLLAddr() + 0x1C9B460, "Float", 0x1160],
gamePtrs.HeadX := [GetGameDLLAddr() + 0xA0074C, "Float"],       ; not working right now 
gamePtrs.HeadY := [GetGameDLLAddr() + 0xA0074C, "Float", 0x8],  ; not working right now
gamePtrs.HeadZ := [GetGameDLLAddr() + 0xA0074C, "Float", 0x4],  ; not working right now
gamePtrs.HeadPitch := [GetGameDLLAddr() + 0x1C9B460, "Float", 0x1148],
gamePtrs.HeadYaw := [GetGameDLLAddr() + 0x1C9B460, "Float", 0x11C0]

StartGettingGameAddresses() { ; OBSOLETE
  SetTimer, GetGameAddresses, 100
}

GetGameAddresses() { ; OBSOLETE
  global gameAddresses
  Loop, read, %A_ScriptDir%/GameData/data.txt
  {
    split := StrSplit(A_LoopReadLine, ":")
    key := split[1]
    address := split[2]
    gameAddresses[key] := address
  }
}

getProp(prop) {
  global gamePtrs
  mem := getMem()
  ptr := gamePtrs[prop]
  val := mem.read(ptr*)
  return val
}

SetPitchTo(deg) {
  global PITCH90
  initial := getProp("HeadPitch")
  moveAmt := (initial-deg)/90 * PITCH90
  SendMouse_RelativeMove(0, moveAmt)
}


SetYawTo(deg) {
  initial := getFixedYaw()
  ChangeYawBy(deg - initial)
}

GetFixedYaw() {
  return mod(getProp("HeadYaw"), 360.0)
}

ChangeYawBy(deg) {
  global YAW360
  SendMouse_RelativeMove(deg/360 * YAW360, 0)
}

SprintTo(x, y) {
  SendInput, {Shift down}
  MoveTo(x, y)
  SendInput, {Shift up}
}

SpamSpace(time) {
  t := 0
  while t < time {
    SendInput {Space}
    Sleep, 10
    t += 10
  }
}

MoveTo(x, y) {
  global POS_TOLERANCE
  SendInput, {w down} 
  while 1 {
    xDiff := x - getProp("PlayerX")
    yDiff := y - getProp("PlayerY")
    
    angle := ATan(yDiff / xDiff) * 57.29578 ; convert to degrees
    if (xDiff < 0)
      angle += 180
    
    SetPitchTo(0)
    SetYawTo(angle)

    ;---------
    ; Check if player is within the tolerance
    ;--------- 
    if (InRange(getProp("PlayerX"), x, POS_TOLERANCE) and InRange(getProp("PlayerY"), y, POS_TOLERANCE))
      break

    ;---------
    ; Check if player has moved passed dest
    ;--------- 
    if (xDiff > 0) {
      if (getProp("PlayerX") >= x)
        break
    } else {
      if (getProp("PlayerX") <= x)
        break
    }

    if (yDiff > 0) {
      if (getProp("PlayerY") >= y)
        break
    } else {
      if (getProp("PlayerY") <= y)
        break
    }
    sleep 10
  }
  SendInput, {w up}
}

InRange(val, target, range) {
  return val >= target-range and val <= target+range 
}