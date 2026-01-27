import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/topic.tsp";
import "./properties/discoveredAssetsProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@doc("Discovered Asset definition.")
@added(Versions.v2024_07_01_preview)
@removed(Versions.v2024_10_01_preview)
model DiscoveredAsset is TrackedResource<DiscoveredAssetProperties> {
  @doc("The name of the discovered asset.")
  @key("discoveredAssetName")
  @segment("discoveredAssets")
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
@added(Versions.v2024_07_01_preview)
@removed(Versions.v2024_10_01_preview)
interface DiscoveredAssets {
  get is ArmResourceRead<DiscoveredAsset>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<DiscoveredAsset>;
  update is ArmResourcePatchAsync<DiscoveredAsset, DiscoveredAssetProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<DiscoveredAsset>;
  listByResourceGroup is ArmResourceListByParent<DiscoveredAsset>;
  listBySubscription is ArmListBySubscription<DiscoveredAsset>;
}
