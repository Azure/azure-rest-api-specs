## Swagger Changes

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DiagnoseResponseResult.properties.value.$ref__added` | added | `#/definitions/DiagnoseResponseResultValue` |
| `definitions.InstanceTypeSchema.properties.resources.$ref__added` | added | `#/definitions/InstanceTypeSchemaResources` |
| `definitions.PartialManagedServiceIdentity.properties.userAssignedIdentities.additionalProperties.$ref__deleted` | deleted | `#/definitions/PartialUserAssignedIdentity` |
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
| `definitions.PartialManagedServiceIdentity.properties.userAssignedIdentities.additionalProperties.type__added` | added | `object` |
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
| `definitions.SparkJob.properties.codeId.pattern__deleted` | deleted | `[a-zA-Z0-9_]` |
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
| `definitions.RaiBlocklistItemsBulkAddRequest.items__deleted` | deleted | `{"$ref":"#/definitions/RaiBlocklistItemBulkRequest"}` |
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

### Changes for `FQDNEndpoint`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FQDNEndpoint__deleted` | deleted | `{"type":"object","properties":{"domainName":{"type":"string"},"endpointDetails":{"type":"array","ite...` |

### Changes for `FQDNEndpointDetail`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FQDNEndpointDetail__deleted` | deleted | `{"type":"object","properties":{"port":{"type":"integer","format":"int32"}}}` |

### Changes for `FQDNEndpoints`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FQDNEndpoints__deleted` | deleted | `{"type":"object","properties":{"category":{"type":"string"},"endpoints":{"type":"array","items":{"$r...` |

### Changes for `FQDNEndpointsPropertyBag`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FQDNEndpointsPropertyBag__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/FQDNEndpoints"}}}` |

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
| `definitions.EnvironmentVersionProperties__added` | added | `{"type":"object","properties":{"autoRebuild":{"type":"string","enum":["Disabled","OnBaseImageUpdate"...` |

### Changes for `FeatureProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeatureProperties__added` | added | `{"type":"object","properties":{"dataType":{"type":"string","enum":["String","Integer","Long","Float"...` |

### Changes for `FeaturesetContainerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturesetContainerProperties__added` | added | `{"type":"object","properties":{"provisioningState":{"type":"string","enum":["Succeeded","Failed","Ca...` |

### Changes for `FeaturesetVersionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturesetVersionProperties__added` | added | `{"type":"object","properties":{"entities":{"type":"array","items":{"type":"string"}},"materializatio...` |

### Changes for `FeaturestoreEntityContainerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturestoreEntityContainerProperties__added` | added | `{"type":"object","properties":{"provisioningState":{"type":"string","enum":["Succeeded","Failed","Ca...` |

### Changes for `FeaturestoreEntityVersionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FeaturestoreEntityVersionProperties__added` | added | `{"type":"object","properties":{"indexColumns":{"type":"array","items":{"$ref":"#/definitions/IndexCo...` |

### Changes for `FqdnEndpoint`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FqdnEndpoint__added` | added | `{"type":"object","properties":{"domainName":{"type":"string"},"endpointDetails":{"type":"array","ite...` |

### Changes for `FqdnEndpointDetail`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FqdnEndpointDetail__added` | added | `{"type":"object","properties":{"port":{"type":"integer","format":"int32"}}}` |

### Changes for `FqdnEndpoints`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FqdnEndpoints__added` | added | `{"type":"object","properties":{"category":{"type":"string"},"endpoints":{"type":"array","items":{"$r...` |

### Changes for `FqdnEndpointsPropertyBag`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FqdnEndpointsPropertyBag__added` | added | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/FqdnEndpoints"}}}` |

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
| `definitions.JobBaseProperties__added` | added | `{"type":"object","properties":{"componentId":{"type":"string","x-ms-mutability":["create","read"]},"...` |

### Changes for `MarketplaceSubscriptionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MarketplaceSubscriptionProperties__added` | added | `{"type":"object","properties":{"marketplacePlan":{"$ref":"#/definitions/MarketplacePlan","readOnly":...` |

### Changes for `ModelContainerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelContainerProperties__added` | added | `{"type":"object","properties":{"provisioningState":{"type":"string","enum":["Succeeded","Failed","Ca...` |

### Changes for `ModelVersionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ModelVersionProperties__added` | added | `{"type":"object","properties":{"flavors":{"type":"object","additionalProperties":{"$ref":"#/definiti...` |

### Changes for `OnlineDeploymentProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineDeploymentProperties__added` | added | `{"type":"object","properties":{"appInsightsEnabled":{"type":"boolean"},"dataCollector":{"$ref":"#/de...` |

### Changes for `OnlineEndpointProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnlineEndpointProperties__added` | added | `{"type":"object","properties":{"compute":{"type":"string"},"mirrorTraffic":{"type":"object","additio...` |

### Changes for `RegistryProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RegistryProperties__added` | added | `{"type":"object","properties":{"discoveryUrl":{"type":"string"},"intellectualPropertyPublisher":{"ty...` |

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
| `definitions.Stringforlist__added` | added | `{"type":"object","properties":{"string":{"type":"string"}},"required":["string"]}` |

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
| `definitions.RaiBlocklistItemsBulkAddRequest.properties__added` | added | `{"items":{"type":"array","items":{"$ref":"#/definitions/RaiBlocklistItemBulkRequest"},"x-ms-identifi...` |
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

