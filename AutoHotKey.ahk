SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). The value -1 means the script will run at it's max speed possible.
#Persistent ; Keeps script permanently running
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force ; Ensures that there is only a single instance of this script running.
#InstallKeybdHook
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#include %A_ScriptDir%\CSCCScripts.ahk
#include %A_ScriptDir%\EclipseScripts.ahk
#include %A_ScriptDir%\VSCodeScripts.ahk
#include %A_ScriptDir%\MagicScripts.ahk
#include %A_ScriptDir%\MATScripts.ahk

; Table of Contents:
; 1. CS Specific Macros:
;    A. F11        - Replaces F11 with Esc, because I hate EMR
;    B. Ctrl+Alt+g - Automates screen paste.  Removes Field| and Attribute|.  Puts data directly into E/E Screen routine.
;    C. Ctrl+Alt+u - Unlock routine
;
; 2. Eclipse Specific Macros:
; 	 A. Ctrl+Alt+q   - CGS 3M Field Macro Creator.  Copy Field Name, POS, and LEN from excel.
; 	 B. Ctrl+Shift+p - Increase Field Length of CGS 3M Grouper Software Update.
;
; 3. MG Specific Macros:
;    A. Wheel Down - Scroll down
;    B. Wheel Up   - Scroll Up
;    C. Ctrl+C     - Copy
;    D. Ctrl+V     - Paste
;    E. Ctrl+Alt+s - Log into S5.6.7.MIS
;    F. Ctrl+Alt+t - Log into T5.6.7.MIS
;    G. Ctrl+Alt+o - Paste.  Split lines that are too long and merge.
;    H. Ctrl+Alt+g - Automates screen paste.  Removes Field| and Attribute|.  Puts data directly into E/E Screen routine.
;    I. Ctrl+Alt+u - Unlock routine
;
; 4. TextPad Specific Macros for MAT:
;    A. Ctrl+Alt+t - MAT Screen Template
;    B. Ctrl+Alt+i - MAT Lookup Template
;    C. GUI Code to support screens:
;        i. Cancel Button Code
;       ii. Screen Template Submit Code
;      iii. Lookup Template Create Code
;
; 5. Generic Macros:
;	 A.  Ctrl+S     - Save and reload Script.  Only works in Notepad++.
;	 B.  Ctrl+R     - Reload Script.  Only works in Notepad++.
;	 C.  Ctrl+Alt+h - Displays Help (Readme file)
;	 D.  Ctrl+Alt+l - Shows length and number of spaces of highlighted text in popup box.
;	 E.  Ctrl+Space - Set active window to always on top.  Doesn't always work.
;	 F. Ctrl+Alt+d  - Take CS BAR 1337 turn into DTS link. Warning: Hits Enter at the end.
;	 G. Ctrl+Alt+f  - Take DTS link, turn it into Shorthand (CS BAR 1337) Warning: Hits Enter at the end.
;	 H. Ctrl+Alt+j  - Takes JIRA number, makes it into JIRA link.  Warning: Hits Enter at the end.
;	 I. Ctrl+Alt+p  - Parse Crucible review for pasting.  Does not auto paste.
;	 J. Ctrl+Alt+b  - Remove "Attribute|" code for pasting.  Does not auto paste.

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

#If (WinActive("ahk_class Notepad++") && WinActive("ahk_exe Notepad++.exe"))
 
~^s::
^r::
; Ctrl+S OR Ctrl+R - Saves and reloads script.
TrayTip, Reloading updated script, %A_ScriptName%
SetTimer, RemoveTrayTip, 1500
Sleep, 1750
Reload

Return
 
; Removes any popped up tray tips.
RemoveTrayTip:
	SetTimer, RemoveTrayTip, Off 
	TrayTip 
Return 
 
#If

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

^!h::
; Ctrl+Alt+h - Show Help (the Readme file)
FileRead, Readme, %A_ScriptDir%\Readme.md
Gui, Add, Text,, %Readme%
Gui, Show
Return

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

^!l::
; Ctrl+Alt+L - Length of Highlighted
; Save off old clipboard and empty it.
saveClipboard := Clipboard
Clipboard := ""
Sleep, 250

; Copy highlighted message to clipboard.  Count the characters and spaces.
; 12345 6789
Send, ^c
ClipWait, 2
Chars := StrLen(Clipboard)
RegExReplace(Clipboard,A_Space,"",Spaces)

