import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.SqlVirtualMachine;

/**
 * Replica Role in availability group.
 */
union Role {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Primary: "Primary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Secondary: "Secondary",
}

/**
 * Replica commit mode in availability group.
 */
union Commit {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Synchronous_Commit: "Synchronous_Commit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Asynchronous_Commit: "Asynchronous_Commit",
}

/**
 * Replica failover mode in availability group.
 */
union Failover {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Automatic: "Automatic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Manual: "Manual",
}

/**
 * Replica readable secondary mode in availability group.
 */
union ReadableSecondary {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  No: "No",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  All: "All",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Read_Only: "Read_Only",
}

/**
 * The intended executor of the operation.
 */
union OperationOrigin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  system: "system",
}

/**
 * SQL image sku.
 */
union SqlVmGroupImageSku {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Developer: "Developer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enterprise: "Enterprise",
}

/**
 * Scale type.
 */
union ScaleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HA: "HA",
}

/**
 * Type of cluster manager: Windows Server Failover Cluster (WSFC), implied by the scale type of the group and the OS type.
 */
union ClusterManagerType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WSFC: "WSFC",
}

/**
 * Cluster type.
 */
union ClusterConfiguration {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Domainful: "Domainful",
}

/**
 * Cluster subnet type.
 */
union ClusterSubnetType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SingleSubnet: "SingleSubnet",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MultiSubnet: "MultiSubnet",
}

/**
 * The identity type. Set this to 'SystemAssigned' in order to automatically create and assign an Azure Active Directory principal for the resource.
 */
union IdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

/**
 * SQL Server license type.
 */
union SqlServerLicenseType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PAYG: "PAYG",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AHUB: "AHUB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DR: "DR",
}

/**
 * SQL Server Management type. NOTE: This parameter is not used anymore. API will automatically detect the Sql Management, refrain from using it.
 */
union SqlManagementMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Full: "Full",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LightWeight: "LightWeight",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NoAgent: "NoAgent",
}

/**
 * SQL IaaS Agent least privilege mode.
 */
union LeastPrivilegeMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSet: "NotSet",
}

/**
 * SQL Server edition type.
 */
union SqlImageSku {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Developer: "Developer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Express: "Express",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enterprise: "Enterprise",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Web: "Web",
}

/**
 * Additional Patch to be enable or enabled on the SQL Virtual Machine.
 */
union AdditionalVmPatch {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSet: "NotSet",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MicrosoftUpdate: "MicrosoftUpdate",
}

/**
 * Backup schedule type.
 */
union BackupScheduleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Manual: "Manual",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Automated: "Automated",
}

/**
 * Frequency of full backups. In both cases, full backups begin during the next scheduled time window.
 */
union FullBackupFrequencyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Daily: "Daily",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Weekly: "Weekly",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union AutoBackupDaysOfWeek {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Monday: "Monday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Tuesday: "Tuesday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Wednesday: "Wednesday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Thursday: "Thursday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Friday: "Friday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Saturday: "Saturday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Sunday: "Sunday",
}

/**
 * SQL Server connectivity option.
 */
union ConnectivityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LOCAL: "LOCAL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PRIVATE: "PRIVATE",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PUBLIC: "PUBLIC",
}

/**
 * SQL Server workload type.
 */
union SqlWorkloadType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GENERAL: "GENERAL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OLTP: "OLTP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DW: "DW",
}

/**
 * Disk configuration to apply to SQL Server.
 */
union DiskConfigurationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NEW: "NEW",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EXTEND: "EXTEND",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ADD: "ADD",
}

/**
 * Storage workload type.
 */
union StorageWorkloadType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GENERAL: "GENERAL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OLTP: "OLTP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DW: "DW",
}

/**
 * SQL VM troubleshooting scenario.
 */
union TroubleshootingScenario {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UnhealthyReplica: "UnhealthyReplica",
}

/**
 * Additional VM Patching solution enabled on the Virtual Machine
 */
union AdditionalOsPatch {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WU: "WU",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WUMU: "WUMU",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WSUS: "WSUS",
}

/**
 * Identity type of the virtual machine. Specify None to opt-out of Managed Identities.
 */
union VmIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
}

