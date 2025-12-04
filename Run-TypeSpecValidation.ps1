#!/usr/bin/env pwsh
<#
.SYNOPSIS
    运行 TypeSpec 验证并记录所有错误

.DESCRIPTION
    此脚本会遍历 specification 目录下的所有 TypeSpec 项目，
    对每个项目运行 tsv 验证，并将所有错误记录到日志文件中。

.PARAMETER OutputPath
    输出日志文件的路径，默认为当前目录下的 tsv-validation-results.log

.PARAMETER SpecificationPath
    specification 目录的路径，默认为脚本所在仓库的 specification 目录

.PARAMETER Pattern
    搜索 TypeSpec 项目的通配符模式，默认为 "**/tspconfig.yaml"

.PARAMETER ContinueOnError
    是否在遇到错误时继续运行，默认为 $true

.EXAMPLE
    .\Run-TypeSpecValidation.ps1
    
.EXAMPLE
    .\Run-TypeSpecValidation.ps1 -OutputPath "validation-errors.log"
    
.EXAMPLE
    .\Run-TypeSpecValidation.ps1 -SpecificationPath ".\specification" -ContinueOnError $false
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$OutputPath = "tsv-validation-results.log",
    
    [Parameter(Mandatory = $false)]
    [string]$SpecificationPath,
    
    [Parameter(Mandatory = $false)]
    [string]$Pattern = "**/tspconfig.yaml",
    
    [Parameter(Mandatory = $false)]
    [bool]$ContinueOnError = $true
)

# 设置错误操作首选项
$ErrorActionPreference = "Continue"

# 获取脚本所在目录
$scriptRoot = Split-Path -Parent $PSCommandPath
if (-not $SpecificationPath) {
    $SpecificationPath = Join-Path $scriptRoot "specification"
}

# 验证路径是否存在
if (-not (Test-Path $SpecificationPath)) {
    Write-Error "Specification 目录不存在: $SpecificationPath"
    exit 1
}

# 初始化结果统计
$totalProjects = 0
$successCount = 0
$errorCount = 0
$skippedCount = 0
$errorDetails = @()

# 创建或清空输出日志文件
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$logHeader = @"
================================================================
TypeSpec 验证报告
================================================================
开始时间: $timestamp
Specification 路径: $SpecificationPath
输出日志: $OutputPath
================================================================

"@

$logHeader | Out-File -FilePath $OutputPath -Encoding utf8

Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "TypeSpec 验证工具" -ForegroundColor Cyan
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "Specification 路径: $SpecificationPath" -ForegroundColor Gray
Write-Host "输出日志: $OutputPath" -ForegroundColor Gray
Write-Host "================================================================`n" -ForegroundColor Cyan

# 查找所有 TypeSpec 项目
Write-Host "正在查找 TypeSpec 项目..." -ForegroundColor Yellow
$tspConfigFiles = Get-ChildItem -Path $SpecificationPath -Filter "tspconfig.yaml" -Recurse -ErrorAction SilentlyContinue

if ($tspConfigFiles.Count -eq 0) {
    Write-Warning "未找到任何 TypeSpec 项目 (tspconfig.yaml)"
    "未找到任何 TypeSpec 项目" | Out-File -FilePath $OutputPath -Append -Encoding utf8
    exit 0
}

Write-Host "找到 $($tspConfigFiles.Count) 个 TypeSpec 项目`n" -ForegroundColor Green

# 遍历每个项目并运行验证
foreach ($configFile in $tspConfigFiles) {
    $totalProjects++
    $projectPath = Split-Path -Parent $configFile.FullName
    $relativePath = $projectPath.Replace($scriptRoot, "").TrimStart('\', '/')
    
    Write-Host "[$totalProjects/$($tspConfigFiles.Count)] 验证: $relativePath" -ForegroundColor Cyan
    
    # 记录项目信息到日志
    $projectLog = @"

----------------------------------------------------------------
项目 $totalProjects : $relativePath
----------------------------------------------------------------
项目路径: $projectPath
开始时间: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

"@
    $projectLog | Out-File -FilePath $OutputPath -Append -Encoding utf8
    
    try {
        # 运行 tsv 验证 (从仓库根目录运行，传入项目路径)
        $tsvPath = Join-Path $scriptRoot "eng\tools\typespec-validation\cmd\tsv.js"
        $output = & node $tsvPath $projectPath 2>&1
        $exitCode = $LASTEXITCODE
        
        # 记录输出
        $output | Out-File -FilePath $OutputPath -Append -Encoding utf8
        
        # 判断验证结果
        if ($exitCode -eq 0) {
            $successCount++
            Write-Host "  ✓ 验证通过" -ForegroundColor Green
            "状态: ✓ 成功" | Out-File -FilePath $OutputPath -Append -Encoding utf8
        }
        else {
            $errorCount++
            Write-Host "  ✗ 验证失败 (退出码: $exitCode)" -ForegroundColor Red
            
            # 记录错误详情
            $errorInfo = @{
                Project = $relativePath
                Path = $projectPath
                ExitCode = $exitCode
                Output = ($output | Out-String)
            }
            $errorDetails += $errorInfo
            
            "状态: ✗ 失败 (退出码: $exitCode)" | Out-File -FilePath $OutputPath -Append -Encoding utf8
            
            # 如果设置为遇到错误时停止
            if (-not $ContinueOnError) {
                Write-Error "验证失败，停止执行"
                break
            }
        }
    }
    catch {
        $skippedCount++
        Write-Host "  ⚠ 跳过: $_" -ForegroundColor Yellow
        "状态: ⚠ 跳过 - 错误: $_" | Out-File -FilePath $OutputPath -Append -Encoding utf8
    }
    
    "结束时间: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")" | Out-File -FilePath $OutputPath -Append -Encoding utf8
}

# 生成摘要报告
$endTimestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$summary = @"

================================================================
验证摘要
================================================================
结束时间: $endTimestamp
总项目数: $totalProjects
成功: $successCount
失败: $errorCount
跳过: $skippedCount
================================================================

"@

Write-Host "`n================================================================" -ForegroundColor Cyan
Write-Host "验证摘要" -ForegroundColor Cyan
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "总项目数: $totalProjects" -ForegroundColor White
Write-Host "成功: $successCount" -ForegroundColor Green
Write-Host "失败: $errorCount" -ForegroundColor Red
Write-Host "跳过: $skippedCount" -ForegroundColor Yellow
Write-Host "================================================================`n" -ForegroundColor Cyan

$summary | Out-File -FilePath $OutputPath -Append -Encoding utf8

# 如果有错误，输出错误项目列表
if ($errorCount -gt 0) {
    Write-Host "失败的项目列表:" -ForegroundColor Red
    $errorListLog = "`n失败的项目列表:`n"
    
    foreach ($error in $errorDetails) {
        Write-Host "  - $($error.Project)" -ForegroundColor Red
        $errorListLog += "  - $($error.Project) (退出码: $($error.ExitCode))`n"
    }
    
    $errorListLog | Out-File -FilePath $OutputPath -Append -Encoding utf8
    Write-Host ""
}

Write-Host "完整日志已保存到: $OutputPath" -ForegroundColor Green

# 设置退出码
if ($errorCount -gt 0) {
    exit 1
}
else {
    exit 0
}
