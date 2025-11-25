# 为 ArmProviderActionSync/Async 操作添加 Error = CloudError 参数

$file = "routes.tsp"
$lines = Get-Content $file

$modified = $false
$inProviderOp = $false
$bracketCount = 0
$opStartLine = 0

for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    
    # 检测 Provider 操作的开始
    if ($line -match 'is\s+ArmProviderAction(Sync|Async)<') {
        $inProviderOp = $true
        $opStartLine = $i
        $bracketCount = 1
        continue
    }
    
    if ($inProviderOp) {
        # 计算括号数量
        $bracketCount += ($line.ToCharArray() | Where-Object { $_ -eq '<' }).Count
        $bracketCount -= ($line.ToCharArray() | Where-Object { $_ -eq '>' }).Count
        
        # 找到闭合的 >
        if ($bracketCount -eq 0) {
            # 检查操作是否已经有 Error 参数
            $opContent = ($lines[$opStartLine..$i] -join "`n")
            if ($opContent -notmatch 'Error\s*=') {
                # 在当前行(包含 >)之前插入 Error 参数和逗号
                $prevLine = $lines[$i-1]
                if ($prevLine -notmatch ',\s*$') {
                    # 上一行没有逗号,需要添加
                    $lines[$i-1] = $prevLine + ','
                }
                $indent = $line -replace '^(\s*).*', '$1'
                $lines[$i] = "$indent  Error = CloudError`n" + $line
                $modified = $true
                Write-Host "✓ 第 $($i+1) 行: 添加 Error = CloudError" -ForegroundColor Cyan
            }
            $inProviderOp = $false
        }
    }
}

if ($modified) {
    $content = $lines -join "`n"
    Set-Content $file $content -NoNewline
    Write-Host "`n✓ 修复完成" -ForegroundColor Green
} else {
    Write-Host "✓ 所有 Provider 操作都已正确配置 Error 参数" -ForegroundColor Yellow
}
