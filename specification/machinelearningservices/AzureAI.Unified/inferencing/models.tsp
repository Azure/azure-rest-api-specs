import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../main.tsp";
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

@doc("Inference Endpoint base definition")
model EndpointBase {
  @doc("[Required] Use 'Key' for key based authentication and 'AMLToken' for Azure Machine Learning token-based authentication. 'Key' doesn't expire but 'AMLToken' does.")
  authMode: EndpointAuthMode;

  @doc("Description of the inference endpoint.")
  description?: string;

  @doc("EndpointAuthKeys to set initially on an Endpoint. This property will always be returned as null. AuthKey values must be retrieved using the ListKeys API.")
  @visibility("create")
  keys?: EndpointAuthKeys;

  @doc("Property dictionary. Properties can be added, but not removed or altered.")
  properties?: Record<string>;

  @doc("Endpoint URI.")
  @visibility("read")
  scoringUri?: url;

  @doc("Endpoint Swagger URI.")
  @visibility("read")
  swaggerUri?: url;
}

@doc("Base definition for endpoint deployment.")
model EndpointDeploymentBase {
  @doc("Code configuration for the endpoint deployment.")
  codeConfiguration?: CodeConfiguration;

  @doc("Description of the endpoint deployment.")
  description?: string;

  @doc("ARM resource ID or AssetId of the environment specification for the endpoint deployment.")
  environmentId?: string;

  @doc("Environment variables configuration for the deployment.")
  environmentVariables?: Record<string>;

  @doc("Property dictionary. Properties can be added, but not removed or altered.")
  properties?: Record<string>;
}

@doc("Keys for endpoint authentication.")
model EndpointAuthKeys {
  @doc("The primary key.")
  @visibility("read", "create")
  primaryKey?: string;

  @doc("The secondary key.")
  @visibility("read", "create")
  secondaryKey?: string;
}

@doc("Enum to determine endpoint authentication mode.")
union EndpointAuthMode {
  string,

  @doc("AMLToken")
  AMLToken: "AMLToken",

  @doc("Key")
  Key: "Key",

  @doc("AADToken")
  AADToken: "AADToken",
}

@doc("Configuration for a scoring code asset.")
model CodeConfiguration {
  @doc("ARM resource ID of the code asset.")
  @visibility("read", "create")
  codeId?: string;

  @doc("[Required] The script to execute on startup. eg. 'score.py'")
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  scoringScript: string;
}

@doc("State of endpoint provisioning.")
union EndpointProvisioningState {
  string,

  @doc("The endpoint is being created.")
  Creating: "Creating",

  @doc("The endpoint is being deleted.")
  Deleting: "Deleting",

  @doc("The endpoint provisioning succeeded.")
  Succeeded: "Succeeded",

  @doc("The endpoint provisioning failed.")
  Failed: "Failed",

  @doc("The endpoint is being updated.")
  Updating: "Updating",

  @doc("The endpoint provisioning was canceled.")
  Canceled: "Canceled",
}

@doc("Definition for RequestLogging.")
model RequestLogging {
  @doc("For payload logging, we only collect payload by default. If customers also want to collect the specified headers, they can set them in captureHeaders so that backend will collect those headers along with payload.")
  captureHeaders?: string[];
}

@doc("Service Token")
model EndpointAuthToken {
  @doc("Access token for endpoint authentication.")
  accessToken?: string;

  @doc("Access token expiry time (UTC).")
  expiryTimeUtc?: int64;

  @doc("Refresh access token after time (UTC).")
  refreshAfterTimeUtc?: int64;

  @doc("Access token type.")
  tokenType?: string;
}

@doc("Request to regenerate endpoint keys.")
model RegenerateEndpointKeysRequest {
  @doc("[Required] Specification for which type of key to generate. Primary or Secondary.")
  keyType: KeyType;

  @doc("The value the key is set to.")
  keyValue?: string;
}

@doc("Request to get deployment logs.")
model DeploymentLogsRequest {
  @doc("The type of container to retrieve logs from.")
  containerType?: ContainerType;

  @doc("The maximum number of lines to tail.")
  tail?: int32;
}

@doc("Deployment logs.")
model DeploymentLogs {
  @doc("The retrieved online deployment logs.")
  content?: string;
}

@doc("Container types.")
union ContainerType {
  string,

  @doc("StorageInitializer")
  StorageInitializer: "StorageInitializer",

  @doc("InferenceServer")
  InferenceServer: "InferenceServer",
}

@doc("Online endpoint configuration")
model OnlineEndpoint extends EndpointBase {
  @doc("ARM resource ID of the compute if it exists. optional")
  compute?: string;

  @doc("Percentage of traffic to be mirrored to each deployment without using returned scoring. Traffic values need to sum to utmost 50.")
  mirrorTraffic?: Record<int32>;

  @doc("Provisioning state for the endpoint.")
  @visibility("read")
  provisioningState?: EndpointProvisioningState;

  @doc("Set to 'Enabled' for endpoints that should allow public access when Private Link is enabled.")
  publicNetworkAccess?: PublicNetworkAccessType;

  @doc("Percentage of traffic from endpoint to divert to each deployment. Traffic values need to sum to 100.")
  traffic?: Record<int32>;
}

