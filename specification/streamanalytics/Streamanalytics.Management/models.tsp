import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.StreamAnalytics;

/**
 * The name of the SKU. Required on PUT (CreateOrReplace) requests.
 */
union SkuName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard: "Standard",
}

/**
 * Describes the type of the job. Valid modes are `Cloud` and 'Edge'.
 */
union JobType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Cloud: "Cloud",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Edge: "Edge",
}

/**
 * Value may be JobStartTime, CustomTime, or LastOutputEventTime to indicate whether the starting point of the output event stream should start whenever the job is started, start at a custom user time stamp specified via the outputStartTime property, or start from the last event output time.
 */
union OutputStartMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  JobStartTime: "JobStartTime",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CustomTime: "CustomTime",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LastOutputEventTime: "LastOutputEventTime",
}

/**
 * Indicates the policy to apply to events that arrive out of order in the input event stream.
 */
union EventsOutOfOrderPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Adjust: "Adjust",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Drop: "Drop",
}

/**
 * Indicates the policy to apply to events that arrive at the output and cannot be written to the external storage due to being malformed (missing column values, column values of wrong type or size).
 */
union OutputErrorPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Stop: "Stop",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Drop: "Drop",
}

/**
 * Controls certain runtime behaviors of the streaming job.
 */
union CompatibilityLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `1.0`: "1.0",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `1.2`: "1.2",
}

/**
 * Indicates the type of serialization that the input or output uses. Required on PUT (CreateOrReplace) requests.
 */
union EventSerializationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Csv: "Csv",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Avro: "Avro",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Json: "Json",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Parquet: "Parquet",
}

/**
 * Indicates the type of compression that the input uses. Required on PUT (CreateOrReplace) requests.
 */
union CompressionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GZip: "GZip",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deflate: "Deflate",
}

/**
 * Authentication Mode. Valid modes are `ConnectionString`, `Msi` and 'UserToken'.
 */
union AuthenticationMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Msi: "Msi",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserToken: "UserToken",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ConnectionString: "ConnectionString",
}

/**
 * Valid values are JobStorageAccount and SystemAccount. If set to JobStorageAccount, this requires the user to also specify jobStorageAccount property. .
 */
union ContentStoragePolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAccount: "SystemAccount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  JobStorageAccount: "JobStorageAccount",
}

/**
 * Specifies the SKU name of the cluster. Required on PUT (CreateOrUpdate) requests.
 */
union ClusterSkuName {
  string,

  /**
   * The default SKU.
   */
  Default: "Default",
}

/**
 * The status of the cluster provisioning. The three terminal states are: Succeeded, Failed and Canceled
 */
union ClusterProvisioningState {
  string,

  /**
   * The cluster provisioning succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * The cluster provisioning failed.
   */
  Failed: "Failed",

  /**
   * The cluster provisioning was canceled.
   */
  Canceled: "Canceled",

  /**
   * The cluster provisioning was inprogress.
   */
  InProgress: "InProgress",
}

/**
 * The current execution state of the streaming job.
 */
union JobState {
  string,

  /**
   * The job is currently in the Created state.
   */
  Created: "Created",

  /**
   * The job is currently in the Starting state.
   */
  Starting: "Starting",

  /**
   * The job is currently in the Running state.
   */
  Running: "Running",

  /**
   * The job is currently in the Stopping state.
   */
  Stopping: "Stopping",

  /**
   * The job is currently in the Stopped state.
   */
  Stopped: "Stopped",

  /**
   * The job is currently in the Deleting state.
   */
  Deleting: "Deleting",

  /**
   * The job is currently in the Failed state.
   */
  Failed: "Failed",

  /**
   * The job is currently in the Degraded state.
   */
  Degraded: "Degraded",

  /**
   * The job is currently in the Restarting state.
   */
  Restarting: "Restarting",

  /**
   * The job is currently in the Scaling state.
   */
  Scaling: "Scaling",
}

/**
 * Specifies the encoding of the incoming data in the case of input and the encoding of outgoing data in the case of output.
 */
union Encoding {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UTF8: "UTF8",
}

