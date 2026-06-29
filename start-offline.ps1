#!/usr/bin/env powershell
<#
    Odysseus Offline Startup Script for PowerShell
    Starts Ollama and Odysseus for offline operation
#>

$ErrorActionPreference = "Continue"

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  ODYSSEUS - OFFLINE AI WORKSPACE LAUNCHER              ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Check if Ollama is installed
Write-Host "Checking Ollama installation..."
$ollamaCheck = Get-Command ollama -ErrorAction SilentlyContinue
if (-not $ollamaCheck) {
    Write-Host "❌ ERROR: Ollama is not installed or not in PATH" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please download and install Ollama from: https://ollama.ai" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "✅ Ollama found" -ForegroundColor Green
Write-Host ""

# Get script directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location -Path $scriptDir

# Check if venv exists
if (-not (Test-Path "venv\Scripts\Activate.ps1")) {
    Write-Host "❌ ERROR: Virtual environment not found" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please run setup first:" -ForegroundColor Yellow
    Write-Host "  powershell -ExecutionPolicy Bypass -File .\launch-windows.ps1" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "✅ Virtual environment found" -ForegroundColor Green
Write-Host ""

# Check Ollama models
Write-Host "Checking Ollama models..."
try {
    $models = ollama list 2>&1
    if ($models) {
        Write-Host "✅ Models available:" -ForegroundColor Green
        $models | ForEach-Object { Write-Host "   - $_" }
    }
} catch {
    Write-Host "⚠️  Could not check models (Ollama may not be running yet)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  STARTING SERVICES                                    ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Start Ollama in background
Write-Host "📦 Starting Ollama server..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "ollama serve" -WindowStyle Normal

# Wait for Ollama to start
Write-Host "⏳ Waiting for Ollama to initialize (3 seconds)..."
Start-Sleep -Seconds 3

# Start Odysseus
Write-Host ""
Write-Host "🚀 Starting Odysseus..." -ForegroundColor Yellow
Write-Host ""

# Check for offline config
if (Test-Path ".env.offline") {
    Write-Host "Using offline configuration (.env.offline)" -ForegroundColor Green
    if (Test-Path ".env") {
        Copy-Item ".env" ".env.backup" -Force -ErrorAction SilentlyContinue
    }
    Copy-Item ".env.offline" ".env" -Force
}

# Activate venv and run server
& ".\venv\Scripts\Activate.ps1"
python -m uvicorn app:app --host 127.0.0.1 --port 7000

# Restore original .env if we backed it up
if (Test-Path ".env.backup") {
    Copy-Item ".env.backup" ".env" -Force -ErrorAction SilentlyContinue
    Remove-Item ".env.backup" -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  ODYSSEUS STOPPED                                     ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
