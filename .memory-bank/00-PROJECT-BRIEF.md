# Project Brief

## Mission
AutoMaker is an autonomous AI development studio built as an npm workspace monorepo that provides a Kanban-based workflow where AI agents (powered by Claude Agent SDK) implement features in isolated git worktrees.

## Core Requirements
1. Provide a Kanban-based UI for managing AI-driven feature implementation
2. Execute feature implementations in isolated git worktrees to protect main branch
3. Stream events from server to frontend via WebSocket for real-time updates
4. Support both web (React + Vite) and desktop (Electron) deployment modes

## Success Criteria
- Features execute autonomously without manual intervention
- Main branch remains protected during feature development
- UI displays live progress of feature implementation
- Project context (CLAUDE.md, etc.) is automatically loaded into agent prompts

## User Experience Targets
- Intuitive Kanban board interface for feature management
- Real-time progress feedback via event streaming
- Easy project setup and configuration
- Seamless context loading from project files

## Out of Scope
- Manual code editing during feature execution
- Multi-user collaboration features
- Git merge conflict resolution (uses worktrees to avoid this)
