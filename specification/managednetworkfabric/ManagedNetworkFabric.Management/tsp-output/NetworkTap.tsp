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
@doc("The Network Tap resource definition.")
model NetworkTap is TrackedResource<NetworkTapProperties> {
  @doc("Name of the Network Tap.")
  @path
  @key("networkTapName")
  @segment("networkTaps")
  name: string;
}

@armResourceOperations
interface NetworkTaps {
  @doc("Retrieves details of this Network Tap.")
  get is ArmResourceRead<NetworkTap>;

  @doc("Creates a Network Tap.")
  create is ArmResourceCreateOrUpdateAsync<
    NetworkTap,
    BaseParameters<NetworkTap>,
    ArmAsyncOperationHeader
  >;

  @doc("API to update certain properties of the Network Tap resource.")
  update is ArmCustomPatchAsync<
    NetworkTap,
    NetworkTapPatch,
    BaseParameters<NetworkTap>,
    ArmLroLocationHeader
  >;

  @doc("Deletes Network Tap.")
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkTap,
    BaseParameters<NetworkTap>,
    ArmLroLocationHeader
  >;

  @doc("Displays Network Taps list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<NetworkTap>;

  @doc("Displays Network Taps list by subscription GET method.")
  listBySubscription is ArmListBySubscription<NetworkTap>;

  @doc("Implements the operation to the underlying resources.")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkTap,
    UpdateAdministrativeState,
    CommonPostActionResponseForDeviceUpdate,
    BaseParameters<NetworkTap>,
    ArmLroLocationHeader
  >;

  @doc("Implements the operation to the underlying resources.")
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
