param(
    [switch]$DryRun
)

# 设置输出编码
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# 需要添加 OverrideErrorType = CloudError 的Provider操作模板列表
$providerTemplates = @(
    "ArmProviderActionSync",
    "ArmProviderActionAsync"
)

function Fix-ProviderOperationError {
    param(
        [string]$filePath
    )
    
    $content = Get-Content -Path $filePath -Raw -Encoding UTF8
    $originalContent = $content
    $changes = 0
    
    foreach ($template in $providerTemplates) {
        # 匹配模式: ArmProviderActionSync<...Response = ...> 但没有 OverrideErrorType
        $pattern = "($template\s*<[^>]*Response\s*=[^>]*?)(\s*>)"
        
        $regex = [regex]::new($pattern, 
            [System.Text.RegularExpressions.RegexOptions]::Singleline -bor
            [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor
            [System.Text.RegularExpressions.RegexOptions]::Multiline
        )
        
        $matches = $regex.Matches($content)
        
        foreach ($match in $matches) {
            # 检查是否已经有 OverrideErrorType
            if ($match.Groups[1].Value -notmatch "OverrideErrorType\s*=") {
                # 添加 OverrideErrorType = CloudError
                $oldText = $match.Value
                $newText = $match.Groups[1].Value + ",`n    OverrideErrorType = CloudError" + $match.Groups[2].Value
                
                $content = $content.Replace($oldText, $newText)
                $changes++
                Write-Host "  已修复: $template<...> (#$changes)" -ForegroundColor Yellow
            }
        }
    }
    
    if ($changes -gt 0) {
        if (-not $DryRun) {
            Set-Content -Path $filePath -Value $content -Encoding UTF8 -NoNewline
            Write-Host "  ✓ 已保存: $($filePath | Split-Path -Leaf) ($changes 处)" -ForegroundColor Green
        } else {
            Write-Host "  [DRY RUN] 跳过保存: $($filePath | Split-Path -Leaf) ($changes 处)" -ForegroundColor Cyan
        }
    }
    
    return $changes
}

# 主程序
Write-Host "`n===== 修复 Provider 操作的 Error 类型 =====" -ForegroundColor Cyan

$tspFiles = Get-ChildItem -Path "." -Filter "*.tsp" -Recurse | Where-Object { 
    $_.FullName -notlike "*\node_modules\*" 
}

$totalChanges = 0
$modifiedFiles = 0

foreach ($file in $tspFiles) {
    $changes = Fix-ProviderOperationError -filePath $file.FullName
    if ($changes -gt 0) {
        Write-Host "处理: $($file.Name)" -ForegroundColor White
        $totalChanges += $changes
        $modifiedFiles++
    }
}

Write-Host "`n===== 统计 =====" -ForegroundColor Cyan
Write-Host "总文件数: $($tspFiles.Count)" -ForegroundColor White
Write-Host "修改文件数: $modifiedFiles" -ForegroundColor Yellow
Write-Host "总修改数: $totalChanges" -ForegroundColor Green

if ($DryRun) {
    Write-Host "`n这是 DRY RUN 模式,没有实际修改文件" -ForegroundColor Magenta
}
