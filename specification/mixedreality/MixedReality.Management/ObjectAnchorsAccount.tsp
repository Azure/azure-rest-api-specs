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
 * ObjectAnchorsAccount Response.
 */
model ObjectAnchorsAccount
  is Azure.ResourceManager.TrackedResource<MixedRealityAccountProperties> {
  ...ResourceNameParameter<
    Resource = ObjectAnchorsAccount,
    KeyName = "accountName",
    SegmentName = "objectAnchorsAccounts",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ObjectAnchorsAccountIdentity;

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
interface ObjectAnchorsAccounts {
  /**
   *
   *
   * > [!NOTE]
   * >
   * > **Mixed Reality retirement**
   * >
   * > The Mixed Reality service is now deprecated and will be retired.
   *
   *  Retrieve an Object Anchors Account.
   */
  get is ArmResourceRead<ObjectAnchorsAccount>;

  /**
   *
   *
   * > [!NOTE]
   * >
   * > **Mixed Reality retirement**
   * >
   * > The Mixed Reality service is now deprecated and will be retired.
   *
   *  Creating or Updating an object anchors Account.
   */
  create is ArmResourceCreateOrReplaceSync<ObjectAnchorsAccount>;

  /**
   *
   *
   * > [!NOTE]
   * >
   * > **Mixed Reality retirement**
   * >
   * > The Mixed Reality service is now deprecated and will be retired.
   *
   *  Updating an Object Anchors Account
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ObjectAnchorsAccount,
    PatchModel = ObjectAnchorsAccount
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
   *  Delete an Object Anchors Account.
   */
  delete is ArmResourceDeleteSync<ObjectAnchorsAccount>;

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
    ObjectAnchorsAccount,
    Response = ArmResponse<ObjectAnchorsAccountPage>
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
   *  List Object Anchors Accounts by Subscription
   */
  listBySubscription is ArmListBySubscription<
    ObjectAnchorsAccount,
    Response = ArmResponse<ObjectAnchorsAccountPage>
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
   *  List Both of the 2 Keys of an object anchors Account
   */
  listKeys is ArmResourceActionSync<
    ObjectAnchorsAccount,
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
   *  Regenerate specified Key of an object anchors Account
   */
  regenerateKeys is ArmResourceActionSync<
    ObjectAnchorsAccount,
    AccountKeyRegenerateRequest,
    ArmResponse<AccountKeys>
  >;
}

@@maxLength(ObjectAnchorsAccount.name, 90);
@@minLength(ObjectAnchorsAccount.name, 1);
@@doc(ObjectAnchorsAccount.name, "Name of an Mixed Reality Account.");
@@doc(ObjectAnchorsAccount.properties, "Property bag.");
@@doc(ObjectAnchorsAccounts.create::parameters.resource,
  "Object Anchors Account parameter."
);
@@doc(ObjectAnchorsAccounts.update::parameters.properties,
  "Object Anchors Account parameter."
);
@@doc(ObjectAnchorsAccounts.regenerateKeys::parameters.body,
  "Required information for key regeneration."
);
