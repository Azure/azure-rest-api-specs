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

namespace Microsoft.Purview;
/**
 * Account resource
 */
model Account is TrackedResource<AccountProperties> {
  /**
   * The name of the account.
   */
  @path
  @key("accountName")
  @segment("accounts")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Account>;

  /**
   * Updates an account
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<Account, AccountUpdateParameters>;

  /**
   * Deletes an account resource
   */
  delete is ArmResourceDeleteAsync<Account>;

  /**
   * List accounts in ResourceGroup
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    Account,
    {
      ...BaseParameters<Account>;

      /**
       * The skip token.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  /**
   * List accounts in Subscription
   */
  listBySubscription is ArmListBySubscription<Account>;

  /**
   * List the authorization keys associated with this account.
   */
  listKeys is ArmResourceActionSync<Account, void, AccessKeys>;

  /**
   * Add the administrator for root collection associated with this account.
   */
  addRootCollectionAdmin is ArmResourceActionSync<
    Account,
    CollectionAdminUpdate,
    void
  >;

  /**
   * Checks if account name is available.
   */
  checkNameAvailability is checkGlobalNameAvailability<
    CheckNameAvailabilityRequest,
    CheckNameAvailabilityResult
  >;
}

@@projectedName(Accounts.createOrUpdate::parameters.resource,
  "json",
  "account"
);
@@extension(Accounts.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "account"
);
@@doc(Accounts.createOrUpdate::parameters.resource, "The account.");
@@projectedName(Accounts.update::parameters.properties,
  "json",
  "accountUpdateParameters"
);
@@extension(Accounts.update::parameters.properties,
  "x-ms-client-name",
  "accountUpdateParameters"
);
@@doc(Accounts.update::parameters.properties, "The account update parameters.");
@@projectedName(Accounts.addRootCollectionAdmin::parameters.body,
  "json",
  "collectionAdminUpdate"
);
@@extension(Accounts.addRootCollectionAdmin::parameters.body,
  "x-ms-client-name",
  "collectionAdminUpdate"
);
@@doc(Accounts.addRootCollectionAdmin::parameters.body,
  "The collection admin update payload."
);
