; Red Ball Level Reset Macro
; by InsaneJetman
;
; This macro needs "Show All" option has been activated in Adobe Flash Player.

#NoEnv
#SingleInstance force

PauseTime := 100
Turbo := false
Level := 1
HotKey := "F12"

Gui, Add, Text, , Level:
Gui, Add, Text, , Hotkey:
Gui, Add, Text, , Turbo Reset:
Gui, Add, Edit, vLevel w60, 1
Gui, Add, Edit, vHotKey w80, %HotKey%
Gui, Add, CheckBox, vTurbo
Gui, Add, Button, Default w80, OK
Gui, Show,, Red Ball Reset
return

GuiClose:
ButtonOK:
Gui, Submit, NoHide
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
  Scale := Min(ClientWide / 550, ClientHigh / 400)

  if (Turbo)
    SendMode Input

  MouseGetPos, MouseX, MouseY
  MouseClick, Left, MidX, MidY + Scale * 10, 1, 0
  Send, P
  Sleep, %PauseTime%
  MouseClick, Left, MidX, MidY + Scale * 10, 1, 0
  Sleep, %PauseTime%
  MouseClick, Left, MidX - Scale * 222, MidY + Scale * 20, 1, 10
  Sleep, %PauseTime%
  if (Level <= 12)
  {
    X := MidX - Scale * 192
    Y := MidY - Scale * 122
    MouseMove, X, Y, 4
    MouseClick, Left, X + Scale * Level * 30, Y, 1, 10
  }
  else
  {
    X := MidX - Scale * 87
    Y := MidY - Scale * 72
    MouseMove, X, Y, 4
    MouseClick, Left, X + Scale * (Level - 12) * 30, Y, 1, 10
  }
  MouseMove, MouseX, MouseY, 0
}
return
