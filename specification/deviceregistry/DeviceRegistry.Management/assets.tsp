import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/topic.tsp";
import "./common/assetProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@removed(Versions.v2024_10_01_preview)
@added(Versions.v2025_07_01_preview)
@doc("Asset definition.")
model Asset is TrackedResource<AssetProperties> {
  @doc("The name of the asset.")
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

alias AssetPropertiesUpdate = {
  ...OptionalProperties<UpdateableProperties<OmitProperties<
    AssetProperties,
    "defaultTopic"
  >>>;

  @added(Versions.v2024_07_01_preview)
  @removed(Versions.v2024_10_01_preview)
  @added(Versions.v2025_07_01_preview)
  @doc("Object that describes the default topic information for the asset.")
  defaultTopic?: OptionalProperties<OmitDefaults<Topic>>;
};

@removed(Versions.v2024_10_01_preview)
@added(Versions.v2025_07_01_preview)
@armResourceOperations
interface Assets {
  get is ArmResourceRead<Asset>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<Asset>;
  // Using 'ArmCustomPatchAsync' instead of 'ArmResourcePatchAsync' to define the correct patch payload for the resource.
  // This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
  // since otherwise it extends the ARM TrackedResource type.
  update is ArmCustomPatchAsync<
    Asset,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Asset,
      AssetPropertiesUpdate
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Asset>;
  listByResourceGroup is ArmResourceListByParent<Asset>;
  listBySubscription is ArmListBySubscription<Asset>;
}
