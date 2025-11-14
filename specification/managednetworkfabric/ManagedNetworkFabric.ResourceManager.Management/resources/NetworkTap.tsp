import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The Network Tap resource definition.")
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkTap extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the Network Tap.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkTapName")
  @segment("networkTaps")
  @visibility(Lifecycle.Read)
  name: string;

  /** The NetworkTap Properties */
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "properties")
  propertiesDeprecated: NetworkTapProperties;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @doc("The NetworkTap Properties")
  @added(Versions.v2025_07_15)
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties: NetworkTapProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @added(Versions.v2025_07_15)
  @doc("The managed service identities assigned to this resource.")
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;
}

@armResourceOperations
interface NetworkTaps {
  @doc("Retrieves details of this Network Tap.")
  get is ArmResourceRead<NetworkTap>;

  @doc("Creates a Network Tap.")
  create is ArmResourceCreateOrReplaceAsync<NetworkTap>;

  @doc("API to update certain properties of the Network Tap resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<NetworkTap, NetworkTapPatch>;

  @doc("Deletes Network Tap.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkTap>;

  @doc("Displays Network Taps list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<NetworkTap>;

  @doc("Displays Network Taps list by subscription GET method.")
  listBySubscription is ArmListBySubscription<NetworkTap>;

  @doc("Implements the operation to the underlying resources.")
  @action("updateAdministrativeState")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "updateAdministrativeState")
  @sharedRoute
  updateAdministrativeStateDeprecated is ArmResourceActionAsync<
    NetworkTap,
    UpdateAdministrativeState,
    CommonPostActionResponseForDeviceUpdate
  >;

  @doc("Implements the operation to the underlying resources.")
  @action("updateAdministrativeState")
  @added(Versions.v2025_07_15)
  @sharedRoute
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkTap,
    UpdateAdministrativeState,
    UpdateAdministrativeStateResponse
  >;

  @doc("Implements the operation to the underlying resources.")
  @action("resync")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "resync")
  @sharedRoute
  resyncDeprecated is ArmResourceActionAsync<
    NetworkTap,
    void,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Implements the operation to the underlying resources.")
  @action("resync")
  @added(Versions.v2025_07_15)
  @sharedRoute
  resync is ArmResourceActionAsync<NetworkTap, void, NetworkTapResyncResponse>;
}

@@doc(NetworkTaps.create::parameters.resource, "Request payload.");
@@doc(NetworkTaps.update::parameters.properties,
  "Network Tap properties to update."
);
@@doc(NetworkTaps.updateAdministrativeStateDeprecated::parameters.body,
  "Request payload."
);
@@doc(NetworkTaps.updateAdministrativeState::parameters.body,
  "Request payload."
);
