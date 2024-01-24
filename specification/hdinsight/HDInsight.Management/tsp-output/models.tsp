import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.HDInsight;

interface Operations extends Azure.ResourceManager.Operations {}

enum DaysOfWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

/**
 * The private link configuration provisioning state, which only appears in the response.
 */
enum PrivateLinkConfigurationProvisioningState {
  InProgress,
  Failed,
  Succeeded,
  Canceled,
  Deleting,
}

/**
 * The method that private IP address is allocated.
 */
enum PrivateIPAllocationMethod {
  dynamic,
  static,
}

/**
 * The async operation state.
 */
enum AsyncOperationState {
  InProgress,
  Succeeded,
  Failed,
}

/**
 * The type of operating system.
 */
enum OSType {
  Windows,
  Linux,
}

/**
 * The cluster tier.
 */
enum Tier {
  Standard,
  Premium,
}

/**
 * The directory type.
 */
enum DirectoryType {
  ActiveDirectory,
}

/**
 * Algorithm identifier for encryption, default RSA-OAEP.
 */
enum JsonWebKeyEncryptionAlgorithm {
  `RSA-OAEP`,
  `RSA-OAEP-256`,
  RSA1_5,
}

/**
 * The direction for the resource provider connection.
 */
enum ResourceProviderConnection {
  Inbound,
  Outbound,
}

/**
 * Indicates whether or not private link is enabled.
 */
enum PrivateLink {
  Disabled,
  Enabled,
}

/**
 * The type of identity used for the cluster. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities.
 */
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * The provisioning state, which only appears in the response.
 */
enum HDInsightClusterProvisioningState {
  InProgress,
  Failed,
  Succeeded,
  Canceled,
  Deleting,
}

/**
 * The concrete private link service connection.
 */
enum PrivateLinkServiceConnectionStatus {
  Approved,
  Rejected,
  Pending,
  Removed,
}

/**
 * The provisioning state, which only appears in the response.
 */
enum PrivateEndpointConnectionProvisioningState {
  InProgress,
  Updating,
  Failed,
  Succeeded,
  Canceled,
  Deleting,
}

enum RoleName {
  workernode,
}

/**
 * The filtering mode. Effectively this can enabling or disabling the VM sizes in a particular set.
 */
enum FilterMode {
  Exclude,
  Include,
  Recommend,
  Default,
}

/**
 * The HDInsight cluster application GET response.
 */
model ApplicationProperties {
  /**
   * The list of roles in the cluster.
   */
  computeProfile?: ComputeProfile;

  /**
   * The list of install script actions.
   */
  installScriptActions?: RuntimeScriptAction[];

  /**
   * The list of uninstall script actions.
   */
  uninstallScriptActions?: RuntimeScriptAction[];

  /**
   * The list of application HTTPS endpoints.
   */
  httpsEndpoints?: ApplicationGetHttpsEndpoint[];

  /**
   * The list of application SSH endpoints.
   */
  sshEndpoints?: ApplicationGetEndpoint[];

  /**
   * The provisioning state of the application.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The application type.
   */
  applicationType?: string;

  /**
   * The application state.
   */
  @visibility("read")
  applicationState?: string;

  /**
   * The list of errors.
   */
  errors?: Errors[];

  /**
   * The application create date time.
   */
  @visibility("read")
  createdDate?: string;

  /**
   * The marketplace identifier.
   */
  @visibility("read")
  marketplaceIdentifier?: string;

  /**
   * The private link configurations.
   */
  privateLinkConfigurations?: PrivateLinkConfiguration[];
}

/**
 * Describes the compute profile.
 */
model ComputeProfile {
  /**
   * The list of roles in the cluster.
   */
  roles?: Role[];
}

/**
 * Describes a role on the cluster.
 */
model Role {
  /**
   * The name of the role.
   */
  name?: string;

  /**
   * The minimum instance count of the cluster.
   */
  minInstanceCount?: int32;

  /**
   * The instance count of the cluster.
   */
  targetInstanceCount?: int32;

  /**
   * The name of the virtual machine group.
   */
  @visibility("read", "create")
  VMGroupName?: string;

  /**
   * The autoscale configurations.
   */
  @projectedName("json", "autoscale")
  autoscaleConfiguration?: Autoscale;

  /**
   * The hardware profile.
   */
  hardwareProfile?: HardwareProfile;

  /**
   * The operating system profile.
   */
  osProfile?: OsProfile;

  /**
   * The virtual network profile.
   */
  virtualNetworkProfile?: VirtualNetworkProfile;

  /**
   * The data disks groups for the role.
   */
  dataDisksGroups?: DataDisksGroups[];

  /**
   * The list of script actions on the role.
   */
  scriptActions?: ScriptAction[];

  /**
   * Indicates whether encrypt the data disks.
   */
  encryptDataDisks?: boolean;
}

/**
 * The autoscale request parameters
 */
model Autoscale {
  /**
   * Parameters for load-based autoscale
   */
  capacity?: AutoscaleCapacity;

  /**
   * Parameters for schedule-based autoscale
   */
  recurrence?: AutoscaleRecurrence;
}

/**
 * The load-based autoscale request parameters
 */
model AutoscaleCapacity {
  /**
   * The minimum instance count of the cluster
   */
  minInstanceCount?: int32;

  /**
   * The maximum instance count of the cluster
   */
  maxInstanceCount?: int32;
}

