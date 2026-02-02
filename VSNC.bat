@echo off
setlocal EnableDelayedExpansion

:: Initialization
reg add "HKCU\Console" /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

chcp 65001 >nul
title VSNC v1.2
mode con: cols=85 lines=30

:: Chat directory for txt file
set "CHAT=C:\Temp"

:: txt file name
set "CHATFILE=%CHAT%\chat.txt"
if not exist "%CHAT%" mkdir "%CHAT%"

:: Date/time variable
set "TS=%DATE%-%TIME:~0,5%"

:: Header and branding
echo.
echo %ESC%[38;5;214m                              _   __ _____  _   __ ______
echo %ESC%[38;5;208m                             ^| ^| / // ___/ / ^| / // ____/
echo %ESC%[38;5;202m                             ^| ^|/ / \__ \ /  ^|/ // /     
echo %ESC%[38;5;196m                             ^|   /  ___/ / /^|  // /___   
echo %ESC%[38;5;124m                             ^|__/  /____/_/ ^|_/ \____/   
echo %ESC%[0m
echo                                        v1.2
echo                                 Very Simple Net Chat     
echo                             (2026) by Manuel Pollhammer
echo.

:: User login
set /p USER=Please enter your name: 
if "%USER%"=="" set USER=Guest

:: Stabilize window after input
mode con: cols=85 lines=30

if not exist "%CHATFILE%" (
    >>"%CHATFILE%" echo %ESC%[38;5;240m%ESC%[0m%ESC%[38;5;196m System:%ESC%[0m Chat started.
)

:: Main loop
:loop
cls
echo %ESC%[H
echo ===== CHAT (latest 20) =====

set /a LINECOUNT=0
for /f "delims=" %%l in ('type "%CHATFILE%" 2^>nul') do (
    set /a LINECOUNT+=1
    set "LINE[!LINECOUNT!]=%%l"
)

set /a START=LINECOUNT-19
if !START! lss 1 set START=1

for /l %%i in (!START!,1,!LINECOUNT!) do (
    echo !LINE[%%i]!
)

echo.
echo [W] write   [Q] quit

choice /c WQR /n /t 1 /d R >nul
if errorlevel 3 goto loop
if errorlevel 2 goto end
if errorlevel 1 goto write
goto loop

:: Chat actions
:write
:: Ask user for text input
set "TEXT="
set /p TEXT=%ESC%[38;5;208m %USER%: %ESC%[0m

if not "%TEXT%"=="" (
    :: Capture date & time
    set "TS=%DATE%-%TIME:~0,5%"
    :: Write message to chat file
    >>"%CHATFILE%" echo %ESC%[38;5;240m[%TS%]%ESC%[0m %ESC%[38;5;208m%USER%:%ESC%[0m %TEXT%
)
goto loop

:: Exit program
:end
exit
