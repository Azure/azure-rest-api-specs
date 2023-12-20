import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.StreamAnalytics;

interface Operations extends Azure.ResourceManager.Operations {}

enum EventSerializationType {
  Csv,
  Avro,
  Json,
  CustomClr,
  Parquet,
}

enum CompressionType {
  None,
  GZip,
  Deflate,
}

enum InputWatermarkMode {
  None,
  ReadWatermark,
}

enum OutputWatermarkMode {
  None,
  SendCurrentPartitionWatermark,
  SendLowestWatermarkAcrossPartitions,
}

enum SkuName {
  Standard,
}

enum JobType {
  Cloud,
  Edge,
}

enum OutputStartMode {
  JobStartTime,
  CustomTime,
  LastOutputEventTime,
}

enum EventsOutOfOrderPolicy {
  Adjust,
  Drop,
}

enum OutputErrorPolicy {
  Stop,
  Drop,
}

enum CompatibilityLevel {
  `1.0`,
  `1.2`,
}

enum AuthenticationMode {
  Msi,
  UserToken,
  ConnectionString,
}

enum ContentStoragePolicy {
  SystemAccount,
  JobStorageAccount,
}

enum RefreshType {
  Static,
  RefreshPeriodicallyWithFull,
  RefreshPeriodicallyWithDelta,
  Blocking,
  Nonblocking,
}

enum IdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

enum QueryTestingResultStatus {
  @doc("The query testing operation was initiated.") Started,
  @doc("The query testing operation succeeded.") Success,
  @doc("The query testing operation failed due to a compiler error.")
  CompilerError,
  @doc("The query testing operation failed due to a runtime error.")
  RuntimeError,
  @doc("The query testing operation failed due to a timeout.") Timeout,
  @doc("The query testing operation failed due to an unknown error .")
  UnknownError,
}

enum SampleInputResultStatus {
  @doc("The sample input operation successfully read all the events in the range.")
  ReadAllEventsInRange,
  @doc("The sample input operation found no events in the range.")
  NoEventsFoundInRange,
  @doc("The sample input operation failed to connect to the input.")
  ErrorConnectingToInput,
}

enum TestDatasourceResultStatus {
  @doc("The test datasource operation succeeded.") TestSucceeded,
  @doc("The test datasource operation failed.") TestFailed,
}

enum ClusterSkuName {
  @doc("The default SKU.") Default,
}

enum ClusterProvisioningState {
  @doc("The cluster provisioning succeeded.") Succeeded,
  @doc("The cluster provisioning failed.") Failed,
  @doc("The cluster provisioning was canceled.") Canceled,
  @doc("The cluster provisioning was inprogress.") InProgress,
}

enum JobState {
  @doc("The job is currently in the Created state.") Created,
  @doc("The job is currently in the Starting state.") Starting,
  @doc("The job is currently in the Running state.") Running,
  @doc("The job is currently in the Stopping state.") Stopping,
  @doc("The job is currently in the Stopped state.") Stopped,
  @doc("The job is currently in the Deleting state.") Deleting,
  @doc("The job is currently in the Failed state.") Failed,
  @doc("The job is currently in the Degraded state.") Degraded,
  @doc("The job is currently in the Restarting state.") Restarting,
  @doc("The job is currently in the Scaling state.") Scaling,
}

enum UpdateMode {
  Static,
  Refreshable,
}

enum Encoding {
  UTF8,
}

enum JsonOutputSerializationFormat {
  LineSeparated,
  Array,
}

enum EventGridEventSchemaType {
  EventGridEventSchema,
  CloudEventSchema,
}

enum BlobWriteMode {
  Append,
  Once,
}

@doc("The properties that are associated with a function.")
@discriminator("type")
model FunctionProperties {
  @doc("The current entity tag for the function. This is an opaque string. You can use it to detect whether the resource has changed between requests. You can also use it in the If-Match or If-None-Match headers for write operations for optimistic concurrency.")
  @visibility("read")
  etag?: string;

  properties?: FunctionConfiguration;
}

model FunctionConfiguration {
  inputs?: FunctionInput[];

  @doc("Describes the output of a function.")
  output?: FunctionOutput;

  @doc("The physical binding of the function. For example, in the Azure Machine Learning web service’s case, this describes the endpoint.")
  binding?: FunctionBinding;
}

@doc("Describes one input parameter of a function.")
model FunctionInput {
  @doc("The (Azure Stream Analytics supported) data type of the function input parameter. A list of valid Azure Stream Analytics data types are described at https://msdn.microsoft.com/en-us/library/azure/dn835065.aspx")
  dataType?: string;

  @doc("A flag indicating if the parameter is a configuration parameter. True if this input parameter is expected to be a constant. Default is false.")
  isConfigurationParameter?: boolean;
}

@doc("Describes the output of a function.")
model FunctionOutput {
  @doc("The (Azure Stream Analytics supported) data type of the function output. A list of valid Azure Stream Analytics data types are described at https://msdn.microsoft.com/en-us/library/azure/dn835065.aspx")
  dataType?: string;
}

@doc("The physical binding of the function. For example, in the Azure Machine Learning web service’s case, this describes the endpoint.")
@discriminator("type")
model FunctionBinding {}

@doc("The base sub-resource model definition.")
model SubResource {
  @doc("Resource Id")
  @visibility("read")
  id?: string;

  @doc("Resource name")
  name?: string;

  @doc("Resource type")
  @visibility("read")
  type?: string;
}

@doc("Common error representation.")
@error
model StreamAnalyticsError {
  @doc("Error definition properties.")
  error?: ErrorError;
}

@doc("Error definition properties.")
model ErrorError {
  @doc("Error code.")
  code?: string;

  @doc("Error message.")
  message?: string;

  @doc("Error target.")
  target?: string;

  @doc("Error details.")
  details?: StreamAnalyticsErrorDetails[];
}

@doc("Common error details representation.")
model StreamAnalyticsErrorDetails {
  @doc("Error code.")
  code?: string;

  @doc("Error target.")
  target?: string;

  @doc("Error message.")
  message?: string;
}

@doc("Describes the status of the test operation along with error information, if applicable.")
model ResourceTestStatus {
  @doc("The status of the test operation.")
  @visibility("read")
  status?: string;

  @doc("Describes the error that occurred.")
  @visibility("read")
  error?: ErrorResponse;
}

@doc("Parameters used to specify the type of function to retrieve the default definition for.")
@discriminator("bindingType")
model FunctionRetrieveDefaultDefinitionParameters {}

@doc("The properties that are associated with an input.")
@discriminator("type")
model InputProperties {
  @doc("Describes how data from an input is serialized or how data is serialized when written to an output. Required on PUT (CreateOrReplace) requests.")
  serialization?: Serialization;

  @doc("Describes conditions applicable to the Input, Output, or the job overall, that warrant customer attention.")
  @visibility("read")
  diagnostics?: Diagnostics;

  @doc("The current entity tag for the input. This is an opaque string. You can use it to detect whether the resource has changed between requests. You can also use it in the If-Match or If-None-Match headers for write operations for optimistic concurrency.")
  @visibility("read")
  etag?: string;

  @doc("Describes how input data is compressed")
  compression?: Compression;

  @doc("partitionKey Describes a key in the input data which is used for partitioning the input data")
  partitionKey?: string;

  @doc("Settings which determine whether to read watermark events.")
  watermarkSettings?: InputWatermarkProperties;
}

@doc("Describes how data from an input is serialized or how data is serialized when written to an output.")
@discriminator("type")
model Serialization {}

@doc("Describes conditions applicable to the Input, Output, or the job overall, that warrant customer attention.")
model Diagnostics {
  @doc("A collection of zero or more conditions applicable to the resource, or to the job overall, that warrant customer attention.")
  @visibility("read")
  conditions?: DiagnosticCondition[];
}

@doc("Condition applicable to the resource, or to the job overall, that warrant customer attention.")
model DiagnosticCondition {
  @doc("The UTC timestamp of when the condition started. Customers should be able to find a corresponding event in the ops log around this time.")
  @visibility("read")
  since?: string;

  @doc("The opaque diagnostic code.")
  @visibility("read")
  code?: string;

  @doc("The human-readable message describing the condition in detail. Localized in the Accept-Language of the client request.")
  @visibility("read")
  message?: string;
}

@doc("Describes how input data is compressed")
model Compression {
  @doc("Indicates the type of compression that the input uses. Required on PUT (CreateOrReplace) requests.")
  type: CompressionType;
}

@doc("Settings which determine whether to read watermark events.")
model InputWatermarkProperties {
  @doc("The input watermark mode.")
  watermarkMode?: InputWatermarkMode;
}

