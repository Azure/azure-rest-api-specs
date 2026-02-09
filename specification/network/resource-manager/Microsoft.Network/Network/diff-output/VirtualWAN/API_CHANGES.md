## Changed Paths

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/virtualRouters
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings/{peeringName}
Change Type: deleted

## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `tags__added` | added | `[{"name":"VirtualWANs"},{"name":"VpnSites"},{"name":"VpnServerConfigurations"},{"name":"VpnGateways"...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/virtualRouters`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/virtualRouters__deleted']` | deleted | `{"get":{"operationId":"VirtualRouters_List","tags":["VirtualRouters"],"parameters":[],"responses":{"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters__deleted']` | deleted | `{"get":{"operationId":"VirtualRouters_ListByResourceGroup","tags":["VirtualRouters"],"parameters":[]...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}__deleted']` | deleted | `{"get":{"operationId":"VirtualRouters_Get","tags":["VirtualRouters"],"parameters":[{"name":"virtualR...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings__deleted']` | deleted | `{"get":{"operationId":"VirtualRouterPeerings_List","tags":["VirtualRouterPeerings"],"parameters":[{"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings/{peeringName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings/{peeringName}__deleted']` | deleted | `{"get":{"operationId":"VirtualRouterPeerings_Get","tags":["VirtualRouterPeerings"],"parameters":[{"n...` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections/{connectionName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}/generatevpnprofile'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}/getP2sVpnConnectionHealth'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}/getP2sVpnConnectionHealthDetailed'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}/reset'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{p2sVpnGatewayName}/disconnectP2sVpnConnections'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/advertisedRoutes'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/learnedRoutes'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/bgpConnections/{connectionName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/bgpConnections/{connectionName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/effectiveRoutes'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubRouteTables/{routeTableName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubRouteTables/{routeTableName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/inboundRoutes'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/ipConfigurations/{ipConfigName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/ipConfigurations/{ipConfigName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/outboundRoutes'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeMaps/{routeMapName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeMaps/{routeMapName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routingIntent/{routingIntentName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routingIntent/{routingIntentName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{VirtualWANName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{VirtualWANName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{virtualWANName}/generateVpnProfile'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{virtualWANName}/vpnConfiguration'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{virtualWANName}/vpnServerConfigurations'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/natRules/{natRuleName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/natRules/{natRuleName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/reset'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/startpacketcapture'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/stoppacketcapture'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/getikesas'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/resetconnection'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/sharedKeys/default'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{vpnConnectionName}/startpacketcapture'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{vpnConnectionName}/stoppacketcapture'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups/{configurationPolicyGroupName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups/{configurationPolicyGroupName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ExpressRouteGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ExpressRouteGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ExpressRouteConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections/{connectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/NetworkVirtualApplianceConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/P2SVpnGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/P2SVpnGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualHub` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/bgpConnections/{connectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/BgpConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubRouteTables/{routeTableName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/HubRouteTable` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/HubVirtualNetworkConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/ipConfigurations/{ipConfigName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/HubIpConfiguration` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeMaps/{routeMapName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/RouteMap` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualHubRouteTableV2` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routingIntent/{routingIntentName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/RoutingIntent` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{VirtualWANName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualWAN` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VpnGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VpnGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/natRules/{natRuleName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VpnGatewayNatRule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VpnConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/sharedKeys/default'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ConnectionSharedKeyResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VpnServerConfiguration` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups/{configurationPolicyGroupName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VpnServerConfigurationPolicyGroup` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VpnSite` |

### Changes for `pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections'].get.parameters[0].pattern__deleted` | deleted | `^[A-Za-z0-9_]+` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections/{connectionName}'].put.parameters[0].pattern__deleted` | deleted | `^[A-Za-z0-9_]+` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections/{connectionName}'].put.parameters[1].pattern__deleted` | deleted | `^[A-Za-z0-9_]+` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/listRadiusSecrets'].post.parameters[0].pattern__deleted` | deleted | `^[A-Za-z0-9_]+` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections/{connectionName}'].delete.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"The URL of the resource used to check the status of the asynchronous...` |

