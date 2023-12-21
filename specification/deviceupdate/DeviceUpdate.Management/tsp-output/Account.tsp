import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DeviceUpdate;
@doc("Device Update account details.")
model Account is TrackedResource<AccountProperties> {
  @doc("Account name.")
  @maxLength(24)
  @minLength(3)
  @pattern("^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$")
  @path
  @key("accountName")
  @segment("accounts")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Accounts {
  @doc("Returns account details for the given account name.")
  get is ArmResourceRead<Account>;
  @doc("Creates or updates Account.")
  create is ArmResourceCreateOrUpdateAsync<Account>;
  @doc("Updates account's patchable properties")
  update is ArmTagsPatchAsync<Account>;
  @doc("Deletes account.")
  delete is ArmResourceDeleteAsync<Account>;
  @doc("Returns list of Accounts.")
  listByResourceGroup is ArmResourceListByParent<Account>;
  @doc("Returns list of Accounts.")
  listBySubscription is ArmListBySubscription<Account>;
}
