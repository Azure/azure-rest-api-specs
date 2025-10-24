import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;

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
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

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