/**
 * Schedule-based autoscale request parameters
 */
model AutoscaleRecurrence {
  /**
   * The time zone for the autoscale schedule times
   */
  timeZone?: string;

  /**
   * Array of schedule-based autoscale rules
   */
  schedule?: AutoscaleSchedule[];
}

/**
 * Parameters for a schedule-based autoscale rule, consisting of an array of days + a time and capacity
 */
model AutoscaleSchedule {
  /**
   * Days of the week for a schedule-based autoscale rule
   */
  days?: DaysOfWeek[];

  /**
   * Time and capacity for a schedule-based autoscale rule
   */
  timeAndCapacity?: AutoscaleTimeAndCapacity;
}

/**
 * Time and capacity request parameters
 */
model AutoscaleTimeAndCapacity {
  /**
   * 24-hour time in the form xx:xx
   */
  time?: string;

  /**
   * The minimum instance count of the cluster
   */
  minInstanceCount?: int32;

  /**
   * The maximum instance count of the cluster
   */
  maxInstanceCount?: int32;
}

/**
 * The hardware profile.
 */
model HardwareProfile {
  /**
   * The size of the VM
   */
  vmSize?: string;
}

/**
 * The Linux operation systems profile.
 */
model OsProfile {
  /**
   * The Linux OS profile.
   */
  linuxOperatingSystemProfile?: LinuxOperatingSystemProfile;
}

/**
 * The ssh username, password, and ssh public key.
 */
model LinuxOperatingSystemProfile {
  /**
   * The username.
   */
  username?: string;

  /**
   * The password.
   */
  password?: string;

  /**
   * The SSH profile.
   */
  sshProfile?: SshProfile;
}

/**
 * The list of SSH public keys.
 */
model SshProfile {
  /**
   * The list of SSH public keys.
   */
  publicKeys?: SshPublicKey[];
}

/**
 * The SSH public key for the cluster nodes.
 */
model SshPublicKey {
  /**
   * The certificate for SSH.
   */
  certificateData?: string;
}

/**
 * The virtual network properties.
 */
model VirtualNetworkProfile {
  /**
   * The ID of the virtual network.
   */
  id?: string;

  /**
   * The name of the subnet.
   */
  subnet?: string;
}

/**
 * The data disks groups for the role.
 */
model DataDisksGroups {
  /**
   * The number of disks per node.
   */
  disksPerNode?: int32;

  /**
   * ReadOnly. The storage account type. Do not set this value.
   */
  @visibility("read")
  storageAccountType?: string;

  /**
   * ReadOnly. The DiskSize in GB. Do not set this value.
   */
  @visibility("read")
  diskSizeGB?: int32;
}

/**
 * Describes a script action on role on the cluster.
 */
model ScriptAction {
  /**
   * The name of the script action.
   */
  name: string;

  /**
   * The URI to the script.
   */
  uri: string;

  /**
   * The parameters for the script provided.
   */
  parameters: string;
}

/**
 * Describes a script action on a running cluster.
 */
model RuntimeScriptAction {
  /**
   * The name of the script action.
   */
  name: string;

  /**
   * The URI to the script.
   */
  uri: string;

  /**
   * The parameters for the script
   */
  parameters?: string;

  /**
   * The list of roles where script will be executed.
   */
  roles: string[];

  /**
   * The application name of the script action, if any.
   */
  @visibility("read")
  applicationName?: string;
}

/**
 * Gets the application HTTP endpoints.
 */
model ApplicationGetHttpsEndpoint {
  /**
   * The list of access modes for the application.
   */
  accessModes?: string[];

  /**
   * The location of the endpoint.
   */
  @visibility("read")
  location?: string;

  /**
   * The destination port to connect to.
   */
  destinationPort?: int32;

  /**
   * The public port to connect to.
   */
  @visibility("read")
  publicPort?: int32;

  /**
   * The private ip address of the endpoint.
   */
  @visibility("read", "create")
  privateIPAddress?: string;

  /**
   * The subdomain suffix of the application.
   */
  @visibility("create", "update")
  subDomainSuffix?: string;

  /**
   * The value indicates whether to disable GatewayAuth.
   */
  disableGatewayAuth?: boolean;
}

/**
 * Gets the application SSH endpoint
 */
model ApplicationGetEndpoint {
  /**
   * The location of the endpoint.
   */
  location?: string;

  /**
   * The destination port to connect to.
   */
  destinationPort?: int32;

  /**
   * The public port to connect to.
   */
  publicPort?: int32;

  /**
   * The private ip address of the endpoint.
   */
  @visibility("read", "create")
  privateIPAddress?: string;
}

/**
 * The error message associated with the cluster creation.
 */
model Errors {
  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The error message.
   */
  @visibility("read")
  message?: string;

  /**
   * The error target.
   */
  @visibility("read")
  target?: string;

  /**
   * The error details.
   */
  @visibility("read")
  details?: Errors[];
}

/**
 * The private link configuration.
 */
