:: ============================================================
:: VSNC v2.1 – Very Simple Network Chat (2026)
:: GitHub: https://github.com/pollhammer/vsnc
:: Author: Manuel Pollhammer
:: ============================================================

@echo off
setlocal EnableDelayedExpansion

:: -------------------- Initialization -----------------------
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
reg add "HKCU\Console" /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

chcp 65001 >nul
title VSNC v2.1
mode con: cols=85 lines=30

:: -------------------- Chat directory ----------------------
set "CHAT=C:\Temp"
set "CHATFILE=%CHAT%\chat.txt"
set "USERCOLORFILE=%CHAT%\usercolors.txt"

if not exist "%CHAT%" mkdir "%CHAT%"
if not exist "%USERCOLORFILE%" echo.>"%USERCOLORFILE%"

:: -------------------- Header -------------------------------
echo.
echo %ESC%[38;5;214m                              _   __ _____  _   __ ______
echo %ESC%[38;5;208m                             ^| ^| / // ___/ / ^| / // ____/
echo %ESC%[38;5;202m                             ^| ^|/ / \__ \ /  ^|/ // /     
echo %ESC%[38;5;196m                             ^|   /  ___/ / /^|  // /___   
echo %ESC%[38;5;124m                             ^|__/  /____/_/ ^|_/ \____/   
echo %ESC%[0m
echo                                         v2.1
echo                               Very Simple Network Chat     
echo                             (2026) by Manuel Pollhammer
echo.

:: -------------------- User login --------------------------
set /p USER=Please enter your name: 
if "%USER%"=="" set USER=Guest

:: Create a safe filename for temporary files
set "SAFEUSER=%USER: =_%"
set "TMPF=%CHAT%\vsnc_%SAFEUSER%"

:: -------------------- User color handling ------------------
set COLORS=11 12 13 14 15 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231
set "USERCOLOR="
for /f "usebackq tokens=1,2 delims=:" %%A in ("%USERCOLORFILE%") do (
    if /I "%%A"=="%USER%" set "USERCOLOR=%%B"
)
if not defined USERCOLOR (
    set /a IDX=%RANDOM% %% 40
    set /a CNT=0
    for %%C in (%COLORS%) do (
        if !CNT! EQU !IDX! set USERCOLOR=%%C
        set /a CNT+=1
    )
    echo %USER%:!USERCOLOR!>>"%USERCOLORFILE%"
)

:: -------------------- Stabilize window --------------------
mode con: cols=85 lines=30

:: ============================================================
:: ====================== MAIN LOOP ==========================
:loop

:: Move cursor to top without clearing screen
echo %ESC%[H
echo ===== CHAT (latest 15) =====
echo %ESC%[38;5;196mSystem:%ESC%[0m Chat started
echo.

:: Read and decode messages
set LINECOUNT=0
if exist "%CHATFILE%" (
    for /f "usebackq delims=" %%L in ("%CHATFILE%") do (
        set /a LINECOUNT+=1
        set "DECODED_LINE="
        echo %%L > "%TMPF%.b64"
        certutil -decode "%TMPF%.b64" "%TMPF%.bin" >nul 2>&1
        if exist "%TMPF%.bin" (
            for /f "usebackq delims=" %%D in ("%TMPF%.bin") do set "DECODED_LINE=%%D"
            set "LINE[!LINECOUNT!]=!DECODED_LINE!"
            del "%TMPF%.bin" >nul 2>&1
        )
    )
)

:: Show only the last 15 messages
set /a START=LINECOUNT-14
if !START! LSS 1 set START=1
for /l %%I in (!START!,1,!LINECOUNT!) do (
    if defined LINE[%%I] echo !LINE[%%I]!
)

:: -------------------- Menu -------------------------------
set "MENU=[W] write   [Q] quit"
:: Only display menu if it is not already the last line
if "!LINE[!LINECOUNT!]!" neq "!MENU!" echo !MENU!

:: 1-second wait / live update
choice /c WQR /n /t 1 /d R >nul
if errorlevel 3 goto loop
if errorlevel 2 goto end
if errorlevel 1 goto write

:: Clear message cache
for /l %%I in (1,1,!LINECOUNT!) do set "LINE[%%I]="

goto loop

:: ============================================================
:: ===================== WRITE MESSAGE ======================
:write
set "TEXT="
set /p TEXT=%ESC%[38;5;!USERCOLOR!m %USER%:%ESC%[0m 

if defined TEXT (
    :: Timestamp with date (YYYY-MM-DD HH:MM)
    set "DATESTAMP=%DATE%"
    set "TIMESTAMP=%TIME:~0,5%"
    set "RAW=%ESC%[38;5;240m[!DATESTAMP! !TIMESTAMP!]%ESC%[0m %ESC%[38;5;!USERCOLOR!m%USER%:%ESC%[0m %TEXT%"

    cls

    :: Write to file without newline for Base64
    <nul set /p="!RAW!" > "%TMPF%.raw"

    :: Encode to Base64
    certutil -encode "%TMPF%.raw" "%TMPF%.b64_full" >nul 2>&1

    :: Extract only data lines
    set "B64_DATA="
    for /f "usebackq tokens=*" %%B in ("%TMPF%.b64_full") do (
        set "ln=%%B"
        if "!ln:~0,1!" neq "-" set "B64_DATA=!B64_DATA!!ln!"
    )
    echo !B64_DATA!>>"%CHATFILE%"

    del "%TMPF%.raw" "%TMPF%.b64_full" "%TMPF%.b64" >nul 2>&1
)

:: Limit chat.txt to 15 messages
set /a C_LINES=0
for /f "usebackq delims=" %%l in ("%CHATFILE%") do set /a C_LINES+=1
if !C_LINES! gtr 15 (
    more +1 "%CHATFILE%" > "%CHATFILE%.tmp"
    move /y "%CHATFILE%.tmp" "%CHATFILE%" >nul
)

goto loop

:end
del "%TMPF%*" >nul 2>&1
exit
