# 为所有ARM操作添加 Error = CloudError

$files = Get-ChildItem -Path . -Filter "*.tsp" -Recurse | Where-Object { $_.Name -ne "main.tsp" -and $_.Name -ne "client.tsp" }

$templates = @(
    "ArmResourceDeleteWithoutOkAsync",
    "ArmResourceDeleteAsync",
    "ArmResourceDeleteSync",
    "ArmResourceCreateOrReplaceAsync",
    "ArmResourceCreateOrReplaceSync",
    "ArmResourceCreateOrUpdateAsync",
    "ArmResourceCreateOrUpdateSync",
    "ArmResourceRead",
    "ArmResourceListByParent",
    "ArmResourceActionAsync",
    "ArmResourceActionSync",
    "ArmCustomPatchAsync",
    "ArmCustomPatchSync",
    "ArmTagsPatchAsync",
    "ArmTagsPatchSync"
)

$count = 0
$fileCount = 0

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    $fileModified = $false
    
    foreach ($template in $templates) {
        # 模式1: 单行格式，模板结束于 >; - 在 > 之前添加
        $pattern1 = "(\b$template<[^>]+?)(\s*>\s*;)"
        if ($content -match $pattern1) {
            # 检查是否已经有 Error 参数
            $matches = [regex]::Matches($content, $pattern1)
            foreach ($match in $matches) {
                if ($match.Groups[1].Value -notmatch '\bError\s*=') {
                    $replacement = $match.Groups[1].Value + ",`n    Error = CloudError" + $match.Groups[2].Value
                    $content = $content.Replace($match.Value, $replacement)
                    $count++
                    $fileModified = $true
                    Write-Host "修复: $($file.Name) - $template (单行)" -ForegroundColor Green
                }
            }
        }
        
        # 模式2: 多行格式，参数在下一行 - 在最后一个参数后添加
        # 匹配模式: template<...,\n  Parameters = {...}\n>
        $pattern2 = "(\b$template<[^>]*?Parameters\s*=\s*\{[^}]*?\}\s*)(\n\s*>\s*;)"
        if ($content -match $pattern2) {
            $matches = [regex]::Matches($content, $pattern2)
            foreach ($match in $matches) {
                if ($match.Groups[1].Value -notmatch '\bError\s*=') {
                    $replacement = $match.Groups[1].Value + ",`n    Error = CloudError" + $match.Groups[2].Value
                    $content = $content.Replace($match.Value, $replacement)
                    $count++
                    $fileModified = $true
                    Write-Host "修复: $($file.Name) - $template (多行Parameters)" -ForegroundColor Green
                }
            }
        }
        
        # 模式3: 多行格式，Response参数 - 在 Response 后添加
        $pattern3 = "(\b$template<[^>]*?Response\s*=\s*[^,\n>]+)(\s*\n\s*>\s*;)"
        if ($content -match $pattern3) {
            $matches = [regex]::Matches($content, $pattern3)
            foreach ($match in $matches) {
                if ($match.Groups[1].Value -notmatch '\bError\s*=') {
                    $replacement = $match.Groups[1].Value + ",`n    Error = CloudError" + $match.Groups[2].Value
                    $content = $content.Replace($match.Value, $replacement)
                    $count++
                    $fileModified = $true
                    Write-Host "修复: $($file.Name) - $template (多行Response)" -ForegroundColor Green
                }
            }
        }
    }
    
    if ($fileModified) {
        Set-Content -Path $file.FullName -Value $content -NoNewline
        $fileCount++
    }
}

Write-Host "`n✓ 总计修复: $count 处操作" -ForegroundColor Cyan
Write-Host "✓ 修改文件: $fileCount 个" -ForegroundColor Cyan
