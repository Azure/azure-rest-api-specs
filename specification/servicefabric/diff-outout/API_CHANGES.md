## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationResource.properties.tags__added` | added | `{"type":"object","description":"Azure resource tags.","additionalProperties":{"type":"string"},"x-ms...` |
| `definitions.ApplicationTypeResource.properties.tags__added` | added | `{"type":"object","description":"Azure resource tags.","additionalProperties":{"type":"string"},"x-ms...` |
| `definitions.ApplicationTypeVersionResource.properties.tags__added` | added | `{"type":"object","description":"Azure resource tags.","additionalProperties":{"type":"string"},"x-ms...` |
| `definitions.ServiceResource.properties.tags__added` | added | `{"type":"object","description":"Azure resource tags.","additionalProperties":{"type":"string"},"x-ms...` |
| `tags__added` | added | `[{"name":"Operations"},{"name":"Cluster"},{"name":"ListUpgradableVersions"},{"name":"VMSizes"},{"nam...` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VMSizeResource.properties.name__deleted` | deleted | `{"type":"string","description":"VM Size name.","readOnly":true}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/clusterVersions'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/clusterVersions/{clusterVersion}'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/environments/{environment}/clusterVersions'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/environments/{environment}/clusterVersions/{clusterVersion}'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/unsupportedVmSizes/{vmSize}'].get.parameters[0].name__deleted` | deleted | `location` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/clusterVersions'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/clusterVersions/{clusterVersion}'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/environments/{environment}/clusterVersions'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/environments/{environment}/clusterVersions/{clusterVersion}'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/unsupportedVmSizes/{vmSize}'].get.parameters[0].in__deleted` | deleted | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationResourceList.required__added` | added | `["value"]` |
| `definitions.ApplicationTypeResourceList.required__added` | added | `["value"]` |
| `definitions.ApplicationTypeVersionResourceList.required__added` | added | `["value"]` |
| `definitions.ClusterCodeVersionsListResult.required__added` | added | `["value"]` |
| `definitions.ClusterListResult.required__added` | added | `["value"]` |
| `definitions.ServiceResourceList.required__added` | added | `["value"]` |
| `definitions.ServiceResourceUpdate.required__added` | added | `["properties"]` |
| `definitions.VMSizesResult.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/clusterVersions'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/clusterVersions/{clusterVersion}'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/environments/{environment}/clusterVersions'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/environments/{environment}/clusterVersions/{clusterVersion}'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/unsupportedVmSizes/{vmSize}'].get.parameters[0].required__deleted` | deleted | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationDeltaHealthPolicy.properties.serviceTypeDeltaHealthPolicies.type__added` | added | `object` |
| `definitions.ApplicationHealthPolicy.properties.serviceTypeHealthPolicies.type__added` | added | `object` |
| `definitions.ApplicationResourceUpdateProperties.properties.metrics.type__added` | added | `array` |
| `definitions.ApplicationResourceUpdateProperties.properties.parameters.type__added` | added | `object` |
| `definitions.ApplicationTypeVersionResourceProperties.properties.defaultParameterList.type__added` | added | `object` |
| `definitions.ArmApplicationHealthPolicy.properties.serviceTypeHealthPolicyMap.type__added` | added | `object` |
| `definitions.ClusterHealthPolicy.properties.applicationHealthPolicies.type__added` | added | `object` |
| `definitions.ClusterUpgradeDeltaHealthPolicy.properties.applicationDeltaHealthPolicies.type__added` | added | `object` |
| `definitions.ServiceResourcePropertiesBase.properties.correlationScheme.type__added` | added | `array` |
| `definitions.ServiceResourcePropertiesBase.properties.serviceLoadMetrics.type__added` | added | `array` |
| `definitions.ServiceResourcePropertiesBase.properties.servicePlacementPolicies.type__added` | added | `array` |
| `definitions.SingletonPartitionSchemeDescription.type__added` | added | `object` |
| `definitions.VMSizeResource.properties.type__deleted` | deleted | `{"type":"string","description":"VM Size type.","readOnly":true}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/clusterVersions'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/clusterVersions/{clusterVersion}'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/environments/{environment}/clusterVersions'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/environments/{environment}/clusterVersions/{clusterVersion}'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/unsupportedVmSizes/{vmSize}'].get.parameters[0].type__deleted` | deleted | `string` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationDeltaHealthPolicy.properties.serviceTypeDeltaHealthPolicies.$ref__deleted` | deleted | `#/definitions/ServiceTypeDeltaHealthPolicyMap` |
| `definitions.ApplicationHealthPolicy.properties.serviceTypeHealthPolicies.$ref__deleted` | deleted | `#/definitions/ServiceTypeHealthPolicyMap` |
| `definitions.ApplicationResourceUpdateProperties.properties.metrics.$ref__deleted` | deleted | `#/definitions/ApplicationMetricDescriptionList` |
| `definitions.ApplicationResourceUpdateProperties.properties.parameters.$ref__deleted` | deleted | `#/definitions/ApplicationParameterList` |
| `definitions.ApplicationTypeVersionResourceProperties.properties.defaultParameterList.$ref__deleted` | deleted | `#/definitions/ApplicationTypeParameterList` |
| `definitions.ArmApplicationHealthPolicy.properties.serviceTypeHealthPolicyMap.$ref__deleted` | deleted | `#/definitions/ArmServiceTypeHealthPolicyMap` |
| `definitions.ClusterHealthPolicy.properties.applicationHealthPolicies.$ref__deleted` | deleted | `#/definitions/ApplicationHealthPolicyMap` |
| `definitions.ClusterUpgradeDeltaHealthPolicy.properties.applicationDeltaHealthPolicies.$ref__deleted` | deleted | `#/definitions/ApplicationDeltaHealthPolicyMap` |
| `definitions.ServiceResourcePropertiesBase.properties.correlationScheme.$ref__deleted` | deleted | `#/definitions/CorrelationSchemeList` |
| `definitions.ServiceResourcePropertiesBase.properties.serviceLoadMetrics.$ref__deleted` | deleted | `#/definitions/ServiceLoadMetricsList` |
| `definitions.ServiceResourcePropertiesBase.properties.servicePlacementPolicies.$ref__deleted` | deleted | `#/definitions/ServicePlacementPoliciesList` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/clusterVersions'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/clusterVersions/{clusterVersion}'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/environments/{environment}/clusterVersions'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/environments/{environment}/clusterVersions/{clusterVersion}'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ServiceFabric/locations/{location}/unsupportedVmSizes/{vmSize}'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ServiceFabric/clusters/{clusterName}'].patch.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ServiceFabric/clusters/{clusterName}'].put.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","format":"uri","description":"A link to the status monitor"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ServiceFabric/clusters/{clusterName}/applications/{applicationName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ServiceFabric/clusters/{clusterName}/applications/{applicationName}'].patch.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ServiceFabric/clusters/{clusterName}/applications/{applicationName}'].put.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","format":"uri","description":"A link to the status monitor"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ServiceFabric/clusters/{clusterName}/applications/{applicationName}/services/{serviceName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ServiceFabric/clusters/{clusterName}/applications/{applicationName}/services/{serviceName}'].patch.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ServiceFabric/clusters/{clusterName}/applications/{applicationName}/services/{serviceName}'].put.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","format":"uri","description":"A link to the status monitor"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ServiceFabric/clusters/{clusterName}/applicationTypes/{applicationTypeName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ServiceFabric/clusters/{clusterName}/applicationTypes/{applicationTypeName}/versions/{version}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ServiceFabric/clusters/{clusterName}/applicationTypes/{applicationTypeName}/versions/{version}'].put.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","format":"uri","description":"A link to the status monitor"...` |

