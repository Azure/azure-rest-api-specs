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
@doc("Account resource")
model Account is TrackedResource<AccountProperties> {
  @doc("The name of the account.")
  @path
  @key("accountName")
  @segment("accounts")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Accounts {
  @doc("Get an account")
  get is ArmResourceRead<Account>;

  @doc("Creates or updates an account")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Account>;

  @doc("Updates an account")
  update is ArmCustomPatchAsync<Account, AccountUpdateParameters>;

  @doc("Deletes an account resource")
  delete is ArmResourceDeleteAsync<Account>;

  @doc("List accounts in ResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    Account,
    {
      ...BaseParameters<Account>;

      @doc("The skip token.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  @doc("List accounts in Subscription")
  listBySubscription is ArmListBySubscription<Account>;

  @doc("List the authorization keys associated with this account.")
  listKeys is ArmResourceActionSync<Account, void, AccessKeys>;

  @doc("Add the administrator for root collection associated with this account.")
  addRootCollectionAdmin is ArmResourceActionSync<
    Account,
    CollectionAdminUpdate,
    void
  >;

  @doc("Checks if account name is available.")
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
