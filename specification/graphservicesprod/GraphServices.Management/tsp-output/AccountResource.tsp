import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.GraphServices;
@doc("Account details")
model AccountResource is TrackedResource<AccountResourceProperties> {
  @doc("The name of the resource.")
  @key("resourceName")
  @segment("accounts")
  name: string;
}

@armResourceOperations
interface Accounts {
  @doc("Returns account resource for a given name.")
  get is ArmResourceRead<AccountResource>;
  @doc("Create or update account resource.")
  createAndUpdate is ArmResourceCreateOrUpdateAsync<AccountResource>;
  @doc("Update account details.")
  update is ArmCustomPatchSync<AccountResource, AccountPatchResource>;
  @doc("Deletes a account resource.")
  delete is ArmResourceDeleteSync<AccountResource>;
  @doc("Returns list of accounts apps.")
  listByResourceGroup is ArmResourceListByParent<AccountResource>;
  @doc("Returns list of accounts belonging to a subscription.")
  listBySubscription is ArmListBySubscription<AccountResource>;
}
