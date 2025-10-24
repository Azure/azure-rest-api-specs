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

namespace Microsoft.Consumption;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface PriceSheetOperationGroup {
  /**
   * Generates the pricesheet for the provided billing period asynchronously based on the enrollment id
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @action("pricesheets/download")
  @post
  @armResourceCollectionAction
  downloadByBillingAccountPeriod(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string,

    /**
     * Billing Period Name.
     */
    @path
    @segment("billingPeriods")
    billingPeriodName: string,

    ...Azure.ResourceManager.Legacy.Provider,
  ): OperationStatus | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatus>> | CommonTypes.ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface UsageDetailsOperationGroup {
  /**
   * Lists the usage details for the defined scope. Usage details are available via this API only for May 1, 2014 or later.
   *
   * **Note:Microsoft will be retiring the Consumption Usage Details API at some point in the future. We do not recommend that you take a new dependency on this API. Please use the Cost Details API instead. We will notify customers once a date for retirement has been determined.For Learn more,see [Generate Cost Details Report - Create Operation](https://learn.microsoft.com/en-us/rest/api/cost-management/generate-cost-details-report/create-operation?tabs=HTTP)**
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @list
  @get
  @action("usageDetails")
  list is ArmProviderActionSync<
    Response = UsageDetailsListResult | ArmNoContentResponse,
    Scope = ExtensionActionScope,
    Parameters = {
      /**
       * May be used to expand the properties/additionalInfo or properties/meterDetails within a list of usage details. By default, these fields are not included when listing usage details.
       */
      @query("$expand")
      $expand?: string;

      /**
       * May be used to filter usageDetails by properties/resourceGroup, properties/resourceName, properties/resourceId, properties/chargeType, properties/reservationId, properties/publisherType or tags. The filter supports 'eq', 'lt', 'gt', 'le', 'ge', and 'and'. It does not currently support 'ne', 'or', or 'not'. Tag filter is a key value pair string where key and value is separated by a colon (:). PublisherType Filter accepts two values azure and marketplace and it is currently supported for Web Direct Offer Type
       */
      @query("$filter")
      $filter?: string;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skiptoken")
      $skiptoken?: string;

      /**
       * May be used to limit the number of results to the most recent N usageDetails.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Allows to select different type of cost/usage records.
       */
      @query("metric")
      metric?: Metrictype;
    },
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface MarketplacesOperationGroup {
  /**
   * Lists the marketplaces for a scope at the defined scope. Marketplaces are available via this API only for May 1, 2014 or later.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @list
  @get
  @action("marketplaces")
  list is ArmProviderActionSync<
    Response = MarketplacesListResult | ArmNoContentResponse,
    Scope = ExtensionActionScope,
    Parameters = {
      /**
       * May be used to filter marketplaces by properties/usageEnd (Utc time), properties/usageStart (Utc time), properties/resourceGroup, properties/instanceName or properties/instanceId. The filter supports 'eq', 'lt', 'gt', 'le', 'ge', and 'and'. It does not currently support 'ne', 'or', or 'not'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * May be used to limit the number of results to the most recent N marketplaces.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    },
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface TagsOperationGroup {
  /**
   * Get all available tag keys for the defined scope
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @get
  @action("tags")
  get is ArmProviderActionSync<
    Response = TagsResult | ArmNoContentResponse,
    Scope = ExtensionActionScope,
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ChargesOperationGroup {
  /**
   * Lists the charges based for the defined scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @get
  @action("charges")
  list is ArmProviderActionSync<
    Response = ChargesListResult,
    Scope = ExtensionActionScope,
    Parameters = {
      /**
       * Start date
       */
      @query("startDate")
      startDate?: string;

      /**
       * End date
       */
      @query("endDate")
      endDate?: string;

      /**
       * May be used to filter charges by properties/usageEnd (Utc time), properties/usageStart (Utc time). The filter supports 'eq', 'lt', 'gt', 'le', 'ge', and 'and'. It does not currently support 'ne', 'or', or 'not'. Tag filter is a key value pair string where key and value is separated by a colon (:).
       */
      @query("$filter")
      $filter?: string;

      /**
       * May be used to group charges for billingAccount scope by properties/billingProfileId, properties/invoiceSectionId, properties/customerId (specific for Partner Led), or for billingProfile scope by properties/invoiceSectionId.
       */
      @query("$apply")
      $apply?: string;
    },
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface BalancesOperationGroup {
  /**
   * Gets the balances for a scope by billingAccountId. Balances are available via this API only for May 1, 2014 or later.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @get
  @action("balances")
  getByBillingAccount(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string,

    ...Azure.ResourceManager.Legacy.Provider,
  ): Balance | ErrorResponse;
  /**
   * Gets the balances for a scope by billing period and billingAccountId. Balances are available via this API only for May 1, 2014 or later.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @get
  @action("balances")
  getForBillingPeriodByBillingAccount(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string,

    /**
     * Billing Period Name.
     */
    @path
    @segment("billingPeriods")
    billingPeriodName: string,

    ...Azure.ResourceManager.Legacy.Provider,
  ): Balance | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ReservationsSummariesOperationGroup {
  /**
   * Lists the reservations summaries for daily or monthly grain. Note: ARM has a payload size limit of 12MB, so currently callers get 400 when the response size exceeds the ARM limit. In such cases, API call should be made with smaller date ranges.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @list
  @get
  @action("reservationSummaries")
  listByReservationOrder(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Capacity",

    /**
     * Order Id of the reservation
     */
    @path
    @segment("reservationorders")
    reservationOrderId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Can be daily or monthly
     */
    @query("grain")
    grain: Datagrain,

    /**
     * Required only for daily grain. The properties/UsageDate for start date and end date. The filter supports 'le' and  'ge'
     */
    @query("$filter")
    $filter?: string,
  ): ReservationSummariesListResult | ErrorResponse;
  /**
   * Lists the reservations summaries for daily or monthly grain. Note: ARM has a payload size limit of 12MB, so currently callers get 400 when the response size exceeds the ARM limit. In such cases, API call should be made with smaller date ranges.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @list
  @get
  @action("reservationSummaries")
  listByReservationOrderAndReservation(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Capacity",

    /**
     * Order Id of the reservation
     */
    @path
    @segment("reservationorders")
    reservationOrderId: string,

    /**
     * Id of the reservation
     */
    @path
    @segment("reservations")
    reservationId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Can be daily or monthly
     */
    @query("grain")
    grain: Datagrain,

    /**
     * Required only for daily grain. The properties/UsageDate for start date and end date. The filter supports 'le' and  'ge'
     */
    @query("$filter")
    $filter?: string,
  ): ReservationSummariesListResult | ErrorResponse;

  /**
   * Lists the reservations summaries for the defined scope daily or monthly grain. Note: ARM has a payload size limit of 12MB, so currently callers get 400 when the response size exceeds the ARM limit. In such cases, API call should be made with smaller date ranges.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @list
  @get
  @action("reservationSummaries")
  list is ArmProviderActionSync<
    Response = ReservationSummariesListResult,
    Scope = ResourceScopeActionScope,
    Parameters = {
      /**
       * Can be daily or monthly
       */
      @query("grain")
      grain: Datagrain;

      /**
       * Start date. Only applicable when querying with billing profile
       */
      @query("startDate")
      startDate?: string;

      /**
       * End date. Only applicable when querying with billing profile
       */
      @query("endDate")
      endDate?: string;

      /**
       * Required only for daily grain. The properties/UsageDate for start date and end date. The filter supports 'le' and  'ge'. Not applicable when querying with billing profile
       */
      @query("$filter")
      $filter?: string;

      /**
       * Reservation Id GUID. Only valid if reservationOrderId is also provided. Filter to a specific reservation
       */
      @query("reservationId")
      reservationId?: string;

      /**
       * Reservation Order Id GUID. Required if reservationId is provided. Filter to a specific reservation order
       */
      @query("reservationOrderId")
      reservationOrderId?: string;
    },
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ReservationsDetailsOperationGroup {
  /**
   * Lists the reservations details for provided date range. Note: ARM has a payload size limit of 12MB, so currently callers get 400 when the response size exceeds the ARM limit. If the data size is too large, customers may also get 504 as the API timed out preparing the data. In such cases, API call should be made with smaller date ranges or a call to Generate Reservation Details Report API should be made as it is asynchronous and will not run into response size time outs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @list
  @get
  @action("reservationDetails")
  listByReservationOrder(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Capacity",

    /**
     * Order Id of the reservation
     */
    @path
    @segment("reservationorders")
    reservationOrderId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Filter reservation details by date range. The properties/UsageDate for start date and end date. The filter supports 'le' and  'ge'
     */
    @query("$filter")
    $filter: string,
  ): ReservationDetailsListResult | ErrorResponse;
  /**
   * Lists the reservations details for provided date range. Note: ARM has a payload size limit of 12MB, so currently callers get 400 when the response size exceeds the ARM limit. If the data size is too large, customers may also get 504 as the API timed out preparing the data. In such cases, API call should be made with smaller date ranges or a call to Generate Reservation Details Report API should be made as it is asynchronous and will not run into response size time outs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @list
  @get
  @action("reservationDetails")
  listByReservationOrderAndReservation(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Capacity",

    /**
     * Order Id of the reservation
     */
    @path
    @segment("reservationorders")
    reservationOrderId: string,

    /**
     * Id of the reservation
     */
    @path
    @segment("reservations")
    reservationId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Filter reservation details by date range. The properties/UsageDate for start date and end date. The filter supports 'le' and  'ge'
     */
    @query("$filter")
    $filter: string,
  ): ReservationDetailsListResult | ErrorResponse;

  /**
   * Lists the reservations details for provided date range. Note: ARM has a payload size limit of 12MB, so currently callers get 400 when the response size exceeds the ARM limit. If the data size is too large, customers may also get 504 as the API timed out preparing the data. In such cases, API call should be made with smaller date ranges or a call to Generate Reservation Details Report API should be made as it is asynchronous and will not run into response size time outs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @list
  @get
  @action("reservationDetails")
  list is ArmProviderActionSync<
    Response = ReservationDetailsListResult,
    Scope = ResourceScopeActionScope,
    Parameters = {
      /**
       * Start date. Only applicable when querying with billing profile
       */
      @query("startDate")
      startDate?: string;

      /**
       * End date. Only applicable when querying with billing profile
       */
      @query("endDate")
      endDate?: string;

      /**
       * Filter reservation details by date range. The properties/UsageDate for start date and end date. The filter supports 'le' and  'ge'. Not applicable when querying with billing profile
       */
      @query("$filter")
      $filter?: string;

      /**
       * Reservation Id GUID. Only valid if reservationOrderId is also provided. Filter to a specific reservation
       */
      @query("reservationId")
      reservationId?: string;

      /**
       * Reservation Order Id GUID. Required if reservationId is provided. Filter to a specific reservation order
       */
      @query("reservationOrderId")
      reservationOrderId?: string;
    },
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ReservationRecommendationsOperationGroup {
  /**
   * List of recommendations for purchasing reserved instances.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @list
  @get
  @action("reservationRecommendations")
  list is ArmProviderActionSync<
    Response = ReservationRecommendationsListResult | ArmNoContentResponse,
    Scope = ResourceScopeActionScope,
    Parameters = {
      /**
       * May be used to filter reservationRecommendations by: properties/scope with allowed values ['Single', 'Shared'] and default value 'Single'; properties/resourceType with allowed values ['VirtualMachines', 'SQLDatabases', 'PostgreSQL', 'ManagedDisk', 'MySQL', 'RedHat', 'MariaDB', 'RedisCache', 'CosmosDB', 'SqlDataWarehouse', 'SUSELinux', 'AppService', 'BlockBlob', 'AzureDataExplorer', 'VMwareCloudSimple'] and default value 'VirtualMachines'; and properties/lookBackPeriod with allowed values ['Last7Days', 'Last30Days', 'Last60Days'] and default value 'Last7Days'.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ReservationRecommendationDetailsOperationGroup {
  /**
   * Details of a reservation recommendation for what-if analysis of reserved instances.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @get
  @action("reservationRecommendationDetails")
  get(
    ...ApiVersionParameter,

    /**
     * The scope associated with reservation recommendation details operations. This includes '/subscriptions/{subscriptionId}/' for subscription scope, '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resource group scope, /providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for BillingAccount scope, and '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for billingProfile scope
     */
    @path(#{ allowReserved: true })
    @segment("")
    resourceScope: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Scope of the reservation.
     */
    @query("scope")
    scope: Scope,

    /**
     * Used to select the region the recommendation should be generated for.
     */
    @query("region")
    region: string,

    /**
     * Specify length of reservation recommendation term.
     */
    @query("term")
    term: Term,

    /**
     * Filter the time period on which reservation recommendation results are based.
     */
    @query("lookBackPeriod")
    lookBackPeriod: LookBackPeriod,

    /**
     * Filter the products for which reservation recommendation results are generated. Examples: Standard_DS1_v2 (for VM), Premium_SSD_Managed_Disks_P30 (for Managed Disks)
     */
    @query("product")
    product: string,

    /**
     * Used to filter reservation recommendation details by: properties/subscriptionId can be specified for billing account and billing profile paths.
     */
    @query("$filter")
    $filter?: string,
  ): ReservationRecommendationDetailsModel | NoContentResponse | HighCasedErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ReservationTransactionsOperationGroup {
  /**
   * List of transactions for reserved instances on billing account scope. Note: The refund transactions are posted along with its purchase transaction (i.e. in the purchase billing month). For example, The refund is requested in May 2021. This refund transaction will have event date as May 2021 but the billing month as April 2020 when the reservation purchase was made. Note: ARM has a payload size limit of 12MB, so currently callers get 400 when the response size exceeds the ARM limit. In such cases, API call should be made with smaller date ranges.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @list
  @get
  @action("reservationTransactions")
  list(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Filter reservation transactions by date range. The properties/EventDate for start date and end date. The filter supports 'le' and  'ge'. Note: API returns data for the entire start date's and end date's billing month. For example, filter properties/eventDate+ge+2020-01-01+AND+properties/eventDate+le+2020-12-29 will include data for the entire December 2020 month (i.e. will contain records for dates December 30 and 31)
     */
    @query("$filter")
    $filter?: string,

    /**
     * Applies mark up to the transactions if the caller is a partner.
     */
    @query("useMarkupIfPartner")
    useMarkupIfPartner?: boolean,

    /**
     * Preview markup percentage to be applied.
     */
    @query("previewMarkupPercentage")
    previewMarkupPercentage?: decimal,
  ): ReservationTransactionsListResult | ErrorResponse;
  /**
   * List of transactions for reserved instances on billing profile scope. The refund transactions are posted along with its purchase transaction (i.e. in the purchase billing month). For example, The refund is requested in May 2021. This refund transaction will have event date as May 2021 but the billing month as April 2020 when the reservation purchase was made. Note: ARM has a payload size limit of 12MB, so currently callers get 400 when the response size exceeds the ARM limit. In such cases, API call should be made with smaller date ranges.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @list
  @get
  @action("reservationTransactions")
  listByBillingProfile(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string,

    /**
     * Azure Billing Profile ID.
     */
    @path
    @segment("billingProfiles")
    billingProfileId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Filter reservation transactions by date range. The properties/EventDate for start date and end date. The filter supports 'le' and  'ge'. Note: API returns data for the entire start date's and end date's billing month. For example, filter properties/eventDate+ge+2020-01-01+AND+properties/eventDate+le+2020-12-29 will include data for entire December 2020 month (i.e. will contain records for dates December 30 and 31)
     */
    @query("$filter")
    $filter?: string,
  ): ModernReservationTransactionsListResult | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AggregatedCostOperationGroup {
  /**
   * Provides the aggregate cost of a management group and all child management groups by current billing period.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @get
  @action("aggregatedcost")
  getByManagementGroup(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Management",

    /**
     * Order Id of the reservation
     */
    @path
    @segment("managementGroups")
    managementGroupId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Required only for daily grain. The properties/UsageDate for start date and end date. The filter supports 'le' and  'ge'
     */
    @query("$filter")
    $filter?: string,
  ): ManagementGroupAggregatedCostResult | ErrorResponse;
  /**
   * Provides the aggregate cost of a management group and all child management groups by specified billing period
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @get
  @action("aggregatedCost")
  getForBillingPeriodByManagementGroup(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    providerNamespace: "Microsoft.Management",

    /**
     * Order Id of the reservation
     */
    @path
    @segment("managementGroups")
    managementGroupId: string,

    /** the provider namespace */
    @path
    @segment("providers")
    billingproviderNamespace: "Microsoft.Billing",

    /**
     * Billing Period Name.
     */
    @path
    @segment("billingPeriods")
    billingPeriodName: string,

    ...Azure.ResourceManager.Legacy.Provider,
  ): ManagementGroupAggregatedCostResult | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface EventsOperationGroup {
  /**
   * Lists the events that decrements Azure credits or Microsoft Azure consumption commitment for a billing account or a billing profile for a given start and end date.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @list
  @get
  @action("events")
  listByBillingProfile(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string,

    /**
     * Azure Billing Profile ID.
     */
    @path
    @segment("billingProfiles")
    billingProfileId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Start date
     */
    @query("startDate")
    startDate: string,

    /**
     * End date
     */
    @query("endDate")
    endDate: string,
  ): Events | ErrorResponse;

  /**
   * Lists the events that decrements Azure credits or Microsoft Azure consumption commitment for a billing account or a billing profile for a given start and end date.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @list
  @get
  @action("events")
  listByBillingAccount(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * May be used to filter the events by lotId, lotSource etc. The filter supports 'eq', 'lt', 'gt', 'le', 'ge', and 'and'. It does not currently support 'ne', 'or', or 'not'. Tag filter is a key value pair string where key and value is separated by a colon (:).
     */
    @query("$filter")
    $filter?: string,
  ): Events | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface LotsOperationGroup {
  /**
   * Lists all Azure credits for a billing account or a billing profile. The API is only supported for Microsoft Customer Agreements (MCA) billing accounts.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @list
  @get
  @action("lots")
  listByBillingProfile(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string,

    /**
     * Azure Billing Profile ID.
     */
    @path
    @segment("billingProfiles")
    billingProfileId: string,

    ...Azure.ResourceManager.Legacy.Provider,
  ): Lots | ErrorResponse;

  /**
   * Lists all Microsoft Azure consumption commitments for a billing account. The API is only supported for Microsoft Customer Agreements (MCA) and Direct Enterprise Agreement (EA)  billing accounts.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @list
  @get
  @action("lots")
  listByBillingAccount(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * May be used to filter the lots by Status, Source etc. The filter supports 'eq', 'lt', 'gt', 'le', 'ge', and 'and'. It does not currently support 'ne', 'or', or 'not'. Tag filter is a key value pair string where key and value is separated by a colon (:).
     */
    @query("$filter")
    $filter?: string,
  ): Lots | ErrorResponse;
  /**
   * Lists all Azure credits for a customer. The API is only supported for Microsoft Partner  Agreements (MPA) billing accounts.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @autoRoute
  @list
  @get
  @action("lots")
  listByCustomer(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string,

    /**
     * Customer ID
     */
    @path
    @segment("customers")
    customerId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * May be used to filter the lots by Status, Source etc. The filter supports 'eq', 'lt', 'gt', 'le', 'ge', and 'and'. Tag filter is a key value pair string where key and value is separated by a colon (:).
     */
    @query("$filter")
    $filter?: string,
  ): Lots | ErrorResponse;
}
