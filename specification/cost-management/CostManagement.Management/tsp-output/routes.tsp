import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.CostManagement;

interface BenefitRecommendationsOperations {
  @doc("List of recommendations for purchasing savings plan.")
  @route("/{billingScope}/providers/Microsoft.CostManagement/benefitRecommendations")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Can be used to filter benefitRecommendations by: properties/scope with allowed values ['Single', 'Shared'] and default value 'Shared'; and properties/lookBackPeriod with allowed values ['Last7Days', 'Last30Days', 'Last60Days'] and default value 'Last60Days'; properties/term with allowed values ['P1Y', 'P3Y'] and default value 'P3Y'; properties/subscriptionId; properties/resourceGroup")
      @query("$filter")
      $filter?: string;

      @doc("May be used to order the recommendations by: properties/armSkuName. For the savings plan, the results are in order by default. There is no need to use this clause.")
      @query("$orderby")
      $orderby?: string;

      @doc("May be used to expand the properties by: properties/usage, properties/allRecommendationDetails")
      @query("$expand")
      $expand?: string;

      @doc("The scope associated with benefit recommendation operations. This includes '/subscriptions/{subscriptionId}/' for subscription scope, '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resource group scope, /providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for enterprise agreement scope, and '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for billing profile scope")
      @path
      billingScope: string;
    },
    BenefitRecommendationsListResult
  >;
}

interface BenefitUtilizationSummariesOperations {
  @doc("Lists savings plan utilization summaries for the enterprise agreement scope. Supported at grain values: 'Daily' and 'Monthly'.")
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/providers/Microsoft.CostManagement/benefitUtilizationSummaries")
  @get
  listByBillingAccountId is Azure.Core.Foundations.Operation<
    {
      @doc("Billing account ID")
      @path
      billingAccountId: string;

      @doc("Grain.")
      @query("grainParameter")
      grainParameter?: GrainParameter;

      @doc("Supports filtering by properties/benefitId, properties/benefitOrderId and properties/usageDate.")
      @query("filter")
      filter?: string;
    },
    BenefitUtilizationSummariesListResult
  >;

  @doc("Lists savings plan utilization summaries for billing profile. Supported at grain values: 'Daily' and 'Monthly'.")
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}/providers/Microsoft.CostManagement/benefitUtilizationSummaries")
  @get
  listByBillingProfileId is Azure.Core.Foundations.Operation<
    {
      @doc("Billing account ID")
      @path
      billingAccountId: string;

      @doc("Billing profile ID.")
      @path
      billingProfileId: string;

      @doc("Grain.")
      @query("grainParameter")
      grainParameter?: GrainParameter;

      @doc("Supports filtering by properties/benefitId, properties/benefitOrderId and properties/usageDate.")
      @query("filter")
      filter?: string;
    },
    BenefitUtilizationSummariesListResult
  >;

  @doc("Lists the savings plan utilization summaries for daily or monthly grain.")
  @route("/providers/Microsoft.BillingBenefits/savingsPlanOrders/{savingsPlanOrderId}/providers/Microsoft.CostManagement/benefitUtilizationSummaries")
  @get
  listBySavingsPlanOrder is Azure.Core.Foundations.Operation<
    {
      @doc("Supports filtering by properties/usageDate.")
      @query("$filter")
      $filter?: string;

      @doc("Grain.")
      @query("grainParameter")
      grainParameter?: GrainParameter;

      @doc("Savings plan order ID.")
      @path
      savingsPlanOrderId: string;
    },
    BenefitUtilizationSummariesListResult
  >;

  @doc("Lists the savings plan utilization summaries for daily or monthly grain.")
  @route("/providers/Microsoft.BillingBenefits/savingsPlanOrders/{savingsPlanOrderId}/savingsPlans/{savingsPlanId}/providers/Microsoft.CostManagement/benefitUtilizationSummaries")
  @get
  listBySavingsPlanId is Azure.Core.Foundations.Operation<
    {
      @doc("Supports filtering by properties/usageDate.")
      @query("$filter")
      $filter?: string;

      @doc("Grain.")
      @query("grainParameter")
      grainParameter?: GrainParameter;

      @doc("Savings plan order ID.")
      @path
      savingsPlanOrderId: string;

      @doc("Savings plan ID.")
      @path
      savingsPlanId: string;
    },
    BenefitUtilizationSummariesListResult
  >;
}

