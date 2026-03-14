# Architecture

## Tech Stack
| Layer | Technology | Version |
|-------|------------|---------|
| Language | TypeScript | Latest |
| Frontend | React 19 + Vite 7 + Electron 39 | Latest |
| Backend | Express 5 + WebSocket (ws) | Latest |
| AI Provider | Claude Agent SDK | Latest |
| State Management | Zustand 5 | Latest |
| Routing (Frontend) | TanStack Router | Latest |
| Styling | Tailwind CSS 4 | Latest |
| Testing | Playwright (E2E), Vitest (unit) | Latest |

## Directory Structure
```
automaker/
├── apps/
│   ├── ui/              # React + Vite + Electron frontend (port 3007)
│   └── server/          # Express + WebSocket backend (port 3008)
└── libs/                # Shared packages (@automaker/*)
    ├── types/           # Core TypeScript definitions (no dependencies)
    ├── utils/           # Logging, errors, image processing, context loading
    ├── prompts/         # AI prompt templates
    ├── platform/        # Path management, security, process spawning
    ├── model-resolver/  # Claude model alias resolution
    ├── dependency-resolver/ # Feature dependency ordering
    └── git-utils/       # Git operations & worktree management
```

## Package Dependency Chain (Strictest Order)
```
@automaker/types (no dependencies)
    ↓
@automaker/utils, @automaker/prompts, @automaker/platform, @automaker/model-resolver, @automaker/dependency-resolver
    ↓
@automaker/git-utils
    ↓
@automaker/server, @automaker/ui
```

## Design Patterns
- **Event-Driven Architecture**: All server operations emit WebSocket events to frontend
- **Git Worktree Isolation**: Each feature executes in isolated git worktree for safety
- **Context File Loading**: Project-specific rules loaded from `.automaker/context/` into agent prompts
- **Model Resolution**: Use `resolveModelString()` to convert model aliases (haiku → claude-haiku-4-5)

## Key Components
- **AgentService**: Manages AI agent execution
- **AutoModeService**: Handles autonomous feature implementation mode
- **FeatureLoader**: Loads and manages feature definitions
- **TerminalService**: Manages terminal sessions
- **WebSocket Event System**: Streams all operations to frontend in real-time

## Integration Points
- **Claude Agent SDK**: AI-powered feature implementation
- **node-pty**: Terminal process management
- **Electron**: Desktop application deployment
- **Git**: Feature isolation via worktrees
