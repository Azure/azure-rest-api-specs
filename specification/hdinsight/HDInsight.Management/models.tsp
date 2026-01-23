import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.Foundations;

namespace Microsoft.HDInsight;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union DaysOfWeek {
  string,

  /**
   * Monday
   */
  Monday: "Monday",

  /**
   * Tuesday
   */
  Tuesday: "Tuesday",

  /**
   * Wednesday
   */
  Wednesday: "Wednesday",

  /**
   * Thursday
   */
  Thursday: "Thursday",

  /**
   * Friday
   */
  Friday: "Friday",

  /**
   * Saturday
   */
  Saturday: "Saturday",

  /**
   * Sunday
   */
  Sunday: "Sunday",
}

/**
 * The private link configuration provisioning state, which only appears in the response.
 */
union PrivateLinkConfigurationProvisioningState {
  string,

  /**
   * InProgress
   */
  InProgress: "InProgress",

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
}

/**
 * The method that private IP address is allocated.
 */
union PrivateIPAllocationMethod {
  string,

  /**
   * dynamic
   */
  dynamic: "dynamic",

  /**
   * static
   */
  static: "static",
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
 * The async operation state.
 */
union AsyncOperationState {
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
 * The type of operating system.
 */
union OSType {
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
 * The cluster tier.
 */
union Tier {
  string,

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * Premium
   */
  Premium: "Premium",
}

/**
 * The directory type.
 */
union DirectoryType {
  string,

  /**
   * ActiveDirectory
   */
  ActiveDirectory: "ActiveDirectory",
}

/**
 * Algorithm identifier for encryption, default RSA-OAEP.
 */
union JsonWebKeyEncryptionAlgorithm {
  string,

  /**
   * RSA-OAEP
   */
  `RSA-OAEP`: "RSA-OAEP",

  /**
   * RSA-OAEP-256
   */
  `RSA-OAEP-256`: "RSA-OAEP-256",

  /**
   * RSA1_5
   */
  RSA1_5: "RSA1_5",
}

/**
 * A value to describe how the outbound dependencies of a HDInsight cluster are managed. 'Managed' means that the outbound dependencies are managed by the HDInsight service. 'External' means that the outbound dependencies are managed by a customer specific solution.
 */
union OutboundDependenciesManagedType {
  string,

  /**
   * Managed
   */
  Managed: "Managed",

  /**
   * External
   */
  External: "External",
}

/**
 * The direction for the resource provider connection.
 */
union ResourceProviderConnection {
  string,

  /**
   * Inbound
   */
  Inbound: "Inbound",

  /**
   * Outbound
   */
  Outbound: "Outbound",
}

/**
 * Indicates whether or not private link is enabled.
 */
union PrivateLink {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * The type of identity used for the cluster. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities.
 */
union ResourceIdentityType {
  string,

  /**
   * SystemAssigned
   */
  SystemAssigned: "SystemAssigned",

  /**
   * UserAssigned
   */
  UserAssigned: "UserAssigned",

  /**
   * SystemAssigned, UserAssigned
   */
  `SystemAssigned, UserAssigned`: "SystemAssigned, UserAssigned",

  /**
   * None
   */
  None: "None",
}

/**
 * The provisioning state, which only appears in the response.
 */
union HDInsightClusterProvisioningState {
  string,

  /**
   * InProgress
   */
  InProgress: "InProgress",

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
}

/**
 * The concrete private link service connection.
 */
union PrivateLinkServiceConnectionStatus {
  string,

  /**
   * Approved
   */
  Approved: "Approved",

  /**
   * Rejected
   */
  Rejected: "Rejected",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Removed
   */
  Removed: "Removed",
}

/**
 * The provisioning state, which only appears in the response.
 */
union PrivateEndpointConnectionProvisioningState {
  string,

  /**
   * InProgress
   */
  InProgress: "InProgress",

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
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union RoleName {
  string,

  /**
   * workernode
   */
  workernode: "workernode",
}

/**
 * The filtering mode. Effectively this can enabling or disabling the VM sizes in a particular set.
 */
union FilterMode {
  string,

