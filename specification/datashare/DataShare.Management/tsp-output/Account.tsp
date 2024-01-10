import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataShare;
@doc("An account data transfer object.")
model Account is TrackedResource<AccountProperties> {
  @doc("The name of the share account.")
  @key("accountName")
  @segment("accounts")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Accounts {
  @doc("Get an account")
  get is ArmResourceRead<Account>;

  @doc("Create an account")
  create is ArmResourceCreateOrUpdateAsync<Account>;

  @doc("Patch an account")
  update is ArmCustomPatchSync<Account, AccountUpdateParameters>;

  @doc("DeleteAccount")
  delete is ArmResourceDeleteAsync<Account>;

  @doc("List Accounts in ResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    Account,
    {
      ...BaseParameters<Account>;

      @doc("Continuation token")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  @doc("List Accounts in Subscription")
  listBySubscription is ArmListBySubscription<Account>;
}