### Changes for `x-ms-secret`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccountKeyDatastoreCredentials.properties.secrets['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.CertificateDatastoreCredentials.properties.secrets['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.EndpointKeys.properties.keys['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.EndpointPropertiesBase.properties.keys['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.KubernetesProperties.properties.relayConnectionString['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.KubernetesProperties.properties.serviceBusConnectionString['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.ListNotebookKeysResult.properties.primaryAccessKey['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.ListNotebookKeysResult.properties.secondaryAccessKey['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.ListStorageAccountKeysResult.properties.userStorageKey['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.ListWorkspaceKeysResult.properties.appInsightsInstrumentationKey['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.ListWorkspaceKeysResult.properties.userStorageKey['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.NotebookAccessTokenResult.properties.accessToken['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.NotebookAccessTokenResult.properties.refreshToken['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.Password.properties.name['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.Password.properties.value['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.SASCredentialDto.properties.sasUri['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.SasDatastoreCredentials.properties.secrets['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.ServicePrincipalDatastoreCredentials.properties.secrets['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.SslConfiguration.properties.cert['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.SslConfiguration.properties.key['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.UserAccountCredentials.properties.adminUserPassword['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.UserAccountCredentials.properties.adminUserSshPublicKey['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.VirtualMachineSshCredentials.properties.privateKeyData['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.VirtualMachineSshCredentials.properties.publicKeyData['x-ms-secret__deleted']` | deleted | `true` |
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
| `definitions.DeltaModelCurrentState.properties.count.default__deleted` | deleted | `0` |
| `definitions.DeltaModelStatusResponse.properties.actualInstanceCount.default__deleted` | deleted | `0` |
| `definitions.DeltaModelStatusResponse.properties.expectedInstanceCount.default__deleted` | deleted | `0` |
| `definitions.DeploymentLogsRequest.properties.containerType.default__deleted` | deleted | `InferenceServer` |
| `definitions.DistillationJob.properties.resources.default__deleted` | deleted | `{}` |
| `definitions.EarlyTerminationPolicy.properties.delayEvaluation.default__deleted` | deleted | `0` |
| `definitions.EarlyTerminationPolicy.properties.evaluationInterval.default__deleted` | deleted | `0` |
| `definitions.EndpointAuthToken.properties.expiryTimeUtc.default__deleted` | deleted | `0` |
| `definitions.EndpointAuthToken.properties.refreshAfterTimeUtc.default__deleted` | deleted | `0` |
| `definitions.FeatureImportanceSettings.properties.mode.default__deleted` | deleted | `Disabled` |
| `definitions.FineTuningJob.properties.resources.default__deleted` | deleted | `{}` |
| `definitions.Forecasting.properties.primaryMetric.default__deleted` | deleted | `NormalizedRootMeanSquaredError` |
| `definitions.ForecastingSettings.properties.featureLags.default__deleted` | deleted | `None` |
| `definitions.ForecastingSettings.properties.forecastHorizon.default__deleted` | deleted | `{"Mode": "Custom", "Value": 1}` |
| `definitions.ForecastingSettings.properties.seasonality.default__deleted` | deleted | `{"Mode": "Auto"}` |
| `definitions.ForecastingSettings.properties.shortSeriesHandlingConfig.default__deleted` | deleted | `Auto` |
| `definitions.ForecastingSettings.properties.targetAggregateFunction.default__deleted` | deleted | `None` |
| `definitions.ForecastingSettings.properties.useStl.default__deleted` | deleted | `None` |
| `definitions.GroupStatus.properties.endpointCount.default__deleted` | deleted | `0` |
| `definitions.GroupStatus.properties.requestedCapacity.default__deleted` | deleted | `0` |
| `definitions.ImageClassification.properties.primaryMetric.default__deleted` | deleted | `Accuracy` |
| `definitions.ImageClassificationMultilabel.properties.primaryMetric.default__deleted` | deleted | `IOU` |
| `definitions.ImageInstanceSegmentation.properties.primaryMetric.default__deleted` | deleted | `MeanAveragePrecision` |
| `definitions.ImageLimitSettings.properties.timeout.default__deleted` | deleted | `P7D` |
| `definitions.ImageModelSettings.properties.learningRateScheduler.default__deleted` | deleted | `None` |
| `definitions.ImageModelSettings.properties.optimizer.default__deleted` | deleted | `None` |
| `definitions.ImageModelSettingsObjectDetection.properties.modelSize.default__deleted` | deleted | `None` |
| `definitions.ImageModelSettingsObjectDetection.properties.validationMetricType.default__deleted` | deleted | `None` |
| `definitions.ImageObjectDetection.properties.primaryMetric.default__deleted` | deleted | `MeanAveragePrecision` |
| `definitions.IndexColumn.properties.dataType.default__deleted` | deleted | `String` |
| `definitions.ManagedNetworkSettings.properties.enableNetworkMonitor.default__deleted` | deleted | `false` |
| `definitions.MaterializationSettings.properties.storeType.default__deleted` | deleted | `None` |
| `definitions.NlpVerticalLimitSettings.properties.timeout.default__deleted` | deleted | `P7D` |
| `definitions.OneLakeDatastore.properties.serviceDataAccessAuthIdentity.default__deleted` | deleted | `None` |
| `definitions.OnlineRequestSettings.properties.maxQueueWait.default__deleted` | deleted | `PT0.5S` |
| `definitions.OnlineRequestSettings.properties.requestTimeout.default__deleted` | deleted | `PT5S` |
| `definitions.PendingUploadRequestDto.properties.pendingUploadType.default__deleted` | deleted | `TemporaryBlobReference` |
| `definitions.PendingUploadResponseDto.properties.pendingUploadType.default__deleted` | deleted | `TemporaryBlobReference` |
| `definitions.ProbeSettings.properties.period.default__deleted` | deleted | `PT10S` |
| `definitions.ProbeSettings.properties.timeout.default__deleted` | deleted | `PT2S` |
| `definitions.QueueSettings.properties.jobTier.default__deleted` | deleted | `Null` |
| `definitions.RandomSamplingAlgorithm.properties.rule.default__deleted` | deleted | `Random` |
| `definitions.Regression.properties.primaryMetric.default__deleted` | deleted | `NormalizedRootMeanSquaredError` |
| `definitions.RequestConfiguration.properties.requestTimeout.default__deleted` | deleted | `PT5S` |
| `definitions.ScaleSettings.properties.minNodeCount.default__deleted` | deleted | `0` |
| `definitions.ScaleUnitConfiguration.properties.disablePublicEgress.default__deleted` | deleted | `false` |
| `definitions.SecretExpiry.properties.expirableSecret.default__deleted` | deleted | `false` |
| `definitions.SkuCapacity.properties.default.default__deleted` | deleted | `0` |
| `definitions.SkuCapacity.properties.maximum.default__deleted` | deleted | `0` |
| `definitions.SkuCapacity.properties.minimum.default__deleted` | deleted | `0` |
| `definitions.SkuCapacity.properties.scaleType.default__deleted` | deleted | `Automatic` |
| `definitions.SkuSetting.properties.tier.default__deleted` | deleted | `Basic` |
| `definitions.StackEnsembleSettings.properties.stackMetaLearnerType.default__deleted` | deleted | `None` |
| `definitions.SweepJob.properties.limits.default__deleted` | deleted | `{}` |
| `definitions.TableVerticalFeaturizationSettings.properties.enableDnnFeaturization.default__deleted` | deleted | `false` |
| `definitions.TableVerticalFeaturizationSettings.properties.mode.default__deleted` | deleted | `Auto` |
| `definitions.TableVerticalLimitSettings.properties.timeout.default__deleted` | deleted | `PT6H` |
| `definitions.TableVerticalLimitSettings.properties.trialTimeout.default__deleted` | deleted | `PT30M` |
| `definitions.TargetUtilizationScaleSettings.properties.pollingInterval.default__deleted` | deleted | `PT1S` |
| `definitions.TensorFlow.properties.parameterServerCount.default__deleted` | deleted | `0` |
| `definitions.TextClassification.properties.primaryMetric.default__deleted` | deleted | `Accuracy` |
| `definitions.TrainingSettings.properties.enableDnnTraining.default__deleted` | deleted | `false` |
| `definitions.TrainingSettings.properties.enableOnnxCompatibleModels.default__deleted` | deleted | `false` |
| `definitions.TrainingSettings.properties.ensembleModelDownloadTimeout.default__deleted` | deleted | `PT5M` |
| `definitions.TrialComponent.properties.resources.default__deleted` | deleted | `{}` |
| `definitions.TruncationSelectionPolicy.properties.truncationPercentage.default__deleted` | deleted | `0` |

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
| `definitions.TextClassification.properties.featurizationSettings__added` | added | `{"$ref":"#/definitions/NlpVerticalFeaturizationSettings"}` |
| `definitions.TextClassificationMultilabel.properties.featurizationSettings__added` | added | `{"$ref":"#/definitions/NlpVerticalFeaturizationSettings"}` |
| `definitions.TextNer.properties.featurizationSettings__added` | added | `{"$ref":"#/definitions/NlpVerticalFeaturizationSettings"}` |

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
| `definitions.TextClassification.properties.limitSettings__added` | added | `{"$ref":"#/definitions/NlpVerticalLimitSettings"}` |
| `definitions.TextClassificationMultilabel.properties.limitSettings__added` | added | `{"$ref":"#/definitions/NlpVerticalLimitSettings"}` |
| `definitions.TextNer.properties.limitSettings__added` | added | `{"$ref":"#/definitions/NlpVerticalLimitSettings"}` |

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
| `definitions.ImageClassification.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput"}` |
| `definitions.ImageClassificationMultilabel.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput"}` |
| `definitions.ImageInstanceSegmentation.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput"}` |
| `definitions.ImageObjectDetection.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput"}` |
| `definitions.Regression.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput","x-nullable":true}` |
| `definitions.TextClassification.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput"}` |
| `definitions.TextClassificationMultilabel.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput"}` |
| `definitions.TextNer.properties.validationData__added` | added | `{"$ref":"#/definitions/MLTableJobInput"}` |

