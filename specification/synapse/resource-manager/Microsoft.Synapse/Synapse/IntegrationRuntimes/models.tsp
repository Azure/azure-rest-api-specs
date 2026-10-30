import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.Foundations;

namespace IntegrationRuntimes;

/**
 * The state of integration runtime auto update.
 */
union IntegrationRuntimeAutoUpdate {
  string,

  /**
   * On
   */
  On: "On",

  /**
   * Off
   */
  Off: "Off",
}

/**
 * The type of integration runtime.
 */
union IntegrationRuntimeType {
  string,

  /**
   * Managed
   */
  Managed: "Managed",

  /**
   * SelfHosted
   */
  SelfHosted: "SelfHosted",
}

/**
 * The type of SSIS object metadata.
 */
union SsisObjectMetadataType {
  string,

  /**
   * Folder
   */
  Folder: "Folder",

  /**
   * Project
   */
  Project: "Project",

  /**
   * Package
   */
  Package: "Package",

  /**
   * Environment
   */
  Environment: "Environment",
}

/**
 * Status of the integration runtime node.
 */
union SelfHostedIntegrationRuntimeNodeStatus {
  string,

  /**
   * NeedRegistration
   */
  NeedRegistration: "NeedRegistration",

  /**
   * Online
   */
  Online: "Online",

  /**
   * Limited
   */
  Limited: "Limited",

  /**
   * Offline
   */
  Offline: "Offline",

  /**
   * Upgrading
   */
  Upgrading: "Upgrading",

  /**
   * Initializing
   */
  Initializing: "Initializing",

  /**
   * InitializeFailed
   */
  InitializeFailed: "InitializeFailed",
}

/**
 * The result of the last integration runtime node update.
 */
union IntegrationRuntimeUpdateResult {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Succeed
   */
  Succeed: "Succeed",

  /**
   * Fail
   */
  Fail: "Fail",
}

/**
 * The state of integration runtime.
 */
union IntegrationRuntimeState {
  string,

  /**
   * Initial
   */
  Initial: "Initial",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Started
   */
  Started: "Started",

  /**
   * Starting
   */
  Starting: "Starting",

  /**
   * Stopping
   */
  Stopping: "Stopping",

  /**
   * NeedRegistration
   */
  NeedRegistration: "NeedRegistration",

  /**
   * Online
   */
  Online: "Online",

  /**
   * Limited
   */
  Limited: "Limited",

  /**
   * Offline
   */
  Offline: "Offline",

  /**
   * AccessDenied
   */
  AccessDenied: "AccessDenied",
}

/**
 * The name of the authentication key to regenerate.
 */
union IntegrationRuntimeAuthKeyName {
  string,

  /**
   * authKey1
   */
  authKey1: "authKey1",

  /**
   * authKey2
   */
  authKey2: "authKey2",
}

/**
 * status of Start Integrationruntimes.
 */
union WorkspaceStatus {
  string,

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Compute type of the cluster which will execute data flow job.
 */
union DataFlowComputeType {
  string,

  /**
   * General
   */
  General: "General",

  /**
   * MemoryOptimized
   */
  MemoryOptimized: "MemoryOptimized",

  /**
   * ComputeOptimized
   */
  ComputeOptimized: "ComputeOptimized",
}

/**
 * The pricing tier for the catalog database. The valid values could be found in https://azure.microsoft.com/en-us/pricing/details/sql-database/
 */
union IntegrationRuntimeSsisCatalogPricingTier {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * Premium
   */
  Premium: "Premium",

  /**
   * PremiumRS
   */
  PremiumRS: "PremiumRS",
}

/**
 * License type for bringing your own license scenario.
 */
union IntegrationRuntimeLicenseType {
  string,

  /**
   * BasePrice
   */
  BasePrice: "BasePrice",

  /**
   * LicenseIncluded
   */
  LicenseIncluded: "LicenseIncluded",
}

/**
 * The type of this referenced entity.
 */
union IntegrationRuntimeEntityReferenceType {
  string,

  /**
   * IntegrationRuntimeReference
   */
  IntegrationRuntimeReference: "IntegrationRuntimeReference",

  /**
   * LinkedServiceReference
   */
  LinkedServiceReference: "LinkedServiceReference",
}

/**
 * The edition for the SSIS Integration Runtime
 */
union IntegrationRuntimeEdition {
  string,

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * Enterprise
   */
  Enterprise: "Enterprise",
}

/**
 * The managed integration runtime node status.
 */
union ManagedIntegrationRuntimeNodeStatus {
  string,

  /**
   * Starting
   */
  Starting: "Starting",

  /**
   * Available
   */
  Available: "Available",

  /**
   * Recycling
   */
  Recycling: "Recycling",

