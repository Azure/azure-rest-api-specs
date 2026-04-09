## Swagger Changes

### Changes for `contact`

| Path | Change Type | Value |
|------|------------|-------|
| `info.contact__deleted` | deleted | `{"name":"Azure Monitor Control Service Team","email":"amcsdev@microsoft.com"}` |

### Changes for `x-ms-code-generation-settings`

| Path | Change Type | Value |
|------|------------|-------|
| `info['x-ms-code-generation-settings__deleted']` | deleted | `{"name":"MonitorManagementClient"}` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OtelLogsDataSource.properties.enrichWithResourceAttributes.description__added` | added | `Specifies the list of resource attributes that need to be added as labels/dimensions to the telemetry data for further enrichment.` |
| `definitions.OtelLogsDirectDataSource.properties.enrichWithResourceAttributes.description__added` | added | `Specifies the list of resource attributes that need to be added as labels/dimensions to the telemetry data for further enrichment.` |
| `definitions.OtelMetricsDataSource.properties.enrichWithResourceAttributes.description__added` | added | `Specifies the list of resource attributes that need to be added as labels/dimensions to the telemetry data for further enrichment.` |
| `definitions.OtelMetricsDirectDataSource.properties.enrichWithResourceAttributes.description__added` | added | `Specifies the list of resource attributes that need to be added as labels/dimensions to the telemetry data for further enrichment.` |
| `definitions.OtelTracesDataSource.properties.enrichWithResourceAttributes.description__added` | added | `Specifies the list of resource attributes that need to be added as labels/dimensions to the telemetry data for further enrichment.` |
| `definitions.OtelTracesDirectDataSource.properties.enrichWithResourceAttributes.description__added` | added | `Specifies the list of resource attributes that need to be added as labels/dimensions to the telemetry data for further enrichment.` |
| `paths['/{resourceUri}/providers/microsoft.Insights/dataCollectionRuleAssociations'].get.description__added` | added | `Lists associations for the specified resource.` |
| `paths['/{resourceUri}/providers/microsoft.Insights/dataCollectionRuleAssociations/{associationName}'].delete.description__added` | added | `Deletes an association.` |
| `paths['/{resourceUri}/providers/microsoft.Insights/dataCollectionRuleAssociations/{associationName}'].get.description__added` | added | `Returns the specified association.` |
| `paths['/{resourceUri}/providers/microsoft.Insights/dataCollectionRuleAssociations/{associationName}'].put.description__added` | added | `Creates or updates an association.` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/dataCollectionEndpoints'].get.description__added` | added | `Lists all data collection endpoints in the specified subscription` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/dataCollectionRules'].get.description__added` | added | `Lists all data collection rules in the specified subscription.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionEndpoints'].get.description__added` | added | `Lists all data collection endpoints in the specified resource group.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionEndpoints/{dataCollectionEndpointName}'].delete.description__added` | added | `Deletes a data collection endpoint.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionEndpoints/{dataCollectionEndpointName}'].get.description__added` | added | `Returns the specified data collection endpoint.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionEndpoints/{dataCollectionEndpointName}'].patch.description__added` | added | `Updates part of a data collection endpoint.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionEndpoints/{dataCollectionEndpointName}'].put.description__added` | added | `Creates or updates a data collection endpoint.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionEndpoints/{dataCollectionEndpointName}/associations'].get.description__added` | added | `Lists associations for the specified data collection endpoint.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionRules'].get.description__added` | added | `Lists all data collection rules in the specified resource group.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionRules/{dataCollectionRuleName}'].delete.description__added` | added | `Deletes a data collection rule.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionRules/{dataCollectionRuleName}'].get.description__added` | added | `Returns the specified data collection rule.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionRules/{dataCollectionRuleName}'].patch.description__added` | added | `Updates part of a data collection rule.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionRules/{dataCollectionRuleName}'].put.description__added` | added | `Creates or updates a data collection rule.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionRules/{dataCollectionRuleName}/associations'].get.description__added` | added | `Lists associations for the specified data collection rule.` |

### Changes for `EnrichWithResourceAttributes`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnrichWithResourceAttributes__deleted` | deleted | `{"type":"array","description":"Specifies the list of resource attributes that need to be added as la...` |

### Changes for `DataCollectionEndpointConfigurationAccess`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpointConfigurationAccess__added` | added | `{"type":"object","description":"The endpoint used by clients to access their configuration.","allOf"...` |

### Changes for `DataCollectionEndpointFailoverConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpointFailoverConfiguration__added` | added | `{"type":"object","description":"Metadata for the resource. This property can only be updated by Log ...` |

### Changes for `DataCollectionEndpointLogsIngestion`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpointLogsIngestion__added` | added | `{"type":"object","description":"The endpoint used by clients to ingest logs.","allOf":[{"$ref":"#/de...` |

### Changes for `DataCollectionEndpointMetadata`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpointMetadata__added` | added | `{"type":"object","description":"Metadata for the resource. This property can only be updated by Log ...` |

### Changes for `DataCollectionEndpointMetricsIngestion`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpointMetricsIngestion__added` | added | `{"type":"object","description":"The endpoint used by clients to ingest metrics.","allOf":[{"$ref":"#...` |

### Changes for `DataCollectionEndpointNetworkAcls`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpointNetworkAcls__added` | added | `{"type":"object","description":"Network access control rules for the endpoints.","allOf":[{"$ref":"#...` |

### Changes for `DataCollectionEndpointResourceIdentity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpointResourceIdentity__added` | added | `{"type":"object","description":"Managed service identity of the resource.","allOf":[{"$ref":"../../....` |

### Changes for `DataCollectionEndpointResourceProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpointResourceProperties__added` | added | `{"type":"object","allOf":[{"$ref":"#/definitions/DataCollectionEndpoint"}]}` |

### Changes for `DataCollectionEndpointResourceSku`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpointResourceSku__added` | added | `{"type":"object","description":"The SKU of the resource.","allOf":[{"$ref":"../../../common-types/re...` |

### Changes for `DataCollectionEndpointResourceSystemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpointResourceSystemData__added` | added | `{"type":"object","description":"Metadata pertaining to creation and last modification of the resourc...` |

### Changes for `DataCollectionRuleAgentSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionRuleAgentSettings__added` | added | `{"type":"object","description":"Agent settings used to modify agent behavior on a given host","allOf...` |

### Changes for `DataCollectionRuleAssociationMetadata`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionRuleAssociationMetadata__added` | added | `{"type":"object","description":"Metadata about the resource","allOf":[{"$ref":"#/definitions/Metadat...` |

### Changes for `DataCollectionRuleAssociationProxyOnlyResourceProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionRuleAssociationProxyOnlyResourceProperties__added` | added | `{"type":"object","allOf":[{"$ref":"#/definitions/DataCollectionRuleAssociation"}]}` |

### Changes for `DataCollectionRuleAssociationProxyOnlyResourceSystemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionRuleAssociationProxyOnlyResourceSystemData__added` | added | `{"type":"object","description":"Metadata pertaining to creation and last modification of the resourc...` |

### Changes for `DataCollectionRuleDataSources`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionRuleDataSources__added` | added | `{"type":"object","description":"The specification of data sources.\\nThis property is optional and ca...` |

### Changes for `DataCollectionRuleDestinations`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionRuleDestinations__added` | added | `{"type":"object","description":"The specification of destinations.","allOf":[{"$ref":"#/definitions/...` |

