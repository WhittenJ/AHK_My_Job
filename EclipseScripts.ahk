#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

; Table of Contents:
; 1. Ctrl+Alt+q - CGS 3M Field Macro Creator.  Copy Field Name, POS, and LEN from excel.
; 2. Ctrl+Shift+p - Increase Field Length of CGS 3M Grouper Software Update

#If (WinActive("ahk_class SWT_Window0") && WinActive("ahk_exe eclipse.exe"))

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
Send, {Raw}^START,
Send, %LEN%
Send, {Raw}^LEN
Sleep, 100
Send, {enter}
	
Return

^+p::
; Ctrl+Shift+p - Remove old POS, add new legnth
Send, ^c ; Copies highlighted text to clipboard.
ClipWait, 2

Sleep, 250

POS = %Clipboard%
len := StrLen(POS)
POS += 98 ; Edit this number based on how many positions the fields have to move to accomodate new/deleted/edited fields.

Send, {Delete %len%}
Send, %POS%
Return

#If
