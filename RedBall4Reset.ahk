; Red Ball 4 Level Reset Macro
; by InsaneJetman and Mr. Frosty
;
; This macro assumes that the "Show All" option has been activated in Adobe Flash Player.

#NoEnv
#SingleInstance force
PauseTime = 100

Gui, New, , Red Ball Reset
Gui, Add, Text, , Level:
Gui, Add, Text, , Hotkey:
Gui, Add, Text, , Turbo Reset:
Gui, Add, Edit, ys w60
Gui, Add, UpDown, vLevel Range1-15, 1
Gui, Add, Edit, vHotKey w80, F12
Gui, Add, CheckBox, vTurbo
Gui, Add, Button, Default w80, OK
Gui, Show
return

GuiClose:
ButtonOK:
Gui, Submit
Hotkey, %HotKey%, Reset
return

Reset:
hwnd := WinActive("Adobe Flash Player")
if (hwnd)
{
  WinGetPos, WindowX, WindowY, , , ahk_id %hwnd%
  VarSetCapacity(RECT, 16, 0)
  DllCall("user32\GetClientRect", Ptr, hwnd, Ptr, &RECT)
  DllCall("user32\ClientToScreen", Ptr, hwnd, Ptr, &RECT)
  ClientX := NumGet(&RECT, 0, "Int") - WindowX
  ClientY := NumGet(&RECT, 4, "Int") - WindowY
  ClientWide := NumGet(&RECT, 8, "Int")
  ClientHigh := NumGet(&RECT, 12, "Int")
  MidX := ClientX + ClientWide / 2
  MidY := ClientY + ClientHigh / 2
  Scale := Min(ClientWide / 640, ClientHigh / 480)
  LevelX := Mod(Level + 4, 5)
  LevelY := (Level + 4)//5

  if (Turbo)
    SendMode Input

  MouseGetPos, MouseX, MouseY
  MouseClick, Left, MidX - Scale * 295, MidY + Scale * 220, 1, 0
  Sleep, %PauseTime%
  MouseClick, Left, MidX - Scale * 200, MidY + Scale * 180, 1, 0
  Sleep, %PauseTime%
  MouseClick, Left, MidX, MidY + Scale * 10, 1, 10
  Sleep, %PauseTime%
  MouseMove, MidX + Scale * (LevelX * 90 - 180), MidY + Scale * (LevelY * 85 - 170) , 4
  MouseClick, Left
  if (Level = 1)
  {
    MouseClick, Left, MidX + Scale * 280, MidY + Scale * 220
  }
  MouseMove, MouseX, MouseY, 0
}
return
