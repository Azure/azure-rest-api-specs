// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.EdgeOrder;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ProductsAndConfigurationsOperationGroup {
  /**
   * List configurations for the given product family, product line and product for the given subscription.
   */
  @autoRoute
  listConfigurations is ArmProviderActionSync<
    Request = ConfigurationsRequest,
    Response = Configurations,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * $skipToken is supported on list of configurations, which provides the next page in the list of configurations.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
  /**
   * List product families for the given subscription.
   */
  @autoRoute
  listProductFamilies is ArmProviderActionSync<
    Request = ProductFamiliesRequest,
    Response = ProductFamilies,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * $expand is supported on configurations parameter for product, which provides details on the configurations for the product.
       */
      @query("$expand")
      $expand?: string;

      /**
       * $skipToken is supported on list of product families, which provides the next page in the list of product families.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
  /**
   * List product families metadata for the given subscription.
   */
  @autoRoute
  @action("productFamiliesMetadata")
  listProductFamiliesMetadata is ArmProviderActionSync<
    Response = ProductFamiliesMetadata,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * $skipToken is supported on list of product families metadata, which provides the next page in the list of product families metadata.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OrdersOperationGroup {
  /**
   * List orders at subscription level.
   */
  @autoRoute
  @get
  @action("orders")
  listBySubscription is ArmProviderActionSync<
    Response = OrderResourceList,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * $skipToken is supported on Get list of orders, which provides the next page in the list of orders.
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * $top is supported on fetching list of resources. $top=10 means that the first 10 items in the list will be returned to the API caller.
       */
      @query("$top")
      $top?: int32;
    }
  >;
  /**
   * List orders at resource group level.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EdgeOrder/orders")
  @get
  listByResourceGroup(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * $skipToken is supported on Get list of orders, which provides the next page in the list of orders.
     */
    @query("$skipToken")
    $skipToken?: string,

    /**
     * $top is supported on fetching list of resources. $top=10 means that the first 10 items in the list will be returned to the API caller.
     */
    @query("$top")
    $top?: int32,
  ): ArmResponse<OrderResourceList> | ErrorResponse;
}
@@doc(ProductsAndConfigurationsOperationGroup.listConfigurations::parameters.body,
  "Filters for showing the configurations."
);
@@doc(ProductsAndConfigurationsOperationGroup.listProductFamilies::parameters.body,
  "Filters for showing the product families."
);
