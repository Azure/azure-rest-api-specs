import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.MixedReality;
@doc("ObjectAnchorsAccount Response.")
model ObjectAnchorsAccount is TrackedResource<MixedRealityAccountProperties> {
  @doc("Name of an Mixed Reality Account.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @path
  @key("accountName")
  @segment("objectAnchorsAccounts")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourcePlan;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ObjectAnchorsAccounts {
  @doc("Retrieve an Object Anchors Account.")
  get is ArmResourceRead<ObjectAnchorsAccount>;
  @doc("Creating or Updating an object anchors Account.")
  create is ArmResourceCreateOrReplaceSync<ObjectAnchorsAccount>;
  @doc("Updating an Object Anchors Account")
  update is ArmResourcePatchSync<
    ObjectAnchorsAccount,
    MixedRealityAccountProperties
  >;
  @doc("Delete an Object Anchors Account.")
  delete is ArmResourceDeleteSync<ObjectAnchorsAccount>;
  @doc("List Resources by Resource Group")
  listByResourceGroup is ArmResourceListByParent<ObjectAnchorsAccount>;
  @doc("List Object Anchors Accounts by Subscription")
  listBySubscription is ArmListBySubscription<ObjectAnchorsAccount>;
  @doc("List Both of the 2 Keys of an object anchors Account")
  listKeys is ArmResourceActionSync<ObjectAnchorsAccount, {}, AccountKeys>;
  @doc("Regenerate specified Key of an object anchors Account")
  regenerateKeys is ArmResourceActionSync<
    ObjectAnchorsAccount,
    AccountKeyRegenerateRequest,
    AccountKeys
  >;
}
