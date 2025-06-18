import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Resources;

/**
 * Specifies an action for a newly unmanaged resource. Delete will attempt to delete the resource from Azure. Detach will leave the resource in it's current state.
 */
union DeploymentStacksDeleteDetachEnum {
  string,
  /** Delete the specified resources from Azure */
  delete: "delete",
  /** Keep the specified resources in Azure */
  detach: "detach",
}

/**
 * denySettings Mode that defines denied actions.
 */
union DenySettingsMode {
  string,

  /**
   * Authorized users are able to read and modify the resources, but cannot delete.
   */
  denyDelete: "denyDelete",

  /**
   * Authorized users can read from a resource, but cannot modify or delete it.
   */
  denyWriteAndDelete: "denyWriteAndDelete",

  /**
   * No denyAssignments have been applied.
   */
  none: "none",
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
}

/**
 * Current management state of the resource in the deployment stack.
 */
union ResourceStatusMode {
  string,

  /**
   * This resource is managed by the deployment stack.
   */
  managed: "managed",

  /**
   * Unable to remove the deny assignment on resource.
   */
  removeDenyFailed: "removeDenyFailed",

  /**
   * Unable to delete the resource from Azure. The delete will be retried on the next stack deployment, or can be deleted manually.
   */
  deleteFailed: "deleteFailed",
}

/**
 * denyAssignment settings applied to the resource.
 */
union DenyStatusMode {
  string,

  /**
   * Authorized users are able to read and modify the resources, but cannot delete.
   */
  denyDelete: "denyDelete",

  /**
   * Resource type does not support denyAssignments.
   */
  notSupported: "notSupported",

  /**
   * denyAssignments are not supported on resources outside the scope of the deployment stack.
   */
  inapplicable: "inapplicable",

  /**
   * Authorized users can only read from a resource, but cannot modify or delete it.
   */
  denyWriteAndDelete: "denyWriteAndDelete",

  /**
   * Deny assignment has been removed by Azure due to a resource management change (management group move, etc.)
   */
  removedBySystem: "removedBySystem",

  /**
   * No denyAssignments have been applied.
   */
  none: "none",
}

/**
 * Parameters to specify the action for removed resources during the delete operation.
 */
model ActionOnUnmanageDeleteParameters {
  /**
   * Flag to indicate delete rather than detach for unmanaged resources.
   */
  @query("unmanageAction.Resources")
  unmanageActionResources?: DeploymentStacksDeleteDetachEnum;

  /**
   * Flag to indicate delete rather than detach for unmanaged resource groups.
   */
  @query("unmanageAction.ResourceGroups")
  unmanageActionResourceGroups?: DeploymentStacksDeleteDetachEnum;

  /**
   * Flag to indicate delete rather than detach for unmanaged management groups.
   */
  @query("unmanageAction.ManagementGroups")
  unmanageActionManagementGroups?: DeploymentStacksDeleteDetachEnum;

  /**
   * Flag to bypass service errors that indicate the stack resource list is not correctly synchronized.
   */
  @query("bypassStackOutOfSyncError")
  bypassStackOutOfSyncError?: boolean;
}

/**
 * Deployment stack properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DeploymentStackProperties extends DeploymentStacksError {
  /**
   * The template content. You use this element when you want to pass the template syntax directly in the request rather than link to an existing template. It can be a JObject or well-formed JSON string. Use either the templateLink property or the template property, but not both.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<DeploymentParameter>;

  /**
   * The URI of parameters file. Use this element to link to an existing parameters file. Use either the parametersLink property or the parameters property, but not both.
   */
  parametersLink?: DeploymentStacksParametersLink;

  /**
   * Defines the behavior of resources that are no longer managed after the Deployment stack is updated or deleted.
   */
  actionOnUnmanage: ActionOnUnmanage;

  /**
   * The debug setting of the deployment.
   */
  debugSetting?: DeploymentStacksDebugSetting;

  /**
   * Flag to bypass service errors that indicate the stack resource list is not correctly synchronized.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  bypassStackOutOfSyncError?: boolean;

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
  @visibility(Lifecycle.Read)
  correlationId?: string;

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
   * The resourceId of the deployment resource created by the deployment stack.
   */
  @visibility(Lifecycle.Read)
  deploymentId?: string;

  /**
   * The outputs of the deployment resource created by the deployment stack.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  value?: unknown;

  /**
   * Type of the value.
   */
  type?: string;

  /**
   * Azure Key Vault parameter reference.
   */
  reference?: KeyVaultParameterReference;
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
 * Defines the behavior of resources that are no longer managed after the stack is updated or deleted.
 */
model ActionOnUnmanage {
  /**
   * Specifies an action for a newly unmanaged resource. Delete will attempt to delete the resource from Azure. Detach will leave the resource in it's current state.
   */
  resources: DeploymentStacksDeleteDetachEnum;

  /**
   * Specifies an action for a newly unmanaged resource. Delete will attempt to delete the resource from Azure. Detach will leave the resource in it's current state.
   */
  resourceGroups?: DeploymentStacksDeleteDetachEnum;

  /**
   * Specifies an action for a newly unmanaged resource. Delete will attempt to delete the resource from Azure. Detach will leave the resource in it's current state.
   */
  managementGroups?: DeploymentStacksDeleteDetachEnum;
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
   * The resourceId of a resource managed by the deployment stack.
   */
  @visibility(Lifecycle.Read)
  id?: string;
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
@error
model DeploymentStacksError {
  /**
   * The error detail.
   */
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

/**
 * The managed resource model.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ManagedResourceReference extends ResourceReference {
  /**
   * Current management state of the resource in the deployment stack.
   */
  status?: ResourceStatusMode;

  /**
   * denyAssignment settings applied to the resource.
   */
  denyStatus?: DenyStatusMode = DenyStatusMode.none;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  template?: Record<unknown>;

  /**
   * The URI of the template. Use either the templateLink property or the template property, but not both.
   */
  templateLink?: DeploymentStacksTemplateLink;
}

/**
 * The Deployment stack validation result.
 */
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<DeploymentParameter>;

  /**
   * The URI of the template.
   */
  templateLink?: DeploymentStacksTemplateLink;

  /**
   * The array of resources that were validated.
   */
  validatedResources?: ResourceReference[];
}
