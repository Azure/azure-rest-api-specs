import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.StreamAnalytics;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Indicates the type of serialization that the input or output uses. Required on PUT (CreateOrReplace) requests.
 */
enum EventSerializationType {
  Csv,
  Avro,
  Json,
  CustomClr,
  Parquet,
}

/**
 * Indicates the type of compression that the input uses. Required on PUT (CreateOrReplace) requests.
 */
enum CompressionType {
  None,
  GZip,
  Deflate,
}

/**
 * The input watermark mode.
 */
enum InputWatermarkMode {
  None,
  ReadWatermark,
}

/**
 * The output watermark mode.
 */
enum OutputWatermarkMode {
  None,
  SendCurrentPartitionWatermark,
  SendLowestWatermarkAcrossPartitions,
}

/**
 * The name of the SKU. Required on PUT (CreateOrReplace) requests.
 */
enum SkuName {
  Standard,
}

/**
 * Describes the type of the job. Valid modes are `Cloud` and 'Edge'.
 */
enum JobType {
  Cloud,
  Edge,
}

/**
 * Value may be JobStartTime, CustomTime, or LastOutputEventTime to indicate whether the starting point of the output event stream should start whenever the job is started, start at a custom user time stamp specified via the outputStartTime property, or start from the last event output time.
 */
enum OutputStartMode {
  JobStartTime,
  CustomTime,
  LastOutputEventTime,
}

/**
 * Indicates the policy to apply to events that arrive out of order in the input event stream.
 */
enum EventsOutOfOrderPolicy {
  Adjust,
  Drop,
}

/**
 * Indicates the policy to apply to events that arrive at the output and cannot be written to the external storage due to being malformed (missing column values, column values of wrong type or size).
 */
enum OutputErrorPolicy {
  Stop,
  Drop,
}

/**
 * Controls certain runtime behaviors of the streaming job.
 */
enum CompatibilityLevel {
  `1.0`,
  `1.2`,
}

/**
 * Authentication Mode. Valid modes are `ConnectionString`, `Msi` and 'UserToken'.
 */
enum AuthenticationMode {
  Msi,
  UserToken,
  ConnectionString,
}

/**
 * Valid values are JobStorageAccount and SystemAccount. If set to JobStorageAccount, this requires the user to also specify jobStorageAccount property. .
 */
enum ContentStoragePolicy {
  SystemAccount,
  JobStorageAccount,
}

/**
 * Indicates the type of data refresh option.
 */
enum RefreshType {
  Static,
  RefreshPeriodicallyWithFull,
  RefreshPeriodicallyWithDelta,
  Blocking,
  Nonblocking,
}

/**
 * The identity type.
 */
enum IdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

/**
 * The status of the query testing request.
 */
enum QueryTestingResultStatus {
  /**
   * The query testing operation was initiated.
   */
  Started,

  /**
   * The query testing operation succeeded.
   */
  Success,

  /**
   * The query testing operation failed due to a compiler error.
   */
  CompilerError,

  /**
   * The query testing operation failed due to a runtime error.
   */
  RuntimeError,

  /**
   * The query testing operation failed due to a timeout.
   */
  Timeout,

  /**
   * The query testing operation failed due to an unknown error .
   */
  UnknownError,
}

/**
 * The status of the sample input request.
 */
enum SampleInputResultStatus {
  /**
   * The sample input operation successfully read all the events in the range.
   */
  ReadAllEventsInRange,

  /**
   * The sample input operation found no events in the range.
   */
  NoEventsFoundInRange,

  /**
   * The sample input operation failed to connect to the input.
   */
  ErrorConnectingToInput,
}

/**
 * The status of the test input or output request.
 */
enum TestDatasourceResultStatus {
  /**
   * The test datasource operation succeeded.
   */
  TestSucceeded,

  /**
   * The test datasource operation failed.
   */
  TestFailed,
}

/**
 * Specifies the SKU name of the cluster. Required on PUT (CreateOrUpdate) requests.
 */
enum ClusterSkuName {
  /**
   * The default SKU.
   */
  Default,
}

/**
 * The status of the cluster provisioning. The three terminal states are: Succeeded, Failed and Canceled
 */
enum ClusterProvisioningState {
  /**
   * The cluster provisioning succeeded.
   */
  Succeeded,

  /**
   * The cluster provisioning failed.
   */
  Failed,

  /**
   * The cluster provisioning was canceled.
   */
  Canceled,

  /**
   * The cluster provisioning was inprogress.
   */
  InProgress,
}

/**
 * The current execution state of the streaming job.
 */
enum JobState {
  /**
   * The job is currently in the Created state.
   */
  Created,

  /**
   * The job is currently in the Starting state.
   */
  Starting,

  /**
   * The job is currently in the Running state.
   */
  Running,

  /**
   * The job is currently in the Stopping state.
   */
  Stopping,

  /**
   * The job is currently in the Stopped state.
   */
  Stopped,

  /**
   * The job is currently in the Deleting state.
   */
  Deleting,

  /**
   * The job is currently in the Failed state.
   */
  Failed,

  /**
   * The job is currently in the Degraded state.
   */
  Degraded,

  /**
   * The job is currently in the Restarting state.
   */
  Restarting,

  /**
   * The job is currently in the Scaling state.
   */
  Scaling,
}

/**
 * Refresh modes for Stream Analytics functions.
 */
enum UpdateMode {
  Static,
  Refreshable,
}

/**
 * Specifies the encoding of the incoming data in the case of input and the encoding of outgoing data in the case of output.
 */
enum Encoding {
  UTF8,
}

/**
 * Specifies the format of the JSON the output will be written in. The currently supported values are 'lineSeparated' indicating the output will be formatted by having each JSON object separated by a new line and 'array' indicating the output will be formatted as an array of JSON objects.
 */
enum JsonOutputSerializationFormat {
  LineSeparated,
  Array,
}

/**
 * Supported Event Grid schema types.
 */
enum EventGridEventSchemaType {
  EventGridEventSchema,
  CloudEventSchema,
}

/**
 * Determines whether blob blocks are either committed automatically or appended.
 */
enum BlobWriteMode {
  Append,
  Once,
}

/**
 * The properties that are associated with a function.
 */
@discriminator("type")
model FunctionProperties {
  /**
   * The current entity tag for the function. This is an opaque string. You can use it to detect whether the resource has changed between requests. You can also use it in the If-Match or If-None-Match headers for write operations for optimistic concurrency.
   */
  @visibility("read")
  etag?: string;

  @extension("x-ms-client-flatten", true)
  properties?: FunctionConfiguration;
}

model FunctionConfiguration {
  inputs?: FunctionInput[];

  /**
   * Describes the output of a function.
   */
  output?: FunctionOutput;

  /**
   * The physical binding of the function. For example, in the Azure Machine Learning web service’s case, this describes the endpoint.
   */
  binding?: FunctionBinding;
}

/**
 * Describes one input parameter of a function.
 */
model FunctionInput {
  /**
   * The (Azure Stream Analytics supported) data type of the function input parameter. A list of valid Azure Stream Analytics data types are described at https://msdn.microsoft.com/en-us/library/azure/dn835065.aspx
   */
  dataType?: string;

  /**
   * A flag indicating if the parameter is a configuration parameter. True if this input parameter is expected to be a constant. Default is false.
   */
  isConfigurationParameter?: boolean;
}

/**
 * Describes the output of a function.
 */
model FunctionOutput {
  /**
   * The (Azure Stream Analytics supported) data type of the function output. A list of valid Azure Stream Analytics data types are described at https://msdn.microsoft.com/en-us/library/azure/dn835065.aspx
   */
  dataType?: string;
}

/**
 * The physical binding of the function. For example, in the Azure Machine Learning web service’s case, this describes the endpoint.
 */
@discriminator("type")
model FunctionBinding {}

/**
 * The base sub-resource model definition.
 */
model SubResource {
  /**
   * Resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name
   */
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;
}

/**
 * Common error representation.
 */
@error
model StreamAnalyticsError {
  /**
   * Error definition properties.
   */
  @extension("x-ms-client-flatten", true)
  error?: ErrorError;
}

/**
 * Error definition properties.
 */
model ErrorError {
  /**
   * Error code.
   */
  code?: string;

  /**
   * Error message.
   */
  message?: string;

  /**
   * Error target.
   */
  target?: string;

  /**
   * Error details.
   */
  details?: StreamAnalyticsErrorDetails[];
}

/**
 * Common error details representation.
 */
model StreamAnalyticsErrorDetails {
  /**
   * Error code.
   */
  code?: string;

  /**
   * Error target.
   */
  target?: string;

  /**
   * Error message.
   */
  message?: string;
}

/**
 * Describes the status of the test operation along with error information, if applicable.
 */
model ResourceTestStatus {
  /**
   * The status of the test operation.
   */
  @visibility("read")
  status?: string;

  /**
   * Describes the error that occurred.
   */
  @visibility("read")
  @extension("x-ms-client-flatten", true)
  error?: ErrorResponse;
}

/**
 * Parameters used to specify the type of function to retrieve the default definition for.
 */
@discriminator("bindingType")
model FunctionRetrieveDefaultDefinitionParameters {}

/**
 * The properties that are associated with an input.
 */
@discriminator("type")
model InputProperties {
  /**
   * Describes how data from an input is serialized or how data is serialized when written to an output. Required on PUT (CreateOrReplace) requests.
   */
  serialization?: Serialization;

  /**
   * Describes conditions applicable to the Input, Output, or the job overall, that warrant customer attention.
   */
  @visibility("read")
  diagnostics?: Diagnostics;

  /**
   * The current entity tag for the input. This is an opaque string. You can use it to detect whether the resource has changed between requests. You can also use it in the If-Match or If-None-Match headers for write operations for optimistic concurrency.
   */
  @visibility("read")
  etag?: string;

  /**
   * Describes how input data is compressed
   */
  compression?: Compression;

  /**
   * partitionKey Describes a key in the input data which is used for partitioning the input data
   */
  partitionKey?: string;

  /**
   * Settings which determine whether to read watermark events.
   */
  watermarkSettings?: InputWatermarkProperties;
}

/**
 * Describes how data from an input is serialized or how data is serialized when written to an output.
 */
@discriminator("type")
model Serialization {}

/**
 * Describes conditions applicable to the Input, Output, or the job overall, that warrant customer attention.
 */
model Diagnostics {
  /**
   * A collection of zero or more conditions applicable to the resource, or to the job overall, that warrant customer attention.
   */
  @visibility("read")
  conditions?: DiagnosticCondition[];
}

/**
 * Condition applicable to the resource, or to the job overall, that warrant customer attention.
 */
model DiagnosticCondition {
  /**
   * The UTC timestamp of when the condition started. Customers should be able to find a corresponding event in the ops log around this time.
   */
  @visibility("read")
  since?: string;

  /**
   * The opaque diagnostic code.
   */
  @visibility("read")
  code?: string;

  /**
   * The human-readable message describing the condition in detail. Localized in the Accept-Language of the client request.
   */
  @visibility("read")
  message?: string;
}

/**
 * Describes how input data is compressed
 */
model Compression {
  /**
   * Indicates the type of compression that the input uses. Required on PUT (CreateOrReplace) requests.
   */
  type: CompressionType;
}

/**
 * Settings which determine whether to read watermark events.
 */
model InputWatermarkProperties {
  /**
   * The input watermark mode.
   */
  watermarkMode?: InputWatermarkMode;
}

/**
 * The properties that are associated with an output.
 */
model OutputProperties {
  /**
   * Describes the data source that output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  datasource?: OutputDataSource;

  /**
   * The time frame for filtering Stream Analytics job outputs.
   */
  @projectedName("json", "timeWindow")
  timeFrame?: plainTime;

  /**
   * The size window to constrain a Stream Analytics output to.
   */
  sizeWindow?: float32;

  /**
   * Describes how data from an input is serialized or how data is serialized when written to an output. Required on PUT (CreateOrReplace) requests.
   */
  serialization?: Serialization;

  /**
   * Describes conditions applicable to the Input, Output, or the job overall, that warrant customer attention.
   */
  @visibility("read")
  diagnostics?: Diagnostics;

  /**
   * The current entity tag for the output. This is an opaque string. You can use it to detect whether the resource has changed between requests. You can also use it in the If-Match or If-None-Match headers for write operations for optimistic concurrency.
   */
  @visibility("read")
  etag?: string;

  /**
   * A list of the last output event times for each output partition. The index of the array corresponds to the partition number.
   */
  @visibility("read")
  lastOutputEventTimestamps?: LastOutputEventTimestamp[];

  /**
   * Settings which determine whether to send watermarks to downstream.
   */
  watermarkSettings?: OutputWatermarkProperties;
}

/**
 * Describes the data source that output will be written to.
 */
@discriminator("type")
model OutputDataSource {}

/**
 * An output event timestamp.
 */
model LastOutputEventTimestamp {
  /**
   * The last output event time.
   */
  lastOutputEventTime?: string;

  /**
   * The time that the last update happened.
   */
  lastUpdateTime?: string;
}

/**
 * Settings which determine whether to send watermarks to downstream.
 */
model OutputWatermarkProperties {
  /**
   * The output watermark mode.
   */
  watermarkMode?: OutputWatermarkMode;

  /**
   * Describes the maximal delta between the fastest and slowest partitions, so the out of order window that catches all necessary events in downstream jobs is well defined.
   */
  maxWatermarkDifferenceAcrossPartitions?: string;
}

/**
 * The properties that are associated with a streaming job.
 */
model StreamingJobProperties {
  /**
   * Describes the SKU of the streaming job. Required on PUT (CreateOrReplace) requests.
   */
  sku?: Sku;

  /**
   * A GUID uniquely identifying the streaming job. This GUID is generated upon creation of the streaming job.
   */
  @visibility("read")
  jobId?: string;

  /**
   * Describes the provisioning status of the streaming job.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Describes the state of the streaming job.
   */
  @visibility("read")
  jobState?: string;

  /**
   * Describes the type of the job. Valid modes are `Cloud` and 'Edge'.
   */
  jobType?: JobType;

  /**
   * This property should only be utilized when it is desired that the job be started immediately upon creation. Value may be JobStartTime, CustomTime, or LastOutputEventTime to indicate whether the starting point of the output event stream should start whenever the job is started, start at a custom user time stamp specified via the outputStartTime property, or start from the last event output time.
   */
  outputStartMode?: OutputStartMode;

  /**
   * Value is either an ISO-8601 formatted time stamp that indicates the starting point of the output event stream, or null to indicate that the output event stream will start whenever the streaming job is started. This property must have a value if outputStartMode is set to CustomTime.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  outputStartTime?: utcDateTime;

  /**
   * Value is either an ISO-8601 formatted timestamp indicating the last output event time of the streaming job or null indicating that output has not yet been produced. In case of multiple outputs or multiple streams, this shows the latest value in that set.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastOutputEventTime?: utcDateTime;

  /**
   * Indicates the policy to apply to events that arrive out of order in the input event stream.
   */
  eventsOutOfOrderPolicy?: EventsOutOfOrderPolicy;

  /**
   * Indicates the policy to apply to events that arrive at the output and cannot be written to the external storage due to being malformed (missing column values, column values of wrong type or size).
   */
  outputErrorPolicy?: OutputErrorPolicy;

  /**
   * The maximum tolerable delay in seconds where out-of-order events can be adjusted to be back in order.
   */
  eventsOutOfOrderMaxDelayInSeconds?: int32;

  /**
   * The maximum tolerable delay in seconds where events arriving late could be included.  Supported range is -1 to 1814399 (20.23:59:59 days) and -1 is used to specify wait indefinitely. If the property is absent, it is interpreted to have a value of -1.
   */
  eventsLateArrivalMaxDelayInSeconds?: int32;

  /**
   * The data locale of the stream analytics job. Value should be the name of a supported .NET Culture from the set https://msdn.microsoft.com/en-us/library/system.globalization.culturetypes(v=vs.110).aspx. Defaults to 'en-US' if none specified.
   */
  dataLocale?: string;

  /**
   * Controls certain runtime behaviors of the streaming job.
   */
  compatibilityLevel?: CompatibilityLevel;

  /**
   * Value is an ISO-8601 formatted UTC timestamp indicating when the streaming job was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * A list of one or more inputs to the streaming job. The name property for each input is required when specifying this property in a PUT request. This property cannot be modify via a PATCH operation. You must use the PATCH API available for the individual input.
   */
  inputs?: Input[];

  /**
   * Indicates the query and the number of streaming units to use for the streaming job. The name property of the transformation is required when specifying this property in a PUT request. This property cannot be modify via a PATCH operation. You must use the PATCH API available for the individual transformation.
   */
  transformation?: Transformation;

  /**
   * A list of one or more outputs for the streaming job. The name property for each output is required when specifying this property in a PUT request. This property cannot be modify via a PATCH operation. You must use the PATCH API available for the individual output.
   */
  outputs?: Output[];

  /**
   * A list of one or more functions for the streaming job. The name property for each function is required when specifying this property in a PUT request. This property cannot be modify via a PATCH operation. You must use the PATCH API available for the individual transformation.
   */
  functions?: Function[];

  /**
   * The current entity tag for the streaming job. This is an opaque string. You can use it to detect whether the resource has changed between requests. You can also use it in the If-Match or If-None-Match headers for write operations for optimistic concurrency.
   */
  @visibility("read")
  etag?: string;

  /**
   * The properties that are associated with an Azure Storage account with MSI
   */
  jobStorageAccount?: JobStorageAccount;

  /**
   * Valid values are JobStorageAccount and SystemAccount. If set to JobStorageAccount, this requires the user to also specify jobStorageAccount property. .
   */
  contentStoragePolicy?: ContentStoragePolicy;

  /**
   * The storage account where the custom code artifacts are located.
   */
  externals?: External;

  /**
   * The cluster which streaming jobs will run on.
   */
  cluster?: ClusterInfo;
}

/**
 * The properties that are associated with a SKU.
 */
model Sku {
  /**
   * The name of the SKU. Required on PUT (CreateOrReplace) requests.
   */
  name?: SkuName;
}

/**
 * The properties that are associated with a transformation.
 */
