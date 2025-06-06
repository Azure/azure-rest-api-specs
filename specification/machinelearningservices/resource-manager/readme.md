# MachineLearningServices

> see https://aka.ms/autorest

This is the AutoRest configuration file for Machine Learning Services.

---

## Getting Started

To build the SDK for Azure Machine Learning, simply [Install AutoRest](https://aka.ms/autorest/install) and
 in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Machine Learning Services API.

``` yaml
openapi-type: arm
tag: package-2025-04-01
```

### Tag: package-2025-04-01

These settings apply only when `--tag=package-2025-04-01` is specified on the command line.

```yaml $(tag) == 'package-2025-04-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2025-04-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2025-04-01/mfe.json
  - Microsoft.MachineLearningServices/stable/2025-04-01/registries.json
  - Microsoft.MachineLearningServices/stable/2025-04-01/workspaceFeatures.json
  - Microsoft.MachineLearningServices/stable/2025-04-01/workspaceRP.json
suppressions:
  - code: PatchBodyParametersSchema
    reason: Suppress as instructed, this patch is for a abstract class and the type-discriminator needs to be required.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
  - code: ResourceNameRestriction
    reason: Experience is the same as previous GA version, adding restriction will be a breaking change.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/listNodes"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/listKeys"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/start"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/stop"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/restart"]
  - code: AvoidAdditionalProperties
    reason: Existing property in previous GA version.
    where:
      - $.definitions.SparkJob.properties.conf
      - $.definitions.SparkJob.properties.environmentVariables
      - $.definitions.WorkspaceConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: LroLocationHeader
    reason: Existing API behavior
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}"].delete.responses.202
  - code: PatchBodyParametersSchema
    reason: Existing API behavior, the whole property is not required.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}"].patch.parameters[4].schema.properties.properties
  - code: XmsPageableForListCalls
    reason: Existing API behavior.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/privateLinkResources"].get
  - code: GuidUsage
    reason: Existing property in previous GA version.
    where:
      - $.definitions.WorkspaceConnectionOAuth2.properties.clientId.format
```

### Tag: package-preview-2025-04

These settings apply only when `--tag=package-preview-2025-04` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-04'
input-file:
  - Microsoft.MachineLearningServices/preview/2025-04-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2025-04-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2025-04-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2025-04-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2025-04-01-preview/workspaceRP.json
suppressions:
  - code: AvoidAdditionalProperties
    reason: This is necessary to allow users to specify custom inference parameters and 
      fine-tuning hyperparameters for any model. Enforcing typecasting would require modifying 
      contracts for each new addition by model providers. A similar approach has been previously 
      permitted for the FinetuningJob.
    where:
      - $.definitions.TeacherModelSettings.properties.teacherModelInferenceParameters
      - $.definitions.FinetuningDetails.properties.hyperParameters
      - $.definitions.DistillationJob.properties.outputs
  - code: DeleteResponseCodes
    reason: Existing API behavior in 2024-10-01-preview.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{inferencePoolName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}"].delete
  - code: PatchIdentityProperty
    reason: Existing API behavior in 2024-10-01-preview.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}"].patch.parameters[6]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}"].patch.parameters[6]
  - code: PathForResourceAction
    reason: Existing API behavior in 2024-10-01-preview.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/deltaModels/getStatus"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/deltaModels/list"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/deltaModels/modify"]
  - code: NestedResourcesMustHaveListOperation
    reason: This resource will have many kind and we currently only start with the first kind that will have a 1 to 1 
        mapping with the parent resource, so right now we didn't implement List API, 
        we will add whence needed in the future.
    where:
      - $.definitions["CapabilityHostResource"]
  - code: AvoidAdditionalProperties
    reason: Existing API behavior in 2024-10-01-preview.
    where:
      - $.definitions.CustomModelFineTuning.properties.hyperParameters
      - $.definitions.DeltaModelStatusResponse.properties.deltaModels
      - $.definitions.FineTuningJob.properties.outputs
      - $.definitions.SparkJob.properties.conf
      - $.definitions.SparkJob.properties.environmentVariables
      - $.definitions.DiagnoseRequestProperties.properties.requiredResourceProviders
  - code: PatchBodyParametersSchema
    reason: Suppress as instructed, this patch is for a abstract class and the type-discriminator needs to be required.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
  - code: PatchBodyParametersSchema
    reason: Existing API behavior, the whole property is not required.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}"].patch.parameters[4].schema.properties.properties
  - code: PatchBodyParametersSchema
    reason: The required part is within a property, the whole property itself is not required.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}"].patch.parameters[4].schema.properties.properties
  - code: ProvisioningStateSpecifiedForLROPut
    reason: This should be exist in 2024-10-01-preview and got suppressed already, not sure why it got triggered.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/deployments/{deploymentName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiPolicies/{raiPolicyName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/raiPolicies/{raiPolicyName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/raiBlocklistItems/{raiBlocklistItemName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}"].put
  - code: PostResponseCodes
    reason: This API is intend to align with Cognitive service API which has the same behavior https://github.com/Azure/azure-rest-api-specs/blob/efa7e41b82e82359fc76c0cda1856eb6e44448ec/specification/cognitiveservices/resource-manager/Microsoft.CognitiveServices/preview/2024-04-01-preview/cognitiveservices.json#L2717.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems"].post
  - code: PutResponseCodes
    reason: Service already using 202 response code for the below APIs, got exceptions from ARM reviewer.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}"].put
  - code: GuidUsage
    reason: Existing property in previous GA version.
    where:
      - $.definitions.WorkspaceConnectionOAuth2.properties.clientId.format
      - $.definitions.ManagedResourceGroupAssignedIdentities.properties.principalId.format
  - code: AvoidAdditionalProperties
    reason: Existing API behavior in 2024-10-01-preview.
    where:
      - $.definitions.CustomKeys.properties.keys
      - $.definitions.EndpointModelProperties.properties.capabilities
      - $.definitions.EndpointModelProperties.properties.finetuneCapabilities
      - $.definitions.ManagedOnlineEndpointResourceProperties.properties.mirrorTraffic
      - $.definitions.ManagedOnlineEndpointResourceProperties.properties.traffic
      - $.definitions.ServerlessEndpointInferenceEndpoint.properties.headers
      - $.definitions.WorkspaceConnectionPropertiesV2.properties.metadata
  - code: ParametersSchemaAsTypeObject
    reason: Existing API parameter with type array.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/customServices"].post.parameters[5].schema.type
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/updateDataMounts"].post.parameters[5].schema.type
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/addRaiBlocklistItems"].post.parameters[6].schema.type
  - code: SecurityDefinitionsStructure
    reason: Exist in swagger, not sure why complain
  - code: ProvisioningStateMustBeReadOnly
    reason: ProvisioningState are readonly here, nothing to fix here.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}"].get.responses.200.schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}"].patch.responses.200.schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}"].put.responses.200.schema
  - code: DefinitionsPropertiesNamesCamelCase
    reason: CMK is a short term and not violate the camel case rule.
    where:
      - $.definitions.WorkspaceProperties.properties.enableServiceSideCMKEncryption
  - code: PutResponseCodes
    reason: Service already using 202 response code for all the previous existing managed network APIs.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks/{managedNetworkName}"].put
  - code: ProvisioningStateSpecifiedForLROPut
    reason: Service already using response pattern without provisioning state for all previous existing outbound rules APIs.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworks/{managedNetworkName}].put
