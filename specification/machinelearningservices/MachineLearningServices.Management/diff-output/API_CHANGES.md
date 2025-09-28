## Swagger Changes

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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].put.responses.201.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].put.responses.201.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].put.responses.201.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}'].delete.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}'].put.responses.201.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}'].put.responses.201.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].put.responses.201.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].put.responses.201.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].put.responses.201.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URI to poll for asynchronous operation status."}` |

### Changes for `200`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].delete.responses.200__added` | added | `{"description":"ignore"}` |

### Changes for `Location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}'].put.responses.201.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |

### Changes for `x-ms-long-running-operation-options`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}'].patch['x-ms-long-running-operation-options__added']` | added | `{"final-state-via":"azure-async-operation","final-state-schema":"#/definitions/ComputeResource"}` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AutoMLJob.properties.outputs.additionalProperties.description__deleted` | deleted | `Job output definition container information on where to find job output/logs.` |
| `definitions.CommandJob.properties.inputs.additionalProperties.description__deleted` | deleted | `Command job definition.` |
| `definitions.CommandJob.properties.outputs.additionalProperties.description__deleted` | deleted | `Job output definition container information on where to find job output/logs.` |
| `definitions.CustomMonitoringSignal.properties.inputAssets.additionalProperties.description__deleted` | deleted | `Monitoring input data base definition.` |
| `definitions.CustomMonitoringSignal.properties.inputs.additionalProperties.description__deleted` | deleted | `Command job definition.` |
| `definitions.DistillationJob.properties.outputs.additionalProperties.description__deleted` | deleted | `Job output definition container information on where to find job output/logs.` |
| `definitions.FineTuningJob.properties.outputs.additionalProperties.description__deleted` | deleted | `Job output definition container information on where to find job output/logs.` |
| `definitions.ManagedNetworkSettings.properties.outboundRules.additionalProperties.description__deleted` | deleted | `Outbound Rule for the managed network of a machine learning workspace.` |
| `definitions.NotificationSetting.properties.webhooks.additionalProperties.description__deleted` | deleted | `Webhook base` |
| `definitions.PipelineJob.properties.inputs.additionalProperties.description__deleted` | deleted | `Command job definition.` |
| `definitions.PipelineJob.properties.outputs.additionalProperties.description__deleted` | deleted | `Job output definition container information on where to find job output/logs.` |
| `definitions.PrivateEndpointConnectionListResult.description__added` | added | `[Placeholder] Discription for page model` |
| `definitions.PrivateEndpointConnectionListResult.properties.value.description__added` | added | `[Placeholder] Discription for value property` |
| `definitions.PrivateLinkResourceListResult.description__added` | added | `[Placeholder] Discription for page model` |
| `definitions.PrivateLinkResourceListResult.properties.value.description__added` | added | `[Placeholder] Discription for value property` |
| `definitions.SparkJob.properties.inputs.additionalProperties.description__deleted` | deleted | `Command job definition.` |
| `definitions.SparkJob.properties.outputs.additionalProperties.description__deleted` | deleted | `Job output definition container information on where to find job output/logs.` |
| `definitions.SweepJob.properties.inputs.additionalProperties.description__deleted` | deleted | `Command job definition.` |
| `definitions.SweepJob.properties.outputs.additionalProperties.description__deleted` | deleted | `Job output definition container information on where to find job output/logs.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/resize'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/datastores/{name}/listSecrets'].post.responses.200.schema.description__deleted` | deleted | `Base definition for datastore secrets.` |

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
| `definitions.AKSSchema__deleted` | deleted | `{"type":"object","properties":{"properties":{"type":"object","properties":{"clusterFqdn":{"type":"st...` |

### Changes for `AksComputeSecretsProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AksComputeSecretsProperties__deleted` | deleted | `{"type":"object","properties":{"userKubeConfig":{"type":"string"},"adminKubeConfig":{"type":"string"...` |

### Changes for `AmlComputeSchema`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AmlComputeSchema__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/AmlComputeProperties"}}}` |

### Changes for `AssetJobInput`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AssetJobInput__deleted` | deleted | `{"type":"object","properties":{"mode":{"type":"string","default":"ReadOnlyMount","enum":["ReadOnlyMo...` |

### Changes for `AssetJobOutput`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AssetJobOutput__deleted` | deleted | `{"type":"object","properties":{"assetName":{"type":"string","x-nullable":true},"mode":{"type":"strin...` |

### Changes for `AzureDatastore`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDatastore__deleted` | deleted | `{"type":"object","properties":{"resourceGroup":{"type":"string","x-nullable":true},"subscriptionId":...` |

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
| `definitions.CapabilityHostResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/CapabilityHost"}},"required":["pr...` |

### Changes for `CapacityConfig`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapacityConfig__deleted` | deleted | `{"type":"object","properties":{"minimum":{"type":"integer","format":"int32"},"maximum":{"type":"inte...` |

### Changes for `CodeContainerResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CodeContainerResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/CodeContainer"}},"required":["pro...` |

### Changes for `CodeVersionResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CodeVersionResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/CodeVersion"}},"required":["prope...` |

### Changes for `CognitiveServiceEndpointDeploymentResourceProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CognitiveServiceEndpointDeploymentResourceProperties__deleted` | deleted | `{"type":"object","properties":{"model":{"$ref":"#/definitions/EndpointDeploymentModel"},"raiPolicyNa...` |

### Changes for `ComponentContainerResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComponentContainerResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ComponentContainer"}},"required":...` |

### Changes for `ComponentVersionResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComponentVersionResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ComponentVersion"}},"required":["...` |

### Changes for `ComputeInstanceSchema`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComputeInstanceSchema__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ComputeInstanceProperties"}}}` |

### Changes for `DataContainerResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataContainerResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/DataContainer"}},"required":["pro...` |

### Changes for `DataLakeAnalyticsSchema`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataLakeAnalyticsSchema__deleted` | deleted | `{"type":"object","properties":{"properties":{"type":"object","properties":{"dataLakeStoreAccountName...` |

### Changes for `DataVersionBaseResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataVersionBaseResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/DataVersionBase"}},"required":["p...` |

### Changes for `DatabricksComputeSecretsProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatabricksComputeSecretsProperties__deleted` | deleted | `{"type":"object","properties":{"databricksAccessToken":{"type":"string"}}}` |

### Changes for `DatabricksSchema`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatabricksSchema__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/DatabricksProperties"}}}` |

### Changes for `DatastoreResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatastoreResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/Datastore"}},"required":["propert...` |

### Changes for `EnvironmentContainerResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentContainerResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/EnvironmentContainer"}},"required...` |

### Changes for `EnvironmentVersionResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersionResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/EnvironmentVersion"}},"required":...` |

### Changes for `FeatureResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeatureResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/Feature"}},"required":["propertie...` |

### Changes for `FeaturesetContainerResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturesetContainerResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/FeaturesetContainer"}},"required"...` |

### Changes for `FeaturesetVersionResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturesetVersionResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/FeaturesetVersion"}},"required":[...` |

### Changes for `FeaturestoreEntityContainerResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturestoreEntityContainerResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/FeaturestoreEntityContainer"}},"r...` |

### Changes for `FeaturestoreEntityVersionResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturestoreEntityVersionResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/FeaturestoreEntityVersion"}},"req...` |

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
| `definitions.ImageVertical__deleted` | deleted | `{"type":"object","properties":{"limitSettings":{"$ref":"#/definitions/ImageLimitSettings"},"sweepSet...` |

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
| `definitions.InstanceResourceSchema__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"}}` |

### Changes for `JobBaseResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBaseResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/JobBase"}},"required":["propertie...` |

### Changes for `KubernetesSchema`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.KubernetesSchema__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/KubernetesProperties"}}}` |

### Changes for `MarketplaceSubscriptionResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MarketplaceSubscriptionResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/MarketplaceSubscription"}},"requi...` |

### Changes for `ModelContainerResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelContainerResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ModelContainer"}},"required":["pr...` |

### Changes for `ModelVersionResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelVersionResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ModelVersion"}},"required":["prop...` |

### Changes for `NlpVertical`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NlpVertical__deleted` | deleted | `{"type":"object","properties":{"featurizationSettings":{"$ref":"#/definitions/NlpVerticalFeaturizati...` |

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
| `definitions.PartialRegistry__deleted` | deleted | `{"type":"object"}` |

### Changes for `PartialUserAssignedIdentity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PartialUserAssignedIdentity__deleted` | deleted | `{"type":"object"}` |

### Changes for `RaiBlocklistItemsBulkDeleteRequest`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RaiBlocklistItemsBulkDeleteRequest__deleted` | deleted | `{"type":"object","items":{"type":"string"}}` |

### Changes for `RegistryTrackedResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RegistryTrackedResource__deleted` | deleted | `{"type":"object","properties":{"identity":{"$ref":"../../../../../common-types/resource-management/v...` |

### Changes for `ScheduleResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScheduleResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/Schedule"}},"required":["properti...` |

### Changes for `ServerlessEndpointTrackedResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerlessEndpointTrackedResource__deleted` | deleted | `{"type":"object","properties":{"identity":{"$ref":"../../../../../common-types/resource-management/v...` |

### Changes for `TableVertical`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TableVertical__deleted` | deleted | `{"type":"object","properties":{"cvSplitColumnNames":{"type":"array","x-nullable":true,"items":{"type...` |

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
| `definitions.AKSSchemaProperties__added` | added | `{"type":"object","properties":{"clusterFqdn":{"type":"string","x-nullable":true},"systemServices":{"...` |

### Changes for `Azure.ResourceManager.ArmResponse<RaiBlocklistItemPropertiesBasicResource[]>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<RaiBlocklistItemPropertiesBasicResource[]>__added']` | added | `{"type":"object","properties":{"body":{"type":"array","items":{"$ref":"#/definitions/RaiBlocklistIte...` |