model TransformationProperties {
  /**
   * Specifies the number of streaming units that the streaming job uses.
   */
  streamingUnits?: int32;

  /**
   * Specifies the valid streaming units a streaming job can scale to.
   */
  validStreamingUnits?: int32[];

  /**
   * Specifies the query that will be run in the streaming job. You can learn more about the Stream Analytics Query Language (SAQL) here: https://msdn.microsoft.com/library/azure/dn834998 . Required on PUT (CreateOrReplace) requests.
   */
  query?: string;

  /**
   * The current entity tag for the transformation. This is an opaque string. You can use it to detect whether the resource has changed between requests. You can also use it in the If-Match or If-None-Match headers for write operations for optimistic concurrency.
   */
  @visibility("read")
  etag?: string;
}

/**
 * The properties that are associated with an Azure Storage account with MSI
 */
model JobStorageAccount extends StorageAccount {}

/**
 * The properties that are associated with an Azure Storage account
 */
model StorageAccount {
  /**
   * The name of the Azure Storage account. Required on PUT (CreateOrReplace) requests.
   */
  accountName?: string;

  /**
   * The account key for the Azure Storage account. Required on PUT (CreateOrReplace) requests.
   */
  accountKey?: string;

  /**
   * Authentication Mode.
   */
  authenticationMode?: AuthenticationMode;
}

/**
 * The storage account where the custom code artifacts are located.
 */
model External {
  /**
   * The properties that are associated with an Azure Storage account
   */
  storageAccount?: StorageAccount;

  /**
   * The UserCustomCode container.
   */
  container?: string;

  /**
   * The UserCustomCode path.
   */
  path?: string;

  /**
   * The refresh parameters for any/all updatable user defined functions present in the job config.
   */
  refreshConfiguration?: RefreshConfiguration;
}

/**
 * The refresh parameters for any/all updatable user defined functions present in the job config.
 */
model RefreshConfiguration {
  /**
   * The blob path pattern. Not a regular expression. It represents a pattern against which blob names will be matched to determine whether or not they should be included as input or output to the job. See https://docs.microsoft.com/en-us/rest/api/streamanalytics/stream-analytics-input or https://docs.microsoft.com/en-us/rest/api/streamanalytics/stream-analytics-output for a more detailed explanation and example.
   */
  pathPattern?: string;

  /**
   * The date format. Wherever {date} appears in pathPattern, the value of this property is used as the date format instead.
   */
  dateFormat?: string;

  /**
   * The time format. Wherever {time} appears in pathPattern, the value of this property is used as the time format instead.
   */
  timeFormat?: string;

  /**
   * The refresh interval.
   */
  refreshInterval?: string;

  /**
   * This property indicates which data refresh option to use, Blocking or Nonblocking.
   */
  refreshType?: RefreshType;
}

/**
 * The properties associated with a Stream Analytics cluster.
 */
model ClusterInfo {
  /**
   * The resource id of cluster.
   */
  id?: string;
}

/**
 * Describes how identity is verified
 */
model Identity {
  /**
   * The tenantId of the identity.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The principalId of the identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The identity type.
   */
  type?: IdentityType;
}

/**
 * The resource model definition for a ARM tracked top level resource
 */
model TrackedResource extends Resource {
  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives
   */
  @visibility("read", "create")
  location?: string;
}

/**
 * The base resource definition
 */
model Resource {
  /**
   * Fully qualified resource Id for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. Ex- Microsoft.Compute/virtualMachines or Microsoft.Storage/storageAccounts.
   */
  @visibility("read")
  type?: string;
}

/**
 * Parameters supplied to the Start Streaming Job operation.
 */
