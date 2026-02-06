:: https://github.com
@echo off
setlocal EnableDelayedExpansion

:: Initialization
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
reg add "HKCU\Console" /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

chcp 65001 >nul
title VSNC v2.0 (Secure Network)
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
echo                                         v2.0
echo                               Very Simple Network Chat     
echo                             (2026) by Manuel Pollhammer
echo.

:: User login
set /p USER=Please enter your name: 
if "%USER%"=="" set USER=Guest
:: Erstelle einen sauberen Dateinamen fuer temporaere Dateien
set "SAFEUSER=%USER: =_%"
set "TMPF=%CHAT%\vsnc_%SAFEUSER%"

:: User color handling
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

:: Stabilize window
mode con: cols=85 lines=30


:: ================= MAIN LOOP =================
:loop
cls
echo %ESC%[H
echo ===== CHAT (latest 20) =====
echo %ESC%[38;5;196mSystem:%ESC%[0m Chat started

set LINECOUNT=0
if exist "%CHATFILE%" (
    for /f "usebackq delims=" %%L in ("%CHATFILE%") do (
        set /a LINECOUNT+=1
        set "DECODED_LINE="
        
        :: Dekodieren der Zeile
        echo %%L > "%TMPF%.b64"
        certutil -decode "%TMPF%.b64" "%TMPF%.bin" >nul 2>&1
        
        if exist "%TMPF%.bin" (
            for /f "usebackq delims=" %%D in ("%TMPF%.bin") do set "DECODED_LINE=%%D"
            set "LINE[!LINECOUNT!]=!DECODED_LINE!"
            del "%TMPF%.bin" >nul 2>&1
        )
    )
)

set /a START=LINECOUNT-19
if !START! LSS 1 set START=1
for /l %%I in (!START!,1,!LINECOUNT!) do (
    if defined LINE[%%I] echo !LINE[%%I]!
)

:: Cache leeren fuer den nächsten Refresh
for /l %%I in (1,1,!LINECOUNT!) do set "LINE[%%I]="

echo.
echo [W] write   [Q] quit

choice /c WQR /n /t 2 /d R >nul
if errorlevel 3 goto loop
if errorlevel 2 goto end
if errorlevel 1 goto write
goto loop

:: ================= WRITE =================
:write
set "TEXT="
set /p TEXT=%ESC%[38;5;!USERCOLOR!m %USER%:%ESC%[0m 

if defined TEXT (
    :: Zeitstempel ohne Sekunden
    set "T=%TIME:~0,5%"
    set "RAW=%ESC%[38;5;240m[!T!]%ESC%[0m %ESC%[38;5;!USERCOLOR!m%USER%:%ESC%[0m %TEXT%"
    
    :: In Datei schreiben (ohne Zeilenumbruch fuer sauberes B64)
    <nul set /p="!RAW!" > "%TMPF%.raw"
    
    :: Kodieren
    certutil -encode "%TMPF%.raw" "%TMPF%.b64_full" >nul 2>&1
    
    :: Nur die Datenzeilen extrahieren (Header/Footer entfernen)
    set "B64_DATA="
    for /f "usebackq tokens=*" %%B in ("%TMPF%.b64_full") do (
        set "ln=%%B"
        if "!ln:~0,1!" neq "-" set "B64_DATA=!B64_DATA!!ln!"
    )
    echo !B64_DATA!>>"%CHATFILE%"
    
    del "%TMPF%.raw" "%TMPF%.b64_full" "%TMPF%.b64" >nul 2>&1
)

:: ===== LIMIT chat.txt (Wartung der Datei) =====
set /a C_LINES=0
for /f "usebackq delims=" %%l in ("%CHATFILE%") do set /a C_LINES+=1
if !C_LINES! geq 40 (
    set /a SKIP=C_LINES-20
    for /f "usebackq skip=%SKIP% delims=" %%l in ("%CHATFILE%") do echo %%l>>"%CHATFILE%.new"
    move /y "%CHATFILE%.new" "%CHATFILE%" >nul
)

goto loop

:end
del "%TMPF%*" >nul 2>&1
exit