/**
 * Specifies the format of the JSON the output will be written in. The currently supported values are 'lineSeparated' indicating the output will be formatted by having each JSON object separated by a new line and 'array' indicating the output will be formatted as an array of JSON objects.
 */
union JsonOutputSerializationFormat {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LineSeparated: "LineSeparated",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Array: "Array",
}

/**
 * Indicates the type of data refresh option.
 */
union RefreshType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Static: "Static",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RefreshPeriodicallyWithFull: "RefreshPeriodicallyWithFull",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RefreshPeriodicallyWithDelta: "RefreshPeriodicallyWithDelta",
}

/**
 * Common error representation.
 */
@error
model Error {
  /**
   * Error definition properties.
   */
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
  @OpenAPI.extension("x-ms-identifiers", #[])
  details?: ErrorDetails[];
}

/**
 * Common error details representation.
 */
model ErrorDetails {
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
  @visibility(Lifecycle.Read)
  jobId?: string;

  /**
   * Describes the provisioning status of the streaming job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Describes the state of the streaming job.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
 * The properties that are associated with an input.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
@discriminator("type")
model InputProperties {
  /**
   * Indicates whether the input is a source of reference data or stream data. Required on PUT (CreateOrReplace) requests.
   */
  type: string;

  /**
   * Describes how data from an input is serialized or how data is serialized when written to an output. Required on PUT (CreateOrReplace) requests.
   */
  serialization?: Serialization;

  /**
   * Describes conditions applicable to the Input, Output, or the job overall, that warrant customer attention.
   */
  @visibility(Lifecycle.Read)
  diagnostics?: Diagnostics;

  /**
   * The current entity tag for the input. This is an opaque string. You can use it to detect whether the resource has changed between requests. You can also use it in the If-Match or If-None-Match headers for write operations for optimistic concurrency.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Describes how input data is compressed
   */
  compression?: Compression;

  /**
   * partitionKey Describes a key in the input data which is used for partitioning the input data
   */
  partitionKey?: string;
}

/**
 * Describes how data from an input is serialized or how data is serialized when written to an output.
 */
@discriminator("type")
model Serialization {
  /**
   * Indicates the type of serialization that the input or output uses. Required on PUT (CreateOrReplace) requests.
   */
  type: EventSerializationType;
}

/**
 * Describes conditions applicable to the Input, Output, or the job overall, that warrant customer attention.
 */
model Diagnostics {
  /**
   * A collection of zero or more conditions applicable to the resource, or to the job overall, that warrant customer attention.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  conditions?: DiagnosticCondition[];
}

/**
 * Condition applicable to the resource, or to the job overall, that warrant customer attention.
 */
model DiagnosticCondition {
  /**
   * The UTC timestamp of when the condition started. Customers should be able to find a corresponding event in the ops log around this time.
   */
  @visibility(Lifecycle.Read)
  since?: string;

  /**
   * The opaque diagnostic code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The human-readable message describing the condition in detail. Localized in the Accept-Language of the client request.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Describes how input data is compressed
 */
model Compression {
  /**
   * Indicates the type of compression that the input uses. Required on PUT (CreateOrReplace) requests.
   */
  type: CompressionType = CompressionType.None;
}

/**
 * The base sub-resource model definition.
 */
model SubResource {
  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The properties that are associated with a transformation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model TransformationProperties {
  /**
   * Specifies the number of streaming units that the streaming job uses.
   */
  streamingUnits?: int32 = 3;

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
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * The properties that are associated with an output.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model OutputProperties {
  /**
   * Describes the data source that output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  datasource?: OutputDataSource;

  /**
   * The time frame for filtering Stream Analytics job outputs.
   */
  timeWindow?: string;

  /**
   * The size window to constrain a Stream Analytics output to.
   */
  sizeWindow?: int32;

  /**
   * Describes how data from an input is serialized or how data is serialized when written to an output. Required on PUT (CreateOrReplace) requests.
   */
  serialization?: Serialization;

  /**
   * Describes conditions applicable to the Input, Output, or the job overall, that warrant customer attention.
   */
  @visibility(Lifecycle.Read)
  diagnostics?: Diagnostics;

  /**
   * The current entity tag for the output. This is an opaque string. You can use it to detect whether the resource has changed between requests. You can also use it in the If-Match or If-None-Match headers for write operations for optimistic concurrency.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Describes the data source that output will be written to.
 */
@discriminator("type")
model OutputDataSource {
  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: string;
}

/**
 * The properties that are associated with a function.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
@discriminator("type")
model FunctionProperties {
  /**
   * Indicates the type of function.
   */
  type: string;

  /**
   * The current entity tag for the function. This is an opaque string. You can use it to detect whether the resource has changed between requests. You can also use it in the If-Match or If-None-Match headers for write operations for optimistic concurrency.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: FunctionConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model FunctionConfiguration {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
model FunctionBinding {
  /**
   * Indicates the function binding type.
   */
  type: string;
}

/**
 * The properties that are associated with an Azure Storage account with MSI
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model JobStorageAccount extends StorageAccount {
  /**
   * Authentication Mode.
   */
  authenticationMode?: AuthenticationMode = AuthenticationMode.ConnectionString;
}

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
   * The identity tenantId
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The identity principal ID
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The identity type
   */
  type?: string;
}

/**
 * The base resource definition
 */
model Resource {
  /**
   * Fully qualified resource Id for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. Ex- Microsoft.Compute/virtualMachines or Microsoft.Storage/storageAccounts.
   */
  @visibility(Lifecycle.Read)
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
 * Describes the status of the test operation along with error information, if applicable.
 */
model ResourceTestStatus {
  /**
   * The status of the test operation.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Describes the error that occurred.
   */
  @visibility(Lifecycle.Read)
  error?: ErrorResponse;
}

/**
 * Parameters used to specify the type of function to retrieve the default definition for.
 */
@discriminator("bindingType")
model FunctionRetrieveDefaultDefinitionParameters {
  /**
   * Indicates the function binding type.
   */
  bindingType: string;
}

/**
 * Result of the GetQuotas operation. It contains a list of quotas for the subscription in a particular region.
 */
model SubscriptionQuotasListResult {
  /**
   * List of quotas for the subscription in a particular region.
   */
  @visibility(Lifecycle.Read)
  value?: SubscriptionQuota[];
}

/**
 * Describes the current quota for the subscription.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SubscriptionQuota extends SubResource {
  /**
   * Describes the properties of the quota.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: SubscriptionQuotaProperties;
}

/**
 * Describes the properties of the quota.
 */
model SubscriptionQuotaProperties {
  /**
   * The max permitted usage of this resource.
   */
  @visibility(Lifecycle.Read)
  maxCount?: int32;

  /**
   * The current usage of this resource.
   */
  @visibility(Lifecycle.Read)
  currentCount?: int32;
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
  @maxValue(396)
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * Unique identifier for the cluster.
   */
  @visibility(Lifecycle.Read)
  clusterId?: string;

  /**
   * The status of the cluster provisioning. The three terminal states are: Succeeded, Failed and Canceled
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ClusterProvisioningState;

  /**
   * Represents the number of streaming units currently being used on the cluster.
   */
  @visibility(Lifecycle.Read)
  capacityAllocated?: int32;

  /**
   * Represents the sum of the SUs of all streaming jobs associated with the cluster. If all of the jobs were running, this would be the capacity allocated.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The number of streaming units that are used by the streaming job.
   */
  @visibility(Lifecycle.Read)
  streamingUnits?: int32;

  /**
   * The current execution state of the streaming job.
   */
  @visibility(Lifecycle.Read)
  jobState?: JobState;
}

/**
 * The properties associated with a private endpoint.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model PrivateEndpointProperties {
  /**
   * The date when this private endpoint was created.
   */
  @visibility(Lifecycle.Read)
  createdDate?: string;

  /**
   * A list of connections to the remote resource. Immutable after it is set.
   */
  @OpenAPI.extension("x-ms-identifiers", #["/properties/privateLinkServiceId"])
  manualPrivateLinkServiceConnections?: PrivateLinkServiceConnection[];
}

/**
 * A grouping of information about the connection to the remote resource.
 */
model PrivateLinkServiceConnection {
  /**
   * Bag of properties defining a privatelinkServiceConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The reason for approval/rejection of the connection.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  @visibility(Lifecycle.Read)
  actionsRequired?: string;
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
model StreamInputDataSource {
  /**
   * Indicates the type of input data source containing stream data. Required on PUT (CreateOrReplace) requests.
   */
  type: string;
}

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
model ReferenceInputDataSource {
  /**
   * Indicates the type of input data source containing reference data. Required on PUT (CreateOrReplace) requests.
   */
  type: string;
}

/**
 * Describes a blob input data source that contains stream data.
 */
model BlobStreamInputDataSource extends StreamInputDataSource {
  /**
   * The properties that are associated with a blob input containing stream data. Required on PUT (CreateOrReplace) requests.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: BlobStreamInputDataSourceProperties;

  /**
   * Indicates the type of input data source containing stream data. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.Storage/Blob";
}

/**
 * The properties that are associated with a blob input containing stream data.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
  @OpenAPI.extension("x-ms-identifiers", #["accountName"])
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
  authenticationMode?: AuthenticationMode = AuthenticationMode.ConnectionString;
}

/**
 * Describes an Event Hub input data source that contains stream data.
 */
model EventHubStreamInputDataSource extends StreamInputDataSource {
  /**
   * The properties that are associated with an Event Hub input containing stream data. Required on PUT (CreateOrReplace) requests.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: EventHubStreamInputDataSourceProperties;

  /**
   * Indicates the type of input data source containing stream data. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.ServiceBus/EventHub";
}

/**
 * The properties that are associated with a Event Hub input containing stream data.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model EventHubStreamInputDataSourceProperties
  extends EventHubDataSourceProperties {
  /**
   * The name of an Event Hub Consumer Group that should be used to read events from the Event Hub. Specifying distinct consumer group names for multiple inputs allows each of those inputs to receive the same events from the Event Hub. If not specified, the input uses the Event Hub’s default consumer group.
   */
  consumerGroupName?: string;
}

/**
 * The common properties that are associated with Event Hub data sources.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model EventHubDataSourceProperties extends ServiceBusDataSourceProperties {
  /**
   * The name of the Event Hub. Required on PUT (CreateOrReplace) requests.
   */
  eventHubName?: string;
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
  authenticationMode?: AuthenticationMode = AuthenticationMode.ConnectionString;
}

/**
 * Describes an Event Hub input data source that contains stream data.
 */
model EventHubV2StreamInputDataSource extends StreamInputDataSource {
  /**
   * The properties that are associated with an Event Hub input containing stream data. Required on PUT (CreateOrReplace) requests.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
 * Describes a file input data source that contains reference data.
 */
model FileReferenceInputDataSource extends ReferenceInputDataSource {
  /**
   * The properties that are associated with a file input containing reference data. Required on PUT (CreateOrReplace) requests.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: FileReferenceInputDataSourceProperties;

  /**
   * Indicates the type of input data source containing reference data. Required on PUT (CreateOrReplace) requests.
   */
  type: "File";
}

/**
 * The properties that are associated with a file input containing reference data.
 */
model FileReferenceInputDataSourceProperties {
  /**
   * The path of the file.
   */
  path?: string;
}

/**
 * Describes a blob input data source that contains reference data.
 */
model BlobReferenceInputDataSource extends ReferenceInputDataSource {
  /**
   * The properties that are associated with a blob input containing reference data. Required on PUT (CreateOrReplace) requests.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: BlobReferenceInputDataSourceProperties;

  /**
   * Indicates the type of input data source containing reference data. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.Storage/Blob";
}

/**
 * The properties that are associated with a blob input containing reference data.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model BlobReferenceInputDataSourceProperties extends BlobDataSourceProperties {}

/**
 * Describes how data from an input is serialized or how data is serialized when written to an output in Parquet format.
 */
model ParquetSerialization extends Serialization {
  /**
   * The properties that are associated with the Parquet serialization type. Required on PUT (CreateOrReplace) requests.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: Record<unknown>;

  /**
   * Indicates the type of serialization that the input or output uses. Required on PUT (CreateOrReplace) requests.
   */
  type: "Parquet";
}

/**
 * Describes how data from an input is serialized or how data is serialized when written to an output in CSV format.
 */
model CsvSerialization extends Serialization {
  /**
   * The properties that are associated with the CSV serialization type. Required on PUT (CreateOrReplace) requests.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
   * This element is associated with the datasource element. The name of the table in the Azure SQL database..
   */
  table?: string;

  /**
   * Indicates the type of data refresh option.
   */
  refreshType?: RefreshType;

  /**
   * This element is associated with the datasource element. This indicates how frequently the data will be fetched from the database. It is of DateTime format.
   */
  refreshRate?: string;

  /**
   * This element is associated with the datasource element. This query is used to fetch data from the sql database.
   */
  fullSnapshotQuery?: string;

  /**
   * This element is associated with the datasource element. This query is used to fetch incremental changes from the SQL database. To use this option, we recommend using temporal tables in Azure SQL Database.
   */
  deltaSnapshotQuery?: string;
}

/**
 * Describes a blob input data source that contains stream data.
 */
model GatewayMessageBusStreamInputDataSource extends StreamInputDataSource {
  /**
   * The properties that are associated with a gateway message bus input containing stream data.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: GatewayMessageBusStreamInputDataSourceProperties;

  /**
   * Indicates the type of input data source containing stream data. Required on PUT (CreateOrReplace) requests.
   */
  type: "GatewayMessageBus";
}

/**
 * The properties that are associated with a gateway message bus input containing stream data.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
 * Describes a blob output data source.
 */
model BlobOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with a blob output. Required on PUT (CreateOrReplace) requests.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: BlobOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.Storage/Blob";
}

/**
 * The properties that are associated with a blob output.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model BlobOutputDataSourceProperties extends BlobDataSourceProperties {
  /**
   * Blob path prefix.
   */
  blobPathPrefix?: string;
}

/**
 * Describes an Azure Table output data source.
 */
model AzureTableOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with an Azure Table output. Required on PUT (CreateOrReplace) requests.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: EventHubOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.ServiceBus/EventHub";
}

/**
 * The properties that are associated with an Event Hub output.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: AzureSqlDatabaseOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.Sql/Server/Database";
}

/**
 * The properties that are associated with an Azure SQL database output.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
  maxBatchCount?: float32;

  /**
   * Max Writer count, currently only 1(single writer) and 0(based on query partition) are available. Optional on PUT requests.
   */
  maxWriterCount?: float32;

  /**
   * Authentication Mode.
   */
  authenticationMode?: AuthenticationMode = AuthenticationMode.ConnectionString;
}

/**
 * Describes an Azure Synapse output data source.
 */
model AzureSynapseOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with an Azure Synapse output. Required on PUT (CreateOrReplace) requests.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: AzureSynapseOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.Sql/Server/DataWarehouse";
}

/**
 * The properties that are associated with an Azure Synapse output.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
}

/**
 * Describes a DocumentDB output data source.
 */
model DocumentDbOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with a DocumentDB output. Required on PUT (CreateOrReplace) requests.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
}

