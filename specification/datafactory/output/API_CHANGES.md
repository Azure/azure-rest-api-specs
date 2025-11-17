## Changed Paths

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/{runId}/{runId}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/{runId}/cancel
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/{runId}/queryActivityruns
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/{nodeName}/{nodeName}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/{nodeName}/ipAddress
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/nodes/{nodeName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/nodes/{nodeName}/ipAddress
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelineruns/{runId}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelineruns/{runId}/cancel
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelineruns/{runId}/queryActivityruns
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/privateEndPointConnections
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/privateEndpointConnections
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/{runId}/cancel
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/{runId}/rerun
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/triggerRuns/{runId}/cancel
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/triggerRuns/{runId}/rerun
Change Type: deleted

## Swagger Changes

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateLinkConnectionApprovalRequest.properties.privateLinkServiceConnectionState.description__added` | added | `The state of a private link connection` |
| `definitions.RemotePrivateEndpointConnection.properties.privateLinkServiceConnectionState.description__added` | added | `The state of a private link connection` |
| `info.description__added` | added | `The Azure Data Factory V2 management API provides a RESTful set of web services that interact with Azure Data Factory V2 services.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/disableInteractiveQuery'].post.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/enableInteractiveQuery'].post.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/nodes/{nodeName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/nodes/{nodeName}__deleted']` | deleted | `{"get":{"operationId":"IntegrationRuntimeNodes_Get","description":"Gets a self-hosted integration ru...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/nodes/{nodeName}/ipAddress`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/nodes/{nodeName}/ipAddress__deleted']` | deleted | `{"post":{"operationId":"IntegrationRuntimeNodes_GetIpAddress","description":"Get the IP address of s...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelineruns/{runId}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelineruns/{runId}__deleted']` | deleted | `{"get":{"operationId":"PipelineRuns_Get","description":"Get a pipeline run by its run ID.","paramete...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelineruns/{runId}/cancel`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelineruns/{runId}/cancel__deleted']` | deleted | `{"post":{"operationId":"PipelineRuns_Cancel","description":"Cancel a pipeline run by its run ID.","p...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelineruns/{runId}/queryActivityruns`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelineruns/{runId}/queryActivityruns__deleted']` | deleted | `{"post":{"operationId":"ActivityRuns_QueryByPipelineRun","description":"Query activity runs based on...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/privateEndPointConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/privateEndPointConnections__deleted']` | deleted | `{"get":{"operationId":"privateEndPointConnections_ListByFactory","description":"Lists Private endpoi...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/triggerRuns/{runId}/cancel`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/triggerRuns/{runId}/cancel__deleted']` | deleted | `{"post":{"operationId":"TriggerRuns_Cancel","description":"Cancel a single trigger instance by runId...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/triggerRuns/{runId}/rerun`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/triggerRuns/{runId}/rerun__deleted']` | deleted | `{"post":{"operationId":"TriggerRuns_Rerun","description":"Rerun single trigger instance by runId.","...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/{runId}/{runId}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/{runId}/{runId}__added']` | added | `{"get":{"operationId":"PipelineRuns_Get","description":"Get a pipeline run by its run ID.","paramete...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/{runId}/cancel`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/{runId}/cancel__added']` | added | `{"post":{"operationId":"PipelineRuns_Cancel","description":"Cancel a pipeline run by its run ID.","p...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/{runId}/queryActivityruns`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/{runId}/queryActivityruns__added']` | added | `{"post":{"operationId":"ActivityRuns_QueryByPipelineRun","description":"Query activity runs based on...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/{nodeName}/{nodeName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/{nodeName}/{nodeName}__added']` | added | `{"get":{"operationId":"IntegrationRuntimeNodes_Get","description":"Gets a self-hosted integration ru...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/{nodeName}/ipAddress`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/{nodeName}/ipAddress__added']` | added | `{"post":{"operationId":"IntegrationRuntimeNodes_GetIpAddress","description":"Get the IP address of s...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/privateEndpointConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/privateEndpointConnections__added']` | added | `{"get":{"operationId":"privateEndPointConnections_ListByFactory","description":"Lists Private endpoi...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/{runId}/cancel`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/{runId}/cancel__added']` | added | `{"post":{"operationId":"TriggerRuns_Cancel","description":"Cancel a single trigger instance by runId...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/{runId}/rerun`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/{runId}/rerun__added']` | added | `{"post":{"operationId":"TriggerRuns_Rerun","description":"Rerun single trigger instance by runId.","...` |

### Changes for `x-ms-client-name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}'].get.parameters[1]['x-ms-client-name__added']` | added | `If-None-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/adfcdcs/{changeDataCaptureName}'].get.parameters[2]['x-ms-client-name__added']` | added | `If-None-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/adfcdcs/{changeDataCaptureName}'].put.parameters[2]['x-ms-client-name__added']` | added | `If-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/credentials/{credentialName}'].get.parameters[2]['x-ms-client-name__added']` | added | `If-None-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/credentials/{credentialName}'].put.parameters[2]['x-ms-client-name__added']` | added | `If-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/dataflows/{dataFlowName}'].get.parameters[2]['x-ms-client-name__added']` | added | `If-None-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/dataflows/{dataFlowName}'].put.parameters[2]['x-ms-client-name__added']` | added | `If-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/datasets/{datasetName}'].get.parameters[2]['x-ms-client-name__added']` | added | `If-None-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/datasets/{datasetName}'].put.parameters[2]['x-ms-client-name__added']` | added | `If-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}'].get.parameters[2]['x-ms-client-name__added']` | added | `If-None-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}'].put.parameters[2]['x-ms-client-name__added']` | added | `If-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/linkedservices/{linkedServiceName}'].get.parameters[2]['x-ms-client-name__added']` | added | `If-None-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/linkedservices/{linkedServiceName}'].put.parameters[2]['x-ms-client-name__added']` | added | `If-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/managedVirtualNetworks/{managedVirtualNetworkName}'].get.parameters[2]['x-ms-client-name__added']` | added | `If-None-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/managedVirtualNetworks/{managedVirtualNetworkName}'].put.parameters[2]['x-ms-client-name__added']` | added | `If-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/managedVirtualNetworks/{managedVirtualNetworkName}/managedPrivateEndpoints/{managedPrivateEndpointName}'].get.parameters[3]['x-ms-client-name__added']` | added | `If-None-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/managedVirtualNetworks/{managedVirtualNetworkName}/managedPrivateEndpoints/{managedPrivateEndpointName}'].put.parameters[3]['x-ms-client-name__added']` | added | `If-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelines/{pipelineName}'].get.parameters[2]['x-ms-client-name__added']` | added | `If-None-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelines/{pipelineName}'].put.parameters[2]['x-ms-client-name__added']` | added | `If-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[2]['x-ms-client-name__added']` | added | `If-None-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[2]['x-ms-client-name__added']` | added | `If-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}'].get.parameters[2]['x-ms-client-name__added']` | added | `If-None-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}'].put.parameters[2]['x-ms-client-name__added']` | added | `If-Match` |

### Changes for `304`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}'].get.responses.304__deleted` | deleted | `{"description":"ignore"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/credentials/{credentialName}'].get.responses.304__deleted` | deleted | `{"description":"ignore"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/datasets/{datasetName}'].get.responses.304__deleted` | deleted | `{"description":"ignore"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}'].get.responses.304__deleted` | deleted | `{"description":"ignore"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/linkedservices/{linkedServiceName}'].get.responses.304__deleted` | deleted | `{"description":"ignore"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelines/{pipelineName}'].get.responses.304__deleted` | deleted | `{"description":"ignore"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}'].get.responses.304__deleted` | deleted | `{"description":"ignore"}` |

### Changes for `produces`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/adfcdcs/{changeDataCaptureName}/status'].get.produces__added` | added | `["text/plain","application/json"]` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataFlowDebugPackage.properties.debugSettings.$ref__added` | added | `#/definitions/DataFlowDebugPackageDebugSettings` |
| `definitions.DataFlowReference.properties.parameters.$ref__deleted` | deleted | `#/definitions/ParameterValueSpecification` |
| `definitions.DatasetReference.properties.parameters.$ref__deleted` | deleted | `#/definitions/ParameterValueSpecification` |
| `definitions.FactoryIdentity.properties.userAssignedIdentities.$ref__deleted` | deleted | `#/definitions/UserAssignedIdentitiesDefinitionSpecification` |
| `definitions.FactoryProperties.properties.globalParameters.$ref__deleted` | deleted | `#/definitions/GlobalParameterDefinitionSpecification` |
| `definitions.GlobalParameterResource.properties.properties.$ref__deleted` | deleted | `./entityTypes/GlobalParameter.json#/definitions/GlobalParameter` |
| `definitions.IntegrationRuntimeReference.properties.parameters.$ref__deleted` | deleted | `#/definitions/ParameterValueSpecification` |
| `definitions.LinkedServiceReference.properties.parameters.$ref__deleted` | deleted | `#/definitions/ParameterValueSpecification` |
| `definitions.TriggerPipelineReference.properties.parameters.$ref__deleted` | deleted | `#/definitions/ParameterValueSpecification` |
| `definitions.UpdateIntegrationRuntimeRequest.properties.autoUpdate.$ref__deleted` | deleted | `./entityTypes/IntegrationRuntime.json#/definitions/IntegrationRuntimeAutoUpdate` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/adfcdcs/{changeDataCaptureName}/status'].get.responses.200.schema.$ref__deleted` | deleted | `#/definitions/ChangeDataCaptureStatusResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelines/{pipelineName}/createRun'].post.parameters[6].schema.$ref__deleted` | deleted | `#/definitions/ParameterValueSpecification` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActivityRun.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.ActivityRun.properties.error.type__deleted` | deleted | `object` |
| `definitions.ActivityRun.properties.input.type__deleted` | deleted | `object` |
| `definitions.ActivityRun.properties.output.type__deleted` | deleted | `object` |
| `definitions.AzureKeyVaultSecretReference.properties.secretName.type__deleted` | deleted | `object` |
| `definitions.AzureKeyVaultSecretReference.properties.secretVersion.type__deleted` | deleted | `object` |
| `definitions.CredentialReference.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.DataFlowDebugPackage.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.DataFlowDebugPackage.properties.debugSettings.type__deleted` | deleted | `object` |
| `definitions.DataFlowDebugSessionInfo.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.DataFlowReference.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.DataFlowReference.properties.datasetParameters.type__deleted` | deleted | `object` |
| `definitions.DataFlowReference.properties.parameters.type__added` | added | `object` |
| `definitions.DataFlowSourceSetting.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.DataFlowStagingInfo.properties.folderPath.type__deleted` | deleted | `object` |
| `definitions.DatasetReference.properties.parameters.type__added` | added | `object` |
| `definitions.FactoryIdentity.properties.userAssignedIdentities.type__added` | added | `object` |
| `definitions.FactoryProperties.properties.globalParameters.type__added` | added | `object` |
| `definitions.GlobalParameterResource.properties.properties.type__added` | added | `object` |
| `definitions.GlobalParameterSpecification.properties.value.type__deleted` | deleted | `object` |
| `definitions.IntegrationRuntimeReference.properties.parameters.type__added` | added | `object` |
| `definitions.LinkedServiceReference.properties.parameters.type__added` | added | `object` |
| `definitions.ParameterSpecification.properties.defaultValue.type__deleted` | deleted | `object` |
| `definitions.PipelineRun.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.TriggerPipelineReference.properties.parameters.type__added` | added | `object` |
| `definitions.TriggerRun.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.TriggerRun.properties.dependencyStatus.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.UpdateIntegrationRuntimeRequest.properties.autoUpdate.type__added` | added | `string` |
| `definitions.VariableSpecification.properties.defaultValue.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/adfcdcs/{changeDataCaptureName}/status'].get.responses.200.schema.type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelines/{pipelineName}/createRun'].post.parameters[6].schema.type__added` | added | `object` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Factory.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/createDataFlowDebugSession'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/executeDataFlowDebugCommand'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/disableInteractiveQuery'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/enableInteractiveQuery'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |

### Changes for `Location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/createDataFlowDebugSession'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/executeDataFlowDebugCommand'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/disableInteractiveQuery'].post.responses.200.headers__deleted` | deleted | `{"Azure-AsyncOperation":{"type":"string"},"location":{"type":"string","description":"URI to poll for...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/disableInteractiveQuery'].post.responses.default.headers__deleted` | deleted | `{"Azure-AsyncOperation":{"type":"string"},"location":{"type":"string","description":"URI to poll for...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/enableInteractiveQuery'].post.responses.200.headers__deleted` | deleted | `{"Azure-AsyncOperation":{"type":"string"},"location":{"type":"string","description":"URI to poll for...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/enableInteractiveQuery'].post.responses.default.headers__deleted` | deleted | `{"Azure-AsyncOperation":{"type":"string"},"location":{"type":"string","description":"URI to poll for...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/refreshObjectMetadata'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/start'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/stop'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/subscribeToEvents'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/unsubscribeFromEvents'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/disableInteractiveQuery'].post['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/IntegrationRuntimeResource` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/enableInteractiveQuery'].post['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/IntegrationRuntimeResource` |

### Changes for `x-ms-pageable`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/getObjectMetadata'].post['x-ms-pageable__added']` | added | `{"nextLinkName":"nextLink"}` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ChangeDataCaptureResource.additionalProperties__deleted` | deleted | `{"type":"object"}` |
| `definitions.DataFlowReference.properties.parameters.additionalProperties__added` | added | `{}` |
| `definitions.DatasetReference.properties.parameters.additionalProperties__added` | added | `{}` |
| `definitions.Factory.additionalProperties__deleted` | deleted | `{"type":"object"}` |
| `definitions.FactoryIdentity.properties.userAssignedIdentities.additionalProperties__added` | added | `{}` |
| `definitions.FactoryProperties.properties.globalParameters.additionalProperties__added` | added | `{"$ref":"#/definitions/GlobalParameterSpecification"}` |
| `definitions.GlobalParameterResource.properties.properties.additionalProperties__added` | added | `{}` |
| `definitions.IntegrationRuntimeReference.properties.parameters.additionalProperties__added` | added | `{}` |
| `definitions.LinkedServiceReference.properties.parameters.additionalProperties__added` | added | `{}` |
| `definitions.PipelineResource.additionalProperties__deleted` | deleted | `{"type":"object"}` |
| `definitions.TriggerPipelineReference.properties.parameters.additionalProperties__added` | added | `{}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelines/{pipelineName}/createRun'].post.parameters[6].schema.additionalProperties__added` | added | `{}` |

### Changes for `x-ms-long-running-operation`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/start'].post['x-ms-long-running-operation__deleted']` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/stop'].post['x-ms-long-running-operation__deleted']` | deleted | `true` |

### Changes for `ChangeDataCaptureStatusResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ChangeDataCaptureStatusResponse__deleted` | deleted | `{"type":"string","description":"Current status of the change data capture resource."}` |

### Changes for `CloudError`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudError__deleted` | deleted | `{"type":"object","description":"The object that defines the structure of an Azure Data Factory error...` |

### Changes for `CloudErrorBody`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudErrorBody__deleted` | deleted | `{"type":"object","description":"The object that defines the structure of an Azure Data Factory error...` |

### Changes for `FactoryVSTSConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FactoryVSTSConfiguration__deleted` | deleted | `{"type":"object","description":"Factory's VSTS repo information.","properties":{"projectName":{"type...` |

### Changes for `GetDataFactoryOperationStatusResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GetDataFactoryOperationStatusResponse__deleted` | deleted | `{"type":"object","description":"Response body structure for get data factory operation status.","pro...` |

### Changes for `GlobalParameterDefinitionSpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GlobalParameterDefinitionSpecification__deleted` | deleted | `{"type":"object","description":"Definition of all parameters for an entity.","additionalProperties":...` |

### Changes for `IntegrationRuntimeStatusListResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeStatusListResponse__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `Operation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation__deleted` | deleted | `{"type":"object","description":"Azure Data Factory API operation definition.","properties":{"name":{...` |

### Changes for `OperationListResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationListResponse__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `OperationLogSpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationLogSpecification__deleted` | deleted | `{"type":"object","description":"Details about an operation related to logs.","properties":{"name":{"...` |

### Changes for `OperationMetricAvailability`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationMetricAvailability__deleted` | deleted | `{"type":"object","description":"Defines how often data for a metric becomes available.","properties"...` |

### Changes for `OperationMetricDimension`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationMetricDimension__deleted` | deleted | `{"type":"object","description":"Defines the metric dimension.","properties":{"name":{"type":"string"...` |

### Changes for `OperationMetricSpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationMetricSpecification__deleted` | deleted | `{"type":"object","description":"Details about an operation related to metrics.","properties":{"name"...` |

### Changes for `OperationProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationProperties__deleted` | deleted | `{"type":"object","description":"Additional details about an operation.","properties":{"serviceSpecif...` |

### Changes for `OperationServiceSpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationServiceSpecification__deleted` | deleted | `{"type":"object","description":"Details about a service operation.","properties":{"logSpecifications...` |

### Changes for `ParameterDefinitionSpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ParameterDefinitionSpecification__deleted` | deleted | `{"type":"object","description":"Definition of all parameters for an entity.","additionalProperties":...` |

### Changes for `ParameterValueSpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ParameterValueSpecification__deleted` | deleted | `{"type":"object","description":"An object mapping parameter names to argument values.","additionalPr...` |

### Changes for `Resource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Resource__deleted` | deleted | `{"type":"object","description":"Azure Data Factory top-level resource.","properties":{"id":{"type":"...` |

### Changes for `UserAssignedIdentitiesDefinitionSpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UserAssignedIdentitiesDefinitionSpecification__deleted` | deleted | `{"type":"object","description":"Definition of all user assigned identities for a factory.","addition...` |

### Changes for `UserAssignedIdentitySpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UserAssignedIdentitySpecification__deleted` | deleted | `{"type":"object","description":"Definition of a single user assigned identity for a factory.","prope...` |

### Changes for `VariableDefinitionSpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VariableDefinitionSpecification__deleted` | deleted | `{"type":"object","description":"Definition of variable for a Pipeline.","additionalProperties":{"$re...` |

### Changes for `managedPrivateEndpointListResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.managedPrivateEndpointListResponse__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `Activity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Activity__added` | added | `{"type":"object","description":"A pipeline activity.","properties":{"name":{"type":"string","descrip...` |

### Changes for `ActivityDependency`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActivityDependency__added` | added | `{"type":"object","description":"Activity dependency information.","properties":{"activity":{"type":"...` |

### Changes for `ActivityPolicy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActivityPolicy__added` | added | `{"type":"object","description":"Execution policy for an activity.","properties":{"timeout":{"descrip...` |

### Changes for `AmazonMWSLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonMWSLinkedService__added` | added | `{"type":"object","description":"Amazon Marketplace Web Service linked service.","properties":{"typeP...` |

### Changes for `AmazonMWSLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonMWSLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Amazon Marketplace Web Service linked service properties.","properti...` |

### Changes for `AmazonMWSObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonMWSObjectDataset__added` | added | `{"type":"object","description":"Amazon Marketplace Web Service dataset.","properties":{"typeProperti...` |

### Changes for `AmazonMWSSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonMWSSource__added` | added | `{"type":"object","description":"A copy activity Amazon Marketplace Web Service source.","properties"...` |

### Changes for `AmazonRdsForLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonRdsForLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"AmazonRdsForOracle database linked service properties.","properties"...` |

### Changes for `AmazonRdsForOracleLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonRdsForOracleLinkedService__added` | added | `{"type":"object","description":"AmazonRdsForOracle database. This linked service has supported versi...` |

### Changes for `AmazonRdsForOraclePartitionSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonRdsForOraclePartitionSettings__added` | added | `{"type":"object","description":"The settings that will be leveraged for AmazonRdsForOracle source pa...` |

### Changes for `AmazonRdsForOracleSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonRdsForOracleSource__added` | added | `{"type":"object","description":"A copy activity AmazonRdsForOracle source.","properties":{"oracleRea...` |

### Changes for `AmazonRdsForOracleTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonRdsForOracleTableDataset__added` | added | `{"type":"object","description":"The AmazonRdsForOracle database dataset.","properties":{"typePropert...` |

### Changes for `AmazonRdsForOracleTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonRdsForOracleTableDatasetTypeProperties__added` | added | `{"type":"object","description":"AmazonRdsForOracle dataset properties.","properties":{"schema":{"des...` |

### Changes for `AmazonRdsForSqlServerLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonRdsForSqlServerLinkedService__added` | added | `{"type":"object","description":"Amazon RDS for SQL Server linked service.","properties":{"typeProper...` |

### Changes for `AmazonRdsForSqlServerLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonRdsForSqlServerLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Amazon Rds for SQL Server linked service properties.","properties":{...` |

### Changes for `AmazonRdsForSqlServerSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonRdsForSqlServerSource__added` | added | `{"type":"object","description":"A copy activity Amazon RDS for SQL Server source.","properties":{"sq...` |

### Changes for `AmazonRdsForSqlServerTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonRdsForSqlServerTableDataset__added` | added | `{"type":"object","description":"The Amazon RDS for SQL Server dataset.","properties":{"typePropertie...` |

### Changes for `AmazonRdsForSqlServerTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonRdsForSqlServerTableDatasetTypeProperties__added` | added | `{"type":"object","description":"The Amazon RDS for SQL Server dataset properties.","properties":{"sc...` |

### Changes for `AmazonRedshiftLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonRedshiftLinkedService__added` | added | `{"type":"object","description":"Linked service for Amazon Redshift.","properties":{"typeProperties":...` |

### Changes for `AmazonRedshiftLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonRedshiftLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Amazon Redshift linked service properties.","properties":{"server":{...` |

### Changes for `AmazonRedshiftSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonRedshiftSource__added` | added | `{"type":"object","description":"A copy activity source for Amazon Redshift Source.","properties":{"q...` |

### Changes for `AmazonRedshiftTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonRedshiftTableDataset__added` | added | `{"type":"object","description":"The Amazon Redshift table dataset.","properties":{"typeProperties":{...` |

### Changes for `AmazonRedshiftTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonRedshiftTableDatasetTypeProperties__added` | added | `{"type":"object","description":"Amazon Redshift table dataset properties.","properties":{"tableName"...` |

### Changes for `AmazonS3CompatibleLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonS3CompatibleLinkedService__added` | added | `{"type":"object","description":"Linked service for Amazon S3 Compatible.","properties":{"typePropert...` |

### Changes for `AmazonS3CompatibleLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonS3CompatibleLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Amazon S3 Compatible linked service properties.","properties":{"acce...` |

### Changes for `AmazonS3CompatibleLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonS3CompatibleLocation__added` | added | `{"type":"object","description":"The location of Amazon S3 Compatible dataset.","properties":{"bucket...` |

### Changes for `AmazonS3CompatibleReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonS3CompatibleReadSettings__added` | added | `{"type":"object","description":"Amazon S3 Compatible read settings.","properties":{"recursive":{"des...` |

### Changes for `AmazonS3Dataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonS3Dataset__added` | added | `{"type":"object","description":"A single Amazon Simple Storage Service (S3) object or a set of S3 ob...` |

### Changes for `AmazonS3DatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonS3DatasetTypeProperties__added` | added | `{"type":"object","description":"Amazon S3 dataset properties.","properties":{"bucketName":{"descript...` |

### Changes for `AmazonS3LinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonS3LinkedService__added` | added | `{"type":"object","description":"Linked service for Amazon S3.","properties":{"typeProperties":{"$ref...` |

### Changes for `AmazonS3LinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonS3LinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Amazon S3 linked service properties.","properties":{"authenticationT...` |

### Changes for `AmazonS3Location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonS3Location__added` | added | `{"type":"object","description":"The location of amazon S3 dataset.","properties":{"bucketName":{"des...` |

### Changes for `AmazonS3ReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmazonS3ReadSettings__added` | added | `{"type":"object","description":"Amazon S3 read settings.","properties":{"recursive":{"description":"...` |

### Changes for `AppFiguresLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AppFiguresLinkedService__added` | added | `{"type":"object","description":"Linked service for AppFigures.","properties":{"typeProperties":{"$re...` |

### Changes for `AppFiguresLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AppFiguresLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"AppFigures linked service type properties.","properties":{"userName"...` |

### Changes for `AppendVariableActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AppendVariableActivity__added` | added | `{"type":"object","description":"Append value for a Variable of type Array.","properties":{"typePrope...` |

### Changes for `AppendVariableActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AppendVariableActivityTypeProperties__added` | added | `{"type":"object","description":"AppendVariable activity properties.","properties":{"variableName":{"...` |

### Changes for `AsanaLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AsanaLinkedService__added` | added | `{"type":"object","description":"Linked service for Asana.","properties":{"typeProperties":{"$ref":"#...` |

### Changes for `AsanaLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AsanaLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Asana linked service type properties.","properties":{"apiToken":{"$r...` |

### Changes for `AvroDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AvroDataset__added` | added | `{"type":"object","description":"Avro dataset.","properties":{"typeProperties":{"$ref":"#/definitions...` |

### Changes for `AvroDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AvroDatasetTypeProperties__added` | added | `{"type":"object","description":"Avro dataset properties.","properties":{"location":{"$ref":"#/defini...` |

### Changes for `AvroFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AvroFormat__added` | added | `{"type":"object","description":"The data stored in Avro format.","allOf":[{"$ref":"#/definitions/Dat...` |

### Changes for `AvroSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AvroSink__added` | added | `{"type":"object","description":"A copy activity Avro sink.","properties":{"storeSettings":{"$ref":"#...` |

### Changes for `AvroSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AvroSource__added` | added | `{"type":"object","description":"A copy activity Avro source.","properties":{"storeSettings":{"$ref":...` |

### Changes for `AvroWriteSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AvroWriteSettings__added` | added | `{"type":"object","description":"Avro write settings.","properties":{"recordName":{"type":"string","d...` |

### Changes for `AzPowerShellSetup`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzPowerShellSetup__added` | added | `{"type":"object","description":"The express custom setup of installing Azure PowerShell.","propertie...` |

### Changes for `AzPowerShellSetupTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzPowerShellSetupTypeProperties__added` | added | `{"type":"object","description":"Installation of Azure PowerShell type properties.","properties":{"ve...` |

### Changes for `Azure.ResourceManager.ArmResponse<CreateDataFlowDebugSessionResponse>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<CreateDataFlowDebugSessionResponse>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<DataFlowDebugCommandResponse>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<DataFlowDebugCommandResponse>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<IntegrationRuntimeStatusResponse>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<IntegrationRuntimeStatusResponse>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<SsisObjectMetadataStatusResponse>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<SsisObjectMetadataStatusResponse>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<TriggerSubscriptionOperationStatus>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<TriggerSubscriptionOperationStatus>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `AzureBatchLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBatchLinkedService__added` | added | `{"type":"object","description":"Azure Batch linked service.","properties":{"typeProperties":{"$ref":...` |

### Changes for `AzureBatchLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBatchLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure Batch linked service properties.","properties":{"accountName":...` |

### Changes for `AzureBlobDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobDataset__added` | added | `{"type":"object","description":"The Azure Blob storage.","properties":{"typeProperties":{"$ref":"#/d...` |

### Changes for `AzureBlobDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobDatasetTypeProperties__added` | added | `{"type":"object","description":"Azure Blob dataset properties.","properties":{"folderPath":{"descrip...` |

### Changes for `AzureBlobFSDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobFSDataset__added` | added | `{"type":"object","description":"The Azure Data Lake Storage Gen2 storage.","properties":{"typeProper...` |

### Changes for `AzureBlobFSDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobFSDatasetTypeProperties__added` | added | `{"type":"object","description":"Azure Data Lake Storage Gen2 dataset properties.","properties":{"fol...` |

### Changes for `AzureBlobFSLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobFSLinkedService__added` | added | `{"type":"object","description":"Azure Data Lake Storage Gen2 linked service.","properties":{"typePro...` |

### Changes for `AzureBlobFSLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobFSLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure Data Lake Storage Gen2 linked service properties.","properties...` |

### Changes for `AzureBlobFSLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobFSLocation__added` | added | `{"type":"object","description":"The location of azure blobFS dataset.","properties":{"fileSystem":{"...` |

### Changes for `AzureBlobFSReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobFSReadSettings__added` | added | `{"type":"object","description":"Azure blobFS read settings.","properties":{"recursive":{"description...` |

### Changes for `AzureBlobFSSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobFSSink__added` | added | `{"type":"object","description":"A copy activity Azure Data Lake Storage Gen2 sink.","properties":{"c...` |

### Changes for `AzureBlobFSSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobFSSource__added` | added | `{"type":"object","description":"A copy activity Azure BlobFS source.","properties":{"treatEmptyAsNul...` |

### Changes for `AzureBlobFSWriteSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobFSWriteSettings__added` | added | `{"type":"object","description":"Azure blobFS write settings.","properties":{"blockSizeInMB":{"descri...` |

### Changes for `AzureBlobStorageLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobStorageLinkedService__added` | added | `{"type":"object","description":"The azure blob storage linked service.","properties":{"typePropertie...` |

### Changes for `AzureBlobStorageLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobStorageLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure Blob Storage linked service properties.","properties":{"connec...` |

### Changes for `AzureBlobStorageLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobStorageLocation__added` | added | `{"type":"object","description":"The location of azure blob dataset.","properties":{"container":{"des...` |

### Changes for `AzureBlobStorageReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobStorageReadSettings__added` | added | `{"type":"object","description":"Azure blob read settings.","properties":{"recursive":{"description":...` |

### Changes for `AzureBlobStorageWriteSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobStorageWriteSettings__added` | added | `{"type":"object","description":"Azure blob write settings.","properties":{"blockSizeInMB":{"descript...` |

### Changes for `AzureDataExplorerCommandActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataExplorerCommandActivity__added` | added | `{"type":"object","description":"Azure Data Explorer command activity.","properties":{"typeProperties...` |

### Changes for `AzureDataExplorerCommandActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataExplorerCommandActivityTypeProperties__added` | added | `{"type":"object","description":"Azure Data Explorer command activity properties.","properties":{"com...` |

### Changes for `AzureDataExplorerDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataExplorerDatasetTypeProperties__added` | added | `{"type":"object","description":"Azure Data Explorer (Kusto) dataset properties.","properties":{"tabl...` |

### Changes for `AzureDataExplorerLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataExplorerLinkedService__added` | added | `{"type":"object","description":"Azure Data Explorer (Kusto) linked service.","properties":{"typeProp...` |

### Changes for `AzureDataExplorerLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataExplorerLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure Data Explorer (Kusto) linked service properties.","properties"...` |

### Changes for `AzureDataExplorerSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataExplorerSink__added` | added | `{"type":"object","description":"A copy activity Azure Data Explorer sink.","properties":{"ingestionM...` |

### Changes for `AzureDataExplorerSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataExplorerSource__added` | added | `{"type":"object","description":"A copy activity Azure Data Explorer (Kusto) source.","properties":{"...` |

### Changes for `AzureDataExplorerTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataExplorerTableDataset__added` | added | `{"type":"object","description":"The Azure Data Explorer (Kusto) dataset.","properties":{"typePropert...` |

### Changes for `AzureDataLakeAnalyticsLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataLakeAnalyticsLinkedService__added` | added | `{"type":"object","description":"Azure Data Lake Analytics linked service.","properties":{"typeProper...` |

### Changes for `AzureDataLakeAnalyticsLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataLakeAnalyticsLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure Data Lake Analytics linked service properties.","properties":{...` |

### Changes for `AzureDataLakeStoreDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataLakeStoreDataset__added` | added | `{"type":"object","description":"Azure Data Lake Store dataset.","properties":{"typeProperties":{"$re...` |

### Changes for `AzureDataLakeStoreDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataLakeStoreDatasetTypeProperties__added` | added | `{"type":"object","description":"Azure Data Lake Store dataset properties.","properties":{"folderPath...` |

### Changes for `AzureDataLakeStoreLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataLakeStoreLinkedService__added` | added | `{"type":"object","description":"Azure Data Lake Store linked service.","properties":{"typeProperties...` |

### Changes for `AzureDataLakeStoreLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataLakeStoreLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure Data Lake Store linked service properties.","properties":{"dat...` |

### Changes for `AzureDataLakeStoreLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataLakeStoreLocation__added` | added | `{"type":"object","description":"The location of azure data lake store dataset.","allOf":[{"$ref":"#/...` |

### Changes for `AzureDataLakeStoreReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataLakeStoreReadSettings__added` | added | `{"type":"object","description":"Azure data lake store read settings.","properties":{"recursive":{"de...` |

### Changes for `AzureDataLakeStoreSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataLakeStoreSink__added` | added | `{"type":"object","description":"A copy activity Azure Data Lake Store sink.","properties":{"copyBeha...` |

### Changes for `AzureDataLakeStoreSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataLakeStoreSource__added` | added | `{"type":"object","description":"A copy activity Azure Data Lake source.","properties":{"recursive":{...` |

### Changes for `AzureDataLakeStoreWriteSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDataLakeStoreWriteSettings__added` | added | `{"type":"object","description":"Azure data lake store write settings.","properties":{"expiryDateTime...` |

### Changes for `AzureDatabricksDeltaLakeDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDatabricksDeltaLakeDataset__added` | added | `{"type":"object","description":"Azure Databricks Delta Lake dataset.","properties":{"typeProperties"...` |

### Changes for `AzureDatabricksDeltaLakeDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDatabricksDeltaLakeDatasetTypeProperties__added` | added | `{"type":"object","description":"Azure Databricks Delta Lake Dataset Properties","properties":{"table...` |

### Changes for `AzureDatabricksDeltaLakeExportCommand`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDatabricksDeltaLakeExportCommand__added` | added | `{"type":"object","description":"Azure Databricks Delta Lake export command settings.","properties":{...` |

### Changes for `AzureDatabricksDeltaLakeImportCommand`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDatabricksDeltaLakeImportCommand__added` | added | `{"type":"object","description":"Azure Databricks Delta Lake import command settings.","properties":{...` |

### Changes for `AzureDatabricksDeltaLakeLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDatabricksDeltaLakeLinkedService__added` | added | `{"type":"object","description":"Azure Databricks Delta Lake linked service.","properties":{"typeProp...` |

### Changes for `AzureDatabricksDeltaLakeSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDatabricksDeltaLakeSink__added` | added | `{"type":"object","description":"A copy activity Azure Databricks Delta Lake sink.","properties":{"pr...` |

### Changes for `AzureDatabricksDeltaLakeSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDatabricksDeltaLakeSource__added` | added | `{"type":"object","description":"A copy activity Azure Databricks Delta Lake source.","properties":{"...` |

### Changes for `AzureDatabricksDetltaLakeLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDatabricksDetltaLakeLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure Databricks Delta Lake linked service properties.","properties"...` |

### Changes for `AzureDatabricksLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDatabricksLinkedService__added` | added | `{"type":"object","description":"Azure Databricks linked service.","properties":{"typeProperties":{"$...` |

### Changes for `AzureDatabricksLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDatabricksLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure Databricks linked service properties.","properties":{"domain":...` |

### Changes for `AzureFileStorageLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFileStorageLinkedService__added` | added | `{"type":"object","description":"Azure File Storage linked service.","properties":{"typeProperties":{...` |

### Changes for `AzureFileStorageLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFileStorageLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure File Storage linked service properties.","properties":{"host":...` |

### Changes for `AzureFileStorageLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFileStorageLocation__added` | added | `{"type":"object","description":"The location of file server dataset.","allOf":[{"$ref":"#/definition...` |

### Changes for `AzureFileStorageReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFileStorageReadSettings__added` | added | `{"type":"object","description":"Azure File Storage read settings.","properties":{"recursive":{"descr...` |

### Changes for `AzureFileStorageWriteSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFileStorageWriteSettings__added` | added | `{"type":"object","description":"Azure File Storage write settings.","allOf":[{"$ref":"#/definitions/...` |

### Changes for `AzureFunctionActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFunctionActivity__added` | added | `{"type":"object","description":"Azure Function activity.","properties":{"typeProperties":{"$ref":"#/...` |

### Changes for `AzureFunctionActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFunctionActivityTypeProperties__added` | added | `{"type":"object","description":"Azure Function activity type properties.","properties":{"method":{"t...` |

### Changes for `AzureFunctionLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFunctionLinkedService__added` | added | `{"type":"object","description":"Azure Function linked service.","properties":{"typeProperties":{"$re...` |

### Changes for `AzureFunctionLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFunctionLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure Function linked service properties.","properties":{"functionAp...` |

### Changes for `AzureKeyVaultLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureKeyVaultLinkedService__added` | added | `{"type":"object","description":"Azure Key Vault linked service.","properties":{"typeProperties":{"$r...` |

### Changes for `AzureKeyVaultLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureKeyVaultLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure Key Vault linked service properties.","properties":{"baseUrl":...` |

### Changes for `AzureMLBatchExecutionActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMLBatchExecutionActivity__added` | added | `{"type":"object","description":"Azure ML Batch Execution activity.","properties":{"typeProperties":{...` |

### Changes for `AzureMLBatchExecutionActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMLBatchExecutionActivityTypeProperties__added` | added | `{"type":"object","description":"Azure ML Batch Execution activity properties.","properties":{"global...` |

### Changes for `AzureMLExecutePipelineActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMLExecutePipelineActivity__added` | added | `{"type":"object","description":"Azure ML Execute Pipeline activity.","properties":{"typeProperties":...` |

### Changes for `AzureMLExecutePipelineActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMLExecutePipelineActivityTypeProperties__added` | added | `{"type":"object","description":"Azure ML Execute Pipeline activity properties.","properties":{"mlPip...` |

### Changes for `AzureMLLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMLLinkedService__added` | added | `{"type":"object","description":"Azure ML Studio Web Service linked service.","properties":{"typeProp...` |

### Changes for `AzureMLLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMLLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure ML Studio Web Service linked service properties.","properties"...` |

### Changes for `AzureMLServiceLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMLServiceLinkedService__added` | added | `{"type":"object","description":"Azure ML Service linked service.","properties":{"typeProperties":{"$...` |

### Changes for `AzureMLServiceLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMLServiceLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure ML Service linked service properties.","properties":{"subscrip...` |

### Changes for `AzureMLUpdateResourceActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMLUpdateResourceActivity__added` | added | `{"type":"object","description":"Azure ML Update Resource management activity.","properties":{"typePr...` |

### Changes for `AzureMLUpdateResourceActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMLUpdateResourceActivityTypeProperties__added` | added | `{"type":"object","description":"Azure ML Update Resource activity properties.","properties":{"traine...` |

### Changes for `AzureMLWebServiceFile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMLWebServiceFile__added` | added | `{"type":"object","description":"Azure ML WebService Input/Output file","properties":{"filePath":{"de...` |

### Changes for `AzureMariaDBLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMariaDBLinkedService__added` | added | `{"type":"object","description":"Azure Database for MariaDB linked service.","properties":{"typePrope...` |

### Changes for `AzureMariaDBLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMariaDBLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure Database for MariaDB linked service properties.","properties":...` |

### Changes for `AzureMariaDBSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMariaDBSource__added` | added | `{"type":"object","description":"A copy activity Azure MariaDB source.","properties":{"query":{"descr...` |

### Changes for `AzureMariaDBTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMariaDBTableDataset__added` | added | `{"type":"object","description":"Azure Database for MariaDB dataset.","properties":{"typeProperties":...` |

### Changes for `AzureMySqlLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMySqlLinkedService__added` | added | `{"type":"object","description":"Azure MySQL database linked service.","properties":{"typeProperties"...` |

### Changes for `AzureMySqlLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMySqlLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure MySQL database linked service properties.","properties":{"conn...` |

### Changes for `AzureMySqlSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMySqlSink__added` | added | `{"type":"object","description":"A copy activity Azure MySql sink.","properties":{"preCopyScript":{"d...` |

### Changes for `AzureMySqlSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMySqlSource__added` | added | `{"type":"object","description":"A copy activity Azure MySQL source.","properties":{"query":{"descrip...` |

### Changes for `AzureMySqlTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMySqlTableDataset__added` | added | `{"type":"object","description":"The Azure MySQL database dataset.","properties":{"typeProperties":{"...` |

### Changes for `AzureMySqlTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureMySqlTableDatasetTypeProperties__added` | added | `{"type":"object","description":"Azure MySQL database dataset properties.","properties":{"tableName":...` |

### Changes for `AzurePostgreSqlLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzurePostgreSqlLinkedService__added` | added | `{"type":"object","description":"Azure PostgreSQL linked service.","properties":{"typeProperties":{"$...` |

### Changes for `AzurePostgreSqlLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzurePostgreSqlLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure PostgreSQL linked service properties.","properties":{"connecti...` |

### Changes for `AzurePostgreSqlSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzurePostgreSqlSink__added` | added | `{"type":"object","description":"A copy activity Azure Database for PostgreSQL sink.","properties":{"...` |

### Changes for `AzurePostgreSqlSinkUpsertSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzurePostgreSqlSinkUpsertSettings__added` | added | `{"type":"object","description":"Azure Database for PostgreSQL upsert option settings","properties":{...` |

### Changes for `AzurePostgreSqlSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzurePostgreSqlSource__added` | added | `{"type":"object","description":"A copy activity Azure Database for PostgreSQL source.","properties":...` |

### Changes for `AzurePostgreSqlTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzurePostgreSqlTableDataset__added` | added | `{"type":"object","description":"Azure PostgreSQL dataset.","properties":{"typeProperties":{"$ref":"#...` |

### Changes for `AzurePostgreSqlTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzurePostgreSqlTableDatasetTypeProperties__added` | added | `{"type":"object","description":"Azure PostgreSQL dataset properties.","properties":{"tableName":{"de...` |

### Changes for `AzureQueueSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureQueueSink__added` | added | `{"type":"object","description":"A copy activity Azure Queue sink.","allOf":[{"$ref":"#/definitions/C...` |

### Changes for `AzureSearchIndexDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSearchIndexDataset__added` | added | `{"type":"object","description":"The Azure Search Index.","properties":{"typeProperties":{"$ref":"#/d...` |

### Changes for `AzureSearchIndexDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSearchIndexDatasetTypeProperties__added` | added | `{"type":"object","description":"Properties specific to this dataset type.","properties":{"indexName"...` |

### Changes for `AzureSearchIndexSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSearchIndexSink__added` | added | `{"type":"object","description":"A copy activity Azure Search Index sink.","properties":{"writeBehavi...` |

### Changes for `AzureSearchLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSearchLinkedService__added` | added | `{"type":"object","description":"Linked service for Windows Azure Search Service.","properties":{"typ...` |

### Changes for `AzureSearchLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSearchLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Windows Azure Search Service linked service properties.","properties...` |

### Changes for `AzureSqlDWLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSqlDWLinkedService__added` | added | `{"type":"object","description":"Azure SQL Data Warehouse linked service.","properties":{"typePropert...` |

### Changes for `AzureSqlDWLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSqlDWLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure SQL Data Warehouse linked service properties.","properties":{"...` |

### Changes for `AzureSqlDWTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSqlDWTableDataset__added` | added | `{"type":"object","description":"The Azure SQL Data Warehouse dataset.","properties":{"typeProperties...` |

### Changes for `AzureSqlDWTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSqlDWTableDatasetTypeProperties__added` | added | `{"type":"object","description":"Azure SQL Data Warehouse dataset properties.","properties":{"tableNa...` |

### Changes for `AzureSqlDatabaseLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSqlDatabaseLinkedService__added` | added | `{"type":"object","description":"Microsoft Azure SQL Database linked service.","properties":{"typePro...` |

### Changes for `AzureSqlDatabaseLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSqlDatabaseLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure SQL Database linked service properties.","properties":{"connec...` |

### Changes for `AzureSqlMILinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSqlMILinkedService__added` | added | `{"type":"object","description":"Azure SQL Managed Instance linked service.","properties":{"typePrope...` |

### Changes for `AzureSqlMILinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSqlMILinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure SQL Managed Instance linked service properties.","properties":...` |

### Changes for `AzureSqlMITableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSqlMITableDataset__added` | added | `{"type":"object","description":"The Azure SQL Managed Instance dataset.","properties":{"typeProperti...` |

### Changes for `AzureSqlMITableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSqlMITableDatasetTypeProperties__added` | added | `{"type":"object","description":"Azure SQL Managed Instance dataset properties.","properties":{"table...` |

### Changes for `AzureSqlSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSqlSink__added` | added | `{"type":"object","description":"A copy activity Azure SQL sink.","properties":{"sqlWriterStoredProce...` |

### Changes for `AzureSqlSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSqlSource__added` | added | `{"type":"object","description":"A copy activity Azure SQL source.","properties":{"sqlReaderQuery":{"...` |

### Changes for `AzureSqlTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSqlTableDataset__added` | added | `{"type":"object","description":"The Azure SQL Server database dataset.","properties":{"typePropertie...` |

### Changes for `AzureSqlTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSqlTableDatasetTypeProperties__added` | added | `{"type":"object","description":"Azure SQL dataset properties.","properties":{"tableName":{"descripti...` |

### Changes for `AzureStorageLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureStorageLinkedService__added` | added | `{"type":"object","description":"The storage account linked service.","properties":{"typeProperties":...` |

### Changes for `AzureStorageLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureStorageLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure Storage linked service properties.","properties":{"connectionS...` |

### Changes for `AzureSynapseArtifactsLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSynapseArtifactsLinkedService__added` | added | `{"type":"object","description":"Azure Synapse Analytics (Artifacts) linked service.","properties":{"...` |

### Changes for `AzureSynapseArtifactsLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureSynapseArtifactsLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure Synapse Analytics (Artifacts) linked service properties.","pro...` |

### Changes for `AzureTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureTableDataset__added` | added | `{"type":"object","description":"The Azure Table storage dataset.","properties":{"typeProperties":{"$...` |

### Changes for `AzureTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureTableDatasetTypeProperties__added` | added | `{"type":"object","description":"Azure Table dataset properties.","properties":{"tableName":{"descrip...` |

### Changes for `AzureTableSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureTableSink__added` | added | `{"type":"object","description":"A copy activity Azure Table sink.","properties":{"azureTableDefaultP...` |

### Changes for `AzureTableSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureTableSource__added` | added | `{"type":"object","description":"A copy activity Azure Table source.","properties":{"azureTableSource...` |

### Changes for `AzureTableStorageLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureTableStorageLinkedService__added` | added | `{"type":"object","description":"The azure table storage linked service.","properties":{"typeProperti...` |

### Changes for `AzureTableStorageLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureTableStorageLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Azure Table Storage linked service properties.","properties":{"servi...` |

### Changes for `BigDataPoolParametrizationReference`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BigDataPoolParametrizationReference__added` | added | `{"type":"object","description":"Big data pool reference type.","properties":{"type":{"type":"string"...` |

### Changes for `BinaryDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BinaryDataset__added` | added | `{"type":"object","description":"Binary dataset.","properties":{"typeProperties":{"$ref":"#/definitio...` |

### Changes for `BinaryDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BinaryDatasetTypeProperties__added` | added | `{"type":"object","description":"Binary dataset properties.","properties":{"location":{"$ref":"#/defi...` |

### Changes for `BinaryReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BinaryReadSettings__added` | added | `{"type":"object","description":"Binary read settings.","properties":{"compressionProperties":{"$ref"...` |

### Changes for `BinarySink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BinarySink__added` | added | `{"type":"object","description":"A copy activity Binary sink.","properties":{"storeSettings":{"$ref":...` |

### Changes for `BinarySource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BinarySource__added` | added | `{"type":"object","description":"A copy activity Binary source.","properties":{"storeSettings":{"$ref...` |

### Changes for `BlobEventsTrigger`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BlobEventsTrigger__added` | added | `{"type":"object","description":"Trigger that runs every time a Blob event occurs.","properties":{"ty...` |

### Changes for `BlobEventsTriggerTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BlobEventsTriggerTypeProperties__added` | added | `{"type":"object","description":"Blob Events Trigger properties.","properties":{"blobPathBeginsWith":...` |

### Changes for `BlobSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BlobSink__added` | added | `{"type":"object","description":"A copy activity Azure Blob sink.","properties":{"blobWriterOverwrite...` |

### Changes for `BlobSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BlobSource__added` | added | `{"type":"object","description":"A copy activity Azure Blob source.","properties":{"treatEmptyAsNull"...` |

### Changes for `BlobTrigger`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BlobTrigger__added` | added | `{"type":"object","description":"Trigger that runs every time the selected Blob container changes.","...` |

### Changes for `BlobTriggerTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BlobTriggerTypeProperties__added` | added | `{"type":"object","description":"Blob Trigger properties.","properties":{"folderPath":{"type":"string...` |

### Changes for `CassandraLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CassandraLinkedService__added` | added | `{"type":"object","description":"Linked service for Cassandra data source.","properties":{"typeProper...` |

### Changes for `CassandraLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CassandraLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Cassandra linked service properties.","properties":{"host":{"descrip...` |

### Changes for `CassandraSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CassandraSource__added` | added | `{"type":"object","description":"A copy activity source for a Cassandra database.","properties":{"que...` |

### Changes for `CassandraTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CassandraTableDataset__added` | added | `{"type":"object","description":"The Cassandra database dataset.","properties":{"typeProperties":{"$r...` |

### Changes for `CassandraTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CassandraTableDatasetTypeProperties__added` | added | `{"type":"object","description":"Cassandra dataset properties.","properties":{"tableName":{"descripti...` |

### Changes for `ChainingTrigger`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ChainingTrigger__added` | added | `{"type":"object","description":"Trigger that allows the referenced pipeline to depend on other pipel...` |

### Changes for `ChainingTriggerTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ChainingTriggerTypeProperties__added` | added | `{"type":"object","description":"Chaining Trigger properties.","properties":{"dependsOn":{"type":"arr...` |

### Changes for `ChangeDataCapture`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ChangeDataCapture__added` | added | `{"type":"object","description":"A Azure Data Factory object which automatically detects data changes...` |

### Changes for `ChangeDataCaptureFolder`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ChangeDataCaptureFolder__added` | added | `{"type":"object","description":"The folder that this CDC is in. If not specified, CDC will appear at...` |

### Changes for `CmdkeySetup`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CmdkeySetup__added` | added | `{"type":"object","description":"The custom setup of running cmdkey commands.","properties":{"typePro...` |

### Changes for `CmdkeySetupTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CmdkeySetupTypeProperties__added` | added | `{"type":"object","description":"Cmdkey command custom setup type properties.","properties":{"targetN...` |

### Changes for `CommonDataServiceForAppsEntityDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CommonDataServiceForAppsEntityDataset__added` | added | `{"type":"object","description":"The Common Data Service for Apps entity dataset.","properties":{"typ...` |

### Changes for `CommonDataServiceForAppsEntityDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CommonDataServiceForAppsEntityDatasetTypeProperties__added` | added | `{"type":"object","description":"Common Data Service for Apps entity dataset properties.","properties...` |

### Changes for `CommonDataServiceForAppsLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CommonDataServiceForAppsLinkedService__added` | added | `{"type":"object","description":"Common Data Service for Apps linked service.","properties":{"typePro...` |

### Changes for `CommonDataServiceForAppsLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CommonDataServiceForAppsLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Common Data Service for Apps linked service properties.","properties...` |

### Changes for `CommonDataServiceForAppsSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CommonDataServiceForAppsSink__added` | added | `{"type":"object","description":"A copy activity Common Data Service for Apps sink.","properties":{"w...` |

### Changes for `CommonDataServiceForAppsSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CommonDataServiceForAppsSource__added` | added | `{"type":"object","description":"A copy activity Common Data Service for Apps source.","properties":{...` |

### Changes for `ComponentSetup`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComponentSetup__added` | added | `{"type":"object","description":"The custom setup of installing 3rd party components.","properties":{...` |

### Changes for `CompressionReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CompressionReadSettings__added` | added | `{"type":"object","description":"Compression read settings.","properties":{"type":{"type":"string","d...` |

### Changes for `ConcurLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConcurLinkedService__added` | added | `{"type":"object","description":"Concur Service linked service.","properties":{"typeProperties":{"$re...` |

### Changes for `ConcurLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConcurLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Concur Service linked service properties.","properties":{"connection...` |

### Changes for `ConcurObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConcurObjectDataset__added` | added | `{"type":"object","description":"Concur Service dataset.","properties":{"typeProperties":{"$ref":"#/d...` |

### Changes for `ConcurSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConcurSource__added` | added | `{"type":"object","description":"A copy activity Concur Service source.","properties":{"query":{"desc...` |

### Changes for `ConnectionStateProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionStateProperties__added` | added | `{"type":"object","description":"The connection state of a managed private endpoint","properties":{"a...` |

### Changes for `ContinuationSettingsReference`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ContinuationSettingsReference__added` | added | `{"type":"object","description":"Continuation settings for execute data flow activity.","properties":...` |

### Changes for `ControlActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ControlActivity__added` | added | `{"type":"object","description":"Base class for all control activities like IfCondition, ForEach , Un...` |

### Changes for `CopyActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CopyActivity__added` | added | `{"type":"object","description":"Copy activity.","properties":{"typeProperties":{"$ref":"#/definition...` |

### Changes for `CopyActivityLogSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CopyActivityLogSettings__added` | added | `{"type":"object","description":"Settings for copy activity log.","properties":{"logLevel":{"descript...` |

### Changes for `CopyActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CopyActivityTypeProperties__added` | added | `{"type":"object","description":"Copy activity properties.","properties":{"source":{"$ref":"#/definit...` |

### Changes for `CopyComputeScaleProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CopyComputeScaleProperties__added` | added | `{"type":"object","description":"CopyComputeScale properties for managed integration runtime.","prope...` |

### Changes for `CopySink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CopySink__added` | added | `{"type":"object","description":"A copy activity sink.","properties":{"type":{"type":"string","descri...` |

### Changes for `CopySource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CopySource__added` | added | `{"type":"object","description":"A copy activity source.","properties":{"type":{"type":"string","desc...` |

### Changes for `CosmosDbLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CosmosDbLinkedService__added` | added | `{"type":"object","description":"Microsoft Azure Cosmos Database (CosmosDB) linked service.","propert...` |

### Changes for `CosmosDbLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CosmosDbLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"CosmosDB linked service properties.","properties":{"connectionString...` |

### Changes for `CosmosDbMongoDbApiCollectionDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CosmosDbMongoDbApiCollectionDataset__added` | added | `{"type":"object","description":"The CosmosDB (MongoDB API) database dataset.","properties":{"typePro...` |

### Changes for `CosmosDbMongoDbApiCollectionDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CosmosDbMongoDbApiCollectionDatasetTypeProperties__added` | added | `{"type":"object","description":"CosmosDB (MongoDB API) database dataset properties.","properties":{"...` |

### Changes for `CosmosDbMongoDbApiLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CosmosDbMongoDbApiLinkedService__added` | added | `{"type":"object","description":"Linked service for CosmosDB (MongoDB API) data source.","properties"...` |

### Changes for `CosmosDbMongoDbApiLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CosmosDbMongoDbApiLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"CosmosDB (MongoDB API) linked service properties.","properties":{"is...` |

### Changes for `CosmosDbMongoDbApiSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CosmosDbMongoDbApiSink__added` | added | `{"type":"object","description":"A copy activity sink for a CosmosDB (MongoDB API) database.","proper...` |

### Changes for `CosmosDbMongoDbApiSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CosmosDbMongoDbApiSource__added` | added | `{"type":"object","description":"A copy activity source for a CosmosDB (MongoDB API) database.","prop...` |

### Changes for `CosmosDbSqlApiCollectionDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CosmosDbSqlApiCollectionDataset__added` | added | `{"type":"object","description":"Microsoft Azure CosmosDB (SQL API) Collection dataset.","properties"...` |

### Changes for `CosmosDbSqlApiCollectionDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CosmosDbSqlApiCollectionDatasetTypeProperties__added` | added | `{"type":"object","description":"CosmosDB (SQL API) Collection dataset properties.","properties":{"co...` |

### Changes for `CosmosDbSqlApiSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CosmosDbSqlApiSink__added` | added | `{"type":"object","description":"A copy activity Azure CosmosDB (SQL API) Collection sink.","properti...` |

### Changes for `CosmosDbSqlApiSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CosmosDbSqlApiSource__added` | added | `{"type":"object","description":"A copy activity Azure CosmosDB (SQL API) Collection source.","proper...` |

### Changes for `CouchbaseLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CouchbaseLinkedService__added` | added | `{"type":"object","description":"Couchbase server linked service.","properties":{"typeProperties":{"$...` |

### Changes for `CouchbaseLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CouchbaseLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Couchbase server linked service properties.","properties":{"connecti...` |

### Changes for `CouchbaseSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CouchbaseSource__added` | added | `{"type":"object","description":"A copy activity Couchbase server source.","properties":{"query":{"de...` |

### Changes for `CouchbaseTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CouchbaseTableDataset__added` | added | `{"type":"object","description":"Couchbase server dataset.","properties":{"typeProperties":{"$ref":"#...` |

### Changes for `Credential`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Credential__added` | added | `{"type":"object","description":"The Azure Data Factory nested object which contains the information ...` |

### Changes for `CustomActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CustomActivity__added` | added | `{"type":"object","description":"Custom activity type.","properties":{"typeProperties":{"$ref":"#/def...` |

### Changes for `CustomActivityReferenceObject`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CustomActivityReferenceObject__added` | added | `{"type":"object","description":"Reference objects for custom activity","properties":{"linkedServices...` |

### Changes for `CustomActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CustomActivityTypeProperties__added` | added | `{"type":"object","description":"Custom activity properties.","properties":{"command":{"description":...` |

### Changes for `CustomDataSourceLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CustomDataSourceLinkedService__added` | added | `{"type":"object","description":"Custom linked service.","properties":{"typeProperties":{"description...` |

### Changes for `CustomDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CustomDataset__added` | added | `{"type":"object","description":"The custom dataset.","properties":{"typeProperties":{"description":"...` |

### Changes for `CustomEventsTrigger`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CustomEventsTrigger__added` | added | `{"type":"object","description":"Trigger that runs every time a custom event is received.","propertie...` |

### Changes for `CustomEventsTriggerTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CustomEventsTriggerTypeProperties__added` | added | `{"type":"object","description":"Custom Events Trigger properties.","properties":{"subjectBeginsWith"...` |

### Changes for `CustomSetupBase`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CustomSetupBase__added` | added | `{"type":"object","description":"The base definition of the custom setup.","properties":{"type":{"typ...` |

### Changes for `DWCopyCommandDefaultValue`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DWCopyCommandDefaultValue__added` | added | `{"type":"object","description":"Default value.","properties":{"columnName":{"description":"Column na...` |

### Changes for `DWCopyCommandSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DWCopyCommandSettings__added` | added | `{"type":"object","description":"DW Copy Command settings.","properties":{"defaultValues":{"type":"ar...` |

### Changes for `DataFlow`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataFlow__added` | added | `{"type":"object","description":"Azure Data Factory nested object which contains a flow with data mov...` |

### Changes for `DataFlowDebugPackageDebugSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataFlowDebugPackageDebugSettings__added` | added | `{"type":"object","description":"Data flow debug settings.","properties":{"sourceSettings":{"type":"a...` |

### Changes for `DataFlowFolder`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataFlowFolder__added` | added | `{"type":"object","description":"The folder that this data flow is in. If not specified, Data flow wi...` |

### Changes for `DataFlowSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataFlowSink__added` | added | `{"type":"object","description":"Transformation for data flow sink.","properties":{"schemaLinkedServi...` |

### Changes for `DataFlowSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataFlowSource__added` | added | `{"type":"object","description":"Transformation for data flow source.","properties":{"schemaLinkedSer...` |

### Changes for `DataLakeAnalyticsUsqlActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataLakeAnalyticsUsqlActivity__added` | added | `{"type":"object","description":"Data Lake Analytics U-SQL activity.","properties":{"typeProperties":...` |

### Changes for `DataLakeAnalyticsUsqlActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataLakeAnalyticsUsqlActivityTypeProperties__added` | added | `{"type":"object","description":"DataLakeAnalyticsU-SQL activity properties.","properties":{"scriptPa...` |

### Changes for `DataMapperMapping`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataMapperMapping__added` | added | `{"type":"object","description":"Source and target table mapping details.","properties":{"targetEntit...` |

### Changes for `DatabricksJobActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatabricksJobActivity__added` | added | `{"type":"object","description":"Databricks Job activity.","properties":{"typeProperties":{"$ref":"#/...` |

### Changes for `DatabricksJobActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatabricksJobActivityTypeProperties__added` | added | `{"type":"object","description":"Databricks Job activity properties.","properties":{"jobId":{"descrip...` |

### Changes for `DatabricksNotebookActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatabricksNotebookActivity__added` | added | `{"type":"object","description":"DatabricksNotebook activity.","properties":{"typeProperties":{"$ref"...` |

### Changes for `DatabricksNotebookActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatabricksNotebookActivityTypeProperties__added` | added | `{"type":"object","description":"Databricks Notebook activity properties.","properties":{"notebookPat...` |

### Changes for `DatabricksSparkJarActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatabricksSparkJarActivity__added` | added | `{"type":"object","description":"DatabricksSparkJar activity.","properties":{"typeProperties":{"$ref"...` |

### Changes for `DatabricksSparkJarActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatabricksSparkJarActivityTypeProperties__added` | added | `{"type":"object","description":"Databricks SparkJar activity properties.","properties":{"mainClassNa...` |

### Changes for `DatabricksSparkPythonActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatabricksSparkPythonActivity__added` | added | `{"type":"object","description":"DatabricksSparkPython activity.","properties":{"typeProperties":{"$r...` |

### Changes for `DatabricksSparkPythonActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatabricksSparkPythonActivityTypeProperties__added` | added | `{"type":"object","description":"Databricks SparkPython activity properties.","properties":{"pythonFi...` |

### Changes for `Dataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Dataset__added` | added | `{"type":"object","description":"The Azure Data Factory nested object which identifies data within di...` |

### Changes for `DatasetCompression`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatasetCompression__added` | added | `{"type":"object","description":"The compression method used on a dataset.","properties":{"type":{"de...` |

### Changes for `DatasetFolder`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatasetFolder__added` | added | `{"type":"object","description":"The folder that this Dataset is in. If not specified, Dataset will a...` |

### Changes for `DatasetLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatasetLocation__added` | added | `{"type":"object","description":"Dataset location.","properties":{"type":{"type":"string","descriptio...` |

### Changes for `DatasetStorageFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatasetStorageFormat__added` | added | `{"type":"object","description":"The format definition of a storage.","properties":{"type":{"type":"s...` |

### Changes for `DataworldLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataworldLinkedService__added` | added | `{"type":"object","description":"Linked service for Dataworld.","properties":{"typeProperties":{"$ref...` |

### Changes for `DataworldLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataworldLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Dataworld linked service type properties.","properties":{"apiToken":...` |

### Changes for `Db2LinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Db2LinkedService__added` | added | `{"type":"object","description":"Linked service for DB2 data source.","properties":{"typeProperties":...` |

### Changes for `Db2LinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Db2LinkedServiceTypeProperties__added` | added | `{"type":"object","description":"DB2 linked service properties.","properties":{"connectionString":{"d...` |

### Changes for `Db2Source`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Db2Source__added` | added | `{"type":"object","description":"A copy activity source for Db2 databases.","properties":{"query":{"d...` |

### Changes for `Db2TableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Db2TableDataset__added` | added | `{"type":"object","description":"The Db2 table dataset.","properties":{"typeProperties":{"$ref":"#/de...` |

### Changes for `Db2TableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Db2TableDatasetTypeProperties__added` | added | `{"type":"object","description":"Db2 table dataset properties.","properties":{"tableName":{"descripti...` |

### Changes for `DeleteActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeleteActivity__added` | added | `{"type":"object","description":"Delete activity.","properties":{"typeProperties":{"$ref":"#/definiti...` |

### Changes for `DeleteActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeleteActivityTypeProperties__added` | added | `{"type":"object","description":"Delete activity properties.","properties":{"recursive":{"description...` |

### Changes for `DelimitedTextDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DelimitedTextDataset__added` | added | `{"type":"object","description":"Delimited text dataset.","properties":{"typeProperties":{"$ref":"#/d...` |

### Changes for `DelimitedTextDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DelimitedTextDatasetTypeProperties__added` | added | `{"type":"object","description":"DelimitedText dataset properties.","properties":{"location":{"$ref":...` |

### Changes for `DelimitedTextReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DelimitedTextReadSettings__added` | added | `{"type":"object","description":"Delimited text read settings.","properties":{"skipLineCount":{"descr...` |

### Changes for `DelimitedTextSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DelimitedTextSink__added` | added | `{"type":"object","description":"A copy activity DelimitedText sink.","properties":{"storeSettings":{...` |

### Changes for `DelimitedTextSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DelimitedTextSource__added` | added | `{"type":"object","description":"A copy activity DelimitedText source.","properties":{"storeSettings"...` |

### Changes for `DelimitedTextWriteSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DelimitedTextWriteSettings__added` | added | `{"type":"object","description":"Delimited text write settings.","properties":{"quoteAllText":{"descr...` |

### Changes for `DependencyReference`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DependencyReference__added` | added | `{"type":"object","description":"Referenced dependency.","properties":{"type":{"type":"string","descr...` |

### Changes for `DistcpSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DistcpSettings__added` | added | `{"type":"object","description":"Distcp settings.","properties":{"resourceManagerEndpoint":{"descript...` |

### Changes for `DocumentDbCollectionDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DocumentDbCollectionDataset__added` | added | `{"type":"object","description":"Microsoft Azure Document Database Collection dataset.","properties":...` |

### Changes for `DocumentDbCollectionDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DocumentDbCollectionDatasetTypeProperties__added` | added | `{"type":"object","description":"DocumentDB Collection dataset properties.","properties":{"collection...` |

### Changes for `DocumentDbCollectionSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DocumentDbCollectionSink__added` | added | `{"type":"object","description":"A copy activity Document Database Collection sink.","properties":{"n...` |

### Changes for `DocumentDbCollectionSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DocumentDbCollectionSource__added` | added | `{"type":"object","description":"A copy activity Document Database Collection source.","properties":{...` |

### Changes for `DrillDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DrillDatasetTypeProperties__added` | added | `{"type":"object","description":"Drill Dataset Properties","properties":{"tableName":{"description":"...` |

### Changes for `DrillLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DrillLinkedService__added` | added | `{"type":"object","description":"Drill server linked service.","properties":{"typeProperties":{"$ref"...` |

### Changes for `DrillLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DrillLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Drill server linked service properties.","properties":{"connectionSt...` |

### Changes for `DrillSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DrillSource__added` | added | `{"type":"object","description":"A copy activity Drill server source.","properties":{"query":{"descri...` |

### Changes for `DrillTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DrillTableDataset__added` | added | `{"type":"object","description":"Drill server dataset.","properties":{"typeProperties":{"$ref":"#/def...` |

### Changes for `DynamicsAXLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicsAXLinkedService__added` | added | `{"type":"object","description":"Dynamics AX linked service.","properties":{"typeProperties":{"$ref":...` |

### Changes for `DynamicsAXLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicsAXLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Dynamics AX linked service properties.","properties":{"url":{"descri...` |

### Changes for `DynamicsAXResourceDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicsAXResourceDataset__added` | added | `{"type":"object","description":"The path of the Dynamics AX OData entity.","properties":{"typeProper...` |

### Changes for `DynamicsAXResourceDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicsAXResourceDatasetTypeProperties__added` | added | `{"type":"object","description":"Dynamics AX OData resource dataset properties.","properties":{"path"...` |

### Changes for `DynamicsAXSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicsAXSource__added` | added | `{"type":"object","description":"A copy activity Dynamics AX source.","properties":{"query":{"descrip...` |

### Changes for `DynamicsCrmEntityDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicsCrmEntityDataset__added` | added | `{"type":"object","description":"The Dynamics CRM entity dataset.","properties":{"typeProperties":{"$...` |

### Changes for `DynamicsCrmEntityDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicsCrmEntityDatasetTypeProperties__added` | added | `{"type":"object","description":"Dynamics CRM entity dataset properties.","properties":{"entityName":...` |

### Changes for `DynamicsCrmLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicsCrmLinkedService__added` | added | `{"type":"object","description":"Dynamics CRM linked service.","properties":{"typeProperties":{"$ref"...` |

### Changes for `DynamicsCrmLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicsCrmLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Dynamics CRM linked service properties.","properties":{"deploymentTy...` |

### Changes for `DynamicsCrmSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicsCrmSink__added` | added | `{"type":"object","description":"A copy activity Dynamics CRM sink.","properties":{"writeBehavior":{"...` |

### Changes for `DynamicsCrmSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicsCrmSource__added` | added | `{"type":"object","description":"A copy activity Dynamics CRM source.","properties":{"query":{"descri...` |

### Changes for `DynamicsEntityDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicsEntityDataset__added` | added | `{"type":"object","description":"The Dynamics entity dataset.","properties":{"typeProperties":{"$ref"...` |

### Changes for `DynamicsEntityDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicsEntityDatasetTypeProperties__added` | added | `{"type":"object","description":"Dynamics entity dataset properties.","properties":{"entityName":{"de...` |

### Changes for `DynamicsLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicsLinkedService__added` | added | `{"type":"object","description":"Dynamics linked service.","properties":{"typeProperties":{"$ref":"#/...` |

### Changes for `DynamicsLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicsLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Dynamics linked service properties.","properties":{"deploymentType":...` |

### Changes for `DynamicsSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicsSink__added` | added | `{"type":"object","description":"A copy activity Dynamics sink.","properties":{"writeBehavior":{"type...` |

### Changes for `DynamicsSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DynamicsSource__added` | added | `{"type":"object","description":"A copy activity Dynamics source.","properties":{"query":{"descriptio...` |

### Changes for `EloquaLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EloquaLinkedService__added` | added | `{"type":"object","description":"Eloqua server linked service.","properties":{"typeProperties":{"$ref...` |

### Changes for `EloquaLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EloquaLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Eloqua server linked service properties.","properties":{"endpoint":{...` |

### Changes for `EloquaObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EloquaObjectDataset__added` | added | `{"type":"object","description":"Eloqua server dataset.","properties":{"typeProperties":{"$ref":"#/de...` |

### Changes for `EloquaSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EloquaSource__added` | added | `{"type":"object","description":"A copy activity Eloqua server source.","properties":{"query":{"descr...` |

### Changes for `EntityReference`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EntityReference__added` | added | `{"type":"object","description":"The entity reference.","properties":{"type":{"type":"string","descri...` |

### Changes for `EnvironmentVariableSetup`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVariableSetup__added` | added | `{"type":"object","description":"The custom setup of setting environment variable.","properties":{"ty...` |

### Changes for `EnvironmentVariableSetupTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVariableSetupTypeProperties__added` | added | `{"type":"object","description":"Environment variable custom setup type properties.","properties":{"v...` |

### Changes for `ExcelDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExcelDataset__added` | added | `{"type":"object","description":"Excel dataset.","properties":{"typeProperties":{"$ref":"#/definition...` |

### Changes for `ExcelDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExcelDatasetTypeProperties__added` | added | `{"type":"object","description":"Excel dataset properties.","properties":{"location":{"$ref":"#/defin...` |

### Changes for `ExcelSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExcelSource__added` | added | `{"type":"object","description":"A copy activity excel source.","properties":{"storeSettings":{"$ref"...` |

### Changes for `ExecuteDataFlowActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExecuteDataFlowActivity__added` | added | `{"type":"object","description":"Execute data flow activity.","properties":{"typeProperties":{"$ref":...` |

### Changes for `ExecuteDataFlowActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExecuteDataFlowActivityTypeProperties__added` | added | `{"type":"object","description":"Execute data flow activity properties.","properties":{"dataFlow":{"$...` |

### Changes for `ExecuteDataFlowActivityTypePropertiesCompute`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExecuteDataFlowActivityTypePropertiesCompute__added` | added | `{"type":"object","description":"Compute properties for data flow activity.","properties":{"computeTy...` |

### Changes for `ExecutePipelineActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExecutePipelineActivity__added` | added | `{"type":"object","description":"Execute pipeline activity.","properties":{"policy":{"$ref":"#/defini...` |

### Changes for `ExecutePipelineActivityPolicy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExecutePipelineActivityPolicy__added` | added | `{"type":"object","description":"Execution policy for an execute pipeline activity.","properties":{"s...` |

### Changes for `ExecutePipelineActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExecutePipelineActivityTypeProperties__added` | added | `{"type":"object","description":"Execute pipeline activity properties.","properties":{"pipeline":{"$r...` |

### Changes for `ExecutePowerQueryActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExecutePowerQueryActivityTypeProperties__added` | added | `{"type":"object","description":"Execute power query data flow activity properties.","properties":{"s...` |

### Changes for `ExecuteSsisPackageActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExecuteSsisPackageActivity__added` | added | `{"type":"object","description":"Execute SSIS package activity.","properties":{"typeProperties":{"$re...` |

### Changes for `ExecuteSsisPackageActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExecuteSsisPackageActivityTypeProperties__added` | added | `{"type":"object","description":"Execute SSIS package activity properties.","properties":{"packageLoc...` |

### Changes for `ExecuteWranglingDataflowActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExecuteWranglingDataflowActivity__added` | added | `{"type":"object","description":"Execute power query activity.","properties":{"typeProperties":{"$ref...` |

### Changes for `ExecutionActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExecutionActivity__added` | added | `{"type":"object","description":"Base class for all execution activities.","properties":{"type":{"typ...` |

### Changes for `ExportSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExportSettings__added` | added | `{"type":"object","description":"Export command settings.","properties":{"type":{"type":"string","des...` |

### Changes for `ExpressionV2`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressionV2__added` | added | `{"type":"object","description":"Nested representation of a complex expression.","properties":{"type"...` |

### Changes for `FactoryVstsConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FactoryVstsConfiguration__added` | added | `{"type":"object","description":"Factory's VSTS repo information.","properties":{"projectName":{"type...` |

### Changes for `FailActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FailActivity__added` | added | `{"type":"object","description":"This activity will fail within its own scope and output a custom err...` |

### Changes for `FailActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FailActivityTypeProperties__added` | added | `{"type":"object","description":"Fail activity properties.","properties":{"message":{"description":"T...` |

### Changes for `FileServerLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FileServerLinkedService__added` | added | `{"type":"object","description":"File system linked service.","properties":{"typeProperties":{"$ref":...` |

### Changes for `FileServerLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FileServerLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"File system linked service properties.","properties":{"host":{"descr...` |

### Changes for `FileServerLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FileServerLocation__added` | added | `{"type":"object","description":"The location of file server dataset.","allOf":[{"$ref":"#/definition...` |

### Changes for `FileServerReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FileServerReadSettings__added` | added | `{"type":"object","description":"File server read settings.","properties":{"recursive":{"description"...` |

### Changes for `FileServerWriteSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FileServerWriteSettings__added` | added | `{"type":"object","description":"File server write settings.","allOf":[{"$ref":"#/definitions/StoreWr...` |

### Changes for `FileShareDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FileShareDataset__added` | added | `{"type":"object","description":"An on-premises file system dataset.","properties":{"typeProperties":...` |

### Changes for `FileShareDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FileShareDatasetTypeProperties__added` | added | `{"type":"object","description":"On-premises file system dataset properties.","properties":{"folderPa...` |

### Changes for `FileSystemSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FileSystemSink__added` | added | `{"type":"object","description":"A copy activity file system sink.","properties":{"copyBehavior":{"de...` |

### Changes for `FileSystemSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FileSystemSource__added` | added | `{"type":"object","description":"A copy activity file system source.","properties":{"recursive":{"des...` |

### Changes for `FilterActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FilterActivity__added` | added | `{"type":"object","description":"Filter and return results from input array based on the conditions."...` |

### Changes for `FilterActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FilterActivityTypeProperties__added` | added | `{"type":"object","description":"Filter activity properties.","properties":{"items":{"$ref":"#/defini...` |

### Changes for `Flowlet`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Flowlet__added` | added | `{"type":"object","description":"Data flow flowlet","properties":{"typeProperties":{"$ref":"#/definit...` |

### Changes for `FlowletTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FlowletTypeProperties__added` | added | `{"type":"object","description":"Flowlet type properties.","properties":{"sources":{"type":"array","d...` |

### Changes for `ForEachActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ForEachActivity__added` | added | `{"type":"object","description":"This activity is used for iterating over a collection and execute gi...` |

### Changes for `ForEachActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ForEachActivityTypeProperties__added` | added | `{"type":"object","description":"ForEach activity properties.","properties":{"isSequential":{"type":"...` |

### Changes for `FormatReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FormatReadSettings__added` | added | `{"type":"object","description":"Format read settings.","properties":{"type":{"type":"string","descri...` |

### Changes for `FormatWriteSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FormatWriteSettings__added` | added | `{"type":"object","description":"Format write settings.","properties":{"type":{"type":"string","descr...` |

### Changes for `FtpReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FtpReadSettings__added` | added | `{"type":"object","description":"Ftp read settings.","properties":{"recursive":{"description":"If tru...` |

### Changes for `FtpServerLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FtpServerLinkedService__added` | added | `{"type":"object","description":"A FTP server Linked Service.","properties":{"typeProperties":{"$ref"...` |

### Changes for `FtpServerLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FtpServerLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Properties specific to this linked service type.","properties":{"hos...` |

### Changes for `FtpServerLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FtpServerLocation__added` | added | `{"type":"object","description":"The location of ftp server dataset.","allOf":[{"$ref":"#/definitions...` |

### Changes for `GenericDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GenericDatasetTypeProperties__added` | added | `{"type":"object","description":"Properties specific to this dataset type.","properties":{"tableName"...` |

### Changes for `GetMetadataActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GetMetadataActivity__added` | added | `{"type":"object","description":"Activity to get metadata of dataset","properties":{"typeProperties":...` |

### Changes for `GetMetadataActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GetMetadataActivityTypeProperties__added` | added | `{"type":"object","description":"GetMetadata activity properties.","properties":{"dataset":{"$ref":"#...` |

### Changes for `GoogleAdWordsLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleAdWordsLinkedService__added` | added | `{"type":"object","description":"Google AdWords service linked service.","properties":{"typePropertie...` |

### Changes for `GoogleAdWordsLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleAdWordsLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Google AdWords service linked service properties.","properties":{"co...` |

### Changes for `GoogleAdWordsObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleAdWordsObjectDataset__added` | added | `{"type":"object","description":"Google AdWords service dataset.","properties":{"typeProperties":{"$r...` |

### Changes for `GoogleAdWordsSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleAdWordsSource__added` | added | `{"type":"object","description":"A copy activity Google AdWords service source.","properties":{"query...` |

### Changes for `GoogleBigQueryDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleBigQueryDatasetTypeProperties__added` | added | `{"type":"object","description":"Google BigQuery Dataset Properties","properties":{"tableName":{"desc...` |

### Changes for `GoogleBigQueryLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleBigQueryLinkedService__added` | added | `{"type":"object","description":"Google BigQuery service linked service.","properties":{"typeProperti...` |

### Changes for `GoogleBigQueryLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleBigQueryLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Google BigQuery service linked service properties.","properties":{"p...` |

### Changes for `GoogleBigQueryObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleBigQueryObjectDataset__added` | added | `{"type":"object","description":"Google BigQuery service dataset.","properties":{"typeProperties":{"$...` |

### Changes for `GoogleBigQuerySource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleBigQuerySource__added` | added | `{"type":"object","description":"A copy activity Google BigQuery service source.","properties":{"quer...` |

### Changes for `GoogleBigQueryV2DatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleBigQueryV2DatasetTypeProperties__added` | added | `{"type":"object","description":"Google BigQuery Dataset Properties","properties":{"table":{"descript...` |

### Changes for `GoogleBigQueryV2LinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleBigQueryV2LinkedService__added` | added | `{"type":"object","description":"Google BigQuery service linked service.","properties":{"typeProperti...` |

### Changes for `GoogleBigQueryV2LinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleBigQueryV2LinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Google BigQuery service linked service properties.","properties":{"p...` |

### Changes for `GoogleBigQueryV2ObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleBigQueryV2ObjectDataset__added` | added | `{"type":"object","description":"Google BigQuery service dataset.","properties":{"typeProperties":{"$...` |

### Changes for `GoogleBigQueryV2Source`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleBigQueryV2Source__added` | added | `{"type":"object","description":"A copy activity Google BigQuery service source.","properties":{"quer...` |

### Changes for `GoogleCloudStorageLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleCloudStorageLinkedService__added` | added | `{"type":"object","description":"Linked service for Google Cloud Storage.","properties":{"typePropert...` |

### Changes for `GoogleCloudStorageLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleCloudStorageLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Google Cloud Storage linked service properties.","properties":{"acce...` |

### Changes for `GoogleCloudStorageLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleCloudStorageLocation__added` | added | `{"type":"object","description":"The location of Google Cloud Storage dataset.","properties":{"bucket...` |

### Changes for `GoogleCloudStorageReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleCloudStorageReadSettings__added` | added | `{"type":"object","description":"Google Cloud Storage read settings.","properties":{"recursive":{"des...` |

### Changes for `GoogleSheetsLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleSheetsLinkedService__added` | added | `{"type":"object","description":"Linked service for GoogleSheets.","properties":{"typeProperties":{"$...` |

### Changes for `GoogleSheetsLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GoogleSheetsLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"GoogleSheets linked service type properties.","properties":{"apiToke...` |

### Changes for `GreenplumDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GreenplumDatasetTypeProperties__added` | added | `{"type":"object","description":"Greenplum Dataset Properties","properties":{"tableName":{"descriptio...` |

### Changes for `GreenplumLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GreenplumLinkedService__added` | added | `{"type":"object","description":"Greenplum Database linked service.","properties":{"typeProperties":{...` |

### Changes for `GreenplumLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GreenplumLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Greenplum Database linked service properties.","properties":{"connec...` |

### Changes for `GreenplumSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GreenplumSource__added` | added | `{"type":"object","description":"A copy activity Greenplum Database source.","properties":{"query":{"...` |

### Changes for `GreenplumTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GreenplumTableDataset__added` | added | `{"type":"object","description":"Greenplum Database dataset.","properties":{"typeProperties":{"$ref":...` |

### Changes for `HBaseLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HBaseLinkedService__added` | added | `{"type":"object","description":"HBase server linked service.","properties":{"typeProperties":{"$ref"...` |

### Changes for `HBaseLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HBaseLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"HBase server linked service properties.","properties":{"host":{"desc...` |

### Changes for `HBaseObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HBaseObjectDataset__added` | added | `{"type":"object","description":"HBase server dataset.","properties":{"typeProperties":{"$ref":"#/def...` |

### Changes for `HBaseSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HBaseSource__added` | added | `{"type":"object","description":"A copy activity HBase server source.","properties":{"query":{"descri...` |

### Changes for `HDInsightHiveActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HDInsightHiveActivity__added` | added | `{"type":"object","description":"HDInsight Hive activity type.","properties":{"typeProperties":{"$ref...` |

### Changes for `HDInsightHiveActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HDInsightHiveActivityTypeProperties__added` | added | `{"type":"object","description":"HDInsight Hive activity properties.","properties":{"storageLinkedSer...` |

### Changes for `HDInsightLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HDInsightLinkedService__added` | added | `{"type":"object","description":"HDInsight linked service.","properties":{"typeProperties":{"$ref":"#...` |

### Changes for `HDInsightLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HDInsightLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"HDInsight linked service properties.","properties":{"clusterUri":{"d...` |

### Changes for `HDInsightMapReduceActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HDInsightMapReduceActivity__added` | added | `{"type":"object","description":"HDInsight MapReduce activity type.","properties":{"typeProperties":{...` |

### Changes for `HDInsightMapReduceActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HDInsightMapReduceActivityTypeProperties__added` | added | `{"type":"object","description":"HDInsight MapReduce activity properties.","properties":{"storageLink...` |

### Changes for `HDInsightOnDemandLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HDInsightOnDemandLinkedService__added` | added | `{"type":"object","description":"HDInsight ondemand linked service.","properties":{"typeProperties":{...` |

### Changes for `HDInsightOnDemandLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HDInsightOnDemandLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"HDInsight ondemand linked service properties.","properties":{"cluste...` |

### Changes for `HDInsightPigActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HDInsightPigActivity__added` | added | `{"type":"object","description":"HDInsight Pig activity type.","properties":{"typeProperties":{"$ref"...` |

### Changes for `HDInsightPigActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HDInsightPigActivityTypeProperties__added` | added | `{"type":"object","description":"HDInsight Pig activity properties.","properties":{"storageLinkedServ...` |

### Changes for `HDInsightSparkActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HDInsightSparkActivity__added` | added | `{"type":"object","description":"HDInsight Spark activity.","properties":{"typeProperties":{"$ref":"#...` |

### Changes for `HDInsightSparkActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HDInsightSparkActivityTypeProperties__added` | added | `{"type":"object","description":"HDInsight spark activity properties.","properties":{"rootPath":{"des...` |

### Changes for `HDInsightStreamingActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HDInsightStreamingActivity__added` | added | `{"type":"object","description":"HDInsight streaming activity type.","properties":{"typeProperties":{...` |

### Changes for `HDInsightStreamingActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HDInsightStreamingActivityTypeProperties__added` | added | `{"type":"object","description":"HDInsight streaming activity properties.","properties":{"storageLink...` |

### Changes for `HdfsLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HdfsLinkedService__added` | added | `{"type":"object","description":"Hadoop Distributed File System (HDFS) linked service.","properties":...` |

### Changes for `HdfsLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HdfsLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"HDFS linked service properties.","properties":{"url":{"description":...` |

### Changes for `HdfsLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HdfsLocation__added` | added | `{"type":"object","description":"The location of HDFS.","allOf":[{"$ref":"#/definitions/DatasetLocati...` |

### Changes for `HdfsReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HdfsReadSettings__added` | added | `{"type":"object","description":"HDFS read settings.","properties":{"recursive":{"description":"If tr...` |

### Changes for `HdfsSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HdfsSource__added` | added | `{"type":"object","description":"A copy activity HDFS source.","properties":{"recursive":{"descriptio...` |

### Changes for `HiveDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HiveDatasetTypeProperties__added` | added | `{"type":"object","description":"Hive Properties","properties":{"tableName":{"description":"This prop...` |

### Changes for `HiveLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HiveLinkedService__added` | added | `{"type":"object","description":"Hive Server linked service.","properties":{"typeProperties":{"$ref":...` |

### Changes for `HiveLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HiveLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Hive Server linked service properties.","properties":{"host":{"descr...` |

### Changes for `HiveObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HiveObjectDataset__added` | added | `{"type":"object","description":"Hive Server dataset.","properties":{"typeProperties":{"$ref":"#/defi...` |

### Changes for `HiveSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HiveSource__added` | added | `{"type":"object","description":"A copy activity Hive Server source.","properties":{"query":{"descrip...` |

### Changes for `HttpDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HttpDataset__added` | added | `{"type":"object","description":"A file in an HTTP web server.","properties":{"typeProperties":{"$ref...` |

### Changes for `HttpDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HttpDatasetTypeProperties__added` | added | `{"type":"object","description":"Properties specific to this dataset type.","properties":{"relativeUr...` |

### Changes for `HttpLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HttpLinkedService__added` | added | `{"type":"object","description":"Linked service for an HTTP source.","properties":{"typeProperties":{...` |

### Changes for `HttpLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HttpLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Properties specific to this linked service type.","properties":{"url...` |

### Changes for `HttpReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HttpReadSettings__added` | added | `{"type":"object","description":"Http read settings.","properties":{"requestMethod":{"description":"T...` |

### Changes for `HttpServerLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HttpServerLocation__added` | added | `{"type":"object","description":"The location of http server.","properties":{"relativeUrl":{"descript...` |

### Changes for `HttpSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HttpSource__added` | added | `{"type":"object","description":"A copy activity source for an HTTP file.","properties":{"httpRequest...` |

### Changes for `HubspotLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HubspotLinkedService__added` | added | `{"type":"object","description":"Hubspot Service linked service.","properties":{"typeProperties":{"$r...` |

### Changes for `HubspotLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HubspotLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Hubspot Service linked service properties.","properties":{"clientId"...` |

### Changes for `HubspotObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HubspotObjectDataset__added` | added | `{"type":"object","description":"Hubspot Service dataset.","properties":{"typeProperties":{"$ref":"#/...` |

### Changes for `HubspotSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HubspotSource__added` | added | `{"type":"object","description":"A copy activity Hubspot Service source.","properties":{"query":{"des...` |

### Changes for `IcebergDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IcebergDataset__added` | added | `{"type":"object","description":"Iceberg dataset.","properties":{"typeProperties":{"$ref":"#/definiti...` |

### Changes for `IcebergDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IcebergDatasetTypeProperties__added` | added | `{"type":"object","description":"Iceberg dataset properties.","properties":{"location":{"$ref":"#/def...` |

### Changes for `IcebergSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IcebergSink__added` | added | `{"type":"object","description":"A copy activity Iceberg sink.","properties":{"storeSettings":{"$ref"...` |

### Changes for `IcebergWriteSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IcebergWriteSettings__added` | added | `{"type":"object","description":"Iceberg write settings.","allOf":[{"$ref":"#/definitions/FormatWrite...` |

### Changes for `IfConditionActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IfConditionActivity__added` | added | `{"type":"object","description":"This activity evaluates a boolean expression and executes either the...` |

### Changes for `IfConditionActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IfConditionActivityTypeProperties__added` | added | `{"type":"object","description":"IfCondition activity properties.","properties":{"expression":{"$ref"...` |

### Changes for `ImpalaDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImpalaDatasetTypeProperties__added` | added | `{"type":"object","description":"Impala Dataset Properties","properties":{"tableName":{"description":...` |

### Changes for `ImpalaLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImpalaLinkedService__added` | added | `{"type":"object","description":"Impala server linked service.","properties":{"typeProperties":{"$ref...` |

### Changes for `ImpalaLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImpalaLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Impala server linked service properties.","properties":{"host":{"des...` |

### Changes for `ImpalaObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImpalaObjectDataset__added` | added | `{"type":"object","description":"Impala server dataset.","properties":{"typeProperties":{"$ref":"#/de...` |

### Changes for `ImpalaSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImpalaSource__added` | added | `{"type":"object","description":"A copy activity Impala server source.","properties":{"query":{"descr...` |

### Changes for `ImportSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImportSettings__added` | added | `{"type":"object","description":"Import command settings.","properties":{"type":{"type":"string","des...` |

### Changes for `InformixLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InformixLinkedService__added` | added | `{"type":"object","description":"Informix linked service.","properties":{"typeProperties":{"$ref":"#/...` |

### Changes for `InformixLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InformixLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Informix linked service properties.","properties":{"connectionString...` |

### Changes for `InformixSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InformixSink__added` | added | `{"type":"object","description":"A copy activity Informix sink.","properties":{"preCopyScript":{"desc...` |

### Changes for `InformixSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InformixSource__added` | added | `{"type":"object","description":"A copy activity source for Informix.","properties":{"query":{"descri...` |

### Changes for `InformixTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InformixTableDataset__added` | added | `{"type":"object","description":"The Informix table dataset.","properties":{"typeProperties":{"$ref":...` |

### Changes for `InformixTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InformixTableDatasetTypeProperties__added` | added | `{"type":"object","description":"Informix table dataset properties.","properties":{"tableName":{"desc...` |

### Changes for `IntegrationRuntime`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntime__added` | added | `{"type":"object","description":"Azure Data Factory nested object which serves as a compute resource ...` |

### Changes for `IntegrationRuntimeAuthKeys`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeAuthKeys__added` | added | `{"type":"object","description":"The integration runtime authentication keys.","properties":{"authKey...` |

### Changes for `IntegrationRuntimeComputeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeComputeProperties__added` | added | `{"type":"object","description":"The compute resource properties for managed integration runtime.","p...` |

### Changes for `IntegrationRuntimeConnectionInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeConnectionInfo__added` | added | `{"type":"object","description":"Connection information for encrypting the on-premises data source cr...` |

### Changes for `IntegrationRuntimeCustomSetupScriptProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeCustomSetupScriptProperties__added` | added | `{"type":"object","description":"Custom setup script properties for a managed dedicated integration r...` |

### Changes for `IntegrationRuntimeCustomerVirtualNetwork`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeCustomerVirtualNetwork__added` | added | `{"type":"object","description":"The definition and properties of virtual network to which Azure-SSIS...` |

### Changes for `IntegrationRuntimeDataFlowProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeDataFlowProperties__added` | added | `{"type":"object","description":"Data flow properties for managed integration runtime.","properties":...` |

### Changes for `IntegrationRuntimeDataFlowPropertiesCustomPropertiesItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeDataFlowPropertiesCustomPropertiesItem__added` | added | `{"type":"object","properties":{"name":{"type":"string","description":"Name of custom property."},"va...` |

### Changes for `IntegrationRuntimeDataProxyProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeDataProxyProperties__added` | added | `{"type":"object","description":"Data proxy properties for a managed dedicated integration runtime.",...` |

### Changes for `IntegrationRuntimeMonitoringData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeMonitoringData__added` | added | `{"type":"object","description":"Get monitoring data response.","properties":{"name":{"type":"string"...` |

### Changes for `IntegrationRuntimeNodeIpAddress`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeNodeIpAddress__added` | added | `{"type":"object","description":"The IP address of self-hosted integration runtime node.","properties...` |

### Changes for `IntegrationRuntimeNodeMonitoringData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeNodeMonitoringData__added` | added | `{"type":"object","description":"Monitoring data for integration runtime node.","properties":{"nodeNa...` |

### Changes for `IntegrationRuntimeOutboundNetworkDependenciesCategoryEndpoint`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeOutboundNetworkDependenciesCategoryEndpoint__added` | added | `{"type":"object","description":"Azure-SSIS integration runtime outbound network dependency endpoints...` |

### Changes for `IntegrationRuntimeOutboundNetworkDependenciesEndpoint`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeOutboundNetworkDependenciesEndpoint__added` | added | `{"type":"object","description":"The endpoint for Azure-SSIS integration runtime outbound network dep...` |

### Changes for `IntegrationRuntimeOutboundNetworkDependenciesEndpointDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeOutboundNetworkDependenciesEndpointDetails__added` | added | `{"type":"object","description":"The details of Azure-SSIS integration runtime outbound network depen...` |

### Changes for `IntegrationRuntimeOutboundNetworkDependenciesEndpointsResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeOutboundNetworkDependenciesEndpointsResponse__added` | added | `{"type":"object","description":"Azure-SSIS integration runtime outbound network dependency endpoints...` |

### Changes for `IntegrationRuntimeRegenerateKeyParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeRegenerateKeyParameters__added` | added | `{"type":"object","description":"Parameters to regenerate the authentication key.","properties":{"key...` |

### Changes for `IntegrationRuntimeSsisCatalogInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeSsisCatalogInfo__added` | added | `{"type":"object","description":"Catalog information for managed dedicated integration runtime.","pro...` |

### Changes for `IntegrationRuntimeSsisProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeSsisProperties__added` | added | `{"type":"object","description":"SSIS properties for managed integration runtime.","properties":{"cat...` |

### Changes for `IntegrationRuntimeStatus`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeStatus__added` | added | `{"type":"object","description":"Integration runtime status.","properties":{"type":{"type":"string","...` |

### Changes for `IntegrationRuntimeVNetProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IntegrationRuntimeVNetProperties__added` | added | `{"type":"object","description":"VNet properties for managed integration runtime.","properties":{"vNe...` |

### Changes for `InteractiveQueryProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InteractiveQueryProperties__added` | added | `{"type":"object","description":"Interactive authoring capability type properties.","properties":{"st...` |

### Changes for `JiraLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JiraLinkedService__added` | added | `{"type":"object","description":"Jira Service linked service.","properties":{"typeProperties":{"$ref"...` |

### Changes for `JiraLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JiraLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Jira Service linked service properties.","properties":{"host":{"desc...` |

### Changes for `JiraObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JiraObjectDataset__added` | added | `{"type":"object","description":"Jira Service dataset.","properties":{"typeProperties":{"$ref":"#/def...` |

### Changes for `JiraSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JiraSource__added` | added | `{"type":"object","description":"A copy activity Jira Service source.","properties":{"query":{"descri...` |

### Changes for `JiraTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JiraTableDatasetTypeProperties__added` | added | `{"type":"object","description":"Jira dataset properties.","properties":{"tableName":{"description":"...` |

### Changes for `JsonDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JsonDataset__added` | added | `{"type":"object","description":"Json dataset.","properties":{"typeProperties":{"$ref":"#/definitions...` |

### Changes for `JsonDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JsonDatasetTypeProperties__added` | added | `{"type":"object","description":"Json dataset properties.","properties":{"location":{"$ref":"#/defini...` |

### Changes for `JsonFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JsonFormat__added` | added | `{"type":"object","description":"The data stored in JSON format.","properties":{"filePattern":{"descr...` |

### Changes for `JsonReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JsonReadSettings__added` | added | `{"type":"object","description":"Json read settings.","properties":{"compressionProperties":{"$ref":"...` |

### Changes for `JsonSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JsonSink__added` | added | `{"type":"object","description":"A copy activity Json sink.","properties":{"storeSettings":{"$ref":"#...` |

### Changes for `JsonSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JsonSource__added` | added | `{"type":"object","description":"A copy activity Json source.","properties":{"storeSettings":{"$ref":...` |

### Changes for `JsonWriteSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JsonWriteSettings__added` | added | `{"type":"object","description":"Json write settings.","properties":{"filePattern":{"description":"Fi...` |

### Changes for `LakeHouseLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LakeHouseLinkedService__added` | added | `{"type":"object","description":"Microsoft Fabric Lakehouse linked service.","properties":{"typePrope...` |

### Changes for `LakeHouseLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LakeHouseLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Microsoft Fabric Lakehouse linked service properties.","properties":...` |

### Changes for `LakeHouseLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LakeHouseLocation__added` | added | `{"type":"object","description":"The location of Microsoft Fabric Lakehouse Files dataset.","allOf":[...` |

### Changes for `LakeHouseReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LakeHouseReadSettings__added` | added | `{"type":"object","description":"Microsoft Fabric Lakehouse Files read settings.","properties":{"recu...` |

### Changes for `LakeHouseTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LakeHouseTableDataset__added` | added | `{"type":"object","description":"Microsoft Fabric Lakehouse Table.","properties":{"typeProperties":{"...` |

### Changes for `LakeHouseTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LakeHouseTableDatasetTypeProperties__added` | added | `{"type":"object","description":"Microsoft Fabric Lakehouse Table dataset properties.","properties":{...` |

### Changes for `LakeHouseTableSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LakeHouseTableSink__added` | added | `{"type":"object","description":"A copy activity for Microsoft Fabric Lakehouse Table sink.","propert...` |

### Changes for `LakeHouseTableSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LakeHouseTableSource__added` | added | `{"type":"object","description":"A copy activity source for Microsoft Fabric Lakehouse Table.","prope...` |

### Changes for `LakeHouseWriteSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LakeHouseWriteSettings__added` | added | `{"type":"object","description":"Microsoft Fabric Lakehouse Files write settings.","allOf":[{"$ref":"...` |

### Changes for `LicensedComponentSetupTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LicensedComponentSetupTypeProperties__added` | added | `{"type":"object","description":"Installation of licensed component setup type properties.","properti...` |

### Changes for `LinkedIntegrationRuntime`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LinkedIntegrationRuntime__added` | added | `{"type":"object","description":"The linked integration runtime information.","properties":{"name":{"...` |

### Changes for `LinkedIntegrationRuntimeKeyAuthorization`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LinkedIntegrationRuntimeKeyAuthorization__added` | added | `{"type":"object","description":"The key authorization type integration runtime.","properties":{"key"...` |

### Changes for `LinkedIntegrationRuntimeRbacAuthorization`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LinkedIntegrationRuntimeRbacAuthorization__added` | added | `{"type":"object","description":"The role based access control (RBAC) authorization type integration ...` |

### Changes for `LinkedIntegrationRuntimeType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LinkedIntegrationRuntimeType__added` | added | `{"type":"object","description":"The base definition of a linked integration runtime.","properties":{...` |

### Changes for `LinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LinkedService__added` | added | `{"type":"object","description":"The nested object which contains the information and credential whic...` |

### Changes for `LogLocationSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogLocationSettings__added` | added | `{"type":"object","description":"Log location settings.","properties":{"linkedServiceName":{"$ref":"#...` |

### Changes for `LogSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogSettings__added` | added | `{"type":"object","description":"Log settings.","properties":{"enableCopyActivityLog":{"description":...` |

### Changes for `LogStorageSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogStorageSettings__added` | added | `{"type":"object","description":"(Deprecated. Please use LogSettings) Log storage settings.","propert...` |

### Changes for `LookupActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LookupActivity__added` | added | `{"type":"object","description":"Lookup activity.","properties":{"typeProperties":{"$ref":"#/definiti...` |

### Changes for `LookupActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LookupActivityTypeProperties__added` | added | `{"type":"object","description":"Lookup activity properties.","properties":{"source":{"$ref":"#/defin...` |

### Changes for `MagentoLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MagentoLinkedService__added` | added | `{"type":"object","description":"Magento server linked service.","properties":{"typeProperties":{"$re...` |

### Changes for `MagentoLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MagentoLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Magento server linked service properties.","properties":{"host":{"de...` |

### Changes for `MagentoObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MagentoObjectDataset__added` | added | `{"type":"object","description":"Magento server dataset.","properties":{"typeProperties":{"$ref":"#/d...` |

### Changes for `MagentoSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MagentoSource__added` | added | `{"type":"object","description":"A copy activity Magento server source.","properties":{"query":{"desc...` |

### Changes for `ManagedIdentityCredential`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedIdentityCredential__added` | added | `{"type":"object","description":"Managed identity credential.","properties":{"typeProperties":{"$ref"...` |

### Changes for `ManagedIdentityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedIdentityTypeProperties__added` | added | `{"type":"object","description":"Managed identity type properties.","properties":{"resourceId":{"type...` |

### Changes for `ManagedIntegrationRuntime`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedIntegrationRuntime__added` | added | `{"type":"object","description":"Managed integration runtime, including managed elastic and managed d...` |

### Changes for `ManagedIntegrationRuntimeError`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedIntegrationRuntimeError__added` | added | `{"type":"object","description":"Error definition for managed integration runtime.","properties":{"ti...` |

### Changes for `ManagedIntegrationRuntimeNode`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedIntegrationRuntimeNode__added` | added | `{"type":"object","description":"Properties of integration runtime node.","properties":{"nodeId":{"ty...` |

### Changes for `ManagedIntegrationRuntimeOperationResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedIntegrationRuntimeOperationResult__added` | added | `{"type":"object","description":"Properties of managed integration runtime operation result.","proper...` |

### Changes for `ManagedIntegrationRuntimeStatus`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedIntegrationRuntimeStatus__added` | added | `{"type":"object","description":"Managed integration runtime status.","properties":{"typeProperties":...` |

### Changes for `ManagedIntegrationRuntimeStatusTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedIntegrationRuntimeStatusTypeProperties__added` | added | `{"type":"object","description":"Managed integration runtime status type properties.","properties":{"...` |

### Changes for `ManagedIntegrationRuntimeTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedIntegrationRuntimeTypeProperties__added` | added | `{"type":"object","description":"Managed integration runtime type properties.","properties":{"compute...` |

### Changes for `ManagedPrivateEndpoint`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedPrivateEndpoint__added` | added | `{"type":"object","description":"Properties of a managed private endpoint","properties":{"connectionS...` |

### Changes for `ManagedPrivateEndpointListResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedPrivateEndpointListResponse__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ManagedVirtualNetwork`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedVirtualNetwork__added` | added | `{"type":"object","description":"A managed Virtual Network associated with the Azure Data Factory","p...` |

### Changes for `MapperAttributeMapping`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MapperAttributeMapping__added` | added | `{"type":"object","description":"Source and target column mapping details.","properties":{"name":{"ty...` |

### Changes for `MapperAttributeMappings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MapperAttributeMappings__added` | added | `{"type":"object","description":"Attribute mapping details.","properties":{"attributeMappings":{"type...` |

### Changes for `MapperAttributeReference`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MapperAttributeReference__added` | added | `{"type":"object","description":"Attribute reference details for the referred column.","properties":{...` |

### Changes for `MapperConnection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MapperConnection__added` | added | `{"type":"object","description":"Source connection details.","properties":{"linkedService":{"$ref":"#...` |

### Changes for `MapperConnectionReference`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MapperConnectionReference__added` | added | `{"type":"object","description":"Source or target connection reference details.","properties":{"conne...` |

### Changes for `MapperDslConnectorProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MapperDslConnectorProperties__added` | added | `{"type":"object","description":"Connector properties of a CDC table in terms of name / value pairs."...` |

### Changes for `MapperPolicy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MapperPolicy__added` | added | `{"type":"object","description":"CDC Policy.","properties":{"mode":{"type":"string","description":"Mo...` |

### Changes for `MapperPolicyRecurrence`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MapperPolicyRecurrence__added` | added | `{"type":"object","description":"CDC policy recurrence details.","properties":{"frequency":{"type":"s...` |

### Changes for `MapperSourceConnectionsInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MapperSourceConnectionsInfo__added` | added | `{"type":"object","description":"A object which contains list of tables and connection details for a ...` |

### Changes for `MapperTable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MapperTable__added` | added | `{"type":"object","description":"CDC table details.","properties":{"name":{"type":"string","descripti...` |

### Changes for `MapperTableProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MapperTableProperties__added` | added | `{"type":"object","description":"Properties for a CDC table.","properties":{"schema":{"type":"array",...` |

### Changes for `MapperTableSchema`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MapperTableSchema__added` | added | `{"type":"object","description":"Schema of a CDC table in terms of column names and their correspondi...` |

### Changes for `MapperTargetConnectionsInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MapperTargetConnectionsInfo__added` | added | `{"type":"object","description":"A object which contains list of tables and connection details for a ...` |

### Changes for `MappingDataFlow`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MappingDataFlow__added` | added | `{"type":"object","description":"Mapping data flow.","properties":{"typeProperties":{"$ref":"#/defini...` |

### Changes for `MappingDataFlowTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MappingDataFlowTypeProperties__added` | added | `{"type":"object","description":"Mapping data flow type properties.","properties":{"sources":{"type":...` |

### Changes for `MariaDBLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MariaDBLinkedService__added` | added | `{"type":"object","description":"MariaDB server linked service.","properties":{"typeProperties":{"$re...` |

### Changes for `MariaDBLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MariaDBLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"MariaDB server linked service properties.","properties":{"driverVers...` |

### Changes for `MariaDBSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MariaDBSource__added` | added | `{"type":"object","description":"A copy activity MariaDB server source.","properties":{"query":{"desc...` |

### Changes for `MariaDBTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MariaDBTableDataset__added` | added | `{"type":"object","description":"MariaDB server dataset.","properties":{"typeProperties":{"$ref":"#/d...` |

### Changes for `MarketoLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MarketoLinkedService__added` | added | `{"type":"object","description":"Marketo server linked service.","properties":{"typeProperties":{"$re...` |

### Changes for `MarketoLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MarketoLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Marketo server linked service properties.","properties":{"endpoint":...` |

### Changes for `MarketoObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MarketoObjectDataset__added` | added | `{"type":"object","description":"Marketo server dataset.","properties":{"typeProperties":{"$ref":"#/d...` |

### Changes for `MarketoSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MarketoSource__added` | added | `{"type":"object","description":"A copy activity Marketo server source.","properties":{"query":{"desc...` |

### Changes for `MetadataItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetadataItem__added` | added | `{"type":"object","description":"Specify the name and value of custom metadata item.","properties":{"...` |

### Changes for `MicrosoftAccessLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MicrosoftAccessLinkedService__added` | added | `{"type":"object","description":"Microsoft Access linked service.","properties":{"typeProperties":{"$...` |

### Changes for `MicrosoftAccessLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MicrosoftAccessLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Microsoft Access linked service properties.","properties":{"connecti...` |

### Changes for `MicrosoftAccessSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MicrosoftAccessSink__added` | added | `{"type":"object","description":"A copy activity Microsoft Access sink.","properties":{"preCopyScript...` |

### Changes for `MicrosoftAccessSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MicrosoftAccessSource__added` | added | `{"type":"object","description":"A copy activity source for Microsoft Access.","properties":{"query":...` |

### Changes for `MicrosoftAccessTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MicrosoftAccessTableDataset__added` | added | `{"type":"object","description":"The Microsoft Access table dataset.","properties":{"typeProperties":...` |

### Changes for `MicrosoftAccessTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MicrosoftAccessTableDatasetTypeProperties__added` | added | `{"type":"object","description":"Microsoft Access table dataset properties.","properties":{"tableName...` |

### Changes for `MongoDbAtlasCollectionDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MongoDbAtlasCollectionDataset__added` | added | `{"type":"object","description":"The MongoDB Atlas database dataset.","properties":{"typeProperties":...` |

### Changes for `MongoDbAtlasCollectionDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MongoDbAtlasCollectionDatasetTypeProperties__added` | added | `{"type":"object","description":"MongoDB Atlas database dataset properties.","properties":{"collectio...` |

### Changes for `MongoDbAtlasLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MongoDbAtlasLinkedService__added` | added | `{"type":"object","description":"Linked service for MongoDB Atlas data source.","properties":{"typePr...` |

### Changes for `MongoDbAtlasLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MongoDbAtlasLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"MongoDB Atlas linked service properties.","properties":{"connectionS...` |

### Changes for `MongoDbAtlasSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MongoDbAtlasSink__added` | added | `{"type":"object","description":"A copy activity MongoDB Atlas sink.","properties":{"writeBehavior":{...` |

### Changes for `MongoDbAtlasSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MongoDbAtlasSource__added` | added | `{"type":"object","description":"A copy activity source for a MongoDB Atlas database.","properties":{...` |

### Changes for `MongoDbCollectionDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MongoDbCollectionDataset__added` | added | `{"type":"object","description":"The MongoDB database dataset.","properties":{"typeProperties":{"$ref...` |

### Changes for `MongoDbCollectionDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MongoDbCollectionDatasetTypeProperties__added` | added | `{"type":"object","description":"MongoDB database dataset properties.","properties":{"collectionName"...` |

### Changes for `MongoDbCursorMethodsProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MongoDbCursorMethodsProperties__added` | added | `{"type":"object","description":"Cursor methods for Mongodb query","properties":{"project":{"descript...` |

### Changes for `MongoDbLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MongoDbLinkedService__added` | added | `{"type":"object","description":"Linked service for MongoDb data source.","properties":{"typeProperti...` |

### Changes for `MongoDbLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MongoDbLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"MongoDB linked service properties.","properties":{"server":{"descrip...` |

### Changes for `MongoDbSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MongoDbSource__added` | added | `{"type":"object","description":"A copy activity source for a MongoDB database.","properties":{"query...` |

### Changes for `MongoDbV2CollectionDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MongoDbV2CollectionDataset__added` | added | `{"type":"object","description":"The MongoDB database dataset.","properties":{"typeProperties":{"$ref...` |

### Changes for `MongoDbV2CollectionDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MongoDbV2CollectionDatasetTypeProperties__added` | added | `{"type":"object","description":"MongoDB database dataset properties.","properties":{"collection":{"d...` |

### Changes for `MongoDbV2LinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MongoDbV2LinkedService__added` | added | `{"type":"object","description":"Linked service for MongoDB data source.","properties":{"typeProperti...` |

### Changes for `MongoDbV2LinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MongoDbV2LinkedServiceTypeProperties__added` | added | `{"type":"object","description":"MongoDB linked service properties.","properties":{"connectionString"...` |

### Changes for `MongoDbV2Sink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MongoDbV2Sink__added` | added | `{"type":"object","description":"A copy activity MongoDB sink.","properties":{"writeBehavior":{"descr...` |

### Changes for `MongoDbV2Source`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MongoDbV2Source__added` | added | `{"type":"object","description":"A copy activity source for a MongoDB database.","properties":{"filte...` |

### Changes for `MultiplePipelineTrigger`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MultiplePipelineTrigger__added` | added | `{"type":"object","description":"Base class for all triggers that support one to many model for trigg...` |

### Changes for `MySqlLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MySqlLinkedService__added` | added | `{"type":"object","description":"Linked service for MySQL data source.","properties":{"typeProperties...` |

### Changes for `MySqlLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MySqlLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"MySQL linked service properties.","properties":{"driverVersion":{"de...` |

### Changes for `MySqlSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MySqlSource__added` | added | `{"type":"object","description":"A copy activity source for MySQL databases.","properties":{"query":{...` |

### Changes for `MySqlTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MySqlTableDataset__added` | added | `{"type":"object","description":"The MySQL table dataset.","properties":{"typeProperties":{"$ref":"#/...` |

### Changes for `MySqlTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MySqlTableDatasetTypeProperties__added` | added | `{"type":"object","description":"MySql table dataset properties.","properties":{"tableName":{"descrip...` |

### Changes for `NetezzaLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetezzaLinkedService__added` | added | `{"type":"object","description":"Netezza linked service.","properties":{"typeProperties":{"$ref":"#/d...` |

### Changes for `NetezzaLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetezzaLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Netezza linked service properties.","properties":{"connectionString"...` |

### Changes for `NetezzaPartitionSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetezzaPartitionSettings__added` | added | `{"type":"object","description":"The settings that will be leveraged for Netezza source partitioning....` |

### Changes for `NetezzaSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetezzaSource__added` | added | `{"type":"object","description":"A copy activity Netezza source.","properties":{"query":{"description...` |

### Changes for `NetezzaTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetezzaTableDataset__added` | added | `{"type":"object","description":"Netezza dataset.","properties":{"typeProperties":{"$ref":"#/definiti...` |

### Changes for `NetezzaTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetezzaTableDatasetTypeProperties__added` | added | `{"type":"object","description":"Netezza dataset properties.","properties":{"tableName":{"description...` |

### Changes for `NotebookParameter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NotebookParameter__added` | added | `{"type":"object","description":"Notebook parameter.","properties":{"value":{"description":"Notebook ...` |

### Changes for `ODataLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ODataLinkedService__added` | added | `{"type":"object","description":"Open Data Protocol (OData) linked service.","properties":{"typePrope...` |

### Changes for `ODataLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ODataLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"OData linked service properties.","properties":{"url":{"description"...` |

### Changes for `ODataResourceDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ODataResourceDataset__added` | added | `{"type":"object","description":"The Open Data Protocol (OData) resource dataset.","properties":{"typ...` |

### Changes for `ODataResourceDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ODataResourceDatasetTypeProperties__added` | added | `{"type":"object","description":"OData dataset properties.","properties":{"path":{"description":"The ...` |

### Changes for `ODataSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ODataSource__added` | added | `{"type":"object","description":"A copy activity source for OData source.","properties":{"query":{"de...` |

### Changes for `OdbcLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OdbcLinkedService__added` | added | `{"type":"object","description":"Open Database Connectivity (ODBC) linked service.","properties":{"ty...` |

### Changes for `OdbcLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OdbcLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"ODBC linked service properties.","properties":{"connectionString":{"...` |

### Changes for `OdbcSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OdbcSink__added` | added | `{"type":"object","description":"A copy activity ODBC sink.","properties":{"preCopyScript":{"descript...` |

### Changes for `OdbcSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OdbcSource__added` | added | `{"type":"object","description":"A copy activity source for ODBC databases.","properties":{"query":{"...` |

### Changes for `OdbcTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OdbcTableDataset__added` | added | `{"type":"object","description":"The ODBC table dataset.","properties":{"typeProperties":{"$ref":"#/d...` |

### Changes for `OdbcTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OdbcTableDatasetTypeProperties__added` | added | `{"type":"object","description":"ODBC table dataset properties.","properties":{"tableName":{"descript...` |

### Changes for `Office365Dataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Office365Dataset__added` | added | `{"type":"object","description":"The Office365 account.","properties":{"typeProperties":{"$ref":"#/de...` |

### Changes for `Office365DatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Office365DatasetTypeProperties__added` | added | `{"type":"object","description":"Office365 dataset properties.","properties":{"tableName":{"descripti...` |

### Changes for `Office365LinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Office365LinkedService__added` | added | `{"type":"object","description":"Office365 linked service.","properties":{"typeProperties":{"$ref":"#...` |

### Changes for `Office365LinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Office365LinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Office365 linked service properties.","properties":{"office365Tenant...` |

### Changes for `Office365Source`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Office365Source__added` | added | `{"type":"object","description":"A copy activity source for an Office 365 service.","properties":{"al...` |

### Changes for `OracleCloudStorageLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OracleCloudStorageLinkedService__added` | added | `{"type":"object","description":"Linked service for Oracle Cloud Storage.","properties":{"typePropert...` |

### Changes for `OracleCloudStorageLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OracleCloudStorageLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Oracle Cloud Storage linked service properties.","properties":{"acce...` |

### Changes for `OracleCloudStorageLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OracleCloudStorageLocation__added` | added | `{"type":"object","description":"The location of Oracle Cloud Storage dataset.","properties":{"bucket...` |

### Changes for `OracleCloudStorageReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OracleCloudStorageReadSettings__added` | added | `{"type":"object","description":"Oracle Cloud Storage read settings.","properties":{"recursive":{"des...` |

### Changes for `OracleLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OracleLinkedService__added` | added | `{"type":"object","description":"Oracle database. This linked service has supported version property....` |

### Changes for `OracleLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OracleLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Oracle database linked service properties.","properties":{"connectio...` |

### Changes for `OraclePartitionSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OraclePartitionSettings__added` | added | `{"type":"object","description":"The settings that will be leveraged for Oracle source partitioning."...` |

### Changes for `OracleServiceCloudLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OracleServiceCloudLinkedService__added` | added | `{"type":"object","description":"Oracle Service Cloud linked service.","properties":{"typeProperties"...` |

### Changes for `OracleServiceCloudLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OracleServiceCloudLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Oracle Service Cloud linked service properties.","properties":{"host...` |

### Changes for `OracleServiceCloudObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OracleServiceCloudObjectDataset__added` | added | `{"type":"object","description":"Oracle Service Cloud dataset.","properties":{"typeProperties":{"$ref...` |

### Changes for `OracleServiceCloudSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OracleServiceCloudSource__added` | added | `{"type":"object","description":"A copy activity Oracle Service Cloud source.","properties":{"query":...` |

### Changes for `OracleSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OracleSink__added` | added | `{"type":"object","description":"A copy activity Oracle sink.","properties":{"preCopyScript":{"descri...` |

### Changes for `OracleSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OracleSource__added` | added | `{"type":"object","description":"A copy activity Oracle source.","properties":{"oracleReaderQuery":{"...` |

### Changes for `OracleTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OracleTableDataset__added` | added | `{"type":"object","description":"The on-premises Oracle database dataset.","properties":{"typePropert...` |

### Changes for `OracleTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OracleTableDatasetTypeProperties__added` | added | `{"type":"object","description":"On-premises Oracle dataset properties.","properties":{"tableName":{"...` |

### Changes for `OrcDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OrcDataset__added` | added | `{"type":"object","description":"ORC dataset.","properties":{"typeProperties":{"$ref":"#/definitions/...` |

### Changes for `OrcDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OrcDatasetTypeProperties__added` | added | `{"type":"object","description":"ORC dataset properties.","properties":{"location":{"$ref":"#/definit...` |

### Changes for `OrcFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OrcFormat__added` | added | `{"type":"object","description":"The data stored in Optimized Row Columnar (ORC) format.","allOf":[{"...` |

### Changes for `OrcSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OrcSink__added` | added | `{"type":"object","description":"A copy activity ORC sink.","properties":{"storeSettings":{"$ref":"#/...` |

### Changes for `OrcSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OrcSource__added` | added | `{"type":"object","description":"A copy activity ORC source.","properties":{"storeSettings":{"$ref":"...` |

### Changes for `OrcWriteSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OrcWriteSettings__added` | added | `{"type":"object","description":"Orc write settings.","properties":{"maxRowsPerFile":{"description":"...` |

### Changes for `PackageStore`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PackageStore__added` | added | `{"type":"object","description":"Package store for the SSIS integration runtime.","properties":{"name...` |

### Changes for `ParquetDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ParquetDataset__added` | added | `{"type":"object","description":"Parquet dataset.","properties":{"typeProperties":{"$ref":"#/definiti...` |

### Changes for `ParquetDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ParquetDatasetTypeProperties__added` | added | `{"type":"object","description":"Parquet dataset properties.","properties":{"location":{"$ref":"#/def...` |

### Changes for `ParquetFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ParquetFormat__added` | added | `{"type":"object","description":"The data stored in Parquet format.","allOf":[{"$ref":"#/definitions/...` |

### Changes for `ParquetReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ParquetReadSettings__added` | added | `{"type":"object","description":"Parquet read settings.","properties":{"compressionProperties":{"$ref...` |

### Changes for `ParquetSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ParquetSink__added` | added | `{"type":"object","description":"A copy activity Parquet sink.","properties":{"storeSettings":{"$ref"...` |

### Changes for `ParquetSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ParquetSource__added` | added | `{"type":"object","description":"A copy activity Parquet source.","properties":{"storeSettings":{"$re...` |

### Changes for `ParquetWriteSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ParquetWriteSettings__added` | added | `{"type":"object","description":"Parquet write settings.","properties":{"maxRowsPerFile":{"descriptio...` |

### Changes for `PaypalLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PaypalLinkedService__added` | added | `{"type":"object","description":"Paypal Service linked service.","properties":{"typeProperties":{"$re...` |

### Changes for `PaypalLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PaypalLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Paypal Service linked service properties.","properties":{"host":{"de...` |

### Changes for `PaypalObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PaypalObjectDataset__added` | added | `{"type":"object","description":"Paypal Service dataset.","properties":{"typeProperties":{"$ref":"#/d...` |

### Changes for `PaypalSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PaypalSource__added` | added | `{"type":"object","description":"A copy activity Paypal Service source.","properties":{"query":{"desc...` |

### Changes for `PhoenixDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PhoenixDatasetTypeProperties__added` | added | `{"type":"object","description":"Phoenix Dataset Properties","properties":{"tableName":{"description"...` |

### Changes for `PhoenixLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PhoenixLinkedService__added` | added | `{"type":"object","description":"Phoenix server linked service.","properties":{"typeProperties":{"$re...` |

### Changes for `PhoenixLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PhoenixLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Phoenix server linked service properties.","properties":{"host":{"de...` |

### Changes for `PhoenixObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PhoenixObjectDataset__added` | added | `{"type":"object","description":"Phoenix server dataset.","properties":{"typeProperties":{"$ref":"#/d...` |

### Changes for `PhoenixSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PhoenixSource__added` | added | `{"type":"object","description":"A copy activity Phoenix server source.","properties":{"query":{"desc...` |

### Changes for `Pipeline`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Pipeline__added` | added | `{"type":"object","description":"A data factory pipeline.","properties":{"description":{"type":"strin...` |

### Changes for `PipelineElapsedTimeMetricPolicy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PipelineElapsedTimeMetricPolicy__added` | added | `{"type":"object","description":"Pipeline ElapsedTime Metric Policy.","properties":{"duration":{"desc...` |

### Changes for `PipelineExternalComputeScaleProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PipelineExternalComputeScaleProperties__added` | added | `{"type":"object","description":"PipelineExternalComputeScale properties for managed integration runt...` |

### Changes for `PipelineFolder`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PipelineFolder__added` | added | `{"type":"object","description":"The folder that this Pipeline is in. If not specified, Pipeline will...` |

### Changes for `PipelinePolicy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PipelinePolicy__added` | added | `{"type":"object","description":"Pipeline Policy.","properties":{"elapsedTimeMetric":{"$ref":"#/defin...` |

### Changes for `PolybaseSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PolybaseSettings__added` | added | `{"type":"object","description":"PolyBase settings.","properties":{"rejectType":{"type":"string","des...` |

### Changes for `PostgreSqlLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PostgreSqlLinkedService__added` | added | `{"type":"object","description":"Linked service for PostgreSQL data source.","properties":{"typePrope...` |

### Changes for `PostgreSqlLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PostgreSqlLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"PostgreSQL linked service properties.","properties":{"connectionStri...` |

### Changes for `PostgreSqlSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PostgreSqlSource__added` | added | `{"type":"object","description":"A copy activity source for PostgreSQL databases.","properties":{"que...` |

### Changes for `PostgreSqlTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PostgreSqlTableDataset__added` | added | `{"type":"object","description":"The PostgreSQL table dataset.","properties":{"typeProperties":{"$ref...` |

### Changes for `PostgreSqlTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PostgreSqlTableDatasetTypeProperties__added` | added | `{"type":"object","description":"PostgreSQL table dataset properties.","properties":{"tableName":{"de...` |

### Changes for `PostgreSqlV2LinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PostgreSqlV2LinkedService__added` | added | `{"type":"object","description":"Linked service for PostgreSQLV2 data source.","properties":{"typePro...` |

### Changes for `PostgreSqlV2LinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PostgreSqlV2LinkedServiceTypeProperties__added` | added | `{"type":"object","description":"PostgreSqlV2 linked service properties.","properties":{"server":{"de...` |

### Changes for `PostgreSqlV2Source`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PostgreSqlV2Source__added` | added | `{"type":"object","description":"A copy activity source for PostgreSQL databases.","properties":{"que...` |

### Changes for `PostgreSqlV2TableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PostgreSqlV2TableDataset__added` | added | `{"type":"object","description":"The PostgreSQLV2 table dataset.","properties":{"typeProperties":{"$r...` |

### Changes for `PostgreSqlV2TableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PostgreSqlV2TableDatasetTypeProperties__added` | added | `{"type":"object","description":"PostgreSQLV2 table dataset properties.","properties":{"table":{"desc...` |

### Changes for `PowerQuerySink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PowerQuerySink__added` | added | `{"type":"object","description":"Power query sink.","properties":{"script":{"type":"string","descript...` |

### Changes for `PowerQuerySinkMapping`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PowerQuerySinkMapping__added` | added | `{"type":"object","description":"Map Power Query mashup query to sink dataset(s).","properties":{"que...` |

### Changes for `PowerQuerySource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PowerQuerySource__added` | added | `{"type":"object","description":"Power query source.","properties":{"script":{"type":"string","descri...` |

### Changes for `PowerQueryTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PowerQueryTypeProperties__added` | added | `{"type":"object","description":"Power Query data flow type properties.","properties":{"sources":{"ty...` |

### Changes for `PrestoDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrestoDatasetTypeProperties__added` | added | `{"type":"object","description":"Presto Dataset Properties","properties":{"tableName":{"description":...` |

### Changes for `PrestoLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrestoLinkedService__added` | added | `{"type":"object","description":"Presto server linked service. This linked service has supported vers...` |

### Changes for `PrestoLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrestoLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Presto server linked service properties.","properties":{"host":{"des...` |

### Changes for `PrestoObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrestoObjectDataset__added` | added | `{"type":"object","description":"Presto server dataset.","properties":{"typeProperties":{"$ref":"#/de...` |

### Changes for `PrestoSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrestoSource__added` | added | `{"type":"object","description":"A copy activity Presto server source.","properties":{"query":{"descr...` |

### Changes for `QuickBooksLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.QuickBooksLinkedService__added` | added | `{"type":"object","description":"QuickBooks server linked service. This linked service has supported ...` |

### Changes for `QuickBooksLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.QuickBooksLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"QuickBooks server linked service properties.","properties":{"connect...` |

### Changes for `QuickBooksObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.QuickBooksObjectDataset__added` | added | `{"type":"object","description":"QuickBooks server dataset.","properties":{"typeProperties":{"$ref":"...` |

### Changes for `QuickBooksSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.QuickBooksSource__added` | added | `{"type":"object","description":"A copy activity QuickBooks server source.","properties":{"query":{"d...` |

### Changes for `QuickbaseLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.QuickbaseLinkedService__added` | added | `{"type":"object","description":"Linked service for Quickbase.","properties":{"typeProperties":{"$ref...` |

### Changes for `QuickbaseLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.QuickbaseLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Quickbase linked service type properties.","properties":{"url":{"des...` |

### Changes for `RecurrenceSchedule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RecurrenceSchedule__added` | added | `{"type":"object","description":"The recurrence schedule.","properties":{"minutes":{"type":"array","d...` |

### Changes for `RecurrenceScheduleOccurrence`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RecurrenceScheduleOccurrence__added` | added | `{"type":"object","description":"The recurrence schedule occurrence.","properties":{"day":{"type":"st...` |

### Changes for `RedirectIncompatibleRowSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RedirectIncompatibleRowSettings__added` | added | `{"type":"object","description":"Redirect incompatible row settings","properties":{"linkedServiceName...` |

### Changes for `RedshiftUnloadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RedshiftUnloadSettings__added` | added | `{"type":"object","description":"The Amazon S3 settings needed for the interim Amazon S3 when copying...` |

### Changes for `RelationalSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RelationalSource__added` | added | `{"type":"object","description":"A copy activity source for various relational databases.","propertie...` |

### Changes for `RelationalTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RelationalTableDataset__added` | added | `{"type":"object","description":"The relational table dataset.","properties":{"typeProperties":{"$ref...` |

### Changes for `RelationalTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RelationalTableDatasetTypeProperties__added` | added | `{"type":"object","description":"Relational table dataset properties.","properties":{"tableName":{"de...` |

### Changes for `RerunTumblingWindowTrigger`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RerunTumblingWindowTrigger__added` | added | `{"type":"object","description":"Trigger that schedules pipeline reruns for all fixed time interval w...` |

### Changes for `RerunTumblingWindowTriggerTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RerunTumblingWindowTriggerTypeProperties__added` | added | `{"type":"object","description":"Rerun Trigger properties.","properties":{"parentTrigger":{"descripti...` |

### Changes for `ResponsysLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResponsysLinkedService__added` | added | `{"type":"object","description":"Responsys linked service.","properties":{"typeProperties":{"$ref":"#...` |

### Changes for `ResponsysLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResponsysLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Responsys linked service properties.","properties":{"endpoint":{"des...` |

### Changes for `ResponsysObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResponsysObjectDataset__added` | added | `{"type":"object","description":"Responsys dataset.","properties":{"typeProperties":{"$ref":"#/defini...` |

### Changes for `ResponsysSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResponsysSource__added` | added | `{"type":"object","description":"A copy activity Responsys source.","properties":{"query":{"descripti...` |

### Changes for `RestResourceDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RestResourceDataset__added` | added | `{"type":"object","description":"A Rest service dataset.","properties":{"typeProperties":{"$ref":"#/d...` |

### Changes for `RestResourceDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RestResourceDatasetTypeProperties__added` | added | `{"type":"object","description":"Properties specific to this dataset type.","properties":{"relativeUr...` |

### Changes for `RestServiceLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RestServiceLinkedService__added` | added | `{"type":"object","description":"Rest Service linked service.","properties":{"typeProperties":{"$ref"...` |

### Changes for `RestServiceLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RestServiceLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Rest Service linked service properties.","properties":{"url":{"descr...` |

### Changes for `RestSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RestSink__added` | added | `{"type":"object","description":"A copy activity Rest service Sink.","properties":{"requestMethod":{"...` |

### Changes for `RestSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RestSource__added` | added | `{"type":"object","description":"A copy activity Rest service source.","properties":{"requestMethod":...` |

### Changes for `RetryPolicy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RetryPolicy__added` | added | `{"type":"object","description":"Execution policy for an activity.","properties":{"count":{"descripti...` |

### Changes for `SalesforceLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceLinkedService__added` | added | `{"type":"object","description":"Linked service for Salesforce.","properties":{"typeProperties":{"$re...` |

### Changes for `SalesforceLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Salesforce linked service properties.","properties":{"environmentUrl...` |

### Changes for `SalesforceMarketingCloudLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceMarketingCloudLinkedService__added` | added | `{"type":"object","description":"Salesforce Marketing Cloud linked service.","properties":{"typePrope...` |

### Changes for `SalesforceMarketingCloudLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceMarketingCloudLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Salesforce Marketing Cloud linked service properties.","properties":...` |

### Changes for `SalesforceMarketingCloudObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceMarketingCloudObjectDataset__added` | added | `{"type":"object","description":"Salesforce Marketing Cloud dataset.","properties":{"typeProperties":...` |

### Changes for `SalesforceMarketingCloudSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceMarketingCloudSource__added` | added | `{"type":"object","description":"A copy activity Salesforce Marketing Cloud source.","properties":{"q...` |

### Changes for `SalesforceObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceObjectDataset__added` | added | `{"type":"object","description":"The Salesforce object dataset.","properties":{"typeProperties":{"$re...` |

### Changes for `SalesforceObjectDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceObjectDatasetTypeProperties__added` | added | `{"type":"object","description":"Salesforce object dataset properties.","properties":{"objectApiName"...` |

### Changes for `SalesforceServiceCloudLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceServiceCloudLinkedService__added` | added | `{"type":"object","description":"Linked service for Salesforce Service Cloud.","properties":{"typePro...` |

### Changes for `SalesforceServiceCloudLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceServiceCloudLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Salesforce Service Cloud linked service properties.","properties":{"...` |

### Changes for `SalesforceServiceCloudObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceServiceCloudObjectDataset__added` | added | `{"type":"object","description":"The Salesforce Service Cloud object dataset.","properties":{"typePro...` |

### Changes for `SalesforceServiceCloudObjectDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceServiceCloudObjectDatasetTypeProperties__added` | added | `{"type":"object","description":"Salesforce Service Cloud object dataset properties.","properties":{"...` |

### Changes for `SalesforceServiceCloudSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceServiceCloudSink__added` | added | `{"type":"object","description":"A copy activity Salesforce Service Cloud sink.","properties":{"write...` |

### Changes for `SalesforceServiceCloudSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceServiceCloudSource__added` | added | `{"type":"object","description":"A copy activity Salesforce Service Cloud source.","properties":{"que...` |

### Changes for `SalesforceServiceCloudV2LinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceServiceCloudV2LinkedService__added` | added | `{"type":"object","description":"Linked service for Salesforce Service Cloud V2.","properties":{"type...` |

### Changes for `SalesforceServiceCloudV2LinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceServiceCloudV2LinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Salesforce Service Cloud V2 linked service properties.","properties"...` |

### Changes for `SalesforceServiceCloudV2ObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceServiceCloudV2ObjectDataset__added` | added | `{"type":"object","description":"The Salesforce Service Cloud V2 object dataset.","properties":{"type...` |

### Changes for `SalesforceServiceCloudV2ObjectDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceServiceCloudV2ObjectDatasetTypeProperties__added` | added | `{"type":"object","description":"Salesforce Service Cloud V2 object dataset properties.","properties"...` |

### Changes for `SalesforceServiceCloudV2Sink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceServiceCloudV2Sink__added` | added | `{"type":"object","description":"A copy activity Salesforce Service Cloud V2 sink.","properties":{"wr...` |

### Changes for `SalesforceServiceCloudV2Source`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceServiceCloudV2Source__added` | added | `{"type":"object","description":"A copy activity Salesforce Service Cloud V2 source.","properties":{"...` |

### Changes for `SalesforceSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceSink__added` | added | `{"type":"object","description":"A copy activity Salesforce sink.","properties":{"writeBehavior":{"ty...` |

### Changes for `SalesforceSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceSource__added` | added | `{"type":"object","description":"A copy activity Salesforce source.","properties":{"query":{"descript...` |

### Changes for `SalesforceV2LinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceV2LinkedService__added` | added | `{"type":"object","description":"Linked service for Salesforce V2.","properties":{"typeProperties":{"...` |

### Changes for `SalesforceV2LinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceV2LinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Salesforce V2 linked service properties.","properties":{"environment...` |

### Changes for `SalesforceV2ObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceV2ObjectDataset__added` | added | `{"type":"object","description":"The Salesforce V2 object dataset.","properties":{"typeProperties":{"...` |

### Changes for `SalesforceV2ObjectDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceV2ObjectDatasetTypeProperties__added` | added | `{"type":"object","description":"Salesforce V2 object dataset properties.","properties":{"objectApiNa...` |

### Changes for `SalesforceV2Sink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceV2Sink__added` | added | `{"type":"object","description":"A copy activity Salesforce V2 sink.","properties":{"writeBehavior":{...` |

### Changes for `SalesforceV2Source`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SalesforceV2Source__added` | added | `{"type":"object","description":"A copy activity Salesforce V2 source.","properties":{"SOQLQuery":{"d...` |

### Changes for `SapBWLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapBWLinkedService__added` | added | `{"type":"object","description":"SAP Business Warehouse Linked Service.","properties":{"typePropertie...` |

### Changes for `SapBWLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapBWLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Properties specific to this linked service type.","properties":{"ser...` |

### Changes for `SapBwCubeDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapBwCubeDataset__added` | added | `{"type":"object","description":"The SAP BW cube dataset.","allOf":[{"$ref":"#/definitions/Dataset"}]...` |

### Changes for `SapBwSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapBwSource__added` | added | `{"type":"object","description":"A copy activity source for SapBW server via MDX.","properties":{"que...` |

### Changes for `SapCloudForCustomerLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapCloudForCustomerLinkedService__added` | added | `{"type":"object","description":"Linked service for SAP Cloud for Customer.","properties":{"typePrope...` |

### Changes for `SapCloudForCustomerLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapCloudForCustomerLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"SAP Cloud for Customer linked service properties.","properties":{"ur...` |

### Changes for `SapCloudForCustomerResourceDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapCloudForCustomerResourceDataset__added` | added | `{"type":"object","description":"The path of the SAP Cloud for Customer OData entity.","properties":{...` |

### Changes for `SapCloudForCustomerResourceDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapCloudForCustomerResourceDatasetTypeProperties__added` | added | `{"type":"object","description":"Sap Cloud For Customer OData resource dataset properties.","properti...` |

### Changes for `SapCloudForCustomerSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapCloudForCustomerSink__added` | added | `{"type":"object","description":"A copy activity SAP Cloud for Customer sink.","properties":{"writeBe...` |

### Changes for `SapCloudForCustomerSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapCloudForCustomerSource__added` | added | `{"type":"object","description":"A copy activity source for SAP Cloud for Customer source.","properti...` |

### Changes for `SapEccLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapEccLinkedService__added` | added | `{"type":"object","description":"Linked service for SAP ERP Central Component(SAP ECC).","properties"...` |

### Changes for `SapEccLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapEccLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"SAP ECC linked service properties.","properties":{"url":{"descriptio...` |

### Changes for `SapEccResourceDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapEccResourceDataset__added` | added | `{"type":"object","description":"The path of the SAP ECC OData entity.","properties":{"typeProperties...` |

### Changes for `SapEccResourceDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapEccResourceDatasetTypeProperties__added` | added | `{"type":"object","description":"Sap ECC OData resource dataset properties.","properties":{"path":{"d...` |

### Changes for `SapEccSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapEccSource__added` | added | `{"type":"object","description":"A copy activity source for SAP ECC source.","properties":{"query":{"...` |

### Changes for `SapHanaLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapHanaLinkedService__added` | added | `{"type":"object","description":"SAP HANA Linked Service.","properties":{"typeProperties":{"$ref":"#/...` |

### Changes for `SapHanaLinkedServiceProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapHanaLinkedServiceProperties__added` | added | `{"type":"object","description":"Properties specific to this linked service type.","properties":{"con...` |

### Changes for `SapHanaPartitionSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapHanaPartitionSettings__added` | added | `{"type":"object","description":"The settings that will be leveraged for SAP HANA source partitioning...` |

### Changes for `SapHanaSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapHanaSource__added` | added | `{"type":"object","description":"A copy activity source for SAP HANA source.","properties":{"query":{...` |

### Changes for `SapHanaTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapHanaTableDataset__added` | added | `{"type":"object","description":"SAP HANA Table properties.","properties":{"typeProperties":{"$ref":"...` |

### Changes for `SapHanaTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapHanaTableDatasetTypeProperties__added` | added | `{"type":"object","description":"SAP HANA Table properties.","properties":{"schema":{"description":"T...` |

### Changes for `SapOdpLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapOdpLinkedService__added` | added | `{"type":"object","description":"SAP ODP Linked Service.","properties":{"typeProperties":{"$ref":"#/d...` |

### Changes for `SapOdpLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapOdpLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Properties specific to this linked service type.","properties":{"ser...` |

### Changes for `SapOdpResourceDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapOdpResourceDataset__added` | added | `{"type":"object","description":"SAP ODP Resource properties.","properties":{"typeProperties":{"$ref"...` |

### Changes for `SapOdpResourceDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapOdpResourceDatasetTypeProperties__added` | added | `{"type":"object","description":"SAP ODP Resource properties.","properties":{"context":{"description"...` |

### Changes for `SapOdpSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapOdpSource__added` | added | `{"type":"object","description":"A copy activity source for SAP ODP source.","properties":{"extractio...` |

### Changes for `SapOpenHubLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapOpenHubLinkedService__added` | added | `{"type":"object","description":"SAP Business Warehouse Open Hub Destination Linked Service.","proper...` |

### Changes for `SapOpenHubLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapOpenHubLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Properties specific to SAP Business Warehouse Open Hub Destination l...` |

### Changes for `SapOpenHubSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapOpenHubSource__added` | added | `{"type":"object","description":"A copy activity source for SAP Business Warehouse Open Hub Destinati...` |

### Changes for `SapOpenHubTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapOpenHubTableDataset__added` | added | `{"type":"object","description":"Sap Business Warehouse Open Hub Destination Table properties.","prop...` |

### Changes for `SapOpenHubTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapOpenHubTableDatasetTypeProperties__added` | added | `{"type":"object","description":"Sap Business Warehouse Open Hub Destination Table properties.","prop...` |

### Changes for `SapTableLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapTableLinkedService__added` | added | `{"type":"object","description":"SAP Table Linked Service.","properties":{"typeProperties":{"$ref":"#...` |

### Changes for `SapTableLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapTableLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Properties specific to this linked service type.","properties":{"ser...` |

### Changes for `SapTablePartitionSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapTablePartitionSettings__added` | added | `{"type":"object","description":"The settings that will be leveraged for SAP table source partitionin...` |

### Changes for `SapTableResourceDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapTableResourceDataset__added` | added | `{"type":"object","description":"SAP Table Resource properties.","properties":{"typeProperties":{"$re...` |

### Changes for `SapTableResourceDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapTableResourceDatasetTypeProperties__added` | added | `{"type":"object","description":"SAP Table Resource properties.","properties":{"tableName":{"descript...` |

### Changes for `SapTableSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SapTableSource__added` | added | `{"type":"object","description":"A copy activity source for SAP Table source.","properties":{"rowCoun...` |

### Changes for `ScheduleTrigger`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScheduleTrigger__added` | added | `{"type":"object","description":"Trigger that creates pipeline runs periodically, on schedule.","prop...` |

### Changes for `ScheduleTriggerRecurrence`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScheduleTriggerRecurrence__added` | added | `{"type":"object","description":"The workflow trigger recurrence.","properties":{"frequency":{"type":...` |

### Changes for `ScheduleTriggerTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScheduleTriggerTypeProperties__added` | added | `{"type":"object","description":"Schedule Trigger properties.","properties":{"recurrence":{"$ref":"#/...` |

### Changes for `ScriptAction`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScriptAction__added` | added | `{"type":"object","description":"Custom script action to run on HDI ondemand cluster once it's up.","...` |

### Changes for `ScriptActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScriptActivity__added` | added | `{"type":"object","description":"Script activity type.","properties":{"typeProperties":{"$ref":"#/def...` |

### Changes for `ScriptActivityParameter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScriptActivityParameter__added` | added | `{"type":"object","description":"Parameters of a script block.","properties":{"name":{"description":"...` |

### Changes for `ScriptActivityScriptBlock`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScriptActivityScriptBlock__added` | added | `{"type":"object","description":"Script block of scripts.","properties":{"text":{"description":"The q...` |

### Changes for `ScriptActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScriptActivityTypeProperties__added` | added | `{"type":"object","description":"Script activity properties.","properties":{"scriptBlockExecutionTime...` |

### Changes for `ScriptActivityTypePropertiesLogSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScriptActivityTypePropertiesLogSettings__added` | added | `{"type":"object","description":"Log settings of script activity.","properties":{"logDestination":{"t...` |

### Changes for `SecureInputOutputPolicy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecureInputOutputPolicy__added` | added | `{"type":"object","description":"Execution policy for an activity that supports secure input and outp...` |

### Changes for `SelfDependencyTumblingWindowTriggerReference`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SelfDependencyTumblingWindowTriggerReference__added` | added | `{"type":"object","description":"Self referenced tumbling window trigger dependency.","properties":{"...` |

### Changes for `SelfHostedIntegrationRuntime`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SelfHostedIntegrationRuntime__added` | added | `{"type":"object","description":"Self-hosted integration runtime.","properties":{"typeProperties":{"$...` |

### Changes for `SelfHostedIntegrationRuntimeNode`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SelfHostedIntegrationRuntimeNode__added` | added | `{"type":"object","description":"Properties of Self-hosted integration runtime node.","properties":{"...` |

### Changes for `SelfHostedIntegrationRuntimeStatus`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SelfHostedIntegrationRuntimeStatus__added` | added | `{"type":"object","description":"Self-hosted integration runtime status.","properties":{"typeProperti...` |

### Changes for `SelfHostedIntegrationRuntimeStatusTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SelfHostedIntegrationRuntimeStatusTypeProperties__added` | added | `{"type":"object","description":"Self-hosted integration runtime status type properties.","properties...` |

### Changes for `SelfHostedIntegrationRuntimeTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SelfHostedIntegrationRuntimeTypeProperties__added` | added | `{"type":"object","description":"The self-hosted integration runtime properties.","properties":{"link...` |

### Changes for `ServiceNowLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceNowLinkedService__added` | added | `{"type":"object","description":"ServiceNow server linked service.","properties":{"typeProperties":{"...` |

### Changes for `ServiceNowLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceNowLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"ServiceNow server linked service properties.","properties":{"endpoin...` |

### Changes for `ServiceNowObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceNowObjectDataset__added` | added | `{"type":"object","description":"ServiceNow server dataset.","properties":{"typeProperties":{"$ref":"...` |

### Changes for `ServiceNowSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceNowSource__added` | added | `{"type":"object","description":"A copy activity ServiceNow server source.","properties":{"query":{"d...` |

### Changes for `ServiceNowV2DatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceNowV2DatasetTypeProperties__added` | added | `{"type":"object","description":"Properties specific to this dataset type.","properties":{"tableName"...` |

### Changes for `ServiceNowV2LinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceNowV2LinkedService__added` | added | `{"type":"object","description":"ServiceNowV2 server linked service.","properties":{"typeProperties":...` |

### Changes for `ServiceNowV2LinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceNowV2LinkedServiceTypeProperties__added` | added | `{"type":"object","description":"ServiceNowV2 server linked service properties.","properties":{"endpo...` |

### Changes for `ServiceNowV2ObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceNowV2ObjectDataset__added` | added | `{"type":"object","description":"ServiceNowV2 server dataset.","properties":{"typeProperties":{"$ref"...` |

### Changes for `ServiceNowV2Source`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceNowV2Source__added` | added | `{"type":"object","description":"A copy activity ServiceNowV2 server source.","properties":{"expressi...` |

### Changes for `ServicePrincipalCredential`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServicePrincipalCredential__added` | added | `{"type":"object","description":"Service principal credential.","properties":{"typeProperties":{"$ref...` |

### Changes for `ServicePrincipalCredentialTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServicePrincipalCredentialTypeProperties__added` | added | `{"type":"object","description":"Service Principal credential type properties.","properties":{"servic...` |

### Changes for `SetVariableActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SetVariableActivity__added` | added | `{"type":"object","description":"Set value for a Variable.","properties":{"typeProperties":{"$ref":"#...` |

### Changes for `SetVariableActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SetVariableActivityTypeProperties__added` | added | `{"type":"object","description":"SetVariable activity properties.","properties":{"variableName":{"typ...` |

### Changes for `SftpLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SftpLocation__added` | added | `{"type":"object","description":"The location of SFTP dataset.","allOf":[{"$ref":"#/definitions/Datas...` |

### Changes for `SftpReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SftpReadSettings__added` | added | `{"type":"object","description":"Sftp read settings.","properties":{"recursive":{"description":"If tr...` |

### Changes for `SftpServerLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SftpServerLinkedService__added` | added | `{"type":"object","description":"A linked service for an SSH File Transfer Protocol (SFTP) server.","...` |

### Changes for `SftpServerLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SftpServerLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Properties specific to this linked service type.","properties":{"hos...` |

### Changes for `SftpWriteSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SftpWriteSettings__added` | added | `{"type":"object","description":"Sftp write settings.","properties":{"operationTimeout":{"description...` |

### Changes for `SharePointOnlineListDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SharePointOnlineListDatasetTypeProperties__added` | added | `{"type":"object","description":"Sharepoint online list dataset properties.","properties":{"listName"...` |

### Changes for `SharePointOnlineListLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SharePointOnlineListLinkedService__added` | added | `{"type":"object","description":"SharePoint Online List linked service.","properties":{"typePropertie...` |

### Changes for `SharePointOnlineListLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SharePointOnlineListLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"SharePoint Online List linked service properties.","properties":{"si...` |

### Changes for `SharePointOnlineListResourceDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SharePointOnlineListResourceDataset__added` | added | `{"type":"object","description":"The sharepoint online list resource dataset.","properties":{"typePro...` |

### Changes for `SharePointOnlineListSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SharePointOnlineListSource__added` | added | `{"type":"object","description":"A copy activity source for sharePoint online list source.","properti...` |

### Changes for `ShopifyLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ShopifyLinkedService__added` | added | `{"type":"object","description":"Shopify Service linked service.","properties":{"typeProperties":{"$r...` |

### Changes for `ShopifyLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ShopifyLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Shopify Service linked service properties.","properties":{"host":{"d...` |

### Changes for `ShopifyObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ShopifyObjectDataset__added` | added | `{"type":"object","description":"Shopify Service dataset.","properties":{"typeProperties":{"$ref":"#/...` |

### Changes for `ShopifySource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ShopifySource__added` | added | `{"type":"object","description":"A copy activity Shopify Service source.","properties":{"query":{"des...` |

### Changes for `SkipErrorFile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SkipErrorFile__added` | added | `{"type":"object","description":"Skip error file.","properties":{"fileMissing":{"description":"Skip i...` |

### Changes for `SmartsheetLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SmartsheetLinkedService__added` | added | `{"type":"object","description":"Linked service for Smartsheet.","properties":{"typeProperties":{"$re...` |

### Changes for `SmartsheetLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SmartsheetLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Smartsheet linked service type properties.","properties":{"apiToken"...` |

### Changes for `SnowflakeDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SnowflakeDataset__added` | added | `{"type":"object","description":"The snowflake dataset.","properties":{"typeProperties":{"$ref":"#/de...` |

### Changes for `SnowflakeDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SnowflakeDatasetTypeProperties__added` | added | `{"type":"object","description":"Snowflake dataset properties.","properties":{"schema":{"description"...` |

### Changes for `SnowflakeExportCopyCommand`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SnowflakeExportCopyCommand__added` | added | `{"type":"object","description":"Snowflake export command settings.","properties":{"additionalCopyOpt...` |

### Changes for `SnowflakeImportCopyCommand`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SnowflakeImportCopyCommand__added` | added | `{"type":"object","description":"Snowflake import command settings.","properties":{"additionalCopyOpt...` |

### Changes for `SnowflakeLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SnowflakeLinkedService__added` | added | `{"type":"object","description":"Snowflake linked service.","properties":{"typeProperties":{"$ref":"#...` |

### Changes for `SnowflakeLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SnowflakeLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Snowflake linked service properties.","properties":{"connectionStrin...` |

### Changes for `SnowflakeLinkedV2ServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SnowflakeLinkedV2ServiceTypeProperties__added` | added | `{"type":"object","description":"Snowflake linked service properties.","properties":{"accountIdentifi...` |

### Changes for `SnowflakeSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SnowflakeSink__added` | added | `{"type":"object","description":"A copy activity snowflake sink.","properties":{"preCopyScript":{"des...` |

### Changes for `SnowflakeSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SnowflakeSource__added` | added | `{"type":"object","description":"A copy activity snowflake source.","properties":{"query":{"descripti...` |

### Changes for `SnowflakeV2Dataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SnowflakeV2Dataset__added` | added | `{"type":"object","description":"The snowflake dataset.","properties":{"typeProperties":{"$ref":"#/de...` |

### Changes for `SnowflakeV2LinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SnowflakeV2LinkedService__added` | added | `{"type":"object","description":"Snowflake linked service.","properties":{"typeProperties":{"$ref":"#...` |

### Changes for `SnowflakeV2Sink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SnowflakeV2Sink__added` | added | `{"type":"object","description":"A copy activity snowflake sink.","properties":{"preCopyScript":{"des...` |

### Changes for `SnowflakeV2Source`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SnowflakeV2Source__added` | added | `{"type":"object","description":"A copy activity snowflake source.","properties":{"query":{"descripti...` |

### Changes for `SparkConfigurationParametrizationReference`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SparkConfigurationParametrizationReference__added` | added | `{"type":"object","description":"Spark configuration reference.","properties":{"type":{"type":"string...` |

### Changes for `SparkDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SparkDatasetTypeProperties__added` | added | `{"type":"object","description":"Spark Properties","properties":{"tableName":{"description":"This pro...` |

### Changes for `SparkLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SparkLinkedService__added` | added | `{"type":"object","description":"Spark Server linked service.","properties":{"typeProperties":{"$ref"...` |

### Changes for `SparkLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SparkLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Spark Server linked service properties.","properties":{"host":{"desc...` |

### Changes for `SparkObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SparkObjectDataset__added` | added | `{"type":"object","description":"Spark Server dataset.","properties":{"typeProperties":{"$ref":"#/def...` |

### Changes for `SparkSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SparkSource__added` | added | `{"type":"object","description":"A copy activity Spark Server source.","properties":{"query":{"descri...` |

### Changes for `SqlAlwaysEncryptedProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlAlwaysEncryptedProperties__added` | added | `{"type":"object","description":"Sql always encrypted properties.","properties":{"alwaysEncryptedAkvA...` |

### Changes for `SqlDWSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlDWSink__added` | added | `{"type":"object","description":"A copy activity SQL Data Warehouse sink.","properties":{"preCopyScri...` |

### Changes for `SqlDWSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlDWSource__added` | added | `{"type":"object","description":"A copy activity SQL Data Warehouse source.","properties":{"sqlReader...` |

### Changes for `SqlDWUpsertSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlDWUpsertSettings__added` | added | `{"type":"object","description":"Sql DW upsert option settings","properties":{"interimSchemaName":{"d...` |

### Changes for `SqlMISink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlMISink__added` | added | `{"type":"object","description":"A copy activity Azure SQL Managed Instance sink.","properties":{"sql...` |

### Changes for `SqlMISource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlMISource__added` | added | `{"type":"object","description":"A copy activity Azure SQL Managed Instance source.","properties":{"s...` |

### Changes for `SqlPartitionSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlPartitionSettings__added` | added | `{"type":"object","description":"The settings that will be leveraged for Sql source partitioning.","p...` |

### Changes for `SqlServerBaseLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlServerBaseLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Sql Server family connector common linked service properties.","prop...` |

### Changes for `SqlServerLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlServerLinkedService__added` | added | `{"type":"object","description":"SQL Server linked service.","properties":{"typeProperties":{"$ref":"...` |

### Changes for `SqlServerLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlServerLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"SQL Server linked service properties.","properties":{"connectionStri...` |

### Changes for `SqlServerSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlServerSink__added` | added | `{"type":"object","description":"A copy activity SQL server sink.","properties":{"sqlWriterStoredProc...` |

### Changes for `SqlServerSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlServerSource__added` | added | `{"type":"object","description":"A copy activity SQL server source.","properties":{"sqlReaderQuery":{...` |

### Changes for `SqlServerStoredProcedureActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlServerStoredProcedureActivity__added` | added | `{"type":"object","description":"SQL stored procedure activity type.","properties":{"typeProperties":...` |

### Changes for `SqlServerStoredProcedureActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlServerStoredProcedureActivityTypeProperties__added` | added | `{"type":"object","description":"SQL stored procedure activity properties.","properties":{"storedProc...` |

### Changes for `SqlServerTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlServerTableDataset__added` | added | `{"type":"object","description":"The on-premises SQL Server dataset.","properties":{"typeProperties":...` |

### Changes for `SqlServerTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlServerTableDatasetTypeProperties__added` | added | `{"type":"object","description":"On-premises SQL Server dataset properties.","properties":{"tableName...` |

### Changes for `SqlSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlSink__added` | added | `{"type":"object","description":"A copy activity SQL sink.","properties":{"sqlWriterStoredProcedureNa...` |

### Changes for `SqlSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlSource__added` | added | `{"type":"object","description":"A copy activity SQL source.","properties":{"sqlReaderQuery":{"descri...` |

### Changes for `SqlUpsertSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SqlUpsertSettings__added` | added | `{"type":"object","description":"Sql upsert option settings","properties":{"useTempDB":{"description"...` |

### Changes for `SquareLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SquareLinkedService__added` | added | `{"type":"object","description":"Square Service linked service.","properties":{"typeProperties":{"$re...` |

### Changes for `SquareLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SquareLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Square Service linked service properties.","properties":{"connection...` |

### Changes for `SquareObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SquareObjectDataset__added` | added | `{"type":"object","description":"Square Service dataset.","properties":{"typeProperties":{"$ref":"#/d...` |

### Changes for `SquareSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SquareSource__added` | added | `{"type":"object","description":"A copy activity Square Service source.","properties":{"query":{"desc...` |

### Changes for `SsisAccessCredential`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SsisAccessCredential__added` | added | `{"type":"object","description":"SSIS access credential.","properties":{"domain":{"description":"Doma...` |

### Changes for `SsisChildPackage`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SsisChildPackage__added` | added | `{"type":"object","description":"SSIS embedded child package.","properties":{"packagePath":{"descript...` |

### Changes for `SsisEnvironment`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SsisEnvironment__added` | added | `{"type":"object","description":"Ssis environment.","properties":{"folderId":{"type":"integer","forma...` |

### Changes for `SsisEnvironmentReference`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SsisEnvironmentReference__added` | added | `{"type":"object","description":"Ssis environment reference.","properties":{"id":{"type":"integer","f...` |

### Changes for `SsisExecutionCredential`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SsisExecutionCredential__added` | added | `{"type":"object","description":"SSIS package execution credential.","properties":{"domain":{"descrip...` |

### Changes for `SsisExecutionParameter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SsisExecutionParameter__added` | added | `{"type":"object","description":"SSIS execution parameter.","properties":{"value":{"description":"SSI...` |

### Changes for `SsisFolder`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SsisFolder__added` | added | `{"type":"object","description":"Ssis folder.","allOf":[{"$ref":"#/definitions/SsisObjectMetadata"}],...` |

### Changes for `SsisLogLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SsisLogLocation__added` | added | `{"type":"object","description":"SSIS package execution log location","properties":{"logPath":{"descr...` |

### Changes for `SsisLogLocationTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SsisLogLocationTypeProperties__added` | added | `{"type":"object","description":"SSIS package execution log location properties.","properties":{"acce...` |

### Changes for `SsisObjectMetadata`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SsisObjectMetadata__added` | added | `{"type":"object","description":"SSIS object metadata.","properties":{"type":{"type":"string","descri...` |

### Changes for `SsisObjectMetadataListResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SsisObjectMetadataListResponse__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `SsisPackage`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SsisPackage__added` | added | `{"type":"object","description":"Ssis Package.","properties":{"folderId":{"type":"integer","format":"...` |

### Changes for `SsisPackageLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SsisPackageLocation__added` | added | `{"type":"object","description":"SSIS package location.","properties":{"packagePath":{"description":"...` |

### Changes for `SsisPackageLocationTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SsisPackageLocationTypeProperties__added` | added | `{"type":"object","description":"SSIS package location properties.","properties":{"packagePassword":{...` |

### Changes for `SsisParameter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SsisParameter__added` | added | `{"type":"object","description":"Ssis parameter.","properties":{"id":{"type":"integer","format":"int6...` |

### Changes for `SsisProject`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SsisProject__added` | added | `{"type":"object","description":"Ssis project.","properties":{"folderId":{"type":"integer","format":"...` |

### Changes for `SsisPropertyOverride`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SsisPropertyOverride__added` | added | `{"type":"object","description":"SSIS property override.","properties":{"value":{"description":"SSIS ...` |

### Changes for `SsisVariable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SsisVariable__added` | added | `{"type":"object","description":"Ssis variable.","properties":{"id":{"type":"integer","format":"int64...` |

### Changes for `StagingSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StagingSettings__added` | added | `{"type":"object","description":"Staging settings.","properties":{"linkedServiceName":{"$ref":"#/defi...` |

### Changes for `StoreReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StoreReadSettings__added` | added | `{"type":"object","description":"Connector read setting.","properties":{"type":{"type":"string","desc...` |

### Changes for `StoreWriteSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StoreWriteSettings__added` | added | `{"type":"object","description":"Connector write settings.","properties":{"type":{"type":"string","de...` |

### Changes for `SwitchActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SwitchActivity__added` | added | `{"type":"object","description":"This activity evaluates an expression and executes activities under ...` |

### Changes for `SwitchActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SwitchActivityTypeProperties__added` | added | `{"type":"object","description":"Switch activity properties.","properties":{"on":{"$ref":"#/definitio...` |

### Changes for `SwitchCase`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SwitchCase__added` | added | `{"type":"object","description":"Switch cases with have a value and corresponding activities.","prope...` |

### Changes for `SybaseLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SybaseLinkedService__added` | added | `{"type":"object","description":"Linked service for Sybase data source.","properties":{"typePropertie...` |

### Changes for `SybaseLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SybaseLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Sybase linked service properties.","properties":{"server":{"descript...` |

### Changes for `SybaseSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SybaseSource__added` | added | `{"type":"object","description":"A copy activity source for Sybase databases.","properties":{"query":...` |

### Changes for `SybaseTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SybaseTableDataset__added` | added | `{"type":"object","description":"The Sybase table dataset.","properties":{"typeProperties":{"$ref":"#...` |

### Changes for `SybaseTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SybaseTableDatasetTypeProperties__added` | added | `{"type":"object","description":"Sybase table dataset properties.","properties":{"tableName":{"descri...` |

### Changes for `SynapseNotebookActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SynapseNotebookActivity__added` | added | `{"type":"object","description":"Execute Synapse notebook activity.","properties":{"typeProperties":{...` |

### Changes for `SynapseNotebookActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SynapseNotebookActivityTypeProperties__added` | added | `{"type":"object","description":"Execute Synapse notebook activity properties.","properties":{"notebo...` |

### Changes for `SynapseNotebookReference`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SynapseNotebookReference__added` | added | `{"type":"object","description":"Synapse notebook reference type.","properties":{"type":{"type":"stri...` |

### Changes for `SynapseSparkJobActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SynapseSparkJobActivityTypeProperties__added` | added | `{"type":"object","description":"Execute spark job activity properties.","properties":{"sparkJob":{"$...` |

### Changes for `SynapseSparkJobDefinitionActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SynapseSparkJobDefinitionActivity__added` | added | `{"type":"object","description":"Execute spark job activity.","properties":{"typeProperties":{"$ref":...` |

### Changes for `SynapseSparkJobReference`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SynapseSparkJobReference__added` | added | `{"type":"object","description":"Synapse spark job reference type.","properties":{"type":{"type":"str...` |

### Changes for `TabularSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TabularSource__added` | added | `{"type":"object","description":"Copy activity sources of tabular type.","properties":{"type":{"type"...` |

### Changes for `TarGZipReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TarGZipReadSettings__added` | added | `{"type":"object","description":"The TarGZip compression read settings.","properties":{"preserveCompr...` |

### Changes for `TarReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TarReadSettings__added` | added | `{"type":"object","description":"The Tar compression read settings.","properties":{"preserveCompressi...` |

### Changes for `TeamDeskLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TeamDeskLinkedService__added` | added | `{"type":"object","description":"Linked service for TeamDesk.","properties":{"typeProperties":{"$ref"...` |

### Changes for `TeamDeskLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TeamDeskLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"TeamDesk linked service type properties.","properties":{"authenticat...` |

### Changes for `TeradataImportCommand`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TeradataImportCommand__added` | added | `{"type":"object","description":"Teradata import command settings.","properties":{"additionalFormatOp...` |

### Changes for `TeradataLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TeradataLinkedService__added` | added | `{"type":"object","description":"Linked service for Teradata data source.","properties":{"typePropert...` |

### Changes for `TeradataLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TeradataLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Teradata linked service properties.","properties":{"connectionString...` |

### Changes for `TeradataPartitionSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TeradataPartitionSettings__added` | added | `{"type":"object","description":"The settings that will be leveraged for teradata source partitioning...` |

### Changes for `TeradataSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TeradataSink__added` | added | `{"type":"object","description":"A copy activity Teradata sink.","properties":{"importSettings":{"$re...` |

### Changes for `TeradataSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TeradataSource__added` | added | `{"type":"object","description":"A copy activity Teradata source.","properties":{"query":{"descriptio...` |

### Changes for `TeradataTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TeradataTableDataset__added` | added | `{"type":"object","description":"The Teradata database dataset.","properties":{"typeProperties":{"$re...` |

### Changes for `TeradataTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TeradataTableDatasetTypeProperties__added` | added | `{"type":"object","description":"Teradata dataset properties.","properties":{"database":{"description...` |

### Changes for `TextFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TextFormat__added` | added | `{"type":"object","description":"The data stored in text format.","properties":{"columnDelimiter":{"d...` |

### Changes for `Transformation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Transformation__added` | added | `{"type":"object","description":"A data flow transformation.","properties":{"name":{"type":"string","...` |

### Changes for `Trigger`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Trigger__added` | added | `{"type":"object","description":"Azure data factory nested object which contains information about cr...` |

### Changes for `TriggerDependencyReference`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TriggerDependencyReference__added` | added | `{"type":"object","description":"Trigger referenced dependency.","properties":{"type":{"type":"string...` |

### Changes for `TriggerReference`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TriggerReference__added` | added | `{"type":"object","description":"Trigger reference type.","properties":{"type":{"type":"string","desc...` |

### Changes for `TumblingWindowTrigger`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TumblingWindowTrigger__added` | added | `{"type":"object","description":"Trigger that schedules pipeline runs for all fixed time interval win...` |

### Changes for `TumblingWindowTriggerDependencyReference`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TumblingWindowTriggerDependencyReference__added` | added | `{"type":"object","description":"Referenced tumbling window trigger dependency.","properties":{"offse...` |

### Changes for `TumblingWindowTriggerTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TumblingWindowTriggerTypeProperties__added` | added | `{"type":"object","description":"Tumbling Window Trigger properties.","properties":{"frequency":{"typ...` |

### Changes for `TwilioLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TwilioLinkedService__added` | added | `{"type":"object","description":"Linked service for Twilio.","properties":{"typeProperties":{"$ref":"...` |

### Changes for `TwilioLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TwilioLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Twilio linked service type properties.","properties":{"userName":{"d...` |

### Changes for `TypeSpec.Http.OkResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['TypeSpec.Http.OkResponse__added']` | added | `{"type":"object","description":"The request has succeeded."}` |

### Changes for `UntilActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UntilActivity__added` | added | `{"type":"object","description":"This activity executes inner activities until the specified boolean ...` |

### Changes for `UntilActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UntilActivityTypeProperties__added` | added | `{"type":"object","description":"Until activity properties.","properties":{"expression":{"$ref":"#/de...` |

### Changes for `UserProperty`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UserProperty__added` | added | `{"type":"object","description":"User property.","properties":{"name":{"type":"string","description":...` |

### Changes for `ValidationActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ValidationActivity__added` | added | `{"type":"object","description":"This activity verifies that an external resource exists.","propertie...` |

### Changes for `ValidationActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ValidationActivityTypeProperties__added` | added | `{"type":"object","description":"Validation activity properties.","properties":{"timeout":{"descripti...` |

### Changes for `VerticaDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VerticaDatasetTypeProperties__added` | added | `{"type":"object","description":"Vertica Properties","properties":{"tableName":{"description":"This p...` |

### Changes for `VerticaLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VerticaLinkedService__added` | added | `{"type":"object","description":"Vertica linked service.","properties":{"typeProperties":{"$ref":"#/d...` |

### Changes for `VerticaLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VerticaLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Vertica linked service properties.","properties":{"connectionString"...` |

### Changes for `VerticaSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VerticaSource__added` | added | `{"type":"object","description":"A copy activity Vertica source.","properties":{"query":{"description...` |

### Changes for `VerticaTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VerticaTableDataset__added` | added | `{"type":"object","description":"Vertica dataset.","properties":{"typeProperties":{"$ref":"#/definiti...` |

### Changes for `WaitActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WaitActivity__added` | added | `{"type":"object","description":"This activity suspends pipeline execution for the specified interval...` |

### Changes for `WaitActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WaitActivityTypeProperties__added` | added | `{"type":"object","description":"Wait activity properties.","properties":{"waitTimeInSeconds":{"descr...` |

### Changes for `WarehouseLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WarehouseLinkedService__added` | added | `{"type":"object","description":"Microsoft Fabric Warehouse linked service.","properties":{"typePrope...` |

### Changes for `WarehouseLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WarehouseLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Microsoft Fabric Warehouse linked service properties.","properties":...` |

### Changes for `WarehouseSink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WarehouseSink__added` | added | `{"type":"object","description":"A copy activity Microsoft Fabric Warehouse sink.","properties":{"pre...` |

### Changes for `WarehouseSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WarehouseSource__added` | added | `{"type":"object","description":"A copy activity Microsoft Fabric Warehouse source.","properties":{"s...` |

### Changes for `WarehouseTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WarehouseTableDataset__added` | added | `{"type":"object","description":"Microsoft Fabric Warehouse dataset.","properties":{"typeProperties":...` |

### Changes for `WarehouseTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WarehouseTableDatasetTypeProperties__added` | added | `{"type":"object","description":"Microsoft Fabric Warehouse dataset properties.","properties":{"schem...` |

### Changes for `WebActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebActivity__added` | added | `{"type":"object","description":"Web activity.","properties":{"typeProperties":{"$ref":"#/definitions...` |

### Changes for `WebActivityAuthentication`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebActivityAuthentication__added` | added | `{"type":"object","description":"Web activity authentication properties.","properties":{"type":{"type...` |

### Changes for `WebActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebActivityTypeProperties__added` | added | `{"type":"object","description":"Web activity type properties.","properties":{"method":{"type":"strin...` |

### Changes for `WebAnonymousAuthentication`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebAnonymousAuthentication__added` | added | `{"type":"object","description":"A WebLinkedService that uses anonymous authentication to communicate...` |

### Changes for `WebBasicAuthentication`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebBasicAuthentication__added` | added | `{"type":"object","description":"A WebLinkedService that uses basic authentication to communicate wit...` |

### Changes for `WebClientCertificateAuthentication`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebClientCertificateAuthentication__added` | added | `{"type":"object","description":"A WebLinkedService that uses client certificate based authentication...` |

### Changes for `WebHookActivity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebHookActivity__added` | added | `{"type":"object","description":"WebHook activity.","properties":{"typeProperties":{"$ref":"#/definit...` |

### Changes for `WebHookActivityTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebHookActivityTypeProperties__added` | added | `{"type":"object","description":"WebHook activity type properties.","properties":{"method":{"type":"s...` |

### Changes for `WebLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebLinkedService__added` | added | `{"type":"object","description":"Web linked service.","properties":{"typeProperties":{"$ref":"#/defin...` |

### Changes for `WebLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Base definition of WebLinkedServiceTypeProperties, this typeProperti...` |

### Changes for `WebSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebSource__added` | added | `{"type":"object","description":"A copy activity source for web page table.","properties":{"additiona...` |

### Changes for `WebTableDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebTableDataset__added` | added | `{"type":"object","description":"The dataset points to a HTML table in the web page.","properties":{"...` |

### Changes for `WebTableDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WebTableDatasetTypeProperties__added` | added | `{"type":"object","description":"Web table dataset properties.","properties":{"index":{"description":...` |

### Changes for `WranglingDataFlow`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WranglingDataFlow__added` | added | `{"type":"object","description":"Power Query data flow.","properties":{"typeProperties":{"$ref":"#/de...` |

### Changes for `XeroLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.XeroLinkedService__added` | added | `{"type":"object","description":"Xero Service linked service.","properties":{"typeProperties":{"$ref"...` |

### Changes for `XeroLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.XeroLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Xero Service linked service properties.","properties":{"connectionPr...` |

### Changes for `XeroObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.XeroObjectDataset__added` | added | `{"type":"object","description":"Xero Service dataset.","properties":{"typeProperties":{"$ref":"#/def...` |

### Changes for `XeroSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.XeroSource__added` | added | `{"type":"object","description":"A copy activity Xero Service source.","properties":{"query":{"descri...` |

### Changes for `XmlDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.XmlDataset__added` | added | `{"type":"object","description":"Xml dataset.","properties":{"typeProperties":{"$ref":"#/definitions/...` |

### Changes for `XmlDatasetTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.XmlDatasetTypeProperties__added` | added | `{"type":"object","description":"Xml dataset properties.","properties":{"location":{"$ref":"#/definit...` |

### Changes for `XmlReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.XmlReadSettings__added` | added | `{"type":"object","description":"Xml read settings.","properties":{"compressionProperties":{"$ref":"#...` |

### Changes for `XmlSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.XmlSource__added` | added | `{"type":"object","description":"A copy activity Xml source.","properties":{"storeSettings":{"$ref":"...` |

### Changes for `ZendeskLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ZendeskLinkedService__added` | added | `{"type":"object","description":"Linked service for Zendesk.","properties":{"typeProperties":{"$ref":...` |

### Changes for `ZendeskLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ZendeskLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Zendesk linked service type properties.","properties":{"authenticati...` |

### Changes for `ZipDeflateReadSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ZipDeflateReadSettings__added` | added | `{"type":"object","description":"The ZipDeflate compression read settings.","properties":{"preserveZi...` |

### Changes for `ZohoLinkedService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ZohoLinkedService__added` | added | `{"type":"object","description":"Zoho server linked service.","properties":{"typeProperties":{"$ref":...` |

### Changes for `ZohoLinkedServiceTypeProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ZohoLinkedServiceTypeProperties__added` | added | `{"type":"object","description":"Zoho server linked service properties.","properties":{"connectionPro...` |

### Changes for `ZohoObjectDataset`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ZohoObjectDataset__added` | added | `{"type":"object","description":"Zoho server dataset.","properties":{"typeProperties":{"$ref":"#/defi...` |

### Changes for `ZohoSource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ZohoSource__added` | added | `{"type":"object","description":"A copy activity Zoho server source.","properties":{"query":{"descrip...` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActivityRun.properties.durationInMs.format__added` | added | `int32` |
| `definitions.CreateDataFlowDebugSessionRequest.properties.coreCount.format__added` | added | `int32` |
| `definitions.CreateDataFlowDebugSessionRequest.properties.timeToLive.format__added` | added | `int32` |
| `definitions.DataFlowDebugCommandPayload.properties.rowLimits.format__added` | added | `int32` |
| `definitions.DataFlowDebugSessionInfo.properties.coreCount.format__added` | added | `int32` |
| `definitions.DataFlowDebugSessionInfo.properties.nodeCount.format__added` | added | `int32` |
| `definitions.DataFlowDebugSessionInfo.properties.timeToLiveInMinutes.format__added` | added | `int32` |
| `definitions.DataFlowSourceSetting.properties.rowLimit.format__added` | added | `int32` |
| `definitions.EnableInteractiveQueryRequest.properties.autoTerminationMinutes.format__added` | added | `int32` |
| `definitions.PipelineRun.properties.durationInMs.format__added` | added | `int32` |
| `definitions.UpdateIntegrationRuntimeNodeRequest.properties.concurrentJobsLimit.format__added` | added | `int32` |

### Changes for `x-ms-format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureKeyVaultSecretReference.properties.secretName['x-ms-format__deleted']` | deleted | `dfe-string` |
| `definitions.AzureKeyVaultSecretReference.properties.secretVersion['x-ms-format__deleted']` | deleted | `dfe-string` |
| `definitions.DataFlowStagingInfo.properties.folderPath['x-ms-format__deleted']` | deleted | `dfe-string` |

### Changes for `etag`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ChangeDataCaptureResource.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.CredentialResource.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.DataFlowResource.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.DatasetResource.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.GlobalParameterResource.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.IntegrationRuntimeResource.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.LinkedServiceResource.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.ManagedPrivateEndpointResource.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.ManagedVirtualNetworkResource.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.PipelineResource.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.PrivateEndpointConnectionResource.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.TriggerResource.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataFlowDebugPackage.properties.debugSettings.properties__deleted` | deleted | `{"sourceSettings":{"type":"array","description":"Source setting for data flow debug.","items":{"$ref...` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatasetReference.properties.type['x-ms-enum__added']` | added | `{"name":"DatasetReferenceType","modelAsString":true}` |
| `definitions.Expression.properties.type['x-ms-enum__added']` | added | `{"name":"ExpressionType","modelAsString":true}` |
| `definitions.IntegrationRuntimeReference.properties.type['x-ms-enum__added']` | added | `{"name":"IntegrationRuntimeReferenceType","modelAsString":true}` |
| `definitions.PipelineReference.properties.type['x-ms-enum__added']` | added | `{"name":"PipelineReferenceType","modelAsString":true}` |
| `definitions.UpdateIntegrationRuntimeRequest.properties.autoUpdate['x-ms-enum__added']` | added | `{"name":"IntegrationRuntimeAutoUpdate","modelAsString":true}` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Factory.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |

### Changes for `eTag`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Factory.properties.eTag__added` | added | `{"type":"string","description":"If eTag is provided in the response body, it may also be provided as...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GlobalParameterResource.required__deleted` | deleted | `["properties"]` |
| `definitions.QueryDataFlowDebugSessionsResponse.required__added` | added | `["value"]` |

### Changes for `x-ms-identifiers`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.QueryDataFlowDebugSessionsResponse.properties.value['x-ms-identifiers__deleted']` | deleted | `["dataFlowName","sessionId"]` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpdateIntegrationRuntimeRequest.properties.autoUpdate.enum__added` | added | `["On","Off"]` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ChangeDataCaptureResource.allOf[0].$ref` | `#/definitions/SubResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.ChangeDataCaptureResource.properties.properties.$ref` | `./entityTypes/ChangeDataCapture.json#/definitions/ChangeDataCapture` | `#/definitions/ChangeDataCapture` |
| `definitions.CredentialResource.allOf[0].$ref` | `#/definitions/SubResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.CredentialResource.properties.properties.$ref` | `./entityTypes/Credential.json#/definitions/Credential` | `#/definitions/Credential` |
| `definitions.DataFlowDebugResource.properties.properties.$ref` | `./entityTypes/DataFlow.json#/definitions/DataFlow` | `#/definitions/DataFlow` |
| `definitions.DataFlowResource.allOf[0].$ref` | `#/definitions/SubResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.DataFlowResource.properties.properties.$ref` | `./entityTypes/DataFlow.json#/definitions/DataFlow` | `#/definitions/DataFlow` |
| `definitions.DatasetDebugResource.properties.properties.$ref` | `./entityTypes/Dataset.json#/definitions/Dataset` | `#/definitions/Dataset` |
| `definitions.DatasetResource.allOf[0].$ref` | `#/definitions/SubResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.DatasetResource.properties.properties.$ref` | `./entityTypes/Dataset.json#/definitions/Dataset` | `#/definitions/Dataset` |
| `definitions.Factory.allOf[0].$ref` | `#/definitions/Resource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/Resource` |
| `definitions.GlobalParameterResource.allOf[0].$ref` | `#/definitions/SubResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.IntegrationRuntimeDebugResource.properties.properties.$ref` | `./entityTypes/IntegrationRuntime.json#/definitions/IntegrationRuntime` | `#/definitions/IntegrationRuntime` |
| `definitions.IntegrationRuntimeResource.allOf[0].$ref` | `#/definitions/SubResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.IntegrationRuntimeResource.properties.properties.$ref` | `./entityTypes/IntegrationRuntime.json#/definitions/IntegrationRuntime` | `#/definitions/IntegrationRuntime` |
| `definitions.IntegrationRuntimeStatusResponse.properties.properties.$ref` | `./entityTypes/IntegrationRuntime.json#/definitions/IntegrationRuntimeStatus` | `#/definitions/IntegrationRuntimeStatus` |
| `definitions.LinkedServiceDebugResource.properties.properties.$ref` | `./entityTypes/LinkedService.json#/definitions/LinkedService` | `#/definitions/LinkedService` |
| `definitions.LinkedServiceResource.allOf[0].$ref` | `#/definitions/SubResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.LinkedServiceResource.properties.properties.$ref` | `./entityTypes/LinkedService.json#/definitions/LinkedService` | `#/definitions/LinkedService` |
| `definitions.ManagedPrivateEndpointResource.allOf[0].$ref` | `#/definitions/SubResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.ManagedPrivateEndpointResource.properties.properties.$ref` | `./entityTypes/ManagedPrivateEndpoint.json#/definitions/ManagedPrivateEndpoint` | `#/definitions/ManagedPrivateEndpoint` |
| `definitions.ManagedVirtualNetworkResource.allOf[0].$ref` | `#/definitions/SubResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.ManagedVirtualNetworkResource.properties.properties.$ref` | `./entityTypes/ManagedVirtualNetwork.json#/definitions/ManagedVirtualNetwork` | `#/definitions/ManagedVirtualNetwork` |
| `definitions.PipelineResource.allOf[0].$ref` | `#/definitions/SubResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.PipelineResource.properties.properties.$ref` | `./entityTypes/Pipeline.json#/definitions/Pipeline` | `#/definitions/Pipeline` |
| `definitions.PrivateEndpointConnectionResource.allOf[0].$ref` | `#/definitions/SubResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.TriggerResource.allOf[0].$ref` | `#/definitions/SubResource` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `definitions.TriggerResource.properties.properties.$ref` | `./entityTypes/Trigger.json#/definitions/Trigger` | `#/definitions/Trigger` |
| `definitions.UpdateIntegrationRuntimeRequest.properties.autoUpdate.description` | `Enables or disables the auto-update feature of the self-hosted integration runtime. See https://go.microsoft.com/fwlink/?linkid=854189.` | `The state of integration runtime auto update.` |
| `paths['/providers/microsoft.DataFactory/operations'].get.description` | `Lists the available Azure Data Factory API operations.` | `List the operations for the provider` |
| `paths['/providers/microsoft.DataFactory/operations'].get.responses.200.schema.$ref` | `#/definitions/OperationListResponse` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/OperationListResult` |
| `paths['/providers/microsoft.DataFactory/operations'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DataFactory/factories'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DataFactory/locations/{locationId}/configureFactoryRepo'].post.parameters[1].name` | `factoryRepoUpdate` | `body` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DataFactory/locations/{locationId}/configureFactoryRepo'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DataFactory/locations/{locationId}/getFeatureValue'].post.parameters[1].name` | `exposureControlRequest` | `body` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DataFactory/locations/{locationId}/getFeatureValue'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}'].get.parameters[1].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}'].patch.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/addDataFlowToDebugSession'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/adfcdcs'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/adfcdcs/{changeDataCaptureName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/adfcdcs/{changeDataCaptureName}'].get.parameters[2].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/adfcdcs/{changeDataCaptureName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/adfcdcs/{changeDataCaptureName}'].put.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/adfcdcs/{changeDataCaptureName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/adfcdcs/{changeDataCaptureName}/start'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/adfcdcs/{changeDataCaptureName}/status'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/adfcdcs/{changeDataCaptureName}/stop'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/createDataFlowDebugSession'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/credentials'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/credentials/{credentialName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/credentials/{credentialName}'].get.parameters[2].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/credentials/{credentialName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/credentials/{credentialName}'].put.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/credentials/{credentialName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/dataflows'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/dataflows/{dataFlowName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/dataflows/{dataFlowName}'].get.parameters[2].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/dataflows/{dataFlowName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/dataflows/{dataFlowName}'].put.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/dataflows/{dataFlowName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/datasets'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/datasets/{datasetName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/datasets/{datasetName}'].get.parameters[2].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/datasets/{datasetName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/datasets/{datasetName}'].put.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/datasets/{datasetName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/deleteDataFlowDebugSession'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/executeDataFlowDebugCommand'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/getDataPlaneAccess'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/getFeatureValue'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/getGitHubAccessToken'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/globalParameters'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/globalParameters/{globalParameterName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/globalParameters/{globalParameterName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/globalParameters/{globalParameterName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}'].get.parameters[2].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}'].patch.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}'].put.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/getConnectionInfo'].post.responses.200.schema.$ref` | `./entityTypes/IntegrationRuntime.json#/definitions/IntegrationRuntimeConnectionInfo` | `#/definitions/IntegrationRuntimeConnectionInfo` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/getConnectionInfo'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/getObjectMetadata'].post.responses.200.schema.$ref` | `./entityTypes/IntegrationRuntime.json#/definitions/SsisObjectMetadataListResponse` | `#/definitions/SsisObjectMetadataListResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/getObjectMetadata'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/getStatus'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/linkedIntegrationRuntime'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/listAuthKeys'].post.responses.200.schema.$ref` | `./entityTypes/IntegrationRuntime.json#/definitions/IntegrationRuntimeAuthKeys` | `#/definitions/IntegrationRuntimeAuthKeys` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/listAuthKeys'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/monitoringData'].post.responses.200.schema.$ref` | `./entityTypes/IntegrationRuntime.json#/definitions/IntegrationRuntimeMonitoringData` | `#/definitions/IntegrationRuntimeMonitoringData` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/monitoringData'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/outboundNetworkDependenciesEndpoints'].get.responses.200.schema.$ref` | `./entityTypes/IntegrationRuntime.json#/definitions/IntegrationRuntimeOutboundNetworkDependenciesEndpointsResponse` | `#/definitions/IntegrationRuntimeOutboundNetworkDependenciesEndpointsResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/outboundNetworkDependenciesEndpoints'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/refreshObjectMetadata'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/regenerateAuthKey'].post.parameters[2].schema.$ref` | `./entityTypes/IntegrationRuntime.json#/definitions/IntegrationRuntimeRegenerateKeyParameters` | `#/definitions/IntegrationRuntimeRegenerateKeyParameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/regenerateAuthKey'].post.responses.200.schema.$ref` | `./entityTypes/IntegrationRuntime.json#/definitions/IntegrationRuntimeAuthKeys` | `#/definitions/IntegrationRuntimeAuthKeys` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/regenerateAuthKey'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/removeLinks'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/start'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/stop'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/syncCredentials'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/upgrade'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/linkedservices'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/linkedservices/{linkedServiceName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/linkedservices/{linkedServiceName}'].get.parameters[2].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/linkedservices/{linkedServiceName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/linkedservices/{linkedServiceName}'].put.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/linkedservices/{linkedServiceName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/managedVirtualNetworks'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/managedVirtualNetworks/{managedVirtualNetworkName}'].get.parameters[2].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/managedVirtualNetworks/{managedVirtualNetworkName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/managedVirtualNetworks/{managedVirtualNetworkName}'].put.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/managedVirtualNetworks/{managedVirtualNetworkName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/managedVirtualNetworks/{managedVirtualNetworkName}/managedPrivateEndpoints'].get.responses.200.schema.$ref` | `#/definitions/managedPrivateEndpointListResponse` | `#/definitions/ManagedPrivateEndpointListResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/managedVirtualNetworks/{managedVirtualNetworkName}/managedPrivateEndpoints'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/managedVirtualNetworks/{managedVirtualNetworkName}/managedPrivateEndpoints/{managedPrivateEndpointName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/managedVirtualNetworks/{managedVirtualNetworkName}/managedPrivateEndpoints/{managedPrivateEndpointName}'].get.parameters[3].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/managedVirtualNetworks/{managedVirtualNetworkName}/managedPrivateEndpoints/{managedPrivateEndpointName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/managedVirtualNetworks/{managedVirtualNetworkName}/managedPrivateEndpoints/{managedPrivateEndpointName}'].put.parameters[3].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/managedVirtualNetworks/{managedVirtualNetworkName}/managedPrivateEndpoints/{managedPrivateEndpointName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelines'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelines/{pipelineName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelines/{pipelineName}'].get.parameters[2].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelines/{pipelineName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelines/{pipelineName}'].put.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelines/{pipelineName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelines/{pipelineName}/createRun'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[2].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/privateLinkResources'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/queryDataFlowDebugSessions'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/queryFeaturesValue'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/queryPipelineRuns'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/queryTriggerRuns'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/querytriggers'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}'].get.parameters[2].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}'].put.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/getEventSubscriptionStatus'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/start'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/stop'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/subscribeToEvents'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/unsubscribeFromEvents'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` |

