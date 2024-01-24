import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AppPlatform;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Provisioning state of the Service
 */
enum ProvisioningState {
  Creating,
  Updating,
  Starting,
  Stopping,
  Deleting,
  Deleted,
  Succeeded,
  Failed,
  Moving,
  Moved,
  MoveFailed,
}

/**
 * The direction of required traffic
 */
enum TrafficDirection {
  Inbound,
  Outbound,
}

/**
 * Power state of the Service
 */
enum PowerState {
  Running,
  Stopped,
}

/**
 * The type of identity that last modified the resource.
 */
enum LastModifiedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

/**
 * Type of the test key
 */
enum TestKeyType {
  Primary,
  Secondary,
}

/**
 * State of the config server.
 */
enum ConfigServerState {
  NotAvailable,
  Deleted,
  Failed,
  Succeeded,
  Updating,
}

/**
 * State of the Application Configuration Service.
 */
enum ConfigurationServiceProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

/**
 * State of the Service Registry.
 */
enum ServiceRegistryProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

/**
 * Provisioning state of the KPack build result
 */
enum BuildServiceProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

/**
 * Provisioning state of the KPack build result
 */
enum BuildProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

/**
 * Buildpack Binding Type
 */
enum BindingType {
  ApplicationInsights,
  ApacheSkyWalking,
  AppDynamics,
  Dynatrace,
  NewRelic,
  ElasticAPM,
}

/**
 * State of the Buildpack Binding.
 */
enum BuildpackBindingProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

/**
 * Provisioning state of the KPack build result
 */
enum BuildResultProvisioningState {
  Queuing,
  Building,
  Succeeded,
  Failed,
  Deleting,
}

/**
 * The provisioning state of this build stage resource.
 */
enum KPackBuildStageProvisioningState {
  NotStarted,
  Running,
  Succeeded,
  Failed,
}

/**
 * Builder provision status.
 */
enum BuilderProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

/**
 * State of the Monitoring Setting.
 */
enum MonitoringSettingState {
  NotAvailable,
  Failed,
  Succeeded,
  Updating,
}

/**
 * Provisioning state of the App
 */
enum AppResourceProvisioningState {
  Succeeded,
  Failed,
  Creating,
  Updating,
  Deleting,
}

/**
 * The type of the underlying resource to mount as a persistent disk.
 */
enum Type {
  AzureFileVolume,
}

/**
 * Type of the affinity, set this to Cookie to enable session affinity.
 */
enum SessionAffinity {
  Cookie,
  None,
}

/**
 * How ingress should communicate with this app backend service.
 */
enum BackendProtocol {
  GRPC,
  Default,
}

/**
 * Type of the managed identity
 */
enum ManagedIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

/**
 * The type of the storage.
 */
enum StorageType {
  StorageAccount,
}

/**
 * Provisioning state of the Certificate
 */
enum CertificateResourceProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

/**
 * Provisioning state of the Domain
 */
enum CustomDomainResourceProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

/**
 * The type of the action to take to perform the health check.
 */
enum ProbeActionType {
  HTTPGetAction,
  TCPSocketAction,
  ExecAction,
}

/**
 * Provisioning state of the Deployment
 */
enum DeploymentResourceProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
}

/**
 * Status of the Deployment
 */
enum DeploymentResourceStatus {
  Stopped,
  Running,
}

/**
 * The raw value which could be passed to deployment CRUD operations.
 */
enum SupportedRuntimeValue {
  Java_8,
  Java_11,
  Java_17,
  NetCore_31,
}

/**
 * The platform of this runtime version (possible values: "Java" or ".NET").
 */
enum SupportedRuntimePlatform {
  Java,
  `.NET Core`,
}

/**
 * Gets or sets the type of the scale.
 */
enum SkuScaleType {
  None,
  Manual,
  Automatic,
}

/**
 * Gets the type of restrictions. Possible values include: 'Location', 'Zone'
 */
enum ResourceSkuRestrictionsType {
  Location,
  Zone,
}

/**
 * Gets the reason for restriction. Possible values include: 'QuotaId', 'NotAvailableForSubscription'
 */
enum ResourceSkuRestrictionsReasonCode {
  QuotaId,
  NotAvailableForSubscription,
}

/**
 * State of the Spring Cloud Gateway.
 */
enum GatewayProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

/**
 * Protocol of routed Azure Spring Apps applications.
 */
enum GatewayRouteConfigProtocol {
  HTTP,
  HTTPS,
}

/**
 * State of the API portal.
 */
enum ApiPortalProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

/**
 * Scheme to use for connecting to the host. Defaults to HTTP.
 *
 * Possible enum values:
 *  - `"HTTP"` means that the scheme used will be http://
 *  - `"HTTPS"` means that the scheme used will be https://
 */
enum HttpSchemeType {
  HTTP,
  HTTPS,
}

/**
 * Service properties payload
 */
model ClusterResourceProperties {
  /**
   * Provisioning state of the Service
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Network profile of the Service
   */
  networkProfile?: NetworkProfile;

  /**
   * Additional Service settings in vnet injection instance
   */
  vnetAddons?: ServiceVNetAddons;

  /**
   * Version of the Service
   */
  @visibility("read")
  version?: int32;

  /**
   * ServiceInstanceEntity GUID which uniquely identifies a created resource
   */
  @visibility("read")
  serviceId?: string;

  /**
   * Power state of the Service
   */
  @visibility("read")
  powerState?: PowerState;

  @visibility("read", "create")
  zoneRedundant?: boolean;

  /**
   * Fully qualified dns name of the service instance
   */
  @visibility("read")
  fqdn?: string;
}

/**
 * Service network profile payload
 */
model NetworkProfile {
  /**
   * Fully qualified resource Id of the subnet to host Azure Spring Apps Service Runtime
   */
  @visibility("read", "create")
  serviceRuntimeSubnetId?: string;

  /**
   * Fully qualified resource Id of the subnet to host customer apps in Azure Spring Apps
   */
  @visibility("read", "create")
  appSubnetId?: string;

  /**
   * Azure Spring Apps service reserved CIDR
   */
  @visibility("read", "create")
  serviceCidr?: string;

  /**
   * Name of the resource group containing network resources of Azure Spring Apps Service Runtime
   */
  @visibility("read", "create")
  serviceRuntimeNetworkResourceGroup?: string;

  /**
   * Name of the resource group containing network resources for customer apps in Azure Spring Apps
   */
  @visibility("read", "create")
  appNetworkResourceGroup?: string;

  /**
   * Desired outbound IP resources for Azure Spring Apps resource.
   */
  @visibility("read")
  outboundIPs?: NetworkProfileOutboundIPs;

  /**
   * Required inbound or outbound traffics for Azure Spring Apps resource.
   */
  @visibility("read")
  requiredTraffics?: RequiredTraffic[];

  /**
   * Ingress configuration payload for Azure Spring Apps resource.
   */
  ingressConfig?: IngressConfig;

  /**
   * The egress traffic type of Azure Spring Apps VNet instances.
   */
  @visibility("read", "create")
  outboundType?: string;
}

/**
 * Desired outbound IP resources for Azure Spring Apps resource.
 */
model NetworkProfileOutboundIPs {
  /**
   * A list of public IP addresses.
   */
  @visibility("read")
  publicIPs?: string[];
}

/**
 * Required inbound or outbound traffic for Azure Spring Apps resource.
 */
