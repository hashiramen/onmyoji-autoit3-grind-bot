; Haven't tested it on other simulators.. but it works on BlueStacks, you just have to fullscreen it and use the 1920 x 1080 display screen

#include <MsgBoxConstants.au3>
HotKeySet("{f1}", "StopGrind")

Global $YourEnergy = InputBox("Energy Amount", "What is your current energy?", "", "")
Global $StageKillingTime = InputBox("Battle Time", "How long(in seconds) does it takes you to kill stage with auto battle?", "", "")
Global $Difficulty = InputBox("Difficulty", "Which difficulty do you want?(type 'hard' or 'easy')?", "", "")

Global $color = 0xf9b4ba
Global $combatSleepTime = $StageKillingTime * 1000

Grind()

Func Grind()
  Sleep(5000)
  WinActivate("BlueStacks")
  SearchAreaForColor()
EndFunc

Func SearchAreaForColor()
  $variation = 1
  $left = 227
  $right = 1801
  $top = 63
  $bottom = 1018
  $isTimedOut = false

  while($YourEnergy > 3)
    Click(1659, 680)
    Sleep(5000)
    if $Difficulty == "hard" Then
      Click(739, 346)
      Sleep(2500)
    EndIf
    Click(1345, 785)
    Sleep(10500)
    Click(1717, 675)
    Sleep(3500)

    $startTime = TimerInit()
    while($isTimedOut == false)
      $pix = PixelSearch($left, $top, $right, $bottom, $color, $variation)

      if not @error Then
        MouseClick("left", $pix[0], $pix[1], 1, 1)
        BeginCombat()
        $startTime = TimerInit()
      EndIf

      if TimerDiff($startTime)> 12000 Then
        Click(122, 134)
        Sleep(5000)
        Click(1129, 601)
        Sleep(12000)
        $isTimedOut = true
      EndIf
    WEnd

    $isTimedOut = false
  WEnd

EndFunc

Func BeginCombat()
  Sleep(13000)
  $YourEnergy = $YourEnergy - 3
  MouseClick("left", 1652, 806, 1, 1)
  Sleep($combatSleepTime)
  MouseClick("left", 1652, 806, 1, 1)
  Sleep(5500)
EndFunc

Func Click($x, $y)
  MouseClick("left", $x, $y, 1, 1)
EndFunc

Func StopGrind()
  exit
EndFunc


; Link to main source https://github.com/hashiramen/onmyoji-autoit3-grind-bot