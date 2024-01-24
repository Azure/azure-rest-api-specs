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

namespace Microsoft.DataShare;
/**
 * An account data transfer object.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(AccountProperties)
@includeInapplicableMetadataInPayload(false)
model Account extends DefaultDto {
  /**
   * The name of the share account.
   */
  @path
  @key("accountName")
  @segment("accounts")
  name: string;

  /**
   * Identity Info on the Account
   */
  identity: Identity;

  /**
   * Properties on the account
   */
  @extension("x-ms-client-flatten", true)
  properties?: AccountProperties;
}

@armResourceOperations
interface Accounts {
  /**
   * Get an account
   */
  get is ArmResourceRead<Account>;

  /**
   * Create an account
   */
  create is ArmResourceCreateOrReplaceAsync<Account>;

  /**
   * Patch an account
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Account, AccountUpdateParameters>;

  /**
   * DeleteAccount
   */
  delete is ArmResourceDeleteAsync<Account>;

  /**
   * List Accounts in ResourceGroup
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    Account,
    {
      ...BaseParameters<Account>;

      /**
       * Continuation token
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  /**
   * List Accounts in Subscription
   */
  listBySubscription is ArmListBySubscription<Account>;
}

@@projectedName(Accounts.create::parameters.resource, "json", "account");
@@extension(Accounts.create::parameters.resource,
  "x-ms-client-name",
  "account"
);
@@doc(Accounts.create::parameters.resource, "The account payload.");
@@projectedName(Accounts.update::parameters.properties,
  "json",
  "accountUpdateParameters"
);
@@extension(Accounts.update::parameters.properties,
  "x-ms-client-name",
  "accountUpdateParameters"
);
@@doc(Accounts.update::parameters.properties, "The account update parameters.");
