## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/abortMigration'].post.tags__added` | added | `["VirtualNetworkGateways"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/commitMigration'].post.tags__added` | added | `["VirtualNetworkGateways"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/executeMigration'].post.tags__added` | added | `["VirtualNetworkGateways"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules'].get.tags__added` | added | `["VirtualNetworkGatewayNatRules"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}'].delete.tags__added` | added | `["VirtualNetworkGatewayNatRules"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}'].get.tags__added` | added | `["VirtualNetworkGatewayNatRules"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}'].put.tags__added` | added | `["VirtualNetworkGatewayNatRules"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/prepareMigration'].post.tags__added` | added | `["VirtualNetworkGateways"]` |
| `tags__added` | added | `[{"name":"VirtualNetworkGateways"},{"name":"VirtualNetworkGatewayConnections"},{"name":"LocalNetwork...` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/getikesas'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/resetconnection'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey/reset'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/startPacketCapture'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/stopPacketCapture'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetworkGatewayConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetworkGatewayConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ConnectionSharedKey` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/LocalNetworkGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetworkGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetworkGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetworkGatewayNatRule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetworkTap` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BgpPeerStatus.properties.state.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteFailoverConnectionResourceDetails.properties.status.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteFailoverSingleTestDetails.properties.status.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteFailoverTestDetails.properties.status.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteFailoverTestDetails.properties.testType.type__deleted` | deleted | `string` |
| `definitions.IpsecPolicy.properties.dhGroup.type__deleted` | deleted | `string` |
| `definitions.IpsecPolicy.properties.ikeEncryption.type__deleted` | deleted | `string` |
| `definitions.IpsecPolicy.properties.ikeIntegrity.type__deleted` | deleted | `string` |
| `definitions.IpsecPolicy.properties.ipsecEncryption.type__deleted` | deleted | `string` |
| `definitions.IpsecPolicy.properties.ipsecIntegrity.type__deleted` | deleted | `string` |
| `definitions.IpsecPolicy.properties.pfsGroup.type__deleted` | deleted | `string` |
| `definitions.TunnelConnectionHealth.properties.connectionStatus.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.connectionMode.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.connectionProtocol.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.connectionStatus.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.connectionType.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.authenticationType.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionMode.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionProtocol.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionStatus.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionType.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayMigrationParameters.properties.migrationType.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayMigrationStatus.properties.phase.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayMigrationStatus.properties.state.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayNatRule.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.mode.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.type.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayPolicyGroupMember.properties.attributeType.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.adminState.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.gatewayType.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.resiliencyModel.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.vpnGatewayGeneration.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.vpnType.type__deleted` | deleted | `string` |
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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/getikesas'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/startPacketCapture'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/stopPacketCapture'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/vpndeviceconfigurationscript'].post.responses.200.schema.type__deleted` | deleted | `string` |
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
| `definitions.BgpPeerStatus.properties.state.$ref__added` | added | `./common.json#/definitions/BgpPeerState` |
| `definitions.ExpressRouteFailoverConnectionResourceDetails.properties.status.$ref__added` | added | `./common.json#/definitions/FailoverConnectionStatus` |
| `definitions.ExpressRouteFailoverSingleTestDetails.properties.status.$ref__added` | added | `./common.json#/definitions/FailoverTestStatusForSingleTest` |
| `definitions.ExpressRouteFailoverTestDetails.properties.status.$ref__added` | added | `./common.json#/definitions/FailoverTestStatus` |
| `definitions.ExpressRouteFailoverTestDetails.properties.testType.$ref__added` | added | `./common.json#/definitions/FailoverTestType` |
| `definitions.IpsecPolicy.properties.dhGroup.$ref__added` | added | `./common.json#/definitions/DhGroup` |
| `definitions.IpsecPolicy.properties.ikeEncryption.$ref__added` | added | `./common.json#/definitions/IkeEncryption` |
| `definitions.IpsecPolicy.properties.ikeIntegrity.$ref__added` | added | `./common.json#/definitions/IkeIntegrity` |
| `definitions.IpsecPolicy.properties.ipsecEncryption.$ref__added` | added | `./common.json#/definitions/IpsecEncryption` |
| `definitions.IpsecPolicy.properties.ipsecIntegrity.$ref__added` | added | `./common.json#/definitions/IpsecIntegrity` |
| `definitions.IpsecPolicy.properties.pfsGroup.$ref__added` | added | `./common.json#/definitions/PfsGroup` |
| `definitions.TunnelConnectionHealth.properties.connectionStatus.$ref__added` | added | `./common.json#/definitions/VirtualNetworkGatewayConnectionStatus` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.connectionMode.$ref__added` | added | `./common.json#/definitions/VirtualNetworkGatewayConnectionMode` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.connectionProtocol.$ref__added` | added | `./common.json#/definitions/VirtualNetworkGatewayConnectionProtocol` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.connectionStatus.$ref__added` | added | `./common.json#/definitions/VirtualNetworkGatewayConnectionStatus` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.connectionType.$ref__added` | added | `./common.json#/definitions/VirtualNetworkGatewayConnectionType` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.authenticationType.$ref__added` | added | `./common.json#/definitions/ConnectionAuthenticationType` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionMode.$ref__added` | added | `./common.json#/definitions/VirtualNetworkGatewayConnectionMode` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionProtocol.$ref__added` | added | `./common.json#/definitions/VirtualNetworkGatewayConnectionProtocol` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionStatus.$ref__added` | added | `./common.json#/definitions/VirtualNetworkGatewayConnectionStatus` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionType.$ref__added` | added | `./common.json#/definitions/VirtualNetworkGatewayConnectionType` |
| `definitions.VirtualNetworkGatewayMigrationParameters.properties.migrationType.$ref__added` | added | `./common.json#/definitions/VirtualNetworkGatewayMigrationType` |
| `definitions.VirtualNetworkGatewayMigrationStatus.properties.phase.$ref__added` | added | `./common.json#/definitions/VirtualNetworkGatewayMigrationPhase` |
| `definitions.VirtualNetworkGatewayMigrationStatus.properties.state.$ref__added` | added | `./common.json#/definitions/VirtualNetworkGatewayMigrationState` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.mode.$ref__added` | added | `./common.json#/definitions/VpnNatRuleMode` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.type.$ref__added` | added | `./common.json#/definitions/VpnNatRuleType` |
| `definitions.VirtualNetworkGatewayPolicyGroupMember.properties.attributeType.$ref__added` | added | `./common.json#/definitions/VpnPolicyMemberAttributeType` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.adminState.$ref__added` | added | `./common.json#/definitions/AdminState` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.gatewayType.$ref__added` | added | `./common.json#/definitions/VirtualNetworkGatewayType` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.resiliencyModel.$ref__added` | added | `./common.json#/definitions/ResiliencyModel` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.vpnGatewayGeneration.$ref__added` | added | `./common.json#/definitions/VpnGatewayGeneration` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.vpnType.$ref__added` | added | `./common.json#/definitions/VpnType` |
| `definitions.VirtualNetworkGatewaySku.properties.name.$ref__added` | added | `./common.json#/definitions/VirtualNetworkGatewaySkuName` |
| `definitions.VirtualNetworkGatewaySku.properties.tier.$ref__added` | added | `./common.json#/definitions/VirtualNetworkGatewaySkuTier` |
| `definitions.VpnClientConfiguration.properties.vpnAuthenticationTypes.items.$ref__added` | added | `./common.json#/definitions/VpnAuthenticationType` |
| `definitions.VpnClientConfiguration.properties.vpnClientProtocols.items.$ref__added` | added | `./common.json#/definitions/VpnClientProtocol` |
| `definitions.VpnClientIPsecParameters.properties.dhGroup.$ref__added` | added | `./common.json#/definitions/DhGroup` |
| `definitions.VpnClientIPsecParameters.properties.ikeEncryption.$ref__added` | added | `./common.json#/definitions/IkeEncryption` |
| `definitions.VpnClientIPsecParameters.properties.ikeIntegrity.$ref__added` | added | `./common.json#/definitions/IkeIntegrity` |
| `definitions.VpnClientIPsecParameters.properties.ipsecEncryption.$ref__added` | added | `./common.json#/definitions/IpsecEncryption` |
| `definitions.VpnClientIPsecParameters.properties.ipsecIntegrity.$ref__added` | added | `./common.json#/definitions/IpsecIntegrity` |
| `definitions.VpnClientIPsecParameters.properties.pfsGroup.$ref__added` | added | `./common.json#/definitions/PfsGroup` |
| `definitions.VpnClientParameters.properties.processorArchitecture.$ref__added` | added | `./common.json#/definitions/ProcessorArchitecture` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/getikesas'].post.responses.200.schema.$ref__added` | added | `./common.json#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/startPacketCapture'].post.responses.200.schema.$ref__added` | added | `./common.json#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/stopPacketCapture'].post.responses.200.schema.$ref__added` | added | `./common.json#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/vpndeviceconfigurationscript'].post.responses.200.schema.$ref__added` | added | `./common.json#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnclientpackage'].post.responses.200.schema.$ref__added` | added | `./common.json#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnprofile'].post.responses.200.schema.$ref__added` | added | `./common.json#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverAllTestsDetails'].post.responses.200.schema.$ref__deleted` | deleted | `#/definitions/ExpressRouteFailoverAllTestDetails` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverSingleTestDetails'].post.responses.200.schema.$ref__deleted` | deleted | `#/definitions/ExpressRouteFailoverSingleTestDetailsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getvpnprofilepackageurl'].post.responses.200.schema.$ref__added` | added | `./common.json#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startPacketCapture'].post.responses.200.schema.$ref__added` | added | `./common.json#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startSiteFailoverTest'].post.responses.200.schema.$ref__added` | added | `./common.json#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopPacketCapture'].post.responses.200.schema.$ref__added` | added | `./common.json#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopSiteFailoverTest'].post.responses.200.schema.$ref__added` | added | `./common.json#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/supportedvpndevices'].post.responses.200.schema.$ref__added` | added | `./common.json#/definitions/stringApplicationJson` |

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