interface BillingAccountScopeOperations {
  @doc("Triggers generation of a benefit utilization summaries report for the provided billing account. This API supports only enrollment accounts.")
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/providers/Microsoft.CostManagement/generateBenefitUtilizationSummariesReport")
  @post
  generateBenefitUtilizationSummariesReport is Azure.Core.Foundations.Operation<
    {
      @doc("Billing account ID")
      @path
      billingAccountId: string;

      @doc("Async Benefit Utilization Summary report to be created.")
      @body
      benefitUtilizationSummariesRequest: BenefitUtilizationSummariesRequest;
    },
    BenefitUtilizationSummariesOperationStatus | void
  >;
}

interface BillingProfileScopeOperations {
  @doc("Triggers generation of a benefit utilization summaries report for the provided billing account and billing profile.")
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}/providers/Microsoft.CostManagement/generateBenefitUtilizationSummariesReport")
  @post
  generateBenefitUtilizationSummariesReport is Azure.Core.Foundations.Operation<
    {
      @doc("Billing account ID")
      @path
      billingAccountId: string;

      @doc("Billing profile ID.")
      @path
      billingProfileId: string;

      @doc("Async Benefit Utilization Summary report to be created.")
      @body
      benefitUtilizationSummariesRequest: BenefitUtilizationSummariesRequest;
    },
    BenefitUtilizationSummariesOperationStatus | void
  >;
}

interface ReservationOrderScopeOperations {
  @doc("Triggers generation of a benefit utilization summaries report for the provided reservation order.")
  @route("/providers/Microsoft.Capacity/reservationorders/{reservationOrderId}/providers/Microsoft.CostManagement/generateBenefitUtilizationSummariesReport")
  @post
  generateBenefitUtilizationSummariesReport is Azure.Core.Foundations.Operation<
    {
      @doc("Reservation Order ID")
      @path
      reservationOrderId: string;

      @doc("Async Benefit Utilization Summary report to be created.")
      @body
      benefitUtilizationSummariesRequest: BenefitUtilizationSummariesRequest;
    },
    BenefitUtilizationSummariesOperationStatus | void
  >;
}

interface ReservationScopeOperations {
  @doc("Triggers generation of a benefit utilization summaries report for the provided reservation.")
  @route("/providers/Microsoft.Capacity/reservationorders/{reservationOrderId}/reservations/{reservationId}/providers/Microsoft.CostManagement/generateBenefitUtilizationSummariesReport")
  @post
  generateBenefitUtilizationSummariesReport is Azure.Core.Foundations.Operation<
    {
      @doc("Reservation Order ID")
      @path
      reservationOrderId: string;

      @doc("Reservation ID")
      @path
      reservationId: string;

      @doc("Async Benefit Utilization Summary report to be created.")
      @body
      benefitUtilizationSummariesRequest: BenefitUtilizationSummariesRequest;
    },
    BenefitUtilizationSummariesOperationStatus | void
  >;
}

interface SavingsPlanOrderScopeOperations {
  @doc("Triggers generation of a benefit utilization summaries report for the provided savings plan order.")
  @route("/providers/Microsoft.BillingBenefits/savingsPlanOrders/{savingsPlanOrderId}/providers/Microsoft.CostManagement/generateBenefitUtilizationSummariesReport")
  @post
  generateBenefitUtilizationSummariesReport is Azure.Core.Foundations.Operation<
    {
      @doc("Savings plan order ID.")
      @path
      savingsPlanOrderId: string;

      @doc("Async Benefit Utilization Summary report to be created.")
      @body
      benefitUtilizationSummariesRequest: BenefitUtilizationSummariesRequest;
    },
    BenefitUtilizationSummariesOperationStatus | void
  >;
}

