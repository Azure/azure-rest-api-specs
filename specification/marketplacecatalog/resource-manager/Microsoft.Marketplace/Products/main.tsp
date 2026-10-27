import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./product.tsp";
import "./parameters.tsp";

using Http;
using Rest;
using Versioning;
using Azure.ResourceManager;

/** Microsoft.Marketplace Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.Marketplace management service" })
@versioned(Versions)
namespace Microsoft.Marketplace;

/** The available API versions. */
enum Versions {
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

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations(Products)
interface ProductList {
  /** Lists products for tenant. */
  @route("/providers/Microsoft.Marketplace/products")
  @get
  @armResourceList(ProductSummary)
  listByTenant(
    ...ApiVersionParameter,

    @doc(MarketParameterDescription)
    @query
    market?: string,

    @doc(LanguageParameterDescription)
    @query
    language?: string = "en",

    @doc(ExcludePublicParameterDescription)
    @query
    excludePublicOffersAndPublicPlans?: boolean = false,

    @doc(FilterOdataParameterDescription)
    @query
    $filter?: string,

    @doc(SelectOdataParameterDescription)
    @query
    $select?: string,

    @doc(ExpandOdataParameterDescription)
    @query
    $expand?: string,

    @doc(OrderByOdataParameterDescription)
    @query
    $orderBy?: string,

    @doc(SearchParameterDescription)
    @query
    $search?: string,
  ):
    | ArmResponse<ResourceListCustomResult<ProductSummary>>
    | DiscoveryErrorPayload;

  /** Lists products for subscription. */
  listBySubscription is ArmListBySubscriptionCustom<
    Products,
    Parameters = {
      @doc(LanguageParameterDescription)
      @query
      language?: string = "en";

      @doc(ExcludePublicParameterDescription)
      @query
      excludePublicOffersAndPublicPlans?: boolean = false;

      @doc(FilterOdataParameterDescription)
      @query
      $filter?: string;

      @doc(SelectOdataParameterDescription)
      @query
      $select?: string;

      @doc(ExpandOdataParameterDescription)
      @query
      $expand?: string;

      @doc(OrderByOdataParameterDescription)
      @query
      $orderBy?: string;

      @doc(SearchParameterDescription)
      @query
      $search?: string;
    },
    Response = ResourceListCustomResult<ProductSummary>
  >;

  /** Lists products for billing account. */
  listByBillingAccount is ArmListByBillingAccount<
    Products,
    Parameters = {
      @doc(LanguageParameterDescription)
      @query
      language?: string = "en";

      @doc(ExcludePublicParameterDescription)
      @query
      excludePublicOffersAndPublicPlans?: boolean = false;

      @doc(LocationsarameterDescription)
      @query
      locations?: string;

      @doc(FilterOdataParameterDescription)
      @query
      $filter?: string;

      @doc(SelectOdataParameterDescription)
      @query
      $select?: string;

      @doc(ExpandOdataParameterDescription)
      @query
      $expand?: string;

      @doc(OrderByOdataParameterDescription)
      @query
      $orderBy?: string;

      @doc(SearchParameterDescription)
      @query
      $search?: string;
    },
    Response = ResourceListCustomResult<ProductSummary>
  >;

