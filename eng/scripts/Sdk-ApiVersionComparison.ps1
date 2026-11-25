function ConvertTo-ApiVersionSet($Entries) {
    if ($Entries -isnot [array]) {
        return $null
    }
    $values = [System.Collections.Generic.SortedDictionary[string, object]]::new([StringComparer]::Ordinal)
    foreach ($entry in $Entries) {
        if ($entry -isnot [System.Collections.IDictionary] -or
            $entry['version'] -isnot [string] -or [string]::IsNullOrWhiteSpace($entry['version']) -or
            ($null -ne $entry['namespace'] -and $entry['namespace'] -isnot [string])) {
            return $null
        }
        $normalized = [ordered]@{ namespace = [string]$entry['namespace']; version = $entry['version'] }
        $key = ConvertTo-Json -InputObject $normalized -Compress
        $values[$key] = $normalized
    }
    return @{ entries = @($values.Values); signature = (ConvertTo-Json -InputObject @($values.Keys) -Compress) }
}

function Read-ApiVersionComparison($Body) {
    $unknown = @{ current = $null; warning = $null; unresolved = $false }
    $matches = [regex]::Matches($Body, '<!-- azsdk-api-version-comparison:v1:([A-Za-z0-9+/=]+) -->')
    if ($matches.Count -eq 1) {
        try {
            $json = [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($matches[0].Groups[1].Value))
            $state = ConvertFrom-Json -InputObject $json -AsHashtable -NoEnumerate
            if ($state -isnot [System.Collections.IDictionary] -or $state['schemaVersion'] -ne 1 -or
                $state['unresolved'] -isnot [bool] -or -not $state.Contains('current') -or -not $state.Contains('warning')) {
                throw 'Invalid comparison state.'
            }
            $current = ConvertTo-ApiVersionSet $state['current']
            if ($null -ne $state['current'] -and $null -eq $current) {
                throw 'Invalid current snapshot.'
            }
            $warning = $null
            if ($null -ne $state['warning']) {
                if ($state['warning'] -isnot [System.Collections.IDictionary]) {
                    throw 'Invalid warning snapshot.'
                }
                $previous = ConvertTo-ApiVersionSet $state['warning']['previous']
                $lastCurrent = ConvertTo-ApiVersionSet $state['warning']['current']
                if ($null -eq $previous -or $null -eq $lastCurrent -or $previous.signature -ceq $lastCurrent.signature) {
                    throw 'Invalid warning snapshots.'
                }
                $warning = @{ previous = $previous; current = $lastCurrent }
            }
            return @{ current = $current; warning = $warning; unresolved = $state['unresolved'] }
        }
        catch {
            Write-MetadataWarning 'Previous API Versions comparison state is malformed; comparison is unavailable.'
            $unknown.unresolved = $true
            return $unknown
        }
    }
    if ($Body.Contains('azsdk-api-version-comparison:') -or $Body.Contains('azsdk-api-version-warning:')) {
        $unknown.unresolved = $true
        return $unknown
    }

    # Older tables did not record metadata completeness, so they cannot prove a baseline.
    return $unknown
}

function Format-ApiVersionChanges($Previous, $Current) {
    $previousGroups = [System.Collections.Generic.Dictionary[string, object]]::new([StringComparer]::Ordinal)
    $currentGroups = [System.Collections.Generic.Dictionary[string, object]]::new([StringComparer]::Ordinal)
    $namespaces = [System.Collections.Generic.SortedSet[string]]::new([StringComparer]::Ordinal)
    foreach ($pair in @(@{ snapshot = $Previous; groups = $previousGroups }, @{ snapshot = $Current; groups = $currentGroups })) {
        foreach ($entry in $pair.snapshot.entries) {
            $namespace = $entry['namespace']
            [void]$namespaces.Add($namespace)
            if (-not $pair.groups.ContainsKey($namespace)) {
                $pair.groups[$namespace] = [System.Collections.Generic.List[string]]::new()
            }
            $pair.groups[$namespace].Add($entry['version'])
        }
    }
    @(
        '<!-- azsdk-api-version-warning:v1:start -->'
        '> [!WARNING]'
        '> **API Versions changed during regeneration.**'
        '>'
        '> Review the changes below. If unintended, create a spec PR that sets the intended API version in `tspconfig.yaml`. Merging that PR will trigger SDK regeneration.'
        ''
        '| Namespace | Previous API Versions | Current API Versions |'
        '| :--- | :--- | :--- |'
        foreach ($namespace in $namespaces) {
            $previousValues = @(if ($previousGroups.ContainsKey($namespace)) { $previousGroups[$namespace] })
            $currentValues = @(if ($currentGroups.ContainsKey($namespace)) { $currentGroups[$namespace] })
            if ((ConvertTo-Json -InputObject @($previousValues) -Compress) -ceq (ConvertTo-Json -InputObject @($currentValues) -Compress)) {
                continue
            }
            $label = if ($namespace) { Format-CodeSpan $namespace } else { 'Namespace not reported' }
            $previousCell = if ($previousValues.Count) { ($previousValues | ForEach-Object { Format-CodeSpan $_ }) -join '<br>' } else { 'Not present' }
            $currentCell = if ($currentValues.Count) { ($currentValues | ForEach-Object { Format-CodeSpan $_ }) -join '<br>' } else { 'Not present' }
            "| $label | $previousCell | $currentCell |"
        }
        '<!-- azsdk-api-version-warning:v1:end -->'
    ) -join "`n"
}

