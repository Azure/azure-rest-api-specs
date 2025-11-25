# 为Legacy Operations中使用DeleteWithoutOkAsync, CreateOrUpdateAsync等的操作添加 Error = CloudError

$files = Get-ChildItem -Path . -Filter "*.tsp" -Recurse -Exclude "main.tsp","client.tsp"

$count = 0
$templates = @(
    "DeleteWithoutOkAsync",
    "CreateOrUpdateAsync",
    "CreateOrUpdateSync",
    "UpdateAsync",
    "ReadAsync",
    "ListAsync"
)

foreach ($file in $files) {
    $lines = Get-Content $file.FullName
    $modified = $false
    
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        
        # 查找 Ops.TemplateXxx< 模式且没有Error参数
        foreach ($template in $templates) {
            if ($line -match "Ops\.$template<" -and $line -notmatch 'Error\s*=') {
                # 查找这个操作的结束位置
                $bracketCount = 0
                $startFound = $false
                
                for ($j = $i; $j -lt $lines.Count; $j++) {
                    $currentLine = $lines[$j]
                    
                    # 计数<和>
                    $openCount = ($currentLine.ToCharArray() | Where-Object { $_ -eq '<' }).Count
                    $closeCount = ($currentLine.ToCharArray() | Where-Object { $_ -eq '>' }).Count
                    
                    if ($openCount -gt 0) { $startFound = $true }
                    if ($startFound) {
                        $bracketCount += $openCount
                        $bracketCount -= $closeCount
                    }
                    
                    # 当找到闭合的>时
                    if ($startFound -and $bracketCount -eq 0 -and $currentLine -match '>') {
                        # 在>;之前添加Error = CloudError
                        if ($currentLine -match '^\s*>') {
                            # Response在前一行，在>前添加逗号和Error
                            $lines[$j] = $currentLine -replace '(\s*)>\s*;', ',${1}  Error = CloudError>;'
                        } else {
                            # Response在同一行
                            $lines[$j] = $currentLine -replace '(\S)(\s*)>\s*;', '$1,$2  Error = CloudError>;'
                        }
                        $modified = $true
                        $count++
                        Write-Host "修复 $($file.Name):$($j+1) - $template" -ForegroundColor Green
                        break
                    }
                }
            }
        }
    }
    
    if ($modified) {
        Set-Content -Path $file.FullName -Value $lines
    }
}

Write-Host "`n✓ 总计修复: $count 个Legacy Operations操作" -ForegroundColor Cyan
