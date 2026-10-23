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
interface Skus {
  /** Lists SKUs for billing account. */
  @list
  listByBillingAccount is ArmListByBillingAccount<
    Sku,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingAccount.serviceFamily retains the serviceFamily query parameter; preserve wire compatibility."
      @doc("The service family to filter by, such as 'Compute'.")
      @query
      serviceFamily: string;

      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingAccount.service retains the service query parameter; preserve wire compatibility."
      @doc("The service to filter by, such as 'Virtual Machines'.")
      @query
      service: string;

      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingAccount.language retains the language query parameter; preserve wire compatibility."
      @doc(LanguageParameterDescription)
      @query
      language?: string;

      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingAccount.locations retains the locations query parameter; preserve wire compatibility."
      @doc(LocationsParameterDescription)
      @query
      locations?: string[];

      @doc(FilterOdataParameterDescription)
      @query
      $filter?: string;

      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingAccount.$select retains the $select query parameter; preserve wire compatibility."
      @doc(SelectOdataParameterDescription)
      @query
      $select?: string;

      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingAccount.$expand retains the $expand query parameter; preserve wire compatibility."
      @doc(ExpandOdataParameterDescription)
      @query
      $expand?: string;

      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingAccount.$orderBy retains the $orderBy query parameter; preserve wire compatibility."
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
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingProfile.serviceFamily retains the serviceFamily query parameter; preserve wire compatibility."
      @doc("The service family to filter by, such as 'Compute'.")
      @query
      serviceFamily: string;

      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingProfile.service retains the service query parameter; preserve wire compatibility."
      @doc("The service to filter by, such as 'Virtual Machines'.")
      @query
      service: string;

      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingProfile.language retains the language query parameter; preserve wire compatibility."
      @doc(LanguageParameterDescription)
      @query
      language?: string;

      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingProfile.locations retains the locations query parameter; preserve wire compatibility."
      @doc(LocationsParameterDescription)
      @query
      locations?: string[];

      @doc(FilterOdataParameterDescription)
      @query
      $filter?: string;

      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingProfile.$select retains the $select query parameter; preserve wire compatibility."
      @doc(SelectOdataParameterDescription)
      @query
      $select?: string;

      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingProfile.$expand retains the $expand query parameter; preserve wire compatibility."
      @doc(ExpandOdataParameterDescription)
      @query
      $expand?: string;

      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingProfile.$orderBy retains the $orderBy query parameter; preserve wire compatibility."
      @doc(OrderByOdataParameterDescription)
      @query
      $orderBy?: string;
    },
    Response = ResourceListResult<SkuSummary>
  >;

  /**
   * Gets a single SKU with availabilities for the given billing account.
   *
   * Returns full SKU details (including availabilities) for the SKU identified by
   * the composite `productId/skuId`, scoped to the given billing account. The caller
   * must have billing account permissions. Supports both EA (legacy) and Modern (MCA)
   * billing account ID formats.
   */
  @autoRoute
  @get
  @armResourceRead(Sku)
  getByBillingAccount(
    ...ApiVersionParameter,
    ...BillingAccountIdParameter,
    ...SkuIdParameter,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Existing getByBillingAccount.language retains the language query parameter; preserve wire compatibility."
    @doc(LanguageParameterDescription)
    @query
    language?: string,

    #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing getByBillingAccount.includeStopSold has a boolean wire value; preserve the published property contract."
    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Existing getByBillingAccount.includeStopSold retains the includeStopSold query parameter; preserve wire compatibility."
    @doc(IncludeStopSoldParameterDescription)
    @query
    includeStopSold?: boolean = false,

    #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing getByBillingAccount.includeFutureAvailabilities has a boolean wire value; preserve the published property contract."
    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Existing getByBillingAccount.includeFutureAvailabilities retains the includeFutureAvailabilities query parameter; preserve wire compatibility."
    @doc(IncludeFutureAvailabilitiesParameterDescription)
    @query
    includeFutureAvailabilities?: boolean = false,
  ): ArmResponse<SkuDetails> | ErrorResponse;

  /**
   * Gets a single SKU with availabilities for the given billing account and billing profile.
   *
   * Same as the billing-account-only variant, but additionally scopes the hydration
   * claims to a specific billing profile. Only meaningful for Modern (MCA) billing
   * accounts; for EA billing accounts the billing profile is ignored.
   */
  @autoRoute
  @get
  @armResourceRead(Sku)
  getByBillingProfile(
    ...ApiVersionParameter,
    ...BillingAccountIdParameter,
    ...BillingProfileIdParameter,
    ...SkuIdParameter,

    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Existing getByBillingProfile.language retains the language query parameter; preserve wire compatibility."
    @doc(LanguageParameterDescription)
    @query
    language?: string,

    #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing getByBillingProfile.includeStopSold has a boolean wire value; preserve the published property contract."
    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Existing getByBillingProfile.includeStopSold retains the includeStopSold query parameter; preserve wire compatibility."
    @doc(IncludeStopSoldParameterDescription)
    @query
    includeStopSold?: boolean = false,

    #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing getByBillingProfile.includeFutureAvailabilities has a boolean wire value; preserve the published property contract."
    #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Existing getByBillingProfile.includeFutureAvailabilities retains the includeFutureAvailabilities query parameter; preserve wire compatibility."
    @doc(IncludeFutureAvailabilitiesParameterDescription)
    @query
    includeFutureAvailabilities?: boolean = false,
  ): ArmResponse<SkuDetails> | ErrorResponse;
}

/** The operation to list SKUs by billing account. */
#suppress "@azure-tools/typespec-azure-resource-manager/list-operation-missing-pageable" "Existing ArmListByBillingAccount retains its response and SDK paging behavior; preserve published compatibility."
@listsResource(Resource)
@segmentOf(Resource)
@armResourceList(Resource)
@autoRoute
op ArmListByBillingAccount<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  Parameters extends {} = {},
  Response extends {} = ArmResponse<ResourceListResult<SkuSummary>>,
  Error extends {} = ErrorResponse
> is Azure.ResourceManager.Foundations.ArmReadOperation<
  BillingAccountScope<Resource> & Parameters,
  Response,
  Error
>;

/** The operation to list SKUs by billing profile. */
#suppress "@azure-tools/typespec-azure-resource-manager/list-operation-missing-pageable" "Existing ArmListByBillingProfile retains its response and SDK paging behavior; preserve published compatibility."
@listsResource(Resource)
@segmentOf(Resource)
@armResourceList(Resource)
@autoRoute
op ArmListByBillingProfile<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  Parameters extends {} = {},
  Response extends {} = ArmResponse<ResourceListResult<SkuSummary>>,
  Error extends {} = ErrorResponse
> is Azure.ResourceManager.Foundations.ArmReadOperation<
  BillingProfileScope<Resource> & Parameters,
  Response,
  Error
>;

/**
 * Parameter model for listing a resource at the billing account scope.
 * @template Resource The type of the resource.
 */
model BillingAccountScope<Resource extends Azure.ResourceManager.Foundations.Resource> is ResourceParentParameters<
  Resource,
  BillingAccountBaseParameters
>;

/**
 * Parameter model for listing a resource at the billing profile scope.
 * @template Resource The type of the resource.
 */
model BillingProfileScope<Resource extends Azure.ResourceManager.Foundations.Resource> is ResourceParentParameters<
  Resource,
  BillingProfileBaseParameters
>;

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
