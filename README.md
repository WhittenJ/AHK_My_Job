# AHK-for-MEDITECH
A collection of AHK scripts for use at MEDITECH

## CS Specific (Must have CS NPR as active Window)
- `F11` - Replaces F11 with Esc.  This disables accidentally loading EMR.
- `Ctrl + Alt + G` - Automatically pastes in screen code copied from Eclipse.  Removes the Field| and Attribute|.  Puts the code directly into the E/E Screen routine on the Field Page.
- `Ctrl + Alt + U` - Unlocks a routine from the front end.

## Eclipse Specific (Must have Eclipse as active Window)
- `Ctrl + Alt + Q` - CGS 3M Field Macro Creator for batch layout routine.  Copy Field Name, POS, and LEN from Excel file or Table in the JIRA.
- `Ctrl + Shift + P` - Increase Field Length of CGS 3M Grouper Software Update.  *** WARNING: REMEMBER TO EDIT THIS SCRIPT TO THE CORRECT ADJUSTMENT LENGTH ***

## MG Specific (Must have 3.x or 4.x Workstation as active Window, disabled for DTS)
- `Mouse Wheel Down` - Scrolls window Down
- `Mouse Wheel Up` - Scrolls window up
- `Ctrl + C` - Copy
- `Ctrl + V` - Paste
- `Ctrl + Alt + O` - Paste.  Automatically splits lines that are too long for MG and merges them.  *** WARNING: DOES NOT ALWAYS WORK RIGHT ***  It cannot account for indenting and it can only split a single line once.
- `Ctrl + Alt + S` - Log into S5.6.7.MIS (It types AI, S5.6.7.MIS, FE after you hit connect)
- `Ctrl + Alt + T` - Log into T5.6.7.MIS (same, but for T)
- `Ctrl + Alt + G` - Automatically pastes in screen code copied from Eclipse.  Removes the Field| and Attribute|.  Puts the code directly into the E/E Screen routine on the Field Page.
- `Ctrl + Alt + U` - Unlocks a routine from the front end.
- `Ctrl + Alt + Q` - CGS 3M Field Macro Creator for batch layout routine.  Copy Field Name, POS, and LEN from Excel file or Table in the JIRA.
- `Ctrl + Shift + P` - Increase Field Length of CGS 3M Grouper Software Update.  *** WARNING: REMEMBER TO EDIT THIS SCRIPT TO THE CORRECT ADJUSTMENT LENGTH ***

## M-AT Specific (Must have TextPad.exe as active Window)
- `Ctrl + Alt + T` - Automatically creates an MAT Screen Template.
- `Ctrl + Alt + I` - Automatically creates an MAT Lookup Template.

## Generic Macros
- `Ctrl + S` - Save and reload Script.  Only works in Notepad++.
- `Ctrl + R` - Reload Script.  Only works in Notepad++.
- `Ctrl + Alt + H` - Display this help.
- `Ctrl + Alt + L` - Shows length and number of spaces of the highlighted text.
- `Ctrl + Space` - Sets active window to always on top.
- `Ctrl + Alt + D` - Takes a copied DTS number and turns it into a DTS Website link.  Eg. CS BAR 666 turns into http://magicweb/dts/REQUESTS/CS/BAR/666.htm
- `Ctrl + Alt + F` - Takes DTS Website Link, turns it into DTS number.
- `Ctrl + Alt + J` - Takes a JIRA number and turns it into a JIRA URL.
- `Ctrl + Alt + P` - Parses Crucible review for pasting.  Removes all the garbage from a crucible review, so you can easily paste it.
- `Ctrl + Alt + B` - Removes Attribute| code when you copy screen code from Eclipse.  Allows you to paste it later into MG or CC.
