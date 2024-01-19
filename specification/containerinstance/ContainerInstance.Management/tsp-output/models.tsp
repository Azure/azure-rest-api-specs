import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ContainerInstance;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The protocol associated with the port.")
enum ContainerNetworkProtocol {
  TCP,
  UDP,
}

@doc("The SKU of the GPU resource.")
enum GpuSku {
  K80,
  P100,
  V100,
}

@doc("The scheme.")
enum Scheme {
  http,
  https,
}

@doc("""
Restart policy for all containers within the container group. 
- `Always` Always restart
- `OnFailure` Restart on failure
- `Never` Never restart

""")
enum ContainerGroupRestartPolicy {
  Always,
  OnFailure,
  Never,
}

@doc("The protocol associated with the port.")
enum ContainerGroupNetworkProtocol {
  TCP,
  UDP,
}

@doc("Specifies if the IP is exposed to the public internet or private VNET.")
enum ContainerGroupIpAddressType {
  Public,
  Private,
}

@doc("The value representing the security enum. The 'Unsecure' value is the default value if not selected and means the object's domain name label is not secured against subdomain takeover. The 'TenantReuse' value is the default value if selected and means the object's domain name label can be reused within the same tenant. The 'SubscriptionReuse' value means the object's domain name label can be reused within the same subscription. The 'ResourceGroupReuse' value means the object's domain name label can be reused within the same resource group. The 'NoReuse' value means the object's domain name label cannot be reused within the same resource group, subscription, or tenant.")
enum DnsNameLabelReusePolicy {
  Unsecure,
  TenantReuse,
  SubscriptionReuse,
  ResourceGroupReuse,
  Noreuse,
}

@doc("The operating system type required by the containers in the container group.")
enum OperatingSystemTypes {
  Windows,
  Linux,
}

@doc("The log type to be used.")
enum LogAnalyticsLogType {
  ContainerInsights,
  ContainerInstanceLogs,
}

@doc("The container group SKU.")
enum ContainerGroupSku {
  Standard,
  Dedicated,
  Confidential,
}

@doc("The priority of the container group.")
enum ContainerGroupPriority {
  Regular,
  Spot,
}

@doc("The intended executor of the operation.")
enum ContainerInstanceOperationsOrigin {
  User,
  System,
}

@doc("The type of identity used for the container group. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the container group.")
@fixed
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

@doc("The Resource model definition.")
model Resource {
  @doc("The resource id.")
  @visibility("read")
  id?: string;

  @doc("The resource name.")
  @visibility("read")
  name?: string;

  @doc("The resource type.")
  @visibility("read")
  type?: string;

  @doc("The resource location.")
  location?: string;

  @doc("The resource tags.")
  tags?: Record<string>;

  @doc("The zones for the container group.")
  zones?: string[];
}

@doc("The container group properties")
model ContainerGroupProperties {
  @doc("The identity of the container group, if configured.")
  identity?: ContainerGroupIdentity;

  @doc("The container group properties")
  properties: ContainerGroupPropertiesProperties;
}

@doc("Identity for the container group.")
model ContainerGroupIdentity {
  @doc("The principal id of the container group identity. This property will only be provided for a system assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant id associated with the container group. This property will only be provided for a system assigned identity.")
  @visibility("read")
  tenantId?: string;

  @doc("The type of identity used for the container group. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the container group.")
  type?: ResourceIdentityType;

  @doc("The list of user identities associated with the container group.")
  userAssignedIdentities?: Record<UserAssignedIdentities>;
}