model RequiredTraffic {
  /**
   * The protocol of required traffic
   */
  @visibility("read")
  protocol?: string;

  /**
   * The port of required traffic
   */
  @visibility("read")
  port?: int32;

  /**
   * The ip list of required traffic
   */
  @visibility("read")
  ips?: string[];

  /**
   * The FQDN list of required traffic
   */
  @visibility("read")
  fqdns?: string[];

  /**
   * The direction of required traffic
   */
  @visibility("read")
  direction?: TrafficDirection;
}

/**
 * Ingress configuration payload for Azure Spring Apps resource.
 */
model IngressConfig {
  /**
   * Ingress read time out in seconds.
   */
  readTimeoutInSeconds?: int32;
}

/**
 * Additional Service settings in vnet injection instance
 */
model ServiceVNetAddons {
  /**
   * Indicates whether the log stream in vnet injection instance could be accessed from internet.
   */
  logStreamPublicEndpoint?: boolean;
}

/**
 * Sku of Azure Spring Apps
 */
model Sku {
  /**
   * Name of the Sku
   */
  name?: string = "S0";

  /**
   * Tier of the Sku
   */
  tier?: string = "Standard";

  /**
   * Current capacity of the target resource
   */
  capacity?: int32;
}

/**
 * The core properties of ARM resources.
 */
