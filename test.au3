#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3>


Opt("GUIOnEventMode", 1)

Local const $MAXVALUE = 15
Local Const $MAXBTN = 20

Global $arraybtm[$MAXBTN]
Global $valueNow = 0

#Region ### START Koda GUI section ###
$Form1 = GUICreate("Form1", 200, 200, 192, 124)
$left = 0
$top = 0
$index =0
for $i = 0 To  3
		$top += (24 +10)
	for $j = 0 To 4
		$left += (19 + 10 )

	$arraybtm[$index] = GUICtrlCreateButton("", $left, $top, 25, 25)
	GUICtrlSetOnEvent($arraybtm[$index], "Button1Click")
	$index += 1
	Next
	$left = 0
Next

GUISetOnEvent($GUI_EVENT_CLOSE, "mainFromClose")

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	Sleep(100)
WEnd

Func Button1Click()
  $controlID = @GUI_CtrlId
  $value = GUICtrlRead ($controlID)

	if($value <> "") Then

	    ;clear
		subValue($controlID)
	Else

	if($valueNow < $MAXVALUE) Then
		 $valueNow += 1
		GUICtrlSetData($controlID,$valueNow)
	ElseIf ( $valueNow = $MAXVALUE ) Then
		addValue()
		GUICtrlSetData($controlID,$valueNow)
	EndIf

	EndIf


EndFunc


Func getControlIDByBtnValue($conditionIdValue)

	For $i = 0 to UBound($arraybtm) - 1
		$itemControlId = $arraybtm[$i]
		$itemBtnValue = GUICtrlRead($itemControlId)
		if  $itemBtnValue = $conditionIdValue Then
			return $itemControlId
		EndIf
	Next

EndFunc

Func addValue()

	For $i = 0 to UBound($arraybtm) - 1
		$itemControId = $arraybtm[$i]
		 $value = GUICtrlRead ($itemControId)
		 if  $value <> ''  Then
			if ($value = "1" ) Then
				GUICtrlSetData($itemControId,"")
			Else
				$value -= 1
				GUICtrlSetData($itemControId,$value)
			EndIf
		Endif
	Next
EndFunc


Func subValue($controlID)
	 $valueNow -= 1
	 GUICtrlSetData($controlID,"")

	 $arraySort = sortItem()
			 $tempValueNow = $valueNow
			 For $i = UBound($arraySort)-1 to 0 Step - 1
				$itemSort = $arraySort[$i]
			GUICtrlSetData($itemSort,$tempValueNow)
			$tempValueNow -= 1
			Next
EndFunc

Func sortItem()

	Local $tempcontrolId
	Local $tempArrayValue[0]
	Local $size =  UBound($arraybtm) - 1


	For $i = 0 to $size
			$itemControlId = Int(GUICtrlRead( $arraybtm[$i]))
		If ($itemControlId <> "" ) Then
			_ArrayAdd($tempArrayValue, $itemControlId)
		EndIf

	Next

	_ArraySort($tempArrayValue)


	Local $retrunArray[0]

	$size =  UBound($tempArrayValue) - 1

	For $i = 0 to $size

		$itemControlId	= getControlIDByBtnValue($tempArrayValue[$i])
	_ArrayAdd($retrunArray,$itemControlId)
	Next

	return $retrunArray;


EndFunc

Func mainFromClose()
	Exit
EndFunc