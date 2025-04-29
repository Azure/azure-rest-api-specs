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
 * RemoteRenderingAccount Response.
 */
model RemoteRenderingAccount
  is Azure.ResourceManager.TrackedResource<MixedRealityAccountProperties> {
  ...ResourceNameParameter<
    Resource = RemoteRenderingAccount,
    KeyName = "accountName",
    SegmentName = "remoteRenderingAccounts",
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
interface RemoteRenderingAccounts {
  /**
   *
   *
   * > [!NOTE]
   * >
   * > **Mixed Reality retirement**
   * >
   * > The Mixed Reality service is now deprecated and will be retired.
   *
   *  Retrieve a Remote Rendering Account.
   */
  get is ArmResourceRead<RemoteRenderingAccount>;

  /**
   *
   *
   * > [!NOTE]
   * >
   * > **Mixed Reality retirement**
   * >
   * > The Mixed Reality service is now deprecated and will be retired.
   *
   *  Creating or Updating a Remote Rendering Account.
   */
  create is ArmResourceCreateOrReplaceSync<RemoteRenderingAccount>;

  /**
   *
   *
   * > [!NOTE]
   * >
   * > **Mixed Reality retirement**
   * >
   * > The Mixed Reality service is now deprecated and will be retired.
   *
   *  Updating a Remote Rendering Account
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    RemoteRenderingAccount,
    PatchModel = RemoteRenderingAccount
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
   *  Delete a Remote Rendering Account.
   */
  delete is ArmResourceDeleteSync<RemoteRenderingAccount>;

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
    RemoteRenderingAccount,
    Response = ArmResponse<RemoteRenderingAccountPage>
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
   *  List Remote Rendering Accounts by Subscription
   */
  listBySubscription is ArmListBySubscription<
    RemoteRenderingAccount,
    Response = ArmResponse<RemoteRenderingAccountPage>
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
   *  List Both of the 2 Keys of a Remote Rendering Account
   */
  listKeys is ArmResourceActionSync<
    RemoteRenderingAccount,
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
   *  Regenerate specified Key of a Remote Rendering Account
   */
  regenerateKeys is ArmResourceActionSync<
    RemoteRenderingAccount,
    AccountKeyRegenerateRequest,
    ArmResponse<AccountKeys>
  >;
}

@@maxLength(RemoteRenderingAccount.name, 90);
@@minLength(RemoteRenderingAccount.name, 1);
@@doc(RemoteRenderingAccount.name, "Name of an Mixed Reality Account.");
@@doc(RemoteRenderingAccount.properties, "Property bag.");
@@doc(RemoteRenderingAccounts.create::parameters.resource,
  "Remote Rendering Account parameter."
);
@@doc(RemoteRenderingAccounts.update::parameters.properties,
  "Remote Rendering Account parameter."
);
@@doc(RemoteRenderingAccounts.regenerateKeys::parameters.body,
  "Required information for key regeneration."
);