```

### Tag: package-preview-2025-01

These settings apply only when `--tag=package-preview-2025-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-01'
input-file:
  - Microsoft.MachineLearningServices/preview/2025-01-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2025-01-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2025-01-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2025-01-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2025-01-01-preview/workspaceRP.json
suppressions:
  - code: AvoidAdditionalProperties
    reason: This is necessary to allow users to specify custom inference parameters and 
      fine-tuning hyperparameters for any model. Enforcing typecasting would require modifying 
      contracts for each new addition by model providers. A similar approach has been previously 
      permitted for the FinetuningJob.
    where:
      - $.definitions.TeacherModelSettings.properties.teacherModelInferenceParameters
      - $.definitions.FinetuningDetails.properties.hyperParameters
      - $.definitions.DistillationJob.properties.outputs
  - code: DeleteResponseCodes
    reason: Existing API behavior in 2024-10-01-preview.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{inferencePoolName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}"].delete
  - code: PatchIdentityProperty
    reason: Existing API behavior in 2024-10-01-preview.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}"].patch.parameters[6]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}"].patch.parameters[6]
  - code: PathForResourceAction
    reason: Existing API behavior in 2024-10-01-preview.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/deltaModels/getStatus"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/deltaModels/list"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/deltaModels/modify"]
  - code: NestedResourcesMustHaveListOperation
    reason: This resource will have many kind and we currently only start with the first kind that will have a 1 to 1 
        mapping with the parent resource, so right now we didn't implement List API, 
        we will add whence needed in the future.
    where:
      - $.definitions["CapabilityHostResource"]
  - code: AvoidAdditionalProperties
    reason: Existing API behavior in 2024-10-01-preview.
    where:
      - $.definitions.CustomModelFineTuning.properties.hyperParameters
      - $.definitions.DeltaModelStatusResponse.properties.deltaModels
      - $.definitions.FineTuningJob.properties.outputs
      - $.definitions.SparkJob.properties.conf
      - $.definitions.SparkJob.properties.environmentVariables
      - $.definitions.DiagnoseRequestProperties.properties.requiredResourceProviders
  - code: PatchBodyParametersSchema
    reason: Suppress as instructed, this patch is for a abstract class and the type-discriminator needs to be required.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
  - code: PatchBodyParametersSchema
    reason: Existing API behavior, the whole property is not required.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}"].patch.parameters[4].schema.properties.properties
  - code: PatchBodyParametersSchema
    reason: The required part is within a property, the whole property itself is not required.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}"].patch.parameters[4].schema.properties.properties
  - code: LroLocationHeader
    reason: Existing API behavior
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}"].delete.responses.202
  - code: ProvisioningStateSpecifiedForLROPut
    reason: This should be exist in 2024-10-01-preview and got suppressed already, not sure why it got triggered.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/deployments/{deploymentName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiPolicies/{raiPolicyName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/raiPolicies/{raiPolicyName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/raiBlocklistItems/{raiBlocklistItemName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}"].put
  - code: PostResponseCodes
    reason: This API is intend to align with Cognitive service API which has the same behavior https://github.com/Azure/azure-rest-api-specs/blob/efa7e41b82e82359fc76c0cda1856eb6e44448ec/specification/cognitiveservices/resource-manager/Microsoft.CognitiveServices/preview/2024-04-01-preview/cognitiveservices.json#L2717.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems"].post
  - code: PutResponseCodes
    reason: Service already using 202 response code for the below APIs, got exceptions from ARM reviewer.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}"].put
  - code: GuidUsage
    reason: Existing property in previous GA version.
    where:
      - $.definitions.WorkspaceConnectionOAuth2.properties.clientId.format
      - $.definitions.ManagedResourceGroupAssignedIdentities.properties.principalId.format
  - code: AvoidAdditionalProperties
    reason: Existing API behavior in 2024-10-01-preview.
    where:
      - $.definitions.CustomKeys.properties.keys
      - $.definitions.EndpointModelProperties.properties.capabilities
      - $.definitions.EndpointModelProperties.properties.finetuneCapabilities
      - $.definitions.ManagedOnlineEndpointResourceProperties.properties.mirrorTraffic
      - $.definitions.ManagedOnlineEndpointResourceProperties.properties.traffic
      - $.definitions.ServerlessEndpointInferenceEndpoint.properties.headers
      - $.definitions.WorkspaceConnectionPropertiesV2.properties.metadata
  - code: ParametersSchemaAsTypeObject
    reason: Existing API parameter with type array.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/customServices"].post.parameters[5].schema.type
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/updateDataMounts"].post.parameters[5].schema.type
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/addRaiBlocklistItems"].post.parameters[6].schema.type
  - code: SecurityDefinitionsStructure
    reason: Exist in swagger, not sure why complain
  - code: ProvisioningStateMustBeReadOnly
    reason: ProvisioningState are readonly here, nothing to fix here.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}"].get.responses.200.schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}"].patch.responses.200.schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}"].put.responses.200.schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}"].get.responses.200.schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}"].put.responses.200.schema
  - code: DefinitionsPropertiesNamesCamelCase
    reason: CMK is a short term and not violate the camel case rule.
    where:
      - $.definitions.WorkspaceProperties.properties.enableServiceSideCMKEncryption

