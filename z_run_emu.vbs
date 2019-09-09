Set objShell = WScript.CreateObject("WScript.Shell")

rem This emulator is for home PC
intReturn = objShell.Run("C:\Users\%USERNAME%\AppData\Local\Android\sdk\emulator\emulator.exe -avd Pixel_2_API_27", 0, true)
If intReturn <> 0 Then
   rem This emulator is for school PC
   intReturn = objShell.Run("C:\Users\%USERNAME%\AppData\Local\Android\sdk\emulator\emulator.exe -avd Pixel_3_API_26", 0, true)
End If