### Changes for `BatchDeploymentProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeploymentProperties__added` | added | `{"type":"object","properties":{"compute":{"type":"string","x-nullable":true},"deploymentConfiguratio...` |

### Changes for `BatchEndpointProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchEndpointProperties__added` | added | `{"type":"object","properties":{"defaults":{"$ref":"#/definitions/BatchEndpointDefaults"},"provisioni...` |

### Changes for `CapabilityHostProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapabilityHostProperties__added` | added | `{"type":"object","properties":{"aiServicesConnections":{"type":"array","x-nullable":true,"items":{"t...` |

### Changes for `CodeContainerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CodeContainerProperties__added` | added | `{"type":"object","properties":{"provisioningState":{"type":"string","enum":["Succeeded","Failed","Ca...` |

### Changes for `CodeVersionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CodeVersionProperties__added` | added | `{"type":"object","properties":{"codeUri":{"type":"string","x-nullable":true},"provisioningState":{"t...` |

### Changes for `ComponentContainerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComponentContainerProperties__added` | added | `{"type":"object","properties":{"provisioningState":{"type":"string","enum":["Succeeded","Failed","Ca...` |

### Changes for `ComponentVersionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComponentVersionProperties__added` | added | `{"type":"object","properties":{"componentSpec":{"type":"object","x-nullable":true,"additionalPropert...` |

### Changes for `DataContainerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataContainerProperties__added` | added | `{"type":"object","properties":{"dataType":{"type":"string","enum":["uri_file","uri_folder","mltable"...` |

### Changes for `DataLakeAnalyticsSchemaProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataLakeAnalyticsSchemaProperties__added` | added | `{"type":"object","properties":{"dataLakeStoreAccountName":{"type":"string"}}}` |

### Changes for `DataVersionBaseProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataVersionBaseProperties__added` | added | `{"type":"object","properties":{"dataType":{"type":"string","enum":["uri_file","uri_folder","mltable"...` |

### Changes for `DatastoreProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatastoreProperties__added` | added | `{"type":"object","properties":{"credentials":{"$ref":"#/definitions/DatastoreCredentials"},"datastor...` |

### Changes for `DiagnoseResponseResultValue`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DiagnoseResponseResultValue__added` | added | `{"type":"object","properties":{"userDefinedRouteResults":{"type":"array","items":{"$ref":"#/definiti...` |

### Changes for `EnvironmentContainerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentContainerProperties__added` | added | `{"type":"object","properties":{"provisioningState":{"type":"string","enum":["Succeeded","Failed","Ca...` |

### Changes for `EnvironmentVersionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersionProperties__added` | added | `{"type":"object","properties":{"autoRebuild":{"type":"string","default":"Disabled","enum":["Disabled...` |

### Changes for `FeatureProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeatureProperties__added` | added | `{"type":"object","properties":{"dataType":{"type":"string","default":"String","enum":["String","Inte...` |

### Changes for `FeaturesetContainerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturesetContainerProperties__added` | added | `{"type":"object","properties":{"provisioningState":{"type":"string","enum":["Succeeded","Failed","Ca...` |

### Changes for `FeaturesetVersionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturesetVersionProperties__added` | added | `{"type":"object","properties":{"entities":{"type":"array","x-nullable":true,"items":{"type":"string"...` |

### Changes for `FeaturestoreEntityContainerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturestoreEntityContainerProperties__added` | added | `{"type":"object","properties":{"provisioningState":{"type":"string","enum":["Succeeded","Failed","Ca...` |

### Changes for `FeaturestoreEntityVersionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturestoreEntityVersionProperties__added` | added | `{"type":"object","properties":{"indexColumns":{"type":"array","x-nullable":true,"items":{"$ref":"#/d...` |

### Changes for `InferenceEndpointProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceEndpointProperties__added` | added | `{"type":"object","properties":{"authMode":{"type":"string","enum":["AAD"],"x-ms-enum":{"name":"AuthM...` |

### Changes for `InferenceGroupProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceGroupProperties__added` | added | `{"type":"object","properties":{"environmentConfiguration":{"$ref":"#/definitions/GroupEnvironmentCon...` |

### Changes for `InferencePoolProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferencePoolProperties__added` | added | `{"type":"object","properties":{"provisioningState":{"type":"string","enum":["Creating","Deleting","S...` |

### Changes for `InstanceTypeSchemaResources`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InstanceTypeSchemaResources__added` | added | `{"type":"object","properties":{"requests":{"type":"object","additionalProperties":{"type":"string"}}...` |

### Changes for `JobBaseProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBaseProperties__added` | added | `{"type":"object","properties":{"componentId":{"type":"string","x-nullable":true,"x-ms-mutability":["...` |

### Changes for `MarketplaceSubscriptionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MarketplaceSubscriptionProperties__added` | added | `{"type":"object","properties":{"marketplacePlan":{"$ref":"#/definitions/MarketplacePlan","x-nullable...` |

### Changes for `ModelContainerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelContainerProperties__added` | added | `{"type":"object","properties":{"provisioningState":{"type":"string","enum":["Succeeded","Failed","Ca...` |

### Changes for `ModelVersionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelVersionProperties__added` | added | `{"type":"object","properties":{"flavors":{"type":"object","x-nullable":true,"additionalProperties":{...` |

### Changes for `OnlineDeploymentProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeploymentProperties__added` | added | `{"type":"object","properties":{"appInsightsEnabled":{"type":"boolean","default":false},"dataCollecto...` |

### Changes for `OnlineEndpointProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineEndpointProperties__added` | added | `{"type":"object","properties":{"compute":{"type":"string","x-nullable":true},"mirrorTraffic":{"type"...` |

### Changes for `RegistryProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RegistryProperties__added` | added | `{"type":"object","properties":{"discoveryUrl":{"type":"string","x-nullable":true},"intellectualPrope...` |

### Changes for `ScheduleProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScheduleProperties__added` | added | `{"type":"object","properties":{"action":{"$ref":"#/definitions/ScheduleActionBase","x-ms-mutability"...` |

### Changes for `ServerlessEndpointProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerlessEndpointProperties__added` | added | `{"type":"object","properties":{"authMode":{"type":"string","enum":["Key","AAD","KeyAndAAD"],"x-ms-en...` |

### Changes for `Stringforlist`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Stringforlist__added` | added | `{"type":"object","properties":{"string":{"type":"string"}}}` |

### Changes for `SynapseSparkProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SynapseSparkProperties__added` | added | `{"type":"object","properties":{"autoScaleProperties":{"$ref":"#/definitions/AutoScaleProperties"},"a...` |

### Changes for `TypeSpec.Http.NoContentResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['TypeSpec.Http.NoContentResponse__added']` | added | `{"type":"object"}` |

### Changes for `TypeSpec.Http.OkResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['TypeSpec.Http.OkResponse__added']` | added | `{"type":"object"}` |

### Changes for `VirtualMachineSchemaProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualMachineSchemaProperties__added` | added | `{"type":"object","properties":{"virtualMachineSize":{"type":"string"},"sshPort":{"type":"integer","f...` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AKS.properties__added` | added | `{"properties":{"$ref":"#/definitions/AKSSchemaProperties"}}` |
| `definitions.AksComputeSecrets.properties__added` | added | `{"userKubeConfig":{"type":"string"},"adminKubeConfig":{"type":"string"},"imagePullSecretName":{"type...` |
| `definitions.AmlCompute.properties__added` | added | `{"properties":{"$ref":"#/definitions/AmlComputeProperties"}}` |
| `definitions.BatchDeployment.properties.properties__added` | added | `{"$ref":"#/definitions/BatchDeploymentProperties"}` |
| `definitions.BatchEndpoint.properties.properties__added` | added | `{"$ref":"#/definitions/BatchEndpointProperties"}` |
| `definitions.CapabilityHost.properties.properties__added` | added | `{"$ref":"#/definitions/CapabilityHostProperties"}` |
| `definitions.CodeContainer.properties.properties__added` | added | `{"$ref":"#/definitions/CodeContainerProperties"}` |
| `definitions.CodeVersion.properties.properties__added` | added | `{"$ref":"#/definitions/CodeVersionProperties"}` |
| `definitions.ComponentContainer.properties.properties__added` | added | `{"$ref":"#/definitions/ComponentContainerProperties"}` |
| `definitions.ComponentVersion.properties.properties__added` | added | `{"$ref":"#/definitions/ComponentVersionProperties"}` |
| `definitions.ComputeInstance.properties__added` | added | `{"properties":{"$ref":"#/definitions/ComputeInstanceProperties"}}` |
| `definitions.ComputeResource.properties.properties__added` | added | `{"$ref":"#/definitions/ComputeResourceSchema"}` |
| `definitions.ContentSafetyEndpointDeploymentResourceProperties.properties__added` | added | `{"model":{"$ref":"#/definitions/EndpointDeploymentModel"},"raiPolicyName":{"type":"string"},"sku":{"...` |
| `definitions.CustomModelJobInput.properties__added` | added | `{"mode":{"type":"string","default":"ReadOnlyMount","enum":["ReadOnlyMount","ReadWriteMount","Downloa...` |
| `definitions.CustomModelJobOutput.properties__added` | added | `{"assetName":{"type":"string","x-nullable":true},"mode":{"type":"string","default":"ReadWriteMount",...` |
| `definitions.Databricks.properties__added` | added | `{"properties":{"$ref":"#/definitions/DatabricksProperties"}}` |
| `definitions.DatabricksComputeSecrets.properties__added` | added | `{"databricksAccessToken":{"type":"string"}}` |
| `definitions.DataContainer.properties.properties__added` | added | `{"$ref":"#/definitions/DataContainerProperties"}` |
| `definitions.DataLakeAnalytics.properties__added` | added | `{"properties":{"$ref":"#/definitions/DataLakeAnalyticsSchemaProperties"}}` |
| `definitions.Datastore.properties.properties__added` | added | `{"$ref":"#/definitions/DatastoreProperties"}` |
| `definitions.DataVersionBase.properties.properties__added` | added | `{"$ref":"#/definitions/DataVersionBaseProperties"}` |
| `definitions.DiagnoseResponseResult.properties.value.properties__deleted` | deleted | `{"userDefinedRouteResults":{"type":"array","items":{"$ref":"#/definitions/DiagnoseResult"},"x-ms-ide...` |
| `definitions.EnvironmentContainer.properties.properties__added` | added | `{"$ref":"#/definitions/EnvironmentContainerProperties"}` |
| `definitions.EnvironmentVersion.properties.properties__added` | added | `{"$ref":"#/definitions/EnvironmentVersionProperties"}` |
| `definitions.Feature.properties.properties__added` | added | `{"$ref":"#/definitions/FeatureProperties"}` |
| `definitions.FeaturesetContainer.properties.properties__added` | added | `{"$ref":"#/definitions/FeaturesetContainerProperties"}` |
| `definitions.FeaturesetVersion.properties.properties__added` | added | `{"$ref":"#/definitions/FeaturesetVersionProperties"}` |
| `definitions.FeaturestoreEntityContainer.properties.properties__added` | added | `{"$ref":"#/definitions/FeaturestoreEntityContainerProperties"}` |
| `definitions.FeaturestoreEntityVersion.properties.properties__added` | added | `{"$ref":"#/definitions/FeaturestoreEntityVersionProperties"}` |
| `definitions.HDInsight.properties__added` | added | `{"properties":{"$ref":"#/definitions/HDInsightProperties"}}` |
| `definitions.InferenceEndpoint.properties.properties__added` | added | `{"$ref":"#/definitions/InferenceEndpointProperties"}` |
| `definitions.InferenceGroup.properties.properties__added` | added | `{"$ref":"#/definitions/InferenceGroupProperties"}` |
| `definitions.InferencePool.properties.properties__added` | added | `{"$ref":"#/definitions/InferencePoolProperties"}` |
| `definitions.InstanceTypeSchema.properties.resources.properties__deleted` | deleted | `{"requests":{"$ref":"#/definitions/InstanceResourceSchema","description":"Resource requests for this...` |
| `definitions.JobBase.properties.properties__added` | added | `{"$ref":"#/definitions/JobBaseProperties"}` |
| `definitions.Kubernetes.properties__added` | added | `{"properties":{"$ref":"#/definitions/KubernetesProperties"}}` |
| `definitions.MarketplaceSubscription.properties.properties__added` | added | `{"$ref":"#/definitions/MarketplaceSubscriptionProperties"}` |
| `definitions.MLFlowModelJobInput.properties__added` | added | `{"mode":{"type":"string","default":"ReadOnlyMount","enum":["ReadOnlyMount","ReadWriteMount","Downloa...` |
| `definitions.MLFlowModelJobOutput.properties__added` | added | `{"assetName":{"type":"string","x-nullable":true},"mode":{"type":"string","default":"ReadWriteMount",...` |
| `definitions.MLTableJobInput.properties__added` | added | `{"mode":{"type":"string","default":"ReadOnlyMount","enum":["ReadOnlyMount","ReadWriteMount","Downloa...` |
| `definitions.MLTableJobOutput.properties__added` | added | `{"assetName":{"type":"string","x-nullable":true},"mode":{"type":"string","default":"ReadWriteMount",...` |
| `definitions.ModelContainer.properties.properties__added` | added | `{"$ref":"#/definitions/ModelContainerProperties"}` |
| `definitions.ModelVersion.properties.properties__added` | added | `{"$ref":"#/definitions/ModelVersionProperties"}` |
| `definitions.OnlineDeployment.properties.properties__added` | added | `{"$ref":"#/definitions/OnlineDeploymentProperties"}` |
| `definitions.OnlineEndpoint.properties.properties__added` | added | `{"$ref":"#/definitions/OnlineEndpointProperties"}` |
| `definitions.OpenAIEndpointDeploymentResourceProperties.properties__added` | added | `{"model":{"$ref":"#/definitions/EndpointDeploymentModel"},"raiPolicyName":{"type":"string"},"sku":{"...` |
| `definitions.Registry.properties.properties__added` | added | `{"$ref":"#/definitions/RegistryProperties","x-ms-client-flatten":true}` |
| `definitions.Schedule.properties.properties__added` | added | `{"$ref":"#/definitions/ScheduleProperties"}` |
| `definitions.ServerlessEndpoint.properties.properties__added` | added | `{"$ref":"#/definitions/ServerlessEndpointProperties"}` |
| `definitions.SpeechEndpointDeploymentResourceProperties.properties__added` | added | `{"model":{"$ref":"#/definitions/EndpointDeploymentModel"},"raiPolicyName":{"type":"string"},"sku":{"...` |
| `definitions.SynapseSpark.properties.properties.properties__deleted` | deleted | `{"autoScaleProperties":{"$ref":"#/definitions/AutoScaleProperties","description":"Auto scale propert...` |
| `definitions.TritonModelJobInput.properties__added` | added | `{"mode":{"type":"string","default":"ReadOnlyMount","enum":["ReadOnlyMount","ReadWriteMount","Downloa...` |
| `definitions.TritonModelJobOutput.properties__added` | added | `{"assetName":{"type":"string","x-nullable":true},"mode":{"type":"string","default":"ReadWriteMount",...` |
| `definitions.UriFileJobInput.properties__added` | added | `{"mode":{"type":"string","default":"ReadOnlyMount","enum":["ReadOnlyMount","ReadWriteMount","Downloa...` |
| `definitions.UriFileJobOutput.properties__added` | added | `{"assetName":{"type":"string","x-nullable":true},"mode":{"type":"string","default":"ReadWriteMount",...` |
| `definitions.UriFolderJobInput.properties__added` | added | `{"mode":{"type":"string","default":"ReadOnlyMount","enum":["ReadOnlyMount","ReadWriteMount","Downloa...` |
| `definitions.UriFolderJobOutput.properties__added` | added | `{"assetName":{"type":"string","x-nullable":true},"mode":{"type":"string","default":"ReadWriteMount",...` |
| `definitions.VirtualMachine.properties__added` | added | `{"properties":{"$ref":"#/definitions/VirtualMachineSchemaProperties"}}` |
| `definitions.VirtualMachineSecrets.properties__added` | added | `{"administratorAccount":{"$ref":"#/definitions/VirtualMachineSshCredentials"}}` |

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
| `definitions.VirtualMachineSshCredentials.properties.privateKeyData.format__added` | added | `password` |
| `definitions.VirtualMachineSshCredentials.properties.publicKeyData.format__added` | added | `password` |

### Changes for `x-ms-secret`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccountKeyDatastoreCredentials.properties.secrets['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.CertificateDatastoreCredentials.properties.secrets['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.EndpointKeys.properties.keys['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.EndpointPropertiesBase.properties.keys['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.SasDatastoreCredentials.properties.secrets['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.ServicePrincipalDatastoreCredentials.properties.secrets['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.UserAccountCredentials.properties.adminUserPassword['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.UserAccountCredentials.properties.adminUserSshPublicKey['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.WorkspaceConnectionOAuth2.properties.clientSecret['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.WorkspaceConnectionOAuth2.properties.developerToken['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.WorkspaceConnectionOAuth2.properties.password['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.WorkspaceConnectionOAuth2.properties.refreshToken['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.WorkspaceConnectionServicePrincipal.properties.clientSecret['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.WorkspaceConnectionUsernamePassword.properties.securityToken['x-ms-secret__deleted']` | deleted | `true` |

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
| `definitions.BatchRetrySettings.properties.timeout.default__deleted` | deleted | `PT30S` |
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
| `definitions.AzureBlobDatastore.properties.resourceGroup__added` | added | `{"type":"string","x-nullable":true}` |
| `definitions.AzureDataLakeGen1Datastore.properties.resourceGroup__added` | added | `{"type":"string","x-nullable":true}` |
| `definitions.AzureDataLakeGen2Datastore.properties.resourceGroup__added` | added | `{"type":"string","x-nullable":true}` |
| `definitions.AzureFileDatastore.properties.resourceGroup__added` | added | `{"type":"string","x-nullable":true}` |

### Changes for `subscriptionId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobDatastore.properties.subscriptionId__added` | added | `{"type":"string","x-nullable":true}` |
| `definitions.AzureDataLakeGen1Datastore.properties.subscriptionId__added` | added | `{"type":"string","x-nullable":true}` |
| `definitions.AzureDataLakeGen2Datastore.properties.subscriptionId__added` | added | `{"type":"string","x-nullable":true}` |
| `definitions.AzureFileDatastore.properties.subscriptionId__added` | added | `{"type":"string","x-nullable":true}` |

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
| `definitions.BatchDeployment.properties.compute__deleted` | deleted | `{"type":"string","x-nullable":true}` |
| `definitions.OnlineEndpoint.properties.compute__deleted` | deleted | `{"type":"string","x-nullable":true}` |

### Changes for `deploymentConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.deploymentConfiguration__deleted` | deleted | `{"$ref":"#/definitions/BatchDeploymentConfiguration","x-nullable":true}` |

### Changes for `errorThreshold`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.errorThreshold__deleted` | deleted | `{"type":"integer","format":"int32","default":-1}` |

### Changes for `loggingLevel`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.loggingLevel__deleted` | deleted | `{"type":"string","default":"Info","enum":["Info","Warning","Debug"],"x-ms-enum":{"name":"BatchLoggin...` |

