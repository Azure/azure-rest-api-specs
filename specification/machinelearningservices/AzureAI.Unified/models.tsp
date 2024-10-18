import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

/**
 * An enum describing the unit of usage measurement.
 */
union UsageUnit {
  string,
  Count: "Count",
}

/**
 * Three lettered code specifying the currency of the VM price. Example: USD
 */
union BillingCurrency {
  string,
  USD: "USD",
}

/**
 * The unit of time measurement for the specified VM price. Example: OneHour
 */
union UnitOfMeasure {
  string,
  OneHour: "OneHour",
}

/**
 * Operating system type used by the VM.
 */
union VMPriceOSType {
  string,
  Linux: "Linux",
  Windows: "Windows",
}

/**
 * The type of the VM.
 */
union VMTier {
  string,
  Standard: "Standard",
  LowPriority: "LowPriority",
  Spot: "Spot",
}

/**
 * An enum describing the unit of quota measurement.
 */
union QuotaUnit {
  string,
  Count: "Count",
}

/**
 * Status of update workspace quota.
 */
union Status {
  string,
  Undefined: "Undefined",
  Success: "Success",
  Failure: "Failure",
  InvalidQuotaBelowClusterMinimum: "InvalidQuotaBelowClusterMinimum",
  InvalidQuotaExceedsSubscriptionLimit: "InvalidQuotaExceedsSubscriptionLimit",
  InvalidVMFamilyName: "InvalidVMFamilyName",
  OperationNotSupportedForSku: "OperationNotSupportedForSku",
  OperationNotEnabledForRegion: "OperationNotEnabledForRegion",
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
union ManagedServiceIdentityType {
  string,
  None: "None",
  SystemAssigned: "SystemAssigned",
  UserAssigned: "UserAssigned",
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

/**
 * The type of compute
 */
union ComputeType {
  string,
  AKS: "AKS",
  Kubernetes: "Kubernetes",
  AmlCompute: "AmlCompute",
  ComputeInstance: "ComputeInstance",
  DataFactory: "DataFactory",
  VirtualMachine: "VirtualMachine",
  HDInsight: "HDInsight",
  Databricks: "Databricks",
  DataLakeAnalytics: "DataLakeAnalytics",
  SynapseSpark: "SynapseSpark",
}

/**
 * The provision state of the cluster. Valid values are Unknown, Updating, Provisioning, Succeeded, and Failed.
 */
union ProvisioningState {
  string,
  Unknown: "Unknown",
  Updating: "Updating",
  Creating: "Creating",
  Deleting: "Deleting",
  Succeeded: "Succeeded",
  Failed: "Failed",
  Canceled: "Canceled",
}

union UnderlyingResourceAction {
  string,
  Delete: "Delete",
  Detach: "Detach",
}

/**
 * Type of the image. Possible values are: docker - For docker images. azureml - For AzureML Environment images (custom and curated)
 */
union ImageType {
  string,
  docker: "docker",
  azureml: "azureml",
}

/**
 * Type of the Environment Variable. Possible values are: local - For local variable
 */
union EnvironmentVariableType {
  string,
  local: "local",
}

/**
 * Protocol over which communication will happen over this endpoint
 */
union Protocol {
  string,
  tcp: "tcp",
  udp: "udp",
  http: "http",
}

/**
 * Type of Volume Definition. Possible Values: bind,volume,tmpfs,npipe
 */
union VolumeDefinitionType {
  string,
  bind: "bind",
  volume: "volume",
  tmpfs: "tmpfs",
  npipe: "npipe",
}

/**
 * State of the compute node. Values are idle, running, preparing, unusable, leaving and preempted.
 */
union NodeState {
  string,
  idle: "idle",
  running: "running",
  preparing: "preparing",
  unusable: "unusable",
  leaving: "leaving",
  preempted: "preempted",
}

/**
 * Data source type.
 */
union SourceType {
  string,
  Dataset: "Dataset",
  Datastore: "Datastore",
  URI: "URI",
}

/**
 * Mount Action.
 */
union MountAction {
  string,
  Mount: "Mount",
  Unmount: "Unmount",
}

/**
 * Mount Mode.
 */
union MountMode {
  string,
  ReadOnly: "ReadOnly",
  ReadWrite: "ReadWrite",
}

/**
 * Mount state.
 */
union MountState {
  string,
  MountRequested: "MountRequested",
  Mounted: "Mounted",
  MountFailed: "MountFailed",
  UnmountRequested: "UnmountRequested",
  UnmountFailed: "UnmountFailed",
  Unmounted: "Unmounted",
}

/**
 * Provisioning state of registry asset.
 */
union AssetProvisioningState {
  string,
  Succeeded: "Succeeded",
  Failed: "Failed",
  Canceled: "Canceled",
  Creating: "Creating",
  Updating: "Updating",
  Deleting: "Deleting",
}

/**
 * Type of storage to use for the pending upload location
 */
union PendingUploadType {
  string,
  None: "None",
  TemporaryBlobReference: "TemporaryBlobReference",
}

/**
 * Enum to determine the PendingUpload credentials type.
 */
union PendingUploadCredentialType {
  string,
  SAS: "SAS",
}

union ListViewType {
  string,
  ActiveOnly: "ActiveOnly",
  ArchivedOnly: "ArchivedOnly",
  All: "All",
}

/**
 * Enum to determine the type of data.
 */
union DataType {
  string,
  uri_file: "uri_file",
  uri_folder: "uri_folder",
}

/**
 * Enum to determine the DataReference credentials type.
 */
union DataReferenceCredentialType {
  string,
  SAS: "SAS",
  DockerCredentials: "DockerCredentials",
  ManagedIdentity: "ManagedIdentity",
  NoCredentials: "NoCredentials",
}

/**
 * AutoRebuild setting for the derived image
 */
union AutoRebuildSetting {
  string,
  Disabled: "Disabled",
  OnBaseImageUpdate: "OnBaseImageUpdate",
}

/**
 * Environment type is either user created or curated by Azure ML service
 */
union EnvironmentType {
  string,
  Curated: "Curated",
  UserCreated: "UserCreated",
}

/**
 * The type of operating system.
 */
union OperatingSystemType {
  string,
  Linux: "Linux",
  Windows: "Windows",
}

/**
 * State of endpoint provisioning.
 */
union EndpointProvisioningState {
  string,
  Creating: "Creating",
  Deleting: "Deleting",
  Succeeded: "Succeeded",
  Failed: "Failed",
  Updating: "Updating",
  Canceled: "Canceled",
}

/**
 * Enum to determine endpoint authentication mode.
 */
union EndpointAuthMode {
  string,
  AMLToken: "AMLToken",
  Key: "Key",
  AADToken: "AADToken",
}

/**
 * The enumerated property types for batch deployments.
 */
union BatchDeploymentConfigurationType {
  string,
  Model: "Model",
  PipelineComponent: "PipelineComponent",
}

/**
 * Log verbosity for batch inferencing.
 * Increasing verbosity order for logging is : Warning, Info and Debug.
 * The default value is Info.
 */
union BatchLoggingLevel {
  string,
  Info: "Info",
  Warning: "Warning",
  Debug: "Debug",
}

/**
 * Enum to determine which reference method to use for an asset.
 */
union ReferenceType {
  string,
  Id: "Id",
  DataPath: "DataPath",
  OutputPath: "OutputPath",
}

/**
 * Enum to determine how batch inferencing will handle output
 */
union BatchOutputAction {
  string,
  SummaryOnly: "SummaryOnly",
  AppendRow: "AppendRow",
}

/**
 * Possible values for DeploymentProvisioningState.
 */
union DeploymentProvisioningState {
  string,
  Creating: "Creating",
  Deleting: "Deleting",
  Scaling: "Scaling",
  Updating: "Updating",
  Succeeded: "Succeeded",
  Failed: "Failed",
  Canceled: "Canceled",
}

/**
 * Enum to determine the datastore credentials type.
 */
union CredentialsType {
  string,
  AccountKey: "AccountKey",
  Certificate: "Certificate",
  None: "None",
  Sas: "Sas",
  ServicePrincipal: "ServicePrincipal",
}

/**
 * Enum to determine the datastore contents type.
 */
union DatastoreType {
  string,
  AzureBlob: "AzureBlob",
  AzureDataLakeGen1: "AzureDataLakeGen1",
  AzureDataLakeGen2: "AzureDataLakeGen2",
  AzureFile: "AzureFile",
  OneLake: "OneLake",
}

/**
 * Enum to determine the datastore secrets type.
 */
union SecretsType {
  string,
  AccountKey: "AccountKey",
  Certificate: "Certificate",
  Sas: "Sas",
  ServicePrincipal: "ServicePrincipal",
}

union FeatureDataType {
  string,
  String: "String",
  Integer: "Integer",
  Long: "Long",
  Float: "Float",
  Double: "Double",
  Binary: "Binary",
  Datetime: "Datetime",
  Boolean: "Boolean",
}

/**
 * Enum to determine the email notification type.
 */
union EmailNotificationEnableType {
  string,
  JobCompleted: "JobCompleted",
  JobFailed: "JobFailed",
  JobCancelled: "JobCancelled",
}

/**
 * Enum to determine the webhook callback service type.
 */
union WebhookType {
  string,
  AzureDevOps: "AzureDevOps",
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
 * Enum of weekday
 */
union WeekDay {
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

union TriggerType {
  string,
  Recurrence: "Recurrence",
  Cron: "Cron",
}

union MaterializationStoreType {
  string,
  None: "None",
  Online: "Online",
  Offline: "Offline",
  OnlineAndOffline: "OnlineAndOffline",
}

union DataAvailabilityStatus {
  string,
  None: "None",
  Pending: "Pending",
  Incomplete: "Incomplete",
  Complete: "Complete",
}

/**
 * Enum to determine identity framework.
 */
union IdentityConfigurationType {
  string,
  Managed: "Managed",
  AMLToken: "AMLToken",
  UserIdentity: "UserIdentity",
}

/**
 * Enum to determine the type of job.
 */
union JobType {
  string,
  AutoML: "AutoML",
  Command: "Command",
  Sweep: "Sweep",
  Pipeline: "Pipeline",
  Spark: "Spark",
  FineTuning: "FineTuning",
}

/**
 * The enumerated types for the nodes value
 */
union NodesValueType {
  string,
  All: "All",
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
}

/**
 * Enum to determine endpoint compute type.
 */
union EndpointComputeType {
  string,
  Managed: "Managed",
  Kubernetes: "Kubernetes",
  AzureMLCompute: "AzureMLCompute",
}

union OrderString {
  string,
  CreatedAtDesc: "CreatedAtDesc",
  CreatedAtAsc: "CreatedAtAsc",
  UpdatedAtDesc: "UpdatedAtDesc",
  UpdatedAtAsc: "UpdatedAtAsc",
}

/**
 * Enum to determine whether PublicNetworkAccess is Enabled or Disabled.
 */
union PublicNetworkAccessType {
  string,
  Enabled: "Enabled",
  Disabled: "Disabled",
}

union DataCollectionMode {
  string,
  Enabled: "Enabled",
  Disabled: "Disabled",
}

union RollingRateType {
  string,
  Year: "Year",
  Month: "Month",
  Day: "Day",
  Hour: "Hour",
  Minute: "Minute",
}

/**
 * Enum to determine whether PublicNetworkAccess is Enabled or Disabled for egress of a deployment.
 */
union EgressPublicNetworkAccessType {
  string,
  Enabled: "Enabled",
  Disabled: "Disabled",
}

union ScaleType {
  string,
  Default: "Default",
  TargetUtilization: "TargetUtilization",
}

union ContainerType {
  string,
  StorageInitializer: "StorageInitializer",
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

union KeyType {
  string,
  Primary: "Primary",
  Secondary: "Secondary",
}

union ScheduleListViewType {
  string,
  EnabledOnly: "EnabledOnly",
  DisabledOnly: "DisabledOnly",
  All: "All",
}

union ScheduleActionType {
  string,
  CreateJob: "CreateJob",
  InvokeBatchEndpoint: "InvokeBatchEndpoint",
  CreateMonitor: "CreateMonitor",
}

union ScheduleProvisioningStatus {
  string,
  Creating: "Creating",
  Updating: "Updating",
  Deleting: "Deleting",
  Succeeded: "Succeeded",
  Failed: "Failed",
  Canceled: "Canceled",
}

union ServerlessInferenceEndpointAuthMode {
  string,
  Key: "Key",
}

/**
 * Specifies the status of content safety.
 */
union ContentSafetyStatus {
  string,
  Enabled: "Enabled",
  Disabled: "Disabled",
}

/**
 * State of the Serverless Endpoint.
 */
union ServerlessEndpointState {
  string,
  Unknown: "Unknown",
  Creating: "Creating",
  Deleting: "Deleting",
  Suspending: "Suspending",
  Reinstating: "Reinstating",
  Online: "Online",
  Suspended: "Suspended",
  CreationFailed: "CreationFailed",
  DeletionFailed: "DeletionFailed",
}

/**
 * Connection status of the service consumer with the service provider
 */
union EndpointServiceConnectionStatus {
  string,
  Approved: "Approved",
  Pending: "Pending",
  Rejected: "Rejected",
  Disconnected: "Disconnected",
  Timeout: "Timeout",
}

/**
 * Indicates whether or not the encryption is enabled for the workspace.
 */
union EncryptionStatus {
  string,
  Enabled: "Enabled",
  Disabled: "Disabled",
}

/**
 * Isolation mode for the managed network of a machine learning workspace.
 */
union IsolationMode {
  string,
  Disabled: "Disabled",
  AllowInternetOutbound: "AllowInternetOutbound",
  AllowOnlyApprovedOutbound: "AllowOnlyApprovedOutbound",
}

/**
 * Category of a managed network Outbound Rule of a machine learning workspace.
 */
union RuleCategory {
  string,
  Required: "Required",
  Recommended: "Recommended",
  UserDefined: "UserDefined",
  Dependency: "Dependency",
}

/**
 * Type of a managed network Outbound Rule of a machine learning workspace.
 */
union RuleStatus {
  string,
  Inactive: "Inactive",
  Active: "Active",
}

/**
 * Type of a managed network Outbound Rule of a machine learning workspace.
 */
union RuleType {
  string,
  FQDN: "FQDN",
  PrivateEndpoint: "PrivateEndpoint",
  ServiceTag: "ServiceTag",
}

/**
 * Status for the managed network of a machine learning workspace.
 */
union ManagedNetworkStatus {
  string,
  Inactive: "Inactive",
  Active: "Active",
}

/**
 * The current provisioning state.
 */
union PrivateEndpointConnectionProvisioningState {
  string,
  Succeeded: "Succeeded",
  Creating: "Creating",
  Deleting: "Deleting",
  Failed: "Failed",
}

/**
 * Authentication type of the connection target
 */
union ConnectionAuthType {
  string,
  PAT: "PAT",
  ManagedIdentity: "ManagedIdentity",
  UsernamePassword: "UsernamePassword",
  None: "None",
  SAS: "SAS",
  AccountKey: "AccountKey",
  ServicePrincipal: "ServicePrincipal",
  AccessKey: "AccessKey",
  ApiKey: "ApiKey",
  CustomKeys: "CustomKeys",
  OAuth2: "OAuth2",
  AAD: "AAD",
}

/**
 * Category of the connection
 */
union ConnectionCategory {
  string,
  PythonFeed: "PythonFeed",
  ContainerRegistry: "ContainerRegistry",
  Git: "Git",
  S3: "S3",
  Snowflake: "Snowflake",
  AzureSqlDb: "AzureSqlDb",
  AzureSynapseAnalytics: "AzureSynapseAnalytics",
  AzureMySqlDb: "AzureMySqlDb",
  AzurePostgresDb: "AzurePostgresDb",
  ADLSGen2: "ADLSGen2",
  Redis: "Redis",
  ApiKey: "ApiKey",
  AzureOpenAI: "AzureOpenAI",
  AIServices: "AIServices",
  CognitiveSearch: "CognitiveSearch",
  CognitiveService: "CognitiveService",
  CustomKeys: "CustomKeys",
  AzureBlob: "AzureBlob",
  AzureOneLake: "AzureOneLake",
  CosmosDb: "CosmosDb",
  CosmosDbMongoDbApi: "CosmosDbMongoDbApi",
  AzureDataExplorer: "AzureDataExplorer",
  AzureMariaDb: "AzureMariaDb",
  AzureDatabricksDeltaLake: "AzureDatabricksDeltaLake",
  AzureSqlMi: "AzureSqlMi",
  AzureTableStorage: "AzureTableStorage",
  AmazonRdsForOracle: "AmazonRdsForOracle",
  AmazonRdsForSqlServer: "AmazonRdsForSqlServer",
  AmazonRedshift: "AmazonRedshift",
  Db2: "Db2",
  Drill: "Drill",
  GoogleBigQuery: "GoogleBigQuery",
  Greenplum: "Greenplum",
  Hbase: "Hbase",
  Hive: "Hive",
  Impala: "Impala",
  Informix: "Informix",
  MariaDb: "MariaDb",
  MicrosoftAccess: "MicrosoftAccess",
  MySql: "MySql",
  Netezza: "Netezza",
  Oracle: "Oracle",
  Phoenix: "Phoenix",
  PostgreSql: "PostgreSql",
  Presto: "Presto",
  SapOpenHub: "SapOpenHub",
  SapBw: "SapBw",
  SapHana: "SapHana",
  SapTable: "SapTable",
  Spark: "Spark",
  SqlServer: "SqlServer",
  Sybase: "Sybase",
  Teradata: "Teradata",
  Vertica: "Vertica",
  Cassandra: "Cassandra",
  Couchbase: "Couchbase",
  MongoDbV2: "MongoDbV2",
  MongoDbAtlas: "MongoDbAtlas",
  AmazonS3Compatible: "AmazonS3Compatible",
  FileServer: "FileServer",
  FtpServer: "FtpServer",
  GoogleCloudStorage: "GoogleCloudStorage",
  Hdfs: "Hdfs",
  OracleCloudStorage: "OracleCloudStorage",
  Sftp: "Sftp",
  GenericHttp: "GenericHttp",
  ODataRest: "ODataRest",
  Odbc: "Odbc",
  GenericRest: "GenericRest",
  AmazonMws: "AmazonMws",
  Concur: "Concur",
  Dynamics: "Dynamics",
  DynamicsAx: "DynamicsAx",
  DynamicsCrm: "DynamicsCrm",
  GoogleAdWords: "GoogleAdWords",
  Hubspot: "Hubspot",
  Jira: "Jira",
  Magento: "Magento",
  Marketo: "Marketo",
  Office365: "Office365",
  Eloqua: "Eloqua",
  Responsys: "Responsys",
  OracleServiceCloud: "OracleServiceCloud",
  PayPal: "PayPal",
  QuickBooks: "QuickBooks",
  Salesforce: "Salesforce",
  SalesforceServiceCloud: "SalesforceServiceCloud",
  SalesforceMarketingCloud: "SalesforceMarketingCloud",
  SapCloudForCustomer: "SapCloudForCustomer",
  SapEcc: "SapEcc",
  ServiceNow: "ServiceNow",
  SharePointOnlineList: "SharePointOnlineList",
  Shopify: "Shopify",
  Square: "Square",
  WebTable: "WebTable",
  Xero: "Xero",
  Zoho: "Zoho",
  GenericContainerRegistry: "GenericContainerRegistry",
  OpenAI: "OpenAI",
  Serp: "Serp",
  BingLLMSearch: "BingLLMSearch",
  Serverless: "Serverless",
}

/**
 * Group based on connection category
 */
union ConnectionGroup {
  string,
  Azure: "Azure",
  AzureAI: "AzureAI",
  Database: "Database",
  NoSQL: "NoSQL",
  File: "File",
  GenericProtocol: "GenericProtocol",
  ServicesAndApps: "ServicesAndApps",
}

union ManagedPERequirement {
  string,
  Required: "Required",
  NotRequired: "NotRequired",
  NotApplicable: "NotApplicable",
}

union ManagedPEStatus {
  string,
  Inactive: "Inactive",
  Active: "Active",
  NotApplicable: "NotApplicable",
}

union DefaultResourceProvisioningState {
  string,
  NotStarted: "NotStarted",
  Failed: "Failed",
  Creating: "Creating",
  Updating: "Updating",
  Succeeded: "Succeeded",
  Deleting: "Deleting",
  Accepted: "Accepted",
  Canceled: "Canceled",
  Scaling: "Scaling",
  Disabled: "Disabled",
}

/**
 * Model lifecycle status.
 */
union ModelLifecycleStatus {
  string,
  GenerallyAvailable: "GenerallyAvailable",
  Preview: "Preview",
}

/**
 * Level at which content is filtered.
 */
union AllowedContentLevel {
  string,
  Low: "Low",
  Medium: "Medium",
  High: "High",
}

/**
 * Content source to apply the Content Filters.
 */
union RaiPolicyContentSource {
  string,
  Prompt: "Prompt",
  Completion: "Completion",
}

/**
 * Content Filters mode.
 */
union RaiPolicyMode {
  string,
  Default: "Default",
  Deferred: "Deferred",
  Blocking: "Blocking",
}

/**
 * Content Filters policy type.
 */
union RaiPolicyType {
  string,
  UserManaged: "UserManaged",
  SystemManaged: "SystemManaged",
}

/**
 * Type of the endpoint.
 */
union EndpointType {
  string,
  `Azure.OpenAI`: "Azure.OpenAI",
  `Azure.Speech`: "Azure.Speech",
  `Azure.ContentSafety`: "Azure.ContentSafety",
  `Azure.Llama`: "Azure.Llama",
  managedOnlineEndpoint: "managedOnlineEndpoint",
  serverlessEndpoint: "serverlessEndpoint",
}

/**
 * Level of workspace setup error
 */
union DiagnoseResultLevel {
  string,
  Warning: "Warning",
  Error: "Error",
  Information: "Information",
}

union ServiceAccountKeyName {
  string,
  Key1: "Key1",
  Key2: "Key2",
}

/**
 * Intended usage of the cluster
 */
union ClusterPurpose {
  string,
  FastProd: "FastProd",
  DenseProd: "DenseProd",
  DevTest: "DevTest",
}

/**
 * Enable or disable ssl for scoring
 */
union SslConfigStatus {
  string,
  Disabled: "Disabled",
  Enabled: "Enabled",
  Auto: "Auto",
}

/**
 * Load Balancer Type
 */
union LoadBalancerType {
  string,
  PublicIp: "PublicIp",
  InternalLoadBalancer: "InternalLoadBalancer",
}

/**
 * Compute OS Type
 */
union OsType {
  string,
  Linux: "Linux",
  Windows: "Windows",
}

/**
 * Virtual Machine priority
 */
union VmPriority {
  string,
  Dedicated: "Dedicated",
  LowPriority: "LowPriority",
}

/**
 * State of the public SSH port. Possible values are: Disabled - Indicates that the public ssh port is closed on all nodes of the cluster. Enabled - Indicates that the public ssh port is open on all nodes of the cluster. NotSpecified - Indicates that the public ssh port is closed on all nodes of the cluster if VNet is defined, else is open all public nodes. It can be default only during cluster creation time, after creation it will be either enabled or disabled.
 */
union RemoteLoginPortPublicAccess {
  string,
  Enabled: "Enabled",
  Disabled: "Disabled",
  NotSpecified: "NotSpecified",
}

/**
 * Allocation state of the compute. Possible values are: steady - Indicates that the compute is not resizing. There are no changes to the number of compute nodes in the compute in progress. A compute enters this state when it is created and when no operations are being performed on the compute to change the number of compute nodes. resizing - Indicates that the compute is resizing; that is, compute nodes are being added to or removed from the compute.
 */
union AllocationState {
  string,
  Steady: "Steady",
  Resizing: "Resizing",
}

/**
 * Policy for sharing applications on this compute instance among users of parent workspace. If Personal, only the creator can access applications on this compute instance. When Shared, any workspace user can access applications on this instance depending on his/her assigned role.
 */
union ApplicationSharingPolicy {
  string,
  Personal: "Personal",
  Shared: "Shared",
}

/**
 * Indicates whether mlflow autologger is enabled for notebooks.
 */
union MlflowAutologger {
  string,
  Enabled: "Enabled",
  Disabled: "Disabled",
}

/**
 * State of the public SSH port. Possible values are: Disabled - Indicates that the public ssh port is closed on this instance. Enabled - Indicates that the public ssh port is open and accessible according to the VNet/subnet policy if applicable.
 */
union SshPublicAccess {
  string,
  Enabled: "Enabled",
  Disabled: "Disabled",
}

/**
 * The os patching status.
 */
union PatchStatus {
  string,
  CompletedWithWarnings: "CompletedWithWarnings",
  Failed: "Failed",
  InProgress: "InProgress",
  Succeeded: "Succeeded",
  Unknown: "Unknown",
}

/**
 * Current state of an ComputeInstance.
 */
union ComputeInstanceState {
  string,
  Creating: "Creating",
  CreateFailed: "CreateFailed",
  Deleting: "Deleting",
  Running: "Running",
  Restarting: "Restarting",
  Resizing: "Resizing",
  JobRunning: "JobRunning",
  SettingUp: "SettingUp",
  SetupFailed: "SetupFailed",
  Starting: "Starting",
  Stopped: "Stopped",
  Stopping: "Stopping",
  UserSettingUp: "UserSettingUp",
  UserSetupFailed: "UserSetupFailed",
  Unknown: "Unknown",
  Unusable: "Unusable",
}

/**
 * The Compute Instance Authorization type. Available values are personal (default).
 */
union ComputeInstanceAuthorizationType {
  string,
  personal: "personal",
}

/**
 * Name of the last operation.
 */
union OperationName {
  string,
  Create: "Create",
  Start: "Start",
  Stop: "Stop",
  Restart: "Restart",
  Resize: "Resize",
  Reimage: "Reimage",
  Delete: "Delete",
}

/**
 * Operation status.
 */
union OperationStatus {
  string,
  InProgress: "InProgress",
  Succeeded: "Succeeded",
  CreateFailed: "CreateFailed",
  StartFailed: "StartFailed",
  StopFailed: "StopFailed",
  RestartFailed: "RestartFailed",
  ResizeFailed: "ResizeFailed",
  ReimageFailed: "ReimageFailed",
  DeleteFailed: "DeleteFailed",
}

/**
 * Trigger of operation.
 */
union OperationTrigger {
  string,
  User: "User",
  Schedule: "Schedule",
  IdleShutdown: "IdleShutdown",
}

/**
 * The current deployment state of schedule.
 */
union ProvisioningStatus {
  string,
  Completed: "Completed",
  Provisioning: "Provisioning",
  Failed: "Failed",
}

/**
 * Is the schedule enabled or disabled?
 */
union ScheduleStatus {
  string,
  Enabled: "Enabled",
  Disabled: "Disabled",
}

/**
 * [Required] The compute power action.
 */
union ComputePowerAction {
  string,
  Start: "Start",
  Stop: "Stop",
}

union ComputeTriggerType {
  string,
  Recurrence: "Recurrence",
  Cron: "Cron",
}

/**
 * Enum to describe the frequency of a compute recurrence schedule
 */
union ComputeRecurrenceFrequency {
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
 * Enum of weekday
 */
union ComputeWeekDay {
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
 * The current deployment state of schedule.
 */
union ScheduleProvisioningState {
  string,
  Completed: "Completed",
  Provisioning: "Provisioning",
  Failed: "Failed",
}

/**
 * Auto save settings.
 */
union Autosave {
  string,
  None: "None",
  Local: "Local",
  Remote: "Remote",
}

/**
 * network of this container.
 */
union Network {
  string,
  Bridge: "Bridge",
  Host: "Host",
}

/**
 * Caching type of Data Disk.
 */
union Caching {
  string,
  None: "None",
  ReadOnly: "ReadOnly",
  ReadWrite: "ReadWrite",
}

/**
 * type of this storage account.
 */
union StorageAccountType {
  string,
  Standard_LRS: "Standard_LRS",
  Premium_LRS: "Premium_LRS",
}

union MonitoringFeatureFilterType {
  string,

  /**
   * Includes all features.
   */
  AllFeatures: "AllFeatures",

  /**
   * Only includes the top contributing features, measured by feature attribution.
   */
  TopNByAttribution: "TopNByAttribution",

  /**
   * Includes a user-defined subset of features.
   */
  FeatureSubset: "FeatureSubset",
}

/**
 * Monitor compute identity type enum.
 */
union MonitorComputeIdentityType {
  string,

  /**
   * Authenticates through user's AML token.
   */
  AmlToken: "AmlToken",

  /**
   * Authenticates through a user-provided managed identity.
   */
  ManagedIdentity: "ManagedIdentity",
}

/**
 * Enum to determine the input data delivery mode.
 */
union InputDeliveryMode {
  string,
  ReadOnlyMount: "ReadOnlyMount",
  ReadWriteMount: "ReadWriteMount",
  Download: "Download",
  Direct: "Direct",
  EvalMount: "EvalMount",
  EvalDownload: "EvalDownload",
}

/**
 * Output data delivery mode enums.
 */
union OutputDeliveryMode {
  string,
  ReadWriteMount: "ReadWriteMount",
  Upload: "Upload",
  Direct: "Direct",
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
  uri_file: "uri_file",
  uri_folder: "uri_folder",
  mltable: "mltable",
  custom_model: "custom_model",
  mlflow_model: "mlflow_model",
  triton_model: "triton_model",
}

/**
 * Enum to determine the job tier.
 */
union JobTier {
  string,
  Null: "Null",
  Spot: "Spot",
  Basic: "Basic",
  Standard: "Standard",
  Premium: "Premium",
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
 * Enum to determine the Job Input Type.
 */
union JobInputType {
  string,
  literal: "literal",
  uri_file: "uri_file",
  uri_folder: "uri_folder",
  mltable: "mltable",
  custom_model: "custom_model",
  mlflow_model: "mlflow_model",
  triton_model: "triton_model",
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

/**
 * Enum to determine the type of fine tuning.
 */
union ModelProvider {
  string,

  /**
   * Fine tuning using Azure Open AI model.
   */
  AzureOpenAI: "AzureOpenAI",

  /**
   * Fine tuning using custom model.
   */
  Custom: "Custom",
}

union FineTuningTaskType {
  string,
  ChatCompletion: "ChatCompletion",
  TextCompletion: "TextCompletion",
  TextClassification: "TextClassification",
  QuestionAnswering: "QuestionAnswering",
  TextSummarization: "TextSummarization",
  TokenClassification: "TokenClassification",
  TextTranslation: "TextTranslation",
  ImageClassification: "ImageClassification",
  ImageInstanceSegmentation: "ImageInstanceSegmentation",
  ImageObjectDetection: "ImageObjectDetection",
  VideoMultiObjectTracking: "VideoMultiObjectTracking",
}

union EarlyTerminationPolicyType {
  string,
  Bandit: "Bandit",
  MedianStopping: "MedianStopping",
  TruncationSelection: "TruncationSelection",
}

union SamplingAlgorithmType {
  string,
  Grid: "Grid",
  Random: "Random",
  Bayesian: "Bayesian",
}

union CategoricalDataDriftMetric {
  string,

  /**
   * The Jensen Shannon Distance (JSD) metric.
   */
  JensenShannonDistance: "JensenShannonDistance",

  /**
   * The Population Stability Index (PSI) metric.
   */
  PopulationStabilityIndex: "PopulationStabilityIndex",

  /**
   * The Pearsons Chi Squared Test metric.
   */
  PearsonsChiSquaredTest: "PearsonsChiSquaredTest",
}

union MonitoringFeatureDataType {
  string,

  /**
   * Used for features of numerical data type.
   */
  Numerical: "Numerical",

  /**
   * Used for features of categorical data type.
   */
  Categorical: "Categorical",
}

union CategoricalDataQualityMetric {
  string,

  /**
   * Calculates the rate of null values.
   */
  NullValueRate: "NullValueRate",

  /**
   * Calculates the rate of data type errors.
   */
  DataTypeErrorRate: "DataTypeErrorRate",

  /**
   * Calculates the rate values are out of bounds.
   */
  OutOfBoundsRate: "OutOfBoundsRate",
}

union CategoricalPredictionDriftMetric {
  string,

  /**
   * The Jensen Shannon Distance (JSD) metric.
   */
  JensenShannonDistance: "JensenShannonDistance",

  /**
   * The Population Stability Index (PSI) metric.
   */
  PopulationStabilityIndex: "PopulationStabilityIndex",

  /**
   * The Pearsons Chi Squared Test metric.
   */
  PearsonsChiSquaredTest: "PearsonsChiSquaredTest",
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
 * The meta-learner is a model trained on the output of the individual heterogeneous models.
 * Default meta-learners are LogisticRegression for classification tasks (or LogisticRegressionCV if cross-validation is enabled) and ElasticNet for regression/forecasting tasks (or ElasticNetCV if cross-validation is enabled).
 * This parameter can be one of the following strings: LogisticRegression, LogisticRegressionCV, LightGBMClassifier, ElasticNet, ElasticNetCV, LightGBMRegressor, or LinearRegression
 */
union StackMetaLearnerType {
  string,
  None: "None",

  /**
   * Default meta-learners are LogisticRegression for classification tasks.
   */
  LogisticRegression: "LogisticRegression",

  /**
   * Default meta-learners are LogisticRegression for classification task when CV is on.
   */
  LogisticRegressionCV: "LogisticRegressionCV",

  LightGBMClassifier: "LightGBMClassifier",

  /**
   * Default meta-learners are LogisticRegression for regression task.
   */
  ElasticNet: "ElasticNet",

  /**
   * Default meta-learners are LogisticRegression for regression task when CV is on.
   */
  ElasticNetCV: "ElasticNetCV",

  LightGBMRegressor: "LightGBMRegressor",
  LinearRegression: "LinearRegression",
}

/**
 * Enum for all classification models supported by AutoML.
 */
union BlockedTransformers {
  string,

  /**
   * Target encoding for text data.
   */
  TextTargetEncoder: "TextTargetEncoder",

  /**
   * Ohe hot encoding creates a binary feature transformation.
   */
  OneHotEncoder: "OneHotEncoder",

  /**
   * Target encoding for categorical data.
   */
  CatTargetEncoder: "CatTargetEncoder",

  /**
   * Tf-Idf stands for, term-frequency times inverse document-frequency. This is a common term weighting scheme for identifying information from documents.
   */
  TfIdf: "TfIdf",

  /**
   * Weight of Evidence encoding is a technique used to encode categorical variables. It uses the natural log of the P(1)/P(0) to create weights.
   */
  WoETargetEncoder: "WoETargetEncoder",

  /**
   * Label encoder converts labels/categorical variables in a numerical form.
   */
  LabelEncoder: "LabelEncoder",

  /**
   * Word embedding helps represents words or phrases as a vector, or a series of numbers.
   */
  WordEmbedding: "WordEmbedding",

  /**
   * Naive Bayes is a classified that is used for classification of discrete features that are categorically distributed.
   */
  NaiveBayes: "NaiveBayes",

  /**
   * Count Vectorizer converts a collection of text documents to a matrix of token counts.
   */
  CountVectorizer: "CountVectorizer",

  /**
   * Hashing One Hot Encoder can turn categorical variables into a limited number of new features. This is often used for high-cardinality categorical features.
   */
  HashOneHotEncoder: "HashOneHotEncoder",
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
 * Enum to determine the job distribution type.
 */
union DistributionType {
  string,
  PyTorch: "PyTorch",
  TensorFlow: "TensorFlow",
  Mpi: "Mpi",
}

union JobLimitsType {
  string,
  Command: "Command",
  Sweep: "Sweep",
}

/**
 * Monitor compute type enum.
 */
union MonitorComputeType {
  string,

  /**
   * Serverless Spark compute.
   */
  ServerlessSpark: "ServerlessSpark",
}

/**
 * Model task type enum.
 */
union ModelTaskType {
  string,
  Classification: "Classification",
  Regression: "Regression",
}

union MonitoringNotificationType {
  string,

  /**
   * Enables email notifications through AML notifications.
   */
  AmlNotification: "AmlNotification",
}

union MonitoringSignalType {
  string,

  /**
   * Tracks model input data distribution change, comparing against training data or past production data.
   */
  DataDrift: "DataDrift",

  /**
   * Tracks prediction result data distribution change, comparing against validation/test label data or past production data.
   */
  PredictionDrift: "PredictionDrift",

  /**
   * Tracks model input data integrity.
   */
  DataQuality: "DataQuality",

  /**
   * Tracks feature importance change in production, comparing against feature importance at training time.
   */
  FeatureAttributionDrift: "FeatureAttributionDrift",

  /**
   * Tracks a custom signal provided by users.
   */
  Custom: "Custom",
}

/**
 * Monitoring input data type enum.
 */
union MonitoringInputDataType {
  string,

  /**
   * An input data with a fixed window size.
   */
  Static: "Static",

  /**
   * An input data which rolls relatively to the monitor's current run time.
   */
  Rolling: "Rolling",

  /**
   * An input data with tabular format which doesn't require preprocessing.
   */
  Fixed: "Fixed",
}

/**
 * The mode of operation for computing feature importance.
 */
union FeatureImportanceMode {
  string,

  /**
   * Disables computing feature importance within a signal.
   */
  Disabled: "Disabled",

  /**
   * Enables computing feature importance within a signal.
   */
  Enabled: "Enabled",
}

union FeatureAttributionMetric {
  string,

  /**
   * The Normalized Discounted Cumulative Gain metric.
   */
  NormalizedDiscountedCumulativeGain: "NormalizedDiscountedCumulativeGain",
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

  Sum: "Sum",
  Max: "Max",
  Min: "Min",
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

  Season: "Season",
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
   * TCNForecaster: Temporal Convolutional Networks Forecaster. //TODO: Ask forecasting team for brief intro.
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
 * Enum to determine OneLake artifact type.
 */
union OneLakeArtifactType {
  string,
  LakeHouse: "LakeHouse",
}

union NumericalDataDriftMetric {
  string,

  /**
   * The Jensen Shannon Distance (JSD) metric.
   */
  JensenShannonDistance: "JensenShannonDistance",

  /**
   * The Population Stability Index (PSI) metric.
   */
  PopulationStabilityIndex: "PopulationStabilityIndex",

  /**
   * The Normalized Wasserstein Distance metric.
   */
  NormalizedWassersteinDistance: "NormalizedWassersteinDistance",

  /**
   * The Two Sample Kolmogorov-Smirnov Test (two-sample K–S) metric.
   */
  TwoSampleKolmogorovSmirnovTest: "TwoSampleKolmogorovSmirnovTest",
}

union NumericalDataQualityMetric {
  string,

  /**
   * Calculates the rate of null values.
   */
  NullValueRate: "NullValueRate",

  /**
   * Calculates the rate of data type errors.
   */
  DataTypeErrorRate: "DataTypeErrorRate",

  /**
   * Calculates the rate values are out of bounds.
   */
  OutOfBoundsRate: "OutOfBoundsRate",
}

union NumericalPredictionDriftMetric {
  string,

  /**
   * The Jensen Shannon Distance (JSD) metric.
   */
  JensenShannonDistance: "JensenShannonDistance",

  /**
   * The Population Stability Index (PSI) metric.
   */
  PopulationStabilityIndex: "PopulationStabilityIndex",

  /**
   * The Normalized Wasserstein Distance metric.
   */
  NormalizedWassersteinDistance: "NormalizedWassersteinDistance",

