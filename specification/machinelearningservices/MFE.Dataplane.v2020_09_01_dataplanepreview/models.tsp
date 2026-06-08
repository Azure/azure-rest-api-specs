import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.MachineLearningServices;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union InferenceDataInputType {
  string,

  /**
   * DatasetVersion
   */
  DatasetVersion: "DatasetVersion",

  /**
   * DatasetId
   */
  DatasetId: "DatasetId",

  /**
   * DataUrl
   */
  DataUrl: "DataUrl",
}

/**
 * Enum to determine the Job Input Type.
 */
union JobInputType {
  string,

  /**
   * UriFile
   */
  UriFile: "UriFile",

  /**
   * UriFolder
   */
  UriFolder: "UriFolder",

  /**
   * MLTable
   */
  MLTable: "MLTable",

  /**
   * Literal
   */
  Literal: "Literal",

  /**
   * CustomModel
   */
  CustomModel: "CustomModel",

  /**
   * MLFlowModel
   */
  MLFlowModel: "MLFlowModel",

  /**
   * TritonModel
   */
  TritonModel: "TritonModel",
}

/**
 * Log verbosity for batch inferencing.
 * Increasing verbosity order for logging is : Warning, Info and Debug.
 * The default value is Info.
 */
union BatchLoggingLevel {
  string,

  /**
   * Info
   */
  Info: "Info",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Debug
   */
  Debug: "Debug",
}

/**
 * Enum to determine the Job Output Type.
 */
union JobOutputType {
  string,

  /**
   * UriFile
   */
  UriFile: "UriFile",

  /**
   * UriFolder
   */
  UriFolder: "UriFolder",

  /**
   * MLTable
   */
  MLTable: "MLTable",

  /**
   * CustomModel
   */
  CustomModel: "CustomModel",

  /**
   * MLFlowModel
   */
  MLFlowModel: "MLFlowModel",

  /**
   * TritonModel
   */
  TritonModel: "TritonModel",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union DatasetType {
  string,

  /**
   * Simple
   */
  Simple: "Simple",

  /**
   * Dataflow
   */
  Dataflow: "Dataflow",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union JobProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * InProgress
   */
  InProgress: "InProgress",
}

/**
 * The status of a job.
 */
union JobStatus {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * Starting
   */
  Starting: "Starting",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Preparing
   */
  Preparing: "Preparing",

  /**
   * Queued
   */
  Queued: "Queued",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Finalizing
   */
  Finalizing: "Finalizing",

  /**
   * CancelRequested
   */
  CancelRequested: "CancelRequested",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * NotResponding
   */
  NotResponding: "NotResponding",

  /**
   * Paused
   */
  Paused: "Paused",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * Enum to determine the input data delivery mode.
 */
union InputDeliveryMode {
  string,

  /**
   * ReadOnlyMount
   */
  ReadOnlyMount: "ReadOnlyMount",

  /**
   * ReadWriteMount
   */
  ReadWriteMount: "ReadWriteMount",

  /**
   * Download
   */
  Download: "Download",

  /**
   * Direct
   */
  Direct: "Direct",

  /**
   * EvalMount
   */
  EvalMount: "EvalMount",

  /**
   * EvalDownload
   */
  EvalDownload: "EvalDownload",
}

/**
 * Output data delivery mode enums.
 */
union OutputDeliveryMode {
  string,

  /**
   * ReadWriteMount
   */
  ReadWriteMount: "ReadWriteMount",

