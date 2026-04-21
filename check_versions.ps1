$scriptPath = 'specification\monitor\outputFolder\run-tsmv-monitor.ps1'
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
        $match = $sourceVersions -contains $targetVersion
        [PSCustomObject]@{
            SourceFolder = Split-Path $sourceDir -Leaf
            SourceVersions = ($sourceVersions -join ', ')
            TargetVersion = $targetVersion
            Result = if ($match) { '匹配' } else { '不一致' }
            Note = if (-not $match) { ($sourceVersions -join ', ') } else { '' }
        }
    }
}
$results | Format-Table -AutoSize
Write-Host "汇总:"
Write-Host "总命令数: $($results.Count)"
Write-Host "匹配数: $(($results | Where-Object { $_.Result -eq '匹配' }).Count)"
Write-Host "不一致数: $(($results | Where-Object { $_.Result -eq '不一致' }).Count)"
if ($results | Where-Object { $_.Result -eq '不一致' }) {
    Write-Host "不一致项列表:"
    $results | Where-Object { $_.Result -eq '不一致' } | Select-Object SourceFolder, SourceVersions, TargetVersion | Format-Table -AutoSize
}
