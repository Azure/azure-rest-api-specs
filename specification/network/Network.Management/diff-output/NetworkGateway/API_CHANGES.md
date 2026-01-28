## Changed Paths

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/getikesas
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/resetconnection
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey/reset
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/startPacketCapture
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/stopPacketCapture
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/vpndeviceconfigurationscript
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}
Change Type: deleted

## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/abortMigration'].post.tags__added` | added | `["VirtualNetworkGateways"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/commitMigration'].post.tags__added` | added | `["VirtualNetworkGateways"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/executeMigration'].post.tags__added` | added | `["VirtualNetworkGateways"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/prepareMigration'].post.tags__added` | added | `["VirtualNetworkGateways"]` |
| `tags__added` | added | `[{"name":"VirtualNetworkGateways"},{"name":"VirtualNetworkTaps"}]` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections__deleted']` | deleted | `{"get":{"operationId":"VirtualNetworkGatewayConnections_List","tags":["VirtualNetworkGatewayConnecti...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}__deleted']` | deleted | `{"get":{"operationId":"VirtualNetworkGatewayConnections_Get","tags":["VirtualNetworkGatewayConnectio...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/getikesas`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/getikesas__deleted']` | deleted | `{"post":{"operationId":"VirtualNetworkGatewayConnections_GetIkeSas","tags":["VirtualNetworkGatewayCo...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/resetconnection`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/resetconnection__deleted']` | deleted | `{"post":{"operationId":"VirtualNetworkGatewayConnections_ResetConnection","tags":["VirtualNetworkGat...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey__deleted']` | deleted | `{"get":{"operationId":"VirtualNetworkGatewayConnections_GetSharedKey","tags":["VirtualNetworkGateway...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey/reset`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey/reset__deleted']` | deleted | `{"post":{"operationId":"VirtualNetworkGatewayConnections_ResetSharedKey","tags":["VirtualNetworkGate...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/startPacketCapture`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/startPacketCapture__deleted']` | deleted | `{"post":{"operationId":"VirtualNetworkGatewayConnections_StartPacketCapture","tags":["VirtualNetwork...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/stopPacketCapture`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/stopPacketCapture__deleted']` | deleted | `{"post":{"operationId":"VirtualNetworkGatewayConnections_StopPacketCapture","tags":["VirtualNetworkG...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/vpndeviceconfigurationscript`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/vpndeviceconfigurationscript__deleted']` | deleted | `{"post":{"operationId":"VirtualNetworkGateways_VpnDeviceConfigurationScript","tags":["VirtualNetwork...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways__deleted']` | deleted | `{"get":{"operationId":"LocalNetworkGateways_List","tags":["LocalNetworkGateways"],"parameters":[],"r...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}__deleted']` | deleted | `{"get":{"operationId":"LocalNetworkGateways_Get","tags":["LocalNetworkGateways"],"parameters":[{"nam...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules__deleted']` | deleted | `{"get":{"operationId":"VirtualNetworkGatewayNatRules_ListByVirtualNetworkGateway","parameters":[{"na...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}__deleted']` | deleted | `{"get":{"operationId":"VirtualNetworkGatewayNatRules_Get","parameters":[{"name":"virtualNetworkGatew...` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/disconnectVirtualNetworkGatewayVpnConnections'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnclientpackage'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnprofile'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getAdvertisedRoutes'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getBgpPeerStatus'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getLearnedRoutes'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getVpnClientConnectionHealth'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getvpnclientipsecparameters'].post.responses.200.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getvpnprofilepackageurl'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/reset'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/resetvpnclientsharedkey'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/setvpnclientipsecparameters'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startPacketCapture'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopPacketCapture'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetworkGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetworkGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetworkTap` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/abortMigration'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/commitMigration'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/executeMigration'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverAllTestsDetails'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverSingleTestDetails'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getResiliencyInformation'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getRoutesInformation'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/prepareMigration'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startSiteFailoverTest'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopSiteFailoverTest'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |

### Changes for `Location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/abortMigration'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/commitMigration'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/executeMigration'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverAllTestsDetails'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverSingleTestDetails'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getResiliencyInformation'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getRoutesInformation'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/prepareMigration'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startSiteFailoverTest'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopSiteFailoverTest'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BgpPeerStatus.properties.state.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteFailoverTestDetails.properties.status.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteFailoverTestDetails.properties.testType.type__deleted` | deleted | `string` |
| `definitions.IpsecPolicy.properties.dhGroup.type__deleted` | deleted | `string` |
| `definitions.IpsecPolicy.properties.ikeEncryption.type__deleted` | deleted | `string` |
| `definitions.IpsecPolicy.properties.ikeIntegrity.type__deleted` | deleted | `string` |
| `definitions.IpsecPolicy.properties.ipsecEncryption.type__deleted` | deleted | `string` |
| `definitions.IpsecPolicy.properties.ipsecIntegrity.type__deleted` | deleted | `string` |
| `definitions.IpsecPolicy.properties.pfsGroup.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.authenticationType.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionMode.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionProtocol.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionStatus.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionType.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.mode.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.type.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayPolicyGroupMember.properties.attributeType.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewaySku.properties.name.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewaySku.properties.tier.type__deleted` | deleted | `string` |
| `definitions.VpnClientConfiguration.properties.vpnAuthenticationTypes.items.type__deleted` | deleted | `string` |
| `definitions.VpnClientConfiguration.properties.vpnClientProtocols.items.type__deleted` | deleted | `string` |
| `definitions.VpnClientIPsecParameters.properties.dhGroup.type__deleted` | deleted | `string` |
| `definitions.VpnClientIPsecParameters.properties.ikeEncryption.type__deleted` | deleted | `string` |
| `definitions.VpnClientIPsecParameters.properties.ikeIntegrity.type__deleted` | deleted | `string` |
| `definitions.VpnClientIPsecParameters.properties.ipsecEncryption.type__deleted` | deleted | `string` |
| `definitions.VpnClientIPsecParameters.properties.ipsecIntegrity.type__deleted` | deleted | `string` |
| `definitions.VpnClientIPsecParameters.properties.pfsGroup.type__deleted` | deleted | `string` |
| `definitions.VpnClientParameters.properties.processorArchitecture.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnclientpackage'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnprofile'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverAllTestsDetails'].post.responses.200.schema.type__added` | added | `array` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverSingleTestDetails'].post.responses.200.schema.type__added` | added | `array` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getvpnprofilepackageurl'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startPacketCapture'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startSiteFailoverTest'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopPacketCapture'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopSiteFailoverTest'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/supportedvpndevices'].post.responses.200.schema.type__deleted` | deleted | `string` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BgpPeerStatus.properties.state.$ref__added` | added | `./common.json/definitions/BgpPeerState` |
| `definitions.ExpressRouteFailoverTestDetails.properties.status.$ref__added` | added | `./common.json/definitions/FailoverTestStatus` |
| `definitions.ExpressRouteFailoverTestDetails.properties.testType.$ref__added` | added | `./common.json/definitions/FailoverTestType` |
| `definitions.IpsecPolicy.properties.dhGroup.$ref__added` | added | `./common.json/definitions/DhGroup` |
| `definitions.IpsecPolicy.properties.ikeEncryption.$ref__added` | added | `./common.json/definitions/IkeEncryption` |
| `definitions.IpsecPolicy.properties.ikeIntegrity.$ref__added` | added | `./common.json/definitions/IkeIntegrity` |
| `definitions.IpsecPolicy.properties.ipsecEncryption.$ref__added` | added | `./common.json/definitions/IpsecEncryption` |
| `definitions.IpsecPolicy.properties.ipsecIntegrity.$ref__added` | added | `./common.json/definitions/IpsecIntegrity` |
| `definitions.IpsecPolicy.properties.pfsGroup.$ref__added` | added | `./common.json/definitions/PfsGroup` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.authenticationType.$ref__added` | added | `./common.json/definitions/ConnectionAuthenticationType` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionMode.$ref__added` | added | `./common.json/definitions/VirtualNetworkGatewayConnectionMode` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionProtocol.$ref__added` | added | `./common.json/definitions/VirtualNetworkGatewayConnectionProtocol` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionStatus.$ref__added` | added | `./common.json/definitions/VirtualNetworkGatewayConnectionStatus` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionType.$ref__added` | added | `./common.json/definitions/VirtualNetworkGatewayConnectionType` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.mode.$ref__added` | added | `./common.json/definitions/VpnNatRuleMode` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.type.$ref__added` | added | `./common.json/definitions/VpnNatRuleType` |
| `definitions.VirtualNetworkGatewayPolicyGroupMember.properties.attributeType.$ref__added` | added | `./common.json/definitions/VpnPolicyMemberAttributeType` |
| `definitions.VirtualNetworkGatewaySku.properties.name.$ref__added` | added | `./common.json/definitions/VirtualNetworkGatewaySkuName` |
| `definitions.VirtualNetworkGatewaySku.properties.tier.$ref__added` | added | `./common.json/definitions/VirtualNetworkGatewaySkuTier` |
| `definitions.VpnClientConfiguration.properties.vpnAuthenticationTypes.items.$ref__added` | added | `./common.json/definitions/VpnAuthenticationType` |
| `definitions.VpnClientConfiguration.properties.vpnClientProtocols.items.$ref__added` | added | `./common.json/definitions/VpnClientProtocol` |
| `definitions.VpnClientIPsecParameters.properties.dhGroup.$ref__added` | added | `./common.json/definitions/DhGroup` |
| `definitions.VpnClientIPsecParameters.properties.ikeEncryption.$ref__added` | added | `./common.json/definitions/IkeEncryption` |
| `definitions.VpnClientIPsecParameters.properties.ikeIntegrity.$ref__added` | added | `./common.json/definitions/IkeIntegrity` |
| `definitions.VpnClientIPsecParameters.properties.ipsecEncryption.$ref__added` | added | `./common.json/definitions/IpsecEncryption` |
| `definitions.VpnClientIPsecParameters.properties.ipsecIntegrity.$ref__added` | added | `./common.json/definitions/IpsecIntegrity` |
| `definitions.VpnClientIPsecParameters.properties.pfsGroup.$ref__added` | added | `./common.json/definitions/PfsGroup` |
| `definitions.VpnClientParameters.properties.processorArchitecture.$ref__added` | added | `./common.json/definitions/ProcessorArchitecture` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnclientpackage'].post.responses.200.schema.$ref__added` | added | `./common.json/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnprofile'].post.responses.200.schema.$ref__added` | added | `./common.json/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverAllTestsDetails'].post.responses.200.schema.$ref__deleted` | deleted | `#/definitions/ExpressRouteFailoverAllTestDetails` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverSingleTestDetails'].post.responses.200.schema.$ref__deleted` | deleted | `#/definitions/ExpressRouteFailoverSingleTestDetailsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getvpnprofilepackageurl'].post.responses.200.schema.$ref__added` | added | `./common.json/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startPacketCapture'].post.responses.200.schema.$ref__added` | added | `./common.json/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startSiteFailoverTest'].post.responses.200.schema.$ref__added` | added | `./common.json/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopPacketCapture'].post.responses.200.schema.$ref__added` | added | `./common.json/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopSiteFailoverTest'].post.responses.200.schema.$ref__added` | added | `./common.json/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/supportedvpndevices'].post.responses.200.schema.$ref__added` | added | `./common.json/definitions/stringApplicationJson` |

### Changes for `items`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverAllTestsDetails'].post.responses.200.schema.items__added` | added | `{"$ref":"#/definitions/ExpressRouteFailoverTestDetails"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverSingleTestDetails'].post.responses.200.schema.items__added` | added | `{"$ref":"./common.json/definitions/ExpressRouteFailoverSingleTestDetails"}` |

### Changes for `ConnectionSharedKey`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionSharedKey__deleted` | deleted | `{"type":"object","properties":{"value":{"type":"string"}},"required":["value"],"allOf":[{"$ref":"./n...` |

### Changes for `ExpressRouteFailoverAllTestDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteFailoverAllTestDetails__deleted` | deleted | `{"type":"array","items":{"$ref":"#/definitions/ExpressRouteFailoverTestDetails"}}` |

### Changes for `ExpressRouteFailoverCircuitResourceDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteFailoverCircuitResourceDetails__deleted` | deleted | `{"type":"object","properties":{"nrpResourceUri":{"type":"string","format":"arm-id"},"name":{"type":"...` |

### Changes for `ExpressRouteFailoverConnectionResourceDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteFailoverConnectionResourceDetails__deleted` | deleted | `{"type":"object","properties":{"nrpResourceUri":{"type":"string","format":"arm-id"},"name":{"type":"...` |

### Changes for `ExpressRouteFailoverRedundantRoute`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteFailoverRedundantRoute__deleted` | deleted | `{"type":"object","properties":{"peeringLocations":{"type":"array","items":{"type":"string"}},"routes...` |

### Changes for `ExpressRouteFailoverSingleTestDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteFailoverSingleTestDetails__deleted` | deleted | `{"type":"object","properties":{"peeringLocation":{"type":"string"},"status":{"type":"string","enum":...` |

### Changes for `ExpressRouteFailoverSingleTestDetailsObject`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteFailoverSingleTestDetailsObject__deleted` | deleted | `{"type":"array","items":{"$ref":"#/definitions/ExpressRouteFailoverSingleTestDetails"}}` |

### Changes for `ExpressRouteFailoverStopApiParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteFailoverStopApiParameters__deleted` | deleted | `{"type":"object","properties":{"peeringLocation":{"type":"string"},"wasSimulationSuccessful":{"type"...` |

### Changes for `FailoverConnectionDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FailoverConnectionDetails__deleted` | deleted | `{"type":"object","properties":{"failoverConnectionName":{"type":"string"},"failoverLocation":{"type"...` |

### Changes for `GatewayResiliencyInformation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GatewayResiliencyInformation__deleted` | deleted | `{"type":"object","properties":{"overallScore":{"type":"string"},"scoreChange":{"type":"string"},"min...` |

### Changes for `GatewayResiliencyRecommendation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GatewayResiliencyRecommendation__deleted` | deleted | `{"type":"object","properties":{"recommendationTitle":{"type":"string"},"recommendationId":{"type":"s...` |

### Changes for `GatewayRouteSet`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GatewayRouteSet__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"locations":{"type":"array","items":{"type":...` |

### Changes for `GatewayRouteSetsInformation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GatewayRouteSetsInformation__deleted` | deleted | `{"type":"object","properties":{"lastComputedTime":{"type":"string","format":"date-time"},"nextEligib...` |

### Changes for `ListVirtualNetworkGatewayNatRulesResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ListVirtualNetworkGatewayNatRulesResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `LocalNetworkGateway`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LocalNetworkGateway__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/LocalNetworkGatewayPropertiesForm...` |

### Changes for `LocalNetworkGatewayListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LocalNetworkGatewayListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `RadiusAuthServerListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RadiusAuthServerListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `RadiusServer`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RadiusServer__deleted` | deleted | `{"type":"object","properties":{"radiusServerAddress":{"type":"string"},"radiusServerScore":{"type":"...` |

### Changes for `ResiliencyRecommendationComponents`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResiliencyRecommendationComponents__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"currentScore":{"type":"string"},"maxScore":...` |

### Changes for `RouteSourceDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RouteSourceDetails__deleted` | deleted | `{"type":"object","properties":{"circuit":{"type":"string"},"pri":{"type":"string"},"sec":{"type":"st...` |

### Changes for `TrafficSelectorPolicy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TrafficSelectorPolicy__deleted` | deleted | `{"type":"object","properties":{"localAddressRanges":{"type":"array","items":{"type":"string"}},"remo...` |

### Changes for `TunnelConnectionHealth`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TunnelConnectionHealth__deleted` | deleted | `{"type":"object","properties":{"tunnel":{"type":"string","readOnly":true},"connectionStatus":{"type"...` |

### Changes for `VirtualNetworkConnectionGatewayReference`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkConnectionGatewayReference__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string"}},"required":["id"]}` |

### Changes for `VirtualNetworkGatewayAutoScaleBounds`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkGatewayAutoScaleBounds__deleted` | deleted | `{"type":"object","properties":{"min":{"type":"integer"},"max":{"type":"integer"}}}` |

### Changes for `VirtualNetworkGatewayAutoScaleConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkGatewayAutoScaleConfiguration__deleted` | deleted | `{"type":"object","properties":{"bounds":{"$ref":"#/definitions/VirtualNetworkGatewayAutoScaleBounds"...` |

### Changes for `VirtualNetworkGatewayConnection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkGatewayConnection__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/VirtualNetworkGatewayConnectionPr...` |

### Changes for `VirtualNetworkGatewayConnectionListEntity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkGatewayConnectionListEntity__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/VirtualNetworkGatewayConnectionLi...` |

### Changes for `VirtualNetworkGatewayConnectionListEntityPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"authorizationKey":{"type":"string"},"virtualNetworkGateway1":{"$ref"...` |

### Changes for `VirtualNetworkGatewayConnectionListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkGatewayConnectionListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `VirtualNetworkGatewayConnectionTunnelProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkGatewayConnectionTunnelProperties__deleted` | deleted | `{"type":"object","properties":{"tunnelIpAddress":{"type":"string"},"bgpPeeringAddress":{"type":"stri...` |

### Changes for `VirtualNetworkGatewayIPConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkGatewayIPConfiguration__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/VirtualNetworkGatewayIPConfigurat...` |

### Changes for `VirtualNetworkGatewayListConnectionsResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkGatewayListConnectionsResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `VirtualNetworkGatewayMigrationParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkGatewayMigrationParameters__deleted` | deleted | `{"type":"object","properties":{"migrationType":{"type":"string","enum":["UpgradeDeploymentToStandard...` |

### Changes for `VirtualNetworkGatewayMigrationStatus`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkGatewayMigrationStatus__deleted` | deleted | `{"type":"object","properties":{"state":{"type":"string","enum":["None","InProgress","Succeeded","Fai...` |

### Changes for `VirtualNetworkGatewayNatRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkGatewayNatRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/VirtualNetworkGatewayNatRulePrope...` |

### Changes for `VirtualNetworkGatewayPolicyGroup`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkGatewayPolicyGroup__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/VirtualNetworkGatewayPolicyGroupP...` |

### Changes for `VirtualNetworkGatewayPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkGatewayPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"autoScaleConfiguration":{"$ref":"#/definitions/VirtualNetworkGateway...` |

### Changes for `VirtualNetworkTapPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkTapPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"networkInterfaceTapConfigurations":{"type":"array","items":{"$ref":"...` |

### Changes for `VngClientConnectionConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VngClientConnectionConfiguration__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/VngClientConnectionConfigurationP...` |

### Changes for `VpnClientRevokedCertificate`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VpnClientRevokedCertificate__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/VpnClientRevokedCertificateProper...` |

### Changes for `VpnClientRevokedCertificatePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VpnClientRevokedCertificatePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"thumbprint":{"type":"string"},"provisioningState":{"$ref":"./network...` |

### Changes for `VpnClientRootCertificate`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VpnClientRootCertificate__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/VpnClientRootCertificatePropertie...` |

### Changes for `VpnClientRootCertificatePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VpnClientRootCertificatePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"publicCertData":{"type":"string"},"provisioningState":{"$ref":"./net...` |

### Changes for `VpnClientConnectionHealth`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VpnClientConnectionHealth__added` | added | `{"type":"object","properties":{"totalIngressBytesTransferred":{"type":"integer","format":"int64","re...` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BgpPeerStatus.properties.state.enum__deleted` | deleted | `["Unknown","Stopped","Idle","Connecting","Connected"]` |
| `definitions.ExpressRouteFailoverTestDetails.properties.status.enum__deleted` | deleted | `["NotStarted","Starting","Running","StartFailed","Stopping","Completed","StopFailed","Invalid","Expi...` |
| `definitions.ExpressRouteFailoverTestDetails.properties.testType.enum__deleted` | deleted | `["SingleSiteFailover","MultiSiteFailover","All"]` |
| `definitions.IpsecPolicy.properties.dhGroup.enum__deleted` | deleted | `["None","DHGroup1","DHGroup2","DHGroup14","DHGroup2048","ECP256","ECP384","DHGroup24"]` |
| `definitions.IpsecPolicy.properties.ikeEncryption.enum__deleted` | deleted | `["DES","DES3","AES128","AES192","AES256","GCMAES256","GCMAES128"]` |
| `definitions.IpsecPolicy.properties.ikeIntegrity.enum__deleted` | deleted | `["MD5","SHA1","SHA256","SHA384","GCMAES256","GCMAES128"]` |
| `definitions.IpsecPolicy.properties.ipsecEncryption.enum__deleted` | deleted | `["None","DES","DES3","AES128","AES192","AES256","GCMAES128","GCMAES192","GCMAES256"]` |
| `definitions.IpsecPolicy.properties.ipsecIntegrity.enum__deleted` | deleted | `["MD5","SHA1","SHA256","GCMAES128","GCMAES192","GCMAES256"]` |
| `definitions.IpsecPolicy.properties.pfsGroup.enum__deleted` | deleted | `["None","PFS1","PFS2","PFS2048","ECP256","ECP384","PFS24","PFS14","PFSMM"]` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.authenticationType.enum__deleted` | deleted | `["PSK","Certificate"]` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionMode.enum__deleted` | deleted | `["Default","ResponderOnly","InitiatorOnly"]` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionProtocol.enum__deleted` | deleted | `["IKEv2","IKEv1"]` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionStatus.enum__deleted` | deleted | `["Unknown","Connecting","Connected","NotConnected"]` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionType.enum__deleted` | deleted | `["IPsec","Vnet2Vnet","ExpressRoute","VPNClient"]` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.mode.enum__deleted` | deleted | `["EgressSnat","IngressSnat"]` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.type.enum__deleted` | deleted | `["Static","Dynamic"]` |
| `definitions.VirtualNetworkGatewayPolicyGroupMember.properties.attributeType.enum__deleted` | deleted | `["CertificateGroupId","AADGroupId","RadiusAzureGroupId"]` |
| `definitions.VirtualNetworkGatewaySku.properties.name.enum__deleted` | deleted | `["Basic","HighPerformance","Standard","UltraPerformance","VpnGw1","VpnGw2","VpnGw3","VpnGw4","VpnGw5...` |
| `definitions.VirtualNetworkGatewaySku.properties.tier.enum__deleted` | deleted | `["Basic","HighPerformance","Standard","UltraPerformance","VpnGw1","VpnGw2","VpnGw3","VpnGw4","VpnGw5...` |
| `definitions.VpnClientConfiguration.properties.vpnAuthenticationTypes.items.enum__deleted` | deleted | `["Certificate","Radius","AAD"]` |
| `definitions.VpnClientConfiguration.properties.vpnClientProtocols.items.enum__deleted` | deleted | `["IkeV2","SSTP","OpenVPN"]` |
| `definitions.VpnClientIPsecParameters.properties.dhGroup.enum__deleted` | deleted | `["None","DHGroup1","DHGroup2","DHGroup14","DHGroup2048","ECP256","ECP384","DHGroup24"]` |
| `definitions.VpnClientIPsecParameters.properties.ikeEncryption.enum__deleted` | deleted | `["DES","DES3","AES128","AES192","AES256","GCMAES256","GCMAES128"]` |
| `definitions.VpnClientIPsecParameters.properties.ikeIntegrity.enum__deleted` | deleted | `["MD5","SHA1","SHA256","SHA384","GCMAES256","GCMAES128"]` |
| `definitions.VpnClientIPsecParameters.properties.ipsecEncryption.enum__deleted` | deleted | `["None","DES","DES3","AES128","AES192","AES256","GCMAES128","GCMAES192","GCMAES256"]` |
| `definitions.VpnClientIPsecParameters.properties.ipsecIntegrity.enum__deleted` | deleted | `["MD5","SHA1","SHA256","GCMAES128","GCMAES192","GCMAES256"]` |
| `definitions.VpnClientIPsecParameters.properties.pfsGroup.enum__deleted` | deleted | `["None","PFS1","PFS2","PFS2048","ECP256","ECP384","PFS24","PFS14","PFSMM"]` |
| `definitions.VpnClientParameters.properties.processorArchitecture.enum__deleted` | deleted | `["Amd64","X86"]` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BgpPeerStatus.properties.state['x-ms-enum__deleted']` | deleted | `{"name":"BgpPeerState","modelAsString":true}` |
| `definitions.ExpressRouteFailoverTestDetails.properties.status['x-ms-enum__deleted']` | deleted | `{"name":"FailoverTestStatus","modelAsString":true}` |
| `definitions.ExpressRouteFailoverTestDetails.properties.testType['x-ms-enum__deleted']` | deleted | `{"name":"FailoverTestType","modelAsString":true}` |
| `definitions.IpsecPolicy.properties.dhGroup['x-ms-enum__deleted']` | deleted | `{"name":"DhGroup","modelAsString":true}` |
| `definitions.IpsecPolicy.properties.ikeEncryption['x-ms-enum__deleted']` | deleted | `{"name":"IkeEncryption","modelAsString":true}` |
| `definitions.IpsecPolicy.properties.ikeIntegrity['x-ms-enum__deleted']` | deleted | `{"name":"IkeIntegrity","modelAsString":true}` |
| `definitions.IpsecPolicy.properties.ipsecEncryption['x-ms-enum__deleted']` | deleted | `{"name":"IpsecEncryption","modelAsString":true}` |
| `definitions.IpsecPolicy.properties.ipsecIntegrity['x-ms-enum__deleted']` | deleted | `{"name":"IpsecIntegrity","modelAsString":true}` |
| `definitions.IpsecPolicy.properties.pfsGroup['x-ms-enum__deleted']` | deleted | `{"name":"PfsGroup","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.authenticationType['x-ms-enum__deleted']` | deleted | `{"name":"ConnectionAuthenticationType","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionMode['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewayConnectionMode","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionProtocol['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewayConnectionProtocol","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionStatus['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewayConnectionStatus","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionType['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewayConnectionType","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.mode['x-ms-enum__deleted']` | deleted | `{"name":"VpnNatRuleMode","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"VpnNatRuleType","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayPolicyGroupMember.properties.attributeType['x-ms-enum__deleted']` | deleted | `{"name":"VpnPolicyMemberAttributeType","modelAsString":true}` |
| `definitions.VirtualNetworkGatewaySku.properties.name['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewaySkuName","modelAsString":true}` |
| `definitions.VirtualNetworkGatewaySku.properties.tier['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewaySkuTier","modelAsString":true}` |
| `definitions.VpnClientConfiguration.properties.vpnAuthenticationTypes.items['x-ms-enum__deleted']` | deleted | `{"name":"VpnAuthenticationType","modelAsString":true}` |
| `definitions.VpnClientConfiguration.properties.vpnClientProtocols.items['x-ms-enum__deleted']` | deleted | `{"name":"VpnClientProtocol","modelAsString":true}` |
| `definitions.VpnClientIPsecParameters.properties.dhGroup['x-ms-enum__deleted']` | deleted | `{"name":"DhGroup","modelAsString":true}` |
| `definitions.VpnClientIPsecParameters.properties.ikeEncryption['x-ms-enum__deleted']` | deleted | `{"name":"IkeEncryption","modelAsString":true}` |
| `definitions.VpnClientIPsecParameters.properties.ikeIntegrity['x-ms-enum__deleted']` | deleted | `{"name":"IkeIntegrity","modelAsString":true}` |
| `definitions.VpnClientIPsecParameters.properties.ipsecEncryption['x-ms-enum__deleted']` | deleted | `{"name":"IpsecEncryption","modelAsString":true}` |
| `definitions.VpnClientIPsecParameters.properties.ipsecIntegrity['x-ms-enum__deleted']` | deleted | `{"name":"IpsecIntegrity","modelAsString":true}` |
| `definitions.VpnClientIPsecParameters.properties.pfsGroup['x-ms-enum__deleted']` | deleted | `{"name":"PfsGroup","modelAsString":true}` |
| `definitions.VpnClientParameters.properties.processorArchitecture['x-ms-enum__deleted']` | deleted | `{"name":"ProcessorArchitecture","modelAsString":true}` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RadiusAuthServer.properties.radiusServerSecret.format__added` | added | `password` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.sharedKey.format__added` | added | `password` |
| `definitions.VpnClientConfiguration.properties.radiusServerSecret.format__added` | added | `password` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkGatewayListResult.required__added` | added | `["value"]` |
| `definitions.VirtualNetworkTapListResult.required__added` | added | `["value"]` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ExpressRouteFailoverTestDetails.properties.circuits.items.$ref` | `#/definitions/ExpressRouteFailoverCircuitResourceDetails` | `./common.json/definitions/ExpressRouteFailoverCircuitResourceDetails` |
| `definitions.ExpressRouteFailoverTestDetails.properties.connections.items.$ref` | `#/definitions/ExpressRouteFailoverConnectionResourceDetails` | `./common.json/definitions/ExpressRouteFailoverConnectionResourceDetails` |
| `definitions.LocalNetworkGatewayPropertiesFormat.properties.localNetworkAddressSpace.$ref` | `./virtualNetwork.json#/definitions/AddressSpace` | `./virtualNetwork.json/definitions/AddressSpace` |
| `definitions.LocalNetworkGatewayPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.VirtualNetworkGateway.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.VirtualNetworkGateway.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `./common.json/definitions/ExtendedLocation` |
| `definitions.VirtualNetworkGateway.properties.identity.$ref` | `./network.json#/definitions/ManagedServiceIdentity` | `./common.json/definitions/ManagedServiceIdentity` |
| `definitions.VirtualNetworkGateway.properties.properties.$ref` | `#/definitions/VirtualNetworkGatewayPropertiesFormat` | `./common.json/definitions/VirtualNetworkGatewayPropertiesFormat` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.egressNatRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.ingressNatRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.localNetworkGateway2.$ref` | `#/definitions/LocalNetworkGateway` | `./common.json/definitions/LocalNetworkGateway` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.peer.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.trafficSelectorPolicies.items.$ref` | `#/definitions/TrafficSelectorPolicy` | `./common.json/definitions/TrafficSelectorPolicy` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.tunnelConnectionStatus.items.$ref` | `#/definitions/TunnelConnectionHealth` | `./common.json/definitions/TunnelConnectionHealth` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.tunnelProperties.items.$ref` | `#/definitions/VirtualNetworkGatewayConnectionTunnelProperties` | `./common.json/definitions/VirtualNetworkGatewayConnectionTunnelProperties` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.$ref` | `./network.json#/definitions/IPAllocationMethod` | `./common.json/definitions/IPAllocationMethod` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.externalMappings.items.$ref` | `./virtualWan.json#/definitions/VpnNatRuleMapping` | `./virtualWan.json/definitions/VpnNatRuleMapping` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.internalMappings.items.$ref` | `./virtualWan.json#/definitions/VpnNatRuleMapping` | `./virtualWan.json/definitions/VpnNatRuleMapping` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.VirtualNetworkGatewayPolicyGroupProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.VirtualNetworkGatewayPolicyGroupProperties.properties.vngClientConnectionConfigurations.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.VirtualNetworkTap.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.VirtualNetworkTap.properties.properties.$ref` | `#/definitions/VirtualNetworkTapPropertiesFormat` | `./common.json/definitions/VirtualNetworkTapPropertiesFormat` |
| `definitions.VngClientConnectionConfigurationProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.VngClientConnectionConfigurationProperties.properties.virtualNetworkGatewayPolicyGroups.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.VngClientConnectionConfigurationProperties.properties.vpnClientAddressPool.$ref` | `./virtualNetwork.json#/definitions/AddressSpace` | `./virtualNetwork.json/definitions/AddressSpace` |
| `definitions.VpnClientConfiguration.properties.radiusServers.items.$ref` | `#/definitions/RadiusServer` | `./common.json/definitions/RadiusServer` |
| `definitions.VpnClientConfiguration.properties.vngClientConnectionConfigurations.items.$ref` | `#/definitions/VngClientConnectionConfiguration` | `./common.json/definitions/VngClientConnectionConfiguration` |
| `definitions.VpnClientConfiguration.properties.vpnClientAddressPool.$ref` | `./virtualNetwork.json#/definitions/AddressSpace` | `./virtualNetwork.json/definitions/AddressSpace` |
| `definitions.VpnClientConfiguration.properties.vpnClientRevokedCertificates.items.$ref` | `#/definitions/VpnClientRevokedCertificate` | `./common.json/definitions/VpnClientRevokedCertificate` |
| `definitions.VpnClientConfiguration.properties.vpnClientRootCertificates.items.$ref` | `#/definitions/VpnClientRootCertificate` | `./common.json/definitions/VpnClientRootCertificate` |
| `definitions.VpnClientParameters.properties.authenticationMethod.$ref` | `./network.json#/definitions/AuthenticationMethod` | `./common.json/definitions/AuthenticationMethod` |
| `info.description` | `The Microsoft Azure Network management API provides a RESTful set of web services that interact with Microsoft Azure Networks service to manage your network resources. The API has entities that capture the relationship between an end user and the Microsoft Azure Networks service.` | `APIs to manage web application firewall rules.` |
| `info.title` | `NetworkManagementClient` | `WebApplicationFirewallManagement` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/virtualNetworkTaps'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/abortMigration'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/commitMigration'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/connections'].get.responses.200.schema.$ref` | `#/definitions/VirtualNetworkGatewayListConnectionsResult` | `./common.json/definitions/VirtualNetworkGatewayListConnectionsResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/connections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/disconnectVirtualNetworkGatewayVpnConnections'].post.parameters[1].schema.$ref` | `./virtualWan.json#/definitions/P2SVpnConnectionRequest` | `./virtualWan.json/definitions/P2SVpnConnectionRequest` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/disconnectVirtualNetworkGatewayVpnConnections'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/executeMigration'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnclientpackage'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnprofile'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getAdvertisedRoutes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getBgpPeerStatus'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverAllTestsDetails'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverSingleTestDetails'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getLearnedRoutes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getResiliencyInformation'].post.responses.200.schema.$ref` | `#/definitions/GatewayResiliencyInformation` | `./common.json/definitions/GatewayResiliencyInformation` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getResiliencyInformation'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getRoutesInformation'].post.responses.200.schema.$ref` | `#/definitions/GatewayRouteSetsInformation` | `./common.json/definitions/GatewayRouteSetsInformation` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getRoutesInformation'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getVpnClientConnectionHealth'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getvpnclientipsecparameters'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getvpnprofilepackageurl'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/listRadiusSecrets'].post.responses.200.schema.$ref` | `#/definitions/RadiusAuthServerListResult` | `./common.json/definitions/RadiusAuthServerListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/listRadiusSecrets'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/prepareMigration'].post.parameters[1].schema.$ref` | `#/definitions/VirtualNetworkGatewayMigrationParameters` | `./common.json/definitions/VirtualNetworkGatewayMigrationParameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/prepareMigration'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/reset'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/resetvpnclientsharedkey'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/setvpnclientipsecparameters'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startPacketCapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startSiteFailoverTest'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopPacketCapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopSiteFailoverTest'].post.parameters[1].schema.$ref` | `#/definitions/ExpressRouteFailoverStopApiParameters` | `./common.json/definitions/ExpressRouteFailoverStopApiParameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopSiteFailoverTest'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/supportedvpndevices'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |

