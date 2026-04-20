import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Microsoft.Common;

namespace Microsoft.Metrics;

/**
 * The class of the metric.
 */
union MetricClass {
  string,

  /**
   * Availability
   */
  Availability: "Availability",

  /**
   * Transactions
   */
  Transactions: "Transactions",

  /**
   * Errors
   */
  Errors: "Errors",

  /**
   * Latency
   */
  Latency: "Latency",

  /**
   * Saturation
   */
  Saturation: "Saturation",
}

/**
 * The unit of the metric.
 */
union MetricUnit {
  string,

  /**
   * Unit of raw quantity.
   */
  Count: "Count",

  /**
   * Unit of memory in bytes.
   */
  Bytes: "Bytes",

  /**
   * Unit of time in seconds.
   */
  Seconds: "Seconds",

  /**
   * Rate unit of raw quantity per second.
   */
  CountPerSecond: "CountPerSecond",

  /**
   * Rate unit of memory in bytes per second.
   */
  BytesPerSecond: "BytesPerSecond",

  /**
   * Percentage unit.
   */
  Percent: "Percent",

  /**
   * Unit of time in 1/1000th of a second.
   */
  MilliSeconds: "MilliSeconds",

  /**
   * Unit of data transfer or storage. It is the size of the data in bytes multiplied by the time it takes to transfer or store the data in seconds.
   */
  ByteSeconds: "ByteSeconds",

  /**
   * No specified unit.
   */
  Unspecified: "Unspecified",

  /**
   * Unit of processing power.
   */
  Cores: "Cores",

  /**
   * Unit of processing power in 1/1000th of a CPU core.
   */
  MilliCores: "MilliCores",

  /**
   * Unit of processing power in one billionth of a CPU core.
   */
  NanoCores: "NanoCores",

  /**
   * Rate unit of binary digits per second.
   */
  BitsPerSecond: "BitsPerSecond",
}

/**
 * The aggregation type of the metric.
 */
union MetricAggregationType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Average
   */
  Average: "Average",

  /**
   * Count
   */
  Count: "Count",

  /**
   * Minimum
   */
  Minimum: "Minimum",

  /**
   * Maximum
   */
  Maximum: "Maximum",

  /**
   * Total
   */
  Total: "Total",
}

/**
 * Kind of namespace
 */
union NamespaceClassification {
  string,

  /**
   * Platform
   */
  Platform: "Platform",

  /**
   * Custom
   */
  Custom: "Custom",

  /**
   * Qos
   */
  Qos: "Qos",
}

/**
 * Reduces the set of data collected. The syntax allowed depends on the operation. See the operation's description for details.
 */
union MetricResultType {
  string,

  /**
   * Data
   */
  Data: "Data",

  /**
   * Metadata
   */
  Metadata: "Metadata",
}

/**
 * The aggregation type of the metric.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AggregationType {
  /**
   * None
   */
  None,

  /**
   * Average
   */
  Average,

  /**
   * Count
   */
  Count,

  /**
   * Minimum
   */
  Minimum,

  /**
   * Maximum
   */
  Maximum,

  /**
   * Total
   */
  Total,
}

/**
 * Represents collection of metric definitions.
 */
model SubscriptionScopeMetricDefinitionCollection {
  /**
   * The values for the metric definitions.
   */
  @pageItems
  value: SubscriptionScopeMetricDefinition[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: string;
}

/**
 * Metric definition class specifies the metadata for a metric.
 */
model SubscriptionScopeMetricDefinition {
  /**
   * Flag to indicate whether the dimension is required.
   */
  isDimensionRequired?: boolean;

  /**
   * The resource identifier of the resource that emitted the metric.
   */
  resourceId?: string;

  /**
   * The namespace the metric belongs to.
   */
  `namespace`?: string;

  /**
   * The name and the display name of the metric, i.e. it is a localizable string.
   */
  name?: LocalizableString;

  /**
   * Detailed description of this metric.
   */
  displayDescription?: string;

  /**
   * Custom category name for this metric.
   */
  category?: string;

  /**
   * The class of the metric.
   */
  metricClass?: MetricClass;

  /**
   * The unit of the metric.
   */
  unit?: MetricUnit;

  /**
   * The primary aggregation type value defining how to use the values for display.
   */
  primaryAggregationType?: MetricAggregationType;

  /**
   * The collection of what aggregation types are supported.
   */
  supportedAggregationTypes?: MetricAggregationType[];

  /**
   * The collection of what aggregation intervals are available to be queried.
   */
  @identifiers(#["timeGrain"])
  metricAvailabilities?: MetricAvailability[];

  /**
   * The resource identifier of the metric definition.
   */
  id?: string;

  /**
   * The name and the display name of the dimension, i.e. it is a localizable string.
   */
  @identifiers(#["value"])
  dimensions?: LocalizableString[];
}

/**
 * Metric availability specifies the time grain (aggregation interval or frequency) and the retention period for that time grain.
 */
model MetricAvailability {
  /**
   * The time grain specifies a supported aggregation interval for the metric. Expressed as a duration 'PT1M', 'P1D', etc.
   */
  timeGrain?: duration;

  /**
   * The retention period for the metric at the specified timegrain.  Expressed as a duration 'PT1M', 'P1D', etc.
   */
  retention?: duration;
}

/**
 * Represents collection of metric definitions.
 */
model MetricDefinitionCollection {
  /**
   * The values for the metric definitions.
   */
  @pageItems
  value: MetricDefinition[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: string;
}

/**
 * Metric definition class specifies the metadata for a metric.
 */
model MetricDefinition {
  /**
   * Flag to indicate whether the dimension is required.
   */
  isDimensionRequired?: boolean;

  /**
   * The resource identifier of the resource that emitted the metric.
   */
  resourceId?: string;

  /**
   * The namespace the metric belongs to.
   */
  `namespace`?: string;

  /**
   * The name and the display name of the metric, i.e. it is a localizable string.
   */
  name?: LocalizableString;

  /**
   * Detailed description of this metric.
   */
  displayDescription?: string;

  /**
   * Custom category name for this metric.
   */
  category?: string;

  /**
   * The class of the metric.
   */
  metricClass?: MetricClass;

  /**
   * The unit of the metric.
   */
  unit?: MetricUnit;

  /**
   * The primary aggregation type value defining how to use the values for display.
   */
  primaryAggregationType?: AggregationType;

  /**
   * The collection of what aggregation types are supported.
   */
  supportedAggregationTypes?: AggregationType[];

  /**
   * The collection of what aggregation intervals are available to be queried.
   */
  @identifiers(#["timeGrain"])
  metricAvailabilities?: MetricAvailability[];

  /**
   * The resource identifier of the metric definition.
   */
  id?: string;

  /**
   * The name and the display name of the dimension, i.e. it is a localizable string.
   */
  @identifiers(#["value"])
  dimensions?: LocalizableString[];
}

/**
 * Represents collection of metric namespaces.
 */
model MetricNamespaceCollection {
  /**
   * The values for the metric namespaces.
   */
  @pageItems
  value: MetricNamespace[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: string;
}

/**
 * Metric namespace class specifies the metadata for a metric namespace.
 */
model MetricNamespace {
  /**
   * The ID of the metric namespace.
   */
  id?: string;

  /**
   * The type of the namespace.
   */
  type?: string;

  /**
   * The escaped name of the namespace.
   */
  name?: string;

  /**
   * Kind of namespace
   */
  classification?: NamespaceClassification;

  /**
   * Properties which include the fully qualified namespace name.
   */
  properties?: MetricNamespaceName;
}

/**
 * The fully qualified metric namespace name.
 */
model MetricNamespaceName {
  /**
   * The metric namespace name.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  metricNamespaceName?: string;
}

/**
 * The response to a metrics query.
 */
model Response {
  /**
   * The integer value representing the relative cost of the query.
   */
  @minValue(0)
  cost?: int32;

  /**
   * The timespan for which the data was retrieved. Its value consists of two datetimes concatenated, separated by '/'.  This may be adjusted in the future and returned back from what was originally requested.
   */
  timespan: string;

  /**
   * The interval (window size) for which the metric data was returned in ISO 8601 duration format with a special case for 'FULL' value that returns single datapoint for entire time span requested (*Examples: PT15M, PT1H, P1D, FULL*).
   * This may be adjusted and different from what was originally requested if AutoAdjustTimegrain=true is specified. This is not present if a metadata request was made.
   */
  interval?: string;

  /**
   * The namespace of the metrics being queried
   */
  `namespace`?: string;

  /**
   * The region of the resource being queried for metrics.
   */
  resourceregion?: string;

  /**
   * The value of the collection.
   */
  value: Metric[];
}

/**
 * The result data of a query.
 */
model Metric {
  /**
   * The metric Id.
   */
  id: string;

  /**
   * The resource type of the metric resource.
   */
  type: string;

  /**
   * The name and the display name of the metric, i.e. it is localizable string.
   */
  name: LocalizableString;

  /**
   * Detailed description of this metric.
   */
  displayDescription?: string;

  /**
   * 'Success' or the error details on query failures for this metric.
   */
  errorCode?: string;

  /**
   * Error message encountered querying this specific metric.
   */
  errorMessage?: string;

  /**
   * The unit of the metric.
   */
  unit: MetricUnit;

  /**
   * The time series returned when a data query is performed.
   */
  @identifiers(#[])
  timeseries: TimeSeriesElement[];
}

/**
 * A time series result type. The discriminator value is always TimeSeries in this case.
 */
model TimeSeriesElement {
  /**
   * The metadata values returned if $filter was specified in the call.
   */
  @identifiers(#["name"])
  metadatavalues?: MetadataValue[];

  /**
   * An array of data points representing the metric values.  This is only returned if a result type of data is specified.
   */
  @identifiers(#["timeStamp"])
  data?: MetricValue[];
}

/**
 * Represents a metric metadata value.
 */
model MetadataValue {
  /**
   * The name of the metadata.
   */
  name?: LocalizableString;

  /**
   * The value of the metadata.
   */
  value?: string;
}

/**
 * Represents a metric value.
 */
model MetricValue {
  /**
   * The timestamp for the metric value in ISO 8601 format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStamp: utcDateTime;

  /**
   * The average value in the time range.
   */
  average?: float64;

  /**
   * The least value in the time range.
   */
  minimum?: float64;

  /**
   * The greatest value in the time range.
   */
  maximum?: float64;

  /**
   * The sum of all of the values in the time range.
   */
  total?: float64;

  /**
   * The number of samples in the time range. Can be used to determine the number of values that contributed to the average value.
   */
  count?: float64;
}

/**
 * Query parameters can also be specified in the body, specifying the same parameter in both the body and query parameters will result in an error.
 */
model SubscriptionScopeMetricsRequestBodyParameters {
  /**
   * The timespan of the query. It is a string with the following format 'startDateTime_ISO/endDateTime_ISO'.
   */
  timespan?: string;

  /**
   * The interval (i.e. timegrain) of the query in ISO 8601 duration format. Defaults to PT1M. Special case for 'FULL' value that returns single datapoint for entire time span requested.
   * *Examples: PT15M, PT1H, P1D, FULL*
   */
  interval?: string;

  /**
   * The names of the metrics (comma separated) to retrieve.
   */
  metricNames?: string;

  /**
   * The list of aggregation types (comma separated) to retrieve.
   */
  aggregation?: string;

  /**
   * The **$filter** is used to reduce the set of metric data returned.<br>Example:<br>Metric contains metadata A, B and C.<br>- Return all time series of C where A = a1 and B = b1 or b2<br>**$filter=A eq ‘a1’ and B eq ‘b1’ or B eq ‘b2’ and C eq ‘*’**<br>- Invalid variant:<br>**$filter=A eq ‘a1’ and B eq ‘b1’ and C eq ‘*’ or B = ‘b2’**<br>This is invalid because the logical or operator cannot separate two different metadata names.<br>- Return all time series where A = a1, B = b1 and C = c1:<br>**$filter=A eq ‘a1’ and B eq ‘b1’ and C eq ‘c1’**<br>- Return all time series where A = a1<br>**$filter=A eq ‘a1’ and B eq ‘*’ and C eq ‘*’**.
   */
  filter?: string;

  /**
   * The maximum number of records to retrieve.
   * Valid only if $filter is specified.
   * Defaults to 10.
   */
  top?: int32;

  /**
   * The aggregation to use for sorting results and the direction of the sort.
   * Only one order can be specified.
   * Examples: sum asc.
   */
  orderBy?: string;

  /**
   * Dimension name(s) to rollup results by. For example if you only want to see metric values with a filter like 'City eq Seattle or City eq Tacoma' but don't want to see separate values for each city, you can specify 'RollUpBy=City' to see the results for Seattle and Tacoma rolled up into one timeseries.
   */
  rollUpBy?: string;

  /**
   * Reduces the set of data collected. The syntax allowed depends on the operation. See the operation's description for details.
   */
  resultType?: MetricResultType;

  /**
   * Metric namespace where the metrics you want reside.
   */
  metricNamespace?: string;

  /**
   * When set to true, if the timespan passed in is not supported by this metric, the API will return the result using the closest supported timespan. When set to false, an error is returned for invalid timespan parameters. Defaults to false.
   */
  autoAdjustTimegrain?: boolean;

  /**
   * When set to false, invalid filter parameter values will be ignored. When set to true, an error is returned for invalid filter parameters. Defaults to true.
   */
  validateDimensions?: boolean;
}