### Changes for `items`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverAllTestsDetails'].post.responses.200.schema.items__added` | added | `{"$ref":"#/definitions/ExpressRouteFailoverTestDetails"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverSingleTestDetails'].post.responses.200.schema.items__added` | added | `{"$ref":"#/definitions/ExpressRouteFailoverSingleTestDetails"}` |

### Changes for `ExpressRouteFailoverAllTestDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteFailoverAllTestDetails__deleted` | deleted | `{"type":"array","items":{"$ref":"#/definitions/ExpressRouteFailoverTestDetails"}}` |

### Changes for `ExpressRouteFailoverSingleTestDetailsObject`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteFailoverSingleTestDetailsObject__deleted` | deleted | `{"type":"array","items":{"$ref":"#/definitions/ExpressRouteFailoverSingleTestDetails"}}` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BgpPeerStatus.properties.state.enum__deleted` | deleted | `["Unknown","Stopped","Idle","Connecting","Connected"]` |
| `definitions.ExpressRouteFailoverConnectionResourceDetails.properties.status.enum__deleted` | deleted | `["Connected","Disconnected"]` |
| `definitions.ExpressRouteFailoverSingleTestDetails.properties.status.enum__deleted` | deleted | `["NotStarted","Starting","Running","StartFailed","Stopping","Completed","StopFailed","Invalid","Expi...` |
| `definitions.ExpressRouteFailoverTestDetails.properties.status.enum__deleted` | deleted | `["NotStarted","Starting","Running","StartFailed","Stopping","Completed","StopFailed","Invalid","Expi...` |
| `definitions.ExpressRouteFailoverTestDetails.properties.testType.enum__deleted` | deleted | `["SingleSiteFailover","MultiSiteFailover","All"]` |
| `definitions.IpsecPolicy.properties.dhGroup.enum__deleted` | deleted | `["None","DHGroup1","DHGroup2","DHGroup14","DHGroup2048","ECP256","ECP384","DHGroup24"]` |
| `definitions.IpsecPolicy.properties.ikeEncryption.enum__deleted` | deleted | `["DES","DES3","AES128","AES192","AES256","GCMAES256","GCMAES128"]` |
| `definitions.IpsecPolicy.properties.ikeIntegrity.enum__deleted` | deleted | `["MD5","SHA1","SHA256","SHA384","GCMAES256","GCMAES128"]` |
| `definitions.IpsecPolicy.properties.ipsecEncryption.enum__deleted` | deleted | `["None","DES","DES3","AES128","AES192","AES256","GCMAES128","GCMAES192","GCMAES256"]` |
| `definitions.IpsecPolicy.properties.ipsecIntegrity.enum__deleted` | deleted | `["MD5","SHA1","SHA256","GCMAES128","GCMAES192","GCMAES256"]` |
| `definitions.IpsecPolicy.properties.pfsGroup.enum__deleted` | deleted | `["None","PFS1","PFS2","PFS2048","ECP256","ECP384","PFS24","PFS14","PFSMM"]` |
| `definitions.TunnelConnectionHealth.properties.connectionStatus.enum__deleted` | deleted | `["Unknown","Connecting","Connected","NotConnected"]` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.connectionMode.enum__deleted` | deleted | `["Default","ResponderOnly","InitiatorOnly"]` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.connectionProtocol.enum__deleted` | deleted | `["IKEv2","IKEv1"]` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.connectionStatus.enum__deleted` | deleted | `["Unknown","Connecting","Connected","NotConnected"]` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.connectionType.enum__deleted` | deleted | `["IPsec","Vnet2Vnet","ExpressRoute","VPNClient"]` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.authenticationType.enum__deleted` | deleted | `["PSK","Certificate"]` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionMode.enum__deleted` | deleted | `["Default","ResponderOnly","InitiatorOnly"]` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionProtocol.enum__deleted` | deleted | `["IKEv2","IKEv1"]` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionStatus.enum__deleted` | deleted | `["Unknown","Connecting","Connected","NotConnected"]` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionType.enum__deleted` | deleted | `["IPsec","Vnet2Vnet","ExpressRoute","VPNClient"]` |
| `definitions.VirtualNetworkGatewayMigrationParameters.properties.migrationType.enum__deleted` | deleted | `["UpgradeDeploymentToStandardIP"]` |
| `definitions.VirtualNetworkGatewayMigrationStatus.properties.phase.enum__deleted` | deleted | `["None","Prepare","PrepareSucceeded","Execute","ExecuteSucceeded","Commit","CommitSucceeded","AbortS...` |
| `definitions.VirtualNetworkGatewayMigrationStatus.properties.state.enum__deleted` | deleted | `["None","InProgress","Succeeded","Failed"]` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.mode.enum__deleted` | deleted | `["EgressSnat","IngressSnat"]` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.type.enum__deleted` | deleted | `["Static","Dynamic"]` |
| `definitions.VirtualNetworkGatewayPolicyGroupMember.properties.attributeType.enum__deleted` | deleted | `["CertificateGroupId","AADGroupId","RadiusAzureGroupId"]` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.adminState.enum__deleted` | deleted | `["Enabled","Disabled"]` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.gatewayType.enum__deleted` | deleted | `["Vpn","ExpressRoute","LocalGateway"]` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.resiliencyModel.enum__deleted` | deleted | `["SingleHomed","MultiHomed"]` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.vpnGatewayGeneration.enum__deleted` | deleted | `["None","Generation1","Generation2"]` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.vpnType.enum__deleted` | deleted | `["PolicyBased","RouteBased"]` |
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
| `definitions.ExpressRouteFailoverConnectionResourceDetails.properties.status['x-ms-enum__deleted']` | deleted | `{"name":"FailoverConnectionStatus","modelAsString":true}` |
| `definitions.ExpressRouteFailoverSingleTestDetails.properties.status['x-ms-enum__deleted']` | deleted | `{"name":"FailoverTestStatusForSingleTest","modelAsString":true}` |
| `definitions.ExpressRouteFailoverTestDetails.properties.status['x-ms-enum__deleted']` | deleted | `{"name":"FailoverTestStatus","modelAsString":true}` |
| `definitions.ExpressRouteFailoverTestDetails.properties.testType['x-ms-enum__deleted']` | deleted | `{"name":"FailoverTestType","modelAsString":true}` |
| `definitions.IpsecPolicy.properties.dhGroup['x-ms-enum__deleted']` | deleted | `{"name":"DhGroup","modelAsString":true}` |
| `definitions.IpsecPolicy.properties.ikeEncryption['x-ms-enum__deleted']` | deleted | `{"name":"IkeEncryption","modelAsString":true}` |
| `definitions.IpsecPolicy.properties.ikeIntegrity['x-ms-enum__deleted']` | deleted | `{"name":"IkeIntegrity","modelAsString":true}` |
| `definitions.IpsecPolicy.properties.ipsecEncryption['x-ms-enum__deleted']` | deleted | `{"name":"IpsecEncryption","modelAsString":true}` |
| `definitions.IpsecPolicy.properties.ipsecIntegrity['x-ms-enum__deleted']` | deleted | `{"name":"IpsecIntegrity","modelAsString":true}` |
| `definitions.IpsecPolicy.properties.pfsGroup['x-ms-enum__deleted']` | deleted | `{"name":"PfsGroup","modelAsString":true}` |
| `definitions.TunnelConnectionHealth.properties.connectionStatus['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewayConnectionStatus","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.connectionMode['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewayConnectionMode","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.connectionProtocol['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewayConnectionProtocol","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.connectionStatus['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewayConnectionStatus","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.connectionType['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewayConnectionType","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.authenticationType['x-ms-enum__deleted']` | deleted | `{"name":"ConnectionAuthenticationType","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionMode['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewayConnectionMode","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionProtocol['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewayConnectionProtocol","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionStatus['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewayConnectionStatus","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.connectionType['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewayConnectionType","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayMigrationParameters.properties.migrationType['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewayMigrationType","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayMigrationStatus.properties.phase['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewayMigrationPhase","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayMigrationStatus.properties.state['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewayMigrationState","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.mode['x-ms-enum__deleted']` | deleted | `{"name":"VpnNatRuleMode","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"VpnNatRuleType","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayPolicyGroupMember.properties.attributeType['x-ms-enum__deleted']` | deleted | `{"name":"VpnPolicyMemberAttributeType","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.adminState['x-ms-enum__deleted']` | deleted | `{"name":"AdminState","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.gatewayType['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkGatewayType","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.resiliencyModel['x-ms-enum__deleted']` | deleted | `{"name":"ResiliencyModel","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.vpnGatewayGeneration['x-ms-enum__deleted']` | deleted | `{"name":"VpnGatewayGeneration","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.vpnType['x-ms-enum__deleted']` | deleted | `{"name":"VpnType","modelAsString":true}` |
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

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ListVirtualNetworkGatewayNatRulesResult.required__added` | added | `["value"]` |
| `definitions.LocalNetworkGatewayListResult.required__added` | added | `["value"]` |
| `definitions.RadiusAuthServerListResult.required__added` | added | `["value"]` |
| `definitions.VirtualNetworkGatewayConnectionListResult.required__added` | added | `["value"]` |
| `definitions.VirtualNetworkGatewayListConnectionsResult.required__added` | added | `["value"]` |
| `definitions.VirtualNetworkGatewayListResult.required__added` | added | `["value"]` |
| `definitions.VirtualNetworkTapListResult.required__added` | added | `["value"]` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RadiusAuthServer.properties.radiusServerSecret.format__added` | added | `password` |
| `definitions.RadiusServer.properties.radiusServerSecret.format__added` | added | `password` |
| `definitions.VirtualNetworkGatewayAutoScaleBounds.properties.max.format__added` | added | `int32` |
| `definitions.VirtualNetworkGatewayAutoScaleBounds.properties.min.format__added` | added | `int32` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.sharedKey.format__added` | added | `password` |
| `definitions.VirtualNetworkTapPropertiesFormat.properties.destinationPort.format__added` | added | `int32` |
| `definitions.VpnClientConfiguration.properties.radiusServerSecret.format__added` | added | `password` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkGatewayNatRule.properties.name__deleted` | deleted | `{"type":"string"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ConnectionSharedKey.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.LocalNetworkGateway.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.LocalNetworkGatewayPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VirtualNetworkGateway.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.VirtualNetworkGateway.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `./common.json#/definitions/ExtendedLocation` |
| `definitions.VirtualNetworkGateway.properties.identity.$ref` | `./network.json#/definitions/ManagedServiceIdentity` | `./common.json#/definitions/ManagedServiceIdentity` |
| `definitions.VirtualNetworkGatewayConnection.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.VirtualNetworkGatewayConnectionListEntity.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.peer.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.egressNatRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.ingressNatRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.peer.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VirtualNetworkGatewayIPConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.$ref` | `./network.json#/definitions/IPAllocationMethod` | `./common.json#/definitions/IPAllocationMethod` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayNatRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VirtualNetworkGatewayPolicyGroup.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayPolicyGroupProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VirtualNetworkGatewayPolicyGroupProperties.properties.vngClientConnectionConfigurations.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.gatewayDefaultSite.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VirtualNetworkTap.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.VirtualNetworkTapPropertiesFormat.properties.destinationNetworkInterfaceIPConfiguration.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceIPConfiguration` | `./virtualNetwork.json#/definitions/NetworkInterfaceIPConfiguration` |
| `definitions.VirtualNetworkTapPropertiesFormat.properties.networkInterfaceTapConfigurations.items.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceTapConfiguration` | `./virtualNetwork.json#/definitions/NetworkInterfaceTapConfiguration` |
| `definitions.VirtualNetworkTapPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VngClientConnectionConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VngClientConnectionConfigurationProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VngClientConnectionConfigurationProperties.properties.virtualNetworkGatewayPolicyGroups.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VpnClientParameters.properties.authenticationMethod.$ref` | `./network.json#/definitions/AuthenticationMethod` | `./common.json#/definitions/AuthenticationMethod` |
| `definitions.VpnClientRevokedCertificate.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VpnClientRevokedCertificatePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VpnClientRootCertificate.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VpnClientRootCertificatePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `info.description` | `The Microsoft Azure Network management API provides a RESTful set of web services that interact with Microsoft Azure Networks service to manage your network resources. The API has entities that capture the relationship between an end user and the Microsoft Azure Networks service.` | `APIs to manage web application firewall rules.` |
| `info.title` | `NetworkManagementClient` | `WebApplicationFirewallManagement` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/virtualNetworkTaps'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey/reset'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/startPacketCapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/stopPacketCapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/vpndeviceconfigurationscript'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/abortMigration'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/commitMigration'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/connections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/disconnectVirtualNetworkGatewayVpnConnections'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/executeMigration'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnclientpackage'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnprofile'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getAdvertisedRoutes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getBgpPeerStatus'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverAllTestsDetails'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverSingleTestDetails'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getLearnedRoutes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getResiliencyInformation'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getRoutesInformation'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getVpnClientConnectionHealth'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getvpnclientipsecparameters'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getvpnprofilepackageurl'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/listRadiusSecrets'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/prepareMigration'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/reset'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/resetvpnclientsharedkey'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/setvpnclientipsecparameters'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startPacketCapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startSiteFailoverTest'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopPacketCapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopSiteFailoverTest'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/supportedvpndevices'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |

