param(
    [string]$ModelsFile = "models.tsp"
)

# LoadBalancer 缺失的模型列表
$deletedDefs = @(
    "BackendAddressInboundNatRulePortMappings",
    "BackendAddressPool",
    "BackendAddressPoolPropertiesFormat",
    "FrontendIPConfiguration",
    "FrontendIPConfigurationPropertiesFormat",
    "GatewayLoadBalancerTunnelInterface",
    "InboundNatPool",
    "InboundNatPoolPropertiesFormat",
    "InboundNatRule",
    "InboundNatRuleListResult",
    "InboundNatRulePortMapping",
    "InboundNatRulePropertiesFormat",
    "LoadBalancerBackendAddress",
    "LoadBalancerBackendAddressPoolListResult",
    "LoadBalancerBackendAddressPropertiesFormat",
    "LoadBalancerFrontendIPConfigurationListResult",
    "LoadBalancerHealthPerRule",
    "LoadBalancerHealthPerRulePerBackendAddress",
    "LoadBalancerLoadBalancingRuleListResult",
    "LoadBalancerOutboundRuleListResult",
    "LoadBalancerProbeListResult",
    "LoadBalancerPropertiesFormat",
    "LoadBalancerSku",
    "LoadBalancerVipSwapRequest",
    "LoadBalancerVipSwapRequestFrontendIPConfiguration",
    "LoadBalancerVipSwapRequestFrontendIPConfigurationProperties",
    "LoadBalancingRule",
    "LoadBalancingRulePropertiesFormat",
    "MigratedPools",
    "MigrateLoadBalancerToIpBasedRequest",
    "NatRulePortMapping",
    "OutboundRule",
    "OutboundRulePropertiesFormat",
    "Probe",
    "ProbePropertiesFormat",
    "QueryInboundNatRulePortMappingRequest"
)

$suppressLine = '#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"'
$featureLine = '@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)'

Write-Host "=== LoadBalancer 装饰器添加脚本 ===" -ForegroundColor Green
Write-Host "目标文件: $ModelsFile" -ForegroundColor Cyan
Write-Host "缺失模型数量: $($deletedDefs.Count)" -ForegroundColor Cyan

$lines = Get-Content $ModelsFile
$modificationsNeeded = @()

Write-Host "`n第一步: 查找需要添加装饰器的模型..." -ForegroundColor Yellow

for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    
    foreach ($modelName in $deletedDefs) {
        if ($line -match "^(model|alias) $modelName(\s|<|\{|=|$)") {
            $hasFeatureDecorator = $false
            $hasNoLegacySuppress = $false
            $lastSuppressIndex = -1
            
            for ($j = $i - 1; $j -ge [Math]::Max(0, $i - 10); $j--) {
                if ($lines[$j] -match '@Azure\.ResourceManager\.Legacy\.feature\(Features\.loadBalancer\)') {
                    $hasFeatureDecorator = $true
                }
                if ($lines[$j] -match '#suppress.*no-legacy-usage') {
                    $hasNoLegacySuppress = $true
                }
                if ($lines[$j] -match '^#suppress' -and $lastSuppressIndex -eq -1) {
                    $lastSuppressIndex = $j
                }
                if ($lines[$j] -match '^(model|interface|enum|union|alias)\s' -and $j -ne $i) {
                    break
                }
            }
            
            if (-not $hasFeatureDecorator) {
                $modificationsNeeded += [PSCustomObject]@{
                    LineNumber = $i + 1
                    LineIndex = $i
                    ModelName = $modelName
                    HasSuppressAbove = ($lastSuppressIndex -ge 0)
                    LastSuppressIndex = $lastSuppressIndex
                    HasNoLegacySuppress = $hasNoLegacySuppress
                }
            }
            break
        }
    }
}

Write-Host "找到 $($modificationsNeeded.Count) 个需要添加装饰器的模型" -ForegroundColor Cyan

if ($modificationsNeeded.Count -eq 0) {
    Write-Host "`n所有模型都已有正确的装饰器，无需修改！" -ForegroundColor Green
    exit
}

Write-Host "`n将要修改的模型:" -ForegroundColor Yellow
$modificationsNeeded | ForEach-Object {
    $status = if ($_.HasSuppressAbove) { "(已有其他suppress)" } else { "(无suppress)" }
    Write-Host "  行 $($_.LineNumber): $($_.ModelName) $status" -ForegroundColor Gray
}

Write-Host "`n是否继续添加装饰器? (Y/N)" -ForegroundColor Yellow
$response = Read-Host

if ($response -ne 'Y' -and $response -ne 'y') {
    Write-Host "已取消" -ForegroundColor Red
    exit
}

Write-Host "`n第二步: 添加装饰器..." -ForegroundColor Yellow

$modificationsNeeded = $modificationsNeeded | Sort-Object LineIndex -Descending
$modifiedCount = 0

foreach ($mod in $modificationsNeeded) {
    $lineIndex = $mod.LineIndex
    
    if ($mod.HasSuppressAbove) {
        $insertIndex = $mod.LastSuppressIndex + 1
        
        if (-not $mod.HasNoLegacySuppress) {
            $linesToInsert = @($suppressLine, $featureLine)
        } else {
            $linesToInsert = @($featureLine)
        }
    } else {
        $insertIndex = $lineIndex
        $linesToInsert = @($suppressLine, $featureLine)
    }
    
    $lines = @($lines[0..($insertIndex-1)]) + $linesToInsert + @($lines[$insertIndex..($lines.Count-1)])
    $modifiedCount++
}

$lines | Set-Content $ModelsFile -Encoding UTF8

Write-Host "`n成功为 $modifiedCount 个模型添加了装饰器" -ForegroundColor Green
Write-Host "请运行 'tsp compile .' 验证修改是否正确" -ForegroundColor Cyan
