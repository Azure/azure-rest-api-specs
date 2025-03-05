import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/topic.tsp";
import "./common/discoveredAssetsProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.DeviceRegistry;

@doc("Namespace Discovered Asset definition.")
@parentResource(Namespace)
@added(Versions.v2024_10_01_preview)
model NamespaceDiscoveredAsset is TrackedResource<DiscoveredAssetProperties> {
  @doc("Discovered Asset name parameter.")
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

alias DiscoveredAssetPropertiesUpdate = {
  ...OptionalProperties<UpdateableProperties<OmitProperties<
    DiscoveredAssetProperties,
    "defaultTopic"
  >>>;

  @added(Versions.v2024_10_01_preview)
  @doc("Object that describes the default topic information for the discovered asset.")
  defaultTopic?: OptionalProperties<OmitDefaults<Topic>>;
};

@armResourceOperations
@added(Versions.v2024_10_01_preview)
interface NamespaceDiscoveredAssets {
  get is ArmResourceRead<NamespaceDiscoveredAsset>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<NamespaceDiscoveredAsset>;
  update is ArmCustomPatchAsync<
    NamespaceDiscoveredAsset,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      NamespaceDiscoveredAsset,
      DiscoveredAssetPropertiesUpdate
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NamespaceDiscoveredAsset>;
  listByResourceGroup is ArmResourceListByParent<NamespaceDiscoveredAsset>;
  listBySubscription is ArmListBySubscription<NamespaceDiscoveredAsset>;
}
