@echo off

reg add "HKCU\Console" /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

chcp 65001 >nul
title VSNC v1.3
mode con: cols=59 lines=31

setlocal EnableDelayedExpansion

set CHAT=C:\Temp
set CHATFILE=%CHAT%\chat.txt

echo.
echo %ESC%[38;5;214m                  _   __ _____  _   __ ______
echo %ESC%[38;5;208m                 ^| ^| / // ___/ / ^| / // ____/
echo %ESC%[38;5;202m                 ^| ^|/ / \__ \ /  ^|/ // /     
echo %ESC%[38;5;196m                 ^|   /  ___/ / /^|  // /___   
echo %ESC%[38;5;124m                 ^|__/  /____/_/ ^|_/ \____/   
echo %ESC%[0m

echo                            v1.3
echo                     Very Simple Net Chat     
echo                 (2026) by Manuel Pollhammer
echo.

set /p USER=Please enter your name: 
if "%USER%"=="" set USER=Gast

if not exist "%CHATFILE%" (
    echo Chat started. > "%CHATFILE%"
)

:loop
cls
echo ===== CHAT =====
type "%CHATFILE%"
echo.
echo [W] write   [Q] quit

choice /c WQR /n /t 1 /d R >nul

if errorlevel 3 goto loop
if errorlevel 2 goto end
if errorlevel 1 goto write

goto loop

:write
set TEXT=
set /p TEXT=%ESC%[38;5;208m %USER%: %ESC%[0m
if not "%TEXT%"=="" echo %ESC%[38;5;208m %USER%:%ESC%[0m %TEXT% >> "%CHATFILE%"
goto loop

:end
exit


