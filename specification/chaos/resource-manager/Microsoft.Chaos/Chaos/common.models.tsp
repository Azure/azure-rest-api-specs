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
