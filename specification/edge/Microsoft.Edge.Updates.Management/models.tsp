import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Edge;

/**
 * The Status
 */
enum UpdateStatus {
  /**
   * The device is in Unknown state
   */
  Unknown,

  /**
   * The device is in UpdateAvailable state
   */
  UpdateAvailable,

  /**
   * The device is in UptoDate state
   */
  UptoDate,

  /**
   * The device is in UpdateInProgress state
   */
  UpdateInProgress,

  /**
   * The device is in NeedsAttention state
   */
  NeedsAttention,
}

/**
 * Update properties
 */
model UpdateProperties {
  /**
   * The Status
   */
  status?: UpdateStatus;

  /**
   * The status of the last operation.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: ResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The type used for update operations of the Update.
 */
model ModifyUpdate {
  /**
   * The updatable properties of the Update.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ModifyUpdateProperties;
}

/**
 * The updatable properties of the Update.
 */
model ModifyUpdateProperties {
  /**
   * The Status
   */
  status?: string;
}
