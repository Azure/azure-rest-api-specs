import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.Foundations;

namespace Microsoft.MachineLearningServices;

/**
 * The current deployment state of workspace resource. The provisioningState is to indicate states for resource provisioning.
 */
union ProvisioningState {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * Indicates whether or not the encryption is enabled for the workspace.
 */
union EncryptionStatus {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Whether requests from Public Network are allowed.
 */
union PublicNetworkAccess {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * The private endpoint connection status.
 */
union PrivateEndpointServiceConnectionStatus {
  string,

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Approved
   */
  Approved: "Approved",

  /**
   * Rejected
   */
  Rejected: "Rejected",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",

  /**
   * Timeout
   */
  Timeout: "Timeout",
}

/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union PrivateEndpointConnectionProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Failed
   */
  Failed: "Failed",
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
 * Level of workspace setup error
 */
union DiagnoseResultLevel {
  string,

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Error
   */
  Error: "Error",

  /**
   * Information
   */
  Information: "Information",
}

/**
 * An enum describing the unit of usage measurement.
 */
union UsageUnit {
  string,

  /**
   * Count
   */
  Count: "Count",
}

/**
 * Three lettered code specifying the currency of the VM price. Example: USD
 */
union BillingCurrency {
  string,

  /**
   * USD
   */
  USD: "USD",
}

/**
 * The unit of time measurement for the specified VM price. Example: OneHour
 */
union UnitOfMeasure {
  string,

  /**
   * OneHour
   */
  OneHour: "OneHour",
}

/**
 * Operating system type used by the VM.
 */
union VMPriceOSType {
  string,

  /**
   * Linux
   */
  Linux: "Linux",

  /**
   * Windows
   */
  Windows: "Windows",
}

/**
 * The type of the VM.
 */
union VMTier {
  string,

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * LowPriority
   */
  LowPriority: "LowPriority",

  /**
   * Spot
   */
  Spot: "Spot",
}

/**
 * An enum describing the unit of quota measurement.
 */
union QuotaUnit {
  string,

  /**
   * Count
   */
  Count: "Count",
}

/**
 * Status of update workspace quota.
 */
union Status {
  string,

  /**
   * Undefined
   */
  Undefined: "Undefined",

  /**
   * Success
   */
  Success: "Success",

  /**
   * Failure
   */
  Failure: "Failure",

  /**
   * InvalidQuotaBelowClusterMinimum
   */
  InvalidQuotaBelowClusterMinimum: "InvalidQuotaBelowClusterMinimum",

  /**
   * InvalidQuotaExceedsSubscriptionLimit
   */
  InvalidQuotaExceedsSubscriptionLimit: "InvalidQuotaExceedsSubscriptionLimit",

  /**
   * InvalidVMFamilyName
   */
  InvalidVMFamilyName: "InvalidVMFamilyName",

  /**
   * OperationNotSupportedForSku
   */
  OperationNotSupportedForSku: "OperationNotSupportedForSku",

  /**
   * OperationNotEnabledForRegion
   */
  OperationNotEnabledForRegion: "OperationNotEnabledForRegion",
}

/**
 * The type of compute
 */
union ComputeType {
  string,

  /**
   * AKS
   */
  AKS: "AKS",

  /**
   * Kubernetes
   */
  Kubernetes: "Kubernetes",

  /**
   * AmlCompute
   */
  AmlCompute: "AmlCompute",

  /**
   * ComputeInstance
   */
  ComputeInstance: "ComputeInstance",

  /**
   * DataFactory
   */
  DataFactory: "DataFactory",

  /**
   * VirtualMachine
   */
  VirtualMachine: "VirtualMachine",

  /**
   * HDInsight
   */
  HDInsight: "HDInsight",

  /**
   * Databricks
   */
  Databricks: "Databricks",

  /**
   * DataLakeAnalytics
   */
  DataLakeAnalytics: "DataLakeAnalytics",

  /**
   * SynapseSpark
   */
  SynapseSpark: "SynapseSpark",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union UnderlyingResourceAction {
  string,

  /**
   * Delete
   */
  Delete: "Delete",

  /**
   * Detach
   */
  Detach: "Detach",
}

/**
 * State of the compute node. Values are idle, running, preparing, unusable, leaving and preempted.
 */
union NodeState {
  string,

  /**
   * idle
   */
  idle: "idle",

  /**
   * running
   */
  running: "running",

  /**
   * preparing
   */
  preparing: "preparing",

  /**
   * unusable
   */
  unusable: "unusable",

  /**
   * leaving
   */
  leaving: "leaving",

  /**
   * preempted
   */
  preempted: "preempted",
}

/**
 * format for the workspace connection value
 */
union ValueFormat {
  string,

  /**
   * JSON
   */
  JSON: "JSON",
}

/**
 * State of endpoint provisioning.
 */
union EndpointProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * Enum to determine endpoint authentication mode.
 */
union EndpointAuthMode {
  string,

  /**
   * AMLToken
   */
  AMLToken: "AMLToken",

  /**
   * Key
   */
  Key: "Key",

  /**
   * AADToken
   */
  AADToken: "AADToken",
}

/**
 * Log verbosity for batch inferencing.
 * Increasing verbosity order for logging is : Warning, Info and Debug.
 * The default value is Info.
 */
union BatchLoggingLevel {
  string,

  /**
   * Info
   */
  Info: "Info",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Debug
   */
  Debug: "Debug",
}

/**
 * Enum to determine which reference method to use for an asset.
 */
union ReferenceType {
  string,

  /**
   * Id
   */
  Id: "Id",

  /**
   * DataPath
   */
  DataPath: "DataPath",

  /**
   * OutputPath
   */
  OutputPath: "OutputPath",
}

/**
 * Enum to determine how batch inferencing will handle output
 */
union BatchOutputAction {
  string,

  /**
   * SummaryOnly
   */
  SummaryOnly: "SummaryOnly",

  /**
   * AppendRow
   */
  AppendRow: "AppendRow",
}

/**
 * Possible values for DeploymentProvisioningState.
 */
union DeploymentProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Scaling
   */
  Scaling: "Scaling",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ListViewType {
  string,

  /**
   * ActiveOnly
   */
  ActiveOnly: "ActiveOnly",

  /**
   * ArchivedOnly
   */
  ArchivedOnly: "ArchivedOnly",

  /**
   * All
   */
  All: "All",
}

/**
 * Enum to determine the type of data.
 */
union DataType {
  string,

  /**
   * UriFile
   */
  UriFile: "UriFile",

  /**
   * UriFolder
   */
  UriFolder: "UriFolder",

  /**
   * MLTable
   */
  MLTable: "MLTable",
}

/**
 * Enum to determine the datastore credentials type.
 */
union CredentialsType {
  string,

  /**
   * AccountKey
   */
  AccountKey: "AccountKey",

  /**
   * Certificate
   */
  Certificate: "Certificate",

  /**
   * None
   */
  None: "None",

  /**
   * Sas
   */
  Sas: "Sas",

  /**
   * ServicePrincipal
   */
  ServicePrincipal: "ServicePrincipal",

  /**
   * KerberosKeytab
   */
  KerberosKeytab: "KerberosKeytab",

  /**
   * KerberosPassword
   */
  KerberosPassword: "KerberosPassword",
}

/**
 * Enum to determine the datastore contents type.
 */
union DatastoreType {
  string,

  /**
   * AzureBlob
   */
  AzureBlob: "AzureBlob",

  /**
   * AzureDataLakeGen1
   */
  AzureDataLakeGen1: "AzureDataLakeGen1",

  /**
   * AzureDataLakeGen2
   */
  AzureDataLakeGen2: "AzureDataLakeGen2",

  /**
   * AzureFile
   */
  AzureFile: "AzureFile",

  /**
   * Hdfs
   */
  Hdfs: "Hdfs",
}

/**
 * Enum to determine the datastore secrets type.
 */
union SecretsType {
  string,

  /**
   * AccountKey
   */
  AccountKey: "AccountKey",

  /**
   * Certificate
   */
  Certificate: "Certificate",

  /**
   * Sas
   */
  Sas: "Sas",

  /**
   * ServicePrincipal
   */
  ServicePrincipal: "ServicePrincipal",

  /**
   * KerberosPassword
   */
  KerberosPassword: "KerberosPassword",

  /**
   * KerberosKeytab
   */
  KerberosKeytab: "KerberosKeytab",
}

/**
 * Environment type is either user created or curated by Azure ML service
 */
union EnvironmentType {
  string,

  /**
   * Curated
   */
  Curated: "Curated",

  /**
   * UserCreated
   */
  UserCreated: "UserCreated",
}

/**
 * The type of operating system.
 */
union OperatingSystemType {
  string,

  /**
   * Linux
   */
  Linux: "Linux",

  /**
   * Windows
   */
  Windows: "Windows",
}

/**
 * Enum to determine identity framework.
 */
union IdentityConfigurationType {
  string,

  /**
   * Managed
   */
  Managed: "Managed",

  /**
   * AMLToken
   */
  AMLToken: "AMLToken",

  /**
   * UserIdentity
   */
  UserIdentity: "UserIdentity",
}

/**
 * Enum to determine the type of job.
 */
union JobType {
  string,

  /**
   * AutoML
   */
  AutoML: "AutoML",

  /**
   * Command
   */
  Command: "Command",

  /**
   * Sweep
   */
  Sweep: "Sweep",

  /**
   * Pipeline
   */
  Pipeline: "Pipeline",
}

/**
 * Enum to describe status of schedule
 */
union ScheduleStatus {
  string,

  /**
   * Schedule is enabled
   */
  Enabled: "Enabled",

  /**
   * Schedule is disabled
   */
  Disabled: "Disabled",
}

/**
 * Enum to describe type of schedule
 */
union ScheduleType {
  string,

  /**
   * Cron schedule type
   */
  Cron: "Cron",

  /**
   * Recurrence schedule type
   */
  Recurrence: "Recurrence",
}

/**
 * The status of a job.
 */
union JobStatus {
  string,

  /**
   * Run hasn't started yet.
   */
  NotStarted: "NotStarted",

  /**
   * Run has started. The user has a run ID.
   */
  Starting: "Starting",

  /**
   * (Not used currently) It will be used if ES is creating the compute target.
   */
  Provisioning: "Provisioning",

  /**
   * The run environment is being prepared.
   */
  Preparing: "Preparing",

  /**
   * The job is queued in the compute target. For example, in BatchAI the job is in queued state, while waiting for all required nodes to be ready.
   */
  Queued: "Queued",

  /**
   * The job started to run in the compute target.
   */
  Running: "Running",

  /**
   * Job is completed in the target. It is in output collection state now.
   */
  Finalizing: "Finalizing",

  /**
   * Cancellation has been requested for the job.
   */
  CancelRequested: "CancelRequested",

  /**
   * Job completed successfully. This reflects that both the job itself and output collection states completed successfully
   */
  Completed: "Completed",

  /**
   * Job failed.
   */
  Failed: "Failed",

  /**
   * Following cancellation request, the job is now successfully canceled.
   */
  Canceled: "Canceled",

  /**
   * When heartbeat is enabled, if the run isn't updating any information to RunHistory then the run goes to NotResponding state.
   * NotResponding is the only state that is exempt from strict transition orders. A run can go from NotResponding to any of the previous states.
   */
  NotResponding: "NotResponding",

  /**
   * The job is paused by users. Some adjustment to labeling jobs can be made only in paused state.
   */
  Paused: "Paused",

  /**
   * Default job status if not mapped to all other statuses
   */
  Unknown: "Unknown",

  /**
   * The job is in a scheduled state. Job is not in any active state.
   */
  Scheduled: "Scheduled",
}

/**
 * The async operation state.
 */
union ModelType {
  string,

  /**
   * CustomModel
   */
  CustomModel: "CustomModel",

  /**
   * MLFlowModel
   */
  MLFlowModel: "MLFlowModel",

  /**
   * TritonModel
   */
  TritonModel: "TritonModel",
}

/**
 * Enum to determine endpoint compute type.
 */
union EndpointComputeType {
  string,

  /**
   * Managed
   */
  Managed: "Managed",

  /**
   * Kubernetes
   */
  Kubernetes: "Kubernetes",

  /**
   * AzureMLCompute
   */
  AzureMLCompute: "AzureMLCompute",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union OrderString {
  string,

  /**
   * CreatedAtDesc
   */
  CreatedAtDesc: "CreatedAtDesc",

  /**
   * CreatedAtAsc
   */
  CreatedAtAsc: "CreatedAtAsc",

  /**
   * UpdatedAtDesc
   */
  UpdatedAtDesc: "UpdatedAtDesc",

  /**
   * UpdatedAtAsc
   */
  UpdatedAtAsc: "UpdatedAtAsc",
}

/**
 * Enum to determine whether PublicNetworkAccess is Enabled or Disabled.
 */
union PublicNetworkAccessType {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Enum to determine whether PublicNetworkAccess is Enabled or Disabled for egress of a deployment.
 */
union EgressPublicNetworkAccessType {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ScaleType {
  string,

  /**
   * Default
   */
  Default: "Default",

  /**
   * TargetUtilization
   */
  TargetUtilization: "TargetUtilization",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ContainerType {
  string,

  /**
   * StorageInitializer
   */
  StorageInitializer: "StorageInitializer",

  /**
   * InferenceServer
   */
  InferenceServer: "InferenceServer",
}

/**
 * Node scaling setting for the compute sku.
 */
union SkuScaleType {
  string,

  /**
   * Automatically scales node count.
   */
  Automatic: "Automatic",

  /**
   * Node count scaled upon user request.
   */
  Manual: "Manual",

  /**
   * Fixed set of nodes.
   */
  None: "None",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union KeyType {
  string,

  /**
   * Primary
   */
  Primary: "Primary",

  /**
   * Secondary
   */
  Secondary: "Secondary",
}

/**
 * Intended usage of the cluster
 */
union ClusterPurpose {
  string,

  /**
   * FastProd
   */
  FastProd: "FastProd",

  /**
   * DenseProd
   */
  DenseProd: "DenseProd",

  /**
   * DevTest
   */
  DevTest: "DevTest",
}

/**
 * Enable or disable ssl for scoring
 */
union SslConfigurationStatus {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Auto
   */
  Auto: "Auto",
}

/**
 * Load Balancer Type
 */
union LoadBalancerType {
  string,

  /**
   * PublicIp
   */
  PublicIp: "PublicIp",

  /**
   * InternalLoadBalancer
   */
  InternalLoadBalancer: "InternalLoadBalancer",
}

/**
 * Compute OS Type
 */
union OsType {
  string,

  /**
   * Linux
   */
  Linux: "Linux",

  /**
   * Windows
   */
  Windows: "Windows",
}

/**
 * Virtual Machine priority
 */
union VmPriority {
  string,

  /**
   * Dedicated
   */
  Dedicated: "Dedicated",

  /**
   * LowPriority
   */
  LowPriority: "LowPriority",
}

/**
 * State of the public SSH port. Possible values are: Disabled - Indicates that the public ssh port is closed on all nodes of the cluster. Enabled - Indicates that the public ssh port is open on all nodes of the cluster. NotSpecified - Indicates that the public ssh port is closed on all nodes of the cluster if VNet is defined, else is open all public nodes. It can be default only during cluster creation time, after creation it will be either enabled or disabled.
 */
union RemoteLoginPortPublicAccess {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",
}

/**
 * Allocation state of the compute. Possible values are: steady - Indicates that the compute is not resizing. There are no changes to the number of compute nodes in the compute in progress. A compute enters this state when it is created and when no operations are being performed on the compute to change the number of compute nodes. resizing - Indicates that the compute is resizing; that is, compute nodes are being added to or removed from the compute.
 */
union AllocationState {
  string,

  /**
   * Steady
   */
  Steady: "Steady",

  /**
   * Resizing
   */
  Resizing: "Resizing",
}

/**
 * Policy for sharing applications on this compute instance among users of parent workspace. If Personal, only the creator can access applications on this compute instance. When Shared, any workspace user can access applications on this instance depending on his/her assigned role.
 */
union ApplicationSharingPolicy {
  string,

  /**
   * Personal
   */
  Personal: "Personal",

  /**
   * Shared
   */
  Shared: "Shared",
}

/**
 * State of the public SSH port. Possible values are: Disabled - Indicates that the public ssh port is closed on this instance. Enabled - Indicates that the public ssh port is open and accessible according to the VNet/subnet policy if applicable.
 */
union SshPublicAccess {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Current state of an ComputeInstance.
 */
union ComputeInstanceState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * CreateFailed
   */
  CreateFailed: "CreateFailed",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Restarting
   */
  Restarting: "Restarting",

  /**
   * JobRunning
   */
  JobRunning: "JobRunning",

  /**
   * SettingUp
   */
  SettingUp: "SettingUp",

  /**
   * SetupFailed
   */
  SetupFailed: "SetupFailed",

  /**
   * Starting
   */
  Starting: "Starting",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Stopping
   */
  Stopping: "Stopping",

  /**
   * UserSettingUp
   */
  UserSettingUp: "UserSettingUp",

  /**
   * UserSetupFailed
   */
  UserSetupFailed: "UserSetupFailed",

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Unusable
   */
  Unusable: "Unusable",
}

/**
 * The Compute Instance Authorization type. Available values are personal (default).
 */
union ComputeInstanceAuthorizationType {
  string,

  /**
   * personal
   */
  personal: "personal",
}

/**
 * Name of the last operation.
 */
union OperationName {
  string,

  /**
   * Create
   */
  Create: "Create",

  /**
   * Start
   */
  Start: "Start",

  /**
   * Stop
   */
  Stop: "Stop",

  /**
   * Restart
   */
  Restart: "Restart",

  /**
   * Reimage
   */
  Reimage: "Reimage",

  /**
   * Delete
   */
  Delete: "Delete",
}

/**
 * Operation status.
 */
union OperationStatus {
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
   * CreateFailed
   */
  CreateFailed: "CreateFailed",

  /**
   * StartFailed
   */
  StartFailed: "StartFailed",

  /**
   * StopFailed
   */
  StopFailed: "StopFailed",

  /**
   * RestartFailed
   */
  RestartFailed: "RestartFailed",

  /**
   * ReimageFailed
   */
  ReimageFailed: "ReimageFailed",

  /**
   * DeleteFailed
   */
  DeleteFailed: "DeleteFailed",
}

/**
 * Trigger of operation.
 */
union OperationTrigger {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Schedule
   */
  Schedule: "Schedule",

  /**
   * IdleShutdown
   */
  IdleShutdown: "IdleShutdown",
}

/**
 * The current deployment state of schedule.
 */
union ProvisioningStatus {
  string,

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The compute power action.
 */
union ComputePowerAction {
  string,

  /**
   * Start
   */
  Start: "Start",

  /**
   * Stop
   */
  Stop: "Stop",
}

/**
 * Auto save settings.
 */
union Autosave {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Local
   */
  Local: "Local",

  /**
   * Remote
   */
  Remote: "Remote",
}

/**
 * network of this container.
 */
union Network {
  string,

  /**
   * Bridge
   */
  Bridge: "Bridge",

  /**
   * Host
   */
  Host: "Host",
}

/**
 * Caching type of Data Disk.
 */
union Caching {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * ReadOnly
   */
  ReadOnly: "ReadOnly",

  /**
   * ReadWrite
   */
  ReadWrite: "ReadWrite",
}

/**
 * type of this storage account.
 */
union StorageAccountType {
  string,

  /**
   * Standard_LRS
   */
  Standard_LRS: "Standard_LRS",

  /**
   * Premium_LRS
   */
  Premium_LRS: "Premium_LRS",
}

/**
 * Data source type.
 */
union SourceType {
  string,

  /**
   * Dataset
   */
  Dataset: "Dataset",

  /**
   * Datastore
   */
  Datastore: "Datastore",

  /**
   * URI
   */
  URI: "URI",
}

/**
 * Mount Action.
 */
union MountAction {
  string,

  /**
   * Mount
   */
  Mount: "Mount",

  /**
   * Unmount
   */
  Unmount: "Unmount",
}

/**
 * Mount state.
 */
union MountState {
  string,

  /**
   * MountRequested
   */
  MountRequested: "MountRequested",

  /**
   * Mounted
   */
  Mounted: "Mounted",

  /**
   * MountFailed
   */
  MountFailed: "MountFailed",

  /**
   * UnmountRequested
   */
  UnmountRequested: "UnmountRequested",

  /**
   * UnmountFailed
   */
  UnmountFailed: "UnmountFailed",

  /**
   * Unmounted
   */
  Unmounted: "Unmounted",
}

/**
 * Enum to determine the input data delivery mode.
 */
union InputDeliveryMode {
  string,

  /**
   * ReadOnlyMount
   */
  ReadOnlyMount: "ReadOnlyMount",

  /**
   * ReadWriteMount
   */
  ReadWriteMount: "ReadWriteMount",

  /**
   * Download
   */
  Download: "Download",

  /**
   * Direct
   */
  Direct: "Direct",

  /**
   * EvalMount
   */
  EvalMount: "EvalMount",

  /**
   * EvalDownload
   */
  EvalDownload: "EvalDownload",
}

/**
 * Output data delivery mode enums.
 */
union OutputDeliveryMode {
  string,

  /**
   * ReadWriteMount
   */
  ReadWriteMount: "ReadWriteMount",

  /**
   * Upload
   */
  Upload: "Upload",
}

/**
 * Enum to determine forecast horizon selection mode.
 */
union ForecastHorizonMode {
  string,

  /**
   * Forecast horizon to be determined automatically.
   */
  Auto: "Auto",

  /**
   * Use the custom forecast horizon.
   */
  Custom: "Custom",
}

/**
 * Enum to determine the Job Output Type.
 */
union JobOutputType {
  string,

  /**
   * UriFile
   */
  UriFile: "UriFile",

  /**
   * UriFolder
   */
  UriFolder: "UriFolder",

  /**
   * MLTable
   */
  MLTable: "MLTable",

  /**
   * CustomModel
   */
  CustomModel: "CustomModel",

  /**
   * MLFlowModel
   */
  MLFlowModel: "MLFlowModel",

  /**
   * TritonModel
   */
  TritonModel: "TritonModel",
}

/**
 * Enum for setting log verbosity.
 */
union LogVerbosity {
  string,

  /**
   * No logs emitted.
   */
  NotSet: "NotSet",

  /**
   * Debug and above log statements logged.
   */
  Debug: "Debug",

  /**
   * Info and above log statements logged.
   */
  Info: "Info",

  /**
   * Warning and above log statements logged.
   */
  Warning: "Warning",

  /**
   * Error and above log statements logged.
   */
  Error: "Error",

  /**
   * Only critical statements logged.
   */
  Critical: "Critical",
}

/**
 * AutoMLJob Task type.
 */
union TaskType {
  string,

  /**
   * Classification in machine learning and statistics is a supervised learning approach in which
   * the computer program learns from the data given to it and make new observations or classifications.
   */
  Classification: "Classification",

  /**
   * Regression means to predict the value using the input data. Regression models are used to predict a continuous value.
   */
  Regression: "Regression",