model StartStreamingJobParameters {
  /**
   * Value may be JobStartTime, CustomTime, or LastOutputEventTime to indicate whether the starting point of the output event stream should start whenever the job is started, start at a custom user time stamp specified via the outputStartTime property, or start from the last event output time.
   */
  outputStartMode?: OutputStartMode;

  /**
   * Value is either an ISO-8601 formatted time stamp that indicates the starting point of the output event stream, or null to indicate that the output event stream will start whenever the streaming job is started. This property must have a value if outputStartMode is set to CustomTime.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  outputStartTime?: utcDateTime;
}

/**
 * Parameters supplied to the Scale Streaming Job operation.
 */
model ScaleStreamingJobParameters {
  /**
   * Specifies the number of streaming units that the streaming job will scale to.
   */
  streamingUnits?: int32;
}

/**
 * Result of the GetQuotas operation. It contains a list of quotas for the subscription in a particular region.
 */
model SubscriptionQuotasListResult {
  /**
   * List of quotas for the subscription in a particular region.
   */
  @visibility("read")
  value?: SubscriptionQuota[];
}

/**
 * Describes the current quota for the subscription.
 */
model SubscriptionQuota extends SubResource {
  /**
   * Describes the properties of the quota.
   */
  @visibility("read")
  @extension("x-ms-client-flatten", true)
  properties?: SubscriptionQuotaProperties;
}

/**
 * Describes the properties of the quota.
 */
model SubscriptionQuotaProperties {
  /**
   * The max permitted usage of this resource.
   */
  @visibility("read")
  maxCount?: int32;

  /**
   * The current usage of this resource.
   */
  @visibility("read")
  currentCount?: int32;
}

/**
 * The request object for query testing.
 */
model TestQuery {
  /**
   * Diagnostics information related to query testing.
   */
  @extension("x-ms-client-flatten", true)
  diagnostics?: TestQueryDiagnostics;

  /**
   * Stream analytics job object which defines the input, output, and transformation for the query testing.
   */
  streamingJob: StreamingJob;
}

/**
 * Diagnostics information related to query testing.
 */
model TestQueryDiagnostics {
  /**
   * The SAS URI to the container or directory.
   */
  writeUri: string;

  /**
   * The path to the subdirectory.
   */
  path?: string;
}

/**
 * The result of the query testing request.
 */
model QueryTestingResult extends StreamAnalyticsError {
  /**
   * The status of the query testing request.
   */
  @visibility("read")
  status?: QueryTestingResultStatus;

  /**
   * The SAS URL to the outputs payload.
   */
  @visibility("read")
  outputUri?: string;
}

/**
 * The query compilation object which defines the input, output, and transformation for the query compilation.
 */
model CompileQuery {
  /**
   * The query to compile.
   */
  query: string;

  /**
   * The inputs for the query compilation.
   */
  inputs?: QueryInput[];

  /**
   * The functions for the query compilation.
   */
  functions?: QueryFunction[];

  /**
   * Describes the type of the job. Valid values are `Cloud` and 'Edge'.
   */
  jobType: JobType;

  /**
   * The query to compile.
   */
  compatibilityLevel?: CompatibilityLevel;
}

/**
 * An input for the query compilation.
 */
model QueryInput {
  /**
   * The name of the input.
   */
  name: string;

  /**
   * The type of the input, can be Stream or Reference.
   */
  type: string;
}

/**
 * A function for the query compilation.
 */
model QueryFunction {
  /**
   * The name of the function.
   */
  name: string;

  /**
   * The type of the function.
   */
  type: string;

  /**
   * The type of the function binding.
   */
  bindingType: string;

  /**
   * The inputs for the function.
   */
  inputs: FunctionInput[];

  /**
   * An output for the function.
   */
  output: FunctionOutput;
}

/**
 * The result of the query compilation request.
 */
model QueryCompilationResult {
  /**
   * Error messages produced by the compiler.
   */
  @visibility("read")
  errors?: QueryCompilationError[];

  /**
   * Warning messages produced by the compiler.
   */
  @visibility("read")
  warnings?: string[];

  /**
   * All input names used by the query.
   */
  @visibility("read")
  inputs?: string[];

  /**
   * All output names used by the query.
   */
  @visibility("read")
  outputs?: string[];

  /**
   * All function names used by the query.
   */
  @visibility("read")
  functions?: string[];
}

/**
 * An error produced by the compiler.
 */
model QueryCompilationError {
  /**
   * The content of the error message.
   */
  @visibility("read")
  message?: string;

  /**
   * Describes the error location in the original query. Not set if isGlobal is true.
   */
  @visibility("read")
  startLine?: int32;

  /**
   * Describes the error location in the original query. Not set if isGlobal is true.
   */
  @visibility("read")
  startColumn?: int32;

  /**
   * Describes the error location in the original query. Not set if isGlobal is true.
   */
  @visibility("read")
  endLine?: int32;

  /**
   * Describes the error location in the original query. Not set if isGlobal is true.
   */
  @visibility("read")
  endColumn?: int32;

  /**
   * Whether the error is not for a specific part but for the entire query.
   */
  @visibility("read")
  isGlobal?: boolean;
}

/**
 * The stream analytics input to sample.
 */
model SampleInput {
  /**
   * The stream analytics input to sample.
   */
  input?: Input;

  /**
   * Defaults to the default ASA job compatibility level. Today it is 1.2
   */
  compatibilityLevel?: string;

  /**
   * The SAS URI of the storage blob for service to write the sampled events to. If this parameter is not provided, service will write events to he system account and share a temporary SAS URI to it.
   */
  eventsUri?: string;

  /**
   * Defaults to en-US.
   */
  dataLocale?: string;
}

/**
 * The result of the sample input request.
 */
model SampleInputResult extends StreamAnalyticsError {
  /**
   * The status of the sample input request.
   */
  @visibility("read")
  status?: SampleInputResultStatus;

  /**
   * Diagnostics messages. E.g. message indicating some partitions from the input have no data.
   */
  @visibility("read")
  diagnostics?: string[];

  /**
   * A SAS URL to download the sampled input data.
   */
  @visibility("read")
  eventsDownloadUrl?: string;

  /**
   * The timestamp for the last event in the data. It is in DateTime format.
   */
  @visibility("read")
  lastArrivalTime?: string;
}

/**
 * A stream analytics input.
 */
model TestInput {
  /**
   * The stream analytics input to test.
   */
  input: Input;
}

/**
 * The result of the test input or output request.
 */
model TestDatasourceResult extends StreamAnalyticsError {
  /**
   * The status of the sample output request.
   */
  @visibility("read")
  status?: TestDatasourceResultStatus;
}

/**
 * A stream analytics output.
 */
model TestOutput {
  /**
   * The stream analytics output to test.
   */
  output: Output;
}

/**
 * The SKU of the cluster. This determines the size/capacity of the cluster. Required on PUT (CreateOrUpdate) requests.
 */
model ClusterSku {
  /**
   * Specifies the SKU name of the cluster. Required on PUT (CreateOrUpdate) requests.
   */
  name?: ClusterSkuName;

  /**
   * Denotes the number of streaming units the cluster can support. Valid values for this property are multiples of 36 with a minimum value of 36 and maximum value of 216. Required on PUT (CreateOrUpdate) requests.
   */
  @maxValue(216)
  @minValue(36)
  capacity?: int32;
}

/**
 * The properties associated with a Stream Analytics cluster.
 */
model ClusterProperties {
  /**
   * The date this cluster was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * Unique identifier for the cluster.
   */
  @visibility("read")
  clusterId?: string;

  /**
   * The status of the cluster provisioning. The three terminal states are: Succeeded, Failed and Canceled
   */
  @visibility("read")
  provisioningState?: ClusterProvisioningState;

  /**
   * Represents the number of streaming units currently being used on the cluster.
   */
  @visibility("read")
  capacityAllocated?: int32;

  /**
   * Represents the sum of the SUs of all streaming jobs associated with the cluster. If all of the jobs were running, this would be the capacity allocated.
   */
  @visibility("read")
  capacityAssigned?: int32;
}

/**
 * A list of streaming jobs. Populated by a List operation.
 */
model ClusterJobListResult is Azure.Core.Page<ClusterJob>;

/**
 * A streaming job.
 */
model ClusterJob {
  /**
   * Resource ID of the streaming job.
   */
  @visibility("read")
  id?: string;

  /**
   * The number of streaming units that are used by the streaming job.
   */
  @visibility("read")
  streamingUnits?: int32;

  /**
   * The current execution state of the streaming job.
   */
  @visibility("read")
  jobState?: JobState;
}

/**
 * The properties associated with a private endpoint.
 */
model PrivateEndpointProperties {
  /**
   * The date when this private endpoint was created.
   */
  @visibility("read")
  createdDate?: string;

  /**
   * A list of connections to the remote resource. Immutable after it is set.
   */
  manualPrivateLinkServiceConnections?: PrivateLinkServiceConnection[];
}

/**
 * A grouping of information about the connection to the remote resource.
 */
model PrivateLinkServiceConnection {
  /**
   * Bag of properties defining a privatelinkServiceConnection.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PrivateLinkServiceConnectionProperties;
}

/**
 * Bag of properties defining a privatelinkServiceConnection.
 */
model PrivateLinkServiceConnectionProperties {
  /**
   * The resource id of the private link service. Required on PUT (CreateOrUpdate) requests.
   */
  privateLinkServiceId?: string;

  /**
   * The ID(s) of the group(s) obtained from the remote resource that this private endpoint should connect to. Required on PUT (CreateOrUpdate) requests.
   */
  groupIds?: string[];

  /**
   * A message passed to the owner of the remote resource with this connection request. Restricted to 140 chars.
   */
  @visibility("read")
  requestMessage?: string;

  /**
   * A collection of read-only information about the state of the connection to the private remote resource.
   */
  privateLinkServiceConnectionState?: PrivateLinkConnectionState;
}

/**
 * A collection of read-only information about the state of the connection to the private remote resource.
 */
model PrivateLinkConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the remote resource/service.
   */
  @visibility("read")
  status?: string;

  /**
   * The reason for approval/rejection of the connection.
   */
  @visibility("read")
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  @visibility("read")
  actionsRequired?: string;
}

/**
 * The resource model definition for a ARM proxy resource. It will have everything other than required location and tags
 */
model ProxyResource extends Resource {}

/**
 * The properties that are associated with a scalar function.
 */
model ScalarFunctionProperties extends FunctionProperties {
  /**
   * Indicates the type of function.
   */
  type: "Scalar";
}

/**
 * The binding to an Azure Machine Learning Studio.
 */
model AzureMachineLearningStudioFunctionBinding extends FunctionBinding {
  /**
   * The binding properties associated with an Azure Machine learning Studio.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AzureMachineLearningStudioFunctionBindingProperties;

  /**
   * Indicates the function binding type.
   */
  type: "Microsoft.MachineLearning/WebService";
}

/**
 * The binding properties associated with an Azure Machine learning Studio.
 */
model AzureMachineLearningStudioFunctionBindingProperties {
  /**
   * The Request-Response execute endpoint of the Azure Machine Learning Studio. Find out more here: https://docs.microsoft.com/en-us/azure/machine-learning/machine-learning-consume-web-services#request-response-service-rrs
   */
  endpoint?: string;

  /**
   * The API key used to authenticate with Request-Response endpoint.
   */
  apiKey?: string;

  /**
   * The inputs for the Azure Machine Learning Studio endpoint.
   */
  inputs?: AzureMachineLearningStudioInputs;

  /**
   * A list of outputs from the Azure Machine Learning Studio endpoint execution.
   */
  outputs?: AzureMachineLearningStudioOutputColumn[];

  /**
   * Number between 1 and 10000 describing maximum number of rows for every Azure ML RRS execute request. Default is 1000.
   */
  batchSize?: int32;
}

/**
 * The inputs for the Azure Machine Learning Studio endpoint.
 */
model AzureMachineLearningStudioInputs {
  /**
   * The name of the input. This is the name provided while authoring the endpoint.
   */
  name?: string;

  /**
   * A list of input columns for the Azure Machine Learning Studio endpoint.
   */
  columnNames?: AzureMachineLearningStudioInputColumn[];
}

/**
 * Describes an input column for the Azure Machine Learning Studio endpoint.
 */
model AzureMachineLearningStudioInputColumn {
  /**
   * The name of the input column.
   */
  name?: string;

  /**
   * The (Azure Machine Learning supported) data type of the input column. A list of valid  Azure Machine Learning data types are described at https://msdn.microsoft.com/en-us/library/azure/dn905923.aspx .
   */
  dataType?: string;

  /**
   * The zero based index of the function parameter this input maps to.
   */
  mapTo?: int32;
}

/**
 * Describes an output column for the Azure Machine Learning Studio endpoint.
 */
model AzureMachineLearningStudioOutputColumn {
  /**
   * The name of the output column.
   */
  name?: string;

  /**
   * The (Azure Machine Learning supported) data type of the output column. A list of valid  Azure Machine Learning data types are described at https://msdn.microsoft.com/en-us/library/azure/dn905923.aspx .
   */
  dataType?: string;
}

/**
 * The binding to a JavaScript function.
 */
model JavaScriptFunctionBinding extends FunctionBinding {
  /**
   * The binding properties associated with a JavaScript function.
   */
  @extension("x-ms-client-flatten", true)
  properties?: JavaScriptFunctionBindingProperties;

  /**
   * Indicates the function binding type.
   */
  type: "Microsoft.StreamAnalytics/JavascriptUdf";
}

/**
 * The binding properties associated with a JavaScript function.
 */
model JavaScriptFunctionBindingProperties {
  /**
   * The JavaScript code containing a single function definition. For example: 'function (x, y) { return x + y; }'
   */
  script?: string;
}

/**
 * The binding to a CSharp function.
 */
model CSharpFunctionBinding extends FunctionBinding {
  /**
   * The binding properties associated with a CSharp function.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CSharpFunctionBindingProperties;

  /**
   * Indicates the function binding type.
   */
  type: "Microsoft.StreamAnalytics/CLRUdf";
}

/**
 * The binding properties associated with a CSharp function.
 */
model CSharpFunctionBindingProperties {
  /**
   * The Csharp code containing a single function definition.
   */
  dllPath?: string;

  /**
   * The Csharp code containing a single function definition.
   */
  class?: string;

  /**
   * The Csharp code containing a single function definition.
   */
  method?: string;

  /**
   * Refresh modes for Stream Analytics functions.
   */
  updateMode?: UpdateMode;
}

/**
 * The parameters needed to retrieve the default function definition for an Azure Machine Learning Studio function.
 */
model AzureMachineLearningStudioFunctionRetrieveDefaultDefinitionParameters
  extends FunctionRetrieveDefaultDefinitionParameters {
  /**
   * The binding retrieval properties associated with an Azure Machine learning Studio.
   */
  @extension("x-ms-client-flatten", true)
  bindingRetrievalProperties?: AzureMachineLearningStudioFunctionBindingRetrievalProperties;

  /**
   * Indicates the function binding type.
   */
  bindingType: "Microsoft.MachineLearning/WebService";
}

/**
 * The binding retrieval properties associated with an Azure Machine learning Studio.
 */
model AzureMachineLearningStudioFunctionBindingRetrievalProperties {
  /**
   * The Request-Response execute endpoint of the Azure Machine Learning Studio. Find out more here: https://docs.microsoft.com/en-us/azure/machine-learning/machine-learning-consume-web-services#request-response-service-rrs
   */
  executeEndpoint?: string;

  /**
   * The function type.
   */
  udfType?: "Scalar";
}

/**
 * The parameters needed to retrieve the default function definition for an Azure Machine Learning web service function.
 */
model AzureMachineLearningServiceFunctionRetrieveDefaultDefinitionParameters
  extends FunctionRetrieveDefaultDefinitionParameters {
  /**
   * The binding retrieval properties associated with an Azure Machine learning web service.
   */
  @extension("x-ms-client-flatten", true)
  bindingRetrievalProperties?: AzureMachineLearningServiceFunctionBindingRetrievalProperties;

  /**
   * Indicates the function binding type.
   */
  bindingType: "Microsoft.MachineLearningServices";
}

/**
 * The binding retrieval properties associated with an Azure Machine learning web service.
 */
model AzureMachineLearningServiceFunctionBindingRetrievalProperties {
  /**
   * The Request-Response execute endpoint of the Azure Machine Learning web service.
   */
  executeEndpoint?: string;

  /**
   * The function type.
   */
  udfType?: "Scalar";
}

/**
 * The parameters needed to retrieve the default function definition for a JavaScript function.
 */
model JavaScriptFunctionRetrieveDefaultDefinitionParameters
  extends FunctionRetrieveDefaultDefinitionParameters {
  /**
   * The binding retrieval properties associated with a JavaScript function.
   */
  @extension("x-ms-client-flatten", true)
  bindingRetrievalProperties?: JavaScriptFunctionBindingRetrievalProperties;

  /**
   * Indicates the function binding type.
   */
  bindingType: "Microsoft.StreamAnalytics/JavascriptUdf";
}

/**
 * The binding retrieval properties associated with a JavaScript function.
 */
model JavaScriptFunctionBindingRetrievalProperties {
  /**
   * The JavaScript code containing a single function definition. For example: 'function (x, y) { return x + y; }'.
   */
  script?: string;

  /**
   * The function type.
   */
  udfType?: "Scalar";
}

/**
 * The parameters needed to retrieve the default function definition for a CSharp function.
 */
model CSharpFunctionRetrieveDefaultDefinitionParameters
  extends FunctionRetrieveDefaultDefinitionParameters {
  /**
   * The binding retrieval properties associated with a CSharp function.
   */
  @extension("x-ms-client-flatten", true)
  bindingRetrievalProperties?: CSharpFunctionBindingRetrievalProperties;

  /**
   * Indicates the function binding type.
   */
  bindingType: "Microsoft.StreamAnalytics/CLRUdf";
}

/**
 * The binding retrieval properties associated with a CSharp function.
 */
model CSharpFunctionBindingRetrievalProperties {
  /**
   * The CSharp code containing a single function definition.
   */
  script?: string;

  /**
   * The function type.
   */
  udfType?: "Scalar";
}

/**
 * The binding to an Azure Machine Learning web service.
 */
model AzureMachineLearningServiceFunctionBinding extends FunctionBinding {
  /**
   * The binding properties associated with an Azure Machine learning web service.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AzureMachineLearningServiceFunctionBindingProperties;

  /**
   * Indicates the function binding type.
   */
  type: "Microsoft.MachineLearningServices";
}

/**
 * The binding properties associated with an Azure Machine learning web service.
 */
model AzureMachineLearningServiceFunctionBindingProperties {
  /**
   * The Request-Response execute endpoint of the Azure Machine Learning web service.
   */
  endpoint?: string;

  /**
   * The API key used to authenticate with Request-Response endpoint.
   */
  apiKey?: string;

  /**
   * The inputs for the Azure Machine Learning web service endpoint.
   */
  inputs?: AzureMachineLearningServiceInputColumn[];

  /**
   * A list of outputs from the Azure Machine Learning web service endpoint execution.
   */
  outputs?: AzureMachineLearningServiceOutputColumn[];

  /**
   * Number between 1 and 10000 describing maximum number of rows for every Azure ML RRS execute request. Default is 1000.
   */
  batchSize?: int32;

  /**
   * The number of parallel requests that will be sent per partition of your job to the machine learning service. Default is 1.
   */
  numberOfParallelRequests?: int32;

  /**
   * Label for the input request object.
   */
  inputRequestName?: string;

  /**
   * Label for the output request object.
   */
  outputResponseName?: string;
}

/**
 * Describes an input column for the Azure Machine Learning web service endpoint.
 */
model AzureMachineLearningServiceInputColumn {
  /**
   * The name of the input column.
   */
  name?: string;

  /**
   * The (Azure Machine Learning supported) data type of the input column.
   */
  dataType?: string;

  /**
   * The zero based index of the function parameter this input maps to.
   */
  mapTo?: int32;
}

/**
 * Describes an output column for the Azure Machine Learning web service endpoint.
 */
model AzureMachineLearningServiceOutputColumn {
  /**
   * The name of the output column.
   */
  name?: string;

  /**
   * The (Azure Machine Learning supported) data type of the output column.
   */
  dataType?: string;

  /**
   * The zero based index of the function parameter this input maps to.
   */
  mapTo?: int32;
}

/**
 * The inputs for the Azure Machine Learning web service endpoint.
 */
model AzureMachineLearningServiceInputs {
  /**
   * The name of the input. This is the name provided while authoring the endpoint.
   */
  name?: string;

  /**
   * A list of input columns for the Azure Machine Learning web service endpoint.
   */
  columnNames?: AzureMachineLearningServiceInputColumn[];
}

/**
 * The properties that are associated with an aggregate function.
 */
model AggregateFunctionProperties extends FunctionProperties {
  /**
   * Indicates the type of function.
   */
  type: "Aggregate";
}

/**
 * The properties that are associated with an input containing stream data.
 */
model StreamInputProperties extends InputProperties {
  /**
   * Describes an input data source that contains stream data. Required on PUT (CreateOrReplace) requests.
   */
  datasource?: StreamInputDataSource;

  /**
   * Indicates whether the input is a source of reference data or stream data. Required on PUT (CreateOrReplace) requests.
   */
  type: "Stream";
}

/**
 * Describes an input data source that contains stream data.
 */
@discriminator("type")
model StreamInputDataSource {}

/**
 * The properties that are associated with an input containing reference data.
 */
model ReferenceInputProperties extends InputProperties {
  /**
   * Describes an input data source that contains reference data. Required on PUT (CreateOrReplace) requests.
   */
  datasource?: ReferenceInputDataSource;

  /**
   * Indicates whether the input is a source of reference data or stream data. Required on PUT (CreateOrReplace) requests.
   */
  type: "Reference";
}

/**
 * Describes an input data source that contains reference data.
 */
@discriminator("type")
model ReferenceInputDataSource {}

/**
 * Describes a blob input data source that contains stream data.
 */
model BlobStreamInputDataSource extends StreamInputDataSource {
  /**
   * The properties that are associated with a blob input containing stream data. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: BlobStreamInputDataSourceProperties;

  /**
   * Indicates the type of input data source containing stream data. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.Storage/Blob";
}

/**
 * The properties that are associated with a blob input containing stream data.
 */
model BlobStreamInputDataSourceProperties extends BlobDataSourceProperties {
  /**
   * The partition count of the blob input data source. Range 1 - 1024.
   */
  sourcePartitionCount?: int32;
}

/**
 * The properties that are associated with a blob data source.
 */
model BlobDataSourceProperties {
  /**
   * A list of one or more Azure Storage accounts. Required on PUT (CreateOrReplace) requests.
   */
  storageAccounts?: StorageAccount[];

  /**
   * The name of a container within the associated Storage account. This container contains either the blob(s) to be read from or written to. Required on PUT (CreateOrReplace) requests.
   */
  container?: string;

  /**
   * The blob path pattern. Not a regular expression. It represents a pattern against which blob names will be matched to determine whether or not they should be included as input or output to the job. See https://docs.microsoft.com/en-us/rest/api/streamanalytics/stream-analytics-input or https://docs.microsoft.com/en-us/rest/api/streamanalytics/stream-analytics-output for a more detailed explanation and example.
   */
  pathPattern?: string;

  /**
   * The date format. Wherever {date} appears in pathPattern, the value of this property is used as the date format instead.
   */
  dateFormat?: string;

  /**
   * The time format. Wherever {time} appears in pathPattern, the value of this property is used as the time format instead.
   */
  timeFormat?: string;

  /**
   * Authentication Mode.
   */
  authenticationMode?: AuthenticationMode;
}

/**
 * Describes an Event Hub input data source that contains stream data.
 */
model EventHubStreamInputDataSource extends StreamInputDataSource {
  /**
   * The properties that are associated with an Event Hub input containing stream data. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: EventHubStreamInputDataSourceProperties;

  /**
   * Indicates the type of input data source containing stream data. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.ServiceBus/EventHub";
}

/**
 * The properties that are associated with a Event Hub input containing stream data.
 */
model EventHubStreamInputDataSourceProperties
  extends EventHubDataSourceProperties {
  /**
   * The name of an Event Hub Consumer Group that should be used to read events from the Event Hub. Specifying distinct consumer group names for multiple inputs allows each of those inputs to receive the same events from the Event Hub. If not specified, the input uses the Event Hub’s default consumer group.
   */
  consumerGroupName?: string;

  /**
   * The number of messages that the message receiver can simultaneously request.
   */
  prefetchCount?: int32;
}

/**
 * The common properties that are associated with Event Hub data sources.
 */
model EventHubDataSourceProperties extends ServiceBusDataSourceProperties {
  /**
   * The name of the Event Hub. Required on PUT (CreateOrReplace) requests.
   */
  eventHubName?: string;

  /**
   * The partition count of the event hub data source. Range 1 - 256.
   */
  partitionCount?: int32;
}

/**
 * The common properties that are associated with Service Bus data sources (Queues, Topics, Event Hubs, etc.).
 */
model ServiceBusDataSourceProperties {
  /**
   * The namespace that is associated with the desired Event Hub, Service Bus Queue, Service Bus Topic, etc. Required on PUT (CreateOrReplace) requests.
   */
  serviceBusNamespace?: string;

  /**
   * The shared access policy name for the Event Hub, Service Bus Queue, Service Bus Topic, etc. Required on PUT (CreateOrReplace) requests.
   */
  sharedAccessPolicyName?: string;

  /**
   * The shared access policy key for the specified shared access policy. Required on PUT (CreateOrReplace) requests.
   */
  sharedAccessPolicyKey?: string;

  /**
   * Authentication Mode.
   */
  authenticationMode?: AuthenticationMode;
}

/**
 * Describes an Event Hub input data source that contains stream data.
 */
model EventHubV2StreamInputDataSource extends StreamInputDataSource {
  /**
   * The properties that are associated with an Event Hub input containing stream data. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: EventHubStreamInputDataSourceProperties;

  /**
   * Indicates the type of input data source containing stream data. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.EventHub/EventHub";
}

/**
 * Describes an IoT Hub input data source that contains stream data.
 */
model IoTHubStreamInputDataSource extends StreamInputDataSource {
  /**
   * The properties that are associated with an IoT Hub input containing stream data. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: IoTHubStreamInputDataSourceProperties;

  /**
   * Indicates the type of input data source containing stream data. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.Devices/IotHubs";
}

/**
 * The properties that are associated with a IoT Hub input containing stream data.
 */
model IoTHubStreamInputDataSourceProperties {
  /**
   * The name or the URI of the IoT Hub. Required on PUT (CreateOrReplace) requests.
   */
  iotHubNamespace?: string;

  /**
   * The shared access policy name for the IoT Hub. This policy must contain at least the Service connect permission. Required on PUT (CreateOrReplace) requests.
   */
  sharedAccessPolicyName?: string;

  /**
   * The shared access policy key for the specified shared access policy. Required on PUT (CreateOrReplace) requests.
   */
  sharedAccessPolicyKey?: string;

  /**
   * The name of an IoT Hub Consumer Group that should be used to read events from the IoT Hub. If not specified, the input uses the Iot Hub’s default consumer group.
   */
  consumerGroupName?: string;

  /**
   * The IoT Hub endpoint to connect to (ie. messages/events, messages/operationsMonitoringEvents, etc.).
   */
  endpoint?: string;
}

/**
 * Describes a raw input data source that contains stream data. This data source type is only applicable/usable when using the query testing API. You cannot create a job with this data source type or add an input of this data source type to an existing job.
 */
model RawStreamInputDataSource extends StreamInputDataSource {
  /**
   * The properties that are associated with a raw input. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: RawInputDatasourceProperties;

  /**
   * Indicates the type of input data source containing stream data. Required on PUT (CreateOrReplace) requests.
   */
  type: "Raw";
}

/**
 * The properties that are associated with a raw input.
 */
model RawInputDatasourceProperties {
  /**
   * The JSON serialized content of the input data. Either payload or payloadUri must be set, but not both.
   */
  payload?: string;

  /**
   * The SAS URL to a blob containing the JSON serialized content of the input data. Either payload or payloadUri must be set, but not both.
   */
  payloadUri?: string;
}

/**
 * Describes a blob input data source that contains reference data.
 */
model BlobReferenceInputDataSource extends ReferenceInputDataSource {
  /**
   * The properties that are associated with a blob input containing reference data. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: BlobReferenceInputDataSourceProperties;

  /**
   * Indicates the type of input data source containing reference data. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.Storage/Blob";
}

/**
 * The properties that are associated with a blob input containing reference data.
 */
model BlobReferenceInputDataSourceProperties extends BlobDataSourceProperties {
  /**
   * The name of the blob input.
   */
  blobName?: string;

  /**
   * The path pattern of the delta snapshot.
   */
  deltaPathPattern?: string;

  /**
   * The partition count of the blob input data source. Range 1 - 256.
   */
  sourcePartitionCount?: int32;

  /**
   * The refresh interval of the blob input data source.
   */
  @projectedName("json", "fullSnapshotRefreshRate")
  fullSnapshotRefreshInterval?: plainTime;

  /**
   * The interval that the user generates a delta snapshot of this reference blob input data source.
   */
  @projectedName("json", "deltaSnapshotRefreshRate")
  deltaSnapshotRefreshInterval?: plainTime;
}

/**
 * Describes a raw input data source that contains reference data. This data source type is only applicable/usable when using the query testing API. You cannot create a job with this data source type or add an input of this data source type to an existing job.
 */
model RawReferenceInputDataSource extends ReferenceInputDataSource {
  /**
   * The properties that are associated with a raw input containing reference data. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: RawInputDatasourceProperties;

  /**
   * Indicates the type of input data source containing reference data. Required on PUT (CreateOrReplace) requests.
   */
  type: "Raw";
}

/**
 * Describes how data from an input is serialized or how data is serialized when written to an output in Parquet format.
 */
model ParquetSerialization extends Serialization {
  /**
   * The properties that are associated with the Parquet serialization type. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: Record<unknown>;

  /**
   * Indicates the type of serialization that the input or output uses. Required on PUT (CreateOrReplace) requests.
   */
  type: "Parquet";
}

/**
 * Describes how data from an input is serialized or how data is serialized when written to an output in custom format.
 */
model CustomClrSerialization extends Serialization {
  /**
   * The properties that are associated with the CustomClr serialization type. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CustomClrSerializationProperties;

  /**
   * Indicates the type of serialization that the input or output uses. Required on PUT (CreateOrReplace) requests.
   */
  type: "CustomClr";
}

/**
 * The properties that are associated with the CustomClr serialization type.
 */
model CustomClrSerializationProperties {
  /**
   * The serialization library path.
   */
  serializationDllPath?: string;

  /**
   * The serialization class name.
   */
  serializationClassName?: string;
}

/**
 * Describes how data from an input is serialized or how data is serialized when written to an output in CSV format.
 */
model CsvSerialization extends Serialization {
  /**
   * The properties that are associated with the CSV serialization type. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CsvSerializationProperties;

  /**
   * Indicates the type of serialization that the input or output uses. Required on PUT (CreateOrReplace) requests.
   */
  type: "Csv";
}

/**
 * The properties that are associated with the CSV serialization type.
 */
model CsvSerializationProperties {
  /**
   * Specifies the delimiter that will be used to separate comma-separated value (CSV) records. See https://docs.microsoft.com/en-us/rest/api/streamanalytics/stream-analytics-input or https://docs.microsoft.com/en-us/rest/api/streamanalytics/stream-analytics-output for a list of supported values. Required on PUT (CreateOrReplace) requests.
   */
  fieldDelimiter?: string;

  /**
   * Specifies the encoding of the incoming data in the case of input and the encoding of outgoing data in the case of output. Required on PUT (CreateOrReplace) requests.
   */
  encoding?: Encoding;
}

/**
 * Describes how data from an input is serialized or how data is serialized when written to an output in JSON format.
 */
model JsonSerialization extends Serialization {
  /**
   * The properties that are associated with the JSON serialization type. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: JsonSerializationProperties;

  /**
   * Indicates the type of serialization that the input or output uses. Required on PUT (CreateOrReplace) requests.
   */
  type: "Json";
}

/**
 * The properties that are associated with the JSON serialization type.
 */
model JsonSerializationProperties {
  /**
   * Specifies the encoding of the incoming data in the case of input and the encoding of outgoing data in the case of output. Required on PUT (CreateOrReplace) requests.
   */
  encoding?: Encoding;

  /**
   * This property only applies to JSON serialization of outputs only. It is not applicable to inputs. This property specifies the format of the JSON the output will be written in. The currently supported values are 'lineSeparated' indicating the output will be formatted by having each JSON object separated by a new line and 'array' indicating the output will be formatted as an array of JSON objects. Default value is 'lineSeparated' if left null.
   */
  format?: JsonOutputSerializationFormat;
}

/**
 * Describes how data from an input is serialized or how data is serialized when written to an output in Avro format.
 */
model AvroSerialization extends Serialization {
  /**
   * The properties that are associated with the Avro serialization type. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: Record<unknown>;

  /**
   * Indicates the type of serialization that the input or output uses. Required on PUT (CreateOrReplace) requests.
   */
  type: "Avro";
}

/**
 * Describes an Azure SQL database reference input data source.
 */
model AzureSqlReferenceInputDataSource extends ReferenceInputDataSource {
  /**
   * The properties that are associated with SQL DB input containing reference data. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AzureSqlReferenceInputDataSourceProperties;

  /**
   * Indicates the type of input data source containing reference data. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.Sql/Server/Database";
}

/**
 * The properties that are associated with SQL DB input containing reference data. Required on PUT (CreateOrReplace) requests.
 */
model AzureSqlReferenceInputDataSourceProperties {
  /**
   * This element is associated with the datasource element. This is the name of the server that contains the database that will be written to.
   */
  server?: string;

  /**
   * This element is associated with the datasource element. This is the name of the database that output will be written to.
   */
  database?: string;

  /**
   * This element is associated with the datasource element. This is the user name that will be used to connect to the SQL Database instance.
   */
  user?: string;

  /**
   * This element is associated with the datasource element. This is the password that will be used to connect to the SQL Database instance.
   */
  password?: string;

  /**
   * Indicates the type of data refresh option.
   */
  refreshType?: RefreshType;

  /**
   * This element is associated with the datasource element. This indicates how frequently the data will be fetched from the database. It is of DateTime format.
   */
  @projectedName("json", "refreshRate")
  refreshInterval?: plainTime;

  /**
   * This element is associated with the datasource element. This query is used to fetch data from the sql database.
   */
  fullSnapshotQuery?: string;

  /**
   * This element is associated with the datasource element. This query is used to fetch incremental changes from the SQL database. To use this option, we recommend using temporal tables in Azure SQL Database.
   */
  deltaSnapshotQuery?: string;

  /**
   * Authentication Mode.
   */
  authenticationMode?: AuthenticationMode;
}

/**
 * Describes a blob input data source that contains stream data.
 */
model GatewayMessageBusStreamInputDataSource extends StreamInputDataSource {
  /**
   * The properties that are associated with a gateway message bus input containing stream data.
   */
  @extension("x-ms-client-flatten", true)
  properties?: GatewayMessageBusStreamInputDataSourceProperties;

  /**
   * Indicates the type of input data source containing stream data. Required on PUT (CreateOrReplace) requests.
   */
  type: "GatewayMessageBus";
}

/**
 * The properties that are associated with a gateway message bus input containing stream data.
 */
model GatewayMessageBusStreamInputDataSourceProperties
  extends GatewayMessageBusSourceProperties {}

/**
 * The properties that are associated with a gateway message bus datasource.
 */
model GatewayMessageBusSourceProperties {
  /**
   * The name of the Service Bus topic.
   */
  topic?: string;
}

/**
 * Describes an event grid input data source that contains stream data.
 */
model EventGridStreamInputDataSource extends StreamInputDataSource {
  /**
   * The properties that are associated with an event grid input containing stream data.
   */
  @extension("x-ms-client-flatten", true)
  properties?: EventGridStreamInputDataSourceProperties;

  /**
   * Indicates the type of input data source containing stream data. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.EventGrid/EventSubscriptions";
}

/**
 * The properties that are associated with an event grid input containing stream data.
 */
model EventGridStreamInputDataSourceProperties {
  /**
   * Subscribers for the Event Grid. Currently only EventHub Subscriber is supported.
   */
  subscriber?: EventHubV2StreamInputDataSource;

  /**
   * Indicates the Event Grid schema type.
   */
  schema?: EventGridEventSchemaType;

  /**
   * A list of one or more Azure Storage accounts. Required on PUT (CreateOrReplace) requests.
   */
  storageAccounts?: StorageAccount[];

  /**
   * List of Event Types that are supported by the Event Grid adapter.
   */
  eventTypes?: string[];
}

/**
 * Describes a raw output data source. This data source type is only applicable/usable when using the query testing API. You cannot create a job with this data source type or add an output of this data source type to an existing job.
 */
model RawOutputDatasource extends OutputDataSource {
  /**
   * The properties that are associated with a raw output. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: RawOutputDatasourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Raw";
}

/**
 * The properties that are associated with a raw output.
 */
model RawOutputDatasourceProperties {
  /**
   * The SAS URL to a blob where the output should be written. If this property is not set, output data will be written into a temporary storage, and a SAS URL to that temporary storage will be included in the result.
   */
  payloadUri?: string;
}

/**
 * Describes a blob output data source.
 */
model BlobOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with a blob output. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: BlobOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.Storage/Blob";
}

/**
 * The properties that are associated with a blob output.
 */
model BlobOutputDataSourceProperties extends BlobDataSourceProperties {
  /**
   * Blob path prefix.
   */
  blobPathPrefix?: string;

  /**
   * Blob write mode.
   */
  blobWriteMode?: BlobWriteMode;
}

/**
 * Describes an Azure Table output data source.
 */
model AzureTableOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with an Azure Table output. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AzureTableOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.Storage/Table";
}

/**
 * The properties that are associated with an Azure Table output.
 */
model AzureTableOutputDataSourceProperties {
  /**
   * The name of the Azure Storage account. Required on PUT (CreateOrReplace) requests.
   */
  accountName?: string;

  /**
   * The account key for the Azure Storage account. Required on PUT (CreateOrReplace) requests.
   */
  accountKey?: string;

  /**
   * The name of the Azure Table. Required on PUT (CreateOrReplace) requests.
   */
  table?: string;

  /**
   * This element indicates the name of a column from the SELECT statement in the query that will be used as the partition key for the Azure Table. Required on PUT (CreateOrReplace) requests.
   */
  partitionKey?: string;

  /**
   * This element indicates the name of a column from the SELECT statement in the query that will be used as the row key for the Azure Table. Required on PUT (CreateOrReplace) requests.
   */
  rowKey?: string;

  /**
   * If specified, each item in the array is the name of a column to remove (if present) from output event entities.
   */
  columnsToRemove?: string[];

  /**
   * The number of rows to write to the Azure Table at a time.
   */
  batchSize?: int32;
}

/**
 * Describes an Event Hub output data source.
 */
model EventHubOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with an Event Hub output. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: EventHubOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.ServiceBus/EventHub";
}

/**
 * The properties that are associated with an Event Hub output.
 */
model EventHubOutputDataSourceProperties extends EventHubDataSourceProperties {
  /**
   * The key/column that is used to determine to which partition to send event data.
   */
  partitionKey?: string;

  /**
   * The properties associated with this Event Hub output.
   */
  propertyColumns?: string[];
}

/**
 * Describes an Event Hub output data source.
 */
model EventHubV2OutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with an Event Hub output. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: EventHubOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.EventHub/EventHub";
}

/**
 * Describes an Azure SQL database output data source.
 */
model AzureSqlDatabaseOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with an Azure SQL database output. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AzureSqlDatabaseOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.Sql/Server/Database";
}

/**
 * The properties that are associated with an Azure SQL database output.
 */
model AzureSqlDatabaseOutputDataSourceProperties
  extends AzureSqlDatabaseDataSourceProperties {}

/**
 * The properties that are associated with an Azure SQL database data source.
 */
model AzureSqlDatabaseDataSourceProperties {
  /**
   * The name of the SQL server containing the Azure SQL database. Required on PUT (CreateOrReplace) requests.
   */
  server?: string;

  /**
   * The name of the Azure SQL database. Required on PUT (CreateOrReplace) requests.
   */
  database?: string;

  /**
   * The user name that will be used to connect to the Azure SQL database. Required on PUT (CreateOrReplace) requests.
   */
  user?: string;

  /**
   * The password that will be used to connect to the Azure SQL database. Required on PUT (CreateOrReplace) requests.
   */
  password?: string;

  /**
   * The name of the table in the Azure SQL database. Required on PUT (CreateOrReplace) requests.
   */
  table?: string;

  /**
   * Max Batch count for write to Sql database, the default value is 10,000. Optional on PUT requests.
   */
  maxBatchCount?: int32;

  /**
   * Max Writer count, currently only 1(single writer) and 0(based on query partition) are available. Optional on PUT requests.
   */
  maxWriterCount?: int32;

  /**
   * Authentication Mode.
   */
  authenticationMode?: AuthenticationMode;
}

/**
 * Describes an Azure Synapse output data source.
 */
model AzureSynapseOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with an Azure Synapse output. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AzureSynapseOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.Sql/Server/DataWarehouse";
}

/**
 * The properties that are associated with an Azure Synapse output.
 */
model AzureSynapseOutputDataSourceProperties
  extends AzureSynapseDataSourceProperties {}

/**
 * The properties that are associated with an Azure SQL database data source.
 */
model AzureSynapseDataSourceProperties {
  /**
   * The name of the SQL server containing the Azure SQL database. Required on PUT (CreateOrReplace) requests.
   */
  server?: string;

  /**
   * The name of the Azure SQL database. Required on PUT (CreateOrReplace) requests.
   */
  database?: string;

  /**
   * The name of the table in the Azure SQL database. Required on PUT (CreateOrReplace) requests.
   */
  table?: string;

  /**
   * The user name that will be used to connect to the Azure SQL database. Required on PUT (CreateOrReplace) requests.
   */
  user?: string;

  /**
   * The password that will be used to connect to the Azure SQL database. Required on PUT (CreateOrReplace) requests.
   */
  password?: string;

  /**
   * Authentication Mode.
   */
  authenticationMode?: AuthenticationMode;
}

/**
 * Describes a PostgreSQL output data source.
 */
model PostgreSQLOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with a PostgreSQL output data source. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PostgreSQLOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.DBForPostgreSQL/servers/databases";
}

/**
 * The properties that are associated with a PostgreSQL output.
 */
model PostgreSQLOutputDataSourceProperties
  extends PostgreSQLDataSourceProperties {}

/**
 * The properties that are associated with an Azure SQL database data source.
 */
model PostgreSQLDataSourceProperties {
  /**
   * The name of the SQL server containing the Azure SQL database. Required on PUT (CreateOrReplace) requests.
   */
  server?: string;

  /**
   * The name of the Azure SQL database. Required on PUT (CreateOrReplace) requests.
   */
  database?: string;

  /**
   * The name of the table in the Azure SQL database. Required on PUT (CreateOrReplace) requests.
   */
  table?: string;

  /**
   * The user name that will be used to connect to the Azure SQL database. Required on PUT (CreateOrReplace) requests.
   */
  user?: string;

  /**
   * The password that will be used to connect to the Azure SQL database. Required on PUT (CreateOrReplace) requests.
   */
  password?: string;

  /**
   * Max Writer count, currently only 1(single writer) and 0(based on query partition) are available. Optional on PUT requests.
   */
  maxWriterCount?: int32;

  /**
   * Authentication Mode.
   */
  authenticationMode?: AuthenticationMode;
}

/**
 * Describes a DocumentDB output data source.
 */
model DocumentDbOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with a DocumentDB output. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DocumentDbOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.Storage/DocumentDB";
}

/**
 * The properties that are associated with a DocumentDB output.
 */
model DocumentDbOutputDataSourceProperties {
  /**
   * The DocumentDB account name or ID. Required on PUT (CreateOrReplace) requests.
   */
  accountId?: string;

  /**
   * The account key for the DocumentDB account. Required on PUT (CreateOrReplace) requests.
   */
  accountKey?: string;

  /**
   * The name of the DocumentDB database. Required on PUT (CreateOrReplace) requests.
   */
  database?: string;

  /**
   * The collection name pattern for the collections to be used. The collection name format can be constructed using the optional {partition} token, where partitions start from 0. See the DocumentDB section of https://docs.microsoft.com/en-us/rest/api/streamanalytics/stream-analytics-output for more information. Required on PUT (CreateOrReplace) requests.
   */
  collectionNamePattern?: string;

  /**
   * The name of the field in output events used to specify the key for partitioning output across collections. If 'collectionNamePattern' contains the {partition} token, this property is required to be specified.
   */
  partitionKey?: string;

  /**
   * The name of the field in output events used to specify the primary key which insert or update operations are based on.
   */
  documentId?: string;

  /**
   * Authentication Mode.
   */
  authenticationMode?: AuthenticationMode;
}

/**
 * Defines the metadata of AzureFunctionOutputDataSource
 */
model AzureFunctionOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with a Azure Function output. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AzureFunctionOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.AzureFunction";
}

