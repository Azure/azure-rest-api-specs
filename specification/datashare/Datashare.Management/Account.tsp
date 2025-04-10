import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;
/**
 * An account data transfer object.
 */
model Account is Azure.ResourceManager.TrackedResource<AccountProperties> {
  ...ResourceNameParameter<
    Resource = Account,
    KeyName = "accountName",
    SegmentName = "accounts",
    NamePattern = ""
  >;

  /**
   * Identity Info on the Account
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity: Identity;
}

@armResourceOperations
interface Accounts {
  /**
   * Get an account
   */
  get is ArmResourceRead<Account>;

  /**
   * Create an account
   */
  create is ArmResourceCreateOrReplaceAsync<
    Account,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Patch an account
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Account, PatchModel = AccountUpdateParameters>;

  /**
   * DeleteAccount
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Account,
    Response = ArmResponse<OperationResponse> | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List Accounts in ResourceGroup
   */
  listByResourceGroup is ArmResourceListByParent<
    Account,
    Parameters = {
      /**
       * Continuation token
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<AccountList>
  >;

  /**
   * List Accounts in Subscription
   */
  listBySubscription is ArmListBySubscription<
    Account,
    Parameters = {
      /**
       * Continuation token
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<AccountList>
  >;
}

@@doc(Account.name, "The name of the share account.");
@@doc(Account.properties, "Properties on the account");
@@doc(Accounts.create::parameters.resource, "The account payload.");
@@doc(Accounts.update::parameters.properties, "The account update parameters.");
