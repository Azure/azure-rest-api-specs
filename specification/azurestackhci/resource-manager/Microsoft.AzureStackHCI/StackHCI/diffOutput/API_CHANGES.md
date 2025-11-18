## Swagger Changes

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterProperties.properties.identityProvider.default__deleted` | deleted | `ActiveDirectory` |
| `definitions.ClusterReportedProperties.properties.hardwareClass.default__added` | added | `Medium` |
| `definitions.DeploymentCluster.properties.hardwareClass.default__added` | added | `Medium` |
| `definitions.DeploymentSecuritySettings.properties.credentialGuardEnforced.default__deleted` | deleted | `false` |
| `definitions.DeploymentSecuritySettings.properties.smbClusterEncryption.default__deleted` | deleted | `false` |
| `definitions.Observability.properties.euLocation.default__deleted` | deleted | `false` |
| `definitions.SecurityProperties.properties.securedCoreComplianceAssignment.default__deleted` | deleted | `Audit` |
| `definitions.SecurityProperties.properties.smbEncryptionForIntraClusterTrafficComplianceAssignment.default__deleted` | deleted | `Audit` |
| `definitions.SecurityProperties.properties.wdacComplianceAssignment.default__deleted` | deleted | `Audit` |
| `paths['/{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}'].delete.parameters[1].default__deleted` | deleted | `default` |
| `paths['/{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}'].get.parameters[1].default__deleted` | deleted | `default` |
| `paths['/{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}'].put.parameters[1].default__deleted` | deleted | `default` |
| `paths['/{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}/validate'].post.parameters[1].default__deleted` | deleted | `default` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/deploymentSettings/{deploymentSettingsName}'].delete.parameters[1].default__deleted` | deleted | `default` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/deploymentSettings/{deploymentSettingsName}'].get.parameters[1].default__deleted` | deleted | `default` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/deploymentSettings/{deploymentSettingsName}'].put.parameters[1].default__deleted` | deleted | `default` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/securitySettings/{securitySettingsName}'].delete.parameters[1].default__deleted` | deleted | `default` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/securitySettings/{securitySettingsName}'].get.parameters[1].default__deleted` | deleted | `default` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/securitySettings/{securitySettingsName}'].put.parameters[1].default__deleted` | deleted | `default` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}'].delete.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"},"Location":{"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/createArcIdentity'].post.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"},"Location":{"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}'].delete.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"},"Location":{"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}'].patch.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}/upgrade'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/initializeDisableProcess'].post.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"},"Location":{"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/reconcile'].post.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"},"Location":{"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/createClusterIdentity'].post.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"},"Location":{"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/deploymentSettings/{deploymentSettingsName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/extendSoftwareAssuranceBenefit'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/securitySettings/{securitySettingsName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/uploadCertificate'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |

### Changes for `x-ms-long-running-operation-options`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}'].put['x-ms-long-running-operation-options__added']` | added | `{"final-state-via":"original-uri"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}'].delete['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}'].put['x-ms-long-running-operation-options__added']` | added | `{"final-state-via":"original-uri"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}'].delete['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}'].patch['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"original-uri"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}/upgrade'].post['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/initializeDisableProcess'].post['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}'].delete['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}'].put['x-ms-long-running-operation-options__added']` | added | `{"final-state-via":"original-uri"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/apply'].post['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns/{updateRunName}'].delete['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns/{updateRunName}'].put['x-ms-long-running-operation-options__added']` | added | `{"final-state-via":"original-uri"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].delete['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].put['x-ms-long-running-operation-options__added']` | added | `{"final-state-via":"original-uri"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/uploadCertificate'].post['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |

### Changes for `x-ms-long-running-operation`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}'].put['x-ms-long-running-operation__added']` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}'].put['x-ms-long-running-operation__added']` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}'].put['x-ms-long-running-operation__added']` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns/{updateRunName}'].put['x-ms-long-running-operation__added']` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].put['x-ms-long-running-operation__added']` | added | `true` |

### Changes for `201`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}'].put.responses.201__added` | added | `{"description":"ignore","schema":{"$ref":"#/definitions/Cluster"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}'].put.responses.201__added` | added | `{"description":"ignore","schema":{"$ref":"#/definitions/ArcSetting"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}'].put.responses.201__added` | added | `{"description":"ignore","schema":{"$ref":"#/definitions/Update"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns/{updateRunName}'].put.responses.201__added` | added | `{"description":"ignore","schema":{"$ref":"#/definitions/UpdateRun"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].put.responses.201__added` | added | `{"description":"ignore","schema":{"$ref":"#/definitions/UpdateSummary"}}` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/changeRing'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/configureRemoteSupport'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/triggerLogCollection'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |

### Changes for `x-ms-pageable`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/offers'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |

### Changes for `Location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}'].delete.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/apply'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns/{updateRunName}'].delete.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].delete.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |

### Changes for `ClusterIdentityResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterIdentityResponse__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ClusterIdentityResponseProperties...` |

### Changes for `DeploymentData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentData__deleted` | deleted | `{"type":"object","properties":{"securitySettings":{"$ref":"#/definitions/DeploymentSecuritySettings"...` |

### Changes for `ErrorDetail`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorDetail__deleted` | deleted | `{"type":"object","properties":{"exception":{"type":"string","readOnly":true}}}` |

### Changes for `ExtensionParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExtensionParameters__deleted` | deleted | `{"type":"object","properties":{"forceUpdateTag":{"type":"string"},"publisher":{"type":"string"},"typ...` |

### Changes for `ExtensionPatchParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExtensionPatchParameters__deleted` | deleted | `{"type":"object","properties":{"typeHandlerVersion":{"type":"string"},"enableAutomaticUpgrade":{"typ...` |

### Changes for `HostNetwork`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HostNetwork__deleted` | deleted | `{"type":"object","properties":{"intents":{"type":"array","items":{"$ref":"#/definitions/Intents"},"x...` |

### Changes for `Intents`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Intents__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"trafficType":{"type":"array","items":{"type...` |

### Changes for `LogCollectionJobSession`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogCollectionJobSession__deleted` | deleted | `{"type":"object","properties":{"startTime":{"type":"string","readOnly":true},"endTime":{"type":"stri...` |

### Changes for `RemoteSupportJobNodeSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RemoteSupportJobNodeSettings__deleted` | deleted | `{"type":"object","properties":{"state":{"type":"string","readOnly":true},"createdAt":{"type":"string...` |

### Changes for `RemoteSupportJobReportedProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RemoteSupportJobReportedProperties__deleted` | deleted | `{"type":"object","properties":{"percentComplete":{"type":"integer","format":"int32","readOnly":true}...` |

### Changes for `RemoteSupportNodeSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RemoteSupportNodeSettings__deleted` | deleted | `{"type":"object","properties":{"arcResourceId":{"type":"string","readOnly":true},"state":{"type":"st...` |

### Changes for `StorageAdapterIPInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StorageAdapterIPInfo__deleted` | deleted | `{"type":"object","properties":{"physicalNode":{"type":"string"},"ipv4Address":{"type":"string"},"sub...` |

### Changes for `StorageNetworks`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StorageNetworks__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"networkAdapterName":{"type":"string"},"vlan...` |

### Changes for `UpdateSummaries`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpdateSummaries__deleted` | deleted | `{"type":"object","properties":{"location":{"type":"string","x-ms-mutability":["create","read"]},"pro...` |

### Changes for `VirtualSwitchConfigurationOverrides`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualSwitchConfigurationOverrides__deleted` | deleted | `{"type":"object","properties":{"enableIov":{"type":"string"},"loadBalancingAlgorithm":{"type":"strin...` |

### Changes for `AzureLinuxEdgeDeviceJob`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureLinuxEdgeDeviceJob__added` | added | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/AzureLinuxEdgeDeviceJobProperties...` |

### Changes for `AzureLinuxEdgeDeviceJobProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureLinuxEdgeDeviceJobProperties__added` | added | `{"type":"object","properties":{"deploymentMode":{"type":"string","enum":["Validate","Deploy"],"x-ms-...` |

### Changes for `AzureLinuxRemoteSupportJobProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureLinuxRemoteSupportJobProperties__added` | added | `{"type":"object","properties":{"accessLevel":{"type":"string","enum":["None","Diagnostics","Diagnost...` |

### Changes for `ClusterWitnessProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterWitnessProperties__added` | added | `{"type":"object","properties":{"authenticationMode":{"type":"string","readOnly":true}}}` |

### Changes for `ClustersLogCollectionSession`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClustersLogCollectionSession__added` | added | `{"type":"object","properties":{"logStartTime":{"type":"string","format":"date-time","readOnly":true}...` |

### Changes for `ClustersRemoteSupportNodeSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClustersRemoteSupportNodeSettings__added` | added | `{"type":"object","properties":{"arcResourceId":{"type":"string","readOnly":true},"state":{"type":"st...` |

### Changes for `DeploymentAdapterPropertyOverrides`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentAdapterPropertyOverrides__added` | added | `{"type":"object","properties":{"jumboPacket":{"type":"string"},"networkDirect":{"type":"string"},"ne...` |

### Changes for `DeploymentDataContent`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentDataContent__added` | added | `{"type":"object","properties":{"securitySettings":{"$ref":"#/definitions/DeploymentSecuritySettings"...` |

### Changes for `DeploymentHostNetwork`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentHostNetwork__added` | added | `{"type":"object","properties":{"intents":{"type":"array","items":{"$ref":"#/definitions/DeploymentIn...` |

### Changes for `DeploymentIntents`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentIntents__added` | added | `{"type":"object","properties":{"name":{"type":"string"},"trafficType":{"type":"array","items":{"type...` |

### Changes for `DeploymentSettingsHostNetwork`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentSettingsHostNetwork__added` | added | `{"type":"object","properties":{"intents":{"type":"array","items":{"$ref":"#/definitions/DeploymentSe...` |

### Changes for `DeploymentSettingsIntents`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentSettingsIntents__added` | added | `{"type":"object","properties":{"name":{"type":"string"},"trafficType":{"type":"array","items":{"type...` |

### Changes for `DeploymentSettingsStorageAdapterIPInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentSettingsStorageAdapterIPInfo__added` | added | `{"type":"object","properties":{"physicalNode":{"type":"string"},"ipv4Address":{"type":"string"},"sub...` |

### Changes for `DeploymentSettingsStorageNetworks`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentSettingsStorageNetworks__added` | added | `{"type":"object","properties":{"name":{"type":"string"},"networkAdapterName":{"type":"string"},"vlan...` |

### Changes for `DeploymentSettingsVirtualSwitchConfigurationOverrides`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentSettingsVirtualSwitchConfigurationOverrides__added` | added | `{"type":"object","properties":{"enableIov":{"type":"string"},"loadBalancingAlgorithm":{"type":"strin...` |

### Changes for `DeploymentStorageAdapterIPInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentStorageAdapterIPInfo__added` | added | `{"type":"object","properties":{"physicalNode":{"type":"string"},"ipv4Address":{"type":"string"},"sub...` |

### Changes for `DeploymentStorageNetworks`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentStorageNetworks__added` | added | `{"type":"object","properties":{"name":{"type":"string"},"networkAdapterName":{"type":"string"},"vlan...` |

### Changes for `DeploymentVirtualSwitchConfigurationOverrides`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentVirtualSwitchConfigurationOverrides__added` | added | `{"type":"object","properties":{"enableIov":{"type":"string"},"loadBalancingAlgorithm":{"type":"strin...` |

### Changes for `EdgeDeviceErrorDetail`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDeviceErrorDetail__added` | added | `{"type":"object","properties":{"exception":{"type":"string","readOnly":true}}}` |

### Changes for `EdgeDeviceJobsEceActionStatus`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDeviceJobsEceActionStatus__added` | added | `{"type":"object","properties":{"status":{"type":"string","readOnly":true},"steps":{"type":"array","i...` |

### Changes for `EdgeDeviceJobsLogCollectionSession`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDeviceJobsLogCollectionSession__added` | added | `{"type":"object","properties":{"startTime":{"type":"string","readOnly":true},"endTime":{"type":"stri...` |

### Changes for `EdgeDeviceJobsRemoteSupportNodeSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDeviceJobsRemoteSupportNodeSettings__added` | added | `{"type":"object","properties":{"state":{"type":"string","readOnly":true},"createdAt":{"type":"string...` |

### Changes for `EdgeDeviceJobsStep`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDeviceJobsStep__added` | added | `{"type":"object","properties":{"name":{"type":"string","readOnly":true},"description":{"type":"strin...` |

### Changes for `EdgeDevicesAdapterPropertyOverrides`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDevicesAdapterPropertyOverrides__added` | added | `{"type":"object","properties":{"jumboPacket":{"type":"string","readOnly":true},"networkDirect":{"typ...` |

### Changes for `EdgeDevicesExtension`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDevicesExtension__added` | added | `{"type":"object","properties":{"extensionName":{"type":"string","readOnly":true},"state":{"type":"st...` |

### Changes for `EdgeDevicesHostNetwork`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDevicesHostNetwork__added` | added | `{"type":"object","properties":{"intents":{"type":"array","items":{"$ref":"#/definitions/EdgeDevicesI...` |

### Changes for `EdgeDevicesIntents`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDevicesIntents__added` | added | `{"type":"object","properties":{"scope":{"type":"integer","format":"int64","readOnly":true},"intentTy...` |

### Changes for `EdgeDevicesStorageAdapterIPInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDevicesStorageAdapterIPInfo__added` | added | `{"type":"object","properties":{"physicalNode":{"type":"string","readOnly":true},"ipv4Address":{"type...` |

### Changes for `EdgeDevicesStorageNetworks`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDevicesStorageNetworks__added` | added | `{"type":"object","properties":{"name":{"type":"string","readOnly":true},"networkAdapterName":{"type"...` |

### Changes for `EdgeDevicesVirtualSwitchConfigurationOverrides`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDevicesVirtualSwitchConfigurationOverrides__added` | added | `{"type":"object","properties":{"enableIov":{"type":"string","readOnly":true},"loadBalancingAlgorithm...` |

### Changes for `ExtensionInstanceViewStatus`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExtensionInstanceViewStatus__added` | added | `{"type":"object","properties":{"code":{"type":"string"},"level":{"type":"string","enum":["Info","War...` |

### Changes for `ExtensionParametersContent`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExtensionParametersContent__added` | added | `{"type":"object","properties":{"forceUpdateTag":{"type":"string"},"publisher":{"type":"string"},"typ...` |

### Changes for `IpAddressRange`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IpAddressRange__added` | added | `{"type":"object","properties":{"startIp":{"type":"string"},"endIp":{"type":"string"}},"required":["e...` |

### Changes for `NetworkAdapter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkAdapter__added` | added | `{"type":"object","properties":{"ipAssignmentType":{"type":"string","enum":["Automatic","Manual"],"x-...` |

### Changes for `NetworkConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkConfiguration__added` | added | `{"type":"object","properties":{"networkAdapters":{"type":"array","items":{"$ref":"#/definitions/Netw...` |

### Changes for `PrecheckResultTags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrecheckResultTags__added` | added | `{"type":"object","properties":{"key":{"type":"string"},"value":{"type":"string"}}}` |

### Changes for `ProvisionOsReportedProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ProvisionOsReportedProperties__added` | added | `{"type":"object","properties":{"percentComplete":{"type":"integer","format":"int32","readOnly":true}...` |

### Changes for `RemoteSupportReportedProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RemoteSupportReportedProperties__added` | added | `{"type":"object","properties":{"percentComplete":{"type":"integer","format":"int32","readOnly":true}...` |

### Changes for `StackHCIHciExtensionPatchParametersContent`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StackHCIHciExtensionPatchParametersContent__added` | added | `{"type":"object","properties":{"typeHandlerVersion":{"type":"string"},"enableAutomaticUpgrade":{"typ...` |

### Changes for `StackHciClusterIdentityResponseResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StackHciClusterIdentityResponseResult__added` | added | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ClusterIdentityResponseProperties...` |

### Changes for `TimeConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TimeConfiguration__added` | added | `{"type":"object","properties":{"primaryTimeServer":{"type":"string"},"secondaryTimeServer":{"type":"...` |

### Changes for `UpdateRunsStep`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpdateRunsStep__added` | added | `{"type":"object","properties":{"name":{"type":"string"},"description":{"type":"string"},"errorMessag...` |

### Changes for `UpdateSummary`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpdateSummary__added` | added | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/UpdateSummariesProperties"},"loca...` |

### Changes for `WebProxyConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebProxyConfiguration__added` | added | `{"type":"object","properties":{"connectionUri":{"type":"string"},"port":{"type":"string"},"bypassLis...` |

### Changes for `x-ms-client-flatten`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcIdentityResponse.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.ArcSetting.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.ArcSettingsPatch.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.Cluster.properties.identity['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.Cluster.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.ClusterPatch.properties.identity['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.ClusterPatch.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.DeploymentSetting.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.ExtensionPatch.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.ExtensionProperties.properties.extensionParameters['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.Offer.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.Publisher.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.SecuritySetting.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.Sku.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.Update.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.UpdateProperties.properties.componentVersions['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.UpdateProperties.properties.healthCheckResult['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.UpdateProperties.properties.healthState['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.UpdateProperties.properties.rebootRequired['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.UpdateProperties.properties.updateStateProperties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.UpdateRun.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.UpdateRunProperties.properties.progress['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.UpdateSummariesProperties.properties.healthCheckResult['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.UpdateSummariesProperties.properties.healthState['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.UpdateSummariesProperties.properties.packageVersions['x-ms-client-flatten__deleted']` | deleted | `true` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcIdentityResponse.properties.properties.readOnly__added` | added | `true` |
| `definitions.ArcIdentityResponseProperties.readOnly__deleted` | deleted | `true` |
| `definitions.ArcSettingList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.ClusterIdentityResponseProperties.readOnly__deleted` | deleted | `true` |
| `definitions.ExtensionList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.OfferList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.PasswordCredential.readOnly__deleted` | deleted | `true` |
| `definitions.PrecheckResult.properties.status.readOnly__added` | added | `true` |
| `definitions.PublisherList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.SkuList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.Step.properties.description.readOnly__added` | added | `true` |
| `definitions.Step.properties.endTimeUtc.readOnly__added` | added | `true` |
| `definitions.Step.properties.name.readOnly__added` | added | `true` |
| `definitions.Step.properties.startTimeUtc.readOnly__added` | added | `true` |
| `definitions.Step.properties.status.readOnly__added` | added | `true` |
| `definitions.Step.properties.steps.readOnly__added` | added | `true` |
| `definitions.UpdateRunProperties.properties.state.readOnly__added` | added | `true` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcSettingList.required__added` | added | `["value"]` |
| `definitions.ClusterList.required__added` | added | `["value"]` |
| `definitions.ExtensionList.required__added` | added | `["value"]` |
| `definitions.OfferList.required__added` | added | `["value"]` |
| `definitions.PublisherList.required__added` | added | `["value"]` |
| `definitions.SkuList.required__added` | added | `["value"]` |
| `definitions.UpdateList.required__added` | added | `["value"]` |
| `definitions.UpdateRunList.required__added` | added | `["value"]` |
| `definitions.UpdateSummariesList.required__added` | added | `["value"]` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcSettingProperties.properties.tags__added` | added | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.ArcSettingsPatch.properties.tags__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.ArcSettingsPatchProperties.properties.tags__added` | added | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.Update.properties.tags__added` | added | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.UpdateRun.properties.tags__added` | added | `{"type":"object","additionalProperties":{"type":"string"}}` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcSettingProperties.properties.connectivityProperties.type__deleted` | deleted | `object` |
| `definitions.ArcSettingsPatchProperties.properties.connectivityProperties.type__deleted` | deleted | `object` |
| `definitions.ClusterProperties.properties.clusterPattern.type__added` | added | `string` |
| `definitions.ClusterReportedProperties.properties.hardwareClass.type__added` | added | `string` |
| `definitions.DeploymentCluster.properties.clusterPattern.type__added` | added | `string` |
| `definitions.DeploymentCluster.properties.hardwareClass.type__added` | added | `string` |
| `definitions.DeploymentSettingsProperties.properties.deploymentMode.type__added` | added | `string` |
| `definitions.DeploymentSettingsProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.EdgeDeviceJob.properties.kind.type__added` | added | `string` |
| `definitions.EdgeDeviceProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.ExtensionInstanceView.properties.status.type__deleted` | deleted | `object` |
| `definitions.PrecheckResult.properties.tags.type__deleted` | deleted | `object` |
| `definitions.Update.properties.properties.type__deleted` | deleted | `object` |
| `definitions.UpdateProperties.properties.updateStateProperties.type__deleted` | deleted | `object` |

### Changes for `items`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcSettingProperties.properties.connectivityProperties.items__deleted` | deleted | `{"$ref":"#/definitions/ArcConnectivityProperties"}` |
| `definitions.ArcSettingsPatchProperties.properties.connectivityProperties.items__deleted` | deleted | `{"$ref":"#/definitions/ArcConnectivityProperties"}` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcSettingProperties.properties.connectivityProperties.$ref__added` | added | `#/definitions/ArcConnectivityProperties` |
| `definitions.ArcSettingsPatchProperties.properties.connectivityProperties.$ref__added` | added | `#/definitions/ArcConnectivityProperties` |
| `definitions.ClusterProperties.properties.clusterPattern.$ref__deleted` | deleted | `./hciCommon.json#/definitions/ClusterPattern` |
| `definitions.ClusterReportedProperties.properties.hardwareClass.$ref__deleted` | deleted | `./hciCommon.json#/definitions/HardwareClass` |
| `definitions.DeploymentCluster.properties.clusterPattern.$ref__deleted` | deleted | `./hciCommon.json#/definitions/ClusterPattern` |
| `definitions.DeploymentCluster.properties.hardwareClass.$ref__deleted` | deleted | `./hciCommon.json#/definitions/HardwareClass` |
| `definitions.DeploymentSettingsProperties.properties.deploymentMode.$ref__deleted` | deleted | `./hciCommon.json#/definitions/DeploymentMode` |
| `definitions.DeploymentSettingsProperties.properties.provisioningState.$ref__deleted` | deleted | `./hciCommon.json#/definitions/ProvisioningState` |
| `definitions.EdgeDeviceJob.properties.kind.$ref__deleted` | deleted | `./hciCommon.json#/definitions/EdgeDeviceKind` |
| `definitions.EdgeDeviceProperties.properties.provisioningState.$ref__deleted` | deleted | `./hciCommon.json#/definitions/ProvisioningState` |
| `definitions.ExtensionInstanceView.properties.status.$ref__added` | added | `#/definitions/ExtensionInstanceViewStatus` |
| `definitions.PrecheckResult.properties.tags.$ref__added` | added | `#/definitions/PrecheckResultTags` |

### Changes for `kind`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Cluster.properties.kind__deleted` | deleted | `{"type":"string","pattern":"^[-\\\\w\\\\._,\\\\(\\\\\\\\\\\\)]+$","x-ms-mutability":["create","read"]}` |
| `definitions.HciEdgeDeviceJob.properties.kind__added` | added | `{"type":"string","enum":["HCI"],"x-ms-enum":{"modelAsString":false}}` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterNode.properties.coreCount.format__added` | added | `float` |
| `definitions.ClusterNode.properties.id.format__added` | added | `float` |
| `definitions.ClusterNode.properties.memoryInGiB.format__added` | added | `float` |
| `definitions.ClusterProperties.properties.trialDaysRemaining.format__added` | added | `float` |
| `definitions.LogCollectionSession.properties.timeCollected.format__deleted` | deleted | `date-time` |
| `definitions.Step.properties.endTimeUtc.format__deleted` | deleted | `date-time` |
| `definitions.Step.properties.startTimeUtc.format__deleted` | deleted | `date-time` |
| `definitions.UpdateProperties.properties.packageSizeInMb.format__added` | added | `float` |
| `definitions.UpdateStateProperties.properties.progressPercentage.format__added` | added | `float` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterProperties.properties.clusterPattern.enum__added` | added | `["Standard","RackAware"]` |
| `definitions.ClusterReportedProperties.properties.hardwareClass.enum__added` | added | `["Small","Medium","Large"]` |
| `definitions.DeploymentCluster.properties.clusterPattern.enum__added` | added | `["Standard","RackAware"]` |
| `definitions.DeploymentCluster.properties.hardwareClass.enum__added` | added | `["Small","Medium","Large"]` |
| `definitions.DeploymentSettingsProperties.properties.deploymentMode.enum__added` | added | `["Validate","Deploy"]` |
| `definitions.DeploymentSettingsProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Error","Succeeded","Failed","Canceled","Connected","Disconnected","Deleted","Creati...` |
| `definitions.EdgeDeviceJob.properties.kind.enum__added` | added | `["HCI","WindowsServer","WindowsIoT","AzureLinux","UbuntuLinux","AzureLinuxRoe"]` |
| `definitions.EdgeDeviceProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Error","Succeeded","Failed","Canceled","Connected","Disconnected","Deleted","Creati...` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterProperties.properties.clusterPattern['x-ms-enum__added']` | added | `{"name":"ClusterPattern","modelAsString":true}` |
| `definitions.ClusterReportedProperties.properties.hardwareClass['x-ms-enum__added']` | added | `{"name":"HardwareClass","modelAsString":true}` |
| `definitions.DeploymentCluster.properties.clusterPattern['x-ms-enum__added']` | added | `{"name":"ClusterPattern","modelAsString":true}` |
| `definitions.DeploymentCluster.properties.hardwareClass['x-ms-enum__added']` | added | `{"name":"HardwareClass","modelAsString":true}` |
| `definitions.DeploymentSettingsProperties.properties.deploymentMode['x-ms-enum__added']` | added | `{"name":"DeploymentMode","modelAsString":true}` |
| `definitions.DeploymentSettingsProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.EdgeDeviceJob.properties.kind['x-ms-enum__added']` | added | `{"name":"EdgeDeviceKind","modelAsString":true}` |
| `definitions.EdgeDeviceProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |

### Changes for `customLocationId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterReportedProperties.properties.customLocationId__added` | added | `{"type":"string","readOnly":true}` |

### Changes for `witnessAuthenticationMode`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentCluster.properties.witnessAuthenticationMode__added` | added | `{"type":"string"}` |

### Changes for `x-ms-mutability`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentSetting.properties.properties['x-ms-mutability__deleted']` | deleted | `["create","read"]` |
| `definitions.SecuritySetting.properties.properties['x-ms-mutability__deleted']` | deleted | `["create","read"]` |

### Changes for `x-ms-identifiers`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EceActionStatus.properties.steps['x-ms-identifiers__added']` | added | `["name"]` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDevice.properties.properties__added` | added | `{"type":"object"}` |
| `definitions.EdgeDeviceJob.properties.properties__added` | added | `{"$ref":"#/definitions/EdgeDeviceJobProperties"}` |
| `definitions.Extension.properties.properties__added` | added | `{"$ref":"#/definitions/ExtensionProperties"}` |
| `definitions.ExtensionInstanceView.properties.status.properties__deleted` | deleted | `{"code":{"type":"string","description":"The status code."},"level":{"type":"string","description":"T...` |
| `definitions.PrecheckResult.properties.tags.properties__deleted` | deleted | `{"key":{"type":"string","description":"Key that allow grouping/filtering individual tests."},"value"...` |

### Changes for `discriminator`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDeviceJob.discriminator__deleted` | deleted | `kind` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Extension.allOf__added` | added | `[{"$ref":"../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResourc...` |

### Changes for `extensionName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Extension.properties.extensionName__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `state`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Extension.properties.state__deleted` | deleted | `{"type":"string","enum":["NotSpecified","Succeeded","Failed","Canceled","Accepted","Creating","Updat...` |

### Changes for `errorDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Extension.properties.errorDetails__deleted` | deleted | `{"type":"array","items":{"$ref":"#/definitions/ErrorDetail"},"readOnly":true}` |

### Changes for `extensionResourceId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Extension.properties.extensionResourceId__deleted` | deleted | `{"type":"string","format":"arm-id","readOnly":true}` |

### Changes for `typeHandlerVersion`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Extension.properties.typeHandlerVersion__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `managedBy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Extension.properties.managedBy__deleted` | deleted | `{"type":"string","default":"Azure","enum":["User","Azure"],"x-ms-enum":{"name":"ExtensionManagedBy",...` |

### Changes for `x-ms-discriminator-value`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HciEdgeDeviceJob['x-ms-discriminator-value__deleted']` | deleted | `HCI` |

### Changes for `scopes`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IsolatedVmAttestationConfiguration.properties.attestationResourceId['x-ms-arm-id-details'].allowedResources[0].scopes__deleted` | deleted | `["Tenant"]` |

### Changes for `localAvailabilityZoneMode`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LocalAvailabilityZones.properties.localAvailabilityZoneMode__added` | added | `{"type":"string","enum":["Active","Passive"],"x-ms-enum":{"name":"LocalAvailabilityZoneMode","modelA...` |

### Changes for `logStartTime`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogCollectionSession.properties.logStartTime__deleted` | deleted | `{"type":"string","format":"date-time","readOnly":true}` |

### Changes for `logEndTime`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogCollectionSession.properties.logEndTime__deleted` | deleted | `{"type":"string","format":"date-time","readOnly":true}` |

### Changes for `logCollectionStatus`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogCollectionSession.properties.logCollectionStatus__deleted` | deleted | `{"type":"string","enum":["None","InProgress","Failed","Succeeded"],"x-ms-enum":{"name":"LogCollectio...` |

### Changes for `logCollectionJobType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogCollectionSession.properties.logCollectionJobType__deleted` | deleted | `{"type":"string","enum":["OnDemand","Scheduled"],"x-ms-enum":{"name":"LogCollectionJobType","modelAs...` |

### Changes for `endTimeCollected`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogCollectionSession.properties.endTimeCollected__deleted` | deleted | `{"type":"string","format":"date-time","readOnly":true}` |

### Changes for `logCollectionError`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogCollectionSession.properties.logCollectionError__deleted` | deleted | `{"$ref":"#/definitions/LogCollectionError","readOnly":true}` |

### Changes for `startTime`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogCollectionSession.properties.startTime__added` | added | `{"type":"string","readOnly":true}` |

### Changes for `endTime`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogCollectionSession.properties.endTime__added` | added | `{"type":"string","readOnly":true}` |

### Changes for `status`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogCollectionSession.properties.status__added` | added | `{"type":"string","enum":["NotStarted","Running","Failed","Succeeded","Canceled"],"x-ms-enum":{"name"...` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrecheckResult.properties.healthCheckTags.additionalProperties__added` | added | `{}` |

### Changes for `x-ms-client-name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.QosPolicyOverrides.properties.bandwidthPercentage_SMB['x-ms-client-name__added']` | added | `bandwidthPercentageSMB` |
| `definitions.QosPolicyOverrides.properties.priorityValue8021Action_Cluster['x-ms-client-name__added']` | added | `priorityValue8021ActionCluster` |
| `definitions.QosPolicyOverrides.properties.priorityValue8021Action_SMB['x-ms-client-name__added']` | added | `priorityValue8021ActionSMB` |

### Changes for `externalDocs`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScaleUnits.externalDocs__deleted` | deleted | `{"description":"Deploy Azure Stack HCI using an existing configuration file","url":"https://learn.mi...` |

### Changes for `errorMessage`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Step.properties.errorMessage__deleted` | deleted | `{"type":"string"}` |

### Changes for `lastUpdatedTimeUtc`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Step.properties.lastUpdatedTimeUtc__deleted` | deleted | `{"type":"string","format":"date-time"}` |

### Changes for `expectedExecutionTime`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Step.properties.expectedExecutionTime__deleted` | deleted | `{"type":"string"}` |

### Changes for `fullStepIndex`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Step.properties.fullStepIndex__added` | added | `{"type":"string","readOnly":true}` |

### Changes for `exception`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Step.properties.exception__added` | added | `{"type":"array","items":{"type":"string"},"readOnly":true}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.Cluster.properties.identity.$ref` | `../../../../../../common-types/resource-management/v4/managedidentity.json#/definitions/ManagedServiceIdentity` | `../../../../../../common-types/resource-management/v6/managedidentity.json#/definitions/ManagedServiceIdentity` |
| `definitions.ClusterPatch.properties.identity.$ref` | `../../../../../../common-types/resource-management/v4/managedidentity.json#/definitions/ManagedServiceIdentity` | `../../../../../../common-types/resource-management/v6/managedidentity.json#/definitions/ManagedServiceIdentity` |
| `definitions.ClusterProperties.properties.localAvailabilityZones.items.$ref` | `./hciCommon.json#/definitions/LocalAvailabilityZones` | `#/definitions/LocalAvailabilityZones` |
| `definitions.DeploymentSettingsProperties.properties.reportedProperties.$ref` | `./hciCommon.json#/definitions/EceReportedProperties` | `#/definitions/EceReportedProperties` |
| `definitions.EceActionStatus.properties.steps.items.$ref` | `#/definitions/DeploymentStep` | `#/definitions/Step` |
| `definitions.ExtensionPatchProperties.properties.extensionParameters.$ref` | `#/definitions/ExtensionPatchParameters` | `#/definitions/StackHCIHciExtensionPatchParametersContent` |
| `definitions.ExtensionProfile.properties.extensions.items.$ref` | `#/definitions/Extension` | `#/definitions/EdgeDevicesExtension` |
| `definitions.ExtensionProperties.properties.extensionParameters.$ref` | `#/definitions/ExtensionParameters` | `#/definitions/ExtensionParametersContent` |
| `definitions.HciNetworkProfile.properties.hostNetwork.$ref` | `#/definitions/HostNetwork` | `#/definitions/EdgeDevicesHostNetwork` |
| `definitions.HciRemoteSupportJobProperties.properties.reportedProperties.$ref` | `#/definitions/RemoteSupportJobReportedProperties` | `#/definitions/RemoteSupportReportedProperties` |
| `definitions.JobReportedProperties.properties.deploymentStatus.$ref` | `./hciCommon.json#/definitions/EceActionStatus` | `#/definitions/EceActionStatus` |
| `definitions.JobReportedProperties.properties.validationStatus.$ref` | `./hciCommon.json#/definitions/EceActionStatus` | `#/definitions/EceActionStatus` |
| `definitions.LogCollectionProperties.properties.logCollectionSessionDetails.items.$ref` | `#/definitions/LogCollectionSession` | `#/definitions/ClustersLogCollectionSession` |
| `definitions.LogCollectionReportedProperties.properties.deploymentStatus.$ref` | `./hciCommon.json#/definitions/EceActionStatus` | `#/definitions/EceActionStatus` |
| `definitions.LogCollectionReportedProperties.properties.logCollectionSessionDetails.items.$ref` | `#/definitions/LogCollectionJobSession` | `#/definitions/LogCollectionSession` |
| `definitions.LogCollectionReportedProperties.properties.validationStatus.$ref` | `./hciCommon.json#/definitions/EceActionStatus` | `#/definitions/EceActionStatus` |
| `definitions.LogCollectionSession.properties.logSize.format` | `int64` | `int32` |
| `definitions.Offer.allOf[0].$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.Publisher.allOf[0].$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.RemoteSupportJobProperties.properties.reportedProperties.$ref` | `#/definitions/RemoteSupportJobReportedProperties` | `#/definitions/RemoteSupportReportedProperties` |
| `definitions.RemoteSupportProperties.properties.remoteSupportNodeSettings.items.$ref` | `#/definitions/RemoteSupportNodeSettings` | `#/definitions/ClustersRemoteSupportNodeSettings` |
| `definitions.ScaleUnits.properties.deploymentData.$ref` | `#/definitions/DeploymentData` | `#/definitions/DeploymentDataContent` |
| `definitions.Sku.allOf[0].$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.Update.allOf[0].$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.UpdateProperties.properties.healthCheckResult.items.$ref` | `./hciCommon.json#/definitions/PrecheckResult` | `#/definitions/PrecheckResult` |
| `definitions.UpdateRun.allOf[0].$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.UpdateRunProperties.properties.progress.$ref` | `#/definitions/Step` | `#/definitions/UpdateRunsStep` |
| `definitions.UpdateSummariesList.properties.value.items.$ref` | `#/definitions/UpdateSummaries` | `#/definitions/UpdateSummary` |
| `definitions.UpdateSummariesProperties.properties.healthCheckResult.items.$ref` | `./hciCommon.json#/definitions/PrecheckResult` | `#/definitions/PrecheckResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}'].patch.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}/upgrade'].post.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/createClusterIdentity'].post.responses.200.schema.$ref` | `#/definitions/ClusterIdentityResponse` | `#/definitions/StackHciClusterIdentityResponseResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/offers'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}/offers'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}/offers/{offerName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}/offers/{offerName}/skus'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}/offers/{offerName}/skus/{skuName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `URL to query for status of the operation.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/apply'].post.responses.202.headers['Azure-AsyncOperation'].description` | `URL to query for status of the operation.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/apply'].post.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns/{updateRunName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `URL to query for status of the operation.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns/{updateRunName}'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns/{updateRunName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns/{updateRunName}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `URL to query for status of the operation.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].get.responses.200.schema.$ref` | `#/definitions/UpdateSummaries` | `#/definitions/UpdateSummary` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].put.parameters[1].schema.$ref` | `#/definitions/UpdateSummaries` | `#/definitions/UpdateSummary` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].put.responses.200.schema.$ref` | `#/definitions/UpdateSummaries` | `#/definitions/UpdateSummary` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |

