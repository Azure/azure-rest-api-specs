import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.Edge;

/**
 * The Status
 */
union ConnectivityStatusEnum {
  string,

  /**
   * The device is in Connected state
   */
  Connected: "Connected",

  /**
   * The device was NotRecentlyConnected
   */
  NotRecentlyConnected: "NotRecentlyConnected",

  /**
   * The device NeedsAttention
   */
  NeedsAttention: "NeedsAttention",
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
 * The type used for update operations of the ConnectivityStatus.
 */
model ConnectivityStatusUpdate {
  /**
   * The updatable properties of the ConnectivityStatus.
   */
  properties?: ConnectivityStatusUpdateProperties;
}

/**
 * The updatable properties of the ConnectivityStatus.
 */
model ConnectivityStatusUpdateProperties {
  /**
   * The Status
   */
  status?: ConnectivityStatusEnum;
}

/**
 * The ProvisioningState
 */
union ProvisioningState {
  string,
  ResourceProvisioningState,
}
