import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Purview;
@doc("Account resource")
model PurviewAccount is TrackedResource<AccountProperties> {
  @doc("The name of the account.")
  @path
  @key("accountName")
  @segment("accounts")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface PurviewAccounts {
  @doc("Get an account")
  get is ArmResourceRead<PurviewAccount>;
  @doc("Creates or updates an account")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PurviewAccount>;
  @doc("Updates an account")
  update is ArmResourcePatchAsync<PurviewAccount, AccountProperties>;
  @doc("Deletes an account resource")
  delete is ArmResourceDeleteAsync<PurviewAccount>;
  @doc("List accounts in ResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    PurviewAccount,
    {
      ...BaseParameters<PurviewAccount>;

      @doc("The skip token.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
  @doc("List accounts in Subscription")
  listBySubscription is ArmListBySubscription<PurviewAccount>;
  @doc("List the authorization keys associated with this account.")
  listKeys is ArmResourceActionSync<PurviewAccount, void, AccessKeys>;
  @doc("Add the administrator for root collection associated with this account.")
  addRootCollectionAdmin is ArmResourceActionSync<
    PurviewAccount,
    CollectionAdminUpdate,
    void
  >;
}
