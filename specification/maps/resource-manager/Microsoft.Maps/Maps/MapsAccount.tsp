import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Maps;
/**
 * An Azure resource which represents access to a suite of Maps REST APIs.
 */
model MapsAccount
  is Azure.ResourceManager.TrackedResource<MapsAccountProperties> {
  ...ResourceNameParameter<
    Resource = MapsAccount,
    KeyName = "accountName",
    SegmentName = "accounts",
    NamePattern = "^[^%&:\\\\/#?]+$"
  >;

  /**
   * The SKU of this account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku: Sku;

  /**
   * Get or Set Kind property.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: Kind;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface Accounts {
  /**
   * Get a Maps Account.
   */
  get is ArmResourceRead<MapsAccount>;

  /**
   * Create or update a Maps Account. A Maps Account holds the keys which allow access to the Maps REST APIs.
   */
  @removed(Versions.v2026_12_01)
  @renamedFrom(Versions.v2026_12_01, "createOrUpdate")
  @sharedRoute
  createOrUpdateV1 is ArmResourceCreateOrReplaceSync<MapsAccount>;

  /**
   * Create or update a Maps Account. A Maps Account holds the keys which allow access to the Maps REST APIs.
   */
  @added(Versions.v2026_12_01)
  @sharedRoute
  @Azure.Core.useFinalStateVia("location")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    MapsAccount,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = MapsAccount> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a Maps Account. Only a subset of the parameters may be updated after creation, such as Sku, Tags, Properties.
   */
  @removed(Versions.v2026_12_01)
  @renamedFrom(Versions.v2026_12_01, "update")
  @sharedRoute
  updateV1 is ArmCustomPatchSync<
    MapsAccount,
    PatchModel = MapsAccountUpdateParameters
  >;

  /**
   * Updates a Maps Account. Only a subset of the parameters may be updated after creation, such as Sku, Tags, Properties.
   */
  @added(Versions.v2026_12_01)
  @sharedRoute
  @Azure.Core.useFinalStateVia("location")
  update is ArmCustomPatchAsync<
    MapsAccount,
    PatchModel = MapsAccountUpdateParameters,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = MapsAccount> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a Maps Account.
   */
  delete is ArmResourceDeleteSync<MapsAccount>;

  /**
   * Get all Maps Accounts in a Resource Group
   */
  listByResourceGroup is ArmResourceListByParent<
    MapsAccount,
    Response = ArmResponse<MapsAccounts>
  >;

  /**
   * Get all Maps Accounts in a Subscription
   */
  listBySubscription is ArmListBySubscription<
    MapsAccount,
    Response = ArmResponse<MapsAccounts>
  >;

  /**
   * Create and list an account shared access signature token. Use this SAS token for authentication to Azure Maps REST APIs through various Azure Maps SDKs. As prerequisite to create a SAS Token.
   *
   * Prerequisites:
   * 1. Create or have an existing User Assigned Managed Identity in the same Azure region as the account.
   * 2. Create or update an Azure Maps account with the same Azure region as the User Assigned Managed Identity is placed.
   */
  listSas is ArmResourceActionSync<
    MapsAccount,
    AccountSasParameters,
    ArmResponse<MapsAccountSasToken>
  >;

  /**
   * Get the keys to use with the Maps APIs. A key is used to authenticate and authorize access to the Maps REST APIs. Only one key is needed at a time; two are given to provide seamless key regeneration.
   */
  listKeys is ArmResourceActionSync<
    MapsAccount,
    void,
    ArmResponse<MapsAccountKeys>
  >;

  /**
   * Regenerate either the primary or secondary key for use with the Maps APIs. The old key will stop working immediately.
   */
  @action("regenerateKey")
  regenerateKeys is ArmResourceActionSync<
    MapsAccount,
    MapsKeySpecification,
    ArmResponse<MapsAccountKeys>
  >;
}

@@minLength(MapsAccount.name, 1);
@@doc(MapsAccount.name, "The name of the Maps Account.");
@@doc(MapsAccount.properties, "The map account properties.");
@@doc(
  Accounts.createOrUpdateV1::parameters.resource,
  "The new or updated parameters for the Maps Account."
);
@@doc(
  Accounts.createOrUpdate::parameters.resource,
  "The new or updated parameters for the Maps Account."
);
@@doc(
  Accounts.updateV1::parameters.properties,
  "The updated parameters for the Maps Account."
);
@@doc(
  Accounts.update::parameters.properties,
  "The updated parameters for the Maps Account."
);
@@doc(
  Accounts.listSas::parameters.body,
  "The updated parameters for the Maps Account."
);
@@doc(
  Accounts.regenerateKeys::parameters.body,
  "Which key to regenerate:  primary or secondary."
);
