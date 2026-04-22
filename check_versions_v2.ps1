$scriptPath = 'specification/monitor/outputFolder/run-tsmv-monitor.ps1'
$lines = Get-Content $scriptPath | Where-Object { $_.Trim().StartsWith('npx tsmv') }
$results = foreach ($line in $lines) {
    if ($line -match 'npx tsmv\s+"([^"]+)"\s+"([^"]+)"') {
        $sourceDir = $Matches[1]
        $targetFile = $Matches[2]
        $targetVersion = Split-Path (Split-Path $targetFile -Parent) -Leaf
        $sourceVersions = @()
        if (Test-Path $sourceDir) {
            $files = Get-ChildItem -Path $sourceDir -Filter "*.json" -File
            foreach ($f in $files) {
                try {
                    $data = Get-Content $f.FullName -Raw | ConvertFrom-Json
                    if ($data.info.version) { $sourceVersions += $data.info.version }
                } catch {}
            }
        }
        $sourceVersions = $sourceVersions | Select-Object -Unique | Sort-Object
        $isMatch = $sourceVersions -contains $targetVersion
        [PSCustomObject]@{
            SourceFolder = Split-Path $sourceDir -Leaf
            SourceVersions = ($sourceVersions -join ', ')
            TargetVersion = $targetVersion
            Match = $isMatch
        }
    }
}
$results | Select-Object SourceFolder, SourceVersions, TargetVersion, @{N='Result';E={if($_.Match){'Match'}else{'Mismatch'}}} | Format-Table -AutoSize
$total = $results.Count
$matched = ($results | Where-Object { $_.Match }).Count
$mismatched = $total - $matched
Write-Host "
Summary:"
Write-Host "Total commands: $total"
Write-Host "Matched: $matched"
Write-Host "Mismatched: $mismatched"
if ($mismatched -gt 0) {
    Write-Host "
Mismatched items:"
    $results | Where-Object { -not $_.Match } | Select-Object SourceFolder, SourceVersions, TargetVersion | Format-Table -AutoSize
}