/**
 * The properties that are associated with an Azure Function output.
 */
model AzureFunctionOutputDataSourceProperties {
  /**
   * The name of your Azure Functions app.
   */
  functionAppName?: string;

  /**
   * The name of the function in your Azure Functions app.
   */
  functionName?: string;

  /**
   * If you want to use an Azure Function from another subscription, you can do so by providing the key to access your function.
   */
  apiKey?: string;

  /**
   * A property that lets you set the maximum size for each output batch that's sent to your Azure function. The input unit is in bytes. By default, this value is 262,144 bytes (256 KB).
   */
  maxBatchSize?: int32;

  /**
   * A property that lets you specify the maximum number of events in each batch that's sent to Azure Functions. The default value is 100.
   */
  maxBatchCount?: int32;
}

/**
 * Describes a Service Bus Queue output data source.
 */
model ServiceBusQueueOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with a Service Bus Queue output. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ServiceBusQueueOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.ServiceBus/Queue";
}

/**
 * The properties that are associated with a Service Bus Queue output.
 */
model ServiceBusQueueOutputDataSourceProperties
  extends ServiceBusDataSourceProperties {
  /**
   * The name of the Service Bus Queue. Required on PUT (CreateOrReplace) requests.
   */
  queueName?: string;

  /**
   * A string array of the names of output columns to be attached to Service Bus messages as custom properties.
   */
  propertyColumns?: string[];

  /**
   * The system properties associated with the Service Bus Queue. The following system properties are supported: ReplyToSessionId, ContentType, To, Subject, CorrelationId, TimeToLive, PartitionKey, SessionId, ScheduledEnqueueTime, MessageId, ReplyTo, Label, ScheduledEnqueueTimeUtc.
   */
  systemPropertyColumns?: Record<string>;
}

