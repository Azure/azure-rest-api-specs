## Swagger Changes

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExportImportedMachinesJob.properties.type__deleted` | deleted | `{"type":"string","description":"Type name for export job.","readOnly":true}` |
| `definitions.ImportMachinesJob.properties.type__deleted` | deleted | `{"type":"string","description":"Handled by resource provider. Type =\\nMicrosoft.OffAzure/ImportSites...` |
| `definitions.ImportSqlInventoryJob.properties.type__deleted` | deleted | `{"type":"string","description":"Resource Type","readOnly":true}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/clientGroupMembers'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/computeErrorSummary'].post.parameters[1].schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/computeusage'].post.parameters[1].schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/exportApplications'].post.parameters[1].schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/exportApplications'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/exportDependencies'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/exportMachineErrors'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/generateCoarseMap'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/generateDetailedMap'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/serverGroupMembers'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/updateDependencyMapStatus'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/updateProperties'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/importSites/{siteName}/deleteImportedMachines'].post.parameters[1].schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/masterSites/{siteName}/refreshArcStatus'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/masterSites/{siteName}/sqlSites/{sqlSiteName}/exportSqlServerErrors'].post.parameters[2].schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/masterSites/{siteName}/sqlSites/{sqlSiteName}/exportSqlServerErrors'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/masterSites/{siteName}/sqlSites/{sqlSiteName}/exportSqlServers'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/masterSites/{siteName}/sqlSites/{sqlSiteName}/refresh'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/masterSites/{siteName}/webAppSites/{webAppSiteName}/exportInventory'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/masterSites/{siteName}/webAppSites/{webAppSiteName}/refresh'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/masterSites/{siteName}/webAppSites/{webAppSiteName}/updateProperties'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/clientGroupMembers'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/computeErrorSummary'].post.parameters[1].schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/computeusage'].post.parameters[1].schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/exportApplications'].post.parameters[1].schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/exportApplications'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/exportDependencies'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/exportMachineErrors'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/generateCoarseMap'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/generateDetailedMap'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/refreshSite'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/serverGroupMembers'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/updateDependencyMapStatus'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/updateProperties'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/clientGroupMembers'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/computeErrorSummary'].post.parameters[1].schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/computeusage'].post.parameters[1].schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/exportApplications'].post.parameters[1].schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/exportApplications'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/exportDependencies'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/exportMachineErrors'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/exportMachines'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/generateCoarseMap'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/generateDetailedMap'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/machines/{machineName}/start'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/machines/{machineName}/stop'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/serverGroupMembers'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/updateDependencyMapStatus'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/updateProperties'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/updateRunAsAccount'].post.responses.200.schema.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/updateTags'].post.responses.200.schema.type__deleted` | deleted | `object` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/clusters/{clusterName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/hosts/{hostName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/masterSites/{siteName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/masterSites/{siteName}/sqlSites/{sqlSiteName}/discoverySiteDataSources/{discoverySiteDataSourceName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/masterSites/{siteName}/webAppSites/{webAppSiteName}/discoverySiteDataSources/{discoverySiteDataSourceName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/vcenters/{vcenterName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |

### Changes for `x-ms-pageable`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/listHealthSummary'].post['x-ms-pageable__added']` | added | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/listHealthSummary'].post['x-ms-pageable__added']` | added | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/listHealthSummary'].post['x-ms-pageable__added']` | added | `{"nextLinkName":"nextLink"}` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/masterSites/{siteName}/refreshArcStatus'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/refreshSite'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/machines/{machineName}/start'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/machines/{machineName}/stop'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/updateDependencyMapStatus'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/updateRunAsAccount'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/updateTags'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |

### Changes for `Location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/masterSites/{siteName}/refreshArcStatus'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/refreshSite'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/machines/{machineName}/start'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/machines/{machineName}/stop'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/updateDependencyMapStatus'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/updateRunAsAccount'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/updateTags'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |

### Changes for `Azure.ResourceManager.Object`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.Object__deleted']` | deleted | `{"type":"object","description":"object model"}` |

### Changes for `DeleteImportMachinesJobCollection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeleteImportMachinesJobCollection__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `HypervOperationsStatusResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HypervOperationsStatusResource__deleted` | deleted | `{"type":"object","description":"A cluster resource belonging to a site resource.","properties":{"pro...` |

### Changes for `MachineResourceId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MachineResourceId__deleted` | deleted | `{"type":"string","format":"arm-id","description":"A type definition that refers the id to an ARM res...` |

### Changes for `Object`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Object__deleted` | deleted | `{"type":"object","description":"object model"}` |

### Changes for `TomcatWebApplicationsUpdate`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TomcatWebApplicationsUpdate__deleted` | deleted | `{"type":"object","description":"The type used for update operations of the TomcatWebApplications."}` |

### Changes for `V20180501PreviewVmwareRunAsAccount`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.V20180501PreviewVmwareRunAsAccount__deleted` | deleted | `{"type":"object","description":"Run as account REST Resource.","properties":{"id":{"type":"string","...` |

### Changes for `V20180501PreviewVmwareRunAsAccountVmwareRunAsAccountCollection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.V20180501PreviewVmwareRunAsAccountVmwareRunAsAccountCollection__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `Azure.ResourceManager.ArmResponse<unknown>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<unknown>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"desc...` |

### Changes for `TomcatWebApplicationsTagsUpdate`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TomcatWebApplicationsTagsUpdate__added` | added | `{"type":"object","description":"The type used for updating tags in TomcatWebApplications resources."...` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcScopeProperties.properties.subscriptionOrResourceGroupIds.items.description__added` | added | `A type definition that refers the id to an Azure Resource Manager resource.` |
| `definitions.HypervMachineUpdate.properties.properties.description__added` | added | `The updatable properties of the HypervMachine.` |
| `definitions.HypervSiteUpdate.properties.properties.description__added` | added | `The updatable properties of the HypervSite.` |
| `definitions.IisWebApplicationsUpdate.properties.properties.description__added` | added | `The updatable properties of the IisWebApplications.` |
| `definitions.ImportSiteUpdate.properties.properties.description__added` | added | `The updatable properties of the ImportSite.` |
| `definitions.MachineResourceUpdate.properties.properties.description__added` | added | `The updatable properties of the MachineResource.` |
| `definitions.MasterSiteUpdate.properties.properties.description__added` | added | `The updatable properties of the MasterSite.` |
| `definitions.ServerSiteResourceUpdate.properties.properties.description__added` | added | `The updatable properties of the ServerSiteResource.` |
| `definitions.ServerUpdate.properties.properties.description__added` | added | `The updatable properties of the Server.` |
| `definitions.SqlServerV2Update.properties.properties.description__added` | added | `The updatable properties of the SqlServerV2.` |
| `definitions.SqlSiteUpdate.properties.properties.description__added` | added | `The updatable properties of the SqlSite.` |
| `definitions.VmwareSiteUpdate.properties.properties.description__added` | added | `The updatable properties of the VmwareSite.` |
| `definitions.WebAppSiteUpdate.properties.properties.description__added` | added | `The updatable properties of the WebAppSite.` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExportImportedMachinesJob.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}...` |
| `definitions.ImportMachinesJob.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}...` |
| `definitions.ImportSqlInventoryJob.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}...` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExportImportedMachinesJob.properties.id__deleted` | deleted | `{"type":"string","description":"Gets or sets the relative ARM name to get job."}` |
| `definitions.ImportMachinesJob.properties.id__deleted` | deleted | `{"type":"string","description":"Gets or sets the relative ARM name to get job."}` |
| `definitions.ImportSqlInventoryJob.properties.id__deleted` | deleted | `{"type":"string","description":"Resource Id","readOnly":true}` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExportImportedMachinesJob.properties.name__deleted` | deleted | `{"type":"string","description":"Gets or sets the Job ID."}` |
| `definitions.ImportMachinesJob.properties.name__deleted` | deleted | `{"type":"string","description":"Gets or sets the Job ID."}` |
| `definitions.ImportSqlInventoryJob.properties.name__deleted` | deleted | `{"type":"string","description":"Resource Name","readOnly":true}` |

### Changes for `x-ms-secret`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImportSqlInventoryJobProperties.properties.blobSasUri['x-ms-secret__deleted']` | deleted | `true` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PagedDeleteImportMachinesJob.required__added` | added | `["value"]` |
| `definitions.PagedExportImportedMachinesJob.required__added` | added | `["value"]` |
| `definitions.PagedImportMachinesJob.required__added` | added | `["value"]` |
| `definitions.PagedImportSqlInventoryJob.required__added` | added | `["value"]` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PagedDeleteImportMachinesJob.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.PagedExportImportedMachinesJob.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.PagedImportMachinesJob.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.PagedImportSqlInventoryJob.properties.value.readOnly__deleted` | deleted | `true` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SasUriResponse.properties.importType.default__deleted` | deleted | `AzureMigrateCSV` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerProperties.properties.tags.additionalProperties.$ref__deleted` | deleted | `#/definitions/Azure.ResourceManager.Object` |
| `definitions.ServerUpdateProperties.properties.tags.additionalProperties.$ref__deleted` | deleted | `#/definitions/Azure.ResourceManager.Object` |
| `definitions.SqlServerProperties.properties.tags.additionalProperties.$ref__deleted` | deleted | `#/definitions/Azure.ResourceManager.Object` |
| `definitions.SqlServerV2UpdateProperties.properties.tags.additionalProperties.$ref__deleted` | deleted | `#/definitions/Azure.ResourceManager.Object` |

### Changes for `x-ms-identifiers`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SiteHealthSummaryCollection.properties.value['x-ms-identifiers__deleted']` | deleted | `["applianceName"]` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ApplicationDiscovery.properties.hydratedRunAsAccountId.description` | `Gets the run as account ID with which feature worked successfully.
           
It is discovered by the agent from the list of credentials.` | `Gets the run as account ID with which feature worked successfully.

It is discovered by the agent from the list of credentials.` |
| `definitions.ArcDiscovery.properties.machineResourceId.description` | `A type definition that refers the id to an ARM resource.` | `Machine Resource Id.` |
| `definitions.ArcScopePropertiesUpdate.properties.subscriptionOrResourceGroupIds.items.description` | `An array of ARM resource IDs for subscriptions or resource groups.` | `A type definition that refers the id to an Azure Resource Manager resource.` |
| `definitions.DependencyMapDiscovery.properties.hydratedRunAsAccountId.description` | `Gets the run as account ID with which feature worked successfully.
           
It is discovered by the agent from the list of credentials.` | `Gets the run as account ID with which feature worked successfully.

It is discovered by the agent from the list of credentials.` |
| `definitions.DependencyMapMachineInput.properties.isDependencyMapToBeEnabled.description` | `Gets or sets a value indicating whether
            dependency mapping is to
be enabled or not.` | `Gets or sets a value indicating whether
dependency mapping is to
be enabled or not.` |
| `definitions.DependencyMapServiceMapextensionsClientGroupMembersRequest.properties.processGroupName.description` | `process group name ` | `process group name` |
| `definitions.ExportImportedMachinesJobEntityProperties.description` | ` Export Imported Machines JobEntity Properties ` | `Export Imported Machines JobEntity Properties` |
| `definitions.GuestOsDetails.description` | `Second level object.  Data related to a machine's operating system.             Serialized and stored as part of Machine Rest object. ` | `Second level object.  Data related to a machine's operating system.             Serialized and stored as part of Machine Rest object.` |
| `definitions.HypervMachineProperties.properties.dependencyMapping.description` | `Gets or sets if dependency mapping feature is enabled or not
            for
the VM.` | `Gets or sets if dependency mapping feature is enabled or not
for
the VM.` |
| `definitions.HypervMachineProperties.properties.guestDetailsDiscoveryTimestamp.description` | `The last time at which the Guest Details was discovered
            or the
error while discovering guest details based discovery
            of the
machine.` | `The last time at which the Guest Details was discovered
or the
error while discovering guest details based discovery
of the
machine.` |
| `definitions.HypervMachineProperties.properties.guestOsDetails.description` | `Operating System Details extracted from the guest             bu executing script inside the guest VM. ` | `Operating System Details extracted from the guest             bu executing script inside the guest VM.` |
| `definitions.HypervMachineProperties.properties.isGuestDetailsDiscoveryInProgress.description` | `Whether Refresh Fabric Layout Guest Details has been completed once.
         
  Portal will show discovery in progress, if this value is true.` | `Whether Refresh Fabric Layout Guest Details has been completed once.

Portal will show discovery in progress, if this value is true.` |
| `definitions.HypervMachineProperties.properties.managementServerType.description` | `Management server type captured as a string representation of the
           
{Microsoft.Azure.FDS.WebRole.HyperVMachineBase.HyperVMachineBaseProperties.ManagementServerType}
enumeration.` | `Management server type captured as a string representation of the

{Microsoft.Azure.FDS.WebRole.HyperVMachineBase.HyperVMachineBaseProperties.ManagementServerType}
enumeration.` |
| `definitions.HypervMachineProperties.properties.numberOfProcessorCore.description` | `Gets or sets the Number of Processor Cores 
            allocated for the
machine.` | `Gets or sets the Number of Processor Cores
allocated for the
machine.` |
| `definitions.HypervMachineUpdateProperties.properties.numberOfProcessorCore.description` | `Gets or sets the Number of Processor Cores 
            allocated for the
machine.` | `Gets or sets the Number of Processor Cores
allocated for the
machine.` |
| `definitions.HypervSiteUpdateProperties.properties.servicePrincipalIdentityDetails.description` | `Gets or sets the service principal identity details used by agent for
communication
            to the service.` | `Gets or sets the service principal identity details used by agent for
communication
to the service.` |
| `definitions.ImportMachineProperties.properties.numberOfProcessorCore.description` | `Gets or sets the Number of Processor Cores 
            allocated for the
machine.` | `Gets or sets the Number of Processor Cores
allocated for the
machine.` |
| `definitions.MachineResourceUpdateProperties.properties.numberOfProcessorCore.description` | `Gets or sets the Number of Processor Cores 
            allocated for the
machine.` | `Gets or sets the Number of Processor Cores
allocated for the
machine.` |
| `definitions.MasterSiteProperties.properties.sites.description` | `Gets or sets the sites that are a part of Master Site.
            The key
should contain the Site ARM name.` | `Gets or sets the sites that are a part of Master Site.
The key
should contain the Site ARM name.` |
| `definitions.MasterSiteUpdateProperties.properties.sites.description` | `Gets or sets the sites that are a part of Master Site.
            The key
should contain the Site ARM name.` | `Gets or sets the sites that are a part of Master Site.
The key
should contain the Site ARM name.` |
| `definitions.OperationStatus.properties.status.description` | `Gets the status of the operation. ARM expects the terminal status to be one
of
            Succeeded/ Failed/ Canceled. All other values imply that the
operation is still running.` | `Gets the status of the operation. ARM expects the terminal status to be one
of
Succeeded/ Failed/ Canceled. All other values imply that the
operation is still running.` |
| `definitions.ServerProperties.properties.dependencyMapping.description` | `Gets or sets if dependency mapping feature is enabled or not
            for
the VM.` | `Gets or sets if dependency mapping feature is enabled or not
for
the VM.` |
| `definitions.ServerProperties.properties.displayName.description` | `Gets the Display name of the machine.
            For server entity hydrated
FQDN is set as display name
            as the server id and server name are
same.` | `Gets the Display name of the machine.
For server entity hydrated
FQDN is set as display name
as the server id and server name are
same.` |
| `definitions.ServerProperties.properties.guestDetailsDiscoveryTimestamp.description` | `The last time at which the Guest Details was discovered
            or the
error while discovering guest details based discovery
            of the
machine.` | `The last time at which the Guest Details was discovered
or the
error while discovering guest details based discovery
of the
machine.` |
| `definitions.ServerProperties.properties.guestOsDetails.description` | `Operating System Details extracted from the guest
            bu executing
script inside the guest VM.` | `Operating System Details extracted from the guest
bu executing
script inside the guest VM.` |
| `definitions.ServerProperties.properties.isGuestDetailsDiscoveryInProgress.description` | `Whether Refresh Fabric Layout Guest Details has been completed once.
         
  Portal will show discovery in progress, if this value is true.` | `Whether Refresh Fabric Layout Guest Details has been completed once.

Portal will show discovery in progress, if this value is true.` |
| `definitions.ServerProperties.properties.numberOfProcessorCore.description` | `Gets or sets the Number of Processor Cores 
            allocated for the
machine.` | `Gets or sets the Number of Processor Cores
allocated for the
machine.` |
| `definitions.ServerSiteResourceUpdateProperties.properties.servicePrincipalIdentityDetails.description` | `Gets or sets the service principal identity details used by agent for
communication
            to the service.` | `Gets or sets the service principal identity details used by agent for
communication
to the service.` |
| `definitions.ServerUpdateProperties.properties.numberOfProcessorCore.description` | `Gets or sets the Number of Processor Cores 
            allocated for the
machine.` | `Gets or sets the Number of Processor Cores
allocated for the
machine.` |
| `definitions.SiteApplianceProperties.properties.servicePrincipalIdentityDetails.description` | ` Gets or sets the service principal identity details used by agent for  communication              to the service.  ` | `Gets or sets the service principal identity details used by agent for  communication              to the service.` |
| `definitions.SiteProperties.properties.servicePrincipalIdentityDetails.description` | `Gets or sets the service principal identity details used by agent for
communication
            to the service.` | `Gets or sets the service principal identity details used by agent for
communication
to the service.` |
| `definitions.SiteSpnProperties.properties.aadAuthority.description` | `Gets or sets the AAD Authority URL which was used to request the token for
the
            service principal.` | `Gets or sets the AAD Authority URL which was used to request the token for
the
service principal.` |
| `definitions.SiteSpnProperties.properties.applicationId.description` | `Gets or sets the application/client Id for the service principal with which
the
            on-premise management/data plane components would communicate
with our Azure 
            services.` | `Gets or sets the application/client Id for the service principal with which
the
on-premise management/data plane components would communicate
with our Azure
services.` |
| `definitions.SiteSpnProperties.properties.machineResourceId.description` | `A type definition that refers the id to an ARM resource.` | `Gets or sets the ARM ID of the arc for servers resource.` |
| `definitions.SiteSpnProperties.properties.objectId.description` | `Gets or sets the object Id of the service principal with which the on-premise

           management/data plane components would communicate with our Azure
services.` | `Gets or sets the object Id of the service principal with which the on-premise

management/data plane components would communicate with our Azure
services.` |
| `definitions.SiteSpnProperties.properties.tenantId.description` | `Gets or sets the tenant Id for the service principal with which the
on-premise
            management/data plane components would communicate with
our Azure services.` | `Gets or sets the tenant Id for the service principal with which the
on-premise
management/data plane components would communicate with
our Azure services.` |
| `definitions.SitesProperties.properties.servicePrincipalIdentityDetails.description` | `Gets or sets the service principal identity details used by agent for
communication
            to the service.` | `Gets or sets the service principal identity details used by agent for
communication
to the service.` |
| `definitions.SqlAvailabilityGroupProperties.properties.parentReplicaOverviewList.description` | `Gets the parent availability replica overview if any.
            This would be
set with details of parent AG and AR for cases where this availability group is
a part of a distributed AG.
            Currently, we do not populate this
since discovery and linking of DAG(Distributed Availability Group) is not
implemented.` | `Gets the parent availability replica overview if any.
This would be
set with details of parent AG and AR for cases where this availability group is
a part of a distributed AG.
Currently, we do not populate this
since discovery and linking of DAG(Distributed Availability Group) is not
implemented.` |
| `definitions.SqlAvailabilityReplicaProperties.properties.sqlAvailabilityGroupReplicaInfo.description` | `Gets or sets the Availability Replica object if Replica is of type AG. This is
null in case Replica is
            of type database. This is to be populated
in case AG is of type DAG.` | `Gets or sets the Availability Replica object if Replica is of type AG. This is
null in case Replica is
of type database. This is to be populated
in case AG is of type DAG.` |
| `definitions.SqlAvailabilityReplicaProperties.properties.sqlDatabaseReplicaInfo.description` | `Gets or sets the Availability Replica object if Replica is of type database.
This is null in case Replica is
            of type AG. This is to be populated
in case of normal AG.` | `Gets or sets the Availability Replica object if Replica is of type database.
This is null in case Replica is
of type AG. This is to be populated
in case of normal AG.` |
| `definitions.SqlDiscovery.properties.successfullyDiscoveredServerCount.description` | ` successfully Discovered ServerCount` | `successfully Discovered ServerCount` |
| `definitions.SqlFciProperties.properties.state.description` | `fci instance state ` | `fci instance state` |
| `definitions.SqlMachineOverview.properties.fciRole.description` | `sql fci role ` | `sql fci role` |
| `definitions.SqlSiteProperties.properties.siteAppliancePropertiesCollection.description` | `Gets or sets the appliance details used by service to communicate
           
to the appliance.` | `Gets or sets the appliance details used by service to communicate

to the appliance.` |
| `definitions.SqlSiteUpdateProperties.properties.siteAppliancePropertiesCollection.description` | `Gets or sets the appliance details used by service to communicate
           
to the appliance.` | `Gets or sets the appliance details used by service to communicate

to the appliance.` |
| `definitions.StaticDiscovery.properties.hydratedRunAsAccountId.description` | `Gets the run as account ID with which feature worked successfully.
           
It is discovered by the agent from the list of credentials.` | `Gets the run as account ID with which feature worked successfully.

It is discovered by the agent from the list of credentials.` |
| `definitions.UpdateMachineDepMapStatus.description` | `Defines class that represents input to enable or disable DMP on machine
      
      for cosmos entity operation.` | `Defines class that represents input to enable or disable DMP on machine

for cosmos entity operation.` |
| `definitions.UpdateMachineRunAsAccount.description` | `Defines class that represents input to update RunAsAccount on machine
      
      for cosmos entity operation.` | `Defines class that represents input to update RunAsAccount on machine

for cosmos entity operation.` |
| `definitions.UpdateMachineTags.description` | `Defines class that represents input to update Tags on machine
      
      for cosmos entity operation.` | `Defines class that represents input to update Tags on machine

for cosmos entity operation.` |
| `definitions.VmwareDisk.properties.diskProvisioningPolicy.description` | `The provisioning policy of the disk.
            It is Thin or Thick or
Unknown for the VMWare VMDK.` | `The provisioning policy of the disk.
It is Thin or Thick or
Unknown for the VMWare VMDK.` |
| `definitions.VmwareDisk.properties.diskScrubbingPolicy.description` | `The scrubbing policy of disks which can be
            eagerly zeroed or
lazily zeroed.` | `The scrubbing policy of disks which can be
eagerly zeroed or
lazily zeroed.` |
| `definitions.VmwareMachineProperties.properties.dependencyMapping.description` | `Gets or sets if dependency mapping feature is enabled or not
            for
the VM.` | `Gets or sets if dependency mapping feature is enabled or not
for
the VM.` |
| `definitions.VmwareMachineProperties.properties.guestDetailsDiscoveryTimestamp.description` | `The last time at which the Guest Details was discovered
            or the
error while discovering guest details based discovery
            of the
machine.` | `The last time at which the Guest Details was discovered
or the
error while discovering guest details based discovery
of the
machine.` |
| `definitions.VmwareMachineProperties.properties.guestOsDetails.description` | `Operating System Details extracted from the guest
            bu executing
script inside the guest VM.` | `Operating System Details extracted from the guest
bu executing
script inside the guest VM.` |
| `definitions.VmwareMachineProperties.properties.isGuestDetailsDiscoveryInProgress.description` | `Whether Refresh Fabric Layout Guest Details has been completed once.
         
  Portal will show discovery in progress, if this value is true.` | `Whether Refresh Fabric Layout Guest Details has been completed once.

Portal will show discovery in progress, if this value is true.` |
| `definitions.VmwareMachineProperties.properties.numberOfProcessorCore.description` | `Gets or sets the Number of Processor Cores 
            allocated for the
machine.` | `Gets or sets the Number of Processor Cores
allocated for the
machine.` |
| `definitions.VmwareSiteUpdateProperties.properties.servicePrincipalIdentityDetails.description` | `Gets or sets the service principal identity details used by agent for
communication
            to the service.` | `Gets or sets the service principal identity details used by agent for
communication
to the service.` |
| `definitions.WebApplicationDirectoryUnit.properties.isEditable.description` | `Gets or sets a value indicating whether the directory object is editable.
     
      True when the directory is added as an optional directory, false when
discovery is done
            manually.` | `Gets or sets a value indicating whether the directory object is editable.

True when the directory is added as an optional directory, false when
discovery is done
manually.` |
| `definitions.WebAppSiteProperties.properties.siteAppliancePropertiesCollection.description` | `Gets or sets the appliance details used by service to communicate
           
to the appliance.` | `Gets or sets the appliance details used by service to communicate

to the appliance.` |
| `definitions.WebAppSiteUpdateProperties.properties.siteAppliancePropertiesCollection.description` | `Gets or sets the appliance details used by service to communicate
           
to the appliance.` | `Gets or sets the appliance details used by service to communicate

to the appliance.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/exportApplications'].post.description` | `Method to generate report containing
            machine and the deep discovery of the application installed in the machine.` | `Method to generate report containing
machine and the deep discovery of the application installed in the machine.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/exportMachineErrors'].post.description` | `Method to generate report containing 
            machine and the errors encountered during guest discovery of the machine.` | `Method to generate report containing
machine and the errors encountered during guest discovery of the machine.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/updateDependencyMapStatus'].post.description` | `Method to enable disable dependency map status for machines
            in a site.` | `Method to enable disable dependency map status for machines
in a site.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/hypervSites/{siteName}/updateProperties'].post.description` | `Method to update custom properties for HYPERV machines
            in a site.` | `Method to update custom properties for HYPERV machines
in a site.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/masterSites/{siteName}/sqlSites/{sqlSiteName}/importUri'].post.responses.202.headers.Location.description` | `The URL to retrieve the status of the asynchronous operation. This must be a full absolute URI and a public-facing endpoint.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/masterSites/{siteName}/webAppSites/{webAppSiteName}/tomcatWebApplications/{webApplicationName}'].patch.parameters[3].schema.$ref` | `#/definitions/TomcatWebApplicationsUpdate` | `#/definitions/TomcatWebApplicationsTagsUpdate` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/masterSites/{siteName}/webAppSites/{webAppSiteName}/updateProperties'].post.description` | `Method to update properties for web applications.
            in a site.` | `Method to update properties for web applications.
in a site.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/exportApplications'].post.description` | `Method to generate report containing
            machine and the deep discovery of the application installed in the machine.` | `Method to generate report containing
machine and the deep discovery of the application installed in the machine.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/exportMachineErrors'].post.description` | `Method to generate report containing 
            machine and the errors encountered during guest discovery of the machine.` | `Method to generate report containing
machine and the errors encountered during guest discovery of the machine.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/serverSites/{siteName}/updateDependencyMapStatus'].post.description` | `Method to enable disable dependency map status for machines
            in a site.` | `Method to enable disable dependency map status for machines
in a site.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/exportApplications'].post.description` | `Method to generate report containing
            machine and the deep discovery of the application installed in the machine.` | `Method to generate report containing
machine and the deep discovery of the application installed in the machine.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/exportMachineErrors'].post.description` | `Method to generate report containing 
            machine and the errors encountered during guest discovery of the machine.` | `Method to generate report containing
machine and the errors encountered during guest discovery of the machine.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/exportMachines'].post.description` | `Method to generate report containing 
            machine and the deep discovery of the application installed in the machine.` | `Method to generate report containing
machine and the deep discovery of the application installed in the machine.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/updateDependencyMapStatus'].post.description` | `Method to enable disable dependency map status for machines
            in a
site.` | `Method to enable disable dependency map status for machines
in a
site.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/updateRunAsAccount'].post.description` | `Method to associate Run as account to machine
            in a site.` | `Method to associate Run as account to machine
in a site.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OffAzure/vmwareSites/{siteName}/updateTags'].post.description` | `Method to associate Run as account to machine
            in a site.` | `Method to associate Run as account to machine
in a site.` |

