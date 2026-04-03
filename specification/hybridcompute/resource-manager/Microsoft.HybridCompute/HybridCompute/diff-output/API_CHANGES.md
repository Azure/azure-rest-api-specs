## Changed Paths

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/licenseProfiles/{licenseProfileName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/licenseProfiles/default
Change Type: added

## Swagger Changes

### Changes for `x-ms-code-generation-settings`

| Path | Change Type | Value |
|------|------------|-------|
| `info['x-ms-code-generation-settings__deleted']` | deleted | `{"name":"HybridComputeManagementClient"}` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/licenseProfiles/{licenseProfileName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/licenseProfiles/{licenseProfileName}__deleted']` | deleted | `{"get":{"operationId":"LicenseProfiles_Get","tags":["licenseProfiles"],"description":"Retrieves info...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/licenseProfiles/default`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/licenseProfiles/default__added']` | added | `{"get":{"operationId":"LicenseProfiles_Get","tags":["LicenseProfiles"],"description":"Retrieves info...` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.HybridCompute/locations/{location}/publishers'].get.tags__deleted` | deleted | `["extensions"]` |
| `paths['/providers/microsoft.HybridCompute/locations/{location}/publishers/{publisher}/extensionTypes'].get.tags__deleted` | deleted | `["extensions"]` |
| `paths['/providers/microsoft.HybridCompute/osType/{osType}/agentVersions'].get.tags__deleted` | deleted | `["AgentVersions"]` |
| `paths['/providers/microsoft.HybridCompute/osType/{osType}/agentVersions/{version}'].get.tags__deleted` | deleted | `["AgentVersions"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/privateLinkScopes'].get.tags__added` | added | `["HybridComputePrivateLinkScopes"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/validateLicense'].post.tags__deleted` | deleted | `["licenses"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/privateLinkScopes/current'].get.tags__added` | added | `["Machines"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes'].get.tags__added` | added | `["HybridComputePrivateLinkScopes"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}'].delete.tags__added` | added | `["HybridComputePrivateLinkScopes"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}'].get.tags__added` | added | `["HybridComputePrivateLinkScopes"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}'].patch.tags__added` | added | `["HybridComputePrivateLinkScopes"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}'].put.tags__added` | added | `["HybridComputePrivateLinkScopes"]` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterConfiguration.properties.name__deleted` | deleted | `{"type":"string","description":"Azure resource name","readOnly":true}` |
| `paths['/providers/microsoft.HybridCompute/locations/{location}/publishers'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/providers/microsoft.HybridCompute/locations/{location}/publishers/{publisher}/extensionTypes'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/locations/{location}/privateLinkScopes/{privateLinkScopeId}'].get.parameters[0].name__deleted` | deleted | `location` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.HybridCompute/locations/{location}/publishers'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/providers/microsoft.HybridCompute/locations/{location}/publishers/{publisher}/extensionTypes'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/locations/{location}/privateLinkScopes/{privateLinkScopeId}'].get.parameters[0].in__deleted` | deleted | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AgentVersionsList.required__added` | added | `["value"]` |
| `definitions.ExtensionPublisherListResult.required__added` | added | `["value"]` |
| `definitions.ExtensionTypeListResult.required__added` | added | `["value"]` |
| `definitions.ExtensionValueListResultV2.required__added` | added | `["value"]` |
| `definitions.NetworkSecurityPerimeterConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.PrivateEndpointConnectionListResult.required__added` | added | `["value"]` |
| `definitions.PrivateLinkResourceListResult.required__added` | added | `["value"]` |
| `paths['/providers/microsoft.HybridCompute/locations/{location}/publishers'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/providers/microsoft.HybridCompute/locations/{location}/publishers/{publisher}/extensionTypes'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/locations/{location}/privateLinkScopes/{privateLinkScopeId}'].get.parameters[0].required__deleted` | deleted | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IpAddress.properties.subnet.type__deleted` | deleted | `object` |
| `definitions.LicenseProfile.properties.properties.type__deleted` | deleted | `object` |
| `definitions.LicenseProfileMachineInstanceView.properties.softwareAssurance.type__deleted` | deleted | `object` |
| `definitions.LicenseProfileUpdate.properties.properties.type__deleted` | deleted | `object` |
| `definitions.LicenseUpdateProperties.properties.licenseDetails.type__deleted` | deleted | `object` |
| `definitions.MachineExtensionInstanceView.properties.status.type__deleted` | deleted | `object` |
| `definitions.MachineExtensionUpgrade.properties.extensionTargets.type__added` | added | `object` |
| `definitions.MachineProperties.properties.detectedProperties.type__added` | added | `object` |
| `definitions.NetworkSecurityPerimeterConfiguration.properties.type__deleted` | deleted | `{"type":"string","description":"Azure resource type","readOnly":true}` |
| `definitions.OSProfile.properties.linuxConfiguration.type__deleted` | deleted | `object` |
| `definitions.OSProfile.properties.windowsConfiguration.type__deleted` | deleted | `object` |
| `definitions.PatchSettings.properties.status.type__deleted` | deleted | `object` |
| `paths['/providers/microsoft.HybridCompute/locations/{location}/publishers'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/providers/microsoft.HybridCompute/locations/{location}/publishers/{publisher}/extensionTypes'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/locations/{location}/privateLinkScopes/{privateLinkScopeId}'].get.parameters[0].type__deleted` | deleted | `string` |

### Changes for `minLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.HybridCompute/locations/{location}/publishers'].get.parameters[0].minLength__deleted` | deleted | `1` |
| `paths['/providers/microsoft.HybridCompute/locations/{location}/publishers/{publisher}/extensionTypes'].get.parameters[0].minLength__deleted` | deleted | `1` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/locations/{location}/privateLinkScopes/{privateLinkScopeId}'].get.parameters[0].minLength__deleted` | deleted | `1` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/locations/{location}/publishers/{publisher}/extensionTypes/{extensionType}/versions'].get.parameters[0].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/locations/{location}/publishers/{publisher}/extensionTypes/{extensionType}/versions/{version}'].get.parameters[0].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands'].get.parameters[0].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].delete.parameters[0].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].get.parameters[0].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].patch.parameters[0].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].put.parameters[0].minLength__added` | added | `1` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LicenseProfile.properties.properties.$ref__added` | added | `#/definitions/LicenseProfileProperties` |
| `definitions.LicenseProfileMachineInstanceView.properties.softwareAssurance.$ref__added` | added | `#/definitions/LicenseProfileMachineInstanceViewSoftwareAssurance` |
| `definitions.LicenseProfileUpdate.properties.properties.$ref__added` | added | `#/definitions/LicenseProfileUpdateProperties` |
| `definitions.LicenseUpdateProperties.properties.licenseDetails.$ref__added` | added | `#/definitions/LicenseUpdatePropertiesLicenseDetails` |
| `definitions.MachineExtensionInstanceView.properties.status.$ref__added` | added | `#/definitions/MachineExtensionInstanceViewStatus` |
| `definitions.MachineExtensionUpgrade.properties.extensionTargets.$ref__deleted` | deleted | `#/definitions/ExtensionTarget` |
| `definitions.MachineProperties.properties.detectedProperties.$ref__deleted` | deleted | `#/definitions/DetectedProperties` |
| `definitions.OSProfile.properties.linuxConfiguration.$ref__added` | added | `#/definitions/OSProfileLinuxConfiguration` |
| `definitions.OSProfile.properties.windowsConfiguration.$ref__added` | added | `#/definitions/OSProfileWindowsConfiguration` |
| `definitions.PatchSettings.properties.status.$ref__added` | added | `#/definitions/PatchSettingsStatus` |
| `paths['/providers/microsoft.HybridCompute/locations/{location}/publishers'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/providers/microsoft.HybridCompute/locations/{location}/publishers/{publisher}/extensionTypes'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/locations/{location}/privateLinkScopes/{privateLinkScopeId}'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v3/types.json#/parameters/LocationParameter` |

