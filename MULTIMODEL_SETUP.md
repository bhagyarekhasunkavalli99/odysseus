# Multi-Model Chat Setup Guide
# Configure Odysseus to use Claude, Ollama, and other AI models

## Quick Setup

### Option 1: Local Only (Ollama)
```bash
# Already configured in .env.offline
ollama serve &
python -m uvicorn app:app --host 127.0.0.1 --port 7000
```

### Option 2: Claude + Local (Recommended)
```bash
# 1. Get Claude API key from: https://console.anthropic.com/account/keys
# 2. Update .env with your key:
CLAUDE_API_KEY=sk-ant-v1-xxxxx

# 3. Start Ollama
ollama serve &

# 4. Start Odysseus
python -m uvicorn app:app --host 127.0.0.1 --port 7000
```

### Option 3: All Models (Claude + Ollama + OpenAI)
```bash
# 1. Set up keys in .env:
CLAUDE_API_KEY=sk-ant-v1-xxxxx
OPENAI_API_KEY=sk-proj-xxxxx

# 2. Start Ollama
ollama serve &

# 3. Start Odysseus
python -m uvicorn app:app --host 127.0.0.1 --port 7000
```

---

## Getting API Keys

### Claude (Anthropic)
1. Go to: https://console.anthropic.com/account/keys
2. Sign up or log in
3. Click "Create Key"
4. Copy the key starting with `sk-ant-v1-`
5. Add to `.env`: `CLAUDE_API_KEY=your_key_here`

**Models available:**
- `claude-3-5-sonnet` - Best balance (recommended)
- `claude-3-opus` - Most powerful
- `claude-3-sonnet` - Fast & good
- `claude-3-haiku` - Cheapest & fastest

### OpenAI (Optional)
1. Go to: https://platform.openai.com/account/api-keys
2. Sign up or log in
3. Click "Create new secret key"
4. Copy the key starting with `sk-proj-`
5. Add to `.env`: `OPENAI_API_KEY=your_key_here`

**Models available:**
- `gpt-4o` - Latest & best
- `gpt-4-turbo` - Powerful
- `gpt-3.5-turbo` - Fast & cheap

---

## Configuration Steps

### Step 1: Update .env File

Edit `.env` and add your keys:

```env
# Claude API
CLAUDE_API_KEY=sk-ant-v1-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# OpenAI API (optional)
OPENAI_API_KEY=sk-proj-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# Local Ollama
LLM_HOST=localhost
OLLAMA_BASE_URL=http://localhost:11434
```

### Step 2: Start Services

**Terminal 1 - Start Ollama:**
```powershell
ollama serve
```

**Terminal 2 - Start Odysseus:**
```powershell
cd "c:\Users\x380 yoga\Downloads\claude ody\odysseus-dev"
.\venv\Scripts\Activate.ps1
python -m uvicorn app:app --host 127.0.0.1 --port 7000
```

### Step 3: Configure in Web UI

1. Open: http://localhost:7000
2. Login: `rekha` / `rekha@2005`
3. Go to **Settings** (gear icon)
4. Click **Model Setup**
5. Add models:

**For Ollama (Local):**
- Name: `Mistral Local`
- Type: `Ollama`
- Endpoint: `http://localhost:11434`
- Model: `mistral`

**For Claude:**
- Name: `Claude 3.5 Sonnet`
- Type: `Claude`
- API Key: (auto-filled from .env)
- Model: `claude-3-5-sonnet-20241022`

**For OpenAI:**
- Name: `GPT-4o`
- Type: `OpenAI`
- API Key: (auto-filled from .env)
- Model: `gpt-4o`

### Step 4: Test Models

In chat:
1. Click model selector dropdown
2. Choose a model (e.g., "Claude 3.5 Sonnet")
3. Type a message
4. Click send

---

## Model Comparison

| Model | Provider | Speed | Quality | Cost | Offline |
|-------|----------|-------|---------|------|---------|
| Mistral | Ollama | ⚡⚡ Fast | ⭐⭐⭐ | FREE | ✅ Yes |
| Claude 3.5 | Anthropic | ⚡ Medium | ⭐⭐⭐⭐⭐ | $$ | ❌ No |
| GPT-4o | OpenAI | ⚡ Medium | ⭐⭐⭐⭐⭐ | $$ | ❌ No |
| Llama 2 | Ollama | ⚡⚡ Fast | ⭐⭐⭐ | FREE | ✅ Yes |
| Orca-mini | Ollama | ⚡⚡⚡ Very Fast | ⭐⭐ | FREE | ✅ Yes |

