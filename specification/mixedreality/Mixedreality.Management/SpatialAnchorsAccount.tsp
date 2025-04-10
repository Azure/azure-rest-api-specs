import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MixedReality;
/**
 * SpatialAnchorsAccount Response.
 */
model SpatialAnchorsAccount
  is Azure.ResourceManager.TrackedResource<MixedRealityAccountProperties> {
  ...ResourceNameParameter<
    Resource = SpatialAnchorsAccount,
    KeyName = "accountName",
    SegmentName = "spatialAnchorsAccounts",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;

  /**
   * The identity associated with this account
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Identity;

  /**
   * The plan associated with this account
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  plan?: Identity;

  ...Azure.ResourceManager.ResourceSkuProperty;

  /**
   * The kind of account, if supported
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: Sku;
}

@armResourceOperations
interface SpatialAnchorsAccounts {
  /**
   *
   *
   * > [!NOTE]
   * >
   * > **Mixed Reality retirement**
   * >
   * > The Mixed Reality service is now deprecated and will be retired.
   *
   *  Retrieve a Spatial Anchors Account.
   */
  get is ArmResourceRead<SpatialAnchorsAccount>;

  /**
   *
   *
   * > [!NOTE]
   * >
   * > **Mixed Reality retirement**
   * >
   * > The Mixed Reality service is now deprecated and will be retired.
   *
   *  Creating or Updating a Spatial Anchors Account.
   */
  create is ArmResourceCreateOrReplaceSync<SpatialAnchorsAccount>;

  /**
   *
   *
   * > [!NOTE]
   * >
   * > **Mixed Reality retirement**
   * >
   * > The Mixed Reality service is now deprecated and will be retired.
   *
   *  Updating a Spatial Anchors Account
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    SpatialAnchorsAccount,
    PatchModel = SpatialAnchorsAccount
  >;

  /**
   *
   *
   * > [!NOTE]
   * >
   * > **Mixed Reality retirement**
   * >
   * > The Mixed Reality service is now deprecated and will be retired.
   *
   *  Delete a Spatial Anchors Account.
   */
  delete is ArmResourceDeleteSync<SpatialAnchorsAccount>;

  /**
   *
   *
   * > [!NOTE]
   * >
   * > **Mixed Reality retirement**
   * >
   * > The Mixed Reality service is now deprecated and will be retired.
   *
   *  List Resources by Resource Group
   */
  listByResourceGroup is ArmResourceListByParent<
    SpatialAnchorsAccount,
    Response = ArmResponse<SpatialAnchorsAccountPage>
  >;

  /**
   *
   *
   * > [!NOTE]
   * >
   * > **Mixed Reality retirement**
   * >
   * > The Mixed Reality service is now deprecated and will be retired.
   *
   *  List Spatial Anchors Accounts by Subscription
   */
  listBySubscription is ArmListBySubscription<
    SpatialAnchorsAccount,
    Response = ArmResponse<SpatialAnchorsAccountPage>
  >;

  /**
   *
   *
   * > [!NOTE]
   * >
   * > **Mixed Reality retirement**
   * >
   * > The Mixed Reality service is now deprecated and will be retired.
   *
   *  List Both of the 2 Keys of a Spatial Anchors Account
   */
  listKeys is ArmResourceActionSync<
    SpatialAnchorsAccount,
    void,
    ArmResponse<AccountKeys>
  >;

  /**
   *
   *
   * > [!NOTE]
   * >
   * > **Mixed Reality retirement**
   * >
   * > The Mixed Reality service is now deprecated and will be retired.
   *
   *  Regenerate specified Key of a Spatial Anchors Account
   */
  regenerateKeys is ArmResourceActionSync<
    SpatialAnchorsAccount,
    AccountKeyRegenerateRequest,
    ArmResponse<AccountKeys>
  >;
}

@@maxLength(SpatialAnchorsAccount.name, 90);
@@minLength(SpatialAnchorsAccount.name, 1);
@@doc(SpatialAnchorsAccount.name, "Name of an Mixed Reality Account.");
@@doc(SpatialAnchorsAccount.properties, "Property bag.");
@@doc(SpatialAnchorsAccounts.create::parameters.resource,
  "Spatial Anchors Account parameter."
);
@@doc(SpatialAnchorsAccounts.update::parameters.properties,
  "Spatial Anchors Account parameter."
);
@@doc(SpatialAnchorsAccounts.regenerateKeys::parameters.body,
  "Required information for key regeneration."
);