@doc("The list of user identities associated with the container group. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.")
model UserAssignedIdentities {
  @doc("The principal id of user assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client id of user assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("The container group properties")
model ContainerGroupPropertiesProperties {
  @doc("The provisioning state of the container group. This only appears in the response.")
  @visibility("read")
  provisioningState?: string;

  @doc("The containers within the container group.")
  containers: Container[];

  @doc("The image registry credentials by which the container group is created from.")
  imageRegistryCredentials?: ImageRegistryCredential[];

  @doc("""
Restart policy for all containers within the container group. 
- `Always` Always restart
- `OnFailure` Restart on failure
- `Never` Never restart

""")
  restartPolicy?: ContainerGroupRestartPolicy;

  @doc("The IP address type of the container group.")
  ipAddress?: IpAddress;

  @doc("The operating system type required by the containers in the container group.")
  osType: OperatingSystemTypes;

  @doc("The list of volumes that can be mounted by containers in this container group.")
  volumes?: Volume[];

  @doc("The instance view of the container group. Only valid in response.")
  @visibility("read")
  instanceView?: ContainerGroupPropertiesPropertiesInstanceView;

  @doc("The diagnostic information for a container group.")
  diagnostics?: ContainerGroupDiagnostics;

  @doc("The subnet resource IDs for a container group.")
  subnetIds?: ContainerGroupSubnetId[];

  @doc("The DNS config information for a container group.")
  dnsConfig?: DnsConfiguration;

  @doc("The SKU for a container group.")
  sku?: ContainerGroupSku;

  @doc("The encryption properties for a container group.")
  encryptionProperties?: EncryptionProperties;

  @doc("The init containers for a container group.")
  initContainers?: InitContainerDefinition[];

  @doc("extensions used by virtual kubelet")
  extensions?: DeploymentExtensionSpec[];

  @doc("The properties for confidential container group")
  confidentialComputeProperties?: ConfidentialComputeProperties;

  @doc("The priority of the container group.")
  priority?: ContainerGroupPriority;
}

@doc("A container instance.")
model Container {
  @doc("The user-provided name of the container instance.")
  name: string;

  @doc("The properties of the container instance.")
  properties: ContainerProperties;
}

@doc("The container instance properties.")
model ContainerProperties {
  @doc("The name of the image used to create the container instance.")
  image: string;

  @doc("The commands to execute within the container instance in exec form.")
  command?: string[];

  @doc("The exposed ports on the container instance.")
  ports?: ContainerPort[];

  @doc("The environment variables to set in the container instance.")
  environmentVariables?: EnvironmentVariable[];

  @doc("The instance view of the container instance. Only valid in response.")
  @visibility("read")
  instanceView?: ContainerPropertiesInstanceView;

  @doc("The resource requirements of the container instance.")
  resources: ResourceRequirements;

  @doc("The volume mounts available to the container instance.")
  volumeMounts?: VolumeMount[];

  @doc("The liveness probe.")
  livenessProbe?: ContainerProbe;

  @doc("The readiness probe.")
  readinessProbe?: ContainerProbe;

  @doc("The container security properties.")
  securityContext?: SecurityContextDefinition;
}

@doc("The port exposed on the container instance.")
model ContainerPort {
  @doc("The protocol associated with the port.")
  protocol?: ContainerNetworkProtocol;

  @doc("The port number exposed within the container group.")
  port: int32;
}

@doc("The environment variable to set within the container instance.")
model EnvironmentVariable {
  @doc("The name of the environment variable.")
  name: string;

  @doc("The value of the environment variable.")
  value?: string;

  @doc("The value of the secure environment variable.")
  secureValue?: string;
}

@doc("The instance view of the container instance. Only valid in response.")
model ContainerPropertiesInstanceView {
  @doc("The number of times that the container instance has been restarted.")
  @visibility("read")
  restartCount?: int32;

  @doc("Current container instance state.")
  @visibility("read")
  currentState?: ContainerState;

  @doc("Previous container instance state.")
  @visibility("read")
  previousState?: ContainerState;

  @doc("The events of the container instance.")
  @visibility("read")
  events?: Event[];
}

@doc("The container instance state.")
model ContainerState {
  @doc("The state of the container instance.")
  @visibility("read")
  state?: string;

  @doc("The date-time when the container instance state started.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The container instance exit codes correspond to those from the `docker run` command.")
  @visibility("read")
  exitCode?: int32;

  @doc("The date-time when the container instance state finished.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishTime?: utcDateTime;

  @doc("The human-readable status of the container instance state.")
  @visibility("read")
  detailStatus?: string;
}

@doc("A container group or container instance event.")
model Event {
  @doc("The count of the event.")
  @visibility("read")
  count?: int32;

  @doc("The date-time of the earliest logged event.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  firstTimestamp?: utcDateTime;

  @doc("The date-time of the latest logged event.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastTimestamp?: utcDateTime;

  @doc("The event name.")
  @visibility("read")
  name?: string;

  @doc("The event message.")
  @visibility("read")
  message?: string;

  @doc("The event type.")
  @visibility("read")
  type?: string;
}

@doc("The resource requirements.")
model ResourceRequirements {
  @doc("The resource requests of this container instance.")
  requests: ResourceRequests;

  @doc("The resource limits of this container instance.")
  limits?: ResourceLimits;
}

@doc("The resource requests.")
model ResourceRequests {
  @doc("The memory request in GB of this container instance.")
  memoryInGB: float32;

  @doc("The CPU request of this container instance.")
  cpu: float32;

  @doc("The GPU request of this container instance.")
  gpu?: GpuResource;
}

@doc("The GPU resource.")
model GpuResource {
  @doc("The count of the GPU resource.")
  count: int32;

  @doc("The SKU of the GPU resource.")
  sku: GpuSku;
}

@doc("The resource limits.")
model ResourceLimits {
  @doc("The memory limit in GB of this container instance.")
  memoryInGB?: float32;

  @doc("The CPU limit of this container instance.")
  cpu?: float32;

  @doc("The GPU limit of this container instance.")
  gpu?: GpuResource;
}

@doc("The properties of the volume mount.")
model VolumeMount {
  @doc("The name of the volume mount.")
  name: string;

  @doc("The path within the container where the volume should be mounted. Must not contain colon (:).")
  mountPath: string;

  @doc("The flag indicating whether the volume mount is read-only.")
  readOnly?: boolean;
}

@doc("The container probe, for liveness or readiness")
model ContainerProbe {
  @doc("The execution command to probe")
  exec?: ContainerExec;

  @doc("The Http Get settings to probe")
  httpGet?: ContainerHttpGet;

  @doc("The initial delay seconds.")
  initialDelaySeconds?: int32;

  @doc("The period seconds.")
  periodSeconds?: int32;

  @doc("The failure threshold.")
  failureThreshold?: int32;

  @doc("The success threshold.")
  successThreshold?: int32;

  @doc("The timeout seconds.")
  timeoutSeconds?: int32;
}

@doc("The container execution command, for liveness or readiness probe")
model ContainerExec {
  @doc("The commands to execute within the container.")
  command?: string[];
}

@doc("The container Http Get settings, for liveness or readiness probe")
model ContainerHttpGet {
  @doc("The path to probe.")
  path?: string;

  @doc("The port number to probe.")
  port: int32;

  @doc("The scheme.")
  scheme?: Scheme;

  @doc("The HTTP headers.")
  httpHeaders?: HttpHeader[];
}

@doc("The HTTP header.")
model HttpHeader {
  @doc("The header name.")
  name?: string;

  @doc("The header value.")
  value?: string;
}

@doc("The security context for the container.")
model SecurityContextDefinition {
  @doc("The flag to determine if the container permissions is elevated to Privileged.")
  privileged?: boolean;

  @doc("A boolean value indicating whether the init process can elevate its privileges")
  allowPrivilegeEscalation?: boolean;

  @doc("The capabilities to add or drop from a container.")
  capabilities?: SecurityContextCapabilitiesDefinition;

  @doc("Sets the User GID for the container.")
  runAsGroup?: int32;

  @doc("Sets the User UID for the container.")
  runAsUser?: int32;

  @doc("a base64 encoded string containing the contents of the JSON in the seccomp profile")
  seccompProfile?: string;
}

@doc("The capabilities to add or drop from a container.")
model SecurityContextCapabilitiesDefinition {
  @doc("The capabilities to add to the container.")
  add?: string[];

  @doc("The capabilities to drop from the container.")
  drop?: string[];
}

@doc("Image registry credential.")
model ImageRegistryCredential {
  @doc("The Docker image registry server without a protocol such as \"http\" and \"https\".")
  server: string;

  @doc("The username for the private registry.")
  username?: string;

  @doc("The password for the private registry.")
  password?: string;

  @doc("The identity for the private registry.")
  identity?: string;

  @doc("The identity URL for the private registry.")
  identityUrl?: string;
}

@doc("IP address for the container group.")
model IpAddress {
  @doc("The list of ports exposed on the container group.")
  ports: Port[];

  @doc("Specifies if the IP is exposed to the public internet or private VNET.")
  type: ContainerGroupIpAddressType;

  @doc("The IP exposed to the public internet.")
  ip?: string;

  @doc("The Dns name label for the IP.")
  dnsNameLabel?: string;

  @doc("The value representing the security enum. The 'Unsecure' value is the default value if not selected and means the object's domain name label is not secured against subdomain takeover. The 'TenantReuse' value is the default value if selected and means the object's domain name label can be reused within the same tenant. The 'SubscriptionReuse' value means the object's domain name label can be reused within the same subscription. The 'ResourceGroupReuse' value means the object's domain name label can be reused within the same resource group. The 'NoReuse' value means the object's domain name label cannot be reused within the same resource group, subscription, or tenant.")
  autoGeneratedDomainNameLabelScope?: DnsNameLabelReusePolicy;

  @doc("The FQDN for the IP.")
  @visibility("read")
  fqdn?: string;
}

@doc("The port exposed on the container group.")
model Port {
  @doc("The protocol associated with the port.")
  protocol?: ContainerGroupNetworkProtocol;

  @doc("The port number.")
  port: int32;
}

@doc("The properties of the volume.")
model Volume {
  @doc("The name of the volume.")
  name: string;

  @doc("The Azure File volume.")
  azureFile?: AzureFileVolume;

  @doc("The empty directory volume.")
  emptyDir?: Record<unknown>;

  @doc("The secret volume.")
  secret?: Record<string>;

  @doc("The git repo volume.")
  gitRepo?: GitRepoVolume;
}

@doc("The properties of the Azure File volume. Azure File shares are mounted as volumes.")
model AzureFileVolume {
  @doc("The name of the Azure File share to be mounted as a volume.")
  shareName: string;

  @doc("The flag indicating whether the Azure File shared mounted as a volume is read-only.")
  readOnly?: boolean;

  @doc("The name of the storage account that contains the Azure File share.")
  storageAccountName: string;

  @doc("The storage account access key used to access the Azure File share.")
  storageAccountKey?: string;
}

@doc("Represents a volume that is populated with the contents of a git repository")
model GitRepoVolume {
  @doc("Target directory name. Must not contain or start with '..'.  If '.' is supplied, the volume directory will be the git repository.  Otherwise, if specified, the volume will contain the git repository in the subdirectory with the given name.")
  directory?: string;

  @doc("Repository URL")
  repository: string;

  @doc("Commit hash for the specified revision.")
  revision?: string;
}

@doc("The instance view of the container group. Only valid in response.")
model ContainerGroupPropertiesPropertiesInstanceView {
  @doc("The events of this container group.")
  @visibility("read")
  events?: Event[];

  @doc("The state of the container group. Only valid in response.")
  @visibility("read")
  state?: string;
}

@doc("Container group diagnostic information.")
model ContainerGroupDiagnostics {
  @doc("Container group log analytics information.")
  logAnalytics?: LogAnalytics;
}

@doc("Container group log analytics information.")
model LogAnalytics {
  @doc("The workspace id for log analytics")
  workspaceId: string;

  @doc("The workspace key for log analytics")
  workspaceKey: string;

  @doc("The log type to be used.")
  logType?: LogAnalyticsLogType;

  @doc("Metadata for log analytics.")
  metadata?: Record<string>;

  @doc("The workspace resource id for log analytics")
  workspaceResourceId?: string;
}

@doc("Container group subnet information.")
model ContainerGroupSubnetId {
  @doc("Resource ID of virtual network and subnet.")
  id: string;

  @doc("Friendly name for the subnet.")
  name?: string;
}

@doc("DNS configuration for the container group.")
model DnsConfiguration {
  @doc("The DNS servers for the container group.")
  nameServers: string[];

  @doc("The DNS search domains for hostname lookup in the container group.")
  searchDomains?: string;

  @doc("The DNS options for the container group.")
  options?: string;
}

@doc("The container group encryption properties.")
model EncryptionProperties {
  @doc("The keyvault base url.")
  vaultBaseUrl: string;

  @doc("The encryption key name.")
  keyName: string;

  @doc("The encryption key version.")
  keyVersion: string;

  @doc("The keyvault managed identity.")
  identity?: string;
}

@doc("The init container definition.")
model InitContainerDefinition {
  @doc("The name for the init container.")
  name: string;

  @doc("The properties for the init container.")
  properties: InitContainerPropertiesDefinition;
}

@doc("The init container definition properties.")
model InitContainerPropertiesDefinition {
  @doc("The image of the init container.")
  image?: string;

  @doc("The command to execute within the init container in exec form.")
  command?: string[];

  @doc("The environment variables to set in the init container.")
  environmentVariables?: EnvironmentVariable[];

  @doc("The instance view of the init container. Only valid in response.")
  @visibility("read")
  instanceView?: InitContainerPropertiesDefinitionInstanceView;

  @doc("The volume mounts available to the init container.")
  volumeMounts?: VolumeMount[];

  @doc("The container security properties.")
  securityContext?: SecurityContextDefinition;
}

@doc("The instance view of the init container. Only valid in response.")
model InitContainerPropertiesDefinitionInstanceView {
  @doc("The number of times that the init container has been restarted.")
  @visibility("read")
  restartCount?: int32;

  @doc("The current state of the init container.")
  @visibility("read")
  currentState?: ContainerState;

  @doc("The previous state of the init container.")
  @visibility("read")
  previousState?: ContainerState;

  @doc("The events of the init container.")
  @visibility("read")
  events?: Event[];
}

@doc("Extension sidecars to be added to the deployment.")
model DeploymentExtensionSpec {
  @doc("Name of the extension.")
  name: string;

  @doc("Extension specific properties")
  properties?: DeploymentExtensionSpecProperties;
}

@doc("Extension specific properties")
model DeploymentExtensionSpecProperties {
  @doc("Type of extension to be added.")
  extensionType: string;

  @doc("Version of the extension being used.")
  version: string;

  @doc("Settings for the extension.")
  settings?: Record<unknown>;

  @doc("Protected settings for the extension.")
  protectedSettings?: Record<unknown>;
}

@doc("The properties for confidential container group")
model ConfidentialComputeProperties {
  @doc("The base64 encoded confidential compute enforcement policy")
  ccePolicy?: string;
}

@doc("An error response from the Container Instance service.")
@error
model CloudError {
  @doc("An error response from the Container Instance service.")
  error?: CloudErrorBody;
}

@doc("An error response from the Container Instance service.")
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

@doc("The response containing the usage data")
@pagedResult
model UsageListResult {
  @doc("The usage data.")
  @visibility("read")
  @items
  value?: Usage[];
}

@doc("A single usage result")
model Usage {
  @doc("Id of the usage result")
  @visibility("read")
  id?: string;

  @doc("Unit of the usage result")
  @visibility("read")
  unit?: string;

  @doc("The current usage of the resource")
  @visibility("read")
  currentValue?: int32;

  @doc("The maximum permitted usage of the resource.")
  @visibility("read")
  limit?: int32;

  @doc("The name object of the resource")
  @visibility("read")
  name?: UsageName;
}

@doc("The name object of the resource")
model UsageName {
  @doc("The name of the resource")
  @visibility("read")
  value?: string;

  @doc("The localized name of the resource")
  @visibility("read")
  localizedValue?: string;
}

@doc("The logs.")
model Logs {
  @doc("The content of the log.")
  content?: string;
}

@doc("The container exec request.")
model ContainerExecRequest {
  @doc("The command to be executed.")
  command?: string;

  @doc("The size of the terminal.")
  terminalSize?: ContainerExecRequestTerminalSize;
}

@doc("The size of the terminal.")
model ContainerExecRequestTerminalSize {
  @doc("The row size of the terminal")
  rows?: int32;

  @doc("The column size of the terminal")
  cols?: int32;
}

@doc("The information for the container exec command.")
model ContainerExecResponse {
  @doc("The uri for the exec websocket.")
  webSocketUri?: string;

  @doc("The password to start the exec command.")
  password?: string;
}

@doc("The information for the output stream from container attach.")
model ContainerAttachResponse {
  @doc("The uri for the output stream from the attach.")
  webSocketUri?: string;

  @doc("The password to the output stream from the attach. Send as an Authorization header value when connecting to the websocketUri.")
  password?: string;
}

@doc("The response containing cached images.")
model CachedImagesListResult is Azure.Core.Page<CachedImages>;

@doc("The cached image and OS type.")
model CachedImages {
  @doc("The OS type of the cached image.")
  osType: string;

  @doc("The cached image name.")
  image: string;
}

@doc("The response containing list of capabilities.")
model CapabilitiesListResult is Azure.Core.Page<Capabilities>;

@doc("The regional capabilities.")
model Capabilities {
  @doc("The resource type that this capability describes.")
  @visibility("read")
  resourceType?: string;

  @doc("The OS type that this capability describes.")
  @visibility("read")
  osType?: string;

  @doc("The resource location.")
  @visibility("read")
  location?: string;

  @doc("The ip address type that this capability describes.")
  @visibility("read")
  ipAddressType?: string;

  @doc("The GPU sku that this capability describes.")
  @visibility("read")
  gpu?: string;

  @doc("The supported capabilities.")
  @visibility("read")
  capabilities?: CapabilitiesCapabilities;
}

@doc("The supported capabilities.")
model CapabilitiesCapabilities {
  @doc("The maximum allowed memory request in GB.")
  @visibility("read")
  maxMemoryInGB?: float32;

  @doc("The maximum allowed CPU request in cores.")
  @visibility("read")
  maxCpu?: float32;

  @doc("The maximum allowed GPU count.")
  @visibility("read")
  maxGpuCount?: float32;
}
