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

namespace Microsoft.GraphServices;
@doc("Account details")
model AccountResource is TrackedResource<AccountResourceProperties> {
  @doc("The name of the resource.")
  @path
  @key("resourceName")
  @segment("accounts")
  name: string;
}

@armResourceOperations
interface AccountResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns account resource for a given name.")
  @operationId("Accounts_Get")
  get is ArmResourceRead<AccountResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update account resource.")
  @operationId("Accounts_CreateAndUpdate")
  createAndUpdate is ArmResourceCreateOrUpdateAsync<
    AccountResource,
    BaseParameters<AccountResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update account details.")
  @operationId("Accounts_Update")
  update is ArmCustomPatchSync<AccountResource, AccountPatchResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a account resource.")
  @operationId("Accounts_Delete")
  delete is ArmResourceDeleteSync<AccountResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns list of accounts apps.")
  @operationId("Accounts_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AccountResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns list of accounts belonging to a subscription.")
  @operationId("Accounts_ListBySubscription")
  listBySubscription is ArmListBySubscription<AccountResource>;
}

@@projectedName(AccountResources.createAndUpdate::parameters.resource,
  "json",
  "accountResource"
);
@@extension(AccountResources.createAndUpdate::parameters.resource,
  "x-ms-client-name",
  "accountResource"
);
@@doc(AccountResources.createAndUpdate::parameters.resource,
  "Account details."
);
@@projectedName(AccountResources.update::parameters.properties,
  "json",
  "accountResource"
);
@@extension(AccountResources.update::parameters.properties,
  "x-ms-client-name",
  "accountResource"
);
@@doc(AccountResources.update::parameters.properties, "Account patch details.");