### Changes for `ApplicationDeltaHealthPolicyMap`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationDeltaHealthPolicyMap__deleted` | deleted | `{"type":"object","description":"Defines a map that contains specific application delta health polici...` |

### Changes for `ApplicationHealthPolicyMap`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationHealthPolicyMap__deleted` | deleted | `{"type":"object","description":"Defines a map that contains specific application health policies for...` |

### Changes for `ApplicationMetricDescriptionList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationMetricDescriptionList__deleted` | deleted | `{"type":"array","description":"List of application capacity metric description.","items":{"$ref":"#/...` |

### Changes for `ApplicationParameterList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationParameterList__deleted` | deleted | `{"type":"object","description":"List of application parameters with overridden values from their def...` |

### Changes for `ApplicationTypeName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationTypeName__deleted` | deleted | `{"type":"string","description":"The application type name as defined in the application manifest."}` |

### Changes for `ApplicationTypeParameterList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationTypeParameterList__deleted` | deleted | `{"type":"object","description":"List of application type parameters that can be overridden when crea...` |

### Changes for `ApplicationTypeVersion`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationTypeVersion__deleted` | deleted | `{"type":"string","description":"The version of the application type as defined in the application ma...` |

### Changes for `ArmServiceTypeHealthPolicyMap`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArmServiceTypeHealthPolicyMap__deleted` | deleted | `{"type":"object","description":"Defines a ServiceTypeHealthPolicy per service type name.\\n\\nThe entr...` |

### Changes for `CorrelationSchemeList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CorrelationSchemeList__deleted` | deleted | `{"type":"array","description":"A list that describes the correlation of the service with other servi...` |

### Changes for `ForceRestart`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ForceRestart__deleted` | deleted | `{"type":"boolean","description":"If true, then processes are forcefully restarted during upgrade eve...` |

### Changes for `HealthCheckRetryTimeout`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HealthCheckRetryTimeout__deleted` | deleted | `{"type":"string","description":"The amount of time to retry health evaluation when the application o...` |

### Changes for `HealthCheckStableDuration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HealthCheckStableDuration__deleted` | deleted | `{"type":"string","description":"The amount of time that the application or cluster must remain healt...` |

### Changes for `HealthCheckWaitDuration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HealthCheckWaitDuration__deleted` | deleted | `{"type":"string","description":"The amount of time to wait after completing an upgrade domain before...` |

### Changes for `ManagedIdentity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedIdentity__deleted` | deleted | `{"type":"object","description":"Describes the managed identities for an Azure resource.","properties...` |

### Changes for `Resource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Resource__deleted` | deleted | `{"type":"object","description":"The resource model definition.","properties":{"id":{"type":"string",...` |

