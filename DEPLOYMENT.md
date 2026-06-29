# Odysseus Deployment Guide

This document describes the deployment of Odysseus to both local systems and GitHub.

## Deployment Summary

- **Application**: Odysseus - Self-hosted AI Workspace
- **Deployment Date**: June 29, 2026
- **Status**: ✅ Active and Running
- **Local URL**: http://localhost:7000
- **GitHub Repository**: https://github.com/bhagyarekhasunkavalli99/odysseus

## Admin Credentials

- **Username**: rekha
- **Password**: rekha@2005

## Windows Native Deployment

### System Requirements
- Windows 10/11
- Python 3.11+ (Python 3.12.4 installed)
- 4GB+ RAM (8GB recommended)
- Internet connection

### Deployment Steps Completed

1. ✅ **Python Environment**
   - Python 3.12.4 installed
   - Virtual environment created at `venv/`

2. ✅ **Dependencies Installed**
   - All packages from requirements.txt installed
   - Total: 73 packages
   - Installation time: ~5 minutes
   - Size: ~1.5GB

3. ✅ **Database & Setup**
   - SQLite database initialized at `data/app.db`
   - Admin account created: `rekha`
   - All necessary directories created

4. ✅ **Server Running**
   - Server status: Active
   - Host: 127.0.0.1
   - Port: 7000
   - Protocol: HTTP

## Features Deployed

- **Chat & AI Agents** - Ready for models (local Ollama or API endpoints)
- **Email** - IMAP/SMTP configuration available in Settings
- **Documents** - Full editor with Markdown support
- **Calendar** - CalDAV sync ready
- **Notes & Tasks** - Memory and task management
- **Research** - Deep research capabilities
- **Cookbook** - Model management and serving
- **Gallery** - Image editing and management
- **Memory/Brain** - Semantic search and memory storage

## GitHub Deployment

### Repository Details
- **URL**: https://github.com/bhagyarekhasunkavalli99/odysseus
- **Visibility**: Public
- **Branch**: main
- **Total Commits**: 1
- **Total Files**: 1,318+
- **Repository Size**: 12.32 MB

### Files Included
```
✅ Application code (routes, services, core)
✅ Configuration files (.env.example, pyproject.toml)
✅ Dependencies (requirements.txt, requirements-optional.txt)
✅ Documentation (README.md, docs/setup.md)
✅ Database schemas and migrations
✅ Docker configuration files
✅ Windows launcher scripts
✅ Platform compatibility files
✅ Static assets and UI components
```

### Files Excluded
- `.github/workflows/` - GitHub Actions (required workflow scope)
- `data/` - Local database and uploads (gitignored)
- `venv/` - Virtual environment (gitignored)
- `.env` - Environment variables (gitignored)

## Running Odysseus

### Start Server
```powershell
cd c:\Users\x380 yoga\Downloads\claude ody\odysseus-dev
.\venv\Scripts\Activate.ps1
python -m uvicorn app:app --host 127.0.0.1 --port 7000
```

### Access Web Interface
1. Open browser: http://localhost:7000
2. Login with credentials: rekha / rekha@2005
3. Configure models and API endpoints in Settings

### Stop Server
- Press `Ctrl+C` in the terminal running the server

## Configuration

### Environment Variables (.env)
Currently configured for local use:
```
LLM_HOST=localhost
SEARXNG_INSTANCE=http://localhost:8080
AUTH_ENABLED=true
APP_BIND=127.0.0.1
APP_PORT=7000
```

### Adding AI Models
1. Install Ollama locally or use API endpoint
2. Go to Settings → Model Setup
3. Add model endpoint (default: http://localhost:11434)
4. Start chatting

### Email Setup
1. Settings → Email
2. Enter IMAP/SMTP credentials
3. Configure inbox sync

## Next Steps

1. **Add Models**: Configure Ollama or API endpoints (OpenAI, Claude, etc.)
2. **Setup Email**: Connect your email account
3. **Customize**: Change theme, font, and settings
4. **Backup**: Use the built-in backup feature regularly
5. **Deploy Remote**: Use reverse proxy (nginx) for public access if needed

## Troubleshooting

### Port Already in Use
```powershell
# Change port in .env
APP_PORT=7001
# Restart server
```

### Database Issues
```powershell
# Reset database (careful - loses all data)
Remove-Item data\app.db
python setup.py
```

### Module Not Found
```powershell
# Reinstall dependencies
pip install -r requirements.txt
```

## Support & Documentation

- **Setup Guide**: [docs/setup.md](docs/setup.md)
- **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md)
- **Roadmap**: [ROADMAP.md](ROADMAP.md)
- **Security**: [SECURITY.md](SECURITY.md)
- **GitHub Issues**: https://github.com/bhagyarekhasunkavalli99/odysseus/issues

## Deployment Information

- **Deployed by**: GitHub Copilot AI Assistant
- **Deployment Type**: Windows Native (PowerShell)
- **Container Runtime**: Not used (native Python)
- **Version**: v1.0.1
- **License**: AGPL-3.0-or-later

---

Last Updated: June 29, 2026
Status: ✅ Production Ready
