import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Commerce;
using Http;
using Azure.ResourceManager;

@@clientName(Microsoft.Commerce, "UsageManagementClient", "python, javascript");

/**
 * override for UsageAggregatesOperationGroup.list
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op usageAggregatesOperationGroupList(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  scope: SubscriptionActionScope,
  ...Azure.ResourceManager.Legacy.Provider,

  /**
   * The start of the time range to retrieve data for.
   */
  @query("reportedStartTime")
  reportedStartTime: utcDateTime,

  /**
   * The end of the time range to retrieve data for.
   */
  @query("reportedEndTime")
  reportedEndTime: utcDateTime,

  /**
   * `True` returns usage data in instance-level detail, `false` causes server-side aggregation with fewer details. For example, if you have 3 website instances, by default you will get 3 line items for website consumption. If you specify showDetails = false, the data will be aggregated as a single line item for website consumption within the time period (for the given subscriptionId, meterId, usageStartTime and usageEndTime).
   */
  @query("showDetails")
  showDetails?: boolean,

  /**
   * `Daily` (default) returns the data in daily granularity, `Hourly` returns the data in hourly granularity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @query("aggregationGranularity")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("Daily")
  aggregationGranularity?: AggregationGranularity = AggregationGranularity.Daily,

  continuationToken: string,
  body: void,
): Azure.ResourceManager.ResourceListResult<Microsoft.Commerce.UsageAggregation> | Microsoft.Commerce.ErrorObjectResponse;

@@override(UsageAggregatesOperationGroup.list,
  usageAggregatesOperationGroupList,
  "javascript"
);