---

## Using Different Models

### Switch Models in Chat
1. Click the model selector at top of chat
2. Choose from available models
3. All previous conversations available with any model

### Example Workflow
```
Chat 1: Use Mistral for brainstorming (fast, offline)
Chat 2: Use Claude for detailed analysis (best quality)
Chat 3: Use GPT-4o for programming (good at code)
```

---

## Pricing & Costs

### Ollama (Local)
- Cost: FREE
- Runs on your computer
- No internet needed
- Slower than cloud models

### Claude (Anthropic)
- Input: $3 / 1M tokens
- Output: $15 / 1M tokens
- Estimated: $0.01-0.10 per chat
- No subscription needed

### OpenAI
- GPT-3.5: $0.50 / 1M input, $1.50 / 1M output
- GPT-4o: $5 / 1M input, $15 / 1M output
- No subscription needed

---

## Troubleshooting

### Claude Not Working
**Error:** "Invalid API key"
- Solution: Check key starts with `sk-ant-v1-`
- Verify at: https://console.anthropic.com/account/keys

### OpenAI Not Working
**Error:** "Invalid API key"
- Solution: Check key starts with `sk-proj-`
- Verify at: https://platform.openai.com/account/api-keys

### Ollama Not Responding
**Error:** "Connection refused at localhost:11434"
- Solution: Run `ollama serve` in another terminal
- Check: `ollama list` to see models

### No Models Showing
**Solution:**
1. Restart Odysseus
2. Go to Settings → Model Setup
3. Click "Refresh"
4. Models should appear

---

## Advanced Configuration

### Use Only Claude (No Ollama)
```env
# Remove or comment out:
# OLLAMA_BASE_URL=http://localhost:11434

# Set Claude
CLAUDE_API_KEY=sk-ant-v1-xxxxx
```

### Use Only Ollama (Offline)
```env
# Use offline config
# .env.offline already set up for this
OLLAMA_BASE_URL=http://localhost:11434
```

### Use Claude for Chat, Ollama for Memory
```env
# Chat uses Claude
CLAUDE_API_KEY=sk-ant-v1-xxxxx

# Memory uses Ollama embeddings (cheaper)
EMBEDDING_URL=http://localhost:11434/v1/embeddings
EMBEDDING_MODEL=all-minilm:l6-v2
```

---

## Quick Reference: Adding a Model

### To Add Claude:
1. Get key from https://console.anthropic.com/account/keys
2. Edit `.env`: `CLAUDE_API_KEY=your_key`
3. Restart Odysseus
4. Settings → Model Setup → Claude appears

### To Add OpenAI:
1. Get key from https://platform.openai.com/account/api-keys
2. Edit `.env`: `OPENAI_API_KEY=your_key`
3. Restart Odysseus
4. Settings → Model Setup → GPT models appear

### To Add More Ollama Models:
```powershell
ollama pull neural-chat
ollama pull llama2
ollama pull orca-mini
```

Then select in chat dropdown!

---

## Recommended Setup

**Best for Most Users:**
- Primary: Claude 3.5 Sonnet (for good quality)
- Secondary: Mistral Local (for offline backup)
- Cost: ~$0.02-0.05 per average chat

```env
CLAUDE_API_KEY=sk-ant-v1-xxxxx
OLLAMA_BASE_URL=http://localhost:11434
```

---

## Safety & Best Practices

1. **Never commit API keys to git**
   - `.env` is gitignored (safe)
   - `.env.multimodel` is in git (remove keys!)

2. **Rotate keys regularly**
   - Claude: https://console.anthropic.com/account/keys
   - OpenAI: https://platform.openai.com/account/api-keys

3. **Monitor usage**
   - Claude: https://console.anthropic.com/account/usage
   - OpenAI: https://platform.openai.com/account/usage

4. **Set spending limits**
   - Prevent unexpected bills

---

## Next Steps

1. ✅ Get Claude API key (free trial available)
2. ✅ Add key to `.env`: `CLAUDE_API_KEY=...`
3. ✅ Start Ollama: `ollama serve`
4. ✅ Start Odysseus: `python -m uvicorn app:app ...`
5. ✅ Configure in Settings
6. ✅ Start chatting with multiple models!

---

**You now have access to:**
- 🏠 Local models (Ollama) - Free, offline
- 🚀 Claude - Best quality
- 🤖 GPT-4o - Excellent for coding
- 💡 All in one interface!