/**
 * Describes a Service Bus Topic output data source.
 */
model ServiceBusTopicOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with a Service Bus Topic output. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ServiceBusTopicOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.ServiceBus/Topic";
}

/**
 * The properties that are associated with a Service Bus Topic output.
 */
model ServiceBusTopicOutputDataSourceProperties
  extends ServiceBusDataSourceProperties {
  /**
   * The name of the Service Bus Topic. Required on PUT (CreateOrReplace) requests.
   */
  topicName?: string;

  /**
   * A string array of the names of output columns to be attached to Service Bus messages as custom properties.
   */
  propertyColumns?: string[];

  /**
   * The system properties associated with the Service Bus Topic Output. The following system properties are supported: ReplyToSessionId, ContentType, To, Subject, CorrelationId, TimeToLive, PartitionKey, SessionId, ScheduledEnqueueTime, MessageId, ReplyTo, Label, ScheduledEnqueueTimeUtc.
   */
  systemPropertyColumns?: Record<string>;
}

/**
 * Describes a Power BI output data source.
 */
model PowerBIOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with a Power BI output. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PowerBIOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "PowerBI";
}

/**
 * The properties that are associated with a Power BI output.
 */
model PowerBIOutputDataSourceProperties extends OAuthBasedDataSourceProperties {
  /**
   * The name of the Power BI dataset. Required on PUT (CreateOrReplace) requests.
   */
  dataset?: string;

  /**
   * The name of the Power BI table under the specified dataset. Required on PUT (CreateOrReplace) requests.
   */
  table?: string;

  /**
   * The ID of the Power BI group.
   */
  groupId?: string;

  /**
   * The name of the Power BI group. Use this property to help remember which specific Power BI group id was used.
   */
  groupName?: string;

  /**
   * Authentication Mode.
   */
  authenticationMode?: AuthenticationMode;
}