### Changes for `Location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections/{connectionName}'].delete.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Action.properties.type.$ref__added` | added | `./common.json#/definitions/RouteMapActionType` |
| `definitions.BgpConnectionProperties.properties.connectionState.$ref__added` | added | `./common.json#/definitions/HubBgpConnectionStatus` |
| `definitions.Criterion.properties.matchCondition.$ref__added` | added | `./common.json#/definitions/RouteMapMatchCondition` |
| `definitions.ExpressRouteGatewayProperties.properties.autoScaleConfiguration.$ref__added` | added | `#/definitions/ExpressRouteGatewayPropertiesAutoScaleConfiguration` |
| `definitions.RouteMapRule.properties.nextStepIfMatched.$ref__added` | added | `./common.json#/definitions/NextStep` |
| `definitions.StaticRoutesConfig.properties.vnetLocalRouteOverrideCriteria.$ref__added` | added | `./common.json#/definitions/VnetLocalRouteOverrideCriteria` |
| `definitions.VirtualHubProperties.properties.hubRoutingPreference.$ref__added` | added | `./common.json#/definitions/HubRoutingPreference` |
| `definitions.VirtualHubProperties.properties.preferredRoutingGateway.$ref__added` | added | `./common.json#/definitions/PreferredRoutingGateway` |
| `definitions.VirtualHubProperties.properties.routingState.$ref__added` | added | `./common.json#/definitions/RoutingState` |
| `definitions.VirtualWanProperties.properties.office365LocalBreakoutCategory.$ref__added` | added | `./common.json#/definitions/OfficeTrafficCategory` |
| `definitions.VirtualWanSecurityProvider.properties.type.$ref__added` | added | `./common.json#/definitions/VirtualWanSecurityProviderType` |
| `definitions.VpnConnectionProperties.properties.connectionStatus.$ref__added` | added | `./common.json#/definitions/VpnConnectionStatus` |
| `definitions.VpnGatewayNatRuleProperties.properties.mode.$ref__added` | added | `./common.json#/definitions/VpnNatRuleMode` |
| `definitions.VpnGatewayNatRuleProperties.properties.type.$ref__added` | added | `./common.json#/definitions/VpnNatRuleType` |
| `definitions.VpnServerConfigurationPolicyGroupMember.properties.attributeType.$ref__added` | added | `./common.json#/definitions/VpnPolicyMemberAttributeType` |
| `definitions.VpnServerConfigurationProperties.properties.vpnAuthenticationTypes.items.$ref__added` | added | `./common.json#/definitions/VpnAuthenticationType` |
| `definitions.VpnServerConfigurationProperties.properties.vpnProtocols.items.$ref__added` | added | `./common.json#/definitions/VpnGatewayTunnelingProtocol` |
| `definitions.VpnSiteLinkConnectionProperties.properties.connectionStatus.$ref__added` | added | `./common.json#/definitions/VpnConnectionStatus` |
| `definitions.VpnSiteLinkConnectionProperties.properties.vpnLinkConnectionMode.$ref__added` | added | `./common.json#/definitions/VpnLinkConnectionMode` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/advertisedRoutes'].post.responses.200.schema.$ref__deleted` | deleted | `#/definitions/PeerRouteList` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/learnedRoutes'].post.responses.200.schema.$ref__deleted` | deleted | `#/definitions/PeerRouteList` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/startpacketcapture'].post.responses.200.schema.$ref__added` | added | `./common.json#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/stoppacketcapture'].post.responses.200.schema.$ref__added` | added | `./common.json#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/getikesas'].post.responses.200.schema.$ref__added` | added | `./common.json#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{vpnConnectionName}/startpacketcapture'].post.responses.200.schema.$ref__added` | added | `./common.json#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{vpnConnectionName}/stoppacketcapture'].post.responses.200.schema.$ref__added` | added | `./common.json#/definitions/stringApplicationJson` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Action.properties.type.type__deleted` | deleted | `string` |
| `definitions.BgpConnection.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.BgpConnectionProperties.properties.connectionState.type__deleted` | deleted | `string` |
| `definitions.ConnectionSharedKeyResult.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.Criterion.properties.matchCondition.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteGatewayProperties.properties.autoScaleConfiguration.type__deleted` | deleted | `object` |
| `definitions.HubIpConfiguration.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.HubRouteTable.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.RouteMap.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.RouteMapRule.properties.nextStepIfMatched.type__deleted` | deleted | `string` |
| `definitions.RoutingIntent.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.StaticRoutesConfig.properties.vnetLocalRouteOverrideCriteria.type__deleted` | deleted | `string` |
| `definitions.VirtualHubProperties.properties.hubRoutingPreference.type__deleted` | deleted | `string` |
| `definitions.VirtualHubProperties.properties.preferredRoutingGateway.type__deleted` | deleted | `string` |
| `definitions.VirtualHubProperties.properties.routingState.type__deleted` | deleted | `string` |
| `definitions.VirtualWanProperties.properties.office365LocalBreakoutCategory.type__deleted` | deleted | `string` |
| `definitions.VirtualWanSecurityProvider.properties.type.type__deleted` | deleted | `string` |
| `definitions.VpnConnectionProperties.properties.connectionStatus.type__deleted` | deleted | `string` |
| `definitions.VpnGatewayNatRule.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.VpnGatewayNatRuleProperties.properties.mode.type__deleted` | deleted | `string` |
| `definitions.VpnGatewayNatRuleProperties.properties.type.type__deleted` | deleted | `string` |
| `definitions.VpnServerConfigurationPolicyGroup.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.VpnServerConfigurationPolicyGroupMember.properties.attributeType.type__deleted` | deleted | `string` |
| `definitions.VpnServerConfigurationProperties.properties.vpnAuthenticationTypes.items.type__deleted` | deleted | `string` |
| `definitions.VpnServerConfigurationProperties.properties.vpnProtocols.items.type__deleted` | deleted | `string` |
| `definitions.VpnSiteLink.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.VpnSiteLinkConnection.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.VpnSiteLinkConnectionProperties.properties.connectionStatus.type__deleted` | deleted | `string` |
| `definitions.VpnSiteLinkConnectionProperties.properties.vpnLinkConnectionMode.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/advertisedRoutes'].post.responses.200.schema.type__added` | added | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/learnedRoutes'].post.responses.200.schema.type__added` | added | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/startpacketcapture'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/stoppacketcapture'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/getikesas'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{vpnConnectionName}/startpacketcapture'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{vpnConnectionName}/stoppacketcapture'].post.responses.200.schema.type__deleted` | deleted | `string` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/advertisedRoutes'].post.responses.200.schema.additionalProperties__added` | added | `{"items":{"$ref":"#/definitions/PeerRoute"},"type":"array"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/learnedRoutes'].post.responses.200.schema.additionalProperties__added` | added | `{"items":{"$ref":"#/definitions/PeerRoute"},"type":"array"}` |

