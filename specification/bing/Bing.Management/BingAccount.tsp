import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Bing;
/**
 * Bing Account is an Azure resource representing the provisioned account, its type, location and SKU.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Private.armResourceInternal(BingAccountProperties)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
model BingAccount extends Foundations.ProxyResource {
  ...ResourceNameParameter<
    Resource = BingAccount,
    KeyName = "accountName",
    SegmentName = "accounts",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  /**
   * Entity Tag
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Required. Indicates the type of Bing account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;

  /**

   * The location of the resource

   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("The resource-specific properties for this resource.")
  properties?: BingAccountProperties;

  /**
   * The SKU of Bing account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;

  /**

   * Gets or sets a list of key-value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater than 128 characters and value no greater than 256 characters.

   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

@armResourceOperations
interface BingAccounts {
  /**
   * Returns a Bing account specified by the parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<BingAccount>;

  /**
   * Create a Bing account. Accounts is a resource group-wide resource type. It holds keys for developers to access Bing APIs and is the resource type for billing.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceAsync<BingAccount>;

  /**
   * Updates a Bing account
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    BingAccount,
    PatchModel = BingAccount,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = BingAccount> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a Bing account from the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteSync<BingAccount>;

  /**
   * Returns all the resources of a particular type belonging to a resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listByResourceGroup is ArmResourceListByParent<BingAccount>;

  /**
   * Returns all the resources of a particular type belonging to a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  list is ArmListBySubscription<BingAccount>;

  /**
   * Gets the keys to access the Bing APIs for the specified Bing account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listKeys is ArmResourceActionSync<BingAccount, void, BingAccountKeys>;

  /**
   * Regenerates the specified account key for the specified Bing account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  regenerateKey is ArmResourceActionSync<
    BingAccount,
    RegenerateKeyParameters,
    BingAccountKeys
  >;

  /**
   * List available SKUs for the requested Bing account
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("skus")
  listSkus is ArmResourceActionSync<
    BingAccount,
    void,
    BingAccountEnumerateSkusResult
  >;

  /**
   * List usages for the requested Bing account
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("usages")
  listUsages is ArmResourceActionSync<
    BingAccount,
    void,
    UsagesResult,
    Parameters = {
      /**
       * An OData filter expression that describes a subset of usages to return. The supported parameter is name.value (name of the metric, can have an or of multiple names).
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@maxLength(BingAccount.name, 64);
@@minLength(BingAccount.name, 2);
@@doc(BingAccount.name, "The name of the Bing account.");
@@doc(BingAccount.properties, "Properties of Bing account.");
@@doc(BingAccounts.create::parameters.resource,
  "The parameters of the account to create."
);
@@doc(BingAccounts.update::parameters.properties,
  "The parameters to update in the account."
);
@@doc(BingAccounts.regenerateKey::parameters.body,
  "Regenerate key parameters."
);