  /**
   * Upload
   */
  Upload: "Upload",
}

/**
 * A paginated list of BatchJob entities.
 */
model BatchJobResourceArmPaginatedResult is Azure.Core.Page<BatchJobResource>;

/**
 * Batch endpoint job
 */
model BatchJob {
  /**
   * Compute configuration used to set instance count.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  compute?: ComputeConfiguration;

  /**
   * Input dataset
   * This will be deprecated. Use InputData instead
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataset?: InferenceDataInputBase;

  /**
   * The asset description text.
   */
  description?: string;

  /**
   * Error threshold, if the error count for the entire input goes above this value,
   * the batch inference will be aborted. Range is [-1, int.MaxValue]
   * -1 value indicates, ignore all failures during batch inference
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  errorThreshold?: int32;

  /**
   * Input data for the job
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inputData?: Record<JobInput>;

  /**
   * Dictonary of endpoint URIs, keyed by enumerated job endpoints.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  interactionEndpoints?: Record<JobEndpoint>;

  /**
   * Logging level for batch inference operation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  loggingLevel?: BatchLoggingLevel;

  /**
   * Indicates maximum number of parallelism per instance.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  maxConcurrencyPerInstance?: int32;

  /**
   * Size of the mini-batch passed to each batch invocation.
   * For FileDataset, this is the number of files per mini-batch.
   * For TabularDataset, this is the size of the records in bytes, per mini-batch.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  miniBatchSize?: int64;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  name?: string;

  /**
   * Location of the job output logs and artifacts.
   */
  @visibility(Lifecycle.Read)
  output?: JobOutputArtifacts;

  /**
   * Job output data location
   * Optional parameter: when not specified, the default location is
   * workspaceblobstore location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outputData?: Record<JobOutputV2>;

  /**
   * Output dataset location
   * Optional parameter: when not specified, the default location is
   * workspaceblobstore location.
   * This will be deprecated. Use OutputData instead
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outputDataset?: DataVersion;

  /**
   * Output file name
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outputFileName?: string;

  /**
   * Partition keys list used for Named partitioning.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  partitionKeys?: string[];

  /**
   * The asset property dictionary.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: JobProvisioningState;

  /**
   * Retry Settings for the batch inference operation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  retrySettings?: BatchRetrySettings;

  /**
   * Status of the job.
   */
  @visibility(Lifecycle.Read)
  status?: JobStatus;

  /**
   * Tag dictionary. Tags can be added, removed, and updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Configuration for compute binding.
 */
model ComputeConfiguration {
  /**
   * Number of instances or nodes.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  instanceCount?: int32;

  /**
   * SKU type to run on.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  instanceType?: string;

  /**
   * Set to true for jobs running on local compute.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isLocal?: boolean;

  /**
   * Location for virtual cluster run.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Additional properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<string>;

  /**
   * ARM resource ID of the Compute you are targeting. If not provided the resource will be deployed as Managed.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  target?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@discriminator("dataInputType")
model InferenceDataInputBase {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  dataInputType: InferenceDataInputType;
}

/**
 * Job input definition.
 */
@discriminator("jobInputType")
model JobInput {
  /**
   * Description for the input.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  description?: string;

  /**
   * Specifies the type of job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobInputType: JobInputType;
}

/**
 * Job endpoint definition
 */
model JobEndpoint {
  /**
   * Url for endpoint.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpoint?: string;

  /**
   * Endpoint type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobEndpointType?: string;

  /**
   * Port for endpoint.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  port?: int32;

  /**
   * Additional properties to set on the endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<string>;
}

/**
 * Job output definition container information on where to find job logs and artifacts.
 */
model JobOutputArtifacts {
  /**
   * ARM ID of the datastore where the job logs and artifacts are stored
   */
  @visibility(Lifecycle.Read)
  datastoreId?: string;

  /**
   * Path within the datastore to the job logs and artifacts.
   */
  @visibility(Lifecycle.Read)
  path?: string;
}

/**
 * Job output definition container information on where to find the job output.
 */
@discriminator("jobOutputType")
model JobOutputV2 {
  /**
   * Description for the output.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  description?: string;

  /**
   * Specifies the type of job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobOutputType: JobOutputType;
}

/**
 * Data asset version details.
 */
model DataVersion {
  /**
   * The Format of dataset.
   */
  datasetType?: DatasetType;

  /**
   * ARM resource ID of the datastore where the asset is located.
   */
  datastoreId?: string;

  /**
   * The asset description text.
   */
  description?: string;

  /**
   * If the name version are system generated (anonymous registration).
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isAnonymous?: boolean;

  /**
   * [Required] The path of the file/directory in the datastore.
   */
  @pattern("[a-zA-Z0-9_]")
  path: string;

  /**
   * The asset property dictionary.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<string>;

  /**
   * Tag dictionary. Tags can be added, removed, and updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Retry settings for a batch inference operation.
 */
model BatchRetrySettings {
  /**
   * Maximum retry count for a mini-batch
   */
  maxRetries?: int32;

  /**
   * Invocation timeout for a mini-batch, in ISO 8601 format.
   */
  timeout?: duration;
}

/**
 * Error response information.
 */
@error
model ErrorResponse {
  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * An array of error detail objects.
   */
  @visibility(Lifecycle.Read)
  details?: ErrorDetail[];
}

/**
 * Error detail information.
 */
model ErrorDetail {
  /**
   * Error code.
   */
  code: string;

  /**
   * Error message.
   */
  message: string;
}

/**
 * Asset input type.
 */
model AssetJobInput {
  /**
   * Input Asset Delivery Mode.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode?: InputDeliveryMode;

  /**
   * Input Asset URI.
   */
  @pattern("[a-zA-Z0-9_]")
  uri: string;
}

/**
 * Asset output type.
 */
model AssetJobOutput {
  /**
   * Output Asset Delivery Mode.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode?: OutputDeliveryMode;

  /**
   * Output Asset URI. This will have a default value of "azureml/{jobId}/{outputFolder}/{outputFileName}" if omitted.
   */
  uri?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CustomModelJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * Specifies the type of job.
   */
  jobInputType: "CustomModel";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CustomModelJobOutput extends JobOutputV2 {
  ...AssetJobOutput;

  /**
   * Specifies the type of job.
   */
  jobOutputType: "CustomModel";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model InferenceDatasetIdInput extends InferenceDataInputBase {
  /**
   * ARM ID of the input dataset
   */
  datasetId?: string;

  dataInputType: "DatasetId";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model InferenceDatasetInput extends InferenceDataInputBase {
  /**
   * Name of the input dataset
   */
  datasetName?: string;

  /**
   * Version of the input dataset
   */
  datasetVersion?: string;

  dataInputType: "DatasetVersion";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model InferenceDataUrlInput extends InferenceDataInputBase {
  /**
   * Asset path to the input data, say a blob URL.
   */
  @pattern("[a-zA-Z0-9_]")
  path: string;

  dataInputType: "DataUrl";
}

/**
 * Label class definition
 */
model LabelClass {
  /**
   * Display name of the label class.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  displayName?: string;

  /**
   * Dictionary of subclasses of the label class.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  subclasses?: Record<LabelClass>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model LiteralJobInput extends JobInput {
  /**
   * Literal input value
   */
  @pattern("[a-zA-Z0-9_]")
  value: string;

  /**
   * Specifies the type of job.
   */
  jobInputType: "Literal";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model MLFlowModelJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * Specifies the type of job.
   */
  jobInputType: "MLFlowModel";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model MLFlowModelJobOutput extends JobOutputV2 {
  ...AssetJobOutput;

  /**
   * Specifies the type of job.
   */
  jobOutputType: "MLFlowModel";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model MLTableJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * Specifies the type of job.
   */
  jobInputType: "MLTable";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model MLTableJobOutput extends JobOutputV2 {
  ...AssetJobOutput;

  /**
   * Specifies the type of job.
   */
  jobOutputType: "MLTable";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model TritonModelJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * Specifies the type of job.
   */
  jobInputType: "TritonModel";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model TritonModelJobOutput extends JobOutputV2 {
  ...AssetJobOutput;

  /**
   * Specifies the type of job.
   */
  jobOutputType: "TritonModel";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UriFileJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * Specifies the type of job.
   */
  jobInputType: "UriFile";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UriFileJobOutput extends JobOutputV2 {
  ...AssetJobOutput;

  /**
   * Specifies the type of job.
   */
  jobOutputType: "UriFile";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UriFolderJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * Specifies the type of job.
   */
  jobInputType: "UriFolder";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UriFolderJobOutput extends JobOutputV2 {
  ...AssetJobOutput;

  /**
   * Specifies the type of job.
   */
  jobOutputType: "UriFolder";
}
