import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MixedReality;
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
  update is ArmCustomPatchSync<SpatialAnchorsAccount, SpatialAnchorsAccount>;

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

@@projectedName(SpatialAnchorsAccounts.create::parameters.resource,
  "json",
  "spatialAnchorsAccount"
);
@@extension(SpatialAnchorsAccounts.create::parameters.resource,
  "x-ms-client-name",
  "spatialAnchorsAccount"
);
@@doc(SpatialAnchorsAccounts.create::parameters.resource,
  "Spatial Anchors Account parameter."
);
@@projectedName(SpatialAnchorsAccounts.update::parameters.properties,
  "json",
  "spatialAnchorsAccount"
);
@@extension(SpatialAnchorsAccounts.update::parameters.properties,
  "x-ms-client-name",
  "spatialAnchorsAccount"
);
@@doc(SpatialAnchorsAccounts.update::parameters.properties,
  "Spatial Anchors Account parameter."
);
@@projectedName(SpatialAnchorsAccounts.regenerateKeys::parameters.body,
  "json",
  "regenerate"
);
@@extension(SpatialAnchorsAccounts.regenerateKeys::parameters.body,
  "x-ms-client-name",
  "regenerate"
);
@@doc(SpatialAnchorsAccounts.regenerateKeys::parameters.body,
  "Required information for key regeneration."
);