/**
 * Defines the metadata of AzureFunctionOutputDataSource
 */
model AzureFunctionOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with a Azure Function output. Required on PUT (CreateOrReplace) requests.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  maxBatchSize?: float32;

  /**
   * A property that lets you specify the maximum number of events in each batch that's sent to Azure Functions. The default value is 100.
   */
  maxBatchCount?: float32;
}

/**
 * Describes a Service Bus Queue output data source.
 */
model ServiceBusQueueOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with a Service Bus Queue output. Required on PUT (CreateOrReplace) requests.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ServiceBusQueueOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.ServiceBus/Queue";
}

/**
 * The properties that are associated with a Service Bus Queue output.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
  systemPropertyColumns?: Record<unknown>;
}

/**
 * Describes a Service Bus Topic output data source.
 */
model ServiceBusTopicOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with a Service Bus Topic output. Required on PUT (CreateOrReplace) requests.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ServiceBusTopicOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.ServiceBus/Topic";
}

/**
 * The properties that are associated with a Service Bus Topic output.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  systemPropertyColumns?: Record<string>;
}

/**
 * Describes a Power BI output data source.
 */
model PowerBIOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with a Power BI output. Required on PUT (CreateOrReplace) requests.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: PowerBIOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "PowerBI";
}

/**
 * The properties that are associated with a Power BI output.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
  authenticationMode?: AuthenticationMode = AuthenticationMode.ConnectionString;
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: AzureDataLakeStoreOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "Microsoft.DataLake/Accounts";
}

/**
 * The properties that are associated with an Azure Data Lake Store.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
  authenticationMode?: AuthenticationMode = AuthenticationMode.ConnectionString;
}

/**
 * Describes a Gateway Message Bus output data source.
 */