### Changes for `PeerRouteList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PeerRouteList__deleted` | deleted | `{"type":"object","additionalProperties":{"description":"List of peer routes.","items":{"$ref":"#/def...` |

### Changes for `VirtualRouter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualRouter__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/VirtualRouterPropertiesFormat","x...` |

### Changes for `VirtualRouterListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualRouterListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `VirtualRouterPeering`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualRouterPeering__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/VirtualRouterPeeringProperties","...` |

### Changes for `VirtualRouterPeeringListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualRouterPeeringListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `VirtualRouterPeeringProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualRouterPeeringProperties__deleted` | deleted | `{"type":"object","properties":{"peerAsn":{"type":"integer","format":"int64","minimum":0,"maximum":42...` |

### Changes for `VirtualRouterPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualRouterPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"virtualRouterAsn":{"type":"integer","format":"int64","minimum":0,"ma...` |

### Changes for `VpnSiteId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VpnSiteId__deleted` | deleted | `{"type":"object","properties":{"vpnSite":{"type":"string","readOnly":true}}}` |

### Changes for `ExpressRouteGatewayPropertiesAutoScaleConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteGatewayPropertiesAutoScaleConfiguration__added` | added | `{"type":"object","properties":{"bounds":{"$ref":"#/definitions/ExpressRouteGatewayPropertiesAutoScal...` |