### Changes for `ServiceLoadMetricsList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceLoadMetricsList__deleted` | deleted | `{"type":"array","description":"The service load metrics is given as an array of ServiceLoadMetricDes...` |

### Changes for `ServiceName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceName__deleted` | deleted | `{"type":"string","description":"The full name of the service with 'fabric:' URI scheme."}` |

### Changes for `ServicePlacementPoliciesList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServicePlacementPoliciesList__deleted` | deleted | `{"type":"array","description":"A list that describes the correlation of the service with other servi...` |

### Changes for `ServiceTypeDeltaHealthPolicyMap`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceTypeDeltaHealthPolicyMap__deleted` | deleted | `{"type":"object","description":"Defines a map that contains specific delta health policies for diffe...` |

### Changes for `ServiceTypeHealthPolicyMap`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceTypeHealthPolicyMap__deleted` | deleted | `{"type":"object","description":"Defines a ServiceTypeHealthPolicy per service type name.\\n\\nThe entr...` |

### Changes for `SystemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SystemData__deleted` | deleted | `{"type":"object","description":"Metadata pertaining to creation and last modification of the resourc...` |

### Changes for `UpgradeDomainTimeout`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpgradeDomainTimeout__deleted` | deleted | `{"type":"string","description":"The amount of time each upgrade domain has to complete before Failur...` |

### Changes for `UpgradeTimeout`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpgradeTimeout__deleted` | deleted | `{"type":"string","description":"The amount of time the overall upgrade has to complete before Failur...` |

### Changes for `UserAssignedIdentity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UserAssignedIdentity__deleted` | deleted | `{"type":"object","properties":{"principalId":{"type":"string","description":"The principal id of use...` |

