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
/**
 * Device Update account details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(AccountProperties)
model Account extends TrackedResourceBase {
  /**
   * Account name.
   */
  @maxLength(24)
  @minLength(3)
  @pattern("^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$")
  @path
  @key("accountName")
  @segment("accounts")
  @visibility("read")
  name: string;

  /**
   * Device Update account properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AccountProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Accounts {
  /**
   * Returns account details for the given account name.
   */
  get is ArmResourceRead<Account>;

  /**
   * Creates or updates Account.
   */
  create is ArmResourceCreateOrReplaceAsync<
    Account,
    BaseParameters<Account>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates account's patchable properties
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Account,
    AccountUpdate,
    BaseParameters<Account>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes account.
   */
  delete is ArmResourceDeleteAsync<
    Account,
    BaseParameters<Account>,
    ArmLroLocationHeader
  >;

  /**
   * Returns list of Accounts.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Account>;

  /**
   * Returns list of Accounts.
   */
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
