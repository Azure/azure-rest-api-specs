## Swagger Changes

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/securitySolutionsReferenceData'].get.parameters[0].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/AscLocation` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.securitySolutionsReferenceData.properties.name__added` | added | `{"type":"string","description":"Resource name","readOnly":true}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/securitySolutionsReferenceData'].get.parameters[0].name__added` | added | `ascLocation` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/securitySolutionsReferenceData'].get.parameters[0].in__added` | added | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/securitySolutionsReferenceData'].get.parameters[0].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.securitySolutionsReferenceData.properties.type__added` | added | `{"type":"string","description":"Resource type","readOnly":true}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/securitySolutionsReferenceData'].get.parameters[0].type__added` | added | `string` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceNamespace}/{resourceType}/{resourceName}/providers/microsoft.Security/serverVulnerabilityAssessments/{serverVulnerabilityAssessment}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |

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

### Changes for `CloudError`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudError__added` | added | `{"type":"object","description":"Common error response for all Azure Resource Manager APIs to return ...` |

### Changes for `CloudErrorBody`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudErrorBody__added` | added | `{"type":"object","description":"The error detail.","properties":{"code":{"type":"string","descriptio...` |

### Changes for `ErrorAdditionalInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorAdditionalInfo__added` | added | `{"type":"object","description":"The resource management error additional info.","properties":{"type"...` |

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
| `definitions.securitySolutionsReferenceData.allOf__deleted` | deleted | `[{"$ref":"./common/v1/types.json#/definitions/Resource"},{"$ref":"./common/v1/types.json#/definition...` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AadSolutionProperties.properties__added` | added | `{"deviceVendor":{"type":"string"},"deviceType":{"type":"string"},"workspace":{"$ref":"#/definitions/...` |
| `definitions.ExternalSecuritySolution.properties.properties__added` | added | `{"type":"object","description":"The resource-specific properties for this resource."}` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AadSolutionProperties.additionalProperties__added` | added | `{}` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AllowedConnectionsResource.properties.location__added` | added | `{"type":"string","description":"Location where the resource is stored","readOnly":true}` |
| `definitions.DiscoveredSecuritySolution.properties.location__added` | added | `{"type":"string","description":"Location where the resource is stored","readOnly":true}` |
| `definitions.ExternalSecuritySolution.properties.location__added` | added | `{"type":"string","description":"Location where the resource is stored","readOnly":true}` |
| `definitions.JitNetworkAccessPolicy.properties.location__added` | added | `{"type":"string","description":"Location where the resource is stored","readOnly":true}` |
| `definitions.SecuritySolution.properties.location__added` | added | `{"type":"string","description":"Location where the resource is stored","readOnly":true}` |
| `definitions.securitySolutionsReferenceData.properties.location__added` | added | `{"type":"string","description":"Location where the resource is stored","readOnly":true}` |
| `definitions.TopologyResource.properties.location__added` | added | `{"type":"string","description":"Location where the resource is stored","readOnly":true}` |

### Changes for `kind`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExternalSecuritySolution.properties.kind__added` | added | `{"type":"string","description":"The kind of the external solution","enum":["CEF","ATA","AAD"],"x-ms-...` |
| `definitions.JitNetworkAccessPolicy.properties.kind__added` | added | `{"type":"string","description":"Kind of the resource"}` |

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

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.securitySolutionsReferenceData.properties.id__added` | added | `{"type":"string","description":"Resource Id","readOnly":true}` |

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
| `definitions.securitySolutionsReferenceDataProperties.properties.securityFamily.description` | `The security family of the security solution` | `The security family of the discovered solution` |
| `definitions.ServerVulnerabilityAssessment.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.TopologyResource.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/allowedConnections'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/discoveredSecuritySolutions'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/externalSecuritySolutions'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/jitNetworkAccessPolicies'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/allowedConnections'].get.parameters[0].$ref` | `./common/v1/types.json#/parameters/AscLocation` | `../../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/allowedConnections'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/discoveredSecuritySolutions'].get.parameters[0].$ref` | `./common/v1/types.json#/parameters/AscLocation` | `../../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/discoveredSecuritySolutions'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/externalSecuritySolutions'].get.parameters[0].$ref` | `./common/v1/types.json#/parameters/AscLocation` | `../../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/externalSecuritySolutions'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies'].get.parameters[0].$ref` | `./common/v1/types.json#/parameters/AscLocation` | `../../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/securitySolutionsReferenceData'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/topologies'].get.parameters[0].$ref` | `./common/v1/types.json#/parameters/AscLocation` | `../../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/topologies'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/securitySolutions'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/securitySolutionsReferenceData'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/topologies'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceNamespace}/{resourceType}/{resourceName}/providers/microsoft.Security/serverVulnerabilityAssessments'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceNamespace}/{resourceType}/{resourceName}/providers/microsoft.Security/serverVulnerabilityAssessments/{serverVulnerabilityAssessment}'].delete.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceNamespace}/{resourceType}/{resourceName}/providers/microsoft.Security/serverVulnerabilityAssessments/{serverVulnerabilityAssessment}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceNamespace}/{resourceType}/{resourceName}/providers/microsoft.Security/serverVulnerabilityAssessments/{serverVulnerabilityAssessment}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/jitNetworkAccessPolicies'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/allowedConnections/{connectionType}'].get.parameters[0].$ref` | `./common/v1/types.json#/parameters/AscLocation` | `../../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/allowedConnections/{connectionType}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/discoveredSecuritySolutions/{discoveredSecuritySolutionName}'].get.parameters[0].$ref` | `./common/v1/types.json#/parameters/AscLocation` | `../../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/discoveredSecuritySolutions/{discoveredSecuritySolutionName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/externalSecuritySolutions/{externalSecuritySolutionsName}'].get.parameters[0].$ref` | `./common/v1/types.json#/parameters/AscLocation` | `../../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/externalSecuritySolutions/{externalSecuritySolutionsName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies'].get.parameters[0].$ref` | `./common/v1/types.json#/parameters/AscLocation` | `../../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}'].delete.parameters[0].$ref` | `./common/v1/types.json#/parameters/AscLocation` | `../../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}'].delete.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}'].get.parameters[0].$ref` | `./common/v1/types.json#/parameters/AscLocation` | `../../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}'].put.parameters[0].$ref` | `./common/v1/types.json#/parameters/AscLocation` | `../../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}/{jitNetworkAccessPolicyInitiateType}'].post.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/securitySolutions/{securitySolutionName}'].get.parameters[0].$ref` | `./common/v1/types.json#/parameters/AscLocation` | `../../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/securitySolutions/{securitySolutionName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/topologies/{topologyResourceName}'].get.parameters[0].$ref` | `./common/v1/types.json#/parameters/AscLocation` | `../../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/topologies/{topologyResourceName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |

