import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(Workspace)
model MarketplaceSubscription
  is Azure.ResourceManager.ProxyResource<
    MarketplaceSubscriptionProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = MarketplaceSubscription,
    KeyName = "name",
    SegmentName = "marketplaceSubscriptions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface MarketplaceSubscriptions {
  /**
   * Get container.
   */
  get is ArmResourceRead<MarketplaceSubscription>;

  /**
   * Create or update Marketplace Subscription (asynchronous).
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MarketplaceSubscription>;

  /**
   * Delete Marketplace Subscription (asynchronous).
   */
  delete is ArmResourceDeleteWithoutOkAsync<MarketplaceSubscription>;

  /**
   * List containers.
   */
  list is ArmResourceListByParent<
    MarketplaceSubscription,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    },
    Response = ArmResponse<MarketplaceSubscriptionResourceArmPaginatedResult>
  >;
}

@@doc(MarketplaceSubscription.name, "Container name.");
@@doc(MarketplaceSubscription.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(MarketplaceSubscriptions.createOrUpdate::parameters.resource,
  "Marketplace Subscription entity to apply during operation."
);