MsgBox,, Character Count, The highlighted text is %Chars% characters in length and contains %Spaces% spaces.
Sleep, 250

; Put old contents of clipboard back into clipboard
Clipboard := saveClipboard
return

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

^SPACE::Winset, Alwaysontop, , A
;Ctrl+Space - Sets active window to always on top.  Toggles On/Off

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

^!d::
;Ctrl+Alt+D - Takes the clipboard, makes a DTS link out of it, and sends it back

;Find where the two spaces are in the DTS shorthand.  Eg. CS BAR 1337
;platformPos should return 3.  The 3rd position.
;appPos should return 7.  The 7th position.

platformPos := InStr(clipboard, " ") ; Find the first occurance of space
appPos := InStr(clipboard, " ", , , 2) ; Find the second occurance of space

platform := SubStr(clipboard, 1, platformPos - 1) ; Get the platform
app := SubStr(clipboard, platformPos + 1, (appPos - platformPos) - 1) ; Get the Application
DTS := SubStr(clipboard, appPos + 1) ; Get the DTS number

Send, http://magicweb/dts/REQUESTS/%platform%/%app%/%DTS%.htm
Sleep, 500
Send, {enter}

return

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

^!f::
;Ctrl+Alt+F - Takes the clipboard, makes a DTS shorthand out of it, and sends it back

;Find where the two spaces are in the DTS link.  Eg. http://magicweb/dts/REQUESTS/CS/BAR/1337.htm
;platformPos should return 29.  The 29th position.
;appPos should return 32.  The 32nd position.

platformPos := InStr(clipboard, "/", , , 5) ; Get the 5th occurance of /
appPos := InStr(clipboard, "/", , , 6) ; Get the 6th occurance of /
DTSPos := InStr(clipboard, "/", , , 7) ; Get the 7th occurance of /
EndPos := InStr(clipboard, ".htm") ; Get the 1st occurance of .htm

platform := SubStr(clipboard, platformPos + 1, appPos - platformPos - 1) ; Get the platform
app := SubStr(clipboard, appPos + 1, DTSPos - appPos - 1) ; Get the Application
DTS := SubStr(clipboard, DTSPos + 1, EndPos - DTSPos - 1) ; Get the DTS number

Send, %platform% %app% %DTS%
Sleep, 500
Send, {enter}

return

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////


^!j::
;Ctrl+Alt+J - Takes the clipboard, makes a jira link out of it, and sends it back

Send, https://jira.meditech.com/browse/%clipboard%
Sleep, 500
Send, {enter}

return

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

^!p::
;Ctrl+Alt+P - Parse Cursible review code for pasting

clipboard = %clipboard%  ; Trim left and right whitespaces

loop parse, clipboard, `n, `r  ; `n before `r allows cross-platform parsing
{
	CurrentLine = %A_LoopField% ; Grab current looped line
	CurrentLine := SubStr(CurrentLine, RegExMatch(CurrentLine, "\s") + 1)  ; Remove all to left of first whitespace
	If AllLines is not space ; If this isn't the first run of the loop, concatinate all the previous lines, AllLines with CurrentLine
		AllLines = %AllLines%`r`n%CurrentLine% ; `r before `n allows pasting into NPR correctly, I believe this means not return and not newline.
	Else
		AllLines = %CurrentLine%
}	

clipboard = %AllLines%

;Cleanup
CurrentLine := ""
AllLines := ""

Return

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

^!b::
;Ctrl+Alt+H - Remove "Attribute|" code for pasting

clipboard = %clipboard%  ; Trim left and right whitespaces

loop parse, clipboard, `n, `r  ; `n before `r allows cross-platform parsing
{
	CurrentLine = %A_LoopField% ; Grab current looped line
	CurrentLine := SubStr(CurrentLine, 11)  ; Remove Attribute|
	If AllLines is not space ; If this isn't the first run of the loop, concatinate all the previous lines, AllLines with CurrentLine
		AllLines = %AllLines%`r`n%CurrentLine% ; `r before `n allows pasting into NPR correctly, I believe this means not return and not newline.
	Else
		AllLines = %CurrentLine%
}	

clipboard = %AllLines%

;Cleanup
CurrentLine := ""
AllLines := ""

Return
