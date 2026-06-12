@echo off
title Viscord Setup and Launcher
color 0A

echo ===================================================
echo              VISCORD SETUP
echo ===================================================
echo.

:: Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo Python not found.
    echo Downloading Python...

    curl -L -o python_installer.exe https://www.python.org/ftp/python/3.11.9/python-3.11.9-amd64.exe

    if not exist python_installer.exe (
        echo Failed to download Python.
        pause
        exit /b
    )

    echo Installing Python...
    start /wait python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0

    del python_installer.exe

    echo.
    echo Python installed.
    echo Please run this file again.
    pause
    exit /b
)

echo Python detected.
echo.

:: Upgrade pip
python -m pip install --upgrade pip

:: Install requirements
echo Installing Viscord dependencies...
python -m pip install --upgrade ^
paho-mqtt ^
firebase-admin ^
numpy ^
sounddevice ^
scipy

if errorlevel 1 (
    echo.
    echo Some packages failed to install.
    pause
    exit /b
)

:: Verify main file exists
if not exist Viscord.py (
    echo.
    echo ERROR: Viscord.py not found.
    pause
    exit /b
)

echo.
echo Launching Viscord...
echo.

python Viscord.py

echo.
echo Viscord closed.
pause
