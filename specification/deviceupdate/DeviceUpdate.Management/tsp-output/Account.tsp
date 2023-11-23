import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DeviceUpdate;
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
  @doc("Checks whether account exists.")
  @head
  head(
    ...ResourceInstanceParameters<Account, BaseParameters<Account>>,
  ): OkResponse | ErrorResponse;
  @doc("Creates or updates Account.")
  create is ArmResourceCreateOrUpdateAsync<Account>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Updates account's patchable properties")
  update is ArmCustomPatchAsync<Account, AccountUpdate>;
  @doc("Deletes account.")
  delete is ArmResourceDeleteAsync<Account>;
  @doc("Returns list of Accounts.")
  listByResourceGroup is ArmResourceListByParent<Account>;
  @doc("Returns list of Accounts.")
  listBySubscription is ArmListBySubscription<Account>;
}
