## Changed Paths

Path: /subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/allowedConnections
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/discoveredSecuritySolutions
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/externalSecuritySolutions
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/topologies
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceNamespace}/{resourceType}/{resourceName}/providers/microsoft.Security/serverVulnerabilityAssessments
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceNamespace}/{resourceType}/{resourceName}/providers/microsoft.Security/serverVulnerabilityAssessments/{serverVulnerabilityAssessment}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/{resourceType}/serverVulnerabilityAssessments
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/allowedConnections/{connectionType}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/discoveredSecuritySolutions/{discoveredSecuritySolutionName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/externalSecuritySolutions/{externalSecuritySolutionsName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}/{jitNetworkAccessPolicyInitiateType}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/securitySolutions/{securitySolutionName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/topologies/{topologyResourceName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/allowedConnections
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/allowedConnections/{connectionType}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/discoveredSecuritySolutions
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/discoveredSecuritySolutions/{discoveredSecuritySolutionName}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/externalSecuritySolutions
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/externalSecuritySolutions/{externalSecuritySolutionsName}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/jitNetworkAccessPolicies
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}/initiate/initiate
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/securitySolutions/{securitySolutionName}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/topologies
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/topologies/{topologyResourceName}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/serverVulnerabilityAssessments/default/{resourceType}
Change Type: added

## Swagger Changes

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/allowedConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/allowedConnections__deleted']` | deleted | `{"get":{"operationId":"AllowedConnections_ListByHomeRegion","tags":["AllowedConnections"],"descripti...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/discoveredSecuritySolutions`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/discoveredSecuritySolutions__deleted']` | deleted | `{"get":{"operationId":"DiscoveredSecuritySolutions_ListByHomeRegion","tags":["DiscoveredSecuritySolu...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/externalSecuritySolutions`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/externalSecuritySolutions__deleted']` | deleted | `{"get":{"operationId":"ExternalSecuritySolutions_ListByHomeRegion","tags":["ExternalSecuritySolution...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies__deleted']` | deleted | `{"get":{"operationId":"JitNetworkAccessPolicies_ListByRegion","tags":["JitNetworkAccessPolicies"],"d...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/topologies`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/topologies__deleted']` | deleted | `{"get":{"operationId":"Topology_ListByHomeRegion","tags":["Topology"],"description":"Gets a list tha...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceNamespace}/{resourceType}/{resourceName}/providers/microsoft.Security/serverVulnerabilityAssessments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceNamespace}/{resourceType}/{resourceName}/providers/microsoft.Security/serverVulnerabilityAssessments__deleted']` | deleted | `{"get":{"operationId":"ServerVulnerabilityAssessment_ListByExtendedResource","tags":["ServerVulnerab...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceNamespace}/{resourceType}/{resourceName}/providers/microsoft.Security/serverVulnerabilityAssessments/{serverVulnerabilityAssessment}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceNamespace}/{resourceType}/{resourceName}/providers/microsoft.Security/serverVulnerabilityAssessments/{serverVulnerabilityAssessment}__deleted']` | deleted | `{"get":{"operationId":"ServerVulnerabilityAssessment_Get","tags":["ServerVulnerabilityAssessments"],...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/allowedConnections/{connectionType}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/allowedConnections/{connectionType}__deleted']` | deleted | `{"get":{"operationId":"AllowedConnections_Get","tags":["AllowedConnections"],"description":"Gets the...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/discoveredSecuritySolutions/{discoveredSecuritySolutionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/discoveredSecuritySolutions/{discoveredSecuritySolutionName}__deleted']` | deleted | `{"get":{"operationId":"DiscoveredSecuritySolutions_Get","tags":["DiscoveredSecuritySolutions"],"desc...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/externalSecuritySolutions/{externalSecuritySolutionsName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/externalSecuritySolutions/{externalSecuritySolutionsName}__deleted']` | deleted | `{"get":{"operationId":"ExternalSecuritySolutions_Get","tags":["ExternalSecuritySolutions"],"descript...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies__deleted']` | deleted | `{"get":{"operationId":"JitNetworkAccessPolicies_ListByResourceGroupAndRegion","tags":["JitNetworkAcc...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}__deleted']` | deleted | `{"get":{"operationId":"JitNetworkAccessPolicies_Get","tags":["JitNetworkAccessPolicies"],"descriptio...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}/{jitNetworkAccessPolicyInitiateType}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}/{jitNetworkAccessPolicyInitiateType}__deleted']` | deleted | `{"post":{"operationId":"JitNetworkAccessPolicies_Initiate","tags":["JitNetworkAccessPolicies"],"desc...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/securitySolutions/{securitySolutionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/securitySolutions/{securitySolutionName}__deleted']` | deleted | `{"get":{"operationId":"SecuritySolutions_Get","tags":["SecuritySolutions"],"description":"Gets a spe...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/topologies/{topologyResourceName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/topologies/{topologyResourceName}__deleted']` | deleted | `{"get":{"operationId":"Topology_Get","tags":["Topology"],"description":"Gets a specific topology com...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/{resourceType}/serverVulnerabilityAssessments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/{resourceType}/serverVulnerabilityAssessments__added']` | added | `{"get":{"operationId":"ServerVulnerabilityAssessment_ListByExtendedResource","tags":["ServerVulnerab...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/allowedConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/allowedConnections__added']` | added | `{"get":{"operationId":"AllowedConnections_ListByHomeRegion","tags":["AllowedConnectionsResources"],"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/allowedConnections/{connectionType}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/allowedConnections/{connectionType}__added']` | added | `{"get":{"operationId":"AllowedConnections_Get","tags":["AllowedConnectionsResources"],"description":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/discoveredSecuritySolutions`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/discoveredSecuritySolutions__added']` | added | `{"get":{"operationId":"DiscoveredSecuritySolutions_ListByResourceGroupLocationResource","tags":["Dis...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/discoveredSecuritySolutions/{discoveredSecuritySolutionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/discoveredSecuritySolutions/{discoveredSecuritySolutionName}__added']` | added | `{"get":{"operationId":"DiscoveredSecuritySolutions_Get","tags":["DiscoveredSecuritySolutions"],"desc...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/externalSecuritySolutions`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/externalSecuritySolutions__added']` | added | `{"get":{"operationId":"ExternalSecuritySolutions_ListByResourceGroupLocationResource","tags":["Exter...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/externalSecuritySolutions/{externalSecuritySolutionsName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/externalSecuritySolutions/{externalSecuritySolutionsName}__added']` | added | `{"get":{"operationId":"ExternalSecuritySolutions_Get","tags":["ExternalSecuritySolutions"],"descript...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/jitNetworkAccessPolicies`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/jitNetworkAccessPolicies__added']` | added | `{"get":{"operationId":"JitNetworkAccessPolicies_ListByResourceGroupAndRegion","tags":["JitNetworkAcc...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}__added']` | added | `{"get":{"operationId":"JitNetworkAccessPolicies_Get","tags":["JitNetworkAccessPolicies"],"descriptio...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}/initiate/initiate`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}/initiate/initiate__added']` | added | `{"post":{"operationId":"JitNetworkAccessPolicies_Initiate","tags":["JitNetworkAccessPolicies"],"desc...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/securitySolutions/{securitySolutionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/securitySolutions/{securitySolutionName}__added']` | added | `{"get":{"operationId":"SecuritySolutions_Get","tags":["SecuritySolutions"],"description":"Gets a spe...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/topologies`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/topologies__added']` | added | `{"get":{"operationId":"Topology_ListByHomeRegion","tags":["TopologyResources"],"description":"Gets a...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/topologies/{topologyResourceName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{location}/topologies/{topologyResourceName}__added']` | added | `{"get":{"operationId":"Topology_Get","tags":["TopologyResources"],"description":"Gets a specific top...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/serverVulnerabilityAssessments/default/{resourceType}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/serverVulnerabilityAssessments/default/{resourceType}__added']` | added | `{"get":{"operationId":"ServerVulnerabilityAssessment_Get","tags":["ServerVulnerabilityAssessments"],...` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/allowedConnections'].get.tags__deleted` | deleted | `["AllowedConnections"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/discoveredSecuritySolutions'].get.tags__deleted` | deleted | `["DiscoveredSecuritySolutions"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/externalSecuritySolutions'].get.tags__deleted` | deleted | `["ExternalSecuritySolutions"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/jitNetworkAccessPolicies'].get.tags__deleted` | deleted | `["JitNetworkAccessPolicies"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/securitySolutionsReferenceData'].get.tags__deleted` | deleted | `["SecuritySolutionsReferenceData"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/securitySolutions'].get.tags__deleted` | deleted | `["SecuritySolutions"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/securitySolutionsReferenceData'].get.tags__deleted` | deleted | `["securitySolutionsReferenceData"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/topologies'].get.tags__deleted` | deleted | `["Topology"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/jitNetworkAccessPolicies'].get.tags__deleted` | deleted | `["JitNetworkAccessPolicies"]` |

### Changes for `x-ms-pageable`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/allowedConnections'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/discoveredSecuritySolutions'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/externalSecuritySolutions'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/jitNetworkAccessPolicies'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/securitySolutions'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/topologies'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/jitNetworkAccessPolicies'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/securitySolutionsReferenceData'].get.parameters[0].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/AscLocation` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/securitySolutionsReferenceData'].get.parameters[0].name__added` | added | `ascLocation` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/securitySolutionsReferenceData'].get.parameters[0].in__added` | added | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AllowedConnectionsList.required__added` | added | `["value"]` |
| `definitions.DiscoveredSecuritySolutionList.required__added` | added | `["value"]` |
| `definitions.ExternalSecuritySolution.required__deleted` | deleted | `["kind"]` |
| `definitions.ExternalSecuritySolutionList.required__added` | added | `["value"]` |
| `definitions.JitNetworkAccessPoliciesList.required__added` | added | `["value"]` |
| `definitions.SecuritySolutionList.required__added` | added | `["value"]` |
| `definitions.TopologyList.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/securitySolutionsReferenceData'].get.parameters[0].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/securitySolutionsReferenceData'].get.parameters[0].type__added` | added | `string` |

### Changes for `AadConnectivityState`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AadConnectivityState__deleted` | deleted | `{"type":"object","description":"Describes an Azure resource with kind","properties":{"connectivitySt...` |

### Changes for `ExternalSecuritySolutionKind`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExternalSecuritySolutionKind__deleted` | deleted | `{"type":"object","description":"Describes an Azure resource with kind","properties":{"kind":{"type":...` |

### Changes for `PortNumber`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PortNumber__deleted` | deleted | `{"type":"integer","minimum":0,"maximum":65535}` |

### Changes for `securitySolutionsReferenceData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.securitySolutionsReferenceData__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/securitySolutionsReferenceDataPro...` |

### Changes for `securitySolutionsReferenceDataList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.securitySolutionsReferenceDataList__deleted` | deleted | `{"type":"object","properties":{"value":{"type":"array","items":{"$ref":"#/definitions/securitySoluti...` |

### Changes for `securitySolutionsReferenceDataProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.securitySolutionsReferenceDataProperties__deleted` | deleted | `{"type":"object","properties":{"securityFamily":{"type":"string","description":"The security family ...` |

### Changes for `SecuritySolutionsReferenceData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecuritySolutionsReferenceData__added` | added | `{"type":"object","properties":{"id":{"type":"string","description":"Resource Id","readOnly":true},"n...` |

### Changes for `SecuritySolutionsReferenceDataList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecuritySolutionsReferenceDataList__added` | added | `{"type":"object","properties":{"value":{"type":"array","items":{"$ref":"#/definitions/SecuritySoluti...` |

### Changes for `SecuritySolutionsReferenceDataProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecuritySolutionsReferenceDataProperties__added` | added | `{"type":"object","properties":{"securityFamily":{"type":"string","description":"The security family ...` |

### Changes for `x-ms-discriminator-value`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AadExternalSecuritySolution['x-ms-discriminator-value__deleted']` | deleted | `AAD` |
| `definitions.AtaExternalSecuritySolution['x-ms-discriminator-value__deleted']` | deleted | `ATA` |
| `definitions.CefExternalSecuritySolution['x-ms-discriminator-value__deleted']` | deleted | `CEF` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AadExternalSecuritySolution.properties.properties.description__added` | added | `The external security solution properties for AAD solutions` |
| `definitions.AadSolutionProperties.description__added` | added | `The external security solution properties for AAD solutions` |
| `definitions.AllowedConnectionsResource.properties.properties.description__added` | added | `Describes the allowed traffic between Azure resources` |
| `definitions.AtaExternalSecuritySolution.properties.properties.description__added` | added | `The external security solution properties for ATA solutions` |
| `definitions.AtaSolutionProperties.description__added` | added | `The external security solution properties for ATA solutions` |
| `definitions.CefExternalSecuritySolution.properties.properties.description__added` | added | `The external security solution properties for CEF solutions` |
| `definitions.CefSolutionProperties.description__added` | added | `The external security solution properties for CEF solutions` |
| `definitions.ConnectedWorkspace.description__added` | added | `Represents an OMS workspace to which the solution is connected` |
| `definitions.DiscoveredSecuritySolution.description__added` | added | `Concrete proxy resource types can be created by aliasing this type using a specific property type.` |
| `definitions.ExternalSecuritySolutionProperties.properties.workspace.description__added` | added | `Represents an OMS workspace to which the solution is connected` |
| `definitions.JitNetworkAccessPolicy.description__added` | added | `Concrete proxy resource types can be created by aliasing this type using a specific property type.` |
| `definitions.JitNetworkAccessPortRule.properties.allowedSourceAddressPrefixes.items.description__deleted` | deleted | `IP address or CIDR, for example "192.168.0.3" or "192.168.0.0/16".` |
| `definitions.JitNetworkAccessRequestPort.properties.allowedSourceAddressPrefixes.items.description__deleted` | deleted | `IP address or CIDR, for example "192.168.0.3" or "192.168.0.0/16".` |
| `definitions.SecuritySolution.description__added` | added | `Concrete proxy resource types can be created by aliasing this type using a specific property type.` |
| `definitions.ServerVulnerabilityAssessment.properties.properties.description__added` | added | `describes ServerVulnerabilityAssessment properties.` |
| `definitions.TopologyResource.description__added` | added | `Concrete proxy resource types can be created by aliasing this type using a specific property type.` |

### Changes for `title`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AadSolutionProperties.title__deleted` | deleted | `The external security solution properties for AAD solutions` |
| `definitions.AtaSolutionProperties.title__deleted` | deleted | `The external security solution properties for ATA solutions` |
| `definitions.CefSolutionProperties.title__deleted` | deleted | `The external security solution properties for CEF solutions` |
| `definitions.ConnectedWorkspace.title__deleted` | deleted | `Represents an OMS workspace to which the solution is connected` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AadSolutionProperties.allOf__deleted` | deleted | `[{"$ref":"#/definitions/ExternalSecuritySolutionProperties"},{"$ref":"#/definitions/AadConnectivityS...` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AadSolutionProperties.properties__added` | added | `{"deviceVendor":{"type":"string"},"deviceType":{"type":"string"},"workspace":{"$ref":"#/definitions/...` |
| `definitions.ExternalSecuritySolution.properties.properties__added` | added | `{"type":"object","description":"The resource-specific properties for this resource."}` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AadSolutionProperties.additionalProperties__added` | added | `{}` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AllowedConnectionsList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.AllowedConnectionsResource.properties.properties.readOnly__deleted` | deleted | `true` |
| `definitions.TopologyList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.TopologyResource.properties.properties.readOnly__deleted` | deleted | `true` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AllowedConnectionsResource.properties.location__added` | added | `{"type":"string","description":"Location where the resource is stored","readOnly":true}` |
| `definitions.DiscoveredSecuritySolution.properties.location__added` | added | `{"type":"string","description":"Location where the resource is stored","readOnly":true}` |
| `definitions.ExternalSecuritySolution.properties.location__added` | added | `{"type":"string","description":"Location where the resource is stored","readOnly":true}` |
| `definitions.JitNetworkAccessPolicy.properties.location__added` | added | `{"type":"string","description":"Location where the resource is stored","readOnly":true}` |
| `definitions.SecuritySolution.properties.location__added` | added | `{"type":"string","description":"Location where the resource is stored","readOnly":true}` |
| `definitions.TopologyResource.properties.location__added` | added | `{"type":"string","description":"Location where the resource is stored","readOnly":true}` |

### Changes for `discriminator`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExternalSecuritySolution.discriminator__deleted` | deleted | `kind` |

### Changes for `kind`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExternalSecuritySolution.properties.kind__added` | added | `{"type":"string","description":"The kind of the external solution","enum":["CEF","ATA","AAD"],"x-ms-...` |
| `definitions.JitNetworkAccessPolicy.properties.kind__added` | added | `{"type":"string","description":"Kind of the resource"}` |

### Changes for `minimum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JitNetworkAccessPolicyInitiatePort.properties.number.minimum__deleted` | deleted | `0` |
| `definitions.JitNetworkAccessPortRule.properties.number.minimum__deleted` | deleted | `0` |
| `definitions.JitNetworkAccessRequestPort.properties.number.minimum__deleted` | deleted | `0` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JitNetworkAccessPolicyInitiatePort.properties.number.format__added` | added | `int32` |
| `definitions.JitNetworkAccessPortRule.properties.number.format__added` | added | `int32` |
| `definitions.JitNetworkAccessRequestPort.properties.mappedPort.format__added` | added | `int32` |
| `definitions.JitNetworkAccessRequestPort.properties.number.format__added` | added | `int32` |
| `definitions.TopologySingleResource.properties.topologyScore.format__added` | added | `int32` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerVulnerabilityAssessmentProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ServerVulnerabilityAssessmentPropertiesProvisioningState","modelAsString":true}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AllowedConnectionsResource.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.DiscoveredSecuritySolution.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ExternalSecuritySolution.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ExternalSecuritySolutionProperties.additionalProperties` | `true` | `{}` |
| `definitions.JitNetworkAccessPolicy.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.SecuritySolution.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.SecuritySolutionProperties.properties.securityFamily.description` | `The security family of the security solution` | `The security family of the discovered solution` |
| `definitions.ServerVulnerabilityAssessment.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.TopologyResource.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `info.description` | `API spec for Microsoft.Security (Microsoft Defender for Cloud) resource provider` | `API spec for Microsoft.Security (Azure Security Center) resource provider` |
| `info.title` | `Microsoft Defender for Cloud` | `SecurityCenter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/allowedConnections'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/discoveredSecuritySolutions'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/externalSecuritySolutions'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/jitNetworkAccessPolicies'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/securitySolutionsReferenceData'].get.responses.200.schema.$ref` | `#/definitions/securitySolutionsReferenceDataList` | `#/definitions/SecuritySolutionsReferenceDataList` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/securitySolutionsReferenceData'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/securitySolutions'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/securitySolutionsReferenceData'].get.responses.200.schema.$ref` | `#/definitions/securitySolutionsReferenceDataList` | `#/definitions/SecuritySolutionsReferenceDataList` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/securitySolutionsReferenceData'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/topologies'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/jitNetworkAccessPolicies'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