model PrivateLinkConfiguration {
  /**
   * The private link configuration id.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of private link configuration.
   */
  name: string;

  /**
   * The type of the private link configuration.
   */
  @visibility("read")
  type?: string;

  /**
   * The private link configuration properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: PrivateLinkConfigurationProperties;
}

/**
 * The private link configuration properties.
 */
model PrivateLinkConfigurationProperties {
  /**
   * The HDInsight private linkable sub-resource name to apply the private link configuration to. For example, 'headnode', 'gateway', 'edgenode'.
   */
  groupId: string;

  /**
   * The private link configuration provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: PrivateLinkConfigurationProvisioningState;

  /**
   * The IP configurations for the private link service.
   */
  ipConfigurations: IPConfiguration[];
}

/**
 * The ip configurations for the private link service.
 */
model IPConfiguration {
  /**
   * The private link IP configuration id.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of private link IP configuration.
   */
  name: string;

  /**
   * The type of the private link IP configuration.
   */
  @visibility("read")
  type?: string;

  /**
   * The private link ip configuration properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: IPConfigurationProperties;
}

/**
 * The private link ip configuration properties.
 */
model IPConfigurationProperties {
  /**
   * The private link configuration provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: PrivateLinkConfigurationProvisioningState;

  /**
   * Indicates whether this IP configuration is primary for the corresponding NIC.
   */
  primary?: boolean;

  /**
   * The IP address.
   */
  privateIPAddress?: string;

  /**
   * The method that private IP address is allocated.
   */
  privateIPAllocationMethod?: PrivateIPAllocationMethod;

  /**
   * The subnet resource id.
   */
  subnet?: ResourceId;
}

/**
 * The azure resource id.
 */
model ResourceId {
  /**
   * The azure resource id.
   */
  id?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model HDInsightClusterResponseData {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;
}

/**
 * The azure async operation response.
 */
model AsyncOperationResult {
  /**
   * The async operation state.
   */
  status?: AsyncOperationState;

  /**
   * The operation error information.
   */
  error?: Errors;
}

/**
 * The CreateCluster request parameters.
 */
model ClusterCreateParametersExtended {
  /**
   * The location of the cluster.
   */
  location?: string;

  /**
   * The resource tags.
   */
  tags?: Record<string>;

  /**
   * The availability zones.
   */
  zones?: string[];

  /**
   * The cluster create parameters.
   */
  properties?: ClusterCreateProperties;

  /**
   * The identity of the cluster, if configured.
   */
  identity?: ClusterIdentity;
}

/**
 * The cluster create parameters.
 */
model ClusterCreateProperties {
  /**
   * The version of the cluster.
   */
  clusterVersion?: string;

  /**
   * The type of operating system.
   */
  osType?: OSType;

  /**
   * The cluster tier.
   */
  @visibility("read", "create")
  tier?: Tier;

  /**
   * The cluster definition.
   */
  clusterDefinition?: ClusterDefinition;

  /**
   * The cluster kafka rest proxy configuration.
   */
  kafkaRestProperties?: KafkaRestProperties;

  /**
   * The security profile.
   */
  securityProfile?: SecurityProfile;

  /**
   * The compute profile.
   */
  computeProfile?: ComputeProfile;

  /**
   * The storage profile.
   */
  storageProfile?: StorageProfile;

  /**
   * The disk encryption properties.
   */
  diskEncryptionProperties?: DiskEncryptionProperties;

  /**
   * The encryption-in-transit properties.
   */
  encryptionInTransitProperties?: EncryptionInTransitProperties;

  /**
   * The minimal supported tls version.
   */
  minSupportedTlsVersion?: string;

  /**
   * The network properties.
   */
  networkProperties?: NetworkProperties;

  /**
   * The compute isolation properties.
   */
  computeIsolationProperties?: ComputeIsolationProperties;

  /**
   * The private link configurations.
   */
  privateLinkConfigurations?: PrivateLinkConfiguration[];
}

/**
 * The cluster definition.
 */
model ClusterDefinition {
  /**
   * The link to the blueprint.
   */
  blueprint?: string;

  /**
   * The type of cluster.
   */
  kind?: string;

  /**
   * The versions of different services in the cluster.
   */
  @visibility("read", "create")
  componentVersion?: Record<string>;

  /**
   * The cluster configurations.
   */
  configurations?: Record<unknown>;
}

/**
 * The kafka rest proxy configuration which contains AAD security group information.
 */
model KafkaRestProperties {
  /**
   * The information of AAD security group.
   */
  clientGroupInfo?: ClientGroupInfo;

  /**
   * The configurations that need to be overriden.
   */
  configurationOverride?: Record<string>;
}

/**
 * The information of AAD security group.
 */
model ClientGroupInfo {
  /**
   * The AAD security group name.
   */
  groupName?: string;

  /**
   * The AAD security group id.
   */
  groupId?: string;
}

/**
 * The security profile which contains Ssh public key for the HDInsight cluster.
 */
model SecurityProfile {
  /**
   * The directory type.
   */
  directoryType?: DirectoryType;

  /**
   * The organization's active directory domain.
   */
  domain?: string;

  /**
   * The organizational unit within the Active Directory to place the cluster and service accounts.
   */
  @visibility("read", "create")
  organizationalUnitDN?: string;

  /**
   * The LDAPS protocol URLs to communicate with the Active Directory.
   */
  ldapsUrls?: string[];

  /**
   * The domain user account that will have admin privileges on the cluster.
   */
  domainUsername?: string;

  /**
   * The domain admin password.
   */
  @secret
  domainUserPassword?: string;

  /**
   * Optional. The Distinguished Names for cluster user groups
   */
  clusterUsersGroupDNs?: string[];

  /**
   * The resource ID of the user's Azure Active Directory Domain Service.
   */
  aaddsResourceId?: string;

  /**
   * User assigned identity that has permissions to read and create cluster-related artifacts in the user's AADDS.
   */
  msiResourceId?: string;
}

/**
 * The storage profile.
 */
model StorageProfile {
  /**
   * The list of storage accounts in the cluster.
   */
  storageaccounts?: StorageAccount[];
}

/**
 * The storage Account.
 */
model StorageAccount {
  /**
   * The name of the storage account.
   */
  name?: string;

  /**
   * Whether or not the storage account is the default storage account.
   */
  isDefault?: boolean;

  /**
   * The container in the storage account, only to be specified for WASB storage accounts.
   */
  container?: string;

  /**
   * The filesystem, only to be specified for Azure Data Lake Storage Gen 2.
   */
  fileSystem?: string;

  /**
   * The storage account access key.
   */
  key?: string;

  /**
   * The resource ID of storage account, only to be specified for Azure Data Lake Storage Gen 2.
   */
  resourceId?: string;

  /**
   * The managed identity (MSI) that is allowed to access the storage account, only to be specified for Azure Data Lake Storage Gen 2.
   */
  msiResourceId?: string;

  /**
   * The shared access signature key.
   */
  saskey?: string;

  /**
   * The file share name.
   */
  fileshare?: string;

  /**
   * Enable secure channel or not, it's an optional field. Default value is false when cluster version < 5.1 and true when cluster version >= 5.1 ,
   */
  enableSecureChannel?: boolean;
}

/**
 * The disk encryption properties
 */
model DiskEncryptionProperties {
  /**
   * Base key vault URI where the customers key is located eg. https://myvault.vault.azure.net
   */
  vaultUri?: string;

  /**
   * Key name that is used for enabling disk encryption.
   */
  keyName?: string;

  /**
   * Specific key version that is used for enabling disk encryption.
   */
  keyVersion?: string;

  /**
   * Algorithm identifier for encryption, default RSA-OAEP.
   */
  encryptionAlgorithm?: JsonWebKeyEncryptionAlgorithm;

  /**
   * Resource ID of Managed Identity that is used to access the key vault.
   */
  msiResourceId?: string;

  /**
   * Indicates whether or not resource disk encryption is enabled.
   */
  encryptionAtHost?: boolean;
}

/**
 * The encryption-in-transit properties.
 */
model EncryptionInTransitProperties {
  /**
   * Indicates whether or not inter cluster node communication is encrypted in transit.
   */
  isEncryptionInTransitEnabled?: boolean;
}

/**
 * The network properties.
 */
model NetworkProperties {
  /**
   * The direction for the resource provider connection.
   */
  resourceProviderConnection?: ResourceProviderConnection;

  /**
   * Indicates whether or not private link is enabled.
   */
  privateLink?: PrivateLink;
}

/**
 * The compute isolation properties.
 */
model ComputeIsolationProperties {
  /**
   * The flag indicates whether enable compute isolation or not.
   */
  enableComputeIsolation?: boolean;

  /**
   * The host sku.
   */
  hostSku?: string;
}

/**
 * Identity for the cluster.
 */
model ClusterIdentity {
  /**
   * The principal id of cluster identity. This property will only be provided for a system assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant id associated with the cluster. This property will only be provided for a system assigned identity.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The type of identity used for the cluster. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the cluster. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * The properties of cluster.
 */
model ClusterGetProperties {
  /**
   * The version of the cluster.
   */
  clusterVersion?: string;

  /**
   * The hdp version of the cluster.
   */
  clusterHdpVersion?: string;

  /**
   * The type of operating system.
   */
  osType?: OSType;

  /**
   * The cluster tier.
   */
  tier?: Tier;

  /**
   * The cluster id.
   */
  clusterId?: string;

  /**
   * The cluster definition.
   */
  clusterDefinition: ClusterDefinition;

  /**
   * The cluster kafka rest proxy configuration.
   */
  kafkaRestProperties?: KafkaRestProperties;

  /**
   * The security profile.
   */
  securityProfile?: SecurityProfile;

  /**
   * The compute profile.
   */
  computeProfile?: ComputeProfile;

  /**
   * The provisioning state, which only appears in the response.
   */
  provisioningState?: HDInsightClusterProvisioningState;

  /**
   * The date on which the cluster was created.
   */
  createdDate?: string;

  /**
   * The state of the cluster.
   */
  clusterState?: string;

  /**
   * The quota information.
   */
  quotaInfo?: QuotaInfo;

  /**
   * The list of errors.
   */
  errors?: Errors[];

  /**
   * The list of connectivity endpoints.
   */
  connectivityEndpoints?: ConnectivityEndpoint[];

  /**
   * The disk encryption properties.
   */
  diskEncryptionProperties?: DiskEncryptionProperties;

  /**
   * The encryption-in-transit properties.
   */
  encryptionInTransitProperties?: EncryptionInTransitProperties;

  /**
   * The storage profile.
   */
  storageProfile?: StorageProfile;

  /**
   * The minimal supported tls version.
   */
  minSupportedTlsVersion?: string;

  /**
   * The excluded services config.
   */
  excludedServicesConfig?: ExcludedServicesConfig;

  /**
   * The network properties.
   */
  networkProperties?: NetworkProperties;

  /**
   * The compute isolation properties.
   */
  computeIsolationProperties?: ComputeIsolationProperties;

  /**
   * The private link configurations.
   */
  privateLinkConfigurations?: PrivateLinkConfiguration[];

  /**
   * The list of private endpoint connections.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];
}

/**
 * The quota properties for the cluster.
 */
model QuotaInfo {
  /**
   * The cores used by the cluster.
   */
  coresUsed?: int32;
}

/**
 * The connectivity properties
 */
model ConnectivityEndpoint {
  /**
   * The name of the endpoint.
   */
  name?: string;

  /**
   * The protocol of the endpoint.
   */
  protocol?: string;

  /**
   * The location of the endpoint.
   */
  location?: string;

  /**
   * The port to connect to.
   */
  port?: int32;

  /**
   * The private ip address of the endpoint.
   */
  privateIPAddress?: string;
}

/**
 * The configuration that services will be excluded when creating cluster.
 */
model ExcludedServicesConfig {
  /**
   * The config id of excluded services.
   */
  excludedServicesConfigId?: string;

  /**
   * The list of excluded services.
   */
  excludedServicesList?: string;
}

/**
 * The private endpoint connection properties.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The private endpoint of the private endpoint connection
   */
  @visibility("read")
  privateEndpoint?: PrivateEndpoint;

  /**
   * The private link service connection state.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The link identifier.
   */
  @visibility("read")
  linkIdentifier?: string;

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The private endpoint.
 */
model PrivateEndpoint {
  /**
   * The private endpoint id.
   */
  id?: string;
}

/**
 * The private link service connection state.
 */
model PrivateLinkServiceConnectionState {
  /**
   * The concrete private link service connection.
   */
  status: PrivateLinkServiceConnectionStatus;

  /**
   * The optional description of the status.
   */
  description?: string;

  /**
   * Whether there is further actions.
   */
  actionsRequired?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;
}

/**
 * The PatchCluster request parameters
 */
model ClusterPatchParameters {
  /**
   * The resource tags.
   */
  tags?: Record<string>;
}

/**
 * The Resize Cluster request parameters.
 */
model ClusterResizeParameters {
  /**
   * The target instance count for the operation.
   */
  targetInstanceCount?: int32;
}

/**
 * The autoscale configuration update parameter.
 */
model AutoscaleConfigurationUpdateParameter {
  /**
   * The autoscale configuration.
   */
  autoscale?: Autoscale;
}

/**
 * The Disk Encryption Cluster request parameters.
 */
model ClusterDiskEncryptionParameters {
  /**
   * Base key vault URI where the customers key is located eg. https://myvault.vault.azure.net
   */
  vaultUri?: string;

  /**
   * Key name that is used for enabling disk encryption.
   */
  keyName?: string;

  /**
   * Specific key version that is used for enabling disk encryption.
   */
  keyVersion?: string;
}

/**
 * Gateway settings.
 */
model GatewaySettings {
  /**
   * Indicates whether or not the gateway settings based authorization is enabled.
   */
  @visibility("read")
  @projectedName("json", "restAuthCredential.isEnabled")
  isCredentialEnabled?: boolean;

  /**
   * The gateway settings user name.
   */
  @visibility("read")
  @projectedName("json", "restAuthCredential.username")
  userName?: string;

  /**
   * The gateway settings user password.
   */
  @visibility("read")
  @projectedName("json", "restAuthCredential.password")
  password?: string;
}

/**
 * The update gateway settings request parameters.
 */
model UpdateGatewaySettingsParameters {
  /**
   * Indicates whether or not the gateway settings based authorization is enabled.
   */
  @projectedName("json", "restAuthCredential.isEnabled")
  isCredentialEnabled?: boolean = true;

  /**
   * The gateway settings user name.
   */
  @projectedName("json", "restAuthCredential.username")
  userName?: string;

  /**
   * The gateway settings user password.
   */
  @projectedName("json", "restAuthCredential.password")
  password?: string;
}

/**
 * The update cluster identity certificate request parameters.
 */
model UpdateClusterIdentityCertificateParameters {
  /**
   * The application id.
   */
  applicationId?: string;

  /**
   * The certificate in base64 encoded format.
   */
  certificate?: string;

  /**
   * The password of the certificate.
   */
  certificatePassword?: string;
}

/**
 * The configuration object for the specified cluster.
 */
model ClusterConfigurations {
  /**
   * The configuration object for the specified configuration for the specified cluster.
   */
  configurations?: Record<Record<string>>;
}

/**
 * The cluster monitor parameters.
 */
model ClusterMonitoringRequest {
  /**
   * The cluster monitor workspace ID.
   */
  workspaceId?: string;

  /**
   * The cluster monitor workspace key.
   */
  primaryKey?: string;
}

/**
 * The cluster monitoring status response.
 */
model ClusterMonitoringResponse {
  /**
   * The status of the monitor on the HDInsight cluster.
   */
  clusterMonitoringEnabled?: boolean;

  /**
   * The workspace ID of the monitor on the HDInsight cluster.
   */
  workspaceId?: string;
}

/**
 * The azure monitor parameters.
 */
model AzureMonitorRequest {
  /**
   * The Log Analytics workspace ID.
   */
  workspaceId?: string;

  /**
   * The Log Analytics workspace key.
   */
  primaryKey?: string;

  /**
   * The selected configurations.
   */
  selectedConfigurations?: AzureMonitorSelectedConfigurations;
}

/**
 * The selected configurations for azure monitor.
 */
model AzureMonitorSelectedConfigurations {
  /**
   * The configuration version.
   */
  configurationVersion?: string;

  /**
   * The global configurations of selected configurations.
   */
  globalConfigurations?: Record<string>;

  /**
   * The table list.
   */
  tableList?: AzureMonitorTableConfiguration[];
}

/**
 * The table configuration for the Log Analytics integration.
 */
model AzureMonitorTableConfiguration {
  /**
   * The name.
   */
  name?: string;
}

/**
 * The azure monitor status response.
 */
model AzureMonitorResponse {
  /**
   * The status of the monitor on the HDInsight cluster.
   */
  clusterMonitoringEnabled?: boolean;

  /**
   * The workspace ID of the monitor on the HDInsight cluster.
   */
  workspaceId?: string;

  /**
   * The selected configurations.
   */
  selectedConfigurations?: AzureMonitorSelectedConfigurations;
}

/**
 * Cluster monitoring extensions.
 */
model Extension {
  /**
   * The workspace ID for the cluster monitoring extension.
   */
  workspaceId?: string;

  /**
   * The certificate for the cluster monitoring extensions.
   */
  primaryKey?: string;
}

/**
 * The Get Capabilities operation response.
 */
model CapabilitiesResult {
  /**
   * The version capability.
   */
  versions?: Record<VersionsCapability>;

  /**
   * The virtual machine size compatibility features.
   */
  regions?: Record<RegionsCapability>;

  /**
   * The capability features.
   */
  features?: string[];

  /**
   * The quota capability.
   */
  @visibility("read")
  quota?: QuotaCapability;
}

/**
 * The version capability.
 */
model VersionsCapability {
  /**
   * The list of version capabilities.
   */
  available?: VersionSpec[];
}

/**
 * The version properties.
 */
model VersionSpec {
  /**
   * The friendly name
   */
  friendlyName?: string;

  /**
   * The display name
   */
  displayName?: string;

  /**
   * Whether or not the version is the default version.
   */
  isDefault?: boolean;

  /**
   * The component version property.
   */
  componentVersions?: Record<string>;
}

/**
 * The regions capability.
 */
model RegionsCapability {
  /**
   * The list of region capabilities.
   */
  available?: string[];
}

/**
 * The regional quota capability.
 */
model QuotaCapability {
  /**
   * The number of cores used in the subscription.
   */
  coresUsed?: int64;

  /**
   * The number of cores that the subscription allowed.
   */
  maxCoresAllowed?: int64;

  /**
   * The list of region quota capabilities.
   */
  regionalQuotas?: RegionalQuotaCapability[];
}

/**
 * The regional quota capacity.
 */
model RegionalQuotaCapability {
  /**
   * The region name.
   */
  regionName?: string;

  /**
   * The number of cores used in the region.
   */
  coresUsed?: int64;

  /**
   * The number of cores available in the region.
   */
  coresAvailable?: int64;
}

/**
 * The response for the operation to get regional usages for a subscription.
 */
model UsagesListResult {
  /**
   * The list of usages.
   */
  value?: Usage[];
}

/**
 * The details about the usage of a particular limited resource.
 */
model Usage {
  /**
   * The type of measurement for usage.
   */
  unit?: string;

  /**
   * The current usage.
   */
  currentValue?: int64;

  /**
   * The maximum allowed usage.
   */
  limit?: int64;

  /**
   * The details about the localizable name of the used resource.
   */
  @visibility("read")
  name?: LocalizedName;
}

/**
 * The details about the localizable name of a type of usage.
 */
model LocalizedName {
  /**
   * The name of the used resource.
   */
  value?: string;

  /**
   * The localized name of the used resource.
   */
  localizedValue?: string;
}

/**
 * The response for the operation to get regional billingSpecs for a subscription.
 */
model BillingResponseListResult {
  /**
   * The virtual machine sizes to include or exclude.
   */
  vmSizes?: string[];

  /**
   * The vm sizes which enable encryption at host.
   */
  vmSizesWithEncryptionAtHost?: string[];

  /**
   * The virtual machine filtering mode. Effectively this can enabling or disabling the virtual machine sizes in a particular set.
   */
  vmSizeFilters?: VmSizeCompatibilityFilterV2[];

  /**
   * The vm size properties.
   */
  @visibility("read")
  vmSizeProperties?: VmSizeProperty[];

  /**
   * The billing and managed disk billing resources for a region.
   */
  billingResources?: BillingResources[];
}

/**
 * This class represent a single filter object that defines a multidimensional set. The dimensions of this set are Regions, ClusterFlavors, NodeTypes and ClusterVersions. The constraint should be defined based on the following: FilterMode (Exclude vs Include), VMSizes (the vm sizes in affect of exclusion/inclusion) and the ordering of the Filters. Later filters override previous settings if conflicted.
 */
model VmSizeCompatibilityFilterV2 {
  /**
   * The filtering mode. Effectively this can enabling or disabling the VM sizes in a particular set.
   */
  filterMode?: FilterMode;

  /**
   * The list of regions under the effect of the filter.
   */
  regions?: string[];

  /**
   * The list of cluster flavors under the effect of the filter.
   */
  clusterFlavors?: string[];

  /**
   * The list of node types affected by the filter.
   */
  nodeTypes?: string[];

  /**
   * The list of cluster versions affected in Major.Minor format.
   */
  clusterVersions?: string[];

  /**
   * The OSType affected, Windows or Linux.
   */
  osType?: OSType[];

  /**
   * The list of virtual machine sizes to include or exclude.
   */
  vmSizes?: string[];

  /**
   * Whether apply for ESP cluster. 'true' means only for ESP, 'false' means only for non-ESP, null or empty string or others mean for both.
   */
  espApplied?: string;

  /**
   * Whether support compute isolation. 'true' means only for ComputeIsolationEnabled, 'false' means only for regular cluster.
   */
  computeIsolationSupported?: string;
}

/**
 * The vm size property
 */
model VmSizeProperty {
  /**
   * The vm size name.
   */
  name?: string;

  /**
   * The number of cores that the vm size has.
   */
  cores?: int32;

  /**
   * The data disk storage tier of the vm size.
   */
  dataDiskStorageTier?: string;

  /**
   * The label of the vm size.
   */
  label?: string;

  /**
   * The max data disk count of the vm size.
   */
  maxDataDiskCount?: int64;

  /**
   * The memory whose unit is MB of the vm size.
   */
  memoryInMb?: int64;

  /**
   * This indicates this vm size is supported by virtual machines or not
   */
  supportedByVirtualMachines?: boolean;

  /**
   * The indicates this vm size is supported by web worker roles or not
   */
  supportedByWebWorkerRoles?: boolean;

  /**
   * The virtual machine resource disk size whose unit is MB of the vm size.
   */
  virtualMachineResourceDiskSizeInMb?: int64;

  /**
   * The web worker resource disk size whose unit is MB of the vm size.
   */
  webWorkerResourceDiskSizeInMb?: int64;
}

/**
 * The billing resources.
 */
model BillingResources {
  /**
   * The region or location.
   */
  region?: string;

  /**
   * The billing meter information.
   */
  billingMeters?: BillingMeters[];

  /**
   * The managed disk billing information.
   */
  diskBillingMeters?: DiskBillingMeters[];
}

/**
 * The billing meters.
 */
model BillingMeters {
  /**
   * The virtual machine sizes.
   */
  meterParameter?: string;

  /**
   * The HDInsight meter guid.
   */
  meter?: string;

  /**
   * The unit of meter, VMHours or CoreHours.
   */
  unit?: string;
}

/**
 * The disk billing meters.
 */
model DiskBillingMeters {
  /**
   * The managed disk meter guid.
   */
  diskRpMeter?: string;

  /**
   * The managed disk billing sku, P30 or S30.
   */
  sku?: string;

  /**
   * The managed disk billing tier, Standard or Premium.
   */
  tier?: Tier;
}

/**
 * The request spec of checking name availability.
 */
model NameAvailabilityCheckRequestParameters {
  /**
   * The resource name.
   */
  name?: string;

  /**
   * The resource type
   */
  type?: string;
}

/**
 * The response spec of checking name availability.
 */
model NameAvailabilityCheckResult {
  /**
   * This indicates whether the name is available.
   */
  nameAvailable?: boolean;

  /**
   * The reason of the result.
   */
  @visibility("read")
  reason?: string;

  /**
   * The related message.
   */
  @visibility("read")
  message?: string;
}

/**
 * The cluster create request specification.
 */
model ClusterCreateRequestValidationParameters
  extends ClusterCreateParametersExtended {
  /**
   * The cluster name.
   */
  name?: string;

  /**
   * The resource type.
   */
  type?: string;

  /**
   * The tenant id.
   */
  tenantId?: string;

  /**
   * This indicates whether fetch Aadds resource or not.
   */
  fetchAaddsResource?: boolean;
}

/**
 * The response of cluster create request validation.
 */
model ClusterCreateValidationResult {
  /**
   * The validation errors.
   */
  validationErrors?: ValidationErrorInfo[];

  /**
   * The validation warnings.
   */
  validationWarnings?: ValidationErrorInfo[];

  /**
   * The estimated creation duration.
   */
  estimatedCreationDuration?: duration;

  /**
   * The Azure active directory domain service resource details.
   */
  aaddsResourcesDetails?: AaddsResourceDetails[];
}

/**
 * The validation error information.
 */
model ValidationErrorInfo {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The error message.
   */
  message?: string;

  /**
   * The error resource.
   */
  errorResource?: string;

  /**
   * The message arguments
   */
  messageArguments?: string[];
}

/**
 * The Azure active directory domain service resource details.
 */
model AaddsResourceDetails {
  /**
   * The Azure active directory domain service name.
   */
  domainName?: string;

  /**
   * This indicates whether initial sync complete or not.
   */
  initialSyncComplete?: boolean;

  /**
   * This indicates whether enable ldaps or not.
   */
  ldapsEnabled?: boolean;

  /**
   * The base 64 format string of public ldap certificate.
   */
  ldapsPublicCertificateInBase64?: string;

  /**
   * The resource id of azure active directory domain service.
   */
  resourceId?: string;

  /**
   * The subnet resource id.
   */
  subnetId?: string;

  /**
   * The tenant id of azure active directory domain service .
   */
  tenantId?: string;
}

/**
 * The details of operation.
 */
model OperationProperties {
  /**
   * The specification of the service.
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * The specification of the service.
 */
model ServiceSpecification {
  /**
   * The metric specifications.
   */
  metricSpecifications?: MetricSpecifications[];
}

/**
 * The details of metric specifications.
 */
model MetricSpecifications {
  /**
   * The name of the metric specification.
   */
  name?: string;

  /**
   * The display name of the metric specification.
   */
  displayName?: string;

  /**
   * The display description of the metric specification.
   */
  displayDescription?: string;

  /**
   * The unit of the metric specification.
   */
  unit?: string;

  /**
   * The aggregation type of the metric specification.
   */
  aggregationType?: string;

  /**
   * The supported aggregation types of the metric specification.
   */
  supportedAggregationTypes?: string[];

  /**
   * The supported time grain types of the metric specification.
   */
  supportedTimeGrainTypes?: string[];

  /**
   * The flag indicates whether enable regional mdm account or not.
   */
  enableRegionalMdmAccount?: boolean;

  /**
   * The source mdm account.
   */
  sourceMdmAccount?: string;

  /**
   * The source mdm namespace.
   */
  sourceMdmNamespace?: string;

  /**
   * The metric filter pattern.
   */
  metricFilterPattern?: string;

  /**
   * The flag indicates whether filling gap with zero.
   */
  fillGapWithZero?: boolean;

  /**
   * The category of the metric.
   */
  category?: string;

  /**
   * The override name of resource id dimension name.
   */
  resourceIdDimensionNameOverride?: string;

  /**
   * The flag indicates whether the metric is internal or not.
   */
  isInternal?: boolean;

  /**
   * The override name of delegate metric.
   */
  delegateMetricNameOverride?: string;

  /**
   * The dimensions of the metric specification.
   */
  dimensions?: Dimension[];
}

/**
 * The definition of Dimension.
 */
model Dimension {
  /**
   * The name of the dimension.
   */
  name?: string;

  /**
   * The display name of the dimension.
   */
  displayName?: string;

  /**
   * The display name of the dimension.
   */
  internalName?: string;

  /**
   * The flag indicates whether the metric will be exported for shoebox or not.
   */
  toBeExportedForShoebox?: boolean;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility("read")
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * The parameters for the script actions to execute on a running cluster.
 */
model ExecuteScriptActionParameters {
  /**
   * The list of run time script actions.
   */
  scriptActions?: RuntimeScriptAction[];

  /**
   * Gets or sets if the scripts needs to be persisted.
   */
  persistOnSuccess: boolean;
}

/**
 * The persisted script action for the cluster.
 */
model ScriptActionsList is Azure.Core.Page<RuntimeScriptActionDetail>;

/**
 * The execution details of a script action.
 */
model RuntimeScriptActionDetail extends RuntimeScriptAction {
  /**
   * The execution id of the script action.
   */
  @visibility("read")
  scriptExecutionId?: int64;

  /**
   * The start time of script action execution.
   */
  @visibility("read")
  startTime?: string;

  /**
   * The end time of script action execution.
   */
  @visibility("read")
  endTime?: string;

  /**
   * The current execution status of the script action.
   */
  @visibility("read")
  status?: string;

  /**
   * The reason why the script action was executed.
   */
  @visibility("read")
  operation?: string;

  /**
   * The summary of script action execution result.
   */
  @visibility("read")
  executionSummary?: ScriptActionExecutionSummary[];

  /**
   * The script action execution debug information.
   */
  @visibility("read")
  debugInformation?: string;
}

/**
 * The execution summary of a script action.
 */
model ScriptActionExecutionSummary {
  /**
   * The status of script action execution.
   */
  @visibility("read")
  status?: string;

  /**
   * The instance count for a given script action execution status.
   */
  @visibility("read")
  instanceCount?: int32;
}

/**
 * The list script execution history response.
 */
model ScriptActionExecutionHistoryList
  is Azure.Core.Page<RuntimeScriptActionDetail>;

/**
 * The cluster host information.
 */
model HostInfo {
  /**
   * The host name
   */
  name?: string;

  /**
   * The Fully Qualified Domain Name of host
   */
  fqdn?: string;

  /**
   * The effective disk encryption key URL used by the host
   */
  effectiveDiskEncryptionKeyUrl?: string;
}

/**
 * The ListPersistedScriptActions operation response.
 */
model ClusterListPersistedScriptActionsResult {
  /**
   * The list of Persisted Script Actions.
   */
  value?: RuntimeScriptAction[];

  /**
   * The link (url) to the next page of results.
   */
  @visibility("read")
  nextLink?: string;
}

/**
 * The persisted script action for cluster.
 */
model ScriptActionPersistedGetResponseSpec {
  /**
   * The name of script action.
   */
  name?: string;

  /**
   * The URI to the script.
   */
  uri?: string;

  /**
   * The parameters for the script provided.
   */
  parameters?: string;

  /**
   * The list of roles where script will be executed.
   */
  roles?: string[];

  /**
   * The application name for the script action.
   */
  applicationName?: string;
}