```

### Tag: package-2024-10

These settings apply only when `--tag=package-2024-10` is specified on the command line.

```yaml $(tag) == 'package-2024-10'
input-file:
  - Microsoft.MachineLearningServices/stable/2024-10-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2024-10-01/mfe.json
  - Microsoft.MachineLearningServices/stable/2024-10-01/registries.json
  - Microsoft.MachineLearningServices/stable/2024-10-01/workspaceFeatures.json
  - Microsoft.MachineLearningServices/stable/2024-10-01/workspaceRP.json
suppressions:
  - code: PatchBodyParametersSchema
    reason: Suppress as instructed, this patch is for a abstract class and the type-discriminator needs to be required.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
  - code: ResourceNameRestriction
    reason: Experience is the same as previous GA version, adding restriction will be a breaking change.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/listNodes"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/listKeys"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/start"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/stop"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/restart"]
  - code: AvoidAdditionalProperties
    reason: Existing property in previous GA version.
    where:
      - $.definitions.SparkJob.properties.conf
      - $.definitions.SparkJob.properties.environmentVariables
      - $.definitions.WorkspaceConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: LroLocationHeader
    reason: Existing API behavior
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}"].delete.responses.202
  - code: PatchBodyParametersSchema
    reason: Existing API behavior, the whole property is not required.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}"].patch.parameters[4].schema.properties.properties
  - code: XmsPageableForListCalls
    reason: Existing API behavior.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/privateLinkResources"].get
  - code: GuidUsage
    reason: Existing property in previous GA version.
    where:
      - $.definitions.WorkspaceConnectionOAuth2.properties.clientId.format
  ```

### Tag: package-preview-2024-10

These settings apply only when `--tag=package-preview-2024-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-10'
input-file:
  - Microsoft.MachineLearningServices/preview/2024-10-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2024-10-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2024-10-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2024-10-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2024-10-01-preview/workspaceRP.json
