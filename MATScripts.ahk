#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

; Table of Contents:
; 1. Ctrl+Alt+t - MAT Screen Template
; 2. Ctrl+Alt+i - MAT Lookup Template
; 3. GUI Code to support screens:
;   i. Cancel Button Code
;  ii. Screen Template Submit Code
; iii. Lookup Template Create Code

#If (WinActive("ahk_class TextPad8") && WinActive("ahk_exe TextPad.exe"))

^!t::
;Ctrl+Alt+T - Screen template

Gui, Add, Text,, Object?
Gui, Add, Edit, vObject
Gui, Add, Text,, Screen Title?
Gui, Add, Edit, vTitle
Gui, Add, Text,, First Index (eg, MnemonicX):
Gui, Add, Edit, vIndex
Gui, Add, CheckBox, vOnEntry, On Entry/Setup Macro?
Gui, Add, CheckBox, vHeader, Header?
Gui, Add, CheckBox, vFooter, Footer Buttons?
Gui, Add, CheckBox, vPageSet, External PageSet?
Gui, Add, Button, gScreen wp-50,Create
Gui, Add, Button, gCancel wp-50,Cancel
Gui, Show, Center, MAT Screen Template Creator
Return

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

^!i::
;Ctrl+Alt+i - ID template

;Gui, New,, MAT ID Template Creator
Gui, Add, Text,, Object?
Gui, Add, Edit, x+m yp vObject
Gui, Add, Text, xm, Lookup Title?
Gui, Add, Edit, x+m yp vTitle
Gui, Add, Text, xm, Index to Use (eg, MnemonicX):
Gui, Add, Edit, x+m yp vIndex
Gui, Add, Text, xm, Initial Method (eg, Mnemonic):
Gui, Add, Edit, x+m yp vMethod1
Gui, Add, Text, xm, Second Method (eg, Name):
Gui, Add, Edit, x+m yp vMethod2

Gui, Add, Text, xm Section, Label 1:
Gui, Add, Edit, ys vLabel1
Gui, Add, Text, xs, Value 1:
Gui, Add, Edit, x+m yp vValue1
Gui, Add, Text, xs, ----------------------------------------------------------

Gui, Add, Text, ys Section, Label 2:
Gui, Add, Edit, ys vLabel2
Gui, Add, Text, xs, Value 2:
Gui, Add, Edit, x+m yp vValue2
Gui, Add, Text, xs, ----------------------------------------------------------

Gui, Add, Text, xm Section, Label 3:
Gui, Add, Edit, ys vLabel3
Gui, Add, Text, xs, Value 3:
Gui, Add, Edit, x+m yp vValue3

Gui, Add, Text, ys Section, Label 4:
Gui, Add, Edit, ys vLabel4
Gui, Add, Text, xs, Value 4:
Gui, Add, Edit, x+m yp vValue4

Gui, Add, Button, gId xm Section,C&reate
Gui, Add, Button, ys gCancel,&Cancel
Gui, Show,, MAT ID Template Creator
Return

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

Cancel:
Gui,Destroy
return

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

