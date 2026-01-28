## Changed Paths

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}/stop
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs/{flowLogName}
Change Type: deleted

## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `tags__added` | added | `[{"name":"NetworkWatchers"}]` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors__deleted']` | deleted | `{"get":{"operationId":"ConnectionMonitors_List","tags":["ConnectionMonitors"],"parameters":[{"name":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}__deleted']` | deleted | `{"get":{"operationId":"ConnectionMonitors_Get","tags":["ConnectionMonitors"],"parameters":[{"name":"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}/stop`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}/stop__deleted']` | deleted | `{"post":{"operationId":"ConnectionMonitors_Stop","tags":["ConnectionMonitors"],"parameters":[{"name"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs__deleted']` | deleted | `{"get":{"operationId":"FlowLogs_List","tags":["FlowLogs"],"parameters":[{"name":"networkWatcherName"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs/{flowLogName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs/{flowLogName}__deleted']` | deleted | `{"get":{"operationId":"FlowLogs_Get","tags":["FlowLogs"],"parameters":[{"name":"networkWatcherName",...` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/availableProvidersList'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/azureReachabilityReport'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/configureFlowLog'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectivityCheck'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/ipFlowVerify'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/networkConfigurationDiagnostic'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/nextHop'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}/queryStatus'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}/stop'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/queryFlowLogStatus'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/queryTroubleshootResult'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/securityGroupView'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/troubleshoot'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/NetworkWatcher` |

### Changes for `ConnectionMonitorQueryResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorQueryResult__deleted` | deleted | `{"type":"object","properties":{"sourceStatus":{"type":"string","enum":["Unknown","Active","Inactive"...` |

### Changes for `ConnectionMonitorResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorResult__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string","readOnly":true},"id":{"type":"string","readO...` |

### Changes for `ConnectionMonitorResultProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorResultProperties__deleted` | deleted | `{"type":"object","properties":{"provisioningState":{"$ref":"./network.json#/definitions/Provisioning...` |

### Changes for `ConnectionStateSnapshot`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionStateSnapshot__deleted` | deleted | `{"type":"object","properties":{"connectionState":{"type":"string","enum":["Reachable","Unreachable",...` |

### Changes for `FlowLog`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FlowLog__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/FlowLogPropertiesFormat","x-ms-cl...` |

### Changes for `FlowLogListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FlowLogListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `IssueContext`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IssueContext__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"}}` |

