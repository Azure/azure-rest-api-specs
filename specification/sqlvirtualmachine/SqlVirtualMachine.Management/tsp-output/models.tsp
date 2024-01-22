import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.SqlVirtualMachine;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Replica Role in availability group.
 */
enum Role {
  PRIMARY,
  SECONDARY,
}

/**
 * Replica commit mode in availability group.
 */
enum Commit {
  SYNCHRONOUS_COMMIT,
  ASYNCHRONOUS_COMMIT,
}

/**
 * Replica failover mode in availability group.
 */
enum Failover {
  AUTOMATIC,
  MANUAL,
}

/**
 * Replica readable secondary mode in availability group.
 */
enum ReadableSecondary {
  NO,
  ALL,
  READ_ONLY,
}

/**
 * The intended executor of the operation.
 */
enum OperationOrigin {
  user,
  system,
}

/**
 * SQL image sku.
 */
enum SqlVmGroupImageSku {
  Developer,
  Enterprise,
}

/**
 * Scale type.
 */
enum ScaleType {
  HA,
}

/**
 * Type of cluster manager: Windows Server Failover Cluster (WSFC), implied by the scale type of the group and the OS type.
 */
enum ClusterManagerType {
  WSFC,
}

/**
 * Cluster type.
 */
enum ClusterConfiguration {
  Domainful,
}

/**
 * Cluster subnet type.
 */
enum ClusterSubnetType {
  SingleSubnet,
  MultiSubnet,
}

/**
 * The identity type. Set this to 'SystemAssigned' in order to automatically create and assign an Azure Active Directory principal for the resource.
 */
enum IdentityType {
  None,
  SystemAssigned,
}

/**
 * SQL Server license type.
 */
enum SqlServerLicenseType {
  PAYG,
  AHUB,
  DR,
}

/**
 * SQL Server Management type.
 */
enum SqlManagementMode {
  Full,
  LightWeight,
  NoAgent,
}

/**
 * SQL Server edition type.
 */
enum SqlImageSku {
  Developer,
  Express,
  Standard,
  Enterprise,
  Web,
}

/**
 * Backup schedule type.
 */
enum BackupScheduleType {
  Manual,
  Automated,
}

/**
 * Frequency of full backups. In both cases, full backups begin during the next scheduled time window.
 */
enum FullBackupFrequencyType {
  Daily,
  Weekly,
}

enum AutoBackupDaysOfWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

/**
 * SQL Server connectivity option.
 */
enum ConnectivityType {
  LOCAL,
  PRIVATE,
  PUBLIC,
}

/**
 * SQL Server workload type.
 */
enum SqlWorkloadType {
  GENERAL,
  OLTP,
  DW,
}

/**
 * Disk configuration to apply to SQL Server.
 */
enum DiskConfigurationType {
  NEW,
  EXTEND,
  ADD,
}

/**
 * Storage workload type.
 */
enum StorageWorkloadType {
  GENERAL,
  OLTP,
  DW,
}

/**
 * Day of week to apply the patch on.
 */
@fixed
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
@fixed
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
 * The properties of an availability group listener.
 */
model AvailabilityGroupListenerProperties {
  /**
   * Provisioning state to track the async operation status.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Name of the availability group.
   */
  availabilityGroupName?: string;

  /**
   * List of load balancer configurations for an availability group listener.
   */
  loadBalancerConfigurations?: LoadBalancerConfiguration[];

  /**
   * List of multi subnet IP configurations for an AG listener.
   */
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
  @visibility("read")
  id?: string;

  /**
   * Resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type.
   */
  @visibility("read")
  type?: string;
}

/**
 * The properties of a SQL virtual machine group.
 */
model SqlVirtualMachineGroupProperties {
  /**
   * Provisioning state to track the async operation status.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * SQL image offer. Examples may include SQL2016-WS2016, SQL2017-WS2016.
   */
  @visibility("read", "create")
  sqlImageOffer?: string;

  /**
   * SQL image sku.
   */
  @visibility("read", "create")
  sqlImageSku?: SqlVmGroupImageSku;

  /**
   * Scale type.
   */
  @visibility("read")
  scaleType?: ScaleType;

  /**
   * Type of cluster manager: Windows Server Failover Cluster (WSFC), implied by the scale type of the group and the OS type.
   */
  @visibility("read")
  clusterManagerType?: ClusterManagerType;

  /**
   * Cluster type.
   */
  @visibility("read")
  clusterConfiguration?: ClusterConfiguration;

  /**
   * Cluster Active Directory domain profile.
   */
  @visibility("read", "create")
  wsfcDomainProfile?: WsfcDomainProfile;
}

/**
 * Active Directory account details to operate Windows Server Failover Cluster.
 */