/**
 * The properties that are associated with data sources that use OAuth as their authentication model.
 */
model OAuthBasedDataSourceProperties {
  /**
   * A refresh token that can be used to obtain a valid access token that can then be used to authenticate with the data source. A valid refresh token is currently only obtainable via the Azure Portal. It is recommended to put a dummy string value here when creating the data source and then going to the Azure Portal to authenticate the data source which will update this property with a valid refresh token. Required on PUT (CreateOrReplace) requests.
   */
  refreshToken?: string;

  /**
   * The user principal name (UPN) of the user that was used to obtain the refresh token. Use this property to help remember which user was used to obtain the refresh token.
   */
  tokenUserPrincipalName?: string;

  /**
   * The user display name of the user that was used to obtain the refresh token. Use this property to help remember which user was used to obtain the refresh token.
   */
  tokenUserDisplayName?: string;
}

/**
 * Describes an Azure Data Lake Store output data source.
 */
model AzureDataLakeStoreOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with an Azure Data Lake Store output. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AzureDataLakeStoreOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.DataLake/Accounts";
}

/**
 * The properties that are associated with an Azure Data Lake Store.
 */
model AzureDataLakeStoreOutputDataSourceProperties
  extends OAuthBasedDataSourceProperties {
  /**
   * The name of the Azure Data Lake Store account. Required on PUT (CreateOrReplace) requests.
   */
  accountName?: string;

  /**
   * The tenant id of the user used to obtain the refresh token. Required on PUT (CreateOrReplace) requests.
   */
  tenantId?: string;

  /**
   * The location of the file to which the output should be written to. Required on PUT (CreateOrReplace) requests.
   */
  filePathPrefix?: string;

  /**
   * The date format. Wherever {date} appears in filePathPrefix, the value of this property is used as the date format instead.
   */
  dateFormat?: string;

  /**
   * The time format. Wherever {time} appears in filePathPrefix, the value of this property is used as the time format instead.
   */
  timeFormat?: string;

  /**
   * Authentication Mode.
   */
  authenticationMode?: AuthenticationMode;
}

/**
 * Describes a Gateway Message Bus output data source.
 */
model GatewayMessageBusOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with a Gateway Message Bus output. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: GatewayMessageBusOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "GatewayMessageBus";
}

/**
 * The properties that are associated with a Gateway Message Bus.
 */
model GatewayMessageBusOutputDataSourceProperties
  extends GatewayMessageBusSourceProperties {}