model Resource {
  /**
   * Fully qualified resource Id for the resource.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility("read")
  type?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * An error response from the service.
 */
@error
model CloudError {
  /**
   * An error response from the service.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the service.
 */
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message?: string;

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  target?: string;

  /**
   * A list of additional details about the error.
   */
  details?: CloudErrorBody[];
}

/**
 * Test keys payload
 */
model TestKeys {
  /**
   * Primary key
   */
  primaryKey?: string;

  /**
   * Secondary key
   */
  secondaryKey?: string;

  /**
   * Primary test endpoint
   */
  primaryTestEndpoint?: string;

  /**
   * Secondary test endpoint
   */
  secondaryTestEndpoint?: string;

  /**
   * Indicates whether the test endpoint feature enabled or not
   */
  enabled?: boolean;
}

/**
 * Regenerate test key request payload
 */
model RegenerateTestKeyRequestPayload {
  /**
   * Type of the test key
   */
  keyType: TestKeyType;
}

/**
 * Config server git properties payload
 */
model ConfigServerProperties {
  /**
   * State of the config server.
   */
  @visibility("read")
  provisioningState?: ConfigServerState;

  /**
   * Error when apply config server settings.
   */
  error?: Error;

  /**
   * Settings of config server.
   */
  configServer?: ConfigServerSettings;
}

/**
 * The error code compose of code and message.
 */
model Error {
  /**
   * The code of error.
   */
  code?: string;

  /**
   * The message of error.
   */
  message?: string;
}

/**
 * The settings of config server.
 */
model ConfigServerSettings {
  /**
   * Property of git environment.
   */
  gitProperty?: ConfigServerGitProperty;
}

/**
 * Property of git.
 */
model ConfigServerGitProperty {
  /**
   * Repositories of git.
   */
  repositories?: GitPatternRepository[];

  /**
   * URI of the repository
   */
  uri: string;

  /**
   * Label of the repository
   */
  label?: string;

  /**
   * Searching path of the repository
   */
  searchPaths?: string[];

  /**
   * Username of git repository basic auth.
   */
  username?: string;

  /**
   * Password of git repository basic auth.
   */
  password?: string;

  /**
   * Public sshKey of git repository.
   */
  hostKey?: string;

  /**
   * SshKey algorithm of git repository.
   */
  hostKeyAlgorithm?: string;

  /**
   * Private sshKey algorithm of git repository.
   */
  privateKey?: string;

  /**
   * Strict host key checking or not.
   */
  strictHostKeyChecking?: boolean;
}

/**
 * Git repository property payload for config server
 */
model GitPatternRepository {
  /**
   * Name of the repository
   */
  name: string;

  /**
   * Collection of pattern of the repository
   */
  pattern?: string[];

  /**
   * URI of the repository
   */
  uri: string;

  /**
   * Label of the repository
   */
  label?: string;

  /**
   * Searching path of the repository
   */
  searchPaths?: string[];

  /**
   * Username of git repository basic auth.
   */
  username?: string;

  /**
   * Password of git repository basic auth.
   */
  password?: string;

  /**
   * Public sshKey of git repository.
   */
  hostKey?: string;

  /**
   * SshKey algorithm of git repository.
   */
  hostKeyAlgorithm?: string;

  /**
   * Private sshKey algorithm of git repository.
   */
  privateKey?: string;

  /**
   * Strict host key checking or not.
   */
  strictHostKeyChecking?: boolean;
}

/**
 * Validation result for config server settings
 */
model ConfigServerSettingsValidateResult {
  /**
   * Indicate if the config server settings are valid
   */
  isValid?: boolean;

  /**
   * The detail validation results
   */
  details?: ConfigServerSettingsErrorRecord[];
}

/**
 * Error record of the config server settings
 */
model ConfigServerSettingsErrorRecord {
  /**
   * The name of the config server settings error record
   */
  name?: string;

  /**
   * The uri of the config server settings error record
   */
  uri?: string;

  /**
   * The detail error messages of the record
   */
  messages?: string[];
}

/**
 * Application Configuration Service properties payload
 */
model ConfigurationServiceProperties {
  /**
   * State of the Application Configuration Service.
   */
  @visibility("read")
  provisioningState?: ConfigurationServiceProvisioningState;

  /**
   * The requested resource quantity for required CPU and Memory.
   */
  @visibility("read")
  resourceRequests?: ConfigurationServiceResourceRequests;

  /**
   * Collection of instances belong to Application Configuration Service.
   */
  @visibility("read")
  instances?: ConfigurationServiceInstance[];

  /**
   * The settings of Application Configuration Service.
   */
  settings?: ConfigurationServiceSettings;
}

/**
 * Resource request payload of Application Configuration Service
 */
model ConfigurationServiceResourceRequests {
  /**
   * Cpu allocated to each Application Configuration Service instance
   */
  @visibility("read")
  cpu?: string;

  /**
   * Memory allocated to each Application Configuration Service instance
   */
  @visibility("read")
  memory?: string;

  /**
   * Instance count of the Application Configuration Service
   */
  @visibility("read")
  instanceCount?: int32;
}

/**
 * Collection of instances belong to the Application Configuration Service
 */
model ConfigurationServiceInstance {
  /**
   * Name of the Application Configuration Service instance
   */
  @visibility("read")
  name?: string;

  /**
   * Status of the Application Configuration Service instance
   */
  @visibility("read")
  status?: string;
}

/**
 * The settings of Application Configuration Service.
 */
model ConfigurationServiceSettings {
  /**
   * Property of git environment.
   */
  gitProperty?: ConfigurationServiceGitProperty;
}

/**
 * Property of git environment.
 */
model ConfigurationServiceGitProperty {
  /**
   * Repositories of Application Configuration Service git property.
   */
  repositories?: ConfigurationServiceGitRepository[];
}

/**
 * Git repository property payload for Application Configuration Service
 */
model ConfigurationServiceGitRepository {
  /**
   * Name of the repository
   */
  name: string;

  /**
   * Collection of patterns of the repository
   */
  patterns: string[];

  /**
   * URI of the repository
   */
  uri: string;

  /**
   * Label of the repository
   */
  label: string;

  /**
   * Searching path of the repository
   */
  searchPaths?: string[];

  /**
   * Username of git repository basic auth.
   */
  username?: string;

  /**
   * Password of git repository basic auth.
   */
  password?: string;

  /**
   * Public sshKey of git repository.
   */
  hostKey?: string;

  /**
   * SshKey algorithm of git repository.
   */
  hostKeyAlgorithm?: string;

  /**
   * Private sshKey algorithm of git repository.
   */
  privateKey?: string;

  /**
   * Strict host key checking or not.
   */
  strictHostKeyChecking?: boolean;
}

/**
 * Validation result for configuration service settings
 */
model ConfigurationServiceSettingsValidateResult {
  /**
   * Validation result for configuration service settings
   */
  gitPropertyValidationResult?: ConfigurationServiceGitPropertyValidateResult;
}

/**
 * Validation result for configuration service settings
 */
model ConfigurationServiceGitPropertyValidateResult {
  /**
   * Indicate if the configuration service settings are valid
   */
  isValid?: boolean;

  /**
   * The detail validation results
   */
  gitReposValidationResult?: ValidationMessages[];
}

/**
 * Validate messages of the configuration service git repositories
 */
model ValidationMessages {
  /**
   * The name of the configuration service git repository.
   */
  name?: string;

  /**
   * Detailed validation messages.
   */
  messages?: string[];
}

/**
 * Service Registry properties payload
 */
model ServiceRegistryProperties {
  /**
   * State of the Service Registry.
   */
  @visibility("read")
  provisioningState?: ServiceRegistryProvisioningState;

  /**
   * The requested resource quantity for required CPU and Memory.
   */
  @visibility("read")
  resourceRequests?: ServiceRegistryResourceRequests;

  /**
   * Collection of instances belong to Service Registry.
   */
  @visibility("read")
  instances?: ServiceRegistryInstance[];
}

/**
 * Resource request payload of Service Registry
 */
model ServiceRegistryResourceRequests {
  /**
   * Cpu allocated to each Service Registry instance
   */
  @visibility("read")
  cpu?: string;

  /**
   * Memory allocated to each Service Registry instance
   */
  @visibility("read")
  memory?: string;

  /**
   * Instance count of the Service Registry
   */
  @visibility("read")
  instanceCount?: int32;
}

/**
 * Collection of instances belong to the Service Registry
 */
model ServiceRegistryInstance {
  /**
   * Name of the Service Registry instance
   */
  @visibility("read")
  name?: string;

  /**
   * Status of the Service Registry instance
   */
  @visibility("read")
  status?: string;
}

/**
 * Build service resource properties payload
 */
model BuildServiceProperties {
  /**
   * The installed KPack version in this build service.
   */
  kPackVersion?: string;

  /**
   * Provisioning state of the KPack build result
   */
  @visibility("read")
  provisioningState?: BuildServiceProvisioningState;

  /**
   * The runtime resource configuration of this build service.
   */
  resourceRequests?: BuildServicePropertiesResourceRequests;
}

/**
 * The runtime resource configuration of this build service.
 */
model BuildServicePropertiesResourceRequests {
  /**
   * vCPU allocated to the entire build service node pool.
   */
  @visibility("read")
  cpu?: string;

  /**
   * Memory allocated to the entire build service node pool.
   */
  @visibility("read")
  memory?: string;
}

/**
 * Build resource properties payload
 */
model BuildProperties {
  /**
   * The relative path of source code
   */
  relativePath?: string;

  /**
   * The resource id of builder to build the source code
   */
  builder?: string;

  /**
   * The resource id of agent pool
   */
  agentPool?: string;

  /**
   * Provisioning state of the KPack build result
   */
  @visibility("read")
  provisioningState?: BuildProvisioningState;

  /**
   * The environment variables for this build
   */
  env?: Record<string>;

  /**
   *  The build result triggered by this build
   */
  @visibility("read")
  triggeredBuildResult?: TriggeredBuildResult;

  /**
   * The customized build resource for this build
   */
  resourceRequests?: BuildResourceRequests;
}

/**
 * The build result triggered by a build
 */
model TriggeredBuildResult {
  /**
   * The unique build id of this build result
   */
  id?: string;
}

/**
 * Resource request payload of Build Resource.
 */
model BuildResourceRequests {
  /**
   * Optional Cpu allocated to the build resource. 1 core can be represented by 1 or 1000m.
   * The default value is 1, this should not exceed build service agent pool cpu size.
   */
  cpu?: string = "1";

  /**
   * Optional Memory allocated to the build resource. 1 GB can be represented by 1Gi or 1024Mi.
   * The default value is 2Gi, this should not exceed build service agent pool memory size.
   */
  memory?: string = "2Gi";
}

/**
 * Properties of a buildpack binding
 */
model BuildpackBindingProperties {
  /**
   * Buildpack Binding Type
   */
  bindingType?: BindingType;

  /**
   * State of the Buildpack Binding.
   */
  @visibility("read")
  provisioningState?: BuildpackBindingProvisioningState;

  /**
   * The object describes the buildpack binding launch properties
   */
  launchProperties?: BuildpackBindingLaunchProperties;
}

/**
 * Buildpack Binding Launch Properties
 */
model BuildpackBindingLaunchProperties {
  /**
   * Non-sensitive properties for launchProperties
   */
  properties?: Record<string>;

  /**
   * Sensitive properties for launchProperties
   */
  secrets?: Record<string>;
}

/**
 * Build result resource properties payload
 */
model BuildResultProperties {
  /**
   * The name of this build result
   */
  name?: string;

  /**
   * Provisioning state of the KPack build result
   */
  @visibility("read")
  provisioningState?: BuildResultProvisioningState;

  /**
   * The build pod name which can be used to get the build log streaming.
   */
  buildPodName?: string;

  /**
   * All of the build stage (init-container and container) resources in build pod.
   */
  @visibility("read")
  buildStages?: BuildStageProperties[];
}

/**
 * The build stage (init-container and container) resources in build pod.
 */
model BuildStageProperties {
  /**
   * The name of this build stage resource.
   */
  @visibility("read")
  name?: string;

  /**
   * The provisioning state of this build stage resource.
   */
  @visibility("read")
  status?: KPackBuildStageProvisioningState;
}

/**
 * Build result log resource properties payload
 */
model BuildResultLog {
  /**
   * The public download URL of this build result log
   */
  blobUrl?: string;
}

/**
 * KPack Builder properties payload
 */
model BuilderProperties {
  /**
   * Builder provision status.
   */
  @visibility("read")
  provisioningState?: BuilderProvisioningState;

  /**
   * Builder cluster stack property.
   */
  stack?: StackProperties;

  /**
   * Builder buildpack groups.
   */
  buildpackGroups?: BuildpacksGroupProperties[];
}

/**
 * KPack ClusterStack properties payload
 */
model StackProperties {
  /**
   * Id of the ClusterStack.
   */
  id?: string;

  /**
   * Version of the ClusterStack
   */
  version?: string;
}

/**
 * Buildpack group properties of the Builder
 */
model BuildpacksGroupProperties {
  /**
   * Buildpack group name
   */
  name?: string;

  /**
   * Buildpacks in the buildpack group
   */
  buildpacks?: BuildpackProperties[];
}

/**
 * Buildpack properties payload
 */
model BuildpackProperties {
  /**
   * Id of the buildpack
   */
  id?: string;
}

/**
 * Resource upload definition payload
 */
model ResourceUploadDefinition {
  /**
   * Source relative path
   */
  relativePath?: string;

  /**
   * Upload URL
   */
  uploadUrl?: string;
}

/**
 * Supported buildpack resource properties
 */
model SupportedBuildpackResourceProperties {
  /**
   * The id of supported buildpack
   */
  buildpackId?: string;
}

/**
 * Supported stack resource properties
 */
model SupportedStackResourceProperties {
  /**
   * The id of supported stack
   */
  stackId?: string;

  /**
   * The version of supported stack
   */
  version?: string;
}

/**
 * Build service agent pool properties
 */
model BuildServiceAgentPoolProperties {
  /**
   * Provisioning state of the build service agent pool
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * build service agent pool size properties
   */
  poolSize?: BuildServiceAgentPoolSizeProperties;
}

/**
 * Build service agent pool size properties
 */
model BuildServiceAgentPoolSizeProperties {
  /**
   * The name of build service agent pool size
   */
  name?: string;

  /**
   * The cpu property of build service agent pool size
   */
  @visibility("read")
  cpu?: string;

  /**
   * The memory property of build service agent pool size
   */
  @visibility("read")
  memory?: string;
}

/**
 * Monitoring Setting properties payload
 */
model MonitoringSettingProperties {
  /**
   * State of the Monitoring Setting.
   */
  @visibility("read")
  provisioningState?: MonitoringSettingState;

  /**
   * Error when apply Monitoring Setting changes.
   */
  error?: Error;

  /**
   * Indicates whether enable the trace functionality, which will be deprecated since api version 2020-11-01-preview. Please leverage appInsightsInstrumentationKey to indicate if monitoringSettings enabled or not
   */
  traceEnabled?: boolean;

  /**
   * Target application insight instrumentation key, null or whitespace include empty will disable monitoringSettings
   */
  appInsightsInstrumentationKey?: string;

  /**
   * Indicates the sampling rate of application insight agent, should be in range [0.0, 100.0]
   */
  @maxValue(100)
  appInsightsSamplingRate?: float64;

  /**
   * Indicates the versions of application insight agent
   */
  appInsightsAgentVersions?: ApplicationInsightsAgentVersions;
}

/**
 * Application Insights agent versions properties payload
 */
model ApplicationInsightsAgentVersions {
  /**
   * Indicates the version of application insight java agent
   */
  @visibility("read")
  java?: string;
}

/**
 * App resource properties payload
 */
model AppResourceProperties {
  /**
   * Indicates whether the App exposes public endpoint
   */
  public?: boolean;

  /**
   * URL of the App
   */
  @visibility("read")
  url?: string;

  /**
   * Collection of addons
   */
  addonConfigs?: Record<Record<Record<unknown>>>;

  /**
   * Provisioning state of the App
   */
  @visibility("read")
  provisioningState?: AppResourceProvisioningState;

  /**
   * Fully qualified dns Name.
   */
  @visibility("read")
  fqdn?: string;

  /**
   * Indicate if only https is allowed.
   */
  httpsOnly?: boolean;

  /**
   * Temporary disk settings
   */
  temporaryDisk?: TemporaryDisk;

  /**
   * Persistent disk settings
   */
  persistentDisk?: PersistentDisk;

  /**
   * List of custom persistent disks
   */
  customPersistentDisks?: CustomPersistentDiskResource[];

  /**
   * Indicate if end to end TLS is enabled.
   */
  enableEndToEndTLS?: boolean;

  /**
   * Collection of loaded certificates
   */
  loadedCertificates?: LoadedCertificate[];

  /**
   * Additional App settings in vnet injection instance
   */
  vnetAddons?: AppVNetAddons;

  /**
   * App ingress settings payload.
   */
  ingressSettings?: IngressSettings;
}

/**
 * Temporary disk payload
 */
model TemporaryDisk {
  /**
   * Size of the temporary disk in GB
   */
  @maxValue(5)
  sizeInGB?: int32;

  /**
   * Mount path of the temporary disk
   */
  mountPath?: string = "/tmp";
}

/**
 * Persistent disk payload
 */
model PersistentDisk {
  /**
   * Size of the persistent disk in GB
   */
  @maxValue(50)
  sizeInGB?: int32;

  /**
   * Size of the used persistent disk in GB
   */
  @visibility("read")
  @maxValue(50)
  usedInGB?: int32;

  /**
   * Mount path of the persistent disk
   */
  mountPath?: string;
}

/**
 * Custom persistent disk resource payload.
 */
model CustomPersistentDiskResource {
  /**
   * Properties of the custom persistent disk resource payload.
   */
  customPersistentDiskProperties?: CustomPersistentDiskProperties;

  /**
   * The resource id of Azure Spring Apps Storage resource.
   */
  storageId: string;
}

/**
 * Custom persistent disk resource payload.
 */
@discriminator("type")
model CustomPersistentDiskProperties {
  /**
   * The mount path of the persistent disk.
   */
  mountPath: string;

  /**
   * Indicates whether the persistent disk is a readOnly one.
   */
  readOnly?: boolean;

  /**
   * These are the mount options for a persistent disk.
   */
  mountOptions?: string[];
}

/**
 * Loaded certificate payload
 */
model LoadedCertificate {
  /**
   * Resource Id of loaded certificate
   */
  resourceId: string;

  /**
   * Indicate whether the certificate will be loaded into default trust store, only work for Java runtime.
   */
  loadTrustStore?: boolean;
}

/**
 * Additional App settings in vnet injection instance
 */
model AppVNetAddons {
  /**
   * Indicates whether the App in vnet injection instance exposes endpoint which could be accessed from internet.
   */
  publicEndpoint?: boolean;

  /**
   * URL of the App in vnet injection instance which could be accessed from internet
   */
  @visibility("read")
  publicEndpointUrl?: string;
}

/**
 * App ingress settings payload.
 */
model IngressSettings {
  /**
   * Ingress read time out in seconds.
   */
  readTimeoutInSeconds?: int32;

  /**
   * Ingress send time out in seconds.
   */
  sendTimeoutInSeconds?: int32;

  /**
   * Type of the affinity, set this to Cookie to enable session affinity.
   */
  sessionAffinity?: SessionAffinity;

  /**
   * Time in seconds until the cookie expires.
   */
  sessionCookieMaxAge?: int32;

  /**
   * How ingress should communicate with this app backend service.
   */
  backendProtocol?: BackendProtocol;

  /**
   * Client-Certification Authentication.
   */
  clientAuth?: IngressSettingsClientAuth;
}

/**
 * Client-Certification Authentication.
 */
model IngressSettingsClientAuth {
  /**
   * Collection of certificate resource id.
   */
  certificates?: string[];
}

/**
 * Managed identity properties retrieved from ARM request headers.
 */
model ManagedIdentityProperties {
  /**
   * Type of the managed identity
   */
  type?: ManagedIdentityType;

  /**
   * Principal Id of system-assigned managed identity.
   */
  principalId?: string;

  /**
   * Tenant Id of system-assigned managed identity.
   */
  tenantId?: string;

  /**
   * Properties of user-assigned managed identities
   */
  userAssignedIdentities?: Record<UserAssignedManagedIdentity>;
}

/**
 * The details of the user-assigned managed identity assigned to an App.
 */
model UserAssignedManagedIdentity {
  /**
   * Principal Id of user-assigned managed identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * Client Id of user-assigned managed identity.
   */
  @visibility("read")
  clientId?: string;
}

/**
 * Object that includes an array of Deployment resource name and set them as active.
 */
model ActiveDeploymentCollection {
  /**
   * Collection of Deployment name.
   */
  activeDeploymentNames?: string[];
}

/**
 * Binding resource properties payload
 */
model BindingResourceProperties {
  /**
   * The name of the bound resource
   */
  @visibility("read")
  resourceName?: string;

  /**
   * The standard Azure resource type of the bound resource
   */
  @visibility("read")
  resourceType?: string;

  /**
   * The Azure resource id of the bound resource
   */
  resourceId?: string;

  /**
   * The key of the bound resource
   */
  key?: string;

  /**
   * Binding parameters of the Binding resource
   */
  bindingParameters?: Record<Record<unknown>>;

  /**
   * The generated Spring Boot property file for this binding. The secret will be deducted.
   */
  @visibility("read")
  generatedProperties?: string;

  /**
   * Creation time of the Binding resource
   */
  @visibility("read")
  createdAt?: string;

  /**
   * Update time of the Binding resource
   */
  @visibility("read")
  updatedAt?: string;
}

/**
 * Storage resource payload.
 */
@discriminator("storageType")
model StorageProperties {}

/**
 * Certificate resource payload.
 */
@discriminator("type")
model CertificateProperties {
  /**
   * The thumbprint of certificate.
   */
  @visibility("read")
  thumbprint?: string;

  /**
   * The issuer of certificate.
   */
  @visibility("read")
  issuer?: string;

  /**
   * The issue date of certificate.
   */
  @visibility("read")
  issuedDate?: string;

  /**
   * The expiration date of certificate.
   */
  @visibility("read")
  expirationDate?: string;

  /**
   * The activate date of certificate.
   */
  @visibility("read")
  activateDate?: string;

  /**
   * The subject name of certificate.
   */
  @visibility("read")
  subjectName?: string;

  /**
   * The domain list of certificate.
   */
  @visibility("read")
  dnsNames?: string[];

  /**
   * Provisioning state of the Certificate
   */
  @visibility("read")
  provisioningState?: CertificateResourceProvisioningState;
}

/**
 * Name availability parameters payload
 */
model NameAvailabilityParameters {
  /**
   * Type of the resource to check name availability
   */
  type: string;

  /**
   * Name to be checked
   */
  name: string;
}

/**
 * Name availability result payload
 */
model NameAvailability {
  /**
   * Indicates whether the name is available
   */
  nameAvailable?: boolean;

  /**
   * Reason why the name is not available
   */
  reason?: string;

  /**
   * Message why the name is not available
   */
  message?: string;
}

/**
 * Custom domain of app resource payload.
 */
model CustomDomainProperties {
  /**
   * The thumbprint of bound certificate.
   */
  thumbprint?: string;

  /**
   * The app name of domain.
   */
  @visibility("read")
  appName?: string;

  /**
   * The bound certificate name of domain.
   */
  certName?: string;

  /**
   * Provisioning state of the Domain
   */
  @visibility("read")
  provisioningState?: CustomDomainResourceProvisioningState;
}

/**
 * Custom domain validate payload.
 */
model CustomDomainValidatePayload {
  /**
   * Name to be validated
   */
  name: string;
}

/**
 * Validation result for custom domain.
 */
model CustomDomainValidateResult {
  /**
   * Indicates if domain name is valid.
   */
  isValid?: boolean;

  /**
   * Message of why domain name is invalid.
   */
  message?: string;
}

/**
 * Deployment resource properties payload
 */
model DeploymentResourceProperties {
  /**
   * Uploaded source information of the deployment.
   */
  source?: UserSourceInfo;

  /**
   * Deployment settings of the Deployment
   */
  deploymentSettings?: DeploymentSettings;

  /**
   * Provisioning state of the Deployment
   */
  @visibility("read")
  provisioningState?: DeploymentResourceProvisioningState;

  /**
   * Status of the Deployment
   */
  @visibility("read")
  status?: DeploymentResourceStatus;

  /**
   * Indicates whether the Deployment is active
   */
  active?: boolean;

  /**
   * Collection of instances belong to the Deployment
   */
  @visibility("read")
  instances?: DeploymentInstance[];
}

/**
 * Source information for a deployment
 */
@discriminator("type")
model UserSourceInfo {
  /**
   * Version of the source
   */
  version?: string;
}

/**
 * Deployment settings payload
 */
model DeploymentSettings {
  /**
   * The requested resource quantity for required CPU and Memory. It is recommended that using this field to represent the required CPU and Memory, the old field cpu and memoryInGB will be deprecated later.
   */
  resourceRequests?: ResourceRequests;

  /**
   * Collection of environment variables
   */
  environmentVariables?: Record<string>;

  /**
   * Collection of addons
   */
  addonConfigs?: Record<Record<Record<unknown>>>;

  /**
   * Periodic probe of App Instance liveness. App Instance will be restarted if the probe fails. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
   */
  livenessProbe?: Probe;

  /**
   * Periodic probe of App Instance service readiness. App Instance will be removed from service endpoints if the probe fails. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
   */
  readinessProbe?: Probe;

  /**
   * StartupProbe indicates that the App Instance has successfully initialized. If specified, no other probes are executed until this completes successfully. If this probe fails, the Pod will be restarted, just as if the livenessProbe failed. This can be used to provide different probe parameters at the beginning of a App Instance's lifecycle, when it might take a long time to load data or warm a cache, than during steady-state operation. This cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
   */
  startupProbe?: Probe;

  /**
   * Optional duration in seconds the App Instance needs to terminate gracefully. May be decreased in delete request. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). If this value is nil, the default grace period will be used instead. The grace period is the duration in seconds after the processes running in the App Instance are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. Defaults to 90 seconds.
   */
  terminationGracePeriodSeconds?: int32 = 90;

  /**
   * Container liveness and readiness probe settings
   */
  containerProbeSettings?: ContainerProbeSettings;
}

/**
 * Deployment resource request payload
 */
model ResourceRequests {
  /**
   * Required CPU. 1 core can be represented by 1 or 1000m. This should be 500m or 1 for Basic tier, and {500m, 1, 2, 3, 4} for Standard tier.
   */
  cpu?: string;

  /**
   * Required memory. 1 GB can be represented by 1Gi or 1024Mi. This should be {512Mi, 1Gi, 2Gi} for Basic tier, and {512Mi, 1Gi, 2Gi, ..., 8Gi} for Standard tier.
   */
  memory?: string;
}

/**
 * Probe describes a health check to be performed against an App Instance to determine whether it is alive or ready to receive traffic.
 */
model Probe {
  /**
   * The action of the probe.
   */
  probeAction?: ProbeAction;

  /**
   * Indicate whether the probe is disabled.
   */
  disableProbe: boolean;

  /**
   * Number of seconds after the App Instance has started before probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
   */
  initialDelaySeconds?: int32;

  /**
   * How often (in seconds) to perform the probe. Minimum value is 1.
   */
  periodSeconds?: int32;

  /**
   * Number of seconds after which the probe times out. Minimum value is 1.
   */
  timeoutSeconds?: int32;

  /**
   * Minimum consecutive failures for the probe to be considered failed after having succeeded. Minimum value is 1.
   */
  failureThreshold?: int32;

  /**
   * Minimum consecutive successes for the probe to be considered successful after having failed. Must be 1 for liveness and startup. Minimum value is 1.
   */
  successThreshold?: int32;
}

/**
 * The action of the probe.
 */
@discriminator("type")
model ProbeAction {}

/**
 * Container liveness and readiness probe settings
 */
model ContainerProbeSettings {
  /**
   * Indicates whether disable the liveness and readiness probe
   */
  disableProbe?: boolean;
}

/**
 * Deployment instance payload
 */
model DeploymentInstance {
  /**
   * Name of the deployment instance
   */
  @visibility("read")
  name?: string;

  /**
   * Status of the deployment instance
   */
  @visibility("read")
  status?: string;

  /**
   * Failed reason of the deployment instance
   */
  @visibility("read")
  reason?: string;

  /**
   * Discovery status of the deployment instance
   */
  @visibility("read")
  discoveryStatus?: string;

  /**
   * Start time of the deployment instance
   */
  @visibility("read")
  startTime?: string;

  /**
   * Availability zone information of the deployment instance
   */
  @visibility("read")
  zone?: string;
}

/**
 * A list of deployments resource ids.
 */
@pagedResult
model DeploymentList {
  /**
   * A list of deployment resource ids.
   */
  @items
  deployments?: string[];
}

/**
 * Remote debugging payload.
 */
model RemoteDebuggingPayload {
  /**
   * Application debugging port.
   */
  port?: int32;
}

/**
 * Remote debugging config.
 */
model RemoteDebugging {
  /**
   * Application debugging port
   */
  port?: int32;

  /**
   * Indicate if remote debugging is enabled
   */
  enabled?: boolean;
}

/**
 * Log file URL payload
 */
model LogFileUrlResponse {
  /**
   * URL of the log file
   */
  url: string;
}

/**
 * Diagnostic parameters of diagnostic operations
 */
model DiagnosticParameters {
  /**
   * App instance name
   */
  appInstance?: string;

  /**
   * Your target file path in your own BYOS
   */
  filePath?: string;

  /**
   * Duration of your JFR. 1 min can be represented by 1m or 60s.
   */
  duration?: string;
}

/**
 * Operation detail payload
 */
model OperationDetail {
  /**
   * Name of the operation
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * Display of the operation
   */
  display?: OperationDisplay;

  /**
   * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
   */
  @visibility("read")
  actionType?: ActionType;

  /**
   * Origin of the operation
   */
  origin?: string;

  /**
   * Properties of the operation
   */
  properties?: OperationProperties;
}

/**
 * Extra Operation properties
 */
model OperationProperties {
  /**
   * Service specifications of the operation
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * Service specification payload
 */
model ServiceSpecification {
  /**
   * Specifications of the Log for Azure Monitoring
   */
  logSpecifications?: LogSpecification[];

  /**
   * Specifications of the Metrics for Azure Monitoring
   */
  metricSpecifications?: MetricSpecification[];
}

/**
 * Specifications of the Log for Azure Monitoring
 */
model LogSpecification {
  /**
   * Name of the log
   */
  name?: string;

  /**
   * Localized friendly display name of the log
   */
  displayName?: string;

  /**
   * Blob duration of the log
   */
  blobDuration?: string;
}

/**
 * Specifications of the Metrics for Azure Monitoring
 */
model MetricSpecification {
  /**
   * Name of the metric
   */
  name?: string;

  /**
   * Localized friendly display name of the metric
   */
  displayName?: string;

  /**
   * Localized friendly description of the metric
   */
  displayDescription?: string;

  /**
   * Unit that makes sense for the metric
   */
  unit?: string;

  /**
   * Name of the metric category that the metric belongs to. A metric can only belong to a single category.
   */
  category?: string;

  /**
   * Only provide one value for this field. Valid values: Average, Minimum, Maximum, Total, Count.
   */
  aggregationType?: string;

  /**
   * Supported aggregation types
   */
  supportedAggregationTypes?: string[];

  /**
   * Supported time grain types
   */
  supportedTimeGrainTypes?: string[];

  /**
   * Optional. If set to true, then zero will be returned for time duration where no metric is emitted/published.
   */
  fillGapWithZero?: boolean;

  /**
   * Dimensions of the metric
   */
  dimensions?: MetricDimension[];

  /**
   * Name of the MDM namespace. Optional.
   */
  sourceMdmNamespace?: string;
}

/**
 * Specifications of the Dimension of metrics
 */
model MetricDimension {
  /**
   * Name of the dimension
   */
  name?: string;

  /**
   * Localized friendly display name of the dimension
   */
  displayName?: string;

  /**
   * Whether this dimension should be included for the Shoebox export scenario
   */
  toBeExportedForShoebox?: boolean;
}

model AvailableRuntimeVersions {
  /**
   * A list of all supported runtime versions.
   */
  @visibility("read")
  value?: SupportedRuntimeVersion[];
}

/**
 * Supported deployment runtime version descriptor.
 */
model SupportedRuntimeVersion {
  /**
   * The raw value which could be passed to deployment CRUD operations.
   */
  value?: SupportedRuntimeValue;

  /**
   * The platform of this runtime version (possible values: "Java" or ".NET").
   */
  platform?: SupportedRuntimePlatform;

  /**
   * The detailed version (major.minor) of the platform.
   */
  version?: string;
}

/**
 * Object that includes an array of Azure Spring Apps SKU and a possible link for next set
 */
model ResourceSkuCollection is Azure.Core.Page<ResourceSku>;

/**
 * Describes an available Azure Spring Apps SKU.
 */
model ResourceSku {
  /**
   * Gets the type of resource the SKU applies to.
   */
  resourceType?: string;

  /**
   * Gets the name of SKU.
   */
  name?: string;

  /**
   * Gets the tier of SKU.
   */
  tier?: string;

  /**
   * Gets the capacity of SKU.
   */
  capacity?: SkuCapacity;

  /**
   * Gets the set of locations that the SKU is available.
   */
  locations?: string[];

  /**
   * Gets a list of locations and availability zones in those locations where the SKU is available.
   */
  locationInfo?: ResourceSkuLocationInfo[];

  /**
   * Gets the restrictions because of which SKU cannot be used. This is
   * empty if there are no restrictions.
   */
  restrictions?: ResourceSkuRestrictions[];
}

/**
 * The SKU capacity
 */
model SkuCapacity {
  /**
   * Gets or sets the minimum.
   */
  minimum: int32;

  /**
   * Gets or sets the maximum.
   */
  maximum?: int32;

  /**
   * Gets or sets the default.
   */
  default?: int32;

  /**
   * Gets or sets the type of the scale.
   */
  scaleType?: SkuScaleType;
}

/**
 * Locations and availability zones where the SKU is available
 */
model ResourceSkuLocationInfo {
  /**
   * Gets location of the SKU
   */
  location?: string;

  /**
   * Gets list of availability zones where the SKU is supported.
   */
  zones?: string[];

  /**
   * Gets details of capabilities available to a SKU in specific zones.
   */
  zoneDetails?: ResourceSkuZoneDetails[];
}

/**
 * Details of capabilities available to a SKU in specific zones
 */
model ResourceSkuZoneDetails {
  /**
   * Gets the set of zones that the SKU is available in with the
   * specified capabilities.
   */
  name?: string[];

  /**
   * Gets a list of capabilities that are available for the SKU in the
   * specified list of zones.
   */
  capabilities?: ResourceSkuCapabilities[];
}

model ResourceSkuCapabilities {
  /**
   * Gets an invariant to describe the feature.
   */
  name?: string;

  /**
   * Gets an invariant if the feature is measured by quantity.
   */
  value?: string;
}

/**
 * Restrictions where the SKU cannot be used
 */
model ResourceSkuRestrictions {
  /**
   * Gets the type of restrictions. Possible values include: 'Location', 'Zone'
   */
  type?: ResourceSkuRestrictionsType;

  /**
   * Gets the value of restrictions. If the restriction type is set to
   * location. This would be different locations where the SKU is restricted.
   */
  values?: string[];

  /**
   * Gets the information about the restriction where the SKU cannot be used.
   */
  restrictionInfo?: ResourceSkuRestrictionInfo;

  /**
   * Gets the reason for restriction. Possible values include: 'QuotaId', 'NotAvailableForSubscription'
   */
  reasonCode?: ResourceSkuRestrictionsReasonCode;
}

/**
 * Information about the restriction where the SKU cannot be used
 */
model ResourceSkuRestrictionInfo {
  /**
   * Gets locations where the SKU is restricted
   */
  locations?: string[];

  /**
   * Gets list of availability zones where the SKU is restricted.
   */
  zones?: string[];
}

/**
 * Spring Cloud Gateway properties payload
 */
model GatewayProperties {
  /**
   * State of the Spring Cloud Gateway.
   */
  @visibility("read")
  provisioningState?: GatewayProvisioningState;

  /**
   * Indicates whether the Spring Cloud Gateway exposes endpoint.
   */
  public?: boolean;

  /**
   * URL of the Spring Cloud Gateway, exposed when 'public' is true.
   */
  @visibility("read")
  url?: string;

  /**
   * Indicate if only https is allowed.
   */
  httpsOnly?: boolean;

  /**
   * Single sign-on related configuration
   */
  ssoProperties?: SsoProperties;

  /**
   * API metadata property for Spring Cloud Gateway
   */
  apiMetadataProperties?: GatewayApiMetadataProperties;

  /**
   * Cross-Origin Resource Sharing property
   */
  corsProperties?: GatewayCorsProperties;

  /**
   * The requested resource quantity for required CPU and Memory.
   */
  resourceRequests?: GatewayResourceRequests;

  /**
   * Collection of instances belong to Spring Cloud Gateway.
   */
  @visibility("read")
  instances?: GatewayInstance[];

  /**
   * Properties of the Spring Cloud Gateway Operator.
   */
  @visibility("read")
  operatorProperties?: GatewayOperatorProperties;
}

/**
 * Single sign-on related configuration
 */
model SsoProperties {
  /**
   * It defines the specific actions applications can be allowed to do on a user's behalf
   */
  scope?: string[];

  /**
   * The public identifier for the application
   */
  clientId?: string;

  /**
   * The secret known only to the application and the authorization server
   */
  clientSecret?: string;

  /**
   * The URI of Issuer Identifier
   */
  issuerUri?: string;
}

/**
 * API metadata property for Spring Cloud Gateway
 */
model GatewayApiMetadataProperties {
  /**
   * Title describing the context of the APIs available on the Gateway instance (default: `Spring Cloud Gateway for K8S`)
   */
  title?: string;

  /**
   * Detailed description of the APIs available on the Gateway instance (default: `Generated OpenAPI 3 document that describes the API routes configured.`)
   */
  description?: string;

  /**
   * Location of additional documentation for the APIs available on the Gateway instance
   */
  documentation?: string;

  /**
   * Version of APIs available on this Gateway instance (default: `unspecified`).
   */
  version?: string;

  /**
   * Base URL that API consumers will use to access APIs on the Gateway instance.
   */
  serverUrl?: string;
}

/**
 * Cross-Origin Resource Sharing property
 */
model GatewayCorsProperties {
  /**
   * Allowed origins to make cross-site requests. The special value `*` allows all domains.
   */
  allowedOrigins?: string[];

  /**
   * Allowed HTTP methods on cross-site requests. The special value `*` allows all methods. If not set, `GET` and `HEAD` are allowed by default.
   */
  allowedMethods?: string[];

  /**
   * Allowed headers in cross-site requests. The special value `*` allows actual requests to send any header.
   */
  allowedHeaders?: string[];

  /**
   * How long, in seconds, the response from a pre-flight request can be cached by clients.
   */
  maxAge?: int32;

  /**
   * Whether user credentials are supported on cross-site requests. Valid values: `true`, `false`.
   */
  allowCredentials?: boolean;

  /**
   * HTTP response headers to expose for cross-site requests.
   */
  exposedHeaders?: string[];
}

/**
 * Resource request payload of Spring Cloud Gateway.
 */
model GatewayResourceRequests {
  /**
   * Cpu allocated to each Spring Cloud Gateway instance.
   */
  cpu?: string = "1";

  /**
   * Memory allocated to each Spring Cloud Gateway instance.
   */
  memory?: string = "2Gi";
}

/**
 * Collection of instances belong to the Spring Cloud Gateway
 */
model GatewayInstance {
  /**
   * Name of the Spring Cloud Gateway instance
   */
  @visibility("read")
  name?: string;

  /**
   * Status of the Spring Cloud Gateway instance
   */
  @visibility("read")
  status?: string;
}

/**
 * Properties of the Spring Cloud Gateway Operator.
 */
model GatewayOperatorProperties {
  /**
   * The requested resource quantity for required CPU and Memory.
   */
  @visibility("read")
  resourceRequests?: GatewayOperatorResourceRequests;

  /**
   * Collection of instances belong to Spring Cloud Gateway operator.
   */
  @visibility("read")
  instances?: GatewayInstance[];
}

/**
 * Properties of the Spring Cloud Gateway Operator.
 */
model GatewayOperatorResourceRequests {
  /**
   * Cpu allocated to each Spring Cloud Gateway Operator instance.
   */
  @visibility("read")
  cpu?: string;

  /**
   * Memory allocated to each Spring Cloud Gateway Operator instance.
   */
  @visibility("read")
  memory?: string;

  /**
   * Instance count of the Spring Cloud Gateway Operator.
   */
  @visibility("read")
  instanceCount?: int32;
}

/**
 * API route config of the Spring Cloud Gateway
 */
model GatewayRouteConfigProperties {
  /**
   * State of the Spring Cloud Gateway route config.
   */
  @visibility("read")
  provisioningState?: GatewayProvisioningState;

  /**
   * The resource Id of the Azure Spring Apps app, required unless route defines `uri`.
   */
  appResourceId?: string;

  /**
   * OpenAPI properties of Spring Cloud Gateway route config.
   */
  openApi?: GatewayRouteConfigOpenApiProperties;

  /**
   * Protocol of routed Azure Spring Apps applications.
   */
  protocol?: GatewayRouteConfigProtocol = GatewayRouteConfigProtocol.HTTP;

  /**
   * Array of API routes, each route contains properties such as `title`, `uri`, `ssoEnabled`, `predicates`, `filters`.
   */
  routes?: GatewayApiRoute[];
}

/**
 * OpenAPI properties of Spring Cloud Gateway route config.
 */
model GatewayRouteConfigOpenApiProperties {
  /**
   * The URI of OpenAPI specification.
   */
  uri?: string;
}

/**
 * API route config of the Spring Cloud Gateway
 */
model GatewayApiRoute {
  /**
   * A title, will be applied to methods in the generated OpenAPI documentation.
   */
  title?: string;

  /**
   * A description, will be applied to methods in the generated OpenAPI documentation.
   */
  description?: string;

  /**
   * Full uri, will override `appName`.
   */
  uri?: string;

  /**
   * Enable sso validation.
   */
  ssoEnabled?: boolean;

  /**
   * Pass currently-authenticated user's identity token to application service, default is 'false'
   */
  tokenRelay?: boolean;

  /**
   * A number of conditions to evaluate a route for each request. Each predicate may be evaluated against request headers and parameter values. All of the predicates associated with a route must evaluate to true for the route to be matched to the request.
   */
  predicates?: string[];

  /**
   * To modify the request before sending it to the target endpoint, or the received response.
   */
  filters?: string[];

  /**
   * Route processing order.
   */
  order?: int32;

  /**
   * Classification tags, will be applied to methods in the generated OpenAPI documentation.
   */
  tags?: string[];
}

/**
 * The properties of custom domain for Spring Cloud Gateway
 */
model GatewayCustomDomainProperties {
  /**
   * The thumbprint of bound certificate.
   */
  thumbprint?: string;
}

/**
 * API portal properties payload
 */
model ApiPortalProperties {
  /**
   * State of the API portal.
   */
  @visibility("read")
  provisioningState?: ApiPortalProvisioningState;

  /**
   * Indicates whether the API portal exposes endpoint.
   */
  public?: boolean;

  /**
   * URL of the API portal, exposed when 'public' is true.
   */
  @visibility("read")
  url?: string;

  /**
   * Indicate if only https is allowed.
   */
  httpsOnly?: boolean;

  /**
   * The array of resource Ids of gateway to integrate with API portal.
   */
  gatewayIds?: string[];

  /**
   * Collection of OpenAPI source URL locations.
   */
  sourceUrls?: string[];

  /**
   * Single sign-on related configuration
   */
  ssoProperties?: SsoProperties;

  /**
   * The requested resource quantity for required CPU and Memory.
   */
  @visibility("read")
  resourceRequests?: ApiPortalResourceRequests;

  /**
   * Collection of instances belong to API portal.
   */
  @visibility("read")
  instances?: ApiPortalInstance[];
}

/**
 * Resource requests of the API portal
 */
model ApiPortalResourceRequests {
  /**
   * Cpu allocated to each API portal instance
   */
  @visibility("read")
  cpu?: string;

  /**
   * Memory allocated to each API portal instance
   */
  @visibility("read")
  memory?: string;
}

/**
 * Collection of instances belong to the API portal
 */
model ApiPortalInstance {
  /**
   * Name of the API portal instance
   */
  @visibility("read")
  name?: string;

  /**
   * Status of the API portal instance
   */
  @visibility("read")
  status?: string;
}

/**
 * The properties of custom domain for API portal
 */
model ApiPortalCustomDomainProperties {
  /**
   * The thumbprint of bound certificate.
   */
  thumbprint?: string;
}

/**
 * Properties of certificate imported from key vault.
 */
model KeyVaultCertificateProperties extends CertificateProperties {
  /**
   * The vault uri of user key vault.
   */
  vaultUri: string;

  /**
   * The certificate name of key vault.
   */
  keyVaultCertName: string;

  /**
   * The certificate version of key vault.
   */
  certVersion?: string;

  /**
   * Optional. If set to true, it will not import private key from key vault.
   */
  excludePrivateKey?: boolean;

  /**
   * The type of the certificate source.
   */
  type: "KeyVaultCertificate";
}

/**
 * Properties of certificate imported from key vault.
 */
model ContentCertificateProperties extends CertificateProperties {
  /**
   * The content of uploaded certificate.
   */
  @visibility("create", "update")
  content?: string;

  /**
   * The type of the certificate source.
   */
  type: "ContentCertificate";
}

/**
 * storage resource of type Azure Storage Account.
 */
model StorageAccount extends StorageProperties {
  /**
   * The account name of the Azure Storage Account.
   */
  accountName: string;

  /**
   * The account key of the Azure Storage Account.
   */
  @visibility("create", "update")
  accountKey: string;

  /**
   * The type of the storage.
   */
  storageType: "StorageAccount";
}

/**
 * The properties of the Azure File volume. Azure File shares are mounted as volumes.
 */
model AzureFileVolume extends CustomPersistentDiskProperties {
  /**
   * The share name of the Azure File share.
   */
  shareName: string;

  /**
   * The type of the underlying resource to mount as a persistent disk.
   */
  type: "AzureFileVolume";
}

/**
 * Source with uploaded location
 */
@discriminator("type")
model UploadedUserSourceInfo extends UserSourceInfo {
  /**
   * Relative path of the storage which stores the source
   */
  relativePath?: string;
}

/**
 * Uploaded Jar binary for a deployment
 */
model JarUploadedUserSourceInfo extends UploadedUserSourceInfo {
  /**
   * Runtime version of the Jar file
   */
  runtimeVersion?: string;

  /**
   * JVM parameter
   */
  jvmOptions?: string;

  /**
   * Type of the source uploaded
   */
  type: "Jar";
}

/**
 * Uploaded Java source code binary for a deployment
 */
model SourceUploadedUserSourceInfo extends UploadedUserSourceInfo {
  /**
   * Selector for the artifact to be used for the deployment for multi-module projects. This should be
   * the relative path to the target module/project.
   */
  artifactSelector?: string;

  /**
   * Runtime version of the source file
   */
  runtimeVersion?: string;

  /**
   * Type of the source uploaded
   */
  type: "Source";
}

/**
 * Uploaded Jar binary for a deployment
 */
model NetCoreZipUploadedUserSourceInfo extends UploadedUserSourceInfo {
  /**
   * The path to the .NET executable relative to zip root
   */
  netCoreMainEntryPath?: string;

  /**
   * Runtime version of the .Net file
   */
  runtimeVersion?: string;

  /**
   * Type of the source uploaded
   */
  type: "NetCoreZip";
}

/**
 * Reference to a build result
 */
model BuildResultUserSourceInfo extends UserSourceInfo {
  /**
   * Resource id of an existing succeeded build result under the same Spring instance.
   */
  buildResultId?: string;

  /**
   * Type of the source uploaded
   */
  type: "BuildResult";
}

/**
 * Custom container user source info
 */
model CustomContainerUserSourceInfo extends UserSourceInfo {
  /**
   * Custom container payload
   */
  customContainer?: CustomContainer;

  /**
   * Type of the source uploaded
   */
  type: "Container";
}

/**
 * Custom container payload
 */
model CustomContainer {
  /**
   * The name of the registry that contains the container image
   */
  server?: string;

  /**
   * Container image of the custom container. This should be in the form of <repository>:<tag> without the server name of the registry
   */
  containerImage?: string;

  /**
   * Entrypoint array. Not executed within a shell. The docker image's ENTRYPOINT is used if this is not provided.
   */
  command?: string[];

  /**
   * Arguments to the entrypoint. The docker image's CMD is used if this is not provided.
   */
  args?: string[];

  /**
   * Credential of the image registry
   */
  imageRegistryCredential?: ImageRegistryCredential;

  /**
   * Language framework of the container image uploaded
   */
  languageFramework?: string;
}

/**
 * Credential of the image registry
 */
model ImageRegistryCredential {
  /**
   * The username of the image registry credential
   */
  username?: string;

  /**
   * The password of the image registry credential
   */
  password?: string;
}

/**
 * HTTPGetAction describes an action based on HTTP Get requests.
 */
model HttpGetAction extends ProbeAction {
  /**
   * Path to access on the HTTP server.
   */
  path?: string;

  /**
   * Scheme to use for connecting to the host. Defaults to HTTP.
   *
   * Possible enum values:
   *  - `"HTTP"` means that the scheme used will be http://
   *  - `"HTTPS"` means that the scheme used will be https://
   */
  scheme?: HttpSchemeType;

  /**
   * The type of the action to take to perform the health check.
   */
  type: "HTTPGetAction";
}

/**
 * ExecAction describes a "run in container" action.
 */
model ExecAction extends ProbeAction {
  /**
   * Command is the command line to execute inside the container, the working directory for the command is root ('/') in the container's filesystem. The command is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
   */
  command?: string[];

  /**
   * The type of the action to take to perform the health check.
   */
  type: "ExecAction";
}

/**
 * TCPSocketAction describes an action based on opening a socket
 */
model TCPSocketAction extends ProbeAction {
  /**
   * The type of the action to take to perform the health check.
   */
  type: "TCPSocketAction";
}
