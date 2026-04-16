#!/usr/bin/env pwsh
# Portable MCP bootstrapper for vally evals.
# Finds azsdk in the standard install location ($HOME/bin) and starts the MCP server.
# If azsdk is not installed, run: eng/common/mcp/azure-sdk-mcp.ps1
$ErrorActionPreference = 'Stop'

$exeName = if ($IsWindows -or -not $PSVersionTable.PSEdition -or $PSVersionTable.PSEdition -eq 'Desktop') { 'azsdk.exe' } else { 'azsdk' }
$exe = Join-Path $HOME 'bin' $exeName

if (-not (Test-Path $exe)) {
    $cmd = Get-Command azsdk -ErrorAction SilentlyContinue
    if ($cmd) {
        $exe = $cmd.Source
    } else {
        $msg = @{
            jsonrpc = "2.0"
            method  = "notifications/message"
            params  = @{ level = "error"; logger = "bootstrap"; data = "azsdk not found at '$exe'. Run: eng/common/mcp/azure-sdk-mcp.ps1" }
        }
        Write-Host ($msg | ConvertTo-Json -Depth 10 -Compress)
        exit 1
    }
}

& $exe mcp
exit $LASTEXITCODE
