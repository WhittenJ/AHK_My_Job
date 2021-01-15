#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

; Table of Contents:
; 1. F11        - Replaces F11 with Esc, disables EMR
; 2. Ctrl+Alt+g - Automates screen paste.  Removes Field| and Attribute|.  Puts data directly into E/E Screen routine.
; 3. Ctrl+Alt+u - Unlock routine

#If (WinActive("ahk_class MagicFrame") || WinActive("ahk_class MGUIWin")) && WinActive("ahk_exe CSMagic.exe")

F11::
Send, {esc}
Return

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

^!u::
; Ctrl+Alt+u - Unlock routine

InputBox, procedure, "Unlock Procedure", "Enter in the entire procedure name to unlock:"

Send, OPEN NPR
Sleep, 100
Send, {enter}
Sleep, 100
SendRaw, ""^*(I)[".LOCK","IP","
Send, %procedure%
SendRaw, "]
Send, {enter}

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
		Send, {enter}
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

#If
