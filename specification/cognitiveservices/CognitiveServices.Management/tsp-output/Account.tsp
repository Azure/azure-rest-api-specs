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

namespace Microsoft.CognitiveServices;
/**
 * Cognitive Services account is an Azure resource representing the provisioned account, it's type, location and SKU.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(AccountProperties)
@includeInapplicableMetadataInPayload(false)
model Account extends TrackedResourceBase {
  /**
   * The name of Cognitive Services account.
   */
  @maxLength(64)
  @minLength(2)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  @path
  @key("accountName")
  @segment("accounts")
  name: string;

  /**
   * The Kind of the resource.
   */
  kind?: string;

  /**
   * Properties of Cognitive Services account.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AccountProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Accounts {
  /**
   * Returns a Cognitive Services account specified by the parameters.
   */
  get is ArmResourceRead<Account>;

  /**
   * Create Cognitive Services Account. Accounts is a resource group wide resource type. It holds the keys for developer to access intelligent APIs. It's also the resource type for billing.
   */
  create is ArmResourceCreateOrReplaceAsync<Account>;

  /**
   * Updates a Cognitive Services account
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<Account, Account>;

  /**
   * Deletes a Cognitive Services account from the resource group.
   */
  delete is ArmResourceDeleteAsync<Account>;

  /**
   * Returns all the resources of a particular type belonging to a resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Account>;

  /**
   * Returns all the resources of a particular type belonging to a subscription.
   */
  list is ArmListBySubscription<Account>;

  /**
   * Lists the account keys for the specified Cognitive Services account.
   */
  listKeys is ArmResourceActionSync<Account, void, ApiKeys>;

  /**
   * Regenerates the specified account key for the specified Cognitive Services account.
   */
  regenerateKey is ArmResourceActionSync<
    Account,
    RegenerateKeyParameters,
    ApiKeys
  >;

  /**
   * List available SKUs for the requested Cognitive Services account
   */
  // FIXME: Accounts_ListSkus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/skus")
  @get
  listSkus is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of Cognitive Services account.
       */
      @maxLength(64)
      @minLength(2)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      accountName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    AccountSkuListResult
  >;

  /**
   * Get usages for the requested Cognitive Services account
   */
  // FIXME: Accounts_ListUsages could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/usages")
  @get
  listUsages is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of Cognitive Services account.
       */
      @maxLength(64)
      @minLength(2)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      accountName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * An OData filter expression that describes a subset of usages to return. The supported parameter is name.value (name of the metric, can have an or of multiple names).
       */
      @query("$filter")
      $filter?: string;
    },
    UsageListResult
  >;

  /**
   * List available Models for the requested Cognitive Services account
   */
  // FIXME: Accounts_ListModels could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/models")
  @get
  listModels is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of Cognitive Services account.
       */
      @maxLength(64)
      @minLength(2)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      accountName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    AccountModelListResult
  >;

  /**
   * Gets the private link resources that need to be created for a Cognitive Services account.
   */
  // FIXME: PrivateLinkResources_List could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/privateLinkResources")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of Cognitive Services account.
       */
      @maxLength(64)
      @minLength(2)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      accountName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    PrivateLinkResourceListResult
  >;
}

@@projectedName(Accounts.create::parameters.resource, "json", "account");
@@extension(Accounts.create::parameters.resource,
  "x-ms-client-name",
  "account"
);
@@doc(Accounts.create::parameters.resource,
  "The parameters to provide for the created account."
);
@@projectedName(Accounts.update::parameters.properties, "json", "account");
@@extension(Accounts.update::parameters.properties,
  "x-ms-client-name",
  "account"
);
@@doc(Accounts.update::parameters.properties,
  "The parameters to provide for the created account."
);
@@projectedName(Accounts.regenerateKey::parameters.body, "json", "parameters");
@@extension(Accounts.regenerateKey::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(Accounts.regenerateKey::parameters.body, "regenerate key parameters.");
