import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./product.tsp";

using Http;
using Rest;
using Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.Marketplace Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.Marketplace management service" })
@versioned(Versions)
namespace Microsoft.Marketplace;

/** The available API versions. */
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_05_01: "2025-05-01",
}

/** Product resource */
model ProductListing is ProxyResource<ProductSummary> {
  ...ResourceNameParameter<ProductListing>;
}

/** Product resource */
model ProductSingle is ProxyResource<ProductDetails> {
  ...ResourceNameParameter<ProductSingle>;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations(ProductListing)
interface ProductListings {
  /** Lists products for tenant. */
  @route("/providers/Microsoft.Marketplace/products")
  @get
  @armResourceRead(ProductListing)
  listByTenant(
    ...ApiVersionParameter,

    @doc("The market in which the product is available.")
    @query
    market: string,

    @doc("The language to filter by")
    @query
    language: string,
  ): ArmResponse<ProductListing> | ErrorResponse;

  /** Lists products by subscription. */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Marketplace/products")
  @get
  @armResourceRead(ProductListing)
  getBySubscription(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @doc("The market in which the product is available.")
    @query
    market: string,

    @doc("The language to filter by")
    @query
    language: string,
  ): ArmResponse<ProductListing> | ErrorResponse;
}

@armResourceOperations(ProductSingle)
interface ProductSingles {
  /** Gets a product single by tenant. */
  @route("/providers/Microsoft.Marketplace/products/{productId}")
  @get
  @armResourceRead(ProductSingle)
  getByTenant(
    ...ApiVersionParameter,

    @doc("The name of the product single.")
    @path
    productId: string,

    @doc("The market in which the product is available.")
    @query
    market: string,

    @doc("Whether to include stop-sold plans in the response.")
    @query
    includeStopSoldPlans: boolean,

    @doc("The language to filter by")
    @query
    language: string,

    @doc("Whether to include hidden plans in the response.")
    @query
    includeHiddenPlans: boolean,

    @doc("Whether to include service instruction templates in the response.")
    @query
    includeServiceInstructionTemplates: boolean,
  ): ArmResponse<ProductSingle> | ErrorResponse;

  /** Gets a product single by subscription. */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Marketplace/productSingles/{productId}")
  @get
  @armResourceRead(ProductSingle)
  getBySubscription(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @doc("The name of the product single.")
    @path
    productId: string,

    @doc("The market in which the product is available.")
    @query
    market: string,

    @doc("Whether to include stop-sold plans in the response.")
    @query
    includeStopSoldPlans: boolean,

    @doc("The language to filter by")
    @query
    language: string,

    @doc("Whether to include hidden plans in the response.")
    @query
    includeHiddenPlans: boolean,

    @doc("Whether to include service instruction templates in the response.")
    @query
    includeServiceInstructionTemplates: boolean,
  ): ArmResponse<ProductSingle> | ErrorResponse;
}
