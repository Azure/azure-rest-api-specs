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

namespace Microsoft.Insights;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface MetricDefinitionsOperationGroup {
  /**
   * Lists the metric definitions for the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricDefinitions_ListAtSubscriptionScope")
  @autoRoute
  @get
  @action("metricDefinitions")
  @tag("MetricDefinitions")
  @list
  listAtSubscriptionScope is ArmProviderActionSync<
    Response = SubscriptionScopeMetricDefinitionCollection,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The region where the metrics you want reside.
       */
      @query("region")
      region: string;

      /**
       * Metric namespace where the metrics you want reside.
       */
      @query("metricnamespace")
      metricnamespace?: string;
    },
    Error = ErrorContract
  >;
  /**
   * Lists the metric definitions for the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricDefinitions_List")
  @autoRoute
  @get
  @action("metricDefinitions")
  @tag("MetricDefinitions")
  @list
  list is ArmProviderActionSync<
    Response = MetricDefinitionCollection,
    Scope = ExtensionResourceActionScope,
    Parameters = {
      /**
       * Metric namespace where the metrics you want reside.
       */
      @query("metricnamespace")
      metricnamespace?: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface MetricNamespacesOperationGroup {
  /**
   * Lists the metric namespaces for the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricNamespaces_List")
  @autoRoute
  @get
  @action("metricNamespaces")
  @tag("metricNamespaces")
  @list
  list is ArmProviderActionSync<
    Response = MetricNamespaceCollection,
    Scope = ExtensionResourceActionScope,
    Parameters = {
      /**
       * The ISO 8601 conform Date start time from which to query for metric namespaces.
       */
      @query("startTime")
      startTime?: string;
    },
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface MetricsOperationGroup {
  /**
   * **Lists the metric data for a subscription**. This API used the [default ARM throttling limits](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/request-limits-and-throttling).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Metrics_ListAtSubscriptionScope")
  @autoRoute
  @get
  @action("metrics")
  @tag("Metrics")
  listAtSubscriptionScope is ArmProviderActionSync<
    Response = Response,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The region where the metrics you want reside.
       */
      @query("region")
      region: string;

      /**
       * The timespan of the query. It is a string with the following format 'startDateTime_ISO/endDateTime_ISO'.
       */
      @query("timespan")
      timespan?: string;

      /**
       * The interval (i.e. timegrain) of the query in ISO 8601 duration format. Defaults to PT1M. Special case for 'FULL' value that returns single datapoint for entire time span requested.
       * *Examples: PT15M, PT1H, P1D, FULL*
       */
      @query("interval")
      interval?: string;

      /**
       * The names of the metrics (comma separated) to retrieve. Limit 20 metrics.
       */
      @query("metricnames")
      metricnames?: string;

      /**
       * The list of aggregation types (comma separated) to retrieve.
       * *Examples: average, minimum, maximum*
       */
      @query("aggregation")
      aggregation?: string;

      /**
       * The maximum number of records to retrieve per resource ID in the request.
       * Valid only if filter is specified.
       * Defaults to 10.
       */
      @query("top")
      top?: int32;

      /**
       * The aggregation to use for sorting results and the direction of the sort.
       * Only one order can be specified.
       * *Examples: sum asc*
       */
      @query("orderby")
      orderby?: string;

      /**
       * The **$filter** is used to reduce the set of metric data returned.<br>Example:<br>Metric contains metadata A, B and C.<br>- Return all time series of C where A = a1 and B = b1 or b2<br>**$filter=A eq ‘a1’ and B eq ‘b1’ or B eq ‘b2’ and C eq ‘*’**<br>- Invalid variant:<br>**$filter=A eq ‘a1’ and B eq ‘b1’ and C eq ‘*’ or B = ‘b2’**<br>This is invalid because the logical or operator cannot separate two different metadata names.<br>- Return all time series where A = a1, B = b1 and C = c1:<br>**$filter=A eq ‘a1’ and B eq ‘b1’ and C eq ‘c1’**<br>- Return all time series where A = a1<br>**$filter=A eq ‘a1’ and B eq ‘*’ and C eq ‘*’**.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Reduces the set of data collected. The syntax allowed depends on the operation. See the operation's description for details.
       */
      @query("resultType")
      resultType?: MetricResultType;

      /**
       * Metric namespace where the metrics you want reside.
       */
      @query("metricnamespace")
      metricnamespace?: string;

      /**
       * When set to true, if the timespan passed in is not supported by this metric, the API will return the result using the closest supported timespan. When set to false, an error is returned for invalid timespan parameters. Defaults to false.
       */
      @query("AutoAdjustTimegrain")
      AutoAdjustTimegrain?: boolean;

      /**
       * When set to false, invalid filter parameter values will be ignored. When set to true, an error is returned for invalid filter parameters. Defaults to true.
       */
      @query("ValidateDimensions")
      ValidateDimensions?: boolean;

      /**
       * Dimension name(s) to rollup results by. For example if you only want to see metric values with a filter like 'City eq Seattle or City eq Tacoma' but don't want to see separate values for each city, you can specify 'RollUpBy=City' to see the results for Seattle and Tacoma rolled up into one timeseries.
       */
      @query("rollupby")
      rollupby?: string;
    },
    Error = ErrorContract
  >;
  /**
   * **Lists the metric data for a subscription**. Parameters can be specified on either query params or the body. This API used the [default ARM throttling limits](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/request-limits-and-throttling).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Metrics_ListAtSubscriptionScopePost")
  @autoRoute
  @action("metrics")
  @tag("Metrics")
  listAtSubscriptionScopePost is ArmProviderActionSync<
    Request = SubscriptionScopeMetricsRequestBodyParameters,
    Response = Response,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The region where the metrics you want reside.
       */
      @query("region")
      region: string;

      /**
       * The timespan of the query. It is a string with the following format 'startDateTime_ISO/endDateTime_ISO'.
       */
      @query("timespan")
      timespan?: string;

      /**
       * The interval (i.e. timegrain) of the query in ISO 8601 duration format. Defaults to PT1M. Special case for 'FULL' value that returns single datapoint for entire time span requested.
       * *Examples: PT15M, PT1H, P1D, FULL*
       */
      @query("interval")
      interval?: string;

      /**
       * The names of the metrics (comma separated) to retrieve. Limit 20 metrics.
       */
      @query("metricnames")
      metricnames?: string;

      /**
       * The list of aggregation types (comma separated) to retrieve.
       * *Examples: average, minimum, maximum*
       */
      @query("aggregation")
      aggregation?: string;

      /**
       * The maximum number of records to retrieve per resource ID in the request.
       * Valid only if filter is specified.
       * Defaults to 10.
       */
      @query("top")
      top?: int32;

      /**
       * The aggregation to use for sorting results and the direction of the sort.
       * Only one order can be specified.
       * *Examples: sum asc*
       */
      @query("orderby")
      orderby?: string;

      /**
       * The **$filter** is used to reduce the set of metric data returned.<br>Example:<br>Metric contains metadata A, B and C.<br>- Return all time series of C where A = a1 and B = b1 or b2<br>**$filter=A eq ‘a1’ and B eq ‘b1’ or B eq ‘b2’ and C eq ‘*’**<br>- Invalid variant:<br>**$filter=A eq ‘a1’ and B eq ‘b1’ and C eq ‘*’ or B = ‘b2’**<br>This is invalid because the logical or operator cannot separate two different metadata names.<br>- Return all time series where A = a1, B = b1 and C = c1:<br>**$filter=A eq ‘a1’ and B eq ‘b1’ and C eq ‘c1’**<br>- Return all time series where A = a1<br>**$filter=A eq ‘a1’ and B eq ‘*’ and C eq ‘*’**.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Reduces the set of data collected. The syntax allowed depends on the operation. See the operation's description for details.
       */
      @query("resultType")
      resultType?: MetricResultType;

      /**
       * Metric namespace where the metrics you want reside.
       */
      @query("metricnamespace")
      metricnamespace?: string;

      /**
       * When set to true, if the timespan passed in is not supported by this metric, the API will return the result using the closest supported timespan. When set to false, an error is returned for invalid timespan parameters. Defaults to false.
       */
      @query("AutoAdjustTimegrain")
      AutoAdjustTimegrain?: boolean;

      /**
       * When set to false, invalid filter parameter values will be ignored. When set to true, an error is returned for invalid filter parameters. Defaults to true.
       */
      @query("ValidateDimensions")
      ValidateDimensions?: boolean;

      /**
       * Dimension name(s) to rollup results by. For example if you only want to see metric values with a filter like 'City eq Seattle or City eq Tacoma' but don't want to see separate values for each city, you can specify 'RollUpBy=City' to see the results for Seattle and Tacoma rolled up into one timeseries.
       */
      @query("rollupby")
      rollupby?: string;
    },
    OptionalRequestBody = true,
    Error = ErrorContract
  >;
  /**
   * **Lists the metric values for a resource**. This API used the [default ARM throttling limits](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/request-limits-and-throttling).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Metrics_List")
  @autoRoute
  @get
  @action("metrics")
  @tag("Metrics")
  list is ArmProviderActionSync<
    Response = Response,
    Scope = ExtensionResourceActionScope,
    Parameters = {
      /**
       * The timespan of the query. It is a string with the following format 'startDateTime_ISO/endDateTime_ISO'.
       */
      @query("timespan")
      timespan?: string;

      /**
       * The interval (i.e. timegrain) of the query in ISO 8601 duration format. Defaults to PT1M. Special case for 'FULL' value that returns single datapoint for entire time span requested.
       * *Examples: PT15M, PT1H, P1D, FULL*
       */
      @query("interval")
      interval?: string;

      /**
       * The names of the metrics (comma separated) to retrieve. Limit 20 metrics.
       */
      @query("metricnames")
      metricnames?: string;

      /**
       * The list of aggregation types (comma separated) to retrieve.
       * *Examples: average, minimum, maximum*
       */
      @query("aggregation")
      aggregation?: string;

      /**
       * The maximum number of records to retrieve per resource ID in the request.
       * Valid only if filter is specified.
       * Defaults to 10.
       */
      @query("top")
      top?: int32;

      /**
       * The aggregation to use for sorting results and the direction of the sort.
       * Only one order can be specified.
       * *Examples: sum asc*
       */
      @query("orderby")
      orderby?: string;

      /**
       * The **$filter** is used to reduce the set of metric data returned.<br>Example:<br>Metric contains metadata A, B and C.<br>- Return all time series of C where A = a1 and B = b1 or b2<br>**$filter=A eq ‘a1’ and B eq ‘b1’ or B eq ‘b2’ and C eq ‘*’**<br>- Invalid variant:<br>**$filter=A eq ‘a1’ and B eq ‘b1’ and C eq ‘*’ or B = ‘b2’**<br>This is invalid because the logical or operator cannot separate two different metadata names.<br>- Return all time series where A = a1, B = b1 and C = c1:<br>**$filter=A eq ‘a1’ and B eq ‘b1’ and C eq ‘c1’**<br>- Return all time series where A = a1<br>**$filter=A eq ‘a1’ and B eq ‘*’ and C eq ‘*’**.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Reduces the set of data collected. The syntax allowed depends on the operation. See the operation's description for details.
       */
      @query("resultType")
      resultType?: ResultType;

      /**
       * Metric namespace where the metrics you want reside.
       */
      @query("metricnamespace")
      metricnamespace?: string;

      /**
       * When set to true, if the timespan passed in is not supported by this metric, the API will return the result using the closest supported timespan. When set to false, an error is returned for invalid timespan parameters. Defaults to false.
       */
      @query("AutoAdjustTimegrain")
      AutoAdjustTimegrain?: boolean;

      /**
       * When set to false, invalid filter parameter values will be ignored. When set to true, an error is returned for invalid filter parameters. Defaults to true.
       */
      @query("ValidateDimensions")
      ValidateDimensions?: boolean;

      /**
       * Dimension name(s) to rollup results by. For example if you only want to see metric values with a filter like 'City eq Seattle or City eq Tacoma' but don't want to see separate values for each city, you can specify 'RollUpBy=City' to see the results for Seattle and Tacoma rolled up into one timeseries.
       */
      @query("rollupby")
      rollupby?: string;
    }
  >;
}
