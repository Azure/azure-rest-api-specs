import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./sku.tsp";
import "./parameters.tsp";

using Http;
using Rest;
using Versioning;
using Azure.ResourceManager;

/** Microsoft.Marketplace Resource Provider management API for SKUs. */
@armProviderNamespace
@service(#{ title: "Microsoft.Marketplace SKU management service" })
@versioned(Versions)
namespace Microsoft.Marketplace;

/** The available API versions. */
enum Versions {
  /** The 2025-05-01 api version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_05_01: "2025-05-01",
}

/** SKU resource */
model Sku is ProxyResource<SkuSummary> {
  ...ResourceNameParameter<Sku>;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations(Sku)
interface SkuList {
  /** Lists SKUs for tenant. */
  @route("/providers/Microsoft.Marketplace/skus")
  @get
  @list
  @armResourceList(SkuSummary)
  listByTenant(
    ...ApiVersionParameter,

    @doc("The service family to filter by, such as 'Compute'.")
    @query
    serviceFamily: string,

    @doc("The service to filter by, such as 'Virtual Machines'.")
    @query
    service: string,

    @doc(MarketParameterDescription)
    @query
    market?: string,

    @doc(LanguageParameterDescription)
    @query
    language?: string,

    @doc(LocationsParameterDescription)
    @query
    locations?: string[],

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
  ): ArmResponse<ResourceListResult<SkuSummary>> | DiscoveryErrorPayload;

  /** Lists SKUs for subscription. */
  @list
  listBySubscription is ArmListBySubscriptionCustom<
    Sku,
    Parameters = {
      @doc("The service family to filter by, such as 'Compute'.")
      @query
      serviceFamily: string;

      @doc("The service to filter by, such as 'Virtual Machines'.")
      @query
      service: string;

      @doc(LanguageParameterDescription)
      @query
      language?: string;

      @doc(LocationsParameterDescription)
      @query
      locations?: string[];

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
    },
    Response = ResourceListResult<SkuSummary>
  >;

  /** Lists SKUs for billing account. */
  @list
  listByBillingAccount is ArmListByBillingAccount<
    Sku,
    Parameters = {
      @doc("The service family to filter by, such as 'Compute'.")
      @query
      serviceFamily: string;

      @doc("The service to filter by, such as 'Virtual Machines'.")
      @query
      service: string;

      @doc(LanguageParameterDescription)
      @query
      language?: string;

      @doc(LocationsParameterDescription)
      @query
      locations?: string[];

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
    },
    Response = ResourceListResult<SkuSummary>
  >;

  /** Lists SKUs for billing profile. */
  @list
  listByBillingProfile is ArmListByBillingProfile<
    Sku,
    Parameters = {
      @doc("The service family to filter by, such as 'Compute'.")
      @query
      serviceFamily: string;

      @doc("The service to filter by, such as 'Virtual Machines'.")
      @query
      service: string;

      @doc(LanguageParameterDescription)
      @query
      language?: string;

      @doc(LocationsParameterDescription)
      @query
      locations?: string[];

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
    },
    Response = ResourceListResult<SkuSummary>
  >;
}

@armResourceOperations(Sku)
interface SkuGet {
  /** Gets a single product by tenant. */
  @autoRoute
  @get
  @armResourceRead(Sku)
  getByTenant(
    ...ApiVersionParameter,
    ...SkuIdParameter,

    @doc(MarketSingleParameterDescription)
    @query
    market: string,

    @doc(LanguageParameterDescription)
    @query
    language?: string,
  ): ArmResponse<Sku> | DiscoveryErrorPayload;

  /** Gets a single product by subscription. */
  @autoRoute
  @get
  @armResourceRead(Sku)
  getBySubscription(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...SkuIdParameter,

    @doc(LanguageParameterDescription)
    @query
    language?: string,
  ): ArmResponse<Sku> | DiscoveryErrorPayload;

  /** Gets a single product by billing account. */
  @autoRoute
  @get
  @armResourceRead(Sku)
  getByBillingAccount(
    ...ApiVersionParameter,
    ...BillingAccountIdParameter,
    ...SkuIdParameter,

    @doc(LanguageParameterDescription)
    @query
    language?: string,
  ): ArmResponse<Sku> | DiscoveryErrorPayload;

  /** Gets a single product by billing profile. */
  @autoRoute
  @get
  @armResourceRead(Sku)
  getByBillingProfile(
    ...ApiVersionParameter,
    ...BillingAccountIdParameter,
    ...BillingProfileIdParameter,
    ...SkuIdParameter,

    @doc(LanguageParameterDescription)
    @query
    language?: string,
  ): ArmResponse<Sku> | DiscoveryErrorPayload;
}

/** The operation to list SKUs by subscription. */
@listsResource(Resource)
@segmentOf(Resource)
@armResourceList(Resource)
@autoRoute
op ArmListBySubscriptionCustom<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  Parameters extends {} = {},
  Response extends {} = ArmResponse<ResourceListResult<SkuSummary>>,
  Error extends {} = DiscoveryErrorPayload
> is Azure.ResourceManager.Foundations.ArmReadOperation<
  Azure.ResourceManager.Foundations.SubscriptionScope<Resource> & Parameters,
  Response,
  Error
>;

/** The operation to list SKUs by billing account. */
@listsResource(Resource)
@segmentOf(Resource)
@armResourceList(Resource)
@autoRoute
op ArmListByBillingAccount<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  Parameters extends {} = {},
  Response extends {} = ArmResponse<ResourceListResult<SkuSummary>>,
  Error extends {} = DiscoveryErrorPayload
> is Azure.ResourceManager.Foundations.ArmReadOperation<
  BillingAccountScope<Resource> & Parameters,
  Response,
  Error
>;

/** The operation to list SKUs by billing profile. */
@listsResource(Resource)
@segmentOf(Resource)
@armResourceList(Resource)
@autoRoute
op ArmListByBillingProfile<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  Parameters extends {} = {},
  Response extends {} = ArmResponse<ResourceListResult<SkuSummary>>,
  Error extends {} = DiscoveryErrorPayload
> is Azure.ResourceManager.Foundations.ArmReadOperation<
  BillingProfileScope<Resource> & Parameters,
  Response,
  Error
>;

/**
 * Parameter model for listing a resource at the billing account scope.
 * @template Resource The type of the resource.
 */
model BillingAccountScope<Resource extends Azure.ResourceManager.Foundations.Resource>
  is ResourceParentParameters<Resource, BillingAccountBaseParameters>;

/**
 * Parameter model for listing a resource at the billing profile scope.
 * @template Resource The type of the resource.
 */
model BillingProfileScope<Resource extends Azure.ResourceManager.Foundations.Resource>
  is ResourceParentParameters<Resource, BillingProfileBaseParameters>;

/**
 * The static parameters for a billing account based resource.
 */
model BillingAccountBaseParameters
  is Azure.ResourceManager.Foundations.TenantBaseParameters {
  ...BillingAccountIdParameter;
}

/**
 * The static parameters for a billing profile based resource.
 */
model BillingProfileBaseParameters
  is Azure.ResourceManager.Foundations.TenantBaseParameters {
  ...BillingAccountIdParameter;
  ...BillingProfileIdParameter;
}

/** Error payload returned by Marketplace Discovery APIs. */
@error
model DiscoveryErrorPayload {
  /** The error details object. */
  error: DiscoveryErrorDetails;
}

/** Error details returned in DiscoveryErrorPayload. */
model DiscoveryErrorDetails {
  /** The error code. */
  code: string;

  /** The error message. */
  message: string;
}
