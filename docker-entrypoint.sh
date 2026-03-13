#!/bin/sh
set -e

# Ensure Claude CLI config directory exists with correct permissions
if [ ! -d "/home/devuser/.claude" ]; then
    mkdir -p /home/devuser/.claude
fi

# If CLAUDE_OAUTH_CREDENTIALS is set, write it to the credentials file
# This allows passing OAuth tokens from host (especially macOS where they're in Keychain)
if [ -n "$CLAUDE_OAUTH_CREDENTIALS" ]; then
    echo "$CLAUDE_OAUTH_CREDENTIALS" > /home/devuser/.claude/.credentials.json
    chmod 600 /home/devuser/.claude/.credentials.json
fi

# Fix permissions on Claude CLI config directory
chown -R devuser:devuser /home/devuser/.claude
chmod 700 /home/devuser/.claude

# Ensure Cursor CLI config directory exists with correct permissions
# This handles both: mounted volumes (owned by root) and empty directories
if [ ! -d "/home/devuser/.cursor" ]; then
    mkdir -p /home/devuser/.cursor
fi
chown -R devuser:devuser /home/devuser/.cursor
chmod -R 700 /home/devuser/.cursor

# Ensure OpenCode CLI config directory exists with correct permissions
# OpenCode stores config and auth in ~/.local/share/opencode/
if [ ! -d "/home/devuser/.local/share/opencode" ]; then
    mkdir -p /home/devuser/.local/share/opencode
fi
chown -R devuser:devuser /home/devuser/.local/share/opencode
chmod -R 700 /home/devuser/.local/share/opencode

# OpenCode also uses ~/.config/opencode for configuration
if [ ! -d "/home/devuser/.config/opencode" ]; then
    mkdir -p /home/devuser/.config/opencode
fi
chown -R devuser:devuser /home/devuser/.config/opencode
chmod -R 700 /home/devuser/.config/opencode

# OpenCode also uses ~/.cache/opencode for cache data (version file, etc.)
if [ ! -d "/home/devuser/.cache/opencode" ]; then
    mkdir -p /home/devuser/.cache/opencode
fi
chown -R devuser:devuser /home/devuser/.cache/opencode
chmod -R 700 /home/devuser/.cache/opencode

# Ensure npm cache directory exists with correct permissions
# This is needed for using npx to run MCP servers
if [ ! -d "/home/devuser/.npm" ]; then
    mkdir -p /home/devuser/.npm
fi
chown -R devuser:devuser /home/devuser/.npm

# If CURSOR_AUTH_TOKEN is set, write it to the cursor auth file
# On Linux, cursor-agent uses ~/.config/cursor/auth.json for file-based credential storage
# The env var CURSOR_AUTH_TOKEN is also checked directly by cursor-agent
if [ -n "$CURSOR_AUTH_TOKEN" ]; then
    CURSOR_CONFIG_DIR="/home/devuser/.config/cursor"
    mkdir -p "$CURSOR_CONFIG_DIR"
    # Write auth.json with the access token
    cat > "$CURSOR_CONFIG_DIR/auth.json" << EOF
{
  "accessToken": "$CURSOR_AUTH_TOKEN"
}
EOF
    chmod 600 "$CURSOR_CONFIG_DIR/auth.json"
    chown -R devuser:devuser /home/devuser/.config
fi

# Switch to devuser and execute the command
exec gosu devuser "$@"
