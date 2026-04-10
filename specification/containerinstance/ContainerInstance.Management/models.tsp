import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.Foundations;
using Azure.ClientGenerator.Core;

namespace Microsoft.ContainerInstance;

/**
 * Response for network dependencies, always empty list.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model NetworkDependenciesResponse is string[];

/**
 * The provisioning state of the container group. This only appears in the response.
 */
union ContainerGroupProvisioningState {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Repairing
   */
  Repairing: "Repairing",

  /**
   * Unhealthy
   */
  Unhealthy: "Unhealthy",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * NotAccessible
   */
  NotAccessible: "NotAccessible",

  /**
   * PreProvisioned
   */
  PreProvisioned: "PreProvisioned",
}

/**
 * The protocol associated with the port.
 */
union ContainerNetworkProtocol {
  string,

  /**
   * TCP
   */
  TCP: "TCP",

  /**
   * UDP
   */
  UDP: "UDP",
}

/**
 * The SKU of the GPU resource.
 */
union GpuSku {
  string,

  /**
   * K80
   */
  K80: "K80",

  /**
   * P100
   */
  P100: "P100",

  /**
   * V100
   */
  V100: "V100",
}

/**
 * The scheme.
 */
union Scheme {
  string,

  /**
   * http
   */
  http: "http",

  /**
   * https
   */
  https: "https",
}

/**
 * Restart policy for all containers within the container group.
 * - `Always` Always restart
 * - `OnFailure` Restart on failure
 * - `Never` Never restart
 *
 */
union ContainerGroupRestartPolicy {
  string,

  /**
   * Always
   */
  Always: "Always",

  /**
   * OnFailure
   */
  OnFailure: "OnFailure",

  /**
   * Never
   */
  Never: "Never",
}

/**
 * The protocol associated with the port.
 */
union ContainerGroupNetworkProtocol {
  string,

  /**
   * TCP
   */
  TCP: "TCP",

  /**
   * UDP
   */
  UDP: "UDP",
}

/**
 * Specifies if the IP is exposed to the public internet or private VNET.
 */
union ContainerGroupIpAddressType {
  string,

  /**
   * Public
   */
  Public: "Public",

  /**
   * Private
   */
  Private: "Private",
}

/**
 * The value representing the security enum. The 'Unsecure' value is the default value if not selected and means the object's domain name label is not secured against subdomain takeover. The 'TenantReuse' value is the default value if selected and means the object's domain name label can be reused within the same tenant. The 'SubscriptionReuse' value means the object's domain name label can be reused within the same subscription. The 'ResourceGroupReuse' value means the object's domain name label can be reused within the same resource group. The 'NoReuse' value means the object's domain name label cannot be reused within the same resource group, subscription, or tenant.
 */
union DnsNameLabelReusePolicy {
  string,

  /**
   * Unsecure
   */
  Unsecure: "Unsecure",

  /**
   * TenantReuse
   */
  TenantReuse: "TenantReuse",

  /**
   * SubscriptionReuse
   */
  SubscriptionReuse: "SubscriptionReuse",

  /**
   * ResourceGroupReuse
   */
  ResourceGroupReuse: "ResourceGroupReuse",

  /**
   * Noreuse
   */
  Noreuse: "Noreuse",
}

/**
 * The operating system type required by the containers in the container group.
 */
union OperatingSystemTypes {
  string,

  /**
   * Windows
   */
  Windows: "Windows",

  /**
   * Linux
   */
  Linux: "Linux",
}

/**
 * The log type to be used.
 */
union LogAnalyticsLogType {
  string,

  /**
   * ContainerInsights
   */
  ContainerInsights: "ContainerInsights",

  /**
   * ContainerInstanceLogs
   */
  ContainerInstanceLogs: "ContainerInstanceLogs",
}

/**
 * The container group SKU.
 */
union ContainerGroupSku {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * Dedicated
   */
  Dedicated: "Dedicated",

  /**
   * Confidential
   */
  Confidential: "Confidential",
}

/**
 * The priority of the container group.
 */
union ContainerGroupPriority {
  string,

  /**
   * Regular
   */
  Regular: "Regular",