### Changes for `x-ms-examples`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.HybridCompute/osType/{osType}/agentVersions'].get['x-ms-examples__deleted']` | deleted | `{"GET Agent Versions":{"$ref":"./examples/AgentVersions_Get.json"}}` |
| `paths['/providers/microsoft.HybridCompute/osType/{osType}/agentVersions/{version}'].get['x-ms-examples__deleted']` | deleted | `{"GET Agent Versions":{"$ref":"./examples/AgentVersion_GetLatest.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/hybridIdentityMetadata/{metadataName}'].get['x-ms-examples__deleted']` | deleted | `{"GetHybridIdentityMetadata":{"$ref":"./examples/HybridIdentityMetadata_Get.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/providers/microsoft.HybridCompute/networkConfigurations/current'].get['x-ms-examples__deleted']` | deleted | `{"NetworkConfigurationsGet":{"$ref":"./examples/networkConfiguration/NetworkConfigurationsGet.json"}...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/providers/microsoft.HybridCompute/networkConfigurations/current'].patch['x-ms-examples__deleted']` | deleted | `{"NetworkConfigurationsPatch":{"$ref":"./examples/networkConfiguration/NetworkConfigurationsPatch.js...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/providers/microsoft.HybridCompute/networkConfigurations/current'].put['x-ms-examples__deleted']` | deleted | `{"NetworkConfigurationsCreate":{"$ref":"./examples/networkConfiguration/NetworkConfigurationsCreate....` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].patch['x-ms-examples__deleted']` | deleted | `{"Update a Run Command":{"$ref":"./examples/runCommand/RunCommands_Update.json"}}` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HybridIdentityMetadata.allOf[0].description__deleted` | deleted | `The resource model definition for an Azure Resource Manager proxy resource. It will have everything other than required location and tags.` |
| `definitions.HybridIdentityMetadataProperties.properties.identity.description__added` | added | `Identity for the resource.` |
| `definitions.LicenseProfileMachineInstanceView.properties.esuProfile.description__added` | added | `Properties for the Machine ESU profile.` |
| `definitions.Machine.properties.identity.description__added` | added | `Identity for the resource.` |
| `definitions.MachineProperties.properties.locationData.description__added` | added | `Metadata pertaining to the geographic location of the resource.` |
| `definitions.MachineUpdate.properties.identity.description__added` | added | `Identity for the resource.` |
| `definitions.MachineUpdateProperties.properties.locationData.description__added` | added | `Metadata pertaining to the geographic location of the resource.` |
| `definitions.MachineUpdateProperties.properties.osProfile.description__added` | added | `Specifies the operating system settings for the hybrid machine.` |
| `definitions.NetworkConfiguration.properties.properties.description__added` | added | `Network configuration properties` |
| `definitions.ServiceExtensionType.description__deleted` | deleted | `The name of the Azure Arc Extension.` |
| `definitions.Settings.description__added` | added | `Concrete proxy resource types can be created by aliasing this type using a specific property type.` |
| `definitions.Settings.properties.properties.description__added` | added | `Settings properties` |
| `definitions.SettingsProperties.properties.gatewayProperties.description__added` | added | `Settings Gateway properties` |
| `paths['/providers/microsoft.HybridCompute/osType/{osType}/agentVersions/{version}'].get.description__deleted` | deleted | `Gets an Agent Version along with the download link currently present.` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/validateLicense'].post.responses.200.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/licenses/{licenseName}'].delete.responses.200.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/licenses/{licenseName}'].patch.responses.200.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/licenses/{licenseName}'].put.responses.200.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/extensions/{extensionName}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |

