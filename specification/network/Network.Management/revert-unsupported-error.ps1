param(
    [switch]$DryRun
)

# 设置输出编码
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# 不支持 Error 参数的模板/类型列表
$unsupportedPatterns = @(
    "ArmResponse<",
    "ResourceListResult<",
    "ArmLroLocationHeader<",
    "ArmAsyncOperationHeader<",
    "DefaultBaseParameters<",
    "ArmResourceUpdatedResponse<",
    "ArmResourceCreatedResponse<",
    "ArmDeletedNoContentResponse",
    "ArmAcceptedLroResponse",
    "RetryAfterHeader"
)

function Remove-UnsupportedError {
    param(
        [string]$filePath
    )
    
    $content = Get-Content -Path $filePath -Raw -Encoding UTF8
    $originalContent = $content
    $changes = 0
    
    foreach ($pattern in $unsupportedPatterns) {
        # 移除这些类型中的 Error = CloudError 参数
        # 处理多行情况
        $regex = [regex]::new(
            "($([regex]::Escape($pattern))(?:(?!>).)*?),\s*Error\s*=\s*CloudError\s*([>,])",
            [System.Text.RegularExpressions.RegexOptions]::Singleline -bor
            [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor
            [System.Text.RegularExpressions.RegexOptions]::Multiline
        )
        
        $matches = $regex.Matches($content)
        if ($matches.Count -gt 0) {
            $content = $regex.Replace($content, '$1$2')
            $changes += $matches.Count
            Write-Host "  移除 $pattern 中的 Error 参数: $($matches.Count) 处" -ForegroundColor Yellow
        }
    }
    
    if ($changes -gt 0) {
        if (-not $DryRun) {
            Set-Content -Path $filePath -Value $content -Encoding UTF8 -NoNewline
            Write-Host "  ✓ 已保存: $($filePath | Split-Path -Leaf)" -ForegroundColor Green
        } else {
            Write-Host "  [DRY RUN] 跳过保存: $($filePath | Split-Path -Leaf)" -ForegroundColor Cyan
        }
    }
    
    return $changes
}

# 主程序
Write-Host "`n===== 回退不支持的 Error 参数 =====" -ForegroundColor Cyan

$tspFiles = Get-ChildItem -Path "." -Filter "*.tsp" -Recurse | Where-Object { 
    $_.FullName -notlike "*\node_modules\*" 
}

$totalChanges = 0
$modifiedFiles = 0

foreach ($file in $tspFiles) {
    $changes = Remove-UnsupportedError -filePath $file.FullName
    if ($changes -gt 0) {
        Write-Host "处理: $($file.Name)" -ForegroundColor White
        $totalChanges += $changes
        $modifiedFiles++
    }
}

Write-Host "`n===== 统计 =====" -ForegroundColor Cyan
Write-Host "总文件数: $($tspFiles.Count)" -ForegroundColor White
Write-Host "修改文件数: $modifiedFiles" -ForegroundColor Yellow
Write-Host "总回退数: $totalChanges" -ForegroundColor Green

if ($DryRun) {
    Write-Host "`n这是 DRY RUN 模式,没有实际修改文件" -ForegroundColor Magenta
}
