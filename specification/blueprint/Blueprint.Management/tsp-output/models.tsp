import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";


using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;


namespace Microsoft.Blueprint;

interface Operations extends Azure.ResourceManager.Operations {} 

/**
* The scope where this blueprint definition can be assigned.
*/
    enum BlueprintTargetScope {
        /**
* The blueprint targets a subscription during blueprint assignment.
*/"subscription", /**
* The blueprint targets a management group during blueprint assignment. This is reserved for future use.
*/"managementGroup"
    }

/**
* Allowed data types for Resource Manager template parameters.
*/
    enum TemplateParameterType {
        "string", "array", "bool", "int", "object", "secureObject", "secureString"
    }

/**
* Specifies the kind of blueprint artifact.
*/
    enum ArtifactKind {
        "template", "roleAssignment", "policyAssignment"
    }

/**
* Type of the managed identity.
*/
    enum ManagedServiceIdentityType {
        "None", "SystemAssigned", "UserAssigned"
    }

/**
* Lock mode.
*/
    enum AssignmentLockMode {
        "None", "AllResourcesReadOnly", "AllResourcesDoNotDelete"
    }

/**
* State of the blueprint assignment.
*/
    enum AssignmentProvisioningState {
        "creating", "validating", "waiting", "deploying", "cancelling", "locking", "succeeded", "failed", "canceled", "deleting"
    }


    enum AssignmentDeleteBehavior {
        "none", "all"
    }




/**
* Schema for blueprint definition properties.
*/
model BlueprintProperties extends SharedBlueprintProperties {
/**
* Published versions of this blueprint definition.
*/
"versions"?: Record<unknown>;
/**
* Layout view of the blueprint definition for UI reference.
*/
@visibility("read")
"layout"?: Record<unknown>;
}

/**
* Shared Schema for both blueprintProperties and publishedBlueprintProperties.
*/
model SharedBlueprintProperties extends BlueprintResourcePropertiesBase {
/**
* Status of the blueprint. This field is readonly.
*/
@visibility("read")
"status"?: BlueprintStatus;
/**
* The scope where this blueprint definition can be assigned.
*/
"targetScope"?: BlueprintTargetScope;
/**
* Parameters required by this blueprint definition.
*/
"parameters"?: Record<ParameterDefinition>;
/**
* Resource group placeholders defined by this blueprint definition.
*/
"resourceGroups"?: Record<ResourceGroupDefinition>;
}

/**
* The status of the blueprint. This field is readonly.
*/
model BlueprintStatus extends BlueprintResourceStatusBase {
}

