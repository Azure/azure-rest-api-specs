## Changed Paths

Path: /{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices
Change Type: deleted

Path: /{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}
Change Type: deleted

Path: /{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}/jobs
Change Type: deleted

Path: /{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}/jobs/{jobsName}
Change Type: deleted

Path: /{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}/validate
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.AzureStackHCI/locations/{location}/validatedSolutionRecipes
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.AzureStackHCI/locations/{location}/validatedSolutionRecipes/{validatedSolutionRecipeName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/consentAndInstallDefaultExtensions
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/createArcIdentity
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}/upgrade
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/generatePassword
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/initializeDisableProcess
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/reconcile
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/changeRing
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/deploymentSettings
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/deploymentSettings/{deploymentSettingsName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/offers
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}/offers
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}/offers/{offerName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}/offers/{offerName}/skus
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}/offers/{offerName}/skus/{skuName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/securitySettings
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/securitySettings/{securitySettingsName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/apply
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns/{updateRunName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default
Change Type: deleted

## Swagger Changes

### Changes for `/{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices__deleted']` | deleted | `{"get":{"operationId":"EdgeDevices_List","parameters":[{"name":"resourceUri","in":"path","required":...` |

### Changes for `/{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}__deleted']` | deleted | `{"get":{"operationId":"EdgeDevices_Get","parameters":[{"name":"resourceUri","in":"path","required":t...` |

### Changes for `/{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}/jobs`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}/jobs__deleted']` | deleted | `{"get":{"operationId":"EdgeDeviceJobs_ListByEdgeDevice","parameters":[{"name":"resourceUri","in":"pa...` |

### Changes for `/{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}/jobs/{jobsName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}/jobs/{jobsName}__deleted']` | deleted | `{"get":{"operationId":"EdgeDeviceJobs_Get","parameters":[{"name":"resourceUri","in":"path","required...` |

### Changes for `/{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}/validate`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceUri}/providers/microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}/validate__deleted']` | deleted | `{"post":{"operationId":"EdgeDevices_Validate","parameters":[{"name":"resourceUri","in":"path","requi...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.AzureStackHCI/locations/{location}/validatedSolutionRecipes`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.AzureStackHCI/locations/{location}/validatedSolutionRecipes__deleted']` | deleted | `{"get":{"operationId":"ValidatedSolutionRecipes_ListBySubscriptionLocationResource","parameters":[{"...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.AzureStackHCI/locations/{location}/validatedSolutionRecipes/{validatedSolutionRecipeName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.AzureStackHCI/locations/{location}/validatedSolutionRecipes/{validatedSolutionRecipeName}__deleted']` | deleted | `{"get":{"operationId":"ValidatedSolutionRecipes_Get","parameters":[{"$ref":"../../../../../../common...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings__deleted']` | deleted | `{"get":{"operationId":"ArcSettings_ListByCluster","parameters":[{"name":"clusterName","in":"path","r...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}__deleted']` | deleted | `{"get":{"operationId":"ArcSettings_Get","parameters":[{"name":"clusterName","in":"path","required":t...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/consentAndInstallDefaultExtensions`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/consentAndInstallDefaultExtensions__deleted']` | deleted | `{"post":{"operationId":"ArcSettings_ConsentAndInstallDefaultExtensions","parameters":[{"name":"clust...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/createArcIdentity`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/createArcIdentity__deleted']` | deleted | `{"post":{"operationId":"ArcSettings_CreateIdentity","parameters":[{"name":"clusterName","in":"path",...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions__deleted']` | deleted | `{"get":{"operationId":"Extensions_ListByArcSetting","parameters":[{"name":"clusterName","in":"path",...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}__deleted']` | deleted | `{"get":{"operationId":"Extensions_Get","parameters":[{"name":"clusterName","in":"path","required":tr...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}/upgrade`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}/upgrade__deleted']` | deleted | `{"post":{"operationId":"Extensions_Upgrade","parameters":[{"name":"clusterName","in":"path","require...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/generatePassword`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/generatePassword__deleted']` | deleted | `{"post":{"operationId":"ArcSettings_GeneratePassword","parameters":[{"name":"clusterName","in":"path...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/initializeDisableProcess`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/initializeDisableProcess__deleted']` | deleted | `{"post":{"operationId":"ArcSettings_InitializeDisableProcess","parameters":[{"name":"clusterName","i...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/reconcile`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/reconcile__deleted']` | deleted | `{"post":{"operationId":"ArcSettings_Reconcile","parameters":[{"name":"clusterName","in":"path","requ...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/changeRing`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/changeRing__deleted']` | deleted | `{"post":{"operationId":"Clusters_ChangeRing","parameters":[{"name":"clusterName","in":"path","requir...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/deploymentSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/deploymentSettings__deleted']` | deleted | `{"get":{"operationId":"DeploymentSettings_ListByClusters","parameters":[{"name":"clusterName","in":"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/deploymentSettings/{deploymentSettingsName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/deploymentSettings/{deploymentSettingsName}__deleted']` | deleted | `{"get":{"operationId":"DeploymentSettings_Get","parameters":[{"name":"clusterName","in":"path","requ...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/offers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/offers__deleted']` | deleted | `{"get":{"operationId":"Offers_ListByCluster","parameters":[{"name":"clusterName","in":"path","requir...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers__deleted']` | deleted | `{"get":{"operationId":"Publishers_ListByCluster","parameters":[{"name":"clusterName","in":"path","re...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}__deleted']` | deleted | `{"get":{"operationId":"Publishers_Get","parameters":[{"name":"clusterName","in":"path","required":tr...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}/offers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}/offers__deleted']` | deleted | `{"get":{"operationId":"Offers_ListByPublisher","parameters":[{"name":"clusterName","in":"path","requ...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}/offers/{offerName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}/offers/{offerName}__deleted']` | deleted | `{"get":{"operationId":"Offers_Get","parameters":[{"name":"clusterName","in":"path","required":true,"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}/offers/{offerName}/skus`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}/offers/{offerName}/skus__deleted']` | deleted | `{"get":{"operationId":"Skus_ListByOffer","parameters":[{"name":"clusterName","in":"path","required":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}/offers/{offerName}/skus/{skuName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}/offers/{offerName}/skus/{skuName}__deleted']` | deleted | `{"get":{"operationId":"Skus_Get","parameters":[{"name":"clusterName","in":"path","required":true,"ty...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/securitySettings`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/securitySettings__deleted']` | deleted | `{"get":{"operationId":"SecuritySettings_ListByClusters","parameters":[{"name":"clusterName","in":"pa...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/securitySettings/{securitySettingsName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/securitySettings/{securitySettingsName}__deleted']` | deleted | `{"get":{"operationId":"SecuritySettings_Get","parameters":[{"name":"clusterName","in":"path","requir...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries__deleted']` | deleted | `{"get":{"operationId":"UpdateSummaries_List","parameters":[{"name":"clusterName","in":"path","requir...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default__deleted']` | deleted | `{"get":{"operationId":"UpdateSummaries_Get","parameters":[{"name":"clusterName","in":"path","require...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates__deleted']` | deleted | `{"get":{"operationId":"Updates_List","parameters":[{"name":"clusterName","in":"path","required":true...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}__deleted']` | deleted | `{"get":{"operationId":"Updates_Get","parameters":[{"name":"clusterName","in":"path","required":true,...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/apply`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/apply__deleted']` | deleted | `{"post":{"operationId":"Updates_Post","parameters":[{"name":"clusterName","in":"path","required":tru...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns__deleted']` | deleted | `{"get":{"operationId":"UpdateRuns_List","parameters":[{"name":"clusterName","in":"path","required":t...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns/{updateRunName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns/{updateRunName}__deleted']` | deleted | `{"get":{"operationId":"UpdateRuns_Get","parameters":[{"name":"clusterName","in":"path","required":tr...` |

### Changes for `x-ms-examples`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.AzureStackHCI/clusters'].get['x-ms-examples__deleted']` | deleted | `{"List clusters in a given subscription":{"$ref":"./examples/ListClustersBySubscription.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters'].get['x-ms-examples__deleted']` | deleted | `{"List clusters in a given resource group":{"$ref":"./examples/ListClustersByResourceGroup.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}'].delete['x-ms-examples__deleted']` | deleted | `{"Delete cluster":{"$ref":"./examples/DeleteCluster.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}'].get['x-ms-examples__deleted']` | deleted | `{"Get cluster":{"$ref":"./examples/GetCluster.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}'].patch['x-ms-examples__deleted']` | deleted | `{"Update cluster":{"$ref":"./examples/UpdateCluster.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}'].put['x-ms-examples__deleted']` | deleted | `{"Create cluster":{"$ref":"./examples/CreateCluster.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/configureRemoteSupport'].post['x-ms-examples__deleted']` | deleted | `{"Configure Remote Support":{"$ref":"./examples/ConfigureRemoteSupport.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/createClusterIdentity'].post['x-ms-examples__deleted']` | deleted | `{"Create cluster Identity":{"$ref":"./examples/CreateClusterIdentity.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/extendSoftwareAssuranceBenefit'].post['x-ms-examples__deleted']` | deleted | `{"Create cluster Identity":{"$ref":"./examples/ExtendSoftwareAssuranceBenefit.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/triggerLogCollection'].post['x-ms-examples__deleted']` | deleted | `{"Trigger Log Collection":{"$ref":"./examples/TriggerLogCollection.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/updateSecretsLocations'].post['x-ms-examples__deleted']` | deleted | `{"Update secrets locations for a Cluster":{"$ref":"./examples/Clusters_UpdateSecretsLocations.json"}...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/uploadCertificate'].post['x-ms-examples__deleted']` | deleted | `{"Upload certificate":{"$ref":"./examples/UploadCertificate.json"}}` |

### Changes for `x-ms-long-running-operation-options`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}'].put['x-ms-long-running-operation-options__added']` | added | `{"final-state-via":"original-uri"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/uploadCertificate'].post['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |

### Changes for `x-ms-long-running-operation`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}'].put['x-ms-long-running-operation__added']` | added | `true` |

### Changes for `201`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}'].put.responses.201__added` | added | `{"description":"ignore","schema":{"$ref":"#/definitions/Cluster"}}` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/createClusterIdentity'].post.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"},"Location":{"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/extendSoftwareAssuranceBenefit'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/uploadCertificate'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/configureRemoteSupport'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/triggerLogCollection'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |

### Changes for `AdapterPropertyOverrides`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdapterPropertyOverrides__deleted` | deleted | `{"type":"object","properties":{"jumboPacket":{"type":"string"},"networkDirect":{"type":"string"},"ne...` |

### Changes for `ArcConnectivityProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcConnectivityProperties__deleted` | deleted | `{"type":"object","properties":{"enabled":{"type":"boolean"},"serviceConfigurations":{"type":"array",...` |

### Changes for `ArcIdentityResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcIdentityResponse__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ArcIdentityResponseProperties","x...` |

### Changes for `ArcIdentityResponseProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcIdentityResponseProperties__deleted` | deleted | `{"type":"object","properties":{"arcApplicationClientId":{"type":"string"},"arcApplicationTenantId":{...` |

### Changes for `ArcSetting`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcSetting__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ArcSettingProperties","x-ms-clien...` |

### Changes for `ArcSettingList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcSettingList__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ArcSettingProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcSettingProperties__deleted` | deleted | `{"type":"object","properties":{"provisioningState":{"type":"string","enum":["NotSpecified","Error","...` |

### Changes for `ArcSettingsPatch`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcSettingsPatch__deleted` | deleted | `{"type":"object","properties":{"tags":{"type":"object","additionalProperties":{"type":"string"}},"pr...` |

### Changes for `ArcSettingsPatchProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcSettingsPatchProperties__deleted` | deleted | `{"type":"object","properties":{"connectivityProperties":{"type":"object","items":{"$ref":"#/definiti...` |

### Changes for `AssemblyInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AssemblyInfo__deleted` | deleted | `{"type":"object","properties":{"packageVersion":{"type":"string","readOnly":true},"payload":{"type":...` |

### Changes for `AssemblyInfoPayload`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AssemblyInfoPayload__deleted` | deleted | `{"type":"object","properties":{"identifier":{"type":"string","readOnly":true},"hash":{"type":"string...` |

### Changes for `ChangeRingRequest`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ChangeRingRequest__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ChangeRingRequestProperties"}}}` |

### Changes for `ChangeRingRequestProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ChangeRingRequestProperties__deleted` | deleted | `{"type":"object","properties":{"targetRing":{"type":"string"}}}` |

### Changes for `ClusterIdentityResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterIdentityResponse__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ClusterIdentityResponseProperties...` |

### Changes for `CollectLogJobProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CollectLogJobProperties__deleted` | deleted | `{"type":"object","properties":{"fromDate":{"type":"string","format":"date-time"},"toDate":{"type":"s...` |

### Changes for `DefaultExtensionDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DefaultExtensionDetails__deleted` | deleted | `{"type":"object","properties":{"category":{"type":"string","readOnly":true},"consentTime":{"type":"s...` |

### Changes for `DeploymentCluster`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentCluster__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"witnessType":{"type":"string"},"witnessPath...` |

### Changes for `DeploymentConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentConfiguration__deleted` | deleted | `{"type":"object","properties":{"version":{"type":"string"},"scaleUnits":{"type":"array","items":{"$r...` |

### Changes for `DeploymentData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentData__deleted` | deleted | `{"type":"object","properties":{"securitySettings":{"$ref":"#/definitions/DeploymentSecuritySettings"...` |

### Changes for `DeploymentSecuritySettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentSecuritySettings__deleted` | deleted | `{"type":"object","properties":{"hvciProtection":{"type":"boolean","default":true},"drtmProtection":{...` |

### Changes for `DeploymentSetting`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentSetting__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/DeploymentSettingsProperties","x-...` |

### Changes for `DeploymentSettingListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentSettingListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `DeploymentSettingsProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentSettingsProperties__deleted` | deleted | `{"type":"object","properties":{"provisioningState":{"$ref":"./hciCommon.json#/definitions/Provisioni...` |

### Changes for `DnsZones`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DnsZones__deleted` | deleted | `{"type":"object","properties":{"dnsZoneName":{"type":"string"},"dnsForwarder":{"type":"array","items...` |

### Changes for `EceDeploymentSecrets`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EceDeploymentSecrets__deleted` | deleted | `{"type":"object","properties":{"secretName":{"type":"string"},"eceSecretName":{"type":"string","enum...` |

### Changes for `EdgeDevice`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDevice__deleted` | deleted | `{"type":"object","properties":{"kind":{"type":"string","default":"HCI","enum":["HCI"],"x-ms-enum":{"...` |

### Changes for `EdgeDeviceJob`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDeviceJob__deleted` | deleted | `{"type":"object","properties":{"kind":{"$ref":"./hciCommon.json#/definitions/EdgeDeviceKind","x-ms-m...` |

### Changes for `EdgeDeviceJobListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDeviceJobListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `EdgeDeviceJobProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDeviceJobProperties__deleted` | deleted | `{"type":"object","properties":{"deploymentMode":{"type":"string","enum":["Validate","Deploy"],"x-ms-...` |

### Changes for `EdgeDeviceListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDeviceListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `EdgeDeviceProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeDeviceProperties__deleted` | deleted | `{"type":"object","properties":{"deviceConfiguration":{"$ref":"#/definitions/DeviceConfiguration"},"p...` |

### Changes for `ErrorDetail`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorDetail__deleted` | deleted | `{"type":"object","properties":{"exception":{"type":"string","readOnly":true}}}` |

### Changes for `Extension`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Extension__deleted` | deleted | `{"type":"object","properties":{"extensionName":{"type":"string","readOnly":true},"state":{"type":"st...` |

### Changes for `ExtensionInstanceView`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExtensionInstanceView__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"type":{"type":"string"},"typeHandlerVersion...` |

### Changes for `ExtensionList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExtensionList__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ExtensionParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExtensionParameters__deleted` | deleted | `{"type":"object","properties":{"forceUpdateTag":{"type":"string"},"publisher":{"type":"string"},"typ...` |

### Changes for `ExtensionPatch`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExtensionPatch__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ExtensionPatchProperties","x-ms-c...` |

### Changes for `ExtensionPatchParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExtensionPatchParameters__deleted` | deleted | `{"type":"object","properties":{"typeHandlerVersion":{"type":"string"},"enableAutomaticUpgrade":{"typ...` |

### Changes for `ExtensionPatchProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExtensionPatchProperties__deleted` | deleted | `{"type":"object","properties":{"extensionParameters":{"$ref":"#/definitions/ExtensionPatchParameters...` |

### Changes for `ExtensionProfile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExtensionProfile__deleted` | deleted | `{"type":"object","properties":{"extensions":{"type":"array","items":{"$ref":"#/definitions/Extension...` |

### Changes for `ExtensionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExtensionProperties__deleted` | deleted | `{"type":"object","properties":{"provisioningState":{"type":"string","enum":["NotSpecified","Error","...` |

### Changes for `ExtensionUpgradeParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExtensionUpgradeParameters__deleted` | deleted | `{"type":"object","properties":{"targetVersion":{"type":"string"}}}` |

### Changes for `HciCollectLogJobProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HciCollectLogJobProperties__deleted` | deleted | `{"type":"object","properties":{"fromDate":{"type":"string","format":"date-time"},"toDate":{"type":"s...` |

### Changes for `HciEdgeDevice`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HciEdgeDevice__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/HciEdgeDeviceProperties"}},"allOf...` |

### Changes for `HciEdgeDeviceJob`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HciEdgeDeviceJob__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/HciEdgeDeviceJobProperties"}},"re...` |

### Changes for `HciEdgeDeviceJobProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HciEdgeDeviceJobProperties__deleted` | deleted | `{"type":"object","properties":{"deploymentMode":{"type":"string","enum":["Validate","Deploy"],"x-ms-...` |

### Changes for `HciEdgeDeviceProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HciEdgeDeviceProperties__deleted` | deleted | `{"type":"object","properties":{"reportedProperties":{"$ref":"#/definitions/HciReportedProperties","r...` |

### Changes for `HciHardwareProfile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HciHardwareProfile__deleted` | deleted | `{"type":"object","properties":{"processorType":{"type":"string","readOnly":true}}}` |

### Changes for `HciNetworkProfile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HciNetworkProfile__deleted` | deleted | `{"type":"object","properties":{"nicDetails":{"type":"array","items":{"$ref":"#/definitions/HciNicDet...` |

### Changes for `HciNicDetail`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HciNicDetail__deleted` | deleted | `{"type":"object","properties":{"adapterName":{"type":"string","readOnly":true},"interfaceDescription...` |

### Changes for `HciOsProfile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HciOsProfile__deleted` | deleted | `{"type":"object","properties":{"bootType":{"type":"string","readOnly":true},"assemblyVersion":{"type...` |

### Changes for `HciRemoteSupportJobProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HciRemoteSupportJobProperties__deleted` | deleted | `{"type":"object","properties":{"accessLevel":{"type":"string","enum":["None","Diagnostics","Diagnost...` |

### Changes for `HciReportedProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HciReportedProperties__deleted` | deleted | `{"type":"object","properties":{"networkProfile":{"$ref":"#/definitions/HciNetworkProfile","readOnly"...` |

### Changes for `HciStorageProfile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HciStorageProfile__deleted` | deleted | `{"type":"object","properties":{"poolableDisksCount":{"type":"integer","format":"int64","readOnly":tr...` |

### Changes for `HostNetwork`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HostNetwork__deleted` | deleted | `{"type":"object","properties":{"intents":{"type":"array","items":{"$ref":"#/definitions/Intents"},"x...` |

### Changes for `InfrastructureNetwork`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InfrastructureNetwork__deleted` | deleted | `{"type":"object","properties":{"subnetMask":{"type":"string"},"gateway":{"type":"string"},"ipPools":...` |

### Changes for `Intents`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Intents__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"trafficType":{"type":"array","items":{"type...` |

### Changes for `IpPools`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IpPools__deleted` | deleted | `{"type":"object","properties":{"startingAddress":{"type":"string"},"endingAddress":{"type":"string"}...` |

### Changes for `LogCollectionJobSession`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogCollectionJobSession__deleted` | deleted | `{"type":"object","properties":{"startTime":{"type":"string","readOnly":true},"endTime":{"type":"stri...` |

### Changes for `NetworkController`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkController__deleted` | deleted | `{"type":"object","properties":{"macAddressPoolStart":{"type":"string"},"macAddressPoolStop":{"type":...` |

### Changes for `NicDetail`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NicDetail__deleted` | deleted | `{"type":"object","properties":{"adapterName":{"type":"string"},"interfaceDescription":{"type":"strin...` |

### Changes for `Observability`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Observability__deleted` | deleted | `{"type":"object","properties":{"streamingDataClient":{"type":"boolean","default":true},"euLocation":...` |

### Changes for `Offer`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Offer__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/OfferProperties","x-ms-client-fla...` |

### Changes for `OfferList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OfferList__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `OfferProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OfferProperties__deleted` | deleted | `{"type":"object","properties":{"provisioningState":{"type":"string","readOnly":true},"publisherId":{...` |

### Changes for `OptionalServices`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OptionalServices__deleted` | deleted | `{"type":"object","properties":{"customLocation":{"type":"string"}}}` |

### Changes for `PasswordCredential`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PasswordCredential__deleted` | deleted | `{"type":"object","properties":{"secretText":{"type":"string"},"keyId":{"type":"string"},"startDateTi...` |

### Changes for `PerNodeExtensionState`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PerNodeExtensionState__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string","readOnly":true},"extension":{"type":"string"...` |

### Changes for `PerNodeState`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PerNodeState__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string","readOnly":true},"arcInstance":{"type":"strin...` |

### Changes for `PhysicalNodes`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PhysicalNodes__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"ipv4Address":{"type":"string"}}}` |

### Changes for `Publisher`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Publisher__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/PublisherProperties","x-ms-client...` |

### Changes for `PublisherList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PublisherList__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `PublisherProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PublisherProperties__deleted` | deleted | `{"type":"object","properties":{"provisioningState":{"type":"string","readOnly":true}}}` |

### Changes for `ReconcileArcSettingsRequest`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ReconcileArcSettingsRequest__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ReconcileArcSettingsRequestProper...` |

### Changes for `ReconcileArcSettingsRequestProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ReconcileArcSettingsRequestProperties__deleted` | deleted | `{"type":"object","properties":{"clusterNodes":{"type":"array","items":{"type":"string"}}}}` |

### Changes for `RemoteSupportJobNodeSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RemoteSupportJobNodeSettings__deleted` | deleted | `{"type":"object","properties":{"state":{"type":"string","readOnly":true},"createdAt":{"type":"string...` |

### Changes for `RemoteSupportJobProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RemoteSupportJobProperties__deleted` | deleted | `{"type":"object","properties":{"accessLevel":{"type":"string","enum":["None","Diagnostics","Diagnost...` |

### Changes for `RemoteSupportJobReportedProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RemoteSupportJobReportedProperties__deleted` | deleted | `{"type":"object","properties":{"percentComplete":{"type":"integer","format":"int32","readOnly":true}...` |

### Changes for `RemoteSupportNodeSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RemoteSupportNodeSettings__deleted` | deleted | `{"type":"object","properties":{"arcResourceId":{"type":"string","readOnly":true},"state":{"type":"st...` |

### Changes for `RemoteSupportSession`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RemoteSupportSession__deleted` | deleted | `{"type":"object","properties":{"sessionId":{"type":"string","readOnly":true},"sessionStartTime":{"ty...` |

### Changes for `ReportedProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ReportedProperties__deleted` | deleted | `{"type":"object","properties":{"deviceState":{"type":"string","enum":["NotSpecified","Connected","Di...` |

### Changes for `SbeCredentials`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SbeCredentials__deleted` | deleted | `{"type":"object","properties":{"secretName":{"type":"string"},"eceSecretName":{"type":"string"},"sec...` |

### Changes for `SbeDeploymentInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SbeDeploymentInfo__deleted` | deleted | `{"type":"object","properties":{"version":{"type":"string"},"family":{"type":"string"},"publisher":{"...` |

### Changes for `SbeDeploymentPackageInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SbeDeploymentPackageInfo__deleted` | deleted | `{"type":"object","properties":{"code":{"type":"string","readOnly":true},"message":{"type":"string","...` |

### Changes for `SbePartnerInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SbePartnerInfo__deleted` | deleted | `{"type":"object","properties":{"sbeDeploymentInfo":{"$ref":"#/definitions/SbeDeploymentInfo"},"partn...` |

### Changes for `SbePartnerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SbePartnerProperties__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"value":{"type":"string"}}}` |

### Changes for `ScaleUnits`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScaleUnits__deleted` | deleted | `{"type":"object","properties":{"deploymentData":{"$ref":"#/definitions/DeploymentData"},"sbePartnerI...` |

### Changes for `SdnIntegration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SdnIntegration__deleted` | deleted | `{"type":"object","properties":{"networkController":{"$ref":"#/definitions/NetworkController"}}}` |

### Changes for `SecurityComplianceStatus`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityComplianceStatus__deleted` | deleted | `{"type":"object","properties":{"securedCoreCompliance":{"type":"string","enum":["Compliant","NonComp...` |

### Changes for `SecurityProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityProperties__deleted` | deleted | `{"type":"object","properties":{"securedCoreComplianceAssignment":{"type":"string","default":"Audit",...` |

### Changes for `SecuritySetting`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecuritySetting__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/SecurityProperties","x-ms-client-...` |

### Changes for `SecuritySettingListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecuritySettingListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ServiceConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceConfiguration__deleted` | deleted | `{"type":"object","properties":{"serviceName":{"type":"string","enum":["WAC"],"x-ms-enum":{"name":"Se...` |

### Changes for `Sku`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Sku__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/SkuProperties","x-ms-client-flatt...` |

### Changes for `SkuList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SkuList__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `SkuProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SkuProperties__deleted` | deleted | `{"type":"object","properties":{"provisioningState":{"type":"string","readOnly":true},"publisherId":{...` |

### Changes for `Storage`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Storage__deleted` | deleted | `{"type":"object","properties":{"configurationMode":{"type":"string","default":"Express"}}}` |

### Changes for `StorageAdapterIPInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StorageAdapterIPInfo__deleted` | deleted | `{"type":"object","properties":{"physicalNode":{"type":"string"},"ipv4Address":{"type":"string"},"sub...` |

### Changes for `StorageNetworks`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StorageNetworks__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"networkAdapterName":{"type":"string"},"vlan...` |

### Changes for `SwitchDetail`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SwitchDetail__deleted` | deleted | `{"type":"object","properties":{"switchName":{"type":"string","readOnly":true},"switchType":{"type":"...` |

### Changes for `SwitchExtension`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SwitchExtension__deleted` | deleted | `{"type":"object","properties":{"switchId":{"type":"string","readOnly":true},"extensionName":{"type":...` |

### Changes for `Update`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Update__deleted` | deleted | `{"type":"object","properties":{"location":{"type":"string","x-ms-mutability":["create","read"]},"pro...` |

### Changes for `UpdateList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpdateList__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `UpdatePrerequisite`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpdatePrerequisite__deleted` | deleted | `{"type":"object","properties":{"updateType":{"type":"string"},"version":{"type":"string"},"packageNa...` |

### Changes for `UpdateProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpdateProperties__deleted` | deleted | `{"type":"object","properties":{"provisioningState":{"type":"string","enum":["Succeeded","Failed","Ca...` |

### Changes for `UpdateRun`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpdateRun__deleted` | deleted | `{"type":"object","properties":{"location":{"type":"string","x-ms-mutability":["create","read"]},"pro...` |

### Changes for `UpdateRunList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpdateRunList__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `UpdateRunProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpdateRunProperties__deleted` | deleted | `{"type":"object","properties":{"provisioningState":{"type":"string","enum":["Succeeded","Failed","Ca...` |

### Changes for `UpdateStateProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpdateStateProperties__deleted` | deleted | `{"type":"object","properties":{"progressPercentage":{"type":"number"},"notifyMessage":{"type":"strin...` |

### Changes for `UpdateSummaries`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpdateSummaries__deleted` | deleted | `{"type":"object","properties":{"location":{"type":"string","x-ms-mutability":["create","read"]},"pro...` |

### Changes for `UpdateSummariesList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpdateSummariesList__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `UpdateSummariesProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpdateSummariesProperties__deleted` | deleted | `{"type":"object","properties":{"provisioningState":{"type":"string","enum":["Succeeded","Failed","Ca...` |

### Changes for `ValidateRequest`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ValidateRequest__deleted` | deleted | `{"type":"object","properties":{"edgeDeviceIds":{"type":"array","items":{"type":"string"}},"additiona...` |

### Changes for `ValidateResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ValidateResponse__deleted` | deleted | `{"type":"object","properties":{"status":{"type":"string","readOnly":true}}}` |

### Changes for `ValidatedSolutionRecipe`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ValidatedSolutionRecipe__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ValidatedSolutionRecipeProperties...` |

### Changes for `ValidatedSolutionRecipeCapabilities`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ValidatedSolutionRecipeCapabilities__deleted` | deleted | `{"type":"object","properties":{"clusterCapabilities":{"type":"array","items":{"$ref":"#/definitions/...` |

### Changes for `ValidatedSolutionRecipeCapability`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ValidatedSolutionRecipeCapability__deleted` | deleted | `{"type":"object","properties":{"capabilityName":{"type":"string"}},"required":["capabilityName"]}` |

### Changes for `ValidatedSolutionRecipeComponent`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ValidatedSolutionRecipeComponent__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"type":{"type":"string"},"requiredVersion":{...` |

### Changes for `ValidatedSolutionRecipeComponentMetadata`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ValidatedSolutionRecipeComponentMetadata__deleted` | deleted | `{"type":"object","properties":{"extensionType":{"type":"string"},"publisher":{"type":"string"},"enab...` |

### Changes for `ValidatedSolutionRecipeComponentPayload`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ValidatedSolutionRecipeComponentPayload__deleted` | deleted | `{"type":"object","properties":{"identifier":{"type":"string"},"hash":{"type":"string"},"fileName":{"...` |

### Changes for `ValidatedSolutionRecipeContent`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ValidatedSolutionRecipeContent__deleted` | deleted | `{"type":"object","properties":{"info":{"$ref":"#/definitions/ValidatedSolutionRecipeInfo"},"capabili...` |

### Changes for `ValidatedSolutionRecipeInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ValidatedSolutionRecipeInfo__deleted` | deleted | `{"type":"object","properties":{"solutionType":{"type":"string"},"version":{"type":"string"}},"requir...` |

### Changes for `ValidatedSolutionRecipeListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ValidatedSolutionRecipeListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ValidatedSolutionRecipeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ValidatedSolutionRecipeProperties__deleted` | deleted | `{"type":"object","properties":{"recipeContent":{"$ref":"#/definitions/ValidatedSolutionRecipeContent...` |

### Changes for `VirtualSwitchConfigurationOverrides`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualSwitchConfigurationOverrides__deleted` | deleted | `{"type":"object","properties":{"enableIov":{"type":"string"},"loadBalancingAlgorithm":{"type":"strin...` |

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

### Changes for `DeploymentHostNetwork`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentHostNetwork__added` | added | `{"type":"object","properties":{"intents":{"type":"array","items":{"$ref":"#/definitions/DeploymentIn...` |

### Changes for `DeploymentIntents`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentIntents__added` | added | `{"type":"object","properties":{"name":{"type":"string"},"trafficType":{"type":"array","items":{"type...` |

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

### Changes for `StackHciClusterIdentityResponseResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StackHciClusterIdentityResponseResult__added` | added | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ClusterIdentityResponseProperties...` |

### Changes for `TimeConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TimeConfiguration__added` | added | `{"type":"object","properties":{"primaryTimeServer":{"type":"string"},"secondaryTimeServer":{"type":"...` |

### Changes for `WebProxyConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebProxyConfiguration__added` | added | `{"type":"object","properties":{"connectionUri":{"type":"string"},"port":{"type":"string"},"bypassLis...` |

### Changes for `kind`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Cluster.properties.kind__deleted` | deleted | `{"type":"string","pattern":"^[-\\\\w\\\\._,\\\\(\\\\\\\\\\\\)]+$","x-ms-mutability":["create","read"]}` |

### Changes for `x-ms-client-flatten`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Cluster.properties.identity['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.Cluster.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.ClusterPatch.properties.identity['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.ClusterPatch.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterIdentityResponseProperties.readOnly__deleted` | deleted | `true` |
| `definitions.PrecheckResult.properties.status.readOnly__added` | added | `true` |
| `definitions.Step.properties.description.readOnly__added` | added | `true` |
| `definitions.Step.properties.endTimeUtc.readOnly__added` | added | `true` |
| `definitions.Step.properties.name.readOnly__added` | added | `true` |
| `definitions.Step.properties.startTimeUtc.readOnly__added` | added | `true` |
| `definitions.Step.properties.status.readOnly__added` | added | `true` |
| `definitions.Step.properties.steps.readOnly__added` | added | `true` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterList.required__added` | added | `["value"]` |

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

### Changes for `supportStatus`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterProperties.properties.supportStatus__deleted` | deleted | `{"type":"string","enum":["InSupport","OutOfSupport","NotSpecified"],"x-ms-enum":{"name":"SupportStat...` |

### Changes for `ring`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterProperties.properties.ring__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `identityProvider`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterProperties.properties.identityProvider__deleted` | deleted | `{"type":"string","default":"ActiveDirectory","enum":["ActiveDirectory","LocalIdentity"],"x-ms-enum":...` |

### Changes for `cloudEnvironment`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterProperties.properties.cloudEnvironment__added` | added | `{"type":"string","readOnly":true}` |

### Changes for `clusterWitness`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterProperties.properties.clusterWitness__added` | added | `{"$ref":"#/definitions/ClusterWitnessProperties"}` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterProperties.properties.clusterPattern.$ref__deleted` | deleted | `./hciCommon.json#/definitions/ClusterPattern` |
| `definitions.ClusterReportedProperties.properties.hardwareClass.$ref__deleted` | deleted | `./hciCommon.json#/definitions/HardwareClass` |
| `definitions.PrecheckResult.properties.tags.$ref__added` | added | `#/definitions/PrecheckResultTags` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterProperties.properties.clusterPattern.type__added` | added | `string` |
| `definitions.ClusterReportedProperties.properties.hardwareClass.type__added` | added | `string` |
| `definitions.PrecheckResult.properties.tags.type__deleted` | deleted | `object` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterProperties.properties.clusterPattern.enum__added` | added | `["Standard","RackAware"]` |
| `definitions.ClusterReportedProperties.properties.hardwareClass.enum__added` | added | `["Small","Medium","Large"]` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterProperties.properties.clusterPattern['x-ms-enum__added']` | added | `{"name":"ClusterPattern","modelAsString":true}` |
| `definitions.ClusterReportedProperties.properties.hardwareClass['x-ms-enum__added']` | added | `{"name":"HardwareClass","modelAsString":true}` |

### Changes for `customLocationId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterReportedProperties.properties.customLocationId__added` | added | `{"type":"string","readOnly":true}` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterReportedProperties.properties.hardwareClass.default__added` | added | `Medium` |

### Changes for `nicDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeviceConfiguration.properties.nicDetails__deleted` | deleted | `{"type":"array","items":{"$ref":"#/definitions/NicDetail"},"x-ms-identifiers":["adapterName"]}` |

### Changes for `deviceMetadata`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeviceConfiguration.properties.deviceMetadata__deleted` | deleted | `{"type":"string"}` |

### Changes for `network`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeviceConfiguration.properties.network__added` | added | `{"$ref":"#/definitions/NetworkConfiguration"}` |

### Changes for `hostName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeviceConfiguration.properties.hostName__added` | added | `{"type":"string"}` |

### Changes for `webProxy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeviceConfiguration.properties.webProxy__added` | added | `{"$ref":"#/definitions/WebProxyConfiguration"}` |

### Changes for `time`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeviceConfiguration.properties.time__added` | added | `{"$ref":"#/definitions/TimeConfiguration"}` |

### Changes for `x-ms-identifiers`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EceActionStatus.properties.steps['x-ms-identifiers__added']` | added | `["name"]` |

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

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrecheckResult.properties.tags.properties__deleted` | deleted | `{"key":{"type":"string","description":"Key that allow grouping/filtering individual tests."},"value"...` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrecheckResult.properties.healthCheckTags.additionalProperties__added` | added | `{}` |

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
| `definitions.EceActionStatus.properties.steps.items.$ref` | `#/definitions/DeploymentStep` | `#/definitions/Step` |
| `definitions.JobReportedProperties.properties.deploymentStatus.$ref` | `./hciCommon.json#/definitions/EceActionStatus` | `#/definitions/EceActionStatus` |
| `definitions.JobReportedProperties.properties.validationStatus.$ref` | `./hciCommon.json#/definitions/EceActionStatus` | `#/definitions/EceActionStatus` |
| `definitions.LogCollectionProperties.properties.logCollectionSessionDetails.items.$ref` | `#/definitions/LogCollectionSession` | `#/definitions/ClustersLogCollectionSession` |
| `definitions.LogCollectionReportedProperties.properties.deploymentStatus.$ref` | `./hciCommon.json#/definitions/EceActionStatus` | `#/definitions/EceActionStatus` |
| `definitions.LogCollectionReportedProperties.properties.logCollectionSessionDetails.items.$ref` | `#/definitions/LogCollectionJobSession` | `#/definitions/LogCollectionSession` |
| `definitions.LogCollectionReportedProperties.properties.validationStatus.$ref` | `./hciCommon.json#/definitions/EceActionStatus` | `#/definitions/EceActionStatus` |
| `definitions.LogCollectionSession.properties.logSize.format` | `int64` | `int32` |
| `definitions.RemoteSupportProperties.properties.remoteSupportNodeSettings.items.$ref` | `#/definitions/RemoteSupportNodeSettings` | `#/definitions/ClustersRemoteSupportNodeSettings` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}'].patch.parameters[1].name` | `cluster` | `properties` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}'].put.parameters[1].name` | `cluster` | `resource` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/configureRemoteSupport'].post.parameters[1].name` | `remoteSupportRequest` | `body` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/createClusterIdentity'].post.responses.200.schema.$ref` | `#/definitions/ClusterIdentityResponse` | `#/definitions/StackHciClusterIdentityResponseResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/extendSoftwareAssuranceBenefit'].post.parameters[1].name` | `softwareAssuranceChangeRequest` | `body` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/triggerLogCollection'].post.parameters[1].name` | `logCollectionRequest` | `body` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHCI/clusters/{clusterName}/uploadCertificate'].post.parameters[1].name` | `uploadCertificateRequest` | `body` |

