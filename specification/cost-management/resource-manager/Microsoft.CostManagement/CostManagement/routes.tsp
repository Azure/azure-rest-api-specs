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

namespace Microsoft.CostManagement;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface CostAllocationRulesOperationGroup {
  /**
   * Checks availability and correctness of a name for a cost allocation rule
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("CostAllocationRules_CheckNameAvailability")
  @autoRoute
  @post
  @action("costAllocationRules/checkNameAvailability")
  @armResourceCollectionAction
  checkNameAvailability(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Cost allocation rule to be created or updated
     */
    @bodyRoot
    body: CostAllocationRuleCheckNameAvailabilityRequest,
  ): ArmResponse<CostAllocationRuleCheckNameAvailabilityResponse> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface BenefitRecommendationsOperationGroup {
  /**
   * List of recommendations for purchasing savings plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("BenefitRecommendations_List")
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/CostManagement/")
  @get
  @list
  @action("benefitRecommendations")
  @autoRoute
  list(
    ...ApiVersionParameter,

    /**
     * Can be used to filter benefitRecommendations by: properties/scope with allowed values ['Single', 'Shared'] and default value 'Shared'; and properties/lookBackPeriod with allowed values ['Last7Days', 'Last30Days', 'Last60Days'] and default value 'Last60Days'; properties/term with allowed values ['P1Y', 'P3Y'] and default value 'P3Y'; properties/subscriptionId; properties/resourceGroup
     */
    @query("$filter")
    $filter?: string,

    /**
     * May be used to order the recommendations by: properties/armSkuName. For the savings plan, the results are in order by default. There is no need to use this clause.
     */
    @query("$orderby")
    $orderby?: string,

    /**
     * May be used to expand the properties by: properties/usage, properties/allRecommendationDetails
     */
    @query("$expand")
    $expand?: string,

    /**
     * The scope associated with benefit recommendation operations. This includes '/subscriptions/{subscriptionId}/' for subscription scope, '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resource group scope, /providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for enterprise agreement scope, and '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for billing profile scope
     */
    @path(#{ allowReserved: true })
    billingScope: string,

    ...Azure.ResourceManager.Legacy.Provider,
  ): ArmResponse<benefitRecommendationsListResult> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface BenefitUtilizationSummariesOperationGroup {
  /**
   * Lists savings plan utilization summaries for the enterprise agreement scope. Supported at grain values: 'Daily' and 'Monthly'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("BenefitUtilizationSummaries_ListByBillingAccountId")
  @autoRoute
  @get
  @action("benefitUtilizationSummaries")
  @list
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/cost-management/")
  listByBillingAccountId(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Grain.
     */
    @query("grainParameter")
    grainParameter?: GrainParameter,

    /**
     * Supports filtering by properties/benefitId, properties/benefitOrderId and properties/usageDate.
     */
    @query("filter")
    filter?: string,
  ): ArmResponse<BenefitUtilizationSummariesListResult> | ErrorResponse;

  /**
   * Lists savings plan utilization summaries for billing profile. Supported at grain values: 'Daily' and 'Monthly'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("BenefitUtilizationSummaries_ListByBillingProfileId")
  @autoRoute
  @get
  @action("benefitUtilizationSummaries")
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/cost-management/")
  @list
  listByBillingProfileId(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string,

    /**
     * Billing Profile ID.
     */
    @path
    @segment("billingProfiles")
    billingProfileId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Grain.
     */
    @query("grainParameter")
    grainParameter?: GrainParameter,

    /**
     * Supports filtering by properties/benefitId, properties/benefitOrderId and properties/usageDate.
     */
    @query("filter")
    filter?: string,
  ): ArmResponse<BenefitUtilizationSummariesListResult> | ErrorResponse;

  /**
   * Lists the savings plan utilization summaries for daily or monthly grain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("BenefitUtilizationSummaries_ListBySavingsPlanOrder")
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/cost-management/")
  @autoRoute
  @get
  @action("benefitUtilizationSummaries")
  @list
  listBySavingsPlanOrder(
    ...ApiVersionParameter,

    /**
     * Supports filtering by properties/usageDate.
     */
    @query("$filter")
    $filter?: string,

    /**
     * Grain.
     */
    @query("grainParameter")
    grainParameter?: GrainParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "microsoft.BillingBenefits",

    /**
     * Savings plan order ID.
     */
    @path
    @segment("savingsPlanOrders")
    savingsPlanOrderId: string,

    ...Azure.ResourceManager.Legacy.Provider,
  ): BenefitUtilizationSummariesListResult | ErrorResponse;
  /**
   * Lists the savings plan utilization summaries for daily or monthly grain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("BenefitUtilizationSummaries_ListBySavingsPlanId")
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/cost-management/")
  @autoRoute
  @get
  @action("benefitUtilizationSummaries")
  @list
  listBySavingsPlanId(
    ...ApiVersionParameter,

    /**
     * Supports filtering by properties/usageDate.
     */
    @query("$filter")
    $filter?: string,

    /**
     * Grain.
     */
    @query("grainParameter")
    grainParameter?: GrainParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "microsoft.BillingBenefits",

    /**
     * Savings plan order ID.
     */
    @path
    @segment("savingsPlanOrders")
    savingsPlanOrderId: string,

    /**
     * Savings plan ID.
     */
    @path
    @segment("savingsPlans")
    savingsPlanId: string,

    ...Azure.ResourceManager.Legacy.Provider,
  ): BenefitUtilizationSummariesListResult | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GenerateBenefitUtilizationSummariesReportOperationGroup {
  /**
   * Triggers generation of a benefit utilization summaries report for the provided billing account. This API supports only enrollment accounts.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GenerateBenefitUtilizationSummariesReport_GenerateByBillingAccount")
  @externalDocs("https://docs.microsoft.com/rest/api/cost-management/")
  @autoRoute
  @action("generateBenefitUtilizationSummariesReport")
  @post
  @armResourceCollectionAction
  generateByBillingAccount(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Async Benefit Utilization Summary report to be created.
     */
    @body
    body: BenefitUtilizationSummariesRequest,
  ): ArmResponse<BenefitUtilizationSummariesOperationStatus> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = BenefitUtilizationSummariesOperationStatus>> | CommonTypes.ErrorResponse;

  /**
   * Triggers generation of a benefit utilization summaries report for the provided billing account and billing profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GenerateBenefitUtilizationSummariesReport_GenerateByBillingProfile")
  @autoRoute
  @action("generateBenefitUtilizationSummariesReport")
  @externalDocs("https://docs.microsoft.com/rest/api/cost-management/")
  @post
  @armResourceCollectionAction
  generateByBillingProfile(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string,

    /**
     * Billing Profile ID.
     */
    @path
    @segment("billingProfiles")
    billingProfileId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Async Benefit Utilization Summary report to be created.
     */
    @body
    body: BenefitUtilizationSummariesRequest,
  ): ArmResponse<BenefitUtilizationSummariesOperationStatus> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = BenefitUtilizationSummariesOperationStatus>> | CommonTypes.ErrorResponse;

  /**
   * Triggers generation of a benefit utilization summaries report for the provided reservation order.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GenerateBenefitUtilizationSummariesReport_GenerateByReservationOrderId")
  @externalDocs("https://docs.microsoft.com/rest/api/cost-management/")
  @autoRoute
  @action("generateBenefitUtilizationSummariesReport")
  @post
  @armResourceCollectionAction
  generateByReservationOrderId(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "microsoft.Capacity",

    /**
     * Reservation Order ID
     */
    @path
    @segment("reservationorders")
    reservationOrderId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Async Benefit Utilization Summary report to be created.
     */
    @body
    body: BenefitUtilizationSummariesRequest,
  ): BenefitUtilizationSummariesOperationStatus | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = BenefitUtilizationSummariesOperationStatus>> | CommonTypes.ErrorResponse;

  /**
   * Triggers generation of a benefit utilization summaries report for the provided reservation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GenerateBenefitUtilizationSummariesReport_GenerateByReservationId")
  @externalDocs("https://docs.microsoft.com/rest/api/cost-management/")
  @autoRoute
  @action("generateBenefitUtilizationSummariesReport")
  @post
  @armResourceCollectionAction
  generateByReservationId(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "microsoft.Capacity",

    /**
     * Reservation Order ID
     */
    @path
    @segment("reservationorders")
    reservationOrderId: string,

    /**
     * Reservation ID
     */
    @path
    @segment("reservations")
    reservationId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Async Benefit Utilization Summary report to be created.
     */
    @body
    body: BenefitUtilizationSummariesRequest,
  ): BenefitUtilizationSummariesOperationStatus | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = BenefitUtilizationSummariesOperationStatus>> | CommonTypes.ErrorResponse;
  /**
   * Triggers generation of a benefit utilization summaries report for the provided savings plan order.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GenerateBenefitUtilizationSummariesReport_GenerateBySavingsPlanOrderId")
  @externalDocs("https://docs.microsoft.com/rest/api/cost-management/")
  @autoRoute
  @action("generateBenefitUtilizationSummariesReport")
  @post
  @armResourceCollectionAction
  generateBySavingsPlanOrderId(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "microsoft.BillingBenefits",

    /**
     * Savings plan order ID.
     */
    @path
    @segment("savingsPlanOrders")
    savingsPlanOrderId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Async Benefit Utilization Summary report to be created.
     */
    @body
    body: BenefitUtilizationSummariesRequest,
  ): BenefitUtilizationSummariesOperationStatus | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = BenefitUtilizationSummariesOperationStatus>> | CommonTypes.ErrorResponse;
  /**
   * Triggers generation of a benefit utilization summaries report for the provided savings plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GenerateBenefitUtilizationSummariesReport_GenerateBySavingsPlanId")
  @externalDocs("https://docs.microsoft.com/rest/api/cost-management/")
  @autoRoute
  @action("generateBenefitUtilizationSummariesReport")
  @post
  @armResourceCollectionAction
  generateBySavingsPlanId(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "microsoft.BillingBenefits",

    /**
     * Savings plan order ID.
     */
    @path
    @segment("savingsPlanOrders")
    savingsPlanOrderId: string,

    /**
     * Savings plan ID.
     */
    @path
    @segment("savingsPlans")
    savingsPlanId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Async Benefit Utilization Summary report to be created.
     */
    @body
    body: BenefitUtilizationSummariesRequest,
  ): BenefitUtilizationSummariesOperationStatus | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = BenefitUtilizationSummariesOperationStatus>> | CommonTypes.ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GenerateCostDetailsReportOperationGroup {
  /**
   * This API is the replacement for all previously release Usage Details APIs. Request to generate a cost details report for the provided date range, billing period (Only enterprise customers) or Invoice Id asynchronously at a certain scope. The initial call to request a report will return a 202 with a 'Location' and 'Retry-After' header. The 'Location' header will provide the endpoint to poll to get the result of the report generation. The 'Retry-After' provides the duration to wait before polling for the generated report. A call to poll the report operation will provide a 202 response with a 'Location' header if the operation is still in progress. Once the report generation operation completes, the polling endpoint will provide a 200 response along with details on the report blob(s) that are available for download. The details on the file(s) available for download will be available in the polling response body. To Understand cost details (formerly known as usage details) fields found in files ,see https://learn.microsoft.com/en-us/azure/cost-management-billing/automate/understand-usage-details-fields
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GenerateCostDetailsReport_CreateOperation")
  @post
  @autoRoute
  @action("generateCostDetailsReport")
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  createOperation(
    ...ApiVersionParameter,

    /**
     * The ARM Resource ID for subscription, billing account, or other billing scopes.Currently Resource Group and Management Group are not supported. For details, see https://aka.ms/costmgmt/scopes.
     */
    @path(#{ allowReserved: true })
    scope: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Parameters supplied to the Create cost details operation.
     */
    @bodyRoot
    parameters: GenerateCostDetailsReportRequestDefinition,
  ):
    | ArmResponse<CostDetailsOperationResults>
    | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = CostDetailsOperationResults>>
    | NoContentResponse
    | GenerateCostDetailsReportErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GenerateDetailedCostReportOperationGroup {
  /**
   * Generates the detailed cost report for provided date range, billing period(only enterprise customers) or Invoice ID asynchronously at a certain scope. Call returns a 202 with header Azure-Consumption-AsyncOperation providing a link to the operation created. A call on the operation will provide the status and if the operation is completed the blob file where generated detailed cost report is being stored.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GenerateDetailedCostReport_CreateOperation")
  @post
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  @autoRoute
  @action("generateDetailedCostReport")
  createOperation(
    ...ApiVersionParameter,

    /**
     * The ARM Resource ID for subscription, resource group, billing account, or other billing scopes. For details, see https://aka.ms/costmgmt/scopes.
     */
    @path(#{ allowReserved: true })
    scope: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Parameters supplied to the Create detailed cost report operation.
     */
    @bodyRoot
    parameters: GenerateDetailedCostReportDefinition,
  ): ArmResponse<GenerateDetailedCostReportOperationResult> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = GenerateDetailedCostReportOperationResult>> & {
    /**
     * The URL to check the status of the asynchronous operation.
     */
    @header("Azure-Consumption-AsyncOperation")
    azureConsumptionAsyncOperation: string;
  }) | GenerateDetailedCostReportErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AlertsOperationGroup {
  /**
   * Lists the Alerts for external cloud provider type defined.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Alerts_ListExternal")
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  @autoRoute
  @get
  @action("alerts")
  listExternal is ArmProviderActionSync<
    Response = AlertsResult,
    Parameters = {
      /**
       * The external cloud provider type associated with dimension/query operations. This includes 'externalSubscriptions' for linked account and 'externalBillingAccounts' for consolidated account.
       */
      @path
      externalCloudProviderType: ExternalCloudProviderType;

      /**
       * This can be '{externalSubscriptionId}' for linked account or '{externalBillingAccountId}' for consolidated account used with dimension/query operations.
       */
      @path
      externalCloudProviderId: string;
    },
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ForecastOperationGroup {
  /**
   * Lists the forecast charges for scope defined.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Forecast_Usage")
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  @post
  @action("forecast")
  @autoRoute
  usage(
    ...ApiVersionParameter,

    /**
     * May be used to filter forecasts by properties/usageDate (Utc time), properties/chargeType or properties/grain. The filter supports 'eq', 'lt', 'gt', 'le', 'ge', and 'and'. It does not currently support 'ne', 'or', or 'not'.
     */
    @query("$filter")
    $filter?: string,

    /**
     * The scope associated with forecast operations. This includes '/subscriptions/{subscriptionId}/' for subscription scope, '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope and '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, '/providers/Microsoft.Management/managementGroups/{managementGroupId} for Management Group scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for billingProfile scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}/invoiceSections/{invoiceSectionId}' for invoiceSection scope, and '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/customers/{customerId}' specific for partners.
     */
    @path(#{ allowReserved: true })
    scope: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Parameters supplied to the CreateOrUpdate Forecast Config operation.
     */
    @bodyRoot
    parameters: ForecastDefinition,
  ): ArmResponse<ForecastResult> | NoContentResponse | ErrorResponse;

  /**
   * Lists the forecast charges for external cloud provider type defined.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Forecast_ExternalCloudProviderUsage")
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  @autoRoute
  @action("forecast")
  externalCloudProviderUsage is ArmProviderActionSync<
    Request = ForecastDefinition,
    Response = ForecastResult,
    Parameters = {
      /**
       * May be used to filter forecasts by properties/usageDate (Utc time), properties/chargeType or properties/grain. The filter supports 'eq', 'lt', 'gt', 'le', 'ge', and 'and'. It does not currently support 'ne', 'or', or 'not'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The external cloud provider type associated with dimension/query operations. This includes 'externalSubscriptions' for linked account and 'externalBillingAccounts' for consolidated account.
       */
      @path
      externalCloudProviderType: ExternalCloudProviderType;

      /**
       * This can be '{externalSubscriptionId}' for linked account or '{externalBillingAccountId}' for consolidated account used with dimension/query operations.
       */
      @path
      externalCloudProviderId: string;
    },
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DimensionsOperationGroup {
  /**
   * Lists the dimensions by the defined scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Dimensions_List")
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  @get
  @action("dimensions")
  @autoRoute
  @list
  list(
    ...ApiVersionParameter,

    /**
     * The scope associated with dimension operations. This includes '/subscriptions/{subscriptionId}/' for subscription scope, '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, '/providers/Microsoft.Management/managementGroups/{managementGroupId}' for Management Group scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for billingProfile scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}/invoiceSections/{invoiceSectionId}' for invoiceSection scope, and 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/customers/{customerId}' specific for partners.
     */
    @path(#{ allowReserved: true })
    scope: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * May be used to filter dimensions by properties/category, properties/usageStart, properties/usageEnd. Supported operators are 'eq','lt', 'gt', 'le', 'ge'.
     */
    @query("$filter")
    $filter?: string,

    /**
     * May be used to expand the properties/data within a dimension category. By default, data is not included when listing dimensions.
     */
    @query("$expand")
    $expand?: string,

    /**
     * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.
     */
    @query("$skiptoken")
    $skiptoken?: string,

    /**
     * May be used to limit the number of results to the most recent N dimension data.
     */
    @maxValue(1000)
    @minValue(1)
    @query("$top")
    $top?: int32,
  ): ArmResponse<DimensionsListResult> | NoContentResponse | ErrorResponse;

  /**
   * Lists the dimensions by the external cloud provider type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Dimensions_ByExternalCloudProviderType")
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  @autoRoute
  @get
  @action("dimensions")
  @list
  byExternalCloudProviderType is ArmProviderActionSync<
    Response = DimensionsListResult,
    Parameters = {
      /**
       * The external cloud provider type associated with dimension/query operations. This includes 'externalSubscriptions' for linked account and 'externalBillingAccounts' for consolidated account.
       */
      @path
      externalCloudProviderType: ExternalCloudProviderType;

      /**
       * This can be '{externalSubscriptionId}' for linked account or '{externalBillingAccountId}' for consolidated account used with dimension/query operations.
       */
      @path
      externalCloudProviderId: string;

      /**
       * May be used to filter dimensions by properties/category, properties/usageStart, properties/usageEnd. Supported operators are 'eq','lt', 'gt', 'le', 'ge'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * May be used to expand the properties/data within a dimension category. By default, data is not included when listing dimensions.
       */
      @query("$expand")
      $expand?: string;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skiptoken")
      $skiptoken?: string;

      /**
       * May be used to limit the number of results to the most recent N dimension data.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    },
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface QueryOperationGroup {
  /**
   * Query the usage data for scope defined.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Query_Usage")
  @post
  @action("query")
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  @autoRoute
  usage(
    ...ApiVersionParameter,

    /**
     * The scope associated with query and export operations. This includes '/subscriptions/{subscriptionId}/' for subscription scope, '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope and '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, '/providers/Microsoft.Management/managementGroups/{managementGroupId} for Management Group scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for billingProfile scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}/invoiceSections/{invoiceSectionId}' for invoiceSection scope, and '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/customers/{customerId}' specific for partners.
     */
    @path(#{ allowReserved: true })
    scope: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Parameters supplied to the CreateOrUpdate Query Config operation.
     */
    @bodyRoot
    parameters: QueryDefinition,
  ): ArmResponse<QueryResult> | NoContentResponse | ErrorResponse;

  /**
   * Query the usage data for external cloud provider type defined.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Query_UsageByExternalCloudProviderType")
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  @autoRoute
  @action("query")
  usageByExternalCloudProviderType is ArmProviderActionSync<
    Request = QueryDefinition,
    Response = QueryResult,
    Parameters = {
      /**
       * The external cloud provider type associated with dimension/query operations. This includes 'externalSubscriptions' for linked account and 'externalBillingAccounts' for consolidated account.
       */
      @path
      externalCloudProviderType: ExternalCloudProviderType;

      /**
       * This can be '{externalSubscriptionId}' for linked account or '{externalBillingAccountId}' for consolidated account used with dimension/query operations.
       */
      @path
      externalCloudProviderId: string;
    },
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GenerateReservationDetailsReportOperationGroup {
  /**
   * Generates the reservations details report for provided date range asynchronously based on enrollment id. The Reservation usage details can be viewed only by certain enterprise roles. For more details on the roles see, https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/understand-ea-roles#usage-and-costs-access-by-role
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GenerateReservationDetailsReport_ByBillingAccountId")
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  @autoRoute
  @action("generateReservationDetailsReport")
  @post
  @armResourceCollectionAction
  byBillingAccountId(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Start Date
     */
    @query("startDate")
    startDate: string,

    /**
     * End Date
     */
    @query("endDate")
    endDate: string,
  ): ArmResponse<OperationStatus> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatus>> | ErrorResponse;
  /**
   * Generates the reservations details report for provided date range asynchronously by billing profile. The Reservation usage details can be viewed by only certain enterprise roles by default. For more details on the roles see, https://docs.microsoft.com/en-us/azure/cost-management-billing/reservations/reservation-utilization#view-utilization-in-the-azure-portal-with-azure-rbac-access
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GenerateReservationDetailsReport_ByBillingProfileId")
  @autoRoute
  @action("generateReservationDetailsReport")
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  @post
  @armResourceCollectionAction
  byBillingProfileId(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string,

    /**
     * Billing Profile ID.
     */
    @path
    @segment("billingProfiles")
    billingProfileId: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * Start Date
     */
    @query("startDate")
    startDate: string,

    /**
     * End Date
     */
    @query("endDate")
    endDate: string,
  ): ArmResponse<OperationStatus> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatus>> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface PriceSheetOperationGroup {
  /**
   * Gets a URL to download the pricesheet for an invoice. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PriceSheet_DownloadByInvoice")
  @autoRoute
  @action("pricesheets/default/download")
  @post
  @armResourceCollectionAction
  downloadByInvoice(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    @pattern("([A-Za-z0-9]+(-[A-Za-z0-9]+)+):([A-Za-z0-9]+(-[A-Za-z0-9]+)+)_[0-9]{4}-[0-9]{2}-[0-9]{2}")
    billingAccountName: string,

    /**
     * Billing Profile Name.
     */
    @path
    @segment("billingProfiles")
    @pattern("([A-Za-z0-9]+(-[A-Za-z0-9]+)+)")
    billingProfileName: string,

    /**
     * The ID that uniquely identifies an invoice.
     */
    @pattern("[A-Za-z0-9]+")
    @path
    @segment("invoices")
    invoiceName: string,

    ...Azure.ResourceManager.Legacy.Provider,
  ): DownloadURL | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = DownloadURL>> & {
    /**
     * The operation entity Id GUID.
     */
    @header("OData-EntityId")
    odataEntityId: string;
  }) | ErrorResponse;
  /**
   * Gets a URL to download the current month's pricesheet for a billing profile. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   *
   *  You can use the new 2023-09-01 API version for billing periods January 2023 onwards. Azure Reserved Instance (RI) pricing is only available through the new version of the API.
   *
   *  Due to Azure product growth, the Azure price sheet download experience in this preview version will be updated from a single csv/json file to a Zip file containing multiple csv/json files, each with max size of 75MB.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PriceSheet_DownloadByBillingProfile")
  @autoRoute
  @action("pricesheets/default/download")
  @post
  @armResourceCollectionAction
  downloadByBillingProfile(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    @pattern("([A-Za-z0-9]+(-[A-Za-z0-9]+)+):([A-Za-z0-9]+(-[A-Za-z0-9]+)+)_[0-9]{4}-[0-9]{2}-[0-9]{2}")
    billingAccountName: string,

    /**
     * Billing Profile Name.
     */
    @path
    @segment("billingProfiles")
    @pattern("([A-Za-z0-9]+(-[A-Za-z0-9]+)+)")
    billingProfileName: string,

    ...Azure.ResourceManager.Legacy.Provider,
  ): PricesheetDownloadProperties | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = PricesheetDownloadProperties>> & {
    /**
     * The operation entity Id GUID.
     */
    @header("OData-EntityId")
    odataEntityId: string;
  }) | ErrorResponse;

  /**
   * Generates the pricesheet for the provided billing period asynchronously based on the Enrollment ID. This is for Enterprise Agreement customers.
   *
   *  **Migrate to version 2025-03-01**
   *
   *  You can use the 2025-03-01 API version with the new URI:
   *
   *  '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingPeriods/{billingPeriodName}/providers/Microsoft.CostManagement/pricesheets/default/download'
   *
   *  With a new schema detailed below, the new version of the price sheet provides additional information and includes prices for Azure Reserved Instances (RI) for the current billing period. We recommend downloading an Azure Price Sheet for when entering a new billing period if you would maintain an ongoing record of past Azure Reserved Instance (RI) pricing.
   *
   *  The EA Azure price sheet is available for billing periods in the past 13 months. To request a price sheet for a billing period older than 13 months, please contact support.
   *
   *  The Azure price sheet download experience has been updated from a single .csv file to a zip file containing multiple .csv files, each with max size of 75MB. The 2023-11-01 version has been upgraded to use http POST method; details can be found below.
   *
   *  All versions of the Microsoft.Consumption Azure Price Sheet - Download by Billing Account (including 2022-06-01, 2021-10-01, 2020-01-01-preview, 2019-10-01, 2019-05-01) are scheduled to be retired on 01 June 2026 and will no longer be supported after this date.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PriceSheet_DownloadByBillingAccount")
  @autoRoute
  @post
  @action("pricesheets/default/download")
  @armResourceCollectionAction
  downloadByBillingAccount(
    ...ApiVersionParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "microsoft.Billing",

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string,

    /**
     * Billing Period Name.
     */
    @pattern("^[0-9]*$")
    @path
    @segment("billingPeriods")
    billingPeriodName: string,

    ...Azure.ResourceManager.Legacy.Provider,
  ): OperationStatus | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatus>> | CommonTypes.ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ScheduledActionsOperationGroup {
  /**
   * Checks availability and correctness of the name for a scheduled action.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ScheduledActions_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
    Response = Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
    Error = ErrorResponseWithNestedDetails
  >;
  /**
   * Checks availability and correctness of the name for a scheduled action within the given scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ScheduledActions_CheckNameAvailabilityByScope")
  @route("/{scope}/providers/Microsoft.CostManagement/checkNameAvailability")
  @post
  checkNameAvailabilityByScope(
    ...ApiVersionParameter,

    /**
     * The scope associated with scheduled action operations. This includes 'subscriptions/{subscriptionId}' for subscription scope, 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for BillingProfile scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/invoiceSections/{invoiceSectionId}' for InvoiceSection scope, 'providers/Microsoft.CostManagement/externalBillingAccounts/{externalBillingAccountName}' for External Billing Account scope and 'providers/Microsoft.CostManagement/externalSubscriptions/{externalSubscriptionName}' for External Subscription scope. Note: Insight Alerts are only available on subscription scope.
     */
    @path
    scope: string,

    /**
     * Scheduled action to be created or updated.
     */
    @bodyRoot
    checkNameAvailabilityRequest: Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
  ): ArmResponse<Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse> | ErrorResponseWithNestedDetails;
}

@armResourceOperations
interface GenerateCostDetailsReport {
  /**
   * Get the result of the specified operation. This link is provided in the CostDetails creation request response Location header.
   */
  #suppress "@azure-tools/typespec-client-generator-core/mark-as-lro-ineffective" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ClientGenerator.Core.Legacy.markAsLro
  getOperationResults(
    ...ApiVersionParameter,

    /**
     * The ARM Resource ID for subscription, billing account, or other billing scopes.Currently Resource Group and Management Group are not supported. For details, see https://aka.ms/costmgmt/scopes.
     */
    @path(#{ allowReserved: true })
    scope: string,

    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * The target operation Id.
     */
    @path
    @segment("costDetailsOperationResults")
    operationId: string,
  ): ArmResponse<CostDetailsOperationResults> | ArmAcceptedResponse | ErrorResponse;
}