interface SavingsPlanScopeOperations {
  @doc("Triggers generation of a benefit utilization summaries report for the provided savings plan.")
  @route("/providers/Microsoft.BillingBenefits/savingsPlanOrders/{savingsPlanOrderId}/savingsPlans/{savingsPlanId}/providers/Microsoft.CostManagement/generateBenefitUtilizationSummariesReport")
  @post
  generateBenefitUtilizationSummariesReportAsync is Azure.Core.Foundations.Operation<
    {
      @doc("Savings plan order ID.")
      @path
      savingsPlanOrderId: string;

      @doc("Savings plan ID.")
      @path
      savingsPlanId: string;

      @doc("Async Benefit Utilization Summary report to be created.")
      @body
      benefitUtilizationSummariesRequest: BenefitUtilizationSummariesRequest;
    },
    BenefitUtilizationSummariesOperationStatus | void
  >;
}

interface ViewsOperations {
  @doc("Lists all views at the given scope.")
  @route("/{scope}/providers/Microsoft.CostManagement/views")
  @get
  listByScope is Azure.Core.Foundations.Operation<
    {
      @doc("The scope associated with view operations. This includes 'subscriptions/{subscriptionId}' for subscription scope, 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for BillingProfile scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/invoiceSections/{invoiceSectionId}' for InvoiceSection scope, 'providers/Microsoft.Management/managementGroups/{managementGroupId}' for Management Group scope, 'providers/Microsoft.CostManagement/externalBillingAccounts/{externalBillingAccountName}' for External Billing Account scope and 'providers/Microsoft.CostManagement/externalSubscriptions/{externalSubscriptionName}' for External Subscription scope.")
      @path
      scope: string;
    },
    ViewListResult
  >;

  @doc("Gets the view for the defined scope by view name.")
  @route("/{scope}/providers/Microsoft.CostManagement/views/{viewName}")
  @get
  getByScope is Azure.Core.Foundations.Operation<
    {
      @doc("The scope associated with view operations. This includes 'subscriptions/{subscriptionId}' for subscription scope, 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for BillingProfile scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/invoiceSections/{invoiceSectionId}' for InvoiceSection scope, 'providers/Microsoft.Management/managementGroups/{managementGroupId}' for Management Group scope, 'providers/Microsoft.CostManagement/externalBillingAccounts/{externalBillingAccountName}' for External Billing Account scope and 'providers/Microsoft.CostManagement/externalSubscriptions/{externalSubscriptionName}' for External Subscription scope.")
      @path
      scope: string;

      @doc("View name")
      @path
      viewName: string;
    },
    View
  >;

  @doc("The operation to create or update a view. Update operation requires latest eTag to be set in the request. You may obtain the latest eTag by performing a get operation. Create operation does not require eTag.")
  @route("/{scope}/providers/Microsoft.CostManagement/views/{viewName}")
  @put
  createOrUpdateByScope is Azure.Core.Foundations.Operation<
    {
      @doc("The scope associated with view operations. This includes 'subscriptions/{subscriptionId}' for subscription scope, 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for BillingProfile scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/invoiceSections/{invoiceSectionId}' for InvoiceSection scope, 'providers/Microsoft.Management/managementGroups/{managementGroupId}' for Management Group scope, 'providers/Microsoft.CostManagement/externalBillingAccounts/{externalBillingAccountName}' for External Billing Account scope and 'providers/Microsoft.CostManagement/externalSubscriptions/{externalSubscriptionName}' for External Subscription scope.")
      @path
      scope: string;

      @doc("View name")
      @path
      viewName: string;

      @doc("Parameters supplied to the CreateOrUpdate View operation.")
      @body
      parameters: View;
    },
    View
  >;

  @doc("The operation to delete a view.")
  @route("/{scope}/providers/Microsoft.CostManagement/views/{viewName}")
  @delete
  deleteByScope is Azure.Core.Foundations.Operation<
    {
      @doc("The scope associated with view operations. This includes 'subscriptions/{subscriptionId}' for subscription scope, 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for BillingProfile scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/invoiceSections/{invoiceSectionId}' for InvoiceSection scope, 'providers/Microsoft.Management/managementGroups/{managementGroupId}' for Management Group scope, 'providers/Microsoft.CostManagement/externalBillingAccounts/{externalBillingAccountName}' for External Billing Account scope and 'providers/Microsoft.CostManagement/externalSubscriptions/{externalSubscriptionName}' for External Subscription scope.")
      @path
      scope: string;

      @doc("View name")
      @path
      viewName: string;
    },
    void
  >;
}

