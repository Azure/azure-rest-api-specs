#!/usr/bin/env pwsh

#Requires -Version 7.0
#Requires -PSEdition Core

param(
    [string]$FileName = 'Azure.Sdk.Tools.Cli',
    [string]$Package = 'azsdk',
    [string]$Version, # Default to latest
    [string]$InstallDirectory = '',
    [string]$Repository = 'Azure/azure-sdk-tools',
    [string]$RunDirectory = (Resolve-Path (Join-Path $PSScriptRoot .. .. ..)),
    [switch]$Run,
    [switch]$UpdateVsCodeConfig,
    [switch]$UpdatePathInProfile
)

$ErrorActionPreference = "Stop"

# Disable PowerShell's colored output for cleaner MCP logs
$env:NO_COLOR = "1"
$env:TERM = "dumb"

# Fix Azure Identity authentication issues with Conditional Access policies
$env:AZURE_CLI_DISABLE_CONNECTION_VERIFICATION = "true"
$env:AZURE_IDENTITY_DISABLE_CP1 = "true"
$env:AZURE_IDENTITY_USE_CLI_CREDENTIAL = "true"
$env:USER_AGENT = "azsdk-net-Azure.Identity/1.0.0 (.NET 8.0.0; macOS 15.0.0)"
$env:AZURE_CLIENT_USER_AGENT = "azsdk-net-Azure.Identity/1.0.0 (.NET 8.0.0; macOS 15.0.0)"
$env:DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = "false"
$env:DOTNET_SYSTEM_NET_HTTP_USESOCKETSHTTPHANDLER = "true"

# Disable colored output if PSStyle is available (PowerShell 7+)
try {
    if ($PSStyle -and $PSStyle.OutputRendering) {
        $PSStyle.OutputRendering = 'PlainText'
    }
}
catch {
    # Ignore if PSStyle is not available
}
. (Join-Path $PSScriptRoot '..' 'scripts' 'Helpers' 'AzSdkTool-Helpers.ps1')

$toolInstallDirectory = $InstallDirectory ? $InstallDirectory : (Get-CommonInstallDirectory)

$mcpMode = $Run

# Log to console or MCP client json-rpc
function log([object]$message, [switch]$warn, [switch]$err) {
    [string]$messageString = $message

    # Assume we are in an MCP client context when `-Run` is specified
    # otherwise print to console normally
    if (!$mcpMode) {
        if ($err) {
            Write-Error $messageString -ErrorAction Continue
        }
        elseif ($warn) {
            Write-Warning $messageString
        }
        else {
            Write-Host $messageString
        }
        return;
    }

    $level = switch ($message) {
        { $_ -is [System.Management.Automation.ErrorRecord] } { 'error' }
        { $_ -is [System.Management.Automation.WarningRecord] } { 'warning' }
        default { 'notice' }
    }

    # If message stringifies as a valid error message we want to print it
    # otherwise print stack for calls to external binaries
    if ($messageString -eq 'System.Management.Automation.RemoteException') {
        $messageString = $message.ScriptStackTrace
    }

    # Log json-rpc messages so the MCP client doesn't print
    # '[warning] Failed to parse message:'
    $messageObject = @{
        jsonrpc = "2.0"
        method  = "notifications/message"
        params  = @{
            level  = $level
            logger = "installer"
            data   = $messageString
        }
    }

    Write-Host ($messageObject | ConvertTo-Json -Depth 100 -Compress)
}

if ($UpdateVsCodeConfig) {
    $vscodeConfigPath = Join-Path $PSScriptRoot ".." ".." ".." ".vscode" "mcp.json"
    if (Test-Path $vscodeConfigPath) {
        $vscodeConfig = Get-Content -Raw $vscodeConfigPath | ConvertFrom-Json -AsHashtable
    }
    else {
        $vscodeConfig = @{}
    }
    $serverKey = "azure-sdk-mcp"
    $serverConfig = @{
        "type"    = "stdio"
        "command" = "$PSCommandPath"
    }
    $orderedServers = [ordered]@{
        $serverKey = $serverConfig
    }
    if (-not $vscodeConfig.ContainsKey('servers')) {
        $vscodeConfig['servers'] = @{}
    }
    foreach ($key in $vscodeConfig.servers.Keys) {
        if ($key -ne $serverKey) {
            $orderedServers[$key] = $vscodeConfig.servers[$key]
        }
    }
    $vscodeConfig.servers = $orderedServers
    log "Updating vscode mcp config at $vscodeConfigPath"
    $vscodeConfig | ConvertTo-Json -Depth 10 | Set-Content -Path $vscodeConfigPath -Force
}

