# Odysseus Offline Configuration Guide

## Overview
Odysseus can run completely offline with local AI models. This guide shows how to set it up for offline operation.

## Requirements for Offline Operation

### 1. Local AI Model (Ollama)
- Download: https://ollama.ai
- Install and run: `ollama serve`
- Download models: `ollama pull mistral` (or any model)

### 2. No Internet Required Features
✅ Chat with local models  
✅ Document editing  
✅ Notes & tasks  
✅ Calendar (local only)  
✅ Gallery/images  
✅ Local memory storage  

### 3. Internet-Only Features (Disabled)
❌ Web search / research  
❌ Email (requires IMAP/SMTP server)  
❌ Cloud model APIs (OpenAI, Claude, etc.)  
❌ SearXNG integration  
❌ YouTube transcript loading  

## Installation Steps

### Step 1: Install Ollama

**Windows:**
1. Download: https://ollama.ai/download
2. Run installer
3. Restart if needed

**Verify installation:**
```powershell
ollama --version
```

### Step 2: Download a Model

Open PowerShell and run:
```powershell
ollama pull mistral
```

Available models:
- `mistral` - Fast, good for general chat (7B)
- `llama2` - Meta's model (7B or 13B)
- `neural-chat` - Intel optimized (7B)
- `orca-mini` - Smaller, faster (3B)
- `starling-lm` - Open source (7B)

For better quality (requires more VRAM):
```powershell
ollama pull mistral:13b
ollama pull neural-chat:13b
```

### Step 3: Run Ollama Server

Open a new PowerShell terminal:
```powershell
ollama serve
```

It will listen on: `http://localhost:11434`

Keep this terminal running while using Odysseus.

### Step 4: Configure Odysseus for Offline

Update `.env` file with:
```env
# Disable online services
SEARXNG_INSTANCE=disabled
AUTH_ENABLED=true
APP_BIND=127.0.0.1
APP_PORT=7000

# Point to local Ollama
LLM_HOST=localhost
OLLAMA_BASE_URL=http://localhost:11434

# Disable email (requires internet)
ODYSSEUS_INPROCESS_POLLERS=0

# Disable online features
ODYSSEUS_INPROCESS_TASKS=0
```

### Step 5: Start Odysseus

```powershell
cd "c:\Users\x380 yoga\Downloads\claude ody\odysseus-dev"
.\venv\Scripts\Activate.ps1
python -m uvicorn app:app --host 127.0.0.1 --port 7000
```

### Step 6: Configure in Web UI

1. Open: http://localhost:7000
2. Login: rekha / rekha@2005
3. Click Settings (gear icon)
4. Model Setup → Add Model:
   - **Name:** Mistral
   - **Endpoint:** http://localhost:11434
   - **Model:** mistral (or your chosen model)
5. Test → Start chatting!

## Complete Offline Setup Instructions

### Option A: Quick Setup (Recommended)

```powershell
# Terminal 1: Run Ollama
ollama serve

# Terminal 2: Run Odysseus
cd "c:\Users\x380 yoga\Downloads\claude ody\odysseus-dev"
.\venv\Scripts\Activate.ps1
python -m uvicorn app:app --host 127.0.0.1 --port 7000

# Terminal 3: Use browser
# Open http://localhost:7000
```

### Option B: Single Command (PowerShell)

```powershell
# Start Ollama in background
Start-Process powershell -ArgumentList "-NoExit", "-Command", "ollama serve"

# Wait 2 seconds for Ollama to start
Start-Sleep -Seconds 2

# Start Odysseus
cd "c:\Users\x380 yoga\Downloads\claude ody\odysseus-dev"
powershell -ExecutionPolicy Bypass -Command ".\venv\Scripts\Activate.ps1; python -m uvicorn app:app --host 127.0.0.1 --port 7000"
```

### Option C: Windows Batch Script

