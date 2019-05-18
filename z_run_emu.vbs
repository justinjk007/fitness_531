rem Run Andriod emulator for windows
Set objShell = WScript.CreateObject("WScript.Shell")
objShell.Run "C:\Users\Justin\AppData\Local\Android\sdk\emulator\emulator.exe -avd Pixel_2_API_27", 0, True