@doc("The properties that are associated with an output.")
model OutputProperties {
  @doc("Describes the data source that output will be written to. Required on PUT (CreateOrReplace) requests.")
  datasource?: OutputDataSource;

  @doc("The time frame for filtering Stream Analytics job outputs.")
  @projectedName("json", "timeWindow")
  timeFrame?: plainTime;

  @doc("The size window to constrain a Stream Analytics output to.")
  sizeWindow?: float32;

  @doc("Describes how data from an input is serialized or how data is serialized when written to an output. Required on PUT (CreateOrReplace) requests.")
  serialization?: Serialization;

  @doc("Describes conditions applicable to the Input, Output, or the job overall, that warrant customer attention.")
  @visibility("read")
  diagnostics?: Diagnostics;

  @doc("The current entity tag for the output. This is an opaque string. You can use it to detect whether the resource has changed between requests. You can also use it in the If-Match or If-None-Match headers for write operations for optimistic concurrency.")
  @visibility("read")
  etag?: string;

  @doc("A list of the last output event times for each output partition. The index of the array corresponds to the partition number.")
  @visibility("read")
  lastOutputEventTimestamps?: LastOutputEventTimestamp[];

  @doc("Settings which determine whether to send watermarks to downstream.")
  watermarkSettings?: OutputWatermarkProperties;
}

@doc("Describes the data source that output will be written to.")
@discriminator("type")
model OutputDataSource {}

@doc("An output event timestamp.")
model LastOutputEventTimestamp {
  @doc("The last output event time.")
  lastOutputEventTime?: string;

  @doc("The time that the last update happened.")
  lastUpdateTime?: string;
}

@doc("Settings which determine whether to send watermarks to downstream.")
model OutputWatermarkProperties {
  @doc("The output watermark mode.")
  watermarkMode?: OutputWatermarkMode;

  @doc("Describes the maximal delta between the fastest and slowest partitions, so the out of order window that catches all necessary events in downstream jobs is well defined.")
  maxWatermarkDifferenceAcrossPartitions?: string;
}

@doc("The properties that are associated with a streaming job.")
model StreamingJobProperties {
  @doc("Describes the SKU of the streaming job. Required on PUT (CreateOrReplace) requests.")
  sku?: Sku;

  @doc("A GUID uniquely identifying the streaming job. This GUID is generated upon creation of the streaming job.")
  @visibility("read")
  jobId?: string;

  @doc("Describes the provisioning status of the streaming job.")
  @visibility("read")
  provisioningState?: string;

  @doc("Describes the state of the streaming job.")
  @visibility("read")
  jobState?: string;

  @doc("Describes the type of the job. Valid modes are `Cloud` and 'Edge'.")
  jobType?: JobType;

  @doc("This property should only be utilized when it is desired that the job be started immediately upon creation. Value may be JobStartTime, CustomTime, or LastOutputEventTime to indicate whether the starting point of the output event stream should start whenever the job is started, start at a custom user time stamp specified via the outputStartTime property, or start from the last event output time.")
  outputStartMode?: OutputStartMode;

  @doc("Value is either an ISO-8601 formatted time stamp that indicates the starting point of the output event stream, or null to indicate that the output event stream will start whenever the streaming job is started. This property must have a value if outputStartMode is set to CustomTime.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  outputStartTime?: utcDateTime;

  @doc("Value is either an ISO-8601 formatted timestamp indicating the last output event time of the streaming job or null indicating that output has not yet been produced. In case of multiple outputs or multiple streams, this shows the latest value in that set.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastOutputEventTime?: utcDateTime;

  @doc("Indicates the policy to apply to events that arrive out of order in the input event stream.")
  eventsOutOfOrderPolicy?: EventsOutOfOrderPolicy;

  @doc("Indicates the policy to apply to events that arrive at the output and cannot be written to the external storage due to being malformed (missing column values, column values of wrong type or size).")
  outputErrorPolicy?: OutputErrorPolicy;

  @doc("The maximum tolerable delay in seconds where out-of-order events can be adjusted to be back in order.")
  eventsOutOfOrderMaxDelayInSeconds?: int32;

  @doc("The maximum tolerable delay in seconds where events arriving late could be included.  Supported range is -1 to 1814399 (20.23:59:59 days) and -1 is used to specify wait indefinitely. If the property is absent, it is interpreted to have a value of -1.")
  eventsLateArrivalMaxDelayInSeconds?: int32;

  @doc("The data locale of the stream analytics job. Value should be the name of a supported .NET Culture from the set https://msdn.microsoft.com/en-us/library/system.globalization.culturetypes(v=vs.110).aspx. Defaults to 'en-US' if none specified.")
  dataLocale?: string;

  @doc("Controls certain runtime behaviors of the streaming job.")
  compatibilityLevel?: CompatibilityLevel;

  @doc("Value is an ISO-8601 formatted UTC timestamp indicating when the streaming job was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  @doc("A list of one or more inputs to the streaming job. The name property for each input is required when specifying this property in a PUT request. This property cannot be modify via a PATCH operation. You must use the PATCH API available for the individual input.")
  inputs?: Input[];

  @doc("Indicates the query and the number of streaming units to use for the streaming job. The name property of the transformation is required when specifying this property in a PUT request. This property cannot be modify via a PATCH operation. You must use the PATCH API available for the individual transformation.")
  transformation?: Transformation;

  @doc("A list of one or more outputs for the streaming job. The name property for each output is required when specifying this property in a PUT request. This property cannot be modify via a PATCH operation. You must use the PATCH API available for the individual output.")
  outputs?: Output[];

  @doc("A list of one or more functions for the streaming job. The name property for each function is required when specifying this property in a PUT request. This property cannot be modify via a PATCH operation. You must use the PATCH API available for the individual transformation.")
  functions?: Function[];

  @doc("The current entity tag for the streaming job. This is an opaque string. You can use it to detect whether the resource has changed between requests. You can also use it in the If-Match or If-None-Match headers for write operations for optimistic concurrency.")
  @visibility("read")
  etag?: string;

  @doc("The properties that are associated with an Azure Storage account with MSI")
  jobStorageAccount?: JobStorageAccount;

  @doc("Valid values are JobStorageAccount and SystemAccount. If set to JobStorageAccount, this requires the user to also specify jobStorageAccount property. .")
  contentStoragePolicy?: ContentStoragePolicy;

  @doc("The storage account where the custom code artifacts are located.")
  externals?: External;

  @doc("The cluster which streaming jobs will run on.")
  cluster?: ClusterInfo;
}

@doc("The properties that are associated with a SKU.")
model Sku {
  @doc("The name of the SKU. Required on PUT (CreateOrReplace) requests.")
  name?: SkuName;
}

@doc("The properties that are associated with a transformation.")
model TransformationProperties {
  @doc("Specifies the number of streaming units that the streaming job uses.")
  streamingUnits?: int32;

  @doc("Specifies the valid streaming units a streaming job can scale to.")
  validStreamingUnits?: int32[];

  @doc("Specifies the query that will be run in the streaming job. You can learn more about the Stream Analytics Query Language (SAQL) here: https://msdn.microsoft.com/library/azure/dn834998 . Required on PUT (CreateOrReplace) requests.")
  query?: string;

  @doc("The current entity tag for the transformation. This is an opaque string. You can use it to detect whether the resource has changed between requests. You can also use it in the If-Match or If-None-Match headers for write operations for optimistic concurrency.")
  @visibility("read")
  etag?: string;
}

@doc("The properties that are associated with an Azure Storage account with MSI")
model JobStorageAccount {
  ...StorageAccount;
}

@doc("The properties that are associated with an Azure Storage account")
model StorageAccount {
  @doc("The name of the Azure Storage account. Required on PUT (CreateOrReplace) requests.")
  accountName?: string;

  @doc("The account key for the Azure Storage account. Required on PUT (CreateOrReplace) requests.")
  accountKey?: string;

  @doc("Authentication Mode.")
  authenticationMode?: AuthenticationMode;
}

@doc("The storage account where the custom code artifacts are located.")
model External {
  @doc("The properties that are associated with an Azure Storage account")
  storageAccount?: StorageAccount;

  @doc("The UserCustomCode container.")
  container?: string;

  @doc("The UserCustomCode path.")
  path?: string;

  @doc("The refresh parameters for any/all updatable user defined functions present in the job config.")
  refreshConfiguration?: RefreshConfiguration;
}

@doc("The refresh parameters for any/all updatable user defined functions present in the job config.")
model RefreshConfiguration {
  @doc("The blob path pattern. Not a regular expression. It represents a pattern against which blob names will be matched to determine whether or not they should be included as input or output to the job. See https://docs.microsoft.com/en-us/rest/api/streamanalytics/stream-analytics-input or https://docs.microsoft.com/en-us/rest/api/streamanalytics/stream-analytics-output for a more detailed explanation and example.")
  pathPattern?: string;

  @doc("The date format. Wherever {date} appears in pathPattern, the value of this property is used as the date format instead.")
  dateFormat?: string;

  @doc("The time format. Wherever {time} appears in pathPattern, the value of this property is used as the time format instead.")
  timeFormat?: string;

  @doc("The refresh interval.")
  refreshInterval?: string;

  @doc("This property indicates which data refresh option to use, Blocking or Nonblocking.")
  refreshType?: RefreshType;
}

@doc("The properties associated with a Stream Analytics cluster.")
model ClusterInfo {
  @doc("The resource id of cluster.")
  id?: string;
}

@doc("Describes how identity is verified")
model Identity {
  @doc("The tenantId of the identity.")
  @visibility("read")
  tenantId?: string;

  @doc("The principalId of the identity.")
  @visibility("read")
  principalId?: string;

  @doc("The identity type.")
  type?: IdentityType;
}

@doc("Parameters supplied to the Start Streaming Job operation.")
model StartStreamingJobParameters {
  @doc("Value may be JobStartTime, CustomTime, or LastOutputEventTime to indicate whether the starting point of the output event stream should start whenever the job is started, start at a custom user time stamp specified via the outputStartTime property, or start from the last event output time.")
  outputStartMode?: OutputStartMode;

  @doc("Value is either an ISO-8601 formatted time stamp that indicates the starting point of the output event stream, or null to indicate that the output event stream will start whenever the streaming job is started. This property must have a value if outputStartMode is set to CustomTime.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  outputStartTime?: utcDateTime;
}

@doc("Parameters supplied to the Scale Streaming Job operation.")
model ScaleStreamingJobParameters {
  @doc("Specifies the number of streaming units that the streaming job will scale to.")
  streamingUnits?: int32;
}

@doc("Result of the GetQuotas operation. It contains a list of quotas for the subscription in a particular region.")
model SubscriptionQuotasListResult {
  @doc("List of quotas for the subscription in a particular region.")
  @visibility("read")
  value?: SubscriptionQuota[];
}

@doc("Describes the current quota for the subscription.")
model SubscriptionQuota {
  ...SubResource;

  @doc("Describes the properties of the quota.")
  @visibility("read")
  properties?: SubscriptionQuotaProperties;
}

@doc("Describes the properties of the quota.")
model SubscriptionQuotaProperties {
  @doc("The max permitted usage of this resource.")
  @visibility("read")
  maxCount?: int32;

  @doc("The current usage of this resource.")
  @visibility("read")
  currentCount?: int32;
}

@doc("The request object for query testing.")
model TestQuery {
  @doc("Diagnostics information related to query testing.")
  diagnostics?: TestQueryDiagnostics;

  @doc("Stream analytics job object which defines the input, output, and transformation for the query testing.")
  streamingJob: StreamingJob;
}

@doc("Diagnostics information related to query testing.")
model TestQueryDiagnostics {
  @doc("The SAS URI to the container or directory.")
  writeUri: string;

  @doc("The path to the subdirectory.")
  path?: string;
}

@doc("The result of the query testing request.")
model QueryTestingResult {
  ...StreamAnalyticsError;

  @doc("The status of the query testing request.")
  @visibility("read")
  status?: QueryTestingResultStatus;

  @doc("The SAS URL to the outputs payload.")
  @visibility("read")
  outputUri?: string;
}

@doc("The query compilation object which defines the input, output, and transformation for the query compilation.")
model CompileQuery {
  @doc("The query to compile.")
  query: string;

  @doc("The inputs for the query compilation.")
  inputs?: QueryInput[];

  @doc("The functions for the query compilation.")
  functions?: QueryFunction[];

  @doc("Describes the type of the job. Valid values are `Cloud` and 'Edge'.")
  jobType: JobType;

  @doc("The query to compile.")
  compatibilityLevel?: CompatibilityLevel;
}

@doc("An input for the query compilation.")
model QueryInput {
  @doc("The name of the input.")
  name: string;

  @doc("The type of the input, can be Stream or Reference.")
  type: string;
}

@doc("A function for the query compilation.")
model QueryFunction {
  @doc("The name of the function.")
  name: string;

  @doc("The type of the function.")
  type: string;

  @doc("The type of the function binding.")
  bindingType: string;

  @doc("The inputs for the function.")
  inputs: FunctionInput[];

  @doc("An output for the function.")
  output: FunctionOutput;
}

@doc("The result of the query compilation request.")
model QueryCompilationResult {
  @doc("Error messages produced by the compiler.")
  @visibility("read")
  errors?: QueryCompilationError[];

  @doc("Warning messages produced by the compiler.")
  @visibility("read")
  warnings?: string[];

  @doc("All input names used by the query.")
  @visibility("read")
  inputs?: string[];

  @doc("All output names used by the query.")
  @visibility("read")
  outputs?: string[];

  @doc("All function names used by the query.")
  @visibility("read")
  functions?: string[];
}

@doc("An error produced by the compiler.")
model QueryCompilationError {
  @doc("The content of the error message.")
  @visibility("read")
  message?: string;

  @doc("Describes the error location in the original query. Not set if isGlobal is true.")
  @visibility("read")
  startLine?: int32;

  @doc("Describes the error location in the original query. Not set if isGlobal is true.")
  @visibility("read")
  startColumn?: int32;

  @doc("Describes the error location in the original query. Not set if isGlobal is true.")
  @visibility("read")
  endLine?: int32;

  @doc("Describes the error location in the original query. Not set if isGlobal is true.")
  @visibility("read")
  endColumn?: int32;

  @doc("Whether the error is not for a specific part but for the entire query.")
  @visibility("read")
  isGlobal?: boolean;
}

@doc("The stream analytics input to sample.")
model SampleInput {
  @doc("The stream analytics input to sample.")
  input?: Input;

  @doc("Defaults to the default ASA job compatibility level. Today it is 1.2")
  compatibilityLevel?: string;

  @doc("The SAS URI of the storage blob for service to write the sampled events to. If this parameter is not provided, service will write events to he system account and share a temporary SAS URI to it.")
  eventsUri?: string;

  @doc("Defaults to en-US.")
  dataLocale?: string;
}

@doc("The result of the sample input request.")
model SampleInputResult {
  ...StreamAnalyticsError;

  @doc("The status of the sample input request.")
  @visibility("read")
  status?: SampleInputResultStatus;

  @doc("Diagnostics messages. E.g. message indicating some partitions from the input have no data.")
  @visibility("read")
  diagnostics?: string[];

  @doc("A SAS URL to download the sampled input data.")
  @visibility("read")
  eventsDownloadUrl?: string;

  @doc("The timestamp for the last event in the data. It is in DateTime format.")
  @visibility("read")
  lastArrivalTime?: string;
}

@doc("A stream analytics input.")
model TestInput {
  @doc("The stream analytics input to test.")
  input: Input;
}

@doc("The result of the test input or output request.")
model TestDatasourceResult {
  ...StreamAnalyticsError;

  @doc("The status of the sample output request.")
  @visibility("read")
  status?: TestDatasourceResultStatus;
}

@doc("A stream analytics output.")
model TestOutput {
  @doc("The stream analytics output to test.")
  output: Output;
}

@doc("The SKU of the cluster. This determines the size/capacity of the cluster. Required on PUT (CreateOrUpdate) requests.")
model ClusterSku {
  @doc("Specifies the SKU name of the cluster. Required on PUT (CreateOrUpdate) requests.")
  name?: ClusterSkuName;

  @doc("Denotes the number of streaming units the cluster can support. Valid values for this property are multiples of 36 with a minimum value of 36 and maximum value of 216. Required on PUT (CreateOrUpdate) requests.")
  @maxValue(216)
  @minValue(36)
  capacity?: int32;
}

@doc("The properties associated with a Stream Analytics cluster.")
model ClusterProperties {
  @doc("The date this cluster was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  @doc("Unique identifier for the cluster.")
  @visibility("read")
  clusterId?: string;

  @doc("The status of the cluster provisioning. The three terminal states are: Succeeded, Failed and Canceled")
  @visibility("read")
  provisioningState?: ClusterProvisioningState;

  @doc("Represents the number of streaming units currently being used on the cluster.")
  @visibility("read")
  capacityAllocated?: int32;

  @doc("Represents the sum of the SUs of all streaming jobs associated with the cluster. If all of the jobs were running, this would be the capacity allocated.")
  @visibility("read")
  capacityAssigned?: int32;
}

@doc("A list of streaming jobs. Populated by a List operation.")
model ClusterJobListResult is Azure.Core.Page<ClusterJob>;

@doc("A streaming job.")
model ClusterJob {
  @doc("Resource ID of the streaming job.")
  @visibility("read")
  id?: string;

  @doc("The number of streaming units that are used by the streaming job.")
  @visibility("read")
  streamingUnits?: int32;

  @doc("The current execution state of the streaming job.")
  @visibility("read")
  jobState?: JobState;
}

@doc("The properties associated with a private endpoint.")
model PrivateEndpointProperties {
  @doc("The date when this private endpoint was created.")
  @visibility("read")
  createdDate?: string;

  @doc("A list of connections to the remote resource. Immutable after it is set.")
  manualPrivateLinkServiceConnections?: PrivateLinkServiceConnection[];
}

@doc("A grouping of information about the connection to the remote resource.")
model PrivateLinkServiceConnection {
  @doc("Bag of properties defining a privatelinkServiceConnection.")
  properties?: PrivateLinkServiceConnectionProperties;
}

@doc("Bag of properties defining a privatelinkServiceConnection.")
model PrivateLinkServiceConnectionProperties {
  @doc("The resource id of the private link service. Required on PUT (CreateOrUpdate) requests.")
  privateLinkServiceId?: string;

  @doc("The ID(s) of the group(s) obtained from the remote resource that this private endpoint should connect to. Required on PUT (CreateOrUpdate) requests.")
  groupIds?: string[];

  @doc("A message passed to the owner of the remote resource with this connection request. Restricted to 140 chars.")
  @visibility("read")
  requestMessage?: string;

  @doc("A collection of read-only information about the state of the connection to the private remote resource.")
  privateLinkServiceConnectionState?: PrivateLinkConnectionState;
}

@doc("A collection of read-only information about the state of the connection to the private remote resource.")
model PrivateLinkConnectionState {
  @doc("Indicates whether the connection has been Approved/Rejected/Removed by the owner of the remote resource/service.")
  @visibility("read")
  status?: string;

  @doc("The reason for approval/rejection of the connection.")
  @visibility("read")
  description?: string;

  @doc("A message indicating if changes on the service provider require any updates on the consumer.")
  @visibility("read")
  actionsRequired?: string;
}

@doc("The properties that are associated with a scalar function.")
model ScalarFunctionProperties extends FunctionProperties {
  @doc("Indicates the type of function.")
  type: "Scalar";
}

@doc("The binding to an Azure Machine Learning Studio.")
model AzureMachineLearningStudioFunctionBinding extends FunctionBinding {
  @doc("The binding properties associated with an Azure Machine learning Studio.")
  properties?: AzureMachineLearningStudioFunctionBindingProperties;

  @doc("Indicates the function binding type.")
  type: "Microsoft.MachineLearning/WebService";
}

@doc("The binding properties associated with an Azure Machine learning Studio.")
model AzureMachineLearningStudioFunctionBindingProperties {
  @doc("The Request-Response execute endpoint of the Azure Machine Learning Studio. Find out more here: https://docs.microsoft.com/en-us/azure/machine-learning/machine-learning-consume-web-services#request-response-service-rrs")
  endpoint?: string;

  @doc("The API key used to authenticate with Request-Response endpoint.")
  apiKey?: string;

  @doc("The inputs for the Azure Machine Learning Studio endpoint.")
  inputs?: AzureMachineLearningStudioInputs;

  @doc("A list of outputs from the Azure Machine Learning Studio endpoint execution.")
  outputs?: AzureMachineLearningStudioOutputColumn[];

  @doc("Number between 1 and 10000 describing maximum number of rows for every Azure ML RRS execute request. Default is 1000.")
  batchSize?: int32;
}

@doc("The inputs for the Azure Machine Learning Studio endpoint.")
model AzureMachineLearningStudioInputs {
  @doc("The name of the input. This is the name provided while authoring the endpoint.")
  name?: string;

  @doc("A list of input columns for the Azure Machine Learning Studio endpoint.")
  columnNames?: AzureMachineLearningStudioInputColumn[];
}

@doc("Describes an input column for the Azure Machine Learning Studio endpoint.")
model AzureMachineLearningStudioInputColumn {
  @doc("The name of the input column.")
  name?: string;

  @doc("The (Azure Machine Learning supported) data type of the input column. A list of valid  Azure Machine Learning data types are described at https://msdn.microsoft.com/en-us/library/azure/dn905923.aspx .")
  dataType?: string;

  @doc("The zero based index of the function parameter this input maps to.")
  mapTo?: int32;
}

@doc("Describes an output column for the Azure Machine Learning Studio endpoint.")
model AzureMachineLearningStudioOutputColumn {
  @doc("The name of the output column.")
  name?: string;

  @doc("The (Azure Machine Learning supported) data type of the output column. A list of valid  Azure Machine Learning data types are described at https://msdn.microsoft.com/en-us/library/azure/dn905923.aspx .")
  dataType?: string;
}

@doc("The binding to a JavaScript function.")
model JavaScriptFunctionBinding extends FunctionBinding {
  @doc("The binding properties associated with a JavaScript function.")
  properties?: JavaScriptFunctionBindingProperties;

  @doc("Indicates the function binding type.")
  type: "Microsoft.StreamAnalytics/JavascriptUdf";
}

@doc("The binding properties associated with a JavaScript function.")
model JavaScriptFunctionBindingProperties {
  @doc("The JavaScript code containing a single function definition. For example: 'function (x, y) { return x + y; }'")
  script?: string;
}

@doc("The binding to a CSharp function.")
model CSharpFunctionBinding extends FunctionBinding {
  @doc("The binding properties associated with a CSharp function.")
  properties?: CSharpFunctionBindingProperties;

  @doc("Indicates the function binding type.")
  type: "Microsoft.StreamAnalytics/CLRUdf";
}

@doc("The binding properties associated with a CSharp function.")
model CSharpFunctionBindingProperties {
  @doc("The Csharp code containing a single function definition.")
  dllPath?: string;

  @doc("The Csharp code containing a single function definition.")
  class?: string;

  @doc("The Csharp code containing a single function definition.")
  method?: string;

  @doc("Refresh modes for Stream Analytics functions.")
  updateMode?: UpdateMode;
}

@doc("The parameters needed to retrieve the default function definition for an Azure Machine Learning Studio function.")
model AzureMachineLearningStudioFunctionRetrieveDefaultDefinitionParameters
  extends FunctionRetrieveDefaultDefinitionParameters {
  @doc("The binding retrieval properties associated with an Azure Machine learning Studio.")
  bindingRetrievalProperties?: AzureMachineLearningStudioFunctionBindingRetrievalProperties;

  @doc("Indicates the function binding type.")
  bindingType: "Microsoft.MachineLearning/WebService";
}

@doc("The binding retrieval properties associated with an Azure Machine learning Studio.")
model AzureMachineLearningStudioFunctionBindingRetrievalProperties {
  @doc("The Request-Response execute endpoint of the Azure Machine Learning Studio. Find out more here: https://docs.microsoft.com/en-us/azure/machine-learning/machine-learning-consume-web-services#request-response-service-rrs")
  executeEndpoint?: string;

  @doc("The function type.")
  udfType?: "Scalar";
}

@doc("The parameters needed to retrieve the default function definition for an Azure Machine Learning web service function.")
model AzureMachineLearningServiceFunctionRetrieveDefaultDefinitionParameters
  extends FunctionRetrieveDefaultDefinitionParameters {
  @doc("The binding retrieval properties associated with an Azure Machine learning web service.")
  bindingRetrievalProperties?: AzureMachineLearningServiceFunctionBindingRetrievalProperties;

  @doc("Indicates the function binding type.")
  bindingType: "Microsoft.MachineLearningServices";
}

@doc("The binding retrieval properties associated with an Azure Machine learning web service.")
model AzureMachineLearningServiceFunctionBindingRetrievalProperties {
  @doc("The Request-Response execute endpoint of the Azure Machine Learning web service.")
  executeEndpoint?: string;

  @doc("The function type.")
  udfType?: "Scalar";
}

@doc("The parameters needed to retrieve the default function definition for a JavaScript function.")
model JavaScriptFunctionRetrieveDefaultDefinitionParameters
  extends FunctionRetrieveDefaultDefinitionParameters {
  @doc("The binding retrieval properties associated with a JavaScript function.")
  bindingRetrievalProperties?: JavaScriptFunctionBindingRetrievalProperties;

  @doc("Indicates the function binding type.")
  bindingType: "Microsoft.StreamAnalytics/JavascriptUdf";
}

@doc("The binding retrieval properties associated with a JavaScript function.")
model JavaScriptFunctionBindingRetrievalProperties {
  @doc("The JavaScript code containing a single function definition. For example: 'function (x, y) { return x + y; }'.")
  script?: string;

  @doc("The function type.")
  udfType?: "Scalar";
}

@doc("The parameters needed to retrieve the default function definition for a CSharp function.")
model CSharpFunctionRetrieveDefaultDefinitionParameters
  extends FunctionRetrieveDefaultDefinitionParameters {
  @doc("The binding retrieval properties associated with a CSharp function.")
  bindingRetrievalProperties?: CSharpFunctionBindingRetrievalProperties;

  @doc("Indicates the function binding type.")
  bindingType: "Microsoft.StreamAnalytics/CLRUdf";
}

@doc("The binding retrieval properties associated with a CSharp function.")
model CSharpFunctionBindingRetrievalProperties {
  @doc("The CSharp code containing a single function definition.")
  script?: string;

  @doc("The function type.")
  udfType?: "Scalar";
}

@doc("The binding to an Azure Machine Learning web service.")
model AzureMachineLearningServiceFunctionBinding extends FunctionBinding {
  @doc("The binding properties associated with an Azure Machine learning web service.")
  properties?: AzureMachineLearningServiceFunctionBindingProperties;

  @doc("Indicates the function binding type.")
  type: "Microsoft.MachineLearningServices";
}

@doc("The binding properties associated with an Azure Machine learning web service.")
model AzureMachineLearningServiceFunctionBindingProperties {
  @doc("The Request-Response execute endpoint of the Azure Machine Learning web service.")
  endpoint?: string;

  @doc("The API key used to authenticate with Request-Response endpoint.")
  apiKey?: string;

  @doc("The inputs for the Azure Machine Learning web service endpoint.")
  inputs?: AzureMachineLearningServiceInputColumn[];

  @doc("A list of outputs from the Azure Machine Learning web service endpoint execution.")
  outputs?: AzureMachineLearningServiceOutputColumn[];

  @doc("Number between 1 and 10000 describing maximum number of rows for every Azure ML RRS execute request. Default is 1000.")
  batchSize?: int32;

  @doc("The number of parallel requests that will be sent per partition of your job to the machine learning service. Default is 1.")
  numberOfParallelRequests?: int32;

  @doc("Label for the input request object.")
  inputRequestName?: string;

  @doc("Label for the output request object.")
  outputResponseName?: string;
}

@doc("Describes an input column for the Azure Machine Learning web service endpoint.")
model AzureMachineLearningServiceInputColumn {
  @doc("The name of the input column.")
  name?: string;

  @doc("The (Azure Machine Learning supported) data type of the input column.")
  dataType?: string;

  @doc("The zero based index of the function parameter this input maps to.")
  mapTo?: int32;
}

@doc("Describes an output column for the Azure Machine Learning web service endpoint.")
model AzureMachineLearningServiceOutputColumn {
  @doc("The name of the output column.")
  name?: string;

  @doc("The (Azure Machine Learning supported) data type of the output column.")
  dataType?: string;

  @doc("The zero based index of the function parameter this input maps to.")
  mapTo?: int32;
}

@doc("The inputs for the Azure Machine Learning web service endpoint.")
model AzureMachineLearningServiceInputs {
  @doc("The name of the input. This is the name provided while authoring the endpoint.")
  name?: string;

  @doc("A list of input columns for the Azure Machine Learning web service endpoint.")
  columnNames?: AzureMachineLearningServiceInputColumn[];
}

@doc("The properties that are associated with an aggregate function.")
model AggregateFunctionProperties extends FunctionProperties {
  @doc("Indicates the type of function.")
  type: "Aggregate";
}

@doc("The properties that are associated with an input containing stream data.")
model StreamInputProperties extends InputProperties {
  @doc("Describes an input data source that contains stream data. Required on PUT (CreateOrReplace) requests.")
  datasource?: StreamInputDataSource;

  @doc("Indicates whether the input is a source of reference data or stream data. Required on PUT (CreateOrReplace) requests.")
  type: "Stream";
}

@doc("Describes an input data source that contains stream data.")
@discriminator("type")
model StreamInputDataSource {}

@doc("The properties that are associated with an input containing reference data.")
model ReferenceInputProperties extends InputProperties {
  @doc("Describes an input data source that contains reference data. Required on PUT (CreateOrReplace) requests.")
  datasource?: ReferenceInputDataSource;

  @doc("Indicates whether the input is a source of reference data or stream data. Required on PUT (CreateOrReplace) requests.")
  type: "Reference";
}

@doc("Describes an input data source that contains reference data.")
@discriminator("type")
model ReferenceInputDataSource {}

@doc("Describes a blob input data source that contains stream data.")
model BlobStreamInputDataSource extends StreamInputDataSource {
  @doc("The properties that are associated with a blob input containing stream data. Required on PUT (CreateOrReplace) requests.")
  properties?: BlobStreamInputDataSourceProperties;

  @doc("Indicates the type of input data source containing stream data. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.Storage/Blob";
}

@doc("The properties that are associated with a blob input containing stream data.")
model BlobStreamInputDataSourceProperties {
  ...BlobDataSourceProperties;

  @doc("The partition count of the blob input data source. Range 1 - 1024.")
  sourcePartitionCount?: int32;
}

@doc("The properties that are associated with a blob data source.")
model BlobDataSourceProperties {
  @doc("A list of one or more Azure Storage accounts. Required on PUT (CreateOrReplace) requests.")
  storageAccounts?: StorageAccount[];

  @doc("The name of a container within the associated Storage account. This container contains either the blob(s) to be read from or written to. Required on PUT (CreateOrReplace) requests.")
  container?: string;

  @doc("The blob path pattern. Not a regular expression. It represents a pattern against which blob names will be matched to determine whether or not they should be included as input or output to the job. See https://docs.microsoft.com/en-us/rest/api/streamanalytics/stream-analytics-input or https://docs.microsoft.com/en-us/rest/api/streamanalytics/stream-analytics-output for a more detailed explanation and example.")
  pathPattern?: string;

  @doc("The date format. Wherever {date} appears in pathPattern, the value of this property is used as the date format instead.")
  dateFormat?: string;

  @doc("The time format. Wherever {time} appears in pathPattern, the value of this property is used as the time format instead.")
  timeFormat?: string;

  @doc("Authentication Mode.")
  authenticationMode?: AuthenticationMode;
}

@doc("Describes an Event Hub input data source that contains stream data.")
model EventHubStreamInputDataSource extends StreamInputDataSource {
  @doc("The properties that are associated with an Event Hub input containing stream data. Required on PUT (CreateOrReplace) requests.")
  properties?: EventHubStreamInputDataSourceProperties;

  @doc("Indicates the type of input data source containing stream data. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.ServiceBus/EventHub";
}

@doc("The properties that are associated with a Event Hub input containing stream data.")
model EventHubStreamInputDataSourceProperties {
  ...EventHubDataSourceProperties;

  @doc("The name of an Event Hub Consumer Group that should be used to read events from the Event Hub. Specifying distinct consumer group names for multiple inputs allows each of those inputs to receive the same events from the Event Hub. If not specified, the input uses the Event Hub’s default consumer group.")
  consumerGroupName?: string;

  @doc("The number of messages that the message receiver can simultaneously request.")
  prefetchCount?: int32;
}

@doc("The common properties that are associated with Event Hub data sources.")
model EventHubDataSourceProperties {
  ...ServiceBusDataSourceProperties;

  @doc("The name of the Event Hub. Required on PUT (CreateOrReplace) requests.")
  eventHubName?: string;

  @doc("The partition count of the event hub data source. Range 1 - 256.")
  partitionCount?: int32;
}

@doc("The common properties that are associated with Service Bus data sources (Queues, Topics, Event Hubs, etc.).")
model ServiceBusDataSourceProperties {
  @doc("The namespace that is associated with the desired Event Hub, Service Bus Queue, Service Bus Topic, etc. Required on PUT (CreateOrReplace) requests.")
  serviceBusNamespace?: string;

  @doc("The shared access policy name for the Event Hub, Service Bus Queue, Service Bus Topic, etc. Required on PUT (CreateOrReplace) requests.")
  sharedAccessPolicyName?: string;

  @doc("The shared access policy key for the specified shared access policy. Required on PUT (CreateOrReplace) requests.")
  sharedAccessPolicyKey?: string;

  @doc("Authentication Mode.")
  authenticationMode?: AuthenticationMode;
}

@doc("Describes an Event Hub input data source that contains stream data.")
model EventHubV2StreamInputDataSource extends StreamInputDataSource {
  @doc("The properties that are associated with an Event Hub input containing stream data. Required on PUT (CreateOrReplace) requests.")
  properties?: EventHubStreamInputDataSourceProperties;

  @doc("Indicates the type of input data source containing stream data. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.EventHub/EventHub";
}

@doc("Describes an IoT Hub input data source that contains stream data.")
model IoTHubStreamInputDataSource extends StreamInputDataSource {
  @doc("The properties that are associated with an IoT Hub input containing stream data. Required on PUT (CreateOrReplace) requests.")
  properties?: IoTHubStreamInputDataSourceProperties;

  @doc("Indicates the type of input data source containing stream data. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.Devices/IotHubs";
}

@doc("The properties that are associated with a IoT Hub input containing stream data.")
model IoTHubStreamInputDataSourceProperties {
  @doc("The name or the URI of the IoT Hub. Required on PUT (CreateOrReplace) requests.")
  iotHubNamespace?: string;

  @doc("The shared access policy name for the IoT Hub. This policy must contain at least the Service connect permission. Required on PUT (CreateOrReplace) requests.")
  sharedAccessPolicyName?: string;

  @doc("The shared access policy key for the specified shared access policy. Required on PUT (CreateOrReplace) requests.")
  sharedAccessPolicyKey?: string;

  @doc("The name of an IoT Hub Consumer Group that should be used to read events from the IoT Hub. If not specified, the input uses the Iot Hub’s default consumer group.")
  consumerGroupName?: string;

  @doc("The IoT Hub endpoint to connect to (ie. messages/events, messages/operationsMonitoringEvents, etc.).")
  endpoint?: string;
}

@doc("Describes a raw input data source that contains stream data. This data source type is only applicable/usable when using the query testing API. You cannot create a job with this data source type or add an input of this data source type to an existing job.")
model RawStreamInputDataSource extends StreamInputDataSource {
  @doc("The properties that are associated with a raw input. Required on PUT (CreateOrReplace) requests.")
  properties?: RawInputDatasourceProperties;

  @doc("Indicates the type of input data source containing stream data. Required on PUT (CreateOrReplace) requests.")
  type: "Raw";
}

@doc("The properties that are associated with a raw input.")
model RawInputDatasourceProperties {
  @doc("The JSON serialized content of the input data. Either payload or payloadUri must be set, but not both. ")
  payload?: string;

  @doc("The SAS URL to a blob containing the JSON serialized content of the input data. Either payload or payloadUri must be set, but not both.")
  payloadUri?: string;
}

@doc("Describes a blob input data source that contains reference data.")
model BlobReferenceInputDataSource extends ReferenceInputDataSource {
  @doc("The properties that are associated with a blob input containing reference data. Required on PUT (CreateOrReplace) requests.")
  properties?: BlobReferenceInputDataSourceProperties;

  @doc("Indicates the type of input data source containing reference data. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.Storage/Blob";
}

@doc("The properties that are associated with a blob input containing reference data.")
model BlobReferenceInputDataSourceProperties {
  ...BlobDataSourceProperties;

  @doc("The name of the blob input.")
  blobName?: string;

  @doc("The path pattern of the delta snapshot.")
  deltaPathPattern?: string;

  @doc("The partition count of the blob input data source. Range 1 - 256.")
  sourcePartitionCount?: int32;

  @doc("The refresh interval of the blob input data source.")
  @projectedName("json", "fullSnapshotRefreshRate")
  fullSnapshotRefreshInterval?: plainTime;

  @doc("The interval that the user generates a delta snapshot of this reference blob input data source.")
  @projectedName("json", "deltaSnapshotRefreshRate")
  deltaSnapshotRefreshInterval?: plainTime;
}

@doc("Describes a raw input data source that contains reference data. This data source type is only applicable/usable when using the query testing API. You cannot create a job with this data source type or add an input of this data source type to an existing job.")
model RawReferenceInputDataSource extends ReferenceInputDataSource {
  @doc("The properties that are associated with a raw input containing reference data. Required on PUT (CreateOrReplace) requests.")
  properties?: RawInputDatasourceProperties;

  @doc("Indicates the type of input data source containing reference data. Required on PUT (CreateOrReplace) requests.")
  type: "Raw";
}

@doc("Describes how data from an input is serialized or how data is serialized when written to an output in Parquet format.")
model ParquetSerialization extends Serialization {
  @doc("The properties that are associated with the Parquet serialization type. Required on PUT (CreateOrReplace) requests.")
  properties?: Record<unknown>;

  @doc("Indicates the type of serialization that the input or output uses. Required on PUT (CreateOrReplace) requests.")
  type: "Parquet";
}

@doc("Describes how data from an input is serialized or how data is serialized when written to an output in custom format.")
model CustomClrSerialization extends Serialization {
  @doc("The properties that are associated with the CustomClr serialization type. Required on PUT (CreateOrReplace) requests.")
  properties?: CustomClrSerializationProperties;

  @doc("Indicates the type of serialization that the input or output uses. Required on PUT (CreateOrReplace) requests.")
  type: "CustomClr";
}

@doc("The properties that are associated with the CustomClr serialization type.")
model CustomClrSerializationProperties {
  @doc("The serialization library path.")
  serializationDllPath?: string;

  @doc("The serialization class name.")
  serializationClassName?: string;
}

@doc("Describes how data from an input is serialized or how data is serialized when written to an output in CSV format.")
model CsvSerialization extends Serialization {
  @doc("The properties that are associated with the CSV serialization type. Required on PUT (CreateOrReplace) requests.")
  properties?: CsvSerializationProperties;

  @doc("Indicates the type of serialization that the input or output uses. Required on PUT (CreateOrReplace) requests.")
  type: "Csv";
}

@doc("The properties that are associated with the CSV serialization type.")
model CsvSerializationProperties {
  @doc("Specifies the delimiter that will be used to separate comma-separated value (CSV) records. See https://docs.microsoft.com/en-us/rest/api/streamanalytics/stream-analytics-input or https://docs.microsoft.com/en-us/rest/api/streamanalytics/stream-analytics-output for a list of supported values. Required on PUT (CreateOrReplace) requests.")
  fieldDelimiter?: string;

  @doc("Specifies the encoding of the incoming data in the case of input and the encoding of outgoing data in the case of output. Required on PUT (CreateOrReplace) requests.")
  encoding?: Encoding;
}

@doc("Describes how data from an input is serialized or how data is serialized when written to an output in JSON format.")
model JsonSerialization extends Serialization {
  @doc("The properties that are associated with the JSON serialization type. Required on PUT (CreateOrReplace) requests.")
  properties?: JsonSerializationProperties;

  @doc("Indicates the type of serialization that the input or output uses. Required on PUT (CreateOrReplace) requests.")
  type: "Json";
}

@doc("The properties that are associated with the JSON serialization type.")
model JsonSerializationProperties {
  @doc("Specifies the encoding of the incoming data in the case of input and the encoding of outgoing data in the case of output. Required on PUT (CreateOrReplace) requests.")
  encoding?: Encoding;

  @doc("This property only applies to JSON serialization of outputs only. It is not applicable to inputs. This property specifies the format of the JSON the output will be written in. The currently supported values are 'lineSeparated' indicating the output will be formatted by having each JSON object separated by a new line and 'array' indicating the output will be formatted as an array of JSON objects. Default value is 'lineSeparated' if left null.")
  format?: JsonOutputSerializationFormat;
}

@doc("Describes how data from an input is serialized or how data is serialized when written to an output in Avro format.")
model AvroSerialization extends Serialization {
  @doc("The properties that are associated with the Avro serialization type. Required on PUT (CreateOrReplace) requests.")
  properties?: Record<unknown>;

  @doc("Indicates the type of serialization that the input or output uses. Required on PUT (CreateOrReplace) requests.")
  type: "Avro";
}

@doc("Describes an Azure SQL database reference input data source.")
model AzureSqlReferenceInputDataSource extends ReferenceInputDataSource {
  @doc("The properties that are associated with SQL DB input containing reference data. Required on PUT (CreateOrReplace) requests.")
  properties?: AzureSqlReferenceInputDataSourceProperties;

  @doc("Indicates the type of input data source containing reference data. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.Sql/Server/Database";
}

@doc("The properties that are associated with SQL DB input containing reference data. Required on PUT (CreateOrReplace) requests.")
model AzureSqlReferenceInputDataSourceProperties {
  @doc("This element is associated with the datasource element. This is the name of the server that contains the database that will be written to.")
  server?: string;

  @doc("This element is associated with the datasource element. This is the name of the database that output will be written to.")
  database?: string;

  @doc("This element is associated with the datasource element. This is the user name that will be used to connect to the SQL Database instance.")
  user?: string;

  @doc("This element is associated with the datasource element. This is the password that will be used to connect to the SQL Database instance.")
  password?: string;

  @doc("Indicates the type of data refresh option.")
  refreshType?: RefreshType;

  @doc("This element is associated with the datasource element. This indicates how frequently the data will be fetched from the database. It is of DateTime format.")
  @projectedName("json", "refreshRate")
  refreshInterval?: plainTime;

  @doc("This element is associated with the datasource element. This query is used to fetch data from the sql database.")
  fullSnapshotQuery?: string;

  @doc("This element is associated with the datasource element. This query is used to fetch incremental changes from the SQL database. To use this option, we recommend using temporal tables in Azure SQL Database.")
  deltaSnapshotQuery?: string;

  @doc("Authentication Mode.")
  authenticationMode?: AuthenticationMode;
}

@doc("Describes a blob input data source that contains stream data.")
model GatewayMessageBusStreamInputDataSource extends StreamInputDataSource {
  @doc("The properties that are associated with a gateway message bus input containing stream data.")
  properties?: GatewayMessageBusStreamInputDataSourceProperties;

  @doc("Indicates the type of input data source containing stream data. Required on PUT (CreateOrReplace) requests.")
  type: "GatewayMessageBus";
}

@doc("The properties that are associated with a gateway message bus input containing stream data.")
model GatewayMessageBusStreamInputDataSourceProperties {
  ...GatewayMessageBusSourceProperties;
}

@doc("The properties that are associated with a gateway message bus datasource.")
model GatewayMessageBusSourceProperties {
  @doc("The name of the Service Bus topic.")
  topic?: string;
}

@doc("Describes an event grid input data source that contains stream data.")
model EventGridStreamInputDataSource extends StreamInputDataSource {
  @doc("The properties that are associated with an event grid input containing stream data.")
  properties?: EventGridStreamInputDataSourceProperties;

  @doc("Indicates the type of input data source containing stream data. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.EventGrid/EventSubscriptions";
}

@doc("The properties that are associated with an event grid input containing stream data.")
model EventGridStreamInputDataSourceProperties {
  @doc("Subscribers for the Event Grid. Currently only EventHub Subscriber is supported.")
  subscriber?: EventHubV2StreamInputDataSource;

  @doc("Indicates the Event Grid schema type.")
  schema?: EventGridEventSchemaType;

  @doc("A list of one or more Azure Storage accounts. Required on PUT (CreateOrReplace) requests.")
  storageAccounts?: StorageAccount[];

  @doc("List of Event Types that are supported by the Event Grid adapter.")
  eventTypes?: string[];
}

@doc("Describes a raw output data source. This data source type is only applicable/usable when using the query testing API. You cannot create a job with this data source type or add an output of this data source type to an existing job.")
model RawOutputDatasource extends OutputDataSource {
  @doc("The properties that are associated with a raw output. Required on PUT (CreateOrReplace) requests.")
  properties?: RawOutputDatasourceProperties;

  @doc("Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.")
  type: "Raw";
}

@doc("The properties that are associated with a raw output.")
model RawOutputDatasourceProperties {
  @doc("The SAS URL to a blob where the output should be written. If this property is not set, output data will be written into a temporary storage, and a SAS URL to that temporary storage will be included in the result.")
  payloadUri?: string;
}

@doc("Describes a blob output data source.")
model BlobOutputDataSource extends OutputDataSource {
  @doc("The properties that are associated with a blob output. Required on PUT (CreateOrReplace) requests.")
  properties?: BlobOutputDataSourceProperties;

  @doc("Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.Storage/Blob";
}

@doc("The properties that are associated with a blob output.")
model BlobOutputDataSourceProperties {
  ...BlobDataSourceProperties;

  @doc("Blob path prefix.")
  blobPathPrefix?: string;

  @doc("Blob write mode.")
  blobWriteMode?: BlobWriteMode;
}

@doc("Describes an Azure Table output data source.")
model AzureTableOutputDataSource extends OutputDataSource {
  @doc("The properties that are associated with an Azure Table output. Required on PUT (CreateOrReplace) requests.")
  properties?: AzureTableOutputDataSourceProperties;

  @doc("Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.Storage/Table";
}

@doc("The properties that are associated with an Azure Table output.")
model AzureTableOutputDataSourceProperties {
  @doc("The name of the Azure Storage account. Required on PUT (CreateOrReplace) requests.")
  accountName?: string;

  @doc("The account key for the Azure Storage account. Required on PUT (CreateOrReplace) requests.")
  accountKey?: string;

  @doc("The name of the Azure Table. Required on PUT (CreateOrReplace) requests.")
  table?: string;

  @doc("This element indicates the name of a column from the SELECT statement in the query that will be used as the partition key for the Azure Table. Required on PUT (CreateOrReplace) requests.")
  partitionKey?: string;

  @doc("This element indicates the name of a column from the SELECT statement in the query that will be used as the row key for the Azure Table. Required on PUT (CreateOrReplace) requests.")
  rowKey?: string;

  @doc("If specified, each item in the array is the name of a column to remove (if present) from output event entities.")
  columnsToRemove?: string[];

  @doc("The number of rows to write to the Azure Table at a time.")
  batchSize?: int32;
}

@doc("Describes an Event Hub output data source.")
model EventHubOutputDataSource extends OutputDataSource {
  @doc("The properties that are associated with an Event Hub output. Required on PUT (CreateOrReplace) requests.")
  properties?: EventHubOutputDataSourceProperties;

  @doc("Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.ServiceBus/EventHub";
}

@doc("The properties that are associated with an Event Hub output.")
model EventHubOutputDataSourceProperties {
  ...EventHubDataSourceProperties;

  @doc("The key/column that is used to determine to which partition to send event data.")
  partitionKey?: string;

  @doc("The properties associated with this Event Hub output.")
  propertyColumns?: string[];
}

@doc("Describes an Event Hub output data source.")
model EventHubV2OutputDataSource extends OutputDataSource {
  @doc("The properties that are associated with an Event Hub output. Required on PUT (CreateOrReplace) requests.")
  properties?: EventHubOutputDataSourceProperties;

  @doc("Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.EventHub/EventHub";
}

@doc("Describes an Azure SQL database output data source.")
model AzureSqlDatabaseOutputDataSource extends OutputDataSource {
  @doc("The properties that are associated with an Azure SQL database output. Required on PUT (CreateOrReplace) requests.")
  properties?: AzureSqlDatabaseOutputDataSourceProperties;

  @doc("Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.Sql/Server/Database";
}

@doc("The properties that are associated with an Azure SQL database output.")
model AzureSqlDatabaseOutputDataSourceProperties {
  ...AzureSqlDatabaseDataSourceProperties;
}

@doc("The properties that are associated with an Azure SQL database data source.")
model AzureSqlDatabaseDataSourceProperties {
  @doc("The name of the SQL server containing the Azure SQL database. Required on PUT (CreateOrReplace) requests.")
  server?: string;

  @doc("The name of the Azure SQL database. Required on PUT (CreateOrReplace) requests.")
  database?: string;

  @doc("The user name that will be used to connect to the Azure SQL database. Required on PUT (CreateOrReplace) requests.")
  user?: string;

  @doc("The password that will be used to connect to the Azure SQL database. Required on PUT (CreateOrReplace) requests.")
  password?: string;

  @doc("The name of the table in the Azure SQL database. Required on PUT (CreateOrReplace) requests.")
  table?: string;

  @doc("Max Batch count for write to Sql database, the default value is 10,000. Optional on PUT requests.")
  maxBatchCount?: int32;

  @doc("Max Writer count, currently only 1(single writer) and 0(based on query partition) are available. Optional on PUT requests.")
  maxWriterCount?: int32;

  @doc("Authentication Mode.")
  authenticationMode?: AuthenticationMode;
}

@doc("Describes an Azure Synapse output data source.")
model AzureSynapseOutputDataSource extends OutputDataSource {
  @doc("The properties that are associated with an Azure Synapse output. Required on PUT (CreateOrReplace) requests.")
  properties?: AzureSynapseOutputDataSourceProperties;

  @doc("Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.Sql/Server/DataWarehouse";
}

@doc("The properties that are associated with an Azure Synapse output.")
model AzureSynapseOutputDataSourceProperties {
  ...AzureSynapseDataSourceProperties;
}

@doc("The properties that are associated with an Azure SQL database data source.")
model AzureSynapseDataSourceProperties {
  @doc("The name of the SQL server containing the Azure SQL database. Required on PUT (CreateOrReplace) requests.")
  server?: string;

  @doc("The name of the Azure SQL database. Required on PUT (CreateOrReplace) requests.")
  database?: string;

  @doc("The name of the table in the Azure SQL database. Required on PUT (CreateOrReplace) requests.")
  table?: string;

  @doc("The user name that will be used to connect to the Azure SQL database. Required on PUT (CreateOrReplace) requests.")
  user?: string;

  @doc("The password that will be used to connect to the Azure SQL database. Required on PUT (CreateOrReplace) requests.")
  password?: string;

  @doc("Authentication Mode.")
  authenticationMode?: AuthenticationMode;
}

@doc("Describes a PostgreSQL output data source.")
model PostgreSQLOutputDataSource extends OutputDataSource {
  @doc("The properties that are associated with a PostgreSQL output data source. Required on PUT (CreateOrReplace) requests.")
  properties?: PostgreSQLOutputDataSourceProperties;

  @doc("Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.DBForPostgreSQL/servers/databases";
}

@doc("The properties that are associated with a PostgreSQL output.")
model PostgreSQLOutputDataSourceProperties {
  ...PostgreSQLDataSourceProperties;
}

@doc("The properties that are associated with an Azure SQL database data source.")
model PostgreSQLDataSourceProperties {
  @doc("The name of the SQL server containing the Azure SQL database. Required on PUT (CreateOrReplace) requests.")
  server?: string;

  @doc("The name of the Azure SQL database. Required on PUT (CreateOrReplace) requests.")
  database?: string;

  @doc("The name of the table in the Azure SQL database. Required on PUT (CreateOrReplace) requests.")
  table?: string;

  @doc("The user name that will be used to connect to the Azure SQL database. Required on PUT (CreateOrReplace) requests.")
  user?: string;

  @doc("The password that will be used to connect to the Azure SQL database. Required on PUT (CreateOrReplace) requests.")
  password?: string;

  @doc("Max Writer count, currently only 1(single writer) and 0(based on query partition) are available. Optional on PUT requests.")
  maxWriterCount?: int32;

  @doc("Authentication Mode.")
  authenticationMode?: AuthenticationMode;
}

@doc("Describes a DocumentDB output data source.")
model DocumentDbOutputDataSource extends OutputDataSource {
  @doc("The properties that are associated with a DocumentDB output. Required on PUT (CreateOrReplace) requests.")
  properties?: DocumentDbOutputDataSourceProperties;

  @doc("Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.Storage/DocumentDB";
}

@doc("The properties that are associated with a DocumentDB output.")
model DocumentDbOutputDataSourceProperties {
  @doc("The DocumentDB account name or ID. Required on PUT (CreateOrReplace) requests.")
  accountId?: string;

  @doc("The account key for the DocumentDB account. Required on PUT (CreateOrReplace) requests.")
  accountKey?: string;

  @doc("The name of the DocumentDB database. Required on PUT (CreateOrReplace) requests.")
  database?: string;

  @doc("The collection name pattern for the collections to be used. The collection name format can be constructed using the optional {partition} token, where partitions start from 0. See the DocumentDB section of https://docs.microsoft.com/en-us/rest/api/streamanalytics/stream-analytics-output for more information. Required on PUT (CreateOrReplace) requests.")
  collectionNamePattern?: string;

  @doc("The name of the field in output events used to specify the key for partitioning output across collections. If 'collectionNamePattern' contains the {partition} token, this property is required to be specified.")
  partitionKey?: string;

  @doc("The name of the field in output events used to specify the primary key which insert or update operations are based on.")
  documentId?: string;

  @doc("Authentication Mode.")
  authenticationMode?: AuthenticationMode;
}

@doc("Defines the metadata of AzureFunctionOutputDataSource")
model AzureFunctionOutputDataSource extends OutputDataSource {
  @doc("The properties that are associated with a Azure Function output. Required on PUT (CreateOrReplace) requests.")
  properties?: AzureFunctionOutputDataSourceProperties;

  @doc("Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.AzureFunction";
}

@doc("The properties that are associated with an Azure Function output.")
model AzureFunctionOutputDataSourceProperties {
  @doc("The name of your Azure Functions app.")
  functionAppName?: string;

  @doc("The name of the function in your Azure Functions app.")
  functionName?: string;

  @doc("If you want to use an Azure Function from another subscription, you can do so by providing the key to access your function.")
  apiKey?: string;

  @doc("A property that lets you set the maximum size for each output batch that's sent to your Azure function. The input unit is in bytes. By default, this value is 262,144 bytes (256 KB).")
  maxBatchSize?: int32;

  @doc("A property that lets you specify the maximum number of events in each batch that's sent to Azure Functions. The default value is 100.")
  maxBatchCount?: int32;
}

@doc("Describes a Service Bus Queue output data source.")
model ServiceBusQueueOutputDataSource extends OutputDataSource {
  @doc("The properties that are associated with a Service Bus Queue output. Required on PUT (CreateOrReplace) requests.")
  properties?: ServiceBusQueueOutputDataSourceProperties;

  @doc("Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.ServiceBus/Queue";
}

@doc("The properties that are associated with a Service Bus Queue output.")
model ServiceBusQueueOutputDataSourceProperties {
  ...ServiceBusDataSourceProperties;

  @doc("The name of the Service Bus Queue. Required on PUT (CreateOrReplace) requests.")
  queueName?: string;

  @doc("A string array of the names of output columns to be attached to Service Bus messages as custom properties.")
  propertyColumns?: string[];

  @doc("The system properties associated with the Service Bus Queue. The following system properties are supported: ReplyToSessionId, ContentType, To, Subject, CorrelationId, TimeToLive, PartitionKey, SessionId, ScheduledEnqueueTime, MessageId, ReplyTo, Label, ScheduledEnqueueTimeUtc.")
  systemPropertyColumns?: Record<string>;
}

@doc("Describes a Service Bus Topic output data source.")
model ServiceBusTopicOutputDataSource extends OutputDataSource {
  @doc("The properties that are associated with a Service Bus Topic output. Required on PUT (CreateOrReplace) requests.")
  properties?: ServiceBusTopicOutputDataSourceProperties;

  @doc("Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.ServiceBus/Topic";
}

@doc("The properties that are associated with a Service Bus Topic output.")
model ServiceBusTopicOutputDataSourceProperties {
  ...ServiceBusDataSourceProperties;

  @doc("The name of the Service Bus Topic. Required on PUT (CreateOrReplace) requests.")
  topicName?: string;

  @doc("A string array of the names of output columns to be attached to Service Bus messages as custom properties.")
  propertyColumns?: string[];

  @doc("The system properties associated with the Service Bus Topic Output. The following system properties are supported: ReplyToSessionId, ContentType, To, Subject, CorrelationId, TimeToLive, PartitionKey, SessionId, ScheduledEnqueueTime, MessageId, ReplyTo, Label, ScheduledEnqueueTimeUtc.")
  systemPropertyColumns?: Record<string>;
}

@doc("Describes a Power BI output data source.")
model PowerBIOutputDataSource extends OutputDataSource {
  @doc("The properties that are associated with a Power BI output. Required on PUT (CreateOrReplace) requests.")
  properties?: PowerBIOutputDataSourceProperties;

  @doc("Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.")
  type: "PowerBI";
}

@doc("The properties that are associated with a Power BI output.")
model PowerBIOutputDataSourceProperties {
  ...OAuthBasedDataSourceProperties;

  @doc("The name of the Power BI dataset. Required on PUT (CreateOrReplace) requests.")
  dataset?: string;

  @doc("The name of the Power BI table under the specified dataset. Required on PUT (CreateOrReplace) requests.")
  table?: string;

  @doc("The ID of the Power BI group.")
  groupId?: string;

  @doc("The name of the Power BI group. Use this property to help remember which specific Power BI group id was used.")
  groupName?: string;

  @doc("Authentication Mode.")
  authenticationMode?: AuthenticationMode;
}

@doc("The properties that are associated with data sources that use OAuth as their authentication model.")
model OAuthBasedDataSourceProperties {
  @doc("A refresh token that can be used to obtain a valid access token that can then be used to authenticate with the data source. A valid refresh token is currently only obtainable via the Azure Portal. It is recommended to put a dummy string value here when creating the data source and then going to the Azure Portal to authenticate the data source which will update this property with a valid refresh token. Required on PUT (CreateOrReplace) requests.")
  refreshToken?: string;

  @doc("The user principal name (UPN) of the user that was used to obtain the refresh token. Use this property to help remember which user was used to obtain the refresh token.")
  tokenUserPrincipalName?: string;

  @doc("The user display name of the user that was used to obtain the refresh token. Use this property to help remember which user was used to obtain the refresh token.")
  tokenUserDisplayName?: string;
}

@doc("Describes an Azure Data Lake Store output data source.")
model AzureDataLakeStoreOutputDataSource extends OutputDataSource {
  @doc("The properties that are associated with an Azure Data Lake Store output. Required on PUT (CreateOrReplace) requests.")
  properties?: AzureDataLakeStoreOutputDataSourceProperties;

  @doc("Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.")
  type: "Microsoft.DataLake/Accounts";
}

@doc("The properties that are associated with an Azure Data Lake Store.")
model AzureDataLakeStoreOutputDataSourceProperties {
  ...OAuthBasedDataSourceProperties;

  @doc("The name of the Azure Data Lake Store account. Required on PUT (CreateOrReplace) requests.")
  accountName?: string;

  @doc("The tenant id of the user used to obtain the refresh token. Required on PUT (CreateOrReplace) requests.")
  tenantId?: string;

  @doc("The location of the file to which the output should be written to. Required on PUT (CreateOrReplace) requests.")
  filePathPrefix?: string;

  @doc("The date format. Wherever {date} appears in filePathPrefix, the value of this property is used as the date format instead.")
  dateFormat?: string;

  @doc("The time format. Wherever {time} appears in filePathPrefix, the value of this property is used as the time format instead.")
  timeFormat?: string;

  @doc("Authentication Mode.")
  authenticationMode?: AuthenticationMode;
}

@doc("Describes a Gateway Message Bus output data source.")
model GatewayMessageBusOutputDataSource extends OutputDataSource {
  @doc("The properties that are associated with a Gateway Message Bus output. Required on PUT (CreateOrReplace) requests.")
  properties?: GatewayMessageBusOutputDataSourceProperties;

  @doc("Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.")
  type: "GatewayMessageBus";
}

@doc("The properties that are associated with a Gateway Message Bus.")
model GatewayMessageBusOutputDataSourceProperties {
  ...GatewayMessageBusSourceProperties;
}
