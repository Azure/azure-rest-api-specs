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

@doc("Provisioning state of the Service")
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

@doc("The direction of required traffic")
enum TrafficDirection {
  Inbound,
  Outbound,
}

@doc("Power state of the Service")
enum PowerState {
  Running,
  Stopped,
}

@doc("The type of identity that last modified the resource.")
enum LastModifiedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

@doc("Type of the test key")
enum TestKeyType {
  Primary,
  Secondary,
}

@doc("State of the config server.")
enum ConfigServerState {
  NotAvailable,
  Deleted,
  Failed,
  Succeeded,
  Updating,
}

@doc("State of the Application Configuration Service.")
enum ConfigurationServiceProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

@doc("State of the Service Registry.")
enum ServiceRegistryProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

@doc("Provisioning state of the KPack build result")
enum BuildServiceProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

@doc("Provisioning state of the KPack build result")
enum BuildProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

@doc("Buildpack Binding Type")
enum BindingType {
  ApplicationInsights,
  ApacheSkyWalking,
  AppDynamics,
  Dynatrace,
  NewRelic,
  ElasticAPM,
}

@doc("State of the Buildpack Binding.")
enum BuildpackBindingProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

@doc("Provisioning state of the KPack build result")
enum BuildResultProvisioningState {
  Queuing,
  Building,
  Succeeded,
  Failed,
  Deleting,
}

@doc("The provisioning state of this build stage resource.")
enum KPackBuildStageProvisioningState {
  NotStarted,
  Running,
  Succeeded,
  Failed,
}

@doc("Builder provision status.")
enum BuilderProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

@doc("State of the Monitoring Setting.")
enum MonitoringSettingState {
  NotAvailable,
  Failed,
  Succeeded,
  Updating,
}

@doc("Provisioning state of the App")
enum AppResourceProvisioningState {
  Succeeded,
  Failed,
  Creating,
  Updating,
  Deleting,
}

@doc("The type of the underlying resource to mount as a persistent disk.")
enum Type {
  AzureFileVolume,
}

@doc("Type of the affinity, set this to Cookie to enable session affinity.")
enum SessionAffinity {
  Cookie,
  None,
}

@doc("How ingress should communicate with this app backend service.")
enum BackendProtocol {
  GRPC,
  Default,
}

@doc("The type of the storage.")
enum StorageType {
  StorageAccount,
}

@doc("Provisioning state of the Certificate")
enum CertificateResourceProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

@doc("Provisioning state of the Domain")
enum CustomDomainResourceProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

@doc("The type of the action to take to perform the health check.")
enum ProbeActionType {
  HTTPGetAction,
  TCPSocketAction,
  ExecAction,
}

@doc("Provisioning state of the Deployment")
enum DeploymentResourceProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
}

@doc("Status of the Deployment")
enum DeploymentResourceStatus {
  Stopped,
  Running,
}

@doc("The raw value which could be passed to deployment CRUD operations.")
enum SupportedRuntimeValue {
  Java_8,
  Java_11,
  Java_17,
  NetCore_31,
}

@doc("The platform of this runtime version (possible values: \"Java\" or \".NET\").")
enum SupportedRuntimePlatform {
  Java,
  `.NET Core`,
}

@doc("Gets or sets the type of the scale.")
enum SkuScaleType {
  None,
  Manual,
  Automatic,
}

@doc("Gets the type of restrictions. Possible values include: 'Location', 'Zone'")
enum ResourceSkuRestrictionsType {
  Location,
  Zone,
}

@doc("Gets the reason for restriction. Possible values include: 'QuotaId', 'NotAvailableForSubscription'")
enum ResourceSkuRestrictionsReasonCode {
  QuotaId,
  NotAvailableForSubscription,
}

@doc("State of the Spring Cloud Gateway.")
enum GatewayProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

@doc("Protocol of routed Azure Spring Apps applications.")
enum GatewayRouteConfigProtocol {
  HTTP,
  HTTPS,
}

@doc("State of the API portal.")
enum ApiPortalProvisioningState {
  Creating,
  Updating,
  Succeeded,
  Failed,
  Deleting,
}

@doc("""
Scheme to use for connecting to the host. Defaults to HTTP.

Possible enum values:
 - `\"HTTP\"` means that the scheme used will be http://
 - `\"HTTPS\"` means that the scheme used will be https://
""")
enum HttpSchemeType {
  HTTP,
  HTTPS,
}

@doc("Service properties payload")
model ClusterResourceProperties {
  @doc("Provisioning state of the Service")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Network profile of the Service")
  networkProfile?: NetworkProfile;

  @doc("Additional Service settings in vnet injection instance")
  vnetAddons?: ServiceVNetAddons;

  @doc("Version of the Service")
  @visibility("read")
  version?: int32;

  @doc("ServiceInstanceEntity GUID which uniquely identifies a created resource")
  @visibility("read")
  serviceId?: string;

  @doc("Power state of the Service")
  @visibility("read")
  powerState?: PowerState;

  @visibility("read", "create")
  zoneRedundant?: boolean;

  @doc("Fully qualified dns name of the service instance")
  @visibility("read")
  fqdn?: string;
}

@doc("Service network profile payload")
model NetworkProfile {
  @doc("Fully qualified resource Id of the subnet to host Azure Spring Apps Service Runtime")
  @visibility("read", "create")
  serviceRuntimeSubnetId?: string;

  @doc("Fully qualified resource Id of the subnet to host customer apps in Azure Spring Apps")
  @visibility("read", "create")
  appSubnetId?: string;

  @doc("Azure Spring Apps service reserved CIDR")
  @visibility("read", "create")
  serviceCidr?: string;

  @doc("Name of the resource group containing network resources of Azure Spring Apps Service Runtime")
  @visibility("read", "create")
  serviceRuntimeNetworkResourceGroup?: string;

  @doc("Name of the resource group containing network resources for customer apps in Azure Spring Apps")
  @visibility("read", "create")
  appNetworkResourceGroup?: string;

  @doc("Desired outbound IP resources for Azure Spring Apps resource.")
  @visibility("read")
  outboundIPs?: NetworkProfileOutboundIPs;

  @doc("Required inbound or outbound traffics for Azure Spring Apps resource.")
  @visibility("read")
  requiredTraffics?: RequiredTraffic[];

  @doc("Ingress configuration payload for Azure Spring Apps resource.")
  ingressConfig?: IngressConfig;

  @doc("The egress traffic type of Azure Spring Apps VNet instances.")
  @visibility("read", "create")
  outboundType?: string;
}

@doc("Desired outbound IP resources for Azure Spring Apps resource.")
model NetworkProfileOutboundIPs {
  @doc("A list of public IP addresses.")
  @visibility("read")
  publicIPs?: string[];
}

