import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
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

@doc("The private link configuration provisioning state, which only appears in the response.")
enum PrivateLinkConfigurationProvisioningState {
  InProgress,
  Failed,
  Succeeded,
  Canceled,
  Deleting,
}

@doc("The method that private IP address is allocated.")
enum PrivateIPAllocationMethod {
  dynamic,
  static,
}

@doc("The async operation state.")
enum AsyncOperationState {
  InProgress,
  Succeeded,
  Failed,
}

@doc("The type of operating system.")
enum OSType {
  Windows,
  Linux,
}

@doc("The cluster tier.")
enum Tier {
  Standard,
  Premium,
}

@doc("The directory type.")
enum DirectoryType {
  ActiveDirectory,
}

@doc("Algorithm identifier for encryption, default RSA-OAEP.")
enum JsonWebKeyEncryptionAlgorithm {
  `RSA-OAEP`,
  `RSA-OAEP-256`,
  RSA1_5,
}

@doc("The direction for the resource provider connection.")
enum ResourceProviderConnection {
  Inbound,
  Outbound,
}

@doc("Indicates whether or not private link is enabled.")
enum PrivateLink {
  Disabled,
  Enabled,
}

@doc("The type of identity used for the cluster. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities.")
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

@doc("The provisioning state, which only appears in the response.")
enum HDInsightClusterProvisioningState {
  InProgress,
  Failed,
  Succeeded,
  Canceled,
  Deleting,
}

@doc("The concrete private link service connection.")
enum PrivateLinkServiceConnectionStatus {
  Approved,
  Rejected,
  Pending,
  Removed,
}

@doc("The provisioning state, which only appears in the response.")
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

@doc("The filtering mode. Effectively this can enabling or disabling the VM sizes in a particular set.")
enum FilterMode {
  Exclude,
  Include,
  Recommend,
  Default,
}

@doc("The HDInsight cluster application GET response.")
model ApplicationProperties {
  @doc("The list of roles in the cluster.")
  computeProfile?: ComputeProfile;

  @doc("The list of install script actions.")
  installScriptActions?: RuntimeScriptAction[];

  @doc("The list of uninstall script actions.")
  uninstallScriptActions?: RuntimeScriptAction[];

  @doc("The list of application HTTPS endpoints.")
  httpsEndpoints?: ApplicationGetHttpsEndpoint[];

  @doc("The list of application SSH endpoints.")
  sshEndpoints?: ApplicationGetEndpoint[];

  @doc("The provisioning state of the application.")
  @visibility("read")
  provisioningState?: string;

  @doc("The application type.")
  applicationType?: string;

  @doc("The application state.")
  @visibility("read")
  applicationState?: string;

  @doc("The list of errors.")
  errors?: Errors[];

  @doc("The application create date time.")
  @visibility("read")
  createdDate?: string;

  @doc("The marketplace identifier.")
  @visibility("read")
  marketplaceIdentifier?: string;

  @doc("The private link configurations.")
  privateLinkConfigurations?: PrivateLinkConfiguration[];
}

@doc("Describes the compute profile.")
model ComputeProfile {
  @doc("The list of roles in the cluster.")
  roles?: Role[];
}

@doc("Describes a role on the cluster.")
model Role {
  @doc("The name of the role.")
  name?: string;

  @doc("The minimum instance count of the cluster.")
  minInstanceCount?: int32;

  @doc("The instance count of the cluster.")
  targetInstanceCount?: int32;

  @doc("The name of the virtual machine group.")
  @visibility("read", "create")
  VMGroupName?: string;

  @doc("The autoscale configurations.")
  @projectedName("json", "autoscale")
  autoscaleConfiguration?: Autoscale;

  @doc("The hardware profile.")
  hardwareProfile?: HardwareProfile;

  @doc("The operating system profile.")
  osProfile?: OsProfile;

  @doc("The virtual network profile.")
  virtualNetworkProfile?: VirtualNetworkProfile;

  @doc("The data disks groups for the role.")
  dataDisksGroups?: DataDisksGroups[];

  @doc("The list of script actions on the role.")
  scriptActions?: ScriptAction[];

  @doc("Indicates whether encrypt the data disks.")
  encryptDataDisks?: boolean;
}

@doc("The autoscale request parameters")
model Autoscale {
  @doc("Parameters for load-based autoscale")
  capacity?: AutoscaleCapacity;

  @doc("Parameters for schedule-based autoscale")
  recurrence?: AutoscaleRecurrence;
}

@doc("The load-based autoscale request parameters")
model AutoscaleCapacity {
  @doc("The minimum instance count of the cluster")
  minInstanceCount?: int32;

  @doc("The maximum instance count of the cluster")
  maxInstanceCount?: int32;
}

@doc("Schedule-based autoscale request parameters")
model AutoscaleRecurrence {
  @doc("The time zone for the autoscale schedule times")
  timeZone?: string;

  @doc("Array of schedule-based autoscale rules")
  schedule?: AutoscaleSchedule[];
}

