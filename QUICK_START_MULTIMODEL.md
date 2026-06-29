# 🚀 QUICK START: Claude + Ollama Multi-Model Chat

## 30-Second Setup

### 1. Get Claude API Key (FREE)
- Go to: https://console.anthropic.com/account/keys
- Click "Create Key"
- Copy the key (starts with `sk-ant-v1-`)

### 2. Run Setup Script
```powershell
.\setup-multimodel.bat
```
Choose option 2 (Claude + Ollama)

### 3. Start Everything
**Terminal 1:**
```powershell
ollama serve
```

**Terminal 2:**
```powershell
python -m uvicorn app:app --host 127.0.0.1 --port 7000
```

### 4. Open Browser
http://localhost:7000 → Login → Settings → Select Model

---

## Available Models

| Model | Provider | Speed | Quality | Cost |
|-------|----------|-------|---------|------|
| **Claude 3.5 Sonnet** | Anthropic | ⚡ | ⭐⭐⭐⭐⭐ | ~$0.02/msg |
| **Mistral** | Local | ⚡⚡ | ⭐⭐⭐ | FREE |
| **GPT-4o** | OpenAI | ⚡ | ⭐⭐⭐⭐⭐ | ~$0.05/msg |
| **Neural-Chat** | Local | ⚡⚡ | ⭐⭐⭐ | FREE |

---

## Configuration Files

| File | Purpose |
|------|---------|
| `.env.multimodel` | Multi-model config template |
| `MULTIMODEL_SETUP.md` | Detailed guide |
| `setup-multimodel.bat` | Interactive setup wizard |

---

## Switch Models in Chat

1. Click **model dropdown** at top
2. Select: Claude, Ollama, GPT-4o, etc.
3. Type and send
4. Each model available instantly!

---

## Adding More Models

```powershell
# Download more Ollama models
ollama pull neural-chat
ollama pull llama2
ollama pull orca-mini

# All appear in dropdown automatically!
```

---

## Files in Repository

```
odysseus/
├── .env.multimodel          ← Config template
├── MULTIMODEL_SETUP.md      ← Full guide
├── setup-multimodel.bat     ← Setup wizard
├── OFFLINE_SETUP.md         ← Offline guide
├── DEPLOYMENT.md            ← Deployment guide
└── ... (rest of app)
```

---

## Common Tasks

### Add Claude Only
```
1. setup-multimodel.bat
2. Choose option 2
3. Enter Claude API key
4. Done!
```

### Add All Models (Claude + OpenAI + Ollama)
```
1. setup-multimodel.bat
2. Choose option 3
3. Enter Claude API key
4. Enter OpenAI API key
5. Done!
```

### Go Offline (Ollama Only)
```
1. setup-multimodel.bat
2. Choose option 1
3. All online services disabled
4. Only Ollama works (FREE!)
```

---

## Chat Examples

**Using Claude for Writing:**
- Select: Claude 3.5 Sonnet
- Ask: "Write a blog post about..."
- Get: High-quality, detailed response

**Using Ollama for Brainstorming:**
- Select: Mistral Local
- Ask: "Generate 10 ideas for..."
- Get: Fast response (FREE, offline)

**Using GPT-4o for Coding:**
- Select: GPT-4o
- Ask: "Debug this Python code..."
- Get: Excellent code analysis

---

## Pricing Summary

| Usage | Cost/Month | Setup |
|-------|-----------|-------|
| **Ollama Only** | $0 | Free |
| **Claude + Ollama** | $2-10 | API key |
| **All Models** | $5-30 | 2 API keys |

---

## Support

- Full guide: Read `MULTIMODEL_SETUP.md`
- Offline guide: Read `OFFLINE_SETUP.md`
- Deployment: Read `DEPLOYMENT.md`
- GitHub: https://github.com/bhagyarekhasunkavalli99/odysseus

---

**You're ready! Start chatting with multiple AI models now! 🎉**
