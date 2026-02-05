:: https://github.com/pollhammer/vsnc
@echo off
setlocal EnableDelayedExpansion

:: Initialization
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
reg add "HKCU\Console" /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

chcp 65001 >nul
title VSNC v1.5
mode con: cols=85 lines=30

:: Chat directory
set "CHAT=C:\Temp"
set "CHATFILE=%CHAT%\chat.txt"
set "USERCOLORFILE=%CHAT%\usercolors.txt"

if not exist "%CHAT%" mkdir "%CHAT%"
if not exist "%USERCOLORFILE%" echo.>"%USERCOLORFILE%"

:: Header
echo.
echo %ESC%[38;5;214m                              _   __ _____  _   __ ______
echo %ESC%[38;5;208m                             ^| ^| / // ___/ / ^| / // ____/
echo %ESC%[38;5;202m                             ^| ^|/ / \__ \ /  ^|/ // /     
echo %ESC%[38;5;196m                             ^|   /  ___/ / /^|  // /___   
echo %ESC%[38;5;124m                             ^|__/  /____/_/ ^|_/ \____/   
echo %ESC%[0m
echo                                         v1.5
echo                               Very Simple Network Chat     
echo                             (2026) by Manuel Pollhammer
echo.

:: User login
set /p USER=Please enter your name: 
if "%USER%"=="" set USER=Guest

:: User color handling

:: Predefined bright, readable colors
set COLORS=11 12 13 14 15 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231

set "USERCOLOR="

:: Load existing color
for /f "tokens=1,2 delims=:" %%A in (%USERCOLORFILE%) do (
    if /I "%%A"=="%USER%" set "USERCOLOR=%%B"
)

:: Assign new color if missing
if not defined USERCOLOR (
    set /a IDX=%RANDOM% %% 40
    set /a CNT=0
    for %%C in (%COLORS%) do (
        if !CNT! EQU !IDX! set USERCOLOR=%%C
        set /a CNT+=1
    )
    echo %USER%:!USERCOLOR!>>"%USERCOLORFILE%"

)

:: Stabilize window
mode con: cols=85 lines=30

if not exist "%CHATFILE%" (
    echo %ESC%[38;5;196mSystem:%ESC%[0m Chat started.>>"%CHATFILE%"
)

:: ================= MAIN LOOP =================
:loop
cls
echo %ESC%[H
echo ===== CHAT (latest 20) =====

set LINECOUNT=0
for /f "delims=" %%L in (%CHATFILE%) do (
    set /a LINECOUNT+=1
    set "LINE[!LINECOUNT!]=%%L"
)

set /a START=LINECOUNT-19
if !START! LSS 1 set START=1

for /l %%I in (!START!,1,!LINECOUNT!) do echo !LINE[%%I]!

echo.
echo [W] write   [Q] quit

choice /c WQR /n /t 1 /d R >nul
if errorlevel 3 goto loop
if errorlevel 2 goto end
if errorlevel 1 goto write
goto loop

:: ================= WRITE =================
:write
set "TEXT="
set /p TEXT=%ESC%[38;5;!USERCOLOR!m %USER%:%ESC%[0m 

if defined TEXT (
    echo %ESC%[38;5;240m[%DATE%-%TIME:~0,5%]%ESC%[0m %ESC%[38;5;!USERCOLOR!m%USER%:%ESC%[0m %TEXT%>>"%CHATFILE%"
)

:: ===== LIMIT chat.txt BY REMOVING FIRST 20 LINES WHEN 40 REACHED =====
set MAXLINES=40
set TRIMLINES=20
set COUNT=0

for /f "delims=" %%l in ('type "%CHATFILE%"') do (
    set /a COUNT+=1
    set "TMP[!COUNT!]=%%l"
)

if !COUNT! geq %MAXLINES% (
    (
        for /l %%i in (%TRIMLINES%+1,1,!COUNT!) do (
            echo !TMP[%%i]!
        )
    ) > "%CHATFILE%"
)
:: ================================================================

goto loop

:end
exit