# Install to a temp directory first so we don't dump out all the other
# release zip contents to one of the users bin directories.
$tmp = $env:TEMP ? $env:TEMP : [System.IO.Path]::GetTempPath()
$guid = [System.Guid]::NewGuid()
$tempInstallDirectory = Join-Path $tmp "azsdk-install-$($guid)"

if ($mcpMode) {
    try {
        # Swallow all output and re-log so we can wrap any
        # output from the inner function as json-rpc
        $tempExe = Install-Standalone-Tool `
            -Version $Version `
            -FileName $FileName `
            -Package $Package `
            -Directory $tempInstallDirectory `
            -Repository $Repository `
            *>&1
        | Tee-Object -Variable _
        | ForEach-Object { log $_; $_ }
        | Select-Object -Last 1
    }
    catch {
        log -err $_
        exit 1
    }
}
else {
    $tempExe = Install-Standalone-Tool `
        -Version $Version `
        -FileName $FileName `
        -Package $Package `
        -Directory $tempInstallDirectory `
        -Repository $Repository `

}

if (-not (Test-Path $toolInstallDirectory)) {
    New-Item -ItemType Directory -Path $toolInstallDirectory -Force | Out-Null
}
$exeName = Split-Path $tempExe -Leaf
$exeDestination = Join-Path $toolInstallDirectory $exeName
Copy-Item -Path $tempExe -Destination $exeDestination -Force

# Ensure executable permissions on macOS
if ($IsMacOS) {
    try {
        # Try PowerShell native approach first
        if (Get-Command "chmod" -ErrorAction SilentlyContinue) {
            & chmod 755 $exeDestination
        } else {
            # Use full path to chmod directly
            & /bin/chmod 755 $exeDestination
        }
        
        # Verify the file is now executable
        if (-not (Test-Path $exeDestination -PathType Leaf)) {
            throw "File not found after chmod"
        }
    }
    catch {
        log -warn "Failed to set executable permissions on $exeDestination : $_"
        # As a last resort, try to use Invoke-Expression
        try {
            Invoke-Expression "/bin/chmod 755 '$exeDestination'"
        }
        catch {
            log -warn "All chmod attempts failed: $_"
        }
    }
}

log "Package $package is installed at $exeDestination"
if (!$UpdatePathInProfile) {
    log -warn "To add the tool to PATH for new shell sessions, re-run with -UpdatePathInProfile to modify the shell profile file."
}
else {
    Add-InstallDirectoryToPathInProfile -InstallDirectory $toolInstallDirectory
    log -warn "'$exeName' will be available in PATH for new shell sessions."
}

if ($Run) {
    try {
        # Verify the file is executable before trying to run it
        if (-not (Test-Path $exeDestination)) {
            throw "Executable not found at $exeDestination"
        }
        
        log "Starting $exeDestination with arguments 'start'"
        Start-Process -WorkingDirectory $RunDirectory -FilePath $exeDestination -ArgumentList 'start' -NoNewWindow -Wait
    }
    catch {
        log -err "Failed to start process: $_"
        # Try to fix permissions and retry once
        if ($IsMacOS) {
            log "Attempting to fix permissions and retry..."
            try {
                if (Get-Command "chmod" -ErrorAction SilentlyContinue) {
                    & chmod 755 $exeDestination
                } else {
                    & /bin/chmod 755 $exeDestination
                }
            }
            catch {
                log -warn "Could not set permissions: $_"
            }
            
            try {
                Start-Process -WorkingDirectory $RunDirectory -FilePath $exeDestination -ArgumentList 'start' -NoNewWindow -Wait
            }
            catch {
                log -err "Retry failed: $_"
                throw
            }
        }
        else {
            throw
        }
    }
}
