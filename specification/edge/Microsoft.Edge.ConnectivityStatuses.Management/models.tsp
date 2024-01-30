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
enum ConnectivityStatusEnum {
  /**
   * The device is in Connected state
   */
  Connected,

  /**
   * The device was NotRecentlyConnected
   */
  NotRecentlyConnected,

  /**
   * The device NeedsAttention
   */
  NeedsAttention,
}

/**
 * The Status
 */
enum ConnectivityStatusEnumForUpdate {
  /**
   * The device is in Connected state
   */
  Connected,

  /**
   * The device was NotRecentlyConnected
   */
  NotRecentlyConnected,

  /**
   * The device NeedsAttention
   */
  NeedsAttention,
}

/**
 * ConnectivityStatus properties
 */
model ConnectivityStatusProperties {
  /**
   * The Status
   */
  status?: ConnectivityStatusEnum;

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
 * The type used for update operations of the ConnectivityStatus.
 */
model ConnectivityStatusUpdate {
  /**
   * The updatable properties of the ConnectivityStatus.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ConnectivityStatusUpdateProperties;
}

/**
 * The updatable properties of the ConnectivityStatus.
 */
model ConnectivityStatusUpdateProperties {
  /**
   * The Status
   */
  status?: ConnectivityStatusEnumForUpdate;
}
