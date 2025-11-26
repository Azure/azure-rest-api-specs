import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;

namespace Microsoft.Resources.DeploymentStacks;

/** Deployment stack object. */
@added(Versions.v2025_07_01)
model DeploymentStacksWhatIfResult
  is Azure.ResourceManager.ProxyResource<DeploymentStacksWhatIfResultProperties> {
  ...DeploymentStacksWhatIfResultNameParameter;

  /** The geo-location where the resource lives. Required for subscription and management group scoped stacks. The location is inherited from the resource group for resource group scoped stacks. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Model is shared between resource group, subscription, and management group scope."
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "This is the expected type"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Model is shared between resource group, subscription, and management group scope."
  tags?: Record<string>;
}

alias DeploymentStacksWhatIfResultNameParameter = ResourceNameParameter<
  Resource = DeploymentStacksWhatIfResult,
  KeyName = "deploymentStacksWhatIfResultName",
  SegmentName = "deploymentStacksWhatIfResults",
  NamePattern = "^[-\\w\\._\\(\\)]+$"
>;

@@maxLength(DeploymentStacksWhatIfResult.name, 90);
@@minLength(DeploymentStacksWhatIfResult.name, 1);
@@doc(DeploymentStacksWhatIfResult.name,
  "Name of the deployment stack what-if result."
);

/**
 * DeploymentStack WhatIfResult Properties
 */
@added(Versions.v2025_07_01)
model DeploymentStacksWhatIfResultProperties {
  ...DeploymentStacksError;
  ...DeploymentStackSharedProperties;

  /**
   * The deployment stack id to use as the basis for comparison.
   */
  deploymentStackResourceId: string;

  /**
   * The timestamp for when the deployment stack was last modified. This can be used to determine if the what-if data is still current.
   */
  @visibility(Lifecycle.Read)
  deploymentStackLastModified?: utcDateTime;

  /**
   * The interval to persist the deployment stack what-if result in ISO 8601 format.
   */
  retentionInterval: duration;

  /**
   * All of the changes predicted by the deployment stack what-if operation.
   */
  @visibility(Lifecycle.Read)
  changes?: DeploymentStacksWhatIfChange;

  /**
   * List of resource diagnostics detected by What-If operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Conflict with @azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Raised because of [] vs #[], but [] is invalid"
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  diagnostics?: DeploymentStacksDiagnostic[];
}

/**
 * Changes predicted to the deployment stack as a result of the what-if operation.
 */
@added(Versions.v2025_07_01)
model DeploymentStacksWhatIfChange {
  /**
   * List of resource changes predicted by What-If operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Conflict with @azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @OpenAPI.extension("x-ms-identifiers", #["identifiers", "resourceId"])
  resourceChanges: DeploymentStacksWhatIfResourceChange[];

  /**
   * Predicted changes to the deployment stack deny settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Conflict with @azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Raised because of [] vs #[], but [] is invalid"
  @OpenAPI.extension("x-ms-identifiers", #[])
  denySettingsChange: DeploymentStacksChangeDelta<DenySettings>;

  /**
   * Predicted changes to the deployment scope for the deployment stack.
   */
  deploymentScopeChange?: DeploymentStacksChangeBase<string>;
}

/**
 * Information about a single resource change predicted by What-If operation.
 */
@added(Versions.v2025_07_01)
model DeploymentStacksWhatIfResourceChange {
  ...ResourceReference;

  /**
   * The resource id of the Deployment responsible for this change.
   */
  deploymentId?: string;

  /**
   * The symbolic name of the resource being changed.
   */
  symbolicName?: string;

  /**
   * Type of change that will be made to the resource when the deployment is executed.
   */
  changeType: DeploymentStacksWhatIfChangeType;

  /**
   * The confidence level of the predicted change.
   */
  changeCertainty: DeploymentStacksWhatIfChangeCertainty;

  /**
   * The predicted changes to the deployment stack management status of the resource.
   */
  managementStatusChange?: DeploymentStacksChangeBase<DeploymentStacksManagementStatus>;

  /**
   * The predicted changes to the deployment stack deny status of the resource.
   */
  denyStatusChange?: DeploymentStacksChangeBase<DenyStatusMode>;

  /**
   * The explanation about why the resource is unsupported by What-If.
   */
  unsupportedReason?: string;

  /**
   * The predicted changes to the resource configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Conflict with @azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Raised because of [] vs #[], but [] is invalid"
  @OpenAPI.extension("x-ms-identifiers", #[])
  resourceConfigurationChanges?: DeploymentStacksChangeDelta<Record<unknown>>;
}

/**
 * Denotes the confidence level of the predicted change.
 */
@added(Versions.v2025_07_01)
union DeploymentStacksWhatIfChangeCertainty {
  string,

  /**
   * The change is definite.
   */
  Definite: "definite",

  /**
   * The change may or may not happen, based on deployment-time conditions.
   */
  Potential: "potential",
}

/**
 * Base model for properties with the before-and-after property values.
 */
@added(Versions.v2025_07_01)
model DeploymentStacksChangeBase<T> {
  /**
   * The predicted value before the deployment is executed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "This represents a change for an arbitrary property."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Azure resources are too complex to model"
  before?: T;

  /**
   * The predicted value after the deployment is executed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "This represents a change for an arbitrary property."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Azure resources are too complex to model"
  after?: T;
}

/**
 * Model to show the before-and-after property values, along with the delta between them.
 */
@added(Versions.v2025_07_01)
model DeploymentStacksChangeDelta<T> {
  ...DeploymentStacksChangeBase<T>;

  /**
   * The predicted changes to the properties."
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Conflict with @azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Raised because of [] vs #[], but [] is invalid"
  @OpenAPI.extension("x-ms-identifiers", #["path"])
  delta?: DeploymentStacksWhatIfPropertyChange[];
}

/**
 * The predicted change to the resource property.
 */
@added(Versions.v2025_07_01)
model DeploymentStacksWhatIfPropertyChange {
  ...DeploymentStacksChangeBase<unknown>;

  /**
   * Type of change that will be made to the resource when the deployment is executed.
   */
  path: string;

  /**
   * Type of change that will be made to the resource when the deployment is executed.
   */
  changeType: DeploymentStacksWhatIfPropertyChangeType;

  /**
   * Nested property changes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Conflict with @azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Raised because of [] vs #[], but [] is invalid"
  @OpenAPI.extension("x-ms-identifiers", #["path"])
  children?: DeploymentStacksWhatIfPropertyChange[];
}

/**
 * The error additional info
 */
@added(Versions.v2025_07_01)
model DeploymentStacksDiagnostic {
  /**
   * Denotes the additional response level.
   */
  level: DeploymentStacksDiagnosticLevel;

  /**
   * The error code.
   */
  code: string;

  /**
   * The error message.
   */
  message: string;

  /**
   * The error target.
   */
  target?: string;

  /**
   * Additional error information.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Conflict with @azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @OpenAPI.extension("x-ms-identifiers", #[])
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * The management status of the deployment stack resource.
 */
@added(Versions.v2025_07_01)
union DeploymentStacksManagementStatus {
  string,

  /**
   * The resource is managed by the deployment stack.
   */
  Managed: "managed",

  /**
   * The resource is not managed by the deployment stack.
   */
  Unmanaged: "unmanaged",

  /**
   * The management state of the resource could not be determined.
   */
  Unknown: "unknown",
}

/**
 * Type of change that will be made to the resource when the deployment is executed.
 */
@added(Versions.v2025_07_01)
union DeploymentStacksWhatIfChangeType {
  string,

  /**
   * The resource does not exist in the current state but is present in the desired state. The resource will be created when the deployment is executed.
   */
  Create: "create",

  /**
   * The resource exists in the current state and is missing from the desired state. The resource will be deleted from Azure after the deployment is executed.
   */
  Delete: "delete",

  /**
   * The resource exists in the current state and is missing from the desired state. The resource will be removed from the deployment stack, but will remain in Azure, after the deployment is executed.
   *
   */
  Detach: "detach",

  /**
   * The resource exists in the current state and the desired state and will be redeployed when the deployment is executed. The properties of the resource will change.
   */
  Modify: "modify",

  /**
   * 	The resource exists in the current state and the desired state and will be redeployed when the deployment is executed. The properties of the resource will not change.
   */
  NoChange: "noChange",

  /**
   * The resource is not supported by What-If.
   */
  Unsupported: "unsupported",
}

/**
 * The type of property change.
 */
@added(Versions.v2025_07_01)
union DeploymentStacksWhatIfPropertyChangeType {
  string,

  /**
   * 	The property is an array and contains nested changes.
   */
  Array: "array",

  /**
   * The property does not exist in the current state but is present in the desired state. The property will be created when the deployment is executed.
   */
  Create: "create",

  /**
   * The property exists in the current state and is missing from the desired state. It will be deleted when the deployment is executed.
   */
  Delete: "delete",

  /**
   * The property exists in both current and desired state and is different. The value of the property will change when the deployment is executed.
   */
  Modify: "modify",

  /**
   * The property will not be set or updated.
   */
  NoEffect: "noEffect",
}

/**
 * Denotes the additional response level.
 */
@added(Versions.v2025_07_01)
union DeploymentStacksDiagnosticLevel {
  string,

  /**
   * Informational message.
   */
  Info: "info",

  /**
   * Warning message.
   */
  Warning: "warning",

  /**
   * Error message.
   */
  Error: "error",
}