Screen:
Gui,Submit
	Sleep, 500
	Send, {Raw}//$Header: $
	Send, {enter 2}
	Send, //:Doc Purpose{enter}
	Send, //     Purpose of this screen{enter 2}
	Send, //-------------------------------------------------------------------{enter}
	Send, {Raw}#Translation
	Send, {enter}
	Send, :Options {enter}
	Send, Result MSFile {enter}
	Send, :Product {enter}
	Send, Type Screen {enter}
	Send, {enter}
	Sleep, 250
	Send, //-------------------------------------------------------------------{enter}
	Send, {Raw}#Preamble
	Send, {enter}
	Send, :Options {enter}
	Send, Type Process {enter}
	Send, :Window {enter}
	Send, Title "%Title%"
	Send, {enter 2}
	Sleep, 250
	Send, //-------------------------------------------------------------------{enter}
	Send, {Raw}#Screen
	Send, {enter 2}
	Send, :Object{enter}
	Send, Class %Object%{enter}
	Send, Repeat Yes{enter}
	Send, :Session{enter}
	Send, OnEntry{space}
	If(OnEntry == 1)
		{
		Send, {Raw}@CallSub(Setup)
		}
	Else
		{
		Send, {Raw}"Main"@SetCurrentFooter()
		}
	Send, {enter 2}
	Sleep, 250
	Send, //-------------------------------------------------------------------{enter}
	Send, {Raw}#ImportExport
	Send, {enter}
	Send, :Object {enter}
	Send, Class %Object% {enter}
	Send, :Mutex{enter}
	Send, Name %Object%.Object {enter}
	Send, Intent ForUI {enter}
	Send, :Import {enter}
	Send, File %Object%.MasterFile {enter}
	Send, :Export {enter}
	Send, Index %Object%.%Index% {enter 2}
	Sleep, 250
	If(Header == 1)
	{
	Send, //-------------------------------------------------------------------{enter}
	Send, {Raw}#Header
	Send, {enter}
	Send, :Row {enter}
	Send, :Blank {enter 2}
	Send, :Row {enter}
	Send, :Element {enter}
	Send, Value {space}
	Send, {Raw}@CallSub(HeaderValue1)
	Send, {enter}
	Send, ValueStyle "FontSmallBold" {enter 2}
	Send, :Row {enter}
	Send, :Blank {enter 2}
	Sleep, 250
	}
	Send, //-------------------------------------------------------------------{enter}
	Send, {Raw}#Menu
	Send, {enter}
	Send, :Button {enter}
	Send, Label "View" {enter}
	Send, Function Action {enter}
	Send, Group ViewMode {enter}
	Send, Name View {enter}
	Send, HotKey "V" {enter}
	Send, Logic {space}
	Send, {Raw}@CallSub(EventClickView)
	Send, {enter}
	Send, Condition {space}
	Send, {Raw}@CallSub(ConditionView)
	Send, {enter 2}
	Sleep, 250
	Send, :Blank {enter 2}
	Send, :Button {enter}
	Send, Label "New" {enter}
	Send, Function Action {enter}
	Send, Group ViewMode {enter}
	Send, Name New {enter}
	Send, HotKey "N" {enter}
	Send, Logic {space}
	Send, {Raw}@CallSub(EventClickNew)
	Send, {enter}
	Send, Condition {space}
	Send, {Raw}@CallSub(ConditionNew)
	Send, {enter 2}
	Sleep, 250
	Send, :Button {enter}
	Send, Label "Edit" {enter}
	Send, Function Action {enter}
	Send, Group ViewMode {enter}
	Send, Name Edit {enter}
	Send, HotKey "E" {enter}
	Send, Logic {space}
	Send, {Raw}@CallSub(EventClickEdit)
	Send, {enter}
	Send, Condition {space}
	Send, {Raw}@CallSub(ConditionEdit)
	Send, {enter 2}
	Sleep, 250
	If(Footer == 1)
	{
	Send, //-------------------------------------------------------------------{enter}
	Send, {Raw}#Footer
	Send, {enter}
	Send, :Footer Main{enter}
	Send, :Button {enter}
	Send, Label "Cancel" {enter}
	Send, Function Action {enter}
	Send, Region Right {enter}
	Send, Shortcut Esc {enter}
	Send, Condition {space}
	Send, {Raw}@CallSub(ConditionalCancel)
	Send, {enter}
	Send, Logic {space}
	Send, {Raw}@CallSub(EventCancel)
	Send, {enter 2}
	Sleep, 250
	Send, :Button {enter}
	Send, Label "Save" {enter}
	Send, Function Action {enter}
	Send, Region Right {enter}
	Send, Shortcut F12 {enter}
	Send, Condition {space}
	Send, {Raw}@CallSub(ConditionalSave)
	Send, {enter}
	Send, Logic {space}
	Send, {Raw}@CallSub(EventSave)
	Send, {enter}
	Send, ShowCondition {space}
	Send, {Raw}@CallSub(ShowConditionSave)
	Send, {enter 2}
	Sleep, 250
	Send, {Raw}// Following Buttons are to support @CallScreen functions
	Send, {enter}
	Send, :Button {enter}
	Send, Label "Not Used" {enter}
	Send, Function NewObject {enter}
	Send, ShowCondition "" {enter 2}
	Send, :Button {enter}
	Send, Label "Not Used" {enter}
	Send, Function Save {enter}
	Send, ShowCondition "" {enter 2}
	Send, :Button {enter}
	Send, Label "Not Used" {enter}
	Send, {Raw}Function Cancel
	Send, {enter}
	Send, ShowCondition "" {enter 2}
	Sleep, 250
	}
	If(PageSet == 1)
	{
	Send, //-------------------------------------------------------------------{enter}
	Send, {Raw}#ScreenPage
	Send, {enter}
	Send, :ExternalPageSet {enter}
	Send, CodeBase Test {enter}
	Send, Source %Object%.Ee.E {enter}
	Send, PageName ViewPage {enter}
	Send, PageName EditPage {enter}
	Send, PageName NewPage {enter}
	Send, {enter}
	}
	Send, //-------------------------------------------------------------------{enter}
	Send, {Raw}#Locals
	Send, {enter}
	Send, :Name CurrentFunction
	Send, {enter 2}
	Sleep, 250
	Send, //-------------------------------------------------------------------{enter}
	Send, {Raw}#Magic
	Send, {enter 2}
	If(OnEntry == 1)
	{
	Send, //------------------------------------------------------{enter}
	Send, :Code Setup {enter}
	Send, {Raw}"Edit"@PutLocal(CurrentFunction),
	Send, {enter}
	Send, {Raw}"I"@SetMenuButtonState(Edit),
	Send, {enter}
	Send, {Raw}"EditPage"@GotoPage(),
	Send, {enter}
	Send, {Raw}"Main"@SetCurrentFooter();
	Send, {enter 2}
	Sleep, 250
	}
	Send, //------------------------------------------------------{enter}
	Send, :Code EventClickView {enter}
	Send, //:Doc Purpose {enter}
	Send, //     When the View button was clicked, runs logic to test if change is needed {enter}
	Send, // {enter}
	Send, //:Doc Local Variables {enter}
	Send, //     Current - Current page function value {enter}
	Send, // {enter}
	Send, var: Current {enter}
	Send, {Raw}IF{@GetLocal(CurrentFunction)^Current="View";
	Send, {enter}
	Send, {Raw}IF{Current="New" @CallSub(Cancel)},
	Send, {enter}
	Send, {Raw}"View"@PutLocal(CurrentFunction),
	Send, {enter}
	Send, {Raw}"ViewPage"@GotoPage(),
	Send, {enter}
	Send, {Raw}"Main"@SetCurrentFooter()};
	Send, {enter 2}
	Sleep, 250
	Send, //------------------------------------------------------{enter}
	Send, :Code ConditionView {enter}
	Send, //:Doc Purpose {enter}
	Send, //     Verifying if the View button should be visible {enter}
	Send, // {enter}
	Send, //:Doc Returns {enter}
	Send, //     Returns Nil and Non-Nil for condition {enter}
	Send, // {enter}
	Send, {Raw}IF{@GetLocal(CurrentFunction)="View";
	Send, {enter}
	Send, {Raw}@GetCurrentRID(
	Send, %Object%.Main
	Send, {Raw})@GetField(
	Send, %Object%.Mnemonic
	Send, {Raw})@NV};
	Send, {enter 2}
	Sleep, 250
	Send, //------------------------------------------------------{enter}
	Send, :Code EventClickNew {enter}
	Send, //:Doc Purpose {enter}
	Send, //     When the New button was clicked, runs the logic to test if change is needed {enter}
	Send, // {enter}
	Send, {Raw}IF{@GetLocal(CurrentFunction)="New";
	Send, {enter}
	Send, {Raw}"New"@PutLocal(CurrentFunction),
	Send, {enter}
	Send, {Raw}@CallScreenNewObjectLogic(),
	Send, {enter}
	Send, {Raw}"NewPage"@GotoPage(),
	Send, {enter}
	Send, {Raw}"Main"@SetCurrentFooter()};
	Send, {enter 2}
	Sleep, 250
	Send, //------------------------------------------------------{enter}
	Send, :Code ConditionNew {enter}
	Send, //:Doc Purpose {enter}
	Send, //     Verifying if the New button should be visible {enter}
	Send, // {enter}
	Send, //:Doc Returns {enter}
	Send, //     Returns Nil and Non-Nil for condition {enter}
	Send, // {enter}
	Send, {Raw}IF{@GetLocal(CurrentFunction)="New";
	Send, {enter}
	Send, {Raw}@GetCurrentRID(
	Send, %Object%.Main
	Send, {Raw})@GetField(
	Send, %Object%.Mnemonic
	Send, {Raw})@NV};
	Send, {enter 2}
	Sleep, 250
	Send, //------------------------------------------------------{enter}
	Send, :Code EventClickEdit {enter}
	Send, //:Doc Purpose {enter}
	Send, //     When the Edit button was clicked, runs the logic to test if change is needed {enter}
	Send, // {enter}
	Send, //:Doc Local Variables {enter}
	Send, //     Current - Current page function value {enter}
	Send, // {enter}
	Send, var: Current {enter}
	Send, {Raw}IF{@GetLocal(CurrentFunction)^Current="Edit";
	Send, {enter}
	Send, {Raw}IF{Current="New" @CallSub(Cancel);
	Send, {enter}
	Send, {Raw}Current="View" @CallSub(Reimport)},
	Send, {enter}
	Send, {Raw}"Edit"@PutLocal(CurrentFunction),
	Send, {enter}
	Send, {Raw}"EditPage"@GotoPage(),
	Send, {enter}
	Send, {Raw}"Main"@SetCurrentFooter()};
	Send, {enter 2}
	Sleep, 250
	Send, //------------------------------------------------------{enter}
	Send, :Code ConditionEdit {enter}
	Send, //:Doc Purpose {enter}
	Send, //     Verifying if the Edit button should be visible {enter}
	Send, // {enter}
	Send, //:Doc Local Variables {enter}
	Send, //     Current - Current page function value {enter}
	Send, // {enter}
	Send, //:Doc Returns {enter}
	Send, //     Returns Nil and Non-Nil for condition {enter}
	Send, // {enter}
	Send, var: Current {enter}
	Send, {Raw}IF{@GetLocal(CurrentFunction)^Current="Edit";
	Send, {enter}
	Send, {Raw}Current="View";
	Send, {enter}
	Send, {Raw}@GetCurrentRID(
	Send, %Object%
	Send, {Raw}.Main)@GetField(
	Send, %Object%
	Send, {Raw}.Mnemonic)@NV};
	Send, {enter 2}
	Sleep, 250
	Send, //------------------------------------------------------{enter}
	Send, {Raw}:Code EventCancel
	Send, {enter}
	Send, {Raw}@CallSub(Cancel)
	Send, {enter}
	Send, {Raw}@CallSub(Setup);
	Send, {enter 2}
	Sleep, 250
	Send, //------------------------------------------------------{enter}
	Send, {Raw}:Code Cancel
	Send, {enter}
	Send, //:Doc Purpose {enter}
	Send, {Raw}//     Cancel current viewing and repopulate the control field
	Send, {enter}
	Send, // {enter}
	Send, {Raw}@CallScreenCancelLogic(){{0},""}@PutField(t!
	Send, %Object%
	Send, {Raw}.oid);
	Send, {enter 2}
	Sleep, 250
	Send, //------------------------------------------------------{enter}
	Send, :Code Reimport {enter}
	Send, {Raw};
	Send, {enter 2}
	Sleep, 250
	Send, //------------------------------------------------------{enter}
	Send, :Code ShowConditionSave {enter}
	Send, //:Doc Purpose {enter}
	Send, //     Compiles if the save button should be shown {enter}
	Send, // {enter}
	Send, {Raw}IF{@GetLocal(CurrentFunction)@{="New",="Edit"}@! 1};
	Send, {enter 2}
	Sleep, 250
	Send, //------------------------------------------------------{enter}
	Send, :Code ConditionalSave {enter}
	Send, //:Doc Purpose {enter}
	Send, //     Compiles if the save button should be clickable {enter}
	Send, // {enter}
	Send, {Raw}IF{@GetLocal(CurrentFunction)
	Send, {enter}
	Send, {Raw}@{="New",="Edit"}@! {@GetCurrentOID(
	Send, %Object%
	Send, {Raw})}@GetField(
	Send, %Object%
	Send, {Raw}.Mnemonic)};
	Send, {enter 2}
	Sleep, 250
	Send, //------------------------------------------------------{enter}
	Send, :Code ConditionalCancel {enter}
	Send, //:Doc Purpose {enter}
	Send, {Raw}//     Compiles if the Cancel button should be clickable
	Send, {enter}
	Send, // {enter}
	Send, {Raw}IF{@GetLocal(CurrentFunction)
	Send, {enter}
	Send, {Raw}@{="New",="Edit",="View"}@! {@GetCurrentOID(
	Send, %Object%
	Send, {Raw})}@GetField(
	Send, %Object%
	Send, {Raw}.Mnemonic)};
	Send, {enter 2}
	Sleep, 250
	Send, //------------------------------------------------------{enter}
	Send, :Code HeaderValue1 {enter}
	Send, {Raw}@GetCurrentRID(
	Send, %Object%
	Send, {Raw}.Main)@{@GetField(
	Send, %Object%
	Send, {Raw}.Mnemonic)," - ",@GetField(
	Send, %Object%
	Send, {Raw}.Name)}@CA;
	Send, {enter 2}
	Sleep, 250
	Send, //------------------------------------------------------{enter}
	Send, :Code EventSave {enter}
	Send, {Raw}@CallScreenSaveLogic()
	Send, {enter}
	Send, {Raw}@CallSub(Setup);
	Send, {enter}
	Sleep, 250
	Send, ^{s}
	Sleep, 1000
	Send, ^{2}

