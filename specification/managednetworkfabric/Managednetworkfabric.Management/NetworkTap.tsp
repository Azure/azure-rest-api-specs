import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Network Tap resource definition.
 */
model NetworkTap
  is Azure.ResourceManager.TrackedResource<NetworkTapProperties, false> {
  ...ResourceNameParameter<
    Resource = NetworkTap,
    KeyName = "networkTapName",
    SegmentName = "networkTaps",
    NamePattern = ""
  >;
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<NetworkTap, PatchModel = NetworkTapPatch>;

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
    ArmResponse<CommonPostActionResponseForDeviceUpdate>
  >;

  /**
   * Implements the operation to the underlying resources.
   */
  resync is ArmResourceActionAsync<
    NetworkTap,
    void,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;
}

@@doc(NetworkTap.name, "Name of the Network Tap.");
@@doc(NetworkTap.properties, "Resource properties.");
@@doc(NetworkTaps.create::parameters.resource, "Request payload.");
@@doc(NetworkTaps.update::parameters.properties,
  "Network Tap properties to update."
);
@@doc(NetworkTaps.updateAdministrativeState::parameters.body,
  "Request payload."
);
