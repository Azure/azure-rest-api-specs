## Changed Paths

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteGateways
Change Type: added

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/expressRoutePortsLocations
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/expressRoutePortsLocations/{locationName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteServiceProviders
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/authorizations
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/authorizations/{authorizationName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/arpTables/{devicePath}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections/{connectionName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/peerConnections
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/peerConnections/{connectionName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTables/{devicePath}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTablesSummary/{devicePath}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/stats
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations/{authorizationName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions/{serviceEndpointPolicyDefinitionName}
Change Type: deleted

## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/bgpServiceCommunities'].get.tags__deleted` | deleted | `["BgpServiceCommunities"]` |
| `tags__added` | added | `[{"name":"ExpressRouteProviderPorts"},{"name":"ExpressRouteCircuits"},{"name":"ExpressRouteCrossConn...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRoutePortsLocations`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRoutePortsLocations__deleted']` | deleted | `{"get":{"operationId":"ExpressRoutePortsLocations_List","tags":["ExpressRoutePortsLocations"],"param...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRoutePortsLocations/{locationName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRoutePortsLocations/{locationName}__deleted']` | deleted | `{"get":{"operationId":"ExpressRoutePortsLocations_Get","tags":["ExpressRoutePortsLocations"],"parame...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteServiceProviders`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteServiceProviders__deleted']` | deleted | `{"get":{"operationId":"ExpressRouteServiceProviders_List","tags":["ExpressRouteServiceProviders"],"p...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/authorizations`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/authorizations__deleted']` | deleted | `{"get":{"operationId":"ExpressRouteCircuitAuthorizations_List","tags":["ExpressRouteCircuitAuthoriza...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/authorizations/{authorizationName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/authorizations/{authorizationName}__deleted']` | deleted | `{"get":{"operationId":"ExpressRouteCircuitAuthorizations_Get","tags":["ExpressRouteCircuitAuthorizat...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings__deleted']` | deleted | `{"get":{"operationId":"ExpressRouteCircuitPeerings_List","tags":["ExpressRouteCircuitPeerings"],"par...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}__deleted']` | deleted | `{"get":{"operationId":"ExpressRouteCircuitPeerings_Get","tags":["ExpressRouteCircuitPeerings"],"para...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/arpTables/{devicePath}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/arpTables/{devicePath}__deleted']` | deleted | `{"post":{"operationId":"ExpressRouteCircuits_ListArpTable","tags":["ExpressRouteCircuitArpTable"],"p...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections__deleted']` | deleted | `{"get":{"operationId":"ExpressRouteCircuitConnections_List","tags":["ExpressRouteCircuitConnections"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections/{connectionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections/{connectionName}__deleted']` | deleted | `{"get":{"operationId":"ExpressRouteCircuitConnections_Get","tags":["ExpressRouteCircuitConnections"]...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/peerConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/peerConnections__deleted']` | deleted | `{"get":{"operationId":"PeerExpressRouteCircuitConnections_List","tags":["PeerExpressRouteCircuitConn...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/peerConnections/{connectionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/peerConnections/{connectionName}__deleted']` | deleted | `{"get":{"operationId":"PeerExpressRouteCircuitConnections_Get","tags":["PeerExpressRouteCircuitConne...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTables/{devicePath}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTables/{devicePath}__deleted']` | deleted | `{"post":{"operationId":"ExpressRouteCircuits_ListRoutesTable","tags":["ExpressRouteCircuitRoutesTabl...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTablesSummary/{devicePath}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTablesSummary/{devicePath}__deleted']` | deleted | `{"post":{"operationId":"ExpressRouteCircuits_ListRoutesTableSummary","tags":["ExpressRouteCircuitRou...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/stats`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/stats__deleted']` | deleted | `{"get":{"operationId":"ExpressRouteCircuits_GetPeeringStats","tags":["ExpressRouteCircuitStats"],"pa...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations__deleted']` | deleted | `{"get":{"operationId":"ExpressRoutePortAuthorizations_List","tags":["ExpressRoutePortAuthorizations"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations/{authorizationName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations/{authorizationName}__deleted']` | deleted | `{"get":{"operationId":"ExpressRoutePortAuthorizations_Get","tags":["ExpressRoutePortAuthorizations"]...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions__deleted']` | deleted | `{"get":{"operationId":"ServiceEndpointPolicyDefinitions_ListByResourceGroup","tags":["ServiceEndpoin...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions/{serviceEndpointPolicyDefinitionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions/{serviceEndpointPolicyDefinitionName}__deleted']` | deleted | `{"get":{"operationId":"ServiceEndpointPolicyDefinitions_Get","tags":["serviceEndpointPolicyDefinitio...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteGateways`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteGateways__added']` | added | `{"get":{"operationId":"ExpressRouteGateways_ListBySubscription","tags":["ExpressRouteGateways"],"par...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways__added']` | added | `{"get":{"operationId":"ExpressRouteGateways_ListByResourceGroup","tags":["ExpressRouteGateways"],"pa...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}__added']` | added | `{"get":{"operationId":"ExpressRouteGateways_Get","tags":["ExpressRouteGateways"],"parameters":[{"nam...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections__added']` | added | `{"get":{"operationId":"ExpressRouteConnections_List","tags":["ExpressRouteGateways"],"parameters":[{...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}__added']` | added | `{"get":{"operationId":"ExpressRouteConnections_Get","tags":["ExpressRouteGateways"],"parameters":[{"...` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}'].put.responses.200.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/arpTables/{devicePath}'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/routeTables/{devicePath}'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/routeTablesSummary/{devicePath}'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ExpressRouteCircuit` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ExpressRouteCrossConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `./common.json/definitions/ExpressRouteCrossConnectionPeering` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ExpressRoutePort` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/RouteFilter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `./common.json/definitions/RouteFilterRule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ServiceEndpointPolicy` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitPropertiesFormat.properties.bandwidthInGbps.format__added` | added | `float` |
| `definitions.ExpressRouteCrossConnectionProperties.properties.sTag.format__added` | added | `int32` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.bandwidthInGbps.format__added` | added | `int32` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.provisionedBandwidthInGbps.format__added` | added | `float` |
| `definitions.ExpressRoutePortsLocationBandwidths.properties.valueInGbps.format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |

### Changes for `AuthorizationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AuthorizationListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `BgpServiceCommunity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BgpServiceCommunity__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/BgpServiceCommunityPropertiesForm...` |

### Changes for `BgpServiceCommunityListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BgpServiceCommunityListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ExpressRouteCircuitsArpTableListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitsArpTableListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ExpressRouteCircuitsRoutesTableListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitsRoutesTableListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ExpressRouteCircuitsRoutesTableSummaryListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitsRoutesTableSummaryListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ExpressRouteCrossConnectionPeering`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCrossConnectionPeering__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ExpressRouteCrossConnectionPeerin...` |

### Changes for `ExpressRouteCrossConnectionPeeringList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCrossConnectionPeeringList__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ExpressRouteCrossConnectionsRoutesTableSummaryListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCrossConnectionsRoutesTableSummaryListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ExpressRouteLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteLink__deleted` | deleted | `{"type":"object","title":"ExpressRouteLink","properties":{"properties":{"$ref":"#/definitions/Expres...` |

### Changes for `ExpressRouteLinkListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteLinkListResult__deleted` | deleted | `{"type":"object","title":"ExpressRouteLink List Result","description":"[Placeholder] Discription for...` |

### Changes for `ExpressRoutePortAuthorizationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRoutePortAuthorizationListResult__deleted` | deleted | `{"type":"object","title":"ExpressRoute Port Authorization List Result","description":"[Placeholder] ...` |

### Changes for `ExpressRoutePortListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRoutePortListResult__deleted` | deleted | `{"type":"object","title":"ExpressRoute Port List Result","description":"[Placeholder] Discription fo...` |

### Changes for `ExpressRoutePortsLocationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRoutePortsLocationListResult__deleted` | deleted | `{"type":"object","title":"ExpressRoutePorts Location List Result","description":"[Placeholder] Discr...` |

### Changes for `ExpressRouteServiceProvider`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteServiceProvider__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ExpressRouteServiceProviderProper...` |

### Changes for `ExpressRouteServiceProviderListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteServiceProviderListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `PatchRouteFilter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PatchRouteFilter__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/RouteFilterPropertiesFormat","x-m...` |

### Changes for `PatchRouteFilterRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PatchRouteFilterRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/RouteFilterRulePropertiesFormat",...` |

### Changes for `RouteFilterRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RouteFilterRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/RouteFilterRulePropertiesFormat",...` |

### Changes for `RouteFilterRuleListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RouteFilterRuleListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdvertisedPublicPrefixProperties.properties.validationState.type__deleted` | deleted | `string` |
| `definitions.AuthorizationPropertiesFormat.properties.authorizationUseStatus.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteCircuitAuthorization.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.ExpressRouteCircuitConnection.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.ExpressRouteCircuitConnectionPropertiesFormat.properties.circuitConnectionStatus.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteCircuitPeering.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.ExpressRouteCircuitPeeringConfig.properties.advertisedPublicPrefixesState.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat.properties.peeringType.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat.properties.state.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteCircuitPropertiesFormat.properties.serviceProviderProvisioningState.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteCircuitSku.properties.family.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteCircuitSku.properties.tier.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteLinkMacSecConfig.properties.cipher.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteLinkMacSecConfig.properties.sciState.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteLinkPropertiesFormat.properties.adminState.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteLinkPropertiesFormat.properties.connectorType.type__deleted` | deleted | `string` |
| `definitions.ExpressRoutePortAuthorization.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.ExpressRoutePortAuthorizationPropertiesFormat.properties.authorizationUseStatus.type__deleted` | deleted | `string` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.billingType.type__deleted` | deleted | `string` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.encapsulation.type__deleted` | deleted | `string` |
| `definitions.ExpressRouteProviderPort.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.Ipv6CircuitConnectionConfig.properties.circuitConnectionStatus.type__deleted` | deleted | `string` |
| `definitions.Ipv6ExpressRouteCircuitPeeringConfig.properties.state.type__deleted` | deleted | `string` |
| `definitions.PeerExpressRouteCircuitConnection.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.PeerExpressRouteCircuitConnectionPropertiesFormat.properties.circuitConnectionStatus.type__deleted` | deleted | `string` |
| `definitions.RouteFilterRulePropertiesFormat.properties.routeFilterRuleType.type__deleted` | deleted | `string` |
| `definitions.ServiceEndpointPolicyDefinition.properties.type__deleted` | deleted | `{"type":"string"}` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdvertisedPublicPrefixProperties.properties.validationState.enum__deleted` | deleted | `["NotConfigured","Configuring","Configured","ValidationNeeded","ValidationFailed","ManualValidationN...` |
| `definitions.AuthorizationPropertiesFormat.properties.authorizationUseStatus.enum__deleted` | deleted | `["Available","InUse"]` |
| `definitions.ExpressRouteCircuitConnectionPropertiesFormat.properties.circuitConnectionStatus.enum__deleted` | deleted | `["Connected","Connecting","Disconnected"]` |
| `definitions.ExpressRouteCircuitPeeringConfig.properties.advertisedPublicPrefixesState.enum__deleted` | deleted | `["NotConfigured","Configuring","Configured","ValidationNeeded"]` |
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat.properties.peeringType.enum__deleted` | deleted | `["AzurePublicPeering","AzurePrivatePeering","MicrosoftPeering"]` |
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat.properties.state.enum__deleted` | deleted | `["Disabled","Enabled"]` |
| `definitions.ExpressRouteCircuitPropertiesFormat.properties.serviceProviderProvisioningState.enum__deleted` | deleted | `["NotProvisioned","Provisioning","Provisioned","Deprovisioning"]` |
| `definitions.ExpressRouteCircuitSku.properties.family.enum__deleted` | deleted | `["UnlimitedData","MeteredData"]` |
| `definitions.ExpressRouteCircuitSku.properties.tier.enum__deleted` | deleted | `["Standard","Premium","Basic","Local"]` |
| `definitions.ExpressRouteLinkMacSecConfig.properties.cipher.enum__deleted` | deleted | `["GcmAes256","GcmAes128","GcmAesXpn128","GcmAesXpn256"]` |
| `definitions.ExpressRouteLinkMacSecConfig.properties.sciState.enum__deleted` | deleted | `["Disabled","Enabled"]` |
| `definitions.ExpressRouteLinkPropertiesFormat.properties.adminState.enum__deleted` | deleted | `["Enabled","Disabled"]` |
| `definitions.ExpressRouteLinkPropertiesFormat.properties.connectorType.enum__deleted` | deleted | `["LC","SC"]` |
| `definitions.ExpressRoutePortAuthorizationPropertiesFormat.properties.authorizationUseStatus.enum__deleted` | deleted | `["Available","InUse"]` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.billingType.enum__deleted` | deleted | `["MeteredData","UnlimitedData"]` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.encapsulation.enum__deleted` | deleted | `["Dot1Q","QinQ"]` |
| `definitions.Ipv6CircuitConnectionConfig.properties.circuitConnectionStatus.enum__deleted` | deleted | `["Connected","Connecting","Disconnected"]` |
| `definitions.Ipv6ExpressRouteCircuitPeeringConfig.properties.state.enum__deleted` | deleted | `["Disabled","Enabled"]` |
| `definitions.PeerExpressRouteCircuitConnectionPropertiesFormat.properties.circuitConnectionStatus.enum__deleted` | deleted | `["Connected","Connecting","Disconnected"]` |
| `definitions.RouteFilterRulePropertiesFormat.properties.routeFilterRuleType.enum__deleted` | deleted | `["Community"]` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdvertisedPublicPrefixProperties.properties.validationState['x-ms-enum__deleted']` | deleted | `{"name":"AdvertisedPublicPrefixPropertiesValidationState","modelAsString":true}` |
| `definitions.AuthorizationPropertiesFormat.properties.authorizationUseStatus['x-ms-enum__deleted']` | deleted | `{"name":"AuthorizationUseStatus","modelAsString":true}` |
| `definitions.ExpressRouteCircuitConnectionPropertiesFormat.properties.circuitConnectionStatus['x-ms-enum__deleted']` | deleted | `{"name":"CircuitConnectionStatus","modelAsString":true}` |
| `definitions.ExpressRouteCircuitPeeringConfig.properties.advertisedPublicPrefixesState['x-ms-enum__deleted']` | deleted | `{"name":"ExpressRouteCircuitPeeringAdvertisedPublicPrefixState","modelAsString":true}` |
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat.properties.peeringType['x-ms-enum__deleted']` | deleted | `{"name":"ExpressRoutePeeringType","modelAsString":true}` |
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat.properties.state['x-ms-enum__deleted']` | deleted | `{"name":"ExpressRoutePeeringState","modelAsString":true}` |
| `definitions.ExpressRouteCircuitPropertiesFormat.properties.serviceProviderProvisioningState['x-ms-enum__deleted']` | deleted | `{"name":"ServiceProviderProvisioningState","modelAsString":true}` |
| `definitions.ExpressRouteCircuitSku.properties.family['x-ms-enum__deleted']` | deleted | `{"name":"ExpressRouteCircuitSkuFamily","modelAsString":true}` |
| `definitions.ExpressRouteCircuitSku.properties.tier['x-ms-enum__deleted']` | deleted | `{"name":"ExpressRouteCircuitSkuTier","modelAsString":true}` |
| `definitions.ExpressRouteLinkMacSecConfig.properties.cipher['x-ms-enum__deleted']` | deleted | `{"name":"ExpressRouteLinkMacSecCipher","modelAsString":true}` |
| `definitions.ExpressRouteLinkMacSecConfig.properties.sciState['x-ms-enum__deleted']` | deleted | `{"name":"ExpressRouteLinkMacSecSciState","modelAsString":true}` |
| `definitions.ExpressRouteLinkPropertiesFormat.properties.adminState['x-ms-enum__deleted']` | deleted | `{"name":"ExpressRouteLinkAdminState","modelAsString":true}` |
| `definitions.ExpressRouteLinkPropertiesFormat.properties.connectorType['x-ms-enum__deleted']` | deleted | `{"name":"ExpressRouteLinkConnectorType","modelAsString":true}` |
| `definitions.ExpressRoutePortAuthorizationPropertiesFormat.properties.authorizationUseStatus['x-ms-enum__deleted']` | deleted | `{"name":"ExpressRoutePortAuthorizationUseStatus","modelAsString":true}` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.billingType['x-ms-enum__deleted']` | deleted | `{"name":"ExpressRoutePortsBillingType","modelAsString":true}` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.encapsulation['x-ms-enum__deleted']` | deleted | `{"name":"ExpressRoutePortsEncapsulation","modelAsString":true}` |
| `definitions.Ipv6CircuitConnectionConfig.properties.circuitConnectionStatus['x-ms-enum__deleted']` | deleted | `{"name":"CircuitConnectionStatus","modelAsString":true}` |
| `definitions.Ipv6ExpressRouteCircuitPeeringConfig.properties.state['x-ms-enum__deleted']` | deleted | `{"name":"ExpressRouteCircuitPeeringState","modelAsString":true}` |
| `definitions.PeerExpressRouteCircuitConnectionPropertiesFormat.properties.circuitConnectionStatus['x-ms-enum__deleted']` | deleted | `{"name":"CircuitConnectionStatus","modelAsString":true}` |
| `definitions.RouteFilterRulePropertiesFormat.properties.routeFilterRuleType['x-ms-enum__deleted']` | deleted | `{"name":"RouteFilterRuleType","modelAsString":true}` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdvertisedPublicPrefixProperties.properties.validationState.$ref__added` | added | `./common.json/definitions/AdvertisedPublicPrefixPropertiesValidationState` |
| `definitions.AuthorizationPropertiesFormat.properties.authorizationUseStatus.$ref__added` | added | `./common.json/definitions/AuthorizationUseStatus` |
| `definitions.ExpressRouteCircuitConnectionPropertiesFormat.properties.circuitConnectionStatus.$ref__added` | added | `./common.json/definitions/CircuitConnectionStatus` |
| `definitions.ExpressRouteCircuitPeeringConfig.properties.advertisedPublicPrefixesState.$ref__added` | added | `./common.json/definitions/ExpressRouteCircuitPeeringAdvertisedPublicPrefixState` |
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat.properties.peeringType.$ref__added` | added | `./common.json/definitions/ExpressRoutePeeringType` |
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat.properties.state.$ref__added` | added | `./common.json/definitions/ExpressRoutePeeringState` |
| `definitions.ExpressRouteCircuitPropertiesFormat.properties.serviceProviderProvisioningState.$ref__added` | added | `./common.json/definitions/ServiceProviderProvisioningState` |
| `definitions.ExpressRouteCircuitSku.properties.family.$ref__added` | added | `./common.json/definitions/ExpressRouteCircuitSkuFamily` |
| `definitions.ExpressRouteCircuitSku.properties.tier.$ref__added` | added | `./common.json/definitions/ExpressRouteCircuitSkuTier` |
| `definitions.ExpressRouteLinkMacSecConfig.properties.cipher.$ref__added` | added | `./common.json/definitions/ExpressRouteLinkMacSecCipher` |
| `definitions.ExpressRouteLinkMacSecConfig.properties.sciState.$ref__added` | added | `./common.json/definitions/ExpressRouteLinkMacSecSciState` |
| `definitions.ExpressRouteLinkPropertiesFormat.properties.adminState.$ref__added` | added | `./common.json/definitions/ExpressRouteLinkAdminState` |
| `definitions.ExpressRouteLinkPropertiesFormat.properties.connectorType.$ref__added` | added | `./common.json/definitions/ExpressRouteLinkConnectorType` |
| `definitions.ExpressRoutePortAuthorizationPropertiesFormat.properties.authorizationUseStatus.$ref__added` | added | `./common.json/definitions/ExpressRoutePortAuthorizationUseStatus` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.billingType.$ref__added` | added | `./common.json/definitions/ExpressRoutePortsBillingType` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.encapsulation.$ref__added` | added | `./common.json/definitions/ExpressRoutePortsEncapsulation` |
| `definitions.Ipv6CircuitConnectionConfig.properties.circuitConnectionStatus.$ref__added` | added | `./common.json/definitions/CircuitConnectionStatus` |
| `definitions.Ipv6ExpressRouteCircuitPeeringConfig.properties.state.$ref__added` | added | `./common.json/definitions/ExpressRouteCircuitPeeringState` |
| `definitions.PeerExpressRouteCircuitConnectionPropertiesFormat.properties.circuitConnectionStatus.$ref__added` | added | `./common.json/definitions/CircuitConnectionStatus` |
| `definitions.RouteFilterRulePropertiesFormat.properties.routeFilterRuleType.$ref__added` | added | `./common.json/definitions/RouteFilterRuleType` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitAuthorization.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.ExpressRouteCircuitConnection.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.ExpressRouteCircuitPeering.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.ExpressRoutePortAuthorization.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.ExpressRouteProviderPort.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.PeerExpressRouteCircuitConnection.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.ServiceEndpointPolicyDefinition.properties.name__deleted` | deleted | `{"type":"string"}` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitConnectionListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRouteCircuitListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRouteCircuitPeeringListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRouteCrossConnectionListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRouteProviderPortListResult.required__added` | added | `["value"]` |
| `definitions.PeerExpressRouteCircuitConnectionListResult.required__added` | added | `["value"]` |
| `definitions.RouteFilter.required__deleted` | deleted | `["location"]` |
| `definitions.RouteFilterListResult.required__added` | added | `["value"]` |
| `definitions.ServiceEndpointPolicyDefinitionListResult.required__added` | added | `["value"]` |
| `definitions.ServiceEndpointPolicyListResult.required__added` | added | `["value"]` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRoutePortPropertiesFormat.properties.links.readOnly__deleted` | deleted | `false` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteProviderPort.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AuthorizationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.ExpressRouteCircuit.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.ExpressRouteCircuitAuthorization.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResourceModel` |
| `definitions.ExpressRouteCircuitConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResourceModel` |
| `definitions.ExpressRouteCircuitConnectionPropertiesFormat.properties.expressRouteCircuitPeering.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.ExpressRouteCircuitConnectionPropertiesFormat.properties.peerExpressRouteCircuitPeering.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.ExpressRouteCircuitConnectionPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.ExpressRouteCircuitPeering.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResourceModel` |
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat.properties.expressRouteConnection.$ref` | `./virtualWan.json#/definitions/ExpressRouteConnectionId` | `./virtualWan.json/definitions/ExpressRouteConnectionId` |
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat.properties.routeFilter.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.ExpressRouteCircuitPropertiesFormat.properties.expressRoutePort.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.ExpressRouteCircuitPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.ExpressRouteCrossConnection.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.ipv6PeeringConfig.$ref` | `./expressRouteCircuit.json#/definitions/Ipv6ExpressRouteCircuitPeeringConfig` | `#/definitions/Ipv6ExpressRouteCircuitPeeringConfig` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.microsoftPeeringConfig.$ref` | `./expressRouteCircuit.json#/definitions/ExpressRouteCircuitPeeringConfig` | `#/definitions/ExpressRouteCircuitPeeringConfig` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.peeringType.$ref` | `./expressRouteCircuit.json#/definitions/ExpressRoutePeeringType` | `./common.json/definitions/ExpressRoutePeeringType` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.state.$ref` | `./expressRouteCircuit.json#/definitions/ExpressRoutePeeringState` | `./common.json/definitions/ExpressRoutePeeringState` |
| `definitions.ExpressRouteCrossConnectionProperties.properties.peerings.items.$ref` | `#/definitions/ExpressRouteCrossConnectionPeering` | `./common.json/definitions/ExpressRouteCrossConnectionPeering` |
| `definitions.ExpressRouteCrossConnectionProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.ExpressRouteCrossConnectionProperties.properties.serviceProviderProvisioningState.$ref` | `./expressRouteCircuit.json#/definitions/ServiceProviderProvisioningState` | `./common.json/definitions/ServiceProviderProvisioningState` |
| `definitions.ExpressRouteLinkPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.ExpressRoutePort.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.ExpressRoutePort.properties.identity.$ref` | `./network.json#/definitions/ManagedServiceIdentity` | `./common.json/definitions/ManagedServiceIdentity` |
| `definitions.ExpressRoutePortAuthorization.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResourceModel` |
| `definitions.ExpressRoutePortAuthorizationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.circuits.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.links.items.$ref` | `#/definitions/ExpressRouteLink` | `./common.json/definitions/ExpressRouteLink` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.ExpressRoutePortsLocation.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.ExpressRoutePortsLocationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.ExpressRouteProviderPort.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/ResourceWithReadOnlyNameAndID` |
| `definitions.ExpressRouteServiceProviderPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.Ipv6ExpressRouteCircuitPeeringConfig.properties.routeFilter.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.PeerExpressRouteCircuitConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResourceModel` |
| `definitions.PeerExpressRouteCircuitConnectionPropertiesFormat.properties.expressRouteCircuitPeering.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.PeerExpressRouteCircuitConnectionPropertiesFormat.properties.peerExpressRouteCircuitPeering.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.PeerExpressRouteCircuitConnectionPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.RouteFilter.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/ResourceWithRequiredLocation` |
| `definitions.RouteFilterPropertiesFormat.properties.ipv6Peerings.items.$ref` | `./expressRouteCircuit.json#/definitions/ExpressRouteCircuitPeering` | `#/definitions/ExpressRouteCircuitPeering` |
| `definitions.RouteFilterPropertiesFormat.properties.peerings.items.$ref` | `./expressRouteCircuit.json#/definitions/ExpressRouteCircuitPeering` | `#/definitions/ExpressRouteCircuitPeering` |
| `definitions.RouteFilterPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.RouteFilterPropertiesFormat.properties.rules.items.$ref` | `#/definitions/RouteFilterRule` | `./common.json/definitions/RouteFilterRule` |
| `definitions.RouteFilterRulePropertiesFormat.properties.access.$ref` | `./network.json#/definitions/Access` | `./common.json/definitions/Access` |
| `definitions.RouteFilterRulePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.ServiceEndpointPolicy.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.ServiceEndpointPolicyDefinition.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResourceModel` |
| `definitions.ServiceEndpointPolicyDefinitionPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.ServiceEndpointPolicyPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.ServiceEndpointPolicyPropertiesFormat.properties.subnets.items.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `./common.json/definitions/Subnet` |
| `info.description` | `The Microsoft Azure Network management API provides a RESTful set of web services that interact with Microsoft Azure Networks service to manage your network resources. The API has entities that capture the relationship between an end user and the Microsoft Azure Networks service.` | `APIs to manage web application firewall rules.` |
| `info.title` | `NetworkManagementClient` | `WebApplicationFirewallManagement` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/bgpServiceCommunities'].get.responses.200.schema.$ref` | `#/definitions/BgpServiceCommunityListResult` | `./common.json/definitions/BgpServiceCommunityListResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/bgpServiceCommunities'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteCircuits'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteCrossConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRoutePorts'].get.responses.200.schema.$ref` | `#/definitions/ExpressRoutePortListResult` | `./common.json/definitions/ExpressRoutePortListResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRoutePorts'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteProviderPorts'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteProviderPorts/{providerport}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/routeFilters'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/serviceEndpointPolicies'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/stats'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings'].get.responses.200.schema.$ref` | `#/definitions/ExpressRouteCrossConnectionPeeringList` | `./common.json/definitions/ExpressRouteCrossConnectionPeeringList` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}'].get.responses.200.schema.$ref` | `#/definitions/ExpressRouteCrossConnectionPeering` | `./common.json/definitions/ExpressRouteCrossConnectionPeering` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}'].put.parameters[2].schema.$ref` | `#/definitions/ExpressRouteCrossConnectionPeering` | `./common.json/definitions/ExpressRouteCrossConnectionPeering` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}'].put.responses.200.schema.$ref` | `#/definitions/ExpressRouteCrossConnectionPeering` | `./common.json/definitions/ExpressRouteCrossConnectionPeering` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}'].put.responses.201.schema.$ref` | `#/definitions/ExpressRouteCrossConnectionPeering` | `./common.json/definitions/ExpressRouteCrossConnectionPeering` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/arpTables/{devicePath}'].post.responses.200.schema.$ref` | `./expressRouteCircuit.json#/definitions/ExpressRouteCircuitsArpTableListResult` | `./common.json/definitions/ExpressRouteCircuitsArpTableListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/arpTables/{devicePath}'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/routeTables/{devicePath}'].post.responses.200.schema.$ref` | `./expressRouteCircuit.json#/definitions/ExpressRouteCircuitsRoutesTableListResult` | `./common.json/definitions/ExpressRouteCircuitsRoutesTableListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/routeTables/{devicePath}'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/routeTablesSummary/{devicePath}'].post.responses.200.schema.$ref` | `#/definitions/ExpressRouteCrossConnectionsRoutesTableSummaryListResult` | `./common.json/definitions/ExpressRouteCrossConnectionsRoutesTableSummaryListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/routeTablesSummary/{devicePath}'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts'].get.responses.200.schema.$ref` | `#/definitions/ExpressRoutePortListResult` | `./common.json/definitions/ExpressRoutePortListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].delete.responses.202.headers.Location.description` | `URL for determining when an operation has completed. Send a GET request to the URL in Location header.
The URI should return a 202 until the operation reaches a terminal state and 200 once it reaches a terminal state.

For more info: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#202-accepted-and-location-headers` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `URL for checking the ongoing status of the operation.
To get the status of the asynchronous operation, send a GET request to the URL in Azure-AsyncOperation header value.

For more info: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#asynchronous-operations` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/generateLoa'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/links'].get.responses.200.schema.$ref` | `#/definitions/ExpressRouteLinkListResult` | `./common.json/definitions/ExpressRouteLinkListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/links'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/links/{linkName}'].get.responses.200.schema.$ref` | `#/definitions/ExpressRouteLink` | `./common.json/definitions/ExpressRouteLink` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/links/{linkName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].delete.responses.202.headers.Location.description` | `URL for determining when an operation has completed. Send a GET request to the URL in Location header.
The URI should return a 202 until the operation reaches a terminal state and 200 once it reaches a terminal state.

For more info: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#202-accepted-and-location-headers` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `URL for checking the ongoing status of the operation.
To get the status of the asynchronous operation, send a GET request to the URL in Azure-AsyncOperation header value.

For more info: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#asynchronous-operations` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules'].get.responses.200.schema.$ref` | `#/definitions/RouteFilterRuleListResult` | `./common.json/definitions/RouteFilterRuleListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].delete.responses.202.headers.Location.description` | `URL for determining when an operation has completed. Send a GET request to the URL in Location header.
The URI should return a 202 until the operation reaches a terminal state and 200 once it reaches a terminal state.

For more info: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#202-accepted-and-location-headers` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `URL for checking the ongoing status of the operation.
To get the status of the asynchronous operation, send a GET request to the URL in Azure-AsyncOperation header value.

For more info: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#asynchronous-operations` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].get.responses.200.schema.$ref` | `#/definitions/RouteFilterRule` | `./common.json/definitions/RouteFilterRule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].put.parameters[2].schema.$ref` | `#/definitions/RouteFilterRule` | `./common.json/definitions/RouteFilterRule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].put.responses.200.schema.$ref` | `#/definitions/RouteFilterRule` | `./common.json/definitions/RouteFilterRule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].put.responses.201.schema.$ref` | `#/definitions/RouteFilterRule` | `./common.json/definitions/RouteFilterRule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |

