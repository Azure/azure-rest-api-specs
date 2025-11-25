#!/usr/bin/env pwsh
<#
.SYNOPSIS
    批量修复TypeSpec文件中的错误类型，将ARM模板的默认ErrorResponse改为CloudError

.DESCRIPTION
    扫描所有.tsp文件，查找使用ARM标准模板但未指定Error参数的操作，
    自动添加 Error = CloudError 参数以匹配旧swagger的CloudError类型。

.NOTES
    处理的ARM模板包括:
    - ArmListBySubscription
    - ArmResourceListByParent
    - ArmProviderActionSync
    - ArmProviderActionAsync
    - ArmResourceActionAsync
    - ArmResourceActionSync
    - 等其他Arm*模板
#>

param(
    [string]$Path = ".",
    [switch]$DryRun = $false,
    [switch]$Verbose = $false
)

# 统计信息
$script:TotalFiles = 0
$script:ModifiedFiles = 0
$script:TotalReplacements = 0

# 需要处理的ARM模板模式（不区分大小写）
$armTemplatePatterns = @(
    'ArmListBySubscription',
    'ArmResourceListByParent',
    'ArmProviderActionSync',
    'ArmProviderActionAsync',
    'ArmResourceActionAsync',
    'ArmResourceActionSync',
    'ArmResourceActionAsyncBase',
    'ArmResourceCreateOrReplaceAsync',
    'ArmResourceCreateOrReplaceSync',
    'ArmResourceCreateOrUpdateAsync',
    'ArmResourceCreateOrUpdateSync',
    'ArmResourceDeleteWithoutOkAsync',
    'ArmResourceDeleteAsync',
    'ArmResourceDeleteSync',
    'ArmResourceRead',
    'ArmCustomPatchAsync',
    'ArmCustomPatchSync',
    'ArmResourcePatchAsync',
    'ArmResourcePatchSync'
)

function Write-Info {
    param([string]$Message)
    Write-Host $Message -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host $Message -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host $Message -ForegroundColor Yellow
}

function Write-Detail {
    param([string]$Message)
    if ($Verbose) {
        Write-Host "  $Message" -ForegroundColor Gray
    }
}

function Fix-ErrorTypeInTemplate {
    param(
        [string]$FilePath,
        [string]$Content
    )
    
    $modified = $false
    $newContent = $Content
    $replacements = 0
    
    foreach ($template in $armTemplatePatterns) {
        # 匹配模式：
        # 1. 模板名称后跟 <
        # 2. 可能有多行参数
        # 3. 以 > 或 >; 结束
        # 4. 不包含 Error = 或 OverrideErrorType = 
        
        # 简单模式：单行的 ArmTemplate<Type>; 或 ArmTemplate<Type>
        $pattern1 = "(?i)\b$template\s*<\s*([^>]+)\s*>\s*;"
        
        if ($newContent -match $pattern1) {
            $matches = [regex]::Matches($newContent, $pattern1)
            foreach ($match in $matches) {
                $fullMatch = $match.Value
                
                # 检查是否已经有Error参数
                if ($fullMatch -notmatch '\bError\s*=' -and $fullMatch -notmatch '\bOverrideErrorType\s*=') {
                    # 检查是否是简单的单参数模板
                    $innerContent = $match.Groups[1].Value.Trim()
                    
                    # 构造新的模板调用
                    $newTemplate = "$template<$innerContent, Error = CloudError>;"
                    
                    # 替换
                    $oldPattern = [regex]::Escape($fullMatch)
                    $newContent = $newContent -replace $oldPattern, $newTemplate
                    
                    $replacements++
                    $modified = $true
                    
                    Write-Detail "已修复: $($match.Value.Substring(0, [Math]::Min(60, $match.Value.Length)))..."
                }
            }
        }
        
        # 复杂模式：多行的模板调用
        $pattern2 = "(?smi)\b$template\s*<\s*([^>]+?)>"
        
        if ($newContent -match $pattern2) {
            $matches = [regex]::Matches($newContent, $pattern2)
            foreach ($match in $matches) {
                $fullMatch = $match.Value
                
                # 检查是否已经有Error参数
                if ($fullMatch -notmatch '\bError\s*=' -and $fullMatch -notmatch '\bOverrideErrorType\s*=') {
                    $innerContent = $match.Groups[1].Value.Trim()
                    
                    # 判断是否需要添加逗号
                    $needsComma = $innerContent -match '\S'
                    
                    if ($needsComma) {
                        # 检查最后是否已经有逗号
                        if ($innerContent -notmatch ',\s*$') {
                            $newTemplate = "$template<$innerContent, Error = CloudError>"
                        } else {
                            $newTemplate = "$template<$innerContent Error = CloudError>"
                        }
                    } else {
                        $newTemplate = "$template<Error = CloudError>"
                    }
                    
                    # 使用精确匹配替换
                    $oldPattern = [regex]::Escape($fullMatch)
                    $newContent = $newContent -replace $oldPattern, $newTemplate
                    
                    $replacements++
                    $modified = $true
                    
                    Write-Detail "已修复多行模板: $template"
                }
            }
        }
    }
    
    if ($modified) {
        $script:TotalReplacements += $replacements
        Write-Success "  - 修改了 $replacements 处"
        
        if (-not $DryRun) {
            Set-Content -Path $FilePath -Value $newContent -Encoding UTF8 -NoNewline
            Write-Success "  - 已保存: $FilePath"
        } else {
            Write-Warning "  - [DRY RUN] 跳过保存: $FilePath"
        }
        
        return $true
    }
    
    return $false
}

function Process-TspFiles {
    param([string]$RootPath)
    
    Write-Info "`n开始扫描TypeSpec文件..."
    Write-Info "路径: $RootPath"
    
    $tspFiles = Get-ChildItem -Path $RootPath -Filter "*.tsp" -Recurse -File
    $script:TotalFiles = $tspFiles.Count
    
    Write-Info "找到 $($script:TotalFiles) 个 .tsp 文件`n"
    
    foreach ($file in $tspFiles) {
        Write-Info "处理: $($file.Name)"
        
        $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
        
        if (Fix-ErrorTypeInTemplate -FilePath $file.FullName -Content $content) {
            $script:ModifiedFiles++
        } else {
            Write-Detail "  - 未发现需要修改的内容"
        }
    }
}

# 主执行流程
Write-Host "`n========================================" -ForegroundColor Magenta
Write-Host "TypeSpec 错误类型批量修复工具" -ForegroundColor Magenta
Write-Host "========================================`n" -ForegroundColor Magenta

if ($DryRun) {
    Write-Warning "*** DRY RUN 模式 - 不会实际修改文件 ***`n"
}

# 开始处理
Process-TspFiles -RootPath $Path

# 输出统计
Write-Host "`n========================================" -ForegroundColor Magenta
Write-Host "处理完成" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Info "总文件数: $script:TotalFiles"
Write-Success "修改文件数: $script:ModifiedFiles"
Write-Success "总替换次数: $script:TotalReplacements"

if ($DryRun) {
    Write-Warning "`n这是DRY RUN模式的结果，文件未实际修改"
    Write-Warning "移除 -DryRun 参数以实际应用更改"
}

Write-Host ""