### Changes for `validationDataSize`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Classification.properties.validationDataSize__added` | added | `{"type":"number","format":"double","x-nullable":true}` |
| `definitions.Forecasting.properties.validationDataSize__added` | added | `{"type":"number","format":"double","x-nullable":true}` |
| `definitions.ImageClassification.properties.validationDataSize__added` | added | `{"type":"number","format":"double"}` |
| `definitions.ImageClassificationMultilabel.properties.validationDataSize__added` | added | `{"type":"number","format":"double"}` |
| `definitions.ImageInstanceSegmentation.properties.validationDataSize__added` | added | `{"type":"number","format":"double"}` |
| `definitions.ImageObjectDetection.properties.validationDataSize__added` | added | `{"type":"number","format":"double"}` |
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
| `definitions.EndpointModelProperties.properties.systemData.readOnly__added` | added | `true` |
| `definitions.ListAmlUserFeatureResult.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.ListUsagesResult.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.ListWorkspaceQuotas.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.ServerlessEndpointInferenceEndpoint.properties.uri.readOnly__added` | added | `true` |
| `definitions.ServerlessInferenceEndpoint.properties.uri.readOnly__added` | added | `true` |
| `definitions.UpdateWorkspaceQuotas.properties.status.readOnly__deleted` | deleted | `false` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComputeInstanceContainer.properties.services.items.additionalProperties__added` | added | `{}` |
| `definitions.EndpointScheduleAction.properties.endpointInvocationDefinition.additionalProperties__added` | added | `{}` |
| `definitions.PartialManagedServiceIdentity.properties.userAssignedIdentities.additionalProperties.additionalProperties__added` | added | `{}` |
| `definitions.PipelineJob.properties.jobs.additionalProperties.additionalProperties__added` | added | `{}` |
| `definitions.PipelineJob.properties.settings.additionalProperties__added` | added | `{}` |
| `definitions.ResourceConfiguration.properties.properties.additionalProperties.additionalProperties__added` | added | `{}` |
| `definitions.StackEnsembleSettings.properties.stackMetaLearnerKWargs.additionalProperties__added` | added | `{}` |
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
| `definitions.DataGenerationVertical.properties.promptSettings['x-nullable__deleted']` | deleted | `true` |
| `definitions.DataGenerationVertical.properties.teacherModelSettings['x-nullable__deleted']` | deleted | `true` |
| `definitions.DataPathAssetReference.properties.datastoreId['x-nullable__deleted']` | deleted | `true` |
| `definitions.DataPathAssetReference.properties.path['x-nullable__deleted']` | deleted | `true` |
| `definitions.DataQualityMetricThresholdBase.properties.threshold['x-nullable__deleted']` | deleted | `true` |
| `definitions.DataQualityMonitoringSignal.properties.featureDataTypeOverride['x-nullable__deleted']` | deleted | `true` |
| `definitions.DataQualityMonitoringSignal.properties.featureImportanceSettings['x-nullable__deleted']` | deleted | `true` |
| `definitions.DataQualityMonitoringSignal.properties.features['x-nullable__deleted']` | deleted | `true` |
| `definitions.DatasetReference.properties.id['x-nullable__deleted']` | deleted | `true` |
| `definitions.DatasetReference.properties.name['x-nullable__deleted']` | deleted | `true` |
| `definitions.DeltaModelCurrentState.properties.sampleInstanceID['x-nullable__deleted']` | deleted | `true` |
| `definitions.DeltaModelCurrentState.properties.status['x-nullable__deleted']` | deleted | `true` |
| `definitions.DeltaModelListRequest.properties.skipToken['x-nullable__deleted']` | deleted | `true` |
| `definitions.DeltaModelListRequest.properties.targetBaseModel['x-nullable__deleted']` | deleted | `true` |
| `definitions.DeltaModelModifyRequest.properties.addDeltaModels['x-nullable__deleted']` | deleted | `true` |
| `definitions.DeltaModelModifyRequest.properties.removeDeltaModels['x-nullable__deleted']` | deleted | `true` |
| `definitions.DeltaModelModifyRequest.properties.targetBaseModel['x-nullable__deleted']` | deleted | `true` |
| `definitions.DeltaModelStatusRequest.properties.deltaModels['x-nullable__deleted']` | deleted | `true` |
| `definitions.DeltaModelStatusRequest.properties.targetBaseModel['x-nullable__deleted']` | deleted | `true` |
| `definitions.DeltaModelStatusResponse.properties.deltaModels.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.DeltaModelStatusResponse.properties.deltaModels['x-nullable__deleted']` | deleted | `true` |
| `definitions.DeltaModelStatusResponse.properties.revisionId['x-nullable__deleted']` | deleted | `true` |
| `definitions.DeltaModelStatusResponse.properties.targetBaseModel['x-nullable__deleted']` | deleted | `true` |
| `definitions.DeploymentLogs.properties.content['x-nullable__deleted']` | deleted | `true` |
| `definitions.DeploymentLogsRequest.properties.tail['x-nullable__deleted']` | deleted | `true` |
| `definitions.DestinationAsset.properties.destinationName['x-nullable__deleted']` | deleted | `true` |
| `definitions.DestinationAsset.properties.destinationVersion['x-nullable__deleted']` | deleted | `true` |
| `definitions.DestinationAsset.properties.registryName['x-nullable__deleted']` | deleted | `true` |
| `definitions.DistillationJob.properties.outputs.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.DistillationJob.properties.queueSettings['x-nullable__deleted']` | deleted | `true` |
| `definitions.Docker.properties.privileged['x-nullable__deleted']` | deleted | `true` |
| `definitions.DockerCredential.properties.password['x-nullable__deleted']` | deleted | `true` |
| `definitions.DockerCredential.properties.userName['x-nullable__deleted']` | deleted | `true` |
| `definitions.Endpoint.properties.hostIp['x-nullable__deleted']` | deleted | `true` |
| `definitions.Endpoint.properties.published['x-nullable__deleted']` | deleted | `true` |
| `definitions.EndpointAuthKeys.properties.primaryKey['x-nullable__deleted']` | deleted | `true` |
| `definitions.EndpointAuthKeys.properties.secondaryKey['x-nullable__deleted']` | deleted | `true` |
| `definitions.EndpointAuthToken.properties.accessToken['x-nullable__deleted']` | deleted | `true` |
| `definitions.EndpointAuthToken.properties.tokenType['x-nullable__deleted']` | deleted | `true` |
| `definitions.EndpointDeploymentPropertiesBase.properties.codeConfiguration['x-nullable__deleted']` | deleted | `true` |
| `definitions.EndpointDeploymentPropertiesBase.properties.description['x-nullable__deleted']` | deleted | `true` |
| `definitions.EndpointDeploymentPropertiesBase.properties.environmentId['x-nullable__deleted']` | deleted | `true` |
| `definitions.EndpointDeploymentPropertiesBase.properties.environmentVariables.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.EndpointDeploymentPropertiesBase.properties.environmentVariables['x-nullable__deleted']` | deleted | `true` |
| `definitions.EndpointDeploymentPropertiesBase.properties.properties.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.EndpointDeploymentPropertiesBase.properties.properties['x-nullable__deleted']` | deleted | `true` |
| `definitions.EndpointPropertiesBase.properties.description['x-nullable__deleted']` | deleted | `true` |
| `definitions.EndpointPropertiesBase.properties.keys['x-nullable__deleted']` | deleted | `true` |
| `definitions.EndpointPropertiesBase.properties.properties.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.EndpointPropertiesBase.properties.properties['x-nullable__deleted']` | deleted | `true` |
| `definitions.EndpointPropertiesBase.properties.scoringUri['x-nullable__deleted']` | deleted | `true` |
| `definitions.EndpointPropertiesBase.properties.swaggerUri['x-nullable__deleted']` | deleted | `true` |
| `definitions.FeatureAttributionDriftMonitoringSignal.properties.featureDataTypeOverride['x-nullable__deleted']` | deleted | `true` |
| `definitions.FeatureAttributionMetricThreshold.properties.threshold['x-nullable__deleted']` | deleted | `true` |
| `definitions.FeatureImportanceSettings.properties.targetColumn['x-nullable__deleted']` | deleted | `true` |
| `definitions.FeaturesetSpecification.properties.path['x-nullable__deleted']` | deleted | `true` |
| `definitions.FeaturesetVersionBackfillRequest.properties.featureWindow['x-nullable__deleted']` | deleted | `true` |
| `definitions.FeaturesetVersionBackfillRequest.properties.properties.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.FeaturesetVersionBackfillRequest.properties.sparkConfiguration.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.FeaturesetVersionBackfillRequest.properties.tags.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.FeaturesetVersionBackfillResponse.properties.jobIds['x-nullable__deleted']` | deleted | `true` |
| `definitions.FeatureWindow.properties.featureWindowEnd['x-nullable__deleted']` | deleted | `true` |
| `definitions.FeatureWindow.properties.featureWindowStart['x-nullable__deleted']` | deleted | `true` |
| `definitions.FeaturizationSettings.properties.datasetLanguage['x-nullable__deleted']` | deleted | `true` |
| `definitions.FinetuningDetails.properties.hyperParameters.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.FinetuningDetails.properties.hyperParameters['x-nullable__deleted']` | deleted | `true` |
| `definitions.FineTuningJob.properties.outputs.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.FineTuningJob.properties.queueSettings['x-nullable__deleted']` | deleted | `true` |
| `definitions.FineTuningVertical.properties.validationData['x-nullable__deleted']` | deleted | `true` |
| `definitions.FlavorData.properties.data.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.FlavorData.properties.data['x-nullable__deleted']` | deleted | `true` |
| `definitions.Forecasting.properties.forecastingSettings['x-nullable__deleted']` | deleted | `true` |
| `definitions.Forecasting.properties.trainingSettings['x-nullable__deleted']` | deleted | `true` |
| `definitions.ForecastingSettings.properties.countryOrRegionForHolidays['x-nullable__deleted']` | deleted | `true` |
| `definitions.ForecastingSettings.properties.cvStepSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ForecastingSettings.properties.frequency['x-nullable__deleted']` | deleted | `true` |
| `definitions.ForecastingSettings.properties.targetLags['x-nullable__deleted']` | deleted | `true` |
| `definitions.ForecastingSettings.properties.targetRollingWindowSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ForecastingSettings.properties.timeColumnName['x-nullable__deleted']` | deleted | `true` |
| `definitions.ForecastingSettings.properties.timeSeriesIdColumnNames['x-nullable__deleted']` | deleted | `true` |
| `definitions.ForecastingTrainingSettings.properties.allowedTrainingAlgorithms['x-nullable__deleted']` | deleted | `true` |
| `definitions.ForecastingTrainingSettings.properties.blockedTrainingAlgorithms['x-nullable__deleted']` | deleted | `true` |
| `definitions.GetBlobReferenceForConsumptionDto.properties.blobUri['x-nullable__deleted']` | deleted | `true` |
| `definitions.GetBlobReferenceForConsumptionDto.properties.credential['x-nullable__deleted']` | deleted | `true` |
| `definitions.GetBlobReferenceForConsumptionDto.properties.storageAccountArmId['x-nullable__deleted']` | deleted | `true` |
| `definitions.GetBlobReferenceSASRequestDto.properties.assetId['x-nullable__deleted']` | deleted | `true` |
| `definitions.GetBlobReferenceSASRequestDto.properties.blobUri['x-nullable__deleted']` | deleted | `true` |
| `definitions.GetBlobReferenceSASResponseDto.properties.blobReferenceForConsumption['x-nullable__deleted']` | deleted | `true` |
| `definitions.GroupEnvironmentConfiguration.properties.environmentId['x-nullable__deleted']` | deleted | `true` |
| `definitions.GroupEnvironmentConfiguration.properties.environmentVariables['x-nullable__deleted']` | deleted | `true` |
| `definitions.GroupEnvironmentConfiguration.properties.livenessProbe['x-nullable__deleted']` | deleted | `true` |
| `definitions.GroupEnvironmentConfiguration.properties.readinessProbe['x-nullable__deleted']` | deleted | `true` |
| `definitions.GroupEnvironmentConfiguration.properties.startupProbe['x-nullable__deleted']` | deleted | `true` |
| `definitions.GroupModelConfiguration.properties.modelId['x-nullable__deleted']` | deleted | `true` |
| `definitions.GroupStatus.properties.actualCapacityInfo['x-nullable__deleted']` | deleted | `true` |
| `definitions.HDInsightProperties.properties.administratorAccount['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageDetails.properties.image['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageDetails.properties.vulnerabilityFindings['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageInfo.properties.digest['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageInfo.properties.hostname['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageInfo.properties.repository['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageInfo.properties.tag['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.amsGradient['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.augmentations['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.beta1['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.beta2['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.distributed['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.earlyStopping['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.earlyStoppingDelay['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.earlyStoppingPatience['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.enableOnnxNormalization['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.evaluationFrequency['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.gradientAccumulationStep['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.layersToFreeze['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.learningRate['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.learningRateScheduler['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.modelName['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.momentum['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.nesterov['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.numberOfEpochs['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.numberOfWorkers['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.optimizer['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.randomSeed['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.stepLRGamma['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.stepLRStepSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.trainingBatchSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.validationBatchSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.warmupCosineLRCycles['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.warmupCosineLRWarmupEpochs['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettings.properties.weightDecay['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettingsClassification.properties.trainingCropSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettingsClassification.properties.validationCropSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettingsClassification.properties.validationResizeSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettingsClassification.properties.weightedLoss['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.boxDetectionsPerImage['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.boxScoreThreshold['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.imageSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.maxSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.minSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.modelSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.multiScale['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.nmsIouThreshold['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.tileGridSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.tileOverlapRatio['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.tilePredictionsNmsThreshold['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.validationIouThreshold['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelDistributionSettingsObjectDetection.properties.validationMetricType['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.advancedSettings['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.amsGradient['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.augmentations['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.beta1['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.beta2['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.checkpointFrequency['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.checkpointModel['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.checkpointRunId['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.distributed['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.earlyStopping['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.earlyStoppingDelay['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.earlyStoppingPatience['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.enableOnnxNormalization['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.evaluationFrequency['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.gradientAccumulationStep['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.layersToFreeze['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.learningRate['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.modelName['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.momentum['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.nesterov['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.numberOfEpochs['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.numberOfWorkers['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.randomSeed['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.stepLRGamma['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.stepLRStepSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.trainingBatchSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.validationBatchSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.warmupCosineLRCycles['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.warmupCosineLRWarmupEpochs['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettings.properties.weightDecay['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettingsClassification.properties.trainingCropSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettingsClassification.properties.validationCropSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettingsClassification.properties.validationResizeSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettingsClassification.properties.weightedLoss['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettingsObjectDetection.properties.boxDetectionsPerImage['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettingsObjectDetection.properties.boxScoreThreshold['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettingsObjectDetection.properties.imageSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettingsObjectDetection.properties.maxSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettingsObjectDetection.properties.minSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettingsObjectDetection.properties.multiScale['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettingsObjectDetection.properties.nmsIouThreshold['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettingsObjectDetection.properties.tileGridSize['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettingsObjectDetection.properties.tileOverlapRatio['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettingsObjectDetection.properties.tilePredictionsNmsThreshold['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageModelSettingsObjectDetection.properties.validationIouThreshold['x-nullable__deleted']` | deleted | `true` |
| `definitions.ImageSweepSettings.properties.earlyTermination['x-nullable__deleted']` | deleted | `true` |
| `definitions.IndexColumn.properties.columnName['x-nullable__deleted']` | deleted | `true` |
| `definitions.InferenceContainerProperties.properties.startupRoute['x-nullable__deleted']` | deleted | `true` |
| `definitions.InstanceTypeSchema.properties.nodeSelector.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.InstanceTypeSchema.properties.nodeSelector['x-nullable__deleted']` | deleted | `true` |
| `definitions.JobInput.properties.description['x-nullable__deleted']` | deleted | `true` |
| `definitions.JobLimits.properties.timeout['x-nullable__deleted']` | deleted | `true` |
| `definitions.JobOutput.properties.description['x-nullable__deleted']` | deleted | `true` |
| `definitions.JobResourceConfiguration.properties.dockerArgs['x-nullable__deleted']` | deleted | `true` |
| `definitions.JobResourceConfiguration.properties.dockerArgsList['x-nullable__deleted']` | deleted | `true` |
| `definitions.JobService.properties.endpoint['x-nullable__deleted']` | deleted | `true` |
| `definitions.JobService.properties.errorMessage['x-nullable__deleted']` | deleted | `true` |
| `definitions.JobService.properties.jobServiceType['x-nullable__deleted']` | deleted | `true` |
| `definitions.JobService.properties.nodes['x-nullable__deleted']` | deleted | `true` |
| `definitions.JobService.properties.port['x-nullable__deleted']` | deleted | `true` |
| `definitions.JobService.properties.properties.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.JobService.properties.properties['x-nullable__deleted']` | deleted | `true` |
| `definitions.JobService.properties.status['x-nullable__deleted']` | deleted | `true` |
| `definitions.KubernetesOnlineDeployment.properties.containerResourceRequirements['x-nullable__deleted']` | deleted | `true` |
| `definitions.KubernetesProperties.properties.extensionPrincipalId['x-nullable__deleted']` | deleted | `true` |
| `definitions.KubernetesProperties.properties.relayConnectionString['x-nullable__deleted']` | deleted | `true` |
| `definitions.KubernetesProperties.properties.serviceBusConnectionString['x-nullable__deleted']` | deleted | `true` |
| `definitions.LabelGeneration.properties.trainingData['x-nullable__deleted']` | deleted | `true` |
| `definitions.LabelGeneration.properties.validationData['x-nullable__deleted']` | deleted | `true` |
| `definitions.ManagedComputeIdentity.properties.identity['x-nullable__deleted']` | deleted | `true` |
| `definitions.ManagedIdentity.properties.clientId['x-nullable__deleted']` | deleted | `true` |
| `definitions.ManagedIdentity.properties.objectId['x-nullable__deleted']` | deleted | `true` |
| `definitions.ManagedIdentity.properties.resourceId['x-nullable__deleted']` | deleted | `true` |
| `definitions.ManagedIdentityCredential.properties.managedIdentityType['x-nullable__deleted']` | deleted | `true` |
| `definitions.ManagedIdentityCredential.properties.userManagedIdentityClientId['x-nullable__deleted']` | deleted | `true` |
| `definitions.ManagedIdentityCredential.properties.userManagedIdentityPrincipalId['x-nullable__deleted']` | deleted | `true` |
| `definitions.ManagedIdentityCredential.properties.userManagedIdentityResourceId['x-nullable__deleted']` | deleted | `true` |
| `definitions.ManagedIdentityCredential.properties.userManagedIdentityTenantId['x-nullable__deleted']` | deleted | `true` |
| `definitions.ManagedNetworkSettings.properties.firewallPublicIpAddress['x-nullable__deleted']` | deleted | `true` |
| `definitions.ManagedNetworkSettings.properties.outboundRules['x-nullable__deleted']` | deleted | `true` |
| `definitions.ManagedResourceGroupAssignedIdentities.properties.principalId['x-nullable__deleted']` | deleted | `false` |
| `definitions.ManagedResourceGroupSettings.properties.assignedIdentities['x-nullable__deleted']` | deleted | `true` |
| `definitions.MarketplacePlan.properties.offerId['x-nullable__deleted']` | deleted | `true` |
| `definitions.MarketplacePlan.properties.planId['x-nullable__deleted']` | deleted | `true` |
| `definitions.MarketplacePlan.properties.publisherId['x-nullable__deleted']` | deleted | `true` |
| `definitions.MaterializationComputeResource.properties.instanceType['x-nullable__deleted']` | deleted | `true` |
| `definitions.MaterializationSettings.properties.notification['x-nullable__deleted']` | deleted | `true` |
| `definitions.MaterializationSettings.properties.resource['x-nullable__deleted']` | deleted | `true` |
| `definitions.MaterializationSettings.properties.schedule['x-nullable__deleted']` | deleted | `true` |
| `definitions.MaterializationSettings.properties.sparkConfiguration.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.MaterializationSettings.properties.sparkConfiguration['x-nullable__deleted']` | deleted | `true` |
| `definitions.MLTableData.properties.referencedUris['x-nullable__deleted']` | deleted | `true` |
| `definitions.ModelSettings.properties.modelId['x-nullable__deleted']` | deleted | `true` |
| `definitions.MonitorDefinition.properties.alertNotificationSettings['x-nullable__deleted']` | deleted | `true` |
| `definitions.MonitorDefinition.properties.monitoringTarget['x-nullable__deleted']` | deleted | `true` |
| `definitions.MonitorDefinition.properties.signals.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.MonitorEmailNotificationSettings.properties.emails['x-nullable__deleted']` | deleted | `true` |
| `definitions.MonitoringInputDataBase.properties.columns.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.MonitoringInputDataBase.properties.columns['x-nullable__deleted']` | deleted | `true` |
| `definitions.MonitoringInputDataBase.properties.dataContext['x-nullable__deleted']` | deleted | `true` |
| `definitions.MonitoringSignalBase.properties.notificationTypes['x-nullable__deleted']` | deleted | `true` |
| `definitions.MonitoringSignalBase.properties.properties.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.MonitoringSignalBase.properties.properties['x-nullable__deleted']` | deleted | `true` |
| `definitions.MonitoringTarget.properties.deploymentId['x-nullable__deleted']` | deleted | `true` |
| `definitions.MonitoringTarget.properties.modelId['x-nullable__deleted']` | deleted | `true` |
| `definitions.MonitoringThreshold.properties.value['x-nullable__deleted']` | deleted | `true` |
| `definitions.MonitorNotificationSettings.properties.emailNotificationSettings['x-nullable__deleted']` | deleted | `true` |
| `definitions.Mpi.properties.processCountPerInstance['x-nullable__deleted']` | deleted | `true` |
| `definitions.NotificationSetting.properties.emailOn['x-nullable__deleted']` | deleted | `true` |
| `definitions.NotificationSetting.properties.emails['x-nullable__deleted']` | deleted | `true` |
| `definitions.NotificationSetting.properties.webhooks.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.NotificationSetting.properties.webhooks['x-nullable__deleted']` | deleted | `true` |
| `definitions.OneLakeDatastore.properties.endpoint['x-nullable__deleted']` | deleted | `true` |
| `definitions.OsPatchingStatus.properties.osPatchingErrors['x-nullable__deleted']` | deleted | `true` |
| `definitions.OutputPathAssetReference.properties.jobId['x-nullable__deleted']` | deleted | `true` |
| `definitions.OutputPathAssetReference.properties.path['x-nullable__deleted']` | deleted | `true` |
| `definitions.PackageDetails.properties.installedVersion['x-nullable__deleted']` | deleted | `true` |
| `definitions.PackageDetails.properties.installPath['x-nullable__deleted']` | deleted | `true` |
| `definitions.PackageDetails.properties.name['x-nullable__deleted']` | deleted | `true` |
| `definitions.PackageDetails.properties.patchedVersion['x-nullable__deleted']` | deleted | `true` |
| `definitions.PartialBatchDeployment.properties.description['x-nullable__deleted']` | deleted | `true` |
| `definitions.PartialBatchDeploymentPartialMinimalTrackedResourceWithProperties.properties.tags.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.PartialMinimalTrackedResource.properties.tags.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.PartialRegistryPartialTrackedResource.properties.tags.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.PendingUploadRequestDto.properties.pendingUploadId['x-nullable__deleted']` | deleted | `true` |
| `definitions.PendingUploadResponseDto.properties.blobReferenceForConsumption['x-nullable__deleted']` | deleted | `true` |
| `definitions.PendingUploadResponseDto.properties.pendingUploadId['x-nullable__deleted']` | deleted | `true` |
| `definitions.PipelineJob.properties.inputs.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.PipelineJob.properties.inputs['x-nullable__deleted']` | deleted | `true` |
| `definitions.PipelineJob.properties.jobs.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.PipelineJob.properties.jobs['x-nullable__deleted']` | deleted | `true` |
| `definitions.PipelineJob.properties.outputs.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.PipelineJob.properties.outputs['x-nullable__deleted']` | deleted | `true` |
| `definitions.PipelineJob.properties.settings['x-nullable__deleted']` | deleted | `true` |
| `definitions.PipelineJob.properties.sourceJobId['x-nullable__deleted']` | deleted | `true` |
| `definitions.PredictionDriftMetricThresholdBase.properties.threshold['x-nullable__deleted']` | deleted | `true` |
| `definitions.PredictionDriftMonitoringSignal.properties.featureDataTypeOverride['x-nullable__deleted']` | deleted | `true` |
| `definitions.PrivateEndpointResource.properties.subnetArmId['x-nullable__deleted']` | deleted | `true` |
| `definitions.ProbeSettings.properties.initialDelay['x-nullable__deleted']` | deleted | `true` |
| `definitions.PropertiesBase.properties.description['x-nullable__deleted']` | deleted | `true` |
| `definitions.PropertiesBase.properties.properties['x-nullable__deleted']` | deleted | `true` |
| `definitions.PTUDeploymentUsage.properties.deploymentName['x-nullable__deleted']` | deleted | `true` |
| `definitions.PTUDeploymentUsage.properties.resourceGroup['x-nullable__deleted']` | deleted | `true` |
| `definitions.PTUDeploymentUsage.properties.workspaceName['x-nullable__deleted']` | deleted | `true` |
| `definitions.PyTorch.properties.processCountPerInstance['x-nullable__deleted']` | deleted | `true` |
| `definitions.RandomSamplingAlgorithm.properties.seed['x-nullable__deleted']` | deleted | `true` |
| `definitions.Recurrence.properties.startTime['x-nullable__deleted']` | deleted | `true` |
| `definitions.RecurrenceSchedule.properties.monthDays['x-nullable__deleted']` | deleted | `true` |
| `definitions.RecurrenceSchedule.properties.weekDays['x-nullable__deleted']` | deleted | `true` |
| `definitions.RecurrenceTrigger.properties.schedule['x-nullable__deleted']` | deleted | `true` |
| `definitions.RegenerateEndpointKeysRequest.properties.keyValue['x-nullable__deleted']` | deleted | `true` |
| `definitions.RegistryPrivateEndpointConnection.properties.id['x-nullable__deleted']` | deleted | `true` |
| `definitions.RegistryPrivateEndpointConnection.properties.location['x-nullable__deleted']` | deleted | `true` |
| `definitions.RegistryPrivateEndpointConnection.properties.properties['x-nullable__deleted']` | deleted | `true` |
| `definitions.RegistryPrivateEndpointConnectionProperties.properties.groupIds['x-nullable__deleted']` | deleted | `true` |
| `definitions.RegistryPrivateEndpointConnectionProperties.properties.privateEndpoint['x-nullable__deleted']` | deleted | `true` |
| `definitions.RegistryPrivateEndpointConnectionProperties.properties.provisioningState['x-nullable__deleted']` | deleted | `true` |
| `definitions.RegistryPrivateEndpointConnectionProperties.properties.registryPrivateLinkServiceConnectionState['x-nullable__deleted']` | deleted | `true` |
| `definitions.RegistryPrivateLinkServiceConnectionState.properties.actionsRequired['x-nullable__deleted']` | deleted | `true` |
| `definitions.RegistryPrivateLinkServiceConnectionState.properties.description['x-nullable__deleted']` | deleted | `true` |
| `definitions.RegistryRegionArmDetails.properties.acrDetails['x-nullable__deleted']` | deleted | `true` |
| `definitions.RegistryRegionArmDetails.properties.location['x-nullable__deleted']` | deleted | `true` |
| `definitions.RegistryRegionArmDetails.properties.storageAccountDetails['x-nullable__deleted']` | deleted | `true` |
| `definitions.Regression.properties.trainingSettings['x-nullable__deleted']` | deleted | `true` |
| `definitions.RegressionTrainingSettings.properties.allowedTrainingAlgorithms['x-nullable__deleted']` | deleted | `true` |
| `definitions.RegressionTrainingSettings.properties.blockedTrainingAlgorithms['x-nullable__deleted']` | deleted | `true` |
| `definitions.RequestLogging.properties.captureHeaders['x-nullable__deleted']` | deleted | `true` |
| `definitions.ResourceBase.properties.description['x-nullable__deleted']` | deleted | `true` |
| `definitions.ResourceBase.properties.properties.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.ResourceBase.properties.properties['x-nullable__deleted']` | deleted | `true` |
| `definitions.ResourceBase.properties.tags.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.ResourceBase.properties.tags['x-nullable__deleted']` | deleted | `true` |
| `definitions.ResourceConfiguration.properties.instanceType['x-nullable__deleted']` | deleted | `true` |
| `definitions.ResourceConfiguration.properties.properties.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.ResourceConfiguration.properties.properties['x-nullable__deleted']` | deleted | `true` |
| `definitions.RollingInputData.properties.preprocessingComponentId['x-nullable__deleted']` | deleted | `true` |
| `definitions.SASCredential.properties.sasUri['x-nullable__deleted']` | deleted | `true` |
| `definitions.SASCredentialDto.properties.sasUri['x-nullable__deleted']` | deleted | `true` |
| `definitions.SasDatastoreSecrets.properties.sasToken['x-nullable__deleted']` | deleted | `true` |
| `definitions.ScaleUnitConfiguration.properties.registries['x-nullable__deleted']` | deleted | `true` |
| `definitions.ScheduleBase.properties.id['x-nullable__deleted']` | deleted | `true` |
| `definitions.ServerlessInferenceEndpoint.properties.headers.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.ServerlessInferenceEndpoint.properties.headers['x-nullable__deleted']` | deleted | `true` |
| `definitions.ServicePrincipalDatastoreCredentials.properties.authorityUrl['x-nullable__deleted']` | deleted | `true` |
| `definitions.ServicePrincipalDatastoreCredentials.properties.resourceUrl['x-nullable__deleted']` | deleted | `true` |
| `definitions.ServicePrincipalDatastoreSecrets.properties.clientSecret['x-nullable__deleted']` | deleted | `true` |
| `definitions.SkuResource.properties.capacity['x-nullable__deleted']` | deleted | `true` |
| `definitions.SkuResource.properties.resourceType['x-nullable__deleted']` | deleted | `true` |
| `definitions.SkuResource.properties.sku['x-nullable__deleted']` | deleted | `true` |
| `definitions.SparkJob.properties.archives['x-nullable__deleted']` | deleted | `true` |
| `definitions.SparkJob.properties.args['x-nullable__deleted']` | deleted | `true` |
| `definitions.SparkJob.properties.conf.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.SparkJob.properties.conf['x-nullable__deleted']` | deleted | `true` |
| `definitions.SparkJob.properties.environmentId['x-nullable__deleted']` | deleted | `true` |
| `definitions.SparkJob.properties.environmentVariables.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.SparkJob.properties.environmentVariables['x-nullable__deleted']` | deleted | `true` |
| `definitions.SparkJob.properties.files['x-nullable__deleted']` | deleted | `true` |
| `definitions.SparkJob.properties.inputs.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.SparkJob.properties.inputs['x-nullable__deleted']` | deleted | `true` |
| `definitions.SparkJob.properties.jars['x-nullable__deleted']` | deleted | `true` |
| `definitions.SparkJob.properties.outputs.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.SparkJob.properties.outputs['x-nullable__deleted']` | deleted | `true` |
| `definitions.SparkJob.properties.pyFiles['x-nullable__deleted']` | deleted | `true` |
| `definitions.SparkJob.properties.queueSettings['x-nullable__deleted']` | deleted | `true` |
| `definitions.SparkJob.properties.resources['x-nullable__deleted']` | deleted | `true` |
| `definitions.SparkResourceConfiguration.properties.instanceType['x-nullable__deleted']` | deleted | `true` |
| `definitions.SslConfiguration.properties.cert['x-nullable__deleted']` | deleted | `true` |
| `definitions.SslConfiguration.properties.cname['x-nullable__deleted']` | deleted | `true` |
| `definitions.SslConfiguration.properties.key['x-nullable__deleted']` | deleted | `true` |
| `definitions.SslConfiguration.properties.leafDomainLabel['x-nullable__deleted']` | deleted | `true` |
| `definitions.StackEnsembleSettings.properties.stackMetaLearnerKWargs['x-nullable__deleted']` | deleted | `true` |
| `definitions.StaticInputData.properties.preprocessingComponentId['x-nullable__deleted']` | deleted | `true` |
| `definitions.StorageAccountDetails.properties.systemCreatedStorageAccount['x-nullable__deleted']` | deleted | `true` |
| `definitions.SweepJob.properties.earlyTermination['x-nullable__deleted']` | deleted | `true` |
| `definitions.SweepJob.properties.inputs.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.SweepJob.properties.inputs['x-nullable__deleted']` | deleted | `true` |
| `definitions.SweepJob.properties.outputs.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.SweepJob.properties.outputs['x-nullable__deleted']` | deleted | `true` |
| `definitions.SweepJob.properties.queueSettings['x-nullable__deleted']` | deleted | `true` |
| `definitions.SweepJobLimits.properties.maxConcurrentTrials['x-nullable__deleted']` | deleted | `true` |
| `definitions.SweepJobLimits.properties.maxTotalTrials['x-nullable__deleted']` | deleted | `true` |
| `definitions.SweepJobLimits.properties.trialTimeout['x-nullable__deleted']` | deleted | `true` |
| `definitions.SystemCreatedAcrAccount.properties.acrAccountName['x-nullable__deleted']` | deleted | `true` |
| `definitions.SystemCreatedAcrAccount.properties.acrAccountSku['x-nullable__deleted']` | deleted | `true` |
| `definitions.SystemCreatedAcrAccount.properties.armResourceId['x-nullable__deleted']` | deleted | `true` |
| `definitions.SystemCreatedStorageAccount.properties.armResourceId['x-nullable__deleted']` | deleted | `true` |
| `definitions.SystemCreatedStorageAccount.properties.storageAccountName['x-nullable__deleted']` | deleted | `true` |
| `definitions.SystemCreatedStorageAccount.properties.storageAccountType['x-nullable__deleted']` | deleted | `true` |
| `definitions.TableVerticalFeaturizationSettings.properties.blockedTransformers['x-nullable__deleted']` | deleted | `true` |
| `definitions.TableVerticalFeaturizationSettings.properties.columnNameAndTypes.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.TableVerticalFeaturizationSettings.properties.columnNameAndTypes['x-nullable__deleted']` | deleted | `true` |
| `definitions.TableVerticalFeaturizationSettings.properties.transformerParams.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.TableVerticalFeaturizationSettings.properties.transformerParams['x-nullable__deleted']` | deleted | `true` |
| `definitions.TableVerticalLimitSettings.properties.exitScore['x-nullable__deleted']` | deleted | `true` |
| `definitions.TeacherModelEndpoint.properties.endpointName['x-nullable__deleted']` | deleted | `true` |
| `definitions.TeacherModelSettings.properties.teacherModelEndpointRequestSettings['x-nullable__deleted']` | deleted | `true` |
| `definitions.TeacherModelSettings.properties.teacherModelInferenceParameters.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.TeacherModelSettings.properties.teacherModelInferenceParameters['x-nullable__deleted']` | deleted | `true` |
| `definitions.TensorFlow.properties.workerCount['x-nullable__deleted']` | deleted | `true` |
| `definitions.TrainingSettings.properties.stackEnsembleSettings['x-nullable__deleted']` | deleted | `true` |
| `definitions.TrialComponent.properties.codeId['x-nullable__deleted']` | deleted | `true` |
| `definitions.TrialComponent.properties.distribution['x-nullable__deleted']` | deleted | `true` |
| `definitions.TrialComponent.properties.environmentVariables.additionalProperties['x-nullable__deleted']` | deleted | `true` |
| `definitions.TrialComponent.properties.environmentVariables['x-nullable__deleted']` | deleted | `true` |
| `definitions.TriggerBase.properties.endTime['x-nullable__deleted']` | deleted | `true` |
| `definitions.TriggerBase.properties.startTime['x-nullable__deleted']` | deleted | `true` |
| `definitions.UsageAndQuotaDetails.properties.modelCollection['x-nullable__deleted']` | deleted | `true` |
| `definitions.UsageAndQuotaDetails.properties.usageDetails['x-nullable__deleted']` | deleted | `true` |
| `definitions.VolumeDefinition.properties.bind['x-nullable__deleted']` | deleted | `true` |
| `definitions.VolumeDefinition.properties.consistency['x-nullable__deleted']` | deleted | `true` |
| `definitions.VolumeDefinition.properties.readOnly['x-nullable__deleted']` | deleted | `true` |
| `definitions.VolumeDefinition.properties.tmpfs['x-nullable__deleted']` | deleted | `true` |
| `definitions.VolumeDefinition.properties.volume['x-nullable__deleted']` | deleted | `true` |
| `definitions.VolumeOptions.properties.nocopy['x-nullable__deleted']` | deleted | `true` |
| `definitions.VulnerabilityDetails.properties.cve['x-nullable__deleted']` | deleted | `true` |
| `definitions.VulnerabilityDetails.properties.cveUrl['x-nullable__deleted']` | deleted | `true` |
| `definitions.VulnerabilityDetails.properties.dueDate['x-nullable__deleted']` | deleted | `true` |
| `definitions.VulnerabilityDetails.properties.id['x-nullable__deleted']` | deleted | `true` |
| `definitions.VulnerabilityDetails.properties.packageDetails['x-nullable__deleted']` | deleted | `true` |
| `definitions.VulnerabilityDetails.properties.providerId['x-nullable__deleted']` | deleted | `true` |
| `definitions.VulnerabilityDetails.properties.publishDate['x-nullable__deleted']` | deleted | `true` |
| `definitions.VulnerabilityDetails.properties.solution['x-nullable__deleted']` | deleted | `true` |
| `definitions.VulnerabilityDetails.properties.title['x-nullable__deleted']` | deleted | `true` |
| `definitions.VulnerabilityDetails.properties.vendorId['x-nullable__deleted']` | deleted | `true` |
| `definitions.VulnerabilityDetails.properties.vendorUrl['x-nullable__deleted']` | deleted | `true` |
| `definitions.VulnerabilityFindings.properties.assetId['x-nullable__deleted']` | deleted | `true` |
| `definitions.VulnerabilityFindings.properties.data['x-nullable__deleted']` | deleted | `true` |
| `definitions.VulnerabilityFindings.properties.lastScanDate['x-nullable__deleted']` | deleted | `true` |
| `definitions.VulnerabilityFindings.properties.scanner['x-nullable__deleted']` | deleted | `true` |
| `definitions.VulnerabilityFindings.properties.source['x-nullable__deleted']` | deleted | `true` |
| `definitions.Webhook.properties.eventType['x-nullable__deleted']` | deleted | `true` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComputeResource.properties.location__deleted` | deleted | `{"type":"string"}` |
| `definitions.PrivateEndpointConnection.properties.location__deleted` | deleted | `{"type":"string"}` |
| `definitions.Workspace.properties.location__deleted` | deleted | `{"type":"string"}` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComputeResource.properties.tags__deleted` | deleted | `{"type":"object","x-nullable":true,"additionalProperties":{"type":"string"}}` |
| `definitions.PrivateEndpointConnection.properties.tags__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.Workspace.properties.tags__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"}}` |

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

### Changes for `title`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Endpoint.properties.protocol.title__deleted` | deleted | `Endpoint Communication Protocol` |
| `definitions.EnvironmentVariable.properties.type.title__deleted` | deleted | `Type of Environment Variable` |
| `definitions.EstimatedVMPrice.properties.osType.title__deleted` | deleted | `OS type` |
| `definitions.EstimatedVMPrice.properties.retailPrice.title__deleted` | deleted | `Retail price` |
| `definitions.EstimatedVMPrice.properties.vmTier.title__deleted` | deleted | `VM tier` |
| `definitions.EstimatedVMPrices.properties.billingCurrency.title__deleted` | deleted | `Billing currency` |
| `definitions.EstimatedVMPrices.properties.unitOfMeasure.title__deleted` | deleted | `Unit of time measure` |
| `definitions.EstimatedVMPrices.properties.values.title__deleted` | deleted | `List of estimated VM prices.` |
| `definitions.Image.properties.type.title__deleted` | deleted | `Type of the image` |
| `definitions.NodeStateCounts.properties.idleNodeCount.title__deleted` | deleted | `Idle node count.` |
| `definitions.NodeStateCounts.properties.leavingNodeCount.title__deleted` | deleted | `Leaving node count.` |
| `definitions.NodeStateCounts.properties.preemptedNodeCount.title__deleted` | deleted | `Preempted node count.` |
| `definitions.NodeStateCounts.properties.preparingNodeCount.title__deleted` | deleted | `Preparing node count.` |
| `definitions.NodeStateCounts.properties.runningNodeCount.title__deleted` | deleted | `Running node count.` |
| `definitions.NodeStateCounts.properties.unusableNodeCount.title__deleted` | deleted | `Unusable node count.` |
| `definitions.PersonalComputeInstanceSettings.properties.assignedUser.title__deleted` | deleted | `Assigned User.` |
| `definitions.QuotaBaseProperties.properties.limit.title__deleted` | deleted | `Limit.` |
| `definitions.ResourceQuota.properties.limit.title__deleted` | deleted | `Limit.` |
| `definitions.ScaleSettingsInformation.properties.scaleSettings.title__deleted` | deleted | `Scale settings.` |
| `definitions.UpdateWorkspaceQuotas.properties.limit.title__deleted` | deleted | `Limit.` |
| `definitions.UpdateWorkspaceQuotas.properties.status.title__deleted` | deleted | `Update Workspace Quota Status.` |
| `definitions.UserAccountCredentials.properties.adminUserName.title__deleted` | deleted | `User name.` |
| `definitions.UserAccountCredentials.properties.adminUserPassword.title__deleted` | deleted | `Password.` |
| `definitions.UserAccountCredentials.properties.adminUserSshPublicKey.title__deleted` | deleted | `SSH public key.` |
| `definitions.VirtualMachineSize.properties.estimatedVMPrices.title__deleted` | deleted | `Estimated VM prices` |
| `definitions.VirtualMachineSize.properties.family.title__deleted` | deleted | `Virtual Machine family name` |
| `definitions.VirtualMachineSize.properties.gpus.title__deleted` | deleted | `Number of gPUs` |
| `definitions.VirtualMachineSize.properties.lowPriorityCapable.title__deleted` | deleted | `Low priority capable` |
| `definitions.VirtualMachineSize.properties.maxResourceVolumeMB.title__deleted` | deleted | `Resource volume size` |
| `definitions.VirtualMachineSize.properties.memoryGB.title__deleted` | deleted | `Memory size` |
| `definitions.VirtualMachineSize.properties.name.title__deleted` | deleted | `Virtual Machine size name` |
| `definitions.VirtualMachineSize.properties.osVhdSizeMB.title__deleted` | deleted | `OS VHD Disk size` |
| `definitions.VirtualMachineSize.properties.premiumIO.title__deleted` | deleted | `Premium IO supported` |
| `definitions.VirtualMachineSize.properties.supportedComputeTypes.title__deleted` | deleted | `Supported Compute Types` |
| `definitions.VirtualMachineSize.properties.vCPUs.title__deleted` | deleted | `Number of vPUs` |
| `definitions.VolumeDefinition.properties.type.title__deleted` | deleted | `Type of Volume Definition` |

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
| `definitions.ImageClassification.properties.modelSettings__added` | added | `{"$ref":"#/definitions/ImageModelSettingsClassification"}` |
| `definitions.ImageClassificationMultilabel.properties.modelSettings__added` | added | `{"$ref":"#/definitions/ImageModelSettingsClassification"}` |
| `definitions.ImageInstanceSegmentation.properties.modelSettings__added` | added | `{"$ref":"#/definitions/ImageModelSettingsObjectDetection"}` |
| `definitions.ImageObjectDetection.properties.modelSettings__added` | added | `{"$ref":"#/definitions/ImageModelSettingsObjectDetection"}` |
| `definitions.ServerlessEndpoint.properties.modelSettings__deleted` | deleted | `{"$ref":"#/definitions/ModelSettings","x-nullable":true}` |

### Changes for `searchSpace`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImageClassification.properties.searchSpace__added` | added | `{"type":"array","items":{"$ref":"#/definitions/ImageModelDistributionSettingsClassification"}}` |
| `definitions.ImageClassificationMultilabel.properties.searchSpace__added` | added | `{"type":"array","items":{"$ref":"#/definitions/ImageModelDistributionSettingsClassification"}}` |
| `definitions.ImageInstanceSegmentation.properties.searchSpace__added` | added | `{"type":"array","items":{"$ref":"#/definitions/ImageModelDistributionSettingsObjectDetection"}}` |
| `definitions.ImageObjectDetection.properties.searchSpace__added` | added | `{"type":"array","items":{"$ref":"#/definitions/ImageModelDistributionSettingsObjectDetection"}}` |

### Changes for `sweepSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImageClassification.properties.sweepSettings__added` | added | `{"$ref":"#/definitions/ImageSweepSettings"}` |
| `definitions.ImageClassificationMultilabel.properties.sweepSettings__added` | added | `{"$ref":"#/definitions/ImageSweepSettings"}` |
| `definitions.ImageInstanceSegmentation.properties.sweepSettings__added` | added | `{"$ref":"#/definitions/ImageSweepSettings"}` |
| `definitions.ImageObjectDetection.properties.sweepSettings__added` | added | `{"$ref":"#/definitions/ImageSweepSettings"}` |

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

### Changes for `x-ms-identifiers`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RaiBlocklistItemsBulkAddRequest['x-ms-identifiers__deleted']` | deleted | `["name"]` |
| `definitions.TableVerticalFeaturizationSettings.properties.transformerParams.additionalProperties['x-ms-identifiers__deleted']` | deleted | `[]` |

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

### Changes for `minLength`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SparkJob.properties.codeId.minLength__deleted` | deleted | `1` |

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
| `definitions.ExternalFQDNResponse.properties.value.items.$ref` | `#/definitions/FQDNEndpointsPropertyBag` | `#/definitions/FqdnEndpointsPropertyBag` |
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
| `definitions.PrivateEndpointConnection.allOf[0].$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.RaiBlocklistItemsBulkAddRequest.type` | `array` | `object` |
| `definitions.RegistryTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/RegistryTrackedResource` | `#/definitions/Registry` |
| `definitions.Schedule.allOf[0].$ref` | `#/definitions/ResourceBase` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ScheduleResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/ScheduleResource` | `#/definitions/Schedule` |
| `definitions.ServerlessEndpointTrackedResourceArmPaginatedResult.properties.value.items.$ref` | `#/definitions/ServerlessEndpointTrackedResource` | `#/definitions/ServerlessEndpoint` |
| `definitions.SparkJob.allOf[0].$ref` | `#/definitions/JobBase` | `#/definitions/JobBaseProperties` |
| `definitions.SweepJob.allOf[0].$ref` | `#/definitions/JobBase` | `#/definitions/JobBaseProperties` |
| `definitions.UriFileDataVersion.allOf[0].$ref` | `#/definitions/DataVersionBase` | `#/definitions/DataVersionBaseProperties` |
| `definitions.UriFolderDataVersion.allOf[0].$ref` | `#/definitions/DataVersionBase` | `#/definitions/DataVersionBaseProperties` |
| `definitions.Workspace.allOf[0].$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
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

