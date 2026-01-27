# 为 NetworkGateway 缺失的模型添加装饰器的脚本
Write-Host "=== NetworkGateway 装饰器添加脚本 ===" -ForegroundColor Green

# 目标文件
$targetFile = "models.tsp"
Write-Host "目标文件: $targetFile"

# 从 API_CHANGES.md 提取的缺失模型
$missingModels = @(
    "BgpPeerStatus",
    "BgpPeerStatusListResult",
    "BgpSettings",
    "CertificateAuthentication",
    "CircuitMetadataMap",
    "ConnectionResetSharedKey",
    "ConnectionSharedKey",
    "ExpressRouteFailoverTestDetails",
    "ExpressRouteFailoverTestScenarioRequest",
    "ExpressRouteFailoverTestSettings",
    "ExpressRouteFailoverTestStatus",
    "ExpressRouteFailoverTestStatusProperties",
    "GatewayCustomBgpIpAddressIpConfiguration",
    "GatewayResiliencyTriggerType",
    "GatewayRoute",
    "GatewayRouteListResult",
    "IPConfigurationBgpPeeringAddress",
    "IpsecPolicy",
    "LocalNetworkGateway",
    "LocalNetworkGatewayListResult",
    "LocalNetworkGatewayPropertiesFormat",
    "RadiusAuthServer",
    "RadiusAuthServerConfiguration",
    "RadiusServerRootCertificate",
    "RadiusServerSecret",
    "SetAuthServerConfigurationRequest",
    "VirtualNetworkGatewayConnection",
    "VirtualNetworkGatewayConnectionListResult",
    "VirtualNetworkGatewayConnectionPropertiesFormat",
    "VirtualNetworkGatewayIPConfiguration",
    "VirtualNetworkGatewayIPConfigurationPropertiesFormat",
    "VirtualNetworkGatewayNatRule",
    "VirtualNetworkGatewayNatRuleProperties",
    "VirtualNetworkGatewayPolicyGroup",
    "VirtualNetworkGatewayPolicyGroupMember",
    "VirtualNetworkGatewayPolicyGroupProperties",
    "VirtualNetworkGatewaySku",
    "VngClientConnectionConfiguration",
    "VngClientConnectionConfigurationListResult",
    "VngClientConnectionConfigurationProperties",
    "VpnClientConfiguration",
    "VpnClientConnectionHealth",
    "VpnClientConnectionHealthDetail",
    "VpnClientConnectionHealthDetailListResult",
    "VpnClientIPsecParameters",
    "VpnClientParameters",
    "VpnClientRevokedCertificate",
    "VpnClientRootCertificate",
    "VpnDeviceScriptParameters",
    "VpnPacketCaptureStartParameters",
    "VpnPacketCaptureStopParameters"
)

Write-Host "缺失模型数量: $($missingModels.Count)"

# 定义要添加的装饰器
$suppressDirective = '#suppress "@azure-tools/typespec-azure-core/no-legacy-usage"'
$featureDecorator = '@Azure.ResourceManager.Legacy.feature(Features.networkGateway)'

# 读取文件内容
$content = Get-Content $targetFile -Raw -Encoding UTF8

# 第一步: 查找需要添加装饰器的模型
Write-Host "`n第一步: 查找需要添加装饰器的模型..."
$modelsToModify = @()

foreach ($modelName in $missingModels) {
    # 使用正则表达式查找模型定义
    $pattern = "(?m)^((?:#suppress.*?\r?\n)*)(@[^\r\n]*\r?\n)*model\s+$modelName\s*[{:]"
    if ($content -match $pattern) {
        $existingSuppresses = $matches[1]
        $hasLegacySuppress = $existingSuppresses -match 'no-legacy-usage'
        
        if (-not $hasLegacySuppress) {
            # 找到模型在文件中的位置
            $index = $content.IndexOf($matches[0])
            $lineNumber = ($content.Substring(0, $index) -split "`n").Count
            
            $modelsToModify += [PSCustomObject]@{
                Name = $modelName
                LineNumber = $lineNumber
                HasOtherSuppresses = $existingSuppresses.Trim() -ne ""
            }
        }
    }
}

# 按行号倒序排序
$modelsToModify = $modelsToModify | Sort-Object -Property LineNumber -Descending

Write-Host "找到 $($modelsToModify.Count) 个需要添加装饰器的模型"

# 显示将要修改的模型
if ($modelsToModify.Count -gt 0) {
    Write-Host "`n将要修改的模型:"
    foreach ($model in $modelsToModify) {
        $status = if ($model.HasOtherSuppresses) { "已有其他suppress" } else { "无suppress" }
        Write-Host "  行 $($model.LineNumber): $($model.Name) ($status)"
    }
    
    # 询问用户确认
    $confirm = Read-Host "`n是否继续添加装饰器? (Y/N)"
    if ($confirm -ne 'Y' -and $confirm -ne 'y') {
        Write-Host "操作已取消" -ForegroundColor Yellow
        exit
    }
    
    # 第二步: 添加装饰器
    Write-Host "`n第二步: 添加装饰器..."
    
    foreach ($model in $modelsToModify) {
        $modelName = $model.Name
        
        # 查找模型定义
        $pattern = "(?m)^((?:#suppress.*?\r?\n)*)(@[^\r\n]*\r?\n)*model\s+$modelName(\s*[{:])"
        if ($content -match $pattern) {
            $fullMatch = $matches[0]
            $existingSuppresses = $matches[1]
            $decorators = $matches[2]
            $modelSuffix = $matches[3]
            
            # 构建新的内容
            if ($existingSuppresses.Trim() -ne "") {
                # 如果已有suppress,在最后一个suppress后添加新的
                $newContent = $existingSuppresses + "$suppressDirective`n$featureDecorator`n" + $decorators + "model $modelName" + $modelSuffix
            } else {
                # 如果没有suppress,在装饰器前添加
                $newContent = "$suppressDirective`n$featureDecorator`n" + $decorators + "model $modelName" + $modelSuffix
            }
            
            # 替换内容
            $content = $content.Replace($fullMatch, $newContent)
        }
    }
    
    # 保存文件
    [System.IO.File]::WriteAllText((Resolve-Path $targetFile).Path, $content, [System.Text.Encoding]::UTF8)
    
    Write-Host "`n成功为 $($modelsToModify.Count) 个模型添加了装饰器" -ForegroundColor Green
    Write-Host "请运行 'tsp compile .' 验证修改是否正确" -ForegroundColor Cyan
} else {
    Write-Host "`n所有模型都已有正确的装饰器" -ForegroundColor Green
}