function New-ApiVersionComparison($Entries, [bool]$Complete, [string]$PreviousBody, [string]$PreviousPullRequestState) {
    $current = if ($Complete) { ConvertTo-ApiVersionSet $Entries } else { $null }
    $previous = @{ current = $null; warning = $null; unresolved = $false }
    if ($PreviousPullRequestState -eq 'existing') {
        $previous = Read-ApiVersionComparison $PreviousBody
    } elseif ($PreviousPullRequestState -ne 'new') {
        $previous.unresolved = $true
    }
    $warning = $previous.warning
    $diagnostic = ''
    # A new PR has nothing to compare, so incomplete metadata only affects its stored snapshot.
    if ($PreviousPullRequestState -ne 'new' -and
        ($null -eq $current -or $previous.unresolved -or ($null -eq $previous.current -and $null -eq $warning))) {
        $diagnostic = 'API Versions comparison unavailable: complete previous and current generated metadata could not be verified. Any earlier API Versions warning remains unresolved.'
    }
    if ($null -ne $current -and -not $previous.unresolved) {
        $baseline = if ($null -ne $warning) { $warning.previous } else { $previous.current }
        if ($null -ne $baseline) {
            $warning = if ($baseline.signature -ceq $current.signature) { $null } else { @{ previous = $baseline; current = $current } }
        }
    }
    $warningText = ''
    if ($null -ne $warning) {
        $warningText = Format-ApiVersionChanges $warning.previous $warning.current
    } elseif ($previous.unresolved) {
        $retained = [regex]::Matches($PreviousBody, '(?s)<!-- azsdk-api-version-warning:v1:start -->.*?<!-- azsdk-api-version-warning:v1:end -->')
        if ($retained.Count -eq 1) {
            $warningText = $retained[0].Value
        }
    }
    if ($diagnostic) {
        if ($warningText) {
            $diagnostic += ' The API Versions warning above shows the last verified comparison.'
        }
        Write-MetadataWarning $diagnostic
    }
    $state = [ordered]@{
        schemaVersion = 1
        current = $null
        warning = $(if ($null -ne $warning) { [ordered]@{ previous = $warning.previous.entries; current = $warning.current.entries } } else { $null })
        unresolved = $previous.unresolved
    }
    if ($null -ne $current) {
        $state.current = @($current.entries)
    }
    # Base64 keeps arbitrary version/namespace strings out of HTML comment syntax.
    $encoded = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes((ConvertTo-Json -InputObject $state -Compress -Depth 10)))
    $header = if ($warningText) { "$warningText`n" } else { '' }
    # Only existing PRs can carry the label. Unknown comparisons leave it unchanged.
    $labelAction = 'none'
    if ($PreviousPullRequestState -eq 'existing') {
        if ($null -ne $warning) {
            $labelAction = 'add'
        } elseif (-not $diagnostic) {
            $labelAction = 'remove'
        }
    }
    return @{
        header = $header
        note = $diagnostic
        metadata = "<!-- azsdk-api-version-comparison:v1:$encoded -->"
        hasChanges = ($null -ne $warning)
        labelAction = $labelAction
    }
}