interface ForecastOperations {
  @doc("Lists the forecast charges for scope defined.")
  @route("/{scope}/providers/Microsoft.CostManagement/forecast")
  @post
  usage is Azure.Core.Foundations.Operation<
    {
      @doc("May be used to filter forecasts by properties/usageDate (Utc time), properties/chargeType or properties/grain. The filter supports 'eq', 'lt', 'gt', 'le', 'ge', and 'and'. It does not currently support 'ne', 'or', or 'not'.")
      @query("$filter")
      $filter?: string;

      @doc("The scope associated with forecast operations. This includes '/subscriptions/{subscriptionId}/' for subscription scope, '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope and '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, '/providers/Microsoft.Management/managementGroups/{managementGroupId} for Management Group scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for billingProfile scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}/invoiceSections/{invoiceSectionId}' for invoiceSection scope, and '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/customers/{customerId}' specific for partners.")
      @path
      scope: string;

      @doc("Parameters supplied to the CreateOrUpdate Forecast Config operation.")
      @body
      parameters: ForecastDefinition;
    },
    ForecastResult | void
  >;

  @doc("Lists the forecast charges for external cloud provider type defined.")
  @route("/providers/Microsoft.CostManagement/{externalCloudProviderType}/{externalCloudProviderId}/forecast")
  @post
  externalCloudProviderUsage is Azure.Core.Foundations.Operation<
    {
      @doc("May be used to filter forecasts by properties/usageDate (Utc time), properties/chargeType or properties/grain. The filter supports 'eq', 'lt', 'gt', 'le', 'ge', and 'and'. It does not currently support 'ne', 'or', or 'not'.")
      @query("$filter")
      $filter?: string;

      @doc("The external cloud provider type associated with dimension/query operations. This includes 'externalSubscriptions' for linked account and 'externalBillingAccounts' for consolidated account.")
      @path
      externalCloudProviderType: ExternalCloudProviderType;

      @doc("This can be '{externalSubscriptionId}' for linked account or '{externalBillingAccountId}' for consolidated account used with dimension/query operations.")
      @path
      externalCloudProviderId: string;

      @doc("Parameters supplied to the CreateOrUpdate Forecast Config operation.")
      @body
      parameters: ForecastDefinition;
    },
    ForecastResult
  >;
}

interface DimensionsOperations {
  @doc("Lists the dimensions by the defined scope.")
  @route("/{scope}/providers/Microsoft.CostManagement/dimensions")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The scope associated with dimension operations. This includes '/subscriptions/{subscriptionId}/' for subscription scope, '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, '/providers/Microsoft.Management/managementGroups/{managementGroupId}' for Management Group scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for billingProfile scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}/invoiceSections/{invoiceSectionId}' for invoiceSection scope, and 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/customers/{customerId}' specific for partners.")
      @path
      scope: string;

      @doc("May be used to filter dimensions by properties/category, properties/usageStart, properties/usageEnd. Supported operators are 'eq','lt', 'gt', 'le', 'ge'.")
      @query("$filter")
      $filter?: string;

      @doc("May be used to expand the properties/data within a dimension category. By default, data is not included when listing dimensions.")
      @query("$expand")
      $expand?: string;

      @doc("Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skiptoken")
      $skiptoken?: string;

