import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Network Tap resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(NetworkTapProperties)
model NetworkTap extends TrackedResourceBase {
  /**
   * Name of the Network Tap.
   */
  @path
  @key("networkTapName")
  @segment("networkTaps")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
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
  create is ArmResourceCreateOrReplaceAsync<
    NetworkTap,
    BaseParameters<NetworkTap>,
    ArmAsyncOperationHeader
  >;

  /**
   * API to update certain properties of the Network Tap resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    NetworkTap,
    NetworkTapPatch,
    BaseParameters<NetworkTap>,
    ArmLroLocationHeader
  >;

  /**
   * Deletes Network Tap.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkTap,
    BaseParameters<NetworkTap>,
    ArmLroLocationHeader
  >;

  /**
   * Displays Network Taps list by resource group GET method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkTaps_ListByResourceGroup")
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
    CommonPostActionResponseForDeviceUpdate,
    BaseParameters<NetworkTap>,
    ArmLroLocationHeader
  >;

  /**
   * Implements the operation to the underlying resources.
   */
  resync is ArmResourceActionAsync<
    NetworkTap,
    void,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkTap>,
    ArmLroLocationHeader
  >;
}

@@projectedName(NetworkTaps.create::parameters.resource, "json", "body");
@@extension(NetworkTaps.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkTaps.create::parameters.resource, "Request payload.");
@@projectedName(NetworkTaps.update::parameters.properties, "json", "body");
@@extension(NetworkTaps.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkTaps.update::parameters.properties,
  "Network Tap properties to update."
);
@@doc(NetworkTaps.updateAdministrativeState::parameters.body,
  "Request payload."
);
