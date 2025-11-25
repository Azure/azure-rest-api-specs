# 为所有delete操作添加 Error = CloudError

$files = Get-ChildItem -Path . -Filter "*.tsp" -Recurse -Exclude "main.tsp","client.tsp"

$count = 0

foreach ($file in $files) {
    $lines = Get-Content $file.FullName
    $modified = $false
    
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        
        # 检查是否是delete操作且没有Error参数
        if ($line -match '^\s*delete is ArmResourceDelete' -and $line -notmatch 'Error\s*=') {
            # 情况1: 单行格式 delete is Template<Resource>;
            if ($line -match '>\s*;') {
                $lines[$i] = $line -replace '>', ', Error = CloudError>'
                $modified = $true
                $count++
                Write-Host "修复 $($file.Name):$($i+1) (单行)" -ForegroundColor Green
            }
            # 情况2: 多行格式，查找下一行
            elseif ($i + 1 -lt $lines.Count) {
                $nextLine = $lines[$i + 1]
                
                # 如果下一行是 Response = ... 或 Parameters = ...
                if ($nextLine -match '^\s+(Response|Parameters)\s*=') {
                    # 查找这个多行操作的结束位置 (>;)
                    for ($j = $i + 1; $j -lt $lines.Count; $j++) {
                        if ($lines[$j] -match '>\s*;') {
                            # 在>; 之前添加 Error = CloudError
                            $lines[$j] = $lines[$j] -replace '(\s*)>\s*;', ',${1}  Error = CloudError>;'
                            $modified = $true
                            $count++
                            Write-Host "修复 $($file.Name):$($j+1) (多行)" -ForegroundColor Green
                            break
                        }
                    }
                }
            }
        }
    }
    
    if ($modified) {
        Set-Content -Path $file.FullName -Value $lines
    }
}

Write-Host "`n✓ 总计修复: $count 个delete操作" -ForegroundColor Cyan
