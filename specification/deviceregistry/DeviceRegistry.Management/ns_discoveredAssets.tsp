import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/topic.tsp";
import "./properties/ns_discoveredAssetsProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@doc("Discovered asset definition.")
@parentResource(Namespace)
@added(Versions.v2025_07_01_preview)
model NamespaceDiscoveredAsset
  is TrackedResource<NamespaceDiscoveredAssetProperties> {
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
@added(Versions.v2025_07_01_preview)
interface NamespaceDiscoveredAssets {
  get is ArmResourceRead<NamespaceDiscoveredAsset>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<NamespaceDiscoveredAsset>;
  // Using 'ArmCustomPatchAsync' instead of 'ArmResourcePatchAsync' to define the correct patch payload for the resource.
  // This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
  // since otherwise it extends the ARM TrackedResource type.
  update is ArmCustomPatchAsync<
    NamespaceDiscoveredAsset,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      NamespaceDiscoveredAsset,
      NamespaceDiscoveredAssetProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NamespaceDiscoveredAsset>;
  listByResourceGroup is ArmResourceListByParent<NamespaceDiscoveredAsset>;
}