  /** Lists products for billing profile. */
  listByBillingProfile is ArmListByBillingProfile<
    Products,
    Parameters = {
      @doc(LanguageParameterDescription)
      @query
      language?: string = "en";

      @doc(ExcludePublicParameterDescription)
      @query
      excludePublicOffersAndPublicPlans?: boolean = false;

      @doc(LocationsarameterDescription)
      @query
      locations?: string;

      @doc(FilterOdataParameterDescription)
      @query
      $filter?: string;

      @doc(SelectOdataParameterDescription)
      @query
      $select?: string;

      @doc(ExpandOdataParameterDescription)
      @query
      $expand?: string;

      @doc(OrderByOdataParameterDescription)
      @query
      $orderBy?: string;

      @doc(SearchParameterDescription)
      @query
      $search?: string;
    },
    Response = ResourceListCustomResult<ProductSummary>
  >;
}

@armResourceOperations(ProductSingle)
interface ProductGet {
  /** Gets a single product by tenant. */
  @autoRoute
  @get
  @armResourceRead(ProductSingle)
  getByTenant(
    ...ApiVersionParameter,
    ...ProductIdParameter,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByTenant.market retains the market query parameter; preserve wire compatibility."
    @doc(MarketSingleParameterDescription)
    @query
    market: string,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByTenant.includeStopSoldPlans retains the includeStopSoldPlans query parameter; preserve wire compatibility."
    @doc(IncludeStopSoldPlansParameterDescription)
    @query
    includeStopSoldPlans?: boolean = false,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByTenant.language retains the language query parameter; preserve wire compatibility."
    @doc(LanguageParameterDescription)
    @query
    language?: string,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByTenant.pricingAudience retains the pricingAudience query parameter; preserve wire compatibility."
    @doc(PricingAudienceParameterDescription)
    @query
    pricingAudience?: string,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByTenant.includeHiddenPlans retains the includeHiddenPlans query parameter; preserve wire compatibility."
    @doc(IncludeHiddenPlansParameterDescription)
    @query
    includeHiddenPlans?: boolean = false,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByTenant.includeServiceInstructionTemplates retains the includeServiceInstructionTemplates query parameter; preserve wire compatibility."
    @doc(IncludeServiceInstructionTemplatesParameterDescription)
    @query
    includeServiceInstructionTemplates?: boolean = false,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByTenant.planId retains the planId query parameter; preserve wire compatibility."
    @doc(PlanIdParameterDescription)
    @query
    planId?: string,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByTenant.skuId retains the skuId query parameter; preserve wire compatibility."
    @doc(SkuIdParameterDescription)
    @query
    skuId?: string,
  ): ArmResponse<ProductDetails> | DiscoveryErrorPayload;

  /** Gets a single product by subscription. */
  @autoRoute
  @get
  @armResourceRead(ProductSingle)
  getBySubscription(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ProductIdParameter,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getBySubscription.includeStopSoldPlans retains the includeStopSoldPlans query parameter; preserve wire compatibility."
    @doc(IncludeStopSoldPlansParameterDescription)
    @query
    includeStopSoldPlans?: boolean,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getBySubscription.language retains the language query parameter; preserve wire compatibility."
    @doc(LanguageParameterDescription)
    @query
    language?: string,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getBySubscription.includeHiddenPlans retains the includeHiddenPlans query parameter; preserve wire compatibility."
    @doc(IncludeHiddenPlansParameterDescription)
    @query
    includeHiddenPlans?: boolean = false,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getBySubscription.includeServiceInstructionTemplates retains the includeServiceInstructionTemplates query parameter; preserve wire compatibility."
    @doc(IncludeServiceInstructionTemplatesParameterDescription)
    @query
    includeServiceInstructionTemplates?: boolean = false,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getBySubscription.planId retains the planId query parameter; preserve wire compatibility."
    @doc(PlanIdParameterDescription)
    @query
    planId?: string,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getBySubscription.skuId retains the skuId query parameter; preserve wire compatibility."
    @doc(SkuIdParameterDescription)
    @query
    skuId?: string,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getBySubscription.lookUpOfferInTenantLevel retains the lookUpOfferInTenantLevel query parameter; preserve wire compatibility."
    @doc(LookUpOfferInTenantLevelParameterDescription)
    @query
    lookUpOfferInTenantLevel?: boolean = false,
  ): ArmResponse<ProductDetails> | DiscoveryErrorPayload;

