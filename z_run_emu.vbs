rem Run Andriod emulator for windows
Set objShell = WScript.CreateObject("WScript.Shell")

rem This is for home pc
intReturn = objShell.Run "C:\Users\%USERNAME%\AppData\Local\Android\sdk\emulator\emulator.exe -avd Pixel_2_API_27", 0, True

rem This is for school laptop
If intReturn <> 0 Then
   rem That emulator doesn't exist try another
   intReturn = objShell.Run "C:\Users\%USERNAME%\AppData\Local\Android\sdk\emulator\emulator.exe -avd Pixel_3_API_26", 0, True
End If