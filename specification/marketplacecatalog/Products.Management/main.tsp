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
  @armResourceList(ProductSummary)
  listByTenant(
    ...ApiVersionParameter,

    @doc("The market in which the product is available.")
    @query
    market?: string,

    @doc("The language to filter by")
    @query
    language?: string,
  ): ArmResponse<ResourceListCustomResult<ProductSummary>> | ErrorResponse;

  /** Lists products for subscription. */
  listBySubscription is ArmListBySubscriptionCustom<
    Products,
    Parameters = {
      @doc("The market in which the product is available.")
      @query
      market?: string;

      @doc("The language to filter by")
      @query
      language?: string;
    },
    Response = ResourceListCustomResult<ProductSummary>
  >;

  /** Lists products for billing account. */
  listByBillingAccount is ArmListByBillingAccount<
    Products,
    Parameters = {
      @doc("The market in which the product is available.")
      @query
      market?: string;

      @doc("The language to filter by")
      @query
      language?: string;
    },
    Response = ResourceListCustomResult<ProductSummary>
  >;

  /** Lists products for billing profile. */
  listByBillingProfile is ArmListByBillingProfile<
    Products,
    Parameters = {
      @doc("The market in which the product is available.")
      @query
      market?: string;

      @doc("The language to filter by")
      @query
      language?: string;
    },
    Response = ResourceListCustomResult<ProductSummary>
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
    includeStopSoldPlans?: boolean,

    @doc("The language to filter by")
    @query
    language?: string,

    @doc("Whether to include hidden plans in the response.")
    @query
    includeHiddenPlans?: boolean,

    @doc("Whether to include service instruction templates in the response.")
    @query
    includeServiceInstructionTemplates?: boolean,
  ): ArmResponse<ProductDetails> | ErrorResponse;

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
    includeStopSoldPlans?: boolean,

    @doc("The language to filter by")
    @query
    language?: string,

    @doc("Whether to include hidden plans in the response.")
    @query
    includeHiddenPlans?: boolean,

    @doc("Whether to include service instruction templates in the response.")
    @query
    includeServiceInstructionTemplates?: boolean,
  ): ArmResponse<ProductDetails> | ErrorResponse;

  /** Gets a product single by billing account. */
  @autoRoute
  @get
  @armResourceRead(ProductSingle)
  getByBillingAccount(
    ...ApiVersionParameter,
    ...BillingAccountIdParameter,
    ...ProductIdParameter,

    @doc("The market in which the product is available.")
    @query
    market: string,

    @doc("Whether to include stop-sold plans in the response.")
    @query
    includeStopSoldPlans?: boolean,

    @doc("The language to filter by")
    @query
    language?: string,

    @doc("Whether to include hidden plans in the response.")
    @query
    includeHiddenPlans?: boolean,

    @doc("Whether to include service instruction templates in the response.")
    @query
    includeServiceInstructionTemplates?: boolean,
  ): ArmResponse<ProductDetails> | ErrorResponse;

  /** Gets a product single by billing profile. */
  @autoRoute
  @get
  @armResourceRead(ProductSingle)
  getByBillingProfile(
    ...ApiVersionParameter,
    ...BillingAccountIdParameter,
    ...BillingProfileIdParameter,
    ...ProductIdParameter,

    @doc("The market in which the product is available.")
    @query
    market: string,

    @doc("Whether to include stop-sold plans in the response.")
    @query
    includeStopSoldPlans?: boolean,

    @doc("The language to filter by")
    @query
    language?: string,

    @doc("Whether to include hidden plans in the response.")
    @query
    includeHiddenPlans?: boolean,

    @doc("Whether to include service instruction templates in the response.")
    @query
    includeServiceInstructionTemplates?: boolean,
  ): ArmResponse<ProductDetails> | ErrorResponse;
}

/** The operation to list products by subscription. */
@listsResource(Resource)
@segmentOf(Resource)
@armResourceList(Resource)
@autoRoute
op ArmListBySubscriptionCustom<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  Parameters extends {} = {},
  Response extends {} = ArmResponse<ResourceListResult<ProductSummary>>,
  Error extends {} = ErrorResponse
> is Azure.ResourceManager.Foundations.ArmReadOperation<
  Azure.ResourceManager.Foundations.SubscriptionScope<Resource> & Parameters,
  Response,
  Error
>;

/** The operation to list products by billing account. */
@listsResource(Resource)
@segmentOf(Resource)
@armResourceList(Resource)
@autoRoute
op ArmListByBillingAccount<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  Parameters extends {} = {},
  Response extends {} = ArmResponse<ResourceListResult<ProductSummary>>,
  Error extends {} = ErrorResponse
> is Azure.ResourceManager.Foundations.ArmReadOperation<
  BillingAccountScope<Resource> & Parameters,
  Response,
  Error
>;

/** The operation to list products by billing account. */
@listsResource(Resource)
@segmentOf(Resource)
@armResourceList(Resource)
@autoRoute
op ArmListByBillingProfile<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  Parameters extends {} = {},
  Response extends {} = ArmResponse<ResourceListResult<ProductSummary>>,
  Error extends {} = ErrorResponse
> is Azure.ResourceManager.Foundations.ArmReadOperation<
  BillingProfileScope<Resource> & Parameters,
  Response,
  Error
>;

/**
 * Parameter model for listing a resource at the billing scope
 * @template Resource The type of the resource.
 */
model BillingAccountScope<Resource extends Azure.ResourceManager.Foundations.Resource>
  is ResourceParentParameters<Resource, BillingAccountBaseParameters>;

/**
 * Parameter model for listing a resource at the billing scope
 * @template Resource The type of the resource.
 */
model BillingProfileScope<Resource extends Azure.ResourceManager.Foundations.Resource>
  is ResourceParentParameters<Resource, BillingProfileBaseParameters>;

/**
 * The static parameters for a billing based resource
 */
model BillingAccountBaseParameters
  is Azure.ResourceManager.Foundations.TenantBaseParameters {
  ...BillingAccountIdParameter;
}

/**
 * The static parameters for a billing based resource
 */
model BillingProfileBaseParameters
  is Azure.ResourceManager.Foundations.TenantBaseParameters {
  ...BillingAccountIdParameter;
  ...BillingProfileIdParameter;
}

/**
 * The default billing account id parameter type.
 */
model BillingAccountIdParameter {
  /** The ID of the target billing account. */
  @path
  @segment("providers/Microsoft.Billing/billingAccounts")
  @minLength(1)
  billingAccountId: string;
}

/**
 * The default billing account id parameter type.
 */
model BillingProfileIdParameter {
  /** The ID of the target billing account. */
  @path
  @segment("billingProfiles")
  @minLength(1)
  billingProfileId: string;
}
