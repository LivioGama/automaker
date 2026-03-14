# Easypanel Deployment Guide

## Overview

AutoMaker has been adapted for deployment on Easypanel (VPS Docker management platform). Key changes:

- **No hardcoded `container_name`** - Easypanel manages container naming automatically
- **Environment-based port configuration** - Use `UI_PORT` and `SERVER_PORT` variables
- **Dedicated `automaker` network** - Services communicate via internal network bridge
- **Volume persistence** - Named volumes handle data storage across restarts

## Configuration

### Environment Variables

Create a `.env` file for Easypanel with these optional overrides:

```bash
# Port customization (defaults shown)
UI_PORT=3007
SERVER_PORT=3008

# Anthropic API
ANTHROPIC_API_KEY=sk-...

# Optional: Claude CLI OAuth credentials
CLAUDE_OAUTH_CREDENTIALS=...

# Optional: Cursor CLI token
CURSOR_AUTH_TOKEN=...

# Optional: AutoMaker API key (auto-generated if blank)
AUTOMAKER_API_KEY=...

# Data directory (in container)
ALLOWED_ROOT_DIRECTORY=/projects
DATA_DIR=/data

# CORS (auto-detected if blank)
CORS_ORIGIN=

# Container environment
IS_CONTAINERIZED=true
```

## Deployment Files

### Production (`docker-compose.yml`)
- Use for live deployments
- Multi-stage build (ui + server)
- Optimized images

```bash
docker-compose up -d
```

### Development Full Stack (`docker-compose.dev.yml`)
- Both UI and server in containers
- Live reload with volume mounts
- HMR enabled for frontend

```bash
docker-compose -f docker-compose.dev.yml up
```

### Development Server Only (`docker-compose.dev-server.yml`)
- Server in container, UI runs locally
- Useful for Electron development

```bash
docker-compose -f docker-compose.dev-server.yml up
npm run dev:electron  # On host machine
```

## Networking

Services communicate via the `automaker` bridge network:
- **ui** → accesses **server** at `http://server:3008` (internal)
- External access: `http://localhost:${UI_PORT}` and `http://localhost:${SERVER_PORT}`

## Volumes

Persistent data stored in named volumes:

| Volume | Purpose | Data Retention |
|--------|---------|-----------------|
| `automaker-data` | Projects & sessions | Persistent |
| `automaker-claude-config` | Claude CLI auth | Persistent |
| `automaker-cursor-config` | Cursor CLI config | Persistent |
| `automaker-opencode-*` | OpenCode data | Persistent |

## Health Checks

Server includes a health check endpoint:
```bash
curl http://localhost:3008/api/health
```

## Port Conflicts

If ports 3007/3008 are in use:
```bash
UI_PORT=3017 SERVER_PORT=3018 docker-compose up
```

## Logs & Debugging

View service logs:
```bash
docker-compose logs -f server  # Server logs
docker-compose logs -f ui      # UI logs
```

Check container networking:
```bash
docker network ls
docker network inspect automaker
```

## Best Practices for Easypanel

1. **Use environment variables** - Never hardcode secrets
2. **Monitor volumes** - Ensure named volumes don't fill disk
3. **Set resource limits** - Use Easypanel UI to cap CPU/memory
4. **Regular backups** - Backup named volumes regularly
5. **Update base images** - Periodically rebuild to pull latest dependencies

## Troubleshooting

### Containers won't start
```bash
docker-compose logs server
docker-compose logs ui
```

### Network issues between services
```bash
docker-compose exec server ping ui
docker-compose exec ui curl http://server:3008/api/health
```

### Port already in use
```bash
lsof -i :3007  # Find process using port 3007
# Then either kill it or change UI_PORT
```

### Volume permission issues
```bash
docker-compose down -v  # Delete volumes
docker-compose up       # Recreate fresh
```
