import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
/**
 * NetApp account resource
 */
model NetAppAccount
  is Azure.ResourceManager.TrackedResource<AccountProperties> {
  ...ResourceNameParameter<
    Resource = NetAppAccount,
    KeyName = "accountName",
    SegmentName = "netAppAccounts",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,127}$"
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface NetAppAccounts {
  /**
   * Get the NetApp account
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_Get")
  get is ArmResourceRead<NetAppAccount>;

  /**
   * Create or update the specified NetApp account within the resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NetAppAccount>;

  /**
   * Patch the specified NetApp account
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("Accounts_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NetAppAccount,
    PatchModel = NetAppAccountPatch,
    Response = ArmResponse<NetAppAccount> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: NetAppAccount;
    })
  >;

  /**
   * Delete the specified NetApp account
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<NetAppAccount>;

  /**
   * List and describe all NetApp accounts in the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_List")
  list is ArmResourceListByParent<
    NetAppAccount,
    Response = ArmResponse<NetAppAccountList>
  >;

  /**
   * List and describe all NetApp accounts in the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    NetAppAccount,
    Response = ArmResponse<NetAppAccountList>
  >;

  /**
   * Renew identity credentials that are used to authenticate to key vault, for customer-managed key encryption. If encryption.identity.principalId does not match identity.principalId, running this operation will fix it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_RenewCredentials")
  renewCredentials is ArmResourceActionAsync<
    NetAppAccount,
    void,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Transitions all volumes in a VNet to a different encryption key source (Microsoft-managed key or Azure Key Vault). Operation fails if targeted volumes share encryption sibling set with volumes from another account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_TransitionToCmk")
  @action("transitiontocmk")
  transitionToCmk is ArmResourceActionAsyncBase<
    NetAppAccount,
    EncryptionTransitionRequest,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetAppAccount>,
    OptionalRequestBody = true
  >;

  /**
   * Contains data from encryption.keyVaultProperties as well as information about which private endpoint is used by each encryption sibling set. Response from this endpoint can be modified and used as request body for POST request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_GetChangeKeyVaultInformation")
  @action("getKeyVaultStatus")
  getChangeKeyVaultInformation is ArmResourceActionAsync<
    NetAppAccount,
    void,
    ArmResponse<GetKeyVaultStatusResponse>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = GetKeyVaultStatusResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Affects existing volumes that are encrypted with Key Vault/Managed HSM, and new volumes. Supports HSM to Key Vault, Key Vault to HSM, HSM to HSM and Key Vault to Key Vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_ChangeKeyVault")
  changeKeyVault is ArmResourceActionAsyncBase<
    NetAppAccount,
    ChangeKeyVault,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetAppAccount>,
    OptionalRequestBody = true
  >;

  /**
   * List all volume groups for given account
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VolumeGroups_ListByNetAppAccount")
  @list
  @get
  @action("volumeGroups")
  listByNetAppAccount is ArmResourceActionSync<
    NetAppAccount,
    void,
    ArmResponse<VolumeGroupList>
  >;

  /**
   * Migrate the backups under a NetApp account to backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupsUnderAccount_MigrateBackups")
  migrateBackups is ArmResourceActionAsyncBase<
    NetAppAccount,
    BackupsMigrationRequest,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetAppAccount>
  >;
}

@@doc(NetAppAccount.name, "The name of the NetApp account");
@@doc(NetAppAccount.properties, "NetApp Account properties");
@@doc(NetAppAccounts.createOrUpdate::parameters.resource,
  "NetApp Account object supplied in the body of the operation."
);
@@doc(NetAppAccounts.update::parameters.properties,
  "NetApp Account object supplied in the body of the operation."
);
@@doc(NetAppAccounts.transitionToCmk::parameters.body,
  "The required parameters to perform encryption transition."
);
@@doc(NetAppAccounts.changeKeyVault::parameters.body,
  "The required parameters to perform encryption migration."
);
@@doc(NetAppAccounts.migrateBackups::parameters.body,
  "Migrate backups under an account payload supplied in the body of the operation."
);