### Changes for `PacketCaptureResultProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PacketCaptureResultProperties__deleted` | deleted | `{"type":"object","properties":{"provisioningState":{"$ref":"./network.json#/definitions/Provisioning...` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorEndpoint.properties.coverageLevel.type__deleted` | deleted | `string` |
| `definitions.ConnectionMonitorEndpoint.properties.type.type__deleted` | deleted | `string` |
| `definitions.ConnectionMonitorEndpointFilter.properties.type.type__deleted` | deleted | `string` |
| `definitions.ConnectionMonitorEndpointFilterItem.properties.type.type__deleted` | deleted | `string` |
| `definitions.ConnectionMonitorHttpConfiguration.properties.method.type__deleted` | deleted | `string` |
| `definitions.ConnectionMonitorOutput.properties.type.type__deleted` | deleted | `string` |
| `definitions.ConnectionMonitorTcpConfiguration.properties.destinationPortBehavior.type__deleted` | deleted | `string` |
| `definitions.ConnectionMonitorTestConfiguration.properties.preferredIPVersion.type__deleted` | deleted | `string` |
| `definitions.ConnectionMonitorTestConfiguration.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.ConnectivityInformation.properties.connectionStatus.type__deleted` | deleted | `string` |
| `definitions.ConnectivityIssue.properties.context.items.type__added` | added | `object` |
| `definitions.ConnectivityIssue.properties.origin.type__deleted` | deleted | `string` |
| `definitions.ConnectivityIssue.properties.severity.type__deleted` | deleted | `string` |
| `definitions.ConnectivityIssue.properties.type.type__deleted` | deleted | `string` |
| `definitions.ConnectivityParameters.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.FlowLogFormatParameters.properties.type.type__deleted` | deleted | `string` |
| `definitions.HTTPConfiguration.properties.method.type__deleted` | deleted | `string` |
| `definitions.NetworkConfigurationDiagnosticParameters.properties.verbosityLevel.type__deleted` | deleted | `string` |
| `definitions.NetworkConfigurationDiagnosticProfile.properties.direction.type__deleted` | deleted | `string` |
| `definitions.NextHopResult.properties.nextHopType.type__deleted` | deleted | `string` |
| `definitions.PacketCaptureParameters.properties.captureSettings.type__deleted` | deleted | `object` |
| `definitions.PacketCaptureParameters.properties.targetType.type__deleted` | deleted | `string` |
| `definitions.PacketCaptureQueryStatusResult.properties.packetCaptureError.items.type__deleted` | deleted | `string` |
| `definitions.PacketCaptureQueryStatusResult.properties.packetCaptureStatus.type__deleted` | deleted | `string` |
| `definitions.TopologyAssociation.properties.associationType.type__deleted` | deleted | `string` |
| `definitions.VerificationIPFlowParameters.properties.direction.type__deleted` | deleted | `string` |
| `definitions.VerificationIPFlowParameters.properties.protocol.type__deleted` | deleted | `string` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorEndpoint.properties.coverageLevel.enum__deleted` | deleted | `["Default","Low","BelowAverage","Average","AboveAverage","Full"]` |
| `definitions.ConnectionMonitorEndpoint.properties.type.enum__deleted` | deleted | `["AzureVM","AzureVNet","AzureSubnet","ExternalAddress","MMAWorkspaceMachine","MMAWorkspaceNetwork","...` |
| `definitions.ConnectionMonitorEndpointFilter.properties.type.enum__deleted` | deleted | `["Include"]` |
| `definitions.ConnectionMonitorEndpointFilterItem.properties.type.enum__deleted` | deleted | `["AgentAddress"]` |
| `definitions.ConnectionMonitorHttpConfiguration.properties.method.enum__deleted` | deleted | `["Get","Post"]` |
| `definitions.ConnectionMonitorOutput.properties.type.enum__deleted` | deleted | `["Workspace"]` |
| `definitions.ConnectionMonitorTcpConfiguration.properties.destinationPortBehavior.enum__deleted` | deleted | `["None","ListenIfAvailable"]` |
| `definitions.ConnectionMonitorTestConfiguration.properties.preferredIPVersion.enum__deleted` | deleted | `["IPv4","IPv6"]` |
| `definitions.ConnectionMonitorTestConfiguration.properties.protocol.enum__deleted` | deleted | `["Tcp","Http","Icmp"]` |
| `definitions.ConnectivityInformation.properties.connectionStatus.enum__deleted` | deleted | `["Unknown","Connected","Disconnected","Degraded"]` |
| `definitions.ConnectivityIssue.properties.origin.enum__deleted` | deleted | `["Local","Inbound","Outbound"]` |
| `definitions.ConnectivityIssue.properties.severity.enum__deleted` | deleted | `["Error","Warning"]` |
| `definitions.ConnectivityIssue.properties.type.enum__deleted` | deleted | `["Unknown","AgentStopped","GuestFirewall","DnsResolution","SocketBind","NetworkSecurityRule","UserDe...` |
| `definitions.ConnectivityParameters.properties.protocol.enum__deleted` | deleted | `["Tcp","Http","Https","Icmp"]` |
| `definitions.FlowLogFormatParameters.properties.type.enum__deleted` | deleted | `["JSON"]` |
| `definitions.HTTPConfiguration.properties.method.enum__deleted` | deleted | `["Get"]` |
| `definitions.NetworkConfigurationDiagnosticParameters.properties.verbosityLevel.enum__deleted` | deleted | `["Normal","Minimum","Full"]` |
| `definitions.NetworkConfigurationDiagnosticProfile.properties.direction.enum__deleted` | deleted | `["Inbound","Outbound"]` |
| `definitions.NextHopResult.properties.nextHopType.enum__deleted` | deleted | `["Internet","VirtualAppliance","VirtualNetworkGateway","VnetLocal","HyperNetGateway","None"]` |
| `definitions.PacketCaptureParameters.properties.targetType.enum__deleted` | deleted | `["AzureVM","AzureVMSS"]` |
| `definitions.PacketCaptureQueryStatusResult.properties.packetCaptureError.items.enum__deleted` | deleted | `["InternalError","AgentStopped","CaptureFailed","LocalFileFailed","StorageFailed"]` |
| `definitions.PacketCaptureQueryStatusResult.properties.packetCaptureStatus.enum__deleted` | deleted | `["NotStarted","Running","Stopped","Error","Unknown"]` |
| `definitions.TopologyAssociation.properties.associationType.enum__deleted` | deleted | `["Associated","Contains"]` |
| `definitions.VerificationIPFlowParameters.properties.direction.enum__deleted` | deleted | `["Inbound","Outbound"]` |
| `definitions.VerificationIPFlowParameters.properties.protocol.enum__deleted` | deleted | `["TCP","UDP"]` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorEndpoint.properties.coverageLevel['x-ms-enum__deleted']` | deleted | `{"name":"CoverageLevel","modelAsString":true}` |
| `definitions.ConnectionMonitorEndpoint.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"EndpointType","modelAsString":true}` |
| `definitions.ConnectionMonitorEndpointFilter.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"ConnectionMonitorEndpointFilterType","modelAsString":true}` |
| `definitions.ConnectionMonitorEndpointFilterItem.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"ConnectionMonitorEndpointFilterItemType","modelAsString":true}` |
| `definitions.ConnectionMonitorHttpConfiguration.properties.method['x-ms-enum__deleted']` | deleted | `{"name":"HTTPConfigurationMethod","modelAsString":true}` |
| `definitions.ConnectionMonitorOutput.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"OutputType","modelAsString":true}` |
| `definitions.ConnectionMonitorTcpConfiguration.properties.destinationPortBehavior['x-ms-enum__deleted']` | deleted | `{"name":"DestinationPortBehavior","modelAsString":true}` |
| `definitions.ConnectionMonitorTestConfiguration.properties.preferredIPVersion['x-ms-enum__deleted']` | deleted | `{"name":"PreferredIPVersion","modelAsString":true}` |
| `definitions.ConnectionMonitorTestConfiguration.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"ConnectionMonitorTestConfigurationProtocol","modelAsString":true}` |
| `definitions.ConnectivityInformation.properties.connectionStatus['x-ms-enum__deleted']` | deleted | `{"name":"ConnectionStatus","modelAsString":true}` |
| `definitions.ConnectivityIssue.properties.origin['x-ms-enum__deleted']` | deleted | `{"name":"Origin","modelAsString":true}` |
| `definitions.ConnectivityIssue.properties.severity['x-ms-enum__deleted']` | deleted | `{"name":"Severity","modelAsString":true}` |
| `definitions.ConnectivityIssue.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"IssueType","modelAsString":true}` |
| `definitions.ConnectivityParameters.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"Protocol","modelAsString":true}` |
| `definitions.FlowLogFormatParameters.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"FlowLogFormatType","modelAsString":true}` |
| `definitions.HTTPConfiguration.properties.method['x-ms-enum__deleted']` | deleted | `{"name":"HTTPMethod","modelAsString":true}` |
| `definitions.NetworkConfigurationDiagnosticParameters.properties.verbosityLevel['x-ms-enum__deleted']` | deleted | `{"name":"VerbosityLevel","modelAsString":true}` |
| `definitions.NetworkConfigurationDiagnosticProfile.properties.direction['x-ms-enum__deleted']` | deleted | `{"name":"Direction","modelAsString":true}` |
| `definitions.NextHopResult.properties.nextHopType['x-ms-enum__deleted']` | deleted | `{"name":"NextHopType","modelAsString":true}` |
| `definitions.PacketCaptureParameters.properties.targetType['x-ms-enum__deleted']` | deleted | `{"name":"PacketCaptureTargetType","modelAsString":false}` |
| `definitions.PacketCaptureQueryStatusResult.properties.packetCaptureError.items['x-ms-enum__deleted']` | deleted | `{"name":"PcError","modelAsString":true}` |
| `definitions.PacketCaptureQueryStatusResult.properties.packetCaptureStatus['x-ms-enum__deleted']` | deleted | `{"name":"PcStatus","modelAsString":true}` |
| `definitions.TopologyAssociation.properties.associationType['x-ms-enum__deleted']` | deleted | `{"name":"AssociationType","modelAsString":true}` |
| `definitions.VerificationIPFlowParameters.properties.direction['x-ms-enum__deleted']` | deleted | `{"name":"Direction","modelAsString":true}` |
| `definitions.VerificationIPFlowParameters.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"IpFlowProtocol","modelAsString":true}` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorEndpoint.properties.coverageLevel.$ref__added` | added | `./common.json/definitions/CoverageLevel` |
| `definitions.ConnectionMonitorEndpoint.properties.type.$ref__added` | added | `./common.json/definitions/EndpointType` |
| `definitions.ConnectionMonitorEndpointFilter.properties.type.$ref__added` | added | `./common.json/definitions/ConnectionMonitorEndpointFilterType` |
| `definitions.ConnectionMonitorEndpointFilterItem.properties.type.$ref__added` | added | `./common.json/definitions/ConnectionMonitorEndpointFilterItemType` |
| `definitions.ConnectionMonitorHttpConfiguration.properties.method.$ref__added` | added | `./common.json/definitions/HTTPConfigurationMethod` |
| `definitions.ConnectionMonitorOutput.properties.type.$ref__added` | added | `./common.json/definitions/OutputType` |
| `definitions.ConnectionMonitorTcpConfiguration.properties.destinationPortBehavior.$ref__added` | added | `./common.json/definitions/DestinationPortBehavior` |
| `definitions.ConnectionMonitorTestConfiguration.properties.preferredIPVersion.$ref__added` | added | `./common.json/definitions/PreferredIPVersion` |
| `definitions.ConnectionMonitorTestConfiguration.properties.protocol.$ref__added` | added | `./common.json/definitions/ConnectionMonitorTestConfigurationProtocol` |
| `definitions.ConnectivityInformation.properties.connectionStatus.$ref__added` | added | `./common.json/definitions/ConnectionStatus` |
| `definitions.ConnectivityIssue.properties.context.items.$ref__deleted` | deleted | `#/definitions/IssueContext` |
| `definitions.ConnectivityIssue.properties.origin.$ref__added` | added | `./common.json/definitions/Origin` |
| `definitions.ConnectivityIssue.properties.severity.$ref__added` | added | `./common.json/definitions/Severity` |
| `definitions.ConnectivityIssue.properties.type.$ref__added` | added | `./common.json/definitions/IssueType` |
| `definitions.ConnectivityParameters.properties.protocol.$ref__added` | added | `./common.json/definitions/Protocol` |
| `definitions.FlowLogFormatParameters.properties.type.$ref__added` | added | `./common.json/definitions/FlowLogFormatType` |
| `definitions.HTTPConfiguration.properties.method.$ref__added` | added | `./common.json/definitions/HTTPMethod` |
| `definitions.NetworkConfigurationDiagnosticParameters.properties.verbosityLevel.$ref__added` | added | `./common.json/definitions/VerbosityLevel` |
| `definitions.NetworkConfigurationDiagnosticProfile.properties.direction.$ref__added` | added | `./common.json/definitions/Direction` |
| `definitions.NextHopResult.properties.nextHopType.$ref__added` | added | `./common.json/definitions/NextHopType` |
| `definitions.PacketCaptureParameters.properties.targetType.$ref__added` | added | `./common.json/definitions/PacketCaptureTargetType` |
| `definitions.PacketCaptureQueryStatusResult.properties.packetCaptureError.items.$ref__added` | added | `./common.json/definitions/PcError` |
| `definitions.PacketCaptureQueryStatusResult.properties.packetCaptureStatus.$ref__added` | added | `./common.json/definitions/PcStatus` |
| `definitions.TopologyAssociation.properties.associationType.$ref__added` | added | `./common.json/definitions/AssociationType` |
| `definitions.VerificationIPFlowParameters.properties.direction.$ref__added` | added | `./common.json/definitions/Direction` |
| `definitions.VerificationIPFlowParameters.properties.protocol.$ref__added` | added | `./common.json/definitions/IpFlowProtocol` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorListResult.description__added` | added | `[Placeholder] Discription for page model` |
| `definitions.ConnectionMonitorListResult.properties.value.description__added` | added | `[Placeholder] Discription for value property` |
| `definitions.NetworkWatcherListResult.description__added` | added | `[Placeholder] Discription for page model` |
| `definitions.NetworkWatcherListResult.properties.value.description__added` | added | `[Placeholder] Discription for value property` |
| `definitions.PacketCaptureListResult.description__added` | added | `[Placeholder] Discription for page model` |
| `definitions.PacketCaptureListResult.properties.value.description__added` | added | `[Placeholder] Discription for value property` |

### Changes for `nextLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorListResult.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.NetworkWatcherListResult.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.PacketCaptureListResult.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorSuccessThreshold.properties.roundTripTimeMs.format__added` | added | `float` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectivityIssue.properties.context.items.additionalProperties__added` | added | `{"type":"string"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ConnectionMonitorListResult.properties.value.items.$ref` | `#/definitions/ConnectionMonitorResult` | `./common.json/definitions/ConnectionMonitorResult` |
| `definitions.ConnectivityParameters.properties.preferredIPVersion.$ref` | `./network.json#/definitions/IPVersion` | `./common.json/definitions/IPVersion` |
| `definitions.ErrorResponse.properties.error.$ref` | `./network.json#/definitions/ErrorDetails` | `./common.json/definitions/ErrorDetails` |
| `definitions.FlowLogInformation.properties.identity.$ref` | `./network.json#/definitions/ManagedServiceIdentity` | `./common.json/definitions/ManagedServiceIdentity` |
| `definitions.FlowLogPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.NetworkInterfaceAssociation.properties.securityRules.items.$ref` | `./networkSecurityGroup.json#/definitions/SecurityRule` | `./common.json/definitions/SecurityRule` |
| `definitions.NetworkSecurityGroupResult.properties.securityRuleAccessResult.$ref` | `./networkSecurityGroup.json#/definitions/SecurityRuleAccess` | `./common.json/definitions/SecurityRuleAccess` |
| `definitions.NetworkWatcher.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.NetworkWatcherPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.PacketCaptureResult.properties.properties.$ref` | `#/definitions/PacketCaptureResultProperties` | `./common.json/definitions/PacketCaptureResultProperties` |
| `definitions.SecurityRuleAssociations.properties.defaultSecurityRules.items.$ref` | `./networkSecurityGroup.json#/definitions/SecurityRule` | `./common.json/definitions/SecurityRule` |
| `definitions.SecurityRuleAssociations.properties.effectiveSecurityRules.items.$ref` | `./networkInterface.json#/definitions/EffectiveNetworkSecurityRule` | `./virtualNetwork.json/definitions/EffectiveNetworkSecurityRule` |
| `definitions.SubnetAssociation.properties.securityRules.items.$ref` | `./networkSecurityGroup.json#/definitions/SecurityRule` | `./common.json/definitions/SecurityRule` |
| `definitions.TopologyParameters.properties.targetSubnet.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.TopologyParameters.properties.targetVirtualNetwork.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.VerificationIPFlowResult.properties.access.$ref` | `./network.json#/definitions/Access` | `./common.json/definitions/Access` |
| `info.description` | `The Microsoft Azure Network management API provides a RESTful set of web services that interact with Microsoft Azure Networks service to manage your network resources. The API has entities that capture the relationship between an end user and the Microsoft Azure Networks service.` | `APIs to manage web application firewall rules.` |
| `info.title` | `NetworkManagementClient` | `WebApplicationFirewallManagement` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json/definitions/TagsObject` |