  /**
   * Forecasting is a special kind of regression task that deals with time-series data and creates forecasting model
   * that can be used to predict the near future values based on the inputs.
   */
  Forecasting: "Forecasting",

  /**
   * Image Classification. Multi-class image classification is used when an image is classified with only a single label
   * from a set of classes - e.g. each image is classified as either an image of a 'cat' or a 'dog' or a 'duck'.
   */
  ImageClassification: "ImageClassification",

  /**
   * Image Classification Multilabel. Multi-label image classification is used when an image could have one or more labels
   * from a set of labels - e.g. an image could be labeled with both 'cat' and 'dog'.
   */
  ImageClassificationMultilabel: "ImageClassificationMultilabel",

  /**
   * Image Object Detection. Object detection is used to identify objects in an image and locate each object with a
   * bounding box e.g. locate all dogs and cats in an image and draw a bounding box around each.
   */
  ImageObjectDetection: "ImageObjectDetection",

  /**
   * Image Instance Segmentation. Instance segmentation is used to identify objects in an image at the pixel level,
   * drawing a polygon around each object in the image.
   */
  ImageInstanceSegmentation: "ImageInstanceSegmentation",

  /**
   * Text classification (also known as text tagging or text categorization) is the process of sorting texts into categories.
   * Categories are mutually exclusive.
   */
  TextClassification: "TextClassification",

  /**
   * Multilabel classification task assigns each sample to a group (zero or more) of target labels.
   */
  TextClassificationMultilabel: "TextClassificationMultilabel",

  /**
   * Text Named Entity Recognition a.k.a. TextNER.
   * Named Entity Recognition (NER) is the ability to take free-form text and identify the occurrences of entities such as people, locations, organizations, and more.
   */
  TextNER: "TextNER",
}

/**
 * Determines how N-Cross validations value is determined.
 */
union NCrossValidationsMode {
  string,

  /**
   * Determine N-Cross validations value automatically. Supported only for 'Forecasting' AutoML task.
   */
  Auto: "Auto",

  /**
   * Use custom N-Cross validations value.
   */
  Custom: "Custom",
}

/**
 * Forecasting seasonality mode.
 */
union SeasonalityMode {
  string,

  /**
   * Seasonality to be determined automatically.
   */
  Auto: "Auto",

  /**
   * Use the custom seasonality value.
   */
  Custom: "Custom",
}

/**
 * Target lags selection modes.
 */
union TargetLagsMode {
  string,

  /**
   * Target lags to be determined automatically.
   */
  Auto: "Auto",

  /**
   * Use the custom target lags.
   */
  Custom: "Custom",
}

/**
 * Target rolling windows size mode.
 */
union TargetRollingWindowSizeMode {
  string,

  /**
   * Determine rolling windows size automatically.
   */
  Auto: "Auto",

