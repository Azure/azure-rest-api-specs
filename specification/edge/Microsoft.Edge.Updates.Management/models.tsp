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
union UpdateStatus {
  string,

  /**
   * The device is in Unknown state
   */
  Unknown: "Unknown",

  /**
   * The device is in UpdateAvailable state
   */
  UpdateAvailable: "UpdateAvailable",

  /**
   * The device is in UptoDate state
   */
  UptoDate: "UptoDate",

  /**
   * The device is in UpdateInProgress state
   */
  UpdateInProgress: "UpdateInProgress",

  /**
   * The device is in NeedsAttention state
   */
  NeedsAttention: "NeedsAttention",
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
  status?: UpdateStatus;
}

/**
 * The ProvisioningState
 */
union ProvisioningState {
  string,
  ResourceProvisioningState,
}
