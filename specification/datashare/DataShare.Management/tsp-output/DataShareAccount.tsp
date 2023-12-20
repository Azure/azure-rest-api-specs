import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataShare;
@doc("An account data transfer object.")
model DataShareAccount is TrackedResource<AccountProperties> {
  @doc("The name of the share account.")
  @path
  @key("accountName")
  @segment("accounts")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface DataShareAccounts {
  @doc("Get an account")
  get is ArmResourceRead<DataShareAccount>;
  @doc("Create an account")
  create is ArmResourceCreateOrUpdateAsync<DataShareAccount>;
  @doc("Patch an account")
  update is ArmTagsPatchSync<DataShareAccount>;
  @doc("DeleteAccount")
  delete is ArmResourceDeleteAsync<DataShareAccount>;
  @doc("List Accounts in ResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    DataShareAccount,
    {
      ...BaseParameters<DataShareAccount>;

      @doc("Continuation token")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
  @doc("List Accounts in Subscription")
  listBySubscription is ArmListBySubscription<DataShareAccount>;
}
