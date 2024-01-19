import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.EdgeOrder;

@doc("This method provides the list of product families for the given subscription.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.EdgeOrder/listProductFamilies")
@post
op listProductFamilies is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription.")
    @minLength(1)
    @path
    subscriptionId: string;

    @doc("$expand is supported on configurations parameter for product, which provides details on the configurations for the product.")
    @query("$expand")
    $expand?: string;

    @doc("$skipToken is supported on list of product families, which provides the next page in the list of product families.")
    @query("$skipToken")
    $skipToken?: string;

    @doc("Filters for showing the product families.")
    @body
    productFamiliesRequest: ProductFamiliesRequest;
  },
  ProductFamilies
>;

@doc("This method provides the list of configurations for the given product family, product line and product under subscription.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.EdgeOrder/listConfigurations")
@post
op listConfigurations is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription.")
    @minLength(1)
    @path
    subscriptionId: string;

    @doc("$skipToken is supported on list of configurations, which provides the next page in the list of configurations.")
    @query("$skipToken")
    $skipToken?: string;

    @doc("Filters for showing the configurations.")
    @body
    configurationsRequest: ConfigurationsRequest;
  },
  ProductConfigurations
>;

@doc("This method provides the list of product families metadata for the given subscription.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.EdgeOrder/productFamiliesMetadata")
@post
op listProductFamiliesMetadata is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription.")
    @minLength(1)
    @path
    subscriptionId: string;

    @doc("$skipToken is supported on list of product families metadata, which provides the next page in the list of product families metadata.")
    @query("$skipToken")
    $skipToken?: string;
  },
  ProductFamiliesMetadata
>;

@doc("Lists order at subscription level.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.EdgeOrder/orders")
@get
op listOrderAtSubscriptionLevel is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription.")
    @minLength(1)
    @path
    subscriptionId: string;

    @doc("$skipToken is supported on Get list of order, which provides the next page in the list of order.")
    @query("$skipToken")
    $skipToken?: string;
  },
  OrderResourceList
>;

@doc("Lists order at resource group level.")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EdgeOrder/orders")
@get
op listOrderAtResourceGroupLevel is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription.")
    @minLength(1)
    @path
    subscriptionId: string;

    @doc("The name of the resource group. The name is case insensitive.")
    @maxLength(90)
    @minLength(1)
    @path
    resourceGroupName: string;

    @doc("$skipToken is supported on Get list of order, which provides the next page in the list of order.")
    @query("$skipToken")
    $skipToken?: string;
  },
  OrderResourceList
>;
