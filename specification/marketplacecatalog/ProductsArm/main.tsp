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
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_05_01: "2025-05-01",
}

/** Product resource */
model Products is ProxyResource<ProductSummary> {
  ...ResourceNameParameter<Products>;
}

/** Product resource */
model ProductSingle is ProxyResource<ProductDetails> {
  ...ResourceNameParameter<ProductSingle>;
}

/** Product id path parameter */
model ProductIdParameter {
  /** The ID of the product */
  @path
  @segment("providers/Microsoft.Marketplace/products")
  @minLength(1)
  productId: string;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations(Products)
interface ProductList {
  /** Lists products for tenant. */
  @route("/providers/Microsoft.Marketplace/products")
  @get
  @armResourceRead(Products)
  listByTenant(
    ...ApiVersionParameter,

    @doc("The market in which the product is available.")
    @query
    market: string,

    @doc("The language to filter by")
    @query
    language: string,
  ): ArmResponse<ResourceListResult<Products>> | ErrorResponse;

  /** Lists products for subscription. */
  listBySubscription is ArmListBySubscription<
    Products,
    Parameters = {
      @doc("The market in which the product is available.")
      @query
      market: string;

      @doc("The language to filter by")
      @query
      language: string;
    }
  >;
}

@armResourceOperations(ProductSingle)
interface ProductGet {
  /** Gets a product single by tenant. */
  @autoRoute
  @get
  @armResourceRead(ProductSingle)
  getByTenant(
    ...ApiVersionParameter,
    ...ProductIdParameter,

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
  @autoRoute
  @get
  @armResourceRead(ProductSingle)
  getBySubscription(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ProductIdParameter,

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