      @doc("May be used to limit the number of results to the most recent N dimension data.")
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    },
    DimensionsListResult | void
  >;

  @doc("Lists the dimensions by the external cloud provider type.")
  @route("/providers/Microsoft.CostManagement/{externalCloudProviderType}/{externalCloudProviderId}/dimensions")
  @get
  byExternalCloudProviderType is Azure.Core.Foundations.Operation<
    {
      @doc("The external cloud provider type associated with dimension/query operations. This includes 'externalSubscriptions' for linked account and 'externalBillingAccounts' for consolidated account.")
      @path
      externalCloudProviderType: ExternalCloudProviderType;

      @doc("This can be '{externalSubscriptionId}' for linked account or '{externalBillingAccountId}' for consolidated account used with dimension/query operations.")
      @path
      externalCloudProviderId: string;

      @doc("May be used to filter dimensions by properties/category, properties/usageStart, properties/usageEnd. Supported operators are 'eq','lt', 'gt', 'le', 'ge'.")
      @query("$filter")
      $filter?: string;

      @doc("May be used to expand the properties/data within a dimension category. By default, data is not included when listing dimensions.")
      @query("$expand")
      $expand?: string;

      @doc("Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skiptoken")
      $skiptoken?: string;

      @doc("May be used to limit the number of results to the most recent N dimension data.")
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    },
    DimensionsListResult
  >;
}

interface QueryOperations {
  @doc("Query the usage data for scope defined.")
  @route("/{scope}/providers/Microsoft.CostManagement/query")
  @post
  usage is Azure.Core.Foundations.Operation<
    {
      @doc("The scope associated with query and export operations. This includes '/subscriptions/{subscriptionId}/' for subscription scope, '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope and '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, '/providers/Microsoft.Management/managementGroups/{managementGroupId} for Management Group scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for billingProfile scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}/invoiceSections/{invoiceSectionId}' for invoiceSection scope, and '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/customers/{customerId}' specific for partners.")
      @path
      scope: string;

      @doc("Parameters supplied to the CreateOrUpdate Query Config operation.")
      @body
      parameters: QueryDefinition;
    },
    QueryResult | void
  >;

  @doc("Query the usage data for external cloud provider type defined.")
  @route("/providers/Microsoft.CostManagement/{externalCloudProviderType}/{externalCloudProviderId}/query")
  @post
  usageByExternalCloudProviderType is Azure.Core.Foundations.Operation<
    {
      @doc("The external cloud provider type associated with dimension/query operations. This includes 'externalSubscriptions' for linked account and 'externalBillingAccounts' for consolidated account.")
      @path
      externalCloudProviderType: ExternalCloudProviderType;

      @doc("This can be '{externalSubscriptionId}' for linked account or '{externalBillingAccountId}' for consolidated account used with dimension/query operations.")
      @path
      externalCloudProviderId: string;

      @doc("Parameters supplied to the CreateOrUpdate Query Config operation.")
      @body
      parameters: QueryDefinition;
    },
    QueryResult
  >;
}

interface GenerateReservationDetailsReportOperations {
  @doc("Generates the reservations details report for provided date range asynchronously based on enrollment id. The Reservation usage details can be viewed only by certain enterprise roles. For more details on the roles see, https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/understand-ea-roles#usage-and-costs-access-by-role")
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/providers/Microsoft.CostManagement/generateReservationDetailsReport")
  @post
  byBillingAccountId is Azure.Core.Foundations.Operation<
    {
      @doc("Enrollment ID (Legacy BillingAccount ID)")
      @path
      billingAccountId: string;

      @doc("Start Date")
      @query("startDate")
      startDate: string;

      @doc("End Date")
      @query("endDate")
      endDate: string;
    },
    OperationStatus | void
  >;

  @doc("Generates the reservations details report for provided date range asynchronously by billing profile. The Reservation usage details can be viewed by only certain enterprise roles by default. For more details on the roles see, https://docs.microsoft.com/en-us/azure/cost-management-billing/reservations/reservation-utilization#view-utilization-in-the-azure-portal-with-azure-rbac-access")
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}/providers/Microsoft.CostManagement/generateReservationDetailsReport")
  @post
  byBillingProfileId is Azure.Core.Foundations.Operation<
    {
      @doc("Billing account ID")
      @path
      billingAccountId: string;

      @doc("Billing profile ID.")
      @path
      billingProfileId: string;

      @doc("Start Date")
      @query("startDate")
      startDate: string;

      @doc("End Date")
      @query("endDate")
      endDate: string;
    },
    OperationStatus | void
  >;
}

