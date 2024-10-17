import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../credentials/models.tsp";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Microsoft.MachineLearningServices;

/**
 * Inference Endpoint base definition
 */
model EndpointBase {
  /**
   * [Required] Use 'Key' for key based authentication and 'AMLToken' for Azure Machine Learning token-based authentication. 'Key' doesn't expire but 'AMLToken' does.
   */
  authMode: EndpointAuthMode;

  /**
   * Description of the inference endpoint.
   */
  description?: string;

  /**
   * EndpointAuthKeys to set initially on an Endpoint.
   * This property will always be returned as null. AuthKey values must be retrieved using the ListKeys API.
   */
  @visibility("create")
  keys?: EndpointAuthKeys;

  /**
   * Property dictionary. Properties can be added, but not removed or altered.
   */
  properties?: Record<string>;

  /**
   * Endpoint URI.
   */
  @visibility("read")
  scoringUri?: url;

  /**
   * Endpoint Swagger URI.
   */
  @visibility("read")
  swaggerUri?: url;
}

/**
 * Base definition for endpoint deployment.
 */
model EndpointDeploymentBase {
  /**
   * Code configuration for the endpoint deployment.
   */
  codeConfiguration?: CodeConfiguration;

  /**
   * Description of the endpoint deployment.
   */
  description?: string;

  /**
   * ARM resource ID or AssetId of the environment specification for the endpoint deployment.
   */
  environmentId?: string;

  /**
   * Environment variables configuration for the deployment.
   */
  environmentVariables?: Record<string>;

  /**
   * Property dictionary. Properties can be added, but not removed or altered.
   */
  properties?: Record<string>;
}

/**
 * Keys for endpoint authentication.
 */
model EndpointAuthKeys {
  /**
   * The primary key.
   */
  @visibility("read", "create")
  primaryKey?: string;

  /**
   * The secondary key.
   */
  @visibility("read", "create")
  secondaryKey?: string;
}

/**
 * Enum to determine endpoint authentication mode.
 */
union EndpointAuthMode {
  string,
  AMLToken: "AMLToken",
  Key: "Key",
  AADToken: "AADToken",
}

/**
 * Configuration for a scoring code asset.
 */
