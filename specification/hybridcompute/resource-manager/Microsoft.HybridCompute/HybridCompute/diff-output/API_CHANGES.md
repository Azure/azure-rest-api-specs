## Changed Paths

Path: /subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/locations/{location}/publishers/{publisher}/extensionTypes/{extensionType}/versions
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/locations/{location}/publishers/{publisher}/extensionTypes/{extensionType}/versions/{version}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/versions
Change Type: added

Path: /subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/versions/{version}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{baseProvider}/{baseResourceType}/{baseResourceName}/providers/microsoft.HybridCompute/settings/{settingsResourceName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/{name}/assessPatches
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/{name}/installPatches
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/current
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/hybridIdentityMetadata
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/hybridIdentityMetadata/{metadataName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/licenseProfiles/{licenseProfileName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/licenseProfiles/default
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/privateLinkScopes/current
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/providers/microsoft.HybridCompute/networkConfigurations/current
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{name}/assessPatches
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{name}/installPatches
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/settings/{settingsResourceName}/{baseResourceType}
Change Type: added

## Swagger Changes

### Changes for `x-ms-code-generation-settings`

| Path | Change Type | Value |
|------|------------|-------|
| `info['x-ms-code-generation-settings__deleted']` | deleted | `{"name":"HybridComputeManagementClient"}` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/locations/{location}/publishers/{publisher}/extensionTypes/{extensionType}/versions`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/locations/{location}/publishers/{publisher}/extensionTypes/{extensionType}/versions__deleted']` | deleted | `{"get":{"operationId":"ExtensionMetadata_List","tags":["extensions"],"parameters":[{"name":"location...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/locations/{location}/publishers/{publisher}/extensionTypes/{extensionType}/versions/{version}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/locations/{location}/publishers/{publisher}/extensionTypes/{extensionType}/versions/{version}__deleted']` | deleted | `{"get":{"operationId":"ExtensionMetadata_Get","tags":["extensions"],"parameters":[{"name":"location"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{baseProvider}/{baseResourceType}/{baseResourceName}/providers/microsoft.HybridCompute/settings/{settingsResourceName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{baseProvider}/{baseResourceType}/{baseResourceName}/providers/microsoft.HybridCompute/settings/{settingsResourceName}__deleted']` | deleted | `{"get":{"operationId":"Settings_Get","tags":["Settings"],"parameters":[{"name":"baseProvider","in":"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{name}/assessPatches`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{name}/assessPatches__deleted']` | deleted | `{"post":{"operationId":"Machines_AssessPatches","tags":["machines"],"parameters":[{"name":"name","in...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/hybridIdentityMetadata`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/hybridIdentityMetadata__deleted']` | deleted | `{"get":{"operationId":"HybridIdentityMetadata_ListByMachines","tags":["HybridIdentityMetadata"],"par...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/hybridIdentityMetadata/{metadataName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/hybridIdentityMetadata/{metadataName}__deleted']` | deleted | `{"get":{"operationId":"HybridIdentityMetadata_Get","tags":["HybridIdentityMetadata"],"parameters":[{...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{name}/installPatches`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{name}/installPatches__deleted']` | deleted | `{"post":{"operationId":"Machines_InstallPatches","tags":["machines"],"parameters":[{"name":"name","i...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/licenseProfiles/{licenseProfileName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/licenseProfiles/{licenseProfileName}__deleted']` | deleted | `{"get":{"operationId":"LicenseProfiles_Get","tags":["licenseProfiles"],"parameters":[{"name":"machin...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/privateLinkScopes/current`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/privateLinkScopes/current__deleted']` | deleted | `{"get":{"operationId":"PrivateLinkScopes_GetValidationDetailsForMachine","parameters":[{"name":"mach...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/providers/microsoft.HybridCompute/networkConfigurations/current`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/providers/microsoft.HybridCompute/networkConfigurations/current__deleted']` | deleted | `{"get":{"operationId":"NetworkConfigurations_Get","tags":["NetworkConfigurations"],"parameters":[{"n...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/versions`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/versions__added']` | added | `{"get":{"operationId":"ExtensionMetadata_List","tags":["ExtensionValues"],"parameters":[],"responses...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/versions/{version}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/versions/{version}__added']` | added | `{"get":{"operationId":"ExtensionMetadata_Get","tags":["ExtensionValues"],"parameters":[{"name":"vers...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/{name}/assessPatches`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/{name}/assessPatches__added']` | added | `{"post":{"operationId":"Machines_AssessPatches","tags":["Machines"],"parameters":[{"name":"machineNa...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/{name}/installPatches`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/{name}/installPatches__added']` | added | `{"post":{"operationId":"Machines_InstallPatches","tags":["Machines"],"parameters":[{"name":"machineN...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/current`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/current__added']` | added | `{"get":{"operationId":"PrivateLinkScopes_GetValidationDetailsForMachine","tags":["Machines"],"parame...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/licenseProfiles/default`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/licenseProfiles/default__added']` | added | `{"get":{"operationId":"LicenseProfiles_Get","tags":["LicenseProfiles"],"parameters":[{"name":"machin...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/settings/{settingsResourceName}/{baseResourceType}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/settings/{settingsResourceName}/{baseResourceType}__added']` | added | `{"get":{"operationId":"Settings_Get","tags":["SettingsOperationGroup"],"parameters":[{"name":"settin...` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.HybridCompute/locations/{location}/publishers'].get.tags__deleted` | deleted | `["extensions"]` |
| `paths['/providers/microsoft.HybridCompute/locations/{location}/publishers/{publisher}/extensionTypes'].get.tags__deleted` | deleted | `["extensions"]` |
| `paths['/providers/microsoft.HybridCompute/osType/{osType}/agentVersions'].get.tags__deleted` | deleted | `["AgentVersions"]` |
| `paths['/providers/microsoft.HybridCompute/osType/{osType}/agentVersions/{version}'].get.tags__deleted` | deleted | `["AgentVersions"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/privateLinkScopes'].get.tags__added` | added | `["HybridComputePrivateLinkScopes"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/validateLicense'].post.tags__deleted` | deleted | `["licenses"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes'].get.tags__added` | added | `["HybridComputePrivateLinkScopes"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}'].delete.tags__added` | added | `["HybridComputePrivateLinkScopes"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}'].get.tags__added` | added | `["HybridComputePrivateLinkScopes"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}'].patch.tags__added` | added | `["HybridComputePrivateLinkScopes"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}'].put.tags__added` | added | `["HybridComputePrivateLinkScopes"]` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterConfiguration.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
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
| `definitions.NetworkSecurityPerimeterConfiguration.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands'].get.parameters[0].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].delete.parameters[0].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].get.parameters[0].minLength__added` | added | `1` |
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

### Changes for `202`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/validateLicense'].post.responses.202__added` | added | `{"description":"ignore","headers":{"Location":{"type":"string","description":"The Location header co...` |

### Changes for `Azure-AsyncOperation`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/gateways/{gatewayName}'].delete.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/gateways/{gatewayName}'].put.responses.201.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}'].delete.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/addExtensions'].post.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/extensions/{extensionName}'].delete.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/extensions/{extensionName}'].patch.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].delete.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/upgradeExtensions'].post.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}'].delete.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}/networkSecurityPerimeterConfigurations/{perimeterName}/reconcile'].post.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"The URI to poll for completion status."}` |

### Changes for `x-ms-long-running-operation`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/licenses/{licenseName}'].delete['x-ms-long-running-operation__deleted']` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/licenses/{licenseName}'].patch['x-ms-long-running-operation__deleted']` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/licenses/{licenseName}'].put['x-ms-long-running-operation__deleted']` | deleted | `true` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/extensions/{extensionName}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |

### Changes for `maxLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands'].get.parameters[0].maxLength__added` | added | `54` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].delete.parameters[0].maxLength__added` | added | `54` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].get.parameters[0].maxLength__added` | added | `54` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].put.parameters[0].maxLength__added` | added | `54` |

### Changes for `patch`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].patch__deleted` | deleted | `{"operationId":"MachineRunCommands_Update","tags":["MachineRunCommands"],"parameters":[{"name":"mach...` |

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
| `definitions.DetectedProperties__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"},"readOnly":true}` |

### Changes for `ExtensionTarget`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExtensionTarget__deleted` | deleted | `{"type":"object","additionalProperties":{"$ref":"#/definitions/ExtensionTargetProperties","type":"ob...` |

### Changes for `GatewaysListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GatewaysListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `HybridIdentityMetadata`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HybridIdentityMetadata__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/HybridIdentityMetadataProperties"...` |

### Changes for `HybridIdentityMetadataList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HybridIdentityMetadataList__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"nextLink":{...` |

### Changes for `HybridIdentityMetadataProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HybridIdentityMetadataProperties__deleted` | deleted | `{"type":"object","properties":{"vmId":{"type":"string"},"publicKey":{"type":"string"},"identity":{"$...` |

### Changes for `KeyDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.KeyDetails__deleted` | deleted | `{"type":"object","properties":{"publicKey":{"type":"string","readOnly":true},"notAfter":{"type":"str...` |

### Changes for `KeyProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.KeyProperties__deleted` | deleted | `{"type":"object","properties":{"clientPublicKey":{"$ref":"#/definitions/KeyDetails","readOnly":true}...` |

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

### Changes for `NetworkConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkConfiguration__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/NetworkConfigurationProperties","...` |

### Changes for `NetworkConfigurationProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkConfigurationProperties__deleted` | deleted | `{"type":"object","properties":{"location":{"type":"string","x-ms-mutability":["create","read"]},"ten...` |

### Changes for `OperationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationListResult__deleted` | deleted | `{"type":"object","properties":{"value":{"type":"array","items":{"$ref":"#/definitions/OperationValue...` |

### Changes for `OperationValue`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationValue__deleted` | deleted | `{"type":"object","properties":{"origin":{"type":"string","readOnly":true},"name":{"type":"string","r...` |

### Changes for `OperationValueDisplay`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationValueDisplay__deleted` | deleted | `{"type":"object","properties":{"operation":{"type":"string","readOnly":true},"resource":{"type":"str...` |

### Changes for `PrivateLinkScopesResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateLinkScopesResource__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string","readOnly":true},"name":{"type":"string","readO...` |

### Changes for `TargetVersion`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TargetVersion__deleted` | deleted | `{"type":"string"}` |

### Changes for `Azure.ResourceManager.ArmResponse<MachineAssessPatchesResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<MachineAssessPatchesResult>__added']` | added | `{"type":"object","properties":{"body":{"$ref":"#/definitions/MachineAssessPatchesResult"}},"required...` |

### Changes for `Azure.ResourceManager.ArmResponse<MachineInstallPatchesResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<MachineInstallPatchesResult>__added']` | added | `{"type":"object","properties":{"body":{"$ref":"#/definitions/MachineInstallPatchesResult"}},"require...` |

### Changes for `Azure.ResourceManager.ArmResponse<NetworkSecurityPerimeterConfigurationReconcileResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<NetworkSecurityPerimeterConfigurationReconcileResult>__added']` | added | `{"type":"object","properties":{"body":{"$ref":"#/definitions/NetworkSecurityPerimeterConfigurationRe...` |

### Changes for `Azure.ResourceManager.ArmResponse<SetupExtensionRequest>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<SetupExtensionRequest>__added']` | added | `{"type":"object","properties":{"body":{"$ref":"#/definitions/SetupExtensionRequest"}},"required":["b...` |

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
| `definitions.LicenseProfileMachineInstanceViewSoftwareAssurance__added` | added | `{"type":"object","properties":{"softwareAssuranceCustomer":{"type":"boolean"}}}` |

### Changes for `LicenseProfileProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LicenseProfileProperties__added` | added | `{"type":"object","properties":{"softwareAssurance":{"$ref":"#/definitions/LicenseProfilePropertiesSo...` |

### Changes for `LicenseProfilePropertiesSoftwareAssurance`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LicenseProfilePropertiesSoftwareAssurance__added` | added | `{"type":"object","properties":{"softwareAssuranceCustomer":{"type":"boolean"}}}` |

### Changes for `LicenseProfileUpdateProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LicenseProfileUpdateProperties__added` | added | `{"type":"object","properties":{"softwareAssurance":{"$ref":"#/definitions/LicenseProfileUpdateProper...` |

### Changes for `LicenseProfileUpdatePropertiesSoftwareAssurance`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LicenseProfileUpdatePropertiesSoftwareAssurance__added` | added | `{"type":"object","properties":{"softwareAssuranceCustomer":{"type":"boolean"}}}` |

### Changes for `LicenseUpdatePropertiesLicenseDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LicenseUpdatePropertiesLicenseDetails__added` | added | `{"type":"object","properties":{"state":{"type":"string","enum":["Activated","Deactivated"],"x-ms-enu...` |

### Changes for `MachineExtensionInstanceViewStatus`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MachineExtensionInstanceViewStatus__added` | added | `{"type":"object","properties":{"code":{"type":"string"},"level":{"type":"string","enum":["Info","War...` |

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
| `definitions.OSProfileLinuxConfiguration__added` | added | `{"type":"object","properties":{"patchSettings":{"$ref":"#/definitions/PatchSettings","x-ms-client-fl...` |

### Changes for `OSProfileWindowsConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OSProfileWindowsConfiguration__added` | added | `{"type":"object","properties":{"patchSettings":{"$ref":"#/definitions/PatchSettings","x-ms-client-fl...` |

### Changes for `PatchSettingsStatus`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PatchSettingsStatus__added` | added | `{"type":"object","properties":{"hotpatchEnablementStatus":{"type":"string","enum":["Unknown","Pendin...` |

### Changes for `TypeSpec.Http.OkResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['TypeSpec.Http.OkResponse__added']` | added | `{"type":"object"}` |

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

### Changes for `x-ms-identifiers`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AgentVersionsList.properties.value['x-ms-identifiers__deleted']` | deleted | `["agentVersion"]` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HybridComputePrivateLinkScope.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v3/types.json#/definitions/systemData","...` |
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
| `definitions.NetworkSecurityPerimeterConfiguration.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |

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
| `definitions.ExtensionValueV2.allOf[0].$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.HybridComputePrivateLinkScope.allOf[0].$ref` | `#/definitions/PrivateLinkScopesResource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.LinuxParameters.properties.classificationsToInclude.items['x-ms-enum'].name` | `VMGuestPatchClassification_Linux` | `VMGuestPatchClassificationLinux` |
| `definitions.Machine.properties.kind['x-ms-enum'].name` | `ArcKindEnum ` | `ArcKindEnum` |
| `definitions.MachineUpdate.properties.kind['x-ms-enum'].name` | `ArcKindEnum ` | `ArcKindEnum` |
| `definitions.WindowsParameters.properties.classificationsToInclude.items['x-ms-enum'].name` | `VMGuestPatchClassification_Windows` | `VMGuestPatchClassificationWindows` |
| `info.description` | `Azure Arc( Servers and K8s Clusters) API reference for Private Link's Scopes management.` | `The Hybrid Compute Management Client.` |
| `paths['/providers/microsoft.HybridCompute/operations'].get.responses.200.schema.$ref` | `#/definitions/OperationListResult` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/OperationListResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/gateways'].get.responses.200.schema.$ref` | `#/definitions/GatewaysListResult` | `#/definitions/GatewayListResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/licenses'].get.responses.200.schema.$ref` | `#/definitions/LicensesListResult` | `#/definitions/LicenseListResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.HybridCompute/validateLicense'].post.parameters[0].name` | `parameters` | `body` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/gateways'].get.responses.200.schema.$ref` | `#/definitions/GatewaysListResult` | `#/definitions/GatewayListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/gateways/{gatewayName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/gateways/{gatewayName}'].put.responses.201.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/licenses'].get.responses.200.schema.$ref` | `#/definitions/LicensesListResult` | `#/definitions/LicenseListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/addExtensions'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/extensions'].get.responses.200.schema.$ref` | `#/definitions/MachineExtensionsListResult` | `#/definitions/MachineExtensionListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/extensions/{extensionName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/extensions/{extensionName}'].patch.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/licenseProfiles'].get.responses.200.schema.$ref` | `#/definitions/LicenseProfilesListResult` | `#/definitions/LicenseProfileListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands'].get.parameters[0].pattern` | `[a-zA-Z0-9-_\\.]+` | `^[a-zA-Z0-9-_\\.]{1,54}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands'].get.responses.200.schema.$ref` | `#/definitions/MachineRunCommandsListResult` | `#/definitions/MachineRunCommandListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].delete.parameters[0].pattern` | `[a-zA-Z0-9-_\\.]+` | `^[a-zA-Z0-9-_\\.]{1,54}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].get.parameters[0].pattern` | `[a-zA-Z0-9-_\\.]+` | `^[a-zA-Z0-9-_\\.]{1,54}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].put.parameters[0].pattern` | `[a-zA-Z0-9-_\\.]+` | `^[a-zA-Z0-9-_\\.]{1,54}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `The URI to poll for completion status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/upgradeExtensions'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}/networkSecurityPerimeterConfigurations/{perimeterName}/reconcile'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/privateLinkScopes/{scopeName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |

