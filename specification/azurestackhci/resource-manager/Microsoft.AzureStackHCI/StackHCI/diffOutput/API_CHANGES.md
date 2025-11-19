## Swagger Changes

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterProperties.properties.identityProvider.default__deleted` | deleted | `ActiveDirectory` |
| `definitions.ClusterReportedProperties.properties.hardwareClass.default__added` | added | `Medium` |
| `definitions.DeploymentCluster.properties.hardwareClass.default__added` | added | `Medium` |
| `definitions.DeploymentSecuritySettings.properties.credentialGuardEnforced.default__deleted` | deleted | `false` |
| `definitions.DeploymentSecuritySettings.properties.smbClusterEncryption.default__deleted` | deleted | `false` |
| `definitions.HostNetwork.properties.enableStorageAutoIp.default__deleted` | deleted | `false` |
| `definitions.HostNetwork.properties.storageConnectivitySwitchless.default__deleted` | deleted | `false` |
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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/createArcIdentity'].post.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}'].delete.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"},"Location":{"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}'].patch.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}/upgrade'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/initializeDisableProcess'].post.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"},"Location":{"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/reconcile'].post.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"},"Location":{"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/createClusterIdentity'].post.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/deploymentSettings/{deploymentSettingsName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/extendSoftwareAssuranceBenefit'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/securitySettings/{securitySettingsName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/uploadCertificate'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |

### Changes for `x-ms-long-running-operation-options`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}'].delete['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}'].delete['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}'].patch['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"original-uri"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}/upgrade'].post['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/initializeDisableProcess'].post['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}'].delete['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/apply'].post['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns/{updateRunName}'].delete['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].delete['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/uploadCertificate'].post['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |

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

### Changes for `x-ms-examples`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries'].get['x-ms-examples__deleted']` | deleted | `{"Get Update summaries under cluster resource":{"$ref":"./examples/ListUpdateSummaries.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].delete['x-ms-examples__deleted']` | deleted | `{"Delete an Update":{"$ref":"./examples/DeleteUpdateSummaries.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].get['x-ms-examples__deleted']` | deleted | `{"Get Update summaries under cluster resource":{"$ref":"./examples/GetUpdateSummaries.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].put['x-ms-examples__deleted']` | deleted | `{"Put Update summaries under cluster resource":{"$ref":"./examples/PutUpdateSummaries.json"}}` |

### Changes for `Location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}'].delete.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/apply'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns/{updateRunName}'].delete.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].delete.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |

### Changes for `Intents`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Intents__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"trafficType":{"type":"array","items":{"type...` |

### Changes for `StorageNetworks`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StorageNetworks__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"networkAdapterName":{"type":"string"},"vlan...` |

### Changes for `VirtualSwitchConfigurationOverrides`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualSwitchConfigurationOverrides__deleted` | deleted | `{"type":"object","properties":{"enableIov":{"type":"string"},"loadBalancingAlgorithm":{"type":"strin...` |

### Changes for `ClusterWitnessProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterWitnessProperties__added` | added | `{"type":"object","properties":{"authenticationMode":{"type":"string","readOnly":true}}}` |

### Changes for `DeploymentHostNetwork`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentHostNetwork__added` | added | `{"type":"object","properties":{"intents":{"type":"array","items":{"$ref":"#/definitions/DeploymentIn...` |

### Changes for `DeploymentIntents`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentIntents__added` | added | `{"type":"object","properties":{"name":{"type":"string"},"trafficType":{"type":"array","items":{"type...` |

### Changes for `DeploymentStorageNetworks`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentStorageNetworks__added` | added | `{"type":"object","properties":{"name":{"type":"string"},"networkAdapterName":{"type":"string"},"vlan...` |

### Changes for `DeploymentVirtualSwitchConfigurationOverrides`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentVirtualSwitchConfigurationOverrides__added` | added | `{"type":"object","properties":{"enableIov":{"type":"string"},"loadBalancingAlgorithm":{"type":"strin...` |

### Changes for `DeviceHostNetwork`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeviceHostNetwork__added` | added | `{"type":"object","properties":{"intents":{"type":"array","items":{"$ref":"#/definitions/EdgeDevicesI...` |

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

### Changes for `PrecheckResultTags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrecheckResultTags__added` | added | `{"type":"object","properties":{"key":{"type":"string"},"value":{"type":"string"}}}` |

### Changes for `UpdateStep`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpdateStep__added` | added | `{"type":"object","properties":{"name":{"type":"string"},"description":{"type":"string"},"errorMessag...` |

### Changes for `x-ms-client-flatten`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcIdentityResponse.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.ArcSetting.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.ArcSettingsPatch.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.Cluster.properties.identity['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.Cluster.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.ClusterIdentityResponse.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
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
| `definitions.UpdateSummaries.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.UpdateSummariesProperties.properties.healthCheckResult['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.UpdateSummariesProperties.properties.healthState['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.UpdateSummariesProperties.properties.packageVersions['x-ms-client-flatten__deleted']` | deleted | `true` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcIdentityResponse.properties.properties.readOnly__added` | added | `true` |
| `definitions.ArcIdentityResponseProperties.readOnly__deleted` | deleted | `true` |
| `definitions.ArcSettingList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.ClusterIdentityResponse.properties.properties.readOnly__added` | added | `true` |
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
| `definitions.UpdateSummaries.properties.tags__added` | added | `{"type":"object","additionalProperties":{"type":"string"}}` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcSettingProperties.properties.connectivityProperties.type__deleted` | deleted | `object` |
| `definitions.ArcSettingsPatchProperties.properties.connectivityProperties.type__deleted` | deleted | `object` |
| `definitions.ClusterProperties.properties.clusterPattern.type__added` | added | `string` |
| `definitions.ClusterReportedProperties.properties.hardwareClass.type__added` | added | `string` |
| `definitions.DeploymentCluster.properties.clusterPattern.type__added` | added | `string` |
| `definitions.DeploymentCluster.properties.hardwareClass.type__added` | added | `string` |
| `definitions.DeploymentData.properties.identityProvider.type__added` | added | `string` |
| `definitions.DeploymentSettingsProperties.properties.deploymentMode.type__added` | added | `string` |
| `definitions.DeploymentSettingsProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.EdgeDeviceJob.properties.kind.type__added` | added | `string` |
| `definitions.EdgeDeviceProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.ExtensionInstanceView.properties.status.type__deleted` | deleted | `object` |
| `definitions.PrecheckResult.properties.tags.type__deleted` | deleted | `object` |
| `definitions.Update.properties.properties.type__deleted` | deleted | `object` |
| `definitions.UpdateProperties.properties.updateStateProperties.type__deleted` | deleted | `object` |
| `definitions.UpdateSummaries.properties.properties.type__deleted` | deleted | `object` |

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
| `definitions.DeploymentData.properties.identityProvider.$ref__deleted` | deleted | `./hciCommon.json#/definitions/IdentityProvider` |
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
| `definitions.DeploymentData.properties.identityProvider.enum__added` | added | `["ActiveDirectory","LocalIdentity"]` |
| `definitions.DeploymentSettingsProperties.properties.deploymentMode.enum__added` | added | `["Validate","Deploy"]` |
| `definitions.DeploymentSettingsProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Error","Succeeded","Failed","Canceled","Connected","Disconnected","Deleted","Creati...` |
| `definitions.EdgeDeviceJob.properties.kind.enum__added` | added | `["HCI"]` |
| `definitions.EdgeDeviceProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Error","Succeeded","Failed","Canceled","Connected","Disconnected","Deleted","Creati...` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterProperties.properties.clusterPattern['x-ms-enum__added']` | added | `{"name":"ClusterPattern","modelAsString":true}` |
| `definitions.ClusterReportedProperties.properties.hardwareClass['x-ms-enum__added']` | added | `{"name":"HardwareClass","modelAsString":true}` |
| `definitions.DeploymentCluster.properties.clusterPattern['x-ms-enum__added']` | added | `{"name":"ClusterPattern","modelAsString":true}` |
| `definitions.DeploymentCluster.properties.hardwareClass['x-ms-enum__added']` | added | `{"name":"HardwareClass","modelAsString":true}` |
| `definitions.DeploymentData.properties.identityProvider['x-ms-enum__added']` | added | `{"name":"IdentityProvider","modelAsString":true}` |
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

### Changes for `cloudEnvironment`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentData.properties.cloudEnvironment__added` | added | `{"type":"string"}` |

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
| `definitions.EdgeDeviceJob.properties.properties__added` | added | `{"type":"object"}` |
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

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExtensionParameters.properties.protectedSettings.additionalProperties__added` | added | `{}` |
| `definitions.ExtensionParameters.properties.settings.additionalProperties__added` | added | `{}` |
| `definitions.ExtensionPatchParameters.properties.protectedSettings.additionalProperties__added` | added | `{}` |
| `definitions.ExtensionPatchParameters.properties.settings.additionalProperties__added` | added | `{}` |
| `definitions.PrecheckResult.properties.healthCheckTags.additionalProperties__added` | added | `{"type":"string"}` |

### Changes for `x-ms-secret`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExtensionParameters.properties.protectedSettings['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.ExtensionPatchParameters.properties.protectedSettings['x-ms-secret__deleted']` | deleted | `true` |

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
| `definitions.DeploymentData.properties.hostNetwork.$ref` | `#/definitions/HostNetwork` | `#/definitions/DeploymentHostNetwork` |
| `definitions.DeploymentData.properties.localAvailabilityZones.items.$ref` | `./hciCommon.json#/definitions/LocalAvailabilityZones` | `#/definitions/LocalAvailabilityZones` |
| `definitions.DeploymentData.properties.secrets.items.$ref` | `./hciCommon.json#/definitions/EceDeploymentSecrets` | `#/definitions/EceDeploymentSecrets` |
| `definitions.DeploymentSettingsProperties.properties.reportedProperties.$ref` | `./hciCommon.json#/definitions/EceReportedProperties` | `#/definitions/EceReportedProperties` |
| `definitions.EceActionStatus.properties.steps.items.$ref` | `#/definitions/DeploymentStep` | `#/definitions/Step` |
| `definitions.ExtensionProfile.properties.extensions.items.$ref` | `#/definitions/Extension` | `#/definitions/EdgeDevicesExtension` |
| `definitions.HciNetworkProfile.properties.hostNetwork.$ref` | `#/definitions/HostNetwork` | `#/definitions/DeviceHostNetwork` |
| `definitions.HostNetwork.properties.intents.items.$ref` | `#/definitions/Intents` | `#/definitions/DeploymentIntents` |
| `definitions.HostNetwork.properties.storageNetworks.items.$ref` | `#/definitions/StorageNetworks` | `#/definitions/DeploymentStorageNetworks` |
| `definitions.JobReportedProperties.properties.deploymentStatus.$ref` | `./hciCommon.json#/definitions/EceActionStatus` | `#/definitions/EceActionStatus` |
| `definitions.JobReportedProperties.properties.validationStatus.$ref` | `./hciCommon.json#/definitions/EceActionStatus` | `#/definitions/EceActionStatus` |
| `definitions.LogCollectionReportedProperties.properties.deploymentStatus.$ref` | `./hciCommon.json#/definitions/EceActionStatus` | `#/definitions/EceActionStatus` |
| `definitions.LogCollectionReportedProperties.properties.validationStatus.$ref` | `./hciCommon.json#/definitions/EceActionStatus` | `#/definitions/EceActionStatus` |
| `definitions.Offer.allOf[0].$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.Publisher.allOf[0].$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.RemoteSupportJobReportedProperties.properties.deploymentStatus.$ref` | `./hciCommon.json#/definitions/EceActionStatus` | `#/definitions/EceActionStatus` |
| `definitions.RemoteSupportJobReportedProperties.properties.validationStatus.$ref` | `./hciCommon.json#/definitions/EceActionStatus` | `#/definitions/EceActionStatus` |
| `definitions.Sku.allOf[0].$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.Update.allOf[0].$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.UpdateProperties.properties.healthCheckResult.items.$ref` | `./hciCommon.json#/definitions/PrecheckResult` | `#/definitions/PrecheckResult` |
| `definitions.UpdateRun.allOf[0].$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.UpdateRunProperties.properties.progress.$ref` | `#/definitions/Step` | `#/definitions/UpdateStep` |
| `definitions.UpdateSummaries.allOf[0].$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.UpdateSummariesProperties.properties.healthCheckResult.items.$ref` | `./hciCommon.json#/definitions/PrecheckResult` | `#/definitions/PrecheckResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}'].patch.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}/upgrade'].post.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries'].get.operationId` | `UpdateSummaries_List` | `UpdateSummariesOperationGroup_List` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].delete.operationId` | `UpdateSummaries_Delete` | `UpdateSummariesOperationGroup_Delete` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `URL to query for status of the operation.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].get.operationId` | `UpdateSummaries_Get` | `UpdateSummariesOperationGroup_Get` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].put.operationId` | `UpdateSummaries_Put` | `UpdateSummariesOperationGroup_Put` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |

