import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@useAuth(AadOauth2Auth<["https://exp.azure.net/.default"]>)
@service(#{ title: "Azure.Analytics.OnlineExperimentation service" })
@versioned(Azure.Analytics.OnlineExperimentation.Versions)
@server(
  "{endpoint}",
  "Online Experimentation service",
  {
    @doc("Endpoint URL for the Online Experimentation workspace.")
    endpoint: url,
  }
)
namespace Azure.Analytics.OnlineExperimentation;

@doc("The Azure Online Experimentation service versions.")
enum Versions {
  @doc("The 2025-05-31-preview version of the Azure Online Experimentation service.")
  `2025-05-31-preview`,
}

@doc("Desired direction for an experiment metric value.")
union DesiredDirection {
  @doc("An increase to the metric value is desired. E.g., Success rate, Total revenue.")
  Increase: "Increase",

  @doc("A decrease to the metric value is desired. E.g., Error rate, Latency.")
  Decrease: "Decrease",

  @doc("Neither an increase nor a decrease to the metric value is desired, or the desired direction depends on other factors. E.g., Number of video play attempts, Number of user feedbacks")
  Neutral: "Neutral",

  string,
}

@doc("""
  A condition to filter events. Accepts a Kusto Query Language (KQL) filter predicate. 
  Allowed expressions evaluate to a bool data type and use a subset of KQL syntax:
  Event properties: plain or bracket notation.
  Literals: bool, long, real, string.
  Comparison operators: ==, !=, <, <=, >, >=.
  Boolean operators: and, or.
  Grouping operations: parentheses.
  """)
@example("Revenue > 0")
@example("['transaction.revenue'] > 0")
@example("(Page == 'checkout.html') or (Page == 'cart.html')")
@minLength(1)
@maxLength(1000)
scalar EventCondition extends string;

@doc("A category attached to the metric.")
@pattern("^[a-zA-Z0-9 _:()&-]+$")
@maxLength(30)
@minLength(1)
scalar Category extends string;

@doc("An event observed by a metric.")
model ObservedEvent {
  @doc("The name of the event.")
  @maxLength(200)
  @minLength(1)
  eventName: string;

  @doc("[Optional] A condition to filter events.")
  filter?: EventCondition;
}

@doc("An event property value aggregated by a metric.")
model AggregatedValue {
  ...ObservedEvent;

  @doc("The key of the event property to aggregate.")
  @maxLength(200)
  @minLength(1)
  @pattern("^[a-zA-Z0-9_ -.]+$")
  eventProperty: string;
}

@doc("How the metric definition calculates metric values from event data.")
union ExperimentMetricType {
  @doc("Counts the occurrences of an event. Experiment analysis accounts for unequal traffic allocation.")
  EventCount: "EventCount",

  @doc("Counts the number of unique users who encounter an event. Experiment analysis accounts for unequal traffic allocation.")
  UserCount: "UserCount",

  @doc("Calculates the percentage of events that satisfy a specified condition.")
  EventRate: "EventRate",

  @doc("Calculates the percentage of users who encounter a start event and subsequently encounter an end event. Users must encounter the start event before the end event to be counted.")
  UserRate: "UserRate",

  @doc("Calculates the sum of a specified event property. Experiment analysis accounts for unequal traffic allocation.")
  Sum: "Sum",

  @doc("Calculates the average value of a specified event property.")
  Average: "Average",

  @doc("Calculates a specified percentile of an event property.")
  Percentile: "Percentile",

  string,
}

@doc("The definition of an EventCount metric definition. Counts the occurrences of a specified event.")
model EventCountMetricDefinition extends ExperimentMetricDefinition {
  @doc("The type of metric.")
  type: ExperimentMetricType.EventCount;

  @doc("Event to observe.")
  event: ObservedEvent;
}

@doc("The definition of a UserCount metric definition. Counts unique users who encounter a specified event.")
model UserCountMetricDefinition extends ExperimentMetricDefinition {
  @doc("The type of metric.")
  type: ExperimentMetricType.UserCount;

  @doc("Event to observe.")
  event: ObservedEvent;
}

@doc("The definition of an EventRate metric definition. Calculates the percentage of events satisfying a specified condition.")
model EventRateMetricDefinition extends ExperimentMetricDefinition {
  @doc("The type of metric.")
  type: ExperimentMetricType.EventRate;

  @doc("Event to observe as the rate denominator.")
  event: ObservedEvent;

  @doc("The event contributes to the rate numerator if it satisfies this condition.")
  rateCondition: EventCondition;
}

@doc("The definition of a UserRate metric definition. Calculates the percentage of users who encounter a start event and subsequently an end event. Users must encounter events in the specified order.")
model UserRateMetricDefinition extends ExperimentMetricDefinition {
  @doc("The type of metric.")
  type: ExperimentMetricType.UserRate;

  @doc("The start event to observe as the rate denominator.")
  startEvent: ObservedEvent;

  @doc("The end event to observe, which is a condition for the rate numerator.")
  endEvent: ObservedEvent;
}

@doc("The definition of a Sum metric definition. Calculates the sum of a specified event property. Experiment analysis accounts for unequal traffic allocation.")
model SumMetricDefinition extends ExperimentMetricDefinition {
  @doc("The type of metric.")
  type: ExperimentMetricType.Sum;

  @doc("The value to aggregate.")
  value: AggregatedValue;
}

@doc("The definition of an Average metric definition. Calculates the average value of a specified event property.")
model AverageMetricDefinition extends ExperimentMetricDefinition {
  @doc("The type of metric.")
  type: ExperimentMetricType.Average;

  @doc("The value to aggregate.")
  value: AggregatedValue;
}

@doc("The definition of a Percentile metric definition. Calculates a specified percentile of an event property.")
model PercentileMetricDefinition extends ExperimentMetricDefinition {
  @doc("The type of metric.")
  type: ExperimentMetricType.Percentile;

  @doc("The value to aggregate, including the event name and property to measure.")
  value: AggregatedValue;

  @doc("The percentile to measure.")
  @minValueExclusive(0)
  @maxValueExclusive(100)
  percentile: float64;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Union discriminator with different types are not supported in swagger v2"
@doc("The metric definition, which determines how the metric value is calculated from event data.")
@discriminator("type")
model ExperimentMetricDefinition {}

@doc("Lifecycle stages of an experiment metric, determining whether the metric is included in experiment analysis.")
union LifecycleStage {
  @doc("The metric is included in experiment analysis.")
  Active: "Active",

  @doc("The metric is excluded from experiment analysis but remains available for future use.")
  Inactive: "Inactive",

  string,
}

@doc("Defines experiment metric metadata and computation details.")
@resource("experiment-metrics")
model ExperimentMetric {
  @key("experimentMetricId")
  @doc("Identifier for this experiment metric. Must start with a lowercase letter and contain only lowercase letters, numbers, and underscores.")
  @visibility(Lifecycle.Read)
  @maxLength(50)
  @minLength(1)
  @pattern("^[a-z_][a-z0-9_]*$")
  id: string;

  @doc("Determines whether it is included in experiment analysis.")
  lifecycle: LifecycleStage;

  @doc("A user-friendly display name for the experiment metric shown in reports and dashboards.")
  @minLength(1)
  @maxLength(200)
  displayName: string;

  @doc("A detailed description of the experiment metric.")
  @minLength(1)
  @maxLength(1000)
  description: string;

  @doc("Categories associated with the experiment metric. Used for organizing and filtering metrics.")
  categories: Category[];

  @doc("The desired direction for changes in the metric value.")
  desiredDirection: DesiredDirection;

  @doc("The metric definition specifying how the metric value is calculated from event data.")
  definition: ExperimentMetricDefinition;

  @doc("ETag of the experiment metric.")
  @visibility(Lifecycle.Read)
  eTag: eTag;

  @doc("The timestamp (UTC) of the last modification to the experiment metric resource.")
  @visibility(Lifecycle.Read)
  lastModifiedAt: utcDateTime;
}

@doc("The diagnostic error codes.")
union DiagnosticCode {
  @doc("The metric definition does not conform to the required schema.")
  FailedSchemaValidation: "FailedSchemaValidation",

  @doc("The filter condition is invalid.")
  InvalidEventCondition: "InvalidEventCondition",

  @doc("The filter condition is valid but not currently supported.")
  UnsupportedEventCondition: "UnsupportedEventCondition",

  @doc("""
    The provided metric definition is invalid.
    For example, defining a metric to calculate the average of a numeric property but
    including a filter condition that compares it to a string value creates a type mismatch.
    """)
  InvalidExperimentMetricDefinition: "InvalidExperimentMetricDefinition",

  string,
}

@doc("Diagnostic details for validation errors.")
model DiagnosticDetail {
  @doc("A human-readable error message.")
  @visibility(Lifecycle.Read)
  message: string;

  @doc("The diagnostic error code.")
  @visibility(Lifecycle.Read)
  code: DiagnosticCode;
}

@doc("The result of validating an experiment metric.")
model ExperimentMetricValidationResult {
  @doc("Indicates whether the experiment metric is valid.")
  isValid: boolean;

  @doc("Diagnostic details from the validation process.")
  @visibility(Lifecycle.Read)
  diagnostics: DiagnosticDetail[];
}

alias ServiceTraits = Traits.NoRepeatableRequests &
  Traits.SupportsConditionalRequests &
  Traits.SupportsClientRequestId;

alias Operations = ResourceOperations<ServiceTraits>;

alias BodyParameter<T, TDoc extends valueof string> = {
  @doc(TDoc)
  @bodyRoot
  body: T;
};

@doc("Fetches an experiment metric by ID.")
op getMetric is Operations.ResourceRead<ExperimentMetric>;

@doc("Creates or updates an experiment metric.")
op createOrUpdateMetric is Operations.ResourceCreateOrUpdate<ExperimentMetric>;

@doc("Validates an experiment metric definition.")
@action("validate")
op validateMetric is Operations.ResourceCollectionAction<
  ExperimentMetric,
  BodyParameter<ExperimentMetric, "Experiment metric input to validate">,
  ExperimentMetricValidationResult,
  {}
>;

@doc("Deletes an experiment metric.")
op deleteMetric is Operations.ResourceDelete<ExperimentMetric>;

@doc("Lists experiment metrics.")
op listMetrics is Operations.ResourceList<
  ExperimentMetric,
  ListQueryParametersTrait<StandardListQueryParameters>
>;
