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

/**
 * The protocol associated with the port.
 */
enum ContainerNetworkProtocol {
  TCP,
  UDP,
}

/**
 * The SKU of the GPU resource.
 */
enum GpuSku {
  K80,
  P100,
  V100,
}

/**
 * The scheme.
 */
enum Scheme {
  http,
  https,
}

/**
* Restart policy for all containers within the container group. 
- `Always` Always restart
- `OnFailure` Restart on failure
- `Never` Never restart

*/
enum ContainerGroupRestartPolicy {
  Always,
  OnFailure,
  Never,
}

/**
 * The protocol associated with the port.
 */
enum ContainerGroupNetworkProtocol {
  TCP,
  UDP,
}

/**
 * Specifies if the IP is exposed to the public internet or private VNET.
 */
enum ContainerGroupIpAddressType {
  Public,
  Private,
}

/**
 * The value representing the security enum. The 'Unsecure' value is the default value if not selected and means the object's domain name label is not secured against subdomain takeover. The 'TenantReuse' value is the default value if selected and means the object's domain name label can be reused within the same tenant. The 'SubscriptionReuse' value means the object's domain name label can be reused within the same subscription. The 'ResourceGroupReuse' value means the object's domain name label can be reused within the same resource group. The 'NoReuse' value means the object's domain name label cannot be reused within the same resource group, subscription, or tenant.
 */
enum DnsNameLabelReusePolicy {
  Unsecure,
  TenantReuse,
  SubscriptionReuse,
  ResourceGroupReuse,
  Noreuse,
}

/**
 * The operating system type required by the containers in the container group.
 */
enum OperatingSystemTypes {
  Windows,
  Linux,
}

/**
 * The log type to be used.
 */
enum LogAnalyticsLogType {
  ContainerInsights,
  ContainerInstanceLogs,
}

/**
 * The container group SKU.
 */
enum ContainerGroupSku {
  Standard,
  Dedicated,
  Confidential,
}

/**
 * The priority of the container group.
 */
enum ContainerGroupPriority {
  Regular,
  Spot,
}

/**
 * The intended executor of the operation.
 */
enum ContainerInstanceOperationsOrigin {
  User,
  System,
}

/**
 * The type of identity used for the container group. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the container group.
 */
@fixed
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * The Resource model definition.
 */
model Resource {
  /**
   * The resource id.
   */
  @visibility("read")
  id?: string;

  /**
   * The resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * The resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * The resource location.
   */
  location?: string;

  /**
   * The resource tags.
   */
  tags?: Record<string>;

  /**
   * The zones for the container group.
   */
  zones?: string[];
}

/**
 * The container group properties
 */
model ContainerGroupProperties {
  /**
   * The identity of the container group, if configured.
   */
  identity?: ContainerGroupIdentity;

  /**
   * The container group properties
   */
  properties: ContainerGroupPropertiesProperties;
}

/**
 * Identity for the container group.
 */
model ContainerGroupIdentity {
  /**
   * The principal id of the container group identity. This property will only be provided for a system assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant id associated with the container group. This property will only be provided for a system assigned identity.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The type of identity used for the container group. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the container group.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the container group.
   */
  userAssignedIdentities?: Record<UserAssignedIdentities>;
}

/**
 * The list of user identities associated with the container group. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
 */