interface PriceSheetOperations {
  @doc("Gets a URL to download the pricesheet for an invoice. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.")
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/invoices/{invoiceName}/providers/Microsoft.CostManagement/pricesheets/default/download")
  @post
  download is Azure.Core.Foundations.Operation<
    {
      @doc("The ID that uniquely identifies a billing account.")
      @pattern("([A-Za-z0-9]+(-[A-Za-z0-9]+)+):([A-Za-z0-9]+(-[A-Za-z0-9]+)+)_[0-9]{4}-[0-9]{2}-[0-9]{2}")
      @path
      billingAccountName: string;

      @doc("The ID that uniquely identifies a billing profile.")
      @pattern("([A-Za-z0-9]+(-[A-Za-z0-9]+)+)")
      @path
      billingProfileName: string;

      @doc("The ID that uniquely identifies an invoice.")
      @pattern("[A-Za-z0-9]+")
      @path
      invoiceName: string;
    },
    DownloadURL | void
  >;

  @doc("Gets a URL to download the current month's pricesheet for a billing profile. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.Due to Azure product growth, the Azure price sheet download experience in this preview version will be updated from a single csv file to a Zip file containing multiple csv files, each with max 200k records.")
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/providers/Microsoft.CostManagement/pricesheets/default/download")
  @post
  downloadByBillingProfile is Azure.Core.Foundations.Operation<
    {
      @doc("The ID that uniquely identifies a billing account.")
      @pattern("([A-Za-z0-9]+(-[A-Za-z0-9]+)+):([A-Za-z0-9]+(-[A-Za-z0-9]+)+)_[0-9]{4}-[0-9]{2}-[0-9]{2}")
      @path
      billingAccountName: string;

      @doc("The ID that uniquely identifies a billing profile.")
      @pattern("([A-Za-z0-9]+(-[A-Za-z0-9]+)+)")
      @path
      billingProfileName: string;
    },
    DownloadURL | void
  >;
}

interface ScheduledActionsOperations {
  @doc("List all shared scheduled actions within the given scope.")
  @route("/{scope}/providers/Microsoft.CostManagement/scheduledActions")
  @get
  listByScope is Azure.Core.Foundations.Operation<
    {
      @doc("The scope associated with scheduled action operations. This includes 'subscriptions/{subscriptionId}' for subscription scope, 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for BillingProfile scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/invoiceSections/{invoiceSectionId}' for InvoiceSection scope, 'providers/Microsoft.CostManagement/externalBillingAccounts/{externalBillingAccountName}' for External Billing Account scope and 'providers/Microsoft.CostManagement/externalSubscriptions/{externalSubscriptionName}' for External Subscription scope. Note: Insight Alerts are only available on subscription scope.")
      @path
      scope: string;

      @doc("May be used to filter scheduled actions by properties/viewId. Supported operator is 'eq'.")
      @query("$filter")
      $filter?: string;
    },
    ScheduledActionListResult
  >;

  @doc("Create or update a shared scheduled action within the given scope.")
  @route("/{scope}/providers/Microsoft.CostManagement/scheduledActions/{name}")
  @put
  createOrUpdateByScope is Azure.Core.Foundations.Operation<
    {
      @doc("The scope associated with scheduled action operations. This includes 'subscriptions/{subscriptionId}' for subscription scope, 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for BillingProfile scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/invoiceSections/{invoiceSectionId}' for InvoiceSection scope, 'providers/Microsoft.CostManagement/externalBillingAccounts/{externalBillingAccountName}' for External Billing Account scope and 'providers/Microsoft.CostManagement/externalSubscriptions/{externalSubscriptionName}' for External Subscription scope. Note: Insight Alerts are only available on subscription scope.")
      @path
      scope: string;

      @doc("Scheduled action name.")
      @path
      name: string;

      @doc("ETag of the Entity. Not required when creating an entity. Optional when updating an entity and can be specified to achieve optimistic concurrency.")
      @header
      `If-Match`?: string;

      @doc("Scheduled action to be created or updated.")
      @body
      scheduledAction: ScheduledAction;
    },
    ScheduledAction
  >;

  @doc("Get the shared scheduled action from the given scope by name.")
  @route("/{scope}/providers/Microsoft.CostManagement/scheduledActions/{name}")
  @get
  getByScope is Azure.Core.Foundations.Operation<
    {
      @doc("The scope associated with scheduled action operations. This includes 'subscriptions/{subscriptionId}' for subscription scope, 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for BillingProfile scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/invoiceSections/{invoiceSectionId}' for InvoiceSection scope, 'providers/Microsoft.CostManagement/externalBillingAccounts/{externalBillingAccountName}' for External Billing Account scope and 'providers/Microsoft.CostManagement/externalSubscriptions/{externalSubscriptionName}' for External Subscription scope. Note: Insight Alerts are only available on subscription scope.")
      @path
      scope: string;

      @doc("Scheduled action name.")
      @path
      name: string;
    },
    ScheduledAction
  >;

  @doc("Delete a scheduled action within the given scope.")
  @route("/{scope}/providers/Microsoft.CostManagement/scheduledActions/{name}")
  @delete
  deleteByScope is Azure.Core.Foundations.Operation<
    {
      @doc("The scope associated with scheduled action operations. This includes 'subscriptions/{subscriptionId}' for subscription scope, 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for BillingProfile scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/invoiceSections/{invoiceSectionId}' for InvoiceSection scope, 'providers/Microsoft.CostManagement/externalBillingAccounts/{externalBillingAccountName}' for External Billing Account scope and 'providers/Microsoft.CostManagement/externalSubscriptions/{externalSubscriptionName}' for External Subscription scope. Note: Insight Alerts are only available on subscription scope.")
      @path
      scope: string;

      @doc("Scheduled action name.")
      @path
      name: string;
    },
    void
  >;

  @doc("Runs a shared scheduled action within the given scope.")
  @route("/{scope}/providers/Microsoft.CostManagement/scheduledActions/{name}/execute")
  @post
  runByScope is Azure.Core.Foundations.Operation<
    {
      @doc("The scope associated with scheduled action operations. This includes 'subscriptions/{subscriptionId}' for subscription scope, 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for BillingProfile scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/invoiceSections/{invoiceSectionId}' for InvoiceSection scope, 'providers/Microsoft.CostManagement/externalBillingAccounts/{externalBillingAccountName}' for External Billing Account scope and 'providers/Microsoft.CostManagement/externalSubscriptions/{externalSubscriptionName}' for External Subscription scope. Note: Insight Alerts are only available on subscription scope.")
      @path
      scope: string;

      @doc("Scheduled action name.")
      @path
      name: string;
    },
    void
  >;

  @doc("Checks availability and correctness of the name for a scheduled action.")
  @route("/providers/Microsoft.CostManagement/checkNameAvailability")
  @post
  checkNameAvailability is Azure.Core.Foundations.Operation<
    CheckNameAvailabilityRequest,
    CheckNameAvailabilityResponse
  >;

  @doc("Checks availability and correctness of the name for a scheduled action within the given scope.")
  @route("/{scope}/providers/Microsoft.CostManagement/checkNameAvailability")
  @post
  checkNameAvailabilityByScope is Azure.Core.Foundations.Operation<
    {
      @doc("The scope associated with scheduled action operations. This includes 'subscriptions/{subscriptionId}' for subscription scope, 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for BillingProfile scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/invoiceSections/{invoiceSectionId}' for InvoiceSection scope, 'providers/Microsoft.CostManagement/externalBillingAccounts/{externalBillingAccountName}' for External Billing Account scope and 'providers/Microsoft.CostManagement/externalSubscriptions/{externalSubscriptionName}' for External Subscription scope. Note: Insight Alerts are only available on subscription scope.")
      @path
      scope: string;

      @doc("Scheduled action to be created or updated.")
      @body
      checkNameAvailabilityRequest: CheckNameAvailabilityRequest;
    },
    CheckNameAvailabilityResponse
  >;
}