model OnlineDeployment extends EndpointDeploymentBase {
  @doc("If true, enables Application Insights logging.")
  appInsightsEnabled?: boolean;

  @doc("The mdc configuration, we disable mdc when it's null.")
  dataCollector?: DataCollector;

  @doc("If Enabled, allow egress public network access. If Disabled, this will create secure egress. Default: Enabled.")
  egressPublicNetworkAccess?: EgressPublicNetworkAccessType;

  @doc("Compute instance type.")
  @visibility("read", "create")
  instanceType?: string;

  @doc("Liveness probe monitors the health of the container regularly.")
  livenessProbe?: ProbeSettings;

  @doc("The URI path to the model.")
  `model`?: string;

  @doc("The path to mount the model in custom container.")
  modelMountPath?: string;

  @doc("Provisioning state for the endpoint deployment.")
  @visibility("read")
  provisioningState?: DeploymentProvisioningState;

  @doc("Readiness probe validates if the container is ready to serve traffic. The properties and defaults are the same as liveness probe.")
  readinessProbe?: ProbeSettings;

  @doc("Request settings for the deployment.")
  requestSettings?: OnlineRequestSettings;

  @doc("Scale settings for the deployment. If it is null or not provided, it defaults to TargetUtilizationScaleSettings for KubernetesOnlineDeployment and to DefaultScaleSettings for ManagedOnlineDeployment.")
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

@doc("Rolling rate type")
union RollingRateType {
  string,

  @doc("Year")
  Year: "Year",

  @doc("Month")
  Month: "Month",

  @doc("Day")
  Day: "Day",

  @doc("Hour")
  Hour: "Hour",

  @doc("Minute")
  Minute: "Minute",
}

@doc("Data collector definition.")
model DataCollector {
  @doc("[Required] The collection configuration. Each collection has it own configuration to collect model data and the name of collection can be arbitrary string. Model data collector can be used for either payload logging or custom logging or both of them. Collection request and response are reserved for payload logging, others are for custom logging.")
  collections: Record<Collection>;

  @doc("The request logging configuration for mdc, it includes advanced logging settings for all collections. It's optional.")
  requestLogging?: RequestLogging;

  @doc("When model data is collected to blob storage, we need to roll the data to different path to avoid logging all of them in a single blob file. If the rolling rate is hour, all data will be collected in the blob path /yyyy/MM/dd/HH/. If it's day, all data will be collected in blob path /yyyy/MM/dd/. The other benefit of rolling path is that model monitoring ui is able to select a time range of data very quickly.")
  rollingRate?: RollingRateType;
}

@doc("Data collection mode")
union DataCollectionMode {
  string,

  @doc("Enabled")
  Enabled: "Enabled",

  @doc("Disabled")
  Disabled: "Disabled",
}

@doc("Collection definition.")
model Collection {
  @doc("The msi client id used to collect logging to blob storage. If it's null,backend will pick a registered endpoint identity to auth.")
  clientId?: string;

  @doc("Enable or disable data collection.")
  dataCollectionMode?: DataCollectionMode;

  @doc("The data asset arm resource id. Client side will ensure data asset is pointing to the blob storage, and backend will collect data to the blob storage.")
  dataId?: string;

  @doc("The sampling rate for collection. Sampling rate 1.0 means we collect 100% of data by default.")
  samplingRate?: float64 = 1;
}

@doc("Deployment container liveness/readiness probe configuration.")
model ProbeSettings {
  @doc("The number of failures to allow before returning an unhealthy status.")
  failureThreshold?: int32 = 30;

  @doc("The delay before the first probe in ISO 8601 format.")
  initialDelay?: duration;

  @doc("The length of time between probes in ISO 8601 format.")
  period?: duration;

  @doc("The number of successful probes before returning a healthy status.")
  successThreshold?: int32 = 1;

  @doc("The probe timeout in ISO 8601 format.")
  timeout?: duration;
}

@doc("Possible values for DeploymentProvisioningState.")
union DeploymentProvisioningState {
  string,

  @doc("The endpoint is being created.")
  Creating: "Creating",

  @doc("The endpoint is being deleted.")
  Deleting: "Deleting",

  @doc("The endpoint is being scaled.")
  Scaling: "Scaling",

  @doc("The endpoint is being updated.")
  Updating: "Updating",

  @doc("The endpoint provisioning succeeded.")
  Succeeded: "Succeeded",

  @doc("The endpoint provisioning failed.")
  Failed: "Failed",

  @doc("The endpoint provisioning was canceled.")
  Canceled: "Canceled",
}

@doc("Online deployment scoring requests configuration.")
model OnlineRequestSettings {
  @doc("The number of maximum concurrent requests per node allowed per deployment. Defaults to 1.")
  maxConcurrentRequestsPerInstance?: int32 = 1;

  @doc("(Deprecated for Managed Online Endpoints) The maximum amount of time a request will stay in the queue in ISO 8601 format. Defaults to 500ms. (Now increase `request_timeout_ms` to account for any networking/queue delays)")
  maxQueueWait?: duration;

  @doc("The scoring timeout in ISO 8601 format. Defaults to 5000ms.")
  requestTimeout?: duration;
}

@doc("Online deployment scaling configuration.")
@discriminator("scaleType")
model OnlineScaleSettings {}

@doc("Batch endpoint/deployment specific models.")
@doc("Batch endpoint configuration.")
model BatchEndpoint extends EndpointBase {
  @doc("Default values for Batch Endpoint")
  defaults?: BatchEndpointDefaults;

  @doc("Provisioning state for the endpoint.")
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

@doc("Batch inference settings per deployment.")
model BatchDeployment extends EndpointDeploymentBase {
  @doc("Compute target for batch inference operation.")
  compute?: string;

  @doc("Properties relevant to different deployment types.")
  deploymentConfiguration?: BatchDeploymentConfiguration;

  @doc("Error threshold, if the error count for the entire input goes above this value, the batch inference will be aborted. Range is [-1, int.MaxValue]. For FileDataset, this value is the count of file failures. For TabularDataset, this value is the count of record failures. If set to -1 (the lower bound), all failures during batch inference will be ignored.")
  errorThreshold?: int32 = -1;

  @doc("Logging level for batch inference operation.")
  loggingLevel?: BatchLoggingLevel;

  @doc("Indicates maximum number of parallelism per instance.")
  maxConcurrencyPerInstance?: int32 = 1;

  @doc("Size of the mini-batch passed to each batch invocation. For FileDataset, this is the number of files per mini-batch. For TabularDataset, this is the size of the records in bytes, per mini-batch.")
  miniBatchSize?: int64 = 10;

  @doc("Reference to the model asset for the endpoint deployment.")
  `model`?: AssetReferenceBase;

  @doc("Indicates how the output will be organized.")
  outputAction?: BatchOutputAction;

  @doc("Customized output file name for append_row output action.")
  outputFileName?: string = "predictions.csv";

  @doc("Provisioning state for the endpoint deployment.")
  @visibility("read")
  provisioningState?: DeploymentProvisioningState;

  @doc("Indicates compute configuration for the job. If not provided, will default to the defaults defined in ResourceConfiguration.")
  resources?: DeploymentResourceConfiguration;

  @doc("Retry Settings for the batch inference operation. If not provided, will default to the defaults defined in BatchRetrySettings.")
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

@doc("Strictly used in update requests.")
model PartialBatchDeploymentPartialMinimalTrackedResourceWithProperties {
  @doc("Additional attributes of the entity.")
  properties?: PartialBatchDeployment;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Mutable batch inference settings per deployment.")
model PartialBatchDeployment {
  @doc("Description of the endpoint deployment.")
  description?: string;
}

@doc("Batch endpoint default values")
model BatchEndpointDefaults {
  @doc("Name of the deployment that will be default for the endpoint. This deployment will end up getting 100% traffic when the endpoint scoring URL is invoked.")
  deploymentName?: string;
}

@doc("Properties relevant to different deployment types.")
@discriminator("deploymentConfigurationType")
model BatchDeploymentConfiguration {}

@doc("Log verbosity for batch inferencing. Increasing verbosity order for logging is : Warning, Info and Debug. The default value is Info.")
union BatchLoggingLevel {
  string,

  @doc("Info level logging.")
  Info: "Info",

  @doc("Warning level logging.")
  Warning: "Warning",

  @doc("Debug level logging.")
  Debug: "Debug",
}

@doc("Enum to determine how batch inferencing will handle output")
union BatchOutputAction {
  string,

  @doc("SummaryOnly")
  SummaryOnly: "SummaryOnly",

  @doc("AppendRow")
  AppendRow: "AppendRow",
}

model DeploymentResourceConfiguration extends ResourceConfiguration {}

model ResourceConfiguration {
  @doc("Optional number of instances or nodes used by the compute target.")
  @visibility("read", "create")
  instanceCount?: int32 = 1;

  @doc("Optional type of VM used as supported by the compute target.")
  @visibility("read", "create")
  instanceType?: string;

  @doc("Additional properties bag.")
  @visibility("read", "create")
  properties?: Record<Record<unknown>>;
}

@doc("Retry settings for a batch inference operation.")
model BatchRetrySettings {
  @doc("Maximum retry count for a mini-batch")
  maxRetries?: int32 = 3;

  @doc("Invocation timeout for a mini-batch, in ISO 8601 format.")
  timeout?: duration;
}
