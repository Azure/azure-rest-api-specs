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
/**
 * SpatialAnchorsAccount Response.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  MixedRealityAccountProperties
)
@includeInapplicableMetadataInPayload(false)
model SpatialAnchorsAccount extends TrackedResourceBase {
  /**
   * Name of an Mixed Reality Account.
   */
  @maxLength(90)
  @minLength(1)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @path
  @key("accountName")
  @segment("spatialAnchorsAccounts")
  name: string;

  /**
   * The kind of account, if supported
   */
  kind?: Sku;

  /**
   * Property bag.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MixedRealityAccountProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourcePlan;
}

@armResourceOperations
interface SpatialAnchorsAccounts {
  /**
   * Retrieve a Spatial Anchors Account.
   */
  get is ArmResourceRead<SpatialAnchorsAccount>;

  /**
   * Creating or Updating a Spatial Anchors Account.
   */
  create is ArmResourceCreateOrReplaceSync<SpatialAnchorsAccount>;

  /**
   * Updating a Spatial Anchors Account
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<SpatialAnchorsAccount, SpatialAnchorsAccount>;

  /**
   * Delete a Spatial Anchors Account.
   */
  delete is ArmResourceDeleteSync<SpatialAnchorsAccount>;

  /**
   * List Resources by Resource Group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SpatialAnchorsAccounts_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<SpatialAnchorsAccount>;

  /**
   * List Spatial Anchors Accounts by Subscription
   */
  listBySubscription is ArmListBySubscription<SpatialAnchorsAccount>;

  /**
   * List Both of the 2 Keys of a Spatial Anchors Account
   */
  listKeys is ArmResourceActionSync<SpatialAnchorsAccount, void, AccountKeys>;

  /**
   * Regenerate specified Key of a Spatial Anchors Account
   */
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
