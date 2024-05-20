import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using OpenAPI;

namespace Azure.Monitor.LiveMetrics;

/**
 * Live Metrics IsSubscribed operation's request query parameters, either query strings or headers
 */
model IsSubscribedOperationRequestParameters {
  @doc("The instrumentation key of the target Application Insights component for which the client checks whether there's any subscription to it.")
  @query
  ikey: string;

  @doc("Timestamp when the client transmits the metrics and documents to Live Metrics. A 8-byte long type of ticks.")
  @header("x-ms-qps-transmission-time")
  transmissionTime?: int64;

  @doc("Computer name where Application Insights SDK lives. Live Metrics uses machine name with instance name as a backup.")
  @header("x-ms-qps-machine-name")
  machineName?: string;

  @doc("Service instance name where Application Insights SDK lives. Live Metrics uses machine name with instance name as a backup.")
  @header("x-ms-qps-instance-name")
  instanceName?: string;

  @doc("Identifies an Application Insights SDK as trusted agent to report metrics and documents.")
  @header("x-ms-qps-stream-id")
  streamId?: string;

  @doc("Cloud role name of the service.")
  @header("x-ms-qps-role-name")
  roleName?: string;

  @doc("Version/generation of the data contract (MonitoringDataPoint) between the client and Live Metrics.")
  @header("x-ms-qps-invariant-version")
  invariantVersion?: string;

  @doc("An encoded string that indicates whether the collection configuration is changed.")
  @header("x-ms-qps-configuration-etag")
  configurationEtag?: eTag;

  @doc("Data contract between Application Insights client SDK and Live Metrics. /QuickPulseService.svc/ping uses this as a backup source of machine name, instance name and invariant version.")
  @body
  monitoringDataPoint?: MonitoringDataPoint;
}

/**
 * Live Metrics IsSubscribed operation's response headers
 */
model IsSubscribedOperationResponseHeaders {
  @doc("A boolean flag indicating whether there are active user sessions 'watching' the instrumentation key. If true, the client must start collecting data and posting it to Live Metrics. Otherwise, the client must keep pinging.")
  @header("x-ms-qps-subscribed")
  subscribed: string;

  @doc("An encoded string that indicates whether the collection configuration is changed.")
  @header("x-ms-qps-configuration-etag")
  configurationEtag: eTag;

  @doc("Recommended time (in milliseconds) before the client should ping the service again. This header exists only when the instrumentation key is not subscribed to.")
  @header("x-ms-qps-service-polling-interval-hint")
  pollingInterval?: string;

  @doc("Contains a URI of the service endpoint that the client must permanently use for the particular resource. This header exists only when the client is talking to Live Metrics global endpoint.")
  @header("x-ms-qps-service-endpoint-redirect-v2")
  redirectEndpoint?: string;

  @doc("Corresponding status code.")
  @statusCode
  _: 200;
}

/**
 * Live Metrics Publish operation's request query parameters, either query strings or headers
 */
model PublishOperationRequestParameters {
  @doc("The instrumentation key of the target Application Insights component for which the client checks whether there's any subscription to it.")
  @query
  ikey: string;

  @doc("An encoded string that indicates whether the collection configuration is changed.")
  @header("x-ms-qps-configuration-etag")
  configurationEtag?: eTag;

  @doc("Timestamp when the client transmits the metrics and documents to Live Metrics. A 8-byte long type of ticks.")
  @header("x-ms-qps-transmission-time")
  transmissionTime?: int64;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Need to follow the existing SDK contract."
  @doc("Data contract between the client and Live Metrics. /QuickPulseService.svc/ping uses this as a backup source of machine name, instance name and invariant version.")
  @body
  monitoringDataPoints?: MonitoringDataPoint[];
}

/**
 * Live Metrics Publish operation's response headers
 */
model PublishOperationResponseHeaders {
  @doc("Tells the client whether the input instrumentation key is subscribed to.")
  @header("x-ms-qps-subscribed")
  subscribed: string;

  @doc("An encoded string that indicates whether the collection configuration is changed.")
  @header("x-ms-qps-configuration-etag")
  configurationEtag: eTag;
}

