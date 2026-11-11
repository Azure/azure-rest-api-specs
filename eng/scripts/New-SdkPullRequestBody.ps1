[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('TypeSpec', 'OpenAPI')]
    [string]$ConfigType,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$ConfigPath,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$SpecRepoUrl,

    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[0-9a-fA-F]{7,40}$')]
    [string]$SpecCommitSha,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$PipelineRun,

    [string]$SdkReleaseType = '',
    [string]$ApiVersionsJson = '[]',
    [string]$ReleasePlanJson = '{}'
)

Set-StrictMode -Version 3
$ErrorActionPreference = 'Stop'

function Format-CodeSpan([string]$Value) {
    $value = $Value.Replace("`r", ' ').Replace("`n", ' ').Replace('|', '\|')
    $longestRun = 0
    foreach ($match in [regex]::Matches($value, '`+')) {
        $longestRun = [Math]::Max($longestRun, $match.Length)
    }
    $delimiter = '`' * ($longestRun + 1)
    if ($value.StartsWith('`') -or $value.EndsWith('`')) {
        $value = " $value "
    }
    return "$delimiter$value$delimiter"
}

function Format-MarkdownUrl([string]$Value) {
    $uri = [uri]$Value
    if (-not $uri.IsAbsoluteUri -or $uri.Scheme -notin @('https', 'http')) {
        throw "Expected an absolute HTTP(S) URL: $Value"
    }
    return $Value.Replace('(', '%28').Replace(')', '%29').Replace('|', '%7C').Replace('>', '%3E').Replace('<', '%3C')
}

function Get-QueryParameter([string]$Url, [string]$Name) {
    foreach ($part in ([uri]$Url).Query.TrimStart('?').Split('&')) {
        $pair = $part.Split('=', 2)
        if ($pair.Count -eq 2 -and [uri]::UnescapeDataString($pair[0]) -ceq $Name) {
            return [uri]::UnescapeDataString($pair[1])
        }
    }
    return ''
}