  /** Gets a single product by billing account. */
  @autoRoute
  @get
  @armResourceRead(ProductSingle)
  getByBillingAccount(
    ...ApiVersionParameter,
    ...BillingAccountIdParameter,
    ...ProductIdParameter,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByBillingAccount.includeStopSoldPlans retains the includeStopSoldPlans query parameter; preserve wire compatibility."
    @doc(IncludeStopSoldPlansParameterDescription)
    @query
    includeStopSoldPlans?: boolean,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByBillingAccount.language retains the language query parameter; preserve wire compatibility."
    @doc(LanguageParameterDescription)
    @query
    language?: string,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByBillingAccount.includeHiddenPlans retains the includeHiddenPlans query parameter; preserve wire compatibility."
    @doc(IncludeHiddenPlansParameterDescription)
    @query
    includeHiddenPlans?: boolean = false,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByBillingAccount.includeServiceInstructionTemplates retains the includeServiceInstructionTemplates query parameter; preserve wire compatibility."
    @doc(IncludeServiceInstructionTemplatesParameterDescription)
    @query
    includeServiceInstructionTemplates?: boolean = false,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByBillingAccount.planId retains the planId query parameter; preserve wire compatibility."
    @doc(PlanIdParameterDescription)
    @query
    planId?: string,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByBillingAccount.skuId retains the skuId query parameter; preserve wire compatibility."
    @doc(SkuIdParameterDescription)
    @query
    skuId?: string,
  ): ArmResponse<ProductDetails> | DiscoveryErrorPayload;

  /** Gets a single product by billing profile. */
  @autoRoute
  @get
  @armResourceRead(ProductSingle)
  getByBillingProfile(
    ...ApiVersionParameter,
    ...BillingAccountIdParameter,
    ...BillingProfileIdParameter,
    ...ProductIdParameter,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByBillingProfile.includeStopSoldPlans retains the includeStopSoldPlans query parameter; preserve wire compatibility."
    @doc(IncludeStopSoldPlansParameterDescription)
    @query
    includeStopSoldPlans?: boolean,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByBillingProfile.language retains the language query parameter; preserve wire compatibility."
    @doc(LanguageParameterDescription)
    @query
    language?: string,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByBillingProfile.includeHiddenPlans retains the includeHiddenPlans query parameter; preserve wire compatibility."
    @doc(IncludeHiddenPlansParameterDescription)
    @query
    includeHiddenPlans?: boolean = false,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByBillingProfile.includeServiceInstructionTemplates retains the includeServiceInstructionTemplates query parameter; preserve wire compatibility."
    @doc(IncludeServiceInstructionTemplatesParameterDescription)
    @query
    includeServiceInstructionTemplates?: boolean = false,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByBillingProfile.planId retains the planId query parameter; preserve wire compatibility."
    @doc(PlanIdParameterDescription)
    @query
    planId?: string,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing getByBillingProfile.skuId retains the skuId query parameter; preserve wire compatibility."
    @doc(SkuIdParameterDescription)
    @query
    skuId?: string,
  ): ArmResponse<ProductDetails> | DiscoveryErrorPayload;
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
  Error extends {} = DiscoveryErrorPayload
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
  Error extends {} = DiscoveryErrorPayload
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
  Error extends {} = DiscoveryErrorPayload
> is Azure.ResourceManager.Foundations.ArmReadOperation<
  BillingProfileScope<Resource> & Parameters,
  Response,
  Error
>;

/**
 * Parameter model for listing a resource at the billing scope
 * @template Resource The type of the resource.
 */
model BillingAccountScope<Resource extends Azure.ResourceManager.Foundations.Resource> is ResourceParentParameters<
  Resource,
  BillingAccountBaseParameters
>;

/**
 * Parameter model for listing a resource at the billing scope
 * @template Resource The type of the resource.
 */
model BillingProfileScope<Resource extends Azure.ResourceManager.Foundations.Resource> is ResourceParentParameters<
  Resource,
  BillingProfileBaseParameters
>;

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

// Error payload definitions
@doc("Error payload returned by Marketplace Discovery APIs")
@error
model DiscoveryErrorPayload {
  @doc("The error details object")
  error: DiscoveryErrorDetails;
}

@doc("Error details returned in DiscoveryErrorPayload")
model DiscoveryErrorDetails {
  @doc("The HTTP error code")
  code: string;

  @doc("The error message")
  message: string;
}