Gui, Destroy
return

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

Id:
Gui, Submit
Sleep, 500
	Send, {Raw}//$Header: $
	Send, {enter 2}
	Send, //:Doc Purpose{enter}
	Send, //     Purpose of this Lookup{enter 2}
	Send, //-------------------------------------------------------------------{enter}
	Send, {Raw}#Translation
	Send, {enter}
	Send, :Options {enter}
	Send, Result MSFile {enter}
	Send, :Product {enter}
	Send, Type Lookup {enter}
	Send, {enter}
	Sleep, 250
	Send, //-------------------------------------------------------------------{enter}
	Send, {Raw}#Preamble
	Send, {enter}
	Send, :Options {enter}
	Send, Type Program {enter}
	Send, :Window {enter}
	Send, Title "%Title%"
	Send, {enter 2}
	Sleep, 250
	Send, //-------------------------------------------------------------------{enter}
	Send, {Raw}#Search
	Send, {enter}
	Send, :Search {enter}
	Send, Object %Object% {enter}
	Send, OnEntry {space}
	Send, {Raw}@CallSub(Setup)
	Send, {enter}
	Send, InitialMethod {space}
	Send, {Raw}@GetLocal(InitMethod)
	Send, {enter 2}
	Sleep, 100
	Send, //------------------------------------------------------{enter}
	Send, :Button {enter}
	Send, Label "By %Method1%" {enter}
	Send, Method "By%Method1%" {enter}
	Send, StartDownCondition {space}
	Send, {Raw}@GetLocal(InitMethod)=
	Send, "By%Method1%" {enter}
	Send, Group Methods {enter}
	Send, :Button {enter}
	Send, Label "By %Method2%" {enter}
	Send, Method "By%Method2%" {enter}
	Send, StartDownCondition {space}
	Send, {Raw}@GetLocal(InitMethod)=
	Send, "By%Method2%" {enter}
	Send, Group Methods {enter}
	Send, {enter}
	Sleep, 100
	Send, //------------------------------------------------------{enter}
	Send, :Method By%Method1% {enter}
	Send, Index %Object%.%Index% {enter}
	Send, OnSeedChange {space}
	Send, {Raw}@GetSearchSeed()@{{0},}@PutField(q!
	Send, %Object%
	Send, {Raw}.Mnemonic)
	Send, {enter}
	Send, :IndexKey {enter}
	Send, Name %Object%.%Index%.%Method1% {enter}
	Send, Match "startswith" {enter}
	Sleep, 100
	Send, :Column {enter}
	Send, Label "%Label1%" {enter}
	Send, Value {space}
	Send, {Raw}@GetField(a!
	Send, %Object%
	Send, .%Value1%
	Send, {Raw})
	Send, {enter}
	Sleep, 100
	Send, :Column {enter}
	Send, Label "%Label2%" {enter}
	Send, Value {space}
	Send, {Raw}@GetField(a!
	Send, %Object%
	Send, .%Value2%
	Send, {Raw})
	Send, {enter}
	If(Label3)
	{
	Sleep, 100
	Send, :Column {enter}
	Send, Label "%Label3%" {enter}
	Send, Value {space}
	Send, {Raw}@GetField(a!
	Send, %Object%
	Send, .%Value3%
	Send, {Raw})
	Send, {enter}
	}
	If(Label4)
	{
	Sleep, 100
	Send, :Column {enter}
	Send, Label "%Label4%" {enter}
	Send, Value {space}
	Send, {Raw}@GetField(a!
	Send, %Object%
	Send, .%Value4%
	Send, {Raw})
	Send, {enter}
	}
	Sleep, 100
	Send, //------------------------------------------------------{enter}
	Send, :Method By%Method2% {enter}
	Send, Index %Object%.%Index% {enter}
	Send, OnSeedChange {space}
	Send, {Raw}@GetSearchSeed()@{{0},}@PutField(q!
	Send, %Object%
	Send, {Raw}.Mnemonic)
	Send, {enter}
	Send, :IndexKey {enter}
	Send, Name %Object%.%Index%.%Method2% {enter}
	Send, Match "startswith" {enter}
	Sleep, 100
	Send, :Column {enter}
	Send, Label "%Label2%" {enter}
	Send, Value {space}
	Send, {Raw}@GetField(a!
	Send, %Object%
	Send, .%Value2%
	Send, {Raw})
	Send, {enter}
	Sleep, 100
	Send, :Column {enter}
	Send, Label "%Label1%" {enter}
	Send, Value {space}
	Send, {Raw}@GetField(a!
	Send, %Object%
	Send, .%Value1%
	Send, {Raw})
	Send, {enter}
	If(Label3)
	{
	Sleep, 100
	Send, :Column {enter}
	Send, Label "%Label3%" {enter}
	Send, Value {space}
	Send, {Raw}@GetField(a!
	Send, %Object%
	Send, .%Value3%
	Send, {Raw})
	Send, {enter}
	}
	If(Label4)
	{
	Sleep, 100
	Send, :Column {enter}
	Send, Label "%Label4%" {enter}
	Send, Value {space}
	Send, {Raw}@GetField(a!
	Send, %Object%
	Send, .%Value4%
	Send, {Raw})
	Send, {enter 2}
	}
	Sleep, 250
	Send, //-------------------------------------------------------------------{enter}
	Send, {Raw}#Locals
	Send, {enter 2}
	Send, :Name InitMethod {enter 2}
	Sleep, 250
	Send, //-------------------------------------------------------------------{enter}
	Send, {Raw}#Magic
	Send, {enter}
	Send, :Code Setup {enter}
	Send, //:Doc Purpose {enter}
	Send, //     Configure the q! fields and locals needed to run the inital lookup {enter}
	Send, // {enter}
	Send, //:Doc Local Variables {enter}
	Send, //     InitMethod: The Focus Local which stores the Initial Lookup Method {enter}
	Send, // {enter}
	Send, {Raw}{0}@GetField(q!
	Send, %Object%
	Send, .%Value1%
	Send, {Raw})
	Send, {enter} // {enter}
	Send, {Raw}{0}@IF{@GetField(q!
	Send, %Object%
	Send, .%Value2%
	Send, {Raw})
	Send, {space}"By%Method2%"
	Send, {Raw};
	Send, {enter} "By%Method1%"
	Send, {Raw}}@PutLocal(InitMethod);
	Sleep, 250
	Send, ^{s}
	Sleep, 1000
	Send, ^{2}
	
Gui, Destroy
return

#If
