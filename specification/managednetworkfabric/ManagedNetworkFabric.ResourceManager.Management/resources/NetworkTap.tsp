import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Network Tap resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@includeInapplicableMetadataInPayload(false)
model NetworkTap extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Name of the Network Tap.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkTapName")
  @segment("networkTaps")
  @visibility("read")
  name: string;

  /** The NetworkTap Properties */
  properties: NetworkTapProperties;
}

@armResourceOperations
interface NetworkTaps {
  /**
   * Retrieves details of this Network Tap.
   */
  get is ArmResourceRead<NetworkTap>;

  /**
   * Creates a Network Tap.
   */
  create is ArmResourceCreateOrReplaceAsync<NetworkTap>;

  /**
   * API to update certain properties of the Network Tap resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<NetworkTap, NetworkTapPatch>;

  /**
   * Deletes Network Tap.
   */
  delete is ArmResourceDeleteWithoutOkAsync<NetworkTap>;

  /**
   * Displays Network Taps list by resource group GET method.
   */
  listByResourceGroup is ArmResourceListByParent<NetworkTap>;

  /**
   * Displays Network Taps list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<NetworkTap>;

  /**
   * Implements the operation to the underlying resources.
   */
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkTap,
    UpdateAdministrativeState,
    CommonPostActionResponseForDeviceUpdate
  >;

  /**
   * Implements the operation to the underlying resources.
   */
  resync is ArmResourceActionAsync<
    NetworkTap,
    void,
    CommonPostActionResponseForStateUpdate
  >;
}

@@doc(NetworkTaps.create::parameters.resource, "Request payload.");
@@doc(NetworkTaps.update::parameters.properties,
  "Network Tap properties to update."
);
@@doc(NetworkTaps.updateAdministrativeState::parameters.body,
  "Request payload."
);
