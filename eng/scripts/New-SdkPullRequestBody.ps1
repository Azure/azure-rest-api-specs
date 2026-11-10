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

$apiVersions = ConvertFrom-Json -InputObject $ApiVersionsJson -AsHashtable -NoEnumerate
if ($apiVersions -isnot [array]) {
    throw 'API versions must be a JSON array.'
}
$releasePlan = ConvertFrom-Json -InputObject $ReleasePlanJson -AsHashtable
if ($releasePlan -isnot [System.Collections.IDictionary]) {
    throw 'Release plan metadata must be a JSON object.'
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
        throw 'Each API version must have a nonempty string version.'
    }
    $value = Format-CodeSpan $entry['version']
    if ($null -ne $entry['namespace']) {
        if ($entry['namespace'] -isnot [string]) {
            throw 'An API version namespace must be a string.'
        }
        if ($entry['namespace']) {
            $value += " (Namespace: $(Format-CodeSpan $entry['namespace']))"
        }
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

if ($releasePlan['url']) {
    if ($releasePlan['url'] -isnot [string]) {
        throw 'The release plan URL must be a string.'
    }
    $releasePlanUrl = Format-MarkdownUrl $releasePlan['url']
    $releasePlanId = Get-QueryParameter $releasePlan['url'] 'releaseplan'
    $releasePlanLabel = if ($releasePlanId) { "Release plan #$(Format-LinkLabel $releasePlanId)" } else { 'Open release plan' }
    $rows.Add("| **Release plan** | [$releasePlanLabel]($releasePlanUrl) |")
}
if ($releasePlan['submittedBy']) {
    if ($releasePlan['submittedBy'] -isnot [string]) {
        throw 'The release plan submitter must be a string.'
    }
    $rows.Add("| **Submitted by** | $(Format-CodeSpan $releasePlan['submittedBy']) |")
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