suppressions:
  - code: NestedResourcesMustHaveListOperation
    reason: This resource will have many kind and we currently only start with the first kind that will have a 1 to 1 
        mapping with the parent resource, so right now we didn't implement List API, 
        we will add whence needed in the future.
    where:
      - $.definitions["CapabilityHostResource"]
  - code: DeleteResponseCodes
    reason: Existing API behavior in 2024-04-01-preview.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{inferencePoolName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}"].delete
  - code: PatchIdentityProperty
    reason: Existing API behavior in 2024-04-01-preview.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}"].patch.parameters[6]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}"].patch.parameters[6]
  - code: PathForResourceAction
    reason: Existing API behavior in 2024-04-01-preview.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/deltaModels/getStatus"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/deltaModels/list"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/deltaModels/modify"]
  - code: AvoidAdditionalProperties
    reason: Existing API behavior in 2024-04-01-preview.
    where:
      - $.definitions.CustomModelFineTuning.properties.hyperParameters
      - $.definitions.DeltaModelStatusResponse.properties.deltaModels
      - $.definitions.FineTuningJob.properties.outputs
      - $.definitions.SparkJob.properties.conf
      - $.definitions.SparkJob.properties.environmentVariables
  - code: PatchBodyParametersSchema
    reason: The required part is within a property, the whole property itself is not required.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}"].patch.parameters[4].schema.properties.properties
  - code: ProvisioningStateSpecifiedForLROPut
    reason: This should be exist in 2024-07-01-preview and got suppressed already, not sure why it got triggered.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/deployments/{deploymentName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiPolicies/{raiPolicyName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/raiPolicies/{raiPolicyName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/raiBlocklistItems/{raiBlocklistItemName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}"].put
  - code: PostResponseCodes
    reason: This API is intend to align with Cognitive service API which has the same behavior https://github.com/Azure/azure-rest-api-specs/blob/efa7e41b82e82359fc76c0cda1856eb6e44448ec/specification/cognitiveservices/resource-manager/Microsoft.CognitiveServices/preview/2024-04-01-preview/cognitiveservices.json#L2717.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems"].post
  - code: AvoidAdditionalProperties
    reason: Existing API behavior in 2024-07-01-preview.
    where:
      - $.definitions.CustomKeys.properties.keys
      - $.definitions.EndpointModelProperties.properties.capabilities
      - $.definitions.EndpointModelProperties.properties.finetuneCapabilities
      - $.definitions.ManagedOnlineEndpointResourceProperties.properties.mirrorTraffic
      - $.definitions.ManagedOnlineEndpointResourceProperties.properties.traffic
      - $.definitions.ServerlessEndpointInferenceEndpoint.properties.headers
      - $.definitions.WorkspaceConnectionPropertiesV2.properties.metadata
  - code: GuidUsage
    reason: This property has always been a GUID, we just didn't mark its format before,
       this can't be change without breaking the customer.
    where:
      - $.definitions.WorkspaceConnectionOAuth2.properties.clientId.format
  - code: DefinitionsPropertiesNamesCamelCase
    reason: CMK is a short term and not violate the camel case rule.
    where:
      - $.definitions.WorkspaceProperties.properties.enableServiceSideCMKEncryption
```

### Tag: package-preview-2024-07

These settings apply only when `--tag=package-preview-2024-07` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-07'
input-file:
  - Microsoft.MachineLearningServices/preview/2024-07-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2024-07-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2024-07-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2024-07-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2024-07-01-preview/workspaceRP.json
suppressions:
  - code: AvoidAdditionalProperties
    reason: As discussed In office hour this conf property is string dictionary 
      and passed by user as per there requirements depending on runtime version. 
      This passed to downstream and we have multiple validation on all required 
      configuration before passing it downstream, All optional property passed as 
      user wants and any failure due to that considered as user error.
    where:
      - $.definitions["SparkJob"].properties["conf"]
  - code: AvoidAdditionalProperties
    reason: This is for feature parity with other job type like commandjob, sweepjob etc.
       We have one interface for all type of job and other job take environment variable like this to match with them 
       we also pass environment variable in this format. please check existing "CommandJob" in same file.
    where:
      - $.definitions["SparkJob"].properties["environmentVariables"]
  - code: PatchBodyParametersSchema
    reason: This is already exist in preview version api version, the reason we have required mark for the property 
       inside is those are the only format we allow user to update this whole encryption property.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}"].patch.parameters[4].schema.properties.properties
  - code: AvoidAdditionalProperties
    reason: These schemas are already in production use,.
    where:
      - $.definitions.CustomKeys.properties.keys
      - $.definitions.WorkspaceConnectionPropertiesV2.properties.metadata
  - code: GuidUsage
    reason: This property has always been a GUID, we just didn't mark its format before,
       this can't be change without breaking the customer.
    where:
      - $.definitions.WorkspaceConnectionOAuth2.properties.clientId.format
  - code: AvoidAdditionalProperties
    reason: The headers property here is meant to describe a set of request headers that the user must pass along 
      in their inferencing API request. For that reason, this needs to be represented as an additionalProperties.
    where:
      - $.definitions["ServerlessEndpointInferenceEndpoint"].properties["headers"]
  - code: ProvisioningStateSpecifiedForLROPut
    reason: Below APIs are created for migration, the existing API contract is like this and won't able to change, 
      got exceptions from ARM reviewer.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/deployments/{deploymentName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiPolicies/{raiPolicyName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/raiPolicies/{raiPolicyName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/raiBlocklistItems/{raiBlocklistItemName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}"].put
  - code: AvoidAdditionalProperties
    reason: As discussed these are hyperparameters which can vary by model and fine tuning task types so cannot have strictly typed properties.
    where:
      - $.definitions["CustomModelFineTuning"].properties["hyperParameters"]
  - code: AvoidAdditionalProperties
    reason: This is coming for wrong reason, just inheriting from JobBase.
    where:
      - $.definitions["FineTuningJob"].allOf[0]["allOf"][0].properties["properties"]
      - $.definitions["FineTuningJob"].allOf[0].properties["notificationSetting"].properties["webhooks"]
      - $.definitions["FineTuningJob"].allOf[0].properties["secretsConfiguration"]
      - $.definitions["FineTuningJob"].allOf[0].properties["services"]
      - $.definitions["FineTuningJob"].allOf[0].properties["services"].additionalProperties["properties"].properties
  - code: AvoidAdditionalProperties
    reason: There is a similar usage in existing jobs.
    where:
      - $.definitions["FineTuningJob"].properties["outputs"]
  - code: GuidUsage
    reason: valid usage of UUID format since it is in the AAD objectId
    where:
      - $.definitions.ManagedResourceGroupAssignedIdentities
  - code: AvoidAdditionalProperties
    reason: This is cause by renaming some definition and already in prod use.
    where:
      - $.definitions.EndpointModelProperties.properties.capabilities
      - $.definitions.EndpointModelProperties.properties.finetuneCapabilities
  - code: AvoidAdditionalProperties
    reason: trying to align with schema here for caller to consume https://github.com/Azure/azure-rest-api-specs/blob/2e5be0e72597c6fc8d438f20e38087d900c16427/specification/machinelearningservices/resource-manager/Microsoft.MachineLearningServices/preview/2024-04-01-preview/mfe.json#L26070
    where:
      - $.definitions.ManagedOnlineEndpointResourceProperties.properties.mirrorTraffic
      - $.definitions.ManagedOnlineEndpointResourceProperties.properties.traffic
  - code: DefinitionsPropertiesNamesCamelCase
    reason: CMK is a short term and not violate the camel case rule.
    where:
      - $.definitions.WorkspaceProperties.properties.enableServiceSideCMKEncryption
  - code: PostResponseCodes
    reason: This API is intend to align with Cognitive service API which has the same behavior https://github.com/Azure/azure-rest-api-specs/blob/efa7e41b82e82359fc76c0cda1856eb6e44448ec/specification/cognitiveservices/resource-manager/Microsoft.CognitiveServices/preview/2024-04-01-preview/cognitiveservices.json#L2717.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems"].post
  ```

### Tag: package-2024-04

These settings apply only when `--tag=package-2024-04` is specified on the command line.

```yaml $(tag) == 'package-2024-04'
input-file:
  - Microsoft.MachineLearningServices/stable/2024-04-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2024-04-01/mfe.json
  - Microsoft.MachineLearningServices/stable/2024-04-01/registries.json
  - Microsoft.MachineLearningServices/stable/2024-04-01/workspaceFeatures.json
  - Microsoft.MachineLearningServices/stable/2024-04-01/workspaceRP.json
suppressions:
  - code: ProvisioningStateMustBeReadOnly
    reason: This provisioningState property is marked as readOnly. 
       However, the definition of the enum is not marked as readOnly and is the reason this suppression is needed
    where:
      - $.definitions["ServerlessEndpoint"].properties["provisioningState"]
  - code: AvoidAdditionalProperties
    reason: The headers property here is meant to describe a set of request headers 
      that the user must pass along in their inferencing API request. 
      For that reason, this needs to be represented as an additionalProperties
    where:
      - $.definitions["ServerlessInferenceEndpoint"].properties["headers"]
  - code: AvoidAdditionalProperties
    reason: As discussed In office hour this conf property is string dictionary 
      and passed by user as per there requirements depending on runtime version. 
      This passed to downstream and we have multiple validation on all required configuration before passing it 
      downstream, All optional property passed as user wants and any failure due to that considered as user error.
    where:
      - $.definitions["SparkJob"].properties["conf"]
  - code: AvoidAdditionalProperties
    reason: This is for feature parity with other job type like commandjob,
      sweepjob etc. We have one interface for all type of job and other job 
      take environment variable like this to match with them we also pass environment variable in this format. 
      please check existing "CommandJob" in same file.
    where:
      - $.definitions["SparkJob"].properties["environmentVariables"]
  - code: PatchBodyParametersSchema
    reason: This is already exist in preview version api version, 
      the reason we have required mark for the property inside is those are the only format 
      we allow user to update this whole encryption property.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}"].patch.parameters[4].schema.properties.properties
  - code: ProvisioningStateSpecifiedForLROPut
    reason: Service already using 202 response code for the below APIs in preview version.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/deployments/{deploymentName}].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiPolicies/{raiPolicyName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/raiBlocklistItems/{raiBlocklistItemName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}"].put
  - code: AvoidAdditionalProperties
    reason: These schemas are already in production use,.
    where:
      - $.definitions.WorkspaceUpdateParameters.properties.properties.properties.managedNetwork.properties.outboundRules
      - $.definitions.WorkspacePropertiesUpdateParameters.properties.managedNetwork.properties.outboundRules
      - $.definitions.EndpointModels.properties.value.items.properties.capabilities
      - $.definitions.AccountModel.properties.finetuneCapabilities
      - $.definitions.AccountModel.properties.capabilities
      - $.definitions.EndpointModels.properties.value.items.properties.finetuneCapabilities
      - $.definitions.CustomKeysWorkspaceConnectionProperties.properties.credentials.properties.keys
      - $.definitions.CustomKeys.properties.keys
      - $.definitions.WorkspaceConnectionPropertiesV2.properties.metadata
      - $.definitions.PATAuthTypeWorkspaceConnectionProperties.allOf[0].properties.metadata
      - $.definitions.SASAuthTypeWorkspaceConnectionProperties.allOf[0].properties.metadata
      - $.definitions.UsernamePasswordAuthTypeWorkspaceConnectionProperties.allOf[0].properties.metadata
      - $.definitions.NoneAuthTypeWorkspaceConnectionProperties.allOf[0].properties.metadata
      - $.definitions.ManagedIdentityAuthTypeWorkspaceConnectionProperties.allOf[0].properties.metadata
      - $.definitions.WorkspaceConnectionPropertiesV2BasicResource.properties.properties.properties.metadata
      - $.definitions.WorkspaceConnectionPropertiesV2BasicResourceArmPaginatedResult.properties.value.items.properties.properties.properties.metadata
      - $.definitions.AADAuthTypeWorkspaceConnectionProperties.allOf[0].properties.metadata
      - $.definitions.AccessKeyAuthTypeWorkspaceConnectionProperties.allOf[0].properties.metadata
      - $.definitions.AccountKeyAuthTypeWorkspaceConnectionProperties.allOf[0].properties.metadata
      - $.definitions.ApiKeyAuthWorkspaceConnectionProperties.allOf[0].properties.metadata
      - $.definitions.CustomKeysWorkspaceConnectionProperties.allOf[0].properties.metadata
      - $.definitions.OAuth2AuthTypeWorkspaceConnectionProperties.allOf[0].properties.metadata
      - $.definitions.ServicePrincipalAuthTypeWorkspaceConnectionProperties.allOf[0].properties.metadata
  - code: GuidUsage
    reason: This property has always been a GUID, we just didn't mark its format before, 
      this can't be change without breaking the customer.
    where:
      - $.definitions.WorkspaceConnectionOAuth2.properties.clientId.format
  - code: ProvisioningStateSpecifiedForLROPut
    reason: Caused by swagger file refactor, this is already in prod.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/outboundRules/{ruleName}].put
  - code: PutResponseCodes
    reason: Caused by swagger file refactor, this is already in prod.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/outboundRules/{ruleName}].put
  - code: DeleteResponseCodes
    reason: Caused by swagger file refactor, this is already in prod.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/outboundRules/{ruleName}].delete
  - code: LroLocationHeader
    reason: Caused by swagger file refactor, this is already in prod.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}].delete.responses.202
  - code: PatchBodyParametersSchema
    reason: Caused by swagger file refactor, this is already in prod.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}].patch.parameters[4].schema.properties.identity
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}].patch.parameters[4].schema.properties.sku
  - code: PostResponseCodes
    reason: Caused by swagger file refactor, this is already in prod.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/resyncKeys].post
  - code: GetCollectionOnlyHasValueAndNextLink
    reason: Caused by swagger file refactor, this is already in prod.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/outboundNetworkDependenciesEndpoints].get.responses.200.schema.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/privateLinkResources].get.responses.200.schema.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/privateEndpointConnections].get.responses.200.schema.properties
  - code: XmsPageableForListCalls
    reason: Caused by swagger file refactor, this is already in prod.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/outboundNetworkDependenciesEndpoints].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/privateLinkResources].get
  - code: AvoidAdditionalProperties
    reason: Caused by swagger file refactor, this is already in prod.
    where:
      - $.definitions.DiagnoseRequestProperties.properties.udr
      - $.definitions.DiagnoseRequestProperties.properties.nsg
      - $.definitions.DiagnoseRequestProperties.properties.resourceLock
      - $.definitions.DiagnoseRequestProperties.properties.dnsResolution
      - $.definitions.DiagnoseRequestProperties.properties.storageAccount
      - $.definitions.DiagnoseRequestProperties.properties.keyVault
      - $.definitions.DiagnoseRequestProperties.properties.containerRegistry
      - $.definitions.DiagnoseRequestProperties.properties.applicationInsights
      - $.definitions.DiagnoseRequestProperties.properties.others
      - $.definitions.ManagedNetworkSettings.properties.outboundRules
  - code: TrackedResourcePatchOperation
    reason: Caused by swagger file refactor, this is already in prod.
    where:
      - $.definitions.PrivateEndpointConnection
```

### Tag: package-preview-2024-04

These settings apply only when `--tag=package-preview-2024-04` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-04'
input-file:
  - Microsoft.MachineLearningServices/preview/2024-04-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2024-04-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2024-04-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2024-04-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2024-04-01-preview/workspaceRP.json
suppressions:
  - code: ProvisioningStateSpecifiedForLROPut
    reason: Below APIs are created for migration, the existing API contract is like this and won't able to change, 
      got exceptions from ARM reviewer.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/deployments/{deploymentName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiPolicies/{raiPolicyName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/raiPolicies/{raiPolicyName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/raiBlocklistItems/{raiBlocklistItemName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}"].put
```

### Tag: package-preview-2024-01

These settings apply only when `--tag=package-preview-2024-01` is specified on the command line.

``` yaml $(tag) == 'package-preview-2024-01'
input-file:
  - Microsoft.MachineLearningServices/preview/2024-01-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2024-01-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2024-01-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2024-01-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2024-01-01-preview/workspaceRP.json
suppressions:
  - code: PathForResourceAction
    reason: Keep identical to stable GA version to avoid breaking changes. https://dev.azure.com/msdata/Vienna/_workitems/edit/2803196
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/registries/{registryName}/datareferences/{name}/versions/{version}"].post
  - code: AvoidAdditionalProperties
    reason: As discussed these are hyperparameters which can vary by model 
      and fine tuning task types so cannot have strictly typed properties.
    where:
      - $.definitions["CustomModelFineTuning"].properties["hyperParameters"]
  - code: AvoidAdditionalProperties
    reason: This is coming for wrong reason, just inheriting from JobBase.
    where:
      - $.definitions["FineTuningJob"].allOf[0]["allOf"][0].properties["properties"]
      - $.definitions["FineTuningJob"].allOf[0].properties["notificationSetting"].properties["webhooks"]
      - $.definitions["FineTuningJob"].allOf[0].properties["secretsConfiguration"]
      - $.definitions["FineTuningJob"].allOf[0].properties["services"]
      - $.definitions["FineTuningJob"].allOf[0].properties["services"].additionalProperties["properties"].properties
  - code: AvoidAdditionalProperties
    reason: There is a similar usage in existing jobs.
    where:
      - $.definitions["FineTuningJob"].properties["outputs"]
  - code: ProvisioningStateSpecifiedForLROPut
    reason: Service already using 202 response code for the below APIs, got exceptions from ARM reviewer.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}"].put
  - code: PutResponseCodes
    reason: Service already using 202 response code for the below APIs, got exceptions from ARM reviewer.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}"].put
  - code: AvoidAdditionalProperties
    reason: This is an external reference right now, we will have full control 
      on the schema returned in the upcoming version and will avoid this.
    from: workspaceRP.json
    where:
      - $.definitions.AccountModel.properties.finetuneCapabilities
      - $.definitions.AccountModel.properties.capabilities
      - $.definitions.EndpointModels.properties.value.items.properties.capabilities
      - $.definitions.EndpointModels.properties.value.items.properties.finetuneCapabilities
  - code: GuidUsage
    reason: This property has always been a GUID, we just didn't mark its format before, 
       this can't be change without breaking the customer.
    from: workspaceRP.json    
    where:
      - $.definitions.WorkspaceConnectionOAuth2.properties.clientId.format
```

### Tag: package-preview-2023-08

These settings apply only when `--tag=package-preview-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-08'
input-file:
  - Microsoft.MachineLearningServices/preview/2023-08-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2023-08-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2023-08-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2023-08-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2023-08-01-preview/workspaceRP.json
suppressions:
  - code: LroPostReturn
    reason: LRO does not return 200 by design.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/resize"].post
  - code: TrackedResourcePatchOperation
    reason: server side don't support Patch yet track with https://msdata.visualstudio.com/Vienna/_workitems/edit/2702298.
    where:
      - $.definitions.PrivateEndpointConnection
```

### Tag: package-2023-10

These settings apply only when `--tag=package-2023-10` is specified on the command line.

``` yaml $(tag) == 'package-2023-10'
input-file:
  - Microsoft.MachineLearningServices/stable/2023-10-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2023-10-01/mfe.json
  - Microsoft.MachineLearningServices/stable/2023-10-01/registries.json
  - Microsoft.MachineLearningServices/stable/2023-10-01/workspaceFeatures.json
```

### Tag: package-preview-2023-06

These settings apply only when `--tag=package-preview-2023-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-06'
input-file:
  - Microsoft.MachineLearningServices/preview/2023-06-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2023-06-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2023-06-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2023-06-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2023-06-01-preview/workspaceRP.json
```

### Tag: package-2023-04

These settings apply only when `--tag=package-2023-04` is specified on the command line.

``` yaml $(tag) == 'package-2023-04'
input-file:
  - Microsoft.MachineLearningServices/stable/2023-04-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2023-04-01/mfe.json
  - Microsoft.MachineLearningServices/stable/2023-04-01/registries.json
  - Microsoft.MachineLearningServices/stable/2023-04-01/workspaceFeatures.json
```

### Tag: package-preview-2023-04

These settings apply only when `--tag=package-preview-2023-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-04'
input-file:
  - Microsoft.MachineLearningServices/preview/2023-04-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2023-04-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2023-04-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2023-04-01-preview/workspaceFeatures.json
```

### Tag: package-preview-2023-02

These settings apply only when `--tag=package-preview-2023-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-02'
input-file:
  - Microsoft.MachineLearningServices/preview/2023-02-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2023-02-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2023-02-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2023-02-01-preview/workspaceFeatures.json
```

### Tag: package-preview-2022-12

These settings apply only when `--tag=package-preview-2022-12` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-12'
input-file:
  - Microsoft.MachineLearningServices/preview/2022-12-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2022-12-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2022-12-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2022-12-01-preview/workspaceFeatures.json
```

### Tag: package-preview-2022-10

These settings apply only when `--tag=package-preview-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-10'
input-file:
  - Microsoft.MachineLearningServices/preview/2022-10-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2022-10-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2022-10-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2022-10-01-preview/registries.json
```

### Tag: package-2022-10

These settings apply only when `--tag=package-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-2022-10'
input-file:
  - Microsoft.MachineLearningServices/stable/2022-10-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2022-10-01/mfe.json
  - Microsoft.MachineLearningServices/stable/2022-10-01/workspaceFeatures.json
```

### Tag: package-preview-2022-06

These settings apply only when `--tag=package-preview-2022-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-06'
input-file:
  - Microsoft.MachineLearningServices/preview/2022-06-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2022-06-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2022-06-01-preview/workspaceFeatures.json
```

### Tag: package-2022-05-01

These settings apply only when `--tag=package-2022-05-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-05-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2022-05-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2022-05-01/mfe.json
  - Microsoft.MachineLearningServices/stable/2022-05-01/workspaceFeatures.json
```

### Tag: package-2022-02-01-preview

These settings apply only when `--tag=package-2022-02-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-02-01-preview'
input-file:
  - Microsoft.MachineLearningServices/preview/2022-02-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2022-02-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2022-02-01-preview/workspaceFeatures.json
```

### Tag: package-2022-01-01-preview

These settings apply only when `--tag=package-2022-01-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-01-01-preview'
input-file:
  - Microsoft.MachineLearningServices/preview/2022-01-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2022-01-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2022-01-01-preview/workspaceSkus.json
```

### Tag: package-2021-07-01

These settings apply only when `--tag=package-2021-07` is specified on the command line.

``` yaml $(tag) == 'package-2021-07-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2021-07-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2021-07-01/workspaceFeatures.json
  - Microsoft.MachineLearningServices/stable/2021-07-01/workspaceSkus.json
```

### Tag: package-2021-04-01

These settings apply only when `--tag=package-2021-04` is specified on the command line.

``` yaml $(tag) == 'package-2021-04-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2021-04-01/machineLearningServices.json
```

### Tag: package-2021-01-01

These settings apply only when `--tag=package-2021-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-01-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2021-01-01/machineLearningServices.json
```

### Tag: package-2021-03-01-preview

These settings apply only when `--tag=package-2021-03-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-03-01-preview'
input-file:
  - Microsoft.MachineLearningServices/preview/2021-03-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2021-03-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2021-03-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2021-03-01-preview/workspaceSkus.json
```

### Tag: package-2020-08-01

These settings apply only when `--tag=package-2020-08` is specified on the command line.

``` yaml $(tag) == 'package-2020-08-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2020-08-01/machineLearningServices.json
```

### Tag: package-2020-06-01

These settings apply only when `--tag=package-2020-06` is specified on the command line.

``` yaml $(tag) == 'package-2020-06-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2020-06-01/machineLearningServices.json
```

### Tag: package-preview-2020-05

These settings apply only when `--tag=package-preview-2020-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-05'
input-file:
  - Microsoft.MachineLearningServices/preview/2020-05-15-preview/machineLearningServices.json
```

### Tag: package-2020-04-01

These settings apply only when `--tag=package-2020-04` is specified on the command line.

``` yaml $(tag) == 'package-2020-04-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2020-04-01/machineLearningServices.json
```

### Tag: package-2020-03-01

These settings apply only when `--tag=package-2020-03` is specified on the command line.

``` yaml $(tag) == 'package-2020-03-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2020-03-01/machineLearningServices.json
```

### Tag: package-2020-01-01

These settings apply only when `--tag=package-2020-01` is specified on the command line.

``` yaml $(tag) == 'package-2020-01-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2020-01-01/machineLearningServices.json
```

### Tag: package-2019-11-01

These settings apply only when `--tag=package-2019-11` is specified on the command line.

``` yaml $(tag) == 'package-2019-11-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2019-11-01/machineLearningServices.json
```

### Tag: package-2019-06-01

These settings apply only when `--tag=package-2019-06-01` is specified on the command line.

``` yaml $(tag) == 'package-2019-06-01'
input-file:
- Microsoft.MachineLearningServices/stable/2019-06-01/machineLearningServices.json
```

### Tag: package-2019-05-01

These settings apply only when `--tag=package-2019-05-01` is specified on the command line.

``` yaml $(tag) == 'package-2019-05-01'
input-file:
- Microsoft.MachineLearningServices/stable/2019-05-01/machineLearningServices.json
```

### Tag: package-2018-11-19

These settings apply only when `--tag=package-2018-11-19` is specified on the command line.

``` yaml $(tag) == 'package-2018-11-19'
input-file:
- Microsoft.MachineLearningServices/stable/2018-11-19/machineLearningServices.json
```

### Tag: package-2020-09-01-preview

These settings apply only when `--tag=package-2020-09-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-09-01-preview'
input-file:
- Microsoft.MachineLearningServices/preview/2020-09-01-preview/jobs.json
- Microsoft.MachineLearningServices/preview/2020-09-01-preview/machineLearningServices.json
```

### Tag: package-2020-05-01-preview

These settings apply only when `--tag=package-2020-05-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-05-01-preview'
input-file:
- Microsoft.MachineLearningServices/preview/2020-05-01-preview/machineLearningServices.json
```

### Tag: package-2020-04-01-preview

These settings apply only when `--tag=package-2020-04-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-04-01-preview'
input-file:
- Microsoft.MachineLearningServices/preview/2020-04-01-preview/machineLearningServices.json
```

### Tag: package-2020-02-18-preview

These settings apply only when `--tag=package-2020-02-18-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-02-18-preview'
input-file:
- Microsoft.MachineLearningServices/preview/2020-02-18-preview/machineLearningServices.json
```

### Tag: package-2018-03-preview

These settings apply only when `--tag=package-2018-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-03-preview'
input-file:
- Microsoft.MachineLearningServices/preview/2018-03-01-preview/machineLearningServices.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-cli-extensions
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
