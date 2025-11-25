# 为所有缺少Error参数的delete操作添加 Error = CloudError

$files = Get-ChildItem -Path . -Filter "*.tsp" -Recurse | Where-Object { $_.Name -ne "main.tsp" -and $_.Name -ne "client.tsp" }

$count = 0
$fileCount = 0

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    $fileModified = $false
    
    # 查找所有delete操作且没有Error参数的
    $deleteTemplates = @(
        "ArmResourceDeleteWithoutOkAsync",
        "ArmResourceDeleteAsync",
        "ArmResourceDeleteSync"
    )
    
    foreach ($template in $deleteTemplates) {
        # 匹配: delete is Template<Resource, 但没有 Error =
        $pattern = "(delete is $template<[^,>]+)(,\s*\n\s*)>"
        
        if ($content -match $pattern) {
            $matches = [regex]::Matches($content, $pattern)
            foreach ($match in $matches) {
                # 检查这个匹配中是否已经有Error参数
                $fullMatch = $match.Value
                if ($fullMatch -notmatch '\bError\s*=') {
                    # 在 > 之前添加 Error = CloudError
                    $replacement = $match.Groups[1].Value + $match.Groups[2].Value + "Error = CloudError>"
                    $content = $content.Replace($match.Value, $replacement)
                    $count++
                    $fileModified = $true
                    Write-Host "修复: $($file.Name) - delete操作" -ForegroundColor Green
                }
            }
        }
        
        # 匹配单行格式: delete is Template<Resource>
        $patternSingle = "(delete is $template<[^>]+)>"
        if ($content -match $patternSingle) {
            $matches = [regex]::Matches($content, $patternSingle)
            foreach ($match in $matches) {
                if ($match.Value -notmatch '\bError\s*=' -and $match.Value -notmatch ',\s*\n') {
                    $replacement = $match.Groups[1].Value + ", Error = CloudError>"
                    $content = $content.Replace($match.Value, $replacement)
                    $count++
                    $fileModified = $true
                    Write-Host "修复: $($file.Name) - delete操作(单行)" -ForegroundColor Green
                }
            }
        }
    }
    
    if ($fileModified) {
        Set-Content -Path $file.FullName -Value $content -NoNewline
        $fileCount++
    }
}

Write-Host "`n✓ 总计修复: $count 个delete操作" -ForegroundColor Cyan
Write-Host "✓ 修改文件: $fileCount 个" -ForegroundColor Cyan