/**
 * Day of week to apply the patch on.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DayOfWeek {
  Everyday,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

/**
 * Day of the week to run assessment.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum AssessmentDayOfWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

/**
 * Operating System of the current SQL Virtual Machine.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum OsType {
  Windows,
  Linux,
}

/**
 * The properties of an availability group listener.
 */
model AvailabilityGroupListenerProperties {
  /**
   * Provisioning state to track the async operation status.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Name of the availability group.
   */
  availabilityGroupName?: string;

  /**
   * List of load balancer configurations for an availability group listener.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  loadBalancerConfigurations?: LoadBalancerConfiguration[];

  /**
   * List of multi subnet IP configurations for an AG listener.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  multiSubnetIpConfigurations?: MultiSubnetIpConfiguration[];

  /**
   * Create a default availability group if it does not exist.
   */
  createDefaultAvailabilityGroupIfNotExist?: boolean;

  /**
   * Listener port.
   */
  port?: int32;

  /**
   * Availability Group configuration.
   */
  availabilityGroupConfiguration?: AgConfiguration;
}

/**
 * A load balancer configuration for an availability group listener.
 */
model LoadBalancerConfiguration {
  /**
   * Private IP address.
   */
  privateIpAddress?: PrivateIPAddress;

  /**
   * Resource id of the public IP.
   */
  publicIpAddressResourceId?: string;

  /**
   * Resource id of the load balancer.
   */
  loadBalancerResourceId?: string;

  /**
   * Probe port.
   */
  probePort?: int32;

  /**
   * List of the SQL virtual machine instance resource id's that are enrolled into the availability group listener.
   */
  sqlVirtualMachineInstances?: string[];
}

/**
 * A private IP address bound to the availability group listener.
 */
model PrivateIPAddress {
  /**
   * Private IP address bound to the availability group listener.
   */
  ipAddress?: string;

  /**
   * Subnet used to include private IP.
   */
  subnetResourceId?: string;
}

/**
 * Multi subnet ip configuration for an availability group listener.
 */
model MultiSubnetIpConfiguration {
  /**
   * Private IP address.
   */
  privateIpAddress: PrivateIPAddress;

  /**
   * SQL virtual machine instance resource id that are enrolled into the availability group listener.
   */
  sqlVirtualMachineInstance: string;
}

/**
 * Availability group configuration.
 */