model CodeConfiguration {
  /**
   * ARM resource ID of the code asset.
   */
  @visibility("read", "create")
  codeId?: string;

  /**
   * [Required] The script to execute on startup. eg. "score.py"
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  scoringScript: string;
}

/**
 * State of endpoint provisioning.
 */
union EndpointProvisioningState {
  string,
  Creating: "Creating",
  Deleting: "Deleting",
  Succeeded: "Succeeded",
  Failed: "Failed",
  Updating: "Updating",
  Canceled: "Canceled",
}

model RequestLogging {
  /**
   * For payload logging, we only collect payload by default. If customers also want to collect the specified headers, they can set them in captureHeaders so that backend will collect those headers along with payload.
   */
  captureHeaders?: string[];
}

/**
 * Service Token
 */
model EndpointAuthToken {
  /**
   * Access token for endpoint authentication.
   */
  accessToken?: string;

  /**
   * Access token expiry time (UTC).
   */
  expiryTimeUtc?: int64;

  /**
   * Refresh access token after time (UTC).
   */
  refreshAfterTimeUtc?: int64;

  /**
   * Access token type.
   */
  tokenType?: string;
}

model RegenerateEndpointKeysRequest {
  /**
   * [Required] Specification for which type of key to generate. Primary or Secondary.
   */
  keyType: KeyType;

  /**
   * The value the key is set to.
   */
  keyValue?: string;
}

model DeploymentLogsRequest {
  /**
   * The type of container to retrieve logs from.
   */
  containerType?: ContainerType;

  /**
   * The maximum number of lines to tail.
   */
  tail?: int32;
}

model DeploymentLogs {
  /**
   * The retrieved online deployment logs.
   */
  content?: string;
}

union ContainerType {
  string,
  StorageInitializer: "StorageInitializer",
  InferenceServer: "InferenceServer",
}
/**
 * Online endpoint/deployment specific models.
 */
/**
 * Online endpoint configuration
 */
model OnlineEndpoint extends EndpointBase {
  /**
   * ARM resource ID of the compute if it exists.
   * optional
   */
  compute?: string;

  /**
   * Percentage of traffic to be mirrored to each deployment without using returned scoring. Traffic values need to sum to utmost 50.
   */
  mirrorTraffic?: Record<int32>;

  /**
   * Provisioning state for the endpoint.
   */
  @visibility("read")
  provisioningState?: EndpointProvisioningState;

  /**
   * Set to "Enabled" for endpoints that should allow public access when Private Link is enabled.
   */
  publicNetworkAccess?: PublicNetworkAccessType;

  /**
   * Percentage of traffic from endpoint to divert to each deployment. Traffic values need to sum to 100.
   */
  traffic?: Record<int32>;
}

model OnlineDeployment extends EndpointDeploymentBase {
  /**
   * If true, enables Application Insights logging.
   */
  appInsightsEnabled?: boolean;

  /**
   * The mdc configuration, we disable mdc when it's null.
   */
  dataCollector?: DataCollector;

  /**
   * If Enabled, allow egress public network access. If Disabled, this will create secure egress. Default: Enabled.
   */
  egressPublicNetworkAccess?: EgressPublicNetworkAccessType;

  /**
   * Compute instance type.
   */
  @visibility("read", "create")
  instanceType?: string;

  /**
   * Liveness probe monitors the health of the container regularly.
   */
  livenessProbe?: ProbeSettings;

  /**
   * The URI path to the model.
   */
  `model`?: string;

  /**
   * The path to mount the model in custom container.
   */
  modelMountPath?: string;

  /**
   * Provisioning state for the endpoint deployment.
   */
  @visibility("read")
  provisioningState?: DeploymentProvisioningState;

  /**
   * Readiness probe validates if the container is ready to serve traffic. The properties and defaults are the same as liveness probe.
   */
  readinessProbe?: ProbeSettings;

  /**
   * Request settings for the deployment.
   */
  requestSettings?: OnlineRequestSettings;

  /**
   * Scale settings for the deployment.
   * If it is null or not provided,
   * it defaults to TargetUtilizationScaleSettings for KubernetesOnlineDeployment
   * and to DefaultScaleSettings for ManagedOnlineDeployment.
   */
  scaleSettings?: OnlineScaleSettings;
}

@doc("Paged collection of OnlineEndpoint items.")
@pagedResult
model PagedOnlineEndpoint {
  @doc("The list of Online Endpoints.")
  @extension("x-ms-identifiers", [])
  @items
  value: OnlineEndpoint[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<OnlineEndpoint>;
}

@doc("Paged collection of OnlineDeployment items.")
@pagedResult
model PagedOnlineDeployment {
  @doc("The list of Online Deployments.")
  @extension("x-ms-identifiers", [])
  @items
  value: OnlineDeployment[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<OnlineDeployment>;
}

union RollingRateType {
  string,
  Year: "Year",
  Month: "Month",
  Day: "Day",
  Hour: "Hour",
  Minute: "Minute",
}

model DataCollector {
  /**
   * [Required] The collection configuration. Each collection has it own configuration to collect model data and the name of collection can be arbitrary string.
   * Model data collector can be used for either payload logging or custom logging or both of them. Collection request and response are reserved for payload logging, others are for custom logging.
   */
  collections: Record<Collection>;

  /**
   * The request logging configuration for mdc, it includes advanced logging settings for all collections. It's optional.
   */
  requestLogging?: RequestLogging;

  /**
   * When model data is collected to blob storage, we need to roll the data to different path to avoid logging all of them in a single blob file.
   * If the rolling rate is hour, all data will be collected in the blob path /yyyy/MM/dd/HH/.
   * If it's day, all data will be collected in blob path /yyyy/MM/dd/.
   * The other benefit of rolling path is that model monitoring ui is able to select a time range of data very quickly.
   */
  rollingRate?: RollingRateType;
}

union DataCollectionMode {
  string,
  Enabled: "Enabled",
  Disabled: "Disabled",
}

model Collection {
  /**
   * The msi client id used to collect logging to blob storage. If it's null,backend will pick a registered endpoint identity to auth.
   */
  clientId?: string;

  /**
   * Enable or disable data collection.
   */
  dataCollectionMode?: DataCollectionMode;

  /**
   * The data asset arm resource id. Client side will ensure data asset is pointing to the blob storage, and backend will collect data to the blob storage.
   */
  dataId?: string;

  /**
   * The sampling rate for collection. Sampling rate 1.0 means we collect 100% of data by default.
   */
  samplingRate?: float64 = 1;
}

/**
 * Deployment container liveness/readiness probe configuration.
 */
model ProbeSettings {
  /**
   * The number of failures to allow before returning an unhealthy status.
   */
  failureThreshold?: int32 = 30;

  /**
   * The delay before the first probe in ISO 8601 format.
   */
  initialDelay?: duration;

  /**
   * The length of time between probes in ISO 8601 format.
   */
  period?: duration;

  /**
   * The number of successful probes before returning a healthy status.
   */
  successThreshold?: int32 = 1;

  /**
   * The probe timeout in ISO 8601 format.
   */
  timeout?: duration;
}

/**
 * Possible values for DeploymentProvisioningState.
 */
union DeploymentProvisioningState {
  string,
  Creating: "Creating",
  Deleting: "Deleting",
  Scaling: "Scaling",
  Updating: "Updating",
  Succeeded: "Succeeded",
  Failed: "Failed",
  Canceled: "Canceled",
}

/**
 * Online deployment scoring requests configuration.
 */
model OnlineRequestSettings {
  /**
   * The number of maximum concurrent requests per node allowed per deployment. Defaults to 1.
   */
  maxConcurrentRequestsPerInstance?: int32 = 1;

  /**
   * (Deprecated for Managed Online Endpoints) The maximum amount of time a request will stay in the queue in ISO 8601 format.
   * Defaults to 500ms.
   * (Now increase `request_timeout_ms` to account for any networking/queue delays)
   */
  maxQueueWait?: duration;

  /**
   * The scoring timeout in ISO 8601 format.
   * Defaults to 5000ms.
   */
  requestTimeout?: duration;
}

/**
 * Online deployment scaling configuration.
 */
@discriminator("scaleType")
model OnlineScaleSettings {}

/**
 * Batch endpoint/deployment specific models.
 */
/**
 * Batch endpoint configuration.
 */
model BatchEndpoint extends EndpointBase {
  /**
   * Default values for Batch Endpoint
   */
  defaults?: BatchEndpointDefaults;

  /**
   * Provisioning state for the endpoint.
   */
  @visibility("read")
  provisioningState?: EndpointProvisioningState;
}

@doc("Paged collection of BatchEndpoint items.")
@pagedResult
model PagedBatchEndpoint {
  @doc("The list of Batch Endpoints.")
  @extension("x-ms-identifiers", [])
  @items
  value: BatchEndpoint[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<BatchEndpoint>;
}

/**
 * Batch inference settings per deployment.
 */
model BatchDeployment extends EndpointDeploymentBase {
  /**
   * Compute target for batch inference operation.
   */
  compute?: string;

  /**
   * Properties relevant to different deployment types.
   */
  deploymentConfiguration?: BatchDeploymentConfiguration;

  /**
   * Error threshold, if the error count for the entire input goes above this value,
   * the batch inference will be aborted. Range is [-1, int.MaxValue].
   * For FileDataset, this value is the count of file failures.
   * For TabularDataset, this value is the count of record failures.
   * If set to -1 (the lower bound), all failures during batch inference will be ignored.
   */
  errorThreshold?: int32 = -1;

  /**
   * Logging level for batch inference operation.
   */
  loggingLevel?: BatchLoggingLevel;

  /**
   * Indicates maximum number of parallelism per instance.
   */
  maxConcurrencyPerInstance?: int32 = 1;

  /**
   * Size of the mini-batch passed to each batch invocation.
   * For FileDataset, this is the number of files per mini-batch.
   * For TabularDataset, this is the size of the records in bytes, per mini-batch.
   */
  miniBatchSize?: int64 = 10;

  /**
   * Reference to the model asset for the endpoint deployment.
   */
  `model`?: AssetReferenceBase;

  /**
   * Indicates how the output will be organized.
   */
  outputAction?: BatchOutputAction;

  /**
   * Customized output file name for append_row output action.
   */
  outputFileName?: string = "predictions.csv";

  /**
   * Provisioning state for the endpoint deployment.
   */
  @visibility("read")
  provisioningState?: DeploymentProvisioningState;

  /**
   * Indicates compute configuration for the job.
   * If not provided, will default to the defaults defined in ResourceConfiguration.
   */
  resources?: DeploymentResourceConfiguration;

  /**
   * Retry Settings for the batch inference operation.
   * If not provided, will default to the defaults defined in BatchRetrySettings.
   */
  retrySettings?: BatchRetrySettings;
}

@doc("Paged collection of BatchDeployment items.")
@pagedResult
model PagedBatchDeployment {
  @doc("The list of Batch Deployments.")
  @extension("x-ms-identifiers", [])
  @items
  value: BatchDeployment[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<BatchDeployment>;
}

/**
 * Strictly used in update requests.
 */
model PartialBatchDeploymentPartialMinimalTrackedResourceWithProperties {
  /**
   * Additional attributes of the entity.
   */
  properties?: PartialBatchDeployment;

  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * Mutable batch inference settings per deployment.
 */
model PartialBatchDeployment {
  /**
   * Description of the endpoint deployment.
   */
  description?: string;
}

/**
 * Batch endpoint default values
 */
model BatchEndpointDefaults {
  /**
   * Name of the deployment that will be default for the endpoint.
   * This deployment will end up getting 100% traffic when the endpoint scoring URL is invoked.
   */
  deploymentName?: string;
}

/**
 * Properties relevant to different deployment types.
 */
@discriminator("deploymentConfigurationType")
model BatchDeploymentConfiguration {}

/**
 * Log verbosity for batch inferencing.
 * Increasing verbosity order for logging is : Warning, Info and Debug.
 * The default value is Info.
 */
union BatchLoggingLevel {
  string,
  Info: "Info",
  Warning: "Warning",
  Debug: "Debug",
}

/**
 * Enum to determine how batch inferencing will handle output
 */
union BatchOutputAction {
  string,
  SummaryOnly: "SummaryOnly",
  AppendRow: "AppendRow",
}

model DeploymentResourceConfiguration extends ResourceConfiguration {}

model ResourceConfiguration {
  /**
   * Optional number of instances or nodes used by the compute target.
   */
  @visibility("read", "create")
  instanceCount?: int32 = 1;

  /**
   * Optional type of VM used as supported by the compute target.
   */
  @visibility("read", "create")
  instanceType?: string;

  /**
   * Additional properties bag.
   */
  @visibility("read", "create")
  properties?: Record<Record<unknown>>;
}

/**
 * Retry settings for a batch inference operation.
 */
model BatchRetrySettings {
  /**
   * Maximum retry count for a mini-batch
   */
  maxRetries?: int32 = 3;

  /**
   * Invocation timeout for a mini-batch, in ISO 8601 format.
   */
  timeout?: duration;
}
