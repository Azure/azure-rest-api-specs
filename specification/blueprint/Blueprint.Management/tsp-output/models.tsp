import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Blueprint;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The scope where this blueprint definition can be assigned.")
enum BlueprintTargetScope {
  @doc("The blueprint targets a subscription during blueprint assignment.")
  subscription,
  @doc("The blueprint targets a management group during blueprint assignment. This is reserved for future use.")
  managementGroup,
}

@doc("Allowed data types for Resource Manager template parameters.")
enum TemplateParameterType {
  string,
  array,
  bool,
  int,
  object,
  secureObject,
  secureString,
}

@doc("Specifies the kind of blueprint artifact.")
enum ArtifactKind {
  template,
  roleAssignment,
  policyAssignment,
}

@doc("Type of the managed identity.")
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
}

@doc("Lock mode.")
enum AssignmentLockMode {
  None,
  AllResourcesReadOnly,
  AllResourcesDoNotDelete,
}

@doc("State of the blueprint assignment.")
enum AssignmentProvisioningState {
  creating,
  validating,
  waiting,
  deploying,
  cancelling,
  locking,
  succeeded,
  failed,
  canceled,
  deleting,
}

enum AssignmentDeleteBehavior {
  none,
  all,
}

@doc("Schema for blueprint definition properties.")
model BlueprintProperties extends SharedBlueprintProperties {
  @doc("Published versions of this blueprint definition.")
  versions?: Record<unknown>;

  @doc("Layout view of the blueprint definition for UI reference.")
  @visibility("read")
  layout?: Record<unknown>;
}

@doc("Shared Schema for both blueprintProperties and publishedBlueprintProperties.")
model SharedBlueprintProperties extends BlueprintResourcePropertiesBase {
  @doc("Status of the blueprint. This field is readonly.")
  @visibility("read")
  status?: BlueprintStatus;

  @doc("The scope where this blueprint definition can be assigned.")
  targetScope?: BlueprintTargetScope;

  @doc("Parameters required by this blueprint definition.")
  parameters?: Record<ParameterDefinition>;

  @doc("Resource group placeholders defined by this blueprint definition.")
  resourceGroups?: Record<ResourceGroupDefinition>;
}

@doc("The status of the blueprint. This field is readonly.")
model BlueprintStatus extends BlueprintResourceStatusBase {}

