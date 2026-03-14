# Constraints

## Technical Constraints
- Must support both Node 18+ and Bun runtime
- Package dependency chain must be strictly respected (see 01-ARCHITECTURE.md)
- Frontend port: 3007 (Vite dev server)
- Backend port: 3008 (Express server)
- All imports from shared packages (@automaker/*), never relative imports from other service directories

## Security Policies
- No hardcoded secrets or credentials in code
- All user input sanitized before processing
- Context files loaded from .automaker/ only for trusted projects
- Git worktree operations must be atomic and safe

## Code Standards
- TypeScript everywhere except config files
- All functions defined as const arrow functions with implicit returns
- Follow existing import conventions from @automaker/* packages
- All public functions require JSDoc comments explaining purpose and parameters
- No console.log in production code (use @automaker/utils logger)

## Forbidden Patterns
- ❌ Relative imports across services/apps (use @automaker/* packages)
- ❌ Direct filesystem access (use @automaker/platform utilities)
- ❌ Hardcoded environment variables
- ❌ Shared container_name or port conflicts in Docker
- ❌ Direct git commands (use @automaker/git-utils)
- ❌ Mocking @automaker/types or core packages
- ❌ Circular dependencies between packages

## Pre-Change Validation (MANDATORY before commit)
- [ ] No conflicting container names in Docker configs
- [ ] No overlapping port assignments
- [ ] All imports use @automaker/* namespace
- [ ] Package dependency chain respected
- [ ] TypeScript compilation succeeds
- [ ] Tests pass (if applicable)
- [ ] No hardcoded secrets in diffs