@doc("Parameters for a schedule-based autoscale rule, consisting of an array of days + a time and capacity")
model AutoscaleSchedule {
  @doc("Days of the week for a schedule-based autoscale rule")
  days?: DaysOfWeek[];

  @doc("Time and capacity for a schedule-based autoscale rule")
  timeAndCapacity?: AutoscaleTimeAndCapacity;
}

@doc("Time and capacity request parameters")
model AutoscaleTimeAndCapacity {
  @doc("24-hour time in the form xx:xx")
  time?: string;

  @doc("The minimum instance count of the cluster")
  minInstanceCount?: int32;

  @doc("The maximum instance count of the cluster")
  maxInstanceCount?: int32;
}

@doc("The hardware profile.")
model HardwareProfile {
  @doc("The size of the VM")
  vmSize?: string;
}

@doc("The Linux operation systems profile.")
model OsProfile {
  @doc("The Linux OS profile.")
  linuxOperatingSystemProfile?: LinuxOperatingSystemProfile;
}

@doc("The ssh username, password, and ssh public key.")
model LinuxOperatingSystemProfile {
  @doc("The username.")
  username?: string;

  @doc("The password.")
  password?: string;

  @doc("The SSH profile.")
  sshProfile?: SshProfile;
}

@doc("The list of SSH public keys.")
model SshProfile {
  @doc("The list of SSH public keys.")
  publicKeys?: SshPublicKey[];
}

@doc("The SSH public key for the cluster nodes.")
model SshPublicKey {
  @doc("The certificate for SSH.")
  certificateData?: string;
}

@doc("The virtual network properties.")
model VirtualNetworkProfile {
  @doc("The ID of the virtual network.")
  id?: string;

  @doc("The name of the subnet.")
  subnet?: string;
}

@doc("The data disks groups for the role.")
model DataDisksGroups {
  @doc("The number of disks per node.")
  disksPerNode?: int32;

  @doc("ReadOnly. The storage account type. Do not set this value.")
  @visibility("read")
  storageAccountType?: string;

  @doc("ReadOnly. The DiskSize in GB. Do not set this value.")
  @visibility("read")
  diskSizeGB?: int32;
}

@doc("Describes a script action on role on the cluster.")
model ScriptAction {
  @doc("The name of the script action.")
  name: string;

  @doc("The URI to the script.")
  uri: string;

  @doc("The parameters for the script provided.")
  parameters: string;
}

@doc("Describes a script action on a running cluster.")
model RuntimeScriptAction {
  @doc("The name of the script action.")
  name: string;

  @doc("The URI to the script.")
  uri: string;

  @doc("The parameters for the script")
  parameters?: string;

  @doc("The list of roles where script will be executed.")
  roles: string[];

  @doc("The application name of the script action, if any.")
  @visibility("read")
  applicationName?: string;
}

@doc("Gets the application HTTP endpoints.")
model ApplicationGetHttpsEndpoint {
  @doc("The list of access modes for the application.")
  accessModes?: string[];

  @doc("The location of the endpoint.")
  @visibility("read")
  location?: string;

  @doc("The destination port to connect to.")
  destinationPort?: int32;

  @doc("The public port to connect to.")
  @visibility("read")
  publicPort?: int32;

  @doc("The private ip address of the endpoint.")
  @visibility("read", "create")
  privateIPAddress?: string;

  @doc("The subdomain suffix of the application.")
  @visibility("create", "update")
  subDomainSuffix?: string;

  @doc("The value indicates whether to disable GatewayAuth.")
  disableGatewayAuth?: boolean;
}

@doc("Gets the application SSH endpoint")
model ApplicationGetEndpoint {
  @doc("The location of the endpoint.")
  location?: string;

  @doc("The destination port to connect to.")
  destinationPort?: int32;

  @doc("The public port to connect to.")
  publicPort?: int32;

  @doc("The private ip address of the endpoint.")
  @visibility("read", "create")
  privateIPAddress?: string;
}

@doc("The error message associated with the cluster creation.")
model Errors {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: Errors[];
}

@doc("The private link configuration.")
model PrivateLinkConfiguration {
  @doc("The private link configuration id.")
  @visibility("read")
  id?: string;

  @doc("The name of private link configuration.")
  name: string;

  @doc("The type of the private link configuration.")
  @visibility("read")
  type?: string;

  @doc("The private link configuration properties.")
  properties: PrivateLinkConfigurationProperties;
}

@doc("The private link configuration properties.")
model PrivateLinkConfigurationProperties {
  @doc("The HDInsight private linkable sub-resource name to apply the private link configuration to. For example, 'headnode', 'gateway', 'edgenode'.")
  groupId: string;

  @doc("The private link configuration provisioning state, which only appears in the response.")
  @visibility("read")
  provisioningState?: PrivateLinkConfigurationProvisioningState;

  @doc("The IP configurations for the private link service.")
  ipConfigurations: IPConfiguration[];
}

@doc("The ip configurations for the private link service.")
model IPConfiguration {
  @doc("The private link IP configuration id.")
  @visibility("read")
  id?: string;

  @doc("The name of private link IP configuration.")
  name: string;

  @doc("The type of the private link IP configuration.")
  @visibility("read")
  type?: string;

  @doc("The private link ip configuration properties.")
  properties?: IPConfigurationProperties;
}

@doc("The private link ip configuration properties.")
model IPConfigurationProperties {
  @doc("The private link configuration provisioning state, which only appears in the response.")
  @visibility("read")
  provisioningState?: PrivateLinkConfigurationProvisioningState;

  @doc("Indicates whether this IP configuration is primary for the corresponding NIC.")
  primary?: boolean;

  @doc("The IP address.")
  privateIPAddress?: string;

  @doc("The method that private IP address is allocated.")
  privateIPAllocationMethod?: PrivateIPAllocationMethod;

  @doc("The subnet resource id.")
  subnet?: ResourceId;
}

@doc("The azure resource id.")
model ResourceId {
  @doc("The azure resource id.")
  id?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model HDInsightClusterResponseData {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("The azure async operation response.")
model AsyncOperationResult {
  @doc("The async operation state.")
  status?: AsyncOperationState;

  @doc("The operation error information.")
  error?: Errors;
}

@doc("The CreateCluster request parameters.")
model ClusterCreateParametersExtended {
  @doc("The location of the cluster.")
  location?: string;

  @doc("The resource tags.")
  tags?: Record<string>;

  @doc("The availability zones.")
  zones?: string[];

  @doc("The cluster create parameters.")
  properties?: ClusterCreateProperties;

  @doc("The identity of the cluster, if configured.")
  identity?: ClusterIdentity;
}

@doc("The cluster create parameters.")
model ClusterCreateProperties {
  @doc("The version of the cluster.")
  clusterVersion?: string;

  @doc("The type of operating system.")
  osType?: OSType;

  @doc("The cluster tier.")
  @visibility("read", "create")
  tier?: Tier;

  @doc("The cluster definition.")
  clusterDefinition?: ClusterDefinition;

  @doc("The cluster kafka rest proxy configuration.")
  kafkaRestProperties?: KafkaRestProperties;

  @doc("The security profile.")
  securityProfile?: SecurityProfile;

  @doc("The compute profile.")
  computeProfile?: ComputeProfile;

  @doc("The storage profile.")
  storageProfile?: StorageProfile;

  @doc("The disk encryption properties.")
  diskEncryptionProperties?: DiskEncryptionProperties;

  @doc("The encryption-in-transit properties.")
  encryptionInTransitProperties?: EncryptionInTransitProperties;

  @doc("The minimal supported tls version.")
  minSupportedTlsVersion?: string;

  @doc("The network properties.")
  networkProperties?: NetworkProperties;

  @doc("The compute isolation properties.")
  computeIsolationProperties?: ComputeIsolationProperties;

  @doc("The private link configurations.")
  privateLinkConfigurations?: PrivateLinkConfiguration[];
}

@doc("The cluster definition.")
model ClusterDefinition {
  @doc("The link to the blueprint.")
  blueprint?: string;

  @doc("The type of cluster.")
  kind?: string;

  @doc("The versions of different services in the cluster.")
  @visibility("read", "create")
  componentVersion?: Record<string>;

  @doc("The cluster configurations.")
  configurations?: Record<unknown>;
}

@doc("The kafka rest proxy configuration which contains AAD security group information.")
model KafkaRestProperties {
  @doc("The information of AAD security group.")
  clientGroupInfo?: ClientGroupInfo;

  @doc("The configurations that need to be overriden.")
  configurationOverride?: Record<string>;
}

@doc("The information of AAD security group.")
model ClientGroupInfo {
  @doc("The AAD security group name.")
  groupName?: string;

  @doc("The AAD security group id.")
  groupId?: string;
}

@doc("The security profile which contains Ssh public key for the HDInsight cluster.")
model SecurityProfile {
  @doc("The directory type.")
  directoryType?: DirectoryType;

  @doc("The organization's active directory domain.")
  domain?: string;

  @doc("The organizational unit within the Active Directory to place the cluster and service accounts.")
  @visibility("read", "create")
  organizationalUnitDN?: string;

  @doc("The LDAPS protocol URLs to communicate with the Active Directory.")
  ldapsUrls?: string[];

  @doc("The domain user account that will have admin privileges on the cluster.")
  domainUsername?: string;

  @doc("The domain admin password.")
  @secret
  domainUserPassword?: string;

  @doc("Optional. The Distinguished Names for cluster user groups")
  clusterUsersGroupDNs?: string[];

  @doc("The resource ID of the user's Azure Active Directory Domain Service.")
  aaddsResourceId?: string;

  @doc("User assigned identity that has permissions to read and create cluster-related artifacts in the user's AADDS.")
  msiResourceId?: string;
}

@doc("The storage profile.")
model StorageProfile {
  @doc("The list of storage accounts in the cluster.")
  storageaccounts?: StorageAccount[];
}

@doc("The storage Account.")
model StorageAccount {
  @doc("The name of the storage account.")
  name?: string;

  @doc("Whether or not the storage account is the default storage account.")
  isDefault?: boolean;

  @doc("The container in the storage account, only to be specified for WASB storage accounts.")
  container?: string;

  @doc("The filesystem, only to be specified for Azure Data Lake Storage Gen 2.")
  fileSystem?: string;

  @doc("The storage account access key.")
  key?: string;

  @doc("The resource ID of storage account, only to be specified for Azure Data Lake Storage Gen 2.")
  resourceId?: string;

  @doc("The managed identity (MSI) that is allowed to access the storage account, only to be specified for Azure Data Lake Storage Gen 2.")
  msiResourceId?: string;

  @doc("The shared access signature key.")
  saskey?: string;

  @doc("The file share name.")
  fileshare?: string;

  @doc("Enable secure channel or not, it's an optional field. Default value is false when cluster version < 5.1 and true when cluster version >= 5.1 , ")
  enableSecureChannel?: boolean;
}

@doc("The disk encryption properties")
model DiskEncryptionProperties {
  @doc("Base key vault URI where the customers key is located eg. https://myvault.vault.azure.net")
  vaultUri?: string;

  @doc("Key name that is used for enabling disk encryption.")
  keyName?: string;

  @doc("Specific key version that is used for enabling disk encryption.")
  keyVersion?: string;

  @doc("Algorithm identifier for encryption, default RSA-OAEP.")
  encryptionAlgorithm?: JsonWebKeyEncryptionAlgorithm;

  @doc("Resource ID of Managed Identity that is used to access the key vault.")
  msiResourceId?: string;

  @doc("Indicates whether or not resource disk encryption is enabled.")
  encryptionAtHost?: boolean;
}

@doc("The encryption-in-transit properties.")
model EncryptionInTransitProperties {
  @doc("Indicates whether or not inter cluster node communication is encrypted in transit.")
  isEncryptionInTransitEnabled?: boolean;
}

@doc("The network properties.")
model NetworkProperties {
  @doc("The direction for the resource provider connection.")
  resourceProviderConnection?: ResourceProviderConnection;

  @doc("Indicates whether or not private link is enabled.")
  privateLink?: PrivateLink;
}

@doc("The compute isolation properties.")
model ComputeIsolationProperties {
  @doc("The flag indicates whether enable compute isolation or not.")
  enableComputeIsolation?: boolean;

  @doc("The host sku.")
  hostSku?: string;
}

@doc("Identity for the cluster.")
model ClusterIdentity {
  @doc("The principal id of cluster identity. This property will only be provided for a system assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant id associated with the cluster. This property will only be provided for a system assigned identity.")
  @visibility("read")
  tenantId?: string;

  @doc("The type of identity used for the cluster. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities.")
  type?: ResourceIdentityType;

  @doc("The list of user identities associated with the cluster. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.")
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

@doc("The properties of cluster.")
model ClusterGetProperties {
  @doc("The version of the cluster.")
  clusterVersion?: string;

  @doc("The hdp version of the cluster.")
  clusterHdpVersion?: string;

  @doc("The type of operating system.")
  osType?: OSType;

  @doc("The cluster tier.")
  tier?: Tier;

  @doc("The cluster id.")
  clusterId?: string;

  @doc("The cluster definition.")
  clusterDefinition: ClusterDefinition;

  @doc("The cluster kafka rest proxy configuration.")
  kafkaRestProperties?: KafkaRestProperties;

  @doc("The security profile.")
  securityProfile?: SecurityProfile;

  @doc("The compute profile.")
  computeProfile?: ComputeProfile;

  @doc("The provisioning state, which only appears in the response.")
  provisioningState?: HDInsightClusterProvisioningState;

  @doc("The date on which the cluster was created.")
  createdDate?: string;

  @doc("The state of the cluster.")
  clusterState?: string;

  @doc("The quota information.")
  quotaInfo?: QuotaInfo;

  @doc("The list of errors.")
  errors?: Errors[];

  @doc("The list of connectivity endpoints.")
  connectivityEndpoints?: ConnectivityEndpoint[];

  @doc("The disk encryption properties.")
  diskEncryptionProperties?: DiskEncryptionProperties;

  @doc("The encryption-in-transit properties.")
  encryptionInTransitProperties?: EncryptionInTransitProperties;

  @doc("The storage profile.")
  storageProfile?: StorageProfile;

  @doc("The minimal supported tls version.")
  minSupportedTlsVersion?: string;

  @doc("The excluded services config.")
  excludedServicesConfig?: ExcludedServicesConfig;

  @doc("The network properties.")
  networkProperties?: NetworkProperties;

  @doc("The compute isolation properties.")
  computeIsolationProperties?: ComputeIsolationProperties;

  @doc("The private link configurations.")
  privateLinkConfigurations?: PrivateLinkConfiguration[];

  @doc("The list of private endpoint connections.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];
}

@doc("The quota properties for the cluster.")
model QuotaInfo {
  @doc("The cores used by the cluster.")
  coresUsed?: int32;
}

@doc("The connectivity properties")
model ConnectivityEndpoint {
  @doc("The name of the endpoint.")
  name?: string;

  @doc("The protocol of the endpoint.")
  protocol?: string;

  @doc("The location of the endpoint.")
  location?: string;

  @doc("The port to connect to.")
  port?: int32;

  @doc("The private ip address of the endpoint.")
  privateIPAddress?: string;
}

@doc("The configuration that services will be excluded when creating cluster.")
model ExcludedServicesConfig {
  @doc("The config id of excluded services.")
  excludedServicesConfigId?: string;

  @doc("The list of excluded services.")
  excludedServicesList?: string;
}

@doc("The private endpoint connection properties.")
model PrivateEndpointConnectionProperties {
  @doc("The private endpoint of the private endpoint connection")
  @visibility("read")
  privateEndpoint?: PrivateEndpoint;

  @doc("The private link service connection state.")
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  @doc("The link identifier.")
  @visibility("read")
  linkIdentifier?: string;

  @doc("The provisioning state, which only appears in the response.")
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

@doc("The private endpoint.")
model PrivateEndpoint {
  @doc("The private endpoint id.")
  id?: string;
}

@doc("The private link service connection state.")
model PrivateLinkServiceConnectionState {
  @doc("The concrete private link service connection.")
  status: PrivateLinkServiceConnectionStatus;

  @doc("The optional description of the status.")
  description?: string;

  @doc("Whether there is further actions.")
  actionsRequired?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("The PatchCluster request parameters")
model ClusterPatchParameters {
  @doc("The resource tags.")
  tags?: Record<string>;
}

@doc("The Resize Cluster request parameters.")
model ClusterResizeParameters {
  @doc("The target instance count for the operation.")
  targetInstanceCount?: int32;
}

@doc("The autoscale configuration update parameter.")
model AutoscaleConfigurationUpdateParameter {
  @doc("The autoscale configuration.")
  autoscale?: Autoscale;
}

@doc("The Disk Encryption Cluster request parameters.")
model ClusterDiskEncryptionParameters {
  @doc("Base key vault URI where the customers key is located eg. https://myvault.vault.azure.net")
  vaultUri?: string;

  @doc("Key name that is used for enabling disk encryption.")
  keyName?: string;

  @doc("Specific key version that is used for enabling disk encryption.")
  keyVersion?: string;
}

@doc("Gateway settings.")
model GatewaySettings {
  @doc("Indicates whether or not the gateway settings based authorization is enabled.")
  @visibility("read")
  @projectedName("json", "restAuthCredential.isEnabled")
  isCredentialEnabled?: boolean;

  @doc("The gateway settings user name.")
  @visibility("read")
  @projectedName("json", "restAuthCredential.username")
  userName?: string;

  @doc("The gateway settings user password.")
  @visibility("read")
  @projectedName("json", "restAuthCredential.password")
  password?: string;
}

@doc("The update gateway settings request parameters.")
model UpdateGatewaySettingsParameters {
  @doc("Indicates whether or not the gateway settings based authorization is enabled.")
  @projectedName("json", "restAuthCredential.isEnabled")
  isCredentialEnabled?: boolean;

  @doc("The gateway settings user name.")
  @projectedName("json", "restAuthCredential.username")
  userName?: string;

  @doc("The gateway settings user password.")
  @projectedName("json", "restAuthCredential.password")
  password?: string;
}

@doc("The update cluster identity certificate request parameters.")
model UpdateClusterIdentityCertificateParameters {
  @doc("The application id.")
  applicationId?: string;

  @doc("The certificate in base64 encoded format.")
  certificate?: string;

  @doc("The password of the certificate.")
  certificatePassword?: string;
}

@doc("The configuration object for the specified cluster.")
model ClusterConfigurations {
  @doc("The configuration object for the specified configuration for the specified cluster.")
  configurations?: Record<Record<string>>;
}

@doc("The cluster monitor parameters.")
model ClusterMonitoringRequest {
  @doc("The cluster monitor workspace ID.")
  workspaceId?: string;

  @doc("The cluster monitor workspace key.")
  primaryKey?: string;
}

@doc("The cluster monitoring status response.")
model ClusterMonitoringResponse {
  @doc("The status of the monitor on the HDInsight cluster.")
  clusterMonitoringEnabled?: boolean;

  @doc("The workspace ID of the monitor on the HDInsight cluster.")
  workspaceId?: string;
}

@doc("The azure monitor parameters.")
model AzureMonitorRequest {
  @doc("The Log Analytics workspace ID.")
  workspaceId?: string;

  @doc("The Log Analytics workspace key.")
  primaryKey?: string;

  @doc("The selected configurations.")
  selectedConfigurations?: AzureMonitorSelectedConfigurations;
}

@doc("The selected configurations for azure monitor.")
model AzureMonitorSelectedConfigurations {
  @doc("The configuration version.")
  configurationVersion?: string;

  @doc("The global configurations of selected configurations.")
  globalConfigurations?: Record<string>;

  @doc("The table list.")
  tableList?: AzureMonitorTableConfiguration[];
}

@doc("The table configuration for the Log Analytics integration.")
model AzureMonitorTableConfiguration {
  @doc("The name.")
  name?: string;
}

@doc("The azure monitor status response.")
model AzureMonitorResponse {
  @doc("The status of the monitor on the HDInsight cluster.")
  clusterMonitoringEnabled?: boolean;

  @doc("The workspace ID of the monitor on the HDInsight cluster.")
  workspaceId?: string;

  @doc("The selected configurations.")
  selectedConfigurations?: AzureMonitorSelectedConfigurations;
}

@doc("Cluster monitoring extensions.")
model Extension {
  @doc("The workspace ID for the cluster monitoring extension.")
  workspaceId?: string;

  @doc("The certificate for the cluster monitoring extensions.")
  primaryKey?: string;
}

@doc("The Get Capabilities operation response.")
model CapabilitiesResult {
  @doc("The version capability.")
  versions?: Record<VersionsCapability>;

  @doc("The virtual machine size compatibility features.")
  regions?: Record<RegionsCapability>;

  @doc("The capability features.")
  features?: string[];

  @doc("The quota capability.")
  @visibility("read")
  quota?: QuotaCapability;
}

@doc("The version capability.")
model VersionsCapability {
  @doc("The list of version capabilities.")
  available?: VersionSpec[];
}

@doc("The version properties.")
model VersionSpec {
  @doc("The friendly name")
  friendlyName?: string;

  @doc("The display name")
  displayName?: string;

  @doc("Whether or not the version is the default version.")
  isDefault?: boolean;

  @doc("The component version property.")
  componentVersions?: Record<string>;
}

@doc("The regions capability.")
model RegionsCapability {
  @doc("The list of region capabilities.")
  available?: string[];
}

@doc("The regional quota capability.")
model QuotaCapability {
  @doc("The number of cores used in the subscription.")
  coresUsed?: int32;

  @doc("The number of cores that the subscription allowed.")
  maxCoresAllowed?: int32;

  @doc("The list of region quota capabilities.")
  regionalQuotas?: RegionalQuotaCapability[];
}

@doc("The regional quota capacity.")
model RegionalQuotaCapability {
  @doc("The region name.")
  regionName?: string;

  @doc("The number of cores used in the region.")
  coresUsed?: int32;

  @doc("The number of cores available in the region.")
  coresAvailable?: int32;
}

@doc("The response for the operation to get regional usages for a subscription.")
model UsagesListResult {
  @doc("The list of usages.")
  value?: Usage[];
}

@doc("The details about the usage of a particular limited resource.")
model Usage {
  @doc("The type of measurement for usage.")
  unit?: string;

  @doc("The current usage.")
  currentValue?: int32;

  @doc("The maximum allowed usage.")
  limit?: int32;

  @doc("The details about the localizable name of the used resource.")
  @visibility("read")
  name?: LocalizedName;
}

@doc("The details about the localizable name of a type of usage.")
model LocalizedName {
  @doc("The name of the used resource.")
  value?: string;

  @doc("The localized name of the used resource.")
  localizedValue?: string;
}

@doc("The response for the operation to get regional billingSpecs for a subscription.")
model BillingResponseListResult {
  @doc("The virtual machine sizes to include or exclude.")
  vmSizes?: string[];

  @doc("The vm sizes which enable encryption at host.")
  vmSizesWithEncryptionAtHost?: string[];

  @doc("The virtual machine filtering mode. Effectively this can enabling or disabling the virtual machine sizes in a particular set.")
  vmSizeFilters?: VmSizeCompatibilityFilterV2[];

  @doc("The vm size properties.")
  @visibility("read")
  vmSizeProperties?: VmSizeProperty[];

  @doc("The billing and managed disk billing resources for a region.")
  billingResources?: BillingResources[];
}

@doc("This class represent a single filter object that defines a multidimensional set. The dimensions of this set are Regions, ClusterFlavors, NodeTypes and ClusterVersions. The constraint should be defined based on the following: FilterMode (Exclude vs Include), VMSizes (the vm sizes in affect of exclusion/inclusion) and the ordering of the Filters. Later filters override previous settings if conflicted.")
model VmSizeCompatibilityFilterV2 {
  @doc("The filtering mode. Effectively this can enabling or disabling the VM sizes in a particular set.")
  filterMode?: FilterMode;

  @doc("The list of regions under the effect of the filter.")
  regions?: string[];

  @doc("The list of cluster flavors under the effect of the filter.")
  clusterFlavors?: string[];

  @doc("The list of node types affected by the filter.")
  nodeTypes?: string[];

  @doc("The list of cluster versions affected in Major.Minor format.")
  clusterVersions?: string[];

  @doc("The OSType affected, Windows or Linux.")
  osType?: OSType[];

  @doc("The list of virtual machine sizes to include or exclude.")
  vmSizes?: string[];

  @doc("Whether apply for ESP cluster. 'true' means only for ESP, 'false' means only for non-ESP, null or empty string or others mean for both.")
  espApplied?: string;

  @doc("Whether support compute isolation. 'true' means only for ComputeIsolationEnabled, 'false' means only for regular cluster.")
  computeIsolationSupported?: string;
}

@doc("The vm size property")
model VmSizeProperty {
  @doc("The vm size name.")
  name?: string;

  @doc("The number of cores that the vm size has.")
  cores?: int32;

  @doc("The data disk storage tier of the vm size.")
  dataDiskStorageTier?: string;

  @doc("The label of the vm size.")
  label?: string;

  @doc("The max data disk count of the vm size.")
  maxDataDiskCount?: int32;

  @doc("The memory whose unit is MB of the vm size.")
  memoryInMb?: int32;

  @doc("This indicates this vm size is supported by virtual machines or not")
  supportedByVirtualMachines?: boolean;

  @doc("The indicates this vm size is supported by web worker roles or not")
  supportedByWebWorkerRoles?: boolean;

  @doc("The virtual machine resource disk size whose unit is MB of the vm size.")
  virtualMachineResourceDiskSizeInMb?: int32;

  @doc("The web worker resource disk size whose unit is MB of the vm size.")
  webWorkerResourceDiskSizeInMb?: int32;
}

@doc("The billing resources.")
model BillingResources {
  @doc("The region or location.")
  region?: string;

  @doc("The billing meter information.")
  billingMeters?: BillingMeters[];

  @doc("The managed disk billing information.")
  diskBillingMeters?: DiskBillingMeters[];
}

@doc("The billing meters.")
model BillingMeters {
  @doc("The virtual machine sizes.")
  meterParameter?: string;

  @doc("The HDInsight meter guid.")
  meter?: string;

  @doc("The unit of meter, VMHours or CoreHours.")
  unit?: string;
}

@doc("The disk billing meters.")
model DiskBillingMeters {
  @doc("The managed disk meter guid.")
  diskRpMeter?: string;

  @doc("The managed disk billing sku, P30 or S30.")
  sku?: string;

  @doc("The managed disk billing tier, Standard or Premium.")
  tier?: Tier;
}

@doc("The request spec of checking name availability.")
model NameAvailabilityCheckRequestParameters {
  @doc("The resource name.")
  name?: string;

  @doc("The resource type")
  type?: string;
}

@doc("The response spec of checking name availability.")
model NameAvailabilityCheckResult {
  @doc("This indicates whether the name is available.")
  nameAvailable?: boolean;

  @doc("The reason of the result.")
  @visibility("read")
  reason?: string;

  @doc("The related message.")
  @visibility("read")
  message?: string;
}

@doc("The cluster create request specification.")
model ClusterCreateRequestValidationParameters
  extends ClusterCreateParametersExtended {
  @doc("The cluster name.")
  name?: string;

  @doc("The resource type.")
  type?: string;

  @doc("The tenant id.")
  tenantId?: string;

  @doc("This indicates whether fetch Aadds resource or not.")
  fetchAaddsResource?: boolean;
}

@doc("The response of cluster create request validation.")
model ClusterCreateValidationResult {
  @doc("The validation errors.")
  validationErrors?: ValidationErrorInfo[];

  @doc("The validation warnings.")
  validationWarnings?: ValidationErrorInfo[];

  @doc("The estimated creation duration.")
  estimatedCreationDuration?: duration;

  @doc("The Azure active directory domain service resource details.")
  aaddsResourcesDetails?: AaddsResourceDetails[];
}

@doc("The validation error information.")
model ValidationErrorInfo {
  @doc("The error code.")
  code?: string;

  @doc("The error message.")
  message?: string;

  @doc("The error resource.")
  errorResource?: string;

  @doc("The message arguments")
  messageArguments?: string[];
}

@doc("The Azure active directory domain service resource details.")
model AaddsResourceDetails {
  @doc("The Azure active directory domain service name.")
  domainName?: string;

  @doc("This indicates whether initial sync complete or not.")
  initialSyncComplete?: boolean;

  @doc("This indicates whether enable ldaps or not.")
  ldapsEnabled?: boolean;

  @doc("The base 64 format string of public ldap certificate.")
  ldapsPublicCertificateInBase64?: string;

  @doc("The resource id of azure active directory domain service.")
  resourceId?: string;

  @doc("The subnet resource id.")
  subnetId?: string;

  @doc("The tenant id of azure active directory domain service .")
  tenantId?: string;
}

@doc("The details of operation.")
model OperationProperties {
  @doc("The specification of the service.")
  serviceSpecification?: ServiceSpecification;
}

@doc("The specification of the service.")
model ServiceSpecification {
  @doc("The metric specifications.")
  metricSpecifications?: MetricSpecifications[];
}

@doc("The details of metric specifications.")
model MetricSpecifications {
  @doc("The name of the metric specification.")
  name?: string;

  @doc("The display name of the metric specification.")
  displayName?: string;

  @doc("The display description of the metric specification.")
  displayDescription?: string;

  @doc("The unit of the metric specification.")
  unit?: string;

  @doc("The aggregation type of the metric specification.")
  aggregationType?: string;

  @doc("The supported aggregation types of the metric specification.")
  supportedAggregationTypes?: string[];

  @doc("The supported time grain types of the metric specification.")
  supportedTimeGrainTypes?: string[];

  @doc("The flag indicates whether enable regional mdm account or not.")
  enableRegionalMdmAccount?: boolean;

  @doc("The source mdm account.")
  sourceMdmAccount?: string;

  @doc("The source mdm namespace.")
  sourceMdmNamespace?: string;

  @doc("The metric filter pattern.")
  metricFilterPattern?: string;

  @doc("The flag indicates whether filling gap with zero.")
  fillGapWithZero?: boolean;

  @doc("The category of the metric.")
  category?: string;

  @doc("The override name of resource id dimension name.")
  resourceIdDimensionNameOverride?: string;

  @doc("The flag indicates whether the metric is internal or not.")
  isInternal?: boolean;

  @doc("The override name of delegate metric.")
  delegateMetricNameOverride?: string;

  @doc("The dimensions of the metric specification.")
  dimensions?: Dimension[];
}

@doc("The definition of Dimension.")
model Dimension {
  @doc("The name of the dimension.")
  name?: string;

  @doc("The display name of the dimension.")
  displayName?: string;

  @doc("The display name of the dimension.")
  internalName?: string;

  @doc("The flag indicates whether the metric will be exported for shoebox or not.")
  toBeExportedForShoebox?: boolean;
}

@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group id.")
  @visibility("read")
  groupId?: string;

  @doc("The private link resource required member names.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The private link resource Private link DNS zone name.")
  requiredZoneNames?: string[];
}

@doc("The parameters for the script actions to execute on a running cluster.")
model ExecuteScriptActionParameters {
  @doc("The list of run time script actions.")
  scriptActions?: RuntimeScriptAction[];

  @doc("Gets or sets if the scripts needs to be persisted.")
  persistOnSuccess: boolean;
}

@doc("The persisted script action for the cluster.")
model ScriptActionsList is Azure.Core.Page<RuntimeScriptActionDetail>;

@doc("The execution details of a script action.")
model RuntimeScriptActionDetail extends RuntimeScriptAction {
  @doc("The execution id of the script action.")
  @visibility("read")
  scriptExecutionId?: int32;

  @doc("The start time of script action execution.")
  @visibility("read")
  startTime?: string;

  @doc("The end time of script action execution.")
  @visibility("read")
  endTime?: string;

  @doc("The current execution status of the script action.")
  @visibility("read")
  status?: string;

  @doc("The reason why the script action was executed.")
  @visibility("read")
  operation?: string;

  @doc("The summary of script action execution result.")
  @visibility("read")
  executionSummary?: ScriptActionExecutionSummary[];

  @doc("The script action execution debug information.")
  @visibility("read")
  debugInformation?: string;
}

@doc("The execution summary of a script action.")
model ScriptActionExecutionSummary {
  @doc("The status of script action execution.")
  @visibility("read")
  status?: string;

  @doc("The instance count for a given script action execution status.")
  @visibility("read")
  instanceCount?: int32;
}

@doc("The list script execution history response.")
model ScriptActionExecutionHistoryList
  is Azure.Core.Page<RuntimeScriptActionDetail>;

@doc("The cluster host information.")
model HostInfo {
  @doc("The host name")
  name?: string;

  @doc("The Fully Qualified Domain Name of host")
  fqdn?: string;

  @doc("The effective disk encryption key URL used by the host")
  effectiveDiskEncryptionKeyUrl?: string;
}

@doc("The ListPersistedScriptActions operation response.")
model ClusterListPersistedScriptActionsResult {
  @doc("The list of Persisted Script Actions.")
  value?: RuntimeScriptAction[];

  @doc("The link (url) to the next page of results.")
  @visibility("read")
  nextLink?: string;
}

@doc("The persisted script action for cluster.")
model ScriptActionPersistedGetResponseSpec {
  @doc("The name of script action.")
  name?: string;

  @doc("The URI to the script.")
  uri?: string;

  @doc("The parameters for the script provided.")
  parameters?: string;

  @doc("The list of roles where script will be executed.")
  roles?: string[];

  @doc("The application name for the script action.")
  applicationName?: string;
}