model GatewayMessageBusOutputDataSource extends OutputDataSource {
  /**
   * The properties that are associated with a Gateway Message Bus output. Required on PUT (CreateOrReplace) requests.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: GatewayMessageBusOutputDataSourceProperties;

  /**
   * Indicates the type of data source output will be written to. Required on PUT (CreateOrReplace) requests.
   */
  type: "GatewayMessageBus";
}

/**
 * The properties that are associated with a Gateway Message Bus.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model GatewayMessageBusOutputDataSourceProperties
  extends GatewayMessageBusSourceProperties {}

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
 * The binding to an Azure Machine Learning web service.
 */
model AzureMachineLearningWebServiceFunctionBinding extends FunctionBinding {
  /**
   * The binding properties associated with an Azure Machine learning web service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: AzureMachineLearningWebServiceFunctionBindingProperties;

  /**
   * Indicates the function binding type.
   */
  type: "Microsoft.MachineLearning/WebService";
}

/**
 * The binding properties associated with an Azure Machine learning web service.
 */
model AzureMachineLearningWebServiceFunctionBindingProperties {
  /**
   * The Request-Response execute endpoint of the Azure Machine Learning web service. Find out more here: https://docs.microsoft.com/en-us/azure/machine-learning/machine-learning-consume-web-services#request-response-service-rrs
   */
  endpoint?: string;

  /**
   * The API key used to authenticate with Request-Response endpoint.
   */
  apiKey?: string;

  /**
   * The inputs for the Azure Machine Learning web service endpoint.
   */
  inputs?: AzureMachineLearningWebServiceInputs;

  /**
   * A list of outputs from the Azure Machine Learning web service endpoint execution.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  outputs?: AzureMachineLearningWebServiceOutputColumn[];

  /**
   * Number between 1 and 10000 describing maximum number of rows for every Azure ML RRS execute request. Default is 1000.
   */
  batchSize?: int32;
}

