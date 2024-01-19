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

  @doc("Creates or updates Account.")
  create is ArmResourceCreateOrUpdateAsync<
    Account,
    BaseParameters<Account>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates account's patchable properties")
  update is ArmCustomPatchAsync<
    Account,
    AccountUpdate,
    BaseParameters<Account>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes account.")
  delete is ArmResourceDeleteAsync<
    Account,
    BaseParameters<Account>,
    ArmLroLocationHeader
  >;

  @doc("Returns list of Accounts.")
  listByResourceGroup is ArmResourceListByParent<Account>;

  @doc("Returns list of Accounts.")
  listBySubscription is ArmListBySubscription<Account>;
}

@@projectedName(Accounts.create::parameters.resource, "json", "Account");
@@extension(Accounts.create::parameters.resource,
  "x-ms-client-name",
  "Account"
);
@@doc(Accounts.create::parameters.resource, "Account details.");
@@projectedName(Accounts.update::parameters.properties,
  "json",
  "accountUpdatePayload"
);
@@extension(Accounts.update::parameters.properties,
  "x-ms-client-name",
  "accountUpdatePayload"
);
@@doc(Accounts.update::parameters.properties, "Updated Account.");