  /**
   * Exclude
   */
  Exclude: "Exclude",

  /**
   * Include
   */
  Include: "Include",

  /**
   * Recommend
   */
  Recommend: "Recommend",

  /**
   * Default
   */
  Default: "Default",
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
  @identifiers(#[])
  installScriptActions?: RuntimeScriptAction[];

  /**
   * The list of uninstall script actions.
   */
  @identifiers(#[])
  uninstallScriptActions?: RuntimeScriptAction[];

  /**
   * The list of application HTTPS endpoints.
   */
  @identifiers(#[])
  httpsEndpoints?: ApplicationGetHttpsEndpoint[];

  /**
   * The list of application SSH endpoints.
   */
  @identifiers(#[])
  sshEndpoints?: ApplicationGetEndpoint[];

  /**
   * The provisioning state of the application.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The application type.
   */
  applicationType?: string;

  /**
   * The application state.
   */
  @visibility(Lifecycle.Read)
  applicationState?: string;

  /**
   * The list of errors.
   */
  @identifiers(#["code"])
  errors?: Errors[];

  /**
   * The application create date time.
   */
  @visibility(Lifecycle.Read)
  createdDate?: string;

  /**
   * The marketplace identifier.
   */
  @visibility(Lifecycle.Read)
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
  @identifiers(#["name"])
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
  @secret
  minInstanceCount?: int32;

  /**
   * The instance count of the cluster.
   */
  targetInstanceCount?: int32;

  /**
   * The name of the virtual machine group.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  VMGroupName?: string;

  /**
   * The autoscale configurations.
   */
  autoscale?: Autoscale;

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
  @identifiers(#[])
  dataDisksGroups?: DataDisksGroups[];

  /**
   * The list of script actions on the role.
   */
  @identifiers(#[])
  scriptActions?: ScriptAction[];

  /**
   * Indicates whether encrypt the data disks.
   */
  encryptDataDisks?: boolean = false;
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
  @identifiers(#[])
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  password?: string;

  /**
   * The SSH profile.
   */
  sshProfile?: SshProfile;
}

/**
 * The list of SSH public keys.
 */
@secret
model SshProfile {
  /**
   * The list of SSH public keys.
   */
  @identifiers(#["certificateData"])
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
  @visibility(Lifecycle.Read)
  storageAccountType?: string;

  /**
   * ReadOnly. The DiskSize in GB. Do not set this value.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  diskSizeGB?: int32;
}

/**
 * Describes a script action on role on the cluster.
 */
@secret
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The destination port to connect to.
   */
  destinationPort?: int32;

  /**
   * The public port to connect to.
   */
  @visibility(Lifecycle.Read)
  publicPort?: int32;

  /**
   * The private ip address of the endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  privateIPAddress?: string;

  /**
   * The subdomain suffix of the application.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  privateIPAddress?: string;
}

/**
 * The error message associated with the cluster creation.
 */
model Errors {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * The private link configuration.
 */
model PrivateLinkConfiguration {
  /**
   * The private link configuration id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of private link configuration.
   */
  name: string;

  /**
   * The type of the private link configuration.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The private link configuration properties.
   */
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of private link IP configuration.
   */
  name: string;

  /**
   * The type of the private link IP configuration.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The private link ip configuration properties.
   */
  properties?: IPConfigurationProperties;
}

/**
 * The private link ip configuration properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IPConfigurationProperties {
  /**
   * The private link configuration provisioning state, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
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
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Describes the format of Error response.
 */
@error
model ErrorResponse {
  /**
   * Error code
   */
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  message?: string;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  tier?: Tier = "Standard";

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  componentVersion?: Record<string>;

  /**
   * The cluster configurations.
   */
  configurations?: ClusterDefinitionConfigurations;
}
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@secret
model ClusterDefinitionConfigurations {}

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("password")
  domainUserPassword?: string;

  /**
   * Optional. The Distinguished Names for cluster user groups
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @identifiers(#["name"])
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  encryptionAtHost?: boolean = false;
}

/**
 * The encryption-in-transit properties.
 */
model EncryptionInTransitProperties {
  /**
   * Indicates whether or not inter cluster node communication is encrypted in transit.
   */
  isEncryptionInTransitEnabled?: boolean = false;
}

/**
 * The network properties.
 */
model NetworkProperties {
  /**
   * A value to describe how the outbound dependencies of a HDInsight cluster are managed. 'Managed' means that the outbound dependencies are managed by the HDInsight service. 'External' means that the outbound dependencies are managed by a customer specific solution.
   */
  outboundDependenciesManagedType?: OutboundDependenciesManagedType;

  /**
   * The direction for the resource provider connection.
   */
  resourceProviderConnection?: ResourceProviderConnection;

  /**
   * Indicates whether or not private link is enabled.
   */
  privateLink?: PrivateLink;

  /**
   * Gets or sets the IP tag for the public IPs created along with the HDInsight Clusters.
   */
  publicIpTag?: IpTag;
}

/**
 * Contains the IpTag associated with the public IP address
 */
model IpTag {
  /**
   * Gets or sets the ipTag type: Example FirstPartyUsage.
   */
  ipTagType: string;

  /**
   * Gets or sets value of the IpTag associated with the public IP. Example HDInsight, SQL, Storage etc
   */
  tag: string;
}

/**
 * The compute isolation properties.
 */
model ComputeIsolationProperties {
  /**
   * The flag indicates whether enable compute isolation or not.
   */
  enableComputeIsolation?: boolean = false;

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
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id associated with the cluster. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of identity used for the cluster. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the cluster. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * The User Assigned Identity
 */
model UserAssignedIdentity {
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

  /**
   * The tenant id of user assigned identity.
   */
  tenantId?: string;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @identifiers(#["code"])
  errors?: Errors[];

  /**
   * The list of connectivity endpoints.
   */
  @identifiers(#["name"])
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  privateEndpoint?: PrivateEndpoint;

  /**
   * The private link service connection state.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The link identifier.
   */
  @visibility(Lifecycle.Read)
  linkIdentifier?: string;

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
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
 * The PatchCluster request parameters
 */
model ClusterPatchParameters {
  /**
   * The resource tags.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string> | null;

  /**
   * The identity of the cluster, if configured. Setting this property will override the existing identity configuration of the cluster.
   */
  identity?: ClusterIdentity;
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  `restAuthCredential.isEnabled`?: string;

  /**
   * The gateway settings user name.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  `restAuthCredential.username`?: string;

  /**
   * The gateway settings user password.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  `restAuthCredential.password`?: string;

  /**
   * List of Entra users for gateway access.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  restAuthEntraUsers?: EntraUserInfo[];
}

/**
 * Details of an Entra user for gateway access.
 */
model EntraUserInfo {
  /**
   * The unique object ID of the Entra user or client ID of the enterprise applications.
   */
  objectId?: string;

  /**
   * The display name of the Entra user.
   */
  displayName?: string;

  /**
   * The User Principal Name (UPN) of the Entra user. It may be empty in certain cases, such as for enterprise applications.
   */
  upn?: string;
}

/**
 * The update gateway settings request parameters. Note either basic or entra user should be provided at a time.
 */
model UpdateGatewaySettingsParameters {
  /**
   * Indicates whether or not the gateway settings based authorization is enabled.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `restAuthCredential.isEnabled`?: boolean = true;

  /**
   * The gateway settings user name.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `restAuthCredential.username`?: string;

  /**
   * The gateway settings user password.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `restAuthCredential.password`?: string;

  /**
   * List of Entra users for gateway access.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  restAuthEntraUsers?: EntraUserInfo[];
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
 * The configuration object for the specified configuration for the specified cluster.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ClusterConfiguration is Record<string>;

/**
 * The configuration object for the specified cluster.
 */
model ClusterConfigurations {
  /**
   * The configuration object for the specified configuration for the specified cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  configurations?: Record<ClusterConfiguration>;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  globalConfigurations?: Record<string>;

  /**
   * The table list.
   */
  @identifiers(#["name"])
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  versions?: Record<VersionsCapability>;

  /**
   * The virtual machine size compatibility features.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  regions?: Record<RegionsCapability>;

  /**
   * The capability features.
   */
  features?: string[];

  /**
   * The quota capability.
   */
  @visibility(Lifecycle.Read)
  quota?: QuotaCapability;
}

/**
 * The version capability.
 */
model VersionsCapability {
  /**
   * The list of version capabilities.
   */
  @identifiers(#["friendlyName"])
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @identifiers(#["regionName"])
  @visibility(Lifecycle.Read)
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
  @identifiers(#[])
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  @identifiers(#[])
  vmSizeFilters?: VmSizeCompatibilityFilterV2[];

  /**
   * The vm size properties.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  vmSizeProperties?: VmSizeProperty[];

  /**
   * The billing and managed disk billing resources for a region.
   */
  @identifiers(#[])
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
  @identifiers(#["meter"])
  billingMeters?: BillingMeters[];

  /**
   * The managed disk billing information.
   */
  @identifiers(#["diskRpMeter"])
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
  @visibility(Lifecycle.Read)
  reason?: string;

  /**
   * The related message.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * The cluster create request specification.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @identifiers(#["code"])
  validationErrors?: ValidationErrorInfo[];

  /**
   * The validation warnings.
   */
  @identifiers(#["code"])
  validationWarnings?: ValidationErrorInfo[];

  /**
   * The estimated creation duration.
   */
  estimatedCreationDuration?: duration;

  /**
   * The Azure active directory domain service resource details.
   */
  @identifiers(#["resourceId"])
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
 * Result of the request to list HDInsight operations. It contains a list of operations and a URL link to get the next set of results.
 */
model OperationListResult {
  /**
   * The list of HDInsight operations supported by the HDInsight resource provider.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  value?: Operation[];

  /**
   * The URL to get the next set of operation list results if there are any.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The HDInsight REST API operation.
 */
model Operation {
  /**
   * The operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * The display of operation.
   */
  display?: OperationDisplay;

  /**
   * The operation properties.
   */
  properties?: OperationProperties;
}

/**
 * The object that represents the operation.
 */
model OperationDisplay {
  /**
   * The service provider: Microsoft.HDInsight
   */
  provider?: string;

  /**
   * The resource on which the operation is performed: Cluster, Applications, etc.
   */
  resource?: string;

  /**
   * The operation type: read, write, delete, etc.
   */
  operation?: string;

  /**
   * Localized friendly description for the operation
   */
  description?: string;
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
  @identifiers(#["name"])
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
  @identifiers(#["name"])
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
 * A list of private link resources
 */
model PrivateLinkResourceListResult {
  /**
   * Array of private link resources
   */
  @pageItems
  value?: PrivateLinkResource[];
}

/**
 * The parameters for the script actions to execute on a running cluster.
 */
model ExecuteScriptActionParameters {
  /**
   * The list of run time script actions.
   */
  @identifiers(#[])
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RuntimeScriptActionDetail extends RuntimeScriptAction {
  /**
   * The execution id of the script action.
   */
  @visibility(Lifecycle.Read)
  scriptExecutionId?: int64;

  /**
   * The start time of script action execution.
   */
  @visibility(Lifecycle.Read)
  startTime?: string;

  /**
   * The end time of script action execution.
   */
  @visibility(Lifecycle.Read)
  endTime?: string;

  /**
   * The current execution status of the script action.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The reason why the script action was executed.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The summary of script action execution result.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  executionSummary?: ScriptActionExecutionSummary[];

  /**
   * The script action execution debug information.
   */
  @visibility(Lifecycle.Read)
  debugInformation?: string;
}

/**
 * The execution summary of a script action.
 */
model ScriptActionExecutionSummary {
  /**
   * The status of script action execution.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The instance count for a given script action execution status.
   */
  @visibility(Lifecycle.Read)
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
model ClusterListPersistedScriptActionsResult
  is Azure.Core.Page<RuntimeScriptAction>;

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

/**
 * Bad Request definition.
 */
@error
model ClustersExecuteScriptActionsBadRequestError {
  ...NotFoundResponse;
}