/**
 * Monitoring data point coming from the client, which includes metrics, documents and other metadata info.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
model MonitoringDataPoint {
  @doc("Application Insights SDK version.")
  Version: string;

  @doc("Version/generation of the data contract (MonitoringDataPoint) between SDK and Live Metrics.")
  InvariantVersion: int32;

  @doc("Service instance name where Application Insights SDK lives.")
  Instance: string;

  @doc("Service role name.")
  RoleName: string;

  @doc("Computer name where Application Insights SDK lives.")
  MachineName: string;

  @doc("Identifies an Application Insights SDK as a trusted agent to report metrics and documents.")
  StreamId: string;

  @doc("Data point generation timestamp.")
  Timestamp?: utcDateTime;

  @doc("Timestamp when the client transmits the metrics and documents to Live Metrics.")
  TransmissionTime?: utcDateTime;

  @doc("True if the current application is an Azure Web App.")
  IsWebApp: boolean;

  @doc("True if performance counters collection is supported.")
  PerformanceCollectionSupported: boolean;

  @doc("An array of metric data points.")
  Metrics?: MetricPoint[];

  @doc("An array of documents of a specific type {Request}, {RemoteDependency}, {Exception}, {Event}, or {Trace}")
  Documents?: DocumentIngress[];

  @doc("An array of top cpu consumption data point.")
  TopCpuProcesses?: ProcessCpuData[];

  @doc("An array of error while SDK parses and applies the {CollectionConfigurationInfo} provided by Live Metrics.")
  CollectionConfigurationErrors?: CollectionConfigurationError[];
}

/**
 * Represents an error while SDK parses and applies an instance of CollectionConfigurationInfo.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
model CollectionConfigurationError {
  @doc("Error type.")
  CollectionConfigurationErrorType: CollectionConfigurationErrorType;

  @doc("Error message.")
  Message: string;

  @doc("Exception that led to the creation of the configuration error.")
  FullException: string;

  @doc("Custom properties to add more information to the error.")
  Data: KeyValuePairStringString[];
}

/**
 * Collection configuration error type reported by the client SDK.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
union CollectionConfigurationErrorType {
  string,

  /** Unknown error type. */
  Unknown: "Unknown",

  /** Performance counter parsing error. */
  PerformanceCounterParsing: "PerformanceCounterParsing",

  /** Performance counter unexpected error. */
  PerformanceCounterUnexpected: "PerformanceCounterUnexpected",

  /** Performance counter duplicate ids. */
  PerformanceCounterDuplicateIds: "PerformanceCounterDuplicateIds",

  /** Document stream duplication ids. */
  DocumentStreamDuplicateIds: "DocumentStreamDuplicateIds",

  /** Document stream failed to create. */
  DocumentStreamFailureToCreate: "DocumentStreamFailureToCreate",

  /** Document stream failed to create filter unexpectedly. */
  DocumentStreamFailureToCreateFilterUnexpected: "DocumentStreamFailureToCreateFilterUnexpected",

  /** Metric duplicate ids. */
  MetricDuplicateIds: "MetricDuplicateIds",

  /** Metric telemetry type unsupported. */
  MetricTelemetryTypeUnsupported: "MetricTelemetryTypeUnsupported",

  /** Metric failed to create. */
  MetricFailureToCreate: "MetricFailureToCreate",

  /** Metric failed to create filter unexpectedly. */
  MetricFailureToCreateFilterUnexpected: "MetricFailureToCreateFilterUnexpected",

  /** Filter failed to create unexpectedly. */
  FilterFailureToCreateUnexpected: "FilterFailureToCreateUnexpected",

  /** Collection configuration failed to create unexpectedly. */
  CollectionConfigurationFailureToCreateUnexpected: "CollectionConfigurationFailureToCreateUnexpected",
}

/**
 * CPU consumption datapoint.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
model ProcessCpuData {
  @doc("Process name.")
  ProcessName: string;

  @doc("CPU consumption percentage.")
  CpuPercentage: int32;
}

/**
 * Metric data point.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
model MetricPoint {
  @doc("Metric name.")
  Name: string;

  @doc("Metric value.")
  Value: float64;

  @doc("Metric weight.")
  Weight: int32;
}

/**
 * Base class of the specific document types.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
@discriminator("DocumentType")
model DocumentIngress {
  @doc("Telemetry type. Types not defined in enum will get replaced with a 'Unknown' type.")
  DocumentType: DocumentType;

  @doc("An array of document streaming ids. Each id identifies a flow of documents customized by UX customers.")
  DocumentStreamIds?: string[];

  @doc("Collection of custom properties.")
  Properties?: KeyValuePairStringString[];
}

@doc("Document type")
union DocumentType {
  string,

  @doc("Represents a request telemetry type.")
  Request: "Request",

  @doc("Represents a remote dependency telemetry type.")
  RemoteDependency: "RemoteDependency",

  @doc("Represents an exception telemetry type.")
  Exception: "Exception",

  @doc("Represents an event telemetry type.")
  Event: "Event",

  @doc("Represents a trace telemetry type.")
  Trace: "Trace",

  @doc("Represents an unknown telemetry type.")
  Unknown: "Unknown",
}

/**
 * Request document type.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
model Request extends DocumentIngress {
  @doc("Telemetry type for Request.")
  DocumentType: DocumentType.Request;

  @doc("Name of the request, e.g., 'GET /values/{id}'.")
  @maxLength(1024)
  Name?: string;

  @doc("Request URL with all query string parameters.")
  @maxLength(2048)
  Url?: url;

  @doc("Result of a request execution. For http requests, it could be some HTTP status code.")
  @maxLength(1024)
  ResponseCode?: string;

  @doc("Request duration in ISO 8601 duration format, i.e., P[n]Y[n]M[n]DT[n]H[n]M[n]S or P[n]W.")
  Duration?: string;
}

/**
 * RemoteDependency document type.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
model RemoteDependency extends DocumentIngress {
  @doc("Telemetry type for RemoteDependency.")
  DocumentType: DocumentType.RemoteDependency;

  @doc("Name of the command initiated with this dependency call, e.g., GET /username.")
  @maxLength(1024)
  Name?: string;

  @doc("URL of the dependency call to the target, with all query string parameters.")
  @maxLength(2048)
  CommandName?: string;

  @doc("Result code of a dependency call. Examples are SQL error code and HTTP status code.")
  @maxLength(1024)
  ResultCode?: string;

  @doc("Request duration in ISO 8601 duration format, i.e., P[n]Y[n]M[n]DT[n]H[n]M[n]S or P[n]W.")
  Duration?: string;
}

/**
 * Exception document type.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
model Exception extends DocumentIngress {
  @doc("Telemetry type for Exception.")
  DocumentType: DocumentType.Exception;

  @doc("Exception type name.")
  @maxLength(1024)
  ExceptionType?: string;

  @doc("Exception message.")
  @maxLength(32768)
  ExceptionMessage?: string;
}

/**
 * Event document type.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
model Event extends DocumentIngress {
  @doc("Telemetry type for Event.")
  DocumentType: DocumentType.Event;

  @doc("Event name.")
  @maxLength(512)
  Name?: string;
}

/**
 * Trace document type.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
model Trace extends DocumentIngress {
  @doc("Telemetry type for Trace.")
  DocumentType: DocumentType.Trace;

  @doc("Trace message.")
  @maxLength(32768)
  Message?: string;
}

/**
 * Key-value pair of string and string.
 */
model KeyValuePairStringString {
  @doc("Key of the key-value pair.")
  key: string;

  @doc("Value of the key-value pair.")
  value: string;
}

