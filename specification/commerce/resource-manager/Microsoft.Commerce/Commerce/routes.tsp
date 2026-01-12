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

namespace Microsoft.Commerce;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface UsageAggregatesOperationGroup {
  /**
   * Query aggregated Azure subscription consumption data for a date range.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("https://docs.microsoft.com/rest/api/commerce/usageaggregates")
  @autoRoute
  @get
  @list
  @action("UsageAggregates")
  list is ArmProviderActionSync<
    Response = ResourceListResult<UsageAggregation> | (ArmAcceptedResponse &
      ErrorObjectResponse),
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The start of the time range to retrieve data for.
       */
      @query("reportedStartTime")
      reportedStartTime: utcDateTime;

      /**
       * The end of the time range to retrieve data for.
       */
      @query("reportedEndTime")
      reportedEndTime: utcDateTime;

      /**
       * `True` returns usage data in instance-level detail, `false` causes server-side aggregation with fewer details. For example, if you have 3 website instances, by default you will get 3 line items for website consumption. If you specify showDetails = false, the data will be aggregated as a single line item for website consumption within the time period (for the given subscriptionId, meterId, usageStartTime and usageEndTime).
       */
      @query("showDetails")
      showDetails?: boolean;

      /**
       * `Daily` (default) returns the data in daily granularity, `Hourly` returns the data in hourly granularity.
       */
      @query("aggregationGranularity")
      aggregationGranularity?: AggregationGranularity = AggregationGranularity.Daily;

      /**
       * Used when a continuation token string is provided in the response body of the previous call, enabling paging through a large result set. If not present, the data is retrieved from the beginning of the day/hour (based on the granularity) passed in.
       */
      @query("continuationToken")
      continuationToken?: string;
    },
    Error = ErrorObjectResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface RateCardOperationGroup {
  /**
   * Enables you to query for the resource/meter metadata and related prices used in a given subscription by Offer ID, Currency, Locale and Region. The metadata associated with the billing meters, including but not limited to service names, types, resources, units of measure, and regions, is subject to change at any time and without notice. If you intend to use this billing data in an automated fashion, please use the billing meter GUID to uniquely identify each billable item. If the billing meter GUID is scheduled to change due to a new billing model, you will be notified in advance of the change.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @get
  @action("RateCard")
  @OpenAPI.externalDocs("https://docs.microsoft.com/rest/api/commerce/ratecard")
  get is ArmProviderActionSync<
    Response = ResourceRateCardInfo,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The filter to apply on the operation. It ONLY supports the 'eq' and 'and' logical operators at this time. All the 4 query parameters 'OfferDurableId',  'Currency', 'Locale', 'Region' are required to be a part of the $filter.
       */
      @query
      $filter: string;
    },
    Error = ErrorResponse
  >;
}
