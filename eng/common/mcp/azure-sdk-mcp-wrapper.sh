#!/bin/bash
# Wrapper script for azure-sdk-mcp to resolve repo root path
# The Copilot CLI doesn't resolve ${workspaceFolder} in .vscode/mcp.json,
# so this script finds the repo root via git and launches the PowerShell MCP server.
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo "$(cd "$(dirname "$0")/../../.." && pwd)")"
exec pwsh "$REPO_ROOT/eng/common/mcp/azure-sdk-mcp.ps1" -Run