### Changes for `202`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/validateLicense'].post.responses.202__added` | added | `{"description":"ignore","headers":{"Location":{"type":"string","description":"The Location header co...` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AgentUpgrade.properties.correlationId.format__added` | added | `uuid` |
| `definitions.AgentUpgrade.properties.lastAttemptTimestamp.format__added` | added | `date-time` |
| `definitions.MachineAssessPatchesResult.properties.assessmentActivityId.format__added` | added | `uuid` |
| `definitions.MachineInstallPatchesParameters.properties.maximumDuration.format__added` | added | `duration` |
| `definitions.MachineProperties.properties.parentClusterResourceId.format__added` | added | `arm-id` |
| `definitions.MachineProperties.properties.privateLinkScopeResourceId.format__added` | added | `arm-id` |
| `definitions.MachineProperties.properties.vmId.format__added` | added | `uuid` |
| `definitions.MachineProperties.properties.vmUuid.format__added` | added | `uuid` |
| `definitions.MachineUpdateProperties.properties.parentClusterResourceId.format__added` | added | `arm-id` |
| `definitions.MachineUpdateProperties.properties.privateLinkScopeResourceId.format__added` | added | `arm-id` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/gateways/{gatewayName}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/gateways/{gatewayName}'].put.responses.201.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/addExtensions'].post.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |

### Changes for `Azure-AsyncOperation`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/extensions/{extensionName}'].delete.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/extensions/{extensionName}'].patch.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].delete.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].patch.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/upgradeExtensions'].post.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}'].delete.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}/networkSecurityPerimeterConfigurations/{perimeterName}/reconcile'].post.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |

### Changes for `get`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/hybridIdentityMetadata'].get__deleted` | deleted | `{"operationId":"HybridIdentityMetadata_ListByMachines","tags":["HybridIdentityMetadata"],"summary":"...` |

### Changes for `post`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/hybridIdentityMetadata'].post__added` | added | `{"operationId":"HybridIdentityMetadata_ListByMachines","tags":["Machines"],"summary":"Implements GET...` |

### Changes for `pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/hybridIdentityMetadata/{metadataName}'].get.parameters[2].pattern__deleted` | deleted | `^[a-zA-Z0-9-_\\.]{1,54}$` |

### Changes for `maxLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/privateLinkScopes/current'].get.parameters[0].maxLength__added` | added | `54` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands'].get.parameters[0].maxLength__added` | added | `54` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].delete.parameters[0].maxLength__added` | added | `54` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].get.parameters[0].maxLength__added` | added | `54` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].patch.parameters[0].maxLength__added` | added | `54` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].put.parameters[0].maxLength__added` | added | `54` |

### Changes for `Location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].put.responses.201.headers.Location__deleted` | deleted | `{"type":"string","description":"The URL of the resource used to check the status of the asynchronous...` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/MachineRunCommand` |

### Changes for `DetectedProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DetectedProperties__deleted` | deleted | `{"type":"object","description":"Detected properties from the machine.","additionalProperties":{"type...` |

### Changes for `ExtensionTarget`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExtensionTarget__deleted` | deleted | `{"type":"object","description":"Describes the Machine Extension Target Properties","additionalProper...` |

### Changes for `GatewaysListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GatewaysListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `LicenseProfilesListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LicenseProfilesListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `LicensesListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LicensesListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `MachineExtensionsListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MachineExtensionsListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `MachineRunCommandsListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MachineRunCommandsListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `OperationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationListResult__deleted` | deleted | `{"type":"object","description":"The List Compute Operation operation response.","properties":{"value...` |

### Changes for `OperationValue`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationValue__deleted` | deleted | `{"type":"object","description":"Describes the properties of a Compute Operation value.","properties"...` |

### Changes for `OperationValueDisplay`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationValueDisplay__deleted` | deleted | `{"type":"object","description":"Describes the properties of a Hybrid Compute Operation Value Display...` |

### Changes for `PrivateLinkScopesResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateLinkScopesResource__deleted` | deleted | `{"type":"object","description":"An azure resource object","properties":{"id":{"type":"string","descr...` |

### Changes for `TargetVersion`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TargetVersion__deleted` | deleted | `{"type":"string","description":"Extension Upgrade Target Version."}` |

### Changes for `Azure.ResourceManager.ArmResponse<MachineAssessPatchesResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<MachineAssessPatchesResult>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<MachineInstallPatchesResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<MachineInstallPatchesResult>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<NetworkSecurityPerimeterConfigurationReconcileResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<NetworkSecurityPerimeterConfigurationReconcileResult>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `GatewayListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GatewayListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `LicenseListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LicenseListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `LicenseProfileListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LicenseProfileListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `LicenseProfileMachineInstanceViewSoftwareAssurance`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LicenseProfileMachineInstanceViewSoftwareAssurance__added` | added | `{"type":"object","properties":{"softwareAssuranceCustomer":{"type":"boolean","description":"Specifie...` |

### Changes for `LicenseProfileProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LicenseProfileProperties__added` | added | `{"type":"object","description":"Describe the properties of a license profile.","properties":{"softwa...` |

