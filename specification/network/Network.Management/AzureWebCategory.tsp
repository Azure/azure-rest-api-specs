import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Azure Web Category Resource.
 */
@subscriptionResource
model AzureWebCategory
  is Azure.ResourceManager.ProxyResource<AzureWebCategoryPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = AzureWebCategory,
    KeyName = "name",
    SegmentName = "azureWebCategories",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface AzureWebCategories {
  /**
   * Gets the specified Azure Web Category.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebCategories_Get")
  get is ArmResourceRead<AzureWebCategory,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * Expands resourceIds back referenced by the azureWebCategory resource.
       */
      @query("$expand")
      $expand?: string;
    }, Error = CloudError>;

  /**
   * Gets all the Azure Web Categories in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebCategories_ListBySubscription")
  listBySubscription is ArmResourceListByParent<AzureWebCategory,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters, Error = CloudError>;
}

@@doc(AzureWebCategory.name, "The name of the azureWebCategory.");
@@doc(AzureWebCategory.properties, "Properties of the Azure Web Category.");
