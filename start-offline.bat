@echo off
REM ============================================================
REM Odysseus Offline Startup Script
REM Starts both Ollama and Odysseus with one click
REM ============================================================

setlocal enabledelayedexpansion

echo.
echo ╔═══════════════════════════════════════════════════════╗
echo ║  ODYSSEUS - OFFLINE AI WORKSPACE LAUNCHER              ║
echo ╚═══════════════════════════════════════════════════════╝
echo.

REM Check if Ollama is installed
where ollama >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ ERROR: Ollama is not installed or not in PATH
    echo.
    echo Please download and install Ollama from: https://ollama.ai
    echo.
    pause
    exit /b 1
)

echo ✅ Ollama found
echo.

REM Get script directory
set SCRIPT_DIR=%~dp0
cd /d "%SCRIPT_DIR%"

REM Check if venv exists
if not exist "venv\Scripts\activate.bat" (
    echo ❌ ERROR: Virtual environment not found
    echo.
    echo Please run setup first:
    echo   powershell -ExecutionPolicy Bypass -File .\launch-windows.ps1
    echo.
    pause
    exit /b 1
)

echo ✅ Virtual environment found
echo.

REM Check if models are available
echo Checking Ollama models...
ollama list >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ⚠️  WARNING: Could not check Ollama models
    echo.
    echo Make sure to download a model first:
    echo   ollama pull mistral
    echo   ollama pull neural-chat
    echo.
)

echo.
echo ╔═══════════════════════════════════════════════════════╗
echo ║  STARTING SERVICES                                    ║
echo ╚═══════════════════════════════════════════════════════╝
echo.

REM Start Ollama in a new window
echo 📦 Starting Ollama server...
start "Ollama Server" cmd /k "ollama serve"

REM Give Ollama time to start
timeout /t 3 /nobreak

REM Start Odysseus
echo 🚀 Starting Odysseus...
echo.

REM Use offline config if it exists
if exist ".env.offline" (
    copy .env .env.backup >nul 2>&1
    copy .env.offline .env >nul 2>&1
    echo ✅ Using offline configuration
)

REM Activate venv and start server
call venv\Scripts\activate.bat
python -m uvicorn app:app --host 127.0.0.1 --port 7000

REM Restore original .env if we backed it up
if exist ".env.backup" (
    copy .env.backup .env >nul 2>&1
    del .env.backup >nul 2>&1
)

echo.
echo ╔═══════════════════════════════════════════════════════╗
echo ║  ODYSSEUS STOPPED                                     ║
echo ╚═══════════════════════════════════════════════════════╝
echo.
pause