### Changes for `maxConcurrencyPerInstance`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.maxConcurrencyPerInstance__deleted` | deleted | `{"type":"integer","format":"int32","default":1}` |

### Changes for `miniBatchSize`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.miniBatchSize__deleted` | deleted | `{"type":"integer","format":"int64","default":10}` |

### Changes for `model`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.model__deleted` | deleted | `{"$ref":"#/definitions/AssetReferenceBase","x-nullable":true}` |
| `definitions.OnlineDeployment.properties.model__deleted` | deleted | `{"type":"string","x-nullable":true}` |

### Changes for `outputAction`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.outputAction__deleted` | deleted | `{"type":"string","default":"AppendRow","enum":["SummaryOnly","AppendRow"],"x-ms-enum":{"name":"Batch...` |

### Changes for `outputFileName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.outputFileName__deleted` | deleted | `{"type":"string","default":"predictions.csv"}` |

### Changes for `provisioningState`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Creating","Deleting","Scaling","Updating","Succeeded","Failed","Canceled"]...` |
| `definitions.BatchEndpoint.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Creating","Deleting","Succeeded","Failed","Updating","Canceled"],"x-ms-enu...` |
| `definitions.CapabilityHost.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Succeeded","Failed","Canceled","Creating","Updating","Deleting"],"x-ms-enu...` |
| `definitions.CodeContainer.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Succeeded","Failed","Canceled","Creating","Updating","Deleting"],"x-ms-enu...` |
| `definitions.CodeVersion.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Succeeded","Failed","Canceled","Creating","Updating","Deleting"],"x-ms-enu...` |
| `definitions.ComponentContainer.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Succeeded","Failed","Canceled","Creating","Updating","Deleting"],"x-ms-enu...` |
| `definitions.ComponentVersion.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Succeeded","Failed","Canceled","Creating","Updating","Deleting"],"x-ms-enu...` |
| `definitions.EnvironmentContainer.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Succeeded","Failed","Canceled","Creating","Updating","Deleting"],"x-ms-enu...` |
| `definitions.EnvironmentVersion.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Succeeded","Failed","Canceled","Creating","Updating","Deleting"],"x-ms-enu...` |
| `definitions.FeaturesetContainer.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Succeeded","Failed","Canceled","Creating","Updating","Deleting"],"x-ms-enu...` |
| `definitions.FeaturesetVersion.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Succeeded","Failed","Canceled","Creating","Updating","Deleting"],"x-ms-enu...` |
| `definitions.FeaturestoreEntityContainer.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Succeeded","Failed","Canceled","Creating","Updating","Deleting"],"x-ms-enu...` |
| `definitions.FeaturestoreEntityVersion.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Succeeded","Failed","Canceled","Creating","Updating","Deleting"],"x-ms-enu...` |
| `definitions.InferenceEndpoint.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Creating","Deleting","Succeeded","Failed","Updating","Canceled"],"x-ms-enu...` |
| `definitions.InferenceGroup.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Creating","Deleting","Succeeded","Failed","Updating","Canceled"],"x-ms-enu...` |
| `definitions.InferencePool.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Creating","Deleting","Succeeded","Failed","Updating","Canceled"],"x-ms-enu...` |
| `definitions.MarketplaceSubscription.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Creating","Deleting","Succeeded","Failed","Updating","Canceled"],"x-ms-enu...` |
| `definitions.ModelContainer.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Succeeded","Failed","Canceled","Creating","Updating","Deleting"],"x-ms-enu...` |
| `definitions.ModelVersion.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Succeeded","Failed","Canceled","Creating","Updating","Deleting"],"x-ms-enu...` |
| `definitions.OnlineDeployment.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Creating","Deleting","Scaling","Updating","Succeeded","Failed","Canceled"]...` |
| `definitions.OnlineEndpoint.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Creating","Deleting","Succeeded","Failed","Updating","Canceled"],"x-ms-enu...` |
| `definitions.Schedule.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Creating","Updating","Deleting","Succeeded","Failed","Canceled"],"x-ms-enu...` |
| `definitions.ServerlessEndpoint.properties.provisioningState__deleted` | deleted | `{"type":"string","enum":["Creating","Deleting","Succeeded","Failed","Updating","Canceled"],"x-ms-enu...` |

### Changes for `resources`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.resources__deleted` | deleted | `{"$ref":"#/definitions/DeploymentResourceConfiguration","x-nullable":true}` |

### Changes for `retrySettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.retrySettings__deleted` | deleted | `{"$ref":"#/definitions/BatchRetrySettings","x-nullable":true}` |

### Changes for `identity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.identity__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Manage...` |
| `definitions.BatchEndpoint.properties.identity__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Manage...` |
| `definitions.InferenceEndpoint.properties.identity__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Manage...` |
| `definitions.InferenceGroup.properties.identity__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Manage...` |
| `definitions.InferencePool.properties.identity__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Manage...` |
| `definitions.JobBase.properties.identity__deleted` | deleted | `{"$ref":"#/definitions/IdentityConfiguration","x-nullable":true,"x-ms-mutability":["create","read"]}` |
| `definitions.OnlineDeployment.properties.identity__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Manage...` |
| `definitions.OnlineEndpoint.properties.identity__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Manage...` |
| `definitions.Registry.properties.identity__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Manage...` |
| `definitions.ServerlessEndpoint.properties.identity__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/managedidentity.json#/definitions/Manage...` |

### Changes for `kind`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.kind__added` | added | `{"type":"string"}` |
| `definitions.BatchEndpoint.properties.kind__added` | added | `{"type":"string"}` |
| `definitions.InferenceEndpoint.properties.kind__added` | added | `{"type":"string"}` |
| `definitions.InferenceGroup.properties.kind__added` | added | `{"type":"string"}` |
| `definitions.InferencePool.properties.kind__added` | added | `{"type":"string"}` |
| `definitions.OnlineDeployment.properties.kind__added` | added | `{"type":"string"}` |
| `definitions.OnlineEndpoint.properties.kind__added` | added | `{"type":"string"}` |
| `definitions.Registry.properties.kind__added` | added | `{"type":"string"}` |
| `definitions.ServerlessEndpoint.properties.kind__added` | added | `{"type":"string"}` |

### Changes for `sku`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchDeployment.properties.sku__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/Sku"}` |
| `definitions.BatchEndpoint.properties.sku__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/Sku"}` |
| `definitions.InferenceEndpoint.properties.sku__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/Sku"}` |
| `definitions.InferenceGroup.properties.sku__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/Sku"}` |
| `definitions.InferencePool.properties.sku__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/Sku"}` |
| `definitions.OnlineDeployment.properties.sku__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/Sku"}` |
| `definitions.OnlineEndpoint.properties.sku__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/Sku"}` |
| `definitions.Registry.properties.sku__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/Sku"}` |
| `definitions.ServerlessEndpoint.properties.sku__added` | added | `{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/Sku"}` |

### Changes for `defaults`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchEndpoint.properties.defaults__deleted` | deleted | `{"$ref":"#/definitions/BatchEndpointDefaults","x-nullable":true}` |

### Changes for `aiServicesConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapabilityHost.properties.aiServicesConnections__deleted` | deleted | `{"type":"array","x-nullable":true,"items":{"type":"string"}}` |

### Changes for `capabilityHostKind`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapabilityHost.properties.capabilityHostKind__deleted` | deleted | `{"type":"string","default":"Agents","enum":["Agents"],"x-ms-enum":{"name":"CapabilityHostKind","mode...` |

### Changes for `customerSubnet`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapabilityHost.properties.customerSubnet__deleted` | deleted | `{"type":"string","x-nullable":true}` |

### Changes for `storageConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapabilityHost.properties.storageConnections__deleted` | deleted | `{"type":"array","x-nullable":true,"items":{"type":"string"}}` |

### Changes for `threadStorageConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapabilityHost.properties.threadStorageConnections__deleted` | deleted | `{"type":"array","x-nullable":true,"items":{"type":"string"}}` |

### Changes for `vectorStoreConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapabilityHost.properties.vectorStoreConnections__deleted` | deleted | `{"type":"array","x-nullable":true,"items":{"type":"string"}}` |

### Changes for `cvSplitColumnNames`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.cvSplitColumnNames__added` | added | `{"type":"array","x-nullable":true,"items":{"type":"string"}}` |
| `definitions.Forecasting.properties.cvSplitColumnNames__added` | added | `{"type":"array","x-nullable":true,"items":{"type":"string"}}` |
| `definitions.Regression.properties.cvSplitColumnNames__added` | added | `{"type":"array","x-nullable":true,"items":{"type":"string"}}` |

### Changes for `featurizationSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.featurizationSettings__added` | added | `{"$ref":"#/definitions/TableVerticalFeaturizationSettings","x-nullable":true}` |
| `definitions.Forecasting.properties.featurizationSettings__added` | added | `{"$ref":"#/definitions/TableVerticalFeaturizationSettings","x-nullable":true}` |
| `definitions.Regression.properties.featurizationSettings__added` | added | `{"$ref":"#/definitions/TableVerticalFeaturizationSettings","x-nullable":true}` |
| `definitions.TextClassification.properties.featurizationSettings__added` | added | `{"$ref":"#/definitions/NlpVerticalFeaturizationSettings","x-nullable":true}` |
| `definitions.TextClassificationMultilabel.properties.featurizationSettings__added` | added | `{"$ref":"#/definitions/NlpVerticalFeaturizationSettings","x-nullable":true}` |
| `definitions.TextNer.properties.featurizationSettings__added` | added | `{"$ref":"#/definitions/NlpVerticalFeaturizationSettings","x-nullable":true}` |

