#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

; Table of Contents:
; 1. F8 (VS Code Only) - Add Debugger

#If (WinActive("ahk_class Chrome_WidgetWin_1") && WinActive("ahk_exe Code.exe"))

F8::
SendRaw, `%Z.debug("ddc","JWHITTEN-L"),
Return

#If