model AgConfiguration {
  /**
   * Replica configurations.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  replicas?: AgReplica[];
}

/**
 * Availability group replica configuration.
 */
model AgReplica {
  /**
   * Sql VirtualMachine Instance Id.
   */
  sqlVirtualMachineInstanceId?: string;

  /**
   * Replica Role in availability group.
   */
  role?: Role;

  /**
   * Replica commit mode in availability group.
   */
  commit?: Commit;

  /**
   * Replica failover mode in availability group.
   */
  failover?: Failover;

  /**
   * Replica readable secondary mode in availability group.
   */
  readableSecondary?: ReadableSecondary;
}

/**
 * ARM resource.
 */
model Resource {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The properties of a SQL virtual machine group.
 */
model SqlVirtualMachineGroupProperties {
  /**
   * Provisioning state to track the async operation status.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * SQL image offer. Examples may include SQL2016-WS2016, SQL2017-WS2016.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sqlImageOffer?: string;

  /**
   * SQL image sku.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sqlImageSku?: SqlVmGroupImageSku;

  /**
   * Scale type.
   */
  @visibility(Lifecycle.Read)
  scaleType?: ScaleType;

  /**
   * Type of cluster manager: Windows Server Failover Cluster (WSFC), implied by the scale type of the group and the OS type.
   */
  @visibility(Lifecycle.Read)
  clusterManagerType?: ClusterManagerType;

  /**
   * Cluster type.
   */
  @visibility(Lifecycle.Read)
  clusterConfiguration?: ClusterConfiguration;

  /**
   * Cluster Active Directory domain profile.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  wsfcDomainProfile?: WsfcDomainProfile;
}

/**
 * Active Directory account details to operate Windows Server Failover Cluster.
 */
model WsfcDomainProfile {
  /**
   * Fully qualified name of the domain.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  domainFqdn?: string;

  /**
   * Organizational Unit path in which the nodes and cluster will be present.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ouPath?: string;

  /**
   * Account name used for creating cluster (at minimum needs permissions to 'Create Computer Objects' in domain).
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  clusterBootstrapAccount?: string;

  /**
   * Account name used for operating cluster i.e. will be part of administrators group on all the participating virtual machines in the cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  clusterOperatorAccount?: string;

  /**
   * Account name under which SQL service will run on all participating SQL virtual machines in the cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  sqlServiceAccount?: string;

  /**
   * The flag to check if SQL service account is GMSA.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  isSqlServiceAccountGmsa?: boolean;

  /**
   * Optional path for fileshare witness.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  fileShareWitnessPath?: string;

  /**
   * Fully qualified ARM resource id of the witness storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageAccountUrl?: string;

  /**
   * Primary key of the witness storage account.
   */
  @visibility(Lifecycle.Create)
  storageAccountPrimaryKey?: string;

  /**
   * Cluster subnet type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  clusterSubnetType?: ClusterSubnetType;
}

/**
 * An update to a SQL virtual machine group.
 */
model SqlVirtualMachineGroupUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Azure Active Directory identity configuration for a resource.
 */
model ResourceIdentity {
  /**
   * The Azure Active Directory principal id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  principalId?: string;

  /**
   * The identity type. Set this to 'SystemAssigned' in order to automatically create and assign an Azure Active Directory principal for the resource.
   */
  type?: IdentityType;

  /**
   * The Azure Active Directory tenant id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  tenantId?: string;
}

/**
 * The SQL virtual machine properties.
 */
model SqlVirtualMachineProperties {
  /**
   * ARM Resource id of underlying virtual machine created from SQL marketplace image.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  virtualMachineResourceId?: string;

  /**
   * Provisioning state to track the async operation status.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * SQL image offer. Examples include SQL2016-WS2016, SQL2017-WS2016.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sqlImageOffer?: string;

  /**
   * SQL Server license type.
   */
  sqlServerLicenseType?: SqlServerLicenseType;

  /**
   * SQL Server Management type. NOTE: This parameter is not used anymore. API will automatically detect the Sql Management, refrain from using it.
   */
  sqlManagement?: SqlManagementMode;

  /**
   * SQL IaaS Agent least privilege mode.
   */
  leastPrivilegeMode?: LeastPrivilegeMode = LeastPrivilegeMode.NotSet;

  /**
   * SQL Server edition type.
   */
  sqlImageSku?: SqlImageSku;

  /**
   * ARM resource id of the SQL virtual machine group this SQL virtual machine is or will be part of.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  sqlVirtualMachineGroupResourceId?: string;

  /**
   * Domain credentials for setting up Windows Server Failover Cluster for SQL availability group.
   */
  wsfcDomainCredentials?: WsfcDomainCredentials;

  /**
   * Domain credentials for setting up Windows Server Failover Cluster for SQL availability group.
   */
  wsfcStaticIp?: string;

  /**
   * Auto patching settings for applying critical security updates to SQL virtual machine.
   */
  autoPatchingSettings?: AutoPatchingSettings;

  /**
   * Auto backup settings for SQL Server.
   */
  autoBackupSettings?: AutoBackupSettings;

  /**
   * Key vault credential settings.
   */
  keyVaultCredentialSettings?: KeyVaultCredentialSettings;

  /**
   * SQL Server configuration management settings.
   */
  serverConfigurationsManagementSettings?: ServerConfigurationsManagementSettings;

  /**
   * Storage Configuration Settings.
   */
  storageConfigurationSettings?: StorageConfigurationSettings;

  /**
   * Troubleshooting status
   */
  @visibility(Lifecycle.Read)
  troubleshootingStatus?: TroubleshootingStatus;

  /**
   * SQL best practices Assessment Settings.
   */
  assessmentSettings?: AssessmentSettings;

  /**
   * Enable automatic upgrade of Sql IaaS extension Agent.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Additional VM Patching solution enabled on the Virtual Machine
   */
  @visibility(Lifecycle.Read)
  additionalVmPatch?: AdditionalOsPatch;

  /**
   * Virtual Machine Identity details used for Sql IaaS extension configurations.
   */
  virtualMachineIdentitySettings?: VirtualMachineIdentity;

  /**
   * Operating System of the current SQL Virtual Machine.
   */
  @visibility(Lifecycle.Read)
  osType?: OsType;
}

/**
 * Domain credentials for setting up Windows Server Failover Cluster for SQL availability group.
 */
model WsfcDomainCredentials {
  /**
   * Cluster bootstrap account password.
   */
  clusterBootstrapAccountPassword?: string;

  /**
   * Cluster operator account password.
   */
  clusterOperatorAccountPassword?: string;

  /**
   * SQL service account password.
   */
  sqlServiceAccountPassword?: string;
}

/**
 * Set a patching window during which Windows and SQL patches will be applied.
 */
model AutoPatchingSettings {
  /**
   * Enable or disable autopatching on SQL virtual machine.
   */
  enable?: boolean;

  /**
   * Day of week to apply the patch on.
   */
  dayOfWeek?: DayOfWeek;

  /**
   * Hour of the day when patching is initiated. Local VM time.
   */
  maintenanceWindowStartingHour?: int32;

  /**
   * Duration of patching.
   */
  maintenanceWindowDuration?: int32;

  /**
   * Additional Patch to be enable or enabled on the SQL Virtual Machine.
   */
  additionalVmPatch?: AdditionalVmPatch = AdditionalVmPatch.NotSet;
}

/**
 * Configure backups for databases in your SQL virtual machine.
 */
model AutoBackupSettings {
  /**
   * Enable or disable autobackup on SQL virtual machine.
   */
  enable?: boolean;

  /**
   * Enable or disable encryption for backup on SQL virtual machine.
   */
  enableEncryption?: boolean;

  /**
   * Retention period of backup: 1-90 days.
   */
  retentionPeriod?: int32;

  /**
   * Storage account url where backup will be taken to.
   */
  storageAccountUrl?: string;

  /**
   * Storage container name where backup will be taken to.
   */
  storageContainerName?: string;

  /**
   * Storage account key where backup will be taken to.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  storageAccessKey?: string;

  /**
   * Password for encryption on backup.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  password?: string;

  /**
   * Include or exclude system databases from auto backup.
   */
  backupSystemDbs?: boolean;

  /**
   * Backup schedule type.
   */
  backupScheduleType?: BackupScheduleType;

  /**
   * Frequency of full backups. In both cases, full backups begin during the next scheduled time window.
   */
  fullBackupFrequency?: FullBackupFrequencyType;

  /**
   * Days of the week for the backups when FullBackupFrequency is set to Weekly.
   */
  daysOfWeek?: AutoBackupDaysOfWeek[];

  /**
   * Start time of a given day during which full backups can take place. 0-23 hours.
   */
  fullBackupStartTime?: int32;

  /**
   * Duration of the time window of a given day during which full backups can take place. 1-23 hours.
   */
  fullBackupWindowHours?: int32;

  /**
   * Frequency of log backups. 5-60 minutes.
   */
  logBackupFrequency?: int32;
}

/**
 * Configure your SQL virtual machine to be able to connect to the Azure Key Vault service.
 */
model KeyVaultCredentialSettings {
  /**
   * Enable or disable key vault credential setting.
   */
  enable?: boolean;

  /**
   * Credential name.
   */
  credentialName?: string;

  /**
   * Azure Key Vault url.
   */
  azureKeyVaultUrl?: string;

  /**
   * Service principal name to access key vault.
   */
  servicePrincipalName?: string;

  /**
   * Service principal name secret to access key vault.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  servicePrincipalSecret?: string;
}

/**
 * Set the connectivity, storage and workload settings.
 */
model ServerConfigurationsManagementSettings {
  /**
   * SQL connectivity type settings.
   */
  sqlConnectivityUpdateSettings?: SqlConnectivityUpdateSettings;

  /**
   * SQL workload type settings.
   */
  sqlWorkloadTypeUpdateSettings?: SqlWorkloadTypeUpdateSettings;

  /**
   * SQL storage update settings.
   */
  sqlStorageUpdateSettings?: SqlStorageUpdateSettings;

  /**
   * Additional SQL feature settings.
   */
  additionalFeaturesServerConfigurations?: AdditionalFeaturesServerConfigurations;

  /**
   * SQL Instance settings.
   */
  sqlInstanceSettings?: SQLInstanceSettings;

  /**
   * Azure AD authentication Settings.
   */
  azureAdAuthenticationSettings?: AADAuthenticationSettings;
}

/**
 * Set the access level and network port settings for SQL Server.
 */
model SqlConnectivityUpdateSettings {
  /**
   * SQL Server connectivity option.
   */
  connectivityType?: ConnectivityType;

  /**
   * SQL Server port.
   */
  port?: int32;

  /**
   * SQL Server sysadmin login to create.
   */
  @visibility(Lifecycle.Create)
  sqlAuthUpdateUserName?: string;

  /**
   * SQL Server sysadmin login password.
   */
  @visibility(Lifecycle.Create)
  sqlAuthUpdatePassword?: string;
}

/**
 * Set workload type to optimize storage for SQL Server.
 */
model SqlWorkloadTypeUpdateSettings {
  /**
   * SQL Server workload type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sqlWorkloadType?: SqlWorkloadType;
}

/**
 * Set disk storage settings for SQL Server.
 */
model SqlStorageUpdateSettings {
  /**
   * Virtual machine disk count.
   */
  diskCount?: int32;

  /**
   * Device id of the first disk to be updated.
   */
  startingDeviceId?: int32;

  /**
   * Disk configuration to apply to SQL Server.
   */
  diskConfigurationType?: DiskConfigurationType;
}

/**
 * Additional SQL Server feature settings.
 */
model AdditionalFeaturesServerConfigurations {
  /**
   * Enable or disable R services (SQL 2016 onwards).
   */
  isRServicesEnabled?: boolean;
}

/**
 * Set the server/instance-level settings for SQL Server.
 */
model SQLInstanceSettings {
  /**
   * SQL Server Collation.
   */
  collation?: string;

  /**
   * SQL Server MAXDOP.
   */
  maxDop?: int32;

  /**
   * SQL Server Optimize for Adhoc workloads.
   */
  isOptimizeForAdHocWorkloadsEnabled?: boolean;

  /**
   * SQL Server minimum memory.
   */
  minServerMemoryMB?: int32;

  /**
   * SQL Server maximum memory.
   */
  maxServerMemoryMB?: int32;

  /**
   * SQL Server LPIM.
   */
  isLpimEnabled?: boolean;

  /**
   * SQL Server IFI.
   */
  isIfiEnabled?: boolean;
}

/**
 * Enable AAD authentication for SQL VM.
 */
model AADAuthenticationSettings {
  /**
   * The client Id of the Managed Identity to query Microsoft Graph API. An empty string must be used for the system assigned Managed Identity
   */
  clientId?: string;
}

/**
 * Storage Configurations for SQL Data, Log and TempDb.
 */
model StorageConfigurationSettings {
  /**
   * SQL Server Data Storage Settings.
   */
  sqlDataSettings?: SQLStorageSettings;

  /**
   * SQL Server Log Storage Settings.
   */
  sqlLogSettings?: SQLStorageSettings;

  /**
   * SQL Server TempDb Storage Settings.
   */
  sqlTempDbSettings?: SQLTempDbSettings;

  /**
   * SQL Server SystemDb Storage on DataPool if true.
   */
  sqlSystemDbOnDataDisk?: boolean;

  /**
   * Disk configuration to apply to SQL Server.
   */
  diskConfigurationType?: DiskConfigurationType;

  /**
   * Storage workload type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageWorkloadType?: StorageWorkloadType;

  /**
   * Enable SQL IaaS Agent storage configuration blade in Azure Portal.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  enableStorageConfigBlade?: boolean;
}

/**
 * Set disk storage settings for SQL Server.
 */
model SQLStorageSettings {
  /**
   * Logical Unit Numbers for the disks.
   */
  luns?: int32[];

  /**
   * SQL Server default file path
   */
  defaultFilePath?: string;

  /**
   * Use storage pool to build a drive if true or not provided
   */
  useStoragePool?: boolean;
}

/**
 * Set tempDb storage settings for SQL Server.
 */
model SQLTempDbSettings {
  /**
   * SQL Server tempdb data file size
   */
  dataFileSize?: int32;

  /**
   * SQL Server tempdb data file autoGrowth size
   */
  dataGrowth?: int32;

  /**
   * SQL Server tempdb log file size
   */
  logFileSize?: int32;

  /**
   * SQL Server tempdb log file autoGrowth size
   */
  logGrowth?: int32;

  /**
   * SQL Server tempdb data file count
   */
  dataFileCount?: int32;

  /**
   * SQL Server tempdb persist folder choice
   */
  persistFolder?: boolean;

  /**
   * SQL Server tempdb persist folder location
   */
  persistFolderPath?: string;

  /**
   * Logical Unit Numbers for the disks.
   */
  luns?: int32[];

  /**
   * SQL Server default file path
   */
  defaultFilePath?: string;

  /**
   * Use storage pool to build a drive if true or not provided
   */
  useStoragePool?: boolean;
}

/**
 * Status of last troubleshooting operation on this SQL VM
 */
model TroubleshootingStatus {
  /**
   * Root cause of the issue
   */
  @visibility(Lifecycle.Read)
  rootCause?: string;

  /**
   * Last troubleshooting trigger time in UTC timezone
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastTriggerTimeUtc?: utcDateTime;

  /**
   * Start time in UTC timezone.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  /**
   * End time in UTC timezone.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  /**
   * SQL VM troubleshooting scenario.
   */
  @visibility(Lifecycle.Read)
  troubleshootingScenario?: TroubleshootingScenario;

  /**
   * Troubleshooting properties
   */
  @visibility(Lifecycle.Read)
  properties?: TroubleshootingAdditionalProperties;
}

/**
 * SQL VM Troubleshooting additional properties.
 */
model TroubleshootingAdditionalProperties {
  /**
   * The unhealthy replica information
   */
  unhealthyReplicaInfo?: UnhealthyReplicaInfo;
}

/**
 * SQL VM Troubleshoot UnhealthyReplica scenario information.
 */
model UnhealthyReplicaInfo {
  /**
   * The name of the availability group
   */
  availabilityGroupName?: string;
}

/**
 * Configure SQL best practices Assessment for databases in your SQL virtual machine.
 */
model AssessmentSettings {
  /**
   * Enable or disable SQL best practices Assessment feature on SQL virtual machine.
   */
  enable?: boolean;

  /**
   * Run SQL best practices Assessment immediately on SQL virtual machine.
   */
  runImmediately?: boolean;

  /**
   * Schedule for SQL best practices Assessment.
   */
  schedule?: Schedule;
}

/**
 * Set assessment schedule for SQL Server.
 */
model Schedule {
  /**
   * Enable or disable assessment schedule on SQL virtual machine.
   */
  enable?: boolean;

  /**
   * Number of weeks to schedule between 2 assessment runs. Takes value from 1-6
   */
  weeklyInterval?: int32;

  /**
   * Occurrence of the DayOfWeek day within a month to schedule assessment. Takes values: 1,2,3,4 and -1. Use -1 for last DayOfWeek day of the month
   */
  monthlyOccurrence?: int32;

  /**
   * Day of the week to run assessment.
   */
  dayOfWeek?: AssessmentDayOfWeek;

  /**
   * Time of the day in HH:mm format. Eg. 17:30
   */
  startTime?: string;
}

/**
 * Virtual Machine Identity details used for Sql IaaS extension configurations.
 */
model VirtualMachineIdentity {
  /**
   * Identity type of the virtual machine. Specify None to opt-out of Managed Identities.
   */
  type?: VmIdentityType;

  /**
   * ARM Resource Id of the identity. Only required when UserAssigned identity is selected.
   */
  resourceId?: Azure.Core.armResourceIdentifier;
}

/**
 * Configure disk config assessment for databases in your SQL virtual machine.
 */
model DiskConfigAssessmentRequest {
  /**
   * Boolean to run disk config Assessment. Use false to fetch past Assessment.
   */
  runDiskConfigRules?: boolean;
}

/**
 * An update to a SQL virtual machine.
 */
model SqlVirtualMachineUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Details required for SQL VM troubleshooting
 */
model SqlVmTroubleshooting {
  /**
   * Start time in UTC timezone.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  /**
   * End time in UTC timezone.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  /**
   * SQL VM troubleshooting scenario.
   */
  troubleshootingScenario?: TroubleshootingScenario;

  /**
   * Troubleshooting properties
   */
  properties?: TroubleshootingAdditionalProperties;

  /**
   * Virtual machine resource id for response.
   */
  @visibility(Lifecycle.Read)
  virtualMachineResourceId?: string;
}
