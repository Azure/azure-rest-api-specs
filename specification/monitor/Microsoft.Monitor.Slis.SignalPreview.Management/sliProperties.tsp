import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.Monitor;

@doc("Represents a signal model used in SLI calculations.")
model Signal {
  @doc("Sources of metrics used for SLIs.")
  @OpenAPI.extension("x-ms-identifiers", #["signalSourceId"])
  signalSources: SignalSource[];

  @doc("Mathematical formula used to combine multiple metrics.")
  signalFormula: string;
}

@doc("Represents a signal source used in SLIs.")
model SignalSource {
  @doc("Unique identifier for the signal source.")
  signalSourceId: string;

  @doc("Managed identity for authenticating the signal source.")
  sourceAmwAccountManagedIdentity: string;

  @doc("Resource ID of the source AMW account.")
  sourceAmwAccountResourceId: string;

  @doc("Namespace of the metric.")
  metricNamespace: string;

  @doc("Name of the metric.")
  metricName: string;

  @doc("Filters applied to modify signal values.")
  @OpenAPI.extension(
    "x-ms-identifiers",
    #["dimensionName", "scalarFunction", "samplingType", "value", "operator"]
  )
  filters: Condition[];

  @doc("Defines how measurements are aggregated across multiple time series.")
  spatialAggregation: SpatialAggregation;

  @doc("Defines how measurements are aggregated over a specific time window within the same time series.")
  temporalAggregation?: TemporalAggregation;
}

@doc("Represents a filtering condition.")
model Condition {
  @doc("Dimension name used in filtering.")
  dimensionName?: string;

  @doc("Scalar function applied for filtering.")
  scalarFunction?: ScalarFunction;

  @doc("Defines the sampling type.")
  samplingType?: SamplingType;

  @doc("Operator used in the filtering condition.")
  operator: ConditionOperator;

  @doc("Value used in filtering.")
  value: string;
}

@doc("Defines scalar functions used in filtering.")
union ScalarFunction {
  @doc("Maximum value.")
  "max",

  @doc("Minimum value.")
  "min",

  @doc("Average value.")
  "avg",

  @doc("Summation.")
  "sum",

  string,
}

@doc("Defines the available sampling types.")
union SamplingType {
  @doc("Maximum value.")
  "max",

  @doc("Minimum value.")
  "min",

  @doc("Average value.")
  "avg",

  @doc("Summation.")
  "sum",

  string,
}

@doc("Defines operators used in filter conditions.")
union ConditionOperator {
  @doc("Equal to.")
  Equal: "==",

  @doc("Not equal to.")
  NotEqual: "!=",

  @doc("Less than.")
  LessThan: "<",

  @doc("Less than or equal to.")
  LessThanOrEqual: "<=",

  @doc("Greater than.")
  GreaterThan: ">",

  @doc("Greater than or equal to.")
  GreaterThanOrEqual: ">=",

  @doc("In operator.")
  In: "@in",

  @doc("Not in.")
  NotIn: "!in",

  @doc("Starts with.")
  StartsWith: "startswith",

  @doc("Does not start with.")
  NotStartsWith: "!startswith",

  @doc("Contains the value.")
  Contains: "contains",

  @doc("Does not contain the value.")
  NotContains: "!contains",

  string,
}

@doc("Represents the spatial aggregation model.")
model SpatialAggregation {
  @doc("Type of spatial aggregation.")
  type: SpatialAggregationType;

  @doc("Dimensions considered for spatial aggregation.")
  dimensions: string[];
}

@doc("Defines the available aggregation types.")
union TemporalAggregationType {
  @doc("Average value.")
  "Average",

  @doc("Minimum value.")
  "Min",

  @doc("Maximum value.")
  "Max",

  @doc("Summation.")
  "Sum",

  @doc("Rate over time.")
  "Rate",

  @doc("Instance rate.")
  "IRate",

  @doc("Delta over time.")
  "Delta",

  @doc("Instance delta.")
  "IDelta",

  @doc("Increase over time.")
  "Increase",

  string,
}

@doc("Defines the available aggregation types.")
union SpatialAggregationType {
  @doc("Average value.")
  "Average",

  @doc("Minimum value.")
  "Min",

  @doc("Maximum value.")
  "Max",

  @doc("Summation.")
  "Sum",

  @doc("Count of occurrences.")
  "Count",

  string,
}

@doc("Represents criteria for determining uptime in window-based SLIs.")
model WindowUptimeCriteria {
  @doc("Threshold value used to determine uptime.")
  @minValue(0)
  target: float32;

  @doc("Comparison operator used for uptime evaluation.")
  comparator: WindowUptimeCriteriaComparator;
}

@doc("Defines comparison operators for window uptime criteria.")
union WindowUptimeCriteriaComparator {
  @doc("Less than the target value.")
  LessThan: "<",

  @doc("Greater than the target value.")
  GreaterThan: ">",

  @doc("Less than or equal to the target value.")
  LessThanOrEqual: "<=",

  @doc("Greater than or equal to the target value.")
  GreaterThanOrEqual: ">=",

  string,
}

@doc("Represents temporal aggregation settings.")
model TemporalAggregation {
  @doc("Type of temporal aggregation.")
  type: TemporalAggregationType;

  @doc("Time window size for aggregation, in minutes.")
  windowSizeMinutes: int32;
}