/**
 * Represents the collection configuration - a customizable description of performance counters, metrics, and full telemetry documents to be collected by the client SDK.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
model CollectionConfigurationInfo {
  @doc("An encoded string that indicates whether the collection configuration is changed.")
  ETag: string;

  @doc("An array of metric configuration info.")
  Metrics: DerivedMetricInfo[];

  @doc("An array of document stream configuration info.")
  DocumentStreams: DocumentStreamInfo[];

  @doc("Controls document quotas to be sent to Live Metrics.")
  QuotaInfo?: QuotaConfigurationInfo;
}

/**
 * Controls document quotas to be sent to Live Metrics.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
model QuotaConfigurationInfo {
  @doc("Initial quota")
  InitialQuota?: float32;

  @doc("Max quota")
  MaxQuota: float32;

  @doc("Quota accrual rate per second")
  QuotaAccrualRatePerSec: float32;
}

/**
 * Configurations/filters set by UX to scope the document/telemetry it's interested in.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
model DocumentStreamInfo {
  @doc("Identifier of the document stream initiated by a UX.")
  Id: string;

  @doc("Gets or sets an OR-connected collection of filter groups.")
  DocumentFilterGroups: DocumentFilterConjunctionGroupInfo[];
}

/**
 * A collection of filters for a specific telemetry type.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
model DocumentFilterConjunctionGroupInfo {
  @doc("Telemetry type.")
  TelemetryType: TelemetryType;

  @doc("An array of filter groups.")
  Filters: FilterConjunctionGroupInfo;
}

@doc("Telemetry type.")
union TelemetryType {
  string,

  @doc("Represents a request telemetry type.")
  Request: "Request",

  @doc("Represents a dependency telemetry type.")
  Dependency: "Dependency",

  @doc("Represents an exception telemetry type.")
  Exception: "Exception",

  @doc("Represents an event telemetry type.")
  Event: "Event",

  @doc("Represents a metric telemetry type.")
  Metric: "Metric",

  @doc("Represents a performance counter telemetry type.")
  PerformanceCounter: "PerformanceCounter",

  @doc("Represents a trace telemetry type.")
  Trace: "Trace",
}

/**
 * A metric configuration set by UX to scope the metrics it's interested in.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
model DerivedMetricInfo {
  @doc("metric configuration identifier.")
  Id: string;

  @doc("Telemetry type.")
  TelemetryType: string;

  @doc("A collection of filters to scope metrics that UX needs.")
  FilterGroups: FilterConjunctionGroupInfo[];

  @doc("Telemetry's metric dimension whose value is to be aggregated. Example values: Duration, Count(),...")
  Projection: string;

  @doc("Aggregation type. This is the aggregation done from everything within a single server.")
  Aggregation: AggregationType;

  @doc("Aggregation type. This Aggregation is done across the values for all the servers taken together.")
  BackEndAggregation: AggregationType;
}

@doc("Aggregation type.")
union AggregationType {
  string,

  @doc("Average")
  Avg: "Avg",

  @doc("Sum")
  Sum: "Sum",

  @doc("Minimum")
  Min: "Min",

  @doc("Maximum")
  Max: "Max",
}

/**
 * An AND-connected group of FilterInfo objects.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
model FilterConjunctionGroupInfo {
  @doc("An array of filters.")
  Filters: FilterInfo[];
}

/**
 * A filter set on UX
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
model FilterInfo {
  @doc("dimension name of the filter")
  FieldName: string;

  @doc("Operator of the filter")
  Predicate: PredicateType;

  @doc("Comparand of the filter")
  Comparand: string;
}

/**
 * Enum representing the different types of predicates.
 */
union PredicateType {
  string,

  @doc("Represents an equality predicate.")
  Equal: "Equal",

  @doc("Represents a not-equal predicate.")
  NotEqual: "NotEqual",

  @doc("Represents a less-than predicate.")
  LessThan: "LessThan",

  @doc("Represents a greater-than predicate.")
  GreaterThan: "GreaterThan",

  @doc("Represents a less-than-or-equal predicate.")
  LessThanOrEqual: "LessThanOrEqual",

  @doc("Represents a greater-than-or-equal predicate.")
  GreaterThanOrEqual: "GreaterThanOrEqual",

  @doc("Represents a contains predicate.")
  Contains: "Contains",

  @doc("Represents a does-not-contain predicate.")
  DoesNotContain: "DoesNotContain",
}

/**
 * Optional http response body, whose existence carries additional error descriptions.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
@error
model ServiceError {
  @doc("A globally unique identifier to identify the diagnostic context. It defaults to the empty GUID.")
  RequestId: string = "00000000-0000-0000-0000-000000000000";

  @doc("Service error response date time.")
  ResponseDateTime: string;

  @doc("Error code.")
  Code: string;

  @doc("Error message.")
  Message: string;

  @doc("Message of the exception that triggers the error response.")
  Exception: string;
}