### Changes for `limitSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.limitSettings__added` | added | `{"$ref":"#/definitions/TableVerticalLimitSettings","x-nullable":true}` |
| `definitions.Forecasting.properties.limitSettings__added` | added | `{"$ref":"#/definitions/TableVerticalLimitSettings","x-nullable":true}` |
| `definitions.ImageClassification.properties.limitSettings__added` | added | `{"$ref":"#/definitions/ImageLimitSettings"}` |
| `definitions.ImageClassificationMultilabel.properties.limitSettings__added` | added | `{"$ref":"#/definitions/ImageLimitSettings"}` |
| `definitions.ImageInstanceSegmentation.properties.limitSettings__added` | added | `{"$ref":"#/definitions/ImageLimitSettings"}` |
| `definitions.ImageObjectDetection.properties.limitSettings__added` | added | `{"$ref":"#/definitions/ImageLimitSettings"}` |
| `definitions.Regression.properties.limitSettings__added` | added | `{"$ref":"#/definitions/TableVerticalLimitSettings","x-nullable":true}` |
| `definitions.TextClassification.properties.limitSettings__added` | added | `{"$ref":"#/definitions/NlpVerticalLimitSettings","x-nullable":true}` |
| `definitions.TextClassificationMultilabel.properties.limitSettings__added` | added | `{"$ref":"#/definitions/NlpVerticalLimitSettings","x-nullable":true}` |
| `definitions.TextNer.properties.limitSettings__added` | added | `{"$ref":"#/definitions/NlpVerticalLimitSettings","x-nullable":true}` |

### Changes for `nCrossValidations`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.nCrossValidations__added` | added | `{"$ref":"#/definitions/NCrossValidations","x-nullable":true}` |
| `definitions.Forecasting.properties.nCrossValidations__added` | added | `{"$ref":"#/definitions/NCrossValidations","x-nullable":true}` |
| `definitions.Regression.properties.nCrossValidations__added` | added | `{"$ref":"#/definitions/NCrossValidations","x-nullable":true}` |

### Changes for `testData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.testData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","x-nullable":true}` |
| `definitions.Forecasting.properties.testData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","x-nullable":true}` |
| `definitions.Regression.properties.testData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","x-nullable":true}` |

### Changes for `testDataSize`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.testDataSize__added` | added | `{"type":"number","format":"double","x-nullable":true}` |
| `definitions.Forecasting.properties.testDataSize__added` | added | `{"type":"number","format":"double","x-nullable":true}` |
| `definitions.Regression.properties.testDataSize__added` | added | `{"type":"number","format":"double","x-nullable":true}` |

### Changes for `validationData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","x-nullable":true}` |
| `definitions.Forecasting.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","x-nullable":true}` |
| `definitions.ImageClassification.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","x-nullable":true}` |
| `definitions.ImageClassificationMultilabel.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","x-nullable":true}` |
| `definitions.ImageInstanceSegmentation.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","x-nullable":true}` |
| `definitions.ImageObjectDetection.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","x-nullable":true}` |
| `definitions.Regression.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","x-nullable":true}` |
| `definitions.TextClassification.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","x-nullable":true}` |
| `definitions.TextClassificationMultilabel.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","x-nullable":true}` |
| `definitions.TextNer.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","x-nullable":true}` |

### Changes for `validationDataSize`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.validationDataSize__added` | added | `{"type":"number","format":"double","x-nullable":true}` |
| `definitions.Forecasting.properties.validationDataSize__added` | added | `{"type":"number","format":"double","x-nullable":true}` |
| `definitions.ImageClassification.properties.validationDataSize__added` | added | `{"type":"number","format":"double","x-nullable":true}` |
| `definitions.ImageClassificationMultilabel.properties.validationDataSize__added` | added | `{"type":"number","format":"double","x-nullable":true}` |
| `definitions.ImageInstanceSegmentation.properties.validationDataSize__added` | added | `{"type":"number","format":"double","x-nullable":true}` |
| `definitions.ImageObjectDetection.properties.validationDataSize__added` | added | `{"type":"number","format":"double","x-nullable":true}` |
| `definitions.Regression.properties.validationDataSize__added` | added | `{"type":"number","format":"double","x-nullable":true}` |

### Changes for `weightColumnName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.weightColumnName__added` | added | `{"type":"string","x-nullable":true}` |
| `definitions.Forecasting.properties.weightColumnName__added` | added | `{"type":"string","x-nullable":true}` |
| `definitions.Regression.properties.weightColumnName__added` | added | `{"type":"string","x-nullable":true}` |

### Changes for `codeUri`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CodeVersion.properties.codeUri__deleted` | deleted | `{"type":"string","x-nullable":true,"example":"https://blobStorage/folderName"}` |

### Changes for `componentSpec`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComponentVersion.properties.componentSpec__deleted` | deleted | `{"type":"object","x-nullable":true,"example":{"code":"azureml:/subscriptions/00000000-1111-2222-3333...` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComputeInstanceConnectivityEndpoints.readOnly__deleted` | deleted | `true` |
| `definitions.ComputeInstanceCreatedBy.readOnly__deleted` | deleted | `true` |
| `definitions.ServerlessEndpointInferenceEndpoint.properties.uri.readOnly__added` | added | `true` |
| `definitions.ServerlessInferenceEndpoint.properties.uri.readOnly__added` | added | `true` |
| `definitions.UpdateWorkspaceQuotas.properties.status.readOnly__deleted` | deleted | `false` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComputeInstanceContainer.properties.services.items.additionalProperties__added` | added | `{}` |
| `definitions.EndpointScheduleAction.properties.endpointInvocationDefinition.additionalProperties__added` | added | `{}` |
| `definitions.PipelineJob.properties.settings.additionalProperties__added` | added | `{}` |
| `definitions.SweepJob.properties.searchSpace.additionalProperties__added` | added | `{}` |

### Changes for `x-nullable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComputeInstanceProperties.properties.computeInstanceAuthorizationType['x-nullable__deleted']` | deleted | `true` |
| `definitions.ComputeInstanceProperties.properties.enableOSPatching['x-nullable__deleted']` | deleted | `true` |
| `definitions.ComputeInstanceProperties.properties.enableRootAccess['x-nullable__deleted']` | deleted | `true` |
| `definitions.ComputeInstanceProperties.properties.enableSSO['x-nullable__deleted']` | deleted | `true` |
| `definitions.ComputeInstanceProperties.properties.releaseQuotaOnStop['x-nullable__deleted']` | deleted | `true` |
| `definitions.ComputeResource.properties.sku['x-nullable__deleted']` | deleted | `true` |
| `definitions.Forecasting.properties.forecastingSettings['x-nullable__deleted']` | deleted | `true` |
| `definitions.HDInsightProperties.properties.administratorAccount['x-nullable__deleted']` | deleted | `true` |
| `definitions.ManagedResourceGroupAssignedIdentities.properties.principalId['x-nullable__deleted']` | deleted | `false` |
| `definitions.PartialMinimalTrackedResource.properties.tags.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.PartialMinimalTrackedResource.properties.tags['x-nullable__added']` | added | `true` |
| `definitions.RegistryPrivateEndpointConnection.properties.properties['x-nullable__deleted']` | deleted | `true` |
| `definitions.ServicePrincipalDatastoreCredentials.properties.secrets['x-nullable__added']` | added | `true` |
| `definitions.UsageAndQuotaDetails.properties.modelCollection['x-nullable__deleted']` | deleted | `true` |
| `definitions.UsageAndQuotaDetails.properties.usageDetails['x-nullable__deleted']` | deleted | `true` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComputeResource.properties.location__deleted` | deleted | `{"type":"string"}` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComputeResource.properties.tags__deleted` | deleted | `{"type":"object","x-nullable":true,"additionalProperties":{"type":"string"}}` |

### Changes for `dataType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataContainer.properties.dataType__deleted` | deleted | `{"type":"string","enum":["uri_file","uri_folder","mltable"],"x-ms-enum":{"name":"DataType","modelAsS...` |
| `definitions.DataVersionBase.properties.dataType__deleted` | deleted | `{"type":"string","enum":["uri_file","uri_folder","mltable"],"x-ms-enum":{"name":"DataType","modelAsS...` |
| `definitions.Feature.properties.dataType__deleted` | deleted | `{"type":"string","default":"String","enum":["String","Integer","Long","Float","Double","Binary","Dat...` |

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
| `definitions.DataVersionBase.properties.dataUri__deleted` | deleted | `{"type":"string","minLength":1,"pattern":"[a-zA-Z0-9_]","x-ms-mutability":["create","read"]}` |

### Changes for `credentials`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Datastore.properties.credentials__deleted` | deleted | `{"$ref":"#/definitions/DatastoreCredentials"}` |

### Changes for `datastoreType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Datastore.properties.datastoreType__deleted` | deleted | `{"type":"string","enum":["AzureBlob","AzureDataLakeGen1","AzureDataLakeGen2","AzureFile","OneLake"],...` |

### Changes for `isDefault`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Datastore.properties.isDefault__deleted` | deleted | `{"type":"boolean","readOnly":true,"x-ms-mutability":["read"]}` |

### Changes for `uniqueItems`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeltaModelModifyRequest.properties.addDeltaModels.uniqueItems__deleted` | deleted | `true` |
| `definitions.DeltaModelModifyRequest.properties.removeDeltaModels.uniqueItems__deleted` | deleted | `true` |

### Changes for `autoRebuild`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersion.properties.autoRebuild__deleted` | deleted | `{"type":"string","default":"Disabled","enum":["Disabled","OnBaseImageUpdate"],"x-ms-enum":{"name":"A...` |

### Changes for `build`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersion.properties.build__deleted` | deleted | `{"$ref":"#/definitions/BuildContext","x-ms-mutability":["create","read"]}` |

### Changes for `condaFile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersion.properties.condaFile__deleted` | deleted | `{"type":"string","x-ms-mutability":["create","read"]}` |

### Changes for `environmentType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersion.properties.environmentType__deleted` | deleted | `{"type":"string","enum":["Curated","UserCreated"],"x-ms-enum":{"name":"EnvironmentType","modelAsStri...` |

### Changes for `image`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersion.properties.image__deleted` | deleted | `{"type":"string","example":"docker.io/tensorflow/serving:latest","x-ms-mutability":["create","read"]...` |

### Changes for `imageDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersion.properties.imageDetails__deleted` | deleted | `{"$ref":"#/definitions/ImageDetails"}` |

### Changes for `inferenceConfig`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersion.properties.inferenceConfig__deleted` | deleted | `{"$ref":"#/definitions/InferenceContainerProperties","x-ms-mutability":["create","read"]}` |

### Changes for `osType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersion.properties.osType__deleted` | deleted | `{"type":"string","default":"Linux","enum":["Linux","Windows"],"x-ms-enum":{"name":"OperatingSystemTy...` |

### Changes for `stage`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentVersion.properties.stage__deleted` | deleted | `{"type":"string","x-nullable":true}` |
| `definitions.FeaturesetVersion.properties.stage__deleted` | deleted | `{"type":"string","x-nullable":true}` |
| `definitions.FeaturestoreEntityVersion.properties.stage__deleted` | deleted | `{"type":"string","x-nullable":true}` |
| `definitions.ModelVersion.properties.stage__deleted` | deleted | `{"type":"string","x-nullable":true}` |

### Changes for `featureName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Feature.properties.featureName__deleted` | deleted | `{"type":"string","x-nullable":true}` |

### Changes for `entities`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturesetVersion.properties.entities__deleted` | deleted | `{"type":"array","x-nullable":true,"items":{"type":"string"}}` |

### Changes for `materializationSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturesetVersion.properties.materializationSettings__deleted` | deleted | `{"$ref":"#/definitions/MaterializationSettings","x-nullable":true}` |

### Changes for `specification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturesetVersion.properties.specification__deleted` | deleted | `{"$ref":"#/definitions/FeaturesetSpecification","x-nullable":true}` |

### Changes for `indexColumns`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturestoreEntityVersion.properties.indexColumns__deleted` | deleted | `{"type":"array","x-nullable":true,"items":{"$ref":"#/definitions/IndexColumn"}}` |

### Changes for `modelSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImageClassification.properties.modelSettings__added` | added | `{"$ref":"#/definitions/ImageModelSettingsClassification","x-nullable":true}` |
| `definitions.ImageClassificationMultilabel.properties.modelSettings__added` | added | `{"$ref":"#/definitions/ImageModelSettingsClassification","x-nullable":true}` |
| `definitions.ImageInstanceSegmentation.properties.modelSettings__added` | added | `{"$ref":"#/definitions/ImageModelSettingsObjectDetection","x-nullable":true}` |
| `definitions.ImageObjectDetection.properties.modelSettings__added` | added | `{"$ref":"#/definitions/ImageModelSettingsObjectDetection","x-nullable":true}` |
| `definitions.ServerlessEndpoint.properties.modelSettings__deleted` | deleted | `{"$ref":"#/definitions/ModelSettings","x-nullable":true}` |

### Changes for `searchSpace`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImageClassification.properties.searchSpace__added` | added | `{"type":"array","x-nullable":true,"items":{"$ref":"#/definitions/ImageModelDistributionSettingsClass...` |
| `definitions.ImageClassificationMultilabel.properties.searchSpace__added` | added | `{"type":"array","x-nullable":true,"items":{"$ref":"#/definitions/ImageModelDistributionSettingsClass...` |
| `definitions.ImageInstanceSegmentation.properties.searchSpace__added` | added | `{"type":"array","x-nullable":true,"items":{"$ref":"#/definitions/ImageModelDistributionSettingsObjec...` |
| `definitions.ImageObjectDetection.properties.searchSpace__added` | added | `{"type":"array","x-nullable":true,"items":{"$ref":"#/definitions/ImageModelDistributionSettingsObjec...` |

### Changes for `sweepSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImageClassification.properties.sweepSettings__added` | added | `{"$ref":"#/definitions/ImageSweepSettings","x-nullable":true}` |
| `definitions.ImageClassificationMultilabel.properties.sweepSettings__added` | added | `{"$ref":"#/definitions/ImageSweepSettings","x-nullable":true}` |
| `definitions.ImageInstanceSegmentation.properties.sweepSettings__added` | added | `{"$ref":"#/definitions/ImageSweepSettings","x-nullable":true}` |
| `definitions.ImageObjectDetection.properties.sweepSettings__added` | added | `{"$ref":"#/definitions/ImageSweepSettings","x-nullable":true}` |

### Changes for `authMode`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceEndpoint.properties.authMode__deleted` | deleted | `{"type":"string","enum":["AAD"],"x-ms-enum":{"name":"AuthMode","modelAsString":true}}` |
| `definitions.ServerlessEndpoint.properties.authMode__deleted` | deleted | `{"type":"string","enum":["Key","AAD","KeyAndAAD"],"x-ms-enum":{"name":"ServerlessInferenceEndpointAu...` |

### Changes for `endpointUri`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceEndpoint.properties.endpointUri__deleted` | deleted | `{"type":"string","format":"uri","x-nullable":true,"readOnly":true,"x-ms-mutability":["read"]}` |

### Changes for `groupName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceEndpoint.properties.groupName__deleted` | deleted | `{"type":"string","minLength":1,"pattern":"[a-zA-Z0-9_]"}` |

### Changes for `requestConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceEndpoint.properties.requestConfiguration__deleted` | deleted | `{"$ref":"#/definitions/RequestConfiguration","x-nullable":true}` |

### Changes for `environmentConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceGroup.properties.environmentConfiguration__deleted` | deleted | `{"$ref":"#/definitions/GroupEnvironmentConfiguration","x-nullable":true}` |

### Changes for `modelConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceGroup.properties.modelConfiguration__deleted` | deleted | `{"$ref":"#/definitions/GroupModelConfiguration","x-nullable":true}` |

### Changes for `nodeSkuType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceGroup.properties.nodeSkuType__deleted` | deleted | `{"type":"string","x-nullable":true}` |

### Changes for `scaleUnitSize`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferenceGroup.properties.scaleUnitSize__deleted` | deleted | `{"type":"integer","format":"int32"}` |

### Changes for `scaleUnitConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InferencePool.properties.scaleUnitConfiguration__deleted` | deleted | `{"$ref":"#/definitions/ScaleUnitConfiguration","x-nullable":true}` |

### Changes for `componentId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.componentId__deleted` | deleted | `{"type":"string","x-nullable":true,"x-ms-mutability":["create","read"]}` |

### Changes for `computeId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.computeId__deleted` | deleted | `{"type":"string","x-nullable":true,"x-ms-mutability":["create","read"]}` |

### Changes for `displayName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.displayName__deleted` | deleted | `{"type":"string","x-nullable":true,"x-ms-mutability":["create","read"]}` |
| `definitions.Schedule.properties.displayName__deleted` | deleted | `{"type":"string","x-nullable":true,"x-ms-mutability":["create","read"]}` |

### Changes for `experimentName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.experimentName__deleted` | deleted | `{"type":"string","default":"Default","x-ms-mutability":["create","read"]}` |

### Changes for `isArchived`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.isArchived__deleted` | deleted | `{"type":"boolean","default":false,"x-ms-mutability":["create","read","update"]}` |

### Changes for `jobType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.jobType__deleted` | deleted | `{"type":"string","enum":["AutoML","Command","Sweep","Pipeline","Spark","FineTuning","Distillation"],...` |

### Changes for `notificationSetting`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.notificationSetting__deleted` | deleted | `{"$ref":"#/definitions/NotificationSetting","x-nullable":true,"x-ms-mutability":["create","read","up...` |

### Changes for `parentJobName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.parentJobName__deleted` | deleted | `{"type":"string","x-nullable":true}` |

### Changes for `services`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.services__deleted` | deleted | `{"type":"object","x-nullable":true,"additionalProperties":{"$ref":"#/definitions/JobService","x-null...` |

### Changes for `status`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.JobBase.properties.status__deleted` | deleted | `{"type":"string","enum":["NotStarted","Starting","Provisioning","Preparing","Queued","Running","Fina...` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MarketplaceSubscription.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}...` |
| `definitions.Registry.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource...` |
| `definitions.ServerlessEndpoint.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource...` |

### Changes for `marketplacePlan`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MarketplaceSubscription.properties.marketplacePlan__deleted` | deleted | `{"$ref":"#/definitions/MarketplacePlan","x-nullable":true,"readOnly":true,"x-ms-mutability":["read"]...` |

### Changes for `marketplaceSubscriptionStatus`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MarketplaceSubscription.properties.marketplaceSubscriptionStatus__deleted` | deleted | `{"type":"string","enum":["Subscribed","Suspended","Unsubscribed"],"x-ms-enum":{"name":"MarketplaceSu...` |

### Changes for `modelId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MarketplaceSubscription.properties.modelId__deleted` | deleted | `{"type":"string","minLength":1,"pattern":"[a-zA-Z0-9_]"}` |

### Changes for `flavors`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelVersion.properties.flavors__deleted` | deleted | `{"type":"object","x-nullable":true,"additionalProperties":{"$ref":"#/definitions/FlavorData","x-null...` |

### Changes for `jobName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelVersion.properties.jobName__deleted` | deleted | `{"type":"string","x-nullable":true}` |

### Changes for `modelType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelVersion.properties.modelType__deleted` | deleted | `{"type":"string","x-nullable":true}` |

### Changes for `modelUri`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelVersion.properties.modelUri__deleted` | deleted | `{"type":"string","x-nullable":true}` |

### Changes for `datasets`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelVersion.properties.datasets__deleted` | deleted | `{"type":"array","x-nullable":true,"items":{"$ref":"#/definitions/DatasetReference"}}` |

### Changes for `appInsightsEnabled`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.appInsightsEnabled__deleted` | deleted | `{"type":"boolean","default":false}` |

### Changes for `dataCollector`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.dataCollector__deleted` | deleted | `{"$ref":"#/definitions/DataCollector","x-nullable":true}` |

### Changes for `egressPublicNetworkAccess`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.egressPublicNetworkAccess__deleted` | deleted | `{"type":"string","default":"Enabled","enum":["Enabled","Disabled"],"x-ms-enum":{"name":"EgressPublic...` |

### Changes for `endpointComputeType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.endpointComputeType__deleted` | deleted | `{"type":"string","enum":["Managed","Kubernetes","AzureMLCompute"],"x-ms-enum":{"name":"EndpointCompu...` |

### Changes for `instanceType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.instanceType__deleted` | deleted | `{"type":"string","default":"Standard_F4s_v2","x-nullable":true,"x-ms-mutability":["create","read"]}` |

### Changes for `livenessProbe`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.livenessProbe__deleted` | deleted | `{"$ref":"#/definitions/ProbeSettings","x-nullable":true}` |

### Changes for `modelMountPath`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.modelMountPath__deleted` | deleted | `{"type":"string","x-nullable":true}` |

### Changes for `readinessProbe`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.readinessProbe__deleted` | deleted | `{"$ref":"#/definitions/ProbeSettings","x-nullable":true}` |

### Changes for `requestSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.requestSettings__deleted` | deleted | `{"$ref":"#/definitions/OnlineRequestSettings","x-nullable":true}` |

### Changes for `scaleSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.scaleSettings__deleted` | deleted | `{"$ref":"#/definitions/OnlineScaleSettings","x-nullable":true}` |

### Changes for `startupProbe`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeployment.properties.startupProbe__deleted` | deleted | `{"$ref":"#/definitions/ProbeSettings","x-nullable":true}` |

### Changes for `mirrorTraffic`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineEndpoint.properties.mirrorTraffic__deleted` | deleted | `{"type":"object","x-nullable":true,"additionalProperties":{"format":"int32","type":"integer"}}` |

### Changes for `publicNetworkAccess`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineEndpoint.properties.publicNetworkAccess__deleted` | deleted | `{"type":"string","default":"Enabled","enum":["Enabled","Disabled"],"x-ms-enum":{"name":"PublicNetwor...` |
| `definitions.Registry.properties.publicNetworkAccess__deleted` | deleted | `{"type":"string","x-nullable":true}` |

### Changes for `traffic`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineEndpoint.properties.traffic__deleted` | deleted | `{"type":"object","x-nullable":true,"additionalProperties":{"format":"int32","type":"integer"}}` |

### Changes for `nextLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateEndpointConnectionListResult.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.PrivateLinkResourceListResult.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |

### Changes for `discoveryUrl`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Registry.properties.discoveryUrl__deleted` | deleted | `{"type":"string","x-nullable":true}` |

### Changes for `intellectualPropertyPublisher`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Registry.properties.intellectualPropertyPublisher__deleted` | deleted | `{"type":"string","x-nullable":true}` |

### Changes for `managedResourceGroup`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Registry.properties.managedResourceGroup__deleted` | deleted | `{"$ref":"#/definitions/ArmResourceId","x-nullable":true}` |

### Changes for `managedResourceGroupSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Registry.properties.managedResourceGroupSettings__deleted` | deleted | `{"$ref":"#/definitions/ManagedResourceGroupSettings","x-nullable":true}` |

### Changes for `mlFlowRegistryUri`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Registry.properties.mlFlowRegistryUri__deleted` | deleted | `{"type":"string","x-nullable":true}` |

### Changes for `registryPrivateEndpointConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Registry.properties.registryPrivateEndpointConnections__deleted` | deleted | `{"type":"array","x-nullable":true,"items":{"$ref":"#/definitions/RegistryPrivateEndpointConnection"}...` |

### Changes for `regionDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Registry.properties.regionDetails__deleted` | deleted | `{"type":"array","x-nullable":true,"items":{"$ref":"#/definitions/RegistryRegionArmDetails"}}` |

### Changes for `action`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Schedule.properties.action__deleted` | deleted | `{"$ref":"#/definitions/ScheduleActionBase","x-ms-mutability":["create","read","update"]}` |

### Changes for `isEnabled`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Schedule.properties.isEnabled__deleted` | deleted | `{"type":"boolean","default":true,"x-ms-mutability":["create","read","update"]}` |

### Changes for `trigger`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Schedule.properties.trigger__deleted` | deleted | `{"$ref":"#/definitions/TriggerBase","x-ms-mutability":["create","read","update"]}` |

### Changes for `contentSafety`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerlessEndpoint.properties.contentSafety__deleted` | deleted | `{"$ref":"#/definitions/ContentSafety","x-nullable":true}` |

### Changes for `endpointState`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerlessEndpoint.properties.endpointState__deleted` | deleted | `{"type":"string","enum":["Unknown","Creating","Deleting","Suspending","Reinstating","Online","Suspen...` |

### Changes for `inferenceEndpoint`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerlessEndpoint.properties.inferenceEndpoint__deleted` | deleted | `{"$ref":"#/definitions/ServerlessInferenceEndpoint","x-nullable":true,"readOnly":true,"x-ms-mutabili...` |

### Changes for `marketplaceSubscriptionId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerlessEndpoint.properties.marketplaceSubscriptionId__deleted` | deleted | `{"type":"string","x-nullable":true,"readOnly":true,"x-ms-mutability":["read"]}` |

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
| `definitions.AutoMLJob.allOf[0].$ref` | `#/definitions/JobBase` | `#/definitions/JobBaseProperties` |
| `definitions.AzureBlobDatastore.allOf[0].$ref` | `#/definitions/AzureDatastore` | `#/definitions/DatastoreProperties` |
| `definitions.AzureDataLakeGen1Datastore.allOf[0].$ref` | `#/definitions/AzureDatastore` | `#/definitions/DatastoreProperties` |
| `definitions.AzureDataLakeGen2Datastore.allOf[0].$ref` | `#/definitions/AzureDatastore` | `#/definitions/DatastoreProperties` |
| `definitions.AzureFileDatastore.allOf[0].$ref` | `#/definitions/AzureDatastore` | `#/definitions/DatastoreProperties` |
| `definitions.BatchDeployment.allOf[0].$ref` | `#/definitions/EndpointDeploymentPropertiesBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.BatchDeploymentTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/BatchDeploymentTrackedResource` | `#/definitions/BatchDeployment` |
| `definitions.BatchEndpoint.allOf[0].$ref` | `#/definitions/EndpointPropertiesBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.BatchEndpointTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/BatchEndpointTrackedResource` | `#/definitions/BatchEndpoint` |
| `definitions.CapabilityHost.allOf[0].$ref` | `#/definitions/ResourceBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.CodeContainer.allOf[0].$ref` | `#/definitions/AssetContainer` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.CodeContainerResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/CodeContainerResource` | `#/definitions/CodeContainer` |
| `definitions.CodeVersion.allOf[0].$ref` | `#/definitions/AssetBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.CodeVersionResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/CodeVersionResource` | `#/definitions/CodeVersion` |
| `definitions.CommandJob.allOf[0].$ref` | `#/definitions/JobBase` | `#/definitions/JobBaseProperties` |
| `definitions.ComponentContainer.allOf[0].$ref` | `#/definitions/AssetContainer` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ComponentContainerResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/ComponentContainerResource` | `#/definitions/ComponentContainer` |
| `definitions.ComponentVersion.allOf[0].$ref` | `#/definitions/AssetBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ComponentVersionResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/ComponentVersionResource` | `#/definitions/ComponentVersion` |
| `definitions.ComputeResource.allOf[0].$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.CustomService.additionalProperties` | `true` | `{}` |
| `definitions.DataContainer.allOf[0].$ref` | `#/definitions/AssetContainer` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.DataContainerResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/DataContainerResource` | `#/definitions/DataContainer` |
| `definitions.Datastore.allOf[0].$ref` | `#/definitions/ResourceBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.DatastoreResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/DatastoreResource` | `#/definitions/Datastore` |
| `definitions.DataVersionBase.allOf[0].$ref` | `#/definitions/AssetBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.DataVersionBaseResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/DataVersionBaseResource` | `#/definitions/DataVersionBase` |
| `definitions.DistillationJob.allOf[0].$ref` | `#/definitions/JobBase` | `#/definitions/JobBaseProperties` |
| `definitions.Docker.additionalProperties` | `true` | `{}` |
| `definitions.EndpointResourceProperties.properties.endpointUri.format` | `url` | `uri` |
| `definitions.EnvironmentContainer.allOf[0].$ref` | `#/definitions/AssetContainer` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.EnvironmentContainerResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/EnvironmentContainerResource` | `#/definitions/EnvironmentContainer` |
| `definitions.EnvironmentVariable.additionalProperties` | `true` | `{}` |
| `definitions.EnvironmentVersion.allOf[0].$ref` | `#/definitions/AssetBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.EnvironmentVersionResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/EnvironmentVersionResource` | `#/definitions/EnvironmentVersion` |
| `definitions.Feature.allOf[0].$ref` | `#/definitions/ResourceBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.FeatureResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/FeatureResource` | `#/definitions/Feature` |
| `definitions.FeaturesetContainer.allOf[0].$ref` | `#/definitions/AssetContainer` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.FeaturesetContainerResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/FeaturesetContainerResource` | `#/definitions/FeaturesetContainer` |
| `definitions.FeaturesetVersion.allOf[0].$ref` | `#/definitions/AssetBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.FeaturesetVersionResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/FeaturesetVersionResource` | `#/definitions/FeaturesetVersion` |
| `definitions.FeaturestoreEntityContainer.allOf[0].$ref` | `#/definitions/AssetContainer` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.FeaturestoreEntityContainerResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/FeaturestoreEntityContainerResource` | `#/definitions/FeaturestoreEntityContainer` |
| `definitions.FeaturestoreEntityVersion.allOf[0].$ref` | `#/definitions/AssetBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.FeaturestoreEntityVersionResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/FeaturestoreEntityVersionResource` | `#/definitions/FeaturestoreEntityVersion` |
| `definitions.FineTuningJob.allOf[0].$ref` | `#/definitions/JobBase` | `#/definitions/JobBaseProperties` |
| `definitions.Image.additionalProperties` | `true` | `{}` |
| `definitions.Image.properties.type.title` | `Type of the image` | `Type of the Image` |
| `definitions.InferenceEndpoint.allOf[0].$ref` | `#/definitions/PropertiesBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.InferenceEndpointTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/InferenceEndpointTrackedResource` | `#/definitions/InferenceEndpoint` |
| `definitions.InferenceGroup.allOf[0].$ref` | `#/definitions/PropertiesBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.InferenceGroupTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/InferenceGroupTrackedResource` | `#/definitions/InferenceGroup` |
| `definitions.InferencePool.allOf[0].$ref` | `#/definitions/PropertiesBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.InferencePoolTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/InferencePoolTrackedResource` | `#/definitions/InferencePool` |
| `definitions.JobBase.allOf[0].$ref` | `#/definitions/ResourceBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.JobBaseResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/JobBaseResource` | `#/definitions/JobBase` |
| `definitions.JobScheduleAction.properties.jobDefinition.$ref` | `#/definitions/JobBase` | `#/definitions/JobBaseProperties` |
| `definitions.KubernetesOnlineDeployment.allOf[0].$ref` | `#/definitions/OnlineDeployment` | `#/definitions/OnlineDeploymentProperties` |
| `definitions.ManagedOnlineDeployment.allOf[0].$ref` | `#/definitions/OnlineDeployment` | `#/definitions/OnlineDeploymentProperties` |
| `definitions.MarketplaceSubscriptionResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/MarketplaceSubscriptionResource` | `#/definitions/MarketplaceSubscription` |
| `definitions.MLTableData.allOf[0].$ref` | `#/definitions/DataVersionBase` | `#/definitions/DataVersionBaseProperties` |
| `definitions.ModelContainer.allOf[0].$ref` | `#/definitions/AssetContainer` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ModelContainerResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/ModelContainerResource` | `#/definitions/ModelContainer` |
| `definitions.ModelVersion.allOf[0].$ref` | `#/definitions/AssetBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ModelVersionResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/ModelVersionResource` | `#/definitions/ModelVersion` |
| `definitions.OneLakeDatastore.allOf[0].$ref` | `#/definitions/Datastore` | `#/definitions/DatastoreProperties` |
| `definitions.OnlineDeployment.allOf[0].$ref` | `#/definitions/EndpointDeploymentPropertiesBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.OnlineDeploymentTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/OnlineDeploymentTrackedResource` | `#/definitions/OnlineDeployment` |
| `definitions.OnlineEndpoint.allOf[0].$ref` | `#/definitions/EndpointPropertiesBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.OnlineEndpointTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/OnlineEndpointTrackedResource` | `#/definitions/OnlineEndpoint` |
| `definitions.PipelineJob.allOf[0].$ref` | `#/definitions/JobBase` | `#/definitions/JobBaseProperties` |
| `definitions.RegistryTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/RegistryTrackedResource` | `#/definitions/Registry` |
| `definitions.SASCredentialDto.properties.sasUri.format` | `uri` | `password` |
| `definitions.Schedule.allOf[0].$ref` | `#/definitions/ResourceBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ScheduleResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/ScheduleResource` | `#/definitions/Schedule` |
| `definitions.ServerlessEndpointTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/ServerlessEndpointTrackedResource` | `#/definitions/ServerlessEndpoint` |
| `definitions.SparkJob.allOf[0].$ref` | `#/definitions/JobBase` | `#/definitions/JobBaseProperties` |
| `definitions.SweepJob.allOf[0].$ref` | `#/definitions/JobBase` | `#/definitions/JobBaseProperties` |
| `definitions.UriFileDataVersion.allOf[0].$ref` | `#/definitions/DataVersionBase` | `#/definitions/DataVersionBaseProperties` |
| `definitions.UriFolderDataVersion.allOf[0].$ref` | `#/definitions/DataVersionBase` | `#/definitions/DataVersionBaseProperties` |
| `definitions.WorkspaceConnectionOAuth2.properties.authUrl.format` | `url` | `uri` |
| `definitions.WorkspaceProperties.properties.agentsEndpointUri.format` | `url` | `uri` |
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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}/versions/{version}'].put.responses.200.schema.$ref` | `#/definitions/ModelVersionResource` | `#/definitions/CodeContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/models/{modelName}/versions/{version}'].put.responses.201.schema.$ref` | `#/definitions/ModelVersionResource` | `#/definitions/CodeContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/removeRegions'].post.parameters[1].schema.$ref` | `#/definitions/RegistryTrackedResource` | `#/definitions/Registry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/removeRegions'].post.responses.200.schema.$ref` | `#/definitions/RegistryTrackedResource` | `#/definitions/Registry` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/registries/{registryName}/removeRegions'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}'].put.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].get.responses.200.schema.$ref` | `#/definitions/BatchEndpointTrackedResource` | `#/definitions/BatchEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].patch.parameters[1].name` | `endpointName` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].patch.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].patch.responses.200.schema.$ref` | `#/definitions/BatchEndpointTrackedResource` | `#/definitions/BatchEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].patch.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].put.parameters[1].name` | `endpointName` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].put.parameters[3].schema.$ref` | `#/definitions/BatchEndpointTrackedResource` | `#/definitions/BatchEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].put.responses.200.schema.$ref` | `#/definitions/BatchEndpointTrackedResource` | `#/definitions/BatchEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}'].put.responses.201.schema.$ref` | `#/definitions/BatchEndpointTrackedResource` | `#/definitions/BatchEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].get.responses.200.schema.$ref` | `#/definitions/BatchDeploymentTrackedResource` | `#/definitions/BatchDeployment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].patch.parameters[1].name` | `endpointName` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].patch.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].patch.responses.200.schema.$ref` | `#/definitions/BatchDeploymentTrackedResource` | `#/definitions/BatchDeployment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].patch.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].put.parameters[1].name` | `endpointName` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].put.parameters[4].schema.$ref` | `#/definitions/BatchDeploymentTrackedResource` | `#/definitions/BatchDeployment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].put.responses.200.schema.$ref` | `#/definitions/BatchDeploymentTrackedResource` | `#/definitions/BatchDeployment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/batchEndpoints/{endpointName}/deployments/{deploymentName}'].put.responses.201.schema.$ref` | `#/definitions/BatchDeploymentTrackedResource` | `#/definitions/BatchDeployment` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].get.responses.200.schema.$ref` | `#/definitions/CapabilityHostResource` | `#/definitions/CapabilityHost` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].put.parameters[3].schema.$ref` | `#/definitions/CapabilityHostResource` | `#/definitions/CapabilityHost` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].put.responses.200.schema.$ref` | `#/definitions/CapabilityHostResource` | `#/definitions/CodeContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/capabilityHosts/{name}'].put.responses.201.schema.$ref` | `#/definitions/CapabilityHostResource` | `#/definitions/CodeContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}'].get.responses.200.schema.$ref` | `#/definitions/CodeContainerResource` | `#/definitions/CodeContainer` |
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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}'].put.responses.201.schema.$ref` | `#/definitions/FeaturesetContainerResource` | `#/definitions/FeaturesetContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].get.responses.200.schema.$ref` | `#/definitions/FeaturesetVersionResource` | `#/definitions/FeaturesetVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].put.parameters[4].schema.$ref` | `#/definitions/FeaturesetVersionResource` | `#/definitions/FeaturesetVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].put.responses.200.schema.$ref` | `#/definitions/FeaturesetVersionResource` | `#/definitions/FeaturesetVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}'].put.responses.201.schema.$ref` | `#/definitions/FeaturesetVersionResource` | `#/definitions/FeaturesetVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featuresets/{name}/versions/{version}/backfill'].post.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].get.responses.200.schema.$ref` | `#/definitions/FeaturestoreEntityContainerResource` | `#/definitions/FeaturestoreEntityContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].put.parameters[3].schema.$ref` | `#/definitions/FeaturestoreEntityContainerResource` | `#/definitions/FeaturestoreEntityContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].put.responses.200.schema.$ref` | `#/definitions/FeaturestoreEntityContainerResource` | `#/definitions/FeaturestoreEntityContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}'].put.responses.201.schema.$ref` | `#/definitions/FeaturestoreEntityContainerResource` | `#/definitions/FeaturestoreEntityContainer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].delete.responses.202.headers.Location.description` | `URI to poll for asynchronous operation result.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].get.responses.200.schema.$ref` | `#/definitions/FeaturestoreEntityVersionResource` | `#/definitions/FeaturestoreEntityVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].put.parameters[1].name` | `name` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].put.parameters[1].pattern` | `^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$` | `^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].put.parameters[4].schema.$ref` | `#/definitions/FeaturestoreEntityVersionResource` | `#/definitions/FeaturestoreEntityVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].put.responses.200.schema.$ref` | `#/definitions/FeaturestoreEntityVersionResource` | `#/definitions/FeaturesetVersion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.MachineLearningServices/workspaces/{workspaceName}/featurestoreEntities/{name}/versions/{version}'].put.responses.201.schema.$ref` | `#/definitions/FeaturestoreEntityVersionResource` | `#/definitions/FeaturesetVersion` |
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

