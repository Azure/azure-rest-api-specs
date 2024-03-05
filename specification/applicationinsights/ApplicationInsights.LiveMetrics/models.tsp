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
 * Live Metrics IsSubscribed request query parameters, either query strings or headers
 */
model IsSubscribedRequestParameters {
  @doc("The ikey of the target Application Insights component for which client sdk calls /ping.")
  @query
  ikey: string;

  @doc("Deprecated. An alternative way to pass api key. Use AAD auth instead.")
  @query
  apiKey?: string;

  @doc("Timestamp when SDK transmits the metrics and documents to Live Metrics. A 8-byte long type of ticks.")
  @header("x-ms-qps-transmission-time")
  transmissionTime?: int64;

  @doc("Computer name where AI SDK lives. Live Metrics uses machine name with instance name as a backup.")
  @header("x-ms-qps-machine-name")
  machineName?: string;

  @doc("Service instance name where AI SDK lives. Live Metrics uses machine name with instance name as a backup.")
  @header("x-ms-qps-instance-name")
  instanceName?: string;

  @doc("Identifies an AI SDK as trusted agent to report metrics and documents.")
  @header("x-ms-qps-stream-id")
  streamId?: string;

  @doc("Cloud role name of the service.")
  @header("x-ms-qps-role-name")
  roleName?: string;

  @doc("Version/generation of the data contract (MonitoringDataPoint) between SDK and Live Metrics.")
  @header("x-ms-qps-invariant-version")
  invariantVersion?: string;

  @doc("An encoded string that indicates whether the collection configuration is changed.")
  @header("x-ms-qps-configuration-etag")
  configurationEtag?: eTag;
}

/**
 * Live Metrics IsSubscribed response headers
 */
model IsSubscribedResponseHeaders {
  @doc("A boolean flag indicating whether there are active user sessions 'watching' the instrumentation key. If true, SDK must start collecting data and posting it to Live Metrics. Otherwise, SDK must keep pinging.")
  @header("x-ms-qps-subscribed")
  subscribed: string;

  @doc("An encoded string that indicates whether the collection configuration is changed.")
  @header("x-ms-qps-configuration-etag")
  configurationEtag: eTag;

  @doc("Recommended time (in milliseconds) before an SDK should ping the service again. This header exists only when instrumentation key is not watched by UX.")
  @header("x-ms-qps-service-polling-interval-hint")
  pollingInterval?: string;

  @doc("Contains a URI of the service endpoint that an SDK must permanently use for the particular resource. This header exists only when SDK is talking to Live Metrics global endpoint.")
  @header("x-ms-qps-service-endpoint-redirect-v2")
  redirectEndpoint?: string;

  @doc("Corresponding status code.")
  @statusCode
  _: 200;
}

/**
 * Live Metrics PublishLiveMetrics request query parameters, either query strings or headers
 */
model PublishLiveMetricsRequestParameters {
  @doc("The ikey of the target Application Insights component for which client sdk calls /post.")
  @query
  ikey: string;

  @doc("Deprecated. An alternative way to pass api key. Use AAD auth instead.")
  @query
  apiKey?: string;

  @doc("An encoded string that indicates whether the collection configuration is changed.")
  @header("x-ms-qps-configuration-etag")
  configurationEtag?: eTag;

  @doc("Timestamp when SDK transmits the metrics and documents to Live Metrics. A 8-byte long type of ticks.")
  @header("x-ms-qps-transmission-time")
  transmissionTime?: int64;
}

/**
 * Live Metrics PublishLiveMetrics request body
 */
#suppress "@azure-tools/typespec-azure-core/request-body-problem" "Need to follow the casing style of the existing SDK contract."
model PublishLiveMetricsRequestBody {
  @doc("Data contract between SDK and Live Metrics. /QuickPulseService.svc/ping uses this as a backup source of machine name, instance name and invariant version.")
  @body
  monitoringDataPoints?: MonitoringDataPoint[];
}

/**
 * Live Metrics PublishLiveMetrics response headers
 */
model PublishLiveMetricsResponseHeaders {
  @doc("Tells SDK whether the input instrumentation key is subscribed to by UX.")
  @header("x-ms-qps-subscribed")
  subscribed: string;

  @doc("An encoded string that indicates whether the collection configuration is changed.")
  @header("x-ms-qps-configuration-etag")
  configurationEtag: eTag;
}

/**
 * Monitoring data point coming from SDK, which includes metrics, documents and other metadata info.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
model MonitoringDataPoint {
  @doc("AI SDK version.")
  Version: string;

  @doc("Version/generation of the data contract (MonitoringDataPoint) between SDK and Live Metrics.")
  InvariantVersion: int32;

  @doc("Service instance name where AI SDK lives.")
  Instance: string;

  @doc("Service role name.")
  RoleName: string;

  @doc("Computer name where AI SDK lives.")
  MachineName: string;

  @doc("Identifies an AI SDK as a trusted agent to report metrics and documents.")
  StreamId: string;

  @doc("Data point generation timestamp.")
  Timestamp?: utcDateTime;

  @doc("Timestamp when SDK transmits the metrics and documents to Live Metrics.")
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

  @doc("Exception that leads to the creation of the configuration error.")
  FullException: string;

  @doc("Custom properties to add more information to the error.")
  Data: KeyValuePairStringString[];
}

/**
 * Collection configuration error type reported by SDK.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
enum CollectionConfigurationErrorType {
  /** Unknown error type. */
  Unknown,

  /** Performance counter parsing error. */
  PerformanceCounterParsing,

  /** Performance counter unexpected error. */
  PerformanceCounterUnexpected,

  /** Performance counter duplicate ids. */
  PerformanceCounterDuplicateIds,

  /** Document stream duplication ids. */
  DocumentStreamDuplicateIds,

  /** Document stream failed to create. */
  DocumentStreamFailureToCreate,

  /** Document stream failed to create filter unexpectedly. */
  DocumentStreamFailureToCreateFilterUnexpected,

  /** Metric duplicate ids. */
  MetricDuplicateIds,

  /** Metric telemetry type unsupported. */
  MetricTelemetryTypeUnsupported,

  /** Metric failed to create. */
  MetricFailureToCreate,

  /** Metric failed to create filter unexpectedly. */
  MetricFailureToCreateFilterUnexpected,

  /** Filter failed to create unexpectedly. */
  FilterFailureToCreateUnexpected,

  /** Collection configuration failed to create unexpectedly. */
  CollectionConfigurationFailureToCreateUnexpected,
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
  DocumentType:
    | "Request"
    | "RemoteDependency"
    | "Exception"
    | "Event"
    | "Trace"
    | "Unknown";

  @doc("An array of document streaming ids. Each id identifies a flow of documents customized by UX customers.")
  DocumentStreamIds?: string[];

  @doc("Collection of custom properties.")
  Properties?: KeyValuePairStringString[];
}

/**
 * Request document type.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
model Request extends DocumentIngress {
  @doc("Telemetry type for Request.")
  DocumentType: "Request";

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
  DocumentType: "RemoteDependency";

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
  DocumentType: "Exception";

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
  DocumentType: "Event";

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
  DocumentType: "Trace";

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
 * Represents the collection configuration - a customizable description of performance counters, metrics, and full telemetry documents to be collected by the SDK.
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
enum TelemetryType {
  @doc("Represents a request telemetry type.")
  Request,

  @doc("Represents a dependency telemetry type.")
  Dependency,

  @doc("Represents an exception telemetry type.")
  Exception,

  @doc("Represents an event telemetry type.")
  Event,

  @doc("Represents a metric telemetry type.")
  Metric,

  @doc("Represents a performance counter telemetry type.")
  PerformanceCounter,

  @doc("Represents a trace telemetry type.")
  Trace,
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
enum AggregationType {
  @doc("Average")
  Avg,

  @doc("Sum")
  Sum,
  
  @doc("Minimum")
  Min,
  
  @doc("Maximum")
  Max,
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
  Predicate:
    | "Equal"
    | "NotEqual"
    | "LessThan"
    | "GreaterThan"
    | "LessThanOrEqual"
    | "GreaterThanOrEqual"
    | "Contains"
    | "DoesNotContain";

  @doc("Comparand of the filter")
  Comparand: string;
}

/**
 * Optional http response body, whose existence carries additional error descriptions.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to follow the casing style of the existing SDK contract."
@error
model ServiceError {
  @doc("A globally unique identifier to identify the diagnostic context. Currently it defaults to the empty GUID.")
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
