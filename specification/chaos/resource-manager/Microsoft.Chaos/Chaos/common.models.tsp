import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Chaos;

interface Operations extends Azure.ResourceManager.Operations {}
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Required to avoid breaking SDK change"
alias ParentResourceParameters = {
  /**
   * The parent resource provider namespace.
   */
  @path
  @segment("providers")
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  parentProviderNamespace: string;

  /**
   * The parent resource type.
   */
  @path
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  parentResourceType: string;

  /**
   * The parent resource name.
   */
  @path
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  parentResourceName: string;
};

/**
 * Current provisioning state for a given Azure Chaos resource.
 */
union ProvisioningState {
  string,
  ResourceProvisioningState, // include standard provisioning states

  /**
   * Initial creation in progress.
   */
  Creating: "Creating",

  /**
   * Update in progress.
   */
  Updating: "Updating",

  /**
   * Deletion in progress.
   */
  Deleting: "Deleting",

  /**
   * Action is running.
   */
  @removed(Microsoft.Chaos.Versions.v2025_01_01)
  @added(Microsoft.Chaos.Versions.v2026_05_01_preview)
  Running: "Running",
}

/**
 * The status of operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OperationStatus extends ErrorResponse {
  /**
   * The operation Id.
   */
  id?: string;

  /**
   * The operation name.
   */
  name?: string;

  /**
   * The start time of the operation.
   */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /**
   * The end time of the operation.
   */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  /**
   * The status of the operation.
   */
  status?: string;
}

/**
 * A map used to describe parameters for actions or configurations.
 */
model KeyValuePair {
  /**
   * The name of the setting for the action.
   */
  @minLength(1)
  key: string;

  /**
   * The value of the setting for the action.
   */
  @minLength(1)
  value: string;
}

/**
 * Represents a system or infrastructure error encountered during an async operation.
 */
model OperationError {
  /**
   * The error code identifying the type of system error.
   */
  errorCode: string;

  /**
   * A human-readable description of the system error.
   */
  errorMessage: string;
}

/**
 * Model that represents the scenario run errors.
 */
model ScenarioErrors {
  /**
   * Error code for internal server errors.
   */
  errorCode?: string;

  /**
   * Error message for internal server errors.
   */
  errorMessage?: string;

  /**
   * Any permission errors associated with the scenario run.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["resourceId"])
  permission: PermissionError[];

  /**
   * Any resource state errors associated with the scenario run.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["resourceId"])
  resource: ResourceStateError[];
}

/**
 * Model that represents the permission error.
 */
model PermissionError {
  /**
   * The resource id for the affected resource.
   */
  @visibility(Lifecycle.Read)
  resourceId: string;

  /**
   * The missing permissions.
   */
  @visibility(Lifecycle.Read)
  missingPermissions: string[];

  /**
   * The required permissions.
   */
  @visibility(Lifecycle.Read)
  requiredPermissions: string[];

  /**
   * The recommended roles.
   */
  @visibility(Lifecycle.Read)
  recommendedRoles: string[];

  /**
   * The identity.
   */
  @visibility(Lifecycle.Read)
  identity?: EntraIdentity;
}

/**
 * Model that represents the Azure Entra identity.
 */
model EntraIdentity {
  /**
   * The identity object id.
   */
  @visibility(Lifecycle.Read)
  objectId: string;

  /**
   * The identity tenant id.
   */
  @visibility(Lifecycle.Read)
  tenantId: string;
}

/**
 * Model that represents the resource state error.
 */
model ResourceStateError {
  /**
   * The resource id for the affected resource.
   */
  @visibility(Lifecycle.Read)
  resourceId: string;

  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  errorCode: int32;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  errorMessage: string;

  /**
   * The remediation uri.
   */
  @visibility(Lifecycle.Read)
  remediationUri: string;
}
