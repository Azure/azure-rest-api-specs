import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace Microsoft.Network;
/**
 * Azure Web Category Resource.
 */
@featureFile(Features.azureWebCategory)
@subscriptionResource
model AzureWebCategory
  is ProxyResourceInstance<AzureWebCategoryPropertiesFormat> {
  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("name")
  @segment("azureWebCategories")
  name: string;
}

@featureFile(Features.azureWebCategory)
@armResourceOperations(#{ omitTags: true })
interface AzureWebCategories {
  /**
   * Gets the specified Azure Web Category.
   */
  @tag("WebCategories")
  get is ArmResourceRead<
    AzureWebCategory,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * Expands resourceIds back referenced by the azureWebCategory resource.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = CloudError
  >;

  /**
   * Gets all the Azure Web Categories in a subscription.
   */
  @tag("WebCategories")
  listBySubscription is ArmResourceListByParent<
    AzureWebCategory,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = AzureWebCategoryListResult,
    Error = CloudError
  >;
}

@@doc(AzureWebCategory.name, "The name of the azureWebCategory.");
@@doc(AzureWebCategory.properties, "Properties of the Azure Web Category.");
