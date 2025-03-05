#include <Array.au3>

Local $NumOfRounds, $iWinCountNoSwitch = 0, $iWinCountDoSwitch = 0

; Let's do one thousand rounds of this game, twice! One thousand for not switching answer and one thousand for switching.
$NumOfRounds = 1000 ; or 10000 or 1000000

; First, we play 1 thousand rounds and don't switch our answer
For $i = 1 To $NumOfRounds
	$iWinCountNoSwitch += _PlayGame(0)
Next

; Now lets play another thousand rounds and do switch our answer
For $i = 1 To $NumOfRounds
	$iWinCountDoSwitch += _PlayGame(1)
Next

; Here's the results...
MsgBox(0, "Results", "Here are the results:" & @CRLF & $iWinCountNoSwitch & " NO switch wins out of " & _
	$NumOfRounds & " rounds" & @CRLF & $iWinCountDoSwitch & " DO switch wins out of " & $NumOfRounds & " rounds")

; This is the function that works behind the scene to actually play the game
Func _PlayGame($iSwitch)
	Local $iPlayerWins = 0 ; Player winning variable resets every time function called

	; First, have 3 doors with nothing in them
	Local $array[3] = [0, 0, 0]

	; Next, put a prize in one of them. The other two have goats.
	$iRandom = Random(0, 2, 1) ; Pick the door for the prize (the number 1 is the prize, 0 are goats)
	$array[$iRandom] = 1 ; Put the prize in that door

	; The player picks a door
	$iDoorChoice = Random(0, 2, 1)

	; The host picks a random available door that has a goat
	Local $iGoat
	Do
		$iGoat = Random(0, 2, 1) ; Pick a random number
	Until $iGoat <> $iDoorChoice AND $array[$iGoat] <> 1 ; 1 being the prize

	; This section is for whether the player switches doors
	If $iSwitch = 1 Then ; 0 player does not switch doors, 1 player does switch doors
		If $iDoorChoice = 0 And $iGoat = 1 Then
			$iDoorChoice = 2
		ElseIf $iDoorChoice = 0 And $iGoat = 2 Then
			$iDoorChoice = 1
		ElseIf $iDoorChoice = 1 And $iGoat = 0 Then
			$iDoorChoice = 2
		ElseIf $iDoorChoice = 1 And $iGoat = 2 Then
			$iDoorChoice = 0
		ElseIf $iDoorChoice = 2 And $iGoat = 0 Then
			$iDoorChoice = 1
		ElseIf $iDoorChoice = 2 And $iGoat = 1 Then
			$iDoorChoice = 0
		EndIf
	EndIf

	; Determine if the player has won
	If $array[$iDoorChoice] = 1 Then
		Return 1
	ElseIf $array[$iDoorChoice] = 0 Then
		Return 0
	EndIf
EndFunc