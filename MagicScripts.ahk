#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetTitleMatchMode, 1

; Table of Contents:
; 1. F8         - Add ddc debugger
; 2. Wheel Down - Scroll down
; 3. Wheel Up   - Scroll Up
; 4. Ctrl+C     - Copy
; 5. Ctrl+V     - Paste
; 6. Ctrl+Alt+s - Log into S5.6.7.MIS
; 7. Ctrl+Alt+t - Log into T5.6.7.MIS
; 8. Ctrl+Alt+o - Paste.  Split lines that are too long and merge.
; 9. Ctrl+Alt+g - Automates screen paste.  Removes Field| and Attribute|.  Puts data directly into E/E Screen routine.
; 10. Ctrl+Alt+u - Unlock routine
; 11. Ctrl+Alt+q - CGS 3M Field Macro Creator.  Copy Field Name, POS, and LEN from excel.
; 12. Ctrl+Shift+p - Increase Field Length of CGS 3M Grouper Software Update

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

#If (WinActive("ahk_class MRW") || WinActive("ahk_class MRWF")) && WinActive("ahk_exe T.exe") && not WinActive("DTS")

/* This doesn't work for now because MG hasn't been updated.
Check JIRA for more info: https://jira.meditech.com/browse/INFR-64616
F8::
If RegExMatch(Clipboard, "INTERNET\.[0-9]+", Device)
	SendRaw, `%Z.ddc("JWHITTEN-DDC","%Device%"),
Else
	SendRaw, `%Z.ddc("JWHITTEN-DDC",""),
Return
*/

F8::
If RegExMatch(Clipboard, "INTERNET\.[0-9]+", Device)
	SendRaw, IF{$DEV.NAME($FPN(^#))="%Device%" `%Z.ddc("JWHITTEN-DDC","%Device%")}
Else
	MsgBox, 16, Error, No device name in clipboard.
Return

WheelDown::
Send, {Down}
Return

WheelUp::
Send, {Up}
Return

^c::
;Send, {Alt Down}c{Alt Up}
Send, !{c}
Return

^v::
;Send, {Alt Down}v{Alt Up}
Send, !{v}
Return

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

^!s::
; Ctrl+Alt+s - Log into S5.6.7.MIS
Send, AI
Send, {enter}
Sleep, 250
Send, S5.6.7.MIS
Send, {enter}
Sleep, 250
Send, FE
Send, {enter}
Return

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

^!t::
; Ctrl+Alt+t - Log into S5.6.7.MIS
Send, AI3
Send, {enter}
Sleep, 250
Send, T5.6.7.MIS
Send, {enter}
Sleep, 250
Send, FE
Send, {enter}
Return

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

^!o::
; Ctrl+Alt+o - Paste into MG.  Split lines that are too long, then merge.

Clipboard = %Clipboard% ; Trim left and right whitespace
magicMax := 91

Loop Parse, Clipboard, `n, `r
{
	If(StrLen(A_LoopField) > magicMax) ; Check if line fits
		{
		SendRaw, % SubStr(A_LoopField, 1, magicMax - 1) ; Type what fits into the first line
		Send, {enter} ; Go down to new line
		SendRaw, % SubStr(A_LoopField, magicMax) ; Type the rest
		Send, {Home}
		Send, {Up}
		Send, +{F6} ; Merge with previous line
		Sleep, 250
		Send, {Down}
		Send, {enter} ; Start next line
		Send, {Up}
		Sleep, 100
		}
	Else ; Line fits
		{
		SendRaw, % A_LoopField
		Send, {enter}
		Sleep, 100
		}
}

Return

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

^!g::
;Ctrl+Alt+g - Automates screen paste.  Removes Field| and Attribute|.  Puts data directly into E/E Screen routine.

clipboard = %clipboard%  ; Trim left and right whitespaces
closeAttribute := ""
fromField := ""

loop parse, clipboard, `n, `r  ; `n before `r allows cross-platform parsing
{
	CurrentLine = %A_LoopField% ; Grab current looped line
	
	;// This section handles the Attributes.
	if(SubStr(CurrentLine, 1, 1) = "A") ; Check for Attribute|
	{
	If(fromField == 1) ; Last line was a Field, open attribute window
		{
		fromField := ""
		Send, {A}
		Sleep, 250
		Send, {enter}
		Sleep, 250
		}
	CurrentLine := SubStr(CurrentLine, 11)  ; Remove Attribute|
	closeAttribute = 1 ; Set flag to hit F12 when moves to next field
	
	Send, %CurrentLine% ; Enter attribute
	Sleep, 100
	Send, {enter}
	Sleep, 250
	}
	
	else if(SubStr(CurrentLine, 1, 1) = "F") ;// This section handles the Fields
	{
	If(closeAttribute == 1) { ; Last line was attribute.  Close attribute window.
		closeAttribute := ""
		Send, {F12} ; Close the attribute window.
		Sleep, 250
		Send, {3}
		Sleep, 250
		Send, {enter 3}
		Sleep, 250
		}
	If(fromField == 1) { ; Last line was a field, skip attribute window.
		Send, {enter}
		Sleep, 250
		}
		
	fieldPos := InStr(CurrentLine, "|", , , 2) ; Get the 2nd occurance of |
    CurrentLine := SubStr(CurrentLine, fieldPos + 1) ; Get the field name
	fromField = 1 ; Set flag to say that last line was a Field, Attributes might need to open.  If next line is Field too, skip attribute window.
	
	Send, %CurrentLine% ; Enter field name
	Sleep, 100
	Send, {enter} ; Move to Attribute field thing
	Sleep, 250
	}		
	}
;// Wrap things up
If(closeAttribute == 1) 
	{
	Send, {F12}
	Sleep, 250
	}	

;Cleanup
CurrentLine := ""

Return

^!u::
; Ctrl+Alt+u - Unlock routine

InputBox, procedure, "Unlock Procedure", "Enter in the entire procedure name to unlock:"

Send, OPEN NPR
Sleep, 100
Send, {enter}
Sleep, 100
SendRaw, ""^&[".LOCK","3IP","
Send, %procedure%
SendRaw, "]
Send, {enter}

Return

^!q::
; Ctrl+Alt+q - CGS 3M Field Macro Creator.  Copy Field Name, POS, and LEN from excel.
StringReplace, clipboard, clipboard, `r`n ; Removes carriage returns and new lines
array := StrSplit(clipboard, "`t") ; Delimits the clipboard by tab

; Put all of the data into variables for readability
fieldName := array[1]
POS := array[2]
LEN := array[3]

macroName =
commentField := "; CGS Field Name: " . fieldName

; Turn the fieldName into a MG macro name.  So OccuranceSpanCode turns into OCCURANCE.SPAN.CODE
Loop, Parse, fieldName
{
	currentChar := A_LoopField

	if (A_Index == 1)
		macroName = %currentChar%
	else if currentChar is upper
		macroName .= "." + currentChar
	else
		{
		StringUpper, currentChar, currentChar
		macroName .= currentChar
		}
}

Send, %macroName%
Sleep, 100
Send, {enter}
Sleep, 100
Send, %commentField%
Sleep, 100
Send, {enter}
Sleep, 100
Send, %POS%
Send, {Raw}^POS,
Send, %LEN%
Send, {Raw}^WDTH
Sleep, 100
Send, {enter}
	
Return

^+p::
; Ctrl+Shift+p - Remove old POS, add new legnth
POS = %Clipboard%
len := StrLen(POS)
POS += 98 ; Edit this number based on how many positions the fields have to move to accomodate new/deleted/edited fields.

Send, {Delete %len%}
Send, %POS%
Return
	
#If
