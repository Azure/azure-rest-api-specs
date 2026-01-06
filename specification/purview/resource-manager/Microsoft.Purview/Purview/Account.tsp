import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Purview;
/**
 * Account resource
 */
model Account
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<AccountProperties> {
  ...ResourceNameParameter<
    Resource = Account,
    KeyName = "accountName",
    SegmentName = "accounts",
    NamePattern = "^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$"
  >;

  /**
   * The Managed Identity of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Identity;

  /**
   * Gets or sets the Sku.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: AccountSku;
}

@armResourceOperations
interface Accounts {
  /**
   * Get an account
   */
  get is ArmResourceRead<Account>;

  /**
   * Creates or updates an account
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Account,
    LroHeaders = ArmLroLocationHeader<FinalResult = Account> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates an account
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Account,
    PatchModel = AccountUpdateParameters,
    Response = ArmResponse<Account> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Account;
    })
  >;

  /**
   * Deletes an account resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Account,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List accounts in ResourceGroup
   */
  listByResourceGroup is ArmResourceListByParent<
    Account,
    Parameters = {
      /**
       * The skip token.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<AccountList>
  >;

  /**
   * List accounts in Subscription
   */
  listBySubscription is ArmListBySubscription<
    Account,
    Parameters = {
      /**
       * The skip token.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<AccountList>
  >;

  /**
   * Add the administrator for root collection associated with this account.
   */
  addRootCollectionAdmin is ArmResourceActionSync<
    Account,
    CollectionAdminUpdate,
    OkResponse
  >;

  /**
   * List the authorization keys associated with this account.
   */
  @action("listkeys")
  listKeys is ArmResourceActionSync<Account, void, ArmResponse<AccessKeys>>;

  /**
   * Gets details from a list of feature names.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Features_AccountGet")
  @action("listFeatures")
  accountGet is ArmResourceActionSync<
    Account,
    BatchFeatureRequest,
    ArmResponse<BatchFeatureStatus>
  >;

  /**
   * Lists all ingestion private endpoint connections
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IngestionPrivateEndpointConnections_List")
  @list
  @get
  @action("ingestionPrivateEndpointConnections")
  list is ArmResourceActionSync<
    Account,
    void,
    ArmResponse<PrivateEndpointConnectionList>
  >;

  /**
   * Update ingestion private endpoint connection status
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IngestionPrivateEndpointConnections_UpdateStatus")
  @action("ingestionPrivateEndpointConnectionStatus")
  updateStatus is ArmResourceActionSync<
    Account,
    PrivateEndpointConnectionStatusUpdateRequest,
    ArmResponse<PrivateEndpointConnectionStatusUpdateResponse>
  >;
}

@@maxLength(Account.name, 63);
@@minLength(Account.name, 3);
@@doc(Account.name, "The name of the account.");
@@doc(Account.properties, "The account properties");
@@doc(Accounts.createOrUpdate::parameters.resource, "The account.");
@@doc(Accounts.update::parameters.properties, "The account update parameters.");
@@doc(Accounts.addRootCollectionAdmin::parameters.body,
  "The collection admin update payload."
);
@@doc(Accounts.accountGet::parameters.body, "Request body with feature names.");
@@doc(Accounts.updateStatus::parameters.body,
  "The ingestion private endpoint connection status update request."
);