  /**
   * Unavailable
   */
  Unavailable: "Unavailable",
}

/**
 * It is used to set the encryption mode for node-node communication channel (when more than 2 self-hosted integration runtime nodes exist).
 */
union IntegrationRuntimeInternalChannelEncryptionMode {
  string,

  /**
   * NotSet
   */
  NotSet: "NotSet",

  /**
   * SslEncrypted
   */
  SslEncrypted: "SslEncrypted",

  /**
   * NotEncrypted
   */
  NotEncrypted: "NotEncrypted",
}

/**
 * Update integration runtime request.
 */
model UpdateIntegrationRuntimeRequest {
  /**
   * Enables or disables the auto-update feature of the self-hosted integration runtime. See https://go.microsoft.com/fwlink/?linkid=854189.
   */
  autoUpdate?: IntegrationRuntimeAutoUpdate;

  /**
   * The time offset (in hours) in the day, e.g., PT03H is 3 hours. The integration runtime auto update will happen on that time.
   */
  updateDelayOffset?: string;
}

/**
 * Azure Synapse nested object which serves as a compute resource for activities.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
@discriminator("type")
model IntegrationRuntime {
  ...Record<unknown>;

  /**
   * Type of integration runtime.
   */
  type: IntegrationRuntimeType;

  /**
   * Integration runtime description.
   */
  description?: string;
}

/**
 * Azure Synapse nested resource, which belongs to a workspace.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SubResource extends AzureEntityResource {}

/**
 * The IP address of self-hosted integration runtime node.
 */
model IntegrationRuntimeNodeIpAddress {
  /**
   * The IP address of self-hosted integration runtime node.
   */
  @visibility(Lifecycle.Read)
  ipAddress?: string;
}

/**
 * The request payload of get SSIS object metadata.
 */
model GetSsisObjectMetadataRequest {
  /**
   * Metadata path.
   */
  metadataPath?: string;
}

/**
 * A list of SSIS object metadata.
 */
model SsisObjectMetadataListResponse {
  /**
   * List of SSIS object metadata.
   */
  value?: SsisObjectMetadata[];

  /**
   * The link to the next page of results, if any remaining results exist.
   */
  nextLink?: string;
}

/**
 * SSIS object metadata.
 */
@discriminator("type")
model SsisObjectMetadata {
  /**
   * Type of metadata.
   */
  type: SsisObjectMetadataType;

  /**
   * Metadata id.
   */
  id?: int64;

  /**
   * Metadata name.
   */
  name?: string;

  /**
   * Metadata description.
   */
  description?: string;
}

/**
 * Properties of Self-hosted integration runtime node.
 */
model SelfHostedIntegrationRuntimeNode {
  ...Record<unknown>;

  /**
   * Name of the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  nodeName?: string;

  /**
   * Machine name of the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  machineName?: string;

  /**
   * URI for the host machine of the integration runtime.
   */
  @visibility(Lifecycle.Read)
  hostServiceUri?: string;

  /**
   * Status of the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  status?: SelfHostedIntegrationRuntimeNodeStatus;

  /**
   * The integration runtime capabilities dictionary
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  capabilities?: Record<string>;

  /**
   * Status of the integration runtime node version.
   */
  @visibility(Lifecycle.Read)
  versionStatus?: string;

  /**
   * Version of the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The time at which the integration runtime node was registered in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  registerTime?: utcDateTime;

  /**
   * The most recent time at which the integration runtime was connected in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastConnectTime?: utcDateTime;

  /**
   * The time at which the integration runtime will expire in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  /**
   * The time the node last started up.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStartTime?: utcDateTime;

  /**
   * The integration runtime node last stop time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStopTime?: utcDateTime;

  /**
   * The result of the last integration runtime node update.
   */
  @visibility(Lifecycle.Read)
  lastUpdateResult?: IntegrationRuntimeUpdateResult;

  /**
   * The last time for the integration runtime node update start.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStartUpdateTime?: utcDateTime;

  /**
   * The last time for the integration runtime node update end.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastEndUpdateTime?: utcDateTime;

  /**
   * Indicates whether this node is the active dispatcher for integration runtime requests.
   */
  @visibility(Lifecycle.Read)
  isActiveDispatcher?: boolean;

  /**
   * Maximum concurrent jobs on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  concurrentJobsLimit?: int32;

  /**
   * The maximum concurrent jobs in this integration runtime.
   */
  @visibility(Lifecycle.Read)
  maxConcurrentJobs?: int32;
}

/**
 * Update integration runtime node request.
 */
model UpdateIntegrationRuntimeNodeRequest {
  /**
   * The number of concurrent jobs permitted to run on the integration runtime node. Values between 1 and maxConcurrentJobs(inclusive) are allowed.
   */
  @minValue(1)
  concurrentJobsLimit?: int32;
}

