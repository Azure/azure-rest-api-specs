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
/**
 * Account details
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(AccountResourceProperties)
model AccountResource extends TrackedResourceBase {
  /**
   * The name of the resource.
   */
  @path
  @key("resourceName")
  @segment("accounts")
  @visibility("read")
  name: string;

  /**
   * Property bag from billing account
   */
  @extension("x-ms-client-flatten", true)
  properties: AccountResourceProperties;
}

@armResourceOperations
interface AccountResources {
  /**
   * Returns account resource for a given name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_Get")
  get is ArmResourceRead<AccountResource>;

  /**
   * Create or update account resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_CreateAndUpdate")
  createAndUpdate is ArmResourceCreateOrReplaceAsync<
    AccountResource,
    BaseParameters<AccountResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update account details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Accounts_Update")
  update is ArmCustomPatchSync<AccountResource, AccountPatchResource>;

  /**
   * Deletes a account resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_Delete")
  delete is ArmResourceDeleteSync<AccountResource>;

  /**
   * Returns list of accounts apps.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AccountResource>;

  /**
   * Returns list of accounts belonging to a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
