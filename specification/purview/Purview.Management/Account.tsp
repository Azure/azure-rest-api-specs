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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
model Account extends TrackedResource {
  /**
   * The name of the account.
   */
  @visibility(Lifecycle.Read)
  @key("accountName")
  @path
  @segment("accounts")
  @minLength(3)
  @maxLength(63)
  @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
  name: string;

  /**
   * Gets or sets the Sku.
   */
  sku?: AccountSku;

  properties?: AccountProperties;
}

@armResourceOperations
interface Accounts {
  /**
   * Get an account
   */
  @summary("Gets the account resource.")
  get is ArmResourceRead<Account, Error = ErrorResponseModel>;

  /**
   * Creates or updates an account
   */
  @summary("Create or update an account resource.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Account,
    LroHeaders = ArmLroLocationHeader<FinalResult = Account> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponseModel
  >;

  /**
   * Updates an account
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @summary("Patches the account resource.")
  update is ArmCustomPatchAsync<
    Account,
    PatchModel = AccountUpdateParameters,
    Response = ArmResponse<Account> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Account;
    }),
    Error = ErrorResponseModel
  >;

  /**
   * Deletes an account resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @summary("Deletes the account resource.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Account,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ErrorResponseModel
  >;

  /**
   * List accounts in ResourceGroup
   */
  @summary("Gets the accounts resources by resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Account,
    Parameters = {
      /**
       * The skip token.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<AccountList>,
    Error = ErrorResponseModel
  >;

  /**
   * List accounts in Subscription
   */
  @summary("Gets the accounts resources by subscription.")
  listBySubscription is ArmListBySubscription<
    Account,
    Parameters = {
      /**
       * The skip token.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<AccountList>,
    Error = ErrorResponseModel
  >;

  /**
   * Add the administrator for root collection associated with this account.
   */
  @summary("Add the administrator for root collection.")
  addRootCollectionAdmin is ArmResourceActionSync<
    Account,
    CollectionAdminUpdate,
    OkResponse,
    Error = ErrorResponseModel
  >;

  /**
   * List the authorization keys associated with this account.
   */
  @summary("Lists the keys asynchronous.")
  @action("listkeys")
  listKeys is ArmResourceActionSync<
    Account,
    void,
    ArmResponse<AccessKeys>,
    Error = ErrorResponseModel
  >;

  /**
   * Gets details from a list of feature names.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Features_AccountGet")
  @summary("""
    Gets a list of features and their status for the account.
    Status of enabled features will be true. Status of disabled features will be false.
    Features that don't exist will be excluded from the results.
    """)
  @action("listFeatures")
  accountGet is ArmResourceActionSync<
    Account,
    BatchFeatureRequest,
    ArmResponse<BatchFeatureStatus>,
    Error = ErrorResponseModel
  >;

  /**
   * Lists all ingestion private endpoint connections
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IngestionPrivateEndpointConnections_List")
  @list
  @get
  @action("ingestionPrivateEndpointConnections")
  @summary("Lists all ingestion private endpoint connections.")
  list is ArmResourceActionSync<
    Account,
    void,
    ArmResponse<PrivateEndpointConnectionList>,
    Error = ErrorResponseModel
  >;

  /**
   * Update ingestion private endpoint connection status
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IngestionPrivateEndpointConnections_UpdateStatus")
  @action("ingestionPrivateEndpointConnectionStatus")
  @summary("Updates ingestion private endpoint connection status.")
  updateStatus is ArmResourceActionSync<
    Account,
    PrivateEndpointConnectionStatusUpdateRequest,
    ArmResponse<PrivateEndpointConnectionStatusUpdateResponse>,
    Error = ErrorResponseModel
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