### Changes for `LicenseProfilePropertiesSoftwareAssurance`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LicenseProfilePropertiesSoftwareAssurance__added` | added | `{"type":"object","properties":{"softwareAssuranceCustomer":{"type":"boolean","description":"Specifie...` |

### Changes for `LicenseProfileUpdateProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LicenseProfileUpdateProperties__added` | added | `{"type":"object","description":"Describe the Update properties of a license profile.","properties":{...` |

### Changes for `LicenseProfileUpdatePropertiesSoftwareAssurance`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LicenseProfileUpdatePropertiesSoftwareAssurance__added` | added | `{"type":"object","properties":{"softwareAssuranceCustomer":{"type":"boolean","description":"Specifie...` |

### Changes for `LicenseUpdatePropertiesLicenseDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LicenseUpdatePropertiesLicenseDetails__added` | added | `{"type":"object","properties":{"state":{"type":"string","description":"Describes the state of the li...` |

### Changes for `MachineExtensionInstanceViewStatus`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MachineExtensionInstanceViewStatus__added` | added | `{"type":"object","description":"Instance view status.","properties":{"code":{"type":"string","descri...` |

### Changes for `MachineExtensionListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MachineExtensionListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `MachineRunCommandListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MachineRunCommandListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `OSProfileLinuxConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OSProfileLinuxConfiguration__added` | added | `{"type":"object","description":"Specifies the linux configuration for update management.","propertie...` |

### Changes for `OSProfileWindowsConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OSProfileWindowsConfiguration__added` | added | `{"type":"object","description":"Specifies the windows configuration for update management.","propert...` |

### Changes for `PatchSettingsStatus`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PatchSettingsStatus__added` | added | `{"type":"object","description":"Status of the hotpatch capability enrollment or disenrollment.","pro...` |

### Changes for `TypeSpec.Http.OkResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['TypeSpec.Http.OkResponse__added']` | added | `{"type":"object","description":"The request has succeeded."}` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AgentConfiguration.readOnly__deleted` | deleted | `true` |
| `definitions.AgentVersion.readOnly__deleted` | deleted | `true` |
| `definitions.AgentVersionsList.readOnly__deleted` | deleted | `true` |
| `definitions.Disk.readOnly__deleted` | deleted | `true` |
| `definitions.ExtensionPublisherListResult.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.ExtensionTypeListResult.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.ExtensionValueListResultV2.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.FirmwareProfile.readOnly__deleted` | deleted | `true` |
| `definitions.HardwareProfile.readOnly__deleted` | deleted | `true` |
| `definitions.IpAddress.properties.subnet.readOnly__added` | added | `true` |
| `definitions.IpAddress.readOnly__deleted` | deleted | `true` |
| `definitions.MachineProperties.properties.agentConfiguration.readOnly__added` | added | `true` |
| `definitions.MachineProperties.properties.detectedProperties.readOnly__added` | added | `true` |
| `definitions.MachineProperties.properties.firmwareProfile.readOnly__added` | added | `true` |
| `definitions.MachineProperties.properties.hardwareProfile.readOnly__added` | added | `true` |
| `definitions.MachineProperties.properties.networkProfile.readOnly__added` | added | `true` |
| `definitions.MachineProperties.properties.storageProfile.readOnly__added` | added | `true` |
| `definitions.NetworkInterface.readOnly__deleted` | deleted | `true` |
| `definitions.NetworkProfile.readOnly__deleted` | deleted | `true` |
| `definitions.NetworkSecurityPerimeterConfigurationListResult.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.NetworkSecurityPerimeterConfigurationReconcileResult.properties.location.readOnly__added` | added | `true` |
| `definitions.PrivateEndpointConnectionListResult.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.PrivateLinkResourceListResult.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.Processor.readOnly__deleted` | deleted | `true` |
| `definitions.StorageProfile.readOnly__deleted` | deleted | `true` |
| `definitions.Subnet.readOnly__deleted` | deleted | `true` |

### Changes for `x-ms-identifiers`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AgentVersionsList.properties.value['x-ms-identifiers__deleted']` | deleted | `["agentVersion"]` |