  /**
   * The Two Sample Kolmogorov-Smirnov Test (two-sample K–S) metric.
   */
  TwoSampleKolmogorovSmirnovTest: "TwoSampleKolmogorovSmirnovTest",
}

/**
 * Defines supported metric goals for hyperparameter tuning
 */
union Goal {
  string,
  Minimize: "Minimize",
  Maximize: "Maximize",
}

/**
 * The specific type of random algorithm
 */
union RandomSamplingAlgorithmRule {
  string,
  Random: "Random",
  Sobol: "Sobol",
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

union SparkJobEntryType {
  string,
  SparkJobPythonEntry: "SparkJobPythonEntry",
  SparkJobScalaEntry: "SparkJobScalaEntry",
}

/**
 * Deployment model version upgrade option.
 */
union DeploymentModelVersionUpgradeOption {
  string,
  OnceNewDefaultVersionAvailable: "OnceNewDefaultVersionAvailable",
  OnceCurrentVersionExpired: "OnceCurrentVersionExpired",
  NoAutoUpgrade: "NoAutoUpgrade",
}

/**
 * The action enum for networking rule.
 */
union RuleAction {
  string,
  Allow: "Allow",
  Deny: "Deny",
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
  @visibility("read")
  id?: string;

  /**
   * Region of the AML workspace in the id.
   */
  @visibility("read")
  amlWorkspaceLocation?: string;

  /**
   * Specifies the resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * An enum describing the unit of usage measurement.
   */
  @visibility("read")
  unit?: UsageUnit;

  /**
   * The current usage of the resource.
   */
  @visibility("read")
  currentValue?: int64;

  /**
   * The maximum permitted usage of the resource.
   */
  @visibility("read")
  limit?: int64;

