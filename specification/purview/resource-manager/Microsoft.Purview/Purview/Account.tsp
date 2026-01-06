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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Identity;

  /**
   * Gets or sets the Sku.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: AccountSku;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Patches the account resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Account,
    PatchModel = AccountUpdateParameters,
    Response = ArmResponse<Account> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Account> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: Account;
    }),
    Error = ErrorResponseModel
  >;

  /**
   * Deletes an account resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets a list of features and their status for the account.\r\nStatus of enabled features will be true. Status of disabled features will be false.\r\nFeatures that don't exist will be excluded from the results.")
  @operationId("Features_AccountGet")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Lists all ingestion private endpoint connections.")
  @operationId("IngestionPrivateEndpointConnections_List")
  @list
  @get
  @action("ingestionPrivateEndpointConnections")
  list is ArmResourceActionSync<
    Account,
    void,
    ArmResponse<PrivateEndpointConnectionList>,
    Error = ErrorResponseModel
  >;

  /**
   * Update ingestion private endpoint connection status
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates ingestion private endpoint connection status.")
  @operationId("IngestionPrivateEndpointConnections_UpdateStatus")
  @action("ingestionPrivateEndpointConnectionStatus")
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