### Changes for `nextLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExtensionValueListResult.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HybridComputePrivateLinkScope.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v3/types.json#/definitions/systemData","...` |
| `definitions.HybridIdentityMetadata.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v3/types.json#/definitions/systemData","...` |
| `definitions.PrivateEndpointConnection.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v3/types.json#/definitions/systemData","...` |
| `definitions.PrivateLinkResource.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v3/types.json#/definitions/systemData","...` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LicenseProfile.properties.properties.properties__deleted` | deleted | `{"softwareAssurance":{"type":"object","properties":{"softwareAssuranceCustomer":{"type":"boolean","d...` |
| `definitions.LicenseProfileMachineInstanceView.properties.softwareAssurance.properties__deleted` | deleted | `{"softwareAssuranceCustomer":{"type":"boolean","description":"Specifies if this machine is licensed ...` |
| `definitions.LicenseProfileUpdate.properties.properties.properties__deleted` | deleted | `{"softwareAssurance":{"type":"object","properties":{"softwareAssuranceCustomer":{"type":"boolean","d...` |
| `definitions.LicenseUpdateProperties.properties.licenseDetails.properties__deleted` | deleted | `{"state":{"$ref":"#/definitions/LicenseState"},"target":{"$ref":"#/definitions/LicenseTarget"},"edit...` |
| `definitions.MachineExtensionInstanceView.properties.status.properties__deleted` | deleted | `{"code":{"type":"string","description":"The status code."},"level":{"type":"string","description":"T...` |
| `definitions.OSProfile.properties.linuxConfiguration.properties__deleted` | deleted | `{"patchSettings":{"$ref":"#/definitions/PatchSettings","x-ms-client-flatten":true}}` |
| `definitions.OSProfile.properties.windowsConfiguration.properties__deleted` | deleted | `{"patchSettings":{"$ref":"#/definitions/PatchSettings","x-ms-client-flatten":true}}` |
| `definitions.PatchSettings.properties.status.properties__deleted` | deleted | `{"hotpatchEnablementStatus":{"$ref":"#/definitions/HotpatchEnablementStatus","description":"Indicate...` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MachineExtensionUpgrade.properties.extensionTargets.additionalProperties__added` | added | `{"$ref":"#/definitions/ExtensionTargetProperties"}` |
| `definitions.MachineProperties.properties.detectedProperties.additionalProperties__added` | added | `{"type":"string"}` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MachineRunCommandProperties.properties.asyncExecution.default__deleted` | deleted | `false` |

### Changes for `x-ms-secret`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MachineRunCommandProperties.properties.runAsPassword['x-ms-secret__deleted']` | deleted | `true` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterConfiguration.allOf__added` | added | `[{"$ref":"../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResourc...` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterConfiguration.properties.id__deleted` | deleted | `{"type":"string","description":"Azure resource Id","readOnly":true}` |

### Changes for `x-ms-mutability`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterConfigurationReconcileResult.properties.location['x-ms-mutability__deleted']` | deleted | `["read"]` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceExtension.properties.serviceExtensionType['x-ms-enum__deleted']` | deleted | `{"name":"ServiceExtensionType","modelAsString":true}` |
| `definitions.ServiceExtensionType['x-ms-enum__deleted']` | deleted | `{"name":"ServiceExtensionType","modelAsString":true}` |

### Changes for `x-nullable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceExtension.properties.serviceExtensionType['x-nullable__added']` | added | `false` |
| `definitions.ServiceExtensionType['x-nullable__added']` | added | `false` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AgentConfiguration.properties.configMode['x-ms-enum'].name` | `Agent configuration mode` | `AgentConfigurationMode` |
| `definitions.ExtensionTargetProperties.properties.targetVersion.description` | `Extension Upgrade Target Version.` | `Properties for the specified Extension to Upgrade.` |
| `definitions.ExtensionValueListResult.description` | `The List Extension Metadata response.` | `[Placeholder] Discription for page model` |
| `definitions.ExtensionValueListResult.properties.value.description` | `The list of extension metadata` | `[Placeholder] Discription for value property` |
| `definitions.ExtensionValueV2.allOf[0].$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.HybridComputePrivateLinkScope.allOf[0].$ref` | `#/definitions/PrivateLinkScopesResource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.HybridComputePrivateLinkScopeProperties.properties.publicNetworkAccess.description` | `The network access policy to determine if Azure Arc agents can use public Azure Arc service endpoints. Defaults to disabled (access to Azure Arc services only via private link).` | `Indicates whether machines associated with the private link scope can also use public Azure Arc service endpoints.` |
| `definitions.LinuxParameters.properties.classificationsToInclude.items['x-ms-enum'].name` | `VMGuestPatchClassification_Linux` | `VMGuestPatchClassificationLinux` |
| `definitions.Machine.properties.kind['x-ms-enum'].name` | `ArcKindEnum ` | `ArcKindEnum` |
| `definitions.MachineInstallPatchesResult.properties.status.description` | `The overall success or failure status of the operation. It remains "InProgress" until the operation completes. At that point it will become "Failed", "Succeeded", "Unknown" or "CompletedWithWarnings."` | `The overall success or failure status of the operation. It remains "InProgress" until the operation completes. At that point it will become "Unknown", "Failed", "Succeeded", or "CompletedWithWarnings."` |
| `definitions.MachineRunCommandProperties.properties.errorBlobManagedIdentity.description` | `User-assigned managed identity that has access to errorBlobUri storage blob. Use an empty object in case of system-assigned identity. Make sure managed identity has been given access to blob's container with 'Storage Blob Data Contributor' role assignment. In case of user-assigned identity, make sure you add it under VM's identity. For more info on managed identity and Run Command, refer https://aka.ms/ManagedIdentity and https://aka.ms/RunCommandManaged ` | `User-assigned managed identity that has access to errorBlobUri storage blob. Use an empty object in case of system-assigned identity. Make sure managed identity has been given access to blob's container with 'Storage Blob Data Contributor' role assignment. In case of user-assigned identity, make sure you add it under VM's identity. For more info on managed identity and Run Command, refer https://aka.ms/ManagedIdentity and https://aka.ms/RunCommandManaged` |
| `definitions.MachineRunCommandProperties.properties.outputBlobManagedIdentity.description` | `User-assigned managed identity that has access to outputBlobUri storage blob. Use an empty object in case of system-assigned identity. Make sure managed identity has been given access to blob's container with 'Storage Blob Data Contributor' role assignment. In case of user-assigned identity, make sure you add it under VM's identity. For more info on managed identity and Run Command, refer https://aka.ms/ManagedIdentity and https://aka.ms/RunCommandManaged ` | `User-assigned managed identity that has access to outputBlobUri storage blob. Use an empty object in case of system-assigned identity. Make sure managed identity has been given access to blob's container with 'Storage Blob Data Contributor' role assignment. In case of user-assigned identity, make sure you add it under VM's identity. For more info on managed identity and Run Command, refer https://aka.ms/ManagedIdentity and https://aka.ms/RunCommandManaged` |
| `definitions.MachineRunCommandProperties.properties.outputBlobUri.description` | `Specifies the Azure storage blob where script output stream will be uploaded. Use a SAS URI with read, append, create, write access OR use managed identity to provide the VM access to the blob. Refer outputBlobManagedIdentity parameter. ` | `Specifies the Azure storage blob where script output stream will be uploaded. Use a SAS URI with read, append, create, write access OR use managed identity to provide the VM access to the blob. Refer outputBlobManagedIdentity parameter.` |
| `definitions.MachineUpdate.properties.kind['x-ms-enum'].name` | `ArcKindEnum ` | `ArcKindEnum` |
| `definitions.PrivateLinkScopeValidationDetails.properties.publicNetworkAccess.description` | `The network access policy to determine if Azure Arc agents can use public Azure Arc service endpoints. Defaults to disabled (access to Azure Arc services only via private link).` | `Indicates whether machines associated with the private link scope can also use public Azure Arc service endpoints.` |
| `definitions.RunCommandManagedIdentity.description` | ` Contains clientId or objectId (use only one, not both) of a user-assigned managed identity that has access to storage blob used in Run Command. Use an empty RunCommandManagedIdentity object in case of system-assigned identity. Make sure the Azure storage blob exists in case of scriptUri, and managed identity has been given access to blob's container with 'Storage Blob Data Reader' role assignment with scriptUri blob and 'Storage Blob Data Contributor' for Append blobs(outputBlobUri, errorBlobUri). In case of user assigned identity, make sure you add it under VM's identity. For more info on managed identity and Run Command, refer https://aka.ms/ManagedIdentity and https://aka.ms/RunCommandManaged.` | `Contains clientId or objectId (use only one, not both) of a user-assigned managed identity that has access to storage blob used in Run Command. Use an empty RunCommandManagedIdentity object in case of system-assigned identity. Make sure the Azure storage blob exists in case of scriptUri, and managed identity has been given access to blob's container with 'Storage Blob Data Reader' role assignment with scriptUri blob and 'Storage Blob Data Contributor' for Append blobs(outputBlobUri, errorBlobUri). In case of user assigned identity, make sure you add it under VM's identity. For more info on managed identity and Run Command, refer https://aka.ms/ManagedIdentity and https://aka.ms/RunCommandManaged.` |
| `definitions.WindowsParameters.properties.classificationsToInclude.items['x-ms-enum'].name` | `VMGuestPatchClassification_Windows` | `VMGuestPatchClassificationWindows` |
| `info.description` | `Azure Arc( Servers and K8s Clusters) API reference for Private Link's Scopes management.` | `The Hybrid Compute Management Client.` |
| `paths['/providers/microsoft.HybridCompute/operations'].get.responses.200.schema.$ref` | `#/definitions/OperationListResult` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/OperationListResult` |
| `paths['/providers/microsoft.HybridCompute/osType/{osType}/agentVersions'].get.description` | `Gets all Agent Versions along with the download link currently present.` | `Gets all agent versions based on location and publisher` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/gateways'].get.responses.200.schema.$ref` | `#/definitions/GatewaysListResult` | `#/definitions/GatewayListResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/licenses'].get.responses.200.schema.$ref` | `#/definitions/LicensesListResult` | `#/definitions/LicenseListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/gateways'].get.responses.200.schema.$ref` | `#/definitions/GatewaysListResult` | `#/definitions/GatewayListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/gateways/{gatewayName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/gateways/{gatewayName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `The URI to poll for completion status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/gateways/{gatewayName}'].put.responses.201.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/gateways/{gatewayName}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `The URI to poll for completion status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/licenses'].get.responses.200.schema.$ref` | `#/definitions/LicensesListResult` | `#/definitions/LicenseListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `The URI to poll for completion status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/addExtensions'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/addExtensions'].post.responses.202.headers['Azure-AsyncOperation'].description` | `The URI to poll for completion status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/extensions'].get.responses.200.schema.$ref` | `#/definitions/MachineExtensionsListResult` | `#/definitions/MachineExtensionListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/extensions/{extensionName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/extensions/{extensionName}'].patch.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/licenseProfiles'].get.responses.200.schema.$ref` | `#/definitions/LicenseProfilesListResult` | `#/definitions/LicenseProfileListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/providers/microsoft.HybridCompute/networkConfigurations/current'].patch.parameters[1].name` | `parameters` | `properties` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/providers/microsoft.HybridCompute/networkConfigurations/current'].put.parameters[1].name` | `parameters` | `resource` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands'].get.parameters[0].pattern` | `[a-zA-Z0-9-_\\.]+` | `^[a-zA-Z0-9-_\\.]{1,54}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands'].get.responses.200.schema.$ref` | `#/definitions/MachineRunCommandsListResult` | `#/definitions/MachineRunCommandListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].delete.parameters[0].pattern` | `[a-zA-Z0-9-_\\.]+` | `^[a-zA-Z0-9-_\\.]{1,54}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].get.parameters[0].pattern` | `[a-zA-Z0-9-_\\.]+` | `^[a-zA-Z0-9-_\\.]{1,54}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].patch.description` | `The operation to update the run command.` | `The operation to update a run command.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].patch.parameters[0].pattern` | `[a-zA-Z0-9-_\\.]+` | `^[a-zA-Z0-9-_\\.]{1,54}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].patch.parameters[2].name` | `runCommandProperties` | `properties` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].patch.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].put.parameters[0].pattern` | `[a-zA-Z0-9-_\\.]+` | `^[a-zA-Z0-9-_\\.]{1,54}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `The URI to poll for completion status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/upgradeExtensions'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{name}/assessPatches'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{name}/installPatches'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}/networkSecurityPerimeterConfigurations/{perimeterName}/reconcile'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |

