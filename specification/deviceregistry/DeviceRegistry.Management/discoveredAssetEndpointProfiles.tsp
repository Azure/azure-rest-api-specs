import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/authenticationMethod.tsp";
import "./common/discoveredAssetEndpointProfilesProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@doc("Discovered Asset Endpoint Profile definition.")
@added(Versions.v2024_07_01_preview)
@removed(Versions.v2024_10_01_preview)
model DiscoveredAssetEndpointProfile
  is TrackedResource<DiscoveredAssetEndpointProfileProperties> {
  @doc("Discovered Asset Endpoint Profile name parameter.")
  @key("discoveredAssetEndpointProfileName")
  @segment("discoveredAssetEndpointProfiles")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("The extended location.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
@removed(Versions.v2024_10_01_preview)
@added(Versions.v2024_07_01_preview)
interface DiscoveredAssetEndpointProfiles {
  get is ArmResourceRead<DiscoveredAssetEndpointProfile>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<DiscoveredAssetEndpointProfile>;
  update is ArmResourcePatchAsync<
    DiscoveredAssetEndpointProfile,
    DiscoveredAssetEndpointProfileProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DiscoveredAssetEndpointProfile>;
  listByResourceGroup is ArmResourceListByParent<DiscoveredAssetEndpointProfile>;
  listBySubscription is ArmListBySubscription<DiscoveredAssetEndpointProfile>;
}
