@echo off
title MØNSTR-M1ND Security Control v3.0
setlocal EnableDelayedExpansion
mode con: cols=80 lines=30

:: Check for admin privileges
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    color 0c
    cls
    echo [!] This script requires Administrator privileges.
    echo Please run as Administrator.
    pause
    exit /b 1
)

:: Create log directory if it doesn't exist
if not exist "C:\MØNSTR-M1ND_Logs" (
    mkdir "C:\MØNSTR-M1ND_Logs"
)

:: Set log file
set "LOGFILE=C:\MØNSTR-M1ND_Logs\security_control_%date:~-4,4%%date:~-10,2%%date:~-7,2%.log"
echo [%date% %time%] Script started >> "%LOGFILE%"

:MAIN_MENU
cls
color 0c
echo.
echo ==============================================
echo    MØNSTR-M1ND Security Control v3.0
echo    Created by MØNSTR-M1ND
echo    Ultimate User and Session Management
echo ==============================================
echo.
echo [INFO] Select an option:
echo 1. List all local users
echo 2. List active sessions
echo 3. Delete a user
echo 4. Terminate a session
echo 5. Exit
echo.
set /p choice=Enter your choice (1-5): 
echo [%date% %time%] User selected option: %choice% >> "%LOGFILE%"

if "%choice%"=="1" goto LIST_USERS
if "%choice%"=="2" goto LIST_SESSIONS
if "%choice%"=="3" goto DELETE_USER
if "%choice%"=="4" goto TERMINATE_SESSION
if "%choice%"=="5" goto END
echo [!] Invalid choice. Please select 1-5.
echo [%date% %time%] Invalid choice entered: %choice% >> "%LOGFILE%"
pause
goto MAIN_MENU

:LIST_USERS
cls
echo [INFO] Listing all local user accounts...
echo -----------------------------------
echo.
wmic useraccount get name,sid | findstr /v "Name" > temp_users.txt
for /f "tokens=1,2" %%u in (temp_users.txt) do (
    echo User: %%u  SID: %%v
)
del temp_users.txt
echo.
echo -----------------------------------
echo [%date% %time%] Listed all local users >> "%LOGFILE%"
pause
goto MAIN_MENU

:LIST_SESSIONS
cls
echo [INFO] Listing active sessions...
echo -----------------------------------
echo.
qwinsta | findstr /v "SESSIONNAME" > temp_sessions.txt
for /f "tokens=1,2,3,4" %%s in (temp_sessions.txt) do (
    echo Session: %%s  User: %%t  ID: %%u  State: %%v
)
del temp_sessions.txt
echo.
echo -----------------------------------
echo [%date% %time%] Listed active sessions >> "%LOGFILE%"
pause
goto MAIN_MENU

:DELETE_USER
cls
echo [INFO] Delete a user account
echo -----------------------------------
echo.
set /p user=Enter username to delete (or 'back' to return): 
echo [%date% %time%] User input for deletion: %user% >> "%LOGFILE%"

if /i "%user%"=="back" goto MAIN_MENU
if "%user%"=="" (
    echo [!] Error: Username cannot be empty.
    echo [%date% %time%] Error: Empty username input >> "%LOGFILE%"
    pause
    goto DELETE_USER
)

:: Check if user exists
net user "%user%" >nul 2>&1
if %errorlevel% NEQ 0 (
    echo [!] Error: User "%user%" does not exist.
    echo [%date% %time%] Error: User %user% not found >> "%LOGFILE%"
    pause
    goto DELETE_USER
)

:: Backup user information
echo [INFO] Creating backup of user information...
net user "%user%" > "C:\MØNSTR-M1ND_Logs\backup_%user%_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
echo [%date% %time%] Backup created for user %user% >> "%LOGFILE%"

:: Confirmation prompt
echo.
echo [WARNING] Are you sure you want to delete "%user%"?
set /p confirm=Type YES to confirm deletion: 
if /i not "%confirm%"=="YES" (
    echo [INFO] Deletion cancelled by user.
    echo [%date% %time%] Deletion cancelled for user %user% >> "%LOGFILE%"
    pause
    goto DELETE_USER
)

:: Attempt to delete user
echo [INFO] Attempting to delete user "%user%"...
net user "%user%" /delete >nul 2>&1
if %errorlevel% EQU 0 (
    echo [+] Success: User "%user%" was deleted successfully!
    echo [%date% %time%] User %user% deleted successfully >> "%LOGFILE%"
) else (
    echo [!] Error: Failed to delete user "%user%". Check permissions.
    echo [%date% %time%] Error: Failed to delete user %user% >> "%LOGFILE%"
)
pause
goto MAIN_MENU

:TERMINATE_SESSION
cls
echo [INFO] Terminate an active session
echo -----------------------------------
echo.
qwinsta | findstr /v "SESSIONNAME" > temp_sessions.txt
for /f "tokens=1,2,3,4" %%s in (temp_sessions.txt) do (
    echo Session: %%s  User: %%t  ID: %%u  State: %%v
)
del temp_sessions.txt
echo.
echo -----------------------------------
set /p session_id=Enter session ID to terminate (or 'back' to return): 
echo [%date% %time%] User input for session termination: %session_id% >> "%LOGFILE%"

if /i "%session_id%"=="back" goto MAIN_MENU
if "%session_id%"=="" (
    echo [!] Error: Session ID cannot be empty.
    echo [%date% %time%] Error: Empty session ID input >> "%LOGFILE%"
    pause
    goto TERMINATE_SESSION
)

:: Attempt to terminate session
echo [INFO] Attempting to terminate session ID %session_id%...
logoff %session_id% >nul 2>&1
if %errorlevel% EQU 0 (
    echo [+] Success: Session ID %session_id% was terminated successfully!
    echo [%date% %time%] Session ID %session_id% terminated successfully >> "%LOGFILE%"
) else (
    echo [!] Error: Failed to terminate session ID %session_id%. Check if ID is valid.
    echo [%date% %time%] Error: Failed to terminate session ID %session_id% >> "%LOGFILE%"
)
pause
goto MAIN_MENU

:END
echo [%date% %time%] Script terminated >> "%LOGFILE%"
color 07
exit /b 0