Create `start-offline.bat`:
```batch
@echo off
REM Start Ollama in background
start "Ollama Server" cmd /k "ollama serve"

REM Wait for Ollama
timeout /t 3

REM Start Odysseus
cd "c:\Users\x380 yoga\Downloads\claude ody\odysseus-dev"
powershell -ExecutionPolicy Bypass -Command ".\venv\Scripts\Activate.ps1; python -m uvicorn app:app --host 127.0.0.1 --port 7000"

REM Open browser
start http://localhost:7000
```

Then just double-click `start-offline.bat` to start everything!

## Features in Offline Mode

| Feature | Status | Notes |
|---------|--------|-------|
| Chat | ✅ Works | Local Ollama models |
| Documents | ✅ Works | Full editor, no AI enhancement |
| Notes | ✅ Works | All local |
| Tasks | ✅ Works | Local storage |
| Calendar | ✅ Works | Local calendar |
| Gallery | ✅ Works | Image storage/editing |
| Email | ❌ Disabled | Requires internet |
| Web Search | ❌ Disabled | Requires internet |
| Research | ❌ Disabled | Requires web access |
| Cloud Models | ❌ Disabled | Requires API keys/internet |
| Memory/Brain | ✅ Limited | ChromaDB needs docker |

## Recommended Offline Models

| Model | Size | VRAM | Speed | Quality |
|-------|------|------|-------|---------|
| mistral | 7B | 4GB | Fast | Good |
| neural-chat | 7B | 4GB | Fast | Good |
| orca-mini | 3B | 2GB | Very Fast | OK |
| llama2 | 7B | 4GB | Fast | Good |
| mistral:13b | 13B | 8GB | Medium | Better |

Install multiple models:
```powershell
ollama pull mistral
ollama pull neural-chat
ollama pull orca-mini
```

Then select in Settings → Model Setup

## Troubleshooting Offline

### Problem: "Connection refused at localhost:11434"
**Solution:**
- Ensure Ollama is running: `ollama serve`
- Check firewall isn't blocking port 11434
- Run: `ollama list` to verify models are installed

### Problem: "Model not found"
**Solution:**
```powershell
ollama pull mistral
ollama list
```

### Problem: Chat is very slow
**Solution:**
- Use smaller model: `ollama pull orca-mini`
- Close other programs (Ollama needs RAM)
- Check CPU isn't maxed out

### Problem: "OLLAMA_BASE_URL not found"
**Solution:**
- Restart Odysseus server
- Make sure `.env` has: `OLLAMA_BASE_URL=http://localhost:11434`

## Performance Tips

1. **Use smaller models for speed:**
   - `orca-mini:latest` (3B) - fastest
   - `mistral:latest` (7B) - balanced
   - `mistral:13b` (13B) - best quality, slower

2. **Close unnecessary programs** to free up RAM

3. **Increase Ollama context** (advanced):
   ```powershell
   ollama run mistral --num-predict=2048
   ```

4. **Use GPU if available** (Ollama auto-detects NVIDIA/AMD)

## Offline Starter Pack

```powershell
# Install fast model (recommended)
ollama pull mistral

# OR install multiple models
ollama pull mistral
ollama pull neural-chat
ollama pull orca-mini

# Verify
ollama list

# Run
ollama serve
```

## When You Need Internet

To use online features temporarily:
1. Update `.env` with OpenAI API key: `OPENAI_API_KEY=sk-...`
2. Update SearXNG: `SEARXNG_INSTANCE=http://localhost:8080`
3. Configure email IMAP/SMTP
4. Restart Odysseus

## Next Steps

1. ✅ Install Ollama: https://ollama.ai
2. ✅ Download model: `ollama pull mistral`
3. ✅ Run Ollama: `ollama serve`
4. ✅ Update `.env` for offline
5. ✅ Start Odysseus
6. ✅ Configure model in Settings
7. ✅ Start chatting offline!

---

**Status:** Fully offline-capable ✅
**Tested on:** Windows 10/11  
**Last Updated:** June 29, 2026
