import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/topic.tsp";
import "./common/assetPropertiesUpdate.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2024_10_01_preview)
@parentResource(Namespace)
@doc("Namespace Assets Azure resource.")
model NamespaceAsset is TrackedResource<AssetProperties> {
  @doc("Asset name parameter.")
  @key("assetName")
  @segment("assets")
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

@added(Versions.v2024_10_01_preview)
@armResourceOperations
interface NamespaceAssets {
  get is ArmResourceRead<NamespaceAsset>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<NamespaceAsset>;
  update is ArmCustomPatchAsync<
    NamespaceAsset,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      NamespaceAsset,
      AssetPropertiesUpdate
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NamespaceAsset>;
  listByResourceGroup is ArmResourceListByParent<NamespaceAsset>;
  listBySubscription is ArmListBySubscription<NamespaceAsset>;
}
