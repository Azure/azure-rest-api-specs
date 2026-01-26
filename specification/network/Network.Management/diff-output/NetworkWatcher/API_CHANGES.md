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

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors__deleted']` | deleted | `{"get":{"operationId":"ConnectionMonitors_List","parameters":[{"name":"networkWatcherName","in":"pat...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}__deleted']` | deleted | `{"get":{"operationId":"ConnectionMonitors_Get","parameters":[{"name":"networkWatcherName","in":"path...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}/stop`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}/stop__deleted']` | deleted | `{"post":{"operationId":"ConnectionMonitors_Stop","parameters":[{"name":"networkWatcherName","in":"pa...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs__deleted']` | deleted | `{"get":{"operationId":"FlowLogs_List","parameters":[{"name":"networkWatcherName","in":"path","requir...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs/{flowLogName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs/{flowLogName}__deleted']` | deleted | `{"get":{"operationId":"FlowLogs_Get","parameters":[{"name":"networkWatcherName","in":"path","require...` |

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

### Changes for `AvailableProvidersList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AvailableProvidersList__deleted` | deleted | `{"type":"object","properties":{"countries":{"type":"array","items":{"$ref":"#/definitions/AvailableP...` |

### Changes for `AvailableProvidersListCity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AvailableProvidersListCity__deleted` | deleted | `{"type":"object","properties":{"cityName":{"type":"string"},"providers":{"type":"array","items":{"ty...` |

### Changes for `AvailableProvidersListCountry`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AvailableProvidersListCountry__deleted` | deleted | `{"type":"object","properties":{"countryName":{"type":"string"},"providers":{"type":"array","items":{...` |

### Changes for `AvailableProvidersListParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AvailableProvidersListParameters__deleted` | deleted | `{"type":"object","properties":{"azureLocations":{"type":"array","items":{"type":"string"}},"country"...` |

### Changes for `AvailableProvidersListState`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AvailableProvidersListState__deleted` | deleted | `{"type":"object","properties":{"stateName":{"type":"string"},"providers":{"type":"array","items":{"t...` |

### Changes for `AzureReachabilityReport`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureReachabilityReport__deleted` | deleted | `{"type":"object","properties":{"aggregationLevel":{"type":"string"},"providerLocation":{"$ref":"#/de...` |

### Changes for `AzureReachabilityReportItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureReachabilityReportItem__deleted` | deleted | `{"type":"object","properties":{"provider":{"type":"string"},"azureLocation":{"type":"string"},"laten...` |

### Changes for `AzureReachabilityReportLatencyInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureReachabilityReportLatencyInfo__deleted` | deleted | `{"type":"object","properties":{"timeStamp":{"type":"string","format":"date-time"},"score":{"type":"i...` |

### Changes for `AzureReachabilityReportLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureReachabilityReportLocation__deleted` | deleted | `{"type":"object","properties":{"country":{"type":"string"},"state":{"type":"string"},"city":{"type":...` |

### Changes for `AzureReachabilityReportParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureReachabilityReportParameters__deleted` | deleted | `{"type":"object","properties":{"providerLocation":{"$ref":"#/definitions/AzureReachabilityReportLoca...` |

### Changes for `ConnectionMonitor`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitor__deleted` | deleted | `{"type":"object","properties":{"location":{"type":"string"},"tags":{"type":"object","additionalPrope...` |

### Changes for `ConnectionMonitorDestination`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorDestination__deleted` | deleted | `{"type":"object","properties":{"resourceId":{"type":"string"},"address":{"type":"string"},"port":{"t...` |

### Changes for `ConnectionMonitorEndpoint`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorEndpoint__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"type":{"type":"string","enum":["AzureVM","A...` |

### Changes for `ConnectionMonitorEndpointFilter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorEndpointFilter__deleted` | deleted | `{"type":"object","properties":{"type":{"type":"string","enum":["Include"],"x-ms-enum":{"name":"Conne...` |

### Changes for `ConnectionMonitorEndpointFilterItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorEndpointFilterItem__deleted` | deleted | `{"type":"object","properties":{"type":{"type":"string","enum":["AgentAddress"],"x-ms-enum":{"name":"...` |

### Changes for `ConnectionMonitorEndpointLocationDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorEndpointLocationDetails__deleted` | deleted | `{"type":"object","properties":{"region":{"type":"string"}}}` |

### Changes for `ConnectionMonitorEndpointScope`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorEndpointScope__deleted` | deleted | `{"type":"object","properties":{"include":{"type":"array","items":{"$ref":"#/definitions/ConnectionMo...` |

### Changes for `ConnectionMonitorEndpointScopeItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorEndpointScopeItem__deleted` | deleted | `{"type":"object","properties":{"address":{"type":"string"}}}` |

### Changes for `ConnectionMonitorHttpConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorHttpConfiguration__deleted` | deleted | `{"type":"object","properties":{"port":{"type":"integer","format":"int32","minimum":0,"maximum":65535...` |

### Changes for `ConnectionMonitorIcmpConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorIcmpConfiguration__deleted` | deleted | `{"type":"object","properties":{"disableTraceRoute":{"type":"boolean"}}}` |

### Changes for `ConnectionMonitorListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorListResult__deleted` | deleted | `{"type":"object","properties":{"value":{"type":"array","items":{"$ref":"#/definitions/ConnectionMoni...` |

### Changes for `ConnectionMonitorOutput`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorOutput__deleted` | deleted | `{"type":"object","properties":{"type":{"type":"string","enum":["Workspace"],"x-ms-enum":{"name":"Out...` |

### Changes for `ConnectionMonitorParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorParameters__deleted` | deleted | `{"type":"object","properties":{"source":{"$ref":"#/definitions/ConnectionMonitorSource"},"destinatio...` |

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

### Changes for `ConnectionMonitorSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorSource__deleted` | deleted | `{"type":"object","properties":{"resourceId":{"type":"string"},"port":{"type":"integer","format":"int...` |

### Changes for `ConnectionMonitorSuccessThreshold`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorSuccessThreshold__deleted` | deleted | `{"type":"object","properties":{"checksFailedPercent":{"type":"integer","format":"int32"},"roundTripT...` |

### Changes for `ConnectionMonitorTcpConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorTcpConfiguration__deleted` | deleted | `{"type":"object","properties":{"port":{"type":"integer","format":"int32","minimum":0,"maximum":65535...` |

### Changes for `ConnectionMonitorTestConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorTestConfiguration__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"testFrequencySec":{"type":"integer","format...` |

### Changes for `ConnectionMonitorTestGroup`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorTestGroup__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"disable":{"type":"boolean"},"testConfigurat...` |

### Changes for `ConnectionMonitorWorkspaceSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorWorkspaceSettings__deleted` | deleted | `{"type":"object","properties":{"workspaceResourceId":{"type":"string"}}}` |

### Changes for `ConnectionStateSnapshot`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionStateSnapshot__deleted` | deleted | `{"type":"object","properties":{"connectionState":{"type":"string","enum":["Reachable","Unreachable",...` |

### Changes for `ConnectivityDestination`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectivityDestination__deleted` | deleted | `{"type":"object","properties":{"resourceId":{"type":"string"},"address":{"type":"string"},"port":{"t...` |

### Changes for `ConnectivityHop`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectivityHop__deleted` | deleted | `{"type":"object","properties":{"type":{"type":"string","readOnly":true},"id":{"type":"string","readO...` |

### Changes for `ConnectivityInformation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectivityInformation__deleted` | deleted | `{"type":"object","properties":{"hops":{"type":"array","items":{"$ref":"#/definitions/ConnectivityHop...` |

### Changes for `ConnectivityIssue`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectivityIssue__deleted` | deleted | `{"type":"object","properties":{"origin":{"type":"string","enum":["Local","Inbound","Outbound"],"x-ms...` |

### Changes for `ConnectivityParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectivityParameters__deleted` | deleted | `{"type":"object","properties":{"source":{"$ref":"#/definitions/ConnectivitySource"},"destination":{"...` |

### Changes for `ConnectivitySource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectivitySource__deleted` | deleted | `{"type":"object","properties":{"resourceId":{"type":"string"},"port":{"type":"integer","format":"int...` |

### Changes for `ErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorResponse__deleted` | deleted | `{"type":"object","properties":{"error":{"$ref":"./network.json#/definitions/ErrorDetails","title":"E...` |

### Changes for `EvaluatedNetworkSecurityGroup`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EvaluatedNetworkSecurityGroup__deleted` | deleted | `{"type":"object","properties":{"networkSecurityGroupId":{"type":"string"},"appliedTo":{"type":"strin...` |

### Changes for `FlowLog`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FlowLog__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/FlowLogPropertiesFormat","x-ms-cl...` |

### Changes for `FlowLogFormatParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FlowLogFormatParameters__deleted` | deleted | `{"type":"object","properties":{"type":{"type":"string","enum":["JSON"],"x-ms-enum":{"name":"FlowLogF...` |

### Changes for `FlowLogInformation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FlowLogInformation__deleted` | deleted | `{"type":"object","properties":{"targetResourceId":{"type":"string"},"properties":{"$ref":"#/definiti...` |

### Changes for `FlowLogListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FlowLogListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `FlowLogProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FlowLogProperties__deleted` | deleted | `{"type":"object","properties":{"storageId":{"type":"string"},"enabledFilteringCriteria":{"type":"str...` |

### Changes for `FlowLogPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FlowLogPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"targetResourceId":{"type":"string"},"targetResourceGuid":{"type":"st...` |

### Changes for `FlowLogStatusParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FlowLogStatusParameters__deleted` | deleted | `{"type":"object","properties":{"targetResourceId":{"type":"string"}},"required":["targetResourceId"]...` |

### Changes for `HTTPConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HTTPConfiguration__deleted` | deleted | `{"type":"object","properties":{"method":{"type":"string","enum":["Get"],"x-ms-enum":{"name":"HTTPMet...` |

### Changes for `HTTPHeader`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HTTPHeader__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"value":{"type":"string"}}}` |

### Changes for `HopLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HopLink__deleted` | deleted | `{"type":"object","properties":{"nextHopId":{"type":"string","readOnly":true},"linkType":{"type":"str...` |

### Changes for `HopLinkProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HopLinkProperties__deleted` | deleted | `{"type":"object","properties":{"roundTripTimeMin":{"type":"integer","format":"int64","minimum":0,"ma...` |

### Changes for `IssueContext`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IssueContext__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"}}` |

### Changes for `MatchedRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MatchedRule__deleted` | deleted | `{"type":"object","properties":{"ruleName":{"type":"string"},"action":{"type":"string"}}}` |

### Changes for `NetworkConfigurationDiagnosticParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkConfigurationDiagnosticParameters__deleted` | deleted | `{"type":"object","properties":{"targetResourceId":{"type":"string"},"verbosityLevel":{"type":"string...` |

### Changes for `NetworkConfigurationDiagnosticProfile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkConfigurationDiagnosticProfile__deleted` | deleted | `{"type":"object","properties":{"direction":{"type":"string","enum":["Inbound","Outbound"],"x-ms-enum...` |

### Changes for `NetworkConfigurationDiagnosticResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkConfigurationDiagnosticResponse__deleted` | deleted | `{"type":"object","properties":{"results":{"type":"array","items":{"$ref":"#/definitions/NetworkConfi...` |

### Changes for `NetworkConfigurationDiagnosticResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkConfigurationDiagnosticResult__deleted` | deleted | `{"type":"object","properties":{"profile":{"$ref":"#/definitions/NetworkConfigurationDiagnosticProfil...` |

### Changes for `NetworkInterfaceAssociation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkInterfaceAssociation__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string","readOnly":true},"securityRules":{"type":"array...` |

### Changes for `NetworkSecurityGroupResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityGroupResult__deleted` | deleted | `{"type":"object","properties":{"securityRuleAccessResult":{"$ref":"./networkSecurityGroup.json#/defi...` |

### Changes for `NetworkSecurityRulesEvaluationResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityRulesEvaluationResult__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"protocolMatched":{"type":"boolean"},"source...` |

### Changes for `NetworkWatcherListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkWatcherListResult__deleted` | deleted | `{"type":"object","properties":{"value":{"type":"array","items":{"$ref":"#/definitions/NetworkWatcher...` |

### Changes for `NetworkWatcherPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkWatcherPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"provisioningState":{"$ref":"./network.json#/definitions/Provisioning...` |

### Changes for `NextHopParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NextHopParameters__deleted` | deleted | `{"type":"object","properties":{"targetResourceId":{"type":"string"},"sourceIPAddress":{"type":"strin...` |

### Changes for `NextHopResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NextHopResult__deleted` | deleted | `{"type":"object","properties":{"nextHopType":{"type":"string","enum":["Internet","VirtualAppliance",...` |

### Changes for `PacketCapture`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PacketCapture__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/PacketCaptureParameters","x-ms-cl...` |

### Changes for `PacketCaptureFilter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PacketCaptureFilter__deleted` | deleted | `{"type":"object","properties":{"protocol":{"type":"string","default":"Any","enum":["TCP","UDP","Any"...` |

### Changes for `PacketCaptureListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PacketCaptureListResult__deleted` | deleted | `{"type":"object","properties":{"value":{"type":"array","items":{"$ref":"#/definitions/PacketCaptureR...` |

### Changes for `PacketCaptureMachineScope`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PacketCaptureMachineScope__deleted` | deleted | `{"type":"object","properties":{"include":{"type":"array","items":{"type":"string"}},"exclude":{"type...` |

### Changes for `PacketCaptureParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PacketCaptureParameters__deleted` | deleted | `{"type":"object","properties":{"target":{"type":"string"},"scope":{"$ref":"#/definitions/PacketCaptu...` |

### Changes for `PacketCaptureQueryStatusResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PacketCaptureQueryStatusResult__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"id":{"type":"string"},"captureStartTime":{"...` |

### Changes for `PacketCaptureResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PacketCaptureResult__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string","readOnly":true},"id":{"type":"string","readO...` |

### Changes for `PacketCaptureResultProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PacketCaptureResultProperties__deleted` | deleted | `{"type":"object","properties":{"provisioningState":{"$ref":"./network.json#/definitions/Provisioning...` |

### Changes for `PacketCaptureSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PacketCaptureSettings__deleted` | deleted | `{"type":"object","properties":{"fileCount":{"type":"integer","format":"int32","default":10,"minimum"...` |

### Changes for `PacketCaptureStorageLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PacketCaptureStorageLocation__deleted` | deleted | `{"type":"object","properties":{"storageId":{"type":"string"},"storagePath":{"type":"string"},"filePa...` |

### Changes for `ProtocolConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ProtocolConfiguration__deleted` | deleted | `{"type":"object","properties":{"HTTPConfiguration":{"$ref":"#/definitions/HTTPConfiguration"}}}` |

### Changes for `QueryTroubleshootingParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.QueryTroubleshootingParameters__deleted` | deleted | `{"type":"object","properties":{"targetResourceId":{"type":"string"}},"required":["targetResourceId"]...` |

### Changes for `RetentionPolicyParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RetentionPolicyParameters__deleted` | deleted | `{"type":"object","properties":{"days":{"type":"integer","format":"int32","default":0},"enabled":{"ty...` |

### Changes for `SecurityGroupNetworkInterface`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityGroupNetworkInterface__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string"},"securityRuleAssociations":{"$ref":"#/definiti...` |

### Changes for `SecurityGroupViewParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityGroupViewParameters__deleted` | deleted | `{"type":"object","properties":{"targetResourceId":{"type":"string"}},"required":["targetResourceId"]...` |

### Changes for `SecurityGroupViewResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityGroupViewResult__deleted` | deleted | `{"type":"object","properties":{"networkInterfaces":{"type":"array","items":{"$ref":"#/definitions/Se...` |

### Changes for `SecurityRuleAssociations`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityRuleAssociations__deleted` | deleted | `{"type":"object","properties":{"networkInterfaceAssociation":{"$ref":"#/definitions/NetworkInterface...` |

### Changes for `SubnetAssociation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SubnetAssociation__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string","readOnly":true},"securityRules":{"type":"array...` |

### Changes for `Topology`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Topology__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string","readOnly":true},"createdDateTime":{"type":"str...` |

### Changes for `TopologyAssociation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TopologyAssociation__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"resourceId":{"type":"string"},"associationT...` |

### Changes for `TopologyParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TopologyParameters__deleted` | deleted | `{"type":"object","properties":{"targetResourceGroupName":{"type":"string"},"targetVirtualNetwork":{"...` |

### Changes for `TopologyResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TopologyResource__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"id":{"type":"string"},"location":{"type":"s...` |

### Changes for `TrafficAnalyticsConfigurationProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TrafficAnalyticsConfigurationProperties__deleted` | deleted | `{"type":"object","properties":{"enabled":{"type":"boolean"},"workspaceId":{"type":"string"},"workspa...` |

### Changes for `TrafficAnalyticsProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TrafficAnalyticsProperties__deleted` | deleted | `{"type":"object","properties":{"networkWatcherFlowAnalyticsConfiguration":{"$ref":"#/definitions/Tra...` |

### Changes for `TroubleshootingDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TroubleshootingDetails__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string"},"reasonType":{"type":"string"},"summary":{"typ...` |

### Changes for `TroubleshootingParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TroubleshootingParameters__deleted` | deleted | `{"type":"object","properties":{"targetResourceId":{"type":"string"},"properties":{"$ref":"#/definiti...` |

### Changes for `TroubleshootingProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TroubleshootingProperties__deleted` | deleted | `{"type":"object","properties":{"storageId":{"type":"string"},"storagePath":{"type":"string"}},"requi...` |

### Changes for `TroubleshootingRecommendedActions`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TroubleshootingRecommendedActions__deleted` | deleted | `{"type":"object","properties":{"actionId":{"type":"string"},"actionText":{"type":"string"},"actionUr...` |

### Changes for `TroubleshootingResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TroubleshootingResult__deleted` | deleted | `{"type":"object","properties":{"startTime":{"type":"string","format":"date-time"},"endTime":{"type":...` |

### Changes for `VerificationIPFlowParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VerificationIPFlowParameters__deleted` | deleted | `{"type":"object","properties":{"targetResourceId":{"type":"string"},"direction":{"type":"string","en...` |

### Changes for `VerificationIPFlowResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VerificationIPFlowResult__deleted` | deleted | `{"type":"object","properties":{"access":{"$ref":"./network.json#/definitions/Access"},"ruleName":{"t...` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.NetworkWatcher.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.NetworkWatcher.properties.properties.$ref` | `#/definitions/NetworkWatcherPropertiesFormat` | `./common.json/definitions/NetworkWatcherPropertiesFormat` |
| `info.description` | `The Microsoft Azure Network management API provides a RESTful set of web services that interact with Microsoft Azure Networks service to manage your network resources. The API has entities that capture the relationship between an end user and the Microsoft Azure Networks service.` | `APIs to manage web application firewall rules.` |
| `info.title` | `NetworkManagementClient` | `WebApplicationFirewallManagement` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkWatchers'].get.responses.200.schema.$ref` | `#/definitions/NetworkWatcherListResult` | `./common.json/definitions/NetworkWatcherListResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkWatchers'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers'].get.responses.200.schema.$ref` | `#/definitions/NetworkWatcherListResult` | `./common.json/definitions/NetworkWatcherListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}'].delete.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}'].patch.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}'].put.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/availableProvidersList'].post.parameters[1].schema.$ref` | `#/definitions/AvailableProvidersListParameters` | `./common.json/definitions/AvailableProvidersListParameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/availableProvidersList'].post.responses.200.schema.$ref` | `#/definitions/AvailableProvidersList` | `./common.json/definitions/AvailableProvidersList` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/availableProvidersList'].post.responses.202.schema.$ref` | `#/definitions/AvailableProvidersList` | `./common.json/definitions/AvailableProvidersList` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/availableProvidersList'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/azureReachabilityReport'].post.parameters[1].schema.$ref` | `#/definitions/AzureReachabilityReportParameters` | `./common.json/definitions/AzureReachabilityReportParameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/azureReachabilityReport'].post.responses.200.schema.$ref` | `#/definitions/AzureReachabilityReport` | `./common.json/definitions/AzureReachabilityReport` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/azureReachabilityReport'].post.responses.202.schema.$ref` | `#/definitions/AzureReachabilityReport` | `./common.json/definitions/AzureReachabilityReport` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/azureReachabilityReport'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/configureFlowLog'].post.parameters[1].schema.$ref` | `#/definitions/FlowLogInformation` | `./common.json/definitions/FlowLogInformation` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/configureFlowLog'].post.responses.200.schema.$ref` | `#/definitions/FlowLogInformation` | `./common.json/definitions/FlowLogInformation` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/configureFlowLog'].post.responses.202.schema.$ref` | `#/definitions/FlowLogInformation` | `./common.json/definitions/FlowLogInformation` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/configureFlowLog'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectivityCheck'].post.parameters[1].schema.$ref` | `#/definitions/ConnectivityParameters` | `./common.json/definitions/ConnectivityParameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectivityCheck'].post.responses.200.schema.$ref` | `#/definitions/ConnectivityInformation` | `./common.json/definitions/ConnectivityInformation` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectivityCheck'].post.responses.202.schema.$ref` | `#/definitions/ConnectivityInformation` | `./common.json/definitions/ConnectivityInformation` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectivityCheck'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/ipFlowVerify'].post.parameters[1].schema.$ref` | `#/definitions/VerificationIPFlowParameters` | `./common.json/definitions/VerificationIPFlowParameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/ipFlowVerify'].post.responses.200.schema.$ref` | `#/definitions/VerificationIPFlowResult` | `./common.json/definitions/VerificationIPFlowResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/ipFlowVerify'].post.responses.202.schema.$ref` | `#/definitions/VerificationIPFlowResult` | `./common.json/definitions/VerificationIPFlowResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/ipFlowVerify'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/networkConfigurationDiagnostic'].post.parameters[1].schema.$ref` | `#/definitions/NetworkConfigurationDiagnosticParameters` | `./common.json/definitions/NetworkConfigurationDiagnosticParameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/networkConfigurationDiagnostic'].post.responses.200.schema.$ref` | `#/definitions/NetworkConfigurationDiagnosticResponse` | `./common.json/definitions/NetworkConfigurationDiagnosticResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/networkConfigurationDiagnostic'].post.responses.202.schema.$ref` | `#/definitions/NetworkConfigurationDiagnosticResponse` | `./common.json/definitions/NetworkConfigurationDiagnosticResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/networkConfigurationDiagnostic'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/nextHop'].post.parameters[1].schema.$ref` | `#/definitions/NextHopParameters` | `./common.json/definitions/NextHopParameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/nextHop'].post.responses.200.schema.$ref` | `#/definitions/NextHopResult` | `./common.json/definitions/NextHopResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/nextHop'].post.responses.202.schema.$ref` | `#/definitions/NextHopResult` | `./common.json/definitions/NextHopResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/nextHop'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures'].get.responses.200.schema.$ref` | `#/definitions/PacketCaptureListResult` | `./common.json/definitions/PacketCaptureListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}'].delete.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}'].get.responses.200.schema.$ref` | `#/definitions/PacketCaptureResult` | `./common.json/definitions/PacketCaptureResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}'].put.parameters[2].schema.$ref` | `#/definitions/PacketCapture` | `./common.json/definitions/PacketCapture` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}'].put.responses.201.schema.$ref` | `#/definitions/PacketCaptureResult` | `./common.json/definitions/PacketCaptureResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}'].put.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}/queryStatus'].post.responses.200.schema.$ref` | `#/definitions/PacketCaptureQueryStatusResult` | `./common.json/definitions/PacketCaptureQueryStatusResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}/queryStatus'].post.responses.202.schema.$ref` | `#/definitions/PacketCaptureQueryStatusResult` | `./common.json/definitions/PacketCaptureQueryStatusResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}/queryStatus'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}/stop'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/queryFlowLogStatus'].post.parameters[1].schema.$ref` | `#/definitions/FlowLogStatusParameters` | `./common.json/definitions/FlowLogStatusParameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/queryFlowLogStatus'].post.responses.200.schema.$ref` | `#/definitions/FlowLogInformation` | `./common.json/definitions/FlowLogInformation` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/queryFlowLogStatus'].post.responses.202.schema.$ref` | `#/definitions/FlowLogInformation` | `./common.json/definitions/FlowLogInformation` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/queryFlowLogStatus'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/queryTroubleshootResult'].post.parameters[1].schema.$ref` | `#/definitions/QueryTroubleshootingParameters` | `./common.json/definitions/QueryTroubleshootingParameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/queryTroubleshootResult'].post.responses.200.schema.$ref` | `#/definitions/TroubleshootingResult` | `./common.json/definitions/TroubleshootingResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/queryTroubleshootResult'].post.responses.202.schema.$ref` | `#/definitions/TroubleshootingResult` | `./common.json/definitions/TroubleshootingResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/queryTroubleshootResult'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/securityGroupView'].post.parameters[1].schema.$ref` | `#/definitions/SecurityGroupViewParameters` | `./common.json/definitions/SecurityGroupViewParameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/securityGroupView'].post.responses.200.schema.$ref` | `#/definitions/SecurityGroupViewResult` | `./common.json/definitions/SecurityGroupViewResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/securityGroupView'].post.responses.202.schema.$ref` | `#/definitions/SecurityGroupViewResult` | `./common.json/definitions/SecurityGroupViewResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/securityGroupView'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/topology'].post.parameters[1].schema.$ref` | `#/definitions/TopologyParameters` | `./common.json/definitions/TopologyParameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/topology'].post.responses.200.schema.$ref` | `#/definitions/Topology` | `./common.json/definitions/Topology` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/topology'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/troubleshoot'].post.parameters[1].schema.$ref` | `#/definitions/TroubleshootingParameters` | `./common.json/definitions/TroubleshootingParameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/troubleshoot'].post.responses.200.schema.$ref` | `#/definitions/TroubleshootingResult` | `./common.json/definitions/TroubleshootingResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/troubleshoot'].post.responses.202.schema.$ref` | `#/definitions/TroubleshootingResult` | `./common.json/definitions/TroubleshootingResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/troubleshoot'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `./common.json/definitions/ErrorResponse` |