  /**
   * Spot
   */
  Spot: "Spot",
}

/**
 * The access level of an identity.
 */
union IdentityAccessLevel {
  string,

  /**
   * All
   */
  All: "All",

  /**
   * System
   */
  System: "System",

  /**
   * User
   */
  User: "User",
}

/**
 * The intended executor of the operation.
 */
union ContainerInstanceOperationsOrigin {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * System
   */
  System: "System",
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
 * The provisioning state, which only appears in the response.
 */
union NGroupProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Migrating
   */
  Migrating: "Migrating",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union NGroupUpdateMode {
  string,

  /**
   * Manual
   */
  Manual: "Manual",

  /**
   * Rolling
   */
  Rolling: "Rolling",
}

/**
 * The type of identity used for the container group. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the container group.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceIdentityType {
  /**
   * SystemAssigned
   */
  SystemAssigned,

  /**
   * UserAssigned
   */
  UserAssigned,

  /**
   * SystemAssigned, UserAssigned
   */
  `SystemAssigned, UserAssigned`,

  /**
   * None
   */
  None,
}

/**
 *  Specifies how Container Groups can access the Azure file share i.e. all CG will share same Azure file share or going to have exclusive file share.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum AzureFileShareAccessType {
  /**
   * Shared
   */
  Shared,

  /**
   * Exclusive
   */
  Exclusive,
}

/**
 * Access tier for specific share. GpV2 account can choose between TransactionOptimized (default), Hot, and Cool. FileStorage account can choose Premium. Learn more at: https://learn.microsoft.com/en-us/rest/api/storagerp/file-shares/create?tabs=HTTP#shareaccesstier
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum AzureFileShareAccessTier {
  /**
   * Cool
   */
  Cool,

  /**
   * Hot
   */
  Hot,

  /**
   * Premium
   */
  Premium,

  /**
   * TransactionOptimized
   */
  TransactionOptimized,
}

/**
 * A container group part of the list result.
 */
model ListResultContainerGroup {
  ...Resource;
  ...ListResultContainerGroupProperties;
}

/**
 * The response of a container group list operation.
 */
model ContainerGroupListResult is Azure.Core.Page<ListResultContainerGroup>;

/**
 * The Resource model definition.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "For backward compatibility"
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name" "Renaming to ContainerGroupPatch for C# backward compat"
@clientName("ContainerGroupPatch", "csharp")
model Resource {
  /**
   * The resource id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The resource location.
   */
  location?: string;

  /**
   * The resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The zones for the container group.
   */
  zones?: string[];
}

/**
 * Properties of container group part of list result
 */
model ListResultContainerGroupProperties {
  /**
   * The identity of the container group, if configured.
   */
  identity?: ContainerGroupIdentity;

  /**
   * The container group properties
   */
  properties: ListResultContainerGroupPropertiesProperties;
}

/**
 * Identity for the container group.
 */
model ContainerGroupIdentity {
  /**
   * The principal id of the container group identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id associated with the container group. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of identity used for the container group. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the container group.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the container group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentities>;
}

/**
 * The list of user identities associated with the container group. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
 */
model UserAssignedIdentities {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * The container group properties
 */
model ListResultContainerGroupPropertiesProperties {
  /**
   * The provisioning state of the container group. This only appears in the response.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ContainerGroupProvisioningState;

  /**
   * The secret references that will be referenced within the container group.
   */
  @identifiers(#["name"])
  secretReferences?: SecretReference[];

  /**
   * The containers within the container group.
   */
  @identifiers(#["name"])
  containers: Container[];

  /**
   * The image registry credentials by which the container group is created from.
   */
  @identifiers(#["username"])
  imageRegistryCredentials?: ImageRegistryCredential[];

  /**
   * Restart policy for all containers within the container group.
   * - `Always` Always restart
   * - `OnFailure` Restart on failure
   * - `Never` Never restart
   *
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
  @identifiers(#["name"])
  volumes?: Volume[];

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
  @identifiers(#["name"])
  initContainers?: InitContainerDefinition[];

  /**
   * extensions used by virtual kubelet
   */
  @identifiers(#["name"])
  extensions?: DeploymentExtensionSpec[];

  /**
   * The properties for confidential container group
   */
  confidentialComputeProperties?: ConfidentialComputeProperties;

  /**
   * The priority of the container group.
   */
  priority?: ContainerGroupPriority;

  /**
   * The access control levels of the identities.
   */
  identityAcls?: IdentityAcls;

  /**
   * The reference container group profile properties.
   */
  containerGroupProfile?: ContainerGroupProfileReferenceDefinition;

  /**
   * The reference standby pool profile properties.
   */
  standbyPoolProfile?: StandbyPoolProfileDefinition;

  /**
   * The flag to determine whether the container group is created from standby pool.
   */
  @visibility(Lifecycle.Read)
  isCreatedFromStandbyPool?: boolean;
}

/**
 * A secret reference
 */
model SecretReference {
  /**
   * The identifier of the secret reference
   */
  name: string;

  /**
   * The ARM resource id of the managed identity that has access to the secret in the key vault
   */
  identity: Azure.Core.armResourceIdentifier;

  /**
   * The URI to the secret in key vault
   */
  secretReferenceUri: url;
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
  image?: string;

  /**
   * The commands to execute within the container instance in exec form.
   */
  command?: string[];

  /**
   * The exposed ports on the container instance.
   */
  @identifiers(#["port"])
  ports?: ContainerPort[];

  /**
   * The environment variables to set in the container instance.
   */
  @identifiers(#["name"])
  environmentVariables?: EnvironmentVariable[];

  /**
   * The instance view of the container instance. Only valid in response.
   */
  @visibility(Lifecycle.Read)
  instanceView?: ContainerPropertiesInstanceView;

  /**
   * The resource requirements of the container instance.
   */
  resources?: ResourceRequirements;

  /**
   * The volume mounts available to the container instance.
   */
  @identifiers(#["name"])
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

  /**
   * The config map.
   */
  configMap?: ConfigMap;
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
  @secret
  secureValue?: string;

  /**
   * The reference of the secure environment variable.
   */
  secureValueReference?: string;
}

/**
 * The instance view of the container instance. Only valid in response.
 */
model ContainerPropertiesInstanceView {
  /**
   * The number of times that the container instance has been restarted.
   */
  @visibility(Lifecycle.Read)
  restartCount?: int32;

  /**
   * Current container instance state.
   */
  @visibility(Lifecycle.Read)
  currentState?: ContainerState;

  /**
   * Previous container instance state.
   */
  @visibility(Lifecycle.Read)
  previousState?: ContainerState;

  /**
   * The events of the container instance.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name", "type"])
  events?: Event[];
}

/**
 * The container instance state.
 */
model ContainerState {
  /**
   * The state of the container instance.
   */
  @visibility(Lifecycle.Read)
  state?: string;

  /**
   * The date-time when the container instance state started.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The container instance exit codes correspond to those from the `docker run` command.
   */
  @visibility(Lifecycle.Read)
  exitCode?: int32;

  /**
   * The date-time when the container instance state finished.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishTime?: utcDateTime;

  /**
   * The human-readable status of the container instance state.
   */
  @visibility(Lifecycle.Read)
  detailStatus?: string;
}

/**
 * A container group or container instance event.
 */
model Event {
  /**
   * The count of the event.
   */
  @visibility(Lifecycle.Read)
  count?: int32;

  /**
   * The date-time of the earliest logged event.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  firstTimestamp?: utcDateTime;

  /**
   * The date-time of the latest logged event.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastTimestamp?: utcDateTime;

  /**
   * The event name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The event message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The event type.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
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
  @identifiers(#["name"])
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
 * The container config map.
 */
model ConfigMap {
  /**
   * The key value pairs dictionary in the config map.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  keyValuePairs?: Record<string>;
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
  @secret
  password?: string;

  /**
   * The reference for the private registry password.
   */
  passwordReference?: string;

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
  @identifiers(#["port"])
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  emptyDir?: unknown;

  /**
   * The secret volume.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  secret?: Record<string>;

  /**
   * The secret reference volume.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  secretReference?: Record<string>;

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
  @secret
  storageAccountKey?: string;

  /**
   * The reference to the storage account access key used to access the Azure File share.
   */
  storageAccountKeyReference?: string;
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
  @secret
  workspaceKey: string;

  /**
   * The log type to be used.
   */
  logType?: LogAnalyticsLogType;

  /**
   * Metadata for log analytics.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  metadata?: Record<string>;

  /**
   * The workspace resource id for log analytics
   */
  @secret
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
  @identifiers(#["name"])
  environmentVariables?: EnvironmentVariable[];

  /**
   * The instance view of the init container. Only valid in response.
   */
  @visibility(Lifecycle.Read)
  instanceView?: InitContainerPropertiesDefinitionInstanceView;

  /**
   * The volume mounts available to the init container.
   */
  @identifiers(#["name"])
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
  @visibility(Lifecycle.Read)
  restartCount?: int32;

  /**
   * The current state of the init container.
   */
  @visibility(Lifecycle.Read)
  currentState?: ContainerState;

  /**
   * The previous state of the init container.
   */
  @visibility(Lifecycle.Read)
  previousState?: ContainerState;

  /**
   * The events of the init container.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name", "type"])
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  settings?: unknown;

  /**
   * Protected settings for the extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  protectedSettings?: unknown;
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
 * The access control levels of the identities.
 */
model IdentityAcls {
  /**
   * The default access level.
   */
  defaultAccess?: IdentityAccessLevel;

  /**
   * The access control levels for each identity.
   */
  @identifiers(#["identity"])
  acls?: IdentityAccessControl[];
}

/**
 * The access control for an identity
 */
model IdentityAccessControl {
  /**
   * The access level of the identity.
   */
  access?: IdentityAccessLevel;

  /**
   * An identity.
   */
  identity?: Azure.Core.armResourceIdentifier;
}

/**
 * The container group profile reference.
 */
model ContainerGroupProfileReferenceDefinition {
  /**
   * The container group profile reference id.This will be an ARM resource id in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroupProfiles/{containerGroupProfileName}'.
   */
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The container group profile reference revision.
   */
  revision?: int32;
}

/**
 * The standby pool profile reference.
 */
model StandbyPoolProfileDefinition {
  /**
   * The standby pool profile reference id.This will be an ARM resource id in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StandbyPool/standbyContainerGroupPools/{standbyPoolName}'.
   */
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The flag to determine whether ACI should fail the create request if the container group can not be obtained from standby pool.
   */
  failContainerGroupCreateOnReuseFailure?: boolean;
}

/**
 * An error response from the Container Instance service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@error
@Azure.ResourceManager.Legacy.armExternalType
model CloudError {
  /**
   * An error response from the Container Instance service.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the Container Instance service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@Azure.ResourceManager.Legacy.armExternalType
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
  @identifiers(#["message", "target"])
  details?: CloudErrorBody[];
}

/**
 * The container group properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ContainerGroupProperties {
  /**
   * The identity of the container group, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "For backward compatibility"
  identity?: ContainerGroupIdentity;

  /**
   * The container group properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "For backward compatibility"
  properties: ContainerGroupPropertiesProperties;
}

/**
 * The container group properties
 */
model ContainerGroupPropertiesProperties {
  /**
   * The provisioning state of the container group. This only appears in the response.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The secret references that will be referenced within the container group.
   */
  @identifiers(#["name"])
  secretReferences?: SecretReference[];

  /**
   * The containers within the container group.
   */
  @identifiers(#["name"])
  containers: Container[];

  /**
   * The image registry credentials by which the container group is created from.
   */
  @identifiers(#["username"])
  imageRegistryCredentials?: ImageRegistryCredential[];

  /**
   * Restart policy for all containers within the container group.
   * - `Always` Always restart
   * - `OnFailure` Restart on failure
   * - `Never` Never restart
   *
   */
  restartPolicy?: ContainerGroupRestartPolicy;

  /**
   * The IP address type of the container group.
   */
  ipAddress?: IpAddress;

  /**
   * The operating system type required by the containers in the container group.
   */
  osType?: OperatingSystemTypes;

  /**
   * The list of volumes that can be mounted by containers in this container group.
   */
  @identifiers(#["name"])
  volumes?: Volume[];

  /**
   * The instance view of the container group. Only valid in response.
   */
  @visibility(Lifecycle.Read)
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
  @identifiers(#["name"])
  initContainers?: InitContainerDefinition[];

  /**
   * extensions used by virtual kubelet
   */
  @identifiers(#["name"])
  extensions?: DeploymentExtensionSpec[];

  /**
   * The properties for confidential container group
   */
  confidentialComputeProperties?: ConfidentialComputeProperties;

  /**
   * The priority of the container group.
   */
  priority?: ContainerGroupPriority;

  /**
   * The access control levels of the identities.
   */
  identityAcls?: IdentityAcls;

  /**
   * The reference container group profile properties.
   */
  containerGroupProfile?: ContainerGroupProfileReferenceDefinition;

  /**
   * The reference standby pool profile properties.
   */
  standbyPoolProfile?: StandbyPoolProfileDefinition;

  /**
   * The flag to determine whether the container group is created from standby pool.
   */
  @visibility(Lifecycle.Read)
  isCreatedFromStandbyPool?: boolean;
}

/**
 * The instance view of the container group. Only valid in response.
 */
model ContainerGroupPropertiesPropertiesInstanceView {
  /**
   * The events of this container group.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name", "type"])
  events?: Event[];

  /**
   * The state of the container group. Only valid in response.
   */
  @visibility(Lifecycle.Read)
  state?: string;
}

model OperationListResult is Azure.Core.Page<Operation>;

/**
 * An operation for Azure Container Instance service.
 */
model Operation {
  /**
   * The name of the operation.
   */
  name: string;

  /**
   * The display information of the operation.
   */
  display: OperationDisplay;

  /**
   * The additional properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  properties?: unknown;

  /**
   * The intended executor of the operation.
   */
  origin?: ContainerInstanceOperationsOrigin;
}

/**
 * The display information of the operation.
 */
model OperationDisplay {
  /**
   * The name of the provider of the operation.
   */
  provider?: string;

  /**
   * The name of the resource type of the operation.
   */
  resource?: string;

  /**
   * The friendly name of the operation.
   */
  operation?: string;

  /**
   * The description of the operation.
   */
  description?: string;
}

/**
 * The response containing the usage data
 */
model UsageListResult {
  /**
   * The usage data.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  @identifiers(#["name"])
  value?: Usage[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The response of a NGroups list operation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model NGroupsListResult is Azure.Core.Page<NGroup>;

/**
 * A single usage result
 */
model Usage {
  /**
   * Id of the usage result
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Unit of the usage result
   */
  @visibility(Lifecycle.Read)
  unit?: string;

  /**
   * The current usage of the resource
   */
  @visibility(Lifecycle.Read)
  currentValue?: int32;

  /**
   * The maximum permitted usage of the resource.
   */
  @visibility(Lifecycle.Read)
  limit?: int32;

  /**
   * The name object of the resource
   */
  @visibility(Lifecycle.Read)
  name?: UsageName;
}

/**
 * The name object of the resource
 */
model UsageName {
  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * The localized name of the resource
   */
  @visibility(Lifecycle.Read)
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
  @secret
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
  @secret
  password?: string;
}

/**
 * The response containing cached images.
 */
model CachedImagesListResult {
  /**
   * The cached images.
   */
  @pageItems
  @identifiers(#["image"])
  value?: CachedImages[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

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
model CapabilitiesListResult {
  /**
   * The list of capabilities.
   */
  @pageItems
  @identifiers(#["resourceType", "location"])
  value?: Capabilities[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The regional capabilities.
 */
model Capabilities {
  /**
   * The resource type that this capability describes.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The OS type that this capability describes.
   */
  @visibility(Lifecycle.Read)
  osType?: string;

  /**
   * The resource location.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The ip address type that this capability describes.
   */
  @visibility(Lifecycle.Read)
  ipAddressType?: string;

  /**
   * The GPU sku that this capability describes.
   */
  @visibility(Lifecycle.Read)
  gpu?: string;

  /**
   * The supported capabilities.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "For backward compatibility"
  @visibility(Lifecycle.Read)
  capabilities?: CapabilitiesCapabilities;
}

/**
 * The supported capabilities.
 */
model CapabilitiesCapabilities {
  /**
   * The maximum allowed memory request in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @visibility(Lifecycle.Read)
  maxMemoryInGB?: float32;

  /**
   * The maximum allowed CPU request in cores.
   */
  @visibility(Lifecycle.Read)
  maxCpu?: float32;

  /**
   * The maximum allowed GPU count.
   */
  @visibility(Lifecycle.Read)
  maxGpuCount?: float32;
}

/**
 * Describes the properties of the NGroups resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model NGroupProperties {
  /**
   * The elastic profile.
   */
  elasticProfile?: ElasticProfile;

  /**
   * Provides options w.r.t allocation and management w.r.t certain placement policies. These utilize capabilities provided by the underlying Azure infrastructure. They are typically used for high availability scenarios. E.g., distributing CGs across fault domains.
   */
  placementProfile?: PlacementProfile;

  /**
   * The Container Group Profiles that could be used in the NGroups resource.
   */
  @identifiers(#[])
  containerGroupProfiles?: ContainerGroupProfileStub[];

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NGroupProvisioningState;

  /**
   * Used by the customer to specify the way to update the Container Groups in NGroup.
   */
  updateProfile?: UpdateProfile;
}

/**
 * Describes the elastic profile of the NGroup
 */
model ElasticProfile {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  desiredCount?: int32;

  /**
   * Flag that indicates whether desiredCount should be maintained when customer deletes SPECIFIC container groups (CGs) from the NGroups. In this case, new CGs will be created by NGroup to compensate for the specific deleted ones.
   */
  maintainDesiredCount?: boolean;

  /**
   * Container Groups are named on a generic guid based naming scheme/policy. Customer can modify naming policy to add prefix to CG names during scale out operation.
   */
  containerGroupNamingPolicy?: ElasticProfileContainerGroupNamingPolicy;
}

/**
 * Container Groups are named on a generic guid based naming scheme/policy. Customer can modify naming policy to add prefix to CG names during scale out operation.
 */
model ElasticProfileContainerGroupNamingPolicy {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  guidNamingPolicy?: ElasticProfileContainerGroupNamingPolicyGuidNamingPolicy;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ElasticProfileContainerGroupNamingPolicyGuidNamingPolicy {
  /**
   * The prefix can be used when there are tooling limitations (e.g. on the Azure portal where CGs from multiple NGroups exist in the same RG). The prefix with the suffixed resource name must still follow Azure resource naming guidelines.
   */
  prefix?: string;
}

/**
 * Provides options w.r.t allocation and management w.r.t certain placement policies. These utilize capabilities provided by the underlying Azure infrastructure. They are typically used for high availability scenarios. E.g., distributing CGs across fault domains.
 */
model PlacementProfile {
  /**
   * The number of fault domains to be used to spread CGs in the NGroups resource. This can only be specified during NGroup creation and is immutable after that.
   */
  faultDomainCount?: int32;
}

/**
 * The object that contains a reference to a Container Group Profile and it's other related properties.
 */
model ContainerGroupProfileStub {
  /**
   * A reference to the container group profile ARM resource hosted in ACI RP.
   */
  resource?: ApiEntityReference;

  /**
   * The revision of the CG profile is an optional property. If customer does not to provide a revision then NGroups will pickup the latest revision of CGProfile.
   */
  revision?: int32;

  /**
   * A network profile for network settings of a ContainerGroupProfile.
   */
  networkProfile?: NetworkProfile;

  /**
   * Storage profile for storage related settings of a container group profile.
   */
  storageProfile?: StorageProfile;

  /**
   *  Container Group properties which can be set while creating or updating the NGroups.
   */
  containerGroupProperties?: NGroupContainerGroupProperties;
}

/**
 * The API entity reference.
 */
model ApiEntityReference {
  /**
   * The ARM resource id in the form of /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/...
   */
  id?: string;
}

/**
 * A network profile for network settings of a ContainerGroupProfile. Used to manage load balancer and application gateway backend pools, specifically updating the IP addresses of CGs within the backend pool.
 */
model NetworkProfile {
  /**
   * LoadBalancer the CG profile will use to interact with CGs in a backend pool
   */
  loadBalancer?: LoadBalancer;

  /**
   * Application Gateway the CG profile will use to interact with CGs in a backend pool
   */
  applicationGateway?: ApplicationGateway;
}

/**
 * LoadBalancer the CG profile will use to interact with CGs in a backend pool
 */
model LoadBalancer {
  /**
   * List of Load Balancer Backend Address Pools.
   */
  @identifiers(#["resource"])
  backendAddressPools?: LoadBalancerBackendAddressPool[];
}

/**
 * NGroups load balancer backend address pool
 */
model LoadBalancerBackendAddressPool {
  /**
   * The Load Balancer backend address pool ARM resource Id.
   */
  resource?: string;
}

/**
 * Application Gateway the CG profile will use to interact with CGs in a backend pool
 */
model ApplicationGateway {
  /**
   * The Application Gateway ARM resource Id.
   */
  resource?: string;

  /**
   * List of Application Gateway Backend Address Pools.
   */
  @identifiers(#["resource"])
  backendAddressPools?: ApplicationGatewayBackendAddressPool[];
}

/**
 * NGroups application gateway backend address pool
 */
model ApplicationGatewayBackendAddressPool {
  /**
   * The application gateway backend address pool ARM resource Id.
   */
  resource?: string;
}

/**
 * Storage profile for storage related settings of a container group profile.
 */
model StorageProfile {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#["name"])
  fileShares?: FileShare[];
}

/**
 * File shares that can be mounted on container groups.
 */
model FileShare {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  resourceGroupName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  storageAccountName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: FileShareProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model FileShareProperties {
  /**
   *  Specifies how Container Groups can access the Azure file share i.e. all CG will share same Azure file share or going to have exclusive file share.
   */
  shareAccessType?: AzureFileShareAccessType;

  /**
   * Access tier for specific share. GpV2 account can choose between TransactionOptimized (default), Hot, and Cool. FileStorage account can choose Premium. Learn more at: https://learn.microsoft.com/en-us/rest/api/storagerp/file-shares/create?tabs=HTTP#shareaccesstier
   */
  shareAccessTier?: AzureFileShareAccessTier = AzureFileShareAccessTier.TransactionOptimized;
}

/**
 * Container Group properties which can be set while creating or updating the NGroups.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model NGroupContainerGroupProperties {
  /**
   * Contains information about Virtual Network Subnet ARM Resource
   */
  subnetIds?: ContainerGroupSubnetId[];

  /**
   * Contains information about the volumes that can be mounted by Containers in the Container Groups.
   */
  @identifiers(#["name"])
  volumes?: NGroupCGPropertyVolume[];

  /**
   * Contains information about Container which can be set while creating or updating the NGroups.
   */
  @identifiers(#["name"])
  containers?: NGroupCGPropertyContainer[];
}

/**
 * Contains information about the volumes that can be mounted by Containers in the Container Groups.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model NGroupCGPropertyVolume {
  /**
   * The name of the volume.
   */
  name: string;

  /**
   * The Azure File volume.
   */
  azureFile?: AzureFileVolume;
}

/**
 * Container properties that can be provided with NGroups object.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model NGroupCGPropertyContainer {
  /**
   * container name
   */
  name?: string;

  /**
   * container properties
   */
  properties?: NGroupCGPropertyContainerProperties;
}

/**
 * container properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model NGroupCGPropertyContainerProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#["name"])
  volumeMounts?: VolumeMount[];
}

/**
 * Used by the customer to specify the way to update the Container Groups in NGroup.
 */
model UpdateProfile {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  updateMode?: NGroupUpdateMode;

  /**
   * This profile allows the customers to customize the rolling update.
   */
  rollingUpdateProfile?: UpdateProfileRollingUpdateProfile;
}

/**
 * This profile allows the customers to customize the rolling update.
 */
model UpdateProfileRollingUpdateProfile {
  /**
   * Maximum percentage of total Container Groups which can be updated simultaneously by rolling update in one batch.
   */
  maxBatchPercent?: int32;

  /**
   * Maximum percentage of the updated Container Groups which can be in unhealthy state after each batch is updated.
   */
  maxUnhealthyPercent?: int32;

  /**
   * The wait time between batches after completing the one batch of the rolling update and starting the next batch. The time duration should be specified in ISO 8601 format for duration.
   */
  pauseTimeBetweenBatches?: string;

  /**
   * Default is false. If set to true, the CGs will be updated in-place instead of creating new CG and deleting old ones.
   */
  inPlaceUpdate?: boolean;
}

/**
 * Identity for the NGroup.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model NGroupIdentity {
  /**
   * The principal id of the NGroup identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id associated with the NGroup. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of identity used for the NGroup. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the NGroup.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the NGroup.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentities>;
}

/**
 * Describes the NGroups resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model NGroupPatch {
  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  /**
   * Describes the properties of the NGroups resource.
   */
  properties?: NGroupProperties;

  /**
   * The identity of the NGroup, if configured.
   */
  identity?: NGroupIdentity;

  /**
   * The resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The zones for the NGroup.
   */
  zones?: string[];
}

/**
 * The container group profile properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ContainerGroupProfileProperties {
  /**
   * The SKU for a container group.
   */
  sku?: ContainerGroupSku;

  /**
   * The encryption properties for a container group.
   */
  encryptionProperties?: EncryptionProperties;

  /**
   * The containers within the container group.
   */
  @identifiers(#["name"])
  containers: Container[];

  /**
   * The init containers for a container group.
   */
  @identifiers(#["name"])
  initContainers?: InitContainerDefinition[];

  /**
   * extensions used by virtual kubelet
   */
  @identifiers(#["name"])
  extensions?: DeploymentExtensionSpec[];

  /**
   * The image registry credentials by which the container group is created from.
   */
  @identifiers(#["username"])
  imageRegistryCredentials?: ImageRegistryCredential[];

  /**
   * Restart policy for all containers within the container group.
   * - `Always` Always restart
   * - `OnFailure` Restart on failure
   * - `Never` Never restart
   *
   */
  restartPolicy?: ContainerGroupRestartPolicy;

  /**
   * Shutdown grace period for containers in a container group.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  shutdownGracePeriod?: utcDateTime;

  /**
   * The IP address type of the container group.
   */
  ipAddress?: IpAddress;

  /**
   * Post completion time to live for containers of a CG
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeToLive?: utcDateTime;

  /**
   * The operating system type required by the containers in the container group.
   */
  osType: OperatingSystemTypes;

  /**
   * The list of volumes that can be mounted by containers in this container group.
   */
  @identifiers(#["name"])
  volumes?: Volume[];

  /**
   * The diagnostic information for a container group.
   */
  diagnostics?: ContainerGroupDiagnostics;

  /**
   * The priority of the container group.
   */
  priority?: ContainerGroupPriority;

  /**
   * The properties for confidential container group
   */
  confidentialComputeProperties?: ConfidentialComputeProperties;

  /**
   * The container security properties.
   */
  securityContext?: SecurityContextDefinition;

  /**
   * Container group profile current revision number
   */
  @visibility(Lifecycle.Read)
  revision?: int32;

  /**
   * Registered revisions are calculated at request time based off the records in the table logs.
   */
  @visibility(Lifecycle.Read)
  registeredRevisions?: int32[];

  /**
   * Gets or sets Krypton use property.
   */
  useKrypton?: boolean;
}

/**
 * Properties of container group profile that need to be patched
 */
model ContainerGroupProfilePatch {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * List of SKU definitions. NGroups offer a single sku
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model NGroupsSkusList is Azure.Core.Page<NGroupSkus>;

/**
 * The container probe, for liveness or readiness.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model NGroupSkus {
  /**
   * The type of resource the sku is applied to.
   */
  resourceType?: string;

  /**
   * The sku of the resource type
   */
  sku?: string;

  /**
   * The number of container groups of the NGroups.
   */
  skuCapacity?: string;
}