/**
* Shared status properties between all blueprint resources.
*/
model BlueprintResourceStatusBase {
/**
* Creation time of this blueprint definition.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"timeCreated"?: utcDateTime;
/**
* Last modified time of this blueprint definition.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastModified"?: utcDateTime;
}

/**
* Represent a parameter with constrains and metadata.
*/
model ParameterDefinition {
/**
* Allowed data types for Resource Manager template parameters.
*/
"type": TemplateParameterType;
/**
* User-friendly properties for this parameter.
*/
@extension("x-ms-client-flatten", true)
"metadata"?: ParameterDefinitionMetadata;
/**
* Default Value for this parameter.
*/
"defaultValue"?: unknown;
/**
* Array of allowed values for this parameter.
*/
"allowedValues"?: unknown[];
}

/**
* User-friendly properties for this parameter.
*/
model ParameterDefinitionMetadata {
/**
* DisplayName of this parameter/resourceGroup.
*/
@maxLength(256)
"displayName"?: string;
/**
* Description of this parameter/resourceGroup.
*/
@maxLength(500)
"description"?: string;
/**
* StrongType for UI to render rich experience during blueprint assignment. Supported strong types are resourceType, principalId and location.
*/
@maxLength(64)
"strongType"?: string;
}

/**
* Represents an Azure resource group in a blueprint definition.
*/
model ResourceGroupDefinition {
/**
* Name of this resourceGroup. Leave empty if the resource group name will be specified during the blueprint assignment.
*/
"name"?: string;
/**
* Location of this resourceGroup. Leave empty if the resource group location will be specified during the blueprint assignment.
*/
"location"?: string;
/**
* User-friendly properties for this resource group.
*/
@extension("x-ms-client-flatten", true)
"metadata"?: ParameterDefinitionMetadata;
/**
* Artifacts which need to be deployed before this resource group.
*/
"dependsOn"?: string[];
/**
* Tags to be assigned to this resource group.
*/
"tags"?: Record<string>;
}

/**
* Shared properties between all blueprint resources.
*/
model BlueprintResourcePropertiesBase {
/**
* One-liner string explain this resource.
*/
@maxLength(256)
"displayName"?: string;
/**
* Multi-line explain this resource.
*/
@maxLength(500)
"description"?: string;
}

/**
* Common properties for all Azure resources.
*/
model AzureResourceBase {
/**
* String Id used to locate any resource on Azure.
*/
@visibility("read")
"id"?: string;
/**
* Type of this resource.
*/
@visibility("read")
"type"?: string;
/**
* Name of this resource.
*/
@visibility("read")
"name"?: string;
}


@error
model CloudError {
/**
* Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.)
*/
"error"?: ErrorResponse;
}

/**
* Schema for published blueprint definition properties.
*/
model PublishedBlueprintProperties extends SharedBlueprintProperties {
/**
* Name of the published blueprint definition.
*/
"blueprintName"?: string;
/**
* Version-specific change notes.
*/
@maxLength(500)
"changeNotes"?: string;
}

/**
* List of published blueprint definitions.
*/
model PublishedBlueprintList is Azure.Core.Page<PublishedBlueprint> {
}

/**
* Detailed properties for a blueprint assignment.
*/
model AssignmentProperties extends BlueprintResourcePropertiesBase {
/**
* ID of the published version of a blueprint definition.
*/
"blueprintId"?: string;
/**
* The target subscription scope of the blueprint assignment (format: '/subscriptions/{subscriptionId}'). For management group level assignments, the property is required.
*/
"scope"?: string;
/**
* Blueprint assignment parameter values.
*/
"parameters": Record<ParameterValue>;
/**
* Names and locations of resource group placeholders.
*/
"resourceGroups": Record<ResourceGroupValue>;
/**
* Status of blueprint assignment. This field is readonly.
*/
@visibility("read")
"status"?: AssignmentStatus;
/**
* Defines how resources deployed by a blueprint assignment are locked.
*/
"locks"?: AssignmentLockSettings;
/**
* State of the blueprint assignment.
*/
@visibility("read")
"provisioningState"?: AssignmentProvisioningState;
}

/**
* Value for the specified parameter. Can be either 'value' or 'reference' but not both.
*/
model ParameterValue {
/**
* Parameter value. Any valid JSON value is allowed including objects, arrays, strings, numbers and booleans.
*/
"value"?: Record<unknown>;
/**
* Parameter value as reference type.
*/
"reference"?: SecretValueReference;
}

/**
* Reference to a Key Vault secret.
*/
model SecretValueReference {
/**
* Specifies the reference to a given Azure Key Vault.
*/
"keyVault": KeyVaultReference;
/**
* Name of the secret.
*/
"secretName": string;
/**
* The version of the secret to use. If left blank, the latest version of the secret is used.
*/
"secretVersion"?: string;
}

/**
* Specifies the link to a Key Vault.
*/
model KeyVaultReference {
/**
* Azure resource ID of the Key Vault.
*/
"id": string;
}

/**
* Represents an Azure resource group.
*/
model ResourceGroupValue {
/**
* Name of the resource group.
*/
@maxLength(90)
@minLength(1)
"name"?: string;
/**
* Location of the resource group.
*/
"location"?: string;
}

/**
* The status of a blueprint assignment. This field is readonly.
*/
model AssignmentStatus extends BlueprintResourceStatusBase {
/**
* List of resources that were created by the blueprint assignment.
*/
@visibility("read")
"managedResources"?: string[];
}

/**
* Defines how resources deployed by a blueprint assignment are locked.
*/
model AssignmentLockSettings {
/**
* Lock mode.
*/
"mode"?: AssignmentLockMode;
/**
* List of AAD principals excluded from blueprint locks. Up to 5 principals are permitted.
*/
"excludedPrincipals"?: string[];
/**
* List of management operations that are excluded from blueprint locks. Up to 200 actions are permitted. If the lock mode is set to 'AllResourcesReadOnly', then the following actions are automatically appended to 'excludedActions': '*/read', 'Microsoft.Network/virtualNetworks/subnets/join/action' and 'Microsoft.Authorization/locks/delete'. If the lock mode is set to 'AllResourcesDoNotDelete', then the following actions are automatically appended to 'excludedActions': 'Microsoft.Authorization/locks/delete'. Duplicate actions will get removed.
*/
"excludedActions"?: string[];
}

/**
* Response schema for querying the Azure Blueprints service principal in the tenant.
*/
model WhoIsBlueprintContract {
/**
* AAD object Id of the Azure Blueprints service principal in the tenant.
*/
"objectId"?: string;
}

/**
* Properties of AssignmentOperation.
*/
model AssignmentOperationProperties {
/**
* The published version of the blueprint definition used for the blueprint assignment operation.
*/
"blueprintVersion"?: string;
/**
* State of this blueprint assignment operation.
*/
"assignmentState"?: string;
/**
* Create time of this blueprint assignment operation.
*/
"timeCreated"?: string;
/**
* Start time of the underlying deployment.
*/
"timeStarted"?: string;
/**
* Finish time of the overall underlying deployments.
*/
"timeFinished"?: string;
/**
* List of jobs in this blueprint assignment operation.
*/
"deployments"?: AssignmentDeploymentJob[];
}

/**
* Represents individual job in given blueprint assignment operation.
*/
model AssignmentDeploymentJob {
/**
* Kind of job.
*/
"kind"?: string;
/**
* Name of the action performed in this job.
*/
"action"?: string;
/**
* Id of this job.
*/
"jobId"?: string;
/**
* State of this job.
*/
"jobState"?: string;
/**
* Deployment job result.
*/
"result"?: AssignmentDeploymentJobResult;
/**
* Result of this deployment job for each retry.
*/
"history"?: AssignmentDeploymentJobResult[];
/**
* Reference to deployment job resource id.
*/
"requestUri"?: string;
}

/**
* Result of each individual deployment in a blueprint assignment.
*/
model AssignmentDeploymentJobResult {
/**
* Contains error details if deployment job failed.
*/
"error"?: AzureResourceManagerError;
/**
* Resources created as result of the deployment job.
*/
"resources"?: AssignmentJobCreatedResource[];
}

/**
* Error code and message
*/
model AzureResourceManagerError {
/**
* Error code.
*/
"code"?: string;
/**
* Error message.
*/
"message"?: string;
}

/**
* Azure resource created from deployment job.
*/
model AssignmentJobCreatedResource extends AzureResourceBase {
/**
* Additional properties in a dictionary.
*/
"properties"?: Record<string>;
}

/**
* Results of the request to list operations.
*/
model ResourceProviderOperationList {
/**
* List of operations supported by this resource provider.
*/
"value"?: ResourceProviderOperation[];
}

/**
* Supported operations of this resource provider.
*/
model ResourceProviderOperation {
/**
* Operation name, in format of {provider}/{resource}/{operation}
*/
"name"?: string;
/**
* Display metadata associated with the operation.
*/
"display"?: ResourceProviderOperationDisplay;
}

/**
* Display metadata associated with the operation.
*/
model ResourceProviderOperationDisplay {
/**
* Resource provider: Microsoft Blueprint.
*/
"provider"?: string;
/**
* Resource on which the operation is performed.
*/
"resource"?: string;
/**
* Type of operation: get, read, delete, etc.
*/
"operation"?: string;
/**
* Description of this operation.
*/
"description"?: string;
}

/**
* Properties of a Resource Manager template blueprint artifact.
*/
model TemplateArtifactProperties {
...BlueprintResourcePropertiesBase;
...ArtifactPropertiesBase;
/**
* The Resource Manager template blueprint artifact body.
*/
"template": Record<unknown>;
/**
* If applicable, the name of the resource group placeholder to which the Resource Manager template blueprint artifact will be deployed.
*/
"resourceGroup"?: string;
/**
* Resource Manager template blueprint artifact parameter values.
*/
"parameters": Record<ParameterValue>;
}

/**
* Common properties shared by different artifacts.
*/
model ArtifactPropertiesBase {
/**
* Artifacts which need to be deployed before the specified artifact.
*/
"dependsOn"?: string[];
}

/**
* Blueprint artifact that deploys a Resource Manager template.
*/
model TemplateArtifact extends Artifact {
/**
* Properties for a Resource Manager template blueprint artifact.
*/
@extension("x-ms-client-flatten", true)
"properties": TemplateArtifactProperties;
/**
* Specifies the kind of blueprint artifact.
*/
"kind": "template";
}

/**
* Properties of a Role assignment blueprint artifact.
*/
model RoleAssignmentArtifactProperties {
...BlueprintResourcePropertiesBase;
...ArtifactPropertiesBase;
/**
* Azure resource ID of the RoleDefinition.
*/
"roleDefinitionId": string;
/**
* Array of user or group identities in Azure Active Directory. The roleDefinition will apply to each identity.
*/
"principalIds": unknown;
/**
* RoleAssignment will be scope to this resourceGroup. If empty, it scopes to the subscription.
*/
"resourceGroup"?: string;
}

/**
* Blueprint artifact that applies a Role assignment.
*/
model RoleAssignmentArtifact extends Artifact {
/**
* Properties for a Role assignment blueprint artifact.
*/
@extension("x-ms-client-flatten", true)
"properties": RoleAssignmentArtifactProperties;
/**
* Specifies the kind of blueprint artifact.
*/
"kind": "roleAssignment";
}

/**
* Properties of a Policy assignment blueprint artifact.
*/
model PolicyAssignmentArtifactProperties {
...BlueprintResourcePropertiesBase;
...ArtifactPropertiesBase;
/**
* Azure resource ID of the policy definition.
*/
"policyDefinitionId": string;
/**
* Parameter values for the policy definition.
*/
"parameters": Record<ParameterValue>;
/**
* Name of the resource group placeholder to which the policy will be assigned.
*/
"resourceGroup"?: string;
}

/**
* Blueprint artifact that applies a Policy assignment.
*/
model PolicyAssignmentArtifact extends Artifact {
/**
* properties for policyAssignment Artifact
*/
@extension("x-ms-client-flatten", true)
"properties": PolicyAssignmentArtifactProperties;
/**
* Specifies the kind of blueprint artifact.
*/
"kind": "policyAssignment";
}