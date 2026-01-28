import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Resources.DeploymentStacks;

/** Deployment stack object. */
model DeploymentStack
  is Azure.ResourceManager.ProxyResource<DeploymentStackProperties> {
  ...DeploymentStackNameParameter;

  /** The geo-location where the resource lives. Required for subscription and management group scoped stacks. The location is inherited from the resource group for resource group scoped stacks. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Model is shared between resource group, subscription, and management group scope."
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "This is the expected type"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Model is shared between resource group, subscription, and management group scope."
  tags?: Record<string>;
}

@@doc(DeploymentStack.properties, "Deployment stack properties.");

alias DeploymentStackNameParameter = ResourceNameParameter<
  Resource = DeploymentStack,
  KeyName = "deploymentStackName",
  SegmentName = "deploymentStacks",
  NamePattern = "^[-\\w\\._\\(\\)]+$"
>;

@@maxLength(DeploymentStack.name, 90);
@@minLength(DeploymentStack.name, 1);
@@doc(DeploymentStack.name, "Name of the deployment stack.");

/**
 * Specifies an action for a newly unmanaged resource.
 */
union UnmanageActionResourceMode {
  string,
  
  /** Delete the resources from Azure. */
  Delete: "delete",

  /** Keep the resources in Azure. */
  Detach: "detach",
}

/**
 * Specifies an action for a newly unmanaged resource group.
 */
union UnmanageActionResourceGroupMode {
  string,
  
  /** Delete the resource groups from Azure. */
  Delete: "delete",

  /** Keep the resource groups in Azure. */
  Detach: "detach",
}

/**
 * Specifies an action for a newly unmanaged resource.
 */
union UnmanageActionManagementGroupMode {
  string,
  
  /** Delete the management groups from Azure. */
  Delete: "delete",

  /** Keep the management groups in Azure. */
  Detach: "detach",
}
  
/**
 * Specifies an action for resources that do not support deletion.
 */
@added(Versions.v2025_07_01)
union ResourcesWithoutDeleteSupportAction {
  string,

  /** Detach the specified resources from the deployment stack and continue. */
  Detach: "detach",

  /** Fail the deployment stack if resources cannot be deleted. */
  Fail: "fail",
}

/**
 * denySettings Mode that defines denied actions.
 */
union DenySettingsMode {
  string,

  /**
   * Authorized users are able to read and modify the resources, but cannot delete.
   */
  DenyDelete: "denyDelete",

  /**
   * Authorized users can read from a resource, but cannot modify or delete it.
   */
  DenyWriteAndDelete: "denyWriteAndDelete",

  /**
   * No denyAssignments have been applied.
   */
  None: "none",
}

/**
 * State of the deployment stack.
 */
union DeploymentStackProvisioningState {
  string,

  /** The deployment stack is currently being created */
  Creating: "creating",

  /** The deployment stack is currently being validated */
  Validating: "validating",

  /** The deployment stack is currently waiting */
  Waiting: "waiting",

  /** The deployment stack is currently deploying */
  Deploying: "deploying",

  /** The deployment stack is being cancelled */
  Canceling: "canceling",

  /** The deployment stack is updating deny assignments */
  UpdatingDenyAssignments: "updatingDenyAssignments",

  /** The deployment stack is deleting resources */
  DeletingResources: "deletingResources",

  /** The deployment stack completed successfully */
  Succeeded: "succeeded",

  /** The deployment stack has failed */
  Failed: "failed",

  /** The deployment stack has been cancelled */
  Canceled: "canceled",

  /** The deployment stack is being deleted */
  Deleting: "deleting",

  /** The deployment stack is currently being initialized */
  @added(Versions.v2025_07_01)
  Initializing: "initializing",

  /** The deployment stack is currently performing an operation */
  @added(Versions.v2025_07_01)
  Running: "running",
}

/**
 * Current management state of the resource in the deployment stack.
 */
union ResourceStatusMode {
  string,

  /**
   * This resource is managed by the deployment stack.
   */
  Managed: "managed",

  /**
   * Unable to remove the deny assignment on resource.
   */
  RemoveDenyFailed: "removeDenyFailed",

  /**
   * Unable to delete the resource from Azure. The delete will be retried on the next stack deployment, or can be deleted manually.
   */
  DeleteFailed: "deleteFailed",

  /**
   * No management state.
   */
  @removed(Versions.v2024_03_01)
  None: "none",
}

/**
 * denyAssignment settings applied to the resource.
 */
union DenyStatusMode {
  string,

  /**
   * Authorized users are able to read and modify the resources, but cannot delete.
   */
  DenyDelete: "denyDelete",

  /**
   * Resource type does not support denyAssignments.
   */
  NotSupported: "notSupported",

  /**
   * denyAssignments are not supported on resources outside the scope of the deployment stack.
   */
  Inapplicable: "inapplicable",

  /**
   * Authorized users can only read from a resource, but cannot modify or delete it.
   */
  DenyWriteAndDelete: "denyWriteAndDelete",

  /**
   * Deny assignment has been removed by Azure due to a resource management change (management group move, etc.)
   */
  RemovedBySystem: "removedBySystem",

  /**
   * No denyAssignments have been applied.
   */
  None: "none",

  /**
   * The denyAssignment status is unknown.
   */
  @added(Versions.v2025_07_01)
  Unknown: "unknown",
}

/**
 * Parameters to specify the action for removed resources during the delete operation.
 */
model ActionOnUnmanageDeleteParameters {
  /**
   * Flag to indicate delete rather than detach for unmanaged resources.
   */
  @query("unmanageAction.Resources")
  unmanageActionResources?: UnmanageActionResourceMode;

  /**
   * Flag to indicate delete rather than detach for unmanaged resource groups.
   */
  @query("unmanageAction.ResourceGroups")
  unmanageActionResourceGroups?: UnmanageActionResourceGroupMode;

  /**
   * Flag to indicate delete rather than detach for unmanaged management groups.
   */
  @query("unmanageAction.ManagementGroups")
  unmanageActionManagementGroups?: UnmanageActionManagementGroupMode;

  /**
   * Some resources do not support deletion.  This flag will denote how the stack should handle those resources.
   */
  @query("unmanageAction.ResourcesWithoutDeleteSupport")
  @added(Versions.v2025_07_01)
  unmanageActionResourcesWithoutDeleteSupport?: ResourcesWithoutDeleteSupportAction;

  /**
   * Flag to bypass service errors that indicate the stack resource list is not correctly synchronized.
   */
  @added(Versions.v2024_03_01)
  @query("bypassStackOutOfSyncError")
  bypassStackOutOfSyncError?: boolean;
}

/**
 * Deployment stack shared properties.
 */
alias DeploymentStackSharedProperties = {
  /**
   * The template content. You use this element when you want to pass the template syntax directly in the request rather than link to an existing template. It can be a JObject or well-formed JSON string. Use either the templateLink property or the template property, but not both.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Back compat. Template is a complex object"
  @visibility(Lifecycle.Create, Lifecycle.Update)
  template?: Record<unknown>;

  /**
   * The URI of the template. Use either the templateLink property or the template property, but not both.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  templateLink?: DeploymentStacksTemplateLink;

  /**
   * Name and value pairs that define the deployment parameters for the template. Use this element when providing the parameter values directly in the request, rather than linking to an existing parameter file. Use either the parametersLink property or the parameters property, but not both.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Keys of this object are determined by the template"
  parameters?: Record<DeploymentParameter>;

  /**
   * The URI of parameters file. Use this element to link to an existing parameters file. Use either the parametersLink property or the parameters property, but not both.
   */
  parametersLink?: DeploymentStacksParametersLink;

  /**
   * The deployment extension configs. Keys of this object are extension aliases as defined in the deployment template.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The keys of the object are determined by the deployment template."
  @added(Versions.v2025_07_01)
  @visibility(Lifecycle.Create, Lifecycle.Update)
  extensionConfigs?: Record<DeploymentExtensionConfig>;

  /**
   * External input values, used by external tooling for parameter evaluation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The keys of the object link to externalInputDefinitions."
  @added(Versions.v2025_07_01)
  @visibility(Lifecycle.Create, Lifecycle.Update)
  externalInputs?: Record<DeploymentExternalInput>;

  /**
   * External input definitions, used by external tooling to define expected external input values.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The keys of the object are determined by the deployment template."
  @added(Versions.v2025_07_01)
  @visibility(Lifecycle.Create, Lifecycle.Update)
  externalInputDefinitions?: Record<DeploymentExternalInputDefinition>;

  /**
   * Defines the behavior of resources that are no longer managed after the Deployment stack is updated or deleted.
   */
  actionOnUnmanage: ActionOnUnmanage;

  /**
   * The debug setting of the deployment.
   */
  debugSetting?: DeploymentStacksDebugSetting;

  /**
   * The scope at which the initial deployment should be created. If a scope is not specified, it will default to the scope of the deployment stack. Valid scopes are: management group (format: '/providers/Microsoft.Management/managementGroups/{managementGroupId}'), subscription (format: '/subscriptions/{subscriptionId}'), resource group (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}').
   */
  deploymentScope?: string;

  /**
   * Deployment stack description. Max length of 4096 characters.
   */
  @maxLength(4096)
  description?: string;

  /**
   * Defines how resources deployed by the stack are locked.
   */
  denySettings: DenySettings;

  /**
   * State of the deployment stack.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DeploymentStackProvisioningState;

  /**
   * The correlation id of the last Deployment stack upsert or delete operation. It is in GUID format and is used for tracing.
   */
  @added(Versions.v2024_03_01)
  @visibility(Lifecycle.Read)
  @example("01234567-89ab-cdef-0000-000000000000")
  correlationId?: string;

  /**
   * The validation level of the deployment stack
   */
  @added(Versions.v2025_07_01)
  validationLevel?: ValidationLevel;
};

/**
 * Deployment stack properties.
 */
model DeploymentStackProperties {
  ...DeploymentStacksError;
  ...DeploymentStackSharedProperties;

  /**
   * Flag to bypass service errors that indicate the stack resource list is not correctly synchronized.
   */
  @added(Versions.v2024_03_01)
  @visibility(Lifecycle.Create, Lifecycle.Update)
  bypassStackOutOfSyncError?: boolean;

  /**
   * An array of resources that were detached during the most recent Deployment stack update. Detached means that the resource was removed from the template, but no relevant deletion operations were specified. So, the resource still exists while no longer being associated with the stack.
   */
  @visibility(Lifecycle.Read)
  detachedResources?: ResourceReference[];

  /**
   * An array of resources that were deleted during the most recent Deployment stack update. Deleted means that the resource was removed from the template and relevant deletion operations were specified.
   */
  @visibility(Lifecycle.Read)
  deletedResources?: ResourceReference[];

  /**
   * An array of resources that failed to reach goal state during the most recent update. Each resourceId is accompanied by an error message.
   */
  @visibility(Lifecycle.Read)
  failedResources?: ResourceReferenceExtended[];

  /**
   * An array of resources currently managed by the deployment stack.
   */
  @visibility(Lifecycle.Read)
  resources?: ManagedResourceReference[];

  /**
   * The extensions used during deployment. Contains extension data for all extensible resources managed by the stack.
   */
  @added(Versions.v2025_07_01)
  @visibility(Lifecycle.Read)
  deploymentExtensions?: DeploymentExtension[];

  /**
   * The resourceId of the deployment resource created by the deployment stack.
   */
  @visibility(Lifecycle.Read)
  deploymentId?: string;

  /**
   * The outputs of the deployment resource created by the deployment stack.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Keys of this object are determined by the template"
  @visibility(Lifecycle.Read)
  outputs?: Record<unknown>;

  /**
   * The duration of the last successful Deployment stack update.
   */
  @visibility(Lifecycle.Read)
  duration?: string;
}

/**
 * Entity representing the reference to the template.
 */
model DeploymentStacksTemplateLink {
  /**
   * The URI of the template to deploy. Use either the uri or id property, but not both.
   */
  uri?: string;

  /**
   * The resourceId of a Template Spec. Use either the id or uri property, but not both.
   */
  id?: string;

  /**
   * The relativePath property can be used to deploy a linked template at a location relative to the parent. If the parent template was linked with a TemplateSpec, this will reference an artifact in the TemplateSpec.  If the parent was linked with a URI, the child deployment will be a combination of the parent and relativePath URIs.
   */
  relativePath?: string;

  /**
   * The query string (for example, a SAS token) to be used with the templateLink URI.
   */
  queryString?: string;

  /**
   * If included, must match the ContentVersion in the template.
   */
  contentVersion?: string;
}

/**
 * Deployment parameter for the template.
 */
model DeploymentParameter {
  /**
   * Input value to the parameter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Value type is determined by the template. Discriminated model not made for back compat."
  value?: unknown;

  /**
   * Type of the value.
   */
  type?: string;

  /**
   * Azure Key Vault parameter reference.
   */
  reference?: KeyVaultParameterReference;

  /**
   * Input expression to the parameter.
   */
  @added(Versions.v2025_07_01)
  @visibility(Lifecycle.Create, Lifecycle.Update)
  expression?: string;
}

/**
 * Azure Key Vault parameter reference.
 */
model KeyVaultParameterReference {
  /**
   * Azure Key Vault reference.
   */
  keyVault: KeyVaultReference;

  /**
   * Azure Key Vault secret name.
   */
  secretName: string;

  /**
   * Azure Key Vault secret version.
   */
  secretVersion?: string;
}

/**
 * Azure Key Vault reference.
 */
model KeyVaultReference {
  /**
   * Azure Key Vault resourceId.
   */
  id: string;
}

/**
 * Entity representing the reference to the deployment parameters.
 */
model DeploymentStacksParametersLink {
  /**
   * The URI of the parameters file.
   */
  uri: string;

  /**
   * If included, must match the ContentVersion in the template.
   */
  contentVersion?: string;
}

/**
 * Deployment external input for parameterization.
 */
@added(Versions.v2025_07_01)
model DeploymentExternalInput {
  /**
   * External input value.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Value type is determined by the user."
  value: unknown;
}

/**
 * Deployment external input definition for parameterization.
 */
@added(Versions.v2025_07_01)
model DeploymentExternalInputDefinition {
  /**
   * The kind of external input.
   */
  kind: string;

  /**
   * Configuration for the external input.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Value type is determined by the user."
  config?: unknown;
}

/**
 * Defines the behavior of resources that are no longer managed after the stack is updated or deleted.
 */
model ActionOnUnmanage {
  /**
   * Specifies an action for a newly unmanaged resource.
   */
  resources: UnmanageActionResourceMode;

  /**
   * Specifies an action for a newly unmanaged resource group.
   */
  resourceGroups?: UnmanageActionResourceGroupMode;

  /**
   * Specifies an action for a newly unmanaged management group.
   */
  managementGroups?: UnmanageActionManagementGroupMode;
  
  /**
   * Some resources do not support deletion.  This flag will denote how the stack should handle those resources.
   */
  @added(Versions.v2025_07_01)
  resourcesWithoutDeleteSupport?: ResourcesWithoutDeleteSupportAction;
}

/**
 * The debug setting.
 */
model DeploymentStacksDebugSetting {
  /**
   * Specifies the type of information to log for debugging. The permitted values are none, requestContent, responseContent, or both requestContent and responseContent separated by a comma. The default is none. When setting this value, carefully consider the type of information that is being passed in during deployment. By logging information about the request or response, sensitive data that is retrieved through the deployment operations could potentially be exposed.
   */
  detailLevel?: string;
}

/**
 * Defines how resources deployed by the Deployment stack are locked.
 */
model DenySettings {
  /**
   * denySettings Mode that defines denied actions.
   */
  mode: DenySettingsMode;

  /**
   * List of AAD principal IDs excluded from the lock. Up to 5 principals are permitted.
   */
  excludedPrincipals?: string[];

  /**
   * List of role-based management operations that are excluded from the denySettings. Up to 200 actions are permitted. If the denySetting mode is set to 'denyWriteAndDelete', then the following actions are automatically appended to 'excludedActions': '*\/read' and 'Microsoft.Authorization/locks/delete'. If the denySetting mode is set to 'denyDelete', then the following actions are automatically appended to 'excludedActions': 'Microsoft.Authorization/locks/delete'. Duplicate actions will be removed.
   */
  excludedActions?: string[];

  /**
   * DenySettings will be applied to child resource scopes of every managed resource with a deny assignment.
   */
  applyToChildScopes?: boolean;
}

/**
 * The resourceId model.
 */
model ResourceReference {
  /**
   * The ARM Resource ID of a resource managed by the deployment stack.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The extension the resource was deployed with.
   */
  @added(Versions.v2025_07_01)
  @visibility(Lifecycle.Read)
  extension?: DeploymentExtension;

  /**
   * The resource type.
   */
  @added(Versions.v2025_07_01)
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The extensible resource identifiers.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The schema of this object is determined by the deployment extension."
  @added(Versions.v2025_07_01)
  @visibility(Lifecycle.Read)
  identifiers?: Record<unknown>;

  /**
   * The API version the resource was deployed with
   */
  @added(Versions.v2025_07_01)
  @visibility(Lifecycle.Read)
  apiVersion?: string;
}

/**
 * The resourceId extended model. This is used to document failed resources with a resourceId and a corresponding error.
 */
model ResourceReferenceExtended {
  ...ResourceReference;
  ...DeploymentStacksError;
}

/**
 * Deployment Stacks error response.
 */
alias DeploymentStacksError = {
  /**
   * The error detail.
   */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
};

/**
 * The managed resource model.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ManagedResourceReference extends ResourceReference {
  /**
   * Current management state of the resource in the deployment stack.
   */
  @added(Versions.v2024_03_01)
  status?: ResourceStatusMode;

  /**
   * denyAssignment settings applied to the resource.
   */
  denyStatus?: DenyStatusMode = DenyStatusMode.None;

  /**
   * Current management state of the resource in the deployment stack.
   */
  @renamedFrom(Versions.v2024_03_01, "status")
  @removed(Versions.v2024_03_01)
  deprecatedStatus?: ResourceStatusMode = ResourceStatusMode.None; // "None" was removed in 2024-03-01 but it was the default in swagger so this field is needed to represent that.
}

/**
 * Common properties for all Azure resources.
 */
model AzureResourceBase {
  /**
   * String Id used to locate any resource on Azure.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of this resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Type of this resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Export Template specific properties of the Deployment stack.
 */
model DeploymentStackTemplateDefinition {
  /**
   * The template content. Use this element to pass the template syntax directly in the request rather than link to an existing template. It can be a JObject or well-formed JSON string. Use either the templateLink property or the template property, but not both.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Back compat. Template is a complex object"
  template?: Record<unknown>;

  /**
   * The URI of the template. Use either the templateLink property or the template property, but not both.
   */
  templateLink?: DeploymentStacksTemplateLink;
}

/**
 * The value or how to get a value for an extension config property.
 */
@added(Versions.v2025_07_01)
model DeploymentExtensionConfigItem {
  /**
   * The type of the value.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The value of the config item. The type is determined by the extension config schema.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "The expected type is determined by the extension config schema."
  value?: unknown;

  /**
   * The key vault reference of the config item.
   */
  keyVaultReference?: KeyVaultParameterReference;
}

/**
 * The configuration of a deployment extension. The keys of this object should align with the extension config schema.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Keys are dynamic and based on the deployment extension config schema."
@added(Versions.v2025_07_01)
model DeploymentExtensionConfig is Record<DeploymentExtensionConfigItem>;

/**
 * Details about the usage of a deployment extension.
 */
@added(Versions.v2025_07_01)
model DeploymentExtension {
  /**
   * The extension name.
   */
  name: string;

  /**
   * The extension version.
   */
  version: string;

  /**
   * The configuration ID of the extension usage. It uniquely identifies a target the extension deploys to.
   */
  configId?: string;

  /**
   * The configuration used for deployment. The keys of this object should align with the extension config schema.
   */
  config?: DeploymentExtensionConfig;
}

/**
 * The level of validation performed on the deployment.
 */
@added(Versions.v2025_07_01)
union ValidationLevel {
  string,

  /** Static analysis of the template is performed. */
  Template: "Template",

  /** Static analysis of the template is performed and resource declarations are sent to resource providers for semantic validation. Validates that the caller has RBAC write permissions on each resource. */
  Provider: "Provider",

  /** Static analysis of the template is performed and resource declarations are sent to resource providers for semantic validation. Skips validating that the caller has RBAC write permissions on each resource. */
  ProviderNoRbac: "ProviderNoRbac",
}

/**
 * The Deployment stack validation result.
 */
@added(Versions.v2024_03_01)
model DeploymentStackValidateResult {
  ...AzureResourceBase;
  ...DeploymentStacksError;

  /**
   * The validation result details.
   */
  properties?: DeploymentStackValidateProperties;
}

/**
 * The Deployment stack validation result details.
 */
@added(Versions.v2024_03_01)
model DeploymentStackValidateProperties {
  /**
   * Defines the behavior of resources that are no longer managed after the Deployment stack is updated or deleted.
   */
  actionOnUnmanage?: ActionOnUnmanage;

  /**
   * The correlation id of the Deployment stack validate operation. It is in GUID format and is used for tracing.
   */
  correlationId?: string;

  /**
   * The Deployment stack deny settings.
   */
  denySettings?: DenySettings;

  /**
   * The Deployment stack deployment scope.
   */
  deploymentScope?: string;

  /**
   * The Deployment stack validation description.
   */
  description?: string;

  /**
   * Deployment parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Keys of the object are determined by the deployment template."
  parameters?: Record<DeploymentParameter>;

  /**
   * The URI of the template.
   */
  templateLink?: DeploymentStacksTemplateLink;

  /**
   * The array of resources that were validated.
   */
  validatedResources?: ResourceReference[];

  /**
   * The deployment extensions.
   */
  @added(Versions.v2025_07_01)
  deploymentExtensions?: DeploymentExtension[];

  /**
   * The validation level of the deployment stack
   */
  @added(Versions.v2025_07_01)
  validationLevel?: ValidationLevel;
}