  /**
   * The name of the type of usage.
   */
  @visibility("read")
  name?: UsageName;
}

/**
 * The Usage Names.
 */
model UsageName {
  /**
   * The name of the resource.
   */
  @visibility("read")
  value?: string;

  /**
   * The localized name of the resource.
   */
  @visibility("read")
  localizedValue?: string;
}

/**
 * The List Virtual Machine size operation response.
 */
model VirtualMachineSizeListResult {
  /**
   * The list of virtual machine sizes supported by AmlCompute.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  value?: VirtualMachineSize[];
}

/**
 * Describes the properties of a VM size.
 */
model VirtualMachineSize {
  /**
   * The name of the virtual machine size.
   */
  @visibility("read")
  name?: string;

  /**
   * The family name of the virtual machine size.
   */
  @visibility("read")
  family?: string;

  /**
   * The number of vCPUs supported by the virtual machine size.
   */
  @visibility("read")
  vCPUs?: int32;

  /**
   * The number of gPUs supported by the virtual machine size.
   */
  @visibility("read")
  gpus?: int32;

  /**
   * The OS VHD disk size, in MB, allowed by the virtual machine size.
   */
  @visibility("read")
  osVhdSizeMB?: int32;

  /**
   * The resource volume size, in MB, allowed by the virtual machine size.
   */
  @visibility("read")
  maxResourceVolumeMB?: int32;

  /**
   * The amount of memory, in GB, supported by the virtual machine size.
   */
  @visibility("read")
  memoryGB?: float64;

  /**
   * Specifies if the virtual machine size supports low priority VMs.
   */
  @visibility("read")
  lowPriorityCapable?: boolean;

  /**
   * Specifies if the virtual machine size supports premium IO.
   */
  @visibility("read")
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
  @OpenAPI.extension("x-ms-identifiers", [])
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
model UpdateWorkspaceQuotasResult {
  /**
   * The list of workspace quota update result.
   */
  @visibility("read")
  value?: UpdateWorkspaceQuotas[];

  /**
   * The URI to fetch the next page of workspace quota update result. Call ListNext() with this to fetch the next page of Workspace Quota update result.
   */
  @visibility("read")
  nextLink?: string;
}

/**
 * The properties for update Quota response.
 */
model UpdateWorkspaceQuotas {
  /**
   * Specifies the resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * Specifies the resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * The maximum permitted quota of the resource.
   */
  limit?: int64;

  /**
   * An enum describing the unit of quota measurement.
   */
  @visibility("read")
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
  @visibility("read")
  id?: string;

  /**
   * Region of the AML workspace in the id.
   */
  @visibility("read")
  amlWorkspaceLocation?: string;

  /**
   * Specifies the resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * Name of the resource.
   */
  @visibility("read")
  name?: ResourceName;

  /**
   * The maximum permitted quota of the resource.
   */
  @visibility("read")
  limit?: int64;

  /**
   * An enum describing the unit of quota measurement.
   */
  @visibility("read")
  unit?: QuotaUnit;
}

/**
 * The Resource Name.
 */
model ResourceName {
  /**
   * The name of the resource.
   */
  @visibility("read")
  value?: string;

  /**
   * The localized name of the resource.
   */
  @visibility("read")
  localizedValue?: string;
}

/**
 * The resource model definition representing SKU
 */
model Sku {
  /**
   * The name of the SKU. Ex - P3. It is typically a letter+number code
   */
  name: string;

  /**
   * This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.
   */
  tier?: SkuTier;

  /**
   * The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code.
   */
  size?: string;

  /**
   * If the service has different generations of hardware, for the same SKU, then that can be captured here.
   */
  family?: string;

  /**
   * If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted.
   */
  capacity?: int32;
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

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

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
   * Location for the underlying compute
   */
  @visibility("read", "create")
  computeLocation?: string;

  /**
   * The provision state of the cluster. Valid values are Unknown, Updating, Provisioning, Succeeded, and Failed.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The description of the Machine Learning compute.
   */
  description?: string;

  /**
   * The time at which the compute was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * The time at which the compute was last modified.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedOn?: utcDateTime;

  /**
   * ARM resource id of the underlying compute
   */
  resourceId?: string;

  /**
   * Errors during provisioning
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["/error/code"])
  provisioningErrors?: ErrorResponse[];

  /**
   * Indicating whether the compute was provisioned by user and brought from outside if true, or machine learning service provisioned it if false.
   */
  @visibility("read")
  isAttachedCompute?: boolean;

  /**
   * Opt-out of local authentication and ensure customers can use only MSI and AAD exclusively for authentication.
   */
  @visibility("read", "create")
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
 * Specifies the custom service configuration
 */
model CustomService {
  ...Record<unknown>;

  /**
   * Name of the Custom Service
   */
  name?: string;

  /**
   * Describes the Image Specifications
   */
  image?: Image;

  /**
   * Environment Variable for the container
   */
  environmentVariables?: Record<EnvironmentVariable>;

  /**
   * Describes the docker settings for the image
   */
  docker?: Docker;

  /**
   * Configuring the endpoints for the container
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  endpoints?: Endpoint[];

  /**
   * Configuring the volumes for the container
   */
  @OpenAPI.extension("x-ms-identifiers", ["source", "target"])
  volumes?: VolumeDefinition[];

  /**
   * Describes the jupyter kernel settings for the image if its a custom environment
   */
  kernel?: JupyterKernelConfig;
}

model Image {
  ...Record<unknown>;

  /**
   * Type of the image. Possible values are: docker - For docker images. azureml - For AzureML Environment images (custom and curated)
   */
  type?: ImageType = ImageType.docker;

  /**
   * Image reference URL if type is docker. Environment name if type is azureml
   */
  reference?: string;

  /**
   * Version of image being used. If latest then skip this field
   */
  version?: string;
}

model EnvironmentVariable {
  ...Record<unknown>;

  /**
   * Type of the Environment Variable. Possible values are: local - For local variable
   */
  type?: EnvironmentVariableType = EnvironmentVariableType.local;

  /**
   * Value of the Environment variable
   */
  value?: string;
}

model Docker {
  ...Record<unknown>;

  /**
   * Indicate whether container shall run in privileged or non-privileged mode.
   */
  privileged?: boolean;
}

model Endpoint {
  /**
   * Protocol over which communication will happen over this endpoint
   */
  protocol?: Protocol = Protocol.tcp;

  /**
   * Name of the Endpoint
   */
  name?: string;

  /**
   * Application port inside the container.
   */
  target?: int32;

  /**
   * Port over which the application is exposed from container.
   */
  published?: int32;

  /**
   * Host IP over which the application is exposed from the container
   */
  hostIp?: string;
}

model VolumeDefinition {
  /**
   * Type of Volume Definition. Possible Values: bind,volume,tmpfs,npipe
   */
  type?: VolumeDefinitionType = VolumeDefinitionType.bind;

  /**
   * Indicate whether to mount volume as readOnly. Default value for this is false.
   */
  readOnly?: boolean;

  /**
   * Source of the mount. For bind mounts this is the host path.
   */
  source?: string;

  /**
   * Target of the mount. For bind mounts this is the path in the container.
   */
  target?: string;

  /**
   * Consistency of the volume
   */
  consistency?: string;

  /**
   * Bind Options of the mount
   */
  bind?: BindOptions;

  /**
   * Volume Options of the mount
   */
  volume?: VolumeOptions;

  /**
   * tmpfs option of the mount
   */
  tmpfs?: TmpfsOptions;
}

model BindOptions {
  /**
   * Type of Bind Option
   */
  propagation?: string;

  /**
   * Indicate whether to create host path.
   */
  createHostPath?: boolean;

  /**
   * Mention the selinux options.
   */
  selinux?: string;
}

model VolumeOptions {
  /**
   * Indicate whether volume is nocopy
   */
  nocopy?: boolean;
}

model TmpfsOptions {
  /**
   * Mention the Tmpfs size
   */
  size?: int32;
}

/**
 * Jupyter kernel configuration.
 */
model JupyterKernelConfig {
  /**
   * Argument to the the runtime
   */
  argv?: string[];

  /**
   * Display name of the kernel
   */
  displayName?: string;

  /**
   * Language of the kernel [Example value: python]
   */
  language?: string;
}

/**
 * Result of AmlCompute Nodes
 */
@pagedResult
model AmlComputeNodesInformation {
  /**
   * The collection of returned AmlCompute nodes details.
   */
  @visibility("read")
  @items
  @OpenAPI.extension("x-ms-identifiers", ["nodeId"])
  nodes?: AmlComputeNodeInformation[];

  /**
   * The continuation token.
   */
  @visibility("read")
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
  @visibility("read")
  nodeId?: string;

  /**
   * Private IP address of the compute node.
   */
  @visibility("read")
  privateIpAddress?: string;

  /**
   * Public IP address of the compute node.
   */
  @visibility("read")
  publicIpAddress?: string;

  /**
   * SSH port number of the node.
   */
  @visibility("read")
  port?: int32;

  /**
   * State of the compute node. Values are idle, running, preparing, unusable, leaving and preempted.
   */
  @visibility("read")
  nodeState?: NodeState;

  /**
   * ID of the Experiment running on the node, if any else null.
   */
  @visibility("read")
  runId?: string;
}

/**
 * Secrets related to a Machine Learning compute. Might differ for every type of compute.
 */
@discriminator("computeType")
model ComputeSecrets {}

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
   * Mount Mode.
   */
  mountMode?: MountMode;

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
 * Stops compute instance after user defined period of inactivity.
 */
model IdleShutdownSetting {
  /**
   * Time is defined in ISO8601 format. Minimum is 15 min, maximum is 3 days.
   */
  idleTimeBeforeShutdown?: string;
}

/**
 * Schema for Compute Instance resize.
 */
model ResizeSchema {
  /**
   * The name of the virtual machine size.
   */
  targetVMSize?: string;
}

/**
 * Container for code asset versions.
 */
model CodeContainerProperties extends AssetContainer {
  /**
   * Provisioning state for the code container.
   */
  @visibility("read")
  provisioningState?: AssetProvisioningState;
}

model AssetContainer extends ResourceBase {
  /**
   * Is the asset archived?
   */
  @visibility("read", "create", "update")
  isArchived?: boolean;

  /**
   * The latest version inside this container.
   */
  @visibility("read")
  latestVersion?: string;

  /**
   * The next auto incremental version
   */
  @visibility("read")
  nextVersion?: string;
}

model ResourceBase {
  /**
   * The asset description text.
   */
  description?: string;

  /**
   * The asset property dictionary.
   */
  properties?: Record<string>;

  /**
   * Tag dictionary. Tags can be added, removed, and updated.
   */
  tags?: Record<string>;
}

/**
 * Code asset version details.
 */
model CodeVersionProperties extends AssetBase {
  /**
   * Uri where code is located
   */
  codeUri?: string;

  /**
   * Provisioning state for the code version.
   */
  @visibility("read")
  provisioningState?: AssetProvisioningState;
}

model AssetBase extends ResourceBase {
  /**
   * If the name version are system generated (anonymous registration).
   */
  @visibility("read", "create")
  isAnonymous?: boolean;

  /**
   * Is the asset archived?
   */
  @visibility("read", "create", "update")
  isArchived?: boolean;
}

model PendingUploadRequestDto {
  /**
   * If PendingUploadId = null then random guid will be used.
   */
  pendingUploadId?: string;

  /**
   * TemporaryBlobReference is the only supported type
   */
  pendingUploadType?: PendingUploadType;
}

model PendingUploadResponseDto {
  /**
   * Container level read, write, list SAS
   */
  blobReferenceForConsumption?: BlobReferenceForConsumptionDto;

  /**
   * ID for this upload request
   */
  pendingUploadId?: string;

  /**
   * TemporaryBlobReference is the only supported type
   */
  pendingUploadType?: PendingUploadType;
}

model BlobReferenceForConsumptionDto {
  /**
   * Blob URI path for client to upload data.
   * Example: https://blob.windows.core.net/Container/Path
   */
  blobUri?: url;

  /**
   * Credential info to access storage account
   */
  credential?: PendingUploadCredentialDto;

  /**
   * Arm ID of the storage account to use
   */
  storageAccountArmId?: string;
}

@discriminator("credentialType")
model PendingUploadCredentialDto {}

/**
 * Component container definition.
 * <see href="https://docs.microsoft.com/en-us/azure/machine-learning/reference-yaml-component-command" />
 */
model ComponentContainerProperties extends AssetContainer {
  /**
   * Provisioning state for the component container.
   */
  @visibility("read")
  provisioningState?: AssetProvisioningState;
}

/**
 * Definition of a component version: defines resources that span component types.
 */
model ComponentVersionProperties extends AssetBase {
  /**
   * Defines Component definition details.
   * <see href="https://docs.microsoft.com/en-us/azure/machine-learning/reference-yaml-component-command" />
   */
  @visibility("read", "create")
  componentSpec?: Record<unknown>;

  /**
   * Provisioning state for the component version.
   */
  @visibility("read")
  provisioningState?: AssetProvisioningState;
}

/**
 * Container for data asset versions.
 */
model DataContainerProperties extends AssetContainer {
  /**
   * [Required] Specifies the type of data.
   */
  @visibility("read", "create")
  dataType: DataType;
}

/**
 * BlobReferenceSASRequest for getBlobReferenceSAS API
 */
model GetBlobReferenceSASRequestDto {
  /**
   * Id of the asset to be accessed
   */
  assetId?: string;

  /**
   * Blob uri of the asset to be accessed
   */
  blobUri?: url;
}

/**
 * BlobReferenceSASResponse for getBlobReferenceSAS API
 */
model GetBlobReferenceSASResponseDto {
  /**
   * Blob reference for consumption details
   */
  blobReferenceForConsumption?: GetBlobReferenceForConsumptionDto;
}

model GetBlobReferenceForConsumptionDto {
  /**
   * Blob uri, example: https://blob.windows.core.net/Container/Path
   */
  blobUri?: url;

  /**
   * Credential info to access storage account
   */
  credential?: DataReferenceCredential;

  /**
   * The ARM id of the storage account
   */
  storageAccountArmId?: string;
}

/**
 * DataReferenceCredential base class
 */
@discriminator("credentialType")
model DataReferenceCredential {}

/**
 * Container for environment specification versions.
 */
model EnvironmentContainerProperties extends AssetContainer {
  /**
   * Provisioning state for the environment container.
   */
  @visibility("read")
  provisioningState?: AssetProvisioningState;
}

/**
 * Environment version details.
 */
model EnvironmentVersionProperties extends AssetBase {
  /**
   * Defines if image needs to be rebuilt based on base image changes.
   */
  @visibility("read", "create")
  autoRebuild?: AutoRebuildSetting;

  /**
   * Configuration settings for Docker build context.
   */
  @visibility("read", "create")
  build?: BuildContext;

  /**
   * Standard configuration file used by Conda that lets you install any kind of package, including Python, R, and C/C++ packages.
   * <see href="https://repo2docker.readthedocs.io/en/latest/config_files.html#environment-yml-install-a-conda-environment" />
   */
  @visibility("read", "create")
  condaFile?: string;

  /**
   * Environment type is either user managed or curated by the Azure ML service
   * <see href="https://docs.microsoft.com/en-us/azure/machine-learning/resource-curated-environments" />
   */
  @visibility("read")
  environmentType?: EnvironmentType;

  /**
   * Name of the image that will be used for the environment.
   * <seealso href="https://docs.microsoft.com/en-us/azure/machine-learning/how-to-deploy-custom-docker-image#use-a-custom-base-image" />
   */
  @visibility("read", "create")
  image?: string;

  /**
   * Defines configuration specific to inference.
   */
  @visibility("read", "create")
  inferenceConfig?: InferenceContainerProperties;

  /**
   * The OS type of the environment.
   */
  @visibility("read", "create")
  osType?: OperatingSystemType;

  /**
   * Provisioning state for the environment version.
   */
  @visibility("read")
  provisioningState?: AssetProvisioningState;

  /**
   * Stage in the environment lifecycle assigned to this environment
   */
  stage?: string;
}

/**
 * Configuration settings for Docker build context
 */
model BuildContext {
  /**
   * [Required] URI of the Docker build context used to build the image. Supports blob URIs on environment creation and may return blob or Git URIs.
   * <seealso href="https://docs.docker.com/engine/reference/commandline/build/#extended-description" />
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  contextUri: string;

  /**
   * Path to the Dockerfile in the build context.
   * <seealso href="https://docs.docker.com/engine/reference/builder/" />
   */
  @visibility("read", "create")
  dockerfilePath?: string = "Dockerfile";
}

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

model Route {
  /**
   * [Required] The path for the route.
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  path: string;

  /**
   * [Required] The port for the route.
   */
  port: int32;
}

model ModelContainerProperties extends AssetContainer {
  /**
   * Provisioning state for the model container.
   */
  @visibility("read")
  provisioningState?: AssetProvisioningState;
}

/**
 * Model asset version details.
 */
model ModelVersionProperties extends AssetBase {
  /**
   * Mapping of model flavors to their properties.
   */
  flavors?: Record<FlavorData>;

  /**
   * Name of the training job which produced this model
   */
  jobName?: string;

  /**
   * The storage format for this entity. Used for NCD.
   */
  modelType?: string;

  /**
   * The URI path to the model contents.
   */
  modelUri?: string;

  /**
   * Provisioning state for the model version.
   */
  @visibility("read")
  provisioningState?: AssetProvisioningState;

  /**
   * Stage in the model lifecycle assigned to this model
   */
  stage?: string;
}

model FlavorData {
  /**
   * Model flavor-specific data.
   */
  data?: Record<string>;
}

/**
 * Batch endpoint configuration.
 */
model BatchEndpointProperties extends EndpointPropertiesBase {
  /**
   * Default values for Batch Endpoint
   */
  defaults?: BatchEndpointDefaults;

  /**
   * Provisioning state for the endpoint.
   */
  @visibility("read")
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
  @visibility("create")
  keys?: EndpointAuthKeys;

  /**
   * Property dictionary. Properties can be added, but not removed or altered.
   */
  properties?: Record<string>;

  /**
   * Endpoint URI.
   */
  @visibility("read")
  scoringUri?: url;

  /**
   * Endpoint Swagger URI.
   */
  @visibility("read")
  swaggerUri?: url;
}

/**
 * Keys for endpoint authentication.
 */
model EndpointAuthKeys {
  /**
   * The primary key.
   */
  @visibility("read", "create")
  primaryKey?: string;

  /**
   * The secondary key.
   */
  @visibility("read", "create")
  secondaryKey?: string;
}

/**
 * Strictly used in update requests.
 */
model PartialMinimalTrackedResource {
  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * Batch inference settings per deployment.
 */
model BatchDeploymentProperties extends EndpointDeploymentPropertiesBase {
  /**
   * Compute target for batch inference operation.
   */
  compute?: string;

  /**
   * Properties relevant to different deployment types.
   */
  deploymentConfiguration?: BatchDeploymentConfiguration;

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
  @visibility("read")
  provisioningState?: DeploymentProvisioningState;

  /**
   * Indicates compute configuration for the job.
   * If not provided, will default to the defaults defined in ResourceConfiguration.
   */
  resources?: DeploymentResourceConfiguration;

  /**
   * Retry Settings for the batch inference operation.
   * If not provided, will default to the defaults defined in BatchRetrySettings.
   */
  retrySettings?: BatchRetrySettings;
}

/**
 * Properties relevant to different deployment types.
 */
@discriminator("deploymentConfigurationType")
model BatchDeploymentConfiguration {}

/**
 * Base definition for asset references.
 */
@discriminator("referenceType")
model AssetReferenceBase {}

model DeploymentResourceConfiguration extends ResourceConfiguration {}

model ResourceConfiguration {
  /**
   * Optional number of instances or nodes used by the compute target.
   */
  @visibility("read", "create")
  instanceCount?: int32 = 1;

  /**
   * Optional type of VM used as supported by the compute target.
   */
  @visibility("read", "create")
  instanceType?: string;

  /**
   * Additional properties bag.
   */
  @visibility("read", "create")
  properties?: Record<Record<unknown>>;
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
   * ARM resource ID or AssetId of the environment specification for the endpoint deployment.
   */
  environmentId?: string;

  /**
   * Environment variables configuration for the deployment.
   */
  environmentVariables?: Record<string>;

  /**
   * Property dictionary. Properties can be added, but not removed or altered.
   */
  properties?: Record<string>;
}

/**
 * Configuration for a scoring code asset.
 */
model CodeConfiguration {
  /**
   * ARM resource ID of the code asset.
   */
  @visibility("read", "create")
  codeId?: string;

  /**
   * [Required] The script to execute on startup. eg. "score.py"
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  scoringScript: string;
}

/**
 * Strictly used in update requests.
 */
model PartialBatchDeploymentPartialMinimalTrackedResourceWithProperties {
  /**
   * Additional attributes of the entity.
   */
  properties?: PartialBatchDeployment;

  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * Mutable batch inference settings per deployment.
 */
model PartialBatchDeployment {
  /**
   * Description of the endpoint deployment.
   */
  description?: string;
}

/**
 * Publishing destination registry asset information
 */
model DestinationAsset {
  /**
   * Destination asset name
   */
  destinationName?: string;

  /**
   * Destination asset version
   */
  destinationVersion?: string;

  /**
   * Destination registry name
   */
  registryName?: string;
}

/**
 * Base definition for datastore contents configuration.
 */
@discriminator("datastoreType")
model DatastoreProperties extends ResourceBase {
  /**
   * [Required] Account credentials.
   */
  credentials: DatastoreCredentials;

  /**
   * Readonly property to indicate if datastore is the workspace default datastore
   */
  @visibility("read")
  isDefault?: boolean;
}

/**
 * Base definition for datastore credentials.
 */
@discriminator("credentialsType")
model DatastoreCredentials {}

/**
 * Secret expiration configuration.
 */
model SecretExpiry {
  /**
   * Indicates if the secret is expirable.
   */
  expirableSecret?: boolean;

  /**
   * Number of hours after which the secret will expire.
   */
  expireAfterHours?: int32 = 1;
}

/**
 * Base definition for datastore secrets.
 */
@discriminator("secretsType")
model DatastoreSecrets {}

/**
 * DTO object representing feature set
 */
model FeaturesetContainerProperties extends AssetContainer {
  /**
   * Provisioning state for the featureset container.
   */
  @visibility("read")
  provisioningState?: AssetProvisioningState;
}

/**
 * DTO object representing feature
 */
model FeatureProperties extends ResourceBase {
  /**
   * Specifies type
   */
  dataType?: FeatureDataType;

  /**
   * Specifies name
   */
  featureName?: string;
}

/**
 * DTO object representing feature set version
 */
model FeaturesetVersionProperties extends AssetBase {
  /**
   * Specifies list of entities
   */
  entities?: string[];

  /**
   * Specifies the materialization settings
   */
  materializationSettings?: MaterializationSettings;

  /**
   * Provisioning state for the featureset version container.
   */
  @visibility("read")
  provisioningState?: AssetProvisioningState;

  /**
   * Specifies the feature spec details
   */
  specification?: FeaturesetSpecification;

  /**
   * Specifies the asset stage
   */
  stage?: string;
}

model MaterializationSettings {
  /**
   * Specifies the notification details
   */
  notification?: NotificationSetting;

  /**
   * Specifies the compute resource settings
   */
  resource?: MaterializationComputeResource;

  /**
   * Specifies the schedule details
   */
  schedule?: RecurrenceTrigger;

  /**
   * Specifies the spark compute settings
   */
  sparkConfiguration?: Record<string>;

  /**
   * Specifies the stores to which materialization should happen
   */
  storeType?: MaterializationStoreType;
}

/**
 * Configuration for notification.
 */
model NotificationSetting {
  /**
   * Send email notification to user on specified notification type
   */
  @visibility("read", "create")
  emailOn?: EmailNotificationEnableType[];

  /**
   * This is the email recipient list which has a limitation of 499 characters in total concat with comma separator
   */
  @visibility("read", "create")
  emails?: string[];

  /**
   * Send webhook callback to a service. Key is a user-provided name for the webhook.
   */
  @visibility("read", "create", "update")
  webhooks?: Record<Webhook>;
}

/**
 * Webhook base
 */
@discriminator("webhookType")
model Webhook {
  /**
   * Send callback on a specified notification event
   */
  @visibility("read", "create")
  eventType?: string;
}

/**
 * DTO object representing compute resource
 */
model MaterializationComputeResource {
  /**
   * Specifies the instance type
   */
  instanceType?: string;
}

model RecurrenceTrigger extends TriggerBase {
  /**
   * [Required] The frequency to trigger schedule.
   */
  frequency: RecurrenceFrequency;

  /**
   * [Required] Specifies schedule interval in conjunction with frequency
   */
  interval: int32;

  /**
   * The recurrence schedule.
   */
  schedule?: RecurrenceSchedule;

  /**
   * [Required]
   */
  triggerType: "Recurrence";
}

model RecurrenceSchedule {
  /**
   * [Required] List of hours for the schedule.
   */
  hours: int32[];

  /**
   * [Required] List of minutes for the schedule.
   */
  minutes: int32[];

  /**
   * List of month days for the schedule
   */
  monthDays?: int32[];

  /**
   * List of days for the schedule.
   */
  weekDays?: WeekDay[];
}

@discriminator("triggerType")
model TriggerBase {
  /**
   * Specifies end time of schedule in ISO 8601, but without a UTC offset. Refer https://en.wikipedia.org/wiki/ISO_8601.
   * Recommented format would be "2022-06-01T00:00:01"
   * If not present, the schedule will run indefinitely
   */
  endTime?: string;

  /**
   * Specifies start time of schedule in ISO 8601 format, but without a UTC offset.
   */
  startTime?: string;

  /**
   * Specifies time zone in which the schedule runs.
   * TimeZone should follow Windows time zone format. Refer: https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/default-time-zones?view=windows-11
   */
  timeZone?: string = "UTC";
}

/**
 * DTO object representing specification
 */
model FeaturesetSpecification {
  /**
   * Specifies the spec path
   */
  path?: string;
}

/**
 * Request payload for creating a backfill request for a given feature set version
 */
model FeaturesetVersionBackfillRequest {
  /**
   * Specified the data availability status that you want to backfill
   */
  dataAvailabilityStatus?: DataAvailabilityStatus[];

  /**
   * Specifies description
   */
  description?: string;

  /**
   * Specifies description
   */
  displayName?: string;

  /**
   * Specifies the backfill feature window to be materialized
   */
  featureWindow?: FeatureWindow;

  /**
   * Specify the jobId to retry the failed materialization
   */
  jobId?: string;

  /**
   * Specifies the properties
   */
  properties?: Record<string>;

  /**
   * Specifies the compute resource settings
   */
  resource?: MaterializationComputeResource;

  /**
   * Specifies the spark compute settings
   */
  sparkConfiguration?: Record<string>;

  /**
   * Specifies the tags
   */
  tags?: Record<string>;
}

/**
 * Specifies the feature window
 */
model FeatureWindow {
  /**
   * Specifies the feature window end time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  featureWindowEnd?: utcDateTime;

  /**
   * Specifies the feature window start time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  featureWindowStart?: utcDateTime;
}

/**
 * Response payload for creating a backfill request for a given feature set version
 */
model FeaturesetVersionBackfillResponse {
  /**
   * List of jobs submitted as part of the backfill request.
   */
  jobIds?: string[];
}

/**
 * DTO object representing feature entity
 */
model FeaturestoreEntityContainerProperties extends AssetContainer {
  /**
   * Provisioning state for the featurestore entity container.
   */
  @visibility("read")
  provisioningState?: AssetProvisioningState;
}

/**
 * DTO object representing feature entity version
 */
model FeaturestoreEntityVersionProperties extends AssetBase {
  /**
   * Specifies index columns
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  indexColumns?: IndexColumn[];

  /**
   * Provisioning state for the featurestore entity version.
   */
  @visibility("read")
  provisioningState?: AssetProvisioningState;

  /**
   * Specifies the asset stage
   */
  stage?: string;
}

/**
 * DTO object representing index column
 */
model IndexColumn {
  /**
   * Specifies the column name
   */
  columnName?: string;

  /**
   * Specifies the data type
   */
  dataType?: FeatureDataType;
}

/**
 * Base definition for a job.
 */
@discriminator("jobType")
model JobBaseProperties extends ResourceBase {
  /**
   * ARM resource ID of the component resource.
   */
  @visibility("read", "create")
  componentId?: string;

  /**
   * ARM resource ID of the compute resource.
   */
  @visibility("read", "create")
  computeId?: string;

  /**
   * Display name of job.
   */
  @visibility("read", "create")
  displayName?: string;

  /**
   * The name of the experiment the job belongs to. If not set, the job is placed in the "Default" experiment.
   */
  @visibility("read", "create")
  experimentName?: string = "Default";

  /**
   * Identity configuration. If set, this should be one of AmlToken, ManagedIdentity, UserIdentity or null.
   * Defaults to AmlToken if null.
   */
  @visibility("read", "create")
  identity?: IdentityConfiguration;

  /**
   * Is the asset archived?
   */
  @visibility("read", "create", "update")
  isArchived?: boolean;

  /**
   * Notification setting for the job
   */
  @visibility("read", "create", "update")
  notificationSetting?: NotificationSetting;

  /**
   * List of JobEndpoints.
   * For local jobs, a job endpoint will have an endpoint value of FileStreamObject.
   */
  services?: Record<JobService>;

  /**
   * Status of the job.
   */
  @visibility("read")
  status?: JobStatus;
}

/**
 * Base definition for identity configuration.
 */
@discriminator("identityType")
model IdentityConfiguration {}

/**
 * Job endpoint definition
 */
model JobService {
  /**
   * Url for endpoint.
   */
  @visibility("read", "create")
  endpoint?: string;

  /**
   * Any error in the service.
   */
  @visibility("read")
  errorMessage?: string;

  /**
   * Endpoint type.
   */
  @visibility("read", "create")
  jobServiceType?: string;

  /**
   * Nodes that user would like to start the service on.
   * If Nodes is not set or set to null, the service will only be started on leader node.
   */
  nodes?: Nodes;

  /**
   * Port for endpoint.
   */
  @visibility("read", "create")
  port?: int32;

  /**
   * Additional properties to set on the endpoint.
   */
  properties?: Record<string>;

  /**
   * Status of endpoint.
   */
  @visibility("read")
  status?: string;
}

/**
 * Abstract Nodes definition
 */
@discriminator("nodesValueType")
model Nodes {}

/**
 * Online endpoint configuration
 */
model OnlineEndpointProperties extends EndpointPropertiesBase {
  /**
   * ARM resource ID of the compute if it exists.
   * optional
   */
  compute?: string;

  /**
   * Percentage of traffic to be mirrored to each deployment without using returned scoring. Traffic values need to sum to utmost 50.
   */
  mirrorTraffic?: Record<int32>;

  /**
   * Provisioning state for the endpoint.
   */
  @visibility("read")
  provisioningState?: EndpointProvisioningState;

  /**
   * Set to "Enabled" for endpoints that should allow public access when Private Link is enabled.
   */
  publicNetworkAccess?: PublicNetworkAccessType;

  /**
   * Percentage of traffic from endpoint to divert to each deployment. Traffic values need to sum to 100.
   */
  traffic?: Record<int32>;
}

@discriminator("endpointComputeType")
model OnlineDeploymentProperties extends EndpointDeploymentPropertiesBase {
  /**
   * If true, enables Application Insights logging.
   */
  appInsightsEnabled?: boolean;

  /**
   * The mdc configuration, we disable mdc when it's null.
   */
  dataCollector?: DataCollector;

  /**
   * If Enabled, allow egress public network access. If Disabled, this will create secure egress. Default: Enabled.
   */
  egressPublicNetworkAccess?: EgressPublicNetworkAccessType;

  /**
   * Compute instance type.
   */
  @visibility("read", "create")
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
   * Provisioning state for the endpoint deployment.
   */
  @visibility("read")
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

model DataCollector {
  /**
   * [Required] The collection configuration. Each collection has it own configuration to collect model data and the name of collection can be arbitrary string.
   * Model data collector can be used for either payload logging or custom logging or both of them. Collection request and response are reserved for payload logging, others are for custom logging.
   */
  collections: Record<Collection>;

  /**
   * The request logging configuration for mdc, it includes advanced logging settings for all collections. It's optional.
   */
  requestLogging?: RequestLogging;

  /**
   * When model data is collected to blob storage, we need to roll the data to different path to avoid logging all of them in a single blob file.
   * If the rolling rate is hour, all data will be collected in the blob path /yyyy/MM/dd/HH/.
   * If it's day, all data will be collected in blob path /yyyy/MM/dd/.
   * The other benefit of rolling path is that model monitoring ui is able to select a time range of data very quickly.
   */
  rollingRate?: RollingRateType;
}

model Collection {
  /**
   * The msi client id used to collect logging to blob storage. If it's null,backend will pick a registered endpoint identity to auth.
   */
  clientId?: string;

  /**
   * Enable or disable data collection.
   */
  dataCollectionMode?: DataCollectionMode;

  /**
   * The data asset arm resource id. Client side will ensure data asset is pointing to the blob storage, and backend will collect data to the blob storage.
   */
  dataId?: string;

  /**
   * The sampling rate for collection. Sampling rate 1.0 means we collect 100% of data by default.
   */
  samplingRate?: float64 = 1;
}

model RequestLogging {
  /**
   * For payload logging, we only collect payload by default. If customers also want to collect the specified headers, they can set them in captureHeaders so that backend will collect those headers along with payload.
   */
  captureHeaders?: string[];
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
   * (Deprecated for Managed Online Endpoints) The maximum amount of time a request will stay in the queue in ISO 8601 format.
   * Defaults to 500ms.
   * (Now increase `request_timeout_ms` to account for any networking/queue delays)
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
model OnlineScaleSettings {}

/**
 * Strictly used in update requests.
 */
model PartialMinimalTrackedResourceWithSku
  extends PartialMinimalTrackedResource {
  /**
   * Sku details required for ARM contract for Autoscaling.
   */
  sku?: PartialSku;
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
  tier?: SkuTier;
}

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
  @visibility("read")
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
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  name: string;

  /**
   * This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.
   */
  tier?: SkuTier;
}

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
 * Base definition of a schedule
 */
model ScheduleProperties extends ResourceBase {
  /**
   * [Required] Specifies the action of the schedule
   */
  @visibility("read", "create", "update")
  action: ScheduleActionBase;

  /**
   * Display name of schedule.
   */
  @visibility("read", "create")
  displayName?: string;

  /**
   * Is the schedule enabled?
   */
  @visibility("read", "create", "update")
  isEnabled?: boolean = true;

  /**
   * Provisioning state for the schedule.
   */
  @visibility("read")
  provisioningState?: ScheduleProvisioningStatus;

  /**
   * [Required] Specifies the trigger details
   */
  @visibility("read", "create", "update")
  trigger: TriggerBase;
}

@discriminator("actionType")
model ScheduleActionBase {}

model ServerlessEndpointProperties {
  /**
   * [Required] Specifies the authentication mode for the Serverless endpoint.
   */
  authMode: ServerlessInferenceEndpointAuthMode;

  /**
   * Specifies the content safety options. If omitted, the default content safety settings will be configured
   */
  contentSafety?: ContentSafety;

  /**
   * The current state of the ServerlessEndpoint.
   */
  @visibility("read")
  endpointState?: ServerlessEndpointState;

  /**
   * The inference uri to target when making requests against the serverless endpoint
   */
  @visibility("read")
  inferenceEndpoint?: ServerlessInferenceEndpoint;

  /**
   * The MarketplaceSubscription Azure ID associated to this ServerlessEndpoint.
   */
  @visibility("read")
  marketplaceSubscriptionId?: string;

  /**
   * The model settings (model id) for the model being serviced on the ServerlessEndpoint.
   */
  modelSettings?: ModelSettings;

  /**
   * Provisioning state for the endpoint.
   */
  @visibility("read")
  provisioningState?: EndpointProvisioningState;
}

model ContentSafety {
  /**
   * [Required] Specifies the status of content safety.
   */
  contentSafetyStatus: ContentSafetyStatus;
}

model ServerlessInferenceEndpoint {
  /**
   * Specifies any required headers to target this serverless endpoint.
   */
  @visibility("read")
  headers?: Record<string>;

  /**
   * [Required] The inference uri to target when making requests against the Serverless Endpoint.
   */
  @visibility("read")
  uri: url;
}

model ModelSettings {
  /**
   * The unique model identifier that this ServerlessEndpoint should provision.
   */
  modelId?: string;
}

/**
 * Details of the Registry
 */
model RegistryProperties {
  /**
   * Discovery URL for the Registry
   */
  discoveryUrl?: string;

  /**
   * IntellectualPropertyPublisher for the registry
   */
  intellectualPropertyPublisher?: string;

  /**
   * ResourceId of the managed RG if the registry has system created resources
   */
  managedResourceGroup?: ArmResourceId;

  /**
   * Managed resource group specific settings
   */
  managedResourceGroupSettings?: ManagedResourceGroupSettings;

  /**
   * MLFlow Registry URI for the Registry
   */
  mlFlowRegistryUri?: string;

  /**
   * Is the Registry accessible from the internet?
   * Possible values: "Enabled" or "Disabled"
   */
  publicNetworkAccess?: string;

  /**
   * Details of each region the registry is in
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  regionDetails?: RegistryRegionArmDetails[];
}

/**
 * ARM ResourceId of a resource
 */
model ArmResourceId {
  /**
   * Arm ResourceId is in the format "/subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.Storage/storageAccounts/{StorageAccountName}"
   * or "/subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.ContainerRegistry/registries/{AcrName}"
   */
  resourceId?: string;
}

/**
 * Managed resource group settings
 */
model ManagedResourceGroupSettings {
  /**
   * List of assigned identities for the managed resource group
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  assignedIdentities?: ManagedResourceGroupAssignedIdentities[];
}

/**
 * Details for managed resource group assigned identities.
 */
model ManagedResourceGroupAssignedIdentities {
  /**
   * Identity principal Id
   */
  @visibility("read")
  principalId?: string;
}

/**
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint
   */
  @visibility("read")
  id?: string;
}

/**
 * The connection state.
 */
model RegistryPrivateLinkServiceConnectionState {
  /**
   * Some RP chose "None". Other RPs use this for region expansion.
   */
  actionsRequired?: string;

  /**
   * User-defined message that, per NRP doc, may be used for approval-related message.
   */
  description?: string;

  /**
   * Connection status of the service consumer with the service provider
   */
  status?: EndpointServiceConnectionStatus;
}

/**
 * Details for each region the registry is in
 */
model RegistryRegionArmDetails {
  /**
   * List of ACR accounts
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  acrDetails?: AcrDetails[];

  /**
   * The location where the registry exists
   */
  location?: string;

  /**
   * List of storage accounts
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  storageAccountDetails?: StorageAccountDetails[];
}

/**
 * Details of ACR account to be used for the Registry
 */
model AcrDetails {
  /**
   * Details of system created ACR account to be used for the Registry
   */
  systemCreatedAcrAccount?: SystemCreatedAcrAccount;

  /**
   * Details of user created ACR account to be used for the Registry
   */
  userCreatedAcrAccount?: UserCreatedAcrAccount;
}

model SystemCreatedAcrAccount {
  /**
   * Name of the ACR account
   */
  acrAccountName?: string;

  /**
   * SKU of the ACR account
   */
  acrAccountSku?: string;

  /**
   * This is populated once the ACR account is created.
   */
  armResourceId?: ArmResourceId;
}

model UserCreatedAcrAccount {
  /**
   * ARM ResourceId of a resource
   */
  armResourceId?: ArmResourceId;
}

/**
 * Details of storage account to be used for the Registry
 */
model StorageAccountDetails {
  /**
   * Details of system created storage account to be used for the registry
   */
  systemCreatedStorageAccount?: SystemCreatedStorageAccount;

  /**
   * Details of user created storage account to be used for the registry
   */
  userCreatedStorageAccount?: UserCreatedStorageAccount;
}

model SystemCreatedStorageAccount {
  /**
   * Public blob access allowed
   */
  allowBlobPublicAccess?: boolean;

  /**
   * This is populated once the storage account is created.
   */
  armResourceId?: ArmResourceId;

  /**
   * HNS enabled for storage account
   */
  storageAccountHnsEnabled?: boolean;

  /**
   * Name of the storage account
   */
  storageAccountName?: string;

  /**
   * Allowed values:
   * "Standard_LRS",
   * "Standard_GRS",
   * "Standard_RAGRS",
   * "Standard_ZRS",
   * "Standard_GZRS",
   * "Standard_RAGZRS",
   * "Premium_LRS",
   * "Premium_ZRS"
   */
  storageAccountType?: string;
}

model UserCreatedStorageAccount {
  /**
   * ARM ResourceId of a resource
   */
  armResourceId?: ArmResourceId;
}

/**
 * Identity object used for encryption.
 */
model IdentityForCmk {
  /**
   * UserAssignedIdentity to be used to fetch the encryption key from keyVault
   */
  userAssignedIdentity?: string;
}

/**
 * Customer Key vault properties.
 */
model KeyVaultProperties {
  /**
   * Currently, we support only SystemAssigned MSI.
   * We need this when we support UserAssignedIdentities
   */
  identityClientId?: string;

  /**
   * KeyVault key identifier to encrypt the data
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  keyIdentifier: string;

  /**
   * KeyVault Arm Id that contains the data encryption key
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  keyVaultArmId: string;
}

model FeatureStoreSettings {
  computeRuntime?: ComputeRuntimeDto;
  offlineStoreConnectionName?: string;
  onlineStoreConnectionName?: string;
}

model ComputeRuntimeDto {
  sparkRuntimeVersion?: string;
}

/**
 * Managed Network settings for a machine learning workspace.
 */
model ManagedNetworkSettings {
  /**
   * Isolation mode for the managed network of a machine learning workspace.
   */
  isolationMode?: IsolationMode;

  @visibility("read")
  networkId?: string;

  /**
   * Dictionary of <OutboundRule>
   */
  outboundRules?: Record<OutboundRule>;

  /**
   * Status of the Provisioning for the managed network of a machine learning workspace.
   */
  status?: ManagedNetworkProvisionStatus;

  @visibility("read")
  changeableIsolationModes?: IsolationMode[];
}

/**
 * Outbound Rule for the managed network of a machine learning workspace.
 */
@discriminator("type")
model OutboundRule {
  /**
   * Category of a managed network Outbound Rule of a machine learning workspace.
   */
  category?: RuleCategory;

  @visibility("read")
  parentRuleNames?: string[];

  /**
   * Type of a managed network Outbound Rule of a machine learning workspace.
   */
  status?: RuleStatus;
}

/**
 * Status of the Provisioning for the managed network of a machine learning workspace.
 */
model ManagedNetworkProvisionStatus {
  sparkReady?: boolean;

  /**
   * Status for the managed network of a machine learning workspace.
   */
  status?: ManagedNetworkStatus;
}

/**
 * The Private Endpoint resource.
 */
model WorkspacePrivateEndpointResource {
  /**
   * e.g. /subscriptions/{networkSubscriptionId}/resourceGroups/{rgName}/providers/Microsoft.Network/privateEndpoints/{privateEndpointName}
   */
  @visibility("read")
  id?: string;

  /**
   * The subnetId that the private endpoint is connected to.
   */
  @visibility("read")
  subnetArmId?: string;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Some RP chose "None". Other RPs use this for region expansion.
   */
  actionsRequired?: string;

  /**
   * User-defined message that, per NRP doc, may be used for approval-related message.
   */
  description?: string;

  /**
   * Connection status of the service consumer with the service provider
   */
  status?: EndpointServiceConnectionStatus;
}

model ServerlessComputeSettings {
  /**
   * The resource ID of an existing virtual network subnet in which serverless compute nodes should be deployed
   */
  serverlessComputeCustomSubnet?: Azure.Core.armResourceIdentifier;

  /**
   * The flag to signal if serverless compute nodes deployed in custom vNet would have no public IP addresses for a workspace with private endpoint
   */
  serverlessComputeNoPublicIP?: boolean;
}

model ServiceManagedResourcesSettings {
  cosmosDb?: CosmosDbSettings;
}

model CosmosDbSettings {
  collectionsThroughput?: int32;
}

model SharedPrivateLinkResource {
  /**
   * Unique name of the private link
   */
  name?: string;

  /**
   * Properties of a shared private link resource.
   */
  properties?: SharedPrivateLinkResourceProperty;
}

/**
 * Properties of a shared private link resource.
 */
model SharedPrivateLinkResourceProperty {
  /**
   * group id of the private link
   */
  groupId?: string;

  /**
   * the resource id that private link links to
   */
  privateLinkResourceId?: string;

  /**
   * Request message
   */
  requestMessage?: string;

  /**
   * Connection status of the service consumer with the service provider
   */
  status?: EndpointServiceConnectionStatus;
}

/**
 * The parameters for updating a machine learning workspace.
 */
model WorkspacePropertiesUpdateParameters {
  allowRoleAssignmentOnRG?: boolean;

  /**
   * ARM id of the application insights associated with this workspace.
   */
  applicationInsights?: string;

  /**
   * ARM id of the container registry associated with this workspace.
   */
  containerRegistry?: string;

  /**
   * The description of this workspace.
   */
  description?: string;

  enableDataIsolation?: boolean;

  /**
   * Flag to tell if SoftwareBillOfMaterials should be enabled for this workspace
   */
  enableSoftwareBillOfMaterials?: boolean;

  encryption?: EncryptionUpdateProperties;

  /**
   * Settings for feature store type workspace.
   */
  featureStoreSettings?: FeatureStoreSettings;

  /**
   * The friendly name for this workspace. This name in mutable
   */
  friendlyName?: string;

  /**
   * The compute name for image build
   */
  imageBuildCompute?: string;

  /**
   * The list of IPv4 addresses that are allowed to access the workspace.
   */
  ipAllowlist?: string[];

  /**
   * Managed Network settings for a machine learning workspace.
   */
  managedNetwork?: ManagedNetworkSettings;

  /**
   * The user assigned identity resource id that represents the workspace identity.
   */
  primaryUserAssignedIdentity?: string;

  /**
   * Whether requests from Public Network are allowed.
   */
  publicNetworkAccess?: PublicNetworkAccessType;

  /**
   * Settings for serverless compute in a workspace
   */
  serverlessComputeSettings?: ServerlessComputeSettings;

  /**
   * The service managed resource settings.
   */
  serviceManagedResourcesSettings?: ServiceManagedResourcesSettings;

  /**
   * Retention time in days after workspace get soft deleted.
   */
  softDeleteRetentionInDays?: int32;

  /**
   * The auth mode used for accessing the system datastores of the workspace.
   */
  systemDatastoresAuthMode?: string;

  /**
   * Enabling v1_legacy_mode may prevent you from using features provided by the v2 API.
   */
  v1LegacyMode?: boolean;
}

model EncryptionUpdateProperties {
  keyVaultProperties: EncryptionKeyVaultUpdateProperties;
}

model EncryptionKeyVaultUpdateProperties {
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  keyIdentifier: string;
}

@discriminator("authType")
model WorkspaceConnectionPropertiesV2 {
  /**
   * Category of the connection
   */
  category?: ConnectionCategory;

  @visibility("read")
  createdByWorkspaceArmId?: Azure.Core.armResourceIdentifier;

  error?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  /**
   * Group based on connection category
   */
  @visibility("read")
  group?: ConnectionGroup;

  isSharedToAll?: boolean;

  /**
   * Store user metadata for this connection
   */
  metadata?: Record<string>;

  peRequirement?: ManagedPERequirement;
  peStatus?: ManagedPEStatus;
  sharedUserList?: string[];
  target?: string;
  useWorkspaceManagedIdentity?: boolean;
}

/**
 * The properties that the machine learning workspace connection will be updated with.
 */
model WorkspaceConnectionUpdateParameter {
  /**
   * The properties that the machine learning workspace connection will be updated with.
   */
  properties?: WorkspaceConnectionPropertiesV2;
}

@discriminator("type")
model EndpointDeploymentResourceProperties {
  /**
   * The failure reason if the creation failed.
   */
  failureReason?: string;

  /**
   * Read-only provision state status property.
   */
  @visibility("read")
  provisioningState?: DefaultResourceProvisioningState;
}

model EndpointModels is Azure.Core.Page<EndpointModelProperties>;

/**
 * Endpoint Model properties.
 */
model EndpointModelProperties {
  /**
   * The capabilities.
   */
  capabilities?: Record<string>;

  deprecation?: EndpointModelDeprecationProperties;

  /**
   * The capabilities for finetune models.
   */
  finetuneCapabilities?: Record<string>;

  /**
   * Deployment model format.
   */
  format?: string;

  /**
   * If the model is default version.
   */
  isDefaultVersion?: boolean;

  /**
   * Model lifecycle status.
   */
  lifecycleStatus?: ModelLifecycleStatus;

  /**
   * The max capacity.
   */
  maxCapacity?: int32;

  /**
   * Deployment model name.
   */
  name?: string;

  /**
   * The list of Model Sku.
   */
  skus?: EndpointModelSkuProperties[];

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility("read")
  systemData?: SystemData;

  /**
   * Optional. Deployment model version. If version is not specified, a default version will be assigned. The default version is different for different models and might change when there is new version available for a model. Default version for a model could be found from list models API.
   */
  version?: string;
}

model EndpointModelDeprecationProperties {
  /**
   * The datetime of deprecation of the fineTune Model.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fineTune?: utcDateTime;

  /**
   * The datetime of deprecation of the inference Model.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  inference?: utcDateTime;
}

model EndpointModelSkuProperties {
  capacity?: EndpointModelSkuCapacityProperties;

  /**
   * The list of ARM id for the connection support this SKU.
   */
  connectionIds?: Azure.Core.armResourceIdentifier[];

  /**
   * The datetime of deprecation of the model SKU.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deprecationDate?: utcDateTime;

  /**
   * The name of the model SKU.
   */
  name?: string;

  rateLimits?: EndpointModelSkuRateLimitProperties[];

  /**
   * The usage name of the model SKU.
   */
  usageName?: string;
}

model EndpointModelSkuCapacityProperties {
  /**
   * The default capacity.
   */
  default?: int32;

  /**
   * The maximum capacity.
   */
  maximum?: int32;
}

model EndpointModelSkuRateLimitProperties {
  /**
   * The count value of Call Rate Limit.
   */
  count?: float32;

  /**
   * The renewal period in seconds of Call Rate Limit.
   */
  renewalPeriod?: float32;

  /**
   * The call rate limit for the model.
   */
  rules?: EndpointModelSkuRateLimitRuleProperties[];
}

model EndpointModelSkuRateLimitRuleProperties {
  count?: float32;

  /**
   * If the dynamic throttling is enabled.
   */
  dynamicThrottlingEnabled?: boolean;

  key?: string;
  matchPatterns?: EndpointModelSkuRateLimitRulePatternProperties[];
  minCount?: float32;
  renewalPeriod?: float32;
}

model EndpointModelSkuRateLimitRulePatternProperties {
  method?: string;
  path?: string;
}

/**
 * RAI Custom Blocklist properties.
 */
model RaiBlocklistProperties {
  /**
   * Description of the block list.
   */
  description?: string;
}

/**
 * The Cognitive Services RaiBlocklist Item request body.
 */
model RaiBlocklistItemBulkRequest {
  name?: string;

  /**
   * Properties of Cognitive Services RaiBlocklist Item.
   */
  properties?: RaiBlocklistItemProperties;
}

/**
 * RAI Custom Blocklist Item properties.
 */
model RaiBlocklistItemProperties {
  /**
   * If the pattern is a regex pattern.
   */
  isRegex?: boolean;

  /**
   * Pattern to match against.
   */
  pattern?: string;
}

/**
 * Azure OpenAI Content Filters properties.
 */
model RaiPolicyProperties {
  /**
   * Name of the base Content Filters.
   */
  basePolicyName?: string;

  completionBlocklists?: RaiBlocklistConfig[];
  contentFilters?: RaiPolicyContentFilter[];

  /**
   * Content Filters mode.
   */
  mode?: RaiPolicyMode;

  promptBlocklists?: RaiBlocklistConfig[];

  /**
   * Content Filters policy type.
   */
  type?: RaiPolicyType;
}

/**
 * Azure OpenAI blocklist config.
 */
model RaiBlocklistConfig {
  /**
   * If blocking would occur.
   */
  blocking?: boolean;

  /**
   * Name of ContentFilter.
   */
  blocklistName?: string;
}

/**
 * Azure OpenAI Content Filter.
 */
model RaiPolicyContentFilter {
  /**
   * Level at which content is filtered.
   */
  allowedContentLevel?: AllowedContentLevel;

  /**
   * If blocking would occur.
   */
  blocking?: boolean;

  /**
   * If the ContentFilter is enabled.
   */
  enabled?: boolean;

  /**
   * Name of ContentFilter.
   */
  name?: string;

  /**
   * Content source to apply the Content Filters.
   */
  source?: RaiPolicyContentSource;
}

/**
 * Parameters to diagnose a workspace
 */
model DiagnoseWorkspaceParameters {
  value?: DiagnoseRequestProperties;
}

model DiagnoseRequestProperties {
  /**
   * Setting for diagnosing dependent application insights
   */
  applicationInsights?: Record<unknown>;

  /**
   * Setting for diagnosing dependent container registry
   */
  containerRegistry?: Record<unknown>;

  /**
   * Setting for diagnosing dns resolution
   */
  dnsResolution?: Record<unknown>;

  /**
   * Setting for diagnosing dependent key vault
   */
  keyVault?: Record<unknown>;

  /**
   * Setting for diagnosing network security group
   */
  nsg?: Record<unknown>;

  /**
   * Setting for diagnosing unclassified category of problems
   */
  others?: Record<unknown>;

  /**
   * Setting for diagnosing the presence of required resource providers in the workspace.
   */
  requiredResourceProviders?: Record<unknown>;

  /**
   * Setting for diagnosing resource lock
   */
  resourceLock?: Record<unknown>;

  /**
   * Setting for diagnosing dependent storage account
   */
  storageAccount?: Record<unknown>;

  /**
   * Setting for diagnosing user defined routing
   */
  udr?: Record<unknown>;
}

model DiagnoseResponseResult {
  value?: DiagnoseResponseResultValue;
}

model DiagnoseResponseResultValue {
  @OpenAPI.extension("x-ms-identifiers", ["message"])
  userDefinedRouteResults?: DiagnoseResult[];

  @OpenAPI.extension("x-ms-identifiers", ["message"])
  networkSecurityRuleResults?: DiagnoseResult[];

  @OpenAPI.extension("x-ms-identifiers", ["message"])
  resourceLockResults?: DiagnoseResult[];

  @OpenAPI.extension("x-ms-identifiers", ["message"])
  dnsResolutionResults?: DiagnoseResult[];

  @OpenAPI.extension("x-ms-identifiers", ["message"])
  storageAccountResults?: DiagnoseResult[];

  @OpenAPI.extension("x-ms-identifiers", ["message"])
  keyVaultResults?: DiagnoseResult[];

  @OpenAPI.extension("x-ms-identifiers", ["message"])
  containerRegistryResults?: DiagnoseResult[];

  @OpenAPI.extension("x-ms-identifiers", ["message"])
  applicationInsightsResults?: DiagnoseResult[];

  @OpenAPI.extension("x-ms-identifiers", ["message"])
  otherResults?: DiagnoseResult[];
}

/**
 * Result of Diagnose
 */
model DiagnoseResult {
  /**
   * Code for workspace setup error
   */
  @visibility("read")
  code?: string;

  /**
   * Level of workspace setup error
   */
  @visibility("read")
  level?: DiagnoseResultLevel;

  /**
   * Message of workspace setup error
   */
  @visibility("read")
  message?: string;
}

model EndpointKeys {
  /**
   * Dictionary of Keys for the endpoint.
   */
  keys?: AccountApiKeys;
}

model AccountApiKeys {
  key1?: string;
  key2?: string;
}

model RegenerateServiceAccountKeyContent {
  keyName?: ServiceAccountKeyName;
}

model ListWorkspaceKeysResult {
  /**
   * The access key of the workspace app insights
   */
  @visibility("read")
  appInsightsInstrumentationKey?: string;

  containerRegistryCredentials?: RegistryListCredentialsResult;
  notebookAccessKeys?: ListNotebookKeysResult;

  /**
   * The arm Id key of the workspace storage
   */
  @visibility("read")
  userStorageArmId?: string;

  /**
   * The access key of the workspace storage
   */
  @visibility("read")
  userStorageKey?: string;
}

model RegistryListCredentialsResult {
  /**
   * The location of the workspace ACR
   */
  @visibility("read")
  location?: string;

  @OpenAPI.extension("x-ms-identifiers", ["name"])
  passwords?: Password[];

  /**
   * The username of the workspace ACR
   */
  @visibility("read")
  username?: string;
}

model Password {
  @visibility("read")
  name?: string;

  @visibility("read")
  value?: string;
}

model ListNotebookKeysResult {
  /**
   * The primary access key of the Notebook
   */
  @visibility("read")
  primaryAccessKey?: string;

  /**
   * The secondary access key of the Notebook
   */
  @visibility("read")
  secondaryAccessKey?: string;
}

model NotebookAccessTokenResult {
  @visibility("read")
  accessToken?: string;

  @visibility("read")
  expiresIn?: int32;

  @visibility("read")
  hostName?: string;

  @visibility("read")
  notebookResourceId?: string;

  @visibility("read")
  publicDns?: string;

  @visibility("read")
  refreshToken?: string;

  @visibility("read")
  scope?: string;

  @visibility("read")
  tokenType?: string;
}

model ListStorageAccountKeysResult {
  /**
   * The access key of the storage
   */
  @visibility("read")
  userStorageKey?: string;
}

model ExternalFqdnResponse {
  @OpenAPI.extension("x-ms-identifiers", ["/properties/category"])
  value?: FqdnEndpointsPropertyBag[];
}

/**
 * Property bag for FQDN endpoints result
 */
model FqdnEndpointsPropertyBag {
  properties?: FqdnEndpoints;
}

model FqdnEndpoints {
  category?: string;

  @OpenAPI.extension("x-ms-identifiers", ["domainName"])
  endpoints?: FqdnEndpoint[];
}

model FqdnEndpoint {
  domainName?: string;

  @OpenAPI.extension("x-ms-identifiers", ["port"])
  endpointDetails?: FqdnEndpointDetail[];
}

model FqdnEndpointDetail {
  port?: int32;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * Managed Network Provisioning options for managed network of a machine learning workspace.
 */
model ManagedNetworkProvisionOptions {
  includeSpark?: boolean;
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
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["publicIpAddress"])
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
  @visibility("read")
  systemServiceType?: string;

  /**
   * Public IP address
   */
  @visibility("read")
  publicIpAddress?: string;

  /**
   * The version for this type.
   */
  @visibility("read")
  version?: string;
}

/**
 * The ssl configuration for scoring
 */
model SslConfiguration {
  /**
   * Enable or disable ssl for scoring
   */
  status?: SslConfigStatus;

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
  instanceTypes?: Record<InstanceTypeSchema>;
}

/**
 * Instance type schema.
 */
model InstanceTypeSchema {
  /**
   * Node Selector
   */
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
  requests?: Record<string>;

  /**
   * Resource limits for this instance type
   */
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
  @visibility("read")
  allocationState?: AllocationState;

  /**
   * The time at which the compute entered its current allocation state.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  allocationStateTransitionTime?: utcDateTime;

  /**
   * Collection of errors encountered by various compute nodes during node setup.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["/error/code"])
  errors?: ErrorResponse[];

  /**
   * The number of compute nodes currently assigned to the compute.
   */
  @visibility("read")
  currentNodeCount?: int32;

  /**
   * The target number of compute nodes for the compute. If the allocationState is resizing, this property denotes the target node count for the ongoing resize operation. If the allocationState is steady, this property denotes the target node count for the previous resize operation.
   */
  @visibility("read")
  targetNodeCount?: int32;

  /**
   * Counts of various node states on the compute.
   */
  @visibility("read")
  nodeStateCounts?: NodeStateCounts;

  /**
   * Enable or disable node public IP address provisioning. Possible values are: Possible values are: true - Indicates that the compute nodes will have public IPs provisioned. false - Indicates that the compute nodes will have a private endpoint and no public IPs.
   */
  enableNodePublicIp?: boolean = true;

  /**
   * A property bag containing additional properties.
   */
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
  @visibility("read")
  idleNodeCount?: int32;

  /**
   * Number of compute nodes which are running jobs.
   */
  @visibility("read")
  runningNodeCount?: int32;

  /**
   * Number of compute nodes which are being prepared.
   */
  @visibility("read")
  preparingNodeCount?: int32;

  /**
   * Number of compute nodes which are in unusable state.
   */
  @visibility("read")
  unusableNodeCount?: int32;

  /**
   * Number of compute nodes which are leaving the amlCompute.
   */
  @visibility("read")
  leavingNodeCount?: int32;

  /**
   * Number of compute nodes which are in preempted state.
   */
  @visibility("read")
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
   * Specifies settings for autologger.
   */
  autologgerSettings?: ComputeInstanceAutologgerSettings;

  /**
   * Specifies policy and settings for SSH access.
   */
  sshSettings?: ComputeInstanceSshSettings;

  /**
   * List of Custom Services added to the compute.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  customServices?: CustomService[];

  /**
   * Returns metadata about the operating system image for this compute instance.
   */
  @visibility("read")
  osImageMetadata?: ImageMetadata;

  /**
   * Describes all connectivity endpoints available for this ComputeInstance.
   */
  @visibility("read")
  connectivityEndpoints?: ComputeInstanceConnectivityEndpoints;

  /**
   * Describes available applications and their endpoints on this ComputeInstance.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["displayName"])
  applications?: ComputeInstanceApplication[];

  /**
   * Describes information on user who created this ComputeInstance.
   */
  @visibility("read")
  createdBy?: ComputeInstanceCreatedBy;

  /**
   * Collection of errors encountered on this ComputeInstance.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["/error/code"])
  errors?: ErrorResponse[];

  /**
   * The current state of this ComputeInstance.
   */
  @visibility("read")
  state?: ComputeInstanceState;

  /**
   * The Compute Instance Authorization type. Available values are personal (default).
   */
  computeInstanceAuthorizationType?: ComputeInstanceAuthorizationType = ComputeInstanceAuthorizationType.personal;

  /**
   * Enable Auto OS Patching. Possible values are: true, false.
   */
  enableOSPatching?: boolean;

  /**
   * Enable root access. Possible values are: true, false.
   */
  enableRootAccess?: boolean = true;

  /**
   * Enable SSO (single sign on). Possible values are: true, false.
   */
  enableSSO?: boolean = true;

  /**
   * Release quota if compute instance stopped. Possible values are: true - release quota if compute instance stopped. false - don't release quota when compute instance stopped.
   */
  releaseQuotaOnStop?: boolean;

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
  @visibility("read")
  lastOperation?: ComputeInstanceLastOperation;

  /**
   * The list of schedules to be applied on the computes.
   */
  schedules?: ComputeSchedules;

  /**
   * Stops compute instance after user defined period of inactivity. Time is defined in ISO8601 format. Minimum is 15 min, maximum is 3 days.
   */
  idleTimeBeforeShutdown?: string;

  /**
   * Enable or disable node public IP address provisioning. Possible values are: Possible values are: true - Indicates that the compute nodes will have public IPs provisioned. false - Indicates that the compute nodes will have a private endpoint and no public IPs.
   */
  enableNodePublicIp?: boolean;

  /**
   * Describes informations of containers on this ComputeInstance.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  containers?: ComputeInstanceContainer[];

  /**
   * Describes informations of dataDisks on this ComputeInstance.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  dataDisks?: ComputeInstanceDataDisk[];

  /**
   * Describes informations of dataMounts on this ComputeInstance.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  dataMounts?: ComputeInstanceDataMount[];

  /**
   * ComputeInstance version.
   */
  @visibility("read")
  versions?: ComputeInstanceVersion;
}

/**
 * Specifies settings for autologger.
 */
model ComputeInstanceAutologgerSettings {
  /**
   * Indicates whether mlflow autologger is enabled for notebooks.
   */
  mlflowAutologger?: MlflowAutologger;
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
  @visibility("read")
  adminUserName?: string;

  /**
   * Describes the port for connecting through SSH.
   */
  @visibility("read")
  sshPort?: int32;

  /**
   * Specifies the SSH rsa public key file as a string. Use "ssh-keygen -t rsa -b 2048" to generate your SSH key pairs.
   */
  adminPublicKey?: string;
}

/**
 * Returns metadata about the operating system image for this compute instance.
 */
model ImageMetadata {
  /**
   * Specifies the current operating system image version this compute instance is running on.
   */
  currentImageVersion?: string;

  /**
   * Specifies the latest available operating system image version.
   */
  latestImageVersion?: string;

  /**
   * Specifies whether this compute instance is running on the latest operating system image.
   */
  isLatestOsImageVersion?: boolean;

  /**
   * Metadata about the os patching.
   */
  @visibility("read")
  osPatchingStatus?: OsPatchingStatus;
}

/**
 * Returns metadata about the os patching.
 */
model OsPatchingStatus {
  /**
   * The os patching status.
   */
  patchStatus?: PatchStatus;

  /**
   * Time of the latest os patching.
   */
  latestPatchTime?: string;

  /**
   * Specifies whether this compute instance is pending for reboot to finish os patching.
   */
  rebootPending?: boolean;

  /**
   * Time of scheduled reboot.
   */
  scheduledRebootTime?: string;

  /**
   * Collection of errors encountered when doing os patching.
   */
  @OpenAPI.extension("x-ms-identifiers", ["/error/code"])
  osPatchingErrors?: ErrorResponse[];
}

/**
 * Defines all connectivity endpoints and properties for an ComputeInstance.
 */
model ComputeInstanceConnectivityEndpoints {
  /**
   * Public IP Address of this ComputeInstance.
   */
  @visibility("read")
  publicIpAddress?: string;

  /**
   * Private IP Address of this ComputeInstance (local to the VNET in which the compute instance is deployed).
   */
  @visibility("read")
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
  @visibility("read")
  userName?: string;

  /**
   * Uniquely identifies user' Azure Active Directory organization.
   */
  @visibility("read")
  userOrgId?: string;

  /**
   * Uniquely identifies the user within his/her organization.
   */
  @visibility("read")
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
   * A system assigned id for the schedule.
   */
  @visibility("read")
  id?: string;

  /**
   * The current deployment state of schedule.
   */
  @visibility("read")
  provisioningStatus?: ProvisioningStatus;

  /**
   * Is the schedule enabled or disabled?
   */
  status?: ScheduleStatus;

  /**
   * [Required] The compute power action.
   */
  action?: ComputePowerAction;

  /**
   * [Required] The schedule trigger type.
   */
  triggerType?: ComputeTriggerType;

  /**
   * Required if triggerType is Recurrence.
   */
  recurrence?: Recurrence;

  /**
   * Required if triggerType is Cron.
   */
  cron?: Cron;

  /**
   * [Deprecated] Not used any more.
   */
  schedule?: ScheduleBase;
}

/**
 * The workflow trigger recurrence for ComputeStartStop schedule type.
 */
model Recurrence {
  /**
   * [Required] The frequency to trigger schedule.
   */
  frequency?: ComputeRecurrenceFrequency;

  /**
   * [Required] Specifies schedule interval in conjunction with frequency
   */
  interval?: int32;

  /**
   * The start time in yyyy-MM-ddTHH:mm:ss format.
   */
  startTime?: string;

  /**
   * Specifies time zone in which the schedule runs.
   * TimeZone should follow Windows time zone format. Refer: https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/default-time-zones?view=windows-11
   */
  timeZone?: string = "UTC";

  /**
   * [Required] The recurrence schedule.
   */
  schedule?: ComputeRecurrenceSchedule;
}

model ComputeRecurrenceSchedule {
  /**
   * [Required] List of hours for the schedule.
   */
  hours: int32[];

  /**
   * [Required] List of minutes for the schedule.
   */
  minutes: int32[];

  /**
   * List of month days for the schedule
   */
  monthDays?: int32[];

  /**
   * List of days for the schedule.
   */
  weekDays?: ComputeWeekDay[];
}

/**
 * The workflow trigger cron for ComputeStartStop schedule type.
 */
model Cron {
  /**
   * The start time in yyyy-MM-ddTHH:mm:ss format.
   */
  startTime?: string;

  /**
   * Specifies time zone in which the schedule runs.
   * TimeZone should follow Windows time zone format. Refer: https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/default-time-zones?view=windows-11
   */
  timeZone?: string = "UTC";

  /**
   * [Required] Specifies cron expression of schedule.
   * The expression should follow NCronTab format.
   */
  expression?: string;
}

model ScheduleBase {
  /**
   * A system assigned id for the schedule.
   */
  id?: string;

  /**
   * The current deployment state of schedule.
   */
  provisioningStatus?: ScheduleProvisioningState;

  /**
   * Is the schedule enabled or disabled?
   */
  status?: ScheduleStatus;
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
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  services?: Record<unknown>[];
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

model VirtualMachineSchema {
  properties?: VirtualMachineSchemaProperties;
}

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

model DataLakeAnalyticsSchema {
  properties?: DataLakeAnalyticsSchemaProperties;
}

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
  properties?: SynapseSparkProperties;

  /**
   * The type of compute
   */
  computeType: "SynapseSpark";
}

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
  minNodeCount?: int32;
  enabled?: boolean;
  maxNodeCount?: int32;
}

/**
 * Auto pause properties
 */
model AutoPauseProperties {
  delayInMinutes?: int32;
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
  @visibility("create", "update")
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

model AllFeatures extends MonitoringFeatureFilterBase {
  /**
   * [Required] Specifies the feature filter to leverage when selecting features to calculate metrics over.
   */
  filterType: "AllFeatures";
}

@discriminator("filterType")
model MonitoringFeatureFilterBase {}

/**
 * All nodes means the service will be running on all of the nodes of the job
 */
model AllNodes extends Nodes {
  /**
   * [Required] Type of the Nodes value
   */
  nodesValueType: "All";
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
 * AML token compute identity definition.
 */
model AmlTokenComputeIdentity extends MonitorComputeIdentityBase {
  /**
   * [Required] Specifies the type of identity to use within the monitoring jobs.
   */
  computeIdentityType: "AmlToken";
}

/**
 * Monitor compute identity base definition.
 */
@discriminator("computeIdentityType")
model MonitorComputeIdentityBase {}

/**
 * Access credential with no credentials
 */
model AnonymousAccessCredential extends DataReferenceCredential {
  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialType: "NoCredentials";
}

/**
 * Asset input type.
 */
model AssetJobInput {
  /**
   * Input Asset Delivery Mode.
   */
  @visibility("read", "create")
  mode?: InputDeliveryMode;

  /**
   * [Required] Input Asset URI.
   */
  @minLength(1)
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
  @visibility("read", "create")
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
model ForecastHorizon {}

/**
 * AutoMLJob class.
 * Use this class for executing AutoML tasks like Classification/Regression etc.
 * See TaskType enum for all the tasks supported.
 */
model AutoMLJob extends JobBaseProperties {
  /**
   * The ARM resource ID of the Environment specification for the job.
   * This is optional value to provide, if not provided, AutoML will default this to Production AutoML curated environment version when running the job.
   */
  @visibility("read", "create")
  environmentId?: string;

  /**
   * Environment variables included in the job.
   */
  @visibility("read", "create")
  environmentVariables?: Record<string>;

  /**
   * Mapping of output data bindings used in the job.
   */
  @visibility("read", "create")
  outputs?: Record<JobOutput>;

  /**
   * Queue settings for the job
   */
  @visibility("read", "create")
  queueSettings?: QueueSettings;

  /**
   * Compute Resource configuration for the job.
   */
  @visibility("read", "create")
  resources?: JobResourceConfiguration;

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
  @visibility("read", "create")
  description?: string;
}

model QueueSettings {
  /**
   * Controls the compute job tier
   */
  @visibility("read", "create")
  jobTier?: JobTier;
}

model JobResourceConfiguration extends ResourceConfiguration {
  /**
   * Extra arguments to pass to the Docker run command. This would override any parameters that have already been set by the system, or in this section. This parameter is only supported for Azure ML compute types.
   */
  @visibility("read", "create")
  dockerArgs?: string;

  /**
   * Size of the docker container's shared memory block. This should be in the format of (number)(unit) where number as to be greater than 0 and the unit can be one of b(bytes), k(kilobytes), m(megabytes), or g(gigabytes).
   */
  @visibility("read", "create")
  @pattern("\\d+[bBkKmMgG]")
  shmSize?: string = "2g";
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
   * Target column name: This is prediction values column.
   * Also known as label column name in context of classification tasks.
   */
  targetColumnName?: string;

  /**
   * [Required] Training data input.
   */
  trainingData: MLTableJobInput;
}

model MLTableJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "mltable";
}

/**
 * Command job definition.
 */
@discriminator("jobInputType")
model JobInput {
  /**
   * Description for the input.
   */
  @visibility("read", "create")
  description?: string;
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
model NCrossValidations {}

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
model Seasonality {}

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
model TargetLags {}

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
model TargetRollingWindowSize {}

/**
 * Azure Blob datastore configuration.
 */
model AzureBlobDatastore extends DatastoreProperties {
  ...AzureDatastore;

  /**
   * Storage account name.
   */
  @visibility("read", "create")
  accountName?: string;

  /**
   * Storage account container name.
   */
  @visibility("read", "create")
  containerName?: string;

  /**
   * Azure cloud endpoint for the storage account.
   */
  @visibility("read", "create")
  endpoint?: string;

  /**
   * Protocol used to communicate with the storage account.
   */
  @visibility("read", "create")
  protocol?: string;

  /**
   * Indicates which identity to use to authenticate service data access to customer's storage.
   */
  @visibility("read", "create")
  serviceDataAccessAuthIdentity?: ServiceDataAccessAuthIdentity;

  /**
   * [Required] Storage type backing the datastore.
   */
  datastoreType: "AzureBlob";
}

/**
 * Base definition for Azure datastore contents configuration.
 */
model AzureDatastore {
  /**
   * Azure Resource Group name
   */
  resourceGroup?: string;

  /**
   * Azure Subscription Id
   */
  subscriptionId?: string;
}

/**
 * Azure Data Lake Gen1 datastore configuration.
 */
model AzureDataLakeGen1Datastore extends DatastoreProperties {
  ...AzureDatastore;

  /**
   * Indicates which identity to use to authenticate service data access to customer's storage.
   */
  @visibility("read", "create")
  serviceDataAccessAuthIdentity?: ServiceDataAccessAuthIdentity;

  /**
   * [Required] Azure Data Lake store name.
   */
  @visibility("read", "create")
  @minLength(1)
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
model AzureDataLakeGen2Datastore extends DatastoreProperties {
  ...AzureDatastore;

  /**
   * [Required] Storage account name.
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  accountName: string;

  /**
   * Azure cloud endpoint for the storage account.
   */
  @visibility("read", "create")
  endpoint?: string;

  /**
   * [Required] The name of the Data Lake Gen2 filesystem.
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  filesystem: string;

  /**
   * Protocol used to communicate with the storage account.
   */
  @visibility("read", "create")
  protocol?: string;

  /**
   * Indicates which identity to use to authenticate service data access to customer's storage.
   */
  @visibility("read", "create")
  serviceDataAccessAuthIdentity?: ServiceDataAccessAuthIdentity;

  /**
   * [Required] Storage type backing the datastore.
   */
  datastoreType: "AzureDataLakeGen2";
}

/**
 * Webhook details specific for Azure DevOps
 */
model AzureDevOpsWebhook extends Webhook {
  /**
   * [Required] Specifies the type of service to send a callback
   */
  webhookType: "AzureDevOps";
}

/**
 * Azure File datastore configuration.
 */
model AzureFileDatastore extends DatastoreProperties {
  ...AzureDatastore;

  /**
   * [Required] Storage account name.
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  accountName: string;

  /**
   * Azure cloud endpoint for the storage account.
   */
  @visibility("read", "create")
  endpoint?: string;

  /**
   * [Required] The name of the Azure file share that the datastore points to.
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  fileShareName: string;

  /**
   * Protocol used to communicate with the storage account.
   */
  @visibility("read", "create")
  protocol?: string;

  /**
   * Indicates which identity to use to authenticate service data access to customer's storage.
   */
  @visibility("read", "create")
  serviceDataAccessAuthIdentity?: ServiceDataAccessAuthIdentity;

  /**
   * [Required] Storage type backing the datastore.
   */
  datastoreType: "AzureFile";
}

model AzureOpenAiFineTuning extends FineTuningVertical {
  /**
   * HyperParameters for fine tuning Azure Open AI model.
   */
  hyperParameters?: AzureOpenAiHyperParameters;

  /**
   * [Required] Enum to determine the type of fine tuning.
   */
  modelProvider: "AzureOpenAI";
}

/**
 * Azure Open AI hyperparameters for fine tuning.
 */
model AzureOpenAiHyperParameters {
  /**
   * Scaling factor for the learning rate. A smaller learning rate may be useful to avoid over fitting.
   */
  learningRateMultiplier?: float64;

  /**
   * Number of examples in each batch. A larger batch size means that model parameters are updated less frequently, but with lower variance.
   */
  batchSize?: int32;

  /**
   * The number of epochs to train the model for. An epoch refers to one full cycle through the training dataset.
   */
  nEpochs?: int32;
}

@discriminator("modelProvider")
model FineTuningVertical {
  /**
   * [Required] Fine tuning task type.
   */
  @visibility("read", "create")
  taskType: FineTuningTaskType;

  /**
   * [Required] Training data for fine tuning.
   */
  trainingData: JobInput;

  /**
   * Validation data for fine tuning.
   */
  validationData?: JobInput;

  /**
   * [Required] Input model for fine tuning.
   */
  `model`: MLFlowModelJobInput;
}

model MLFlowModelJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "mlflow_model";
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
}

/**
 * Properties for a Batch Pipeline Component Deployment.
 */
model BatchPipelineComponentDeploymentConfiguration
  extends BatchDeploymentConfiguration {
  /**
   * The ARM id of the component to be run.
   */
  componentId?: IdAssetReference;

  /**
   * The description which will be applied to the job.
   */
  description?: string;

  /**
   * Run-time settings for the pipeline job.
   */
  settings?: Record<string>;

  /**
   * The tags which will be applied to the job.
   */
  tags?: Record<string>;

  /**
   * [Required] The type of the deployment
   */
  deploymentConfigurationType: "PipelineComponent";
}

/**
 * Reference to an asset via its ARM resource ID.
 */
model IdAssetReference extends AssetReferenceBase {
  /**
   * [Required] ARM resource ID of the asset.
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  assetId: string;

  /**
   * [Required] Specifies the type of asset reference.
   */
  referenceType: "Id";
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
model SamplingAlgorithm {}

model CategoricalDataDriftMetricThreshold extends DataDriftMetricThresholdBase {
  /**
   * [Required] The categorical data drift metric to calculate.
   */
  @visibility("read", "create")
  metric: CategoricalDataDriftMetric;

  /**
   * [Required] Specifies the data type of the metric threshold.
   */
  dataType: "Categorical";
}

@discriminator("dataType")
model DataDriftMetricThresholdBase {
  /**
   * The threshold value. If null, a default value will be set depending on the selected metric.
   */
  @visibility("read", "create")
  threshold?: MonitoringThreshold;
}

model MonitoringThreshold {
  /**
   * The threshold value. If null, the set default is dependent on the metric type.
   */
  @visibility("read", "create")
  value?: float64;
}

model CategoricalDataQualityMetricThreshold
  extends DataQualityMetricThresholdBase {
  /**
   * [Required] The categorical data quality metric to calculate.
   */
  @visibility("read", "create")
  metric: CategoricalDataQualityMetric;

  /**
   * [Required] Specifies the data type of the metric threshold.
   */
  dataType: "Categorical";
}

@discriminator("dataType")
model DataQualityMetricThresholdBase {
  /**
   * The threshold value. If null, a default value will be set depending on the selected metric.
   */
  @visibility("read", "create")
  threshold?: MonitoringThreshold;
}

model CategoricalPredictionDriftMetricThreshold
  extends PredictionDriftMetricThresholdBase {
  /**
   * [Required] The categorical prediction drift metric to calculate.
   */
  @visibility("read", "create")
  metric: CategoricalPredictionDriftMetric;

  /**
   * [Required] Specifies the data type of the metric threshold.
   */
  dataType: "Categorical";
}

@discriminator("dataType")
model PredictionDriftMetricThresholdBase {
  /**
   * The threshold value. If null, a default value will be set depending on the selected metric.
   */
  @visibility("read", "create")
  threshold?: MonitoringThreshold;
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
  clientId: string;

  /**
   * Resource the service principal has access to.
   */
  resourceUrl?: string;

  /**
   * [Required] Service principal secrets.
   */
  @visibility("create", "update")
  secrets: CertificateDatastoreSecrets;

  /**
   * [Required] ID of the tenant to which the service principal belongs.
   */
  tenantId: string;

  /**
   * [Required] Thumbprint of the certificate used for authentication.
   */
  @minLength(1)
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
   * Positive label for binary metrics calculation.
   */
  positiveLabel?: string;

  /**
   * Primary metric for the task.
   */
  primaryMetric?: ClassificationPrimaryMetrics;

  /**
   * Inputs for training phase for an AutoML Job.
   */
  trainingSettings?: ClassificationTrainingSettings;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "Classification";
}

/**
 * Classification Training related configuration.
 */
model ClassificationTrainingSettings extends TrainingSettings {
  /**
   * Allowed models for classification task.
   */
  allowedTrainingAlgorithms?: ClassificationModels[];

  /**
   * Blocked models for classification task.
   */
  blockedTrainingAlgorithms?: ClassificationModels[];
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
  enableModelExplainability?: boolean = true;

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
  stackMetaLearnerKWargs?: Record<unknown>;

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
 * Abstract class for AutoML tasks that use table dataset as input - such as Classification/Regression/Forecasting.
 */
model TableVertical {
  /**
   * Columns to use for CVSplit data.
   */
  cvSplitColumnNames?: string[];

  /**
   * Featurization inputs needed for AutoML job.
   */
  featurizationSettings?: TableVerticalFeaturizationSettings;

  /**
   * Execution constraints for AutoMLJob.
   */
  limitSettings?: TableVerticalLimitSettings;

  /**
   * Number of cross validation folds to be applied on training dataset
   * when validation dataset is not provided.
   */
  nCrossValidations?: NCrossValidations;

  /**
   * Test data input.
   */
  testData?: MLTableJobInput;

  /**
   * The fraction of test dataset that needs to be set aside for validation purpose.
   * Values between (0.0 , 1.0)
   * Applied when validation dataset is not provided.
   */
  testDataSize?: float64;

  /**
   * Validation data inputs.
   */
  validationData?: MLTableJobInput;

  /**
   * The fraction of training dataset that needs to be set aside for validation purpose.
   * Values between (0.0 , 1.0)
   * Applied when validation dataset is not provided.
   */
  validationDataSize?: float64;

  /**
   * The name of the sample weight column. Automated ML supports a weighted column as an input, causing rows in the data to be weighted up or down.
   */
  weightColumnName?: string;
}

/**
 * Featurization Configuration.
 */
model TableVerticalFeaturizationSettings extends FeaturizationSettings {
  /**
   * These transformers shall not be used in featurization.
   */
  blockedTransformers?: BlockedTransformers[];

  /**
   * Dictionary of column name and its type (int, float, string, datetime etc).
   */
  columnNameAndTypes?: Record<string>;

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
  parameters?: Record<unknown>;
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
 * Command job definition.
 */
model CommandJob extends JobBaseProperties {
  /**
   * ARM resource ID of the code asset.
   */
  @visibility("read", "create")
  codeId?: string;

  /**
   * [Required] The command to execute on startup of the job. eg. "python train.py"
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  command: string;

  /**
   * Distribution configuration of the job. If set, this should be one of Mpi, Tensorflow, PyTorch, or null.
   */
  @visibility("read", "create")
  distribution?: DistributionConfiguration;

  /**
   * [Required] The ARM resource ID of the Environment specification for the job.
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  environmentId: string;

  /**
   * Environment variables included in the job.
   */
  @visibility("read", "create")
  environmentVariables?: Record<string>;

  /**
   * Mapping of input data bindings used in the job.
   */
  @visibility("read", "create")
  inputs?: Record<JobInput>;

  /**
   * Command Job limit.
   */
  @visibility("read", "create")
  limits?: CommandJobLimits;

  /**
   * Mapping of output data bindings used in the job.
   */
  @visibility("read", "create")
  outputs?: Record<JobOutput>;

  /**
   * Input parameters.
   */
  @visibility("read")
  parameters?: Record<unknown>;

  /**
   * Queue settings for the job
   */
  @visibility("read", "create")
  queueSettings?: QueueSettings;

  /**
   * Compute Resource configuration for the job.
   */
  @visibility("read", "create")
  resources?: JobResourceConfiguration;

  /**
   * [Required] Specifies the type of job.
   */
  jobType: "Command";
}

/**
 * Base definition for job distribution configuration.
 */
@discriminator("distributionType")
model DistributionConfiguration {}

/**
 * Command Job limit class.
 */
model CommandJobLimits extends JobLimits {
  /**
   * [Required] JobLimit type.
   */
  jobLimitsType: "Command";
}

@discriminator("jobLimitsType")
model JobLimits {
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

model CreateMonitorAction extends ScheduleActionBase {
  /**
   * [Required] Defines the monitor.
   */
  @visibility("read", "create")
  monitorDefinition: MonitorDefinition;

  /**
   * [Required] Specifies the action type of the schedule
   */
  actionType: "CreateMonitor";
}

model MonitorDefinition {
  /**
   * The monitor's notification settings.
   */
  @visibility("read", "create")
  alertNotificationSettings?: MonitorNotificationSettings;

  /**
   * [Required] The ARM resource ID of the compute resource to run the monitoring job on.
   */
  @visibility("read", "create")
  computeConfiguration: MonitorComputeConfigurationBase;

  /**
   * The entities targeted by the monitor.
   */
  @visibility("read", "create")
  monitoringTarget?: MonitoringTarget;

  /**
   * [Required] The signals to monitor.
   */
  @visibility("read", "create")
  signals: Record<MonitoringSignalBase>;
}

model MonitorNotificationSettings {
  /**
   * The AML notification email settings.
   */
  @visibility("read", "create")
  emailNotificationSettings?: MonitorEmailNotificationSettings;
}

model MonitorEmailNotificationSettings {
  /**
   * The email recipient list which has a limitation of 499 characters in total.
   */
  @visibility("read", "create")
  @OpenAPI.extension("x-ms-identifiers", [])
  emails?: string[];
}

/**
 * Monitor compute configuration base definition.
 */
@discriminator("computeType")
model MonitorComputeConfigurationBase {}

/**
 * Monitoring target definition.
 */
model MonitoringTarget {
  /**
   * Reference to the deployment asset targeted by this monitor.
   */
  @visibility("read", "create")
  deploymentId?: string;

  /**
   * Reference to the model asset targeted by this monitor.
   */
  @visibility("read", "create")
  modelId?: string;

  /**
   * [Required] The machine learning task type of the monitored model.
   */
  @visibility("read", "create")
  taskType: ModelTaskType;
}

@discriminator("signalType")
model MonitoringSignalBase {
  /**
   * The current notification mode for this signal.
   */
  @visibility("read", "create")
  @OpenAPI.extension("x-ms-identifiers", [])
  notificationTypes?: MonitoringNotificationType[];

  /**
   * Property dictionary. Properties can be added, but not removed or altered.
   */
  properties?: Record<string>;
}

model CronTrigger extends TriggerBase {
  /**
   * [Required] Specifies cron expression of schedule.
   * The expression should follow NCronTab format.
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  expression: string;

  /**
   * [Required]
   */
  triggerType: "Cron";
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

model CustomMetricThreshold {
  /**
   * [Required] The user-defined metric to calculate.
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  metric: string;

  /**
   * The threshold value. If null, a default value will be set depending on the selected metric.
   */
  @visibility("read", "create")
  threshold?: MonitoringThreshold;
}

model CustomModelFineTuning extends FineTuningVertical {
  /**
   * HyperParameters for fine tuning custom model.
   */
  hyperParameters?: Record<string>;

  /**
   * [Required] Enum to determine the type of fine tuning.
   */
  modelProvider: "Custom";
}

model CustomModelJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "custom_model";
}

model CustomModelJobOutput extends JobOutput {
  ...AssetJobOutput;

  /**
   * [Required] Specifies the type of job.
   */
  jobOutputType: "custom_model";
}

model CustomMonitoringSignal extends MonitoringSignalBase {
  /**
   * [Required] Reference to the component asset used to calculate the custom metrics.
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  componentId: string;

  /**
   * Monitoring assets to take as input. Key is the component input port name, value is the data asset.
   */
  @visibility("read", "create")
  inputAssets?: Record<MonitoringInputDataBase>;

  /**
   * Extra component parameters to take as input. Key is the component literal input port name, value is the parameter value.
   */
  @visibility("read", "create")
  inputs?: Record<JobInput>;

  /**
   * [Required] A list of metrics to calculate and their associated thresholds.
   */
  @visibility("read", "create")
  @OpenAPI.extension("x-ms-identifiers", [])
  metricThresholds: CustomMetricThreshold[];

  /**
   * [Required] Specifies the type of signal to monitor.
   */
  signalType: "Custom";
}

/**
 * Monitoring input data base definition.
 */
@discriminator("inputDataType")
model MonitoringInputDataBase {
  /**
   * Mapping of column names to special uses.
   */
  @visibility("read", "create")
  columns?: Record<string>;

  /**
   * The context metadata of the data source.
   */
  @visibility("read", "create")
  dataContext?: string;

  /**
   * [Required] Specifies the type of job.
   */
  @visibility("read", "create")
  jobInputType: JobInputType;

  /**
   * [Required] Input Asset URI.
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  uri: string;
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

model DataDriftMonitoringSignal extends MonitoringSignalBase {
  /**
   * A dictionary that maps feature names to their respective data types.
   */
  @visibility("read", "create")
  featureDataTypeOverride?: Record<MonitoringFeatureDataType>;

  /**
   * The settings for computing feature importance.
   */
  @visibility("read", "create")
  featureImportanceSettings?: FeatureImportanceSettings;

  /**
   * The feature filter which identifies which feature to calculate drift over.
   */
  @visibility("read", "create")
  features?: MonitoringFeatureFilterBase;

  /**
   * [Required] A list of metrics to calculate and their associated thresholds.
   */
  @visibility("read", "create")
  @OpenAPI.extension("x-ms-identifiers", [])
  metricThresholds: DataDriftMetricThresholdBase[];

  /**
   * [Required] The data which drift will be calculated for.
   */
  @visibility("read", "create")
  productionData: MonitoringInputDataBase;

  /**
   * [Required] The data to calculate drift against.
   */
  @visibility("read", "create")
  referenceData: MonitoringInputDataBase;

  /**
   * [Required] Specifies the type of signal to monitor.
   */
  signalType: "DataDrift";
}

model FeatureImportanceSettings {
  /**
   * The mode of operation for computing feature importance.
   */
  mode?: FeatureImportanceMode;

  /**
   * The name of the target column within the input data asset.
   */
  targetColumn?: string;
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

model DataQualityMonitoringSignal extends MonitoringSignalBase {
  /**
   * A dictionary that maps feature names to their respective data types.
   */
  @visibility("read", "create")
  featureDataTypeOverride?: Record<MonitoringFeatureDataType>;

  /**
   * The settings for computing feature importance.
   */
  @visibility("read", "create")
  featureImportanceSettings?: FeatureImportanceSettings;

  /**
   * The features to calculate drift over.
   */
  @visibility("read", "create")
  features?: MonitoringFeatureFilterBase;

  /**
   * [Required] A list of metrics to calculate and their associated thresholds.
   */
  @visibility("read", "create")
  @OpenAPI.extension("x-ms-identifiers", [])
  metricThresholds: DataQualityMetricThresholdBase[];

  /**
   * [Required] The data produced by the production service which drift will be calculated for.
   */
  @visibility("read", "create")
  productionData: MonitoringInputDataBase;

  /**
   * [Required] The data to calculate drift against.
   */
  @visibility("read", "create")
  referenceData: MonitoringInputDataBase;

  /**
   * [Required] Specifies the type of signal to monitor.
   */
  signalType: "DataQuality";
}

model DefaultScaleSettings extends OnlineScaleSettings {
  /**
   * [Required] Type of deployment scaling algorithm
   */
  scaleType: "Default";
}

/**
 * Credential for docker with username and password
 */
model DockerCredential extends DataReferenceCredential {
  /**
   * DockerCredential user password
   */
  password?: string;

  /**
   * DockerCredential user name
   */
  userName?: string;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialType: "DockerCredentials";
}

model EndpointScheduleAction extends ScheduleActionBase {
  /**
   * [Required] Defines Schedule action definition details.
   * <see href="TBD" />
   */
  @visibility("read", "create", "update")
  endpointInvocationDefinition: Record<unknown>;

  /**
   * [Required] Specifies the action type of the schedule
   */
  actionType: "InvokeBatchEndpoint";
}

model FeatureAttributionDriftMonitoringSignal extends MonitoringSignalBase {
  /**
   * A dictionary that maps feature names to their respective data types.
   */
  @visibility("read", "create")
  featureDataTypeOverride?: Record<MonitoringFeatureDataType>;

  /**
   * [Required] The settings for computing feature importance.
   */
  @visibility("read", "create")
  featureImportanceSettings: FeatureImportanceSettings;

  /**
   * [Required] A list of metrics to calculate and their associated thresholds.
   */
  @visibility("read", "create")
  metricThreshold: FeatureAttributionMetricThreshold;

  /**
   * [Required] The data which drift will be calculated for.
   */
  @visibility("read", "create")
  @OpenAPI.extension("x-ms-identifiers", [])
  productionData: MonitoringInputDataBase[];

  /**
   * [Required] The data to calculate drift against.
   */
  @visibility("read", "create")
  referenceData: MonitoringInputDataBase;

  /**
   * [Required] Specifies the type of signal to monitor.
   */
  signalType: "FeatureAttributionDrift";
}

model FeatureAttributionMetricThreshold {
  /**
   * [Required] The feature attribution metric to calculate.
   */
  @visibility("read", "create")
  metric: FeatureAttributionMetric;

  /**
   * The threshold value. If null, a default value will be set depending on the selected metric.
   */
  @visibility("read", "create")
  threshold?: MonitoringThreshold;
}

model FeatureSubset extends MonitoringFeatureFilterBase {
  /**
   * [Required] The list of features to include.
   */
  @visibility("read", "create")
  features: string[];

  /**
   * [Required] Specifies the feature filter to leverage when selecting features to calculate metrics over.
   */
  filterType: "FeatureSubset";
}

/**
 * FineTuning Job definition.
 */
model FineTuningJob extends JobBaseProperties {
  /**
   * [Required]
   */
  fineTuningDetails: FineTuningVertical;

  /**
   * Instance types and other resources for the job
   */
  @visibility("read", "create")
  resources?: JobResources;

  /**
   * Queue settings for the job
   */
  @visibility("read", "create")
  queueSettings?: QueueSettings;

  /**
   * [Required]
   */
  @visibility("read", "create")
  outputs: Record<JobOutput>;

  /**
   * [Required] Specifies the type of job.
   */
  jobType: "FineTuning";
}

model JobResources {
  /**
   * List of instance types to choose from.
   */
  @visibility("read", "create")
  instanceTypes?: string[];
}

/**
 * Fixed input data definition.
 */
model FixedInputData extends MonitoringInputDataBase {
  /**
   * [Required] Specifies the type of signal to monitor.
   */
  inputDataType: "Fixed";
}

/**
 * Forecasting task in AutoML Table vertical.
 */
model Forecasting extends AutoMLVertical {
  ...TableVertical;

  /**
   * Forecasting task specific inputs.
   */
  forecastingSettings?: ForecastingSettings;

  /**
   * Primary metric for forecasting task.
   */
  primaryMetric?: ForecastingPrimaryMetrics;

  /**
   * Inputs for training phase for an AutoML Job.
   */
  trainingSettings?: ForecastingTrainingSettings;

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
 * Forecasting Training related configuration.
 */
model ForecastingTrainingSettings extends TrainingSettings {
  /**
   * Allowed models for forecasting task.
   */
  allowedTrainingAlgorithms?: ForecastingModels[];

  /**
   * Blocked models for forecasting task.
   */
  blockedTrainingAlgorithms?: ForecastingModels[];
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

model ImageClassificationBase extends ImageVertical {
  /**
   * Settings used for training the model.
   */
  modelSettings?: ImageModelSettingsClassification;

  /**
   * Search space for sampling different combinations of models and their hyperparameters.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  searchSpace?: ImageModelDistributionSettingsClassification[];
}

/**
 * Settings used for training the model.
 * For more information on the available settings please visit the official documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
 */
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
   * Frequency to store model checkpoints. Must be a positive integer.
   */
  checkpointFrequency?: int32;

  /**
   * The pretrained checkpoint model for incremental training.
   */
  checkpointModel?: MLFlowModelJobInput;

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
 * ```
 * ModelName = "choice('seresnext', 'resnest50')";
 * LearningRate = "uniform(0.001, 0.01)";
 * LayersToFreeze = "choice(0, 2)";
 * ```</example>
 * For more details on how to compose distribution expressions please check the documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-tune-hyperparameters
 * For more information on the available settings please visit the official documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
 */
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
 * ```
 * ModelName = "choice('seresnext', 'resnest50')";
 * LearningRate = "uniform(0.001, 0.01)";
 * LayersToFreeze = "choice(0, 2)";
 * ```</example>
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
   * [Required] Limit settings for the AutoML job.
   */
  limitSettings: ImageLimitSettings;

  /**
   * Model sweeping and hyperparameter sweeping related settings.
   */
  sweepSettings?: ImageSweepSettings;

  /**
   * Validation data inputs.
   */
  validationData?: MLTableJobInput;

  /**
   * The fraction of training dataset that needs to be set aside for validation purpose.
   * Values between (0.0 , 1.0)
   * Applied when validation dataset is not provided.
   */
  validationDataSize?: float64;
}

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
   * [Required] Type of the hyperparameter sampling algorithms.
   */
  samplingAlgorithm: SamplingAlgorithmType;
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

model ImageObjectDetectionBase extends ImageVertical {
  /**
   * Settings used for training the model.
   */
  modelSettings?: ImageModelSettingsObjectDetection;

  /**
   * Search space for sampling different combinations of models and their hyperparameters.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  searchSpace?: ImageModelDistributionSettingsObjectDetection[];
}

/**
 * Settings used for training the model.
 * For more information on the available settings please visit the official documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
 */
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
 * ```
 * ModelName = "choice('seresnext', 'resnest50')";
 * LearningRate = "uniform(0.001, 0.01)";
 * LayersToFreeze = "choice(0, 2)";
 * ```</example>
 * For more details on how to compose distribution expressions please check the documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-tune-hyperparameters
 * For more information on the available settings please visit the official documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
 */
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

model JobScheduleAction extends ScheduleActionBase {
  /**
   * [Required] Defines Schedule action definition details.
   */
  @visibility("read", "create", "update")
  jobDefinition: JobBaseProperties;

  /**
   * [Required] Specifies the action type of the schedule
   */
  actionType: "CreateJob";
}

/**
 * Properties specific to a KubernetesOnlineDeployment.
 */
model KubernetesOnlineDeployment extends OnlineDeploymentProperties {
  /**
   * The resource requirements for the container (cpu and memory).
   */
  containerResourceRequirements?: ContainerResourceRequirements;

  /**
   * [Required] The compute type of the endpoint.
   */
  endpointComputeType: "Kubernetes";
}

model LakeHouseArtifact extends OneLakeArtifact {
  /**
   * [Required] OneLake artifact type
   */
  artifactType: "LakeHouse";
}

/**
 * OneLake artifact (data source) configuration.
 */
@discriminator("artifactType")
model OneLakeArtifact {
  /**
   * [Required] OneLake artifact name
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  artifactName: string;
}

/**
 * Literal input type.
 */
model LiteralJobInput extends JobInput {
  /**
   * [Required] Literal value for the input.
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  value: string;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "literal";
}

model MLFlowModelJobOutput extends JobOutput {
  ...AssetJobOutput;

  /**
   * [Required] Specifies the type of job.
   */
  jobOutputType: "mlflow_model";
}

model MLTableJobOutput extends JobOutput {
  ...AssetJobOutput;

  /**
   * [Required] Specifies the type of job.
   */
  jobOutputType: "mltable";
}

/**
 * Managed compute identity definition.
 */
model ManagedComputeIdentity extends MonitorComputeIdentityBase {
  /**
   * The identity which will be leveraged by the monitoring jobs.
   */
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;

  /**
   * [Required] Specifies the type of identity to use within the monitoring jobs.
   */
  computeIdentityType: "ManagedIdentity";
}

/**
 * Managed identity configuration.
 */
model ManagedIdentity extends IdentityConfiguration {
  /**
   * Specifies a user-assigned identity by client ID. For system-assigned, do not set this field.
   */
  @visibility("read", "create")
  clientId?: string;

  /**
   * Specifies a user-assigned identity by object ID. For system-assigned, do not set this field.
   */
  @visibility("read", "create")
  objectId?: string;

  /**
   * Specifies a user-assigned identity by ARM resource ID. For system-assigned, do not set this field.
   */
  @visibility("read", "create")
  resourceId?: string;

  /**
   * [Required] Specifies the type of identity framework.
   */
  identityType: "Managed";
}

/**
 * Credential for user managed identity
 */
model ManagedIdentityCredential extends DataReferenceCredential {
  /**
   * ManagedIdentityCredential identity type
   */
  managedIdentityType?: string;

  /**
   * ClientId for the UAMI. For ManagedIdentityType = SystemManaged, this field is null.
   */
  userManagedIdentityClientId?: string;

  /**
   * PrincipalId for the UAMI. For ManagedIdentityType = SystemManaged, this field is null.
   */
  userManagedIdentityPrincipalId?: string;

  /**
   * Full arm scope for the Id. For ManagedIdentityType = SystemManaged, this field is null.
   */
  userManagedIdentityResourceId?: string;

  /**
   * TenantId for the UAMI. For ManagedIdentityType = SystemManaged, this field is null.
   */
  userManagedIdentityTenantId?: string;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialType: "ManagedIdentity";
}

/**
 * Properties specific to a ManagedOnlineDeployment.
 */
model ManagedOnlineDeployment extends OnlineDeploymentProperties {
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

/**
 * Monitor serverless spark compute definition.
 */
model MonitorServerlessSparkCompute extends MonitorComputeConfigurationBase {
  /**
   * [Required] The identity scheme leveraged to by the spark jobs running on serverless Spark.
   */
  @visibility("read", "create")
  computeIdentity: MonitorComputeIdentityBase;

  /**
   * [Required] The instance type running the Spark job.
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  instanceType: string;

  /**
   * [Required] The Spark runtime version.
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("^[0-9]+\\.[0-9]+$")
  runtimeVersion: string;

  /**
   * [Required] Specifies the type of signal to monitor.
   */
  computeType: "ServerlessSpark";
}

/**
 * MPI distribution configuration.
 */
model Mpi extends DistributionConfiguration {
  /**
   * Number of processes per MPI node.
   */
  @visibility("read", "create")
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
   * Featurization inputs needed for AutoML job.
   */
  featurizationSettings?: NlpVerticalFeaturizationSettings;

  /**
   * Execution constraints for AutoMLJob.
   */
  limitSettings?: NlpVerticalLimitSettings;

  /**
   * Validation data inputs.
   */
  validationData?: MLTableJobInput;
}

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

model NumericalDataDriftMetricThreshold extends DataDriftMetricThresholdBase {
  /**
   * [Required] The numerical data drift metric to calculate.
   */
  metric: NumericalDataDriftMetric;

  /**
   * [Required] Specifies the data type of the metric threshold.
   */
  dataType: "Numerical";
}

model NumericalDataQualityMetricThreshold
  extends DataQualityMetricThresholdBase {
  /**
   * [Required] The numerical data quality metric to calculate.
   */
  @visibility("read", "create")
  metric: NumericalDataQualityMetric;

  /**
   * [Required] Specifies the data type of the metric threshold.
   */
  dataType: "Numerical";
}

model NumericalPredictionDriftMetricThreshold
  extends PredictionDriftMetricThresholdBase {
  /**
   * [Required] The numerical prediction drift metric to calculate.
   */
  @visibility("read", "create")
  metric: NumericalPredictionDriftMetric;

  /**
   * [Required] Specifies the data type of the metric threshold.
   */
  dataType: "Numerical";
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
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  primaryMetric: string;
}

/**
 * OneLake (Trident) datastore configuration.
 */
model OneLakeDatastore extends DatastoreProperties {
  /**
   * [Required] OneLake artifact backing the datastore.
   */
  @visibility("read", "create")
  artifact: OneLakeArtifact;

  /**
   * OneLake endpoint to use for the datastore.
   */
  @visibility("read", "create")
  endpoint?: string;

  /**
   * [Required] OneLake workspace name.
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  oneLakeWorkspaceName: string;

  /**
   * Indicates which identity to use to authenticate service data access to customer's storage.
   */
  @visibility("read", "create")
  serviceDataAccessAuthIdentity?: ServiceDataAccessAuthIdentity;

  /**
   * [Required] Storage type backing the datastore.
   */
  datastoreType: "OneLake";
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
 * Pipeline Job definition: defines generic to MFE attributes.
 */
model PipelineJob extends JobBaseProperties {
  /**
   * Inputs for the pipeline job.
   */
  @visibility("read", "create")
  inputs?: Record<JobInput>;

  /**
   * Jobs construct the Pipeline Job.
   */
  @visibility("read", "create")
  jobs?: Record<Record<unknown>>;

  /**
   * Outputs for the pipeline job
   */
  @visibility("read", "create")
  outputs?: Record<JobOutput>;

  /**
   * Pipeline settings, for things like ContinueRunOnStepFailure etc.
   */
  @visibility("read", "create")
  settings?: Record<unknown>;

  /**
   * ARM resource ID of source job.
   */
  @visibility("read", "create")
  sourceJobId?: string;

  /**
   * [Required] Specifies the type of job.
   */
  jobType: "Pipeline";
}

model PredictionDriftMonitoringSignal extends MonitoringSignalBase {
  /**
   * A dictionary that maps feature names to their respective data types.
   */
  @visibility("read", "create")
  featureDataTypeOverride?: Record<MonitoringFeatureDataType>;

  /**
   * [Required] A list of metrics to calculate and their associated thresholds.
   */
  @visibility("read", "create")
  @OpenAPI.extension("x-ms-identifiers", [])
  metricThresholds: PredictionDriftMetricThresholdBase[];

  /**
   * [Required] The data which drift will be calculated for.
   */
  @visibility("read", "create")
  productionData: MonitoringInputDataBase;

  /**
   * [Required] The data to calculate drift against.
   */
  @visibility("read", "create")
  referenceData: MonitoringInputDataBase;

  /**
   * [Required] Specifies the type of signal to monitor.
   */
  signalType: "PredictionDrift";
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
 * Regression task in AutoML Table vertical.
 */
model Regression extends AutoMLVertical {
  ...TableVertical;

  /**
   * Primary metric for regression task.
   */
  primaryMetric?: RegressionPrimaryMetrics;

  /**
   * Inputs for training phase for an AutoML Job.
   */
  trainingSettings?: RegressionTrainingSettings;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "Regression";
}

/**
 * Regression Training related configuration.
 */
model RegressionTrainingSettings extends TrainingSettings {
  /**
   * Allowed models for regression task.
   */
  allowedTrainingAlgorithms?: RegressionModels[];

  /**
   * Blocked models for regression task.
   */
  blockedTrainingAlgorithms?: RegressionModels[];
}

/**
 * Rolling input data definition.
 */
model RollingInputData extends MonitoringInputDataBase {
  /**
   * Reference to the component asset used to preprocess the data.
   */
  @visibility("read", "create")
  preprocessingComponentId?: string;

  /**
   * [Required] The time offset between the end of the data window and the monitor's current run time.
   */
  @visibility("read", "create")
  windowOffset: duration;

  /**
   * [Required] The size of the rolling data window.
   */
  @visibility("read", "create")
  windowSize: duration;

  /**
   * [Required] Specifies the type of signal to monitor.
   */
  inputDataType: "Rolling";
}

/**
 * Access with full SAS uri
 */
model SASCredential extends DataReferenceCredential {
  /**
   * Full SAS Uri, including the storage, container/blob path and SAS token
   */
  sasUri?: url;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialType: "SAS";
}

model SASCredentialDto extends PendingUploadCredentialDto {
  /**
   * Full SAS Uri, including the storage, container/blob path and SAS token
   */
  sasUri?: url;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialType: "SAS";
}

/**
 * SAS datastore credentials configuration.
 */
model SasDatastoreCredentials extends DatastoreCredentials {
  /**
   * [Required] Storage container secrets.
   */
  @visibility("create", "update")
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
  clientId: string;

  /**
   * Resource the service principal has access to.
   */
  resourceUrl?: string;

  /**
   * [Required] Service principal secrets.
   */
  @visibility("create", "update")
  secrets: ServicePrincipalDatastoreSecrets;

  /**
   * [Required] ID of the tenant to which the service principal belongs.
   */
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
 * Spark job definition.
 */
model SparkJob extends JobBaseProperties {
  /**
   * Archive files used in the job.
   */
  @visibility("read", "create")
  archives?: string[];

  /**
   * Arguments for the job.
   */
  @visibility("read", "create")
  args?: string;

  /**
   * [Required] arm-id of the code asset.
   */
  @visibility("read", "create")
  codeId: Azure.Core.armResourceIdentifier;

  /**
   * Spark configured properties.
   */
  @visibility("read", "create")
  conf?: Record<string>;

  /**
   * [Required] The entry to execute on startup of the job.
   */
  @visibility("read", "create")
  entry: SparkJobEntry;

  /**
   * The ARM resource ID of the Environment specification for the job.
   */
  @visibility("read", "create")
  environmentId?: Azure.Core.armResourceIdentifier;

  /**
   * Environment variables included in the job.
   */
  @visibility("read", "create")
  environmentVariables?: Record<string>;

  /**
   * Files used in the job.
   */
  @visibility("read", "create")
  files?: string[];

  /**
   * Mapping of input data bindings used in the job.
   */
  @visibility("read", "create")
  inputs?: Record<JobInput>;

  /**
   * Jar files used in the job.
   */
  @visibility("read", "create")
  jars?: string[];

  /**
   * Mapping of output data bindings used in the job.
   */
  @visibility("read", "create")
  outputs?: Record<JobOutput>;

  /**
   * Python files used in the job.
   */
  @visibility("read", "create")
  pyFiles?: string[];

  /**
   * Queue settings for the job
   */
  @visibility("read", "create")
  queueSettings?: QueueSettings;

  /**
   * Compute Resource configuration for the job.
   */
  @visibility("read", "create")
  resources?: SparkResourceConfiguration;

  /**
   * [Required] Specifies the type of job.
   */
  jobType: "Spark";
}

/**
 * Spark job entry point definition.
 */
@discriminator("sparkJobEntryType")
model SparkJobEntry {}

model SparkResourceConfiguration {
  /**
   * Optional type of VM used as supported by the compute target.
   */
  @visibility("read", "create")
  instanceType?: string;

  /**
   * Version of spark runtime used for the job.
   */
  @visibility("read", "create")
  runtimeVersion?: string = "3.1";
}

model SparkJobPythonEntry extends SparkJobEntry {
  /**
   * [Required] Relative python file path for job entry point.
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  file: string;

  /**
   * [Required] Type of the job's entry point.
   */
  sparkJobEntryType: "SparkJobPythonEntry";
}

model SparkJobScalaEntry extends SparkJobEntry {
  /**
   * [Required] Scala class name used as entry point.
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  className: string;

  /**
   * [Required] Type of the job's entry point.
   */
  sparkJobEntryType: "SparkJobScalaEntry";
}

/**
 * Static input data definition.
 */
model StaticInputData extends MonitoringInputDataBase {
  /**
   * Reference to the component asset used to preprocess the data.
   */
  @visibility("read", "create")
  preprocessingComponentId?: string;

  /**
   * [Required] The end date of the data window.
   */
  @visibility("read", "create")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  windowEnd: utcDateTime;

  /**
   * [Required] The start date of the data window.
   */
  @visibility("read", "create")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  windowStart: utcDateTime;

  /**
   * [Required] Specifies the type of signal to monitor.
   */
  inputDataType: "Static";
}

/**
 * Sweep job definition.
 */
model SweepJob extends JobBaseProperties {
  /**
   * Early termination policies enable canceling poor-performing runs before they complete
   */
  earlyTermination?: EarlyTerminationPolicy;

  /**
   * Mapping of input data bindings used in the job.
   */
  @visibility("read", "create")
  inputs?: Record<JobInput>;

  /**
   * Sweep Job limit.
   */
  @visibility("read", "create")
  limits?: SweepJobLimits;

  /**
   * [Required] Optimization objective.
   */
  objective: Objective;

  /**
   * Mapping of output data bindings used in the job.
   */
  @visibility("read", "create")
  outputs?: Record<JobOutput>;

  /**
   * Queue settings for the job
   */
  @visibility("read", "create")
  queueSettings?: QueueSettings;

  /**
   * [Required] The hyperparameter sampling algorithm
   */
  samplingAlgorithm: SamplingAlgorithm;

  /**
   * [Required] A dictionary containing each parameter and its distribution. The dictionary key is the name of the parameter
   */
  searchSpace: Record<unknown>;

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
  @visibility("read", "create")
  codeId?: string;

  /**
   * [Required] The command to execute on startup of the job. eg. "python train.py"
   */
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  command: string;

  /**
   * Distribution configuration of the job. If set, this should be one of Mpi, Tensorflow, PyTorch, or null.
   */
  @visibility("read", "create")
  distribution?: DistributionConfiguration;

  /**
   * [Required] The ARM resource ID of the Environment specification for the job.
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  environmentId: string;

  /**
   * Environment variables included in the job.
   */
  @visibility("read", "create")
  environmentVariables?: Record<string>;

  /**
   * Compute Resource configuration for the job.
   */
  @visibility("read", "create")
  resources?: JobResourceConfiguration;
}

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
  @visibility("read", "create")
  parameterServerCount?: int32;

  /**
   * Number of workers. If not specified, will default to the instance count.
   */
  @visibility("read", "create")
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
  @visibility("read")
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
  @visibility("read")
  primaryMetric?: ClassificationPrimaryMetrics;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "TextNER";
}

model TopNFeaturesByAttribution extends MonitoringFeatureFilterBase {
  /**
   * The number of top features to include.
   */
  @visibility("read", "create")
  top?: int32 = 10;

  /**
   * [Required] Specifies the feature filter to leverage when selecting features to calculate metrics over.
   */
  filterType: "TopNByAttribution";
}

model TritonModelJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "triton_model";
}

model TritonModelJobOutput extends JobOutput {
  ...AssetJobOutput;

  /**
   * [Required] Specifies the type of job.
   */
  jobOutputType: "triton_model";
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

model UriFileJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "uri_file";
}

model UriFileJobOutput extends JobOutput {
  ...AssetJobOutput;

  /**
   * [Required] Specifies the type of job.
   */
  jobOutputType: "uri_file";
}

model UriFolderJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "uri_folder";
}

model UriFolderJobOutput extends JobOutput {
  ...AssetJobOutput;

  /**
   * [Required] Specifies the type of job.
   */
  jobOutputType: "uri_folder";
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

/**
 * This connection type covers the AAD auth for any applicable Azure service
 */
model AADAuthTypeWorkspaceConnectionProperties
  extends WorkspaceConnectionPropertiesV2 {
  /**
   * Authentication type of the connection target
   */
  authType: "AAD";
}