@doc("Required inbound or outbound traffic for Azure Spring Apps resource.")
model RequiredTraffic {
  @doc("The protocol of required traffic")
  @visibility("read")
  protocol?: string;

  @doc("The port of required traffic")
  @visibility("read")
  port?: int32;

  @doc("The ip list of required traffic")
  @visibility("read")
  ips?: string[];

  @doc("The FQDN list of required traffic")
  @visibility("read")
  fqdns?: string[];

  @doc("The direction of required traffic")
  @visibility("read")
  direction?: TrafficDirection;
}

@doc("Ingress configuration payload for Azure Spring Apps resource.")
model IngressConfig {
  @doc("Ingress read time out in seconds.")
  readTimeoutInSeconds?: int32;
}

@doc("Additional Service settings in vnet injection instance")
model ServiceVNetAddons {
  @doc("Indicates whether the log stream in vnet injection instance could be accessed from internet.")
  logStreamPublicEndpoint?: boolean;
}

@doc("Sku of Azure Spring Apps")
model Sku {
  @doc("Name of the Sku")
  name?: string;

  @doc("Tier of the Sku")
  tier?: string;

  @doc("Current capacity of the target resource")
  capacity?: int32;
}

@doc("The core properties of ARM resources.")
model Resource {
  @doc("Fully qualified resource Id for the resource.")
  @visibility("read")
  id?: string;

  @doc("The name of the resource.")
  @visibility("read")
  name?: string;

  @doc("The type of the resource.")
  @visibility("read")
  type?: string;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("An error response from the service.")
@error
model CloudError {
  @doc("An error response from the service.")
  error?: CloudErrorBody;
}

@doc("An error response from the service.")
model CloudErrorBody {
  @doc("An identifier for the error. Codes are invariant and are intended to be consumed programmatically.")
  code?: string;

  @doc("A message describing the error, intended to be suitable for display in a user interface.")
  message?: string;

  @doc("The target of the particular error. For example, the name of the property in error.")
  target?: string;

  @doc("A list of additional details about the error.")
  details?: CloudErrorBody[];
}

@doc("Test keys payload")
model TestKeys {
  @doc("Primary key")
  primaryKey?: string;

  @doc("Secondary key")
  secondaryKey?: string;

  @doc("Primary test endpoint")
  primaryTestEndpoint?: string;

  @doc("Secondary test endpoint")
  secondaryTestEndpoint?: string;

  @doc("Indicates whether the test endpoint feature enabled or not")
  enabled?: boolean;
}

@doc("Regenerate test key request payload")
model RegenerateTestKeyRequestPayload {
  @doc("Type of the test key")
  keyType: TestKeyType;
}

@doc("Config server git properties payload")
model ConfigServerProperties {
  @doc("State of the config server.")
  @visibility("read")
  provisioningState?: ConfigServerState;

  @doc("Error when apply config server settings.")
  error?: Error;

  @doc("Settings of config server.")
  configServer?: ConfigServerSettings;
}

@doc("The error code compose of code and message.")
model Error {
  @doc("The code of error.")
  code?: string;

  @doc("The message of error.")
  message?: string;
}

@doc("The settings of config server.")
model ConfigServerSettings {
  @doc("Property of git environment.")
  gitProperty?: ConfigServerGitProperty;
}

@doc("Property of git.")
model ConfigServerGitProperty {
  @doc("Repositories of git.")
  repositories?: GitPatternRepository[];

  @doc("URI of the repository")
  uri: string;

  @doc("Label of the repository")
  label?: string;

  @doc("Searching path of the repository")
  searchPaths?: string[];

  @doc("Username of git repository basic auth.")
  username?: string;

  @doc("Password of git repository basic auth.")
  password?: string;

  @doc("Public sshKey of git repository.")
  hostKey?: string;

  @doc("SshKey algorithm of git repository.")
  hostKeyAlgorithm?: string;

  @doc("Private sshKey algorithm of git repository.")
  privateKey?: string;

  @doc("Strict host key checking or not.")
  strictHostKeyChecking?: boolean;
}

@doc("Git repository property payload for config server")
model GitPatternRepository {
  @doc("Name of the repository")
  name: string;

  @doc("Collection of pattern of the repository")
  pattern?: string[];

  @doc("URI of the repository")
  uri: string;

  @doc("Label of the repository")
  label?: string;

  @doc("Searching path of the repository")
  searchPaths?: string[];

  @doc("Username of git repository basic auth.")
  username?: string;

  @doc("Password of git repository basic auth.")
  password?: string;

  @doc("Public sshKey of git repository.")
  hostKey?: string;

  @doc("SshKey algorithm of git repository.")
  hostKeyAlgorithm?: string;

  @doc("Private sshKey algorithm of git repository.")
  privateKey?: string;

  @doc("Strict host key checking or not.")
  strictHostKeyChecking?: boolean;
}

@doc("Validation result for config server settings")
model ConfigServerSettingsValidateResult {
  @doc("Indicate if the config server settings are valid")
  isValid?: boolean;

  @doc("The detail validation results")
  details?: ConfigServerSettingsErrorRecord[];
}

@doc("Error record of the config server settings")
model ConfigServerSettingsErrorRecord {
  @doc("The name of the config server settings error record")
  name?: string;

  @doc("The uri of the config server settings error record")
  uri?: string;

  @doc("The detail error messages of the record")
  messages?: string[];
}

@doc("Application Configuration Service properties payload")
model ConfigurationServiceProperties {
  @doc("State of the Application Configuration Service.")
  @visibility("read")
  provisioningState?: ConfigurationServiceProvisioningState;

  @doc("The requested resource quantity for required CPU and Memory.")
  @visibility("read")
  resourceRequests?: ConfigurationServiceResourceRequests;

  @doc("Collection of instances belong to Application Configuration Service.")
  @visibility("read")
  instances?: ConfigurationServiceInstance[];

  @doc("The settings of Application Configuration Service.")
  settings?: ConfigurationServiceSettings;
}

@doc("Resource request payload of Application Configuration Service")
model ConfigurationServiceResourceRequests {
  @doc("Cpu allocated to each Application Configuration Service instance")
  @visibility("read")
  cpu?: string;

  @doc("Memory allocated to each Application Configuration Service instance")
  @visibility("read")
  memory?: string;

  @doc("Instance count of the Application Configuration Service")
  @visibility("read")
  instanceCount?: int32;
}

@doc("Collection of instances belong to the Application Configuration Service")
model ConfigurationServiceInstance {
  @doc("Name of the Application Configuration Service instance")
  @visibility("read")
  name?: string;

  @doc("Status of the Application Configuration Service instance")
  @visibility("read")
  status?: string;
}

@doc("The settings of Application Configuration Service.")
model ConfigurationServiceSettings {
  @doc("Property of git environment.")
  gitProperty?: ConfigurationServiceGitProperty;
}

@doc("Property of git environment.")
model ConfigurationServiceGitProperty {
  @doc("Repositories of Application Configuration Service git property.")
  repositories?: ConfigurationServiceGitRepository[];
}

@doc("Git repository property payload for Application Configuration Service")
model ConfigurationServiceGitRepository {
  @doc("Name of the repository")
  name: string;

  @doc("Collection of patterns of the repository")
  patterns: string[];

  @doc("URI of the repository")
  uri: string;

  @doc("Label of the repository")
  label: string;

  @doc("Searching path of the repository")
  searchPaths?: string[];

  @doc("Username of git repository basic auth.")
  username?: string;

  @doc("Password of git repository basic auth.")
  password?: string;

  @doc("Public sshKey of git repository.")
  hostKey?: string;

  @doc("SshKey algorithm of git repository.")
  hostKeyAlgorithm?: string;

  @doc("Private sshKey algorithm of git repository.")
  privateKey?: string;

  @doc("Strict host key checking or not.")
  strictHostKeyChecking?: boolean;
}

@doc("Validation result for configuration service settings")
model ConfigurationServiceSettingsValidateResult {
  @doc("Validation result for configuration service settings")
  gitPropertyValidationResult?: ConfigurationServiceGitPropertyValidateResult;
}

@doc("Validation result for configuration service settings")
model ConfigurationServiceGitPropertyValidateResult {
  @doc("Indicate if the configuration service settings are valid")
  isValid?: boolean;

  @doc("The detail validation results")
  gitReposValidationResult?: ValidationMessages[];
}

@doc("Validate messages of the configuration service git repositories")
model ValidationMessages {
  @doc("The name of the configuration service git repository.")
  name?: string;

  @doc("Detailed validation messages.")
  messages?: string[];
}

@doc("Service Registry properties payload")
model ServiceRegistryProperties {
  @doc("State of the Service Registry.")
  @visibility("read")
  provisioningState?: ServiceRegistryProvisioningState;

  @doc("The requested resource quantity for required CPU and Memory.")
  @visibility("read")
  resourceRequests?: ServiceRegistryResourceRequests;

  @doc("Collection of instances belong to Service Registry.")
  @visibility("read")
  instances?: ServiceRegistryInstance[];
}

@doc("Resource request payload of Service Registry")
model ServiceRegistryResourceRequests {
  @doc("Cpu allocated to each Service Registry instance")
  @visibility("read")
  cpu?: string;

  @doc("Memory allocated to each Service Registry instance")
  @visibility("read")
  memory?: string;

  @doc("Instance count of the Service Registry")
  @visibility("read")
  instanceCount?: int32;
}

@doc("Collection of instances belong to the Service Registry")
model ServiceRegistryInstance {
  @doc("Name of the Service Registry instance")
  @visibility("read")
  name?: string;

  @doc("Status of the Service Registry instance")
  @visibility("read")
  status?: string;
}

@doc("Build service resource properties payload")
model BuildServiceProperties {
  @doc("The installed KPack version in this build service.")
  kPackVersion?: string;

  @doc("Provisioning state of the KPack build result")
  @visibility("read")
  provisioningState?: BuildServiceProvisioningState;

  @doc("The runtime resource configuration of this build service.")
  resourceRequests?: BuildServicePropertiesResourceRequests;
}

@doc("The runtime resource configuration of this build service.")
model BuildServicePropertiesResourceRequests {
  @doc("vCPU allocated to the entire build service node pool.")
  @visibility("read")
  cpu?: string;

  @doc("Memory allocated to the entire build service node pool.")
  @visibility("read")
  memory?: string;
}

@doc("Build resource properties payload")
model BuildProperties {
  @doc("The relative path of source code")
  relativePath?: string;

  @doc("The resource id of builder to build the source code")
  builder?: string;

  @doc("The resource id of agent pool")
  agentPool?: string;

  @doc("Provisioning state of the KPack build result")
  @visibility("read")
  provisioningState?: BuildProvisioningState;

  @doc("The environment variables for this build")
  env?: Record<string>;

  @doc(" The build result triggered by this build")
  @visibility("read")
  triggeredBuildResult?: TriggeredBuildResult;

  @doc("The customized build resource for this build")
  resourceRequests?: BuildResourceRequests;
}

@doc("The build result triggered by a build")
model TriggeredBuildResult {
  @doc("The unique build id of this build result")
  id?: string;
}

@doc("Resource request payload of Build Resource.")
model BuildResourceRequests {
  @doc("""
Optional Cpu allocated to the build resource. 1 core can be represented by 1 or 1000m. 
The default value is 1, this should not exceed build service agent pool cpu size.
""")
  cpu?: string;

  @doc("""
Optional Memory allocated to the build resource. 1 GB can be represented by 1Gi or 1024Mi. 
The default value is 2Gi, this should not exceed build service agent pool memory size.
""")
  memory?: string;
}

@doc("Properties of a buildpack binding")
model BuildpackBindingProperties {
  @doc("Buildpack Binding Type")
  bindingType?: BindingType;

  @doc("State of the Buildpack Binding.")
  @visibility("read")
  provisioningState?: BuildpackBindingProvisioningState;

  @doc("The object describes the buildpack binding launch properties")
  launchProperties?: BuildpackBindingLaunchProperties;
}

@doc("Buildpack Binding Launch Properties")
model BuildpackBindingLaunchProperties {
  @doc("Non-sensitive properties for launchProperties")
  properties?: Record<string>;

  @doc("Sensitive properties for launchProperties")
  secrets?: Record<string>;
}

@doc("Build result resource properties payload")
model BuildResultProperties {
  @doc("The name of this build result")
  name?: string;

  @doc("Provisioning state of the KPack build result")
  @visibility("read")
  provisioningState?: BuildResultProvisioningState;

  @doc("The build pod name which can be used to get the build log streaming.")
  buildPodName?: string;

  @doc("All of the build stage (init-container and container) resources in build pod.")
  @visibility("read")
  buildStages?: BuildStageProperties[];
}

@doc("The build stage (init-container and container) resources in build pod.")
model BuildStageProperties {
  @doc("The name of this build stage resource.")
  @visibility("read")
  name?: string;

  @doc("The provisioning state of this build stage resource.")
  @visibility("read")
  status?: KPackBuildStageProvisioningState;
}

@doc("Build result log resource properties payload")
model BuildResultLog {
  @doc("The public download URL of this build result log")
  blobUrl?: string;
}

@doc("KPack Builder properties payload")
model BuilderProperties {
  @doc("Builder provision status.")
  @visibility("read")
  provisioningState?: BuilderProvisioningState;

  @doc("Builder cluster stack property.")
  stack?: StackProperties;

  @doc("Builder buildpack groups.")
  buildpackGroups?: BuildpacksGroupProperties[];
}

@doc("KPack ClusterStack properties payload")
model StackProperties {
  @doc("Id of the ClusterStack.")
  id?: string;

  @doc("Version of the ClusterStack")
  version?: string;
}

@doc("Buildpack group properties of the Builder")
model BuildpacksGroupProperties {
  @doc("Buildpack group name")
  name?: string;

  @doc("Buildpacks in the buildpack group")
  buildpacks?: BuildpackProperties[];
}

@doc("Buildpack properties payload")
model BuildpackProperties {
  @doc("Id of the buildpack")
  id?: string;
}

@doc("Resource upload definition payload")
model ResourceUploadDefinition {
  @doc("Source relative path")
  relativePath?: string;

  @doc("Upload URL")
  uploadUrl?: string;
}

@doc("Supported buildpack resource properties")
model SupportedBuildpackResourceProperties {
  @doc("The id of supported buildpack")
  buildpackId?: string;
}

@doc("Supported stack resource properties")
model SupportedStackResourceProperties {
  @doc("The id of supported stack")
  stackId?: string;

  @doc("The version of supported stack")
  version?: string;
}

@doc("Build service agent pool properties")
model BuildServiceAgentPoolProperties {
  @doc("Provisioning state of the build service agent pool")
  @visibility("read")
  provisioningState?: string;

  @doc("build service agent pool size properties")
  poolSize?: BuildServiceAgentPoolSizeProperties;
}

@doc("Build service agent pool size properties")
model BuildServiceAgentPoolSizeProperties {
  @doc("The name of build service agent pool size")
  name?: string;

  @doc("The cpu property of build service agent pool size")
  @visibility("read")
  cpu?: string;

  @doc("The memory property of build service agent pool size")
  @visibility("read")
  memory?: string;
}

@doc("Monitoring Setting properties payload")
model MonitoringSettingProperties {
  @doc("State of the Monitoring Setting.")
  @visibility("read")
  provisioningState?: MonitoringSettingState;

  @doc("Error when apply Monitoring Setting changes.")
  error?: Error;

  @doc("Indicates whether enable the trace functionality, which will be deprecated since api version 2020-11-01-preview. Please leverage appInsightsInstrumentationKey to indicate if monitoringSettings enabled or not")
  traceEnabled?: boolean;

  @doc("Target application insight instrumentation key, null or whitespace include empty will disable monitoringSettings")
  appInsightsInstrumentationKey?: string;

  @doc("Indicates the sampling rate of application insight agent, should be in range [0.0, 100.0]")
  @maxValue(100)
  appInsightsSamplingRate?: float32;

  @doc("Indicates the versions of application insight agent")
  appInsightsAgentVersions?: ApplicationInsightsAgentVersions;
}

@doc("Application Insights agent versions properties payload")
model ApplicationInsightsAgentVersions {
  @doc("Indicates the version of application insight java agent")
  @visibility("read")
  java?: string;
}

@doc("App resource properties payload")
model AppResourceProperties {
  @doc("Indicates whether the App exposes public endpoint")
  public?: boolean;

  @doc("URL of the App")
  @visibility("read")
  url?: string;

  @doc("Collection of addons")
  addonConfigs?: Record<Record<Record<unknown>>>;

  @doc("Provisioning state of the App")
  @visibility("read")
  provisioningState?: AppResourceProvisioningState;

  @doc("Fully qualified dns Name.")
  @visibility("read")
  fqdn?: string;

  @doc("Indicate if only https is allowed.")
  httpsOnly?: boolean;

  @doc("Temporary disk settings")
  temporaryDisk?: TemporaryDisk;

  @doc("Persistent disk settings")
  persistentDisk?: PersistentDisk;

  @doc("List of custom persistent disks")
  customPersistentDisks?: CustomPersistentDiskResource[];

  @doc("Indicate if end to end TLS is enabled.")
  enableEndToEndTLS?: boolean;

  @doc("Collection of loaded certificates")
  loadedCertificates?: LoadedCertificate[];

  @doc("Additional App settings in vnet injection instance")
  vnetAddons?: AppVNetAddons;

  @doc("App ingress settings payload.")
  ingressSettings?: IngressSettings;
}

@doc("Temporary disk payload")
model TemporaryDisk {
  @doc("Size of the temporary disk in GB")
  @maxValue(5)
  sizeInGB?: int32;

  @doc("Mount path of the temporary disk")
  mountPath?: string;
}

@doc("Persistent disk payload")
model PersistentDisk {
  @doc("Size of the persistent disk in GB")
  @maxValue(50)
  sizeInGB?: int32;

  @doc("Size of the used persistent disk in GB")
  @visibility("read")
  @maxValue(50)
  usedInGB?: int32;

  @doc("Mount path of the persistent disk")
  mountPath?: string;
}

@doc("Custom persistent disk resource payload.")
model CustomPersistentDiskResource {
  @doc("Properties of the custom persistent disk resource payload.")
  customPersistentDiskProperties?: CustomPersistentDiskProperties;

  @doc("The resource id of Azure Spring Apps Storage resource.")
  storageId: string;
}

@doc("Custom persistent disk resource payload.")
@discriminator("type")
model CustomPersistentDiskProperties {
  @doc("The mount path of the persistent disk.")
  mountPath: string;

  @doc("Indicates whether the persistent disk is a readOnly one.")
  readOnly?: boolean;

  @doc("These are the mount options for a persistent disk.")
  mountOptions?: string[];
}

@doc("Loaded certificate payload")
model LoadedCertificate {
  @doc("Resource Id of loaded certificate")
  resourceId: string;

  @doc("Indicate whether the certificate will be loaded into default trust store, only work for Java runtime.")
  loadTrustStore?: boolean;
}

@doc("Additional App settings in vnet injection instance")
model AppVNetAddons {
  @doc("Indicates whether the App in vnet injection instance exposes endpoint which could be accessed from internet.")
  publicEndpoint?: boolean;

  @doc("URL of the App in vnet injection instance which could be accessed from internet")
  @visibility("read")
  publicEndpointUrl?: string;
}

@doc("App ingress settings payload.")
model IngressSettings {
  @doc("Ingress read time out in seconds.")
  readTimeoutInSeconds?: int32;

  @doc("Ingress send time out in seconds.")
  sendTimeoutInSeconds?: int32;

  @doc("Type of the affinity, set this to Cookie to enable session affinity.")
  sessionAffinity?: SessionAffinity;

  @doc("Time in seconds until the cookie expires.")
  sessionCookieMaxAge?: int32;

  @doc("How ingress should communicate with this app backend service.")
  backendProtocol?: BackendProtocol;

  @doc("Client-Certification Authentication.")
  clientAuth?: IngressSettingsClientAuth;
}

@doc("Client-Certification Authentication.")
model IngressSettingsClientAuth {
  @doc("Collection of certificate resource id.")
  certificates?: string[];
}

@doc("The details of the user-assigned managed identity assigned to an App.")
model UserAssignedManagedIdentity {
  @doc("Principal Id of user-assigned managed identity.")
  @visibility("read")
  principalId?: string;

  @doc("Client Id of user-assigned managed identity.")
  @visibility("read")
  clientId?: string;
}

@doc("Object that includes an array of Deployment resource name and set them as active.")
model ActiveDeploymentCollection {
  @doc("Collection of Deployment name.")
  activeDeploymentNames?: string[];
}

@doc("Binding resource properties payload")
model BindingResourceProperties {
  @doc("The name of the bound resource")
  @visibility("read")
  resourceName?: string;

  @doc("The standard Azure resource type of the bound resource")
  @visibility("read")
  resourceType?: string;

  @doc("The Azure resource id of the bound resource")
  resourceId?: string;

  @doc("The key of the bound resource")
  key?: string;

  @doc("Binding parameters of the Binding resource")
  bindingParameters?: Record<Record<unknown>>;

  @doc("The generated Spring Boot property file for this binding. The secret will be deducted.")
  @visibility("read")
  generatedProperties?: string;

  @doc("Creation time of the Binding resource")
  @visibility("read")
  createdAt?: string;

  @doc("Update time of the Binding resource")
  @visibility("read")
  updatedAt?: string;
}

@doc("Storage resource payload.")
@discriminator("storageType")
model StorageProperties {}

@doc("Certificate resource payload.")
@discriminator("type")
model CertificateProperties {
  @doc("The thumbprint of certificate.")
  @visibility("read")
  thumbprint?: string;

  @doc("The issuer of certificate.")
  @visibility("read")
  issuer?: string;

  @doc("The issue date of certificate.")
  @visibility("read")
  issuedDate?: string;

  @doc("The expiration date of certificate.")
  @visibility("read")
  expirationDate?: string;

  @doc("The activate date of certificate.")
  @visibility("read")
  activateDate?: string;

  @doc("The subject name of certificate.")
  @visibility("read")
  subjectName?: string;

  @doc("The domain list of certificate.")
  @visibility("read")
  dnsNames?: string[];

  @doc("Provisioning state of the Certificate")
  @visibility("read")
  provisioningState?: CertificateResourceProvisioningState;
}

@doc("Name availability parameters payload")
model NameAvailabilityParameters {
  @doc("Type of the resource to check name availability")
  type: string;

  @doc("Name to be checked")
  name: string;
}

@doc("Name availability result payload")
model NameAvailability {
  @doc("Indicates whether the name is available")
  nameAvailable?: boolean;

  @doc("Reason why the name is not available")
  reason?: string;

  @doc("Message why the name is not available")
  message?: string;
}

@doc("Custom domain of app resource payload.")
model CustomDomainProperties {
  @doc("The thumbprint of bound certificate.")
  thumbprint?: string;

  @doc("The app name of domain.")
  @visibility("read")
  appName?: string;

  @doc("The bound certificate name of domain.")
  certName?: string;

  @doc("Provisioning state of the Domain")
  @visibility("read")
  provisioningState?: CustomDomainResourceProvisioningState;
}

@doc("Custom domain validate payload.")
model CustomDomainValidatePayload {
  @doc("Name to be validated")
  name: string;
}

@doc("Validation result for custom domain.")
model CustomDomainValidateResult {
  @doc("Indicates if domain name is valid.")
  isValid?: boolean;

  @doc("Message of why domain name is invalid.")
  message?: string;
}

@doc("Deployment resource properties payload")
model DeploymentResourceProperties {
  @doc("Uploaded source information of the deployment.")
  source?: UserSourceInfo;

  @doc("Deployment settings of the Deployment")
  deploymentSettings?: DeploymentSettings;

  @doc("Provisioning state of the Deployment")
  @visibility("read")
  provisioningState?: DeploymentResourceProvisioningState;

  @doc("Status of the Deployment")
  @visibility("read")
  status?: DeploymentResourceStatus;

  @doc("Indicates whether the Deployment is active")
  active?: boolean;

  @doc("Collection of instances belong to the Deployment")
  @visibility("read")
  instances?: DeploymentInstance[];
}

@doc("Source information for a deployment")
@discriminator("type")
model UserSourceInfo {
  @doc("Version of the source")
  version?: string;
}

@doc("Deployment settings payload")
model DeploymentSettings {
  @doc("The requested resource quantity for required CPU and Memory. It is recommended that using this field to represent the required CPU and Memory, the old field cpu and memoryInGB will be deprecated later.")
  resourceRequests?: ResourceRequests;

  @doc("Collection of environment variables")
  environmentVariables?: Record<string>;

  @doc("Collection of addons")
  addonConfigs?: Record<Record<Record<unknown>>>;

  @doc("Periodic probe of App Instance liveness. App Instance will be restarted if the probe fails. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes")
  livenessProbe?: Probe;

  @doc("Periodic probe of App Instance service readiness. App Instance will be removed from service endpoints if the probe fails. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes")
  readinessProbe?: Probe;

  @doc("StartupProbe indicates that the App Instance has successfully initialized. If specified, no other probes are executed until this completes successfully. If this probe fails, the Pod will be restarted, just as if the livenessProbe failed. This can be used to provide different probe parameters at the beginning of a App Instance's lifecycle, when it might take a long time to load data or warm a cache, than during steady-state operation. This cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes")
  startupProbe?: Probe;

  @doc("Optional duration in seconds the App Instance needs to terminate gracefully. May be decreased in delete request. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). If this value is nil, the default grace period will be used instead. The grace period is the duration in seconds after the processes running in the App Instance are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. Defaults to 90 seconds.")
  terminationGracePeriodSeconds?: int32;

  @doc("Container liveness and readiness probe settings")
  containerProbeSettings?: ContainerProbeSettings;
}

@doc("Deployment resource request payload")
model ResourceRequests {
  @doc("Required CPU. 1 core can be represented by 1 or 1000m. This should be 500m or 1 for Basic tier, and {500m, 1, 2, 3, 4} for Standard tier.")
  cpu?: string;

  @doc("Required memory. 1 GB can be represented by 1Gi or 1024Mi. This should be {512Mi, 1Gi, 2Gi} for Basic tier, and {512Mi, 1Gi, 2Gi, ..., 8Gi} for Standard tier.")
  memory?: string;
}

@doc("Probe describes a health check to be performed against an App Instance to determine whether it is alive or ready to receive traffic.")
model Probe {
  @doc("The action of the probe.")
  probeAction?: ProbeAction;

  @doc("Indicate whether the probe is disabled.")
  disableProbe: boolean;

  @doc("Number of seconds after the App Instance has started before probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes")
  initialDelaySeconds?: int32;

  @doc("How often (in seconds) to perform the probe. Minimum value is 1.")
  periodSeconds?: int32;

  @doc("Number of seconds after which the probe times out. Minimum value is 1.")
  timeoutSeconds?: int32;

  @doc("Minimum consecutive failures for the probe to be considered failed after having succeeded. Minimum value is 1.")
  failureThreshold?: int32;

  @doc("Minimum consecutive successes for the probe to be considered successful after having failed. Must be 1 for liveness and startup. Minimum value is 1.")
  successThreshold?: int32;
}

@doc("The action of the probe.")
@discriminator("type")
model ProbeAction {}

@doc("Container liveness and readiness probe settings")
model ContainerProbeSettings {
  @doc("Indicates whether disable the liveness and readiness probe")
  disableProbe?: boolean;
}

@doc("Deployment instance payload")
model DeploymentInstance {
  @doc("Name of the deployment instance")
  @visibility("read")
  name?: string;

  @doc("Status of the deployment instance")
  @visibility("read")
  status?: string;

  @doc("Failed reason of the deployment instance")
  @visibility("read")
  reason?: string;

  @doc("Discovery status of the deployment instance")
  @visibility("read")
  discoveryStatus?: string;

  @doc("Start time of the deployment instance")
  @visibility("read")
  startTime?: string;

  @doc("Availability zone information of the deployment instance")
  @visibility("read")
  zone?: string;
}

@doc("A list of deployments resource ids.")
@pagedResult
model DeploymentList {
  @doc("A list of deployment resource ids.")
  @items
  deployments?: string[];
}

@doc("Remote debugging payload.")
model RemoteDebuggingPayload {
  @doc("Application debugging port.")
  port?: int32;
}

@doc("Remote debugging config.")
model RemoteDebugging {
  @doc("Application debugging port")
  port?: int32;

  @doc("Indicate if remote debugging is enabled")
  enabled?: boolean;
}

@doc("Log file URL payload")
model LogFileUrlResponse {
  @doc("URL of the log file")
  url: string;
}

@doc("Diagnostic parameters of diagnostic operations")
model DiagnosticParameters {
  @doc("App instance name")
  appInstance?: string;

  @doc("Your target file path in your own BYOS")
  filePath?: string;

  @doc("Duration of your JFR. 1 min can be represented by 1m or 60s.")
  duration?: string;
}

@doc("Operation detail payload")
model OperationDetail {
  @doc("Name of the operation")
  name?: string;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;

  @doc("Display of the operation")
  display?: OperationDisplay;

  @doc("Enum. Indicates the action type. \"Internal\" refers to actions that are for internal only APIs.")
  @visibility("read")
  actionType?: ActionType;

  @doc("Origin of the operation")
  origin?: string;

  @doc("Properties of the operation")
  properties?: OperationProperties;
}

@doc("Extra Operation properties")
model OperationProperties {
  @doc("Service specifications of the operation")
  serviceSpecification?: ServiceSpecification;
}

@doc("Service specification payload")
model ServiceSpecification {
  @doc("Specifications of the Log for Azure Monitoring")
  logSpecifications?: LogSpecification[];

  @doc("Specifications of the Metrics for Azure Monitoring")
  metricSpecifications?: MetricSpecification[];
}

@doc("Specifications of the Log for Azure Monitoring")
model LogSpecification {
  @doc("Name of the log")
  name?: string;

  @doc("Localized friendly display name of the log")
  displayName?: string;

  @doc("Blob duration of the log")
  blobDuration?: string;
}

@doc("Specifications of the Metrics for Azure Monitoring")
model MetricSpecification {
  @doc("Name of the metric")
  name?: string;

  @doc("Localized friendly display name of the metric")
  displayName?: string;

  @doc("Localized friendly description of the metric")
  displayDescription?: string;

  @doc("Unit that makes sense for the metric")
  unit?: string;

  @doc("Name of the metric category that the metric belongs to. A metric can only belong to a single category.")
  category?: string;

  @doc("Only provide one value for this field. Valid values: Average, Minimum, Maximum, Total, Count.")
  aggregationType?: string;

  @doc("Supported aggregation types")
  supportedAggregationTypes?: string[];

  @doc("Supported time grain types")
  supportedTimeGrainTypes?: string[];

  @doc("Optional. If set to true, then zero will be returned for time duration where no metric is emitted/published.")
  fillGapWithZero?: boolean;

  @doc("Dimensions of the metric")
  dimensions?: MetricDimension[];

  @doc("Name of the MDM namespace. Optional.")
  sourceMdmNamespace?: string;
}

@doc("Specifications of the Dimension of metrics")
model MetricDimension {
  @doc("Name of the dimension")
  name?: string;

  @doc("Localized friendly display name of the dimension")
  displayName?: string;

  @doc("Whether this dimension should be included for the Shoebox export scenario")
  toBeExportedForShoebox?: boolean;
}

model AvailableRuntimeVersions {
  @doc("A list of all supported runtime versions.")
  @visibility("read")
  value?: SupportedRuntimeVersion[];
}

@doc("Supported deployment runtime version descriptor.")
model SupportedRuntimeVersion {
  @doc("The raw value which could be passed to deployment CRUD operations.")
  value?: SupportedRuntimeValue;

  @doc("The platform of this runtime version (possible values: \"Java\" or \".NET\").")
  platform?: SupportedRuntimePlatform;

  @doc("The detailed version (major.minor) of the platform.")
  version?: string;
}

@doc("Object that includes an array of Azure Spring Apps SKU and a possible link for next set")
model ResourceSkuCollection is Azure.Core.Page<ResourceSku>;

@doc("The SKU capacity")
model SkuCapacity {
  @doc("Gets or sets the minimum.")
  minimum: int32;

  @doc("Gets or sets the maximum.")
  maximum?: int32;

  @doc("Gets or sets the default.")
  default?: int32;

  @doc("Gets or sets the type of the scale.")
  scaleType?: SkuScaleType;
}

@doc("Locations and availability zones where the SKU is available")
model ResourceSkuLocationInfo {
  @doc("Gets location of the SKU")
  location?: string;

  @doc("Gets list of availability zones where the SKU is supported.")
  zones?: string[];

  @doc("Gets details of capabilities available to a SKU in specific zones.")
  zoneDetails?: ResourceSkuZoneDetails[];
}

@doc("Details of capabilities available to a SKU in specific zones")
model ResourceSkuZoneDetails {
  @doc("""
Gets the set of zones that the SKU is available in with the
specified capabilities.
""")
  name?: string[];

  @doc("""
Gets a list of capabilities that are available for the SKU in the
specified list of zones.
""")
  capabilities?: ResourceSkuCapabilities[];
}

model ResourceSkuCapabilities {
  @doc("Gets an invariant to describe the feature.")
  name?: string;

  @doc("Gets an invariant if the feature is measured by quantity.")
  value?: string;
}

@doc("Restrictions where the SKU cannot be used")
model ResourceSkuRestrictions {
  @doc("Gets the type of restrictions. Possible values include: 'Location', 'Zone'")
  type?: ResourceSkuRestrictionsType;

  @doc("""
Gets the value of restrictions. If the restriction type is set to
location. This would be different locations where the SKU is restricted.
""")
  values?: string[];

  @doc("Gets the information about the restriction where the SKU cannot be used.")
  restrictionInfo?: ResourceSkuRestrictionInfo;

  @doc("Gets the reason for restriction. Possible values include: 'QuotaId', 'NotAvailableForSubscription'")
  reasonCode?: ResourceSkuRestrictionsReasonCode;
}

@doc("Information about the restriction where the SKU cannot be used")
model ResourceSkuRestrictionInfo {
  @doc("Gets locations where the SKU is restricted")
  locations?: string[];

  @doc("Gets list of availability zones where the SKU is restricted.")
  zones?: string[];
}

@doc("Spring Cloud Gateway properties payload")
model GatewayProperties {
  @doc("State of the Spring Cloud Gateway.")
  @visibility("read")
  provisioningState?: GatewayProvisioningState;

  @doc("Indicates whether the Spring Cloud Gateway exposes endpoint.")
  public?: boolean;

  @doc("URL of the Spring Cloud Gateway, exposed when 'public' is true.")
  @visibility("read")
  url?: string;

  @doc("Indicate if only https is allowed.")
  httpsOnly?: boolean;

  @doc("Single sign-on related configuration")
  ssoProperties?: SsoProperties;

  @doc("API metadata property for Spring Cloud Gateway")
  apiMetadataProperties?: GatewayApiMetadataProperties;

  @doc("Cross-Origin Resource Sharing property")
  corsProperties?: GatewayCorsProperties;

  @doc("The requested resource quantity for required CPU and Memory.")
  resourceRequests?: GatewayResourceRequests;

  @doc("Collection of instances belong to Spring Cloud Gateway.")
  @visibility("read")
  instances?: GatewayInstance[];

  @doc("Properties of the Spring Cloud Gateway Operator.")
  @visibility("read")
  operatorProperties?: GatewayOperatorProperties;
}

@doc("Single sign-on related configuration")
model SsoProperties {
  @doc("It defines the specific actions applications can be allowed to do on a user's behalf")
  scope?: string[];

  @doc("The public identifier for the application")
  clientId?: string;

  @doc("The secret known only to the application and the authorization server")
  clientSecret?: string;

  @doc("The URI of Issuer Identifier")
  issuerUri?: string;
}

@doc("API metadata property for Spring Cloud Gateway")
model GatewayApiMetadataProperties {
  @doc("Title describing the context of the APIs available on the Gateway instance (default: `Spring Cloud Gateway for K8S`)")
  title?: string;

  @doc("Detailed description of the APIs available on the Gateway instance (default: `Generated OpenAPI 3 document that describes the API routes configured.`)")
  description?: string;

  @doc("Location of additional documentation for the APIs available on the Gateway instance")
  documentation?: string;

  @doc("Version of APIs available on this Gateway instance (default: `unspecified`).")
  version?: string;

  @doc("Base URL that API consumers will use to access APIs on the Gateway instance.")
  serverUrl?: string;
}

@doc("Cross-Origin Resource Sharing property")
model GatewayCorsProperties {
  @doc("Allowed origins to make cross-site requests. The special value `*` allows all domains.")
  allowedOrigins?: string[];

  @doc("Allowed HTTP methods on cross-site requests. The special value `*` allows all methods. If not set, `GET` and `HEAD` are allowed by default.")
  allowedMethods?: string[];

  @doc("Allowed headers in cross-site requests. The special value `*` allows actual requests to send any header.")
  allowedHeaders?: string[];

  @doc("How long, in seconds, the response from a pre-flight request can be cached by clients.")
  maxAge?: int32;

  @doc("Whether user credentials are supported on cross-site requests. Valid values: `true`, `false`.")
  allowCredentials?: boolean;

  @doc("HTTP response headers to expose for cross-site requests.")
  exposedHeaders?: string[];
}

@doc("Resource request payload of Spring Cloud Gateway.")
model GatewayResourceRequests {
  @doc("Cpu allocated to each Spring Cloud Gateway instance.")
  cpu?: string;

  @doc("Memory allocated to each Spring Cloud Gateway instance.")
  memory?: string;
}

@doc("Collection of instances belong to the Spring Cloud Gateway")
model GatewayInstance {
  @doc("Name of the Spring Cloud Gateway instance")
  @visibility("read")
  name?: string;

  @doc("Status of the Spring Cloud Gateway instance")
  @visibility("read")
  status?: string;
}

@doc("Properties of the Spring Cloud Gateway Operator.")
model GatewayOperatorProperties {
  @doc("The requested resource quantity for required CPU and Memory.")
  @visibility("read")
  resourceRequests?: GatewayOperatorResourceRequests;

  @doc("Collection of instances belong to Spring Cloud Gateway operator.")
  @visibility("read")
  instances?: GatewayInstance[];
}

@doc("Properties of the Spring Cloud Gateway Operator.")
model GatewayOperatorResourceRequests {
  @doc("Cpu allocated to each Spring Cloud Gateway Operator instance.")
  @visibility("read")
  cpu?: string;

  @doc("Memory allocated to each Spring Cloud Gateway Operator instance.")
  @visibility("read")
  memory?: string;

  @doc("Instance count of the Spring Cloud Gateway Operator.")
  @visibility("read")
  instanceCount?: int32;
}

@doc("API route config of the Spring Cloud Gateway")
model GatewayRouteConfigProperties {
  @doc("State of the Spring Cloud Gateway route config.")
  @visibility("read")
  provisioningState?: GatewayProvisioningState;

  @doc("The resource Id of the Azure Spring Apps app, required unless route defines `uri`.")
  appResourceId?: string;

  @doc("OpenAPI properties of Spring Cloud Gateway route config.")
  openApi?: GatewayRouteConfigOpenApiProperties;

  @doc("Protocol of routed Azure Spring Apps applications.")
  protocol?: GatewayRouteConfigProtocol;

  @doc("Array of API routes, each route contains properties such as `title`, `uri`, `ssoEnabled`, `predicates`, `filters`.")
  routes?: GatewayApiRoute[];
}

@doc("OpenAPI properties of Spring Cloud Gateway route config.")
model GatewayRouteConfigOpenApiProperties {
  @doc("The URI of OpenAPI specification.")
  uri?: string;
}

@doc("API route config of the Spring Cloud Gateway")
model GatewayApiRoute {
  @doc("A title, will be applied to methods in the generated OpenAPI documentation.")
  title?: string;

  @doc("A description, will be applied to methods in the generated OpenAPI documentation.")
  description?: string;

  @doc("Full uri, will override `appName`.")
  uri?: string;

  @doc("Enable sso validation.")
  ssoEnabled?: boolean;

  @doc("Pass currently-authenticated user's identity token to application service, default is 'false'")
  tokenRelay?: boolean;

  @doc("A number of conditions to evaluate a route for each request. Each predicate may be evaluated against request headers and parameter values. All of the predicates associated with a route must evaluate to true for the route to be matched to the request.")
  predicates?: string[];

  @doc("To modify the request before sending it to the target endpoint, or the received response.")
  filters?: string[];

  @doc("Route processing order.")
  order?: int32;

  @doc("Classification tags, will be applied to methods in the generated OpenAPI documentation.")
  tags?: string[];
}

@doc("The properties of custom domain for Spring Cloud Gateway")
model GatewayCustomDomainProperties {
  @doc("The thumbprint of bound certificate.")
  thumbprint?: string;
}

@doc("API portal properties payload")
model ApiPortalProperties {
  @doc("State of the API portal.")
  @visibility("read")
  provisioningState?: ApiPortalProvisioningState;

  @doc("Indicates whether the API portal exposes endpoint.")
  public?: boolean;

  @doc("URL of the API portal, exposed when 'public' is true.")
  @visibility("read")
  url?: string;

  @doc("Indicate if only https is allowed.")
  httpsOnly?: boolean;

  @doc("The array of resource Ids of gateway to integrate with API portal.")
  gatewayIds?: string[];

  @doc("Collection of OpenAPI source URL locations.")
  sourceUrls?: string[];

  @doc("Single sign-on related configuration")
  ssoProperties?: SsoProperties;

  @doc("The requested resource quantity for required CPU and Memory.")
  @visibility("read")
  resourceRequests?: ApiPortalResourceRequests;

  @doc("Collection of instances belong to API portal.")
  @visibility("read")
  instances?: ApiPortalInstance[];
}

@doc("Resource requests of the API portal")
model ApiPortalResourceRequests {
  @doc("Cpu allocated to each API portal instance")
  @visibility("read")
  cpu?: string;

  @doc("Memory allocated to each API portal instance")
  @visibility("read")
  memory?: string;
}

@doc("Collection of instances belong to the API portal")
model ApiPortalInstance {
  @doc("Name of the API portal instance")
  @visibility("read")
  name?: string;

  @doc("Status of the API portal instance")
  @visibility("read")
  status?: string;
}

@doc("The properties of custom domain for API portal")
model ApiPortalCustomDomainProperties {
  @doc("The thumbprint of bound certificate.")
  thumbprint?: string;
}

@doc("Properties of certificate imported from key vault.")
model KeyVaultCertificateProperties extends CertificateProperties {
  @doc("The vault uri of user key vault.")
  vaultUri: string;

  @doc("The certificate name of key vault.")
  keyVaultCertName: string;

  @doc("The certificate version of key vault.")
  certVersion?: string;

  @doc("Optional. If set to true, it will not import private key from key vault.")
  excludePrivateKey?: boolean;

  @doc("The type of the certificate source.")
  type: "KeyVaultCertificate";
}

@doc("Properties of certificate imported from key vault.")
model ContentCertificateProperties extends CertificateProperties {
  @doc("The content of uploaded certificate.")
  @visibility("create", "update")
  content?: string;

  @doc("The type of the certificate source.")
  type: "ContentCertificate";
}

@doc("storage resource of type Azure Storage Account.")
model StorageAccount extends StorageProperties {
  @doc("The account name of the Azure Storage Account.")
  accountName: string;

  @doc("The account key of the Azure Storage Account.")
  @visibility("create", "update")
  accountKey: string;

  @doc("The type of the storage.")
  storageType: "StorageAccount";
}

@doc("The properties of the Azure File volume. Azure File shares are mounted as volumes.")
model AzureFileVolume extends CustomPersistentDiskProperties {
  @doc("The share name of the Azure File share.")
  shareName: string;

  @doc("The type of the underlying resource to mount as a persistent disk.")
  type: "AzureFileVolume";
}

@doc("Source with uploaded location")
@discriminator("type")
model UploadedUserSourceInfo extends UserSourceInfo {
  @doc("Relative path of the storage which stores the source")
  relativePath?: string;
}

@doc("Uploaded Jar binary for a deployment")
model JarUploadedUserSourceInfo extends UploadedUserSourceInfo {
  @doc("Runtime version of the Jar file")
  runtimeVersion?: string;

  @doc("JVM parameter")
  jvmOptions?: string;

  @doc("Type of the source uploaded")
  type: "Jar";
}

@doc("Uploaded Java source code binary for a deployment")
model SourceUploadedUserSourceInfo extends UploadedUserSourceInfo {
  @doc("""
Selector for the artifact to be used for the deployment for multi-module projects. This should be
the relative path to the target module/project.
""")
  artifactSelector?: string;

  @doc("Runtime version of the source file")
  runtimeVersion?: string;

  @doc("Type of the source uploaded")
  type: "Source";
}

@doc("Uploaded Jar binary for a deployment")
model NetCoreZipUploadedUserSourceInfo extends UploadedUserSourceInfo {
  @doc("The path to the .NET executable relative to zip root")
  netCoreMainEntryPath?: string;

  @doc("Runtime version of the .Net file")
  runtimeVersion?: string;

  @doc("Type of the source uploaded")
  type: "NetCoreZip";
}

@doc("Reference to a build result")
model BuildResultUserSourceInfo extends UserSourceInfo {
  @doc("Resource id of an existing succeeded build result under the same Spring instance.")
  buildResultId?: string;

  @doc("Type of the source uploaded")
  type: "BuildResult";
}

@doc("Custom container user source info")
model CustomContainerUserSourceInfo extends UserSourceInfo {
  @doc("Custom container payload")
  customContainer?: CustomContainer;

  @doc("Type of the source uploaded")
  type: "Container";
}

@doc("Custom container payload")
model CustomContainer {
  @doc("The name of the registry that contains the container image")
  server?: string;

  @doc("Container image of the custom container. This should be in the form of <repository>:<tag> without the server name of the registry")
  containerImage?: string;

  @doc("Entrypoint array. Not executed within a shell. The docker image's ENTRYPOINT is used if this is not provided.")
  command?: string[];

  @doc("Arguments to the entrypoint. The docker image's CMD is used if this is not provided.")
  args?: string[];

  @doc("Credential of the image registry")
  imageRegistryCredential?: ImageRegistryCredential;

  @doc("Language framework of the container image uploaded")
  languageFramework?: string;
}

@doc("Credential of the image registry")
model ImageRegistryCredential {
  @doc("The username of the image registry credential")
  username?: string;

  @doc("The password of the image registry credential")
  password?: string;
}

@doc("HTTPGetAction describes an action based on HTTP Get requests.")
model HttpGetAction extends ProbeAction {
  @doc("Path to access on the HTTP server.")
  path?: string;

  @doc("""
Scheme to use for connecting to the host. Defaults to HTTP.

Possible enum values:
 - `\"HTTP\"` means that the scheme used will be http://
 - `\"HTTPS\"` means that the scheme used will be https://
""")
  scheme?: HttpSchemeType;

  @doc("The type of the action to take to perform the health check.")
  type: "HTTPGetAction";
}

@doc("ExecAction describes a \"run in container\" action.")
model ExecAction extends ProbeAction {
  @doc("Command is the command line to execute inside the container, the working directory for the command is root ('/') in the container's filesystem. The command is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.")
  command?: string[];

  @doc("The type of the action to take to perform the health check.")
  type: "ExecAction";
}

@doc("TCPSocketAction describes an action based on opening a socket")
model TCPSocketAction extends ProbeAction {
  @doc("The type of the action to take to perform the health check.")
  type: "TCPSocketAction";
}