model WsfcDomainProfile {
  /**
   * Fully qualified name of the domain.
   */
  @visibility("read", "create")
  domainFqdn?: string;

  /**
   * Organizational Unit path in which the nodes and cluster will be present.
   */
  @visibility("read", "create")
  ouPath?: string;

  /**
   * Account name used for creating cluster (at minimum needs permissions to 'Create Computer Objects' in domain).
   */
  @visibility("read", "create")
  clusterBootstrapAccount?: string;

  /**
   * Account name used for operating cluster i.e. will be part of administrators group on all the participating virtual machines in the cluster.
   */
  @visibility("read", "update")
  clusterOperatorAccount?: string;

  /**
   * Account name under which SQL service will run on all participating SQL virtual machines in the cluster.
   */
  @visibility("read", "update")
  sqlServiceAccount?: string;

  /**
   * Optional path for fileshare witness.
   */
  @visibility("read", "create")
  fileShareWitnessPath?: string;

  /**
   * Fully qualified ARM resource id of the witness storage account.
   */
  @visibility("read", "create")
  storageAccountUrl?: string;

  /**
   * Primary key of the witness storage account.
   */
  @visibility("create")
  storageAccountPrimaryKey?: string;

  /**
   * Cluster subnet type.
   */
  @visibility("read", "create")
  clusterSubnetType?: ClusterSubnetType;
}

/**
 * An update to a SQL virtual machine group.
 */
model SqlVirtualMachineGroupUpdate {
  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * Azure Active Directory identity configuration for a resource.
 */
model ResourceIdentity {
  /**
   * The Azure Active Directory principal id.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The identity type. Set this to 'SystemAssigned' in order to automatically create and assign an Azure Active Directory principal for the resource.
   */
  type?: IdentityType;

  /**
   * The Azure Active Directory tenant id.
   */
  @visibility("read")
  tenantId?: string;
}

/**
 * The SQL virtual machine properties.
 */
model SqlVirtualMachineProperties {
  /**
   * ARM Resource id of underlying virtual machine created from SQL marketplace image.
   */
  @visibility("read", "create")
  virtualMachineResourceId?: string;

  /**
   * Provisioning state to track the async operation status.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * SQL image offer. Examples include SQL2016-WS2016, SQL2017-WS2016.
   */
  @visibility("read", "create")
  sqlImageOffer?: string;

  /**
   * SQL Server license type.
   */
  sqlServerLicenseType?: SqlServerLicenseType;

  /**
   * SQL Server Management type.
   */
  sqlManagement?: SqlManagementMode;

  /**
   * SQL Server edition type.
   */
  sqlImageSku?: SqlImageSku;

  /**
   * ARM resource id of the SQL virtual machine group this SQL virtual machine is or will be part of.
   */
  @visibility("read", "update")
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
   * Assessment Settings.
   */
  assessmentSettings?: AssessmentSettings;
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
  @projectedName("json", "enable")
  IsEnabled?: boolean;

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
}

/**
 * Configure backups for databases in your SQL virtual machine.
 */
model AutoBackupSettings {
  /**
   * Enable or disable autobackup on SQL virtual machine.
   */
  @projectedName("json", "enable")
  IsEnabled?: boolean;

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
  @visibility("create", "update")
  storageAccessKey?: string;

  /**
   * Password for encryption on backup.
   */
  @visibility("create", "update")
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
  @projectedName("json", "enable")
  IsEnabled?: boolean;

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
  @visibility("create", "update")
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
  @visibility("create")
  sqlAuthUpdateUserName?: string;

  /**
   * SQL Server sysadmin login password.
   */
  @visibility("create")
  sqlAuthUpdatePassword?: string;
}

/**
 * Set workload type to optimize storage for SQL Server.
 */
model SqlWorkloadTypeUpdateSettings {
  /**
   * SQL Server workload type.
   */
  @visibility("read", "create")
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
  @visibility("read", "create")
  storageWorkloadType?: StorageWorkloadType;
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
}

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
}

/**
 * Configure assessment for databases in your SQL virtual machine.
 */
model AssessmentSettings {
  /**
   * Enable or disable assessment feature on SQL virtual machine.
   */
  @projectedName("json", "enable")
  IsEnabled?: boolean;

  /**
   * Run assessment immediately on SQL virtual machine.
   */
  runImmediately?: boolean;

  /**
   * Schedule for Assessment.
   */
  schedule?: Schedule;
}

model Schedule {
  /**
   * Enable or disable assessment schedule on SQL virtual machine.
   */
  @projectedName("json", "enable")
  IsEnabled?: boolean;

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
 * An update to a SQL virtual machine.
 */
model SqlVirtualMachineUpdate {
  /**
   * Resource tags.
   */
  tags?: Record<string>;
}
