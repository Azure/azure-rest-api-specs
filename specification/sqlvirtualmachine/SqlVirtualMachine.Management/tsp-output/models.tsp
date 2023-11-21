import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace SqlVirtualMachineManagementClient;

enum Role {
  PRIMARY,
  SECONDARY,
}

enum Commit {
  SYNCHRONOUS_COMMIT,
  ASYNCHRONOUS_COMMIT,
}

enum Failover {
  AUTOMATIC,
  MANUAL,
}

enum ReadableSecondary {
  NO,
  ALL,
  READ_ONLY,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum OperationOrigin {
  user,
  system,
}

enum SqlVmGroupImageSku {
  Developer,
  Enterprise,
}

enum ScaleType {
  HA,
}

enum ClusterManagerType {
  WSFC,
}

enum ClusterConfiguration {
  Domainful,
}

enum ClusterSubnetType {
  SingleSubnet,
  MultiSubnet,
}

enum IdentityType {
  None,
  SystemAssigned,
}

enum SqlServerLicenseType {
  PAYG,
  AHUB,
  DR,
}

enum SqlManagementMode {
  Full,
  LightWeight,
  NoAgent,
}

enum SqlImageSku {
  Developer,
  Express,
  Standard,
  Enterprise,
  Web,
}

enum BackupScheduleType {
  Manual,
  Automated,
}

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

enum ConnectivityType {
  LOCAL,
  PRIVATE,
  PUBLIC,
}

enum SqlWorkloadType {
  GENERAL,
  OLTP,
  DW,
}

enum DiskConfigurationType {
  NEW,
  EXTEND,
  ADD,
}

enum StorageWorkloadType {
  GENERAL,
  OLTP,
  DW,
}
@Azure.Core.fixed
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
@Azure.Core.fixed
enum AssessmentDayOfWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

@doc("A SQL Server availability group listener.")
model AvailabilityGroupListener {
  ...ProxyResource;

  @doc("Resource properties.")
  properties?: AvailabilityGroupListenerProperties;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The properties of an availability group listener.")
model AvailabilityGroupListenerProperties {
  @doc("Provisioning state to track the async operation status.")
  @visibility("read")
  provisioningState?: string;

  @doc("Name of the availability group.")
  availabilityGroupName?: string;

  @doc("List of load balancer configurations for an availability group listener.")
  loadBalancerConfigurations?: LoadBalancerConfiguration[];

  @doc("List of multi subnet IP configurations for an AG listener.")
  multiSubnetIpConfigurations?: MultiSubnetIpConfiguration[];

  @doc("Create a default availability group if it does not exist.")
  createDefaultAvailabilityGroupIfNotExist?: boolean;

  @doc("Listener port.")
  port?: int32;

  @doc("Availability Group configuration.")
  availabilityGroupConfiguration?: AgConfiguration;
}

@doc("A load balancer configuration for an availability group listener.")
model LoadBalancerConfiguration {
  @doc("Private IP address.")
  privateIpAddress?: PrivateIPAddress;

  @doc("Resource id of the public IP.")
  publicIpAddressResourceId?: string;

  @doc("Resource id of the load balancer.")
  loadBalancerResourceId?: string;

  @doc("Probe port.")
  probePort?: int32;

  @doc("""
List of the SQL virtual machine instance resource id's that are enrolled into
the availability group listener.
""")
  sqlVirtualMachineInstances?: string[];
}

@doc("A private IP address bound to the availability group listener.")
model PrivateIPAddress {
  @doc("Private IP address bound to the availability group listener.")
  ipAddress?: string;

  @doc("Subnet used to include private IP.")
  subnetResourceId?: string;
}

@doc("Multi subnet ip configuration for an availability group listener.")
model MultiSubnetIpConfiguration {
  @doc("Private IP address.")
  privateIpAddress: PrivateIPAddress;

  @doc("""
SQL virtual machine instance resource id that are enrolled into the
availability group listener.
""")
  sqlVirtualMachineInstance: string;
}

@doc("Availability group configuration.")
model AgConfiguration {
  @doc("Replica configurations.")
  replicas?: AgReplica[];
}

@doc("Availability group replica configuration.")
model AgReplica {
  @doc("Sql VirtualMachine Instance Id.")
  sqlVirtualMachineInstanceId?: string;

  @doc("Replica Role in availability group.")
  role?: Role;

  @doc("Replica commit mode in availability group.")
  commit?: Commit;

  @doc("Replica failover mode in availability group.")
  failover?: Failover;

  @doc("Replica readable secondary mode in availability group.")
  readableSecondary?: ReadableSecondary;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @doc("The identity that created the resource.")
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  createdByType?: CreatedByType;

  @doc("The timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  lastModifiedByType?: CreatedByType;

  @doc("The timestamp of resource last modification (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("ARM proxy resource.")
model ProxyResource {
  ...Resource;
}

@doc("ARM resource.")
model Resource {
  @doc("Resource ID.")
  @visibility("read")
  id?: string;

  @doc("Resource name.")
  @visibility("read")
  name?: string;

  @doc("Resource type.")
  @visibility("read")
  type?: string;
}

@doc("A list of availability group listeners.")
model AvailabilityGroupListenerListResult
  is Azure.Core.Page<AvailabilityGroupListener>;

@doc("Result of the request to list SQL operations.")
model OperationListResult is Azure.Core.Page<Operation>;

@doc("SQL REST API operation definition.")
model Operation {
  @doc("The name of the operation being performed on this particular object.")
  @visibility("read")
  name?: string;

  @doc("The localized display information for this particular operation / action.")
  @visibility("read")
  display?: OperationDisplay;

  @doc("The intended executor of the operation.")
  @visibility("read")
  origin?: OperationOrigin;

  @doc("Additional descriptions for the operation.")
  @visibility("read")
  properties?: Record<unknown>;
}

@doc("Display metadata associated with the operation.")
model OperationDisplay {
  @doc("The localized friendly form of the resource provider name.")
  @visibility("read")
  provider?: string;

  @doc("""
The localized friendly form of the resource type related to this
action/operation.
""")
  @visibility("read")
  resource?: string;

  @doc("The localized friendly name for the operation.")
  @visibility("read")
  operation?: string;

  @doc("The localized friendly description for the operation.")
  @visibility("read")
  description?: string;
}

@doc("A SQL virtual machine group.")
model SqlVirtualMachineGroup {
  ...TrackedResource;

  @doc("Resource properties.")
  properties?: SqlVirtualMachineGroupProperties;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The properties of a SQL virtual machine group.")
model SqlVirtualMachineGroupProperties {
  @doc("Provisioning state to track the async operation status.")
  @visibility("read")
  provisioningState?: string;

  @doc("SQL image offer. Examples may include SQL2016-WS2016, SQL2017-WS2016.")
  sqlImageOffer?: string;

  @doc("SQL image sku.")
  sqlImageSku?: SqlVmGroupImageSku;

  @doc("Scale type.")
  @visibility("read")
  scaleType?: ScaleType;

  @doc("""
Type of cluster manager: Windows Server Failover Cluster (WSFC), implied by the
scale type of the group and the OS type.
""")
  @visibility("read")
  clusterManagerType?: ClusterManagerType;

  @doc("Cluster type.")
  @visibility("read")
  clusterConfiguration?: ClusterConfiguration;

  @doc("Cluster Active Directory domain profile.")
  wsfcDomainProfile?: WsfcDomainProfile;
}

@doc("Active Directory account details to operate Windows Server Failover Cluster.")
model WsfcDomainProfile {
  @doc("Fully qualified name of the domain.")
  domainFqdn?: string;

  @doc("Organizational Unit path in which the nodes and cluster will be present.")
  ouPath?: string;

  @doc("""
Account name used for creating cluster (at minimum needs permissions to 'Create
Computer Objects' in domain).
""")
  clusterBootstrapAccount?: string;

  @doc("""
Account name used for operating cluster i.e. will be part of administrators
group on all the participating virtual machines in the cluster.
""")
  clusterOperatorAccount?: string;

  @doc("""
Account name under which SQL service will run on all participating SQL virtual
machines in the cluster.
""")
  sqlServiceAccount?: string;

  @doc("Optional path for fileshare witness.")
  fileShareWitnessPath?: string;

  @doc("Fully qualified ARM resource id of the witness storage account.")
  storageAccountUrl?: string;

  @doc("Primary key of the witness storage account.")
  storageAccountPrimaryKey?: string;

  @doc("Cluster subnet type.")
  clusterSubnetType?: ClusterSubnetType;
}

@doc("ARM tracked top level resource.")
model TrackedResource {
  ...Resource;

  @doc("Resource location.")
  location: string;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("An update to a SQL virtual machine group.")
model SqlVirtualMachineGroupUpdate {
  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("A list of SQL virtual machine groups.")
model SqlVirtualMachineGroupListResult
  is Azure.Core.Page<SqlVirtualMachineGroup>;

@doc("A list of SQL virtual machines.")
model SqlVirtualMachineListResult is Azure.Core.Page<SqlVirtualMachine>;

@doc("A SQL virtual machine.")
model SqlVirtualMachine {
  ...TrackedResource;

  @doc("Azure Active Directory identity of the server.")
  identity?: ResourceIdentity;

  @doc("Resource properties.")
  properties?: SqlVirtualMachineProperties;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Azure Active Directory identity configuration for a resource.")
model ResourceIdentity {
  @doc("The Azure Active Directory principal id.")
  @visibility("read")
  principalId?: string;

  @doc("""
The identity type. Set this to 'SystemAssigned' in order to automatically
create and assign an Azure Active Directory principal for the resource.
""")
  type?: IdentityType;

  @doc("The Azure Active Directory tenant id.")
  @visibility("read")
  tenantId?: string;
}

@doc("The SQL virtual machine properties.")
model SqlVirtualMachineProperties {
  @doc("""
ARM Resource id of underlying virtual machine created from SQL marketplace
image.
""")
  virtualMachineResourceId?: string;

  @doc("Provisioning state to track the async operation status.")
  @visibility("read")
  provisioningState?: string;

  @doc("SQL image offer. Examples include SQL2016-WS2016, SQL2017-WS2016.")
  sqlImageOffer?: string;

  @doc("SQL Server license type.")
  sqlServerLicenseType?: SqlServerLicenseType;

  @doc("SQL Server Management type.")
  sqlManagement?: SqlManagementMode;

  @doc("SQL Server edition type.")
  sqlImageSku?: SqlImageSku;

  @doc("""
ARM resource id of the SQL virtual machine group this SQL virtual machine is or
will be part of.
""")
  sqlVirtualMachineGroupResourceId?: string;

  @doc("""
Domain credentials for setting up Windows Server Failover Cluster for SQL
availability group.
""")
  wsfcDomainCredentials?: WsfcDomainCredentials;

  @doc("""
Domain credentials for setting up Windows Server Failover Cluster for SQL
availability group.
""")
  wsfcStaticIp?: string;

  @doc("""
Auto patching settings for applying critical security updates to SQL virtual
machine.
""")
  autoPatchingSettings?: AutoPatchingSettings;

  @doc("Auto backup settings for SQL Server.")
  autoBackupSettings?: AutoBackupSettings;

  @doc("Key vault credential settings.")
  keyVaultCredentialSettings?: KeyVaultCredentialSettings;

  @doc("SQL Server configuration management settings.")
  serverConfigurationsManagementSettings?: ServerConfigurationsManagementSettings;

  @doc("Storage Configuration Settings.")
  storageConfigurationSettings?: StorageConfigurationSettings;

  @doc("Assessment Settings.")
  assessmentSettings?: AssessmentSettings;
}

@doc("""
Domain credentials for setting up Windows Server Failover Cluster for SQL
availability group.
""")
model WsfcDomainCredentials {
  @doc("Cluster bootstrap account password.")
  clusterBootstrapAccountPassword?: string;

  @doc("Cluster operator account password.")
  clusterOperatorAccountPassword?: string;

  @doc("SQL service account password.")
  sqlServiceAccountPassword?: string;
}

@doc("Set a patching window during which Windows and SQL patches will be applied.")
model AutoPatchingSettings {
  @doc("Enable or disable autopatching on SQL virtual machine.")
  enable?: boolean;

  @doc("Day of week to apply the patch on.")
  dayOfWeek?: DayOfWeek;

  @doc("Hour of the day when patching is initiated. Local VM time.")
  maintenanceWindowStartingHour?: int32;

  @doc("Duration of patching.")
  maintenanceWindowDuration?: int32;
}

@doc("Configure backups for databases in your SQL virtual machine.")
model AutoBackupSettings {
  @doc("Enable or disable autobackup on SQL virtual machine.")
  enable?: boolean;

  @doc("Enable or disable encryption for backup on SQL virtual machine.")
  enableEncryption?: boolean;

  @doc("Retention period of backup: 1-90 days.")
  retentionPeriod?: int32;

  @doc("Storage account url where backup will be taken to.")
  storageAccountUrl?: string;

  @doc("Storage container name where backup will be taken to.")
  storageContainerName?: string;

  @doc("Storage account key where backup will be taken to.")
  storageAccessKey?: string;

  @doc("Password for encryption on backup.")
  password?: string;

  @doc("Include or exclude system databases from auto backup.")
  backupSystemDbs?: boolean;

  @doc("Backup schedule type.")
  backupScheduleType?: BackupScheduleType;

  @doc("""
Frequency of full backups. In both cases, full backups begin during the next
scheduled time window.
""")
  fullBackupFrequency?: FullBackupFrequencyType;

  @doc("Days of the week for the backups when FullBackupFrequency is set to Weekly.")
  daysOfWeek?: AutoBackupDaysOfWeek[];

  @doc("Start time of a given day during which full backups can take place. 0-23 hours.")
  fullBackupStartTime?: int32;

  @doc("""
Duration of the time window of a given day during which full backups can take
place. 1-23 hours.
""")
  fullBackupWindowHours?: int32;

  @doc("Frequency of log backups. 5-60 minutes.")
  logBackupFrequency?: int32;
}

@doc("""
Configure your SQL virtual machine to be able to connect to the Azure Key Vault
service.
""")
model KeyVaultCredentialSettings {
  @doc("Enable or disable key vault credential setting.")
  enable?: boolean;

  @doc("Credential name.")
  credentialName?: string;

  @doc("Azure Key Vault url.")
  azureKeyVaultUrl?: string;

  @doc("Service principal name to access key vault.")
  servicePrincipalName?: string;

  @doc("Service principal name secret to access key vault.")
  servicePrincipalSecret?: string;
}

@doc("Set the connectivity, storage and workload settings.")
model ServerConfigurationsManagementSettings {
  @doc("SQL connectivity type settings.")
  sqlConnectivityUpdateSettings?: SqlConnectivityUpdateSettings;

  @doc("SQL workload type settings.")
  sqlWorkloadTypeUpdateSettings?: SqlWorkloadTypeUpdateSettings;

  @doc("SQL storage update settings.")
  sqlStorageUpdateSettings?: SqlStorageUpdateSettings;

  @doc("Additional SQL feature settings.")
  additionalFeaturesServerConfigurations?: AdditionalFeaturesServerConfigurations;

  @doc("SQL Instance settings.")
  sqlInstanceSettings?: SQLInstanceSettings;
}

@doc("Set the access level and network port settings for SQL Server.")
model SqlConnectivityUpdateSettings {
  @doc("SQL Server connectivity option.")
  connectivityType?: ConnectivityType;

  @doc("SQL Server port.")
  port?: int32;

  @doc("SQL Server sysadmin login to create.")
  sqlAuthUpdateUserName?: string;

  @doc("SQL Server sysadmin login password.")
  sqlAuthUpdatePassword?: string;
}

@doc("Set workload type to optimize storage for SQL Server.")
model SqlWorkloadTypeUpdateSettings {
  @doc("SQL Server workload type.")
  sqlWorkloadType?: SqlWorkloadType;
}

@doc("Set disk storage settings for SQL Server.")
model SqlStorageUpdateSettings {
  @doc("Virtual machine disk count.")
  diskCount?: int32;

  @doc("Device id of the first disk to be updated.")
  startingDeviceId?: int32;

  @doc("Disk configuration to apply to SQL Server.")
  diskConfigurationType?: DiskConfigurationType;
}

@doc("Additional SQL Server feature settings.")
model AdditionalFeaturesServerConfigurations {
  @doc("Enable or disable R services (SQL 2016 onwards).")
  isRServicesEnabled?: boolean;
}

@doc("Set the server/instance-level settings for SQL Server.")
model SQLInstanceSettings {
  @doc("SQL Server Collation.")
  collation?: string;

  @doc("SQL Server MAXDOP.")
  maxDop?: int32;

  @doc("SQL Server Optimize for Adhoc workloads.")
  isOptimizeForAdHocWorkloadsEnabled?: boolean;

  @doc("SQL Server minimum memory.")
  minServerMemoryMB?: int32;

  @doc("SQL Server maximum memory.")
  maxServerMemoryMB?: int32;

  @doc("SQL Server LPIM.")
  isLpimEnabled?: boolean;

  @doc("SQL Server IFI.")
  isIfiEnabled?: boolean;
}

@doc("Storage Configurations for SQL Data, Log and TempDb.")
model StorageConfigurationSettings {
  @doc("SQL Server Data Storage Settings.")
  sqlDataSettings?: SQLStorageSettings;

  @doc("SQL Server Log Storage Settings.")
  sqlLogSettings?: SQLStorageSettings;

  @doc("SQL Server TempDb Storage Settings.")
  sqlTempDbSettings?: SQLTempDbSettings;

  @doc("SQL Server SystemDb Storage on DataPool if true.")
  sqlSystemDbOnDataDisk?: boolean;

  @doc("Disk configuration to apply to SQL Server.")
  diskConfigurationType?: DiskConfigurationType;

  @doc("Storage workload type.")
  storageWorkloadType?: StorageWorkloadType;
}

@doc("Set disk storage settings for SQL Server.")
model SQLStorageSettings {
  @doc("Logical Unit Numbers for the disks.")
  luns?: int32[];

  @doc("SQL Server default file path")
  defaultFilePath?: string;
}

model SQLTempDbSettings {
  @doc("SQL Server tempdb data file size")
  dataFileSize?: int32;

  @doc("SQL Server tempdb data file autoGrowth size")
  dataGrowth?: int32;

  @doc("SQL Server tempdb log file size")
  logFileSize?: int32;

  @doc("SQL Server tempdb log file autoGrowth size")
  logGrowth?: int32;

  @doc("SQL Server tempdb data file count")
  dataFileCount?: int32;

  @doc("SQL Server tempdb persist folder choice")
  persistFolder?: boolean;

  @doc("SQL Server tempdb persist folder location")
  persistFolderPath?: string;

  @doc("Logical Unit Numbers for the disks.")
  luns?: int32[];

  @doc("SQL Server default file path")
  defaultFilePath?: string;
}

@doc("Configure assessment for databases in your SQL virtual machine.")
model AssessmentSettings {
  @doc("Enable or disable assessment feature on SQL virtual machine.")
  enable?: boolean;

  @doc("Run assessment immediately on SQL virtual machine.")
  runImmediately?: boolean;

  @doc("Schedule for Assessment.")
  schedule?: Schedule;
}

model Schedule {
  @doc("Enable or disable assessment schedule on SQL virtual machine.")
  enable?: boolean;

  @doc("Number of weeks to schedule between 2 assessment runs. Takes value from 1-6")
  weeklyInterval?: int32;

  @doc("""
Occurrence of the DayOfWeek day within a month to schedule assessment. Takes
values: 1,2,3,4 and -1. Use -1 for last DayOfWeek day of the month
""")
  monthlyOccurrence?: int32;

  @doc("Day of the week to run assessment.")
  dayOfWeek?: AssessmentDayOfWeek;

  @doc("Time of the day in HH:mm format. Eg. 17:30")
  startTime?: string;
}

@doc("An update to a SQL virtual machine.")
model SqlVirtualMachineUpdate {
  @doc("Resource tags.")
  tags?: Record<string>;
}
