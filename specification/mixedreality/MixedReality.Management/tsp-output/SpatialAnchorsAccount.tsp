import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.MixedReality;
@doc("SpatialAnchorsAccount Response.")
model SpatialAnchorsAccount is TrackedResource<MixedRealityAccountProperties> {
  @doc("Name of an Mixed Reality Account.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @path
  @key("accountName")
  @segment("spatialAnchorsAccounts")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourcePlan;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface SpatialAnchorsAccounts {
  @doc("Retrieve a Spatial Anchors Account.")
  get is ArmResourceRead<SpatialAnchorsAccount>;
  @doc("Creating or Updating a Spatial Anchors Account.")
  create is ArmResourceCreateOrReplaceSync<SpatialAnchorsAccount>;
  @doc("Updating a Spatial Anchors Account")
  update is ArmResourcePatchSync<
    SpatialAnchorsAccount,
    MixedRealityAccountProperties
  >;
  @doc("Delete a Spatial Anchors Account.")
  delete is ArmResourceDeleteSync<SpatialAnchorsAccount>;
  @doc("List Resources by Resource Group")
  listByResourceGroup is ArmResourceListByParent<SpatialAnchorsAccount>;
  @doc("List Spatial Anchors Accounts by Subscription")
  listBySubscription is ArmListBySubscription<SpatialAnchorsAccount>;
  @doc("List Both of the 2 Keys of a Spatial Anchors Account")
  listKeys is ArmResourceActionSync<SpatialAnchorsAccount, void, AccountKeys>;
  @doc("Regenerate specified Key of a Spatial Anchors Account")
  regenerateKeys is ArmResourceActionSync<
    SpatialAnchorsAccount,
    AccountKeyRegenerateRequest,
    AccountKeys
  >;
}
