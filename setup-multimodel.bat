@echo off
REM ============================================================
REM Odysseus Multi-Model Setup Script
REM Configure Claude API and Ollama for multi-model chat
REM ============================================================

setlocal enabledelayedexpansion

echo.
echo ╔═══════════════════════════════════════════════════════╗
echo ║  ODYSSEUS MULTI-MODEL CONFIGURATION                   ║
echo ║  Claude + Ollama Setup                                ║
echo ╚═══════════════════════════════════════════════════════╝
echo.

REM Check if .env exists
if not exist ".env" (
    echo ❌ ERROR: .env file not found
    echo.
    echo Please run setup first:
    echo   powershell -ExecutionPolicy Bypass -File .\launch-windows.ps1
    echo.
    pause
    exit /b 1
)

echo.
echo ╔═══════════════════════════════════════════════════════╗
echo ║  CONFIGURATION OPTIONS                                ║
echo ╚═══════════════════════════════════════════════════════╝
echo.
echo 1. Ollama Only (FREE, Offline)
echo 2. Claude + Ollama (RECOMMENDED)
echo 3. Claude + Ollama + OpenAI (Advanced)
echo 4. Exit
echo.

set /p choice=Enter your choice (1-4): 

if "%choice%"=="1" (
    call :setup_ollama_only
) else if "%choice%"=="2" (
    call :setup_claude_ollama
) else if "%choice%"=="3" (
    call :setup_all_models
) else if "%choice%"=="4" (
    exit /b 0
) else (
    echo ❌ Invalid choice
    timeout /t 2
    goto :EOF
)

pause
exit /b 0

:setup_ollama_only
echo.
echo Setting up Ollama Only configuration...
echo.
echo Removing API keys from .env...
powershell -Command "(Get-Content '.env') -replace 'CLAUDE_API_KEY=.*', 'REM CLAUDE_API_KEY=' | Set-Content '.env'"
powershell -Command "(Get-Content '.env') -replace 'OPENAI_API_KEY=.*', 'REM OPENAI_API_KEY=' | Set-Content '.env'"
echo ✅ Configuration complete!
echo.
echo Next steps:
echo 1. Start Ollama in a new terminal:
echo    ollama serve
echo 2. Download a model:
echo    ollama pull mistral
echo 3. Start Odysseus
echo.
goto :EOF

:setup_claude_ollama
echo.
echo Setting up Claude + Ollama configuration...
echo.
set /p claude_key="Enter your Claude API key (sk-ant-v1-...): "

if "!claude_key!"=="" (
    echo ❌ ERROR: No API key entered
    goto :EOF
)

echo Adding Claude API key to .env...
powershell -Command "(Get-Content '.env') -replace 'REM CLAUDE_API_KEY=.*|CLAUDE_API_KEY=.*', 'CLAUDE_API_KEY=!claude_key!' | Set-Content '.env'"

echo ✅ Configuration complete!
echo.
echo Next steps:
echo 1. Start Ollama in a new terminal:
echo    ollama serve
echo 2. Start Odysseus in another terminal
echo 3. In Settings, configure:
echo    - Ollama: http://localhost:11434
echo    - Claude: Auto-detected from .env
echo 4. Start using both models in chat!
echo.
goto :EOF

:setup_all_models
echo.
echo Setting up Claude + Ollama + OpenAI configuration...
echo.
set /p claude_key="Enter your Claude API key (sk-ant-v1-...): "
set /p openai_key="Enter your OpenAI API key (sk-proj-...): "

if "!claude_key!"=="" (
    echo ❌ ERROR: Claude key is required
    goto :EOF
)

if "!openai_key!"=="" (
    echo ❌ ERROR: OpenAI key is required
    goto :EOF
)

echo Adding API keys to .env...
powershell -Command "(Get-Content '.env') -replace 'REM CLAUDE_API_KEY=.*|CLAUDE_API_KEY=.*', 'CLAUDE_API_KEY=!claude_key!' | Set-Content '.env'"
powershell -Command "(Get-Content '.env') -replace 'REM OPENAI_API_KEY=.*|OPENAI_API_KEY=.*', 'OPENAI_API_KEY=!openai_key!' | Set-Content '.env'"

echo ✅ Configuration complete!
echo.
echo Next steps:
echo 1. Start Ollama in a new terminal:
echo    ollama serve
echo 2. Start Odysseus in another terminal
echo 3. In Settings, you'll have access to:
echo    - Claude models
echo    - OpenAI models (GPT-4o, etc.)
echo    - Ollama models (local, free)
echo 4. Start using all models in chat!
echo.
goto :EOF
