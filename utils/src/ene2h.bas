' ene2h.bas v0.1.20171003

Sub usage
	Print "$ ene2h.exe enems.ene enems.h [2bytes]"
	Print
	Print "The 2bytes parameter is for really old .ene files which"
	Print "stored the hotspots 2 bytes each instead of 3 bytes."
	Print "As a rule of thumb:"
	Print ".ene file created with ponedor.exe -> 3 bytes."
	Print ".ene file created with colocador.exe for MK1 -> 2 bytes."
End Sub

Dim As Integer use2bytes
Dim As Integer fIn, fOut, i, j, mapPants
Dim As uByte d, mapW, mapH, nEnems
Dim As uByte t, a, b, xx, yy, mn, x, y, s1, s2, xy
Dim As Integer typeCounters (255)
Dim As Integer enTypeCounters (255)
Dim As String Dummy

If Command (2) = "" Then usage: End

For i = 0 To 255
	enTypeCounters (i) = 0
	typecounters (i) = 0
Next i

use2bytes = (Command (3) = "2bytes")

fIn = FreeFile
Open Command (1) For Binary As #fIn
fOut = FreeFile
Open Command (2) For Output As #fOut

' Header
dummy = Input (256, fIn)
Get #fIn, , d: mapW = d
Get #fIn, , d: mapH = d
Get #fIn, , d: Get #fIn, , d
Get #fIn, , d: nEnems = d

mapPants = mapW * mapH

Print #fOut, "// MTE MK1 (la Churrera) v5.0"
Print #fOut, "// Copyleft 2010-2014, 2020 by the Mojon Twins"
Print #fOut, ""

Print #fOut, "// Generated by ene2h.exe from " & Command (1)
Print #fOut, "// Copyleft 2010, 2017 by The Mojon Twins"
Print #fOut, ""

Print #fOut, "typedef struct {"
Print #fOut, "	unsigned char x, y;"
Print #fOut, "	unsigned char x1, y1, x2, y2;"
Print #fOut, "	signed char mx, my;"
Print #fOut, "	signed char t;"
Print #fOut, "#ifdef PLAYER_CAN_FIRE"
Print #fOut, "	unsigned char life;"
Print #fOut, "#endif"
Print #fOut, "} MALOTE;"
Print #fOut, ""
Print #fOut, "MALOTE malotes [] = {"

For i = 1 To mapPants
	Print #fOut, "	// Pantalla " & (i-1)
	For j = 1 To nEnems
		Get #fIn, , t
		Get #fIn, , x
		Get #fIn, , y
		Get #fIn, , xx
		Get #fIn, , yy 
		Get #fIn, , mn
		Get #fIn, , s1
		Get #fIn, , s2

		enTypeCounters (t) = enTypeCounters (t) + 1

		Print #fOut, " 	{";
		Print #fOut, "" & (16*x) & ", " & (16*y) & ", ";		' x y
		Print #fOut, "" & (16*x) & ", " & (16*y) & ", ";		' x1 y1
		Print #fOut, "" & (16*xx) & ", " & (16*yy) & ", ";		' x2 y2
		Print #fOut, "" & (mn * Sgn (xx - x)) &  ", "; 		' mx
		Print #fOut, "" & (mn * Sgn (yy - y)) & ", "; 		' my
		Print #fOut, "" & t; 								' t
		Print #fOut, "}";

		If i < mapPants Or j < nEnems Then Print #fOut, "," Else Print #fOut, ""
	Next j
	Print #fOut, ""
Next i

Print #fOut, "};"
Print #fOut, ""

For i = 0 To 255
	If (enTypeCounters (i) > 0 Or i <= 7) And i <> 4 Then
		Print #fOut, "#define N_ENEMS_TYPE_" & i & " " & enTypeCounters (i)
	End If
Next i

Print #fOut, ""
Print #fOut, "// This is output the way it worked originally, please modify if you need"
Print #fOut, "// You may want to add type 5 or 6's below."
Print #fOut, "#define BADDIES_COUNT (N_ENEMS_TYPE_1+N_ENEMS_TYPE_2+N_ENEMS_TYPE_3)"

Print #fOut, ""
Print #fOut, "typedef struct {"
Print #fOut, "	unsigned char xy, tipo, act;"
Print #fOut, "} HOTSPOT;"
Print #fOut, ""
Print #fOut, "HOTSPOT hotspots [] = {"

For i = 1 To mapPants
	If use2bytes Then
		Get #fIn, , xy
		Get #fIn, , t
	Else
		Get #fIn, , x
		Get #fIn, , y
		Get #fIn, , t
		xy = (x Shl 4) Or (y And 15)
	End If

	typeCounters (t) = typeCounters (t) + 1

	Print #fOut, "	{";
	Print #fOut, xy; ", "; t; ", 0";
	Print #fOut, "}";

	If i < mapPants Then Print #fOut, ", " Else Print #fOut, ""
Next i

Print #fOut, "};"
Print #fOut, ""

For i = 0 To 255
	If typeCounters (i) <> 0 Or i < 8 Then
		Print #fOut, "#define N_HOTSPOTS_TYPE_" & i & " " & typeCounters (i)
	End If
Next i

Print #fOut, ""

Close
