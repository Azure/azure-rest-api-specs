import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@useAuth(AadOauth2Auth<["https://exp.azure.net/.default"]>)
@service(#{
  title: "Azure.Analytics.OnlineExperimentation service",
})
@versioned(Azure.Analytics.OnlineExperimentation.Versions)
namespace Azure.Analytics.OnlineExperimentation;

@doc("The Azure.Analytics.OnlineExperimentation service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-11-30-preview version of the Azure.Analytics.OnlineExperimentation service.")
  `2024-11-30-preview`,
}

@doc("Desired direction of the metric.")
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

@doc("A tag attached to the metric.")
@pattern("^[a-zA-Z0-9 _:()&-]+$")
@maxLength(30)
@minLength(1)
scalar Tag extends string;

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

@doc("How the metric should be calculated from the event data.")
union MetricKind {
  @doc("Count the observations of an event. Experiment analysis accounts for unequal traffic allocation.")
  EventCount: "EventCount",

  @doc("Count the users who encounter an event. Experiment analysis accounts for unequal traffic allocation.")
  UserCount: "UserCount",

  @doc("Count the percentage of events that satisfy a condition.")
  EventRate: "EventRate",

  @doc("Count the percentage of users with the start event that then encounter the end event. The metric denominator counts the number of users who encounter the start event at least once. The metric numerator counts the number of users who encounter both the start and end events at least once. The computation is ordered, so the start event must occur before the end event.")
  UserRate: "UserRate",

  @doc("The sum of an event property. Experiment analysis accounts for unequal traffic allocation.")
  Sum: "Sum",

  @doc("The average of an event property.")
  Average: "Average",

  @doc("The percentile of an event property.")
  Percentile: "Percentile",

  string,
}

@doc("The definition of an EventCount metric. This metric kind counts the observations of an event. Experiment analysis accounts for unequal traffic allocation.")
model EventCountDefinition extends MetricDefinition {
  @doc("The kind of metric.")
  kind: MetricKind.EventCount;

  @doc("Event to observe.")
  event: ObservedEvent;
}

@doc("The definition of a UserCount metric. This metric kind counts the users who encounter an event. Experiment analysis accounts for unequal traffic allocation.")
model UserCountDefinition extends MetricDefinition {
  @doc("The kind of metric.")
  kind: MetricKind.UserCount;

  @doc("Event to observe.")
  event: ObservedEvent;
}

@doc("The definition of an EventRate metric. This metric kind counts the percentage of events that satisfy a condition.")
model EventRateDefinition extends MetricDefinition {
  @doc("The kind of metric.")
  kind: MetricKind.EventRate;

  @doc("Event to observe as the rate denominator.")
  event: ObservedEvent;

  @doc("The event contributes to the rate numerator if it satisfies this condition.")
  condition: EventCondition;
}

@doc("The definition of a UserRate metric. This metric kind counts the percentage of users with the start event that then encounter the end event. The metric denominator counts the number of users who encounter the start event at least once. The metric numerator counts the number of users who encounter both the start and end events at least once. The computation is ordered, so the start event must occur before the end event.")
model UserRateDefinition extends MetricDefinition {
  @doc("The kind of metric.")
  kind: MetricKind.UserRate;

  @doc("The start event to observe as the rate denominator.")
  startEvent: ObservedEvent;

  @doc("The end event to observe, which is a condition for the rate numerator.")
  endEvent: ObservedEvent;
}

@doc("The definition of a Sum metric. This metric kind measures the sum of an event property. Experiment analysis accounts for unequal traffic allocation.")
model SumDefinition extends MetricDefinition {
  @doc("The kind of metric.")
  kind: MetricKind.Sum;

  @doc("The value to aggregate.")
  value: AggregatedValue;
}

@doc("The definition of an Average metric. This metric kind measures the average of an event property.")
model AverageDefinition extends MetricDefinition {
  @doc("The kind of metric.")
  kind: MetricKind.Average;

  @doc("The value to aggregate.")
  value: AggregatedValue;
}

@doc("The definition of a Percentile metric. This metric kind measures the percentile of an event property.")
model PercentileDefinition extends MetricDefinition {
  @doc("The kind of metric.")
  kind: MetricKind.Percentile;

  @doc("The value to aggregate.")
  value: AggregatedValue;

  @doc("The percentile to measure.")
  @minValueExclusive(0)
  @maxValueExclusive(100)
  percentile: int32;
}

@doc("A workspace object that describes the experimentation workspace.")
@resource("workspaces")
model Workspace {
  @key("workspaceId")
  @doc("An ID used to uniquely identify and reference the experimentation workspace.")
  @visibility("read")
  @pattern("^[a-z0-9][a-z0-9-]*$")
  workspaceId: string;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Union discriminator with different types are not supported in swagger v2"
@doc("The metric definition, which determines how the metric value is calculated from event data.")
@discriminator("kind")
model MetricDefinition {}

@doc("Lifecycle stages of a metric, which determines when the metric is calculated.")
union LifecycleStage {
  @doc("Metric is included in experiment analysis")
  Active: "Active",

  @doc("Metric is not included in experiment analysis")
  Inactive: "Inactive",

  string,
}

@doc("A Metric object that describes the metric.")
@resource("metrics")
@parentResource(Workspace)
model Metric {
  @key("metricId")
  @doc("An ID used to uniquely identify and reference the metric.")
  @visibility("read")
  @maxLength(50)
  @minLength(1)
  @pattern("^[a-z_][a-z0-9_]*$")
  id: string;

  @doc("The stage in the metric lifecycle, which determines when the metric is calculated.")
  lifecycle: LifecycleStage;

  @doc("A display name for the metric to use for display rather than the ID.")
  @minLength(1)
  @maxLength(200)
  displayName: string;

  @doc("A description of the metric.")
  @minLength(1)
  @maxLength(1000)
  description: string;

  @doc("The tags of the metric.")
  tags: Tag[];

  @doc("Whether an increase or decrease to the metric value is desired.")
  desiredDirection: DesiredDirection;

  @doc("The metric definition, which determines how the metric value is calculated from event data.")
  definition: MetricDefinition;

  @doc("ETag of the metric")
  @visibility("read")
  eTag: eTag;

  @doc("The timestamp of resource last modification (UTC)")
  @visibility("read")
  lastModifiedAt: utcDateTime;
}

@doc("The result of validating a Metric.")
union ValidationResultOption {
  @doc("The metric is valid.")
  Valid: "Valid",

  @doc("The metric is invalid.")
  Invalid: "Invalid",

  string,
}

@doc("The diagnostic error codes.")
union DiagnosticCode {
  @doc("The metric definition is not according to Json Schema.")
  FailedSchemaValidation: "FailedSchemaValidation",

  @doc("The KQL filter condition is invalid.")
  InvalidEventCondition: "InvalidEventCondition",

  @doc("The KQL filter condition is valid but not currently supported.")
  UnsupportedEventCondition: "UnsupportedEventCondition",

  @doc("""
    The metric definition provided is invalid. 
    for example, if the metric is defined to calculate the average of the Revenue property,
    but also includes a filter such as Revenue == 'hello', this creates a type mismatch. 
    The system infers conflicting data types—numeric and string—resulting in a validation failure.
    """)
  InvalidMetricDefinition: "InvalidMetricDefinition",

  string,
}

@doc("The diagnostic information.")
model DiagnosticInfo {
  @doc("The error message.")
  @visibility("read")
  message: string;

  @doc("The error code.")
  @visibility("read")
  code: DiagnosticCode;
}

@doc("The result of validating a Metric.")
model MetricValidateResult {
  @doc("The validation result.")
  @visibility("read")
  diagnostics: DiagnosticInfo[];

  @doc("Whether the metric is valid.")
  result: ValidationResultOption;
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

interface Metrics {
  @doc("Fetch a Metric by Id.")
  get is Operations.ResourceRead<Metric>;

  @doc("Creates or updates a Metric asynchronously.")
  createOrUpdate is Operations.ResourceCreateOrUpdate<Metric>;

  @doc("Validates a Metric.")
  validate is Operations.ResourceAction<
    Metric,
    BodyParameter<Metric, "Metric input to validate">,
    MetricValidateResult,
    {}
  >;

  @doc("Delete a Metric asynchronously.")
  delete is Operations.ResourceDelete<Metric>;

  @doc("List Metrics resources")
  list is Operations.ResourceList<
    Metric,
    {
      parameters: StandardListQueryParameters;
    }
  >;
}