model UserAssignedIdentities {
  /**
   * The principal id of user assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility("read")
  clientId?: string;
}

/**
 * The container group properties
 */
model ContainerGroupPropertiesProperties {
  /**
   * The provisioning state of the container group. This only appears in the response.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The containers within the container group.
   */
  containers: Container[];

  /**
   * The image registry credentials by which the container group is created from.
   */
  imageRegistryCredentials?: ImageRegistryCredential[];

  /**
* Restart policy for all containers within the container group. 
- `Always` Always restart
- `OnFailure` Restart on failure
- `Never` Never restart

*/
  restartPolicy?: ContainerGroupRestartPolicy;

  /**
   * The IP address type of the container group.
   */
  ipAddress?: IpAddress;

  /**
   * The operating system type required by the containers in the container group.
   */
  osType: OperatingSystemTypes;

  /**
   * The list of volumes that can be mounted by containers in this container group.
   */
  volumes?: Volume[];

  /**
   * The instance view of the container group. Only valid in response.
   */
  @visibility("read")
  instanceView?: ContainerGroupPropertiesPropertiesInstanceView;

  /**
   * The diagnostic information for a container group.
   */
  diagnostics?: ContainerGroupDiagnostics;

  /**
   * The subnet resource IDs for a container group.
   */
  subnetIds?: ContainerGroupSubnetId[];

  /**
   * The DNS config information for a container group.
   */
  dnsConfig?: DnsConfiguration;

  /**
   * The SKU for a container group.
   */
  sku?: ContainerGroupSku;

  /**
   * The encryption properties for a container group.
   */
  encryptionProperties?: EncryptionProperties;

  /**
   * The init containers for a container group.
   */
  initContainers?: InitContainerDefinition[];

  /**
   * extensions used by virtual kubelet
   */
  extensions?: DeploymentExtensionSpec[];

  /**
   * The properties for confidential container group
   */
  confidentialComputeProperties?: ConfidentialComputeProperties;

  /**
   * The priority of the container group.
   */
  priority?: ContainerGroupPriority;
}

/**
 * A container instance.
 */
model Container {
  /**
   * The user-provided name of the container instance.
   */
  name: string;

  /**
   * The properties of the container instance.
   */
  properties: ContainerProperties;
}

/**
 * The container instance properties.
 */
model ContainerProperties {
  /**
   * The name of the image used to create the container instance.
   */
  image: string;

  /**
   * The commands to execute within the container instance in exec form.
   */
  command?: string[];

  /**
   * The exposed ports on the container instance.
   */
  ports?: ContainerPort[];

  /**
   * The environment variables to set in the container instance.
   */
  environmentVariables?: EnvironmentVariable[];

  /**
   * The instance view of the container instance. Only valid in response.
   */
  @visibility("read")
  instanceView?: ContainerPropertiesInstanceView;

  /**
   * The resource requirements of the container instance.
   */
  resources: ResourceRequirements;

  /**
   * The volume mounts available to the container instance.
   */
  volumeMounts?: VolumeMount[];

  /**
   * The liveness probe.
   */
  livenessProbe?: ContainerProbe;

  /**
   * The readiness probe.
   */
  readinessProbe?: ContainerProbe;

  /**
   * The container security properties.
   */
  securityContext?: SecurityContextDefinition;
}

/**
 * The port exposed on the container instance.
 */
model ContainerPort {
  /**
   * The protocol associated with the port.
   */
  protocol?: ContainerNetworkProtocol;

  /**
   * The port number exposed within the container group.
   */
  port: int32;
}

/**
 * The environment variable to set within the container instance.
 */
model EnvironmentVariable {
  /**
   * The name of the environment variable.
   */
  name: string;

  /**
   * The value of the environment variable.
   */
  value?: string;

  /**
   * The value of the secure environment variable.
   */
  secureValue?: string;
}

/**
 * The instance view of the container instance. Only valid in response.
 */
model ContainerPropertiesInstanceView {
  /**
   * The number of times that the container instance has been restarted.
   */
  @visibility("read")
  restartCount?: int32;

  /**
   * Current container instance state.
   */
  @visibility("read")
  currentState?: ContainerState;

  /**
   * Previous container instance state.
   */
  @visibility("read")
  previousState?: ContainerState;

  /**
   * The events of the container instance.
   */
  @visibility("read")
  events?: Event[];
}

/**
 * The container instance state.
 */
model ContainerState {
  /**
   * The state of the container instance.
   */
  @visibility("read")
  state?: string;

  /**
   * The date-time when the container instance state started.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The container instance exit codes correspond to those from the `docker run` command.
   */
  @visibility("read")
  exitCode?: int32;

  /**
   * The date-time when the container instance state finished.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishTime?: utcDateTime;

  /**
   * The human-readable status of the container instance state.
   */
  @visibility("read")
  detailStatus?: string;
}

/**
 * A container group or container instance event.
 */
model Event {
  /**
   * The count of the event.
   */
  @visibility("read")
  count?: int32;

  /**
   * The date-time of the earliest logged event.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  firstTimestamp?: utcDateTime;

  /**
   * The date-time of the latest logged event.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastTimestamp?: utcDateTime;

  /**
   * The event name.
   */
  @visibility("read")
  name?: string;

  /**
   * The event message.
   */
  @visibility("read")
  message?: string;

  /**
   * The event type.
   */
  @visibility("read")
  type?: string;
}

/**
 * The resource requirements.
 */
model ResourceRequirements {
  /**
   * The resource requests of this container instance.
   */
  requests: ResourceRequests;

  /**
   * The resource limits of this container instance.
   */
  limits?: ResourceLimits;
}

/**
 * The resource requests.
 */
model ResourceRequests {
  /**
   * The memory request in GB of this container instance.
   */
  memoryInGB: float64;

  /**
   * The CPU request of this container instance.
   */
  cpu: float64;

  /**
   * The GPU request of this container instance.
   */
  gpu?: GpuResource;
}

/**
 * The GPU resource.
 */
model GpuResource {
  /**
   * The count of the GPU resource.
   */
  count: int32;

  /**
   * The SKU of the GPU resource.
   */
  sku: GpuSku;
}

/**
 * The resource limits.
 */
model ResourceLimits {
  /**
   * The memory limit in GB of this container instance.
   */
  memoryInGB?: float64;

  /**
   * The CPU limit of this container instance.
   */
  cpu?: float64;

  /**
   * The GPU limit of this container instance.
   */
  gpu?: GpuResource;
}

/**
 * The properties of the volume mount.
 */
model VolumeMount {
  /**
   * The name of the volume mount.
   */
  name: string;

  /**
   * The path within the container where the volume should be mounted. Must not contain colon (:).
   */
  mountPath: string;

  /**
   * The flag indicating whether the volume mount is read-only.
   */
  readOnly?: boolean;
}

/**
 * The container probe, for liveness or readiness
 */
model ContainerProbe {
  /**
   * The execution command to probe
   */
  exec?: ContainerExec;

  /**
   * The Http Get settings to probe
   */
  httpGet?: ContainerHttpGet;

  /**
   * The initial delay seconds.
   */
  initialDelaySeconds?: int32;

  /**
   * The period seconds.
   */
  periodSeconds?: int32;

  /**
   * The failure threshold.
   */
  failureThreshold?: int32;

  /**
   * The success threshold.
   */
  successThreshold?: int32;

  /**
   * The timeout seconds.
   */
  timeoutSeconds?: int32;
}

/**
 * The container execution command, for liveness or readiness probe
 */
model ContainerExec {
  /**
   * The commands to execute within the container.
   */
  command?: string[];
}

/**
 * The container Http Get settings, for liveness or readiness probe
 */
model ContainerHttpGet {
  /**
   * The path to probe.
   */
  path?: string;

  /**
   * The port number to probe.
   */
  port: int32;

  /**
   * The scheme.
   */
  scheme?: Scheme;

  /**
   * The HTTP headers.
   */
  httpHeaders?: HttpHeader[];
}

/**
 * The HTTP header.
 */
model HttpHeader {
  /**
   * The header name.
   */
  name?: string;

  /**
   * The header value.
   */
  value?: string;
}

/**
 * The security context for the container.
 */
model SecurityContextDefinition {
  /**
   * The flag to determine if the container permissions is elevated to Privileged.
   */
  privileged?: boolean;

  /**
   * A boolean value indicating whether the init process can elevate its privileges
   */
  allowPrivilegeEscalation?: boolean;

  /**
   * The capabilities to add or drop from a container.
   */
  capabilities?: SecurityContextCapabilitiesDefinition;

  /**
   * Sets the User GID for the container.
   */
  runAsGroup?: int32;

  /**
   * Sets the User UID for the container.
   */
  runAsUser?: int32;

  /**
   * a base64 encoded string containing the contents of the JSON in the seccomp profile
   */
  seccompProfile?: string;
}

/**
 * The capabilities to add or drop from a container.
 */
model SecurityContextCapabilitiesDefinition {
  /**
   * The capabilities to add to the container.
   */
  add?: string[];

  /**
   * The capabilities to drop from the container.
   */
  drop?: string[];
}

/**
 * Image registry credential.
 */
model ImageRegistryCredential {
  /**
   * The Docker image registry server without a protocol such as "http" and "https".
   */
  server: string;

  /**
   * The username for the private registry.
   */
  username?: string;

  /**
   * The password for the private registry.
   */
  password?: string;

  /**
   * The identity for the private registry.
   */
  identity?: string;

  /**
   * The identity URL for the private registry.
   */
  identityUrl?: string;
}

/**
 * IP address for the container group.
 */
model IpAddress {
  /**
   * The list of ports exposed on the container group.
   */
  ports: Port[];

  /**
   * Specifies if the IP is exposed to the public internet or private VNET.
   */
  type: ContainerGroupIpAddressType;

  /**
   * The IP exposed to the public internet.
   */
  ip?: string;

  /**
   * The Dns name label for the IP.
   */
  dnsNameLabel?: string;

  /**
   * The value representing the security enum. The 'Unsecure' value is the default value if not selected and means the object's domain name label is not secured against subdomain takeover. The 'TenantReuse' value is the default value if selected and means the object's domain name label can be reused within the same tenant. The 'SubscriptionReuse' value means the object's domain name label can be reused within the same subscription. The 'ResourceGroupReuse' value means the object's domain name label can be reused within the same resource group. The 'NoReuse' value means the object's domain name label cannot be reused within the same resource group, subscription, or tenant.
   */
  autoGeneratedDomainNameLabelScope?: DnsNameLabelReusePolicy = DnsNameLabelReusePolicy.Unsecure;

  /**
   * The FQDN for the IP.
   */
  @visibility("read")
  fqdn?: string;
}

/**
 * The port exposed on the container group.
 */
model Port {
  /**
   * The protocol associated with the port.
   */
  protocol?: ContainerGroupNetworkProtocol;

  /**
   * The port number.
   */
  port: int32;
}

/**
 * The properties of the volume.
 */
model Volume {
  /**
   * The name of the volume.
   */
  name: string;

  /**
   * The Azure File volume.
   */
  azureFile?: AzureFileVolume;

  /**
   * The empty directory volume.
   */
  emptyDir?: Record<unknown>;

  /**
   * The secret volume.
   */
  secret?: Record<string>;

  /**
   * The git repo volume.
   */
  gitRepo?: GitRepoVolume;
}

/**
 * The properties of the Azure File volume. Azure File shares are mounted as volumes.
 */
model AzureFileVolume {
  /**
   * The name of the Azure File share to be mounted as a volume.
   */
  shareName: string;

  /**
   * The flag indicating whether the Azure File shared mounted as a volume is read-only.
   */
  readOnly?: boolean;

  /**
   * The name of the storage account that contains the Azure File share.
   */
  storageAccountName: string;

  /**
   * The storage account access key used to access the Azure File share.
   */
  storageAccountKey?: string;
}

/**
 * Represents a volume that is populated with the contents of a git repository
 */
model GitRepoVolume {
  /**
   * Target directory name. Must not contain or start with '..'.  If '.' is supplied, the volume directory will be the git repository.  Otherwise, if specified, the volume will contain the git repository in the subdirectory with the given name.
   */
  directory?: string;

  /**
   * Repository URL
   */
  repository: string;

  /**
   * Commit hash for the specified revision.
   */
  revision?: string;
}

/**
 * The instance view of the container group. Only valid in response.
 */
model ContainerGroupPropertiesPropertiesInstanceView {
  /**
   * The events of this container group.
   */
  @visibility("read")
  events?: Event[];

  /**
   * The state of the container group. Only valid in response.
   */
  @visibility("read")
  state?: string;
}

/**
 * Container group diagnostic information.
 */
model ContainerGroupDiagnostics {
  /**
   * Container group log analytics information.
   */
  logAnalytics?: LogAnalytics;
}

/**
 * Container group log analytics information.
 */
model LogAnalytics {
  /**
   * The workspace id for log analytics
   */
  workspaceId: string;

  /**
   * The workspace key for log analytics
   */
  workspaceKey: string;

  /**
   * The log type to be used.
   */
  logType?: LogAnalyticsLogType;

  /**
   * Metadata for log analytics.
   */
  metadata?: Record<string>;

  /**
   * The workspace resource id for log analytics
   */
  workspaceResourceId?: string;
}

/**
 * Container group subnet information.
 */
model ContainerGroupSubnetId {
  /**
   * Resource ID of virtual network and subnet.
   */
  id: string;

  /**
   * Friendly name for the subnet.
   */
  name?: string;
}

/**
 * DNS configuration for the container group.
 */
model DnsConfiguration {
  /**
   * The DNS servers for the container group.
   */
  nameServers: string[];

  /**
   * The DNS search domains for hostname lookup in the container group.
   */
  searchDomains?: string;

  /**
   * The DNS options for the container group.
   */
  options?: string;
}

/**
 * The container group encryption properties.
 */
model EncryptionProperties {
  /**
   * The keyvault base url.
   */
  vaultBaseUrl: string;

  /**
   * The encryption key name.
   */
  keyName: string;

  /**
   * The encryption key version.
   */
  keyVersion: string;

  /**
   * The keyvault managed identity.
   */
  identity?: string;
}

/**
 * The init container definition.
 */
model InitContainerDefinition {
  /**
   * The name for the init container.
   */
  name: string;

  /**
   * The properties for the init container.
   */
  properties: InitContainerPropertiesDefinition;
}

/**
 * The init container definition properties.
 */
model InitContainerPropertiesDefinition {
  /**
   * The image of the init container.
   */
  image?: string;

  /**
   * The command to execute within the init container in exec form.
   */
  command?: string[];

  /**
   * The environment variables to set in the init container.
   */
  environmentVariables?: EnvironmentVariable[];

  /**
   * The instance view of the init container. Only valid in response.
   */
  @visibility("read")
  instanceView?: InitContainerPropertiesDefinitionInstanceView;

  /**
   * The volume mounts available to the init container.
   */
  volumeMounts?: VolumeMount[];

  /**
   * The container security properties.
   */
  securityContext?: SecurityContextDefinition;
}

/**
 * The instance view of the init container. Only valid in response.
 */
model InitContainerPropertiesDefinitionInstanceView {
  /**
   * The number of times that the init container has been restarted.
   */
  @visibility("read")
  restartCount?: int32;

  /**
   * The current state of the init container.
   */
  @visibility("read")
  currentState?: ContainerState;

  /**
   * The previous state of the init container.
   */
  @visibility("read")
  previousState?: ContainerState;

  /**
   * The events of the init container.
   */
  @visibility("read")
  events?: Event[];
}

/**
 * Extension sidecars to be added to the deployment.
 */
model DeploymentExtensionSpec {
  /**
   * Name of the extension.
   */
  name: string;

  /**
   * Extension specific properties
   */
  properties?: DeploymentExtensionSpecProperties;
}

/**
 * Extension specific properties
 */
model DeploymentExtensionSpecProperties {
  /**
   * Type of extension to be added.
   */
  extensionType: string;

  /**
   * Version of the extension being used.
   */
  version: string;

  /**
   * Settings for the extension.
   */
  settings?: Record<unknown>;

  /**
   * Protected settings for the extension.
   */
  protectedSettings?: Record<unknown>;
}

/**
 * The properties for confidential container group
 */
model ConfidentialComputeProperties {
  /**
   * The base64 encoded confidential compute enforcement policy
   */
  ccePolicy?: string;
}

/**
 * An error response from the Container Instance service.
 */
@error
model CloudError {
  /**
   * An error response from the Container Instance service.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the Container Instance service.
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
 * The response containing the usage data
 */
@pagedResult
model UsageListResult {
  /**
   * The usage data.
   */
  @visibility("read")
  @items
  value?: Usage[];
}

/**
 * A single usage result
 */
model Usage {
  /**
   * Id of the usage result
   */
  @visibility("read")
  id?: string;

  /**
   * Unit of the usage result
   */
  @visibility("read")
  unit?: string;

  /**
   * The current usage of the resource
   */
  @visibility("read")
  currentValue?: int32;

  /**
   * The maximum permitted usage of the resource.
   */
  @visibility("read")
  limit?: int32;

  /**
   * The name object of the resource
   */
  @visibility("read")
  name?: UsageName;
}

/**
 * The name object of the resource
 */
model UsageName {
  /**
   * The name of the resource
   */
  @visibility("read")
  value?: string;

  /**
   * The localized name of the resource
   */
  @visibility("read")
  localizedValue?: string;
}

/**
 * The logs.
 */
model Logs {
  /**
   * The content of the log.
   */
  content?: string;
}

/**
 * The container exec request.
 */
model ContainerExecRequest {
  /**
   * The command to be executed.
   */
  command?: string;

  /**
   * The size of the terminal.
   */
  terminalSize?: ContainerExecRequestTerminalSize;
}

/**
 * The size of the terminal.
 */
model ContainerExecRequestTerminalSize {
  /**
   * The row size of the terminal
   */
  rows?: int32;

  /**
   * The column size of the terminal
   */
  cols?: int32;
}

/**
 * The information for the container exec command.
 */
model ContainerExecResponse {
  /**
   * The uri for the exec websocket.
   */
  webSocketUri?: string;

  /**
   * The password to start the exec command.
   */
  password?: string;
}

/**
 * The information for the output stream from container attach.
 */
model ContainerAttachResponse {
  /**
   * The uri for the output stream from the attach.
   */
  webSocketUri?: string;

  /**
   * The password to the output stream from the attach. Send as an Authorization header value when connecting to the websocketUri.
   */
  password?: string;
}

/**
 * The response containing cached images.
 */
model CachedImagesListResult is Azure.Core.Page<CachedImages>;

/**
 * The cached image and OS type.
 */
model CachedImages {
  /**
   * The OS type of the cached image.
   */
  osType: string;

  /**
   * The cached image name.
   */
  image: string;
}

/**
 * The response containing list of capabilities.
 */
model CapabilitiesListResult is Azure.Core.Page<Capabilities>;

/**
 * The regional capabilities.
 */
model Capabilities {
  /**
   * The resource type that this capability describes.
   */
  @visibility("read")
  resourceType?: string;

  /**
   * The OS type that this capability describes.
   */
  @visibility("read")
  osType?: string;

  /**
   * The resource location.
   */
  @visibility("read")
  location?: string;

  /**
   * The ip address type that this capability describes.
   */
  @visibility("read")
  ipAddressType?: string;

  /**
   * The GPU sku that this capability describes.
   */
  @visibility("read")
  gpu?: string;

  /**
   * The supported capabilities.
   */
  @visibility("read")
  capabilities?: CapabilitiesCapabilities;
}

/**
 * The supported capabilities.
 */
model CapabilitiesCapabilities {
  /**
   * The maximum allowed memory request in GB.
   */
  @visibility("read")
  maxMemoryInGB?: float32;

  /**
   * The maximum allowed CPU request in cores.
   */
  @visibility("read")
  maxCpu?: float32;

  /**
   * The maximum allowed GPU count.
   */
  @visibility("read")
  maxGpuCount?: float32;
}