function Format-LinkLabel([string]$Value) {
    return $Value.Replace('\', '\\').Replace('[', '\[').Replace(']', '\]').Replace('|', '\|').Replace("`r", ' ').Replace("`n", ' ')
}

function Write-MetadataWarning([string]$Message) {
    Write-Host "##vso[task.logissue type=warning]$Message"
}

$apiVersions = @()
try {
    $parsedVersions = ConvertFrom-Json -InputObject $ApiVersionsJson -AsHashtable -NoEnumerate
    if ($parsedVersions -is [array]) {
        $apiVersions = $parsedVersions
    } else {
        Write-MetadataWarning 'API version metadata must be a JSON array; API versions will be omitted.'
    }
}
catch {
    Write-MetadataWarning 'Could not parse API version metadata; API versions will be omitted.'
}

$releasePlan = @{ unavailable = $true }
try {
    $parsedPlan = ConvertFrom-Json -InputObject $ReleasePlanJson -AsHashtable -NoEnumerate
    if ($parsedPlan -isnot [System.Collections.IDictionary]) {
        Write-MetadataWarning 'Release plan metadata must be a JSON object; release plan information is unavailable.'
    } elseif ($parsedPlan.Contains('unavailable') -and $parsedPlan['unavailable'] -isnot [bool]) {
        Write-MetadataWarning 'The release plan unavailable flag must be a boolean; release plan information is unavailable.'
    } else {
        $releasePlan = $parsedPlan
    }
}
catch {
    Write-MetadataWarning 'Could not parse release plan metadata; release plan information is unavailable.'
}

$specRepository = $SpecRepoUrl.TrimEnd('/')
$configurationPath = ($ConfigPath.Split('/') | ForEach-Object { [uri]::EscapeDataString($_) }) -join '/'
$configurationUrl = Format-MarkdownUrl "$specRepository/blob/$SpecCommitSha/$configurationPath"
$commitUrl = Format-MarkdownUrl "$specRepository/commit/$SpecCommitSha"
$sourceLabel = if ($ConfigType -eq 'TypeSpec') { 'TypeSpec source' } else { 'OpenAPI source' }
$rows = [System.Collections.Generic.List[string]]::new()
$rows.Add("| **$sourceLabel** | [$(Format-CodeSpan $ConfigPath)]($configurationUrl) at [$(Format-CodeSpan $SpecCommitSha.Substring(0, 7))]($commitUrl) |")

$versionValues = foreach ($entry in $apiVersions) {
    if ($entry -isnot [System.Collections.IDictionary] -or $entry['version'] -isnot [string] -or [string]::IsNullOrWhiteSpace($entry['version'])) {
        Write-MetadataWarning 'An API version must have a nonempty string version; the invalid entry will be omitted.'
        continue
    }
    if ($null -ne $entry['namespace'] -and $entry['namespace'] -isnot [string]) {
        Write-MetadataWarning 'An API version namespace must be a string; the invalid entry will be omitted.'
        continue
    }
    $value = Format-CodeSpan $entry['version']
    if ($entry['namespace']) {
        $value += " (Namespace: $(Format-CodeSpan $entry['namespace']))"
    }
    $value
}
if ($versionValues) {
    $rows.Add("| **API versions** | $($versionValues -join '<br>') |")
}
if ($SdkReleaseType -and $SdkReleaseType -ne 'none') {
    $rows.Add("| **SDK release type** | $(Format-CodeSpan $SdkReleaseType) |")
}

$pipelineUrl = Format-MarkdownUrl $PipelineRun
$pipelineId = Get-QueryParameter $PipelineRun 'buildId'
$pipelineLabel = if ($pipelineId) { "SDK Generation #$(Format-LinkLabel $pipelineId)" } else { 'Open pipeline run' }
$rows.Add("| **Pipeline run** | [$pipelineLabel]($pipelineUrl) |")

$releasePlanUnavailable = $releasePlan['unavailable'] -eq $true
if (-not $releasePlanUnavailable -and $releasePlan.Contains('url')) {
    try {
        if ($releasePlan['url'] -isnot [string] -or [string]::IsNullOrWhiteSpace($releasePlan['url'])) {
            throw 'The release plan URL must be a nonempty string.'
        }
        $releasePlanUrl = Format-MarkdownUrl $releasePlan['url']
        $releasePlanId = Get-QueryParameter $releasePlan['url'] 'releaseplan'
        $releasePlanLabel = if ($releasePlanId) { "Release plan #$(Format-LinkLabel $releasePlanId)" } else { 'Open release plan' }
        $rows.Add("| **Release plan** | [$releasePlanLabel]($releasePlanUrl) |")
    }
    catch {
        Write-MetadataWarning 'The release plan URL is invalid; release plan information is unavailable.'
        $releasePlanUnavailable = $true
    }
}
if ($releasePlanUnavailable) {
    $rows.Add('| **Release plan** | Release plan information is not available. Create a release plan and link SDK pull request to the release plan. Refer [aka.ms/azsdk/releaseplan-dashboard](https://aka.ms/azsdk/releaseplan-dashboard) for more info. |')
} elseif ($releasePlan.Contains('submittedBy')) {
    if ($releasePlan['submittedBy'] -isnot [string]) {
        Write-MetadataWarning 'The release plan submitter must be a string; the Submitted by row will be omitted.'
    } elseif ($releasePlan['submittedBy']) {
        $rows.Add("| **Submitted by** | $(Format-CodeSpan $releasePlan['submittedBy']) |")
    }
}

@(
    '<!-- azsdk-autopr-description:v1:start -->'
    '## SDK Generation Details'
    ''
    '> [!NOTE]'
    '> This pull request was generated automatically.'
    ''
    '| Detail | Value |'
    '| :--- | :--- |'
    $rows
    ''
    '> [!IMPORTANT]'
    '> Complete the [SDK release prerequisites](https://eng.ms/docs/products/azure-developer-experience/develop/sdk-release/sdk-release-prerequisites) before release.'
    '<!-- azsdk-autopr-description:v1:end -->'
) -join "`n"