### Changes for `ExpressRouteGatewayPropertiesAutoScaleConfigurationBounds`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteGatewayPropertiesAutoScaleConfigurationBounds__added` | added | `{"type":"object","properties":{"min":{"type":"integer","format":"int32"},"max":{"type":"integer","fo...` |

### Changes for `Record<PeerRoute[]>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Record<PeerRoute[]>__added` | added | `{"type":"object","additionalProperties":{"items":{"$ref":"#/definitions/PeerRoute"},"type":"array"}}` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Action.properties.type.enum__deleted` | deleted | `["Unknown","Remove","Add","Replace","Drop"]` |
| `definitions.BgpConnectionProperties.properties.connectionState.enum__deleted` | deleted | `["Unknown","Connecting","Connected","NotConnected"]` |
| `definitions.Criterion.properties.matchCondition.enum__deleted` | deleted | `["Unknown","Contains","Equals","NotContains","NotEquals"]` |
| `definitions.RouteMapRule.properties.nextStepIfMatched.enum__deleted` | deleted | `["Unknown","Continue","Terminate"]` |
| `definitions.StaticRoutesConfig.properties.vnetLocalRouteOverrideCriteria.enum__deleted` | deleted | `["Contains","Equal"]` |
| `definitions.VirtualHubProperties.properties.hubRoutingPreference.enum__deleted` | deleted | `["ExpressRoute","VpnGateway","ASPath"]` |
| `definitions.VirtualHubProperties.properties.preferredRoutingGateway.enum__deleted` | deleted | `["ExpressRoute","VpnGateway","None"]` |
| `definitions.VirtualHubProperties.properties.routingState.enum__deleted` | deleted | `["None","Provisioned","Provisioning","Failed"]` |
| `definitions.VirtualWanProperties.properties.office365LocalBreakoutCategory.enum__deleted` | deleted | `["Optimize","OptimizeAndAllow","All","None"]` |
| `definitions.VirtualWanSecurityProvider.properties.type.enum__deleted` | deleted | `["External","Native"]` |
| `definitions.VpnConnectionProperties.properties.connectionStatus.enum__deleted` | deleted | `["Unknown","Connecting","Connected","NotConnected"]` |
| `definitions.VpnGatewayNatRuleProperties.properties.mode.enum__deleted` | deleted | `["EgressSnat","IngressSnat"]` |
| `definitions.VpnGatewayNatRuleProperties.properties.type.enum__deleted` | deleted | `["Static","Dynamic"]` |
| `definitions.VpnServerConfigurationPolicyGroupMember.properties.attributeType.enum__deleted` | deleted | `["CertificateGroupId","AADGroupId","RadiusAzureGroupId"]` |
| `definitions.VpnServerConfigurationProperties.properties.vpnAuthenticationTypes.items.enum__deleted` | deleted | `["Certificate","Radius","AAD"]` |
| `definitions.VpnServerConfigurationProperties.properties.vpnProtocols.items.enum__deleted` | deleted | `["IkeV2","OpenVPN"]` |
| `definitions.VpnSiteLinkConnectionProperties.properties.connectionStatus.enum__deleted` | deleted | `["Unknown","Connecting","Connected","NotConnected"]` |
| `definitions.VpnSiteLinkConnectionProperties.properties.vpnLinkConnectionMode.enum__deleted` | deleted | `["Default","ResponderOnly","InitiatorOnly"]` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Action.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"RouteMapActionType","modelAsString":true}` |
| `definitions.BgpConnectionProperties.properties.connectionState['x-ms-enum__deleted']` | deleted | `{"name":"HubBgpConnectionStatus","modelAsString":true}` |
| `definitions.Criterion.properties.matchCondition['x-ms-enum__deleted']` | deleted | `{"name":"RouteMapMatchCondition","modelAsString":true}` |
| `definitions.RouteMapRule.properties.nextStepIfMatched['x-ms-enum__deleted']` | deleted | `{"name":"NextStep","modelAsString":true}` |
| `definitions.StaticRoutesConfig.properties.vnetLocalRouteOverrideCriteria['x-ms-enum__deleted']` | deleted | `{"name":"VnetLocalRouteOverrideCriteria","modelAsString":true}` |
| `definitions.VirtualHubProperties.properties.hubRoutingPreference['x-ms-enum__deleted']` | deleted | `{"name":"HubRoutingPreference","modelAsString":true}` |
| `definitions.VirtualHubProperties.properties.preferredRoutingGateway['x-ms-enum__deleted']` | deleted | `{"name":"PreferredRoutingGateway","modelAsString":true}` |
| `definitions.VirtualHubProperties.properties.routingState['x-ms-enum__deleted']` | deleted | `{"name":"RoutingState","modelAsString":true}` |
| `definitions.VirtualWanProperties.properties.office365LocalBreakoutCategory['x-ms-enum__deleted']` | deleted | `{"name":"OfficeTrafficCategory","modelAsString":true}` |
| `definitions.VirtualWanSecurityProvider.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"VirtualWanSecurityProviderType","modelAsString":true}` |
| `definitions.VpnConnectionProperties.properties.connectionStatus['x-ms-enum__deleted']` | deleted | `{"name":"VpnConnectionStatus","modelAsString":true}` |
| `definitions.VpnGatewayNatRuleProperties.properties.mode['x-ms-enum__deleted']` | deleted | `{"name":"VpnNatRuleMode","modelAsString":true}` |
| `definitions.VpnGatewayNatRuleProperties.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"VpnNatRuleType","modelAsString":true}` |
| `definitions.VpnServerConfigurationPolicyGroupMember.properties.attributeType['x-ms-enum__deleted']` | deleted | `{"name":"VpnPolicyMemberAttributeType","modelAsString":true}` |
| `definitions.VpnServerConfigurationProperties.properties.vpnAuthenticationTypes.items['x-ms-enum__deleted']` | deleted | `{"name":"VpnAuthenticationType","modelAsString":true}` |
| `definitions.VpnServerConfigurationProperties.properties.vpnProtocols.items['x-ms-enum__deleted']` | deleted | `{"name":"VpnGatewayTunnelingProtocol","modelAsString":true}` |
| `definitions.VpnSiteLinkConnectionProperties.properties.connectionStatus['x-ms-enum__deleted']` | deleted | `{"name":"VpnConnectionStatus","modelAsString":true}` |
| `definitions.VpnSiteLinkConnectionProperties.properties.vpnLinkConnectionMode['x-ms-enum__deleted']` | deleted | `{"name":"VpnLinkConnectionMode","modelAsString":true}` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BgpConnection.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.ConnectionSharedKeyResult.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.HubIpConfiguration.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.HubRouteTable.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.RouteMap.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.RoutingIntent.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.VpnGatewayNatRule.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.VpnServerConfiguration.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.VpnServerConfigurationPolicyGroup.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.VpnSiteLink.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.VpnSiteLinkConnection.properties.name__deleted` | deleted | `{"type":"string"}` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BgpConnectionProperties.properties.hubVirtualNetworkConnection.readOnly__deleted` | deleted | `false` |
| `definitions.BgpConnectionProperties.properties.peerAsn.readOnly__deleted` | deleted | `false` |
| `definitions.BgpConnectionProperties.properties.peerIp.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualApplianceConnectionProperties.properties.asn.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualApplianceConnectionProperties.properties.tunnelIdentifier.readOnly__deleted` | deleted | `false` |
| `definitions.O365BreakOutCategoryPolicies.properties.allow.readOnly__deleted` | deleted | `false` |
| `definitions.O365BreakOutCategoryPolicies.properties.default.readOnly__deleted` | deleted | `false` |
| `definitions.O365BreakOutCategoryPolicies.properties.optimize.readOnly__deleted` | deleted | `false` |
| `definitions.O365PolicyProperties.properties.breakOutCategories.readOnly__deleted` | deleted | `false` |
| `definitions.P2SConnectionConfigurationProperties.properties.configurationPolicyGroupAssociations.readOnly__deleted` | deleted | `false` |
| `definitions.RoutingIntentProperties.properties.routingPolicies.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualHubProperties.properties.allowBranchToBranchTraffic.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualHubProperties.properties.virtualRouterAsn.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualHubProperties.properties.virtualRouterIps.readOnly__deleted` | deleted | `false` |
| `definitions.VpnSiteProperties.properties.o365Policy.readOnly__deleted` | deleted | `false` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionSharedKeyResult.properties.id__deleted` | deleted | `{"type":"string"}` |
| `definitions.RouteMap.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionSharedKeyResultList.required__added` | added | `["value"]` |
| `definitions.ListHubRouteTablesResult.required__added` | added | `["value"]` |
| `definitions.ListHubVirtualNetworkConnectionsResult.required__added` | added | `["value"]` |
| `definitions.ListP2SVpnGatewaysResult.required__added` | added | `["value"]` |
| `definitions.ListRouteMapsResult.required__added` | added | `["value"]` |
| `definitions.ListRoutingIntentResult.required__added` | added | `["value"]` |
| `definitions.ListVirtualHubBgpConnectionResults.required__added` | added | `["value"]` |
| `definitions.ListVirtualHubIpConfigurationResults.required__added` | added | `["value"]` |
| `definitions.ListVirtualHubRouteTableV2sResult.required__added` | added | `["value"]` |
| `definitions.ListVirtualHubsResult.required__added` | added | `["value"]` |
| `definitions.ListVirtualWANsResult.required__added` | added | `["value"]` |
| `definitions.ListVpnConnectionsResult.required__added` | added | `["value"]` |
| `definitions.ListVpnGatewayNatRulesResult.required__added` | added | `["value"]` |
| `definitions.ListVpnGatewaysResult.required__added` | added | `["value"]` |
| `definitions.ListVpnServerConfigurationPolicyGroupsResult.required__added` | added | `["value"]` |
| `definitions.ListVpnServerConfigurationsResult.required__added` | added | `["value"]` |
| `definitions.ListVpnSiteLinkConnectionsResult.required__added` | added | `["value"]` |
| `definitions.ListVpnSiteLinksResult.required__added` | added | `["value"]` |
| `definitions.ListVpnSitesResult.required__added` | added | `["value"]` |
| `definitions.NetworkVirtualApplianceConnectionList.required__added` | added | `["value"]` |
| `definitions.P2SVpnGateway.required__deleted` | deleted | `["location"]` |
| `definitions.VirtualHub.required__deleted` | deleted | `["location"]` |
| `definitions.VirtualWAN.required__deleted` | deleted | `["location"]` |
| `definitions.VpnGateway.required__deleted` | deleted | `["location"]` |
| `definitions.VpnSite.required__deleted` | deleted | `["location"]` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteConnectionProperties.properties.routingWeight.format__added` | added | `int32` |
| `definitions.SharedKeyProperties.properties.sharedKey.format__added` | added | `password` |
| `definitions.VpnServerConfigurationProperties.properties.radiusServerSecret.format__added` | added | `password` |
| `definitions.VpnSiteLinkConnectionProperties.properties.sharedKey.format__added` | added | `password` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteGatewayProperties.properties.autoScaleConfiguration.properties__deleted` | deleted | `{"bounds":{"description":"Minimum and maximum number of scale units to deploy.","properties":{"min":...` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.BgpConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.BgpConnectionProperties.properties.hubVirtualNetworkConnection.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.BgpConnectionProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ConnectionSharedKeyResult.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.ExpressRouteConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ExpressRouteConnectionProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ExpressRouteGateway.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.ExpressRouteGatewayProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.HubIpConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.HubIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.$ref` | `./network.json#/definitions/IPAllocationMethod` | `./common.json#/definitions/IPAllocationMethod` |
| `definitions.HubIPConfigurationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.HubIPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./publicIpAddress.json#/definitions/PublicIPAddress` | `./virtualNetwork.json#/definitions/PublicIPAddress` |
| `definitions.HubRouteTable.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.HubRouteTableProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.HubVirtualNetworkConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.HubVirtualNetworkConnectionProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.HubVirtualNetworkConnectionProperties.properties.remoteVirtualNetwork.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.NetworkVirtualApplianceConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.NetworkVirtualApplianceConnectionProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.P2SConnectionConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.P2SConnectionConfigurationProperties.properties.configurationPolicyGroupAssociations.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.P2SConnectionConfigurationProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.P2SVpnGateway.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/ResourceWithRequiredLocation` |
| `definitions.P2SVpnGatewayProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.P2SVpnGatewayProperties.properties.virtualHub.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.P2SVpnGatewayProperties.properties.vpnServerConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.P2SVpnProfileParameters.properties.authenticationMethod.$ref` | `./network.json#/definitions/AuthenticationMethod` | `./common.json#/definitions/AuthenticationMethod` |
| `definitions.PropagatedRouteTable.properties.ids.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.RouteMap.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/ReadOnlySubResourceModel` |
| `definitions.RouteMapProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.RoutingConfiguration.properties.associatedRouteTable.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.RoutingConfiguration.properties.inboundRouteMap.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.RoutingConfiguration.properties.outboundRouteMap.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.RoutingIntent.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.RoutingIntentProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.SharedKeyProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VirtualHub.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/ResourceWithRequiredLocation` |
| `definitions.VirtualHubProperties.properties.azureFirewall.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualHubProperties.properties.bgpConnections.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualHubProperties.properties.expressRouteGateway.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualHubProperties.properties.ipConfigurations.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualHubProperties.properties.p2SVpnGateway.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualHubProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VirtualHubProperties.properties.routeMaps.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualHubProperties.properties.securityPartnerProvider.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualHubProperties.properties.virtualWan.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualHubProperties.properties.vpnGateway.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualHubRouteTableV2.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualHubRouteTableV2Properties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VirtualWAN.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/ResourceWithRequiredLocation` |
| `definitions.VirtualWanProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VirtualWanProperties.properties.virtualHubs.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualWanProperties.properties.vpnSites.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualWanVpnProfileParameters.properties.authenticationMethod.$ref` | `./network.json#/definitions/AuthenticationMethod` | `./common.json#/definitions/AuthenticationMethod` |
| `definitions.VnetRoute.properties.bgpConnections.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VpnConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VpnConnectionProperties.properties.ipsecPolicies.items.$ref` | `./virtualNetworkGateway.json#/definitions/IpsecPolicy` | `./networkGateway.json#/definitions/IpsecPolicy` |
| `definitions.VpnConnectionProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VpnConnectionProperties.properties.remoteVpnSite.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VpnConnectionProperties.properties.trafficSelectorPolicies.items.$ref` | `./virtualNetworkGateway.json#/definitions/TrafficSelectorPolicy` | `./networkGateway.json#/definitions/TrafficSelectorPolicy` |
| `definitions.VpnConnectionProperties.properties.vpnConnectionProtocolType.$ref` | `./virtualNetworkGateway.json#/definitions/ConnectionProtocol` | `./common.json#/definitions/VirtualNetworkGatewayConnectionProtocol` |
| `definitions.VpnGateway.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/ResourceWithRequiredLocation` |
| `definitions.VpnGatewayNatRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.VpnGatewayNatRuleProperties.properties.egressVpnSiteLinkConnections.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VpnGatewayNatRuleProperties.properties.ingressVpnSiteLinkConnections.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VpnGatewayNatRuleProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VpnGatewayProperties.properties.bgpSettings.$ref` | `./virtualNetworkGateway.json#/definitions/BgpSettings` | `./networkGateway.json#/definitions/BgpSettings` |
| `definitions.VpnGatewayProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VpnGatewayProperties.properties.virtualHub.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VpnServerConfiguration.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/ResourceWithWritableName` |
| `definitions.VpnServerConfigurationPolicyGroup.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.VpnServerConfigurationPolicyGroupProperties.properties.p2SConnectionConfigurations.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VpnServerConfigurationPolicyGroupProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VpnServerConfigurationProperties.properties.radiusServers.items.$ref` | `./virtualNetworkGateway.json#/definitions/RadiusServer` | `./networkGateway.json#/definitions/RadiusServer` |
| `definitions.VpnServerConfigurationProperties.properties.vpnClientIpsecPolicies.items.$ref` | `./virtualNetworkGateway.json#/definitions/IpsecPolicy` | `./networkGateway.json#/definitions/IpsecPolicy` |
| `definitions.VpnSite.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/ResourceWithRequiredLocation` |
| `definitions.VpnSiteLink.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.VpnSiteLinkConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.VpnSiteLinkConnectionProperties.properties.egressNatRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VpnSiteLinkConnectionProperties.properties.ingressNatRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VpnSiteLinkConnectionProperties.properties.ipsecPolicies.items.$ref` | `./virtualNetworkGateway.json#/definitions/IpsecPolicy` | `./networkGateway.json#/definitions/IpsecPolicy` |
| `definitions.VpnSiteLinkConnectionProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VpnSiteLinkConnectionProperties.properties.vpnConnectionProtocolType.$ref` | `./virtualNetworkGateway.json#/definitions/ConnectionProtocol` | `./common.json#/definitions/VirtualNetworkGatewayConnectionProtocol` |
| `definitions.VpnSiteLinkConnectionProperties.properties.vpnGatewayCustomBgpAddresses.items.$ref` | `./virtualNetworkGateway.json#/definitions/GatewayCustomBgpIpAddressIpConfiguration` | `./networkGateway.json#/definitions/GatewayCustomBgpIpAddressIpConfiguration` |
| `definitions.VpnSiteLinkConnectionProperties.properties.vpnSiteLink.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VpnSiteLinkProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VpnSiteProperties.properties.bgpProperties.$ref` | `./virtualNetworkGateway.json#/definitions/BgpSettings` | `./networkGateway.json#/definitions/BgpSettings` |
| `definitions.VpnSiteProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VpnSiteProperties.properties.virtualWan.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `info.description` | `REST API for Azure VirtualWAN As a Service.` | `APIs to manage web application firewall rules.` |
| `info.title` | `VirtualWANAsAServiceManagementClient` | `WebApplicationFirewallManagement` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/p2svpnGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/virtualHubs'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/virtualWans'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/vpnGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/vpnServerConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/vpnSites'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections/{connectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections/{connectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections/{connectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}/generatevpnprofile'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}/getP2sVpnConnectionHealth'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}/getP2sVpnConnectionHealthDetailed'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}/reset'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{p2sVpnGatewayName}/disconnectP2sVpnConnections'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/advertisedRoutes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/learnedRoutes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/bgpConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/bgpConnections/{connectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/bgpConnections/{connectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/bgpConnections/{connectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/effectiveRoutes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubRouteTables'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubRouteTables/{routeTableName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubRouteTables/{routeTableName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubRouteTables/{routeTableName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/inboundRoutes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/ipConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/ipConfigurations/{ipConfigName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/ipConfigurations/{ipConfigName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/ipConfigurations/{ipConfigName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/outboundRoutes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeMaps'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeMaps/{routeMapName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeMaps/{routeMapName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeMaps/{routeMapName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeTables'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routingIntent'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routingIntent/{routingIntentName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routingIntent/{routingIntentName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routingIntent/{routingIntentName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{VirtualWANName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{VirtualWANName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{VirtualWANName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{VirtualWANName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{VirtualWANName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{virtualWANName}/generateVpnProfile'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{virtualWANName}/supportedSecurityProviders'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{virtualWANName}/vpnConfiguration'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{virtualWANName}/vpnServerConfigurations'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/natRules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/natRules/{natRuleName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/natRules/{natRuleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/natRules/{natRuleName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/reset'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/startpacketcapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/stoppacketcapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/sharedKeys'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/sharedKeys/default'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/sharedKeys/default'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/sharedKeys/default/listSharedKey'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{vpnConnectionName}/startpacketcapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{vpnConnectionName}/stoppacketcapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups'].get.operationId` | `ConfigurationPolicyGroups_ListByVpnServerConfiguration` | `configurationPolicyGroups_ListByVpnServerConfiguration` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups/{configurationPolicyGroupName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups/{configurationPolicyGroupName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups/{configurationPolicyGroupName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/listRadiusSecrets'].post.responses.200.schema.$ref` | `./virtualNetworkGateway.json#/definitions/RadiusAuthServerListResult` | `./networkGateway.json#/definitions/RadiusAuthServerListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/listRadiusSecrets'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}/vpnSiteLinks'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}/vpnSiteLinks/{vpnSiteLinkName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |

