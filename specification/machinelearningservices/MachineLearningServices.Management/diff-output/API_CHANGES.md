## Swagger Changes

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccountKeyAuthTypeWorkspaceConnectionProperties.properties.credentials.description__added` | added | `Account key object for workspace connection credential.` |
| `definitions.AutoMLJob.properties.outputs.additionalProperties.description__deleted` | deleted | `Job output definition container information on where to find job output/logs.` |
| `definitions.CapabilityHost.description__added` | added | `Azure Resource Manager resource envelope.` |
| `definitions.CommandJob.properties.inputs.additionalProperties.description__deleted` | deleted | `Command job definition.` |
| `definitions.CommandJob.properties.outputs.additionalProperties.description__deleted` | deleted | `Job output definition container information on where to find job output/logs.` |
| `definitions.CustomMonitoringSignal.properties.inputAssets.additionalProperties.description__deleted` | deleted | `Monitoring input data base definition.` |
| `definitions.CustomMonitoringSignal.properties.inputs.additionalProperties.description__deleted` | deleted | `Command job definition.` |
| `definitions.DistillationJob.properties.outputs.additionalProperties.description__deleted` | deleted | `Job output definition container information on where to find job output/logs.` |
| `definitions.EndpointDeploymentResourcePropertiesBasicResource.description__added` | added | `Concrete proxy resource types can be created by aliasing this type using a specific property type.` |
| `definitions.EndpointModelSkuProperties.properties.connectionIds.items.description__added` | added | `A type definition that refers the id to an Azure Resource Manager resource.` |
| `definitions.EndpointResourcePropertiesBasicResource.description__added` | added | `Concrete proxy resource types can be created by aliasing this type using a specific property type.` |
| `definitions.FeatureAttributionDriftMonitoringSignal.properties.productionData.items.description__deleted` | deleted | `Monitoring input data base definition.` |
| `definitions.FineTuningJob.properties.outputs.additionalProperties.description__deleted` | deleted | `Job output definition container information on where to find job output/logs.` |
| `definitions.JupyterKernelConfig.properties.argv.items.description__deleted` | deleted | `argument values` |
| `definitions.ManagedNetworkSettings.properties.outboundRules.additionalProperties.description__deleted` | deleted | `Outbound Rule for the managed network of a machine learning workspace.` |
| `definitions.ManagedNetworkSettings.properties.outboundRules.description__added` | added | `Dictionary of <OutboundRule>` |
| `definitions.ManagedNetworkSettingsPropertiesBasicResource.description__added` | added | `Concrete proxy resource types can be created by aliasing this type using a specific property type.` |
| `definitions.MarketplaceSubscription.description__added` | added | `Azure Resource Manager resource envelope.` |
| `definitions.ModelContainer.description__added` | added | `Azure Resource Manager resource envelope.` |
| `definitions.NotificationSetting.properties.webhooks.additionalProperties.description__deleted` | deleted | `Webhook base` |
| `definitions.OnlineDeployment.description__added` | added | `Concrete tracked resource types can be created by aliasing this type using a specific property type.` |
| `definitions.OutboundRuleBasicResource.description__added` | added | `Concrete proxy resource types can be created by aliasing this type using a specific property type.` |
| `definitions.PipelineJob.properties.inputs.additionalProperties.description__deleted` | deleted | `Command job definition.` |
| `definitions.PipelineJob.properties.outputs.additionalProperties.description__deleted` | deleted | `Job output definition container information on where to find job output/logs.` |
| `definitions.PrivateEndpointConnection.properties.identity.description__added` | added | `The managed service identities assigned to this resource.` |
| `definitions.PrivateEndpointDestination.properties.serviceResourceId.description__added` | added | `A type definition that refers the id to an Azure Resource Manager resource.` |
| `definitions.PrivateLinkResourceListResult.properties.value.description__added` | added | `[Placeholder] Discription for value property` |
| `definitions.RaiBlocklistItemPropertiesBasicResource.description__added` | added | `Concrete proxy resource types can be created by aliasing this type using a specific property type.` |
| `definitions.RaiBlocklistPropertiesBasicResource.description__added` | added | `Concrete proxy resource types can be created by aliasing this type using a specific property type.` |
| `definitions.RaiPolicyPropertiesBasicResource.properties.properties.description__added` | added | `Azure OpenAI Content Filters properties.` |
| `definitions.ServerlessEndpoint.description__added` | added | `Concrete tracked resource types can be created by aliasing this type using a specific property type.` |
| `definitions.SparkJob.properties.inputs.additionalProperties.description__deleted` | deleted | `Command job definition.` |
| `definitions.SparkJob.properties.outputs.additionalProperties.description__deleted` | deleted | `Job output definition container information on where to find job output/logs.` |
| `definitions.SweepJob.properties.inputs.additionalProperties.description__deleted` | deleted | `Command job definition.` |
| `definitions.SweepJob.properties.outputs.additionalProperties.description__deleted` | deleted | `Job output definition container information on where to find job output/logs.` |
| `definitions.Workspace.properties.identity.description__added` | added | `The managed service identities assigned to this resource.` |
| `definitions.WorkspaceConnectionPropertiesV2.properties.createdByWorkspaceArmId.description__added` | added | `A type definition that refers the id to an Azure Resource Manager resource.` |
| `definitions.WorkspaceConnectionPropertiesV2BasicResource.description__added` | added | `Concrete proxy resource types can be created by aliasing this type using a specific property type.` |
| `paths['/providers/microsoft.MachineLearningServices/operations'].get.description__added` | added | `List the operations for the provider` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.MachineLearningServices/locations/{location}/availableQuota'].get.description__added` | added | `List available MaaS PTU quota.` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.MachineLearningServices/locations/{location}/availableQuota/default'].get.description__added` | added | `Get available MaaS PTU quota.` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.MachineLearningServices/locations/{location}/quotaAndUsage'].get.description__added` | added | `List MaaS PTU usage and quota.` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.MachineLearningServices/registries'].get.description__added` | added | `List registries by subscription` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.MachineLearningServices/workspaces'].get.description__added` | added | `Lists all the available machine learning workspaces under the specified subscription.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries'].get.description__added` | added | `List registries` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}'].delete.description__added` | added | `Delete registry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}'].get.description__added` | added | `Get registry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}'].patch.description__added` | added | `Update tags` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}'].put.description__added` | added | `Create or update registry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes'].get.description__added` | added | `List containers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}'].delete.description__added` | added | `Delete Code container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}'].get.description__added` | added | `Get Code container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}'].put.description__added` | added | `Create or update Code container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}/versions'].get.description__added` | added | `List versions.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}/versions/{version}'].delete.description__added` | added | `Delete version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}/versions/{version}'].get.description__added` | added | `Get version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}/versions/{version}'].put.description__added` | added | `Create or update version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}/versions/{version}/startPendingUpload'].post.description__added` | added | `Generate a storage location and credential for the client to upload a code asset to.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components'].get.description__added` | added | `List containers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}'].delete.description__added` | added | `Delete container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}'].get.description__added` | added | `Get container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}'].put.description__added` | added | `Create or update container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}/versions'].get.description__added` | added | `List versions.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}/versions/{version}'].delete.description__added` | added | `Delete version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}/versions/{version}'].get.description__added` | added | `Get version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}/versions/{version}'].put.description__added` | added | `Create or update version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data'].get.description__added` | added | `List Data containers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}'].delete.description__added` | added | `Delete container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}'].get.description__added` | added | `Get container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}'].put.description__added` | added | `Create or update container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}/versions'].get.description__added` | added | `List data versions in the data container` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}/versions/{version}'].delete.description__added` | added | `Delete version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}/versions/{version}'].get.description__added` | added | `Get version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}/versions/{version}'].put.description__added` | added | `Create or update version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}/versions/{version}/startPendingUpload'].post.description__added` | added | `Generate a storage location and credential for the client to upload a data asset to.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/datareferences/{name}/versions/{version}'].post.description__added` | added | `Get blob reference SAS Uri.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments'].get.description__added` | added | `List environment containers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}'].delete.description__added` | added | `Delete container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}'].get.description__added` | added | `Get container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}'].put.description__added` | added | `Create or update container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}/versions'].get.description__added` | added | `List versions.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}/versions/{version}'].delete.description__added` | added | `Delete version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}/versions/{version}'].get.description__added` | added | `Get version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}/versions/{version}'].put.description__added` | added | `Create or update version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models'].get.description__added` | added | `List model containers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}'].delete.description__added` | added | `Delete container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}'].get.description__added` | added | `Get container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}'].put.description__added` | added | `Create or update model container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}/versions'].get.description__added` | added | `List versions.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}/versions/{version}'].delete.description__added` | added | `Delete version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}/versions/{version}'].get.description__added` | added | `Get version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}/versions/{version}'].put.description__added` | added | `Create or update version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}/versions/{version}/startPendingUpload'].post.description__added` | added | `Generate a storage location and credential for the client to upload a model asset to.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/removeRegions'].post.description__added` | added | `Remove regions from registry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces'].get.description__added` | added | `Lists all the available machine learning workspaces under the specified resource group.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}'].delete.description__added` | added | `Deletes a machine learning workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}'].get.description__added` | added | `Gets the properties of the specified machine learning workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}'].patch.description__added` | added | `Updates a machine learning workspace with the specified parameters.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}'].put.description__added` | added | `Creates or updates a workspace with the specified parameters.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints'].get.description__added` | added | `Lists Batch inference endpoint in the workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].delete.description__added` | added | `Delete Batch Inference Endpoint (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].get.description__added` | added | `Gets a batch inference endpoint by name.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].patch.description__added` | added | `Update a batch inference endpoint (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].put.description__added` | added | `Creates a batch inference endpoint (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments'].get.description__added` | added | `Lists Batch inference deployments in the workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].delete.description__added` | added | `Delete Batch Inference deployment (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].get.description__added` | added | `Gets a batch inference deployment by id.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].patch.description__added` | added | `Update a batch inference deployment (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].put.description__added` | added | `Creates/updates a batch inference deployment (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/listkeys'].post.description__added` | added | `Lists batch Inference Endpoint keys.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].delete.description__added` | added | `Delete capabilityHost.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].get.description__added` | added | `Get capabilityHost.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].put.description__added` | added | `Create or update capabilityHost.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes'].get.description__added` | added | `List containers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}'].delete.description__added` | added | `Delete container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}'].get.description__added` | added | `Get container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}'].put.description__added` | added | `Create or update container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions'].get.description__added` | added | `List versions.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions/{version}'].delete.description__added` | added | `Delete version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions/{version}'].get.description__added` | added | `Get version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions/{version}'].put.description__added` | added | `Create or update version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions/{version}/publish'].post.description__added` | added | `Publish version asset into registry.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions/{version}/startPendingUpload'].post.description__added` | added | `Generate a storage location and credential for the client to upload a code asset to.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components'].get.description__added` | added | `List component containers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}'].delete.description__added` | added | `Delete container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}'].get.description__added` | added | `Get container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}'].put.description__added` | added | `Create or update container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}/versions'].get.description__added` | added | `List component versions.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}/versions/{version}'].delete.description__added` | added | `Delete version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}/versions/{version}'].get.description__added` | added | `Get version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}/versions/{version}'].put.description__added` | added | `Create or update version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}/versions/{version}/publish'].post.description__added` | added | `Publish version asset into registry.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/resize'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/updateDataMounts'].post.description__added` | added | `Update Data Mounts of a Machine Learning compute.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections'].get.description__added` | added | `Lists all the available machine learning workspaces connections under the specified workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}'].delete.description__added` | added | `Delete machine learning workspaces connections by name.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}'].get.description__added` | added | `Lists machine learning workspaces connections by name.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}'].patch.description__added` | added | `Update machine learning workspaces connections under the specified workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}'].put.description__added` | added | `Create or update machine learning workspaces connections under the specified workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/deployments'].get.description__added` | added | `Get all the deployments under the Azure OpenAI connection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/deployments/{deploymentName}'].delete.description__added` | added | `Delete Azure OpenAI connection deployment resource by name` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/deployments/{deploymentName}'].get.description__added` | added | `Get deployments under the Azure OpenAI connection by name.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/deployments/{deploymentName}'].put.description__added` | added | `Create or update Azure OpenAI connection deployment resource with the specified parameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/listsecrets'].post.description__added` | added | `List all the secrets of a machine learning workspaces connections.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/models'].get.description__added` | added | `Get available models under the Azure OpenAI connection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists'].get.description__added` | added | `Gets the custom blocklists associated with the Azure OpenAI connection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}'].delete.description__added` | added | `Deletes the specified custom blocklist associated with the Azure OpenAI connection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}'].get.description__added` | added | `Gets the specified custom blocklist associated with the Azure OpenAI connection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}'].put.description__added` | added | `Update the state of specified blocklist associated with the Azure OpenAI connection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/addRaiBlocklistItems'].post.description__added` | added | `Add multiple blocklist items to the specified blocklist associated with the Azure OpenAI connection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems'].post.description__added` | added | `Delete multiple blocklist items from the specified blocklist associated with the Azure OpenAI connection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/raiBlocklistItems'].get.description__added` | added | `Gets the custom blocklist items associated with the Azure OpenAI connection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/raiBlocklistItems/{raiBlocklistItemName}'].delete.description__added` | added | `Deletes the specified custom blocklist item associated with the Azure OpenAI connection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/raiBlocklistItems/{raiBlocklistItemName}'].get.description__added` | added | `Gets the specified custom blocklist item associated with the Azure OpenAI connection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/raiBlocklistItems/{raiBlocklistItemName}'].put.description__added` | added | `Update the state of specified blocklist item associated with the Azure OpenAI connection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiPolicies'].get.description__added` | added | `List the specified Content Filters associated with the Azure OpenAI connection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiPolicies/{raiPolicyName}'].delete.description__added` | added | `Deletes the specified Content Filters associated with the Azure OpenAI connection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiPolicies/{raiPolicyName}'].get.description__added` | added | `Gets the specified Content Filters associated with the Azure OpenAI connection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiPolicies/{raiPolicyName}'].put.description__added` | added | `Update the state of specified Content Filters associated with the Azure OpenAI connection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/testconnection'].post.description__added` | added | `Test machine learning workspaces connections under the specified workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data'].get.description__added` | added | `List data containers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}'].delete.description__added` | added | `Delete container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}'].get.description__added` | added | `Get container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}'].put.description__added` | added | `Create or update container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}/versions'].get.description__added` | added | `List data versions in the data container` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}/versions/{version}'].delete.description__added` | added | `Delete version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}/versions/{version}'].get.description__added` | added | `Get version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}/versions/{version}'].put.description__added` | added | `Create or update version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}/versions/{version}/publish'].post.description__added` | added | `Publish version asset into registry.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/datastores'].get.description__added` | added | `List datastores.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/datastores/{name}'].delete.description__added` | added | `Delete datastore.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/datastores/{name}'].get.description__added` | added | `Get datastore.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/datastores/{name}'].put.description__added` | added | `Create or update datastore.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/datastores/{name}/listSecrets'].post.description__added` | added | `Get datastore secrets.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/datastores/{name}/listSecrets'].post.responses.200.schema.description__deleted` | deleted | `Base definition for datastore secrets.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/deployments'].get.description__added` | added | `Get all the deployments under the workspace scope` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/diagnose'].post.description__added` | added | `Diagnose workspace setup issue.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints'].get.description__added` | added | `List All the endpoints under this workspace` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}'].get.description__added` | added | `Gets endpoint resource` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}'].put.description__added` | added | `Create or update endpoint resource with the specified parameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments'].get.description__added` | added | `Get all the deployments under the endpoint resource scope` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}'].delete.description__added` | added | `Delete  endpoint deployment resource by name` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}'].get.description__added` | added | `Get deployments under endpoint resource by name` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}'].put.description__added` | added | `Create or update endpoint deployment resource with the specified parameters` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/listKeys'].post.description__added` | added | `List keys for the endpoint resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/models'].get.description__added` | added | `Get available models under the endpoint resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/raiPolicies'].get.description__added` | added | `List the specified Content Filters associated with the Azure OpenAI account.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/raiPolicies/{raiPolicyName}'].delete.description__added` | added | `Deletes the specified Content Filters associated with the Azure OpenAI account.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/raiPolicies/{raiPolicyName}'].get.description__added` | added | `Gets the specified Content Filters associated with the Azure OpenAI account.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/raiPolicies/{raiPolicyName}'].put.description__added` | added | `Update the state of specified Content Filters associated with the Azure OpenAI account.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/regenerateKey'].post.description__added` | added | `Regenerate account keys` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments'].get.description__added` | added | `List environment containers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}'].delete.description__added` | added | `Delete container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}'].get.description__added` | added | `Get container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}'].put.description__added` | added | `Create or update container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}/versions'].get.description__added` | added | `List versions.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}/versions/{version}'].delete.description__added` | added | `Delete version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}/versions/{version}'].get.description__added` | added | `Get version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}/versions/{version}'].put.description__added` | added | `Creates or updates an EnvironmentVersion.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}/versions/{version}/publish'].post.description__added` | added | `Publish version asset into registry.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets'].get.description__added` | added | `List featurestore entity containers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{featuresetName}/versions/{featuresetVersion}/features'].get.description__added` | added | `List Features.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{featuresetName}/versions/{featuresetVersion}/features/{featureName}'].get.description__added` | added | `Get feature.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}'].delete.description__added` | added | `Delete container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}'].get.description__added` | added | `Get container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}'].put.description__added` | added | `Create or update container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions'].get.description__added` | added | `List versions.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].delete.description__added` | added | `Delete version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].get.description__added` | added | `Get version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].put.description__added` | added | `Create or update version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}/backfill'].post.description__added` | added | `Backfill.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities'].get.description__added` | added | `List featurestore entity containers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].delete.description__added` | added | `Delete container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].get.description__added` | added | `Get container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].put.description__added` | added | `Create or update container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions'].get.description__added` | added | `List versions.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].delete.description__added` | added | `Delete version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].get.description__added` | added | `Get version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].put.description__added` | added | `Create or update version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools'].get.description__added` | added | `List InferencePools.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{inferencePoolName}'].delete.description__added` | added | `Delete InferencePool (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{inferencePoolName}'].get.description__added` | added | `Get InferencePool.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{inferencePoolName}'].patch.description__added` | added | `Update InferencePool (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{inferencePoolName}'].put.description__added` | added | `Create or update InferencePool (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints'].get.description__added` | added | `List Inference Endpoints.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}'].delete.description__added` | added | `Delete InferenceEndpoint (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}'].get.description__added` | added | `Get InferenceEndpoint.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}'].patch.description__added` | added | `Update InferenceEndpoint (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}'].put.description__added` | added | `Create or update InferenceEndpoint (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups'].get.description__added` | added | `List Inference Groups.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}'].delete.description__added` | added | `Delete InferenceGroup (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}'].get.description__added` | added | `Get InferenceGroup.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}'].patch.description__added` | added | `Update InferenceGroup (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}'].put.description__added` | added | `Create or update InferenceGroup (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/deltaModels/getStatus'].post.description__added` | added | `Retrieve status of delta models associated with the InferenceGroup and the target base model.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/deltaModels/list'].post.description__added` | added | `List delta models associated with the InferenceGroup and the target base model.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/deltaModels/modify'].post.description__added` | added | `Modify delta models associated with the InferenceGroup and the target base model.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/getStatus'].post.description__added` | added | `Retrieve inference group status.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/skus'].get.description__added` | added | `List Inference Group Skus.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/jobs'].get.description__added` | added | `Lists Jobs in the workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/jobs/{id}'].delete.description__added` | added | `Deletes a Job (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/jobs/{id}'].get.description__added` | added | `Gets a Job by name/id.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/jobs/{id}'].put.description__added` | added | `Creates and executes a Job.
For update case, the Tags in the definition passed in will replace Tags in the existing job.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/jobs/{id}/cancel'].post.description__added` | added | `Cancels a Job (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/listConnectionModels'].post.description__added` | added | `Get models under the Azure ML workspace for all Azure OpenAI connections that the user can deploy.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/listKeys'].post.description__added` | added | `Lists all the keys associated with this workspace. This includes keys for the storage account, app insights and password for container registry.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/listNotebookAccessToken'].post.description__added` | added | `Get Azure Machine Learning Workspace notebook access token` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/listNotebookKeys'].post.description__added` | added | `Lists keys of Azure Machine Learning Workspaces notebook.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/listStorageAccountKeys'].post.description__added` | added | `Lists keys of Azure Machine Learning Workspace's storage account.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks'].get.description__added` | added | `List API for managed network settings of a machine learning workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks/{managedNetworkName}'].get.description__added` | added | `Get API for managed network settings of a machine learning workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks/{managedNetworkName}'].patch.description__added` | added | `Patch API for managed network settings of a machine learning workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks/{managedNetworkName}'].put.description__added` | added | `PUT API for managed network settings of a machine learning workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks/{managedNetworkName}/batchOutboundRules'].post.description__added` | added | `The POST API for updating the outbound rules of the managed network associated with the machine learning workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks/{managedNetworkName}/outboundRules'].get.description__added` | added | `The GET API for retrieveing the list of outbound rules of the managed network associated with the machine learning workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}'].delete.description__added` | added | `The DELETE API for deleting a single outbound rule of the managed network associated with the machine learning workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}'].get.description__added` | added | `The GET API for retrieveing a single outbound rule of the managed network associated with the machine learning workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}'].put.description__added` | added | `Create a OutboundRuleBasicResource` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions'].get.description__added` | added | `List containers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions/{name}'].delete.description__added` | added | `Delete Marketplace Subscription (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions/{name}'].get.description__added` | added | `Get container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions/{name}'].put.description__added` | added | `Create or update Marketplace Subscription (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models'].get.description__added` | added | `List model containers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}'].delete.description__added` | added | `Delete container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}'].get.description__added` | added | `Get container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}'].put.description__added` | added | `Create or update container.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}/versions'].get.description__added` | added | `List model versions.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}/versions/{version}'].delete.description__added` | added | `Delete version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}/versions/{version}'].get.description__added` | added | `Get version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}/versions/{version}'].put.description__added` | added | `Create or update version.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}/versions/{version}/publish'].post.description__added` | added | `Publish version asset into registry.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints'].get.description__added` | added | `List Online Endpoints.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}'].delete.description__added` | added | `Delete Online Endpoint (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}'].get.description__added` | added | `Get Online Endpoint.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}'].patch.description__added` | added | `Update Online Endpoint (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}'].put.description__added` | added | `Create or update Online Endpoint (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments'].get.description__added` | added | `List Inference Endpoint Deployments.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].delete.description__added` | added | `Delete Inference Endpoint Deployment (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].get.description__added` | added | `Get Inference Deployment Deployment.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].patch.description__added` | added | `Update Online Deployment (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].put.description__added` | added | `Create or update Inference Endpoint Deployment (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}/getLogs'].post.description__added` | added | `Polls an Endpoint operation.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}/skus'].get.description__added` | added | `List Inference Endpoint Deployment Skus.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/listKeys'].post.description__added` | added | `List EndpointAuthKeys for an Endpoint using Key-based authentication.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/regenerateKeys'].post.description__added` | added | `Regenerate EndpointAuthKeys for an Endpoint using Key-based authentication (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/token'].post.description__added` | added | `Retrieve a valid AML token for an Endpoint using AMLToken-based authentication.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/outboundNetworkDependenciesEndpoints'].get.description__added` | added | `Called by Client (Portal, CLI, etc) to get a list of all external outbound dependencies (FQDNs) programmatically.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/outboundRules'].get.description__added` | added | `Lists the managed network outbound rules for a machine learning workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/outboundRules/{ruleName}'].delete.description__added` | added | `Deletes an outbound rule from the managed network of a machine learning workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/outboundRules/{ruleName}'].get.description__added` | added | `Gets an outbound rule from the managed network of a machine learning workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/outboundRules/{ruleName}'].put.description__added` | added | `Creates or updates an outbound rule in the managed network of a machine learning workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/prepareNotebook'].post.description__added` | added | `Prepare Azure Machine Learning Workspace's notebook resource` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/privateEndpointConnections'].get.description__added` | added | `Called by end-users to get all PE connections.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.description__added` | added | `Called by end-users to delete a PE connection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.description__added` | added | `Called by end-users to get a PE connection.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.description__added` | added | `Called by end-users to approve or reject a PE connection.
This method must validate and forward the call to NRP.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/privateLinkResources'].get.description__added` | added | `Called by Client (Portal, CLI, etc) to get available "private link resources" for the workspace.
Each "private link resource" is a connection endpoint (IP address) to the resource.
Pre single connection endpoint per workspace: the Data Plane IP address, returned by DNS resolution.
Other RPs, such as Azure Storage, have multiple - one for Blobs, other for Queues, etc.
Defined in the "[NRP] Private Endpoint Design" doc, topic "GET API for GroupIds".` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/provisionManagedNetwork'].post.description__added` | added | `Provisions the managed network of a machine learning workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/resyncKeys'].post.description__added` | added | `Resync all the keys associated with this workspace.This includes keys for the storage account, app insights and password for container registry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules'].get.description__added` | added | `List schedules in specified workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules/{name}'].delete.description__added` | added | `Delete schedule.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules/{name}'].get.description__added` | added | `Get schedule.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules/{name}'].put.description__added` | added | `Create or update schedule.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints'].get.description__added` | added | `List Serverless Endpoints.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].delete.description__added` | added | `Delete Serverless Endpoint (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].get.description__added` | added | `Get Serverless Endpoint.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].patch.description__added` | added | `Update Serverless Endpoint (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].put.description__added` | added | `Create or update Serverless Endpoint (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}/listKeys'].post.description__added` | added | `List EndpointAuthKeys for an Endpoint using Key-based authentication.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}/regenerateKeys'].post.description__added` | added | `Regenerate EndpointAuthKeys for an Endpoint using Key-based authentication (asynchronous).` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DiagnoseResponseResult.properties.value.$ref__added` | added | `#/definitions/DiagnoseResponseResultValue` |
| `definitions.InstanceTypeSchema.properties.resources.$ref__added` | added | `#/definitions/InstanceTypeSchemaResources` |
| `definitions.PartialManagedServiceIdentity.properties.userAssignedIdentities.additionalProperties.$ref__deleted` | deleted | `#/definitions/PartialUserAssignedIdentity` |
| `definitions.SkuSetting.properties.tier.$ref__deleted` | deleted | `../../../../../common-types/resource-management/v3/types.json#/definitions/SkuTier` |
| `definitions.StringArmPaginatedResult.properties.value.items.$ref__added` | added | `#/definitions/Stringforlist` |
| `definitions.SynapseSpark.properties.properties.$ref__added` | added | `#/definitions/SynapseSparkProperties` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.MachineLearningServices/locations/{location}/availableQuota'].get.parameters[1].$ref__deleted` | deleted | `machineLearningServices.json#/parameters/PaginationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.MachineLearningServices/locations/{location}/quotaAndUsage'].get.parameters[1].$ref__deleted` | deleted | `machineLearningServices.json#/parameters/PaginationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes'].get.parameters[0].$ref__deleted` | deleted | `registries.json#/parameters/RegistryNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes'].get.parameters[1].$ref__deleted` | deleted | `machineLearningServices.json#/parameters/PaginationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components'].get.parameters[0].$ref__deleted` | deleted | `registries.json#/parameters/RegistryNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components'].get.parameters[1].$ref__deleted` | deleted | `machineLearningServices.json#/parameters/PaginationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data'].get.parameters[0].$ref__deleted` | deleted | `registries.json#/parameters/RegistryNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments'].get.parameters[0].$ref__deleted` | deleted | `registries.json#/parameters/RegistryNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models'].get.parameters[0].$ref__deleted` | deleted | `registries.json#/parameters/RegistryNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints'].get.parameters[0].$ref__deleted` | deleted | `machineLearningServices.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes'].get.parameters[0].$ref__deleted` | deleted | `machineLearningServices.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes'].get.parameters[1].$ref__deleted` | deleted | `machineLearningServices.json#/parameters/PaginationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components'].get.parameters[0].$ref__deleted` | deleted | `machineLearningServices.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems'].post.parameters[3].schema.$ref__deleted` | deleted | `#/definitions/RaiBlocklistItemsBulkDeleteRequest` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data'].get.parameters[0].$ref__deleted` | deleted | `machineLearningServices.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments'].get.parameters[0].$ref__deleted` | deleted | `machineLearningServices.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/features'].get.parameters[0].$ref__deleted` | deleted | `machineLearningServices.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions'].get.parameters[0].$ref__deleted` | deleted | `machineLearningServices.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions'].get.parameters[1].$ref__deleted` | deleted | `machineLearningServices.json#/parameters/PaginationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models'].get.parameters[0].$ref__deleted` | deleted | `machineLearningServices.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules'].get.parameters[0].$ref__deleted` | deleted | `machineLearningServices.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints'].get.parameters[0].$ref__deleted` | deleted | `machineLearningServices.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints'].get.parameters[1].$ref__deleted` | deleted | `machineLearningServices.json#/parameters/PaginationParameter` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComputeInstanceProperties.properties.computeInstanceAuthorizationType['x-ms-enum'].name__deleted` | deleted | `ComputeInstanceAuthorizationType` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.MachineLearningServices/locations/{location}/availableQuota'].get.parameters[1].name__added` | added | `$skip` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.MachineLearningServices/locations/{location}/quotaAndUsage'].get.parameters[1].name__added` | added | `$skip` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes'].get.parameters[0].name__added` | added | `registryName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes'].get.parameters[1].name__added` | added | `$skip` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components'].get.parameters[0].name__added` | added | `registryName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components'].get.parameters[1].name__added` | added | `$skip` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data'].get.parameters[0].name__added` | added | `registryName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments'].get.parameters[0].name__added` | added | `registryName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models'].get.parameters[0].name__added` | added | `registryName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes'].get.parameters[1].name__added` | added | `$skip` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/features'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions'].get.parameters[1].name__added` | added | `$skip` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints'].get.parameters[1].name__added` | added | `$skip` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.MachineLearningServices/locations/{location}/availableQuota'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.MachineLearningServices/locations/{location}/quotaAndUsage'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/features'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints'].get.parameters[1].in__added` | added | `query` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AKS.type__added` | added | `object` |
| `definitions.AksComputeSecrets.type__added` | added | `object` |
| `definitions.AmlCompute.type__added` | added | `object` |
| `definitions.AmlComputeProperties.properties.propertyBag.type__deleted` | deleted | `object` |
| `definitions.ColumnTransformer.properties.parameters.type__deleted` | deleted | `object` |
| `definitions.CommandJob.properties.parameters.type__deleted` | deleted | `object` |
| `definitions.ComputeInstance.type__added` | added | `object` |
| `definitions.Databricks.type__added` | added | `object` |
| `definitions.DatabricksComputeSecrets.type__added` | added | `object` |
| `definitions.DataFactory.type__added` | added | `object` |
| `definitions.DataLakeAnalytics.type__added` | added | `object` |
| `definitions.DiagnoseResponseResult.properties.value.type__deleted` | deleted | `object` |
| `definitions.HDInsight.type__added` | added | `object` |
| `definitions.InstanceTypeSchema.properties.resources.type__deleted` | deleted | `object` |
| `definitions.Kubernetes.type__added` | added | `object` |
| `definitions.PipelineJob.properties.jobs.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.ResourceConfiguration.properties.properties.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.SkuSetting.properties.tier.type__added` | added | `string` |
| `definitions.StackEnsembleSettings.properties.stackMetaLearnerKWargs.type__deleted` | deleted | `object` |
| `definitions.StringArmPaginatedResult.properties.value.items.type__deleted` | deleted | `string` |
| `definitions.SynapseSpark.properties.properties.type__deleted` | deleted | `object` |
| `definitions.VirtualMachine.type__added` | added | `object` |
| `definitions.VirtualMachineSecrets.type__added` | added | `object` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.MachineLearningServices/locations/{location}/availableQuota'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.MachineLearningServices/locations/{location}/quotaAndUsage'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems'].post.parameters[3].schema.type__added` | added | `array` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/features'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints'].get.parameters[1].type__added` | added | `string` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}'].patch.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}'].patch.responses.200.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/restart'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/start'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/stop'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/deployments/{deploymentName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/raiBlocklistItems/{raiBlocklistItemName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiPolicies/{raiPolicyName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/raiPolicies/{raiPolicyName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Registry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/CodeContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}/versions/{version}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/CodeVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ComponentContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}/versions/{version}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ComponentVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/CodeContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}/versions/{version}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/DataVersionBase` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/EnvironmentContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}/versions/{version}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/EnvironmentVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ModelContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}/versions/{version}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ModelVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/BatchEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/BatchDeployment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/CapabilityHost` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/FeaturesetContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/FeaturesetVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/FeaturestoreEntityContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/FeaturestoreEntityVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{inferencePoolName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/InferencePool` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/InferenceEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/InferenceGroup` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions/{name}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/MarketplaceSubscription` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/OnlineEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/OnlineDeployment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules/{name}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Schedule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ServerlessEndpoint` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AllFeatures.required__deleted` | deleted | `["filterType"]` |
| `definitions.AvailableQuotaArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.AzureOpenAiFineTuning.required__deleted` | deleted | `["modelProvider"]` |
| `definitions.BatchDeployment.required__added` | added | `["properties"]` |
| `definitions.BatchDeploymentTrackedResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.BatchEndpoint.required__added` | added | `["properties"]` |
| `definitions.BatchEndpointTrackedResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.CapabilityHost.required__added` | added | `["properties"]` |
| `definitions.CodeContainer.required__added` | added | `["properties"]` |
| `definitions.CodeContainerResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.CodeVersion.required__added` | added | `["properties"]` |
| `definitions.CodeVersionResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.ComponentContainer.required__added` | added | `["properties"]` |
| `definitions.ComponentContainerResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.ComponentVersion.required__added` | added | `["properties"]` |
| `definitions.ComponentVersionResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.ContentSafetyEndpointDeploymentResourceProperties.required__added` | added | `["model"]` |
| `definitions.CustomModelFineTuning.required__deleted` | deleted | `["modelProvider"]` |
| `definitions.CustomModelJobInput.required__added` | added | `["uri"]` |
| `definitions.DataContainerResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.DatastoreResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.DataVersionBaseResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.EndpointDeploymentResourcePropertiesBasicResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.EndpointModels.required__added` | added | `["value"]` |
| `definitions.EndpointResourcePropertiesBasicResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.EnvironmentContainer.required__added` | added | `["properties"]` |
| `definitions.EnvironmentContainerResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.EnvironmentVersion.required__added` | added | `["properties"]` |
| `definitions.EnvironmentVersionResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.Feature.required__added` | added | `["properties"]` |
| `definitions.FeatureResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.FeaturesetContainer.required__added` | added | `["properties"]` |
| `definitions.FeaturesetContainerResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.FeaturesetVersion.required__added` | added | `["properties"]` |
| `definitions.FeaturesetVersionResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.FeaturestoreEntityContainer.required__added` | added | `["properties"]` |
| `definitions.FeaturestoreEntityContainerResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.FeaturestoreEntityVersion.required__added` | added | `["properties"]` |
| `definitions.FeaturestoreEntityVersionResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.ImageClassification.required__added` | added | `["limitSettings"]` |
| `definitions.ImageClassificationMultilabel.required__added` | added | `["limitSettings"]` |
| `definitions.ImageInstanceSegmentation.required__added` | added | `["limitSettings"]` |
| `definitions.ImageObjectDetection.required__added` | added | `["limitSettings"]` |
| `definitions.InferenceEndpointTrackedResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.InferenceGroup.required__added` | added | `["properties"]` |
| `definitions.InferenceGroupTrackedResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.InferencePool.required__added` | added | `["properties"]` |
| `definitions.InferencePoolTrackedResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.JobBaseResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.LabelGeneration.required__deleted` | deleted | `["dataGenerationType"]` |
| `definitions.ListAmlUserFeatureResult.required__added` | added | `["value"]` |
| `definitions.ListUsagesResult.required__added` | added | `["value"]` |
| `definitions.ListWorkspaceQuotas.required__added` | added | `["value"]` |
| `definitions.ManagedNetworkListResult.required__added` | added | `["value"]` |
| `definitions.MarketplaceSubscriptionResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.MLFlowModelJobInput.required__added` | added | `["uri"]` |
| `definitions.MLTableJobInput.required__added` | added | `["uri"]` |
| `definitions.ModelContainer.required__added` | added | `["properties"]` |
| `definitions.ModelContainerResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.ModelVersion.required__added` | added | `["properties"]` |
| `definitions.ModelVersionResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.OnlineDeploymentTrackedResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.OnlineEndpoint.required__added` | added | `["properties"]` |
| `definitions.OnlineEndpointTrackedResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.OpenAIEndpointDeploymentResourceProperties.required__added` | added | `["model"]` |
| `definitions.OutboundRuleListResult.required__added` | added | `["value"]` |
| `definitions.PaginatedComputeResourcesList.required__added` | added | `["value"]` |
| `definitions.RaiBlocklistItemPropertiesBasicResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.RaiBlocklistPropertiesBasicResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.RaiPolicyPropertiesBasicResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.Registry.required__added` | added | `["properties"]` |
| `definitions.RegistryTrackedResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.ScheduleResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.ServerlessEndpointTrackedResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.SkuResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.SpeechEndpointDeploymentResourceProperties.required__added` | added | `["model"]` |
| `definitions.StringArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.TopNFeaturesByAttribution.required__deleted` | deleted | `["filterType"]` |
| `definitions.TritonModelJobInput.required__added` | added | `["uri"]` |
| `definitions.UriFileJobInput.required__added` | added | `["uri"]` |
| `definitions.UriFolderJobInput.required__added` | added | `["uri"]` |
| `definitions.UsageAndQuotaDetailsArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.WorkspaceConnectionPropertiesV2BasicResourceArmPaginatedResult.required__added` | added | `["value"]` |
| `definitions.WorkspaceListResult.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/features'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints'].get.parameters[0].required__added` | added | `true` |

### Changes for `pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].patch.parameters[3].pattern__deleted` | deleted | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].put.parameters[3].pattern__deleted` | deleted | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/features'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}'].patch.parameters[2].pattern__added` | added | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}'].patch.parameters[3].pattern__added` | added | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].patch.parameters[3].pattern__deleted` | deleted | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].put.parameters[3].pattern__deleted` | deleted | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |

### Changes for `Azure-AsyncOperation`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}'].put.responses.201.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}/versions/{version}'].put.responses.201.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}'].put.responses.201.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}/versions/{version}'].put.responses.201.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}/versions/{version}'].put.responses.201.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}'].put.responses.201.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}/versions/{version}'].put.responses.201.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |

### Changes for `x-ms-long-running-operation-options`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}'].patch['x-ms-long-running-operation-options__added']` | added | `{"final-state-via":"azure-async-operation","final-state-schema":"#/definitions/ComputeResource"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}'].put['x-ms-long-running-operation-options__added']` | added | `{"final-state-via":"azure-async-operation","final-state-schema":"#/definitions/ComputeResource"}` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccountApiKeys.properties.key1.format__added` | added | `password` |
| `definitions.AccountApiKeys.properties.key2.format__added` | added | `password` |
| `definitions.KubernetesProperties.properties.relayConnectionString.format__added` | added | `password` |
| `definitions.KubernetesProperties.properties.serviceBusConnectionString.format__added` | added | `password` |
| `definitions.ListNotebookKeysResult.properties.primaryAccessKey.format__added` | added | `password` |
| `definitions.ListNotebookKeysResult.properties.secondaryAccessKey.format__added` | added | `password` |
| `definitions.ListStorageAccountKeysResult.properties.userStorageKey.format__added` | added | `password` |
| `definitions.ListWorkspaceKeysResult.properties.appInsightsInstrumentationKey.format__added` | added | `password` |
| `definitions.ListWorkspaceKeysResult.properties.userStorageKey.format__added` | added | `password` |
| `definitions.ManagedIdentity.properties.clientId.format__deleted` | deleted | `uuid` |
| `definitions.ManagedIdentity.properties.objectId.format__deleted` | deleted | `uuid` |
| `definitions.NotebookAccessTokenResult.properties.accessToken.format__added` | added | `password` |
| `definitions.NotebookAccessTokenResult.properties.refreshToken.format__added` | added | `password` |
| `definitions.Password.properties.name.format__added` | added | `password` |
| `definitions.Password.properties.value.format__added` | added | `password` |
| `definitions.SslConfiguration.properties.cert.format__added` | added | `password` |
| `definitions.SslConfiguration.properties.key.format__added` | added | `password` |
| `definitions.UserAccountCredentials.properties.adminUserPassword.format__added` | added | `password` |
| `definitions.UserAccountCredentials.properties.adminUserSshPublicKey.format__added` | added | `password` |
| `definitions.VirtualMachineSshCredentials.properties.privateKeyData.format__added` | added | `password` |
| `definitions.VirtualMachineSshCredentials.properties.publicKeyData.format__added` | added | `password` |
| `definitions.WorkspaceConnectionOAuth2.properties.clientSecret.format__added` | added | `password` |
| `definitions.WorkspaceConnectionOAuth2.properties.developerToken.format__added` | added | `password` |
| `definitions.WorkspaceConnectionOAuth2.properties.password.format__added` | added | `password` |
| `definitions.WorkspaceConnectionOAuth2.properties.refreshToken.format__added` | added | `password` |
| `definitions.WorkspaceConnectionServicePrincipal.properties.clientSecret.format__added` | added | `password` |
| `definitions.WorkspaceConnectionUsernamePassword.properties.securityToken.format__added` | added | `password` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |

### Changes for `items`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems'].post.parameters[3].schema.items__added` | added | `{"type":"string"}` |

### Changes for `collectionFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/datastores'].get.parameters[6].collectionFormat__added` | added | `csv` |

### Changes for `AKSSchema`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AKSSchema__deleted` | deleted | `{"type":"object","properties":{"properties":{"type":"object","description":"AKS properties","propert...` |

### Changes for `AksComputeSecretsProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AksComputeSecretsProperties__deleted` | deleted | `{"type":"object","description":"Properties of AksComputeSecrets","properties":{"userKubeConfig":{"ty...` |

### Changes for `AmlComputeSchema`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmlComputeSchema__deleted` | deleted | `{"type":"object","description":"Properties(top level) of AmlCompute","properties":{"properties":{"$r...` |

### Changes for `AssetJobInput`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AssetJobInput__deleted` | deleted | `{"type":"object","description":"Asset input type.","properties":{"mode":{"type":"string","descriptio...` |

### Changes for `AssetJobOutput`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AssetJobOutput__deleted` | deleted | `{"type":"object","description":"Asset output type.","properties":{"assetName":{"type":"string","desc...` |

### Changes for `AzureDatastore`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDatastore__deleted` | deleted | `{"type":"object","description":"Base definition for Azure datastore contents configuration.","proper...` |

### Changes for `BatchDeploymentTrackedResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeploymentTrackedResource__deleted` | deleted | `{"type":"object","properties":{"identity":{"$ref":"../../../../../common-types/resource-management/v...` |

### Changes for `BatchEndpointTrackedResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchEndpointTrackedResource__deleted` | deleted | `{"type":"object","properties":{"identity":{"$ref":"../../../../../common-types/resource-management/v...` |

### Changes for `CapabilityHostResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapabilityHostResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `CapacityConfig`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapacityConfig__deleted` | deleted | `{"type":"object","description":"The capacity configuration.","properties":{"minimum":{"type":"intege...` |

### Changes for `CodeContainerResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CodeContainerResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `CodeVersionResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CodeVersionResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `CognitiveServiceEndpointDeploymentResourceProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CognitiveServiceEndpointDeploymentResourceProperties__deleted` | deleted | `{"type":"object","properties":{"model":{"$ref":"#/definitions/EndpointDeploymentModel","description"...` |

### Changes for `ComponentContainerResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComponentContainerResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `ComponentVersionResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComponentVersionResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `ComputeInstanceSchema`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComputeInstanceSchema__deleted` | deleted | `{"type":"object","description":"Properties(top level) of ComputeInstance","properties":{"properties"...` |

### Changes for `ComputeResourceSchema`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComputeResourceSchema__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/Compute","description":"Compute p...` |

### Changes for `DataContainerResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataContainerResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `DataLakeAnalyticsSchema`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataLakeAnalyticsSchema__deleted` | deleted | `{"type":"object","properties":{"properties":{"type":"object","properties":{"dataLakeStoreAccountName...` |

### Changes for `DataVersionBaseResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataVersionBaseResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `DatabricksComputeSecretsProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatabricksComputeSecretsProperties__deleted` | deleted | `{"type":"object","description":"Properties of Databricks Compute Secrets","properties":{"databricksA...` |

### Changes for `DatabricksSchema`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatabricksSchema__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/DatabricksProperties"}}}` |

### Changes for `DatastoreResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatastoreResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `EnvironmentContainerResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentContainerResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `EnvironmentVersionResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersionResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `FeatureResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeatureResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `FeaturesetContainerResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturesetContainerResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `FeaturesetVersionResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturesetVersionResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `FeaturestoreEntityContainerResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturestoreEntityContainerResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `FeaturestoreEntityVersionResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturestoreEntityVersionResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `HDInsightSchema`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HDInsightSchema__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/HDInsightProperties"}}}` |

### Changes for `ImageClassificationBase`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImageClassificationBase__deleted` | deleted | `{"type":"object","properties":{"modelSettings":{"$ref":"#/definitions/ImageModelSettingsClassificati...` |

### Changes for `ImageObjectDetectionBase`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImageObjectDetectionBase__deleted` | deleted | `{"type":"object","properties":{"modelSettings":{"$ref":"#/definitions/ImageModelSettingsObjectDetect...` |

### Changes for `ImageVertical`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImageVertical__deleted` | deleted | `{"type":"object","description":"Abstract class for AutoML tasks that train image (computer vision) m...` |

### Changes for `InferenceEndpointTrackedResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceEndpointTrackedResource__deleted` | deleted | `{"type":"object","properties":{"identity":{"$ref":"../../../../../common-types/resource-management/v...` |

### Changes for `InferenceGroupTrackedResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceGroupTrackedResource__deleted` | deleted | `{"type":"object","properties":{"identity":{"$ref":"../../../../../common-types/resource-management/v...` |

### Changes for `InferencePoolTrackedResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferencePoolTrackedResource__deleted` | deleted | `{"type":"object","properties":{"identity":{"$ref":"../../../../../common-types/resource-management/v...` |

### Changes for `InstanceResourceSchema`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InstanceResourceSchema__deleted` | deleted | `{"type":"object","description":"Resource requests/limits for this instance type","additionalProperti...` |

### Changes for `JobBaseResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBaseResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `KubernetesSchema`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.KubernetesSchema__deleted` | deleted | `{"type":"object","description":"Kubernetes Compute Schema","properties":{"properties":{"$ref":"#/def...` |

### Changes for `MarketplaceSubscriptionResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MarketplaceSubscriptionResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `ModelContainerResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelContainerResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `ModelVersionResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelVersionResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `NlpVertical`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NlpVertical__deleted` | deleted | `{"type":"object","description":"Abstract class for NLP related AutoML tasks.\\r\\nNLP - Natural Langua...` |

### Changes for `OnlineDeploymentTrackedResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeploymentTrackedResource__deleted` | deleted | `{"type":"object","properties":{"identity":{"$ref":"../../../../../common-types/resource-management/v...` |

### Changes for `OnlineEndpointTrackedResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineEndpointTrackedResource__deleted` | deleted | `{"type":"object","properties":{"identity":{"$ref":"../../../../../common-types/resource-management/v...` |

### Changes for `PartialRegistry`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PartialRegistry__deleted` | deleted | `{"type":"object","description":"Partial Registry class for PATCH"}` |

### Changes for `PartialUserAssignedIdentity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PartialUserAssignedIdentity__deleted` | deleted | `{"type":"object"}` |

### Changes for `RaiBlocklistItemsBulkDeleteRequest`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RaiBlocklistItemsBulkDeleteRequest__deleted` | deleted | `{"type":"object","description":"The list of Cognitive Services RaiBlocklist Items Names.","items":{"...` |

### Changes for `RegistryTrackedResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RegistryTrackedResource__deleted` | deleted | `{"type":"object","properties":{"identity":{"$ref":"../../../../../common-types/resource-management/v...` |

### Changes for `ScheduleResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScheduleResource__deleted` | deleted | `{"type":"object","description":"Azure Resource Manager resource envelope.","properties":{"properties...` |

### Changes for `ServerlessEndpointTrackedResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerlessEndpointTrackedResource__deleted` | deleted | `{"type":"object","properties":{"identity":{"$ref":"../../../../../common-types/resource-management/v...` |

### Changes for `TableVertical`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TableVertical__deleted` | deleted | `{"type":"object","description":"Abstract class for AutoML tasks that use table dataset as input - su...` |

### Changes for `VirtualMachineSchema`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualMachineSchema__deleted` | deleted | `{"type":"object","properties":{"properties":{"type":"object","properties":{"virtualMachineSize":{"ty...` |

### Changes for `VirtualMachineSecretsSchema`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualMachineSecretsSchema__deleted` | deleted | `{"type":"object","properties":{"administratorAccount":{"$ref":"#/definitions/VirtualMachineSshCreden...` |

### Changes for `AKSSchemaProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AKSSchemaProperties__added` | added | `{"type":"object","description":"AKS properties","properties":{"clusterFqdn":{"type":"string","descri...` |

### Changes for `BatchDeploymentProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeploymentProperties__added` | added | `{"type":"object","description":"Batch inference settings per deployment.","properties":{"compute":{"...` |

### Changes for `BatchEndpointProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchEndpointProperties__added` | added | `{"type":"object","description":"Batch endpoint configuration.","properties":{"defaults":{"$ref":"#/d...` |

### Changes for `CapabilityHostProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapabilityHostProperties__added` | added | `{"type":"object","properties":{"aiServicesConnections":{"type":"array","description":"List of AI ser...` |

### Changes for `CodeContainerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CodeContainerProperties__added` | added | `{"type":"object","description":"Container for code asset versions.","properties":{"provisioningState...` |

### Changes for `CodeVersionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CodeVersionProperties__added` | added | `{"type":"object","description":"Code asset version details.","properties":{"codeUri":{"type":"string...` |

### Changes for `ComponentContainerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComponentContainerProperties__added` | added | `{"type":"object","description":"Component container definition.\\n<see href=\\"https://docs.microsoft....` |

### Changes for `ComponentVersionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComponentVersionProperties__added` | added | `{"type":"object","description":"Definition of a component version: defines resources that span compo...` |

### Changes for `DataContainerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataContainerProperties__added` | added | `{"type":"object","description":"Container for data asset versions.","properties":{"dataType":{"type"...` |

### Changes for `DataLakeAnalyticsSchemaProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataLakeAnalyticsSchemaProperties__added` | added | `{"type":"object","properties":{"dataLakeStoreAccountName":{"type":"string","description":"DataLake S...` |

### Changes for `DataVersionBaseProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataVersionBaseProperties__added` | added | `{"type":"object","description":"Data version base definition","properties":{"dataType":{"type":"stri...` |

### Changes for `DatastoreProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatastoreProperties__added` | added | `{"type":"object","description":"Base definition for datastore contents configuration.","properties":...` |

### Changes for `DiagnoseResponseResultValue`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DiagnoseResponseResultValue__added` | added | `{"type":"object","properties":{"userDefinedRouteResults":{"type":"array","items":{"$ref":"#/definiti...` |

### Changes for `EnvironmentContainerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentContainerProperties__added` | added | `{"type":"object","description":"Container for environment specification versions.","properties":{"pr...` |

### Changes for `EnvironmentVersionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersionProperties__added` | added | `{"type":"object","description":"Environment version details.","properties":{"autoRebuild":{"type":"s...` |

### Changes for `FeatureProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeatureProperties__added` | added | `{"type":"object","description":"DTO object representing feature","properties":{"dataType":{"type":"s...` |

### Changes for `FeaturesetContainerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturesetContainerProperties__added` | added | `{"type":"object","description":"DTO object representing feature set","properties":{"provisioningStat...` |

### Changes for `FeaturesetVersionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturesetVersionProperties__added` | added | `{"type":"object","description":"DTO object representing feature set version","properties":{"entities...` |

### Changes for `FeaturestoreEntityContainerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturestoreEntityContainerProperties__added` | added | `{"type":"object","description":"DTO object representing feature entity","properties":{"provisioningS...` |

### Changes for `FeaturestoreEntityVersionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturestoreEntityVersionProperties__added` | added | `{"type":"object","description":"DTO object representing feature entity version","properties":{"index...` |

### Changes for `InferenceEndpointProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceEndpointProperties__added` | added | `{"type":"object","description":"InferenceEndpoint configuration","properties":{"authMode":{"type":"s...` |

### Changes for `InferenceGroupProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceGroupProperties__added` | added | `{"type":"object","description":"Inference group configuration","properties":{"environmentConfigurati...` |

### Changes for `InferencePoolProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferencePoolProperties__added` | added | `{"type":"object","description":"Inference pool configuration","properties":{"provisioningState":{"ty...` |

### Changes for `InstanceTypeSchemaResources`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InstanceTypeSchemaResources__added` | added | `{"type":"object","description":"Resource requests/limits for this instance type","properties":{"requ...` |

### Changes for `JobBaseProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBaseProperties__added` | added | `{"type":"object","description":"Base definition for a job.","properties":{"componentId":{"type":"str...` |

### Changes for `MarketplaceSubscriptionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MarketplaceSubscriptionProperties__added` | added | `{"type":"object","properties":{"marketplacePlan":{"$ref":"#/definitions/MarketplacePlan","descriptio...` |

### Changes for `ModelContainerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelContainerProperties__added` | added | `{"type":"object","properties":{"provisioningState":{"type":"string","description":"Provisioning stat...` |

### Changes for `ModelVersionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelVersionProperties__added` | added | `{"type":"object","description":"Model asset version details.","properties":{"flavors":{"type":"objec...` |

### Changes for `OnlineDeploymentProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeploymentProperties__added` | added | `{"type":"object","properties":{"appInsightsEnabled":{"type":"boolean","description":"If true, enable...` |

### Changes for `OnlineEndpointProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineEndpointProperties__added` | added | `{"type":"object","description":"Online endpoint configuration","properties":{"compute":{"type":"stri...` |

### Changes for `RegistryProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RegistryProperties__added` | added | `{"type":"object","description":"Details of the Registry","properties":{"discoveryUrl":{"type":"strin...` |

### Changes for `ScheduleProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScheduleProperties__added` | added | `{"type":"object","description":"Base definition of a schedule","properties":{"action":{"$ref":"#/def...` |

### Changes for `ServerlessEndpointProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerlessEndpointProperties__added` | added | `{"type":"object","properties":{"authMode":{"type":"string","description":"[Required] Specifies the a...` |

### Changes for `Stringforlist`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Stringforlist__added` | added | `{"type":"object","properties":{"string":{"type":"string"}}}` |

### Changes for `SynapseSparkProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SynapseSparkProperties__added` | added | `{"type":"object","properties":{"autoScaleProperties":{"$ref":"#/definitions/AutoScaleProperties","de...` |

### Changes for `VirtualMachineSchemaProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualMachineSchemaProperties__added` | added | `{"type":"object","properties":{"virtualMachineSize":{"type":"string","description":"Virtual Machine ...` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AKS.properties__added` | added | `{"properties":{"$ref":"#/definitions/AKSSchemaProperties","description":"AKS properties"}}` |
| `definitions.AksComputeSecrets.properties__added` | added | `{"userKubeConfig":{"type":"string","description":"Content of kubeconfig file that can be used to con...` |
| `definitions.AmlCompute.properties__added` | added | `{"properties":{"$ref":"#/definitions/AmlComputeProperties","description":"Properties of AmlCompute"}...` |
| `definitions.BatchDeployment.properties.properties__added` | added | `{"$ref":"#/definitions/BatchDeploymentProperties","description":"[Required] Additional attributes of...` |
| `definitions.BatchEndpoint.properties.properties__added` | added | `{"$ref":"#/definitions/BatchEndpointProperties","description":"[Required] Additional attributes of t...` |
| `definitions.CapabilityHost.properties.properties__added` | added | `{"$ref":"#/definitions/CapabilityHostProperties","description":"[Required] Additional attributes of ...` |
| `definitions.CodeContainer.properties.properties__added` | added | `{"$ref":"#/definitions/CodeContainerProperties","description":"[Required] Additional attributes of t...` |
| `definitions.CodeVersion.properties.properties__added` | added | `{"$ref":"#/definitions/CodeVersionProperties","description":"[Required] Additional attributes of the...` |
| `definitions.ComponentContainer.properties.properties__added` | added | `{"$ref":"#/definitions/ComponentContainerProperties","description":"[Required] Additional attributes...` |
| `definitions.ComponentVersion.properties.properties__added` | added | `{"$ref":"#/definitions/ComponentVersionProperties","description":"[Required] Additional attributes o...` |
| `definitions.ComputeInstance.properties__added` | added | `{"properties":{"$ref":"#/definitions/ComputeInstanceProperties","description":"Properties of Compute...` |
| `definitions.ComputeResource.properties.properties__added` | added | `{"$ref":"#/definitions/Compute","description":"The resource-specific properties for this resource."}` |
| `definitions.ContentSafetyEndpointDeploymentResourceProperties.properties__added` | added | `{"model":{"$ref":"#/definitions/EndpointDeploymentModel","description":"Model used for the endpoint ...` |
| `definitions.CustomModelJobInput.properties__added` | added | `{"mode":{"type":"string","description":"Enum to determine the input data delivery mode.","default":"...` |
| `definitions.CustomModelJobOutput.properties__added` | added | `{"assetName":{"type":"string","description":"Output Asset Name.","x-nullable":true},"mode":{"type":"...` |
| `definitions.Databricks.properties__added` | added | `{"properties":{"$ref":"#/definitions/DatabricksProperties"}}` |
| `definitions.DatabricksComputeSecrets.properties__added` | added | `{"databricksAccessToken":{"type":"string","description":"access token for databricks account."}}` |
| `definitions.DataContainer.properties.properties__added` | added | `{"$ref":"#/definitions/DataContainerProperties","description":"[Required] Additional attributes of t...` |
| `definitions.DataLakeAnalytics.properties__added` | added | `{"properties":{"$ref":"#/definitions/DataLakeAnalyticsSchemaProperties"}}` |
| `definitions.Datastore.properties.properties__added` | added | `{"$ref":"#/definitions/DatastoreProperties","description":"[Required] Additional attributes of the e...` |
| `definitions.DataVersionBase.properties.properties__added` | added | `{"$ref":"#/definitions/DataVersionBaseProperties","description":"[Required] Additional attributes of...` |
| `definitions.DiagnoseResponseResult.properties.value.properties__deleted` | deleted | `{"userDefinedRouteResults":{"type":"array","items":{"$ref":"#/definitions/DiagnoseResult"},"x-ms-ide...` |
| `definitions.EnvironmentContainer.properties.properties__added` | added | `{"$ref":"#/definitions/EnvironmentContainerProperties","description":"[Required] Additional attribut...` |
| `definitions.EnvironmentVersion.properties.properties__added` | added | `{"$ref":"#/definitions/EnvironmentVersionProperties","description":"[Required] Additional attributes...` |
| `definitions.Feature.properties.properties__added` | added | `{"$ref":"#/definitions/FeatureProperties","description":"[Required] Additional attributes of the ent...` |
| `definitions.FeaturesetContainer.properties.properties__added` | added | `{"$ref":"#/definitions/FeaturesetContainerProperties","description":"[Required] Additional attribute...` |
| `definitions.FeaturesetVersion.properties.properties__added` | added | `{"$ref":"#/definitions/FeaturesetVersionProperties","description":"[Required] Additional attributes ...` |
| `definitions.FeaturestoreEntityContainer.properties.properties__added` | added | `{"$ref":"#/definitions/FeaturestoreEntityContainerProperties","description":"[Required] Additional a...` |
| `definitions.FeaturestoreEntityVersion.properties.properties__added` | added | `{"$ref":"#/definitions/FeaturestoreEntityVersionProperties","description":"[Required] Additional att...` |
| `definitions.HDInsight.properties__added` | added | `{"properties":{"$ref":"#/definitions/HDInsightProperties"}}` |
| `definitions.InferenceEndpoint.properties.properties__added` | added | `{"$ref":"#/definitions/InferenceEndpointProperties","description":"[Required] Additional attributes ...` |
| `definitions.InferenceGroup.properties.properties__added` | added | `{"$ref":"#/definitions/InferenceGroupProperties","description":"[Required] Additional attributes of ...` |
| `definitions.InferencePool.properties.properties__added` | added | `{"$ref":"#/definitions/InferencePoolProperties","description":"[Required] Additional attributes of t...` |
| `definitions.InstanceTypeSchema.properties.resources.properties__deleted` | deleted | `{"requests":{"$ref":"#/definitions/InstanceResourceSchema","description":"Resource requests for this...` |
| `definitions.JobBase.properties.properties__added` | added | `{"$ref":"#/definitions/JobBaseProperties","description":"[Required] Additional attributes of the ent...` |
| `definitions.Kubernetes.properties__added` | added | `{"properties":{"$ref":"#/definitions/KubernetesProperties","description":"Properties of Kubernetes"}...` |
| `definitions.MarketplaceSubscription.properties.properties__added` | added | `{"$ref":"#/definitions/MarketplaceSubscriptionProperties","description":"[Required] Additional attri...` |
| `definitions.MLFlowModelJobInput.properties__added` | added | `{"mode":{"type":"string","description":"Enum to determine the input data delivery mode.","default":"...` |
| `definitions.MLFlowModelJobOutput.properties__added` | added | `{"assetName":{"type":"string","description":"Output Asset Name.","x-nullable":true},"mode":{"type":"...` |
| `definitions.MLTableJobInput.properties__added` | added | `{"mode":{"type":"string","description":"Enum to determine the input data delivery mode.","default":"...` |
| `definitions.MLTableJobOutput.properties__added` | added | `{"assetName":{"type":"string","description":"Output Asset Name.","x-nullable":true},"mode":{"type":"...` |
| `definitions.ModelContainer.properties.properties__added` | added | `{"$ref":"#/definitions/ModelContainerProperties","description":"[Required] Additional attributes of ...` |
| `definitions.ModelVersion.properties.properties__added` | added | `{"$ref":"#/definitions/ModelVersionProperties","description":"[Required] Additional attributes of th...` |
| `definitions.OnlineDeployment.properties.properties__added` | added | `{"$ref":"#/definitions/OnlineDeploymentProperties","description":"[Required] Additional attributes o...` |
| `definitions.OnlineEndpoint.properties.properties__added` | added | `{"$ref":"#/definitions/OnlineEndpointProperties","description":"[Required] Additional attributes of ...` |
| `definitions.OpenAIEndpointDeploymentResourceProperties.properties__added` | added | `{"model":{"$ref":"#/definitions/EndpointDeploymentModel","description":"Model used for the endpoint ...` |
| `definitions.Registry.properties.properties__added` | added | `{"$ref":"#/definitions/RegistryProperties","description":"[Required] Additional attributes of the en...` |
| `definitions.Schedule.properties.properties__added` | added | `{"$ref":"#/definitions/ScheduleProperties","description":"[Required] Additional attributes of the en...` |
| `definitions.ServerlessEndpoint.properties.properties__added` | added | `{"$ref":"#/definitions/ServerlessEndpointProperties","description":"[Required] Additional attributes...` |
| `definitions.SpeechEndpointDeploymentResourceProperties.properties__added` | added | `{"model":{"$ref":"#/definitions/EndpointDeploymentModel","description":"Model used for the endpoint ...` |
| `definitions.SynapseSpark.properties.properties.properties__deleted` | deleted | `{"autoScaleProperties":{"$ref":"#/definitions/AutoScaleProperties","description":"Auto scale propert...` |
| `definitions.TritonModelJobInput.properties__added` | added | `{"mode":{"type":"string","description":"Enum to determine the input data delivery mode.","default":"...` |
| `definitions.TritonModelJobOutput.properties__added` | added | `{"assetName":{"type":"string","description":"Output Asset Name.","x-nullable":true},"mode":{"type":"...` |
| `definitions.UriFileJobInput.properties__added` | added | `{"mode":{"type":"string","description":"Enum to determine the input data delivery mode.","default":"...` |
| `definitions.UriFileJobOutput.properties__added` | added | `{"assetName":{"type":"string","description":"Output Asset Name.","x-nullable":true},"mode":{"type":"...` |
| `definitions.UriFolderJobInput.properties__added` | added | `{"mode":{"type":"string","description":"Enum to determine the input data delivery mode.","default":"...` |
| `definitions.UriFolderJobOutput.properties__added` | added | `{"assetName":{"type":"string","description":"Output Asset Name.","x-nullable":true},"mode":{"type":"...` |
| `definitions.VirtualMachine.properties__added` | added | `{"properties":{"$ref":"#/definitions/VirtualMachineSchemaProperties"}}` |
| `definitions.VirtualMachineSecrets.properties__added` | added | `{"administratorAccount":{"$ref":"#/definitions/VirtualMachineSshCredentials","description":"Admin cr...` |

### Changes for `x-ms-secret`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccountKeyDatastoreCredentials.properties.secrets['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.CertificateDatastoreCredentials.properties.secrets['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.EndpointKeys.properties.keys['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.EndpointPropertiesBase.properties.keys['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.SasDatastoreCredentials.properties.secrets['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.ServicePrincipalDatastoreCredentials.properties.secrets['x-ms-secret__deleted']` | deleted | `true` |

### Changes for `x-ms-mutability`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AssetContainer.properties.latestVersion['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.AssetContainer.properties.nextVersion['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.CommandJob.properties.parameters['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DiagnoseResult.properties.code['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DiagnoseResult.properties.level['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DiagnoseResult.properties.message['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.EndpointDeploymentResourceProperties.properties.provisioningState['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.EndpointPropertiesBase.properties.scoringUri['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.EndpointPropertiesBase.properties.swaggerUri['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.EndpointResourceProperties.properties.provisioningState['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.JobService.properties.errorMessage['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.JobService.properties.status['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.ListNotebookKeysResult.properties.primaryAccessKey['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.ListNotebookKeysResult.properties.secondaryAccessKey['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.ListStorageAccountKeysResult.properties.userStorageKey['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.ListWorkspaceKeysResult.properties.appInsightsInstrumentationKey['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.ListWorkspaceKeysResult.properties.userStorageArmId['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.ListWorkspaceKeysResult.properties.userStorageKey['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.ManagedNetworkSettingsProperties.properties.provisioningState['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.MarketplacePlan.properties.offerId['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.MarketplacePlan.properties.planId['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.MarketplacePlan.properties.publisherId['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.NotebookAccessTokenResult.properties.accessToken['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.NotebookAccessTokenResult.properties.expiresIn['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.NotebookAccessTokenResult.properties.hostName['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.NotebookAccessTokenResult.properties.notebookResourceId['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.NotebookAccessTokenResult.properties.publicDns['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.NotebookAccessTokenResult.properties.refreshToken['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.NotebookAccessTokenResult.properties.scope['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.NotebookAccessTokenResult.properties.tokenType['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.OutboundRule.properties.errorInformation['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.OutboundRule.properties.parentRuleNames['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.Password.properties.name['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.Password.properties.value['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.RegistryListCredentialsResult.properties.location['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.RegistryListCredentialsResult.properties.username['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.ServerlessEndpointInferenceEndpoint.properties.headers['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.ServerlessEndpointInferenceEndpoint.properties.uri['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.ServerlessInferenceEndpoint.properties.headers['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.ServerlessInferenceEndpoint.properties.uri['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.SkuResource.properties.resourceType['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.WorkspacePrivateEndpointResource.properties.id['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.WorkspacePrivateEndpointResource.properties.subnetArmId['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.WorkspaceProperties.properties.agentsEndpointUri['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.WorkspaceProperties.properties.mlFlowTrackingUri['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.WorkspaceProperties.properties.notebookInfo['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.WorkspaceProperties.properties.privateEndpointConnections['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.WorkspaceProperties.properties.privateLinkCount['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.WorkspaceProperties.properties.provisioningState['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.WorkspaceProperties.properties.serviceProvisionedResourceGroup['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.WorkspaceProperties.properties.storageHnsEnabled['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.WorkspaceProperties.properties.tenantId['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.WorkspaceProperties.properties.workspaceId['x-ms-mutability__deleted']` | deleted | `["read"]` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AutoMLJob.properties.resources.default__deleted` | deleted | `{}` |
| `definitions.CommandJob.properties.resources.default__deleted` | deleted | `{}` |
| `definitions.DistillationJob.properties.resources.default__deleted` | deleted | `{}` |
| `definitions.FineTuningJob.properties.resources.default__deleted` | deleted | `{}` |
| `definitions.ForecastingSettings.properties.forecastHorizon.default__deleted` | deleted | `{"Mode": "Custom", "Value": 1}` |
| `definitions.ForecastingSettings.properties.seasonality.default__deleted` | deleted | `{"Mode": "Auto"}` |
| `definitions.SweepJob.properties.limits.default__deleted` | deleted | `{}` |
| `definitions.TrialComponent.properties.resources.default__deleted` | deleted | `{}` |

### Changes for `resourceGroup`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobDatastore.properties.resourceGroup__added` | added | `{"type":"string","description":"Azure Resource Group name","x-nullable":true}` |
| `definitions.AzureDataLakeGen1Datastore.properties.resourceGroup__added` | added | `{"type":"string","description":"Azure Resource Group name","x-nullable":true}` |
| `definitions.AzureDataLakeGen2Datastore.properties.resourceGroup__added` | added | `{"type":"string","description":"Azure Resource Group name","x-nullable":true}` |
| `definitions.AzureFileDatastore.properties.resourceGroup__added` | added | `{"type":"string","description":"Azure Resource Group name","x-nullable":true}` |

### Changes for `subscriptionId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobDatastore.properties.subscriptionId__added` | added | `{"type":"string","description":"Azure Subscription Id","x-nullable":true}` |
| `definitions.AzureDataLakeGen1Datastore.properties.subscriptionId__added` | added | `{"type":"string","description":"Azure Subscription Id","x-nullable":true}` |
| `definitions.AzureDataLakeGen2Datastore.properties.subscriptionId__added` | added | `{"type":"string","description":"Azure Subscription Id","x-nullable":true}` |
| `definitions.AzureFileDatastore.properties.subscriptionId__added` | added | `{"type":"string","description":"Azure Subscription Id","x-nullable":true}` |

### Changes for `example`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobDatastore.properties.endpoint.example__deleted` | deleted | `core.windows.net` |
| `definitions.AzureBlobDatastore.properties.protocol.example__deleted` | deleted | `https` |
| `definitions.AzureDataLakeGen2Datastore.properties.endpoint.example__deleted` | deleted | `core.windows.net` |
| `definitions.AzureDataLakeGen2Datastore.properties.protocol.example__deleted` | deleted | `https` |
| `definitions.AzureFileDatastore.properties.endpoint.example__deleted` | deleted | `core.windows.net` |
| `definitions.AzureFileDatastore.properties.protocol.example__deleted` | deleted | `https` |
| `definitions.BuildContext.properties.contextUri.example__deleted` | deleted | `https://storage-account.blob.core.windows.net/azureml/DockerBuildContext/95ddede6b9b8c4e90472db3acd0a8d28/` |
| `definitions.BuildContext.properties.dockerfilePath.example__deleted` | deleted | `prod/Dockerfile` |
| `definitions.ContainerResourceSettings.properties.cpu.example__deleted` | deleted | `1` |
| `definitions.ContainerResourceSettings.properties.gpu.example__deleted` | deleted | `1` |
| `definitions.ContainerResourceSettings.properties.memory.example__deleted` | deleted | `2Gi` |
| `definitions.EndpointScheduleAction.properties.endpointInvocationDefinition.example__deleted` | deleted | `{"endpoint":"azureml:/subscriptions/00000000-1111-2222-3333-444444444444/resourceGroups/resourceGrou...` |
| `definitions.ImageModelDistributionSettings.properties.amsGradient.example__deleted` | deleted | `choice(true, false)` |
| `definitions.ImageModelDistributionSettings.properties.augmentations.example__deleted` | deleted | `choice('hflip;mosaic;random_crop', 'mosaic')` |
| `definitions.ImageModelDistributionSettings.properties.beta1.example__deleted` | deleted | `uniform(0, 1)` |
| `definitions.ImageModelDistributionSettings.properties.beta2.example__deleted` | deleted | `uniform(0, 1)` |
| `definitions.ImageModelDistributionSettings.properties.distributed.example__deleted` | deleted | `choice(true, false)` |
| `definitions.ImageModelDistributionSettings.properties.earlyStopping.example__deleted` | deleted | `choice(true, false)` |
| `definitions.ImageModelDistributionSettings.properties.earlyStoppingDelay.example__deleted` | deleted | `choice(1, 5)` |
| `definitions.ImageModelDistributionSettings.properties.earlyStoppingPatience.example__deleted` | deleted | `choice(1, 5)` |
| `definitions.ImageModelDistributionSettings.properties.enableOnnxNormalization.example__deleted` | deleted | `choice(true, false)` |
| `definitions.ImageModelDistributionSettings.properties.evaluationFrequency.example__deleted` | deleted | `choice(1, 5)` |
| `definitions.ImageModelDistributionSettings.properties.gradientAccumulationStep.example__deleted` | deleted | `choice(1, 5)` |
| `definitions.ImageModelDistributionSettings.properties.layersToFreeze.example__deleted` | deleted | `choice(1, 2)` |
| `definitions.ImageModelDistributionSettings.properties.learningRate.example__deleted` | deleted | `uniform(0.0005, 0.005)` |
| `definitions.ImageModelDistributionSettings.properties.learningRateScheduler.example__deleted` | deleted | `choice('warmup_cosine', 'step')` |
| `definitions.ImageModelDistributionSettings.properties.modelName.example__deleted` | deleted | `choice('seresnext', 'resnest50')` |
| `definitions.ImageModelDistributionSettings.properties.momentum.example__deleted` | deleted | `quniform(0, 1)` |
| `definitions.ImageModelDistributionSettings.properties.nesterov.example__deleted` | deleted | `choice(true, false)` |
| `definitions.ImageModelDistributionSettings.properties.numberOfEpochs.example__deleted` | deleted | `choice(15, 30)` |
| `definitions.ImageModelDistributionSettings.properties.numberOfWorkers.example__deleted` | deleted | `uniform(8, 16)` |
| `definitions.ImageModelDistributionSettings.properties.optimizer.example__deleted` | deleted | `choice('sgd', 'adam', 'adamw')` |
| `definitions.ImageModelDistributionSettings.properties.randomSeed.example__deleted` | deleted | `loguniform(0, 1)` |
| `definitions.ImageModelDistributionSettings.properties.stepLRGamma.example__deleted` | deleted | `choice(0.1, 0.2, 0.25)` |
| `definitions.ImageModelDistributionSettings.properties.stepLRStepSize.example__deleted` | deleted | `choice(1, 2, 3)` |
| `definitions.ImageModelDistributionSettings.properties.trainingBatchSize.example__deleted` | deleted | `choice(1, 2, 3)` |
| `definitions.ImageModelDistributionSettings.properties.validationBatchSize.example__deleted` | deleted | `choice(1, 2, 3)` |
| `definitions.ImageModelDistributionSettings.properties.warmupCosineLRCycles.example__deleted` | deleted | `uniform(0, 1)` |
| `definitions.ImageModelDistributionSettings.properties.warmupCosineLRWarmupEpochs.example__deleted` | deleted | `choice(1, 2, 3)` |
| `definitions.ImageModelDistributionSettings.properties.weightDecay.example__deleted` | deleted | `uniform(0, 1)` |
| `definitions.ImageModelDistributionSettingsClassification.properties.trainingCropSize.example__deleted` | deleted | `choice(224, 360)` |
| `definitions.ImageModelDistributionSettingsClassification.properties.validationCropSize.example__deleted` | deleted | `choice(224, 360)` |
| `definitions.ImageModelDistributionSettingsClassification.properties.validationResizeSize.example__deleted` | deleted | `choice(128, 256)` |
| `definitions.ImageModelDistributionSettingsClassification.properties.weightedLoss.example__deleted` | deleted | `choice(0, 1, 2)` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.boxDetectionsPerImage.example__deleted` | deleted | `choice(50, 100)` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.boxScoreThreshold.example__deleted` | deleted | `uniform(0.1, 0.2)` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.imageSize.example__deleted` | deleted | `choice(224, 640)` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.maxSize.example__deleted` | deleted | `choice(640, 1333)` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.minSize.example__deleted` | deleted | `choice(300, 600)` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.modelSize.example__deleted` | deleted | `choice('small', 'medium', 'large', 'xlarge')` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.multiScale.example__deleted` | deleted | `choice(true, false)` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.nmsIouThreshold.example__deleted` | deleted | `uniform(0.1, 0.2)` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.tileGridSize.example__deleted` | deleted | `choice('3x2', '2x2')` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.tileOverlapRatio.example__deleted` | deleted | `uniform(0.1, 0.2)` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.tilePredictionsNmsThreshold.example__deleted` | deleted | `uniform(0.2, 0.3)` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.validationIouThreshold.example__deleted` | deleted | `uniform(0.2, 0.3)` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.validationMetricType.example__deleted` | deleted | `choice('none', 'coco', 'voc', 'coco_voc')` |
| `definitions.ImageModelSettings.properties.advancedSettings.example__deleted` | deleted | `key1:val1;key2;key3:val3;key4` |
| `definitions.ImageModelSettings.properties.augmentations.example__deleted` | deleted | `hflip;mosaic;random_crop` |
| `definitions.ImageModelSettingsObjectDetection.properties.tileGridSize.example__deleted` | deleted | `3x2` |
| `definitions.OneLakeDatastore.properties.endpoint.example__deleted` | deleted | `data.microsoft.com` |
| `definitions.RegenerateEndpointKeysRequest.properties.keyType.example__deleted` | deleted | `Primary` |
| `definitions.SparkJob.properties.args.example__deleted` | deleted | ` --input abfss://blob-container@testgen2.dfs.core.windows.net/mltable` |
| `definitions.SparkJob.properties.conf.example__deleted` | deleted | `[{"spark.driver.memory":"2g"}]` |
| `definitions.SparkJobPythonEntry.properties.file.example__deleted` | deleted | `train.py` |
| `definitions.SparkJobScalaEntry.properties.className.example__deleted` | deleted | `microsoft.aml.sample.myapp` |

### Changes for `x-ms-client-name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment['x-ms-client-name__deleted']` | deleted | `BatchDeploymentProperties` |
| `definitions.BatchEndpoint['x-ms-client-name__deleted']` | deleted | `BatchEndpointProperties` |
| `definitions.CapabilityHost['x-ms-client-name__deleted']` | deleted | `CapabilityHostProperties` |
| `definitions.CodeContainer['x-ms-client-name__deleted']` | deleted | `CodeContainerProperties` |
| `definitions.CodeVersion['x-ms-client-name__deleted']` | deleted | `CodeVersionProperties` |
| `definitions.ComponentContainer['x-ms-client-name__deleted']` | deleted | `ComponentContainerProperties` |
| `definitions.ComponentVersion['x-ms-client-name__deleted']` | deleted | `ComponentVersionProperties` |
| `definitions.DataContainer['x-ms-client-name__deleted']` | deleted | `DataContainerProperties` |
| `definitions.Datastore['x-ms-client-name__deleted']` | deleted | `DatastoreProperties` |
| `definitions.DataVersionBase['x-ms-client-name__deleted']` | deleted | `DataVersionBaseProperties` |
| `definitions.EnvironmentContainer['x-ms-client-name__deleted']` | deleted | `EnvironmentContainerProperties` |
| `definitions.EnvironmentVersion['x-ms-client-name__deleted']` | deleted | `EnvironmentVersionProperties` |
| `definitions.Feature['x-ms-client-name__deleted']` | deleted | `FeatureProperties` |
| `definitions.FeaturesetContainer['x-ms-client-name__deleted']` | deleted | `FeaturesetContainerProperties` |
| `definitions.FeaturesetVersion['x-ms-client-name__deleted']` | deleted | `FeaturesetVersionProperties` |
| `definitions.FeaturestoreEntityContainer['x-ms-client-name__deleted']` | deleted | `FeaturestoreEntityContainerProperties` |
| `definitions.FeaturestoreEntityVersion['x-ms-client-name__deleted']` | deleted | `FeaturestoreEntityVersionProperties` |
| `definitions.InferenceEndpoint['x-ms-client-name__deleted']` | deleted | `InferenceEndpointProperties` |
| `definitions.InferenceGroup['x-ms-client-name__deleted']` | deleted | `InferenceGroupProperties` |
| `definitions.InferencePool['x-ms-client-name__deleted']` | deleted | `InferencePoolProperties` |
| `definitions.JobBase['x-ms-client-name__deleted']` | deleted | `JobBaseProperties` |
| `definitions.MarketplaceSubscription['x-ms-client-name__deleted']` | deleted | `MarketplaceSubscriptionProperties` |
| `definitions.ModelContainer['x-ms-client-name__deleted']` | deleted | `ModelContainerProperties` |
| `definitions.ModelVersion['x-ms-client-name__deleted']` | deleted | `ModelVersionProperties` |
| `definitions.OnlineDeployment['x-ms-client-name__deleted']` | deleted | `OnlineDeploymentProperties` |
| `definitions.OnlineEndpoint['x-ms-client-name__deleted']` | deleted | `OnlineEndpointProperties` |
| `definitions.Registry['x-ms-client-name__deleted']` | deleted | `RegistryProperties` |
| `definitions.Schedule['x-ms-client-name__deleted']` | deleted | `ScheduleProperties` |
| `definitions.ServerlessEndpoint['x-ms-client-name__deleted']` | deleted | `ServerlessEndpointProperties` |

### Changes for `compute`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.compute__deleted` | deleted | `{"type":"string","description":"Compute target for batch inference operation.","x-nullable":true}` |
| `definitions.OnlineEndpoint.properties.compute__deleted` | deleted | `{"type":"string","description":"ARM resource ID of the compute if it exists.\\r\\noptional","x-nullabl...` |

### Changes for `deploymentConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.deploymentConfiguration__deleted` | deleted | `{"$ref":"#/definitions/BatchDeploymentConfiguration","description":"Properties relevant to different...` |

### Changes for `errorThreshold`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.errorThreshold__deleted` | deleted | `{"type":"integer","format":"int32","description":"Error threshold, if the error count for the entire...` |

### Changes for `loggingLevel`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.loggingLevel__deleted` | deleted | `{"type":"string","description":"Log verbosity for batch inferencing.\\r\\nIncreasing verbosity order f...` |

### Changes for `maxConcurrencyPerInstance`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.maxConcurrencyPerInstance__deleted` | deleted | `{"type":"integer","format":"int32","description":"Indicates maximum number of parallelism per instan...` |

### Changes for `miniBatchSize`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.miniBatchSize__deleted` | deleted | `{"type":"integer","format":"int64","description":"Size of the mini-batch passed to each batch invoca...` |

### Changes for `model`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.model__deleted` | deleted | `{"$ref":"#/definitions/AssetReferenceBase","description":"Reference to the model asset for the endpo...` |
| `definitions.OnlineDeployment.properties.model__deleted` | deleted | `{"type":"string","description":"The URI path to the model.","x-nullable":true}` |

### Changes for `outputAction`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.outputAction__deleted` | deleted | `{"type":"string","description":"Enum to determine how batch inferencing will handle output","default...` |

### Changes for `outputFileName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.outputFileName__deleted` | deleted | `{"type":"string","description":"Customized output file name for append_row output action.","default"...` |

### Changes for `provisioningState`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"Possible values for DeploymentProvisioningState.","enum":["Creating"...` |
| `definitions.BatchEndpoint.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"State of endpoint provisioning.","enum":["Creating","Deleting","Succ...` |
| `definitions.CapabilityHost.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"Provisioning state of capability host.","enum":["Succeeded","Failed"...` |
| `definitions.CodeContainer.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"Provisioning state of registry asset.","enum":["Succeeded","Failed",...` |
| `definitions.CodeVersion.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"Provisioning state of registry asset.","enum":["Succeeded","Failed",...` |
| `definitions.ComponentContainer.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"Provisioning state of registry asset.","enum":["Succeeded","Failed",...` |
| `definitions.ComponentVersion.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"Provisioning state of registry asset.","enum":["Succeeded","Failed",...` |
| `definitions.EnvironmentContainer.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"Provisioning state of registry asset.","enum":["Succeeded","Failed",...` |
| `definitions.EnvironmentVersion.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"Provisioning state of registry asset.","enum":["Succeeded","Failed",...` |
| `definitions.FeaturesetContainer.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"Provisioning state of registry asset.","enum":["Succeeded","Failed",...` |
| `definitions.FeaturesetVersion.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"Provisioning state of registry asset.","enum":["Succeeded","Failed",...` |
| `definitions.FeaturestoreEntityContainer.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"Provisioning state of registry asset.","enum":["Succeeded","Failed",...` |
| `definitions.FeaturestoreEntityVersion.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"Provisioning state of registry asset.","enum":["Succeeded","Failed",...` |
| `definitions.InferenceEndpoint.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"State of pool related resources provisioning.","enum":["Creating","D...` |
| `definitions.InferenceGroup.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"State of pool related resources provisioning.","enum":["Creating","D...` |
| `definitions.InferencePool.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"State of pool related resources provisioning.","enum":["Creating","D...` |
| `definitions.MarketplaceSubscription.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"Provisioning State of the Marketplace Subscription.","enum":["Creati...` |
| `definitions.ModelContainer.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"Provisioning state of registry asset.","enum":["Succeeded","Failed",...` |
| `definitions.ModelVersion.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"Provisioning state of registry asset.","enum":["Succeeded","Failed",...` |
| `definitions.OnlineDeployment.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"Possible values for DeploymentProvisioningState.","enum":["Creating"...` |
| `definitions.OnlineEndpoint.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"State of endpoint provisioning.","enum":["Creating","Deleting","Succ...` |
| `definitions.Schedule.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"Provisioning state for the schedule.","enum":["Creating","Updating",...` |
| `definitions.ServerlessEndpoint.properties.provisioningState__deleted` | deleted | `{"type":"string","description":"State of endpoint provisioning.","enum":["Creating","Deleting","Succ...` |

### Changes for `resources`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.resources__deleted` | deleted | `{"$ref":"#/definitions/DeploymentResourceConfiguration","description":"Indicates compute configurati...` |

### Changes for `retrySettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.retrySettings__deleted` | deleted | `{"$ref":"#/definitions/BatchRetrySettings","description":"Retry Settings for the batch inference ope...` |

### Changes for `identity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.identity__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Manage...` |
| `definitions.BatchEndpoint.properties.identity__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Manage...` |
| `definitions.InferenceEndpoint.properties.identity__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Manage...` |
| `definitions.InferenceGroup.properties.identity__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Manage...` |
| `definitions.InferencePool.properties.identity__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Manage...` |
| `definitions.JobBase.properties.identity__deleted` | deleted | `{"$ref":"#/definitions/IdentityConfiguration","description":"Identity configuration. If set, this sh...` |
| `definitions.OnlineDeployment.properties.identity__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Manage...` |
| `definitions.OnlineEndpoint.properties.identity__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Manage...` |
| `definitions.Registry.properties.identity__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Manage...` |
| `definitions.ServerlessEndpoint.properties.identity__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Manage...` |

### Changes for `kind`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.kind__added` | added | `{"type":"string","description":"Metadata used by portal/tooling/etc to render different UX experienc...` |
| `definitions.BatchEndpoint.properties.kind__added` | added | `{"type":"string","description":"Metadata used by portal/tooling/etc to render different UX experienc...` |
| `definitions.InferenceEndpoint.properties.kind__added` | added | `{"type":"string","description":"Metadata used by portal/tooling/etc to render different UX experienc...` |
| `definitions.InferenceGroup.properties.kind__added` | added | `{"type":"string","description":"Metadata used by portal/tooling/etc to render different UX experienc...` |
| `definitions.InferencePool.properties.kind__added` | added | `{"type":"string","description":"Metadata used by portal/tooling/etc to render different UX experienc...` |
| `definitions.OnlineDeployment.properties.kind__added` | added | `{"type":"string","description":"Metadata used by portal/tooling/etc to render different UX experienc...` |
| `definitions.OnlineEndpoint.properties.kind__added` | added | `{"type":"string","description":"Metadata used by portal/tooling/etc to render different UX experienc...` |
| `definitions.Registry.properties.kind__added` | added | `{"type":"string","description":"Metadata used by portal/tooling/etc to render different UX experienc...` |
| `definitions.ServerlessEndpoint.properties.kind__added` | added | `{"type":"string","description":"Metadata used by portal/tooling/etc to render different UX experienc...` |

### Changes for `sku`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.sku__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/Sku","descriptio...` |
| `definitions.BatchEndpoint.properties.sku__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/Sku","descriptio...` |
| `definitions.InferenceEndpoint.properties.sku__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/Sku","descriptio...` |
| `definitions.InferenceGroup.properties.sku__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/Sku","descriptio...` |
| `definitions.InferencePool.properties.sku__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/Sku","descriptio...` |
| `definitions.OnlineDeployment.properties.sku__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/Sku","descriptio...` |
| `definitions.OnlineEndpoint.properties.sku__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/Sku","descriptio...` |
| `definitions.Registry.properties.sku__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/Sku","descriptio...` |
| `definitions.ServerlessEndpoint.properties.sku__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/Sku","descriptio...` |

### Changes for `defaults`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchEndpoint.properties.defaults__deleted` | deleted | `{"$ref":"#/definitions/BatchEndpointDefaults","description":"Default values for Batch Endpoint","x-n...` |

### Changes for `aiServicesConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapabilityHost.properties.aiServicesConnections__deleted` | deleted | `{"type":"array","description":"List of AI services connections.","x-nullable":true,"items":{"type":"...` |

### Changes for `capabilityHostKind`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapabilityHost.properties.capabilityHostKind__deleted` | deleted | `{"type":"string","description":"Kind of this capability host.","default":"Agents","enum":["Agents"],...` |

### Changes for `customerSubnet`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapabilityHost.properties.customerSubnet__deleted` | deleted | `{"type":"string","description":"Customer subnet info to help set up this capability host.","x-nullab...` |

### Changes for `storageConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapabilityHost.properties.storageConnections__deleted` | deleted | `{"type":"array","description":"List of Storage connections.","x-nullable":true,"items":{"type":"stri...` |

### Changes for `threadStorageConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapabilityHost.properties.threadStorageConnections__deleted` | deleted | `{"type":"array","description":"List of Thread storage connections.","x-nullable":true,"items":{"type...` |

### Changes for `vectorStoreConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapabilityHost.properties.vectorStoreConnections__deleted` | deleted | `{"type":"array","description":"List of VectorStore connections.","x-nullable":true,"items":{"type":"...` |

### Changes for `cvSplitColumnNames`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.cvSplitColumnNames__added` | added | `{"type":"array","description":"Columns to use for CVSplit data.","x-nullable":true,"items":{"type":"...` |
| `definitions.Forecasting.properties.cvSplitColumnNames__added` | added | `{"type":"array","description":"Columns to use for CVSplit data.","x-nullable":true,"items":{"type":"...` |
| `definitions.Regression.properties.cvSplitColumnNames__added` | added | `{"type":"array","description":"Columns to use for CVSplit data.","x-nullable":true,"items":{"type":"...` |

### Changes for `featurizationSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.featurizationSettings__added` | added | `{"$ref":"#/definitions/TableVerticalFeaturizationSettings","description":"Featurization inputs neede...` |
| `definitions.Forecasting.properties.featurizationSettings__added` | added | `{"$ref":"#/definitions/TableVerticalFeaturizationSettings","description":"Featurization inputs neede...` |
| `definitions.Regression.properties.featurizationSettings__added` | added | `{"$ref":"#/definitions/TableVerticalFeaturizationSettings","description":"Featurization inputs neede...` |
| `definitions.TextClassification.properties.featurizationSettings__added` | added | `{"$ref":"#/definitions/NlpVerticalFeaturizationSettings","description":"Featurization inputs needed ...` |
| `definitions.TextClassificationMultilabel.properties.featurizationSettings__added` | added | `{"$ref":"#/definitions/NlpVerticalFeaturizationSettings","description":"Featurization inputs needed ...` |
| `definitions.TextNer.properties.featurizationSettings__added` | added | `{"$ref":"#/definitions/NlpVerticalFeaturizationSettings","description":"Featurization inputs needed ...` |

### Changes for `limitSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.limitSettings__added` | added | `{"$ref":"#/definitions/TableVerticalLimitSettings","description":"Execution constraints for AutoMLJo...` |
| `definitions.Forecasting.properties.limitSettings__added` | added | `{"$ref":"#/definitions/TableVerticalLimitSettings","description":"Execution constraints for AutoMLJo...` |
| `definitions.ImageClassification.properties.limitSettings__added` | added | `{"$ref":"#/definitions/ImageLimitSettings","description":"[Required] Limit settings for the AutoML j...` |
| `definitions.ImageClassificationMultilabel.properties.limitSettings__added` | added | `{"$ref":"#/definitions/ImageLimitSettings","description":"[Required] Limit settings for the AutoML j...` |
| `definitions.ImageInstanceSegmentation.properties.limitSettings__added` | added | `{"$ref":"#/definitions/ImageLimitSettings","description":"[Required] Limit settings for the AutoML j...` |
| `definitions.ImageObjectDetection.properties.limitSettings__added` | added | `{"$ref":"#/definitions/ImageLimitSettings","description":"[Required] Limit settings for the AutoML j...` |
| `definitions.Regression.properties.limitSettings__added` | added | `{"$ref":"#/definitions/TableVerticalLimitSettings","description":"Execution constraints for AutoMLJo...` |
| `definitions.TextClassification.properties.limitSettings__added` | added | `{"$ref":"#/definitions/NlpVerticalLimitSettings","description":"Execution constraints for AutoMLJob....` |
| `definitions.TextClassificationMultilabel.properties.limitSettings__added` | added | `{"$ref":"#/definitions/NlpVerticalLimitSettings","description":"Execution constraints for AutoMLJob....` |
| `definitions.TextNer.properties.limitSettings__added` | added | `{"$ref":"#/definitions/NlpVerticalLimitSettings","description":"Execution constraints for AutoMLJob....` |

### Changes for `nCrossValidations`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.nCrossValidations__added` | added | `{"$ref":"#/definitions/NCrossValidations","description":"Number of cross validation folds to be appl...` |
| `definitions.Forecasting.properties.nCrossValidations__added` | added | `{"$ref":"#/definitions/NCrossValidations","description":"Number of cross validation folds to be appl...` |
| `definitions.Regression.properties.nCrossValidations__added` | added | `{"$ref":"#/definitions/NCrossValidations","description":"Number of cross validation folds to be appl...` |

### Changes for `testData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.testData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","description":"Test data input.","x-nullable":true}` |
| `definitions.Forecasting.properties.testData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","description":"Test data input.","x-nullable":true}` |
| `definitions.Regression.properties.testData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","description":"Test data input.","x-nullable":true}` |

### Changes for `testDataSize`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.testDataSize__added` | added | `{"type":"number","format":"double","description":"The fraction of test dataset that needs to be set ...` |
| `definitions.Forecasting.properties.testDataSize__added` | added | `{"type":"number","format":"double","description":"The fraction of test dataset that needs to be set ...` |
| `definitions.Regression.properties.testDataSize__added` | added | `{"type":"number","format":"double","description":"The fraction of test dataset that needs to be set ...` |

### Changes for `validationData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","description":"Validation data inputs.","x-nullable":true}` |
| `definitions.Forecasting.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","description":"Validation data inputs.","x-nullable":true}` |
| `definitions.ImageClassification.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","description":"Validation data inputs.","x-nullable":true}` |
| `definitions.ImageClassificationMultilabel.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","description":"Validation data inputs.","x-nullable":true}` |
| `definitions.ImageInstanceSegmentation.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","description":"Validation data inputs.","x-nullable":true}` |
| `definitions.ImageObjectDetection.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","description":"Validation data inputs.","x-nullable":true}` |
| `definitions.Regression.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","description":"Validation data inputs.","x-nullable":true}` |
| `definitions.TextClassification.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","description":"Validation data inputs.","x-nullable":true}` |
| `definitions.TextClassificationMultilabel.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","description":"Validation data inputs.","x-nullable":true}` |
| `definitions.TextNer.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","description":"Validation data inputs.","x-nullable":true}` |

### Changes for `validationDataSize`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.validationDataSize__added` | added | `{"type":"number","format":"double","description":"The fraction of training dataset that needs to be ...` |
| `definitions.Forecasting.properties.validationDataSize__added` | added | `{"type":"number","format":"double","description":"The fraction of training dataset that needs to be ...` |
| `definitions.ImageClassification.properties.validationDataSize__added` | added | `{"type":"number","format":"double","description":"The fraction of training dataset that needs to be ...` |
| `definitions.ImageClassificationMultilabel.properties.validationDataSize__added` | added | `{"type":"number","format":"double","description":"The fraction of training dataset that needs to be ...` |
| `definitions.ImageInstanceSegmentation.properties.validationDataSize__added` | added | `{"type":"number","format":"double","description":"The fraction of training dataset that needs to be ...` |
| `definitions.ImageObjectDetection.properties.validationDataSize__added` | added | `{"type":"number","format":"double","description":"The fraction of training dataset that needs to be ...` |
| `definitions.Regression.properties.validationDataSize__added` | added | `{"type":"number","format":"double","description":"The fraction of training dataset that needs to be ...` |

### Changes for `weightColumnName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.weightColumnName__added` | added | `{"type":"string","description":"The name of the sample weight column. Automated ML supports a weight...` |
| `definitions.Forecasting.properties.weightColumnName__added` | added | `{"type":"string","description":"The name of the sample weight column. Automated ML supports a weight...` |
| `definitions.Regression.properties.weightColumnName__added` | added | `{"type":"string","description":"The name of the sample weight column. Automated ML supports a weight...` |

### Changes for `codeUri`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CodeVersion.properties.codeUri__deleted` | deleted | `{"type":"string","description":"Uri where code is located","x-nullable":true,"example":"https://blob...` |

### Changes for `componentSpec`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComponentVersion.properties.componentSpec__deleted` | deleted | `{"type":"object","description":"Defines Component definition details.\\r\\n<see href=\\"https://docs.mi...` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComputeInstanceConnectivityEndpoints.readOnly__deleted` | deleted | `true` |
| `definitions.ComputeInstanceCreatedBy.readOnly__deleted` | deleted | `true` |
| `definitions.ServerlessEndpointInferenceEndpoint.properties.uri.readOnly__added` | added | `true` |
| `definitions.ServerlessInferenceEndpoint.properties.uri.readOnly__added` | added | `true` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComputeInstanceContainer.properties.services.items.additionalProperties__added` | added | `{}` |
| `definitions.EndpointScheduleAction.properties.endpointInvocationDefinition.additionalProperties__added` | added | `{}` |
| `definitions.PipelineJob.properties.settings.additionalProperties__added` | added | `{}` |
| `definitions.SweepJob.properties.searchSpace.additionalProperties__added` | added | `{}` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComputeResource.properties.location__deleted` | deleted | `{"type":"string","description":"Specifies the location of the resource."}` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComputeResource.properties.tags__deleted` | deleted | `{"type":"object","description":"Contains resource tags defined as key/value pairs.","x-nullable":tru...` |

### Changes for `x-nullable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComputeResource.properties.sku['x-nullable__deleted']` | deleted | `true` |
| `definitions.HDInsightProperties.properties.administratorAccount['x-nullable__deleted']` | deleted | `true` |
| `definitions.ManagedResourceGroupAssignedIdentities.properties.principalId['x-nullable__deleted']` | deleted | `false` |
| `definitions.PartialMinimalTrackedResource.properties.tags.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.PartialMinimalTrackedResource.properties.tags['x-nullable__added']` | added | `true` |
| `definitions.RegistryPrivateEndpointConnection.properties.properties['x-nullable__deleted']` | deleted | `true` |

### Changes for `dataType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataContainer.properties.dataType__deleted` | deleted | `{"type":"string","description":"Enum to determine the type of data.","enum":["uri_file","uri_folder"...` |
| `definitions.DataVersionBase.properties.dataType__deleted` | deleted | `{"type":"string","description":"Enum to determine the type of data.","enum":["uri_file","uri_folder"...` |
| `definitions.Feature.properties.dataType__deleted` | deleted | `{"type":"string","description":"Specifies type","default":"String","enum":["String","Integer","Long"...` |

### Changes for `discriminator`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Datastore.discriminator__deleted` | deleted | `datastoreType` |
| `definitions.DataVersionBase.discriminator__deleted` | deleted | `dataType` |
| `definitions.JobBase.discriminator__deleted` | deleted | `jobType` |
| `definitions.OnlineDeployment.discriminator__deleted` | deleted | `endpointComputeType` |

### Changes for `dataUri`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataVersionBase.properties.dataUri__deleted` | deleted | `{"type":"string","description":"[Required] Uri of the data. Example: https://go.microsoft.com/fwlink...` |

### Changes for `credentials`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Datastore.properties.credentials__deleted` | deleted | `{"$ref":"#/definitions/DatastoreCredentials","description":"[Required] Account credentials."}` |

### Changes for `datastoreType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Datastore.properties.datastoreType__deleted` | deleted | `{"type":"string","description":"Enum to determine the datastore contents type.","enum":["AzureBlob",...` |

### Changes for `isDefault`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Datastore.properties.isDefault__deleted` | deleted | `{"type":"boolean","description":"Readonly property to indicate if datastore is the workspace default...` |

### Changes for `uniqueItems`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeltaModelModifyRequest.properties.addDeltaModels.uniqueItems__deleted` | deleted | `true` |
| `definitions.DeltaModelModifyRequest.properties.removeDeltaModels.uniqueItems__deleted` | deleted | `true` |

### Changes for `autoRebuild`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersion.properties.autoRebuild__deleted` | deleted | `{"type":"string","description":"AutoRebuild setting for the derived image","default":"Disabled","enu...` |

### Changes for `build`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersion.properties.build__deleted` | deleted | `{"$ref":"#/definitions/BuildContext","description":"Configuration settings for Docker build context....` |

### Changes for `condaFile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersion.properties.condaFile__deleted` | deleted | `{"type":"string","description":"Standard configuration file used by Conda that lets you install any ...` |

### Changes for `environmentType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersion.properties.environmentType__deleted` | deleted | `{"type":"string","description":"Environment type is either user created or curated by Azure ML servi...` |

### Changes for `image`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersion.properties.image__deleted` | deleted | `{"type":"string","description":"Name of the image that will be used for the environment.\\r\\n<seealso...` |

### Changes for `imageDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersion.properties.imageDetails__deleted` | deleted | `{"$ref":"#/definitions/ImageDetails","description":"Environment image details"}` |

### Changes for `inferenceConfig`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersion.properties.inferenceConfig__deleted` | deleted | `{"$ref":"#/definitions/InferenceContainerProperties","description":"Defines configuration specific t...` |

### Changes for `osType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersion.properties.osType__deleted` | deleted | `{"type":"string","description":"The type of operating system.","default":"Linux","enum":["Linux","Wi...` |

### Changes for `stage`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersion.properties.stage__deleted` | deleted | `{"type":"string","description":"Stage in the environment lifecycle assigned to this environment","x-...` |
| `definitions.FeaturesetVersion.properties.stage__deleted` | deleted | `{"type":"string","description":"Specifies the asset stage","x-nullable":true}` |
| `definitions.FeaturestoreEntityVersion.properties.stage__deleted` | deleted | `{"type":"string","description":"Specifies the asset stage","x-nullable":true}` |
| `definitions.ModelVersion.properties.stage__deleted` | deleted | `{"type":"string","description":"Stage in the model lifecycle assigned to this model","x-nullable":tr...` |

### Changes for `featureName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Feature.properties.featureName__deleted` | deleted | `{"type":"string","description":"Specifies name","x-nullable":true}` |

### Changes for `entities`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturesetVersion.properties.entities__deleted` | deleted | `{"type":"array","description":"Specifies list of entities","x-nullable":true,"items":{"type":"string...` |

### Changes for `materializationSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturesetVersion.properties.materializationSettings__deleted` | deleted | `{"$ref":"#/definitions/MaterializationSettings","description":"Specifies the materialization setting...` |

### Changes for `specification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturesetVersion.properties.specification__deleted` | deleted | `{"$ref":"#/definitions/FeaturesetSpecification","description":"Specifies the feature spec details","...` |

### Changes for `indexColumns`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturestoreEntityVersion.properties.indexColumns__deleted` | deleted | `{"type":"array","description":"Specifies index columns","x-nullable":true,"items":{"$ref":"#/definit...` |

### Changes for `modelSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImageClassification.properties.modelSettings__added` | added | `{"$ref":"#/definitions/ImageModelSettingsClassification","description":"Settings used for training t...` |
| `definitions.ImageClassificationMultilabel.properties.modelSettings__added` | added | `{"$ref":"#/definitions/ImageModelSettingsClassification","description":"Settings used for training t...` |
| `definitions.ImageInstanceSegmentation.properties.modelSettings__added` | added | `{"$ref":"#/definitions/ImageModelSettingsObjectDetection","description":"Settings used for training ...` |
| `definitions.ImageObjectDetection.properties.modelSettings__added` | added | `{"$ref":"#/definitions/ImageModelSettingsObjectDetection","description":"Settings used for training ...` |
| `definitions.ServerlessEndpoint.properties.modelSettings__deleted` | deleted | `{"$ref":"#/definitions/ModelSettings","description":"The model settings (model id) for the model bei...` |

### Changes for `searchSpace`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImageClassification.properties.searchSpace__added` | added | `{"type":"array","description":"Search space for sampling different combinations of models and their ...` |
| `definitions.ImageClassificationMultilabel.properties.searchSpace__added` | added | `{"type":"array","description":"Search space for sampling different combinations of models and their ...` |
| `definitions.ImageInstanceSegmentation.properties.searchSpace__added` | added | `{"type":"array","description":"Search space for sampling different combinations of models and their ...` |
| `definitions.ImageObjectDetection.properties.searchSpace__added` | added | `{"type":"array","description":"Search space for sampling different combinations of models and their ...` |

### Changes for `sweepSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImageClassification.properties.sweepSettings__added` | added | `{"$ref":"#/definitions/ImageSweepSettings","description":"Model sweeping and hyperparameter sweeping...` |
| `definitions.ImageClassificationMultilabel.properties.sweepSettings__added` | added | `{"$ref":"#/definitions/ImageSweepSettings","description":"Model sweeping and hyperparameter sweeping...` |
| `definitions.ImageInstanceSegmentation.properties.sweepSettings__added` | added | `{"$ref":"#/definitions/ImageSweepSettings","description":"Model sweeping and hyperparameter sweeping...` |
| `definitions.ImageObjectDetection.properties.sweepSettings__added` | added | `{"$ref":"#/definitions/ImageSweepSettings","description":"Model sweeping and hyperparameter sweeping...` |

### Changes for `authMode`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceEndpoint.properties.authMode__deleted` | deleted | `{"type":"string","description":"Enum to determine endpoint authentication mode.","enum":["AAD"],"x-m...` |
| `definitions.ServerlessEndpoint.properties.authMode__deleted` | deleted | `{"type":"string","description":"[Required] Specifies the authentication mode for the Serverless endp...` |

### Changes for `endpointUri`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceEndpoint.properties.endpointUri__deleted` | deleted | `{"type":"string","format":"uri","description":"Endpoint URI for the inference endpoint.","x-nullable...` |

### Changes for `groupName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceEndpoint.properties.groupName__deleted` | deleted | `{"type":"string","description":"[Required] Group within the same pool with which this endpoint needs...` |

### Changes for `requestConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceEndpoint.properties.requestConfiguration__deleted` | deleted | `{"$ref":"#/definitions/RequestConfiguration","description":"RequestConfiguration for endpoint.","x-n...` |

### Changes for `environmentConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceGroup.properties.environmentConfiguration__deleted` | deleted | `{"$ref":"#/definitions/GroupEnvironmentConfiguration","description":"Gets or sets environment config...` |

### Changes for `modelConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceGroup.properties.modelConfiguration__deleted` | deleted | `{"$ref":"#/definitions/GroupModelConfiguration","description":"Gets or sets model configuration for ...` |

### Changes for `nodeSkuType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceGroup.properties.nodeSkuType__deleted` | deleted | `{"type":"string","description":"Gets or sets compute instance type.","x-nullable":true}` |

### Changes for `scaleUnitSize`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceGroup.properties.scaleUnitSize__deleted` | deleted | `{"type":"integer","format":"int32","description":"Gets or sets Scale Unit size."}` |

### Changes for `scaleUnitConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferencePool.properties.scaleUnitConfiguration__deleted` | deleted | `{"$ref":"#/definitions/ScaleUnitConfiguration","description":"Gets or sets ScaleUnitConfiguration fo...` |

### Changes for `componentId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.componentId__deleted` | deleted | `{"type":"string","description":"ARM resource ID of the component resource.","x-nullable":true,"x-ms-...` |

### Changes for `computeId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.computeId__deleted` | deleted | `{"type":"string","description":"ARM resource ID of the compute resource.","x-nullable":true,"x-ms-mu...` |

### Changes for `displayName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.displayName__deleted` | deleted | `{"type":"string","description":"Display name of job.","x-nullable":true,"x-ms-mutability":["create",...` |
| `definitions.Schedule.properties.displayName__deleted` | deleted | `{"type":"string","description":"Display name of schedule.","x-nullable":true,"x-ms-mutability":["cre...` |

### Changes for `experimentName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.experimentName__deleted` | deleted | `{"type":"string","description":"The name of the experiment the job belongs to. If not set, the job i...` |

### Changes for `isArchived`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.isArchived__deleted` | deleted | `{"type":"boolean","description":"Is the asset archived?","default":false,"x-ms-mutability":["create"...` |

### Changes for `jobType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.jobType__deleted` | deleted | `{"type":"string","description":"Enum to determine the type of job.","enum":["AutoML","Command","Swee...` |

### Changes for `notificationSetting`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.notificationSetting__deleted` | deleted | `{"$ref":"#/definitions/NotificationSetting","description":"Notification setting for the job","x-null...` |

### Changes for `parentJobName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.parentJobName__deleted` | deleted | `{"type":"string","description":"Parent job name.","x-nullable":true}` |

### Changes for `services`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.services__deleted` | deleted | `{"type":"object","description":"List of JobEndpoints.\\r\\nFor local jobs, a job endpoint will have an...` |

### Changes for `status`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.status__deleted` | deleted | `{"type":"string","description":"The status of a job.","enum":["NotStarted","Starting","Provisioning"...` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MarketplaceSubscription.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}...` |
| `definitions.Registry.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource...` |
| `definitions.ServerlessEndpoint.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource...` |

### Changes for `marketplacePlan`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MarketplaceSubscription.properties.marketplacePlan__deleted` | deleted | `{"$ref":"#/definitions/MarketplacePlan","description":"Marketplace Plan associated with the Marketpl...` |

### Changes for `marketplaceSubscriptionStatus`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MarketplaceSubscription.properties.marketplaceSubscriptionStatus__deleted` | deleted | `{"type":"string","description":"Current status of the Marketplace Subscription.","enum":["Subscribed...` |

### Changes for `modelId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MarketplaceSubscription.properties.modelId__deleted` | deleted | `{"type":"string","description":"[Required] Target Marketplace Model ID to create a Marketplace Subsc...` |

### Changes for `flavors`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelVersion.properties.flavors__deleted` | deleted | `{"type":"object","description":"Mapping of model flavors to their properties.","x-nullable":true,"ad...` |

### Changes for `jobName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelVersion.properties.jobName__deleted` | deleted | `{"type":"string","description":"Name of the training job which produced this model","x-nullable":tru...` |

### Changes for `modelType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelVersion.properties.modelType__deleted` | deleted | `{"type":"string","description":"The storage format for this entity. Used for NCD.","x-nullable":true...` |

### Changes for `modelUri`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelVersion.properties.modelUri__deleted` | deleted | `{"type":"string","description":"The URI path to the model contents.","x-nullable":true}` |

### Changes for `datasets`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelVersion.properties.datasets__deleted` | deleted | `{"type":"array","description":"Array of dataset references","x-nullable":true,"items":{"$ref":"#/def...` |

### Changes for `appInsightsEnabled`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.appInsightsEnabled__deleted` | deleted | `{"type":"boolean","description":"If true, enables Application Insights logging.","default":false}` |

### Changes for `dataCollector`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.dataCollector__deleted` | deleted | `{"$ref":"#/definitions/DataCollector","description":"The mdc configuration, we disable mdc when it's...` |

### Changes for `egressPublicNetworkAccess`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.egressPublicNetworkAccess__deleted` | deleted | `{"type":"string","description":"Enum to determine whether PublicNetworkAccess is Enabled or Disabled...` |

### Changes for `endpointComputeType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.endpointComputeType__deleted` | deleted | `{"type":"string","description":"Enum to determine endpoint compute type.","enum":["Managed","Kuberne...` |

### Changes for `instanceType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.instanceType__deleted` | deleted | `{"type":"string","description":"Compute instance type. Default: Standard_F4s_v2.","default":"Standar...` |

### Changes for `livenessProbe`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.livenessProbe__deleted` | deleted | `{"$ref":"#/definitions/ProbeSettings","description":"Liveness probe monitors the health of the conta...` |

### Changes for `modelMountPath`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.modelMountPath__deleted` | deleted | `{"type":"string","description":"The path to mount the model in custom container.","x-nullable":true}` |

### Changes for `readinessProbe`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.readinessProbe__deleted` | deleted | `{"$ref":"#/definitions/ProbeSettings","description":"Readiness probe validates if the container is r...` |

### Changes for `requestSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.requestSettings__deleted` | deleted | `{"$ref":"#/definitions/OnlineRequestSettings","description":"Request settings for the deployment.","...` |

### Changes for `scaleSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.scaleSettings__deleted` | deleted | `{"$ref":"#/definitions/OnlineScaleSettings","description":"Scale settings for the deployment.\\r\\nIf ...` |

### Changes for `startupProbe`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.startupProbe__deleted` | deleted | `{"$ref":"#/definitions/ProbeSettings","description":"Startup probe verify whether an application wit...` |

### Changes for `mirrorTraffic`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineEndpoint.properties.mirrorTraffic__deleted` | deleted | `{"type":"object","description":"Percentage of traffic to be mirrored to each deployment without usin...` |

### Changes for `publicNetworkAccess`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineEndpoint.properties.publicNetworkAccess__deleted` | deleted | `{"type":"string","description":"Enum to determine whether PublicNetworkAccess is Enabled or Disabled...` |
| `definitions.Registry.properties.publicNetworkAccess__deleted` | deleted | `{"type":"string","description":"Is the Registry accessible from the internet?\\r\\nPossible values: \\"...` |

### Changes for `traffic`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineEndpoint.properties.traffic__deleted` | deleted | `{"type":"object","description":"Percentage of traffic from endpoint to divert to each deployment. Tr...` |

### Changes for `nextLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateEndpointConnectionListResult.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.PrivateLinkResourceListResult.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |

### Changes for `discoveryUrl`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Registry.properties.discoveryUrl__deleted` | deleted | `{"type":"string","description":"Discovery URL for the Registry","x-nullable":true}` |

### Changes for `intellectualPropertyPublisher`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Registry.properties.intellectualPropertyPublisher__deleted` | deleted | `{"type":"string","description":"IntellectualPropertyPublisher for the registry","x-nullable":true}` |

### Changes for `managedResourceGroup`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Registry.properties.managedResourceGroup__deleted` | deleted | `{"$ref":"#/definitions/ArmResourceId","description":"ResourceId of the managed RG if the registry ha...` |

### Changes for `managedResourceGroupSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Registry.properties.managedResourceGroupSettings__deleted` | deleted | `{"$ref":"#/definitions/ManagedResourceGroupSettings","description":"Managed resource group specific ...` |

### Changes for `mlFlowRegistryUri`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Registry.properties.mlFlowRegistryUri__deleted` | deleted | `{"type":"string","description":"MLFlow Registry URI for the Registry","x-nullable":true}` |

### Changes for `registryPrivateEndpointConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Registry.properties.registryPrivateEndpointConnections__deleted` | deleted | `{"type":"array","description":"Private endpoint connections info used for pending connections in pri...` |

### Changes for `regionDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Registry.properties.regionDetails__deleted` | deleted | `{"type":"array","description":"Details of each region the registry is in","x-nullable":true,"items":...` |

### Changes for `action`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Schedule.properties.action__deleted` | deleted | `{"$ref":"#/definitions/ScheduleActionBase","description":"[Required] Specifies the action of the sch...` |

### Changes for `isEnabled`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Schedule.properties.isEnabled__deleted` | deleted | `{"type":"boolean","description":"Is the schedule enabled?","default":true,"x-ms-mutability":["create...` |

### Changes for `trigger`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Schedule.properties.trigger__deleted` | deleted | `{"$ref":"#/definitions/TriggerBase","description":"[Required] Specifies the trigger details","x-ms-m...` |

### Changes for `contentSafety`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerlessEndpoint.properties.contentSafety__deleted` | deleted | `{"$ref":"#/definitions/ContentSafety","description":"Specifies the content safety options. If omitte...` |

### Changes for `endpointState`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerlessEndpoint.properties.endpointState__deleted` | deleted | `{"type":"string","description":"State of the Serverless Endpoint.","enum":["Unknown","Creating","Del...` |

### Changes for `inferenceEndpoint`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerlessEndpoint.properties.inferenceEndpoint__deleted` | deleted | `{"$ref":"#/definitions/ServerlessInferenceEndpoint","description":"The inference uri to target when ...` |

### Changes for `marketplaceSubscriptionId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerlessEndpoint.properties.marketplaceSubscriptionId__deleted` | deleted | `{"type":"string","description":"The MarketplaceSubscription Azure ID associated to this ServerlessEn...` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SkuSetting.properties.tier.enum__added` | added | `["Free","Basic","Standard","Premium"]` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SkuSetting.properties.tier['x-ms-enum__added']` | added | `{"name":"SkuTier","modelAsString":false}` |

### Changes for `x-ms-identifiers`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TableVerticalFeaturizationSettings.properties.transformerParams.additionalProperties['x-ms-identifiers__deleted']` | deleted | `[]` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AmlComputeNodeInformation.properties.port.type` | `number` | `integer` |
| `definitions.AmlUserFeature.properties.displayName.description` | `Specifies the feature name ` | `Specifies the feature name` |
| `definitions.ApiKeyAuthWorkspaceConnectionProperties.description` | `This connection type covers the generic ApiKey auth connection categories, for examples:
AzureOpenAI:
    Category:= AzureOpenAI
    AuthType:= ApiKey (as type discriminator)
    Credentials:= {ApiKey} as Microsoft.MachineLearning.AccountRP.Contracts.WorkspaceConnection.ApiKey
    Target:= {ApiBase}
            
CognitiveService:
    Category:= CognitiveService
    AuthType:= ApiKey (as type discriminator)
    Credentials:= {SubscriptionKey} as Microsoft.MachineLearning.AccountRP.Contracts.WorkspaceConnection.ApiKey
    Target:= ServiceRegion={serviceRegion}
            
CognitiveSearch:
    Category:= CognitiveSearch
    AuthType:= ApiKey (as type discriminator)
    Credentials:= {Key} as Microsoft.MachineLearning.AccountRP.Contracts.WorkspaceConnection.ApiKey
    Target:= {Endpoint}
            
Use Metadata property bag for ApiType, ApiVersion, Kind and other metadata fields` | `This connection type covers the generic ApiKey auth connection categories, for examples:
AzureOpenAI:
Category:= AzureOpenAI
AuthType:= ApiKey (as type discriminator)
Credentials:= {ApiKey} as Microsoft.MachineLearning.AccountRP.Contracts.WorkspaceConnection.ApiKey
Target:= {ApiBase}

CognitiveService:
Category:= CognitiveService
AuthType:= ApiKey (as type discriminator)
Credentials:= {SubscriptionKey} as Microsoft.MachineLearning.AccountRP.Contracts.WorkspaceConnection.ApiKey
Target:= ServiceRegion={serviceRegion}

CognitiveSearch:
Category:= CognitiveSearch
AuthType:= ApiKey (as type discriminator)
Credentials:= {Key} as Microsoft.MachineLearning.AccountRP.Contracts.WorkspaceConnection.ApiKey
Target:= {Endpoint}

Use Metadata property bag for ApiType, ApiVersion, Kind and other metadata fields` |
| `definitions.ArmResourceId.properties.resourceId.description` | `Arm ResourceId is in the format "/subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.Storage/storageAccounts/{StorageAccountName}"
or "/subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.ContainerRegistry/registries/{AcrName}"` | `Arm ResourceId is in the format "/subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.Storage/storageAccounts/{StorageAccountName}"
or "/subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.ContainerRegistry/registries/{AcrName}"` |
| `definitions.AutoMLJob.allOf[0].$ref` | `#/definitions/JobBase` | `#/definitions/JobBaseProperties` |
| `definitions.AutoMLJob.description` | `AutoMLJob class.
Use this class for executing AutoML tasks like Classification/Regression etc.
See TaskType enum for all the tasks supported.` | `AutoMLJob class.
Use this class for executing AutoML tasks like Classification/Regression etc.
See TaskType enum for all the tasks supported.` |
| `definitions.AutoMLJob.properties.environmentId.description` | `The ARM resource ID of the Environment specification for the job.
This is optional value to provide, if not provided, AutoML will default this to Production AutoML curated environment version when running the job.` | `The ARM resource ID of the Environment specification for the job.
This is optional value to provide, if not provided, AutoML will default this to Production AutoML curated environment version when running the job.` |
| `definitions.AutoMLVertical.description` | `AutoML vertical class.
Base class for AutoML verticals - TableVertical/ImageVertical/NLPVertical` | `AutoML vertical class.
Base class for AutoML verticals - TableVertical/ImageVertical/NLPVertical` |
| `definitions.AutoMLVertical.properties.targetColumnName.description` | `Target column name: This is prediction values column.
Also known as label column name in context of classification tasks.` | `Target column name: This is prediction values column.
Also known as label column name in context of classification tasks.` |
| `definitions.AzureBlobDatastore.allOf[0].$ref` | `#/definitions/AzureDatastore` | `#/definitions/DatastoreProperties` |
| `definitions.AzureDataLakeGen1Datastore.allOf[0].$ref` | `#/definitions/AzureDatastore` | `#/definitions/DatastoreProperties` |
| `definitions.AzureDataLakeGen2Datastore.allOf[0].$ref` | `#/definitions/AzureDatastore` | `#/definitions/DatastoreProperties` |
| `definitions.AzureFileDatastore.allOf[0].$ref` | `#/definitions/AzureDatastore` | `#/definitions/DatastoreProperties` |
| `definitions.BatchDeployment.allOf[0].$ref` | `#/definitions/EndpointDeploymentPropertiesBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.BatchDeployment.description` | `Batch inference settings per deployment.` | `Concrete tracked resource types can be created by aliasing this type using a specific property type.` |
| `definitions.BatchDeploymentTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/BatchDeploymentTrackedResource` | `#/definitions/BatchDeployment` |
| `definitions.BatchEndpoint.allOf[0].$ref` | `#/definitions/EndpointPropertiesBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.BatchEndpoint.description` | `Batch endpoint configuration.` | `Concrete tracked resource types can be created by aliasing this type using a specific property type.` |
| `definitions.BatchEndpointDefaults.properties.deploymentName.description` | `Name of the deployment that will be default for the endpoint.
This deployment will end up getting 100% traffic when the endpoint scoring URL is invoked.` | `Name of the deployment that will be default for the endpoint.
This deployment will end up getting 100% traffic when the endpoint scoring URL is invoked.` |
| `definitions.BatchEndpointTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/BatchEndpointTrackedResource` | `#/definitions/BatchEndpoint` |
| `definitions.BlobReferenceForConsumptionDto.properties.blobUri.description` | `Blob URI path for client to upload data.
Example: https://blob.windows.core.net/Container/Path` | `Blob URI path for client to upload data.
Example: https://blob.windows.core.net/Container/Path` |
| `definitions.BuildContext.properties.contextUri.description` | `[Required] URI of the Docker build context used to build the image. Supports blob URIs on environment creation and may return blob or Git URIs.
<seealso href="https://docs.docker.com/engine/reference/commandline/build/#extended-description" />` | `[Required] URI of the Docker build context used to build the image. Supports blob URIs on environment creation and may return blob or Git URIs.
<seealso href="https://docs.docker.com/engine/reference/commandline/build/#extended-description" />` |
| `definitions.BuildContext.properties.dockerfilePath.description` | `Path to the Dockerfile in the build context.
<seealso href="https://docs.docker.com/engine/reference/builder/" />` | `Path to the Dockerfile in the build context.
<seealso href="https://docs.docker.com/engine/reference/builder/" />` |
| `definitions.CapabilityHost.allOf[0].$ref` | `#/definitions/ResourceBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.CodeContainer.allOf[0].$ref` | `#/definitions/AssetContainer` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.CodeContainer.description` | `Container for code asset versions.` | `Azure Resource Manager resource envelope.` |
| `definitions.CodeContainerResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/CodeContainerResource` | `#/definitions/CodeContainer` |
| `definitions.CodeVersion.allOf[0].$ref` | `#/definitions/AssetBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.CodeVersion.description` | `Code asset version details.` | `Azure Resource Manager resource envelope.` |
| `definitions.CodeVersionResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/CodeVersionResource` | `#/definitions/CodeVersion` |
| `definitions.ColumnTransformer.properties.parameters.description` | `Different properties to be passed to transformer.
Input expected is dictionary of key,value pairs in JSON format.` | `Different properties to be passed to transformer.
Input expected is dictionary of key,value pairs in JSON format.` |
| `definitions.CommandJob.allOf[0].$ref` | `#/definitions/JobBase` | `#/definitions/JobBaseProperties` |
| `definitions.ComponentContainer.allOf[0].$ref` | `#/definitions/AssetContainer` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ComponentContainer.description` | `Component container definition.
<see href="https://docs.microsoft.com/en-us/azure/machine-learning/reference-yaml-component-command" />` | `Azure Resource Manager resource envelope.` |
| `definitions.ComponentContainerResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/ComponentContainerResource` | `#/definitions/ComponentContainer` |
| `definitions.ComponentVersion.allOf[0].$ref` | `#/definitions/AssetBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ComponentVersion.description` | `Definition of a component version: defines resources that span component types.` | `Azure Resource Manager resource envelope.` |
| `definitions.ComponentVersionResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/ComponentVersionResource` | `#/definitions/ComponentVersion` |
| `definitions.ComputeResource.allOf[0].$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.ComputeResource.properties.identity.description` | `The identity of the resource.` | `The managed service identities assigned to this resource.` |
| `definitions.ComputeResource.properties.sku.description` | `The sku of the workspace.` | `The SKU of the resource.` |
| `definitions.ContainerResourceSettings.properties.cpu.description` | `Number of vCPUs request/limit for container. More info:
https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/` | `Number of vCPUs request/limit for container. More info:
https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/` |
| `definitions.ContainerResourceSettings.properties.gpu.description` | `Number of Nvidia GPU cards request/limit for container. More info:
https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/` | `Number of Nvidia GPU cards request/limit for container. More info:
https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/` |
| `definitions.ContainerResourceSettings.properties.memory.description` | `Memory size request/limit for container. More info:
https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/` | `Memory size request/limit for container. More info:
https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/` |
| `definitions.Cron.properties.expression.description` | `[Required] Specifies cron expression of schedule.
The expression should follow NCronTab format.` | `[Required] Specifies cron expression of schedule.
The expression should follow NCronTab format.` |
| `definitions.Cron.properties.timeZone.description` | `Specifies time zone in which the schedule runs.
TimeZone should follow Windows time zone format. Refer: https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/default-time-zones?view=windows-11` | `Specifies time zone in which the schedule runs.
TimeZone should follow Windows time zone format. Refer: https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/default-time-zones?view=windows-11` |
| `definitions.CronTrigger.properties.expression.description` | `[Required] Specifies cron expression of schedule.
The expression should follow NCronTab format.` | `[Required] Specifies cron expression of schedule.
The expression should follow NCronTab format.` |
| `definitions.CustomKeysWorkspaceConnectionProperties.description` | `Category:= CustomKeys
AuthType:= CustomKeys (as type discriminator)
Credentials:= {CustomKeys} as Microsoft.MachineLearning.AccountRP.Contracts.WorkspaceConnection.CustomKeys
Target:= {any value}
Use Metadata property bag for ApiVersion and other metadata fields` | `Category:= CustomKeys
AuthType:= CustomKeys (as type discriminator)
Credentials:= {CustomKeys} as Microsoft.MachineLearning.AccountRP.Contracts.WorkspaceConnection.CustomKeys
Target:= {any value}
Use Metadata property bag for ApiVersion and other metadata fields` |
| `definitions.CustomService.additionalProperties` | `true` | `{}` |
| `definitions.DataCollector.properties.collections.description` | `[Required] The collection configuration. Each collection has it own configuration to collect model data and the name of collection can be arbitrary string.
Model data collector can be used for either payload logging or custom logging or both of them. Collection request and response are reserved for payload logging, others are for custom logging.` | `[Required] The collection configuration. Each collection has it own configuration to collect model data and the name of collection can be arbitrary string.
Model data collector can be used for either payload logging or custom logging or both of them. Collection request and response are reserved for payload logging, others are for custom logging.` |
| `definitions.DataCollector.properties.rollingRate.description` | `When model data is collected to blob storage, we need to roll the data to different path to avoid logging all of them in a single blob file.
If the rolling rate is hour, all data will be collected in the blob path /yyyy/MM/dd/HH/.
If it's day, all data will be collected in blob path /yyyy/MM/dd/.
The other benefit of rolling path is that model monitoring ui is able to select a time range of data very quickly.` | `When model data is collected to blob storage, we need to roll the data to different path to avoid logging all of them in a single blob file.
If the rolling rate is hour, all data will be collected in the blob path /yyyy/MM/dd/HH/.
If it's day, all data will be collected in blob path /yyyy/MM/dd/.
The other benefit of rolling path is that model monitoring ui is able to select a time range of data very quickly.` |
| `definitions.DataContainer.allOf[0].$ref` | `#/definitions/AssetContainer` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.DataContainer.description` | `Container for data asset versions.` | `Azure Resource Manager resource envelope.` |
| `definitions.DataContainerResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/DataContainerResource` | `#/definitions/DataContainer` |
| `definitions.Datastore.allOf[0].$ref` | `#/definitions/ResourceBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.Datastore.description` | `Base definition for datastore contents configuration.` | `Azure Resource Manager resource envelope.` |
| `definitions.DatastoreResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/DatastoreResource` | `#/definitions/Datastore` |
| `definitions.DataVersionBase.allOf[0].$ref` | `#/definitions/AssetBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.DataVersionBase.description` | `Data version base definition` | `Azure Resource Manager resource envelope.` |
| `definitions.DataVersionBaseResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/DataVersionBaseResource` | `#/definitions/DataVersionBase` |
| `definitions.DistillationJob.allOf[0].$ref` | `#/definitions/JobBase` | `#/definitions/JobBaseProperties` |
| `definitions.DistillationJob.properties.dataGenerationDetails.description` | `[Required] ` | `[Required]` |
| `definitions.DistillationJob.properties.finetuningDetails.description` | `[Required] ` | `[Required]` |
| `definitions.DistillationJob.properties.outputs.description` | `[Required] ` | `[Required]` |
| `definitions.Docker.additionalProperties` | `true` | `{}` |
| `definitions.EncryptionProperty.properties.cosmosDbResourceId.description` | `The byok cosmosdb account that customer brings to store customer's data
with encryption` | `The byok cosmosdb account that customer brings to store customer's data
with encryption` |
| `definitions.EncryptionProperty.properties.searchAccountResourceId.description` | `The byok search account that customer brings to store customer's data
with encryption` | `The byok search account that customer brings to store customer's data
with encryption` |
| `definitions.EncryptionProperty.properties.storageAccountResourceId.description` | `The byok storage account that customer brings to store customer's data
with encryption` | `The byok storage account that customer brings to store customer's data
with encryption` |
| `definitions.EndpointPropertiesBase.properties.keys.description` | `EndpointAuthKeys to set initially on an Endpoint.
This property will always be returned as null. AuthKey values must be retrieved using the ListKeys API.` | `EndpointAuthKeys to set initially on an Endpoint.
This property will always be returned as null. AuthKey values must be retrieved using the ListKeys API.` |
| `definitions.EndpointResourceProperties.properties.endpointUri.format` | `url` | `uri` |
| `definitions.EndpointResourceProperties.properties.location.description` | `Location of the endpoint.
Since input dto and when parse endpoint resource share the same contract
this Location field is just for parse the endpoint resource info
we won't let customer specify the endpoint resource location since we will create it the same location as workspace` | `Location of the endpoint.
Since input dto and when parse endpoint resource share the same contract
this Location field is just for parse the endpoint resource info
we won't let customer specify the endpoint resource location since we will create it the same location as workspace` |
| `definitions.EndpointScheduleAction.properties.endpointInvocationDefinition.description` | `[Required] Defines Schedule action definition details.
<see href="TBD" />` | `[Required] Defines Schedule action definition details.
<see href="TBD" />` |
| `definitions.EnvironmentContainer.allOf[0].$ref` | `#/definitions/AssetContainer` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.EnvironmentContainer.description` | `Container for environment specification versions.` | `Azure Resource Manager resource envelope.` |
| `definitions.EnvironmentContainerResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/EnvironmentContainerResource` | `#/definitions/EnvironmentContainer` |
| `definitions.EnvironmentVariable.additionalProperties` | `true` | `{}` |
| `definitions.EnvironmentVersion.allOf[0].$ref` | `#/definitions/AssetBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.EnvironmentVersion.description` | `Environment version details.` | `Azure Resource Manager resource envelope.` |
| `definitions.EnvironmentVersionResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/EnvironmentVersionResource` | `#/definitions/EnvironmentVersion` |
| `definitions.Feature.allOf[0].$ref` | `#/definitions/ResourceBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.Feature.description` | `DTO object representing feature` | `Azure Resource Manager resource envelope.` |
| `definitions.FeatureResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/FeatureResource` | `#/definitions/Feature` |
| `definitions.FeaturesetContainer.allOf[0].$ref` | `#/definitions/AssetContainer` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.FeaturesetContainer.description` | `DTO object representing feature set` | `Azure Resource Manager resource envelope.` |
| `definitions.FeaturesetContainerResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/FeaturesetContainerResource` | `#/definitions/FeaturesetContainer` |
| `definitions.FeaturesetVersion.allOf[0].$ref` | `#/definitions/AssetBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.FeaturesetVersion.description` | `DTO object representing feature set version` | `Azure Resource Manager resource envelope.` |
| `definitions.FeaturesetVersionResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/FeaturesetVersionResource` | `#/definitions/FeaturesetVersion` |
| `definitions.FeaturestoreEntityContainer.allOf[0].$ref` | `#/definitions/AssetContainer` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.FeaturestoreEntityContainer.description` | `DTO object representing feature entity` | `Azure Resource Manager resource envelope.` |
| `definitions.FeaturestoreEntityContainerResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/FeaturestoreEntityContainerResource` | `#/definitions/FeaturestoreEntityContainer` |
| `definitions.FeaturestoreEntityVersion.allOf[0].$ref` | `#/definitions/AssetBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.FeaturestoreEntityVersion.description` | `DTO object representing feature entity version` | `Azure Resource Manager resource envelope.` |
| `definitions.FeaturestoreEntityVersionResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/FeaturestoreEntityVersionResource` | `#/definitions/FeaturestoreEntityVersion` |
| `definitions.FineTuningJob.allOf[0].$ref` | `#/definitions/JobBase` | `#/definitions/JobBaseProperties` |
| `definitions.FineTuningJob.properties.fineTuningDetails.description` | `[Required] ` | `[Required]` |
| `definitions.FineTuningJob.properties.outputs.description` | `[Required] ` | `[Required]` |
| `definitions.Forecasting.properties.forecastingSettings.description` | `Forecasting task specific inputs.` | `Primary metrics for Forecasting task.` |
| `definitions.Forecasting.properties.primaryMetric.description` | `Primary metrics for Forecasting task.` | `Primary metric for forecasting task.` |
| `definitions.ForecastingSettings.properties.countryOrRegionForHolidays.description` | `Country or region for holidays for forecasting tasks.
These should be ISO 3166 two-letter country/region codes, for example 'US' or 'GB'.` | `Country or region for holidays for forecasting tasks.
These should be ISO 3166 two-letter country/region codes, for example 'US' or 'GB'.` |
| `definitions.ForecastingSettings.properties.cvStepSize.description` | `Number of periods between the origin time of one CV fold and the next fold. For
example, if \`CVStepSize\` = 3 for daily data, the origin time for each fold will be
three days apart.` | `Number of periods between the origin time of one CV fold and the next fold. For
example, if \`CVStepSize\` = 3 for daily data, the origin time for each fold will be
three days apart.` |
| `definitions.ForecastingSettings.properties.seasonality.description` | `Set time series seasonality as an integer multiple of the series frequency.
If seasonality is set to 'auto', it will be inferred.` | `Set time series seasonality as an integer multiple of the series frequency.
If seasonality is set to 'auto', it will be inferred.` |
| `definitions.ForecastingSettings.properties.timeSeriesIdColumnNames.description` | `The names of columns used to group a timeseries. It can be used to create multiple series.
If grain is not defined, the data set is assumed to be one time-series. This parameter is used with task type forecasting.` | `The names of columns used to group a timeseries. It can be used to create multiple series.
If grain is not defined, the data set is assumed to be one time-series. This parameter is used with task type forecasting.` |
| `definitions.Image.additionalProperties` | `true` | `{}` |
| `definitions.ImageClassification.description` | `Image Classification. Multi-class image classification is used when an image is classified with only a single label
from a set of classes - e.g. each image is classified as either an image of a 'cat' or a 'dog' or a 'duck'.` | `Image Classification. Multi-class image classification is used when an image is classified with only a single label
from a set of classes - e.g. each image is classified as either an image of a 'cat' or a 'dog' or a 'duck'.` |
| `definitions.ImageClassificationMultilabel.description` | `Image Classification Multilabel. Multi-label image classification is used when an image could have one or more labels
from a set of labels - e.g. an image could be labeled with both 'cat' and 'dog'.` | `Image Classification Multilabel. Multi-label image classification is used when an image could have one or more labels
from a set of labels - e.g. an image could be labeled with both 'cat' and 'dog'.` |
| `definitions.ImageInstanceSegmentation.description` | `Image Instance Segmentation. Instance segmentation is used to identify objects in an image at the pixel level,
drawing a polygon around each object in the image.` | `Image Instance Segmentation. Instance segmentation is used to identify objects in an image at the pixel level,
drawing a polygon around each object in the image.` |
| `definitions.ImageModelDistributionSettings.description` | `Distribution expressions to sweep over values of model settings.
<example>
Some examples are:
\`\`\`
ModelName = "choice('seresnext', 'resnest50')";
LearningRate = "uniform(0.001, 0.01)";
LayersToFreeze = "choice(0, 2)";
\`\`\`</example>
All distributions can be specified as distribution_name(min, max) or choice(val1, val2, ..., valn)
where distribution name can be: uniform, quniform, loguniform, etc
For more details on how to compose distribution expressions please check the documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-tune-hyperparameters
For more information on the available settings please visit the official documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` | `Distribution expressions to sweep over values of model settings.
<example>
Some examples are:
\`\`\`
ModelName = "choice('seresnext', 'resnest50')";
LearningRate = "uniform(0.001, 0.01)";
LayersToFreeze = "choice(0, 2)";
\`\`\`</example>
All distributions can be specified as distribution_name(min, max) or choice(val1, val2, ..., valn)
where distribution name can be: uniform, quniform, loguniform, etc
For more details on how to compose distribution expressions please check the documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-tune-hyperparameters
For more information on the available settings please visit the official documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` |
| `definitions.ImageModelDistributionSettings.properties.earlyStoppingDelay.description` | `Minimum number of epochs or validation evaluations to wait before primary metric improvement
is tracked for early stopping. Must be a positive integer.` | `Minimum number of epochs or validation evaluations to wait before primary metric improvement
is tracked for early stopping. Must be a positive integer.` |
| `definitions.ImageModelDistributionSettings.properties.earlyStoppingPatience.description` | `Minimum number of epochs or validation evaluations with no primary metric improvement before
the run is stopped. Must be a positive integer.` | `Minimum number of epochs or validation evaluations with no primary metric improvement before
the run is stopped. Must be a positive integer.` |
| `definitions.ImageModelDistributionSettings.properties.gradientAccumulationStep.description` | `Gradient accumulation means running a configured number of "GradAccumulationStep" steps without
updating the model weights while accumulating the gradients of those steps, and then using
the accumulated gradients to compute the weight updates. Must be a positive integer.` | `Gradient accumulation means running a configured number of "GradAccumulationStep" steps without
updating the model weights while accumulating the gradients of those steps, and then using
the accumulated gradients to compute the weight updates. Must be a positive integer.` |
| `definitions.ImageModelDistributionSettings.properties.layersToFreeze.description` | `Number of layers to freeze for the model. Must be a positive integer.
For instance, passing 2 as value for 'seresnext' means
freezing layer0 and layer1. For a full list of models supported and details on layer freeze, please
see: https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` | `Number of layers to freeze for the model. Must be a positive integer.
For instance, passing 2 as value for 'seresnext' means
freezing layer0 and layer1. For a full list of models supported and details on layer freeze, please
see: https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` |
| `definitions.ImageModelDistributionSettings.properties.modelName.description` | `Name of the model to use for training.
For more information on the available models please visit the official documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` | `Name of the model to use for training.
For more information on the available models please visit the official documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` |
| `definitions.ImageModelDistributionSettingsClassification.description` | `Distribution expressions to sweep over values of model settings.
<example>
Some examples are:
\`\`\`
ModelName = "choice('seresnext', 'resnest50')";
LearningRate = "uniform(0.001, 0.01)";
LayersToFreeze = "choice(0, 2)";
\`\`\`</example>
For more details on how to compose distribution expressions please check the documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-tune-hyperparameters
For more information on the available settings please visit the official documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` | `Distribution expressions to sweep over values of model settings.
<example>
Some examples are:
\`\`\`
ModelName = "choice('seresnext', 'resnest50')";
LearningRate = "uniform(0.001, 0.01)";
LayersToFreeze = "choice(0, 2)";
\`\`\`</example>
For more details on how to compose distribution expressions please check the documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-tune-hyperparameters
For more information on the available settings please visit the official documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` |
| `definitions.ImageModelDistributionSettingsClassification.properties.weightedLoss.description` | `Weighted loss. The accepted values are 0 for no weighted loss.
1 for weighted loss with sqrt.(class_weights). 2 for weighted loss with class_weights. Must be 0 or 1 or 2.` | `Weighted loss. The accepted values are 0 for no weighted loss.
1 for weighted loss with sqrt.(class_weights). 2 for weighted loss with class_weights. Must be 0 or 1 or 2.` |
| `definitions.ImageModelDistributionSettingsObjectDetection.description` | `Distribution expressions to sweep over values of model settings.
<example>
Some examples are:
\`\`\`
ModelName = "choice('seresnext', 'resnest50')";
LearningRate = "uniform(0.001, 0.01)";
LayersToFreeze = "choice(0, 2)";
\`\`\`</example>
For more details on how to compose distribution expressions please check the documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-tune-hyperparameters
For more information on the available settings please visit the official documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` | `Distribution expressions to sweep over values of model settings.
<example>
Some examples are:
\`\`\`
ModelName = "choice('seresnext', 'resnest50')";
LearningRate = "uniform(0.001, 0.01)";
LayersToFreeze = "choice(0, 2)";
\`\`\`</example>
For more details on how to compose distribution expressions please check the documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-tune-hyperparameters
For more information on the available settings please visit the official documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.boxDetectionsPerImage.description` | `Maximum number of detections per image, for all classes. Must be a positive integer.
Note: This settings is not supported for the 'yolov5' algorithm.` | `Maximum number of detections per image, for all classes. Must be a positive integer.
Note: This settings is not supported for the 'yolov5' algorithm.` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.boxScoreThreshold.description` | `During inference, only return proposals with a classification score greater than
BoxScoreThreshold. Must be a float in the range[0, 1].` | `During inference, only return proposals with a classification score greater than
BoxScoreThreshold. Must be a float in the range[0, 1].` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.imageSize.description` | `Image size for train and validation. Must be a positive integer.
Note: The training run may get into CUDA OOM if the size is too big.
Note: This settings is only supported for the 'yolov5' algorithm.` | `Image size for train and validation. Must be a positive integer.
Note: The training run may get into CUDA OOM if the size is too big.
Note: This settings is only supported for the 'yolov5' algorithm.` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.maxSize.description` | `Maximum size of the image to be rescaled before feeding it to the backbone.
Must be a positive integer. Note: training run may get into CUDA OOM if the size is too big.
Note: This settings is not supported for the 'yolov5' algorithm.` | `Maximum size of the image to be rescaled before feeding it to the backbone.
Must be a positive integer. Note: training run may get into CUDA OOM if the size is too big.
Note: This settings is not supported for the 'yolov5' algorithm.` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.minSize.description` | `Minimum size of the image to be rescaled before feeding it to the backbone.
Must be a positive integer. Note: training run may get into CUDA OOM if the size is too big.
Note: This settings is not supported for the 'yolov5' algorithm.` | `Minimum size of the image to be rescaled before feeding it to the backbone.
Must be a positive integer. Note: training run may get into CUDA OOM if the size is too big.
Note: This settings is not supported for the 'yolov5' algorithm.` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.modelSize.description` | `Model size. Must be 'small', 'medium', 'large', or 'xlarge'.
Note: training run may get into CUDA OOM if the model size is too big.
Note: This settings is only supported for the 'yolov5' algorithm.` | `Model size. Must be 'small', 'medium', 'large', or 'xlarge'.
Note: training run may get into CUDA OOM if the model size is too big.
Note: This settings is only supported for the 'yolov5' algorithm.` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.multiScale.description` | `Enable multi-scale image by varying image size by +/- 50%.
Note: training run may get into CUDA OOM if no sufficient GPU memory.
Note: This settings is only supported for the 'yolov5' algorithm.` | `Enable multi-scale image by varying image size by +/- 50%.
Note: training run may get into CUDA OOM if no sufficient GPU memory.
Note: This settings is only supported for the 'yolov5' algorithm.` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.tileGridSize.description` | `The grid size to use for tiling each image. Note: TileGridSize must not be
None to enable small object detection logic. A string containing two integers in mxn format.
Note: This settings is not supported for the 'yolov5' algorithm.` | `The grid size to use for tiling each image. Note: TileGridSize must not be
None to enable small object detection logic. A string containing two integers in mxn format.
Note: This settings is not supported for the 'yolov5' algorithm.` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.tileOverlapRatio.description` | `Overlap ratio between adjacent tiles in each dimension. Must be float in the range [0, 1).
Note: This settings is not supported for the 'yolov5' algorithm.` | `Overlap ratio between adjacent tiles in each dimension. Must be float in the range [0, 1).
Note: This settings is not supported for the 'yolov5' algorithm.` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.tilePredictionsNmsThreshold.description` | `The IOU threshold to use to perform NMS while merging predictions from tiles and image.
Used in validation/ inference. Must be float in the range [0, 1].
Note: This settings is not supported for the 'yolov5' algorithm.
NMS: Non-maximum suppression` | `The IOU threshold to use to perform NMS while merging predictions from tiles and image.
Used in validation/ inference. Must be float in the range [0, 1].
Note: This settings is not supported for the 'yolov5' algorithm.
NMS: Non-maximum suppression` |
| `definitions.ImageModelSettings.description` | `Settings used for training the model.
For more information on the available settings please visit the official documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` | `Settings used for training the model.
For more information on the available settings please visit the official documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` |
| `definitions.ImageModelSettings.properties.earlyStoppingDelay.description` | `Minimum number of epochs or validation evaluations to wait before primary metric improvement
is tracked for early stopping. Must be a positive integer.` | `Minimum number of epochs or validation evaluations to wait before primary metric improvement
is tracked for early stopping. Must be a positive integer.` |
| `definitions.ImageModelSettings.properties.earlyStoppingPatience.description` | `Minimum number of epochs or validation evaluations with no primary metric improvement before
the run is stopped. Must be a positive integer.` | `Minimum number of epochs or validation evaluations with no primary metric improvement before
the run is stopped. Must be a positive integer.` |
| `definitions.ImageModelSettings.properties.gradientAccumulationStep.description` | `Gradient accumulation means running a configured number of "GradAccumulationStep" steps without
updating the model weights while accumulating the gradients of those steps, and then using
the accumulated gradients to compute the weight updates. Must be a positive integer.` | `Gradient accumulation means running a configured number of "GradAccumulationStep" steps without
updating the model weights while accumulating the gradients of those steps, and then using
the accumulated gradients to compute the weight updates. Must be a positive integer.` |
| `definitions.ImageModelSettings.properties.layersToFreeze.description` | `Number of layers to freeze for the model. Must be a positive integer.
For instance, passing 2 as value for 'seresnext' means
freezing layer0 and layer1. For a full list of models supported and details on layer freeze, please
see: https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` | `Number of layers to freeze for the model. Must be a positive integer.
For instance, passing 2 as value for 'seresnext' means
freezing layer0 and layer1. For a full list of models supported and details on layer freeze, please
see: https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` |
| `definitions.ImageModelSettings.properties.modelName.description` | `Name of the model to use for training.
For more information on the available models please visit the official documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` | `Name of the model to use for training.
For more information on the available models please visit the official documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` |
| `definitions.ImageModelSettingsClassification.description` | `Settings used for training the model.
For more information on the available settings please visit the official documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` | `Settings used for training the model.
For more information on the available settings please visit the official documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` |
| `definitions.ImageModelSettingsClassification.properties.weightedLoss.description` | `Weighted loss. The accepted values are 0 for no weighted loss.
1 for weighted loss with sqrt.(class_weights). 2 for weighted loss with class_weights. Must be 0 or 1 or 2.` | `Weighted loss. The accepted values are 0 for no weighted loss.
1 for weighted loss with sqrt.(class_weights). 2 for weighted loss with class_weights. Must be 0 or 1 or 2.` |
| `definitions.ImageModelSettingsObjectDetection.description` | `Settings used for training the model.
For more information on the available settings please visit the official documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` | `Settings used for training the model.
For more information on the available settings please visit the official documentation:
https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.` |
| `definitions.ImageModelSettingsObjectDetection.properties.boxDetectionsPerImage.description` | `Maximum number of detections per image, for all classes. Must be a positive integer.
Note: This settings is not supported for the 'yolov5' algorithm.` | `Maximum number of detections per image, for all classes. Must be a positive integer.
Note: This settings is not supported for the 'yolov5' algorithm.` |
| `definitions.ImageModelSettingsObjectDetection.properties.boxScoreThreshold.description` | `During inference, only return proposals with a classification score greater than
BoxScoreThreshold. Must be a float in the range[0, 1].` | `During inference, only return proposals with a classification score greater than
BoxScoreThreshold. Must be a float in the range[0, 1].` |
| `definitions.ImageModelSettingsObjectDetection.properties.imageSize.description` | `Image size for train and validation. Must be a positive integer.
Note: The training run may get into CUDA OOM if the size is too big.
Note: This settings is only supported for the 'yolov5' algorithm.` | `Image size for train and validation. Must be a positive integer.
Note: The training run may get into CUDA OOM if the size is too big.
Note: This settings is only supported for the 'yolov5' algorithm.` |
| `definitions.ImageModelSettingsObjectDetection.properties.maxSize.description` | `Maximum size of the image to be rescaled before feeding it to the backbone.
Must be a positive integer. Note: training run may get into CUDA OOM if the size is too big.
Note: This settings is not supported for the 'yolov5' algorithm.` | `Maximum size of the image to be rescaled before feeding it to the backbone.
Must be a positive integer. Note: training run may get into CUDA OOM if the size is too big.
Note: This settings is not supported for the 'yolov5' algorithm.` |
| `definitions.ImageModelSettingsObjectDetection.properties.minSize.description` | `Minimum size of the image to be rescaled before feeding it to the backbone.
Must be a positive integer. Note: training run may get into CUDA OOM if the size is too big.
Note: This settings is not supported for the 'yolov5' algorithm.` | `Minimum size of the image to be rescaled before feeding it to the backbone.
Must be a positive integer. Note: training run may get into CUDA OOM if the size is too big.
Note: This settings is not supported for the 'yolov5' algorithm.` |
| `definitions.ImageModelSettingsObjectDetection.properties.multiScale.description` | `Enable multi-scale image by varying image size by +/- 50%.
Note: training run may get into CUDA OOM if no sufficient GPU memory.
Note: This settings is only supported for the 'yolov5' algorithm.` | `Enable multi-scale image by varying image size by +/- 50%.
Note: training run may get into CUDA OOM if no sufficient GPU memory.
Note: This settings is only supported for the 'yolov5' algorithm.` |
| `definitions.ImageModelSettingsObjectDetection.properties.tileGridSize.description` | `The grid size to use for tiling each image. Note: TileGridSize must not be
None to enable small object detection logic. A string containing two integers in mxn format.
Note: This settings is not supported for the 'yolov5' algorithm.` | `The grid size to use for tiling each image. Note: TileGridSize must not be
None to enable small object detection logic. A string containing two integers in mxn format.
Note: This settings is not supported for the 'yolov5' algorithm.` |
| `definitions.ImageModelSettingsObjectDetection.properties.tileOverlapRatio.description` | `Overlap ratio between adjacent tiles in each dimension. Must be float in the range [0, 1).
Note: This settings is not supported for the 'yolov5' algorithm.` | `Overlap ratio between adjacent tiles in each dimension. Must be float in the range [0, 1).
Note: This settings is not supported for the 'yolov5' algorithm.` |
| `definitions.ImageModelSettingsObjectDetection.properties.tilePredictionsNmsThreshold.description` | `The IOU threshold to use to perform NMS while merging predictions from tiles and image.
Used in validation/ inference. Must be float in the range [0, 1].
Note: This settings is not supported for the 'yolov5' algorithm.` | `The IOU threshold to use to perform NMS while merging predictions from tiles and image.
Used in validation/ inference. Must be float in the range [0, 1].
Note: This settings is not supported for the 'yolov5' algorithm.` |
| `definitions.ImageObjectDetection.description` | `Image Object Detection. Object detection is used to identify objects in an image and locate each object with a
bounding box e.g. locate all dogs and cats in an image and draw a bounding box around each.` | `Image Object Detection. Object detection is used to identify objects in an image and locate each object with a
bounding box e.g. locate all dogs and cats in an image and draw a bounding box around each.` |
| `definitions.InferenceEndpoint.allOf[0].$ref` | `#/definitions/PropertiesBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.InferenceEndpoint.description` | `InferenceEndpoint configuration` | `Concrete tracked resource types can be created by aliasing this type using a specific property type.` |
| `definitions.InferenceEndpointTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/InferenceEndpointTrackedResource` | `#/definitions/InferenceEndpoint` |
| `definitions.InferenceGroup.allOf[0].$ref` | `#/definitions/PropertiesBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.InferenceGroup.description` | `Inference group configuration` | `Concrete tracked resource types can be created by aliasing this type using a specific property type.` |
| `definitions.InferenceGroupTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/InferenceGroupTrackedResource` | `#/definitions/InferenceGroup` |
| `definitions.InferencePool.allOf[0].$ref` | `#/definitions/PropertiesBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.InferencePool.description` | `Inference pool configuration` | `Concrete tracked resource types can be created by aliasing this type using a specific property type.` |
| `definitions.InferencePoolTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/InferencePoolTrackedResource` | `#/definitions/InferencePool` |
| `definitions.JobBase.allOf[0].$ref` | `#/definitions/ResourceBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.JobBase.description` | `Base definition for a job.` | `Azure Resource Manager resource envelope.` |
| `definitions.JobBaseResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/JobBaseResource` | `#/definitions/JobBase` |
| `definitions.JobScheduleAction.properties.jobDefinition.$ref` | `#/definitions/JobBase` | `#/definitions/JobBaseProperties` |
| `definitions.JobService.properties.nodes.description` | `Nodes that user would like to start the service on.
If Nodes is not set or set to null, the service will only be started on leader node.` | `Nodes that user would like to start the service on.
If Nodes is not set or set to null, the service will only be started on leader node.` |
| `definitions.KeyVaultProperties.properties.identityClientId.description` | `Currently, we support only SystemAssigned MSI.
We need this when we support UserAssignedIdentities` | `Currently, we support only SystemAssigned MSI.
We need this when we support UserAssignedIdentities` |
| `definitions.KubernetesOnlineDeployment.allOf[0].$ref` | `#/definitions/OnlineDeployment` | `#/definitions/OnlineDeploymentProperties` |
| `definitions.ManagedOnlineDeployment.allOf[0].$ref` | `#/definitions/OnlineDeployment` | `#/definitions/OnlineDeploymentProperties` |
| `definitions.MarketplaceSubscriptionResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/MarketplaceSubscriptionResource` | `#/definitions/MarketplaceSubscription` |
| `definitions.MLTableData.allOf[0].$ref` | `#/definitions/DataVersionBase` | `#/definitions/DataVersionBaseProperties` |
| `definitions.ModelContainer.allOf[0].$ref` | `#/definitions/AssetContainer` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ModelContainerResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/ModelContainerResource` | `#/definitions/ModelContainer` |
| `definitions.ModelVersion.allOf[0].$ref` | `#/definitions/AssetBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ModelVersion.description` | `Model asset version details.` | `Azure Resource Manager resource envelope.` |
| `definitions.ModelVersionResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/ModelVersionResource` | `#/definitions/ModelVersion` |
| `definitions.OneLakeDatastore.allOf[0].$ref` | `#/definitions/Datastore` | `#/definitions/DatastoreProperties` |
| `definitions.OnlineDeployment.allOf[0].$ref` | `#/definitions/EndpointDeploymentPropertiesBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.OnlineDeploymentTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/OnlineDeploymentTrackedResource` | `#/definitions/OnlineDeployment` |
| `definitions.OnlineEndpoint.allOf[0].$ref` | `#/definitions/EndpointPropertiesBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.OnlineEndpoint.description` | `Online endpoint configuration` | `Concrete tracked resource types can be created by aliasing this type using a specific property type.` |
| `definitions.OnlineEndpointTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/OnlineEndpointTrackedResource` | `#/definitions/OnlineEndpoint` |
| `definitions.OnlineRequestSettings.properties.maxQueueWait.description` | `(Deprecated for Managed Online Endpoints) The maximum amount of time a request will stay in the queue in ISO 8601 format.
Defaults to 500ms.
(Now increase \`request_timeout_ms\` to account for any networking/queue delays)` | `(Deprecated for Managed Online Endpoints) The maximum amount of time a request will stay in the queue in ISO 8601 format.
Defaults to 500ms.
(Now increase \`request_timeout_ms\` to account for any networking/queue delays)` |
| `definitions.OnlineRequestSettings.properties.requestTimeout.description` | `The scoring timeout in ISO 8601 format.
Defaults to 5000ms.` | `The scoring timeout in ISO 8601 format.
Defaults to 5000ms.` |
| `definitions.PendingUploadResponseDto.properties.pendingUploadType.description` | `Type of storage to use for the pending upload location` | `TemporaryBlobReference is the only supported type` |
| `definitions.PipelineJob.allOf[0].$ref` | `#/definitions/JobBase` | `#/definitions/JobBaseProperties` |
| `definitions.PrivateEndpointConnection.properties.location.description` | `Same as workspace location.` | `*Same as workspace location.` |
| `definitions.PrivateEndpointConnectionListResult.description` | `List of private endpoint connection associated with the specified workspace` | `[Placeholder] Discription for page model` |
| `definitions.PrivateEndpointConnectionListResult.properties.value.description` | `Array of private endpoint connections` | `[Placeholder] Discription for value property` |
| `definitions.PrivateLinkResourceListResult.description` | `A list of private link resources` | `[Placeholder] Discription for page model` |
| `definitions.PrivateLinkServiceConnectionState.properties.status.description` | `Connection status of the service consumer with the service provider
Possible state transitions
Pending -> Approved (Service provider approves the connection request)
Pending -> Rejected (Service provider rejects the connection request)
Pending -> Disconnected (Service provider deletes the connection)
Approved -> Rejected (Service provider rejects the approved connection)
Approved -> Disconnected (Service provider deletes the connection)
Rejected -> Pending (Service consumer re-initiates the connection request that was rejected)
Rejected -> Disconnected (Service provider deletes the connection)` | `Connection status of the service consumer with the service provider` |
| `definitions.Recurrence.properties.timeZone.description` | `Specifies time zone in which the schedule runs.
TimeZone should follow Windows time zone format. Refer: https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/default-time-zones?view=windows-11` | `Specifies time zone in which the schedule runs.
TimeZone should follow Windows time zone format. Refer: https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/default-time-zones?view=windows-11` |
| `definitions.Registry.description` | `Details of the Registry` | `Concrete tracked resource types can be created by aliasing this type using a specific property type.` |
| `definitions.RegistryPrivateEndpointConnection.properties.id.description` | `This is the private endpoint connection name created on SRP
Full resource id: /subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.MachineLearningServices/{resourceType}/{resourceName}/registryPrivateEndpointConnections/{peConnectionName}` | `This is the private endpoint connection name created on SRP
Full resource id: /subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.MachineLearningServices/{resourceType}/{resourceName}/registryPrivateEndpointConnections/{peConnectionName}` |
| `definitions.RegistryTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/RegistryTrackedResource` | `#/definitions/Registry` |
| `definitions.RequestConfiguration.properties.requestTimeout.description` | `The scoring timeout in ISO 8601 format.
Defaults to 5000ms.` | `The scoring timeout in ISO 8601 format.
Defaults to 5000ms.` |
| `definitions.SamplingAlgorithm.description` | `The Sampling Algorithm used to generate hyperparameter values, along with properties to
configure the algorithm` | `The Sampling Algorithm used to generate hyperparameter values, along with properties to
configure the algorithm` |
| `definitions.SASCredentialDto.properties.sasUri.format` | `uri` | `password` |
| `definitions.Schedule.allOf[0].$ref` | `#/definitions/ResourceBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.Schedule.description` | `Base definition of a schedule` | `Azure Resource Manager resource envelope.` |
| `definitions.ScheduleResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/ScheduleResource` | `#/definitions/Schedule` |
| `definitions.ServerlessEndpointTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/ServerlessEndpointTrackedResource` | `#/definitions/ServerlessEndpoint` |
| `definitions.SharedPrivateLinkResourceProperty.properties.status.description` | `Connection status of the service consumer with the service provider
Possible state transitions
Pending -> Approved (Service provider approves the connection request)
Pending -> Rejected (Service provider rejects the connection request)
Pending -> Disconnected (Service provider deletes the connection)
Approved -> Rejected (Service provider rejects the approved connection)
Approved -> Disconnected (Service provider deletes the connection)
Rejected -> Pending (Service consumer re-initiates the connection request that was rejected)
Rejected -> Disconnected (Service provider deletes the connection)` | `Connection status of the service consumer with the service provider` |
| `definitions.SparkJob.allOf[0].$ref` | `#/definitions/JobBase` | `#/definitions/JobBaseProperties` |
| `definitions.StackEnsembleSettings.properties.stackMetaLearnerType.description` | `The meta-learner is a model trained on the output of the individual heterogeneous models.
Default meta-learners are LogisticRegression for classification tasks (or LogisticRegressionCV if cross-validation is enabled) and ElasticNet for regression/forecasting tasks (or ElasticNetCV if cross-validation is enabled).
This parameter can be one of the following strings: LogisticRegression, LogisticRegressionCV, LightGBMClassifier, ElasticNet, ElasticNetCV, LightGBMRegressor, or LinearRegression` | `The meta-learner is a model trained on the output of the individual heterogeneous models.\\r\\nDefault meta-learners are LogisticRegression for classification tasks (or LogisticRegressionCV if cross-validation is enabled) and ElasticNet for regression/forecasting tasks (or ElasticNetCV if cross-validation is enabled).\\r\\nThis parameter can be one of the following strings: LogisticRegression, LogisticRegressionCV, LightGBMClassifier, ElasticNet, ElasticNetCV, LightGBMRegressor, or LinearRegression` |
| `definitions.SweepJob.allOf[0].$ref` | `#/definitions/JobBase` | `#/definitions/JobBaseProperties` |
| `definitions.SystemCreatedStorageAccount.properties.storageAccountType.description` | `Allowed values:
"Standard_LRS",
"Standard_GRS",
"Standard_RAGRS",
"Standard_ZRS",
"Standard_GZRS",
"Standard_RAGZRS",
"Premium_LRS",
"Premium_ZRS"` | `Allowed values:
"Standard_LRS",
"Standard_GRS",
"Standard_RAGRS",
"Standard_ZRS",
"Standard_GZRS",
"Standard_RAGZRS",
"Premium_LRS",
"Premium_ZRS"` |
| `definitions.TableVerticalFeaturizationSettings.properties.mode.description` | `Featurization mode - determines data featurization mode.` | `Featurization mode - User can keep the default 'Auto' mode and AutoML will take care of necessary transformation of the data in featurization phase.
If 'Off' is selected then no featurization is done.
If 'Custom' is selected then user can specify additional inputs to customize how featurization is done.` |
| `definitions.TextClassification.description` | `Text Classification task in AutoML NLP vertical.
NLP - Natural Language Processing.` | `Text Classification task in AutoML NLP vertical.
NLP - Natural Language Processing.` |
| `definitions.TextClassificationMultilabel.description` | `Text Classification Multilabel task in AutoML NLP vertical.
NLP - Natural Language Processing.` | `Text Classification Multilabel task in AutoML NLP vertical.
NLP - Natural Language Processing.` |
| `definitions.TextNer.description` | `Text-NER task in AutoML NLP vertical.
NER - Named Entity Recognition.
NLP - Natural Language Processing.` | `Text-NER task in AutoML NLP vertical.
NER - Named Entity Recognition.
NLP - Natural Language Processing.` |
| `definitions.TrainingSettings.properties.ensembleModelDownloadTimeout.description` | `During VotingEnsemble and StackEnsemble model generation, multiple fitted models from the previous child runs are downloaded.
Configure this parameter with a higher value than 300 secs, if more time is needed.` | `During VotingEnsemble and StackEnsemble model generation, multiple fitted models from the previous child runs are downloaded.
Configure this parameter with a higher value than 300 secs, if more time is needed.` |
| `definitions.TriggerBase.properties.endTime.description` | `Specifies end time of schedule in ISO 8601, but without a UTC offset. Refer https://en.wikipedia.org/wiki/ISO_8601.
Recommented format would be "2022-06-01T00:00:01"
If not present, the schedule will run indefinitely` | `Specifies end time of schedule in ISO 8601, but without a UTC offset. Refer https://en.wikipedia.org/wiki/ISO_8601.
Recommented format would be "2022-06-01T00:00:01"
If not present, the schedule will run indefinitely` |
| `definitions.TriggerBase.properties.timeZone.description` | `Specifies time zone in which the schedule runs.
TimeZone should follow Windows time zone format. Refer: https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/default-time-zones?view=windows-11` | `Specifies time zone in which the schedule runs.
TimeZone should follow Windows time zone format. Refer: https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/default-time-zones?view=windows-11` |
| `definitions.TriggerBase.properties.triggerType.description` | `[Required] ` | `[Required]` |
| `definitions.UpdateWorkspaceQuotas.properties.status.readOnly` | `false` | `true` |
| `definitions.UriFileDataVersion.allOf[0].$ref` | `#/definitions/DataVersionBase` | `#/definitions/DataVersionBaseProperties` |
| `definitions.UriFolderDataVersion.allOf[0].$ref` | `#/definitions/DataVersionBase` | `#/definitions/DataVersionBaseProperties` |
| `definitions.WorkspaceConnectionOAuth2.description` | `ClientId and ClientSecret are required. Other properties are optional
depending on each OAuth2 provider's implementation.` | `ClientId and ClientSecret are required. Other properties are optional
depending on each OAuth2 provider's implementation.` |
| `definitions.WorkspaceConnectionOAuth2.properties.authUrl.format` | `url` | `uri` |
| `definitions.WorkspaceConnectionOAuth2.properties.refreshToken.description` | `Required by GoogleBigQuery, GoogleAdWords, Hubspot, QuickBooks, Square, Xero, Zoho
where user needs to get RefreshToken offline` | `Required by GoogleBigQuery, GoogleAdWords, Hubspot, QuickBooks, Square, Xero, Zoho
where user needs to get RefreshToken offline` |
| `definitions.WorkspaceConnectionOAuth2.properties.username.description` | `Concur, ServiceNow auth server AccessToken grant type is 'Password'
which requires UsernamePassword` | `Concur, ServiceNow auth server AccessToken grant type is 'Password'
which requires UsernamePassword` |
| `definitions.WorkspaceProperties.properties.agentsEndpointUri.format` | `url` | `uri` |
| `definitions.WorkspaceProperties.properties.provisioningState.description` | `The current deployment state of workspace resource. The provisioningState is to indicate states for resource provisioning.` | `The provision state of the cluster. Valid values are Unknown, Updating, Provisioning, Succeeded, and Failed.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}'].get.responses.200.schema.$ref` | `#/definitions/RegistryTrackedResource` | `#/definitions/Registry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}'].patch.responses.200.schema.$ref` | `#/definitions/RegistryTrackedResource` | `#/definitions/Registry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}'].put.parameters[1].schema.$ref` | `#/definitions/RegistryTrackedResource` | `#/definitions/Registry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}'].put.responses.200.schema.$ref` | `#/definitions/RegistryTrackedResource` | `#/definitions/Registry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}'].put.responses.201.schema.$ref` | `#/definitions/RegistryTrackedResource` | `#/definitions/Registry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}'].get.responses.200.schema.$ref` | `#/definitions/CodeContainerResource` | `#/definitions/CodeContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}'].put.parameters[3].schema.$ref` | `#/definitions/CodeContainerResource` | `#/definitions/CodeContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}'].put.responses.200.schema.$ref` | `#/definitions/CodeContainerResource` | `#/definitions/CodeContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}'].put.responses.201.schema.$ref` | `#/definitions/CodeContainerResource` | `#/definitions/CodeContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}/versions/{version}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}/versions/{version}'].get.responses.200.schema.$ref` | `#/definitions/CodeVersionResource` | `#/definitions/CodeVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}/versions/{version}'].put.parameters[4].schema.$ref` | `#/definitions/CodeVersionResource` | `#/definitions/CodeVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}/versions/{version}'].put.responses.200.schema.$ref` | `#/definitions/CodeVersionResource` | `#/definitions/CodeVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/codes/{codeName}/versions/{version}'].put.responses.201.schema.$ref` | `#/definitions/CodeVersionResource` | `#/definitions/CodeVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}'].get.responses.200.schema.$ref` | `#/definitions/ComponentContainerResource` | `#/definitions/ComponentContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}'].put.parameters[3].schema.$ref` | `#/definitions/ComponentContainerResource` | `#/definitions/ComponentContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}'].put.responses.200.schema.$ref` | `#/definitions/ComponentContainerResource` | `#/definitions/ComponentContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}'].put.responses.201.schema.$ref` | `#/definitions/ComponentContainerResource` | `#/definitions/ComponentContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}/versions/{version}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}/versions/{version}'].get.responses.200.schema.$ref` | `#/definitions/ComponentVersionResource` | `#/definitions/ComponentVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}/versions/{version}'].put.parameters[4].schema.$ref` | `#/definitions/ComponentVersionResource` | `#/definitions/ComponentVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}/versions/{version}'].put.responses.200.schema.$ref` | `#/definitions/ComponentVersionResource` | `#/definitions/ComponentVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/components/{componentName}/versions/{version}'].put.responses.201.schema.$ref` | `#/definitions/ComponentVersionResource` | `#/definitions/ComponentVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}'].get.responses.200.schema.$ref` | `#/definitions/DataContainerResource` | `#/definitions/DataContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}'].put.parameters[3].schema.$ref` | `#/definitions/DataContainerResource` | `#/definitions/DataContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}'].put.responses.200.schema.$ref` | `#/definitions/DataContainerResource` | `#/definitions/DataContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}'].put.responses.201.schema.$ref` | `#/definitions/DataContainerResource` | `#/definitions/DataContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}/versions/{version}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}/versions/{version}'].get.responses.200.schema.$ref` | `#/definitions/DataVersionBaseResource` | `#/definitions/DataVersionBase` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}/versions/{version}'].put.parameters[4].schema.$ref` | `#/definitions/DataVersionBaseResource` | `#/definitions/DataVersionBase` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}/versions/{version}'].put.responses.200.schema.$ref` | `#/definitions/DataVersionBaseResource` | `#/definitions/DataVersionBase` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}/versions/{version}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/data/{name}/versions/{version}'].put.responses.201.schema.$ref` | `#/definitions/DataVersionBaseResource` | `#/definitions/DataVersionBase` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}'].get.responses.200.schema.$ref` | `#/definitions/EnvironmentContainerResource` | `#/definitions/EnvironmentContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}'].put.parameters[3].schema.$ref` | `#/definitions/EnvironmentContainerResource` | `#/definitions/EnvironmentContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}'].put.responses.200.schema.$ref` | `#/definitions/EnvironmentContainerResource` | `#/definitions/EnvironmentContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}'].put.responses.201.schema.$ref` | `#/definitions/EnvironmentContainerResource` | `#/definitions/EnvironmentContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}/versions/{version}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}/versions/{version}'].get.responses.200.schema.$ref` | `#/definitions/EnvironmentVersionResource` | `#/definitions/EnvironmentVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}/versions/{version}'].put.parameters[4].schema.$ref` | `#/definitions/EnvironmentVersionResource` | `#/definitions/EnvironmentVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}/versions/{version}'].put.responses.200.schema.$ref` | `#/definitions/EnvironmentVersionResource` | `#/definitions/EnvironmentVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/environments/{environmentName}/versions/{version}'].put.responses.201.schema.$ref` | `#/definitions/EnvironmentVersionResource` | `#/definitions/EnvironmentVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}'].get.responses.200.schema.$ref` | `#/definitions/ModelContainerResource` | `#/definitions/ModelContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}'].put.parameters[3].schema.$ref` | `#/definitions/ModelContainerResource` | `#/definitions/ModelContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}'].put.responses.200.schema.$ref` | `#/definitions/ModelContainerResource` | `#/definitions/ModelContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}'].put.responses.201.schema.$ref` | `#/definitions/ModelContainerResource` | `#/definitions/ModelContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}/versions/{version}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}/versions/{version}'].get.responses.200.schema.$ref` | `#/definitions/ModelVersionResource` | `#/definitions/ModelVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}/versions/{version}'].put.parameters[4].schema.$ref` | `#/definitions/ModelVersionResource` | `#/definitions/ModelVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}/versions/{version}'].put.responses.200.schema.$ref` | `#/definitions/ModelVersionResource` | `#/definitions/ModelVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}/versions/{version}'].put.responses.201.schema.$ref` | `#/definitions/ModelVersionResource` | `#/definitions/ModelVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/removeRegions'].post.parameters[1].schema.$ref` | `#/definitions/RegistryTrackedResource` | `#/definitions/Registry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/removeRegions'].post.responses.200.schema.$ref` | `#/definitions/RegistryTrackedResource` | `#/definitions/Registry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/removeRegions'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}'].put.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].get.responses.200.schema.$ref` | `#/definitions/BatchEndpointTrackedResource` | `#/definitions/BatchEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].get.summary` | `Gets a batch inference endpoint by name.` | `Get batch inference endpoint by name.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].patch.parameters[1].name` | `endpointName` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].patch.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].patch.responses.200.schema.$ref` | `#/definitions/BatchEndpointTrackedResource` | `#/definitions/BatchEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].patch.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].put.parameters[1].name` | `endpointName` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].put.parameters[3].schema.$ref` | `#/definitions/BatchEndpointTrackedResource` | `#/definitions/BatchEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].put.responses.200.schema.$ref` | `#/definitions/BatchEndpointTrackedResource` | `#/definitions/BatchEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].put.responses.201.schema.$ref` | `#/definitions/BatchEndpointTrackedResource` | `#/definitions/BatchEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].put.summary` | `Creates a batch inference endpoint (asynchronous).` | `Create a batch inference endpoint (asynchronous).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].get.responses.200.schema.$ref` | `#/definitions/BatchDeploymentTrackedResource` | `#/definitions/BatchDeployment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].get.summary` | `Gets a batch inference deployment by id.` | `Get batch inference deployment by id.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].patch.parameters[1].name` | `endpointName` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].patch.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].patch.responses.200.schema.$ref` | `#/definitions/BatchDeploymentTrackedResource` | `#/definitions/BatchDeployment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].patch.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].put.parameters[1].name` | `endpointName` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].put.parameters[4].schema.$ref` | `#/definitions/BatchDeploymentTrackedResource` | `#/definitions/BatchDeployment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].put.responses.200.schema.$ref` | `#/definitions/BatchDeploymentTrackedResource` | `#/definitions/BatchDeployment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].put.responses.201.schema.$ref` | `#/definitions/BatchDeploymentTrackedResource` | `#/definitions/BatchDeployment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].get.responses.200.schema.$ref` | `#/definitions/CapabilityHostResource` | `#/definitions/CapabilityHost` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].put.parameters[3].schema.$ref` | `#/definitions/CapabilityHostResource` | `#/definitions/CapabilityHost` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].put.responses.200.schema.$ref` | `#/definitions/CapabilityHostResource` | `#/definitions/CapabilityHost` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].put.responses.201.schema.$ref` | `#/definitions/CapabilityHostResource` | `#/definitions/CapabilityHost` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}'].get.responses.200.schema.$ref` | `#/definitions/CodeContainerResource` | `#/definitions/CodeContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}'].get.summary` | `Get container.` | `Get containers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}'].put.parameters[3].schema.$ref` | `#/definitions/CodeContainerResource` | `#/definitions/CodeContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}'].put.responses.200.schema.$ref` | `#/definitions/CodeContainerResource` | `#/definitions/CodeContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}'].put.responses.201.schema.$ref` | `#/definitions/CodeContainerResource` | `#/definitions/CodeContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions/{version}'].get.responses.200.schema.$ref` | `#/definitions/CodeVersionResource` | `#/definitions/CodeVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions/{version}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions/{version}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions/{version}'].put.parameters[4].schema.$ref` | `#/definitions/CodeVersionResource` | `#/definitions/CodeVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions/{version}'].put.responses.200.schema.$ref` | `#/definitions/CodeVersionResource` | `#/definitions/CodeVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions/{version}'].put.responses.201.schema.$ref` | `#/definitions/CodeVersionResource` | `#/definitions/CodeVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions/{version}/publish'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}'].get.responses.200.schema.$ref` | `#/definitions/ComponentContainerResource` | `#/definitions/ComponentContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}'].put.parameters[3].schema.$ref` | `#/definitions/ComponentContainerResource` | `#/definitions/ComponentContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}'].put.responses.200.schema.$ref` | `#/definitions/ComponentContainerResource` | `#/definitions/ComponentContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}'].put.responses.201.schema.$ref` | `#/definitions/ComponentContainerResource` | `#/definitions/ComponentContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}/versions/{version}'].get.responses.200.schema.$ref` | `#/definitions/ComponentVersionResource` | `#/definitions/ComponentVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}/versions/{version}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}/versions/{version}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}/versions/{version}'].put.parameters[4].schema.$ref` | `#/definitions/ComponentVersionResource` | `#/definitions/ComponentVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}/versions/{version}'].put.responses.200.schema.$ref` | `#/definitions/ComponentVersionResource` | `#/definitions/ComponentVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}/versions/{version}'].put.responses.201.schema.$ref` | `#/definitions/ComponentVersionResource` | `#/definitions/ComponentVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}/versions/{version}/publish'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections'].get.summary` | `Lists all the available machine learning workspaces connections under the specified workspace.` | `List all the available machine learning workspaces connections under the specified workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/deployments/{deploymentName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/addRaiBlocklistItems'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/raiBlocklistItems/{raiBlocklistItemName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiPolicies/{raiPolicyName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/testconnection'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}'].get.responses.200.schema.$ref` | `#/definitions/DataContainerResource` | `#/definitions/DataContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}'].put.parameters[3].schema.$ref` | `#/definitions/DataContainerResource` | `#/definitions/DataContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}'].put.responses.200.schema.$ref` | `#/definitions/DataContainerResource` | `#/definitions/DataContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}'].put.responses.201.schema.$ref` | `#/definitions/DataContainerResource` | `#/definitions/DataContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}/versions/{version}'].get.responses.200.schema.$ref` | `#/definitions/DataVersionBaseResource` | `#/definitions/DataVersionBase` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}/versions/{version}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}/versions/{version}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}/versions/{version}'].put.parameters[4].schema.$ref` | `#/definitions/DataVersionBaseResource` | `#/definitions/DataVersionBase` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}/versions/{version}'].put.responses.200.schema.$ref` | `#/definitions/DataVersionBaseResource` | `#/definitions/DataVersionBase` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}/versions/{version}'].put.responses.201.schema.$ref` | `#/definitions/DataVersionBaseResource` | `#/definitions/DataVersionBase` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}/versions/{version}/publish'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/datastores/{name}'].get.responses.200.schema.$ref` | `#/definitions/DatastoreResource` | `#/definitions/Datastore` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/datastores/{name}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/datastores/{name}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/datastores/{name}'].put.parameters[4].schema.$ref` | `#/definitions/DatastoreResource` | `#/definitions/Datastore` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/datastores/{name}'].put.responses.200.schema.$ref` | `#/definitions/DatastoreResource` | `#/definitions/Datastore` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/datastores/{name}'].put.responses.201.schema.$ref` | `#/definitions/DatastoreResource` | `#/definitions/Datastore` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/diagnose'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}'].get.summary` | `Gets endpoint resource` | `Get endpoint resource` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}'].put.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}'].put.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/raiPolicies/{raiPolicyName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}'].get.responses.200.schema.$ref` | `#/definitions/EnvironmentContainerResource` | `#/definitions/EnvironmentContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}'].put.parameters[3].schema.$ref` | `#/definitions/EnvironmentContainerResource` | `#/definitions/EnvironmentContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}'].put.responses.200.schema.$ref` | `#/definitions/EnvironmentContainerResource` | `#/definitions/EnvironmentContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}'].put.responses.201.schema.$ref` | `#/definitions/EnvironmentContainerResource` | `#/definitions/EnvironmentContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}/versions/{version}'].get.responses.200.schema.$ref` | `#/definitions/EnvironmentVersionResource` | `#/definitions/EnvironmentVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}/versions/{version}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}/versions/{version}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}/versions/{version}'].put.parameters[4].schema.$ref` | `#/definitions/EnvironmentVersionResource` | `#/definitions/EnvironmentVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}/versions/{version}'].put.responses.200.schema.$ref` | `#/definitions/EnvironmentVersionResource` | `#/definitions/EnvironmentVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}/versions/{version}'].put.responses.201.schema.$ref` | `#/definitions/EnvironmentVersionResource` | `#/definitions/EnvironmentVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}/versions/{version}/publish'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{featuresetName}/versions/{featuresetVersion}/features/{featureName}'].get.responses.200.schema.$ref` | `#/definitions/FeatureResource` | `#/definitions/Feature` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}'].get.responses.200.schema.$ref` | `#/definitions/FeaturesetContainerResource` | `#/definitions/FeaturesetContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}'].put.parameters[3].schema.$ref` | `#/definitions/FeaturesetContainerResource` | `#/definitions/FeaturesetContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}'].put.responses.200.schema.$ref` | `#/definitions/FeaturesetContainerResource` | `#/definitions/FeaturesetContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}'].put.responses.201.schema.$ref` | `#/definitions/FeaturesetContainerResource` | `#/definitions/FeaturesetContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].get.responses.200.schema.$ref` | `#/definitions/FeaturesetVersionResource` | `#/definitions/FeaturesetVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].put.parameters[4].schema.$ref` | `#/definitions/FeaturesetVersionResource` | `#/definitions/FeaturesetVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].put.responses.200.schema.$ref` | `#/definitions/FeaturesetVersionResource` | `#/definitions/FeaturesetVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].put.responses.201.schema.$ref` | `#/definitions/FeaturesetVersionResource` | `#/definitions/FeaturesetVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}/backfill'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].get.responses.200.schema.$ref` | `#/definitions/FeaturestoreEntityContainerResource` | `#/definitions/FeaturestoreEntityContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].put.parameters[3].schema.$ref` | `#/definitions/FeaturestoreEntityContainerResource` | `#/definitions/FeaturestoreEntityContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].put.responses.200.schema.$ref` | `#/definitions/FeaturestoreEntityContainerResource` | `#/definitions/FeaturestoreEntityContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].put.responses.201.schema.$ref` | `#/definitions/FeaturestoreEntityContainerResource` | `#/definitions/FeaturestoreEntityContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].get.responses.200.schema.$ref` | `#/definitions/FeaturestoreEntityVersionResource` | `#/definitions/FeaturestoreEntityVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].put.parameters[4].schema.$ref` | `#/definitions/FeaturestoreEntityVersionResource` | `#/definitions/FeaturestoreEntityVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].put.responses.200.schema.$ref` | `#/definitions/FeaturestoreEntityVersionResource` | `#/definitions/FeaturestoreEntityVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].put.responses.201.schema.$ref` | `#/definitions/FeaturestoreEntityVersionResource` | `#/definitions/FeaturestoreEntityVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{inferencePoolName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{inferencePoolName}'].get.responses.200.schema.$ref` | `#/definitions/InferencePoolTrackedResource` | `#/definitions/InferencePool` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{inferencePoolName}'].patch.responses.200.schema.$ref` | `#/definitions/InferencePoolTrackedResource` | `#/definitions/InferencePool` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{inferencePoolName}'].patch.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{inferencePoolName}'].put.parameters[3].schema.$ref` | `#/definitions/InferencePoolTrackedResource` | `#/definitions/InferencePool` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{inferencePoolName}'].put.responses.200.schema.$ref` | `#/definitions/InferencePoolTrackedResource` | `#/definitions/InferencePool` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{inferencePoolName}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{inferencePoolName}'].put.responses.201.schema.$ref` | `#/definitions/InferencePoolTrackedResource` | `#/definitions/InferencePool` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}'].get.responses.200.schema.$ref` | `#/definitions/InferenceEndpointTrackedResource` | `#/definitions/InferenceEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}'].patch.responses.200.schema.$ref` | `#/definitions/InferenceEndpointTrackedResource` | `#/definitions/InferenceEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}'].patch.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}'].put.parameters[4].schema.$ref` | `#/definitions/InferenceEndpointTrackedResource` | `#/definitions/InferenceEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}'].put.responses.200.schema.$ref` | `#/definitions/InferenceEndpointTrackedResource` | `#/definitions/InferenceEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}'].put.responses.201.schema.$ref` | `#/definitions/InferenceEndpointTrackedResource` | `#/definitions/InferenceEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}'].get.responses.200.schema.$ref` | `#/definitions/InferenceGroupTrackedResource` | `#/definitions/InferenceGroup` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}'].patch.responses.200.schema.$ref` | `#/definitions/InferenceGroupTrackedResource` | `#/definitions/InferenceGroup` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}'].patch.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}'].put.parameters[4].schema.$ref` | `#/definitions/InferenceGroupTrackedResource` | `#/definitions/InferenceGroup` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}'].put.responses.200.schema.$ref` | `#/definitions/InferenceGroupTrackedResource` | `#/definitions/InferenceGroup` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}'].put.responses.201.schema.$ref` | `#/definitions/InferenceGroupTrackedResource` | `#/definitions/InferenceGroup` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/deltaModels/modify'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/jobs/{id}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/jobs/{id}'].get.responses.200.schema.$ref` | `#/definitions/JobBaseResource` | `#/definitions/JobBase` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/jobs/{id}'].put.parameters[1].name` | `id` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/jobs/{id}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/jobs/{id}'].put.parameters[3].schema.$ref` | `#/definitions/JobBaseResource` | `#/definitions/JobBase` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/jobs/{id}'].put.responses.200.schema.$ref` | `#/definitions/JobBaseResource` | `#/definitions/JobBase` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/jobs/{id}'].put.responses.201.schema.$ref` | `#/definitions/JobBaseResource` | `#/definitions/JobBase` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/jobs/{id}/cancel'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/listConnectionModels'].post.summary` | `Get models under the Azure ML workspace for all Azure OpenAI connections that the user can deploy.` | `Get all models under the Azure ML workspace for all Azure OpenAI connections that the user can deploy.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks'].get.summary` | `List API for managed network settings of a machine learning workspace.` | `List the managed network settings for a machine learning workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks/{managedNetworkName}'].get.summary` | `Get API for managed network settings of a machine learning workspace.` | `Get the managed network settings for a machine learning workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks/{managedNetworkName}'].patch.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks/{managedNetworkName}'].put.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks/{managedNetworkName}/batchOutboundRules'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}'].put.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions/{name}'].delete.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions/{name}'].delete.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions/{name}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions/{name}'].get.responses.200.schema.$ref` | `#/definitions/MarketplaceSubscriptionResource` | `#/definitions/MarketplaceSubscription` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions/{name}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions/{name}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions/{name}'].put.parameters[3].schema.$ref` | `#/definitions/MarketplaceSubscriptionResource` | `#/definitions/MarketplaceSubscription` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions/{name}'].put.responses.200.schema.$ref` | `#/definitions/MarketplaceSubscriptionResource` | `#/definitions/MarketplaceSubscription` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions/{name}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/marketplaceSubscriptions/{name}'].put.responses.201.schema.$ref` | `#/definitions/MarketplaceSubscriptionResource` | `#/definitions/MarketplaceSubscription` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}'].get.responses.200.schema.$ref` | `#/definitions/ModelContainerResource` | `#/definitions/ModelContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}'].put.parameters[3].schema.$ref` | `#/definitions/ModelContainerResource` | `#/definitions/ModelContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}'].put.responses.200.schema.$ref` | `#/definitions/ModelContainerResource` | `#/definitions/ModelContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}'].put.responses.201.schema.$ref` | `#/definitions/ModelContainerResource` | `#/definitions/ModelContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}/versions/{version}'].get.responses.200.schema.$ref` | `#/definitions/ModelVersionResource` | `#/definitions/ModelVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}/versions/{version}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}/versions/{version}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}/versions/{version}'].put.parameters[4].schema.$ref` | `#/definitions/ModelVersionResource` | `#/definitions/ModelVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}/versions/{version}'].put.responses.200.schema.$ref` | `#/definitions/ModelVersionResource` | `#/definitions/ModelVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}/versions/{version}'].put.responses.201.schema.$ref` | `#/definitions/ModelVersionResource` | `#/definitions/ModelVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}/versions/{version}/publish'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}'].get.responses.200.schema.$ref` | `#/definitions/OnlineEndpointTrackedResource` | `#/definitions/OnlineEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}'].patch.responses.200.schema.$ref` | `#/definitions/OnlineEndpointTrackedResource` | `#/definitions/OnlineEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}'].patch.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}'].put.parameters[1].name` | `endpointName` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}'].put.parameters[3].schema.$ref` | `#/definitions/OnlineEndpointTrackedResource` | `#/definitions/OnlineEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}'].put.responses.200.schema.$ref` | `#/definitions/OnlineEndpointTrackedResource` | `#/definitions/OnlineEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}'].put.responses.201.schema.$ref` | `#/definitions/OnlineEndpointTrackedResource` | `#/definitions/OnlineEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].get.responses.200.schema.$ref` | `#/definitions/OnlineDeploymentTrackedResource` | `#/definitions/OnlineDeployment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].patch.parameters[1].name` | `endpointName` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].patch.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].patch.responses.200.schema.$ref` | `#/definitions/OnlineDeploymentTrackedResource` | `#/definitions/OnlineDeployment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].patch.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].put.parameters[1].name` | `endpointName` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].put.parameters[4].schema.$ref` | `#/definitions/OnlineDeploymentTrackedResource` | `#/definitions/OnlineDeployment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].put.responses.200.schema.$ref` | `#/definitions/OnlineDeploymentTrackedResource` | `#/definitions/OnlineDeployment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/deployments/{deploymentName}'].put.responses.201.schema.$ref` | `#/definitions/OnlineDeploymentTrackedResource` | `#/definitions/OnlineDeployment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/onlineEndpoints/{endpointName}/regenerateKeys'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/outboundRules/{ruleName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/outboundRules/{ruleName}'].put.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/prepareNotebook'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/provisionManagedNetwork'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/resyncKeys'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules/{name}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules/{name}'].get.responses.200.schema.$ref` | `#/definitions/ScheduleResource` | `#/definitions/Schedule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules/{name}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules/{name}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules/{name}'].put.parameters[3].schema.$ref` | `#/definitions/ScheduleResource` | `#/definitions/Schedule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules/{name}'].put.responses.200.schema.$ref` | `#/definitions/ScheduleResource` | `#/definitions/Schedule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules/{name}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/schedules/{name}'].put.responses.201.schema.$ref` | `#/definitions/ScheduleResource` | `#/definitions/Schedule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].delete.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].delete.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].get.responses.200.schema.$ref` | `#/definitions/ServerlessEndpointTrackedResource` | `#/definitions/ServerlessEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].patch.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].patch.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].patch.responses.200.schema.$ref` | `#/definitions/ServerlessEndpointTrackedResource` | `#/definitions/ServerlessEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].patch.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].put.parameters[1].pattern` | `^[a-zA-Z][a-zA-Z0-9-]{0,51}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].put.parameters[3].schema.$ref` | `#/definitions/ServerlessEndpointTrackedResource` | `#/definitions/ServerlessEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].put.responses.200.schema.$ref` | `#/definitions/ServerlessEndpointTrackedResource` | `#/definitions/ServerlessEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `URI to poll for asynchronous operation status.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}'].put.responses.201.schema.$ref` | `#/definitions/ServerlessEndpointTrackedResource` | `#/definitions/ServerlessEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}/listKeys'].post.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}/listKeys'].post.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}/regenerateKeys'].post.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}/regenerateKeys'].post.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/serverlessEndpoints/{name}/regenerateKeys'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |

