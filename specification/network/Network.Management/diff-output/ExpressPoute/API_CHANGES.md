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

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRoutePortsLocations`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRoutePortsLocations__deleted']` | deleted | `{"get":{"operationId":"ExpressRoutePortsLocations_List","parameters":[],"responses":{"200":{"descrip...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRoutePortsLocations/{locationName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRoutePortsLocations/{locationName}__deleted']` | deleted | `{"get":{"operationId":"ExpressRoutePortsLocations_Get","parameters":[{"name":"locationName","in":"pa...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteServiceProviders`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteServiceProviders__deleted']` | deleted | `{"get":{"operationId":"ExpressRouteServiceProviders_List","parameters":[],"responses":{"200":{"descr...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/authorizations`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/authorizations__deleted']` | deleted | `{"get":{"operationId":"ExpressRouteCircuitAuthorizations_List","parameters":[{"name":"circuitName","...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/authorizations/{authorizationName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/authorizations/{authorizationName}__deleted']` | deleted | `{"get":{"operationId":"ExpressRouteCircuitAuthorizations_Get","parameters":[{"name":"circuitName","i...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings__deleted']` | deleted | `{"get":{"operationId":"ExpressRouteCircuitPeerings_List","parameters":[{"name":"circuitName","in":"p...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}__deleted']` | deleted | `{"get":{"operationId":"ExpressRouteCircuitPeerings_Get","parameters":[{"name":"circuitName","in":"pa...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/arpTables/{devicePath}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/arpTables/{devicePath}__deleted']` | deleted | `{"post":{"operationId":"ExpressRouteCircuits_ListArpTable","parameters":[{"name":"circuitName","in":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections__deleted']` | deleted | `{"get":{"operationId":"ExpressRouteCircuitConnections_List","parameters":[{"name":"circuitName","in"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections/{connectionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections/{connectionName}__deleted']` | deleted | `{"get":{"operationId":"ExpressRouteCircuitConnections_Get","parameters":[{"name":"circuitName","in":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/peerConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/peerConnections__deleted']` | deleted | `{"get":{"operationId":"PeerExpressRouteCircuitConnections_List","parameters":[{"name":"circuitName",...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/peerConnections/{connectionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/peerConnections/{connectionName}__deleted']` | deleted | `{"get":{"operationId":"PeerExpressRouteCircuitConnections_Get","parameters":[{"name":"circuitName","...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTables/{devicePath}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTables/{devicePath}__deleted']` | deleted | `{"post":{"operationId":"ExpressRouteCircuits_ListRoutesTable","parameters":[{"name":"circuitName","i...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTablesSummary/{devicePath}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTablesSummary/{devicePath}__deleted']` | deleted | `{"post":{"operationId":"ExpressRouteCircuits_ListRoutesTableSummary","parameters":[{"name":"circuitN...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/stats`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/stats__deleted']` | deleted | `{"get":{"operationId":"ExpressRouteCircuits_GetPeeringStats","parameters":[{"name":"circuitName","in...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations__deleted']` | deleted | `{"get":{"operationId":"ExpressRoutePortAuthorizations_List","parameters":[{"name":"expressRoutePortN...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations/{authorizationName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations/{authorizationName}__deleted']` | deleted | `{"get":{"operationId":"ExpressRoutePortAuthorizations_Get","parameters":[{"name":"expressRoutePortNa...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions__deleted']` | deleted | `{"get":{"operationId":"ServiceEndpointPolicyDefinitions_ListByResourceGroup","parameters":[{"name":"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions/{serviceEndpointPolicyDefinitionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions/{serviceEndpointPolicyDefinitionName}__deleted']` | deleted | `{"get":{"operationId":"ServiceEndpointPolicyDefinitions_Get","parameters":[{"name":"serviceEndpointP...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteGateways`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteGateways__added']` | added | `{"get":{"operationId":"ExpressRouteGateways_ListBySubscription","parameters":[],"responses":{"200":{...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways__added']` | added | `{"get":{"operationId":"ExpressRouteGateways_ListByResourceGroup","parameters":[],"responses":{"200":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}__added']` | added | `{"get":{"operationId":"ExpressRouteGateways_Get","parameters":[{"name":"expressRouteGatewayName","in...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections__added']` | added | `{"get":{"operationId":"ExpressRouteConnections_List","parameters":[{"name":"expressRouteGatewayName"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}__added']` | added | `{"get":{"operationId":"ExpressRouteConnections_Get","parameters":[{"name":"expressRouteGatewayName",...` |

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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |

### Changes for `AdvertisedPublicPrefixProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdvertisedPublicPrefixProperties__deleted` | deleted | `{"type":"object","properties":{"prefix":{"type":"string"},"validationId":{"type":"string"},"signatur...` |

### Changes for `AuthorizationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AuthorizationListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `AuthorizationPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AuthorizationPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"authorizationKey":{"type":"string"},"authorizationUseStatus":{"type"...` |

### Changes for `BGPCommunity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BGPCommunity__deleted` | deleted | `{"type":"object","properties":{"serviceSupportedRegion":{"type":"string"},"communityName":{"type":"s...` |

### Changes for `BgpServiceCommunity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BgpServiceCommunity__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/BgpServiceCommunityPropertiesForm...` |

### Changes for `BgpServiceCommunityListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BgpServiceCommunityListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `BgpServiceCommunityPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BgpServiceCommunityPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"serviceName":{"type":"string"},"bgpCommunities":{"type":"array","ite...` |

### Changes for `ExpressRouteCircuitArpTable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitArpTable__deleted` | deleted | `{"type":"object","properties":{"age":{"type":"integer","format":"int32"},"interface":{"type":"string...` |

### Changes for `ExpressRouteCircuitAuthorization`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitAuthorization__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/AuthorizationPropertiesFormat","x...` |

### Changes for `ExpressRouteCircuitConnection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitConnection__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ExpressRouteCircuitConnectionProp...` |

### Changes for `ExpressRouteCircuitConnectionListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitConnectionListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ExpressRouteCircuitConnectionPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitConnectionPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"expressRouteCircuitPeering":{"$ref":"./network.json#/definitions/Sub...` |

### Changes for `ExpressRouteCircuitPeering`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitPeering__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ExpressRouteCircuitPeeringPropert...` |

### Changes for `ExpressRouteCircuitPeeringConfig`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitPeeringConfig__deleted` | deleted | `{"type":"object","properties":{"advertisedPublicPrefixes":{"type":"array","items":{"type":"string"}}...` |

### Changes for `ExpressRouteCircuitPeeringListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitPeeringListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ExpressRouteCircuitPeeringPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"peeringType":{"type":"string","enum":["AzurePublicPeering","AzurePri...` |

### Changes for `ExpressRouteCircuitPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"allowClassicOperations":{"type":"boolean"},"circuitProvisioningState...` |

### Changes for `ExpressRouteCircuitReference`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitReference__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string"}}}` |

### Changes for `ExpressRouteCircuitRoutesTable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitRoutesTable__deleted` | deleted | `{"type":"object","properties":{"network":{"type":"string"},"nextHop":{"type":"string"},"locPrf":{"ty...` |

### Changes for `ExpressRouteCircuitRoutesTableSummary`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitRoutesTableSummary__deleted` | deleted | `{"type":"object","properties":{"neighbor":{"type":"string"},"v":{"type":"integer","format":"int32"},...` |

### Changes for `ExpressRouteCircuitServiceProviderProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitServiceProviderProperties__deleted` | deleted | `{"type":"object","properties":{"serviceProviderName":{"type":"string"},"peeringLocation":{"type":"st...` |

### Changes for `ExpressRouteCircuitSku`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitSku__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"tier":{"type":"string","enum":["Standard","...` |

### Changes for `ExpressRouteCircuitStats`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitStats__deleted` | deleted | `{"type":"object","properties":{"primarybytesIn":{"type":"integer","format":"int64"},"primarybytesOut...` |

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

### Changes for `ExpressRouteCrossConnectionPeeringProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCrossConnectionPeeringProperties__deleted` | deleted | `{"type":"object","properties":{"peeringType":{"$ref":"./expressRouteCircuit.json#/definitions/Expres...` |

### Changes for `ExpressRouteCrossConnectionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCrossConnectionProperties__deleted` | deleted | `{"type":"object","properties":{"primaryAzurePort":{"type":"string","readOnly":true},"secondaryAzureP...` |

### Changes for `ExpressRouteCrossConnectionRoutesTableSummary`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCrossConnectionRoutesTableSummary__deleted` | deleted | `{"type":"object","properties":{"neighbor":{"type":"string"},"asn":{"type":"integer","format":"int32"...` |

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

### Changes for `ExpressRouteLinkMacSecConfig`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteLinkMacSecConfig__deleted` | deleted | `{"type":"object","title":"Definition of ExpressRouteLink Mac Security configuration.","properties":{...` |

### Changes for `ExpressRouteLinkPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteLinkPropertiesFormat__deleted` | deleted | `{"type":"object","title":"ExpressRouteLink Resource Properties","properties":{"routerName":{"type":"...` |

### Changes for `ExpressRoutePortAuthorization`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRoutePortAuthorization__deleted` | deleted | `{"type":"object","title":"ExpressRoute Port Authorization","properties":{"properties":{"$ref":"#/def...` |

### Changes for `ExpressRoutePortAuthorizationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRoutePortAuthorizationListResult__deleted` | deleted | `{"type":"object","title":"ExpressRoute Port Authorization List Result","description":"[Placeholder] ...` |

### Changes for `ExpressRoutePortAuthorizationPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRoutePortAuthorizationPropertiesFormat__deleted` | deleted | `{"type":"object","title":"ExpressRoute Port Authorization Properties","properties":{"authorizationKe...` |

### Changes for `ExpressRoutePortListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRoutePortListResult__deleted` | deleted | `{"type":"object","title":"ExpressRoute Port List Result","description":"[Placeholder] Discription fo...` |

### Changes for `ExpressRoutePortPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRoutePortPropertiesFormat__deleted` | deleted | `{"type":"object","title":"ExpressRoutePort Properties","properties":{"peeringLocation":{"type":"stri...` |

### Changes for `ExpressRoutePortsLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRoutePortsLocation__deleted` | deleted | `{"type":"object","title":"ExpressRoutePorts Peering Location","properties":{"properties":{"$ref":"#/...` |

### Changes for `ExpressRoutePortsLocationBandwidths`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRoutePortsLocationBandwidths__deleted` | deleted | `{"type":"object","title":"ExpressRoutePorts Location Bandwidths","properties":{"offerName":{"type":"...` |

### Changes for `ExpressRoutePortsLocationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRoutePortsLocationListResult__deleted` | deleted | `{"type":"object","title":"ExpressRoutePorts Location List Result","description":"[Placeholder] Discr...` |

### Changes for `ExpressRoutePortsLocationPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRoutePortsLocationPropertiesFormat__deleted` | deleted | `{"type":"object","title":"ExpressRoutePorts Location Properties","properties":{"address":{"type":"st...` |

### Changes for `ExpressRouteProviderPortProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteProviderPortProperties__deleted` | deleted | `{"type":"object","properties":{"portPairDescriptor":{"type":"string","readOnly":true},"primaryAzureP...` |

### Changes for `ExpressRouteServiceProvider`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteServiceProvider__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ExpressRouteServiceProviderProper...` |

### Changes for `ExpressRouteServiceProviderBandwidthsOffered`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteServiceProviderBandwidthsOffered__deleted` | deleted | `{"type":"object","properties":{"offerName":{"type":"string"},"valueInMbps":{"type":"integer","format...` |

### Changes for `ExpressRouteServiceProviderListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteServiceProviderListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ExpressRouteServiceProviderPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteServiceProviderPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"peeringLocations":{"type":"array","items":{"type":"string"}},"bandwi...` |

### Changes for `GenerateExpressRoutePortsLOARequest`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GenerateExpressRoutePortsLOARequest__deleted` | deleted | `{"type":"object","properties":{"customerName":{"type":"string"}},"required":["customerName"]}` |

### Changes for `GenerateExpressRoutePortsLOAResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GenerateExpressRoutePortsLOAResult__deleted` | deleted | `{"type":"object","properties":{"encodedContent":{"type":"string"}}}` |

### Changes for `Ipv6CircuitConnectionConfig`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Ipv6CircuitConnectionConfig__deleted` | deleted | `{"type":"object","properties":{"addressPrefix":{"type":"string"},"circuitConnectionStatus":{"type":"...` |

### Changes for `Ipv6ExpressRouteCircuitPeeringConfig`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Ipv6ExpressRouteCircuitPeeringConfig__deleted` | deleted | `{"type":"object","properties":{"primaryPeerAddressPrefix":{"type":"string"},"secondaryPeerAddressPre...` |

### Changes for `PatchRouteFilter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PatchRouteFilter__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/RouteFilterPropertiesFormat","x-m...` |

### Changes for `PatchRouteFilterRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PatchRouteFilterRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/RouteFilterRulePropertiesFormat",...` |

### Changes for `PeerExpressRouteCircuitConnection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PeerExpressRouteCircuitConnection__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/PeerExpressRouteCircuitConnection...` |

### Changes for `PeerExpressRouteCircuitConnectionListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PeerExpressRouteCircuitConnectionListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `PeerExpressRouteCircuitConnectionPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PeerExpressRouteCircuitConnectionPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"expressRouteCircuitPeering":{"$ref":"./network.json#/definitions/Sub...` |

### Changes for `RouteFilterPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RouteFilterPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"rules":{"type":"array","items":{"$ref":"#/definitions/RouteFilterRul...` |

### Changes for `RouteFilterRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RouteFilterRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/RouteFilterRulePropertiesFormat",...` |

### Changes for `RouteFilterRuleListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RouteFilterRuleListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `RouteFilterRulePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RouteFilterRulePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"access":{"$ref":"./network.json#/definitions/Access"},"routeFilterRu...` |

### Changes for `ServiceEndpointPolicyDefinition`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceEndpointPolicyDefinition__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ServiceEndpointPolicyDefinitionPr...` |

### Changes for `ServiceEndpointPolicyDefinitionListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceEndpointPolicyDefinitionListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ServiceEndpointPolicyDefinitionPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceEndpointPolicyDefinitionPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"description":{"type":"string"},"service":{"type":"string"},"serviceR...` |

### Changes for `ServiceEndpointPolicyPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceEndpointPolicyPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"serviceEndpointPolicyDefinitions":{"type":"array","items":{"$ref":"#...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteCircuitListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRouteCrossConnectionListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRouteProviderPortListResult.required__added` | added | `["value"]` |
| `definitions.RouteFilter.required__deleted` | deleted | `["location"]` |
| `definitions.RouteFilterListResult.required__added` | added | `["value"]` |
| `definitions.ServiceEndpointPolicyListResult.required__added` | added | `["value"]` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteProviderPort.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteProviderPort.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteProviderPort.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ExpressRouteCircuit.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.ExpressRouteCircuit.properties.properties.$ref` | `#/definitions/ExpressRouteCircuitPropertiesFormat` | `./common.json/definitions/ExpressRouteCircuitPropertiesFormat` |
| `definitions.ExpressRouteCircuit.properties.sku.$ref` | `#/definitions/ExpressRouteCircuitSku` | `./common.json/definitions/ExpressRouteCircuitSku` |
| `definitions.ExpressRouteCrossConnection.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.ExpressRouteCrossConnection.properties.properties.$ref` | `#/definitions/ExpressRouteCrossConnectionProperties` | `./common.json/definitions/ExpressRouteCrossConnectionProperties` |
| `definitions.ExpressRoutePort.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.ExpressRoutePort.properties.identity.$ref` | `./network.json#/definitions/ManagedServiceIdentity` | `./common.json/definitions/ManagedServiceIdentity` |
| `definitions.ExpressRoutePort.properties.properties.$ref` | `#/definitions/ExpressRoutePortPropertiesFormat` | `./common.json/definitions/ExpressRoutePortPropertiesFormat` |
| `definitions.ExpressRouteProviderPort.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/ResourceWithReadOnlyNameAndID` |
| `definitions.ExpressRouteProviderPort.properties.properties.$ref` | `#/definitions/ExpressRouteProviderPortProperties` | `./common.json/definitions/ExpressRouteProviderPortProperties` |
| `definitions.RouteFilter.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/ResourceWithRequiredLocation` |
| `definitions.RouteFilter.properties.properties.$ref` | `#/definitions/RouteFilterPropertiesFormat` | `./common.json/definitions/RouteFilterPropertiesFormat` |
| `definitions.ServiceEndpointPolicy.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.ServiceEndpointPolicy.properties.properties.$ref` | `#/definitions/ServiceEndpointPolicyPropertiesFormat` | `./common.json/definitions/ServiceEndpointPolicyPropertiesFormat` |
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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/stats'].get.responses.200.schema.$ref` | `#/definitions/ExpressRouteCircuitStats` | `./common.json/definitions/ExpressRouteCircuitStats` |
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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/generateLoa'].post.parameters[1].schema.$ref` | `#/definitions/GenerateExpressRoutePortsLOARequest` | `./common.json/definitions/GenerateExpressRoutePortsLOARequest` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/generateLoa'].post.responses.200.schema.$ref` | `#/definitions/GenerateExpressRoutePortsLOAResult` | `./common.json/definitions/GenerateExpressRoutePortsLOAResult` |
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