/**
 * The inputs for the Azure Machine Learning web service endpoint.
 */
model AzureMachineLearningWebServiceInputs {
  /**
   * The name of the input. This is the name provided while authoring the endpoint.
   */
  name?: string;

  /**
   * A list of input columns for the Azure Machine Learning web service endpoint.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  columnNames?: AzureMachineLearningWebServiceInputColumn[];
}

/**
 * Describes an input column for the Azure Machine Learning web service endpoint.
 */
model AzureMachineLearningWebServiceInputColumn {
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
 * Describes an output column for the Azure Machine Learning web service endpoint.
 */
model AzureMachineLearningWebServiceOutputColumn {
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
 * The parameters needed to retrieve the default function definition for an Azure Machine Learning web service function.
 */
model AzureMachineLearningWebServiceFunctionRetrieveDefaultDefinitionParameters
  extends FunctionRetrieveDefaultDefinitionParameters {
  /**
   * The binding retrieval properties associated with an Azure Machine learning web service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  bindingRetrievalProperties?: AzureMachineLearningWebServiceFunctionBindingRetrievalProperties;

  /**
   * Indicates the function binding type.
   */
  bindingType: "Microsoft.MachineLearning/WebService";
}

/**
 * The binding retrieval properties associated with an Azure Machine learning web service.
 */
model AzureMachineLearningWebServiceFunctionBindingRetrievalProperties {
  /**
   * The Request-Response execute endpoint of the Azure Machine Learning web service. Find out more here: https://docs.microsoft.com/en-us/azure/machine-learning/machine-learning-consume-web-services#request-response-service-rrs
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
 * The properties that are associated with an aggregate function.
 */
model AggregateFunctionProperties extends FunctionProperties {
  /**
   * Indicates the type of function.
   */
  type: "Aggregate";
}