### Changes for `DataCollectionRuleDirectDataSources`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionRuleDirectDataSources__added` | added | `{"type":"object","description":"The specification of direct data sources.\\nThis property is optional...` |

### Changes for `DataCollectionRuleEndpoints`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionRuleEndpoints__added` | added | `{"type":"object","description":"Defines the ingestion endpoints to send data to via this rule.","all...` |

### Changes for `DataCollectionRuleIngestionQuotas`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionRuleIngestionQuotas__added` | added | `{"type":"object","description":"The specification for ingestion limits","allOf":[{"$ref":"#/definiti...` |

### Changes for `DataCollectionRuleMetadata`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionRuleMetadata__added` | added | `{"type":"object","description":"Metadata about the resource","allOf":[{"$ref":"#/definitions/Metadat...` |

### Changes for `DataCollectionRuleReferences`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionRuleReferences__added` | added | `{"type":"object","description":"Defines all the references that may be used in other sections of the...` |

### Changes for `DataCollectionRuleResourceIdentity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionRuleResourceIdentity__added` | added | `{"type":"object","description":"Managed service identity of the resource.","allOf":[{"$ref":"../../....` |

### Changes for `DataCollectionRuleResourceProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionRuleResourceProperties__added` | added | `{"type":"object","allOf":[{"$ref":"#/definitions/DataCollectionRule"}]}` |

### Changes for `DataCollectionRuleResourceSku`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionRuleResourceSku__added` | added | `{"type":"object","description":"The SKU of the resource.","allOf":[{"$ref":"../../../common-types/re...` |

### Changes for `DataCollectionRuleResourceSystemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionRuleResourceSystemData__added` | added | `{"type":"object","description":"Metadata pertaining to creation and last modification of the resourc...` |

### Changes for `DataImportSourcesEventHub`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataImportSourcesEventHub__added` | added | `{"type":"object","description":"Definition of Event Hub configuration.","allOf":[{"$ref":"#/definiti...` |

### Changes for `DataSourcesSpecDataImports`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataSourcesSpecDataImports__added` | added | `{"type":"object","description":"Specifications of pull based data sources","allOf":[{"$ref":"#/defin...` |

### Changes for `DestinationsSpecAzureMonitorMetrics`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DestinationsSpecAzureMonitorMetrics__added` | added | `{"type":"object","description":"Azure Monitor Metrics destination.","allOf":[{"$ref":"#/definitions/...` |

### Changes for `IngestionQuotasLogs`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IngestionQuotasLogs__added` | added | `{"type":"object","allOf":[{"$ref":"#/definitions/LogsQuotaSpec"}]}` |

### Changes for `LogFileSettingsText`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogFileSettingsText__added` | added | `{"type":"object","description":"Text settings","allOf":[{"$ref":"#/definitions/LogFileTextSettings"}...` |

### Changes for `LogFilesDataSourceSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogFilesDataSourceSettings__added` | added | `{"type":"object","description":"The log files specific settings.","allOf":[{"$ref":"#/definitions/Lo...` |

### Changes for `OtelLogsDataSourceResourceAttributeRouting`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OtelLogsDataSourceResourceAttributeRouting__added` | added | `{"type":"object","description":"Specifies the routing policy based on OTLP payload resource attribut...` |

### Changes for `OtelMetricsDataSourceResourceAttributeRouting`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OtelMetricsDataSourceResourceAttributeRouting__added` | added | `{"type":"object","description":"Specifies the routing policy based on OTLP payload resource attribut...` |

### Changes for `OtelTracesDataSourceResourceAttributeRouting`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OtelTracesDataSourceResourceAttributeRouting__added` | added | `{"type":"object","description":"Specifies the routing policy based on OTLP payload resource attribut...` |

### Changes for `ReferencesSpecEnrichmentData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ReferencesSpecEnrichmentData__added` | added | `{"type":"object","description":"All the enrichment data sources referenced in data flows","allOf":[{...` |

### Changes for `ResourceForUpdateIdentity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResourceForUpdateIdentity__added` | added | `{"type":"object","description":"Managed Service Identity.","allOf":[{"$ref":"../../../common-types/r...` |

### Changes for `example`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdxDestination.properties.databaseName.example__deleted` | deleted | `MyDatabase` |
| `definitions.AdxDestination.properties.ingestionUri.example__deleted` | deleted | `https://ingest-azcore1.southeastasia.kusto.windows.net` |
| `definitions.AdxDestination.properties.name.example__deleted` | deleted | `myDest1` |
| `definitions.AdxDestination.properties.resourceId.example__deleted` | deleted | `/subscriptions/6f1b91a9-5242-4017-bc01-e262558ddab7/resourceGroups/myrg/providers/Microsoft.Kusto/clusters/myAdx` |
| `definitions.ApplicationInsights.properties.resourceId.example__deleted` | deleted | `/subscriptions/703362b3-f278-4e4b-9179-c76eaf41ffc2/resourceGroups/amcs/providers/microsoft.insights/components/ai01` |
| `definitions.AzureMonitorMetricsDestination.properties.name.example__deleted` | deleted | `myDest1` |
| `definitions.ConfigurationAccessEndpointSpec.properties.endpoint.example__deleted` | deleted | `https://mydce-abcd.eastus-1.control.monitor.azure.com` |
| `definitions.DataCollectionEndpoint.properties.immutableId.example__deleted` | deleted | `dce-b74e0d383fc9415abaa584ec41adece3` |
| `definitions.DataCollectionEndpoint.properties.provisioningState.example__deleted` | deleted | `Creating` |
| `definitions.DataCollectionEndpointResource.properties.kind.example__deleted` | deleted | `Linux` |
| `definitions.DataCollectionRule.properties.dataCollectionEndpointId.example__deleted` | deleted | `/subscriptions/703362b3-f278-4e4b-9179-c76eaf41ffc2/resourceGroups/myResourceGroup/providers/Microsoft.Insights/dataCollectionEndpoints/myCollectionEndpoint` |
| `definitions.DataCollectionRule.properties.immutableId.example__deleted` | deleted | `dcr-b74e0d383fc9415abaa584ec41adece3` |
| `definitions.DataCollectionRule.properties.provisioningState.example__deleted` | deleted | `Creating` |
| `definitions.DataCollectionRuleAssociation.properties.dataCollectionEndpointId.example__deleted` | deleted | `/subscriptions/703362b3-f278-4e4b-9179-c76eaf41ffc2/resourceGroups/myResourceGroup/providers/Microsoft.Insights/dataCollectionEndpoints/myCollectionEndpoint` |
| `definitions.DataCollectionRuleAssociation.properties.dataCollectionRuleId.example__deleted` | deleted | `/subscriptions/703362b3-f278-4e4b-9179-c76eaf41ffc2/resourceGroups/myResourceGroup/providers/Microsoft.Insights/dataCollectionRules/myCollectionRule` |
| `definitions.DataCollectionRuleAssociation.properties.provisioningState.example__deleted` | deleted | `Creating` |
| `definitions.DataCollectionRuleResource.properties.kind.example__deleted` | deleted | `Linux` |
| `definitions.DataFlow.properties.builtInTransform.example__deleted` | deleted | `"Syslog-CRON"` |
| `definitions.DataFlow.properties.destinations.example__deleted` | deleted | `["myLogAnalyticsDest1","myStreamDest2"]` |
| `definitions.DataFlow.properties.outputStream.example__deleted` | deleted | `"Microsoft-SecurityEvent"` |
| `definitions.DataFlow.properties.streams.example__deleted` | deleted | `["Microsoft-SecurityEvent","Microsoft-WindowsEvent"]` |
| `definitions.EndpointsSpec.properties.logsIngestion.example__deleted` | deleted | `https://dcrname-abcd.eastus-1.ingest.monitor.azure.com` |
| `definitions.EndpointsSpec.properties.metricsIngestion.example__deleted` | deleted | `https://dcrname-abcd.eastus-1.metrics.ingest.monitor.azure.com` |
| `definitions.EtwProviderDataSource.properties.eventIds.example__deleted` | deleted | `["61701","61702"]` |
| `definitions.EtwProviderDataSource.properties.keyword.example__deleted` | deleted | `4611686018427387904` |
| `definitions.EtwProviderDataSource.properties.logLevel.example__deleted` | deleted | `Warning` |
| `definitions.EtwProviderDataSource.properties.name.example__deleted` | deleted | `myDataSource1` |
| `definitions.EtwProviderDataSource.properties.provider.example__deleted` | deleted | `Microsoft-ServiceFabric-Actors` |
| `definitions.EtwProviderDataSource.properties.providerType.example__deleted` | deleted | `EventSource` |
| `definitions.EtwProviderDataSource.properties.streams.example__deleted` | deleted | `["Custom-ServiceFabricSystemEventTable"]` |
| `definitions.EventHubDataSource.properties.name.example__deleted` | deleted | `myDataSource1` |
| `definitions.EventHubDestination.properties.eventHubResourceId.example__deleted` | deleted | `/subscriptions/703362b3-f278-4e4b-9179-c76eaf41ffc2/resourceGroups/amcs/providers/Microsoft.EventHub/namespaces/foo/eventhubs/bar` |
| `definitions.EventHubDestination.properties.name.example__deleted` | deleted | `myDest1` |
| `definitions.EventHubDirectDestination.properties.eventHubResourceId.example__deleted` | deleted | `/subscriptions/703362b3-f278-4e4b-9179-c76eaf41ffc2/resourceGroups/amcs/providers/Microsoft.EventHub/namespaces/foo/eventhubs/bar` |
| `definitions.EventHubDirectDestination.properties.name.example__deleted` | deleted | `myDest1` |
| `definitions.ExtensionDataSource.properties.extensionName.example__deleted` | deleted | `AzureSecurityLinuxAgent` |
| `definitions.ExtensionDataSource.properties.extensionSettings.example__deleted` | deleted | `{"frequency":15,"verbosity":2}` |
| `definitions.ExtensionDataSource.properties.name.example__deleted` | deleted | `myDataSource1` |
| `definitions.ExtensionDataSource.properties.streams.example__deleted` | deleted | `["Microsoft-SecurityEvent","Microsoft-Perf","Microsoft-Syslog"]` |
| `definitions.FailoverConfigurationSpec.properties.activeLocation.example__deleted` | deleted | `East US` |
| `definitions.IisLogsDataSource.properties.logDirectories.example__deleted` | deleted | `["C:\\\\scratch\\\\demo\\\\W3SVC1","C:\\\\scratch\\\\demo2\\\\W3SVC1"]` |
| `definitions.IisLogsDataSource.properties.name.example__deleted` | deleted | `myDataSource1` |
| `definitions.IisLogsDataSource.properties.streams.example__deleted` | deleted | `["Microsoft-W3CIISLog"]` |
| `definitions.IisLogsDataSource.properties.transformKql.example__deleted` | deleted | `source` |
| `definitions.LocationSpec.properties.location.example__deleted` | deleted | `East US` |
| `definitions.LocationSpec.properties.provisioningStatus.example__deleted` | deleted | `Creating` |
| `definitions.LogAnalyticsDestination.properties.name.example__deleted` | deleted | `myDest1` |
| `definitions.LogAnalyticsDestination.properties.workspaceId.example__deleted` | deleted | `9ba8bc53-bd36-4156-8667-e983e7ae0e4f` |
| `definitions.LogAnalyticsDestination.properties.workspaceResourceId.example__deleted` | deleted | `/subscriptions/703362b3-f278-4e4b-9179-c76eaf41ffc2/resourceGroups/myResourceGroup/providers/Microsoft.OperationalInsights/workspaces/centralTeamWorkspace` |
| `definitions.LogFilesDataSource.properties.filePatterns.example__deleted` | deleted | `["C:\\\\JavaLogs\\\\*.log"]` |
| `definitions.LogFilesDataSource.properties.format.example__deleted` | deleted | `text` |
| `definitions.LogFilesDataSource.properties.name.example__deleted` | deleted | `myDataSource1` |
| `definitions.LogFilesDataSource.properties.streams.example__deleted` | deleted | `["Custom-JavaLogs"]` |
| `definitions.LogFilesDataSource.properties.transformKql.example__deleted` | deleted | `source` |
| `definitions.LogFileTextSettings.properties.recordStartTimestampFormat.example__deleted` | deleted | `ISO 8601, yyyy-MM-dd HH:mm:ss` |
| `definitions.LogsIngestionEndpointSpec.properties.endpoint.example__deleted` | deleted | `https://mydce-abcd.eastus-1.control.monitor.azure.com` |
| `definitions.Metadata.properties.provisionedBy.example__deleted` | deleted | `Azure Security Center` |
| `definitions.Metadata.properties.provisionedByImmutableId.example__deleted` | deleted | `baeea43c-db35-4d6f-9d3b-26d3a5e792e2` |
| `definitions.Metadata.properties.provisionedByResourceId.example__deleted` | deleted | `/subscriptions/da58aca0-2082-4f5a-85ba-27344286c17c/resourceGroups/ws-rg/providers/Microsoft.OperationalInsights/workspaces/ws-name1` |
| `definitions.MetricsIngestionEndpointSpec.properties.endpoint.example__deleted` | deleted | `https://mydce-abcd.eastus-1.control.monitor.azure.com` |
| `definitions.MicrosoftFabricDestination.properties.artifactId.example__deleted` | deleted | `da58aca0-2082-4f5a-85ba-27344286c17c` |
| `definitions.MicrosoftFabricDestination.properties.databaseName.example__deleted` | deleted | `MyDatabase` |
| `definitions.MicrosoftFabricDestination.properties.ingestionUri.example__deleted` | deleted | `https://ingest-azcore1.southeastasia.kusto.windows.net` |
| `definitions.MicrosoftFabricDestination.properties.name.example__deleted` | deleted | `myDest1` |
| `definitions.MicrosoftFabricDestination.properties.tenantId.example__deleted` | deleted | `984ff517-3441-4eb8-bb25-8e4c0e1334e9` |
| `definitions.MonitoringAccountDestination.properties.accountId.example__deleted` | deleted | `a6a097e1-15e9-42bc-8f48-fcddd804d0f3` |
| `definitions.MonitoringAccountDestination.properties.accountResourceId.example__deleted` | deleted | `/subscriptions/703362b3-f278-4e4b-9179-c76eaf41ffc2/resourceGroups/myResourceGroup/providers/Microsoft.Monitor/accounts/centralTeamAccount` |
| `definitions.MonitoringAccountDestination.properties.name.example__deleted` | deleted | `myDest1` |
| `definitions.OtelDataSourceResourceAttributeRouting.properties.attributeName.example__deleted` | deleted | `service.name` |
| `definitions.OtelDataSourceResourceAttributeRouting.properties.attributeValue.example__deleted` | deleted | `myServiceName` |
| `definitions.OtelLogsDataSource.properties.enrichWithReference.example__deleted` | deleted | `myAI` |
| `definitions.OtelLogsDataSource.properties.name.example__deleted` | deleted | `myDataSource1` |
| `definitions.OtelLogsDataSource.properties.replaceResourceIdWithReference.example__deleted` | deleted | `true` |
| `definitions.OtelLogsDataSource.properties.streams.example__deleted` | deleted | `["Microsoft-OtelLogs"]` |
| `definitions.OtelLogsDirectDataSource.properties.enrichWithReference.example__deleted` | deleted | `myAI` |
| `definitions.OtelLogsDirectDataSource.properties.name.example__deleted` | deleted | `myDataSource1` |
| `definitions.OtelLogsDirectDataSource.properties.replaceResourceIdWithReference.example__deleted` | deleted | `true` |
| `definitions.OtelLogsDirectDataSource.properties.streams.example__deleted` | deleted | `["Microsoft-OtelLogs"]` |
| `definitions.OtelMetricsDataSource.properties.enrichWithReference.example__deleted` | deleted | `myAI` |
| `definitions.OtelMetricsDataSource.properties.name.example__deleted` | deleted | `myDataSource1` |
| `definitions.OtelMetricsDataSource.properties.streams.example__deleted` | deleted | `["Custom-Metrics-MyMetrics"]` |
| `definitions.OtelMetricsDirectDataSource.properties.enrichWithReference.example__deleted` | deleted | `myAI` |
| `definitions.OtelMetricsDirectDataSource.properties.name.example__deleted` | deleted | `myDataSource1` |
| `definitions.OtelMetricsDirectDataSource.properties.streams.example__deleted` | deleted | `["Custom-Metrics-MyMetrics"]` |
| `definitions.OtelTracesDataSource.properties.enrichWithReference.example__deleted` | deleted | `myAI` |
| `definitions.OtelTracesDataSource.properties.name.example__deleted` | deleted | `myDataSource1` |
| `definitions.OtelTracesDataSource.properties.replaceResourceIdWithReference.example__deleted` | deleted | `true` |
| `definitions.OtelTracesDataSource.properties.streams.example__deleted` | deleted | `["Microsoft-OtelSpans","Microsoft-OtelEvents","Microsoft-OtelResources"]` |
| `definitions.OtelTracesDirectDataSource.properties.enrichWithReference.example__deleted` | deleted | `myAI` |
| `definitions.OtelTracesDirectDataSource.properties.name.example__deleted` | deleted | `myDataSource1` |
| `definitions.OtelTracesDirectDataSource.properties.replaceResourceIdWithReference.example__deleted` | deleted | `true` |
| `definitions.OtelTracesDirectDataSource.properties.streams.example__deleted` | deleted | `["Microsoft-OtelSpans","Microsoft-OtelEvents","Microsoft-OtelResources"]` |
| `definitions.PerfCounterDataSource.properties.counterSpecifiers.example__deleted` | deleted | `["\\\\Processor(_Total)\\\\% Processor Time","\\\\Memory\\\\Committed Bytes"]` |
| `definitions.PerfCounterDataSource.properties.name.example__deleted` | deleted | `myDataSource1` |
| `definitions.PerfCounterDataSource.properties.samplingFrequencyInSeconds.example__deleted` | deleted | `15` |
| `definitions.PerfCounterDataSource.properties.streams.example__deleted` | deleted | `["Microsoft-Perf","Microsoft-InsightsMetrics"]` |
| `definitions.PerfCounterDataSource.properties.transformKql.example__deleted` | deleted | `source` |
| `definitions.PerformanceCountersOTelDataSource.properties.counterSpecifiers.example__deleted` | deleted | `["system.cpu.time","system.memory.utilization"]` |
| `definitions.PerformanceCountersOTelDataSource.properties.name.example__deleted` | deleted | `myDataSource1` |
| `definitions.PerformanceCountersOTelDataSource.properties.samplingFrequencyInSeconds.example__deleted` | deleted | `15` |
| `definitions.PerformanceCountersOTelDataSource.properties.streams.example__deleted` | deleted | `["Microsoft-OtelPerfMetrics"]` |
| `definitions.PlatformTelemetryDataSource.properties.name.example__deleted` | deleted | `myDataSource1` |
| `definitions.PlatformTelemetryDataSource.properties.streams.example__deleted` | deleted | `["Microsoft.Cache/redis:Metrics"]` |
| `definitions.PrivateLinkScopedResource.properties.resourceId.example__deleted` | deleted | `/subscriptions/57947cb5-aadd-4b6c-9e8e-2125e5cb7bf5/resourceGroups/testResourceGroup/providers/microsoft.insights/privatelinkscopes/my-scope/scopedResources/my-scoped-resource` |
| `definitions.PrivateLinkScopedResource.properties.scopeId.example__deleted` | deleted | `b74e0d-383fc9415abaa-584ec41-adece3` |
| `definitions.PrometheusForwarderDataSource.properties.labelIncludeFilter.example__deleted` | deleted | `{"microsoft_metrics_include_label":"dashboard"}` |
| `definitions.PrometheusForwarderDataSource.properties.name.example__deleted` | deleted | `myDataSource1` |
| `definitions.PrometheusForwarderDataSource.properties.streams.example__deleted` | deleted | `["Microsoft-PrometheusMetrics"]` |
| `definitions.StorageBlob.properties.blobUrl.example__deleted` | deleted | `https://storage01.blob.core.windows.net/folder/blob.csv` |
| `definitions.StorageBlob.properties.lookupType.example__deleted` | deleted | `Text` |
| `definitions.StorageBlob.properties.resourceId.example__deleted` | deleted | `/subscriptions/703362b3-f278-4e4b-9179-c76eaf41ffc2/resourceGroups/amcs/providers/Microsoft.Storage/storageAccounts/storage01` |
| `definitions.StorageBlobDestination.properties.containerName.example__deleted` | deleted | `foobar` |
| `definitions.StorageBlobDestination.properties.name.example__deleted` | deleted | `myDest1` |
| `definitions.StorageBlobDestination.properties.storageAccountResourceId.example__deleted` | deleted | `/subscriptions/ee63c5dc-9b88-42e3-8070-944a5226aea3/resourceGroups/foo/providers/Microsoft.Storage/storageAccounts/bar` |
| `definitions.StorageTableDestination.properties.name.example__deleted` | deleted | `myDest1` |
| `definitions.StorageTableDestination.properties.storageAccountResourceId.example__deleted` | deleted | `/subscriptions/ee63c5dc-9b88-42e3-8070-944a5226aea3/resourceGroups/foo/providers/Microsoft.Storage/storageAccounts/bar` |
| `definitions.StorageTableDestination.properties.tableName.example__deleted` | deleted | `foobar` |
| `definitions.SyslogDataSource.properties.facilityNames.example__deleted` | deleted | `["cron","syslog"]` |
| `definitions.SyslogDataSource.properties.name.example__deleted` | deleted | `myDataSource1` |
| `definitions.SyslogDataSource.properties.streams.example__deleted` | deleted | `["Microsoft-Syslog"]` |
| `definitions.SyslogDataSource.properties.transformKql.example__deleted` | deleted | `source` |
| `definitions.WindowsEventLogDataSource.properties.name.example__deleted` | deleted | `myDataSource1` |
| `definitions.WindowsEventLogDataSource.properties.streams.example__deleted` | deleted | `["Microsoft-WindowsEvent","Microsoft-Event"]` |
| `definitions.WindowsEventLogDataSource.properties.transformKql.example__deleted` | deleted | `source` |
| `definitions.WindowsEventLogDataSource.properties.xPathQueries.example__deleted` | deleted | `["Security!*","System!*[System[(Level = 1 or Level = 2 or Level = 3)]]"]` |
| `definitions.WindowsFirewallLogsDataSource.properties.name.example__deleted` | deleted | `myDataSource1` |
| `definitions.WindowsFirewallLogsDataSource.properties.streams.example__deleted` | deleted | `["Microsoft-WindowsFirewall"]` |

### Changes for `x-ms-mutability`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdxDestination.properties.ingestionUri['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.ConfigurationAccessEndpointSpec.properties.endpoint['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DataCollectionEndpoint.properties.failoverConfiguration['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DataCollectionEndpoint.properties.metadata['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DataCollectionEndpoint.properties.privateLinkScopedResources['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DataCollectionEndpoint.properties.provisioningState['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DataCollectionEndpointResource.properties.etag['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DataCollectionRule.properties.endpoints['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DataCollectionRule.properties.immutableId['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DataCollectionRule.properties.ingestionQuotas['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DataCollectionRule.properties.metadata['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DataCollectionRule.properties.provisioningState['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DataCollectionRuleAssociation.properties.metadata['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DataCollectionRuleAssociation.properties.provisioningState['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DataCollectionRuleAssociationProxyOnlyResource.properties.etag['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DataCollectionRuleResource.properties.etag['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.EndpointsSpec.properties.logsIngestion['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.EndpointsSpec.properties.metricsIngestion['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.LogAnalyticsDestination.properties.workspaceId['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.LogsIngestionEndpointSpec.properties.endpoint['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.Metadata.properties.provisionedBy['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.Metadata.properties.provisionedByImmutableId['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.Metadata.properties.provisionedByResourceId['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.MetricsIngestionEndpointSpec.properties.endpoint['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.MonitoringAccountDestination.properties.accountId['x-ms-mutability__deleted']` | deleted | `["read"]` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpoint.properties.configurationAccess.allOf__deleted` | deleted | `[{"$ref":"#/definitions/ConfigurationAccessEndpointSpec"}]` |
| `definitions.DataCollectionEndpoint.properties.failoverConfiguration.allOf__deleted` | deleted | `[{"$ref":"#/definitions/FailoverConfigurationSpec"}]` |
| `definitions.DataCollectionEndpoint.properties.logsIngestion.allOf__deleted` | deleted | `[{"$ref":"#/definitions/LogsIngestionEndpointSpec"}]` |
| `definitions.DataCollectionEndpoint.properties.metadata.allOf__deleted` | deleted | `[{"$ref":"#/definitions/Metadata"}]` |
| `definitions.DataCollectionEndpoint.properties.metricsIngestion.allOf__deleted` | deleted | `[{"$ref":"#/definitions/MetricsIngestionEndpointSpec"}]` |
| `definitions.DataCollectionEndpoint.properties.networkAcls.allOf__deleted` | deleted | `[{"$ref":"#/definitions/NetworkRuleSet"}]` |
| `definitions.DataCollectionEndpointResource.allOf__added` | added | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource"}]` |
| `definitions.DataCollectionEndpointResource.properties.identity.allOf__deleted` | deleted | `[{"$ref":"../../../../../../common-types/resource-management/v5/managedidentity.json#/definitions/Ma...` |
| `definitions.DataCollectionEndpointResource.properties.properties.allOf__deleted` | deleted | `[{"$ref":"#/definitions/DataCollectionEndpoint"}]` |
| `definitions.DataCollectionEndpointResource.properties.sku.allOf__deleted` | deleted | `[{"$ref":"../../../../../../common-types/resource-management/v6/types.json#/definitions/Sku"}]` |
| `definitions.DataCollectionRule.properties.agentSettings.allOf__deleted` | deleted | `[{"$ref":"#/definitions/AgentSettingsSpec"}]` |
| `definitions.DataCollectionRule.properties.dataSources.allOf__deleted` | deleted | `[{"$ref":"#/definitions/DataSourcesSpec"}]` |
| `definitions.DataCollectionRule.properties.destinations.allOf__deleted` | deleted | `[{"$ref":"#/definitions/DestinationsSpec"}]` |
| `definitions.DataCollectionRule.properties.directDataSources.allOf__deleted` | deleted | `[{"$ref":"#/definitions/DirectDataSourcesSpec"}]` |
| `definitions.DataCollectionRule.properties.endpoints.allOf__deleted` | deleted | `[{"$ref":"#/definitions/EndpointsSpec"}]` |
| `definitions.DataCollectionRule.properties.ingestionQuotas.allOf__deleted` | deleted | `[{"$ref":"#/definitions/IngestionQuotas"}]` |
| `definitions.DataCollectionRule.properties.metadata.allOf__deleted` | deleted | `[{"$ref":"#/definitions/Metadata"}]` |
| `definitions.DataCollectionRule.properties.references.allOf__deleted` | deleted | `[{"$ref":"#/definitions/ReferencesSpec"}]` |
| `definitions.DataCollectionRuleAssociation.properties.metadata.allOf__deleted` | deleted | `[{"$ref":"#/definitions/Metadata"}]` |
| `definitions.DataCollectionRuleAssociationProxyOnlyResource.allOf__added` | added | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |
| `definitions.DataCollectionRuleAssociationProxyOnlyResource.properties.properties.allOf__deleted` | deleted | `[{"$ref":"#/definitions/DataCollectionRuleAssociation"}]` |
| `definitions.DataCollectionRuleResource.allOf__added` | added | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource"}]` |
| `definitions.DataCollectionRuleResource.properties.identity.allOf__deleted` | deleted | `[{"$ref":"../../../../../../common-types/resource-management/v5/managedidentity.json#/definitions/Ma...` |
| `definitions.DataCollectionRuleResource.properties.properties.allOf__deleted` | deleted | `[{"$ref":"#/definitions/DataCollectionRule"}]` |
| `definitions.DataCollectionRuleResource.properties.sku.allOf__deleted` | deleted | `[{"$ref":"../../../../../../common-types/resource-management/v6/types.json#/definitions/Sku"}]` |
| `definitions.DataImportSources.properties.eventHub.allOf__deleted` | deleted | `[{"$ref":"#/definitions/EventHubDataSource"}]` |
| `definitions.DataSourcesSpec.properties.dataImports.allOf__deleted` | deleted | `[{"$ref":"#/definitions/DataImportSources"}]` |
| `definitions.DestinationsSpec.properties.azureMonitorMetrics.allOf__deleted` | deleted | `[{"$ref":"#/definitions/AzureMonitorMetricsDestination"}]` |
| `definitions.IngestionQuotas.properties.logs.allOf__deleted` | deleted | `[{"$ref":"#/definitions/LogsQuotaSpec"}]` |
| `definitions.LogFilesDataSource.properties.settings.allOf__deleted` | deleted | `[{"$ref":"#/definitions/LogFileSettings"}]` |
| `definitions.LogFileSettings.properties.text.allOf__deleted` | deleted | `[{"$ref":"#/definitions/LogFileTextSettings"}]` |
| `definitions.OtelLogsDataSource.properties.resourceAttributeRouting.allOf__deleted` | deleted | `[{"$ref":"#/definitions/OtelDataSourceResourceAttributeRouting"}]` |
| `definitions.OtelMetricsDataSource.properties.resourceAttributeRouting.allOf__deleted` | deleted | `[{"$ref":"#/definitions/OtelDataSourceResourceAttributeRouting"}]` |
| `definitions.OtelTracesDataSource.properties.resourceAttributeRouting.allOf__deleted` | deleted | `[{"$ref":"#/definitions/OtelDataSourceResourceAttributeRouting"}]` |
| `definitions.ReferencesSpec.properties.enrichmentData.allOf__deleted` | deleted | `[{"$ref":"#/definitions/EnrichmentData"}]` |
| `definitions.ResourceForUpdate.properties.identity.allOf__deleted` | deleted | `[{"$ref":"../../../../../../common-types/resource-management/v5/managedidentity.json#/definitions/Ma...` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpoint.properties.configurationAccess.$ref__added` | added | `#/definitions/DataCollectionEndpointConfigurationAccess` |
| `definitions.DataCollectionEndpoint.properties.failoverConfiguration.$ref__added` | added | `#/definitions/DataCollectionEndpointFailoverConfiguration` |
| `definitions.DataCollectionEndpoint.properties.logsIngestion.$ref__added` | added | `#/definitions/DataCollectionEndpointLogsIngestion` |
| `definitions.DataCollectionEndpoint.properties.metadata.$ref__added` | added | `#/definitions/DataCollectionEndpointMetadata` |
| `definitions.DataCollectionEndpoint.properties.metricsIngestion.$ref__added` | added | `#/definitions/DataCollectionEndpointMetricsIngestion` |
| `definitions.DataCollectionEndpoint.properties.networkAcls.$ref__added` | added | `#/definitions/DataCollectionEndpointNetworkAcls` |
| `definitions.DataCollectionEndpointResource.properties.identity.$ref__added` | added | `#/definitions/DataCollectionEndpointResourceIdentity` |
| `definitions.DataCollectionEndpointResource.properties.properties.$ref__added` | added | `#/definitions/DataCollectionEndpointResourceProperties` |
| `definitions.DataCollectionEndpointResource.properties.sku.$ref__added` | added | `#/definitions/DataCollectionEndpointResourceSku` |
| `definitions.DataCollectionRule.properties.agentSettings.$ref__added` | added | `#/definitions/DataCollectionRuleAgentSettings` |
| `definitions.DataCollectionRule.properties.dataSources.$ref__added` | added | `#/definitions/DataCollectionRuleDataSources` |
| `definitions.DataCollectionRule.properties.destinations.$ref__added` | added | `#/definitions/DataCollectionRuleDestinations` |
| `definitions.DataCollectionRule.properties.directDataSources.$ref__added` | added | `#/definitions/DataCollectionRuleDirectDataSources` |
| `definitions.DataCollectionRule.properties.endpoints.$ref__added` | added | `#/definitions/DataCollectionRuleEndpoints` |
| `definitions.DataCollectionRule.properties.ingestionQuotas.$ref__added` | added | `#/definitions/DataCollectionRuleIngestionQuotas` |
| `definitions.DataCollectionRule.properties.metadata.$ref__added` | added | `#/definitions/DataCollectionRuleMetadata` |
| `definitions.DataCollectionRule.properties.references.$ref__added` | added | `#/definitions/DataCollectionRuleReferences` |
| `definitions.DataCollectionRuleAssociation.properties.metadata.$ref__added` | added | `#/definitions/DataCollectionRuleAssociationMetadata` |
| `definitions.DataCollectionRuleAssociationProxyOnlyResource.properties.properties.$ref__added` | added | `#/definitions/DataCollectionRuleAssociationProxyOnlyResourceProperties` |
| `definitions.DataCollectionRuleResource.properties.identity.$ref__added` | added | `#/definitions/DataCollectionRuleResourceIdentity` |
| `definitions.DataCollectionRuleResource.properties.properties.$ref__added` | added | `#/definitions/DataCollectionRuleResourceProperties` |
| `definitions.DataCollectionRuleResource.properties.sku.$ref__added` | added | `#/definitions/DataCollectionRuleResourceSku` |
| `definitions.DataImportSources.properties.eventHub.$ref__added` | added | `#/definitions/DataImportSourcesEventHub` |
| `definitions.DataSourcesSpec.properties.dataImports.$ref__added` | added | `#/definitions/DataSourcesSpecDataImports` |
| `definitions.DestinationsSpec.properties.azureMonitorMetrics.$ref__added` | added | `#/definitions/DestinationsSpecAzureMonitorMetrics` |
| `definitions.IngestionQuotas.properties.logs.$ref__added` | added | `#/definitions/IngestionQuotasLogs` |
| `definitions.LogFilesDataSource.properties.settings.$ref__added` | added | `#/definitions/LogFilesDataSourceSettings` |
| `definitions.LogFileSettings.properties.text.$ref__added` | added | `#/definitions/LogFileSettingsText` |
| `definitions.OtelLogsDataSource.properties.enrichWithResourceAttributes.$ref__deleted` | deleted | `#/definitions/EnrichWithResourceAttributes` |
| `definitions.OtelLogsDataSource.properties.resourceAttributeRouting.$ref__added` | added | `#/definitions/OtelLogsDataSourceResourceAttributeRouting` |
| `definitions.OtelLogsDirectDataSource.properties.enrichWithResourceAttributes.$ref__deleted` | deleted | `#/definitions/EnrichWithResourceAttributes` |
| `definitions.OtelMetricsDataSource.properties.enrichWithResourceAttributes.$ref__deleted` | deleted | `#/definitions/EnrichWithResourceAttributes` |
| `definitions.OtelMetricsDataSource.properties.resourceAttributeRouting.$ref__added` | added | `#/definitions/OtelMetricsDataSourceResourceAttributeRouting` |
| `definitions.OtelMetricsDirectDataSource.properties.enrichWithResourceAttributes.$ref__deleted` | deleted | `#/definitions/EnrichWithResourceAttributes` |
| `definitions.OtelTracesDataSource.properties.enrichWithResourceAttributes.$ref__deleted` | deleted | `#/definitions/EnrichWithResourceAttributes` |
| `definitions.OtelTracesDataSource.properties.resourceAttributeRouting.$ref__added` | added | `#/definitions/OtelTracesDataSourceResourceAttributeRouting` |
| `definitions.OtelTracesDirectDataSource.properties.enrichWithResourceAttributes.$ref__deleted` | deleted | `#/definitions/EnrichWithResourceAttributes` |
| `definitions.ReferencesSpec.properties.enrichmentData.$ref__added` | added | `#/definitions/ReferencesSpecEnrichmentData` |
| `definitions.ResourceForUpdate.properties.identity.$ref__added` | added | `#/definitions/ResourceForUpdateIdentity` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpointResource.required__deleted` | deleted | `["location"]` |
| `definitions.DataCollectionRuleResource.required__deleted` | deleted | `["location"]` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpointResource.properties.location__deleted` | deleted | `{"type":"string","description":"The geo-location where the resource lives.","x-ms-mutability":["crea...` |
| `definitions.DataCollectionRuleResource.properties.location__deleted` | deleted | `{"type":"string","description":"The geo-location where the resource lives.","x-ms-mutability":["crea...` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpointResource.properties.tags__deleted` | deleted | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.DataCollectionRuleResource.properties.tags__deleted` | deleted | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpointResource.properties.id__deleted` | deleted | `{"type":"string","description":"Fully qualified ID of the resource.","readOnly":true,"example":"/sub...` |
| `definitions.DataCollectionRuleAssociationProxyOnlyResource.properties.id__deleted` | deleted | `{"type":"string","description":"Fully qualified ID of the resource.","readOnly":true,"example":"/sub...` |
| `definitions.DataCollectionRuleResource.properties.id__deleted` | deleted | `{"type":"string","description":"Fully qualified ID of the resource.","readOnly":true,"example":"/sub...` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpointResource.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource.","readOnly":true,"example":"myCollectionRu...` |
| `definitions.DataCollectionRuleAssociationProxyOnlyResource.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource.","readOnly":true,"example":"myCollectionRu...` |
| `definitions.DataCollectionRuleResource.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource.","readOnly":true,"example":"myCollectionRu...` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpointResource.properties.type__deleted` | deleted | `{"type":"string","description":"The type of the resource.","readOnly":true,"example":"Microsoft.Insi...` |
| `definitions.DataCollectionRuleAssociationProxyOnlyResource.properties.type__deleted` | deleted | `{"type":"string","description":"The type of the resource.","readOnly":true,"example":"Microsoft.Insi...` |
| `definitions.DataCollectionRuleResource.properties.type__deleted` | deleted | `{"type":"string","description":"The type of the resource.","readOnly":true,"example":"Microsoft.Insi...` |
| `definitions.ExtensionDataSource.properties.extensionSettings.type__deleted` | deleted | `object` |
| `definitions.OtelLogsDataSource.properties.enrichWithResourceAttributes.type__added` | added | `array` |
| `definitions.OtelLogsDirectDataSource.properties.enrichWithResourceAttributes.type__added` | added | `array` |
| `definitions.OtelMetricsDataSource.properties.enrichWithResourceAttributes.type__added` | added | `array` |
| `definitions.OtelMetricsDirectDataSource.properties.enrichWithResourceAttributes.type__added` | added | `array` |
| `definitions.OtelTracesDataSource.properties.enrichWithResourceAttributes.type__added` | added | `array` |
| `definitions.OtelTracesDirectDataSource.properties.enrichWithResourceAttributes.type__added` | added | `array` |
| `definitions.PrometheusForwarderDataSource.properties.customVMScrapeConfig.items.type__deleted` | deleted | `object` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataCollectionEndpointResource.properties.systemData__deleted` | deleted | `{"description":"Metadata pertaining to creation and last modification of the resource.","allOf":[{"$...` |
| `definitions.DataCollectionRuleAssociationProxyOnlyResource.properties.systemData__deleted` | deleted | `{"description":"Metadata pertaining to creation and last modification of the resource.","allOf":[{"$...` |
| `definitions.DataCollectionRuleResource.properties.systemData__deleted` | deleted | `{"description":"Metadata pertaining to creation and last modification of the resource.","allOf":[{"$...` |

### Changes for `title`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorResponseCommonV2.title__deleted` | deleted | `Error response` |

### Changes for `items`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OtelLogsDataSource.properties.enrichWithResourceAttributes.items__added` | added | `{"type":"string"}` |
| `definitions.OtelLogsDirectDataSource.properties.enrichWithResourceAttributes.items__added` | added | `{"type":"string"}` |
| `definitions.OtelMetricsDataSource.properties.enrichWithResourceAttributes.items__added` | added | `{"type":"string"}` |
| `definitions.OtelMetricsDirectDataSource.properties.enrichWithResourceAttributes.items__added` | added | `{"type":"string"}` |
| `definitions.OtelTracesDataSource.properties.enrichWithResourceAttributes.items__added` | added | `{"type":"string"}` |
| `definitions.OtelTracesDirectDataSource.properties.enrichWithResourceAttributes.items__added` | added | `{"type":"string"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AdxDestination.properties.name.description` | `A friendly name for the destination. 
This name should be unique across all destinations (regardless of type) within the data collection rule.` | `A friendly name for the destination.
This name should be unique across all destinations (regardless of type) within the data collection rule.` |
| `definitions.AgentSetting.properties.name.description` | `The name of the setting. 
Must be part of the list of supported settings` | `The name of the setting.
Must be part of the list of supported settings` |
| `definitions.AzureMonitorMetricsDestination.properties.name.description` | `A friendly name for the destination. 
This name should be unique across all destinations (regardless of type) within the data collection rule.` | `A friendly name for the destination.
This name should be unique across all destinations (regardless of type) within the data collection rule.` |
| `definitions.DataCollectionEndpointResource.properties.etag.description` | `Resource entity tag (ETag).` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.DataCollectionRule.properties.dataSources.description` | `The specification of data sources. 
 This property is optional and can be omitted if the rule is meant to be used via direct calls to the provisioned endpoint.` | `The specification of data sources.
This property is optional and can be omitted if the rule is meant to be used via direct calls to the provisioned endpoint.` |
| `definitions.DataCollectionRule.properties.directDataSources.description` | `The specification of direct data sources. 
 This property is optional and can be omitted.` | `The specification of direct data sources.
This property is optional and can be omitted.` |
| `definitions.DataCollectionRuleAssociationProxyOnlyResource.properties.etag.description` | `Resource entity tag (ETag).` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.DataCollectionRuleResource.properties.etag.description` | `Resource entity tag (ETag).` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.ErrorResponseCommonV2.properties.error.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorDetail` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorDetail` |
| `definitions.EtwProviderDataSource.properties.name.description` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` |
| `definitions.EventHubDataSource.properties.name.description` | `A friendly name for the data source. 
This name should be unique across all data sources (regardless of type) within the data collection rule.` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` |
| `definitions.EventHubDestination.properties.name.description` | `A friendly name for the destination. 
This name should be unique across all destinations (regardless of type) within the data collection rule.` | `A friendly name for the destination.
This name should be unique across all destinations (regardless of type) within the data collection rule.` |
| `definitions.EventHubDirectDestination.properties.name.description` | `A friendly name for the destination. 
This name should be unique across all destinations (regardless of type) within the data collection rule.` | `A friendly name for the destination.
This name should be unique across all destinations (regardless of type) within the data collection rule.` |
| `definitions.ExtensionDataSource.description` | `Definition of which data will be collected from a separate VM extension that integrates with the Azure Monitor Agent.
Collected from either Windows and Linux machines, depending on which extension is defined.` | `Definition of which data will be collected from a separate VM extension that integrates with the Azure Monitor Agent.
Collected from either Windows and Linux machines, depending on which extension is defined.` |
| `definitions.ExtensionDataSource.properties.name.description` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` |
| `definitions.ExtensionDataSource.properties.streams.description` | `List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.` | `List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.` |
| `definitions.IisLogsDataSource.properties.name.description` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` |
| `definitions.LogAnalyticsDestination.properties.name.description` | `A friendly name for the destination. 
This name should be unique across all destinations (regardless of type) within the data collection rule.` | `A friendly name for the destination.
This name should be unique across all destinations (regardless of type) within the data collection rule.` |
| `definitions.LogFilesDataSource.properties.name.description` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` |
| `definitions.LogFilesDataSource.properties.streams.description` | `List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data source` | `List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data source` |
| `definitions.MicrosoftFabricDestination.properties.name.description` | `A friendly name for the destination. 
This name should be unique across all destinations (regardless of type) within the data collection rule.` | `A friendly name for the destination.
This name should be unique across all destinations (regardless of type) within the data collection rule.` |
| `definitions.MonitoringAccountDestination.properties.name.description` | `A friendly name for the destination. 
This name should be unique across all destinations (regardless of type) within the data collection rule.` | `A friendly name for the destination.
This name should be unique across all destinations (regardless of type) within the data collection rule.` |
| `definitions.OtelLogsDataSource.properties.name.description` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` |
| `definitions.OtelLogsDirectDataSource.properties.name.description` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` |
| `definitions.OtelMetricsDataSource.properties.name.description` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` |
| `definitions.OtelMetricsDirectDataSource.properties.name.description` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` |
| `definitions.OtelTracesDataSource.properties.name.description` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` |
| `definitions.OtelTracesDataSource.properties.streams.description` | `List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.` | `List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.` |
| `definitions.OtelTracesDirectDataSource.properties.name.description` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` |
| `definitions.OtelTracesDirectDataSource.properties.streams.description` | `List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.` | `List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.` |
| `definitions.PerfCounterDataSource.description` | `Definition of which performance counters will be collected and how they will be collected by this data collection rule.
Collected from both Windows and Linux machines where the counter is present.` | `Definition of which performance counters will be collected and how they will be collected by this data collection rule.
Collected from both Windows and Linux machines where the counter is present.` |
| `definitions.PerfCounterDataSource.properties.counterSpecifiers.description` | `A list of specifier names of the performance counters you want to collect.
Use a wildcard (*) to collect a counter for all instances.
To get a list of performance counters on Windows, run the command 'typeperf'.` | `A list of specifier names of the performance counters you want to collect.
Use a wildcard (*) to collect a counter for all instances.
To get a list of performance counters on Windows, run the command 'typeperf'.` |
| `definitions.PerfCounterDataSource.properties.name.description` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` |
| `definitions.PerfCounterDataSource.properties.streams.description` | `List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.` | `List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.` |
| `definitions.PerformanceCountersOTelDataSource.description` | `Definition of which Open Telemetry performance counters will be collected and how they will be collected by this data collection rule.
Collected from both Windows and Linux machines where the counter is present.` | `Definition of which Open Telemetry performance counters will be collected and how they will be collected by this data collection rule.
Collected from both Windows and Linux machines where the counter is present.` |
| `definitions.PerformanceCountersOTelDataSource.properties.name.description` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` |
| `definitions.PerformanceCountersOTelDataSource.properties.streams.description` | `List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.` | `List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.` |
| `definitions.PlatformTelemetryDataSource.properties.name.description` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` |
| `definitions.PrometheusForwarderDataSource.properties.labelIncludeFilter.description` | `The list of label inclusion filters in the form of label "name-value" pairs.
Currently only one label is supported: 'microsoft_metrics_include_label'.
Label values are matched case-insensitively.` | `The list of label inclusion filters in the form of label "name-value" pairs.
Currently only one label is supported: 'microsoft_metrics_include_label'.
Label values are matched case-insensitively.` |
| `definitions.PrometheusForwarderDataSource.properties.name.description` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` |
| `definitions.StorageBlobDestination.properties.name.description` | `A friendly name for the destination. 
This name should be unique across all destinations (regardless of type) within the data collection rule.` | `A friendly name for the destination.
This name should be unique across all destinations (regardless of type) within the data collection rule.` |
| `definitions.StorageTableDestination.properties.name.description` | `A friendly name for the destination. 
This name should be unique across all destinations (regardless of type) within the data collection rule.` | `A friendly name for the destination.
This name should be unique across all destinations (regardless of type) within the data collection rule.` |
| `definitions.SyslogDataSource.description` | `Definition of which syslog data will be collected and how it will be collected.
Only collected from Linux machines.` | `Definition of which syslog data will be collected and how it will be collected.
Only collected from Linux machines.` |
| `definitions.SyslogDataSource.properties.name.description` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` |
| `definitions.SyslogDataSource.properties.streams.description` | `List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.` | `List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.` |
| `definitions.WindowsEventLogDataSource.description` | `Definition of which Windows Event Log events will be collected and how they will be collected.
Only collected from Windows machines.` | `Definition of which Windows Event Log events will be collected and how they will be collected.
Only collected from Windows machines.` |
| `definitions.WindowsEventLogDataSource.properties.name.description` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` |
| `definitions.WindowsEventLogDataSource.properties.streams.description` | `List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.` | `List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.` |
| `definitions.WindowsFirewallLogsDataSource.properties.name.description` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` | `A friendly name for the data source.
This name should be unique across all data sources (regardless of type) within the data collection rule.` |
| `paths['/{resourceUri}/providers/microsoft.Insights/dataCollectionRuleAssociations'].get.responses.default.schema.$ref` | `./dataCollectionRules_API.json#/definitions/ErrorResponseCommonV2` | `#/definitions/ErrorResponseCommonV2` |
| `paths['/{resourceUri}/providers/microsoft.Insights/dataCollectionRuleAssociations/{associationName}'].delete.responses.default.schema.$ref` | `./dataCollectionRules_API.json#/definitions/ErrorResponseCommonV2` | `#/definitions/ErrorResponseCommonV2` |
| `paths['/{resourceUri}/providers/microsoft.Insights/dataCollectionRuleAssociations/{associationName}'].get.responses.default.schema.$ref` | `./dataCollectionRules_API.json#/definitions/ErrorResponseCommonV2` | `#/definitions/ErrorResponseCommonV2` |
| `paths['/{resourceUri}/providers/microsoft.Insights/dataCollectionRuleAssociations/{associationName}'].put.responses.default.schema.$ref` | `./dataCollectionRules_API.json#/definitions/ErrorResponseCommonV2` | `#/definitions/ErrorResponseCommonV2` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Insights/dataCollectionEndpoints'].get.responses.default.schema.$ref` | `./dataCollectionRules_API.json#/definitions/ErrorResponseCommonV2` | `#/definitions/ErrorResponseCommonV2` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionEndpoints'].get.responses.default.schema.$ref` | `./dataCollectionRules_API.json#/definitions/ErrorResponseCommonV2` | `#/definitions/ErrorResponseCommonV2` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionEndpoints/{dataCollectionEndpointName}'].delete.responses.default.schema.$ref` | `./dataCollectionRules_API.json#/definitions/ErrorResponseCommonV2` | `#/definitions/ErrorResponseCommonV2` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionEndpoints/{dataCollectionEndpointName}'].get.responses.default.schema.$ref` | `./dataCollectionRules_API.json#/definitions/ErrorResponseCommonV2` | `#/definitions/ErrorResponseCommonV2` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionEndpoints/{dataCollectionEndpointName}'].patch.responses.default.schema.$ref` | `./dataCollectionRules_API.json#/definitions/ErrorResponseCommonV2` | `#/definitions/ErrorResponseCommonV2` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionEndpoints/{dataCollectionEndpointName}'].put.responses.default.schema.$ref` | `./dataCollectionRules_API.json#/definitions/ErrorResponseCommonV2` | `#/definitions/ErrorResponseCommonV2` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionEndpoints/{dataCollectionEndpointName}/associations'].get.responses.default.schema.$ref` | `./dataCollectionRules_API.json#/definitions/ErrorResponseCommonV2` | `#/definitions/ErrorResponseCommonV2` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/dataCollectionRules/{dataCollectionRuleName}/associations'].get.responses.default.schema.$ref` | `./dataCollectionRules_API.json#/definitions/ErrorResponseCommonV2` | `#/definitions/ErrorResponseCommonV2` |