  /**
   * Use the specified rolling window size.
   */
  Custom: "Custom",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ServiceDataAccessAuthIdentity {
  string,

  /**
   * Do not use any identity for service data access.
   */
  None: "None",

  /**
   * Use the system assigned managed identity of the Workspace to authenticate service data access.
   */
  WorkspaceSystemAssignedIdentity: "WorkspaceSystemAssignedIdentity",

  /**
   * Use the user assigned managed identity of the Workspace to authenticate service data access.
   */
  WorkspaceUserAssignedIdentity: "WorkspaceUserAssignedIdentity",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union EarlyTerminationPolicyType {
  string,

  /**
   * Bandit
   */
  Bandit: "Bandit",

  /**
   * MedianStopping
   */
  MedianStopping: "MedianStopping",

  /**
   * TruncationSelection
   */
  TruncationSelection: "TruncationSelection",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union SamplingAlgorithmType {
  string,

  /**
   * Grid
   */
  Grid: "Grid",

  /**
   * Random
   */
  Random: "Random",

  /**
   * Bayesian
   */
  Bayesian: "Bayesian",
}

/**
 * Enum for all classification models supported by AutoML.
 */
union ClassificationModels {
  string,

  /**
   * Logistic regression is a fundamental classification technique.
   * It belongs to the group of linear classifiers and is somewhat similar to polynomial and linear regression.
   * Logistic regression is fast and relatively uncomplicated, and it's convenient for you to interpret the results.
   * Although it's essentially a method for binary classification, it can also be applied to multiclass problems.
   */
  LogisticRegression: "LogisticRegression",

  /**
   * SGD: Stochastic gradient descent is an optimization algorithm often used in machine learning applications
   * to find the model parameters that correspond to the best fit between predicted and actual outputs.
   */
  SGD: "SGD",

  /**
   * The multinomial Naive Bayes classifier is suitable for classification with discrete features (e.g., word counts for text classification).
   * The multinomial distribution normally requires integer feature counts. However, in practice, fractional counts such as tf-idf may also work.
   */
  MultinomialNaiveBayes: "MultinomialNaiveBayes",

  /**
   * Naive Bayes classifier for multivariate Bernoulli models.
   */
  BernoulliNaiveBayes: "BernoulliNaiveBayes",

  /**
   * A support vector machine (SVM) is a supervised machine learning model that uses classification algorithms for two-group classification problems.
   * After giving an SVM model sets of labeled training data for each category, they're able to categorize new text.
   */
  SVM: "SVM",

  /**
   * A support vector machine (SVM) is a supervised machine learning model that uses classification algorithms for two-group classification problems.
   * After giving an SVM model sets of labeled training data for each category, they're able to categorize new text.
   * Linear SVM performs best when input data is linear, i.e., data can be easily classified by drawing the straight line between classified values on a plotted graph.
   */
  LinearSVM: "LinearSVM",

  /**
   * K-nearest neighbors (KNN) algorithm uses 'feature similarity' to predict the values of new datapoints
   * which further means that the new data point will be assigned a value based on how closely it matches the points in the training set.
   */
  KNN: "KNN",

  /**
   * Decision Trees are a non-parametric supervised learning method used for both classification and regression tasks.
   * The goal is to create a model that predicts the value of a target variable by learning simple decision rules inferred from the data features.
   */
  DecisionTree: "DecisionTree",

  /**
   * Random forest is a supervised learning algorithm.
   * The "forest" it builds, is an ensemble of decision trees, usually trained with the “bagging” method.
   * The general idea of the bagging method is that a combination of learning models increases the overall result.
   */
  RandomForest: "RandomForest",

  /**
   * Extreme Trees is an ensemble machine learning algorithm that combines the predictions from many decision trees. It is related to the widely used random forest algorithm.
   */
  ExtremeRandomTrees: "ExtremeRandomTrees",

  /**
   * LightGBM is a gradient boosting framework that uses tree based learning algorithms.
   */
  LightGBM: "LightGBM",

  /**
   * The technique of transiting week learners into a strong learner is called Boosting. The gradient boosting algorithm process works on this theory of execution.
   */
  GradientBoosting: "GradientBoosting",

  /**
   * XGBoost: Extreme Gradient Boosting Algorithm. This algorithm is used for structured data where target column values can be divided into distinct class values.
   */
  XGBoostClassifier: "XGBoostClassifier",
}

/**
 * Primary metrics for classification tasks.
 */
union ClassificationPrimaryMetrics {
  string,

  /**
   * AUC is the Area under the curve.
   * This metric represents arithmetic mean of the score for each class,
   * weighted by the number of true instances in each class.
   */
  AUCWeighted: "AUCWeighted",

  /**
   * Accuracy is the ratio of predictions that exactly match the true class labels.
   */
  Accuracy: "Accuracy",

  /**
   * Normalized macro recall is recall macro-averaged and normalized, so that random
   * performance has a score of 0, and perfect performance has a score of 1.
   */
  NormMacroRecall: "NormMacroRecall",

  /**
   * The arithmetic mean of the average precision score for each class, weighted by
   * the number of true instances in each class.
   */
  AveragePrecisionScoreWeighted: "AveragePrecisionScoreWeighted",

  /**
   * The arithmetic mean of precision for each class, weighted by number of true instances in each class.
   */
  PrecisionScoreWeighted: "PrecisionScoreWeighted",
}

/**
 * Enum to determine the Job Input Type.
 */
union JobInputType {
  string,

  /**
   * Literal
   */
  Literal: "Literal",

  /**
   * UriFile
   */
  UriFile: "UriFile",

  /**
   * UriFolder
   */
  UriFolder: "UriFolder",

  /**
   * MLTable
   */
  MLTable: "MLTable",

  /**
   * CustomModel
   */
  CustomModel: "CustomModel",

  /**
   * MLFlowModel
   */
  MLFlowModel: "MLFlowModel",

  /**
   * TritonModel
   */
  TritonModel: "TritonModel",
}

/**
 * Featurization mode - determines data featurization mode.
 */
union FeaturizationMode {
  string,

  /**
   * Auto mode, system performs featurization without any custom featurization inputs.
   */
  Auto: "Auto",

  /**
   * Custom featurization.
   */
  Custom: "Custom",

  /**
   * Featurization off. 'Forecasting' task cannot use this value.
   */
  Off: "Off",
}

/**
 * The meta-learner is a model trained on the output of the individual heterogeneous models.
 * Default meta-learners are LogisticRegression for classification tasks (or LogisticRegressionCV if cross-validation is enabled) and ElasticNet for regression/forecasting tasks (or ElasticNetCV if cross-validation is enabled).
 * This parameter can be one of the following strings: LogisticRegression, LogisticRegressionCV, LightGBMClassifier, ElasticNet, ElasticNetCV, LightGBMRegressor, or LinearRegression
 */
union StackMetaLearnerType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Default meta-learners are LogisticRegression for classification tasks.
   */
  LogisticRegression: "LogisticRegression",

  /**
   * Default meta-learners are LogisticRegression for classification task when CV is on.
   */
  LogisticRegressionCV: "LogisticRegressionCV",

  /**
   * LightGBMClassifier
   */
  LightGBMClassifier: "LightGBMClassifier",

  /**
   * Default meta-learners are LogisticRegression for regression task.
   */
  ElasticNet: "ElasticNet",

  /**
   * Default meta-learners are LogisticRegression for regression task when CV is on.
   */
  ElasticNetCV: "ElasticNetCV",

  /**
   * LightGBMRegressor
   */
  LightGBMRegressor: "LightGBMRegressor",

  /**
   * LinearRegression
   */
  LinearRegression: "LinearRegression",
}

/**
 * Enum to determine the job distribution type.
 */
union DistributionType {
  string,

  /**
   * PyTorch
   */
  PyTorch: "PyTorch",

  /**
   * TensorFlow
   */
  TensorFlow: "TensorFlow",

  /**
   * Mpi
   */
  Mpi: "Mpi",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union JobLimitsType {
  string,

  /**
   * Command
   */
  Command: "Command",

  /**
   * Sweep
   */
  Sweep: "Sweep",
}

/**
 * Enum for all forecasting models supported by AutoML.
 */
union ForecastingModels {
  string,

  /**
   * Auto-Autoregressive Integrated Moving Average (ARIMA) model uses time-series data and statistical analysis to interpret the data and make future predictions.
   * This model aims to explain data by using time series data on its past values and uses linear regression to make predictions.
   */
  AutoArima: "AutoArima",

  /**
   * Prophet is a procedure for forecasting time series data based on an additive model where non-linear trends are fit with yearly, weekly, and daily seasonality, plus holiday effects.
   * It works best with time series that have strong seasonal effects and several seasons of historical data. Prophet is robust to missing data and shifts in the trend, and typically handles outliers well.
   */
  Prophet: "Prophet",

  /**
   * The Naive forecasting model makes predictions by carrying forward the latest target value for each time-series in the training data.
   */
  Naive: "Naive",

  /**
   * The Seasonal Naive forecasting model makes predictions by carrying forward the latest season of target values for each time-series in the training data.
   */
  SeasonalNaive: "SeasonalNaive",

  /**
   * The Average forecasting model makes predictions by carrying forward the average of the target values for each time-series in the training data.
   */
  Average: "Average",

  /**
   * The Seasonal Average forecasting model makes predictions by carrying forward the average value of the latest season of data for each time-series in the training data.
   */
  SeasonalAverage: "SeasonalAverage",

  /**
   * Exponential smoothing is a time series forecasting method for univariate data that can be extended to support data with a systematic trend or seasonal component.
   */
  ExponentialSmoothing: "ExponentialSmoothing",

  /**
   * An Autoregressive Integrated Moving Average with Explanatory Variable (ARIMAX) model can be viewed as a multiple regression model with one or more autoregressive (AR) terms and/or one or more moving average (MA) terms.
   * This method is suitable for forecasting when data is stationary/non stationary, and multivariate with any type of data pattern, i.e., level/trend /seasonality/cyclicity.
   */
  Arimax: "Arimax",

  /**
   * TCNForecaster: Temporal Convolutional Networks Forecaster.
   */
  TCNForecaster: "TCNForecaster",

  /**
   * Elastic net is a popular type of regularized linear regression that combines two popular penalties, specifically the L1 and L2 penalty functions.
   */
  ElasticNet: "ElasticNet",

  /**
   * The technique of transiting week learners into a strong learner is called Boosting. The gradient boosting algorithm process works on this theory of execution.
   */
  GradientBoosting: "GradientBoosting",

  /**
   * Decision Trees are a non-parametric supervised learning method used for both classification and regression tasks.
   * The goal is to create a model that predicts the value of a target variable by learning simple decision rules inferred from the data features.
   */
  DecisionTree: "DecisionTree",

  /**
   * K-nearest neighbors (KNN) algorithm uses 'feature similarity' to predict the values of new datapoints
   * which further means that the new data point will be assigned a value based on how closely it matches the points in the training set.
   */
  KNN: "KNN",

  /**
   * Lasso model fit with Least Angle Regression a.k.a. Lars. It is a Linear Model trained with an L1 prior as regularizer.
   */
  LassoLars: "LassoLars",

  /**
   * SGD: Stochastic gradient descent is an optimization algorithm often used in machine learning applications
   * to find the model parameters that correspond to the best fit between predicted and actual outputs.
   * It's an inexact but powerful technique.
   */
  SGD: "SGD",

  /**
   * Random forest is a supervised learning algorithm.
   * The "forest" it builds, is an ensemble of decision trees, usually trained with the “bagging” method.
   * The general idea of the bagging method is that a combination of learning models increases the overall result.
   */
  RandomForest: "RandomForest",

  /**
   * Extreme Trees is an ensemble machine learning algorithm that combines the predictions from many decision trees. It is related to the widely used random forest algorithm.
   */
  ExtremeRandomTrees: "ExtremeRandomTrees",

  /**
   * LightGBM is a gradient boosting framework that uses tree based learning algorithms.
   */
  LightGBM: "LightGBM",

  /**
   * XGBoostRegressor: Extreme Gradient Boosting Regressor is a supervised machine learning model using ensemble of base learners.
   */
  XGBoostRegressor: "XGBoostRegressor",
}

/**
 * Flag for generating lags for the numeric features.
 */
union FeatureLags {
  string,

  /**
   * No feature lags generated.
   */
  None: "None",

  /**
   * System auto-generates feature lags.
   */
  Auto: "Auto",
}

/**
 * The parameter defining how if AutoML should handle short time series.
 */
union ShortSeriesHandlingConfiguration {
  string,

  /**
   * Represents no/null value.
   */
  None: "None",

  /**
   * Short series will be padded if there are no long series, otherwise short series will be dropped.
   */
  Auto: "Auto",

  /**
   * All the short series will be padded.
   */
  Pad: "Pad",

  /**
   * All the short series will be dropped.
   */
  Drop: "Drop",
}

/**
 * Target aggregate function.
 */
union TargetAggregationFunction {
  string,

  /**
   * Represent no value set.
   */
  None: "None",

  /**
   * Sum
   */
  Sum: "Sum",

  /**
   * Max
   */
  Max: "Max",

  /**
   * Min
   */
  Min: "Min",

  /**
   * Mean
   */
  Mean: "Mean",
}

/**
 * Configure STL Decomposition of the time-series target column.
 */
union UseStl {
  string,

  /**
   * No stl decomposition.
   */
  None: "None",

  /**
   * Season
   */
  Season: "Season",

  /**
   * SeasonTrend
   */
  SeasonTrend: "SeasonTrend",
}

/**
 * Primary metrics for Forecasting task.
 */
union ForecastingPrimaryMetrics {
  string,

  /**
   * The Spearman's rank coefficient of correlation is a non-parametric measure of rank correlation.
   */
  SpearmanCorrelation: "SpearmanCorrelation",

  /**
   * The Normalized Root Mean Squared Error (NRMSE) the RMSE facilitates the comparison between models with different scales.
   */
  NormalizedRootMeanSquaredError: "NormalizedRootMeanSquaredError",

  /**
   * The R2 score is one of the performance evaluation measures for forecasting-based machine learning models.
   */
  R2Score: "R2Score",

  /**
   * The Normalized Mean Absolute Error (NMAE) is a validation metric to compare the Mean Absolute Error (MAE) of (time) series with different scales.
   */
  NormalizedMeanAbsoluteError: "NormalizedMeanAbsoluteError",
}

/**
 * Learning rate scheduler enum.
 */
union LearningRateScheduler {
  string,

  /**
   * No learning rate scheduler selected.
   */
  None: "None",

  /**
   * Cosine Annealing With Warmup.
   */
  WarmupCosine: "WarmupCosine",

  /**
   * Step learning rate scheduler.
   */
  Step: "Step",
}

/**
 * Stochastic optimizer for image models.
 */
union StochasticOptimizer {
  string,

  /**
   * No optimizer selected.
   */
  None: "None",

  /**
   * Stochastic Gradient Descent optimizer.
   */
  Sgd: "Sgd",

  /**
   * Adam is algorithm the optimizes stochastic objective functions based on adaptive estimates of moments
   */
  Adam: "Adam",

  /**
   * AdamW is a variant of the optimizer Adam that has an improved implementation of weight decay.
   */
  Adamw: "Adamw",
}

/**
 * Primary metrics for classification multilabel tasks.
 */
union ClassificationMultilabelPrimaryMetrics {
  string,

  /**
   * AUC is the Area under the curve.
   * This metric represents arithmetic mean of the score for each class,
   * weighted by the number of true instances in each class.
   */
  AUCWeighted: "AUCWeighted",

  /**
   * Accuracy is the ratio of predictions that exactly match the true class labels.
   */
  Accuracy: "Accuracy",

  /**
   * Normalized macro recall is recall macro-averaged and normalized, so that random
   * performance has a score of 0, and perfect performance has a score of 1.
   */
  NormMacroRecall: "NormMacroRecall",

  /**
   * The arithmetic mean of the average precision score for each class, weighted by
   * the number of true instances in each class.
   */
  AveragePrecisionScoreWeighted: "AveragePrecisionScoreWeighted",

  /**
   * The arithmetic mean of precision for each class, weighted by number of true instances in each class.
   */
  PrecisionScoreWeighted: "PrecisionScoreWeighted",

  /**
   * Intersection Over Union. Intersection of predictions divided by union of predictions.
   */
  IOU: "IOU",
}

/**
 * Primary metrics for InstanceSegmentation tasks.
 */
union InstanceSegmentationPrimaryMetrics {
  string,

  /**
   * Mean Average Precision (MAP) is the average of AP (Average Precision).
   * AP is calculated for each class and averaged to get the MAP.
   */
  MeanAveragePrecision: "MeanAveragePrecision",
}

/**
 * Image model size.
 */
union ModelSize {
  string,

  /**
   * No value selected.
   */
  None: "None",

  /**
   * Small size.
   */
  Small: "Small",

  /**
   * Medium size.
   */
  Medium: "Medium",

  /**
   * Large size.
   */
  Large: "Large",

  /**
   * Extra large size.
   */
  ExtraLarge: "ExtraLarge",
}

/**
 * Metric computation method to use for validation metrics in image tasks.
 */
union ValidationMetricType {
  string,

  /**
   * No metric.
   */
  None: "None",

  /**
   * Coco metric.
   */
  Coco: "Coco",

  /**
   * Voc metric.
   */
  Voc: "Voc",

  /**
   * CocoVoc metric.
   */
  CocoVoc: "CocoVoc",
}

/**
 * Primary metrics for Image ObjectDetection task.
 */
union ObjectDetectionPrimaryMetrics {
  string,

  /**
   * Mean Average Precision (MAP) is the average of AP (Average Precision).
   * AP is calculated for each class and averaged to get the MAP.
   */
  MeanAveragePrecision: "MeanAveragePrecision",
}

/**
 * Defines supported metric goals for hyperparameter tuning
 */
union Goal {
  string,

  /**
   * Minimize
   */
  Minimize: "Minimize",

  /**
   * Maximize
   */
  Maximize: "Maximize",
}

/**
 * The specific type of random algorithm
 */
union RandomSamplingAlgorithmRule {
  string,

  /**
   * Random
   */
  Random: "Random",

  /**
   * Sobol
   */
  Sobol: "Sobol",
}

/**
 * Enum of weekdays
 */
union Weekday {
  string,

  /**
   * Monday weekday
   */
  Monday: "Monday",

  /**
   * Tuesday weekday
   */
  Tuesday: "Tuesday",

  /**
   * Wednesday weekday
   */
  Wednesday: "Wednesday",

  /**
   * Thursday weekday
   */
  Thursday: "Thursday",

  /**
   * Friday weekday
   */
  Friday: "Friday",

  /**
   * Saturday weekday
   */
  Saturday: "Saturday",

  /**
   * Sunday weekday
   */
  Sunday: "Sunday",
}

/**
 * Enum to describe the frequency of a recurrence schedule
 */
union RecurrenceFrequency {
  string,

  /**
   * Minute frequency
   */
  Minute: "Minute",

  /**
   * Hour frequency
   */
  Hour: "Hour",

  /**
   * Day frequency
   */
  Day: "Day",

  /**
   * Week frequency
   */
  Week: "Week",

  /**
   * Month frequency
   */
  Month: "Month",
}

/**
 * Enum for all Regression models supported by AutoML.
 */
union RegressionModels {
  string,

  /**
   * Elastic net is a popular type of regularized linear regression that combines two popular penalties, specifically the L1 and L2 penalty functions.
   */
  ElasticNet: "ElasticNet",

  /**
   * The technique of transiting week learners into a strong learner is called Boosting. The gradient boosting algorithm process works on this theory of execution.
   */
  GradientBoosting: "GradientBoosting",

  /**
   * Decision Trees are a non-parametric supervised learning method used for both classification and regression tasks.
   * The goal is to create a model that predicts the value of a target variable by learning simple decision rules inferred from the data features.
   */
  DecisionTree: "DecisionTree",

  /**
   * K-nearest neighbors (KNN) algorithm uses 'feature similarity' to predict the values of new datapoints
   * which further means that the new data point will be assigned a value based on how closely it matches the points in the training set.
   */
  KNN: "KNN",

  /**
   * Lasso model fit with Least Angle Regression a.k.a. Lars. It is a Linear Model trained with an L1 prior as regularizer.
   */
  LassoLars: "LassoLars",

  /**
   * SGD: Stochastic gradient descent is an optimization algorithm often used in machine learning applications
   * to find the model parameters that correspond to the best fit between predicted and actual outputs.
   * It's an inexact but powerful technique.
   */
  SGD: "SGD",

  /**
   * Random forest is a supervised learning algorithm.
   * The "forest" it builds, is an ensemble of decision trees, usually trained with the “bagging” method.
   * The general idea of the bagging method is that a combination of learning models increases the overall result.
   */
  RandomForest: "RandomForest",

  /**
   * Extreme Trees is an ensemble machine learning algorithm that combines the predictions from many decision trees. It is related to the widely used random forest algorithm.
   */
  ExtremeRandomTrees: "ExtremeRandomTrees",

  /**
   * LightGBM is a gradient boosting framework that uses tree based learning algorithms.
   */
  LightGBM: "LightGBM",

  /**
   * XGBoostRegressor: Extreme Gradient Boosting Regressor is a supervised machine learning model using ensemble of base learners.
   */
  XGBoostRegressor: "XGBoostRegressor",
}

/**
 * Primary metrics for Regression task.
 */
union RegressionPrimaryMetrics {
  string,

  /**
   * The Spearman's rank coefficient of correlation is a nonparametric measure of rank correlation.
   */
  SpearmanCorrelation: "SpearmanCorrelation",

  /**
   * The Normalized Root Mean Squared Error (NRMSE) the RMSE facilitates the comparison between models with different scales.
   */
  NormalizedRootMeanSquaredError: "NormalizedRootMeanSquaredError",

  /**
   * The R2 score is one of the performance evaluation measures for forecasting-based machine learning models.
   */
  R2Score: "R2Score",

  /**
   * The Normalized Mean Absolute Error (NMAE) is a validation metric to compare the Mean Absolute Error (MAE) of (time) series with different scales.
   */
  NormalizedMeanAbsoluteError: "NormalizedMeanAbsoluteError",
}

/**
 * Azure Machine Learning workspace REST API operation
 */
model AmlOperation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * Display name of operation
   */
  display?: AmlOperationDisplay;

  /**
   * Indicates whether the operation applies to data-plane
   */
  isDataAction?: boolean;
}

/**
 * Display name of operation
 */
model AmlOperationDisplay {
  /**
   * The resource provider name: Microsoft.MachineLearningExperimentation
   */
  provider?: string;

  /**
   * The resource on which the operation is performed.
   */
  resource?: string;

  /**
   * The operation that users can perform.
   */
  operation?: string;

  /**
   * The description for the operation.
   */
  description?: string;
}

/**
 * The properties of a machine learning workspace.
 */
model WorkspaceProperties {
  /**
   * The immutable id associated with this workspace.
   */
  @visibility(Lifecycle.Read)
  workspaceId?: string;

  /**
   * The description of this workspace.
   */
  description?: string;

  /**
   * The friendly name for this workspace. This name in mutable
   */
  friendlyName?: string;

  /**
   * ARM id of the key vault associated with this workspace. This cannot be changed once the workspace has been created
   */
  keyVault?: string;

  /**
   * ARM id of the application insights associated with this workspace.
   */
  applicationInsights?: string;

  /**
   * ARM id of the container registry associated with this workspace.
   */
  containerRegistry?: string;

  /**
   * ARM id of the storage account associated with this workspace. This cannot be changed once the workspace has been created
   */
  storageAccount?: string;

  /**
   * Url for the discovery service to identify regional endpoints for machine learning experimentation services
   */
  discoveryUrl?: string;

  /**
   * The current deployment state of workspace resource. The provisioningState is to indicate states for resource provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The encryption settings of Azure ML workspace.
   */
  encryption?: EncryptionProperty;

  /**
   * The flag to signal HBI data in the workspace and reduce diagnostic data collected by the service
   */
  hbiWorkspace?: boolean;

  /**
   * The name of the managed resource group created by workspace RP in customer subscription if the workspace is CMK workspace
   */
  @visibility(Lifecycle.Read)
  serviceProvisionedResourceGroup?: string;

  /**
   * Count of private connections in the workspace
   */
  @visibility(Lifecycle.Read)
  privateLinkCount?: int32;

  /**
   * The compute name for image build
   */
  imageBuildCompute?: string;

  /**
   * The flag to indicate whether to allow public access when behind VNet.
   */
  allowPublicAccessWhenBehindVnet?: boolean;

  /**
   * Whether requests from Public Network are allowed.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * The list of private endpoint connections in the workspace.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * The list of shared private link resources in this workspace.
   */
  @identifiers(#["name"])
  sharedPrivateLinkResources?: SharedPrivateLinkResource[];

  /**
   * The notebook info of Azure ML workspace.
   */
  @visibility(Lifecycle.Read)
  notebookInfo?: NotebookResourceInfo;

  /**
   * The service managed resource settings.
   */
  serviceManagedResourcesSettings?: ServiceManagedResourcesSettings;

  /**
   * The user assigned identity resource id that represents the workspace identity.
   */
  primaryUserAssignedIdentity?: string;

  /**
   * The tenant id associated with this workspace.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * If the storage associated with the workspace has hierarchical namespace(HNS) enabled.
   */
  @visibility(Lifecycle.Read)
  storageHnsEnabled?: boolean;

  /**
   * The URI associated with this workspace that machine learning flow must point at to set up tracking.
   */
  @visibility(Lifecycle.Read)
  mlFlowTrackingUri?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model EncryptionProperty {
  /**
   * Indicates whether or not the encryption is enabled for the workspace.
   */
  status: EncryptionStatus;

  /**
   * The identity that will be used to access the key vault for encryption at rest.
   */
  identity?: IdentityForCmk;

  /**
   * Customer Key vault properties.
   */
  keyVaultProperties: EncryptionKeyVaultProperties;
}

/**
 * Identity that will be used to access key vault for encryption at rest
 */
model IdentityForCmk {
  /**
   * The ArmId of the user assigned identity that will be used to access the customer managed key vault
   */
  userAssignedIdentity?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model EncryptionKeyVaultProperties {
  /**
   * The ArmId of the keyVault where the customer owned encryption key is present.
   */
  keyVaultArmId: string;

  /**
   * Key vault uri to access the encryption key.
   */
  keyIdentifier: string;

  /**
   * For future use - The client id of the identity which will be used to access key vault.
   */
  identityClientId?: string;
}

/**
 * Properties of the PrivateEndpointConnectProperties.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The resource of private end point.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The ARM identifier for Subnet resource that private endpoint links to
   */
  @visibility(Lifecycle.Read)
  subnetArmId?: string;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SharedPrivateLinkResource {
  /**
   * Unique name of the private link.
   */
  name?: string;

  /**
   * Resource properties.
   */
  properties?: SharedPrivateLinkResourceProperty;
}

/**
 * Properties of a shared private link resource.
 */
model SharedPrivateLinkResourceProperty {
  /**
   * The resource id that private link links to.
   */
  privateLinkResourceId?: string;

  /**
   * The private link resource group id.
   */
  groupId?: string;

  /**
   * Request message.
   */
  requestMessage?: string;

  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model NotebookResourceInfo {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  fqdn?: string;

  /**
   * the data plane resourceId that used to initialize notebook component
   */
  resourceId?: string;

  /**
   * The error that occurs when preparing notebook.
   */
  notebookPreparationError?: NotebookPreparationError;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model NotebookPreparationError {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  errorMessage?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  statusCode?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ServiceManagedResourcesSettings {
  /**
   * The settings for the service managed cosmosdb account.
   */
  cosmosDb?: CosmosDbSettings;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CosmosDbSettings {
  /**
   * The throughput of the collections in cosmosdb database
   */
  collectionsThroughput?: int32;
}

/**
 * The parameters for updating a machine learning workspace.
 */
model WorkspaceUpdateParameters {
  /**
   * The resource tags for the machine learning workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The sku of the workspace.
   */
  sku?: Azure.ResourceManager.CommonTypes.Sku;

  /**
   * The identity of the resource.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * The properties that the machine learning workspace will be updated with.
   */
  properties?: WorkspacePropertiesUpdateParameters;
}

/**
 * The parameters for updating the properties of a machine learning workspace.
 */
model WorkspacePropertiesUpdateParameters {
  /**
   * The description of this workspace.
   */
  description?: string;

  /**
   * The friendly name for this workspace.
   */
  friendlyName?: string;

  /**
   * The compute name for image build
   */
  imageBuildCompute?: string;

  /**
   * The service managed resource settings.
   */
  serviceManagedResourcesSettings?: ServiceManagedResourcesSettings;

  /**
   * The user assigned identity resource id that represents the workspace identity.
   */
  primaryUserAssignedIdentity?: string;

  /**
   * Whether requests from Public Network are allowed.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * ARM id of the application insights associated with this workspace.
   */
  applicationInsights?: string;

  /**
   * ARM id of the container registry associated with this workspace.
   */
  containerRegistry?: string;
}

/**
 * Parameters to diagnose a workspace
 */
model DiagnoseWorkspaceParameters {
  /**
   * Value of Parameters
   */
  value?: DiagnoseRequestProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DiagnoseRequestProperties {
  /**
   * Setting for diagnosing user defined routing
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  udr?: Record<unknown>;

  /**
   * Setting for diagnosing network security group
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  nsg?: Record<unknown>;

  /**
   * Setting for diagnosing resource lock
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  resourceLock?: Record<unknown>;

  /**
   * Setting for diagnosing dns resolution
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  dnsResolution?: Record<unknown>;

  /**
   * Setting for diagnosing dependent storage account
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  storageAccount?: Record<unknown>;

  /**
   * Setting for diagnosing dependent key vault
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  keyVault?: Record<unknown>;

  /**
   * Setting for diagnosing dependent container registry
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  containerRegistry?: Record<unknown>;

  /**
   * Setting for diagnosing dependent application insights
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  applicationInsights?: Record<unknown>;

  /**
   * Setting for diagnosing unclassified category of problems
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  others?: Record<unknown>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DiagnoseResponseResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  value?: DiagnoseResponseResultValue;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DiagnoseResponseResultValue {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#["message"])
  userDefinedRouteResults?: DiagnoseResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#["message"])
  networkSecurityRuleResults?: DiagnoseResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#["message"])
  resourceLockResults?: DiagnoseResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#["message"])
  dnsResolutionResults?: DiagnoseResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#["message"])
  storageAccountResults?: DiagnoseResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#["message"])
  keyVaultResults?: DiagnoseResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#["message"])
  containerRegistryResults?: DiagnoseResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#["message"])
  applicationInsightsResults?: DiagnoseResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#["message"])
  otherResults?: DiagnoseResult[];
}

/**
 * Result of Diagnose
 */
model DiagnoseResult {
  /**
   * Code for workspace setup error
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Level of workspace setup error
   */
  @visibility(Lifecycle.Read)
  level?: DiagnoseResultLevel;

  /**
   * Message of workspace setup error
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ListWorkspaceKeysResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  userStorageKey?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  userStorageResourceId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  appInsightsInstrumentationKey?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  containerRegistryCredentials?: RegistryListCredentialsResult;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  notebookAccessKeys?: ListNotebookKeysResult;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model RegistryListCredentialsResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  username?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#["name"])
  passwords?: Password[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model Password {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  name?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ListNotebookKeysResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  primaryAccessKey?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  secondaryAccessKey?: string;
}

/**
 * The List Usages operation response.
 */
model ListUsagesResult is Azure.Core.Page<Usage>;

/**
 * Describes AML Resource Usage.
 */
model Usage {
  /**
   * Specifies the resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Region of the AML workspace in the id.
   */
  @visibility(Lifecycle.Read)
  amlWorkspaceLocation?: string;

  /**
   * Specifies the resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * An enum describing the unit of usage measurement.
   */
  @visibility(Lifecycle.Read)
  unit?: UsageUnit;

  /**
   * The current usage of the resource.
   */
  @visibility(Lifecycle.Read)
  currentValue?: int64;

  /**
   * The maximum permitted usage of the resource.
   */
  @visibility(Lifecycle.Read)
  limit?: int64;

  /**
   * The name of the type of usage.
   */
  @visibility(Lifecycle.Read)
  name?: UsageName;
}

/**
 * The Usage Names.
 */
model UsageName {
  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * The localized name of the resource.
   */
  @visibility(Lifecycle.Read)
  localizedValue?: string;
}

/**
 * The List Virtual Machine size operation response.
 */
model VirtualMachineSizeListResult {
  /**
   * The list of virtual machine sizes supported by AmlCompute.
   */
  @identifiers(#["name"])
  value?: VirtualMachineSize[];
}

/**
 * Describes the properties of a VM size.
 */
model VirtualMachineSize {
  /**
   * The name of the virtual machine size.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The family name of the virtual machine size.
   */
  @visibility(Lifecycle.Read)
  family?: string;

  /**
   * The number of vCPUs supported by the virtual machine size.
   */
  @visibility(Lifecycle.Read)
  vCPUs?: int32;

  /**
   * The number of gPUs supported by the virtual machine size.
   */
  @visibility(Lifecycle.Read)
  gpus?: int32;

  /**
   * The OS VHD disk size, in MB, allowed by the virtual machine size.
   */
  @visibility(Lifecycle.Read)
  osVhdSizeMB?: int32;

  /**
   * The resource volume size, in MB, allowed by the virtual machine size.
   */
  @visibility(Lifecycle.Read)
  maxResourceVolumeMB?: int32;

  /**
   * The amount of memory, in GB, supported by the virtual machine size.
   */
  @visibility(Lifecycle.Read)
  memoryGB?: float64;

  /**
   * Specifies if the virtual machine size supports low priority VMs.
   */
  @visibility(Lifecycle.Read)
  lowPriorityCapable?: boolean;

  /**
   * Specifies if the virtual machine size supports premium IO.
   */
  @visibility(Lifecycle.Read)
  premiumIO?: boolean;

  /**
   * The estimated price information for using a VM.
   */
  estimatedVMPrices?: EstimatedVMPrices;

  /**
   * Specifies the compute types supported by the virtual machine size.
   */
  supportedComputeTypes?: string[];
}

/**
 * The estimated price info for using a VM.
 */
model EstimatedVMPrices {
  /**
   * Three lettered code specifying the currency of the VM price. Example: USD
   */
  billingCurrency: BillingCurrency;

  /**
   * The unit of time measurement for the specified VM price. Example: OneHour
   */
  unitOfMeasure: UnitOfMeasure;

  /**
   * The list of estimated prices for using a VM of a particular OS type, tier, etc.
   */
  @identifiers(#[])
  values: EstimatedVMPrice[];
}

/**
 * The estimated price info for using a VM of a particular OS type, tier, etc.
 */
model EstimatedVMPrice {
  /**
   * The price charged for using the VM.
   */
  retailPrice: float64;

  /**
   * Operating system type used by the VM.
   */
  osType: VMPriceOSType;

  /**
   * The type of the VM.
   */
  vmTier: VMTier;
}

/**
 * Quota update parameters.
 */
model QuotaUpdateParameters {
  /**
   * The list for update quota.
   */
  value?: QuotaBaseProperties[];

  /**
   * Region of workspace quota to be updated.
   */
  location?: string;
}

/**
 * The properties for Quota update or retrieval.
 */
model QuotaBaseProperties {
  /**
   * Specifies the resource ID.
   */
  id?: string;

  /**
   * Specifies the resource type.
   */
  type?: string;

  /**
   * The maximum permitted quota of the resource.
   */
  limit?: int64;

  /**
   * An enum describing the unit of quota measurement.
   */
  unit?: QuotaUnit;
}

/**
 * The result of update workspace quota.
 */
model UpdateWorkspaceQuotasResult is Azure.Core.Page<UpdateWorkspaceQuotas>;

/**
 * The properties for update Quota response.
 */
model UpdateWorkspaceQuotas {
  /**
   * Specifies the resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Specifies the resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The maximum permitted quota of the resource.
   */
  limit?: int64;

  /**
   * An enum describing the unit of quota measurement.
   */
  @visibility(Lifecycle.Read)
  unit?: QuotaUnit;

  /**
   * Status of update workspace quota.
   */
  status?: Status;
}

/**
 * The List WorkspaceQuotasByVMFamily operation response.
 */
model ListWorkspaceQuotas is Azure.Core.Page<ResourceQuota>;

/**
 * The quota assigned to a resource.
 */
model ResourceQuota {
  /**
   * Specifies the resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Region of the AML workspace in the id.
   */
  @visibility(Lifecycle.Read)
  amlWorkspaceLocation?: string;

  /**
   * Specifies the resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: ResourceName;

  /**
   * The maximum permitted quota of the resource.
   */
  @visibility(Lifecycle.Read)
  limit?: int64;

  /**
   * An enum describing the unit of quota measurement.
   */
  @visibility(Lifecycle.Read)
  unit?: QuotaUnit;
}

/**
 * The Resource Name.
 */
model ResourceName {
  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * The localized name of the resource.
   */
  @visibility(Lifecycle.Read)
  localizedValue?: string;
}

/**
 * Paginated list of Machine Learning compute objects wrapped in ARM resource envelope.
 */
model PaginatedComputeResourcesList is Azure.Core.Page<ComputeResource>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ComputeResourceSchema {
  /**
   * Compute properties
   */
  properties?: Compute;
}

/**
 * Machine Learning compute object.
 */
@discriminator("computeType")
model Compute {
  /**
   * The type of compute
   */
  computeType: ComputeType;

  /**
   * Location for the underlying compute
   */
  @visibility(Lifecycle.Read)
  computeLocation?: string;

  /**
   * The provision state of the cluster. Valid values are Unknown, Updating, Provisioning, Succeeded, and Failed.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The description of the Machine Learning compute.
   */
  description?: string;

  /**
   * The time at which the compute was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * The time at which the compute was last modified.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedOn?: utcDateTime;

  /**
   * ARM resource id of the underlying compute
   */
  resourceId?: string;

  /**
   * Errors during provisioning
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["/error/code"])
  provisioningErrors?: ErrorResponse[];

  /**
   * Indicating whether the compute was provisioned by user and brought from outside if true, or machine learning service provisioned it if false.
   */
  @visibility(Lifecycle.Read)
  isAttachedCompute?: boolean;

  /**
   * Opt-out of local authentication and ensure customers can use only MSI and AAD exclusively for authentication.
   */
  disableLocalAuth?: boolean;
}

/**
 * AmlCompute update parameters.
 */
model ClusterUpdateParameters {
  /**
   * The properties of the amlCompute.
   */
  properties?: ClusterUpdateProperties;
}

/**
 * The properties of a amlCompute that need to be updated.
 */
model ClusterUpdateProperties {
  /**
   * Properties of ClusterUpdate
   */
  properties?: ScaleSettingsInformation;
}

/**
 * Desired scale settings for the amlCompute.
 */
model ScaleSettingsInformation {
  /**
   * scale settings for AML Compute
   */
  scaleSettings?: ScaleSettings;
}

/**
 * scale settings for AML Compute
 */
model ScaleSettings {
  /**
   * Max number of nodes to use
   */
  maxNodeCount: int32;

  /**
   * Min number of nodes to use
   */
  minNodeCount?: int32;

  /**
   * Node Idle Time before scaling down amlCompute. This string needs to be in the RFC Format.
   */
  nodeIdleTimeBeforeScaleDown?: duration;
}

/**
 * Result of AmlCompute Nodes
 */
model AmlComputeNodesInformation {
  /**
   * The collection of returned AmlCompute nodes details.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  @identifiers(#["nodeId"])
  nodes?: AmlComputeNodeInformation[];

  /**
   * The continuation token.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}

/**
 * Compute node information related to a AmlCompute.
 */
model AmlComputeNodeInformation {
  /**
   * ID of the compute node.
   */
  @visibility(Lifecycle.Read)
  nodeId?: string;

  /**
   * Private IP address of the compute node.
   */
  @visibility(Lifecycle.Read)
  privateIpAddress?: string;

  /**
   * Public IP address of the compute node.
   */
  @visibility(Lifecycle.Read)
  publicIpAddress?: string;

  /**
   * SSH port number of the node.
   */
  @visibility(Lifecycle.Read)
  port?: int32;

  /**
   * State of the compute node. Values are idle, running, preparing, unusable, leaving and preempted.
   */
  @visibility(Lifecycle.Read)
  nodeState?: NodeState;

  /**
   * ID of the Experiment running on the node, if any else null.
   */
  @visibility(Lifecycle.Read)
  runId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model NotebookAccessTokenResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  notebookResourceId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  hostName?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  publicDns?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  accessToken?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  tokenType?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  expiresIn?: int32;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  refreshToken?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  scope?: string;
}

/**
 * Secrets related to a Machine Learning compute. Might differ for every type of compute.
 */
@discriminator("computeType")
model ComputeSecrets {
  /**
   * The type of compute
   */
  computeType: ComputeType;
}

/**
 * List of private endpoint connection associated with the specified workspace
 */
model PrivateEndpointConnectionListResult {
  /**
   * Array of private endpoint connections
   */
  @pageItems
  value?: PrivateEndpointConnection[];
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
 * A private link resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PrivateLinkResource extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Resource properties.
   */
  properties?: PrivateLinkResourceProperties;

  /**
   * The identity of the resource.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * Specifies the location of the resource.
   */
  location?: string;

  /**
   * Contains resource tags defined as key/value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The sku of the workspace.
   */
  sku?: Azure.ResourceManager.CommonTypes.Sku;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ListStorageAccountKeysResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  userStorageKey?: string;
}

/**
 * Paginated list of Workspace connection objects.
 */
model PaginatedWorkspaceConnectionsList is Azure.Core.Page<WorkspaceConnection>;

/**
 * Workspace Connection specific properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model WorkspaceConnectionProps {
  /**
   * Category of the workspace connection.
   */
  category?: string;

  /**
   * Target of the workspace connection.
   */
  target?: string;

  /**
   * Authorization type of the workspace connection.
   */
  authType?: string;

  /**
   * Value details of the workspace connection.
   */
  value?: string;

  /**
   * format for the workspace connection value
   */
  valueFormat?: ValueFormat;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ExternalFqdnResponse {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @pageItems
  @identifiers(#["/properties/category"])
  value?: FqdnEndpoints[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model FqdnEndpoints {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: FqdnEndpointsProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model FqdnEndpointsProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  category?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#["domainName"])
  endpoints?: FqdnEndpoint[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model FqdnEndpoint {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  domainName?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#["port"])
  endpointDetails?: FqdnEndpointDetail[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model FqdnEndpointDetail {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  port?: int32;
}

/**
 * A paginated list of BatchEndpoint entities.
 */
model BatchEndpointTrackedResourceArmPaginatedResult
  is Azure.Core.Page<BatchEndpointData>;

/**
 * Batch endpoint configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model BatchEndpointDetails extends EndpointPropertiesBase {
  /**
   * Default values for Batch Endpoint
   */
  defaults?: BatchEndpointDefaults;

  /**
   * Provisioning state for the endpoint.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: EndpointProvisioningState;
}

/**
 * Batch endpoint default values
 */
model BatchEndpointDefaults {
  /**
   * Name of the deployment that will be default for the endpoint.
   * This deployment will end up getting 100% traffic when the endpoint scoring URL is invoked.
   */
  deploymentName?: string;
}

/**
 * Inference Endpoint base definition
 */
model EndpointPropertiesBase {
  /**
   * [Required] Use 'Key' for key based authentication and 'AMLToken' for Azure Machine Learning token-based authentication. 'Key' doesn't expire but 'AMLToken' does.
   */
  authMode: EndpointAuthMode;

  /**
   * Description of the inference endpoint.
   */
  description?: string;

  /**
   * EndpointAuthKeys to set initially on an Endpoint.
   * This property will always be returned as null. AuthKey values must be retrieved using the ListKeys API.
   */
  @visibility(Lifecycle.Create)
  keys?: EndpointAuthKeys;

  /**
   * Property dictionary. Properties can be added, but not removed or altered.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<string>;

  /**
   * Endpoint URI.
   */
  @visibility(Lifecycle.Read)
  scoringUri?: url;

  /**
   * Endpoint Swagger URI.
   */
  @visibility(Lifecycle.Read)
  swaggerUri?: url;
}

/**
 * Keys for endpoint authentication.
 */
model EndpointAuthKeys {
  /**
   * The primary key.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  primaryKey?: string;

  /**
   * The secondary key.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  secondaryKey?: string;
}

/**
 * Strictly used in update requests.
 */
model PartialBatchEndpointPartialTrackedResource {
  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  identity?: PartialManagedServiceIdentity;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type.
   */
  kind?: string;

  /**
   * The geo-location where the resource lives.
   */
  location?: string;

  /**
   * Additional attributes of the entity.
   */
  properties?: PartialBatchEndpoint;

  /**
   * Sku details required for ARM contract for Autoscaling.
   */
  sku?: PartialSku;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Managed service identity (system assigned and/or user assigned identities)
 */
model PartialManagedServiceIdentity {
  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  type?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentityType;

  /**
   * The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<unknown>;
}

/**
 * Mutable Batch endpoint configuration
 */
model PartialBatchEndpoint {
  /**
   * Default values for Batch Endpoint
   */
  defaults?: BatchEndpointDefaults;
}

/**
 * Common SKU definition.
 */
model PartialSku {
  /**
   * If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted.
   */
  capacity?: int32;

  /**
   * If the service has different generations of hardware, for the same SKU, then that can be captured here.
   */
  family?: string;

  /**
   * The name of the SKU. Ex - P3. It is typically a letter+number code.
   */
  name?: string;

  /**
   * The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code.
   */
  size?: string;

  /**
   * This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.
   */
  tier?: Azure.ResourceManager.CommonTypes.SkuTier;
}

/**
 * A paginated list of BatchDeployment entities.
 */
model BatchDeploymentTrackedResourceArmPaginatedResult
  is Azure.Core.Page<BatchDeploymentData>;

/**
 * Batch inference settings per deployment.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model BatchDeploymentDetails extends EndpointDeploymentPropertiesBase {
  /**
   * Compute target for batch inference operation.
   */
  compute?: string;

  /**
   * Error threshold, if the error count for the entire input goes above this value,
   * the batch inference will be aborted. Range is [-1, int.MaxValue].
   * For FileDataset, this value is the count of file failures.
   * For TabularDataset, this value is the count of record failures.
   * If set to -1 (the lower bound), all failures during batch inference will be ignored.
   */
  errorThreshold?: int32 = -1;

  /**
   * Logging level for batch inference operation.
   */
  loggingLevel?: BatchLoggingLevel;

  /**
   * Indicates maximum number of parallelism per instance.
   */
  maxConcurrencyPerInstance?: int32 = 1;

  /**
   * Size of the mini-batch passed to each batch invocation.
   * For FileDataset, this is the number of files per mini-batch.
   * For TabularDataset, this is the size of the records in bytes, per mini-batch.
   */
  miniBatchSize?: int64 = 10;

  /**
   * Reference to the model asset for the endpoint deployment.
   */
  `model`?: AssetReferenceBase;

  /**
   * Indicates how the output will be organized.
   */
  outputAction?: BatchOutputAction;

  /**
   * Customized output file name for append_row output action.
   */
  outputFileName?: string = "predictions.csv";

  /**
   * Provisioning state for the endpoint deployment.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DeploymentProvisioningState;

  /**
   * Indicates compute configuration for the job.
   * If not provided, will default to the defaults defined in ResourceConfiguration.
   */
  resources?: ResourceConfiguration;

  /**
   * Retry Settings for the batch inference operation.
   * If not provided, will default to the defaults defined in BatchRetrySettings.
   */
  retrySettings?: BatchRetrySettings;
}

/**
 * Base definition for asset references.
 */
@discriminator("referenceType")
model AssetReferenceBase {
  /**
   * [Required] Specifies the type of asset reference.
   */
  referenceType: ReferenceType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceConfiguration {
  /**
   * Optional number of instances or nodes used by the compute target.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  instanceCount?: int32 = 1;

  /**
   * Optional type of VM used as supported by the compute target.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  instanceType?: string;

  /**
   * Additional properties bag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  properties?: Record<unknown>;
}

/**
 * Retry settings for a batch inference operation.
 */
model BatchRetrySettings {
  /**
   * Maximum retry count for a mini-batch
   */
  maxRetries?: int32 = 3;

  /**
   * Invocation timeout for a mini-batch, in ISO 8601 format.
   */
  timeout?: duration;
}

/**
 * Base definition for endpoint deployment.
 */
model EndpointDeploymentPropertiesBase {
  /**
   * Code configuration for the endpoint deployment.
   */
  codeConfiguration?: CodeConfiguration;

  /**
   * Description of the endpoint deployment.
   */
  description?: string;

  /**
   * ARM resource ID of the environment specification for the endpoint deployment.
   */
  environmentId?: string;

  /**
   * Environment variables configuration for the deployment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  environmentVariables?: Record<string>;

  /**
   * Property dictionary. Properties can be added, but not removed or altered.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<string>;
}

/**
 * Configuration for a scoring code asset.
 */
model CodeConfiguration {
  /**
   * ARM resource ID of the code asset.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  codeId?: string;

  /**
   * [Required] The script to execute on startup. eg. "score.py"
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  scoringScript: string;
}

/**
 * Strictly used in update requests.
 */
model PartialBatchDeploymentPartialTrackedResource {
  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  identity?: PartialManagedServiceIdentity;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type.
   */
  kind?: string;

  /**
   * The geo-location where the resource lives.
   */
  location?: string;

  /**
   * Additional attributes of the entity.
   */
  properties?: PartialBatchDeployment;

  /**
   * Sku details required for ARM contract for Autoscaling.
   */
  sku?: PartialSku;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Mutable batch inference settings per deployment.
 */
model PartialBatchDeployment {
  /**
   * Code configuration for the endpoint deployment.
   */
  codeConfiguration?: PartialCodeConfiguration;

  /**
   * Compute binding definition.
   */
  compute?: string;

  /**
   * Description of the endpoint deployment.
   */
  description?: string;

  /**
   * ARM resource ID of the environment specification for the endpoint deployment.
   */
  environmentId?: string;

  /**
   * Environment variables configuration for the deployment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  environmentVariables?: Record<string>;

  /**
   * Error threshold, if the error count for the entire input goes above this value,
   * the batch inference will be aborted. Range is [-1, int.MaxValue].
   * For FileDataset, this value is the count of file failures.
   * For TabularDataset, this value is the count of record failures.
   * If set to -1 (the lower bound), all failures during batch inference will be ignored.
   */
  errorThreshold?: int32;

  /**
   * Logging level for batch inference operation.
   */
  loggingLevel?: BatchLoggingLevel;

  /**
   * Indicates number of processes per instance
   */
  maxConcurrencyPerInstance?: int32;

  /**
   * Size of the mini-batch passed to each batch invocation.
   * For FileDataset, this is the number of files per mini-batch.
   * For TabularDataset, this is the size of the records in bytes, per mini-batch.
   */
  miniBatchSize?: int64;

  /**
   * Reference to the model asset for the endpoint deployment.
   */
  `model`?: PartialAssetReferenceBase;

  /**
   * Indicates how the output will be organized.
   */
  outputAction?: BatchOutputAction;

  /**
   * Customized output file name for append_row output action.
   */
  outputFileName?: string;

  /**
   * Property dictionary. Properties can be added, but not removed or altered.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<string>;

  /**
   * Retry Settings for the batch inference operation.
   */
  retrySettings?: PartialBatchRetrySettings;
}

/**
 * Configuration for a scoring code asset.
 */
model PartialCodeConfiguration {
  /**
   * ARM resource ID of the code asset.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  codeId?: string;

  /**
   * The script to execute on startup. eg. "score.py"
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  scoringScript?: string;
}

/**
 * Base definition for asset references.
 */
@discriminator("referenceType")
model PartialAssetReferenceBase {
  /**
   * [Required] Specifies the type of asset reference.
   */
  referenceType: ReferenceType;
}

/**
 * Retry settings for a batch inference operation.
 */
model PartialBatchRetrySettings {
  /**
   * Maximum retry count for a mini-batch
   */
  maxRetries?: int32;

  /**
   * Invocation timeout for a mini-batch, in ISO 8601 format.
   */
  timeout?: duration;
}

/**
 * A paginated list of CodeContainer entities.
 */
model CodeContainerResourceArmPaginatedResult
  is Azure.Core.Page<CodeContainerData>;

/**
 * Container for code asset versions.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model CodeContainerDetails extends AssetContainer {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AssetContainer extends ResourceBase {
  /**
   * Is the asset archived?
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  isArchived?: boolean;

  /**
   * The latest version inside this container.
   */
  @visibility(Lifecycle.Read)
  latestVersion?: string;

  /**
   * The next auto incremental version
   */
  @visibility(Lifecycle.Read)
  nextVersion?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceBase {
  /**
   * The asset description text.
   */
  description?: string;

  /**
   * The asset property dictionary.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<string>;

  /**
   * Tag dictionary. Tags can be added, removed, and updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * A paginated list of CodeVersion entities.
 */
model CodeVersionResourceArmPaginatedResult is Azure.Core.Page<CodeVersionData>;

/**
 * Code asset version details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model CodeVersionDetails extends AssetBase {
  /**
   * Uri where code is located
   */
  codeUri?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AssetBase extends ResourceBase {
  /**
   * If the name version are system generated (anonymous registration).
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isAnonymous?: boolean;

  /**
   * Is the asset archived?
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  isArchived?: boolean;
}

/**
 * A paginated list of ComponentContainer entities.
 */
model ComponentContainerResourceArmPaginatedResult
  is Azure.Core.Page<ComponentContainerData>;

/**
 * Component container definition.
 * <see href="https://docs.microsoft.com/en-us/azure/machine-learning/reference-yaml-component-command" />
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ComponentContainerDetails extends AssetContainer {}

/**
 * A paginated list of ComponentVersion entities.
 */
model ComponentVersionResourceArmPaginatedResult
  is Azure.Core.Page<ComponentVersionData>;

/**
 * Definition of a component version: defines resources that span component types.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ComponentVersionDetails extends AssetBase {
  /**
   * Defines Component definition details.
   * <see href="https://docs.microsoft.com/en-us/azure/machine-learning/reference-yaml-component-command" />
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  componentSpec?: unknown;
}

/**
 * A paginated list of DataContainer entities.
 */
model DataContainerResourceArmPaginatedResult
  is Azure.Core.Page<DataContainerData>;

/**
 * Container for data asset versions.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DataContainerDetails extends AssetContainer {
  /**
   * [Required] Specifies the type of data.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataType: DataType;
}

/**
 * A paginated list of DataVersionBase entities.
 */
model DataVersionBaseResourceArmPaginatedResult
  is Azure.Core.Page<DataVersionBaseData>;

/**
 * Data version base definition
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
@discriminator("dataType")
model DataVersionBaseDetails extends AssetBase {
  /**
   * [Required] Specifies the type of data.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataType: DataType;

  /**
   * [Required] Uri of the data. Usage/meaning depends on Microsoft.MachineLearning.ManagementFrontEnd.Contracts.V20220201Preview.Assets.DataVersionBase.DataType
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  dataUri: string;
}

/**
 * A paginated list of Datastore entities.
 */
model DatastoreResourceArmPaginatedResult is Azure.Core.Page<DatastoreData>;

/**
 * Base definition for datastore contents configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
@discriminator("datastoreType")
model DatastoreDetails extends ResourceBase {
  /**
   * [Required] Account credentials.
   */
  credentials: DatastoreCredentials;

  /**
   * [Required] Storage type backing the datastore.
   */
  datastoreType: DatastoreType;

  /**
   * Readonly property to indicate if datastore is the workspace default datastore
   */
  @visibility(Lifecycle.Read)
  isDefault?: boolean;
}

/**
 * Base definition for datastore credentials.
 */
@discriminator("credentialsType")
model DatastoreCredentials {
  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialsType: CredentialsType;
}

/**
 * Base definition for datastore secrets.
 */
@discriminator("secretsType")
model DatastoreSecrets {
  /**
   * [Required] Credential type used to authentication with storage.
   */
  secretsType: SecretsType;
}

/**
 * A paginated list of EnvironmentContainer entities.
 */
model EnvironmentContainerResourceArmPaginatedResult
  is Azure.Core.Page<EnvironmentContainerData>;

/**
 * Container for environment specification versions.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model EnvironmentContainerDetails extends AssetContainer {}

/**
 * A paginated list of EnvironmentVersion entities.
 */
model EnvironmentVersionResourceArmPaginatedResult
  is Azure.Core.Page<EnvironmentVersionData>;

/**
 * Environment version details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model EnvironmentVersionDetails extends AssetBase {
  /**
   * Configuration settings for Docker build context.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  build?: BuildContext;

  /**
   * Standard configuration file used by Conda that lets you install any kind of package, including Python, R, and C/C++ packages.
   * <see href="https://repo2docker.readthedocs.io/en/latest/config_files.html#environment-yml-install-a-conda-environment" />
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  condaFile?: string;

  /**
   * Environment type is either user managed or curated by the Azure ML service
   * <see href="https://docs.microsoft.com/en-us/azure/machine-learning/resource-curated-environments" />
   */
  @visibility(Lifecycle.Read)
  environmentType?: EnvironmentType;

  /**
   * Name of the image that will be used for the environment.
   * <seealso href="https://docs.microsoft.com/en-us/azure/machine-learning/how-to-deploy-custom-docker-image#use-a-custom-base-image" />
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  image?: string;

  /**
   * Defines configuration specific to inference.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inferenceConfig?: InferenceContainerProperties;

  /**
   * The OS type of the environment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  osType?: OperatingSystemType;
}

/**
 * Configuration settings for Docker build context
 */
model BuildContext {
  /**
   * [Required] URI of the Docker build context used to build the image. Supports blob URIs on environment creation and may return blob or Git URIs.
   * <seealso href="https://docs.docker.com/engine/reference/commandline/build/#extended-description" />
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  contextUri: string;

  /**
   * Path to the Dockerfile in the build context.
   * <seealso href="https://docs.docker.com/engine/reference/builder/" />
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dockerfilePath?: string = "Dockerfile";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model InferenceContainerProperties {
  /**
   * The route to check the liveness of the inference server container.
   */
  livenessRoute?: Route;

  /**
   * The route to check the readiness of the inference server container.
   */
  readinessRoute?: Route;

  /**
   * The port to send the scoring requests to, within the inference server container.
   */
  scoringRoute?: Route;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model Route {
  /**
   * [Required] The path for the route.
   */
  @pattern("[a-zA-Z0-9_]")
  path: string;

  /**
   * [Required] The port for the route.
   */
  port: int32;
}

/**
 * A paginated list of JobBase entities.
 */
model JobBaseResourceArmPaginatedResult is Azure.Core.Page<JobBaseData>;

/**
 * Base definition for a job.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
@discriminator("jobType")
model JobBaseDetails extends ResourceBase {
  /**
   * ARM resource ID of the compute resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  computeId?: string;

  /**
   * Display name of job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  displayName?: string;

  /**
   * The name of the experiment the job belongs to. If not set, the job is placed in the "Default" experiment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  experimentName?: string = "Default";

  /**
   * Identity configuration. If set, this should be one of AmlToken, ManagedIdentity, UserIdentity or null.
   * Defaults to AmlToken if null.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  identity?: IdentityConfiguration;

  /**
   * Is the asset archived?
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  isArchived?: boolean;

  /**
   * [Required] Specifies the type of job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobType: JobType;

  /**
   * Schedule definition of job.
   * If no schedule is provided, the job is run once and immediately after submission.
   */
  schedule?: ScheduleBase;

  /**
   * List of JobEndpoints.
   * For local jobs, a job endpoint will have an endpoint value of FileStreamObject.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  services?: Record<JobService>;

  /**
   * Status of the job.
   */
  @visibility(Lifecycle.Read)
  status?: JobStatus;
}

/**
 * Base definition for identity configuration.
 */
@discriminator("identityType")
model IdentityConfiguration {
  /**
   * [Required] Specifies the type of identity framework.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  identityType: IdentityConfigurationType;
}

/**
 * Base definition of a schedule
 */
@discriminator("scheduleType")
model ScheduleBase {
  /**
   * Specifies end time of schedule in ISO 8601 format.
   * If not present, the schedule will run indefinitely
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Specifies the schedule's status
   */
  scheduleStatus?: ScheduleStatus;

  /**
   * [Required] Specifies the schedule type
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  scheduleType: ScheduleType;

  /**
   * Specifies start time of schedule in ISO 8601 format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Specifies time zone in which the schedule runs.
   * TimeZone should follow Windows time zone format.
   */
  timeZone?: string = "UTC";
}

/**
 * Job endpoint definition
 */
model JobService {
  /**
   * Url for endpoint.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpoint?: string;

  /**
   * Any error in the service.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * Endpoint type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobServiceType?: string;

  /**
   * Port for endpoint.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  port?: int32;

  /**
   * Additional properties to set on the endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<string>;

  /**
   * Status of endpoint.
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * A paginated list of ModelContainer entities.
 */
model ModelContainerResourceArmPaginatedResult
  is Azure.Core.Page<ModelContainerData>;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ModelContainerDetails extends AssetContainer {}

/**
 * A paginated list of ModelVersion entities.
 */
model ModelVersionResourceArmPaginatedResult
  is Azure.Core.Page<ModelVersionData>;

/**
 * Model asset version details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ModelVersionDetails extends AssetBase {
  /**
   * Mapping of model flavors to their properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  flavors?: Record<FlavorData>;

  /**
   * Name of the training job which produced this model
   */
  jobName?: string;

  /**
   * The storage format for this entity. Used for NCD.
   */
  modelType?: ModelType;

  /**
   * The URI path to the model contents.
   */
  modelUri?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model FlavorData {
  /**
   * Model flavor-specific data.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  data?: Record<string>;
}

/**
 * A paginated list of OnlineEndpoint entities.
 */
model OnlineEndpointTrackedResourceArmPaginatedResult
  is Azure.Core.Page<OnlineEndpointData>;

/**
 * Online endpoint configuration
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OnlineEndpointDetails extends EndpointPropertiesBase {
  /**
   * ARM resource ID of the compute if it exists.
   * optional
   */
  compute?: string;

  /**
   * Percentage of traffic to be mirrored to each deployment without using returned scoring. Traffic values need to sum to utmost 50.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  mirrorTraffic?: Record<int32>;

  /**
   * Provisioning state for the endpoint.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: EndpointProvisioningState;

  /**
   * Set to "Enabled" for endpoints that should allow public access when Private Link is enabled.
   */
  publicNetworkAccess?: PublicNetworkAccessType;

  /**
   * Percentage of traffic from endpoint to divert to each deployment. Traffic values need to sum to 100.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  traffic?: Record<int32>;
}

/**
 * Strictly used in update requests.
 */
model PartialOnlineEndpointPartialTrackedResource {
  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  identity?: PartialManagedServiceIdentity;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type.
   */
  kind?: string;

  /**
   * The geo-location where the resource lives.
   */
  location?: string;

  /**
   * Additional attributes of the entity.
   */
  properties?: PartialOnlineEndpoint;

  /**
   * Sku details required for ARM contract for Autoscaling.
   */
  sku?: PartialSku;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Mutable online endpoint configuration
 */
model PartialOnlineEndpoint {
  /**
   * Percentage of traffic to be mirrored to each deployment without using returned scoring. Traffic values need to sum to utmost 50.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  mirrorTraffic?: Record<int32>;

  /**
   * Set to "Enabled" for endpoints that should allow public access when Private Link is enabled.
   */
  publicNetworkAccess?: PublicNetworkAccessType;

  /**
   * Percentage of traffic from endpoint to divert to each deployment. Traffic values need to sum to 100.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  traffic?: Record<int32>;
}

/**
 * A paginated list of OnlineDeployment entities.
 */
model OnlineDeploymentTrackedResourceArmPaginatedResult
  is Azure.Core.Page<OnlineDeploymentData>;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@discriminator("endpointComputeType")
model OnlineDeploymentDetails extends EndpointDeploymentPropertiesBase {
  /**
   * If true, enables Application Insights logging.
   */
  appInsightsEnabled?: boolean;

  /**
   * If Enabled, allow egress public network access. If Disabled, this will create secure egress. Default: Enabled.
   */
  egressPublicNetworkAccess?: EgressPublicNetworkAccessType;

  /**
   * [Required] The compute type of the endpoint.
   */
  endpointComputeType: EndpointComputeType;

  /**
   * Compute instance type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  instanceType?: string;

  /**
   * Liveness probe monitors the health of the container regularly.
   */
  livenessProbe?: ProbeSettings;

  /**
   * The URI path to the model.
   */
  `model`?: string;

  /**
   * The path to mount the model in custom container.
   */
  modelMountPath?: string;

  /**
   * If true, enable private network connection.
   * DEPRECATED for future API versions. Use EgressPublicNetworkAccess.
   */
  privateNetworkConnection?: boolean;

  /**
   * Provisioning state for the endpoint deployment.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DeploymentProvisioningState;

  /**
   * Readiness probe validates if the container is ready to serve traffic. The properties and defaults are the same as liveness probe.
   */
  readinessProbe?: ProbeSettings;

  /**
   * Request settings for the deployment.
   */
  requestSettings?: OnlineRequestSettings;

  /**
   * Scale settings for the deployment.
   * If it is null or not provided,
   * it defaults to TargetUtilizationScaleSettings for KubernetesOnlineDeployment
   * and to DefaultScaleSettings for ManagedOnlineDeployment.
   */
  scaleSettings?: OnlineScaleSettings;
}

/**
 * Deployment container liveness/readiness probe configuration.
 */
model ProbeSettings {
  /**
   * The number of failures to allow before returning an unhealthy status.
   */
  failureThreshold?: int32 = 30;

  /**
   * The delay before the first probe in ISO 8601 format.
   */
  initialDelay?: duration;

  /**
   * The length of time between probes in ISO 8601 format.
   */
  period?: duration;

  /**
   * The number of successful probes before returning a healthy status.
   */
  successThreshold?: int32 = 1;

  /**
   * The probe timeout in ISO 8601 format.
   */
  timeout?: duration;
}

/**
 * Online deployment scoring requests configuration.
 */
model OnlineRequestSettings {
  /**
   * The number of maximum concurrent requests per node allowed per deployment. Defaults to 1.
   */
  maxConcurrentRequestsPerInstance?: int32 = 1;

  /**
   * The maximum amount of time a request will stay in the queue in ISO 8601 format.
   * Defaults to 500ms.
   */
  maxQueueWait?: duration;

  /**
   * The scoring timeout in ISO 8601 format.
   * Defaults to 5000ms.
   */
  requestTimeout?: duration;
}

/**
 * Online deployment scaling configuration.
 */
@discriminator("scaleType")
model OnlineScaleSettings {
  /**
   * [Required] Type of deployment scaling algorithm
   */
  scaleType: ScaleType;
}

/**
 * Strictly used in update requests.
 */
model PartialOnlineDeploymentPartialTrackedResource {
  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  identity?: PartialManagedServiceIdentity;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type.
   */
  kind?: string;

  /**
   * The geo-location where the resource lives.
   */
  location?: string;

  /**
   * Additional attributes of the entity.
   */
  properties?: PartialOnlineDeployment;

  /**
   * Sku details required for ARM contract for Autoscaling.
   */
  sku?: PartialSku;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Mutable online deployment configuration
 */
@discriminator("endpointComputeType")
model PartialOnlineDeployment {
  /**
   * [Required] The compute type of the endpoint.
   */
  endpointComputeType: EndpointComputeType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DeploymentLogsRequest {
  /**
   * The type of container to retrieve logs from.
   */
  containerType?: ContainerType;

  /**
   * The maximum number of lines to tail.
   */
  tail?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DeploymentLogs {
  /**
   * The retrieved online deployment logs.
   */
  content?: string;
}

/**
 * A paginated list of SkuResource entities.
 */
model SkuResourceArmPaginatedResult is Azure.Core.Page<SkuResource>;

/**
 * Fulfills ARM Contract requirement to list all available SKUS for a resource.
 */
model SkuResource {
  /**
   * Gets or sets the Sku Capacity.
   */
  capacity?: SkuCapacity;

  /**
   * The resource type name.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * Gets or sets the Sku.
   */
  sku?: SkuSetting;
}

/**
 * SKU capacity information
 */
model SkuCapacity {
  /**
   * Gets or sets the default capacity.
   */
  default?: int32;

  /**
   * Gets or sets the maximum.
   */
  maximum?: int32;

  /**
   * Gets or sets the minimum.
   */
  minimum?: int32;

  /**
   * Gets or sets the type of the scale.
   */
  scaleType?: SkuScaleType;
}

/**
 * SkuSetting fulfills the need for stripped down SKU info in ARM contract.
 */
model SkuSetting {
  /**
   * [Required] The name of the SKU. Ex - P3. It is typically a letter+number code.
   */
  @pattern("[a-zA-Z0-9_]")
  name: string;

  /**
   * This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.
   */
  tier?: Azure.ResourceManager.CommonTypes.SkuTier;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model RegenerateEndpointKeysRequest {
  /**
   * [Required] Specification for which type of key to generate. Primary or Secondary.
   */
  keyType: KeyType;

  /**
   * The value the key is set to.
   */
  keyValue?: string;
}

/**
 * Service Token
 */
model EndpointAuthToken {
  /**
   * Access token for endpoint authentication.
   */
  accessToken?: string;

  /**
   * Access token expiry time (UTC).
   */
  expiryTimeUtc?: int64;

  /**
   * Refresh access token after time (UTC).
   */
  refreshAfterTimeUtc?: int64;

  /**
   * Access token type.
   */
  tokenType?: string;
}

/**
 * The List Aml user feature operation response.
 */
model ListAmlUserFeatureResult is Azure.Core.Page<AmlUserFeature>;

/**
 * Features enabled for a workspace
 */
model AmlUserFeature {
  /**
   * Specifies the feature ID
   */
  id?: string;

  /**
   * Specifies the feature name
   */
  displayName?: string;

  /**
   * Describes the feature for user experience
   */
  description?: string;
}

/**
 * Represents a resource ID. For example, for a subnet, it is the resource URL for the subnet.
 */
model ResourceId {
  /**
   * The ID of the resource
   */
  id: string;
}

/**
 * A Machine Learning compute based on AKS.
 */
model AKS extends Compute {
  ...AKSSchema;

  /**
   * The type of compute
   */
  computeType: "AKS";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AKSSchema {
  /**
   * AKS properties
   */
  properties?: AKSSchemaProperties;
}

/**
 * AKS properties
 */
model AKSSchemaProperties {
  /**
   * Cluster full qualified domain name
   */
  clusterFqdn?: string;

  /**
   * System services
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["publicIpAddress"])
  systemServices?: SystemService[];

  /**
   * Number of agents
   */
  agentCount?: int32;

  /**
   * Agent virtual machine size
   */
  agentVmSize?: string;

  /**
   * Intended usage of the cluster
   */
  clusterPurpose?: ClusterPurpose = ClusterPurpose.FastProd;

  /**
   * SSL configuration
   */
  sslConfiguration?: SslConfiguration;

  /**
   * AKS networking configuration for vnet
   */
  aksNetworkingConfiguration?: AksNetworkingConfiguration;

  /**
   * Load Balancer Type
   */
  loadBalancerType?: LoadBalancerType = LoadBalancerType.PublicIp;

  /**
   * Load Balancer Subnet
   */
  loadBalancerSubnet?: string;
}

/**
 * A system service running on a compute.
 */
model SystemService {
  /**
   * The type of this system service.
   */
  @visibility(Lifecycle.Read)
  systemServiceType?: string;

  /**
   * Public IP address
   */
  @visibility(Lifecycle.Read)
  publicIpAddress?: string;

  /**
   * The version for this type.
   */
  @visibility(Lifecycle.Read)
  version?: string;
}

/**
 * The ssl configuration for scoring
 */
model SslConfiguration {
  /**
   * Enable or disable ssl for scoring
   */
  status?: SslConfigurationStatus;

  /**
   * Cert data
   */
  cert?: string;

  /**
   * Key data
   */
  key?: string;

  /**
   * CNAME of the cert
   */
  cname?: string;

  /**
   * Leaf domain label of public endpoint
   */
  leafDomainLabel?: string;

  /**
   * Indicates whether to overwrite existing domain label.
   */
  overwriteExistingDomain?: boolean;
}

/**
 * Advance configuration for AKS networking
 */
model AksNetworkingConfiguration {
  /**
   * Virtual network subnet resource ID the compute nodes belong to
   */
  subnetId?: string;

  /**
   * A CIDR notation IP range from which to assign service cluster IPs. It must not overlap with any Subnet IP ranges.
   */
  @pattern("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$")
  serviceCidr?: string;

  /**
   * An IP address assigned to the Kubernetes DNS service. It must be within the Kubernetes service address range specified in serviceCidr.
   */
  @pattern("^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
  dnsServiceIP?: string;

  /**
   * A CIDR notation IP range assigned to the Docker bridge network. It must not overlap with any Subnet IP ranges or the Kubernetes service address range.
   */
  @pattern("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$")
  dockerBridgeCidr?: string;
}

/**
 * A Machine Learning compute based on Kubernetes Compute.
 */
model Kubernetes extends Compute {
  ...KubernetesSchema;

  /**
   * The type of compute
   */
  computeType: "Kubernetes";
}

/**
 * Kubernetes Compute Schema
 */
model KubernetesSchema {
  /**
   * Properties of Kubernetes
   */
  properties?: KubernetesProperties;
}

/**
 * Kubernetes properties
 */
model KubernetesProperties {
  /**
   * Relay connection string.
   */
  relayConnectionString?: string;

  /**
   * ServiceBus connection string.
   */
  serviceBusConnectionString?: string;

  /**
   * Extension principal-id.
   */
  extensionPrincipalId?: string;

  /**
   * Extension instance release train.
   */
  extensionInstanceReleaseTrain?: string;

  /**
   * VC name.
   */
  vcName?: string;

  /**
   * Compute namespace
   */
  `namespace`?: string = "default";

  /**
   * Default instance type
   */
  defaultInstanceType?: string;

  /**
   * Instance Type Schema
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  instanceTypes?: Record<InstanceTypeSchema>;
}

/**
 * Instance type schema.
 */
model InstanceTypeSchema {
  /**
   * Node Selector
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  nodeSelector?: Record<string>;

  /**
   * Resource requests/limits for this instance type
   */
  resources?: InstanceTypeSchemaResources;
}

/**
 * Resource requests/limits for this instance type
 */
model InstanceTypeSchemaResources {
  /**
   * Resource requests for this instance type
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  requests?: Record<string>;

  /**
   * Resource limits for this instance type
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  limits?: Record<string>;
}

/**
 * AML Compute properties
 */
model AmlComputeProperties {
  /**
   * Compute OS Type
   */
  osType?: OsType = OsType.Linux;

  /**
   * Virtual Machine Size
   */
  vmSize?: string;

  /**
   * Virtual Machine priority
   */
  vmPriority?: VmPriority;

  /**
   * Virtual Machine image for AML Compute - windows only
   */
  virtualMachineImage?: VirtualMachineImage;

  /**
   * Network is isolated or not
   */
  isolatedNetwork?: boolean;

  /**
   * Scale settings for AML Compute
   */
  scaleSettings?: ScaleSettings;

  /**
   * Credentials for an administrator user account that will be created on each compute node.
   */
  userAccountCredentials?: UserAccountCredentials;

  /**
   * Virtual network subnet resource ID the compute nodes belong to.
   */
  subnet?: ResourceId;

  /**
   * State of the public SSH port. Possible values are: Disabled - Indicates that the public ssh port is closed on all nodes of the cluster. Enabled - Indicates that the public ssh port is open on all nodes of the cluster. NotSpecified - Indicates that the public ssh port is closed on all nodes of the cluster if VNet is defined, else is open all public nodes. It can be default only during cluster creation time, after creation it will be either enabled or disabled.
   */
  remoteLoginPortPublicAccess?: RemoteLoginPortPublicAccess = RemoteLoginPortPublicAccess.NotSpecified;

  /**
   * Allocation state of the compute. Possible values are: steady - Indicates that the compute is not resizing. There are no changes to the number of compute nodes in the compute in progress. A compute enters this state when it is created and when no operations are being performed on the compute to change the number of compute nodes. resizing - Indicates that the compute is resizing; that is, compute nodes are being added to or removed from the compute.
   */
  @visibility(Lifecycle.Read)
  allocationState?: AllocationState;

  /**
   * The time at which the compute entered its current allocation state.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  allocationStateTransitionTime?: utcDateTime;

  /**
   * Collection of errors encountered by various compute nodes during node setup.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["/error/code"])
  errors?: ErrorResponse[];

  /**
   * The number of compute nodes currently assigned to the compute.
   */
  @visibility(Lifecycle.Read)
  currentNodeCount?: int32;

  /**
   * The target number of compute nodes for the compute. If the allocationState is resizing, this property denotes the target node count for the ongoing resize operation. If the allocationState is steady, this property denotes the target node count for the previous resize operation.
   */
  @visibility(Lifecycle.Read)
  targetNodeCount?: int32;

  /**
   * Counts of various node states on the compute.
   */
  @visibility(Lifecycle.Read)
  nodeStateCounts?: NodeStateCounts;

  /**
   * Enable or disable node public IP address provisioning. Possible values are: Possible values are: true - Indicates that the compute nodes will have public IPs provisioned. false - Indicates that the compute nodes will have a private endpoint and no public IPs.
   */
  enableNodePublicIp?: boolean = true;

  /**
   * A property bag containing additional properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  propertyBag?: Record<unknown>;
}

/**
 * Virtual Machine image for Windows AML Compute
 */
model VirtualMachineImage {
  /**
   * Virtual Machine image path
   */
  id: string;
}

/**
 * Settings for user account that gets created on each on the nodes of a compute.
 */
model UserAccountCredentials {
  /**
   * Name of the administrator user account which can be used to SSH to nodes.
   */
  adminUserName: string;

  /**
   * SSH public key of the administrator user account.
   */
  adminUserSshPublicKey?: string;

  /**
   * Password of the administrator user account.
   */
  adminUserPassword?: string;
}

/**
 * Counts of various compute node states on the amlCompute.
 */
model NodeStateCounts {
  /**
   * Number of compute nodes in idle state.
   */
  @visibility(Lifecycle.Read)
  idleNodeCount?: int32;

  /**
   * Number of compute nodes which are running jobs.
   */
  @visibility(Lifecycle.Read)
  runningNodeCount?: int32;

  /**
   * Number of compute nodes which are being prepared.
   */
  @visibility(Lifecycle.Read)
  preparingNodeCount?: int32;

  /**
   * Number of compute nodes which are in unusable state.
   */
  @visibility(Lifecycle.Read)
  unusableNodeCount?: int32;

  /**
   * Number of compute nodes which are leaving the amlCompute.
   */
  @visibility(Lifecycle.Read)
  leavingNodeCount?: int32;

  /**
   * Number of compute nodes which are in preempted state.
   */
  @visibility(Lifecycle.Read)
  preemptedNodeCount?: int32;
}

/**
 * An Azure Machine Learning compute.
 */
model AmlCompute extends Compute {
  ...AmlComputeSchema;

  /**
   * The type of compute
   */
  computeType: "AmlCompute";
}

/**
 * Properties(top level) of AmlCompute
 */
model AmlComputeSchema {
  /**
   * Properties of AmlCompute
   */
  properties?: AmlComputeProperties;
}

/**
 * Compute Instance properties
 */
model ComputeInstanceProperties {
  /**
   * Virtual Machine Size
   */
  vmSize?: string;

  /**
   * Virtual network subnet resource ID the compute nodes belong to.
   */
  subnet?: ResourceId;

  /**
   * Policy for sharing applications on this compute instance among users of parent workspace. If Personal, only the creator can access applications on this compute instance. When Shared, any workspace user can access applications on this instance depending on his/her assigned role.
   */
  applicationSharingPolicy?: ApplicationSharingPolicy = ApplicationSharingPolicy.Shared;

  /**
   * Specifies policy and settings for SSH access.
   */
  sshSettings?: ComputeInstanceSshSettings;

  /**
   * Describes all connectivity endpoints available for this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  connectivityEndpoints?: ComputeInstanceConnectivityEndpoints;

  /**
   * Describes available applications and their endpoints on this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["displayName"])
  applications?: ComputeInstanceApplication[];

  /**
   * Describes information on user who created this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  createdBy?: ComputeInstanceCreatedBy;

  /**
   * Collection of errors encountered on this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["/error/code"])
  errors?: ErrorResponse[];

  /**
   * The current state of this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  state?: ComputeInstanceState;

  /**
   * The Compute Instance Authorization type. Available values are personal (default).
   */
  computeInstanceAuthorizationType?: ComputeInstanceAuthorizationType = ComputeInstanceAuthorizationType.personal;

  /**
   * Settings for a personal compute instance.
   */
  personalComputeInstanceSettings?: PersonalComputeInstanceSettings;

  /**
   * Details of customized scripts to execute for setting up the cluster.
   */
  setupScripts?: SetupScripts;

  /**
   * The last operation on ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  lastOperation?: ComputeInstanceLastOperation;

  /**
   * The list of schedules to be applied on the computes.
   */
  @visibility(Lifecycle.Read)
  schedules?: ComputeSchedules;

  /**
   * Enable or disable node public IP address provisioning. Possible values are: Possible values are: true - Indicates that the compute nodes will have public IPs provisioned. false - Indicates that the compute nodes will have a private endpoint and no public IPs.
   */
  enableNodePublicIp?: boolean;

  /**
   * Describes informations of containers on this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  containers?: ComputeInstanceContainer[];

  /**
   * Describes informations of dataDisks on this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  dataDisks?: ComputeInstanceDataDisk[];

  /**
   * Describes informations of dataMounts on this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  dataMounts?: ComputeInstanceDataMount[];

  /**
   * ComputeInstance version.
   */
  @visibility(Lifecycle.Read)
  versions?: ComputeInstanceVersion;
}

/**
 * Specifies policy and settings for SSH access.
 */
model ComputeInstanceSshSettings {
  /**
   * State of the public SSH port. Possible values are: Disabled - Indicates that the public ssh port is closed on this instance. Enabled - Indicates that the public ssh port is open and accessible according to the VNet/subnet policy if applicable.
   */
  sshPublicAccess?: SshPublicAccess = SshPublicAccess.Disabled;

  /**
   * Describes the admin user name.
   */
  @visibility(Lifecycle.Read)
  adminUserName?: string;

  /**
   * Describes the port for connecting through SSH.
   */
  @visibility(Lifecycle.Read)
  sshPort?: int32;

  /**
   * Specifies the SSH rsa public key file as a string. Use "ssh-keygen -t rsa -b 2048" to generate your SSH key pairs.
   */
  adminPublicKey?: string;
}

/**
 * Defines all connectivity endpoints and properties for an ComputeInstance.
 */
model ComputeInstanceConnectivityEndpoints {
  /**
   * Public IP Address of this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  publicIpAddress?: string;

  /**
   * Private IP Address of this ComputeInstance (local to the VNET in which the compute instance is deployed).
   */
  @visibility(Lifecycle.Read)
  privateIpAddress?: string;
}

/**
 * Defines an Aml Instance application and its connectivity endpoint URI.
 */
model ComputeInstanceApplication {
  /**
   * Name of the ComputeInstance application.
   */
  displayName?: string;

  /**
   * Application' endpoint URI.
   */
  endpointUri?: string;
}

/**
 * Describes information on user who created this ComputeInstance.
 */
model ComputeInstanceCreatedBy {
  /**
   * Name of the user.
   */
  @visibility(Lifecycle.Read)
  userName?: string;

  /**
   * Uniquely identifies user' Azure Active Directory organization.
   */
  @visibility(Lifecycle.Read)
  userOrgId?: string;

  /**
   * Uniquely identifies the user within his/her organization.
   */
  @visibility(Lifecycle.Read)
  userId?: string;
}

/**
 * Settings for a personal compute instance.
 */
model PersonalComputeInstanceSettings {
  /**
   * A user explicitly assigned to a personal compute instance.
   */
  assignedUser?: AssignedUser;
}

/**
 * A user that can be assigned to a compute instance.
 */
model AssignedUser {
  /**
   * User’s AAD Object Id.
   */
  objectId: string;

  /**
   * User’s AAD Tenant Id.
   */
  tenantId: string;
}

/**
 * Details of customized scripts to execute for setting up the cluster.
 */
model SetupScripts {
  /**
   * Customized setup scripts
   */
  scripts?: ScriptsToExecute;
}

/**
 * Customized setup scripts
 */
model ScriptsToExecute {
  /**
   * Script that's run every time the machine starts.
   */
  startupScript?: ScriptReference;

  /**
   * Script that's run only once during provision of the compute.
   */
  creationScript?: ScriptReference;
}

/**
 * Script reference
 */
model ScriptReference {
  /**
   * The storage source of the script: inline, workspace.
   */
  scriptSource?: string;

  /**
   * The location of scripts in the mounted volume.
   */
  scriptData?: string;

  /**
   * Optional command line arguments passed to the script to run.
   */
  scriptArguments?: string;

  /**
   * Optional time period passed to timeout command.
   */
  timeout?: string;
}

/**
 * The last operation on ComputeInstance.
 */
model ComputeInstanceLastOperation {
  /**
   * Name of the last operation.
   */
  operationName?: OperationName;

  /**
   * Time of the last operation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  operationTime?: utcDateTime;

  /**
   * Operation status.
   */
  operationStatus?: OperationStatus;

  /**
   * Trigger of operation.
   */
  operationTrigger?: OperationTrigger;
}

/**
 * The list of schedules to be applied on the computes
 */
model ComputeSchedules {
  /**
   * The list of compute start stop schedules to be applied.
   */
  computeStartStop?: ComputeStartStopSchedule[];
}

/**
 * Compute start stop schedule properties
 */
model ComputeStartStopSchedule {
  /**
   * Schedule id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The current deployment state of schedule.
   */
  @visibility(Lifecycle.Read)
  provisioningStatus?: ProvisioningStatus;

  /**
   * The compute power action.
   */
  action?: ComputePowerAction;

  /**
   * Base definition of a schedule
   */
  schedule?: ScheduleBase;
}

/**
 * Defines an Aml Instance container.
 */
model ComputeInstanceContainer {
  /**
   * Name of the ComputeInstance container.
   */
  name?: string;

  /**
   * Auto save settings.
   */
  autosave?: Autosave;

  /**
   * Information of GPU.
   */
  gpu?: string;

  /**
   * network of this container.
   */
  network?: Network;

  /**
   * Environment information of this container.
   */
  environment?: ComputeInstanceEnvironmentInfo;

  /**
   * services of this containers.
   */
  @visibility(Lifecycle.Read)
  services?: unknown[];
}

/**
 * Environment information
 */
model ComputeInstanceEnvironmentInfo {
  /**
   * name of environment.
   */
  name?: string;

  /**
   * version of environment.
   */
  version?: string;
}

/**
 * Defines an Aml Instance DataDisk.
 */
model ComputeInstanceDataDisk {
  /**
   * Caching type of Data Disk.
   */
  caching?: Caching;

  /**
   * The initial disk size in gigabytes.
   */
  diskSizeGB?: int32;

  /**
   * The lun is used to uniquely identify each data disk. If attaching multiple disks, each should have a distinct lun.
   */
  lun?: int32;

  /**
   * type of this storage account.
   */
  storageAccountType?: StorageAccountType = StorageAccountType.Standard_LRS;
}

/**
 * Defines an Aml Instance DataMount.
 */
model ComputeInstanceDataMount {
  /**
   * Source of the ComputeInstance data mount.
   */
  source?: string;

  /**
   * Data source type.
   */
  sourceType?: SourceType;

  /**
   * name of the ComputeInstance data mount.
   */
  mountName?: string;

  /**
   * Mount Action.
   */
  mountAction?: MountAction;

  /**
   * who this data mount created by.
   */
  createdBy?: string;

  /**
   * Path of this data mount.
   */
  mountPath?: string;

  /**
   * Mount state.
   */
  mountState?: MountState;

  /**
   * The time when the disk mounted.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  mountedOn?: utcDateTime;

  /**
   * Error of this data mount.
   */
  error?: string;
}

/**
 * Version of computeInstance.
 */
model ComputeInstanceVersion {
  /**
   * Runtime of compute instance.
   */
  runtime?: string;
}

/**
 * An Azure Machine Learning compute instance.
 */
model ComputeInstance extends Compute {
  ...ComputeInstanceSchema;

  /**
   * The type of compute
   */
  computeType: "ComputeInstance";
}

/**
 * Properties(top level) of ComputeInstance
 */
model ComputeInstanceSchema {
  /**
   * Properties of ComputeInstance
   */
  properties?: ComputeInstanceProperties;
}

/**
 * A Machine Learning compute based on Azure Virtual Machines.
 */
model VirtualMachine extends Compute {
  ...VirtualMachineSchema;

  /**
   * The type of compute
   */
  computeType: "VirtualMachine";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model VirtualMachineSchema {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: VirtualMachineSchemaProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model VirtualMachineSchemaProperties {
  /**
   * Virtual Machine size
   */
  virtualMachineSize?: string;

  /**
   * Port open for ssh connections.
   */
  sshPort?: int32;

  /**
   * Notebook server port open for ssh connections.
   */
  notebookServerPort?: int32;

  /**
   * Public IP address of the virtual machine.
   */
  address?: string;

  /**
   * Admin credentials for virtual machine
   */
  administratorAccount?: VirtualMachineSshCredentials;

  /**
   * Indicates whether this compute will be used for running notebooks.
   */
  isNotebookInstanceCompute?: boolean;
}

/**
 * Admin credentials for virtual machine
 */
model VirtualMachineSshCredentials {
  /**
   * Username of admin account
   */
  username?: string;

  /**
   * Password of admin account
   */
  password?: string;

  /**
   * Public key data
   */
  publicKeyData?: string;

  /**
   * Private key data
   */
  privateKeyData?: string;
}

/**
 * HDInsight compute properties
 */
model HDInsightProperties {
  /**
   * Port open for ssh connections on the master node of the cluster.
   */
  sshPort?: int32;

  /**
   * Public IP address of the master node of the cluster.
   */
  address?: string;

  /**
   * Admin credentials for master node of the cluster
   */
  administratorAccount?: VirtualMachineSshCredentials;
}

/**
 * A HDInsight compute.
 */
model HDInsight extends Compute {
  ...HDInsightSchema;

  /**
   * The type of compute
   */
  computeType: "HDInsight";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model HDInsightSchema {
  /**
   * HDInsight compute properties
   */
  properties?: HDInsightProperties;
}

/**
 * A DataFactory compute.
 */
model DataFactory extends Compute {
  /**
   * The type of compute
   */
  computeType: "DataFactory";
}

/**
 * Properties of Databricks
 */
model DatabricksProperties {
  /**
   * Databricks access token
   */
  databricksAccessToken?: string;

  /**
   * Workspace Url
   */
  workspaceUrl?: string;
}

/**
 * A DataFactory compute.
 */
model Databricks extends Compute {
  ...DatabricksSchema;

  /**
   * The type of compute
   */
  computeType: "Databricks";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DatabricksSchema {
  /**
   * Properties of Databricks
   */
  properties?: DatabricksProperties;
}

/**
 * A DataLakeAnalytics compute.
 */
model DataLakeAnalytics extends Compute {
  ...DataLakeAnalyticsSchema;

  /**
   * The type of compute
   */
  computeType: "DataLakeAnalytics";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DataLakeAnalyticsSchema {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: DataLakeAnalyticsSchemaProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DataLakeAnalyticsSchemaProperties {
  /**
   * DataLake Store Account Name
   */
  dataLakeStoreAccountName?: string;
}

/**
 * A SynapseSpark compute.
 */
model SynapseSpark extends Compute {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: SynapseSparkProperties;

  /**
   * The type of compute
   */
  computeType: "SynapseSpark";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SynapseSparkProperties {
  /**
   * Auto scale properties.
   */
  autoScaleProperties?: AutoScaleProperties;

  /**
   * Auto pause properties.
   */
  autoPauseProperties?: AutoPauseProperties;

  /**
   * Spark version.
   */
  sparkVersion?: string;

  /**
   * The number of compute nodes currently assigned to the compute.
   */
  nodeCount?: int32;

  /**
   * Node size.
   */
  nodeSize?: string;

  /**
   * Node size family.
   */
  nodeSizeFamily?: string;

  /**
   * Azure subscription identifier.
   */
  subscriptionId?: string;

  /**
   * Name of the resource group in which workspace is located.
   */
  resourceGroup?: string;

  /**
   * Name of Azure Machine Learning workspace.
   */
  workspaceName?: string;

  /**
   * Pool name.
   */
  poolName?: string;
}

/**
 * Auto scale properties
 */
model AutoScaleProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  minNodeCount?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  enabled?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  maxNodeCount?: int32;
}

/**
 * Auto pause properties
 */
model AutoPauseProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  delayInMinutes?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  enabled?: boolean;
}

/**
 * Properties of AksComputeSecrets
 */
model AksComputeSecretsProperties {
  /**
   * Content of kubeconfig file that can be used to connect to the Kubernetes cluster.
   */
  userKubeConfig?: string;

  /**
   * Content of kubeconfig file that can be used to connect to the Kubernetes cluster.
   */
  adminKubeConfig?: string;

  /**
   * Image registry pull secret.
   */
  imagePullSecretName?: string;
}

/**
 * Secrets related to a Machine Learning compute based on AKS.
 */
model AksComputeSecrets extends ComputeSecrets {
  ...AksComputeSecretsProperties;

  /**
   * The type of compute
   */
  computeType: "AKS";
}

/**
 * Secrets related to a Machine Learning compute based on AKS.
 */
model VirtualMachineSecrets extends ComputeSecrets {
  ...VirtualMachineSecretsSchema;

  /**
   * The type of compute
   */
  computeType: "VirtualMachine";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model VirtualMachineSecretsSchema {
  /**
   * Admin credentials for virtual machine.
   */
  administratorAccount?: VirtualMachineSshCredentials;
}

/**
 * Properties of Databricks Compute Secrets
 */
model DatabricksComputeSecretsProperties {
  /**
   * access token for databricks account.
   */
  databricksAccessToken?: string;
}

/**
 * Secrets related to a Machine Learning compute based on Databricks.
 */
model DatabricksComputeSecrets extends ComputeSecrets {
  ...DatabricksComputeSecretsProperties;

  /**
   * The type of compute
   */
  computeType: "Databricks";
}

/**
 * Account key datastore credentials configuration.
 */
model AccountKeyDatastoreCredentials extends DatastoreCredentials {
  /**
   * [Required] Storage account secrets.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  secrets: AccountKeyDatastoreSecrets;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialsType: "AccountKey";
}

/**
 * Datastore account key secrets.
 */
model AccountKeyDatastoreSecrets extends DatastoreSecrets {
  /**
   * Storage account key.
   */
  key?: string;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  secretsType: "AccountKey";
}

/**
 * AML Token identity configuration.
 */
model AmlToken extends IdentityConfiguration {
  /**
   * [Required] Specifies the type of identity framework.
   */
  identityType: "AMLToken";
}

/**
 * Asset input type.
 */
model AssetJobInput {
  /**
   * Input Asset Delivery Mode.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode?: InputDeliveryMode;

  /**
   * [Required] Input Asset URI.
   */
  @pattern("[a-zA-Z0-9_]")
  uri: string;
}

/**
 * Asset output type.
 */
model AssetJobOutput {
  /**
   * Output Asset Delivery Mode.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode?: OutputDeliveryMode;

  /**
   * Output Asset URI.
   */
  uri?: string;
}

/**
 * Forecast horizon determined automatically by system.
 */
model AutoForecastHorizon extends ForecastHorizon {
  /**
   * [Required] Set forecast horizon value selection mode.
   */
  mode: "Auto";
}

/**
 * The desired maximum forecast horizon in units of time-series frequency.
 */
@discriminator("mode")
model ForecastHorizon {
  /**
   * [Required] Set forecast horizon value selection mode.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode: ForecastHorizonMode;
}

/**
 * AutoMLJob class.
 * Use this class for executing AutoML tasks like Classification/Regression etc.
 * See TaskType enum for all the tasks supported.
 */
model AutoMLJob extends JobBaseDetails {
  /**
   * The ARM resource ID of the Environment specification for the job.
   * This is optional value to provide, if not provided, AutoML will default this to Production AutoML curated environment version when running the job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  environmentId?: string;

  /**
   * Environment variables included in the job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  environmentVariables?: Record<string>;

  /**
   * Mapping of output data bindings used in the job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outputs?: Record<JobOutput>;

  /**
   * Compute Resource configuration for the job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resources?: ResourceConfiguration;

  /**
   * [Required] This represents scenario which can be one of Tables/NLP/Image
   */
  taskDetails: AutoMLVertical;

  /**
   * [Required] Specifies the type of job.
   */
  jobType: "AutoML";
}

/**
 * Job output definition container information on where to find job output/logs.
 */
@discriminator("jobOutputType")
model JobOutput {
  /**
   * Description for the output.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  description?: string;

  /**
   * [Required] Specifies the type of job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobOutputType: JobOutputType;
}

/**
 * AutoML vertical class.
 * Base class for AutoML verticals - TableVertical/ImageVertical/NLPVertical
 */
@discriminator("taskType")
model AutoMLVertical {
  /**
   * Log verbosity for the job.
   */
  logVerbosity?: LogVerbosity;

  /**
   * [Required] Task type for AutoMLJob.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  taskType: TaskType;
}

/**
 * N-Cross validations determined automatically.
 */
model AutoNCrossValidations extends NCrossValidations {
  /**
   * [Required] Mode for determining N-Cross validations.
   */
  mode: "Auto";
}

/**
 * N-Cross validations value.
 */
@discriminator("mode")
model NCrossValidations {
  /**
   * [Required] Mode for determining N-Cross validations.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode: NCrossValidationsMode;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AutoSeasonality extends Seasonality {
  /**
   * [Required] Seasonality mode.
   */
  mode: "Auto";
}

/**
 * Forecasting seasonality.
 */
@discriminator("mode")
model Seasonality {
  /**
   * [Required] Seasonality mode.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode: SeasonalityMode;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AutoTargetLags extends TargetLags {
  /**
   * [Required] Set target lags mode - Auto/Custom
   */
  mode: "Auto";
}

/**
 * The number of past periods to lag from the target column.
 */
@discriminator("mode")
model TargetLags {
  /**
   * [Required] Set target lags mode - Auto/Custom
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode: TargetLagsMode;
}

/**
 * Target lags rolling window determined automatically.
 */
model AutoTargetRollingWindowSize extends TargetRollingWindowSize {
  /**
   * [Required] TargetRollingWindowSiz detection mode.
   */
  mode: "Auto";
}

/**
 * Forecasting target rolling window size.
 */
@discriminator("mode")
model TargetRollingWindowSize {
  /**
   * [Required] TargetRollingWindowSiz detection mode.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode: TargetRollingWindowSizeMode;
}

/**
 * Azure Blob datastore configuration.
 */
model AzureBlobDatastore extends DatastoreDetails {
  /**
   * Storage account name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  accountName?: string;

  /**
   * Storage account container name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  containerName?: string;

  /**
   * Azure cloud endpoint for the storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpoint?: string;

  /**
   * Protocol used to communicate with the storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  protocol?: string;

  /**
   * Indicates which identity to use to authenticate service data access to customer's storage.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceDataAccessAuthIdentity?: ServiceDataAccessAuthIdentity;

  /**
   * [Required] Storage type backing the datastore.
   */
  datastoreType: "AzureBlob";
}

/**
 * Azure Data Lake Gen1 datastore configuration.
 */
model AzureDataLakeGen1Datastore extends DatastoreDetails {
  /**
   * Indicates which identity to use to authenticate service data access to customer's storage.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceDataAccessAuthIdentity?: ServiceDataAccessAuthIdentity;

  /**
   * [Required] Azure Data Lake store name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  storeName: string;

  /**
   * [Required] Storage type backing the datastore.
   */
  datastoreType: "AzureDataLakeGen1";
}

/**
 * Azure Data Lake Gen2 datastore configuration.
 */
model AzureDataLakeGen2Datastore extends DatastoreDetails {
  /**
   * [Required] Storage account name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  accountName: string;

  /**
   * Azure cloud endpoint for the storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpoint?: string;

  /**
   * [Required] The name of the Data Lake Gen2 filesystem.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  filesystem: string;

  /**
   * Protocol used to communicate with the storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  protocol?: string;

  /**
   * Indicates which identity to use to authenticate service data access to customer's storage.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceDataAccessAuthIdentity?: ServiceDataAccessAuthIdentity;

  /**
   * [Required] Storage type backing the datastore.
   */
  datastoreType: "AzureDataLakeGen2";
}

/**
 * Azure File datastore configuration.
 */
model AzureFileDatastore extends DatastoreDetails {
  /**
   * [Required] Storage account name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  accountName: string;

  /**
   * Azure cloud endpoint for the storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpoint?: string;

  /**
   * [Required] The name of the Azure file share that the datastore points to.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  fileShareName: string;

  /**
   * Protocol used to communicate with the storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  protocol?: string;

  /**
   * Indicates which identity to use to authenticate service data access to customer's storage.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceDataAccessAuthIdentity?: ServiceDataAccessAuthIdentity;

  /**
   * [Required] Storage type backing the datastore.
   */
  datastoreType: "AzureFile";
}

/**
 * Defines an early termination policy based on slack criteria, and a frequency and delay interval for evaluation
 */
model BanditPolicy extends EarlyTerminationPolicy {
  /**
   * Absolute distance allowed from the best performing run.
   */
  slackAmount?: float32;

  /**
   * Ratio of the allowed distance from the best performing run.
   */
  slackFactor?: float32;

  /**
   * [Required] Name of policy configuration
   */
  policyType: "Bandit";
}

/**
 * Early termination policies enable canceling poor-performing runs before they complete
 */
@discriminator("policyType")
model EarlyTerminationPolicy {
  /**
   * Number of intervals by which to delay the first evaluation.
   */
  delayEvaluation?: int32;

  /**
   * Interval (number of runs) between policy evaluations.
   */
  evaluationInterval?: int32;

  /**
   * [Required] Name of policy configuration
   */
  policyType: EarlyTerminationPolicyType;
}

/**
 * Defines a Sampling Algorithm that generates values based on previous values
 */
model BayesianSamplingAlgorithm extends SamplingAlgorithm {
  /**
   * [Required] The algorithm used for generating hyperparameter values, along with configuration properties
   */
  samplingAlgorithmType: "Bayesian";
}

/**
 * The Sampling Algorithm used to generate hyperparameter values, along with properties to
 * configure the algorithm
 */
@discriminator("samplingAlgorithmType")
model SamplingAlgorithm {
  /**
   * [Required] The algorithm used for generating hyperparameter values, along with configuration properties
   */
  samplingAlgorithmType: SamplingAlgorithmType;
}

/**
 * Certificate datastore credentials configuration.
 */
model CertificateDatastoreCredentials extends DatastoreCredentials {
  /**
   * Authority URL used for authentication.
   */
  authorityUrl?: string;

  /**
   * [Required] Service principal client ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  clientId: string;

  /**
   * Resource the service principal has access to.
   */
  resourceUrl?: string;

  /**
   * [Required] Service principal secrets.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  secrets: CertificateDatastoreSecrets;

  /**
   * [Required] ID of the tenant to which the service principal belongs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  tenantId: string;

  /**
   * [Required] Thumbprint of the certificate used for authentication.
   */
  @pattern("[a-zA-Z0-9_]")
  thumbprint: string;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialsType: "Certificate";
}

/**
 * Datastore certificate secrets.
 */
model CertificateDatastoreSecrets extends DatastoreSecrets {
  /**
   * Service principal certificate.
   */
  certificate?: string;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  secretsType: "Certificate";
}

/**
 * Classification task in AutoML Table vertical.
 */
model Classification extends AutoMLVertical {
  ...TableVertical;

  /**
   * Allowed models for classification task.
   */
  allowedModels?: ClassificationModels[];

  /**
   * Blocked models for classification task.
   */
  blockedModels?: ClassificationModels[];

  /**
   * Primary metric for the task.
   */
  primaryMetric?: ClassificationPrimaryMetrics;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "Classification";
}

/**
 * Abstract class for AutoML tasks that use table dataset as input - such as Classification/Regression/Forecasting.
 */
model TableVertical {
  /**
   * Data inputs for AutoMLJob.
   */
  dataSettings?: TableVerticalDataSettings;

  /**
   * Featurization inputs needed for AutoML job.
   */
  featurizationSettings?: TableVerticalFeaturizationSettings;

  /**
   * Execution constraints for AutoMLJob.
   */
  limitSettings?: TableVerticalLimitSettings;

  /**
   * Inputs for training phase for an AutoML Job.
   */
  trainingSettings?: TrainingSettings;
}

/**
 * Class for data inputs.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model TableVerticalDataSettings extends DataSettings {
  /**
   * Validation data inputs.
   */
  validationData?: TableVerticalValidationDataSettings;

  /**
   * The name of the sample weight column. Automated ML supports a weighted column as an input, causing rows in the data to be weighted up or down.
   */
  weightColumnName?: string;
}

/**
 * Validation settings for AutoML Table vertical tasks - Classification/Regression/Forecasting.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model TableVerticalValidationDataSettings extends ValidationDataSettings {
  /**
   * Columns to use for CVSplit data.
   */
  cvSplitColumnNames?: string[];

  /**
   * Number of cross validation folds to be applied on training dataset
   * when validation dataset is not provided.
   */
  nCrossValidations?: NCrossValidations;
}

/**
 * Validation settings.
 */
model ValidationDataSettings {
  /**
   * Validation data MLTable.
   */
  data?: MLTableJobInput;

  /**
   * The fraction of training dataset that needs to be set aside for validation purpose.
   * Values between (0.0 , 1.0)
   * Applied when validation dataset is not provided.
   */
  validationDataSize?: float64;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model MLTableJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "MLTable";
}

/**
 * Command job definition.
 */
@discriminator("jobInputType")
model JobInput {
  /**
   * Description for the input.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  description?: string;

  /**
   * [Required] Specifies the type of job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobInputType: JobInputType;
}

/**
 * Collection of registered Tabular Dataset Ids and other data settings required for training and validating models.
 */
model DataSettings {
  /**
   * [Required] Target column name: This is prediction values column.
   * Also known as label column name in context of classification tasks.
   */
  @pattern("[a-zA-Z0-9_]")
  targetColumnName: string;

  /**
   * Test data input.
   */
  testData?: TestDataSettings;

  /**
   * [Required] Training data input.
   */
  trainingData: TrainingDataSettings;
}

/**
 * Test data inputs.
 */
model TestDataSettings {
  /**
   * Test data MLTable.
   */
  data?: MLTableJobInput;

  /**
   * The fraction of test dataset that needs to be set aside for validation purpose.
   * Values between (0.0 , 1.0)
   * Applied when validation dataset is not provided.
   */
  testDataSize?: float64;
}

/**
 * Training data input.
 */
model TrainingDataSettings {
  /**
   * [Required] Training data MLTable.
   */
  data: MLTableJobInput;
}

/**
 * Featurization Configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model TableVerticalFeaturizationSettings extends FeaturizationSettings {
  /**
   * These transformers shall not be used in featurization.
   */
  blockedTransformers?: string[];

  /**
   * Dictionary of column name and its type (int, float, string, datetime etc).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  columnNameAndTypes?: Record<string>;

  /**
   * Columns to be dropped from data during featurization.
   */
  dropColumns?: string[];

  /**
   * Determines whether to use Dnn based featurizers for data featurization.
   */
  enableDnnFeaturization?: boolean;

  /**
   * Featurization mode - User can keep the default 'Auto' mode and AutoML will take care of necessary transformation of the data in featurization phase.
   * If 'Off' is selected then no featurization is done.
   * If 'Custom' is selected then user can specify additional inputs to customize how featurization is done.
   */
  mode?: FeaturizationMode;

  /**
   * User can specify additional transformers to be used along with the columns to which it would be applied and parameters for the transformer constructor.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  transformerParams?: Record<ColumnTransformer[]>;
}

/**
 * Column transformer parameters.
 */
model ColumnTransformer {
  /**
   * Fields to apply transformer logic on.
   */
  fields?: string[];

  /**
   * Different properties to be passed to transformer.
   * Input expected is dictionary of key,value pairs in JSON format.
   */
  parameters?: unknown;
}

/**
 * Featurization Configuration.
 */
model FeaturizationSettings {
  /**
   * Dataset language, useful for the text data.
   */
  datasetLanguage?: string;
}

/**
 * Job execution constraints.
 */
model TableVerticalLimitSettings {
  /**
   * Enable early termination, determines whether or not if AutoMLJob will terminate early if there is no score improvement in last 20 iterations.
   */
  enableEarlyTermination?: boolean = true;

  /**
   * Exit score for the AutoML job.
   */
  exitScore?: float64;

  /**
   * Maximum Concurrent iterations.
   */
  maxConcurrentTrials?: int32 = 1;

  /**
   * Max cores per iteration.
   */
  maxCoresPerTrial?: int32 = -1;

  /**
   * Number of iterations.
   */
  maxTrials?: int32 = 1000;

  /**
   * AutoML job timeout.
   */
  timeout?: duration;

  /**
   * Iteration timeout.
   */
  trialTimeout?: duration;
}

/**
 * Training related configuration.
 */
model TrainingSettings {
  /**
   * Enable recommendation of DNN models.
   */
  enableDnnTraining?: boolean;

  /**
   * Flag to turn on explainability on best model.
   */
  enableModelExplainability?: boolean;

  /**
   * Flag for enabling onnx compatible models.
   */
  enableOnnxCompatibleModels?: boolean;

  /**
   * Enable stack ensemble run.
   */
  enableStackEnsemble?: boolean = true;

  /**
   * Enable voting ensemble run.
   */
  enableVoteEnsemble?: boolean = true;

  /**
   * During VotingEnsemble and StackEnsemble model generation, multiple fitted models from the previous child runs are downloaded.
   * Configure this parameter with a higher value than 300 secs, if more time is needed.
   */
  ensembleModelDownloadTimeout?: duration;

  /**
   * Stack ensemble settings for stack ensemble run.
   */
  stackEnsembleSettings?: StackEnsembleSettings;
}

/**
 * Advances setting to customize StackEnsemble run.
 */
model StackEnsembleSettings {
  /**
   * Optional parameters to pass to the initializer of the meta-learner.
   */
  stackMetaLearnerKWargs?: unknown;

  /**
   * Specifies the proportion of the training set (when choosing train and validation type of training) to be reserved for training the meta-learner. Default value is 0.2.
   */
  stackMetaLearnerTrainPercentage?: float64 = 0.2;

  /**
   * The meta-learner is a model trained on the output of the individual heterogeneous models.
   */
  stackMetaLearnerType?: StackMetaLearnerType;
}

/**
 * Command job definition.
 */
model CommandJob extends JobBaseDetails {
  /**
   * ARM resource ID of the code asset.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  codeId?: string;

  /**
   * [Required] The command to execute on startup of the job. eg. "python train.py"
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  command: string;

  /**
   * Distribution configuration of the job. If set, this should be one of Mpi, Tensorflow, PyTorch, or null.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  distribution?: DistributionConfiguration;

  /**
   * [Required] The ARM resource ID of the Environment specification for the job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  environmentId: string;

  /**
   * Environment variables included in the job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  environmentVariables?: Record<string>;

  /**
   * Mapping of input data bindings used in the job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inputs?: Record<JobInput>;

  /**
   * Command Job limit.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  limits?: CommandJobLimits;

  /**
   * Mapping of output data bindings used in the job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outputs?: Record<JobOutput>;

  /**
   * Input parameters.
   */
  @visibility(Lifecycle.Read)
  parameters?: unknown;

  /**
   * Compute Resource configuration for the job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resources?: ResourceConfiguration;

  /**
   * [Required] Specifies the type of job.
   */
  jobType: "Command";
}

/**
 * Base definition for job distribution configuration.
 */
@discriminator("distributionType")
model DistributionConfiguration {
  /**
   * [Required] Specifies the type of distribution framework.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  distributionType: DistributionType;
}

/**
 * Command Job limit class.
 */
model CommandJobLimits extends JobLimits {
  /**
   * [Required] JobLimit type.
   */
  jobLimitsType: "Command";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@discriminator("jobLimitsType")
model JobLimits {
  /**
   * [Required] JobLimit type.
   */
  jobLimitsType: JobLimitsType;

  /**
   * The max run duration in ISO 8601 format, after which the job will be cancelled. Only supports duration with precision as low as Seconds.
   */
  timeout?: duration;
}

/**
 * Resource requirements for each container instance within an online deployment.
 */
model ContainerResourceRequirements {
  /**
   * Container resource limit info:
   */
  containerResourceLimits?: ContainerResourceSettings;

  /**
   * Container resource request info:
   */
  containerResourceRequests?: ContainerResourceSettings;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ContainerResourceSettings {
  /**
   * Number of vCPUs request/limit for container. More info:
   * https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
   */
  cpu?: string;

  /**
   * Number of Nvidia GPU cards request/limit for container. More info:
   * https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
   */
  gpu?: string;

  /**
   * Memory size request/limit for container. More info:
   * https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
   */
  memory?: string;
}

/**
 * Cron schedule definition
 */
model CronSchedule extends ScheduleBase {
  /**
   * [Required] Specifies cron expression of schedule.
   * The expression should follow NCronTab format.
   */
  @pattern("[a-zA-Z0-9_]")
  expression: string;

  /**
   * [Required] Specifies the schedule type
   */
  scheduleType: "Cron";
}

/**
 * The desired maximum forecast horizon in units of time-series frequency.
 */
model CustomForecastHorizon extends ForecastHorizon {
  /**
   * [Required] Forecast horizon value.
   */
  value: int32;

  /**
   * [Required] Set forecast horizon value selection mode.
   */
  mode: "Custom";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CustomModelJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "CustomModel";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CustomModelJobOutput extends JobOutput {
  ...AssetJobOutput;

  /**
   * [Required] Specifies the type of job.
   */
  jobOutputType: "CustomModel";
}

/**
 * N-Cross validations are specified by user.
 */
model CustomNCrossValidations extends NCrossValidations {
  /**
   * [Required] N-Cross validations value.
   */
  value: int32;

  /**
   * [Required] Mode for determining N-Cross validations.
   */
  mode: "Custom";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CustomSeasonality extends Seasonality {
  /**
   * [Required] Seasonality value.
   */
  value: int32;

  /**
   * [Required] Seasonality mode.
   */
  mode: "Custom";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CustomTargetLags extends TargetLags {
  /**
   * [Required] Set target lags values.
   */
  values: int32[];

  /**
   * [Required] Set target lags mode - Auto/Custom
   */
  mode: "Custom";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CustomTargetRollingWindowSize extends TargetRollingWindowSize {
  /**
   * [Required] TargetRollingWindowSize value.
   */
  value: int32;

  /**
   * [Required] TargetRollingWindowSiz detection mode.
   */
  mode: "Custom";
}

/**
 * Reference to an asset via its path in a datastore.
 */
model DataPathAssetReference extends AssetReferenceBase {
  /**
   * ARM resource ID of the datastore where the asset is located.
   */
  datastoreId?: string;

  /**
   * The path of the file/directory in the datastore.
   */
  path?: string;

  /**
   * [Required] Specifies the type of asset reference.
   */
  referenceType: "DataPath";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DefaultScaleSettings extends OnlineScaleSettings {
  /**
   * [Required] Type of deployment scaling algorithm
   */
  scaleType: "Default";
}

/**
 * Forecasting task in AutoML Table vertical.
 */
model Forecasting extends AutoMLVertical {
  ...TableVertical;

  /**
   * Allowed models for forecasting task.
   */
  allowedModels?: ForecastingModels[];

  /**
   * Blocked models for forecasting task.
   */
  blockedModels?: ForecastingModels[];

  /**
   * Forecasting task specific inputs.
   */
  forecastingSettings?: ForecastingSettings;

  /**
   * Primary metric for forecasting task.
   */
  primaryMetric?: ForecastingPrimaryMetrics;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "Forecasting";
}

/**
 * Forecasting specific parameters.
 */
model ForecastingSettings {
  /**
   * Country or region for holidays for forecasting tasks.
   * These should be ISO 3166 two-letter country/region codes, for example 'US' or 'GB'.
   */
  countryOrRegionForHolidays?: string;

  /**
   * Number of periods between the origin time of one CV fold and the next fold. For
   * example, if `CVStepSize` = 3 for daily data, the origin time for each fold will be
   * three days apart.
   */
  cvStepSize?: int32;

  /**
   * Flag for generating lags for the numeric features with 'auto' or null.
   */
  featureLags?: FeatureLags;

  /**
   * The desired maximum forecast horizon in units of time-series frequency.
   */
  forecastHorizon?: ForecastHorizon;

  /**
   * When forecasting, this parameter represents the period with which the forecast is desired, for example daily, weekly, yearly, etc. The forecast frequency is dataset frequency by default.
   */
  frequency?: string;

  /**
   * Set time series seasonality as an integer multiple of the series frequency.
   * If seasonality is set to 'auto', it will be inferred.
   */
  seasonality?: Seasonality;

  /**
   * The parameter defining how if AutoML should handle short time series.
   */
  shortSeriesHandlingConfig?: ShortSeriesHandlingConfiguration;

  /**
   * The function to be used to aggregate the time series target column to conform to a user specified frequency.
   * If the TargetAggregateFunction is set i.e. not 'None', but the freq parameter is not set, the error is raised. The possible target aggregation functions are: "sum", "max", "min" and "mean".
   */
  targetAggregateFunction?: TargetAggregationFunction;

  /**
   * The number of past periods to lag from the target column.
   */
  targetLags?: TargetLags;

  /**
   * The number of past periods used to create a rolling window average of the target column.
   */
  targetRollingWindowSize?: TargetRollingWindowSize;

  /**
   * The name of the time column. This parameter is required when forecasting to specify the datetime column in the input data used for building the time series and inferring its frequency.
   */
  timeColumnName?: string;

  /**
   * The names of columns used to group a timeseries. It can be used to create multiple series.
   * If grain is not defined, the data set is assumed to be one time-series. This parameter is used with task type forecasting.
   */
  timeSeriesIdColumnNames?: string[];

  /**
   * Configure STL Decomposition of the time-series target column.
   */
  useStl?: UseStl;
}

/**
 * Defines a Sampling Algorithm that exhaustively generates every value combination in the space
 */
model GridSamplingAlgorithm extends SamplingAlgorithm {
  /**
   * [Required] The algorithm used for generating hyperparameter values, along with configuration properties
   */
  samplingAlgorithmType: "Grid";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model HdfsDatastore extends DatastoreDetails {
  /**
   * The TLS cert of the HDFS server. Needs to be a base64 encoded string. Required if "Https" protocol is selected.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hdfsServerCertificate?: string;

  /**
   * [Required] IP Address or DNS HostName.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  nameNodeAddress: string;

  /**
   * Protocol used to communicate with the storage account (Https/Http).
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  protocol?: string = "http";

  /**
   * [Required] Storage type backing the datastore.
   */
  datastoreType: "Hdfs";
}

/**
 * Reference to an asset via its ARM resource ID.
 */
model IdAssetReference extends AssetReferenceBase {
  /**
   * [Required] ARM resource ID of the asset.
   */
  @pattern("[a-zA-Z0-9_]")
  assetId: string;

  /**
   * [Required] Specifies the type of asset reference.
   */
  referenceType: "Id";
}

/**
 * Image Classification. Multi-class image classification is used when an image is classified with only a single label
 * from a set of classes - e.g. each image is classified as either an image of a 'cat' or a 'dog' or a 'duck'.
 */
model ImageClassification extends AutoMLVertical {
  ...ImageClassificationBase;

  /**
   * Primary metric to optimize for this task.
   */
  primaryMetric?: ClassificationPrimaryMetrics;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "ImageClassification";
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ImageClassificationBase extends ImageVertical {
  /**
   * Settings used for training the model.
   */
  modelSettings?: ImageModelSettingsClassification;

  /**
   * Search space for sampling different combinations of models and their hyperparameters.
   */
  @identifiers(#[])
  searchSpace?: ImageModelDistributionSettingsClassification[];
}

/**
 * Settings used for training the model.
 * For more information on the available settings please visit the official documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ImageModelSettingsClassification extends ImageModelSettings {
  /**
   * Image crop size that is input to the neural network for the training dataset. Must be a positive integer.
   */
  trainingCropSize?: int32;

  /**
   * Image crop size that is input to the neural network for the validation dataset. Must be a positive integer.
   */
  validationCropSize?: int32;

  /**
   * Image size to which to resize before cropping for validation dataset. Must be a positive integer.
   */
  validationResizeSize?: int32;

  /**
   * Weighted loss. The accepted values are 0 for no weighted loss.
   * 1 for weighted loss with sqrt.(class_weights). 2 for weighted loss with class_weights. Must be 0 or 1 or 2.
   */
  weightedLoss?: int32;
}

/**
 * Settings used for training the model.
 * For more information on the available settings please visit the official documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
 */
model ImageModelSettings {
  /**
   * Settings for advanced scenarios.
   */
  advancedSettings?: string;

  /**
   * Enable AMSGrad when optimizer is 'adam' or 'adamw'.
   */
  amsGradient?: boolean;

  /**
   * Settings for using Augmentations.
   */
  augmentations?: string;

  /**
   * Value of 'beta1' when optimizer is 'adam' or 'adamw'. Must be a float in the range [0, 1].
   */
  beta1?: float32;

  /**
   * Value of 'beta2' when optimizer is 'adam' or 'adamw'. Must be a float in the range [0, 1].
   */
  beta2?: float32;

  /**
   * FileDataset id for pretrained checkpoint(s) for incremental training.
   * Make sure to pass CheckpointFilename along with CheckpointDatasetId.
   */
  checkpointDatasetId?: string;

  /**
   * The pretrained checkpoint filename in FileDataset for incremental training.
   * Make sure to pass CheckpointDatasetId along with CheckpointFilename.
   */
  checkpointFilename?: string;

  /**
   * Frequency to store model checkpoints. Must be a positive integer.
   */
  checkpointFrequency?: int32;

  /**
   * The id of a previous run that has a pretrained checkpoint for incremental training.
   */
  checkpointRunId?: string;

  /**
   * Whether to use distributed training.
   */
  distributed?: boolean;

  /**
   * Enable early stopping logic during training.
   */
  earlyStopping?: boolean;

  /**
   * Minimum number of epochs or validation evaluations to wait before primary metric improvement
   * is tracked for early stopping. Must be a positive integer.
   */
  earlyStoppingDelay?: int32;

  /**
   * Minimum number of epochs or validation evaluations with no primary metric improvement before
   * the run is stopped. Must be a positive integer.
   */
  earlyStoppingPatience?: int32;

  /**
   * Enable normalization when exporting ONNX model.
   */
  enableOnnxNormalization?: boolean;

  /**
   * Frequency to evaluate validation dataset to get metric scores. Must be a positive integer.
   */
  evaluationFrequency?: int32;

  /**
   * Gradient accumulation means running a configured number of "GradAccumulationStep" steps without
   * updating the model weights while accumulating the gradients of those steps, and then using
   * the accumulated gradients to compute the weight updates. Must be a positive integer.
   */
  gradientAccumulationStep?: int32;

  /**
   * Number of layers to freeze for the model. Must be a positive integer.
   * For instance, passing 2 as value for 'seresnext' means
   * freezing layer0 and layer1. For a full list of models supported and details on layer freeze, please
   * see: https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
   */
  layersToFreeze?: int32;

  /**
   * Initial learning rate. Must be a float in the range [0, 1].
   */
  learningRate?: float32;

  /**
   * Type of learning rate scheduler. Must be 'warmup_cosine' or 'step'.
   */
  learningRateScheduler?: LearningRateScheduler;

  /**
   * Name of the model to use for training.
   * For more information on the available models please visit the official documentation:
   * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
   */
  modelName?: string;

  /**
   * Value of momentum when optimizer is 'sgd'. Must be a float in the range [0, 1].
   */
  momentum?: float32;

  /**
   * Enable nesterov when optimizer is 'sgd'.
   */
  nesterov?: boolean;

  /**
   * Number of training epochs. Must be a positive integer.
   */
  numberOfEpochs?: int32;

  /**
   * Number of data loader workers. Must be a non-negative integer.
   */
  numberOfWorkers?: int32;

  /**
   * Type of optimizer.
   */
  optimizer?: StochasticOptimizer;

  /**
   * Random seed to be used when using deterministic training.
   */
  randomSeed?: int32;

  /**
   * If validation data is not defined, this specifies the split ratio for splitting
   * train data into random train and validation subsets. Must be a float in the range [0, 1].
   */
  splitRatio?: float32;

  /**
   * Value of gamma when learning rate scheduler is 'step'. Must be a float in the range [0, 1].
   */
  stepLRGamma?: float32;

  /**
   * Value of step size when learning rate scheduler is 'step'. Must be a positive integer.
   */
  stepLRStepSize?: int32;

  /**
   * Training batch size. Must be a positive integer.
   */
  trainingBatchSize?: int32;

  /**
   * Validation batch size. Must be a positive integer.
   */
  validationBatchSize?: int32;

  /**
   * Value of cosine cycle when learning rate scheduler is 'warmup_cosine'. Must be a float in the range [0, 1].
   */
  warmupCosineLRCycles?: float32;

  /**
   * Value of warmup epochs when learning rate scheduler is 'warmup_cosine'. Must be a positive integer.
   */
  warmupCosineLRWarmupEpochs?: int32;

  /**
   * Value of weight decay when optimizer is 'sgd', 'adam', or 'adamw'. Must be a float in the range[0, 1].
   */
  weightDecay?: float32;
}

/**
 * Distribution expressions to sweep over values of model settings.
 * <example>
 * Some examples are:
 * <code>
 * ModelName = "choice('seresnext', 'resnest50')";
 * LearningRate = "uniform(0.001, 0.01)";
 * LayersToFreeze = "choice(0, 2)";
 * </code></example>
 * For more details on how to compose distribution expressions please check the documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-tune-hyperparameters
 * For more information on the available settings please visit the official documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ImageModelDistributionSettingsClassification
  extends ImageModelDistributionSettings {
  /**
   * Image crop size that is input to the neural network for the training dataset. Must be a positive integer.
   */
  trainingCropSize?: string;

  /**
   * Image crop size that is input to the neural network for the validation dataset. Must be a positive integer.
   */
  validationCropSize?: string;

  /**
   * Image size to which to resize before cropping for validation dataset. Must be a positive integer.
   */
  validationResizeSize?: string;

  /**
   * Weighted loss. The accepted values are 0 for no weighted loss.
   * 1 for weighted loss with sqrt.(class_weights). 2 for weighted loss with class_weights. Must be 0 or 1 or 2.
   */
  weightedLoss?: string;
}

/**
 * Distribution expressions to sweep over values of model settings.
 * <example>
 * Some examples are:
 * <code>
 * ModelName = "choice('seresnext', 'resnest50')";
 * LearningRate = "uniform(0.001, 0.01)";
 * LayersToFreeze = "choice(0, 2)";
 * </code></example>
 * All distributions can be specified as distribution_name(min, max) or choice(val1, val2, ..., valn)
 * where distribution name can be: uniform, quniform, loguniform, etc
 * For more details on how to compose distribution expressions please check the documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-tune-hyperparameters
 * For more information on the available settings please visit the official documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
 */
model ImageModelDistributionSettings {
  /**
   * Enable AMSGrad when optimizer is 'adam' or 'adamw'.
   */
  amsGradient?: string;

  /**
   * Settings for using Augmentations.
   */
  augmentations?: string;

  /**
   * Value of 'beta1' when optimizer is 'adam' or 'adamw'. Must be a float in the range [0, 1].
   */
  beta1?: string;

  /**
   * Value of 'beta2' when optimizer is 'adam' or 'adamw'. Must be a float in the range [0, 1].
   */
  beta2?: string;

  /**
   * Whether to use distributer training.
   */
  distributed?: string;

  /**
   * Enable early stopping logic during training.
   */
  earlyStopping?: string;

  /**
   * Minimum number of epochs or validation evaluations to wait before primary metric improvement
   * is tracked for early stopping. Must be a positive integer.
   */
  earlyStoppingDelay?: string;

  /**
   * Minimum number of epochs or validation evaluations with no primary metric improvement before
   * the run is stopped. Must be a positive integer.
   */
  earlyStoppingPatience?: string;

  /**
   * Enable normalization when exporting ONNX model.
   */
  enableOnnxNormalization?: string;

  /**
   * Frequency to evaluate validation dataset to get metric scores. Must be a positive integer.
   */
  evaluationFrequency?: string;

  /**
   * Gradient accumulation means running a configured number of "GradAccumulationStep" steps without
   * updating the model weights while accumulating the gradients of those steps, and then using
   * the accumulated gradients to compute the weight updates. Must be a positive integer.
   */
  gradientAccumulationStep?: string;

  /**
   * Number of layers to freeze for the model. Must be a positive integer.
   * For instance, passing 2 as value for 'seresnext' means
   * freezing layer0 and layer1. For a full list of models supported and details on layer freeze, please
   * see: https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
   */
  layersToFreeze?: string;

  /**
   * Initial learning rate. Must be a float in the range [0, 1].
   */
  learningRate?: string;

  /**
   * Type of learning rate scheduler. Must be 'warmup_cosine' or 'step'.
   */
  learningRateScheduler?: string;

  /**
   * Name of the model to use for training.
   * For more information on the available models please visit the official documentation:
   * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
   */
  modelName?: string;

  /**
   * Value of momentum when optimizer is 'sgd'. Must be a float in the range [0, 1].
   */
  momentum?: string;

  /**
   * Enable nesterov when optimizer is 'sgd'.
   */
  nesterov?: string;

  /**
   * Number of training epochs. Must be a positive integer.
   */
  numberOfEpochs?: string;

  /**
   * Number of data loader workers. Must be a non-negative integer.
   */
  numberOfWorkers?: string;

  /**
   * Type of optimizer. Must be either 'sgd', 'adam', or 'adamw'.
   */
  optimizer?: string;

  /**
   * Random seed to be used when using deterministic training.
   */
  randomSeed?: string;

  /**
   * If validation data is not defined, this specifies the split ratio for splitting
   * train data into random train and validation subsets. Must be a float in the range [0, 1].
   */
  splitRatio?: string;

  /**
   * Value of gamma when learning rate scheduler is 'step'. Must be a float in the range [0, 1].
   */
  stepLRGamma?: string;

  /**
   * Value of step size when learning rate scheduler is 'step'. Must be a positive integer.
   */
  stepLRStepSize?: string;

  /**
   * Training batch size. Must be a positive integer.
   */
  trainingBatchSize?: string;

  /**
   * Validation batch size. Must be a positive integer.
   */
  validationBatchSize?: string;

  /**
   * Value of cosine cycle when learning rate scheduler is 'warmup_cosine'. Must be a float in the range [0, 1].
   */
  warmupCosineLRCycles?: string;

  /**
   * Value of warmup epochs when learning rate scheduler is 'warmup_cosine'. Must be a positive integer.
   */
  warmupCosineLRWarmupEpochs?: string;

  /**
   * Value of weight decay when optimizer is 'sgd', 'adam', or 'adamw'. Must be a float in the range[0, 1].
   */
  weightDecay?: string;
}

/**
 * Abstract class for AutoML tasks that train image (computer vision) models -
 * such as Image Classification / Image Classification Multilabel / Image Object Detection / Image Instance Segmentation.
 */
model ImageVertical {
  /**
   * [Required] Collection of registered Tabular Dataset Ids and other data settings required for training and validating models.
   */
  dataSettings: ImageVerticalDataSettings;

  /**
   * [Required] Limit settings for the AutoML job.
   */
  limitSettings: ImageLimitSettings;

  /**
   * Model sweeping and hyperparameter sweeping related settings.
   */
  sweepSettings?: ImageSweepSettings;
}

/**
 * Collection of registered Tabular Dataset Ids and other data settings required for training and validating models.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ImageVerticalDataSettings extends DataSettings {
  /**
   * Settings for the validation dataset.
   */
  validationData?: ImageVerticalValidationDataSettings;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ImageVerticalValidationDataSettings extends ValidationDataSettings {}

/**
 * Limit settings for the AutoML job.
 */
model ImageLimitSettings {
  /**
   * Maximum number of concurrent AutoML iterations.
   */
  maxConcurrentTrials?: int32 = 1;

  /**
   * Maximum number of AutoML iterations.
   */
  maxTrials?: int32 = 1;

  /**
   * AutoML job timeout.
   */
  timeout?: duration;
}

/**
 * Model sweeping and hyperparameter sweeping related settings.
 */
model ImageSweepSettings {
  /**
   * Type of early termination policy.
   */
  earlyTermination?: EarlyTerminationPolicy;

  /**
   * [Required] Limit settings for model sweeping and hyperparameter sweeping.
   */
  limits: ImageSweepLimitSettings;

  /**
   * [Required] Type of the hyperparameter sampling algorithms.
   */
  samplingAlgorithm: SamplingAlgorithmType;
}

/**
 * Limit settings for model sweeping and hyperparameter sweeping.
 */
model ImageSweepLimitSettings {
  /**
   * Maximum number of concurrent iterations for the underlying Sweep job.
   */
  maxConcurrentTrials?: int32;

  /**
   * Maximum number of iterations for the underlying Sweep job.
   */
  maxTrials?: int32;
}

/**
 * Image Classification Multilabel. Multi-label image classification is used when an image could have one or more labels
 * from a set of labels - e.g. an image could be labeled with both 'cat' and 'dog'.
 */
model ImageClassificationMultilabel extends AutoMLVertical {
  ...ImageClassificationBase;

  /**
   * Primary metric to optimize for this task.
   */
  primaryMetric?: ClassificationMultilabelPrimaryMetrics;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "ImageClassificationMultilabel";
}

/**
 * Image Instance Segmentation. Instance segmentation is used to identify objects in an image at the pixel level,
 * drawing a polygon around each object in the image.
 */
model ImageInstanceSegmentation extends AutoMLVertical {
  ...ImageObjectDetectionBase;

  /**
   * Primary metric to optimize for this task.
   */
  primaryMetric?: InstanceSegmentationPrimaryMetrics;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "ImageInstanceSegmentation";
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ImageObjectDetectionBase extends ImageVertical {
  /**
   * Settings used for training the model.
   */
  modelSettings?: ImageModelSettingsObjectDetection;

  /**
   * Search space for sampling different combinations of models and their hyperparameters.
   */
  @identifiers(#[])
  searchSpace?: ImageModelDistributionSettingsObjectDetection[];
}

/**
 * Settings used for training the model.
 * For more information on the available settings please visit the official documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ImageModelSettingsObjectDetection extends ImageModelSettings {
  /**
   * Maximum number of detections per image, for all classes. Must be a positive integer.
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  boxDetectionsPerImage?: int32;

  /**
   * During inference, only return proposals with a classification score greater than
   * BoxScoreThreshold. Must be a float in the range[0, 1].
   */
  boxScoreThreshold?: float32;

  /**
   * Image size for train and validation. Must be a positive integer.
   * Note: The training run may get into CUDA OOM if the size is too big.
   * Note: This settings is only supported for the 'yolov5' algorithm.
   */
  imageSize?: int32;

  /**
   * Maximum size of the image to be rescaled before feeding it to the backbone.
   * Must be a positive integer. Note: training run may get into CUDA OOM if the size is too big.
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  maxSize?: int32;

  /**
   * Minimum size of the image to be rescaled before feeding it to the backbone.
   * Must be a positive integer. Note: training run may get into CUDA OOM if the size is too big.
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  minSize?: int32;

  /**
   * Model size. Must be 'small', 'medium', 'large', or 'xlarge'.
   * Note: training run may get into CUDA OOM if the model size is too big.
   * Note: This settings is only supported for the 'yolov5' algorithm.
   */
  modelSize?: ModelSize;

  /**
   * Enable multi-scale image by varying image size by +/- 50%.
   * Note: training run may get into CUDA OOM if no sufficient GPU memory.
   * Note: This settings is only supported for the 'yolov5' algorithm.
   */
  multiScale?: boolean;

  /**
   * IOU threshold used during inference in NMS post processing. Must be a float in the range [0, 1].
   */
  nmsIouThreshold?: float32;

  /**
   * The grid size to use for tiling each image. Note: TileGridSize must not be
   * None to enable small object detection logic. A string containing two integers in mxn format.
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  tileGridSize?: string;

  /**
   * Overlap ratio between adjacent tiles in each dimension. Must be float in the range [0, 1).
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  tileOverlapRatio?: float32;

  /**
   * The IOU threshold to use to perform NMS while merging predictions from tiles and image.
   * Used in validation/ inference. Must be float in the range [0, 1].
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  tilePredictionsNmsThreshold?: float32;

  /**
   * IOU threshold to use when computing validation metric. Must be float in the range [0, 1].
   */
  validationIouThreshold?: float32;

  /**
   * Metric computation method to use for validation metrics.
   */
  validationMetricType?: ValidationMetricType;
}

/**
 * Distribution expressions to sweep over values of model settings.
 * <example>
 * Some examples are:
 * <code>
 * ModelName = "choice('seresnext', 'resnest50')";
 * LearningRate = "uniform(0.001, 0.01)";
 * LayersToFreeze = "choice(0, 2)";
 * </code></example>
 * For more details on how to compose distribution expressions please check the documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-tune-hyperparameters
 * For more information on the available settings please visit the official documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ImageModelDistributionSettingsObjectDetection
  extends ImageModelDistributionSettings {
  /**
   * Maximum number of detections per image, for all classes. Must be a positive integer.
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  boxDetectionsPerImage?: string;

  /**
   * During inference, only return proposals with a classification score greater than
   * BoxScoreThreshold. Must be a float in the range[0, 1].
   */
  boxScoreThreshold?: string;

  /**
   * Image size for train and validation. Must be a positive integer.
   * Note: The training run may get into CUDA OOM if the size is too big.
   * Note: This settings is only supported for the 'yolov5' algorithm.
   */
  imageSize?: string;

  /**
   * Maximum size of the image to be rescaled before feeding it to the backbone.
   * Must be a positive integer. Note: training run may get into CUDA OOM if the size is too big.
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  maxSize?: string;

  /**
   * Minimum size of the image to be rescaled before feeding it to the backbone.
   * Must be a positive integer. Note: training run may get into CUDA OOM if the size is too big.
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  minSize?: string;

  /**
   * Model size. Must be 'small', 'medium', 'large', or 'xlarge'.
   * Note: training run may get into CUDA OOM if the model size is too big.
   * Note: This settings is only supported for the 'yolov5' algorithm.
   */
  modelSize?: string;

  /**
   * Enable multi-scale image by varying image size by +/- 50%.
   * Note: training run may get into CUDA OOM if no sufficient GPU memory.
   * Note: This settings is only supported for the 'yolov5' algorithm.
   */
  multiScale?: string;

  /**
   * IOU threshold used during inference in NMS post processing. Must be float in the range [0, 1].
   */
  nmsIouThreshold?: string;

  /**
   * The grid size to use for tiling each image. Note: TileGridSize must not be
   * None to enable small object detection logic. A string containing two integers in mxn format.
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  tileGridSize?: string;

  /**
   * Overlap ratio between adjacent tiles in each dimension. Must be float in the range [0, 1).
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  tileOverlapRatio?: string;

  /**
   * The IOU threshold to use to perform NMS while merging predictions from tiles and image.
   * Used in validation/ inference. Must be float in the range [0, 1].
   * Note: This settings is not supported for the 'yolov5' algorithm.
   * NMS: Non-maximum suppression
   */
  tilePredictionsNmsThreshold?: string;

  /**
   * IOU threshold to use when computing validation metric. Must be float in the range [0, 1].
   */
  validationIouThreshold?: string;

  /**
   * Metric computation method to use for validation metrics. Must be 'none', 'coco', 'voc', or 'coco_voc'.
   */
  validationMetricType?: string;
}

/**
 * Image Object Detection. Object detection is used to identify objects in an image and locate each object with a
 * bounding box e.g. locate all dogs and cats in an image and draw a bounding box around each.
 */
model ImageObjectDetection extends AutoMLVertical {
  ...ImageObjectDetectionBase;

  /**
   * Primary metric to optimize for this task.
   */
  primaryMetric?: ObjectDetectionPrimaryMetrics;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "ImageObjectDetection";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model KerberosCredentials {
  /**
   * [Required] IP Address or DNS HostName.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  kerberosKdcAddress: string;

  /**
   * [Required] Kerberos Username
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  kerberosPrincipal: string;

  /**
   * [Required] Domain over which a Kerberos authentication server has the authority to authenticate a user, host or service.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  kerberosRealm: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model KerberosKeytabCredentials extends DatastoreCredentials {
  ...KerberosCredentials;

  /**
   * [Required] Keytab secrets.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  secrets: KerberosKeytabSecrets;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialsType: "KerberosKeytab";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model KerberosKeytabSecrets extends DatastoreSecrets {
  /**
   * Kerberos keytab secret.
   */
  kerberosKeytab?: string;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  secretsType: "KerberosKeytab";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model KerberosPasswordCredentials extends DatastoreCredentials {
  ...KerberosCredentials;

  /**
   * [Required] Kerberos password secrets.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  secrets: KerberosPasswordSecrets;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialsType: "KerberosPassword";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model KerberosPasswordSecrets extends DatastoreSecrets {
  /**
   * Kerberos password secret.
   */
  kerberosPassword?: string;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  secretsType: "KerberosPassword";
}

/**
 * Properties specific to a KubernetesOnlineDeployment.
 */
model KubernetesOnlineDeployment extends OnlineDeploymentDetails {
  /**
   * The resource requirements for the container (cpu and memory).
   */
  containerResourceRequirements?: ContainerResourceRequirements;

  /**
   * [Required] The compute type of the endpoint.
   */
  endpointComputeType: "Kubernetes";
}

/**
 * Literal input type.
 */
model LiteralJobInput extends JobInput {
  /**
   * [Required] Literal value for the input.
   */
  @pattern("[a-zA-Z0-9_]")
  value: string;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "Literal";
}

/**
 * Managed identity configuration.
 */
model ManagedIdentity extends IdentityConfiguration {
  /**
   * Specifies a user-assigned identity by client ID. For system-assigned, do not set this field.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @format("uuid")
  clientId?: string;

  /**
   * Specifies a user-assigned identity by object ID. For system-assigned, do not set this field.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @format("uuid")
  objectId?: string;

  /**
   * Specifies a user-assigned identity by ARM resource ID. For system-assigned, do not set this field.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resourceId?: string;

  /**
   * [Required] Specifies the type of identity framework.
   */
  identityType: "Managed";
}

/**
 * Properties specific to a ManagedOnlineDeployment.
 */
model ManagedOnlineDeployment extends OnlineDeploymentDetails {
  /**
   * [Required] The compute type of the endpoint.
   */
  endpointComputeType: "Managed";
}

/**
 * Defines an early termination policy based on running averages of the primary metric of all runs
 */
model MedianStoppingPolicy extends EarlyTerminationPolicy {
  /**
   * [Required] Name of policy configuration
   */
  policyType: "MedianStopping";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model MLFlowModelJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "MLFlowModel";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model MLFlowModelJobOutput extends JobOutput {
  ...AssetJobOutput;

  /**
   * [Required] Specifies the type of job.
   */
  jobOutputType: "MLFlowModel";
}

/**
 * MLTable data definition
 */
model MLTableData extends DataVersionBaseDetails {
  /**
   * Uris referenced in the MLTable definition (required for lineage)
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  referencedUris?: string[];

  /**
   * [Required] Specifies the type of data.
   */
  dataType: "MLTable";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model MLTableJobOutput extends JobOutput {
  ...AssetJobOutput;

  /**
   * [Required] Specifies the type of job.
   */
  jobOutputType: "MLTable";
}

/**
 * MPI distribution configuration.
 */
model Mpi extends DistributionConfiguration {
  /**
   * Number of processes per MPI node.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  processCountPerInstance?: int32;

  /**
   * [Required] Specifies the type of distribution framework.
   */
  distributionType: "Mpi";
}

/**
 * Abstract class for NLP related AutoML tasks.
 * NLP - Natural Language Processing.
 */
model NlpVertical {
  /**
   * Data inputs for AutoMLJob.
   */
  dataSettings?: NlpVerticalDataSettings;

  /**
   * Featurization inputs needed for AutoML job.
   */
  featurizationSettings?: NlpVerticalFeaturizationSettings;

  /**
   * Execution constraints for AutoMLJob.
   */
  limitSettings?: NlpVerticalLimitSettings;
}

/**
 * Class for data inputs.
 * NLP - Natural Language Processing.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NlpVerticalDataSettings extends DataSettings {
  /**
   * Validation data inputs.
   */
  validationData?: NlpVerticalValidationDataSettings;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model NlpVerticalValidationDataSettings extends ValidationDataSettings {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model NlpVerticalFeaturizationSettings extends FeaturizationSettings {}

/**
 * Job execution constraints.
 */
model NlpVerticalLimitSettings {
  /**
   * Maximum Concurrent AutoML iterations.
   */
  maxConcurrentTrials?: int32 = 1;

  /**
   * Number of AutoML iterations.
   */
  maxTrials?: int32 = 1;

  /**
   * AutoML job timeout.
   */
  timeout?: duration;
}

/**
 * Empty/none datastore credentials.
 */
model NoneDatastoreCredentials extends DatastoreCredentials {
  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialsType: "None";
}

/**
 * Optimization objective.
 */
model Objective {
  /**
   * [Required] Defines supported metric goals for hyperparameter tuning
   */
  goal: Goal;

  /**
   * [Required] Name of the metric to optimize.
   */
  @pattern("[a-zA-Z0-9_]")
  primaryMetric: string;
}

/**
 * Reference to an asset via its path in a job output.
 */
model OutputPathAssetReference extends AssetReferenceBase {
  /**
   * ARM resource ID of the job.
   */
  jobId?: string;

  /**
   * The path of the file/directory in the job output.
   */
  path?: string;

  /**
   * [Required] Specifies the type of asset reference.
   */
  referenceType: "OutputPath";
}

/**
 * Reference to an asset via its path in a datastore.
 */
model PartialDataPathAssetReference extends PartialAssetReferenceBase {
  /**
   * ARM resource ID of the datastore where the asset is located.
   */
  datastoreId?: string;

  /**
   * The path of the file/directory in the datastore.
   */
  path?: string;

  /**
   * [Required] Specifies the type of asset reference.
   */
  referenceType: "DataPath";
}

/**
 * Reference to an asset via its ARM resource ID.
 */
model PartialIdAssetReference extends PartialAssetReferenceBase {
  /**
   * ARM resource ID of the asset.
   */
  assetId?: string;

  /**
   * [Required] Specifies the type of asset reference.
   */
  referenceType: "Id";
}

/**
 * Properties specific to a KubernetesOnlineDeployment.
 */
model PartialKubernetesOnlineDeployment extends PartialOnlineDeployment {
  /**
   * [Required] The compute type of the endpoint.
   */
  endpointComputeType: "Kubernetes";
}

/**
 * Properties specific to a ManagedOnlineDeployment.
 */
model PartialManagedOnlineDeployment extends PartialOnlineDeployment {
  /**
   * [Required] The compute type of the endpoint.
   */
  endpointComputeType: "Managed";
}

/**
 * Reference to an asset via its path in a job output.
 */
model PartialOutputPathAssetReference extends PartialAssetReferenceBase {
  /**
   * ARM resource ID of the job.
   */
  jobId?: string;

  /**
   * The path of the file/directory in the job output.
   */
  path?: string;

  /**
   * [Required] Specifies the type of asset reference.
   */
  referenceType: "OutputPath";
}

/**
 * Pipeline Job definition: defines generic to MFE attributes.
 */
model PipelineJob extends JobBaseDetails {
  /**
   * Inputs for the pipeline job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inputs?: Record<JobInput>;

  /**
   * Jobs construct the Pipeline Job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobs?: Record<unknown>;

  /**
   * Outputs for the pipeline job
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outputs?: Record<JobOutput>;

  /**
   * Pipeline settings, for things like ContinueRunOnStepFailure etc.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  settings?: unknown;

  /**
   * [Required] Specifies the type of job.
   */
  jobType: "Pipeline";
}

/**
 * PyTorch distribution configuration.
 */
model PyTorch extends DistributionConfiguration {
  /**
   * Number of processes per node.
   */
  processCountPerInstance?: int32;

  /**
   * [Required] Specifies the type of distribution framework.
   */
  distributionType: "PyTorch";
}

/**
 * Defines a Sampling Algorithm that generates values randomly
 */
model RandomSamplingAlgorithm extends SamplingAlgorithm {
  /**
   * The specific type of random algorithm
   */
  rule?: RandomSamplingAlgorithmRule;

  /**
   * An optional integer to use as the seed for random number generation
   */
  seed?: int32;

  /**
   * [Required] The algorithm used for generating hyperparameter values, along with configuration properties
   */
  samplingAlgorithmType: "Random";
}

/**
 * Recurrence schedule pattern definition
 */
model RecurrencePattern {
  /**
   * [Required] List of hours for recurrence schedule pattern
   */
  hours: int32[];

  /**
   * [Required] List of minutes for recurrence schedule pattern
   */
  minutes: int32[];

  /**
   * List of weekdays for recurrence schedule pattern
   */
  weekdays?: Weekday[];
}

/**
 * Recurrence schedule definition
 */
model RecurrenceSchedule extends ScheduleBase {
  /**
   * [Required] Specifies frequency with with which to trigger schedule
   */
  frequency: RecurrenceFrequency;

  /**
   * [Required] Specifies schedule interval in conjunction with frequency
   */
  interval: int32;

  /**
   * Specifies the recurrence schedule pattern
   */
  pattern?: RecurrencePattern;

  /**
   * [Required] Specifies the schedule type
   */
  scheduleType: "Recurrence";
}

/**
 * Regression task in AutoML Table vertical.
 */
model Regression extends AutoMLVertical {
  ...TableVertical;

  /**
   * Allowed models for regression task.
   */
  allowedModels?: RegressionModels[];

  /**
   * Blocked models for regression task.
   */
  blockedModels?: RegressionModels[];

  /**
   * Primary metric for regression task.
   */
  primaryMetric?: RegressionPrimaryMetrics;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "Regression";
}

/**
 * SAS datastore credentials configuration.
 */
model SasDatastoreCredentials extends DatastoreCredentials {
  /**
   * [Required] Storage container secrets.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  secrets: SasDatastoreSecrets;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialsType: "Sas";
}

/**
 * Datastore SAS secrets.
 */
model SasDatastoreSecrets extends DatastoreSecrets {
  /**
   * Storage container SAS token.
   */
  sasToken?: string;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  secretsType: "Sas";
}

/**
 * Service Principal datastore credentials configuration.
 */
model ServicePrincipalDatastoreCredentials extends DatastoreCredentials {
  /**
   * Authority URL used for authentication.
   */
  authorityUrl?: string;

  /**
   * [Required] Service principal client ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  clientId: string;

  /**
   * Resource the service principal has access to.
   */
  resourceUrl?: string;

  /**
   * [Required] Service principal secrets.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  secrets: ServicePrincipalDatastoreSecrets;

  /**
   * [Required] ID of the tenant to which the service principal belongs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  tenantId: string;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialsType: "ServicePrincipal";
}

/**
 * Datastore Service Principal secrets.
 */
model ServicePrincipalDatastoreSecrets extends DatastoreSecrets {
  /**
   * Service principal secret.
   */
  clientSecret?: string;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  secretsType: "ServicePrincipal";
}

/**
 * Sweep job definition.
 */
model SweepJob extends JobBaseDetails {
  /**
   * Early termination policies enable canceling poor-performing runs before they complete
   */
  earlyTermination?: EarlyTerminationPolicy;

  /**
   * Mapping of input data bindings used in the job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inputs?: Record<JobInput>;

  /**
   * Sweep Job limit.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  limits?: SweepJobLimits;

  /**
   * [Required] Optimization objective.
   */
  objective: Objective;

  /**
   * Mapping of output data bindings used in the job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outputs?: Record<JobOutput>;

  /**
   * [Required] The hyperparameter sampling algorithm
   */
  samplingAlgorithm: SamplingAlgorithm;

  /**
   * [Required] A dictionary containing each parameter and its distribution. The dictionary key is the name of the parameter
   */
  searchSpace: unknown;

  /**
   * [Required] Trial component definition.
   */
  trial: TrialComponent;

  /**
   * [Required] Specifies the type of job.
   */
  jobType: "Sweep";
}

/**
 * Sweep Job limit class.
 */
model SweepJobLimits extends JobLimits {
  /**
   * Sweep Job max concurrent trials.
   */
  maxConcurrentTrials?: int32;

  /**
   * Sweep Job max total trials.
   */
  maxTotalTrials?: int32;

  /**
   * Sweep Job Trial timeout value.
   */
  trialTimeout?: duration;

  /**
   * [Required] JobLimit type.
   */
  jobLimitsType: "Sweep";
}

/**
 * Trial component definition.
 */
model TrialComponent {
  /**
   * ARM resource ID of the code asset.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  codeId?: string;

  /**
   * [Required] The command to execute on startup of the job. eg. "python train.py"
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  command: string;

  /**
   * Distribution configuration of the job. If set, this should be one of Mpi, Tensorflow, PyTorch, or null.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  distribution?: DistributionConfiguration;

  /**
   * [Required] The ARM resource ID of the Environment specification for the job.
   */
  @pattern("[a-zA-Z0-9_]")
  environmentId: string;

  /**
   * Environment variables included in the job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  environmentVariables?: Record<string>;

  /**
   * Compute Resource configuration for the job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resources?: ResourceConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model TargetUtilizationScaleSettings extends OnlineScaleSettings {
  /**
   * The maximum number of instances that the deployment can scale to. The quota will be reserved for max_instances.
   */
  maxInstances?: int32 = 1;

  /**
   * The minimum number of instances to always be present.
   */
  minInstances?: int32 = 1;

  /**
   * The polling interval in ISO 8691 format. Only supports duration with precision as low as Seconds.
   */
  pollingInterval?: duration;

  /**
   * Target CPU usage for the autoscaler.
   */
  targetUtilizationPercentage?: int32 = 70;

  /**
   * [Required] Type of deployment scaling algorithm
   */
  scaleType: "TargetUtilization";
}

/**
 * TensorFlow distribution configuration.
 */
model TensorFlow extends DistributionConfiguration {
  /**
   * Number of parameter server tasks.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  parameterServerCount?: int32;

  /**
   * Number of workers. If not specified, will default to the instance count.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  workerCount?: int32;

  /**
   * [Required] Specifies the type of distribution framework.
   */
  distributionType: "TensorFlow";
}

/**
 * Text Classification task in AutoML NLP vertical.
 * NLP - Natural Language Processing.
 */
model TextClassification extends AutoMLVertical {
  ...NlpVertical;

  /**
   * Primary metric for Text-Classification task.
   */
  primaryMetric?: ClassificationPrimaryMetrics;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "TextClassification";
}

/**
 * Text Classification Multilabel task in AutoML NLP vertical.
 * NLP - Natural Language Processing.
 */
model TextClassificationMultilabel extends AutoMLVertical {
  ...NlpVertical;

  /**
   * Primary metric for Text-Classification-Multilabel task.
   * Currently only Accuracy is supported as primary metric, hence user need not set it explicitly.
   */
  @visibility(Lifecycle.Read)
  primaryMetric?: ClassificationMultilabelPrimaryMetrics;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "TextClassificationMultilabel";
}

/**
 * Text-NER task in AutoML NLP vertical.
 * NER - Named Entity Recognition.
 * NLP - Natural Language Processing.
 */
model TextNer extends AutoMLVertical {
  ...NlpVertical;

  /**
   * Primary metric for Text-NER task.
   * Only 'Accuracy' is supported for Text-NER, so user need not set this explicitly.
   */
  @visibility(Lifecycle.Read)
  primaryMetric?: ClassificationPrimaryMetrics;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "TextNER";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model TritonModelJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "TritonModel";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model TritonModelJobOutput extends JobOutput {
  ...AssetJobOutput;

  /**
   * [Required] Specifies the type of job.
   */
  jobOutputType: "TritonModel";
}

/**
 * Defines an early termination policy that cancels a given percentage of runs at each evaluation interval.
 */
model TruncationSelectionPolicy extends EarlyTerminationPolicy {
  /**
   * The percentage of runs to cancel at each evaluation interval.
   */
  truncationPercentage?: int32;

  /**
   * [Required] Name of policy configuration
   */
  policyType: "TruncationSelection";
}

/**
 * uri-file data version entity
 */
model UriFileDataVersion extends DataVersionBaseDetails {
  /**
   * [Required] Specifies the type of data.
   */
  dataType: "UriFile";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UriFileJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "UriFile";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UriFileJobOutput extends JobOutput {
  ...AssetJobOutput;

  /**
   * [Required] Specifies the type of job.
   */
  jobOutputType: "UriFile";
}

/**
 * uri-folder data version entity
 */
model UriFolderDataVersion extends DataVersionBaseDetails {
  /**
   * [Required] Specifies the type of data.
   */
  dataType: "UriFolder";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UriFolderJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "UriFolder";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UriFolderJobOutput extends JobOutput {
  ...AssetJobOutput;

  /**
   * [Required] Specifies the type of job.
   */
  jobOutputType: "UriFolder";
}

/**
 * User identity configuration.
 */
model UserIdentity extends IdentityConfiguration {
  /**
   * [Required] Specifies the type of identity framework.
   */
  identityType: "UserIdentity";
}
