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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
@subscriptionResource
model AzureWebCategory extends ProxyResource {
  /**
   * Properties of the Azure Web Category.
   */
  properties?: AzureWebCategoryPropertiesFormat;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("name")
  @segment("azureWebCategories")
  name: string;
}

@armResourceOperations
interface AzureWebCategories {
  /**
   * Gets the specified Azure Web Category.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebCategories_Get")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebCategories_ListBySubscription")
  listBySubscription is ArmResourceListByParent<
    AzureWebCategory,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;
}

@@doc(AzureWebCategory.name, "The name of the azureWebCategory.");
@@doc(AzureWebCategory.properties, "Properties of the Azure Web Category.");
