import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/topic.tsp";
import "./properties/ns_discoveredAssetProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@doc("Discovered asset definition.")
@parentResource(Namespace)
@added(Versions.v2024_10_01_preview)
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

alias NamespaceDiscoveredAssetPropertiesUpdate = {
  ...OptionalProperties<UpdateableProperties<OmitProperties<
    NamespaceDiscoveredAssetProperties,
    "defaultTopic"
  >>>;

  @added(Versions.v2024_10_01_preview)
  @removed(Versions.v2025_07_01_preview)
  @doc("Object that describes the default topic information for the discovered asset.")
  defaultTopic?: OptionalProperties<OmitDefaults<Topic>>;
};

@armResourceOperations
@added(Versions.v2024_10_01_preview)
interface NamespaceDiscoveredAssets {
  get is ArmResourceRead<NamespaceDiscoveredAsset>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<NamespaceDiscoveredAsset>;
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    NamespaceDiscoveredAsset,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      NamespaceDiscoveredAsset,
      NamespaceDiscoveredAssetPropertiesUpdate
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NamespaceDiscoveredAsset>;
  listByResourceGroup is ArmResourceListByParent<NamespaceDiscoveredAsset>;
  @removed(Versions.v2025_07_01_preview)
  listBySubscription is ArmListBySubscription<NamespaceDiscoveredAsset>;
}
