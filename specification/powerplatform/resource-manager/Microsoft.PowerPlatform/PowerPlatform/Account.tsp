import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.PowerPlatform;
/**
 * Definition of the account.
 */
model Account is Azure.ResourceManager.TrackedResource<AccountProperties> {
  ...ResourceNameParameter<
    Resource = Account,
    KeyName = "accountName",
    SegmentName = "accounts",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Accounts {
  /**
   * Get information about an account.
   */
  get is ArmResourceRead<Account>;

  /**
   * Creates an account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Account>;

  /**
   * Updates an account.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Account, PatchModel = PatchAccount>;

  /**
   * Delete an account.
   */
  delete is ArmResourceDeleteSync<Account>;

  /**
   * Retrieve a list of accounts within a given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Account,
    Response = ArmResponse<AccountList>
  >;

  /**
   * Retrieve a list of accounts within a subscription.
   */
  listBySubscription is ArmListBySubscription<
    Account,
    Response = ArmResponse<AccountList>
  >;
}

@@doc(Account.name, "Name of the account.");
@@doc(Account.properties,
  "The properties that define configuration for the account."
);
@@doc(Accounts.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update an account."
);
@@doc(Accounts.update::parameters.properties,
  "Parameters supplied to update an account."
);