/**
 * A list of integration runtime resources.
 */
model IntegrationRuntimeListResponse {
  /**
   * List of integration runtimes.
   */
  @pageItems
  value: IntegrationRuntimeResource[];

  /**
   * The link to the next page of results, if any remaining results exist.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Connection information for encrypting the on-premises data source credentials.
 */
model IntegrationRuntimeConnectionInfo {
  ...Record<unknown>;

  /**
   * The token generated in service. Callers use this token to authenticate to integration runtime.
   */
  @visibility(Lifecycle.Read)
  serviceToken?: string;

  /**
   * The integration runtime SSL certificate thumbprint. Click-Once application uses it to do server validation.
   */
  @visibility(Lifecycle.Read)
  identityCertThumbprint?: string;

  /**
   * The on-premises integration runtime host URL.
   */
  @visibility(Lifecycle.Read)
  hostServiceUri?: string;

  /**
   * The integration runtime version.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The public key for encrypting a credential when transferring the credential to the integration runtime.
   */
  @visibility(Lifecycle.Read)
  publicKey?: string;

  /**
   * Whether the identity certificate is expired.
   */
  @visibility(Lifecycle.Read)
  isIdentityCertExprired?: boolean;
}

/**
 * Integration runtime status response.
 */
model IntegrationRuntimeStatusResponse {
  /**
   * The integration runtime name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Integration runtime properties.
   */
  properties: IntegrationRuntimeStatus;
}

/**
 * Integration runtime status.
 */
@discriminator("type")
model IntegrationRuntimeStatus {
  ...Record<unknown>;

  /**
   * Type of integration runtime.
   */
  type: IntegrationRuntimeType;

  /**
   * The workspace name which the integration runtime belong to.
   */
  @visibility(Lifecycle.Read)
  dataFactoryName?: string;

  /**
   * The state of integration runtime.
   */
  @visibility(Lifecycle.Read)
  state?: IntegrationRuntimeState;
}

/**
 * Parameters to regenerate the authentication key.
 */
model IntegrationRuntimeRegenerateKeyParameters {
  /**
   * The name of the authentication key to regenerate.
   */
  keyName?: IntegrationRuntimeAuthKeyName;
}

/**
 * The integration runtime authentication keys.
 */
model IntegrationRuntimeAuthKeys {
  /**
   * The primary integration runtime authentication key.
   */
  authKey1?: string;

  /**
   * The secondary integration runtime authentication key.
   */
  authKey2?: string;
}

/**
 * Get monitoring data response.
 */
model IntegrationRuntimeMonitoringData {
  /**
   * Integration runtime name.
   */
  name?: string;

  /**
   * Integration runtime node monitoring data.
   */
  @identifiers(#[])
  nodes?: IntegrationRuntimeNodeMonitoringData[];
}

/**
 * Monitoring data for integration runtime node.
 */
model IntegrationRuntimeNodeMonitoringData {
  ...Record<unknown>;

  /**
   * Name of the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  nodeName?: string;

  /**
   * Available memory (MB) on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  availableMemoryInMB?: int32;

  /**
   * CPU percentage on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  cpuUtilization?: int32;

  /**
   * Maximum concurrent jobs on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  concurrentJobsLimit?: int32;

  /**
   * The number of jobs currently running on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  concurrentJobsRunning?: int32;

  /**
   * The maximum concurrent jobs in this integration runtime.
   */
  @visibility(Lifecycle.Read)
  maxConcurrentJobs?: int32;

  /**
   * Sent bytes on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  sentBytes?: float32;

  /**
   * Received bytes on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  receivedBytes?: float32;
}

/**
 * The status of the operation.
 */
model SsisObjectMetadataStatusResponse {
  /**
   * The status of the operation.
   */
  status?: string;

  /**
   * The operation name.
   */
  name?: string;

  /**
   * The operation properties.
   */
  properties?: string;

  /**
   * The operation error message.
   */
  error?: string;
}

/**
 * Azure-SSIS integration runtime outbound network dependency endpoints.
 */
model IntegrationRuntimeOutboundNetworkDependenciesEndpointsResponse {
  /**
   * The list of outbound network dependency endpoints.
   */
  @pageItems
  @identifiers(#[])
  value?: IntegrationRuntimeOutboundNetworkDependenciesCategoryEndpoint[];
}

/**
 * Azure-SSIS integration runtime outbound network dependency endpoints for one category.
 */
model IntegrationRuntimeOutboundNetworkDependenciesCategoryEndpoint {
  /**
   * The category of outbound network dependency.
   */
  category?: string;

  /**
   * The endpoints for outbound network dependency.
   */
  @identifiers(#[])
  endpoints?: IntegrationRuntimeOutboundNetworkDependenciesEndpoint[];
}

/**
 * The endpoint for Azure-SSIS integration runtime outbound network dependency.
 */
model IntegrationRuntimeOutboundNetworkDependenciesEndpoint {
  /**
   * The domain name of endpoint.
   */
  domainName?: string;

  /**
   * The details of endpoint.
   */
  @identifiers(#[])
  endpointDetails?: IntegrationRuntimeOutboundNetworkDependenciesEndpointDetails[];
}

/**
 * The details of Azure-SSIS integration runtime outbound network dependency endpoint.
 */
model IntegrationRuntimeOutboundNetworkDependenciesEndpointDetails {
  /**
   * The port of endpoint.
   */
  port?: int32;
}

/**
 * Integration Runtime Operation Status Properties
 */
model IntegrationRuntimeOperationStatus {
  /**
   * status of Start Integrationruntimes.
   */
  status?: WorkspaceStatus;

  /**
   * The operation name.
   */
  name?: string;

  /**
   * The operation properties.
   */
  properties?: unknown;

  /**
   * The operation error message.
   */
  error?: string;
}

/**
 * Integration Runtime Operation Status Properties
 */
model IntegrationRuntimeStopOperationStatus {
  /**
   * status of Start Integrationruntimes.
   */
  status?: WorkspaceStatus;

  /**
   * The operation name.
   */
  name?: string;

  /**
   * The operation properties.
   */
  properties?: unknown;

  /**
   * The operation error message.
   */
  error?: string;
}

/**
 * Integration Runtime Operation Status Properties
 */
model IntegrationRuntimeEnableinteractivequery {
  /**
   * EnableInteractivequery status of  Integrationruntimes.
   */
  status?: WorkspaceStatus;

  /**
   * The operation name.
   */
  name?: string;

  /**
   * The operation properties.
   */
  properties?: unknown;

  /**
   * The operation error message.
   */
  error?: string;
}

/**
 * Managed integration runtime, including managed elastic and managed dedicated integration runtimes.
 */
model ManagedIntegrationRuntime extends IntegrationRuntime {
  /**
   * Integration runtime state, only valid for managed dedicated integration runtime.
   */
  @visibility(Lifecycle.Read)
  state?: IntegrationRuntimeState;

  /**
   * Managed integration runtime properties.
   */
  typeProperties: ManagedIntegrationRuntimeTypeProperties;

  /**
   * Managed integration runtime managed virtual network.
   */
  managedVirtualNetwork?: ManagedIntegrationRuntimeManagedVirtualNetworkReference;

  /**
   * Type of integration runtime.
   */
  type: "Managed";
}

/**
 * Managed integration runtime type properties.
 */
model ManagedIntegrationRuntimeTypeProperties {
  /**
   * The compute resource for managed integration runtime.
   */
  computeProperties?: IntegrationRuntimeComputeProperties;

  /**
   * SSIS properties for managed integration runtime.
   */
  ssisProperties?: IntegrationRuntimeSsisProperties;
}

/**
 * The compute resource properties for managed integration runtime.
 */
model IntegrationRuntimeComputeProperties {
  ...Record<unknown>;

  /**
   * The location for managed integration runtime. The supported regions could be found on https://docs.microsoft.com/en-us/azure/data-factory/data-factory-data-movement-activities
   */
  location?: string;

  /**
   * The node size requirement to managed integration runtime.
   */
  nodeSize?: string;

  /**
   * The required number of nodes for managed integration runtime.
   */
  @minValue(1)
  numberOfNodes?: int32;

  /**
   * Maximum parallel executions count per node for managed integration runtime.
   */
  @minValue(1)
  maxParallelExecutionsPerNode?: int32;

  /**
   * Data flow properties for managed integration runtime.
   */
  dataFlowProperties?: IntegrationRuntimeDataFlowProperties;

  /**
   * VNet properties for managed integration runtime.
   */
  vNetProperties?: IntegrationRuntimeVNetProperties;

  /**
   * CopyComputeScale properties for managed integration runtime.
   */
  copyComputeScaleProperties?: CopyComputeScaleProperties;

  /**
   * PipelineExternalComputeScale properties for managed integration runtime.
   */
  pipelineExternalComputeScaleProperties?: PipelineExternalComputeScaleProperties;
}

/**
 * Data flow properties for managed integration runtime.
 */
model IntegrationRuntimeDataFlowProperties {
  ...Record<unknown>;

  /**
   * Compute type of the cluster which will execute data flow job.
   */
  computeType?: DataFlowComputeType;

  /**
   * Core count of the cluster which will execute data flow job. Supported values are: 8, 16, 32, 48, 80, 144 and 272.
   */
  coreCount?: int32;

  /**
   * Time to live (in minutes) setting of the cluster which will execute data flow job.
   */
  timeToLive?: int32;

  /**
   * Cluster will not be recycled and it will be used in next data flow activity run until TTL (time to live) is reached if this is set as false. Default is true.
   */
  cleanup?: boolean;
}

/**
 * VNet properties for managed integration runtime.
 */
model IntegrationRuntimeVNetProperties {
  ...Record<unknown>;

  /**
   * The ID of the VNet that this integration runtime will join.
   */
  vNetId?: string;

  /**
   * The name of the subnet this integration runtime will join.
   */
  subnet?: string;

  /**
   * Resource IDs of the public IP addresses that this integration runtime will use.
   */
  publicIPs?: string[];

  /**
   * The ID of subnet, to which this Azure-SSIS integration runtime will be joined.
   */
  subnetId?: string;
}

/**
 * CopyComputeScale properties for managed integration runtime.
 */
model CopyComputeScaleProperties {
  /**
   * DIU number setting reserved for copy activity execution. Supported values are multiples of 4 in range 4-256.
   */
  @minValue(4)
  dataIntegrationUnit?: int32;

  /**
   * Time to live (in minutes) setting of integration runtime which will execute copy activity.
   */
  @minValue(5)
  timeToLive?: int32;
}

/**
 * PipelineExternalComputeScale properties for managed integration runtime.
 */
model PipelineExternalComputeScaleProperties {
  /**
   * Time to live (in minutes) setting of integration runtime which will execute pipeline and external activity.
   */
  @minValue(5)
  timeToLive?: int32;

  /**
   * Number of the pipeline nodes, which should be greater than 0 and less than 11.
   */
  @maxValue(10)
  @minValue(1)
  numberOfPipelineNodes?: int32;

  /**
   * Number of the the external nodes, which should be greater than 0 and less than 11.
   */
  @maxValue(10)
  @minValue(1)
  numberOfExternalNodes?: int32;
}

/**
 * SSIS properties for managed integration runtime.
 */
model IntegrationRuntimeSsisProperties {
  ...Record<unknown>;

  /**
   * Catalog information for managed dedicated integration runtime.
   */
  catalogInfo?: IntegrationRuntimeSsisCatalogInfo;

  /**
   * License type for bringing your own license scenario.
   */
  licenseType?: IntegrationRuntimeLicenseType;

  /**
   * Custom setup script properties for a managed dedicated integration runtime.
   */
  customSetupScriptProperties?: IntegrationRuntimeCustomSetupScriptProperties;

  /**
   * Data proxy properties for a managed dedicated integration runtime.
   */
  dataProxyProperties?: IntegrationRuntimeDataProxyProperties;

  /**
   * The edition for the SSIS Integration Runtime
   */
  edition?: IntegrationRuntimeEdition;

  /**
   * Custom setup without script properties for a SSIS integration runtime.
   */
  @identifiers(#[])
  expressCustomSetupProperties?: CustomSetupBase[];
}

/**
 * Catalog information for managed dedicated integration runtime.
 */
model IntegrationRuntimeSsisCatalogInfo {
  ...Record<unknown>;

  /**
   * The catalog database server URL.
   */
  catalogServerEndpoint?: string;

  /**
   * The administrator user name of catalog database.
   */
  @maxLength(128)
  @minLength(1)
  catalogAdminUserName?: string;

  /**
   * The password of the administrator user account of the catalog database.
   */
  catalogAdminPassword?: SecureString;

  /**
   * The pricing tier for the catalog database. The valid values could be found in https://azure.microsoft.com/en-us/pricing/details/sql-database/
   */
  catalogPricingTier?: IntegrationRuntimeSsisCatalogPricingTier;
}

/**
 * Azure Synapse secure string definition. The string value will be masked with asterisks '*' during Get or List API calls.
 */
model SecureString extends SecretBase {
  /**
   * Value of secure string.
   */
  value: string;

  /**
   * Type of the secret.
   */
  type: "SecureString";
}

/**
 * The base definition of a secret type.
 */
@discriminator("type")
model SecretBase {
  /**
   * Type of the secret.
   */
  type: string;
}

/**
 * Custom setup script properties for a managed dedicated integration runtime.
 */
model IntegrationRuntimeCustomSetupScriptProperties {
  /**
   * The URI of the Azure blob container that contains the custom setup script.
   */
  blobContainerUri?: string;

  /**
   * The SAS token of the Azure blob container.
   */
  sasToken?: SecureString;
}

/**
 * Data proxy properties for a managed dedicated integration runtime.
 */
model IntegrationRuntimeDataProxyProperties {
  /**
   * The self-hosted integration runtime reference.
   */
  connectVia?: EntityReference;

  /**
   * The staging linked service reference.
   */
  stagingLinkedService?: EntityReference;

  /**
   * The path to contain the staged data in the Blob storage.
   */
  path?: string;
}

/**
 * The entity reference.
 */
model EntityReference {
  /**
   * The type of this referenced entity.
   */
  type?: IntegrationRuntimeEntityReferenceType;

  /**
   * The name of this referenced entity.
   */
  referenceName?: string;
}

/**
 * The base definition of the custom setup.
 */
@discriminator("type")
model CustomSetupBase {
  /**
   * The type of custom setup.
   */
  type: string;
}

/**
 * Managed integration runtime managed virtual network reference.
 */
model ManagedIntegrationRuntimeManagedVirtualNetworkReference {
  /**
   * The reference name of the managed virtual network.
   */
  referenceName?: string;

  /**
   * The type of the managed virtual network.
   */
  type?: string;

  /**
   * The id of the managed virtual network.
   */
  id?: string;
}

/**
 * The custom setup of running cmdkey commands.
 */
model CmdkeySetup extends CustomSetupBase {
  /**
   * Cmdkey command custom setup type properties.
   */
  typeProperties: CmdkeySetupTypeProperties;

  /**
   * The type of custom setup.
   */
  type: "CmdkeySetup";
}

/**
 * Cmdkey command custom setup type properties.
 */
model CmdkeySetupTypeProperties {
  /**
   * The server name of data source access.
   */
  targetName: unknown;

  /**
   * The user name of data source access.
   */
  userName: unknown;

  /**
   * The password of data source access.
   */
  password: SecretBase;
}

/**
 * The custom setup of setting environment variable.
 */
model EnvironmentVariableSetup extends CustomSetupBase {
  /**
   * Add environment variable type properties.
   */
  typeProperties: EnvironmentVariableSetupTypeProperties;

  /**
   * The type of custom setup.
   */
  type: "EnvironmentVariableSetup";
}

/**
 * Environment variable custom setup type properties.
 */
model EnvironmentVariableSetupTypeProperties {
  /**
   * The name of the environment variable.
   */
  variableName: string;

  /**
   * The value of the environment variable.
   */
  variableValue: string;
}

/**
 * The custom setup of installing 3rd party components.
 */
model ComponentSetup extends CustomSetupBase {
  /**
   * Install 3rd party component type properties.
   */
  typeProperties: LicensedComponentSetupTypeProperties;

  /**
   * The type of custom setup.
   */
  type: "ComponentSetup";
}

/**
 * Installation of licensed component setup type properties.
 */
model LicensedComponentSetupTypeProperties {
  /**
   * The name of the 3rd party component.
   */
  componentName: string;

  /**
   * The license key to activate the component.
   */
  licenseKey?: SecretBase;
}

/**
 * Self-hosted integration runtime.
 */
model SelfHostedIntegrationRuntime extends IntegrationRuntime {
  /**
   * When this property is not null, means this is a linked integration runtime. The property is used to access original integration runtime.
   */
  typeProperties?: SelfHostedIntegrationRuntimeTypeProperties;

  /**
   * Type of integration runtime.
   */
  type: "SelfHosted";
}

/**
 * The self-hosted integration runtime properties.
 */
model SelfHostedIntegrationRuntimeTypeProperties {
  /**
   * Linked integration runtime type from data factory
   */
  linkedInfo?: LinkedIntegrationRuntimeType;

  /**
   * An alternative option to ensure interactive authoring function when your self-hosted integration runtime is unable to establish a connection with Azure Relay.
   */
  selfContainedInteractiveAuthoringEnabled?: boolean;
}

/**
 * The base definition of a linked integration runtime.
 */
@discriminator("authorizationType")
model LinkedIntegrationRuntimeType {
  /**
   * The authorization type for integration runtime sharing.
   */
  authorizationType: string;
}

/**
 * The key authorization type integration runtime.
 */
model LinkedIntegrationRuntimeKeyAuthorization
  extends LinkedIntegrationRuntimeType {
  /**
   * The key used for authorization.
   */
  key: SecureString;

  /**
   * The authorization type for integration runtime sharing.
   */
  authorizationType: "Key";
}

/**
 * The role based access control (RBAC) authorization type integration runtime.
 */
model LinkedIntegrationRuntimeRbacAuthorization
  extends LinkedIntegrationRuntimeType {
  /**
   * The resource identifier of the integration runtime to be shared.
   */
  resourceId: string;

  /**
   * The authorization type for integration runtime sharing.
   */
  authorizationType: "RBAC";
}

/**
 * Managed integration runtime status.
 */
model ManagedIntegrationRuntimeStatus extends IntegrationRuntimeStatus {
  /**
   * Managed integration runtime status type properties.
   */
  typeProperties: ManagedIntegrationRuntimeStatusTypeProperties;

  /**
   * Type of integration runtime.
   */
  type: "Managed";
}

/**
 * Managed integration runtime status type properties.
 */
model ManagedIntegrationRuntimeStatusTypeProperties {
  /**
   * The time at which the integration runtime was created, in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  /**
   * The list of nodes for managed integration runtime.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  nodes?: ManagedIntegrationRuntimeNode[];

  /**
   * The errors that occurred on this integration runtime.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  otherErrors?: ManagedIntegrationRuntimeError[];

  /**
   * The last operation result that occurred on this integration runtime.
   */
  @visibility(Lifecycle.Read)
  lastOperation?: ManagedIntegrationRuntimeOperationResult;
}

/**
 * Properties of integration runtime node.
 */
model ManagedIntegrationRuntimeNode {
  ...Record<unknown>;

  /**
   * The managed integration runtime node id.
   */
  @visibility(Lifecycle.Read)
  nodeId?: string;

  /**
   * The managed integration runtime node status.
   */
  @visibility(Lifecycle.Read)
  status?: ManagedIntegrationRuntimeNodeStatus;

  /**
   * The errors that occurred on this integration runtime node.
   */
  @identifiers(#[])
  errors?: ManagedIntegrationRuntimeError[];
}

/**
 * Error definition for managed integration runtime.
 */
model ManagedIntegrationRuntimeError {
  ...Record<unknown>;

  /**
   * The time when the error occurred.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Managed integration runtime error parameters.
   */
  @visibility(Lifecycle.Read)
  parameters?: string[];

  /**
   * Error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Properties of managed integration runtime operation result.
 */
model ManagedIntegrationRuntimeOperationResult {
  ...Record<unknown>;

  /**
   * The operation type. Could be start or stop.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The start time of the operation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The operation result.
   */
  @visibility(Lifecycle.Read)
  result?: string;

  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /**
   * Managed integration runtime error parameters.
   */
  @visibility(Lifecycle.Read)
  parameters?: string[];

  /**
   * The activity id for the operation request.
   */
  @visibility(Lifecycle.Read)
  activityId?: string;
}

/**
 * Self-hosted integration runtime status.
 */
model SelfHostedIntegrationRuntimeStatus extends IntegrationRuntimeStatus {
  /**
   * Self-hosted integration runtime status type properties.
   */
  typeProperties: SelfHostedIntegrationRuntimeStatusTypeProperties;

  /**
   * Type of integration runtime.
   */
  type: "SelfHosted";
}

/**
 * Self-hosted integration runtime status type properties.
 */
model SelfHostedIntegrationRuntimeStatusTypeProperties {
  /**
   * The time at which the integration runtime was created, in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  /**
   * The task queue id of the integration runtime.
   */
  @visibility(Lifecycle.Read)
  taskQueueId?: string;

  /**
   * The node communication Channel encryption mode
   */
  @visibility(Lifecycle.Read)
  nodeCommunicationChannelEncryptionMode?: string;

  /**
   * It is used to set the encryption mode for node-node communication channel (when more than 2 self-hosted integration runtime nodes exist).
   */
  @visibility(Lifecycle.Read)
  internalChannelEncryption?: IntegrationRuntimeInternalChannelEncryptionMode;

  /**
   * Version of the integration runtime.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The list of nodes for this integration runtime.
   */
  @identifiers(#[])
  nodes?: SelfHostedIntegrationRuntimeNode[];

  /**
   * The date at which the integration runtime will be scheduled to update, in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledUpdateDate?: utcDateTime;

  /**
   * The time in the date scheduled by service to update the integration runtime, e.g., PT03H is 3 hours
   */
  @visibility(Lifecycle.Read)
  updateDelayOffset?: string;

  /**
   * The local time zone offset in hours.
   */
  @visibility(Lifecycle.Read)
  localTimeZoneOffset?: string;

  /**
   * Object with additional information about integration runtime capabilities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  capabilities?: Record<string>;

  /**
   * The URLs for the services used in integration runtime backend service.
   */
  @visibility(Lifecycle.Read)
  serviceUrls?: string[];

  /**
   * Whether Self-hosted integration runtime auto update has been turned on.
   */
  @visibility(Lifecycle.Read)
  autoUpdate?: IntegrationRuntimeAutoUpdate;

  /**
   * Status of the integration runtime version.
   */
  @visibility(Lifecycle.Read)
  versionStatus?: string;

  /**
   * The list of linked integration runtimes that are created to share with this integration runtime.
   */
  @identifiers(#[])
  links?: LinkedIntegrationRuntime[];

  /**
   * The version that the integration runtime is going to update to.
   */
  @visibility(Lifecycle.Read)
  pushedVersion?: string;

  /**
   * The latest version on download center.
   */
  @visibility(Lifecycle.Read)
  latestVersion?: string;

  /**
   * The estimated time when the self-hosted integration runtime will be updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  autoUpdateETA?: utcDateTime;

  /**
   * The service region of the integration runtime
   */
  serviceRegion?: string;

  /**
   * The newer versions on download center.
   */
  newerVersions?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  osType?: int32;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  targetFramework?: int32;

  /**
   * An alternative option to ensure interactive authoring function when your self-hosted integration runtime is unable to establish a connection with Azure Relay.
   */
  @visibility(Lifecycle.Read)
  selfContainedInteractiveAuthoringEnabled?: boolean;
}

/**
 * The linked integration runtime information.
 */
model LinkedIntegrationRuntime {
  /**
   * The name of the linked integration runtime.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The subscription ID for which the linked integration runtime belong to.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * The name of the workspace for which the linked integration runtime belong to.
   */
  @visibility(Lifecycle.Read)
  dataFactoryName?: string;

  /**
   * The location of the workspace for which the linked integration runtime belong to.
   */
  @visibility(Lifecycle.Read)
  dataFactoryLocation?: string;

  /**
   * The creating time of the linked integration runtime.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;
}

/**
 * Ssis folder.
 */
model SsisFolder extends SsisObjectMetadata {
  /**
   * Type of metadata.
   */
  type: "Folder";
}

/**
 * Ssis project.
 */
model SsisProject extends SsisObjectMetadata {
  /**
   * Folder id which contains project.
   */
  folderId?: int64;

  /**
   * Project version.
   */
  version?: int64;

  /**
   * Environment reference in project
   */
  environmentRefs?: SsisEnvironmentReference[];

  /**
   * Parameters in project
   */
  parameters?: SsisParameter[];

  /**
   * Type of metadata.
   */
  type: "Project";
}

/**
 * Ssis environment reference.
 */
model SsisEnvironmentReference {
  /**
   * Environment reference id.
   */
  id?: int64;

  /**
   * Environment folder name.
   */
  environmentFolderName?: string;

  /**
   * Environment name.
   */
  environmentName?: string;

  /**
   * Reference type
   */
  referenceType?: string;
}

/**
 * Ssis parameter.
 */
model SsisParameter {
  /**
   * Parameter id.
   */
  id?: int64;

  /**
   * Parameter name.
   */
  name?: string;

  /**
   * Parameter description.
   */
  description?: string;

  /**
   * Parameter type.
   */
  dataType?: string;

  /**
   * Whether parameter is required.
   */
  required?: boolean;

  /**
   * Whether parameter is sensitive.
   */
  sensitive?: boolean;

  /**
   * Design default value of parameter.
   */
  designDefaultValue?: string;

  /**
   * Default value of parameter.
   */
  defaultValue?: string;

  /**
   * Default sensitive value of parameter.
   */
  sensitiveDefaultValue?: string;

  /**
   * Parameter value type.
   */
  valueType?: string;

  /**
   * Parameter value set.
   */
  valueSet?: boolean;

  /**
   * Parameter reference variable.
   */
  variable?: string;
}

/**
 * Ssis Package.
 */
model SsisPackage extends SsisObjectMetadata {
  /**
   * Folder id which contains package.
   */
  folderId?: int64;

  /**
   * Project version which contains package.
   */
  projectVersion?: int64;

  /**
   * Project id which contains package.
   */
  projectId?: int64;

  /**
   * Parameters in package
   */
  parameters?: SsisParameter[];

  /**
   * Type of metadata.
   */
  type: "Package";
}

/**
 * Ssis environment.
 */
model SsisEnvironment extends SsisObjectMetadata {
  /**
   * Folder id which contains environment.
   */
  folderId?: int64;

  /**
   * Variable in environment
   */
  variables?: SsisVariable[];

  /**
   * Type of metadata.
   */
  type: "Environment";
}

/**
 * Ssis variable.
 */
model SsisVariable {
  /**
   * Variable id.
   */
  id?: int64;

  /**
   * Variable name.
   */
  name?: string;

  /**
   * Variable description.
   */
  description?: string;

  /**
   * Variable type.
   */
  dataType?: string;

  /**
   * Whether variable is sensitive.
   */
  sensitive?: boolean;

  /**
   * Variable value.
   */
  value?: string;

  /**
   * Variable sensitive value.
   */
  sensitiveValue?: string;
}
