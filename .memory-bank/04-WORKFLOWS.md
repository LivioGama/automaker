# Workflows

## Development Workflow
1. Read current state from Memory Bank (02-CURRENT-STATE.md)
2. Check constraints in 03-CONSTRAINTS.md before making changes
3. Make code changes following established patterns
4. Run appropriate tests (`npm run test:server` or `npm run test`)
5. Log changes to 99-CHANGELOG.md
6. Update 02-CURRENT-STATE.md with progress

## Testing

### E2E Tests (Playwright)
```bash
npm run test                  # Headless
npm run test:headed           # With visible browser
```

### Server Unit Tests (Vitest)
```bash
npm run test:server           # All server tests
npm run test:server -- path/to/test.ts  # Specific test file
```

### All Tests
```bash
npm run test:all              # Packages + server + E2E
```

## Build

### Development Build & Run
```bash
npm run dev                   # Interactive launcher (choose web or electron)
npm run dev:web              # Web browser mode (localhost:3007)
npm run dev:electron         # Desktop app
npm run dev:electron:debug   # Desktop with DevTools
```

### Production Build
```bash
npm run build                # Build web application
npm run build:packages       # Build all shared packages (REQUIRED first)
npm run build:electron       # Build desktop app
npm run build:server         # Build server only
```

## Common Tasks

### Add Dependency
```bash
npm install <package> --workspace=@automaker/package-name
# or specific app:
npm install <package> --workspace=apps/server
```

### Format & Lint
```bash
npm run lint                 # ESLint check
npm run format               # Prettier write
npm run format:check         # Prettier check only
```

### Docker Operations
```bash
# Build and run Docker containers (when Dockerfile exists)
docker-compose up --build
```

## Git Workflow
1. Create feature branch from main
2. Make changes in worktree if testing agent execution
3. Run full build before push: `npm run build:packages && npm run build`
4. Ensure tests pass
5. Commit with descriptive message
6. Push to feature branch, then PR to main

## Debugging

### Frontend (React/Vite)
```bash
npm run dev:web              # Dev server with HMR
# Open DevTools (F12) for console/network debugging
```

### Backend (Express)
```bash
npm run test:server -- --reporter=verbose  # Detailed test output
# Add DEBUG=@automaker:* environment variable for logging
```

### Terminal Issues
- Check TerminalService logs in server output
- Verify node-pty is correctly installed