### Changes for `UserAssignedIdentityMap`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UserAssignedIdentityMap__deleted` | deleted | `{"type":"object","description":"The list of user identities associated with the resource. The user i...` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationDeltaHealthPolicy.properties.serviceTypeDeltaHealthPolicies.additionalProperties__added` | added | `{"$ref":"#/definitions/ServiceTypeDeltaHealthPolicy"}` |
| `definitions.ApplicationHealthPolicy.properties.serviceTypeHealthPolicies.additionalProperties__added` | added | `{"$ref":"#/definitions/ServiceTypeHealthPolicy"}` |
| `definitions.ApplicationResourceUpdateProperties.properties.parameters.additionalProperties__added` | added | `{"type":"string"}` |
| `definitions.ApplicationTypeVersionResourceProperties.properties.defaultParameterList.additionalProperties__added` | added | `{"type":"string"}` |
| `definitions.ArmApplicationHealthPolicy.properties.serviceTypeHealthPolicyMap.additionalProperties__added` | added | `{"$ref":"#/definitions/ArmServiceTypeHealthPolicy"}` |
| `definitions.ClusterHealthPolicy.properties.applicationHealthPolicies.additionalProperties__added` | added | `{"$ref":"#/definitions/ApplicationHealthPolicy"}` |
| `definitions.ClusterUpgradeDeltaHealthPolicy.properties.applicationDeltaHealthPolicies.additionalProperties__added` | added | `{"$ref":"#/definitions/ApplicationDeltaHealthPolicy"}` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationResource.properties.location__added` | added | `{"type":"string","description":"It will be deprecated in New API, resource location depends on the p...` |
| `definitions.ApplicationTypeResource.properties.location__added` | added | `{"type":"string","description":"It will be deprecated in New API, resource location depends on the p...` |
| `definitions.ApplicationTypeVersionResource.properties.location__added` | added | `{"type":"string","description":"It will be deprecated in New API, resource location depends on the p...` |
| `definitions.ServiceResource.properties.location__added` | added | `{"type":"string","description":"It will be deprecated in New API, resource location depends on the p...` |

### Changes for `etag`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationResource.properties.etag__added` | added | `{"type":"string","description":"Azure resource etag.","readOnly":true}` |
| `definitions.ApplicationTypeResource.properties.etag__added` | added | `{"type":"string","description":"Azure resource etag.","readOnly":true}` |
| `definitions.ApplicationTypeVersionResource.properties.etag__added` | added | `{"type":"string","description":"Azure resource etag.","readOnly":true}` |
| `definitions.Cluster.properties.etag__added` | added | `{"type":"string","description":"Azure resource etag.","readOnly":true}` |
| `definitions.ServiceResource.properties.etag__added` | added | `{"type":"string","description":"Azure resource etag.","readOnly":true}` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationResource.properties.identity.description__added` | added | `The managed service identities assigned to this resource.` |
| `definitions.ApplicationResource.properties.properties.description__added` | added | `The application resource properties.` |
| `definitions.ApplicationResourceUpdate.properties.properties.description__added` | added | `The application resource properties for patch operations.` |
| `definitions.ApplicationResourceUpdateProperties.properties.metrics.description__added` | added | `List of application capacity metric description.` |
| `definitions.ApplicationResourceUpdateProperties.properties.parameters.description__added` | added | `List of application parameters with overridden values from their default values specified in the application manifest.` |
| `definitions.ApplicationResourceUpdateProperties.properties.upgradePolicy.description__added` | added | `Describes the policy for a monitored application upgrade.` |
| `definitions.ApplicationTypeResource.properties.properties.description__added` | added | `The application type name properties` |
| `definitions.ApplicationTypeVersionResource.properties.properties.description__added` | added | `The properties of the application type version resource.` |
| `definitions.ApplicationTypeVersionResourceProperties.properties.defaultParameterList.description__added` | added | `List of application type parameters that can be overridden when creating or updating the application.` |
| `definitions.ApplicationTypeVersionsCleanupPolicy.description__added` | added | `The policy used to clean up unused versions.` |
| `definitions.ApplicationUpgradePolicy.properties.applicationHealthPolicy.description__added` | added | `Defines a health policy used to evaluate the health of an application or one of its children entities.` |
| `definitions.ApplicationUpgradePolicy.properties.rollingUpgradeMonitoringPolicy.description__added` | added | `The policy used for monitoring the application upgrade` |
| `definitions.ApplicationUserAssignedIdentity.description__added` | added | `Describes a user assigned identity for the application.` |
| `definitions.ClusterCodeVersionsResult.properties.properties.description__added` | added | `The detail of the Service Fabric runtime version result` |
| `definitions.ClusterProperties.properties.certificateCommonNames.description__added` | added | `Describes a list of server certificates referenced by common name that are used to secure the cluster.` |
| `definitions.ClusterProperties.properties.reverseProxyCertificateCommonNames.description__added` | added | `Describes a list of server certificates referenced by common name that are used to secure the cluster.` |
| `definitions.ClusterPropertiesUpdateParameters.properties.certificateCommonNames.description__added` | added | `Describes a list of server certificates referenced by common name that are used to secure the cluster.` |
| `definitions.ClusterUpdateParameters.properties.properties.description__added` | added | `Describes the cluster resource properties that can be updated during PATCH operation.` |
| `definitions.ErrorModel.properties.error.description__added` | added | `The error details.` |
| `definitions.NodeTypeDescription.properties.capacities.additionalProperties.description__deleted` | deleted | `Capacity tag value` |
| `definitions.NodeTypeDescription.properties.placementProperties.additionalProperties.description__deleted` | deleted | `Placement tag value` |
| `definitions.ProxyResource.properties.systemData.description__added` | added | `Metadata pertaining to creation and last modification of the resource.` |
| `definitions.ServiceResource.properties.properties.description__added` | added | `The service resource properties.` |
| `definitions.ServiceResourceProperties.properties.partitionDescription.description__added` | added | `Describes how the service is partitioned.` |
| `definitions.ServiceResourcePropertiesBase.properties.correlationScheme.description__added` | added | `A list that describes the correlation of the service with other services.` |
| `definitions.ServiceResourcePropertiesBase.properties.serviceLoadMetrics.description__added` | added | `The service load metrics is given as an array of ServiceLoadMetricDescription objects.` |
| `definitions.ServiceResourcePropertiesBase.properties.servicePlacementPolicies.description__added` | added | `A list that describes the correlation of the service with other services.` |
| `definitions.ServiceResourceUpdate.properties.properties.description__added` | added | `The RP-specific properties for this resource.` |
| `definitions.UpgradableVersionPathResult.properties.supportedPath.description__added` | added | `The list of intermediate cluster code versions for an upgrade or downgrade.` |
| `definitions.UpgradableVersionPathResult.properties.supportedPath.items.description__deleted` | deleted | `The cluster code version.` |
| `definitions.UpgradableVersionsDescription.description__added` | added | `The upgrade path description with target version.` |

### Changes for `items`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationResourceUpdateProperties.properties.metrics.items__added` | added | `{"$ref":"#/definitions/ApplicationMetricDescription"}` |
| `definitions.ServiceResourcePropertiesBase.properties.correlationScheme.items__added` | added | `{"$ref":"#/definitions/ServiceCorrelationDescription"}` |
| `definitions.ServiceResourcePropertiesBase.properties.serviceLoadMetrics.items__added` | added | `{"$ref":"#/definitions/ServiceLoadMetricDescription"}` |
| `definitions.ServiceResourcePropertiesBase.properties.servicePlacementPolicies.items__added` | added | `{"$ref":"#/definitions/ServicePlacementPolicyDescription"}` |

### Changes for `identity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationTypeResource.properties.identity__added` | added | `{"$ref":"../../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Man...` |
| `definitions.ApplicationTypeVersionResource.properties.identity__added` | added | `{"$ref":"../../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Man...` |
| `definitions.ServiceResource.properties.identity__added` | added | `{"$ref":"../../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Man...` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CertificateDescription.properties.x509StoreName['x-ms-enum__added']` | added | `{"name":"StoreName","modelAsString":true}` |
| `definitions.ClusterProperties.properties.addOnFeatures.items['x-ms-enum__added']` | added | `{"name":"AddOnFeatures","modelAsString":true}` |
| `definitions.ClusterProperties.properties.clusterState['x-ms-enum__added']` | added | `{"name":"ClusterState","modelAsString":true}` |
| `definitions.ClusterProperties.properties.reliabilityLevel['x-ms-enum__added']` | added | `{"name":"ReliabilityLevel","modelAsString":true}` |
| `definitions.ClusterPropertiesUpdateParameters.properties.addOnFeatures.items['x-ms-enum__added']` | added | `{"name":"AddOnFeatures","modelAsString":true}` |
| `definitions.ClusterPropertiesUpdateParameters.properties.reliabilityLevel['x-ms-enum__added']` | added | `{"name":"ReliabilityLevel","modelAsString":true}` |
| `definitions.ClusterVersionDetails.properties.environment['x-ms-enum__added']` | added | `{"name":"ClusterEnvironment","modelAsString":true}` |
| `definitions.NodeTypeDescription.properties.durabilityLevel['x-ms-enum__added']` | added | `{"name":"DurabilityLevel","modelAsString":true}` |
| `definitions.ServerCertificateCommonNames.properties.x509StoreName['x-ms-enum__added']` | added | `{"name":"StoreName","modelAsString":true}` |

### Changes for `x-ms-identifiers`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterProperties.properties.availableClusterVersions['x-ms-identifiers__added']` | added | `["codeVersion","environment"]` |
| `definitions.ClusterProperties.properties.clientCertificateCommonNames['x-ms-identifiers__added']` | added | `["certificateCommonName"]` |
| `definitions.ClusterProperties.properties.clientCertificateThumbprints['x-ms-identifiers__added']` | added | `["certificateThumbprint"]` |
| `definitions.ClusterPropertiesUpdateParameters.properties.clientCertificateCommonNames['x-ms-identifiers__added']` | added | `["certificateCommonName"]` |
| `definitions.ClusterPropertiesUpdateParameters.properties.clientCertificateThumbprints['x-ms-identifiers__added']` | added | `["certificateThumbprint"]` |
| `definitions.ServerCertificateCommonNames.properties.commonNames['x-ms-identifiers__added']` | added | `["certificateCommonName"]` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterUpgradeDeltaHealthPolicy.properties.maxPercentDeltaUnhealthyApplications.default__added` | added | `0` |
| `definitions.ClusterUpgradeDeltaHealthPolicy.properties.maxPercentDeltaUnhealthyNodes.default__added` | added | `0` |
| `definitions.ClusterUpgradeDeltaHealthPolicy.properties.maxPercentUpgradeDomainDeltaUnhealthyNodes.default__added` | added | `0` |
| `definitions.ClusterUpgradePolicy.properties.forceRestart.default__added` | added | `false` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterUpgradePolicy.properties.healthCheckRetryTimeout.format__added` | added | `duration-constant` |
| `definitions.ClusterUpgradePolicy.properties.healthCheckStableDuration.format__added` | added | `duration-constant` |
| `definitions.ClusterUpgradePolicy.properties.healthCheckWaitDuration.format__added` | added | `duration-constant` |
| `definitions.ClusterUpgradePolicy.properties.upgradeDomainTimeout.format__added` | added | `duration-constant` |
| `definitions.ClusterUpgradePolicy.properties.upgradeTimeout.format__added` | added | `duration-constant` |

### Changes for `x-ms-client-flatten`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceResource.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.ServiceResourceUpdate.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VMSizeResource.allOf__added` | added | `[{"$ref":"../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResourc...` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VMSizeResource.properties.id__deleted` | deleted | `{"type":"string","description":"VM Size id.","readOnly":true}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ApplicationDeltaHealthPolicy.description` | `Defines a delta health policy used to evaluate the health of an application or one of its child entities when upgrading the cluster.
` | `Defines a delta health policy used to evaluate the health of an application or one of its child entities when upgrading the cluster.` |
| `definitions.ApplicationHealthPolicy.description` | `Defines a health policy used to evaluate the health of an application or one of its children entities.
` | `Defines a health policy used to evaluate the health of an application or one of its children entities.` |
| `definitions.ApplicationMetricDescription.description` | `Describes capacity information for a custom resource balancing metric. This can be used to limit the total consumption of this metric by the services of this application.
` | `Describes capacity information for a custom resource balancing metric. This can be used to limit the total consumption of this metric by the services of this application.` |
| `definitions.ApplicationMetricDescription.properties.maximumCapacity.description` | `The maximum node capacity for Service Fabric application.
This is the maximum Load for an instance of this application on a single node. Even if the capacity of node is greater than this value, Service Fabric will limit the total load of services within the application on each node to this value.
If set to zero, capacity for this metric is unlimited on each node.
When creating a new application with application capacity defined, the product of MaximumNodes and this value must always be smaller than or equal to TotalApplicationCapacity.
When updating existing application with application capacity, the product of MaximumNodes and this value must always be smaller than or equal to TotalApplicationCapacity.
` | `The maximum node capacity for Service Fabric application.
This is the maximum Load for an instance of this application on a single node. Even if the capacity of node is greater than this value, Service Fabric will limit the total load of services within the application on each node to this value.
If set to zero, capacity for this metric is unlimited on each node.
When creating a new application with application capacity defined, the product of MaximumNodes and this value must always be smaller than or equal to TotalApplicationCapacity.
When updating existing application with application capacity, the product of MaximumNodes and this value must always be smaller than or equal to TotalApplicationCapacity.` |
| `definitions.ApplicationMetricDescription.properties.reservationCapacity.description` | `The node reservation capacity for Service Fabric application.
This is the amount of load which is reserved on nodes which have instances of this application.
If MinimumNodes is specified, then the product of these values will be the capacity reserved in the cluster for the application.
If set to zero, no capacity is reserved for this metric.
When setting application capacity or when updating application capacity; this value must be smaller than or equal to MaximumCapacity for each metric.
` | `The node reservation capacity for Service Fabric application.
This is the amount of load which is reserved on nodes which have instances of this application.
If MinimumNodes is specified, then the product of these values will be the capacity reserved in the cluster for the application.
If set to zero, no capacity is reserved for this metric.
When setting application capacity or when updating application capacity; this value must be smaller than or equal to MaximumCapacity for each metric.` |
| `definitions.ApplicationMetricDescription.properties.totalApplicationCapacity.description` | `The total metric capacity for Service Fabric application.
This is the total metric capacity for this application in the cluster. Service Fabric will try to limit the sum of loads of services within the application to this value.
When creating a new application with application capacity defined, the product of MaximumNodes and MaximumCapacity must always be smaller than or equal to this value.
` | `The total metric capacity for Service Fabric application.
This is the total metric capacity for this application in the cluster. Service Fabric will try to limit the sum of loads of services within the application to this value.
When creating a new application with application capacity defined, the product of MaximumNodes and MaximumCapacity must always be smaller than or equal to this value.` |
| `definitions.ApplicationResource.allOf[0].$ref` | `#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ApplicationResource.properties.identity.$ref` | `#/definitions/ManagedIdentity` | `../../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/ManagedServiceIdentity` |
| `definitions.ApplicationTypeResource.allOf[0].$ref` | `#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ApplicationTypeVersionResource.allOf[0].$ref` | `#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ArmApplicationHealthPolicy.description` | `Defines a health policy used to evaluate the health of an application or one of its children entities.
` | `Defines a health policy used to evaluate the health of an application or one of its children entities.` |
| `definitions.ArmApplicationHealthPolicy.properties.maxPercentUnhealthyDeployedApplications.description` | `The maximum allowed percentage of unhealthy deployed applications. Allowed values are Byte values from zero to 100.
The percentage represents the maximum tolerated percentage of deployed applications that can be unhealthy before the application is considered in error.
This is calculated by dividing the number of unhealthy deployed applications over the number of nodes where the application is currently deployed on in the cluster.
The computation rounds up to tolerate one failure on small numbers of nodes. Default percentage is zero.
` | `The maximum allowed percentage of unhealthy deployed applications. Allowed values are Byte values from zero to 100.
The percentage represents the maximum tolerated percentage of deployed applications that can be unhealthy before the application is considered in error.
This is calculated by dividing the number of unhealthy deployed applications over the number of nodes where the application is currently deployed on in the cluster.
The computation rounds up to tolerate one failure on small numbers of nodes. Default percentage is zero.` |
| `definitions.ArmServiceTypeHealthPolicy.description` | `Represents the health policy used to evaluate the health of services belonging to a service type.
` | `Represents the health policy used to evaluate the health of services belonging to a service type.` |
| `definitions.ArmServiceTypeHealthPolicy.properties.maxPercentUnhealthyPartitionsPerService.description` | `The maximum percentage of partitions per service allowed to be unhealthy before your application is considered in error.
` | `The maximum percentage of partitions per service allowed to be unhealthy before your application is considered in error.` |
| `definitions.ArmServiceTypeHealthPolicy.properties.maxPercentUnhealthyReplicasPerPartition.description` | `The maximum percentage of replicas per partition allowed to be unhealthy before your application is considered in error.
` | `The maximum percentage of replicas per partition allowed to be unhealthy before your application is considered in error.` |
| `definitions.ArmServiceTypeHealthPolicy.properties.maxPercentUnhealthyServices.description` | `The maximum percentage of services allowed to be unhealthy before your application is considered in error.
` | `The maximum percentage of services allowed to be unhealthy before your application is considered in error.` |
| `definitions.Cluster.allOf[1].$ref` | `#/definitions/Resource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.Cluster.description` | `The cluster resource
` | `The cluster resource` |
| `definitions.ClusterHealthPolicy.description` | `Defines a health policy used to evaluate the health of the cluster or of a cluster node.
` | `Defines a health policy used to evaluate the health of the cluster or of a cluster node.` |
| `definitions.ClusterHealthPolicy.properties.maxPercentUnhealthyApplications.description` | `The maximum allowed percentage of unhealthy applications before reporting an error. For example, to allow 10% of applications to be unhealthy, this value would be 10.

The percentage represents the maximum tolerated percentage of applications that can be unhealthy before the cluster is considered in error.
If the percentage is respected but there is at least one unhealthy application, the health is evaluated as Warning.
This is calculated by dividing the number of unhealthy applications over the total number of application instances in the cluster, excluding applications of application types that are included in the ApplicationTypeHealthPolicyMap.
The computation rounds up to tolerate one failure on small numbers of applications. Default percentage is zero.
` | `The maximum allowed percentage of unhealthy applications before reporting an error. For example, to allow 10% of applications to be unhealthy, this value would be 10.

The percentage represents the maximum tolerated percentage of applications that can be unhealthy before the cluster is considered in error.
If the percentage is respected but there is at least one unhealthy application, the health is evaluated as Warning.
This is calculated by dividing the number of unhealthy applications over the total number of application instances in the cluster, excluding applications of application types that are included in the ApplicationTypeHealthPolicyMap.
The computation rounds up to tolerate one failure on small numbers of applications. Default percentage is zero.` |
| `definitions.ClusterHealthPolicy.properties.maxPercentUnhealthyNodes.description` | `The maximum allowed percentage of unhealthy nodes before reporting an error. For example, to allow 10% of nodes to be unhealthy, this value would be 10.

The percentage represents the maximum tolerated percentage of nodes that can be unhealthy before the cluster is considered in error.
If the percentage is respected but there is at least one unhealthy node, the health is evaluated as Warning.
The percentage is calculated by dividing the number of unhealthy nodes over the total number of nodes in the cluster.
The computation rounds up to tolerate one failure on small numbers of nodes. Default percentage is zero.

In large clusters, some nodes will always be down or out for repairs, so this percentage should be configured to tolerate that.
` | `The maximum allowed percentage of unhealthy nodes before reporting an error. For example, to allow 10% of nodes to be unhealthy, this value would be 10.

The percentage represents the maximum tolerated percentage of nodes that can be unhealthy before the cluster is considered in error.
If the percentage is respected but there is at least one unhealthy node, the health is evaluated as Warning.
The percentage is calculated by dividing the number of unhealthy nodes over the total number of nodes in the cluster.
The computation rounds up to tolerate one failure on small numbers of nodes. Default percentage is zero.

In large clusters, some nodes will always be down or out for repairs, so this percentage should be configured to tolerate that.` |
| `definitions.ClusterProperties.properties.clusterState.description` | `The current state of the cluster.

  - WaitingForNodes - Indicates that the cluster resource is created and the resource provider is waiting for Service Fabric VM extension to boot up and report to it.
  - Deploying - Indicates that the Service Fabric runtime is being installed on the VMs. Cluster resource will be in this state until the cluster boots up and system services are up.
  - BaselineUpgrade - Indicates that the cluster is upgrading to establishes the cluster version. This upgrade is automatically initiated when the cluster boots up for the first time.
  - UpdatingUserConfiguration - Indicates that the cluster is being upgraded with the user provided configuration.
  - UpdatingUserCertificate - Indicates that the cluster is being upgraded with the user provided certificate.
  - UpdatingInfrastructure - Indicates that the cluster is being upgraded with the latest Service Fabric runtime version. This happens only when the **upgradeMode** is set to 'Automatic'.
  - EnforcingClusterVersion - Indicates that cluster is on a different version than expected and the cluster is being upgraded to the expected version.
  - UpgradeServiceUnreachable - Indicates that the system service in the cluster is no longer polling the Resource Provider. Clusters in this state cannot be managed by the Resource Provider.
  - AutoScale - Indicates that the ReliabilityLevel of the cluster is being adjusted.
  - Ready - Indicates that the cluster is in a stable state.
` | `The current state of the cluster.` |
| `definitions.ClusterProperties.properties.reliabilityLevel.description` | `The reliability level sets the replica set size of system services. Learn about [ReliabilityLevel](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-capacity).

  - None - Run the System services with a target replica set count of 1. This should only be used for test clusters.
  - Bronze - Run the System services with a target replica set count of 3. This should only be used for test clusters.
  - Silver - Run the System services with a target replica set count of 5.
  - Gold - Run the System services with a target replica set count of 7.
  - Platinum - Run the System services with a target replica set count of 9.
` | `The reliability level sets the replica set size of system services. Learn about [ReliabilityLevel](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-capacity).` |
| `definitions.ClusterPropertiesUpdateParameters.properties.reliabilityLevel.description` | `The reliability level sets the replica set size of system services. Learn about [ReliabilityLevel](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-capacity).

  - None - Run the System services with a target replica set count of 1. This should only be used for test clusters.
  - Bronze - Run the System services with a target replica set count of 3. This should only be used for test clusters.
  - Silver - Run the System services with a target replica set count of 5.
  - Gold - Run the System services with a target replica set count of 7.
  - Platinum - Run the System services with a target replica set count of 9.
` | `The reliability level sets the replica set size of system services. Learn about [ReliabilityLevel](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-capacity).` |
| `definitions.ClusterUpgradeDeltaHealthPolicy.properties.maxPercentDeltaUnhealthyApplications.description` | `The maximum allowed percentage of applications health degradation allowed during cluster upgrades.
The delta is measured between the state of the applications at the beginning of upgrade and the state of the applications at the time of the health evaluation.
The check is performed after every upgrade domain upgrade completion to make sure the global state of the cluster is within tolerated limits. System services are not included in this.
` | `The maximum allowed percentage of applications health degradation allowed during cluster upgrades.
The delta is measured between the state of the applications at the beginning of upgrade and the state of the applications at the time of the health evaluation.
The check is performed after every upgrade domain upgrade completion to make sure the global state of the cluster is within tolerated limits. System services are not included in this.` |
| `definitions.ClusterUpgradeDeltaHealthPolicy.properties.maxPercentDeltaUnhealthyNodes.description` | `The maximum allowed percentage of nodes health degradation allowed during cluster upgrades.
The delta is measured between the state of the nodes at the beginning of upgrade and the state of the nodes at the time of the health evaluation.
The check is performed after every upgrade domain upgrade completion to make sure the global state of the cluster is within tolerated limits.
` | `The maximum allowed percentage of nodes health degradation allowed during cluster upgrades.
The delta is measured between the state of the nodes at the beginning of upgrade and the state of the nodes at the time of the health evaluation.
The check is performed after every upgrade domain upgrade completion to make sure the global state of the cluster is within tolerated limits.` |
| `definitions.ClusterUpgradeDeltaHealthPolicy.properties.maxPercentUpgradeDomainDeltaUnhealthyNodes.description` | `The maximum allowed percentage of upgrade domain nodes health degradation allowed during cluster upgrades.
The delta is measured between the state of the upgrade domain nodes at the beginning of upgrade and the state of the upgrade domain nodes at the time of the health evaluation.
The check is performed after every upgrade domain upgrade completion for all completed upgrade domains to make sure the state of the upgrade domains is within tolerated limits.
` | `The maximum allowed percentage of upgrade domain nodes health degradation allowed during cluster upgrades.
The delta is measured between the state of the upgrade domain nodes at the beginning of upgrade and the state of the upgrade domain nodes at the time of the health evaluation.
The check is performed after every upgrade domain upgrade completion for all completed upgrade domains to make sure the state of the upgrade domains is within tolerated limits.` |
| `definitions.NodeTypeDescription.properties.durabilityLevel.description` | `The durability level of the node type. Learn about [DurabilityLevel](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-capacity).

  - Bronze - No privileges. This is the default.
  - Silver - The infrastructure jobs can be paused for a duration of 10 minutes per UD.
  - Gold - The infrastructure jobs can be paused for a duration of 2 hours per UD. Gold durability can be enabled only on full node VM skus like D15_V2, G5 etc.
` | `The durability level of the node type. Learn about [DurabilityLevel](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-capacity).` |
| `definitions.ProxyResource.properties.systemData.$ref` | `#/definitions/SystemData` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/systemData` |
| `definitions.ServiceResource.allOf[0].$ref` | `#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ServiceResourceProperties.properties.serviceDnsName.description` | `Dns name used for the service. If this is specified, then the DNS name can be used to return the IP addresses of service endpoints for application layer protocols (e.g., HTTP).
When updating serviceDnsName, old name may be temporarily resolvable. However, rely on new name.
When removing serviceDnsName, removed name may temporarily be resolvable. Do not rely on the name being unresolvable.
` | `Dns name used for the service. If this is specified, then the DNS name can be used to return the IP addresses of service endpoints for application layer protocols (e.g., HTTP).
When updating serviceDnsName, old name may be temporarily resolvable. However, rely on new name.
When removing serviceDnsName, removed name may temporarily be resolvable. Do not rely on the name being unresolvable.` |
| `definitions.ServiceTypeDeltaHealthPolicy.description` | `Represents the delta health policy used to evaluate the health of services belonging to a service type when upgrading the cluster.
` | `Represents the delta health policy used to evaluate the health of services belonging to a service type when upgrading the cluster.` |
| `definitions.ServiceTypeDeltaHealthPolicy.properties.maxPercentDeltaUnhealthyServices.description` | `The maximum allowed percentage of services health degradation allowed during cluster upgrades.
The delta is measured between the state of the services at the beginning of upgrade and the state of the services at the time of the health evaluation.
The check is performed after every upgrade domain upgrade completion to make sure the global state of the cluster is within tolerated limits.
` | `The maximum allowed percentage of services health degradation allowed during cluster upgrades.
The delta is measured between the state of the services at the beginning of upgrade and the state of the services at the time of the health evaluation.
The check is performed after every upgrade domain upgrade completion to make sure the global state of the cluster is within tolerated limits.` |
| `definitions.ServiceTypeHealthPolicy.description` | `Represents the health policy used to evaluate the health of services belonging to a service type.
` | `Represents the health policy used to evaluate the health of services belonging to a service type.` |
| `definitions.ServiceTypeHealthPolicy.properties.maxPercentUnhealthyServices.description` | `The maximum percentage of services allowed to be unhealthy before your application is considered in error.
` | `The maximum percentage of services allowed to be unhealthy before your application is considered in error.` |
| `definitions.UniformInt64RangePartitionSchemeDescription.properties.highKey.description` | `String indicating the upper bound of the partition key range that
should be split between the partition ‘count’
` | `String indicating the upper bound of the partition key range that
should be split between the partition ‘count’` |
| `definitions.UniformInt64RangePartitionSchemeDescription.properties.lowKey.description` | `String indicating the lower bound of the partition key range that
should be split between the partition ‘count’
` | `String indicating the lower bound of the partition key range that
should be split between the partition ‘count’` |
| `definitions.UpgradableVersionPathResult.description` | `The list of intermediate cluster code versions for an upgrade or downgrade. Or minimum and maximum upgradable version if no target was given` | `The list of intermediate cluster code versions for an upgrade or downgrade, or minimum and maximum upgradable version if no target was given.` |
| `paths['/providers/microsoft.ServiceFabric/operations'].get.description` | `Get the list of available Service Fabric resource provider API operations.` | `List the operations for the provider` |