@doc("Shared status properties between all blueprint resources.")
model BlueprintResourceStatusBase {
  @doc("Creation time of this blueprint definition.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeCreated?: utcDateTime;

  @doc("Last modified time of this blueprint definition.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;
}

@doc("Represent a parameter with constrains and metadata.")
model ParameterDefinition {
  @doc("Allowed data types for Resource Manager template parameters.")
  type: TemplateParameterType;

  @doc("User-friendly properties for this parameter.")
  metadata?: ParameterDefinitionMetadata;

  @doc("Default Value for this parameter.")
  defaultValue?: unknown;

  @doc("Array of allowed values for this parameter.")
  allowedValues?: unknown[];
}

@doc("User-friendly properties for this parameter.")
model ParameterDefinitionMetadata {
  @doc("DisplayName of this parameter/resourceGroup.")
  @maxLength(256)
  displayName?: string;

  @doc("Description of this parameter/resourceGroup.")
  @maxLength(500)
  description?: string;

  @doc("StrongType for UI to render rich experience during blueprint assignment. Supported strong types are resourceType, principalId and location.")
  @maxLength(64)
  strongType?: string;
}

@doc("Represents an Azure resource group in a blueprint definition.")
model ResourceGroupDefinition {
  @doc("Name of this resourceGroup. Leave empty if the resource group name will be specified during the blueprint assignment.")
  name?: string;

  @doc("Location of this resourceGroup. Leave empty if the resource group location will be specified during the blueprint assignment.")
  location?: string;

  @doc("User-friendly properties for this resource group.")
  metadata?: ParameterDefinitionMetadata;

  @doc("Artifacts which need to be deployed before this resource group.")
  dependsOn?: string[];

  @doc("Tags to be assigned to this resource group.")
  tags?: Record<string>;
}

@doc("Shared properties between all blueprint resources.")
model BlueprintResourcePropertiesBase {
  @doc("One-liner string explain this resource.")
  @maxLength(256)
  displayName?: string;

  @doc("Multi-line explain this resource.")
  @maxLength(500)
  description?: string;
}

@doc("Common properties for all Azure resources.")
model AzureResourceBase {
  @doc("String Id used to locate any resource on Azure.")
  @visibility("read")
  id?: string;

  @doc("Type of this resource.")
  @visibility("read")
  type?: string;

  @doc("Name of this resource.")
  @visibility("read")
  name?: string;
}

@error
model CloudError {
  @doc("Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.)")
  error?: ErrorResponse;
}

@doc("Schema for published blueprint definition properties.")
model PublishedBlueprintProperties extends SharedBlueprintProperties {
  @doc("Name of the published blueprint definition.")
  blueprintName?: string;

  @doc("Version-specific change notes.")
  @maxLength(500)
  changeNotes?: string;
}

@doc("List of published blueprint definitions.")
model PublishedBlueprintList is Azure.Core.Page<PublishedBlueprint>;

@doc("Detailed properties for a blueprint assignment.")
model AssignmentProperties extends BlueprintResourcePropertiesBase {
  @doc("ID of the published version of a blueprint definition.")
  blueprintId?: string;

  @doc("The target subscription scope of the blueprint assignment (format: '/subscriptions/{subscriptionId}'). For management group level assignments, the property is required.")
  scope?: string;

  @doc("Blueprint assignment parameter values.")
  parameters: Record<ParameterValue>;

  @doc("Names and locations of resource group placeholders.")
  resourceGroups: Record<ResourceGroupValue>;

  @doc("Status of blueprint assignment. This field is readonly.")
  @visibility("read")
  status?: AssignmentStatus;

  @doc("Defines how resources deployed by a blueprint assignment are locked.")
  locks?: AssignmentLockSettings;

  @doc("State of the blueprint assignment.")
  @visibility("read")
  provisioningState?: AssignmentProvisioningState;
}

@doc("Value for the specified parameter. Can be either 'value' or 'reference' but not both.")
model ParameterValue {
  @doc("Parameter value. Any valid JSON value is allowed including objects, arrays, strings, numbers and booleans.")
  value?: Record<unknown>;

  @doc("Parameter value as reference type.")
  reference?: SecretValueReference;
}

@doc("Reference to a Key Vault secret.")
model SecretValueReference {
  @doc("Specifies the reference to a given Azure Key Vault.")
  keyVault: KeyVaultReference;

  @doc("Name of the secret.")
  secretName: string;

  @doc("The version of the secret to use. If left blank, the latest version of the secret is used.")
  secretVersion?: string;
}

@doc("Specifies the link to a Key Vault.")
model KeyVaultReference {
  @doc("Azure resource ID of the Key Vault.")
  id: string;
}

@doc("Represents an Azure resource group.")
model ResourceGroupValue {
  @doc("Name of the resource group.")
  @maxLength(90)
  @minLength(1)
  name?: string;

  @doc("Location of the resource group.")
  location?: string;
}

@doc("The status of a blueprint assignment. This field is readonly.")
model AssignmentStatus extends BlueprintResourceStatusBase {
  @doc("List of resources that were created by the blueprint assignment.")
  @visibility("read")
  managedResources?: string[];
}

@doc("Defines how resources deployed by a blueprint assignment are locked.")
model AssignmentLockSettings {
  @doc("Lock mode.")
  mode?: AssignmentLockMode;

  @doc("List of AAD principals excluded from blueprint locks. Up to 5 principals are permitted.")
  excludedPrincipals?: string[];

  @doc("List of management operations that are excluded from blueprint locks. Up to 200 actions are permitted. If the lock mode is set to 'AllResourcesReadOnly', then the following actions are automatically appended to 'excludedActions': '*/read', 'Microsoft.Network/virtualNetworks/subnets/join/action' and 'Microsoft.Authorization/locks/delete'. If the lock mode is set to 'AllResourcesDoNotDelete', then the following actions are automatically appended to 'excludedActions': 'Microsoft.Authorization/locks/delete'. Duplicate actions will get removed.")
  excludedActions?: string[];
}

@doc("Response schema for querying the Azure Blueprints service principal in the tenant.")
model WhoIsBlueprintContract {
  @doc("AAD object Id of the Azure Blueprints service principal in the tenant.")
  objectId?: string;
}

@doc("Properties of AssignmentOperation.")
model AssignmentOperationProperties {
  @doc("The published version of the blueprint definition used for the blueprint assignment operation.")
  blueprintVersion?: string;

  @doc("State of this blueprint assignment operation.")
  assignmentState?: string;

  @doc("Create time of this blueprint assignment operation.")
  timeCreated?: string;

  @doc("Start time of the underlying deployment.")
  timeStarted?: string;

  @doc("Finish time of the overall underlying deployments.")
  timeFinished?: string;

  @doc("List of jobs in this blueprint assignment operation.")
  deployments?: AssignmentDeploymentJob[];
}

@doc("Represents individual job in given blueprint assignment operation.")
model AssignmentDeploymentJob {
  @doc("Kind of job.")
  kind?: string;

  @doc("Name of the action performed in this job.")
  action?: string;

  @doc("Id of this job.")
  jobId?: string;

  @doc("State of this job.")
  jobState?: string;

  @doc("Deployment job result.")
  result?: AssignmentDeploymentJobResult;

  @doc("Result of this deployment job for each retry.")
  history?: AssignmentDeploymentJobResult[];

  @doc("Reference to deployment job resource id.")
  requestUri?: string;
}

@doc("Result of each individual deployment in a blueprint assignment.")
model AssignmentDeploymentJobResult {
  @doc("Contains error details if deployment job failed.")
  error?: AzureResourceManagerError;

  @doc("Resources created as result of the deployment job.")
  resources?: AssignmentJobCreatedResource[];
}

@doc("Error code and message")
model AzureResourceManagerError {
  @doc("Error code.")
  code?: string;

  @doc("Error message.")
  message?: string;
}

@doc("Azure resource created from deployment job.")
model AssignmentJobCreatedResource extends AzureResourceBase {
  @doc("Additional properties in a dictionary.")
  properties?: Record<string>;
}

@doc("Results of the request to list operations.")
model ResourceProviderOperationList {
  @doc("List of operations supported by this resource provider.")
  value?: ResourceProviderOperation[];
}

@doc("Supported operations of this resource provider.")
model ResourceProviderOperation {
  @doc("Operation name, in format of {provider}/{resource}/{operation}")
  name?: string;

  @doc("Display metadata associated with the operation.")
  display?: ResourceProviderOperationDisplay;
}

@doc("Display metadata associated with the operation.")
model ResourceProviderOperationDisplay {
  @doc("Resource provider: Microsoft Blueprint.")
  provider?: string;

  @doc("Resource on which the operation is performed.")
  resource?: string;

  @doc("Type of operation: get, read, delete, etc.")
  operation?: string;

  @doc("Description of this operation.")
  description?: string;
}

@doc("Properties of a Resource Manager template blueprint artifact.")
model TemplateArtifactProperties {
  ...BlueprintResourcePropertiesBase;
  ...ArtifactPropertiesBase;

  @doc("The Resource Manager template blueprint artifact body.")
  template: Record<unknown>;

  @doc("If applicable, the name of the resource group placeholder to which the Resource Manager template blueprint artifact will be deployed.")
  resourceGroup?: string;

  @doc("Resource Manager template blueprint artifact parameter values.")
  parameters: Record<ParameterValue>;
}

@doc("Common properties shared by different artifacts.")
model ArtifactPropertiesBase {
  @doc("Artifacts which need to be deployed before the specified artifact.")
  dependsOn?: string[];
}

@doc("Blueprint artifact that deploys a Resource Manager template.")
model TemplateArtifact extends Artifact {
  @doc("Properties for a Resource Manager template blueprint artifact.")
  properties: TemplateArtifactProperties;

  @doc("Specifies the kind of blueprint artifact.")
  kind: "template";
}

@doc("Properties of a Role assignment blueprint artifact.")
model RoleAssignmentArtifactProperties {
  ...BlueprintResourcePropertiesBase;
  ...ArtifactPropertiesBase;

  @doc("Azure resource ID of the RoleDefinition.")
  roleDefinitionId: string;

  @doc("Array of user or group identities in Azure Active Directory. The roleDefinition will apply to each identity.")
  principalIds: unknown;

  @doc("RoleAssignment will be scope to this resourceGroup. If empty, it scopes to the subscription.")
  resourceGroup?: string;
}

@doc("Blueprint artifact that applies a Role assignment.")
model RoleAssignmentArtifact extends Artifact {
  @doc("Properties for a Role assignment blueprint artifact.")
  properties: RoleAssignmentArtifactProperties;

  @doc("Specifies the kind of blueprint artifact.")
  kind: "roleAssignment";
}

@doc("Properties of a Policy assignment blueprint artifact.")
model PolicyAssignmentArtifactProperties {
  ...BlueprintResourcePropertiesBase;
  ...ArtifactPropertiesBase;

  @doc("Azure resource ID of the policy definition.")
  policyDefinitionId: string;

  @doc("Parameter values for the policy definition.")
  parameters: Record<ParameterValue>;

  @doc("Name of the resource group placeholder to which the policy will be assigned.")
  resourceGroup?: string;
}

@doc("Blueprint artifact that applies a Policy assignment.")
model PolicyAssignmentArtifact extends Artifact {
  @doc("properties for policyAssignment Artifact")
  properties: PolicyAssignmentArtifactProperties;

  @doc("Specifies the kind of blueprint artifact.")
  kind: "policyAssignment";
}
