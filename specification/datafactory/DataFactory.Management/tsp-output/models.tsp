import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DataFactory;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The identity type.
 */
enum FactoryIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

/**
 * Global Parameter type.
 */
enum GlobalParameterType {
  Object,
  String,
  Int,
  Float,
  Bool,
  Array,
}

/**
 * Whether or not public network access is allowed for the data factory.
 */
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

/**
 * The type of integration runtime.
 */
enum IntegrationRuntimeType {
  Managed,
  SelfHosted,
}

/**
 * The state of integration runtime auto update.
 */
enum IntegrationRuntimeAutoUpdate {
  On,
  Off,
}

/**
 * The state of integration runtime.
 */
enum IntegrationRuntimeState {
  Initial,
  Stopped,
  Started,
  Starting,
  Stopping,
  NeedRegistration,
  Online,
  Limited,
  Offline,
  AccessDenied,
}

/**
 * The name of the authentication key to regenerate.
 */
enum IntegrationRuntimeAuthKeyName {
  authKey1,
  authKey2,
}

/**
 * The type of SSIS object metadata.
 */
enum SsisObjectMetadataType {
  Folder,
  Project,
  Package,
  Environment,
}

/**
 * Status of the integration runtime node.
 */
enum SelfHostedIntegrationRuntimeNodeStatus {
  NeedRegistration,
  Online,
  Limited,
  Offline,
  Upgrading,
  Initializing,
  InitializeFailed,
}

/**
 * The result of the last integration runtime node update.
 */
enum IntegrationRuntimeUpdateResult {
  None,
  Succeed,
  Fail,
}

/**
 * Type of integration runtime.
 */
enum IntegrationRuntimeReferenceType {
  IntegrationRuntimeReference,
}

/**
 * Parameter type.
 */
enum ParameterType {
  Object,
  String,
  Int,
  Float,
  Bool,
  Array,
  SecureString,
}

/**
 * Linked service reference type.
 */
enum LinkedServiceReferenceType {
  LinkedServiceReference,
}

/**
 * Activity state. This is an optional property and if not provided, the state will be Active by default.
 */
enum ActivityState {
  Active,
  Inactive,
}

/**
 * Status result of the activity when the state is set to Inactive. This is an optional property and if not provided when the activity is inactive, the status will be Succeeded by default.
 */
enum ActivityOnInactiveMarkAs {
  Succeeded,
  Failed,
  Skipped,
}

enum DependencyCondition {
  Succeeded,
  Failed,
  Skipped,
  Completed,
}

/**
 * Variable type.
 */
enum VariableType {
  String,
  Bool,
  Array,
}

/**
 * Parameter name to be used for filter. The allowed operands to query pipeline runs are PipelineName, RunStart, RunEnd and Status; to query activity runs are ActivityName, ActivityRunStart, ActivityRunEnd, ActivityType and Status, and to query trigger runs are TriggerName, TriggerRunTimestamp and Status.
 */
enum RunQueryFilterOperand {
  PipelineName,
  Status,
  RunStart,
  RunEnd,
  ActivityName,
  ActivityRunStart,
  ActivityRunEnd,
  ActivityType,
  TriggerName,
  TriggerRunTimestamp,
  RunGroupId,
  LatestOnly,
}

/**
 * Operator to be used for filter.
 */
enum RunQueryFilterOperator {
  Equals,
  NotEquals,
  In,
  NotIn,
}

/**
 * Parameter name to be used for order by. The allowed parameters to order by for pipeline runs are PipelineName, RunStart, RunEnd and Status; for activity runs are ActivityName, ActivityRunStart, ActivityRunEnd and Status; for trigger runs are TriggerName, TriggerRunTimestamp and Status.
 */
enum RunQueryOrderByField {
  RunStart,
  RunEnd,
  PipelineName,
  Status,
  ActivityName,
  ActivityRunStart,
  ActivityRunEnd,
  TriggerName,
  TriggerRunTimestamp,
}

/**
 * Sorting order of the parameter.
 */
enum RunQueryOrder {
  ASC,
  DESC,
}

/**
 * Enumerates possible state of Triggers.
 */
enum TriggerRuntimeState {
  Started,
  Stopped,
  Disabled,
}

/**
 * Event Subscription Status.
 */
enum EventSubscriptionStatus {
  Enabled,
  Provisioning,
  Deprovisioning,
  Disabled,
  Unknown,
}

/**
 * Trigger run status.
 */
enum TriggerRunStatus {
  Succeeded,
  Failed,
  Inprogress,
}

/**
 * The command type.
 */
enum DataFlowDebugCommandType {
  executePreviewQuery,
  executeStatisticsQuery,
  executeExpressionQuery,
}

/**
 * Type of connection via linked service or dataset.
 */
enum ConnectionType {
  linkedservicetype,
}

/**
 * Type of the CDC attribute mapping. Note: 'Advanced' mapping type is also saved as 'Derived'.
 */
enum MappingType {
  Direct,
  Derived,
  Aggregate,
}

/**
 * Frequency of period in terms of 'Hour', 'Minute' or 'Second'.
 */
enum FrequencyType {
  Hour,
  Minute,
  Second,
}

/**
 * Expression type.
 */
enum ExpressionType {
  Expression,
}

/**
 * Pipeline reference type.
 */
enum PipelineReferenceType {
  PipelineReference,
}

/**
 * Dataset reference type.
 */
enum DatasetReferenceType {
  DatasetReference,
}

/**
 * Data flow reference type.
 */
enum DataFlowReferenceType {
  DataFlowReference,
}

/**
 * Managed Virtual Network reference type.
 */
enum ManagedVirtualNetworkReferenceType {
  ManagedVirtualNetworkReference,
}

/**
 * Credential reference type.
 */
enum CredentialReferenceType {
  CredentialReference,
}

/**
 * Compute type of the cluster which will execute data flow job.
 */
enum DataFlowComputeType {
  General,
  MemoryOptimized,
  ComputeOptimized,
}

/**
 * The pricing tier for the catalog database. The valid values could be found in https://azure.microsoft.com/en-us/pricing/details/sql-database/
 */
enum IntegrationRuntimeSsisCatalogPricingTier {
  Basic,
  Standard,
  Premium,
  PremiumRS,
}

/**
 * License type for bringing your own license scenario.
 */
enum IntegrationRuntimeLicenseType {
  BasePrice,
  LicenseIncluded,
}

/**
 * The type of this referenced entity.
 */
enum IntegrationRuntimeEntityReferenceType {
  IntegrationRuntimeReference,
  LinkedServiceReference,
}

/**
 * The edition for the SSIS Integration Runtime
 */
enum IntegrationRuntimeEdition {
  Standard,
  Enterprise,
}

/**
 * The managed integration runtime node status.
 */
enum ManagedIntegrationRuntimeNodeStatus {
  Starting,
  Available,
  Recycling,
  Unavailable,
}

/**
 * It is used to set the encryption mode for node-node communication channel (when more than 2 self-hosted integration runtime nodes exist).
 */
enum IntegrationRuntimeInternalChannelEncryptionMode {
  NotSet,
  SslEncrypted,
  NotEncrypted,
}

/**
 * The type used for authentication. Type: string.
 */
enum AzureStorageAuthenticationType {
  Anonymous,
  AccountKey,
  SasUri,
  ServicePrincipal,
  Msi,
}

/**
 * Sql always encrypted AKV authentication type. Type: string.
 */
enum SqlAlwaysEncryptedAkvAuthType {
  ServicePrincipal,
  ManagedIdentity,
  UserAssignedManagedIdentity,
}

/**
 * The connection mode used to access CosmosDB account. Type: string.
 */
enum CosmosDbConnectionMode {
  Gateway,
  Direct,
}

/**
 * AuthenticationType to be used for connection.
 */
enum SybaseAuthenticationType {
  Basic,
  Windows,
}

/**
 * AuthenticationType to be used for connection. It is mutually exclusive with connectionString property.
 */
enum Db2AuthenticationType {
  Basic,
}

/**
 * AuthenticationType to be used for connection.
 */
enum TeradataAuthenticationType {
  Basic,
  Windows,
}

/**
 * Type of authentication used to connect to the OData service.
 */
enum ODataAuthenticationType {
  Basic,
  Anonymous,
  Windows,
  AadServicePrincipal,
  ManagedServiceIdentity,
}

/**
 * Specify the credential type (key or cert) is used for service principal.
 */
enum ODataAadServicePrincipalCredentialType {
  ServicePrincipalKey,
  ServicePrincipalCert,
}

/**
 * Type of authentication used to connect to the web table source.
 */
enum WebAuthenticationType {
  Basic,
  Anonymous,
  ClientCertificate,
}

/**
 * The authentication type to be used to connect to the MongoDB database.
 */
enum MongoDbAuthenticationType {
  Basic,
  Anonymous,
}

/**
 * Type of authentication used to connect to the REST service.
 */
enum RestServiceAuthenticationType {
  Anonymous,
  Basic,
  AadServicePrincipal,
  ManagedServiceIdentity,
  OAuth2ClientCredential,
}

/**
 * The authentication type to use.
 */
enum TeamDeskAuthenticationType {
  Basic,
  Token,
}

/**
 * The authentication type to use.
 */
enum ZendeskAuthenticationType {
  Basic,
  Token,
}

/**
 * The authentication type to be used to connect to the HTTP server.
 */
enum HttpAuthenticationType {
  Basic,
  Anonymous,
  Digest,
  Windows,
  ClientCertificate,
}

/**
 * The authentication type to be used to connect to the FTP server.
 */
enum FtpAuthenticationType {
  Basic,
  Anonymous,
}

/**
 * The authentication type to be used to connect to the FTP server.
 */
enum SftpAuthenticationType {
  Basic,
  SshPublicKey,
  MultiFactor,
}

/**
 * The authentication type to be used to connect to the SAP HANA server.
 */
enum SapHanaAuthenticationType {
  Basic,
  Windows,
}

/**
 * The OAuth 2.0 authentication mechanism used for authentication. ServiceAuthentication can only be used on self-hosted IR.
 */
enum GoogleBigQueryAuthenticationType {
  ServiceAuthentication,
  UserAuthentication,
}

/**
 * The authentication mechanism to use to connect to the HBase server.
 */
enum HBaseAuthenticationType {
  Anonymous,
  Basic,
}

/**
 * The type of Hive server.
 */
enum HiveServerType {
  HiveServer1,
  HiveServer2,
  HiveThriftServer,
}

/**
 * The transport protocol to use in the Thrift layer.
 */
enum HiveThriftTransportProtocol {
  Binary,
  SASL,
  `HTTP `,
}

/**
 * The authentication method used to access the Hive server.
 */
enum HiveAuthenticationType {
  Anonymous,
  Username,
  UsernameAndPassword,
  WindowsAzureHDInsightService,
}

/**
 * The authentication type to use.
 */
enum ImpalaAuthenticationType {
  Anonymous,
  SASLUsername,
  UsernameAndPassword,
}

/**
 * The authentication mechanism used to connect to the Phoenix server.
 */
enum PhoenixAuthenticationType {
  Anonymous,
  UsernameAndPassword,
  WindowsAzureHDInsightService,
}

/**
 * The authentication mechanism used to connect to the Presto server.
 */
enum PrestoAuthenticationType {
  Anonymous,
  LDAP,
}

/**
 * The authentication type to use.
 */
enum ServiceNowAuthenticationType {
  Basic,
  OAuth2,
}

/**
 * The type of Spark server.
 */
enum SparkServerType {
  SharkServer,
  SharkServer2,
  SparkThriftServer,
}

/**
 * The transport protocol to use in the Thrift layer.
 */
enum SparkThriftTransportProtocol {
  Binary,
  SASL,
  `HTTP `,
}

/**
 * The authentication method used to access the Spark server.
 */
enum SparkAuthenticationType {
  Anonymous,
  Username,
  UsernameAndPassword,
  WindowsAzureHDInsightService,
}

/**
 * The OAuth 2.0 authentication mechanism used for authentication. ServiceAuthentication can only be used on self-hosted IR.
 */
enum GoogleAdWordsAuthenticationType {
  ServiceAuthentication,
  UserAuthentication,
}

/**
 * The consistency level specifies how many Cassandra servers must respond to a read request before returning data to the client application. Cassandra checks the specified number of Cassandra servers for data to satisfy the read request. Must be one of cassandraSourceReadConsistencyLevels. The default value is 'ONE'. It is case-insensitive.
 */
enum CassandraSourceReadConsistencyLevels {
  ALL,
  EACH_QUORUM,
  QUORUM,
  LOCAL_QUORUM,
  ONE,
  TWO,
  THREE,
  LOCAL_ONE,
  SERIAL,
  LOCAL_SERIAL,
}

/**
 * Stored procedure parameter type.
 */
enum StoredProcedureParameterType {
  String,
  Int,
  Int64,
  Decimal,
  Guid,
  Boolean,
  Date,
}

/**
 * The write behavior for the operation. Default is 'Insert'.
 */
enum SapCloudForCustomerSinkWriteBehavior {
  Insert,
  Update,
}

/**
 * Indicates whether the RejectValue property is specified as a literal value or a percentage.
 */
enum PolybaseSettingsRejectType {
  value,
  percentage,
}

/**
 * Specify the write behavior when upserting documents into Azure Search Index.
 */
enum AzureSearchIndexWriteBehaviorType {
  Merge,
  Upload,
}

/**
 * Defines values for DynamicsSinkWriteBehavior.
 */
enum DynamicsSinkWriteBehavior {
  Upsert,
}

/**
 * The write behavior for the operation. Default is Insert.
 */
enum SalesforceSinkWriteBehavior {
  Insert,
  Upsert,
}

/**
 * The HDInsightActivityDebugInfoOption settings to use.
 */
enum HDInsightActivityDebugInfoOption {
  None,
  Always,
  Failure,
}

/**
 * The type of SSIS package location.
 */
enum SsisPackageLocationType {
  SSISDB,
  File,
  InlinePackage,
  PackageStore,
}

/**
 * The type of SSIS log location.
 */
enum SsisLogLocationType {
  File,
}

/**
 * The list of HTTP methods supported by a WebActivity.
 */
enum WebActivityMethod {
  GET,
  POST,
  PUT,
  DELETE,
}

/**
 * The list of HTTP methods supported by a AzureFunctionActivity.
 */
enum AzureFunctionActivityMethod {
  GET,
  POST,
  PUT,
  DELETE,
  OPTIONS,
  HEAD,
  TRACE,
}

/**
 * The list of HTTP methods supported by a WebHook activity.
 */
enum WebHookActivityMethod {
  POST,
}

/**
 * The type of the query. Type: string.
 */
enum ScriptType {
  Query,
  NonQuery,
}

/**
 * The type of the parameter.
 */
enum ScriptActivityParameterType {
  Boolean,
  DateTime,
  DateTimeOffset,
  Decimal,
  Double,
  Guid,
  Int16,
  Int32,
  Int64,
  Single,
  String,
  Timespan,
}

/**
 * The direction of the parameter.
 */
enum ScriptActivityParameterDirection {
  Input,
  Output,
  InputOutput,
}

/**
 * The destination of logs. Type: string.
 */
enum ScriptActivityLogDestination {
  ActivityOutput,
  ExternalStore,
}

/**
 * Synapse notebook reference type.
 */
enum NotebookReferenceType {
  NotebookReference,
}

/**
 * Big data pool reference type.
 */
enum BigDataPoolReferenceType {
  BigDataPoolReference,
}

/**
 * Notebook parameter type.
 */
enum NotebookParameterType {
  string,
  int,
  float,
  bool,
}

/**
 * The type of the spark config.
 */
enum ConfigurationType {
  Default,
  Customized,
  Artifact,
}

/**
 * Spark configuration reference type.
 */
enum SparkConfigurationReferenceType {
  SparkConfigurationReference,
}

/**
 * Synapse spark job reference type.
 */
enum SparkJobReferenceType {
  SparkJobDefinitionReference,
}

/**
 * Enumerates possible frequency option for the schedule trigger.
 */
enum RecurrenceFrequency {
  NotSpecified,
  Minute,
  Hour,
  Day,
  Week,
  Month,
  Year,
}

enum BlobEventTypes {
  `Microsoft.Storage.BlobCreated`,
  `Microsoft.Storage.BlobDeleted`,
}

/**
 * Enumerates possible frequency option for the tumbling window trigger.
 */
enum TumblingWindowFrequency {
  Minute,
  Hour,
  Month,
}

/**
 * Trigger reference type.
 */
enum TriggerReferenceType {
  TriggerReference,
}

/**
 * JSON format file pattern. A property of JsonFormat.
 */
enum JsonFormatFilePattern {
  setOfObjects,
  arrayOfObjects,
}

/**
 * All available compression levels.
 */
enum DatasetCompressionLevel {
  Optimal,
  Fastest,
}

enum AvroCompressionCodec {
  none,
  deflate,
  snappy,
  xz,
  bzip2,
}

/**
 * All available compressionCodec values.
 */
enum CompressionCodec {
  none,
  lzo,
  bzip2,
  gzip,
  deflate,
  zipDeflate,
  snappy,
  lz4,
  tar,
  tarGZip,
}

enum OrcCompressionCodec {
  none,
  zlib,
  snappy,
  lzo,
}

/**
 * All available dynamicsDeploymentType values.
 */
enum DynamicsDeploymentType {
  Online,
  OnPremisesWithIfd,
}

/**
 * All available dynamicsAuthenticationType values.
 */
enum DynamicsAuthenticationType {
  Office365,
  Ifd,
  AADServicePrincipal,
}

/**
 * All available servicePrincipalCredentialType values.
 */
enum ServicePrincipalCredentialType {
  ServicePrincipalKey,
  ServicePrincipalCert,
}

/**
 * All available HdiNodeTypes values.
 */
enum HdiNodeTypes {
  Headnode,
  Workernode,
  Zookeeper,
}

/**
 * All available filePatterns.
 */
enum JsonWriteFilePattern {
  setOfObjects,
  arrayOfObjects,
}

/**
 * The Salesforce read behavior for the operation
 */
enum SalesforceSourceReadBehavior {
  Query,
  QueryAll,
}

enum AmazonRdsForOraclePartitionOption {
  None,
  PhysicalPartitionsOfTable,
  DynamicRange,
}

/**
 * All available types of copy behavior.
 */
enum CopyBehaviorType {
  PreserveHierarchy,
  FlattenHierarchy,
  MergeFiles,
}

/**
 * Specify the write behavior when copying data into sql.
 */
enum SqlWriteBehaviorEnum {
  Insert,
  Upsert,
  StoredProcedure,
}

/**
 * Specify the write behavior when copying data into sql dw.
 */
enum SqlDWWriteBehaviorEnum {
  Insert,
  Upsert,
}

/**
 * The partition mechanism that will be used for Sql read in parallel.
 */
enum SqlPartitionOption {
  None,
  PhysicalPartitionsOfTable,
  DynamicRange,
}

/**
 * The partition mechanism that will be used for SAP HANA read in parallel.
 */
enum SapHanaPartitionOption {
  None,
  PhysicalPartitionsOfTable,
  SapHanaDynamicRange,
}

/**
 * The partition mechanism that will be used for SAP table read in parallel.
 */
enum SapTablePartitionOption {
  None,
  PartitionOnInt,
  PartitionOnCalendarYear,
  PartitionOnCalendarMonth,
  PartitionOnCalendarDate,
  PartitionOnTime,
}

/**
 * The partition mechanism that will be used for Oracle read in parallel.
 */
enum OraclePartitionOption {
  None,
  PhysicalPartitionsOfTable,
  DynamicRange,
}

/**
 * The partition mechanism that will be used for teradata read in parallel.
 */
enum TeradataPartitionOption {
  None,
  Hash,
  DynamicRange,
}

/**
 * The partition mechanism that will be used for Netezza read in parallel.
 */
enum NetezzaPartitionOption {
  None,
  DataSlice,
  DynamicRange,
}

@fixed
enum DaysOfWeek {
  Sunday,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
}

/**
 * The days of the week.
 */
@fixed
enum DayOfWeek {
  Sunday,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
}

/**
 * Additional details about an operation.
 */
model OperationProperties {
  /**
   * Details about a service operation.
   */
  serviceSpecification?: OperationServiceSpecification;
}

/**
 * Details about a service operation.
 */
model OperationServiceSpecification {
  /**
   * Details about operations related to logs.
   */
  logSpecifications?: OperationLogSpecification[];

  /**
   * Details about operations related to metrics.
   */
  metricSpecifications?: OperationMetricSpecification[];
}

/**
 * Details about an operation related to logs.
 */
model OperationLogSpecification {
  /**
   * The name of the log category.
   */
  name?: string;

  /**
   * Localized display name.
   */
  displayName?: string;

  /**
   * Blobs created in the customer storage account, per hour.
   */
  blobDuration?: string;
}

/**
 * Details about an operation related to metrics.
 */
model OperationMetricSpecification {
  /**
   * The name of the metric.
   */
  name?: string;

  /**
   * Localized display name of the metric.
   */
  displayName?: string;

  /**
   * The description of the metric.
   */
  displayDescription?: string;

  /**
   * The unit that the metric is measured in.
   */
  unit?: string;

  /**
   * The type of metric aggregation.
   */
  aggregationType?: string;

  /**
   * Whether or not the service is using regional MDM accounts.
   */
  enableRegionalMdmAccount?: string;

  /**
   * The name of the MDM account.
   */
  sourceMdmAccount?: string;

  /**
   * The name of the MDM namespace.
   */
  sourceMdmNamespace?: string;

  /**
   * Defines how often data for metrics becomes available.
   */
  availabilities?: OperationMetricAvailability[];

  /**
   * Defines the metric dimension.
   */
  dimensions?: OperationMetricDimension[];
}

/**
 * Defines how often data for a metric becomes available.
 */
model OperationMetricAvailability {
  /**
   * The granularity for the metric.
   */
  timeGrain?: string;

  /**
   * Blob created in the customer storage account, per hour.
   */
  blobDuration?: string;
}

/**
 * Defines the metric dimension.
 */
model OperationMetricDimension {
  /**
   * The name of the dimension for the metric.
   */
  name?: string;

  /**
   * The display name of the metric dimension.
   */
  displayName?: string;

  /**
   * Whether the dimension should be exported to Azure Monitor.
   */
  toBeExportedForShoebox?: boolean;
}

/**
 * The object that defines the structure of an Azure Data Factory error response.
 */
@error
model CloudError {
  /**
   * Error data
   */
  error: CloudErrorBody;
}

/**
 * The object that defines the structure of an Azure Data Factory error.
 */
model CloudErrorBody {
  /**
   * Error code.
   */
  code: string;

  /**
   * Error message.
   */
  message: string;

  /**
   * Property name/path in request associated with error.
   */
  target?: string;

  /**
   * Array with additional error details.
   */
  details?: CloudError[];
}

/**
 * Identity properties of the factory resource.
 */
model FactoryIdentity {
  /**
   * The identity type.
   */
  type: FactoryIdentityType;

  /**
   * The principal id of the identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The client tenant id of the identity.
   */
  @visibility("read")
  tenantId?: string;
}

/**
 * Factory resource properties.
 */
model FactoryProperties {
  /**
   * Factory provisioning state, example Succeeded.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Time the factory was created in ISO8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  /**
   * Version of the factory.
   */
  @visibility("read")
  version?: string;

  /**
   * Purview information of the factory.
   */
  purviewConfiguration?: PurviewConfiguration;

  /**
   * Git repo information of the factory.
   */
  repoConfiguration?: FactoryRepoConfiguration;

  /**
   * List of parameters for factory.
   */
  globalParameters?: Record<GlobalParameterSpecification>;

  /**
   * Properties to enable Customer Managed Key for the factory.
   */
  encryption?: EncryptionConfiguration;

  /**
   * Whether or not public network access is allowed for the data factory.
   */
  publicNetworkAccess?: PublicNetworkAccess;
}

/**
 * Purview configuration.
 */
model PurviewConfiguration {
  /**
   * Purview resource id.
   */
  purviewResourceId?: string;
}

/**
 * Factory's git repo information.
 */
@discriminator("type")
model FactoryRepoConfiguration {
  /**
   * Account name.
   */
  accountName: string;

  /**
   * Repository name.
   */
  repositoryName: string;

  /**
   * Collaboration branch.
   */
  collaborationBranch: string;

  /**
   * Root folder.
   */
  rootFolder: string;

  /**
   * Last commit id.
   */
  lastCommitId?: string;

  /**
   * Disable manual publish operation in ADF studio to favor automated publish.
   */
  disablePublish?: boolean;
}

/**
 * Definition of a single parameter for an entity.
 */
model GlobalParameterSpecification {
  /**
   * Global Parameter type.
   */
  type: GlobalParameterType;

  /**
   * Value of parameter.
   */
  value: Record<unknown>;
}

/**
 * Definition of CMK for the factory.
 */
model EncryptionConfiguration {
  /**
   * The name of the key in Azure Key Vault to use as Customer Managed Key.
   */
  keyName: string;

  /**
   * The url of the Azure Key Vault used for CMK.
   */
  vaultBaseUrl: string;

  /**
   * The version of the key used for CMK. If not provided, latest version will be used.
   */
  keyVersion?: string;

  /**
   * User assigned identity to use to authenticate to customer's key vault. If not provided Managed Service Identity will be used.
   */
  identity?: CMKIdentityDefinition;
}

/**
 * Managed Identity used for CMK.
 */
model CMKIdentityDefinition {
  /**
   * The resource id of the user assigned identity to authenticate to customer's key vault.
   */
  userAssignedIdentity?: string;
}

/**
 * Azure Data Factory top-level resource.
 */
model Resource {
  /**
   * The resource identifier.
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
  @visibility("read", "create")
  location?: string;

  /**
   * The resource tags.
   */
  tags?: Record<string>;

  /**
   * Etag identifies change in the resource.
   */
  @visibility("read")
  eTag?: string;
}

/**
 * Factory's git repo information.
 */
model FactoryRepoUpdate {
  /**
   * The factory resource id.
   */
  factoryResourceId?: string;

  /**
   * Git repo information of the factory.
   */
  repoConfiguration?: FactoryRepoConfiguration;
}

/**
 * The exposure control request.
 */
model ExposureControlRequest {
  /**
   * The feature name.
   */
  featureName?: string;

  /**
   * The feature type.
   */
  featureType?: string;
}

/**
 * The exposure control response.
 */
model ExposureControlResponse {
  /**
   * The feature name.
   */
  @visibility("read")
  featureName?: string;

  /**
   * The feature value.
   */
  @visibility("read")
  value?: string;
}

/**
 * A list of exposure control features.
 */
model ExposureControlBatchRequest {
  /**
   * List of exposure control features.
   */
  exposureControlRequests: ExposureControlRequest[];
}

/**
 * A list of exposure control feature values.
 */
model ExposureControlBatchResponse {
  /**
   * List of exposure control feature values.
   */
  exposureControlResponses: ExposureControlResponse[];
}

/**
 * Parameters for updating a factory resource.
 */
model FactoryUpdateParameters {
  /**
   * The resource tags.
   */
  tags?: Record<string>;

  /**
   * Managed service identity of the factory.
   */
  identity?: FactoryIdentity;

  /**
   * Properties of update the factory.
   */
  properties?: FactoryUpdateProperties;
}

/**
 * Factory update resource properties.
 */
model FactoryUpdateProperties {
  /**
   * Whether or not public network access is allowed for the data factory.
   */
  publicNetworkAccess?: PublicNetworkAccess;
}

/**
 * Get GitHub access token request definition.
 */
model GitHubAccessTokenRequest {
  /**
   * GitHub access code.
   */
  gitHubAccessCode: string;

  /**
   * GitHub application client ID.
   */
  gitHubClientId?: string;

  /**
   * GitHub bring your own app client secret information.
   */
  gitHubClientSecret?: GitHubClientSecret;

  /**
   * GitHub access token base URL.
   */
  gitHubAccessTokenBaseUrl: string;
}

/**
 * Client secret information for factory's bring your own app repository configuration.
 */
model GitHubClientSecret {
  /**
   * Bring your own app client secret AKV URL.
   */
  byoaSecretAkvUrl?: string;

  /**
   * Bring your own app client secret name in AKV.
   */
  byoaSecretName?: string;
}

/**
 * Get GitHub access token response definition.
 */
model GitHubAccessTokenResponse {
  /**
   * GitHub access token.
   */
  gitHubAccessToken?: string;
}

/**
 * Get Data Plane read only token request definition.
 */
model UserAccessPolicy {
  /**
   * The string with permissions for Data Plane access. Currently only 'r' is supported which grants read only access.
   */
  permissions?: string;

  /**
   * The resource path to get access relative to factory. Currently only empty string is supported which corresponds to the factory resource.
   */
  accessResourcePath?: string;

  /**
   * The name of the profile. Currently only the default is supported. The default value is DefaultProfile.
   */
  profileName?: string;

  /**
   * Start time for the token. If not specified the current time will be used.
   */
  startTime?: string;

  /**
   * Expiration time for the token. Maximum duration for the token is eight hours and by default the token will expire in eight hours.
   */
  expireTime?: string;
}

/**
 * Get Data Plane read only token response definition.
 */
model AccessPolicyResponse {
  /**
   * The user access policy.
   */
  policy?: UserAccessPolicy;

  /**
   * Data Plane read only access token.
   */
  accessToken?: string;

  /**
   * Data Plane service base URL.
   */
  dataPlaneUrl?: string;
}

/**
 * Azure Data Factory nested object which serves as a compute resource for activities.
 */
@discriminator("type")
model IntegrationRuntime extends Record<Record<unknown>> {
  /**
   * Integration runtime description.
   */
  description?: string;
}

/**
 * Azure Data Factory nested resource, which belongs to a factory.
 */
model SubResource {
  /**
   * The resource identifier.
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
   * Etag identifies change in the resource.
   */
  @visibility("read")
  etag?: string;
}

/**
 * Update integration runtime request.
 */
model UpdateIntegrationRuntimeRequest {
  /**
   * Enables or disables the auto-update feature of the self-hosted integration runtime. See https://go.microsoft.com/fwlink/?linkid=854189.
   */
  autoUpdate?: IntegrationRuntimeAutoUpdate;

  /**
   * The time offset (in hours) in the day, e.g., PT03H is 3 hours. The integration runtime auto update will happen on that time.
   */
  updateDelayOffset?: duration;
}

/**
 * Integration runtime status response.
 */
model IntegrationRuntimeStatusResponse {
  /**
   * The integration runtime name.
   */
  @visibility("read")
  name?: string;

  /**
   * Integration runtime properties.
   */
  properties: IntegrationRuntimeStatus;
}

/**
 * Integration runtime status.
 */
@discriminator("type")
model IntegrationRuntimeStatus extends Record<Record<unknown>> {
  /**
   * The data factory name which the integration runtime belong to.
   */
  @visibility("read")
  dataFactoryName?: string;

  /**
   * The state of integration runtime.
   */
  @visibility("read")
  state?: IntegrationRuntimeState;
}

/**
 * Azure-SSIS integration runtime outbound network dependency endpoints.
 */
model IntegrationRuntimeOutboundNetworkDependenciesEndpointsResponse {
  /**
   * The list of outbound network dependency endpoints.
   */
  value?: IntegrationRuntimeOutboundNetworkDependenciesCategoryEndpoint[];
}

/**
 * Azure-SSIS integration runtime outbound network dependency endpoints for one category.
 */
model IntegrationRuntimeOutboundNetworkDependenciesCategoryEndpoint {
  /**
   * The category of outbound network dependency.
   */
  category?: string;

  /**
   * The endpoints for outbound network dependency.
   */
  endpoints?: IntegrationRuntimeOutboundNetworkDependenciesEndpoint[];
}

/**
 * The endpoint for Azure-SSIS integration runtime outbound network dependency.
 */
model IntegrationRuntimeOutboundNetworkDependenciesEndpoint {
  /**
   * The domain name of endpoint.
   */
  domainName?: string;

  /**
   * The details of endpoint.
   */
  endpointDetails?: IntegrationRuntimeOutboundNetworkDependenciesEndpointDetails[];
}

/**
 * The details of Azure-SSIS integration runtime outbound network dependency endpoint.
 */
model IntegrationRuntimeOutboundNetworkDependenciesEndpointDetails {
  /**
   * The port of endpoint.
   */
  port?: int32;
}

/**
 * Connection information for encrypting the on-premises data source credentials.
 */
model IntegrationRuntimeConnectionInfo extends Record<Record<unknown>> {
  /**
   * The token generated in service. Callers use this token to authenticate to integration runtime.
   */
  @visibility("read")
  serviceToken?: string;

  /**
   * The integration runtime SSL certificate thumbprint. Click-Once application uses it to do server validation.
   */
  @visibility("read")
  identityCertThumbprint?: string;

  /**
   * The on-premises integration runtime host URL.
   */
  @visibility("read")
  hostServiceUri?: string;

  /**
   * The integration runtime version.
   */
  @visibility("read")
  version?: string;

  /**
   * The public key for encrypting a credential when transferring the credential to the integration runtime.
   */
  @visibility("read")
  publicKey?: string;

  /**
   * Whether the identity certificate is expired.
   */
  @visibility("read")
  isIdentityCertExprired?: boolean;
}

/**
 * Parameters to regenerate the authentication key.
 */
model IntegrationRuntimeRegenerateKeyParameters {
  /**
   * The name of the authentication key to regenerate.
   */
  keyName?: IntegrationRuntimeAuthKeyName;
}

/**
 * The integration runtime authentication keys.
 */
model IntegrationRuntimeAuthKeys {
  /**
   * The primary integration runtime authentication key.
   */
  authKey1?: string;

  /**
   * The secondary integration runtime authentication key.
   */
  authKey2?: string;
}

/**
 * Get monitoring data response.
 */
model IntegrationRuntimeMonitoringData {
  /**
   * Integration runtime name.
   */
  name?: string;

  /**
   * Integration runtime node monitoring data.
   */
  nodes?: IntegrationRuntimeNodeMonitoringData[];
}

/**
 * Monitoring data for integration runtime node.
 */
model IntegrationRuntimeNodeMonitoringData extends Record<Record<unknown>> {
  /**
   * Name of the integration runtime node.
   */
  @visibility("read")
  nodeName?: string;

  /**
   * Available memory (MB) on the integration runtime node.
   */
  @visibility("read")
  availableMemoryInMB?: int32;

  /**
   * CPU percentage on the integration runtime node.
   */
  @visibility("read")
  cpuUtilization?: int32;

  /**
   * Maximum concurrent jobs on the integration runtime node.
   */
  @visibility("read")
  concurrentJobsLimit?: int32;

  /**
   * The number of jobs currently running on the integration runtime node.
   */
  @visibility("read")
  concurrentJobsRunning?: int32;

  /**
   * The maximum concurrent jobs in this integration runtime.
   */
  @visibility("read")
  maxConcurrentJobs?: int32;

  /**
   * Sent bytes on the integration runtime node.
   */
  @visibility("read")
  sentBytes?: float32;

  /**
   * Received bytes on the integration runtime node.
   */
  @visibility("read")
  receivedBytes?: float32;
}

/**
 * Data factory name for linked integration runtime request.
 */
model LinkedIntegrationRuntimeRequest {
  /**
   * The data factory name for linked integration runtime.
   */
  @projectedName("json", "factoryName")
  linkedFactoryName: string;
}

/**
 * The linked integration runtime information.
 */
model CreateLinkedIntegrationRuntimeRequest {
  /**
   * The name of the linked integration runtime.
   */
  name?: string;

  /**
   * The ID of the subscription that the linked integration runtime belongs to.
   */
  subscriptionId?: string;

  /**
   * The name of the data factory that the linked integration runtime belongs to.
   */
  dataFactoryName?: string;

  /**
   * The location of the data factory that the linked integration runtime belongs to.
   */
  dataFactoryLocation?: string;
}

/**
 * The status of the operation.
 */
model SsisObjectMetadataStatusResponse {
  /**
   * The status of the operation.
   */
  status?: string;

  /**
   * The operation name.
   */
  name?: string;

  /**
   * The operation properties.
   */
  properties?: string;

  /**
   * The operation error message.
   */
  error?: string;
}

/**
 * The request payload of get SSIS object metadata.
 */
model GetSsisObjectMetadataRequest {
  /**
   * Metadata path.
   */
  metadataPath?: string;
}

/**
 * A list of SSIS object metadata.
 */
model SsisObjectMetadataListResponse {
  /**
   * List of SSIS object metadata.
   */
  value?: SsisObjectMetadata[];

  /**
   * The link to the next page of results, if any remaining results exist.
   */
  nextLink?: string;
}

/**
 * SSIS object metadata.
 */
@discriminator("type")
model SsisObjectMetadata {
  /**
   * Metadata id.
   */
  id?: int64;

  /**
   * Metadata name.
   */
  name?: string;

  /**
   * Metadata description.
   */
  description?: string;
}

/**
 * Properties of Self-hosted integration runtime node.
 */
model SelfHostedIntegrationRuntimeNode extends Record<Record<unknown>> {
  /**
   * Name of the integration runtime node.
   */
  @visibility("read")
  nodeName?: string;

  /**
   * Machine name of the integration runtime node.
   */
  @visibility("read")
  machineName?: string;

  /**
   * URI for the host machine of the integration runtime.
   */
  @visibility("read")
  hostServiceUri?: string;

  /**
   * Status of the integration runtime node.
   */
  @visibility("read")
  status?: SelfHostedIntegrationRuntimeNodeStatus;

  /**
   * The integration runtime capabilities dictionary
   */
  @visibility("read")
  capabilities?: Record<string>;

  /**
   * Status of the integration runtime node version.
   */
  @visibility("read")
  versionStatus?: string;

  /**
   * Version of the integration runtime node.
   */
  @visibility("read")
  version?: string;

  /**
   * The time at which the integration runtime node was registered in ISO8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  registerTime?: utcDateTime;

  /**
   * The most recent time at which the integration runtime was connected in ISO8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastConnectTime?: utcDateTime;

  /**
   * The time at which the integration runtime will expire in ISO8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  /**
   * The time the node last started up.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStartTime?: utcDateTime;

  /**
   * The integration runtime node last stop time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStopTime?: utcDateTime;

  /**
   * The result of the last integration runtime node update.
   */
  @visibility("read")
  lastUpdateResult?: IntegrationRuntimeUpdateResult;

  /**
   * The last time for the integration runtime node update start.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStartUpdateTime?: utcDateTime;

  /**
   * The last time for the integration runtime node update end.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastEndUpdateTime?: utcDateTime;

  /**
   * Indicates whether this node is the active dispatcher for integration runtime requests.
   */
  @visibility("read")
  isActiveDispatcher?: boolean;

  /**
   * Maximum concurrent jobs on the integration runtime node.
   */
  @visibility("read")
  concurrentJobsLimit?: int32;

  /**
   * The maximum concurrent jobs in this integration runtime.
   */
  @visibility("read")
  maxConcurrentJobs?: int32;
}

/**
 * Update integration runtime node request.
 */
model UpdateIntegrationRuntimeNodeRequest {
  /**
   * The number of concurrent jobs permitted to run on the integration runtime node. Values between 1 and maxConcurrentJobs(inclusive) are allowed.
   */
  @minValue(1)
  concurrentJobsLimit?: int32;
}

/**
 * The IP address of self-hosted integration runtime node.
 */
model IntegrationRuntimeNodeIpAddress {
  /**
   * The IP address of self-hosted integration runtime node.
   */
  @visibility("read")
  ipAddress?: string;
}

/**
 * The nested object which contains the information and credential which can be used to connect with related store or compute resource.
 */
@discriminator("type")
model LinkedService extends Record<Record<unknown>> {
  /**
   * The integration runtime reference.
   */
  connectVia?: IntegrationRuntimeReference;

  /**
   * Linked service description.
   */
  description?: string;

  /**
   * Parameters for linked service.
   */
  parameters?: Record<ParameterSpecification>;

  /**
   * List of tags that can be used for describing the linked service.
   */
  annotations?: Record<unknown>[];
}

/**
 * Integration runtime reference type.
 */
model IntegrationRuntimeReference {
  /**
   * Type of integration runtime.
   */
  type: IntegrationRuntimeReferenceType;

  /**
   * Reference integration runtime name.
   */
  referenceName: string;

  /**
   * Arguments for integration runtime.
   */
  parameters?: Record<Record<unknown>>;
}

/**
 * Definition of a single parameter for an entity.
 */
model ParameterSpecification {
  /**
   * Parameter type.
   */
  type: ParameterType;

  /**
   * Default value of parameter.
   */
  defaultValue?: Record<unknown>;
}

/**
 * The Azure Data Factory nested object which identifies data within different data stores, such as tables, files, folders, and documents.
 */
@discriminator("type")
model Dataset extends Record<Record<unknown>> {
  /**
   * Dataset description.
   */
  description?: string;

  /**
   * Columns that define the structure of the dataset. Type: array (or Expression with resultType array), itemType: DatasetDataElement.
   */
  structure?: Record<unknown>;

  /**
   * Columns that define the physical type schema of the dataset. Type: array (or Expression with resultType array), itemType: DatasetSchemaDataElement.
   */
  schema?: Record<unknown>;

  /**
   * Linked service reference.
   */
  linkedServiceName: LinkedServiceReference;

  /**
   * Parameters for dataset.
   */
  parameters?: Record<ParameterSpecification>;

  /**
   * List of tags that can be used for describing the Dataset.
   */
  annotations?: Record<unknown>[];

  /**
   * The folder that this Dataset is in. If not specified, Dataset will appear at the root level.
   */
  folder?: DatasetFolder;
}

/**
 * Linked service reference type.
 */
model LinkedServiceReference {
  /**
   * Linked service reference type.
   */
  type: LinkedServiceReferenceType;

  /**
   * Reference LinkedService name.
   */
  referenceName: string;

  /**
   * Arguments for LinkedService.
   */
  parameters?: Record<Record<unknown>>;
}

/**
 * The folder that this Dataset is in. If not specified, Dataset will appear at the root level.
 */
model DatasetFolder {
  /**
   * The name of the folder that this Dataset is in.
   */
  name?: string;
}

/**
 * A data factory pipeline.
 */
model Pipeline {
  /**
   * The description of the pipeline.
   */
  description?: string;

  /**
   * List of activities in pipeline.
   */
  activities?: Activity[];

  /**
   * List of parameters for pipeline.
   */
  parameters?: Record<ParameterSpecification>;

  /**
   * List of variables for pipeline.
   */
  variables?: Record<VariableSpecification>;

  /**
   * The max number of concurrent runs for the pipeline.
   */
  @minValue(1)
  concurrency?: int32;

  /**
   * List of tags that can be used for describing the Pipeline.
   */
  annotations?: Record<unknown>[];

  /**
   * Dimensions emitted by Pipeline.
   */
  runDimensions?: Record<Record<unknown>>;

  /**
   * The folder that this Pipeline is in. If not specified, Pipeline will appear at the root level.
   */
  folder?: PipelineFolder;

  /**
   * Pipeline Policy.
   */
  policy?: PipelinePolicy;
}

/**
 * A pipeline activity.
 */
@discriminator("type")
model Activity extends Record<Record<unknown>> {
  /**
   * Activity name.
   */
  name: string;

  /**
   * Activity description.
   */
  description?: string;

  /**
   * Activity state. This is an optional property and if not provided, the state will be Active by default.
   */
  state?: ActivityState;

  /**
   * Status result of the activity when the state is set to Inactive. This is an optional property and if not provided when the activity is inactive, the status will be Succeeded by default.
   */
  onInactiveMarkAs?: ActivityOnInactiveMarkAs;

  /**
   * Activity depends on condition.
   */
  dependsOn?: ActivityDependency[];

  /**
   * Activity user properties.
   */
  userProperties?: UserProperty[];
}

/**
 * Activity dependency information.
 */
model ActivityDependency extends Record<Record<unknown>> {
  /**
   * Activity name.
   */
  activity: string;

  /**
   * Match-Condition for the dependency.
   */
  dependencyConditions: DependencyCondition[];
}

/**
 * User property.
 */
model UserProperty {
  /**
   * User property name.
   */
  name: string;

  /**
   * User property value. Type: string (or Expression with resultType string).
   */
  value: Record<unknown>;
}

/**
 * Definition of a single variable for a Pipeline.
 */
model VariableSpecification {
  /**
   * Variable type.
   */
  type: VariableType;

  /**
   * Default value of variable.
   */
  defaultValue?: Record<unknown>;
}

/**
 * The folder that this Pipeline is in. If not specified, Pipeline will appear at the root level.
 */
model PipelineFolder {
  /**
   * The name of the folder that this Pipeline is in.
   */
  name?: string;
}

/**
 * Pipeline Policy.
 */
model PipelinePolicy {
  /**
   * Pipeline ElapsedTime Metric Policy.
   */
  elapsedTimeMetric?: PipelineElapsedTimeMetricPolicy;
}

/**
 * Pipeline ElapsedTime Metric Policy.
 */
model PipelineElapsedTimeMetricPolicy {
  /**
   * TimeSpan value, after which an Azure Monitoring Metric is fired.
   */
  duration?: Record<unknown>;
}

/**
 * Response body with a run identifier.
 */
model CreateRunResponse {
  /**
   * Identifier of a run.
   */
  runId: string;
}

/**
 * Query parameters for listing runs.
 */
model RunFilterParameters {
  /**
   * The continuation token for getting the next page of results. Null for first page.
   */
  continuationToken?: string;

  /**
   * The time at or after which the run event was updated in 'ISO 8601' format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedAfter: utcDateTime;

  /**
   * The time at or before which the run event was updated in 'ISO 8601' format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedBefore: utcDateTime;

  /**
   * List of filters.
   */
  filters?: RunQueryFilter[];

  /**
   * List of OrderBy option.
   */
  orderBy?: RunQueryOrderBy[];
}

/**
 * Query filter option for listing runs.
 */
model RunQueryFilter {
  /**
   * Parameter name to be used for filter. The allowed operands to query pipeline runs are PipelineName, RunStart, RunEnd and Status; to query activity runs are ActivityName, ActivityRunStart, ActivityRunEnd, ActivityType and Status, and to query trigger runs are TriggerName, TriggerRunTimestamp and Status.
   */
  operand: RunQueryFilterOperand;

  /**
   * Operator to be used for filter.
   */
  operator: RunQueryFilterOperator;

  /**
   * List of filter values.
   */
  values: string[];
}

/**
 * An object to provide order by options for listing runs.
 */
model RunQueryOrderBy {
  /**
   * Parameter name to be used for order by. The allowed parameters to order by for pipeline runs are PipelineName, RunStart, RunEnd and Status; for activity runs are ActivityName, ActivityRunStart, ActivityRunEnd and Status; for trigger runs are TriggerName, TriggerRunTimestamp and Status.
   */
  orderBy: RunQueryOrderByField;

  /**
   * Sorting order of the parameter.
   */
  order: RunQueryOrder;
}

/**
 * A list pipeline runs.
 */
model PipelineRunsQueryResponse {
  /**
   * List of pipeline runs.
   */
  value: PipelineRun[];

  /**
   * The continuation token for getting the next page of results, if any remaining results exist, null otherwise.
   */
  continuationToken?: string;
}

/**
 * Information about a pipeline run.
 */
model PipelineRun extends Record<Record<unknown>> {
  /**
   * Identifier of a run.
   */
  @visibility("read")
  runId?: string;

  /**
   * Identifier that correlates all the recovery runs of a pipeline run.
   */
  @visibility("read")
  runGroupId?: string;

  /**
   * Indicates if the recovered pipeline run is the latest in its group.
   */
  @visibility("read")
  isLatest?: boolean;

  /**
   * The pipeline name.
   */
  @visibility("read")
  pipelineName?: string;

  /**
   * The full or partial list of parameter name, value pair used in the pipeline run.
   */
  @visibility("read")
  parameters?: Record<string>;

  /**
   * Run dimensions emitted by Pipeline run.
   */
  @visibility("read")
  runDimensions?: Record<string>;

  /**
   * Entity that started the pipeline run.
   */
  @visibility("read")
  invokedBy?: PipelineRunInvokedBy;

  /**
   * The last updated timestamp for the pipeline run event in ISO8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  /**
   * The start time of a pipeline run in ISO8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  runStart?: utcDateTime;

  /**
   * The end time of a pipeline run in ISO8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  runEnd?: utcDateTime;

  /**
   * The duration of a pipeline run.
   */
  @visibility("read")
  durationInMs?: int32;

  /**
   * The status of a pipeline run. Possible values: Queued, InProgress, Succeeded, Failed, Canceling, Cancelled
   */
  @visibility("read")
  status?: string;

  /**
   * The message from a pipeline run.
   */
  @visibility("read")
  message?: string;
}

/**
 * Provides entity name and id that started the pipeline run.
 */
model PipelineRunInvokedBy {
  /**
   * Name of the entity that started the pipeline run.
   */
  @visibility("read")
  name?: string;

  /**
   * The ID of the entity that started the run.
   */
  @visibility("read")
  id?: string;

  /**
   * The type of the entity that started the run.
   */
  @visibility("read")
  invokedByType?: string;

  /**
   * The name of the pipeline that triggered the run, if any.
   */
  @visibility("read")
  pipelineName?: string;

  /**
   * The run id of the pipeline that triggered the run, if any.
   */
  @visibility("read")
  pipelineRunId?: string;
}

/**
 * A list activity runs.
 */
model ActivityRunsQueryResponse {
  /**
   * List of activity runs.
   */
  value: ActivityRun[];

  /**
   * The continuation token for getting the next page of results, if any remaining results exist, null otherwise.
   */
  continuationToken?: string;
}

/**
 * Information about an activity run in a pipeline.
 */
model ActivityRun extends Record<Record<unknown>> {
  /**
   * The name of the pipeline.
   */
  @visibility("read")
  pipelineName?: string;

  /**
   * The id of the pipeline run.
   */
  @visibility("read")
  pipelineRunId?: string;

  /**
   * The name of the activity.
   */
  @visibility("read")
  activityName?: string;

  /**
   * The type of the activity.
   */
  @visibility("read")
  activityType?: string;

  /**
   * The id of the activity run.
   */
  @visibility("read")
  activityRunId?: string;

  /**
   * The name of the compute linked service.
   */
  @visibility("read")
  linkedServiceName?: string;

  /**
   * The status of the activity run.
   */
  @visibility("read")
  status?: string;

  /**
   * The start time of the activity run in 'ISO 8601' format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  activityRunStart?: utcDateTime;

  /**
   * The end time of the activity run in 'ISO 8601' format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  activityRunEnd?: utcDateTime;

  /**
   * The duration of the activity run.
   */
  @visibility("read")
  durationInMs?: int32;

  /**
   * The input for the activity.
   */
  @visibility("read")
  input?: Record<unknown>;

  /**
   * The output for the activity.
   */
  @visibility("read")
  output?: Record<unknown>;

  /**
   * The error if any from the activity run.
   */
  @visibility("read")
  error?: Record<unknown>;
}

/**
 * Azure data factory nested object which contains information about creating pipeline run
 */
@discriminator("type")
model Trigger extends Record<Record<unknown>> {
  /**
   * Trigger description.
   */
  description?: string;

  /**
   * Indicates if trigger is running or not. Updated when Start/Stop APIs are called on the Trigger.
   */
  @visibility("read")
  runtimeState?: TriggerRuntimeState;

  /**
   * List of tags that can be used for describing the trigger.
   */
  annotations?: Record<unknown>[];
}

/**
 * Query parameters for triggers.
 */
model TriggerFilterParameters {
  /**
   * The continuation token for getting the next page of results. Null for first page.
   */
  continuationToken?: string;

  /**
   * The name of the parent TumblingWindowTrigger to get the child rerun triggers
   */
  parentTriggerName?: string;
}

/**
 * A query of triggers.
 */
model TriggerQueryResponse {
  /**
   * List of triggers.
   */
  value: TriggerResource[];

  /**
   * The continuation token for getting the next page of results, if any remaining results exist, null otherwise.
   */
  continuationToken?: string;
}

/**
 * Defines the response of a trigger subscription operation.
 */
model TriggerSubscriptionOperationStatus {
  /**
   * Trigger name.
   */
  @visibility("read")
  triggerName?: string;

  /**
   * Event Subscription Status.
   */
  @visibility("read")
  status?: EventSubscriptionStatus;
}

/**
 * A list of trigger runs.
 */
model TriggerRunsQueryResponse {
  /**
   * List of trigger runs.
   */
  value: TriggerRun[];

  /**
   * The continuation token for getting the next page of results, if any remaining results exist, null otherwise.
   */
  continuationToken?: string;
}

/**
 * Trigger runs.
 */
model TriggerRun extends Record<Record<unknown>> {
  /**
   * Trigger run id.
   */
  @visibility("read")
  triggerRunId?: string;

  /**
   * Trigger name.
   */
  @visibility("read")
  triggerName?: string;

  /**
   * Trigger type.
   */
  @visibility("read")
  triggerType?: string;

  /**
   * Trigger run start time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  triggerRunTimestamp?: utcDateTime;

  /**
   * Trigger run status.
   */
  @visibility("read")
  status?: TriggerRunStatus;

  /**
   * Trigger error message.
   */
  @visibility("read")
  message?: string;

  /**
   * List of property name and value related to trigger run. Name, value pair depends on type of trigger.
   */
  @visibility("read")
  properties?: Record<string>;

  /**
   * List of pipeline name and run Id triggered by the trigger run.
   */
  @visibility("read")
  triggeredPipelines?: Record<string>;

  /**
   * Run dimension for which trigger was fired.
   */
  @visibility("read")
  runDimension?: Record<string>;

  /**
   * Status of the upstream pipelines.
   */
  @visibility("read")
  dependencyStatus?: Record<Record<unknown>>;
}

/**
 * Azure Data Factory nested object which contains a flow with data movements and transformations.
 */
@discriminator("type")
model DataFlow {
  /**
   * The description of the data flow.
   */
  description?: string;

  /**
   * List of tags that can be used for describing the data flow.
   */
  annotations?: Record<unknown>[];

  /**
   * The folder that this data flow is in. If not specified, Data flow will appear at the root level.
   */
  folder?: DataFlowFolder;
}

/**
 * The folder that this data flow is in. If not specified, Data flow will appear at the root level.
 */
model DataFlowFolder {
  /**
   * The name of the folder that this data flow is in.
   */
  name?: string;
}

/**
 * Request body structure for creating data flow debug session.
 */
model CreateDataFlowDebugSessionRequest {
  /**
   * Compute type of the cluster. The value will be overwritten by the same setting in integration runtime if provided.
   */
  computeType?: string;

  /**
   * Core count of the cluster. The value will be overwritten by the same setting in integration runtime if provided.
   */
  coreCount?: int32;

  /**
   * Time to live setting of the cluster in minutes.
   */
  timeToLive?: int32;

  /**
   * Set to use integration runtime setting for data flow debug session.
   */
  integrationRuntime?: IntegrationRuntimeDebugResource;
}

/**
 * Integration runtime debug resource.
 */
model IntegrationRuntimeDebugResource extends SubResourceDebugResource {
  /**
   * Integration runtime properties.
   */
  properties: IntegrationRuntime;
}

/**
 * Azure Data Factory nested debug resource.
 */
model SubResourceDebugResource {
  /**
   * The resource name.
   */
  name?: string;
}

/**
 * Response body structure for creating data flow debug session.
 */
model CreateDataFlowDebugSessionResponse {
  /**
   * The state of the debug session.
   */
  status?: string;

  /**
   * The ID of data flow debug session.
   */
  sessionId?: string;
}

/**
 * A list of active debug sessions.
 */
model QueryDataFlowDebugSessionsResponse
  is Azure.Core.Page<DataFlowDebugSessionInfo>;

/**
 * Data flow debug session info.
 */
model DataFlowDebugSessionInfo extends Record<Record<unknown>> {
  /**
   * The name of the data flow.
   */
  dataFlowName?: string;

  /**
   * Compute type of the cluster.
   */
  computeType?: string;

  /**
   * Core count of the cluster.
   */
  coreCount?: int32;

  /**
   * Node count of the cluster. (deprecated property)
   */
  nodeCount?: int32;

  /**
   * Attached integration runtime name of data flow debug session.
   */
  integrationRuntimeName?: string;

  /**
   * The ID of data flow debug session.
   */
  sessionId?: string;

  /**
   * Start time of data flow debug session.
   */
  startTime?: string;

  /**
   * Compute type of the cluster.
   */
  timeToLiveInMinutes?: int32;

  /**
   * Last activity time of data flow debug session.
   */
  lastActivityTime?: string;
}

/**
 * Request body structure for starting data flow debug session.
 */
model DataFlowDebugPackage extends Record<Record<unknown>> {
  /**
   * The ID of data flow debug session.
   */
  sessionId?: string;

  /**
   * Data flow instance.
   */
  dataFlow?: DataFlowDebugResource;

  /**
   * List of Data flows
   */
  dataFlows?: DataFlowDebugResource[];

  /**
   * List of datasets.
   */
  datasets?: DatasetDebugResource[];

  /**
   * List of linked services.
   */
  linkedServices?: LinkedServiceDebugResource[];

  /**
   * Staging info for debug session.
   */
  staging?: DataFlowStagingInfo;

  /**
   * Data flow debug settings.
   */
  debugSettings?: DataFlowDebugPackageDebugSettings;
}

/**
 * Data flow debug resource.
 */
model DataFlowDebugResource extends SubResourceDebugResource {
  /**
   * Data flow properties.
   */
  properties: DataFlow;
}

/**
 * Dataset debug resource.
 */
model DatasetDebugResource extends SubResourceDebugResource {
  /**
   * Dataset properties.
   */
  properties: Dataset;
}

/**
 * Linked service debug resource.
 */
model LinkedServiceDebugResource extends SubResourceDebugResource {
  /**
   * Properties of linked service.
   */
  properties: LinkedService;
}

/**
 * Staging info for execute data flow activity.
 */
model DataFlowStagingInfo {
  /**
   * Staging linked service reference.
   */
  linkedService?: LinkedServiceReference;

  /**
   * Folder path for staging blob. Type: string (or Expression with resultType string)
   */
  folderPath?: Record<unknown>;
}

/**
 * Data flow debug settings.
 */
model DataFlowDebugPackageDebugSettings {
  /**
   * Source setting for data flow debug.
   */
  sourceSettings?: DataFlowSourceSetting[];

  /**
   * Data flow parameters.
   */
  parameters?: Record<Record<unknown>>;

  /**
   * Parameters for dataset.
   */
  datasetParameters?: Record<unknown>;
}

/**
 * Definition of data flow source setting for debug.
 */
model DataFlowSourceSetting extends Record<Record<unknown>> {
  /**
   * The data flow source name.
   */
  sourceName?: string;

  /**
   * Defines the row limit of data flow source in debug.
   */
  rowLimit?: int32;
}

/**
 * Response body structure for starting data flow debug session.
 */
model AddDataFlowToDebugSessionResponse {
  /**
   * The ID of data flow debug job version.
   */
  jobVersion?: string;
}

/**
 * Request body structure for deleting data flow debug session.
 */
model DeleteDataFlowDebugSessionRequest {
  /**
   * The ID of data flow debug session.
   */
  sessionId?: string;
}

/**
 * Request body structure for data flow debug command.
 */
model DataFlowDebugCommandRequest {
  /**
   * The ID of data flow debug session.
   */
  sessionId?: string;

  /**
   * The command type.
   */
  command?: DataFlowDebugCommandType;

  /**
   * The command payload object.
   */
  commandPayload?: DataFlowDebugCommandPayload;
}

/**
 * Structure of command payload.
 */
model DataFlowDebugCommandPayload {
  /**
   * The stream name which is used for preview.
   */
  streamName: string;

  /**
   * Row limits for preview response.
   */
  rowLimits?: int32;

  /**
   * Array of column names.
   */
  columns?: string[];

  /**
   * The expression which is used for preview.
   */
  expression?: string;
}

/**
 * Response body structure of data flow result for data preview, statistics or expression preview.
 */
model DataFlowDebugCommandResponse {
  /**
   * The run status of data preview, statistics or expression preview.
   */
  status?: string;

  /**
   * The result data of data preview, statistics or expression preview.
   */
  data?: string;
}

/**
 * A managed Virtual Network associated with the Azure Data Factory
 */
model ManagedVirtualNetwork extends Record<Record<unknown>> {
  /**
   * Managed Virtual Network ID.
   */
  @visibility("read")
  vNetId?: string;

  /**
   * Managed Virtual Network alias.
   */
  @visibility("read")
  `alias`?: string;
}

/**
 * Properties of a managed private endpoint
 */
model ManagedPrivateEndpoint extends Record<Record<unknown>> {
  /**
   * The managed private endpoint connection state
   */
  connectionState?: ConnectionStateProperties;

  /**
   * Fully qualified domain names
   */
  fqdns?: string[];

  /**
   * The groupId to which the managed private endpoint is created
   */
  groupId?: string;

  /**
   * Denotes whether the managed private endpoint is reserved
   */
  @visibility("read")
  isReserved?: boolean;

  /**
   * The ARM resource ID of the resource to which the managed private endpoint is created
   */
  privateLinkResourceId?: string;

  /**
   * The managed private endpoint provisioning state
   */
  @visibility("read")
  provisioningState?: string;
}

/**
 * The connection state of a managed private endpoint
 */
model ConnectionStateProperties {
  /**
   * The actions required on the managed private endpoint
   */
  @visibility("read")
  actionsRequired?: string;

  /**
   * The managed private endpoint description
   */
  @visibility("read")
  description?: string;

  /**
   * The approval status
   */
  @visibility("read")
  status?: string;
}

/**
 * Managed identity credential.
 */
model ManagedIdentityCredential extends Credential {
  /**
   * Managed identity credential properties.
   */
  typeProperties?: ManagedIdentityTypeProperties;

  /**
   * Type of credential.
   */
  type: "ManagedIdentity";
}

/**
 * Managed identity type properties.
 */
model ManagedIdentityTypeProperties {
  /**
   * The resource id of user assigned managed identity
   */
  resourceId?: string;
}

/**
 * The Azure Data Factory nested object which contains the information and credential which can be used to connect with related store or compute resource.
 */
@discriminator("type")
model Credential extends Record<Record<unknown>> {
  /**
   * Credential description.
   */
  description?: string;

  /**
   * List of tags that can be used for describing the Credential.
   */
  annotations?: Record<unknown>[];
}

/**
 * A remote private endpoint connection
 */
model RemotePrivateEndpointConnection {
  @visibility("read")
  provisioningState?: string;

  /**
   * PrivateEndpoint of a remote private endpoint connection
   */
  privateEndpoint?: ArmIdWrapper;

  /**
   * The state of a private link connection
   */
  privateLinkServiceConnectionState?: PrivateLinkConnectionState;
}

/**
 * A wrapper for an ARM resource id
 */
model ArmIdWrapper {
  @visibility("read")
  id?: string;
}

/**
 * The state of a private link connection
 */
model PrivateLinkConnectionState {
  /**
   * Status of a private link connection
   */
  status?: string;

  /**
   * Description of a private link connection
   */
  description?: string;

  /**
   * ActionsRequired for a private link connection
   */
  actionsRequired?: string;
}

/**
 * Private Endpoint Connection Approval ARM resource.
 */
model PrivateLinkConnectionApprovalRequestResource extends SubResource {
  /**
   * Core resource properties
   */
  properties?: PrivateLinkConnectionApprovalRequest;
}

/**
 * A request to approve or reject a private endpoint connection
 */
model PrivateLinkConnectionApprovalRequest {
  /**
   * The state of a private link connection
   */
  privateLinkServiceConnectionState?: PrivateLinkConnectionState;

  /**
   * The resource of private endpoint.
   */
  privateEndpoint?: PrivateEndpoint;
}

/**
 * Private endpoint which a connection belongs to.
 */
model PrivateEndpoint {
  /**
   * The resource Id for private endpoint
   */
  id?: string;
}

/**
 * Wrapper for a collection of private link resources
 */
model PrivateLinkResourcesWrapper {
  value: PrivateLinkResource[];
}

/**
 * A private link resource
 */
model PrivateLinkResource extends SubResource {
  /**
   * Core resource properties
   */
  properties?: PrivateLinkResourceProperties;
}

/**
 * Properties of a private link resource
 */
model PrivateLinkResourceProperties {
  /**
   * GroupId of a private link resource
   */
  @visibility("read")
  groupId?: string;

  /**
   * RequiredMembers of a private link resource
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * RequiredZoneNames of a private link resource
   */
  @visibility("read")
  requiredZoneNames?: string[];
}

/**
 * A Azure Data Factory object which automatically detects data changes at the source and then sends the updated data to the destination.
 */
model ChangeDataCapture {
  /**
   * The folder that this CDC is in. If not specified, CDC will appear at the root level.
   */
  folder?: ChangeDataCaptureFolder;

  /**
   * The description of the change data capture.
   */
  description?: string;

  /**
   * List of sources connections that can be used as sources in the CDC.
   */
  sourceConnectionsInfo: MapperSourceConnectionsInfo[];

  /**
   * List of target connections that can be used as sources in the CDC.
   */
  targetConnectionsInfo: MapperTargetConnectionsInfo[];

  /**
   * CDC policy
   */
  policy: MapperPolicy;

  /**
   * A boolean to determine if the vnet configuration needs to be overwritten.
   */
  allowVNetOverride?: boolean;

  /**
   * Status of the CDC as to if it is running or stopped.
   */
  status?: string;
}

/**
 * The folder that this CDC is in. If not specified, CDC will appear at the root level.
 */
model ChangeDataCaptureFolder {
  /**
   * The name of the folder that this CDC is in.
   */
  name?: string;
}

/**
 * A object which contains list of tables and connection details for a source connection.
 */
model MapperSourceConnectionsInfo {
  /**
   * List of source tables for a source connection.
   */
  sourceEntities?: MapperTable[];

  /**
   * Source connection details.
   */
  connection?: MapperConnection;
}

/**
 * CDC table details.
 */
model MapperTable {
  /**
   * Name of the table.
   */
  name?: string;

  /**
   * Table properties.
   */
  properties?: MapperTableProperties;
}

/**
 * Properties for a CDC table.
 */
model MapperTableProperties {
  /**
   * List of columns for the source table.
   */
  schema?: MapperTableSchema[];

  /**
   * List of name/value pairs for connection properties.
   */
  dslConnectorProperties?: MapperDslConnectorProperties[];
}

/**
 * Schema of a CDC table in terms of column names and their corresponding data types.
 */
model MapperTableSchema {
  /**
   * Name of the column.
   */
  name?: string;

  /**
   * Data type of the column.
   */
  dataType?: string;
}

/**
 * Connector properties of a CDC table in terms of name / value pairs.
 */
model MapperDslConnectorProperties {
  /**
   * Name of the property.
   */
  name?: string;

  /**
   * Value of the property.
   */
  value?: Record<unknown>;
}

/**
 * Source connection details.
 */
model MapperConnection {
  /**
   * Linked service reference.
   */
  linkedService?: LinkedServiceReference;

  /**
   * Type of the linked service e.g.: AzureBlobFS.
   */
  linkedServiceType?: string;

  /**
   * Type of connection via linked service or dataset.
   */
  type: ConnectionType;

  /**
   * A boolean indicating whether linked service is of type inline dataset. Currently only inline datasets are supported.
   */
  isInlineDataset?: boolean;

  /**
   * List of name/value pairs for connection properties.
   */
  commonDslConnectorProperties?: MapperDslConnectorProperties[];
}

/**
 * A object which contains list of tables and connection details for a target connection.
 */
model MapperTargetConnectionsInfo {
  /**
   * List of source tables for a target connection.
   */
  targetEntities?: MapperTable[];

  /**
   * Source connection details.
   */
  connection?: MapperConnection;

  /**
   * List of table mappings.
   */
  dataMapperMappings?: DataMapperMapping[];

  /**
   * List of relationship info among the tables.
   */
  relationships?: Record<unknown>[];
}

/**
 * Source and target table mapping details.
 */
model DataMapperMapping {
  /**
   * Name of the target table
   */
  targetEntityName?: string;

  /**
   * Name of the source table
   */
  sourceEntityName?: string;

  /**
   * The connection reference for the source connection.
   */
  sourceConnectionReference?: MapperConnectionReference;

  /**
   * This holds the user provided attribute mapping information.
   */
  attributeMappingInfo?: MapperAttributeMappings;

  /**
   * This holds the source denormalization information used while joining multiple sources.
   */
  sourceDenormalizeInfo?: Record<unknown>;
}

/**
 * Source or target connection reference details.
 */
model MapperConnectionReference {
  /**
   * Name of the connection
   */
  connectionName?: string;

  /**
   * Type of connection via linked service or dataset.
   */
  type?: ConnectionType;
}

/**
 * Attribute mapping details.
 */
model MapperAttributeMappings {
  /**
   * List of attribute mappings.
   */
  attributeMappings?: MapperAttributeMapping[];
}

/**
 * Source and target column mapping details.
 */
model MapperAttributeMapping {
  /**
   * Name of the target column.
   */
  name?: string;

  /**
   * Type of the CDC attribute mapping. Note: 'Advanced' mapping type is also saved as 'Derived'.
   */
  type?: MappingType;

  /**
   * Name of the function used for 'Aggregate' and 'Derived' (except 'Advanced') type mapping.
   */
  functionName?: string;

  /**
   * Expression used for 'Aggregate' and 'Derived' type mapping.
   */
  expression?: string;

  /**
   * Reference of the source column used in the mapping. It is used for 'Direct' mapping type only.
   */
  attributeReference?: MapperAttributeReference;

  /**
   * List of references for source columns. It is used for 'Derived' and 'Aggregate' type mappings only.
   */
  attributeReferences?: MapperAttributeReference[];
}

/**
 * Attribute reference details for the referred column.
 */
model MapperAttributeReference {
  /**
   * Name of the column.
   */
  name?: string;

  /**
   * Name of the table.
   */
  entity?: string;

  /**
   * The connection reference for the connection.
   */
  entityConnectionReference?: MapperConnectionReference;
}

/**
 * CDC Policy.
 */
model MapperPolicy {
  /**
   * Mode of running the CDC: batch vs continuous.
   */
  mode?: string;

  /**
   * Defines the frequency and interval for running the CDC for batch mode.
   */
  recurrence?: MapperPolicyRecurrence;
}

/**
 * CDC policy recurrence details.
 */
model MapperPolicyRecurrence {
  /**
   * Frequency of period in terms of 'Hour', 'Minute' or 'Second'.
   */
  frequency?: FrequencyType;

  /**
   * Actual interval value as per chosen frequency.
   */
  interval?: int32;
}

/**
 * Azure Data Factory expression definition.
 */
model Expression {
  /**
   * Expression type.
   */
  type: ExpressionType;

  /**
   * Expression value.
   */
  value: string;
}

/**
 * Azure Data Factory secure string definition. The string value will be masked with asterisks '*' during Get or List API calls.
 */
model SecureString extends SecretBase {
  /**
   * Value of secure string.
   */
  value: string;

  /**
   * Type of the secret.
   */
  type: "SecureString";
}

/**
 * The base definition of a secret type.
 */
@discriminator("type")
model SecretBase {}

/**
 * Azure Key Vault secret reference.
 */
model AzureKeyVaultSecretReference extends SecretBase {
  /**
   * The Azure Key Vault linked service reference.
   */
  store: LinkedServiceReference;

  /**
   * The name of the secret in Azure Key Vault. Type: string (or Expression with resultType string).
   */
  secretName: Record<unknown>;

  /**
   * The version of the secret in Azure Key Vault. The default value is the latest version of the secret. Type: string (or Expression with resultType string).
   */
  secretVersion?: Record<unknown>;

  /**
   * Type of the secret.
   */
  type: "AzureKeyVaultSecret";
}

/**
 * A list of integration runtime status.
 */
model IntegrationRuntimeStatusListResponse {
  /**
   * List of integration runtime status.
   */
  value: IntegrationRuntimeStatusResponse[];

  /**
   * The link to the next page of results, if any remaining results exist.
   */
  nextLink?: string;
}

/**
 * Factory's VSTS repo information.
 */
model FactoryVstsConfiguration extends FactoryRepoConfiguration {
  /**
   * VSTS project name.
   */
  projectName: string;

  /**
   * VSTS tenant id.
   */
  tenantId?: string;

  /**
   * Type of repo configuration.
   */
  type: "FactoryVSTSConfiguration";
}

/**
 * Factory's GitHub repo information.
 */
model FactoryGitHubConfiguration extends FactoryRepoConfiguration {
  /**
   * GitHub Enterprise host name. For example: `https://github.mydomain.com`
   */
  hostName?: string;

  /**
   * GitHub bring your own app client id.
   */
  clientId?: string;

  /**
   * GitHub bring your own app client secret information.
   */
  clientSecret?: GitHubClientSecret;

  /**
   * Type of repo configuration.
   */
  type: "FactoryGitHubConfiguration";
}

/**
 * Pipeline reference type.
 */
model PipelineReference {
  /**
   * Pipeline reference type.
   */
  type: PipelineReferenceType;

  /**
   * Reference pipeline name.
   */
  referenceName: string;

  /**
   * Reference name.
   */
  name?: string;
}

/**
 * Pipeline that needs to be triggered with the given parameters.
 */
model TriggerPipelineReference {
  /**
   * Pipeline reference.
   */
  pipelineReference?: PipelineReference;

  /**
   * Pipeline parameters.
   */
  parameters?: Record<Record<unknown>>;
}

/**
 * Dataset reference type.
 */
model DatasetReference {
  /**
   * Dataset reference type.
   */
  type: DatasetReferenceType;

  /**
   * Reference dataset name.
   */
  referenceName: string;

  /**
   * Arguments for dataset.
   */
  parameters?: Record<Record<unknown>>;
}

/**
 * Response body structure for get data factory operation status.
 */
model GetDataFactoryOperationStatusResponse extends Record<Record<unknown>> {
  /**
   * Status of the operation.
   */
  status?: string;
}

/**
 * Data flow reference type.
 */
model DataFlowReference extends Record<Record<unknown>> {
  /**
   * Data flow reference type.
   */
  type: DataFlowReferenceType;

  /**
   * Reference data flow name.
   */
  referenceName: string;

  /**
   * Reference data flow parameters from dataset.
   */
  datasetParameters?: Record<unknown>;

  /**
   * Data flow parameters
   */
  parameters?: Record<Record<unknown>>;
}

/**
 * Managed Virtual Network reference type.
 */
model ManagedVirtualNetworkReference {
  /**
   * Managed Virtual Network reference type.
   */
  type: ManagedVirtualNetworkReferenceType;

  /**
   * Reference ManagedVirtualNetwork name.
   */
  referenceName: string;
}

/**
 * Credential reference type.
 */
model CredentialReference extends Record<Record<unknown>> {
  /**
   * Credential reference type.
   */
  type: CredentialReferenceType;

  /**
   * Reference credential name.
   */
  referenceName: string;
}

/**
 * Credential resource type.
 */
model CredentialResource extends SubResource {
  /**
   * Properties of credentials.
   */
  properties: Credential;
}

/**
 * Mapping data flow.
 */
model MappingDataFlow extends DataFlow {
  /**
   * Mapping data flow type properties.
   */
  typeProperties?: MappingDataFlowTypeProperties;

  /**
   * Type of data flow.
   */
  type: "MappingDataFlow";
}

/**
 * Mapping data flow type properties.
 */
model MappingDataFlowTypeProperties {
  /**
   * List of sources in data flow.
   */
  sources?: DataFlowSource[];

  /**
   * List of sinks in data flow.
   */
  sinks?: DataFlowSink[];

  /**
   * List of transformations in data flow.
   */
  transformations?: Transformation[];

  /**
   * DataFlow script.
   */
  script?: string;

  /**
   * Data flow script lines.
   */
  scriptLines?: string[];
}

/**
 * Transformation for data flow source.
 */
model DataFlowSource extends Transformation {
  /**
   * Schema linked service reference.
   */
  schemaLinkedService?: LinkedServiceReference;
}

/**
 * A data flow transformation.
 */
model Transformation {
  /**
   * Transformation name.
   */
  name: string;

  /**
   * Transformation description.
   */
  description?: string;

  /**
   * Dataset reference.
   */
  dataset?: DatasetReference;

  /**
   * Linked service reference.
   */
  linkedService?: LinkedServiceReference;

  /**
   * Flowlet Reference
   */
  flowlet?: DataFlowReference;
}

/**
 * Transformation for data flow sink.
 */
model DataFlowSink extends Transformation {
  /**
   * Schema linked service reference.
   */
  schemaLinkedService?: LinkedServiceReference;

  /**
   * Rejected data linked service reference.
   */
  rejectedDataLinkedService?: LinkedServiceReference;
}

/**
 * Data flow flowlet
 */
model Flowlet extends DataFlow {
  /**
   * Flowlet type properties.
   */
  typeProperties?: FlowletTypeProperties;

  /**
   * Type of data flow.
   */
  type: "Flowlet";
}

/**
 * Flowlet type properties.
 */
model FlowletTypeProperties {
  /**
   * List of sources in Flowlet.
   */
  sources?: DataFlowSource[];

  /**
   * List of sinks in Flowlet.
   */
  sinks?: DataFlowSink[];

  /**
   * List of transformations in Flowlet.
   */
  transformations?: Transformation[];

  /**
   * Flowlet script.
   */
  script?: string;

  /**
   * Flowlet script lines.
   */
  scriptLines?: string[];
}

/**
 * Power Query data flow.
 */
model WranglingDataFlow extends DataFlow {
  /**
   * PowerQuery data flow type properties.
   */
  typeProperties?: PowerQueryTypeProperties;

  /**
   * Type of data flow.
   */
  type: "WranglingDataFlow";
}

/**
 * Power Query data flow type properties.
 */
model PowerQueryTypeProperties {
  /**
   * List of sources in Power Query.
   */
  sources?: PowerQuerySource[];

  /**
   * Power query mashup script.
   */
  script?: string;

  /**
   * Locale of the Power query mashup document.
   */
  documentLocale?: string;
}

/**
 * Power query source.
 */
model PowerQuerySource extends DataFlowSource {
  /**
   * source script.
   */
  script?: string;
}

/**
 * Power query sink.
 */
model PowerQuerySink extends DataFlowSink {
  /**
   * sink script.
   */
  script?: string;
}

/**
 * Dataset location.
 */
@discriminator("type")
model DatasetLocation extends Record<Record<unknown>> {
  /**
   * Specify the folder path of dataset. Type: string (or Expression with resultType string)
   */
  folderPath?: Record<unknown>;

  /**
   * Specify the file name of dataset. Type: string (or Expression with resultType string).
   */
  fileName?: Record<unknown>;
}

/**
 * The location of azure blob dataset.
 */
model AzureBlobStorageLocation extends DatasetLocation {
  /**
   * Specify the container of azure blob. Type: string (or Expression with resultType string).
   */
  container?: Record<unknown>;

  /**
   * Type of dataset storage location.
   */
  type: "AzureBlobStorageLocation";
}

/**
 * The location of azure blobFS dataset.
 */
model AzureBlobFSLocation extends DatasetLocation {
  /**
   * Specify the fileSystem of azure blobFS. Type: string (or Expression with resultType string).
   */
  fileSystem?: Record<unknown>;

  /**
   * Type of dataset storage location.
   */
  type: "AzureBlobFSLocation";
}

/**
 * The location of azure data lake store dataset.
 */
model AzureDataLakeStoreLocation extends DatasetLocation {
  /**
   * Type of dataset storage location.
   */
  type: "AzureDataLakeStoreLocation";
}

/**
 * The location of amazon S3 dataset.
 */
model AmazonS3Location extends DatasetLocation {
  /**
   * Specify the bucketName of amazon S3. Type: string (or Expression with resultType string)
   */
  bucketName?: Record<unknown>;

  /**
   * Specify the version of amazon S3. Type: string (or Expression with resultType string).
   */
  version?: Record<unknown>;

  /**
   * Type of dataset storage location.
   */
  type: "AmazonS3Location";
}

/**
 * The location of file server dataset.
 */
model FileServerLocation extends DatasetLocation {
  /**
   * Type of dataset storage location.
   */
  type: "FileServerLocation";
}

/**
 * The location of file server dataset.
 */
model AzureFileStorageLocation extends DatasetLocation {
  /**
   * Type of dataset storage location.
   */
  type: "AzureFileStorageLocation";
}

/**
 * The location of Amazon S3 Compatible dataset.
 */
model AmazonS3CompatibleLocation extends DatasetLocation {
  /**
   * Specify the bucketName of Amazon S3 Compatible. Type: string (or Expression with resultType string)
   */
  bucketName?: Record<unknown>;

  /**
   * Specify the version of Amazon S3 Compatible. Type: string (or Expression with resultType string).
   */
  version?: Record<unknown>;

  /**
   * Type of dataset storage location.
   */
  type: "AmazonS3CompatibleLocation";
}

/**
 * The location of Oracle Cloud Storage dataset.
 */
model OracleCloudStorageLocation extends DatasetLocation {
  /**
   * Specify the bucketName of Oracle Cloud Storage. Type: string (or Expression with resultType string)
   */
  bucketName?: Record<unknown>;

  /**
   * Specify the version of Oracle Cloud Storage. Type: string (or Expression with resultType string).
   */
  version?: Record<unknown>;

  /**
   * Type of dataset storage location.
   */
  type: "OracleCloudStorageLocation";
}

/**
 * The location of Google Cloud Storage dataset.
 */
model GoogleCloudStorageLocation extends DatasetLocation {
  /**
   * Specify the bucketName of Google Cloud Storage. Type: string (or Expression with resultType string)
   */
  bucketName?: Record<unknown>;

  /**
   * Specify the version of Google Cloud Storage. Type: string (or Expression with resultType string).
   */
  version?: Record<unknown>;

  /**
   * Type of dataset storage location.
   */
  type: "GoogleCloudStorageLocation";
}

/**
 * The location of ftp server dataset.
 */
model FtpServerLocation extends DatasetLocation {
  /**
   * Type of dataset storage location.
   */
  type: "FtpServerLocation";
}

/**
 * The location of SFTP dataset.
 */
model SftpLocation extends DatasetLocation {
  /**
   * Type of dataset storage location.
   */
  type: "SftpLocation";
}

/**
 * The location of http server.
 */
model HttpServerLocation extends DatasetLocation {
  /**
   * Specify the relativeUrl of http server. Type: string (or Expression with resultType string)
   */
  relativeUrl?: Record<unknown>;

  /**
   * Type of dataset storage location.
   */
  type: "HttpServerLocation";
}

/**
 * The location of HDFS.
 */
model HdfsLocation extends DatasetLocation {
  /**
   * Type of dataset storage location.
   */
  type: "HdfsLocation";
}

/**
 * The location of Microsoft Fabric LakeHouse Files dataset.
 */
model LakeHouseLocation extends DatasetLocation {
  /**
   * Type of dataset storage location.
   */
  type: "LakeHouseLocation";
}

/**
 * Columns that define the structure of the dataset.
 */
model DatasetDataElement {
  /**
   * Name of the column. Type: string (or Expression with resultType string).
   */
  name?: Record<unknown>;

  /**
   * Type of the column. Type: string (or Expression with resultType string).
   */
  type?: Record<unknown>;
}

/**
 * Columns that define the physical type schema of the dataset.
 */
model DatasetSchemaDataElement extends Record<Record<unknown>> {
  /**
   * Name of the schema column. Type: string (or Expression with resultType string).
   */
  name?: Record<unknown>;

  /**
   * Type of the schema column. Type: string (or Expression with resultType string).
   */
  type?: Record<unknown>;
}

/**
 * The format definition of a storage.
 */
@discriminator("type")
model DatasetStorageFormat extends Record<Record<unknown>> {
  /**
   * Serializer. Type: string (or Expression with resultType string).
   */
  serializer?: Record<unknown>;

  /**
   * Deserializer. Type: string (or Expression with resultType string).
   */
  deserializer?: Record<unknown>;
}

/**
 * The data stored in text format.
 */
model TextFormat extends DatasetStorageFormat {
  /**
   * The column delimiter. Type: string (or Expression with resultType string).
   */
  columnDelimiter?: Record<unknown>;

  /**
   * The row delimiter. Type: string (or Expression with resultType string).
   */
  rowDelimiter?: Record<unknown>;

  /**
   * The escape character. Type: string (or Expression with resultType string).
   */
  escapeChar?: Record<unknown>;

  /**
   * The quote character. Type: string (or Expression with resultType string).
   */
  quoteChar?: Record<unknown>;

  /**
   * The null value string. Type: string (or Expression with resultType string).
   */
  nullValue?: Record<unknown>;

  /**
   * The code page name of the preferred encoding. If miss, the default value is ΓÇ£utf-8ΓÇ¥, unless BOM denotes another Unicode encoding. Refer to the ΓÇ£NameΓÇ¥ column of the table in the following link to set supported values: https://msdn.microsoft.com/library/system.text.encoding.aspx. Type: string (or Expression with resultType string).
   */
  encodingName?: Record<unknown>;

  /**
   * Treat empty column values in the text file as null. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  treatEmptyAsNull?: Record<unknown>;

  /**
   * The number of lines/rows to be skipped when parsing text files. The default value is 0. Type: integer (or Expression with resultType integer).
   */
  skipLineCount?: Record<unknown>;

  /**
   * When used as input, treat the first row of data as headers. When used as output,write the headers into the output as the first row of data. The default value is false. Type: boolean (or Expression with resultType boolean).
   */
  firstRowAsHeader?: Record<unknown>;

  /**
   * Type of dataset storage format.
   */
  type: "TextFormat";
}

/**
 * The data stored in JSON format.
 */
model JsonFormat extends DatasetStorageFormat {
  /**
   * File pattern of JSON. To be more specific, the way of separating a collection of JSON objects. The default value is 'setOfObjects'. It is case-sensitive.
   */
  filePattern?: Record<unknown>;

  /**
   * The character used to separate nesting levels. Default value is '.' (dot). Type: string (or Expression with resultType string).
   */
  nestingSeparator?: Record<unknown>;

  /**
   * The code page name of the preferred encoding. If not provided, the default value is 'utf-8', unless the byte order mark (BOM) denotes another Unicode encoding. The full list of supported values can be found in the 'Name' column of the table of encodings in the following reference: https://go.microsoft.com/fwlink/?linkid=861078. Type: string (or Expression with resultType string).
   */
  encodingName?: Record<unknown>;

  /**
   * The JSONPath of the JSON array element to be flattened. Example: "$.ArrayPath". Type: string (or Expression with resultType string).
   */
  jsonNodeReference?: Record<unknown>;

  /**
   * The JSONPath definition for each column mapping with a customized column name to extract data from JSON file. For fields under root object, start with "$"; for fields inside the array chosen by jsonNodeReference property, start from the array element. Example: {"Column1": "$.Column1Path", "Column2": "Column2PathInArray"}. Type: object (or Expression with resultType object).
   */
  jsonPathDefinition?: Record<unknown>;

  /**
   * Type of dataset storage format.
   */
  type: "JsonFormat";
}

/**
 * The data stored in Avro format.
 */
model AvroFormat extends DatasetStorageFormat {
  /**
   * Type of dataset storage format.
   */
  type: "AvroFormat";
}

/**
 * The data stored in Optimized Row Columnar (ORC) format.
 */
model OrcFormat extends DatasetStorageFormat {
  /**
   * Type of dataset storage format.
   */
  type: "OrcFormat";
}

/**
 * The data stored in Parquet format.
 */
model ParquetFormat extends DatasetStorageFormat {
  /**
   * Type of dataset storage format.
   */
  type: "ParquetFormat";
}

/**
 * The compression method used on a dataset.
 */
model DatasetCompression extends Record<Record<unknown>> {
  /**
   * Type of dataset compression. Type: string (or Expression with resultType string).
   */
  type: Record<unknown>;

  /**
   * The dataset compression level. Type: string (or Expression with resultType string).
   */
  level?: Record<unknown>;
}

/**
 * A single Amazon Simple Storage Service (S3) object or a set of S3 objects.
 */
model AmazonS3Dataset extends Dataset {
  /**
   * Amazon S3 dataset properties.
   */
  typeProperties: AmazonS3DatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "AmazonS3Object";
}

/**
 * Amazon S3 dataset properties.
 */
model AmazonS3DatasetTypeProperties {
  /**
   * The name of the Amazon S3 bucket. Type: string (or Expression with resultType string).
   */
  bucketName: Record<unknown>;

  /**
   * The key of the Amazon S3 object. Type: string (or Expression with resultType string).
   */
  key?: Record<unknown>;

  /**
   * The prefix filter for the S3 object name. Type: string (or Expression with resultType string).
   */
  prefix?: Record<unknown>;

  /**
   * The version for the S3 object. Type: string (or Expression with resultType string).
   */
  version?: Record<unknown>;

  /**
   * The start of S3 object's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeStart?: Record<unknown>;

  /**
   * The end of S3 object's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeEnd?: Record<unknown>;

  /**
   * The format of files.
   */
  format?: DatasetStorageFormat;

  /**
   * The data compression method used for the Amazon S3 object.
   */
  compression?: DatasetCompression;
}

/**
 * Avro dataset.
 */
model AvroDataset extends Dataset {
  /**
   * Avro dataset properties.
   */
  typeProperties?: AvroDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "Avro";
}

/**
 * Avro dataset properties.
 */
model AvroDatasetTypeProperties {
  /**
   * The location of the avro storage.
   */
  location: DatasetLocation;

  /**
   * The data avroCompressionCodec. Type: string (or Expression with resultType string).
   */
  avroCompressionCodec?: Record<unknown>;

  @maxValue(9)
  @minValue(1)
  avroCompressionLevel?: int32;
}

/**
 * Excel dataset.
 */
model ExcelDataset extends Dataset {
  /**
   * Excel dataset properties.
   */
  typeProperties?: ExcelDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "Excel";
}

/**
 * Excel dataset properties.
 */
model ExcelDatasetTypeProperties {
  /**
   * The location of the excel storage.
   */
  location: DatasetLocation;

  /**
   * The sheet name of excel file. Type: string (or Expression with resultType string).
   */
  sheetName?: Record<unknown>;

  /**
   * The sheet index of excel file and default value is 0. Type: integer (or Expression with resultType integer)
   */
  sheetIndex?: Record<unknown>;

  /**
   * The partial data of one sheet. Type: string (or Expression with resultType string).
   */
  range?: Record<unknown>;

  /**
   * When used as input, treat the first row of data as headers. When used as output,write the headers into the output as the first row of data. The default value is false. Type: boolean (or Expression with resultType boolean).
   */
  firstRowAsHeader?: Record<unknown>;

  /**
   * The data compression method used for the json dataset.
   */
  compression?: DatasetCompression;

  /**
   * The null value string. Type: string (or Expression with resultType string).
   */
  nullValue?: Record<unknown>;
}

/**
 * Parquet dataset.
 */
model ParquetDataset extends Dataset {
  /**
   * Parquet dataset properties.
   */
  typeProperties?: ParquetDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "Parquet";
}

/**
 * Parquet dataset properties.
 */
model ParquetDatasetTypeProperties {
  /**
   * The location of the parquet storage.
   */
  location: DatasetLocation;

  /**
   * The data compressionCodec. Type: string (or Expression with resultType string).
   */
  compressionCodec?: Record<unknown>;
}

/**
 * Delimited text dataset.
 */
model DelimitedTextDataset extends Dataset {
  /**
   * Delimited text dataset properties.
   */
  typeProperties?: DelimitedTextDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "DelimitedText";
}

/**
 * DelimitedText dataset properties.
 */
model DelimitedTextDatasetTypeProperties {
  /**
   * The location of the delimited text storage.
   */
  location: DatasetLocation;

  /**
   * The column delimiter. Type: string (or Expression with resultType string).
   */
  columnDelimiter?: Record<unknown>;

  /**
   * The row delimiter. Type: string (or Expression with resultType string).
   */
  rowDelimiter?: Record<unknown>;

  /**
   * The code page name of the preferred encoding. If miss, the default value is UTF-8, unless BOM denotes another Unicode encoding. Refer to the name column of the table in the following link to set supported values: https://msdn.microsoft.com/library/system.text.encoding.aspx. Type: string (or Expression with resultType string).
   */
  encodingName?: Record<unknown>;

  /**
   * The data compressionCodec. Type: string (or Expression with resultType string).
   */
  compressionCodec?: Record<unknown>;

  /**
   * The data compression method used for DelimitedText.
   */
  compressionLevel?: Record<unknown>;

  /**
   * The quote character. Type: string (or Expression with resultType string).
   */
  quoteChar?: Record<unknown>;

  /**
   * The escape character. Type: string (or Expression with resultType string).
   */
  escapeChar?: Record<unknown>;

  /**
   * When used as input, treat the first row of data as headers. When used as output,write the headers into the output as the first row of data. The default value is false. Type: boolean (or Expression with resultType boolean).
   */
  firstRowAsHeader?: Record<unknown>;

  /**
   * The null value string. Type: string (or Expression with resultType string).
   */
  nullValue?: Record<unknown>;
}

/**
 * Json dataset.
 */
model JsonDataset extends Dataset {
  /**
   * Json dataset properties.
   */
  typeProperties?: JsonDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "Json";
}

/**
 * Json dataset properties.
 */
model JsonDatasetTypeProperties {
  /**
   * The location of the json data storage.
   */
  location: DatasetLocation;

  /**
   * The code page name of the preferred encoding. If not specified, the default value is UTF-8, unless BOM denotes another Unicode encoding. Refer to the name column of the table in the following link to set supported values: https://msdn.microsoft.com/library/system.text.encoding.aspx. Type: string (or Expression with resultType string).
   */
  encodingName?: Record<unknown>;

  /**
   * The data compression method used for the json dataset.
   */
  compression?: DatasetCompression;
}

/**
 * Xml dataset.
 */
model XmlDataset extends Dataset {
  /**
   * Xml dataset properties.
   */
  typeProperties?: XmlDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "Xml";
}

/**
 * Xml dataset properties.
 */
model XmlDatasetTypeProperties {
  /**
   * The location of the json data storage.
   */
  location: DatasetLocation;

  /**
   * The code page name of the preferred encoding. If not specified, the default value is UTF-8, unless BOM denotes another Unicode encoding. Refer to the name column of the table in the following link to set supported values: https://msdn.microsoft.com/library/system.text.encoding.aspx. Type: string (or Expression with resultType string).
   */
  encodingName?: Record<unknown>;

  /**
   * The null value string. Type: string (or Expression with resultType string).
   */
  nullValue?: Record<unknown>;

  /**
   * The data compression method used for the json dataset.
   */
  compression?: DatasetCompression;
}

/**
 * ORC dataset.
 */
model OrcDataset extends Dataset {
  /**
   * ORC dataset properties.
   */
  typeProperties?: OrcDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "Orc";
}

/**
 * ORC dataset properties.
 */
model OrcDatasetTypeProperties {
  /**
   * The location of the ORC data storage.
   */
  location: DatasetLocation;

  /**
   * The data orcCompressionCodec. Type: string (or Expression with resultType string).
   */
  orcCompressionCodec?: Record<unknown>;
}

/**
 * Binary dataset.
 */
model BinaryDataset extends Dataset {
  /**
   * Binary dataset properties.
   */
  typeProperties?: BinaryDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "Binary";
}

/**
 * Binary dataset properties.
 */
model BinaryDatasetTypeProperties {
  /**
   * The location of the Binary storage.
   */
  location: DatasetLocation;

  /**
   * The data compression method used for the binary dataset.
   */
  compression?: DatasetCompression;
}

/**
 * The Azure Blob storage.
 */
model AzureBlobDataset extends Dataset {
  /**
   * Azure Blob dataset properties.
   */
  typeProperties?: AzureBlobDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "AzureBlob";
}

/**
 * Azure Blob dataset properties.
 */
model AzureBlobDatasetTypeProperties {
  /**
   * The path of the Azure Blob storage. Type: string (or Expression with resultType string).
   */
  folderPath?: Record<unknown>;

  /**
   * The root of blob path. Type: string (or Expression with resultType string).
   */
  tableRootLocation?: Record<unknown>;

  /**
   * The name of the Azure Blob. Type: string (or Expression with resultType string).
   */
  fileName?: Record<unknown>;

  /**
   * The start of Azure Blob's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeStart?: Record<unknown>;

  /**
   * The end of Azure Blob's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeEnd?: Record<unknown>;

  /**
   * The format of the Azure Blob storage.
   */
  format?: DatasetStorageFormat;

  /**
   * The data compression method used for the blob storage.
   */
  compression?: DatasetCompression;
}

/**
 * The Azure Table storage dataset.
 */
model AzureTableDataset extends Dataset {
  /**
   * Azure Table dataset properties.
   */
  typeProperties: AzureTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "AzureTable";
}

/**
 * Azure Table dataset properties.
 */
model AzureTableDatasetTypeProperties {
  /**
   * The table name of the Azure Table storage. Type: string (or Expression with resultType string).
   */
  tableName: Record<unknown>;
}

/**
 * The Azure SQL Server database dataset.
 */
model AzureSqlTableDataset extends Dataset {
  /**
   * Azure SQL dataset properties.
   */
  typeProperties?: AzureSqlTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "AzureSqlTable";
}

/**
 * Azure SQL dataset properties.
 */
model AzureSqlTableDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  tableName?: Record<unknown>;

  /**
   * The schema name of the Azure SQL database. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;

  /**
   * The table name of the Azure SQL database. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;
}

/**
 * The Azure SQL Managed Instance dataset.
 */
model AzureSqlMITableDataset extends Dataset {
  /**
   * Azure SQL Managed Instance dataset properties.
   */
  typeProperties?: AzureSqlMITableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "AzureSqlMITable";
}

/**
 * Azure SQL Managed Instance dataset properties.
 */
model AzureSqlMITableDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  tableName?: Record<unknown>;

  /**
   * The schema name of the Azure SQL Managed Instance. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;

  /**
   * The table name of the Azure SQL Managed Instance dataset. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;
}

/**
 * The Azure SQL Data Warehouse dataset.
 */
model AzureSqlDWTableDataset extends Dataset {
  /**
   * Azure SQL Data Warehouse dataset properties.
   */
  typeProperties?: AzureSqlDWTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "AzureSqlDWTable";
}

/**
 * Azure SQL Data Warehouse dataset properties.
 */
model AzureSqlDWTableDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  tableName?: Record<unknown>;

  /**
   * The schema name of the Azure SQL Data Warehouse. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;

  /**
   * The table name of the Azure SQL Data Warehouse. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;
}

/**
 * The Cassandra database dataset.
 */
model CassandraTableDataset extends Dataset {
  /**
   * Cassandra dataset properties.
   */
  typeProperties?: CassandraTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "CassandraTable";
}

/**
 * Cassandra dataset properties.
 */
model CassandraTableDatasetTypeProperties {
  /**
   * The table name of the Cassandra database. Type: string (or Expression with resultType string).
   */
  tableName?: Record<unknown>;

  /**
   * The keyspace of the Cassandra database. Type: string (or Expression with resultType string).
   */
  keyspace?: Record<unknown>;
}

/**
 * The custom dataset.
 */
model CustomDataset extends Dataset {
  /**
   * Custom dataset properties.
   */
  typeProperties?: Record<unknown>;

  /**
   * Type of dataset.
   */
  type: "CustomDataset";
}

/**
 * Microsoft Azure CosmosDB (SQL API) Collection dataset.
 */
model CosmosDbSqlApiCollectionDataset extends Dataset {
  /**
   * CosmosDB (SQL API) Collection dataset properties.
   */
  typeProperties: CosmosDbSqlApiCollectionDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "CosmosDbSqlApiCollection";
}

/**
 * CosmosDB (SQL API) Collection dataset properties.
 */
model CosmosDbSqlApiCollectionDatasetTypeProperties {
  /**
   * CosmosDB (SQL API) collection name. Type: string (or Expression with resultType string).
   */
  collectionName: Record<unknown>;
}

/**
 * Microsoft Azure Document Database Collection dataset.
 */
model DocumentDbCollectionDataset extends Dataset {
  /**
   * DocumentDB Collection dataset properties.
   */
  typeProperties: DocumentDbCollectionDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "DocumentDbCollection";
}

/**
 * DocumentDB Collection dataset properties.
 */
model DocumentDbCollectionDatasetTypeProperties {
  /**
   * Document Database collection name. Type: string (or Expression with resultType string).
   */
  collectionName: Record<unknown>;
}

/**
 * The Dynamics entity dataset.
 */
model DynamicsEntityDataset extends Dataset {
  /**
   * Dynamics entity dataset properties.
   */
  typeProperties?: DynamicsEntityDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "DynamicsEntity";
}

/**
 * Dynamics entity dataset properties.
 */
model DynamicsEntityDatasetTypeProperties {
  /**
   * The logical name of the entity. Type: string (or Expression with resultType string).
   */
  entityName?: Record<unknown>;
}

/**
 * The Dynamics CRM entity dataset.
 */
model DynamicsCrmEntityDataset extends Dataset {
  /**
   * Dynamics CRM entity dataset properties.
   */
  typeProperties?: DynamicsCrmEntityDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "DynamicsCrmEntity";
}

/**
 * Dynamics CRM entity dataset properties.
 */
model DynamicsCrmEntityDatasetTypeProperties {
  /**
   * The logical name of the entity. Type: string (or Expression with resultType string).
   */
  entityName?: Record<unknown>;
}

/**
 * The Common Data Service for Apps entity dataset.
 */
model CommonDataServiceForAppsEntityDataset extends Dataset {
  /**
   * Common Data Service for Apps entity dataset properties.
   */
  typeProperties?: CommonDataServiceForAppsEntityDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "CommonDataServiceForAppsEntity";
}

/**
 * Common Data Service for Apps entity dataset properties.
 */
model CommonDataServiceForAppsEntityDatasetTypeProperties {
  /**
   * The logical name of the entity. Type: string (or Expression with resultType string).
   */
  entityName?: Record<unknown>;
}

/**
 * Azure Data Lake Store dataset.
 */
model AzureDataLakeStoreDataset extends Dataset {
  /**
   * Azure Data Lake Store dataset properties.
   */
  typeProperties?: AzureDataLakeStoreDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "AzureDataLakeStoreFile";
}

/**
 * Azure Data Lake Store dataset properties.
 */
model AzureDataLakeStoreDatasetTypeProperties {
  /**
   * Path to the folder in the Azure Data Lake Store. Type: string (or Expression with resultType string).
   */
  folderPath?: Record<unknown>;

  /**
   * The name of the file in the Azure Data Lake Store. Type: string (or Expression with resultType string).
   */
  fileName?: Record<unknown>;

  /**
   * The format of the Data Lake Store.
   */
  format?: DatasetStorageFormat;

  /**
   * The data compression method used for the item(s) in the Azure Data Lake Store.
   */
  compression?: DatasetCompression;
}

/**
 * The Azure Data Lake Storage Gen2 storage.
 */
model AzureBlobFSDataset extends Dataset {
  /**
   * Azure Data Lake Storage Gen2 dataset properties.
   */
  typeProperties?: AzureBlobFSDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "AzureBlobFSFile";
}

/**
 * Azure Data Lake Storage Gen2 dataset properties.
 */
model AzureBlobFSDatasetTypeProperties {
  /**
   * The path of the Azure Data Lake Storage Gen2 storage. Type: string (or Expression with resultType string).
   */
  folderPath?: Record<unknown>;

  /**
   * The name of the Azure Data Lake Storage Gen2. Type: string (or Expression with resultType string).
   */
  fileName?: Record<unknown>;

  /**
   * The format of the Azure Data Lake Storage Gen2 storage.
   */
  format?: DatasetStorageFormat;

  /**
   * The data compression method used for the blob storage.
   */
  compression?: DatasetCompression;
}

/**
 * The Office365 account.
 */
model Office365Dataset extends Dataset {
  /**
   * Office365 dataset properties.
   */
  typeProperties: Office365DatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "Office365Table";
}

/**
 * Office365 dataset properties.
 */
model Office365DatasetTypeProperties {
  /**
   * Name of the dataset to extract from Office 365. Type: string (or Expression with resultType string).
   */
  tableName: Record<unknown>;

  /**
   * A predicate expression that can be used to filter the specific rows to extract from Office 365. Type: string (or Expression with resultType string).
   */
  predicate?: Record<unknown>;
}

/**
 * An on-premises file system dataset.
 */
model FileShareDataset extends Dataset {
  /**
   * On-premises file system dataset properties.
   */
  typeProperties?: FileShareDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "FileShare";
}

/**
 * On-premises file system dataset properties.
 */
model FileShareDatasetTypeProperties {
  /**
   * The path of the on-premises file system. Type: string (or Expression with resultType string).
   */
  folderPath?: Record<unknown>;

  /**
   * The name of the on-premises file system. Type: string (or Expression with resultType string).
   */
  fileName?: Record<unknown>;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeStart?: Record<unknown>;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeEnd?: Record<unknown>;

  /**
   * The format of the files.
   */
  format?: DatasetStorageFormat;

  /**
   * Specify a filter to be used to select a subset of files in the folderPath rather than all files. Type: string (or Expression with resultType string).
   */
  fileFilter?: Record<unknown>;

  /**
   * The data compression method used for the file system.
   */
  compression?: DatasetCompression;
}

/**
 * The MongoDB database dataset.
 */
model MongoDbCollectionDataset extends Dataset {
  /**
   * MongoDB database dataset properties.
   */
  typeProperties: MongoDbCollectionDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "MongoDbCollection";
}

/**
 * MongoDB database dataset properties.
 */
model MongoDbCollectionDatasetTypeProperties {
  /**
   * The table name of the MongoDB database. Type: string (or Expression with resultType string).
   */
  collectionName: Record<unknown>;
}

/**
 * The MongoDB Atlas database dataset.
 */
model MongoDbAtlasCollectionDataset extends Dataset {
  /**
   * MongoDB Atlas database dataset properties.
   */
  typeProperties: MongoDbAtlasCollectionDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "MongoDbAtlasCollection";
}

/**
 * MongoDB Atlas database dataset properties.
 */
model MongoDbAtlasCollectionDatasetTypeProperties {
  /**
   * The collection name of the MongoDB Atlas database. Type: string (or Expression with resultType string).
   */
  collection: Record<unknown>;
}

/**
 * The MongoDB database dataset.
 */
model MongoDbV2CollectionDataset extends Dataset {
  /**
   * MongoDB database dataset properties.
   */
  typeProperties: MongoDbV2CollectionDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "MongoDbV2Collection";
}

/**
 * MongoDB database dataset properties.
 */
model MongoDbV2CollectionDatasetTypeProperties {
  /**
   * The collection name of the MongoDB database. Type: string (or Expression with resultType string).
   */
  collection: Record<unknown>;
}

/**
 * The CosmosDB (MongoDB API) database dataset.
 */
model CosmosDbMongoDbApiCollectionDataset extends Dataset {
  /**
   * CosmosDB (MongoDB API) database dataset properties.
   */
  typeProperties: CosmosDbMongoDbApiCollectionDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "CosmosDbMongoDbApiCollection";
}

/**
 * CosmosDB (MongoDB API) database dataset properties.
 */
model CosmosDbMongoDbApiCollectionDatasetTypeProperties {
  /**
   * The collection name of the CosmosDB (MongoDB API) database. Type: string (or Expression with resultType string).
   */
  collection: Record<unknown>;
}

/**
 * The Open Data Protocol (OData) resource dataset.
 */
model ODataResourceDataset extends Dataset {
  /**
   * OData dataset properties.
   */
  typeProperties?: ODataResourceDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "ODataResource";
}

/**
 * OData dataset properties.
 */
model ODataResourceDatasetTypeProperties {
  /**
   * The OData resource path. Type: string (or Expression with resultType string).
   */
  path?: Record<unknown>;
}

/**
 * The on-premises Oracle database dataset.
 */
model OracleTableDataset extends Dataset {
  /**
   * On-premises Oracle dataset properties.
   */
  typeProperties?: OracleTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "OracleTable";
}

/**
 * On-premises Oracle dataset properties.
 */
model OracleTableDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  tableName?: Record<unknown>;

  /**
   * The schema name of the on-premises Oracle database. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;

  /**
   * The table name of the on-premises Oracle database. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;
}

/**
 * The AmazonRdsForOracle database dataset.
 */
model AmazonRdsForOracleTableDataset extends Dataset {
  /**
   * AmazonRdsForOracle dataset properties.
   */
  typeProperties?: AmazonRdsForOracleTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "AmazonRdsForOracleTable";
}

/**
 * AmazonRdsForOracle dataset properties.
 */
model AmazonRdsForOracleTableDatasetTypeProperties {
  /**
   * The schema name of the AmazonRdsForOracle database. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;

  /**
   * The table name of the AmazonRdsForOracle database. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;
}

/**
 * The Teradata database dataset.
 */
model TeradataTableDataset extends Dataset {
  /**
   * Teradata dataset properties.
   */
  typeProperties?: TeradataTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "TeradataTable";
}

/**
 * Teradata dataset properties.
 */
model TeradataTableDatasetTypeProperties {
  /**
   * The database name of Teradata. Type: string (or Expression with resultType string).
   */
  database?: Record<unknown>;

  /**
   * The table name of Teradata. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;
}

/**
 * The Azure MySQL database dataset.
 */
model AzureMySqlTableDataset extends Dataset {
  /**
   * Azure MySQL database dataset properties.
   */
  typeProperties: AzureMySqlTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "AzureMySqlTable";
}

/**
 * Azure MySQL database dataset properties.
 */
model AzureMySqlTableDatasetTypeProperties {
  /**
   * The Azure MySQL database table name. Type: string (or Expression with resultType string).
   */
  tableName?: Record<unknown>;

  /**
   * The name of Azure MySQL database table. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;
}

/**
 * The Amazon Redshift table dataset.
 */
model AmazonRedshiftTableDataset extends Dataset {
  /**
   * Amazon Redshift table dataset properties.
   */
  typeProperties?: AmazonRedshiftTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "AmazonRedshiftTable";
}

/**
 * Amazon Redshift table dataset properties.
 */
model AmazonRedshiftTableDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  tableName?: Record<unknown>;

  /**
   * The Amazon Redshift table name. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;

  /**
   * The Amazon Redshift schema name. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;
}

/**
 * The Db2 table dataset.
 */
model Db2TableDataset extends Dataset {
  /**
   * Db2 table dataset properties.
   */
  typeProperties?: Db2TableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "Db2Table";
}

/**
 * Db2 table dataset properties.
 */
model Db2TableDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  tableName?: Record<unknown>;

  /**
   * The Db2 schema name. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;

  /**
   * The Db2 table name. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;
}

/**
 * The relational table dataset.
 */
model RelationalTableDataset extends Dataset {
  /**
   * Relational table dataset properties.
   */
  typeProperties?: RelationalTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "RelationalTable";
}

/**
 * Relational table dataset properties.
 */
model RelationalTableDatasetTypeProperties {
  /**
   * The relational table name. Type: string (or Expression with resultType string).
   */
  tableName?: Record<unknown>;
}

/**
 * The Informix table dataset.
 */
model InformixTableDataset extends Dataset {
  /**
   * Informix table dataset properties.
   */
  typeProperties?: InformixTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "InformixTable";
}

/**
 * Informix table dataset properties.
 */
model InformixTableDatasetTypeProperties {
  /**
   * The Informix table name. Type: string (or Expression with resultType string).
   */
  tableName?: Record<unknown>;
}

/**
 * The ODBC table dataset.
 */
model OdbcTableDataset extends Dataset {
  /**
   * ODBC table dataset properties.
   */
  typeProperties?: OdbcTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "OdbcTable";
}

/**
 * ODBC table dataset properties.
 */
model OdbcTableDatasetTypeProperties {
  /**
   * The ODBC table name. Type: string (or Expression with resultType string).
   */
  tableName?: Record<unknown>;
}

/**
 * The MySQL table dataset.
 */
model MySqlTableDataset extends Dataset {
  /**
   * MySQL table dataset properties.
   */
  typeProperties?: MySqlTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "MySqlTable";
}

/**
 * MySql table dataset properties.
 */
model MySqlTableDatasetTypeProperties {
  /**
   * The MySQL table name. Type: string (or Expression with resultType string).
   */
  tableName?: Record<unknown>;
}

/**
 * The PostgreSQL table dataset.
 */
model PostgreSqlTableDataset extends Dataset {
  /**
   * PostgreSQL table dataset properties.
   */
  typeProperties?: PostgreSqlTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "PostgreSqlTable";
}

/**
 * PostgreSQL table dataset properties.
 */
model PostgreSqlTableDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  tableName?: Record<unknown>;

  /**
   * The PostgreSQL table name. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;

  /**
   * The PostgreSQL schema name. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;
}

/**
 * The Microsoft Access table dataset.
 */
model MicrosoftAccessTableDataset extends Dataset {
  /**
   * Microsoft Access table dataset properties.
   */
  typeProperties?: MicrosoftAccessTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "MicrosoftAccessTable";
}

/**
 * Microsoft Access table dataset properties.
 */
model MicrosoftAccessTableDatasetTypeProperties {
  /**
   * The Microsoft Access table name. Type: string (or Expression with resultType string).
   */
  tableName?: Record<unknown>;
}

/**
 * The Salesforce object dataset.
 */
model SalesforceObjectDataset extends Dataset {
  /**
   * Salesforce object dataset properties.
   */
  typeProperties?: SalesforceObjectDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "SalesforceObject";
}

/**
 * Salesforce object dataset properties.
 */
model SalesforceObjectDatasetTypeProperties {
  /**
   * The Salesforce object API name. Type: string (or Expression with resultType string).
   */
  objectApiName?: Record<unknown>;
}

/**
 * The Salesforce Service Cloud object dataset.
 */
model SalesforceServiceCloudObjectDataset extends Dataset {
  /**
   * Salesforce Service Cloud object dataset properties.
   */
  typeProperties?: SalesforceServiceCloudObjectDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "SalesforceServiceCloudObject";
}

/**
 * Salesforce Service Cloud object dataset properties.
 */
model SalesforceServiceCloudObjectDatasetTypeProperties {
  /**
   * The Salesforce Service Cloud object API name. Type: string (or Expression with resultType string).
   */
  objectApiName?: Record<unknown>;
}

/**
 * The Sybase table dataset.
 */
model SybaseTableDataset extends Dataset {
  /**
   * Sybase table dataset properties.
   */
  typeProperties?: SybaseTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "SybaseTable";
}

/**
 * Sybase table dataset properties.
 */
model SybaseTableDatasetTypeProperties {
  /**
   * The Sybase table name. Type: string (or Expression with resultType string).
   */
  tableName?: Record<unknown>;
}

/**
 * The SAP BW cube dataset.
 */
model SapBwCubeDataset extends Dataset {
  /**
   * Type of dataset.
   */
  type: "SapBwCube";
}

/**
 * The path of the SAP Cloud for Customer OData entity.
 */
model SapCloudForCustomerResourceDataset extends Dataset {
  /**
   * SAP Cloud For Customer OData resource dataset properties.
   */
  typeProperties: SapCloudForCustomerResourceDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "SapCloudForCustomerResource";
}

/**
 * Sap Cloud For Customer OData resource dataset properties.
 */
model SapCloudForCustomerResourceDatasetTypeProperties {
  /**
   * The path of the SAP Cloud for Customer OData entity. Type: string (or Expression with resultType string).
   */
  path: Record<unknown>;
}

/**
 * The path of the SAP ECC OData entity.
 */
model SapEccResourceDataset extends Dataset {
  /**
   * SAP ECC OData resource dataset properties.
   */
  typeProperties: SapEccResourceDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "SapEccResource";
}

/**
 * Sap ECC OData resource dataset properties.
 */
model SapEccResourceDatasetTypeProperties {
  /**
   * The path of the SAP ECC OData entity. Type: string (or Expression with resultType string).
   */
  path: Record<unknown>;
}

/**
 * SAP HANA Table properties.
 */
model SapHanaTableDataset extends Dataset {
  /**
   * SAP HANA Table properties.
   */
  typeProperties?: SapHanaTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "SapHanaTable";
}

/**
 * SAP HANA Table properties.
 */
model SapHanaTableDatasetTypeProperties {
  /**
   * The schema name of SAP HANA. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;

  /**
   * The table name of SAP HANA. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;
}

/**
 * Sap Business Warehouse Open Hub Destination Table properties.
 */
model SapOpenHubTableDataset extends Dataset {
  /**
   * Sap Business Warehouse Open Hub Destination Table properties.
   */
  typeProperties: SapOpenHubTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "SapOpenHubTable";
}

/**
 * Sap Business Warehouse Open Hub Destination Table properties.
 */
model SapOpenHubTableDatasetTypeProperties {
  /**
   * The name of the Open Hub Destination with destination type as Database Table. Type: string (or Expression with resultType string).
   */
  openHubDestinationName: Record<unknown>;

  /**
   * Whether to exclude the records of the last request. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  excludeLastRequest?: Record<unknown>;

  /**
   * The ID of request for delta loading. Once it is set, only data with requestId larger than the value of this property will be retrieved. The default value is 0. Type: integer (or Expression with resultType integer ).
   */
  baseRequestId?: Record<unknown>;
}

/**
 * The on-premises SQL Server dataset.
 */
model SqlServerTableDataset extends Dataset {
  /**
   * On-premises SQL Server dataset properties.
   */
  typeProperties?: SqlServerTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "SqlServerTable";
}

/**
 * On-premises SQL Server dataset properties.
 */
model SqlServerTableDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  tableName?: Record<unknown>;

  /**
   * The schema name of the SQL Server dataset. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;

  /**
   * The table name of the SQL Server dataset. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;
}

/**
 * The Amazon RDS for SQL Server dataset.
 */
model AmazonRdsForSqlServerTableDataset extends Dataset {
  /**
   * The Amazon RDS for SQL Server dataset properties.
   */
  typeProperties?: AmazonRdsForSqlServerTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "AmazonRdsForSqlServerTable";
}

/**
 * The Amazon RDS for SQL Server dataset properties.
 */
model AmazonRdsForSqlServerTableDatasetTypeProperties {
  /**
   * The schema name of the SQL Server dataset. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;

  /**
   * The table name of the SQL Server dataset. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;
}

/**
 * A Rest service dataset.
 */
model RestResourceDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: RestResourceDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "RestResource";
}

/**
 * Properties specific to this dataset type.
 */
model RestResourceDatasetTypeProperties {
  /**
   * The relative URL to the resource that the RESTful API provides. Type: string (or Expression with resultType string).
   */
  relativeUrl?: Record<unknown>;

  /**
   * The HTTP method used to call the RESTful API. The default is GET. Type: string (or Expression with resultType string).
   */
  requestMethod?: Record<unknown>;

  /**
   * The HTTP request body to the RESTful API if requestMethod is POST. Type: string (or Expression with resultType string).
   */
  requestBody?: Record<unknown>;

  /**
   * The additional HTTP headers in the request to the RESTful API.
   */
  additionalHeaders?: Record<Record<unknown>>;

  /**
   * The pagination rules to compose next page requests.
   */
  paginationRules?: Record<Record<unknown>>;
}

/**
 * SAP Table Resource properties.
 */
model SapTableResourceDataset extends Dataset {
  /**
   * SAP Table Resource properties.
   */
  typeProperties: SapTableResourceDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "SapTableResource";
}

/**
 * SAP Table Resource properties.
 */
model SapTableResourceDatasetTypeProperties {
  /**
   * The name of the SAP Table. Type: string (or Expression with resultType string).
   */
  tableName: Record<unknown>;
}

/**
 * SAP ODP Resource properties.
 */
model SapOdpResourceDataset extends Dataset {
  /**
   * SAP ODP Resource properties.
   */
  typeProperties: SapOdpResourceDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "SapOdpResource";
}

/**
 * SAP ODP Resource properties.
 */
model SapOdpResourceDatasetTypeProperties {
  /**
   * The context of the SAP ODP Object. Type: string (or Expression with resultType string).
   */
  context: Record<unknown>;

  /**
   * The name of the SAP ODP Object. Type: string (or Expression with resultType string).
   */
  objectName: Record<unknown>;
}

/**
 * The dataset points to a HTML table in the web page.
 */
model WebTableDataset extends Dataset {
  /**
   * Web table dataset properties.
   */
  typeProperties: WebTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "WebTable";
}

/**
 * Web table dataset properties.
 */
model WebTableDatasetTypeProperties {
  /**
   * The zero-based index of the table in the web page. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  index: Record<unknown>;

  /**
   * The relative URL to the web page from the linked service URL. Type: string (or Expression with resultType string).
   */
  path?: Record<unknown>;
}

/**
 * The Azure Search Index.
 */
model AzureSearchIndexDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties: AzureSearchIndexDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "AzureSearchIndex";
}

/**
 * Properties specific to this dataset type.
 */
model AzureSearchIndexDatasetTypeProperties {
  /**
   * The name of the Azure Search Index. Type: string (or Expression with resultType string).
   */
  indexName: Record<unknown>;
}

/**
 * A file in an HTTP web server.
 */
model HttpDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: HttpDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "HttpFile";
}

/**
 * Properties specific to this dataset type.
 */
model HttpDatasetTypeProperties {
  /**
   * The relative URL based on the URL in the HttpLinkedService refers to an HTTP file Type: string (or Expression with resultType string).
   */
  relativeUrl?: Record<unknown>;

  /**
   * The HTTP method for the HTTP request. Type: string (or Expression with resultType string).
   */
  requestMethod?: Record<unknown>;

  /**
   * The body for the HTTP request. Type: string (or Expression with resultType string).
   */
  requestBody?: Record<unknown>;

  /**
* The headers for the HTTP Request. e.g. request-header-name-1:request-header-value-1
...
request-header-name-n:request-header-value-n Type: string (or Expression with resultType string).
*/
  additionalHeaders?: Record<unknown>;

  /**
   * The format of files.
   */
  format?: DatasetStorageFormat;

  /**
   * The data compression method used on files.
   */
  compression?: DatasetCompression;
}

/**
 * Properties specific to this dataset type.
 */
model GenericDatasetTypeProperties {
  /**
   * The table name. Type: string (or Expression with resultType string).
   */
  tableName?: Record<unknown>;
}

/**
 * Amazon Marketplace Web Service dataset.
 */
model AmazonMWSObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "AmazonMWSObject";
}

/**
 * Azure PostgreSQL dataset.
 */
model AzurePostgreSqlTableDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: AzurePostgreSqlTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "AzurePostgreSqlTable";
}

/**
 * Azure PostgreSQL dataset properties.
 */
model AzurePostgreSqlTableDatasetTypeProperties {
  /**
   * The table name of the Azure PostgreSQL database which includes both schema and table. Type: string (or Expression with resultType string).
   */
  tableName?: Record<unknown>;

  /**
   * The table name of the Azure PostgreSQL database. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;

  /**
   * The schema name of the Azure PostgreSQL database. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;
}

/**
 * Concur Service dataset.
 */
model ConcurObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "ConcurObject";
}

/**
 * Couchbase server dataset.
 */
model CouchbaseTableDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "CouchbaseTable";
}

/**
 * Drill server dataset.
 */
model DrillTableDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: DrillDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "DrillTable";
}

/**
 * Drill Dataset Properties
 */
model DrillDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  tableName?: Record<unknown>;

  /**
   * The table name of the Drill. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;

  /**
   * The schema name of the Drill. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;
}

/**
 * Eloqua server dataset.
 */
model EloquaObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "EloquaObject";
}

/**
 * Google BigQuery service dataset.
 */
model GoogleBigQueryObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GoogleBigQueryDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "GoogleBigQueryObject";
}

/**
 * Google BigQuery Dataset Properties
 */
model GoogleBigQueryDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using database + table properties instead.
   */
  tableName?: Record<unknown>;

  /**
   * The table name of the Google BigQuery. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;

  /**
   * The database name of the Google BigQuery. Type: string (or Expression with resultType string).
   */
  dataset?: Record<unknown>;
}

/**
 * Greenplum Database dataset.
 */
model GreenplumTableDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GreenplumDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "GreenplumTable";
}

/**
 * Greenplum Dataset Properties
 */
model GreenplumDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  tableName?: Record<unknown>;

  /**
   * The table name of Greenplum. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;

  /**
   * The schema name of Greenplum. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;
}

/**
 * HBase server dataset.
 */
model HBaseObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "HBaseObject";
}

/**
 * Hive Server dataset.
 */
model HiveObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: HiveDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "HiveObject";
}

/**
 * Hive Properties
 */
model HiveDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  tableName?: Record<unknown>;

  /**
   * The table name of the Hive. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;

  /**
   * The schema name of the Hive. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;
}

/**
 * Hubspot Service dataset.
 */
model HubspotObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "HubspotObject";
}

/**
 * Impala server dataset.
 */
model ImpalaObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: ImpalaDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "ImpalaObject";
}

/**
 * Impala Dataset Properties
 */
model ImpalaDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  tableName?: Record<unknown>;

  /**
   * The table name of the Impala. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;

  /**
   * The schema name of the Impala. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;
}

/**
 * Jira Service dataset.
 */
model JiraObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "JiraObject";
}

/**
 * Magento server dataset.
 */
model MagentoObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "MagentoObject";
}

/**
 * MariaDB server dataset.
 */
model MariaDBTableDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "MariaDBTable";
}

/**
 * Azure Database for MariaDB dataset.
 */
model AzureMariaDBTableDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "AzureMariaDBTable";
}

/**
 * Marketo server dataset.
 */
model MarketoObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "MarketoObject";
}

/**
 * Paypal Service dataset.
 */
model PaypalObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "PaypalObject";
}

/**
 * Phoenix server dataset.
 */
model PhoenixObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: PhoenixDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "PhoenixObject";
}

/**
 * Phoenix Dataset Properties
 */
model PhoenixDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  tableName?: Record<unknown>;

  /**
   * The table name of the Phoenix. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;

  /**
   * The schema name of the Phoenix. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;
}

/**
 * Presto server dataset.
 */
model PrestoObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: PrestoDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "PrestoObject";
}

/**
 * Presto Dataset Properties
 */
model PrestoDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  tableName?: Record<unknown>;

  /**
   * The table name of the Presto. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;

  /**
   * The schema name of the Presto. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;
}

/**
 * QuickBooks server dataset.
 */
model QuickBooksObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "QuickBooksObject";
}

/**
 * ServiceNow server dataset.
 */
model ServiceNowObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "ServiceNowObject";
}

/**
 * Shopify Service dataset.
 */
model ShopifyObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "ShopifyObject";
}

/**
 * Spark Server dataset.
 */
model SparkObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: SparkDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "SparkObject";
}

/**
 * Spark Properties
 */
model SparkDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  tableName?: Record<unknown>;

  /**
   * The table name of the Spark. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;

  /**
   * The schema name of the Spark. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;
}

/**
 * Square Service dataset.
 */
model SquareObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "SquareObject";
}

/**
 * Xero Service dataset.
 */
model XeroObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "XeroObject";
}

/**
 * Zoho server dataset.
 */
model ZohoObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "ZohoObject";
}

/**
 * Netezza dataset.
 */
model NetezzaTableDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: NetezzaTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "NetezzaTable";
}

/**
 * Netezza dataset properties.
 */
model NetezzaTableDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  tableName?: Record<unknown>;

  /**
   * The table name of the Netezza. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;

  /**
   * The schema name of the Netezza. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;
}

/**
 * Vertica dataset.
 */
model VerticaTableDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: VerticaDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "VerticaTable";
}

/**
 * Vertica Properties
 */
model VerticaDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  tableName?: Record<unknown>;

  /**
   * The table name of the Vertica. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;

  /**
   * The schema name of the Vertica. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;
}

/**
 * Salesforce Marketing Cloud dataset.
 */
model SalesforceMarketingCloudObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "SalesforceMarketingCloudObject";
}

/**
 * Responsys dataset.
 */
model ResponsysObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "ResponsysObject";
}

/**
 * The path of the Dynamics AX OData entity.
 */
model DynamicsAXResourceDataset extends Dataset {
  /**
   * Dynamics AX OData resource dataset properties.
   */
  typeProperties: DynamicsAXResourceDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "DynamicsAXResource";
}

/**
 * Dynamics AX OData resource dataset properties.
 */
model DynamicsAXResourceDatasetTypeProperties {
  /**
   * The path of the Dynamics AX OData entity. Type: string (or Expression with resultType string).
   */
  path: Record<unknown>;
}

/**
 * Oracle Service Cloud dataset.
 */
model OracleServiceCloudObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "OracleServiceCloudObject";
}

/**
 * The Azure Data Explorer (Kusto) dataset.
 */
model AzureDataExplorerTableDataset extends Dataset {
  /**
   * Azure Data Explorer (Kusto) dataset properties.
   */
  typeProperties: AzureDataExplorerDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "AzureDataExplorerTable";
}

/**
 * Azure Data Explorer (Kusto) dataset properties.
 */
model AzureDataExplorerDatasetTypeProperties {
  /**
   * The table name of the Azure Data Explorer database. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;
}

/**
 * Google AdWords service dataset.
 */
model GoogleAdWordsObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GenericDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "GoogleAdWordsObject";
}

/**
 * The snowflake dataset.
 */
model SnowflakeDataset extends Dataset {
  /**
   * Snowflake dataset properties.
   */
  typeProperties: SnowflakeDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "SnowflakeTable";
}

/**
 * Snowflake dataset properties.
 */
model SnowflakeDatasetTypeProperties {
  /**
   * The schema name of the Snowflake database. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;

  /**
   * The table name of the Snowflake database. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;
}

/**
 * The sharepoint online list resource dataset.
 */
model SharePointOnlineListResourceDataset extends Dataset {
  /**
   * Sharepoint online list dataset properties.
   */
  typeProperties?: SharePointOnlineListDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "SharePointOnlineListResource";
}

/**
 * Sharepoint online list dataset properties.
 */
model SharePointOnlineListDatasetTypeProperties {
  /**
   * The name of the SharePoint Online list. Type: string (or Expression with resultType string).
   */
  listName?: Record<unknown>;
}

/**
 * Azure Databricks Delta Lake dataset.
 */
model AzureDatabricksDeltaLakeDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: AzureDatabricksDeltaLakeDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "AzureDatabricksDeltaLakeDataset";
}

/**
 * Azure Databricks Delta Lake Dataset Properties
 */
model AzureDatabricksDeltaLakeDatasetTypeProperties {
  /**
   * The name of delta table. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;

  /**
   * The database name of delta table. Type: string (or Expression with resultType string).
   */
  database?: Record<unknown>;
}

/**
 * Microsoft Fabric LakeHouse Table.
 */
model LakeHouseTableDataset extends Dataset {
  /**
   * Microsoft Fabric LakeHouse Table dataset properties.
   */
  typeProperties?: LakeHouseTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "LakeHouseTable";
}

/**
 * Microsoft Fabric LakeHouse Table dataset properties.
 */
model LakeHouseTableDatasetTypeProperties {
  /**
   * The name of Microsoft Fabric LakeHouse Table. Type: string (or Expression with resultType string).
   */
  table?: Record<unknown>;
}

/**
 * Managed integration runtime, including managed elastic and managed dedicated integration runtimes.
 */
model ManagedIntegrationRuntime extends IntegrationRuntime {
  /**
   * Integration runtime state, only valid for managed dedicated integration runtime.
   */
  @visibility("read")
  state?: IntegrationRuntimeState;

  /**
   * Managed integration runtime properties.
   */
  typeProperties: ManagedIntegrationRuntimeTypeProperties;

  /**
   * Managed Virtual Network reference.
   */
  managedVirtualNetwork?: ManagedVirtualNetworkReference;

  /**
   * Type of integration runtime.
   */
  type: "Managed";
}

/**
 * Managed integration runtime type properties.
 */
model ManagedIntegrationRuntimeTypeProperties {
  /**
   * The compute resource for managed integration runtime.
   */
  computeProperties?: IntegrationRuntimeComputeProperties;

  /**
   * SSIS properties for managed integration runtime.
   */
  ssisProperties?: IntegrationRuntimeSsisProperties;

  /**
   * The name of virtual network to which Azure-SSIS integration runtime will join
   */
  customerVirtualNetwork?: IntegrationRuntimeCustomerVirtualNetwork;
}

/**
 * The compute resource properties for managed integration runtime.
 */
model IntegrationRuntimeComputeProperties extends Record<Record<unknown>> {
  /**
   * The location for managed integration runtime. The supported regions could be found on https://docs.microsoft.com/en-us/azure/data-factory/data-factory-data-movement-activities
   */
  location?: string;

  /**
   * The node size requirement to managed integration runtime.
   */
  nodeSize?: string;

  /**
   * The required number of nodes for managed integration runtime.
   */
  @minValue(1)
  numberOfNodes?: int32;

  /**
   * Maximum parallel executions count per node for managed integration runtime.
   */
  @minValue(1)
  maxParallelExecutionsPerNode?: int32;

  /**
   * Data flow properties for managed integration runtime.
   */
  dataFlowProperties?: IntegrationRuntimeDataFlowProperties;

  /**
   * VNet properties for managed integration runtime.
   */
  vNetProperties?: IntegrationRuntimeVNetProperties;

  /**
   * CopyComputeScale properties for managed integration runtime.
   */
  copyComputeScaleProperties?: CopyComputeScaleProperties;

  /**
   * PipelineExternalComputeScale properties for managed integration runtime.
   */
  pipelineExternalComputeScaleProperties?: PipelineExternalComputeScaleProperties;
}

/**
 * Data flow properties for managed integration runtime.
 */
model IntegrationRuntimeDataFlowProperties extends Record<Record<unknown>> {
  /**
   * Compute type of the cluster which will execute data flow job.
   */
  computeType?: DataFlowComputeType;

  /**
   * Core count of the cluster which will execute data flow job. Supported values are: 8, 16, 32, 48, 80, 144 and 272.
   */
  coreCount?: int32;

  /**
   * Time to live (in minutes) setting of the cluster which will execute data flow job.
   */
  timeToLive?: int32;

  /**
   * Cluster will not be recycled and it will be used in next data flow activity run until TTL (time to live) is reached if this is set as false. Default is true.
   */
  cleanup?: boolean;

  /**
   * Custom properties are used to tune the data flow runtime performance.
   */
  customProperties?: IntegrationRuntimeDataFlowPropertiesCustomPropertiesItem[];
}

model IntegrationRuntimeDataFlowPropertiesCustomPropertiesItem {
  /**
   * Name of custom property.
   */
  name?: string;

  /**
   * Value of custom property.
   */
  value?: string;
}

/**
 * VNet properties for managed integration runtime.
 */
model IntegrationRuntimeVNetProperties extends Record<Record<unknown>> {
  /**
   * The ID of the VNet that this integration runtime will join.
   */
  vNetId?: string;

  /**
   * The name of the subnet this integration runtime will join.
   */
  subnet?: string;

  /**
   * Resource IDs of the public IP addresses that this integration runtime will use.
   */
  publicIPs?: string[];

  /**
   * The ID of subnet, to which this Azure-SSIS integration runtime will be joined.
   */
  subnetId?: string;
}

/**
 * CopyComputeScale properties for managed integration runtime.
 */
model CopyComputeScaleProperties extends Record<Record<unknown>> {
  /**
   * DIU number setting reserved for copy activity execution. Supported values are multiples of 4 in range 4-256.
   */
  @minValue(4)
  dataIntegrationUnit?: int32;

  /**
   * Time to live (in minutes) setting of integration runtime which will execute copy activity.
   */
  @minValue(5)
  timeToLive?: int32;
}

/**
 * PipelineExternalComputeScale properties for managed integration runtime.
 */
model PipelineExternalComputeScaleProperties extends Record<Record<unknown>> {
  /**
   * Time to live (in minutes) setting of integration runtime which will execute pipeline and external activity.
   */
  @minValue(5)
  timeToLive?: int32;

  /**
   * Number of the pipeline nodes, which should be greater than 0 and less than 11.
   */
  @maxValue(10)
  @minValue(1)
  numberOfPipelineNodes?: int32;

  /**
   * Number of the the external nodes, which should be greater than 0 and less than 11.
   */
  @maxValue(10)
  @minValue(1)
  numberOfExternalNodes?: int32;
}

/**
 * SSIS properties for managed integration runtime.
 */
model IntegrationRuntimeSsisProperties extends Record<Record<unknown>> {
  /**
   * Catalog information for managed dedicated integration runtime.
   */
  catalogInfo?: IntegrationRuntimeSsisCatalogInfo;

  /**
   * License type for bringing your own license scenario.
   */
  licenseType?: IntegrationRuntimeLicenseType;

  /**
   * Custom setup script properties for a managed dedicated integration runtime.
   */
  customSetupScriptProperties?: IntegrationRuntimeCustomSetupScriptProperties;

  /**
   * Data proxy properties for a managed dedicated integration runtime.
   */
  dataProxyProperties?: IntegrationRuntimeDataProxyProperties;

  /**
   * The edition for the SSIS Integration Runtime
   */
  edition?: IntegrationRuntimeEdition;

  /**
   * Custom setup without script properties for a SSIS integration runtime.
   */
  expressCustomSetupProperties?: CustomSetupBase[];

  /**
   * Package stores for the SSIS Integration Runtime.
   */
  packageStores?: PackageStore[];

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * Catalog information for managed dedicated integration runtime.
 */
model IntegrationRuntimeSsisCatalogInfo extends Record<Record<unknown>> {
  /**
   * The catalog database server URL.
   */
  catalogServerEndpoint?: string;

  /**
   * The administrator user name of catalog database.
   */
  @maxLength(128)
  @minLength(1)
  catalogAdminUserName?: string;

  /**
   * The password of the administrator user account of the catalog database.
   */
  catalogAdminPassword?: SecureString;

  /**
   * The pricing tier for the catalog database. The valid values could be found in https://azure.microsoft.com/en-us/pricing/details/sql-database/
   */
  catalogPricingTier?: IntegrationRuntimeSsisCatalogPricingTier;

  /**
   * The dual standby pair name of Azure-SSIS Integration Runtimes to support SSISDB failover.
   */
  dualStandbyPairName?: string;
}

/**
 * Custom setup script properties for a managed dedicated integration runtime.
 */
model IntegrationRuntimeCustomSetupScriptProperties {
  /**
   * The URI of the Azure blob container that contains the custom setup script.
   */
  blobContainerUri?: string;

  /**
   * The SAS token of the Azure blob container.
   */
  sasToken?: SecureString;
}

/**
 * Data proxy properties for a managed dedicated integration runtime.
 */
model IntegrationRuntimeDataProxyProperties {
  /**
   * The self-hosted integration runtime reference.
   */
  connectVia?: EntityReference;

  /**
   * The staging linked service reference.
   */
  stagingLinkedService?: EntityReference;

  /**
   * The path to contain the staged data in the Blob storage.
   */
  path?: string;
}

/**
 * The entity reference.
 */
model EntityReference {
  /**
   * The type of this referenced entity.
   */
  type?: IntegrationRuntimeEntityReferenceType;

  /**
   * The name of this referenced entity.
   */
  referenceName?: string;
}

/**
 * The base definition of the custom setup.
 */
@discriminator("type")
model CustomSetupBase {}

/**
 * Package store for the SSIS integration runtime.
 */
model PackageStore {
  /**
   * The name of the package store
   */
  name: string;

  /**
   * The package store linked service reference.
   */
  packageStoreLinkedService: EntityReference;
}

/**
 * The definition and properties of virtual network to which Azure-SSIS integration runtime will join.
 */
model IntegrationRuntimeCustomerVirtualNetwork {
  /**
   * The ID of subnet to which Azure-SSIS integration runtime will join.
   */
  subnetId?: string;
}

/**
 * The custom setup of running cmdkey commands.
 */
model CmdkeySetup extends CustomSetupBase {
  /**
   * Cmdkey command custom setup type properties.
   */
  typeProperties: CmdkeySetupTypeProperties;

  /**
   * The type of custom setup.
   */
  type: "CmdkeySetup";
}

/**
 * Cmdkey command custom setup type properties.
 */
model CmdkeySetupTypeProperties {
  /**
   * The server name of data source access.
   */
  targetName: Record<unknown>;

  /**
   * The user name of data source access.
   */
  userName: Record<unknown>;

  /**
   * The password of data source access.
   */
  password: SecretBase;
}

/**
 * The custom setup of setting environment variable.
 */
model EnvironmentVariableSetup extends CustomSetupBase {
  /**
   * Add environment variable type properties.
   */
  typeProperties: EnvironmentVariableSetupTypeProperties;

  /**
   * The type of custom setup.
   */
  type: "EnvironmentVariableSetup";
}

/**
 * Environment variable custom setup type properties.
 */
model EnvironmentVariableSetupTypeProperties {
  /**
   * The name of the environment variable.
   */
  variableName: string;

  /**
   * The value of the environment variable.
   */
  variableValue: string;
}

/**
 * The custom setup of installing 3rd party components.
 */
model ComponentSetup extends CustomSetupBase {
  /**
   * Install 3rd party component type properties.
   */
  typeProperties: LicensedComponentSetupTypeProperties;

  /**
   * The type of custom setup.
   */
  type: "ComponentSetup";
}

/**
 * Installation of licensed component setup type properties.
 */
model LicensedComponentSetupTypeProperties {
  /**
   * The name of the 3rd party component.
   */
  componentName: string;

  /**
   * The license key to activate the component.
   */
  licenseKey?: SecretBase;
}

/**
 * The express custom setup of installing Azure PowerShell.
 */
model AzPowerShellSetup extends CustomSetupBase {
  /**
   * Install Azure PowerShell type properties.
   */
  typeProperties: AzPowerShellSetupTypeProperties;

  /**
   * The type of custom setup.
   */
  type: "AzPowerShellSetup";
}

/**
 * Installation of Azure PowerShell type properties.
 */
model AzPowerShellSetupTypeProperties {
  /**
   * The required version of Azure PowerShell to install.
   */
  version: string;
}

/**
 * Self-hosted integration runtime.
 */
model SelfHostedIntegrationRuntime extends IntegrationRuntime {
  /**
   * When this property is not null, means this is a linked integration runtime. The property is used to access original integration runtime.
   */
  typeProperties?: SelfHostedIntegrationRuntimeTypeProperties;

  /**
   * Type of integration runtime.
   */
  type: "SelfHosted";
}

/**
 * The self-hosted integration runtime properties.
 */
model SelfHostedIntegrationRuntimeTypeProperties {
  /**
   * The base definition of a linked integration runtime.
   */
  linkedInfo?: LinkedIntegrationRuntimeType;

  /**
   * An alternative option to ensure interactive authoring function when your self-hosted integration runtime is unable to establish a connection with Azure Relay.
   */
  selfContainedInteractiveAuthoringEnabled?: boolean;
}

/**
 * The base definition of a linked integration runtime.
 */
@discriminator("authorizationType")
model LinkedIntegrationRuntimeType {}

/**
 * The key authorization type integration runtime.
 */
model LinkedIntegrationRuntimeKeyAuthorization
  extends LinkedIntegrationRuntimeType {
  /**
   * The key used for authorization.
   */
  key: SecureString;

  /**
   * The authorization type for integration runtime sharing.
   */
  authorizationType: "Key";
}

/**
 * The role based access control (RBAC) authorization type integration runtime.
 */
model LinkedIntegrationRuntimeRbacAuthorization
  extends LinkedIntegrationRuntimeType {
  /**
   * The resource identifier of the integration runtime to be shared.
   */
  resourceId: string;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;

  /**
   * The authorization type for integration runtime sharing.
   */
  authorizationType: "RBAC";
}

/**
 * Managed integration runtime status.
 */
model ManagedIntegrationRuntimeStatus extends IntegrationRuntimeStatus {
  /**
   * Managed integration runtime status type properties.
   */
  typeProperties: ManagedIntegrationRuntimeStatusTypeProperties;

  /**
   * Type of integration runtime.
   */
  type: "Managed";
}

/**
 * Managed integration runtime status type properties.
 */
model ManagedIntegrationRuntimeStatusTypeProperties {
  /**
   * The time at which the integration runtime was created, in ISO8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  /**
   * The list of nodes for managed integration runtime.
   */
  @visibility("read")
  nodes?: ManagedIntegrationRuntimeNode[];

  /**
   * The errors that occurred on this integration runtime.
   */
  @visibility("read")
  otherErrors?: ManagedIntegrationRuntimeError[];

  /**
   * The last operation result that occurred on this integration runtime.
   */
  @visibility("read")
  lastOperation?: ManagedIntegrationRuntimeOperationResult;
}

/**
 * Properties of integration runtime node.
 */
model ManagedIntegrationRuntimeNode extends Record<Record<unknown>> {
  /**
   * The managed integration runtime node id.
   */
  @visibility("read")
  nodeId?: string;

  /**
   * The managed integration runtime node status.
   */
  @visibility("read")
  status?: ManagedIntegrationRuntimeNodeStatus;

  /**
   * The errors that occurred on this integration runtime node.
   */
  errors?: ManagedIntegrationRuntimeError[];
}

/**
 * Error definition for managed integration runtime.
 */
model ManagedIntegrationRuntimeError extends Record<Record<unknown>> {
  /**
   * The time when the error occurred.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  /**
   * Error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Managed integration runtime error parameters.
   */
  @visibility("read")
  parameters?: string[];

  /**
   * Error message.
   */
  @visibility("read")
  message?: string;
}

/**
 * Properties of managed integration runtime operation result.
 */
model ManagedIntegrationRuntimeOperationResult extends Record<Record<unknown>> {
  /**
   * The operation type. Could be start or stop.
   */
  @visibility("read")
  type?: string;

  /**
   * The start time of the operation.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The operation result.
   */
  @visibility("read")
  result?: string;

  /**
   * The error code.
   */
  @visibility("read")
  errorCode?: string;

  /**
   * Managed integration runtime error parameters.
   */
  @visibility("read")
  parameters?: string[];

  /**
   * The activity id for the operation request.
   */
  @visibility("read")
  activityId?: string;
}

/**
 * Self-hosted integration runtime status.
 */
model SelfHostedIntegrationRuntimeStatus extends IntegrationRuntimeStatus {
  /**
   * Self-hosted integration runtime status type properties.
   */
  typeProperties: SelfHostedIntegrationRuntimeStatusTypeProperties;

  /**
   * Type of integration runtime.
   */
  type: "SelfHosted";
}

/**
 * Self-hosted integration runtime status type properties.
 */
model SelfHostedIntegrationRuntimeStatusTypeProperties {
  /**
   * The time at which the integration runtime was created, in ISO8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  /**
   * The task queue id of the integration runtime.
   */
  @visibility("read")
  taskQueueId?: string;

  /**
   * It is used to set the encryption mode for node-node communication channel (when more than 2 self-hosted integration runtime nodes exist).
   */
  @visibility("read")
  internalChannelEncryption?: IntegrationRuntimeInternalChannelEncryptionMode;

  /**
   * Version of the integration runtime.
   */
  @visibility("read")
  version?: string;

  /**
   * The list of nodes for this integration runtime.
   */
  nodes?: SelfHostedIntegrationRuntimeNode[];

  /**
   * The date at which the integration runtime will be scheduled to update, in ISO8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledUpdateDate?: utcDateTime;

  /**
   * The time in the date scheduled by service to update the integration runtime, e.g., PT03H is 3 hours
   */
  @visibility("read")
  updateDelayOffset?: duration;

  /**
   * The local time zone offset in hours.
   */
  @visibility("read")
  localTimeZoneOffset?: duration;

  /**
   * Object with additional information about integration runtime capabilities.
   */
  @visibility("read")
  capabilities?: Record<string>;

  /**
   * The URLs for the services used in integration runtime backend service.
   */
  @visibility("read")
  serviceUrls?: string[];

  /**
   * Whether Self-hosted integration runtime auto update has been turned on.
   */
  @visibility("read")
  autoUpdate?: IntegrationRuntimeAutoUpdate;

  /**
   * Status of the integration runtime version.
   */
  @visibility("read")
  versionStatus?: string;

  /**
   * The list of linked integration runtimes that are created to share with this integration runtime.
   */
  links?: LinkedIntegrationRuntime[];

  /**
   * The version that the integration runtime is going to update to.
   */
  @visibility("read")
  pushedVersion?: string;

  /**
   * The latest version on download center.
   */
  @visibility("read")
  latestVersion?: string;

  /**
   * The estimated time when the self-hosted integration runtime will be updated.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  autoUpdateETA?: utcDateTime;

  /**
   * An alternative option to ensure interactive authoring function when your self-hosted integration runtime is unable to establish a connection with Azure Relay.
   */
  @visibility("read")
  selfContainedInteractiveAuthoringEnabled?: boolean;
}

/**
 * The linked integration runtime information.
 */
model LinkedIntegrationRuntime {
  /**
   * The name of the linked integration runtime.
   */
  @visibility("read")
  name?: string;

  /**
   * The subscription ID for which the linked integration runtime belong to.
   */
  @visibility("read")
  subscriptionId?: string;

  /**
   * The name of the data factory for which the linked integration runtime belong to.
   */
  @visibility("read")
  dataFactoryName?: string;

  /**
   * The location of the data factory for which the linked integration runtime belong to.
   */
  @visibility("read")
  dataFactoryLocation?: string;

  /**
   * The creating time of the linked integration runtime.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;
}

/**
 * Ssis folder.
 */
model SsisFolder extends SsisObjectMetadata {
  /**
   * Type of metadata.
   */
  type: "Folder";
}

/**
 * Ssis project.
 */
model SsisProject extends SsisObjectMetadata {
  /**
   * Folder id which contains project.
   */
  folderId?: int64;

  /**
   * Project version.
   */
  version?: int64;

  /**
   * Environment reference in project
   */
  environmentRefs?: SsisEnvironmentReference[];

  /**
   * Parameters in project
   */
  parameters?: SsisParameter[];

  /**
   * Type of metadata.
   */
  type: "Project";
}

/**
 * Ssis environment reference.
 */
model SsisEnvironmentReference {
  /**
   * Environment reference id.
   */
  id?: int64;

  /**
   * Environment folder name.
   */
  environmentFolderName?: string;

  /**
   * Environment name.
   */
  environmentName?: string;

  /**
   * Reference type
   */
  referenceType?: string;
}

/**
 * Ssis parameter.
 */
model SsisParameter {
  /**
   * Parameter id.
   */
  id?: int64;

  /**
   * Parameter name.
   */
  name?: string;

  /**
   * Parameter description.
   */
  description?: string;

  /**
   * Parameter type.
   */
  dataType?: string;

  /**
   * Whether parameter is required.
   */
  required?: boolean;

  /**
   * Whether parameter is sensitive.
   */
  sensitive?: boolean;

  /**
   * Design default value of parameter.
   */
  designDefaultValue?: string;

  /**
   * Default value of parameter.
   */
  defaultValue?: string;

  /**
   * Default sensitive value of parameter.
   */
  sensitiveDefaultValue?: string;

  /**
   * Parameter value type.
   */
  valueType?: string;

  /**
   * Parameter value set.
   */
  valueSet?: boolean;

  /**
   * Parameter reference variable.
   */
  variable?: string;
}

/**
 * Ssis Package.
 */
model SsisPackage extends SsisObjectMetadata {
  /**
   * Folder id which contains package.
   */
  folderId?: int64;

  /**
   * Project version which contains package.
   */
  projectVersion?: int64;

  /**
   * Project id which contains package.
   */
  projectId?: int64;

  /**
   * Parameters in package
   */
  parameters?: SsisParameter[];

  /**
   * Type of metadata.
   */
  type: "Package";
}

/**
 * Ssis environment.
 */
model SsisEnvironment extends SsisObjectMetadata {
  /**
   * Folder id which contains environment.
   */
  folderId?: int64;

  /**
   * Variable in environment
   */
  variables?: SsisVariable[];

  /**
   * Type of metadata.
   */
  type: "Environment";
}

/**
 * Ssis variable.
 */
model SsisVariable {
  /**
   * Variable id.
   */
  id?: int64;

  /**
   * Variable name.
   */
  name?: string;

  /**
   * Variable description.
   */
  description?: string;

  /**
   * Variable type.
   */
  dataType?: string;

  /**
   * Whether variable is sensitive.
   */
  sensitive?: boolean;

  /**
   * Variable value.
   */
  value?: string;

  /**
   * Variable sensitive value.
   */
  sensitiveValue?: string;
}

/**
 * The storage account linked service.
 */
model AzureStorageLinkedService extends LinkedService {
  /**
   * Azure Storage linked service properties.
   */
  typeProperties: AzureStorageLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureStorage";
}

/**
 * Azure Storage linked service properties.
 */
model AzureStorageLinkedServiceTypeProperties {
  /**
   * The connection string. It is mutually exclusive with sasUri property. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString?: Record<unknown>;

  /**
   * The Azure key vault secret reference of accountKey in connection string.
   */
  accountKey?: AzureKeyVaultSecretReference;

  /**
   * SAS URI of the Azure Storage resource. It is mutually exclusive with connectionString property. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  sasUri?: Record<unknown>;

  /**
   * The Azure key vault secret reference of sasToken in sas uri.
   */
  sasToken?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * The azure blob storage linked service.
 */
model AzureBlobStorageLinkedService extends LinkedService {
  /**
   * Azure Blob Storage linked service properties.
   */
  typeProperties: AzureBlobStorageLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureBlobStorage";
}

/**
 * Azure Blob Storage linked service properties.
 */
model AzureBlobStorageLinkedServiceTypeProperties {
  /**
   * The connection string. It is mutually exclusive with sasUri, serviceEndpoint property. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString?: Record<unknown>;

  /**
   * The Azure key vault secret reference of accountKey in connection string.
   */
  accountKey?: AzureKeyVaultSecretReference;

  /**
   * SAS URI of the Azure Blob Storage resource. It is mutually exclusive with connectionString, serviceEndpoint property. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  sasUri?: Record<unknown>;

  /**
   * The Azure key vault secret reference of sasToken in sas uri.
   */
  sasToken?: AzureKeyVaultSecretReference;

  /**
   * Blob service endpoint of the Azure Blob Storage resource. It is mutually exclusive with connectionString, sasUri property.
   */
  serviceEndpoint?: Record<unknown>;

  /**
   * The ID of the service principal used to authenticate against Azure SQL Data Warehouse. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The key of the service principal used to authenticate against Azure SQL Data Warehouse.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  tenant?: Record<unknown>;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  azureCloudType?: Record<unknown>;

  /**
   * Specify the kind of your storage account. Allowed values are: Storage (general purpose v1), StorageV2 (general purpose v2), BlobStorage, or BlockBlobStorage. Type: string (or Expression with resultType string).
   */
  accountKind?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;

  /**
   * The type used for authentication. Type: string.
   */
  authenticationType?: AzureStorageAuthenticationType;

  /**
   * Container uri of the Azure Blob Storage resource only support for anonymous access. Type: string (or Expression with resultType string).
   */
  containerUri?: Record<unknown>;
}

/**
 * The azure table storage linked service.
 */
model AzureTableStorageLinkedService extends LinkedService {
  /**
   * Azure Table Storage linked service properties.
   */
  typeProperties: AzureStorageLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureTableStorage";
}

/**
 * Azure SQL Data Warehouse linked service.
 */
model AzureSqlDWLinkedService extends LinkedService {
  /**
   * Azure SQL Data Warehouse linked service properties.
   */
  typeProperties: AzureSqlDWLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureSqlDW";
}

/**
 * Azure SQL Data Warehouse linked service properties.
 */
model AzureSqlDWLinkedServiceTypeProperties {
  /**
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString: Record<unknown>;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The ID of the service principal used to authenticate against Azure SQL Data Warehouse. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The key of the service principal used to authenticate against Azure SQL Data Warehouse.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  tenant?: Record<unknown>;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  azureCloudType?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * SQL Server linked service.
 */
model SqlServerLinkedService extends LinkedService {
  /**
   * SQL Server linked service properties.
   */
  typeProperties: SqlServerLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "SqlServer";
}

/**
 * SQL Server linked service properties.
 */
model SqlServerLinkedServiceTypeProperties {
  /**
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString: Record<unknown>;

  /**
   * The on-premises Windows authentication user name. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * The on-premises Windows authentication password.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * Sql always encrypted properties.
   */
  alwaysEncryptedSettings?: SqlAlwaysEncryptedProperties;
}

/**
 * Sql always encrypted properties.
 */
model SqlAlwaysEncryptedProperties {
  /**
   * Sql always encrypted AKV authentication type. Type: string.
   */
  alwaysEncryptedAkvAuthType: SqlAlwaysEncryptedAkvAuthType;

  /**
   * The client ID of the application in Azure Active Directory used for Azure Key Vault authentication. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The key of the service principal used to authenticate against Azure Key Vault.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * Amazon RDS for SQL Server linked service.
 */
model AmazonRdsForSqlServerLinkedService extends LinkedService {
  /**
   * Amazon RDS for SQL Server linked service properties.
   */
  typeProperties: AmazonRdsForSqlServerLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AmazonRdsForSqlServer";
}

/**
 * Amazon Rds for SQL Server linked service properties.
 */
model AmazonRdsForSqlServerLinkedServiceTypeProperties {
  /**
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString: Record<unknown>;

  /**
   * The on-premises Windows authentication user name. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * The on-premises Windows authentication password.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * Sql always encrypted properties.
   */
  alwaysEncryptedSettings?: SqlAlwaysEncryptedProperties;
}

/**
 * Microsoft Azure SQL Database linked service.
 */
model AzureSqlDatabaseLinkedService extends LinkedService {
  /**
   * Azure SQL Database linked service properties.
   */
  typeProperties: AzureSqlDatabaseLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureSqlDatabase";
}

/**
 * Azure SQL Database linked service properties.
 */
model AzureSqlDatabaseLinkedServiceTypeProperties {
  /**
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString: Record<unknown>;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The ID of the service principal used to authenticate against Azure SQL Database. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The key of the service principal used to authenticate against Azure SQL Database.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  tenant?: Record<unknown>;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  azureCloudType?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * Sql always encrypted properties.
   */
  alwaysEncryptedSettings?: SqlAlwaysEncryptedProperties;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * Azure SQL Managed Instance linked service.
 */
model AzureSqlMILinkedService extends LinkedService {
  /**
   * Azure SQL Managed Instance linked service properties.
   */
  typeProperties: AzureSqlMILinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureSqlMI";
}

/**
 * Azure SQL Managed Instance linked service properties.
 */
model AzureSqlMILinkedServiceTypeProperties {
  /**
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString: Record<unknown>;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The ID of the service principal used to authenticate against Azure SQL Managed Instance. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The key of the service principal used to authenticate against Azure SQL Managed Instance.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  tenant?: Record<unknown>;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  azureCloudType?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * Sql always encrypted properties.
   */
  alwaysEncryptedSettings?: SqlAlwaysEncryptedProperties;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * Azure Batch linked service.
 */
model AzureBatchLinkedService extends LinkedService {
  /**
   * Azure Batch linked service properties.
   */
  typeProperties: AzureBatchLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureBatch";
}

/**
 * Azure Batch linked service properties.
 */
model AzureBatchLinkedServiceTypeProperties {
  /**
   * The Azure Batch account name. Type: string (or Expression with resultType string).
   */
  accountName: Record<unknown>;

  /**
   * The Azure Batch account access key.
   */
  accessKey?: SecretBase;

  /**
   * The Azure Batch URI. Type: string (or Expression with resultType string).
   */
  batchUri: Record<unknown>;

  /**
   * The Azure Batch pool name. Type: string (or Expression with resultType string).
   */
  poolName: Record<unknown>;

  /**
   * The Azure Storage linked service reference.
   */
  linkedServiceName: LinkedServiceReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * Azure Key Vault linked service.
 */
model AzureKeyVaultLinkedService extends LinkedService {
  /**
   * Azure Key Vault linked service properties.
   */
  typeProperties: AzureKeyVaultLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureKeyVault";
}

/**
 * Azure Key Vault linked service properties.
 */
model AzureKeyVaultLinkedServiceTypeProperties {
  /**
   * The base URL of the Azure Key Vault. e.g. https://myakv.vault.azure.net Type: string (or Expression with resultType string).
   */
  baseUrl: Record<unknown>;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * Microsoft Azure Cosmos Database (CosmosDB) linked service.
 */
model CosmosDbLinkedService extends LinkedService {
  /**
   * CosmosDB linked service properties.
   */
  typeProperties: CosmosDbLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "CosmosDb";
}

/**
 * CosmosDB linked service properties.
 */
model CosmosDbLinkedServiceTypeProperties {
  /**
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString?: Record<unknown>;

  /**
   * The endpoint of the Azure CosmosDB account. Type: string (or Expression with resultType string)
   */
  accountEndpoint?: Record<unknown>;

  /**
   * The name of the database. Type: string (or Expression with resultType string)
   */
  database?: Record<unknown>;

  /**
   * The account key of the Azure CosmosDB account. Type: SecureString or AzureKeyVaultSecretReference.
   */
  accountKey?: SecretBase;

  /**
   * The client ID of the application in Azure Active Directory used for Server-To-Server authentication. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string.
   */
  servicePrincipalCredentialType?: Record<unknown>;

  /**
   * The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.
   */
  servicePrincipalCredential?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  tenant?: Record<unknown>;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  azureCloudType?: Record<unknown>;

  /**
   * The connection mode used to access CosmosDB account. Type: string.
   */
  connectionMode?: CosmosDbConnectionMode;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * Dynamics linked service.
 */
model DynamicsLinkedService extends LinkedService {
  /**
   * Dynamics linked service properties.
   */
  typeProperties: DynamicsLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Dynamics";
}

/**
 * Dynamics linked service properties.
 */
model DynamicsLinkedServiceTypeProperties {
  /**
   * The deployment type of the Dynamics instance. 'Online' for Dynamics Online and 'OnPremisesWithIfd' for Dynamics on-premises with Ifd. Type: string (or Expression with resultType string).
   */
  deploymentType: Record<unknown>;

  /**
   * The host name of the on-premises Dynamics server. The property is required for on-prem and not allowed for online. Type: string (or Expression with resultType string).
   */
  hostName?: Record<unknown>;

  /**
   * The port of on-premises Dynamics server. The property is required for on-prem and not allowed for online. Default is 443. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  port?: Record<unknown>;

  /**
   * The URL to the Microsoft Dynamics server. The property is required for on-line and not allowed for on-prem. Type: string (or Expression with resultType string).
   */
  serviceUri?: Record<unknown>;

  /**
   * The organization name of the Dynamics instance. The property is required for on-prem and required for online when there are more than one Dynamics instances associated with the user. Type: string (or Expression with resultType string).
   */
  organizationName?: Record<unknown>;

  /**
   * The authentication type to connect to Dynamics server. 'Office365' for online scenario, 'Ifd' for on-premises with Ifd scenario, 'AADServicePrincipal' for Server-To-Server authentication in online scenario. Type: string (or Expression with resultType string).
   */
  authenticationType: Record<unknown>;

  /**
   * User name to access the Dynamics instance. Type: string (or Expression with resultType string).
   */
  username?: Record<unknown>;

  /**
   * Password to access the Dynamics instance.
   */
  password?: SecretBase;

  /**
   * The client ID of the application in Azure Active Directory used for Server-To-Server authentication. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).
   */
  servicePrincipalCredentialType?: Record<unknown>;

  /**
   * The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.
   */
  servicePrincipalCredential?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * Dynamics CRM linked service.
 */
model DynamicsCrmLinkedService extends LinkedService {
  /**
   * Dynamics CRM linked service properties.
   */
  typeProperties: DynamicsCrmLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "DynamicsCrm";
}

/**
 * Dynamics CRM linked service properties.
 */
model DynamicsCrmLinkedServiceTypeProperties {
  /**
   * The deployment type of the Dynamics CRM instance. 'Online' for Dynamics CRM Online and 'OnPremisesWithIfd' for Dynamics CRM on-premises with Ifd. Type: string (or Expression with resultType string).
   */
  deploymentType: Record<unknown>;

  /**
   * The host name of the on-premises Dynamics CRM server. The property is required for on-prem and not allowed for online. Type: string (or Expression with resultType string).
   */
  hostName?: Record<unknown>;

  /**
   * The port of on-premises Dynamics CRM server. The property is required for on-prem and not allowed for online. Default is 443. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  port?: Record<unknown>;

  /**
   * The URL to the Microsoft Dynamics CRM server. The property is required for on-line and not allowed for on-prem. Type: string (or Expression with resultType string).
   */
  serviceUri?: Record<unknown>;

  /**
   * The organization name of the Dynamics CRM instance. The property is required for on-prem and required for online when there are more than one Dynamics CRM instances associated with the user. Type: string (or Expression with resultType string).
   */
  organizationName?: Record<unknown>;

  /**
   * The authentication type to connect to Dynamics CRM server. 'Office365' for online scenario, 'Ifd' for on-premises with Ifd scenario, 'AADServicePrincipal' for Server-To-Server authentication in online scenario. Type: string (or Expression with resultType string).
   */
  authenticationType: Record<unknown>;

  /**
   * User name to access the Dynamics CRM instance. Type: string (or Expression with resultType string).
   */
  username?: Record<unknown>;

  /**
   * Password to access the Dynamics CRM instance.
   */
  password?: SecretBase;

  /**
   * The client ID of the application in Azure Active Directory used for Server-To-Server authentication. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).
   */
  servicePrincipalCredentialType?: Record<unknown>;

  /**
   * The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.
   */
  servicePrincipalCredential?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Common Data Service for Apps linked service.
 */
model CommonDataServiceForAppsLinkedService extends LinkedService {
  /**
   * Common Data Service for Apps linked service properties.
   */
  typeProperties: CommonDataServiceForAppsLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "CommonDataServiceForApps";
}

/**
 * Common Data Service for Apps linked service properties.
 */
model CommonDataServiceForAppsLinkedServiceTypeProperties {
  /**
   * The deployment type of the Common Data Service for Apps instance. 'Online' for Common Data Service for Apps Online and 'OnPremisesWithIfd' for Common Data Service for Apps on-premises with Ifd. Type: string (or Expression with resultType string).
   */
  deploymentType: Record<unknown>;

  /**
   * The host name of the on-premises Common Data Service for Apps server. The property is required for on-prem and not allowed for online. Type: string (or Expression with resultType string).
   */
  hostName?: Record<unknown>;

  /**
   * The port of on-premises Common Data Service for Apps server. The property is required for on-prem and not allowed for online. Default is 443. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  port?: Record<unknown>;

  /**
   * The URL to the Microsoft Common Data Service for Apps server. The property is required for on-line and not allowed for on-prem. Type: string (or Expression with resultType string).
   */
  serviceUri?: Record<unknown>;

  /**
   * The organization name of the Common Data Service for Apps instance. The property is required for on-prem and required for online when there are more than one Common Data Service for Apps instances associated with the user. Type: string (or Expression with resultType string).
   */
  organizationName?: Record<unknown>;

  /**
   * The authentication type to connect to Common Data Service for Apps server. 'Office365' for online scenario, 'Ifd' for on-premises with Ifd scenario. 'AADServicePrincipal' for Server-To-Server authentication in online scenario. Type: string (or Expression with resultType string).
   */
  authenticationType: Record<unknown>;

  /**
   * User name to access the Common Data Service for Apps instance. Type: string (or Expression with resultType string).
   */
  username?: Record<unknown>;

  /**
   * Password to access the Common Data Service for Apps instance.
   */
  password?: SecretBase;

  /**
   * The client ID of the application in Azure Active Directory used for Server-To-Server authentication. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).
   */
  servicePrincipalCredentialType?: Record<unknown>;

  /**
   * The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.
   */
  servicePrincipalCredential?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * HDInsight linked service.
 */
model HDInsightLinkedService extends LinkedService {
  /**
   * HDInsight linked service properties.
   */
  typeProperties: HDInsightLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "HDInsight";
}

/**
 * HDInsight linked service properties.
 */
model HDInsightLinkedServiceTypeProperties {
  /**
   * HDInsight cluster URI. Type: string (or Expression with resultType string).
   */
  clusterUri: Record<unknown>;

  /**
   * HDInsight cluster user name. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * HDInsight cluster password.
   */
  password?: SecretBase;

  /**
   * The Azure Storage linked service reference.
   */
  linkedServiceName?: LinkedServiceReference;

  /**
   * A reference to the Azure SQL linked service that points to the HCatalog database.
   */
  hcatalogLinkedServiceName?: LinkedServiceReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * Specify if the HDInsight is created with ESP (Enterprise Security Package). Type: Boolean.
   */
  isEspEnabled?: Record<unknown>;

  /**
   * Specify the FileSystem if the main storage for the HDInsight is ADLS Gen2. Type: string (or Expression with resultType string).
   */
  fileSystem?: Record<unknown>;
}

/**
 * File system linked service.
 */
model FileServerLinkedService extends LinkedService {
  /**
   * File system linked service properties.
   */
  typeProperties: FileServerLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "FileServer";
}

/**
 * File system linked service properties.
 */
model FileServerLinkedServiceTypeProperties {
  /**
   * Host name of the server. Type: string (or Expression with resultType string).
   */
  host: Record<unknown>;

  /**
   * User ID to logon the server. Type: string (or Expression with resultType string).
   */
  userId?: Record<unknown>;

  /**
   * Password to logon the server.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Azure File Storage linked service.
 */
model AzureFileStorageLinkedService extends LinkedService {
  /**
   * Azure File Storage linked service properties.
   */
  typeProperties: AzureFileStorageLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureFileStorage";
}

/**
 * Azure File Storage linked service properties.
 */
model AzureFileStorageLinkedServiceTypeProperties {
  /**
   * Host name of the server. Type: string (or Expression with resultType string).
   */
  host?: Record<unknown>;

  /**
   * User ID to logon the server. Type: string (or Expression with resultType string).
   */
  userId?: Record<unknown>;

  /**
   * Password to logon the server.
   */
  password?: SecretBase;

  /**
   * The connection string. It is mutually exclusive with sasUri property. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString?: Record<unknown>;

  /**
   * The Azure key vault secret reference of accountKey in connection string.
   */
  accountKey?: AzureKeyVaultSecretReference;

  /**
   * SAS URI of the Azure File resource. It is mutually exclusive with connectionString property. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  sasUri?: Record<unknown>;

  /**
   * The Azure key vault secret reference of sasToken in sas uri.
   */
  sasToken?: AzureKeyVaultSecretReference;

  /**
   * The azure file share name. It is required when auth with accountKey/sasToken. Type: string (or Expression with resultType string).
   */
  fileShare?: Record<unknown>;

  /**
   * The azure file share snapshot version. Type: string (or Expression with resultType string).
   */
  snapshot?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for Amazon S3 Compatible.
 */
model AmazonS3CompatibleLinkedService extends LinkedService {
  /**
   * Amazon S3 Compatible linked service properties.
   */
  typeProperties: AmazonS3CompatibleLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AmazonS3Compatible";
}

/**
 * Amazon S3 Compatible linked service properties.
 */
model AmazonS3CompatibleLinkedServiceTypeProperties {
  /**
   * The access key identifier of the Amazon S3 Compatible Identity and Access Management (IAM) user. Type: string (or Expression with resultType string).
   */
  accessKeyId?: Record<unknown>;

  /**
   * The secret access key of the Amazon S3 Compatible Identity and Access Management (IAM) user.
   */
  secretAccessKey?: SecretBase;

  /**
   * This value specifies the endpoint to access with the Amazon S3 Compatible Connector. This is an optional property; change it only if you want to try a different service endpoint or want to switch between https and http. Type: string (or Expression with resultType string).
   */
  serviceUrl?: Record<unknown>;

  /**
   * If true, use S3 path-style access instead of virtual hosted-style access. Default value is false. Type: boolean (or Expression with resultType boolean).
   */
  forcePathStyle?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for Oracle Cloud Storage.
 */
model OracleCloudStorageLinkedService extends LinkedService {
  /**
   * Oracle Cloud Storage linked service properties.
   */
  typeProperties: OracleCloudStorageLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "OracleCloudStorage";
}

/**
 * Oracle Cloud Storage linked service properties.
 */
model OracleCloudStorageLinkedServiceTypeProperties {
  /**
   * The access key identifier of the Oracle Cloud Storage Identity and Access Management (IAM) user. Type: string (or Expression with resultType string).
   */
  accessKeyId?: Record<unknown>;

  /**
   * The secret access key of the Oracle Cloud Storage Identity and Access Management (IAM) user.
   */
  secretAccessKey?: SecretBase;

  /**
   * This value specifies the endpoint to access with the Oracle Cloud Storage Connector. This is an optional property; change it only if you want to try a different service endpoint or want to switch between https and http. Type: string (or Expression with resultType string).
   */
  serviceUrl?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for Google Cloud Storage.
 */
model GoogleCloudStorageLinkedService extends LinkedService {
  /**
   * Google Cloud Storage linked service properties.
   */
  typeProperties: GoogleCloudStorageLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "GoogleCloudStorage";
}

/**
 * Google Cloud Storage linked service properties.
 */
model GoogleCloudStorageLinkedServiceTypeProperties {
  /**
   * The access key identifier of the Google Cloud Storage Identity and Access Management (IAM) user. Type: string (or Expression with resultType string).
   */
  accessKeyId?: Record<unknown>;

  /**
   * The secret access key of the Google Cloud Storage Identity and Access Management (IAM) user.
   */
  secretAccessKey?: SecretBase;

  /**
   * This value specifies the endpoint to access with the Google Cloud Storage Connector. This is an optional property; change it only if you want to try a different service endpoint or want to switch between https and http. Type: string (or Expression with resultType string).
   */
  serviceUrl?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Oracle database.
 */
model OracleLinkedService extends LinkedService {
  /**
   * Oracle database linked service properties.
   */
  typeProperties: OracleLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Oracle";
}

/**
 * Oracle database linked service properties.
 */
model OracleLinkedServiceTypeProperties {
  /**
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString: Record<unknown>;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * AmazonRdsForOracle database.
 */
model AmazonRdsForOracleLinkedService extends LinkedService {
  /**
   * AmazonRdsForOracle database linked service properties.
   */
  typeProperties: AmazonRdsForLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AmazonRdsForOracle";
}

/**
 * AmazonRdsForOracle database linked service properties.
 */
model AmazonRdsForLinkedServiceTypeProperties {
  /**
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString: Record<unknown>;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Azure MySQL database linked service.
 */
model AzureMySqlLinkedService extends LinkedService {
  /**
   * Azure MySQL database linked service properties.
   */
  typeProperties: AzureMySqlLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureMySql";
}

/**
 * Azure MySQL database linked service properties.
 */
model AzureMySqlLinkedServiceTypeProperties {
  /**
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString: Record<unknown>;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for MySQL data source.
 */
model MySqlLinkedService extends LinkedService {
  /**
   * MySQL linked service properties.
   */
  typeProperties: MySqlLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "MySql";
}

/**
 * MySQL linked service properties.
 */
model MySqlLinkedServiceTypeProperties {
  /**
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString: Record<unknown>;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for PostgreSQL data source.
 */
model PostgreSqlLinkedService extends LinkedService {
  /**
   * PostgreSQL linked service properties.
   */
  typeProperties: PostgreSqlLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "PostgreSql";
}

/**
 * PostgreSQL linked service properties.
 */
model PostgreSqlLinkedServiceTypeProperties {
  /**
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString: Record<unknown>;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for Sybase data source.
 */
model SybaseLinkedService extends LinkedService {
  /**
   * Sybase linked service properties.
   */
  typeProperties: SybaseLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Sybase";
}

/**
 * Sybase linked service properties.
 */
model SybaseLinkedServiceTypeProperties {
  /**
   * Server name for connection. Type: string (or Expression with resultType string).
   */
  server: Record<unknown>;

  /**
   * Database name for connection. Type: string (or Expression with resultType string).
   */
  database: Record<unknown>;

  /**
   * Schema name for connection. Type: string (or Expression with resultType string).
   */
  schema?: Record<unknown>;

  /**
   * AuthenticationType to be used for connection.
   */
  authenticationType?: SybaseAuthenticationType;

  /**
   * Username for authentication. Type: string (or Expression with resultType string).
   */
  username?: Record<unknown>;

  /**
   * Password for authentication.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for DB2 data source.
 */
model Db2LinkedService extends LinkedService {
  /**
   * DB2 linked service properties.
   */
  typeProperties: Db2LinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Db2";
}

/**
 * DB2 linked service properties.
 */
model Db2LinkedServiceTypeProperties {
  /**
   * The connection string. It is mutually exclusive with server, database, authenticationType, userName, packageCollection and certificateCommonName property. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString?: Record<unknown>;

  /**
   * Server name for connection. It is mutually exclusive with connectionString property. Type: string (or Expression with resultType string).
   */
  server?: Record<unknown>;

  /**
   * Database name for connection. It is mutually exclusive with connectionString property. Type: string (or Expression with resultType string).
   */
  database?: Record<unknown>;

  /**
   * AuthenticationType to be used for connection. It is mutually exclusive with connectionString property.
   */
  authenticationType?: Db2AuthenticationType;

  /**
   * Username for authentication. It is mutually exclusive with connectionString property. Type: string (or Expression with resultType string).
   */
  username?: Record<unknown>;

  /**
   * Password for authentication.
   */
  password?: SecretBase;

  /**
   * Under where packages are created when querying database. It is mutually exclusive with connectionString property. Type: string (or Expression with resultType string).
   */
  packageCollection?: Record<unknown>;

  /**
   * Certificate Common Name when TLS is enabled. It is mutually exclusive with connectionString property. Type: string (or Expression with resultType string).
   */
  certificateCommonName?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. It is mutually exclusive with connectionString property. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for Teradata data source.
 */
model TeradataLinkedService extends LinkedService {
  /**
   * Teradata linked service properties.
   */
  typeProperties: TeradataLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Teradata";
}

/**
 * Teradata linked service properties.
 */
model TeradataLinkedServiceTypeProperties {
  /**
   * Teradata ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString?: Record<unknown>;

  /**
   * Server name for connection. Type: string (or Expression with resultType string).
   */
  server?: Record<unknown>;

  /**
   * AuthenticationType to be used for connection.
   */
  authenticationType?: TeradataAuthenticationType;

  /**
   * Username for authentication. Type: string (or Expression with resultType string).
   */
  username?: Record<unknown>;

  /**
   * Password for authentication.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Azure ML Studio Web Service linked service.
 */
model AzureMLLinkedService extends LinkedService {
  /**
   * Azure ML Studio Web Service linked service properties.
   */
  typeProperties: AzureMLLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureML";
}

/**
 * Azure ML Studio Web Service linked service properties.
 */
model AzureMLLinkedServiceTypeProperties {
  /**
   * The Batch Execution REST URL for an Azure ML Studio Web Service endpoint. Type: string (or Expression with resultType string).
   */
  mlEndpoint: Record<unknown>;

  /**
   * The API key for accessing the Azure ML model endpoint.
   */
  apiKey: SecretBase;

  /**
   * The Update Resource REST URL for an Azure ML Studio Web Service endpoint. Type: string (or Expression with resultType string).
   */
  updateResourceEndpoint?: Record<unknown>;

  /**
   * The ID of the service principal used to authenticate against the ARM-based updateResourceEndpoint of an Azure ML Studio web service. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The key of the service principal used to authenticate against the ARM-based updateResourceEndpoint of an Azure ML Studio web service.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  tenant?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * Type of authentication (Required to specify MSI) used to connect to AzureML. Type: string (or Expression with resultType string).
   */
  authentication?: Record<unknown>;
}

/**
 * Azure ML Service linked service.
 */
model AzureMLServiceLinkedService extends LinkedService {
  /**
   * Azure ML Service linked service properties.
   */
  typeProperties: AzureMLServiceLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureMLService";
}

/**
 * Azure ML Service linked service properties.
 */
model AzureMLServiceLinkedServiceTypeProperties {
  /**
   * Azure ML Service workspace subscription ID. Type: string (or Expression with resultType string).
   */
  subscriptionId: Record<unknown>;

  /**
   * Azure ML Service workspace resource group name. Type: string (or Expression with resultType string).
   */
  resourceGroupName: Record<unknown>;

  /**
   * Azure ML Service workspace name. Type: string (or Expression with resultType string).
   */
  mlWorkspaceName: Record<unknown>;

  /**
   * Type of authentication (Required to specify MSI) used to connect to AzureML. Type: string (or Expression with resultType string).
   */
  authentication?: Record<unknown>;

  /**
   * The ID of the service principal used to authenticate against the endpoint of a published Azure ML Service pipeline. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The key of the service principal used to authenticate against the endpoint of a published Azure ML Service pipeline.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  tenant?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Open Database Connectivity (ODBC) linked service.
 */
model OdbcLinkedService extends LinkedService {
  /**
   * ODBC linked service properties.
   */
  typeProperties: OdbcLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Odbc";
}

/**
 * ODBC linked service properties.
 */
model OdbcLinkedServiceTypeProperties {
  /**
   * The non-access credential portion of the connection string as well as an optional encrypted credential. Type: string, or SecureString, or AzureKeyVaultSecretReference, or Expression with resultType string.
   */
  connectionString: Record<unknown>;

  /**
   * Type of authentication used to connect to the ODBC data store. Possible values are: Anonymous and Basic. Type: string (or Expression with resultType string).
   */
  authenticationType?: Record<unknown>;

  /**
   * The access credential portion of the connection string specified in driver-specific property-value format.
   */
  credential?: SecretBase;

  /**
   * User name for Basic authentication. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * Password for Basic authentication.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Informix linked service.
 */
model InformixLinkedService extends LinkedService {
  /**
   * Informix linked service properties.
   */
  typeProperties: InformixLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Informix";
}

/**
 * Informix linked service properties.
 */
model InformixLinkedServiceTypeProperties {
  /**
   * The non-access credential portion of the connection string as well as an optional encrypted credential. Type: string, or SecureString, or AzureKeyVaultSecretReference, or Expression with resultType string.
   */
  connectionString: Record<unknown>;

  /**
   * Type of authentication used to connect to the Informix as ODBC data store. Possible values are: Anonymous and Basic. Type: string (or Expression with resultType string).
   */
  authenticationType?: Record<unknown>;

  /**
   * The access credential portion of the connection string specified in driver-specific property-value format.
   */
  credential?: SecretBase;

  /**
   * User name for Basic authentication. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * Password for Basic authentication.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Microsoft Access linked service.
 */
model MicrosoftAccessLinkedService extends LinkedService {
  /**
   * Microsoft Access linked service properties.
   */
  typeProperties: MicrosoftAccessLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "MicrosoftAccess";
}

/**
 * Microsoft Access linked service properties.
 */
model MicrosoftAccessLinkedServiceTypeProperties {
  /**
   * The non-access credential portion of the connection string as well as an optional encrypted credential. Type: string, or SecureString, or AzureKeyVaultSecretReference, or Expression with resultType string.
   */
  connectionString: Record<unknown>;

  /**
   * Type of authentication used to connect to the Microsoft Access as ODBC data store. Possible values are: Anonymous and Basic. Type: string (or Expression with resultType string).
   */
  authenticationType?: Record<unknown>;

  /**
   * The access credential portion of the connection string specified in driver-specific property-value format.
   */
  credential?: SecretBase;

  /**
   * User name for Basic authentication. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * Password for Basic authentication.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Hadoop Distributed File System (HDFS) linked service.
 */
model HdfsLinkedService extends LinkedService {
  /**
   * HDFS linked service properties.
   */
  typeProperties: HdfsLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Hdfs";
}

/**
 * HDFS linked service properties.
 */
model HdfsLinkedServiceTypeProperties {
  /**
   * The URL of the HDFS service endpoint, e.g. http://myhostname:50070/webhdfs/v1 . Type: string (or Expression with resultType string).
   */
  url: Record<unknown>;

  /**
   * Type of authentication used to connect to the HDFS. Possible values are: Anonymous and Windows. Type: string (or Expression with resultType string).
   */
  authenticationType?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * User name for Windows authentication. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * Password for Windows authentication.
   */
  password?: SecretBase;
}

/**
 * Open Data Protocol (OData) linked service.
 */
model ODataLinkedService extends LinkedService {
  /**
   * OData linked service properties.
   */
  typeProperties: ODataLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "OData";
}

/**
 * OData linked service properties.
 */
model ODataLinkedServiceTypeProperties {
  /**
   * The URL of the OData service endpoint. Type: string (or Expression with resultType string).
   */
  url: Record<unknown>;

  /**
   * Type of authentication used to connect to the OData service.
   */
  authenticationType?: ODataAuthenticationType;

  /**
   * User name of the OData service. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * Password of the OData service.
   */
  password?: SecretBase;

  /**
   * The additional HTTP headers in the request to RESTful API used for authorization. Type: object (or Expression with resultType object).
   */
  authHeaders?: Record<unknown>;

  /**
   * Specify the tenant information (domain name or tenant ID) under which your application resides. Type: string (or Expression with resultType string).
   */
  tenant?: Record<unknown>;

  /**
   * Specify the application id of your application registered in Azure Active Directory. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  azureCloudType?: Record<unknown>;

  /**
   * Specify the resource you are requesting authorization to use Directory. Type: string (or Expression with resultType string).
   */
  aadResourceId?: Record<unknown>;

  /**
   * Specify the credential type (key or cert) is used for service principal.
   */
  aadServicePrincipalCredentialType?: ODataAadServicePrincipalCredentialType;

  /**
   * Specify the secret of your application registered in Azure Active Directory. Type: string (or Expression with resultType string).
   */
  servicePrincipalKey?: SecretBase;

  /**
   * Specify the base64 encoded certificate of your application registered in Azure Active Directory. Type: string (or Expression with resultType string).
   */
  servicePrincipalEmbeddedCert?: SecretBase;

  /**
   * Specify the password of your certificate if your certificate has a password and you are using AadServicePrincipal authentication. Type: string (or Expression with resultType string).
   */
  servicePrincipalEmbeddedCertPassword?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Web linked service.
 */
model WebLinkedService extends LinkedService {
  /**
   * Web linked service properties.
   */
  typeProperties: WebLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Web";
}

/**
 * Base definition of WebLinkedServiceTypeProperties, this typeProperties is polymorphic based on authenticationType, so not flattened in SDK models.
 */
@discriminator("authenticationType")
model WebLinkedServiceTypeProperties {
  /**
   * The URL of the web service endpoint, e.g. https://www.microsoft.com . Type: string (or Expression with resultType string).
   */
  url: Record<unknown>;
}

/**
 * A WebLinkedService that uses anonymous authentication to communicate with an HTTP endpoint.
 */
model WebAnonymousAuthentication extends WebLinkedServiceTypeProperties {
  /**
   * Type of authentication used to connect to the web table source.
   */
  authenticationType: "Anonymous";
}

/**
 * A WebLinkedService that uses basic authentication to communicate with an HTTP endpoint.
 */
model WebBasicAuthentication extends WebLinkedServiceTypeProperties {
  /**
   * User name for Basic authentication. Type: string (or Expression with resultType string).
   */
  username: Record<unknown>;

  /**
   * The password for Basic authentication.
   */
  password: SecretBase;

  /**
   * Type of authentication used to connect to the web table source.
   */
  authenticationType: "Basic";
}

/**
 * A WebLinkedService that uses client certificate based authentication to communicate with an HTTP endpoint. This scheme follows mutual authentication; the server must also provide valid credentials to the client.
 */
model WebClientCertificateAuthentication
  extends WebLinkedServiceTypeProperties {
  /**
   * Base64-encoded contents of a PFX file.
   */
  pfx: SecretBase;

  /**
   * Password for the PFX file.
   */
  password: SecretBase;

  /**
   * Type of authentication used to connect to the web table source.
   */
  authenticationType: "ClientCertificate";
}

/**
 * Linked service for Cassandra data source.
 */
model CassandraLinkedService extends LinkedService {
  /**
   * Cassandra linked service properties.
   */
  typeProperties: CassandraLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Cassandra";
}

/**
 * Cassandra linked service properties.
 */
model CassandraLinkedServiceTypeProperties {
  /**
   * Host name for connection. Type: string (or Expression with resultType string).
   */
  host: Record<unknown>;

  /**
   * AuthenticationType to be used for connection. Type: string (or Expression with resultType string).
   */
  authenticationType?: Record<unknown>;

  /**
   * The port for the connection. Type: integer (or Expression with resultType integer).
   */
  port?: Record<unknown>;

  /**
   * Username for authentication. Type: string (or Expression with resultType string).
   */
  username?: Record<unknown>;

  /**
   * Password for authentication.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for MongoDb data source.
 */
model MongoDbLinkedService extends LinkedService {
  /**
   * MongoDB linked service properties.
   */
  typeProperties: MongoDbLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "MongoDb";
}

/**
 * MongoDB linked service properties.
 */
model MongoDbLinkedServiceTypeProperties {
  /**
   * The IP address or server name of the MongoDB server. Type: string (or Expression with resultType string).
   */
  server: Record<unknown>;

  /**
   * The authentication type to be used to connect to the MongoDB database.
   */
  authenticationType?: MongoDbAuthenticationType;

  /**
   * The name of the MongoDB database that you want to access. Type: string (or Expression with resultType string).
   */
  databaseName: Record<unknown>;

  /**
   * Username for authentication. Type: string (or Expression with resultType string).
   */
  username?: Record<unknown>;

  /**
   * Password for authentication.
   */
  password?: SecretBase;

  /**
   * Database to verify the username and password. Type: string (or Expression with resultType string).
   */
  authSource?: Record<unknown>;

  /**
   * The TCP port number that the MongoDB server uses to listen for client connections. The default value is 27017. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  port?: Record<unknown>;

  /**
   * Specifies whether the connections to the server are encrypted using SSL. The default value is false. Type: boolean (or Expression with resultType boolean).
   */
  enableSsl?: Record<unknown>;

  /**
   * Specifies whether to allow self-signed certificates from the server. The default value is false. Type: boolean (or Expression with resultType boolean).
   */
  allowSelfSignedServerCert?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for MongoDB Atlas data source.
 */
model MongoDbAtlasLinkedService extends LinkedService {
  /**
   * MongoDB Atlas linked service properties.
   */
  typeProperties: MongoDbAtlasLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "MongoDbAtlas";
}

/**
 * MongoDB Atlas linked service properties.
 */
model MongoDbAtlasLinkedServiceTypeProperties {
  /**
   * The MongoDB Atlas connection string. Type: string, SecureString or AzureKeyVaultSecretReference. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString: Record<unknown>;

  /**
   * The name of the MongoDB Atlas database that you want to access. Type: string (or Expression with resultType string).
   */
  database: Record<unknown>;

  /**
   * The driver version that you want to choose. Allowed value are v1 and v2. Type: string (or Expression with resultType string).
   */
  driverVersion?: Record<unknown>;
}

/**
 * Linked service for MongoDB data source.
 */
model MongoDbV2LinkedService extends LinkedService {
  /**
   * MongoDB linked service properties.
   */
  typeProperties: MongoDbV2LinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "MongoDbV2";
}

/**
 * MongoDB linked service properties.
 */
model MongoDbV2LinkedServiceTypeProperties {
  /**
   * The MongoDB connection string. Type: string, SecureString or AzureKeyVaultSecretReference. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString: Record<unknown>;

  /**
   * The name of the MongoDB database that you want to access. Type: string (or Expression with resultType string).
   */
  database: Record<unknown>;
}

/**
 * Linked service for CosmosDB (MongoDB API) data source.
 */
model CosmosDbMongoDbApiLinkedService extends LinkedService {
  /**
   * CosmosDB (MongoDB API) linked service properties.
   */
  typeProperties: CosmosDbMongoDbApiLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "CosmosDbMongoDbApi";
}

/**
 * CosmosDB (MongoDB API) linked service properties.
 */
model CosmosDbMongoDbApiLinkedServiceTypeProperties {
  /**
   * Whether the CosmosDB (MongoDB API) server version is higher than 3.2. The default value is false. Type: boolean (or Expression with resultType boolean).
   */
  isServerVersionAbove32?: Record<unknown>;

  /**
   * The CosmosDB (MongoDB API) connection string. Type: string, SecureString or AzureKeyVaultSecretReference. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString: Record<unknown>;

  /**
   * The name of the CosmosDB (MongoDB API) database that you want to access. Type: string (or Expression with resultType string).
   */
  database: Record<unknown>;
}

/**
 * Azure Data Lake Store linked service.
 */
model AzureDataLakeStoreLinkedService extends LinkedService {
  /**
   * Azure Data Lake Store linked service properties.
   */
  typeProperties: AzureDataLakeStoreLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureDataLakeStore";
}

/**
 * Azure Data Lake Store linked service properties.
 */
model AzureDataLakeStoreLinkedServiceTypeProperties {
  /**
   * Data Lake Store service URI. Type: string (or Expression with resultType string).
   */
  dataLakeStoreUri: Record<unknown>;

  /**
   * The ID of the application used to authenticate against the Azure Data Lake Store account. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The Key of the application used to authenticate against the Azure Data Lake Store account.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  tenant?: Record<unknown>;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  azureCloudType?: Record<unknown>;

  /**
   * Data Lake Store account name. Type: string (or Expression with resultType string).
   */
  accountName?: Record<unknown>;

  /**
   * Data Lake Store account subscription ID (if different from Data Factory account). Type: string (or Expression with resultType string).
   */
  subscriptionId?: Record<unknown>;

  /**
   * Data Lake Store account resource group name (if different from Data Factory account). Type: string (or Expression with resultType string).
   */
  resourceGroupName?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * Azure Data Lake Storage Gen2 linked service.
 */
model AzureBlobFSLinkedService extends LinkedService {
  /**
   * Azure Data Lake Storage Gen2 linked service properties.
   */
  typeProperties: AzureBlobFSLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureBlobFS";
}

/**
 * Azure Data Lake Storage Gen2 linked service properties.
 */
model AzureBlobFSLinkedServiceTypeProperties {
  /**
   * Endpoint for the Azure Data Lake Storage Gen2 service. Type: string (or Expression with resultType string).
   */
  url?: Record<unknown>;

  /**
   * Account key for the Azure Data Lake Storage Gen2 service. Type: string (or Expression with resultType string).
   */
  accountKey?: Record<unknown>;

  /**
   * The ID of the application used to authenticate against the Azure Data Lake Storage Gen2 account. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The Key of the application used to authenticate against the Azure Data Lake Storage Gen2 account.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  tenant?: Record<unknown>;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  azureCloudType?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).
   */
  servicePrincipalCredentialType?: Record<unknown>;

  /**
   * The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.
   */
  servicePrincipalCredential?: SecretBase;

  /**
   * SAS URI of the Azure Data Lake Storage Gen2 service. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  sasUri?: Record<unknown>;

  /**
   * The Azure key vault secret reference of sasToken in sas uri.
   */
  sasToken?: SecretBase;
}

/**
 * Office365 linked service.
 */
model Office365LinkedService extends LinkedService {
  /**
   * Office365 linked service properties.
   */
  typeProperties: Office365LinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Office365";
}

/**
 * Office365 linked service properties.
 */
model Office365LinkedServiceTypeProperties {
  /**
   * Azure tenant ID to which the Office 365 account belongs. Type: string (or Expression with resultType string).
   */
  office365TenantId: Record<unknown>;

  /**
   * Specify the tenant information under which your Azure AD web application resides. Type: string (or Expression with resultType string).
   */
  servicePrincipalTenantId: Record<unknown>;

  /**
   * Specify the application's client ID. Type: string (or Expression with resultType string).
   */
  servicePrincipalId: Record<unknown>;

  /**
   * Specify the application's key.
   */
  servicePrincipalKey: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for Salesforce.
 */
model SalesforceLinkedService extends LinkedService {
  /**
   * Salesforce linked service properties.
   */
  typeProperties: SalesforceLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Salesforce";
}

/**
 * Salesforce linked service properties.
 */
model SalesforceLinkedServiceTypeProperties {
  /**
   * The URL of Salesforce instance. Default is 'https://login.salesforce.com'. To copy data from sandbox, specify 'https://test.salesforce.com'. To copy data from custom domain, specify, for example, 'https://[domain].my.salesforce.com'. Type: string (or Expression with resultType string).
   */
  environmentUrl?: Record<unknown>;

  /**
   * The username for Basic authentication of the Salesforce instance. Type: string (or Expression with resultType string).
   */
  username?: Record<unknown>;

  /**
   * The password for Basic authentication of the Salesforce instance.
   */
  password?: SecretBase;

  /**
   * The security token is optional to remotely access Salesforce instance.
   */
  securityToken?: SecretBase;

  /**
   * The Salesforce API version used in ADF. Type: string (or Expression with resultType string).
   */
  apiVersion?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for Salesforce Service Cloud.
 */
model SalesforceServiceCloudLinkedService extends LinkedService {
  /**
   * Salesforce Service Cloud linked service properties.
   */
  typeProperties: SalesforceServiceCloudLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "SalesforceServiceCloud";
}

/**
 * Salesforce Service Cloud linked service properties.
 */
model SalesforceServiceCloudLinkedServiceTypeProperties {
  /**
   * The URL of Salesforce Service Cloud instance. Default is 'https://login.salesforce.com'. To copy data from sandbox, specify 'https://test.salesforce.com'. To copy data from custom domain, specify, for example, 'https://[domain].my.salesforce.com'. Type: string (or Expression with resultType string).
   */
  environmentUrl?: Record<unknown>;

  /**
   * The username for Basic authentication of the Salesforce instance. Type: string (or Expression with resultType string).
   */
  username?: Record<unknown>;

  /**
   * The password for Basic authentication of the Salesforce instance.
   */
  password?: SecretBase;

  /**
   * The security token is optional to remotely access Salesforce instance.
   */
  securityToken?: SecretBase;

  /**
   * The Salesforce API version used in ADF. Type: string (or Expression with resultType string).
   */
  apiVersion?: Record<unknown>;

  /**
   * Extended properties appended to the connection string. Type: string (or Expression with resultType string).
   */
  extendedProperties?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for SAP Cloud for Customer.
 */
model SapCloudForCustomerLinkedService extends LinkedService {
  /**
   * SAP Cloud for Customer linked service properties.
   */
  typeProperties: SapCloudForCustomerLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "SapCloudForCustomer";
}

/**
 * SAP Cloud for Customer linked service properties.
 */
model SapCloudForCustomerLinkedServiceTypeProperties {
  /**
   * The URL of SAP Cloud for Customer OData API. For example, '[https://[tenantname].crm.ondemand.com/sap/c4c/odata/v1]'. Type: string (or Expression with resultType string).
   */
  url: Record<unknown>;

  /**
   * The username for Basic authentication. Type: string (or Expression with resultType string).
   */
  username?: Record<unknown>;

  /**
   * The password for Basic authentication.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Either encryptedCredential or username/password must be provided. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for SAP ERP Central Component(SAP ECC).
 */
model SapEccLinkedService extends LinkedService {
  /**
   * SAP ECC linked service properties.
   */
  typeProperties: SapEccLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "SapEcc";
}

/**
 * SAP ECC linked service properties.
 */
model SapEccLinkedServiceTypeProperties {
  /**
   * The URL of SAP ECC OData API. For example, '[https://hostname:port/sap/opu/odata/sap/servicename/]'. Type: string (or Expression with resultType string).
   */
  url: Record<unknown>;

  /**
   * The username for Basic authentication. Type: string (or Expression with resultType string).
   */
  username?: Record<unknown>;

  /**
   * The password for Basic authentication.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Either encryptedCredential or username/password must be provided. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * SAP Business Warehouse Open Hub Destination Linked Service.
 */
model SapOpenHubLinkedService extends LinkedService {
  /**
   * Properties specific to SAP Business Warehouse Open Hub Destination linked service type.
   */
  typeProperties: SapOpenHubLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "SapOpenHub";
}

/**
 * Properties specific to SAP Business Warehouse Open Hub Destination linked service type.
 */
model SapOpenHubLinkedServiceTypeProperties {
  /**
   * Host name of the SAP BW instance where the open hub destination is located. Type: string (or Expression with resultType string).
   */
  server?: Record<unknown>;

  /**
   * System number of the BW system where the open hub destination is located. (Usually a two-digit decimal number represented as a string.) Type: string (or Expression with resultType string).
   */
  systemNumber?: Record<unknown>;

  /**
   * Client ID of the client on the BW system where the open hub destination is located. (Usually a three-digit decimal number represented as a string) Type: string (or Expression with resultType string).
   */
  clientId?: Record<unknown>;

  /**
   * Language of the BW system where the open hub destination is located. The default value is EN. Type: string (or Expression with resultType string).
   */
  language?: Record<unknown>;

  /**
   * SystemID of the SAP system where the table is located. Type: string (or Expression with resultType string).
   */
  systemId?: Record<unknown>;

  /**
   * Username to access the SAP BW server where the open hub destination is located. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * Password to access the SAP BW server where the open hub destination is located.
   */
  password?: SecretBase;

  /**
   * The hostname of the SAP Message Server. Type: string (or Expression with resultType string).
   */
  messageServer?: Record<unknown>;

  /**
   * The service name or port number of the Message Server. Type: string (or Expression with resultType string).
   */
  messageServerService?: Record<unknown>;

  /**
   * The Logon Group for the SAP System. Type: string (or Expression with resultType string).
   */
  logonGroup?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * SAP ODP Linked Service.
 */
model SapOdpLinkedService extends LinkedService {
  /**
   * Properties specific to SAP ODP linked service type.
   */
  typeProperties: SapOdpLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "SapOdp";
}

/**
 * Properties specific to this linked service type.
 */
model SapOdpLinkedServiceTypeProperties {
  /**
   * Host name of the SAP instance where the table is located. Type: string (or Expression with resultType string).
   */
  server?: Record<unknown>;

  /**
   * System number of the SAP system where the table is located. (Usually a two-digit decimal number represented as a string.) Type: string (or Expression with resultType string).
   */
  systemNumber?: Record<unknown>;

  /**
   * Client ID of the client on the SAP system where the table is located. (Usually a three-digit decimal number represented as a string) Type: string (or Expression with resultType string).
   */
  clientId?: Record<unknown>;

  /**
   * Language of the SAP system where the table is located. The default value is EN. Type: string (or Expression with resultType string).
   */
  language?: Record<unknown>;

  /**
   * SystemID of the SAP system where the table is located. Type: string (or Expression with resultType string).
   */
  systemId?: Record<unknown>;

  /**
   * Username to access the SAP server where the table is located. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * Password to access the SAP server where the table is located.
   */
  password?: SecretBase;

  /**
   * The hostname of the SAP Message Server. Type: string (or Expression with resultType string).
   */
  messageServer?: Record<unknown>;

  /**
   * The service name or port number of the Message Server. Type: string (or Expression with resultType string).
   */
  messageServerService?: Record<unknown>;

  /**
   * SNC activation indicator to access the SAP server where the table is located. Must be either 0 (off) or 1 (on). Type: string (or Expression with resultType string).
   */
  sncMode?: Record<unknown>;

  /**
   * Initiator's SNC name to access the SAP server where the table is located. Type: string (or Expression with resultType string).
   */
  sncMyName?: Record<unknown>;

  /**
   * Communication partner's SNC name to access the SAP server where the table is located. Type: string (or Expression with resultType string).
   */
  sncPartnerName?: Record<unknown>;

  /**
   * External security product's library to access the SAP server where the table is located. Type: string (or Expression with resultType string).
   */
  sncLibraryPath?: Record<unknown>;

  /**
   * SNC Quality of Protection. Allowed value include: 1, 2, 3, 8, 9. Type: string (or Expression with resultType string).
   */
  sncQop?: Record<unknown>;

  /**
   * SNC X509 certificate file path. Type: string (or Expression with resultType string).
   */
  x509CertificatePath?: Record<unknown>;

  /**
   * The Logon Group for the SAP System. Type: string (or Expression with resultType string).
   */
  logonGroup?: Record<unknown>;

  /**
   * The subscriber name. Type: string (or Expression with resultType string).
   */
  subscriberName?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Rest Service linked service.
 */
model RestServiceLinkedService extends LinkedService {
  /**
   * Rest Service linked service properties.
   */
  typeProperties: RestServiceLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "RestService";
}

/**
 * Rest Service linked service properties.
 */
model RestServiceLinkedServiceTypeProperties {
  /**
   * The base URL of the REST service. Type: string (or Expression with resultType string).
   */
  url: Record<unknown>;

  /**
   * Whether to validate server side SSL certificate when connecting to the endpoint.The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  enableServerCertificateValidation?: Record<unknown>;

  /**
   * Type of authentication used to connect to the REST service.
   */
  authenticationType: RestServiceAuthenticationType;

  /**
   * The user name used in Basic authentication type. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * The password used in Basic authentication type.
   */
  password?: SecretBase;

  /**
   * The additional HTTP headers in the request to RESTful API used for authorization. Type: object (or Expression with resultType object).
   */
  authHeaders?: Record<unknown>;

  /**
   * The application's client ID used in AadServicePrincipal authentication type. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The application's key used in AadServicePrincipal authentication type.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The tenant information (domain name or tenant ID) used in AadServicePrincipal authentication type under which your application resides. Type: string (or Expression with resultType string).
   */
  tenant?: Record<unknown>;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  azureCloudType?: Record<unknown>;

  /**
   * The resource you are requesting authorization to use. Type: string (or Expression with resultType string).
   */
  aadResourceId?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;

  /**
   * The client ID associated with your application. Type: string (or Expression with resultType string).
   */
  clientId?: Record<unknown>;

  /**
   * The client secret associated with your application.
   */
  clientSecret?: SecretBase;

  /**
   * The token endpoint of the authorization server to acquire access token. Type: string (or Expression with resultType string).
   */
  tokenEndpoint?: Record<unknown>;

  /**
   * The target service or resource to which the access will be requested. Type: string (or Expression with resultType string).
   */
  resource?: Record<unknown>;

  /**
   * The scope of the access required. It describes what kind of access will be requested. Type: string (or Expression with resultType string).
   */
  scope?: Record<unknown>;
}

/**
 * Linked service for TeamDesk.
 */
model TeamDeskLinkedService extends LinkedService {
  /**
   * TeamDesk linked service properties.
   */
  typeProperties: TeamDeskLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "TeamDesk";
}

/**
 * TeamDesk linked service type properties.
 */
model TeamDeskLinkedServiceTypeProperties {
  /**
   * The authentication type to use.
   */
  authenticationType: TeamDeskAuthenticationType;

  /**
   * The url to connect TeamDesk source. Type: string (or Expression with resultType string).
   */
  url: Record<unknown>;

  /**
   * The username of the TeamDesk source. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * The password of the TeamDesk source.
   */
  password?: SecretBase;

  /**
   * The api token for the TeamDesk source.
   */
  apiToken?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for Quickbase.
 */
model QuickbaseLinkedService extends LinkedService {
  /**
   * Quickbase linked service properties.
   */
  typeProperties: QuickbaseLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Quickbase";
}

/**
 * Quickbase linked service type properties.
 */
model QuickbaseLinkedServiceTypeProperties {
  /**
   * The url to connect Quickbase source. Type: string (or Expression with resultType string).
   */
  url: Record<unknown>;

  /**
   * The user token for the Quickbase source.
   */
  userToken: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for Smartsheet.
 */
model SmartsheetLinkedService extends LinkedService {
  /**
   * Smartsheet linked service properties.
   */
  typeProperties: SmartsheetLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Smartsheet";
}

/**
 * Smartsheet linked service type properties.
 */
model SmartsheetLinkedServiceTypeProperties {
  /**
   * The api token for the Smartsheet source.
   */
  apiToken: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for Zendesk.
 */
model ZendeskLinkedService extends LinkedService {
  /**
   * Zendesk linked service properties.
   */
  typeProperties: ZendeskLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Zendesk";
}

/**
 * Zendesk linked service type properties.
 */
model ZendeskLinkedServiceTypeProperties {
  /**
   * The authentication type to use.
   */
  authenticationType: ZendeskAuthenticationType;

  /**
   * The url to connect Zendesk source. Type: string (or Expression with resultType string).
   */
  url: Record<unknown>;

  /**
   * The username of the Zendesk source. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * The password of the Zendesk source.
   */
  password?: SecretBase;

  /**
   * The api token for the Zendesk source.
   */
  apiToken?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for Dataworld.
 */
model DataworldLinkedService extends LinkedService {
  /**
   * Dataworld linked service properties.
   */
  typeProperties: DataworldLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Dataworld";
}

/**
 * Dataworld linked service type properties.
 */
model DataworldLinkedServiceTypeProperties {
  /**
   * The api token for the Dataworld source.
   */
  apiToken: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for AppFigures.
 */
model AppFiguresLinkedService extends LinkedService {
  /**
   * AppFigures linked service properties.
   */
  typeProperties: AppFiguresLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AppFigures";
}

/**
 * AppFigures linked service type properties.
 */
model AppFiguresLinkedServiceTypeProperties {
  /**
   * The username of the Appfigures source. Type: string (or Expression with resultType string).
   */
  userName: Record<unknown>;

  /**
   * The password of the AppFigures source.
   */
  password: SecretBase;

  /**
   * The client key for the AppFigures source.
   */
  clientKey: SecretBase;
}

/**
 * Linked service for Asana.
 */
model AsanaLinkedService extends LinkedService {
  /**
   * Asana linked service properties.
   */
  typeProperties: AsanaLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Asana";
}

/**
 * Asana linked service type properties.
 */
model AsanaLinkedServiceTypeProperties {
  /**
   * The api token for the Asana source.
   */
  apiToken: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for Twilio.
 */
model TwilioLinkedService extends LinkedService {
  /**
   * Twilio linked service properties.
   */
  typeProperties: TwilioLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Twilio";
}

/**
 * Twilio linked service type properties.
 */
model TwilioLinkedServiceTypeProperties {
  /**
   * The Account SID of Twilio service. Type: string (or Expression with resultType string).
   */
  userName: Record<unknown>;

  /**
   * The auth token of Twilio service.
   */
  password: SecretBase;
}

/**
 * Linked service for GoogleSheets.
 */
model GoogleSheetsLinkedService extends LinkedService {
  /**
   * GoogleSheets linked service properties.
   */
  typeProperties: GoogleSheetsLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "GoogleSheets";
}

/**
 * GoogleSheets linked service type properties.
 */
model GoogleSheetsLinkedServiceTypeProperties {
  /**
   * The api token for the GoogleSheets source.
   */
  apiToken: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for Amazon S3.
 */
model AmazonS3LinkedService extends LinkedService {
  /**
   * Amazon S3 linked service properties.
   */
  typeProperties: AmazonS3LinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AmazonS3";
}

/**
 * Amazon S3 linked service properties.
 */
model AmazonS3LinkedServiceTypeProperties {
  /**
   * The authentication type of S3. Allowed value: AccessKey (default) or TemporarySecurityCredentials. Type: string (or Expression with resultType string).
   */
  authenticationType?: Record<unknown>;

  /**
   * The access key identifier of the Amazon S3 Identity and Access Management (IAM) user. Type: string (or Expression with resultType string).
   */
  accessKeyId?: Record<unknown>;

  /**
   * The secret access key of the Amazon S3 Identity and Access Management (IAM) user.
   */
  secretAccessKey?: SecretBase;

  /**
   * This value specifies the endpoint to access with the S3 Connector. This is an optional property; change it only if you want to try a different service endpoint or want to switch between https and http. Type: string (or Expression with resultType string).
   */
  serviceUrl?: Record<unknown>;

  /**
   * The session token for the S3 temporary security credential.
   */
  sessionToken?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for Amazon Redshift.
 */
model AmazonRedshiftLinkedService extends LinkedService {
  /**
   * Amazon Redshift linked service properties.
   */
  typeProperties: AmazonRedshiftLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AmazonRedshift";
}

/**
 * Amazon Redshift linked service properties.
 */
model AmazonRedshiftLinkedServiceTypeProperties {
  /**
   * The name of the Amazon Redshift server. Type: string (or Expression with resultType string).
   */
  server: Record<unknown>;

  /**
   * The username of the Amazon Redshift source. Type: string (or Expression with resultType string).
   */
  username?: Record<unknown>;

  /**
   * The password of the Amazon Redshift source.
   */
  password?: SecretBase;

  /**
   * The database name of the Amazon Redshift source. Type: string (or Expression with resultType string).
   */
  database: Record<unknown>;

  /**
   * The TCP port number that the Amazon Redshift server uses to listen for client connections. The default value is 5439. Type: integer (or Expression with resultType integer).
   */
  port?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Custom linked service.
 */
model CustomDataSourceLinkedService extends LinkedService {
  /**
   * Custom linked service properties.
   */
  typeProperties: Record<unknown>;

  /**
   * Type of linked service.
   */
  type: "CustomDataSource";
}

/**
 * Linked service for Windows Azure Search Service.
 */
model AzureSearchLinkedService extends LinkedService {
  /**
   * Windows Azure Search Service linked service properties.
   */
  typeProperties: AzureSearchLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureSearch";
}

/**
 * Windows Azure Search Service linked service properties.
 */
model AzureSearchLinkedServiceTypeProperties {
  /**
   * URL for Azure Search service. Type: string (or Expression with resultType string).
   */
  url: Record<unknown>;

  /**
   * Admin Key for Azure Search service
   */
  key?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Linked service for an HTTP source.
 */
model HttpLinkedService extends LinkedService {
  /**
   * Properties specific to this linked service type.
   */
  typeProperties: HttpLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "HttpServer";
}

/**
 * Properties specific to this linked service type.
 */
model HttpLinkedServiceTypeProperties {
  /**
   * The base URL of the HTTP endpoint, e.g. https://www.microsoft.com. Type: string (or Expression with resultType string).
   */
  url: Record<unknown>;

  /**
   * The authentication type to be used to connect to the HTTP server.
   */
  authenticationType?: HttpAuthenticationType;

  /**
   * User name for Basic, Digest, or Windows authentication. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * Password for Basic, Digest, Windows, or ClientCertificate with EmbeddedCertData authentication.
   */
  password?: SecretBase;

  /**
   * The additional HTTP headers in the request to RESTful API used for authorization. Type: object (or Expression with resultType object).
   */
  authHeaders?: Record<unknown>;

  /**
   * Base64 encoded certificate data for ClientCertificate authentication. For on-premises copy with ClientCertificate authentication, either CertThumbprint or EmbeddedCertData/Password should be specified. Type: string (or Expression with resultType string).
   */
  embeddedCertData?: Record<unknown>;

  /**
   * Thumbprint of certificate for ClientCertificate authentication. Only valid for on-premises copy. For on-premises copy with ClientCertificate authentication, either CertThumbprint or EmbeddedCertData/Password should be specified. Type: string (or Expression with resultType string).
   */
  certThumbprint?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * If true, validate the HTTPS server SSL certificate. Default value is true. Type: boolean (or Expression with resultType boolean).
   */
  enableServerCertificateValidation?: Record<unknown>;
}

/**
 * A FTP server Linked Service.
 */
model FtpServerLinkedService extends LinkedService {
  /**
   * Properties specific to this linked service type.
   */
  typeProperties: FtpServerLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "FtpServer";
}

/**
 * Properties specific to this linked service type.
 */
model FtpServerLinkedServiceTypeProperties {
  /**
   * Host name of the FTP server. Type: string (or Expression with resultType string).
   */
  host: Record<unknown>;

  /**
   * The TCP port number that the FTP server uses to listen for client connections. Default value is 21. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  port?: Record<unknown>;

  /**
   * The authentication type to be used to connect to the FTP server.
   */
  authenticationType?: FtpAuthenticationType;

  /**
   * Username to logon the FTP server. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * Password to logon the FTP server.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * If true, connect to the FTP server over SSL/TLS channel. Default value is true. Type: boolean (or Expression with resultType boolean).
   */
  enableSsl?: Record<unknown>;

  /**
   * If true, validate the FTP server SSL certificate when connect over SSL/TLS channel. Default value is true. Type: boolean (or Expression with resultType boolean).
   */
  enableServerCertificateValidation?: Record<unknown>;
}

/**
 * A linked service for an SSH File Transfer Protocol (SFTP) server.
 */
model SftpServerLinkedService extends LinkedService {
  /**
   * Properties specific to this linked service type.
   */
  typeProperties: SftpServerLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Sftp";
}

/**
 * Properties specific to this linked service type.
 */
model SftpServerLinkedServiceTypeProperties {
  /**
   * The SFTP server host name. Type: string (or Expression with resultType string).
   */
  host: Record<unknown>;

  /**
   * The TCP port number that the SFTP server uses to listen for client connections. Default value is 22. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  port?: Record<unknown>;

  /**
   * The authentication type to be used to connect to the FTP server.
   */
  authenticationType?: SftpAuthenticationType;

  /**
   * The username used to log on to the SFTP server. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * Password to logon the SFTP server for Basic authentication.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * The SSH private key file path for SshPublicKey authentication. Only valid for on-premises copy. For on-premises copy with SshPublicKey authentication, either PrivateKeyPath or PrivateKeyContent should be specified. SSH private key should be OpenSSH format. Type: string (or Expression with resultType string).
   */
  privateKeyPath?: Record<unknown>;

  /**
   * Base64 encoded SSH private key content for SshPublicKey authentication. For on-premises copy with SshPublicKey authentication, either PrivateKeyPath or PrivateKeyContent should be specified. SSH private key should be OpenSSH format.
   */
  privateKeyContent?: SecretBase;

  /**
   * The password to decrypt the SSH private key if the SSH private key is encrypted.
   */
  passPhrase?: SecretBase;

  /**
   * If true, skip the SSH host key validation. Default value is false. Type: boolean (or Expression with resultType boolean).
   */
  skipHostKeyValidation?: Record<unknown>;

  /**
   * The host key finger-print of the SFTP server. When SkipHostKeyValidation is false, HostKeyFingerprint should be specified. Type: string (or Expression with resultType string).
   */
  hostKeyFingerprint?: Record<unknown>;
}

/**
 * SAP Business Warehouse Linked Service.
 */
model SapBWLinkedService extends LinkedService {
  /**
   * Properties specific to this linked service type.
   */
  typeProperties: SapBWLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "SapBW";
}

/**
 * Properties specific to this linked service type.
 */
model SapBWLinkedServiceTypeProperties {
  /**
   * Host name of the SAP BW instance. Type: string (or Expression with resultType string).
   */
  server: Record<unknown>;

  /**
   * System number of the BW system. (Usually a two-digit decimal number represented as a string.) Type: string (or Expression with resultType string).
   */
  systemNumber: Record<unknown>;

  /**
   * Client ID of the client on the BW system. (Usually a three-digit decimal number represented as a string) Type: string (or Expression with resultType string).
   */
  clientId: Record<unknown>;

  /**
   * Username to access the SAP BW server. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * Password to access the SAP BW server.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * SAP HANA Linked Service.
 */
model SapHanaLinkedService extends LinkedService {
  /**
   * Properties specific to this linked service type.
   */
  typeProperties: SapHanaLinkedServiceProperties;

  /**
   * Type of linked service.
   */
  type: "SapHana";
}

/**
 * Properties specific to this linked service type.
 */
model SapHanaLinkedServiceProperties {
  /**
   * SAP HANA ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString?: Record<unknown>;

  /**
   * Host name of the SAP HANA server. Type: string (or Expression with resultType string).
   */
  server?: Record<unknown>;

  /**
   * The authentication type to be used to connect to the SAP HANA server.
   */
  authenticationType?: SapHanaAuthenticationType;

  /**
   * Username to access the SAP HANA server. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * Password to access the SAP HANA server.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Amazon Marketplace Web Service linked service.
 */
model AmazonMWSLinkedService extends LinkedService {
  /**
   * Amazon Marketplace Web Service linked service properties.
   */
  typeProperties: AmazonMWSLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AmazonMWS";
}

/**
 * Amazon Marketplace Web Service linked service properties.
 */
model AmazonMWSLinkedServiceTypeProperties {
  /**
   * The endpoint of the Amazon MWS server, (i.e. mws.amazonservices.com)
   */
  endpoint: Record<unknown>;

  /**
   * The Amazon Marketplace ID you want to retrieve data from. To retrieve data from multiple Marketplace IDs, separate them with a comma (,). (i.e. A2EUQ1WTGCTBG2)
   */
  marketplaceID: Record<unknown>;

  /**
   * The Amazon seller ID.
   */
  sellerID: Record<unknown>;

  /**
   * The Amazon MWS authentication token.
   */
  mwsAuthToken?: SecretBase;

  /**
   * The access key id used to access data.
   */
  accessKeyId: Record<unknown>;

  /**
   * The secret key used to access data.
   */
  secretKey?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  useEncryptedEndpoints?: Record<unknown>;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  useHostVerification?: Record<unknown>;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  usePeerVerification?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Azure PostgreSQL linked service.
 */
model AzurePostgreSqlLinkedService extends LinkedService {
  /**
   * Azure PostgreSQL linked service properties.
   */
  typeProperties: AzurePostgreSqlLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzurePostgreSql";
}

/**
 * Azure PostgreSQL linked service properties.
 */
model AzurePostgreSqlLinkedServiceTypeProperties {
  /**
   * An ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString?: Record<unknown>;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Concur Service linked service.
 */
model ConcurLinkedService extends LinkedService {
  /**
   * Concur Service linked service properties.
   */
  typeProperties: ConcurLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Concur";
}

/**
 * Concur Service linked service properties.
 */
model ConcurLinkedServiceTypeProperties {
  /**
   * Properties used to connect to Concur. It is mutually exclusive with any other properties in the linked service. Type: object.
   */
  connectionProperties?: Record<unknown>;

  /**
   * Application client_id supplied by Concur App Management.
   */
  clientId: Record<unknown>;

  /**
   * The user name that you use to access Concur Service.
   */
  username: Record<unknown>;

  /**
   * The password corresponding to the user name that you provided in the username field.
   */
  password?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  useEncryptedEndpoints?: Record<unknown>;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  useHostVerification?: Record<unknown>;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  usePeerVerification?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Couchbase server linked service.
 */
model CouchbaseLinkedService extends LinkedService {
  /**
   * Couchbase server linked service properties.
   */
  typeProperties: CouchbaseLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Couchbase";
}

/**
 * Couchbase server linked service properties.
 */
model CouchbaseLinkedServiceTypeProperties {
  /**
   * An ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString?: Record<unknown>;

  /**
   * The Azure key vault secret reference of credString in connection string.
   */
  credString?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Drill server linked service.
 */
model DrillLinkedService extends LinkedService {
  /**
   * Drill server linked service properties.
   */
  typeProperties: DrillLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Drill";
}

/**
 * Drill server linked service properties.
 */
model DrillLinkedServiceTypeProperties {
  /**
   * An ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString?: Record<unknown>;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  pwd?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Eloqua server linked service.
 */
model EloquaLinkedService extends LinkedService {
  /**
   * Eloqua server linked service properties.
   */
  typeProperties: EloquaLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Eloqua";
}

/**
 * Eloqua server linked service properties.
 */
model EloquaLinkedServiceTypeProperties {
  /**
   * The endpoint of the Eloqua server. (i.e. eloqua.example.com)
   */
  endpoint: Record<unknown>;

  /**
   * The site name and user name of your Eloqua account in the form: sitename/username. (i.e. Eloqua/Alice)
   */
  username: Record<unknown>;

  /**
   * The password corresponding to the user name.
   */
  password?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  useEncryptedEndpoints?: Record<unknown>;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  useHostVerification?: Record<unknown>;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  usePeerVerification?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Google BigQuery service linked service.
 */
model GoogleBigQueryLinkedService extends LinkedService {
  /**
   * Google BigQuery service linked service properties.
   */
  typeProperties: GoogleBigQueryLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "GoogleBigQuery";
}

/**
 * Google BigQuery service linked service properties.
 */
model GoogleBigQueryLinkedServiceTypeProperties {
  /**
   * The default BigQuery project to query against. Type: string (or Expression with resultType string).
   */
  project: Record<unknown>;

  /**
   * A comma-separated list of public BigQuery projects to access. Type: string (or Expression with resultType string).
   */
  additionalProjects?: Record<unknown>;

  /**
   * Whether to request access to Google Drive. Allowing Google Drive access enables support for federated tables that combine BigQuery data with data from Google Drive. The default value is false. Type: string (or Expression with resultType string).
   */
  requestGoogleDriveScope?: Record<unknown>;

  /**
   * The OAuth 2.0 authentication mechanism used for authentication. ServiceAuthentication can only be used on self-hosted IR.
   */
  authenticationType: GoogleBigQueryAuthenticationType;

  /**
   * The refresh token obtained from Google for authorizing access to BigQuery for UserAuthentication.
   */
  refreshToken?: SecretBase;

  /**
   * The client id of the google application used to acquire the refresh token. Type: string (or Expression with resultType string).
   */
  clientId?: Record<unknown>;

  /**
   * The client secret of the google application used to acquire the refresh token.
   */
  clientSecret?: SecretBase;

  /**
   * The service account email ID that is used for ServiceAuthentication and can only be used on self-hosted IR. Type: string (or Expression with resultType string).
   */
  email?: Record<unknown>;

  /**
   * The full path to the .p12 key file that is used to authenticate the service account email address and can only be used on self-hosted IR. Type: string (or Expression with resultType string).
   */
  keyFilePath?: Record<unknown>;

  /**
   * The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR. Type: string (or Expression with resultType string).
   */
  trustedCertPath?: Record<unknown>;

  /**
   * Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false.Type: boolean (or Expression with resultType boolean).
   */
  useSystemTrustStore?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Greenplum Database linked service.
 */
model GreenplumLinkedService extends LinkedService {
  /**
   * Greenplum Database linked service properties.
   */
  typeProperties: GreenplumLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Greenplum";
}

/**
 * Greenplum Database linked service properties.
 */
model GreenplumLinkedServiceTypeProperties {
  /**
   * An ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString?: Record<unknown>;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  pwd?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * HBase server linked service.
 */
model HBaseLinkedService extends LinkedService {
  /**
   * HBase server linked service properties.
   */
  typeProperties: HBaseLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "HBase";
}

/**
 * HBase server linked service properties.
 */
model HBaseLinkedServiceTypeProperties {
  /**
   * The IP address or host name of the HBase server. (i.e. 192.168.222.160)
   */
  host: Record<unknown>;

  /**
   * The TCP port that the HBase instance uses to listen for client connections. The default value is 9090.
   */
  port?: Record<unknown>;

  /**
   * The partial URL corresponding to the HBase server. (i.e. /gateway/sandbox/hbase/version)
   */
  httpPath?: Record<unknown>;

  /**
   * The authentication mechanism to use to connect to the HBase server.
   */
  authenticationType: HBaseAuthenticationType;

  /**
   * The user name used to connect to the HBase instance.
   */
  username?: Record<unknown>;

  /**
   * The password corresponding to the user name.
   */
  password?: SecretBase;

  /**
   * Specifies whether the connections to the server are encrypted using SSL. The default value is false.
   */
  enableSsl?: Record<unknown>;

  /**
   * The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR.
   */
  trustedCertPath?: Record<unknown>;

  /**
   * Specifies whether to require a CA-issued SSL certificate name to match the host name of the server when connecting over SSL. The default value is false.
   */
  allowHostNameCNMismatch?: Record<unknown>;

  /**
   * Specifies whether to allow self-signed certificates from the server. The default value is false.
   */
  allowSelfSignedServerCert?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Hive Server linked service.
 */
model HiveLinkedService extends LinkedService {
  /**
   * Hive Server linked service properties.
   */
  typeProperties: HiveLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Hive";
}

/**
 * Hive Server linked service properties.
 */
model HiveLinkedServiceTypeProperties {
  /**
   * IP address or host name of the Hive server, separated by ';' for multiple hosts (only when serviceDiscoveryMode is enable).
   */
  host: Record<unknown>;

  /**
   * The TCP port that the Hive server uses to listen for client connections.
   */
  port?: Record<unknown>;

  /**
   * The type of Hive server.
   */
  serverType?: HiveServerType;

  /**
   * The transport protocol to use in the Thrift layer.
   */
  thriftTransportProtocol?: HiveThriftTransportProtocol;

  /**
   * The authentication method used to access the Hive server.
   */
  authenticationType: HiveAuthenticationType;

  /**
   * true to indicate using the ZooKeeper service, false not.
   */
  serviceDiscoveryMode?: Record<unknown>;

  /**
   * The namespace on ZooKeeper under which Hive Server 2 nodes are added.
   */
  zooKeeperNameSpace?: Record<unknown>;

  /**
   * Specifies whether the driver uses native HiveQL queries,or converts them into an equivalent form in HiveQL.
   */
  useNativeQuery?: Record<unknown>;

  /**
   * The user name that you use to access Hive Server.
   */
  username?: Record<unknown>;

  /**
   * The password corresponding to the user name that you provided in the Username field
   */
  password?: SecretBase;

  /**
   * The partial URL corresponding to the Hive server.
   */
  httpPath?: Record<unknown>;

  /**
   * Specifies whether the connections to the server are encrypted using SSL. The default value is false.
   */
  enableSsl?: Record<unknown>;

  /**
   * The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR.
   */
  trustedCertPath?: Record<unknown>;

  /**
   * Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false.
   */
  useSystemTrustStore?: Record<unknown>;

  /**
   * Specifies whether to require a CA-issued SSL certificate name to match the host name of the server when connecting over SSL. The default value is false.
   */
  allowHostNameCNMismatch?: Record<unknown>;

  /**
   * Specifies whether to allow self-signed certificates from the server. The default value is false.
   */
  allowSelfSignedServerCert?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Hubspot Service linked service.
 */
model HubspotLinkedService extends LinkedService {
  /**
   * Hubspot Service linked service properties.
   */
  typeProperties: HubspotLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Hubspot";
}

/**
 * Hubspot Service linked service properties.
 */
model HubspotLinkedServiceTypeProperties {
  /**
   * The client ID associated with your Hubspot application.
   */
  clientId: Record<unknown>;

  /**
   * The client secret associated with your Hubspot application.
   */
  clientSecret?: SecretBase;

  /**
   * The access token obtained when initially authenticating your OAuth integration.
   */
  accessToken?: SecretBase;

  /**
   * The refresh token obtained when initially authenticating your OAuth integration.
   */
  refreshToken?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  useEncryptedEndpoints?: Record<unknown>;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  useHostVerification?: Record<unknown>;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  usePeerVerification?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Impala server linked service.
 */
model ImpalaLinkedService extends LinkedService {
  /**
   * Impala server linked service properties.
   */
  typeProperties: ImpalaLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Impala";
}

/**
 * Impala server linked service properties.
 */
model ImpalaLinkedServiceTypeProperties {
  /**
   * The IP address or host name of the Impala server. (i.e. 192.168.222.160)
   */
  host: Record<unknown>;

  /**
   * The TCP port that the Impala server uses to listen for client connections. The default value is 21050.
   */
  port?: Record<unknown>;

  /**
   * The authentication type to use.
   */
  authenticationType: ImpalaAuthenticationType;

  /**
   * The user name used to access the Impala server. The default value is anonymous when using SASLUsername.
   */
  username?: Record<unknown>;

  /**
   * The password corresponding to the user name when using UsernameAndPassword.
   */
  password?: SecretBase;

  /**
   * Specifies whether the connections to the server are encrypted using SSL. The default value is false.
   */
  enableSsl?: Record<unknown>;

  /**
   * The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR.
   */
  trustedCertPath?: Record<unknown>;

  /**
   * Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false.
   */
  useSystemTrustStore?: Record<unknown>;

  /**
   * Specifies whether to require a CA-issued SSL certificate name to match the host name of the server when connecting over SSL. The default value is false.
   */
  allowHostNameCNMismatch?: Record<unknown>;

  /**
   * Specifies whether to allow self-signed certificates from the server. The default value is false.
   */
  allowSelfSignedServerCert?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Jira Service linked service.
 */
model JiraLinkedService extends LinkedService {
  /**
   * Jira Service linked service properties.
   */
  typeProperties: JiraLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Jira";
}

/**
 * Jira Service linked service properties.
 */
model JiraLinkedServiceTypeProperties {
  /**
   * The IP address or host name of the Jira service. (e.g. jira.example.com)
   */
  host: Record<unknown>;

  /**
   * The TCP port that the Jira server uses to listen for client connections. The default value is 443 if connecting through HTTPS, or 8080 if connecting through HTTP.
   */
  port?: Record<unknown>;

  /**
   * The user name that you use to access Jira Service.
   */
  username: Record<unknown>;

  /**
   * The password corresponding to the user name that you provided in the username field.
   */
  password?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  useEncryptedEndpoints?: Record<unknown>;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  useHostVerification?: Record<unknown>;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  usePeerVerification?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Magento server linked service.
 */
model MagentoLinkedService extends LinkedService {
  /**
   * Magento server linked service properties.
   */
  typeProperties: MagentoLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Magento";
}

/**
 * Magento server linked service properties.
 */
model MagentoLinkedServiceTypeProperties {
  /**
   * The URL of the Magento instance. (i.e. 192.168.222.110/magento3)
   */
  host: Record<unknown>;

  /**
   * The access token from Magento.
   */
  accessToken?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  useEncryptedEndpoints?: Record<unknown>;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  useHostVerification?: Record<unknown>;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  usePeerVerification?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * MariaDB server linked service.
 */
model MariaDBLinkedService extends LinkedService {
  /**
   * MariaDB server linked service properties.
   */
  typeProperties: MariaDBLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "MariaDB";
}

/**
 * MariaDB server linked service properties.
 */
model MariaDBLinkedServiceTypeProperties {
  /**
   * An ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString?: Record<unknown>;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  pwd?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Azure Database for MariaDB linked service.
 */
model AzureMariaDBLinkedService extends LinkedService {
  /**
   * Azure Database for MariaDB linked service properties.
   */
  typeProperties: AzureMariaDBLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureMariaDB";
}

/**
 * Azure Database for MariaDB linked service properties.
 */
model AzureMariaDBLinkedServiceTypeProperties {
  /**
   * An ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString?: Record<unknown>;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  pwd?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Marketo server linked service.
 */
model MarketoLinkedService extends LinkedService {
  /**
   * Marketo server linked service properties.
   */
  typeProperties: MarketoLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Marketo";
}

/**
 * Marketo server linked service properties.
 */
model MarketoLinkedServiceTypeProperties {
  /**
   * The endpoint of the Marketo server. (i.e. 123-ABC-321.mktorest.com)
   */
  endpoint: Record<unknown>;

  /**
   * The client Id of your Marketo service.
   */
  clientId: Record<unknown>;

  /**
   * The client secret of your Marketo service.
   */
  clientSecret?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  useEncryptedEndpoints?: Record<unknown>;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  useHostVerification?: Record<unknown>;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  usePeerVerification?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Paypal Service linked service.
 */
model PaypalLinkedService extends LinkedService {
  /**
   * Paypal Service linked service properties.
   */
  typeProperties: PaypalLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Paypal";
}

/**
 * Paypal Service linked service properties.
 */
model PaypalLinkedServiceTypeProperties {
  /**
   * The URL of the PayPal instance. (i.e. api.sandbox.paypal.com)
   */
  host: Record<unknown>;

  /**
   * The client ID associated with your PayPal application.
   */
  clientId: Record<unknown>;

  /**
   * The client secret associated with your PayPal application.
   */
  clientSecret?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  useEncryptedEndpoints?: Record<unknown>;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  useHostVerification?: Record<unknown>;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  usePeerVerification?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Phoenix server linked service.
 */
model PhoenixLinkedService extends LinkedService {
  /**
   * Phoenix server linked service properties.
   */
  typeProperties: PhoenixLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Phoenix";
}

/**
 * Phoenix server linked service properties.
 */
model PhoenixLinkedServiceTypeProperties {
  /**
   * The IP address or host name of the Phoenix server. (i.e. 192.168.222.160)
   */
  host: Record<unknown>;

  /**
   * The TCP port that the Phoenix server uses to listen for client connections. The default value is 8765.
   */
  port?: Record<unknown>;

  /**
   * The partial URL corresponding to the Phoenix server. (i.e. /gateway/sandbox/phoenix/version). The default value is hbasephoenix if using WindowsAzureHDInsightService.
   */
  httpPath?: Record<unknown>;

  /**
   * The authentication mechanism used to connect to the Phoenix server.
   */
  authenticationType: PhoenixAuthenticationType;

  /**
   * The user name used to connect to the Phoenix server.
   */
  username?: Record<unknown>;

  /**
   * The password corresponding to the user name.
   */
  password?: SecretBase;

  /**
   * Specifies whether the connections to the server are encrypted using SSL. The default value is false.
   */
  enableSsl?: Record<unknown>;

  /**
   * The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR.
   */
  trustedCertPath?: Record<unknown>;

  /**
   * Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false.
   */
  useSystemTrustStore?: Record<unknown>;

  /**
   * Specifies whether to require a CA-issued SSL certificate name to match the host name of the server when connecting over SSL. The default value is false.
   */
  allowHostNameCNMismatch?: Record<unknown>;

  /**
   * Specifies whether to allow self-signed certificates from the server. The default value is false.
   */
  allowSelfSignedServerCert?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Presto server linked service.
 */
model PrestoLinkedService extends LinkedService {
  /**
   * Presto server linked service properties.
   */
  typeProperties: PrestoLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Presto";
}

/**
 * Presto server linked service properties.
 */
model PrestoLinkedServiceTypeProperties {
  /**
   * The IP address or host name of the Presto server. (i.e. 192.168.222.160)
   */
  host: Record<unknown>;

  /**
   * The version of the Presto server. (i.e. 0.148-t)
   */
  serverVersion: Record<unknown>;

  /**
   * The catalog context for all request against the server.
   */
  catalog: Record<unknown>;

  /**
   * The TCP port that the Presto server uses to listen for client connections. The default value is 8080.
   */
  port?: Record<unknown>;

  /**
   * The authentication mechanism used to connect to the Presto server.
   */
  authenticationType: PrestoAuthenticationType;

  /**
   * The user name used to connect to the Presto server.
   */
  username?: Record<unknown>;

  /**
   * The password corresponding to the user name.
   */
  password?: SecretBase;

  /**
   * Specifies whether the connections to the server are encrypted using SSL. The default value is false.
   */
  enableSsl?: Record<unknown>;

  /**
   * The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR.
   */
  trustedCertPath?: Record<unknown>;

  /**
   * Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false.
   */
  useSystemTrustStore?: Record<unknown>;

  /**
   * Specifies whether to require a CA-issued SSL certificate name to match the host name of the server when connecting over SSL. The default value is false.
   */
  allowHostNameCNMismatch?: Record<unknown>;

  /**
   * Specifies whether to allow self-signed certificates from the server. The default value is false.
   */
  allowSelfSignedServerCert?: Record<unknown>;

  /**
   * The local time zone used by the connection. Valid values for this option are specified in the IANA Time Zone Database. The default value is the system time zone.
   */
  timeZoneID?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * QuickBooks server linked service.
 */
model QuickBooksLinkedService extends LinkedService {
  /**
   * QuickBooks server linked service properties.
   */
  typeProperties: QuickBooksLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "QuickBooks";
}

/**
 * QuickBooks server linked service properties.
 */
model QuickBooksLinkedServiceTypeProperties {
  /**
   * Properties used to connect to QuickBooks. It is mutually exclusive with any other properties in the linked service. Type: object.
   */
  connectionProperties?: Record<unknown>;

  /**
   * The endpoint of the QuickBooks server. (i.e. quickbooks.api.intuit.com)
   */
  endpoint?: Record<unknown>;

  /**
   * The company ID of the QuickBooks company to authorize.
   */
  companyId?: Record<unknown>;

  /**
   * The consumer key for OAuth 1.0 authentication.
   */
  consumerKey?: Record<unknown>;

  /**
   * The consumer secret for OAuth 1.0 authentication.
   */
  consumerSecret?: SecretBase;

  /**
   * The access token for OAuth 1.0 authentication.
   */
  accessToken?: SecretBase;

  /**
   * The access token secret for OAuth 1.0 authentication.
   */
  accessTokenSecret?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  useEncryptedEndpoints?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * ServiceNow server linked service.
 */
model ServiceNowLinkedService extends LinkedService {
  /**
   * ServiceNow server linked service properties.
   */
  typeProperties: ServiceNowLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "ServiceNow";
}

/**
 * ServiceNow server linked service properties.
 */
model ServiceNowLinkedServiceTypeProperties {
  /**
   * The endpoint of the ServiceNow server. (i.e. <instance>.service-now.com)
   */
  endpoint: Record<unknown>;

  /**
   * The authentication type to use.
   */
  authenticationType: ServiceNowAuthenticationType;

  /**
   * The user name used to connect to the ServiceNow server for Basic and OAuth2 authentication.
   */
  username?: Record<unknown>;

  /**
   * The password corresponding to the user name for Basic and OAuth2 authentication.
   */
  password?: SecretBase;

  /**
   * The client id for OAuth2 authentication.
   */
  clientId?: Record<unknown>;

  /**
   * The client secret for OAuth2 authentication.
   */
  clientSecret?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  useEncryptedEndpoints?: Record<unknown>;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  useHostVerification?: Record<unknown>;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  usePeerVerification?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Shopify Service linked service.
 */
model ShopifyLinkedService extends LinkedService {
  /**
   * Shopify Service linked service properties.
   */
  typeProperties: ShopifyLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Shopify";
}

/**
 * Shopify Service linked service properties.
 */
model ShopifyLinkedServiceTypeProperties {
  /**
   * The endpoint of the Shopify server. (i.e. mystore.myshopify.com)
   */
  host: Record<unknown>;

  /**
   * The API access token that can be used to access Shopify’s data. The token won't expire if it is offline mode.
   */
  accessToken?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  useEncryptedEndpoints?: Record<unknown>;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  useHostVerification?: Record<unknown>;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  usePeerVerification?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Spark Server linked service.
 */
model SparkLinkedService extends LinkedService {
  /**
   * Spark Server linked service properties.
   */
  typeProperties: SparkLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Spark";
}

/**
 * Spark Server linked service properties.
 */
model SparkLinkedServiceTypeProperties {
  /**
   * IP address or host name of the Spark server
   */
  host: Record<unknown>;

  /**
   * The TCP port that the Spark server uses to listen for client connections.
   */
  port: Record<unknown>;

  /**
   * The type of Spark server.
   */
  serverType?: SparkServerType;

  /**
   * The transport protocol to use in the Thrift layer.
   */
  thriftTransportProtocol?: SparkThriftTransportProtocol;

  /**
   * The authentication method used to access the Spark server.
   */
  authenticationType: SparkAuthenticationType;

  /**
   * The user name that you use to access Spark Server.
   */
  username?: Record<unknown>;

  /**
   * The password corresponding to the user name that you provided in the Username field
   */
  password?: SecretBase;

  /**
   * The partial URL corresponding to the Spark server.
   */
  httpPath?: Record<unknown>;

  /**
   * Specifies whether the connections to the server are encrypted using SSL. The default value is false.
   */
  enableSsl?: Record<unknown>;

  /**
   * The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR.
   */
  trustedCertPath?: Record<unknown>;

  /**
   * Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false.
   */
  useSystemTrustStore?: Record<unknown>;

  /**
   * Specifies whether to require a CA-issued SSL certificate name to match the host name of the server when connecting over SSL. The default value is false.
   */
  allowHostNameCNMismatch?: Record<unknown>;

  /**
   * Specifies whether to allow self-signed certificates from the server. The default value is false.
   */
  allowSelfSignedServerCert?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Square Service linked service.
 */
model SquareLinkedService extends LinkedService {
  /**
   * Square Service linked service properties.
   */
  typeProperties: SquareLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Square";
}

/**
 * Square Service linked service properties.
 */
model SquareLinkedServiceTypeProperties {
  /**
   * Properties used to connect to Square. It is mutually exclusive with any other properties in the linked service. Type: object.
   */
  connectionProperties?: Record<unknown>;

  /**
   * The URL of the Square instance. (i.e. mystore.mysquare.com)
   */
  host?: Record<unknown>;

  /**
   * The client ID associated with your Square application.
   */
  clientId?: Record<unknown>;

  /**
   * The client secret associated with your Square application.
   */
  clientSecret?: SecretBase;

  /**
   * The redirect URL assigned in the Square application dashboard. (i.e. http://localhost:2500)
   */
  redirectUri?: Record<unknown>;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  useEncryptedEndpoints?: Record<unknown>;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  useHostVerification?: Record<unknown>;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  usePeerVerification?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Xero Service linked service.
 */
model XeroLinkedService extends LinkedService {
  /**
   * Xero Service linked service properties.
   */
  typeProperties: XeroLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Xero";
}

/**
 * Xero Service linked service properties.
 */
model XeroLinkedServiceTypeProperties {
  /**
   * Properties used to connect to Xero. It is mutually exclusive with any other properties in the linked service. Type: object.
   */
  connectionProperties?: Record<unknown>;

  /**
   * The endpoint of the Xero server. (i.e. api.xero.com)
   */
  host?: Record<unknown>;

  /**
   * The consumer key associated with the Xero application.
   */
  consumerKey?: SecretBase;

  /**
* The private key from the .pem file that was generated for your Xero private application. You must include all the text from the .pem file, including the Unix line endings(
).
*/
  privateKey?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  useEncryptedEndpoints?: Record<unknown>;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  useHostVerification?: Record<unknown>;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  usePeerVerification?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Zoho server linked service.
 */
model ZohoLinkedService extends LinkedService {
  /**
   * Zoho server linked service properties.
   */
  typeProperties: ZohoLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Zoho";
}

/**
 * Zoho server linked service properties.
 */
model ZohoLinkedServiceTypeProperties {
  /**
   * Properties used to connect to Zoho. It is mutually exclusive with any other properties in the linked service. Type: object.
   */
  connectionProperties?: Record<unknown>;

  /**
   * The endpoint of the Zoho server. (i.e. crm.zoho.com/crm/private)
   */
  endpoint?: Record<unknown>;

  /**
   * The access token for Zoho authentication.
   */
  accessToken?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  useEncryptedEndpoints?: Record<unknown>;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  useHostVerification?: Record<unknown>;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  usePeerVerification?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Vertica linked service.
 */
model VerticaLinkedService extends LinkedService {
  /**
   * Vertica linked service properties.
   */
  typeProperties: VerticaLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Vertica";
}

/**
 * Vertica linked service properties.
 */
model VerticaLinkedServiceTypeProperties {
  /**
   * An ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString?: Record<unknown>;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  pwd?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Netezza linked service.
 */
model NetezzaLinkedService extends LinkedService {
  /**
   * Netezza linked service properties.
   */
  typeProperties: NetezzaLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Netezza";
}

/**
 * Netezza linked service properties.
 */
model NetezzaLinkedServiceTypeProperties {
  /**
   * An ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  connectionString?: Record<unknown>;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  pwd?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Salesforce Marketing Cloud linked service.
 */
model SalesforceMarketingCloudLinkedService extends LinkedService {
  /**
   * Salesforce Marketing Cloud linked service properties.
   */
  typeProperties: SalesforceMarketingCloudLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "SalesforceMarketingCloud";
}

/**
 * Salesforce Marketing Cloud linked service properties.
 */
model SalesforceMarketingCloudLinkedServiceTypeProperties {
  /**
   * Properties used to connect to Salesforce Marketing Cloud. It is mutually exclusive with any other properties in the linked service. Type: object.
   */
  connectionProperties?: Record<unknown>;

  /**
   * The client ID associated with the Salesforce Marketing Cloud application. Type: string (or Expression with resultType string).
   */
  clientId?: Record<unknown>;

  /**
   * The client secret associated with the Salesforce Marketing Cloud application. Type: string (or Expression with resultType string).
   */
  clientSecret?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  useEncryptedEndpoints?: Record<unknown>;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  useHostVerification?: Record<unknown>;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  usePeerVerification?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * HDInsight ondemand linked service.
 */
model HDInsightOnDemandLinkedService extends LinkedService {
  /**
   * HDInsight ondemand linked service properties.
   */
  typeProperties: HDInsightOnDemandLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "HDInsightOnDemand";
}

/**
 * HDInsight ondemand linked service properties.
 */
model HDInsightOnDemandLinkedServiceTypeProperties {
  /**
   * Number of worker/data nodes in the cluster. Suggestion value: 4. Type: string (or Expression with resultType string).
   */
  clusterSize: Record<unknown>;

  /**
   * The allowed idle time for the on-demand HDInsight cluster. Specifies how long the on-demand HDInsight cluster stays alive after completion of an activity run if there are no other active jobs in the cluster. The minimum value is 5 mins. Type: string (or Expression with resultType string).
   */
  timeToLive: Record<unknown>;

  /**
   * Version of the HDInsight cluster.  Type: string (or Expression with resultType string).
   */
  version: Record<unknown>;

  /**
   * Azure Storage linked service to be used by the on-demand cluster for storing and processing data.
   */
  linkedServiceName: LinkedServiceReference;

  /**
   * The customer’s subscription to host the cluster. Type: string (or Expression with resultType string).
   */
  hostSubscriptionId: Record<unknown>;

  /**
   * The service principal id for the hostSubscriptionId. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The key for the service principal id.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The Tenant id/name to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  tenant: Record<unknown>;

  /**
   * The resource group where the cluster belongs. Type: string (or Expression with resultType string).
   */
  clusterResourceGroup: Record<unknown>;

  /**
   * The prefix of cluster name, postfix will be distinct with timestamp. Type: string (or Expression with resultType string).
   */
  clusterNamePrefix?: Record<unknown>;

  /**
   * The username to access the cluster. Type: string (or Expression with resultType string).
   */
  clusterUserName?: Record<unknown>;

  /**
   * The password to access the cluster.
   */
  clusterPassword?: SecretBase;

  /**
   * The username to SSH remotely connect to cluster’s node (for Linux). Type: string (or Expression with resultType string).
   */
  clusterSshUserName?: Record<unknown>;

  /**
   * The password to SSH remotely connect cluster’s node (for Linux).
   */
  clusterSshPassword?: SecretBase;

  /**
   * Specifies additional storage accounts for the HDInsight linked service so that the Data Factory service can register them on your behalf.
   */
  additionalLinkedServiceNames?: LinkedServiceReference[];

  /**
   * The name of Azure SQL linked service that point to the HCatalog database. The on-demand HDInsight cluster is created by using the Azure SQL database as the metastore.
   */
  hcatalogLinkedServiceName?: LinkedServiceReference;

  /**
   * The cluster type. Type: string (or Expression with resultType string).
   */
  clusterType?: Record<unknown>;

  /**
   * The version of spark if the cluster type is 'spark'. Type: string (or Expression with resultType string).
   */
  sparkVersion?: Record<unknown>;

  /**
   * Specifies the core configuration parameters (as in core-site.xml) for the HDInsight cluster to be created.
   */
  coreConfiguration?: Record<unknown>;

  /**
   * Specifies the HBase configuration parameters (hbase-site.xml) for the HDInsight cluster.
   */
  hBaseConfiguration?: Record<unknown>;

  /**
   * Specifies the HDFS configuration parameters (hdfs-site.xml) for the HDInsight cluster.
   */
  hdfsConfiguration?: Record<unknown>;

  /**
   * Specifies the hive configuration parameters (hive-site.xml) for the HDInsight cluster.
   */
  hiveConfiguration?: Record<unknown>;

  /**
   * Specifies the MapReduce configuration parameters (mapred-site.xml) for the HDInsight cluster.
   */
  mapReduceConfiguration?: Record<unknown>;

  /**
   * Specifies the Oozie configuration parameters (oozie-site.xml) for the HDInsight cluster.
   */
  oozieConfiguration?: Record<unknown>;

  /**
   * Specifies the Storm configuration parameters (storm-site.xml) for the HDInsight cluster.
   */
  stormConfiguration?: Record<unknown>;

  /**
   * Specifies the Yarn configuration parameters (yarn-site.xml) for the HDInsight cluster.
   */
  yarnConfiguration?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * Specifies the size of the head node for the HDInsight cluster.
   */
  headNodeSize?: Record<unknown>;

  /**
   * Specifies the size of the data node for the HDInsight cluster.
   */
  dataNodeSize?: Record<unknown>;

  /**
   * Specifies the size of the Zoo Keeper node for the HDInsight cluster.
   */
  zookeeperNodeSize?: Record<unknown>;

  /**
   * Custom script actions to run on HDI ondemand cluster once it's up. Please refer to https://docs.microsoft.com/en-us/azure/hdinsight/hdinsight-hadoop-customize-cluster-linux?toc=%2Fen-us%2Fazure%2Fhdinsight%2Fr-server%2FTOC.json&bc=%2Fen-us%2Fazure%2Fbread%2Ftoc.json#understanding-script-actions.
   */
  scriptActions?: ScriptAction[];

  /**
   * The ARM resource ID for the vNet to which the cluster should be joined after creation. Type: string (or Expression with resultType string).
   */
  virtualNetworkId?: Record<unknown>;

  /**
   * The ARM resource ID for the subnet in the vNet. If virtualNetworkId was specified, then this property is required. Type: string (or Expression with resultType string).
   */
  subnetName?: Record<unknown>;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * Custom script action to run on HDI ondemand cluster once it's up.
 */
model ScriptAction {
  /**
   * The user provided name of the script action.
   */
  name: string;

  /**
   * The URI for the script action.
   */
  uri: string;

  /**
   * The node types on which the script action should be executed.
   */
  roles: Record<unknown>;

  /**
   * The parameters for the script action.
   */
  parameters?: string;
}

/**
 * Azure Data Lake Analytics linked service.
 */
model AzureDataLakeAnalyticsLinkedService extends LinkedService {
  /**
   * Azure Data Lake Analytics linked service properties.
   */
  typeProperties: AzureDataLakeAnalyticsLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureDataLakeAnalytics";
}

/**
 * Azure Data Lake Analytics linked service properties.
 */
model AzureDataLakeAnalyticsLinkedServiceTypeProperties {
  /**
   * The Azure Data Lake Analytics account name. Type: string (or Expression with resultType string).
   */
  accountName: Record<unknown>;

  /**
   * The ID of the application used to authenticate against the Azure Data Lake Analytics account. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The Key of the application used to authenticate against the Azure Data Lake Analytics account.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  tenant: Record<unknown>;

  /**
   * Data Lake Analytics account subscription ID (if different from Data Factory account). Type: string (or Expression with resultType string).
   */
  subscriptionId?: Record<unknown>;

  /**
   * Data Lake Analytics account resource group name (if different from Data Factory account). Type: string (or Expression with resultType string).
   */
  resourceGroupName?: Record<unknown>;

  /**
   * Azure Data Lake Analytics URI Type: string (or Expression with resultType string).
   */
  dataLakeAnalyticsUri?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Azure Databricks linked service.
 */
model AzureDatabricksLinkedService extends LinkedService {
  /**
   * Azure Databricks linked service properties.
   */
  typeProperties: AzureDatabricksLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureDatabricks";
}

/**
 * Azure Databricks linked service properties.
 */
model AzureDatabricksLinkedServiceTypeProperties {
  /**
   * <REGION>.azuredatabricks.net, domain name of your Databricks deployment. Type: string (or Expression with resultType string).
   */
  domain: Record<unknown>;

  /**
   * Access token for databricks REST API. Refer to https://docs.azuredatabricks.net/api/latest/authentication.html. Type: string (or Expression with resultType string).
   */
  accessToken?: SecretBase;

  /**
   * Required to specify MSI, if using Workspace resource id for databricks REST API. Type: string (or Expression with resultType string).
   */
  authentication?: Record<unknown>;

  /**
   * Workspace resource id for databricks REST API. Type: string (or Expression with resultType string).
   */
  workspaceResourceId?: Record<unknown>;

  /**
   * The id of an existing interactive cluster that will be used for all runs of this activity. Type: string (or Expression with resultType string).
   */
  existingClusterId?: Record<unknown>;

  /**
   * The id of an existing instance pool that will be used for all runs of this activity. Type: string (or Expression with resultType string).
   */
  instancePoolId?: Record<unknown>;

  /**
   * If not using an existing interactive cluster, this specifies the Spark version of a new job cluster or instance pool nodes created for each run of this activity. Required if instancePoolId is specified. Type: string (or Expression with resultType string).
   */
  newClusterVersion?: Record<unknown>;

  /**
   * If not using an existing interactive cluster, this specifies the number of worker nodes to use for the new job cluster or instance pool. For new job clusters, this a string-formatted Int32, like '1' means numOfWorker is 1 or '1:10' means auto-scale from 1 (min) to 10 (max). For instance pools, this is a string-formatted Int32, and can only specify a fixed number of worker nodes, such as '2'. Required if newClusterVersion is specified. Type: string (or Expression with resultType string).
   */
  newClusterNumOfWorker?: Record<unknown>;

  /**
   * The node type of the new job cluster. This property is required if newClusterVersion is specified and instancePoolId is not specified. If instancePoolId is specified, this property is ignored. Type: string (or Expression with resultType string).
   */
  newClusterNodeType?: Record<unknown>;

  /**
   * A set of optional, user-specified Spark configuration key-value pairs.
   */
  newClusterSparkConf?: Record<Record<unknown>>;

  /**
   * A set of optional, user-specified Spark environment variables key-value pairs.
   */
  newClusterSparkEnvVars?: Record<Record<unknown>>;

  /**
   * Additional tags for cluster resources. This property is ignored in instance pool configurations.
   */
  newClusterCustomTags?: Record<Record<unknown>>;

  /**
   * Specify a location to deliver Spark driver, worker, and event logs. Type: string (or Expression with resultType string).
   */
  newClusterLogDestination?: Record<unknown>;

  /**
   * The driver node type for the new job cluster. This property is ignored in instance pool configurations. Type: string (or Expression with resultType string).
   */
  newClusterDriverNodeType?: Record<unknown>;

  /**
   * User-defined initialization scripts for the new cluster. Type: array of strings (or Expression with resultType array of strings).
   */
  newClusterInitScripts?: Record<unknown>;

  /**
   * Enable the elastic disk on the new cluster. This property is now ignored, and takes the default elastic disk behavior in Databricks (elastic disks are always enabled). Type: boolean (or Expression with resultType boolean).
   */
  newClusterEnableElasticDisk?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * The policy id for limiting the ability to configure clusters based on a user defined set of rules. Type: string (or Expression with resultType string).
   */
  policyId?: Record<unknown>;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * Azure Databricks Delta Lake linked service.
 */
model AzureDatabricksDeltaLakeLinkedService extends LinkedService {
  /**
   * Azure Databricks Delta Lake linked service properties.
   */
  typeProperties: AzureDatabricksDetltaLakeLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureDatabricksDeltaLake";
}

/**
 * Azure Databricks Delta Lake linked service properties.
 */
model AzureDatabricksDetltaLakeLinkedServiceTypeProperties {
  /**
   * <REGION>.azuredatabricks.net, domain name of your Databricks deployment. Type: string (or Expression with resultType string).
   */
  domain: Record<unknown>;

  /**
   * Access token for databricks REST API. Refer to https://docs.azuredatabricks.net/api/latest/authentication.html. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  accessToken?: SecretBase;

  /**
   * The id of an existing interactive cluster that will be used for all runs of this job. Type: string (or Expression with resultType string).
   */
  clusterId?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;

  /**
   * Workspace resource id for databricks REST API. Type: string (or Expression with resultType string).
   */
  workspaceResourceId?: Record<unknown>;
}

/**
 * Responsys linked service.
 */
model ResponsysLinkedService extends LinkedService {
  /**
   * Responsys linked service properties.
   */
  typeProperties: ResponsysLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Responsys";
}

/**
 * Responsys linked service properties.
 */
model ResponsysLinkedServiceTypeProperties {
  /**
   * The endpoint of the Responsys server.
   */
  endpoint: Record<unknown>;

  /**
   * The client ID associated with the Responsys application. Type: string (or Expression with resultType string).
   */
  clientId: Record<unknown>;

  /**
   * The client secret associated with the Responsys application. Type: string (or Expression with resultType string).
   */
  clientSecret?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  useEncryptedEndpoints?: Record<unknown>;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  useHostVerification?: Record<unknown>;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  usePeerVerification?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Dynamics AX linked service.
 */
model DynamicsAXLinkedService extends LinkedService {
  /**
   * Dynamics AX linked service properties.
   */
  typeProperties: DynamicsAXLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "DynamicsAX";
}

/**
 * Dynamics AX linked service properties.
 */
model DynamicsAXLinkedServiceTypeProperties {
  /**
   * The Dynamics AX (or Dynamics 365 Finance and Operations) instance OData endpoint.
   */
  url: Record<unknown>;

  /**
   * Specify the application's client ID. Type: string (or Expression with resultType string).
   */
  servicePrincipalId: Record<unknown>;

  /**
   * Specify the application's key. Mark this field as a SecureString to store it securely in Data Factory, or reference a secret stored in Azure Key Vault. Type: string (or Expression with resultType string).
   */
  servicePrincipalKey: SecretBase;

  /**
   * Specify the tenant information (domain name or tenant ID) under which your application resides. Retrieve it by hovering the mouse in the top-right corner of the Azure portal. Type: string (or Expression with resultType string).
   */
  tenant: Record<unknown>;

  /**
   * Specify the resource you are requesting authorization. Type: string (or Expression with resultType string).
   */
  aadResourceId: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Oracle Service Cloud linked service.
 */
model OracleServiceCloudLinkedService extends LinkedService {
  /**
   * Oracle Service Cloud linked service properties.
   */
  typeProperties: OracleServiceCloudLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "OracleServiceCloud";
}

/**
 * Oracle Service Cloud linked service properties.
 */
model OracleServiceCloudLinkedServiceTypeProperties {
  /**
   * The URL of the Oracle Service Cloud instance.
   */
  host: Record<unknown>;

  /**
   * The user name that you use to access Oracle Service Cloud server.
   */
  username: Record<unknown>;

  /**
   * The password corresponding to the user name that you provided in the username key.
   */
  password: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  useEncryptedEndpoints?: Record<unknown>;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  useHostVerification?: Record<unknown>;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  usePeerVerification?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Google AdWords service linked service.
 */
model GoogleAdWordsLinkedService extends LinkedService {
  /**
   * Google AdWords service linked service properties.
   */
  typeProperties: GoogleAdWordsLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "GoogleAdWords";
}

/**
 * Google AdWords service linked service properties.
 */
model GoogleAdWordsLinkedServiceTypeProperties {
  /**
   * (Deprecated) Properties used to connect to GoogleAds. It is mutually exclusive with any other properties in the linked service. Type: object.
   */
  connectionProperties?: Record<unknown>;

  /**
   * The Client customer ID of the AdWords account that you want to fetch report data for. Type: string (or Expression with resultType string).
   */
  clientCustomerID?: Record<unknown>;

  /**
   * The developer token associated with the manager account that you use to grant access to the AdWords API.
   */
  developerToken?: SecretBase;

  /**
   * The OAuth 2.0 authentication mechanism used for authentication. ServiceAuthentication can only be used on self-hosted IR.
   */
  authenticationType?: GoogleAdWordsAuthenticationType;

  /**
   * The refresh token obtained from Google for authorizing access to AdWords for UserAuthentication.
   */
  refreshToken?: SecretBase;

  /**
   * The client id of the google application used to acquire the refresh token. Type: string (or Expression with resultType string).
   */
  clientId?: Record<unknown>;

  /**
   * The client secret of the google application used to acquire the refresh token.
   */
  clientSecret?: SecretBase;

  /**
   * The service account email ID that is used for ServiceAuthentication and can only be used on self-hosted IR. Type: string (or Expression with resultType string).
   */
  email?: Record<unknown>;

  /**
   * (Deprecated) The full path to the .p12 key file that is used to authenticate the service account email address and can only be used on self-hosted IR. Type: string (or Expression with resultType string).
   */
  keyFilePath?: Record<unknown>;

  /**
   * (Deprecated) The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR. Type: string (or Expression with resultType string).
   */
  trustedCertPath?: Record<unknown>;

  /**
   * (Deprecated) Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false. Type: boolean (or Expression with resultType boolean).
   */
  useSystemTrustStore?: Record<unknown>;

  /**
   * The private key that is used to authenticate the service account email address and can only be used on self-hosted IR.
   */
  privateKey?: SecretBase;

  /**
   * The customer ID of the Google Ads Manager account through which you want to fetch report data of specific Customer. Type: string (or Expression with resultType string).
   */
  loginCustomerID?: Record<unknown>;

  /**
   * The Google Ads API major version such as v14. The supported major versions could be found on https://developers.google.com/google-ads/api/docs/release-notes. Type: string (or Expression with resultType string).
   */
  googleAdsApiVersion?: Record<unknown>;

  /**
   * Specifies whether to use the legacy data type mappings, which maps float, int32 and int64 from Google to string. Do not set this to true unless you want to keep backward compatibility with legacy driver's data type mappings. Type: boolean (or Expression with resultType boolean).
   */
  supportLegacyDataTypes?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * SAP Table Linked Service.
 */
model SapTableLinkedService extends LinkedService {
  /**
   * Properties specific to this linked service type.
   */
  typeProperties: SapTableLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "SapTable";
}

/**
 * Properties specific to this linked service type.
 */
model SapTableLinkedServiceTypeProperties {
  /**
   * Host name of the SAP instance where the table is located. Type: string (or Expression with resultType string).
   */
  server?: Record<unknown>;

  /**
   * System number of the SAP system where the table is located. (Usually a two-digit decimal number represented as a string.) Type: string (or Expression with resultType string).
   */
  systemNumber?: Record<unknown>;

  /**
   * Client ID of the client on the SAP system where the table is located. (Usually a three-digit decimal number represented as a string) Type: string (or Expression with resultType string).
   */
  clientId?: Record<unknown>;

  /**
   * Language of the SAP system where the table is located. The default value is EN. Type: string (or Expression with resultType string).
   */
  language?: Record<unknown>;

  /**
   * SystemID of the SAP system where the table is located. Type: string (or Expression with resultType string).
   */
  systemId?: Record<unknown>;

  /**
   * Username to access the SAP server where the table is located. Type: string (or Expression with resultType string).
   */
  userName?: Record<unknown>;

  /**
   * Password to access the SAP server where the table is located.
   */
  password?: SecretBase;

  /**
   * The hostname of the SAP Message Server. Type: string (or Expression with resultType string).
   */
  messageServer?: Record<unknown>;

  /**
   * The service name or port number of the Message Server. Type: string (or Expression with resultType string).
   */
  messageServerService?: Record<unknown>;

  /**
   * SNC activation indicator to access the SAP server where the table is located. Must be either 0 (off) or 1 (on). Type: string (or Expression with resultType string).
   */
  sncMode?: Record<unknown>;

  /**
   * Initiator's SNC name to access the SAP server where the table is located. Type: string (or Expression with resultType string).
   */
  sncMyName?: Record<unknown>;

  /**
   * Communication partner's SNC name to access the SAP server where the table is located. Type: string (or Expression with resultType string).
   */
  sncPartnerName?: Record<unknown>;

  /**
   * External security product's library to access the SAP server where the table is located. Type: string (or Expression with resultType string).
   */
  sncLibraryPath?: Record<unknown>;

  /**
   * SNC Quality of Protection. Allowed value include: 1, 2, 3, 8, 9. Type: string (or Expression with resultType string).
   */
  sncQop?: Record<unknown>;

  /**
   * The Logon Group for the SAP System. Type: string (or Expression with resultType string).
   */
  logonGroup?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Azure Data Explorer (Kusto) linked service.
 */
model AzureDataExplorerLinkedService extends LinkedService {
  /**
   * Azure Data Explorer (Kusto) linked service properties.
   */
  typeProperties: AzureDataExplorerLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureDataExplorer";
}

/**
 * Azure Data Explorer (Kusto) linked service properties.
 */
model AzureDataExplorerLinkedServiceTypeProperties {
  /**
   * The endpoint of Azure Data Explorer (the engine's endpoint). URL will be in the format https://<clusterName>.<regionName>.kusto.windows.net. Type: string (or Expression with resultType string)
   */
  endpoint: Record<unknown>;

  /**
   * The ID of the service principal used to authenticate against Azure Data Explorer. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The key of the service principal used to authenticate against Kusto.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * Database name for connection. Type: string (or Expression with resultType string).
   */
  database: Record<unknown>;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  tenant?: Record<unknown>;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * Azure Function linked service.
 */
model AzureFunctionLinkedService extends LinkedService {
  /**
   * Azure Function linked service properties.
   */
  typeProperties: AzureFunctionLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureFunction";
}

/**
 * Azure Function linked service properties.
 */
model AzureFunctionLinkedServiceTypeProperties {
  /**
   * The endpoint of the Azure Function App. URL will be in the format https://<accountName>.azurewebsites.net.
   */
  functionAppUrl: Record<unknown>;

  /**
   * Function or Host key for Azure Function App.
   */
  functionKey?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;

  /**
   * Allowed token audiences for azure function.
   */
  resourceId?: Record<unknown>;

  /**
   * Type of authentication (Required to specify MSI) used to connect to AzureFunction. Type: string (or Expression with resultType string).
   */
  authentication?: Record<unknown>;
}

/**
 * Snowflake linked service.
 */
model SnowflakeLinkedService extends LinkedService {
  /**
   * Snowflake linked service properties.
   */
  typeProperties: SnowflakeLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Snowflake";
}

/**
 * Snowflake linked service properties.
 */
model SnowflakeLinkedServiceTypeProperties {
  /**
   * The connection string of snowflake. Type: string, SecureString.
   */
  connectionString: Record<unknown>;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * SharePoint Online List linked service.
 */
model SharePointOnlineListLinkedService extends LinkedService {
  /**
   * SharePoint Online List linked service properties.
   */
  typeProperties: SharePointOnlineListLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "SharePointOnlineList";
}

/**
 * SharePoint Online List linked service properties.
 */
model SharePointOnlineListLinkedServiceTypeProperties {
  /**
   * The URL of the SharePoint Online site. For example, https://contoso.sharepoint.com/sites/siteName. Type: string (or Expression with resultType string).
   */
  siteUrl: Record<unknown>;

  /**
   * The tenant ID under which your application resides. You can find it from Azure portal Active Directory overview page. Type: string (or Expression with resultType string).
   */
  tenantId: Record<unknown>;

  /**
   * The application (client) ID of your application registered in Azure Active Directory. Make sure to grant SharePoint site permission to this application. Type: string (or Expression with resultType string).
   */
  servicePrincipalId: Record<unknown>;

  /**
   * The client secret of your application registered in Azure Active Directory. Type: string (or Expression with resultType string).
   */
  servicePrincipalKey: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;
}

/**
 * Azure Synapse Analytics (Artifacts) linked service.
 */
model AzureSynapseArtifactsLinkedService extends LinkedService {
  /**
   * Azure Synapse Analytics (Artifacts) linked service properties.
   */
  typeProperties: AzureSynapseArtifactsLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureSynapseArtifacts";
}

/**
 * Azure Synapse Analytics (Artifacts) linked service properties.
 */
model AzureSynapseArtifactsLinkedServiceTypeProperties {
  /**
   * https://<workspacename>.dev.azuresynapse.net, Azure Synapse Analytics workspace URL. Type: string (or Expression with resultType string).
   */
  endpoint: Record<unknown>;

  /**
   * Required to specify MSI, if using system assigned managed identity as authentication method. Type: string (or Expression with resultType string).
   */
  authentication?: Record<unknown>;

  /**
   * The resource ID of the Synapse workspace. The format should be: /subscriptions/{subscriptionID}/resourceGroups/{resourceGroup}/providers/Microsoft.Synapse/workspaces/{workspaceName}. Type: string (or Expression with resultType string).
   */
  workspaceResourceId?: Record<unknown>;
}

/**
 * Microsoft Fabric LakeHouse linked service.
 */
model LakeHouseLinkedService extends LinkedService {
  /**
   * Microsoft Fabric LakeHouse linked service properties.
   */
  typeProperties: LakeHouseLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "LakeHouse";
}

/**
 * Microsoft Fabric LakeHouse linked service properties.
 */
model LakeHouseLinkedServiceTypeProperties {
  /**
   * The ID of Microsoft Fabric workspace. Type: string (or Expression with resultType string).
   */
  workspaceId?: Record<unknown>;

  /**
   * The ID of Microsoft Fabric LakeHouse artifact. Type: string (or Expression with resultType string).
   */
  artifactId?: Record<unknown>;

  /**
   * The ID of the application used to authenticate against Microsoft Fabric LakeHouse. Type: string (or Expression with resultType string).
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The Key of the application used to authenticate against Microsoft Fabric LakeHouse.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  tenant?: Record<unknown>;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  encryptedCredential?: string;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).
   */
  servicePrincipalCredentialType?: Record<unknown>;

  /**
   * The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.
   */
  servicePrincipalCredential?: SecretBase;
}

/**
 * Base class for all control activities like IfCondition, ForEach , Until.
 */
@discriminator("type")
model ControlActivity extends Activity {}

/**
 * Base class for all execution activities.
 */
@discriminator("type")
model ExecutionActivity extends Activity {
  /**
   * Linked service reference.
   */
  linkedServiceName?: LinkedServiceReference;

  /**
   * Activity policy.
   */
  policy?: ActivityPolicy;
}

/**
 * Execution policy for an activity.
 */
model ActivityPolicy extends Record<Record<unknown>> {
  /**
   * Specifies the timeout for the activity to run. The default timeout is 7 days. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  timeout?: Record<unknown>;

  /**
   * Maximum ordinary retry attempts. Default is 0. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  retry?: Record<unknown>;

  /**
   * Interval between each retry attempt (in seconds). The default is 30 sec.
   */
  @maxValue(86400)
  @minValue(30)
  retryIntervalInSeconds?: int32;

  /**
   * When set to true, Input from activity is considered as secure and will not be logged to monitoring.
   */
  secureInput?: boolean;

  /**
   * When set to true, Output from activity is considered as secure and will not be logged to monitoring.
   */
  secureOutput?: boolean;
}

/**
 * Connector read setting.
 */
@discriminator("type")
model StoreReadSettings extends Record<Record<unknown>> {
  /**
   * The maximum concurrent connection count for the source data store. Type: integer (or Expression with resultType integer).
   */
  maxConcurrentConnections?: Record<unknown>;

  /**
   * If true, disable data store metrics collection. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  disableMetricsCollection?: Record<unknown>;
}

/**
 * Azure blob read settings.
 */
model AzureBlobStorageReadSettings extends StoreReadSettings {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * Azure blob wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  wildcardFolderPath?: Record<unknown>;

  /**
   * Azure blob wildcardFileName. Type: string (or Expression with resultType string).
   */
  wildcardFileName?: Record<unknown>;

  /**
   * The prefix filter for the Azure Blob name. Type: string (or Expression with resultType string).
   */
  prefix?: Record<unknown>;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  fileListPath?: Record<unknown>;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  enablePartitionDiscovery?: Record<unknown>;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  partitionRootPath?: Record<unknown>;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  deleteFilesAfterCompletion?: Record<unknown>;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeStart?: Record<unknown>;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeEnd?: Record<unknown>;

  /**
   * The read setting type.
   */
  type: "AzureBlobStorageReadSettings";
}

/**
 * Azure blobFS read settings.
 */
model AzureBlobFSReadSettings extends StoreReadSettings {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * Azure blobFS wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  wildcardFolderPath?: Record<unknown>;

  /**
   * Azure blobFS wildcardFileName. Type: string (or Expression with resultType string).
   */
  wildcardFileName?: Record<unknown>;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  fileListPath?: Record<unknown>;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  enablePartitionDiscovery?: Record<unknown>;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  partitionRootPath?: Record<unknown>;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  deleteFilesAfterCompletion?: Record<unknown>;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeStart?: Record<unknown>;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeEnd?: Record<unknown>;

  /**
   * The read setting type.
   */
  type: "AzureBlobFSReadSettings";
}

/**
 * Azure data lake store read settings.
 */
model AzureDataLakeStoreReadSettings extends StoreReadSettings {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * ADLS wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  wildcardFolderPath?: Record<unknown>;

  /**
   * ADLS wildcardFileName. Type: string (or Expression with resultType string).
   */
  wildcardFileName?: Record<unknown>;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  fileListPath?: Record<unknown>;

  /**
   * Lists files after the value (exclusive) based on file/folder names’ lexicographical order. Applies under the folderPath in data set, and filter files/sub-folders under the folderPath. Type: string (or Expression with resultType string).
   */
  listAfter?: Record<unknown>;

  /**
   * Lists files before the value (inclusive) based on file/folder names’ lexicographical order. Applies under the folderPath in data set, and filter files/sub-folders under the folderPath. Type: string (or Expression with resultType string).
   */
  listBefore?: Record<unknown>;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  enablePartitionDiscovery?: Record<unknown>;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  partitionRootPath?: Record<unknown>;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  deleteFilesAfterCompletion?: Record<unknown>;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeStart?: Record<unknown>;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeEnd?: Record<unknown>;

  /**
   * The read setting type.
   */
  type: "AzureDataLakeStoreReadSettings";
}

/**
 * Amazon S3 read settings.
 */
model AmazonS3ReadSettings extends StoreReadSettings {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * AmazonS3 wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  wildcardFolderPath?: Record<unknown>;

  /**
   * AmazonS3 wildcardFileName. Type: string (or Expression with resultType string).
   */
  wildcardFileName?: Record<unknown>;

  /**
   * The prefix filter for the S3 object name. Type: string (or Expression with resultType string).
   */
  prefix?: Record<unknown>;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  fileListPath?: Record<unknown>;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  enablePartitionDiscovery?: Record<unknown>;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  partitionRootPath?: Record<unknown>;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  deleteFilesAfterCompletion?: Record<unknown>;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeStart?: Record<unknown>;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeEnd?: Record<unknown>;

  /**
   * The read setting type.
   */
  type: "AmazonS3ReadSettings";
}

/**
 * File server read settings.
 */
model FileServerReadSettings extends StoreReadSettings {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * FileServer wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  wildcardFolderPath?: Record<unknown>;

  /**
   * FileServer wildcardFileName. Type: string (or Expression with resultType string).
   */
  wildcardFileName?: Record<unknown>;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  fileListPath?: Record<unknown>;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  enablePartitionDiscovery?: Record<unknown>;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  partitionRootPath?: Record<unknown>;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  deleteFilesAfterCompletion?: Record<unknown>;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeStart?: Record<unknown>;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeEnd?: Record<unknown>;

  /**
   * Specify a filter to be used to select a subset of files in the folderPath rather than all files. Type: string (or Expression with resultType string).
   */
  fileFilter?: Record<unknown>;

  /**
   * The read setting type.
   */
  type: "FileServerReadSettings";
}

/**
 * Azure File Storage read settings.
 */
model AzureFileStorageReadSettings extends StoreReadSettings {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * Azure File Storage wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  wildcardFolderPath?: Record<unknown>;

  /**
   * Azure File Storage wildcardFileName. Type: string (or Expression with resultType string).
   */
  wildcardFileName?: Record<unknown>;

  /**
   * The prefix filter for the Azure File name starting from root path. Type: string (or Expression with resultType string).
   */
  prefix?: Record<unknown>;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  fileListPath?: Record<unknown>;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  enablePartitionDiscovery?: Record<unknown>;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  partitionRootPath?: Record<unknown>;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  deleteFilesAfterCompletion?: Record<unknown>;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeStart?: Record<unknown>;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeEnd?: Record<unknown>;

  /**
   * The read setting type.
   */
  type: "AzureFileStorageReadSettings";
}

/**
 * Sftp write settings.
 */
model SftpWriteSettings extends StoreWriteSettings {
  /**
   * Specifies the timeout for writing each chunk to SFTP server. Default value: 01:00:00 (one hour). Type: string (or Expression with resultType string).
   */
  operationTimeout?: Record<unknown>;

  /**
   * Upload to temporary file(s) and rename. Disable this option if your SFTP server doesn't support rename operation. Type: boolean (or Expression with resultType boolean).
   */
  useTempFileRename?: Record<unknown>;

  /**
   * The write setting type.
   */
  type: "SftpWriteSettings";
}

/**
 * Connector write settings.
 */
@discriminator("type")
model StoreWriteSettings extends Record<Record<unknown>> {
  /**
   * The maximum concurrent connection count for the source data store. Type: integer (or Expression with resultType integer).
   */
  maxConcurrentConnections?: Record<unknown>;

  /**
   * If true, disable data store metrics collection. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  disableMetricsCollection?: Record<unknown>;

  /**
   * The type of copy behavior for copy sink.
   */
  copyBehavior?: Record<unknown>;
}

/**
 * Amazon S3 Compatible read settings.
 */
model AmazonS3CompatibleReadSettings extends StoreReadSettings {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * Amazon S3 Compatible wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  wildcardFolderPath?: Record<unknown>;

  /**
   * Amazon S3 Compatible wildcardFileName. Type: string (or Expression with resultType string).
   */
  wildcardFileName?: Record<unknown>;

  /**
   * The prefix filter for the S3 Compatible object name. Type: string (or Expression with resultType string).
   */
  prefix?: Record<unknown>;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  fileListPath?: Record<unknown>;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  enablePartitionDiscovery?: Record<unknown>;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  partitionRootPath?: Record<unknown>;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  deleteFilesAfterCompletion?: Record<unknown>;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeStart?: Record<unknown>;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeEnd?: Record<unknown>;

  /**
   * The read setting type.
   */
  type: "AmazonS3CompatibleReadSettings";
}

/**
 * Oracle Cloud Storage read settings.
 */
model OracleCloudStorageReadSettings extends StoreReadSettings {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * Oracle Cloud Storage wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  wildcardFolderPath?: Record<unknown>;

  /**
   * Oracle Cloud Storage wildcardFileName. Type: string (or Expression with resultType string).
   */
  wildcardFileName?: Record<unknown>;

  /**
   * The prefix filter for the Oracle Cloud Storage object name. Type: string (or Expression with resultType string).
   */
  prefix?: Record<unknown>;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  fileListPath?: Record<unknown>;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  enablePartitionDiscovery?: Record<unknown>;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  partitionRootPath?: Record<unknown>;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  deleteFilesAfterCompletion?: Record<unknown>;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeStart?: Record<unknown>;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeEnd?: Record<unknown>;

  /**
   * The read setting type.
   */
  type: "OracleCloudStorageReadSettings";
}

/**
 * Google Cloud Storage read settings.
 */
model GoogleCloudStorageReadSettings extends StoreReadSettings {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * Google Cloud Storage wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  wildcardFolderPath?: Record<unknown>;

  /**
   * Google Cloud Storage wildcardFileName. Type: string (or Expression with resultType string).
   */
  wildcardFileName?: Record<unknown>;

  /**
   * The prefix filter for the Google Cloud Storage object name. Type: string (or Expression with resultType string).
   */
  prefix?: Record<unknown>;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  fileListPath?: Record<unknown>;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  enablePartitionDiscovery?: Record<unknown>;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  partitionRootPath?: Record<unknown>;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  deleteFilesAfterCompletion?: Record<unknown>;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeStart?: Record<unknown>;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeEnd?: Record<unknown>;

  /**
   * The read setting type.
   */
  type: "GoogleCloudStorageReadSettings";
}

/**
 * Ftp read settings.
 */
model FtpReadSettings extends StoreReadSettings {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * Ftp wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  wildcardFolderPath?: Record<unknown>;

  /**
   * Ftp wildcardFileName. Type: string (or Expression with resultType string).
   */
  wildcardFileName?: Record<unknown>;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  enablePartitionDiscovery?: Record<unknown>;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  partitionRootPath?: Record<unknown>;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  deleteFilesAfterCompletion?: Record<unknown>;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  fileListPath?: Record<unknown>;

  /**
   * Specify whether to use binary transfer mode for FTP stores. Type: boolean (or Expression with resultType boolean).
   */
  useBinaryTransfer?: Record<unknown>;

  /**
   * If true, disable parallel reading within each file. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  disableChunking?: Record<unknown>;

  /**
   * The read setting type.
   */
  type: "FtpReadSettings";
}

/**
 * Sftp read settings.
 */
model SftpReadSettings extends StoreReadSettings {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * Sftp wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  wildcardFolderPath?: Record<unknown>;

  /**
   * Sftp wildcardFileName. Type: string (or Expression with resultType string).
   */
  wildcardFileName?: Record<unknown>;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  enablePartitionDiscovery?: Record<unknown>;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  partitionRootPath?: Record<unknown>;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  fileListPath?: Record<unknown>;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  deleteFilesAfterCompletion?: Record<unknown>;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeStart?: Record<unknown>;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeEnd?: Record<unknown>;

  /**
   * If true, disable parallel reading within each file. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  disableChunking?: Record<unknown>;

  /**
   * The read setting type.
   */
  type: "SftpReadSettings";
}

/**
 * Http read settings.
 */
model HttpReadSettings extends StoreReadSettings {
  /**
   * The HTTP method used to call the RESTful API. The default is GET. Type: string (or Expression with resultType string).
   */
  requestMethod?: Record<unknown>;

  /**
   * The HTTP request body to the RESTful API if requestMethod is POST. Type: string (or Expression with resultType string).
   */
  requestBody?: Record<unknown>;

  /**
   * The additional HTTP headers in the request to the RESTful API. Type: string (or Expression with resultType string).
   */
  additionalHeaders?: Record<unknown>;

  /**
   * Specifies the timeout for a HTTP client to get HTTP response from HTTP server. Type: string (or Expression with resultType string).
   */
  requestTimeout?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * The read setting type.
   */
  type: "HttpReadSettings";
}

/**
 * HDFS read settings.
 */
model HdfsReadSettings extends StoreReadSettings {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * HDFS wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  wildcardFolderPath?: Record<unknown>;

  /**
   * HDFS wildcardFileName. Type: string (or Expression with resultType string).
   */
  wildcardFileName?: Record<unknown>;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  fileListPath?: Record<unknown>;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  enablePartitionDiscovery?: Record<unknown>;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  partitionRootPath?: Record<unknown>;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeStart?: Record<unknown>;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeEnd?: Record<unknown>;

  /**
   * Specifies Distcp-related settings.
   */
  distcpSettings?: DistcpSettings;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  deleteFilesAfterCompletion?: Record<unknown>;

  /**
   * The read setting type.
   */
  type: "HdfsReadSettings";
}

/**
 * Distcp settings.
 */
model DistcpSettings {
  /**
   * Specifies the Yarn ResourceManager endpoint. Type: string (or Expression with resultType string).
   */
  resourceManagerEndpoint: Record<unknown>;

  /**
   * Specifies an existing folder path which will be used to store temp Distcp command script. The script file is generated by ADF and will be removed after Copy job finished. Type: string (or Expression with resultType string).
   */
  tempScriptPath: Record<unknown>;

  /**
   * Specifies the Distcp options. Type: string (or Expression with resultType string).
   */
  distcpOptions?: Record<unknown>;
}

/**
 * Microsoft Fabric LakeHouse Files read settings.
 */
model LakeHouseReadSettings extends StoreReadSettings {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * Microsoft Fabric LakeHouse Files wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  wildcardFolderPath?: Record<unknown>;

  /**
   * Microsoft Fabric LakeHouse Files wildcardFileName. Type: string (or Expression with resultType string).
   */
  wildcardFileName?: Record<unknown>;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  fileListPath?: Record<unknown>;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  enablePartitionDiscovery?: Record<unknown>;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  partitionRootPath?: Record<unknown>;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  deleteFilesAfterCompletion?: Record<unknown>;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeStart?: Record<unknown>;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  modifiedDatetimeEnd?: Record<unknown>;

  /**
   * The read setting type.
   */
  type: "LakeHouseReadSettings";
}

/**
 * Azure blob write settings.
 */
model AzureBlobStorageWriteSettings extends StoreWriteSettings {
  /**
   * Indicates the block size(MB) when writing data to blob. Type: integer (or Expression with resultType integer).
   */
  blockSizeInMB?: Record<unknown>;

  /**
   * The write setting type.
   */
  type: "AzureBlobStorageWriteSettings";
}

/**
 * Azure blobFS write settings.
 */
model AzureBlobFSWriteSettings extends StoreWriteSettings {
  /**
   * Indicates the block size(MB) when writing data to blob. Type: integer (or Expression with resultType integer).
   */
  blockSizeInMB?: Record<unknown>;

  /**
   * The write setting type.
   */
  type: "AzureBlobFSWriteSettings";
}

/**
 * Azure data lake store write settings.
 */
model AzureDataLakeStoreWriteSettings extends StoreWriteSettings {
  /**
   * Specifies the expiry time of the written files. The time is applied to the UTC time zone in the format of "2018-12-01T05:00:00Z". Default value is NULL. Type: string (or Expression with resultType string).
   */
  expiryDateTime?: Record<unknown>;

  /**
   * The write setting type.
   */
  type: "AzureDataLakeStoreWriteSettings";
}

/**
 * File server write settings.
 */
model FileServerWriteSettings extends StoreWriteSettings {
  /**
   * The write setting type.
   */
  type: "FileServerWriteSettings";
}

/**
 * Azure File Storage write settings.
 */
model AzureFileStorageWriteSettings extends StoreWriteSettings {
  /**
   * The write setting type.
   */
  type: "AzureFileStorageWriteSettings";
}

/**
 * Microsoft Fabric LakeHouse Files write settings.
 */
model LakeHouseWriteSettings extends StoreWriteSettings {
  /**
   * The write setting type.
   */
  type: "LakeHouseWriteSettings";
}

/**
 * Format read settings.
 */
@discriminator("type")
model FormatReadSettings extends Record<Record<unknown>> {}

/**
 * Compression read settings.
 */
@discriminator("type")
model CompressionReadSettings extends Record<Record<unknown>> {}

/**
 * The ZipDeflate compression read settings.
 */
model ZipDeflateReadSettings extends CompressionReadSettings {
  /**
   * Preserve the zip file name as folder path. Type: boolean (or Expression with resultType boolean).
   */
  preserveZipFileNameAsFolder?: Record<unknown>;

  /**
   * The Compression setting type.
   */
  type: "ZipDeflateReadSettings";
}

/**
 * The Tar compression read settings.
 */
model TarReadSettings extends CompressionReadSettings {
  /**
   * Preserve the compression file name as folder path. Type: boolean (or Expression with resultType boolean).
   */
  preserveCompressionFileNameAsFolder?: Record<unknown>;

  /**
   * The Compression setting type.
   */
  type: "TarReadSettings";
}

/**
 * The TarGZip compression read settings.
 */
model TarGZipReadSettings extends CompressionReadSettings {
  /**
   * Preserve the compression file name as folder path. Type: boolean (or Expression with resultType boolean).
   */
  preserveCompressionFileNameAsFolder?: Record<unknown>;

  /**
   * The Compression setting type.
   */
  type: "TarGZipReadSettings";
}

/**
 * Parquet read settings.
 */
model ParquetReadSettings extends FormatReadSettings {
  /**
   * Compression settings.
   */
  compressionProperties?: CompressionReadSettings;

  /**
   * The read setting type.
   */
  type: "ParquetReadSettings";
}

/**
 * Delimited text read settings.
 */
model DelimitedTextReadSettings extends FormatReadSettings {
  /**
   * Indicates the number of non-empty rows to skip when reading data from input files. Type: integer (or Expression with resultType integer).
   */
  skipLineCount?: Record<unknown>;

  /**
   * Compression settings.
   */
  compressionProperties?: CompressionReadSettings;

  /**
   * The read setting type.
   */
  type: "DelimitedTextReadSettings";
}

/**
 * Json read settings.
 */
model JsonReadSettings extends FormatReadSettings {
  /**
   * Compression settings.
   */
  compressionProperties?: CompressionReadSettings;

  /**
   * The read setting type.
   */
  type: "JsonReadSettings";
}

/**
 * Xml read settings.
 */
model XmlReadSettings extends FormatReadSettings {
  /**
   * Compression settings.
   */
  compressionProperties?: CompressionReadSettings;

  /**
   * Indicates what validation method is used when reading the xml files. Allowed values: 'none', 'xsd', or 'dtd'. Type: string (or Expression with resultType string).
   */
  validationMode?: Record<unknown>;

  /**
   * Indicates whether type detection is enabled when reading the xml files. Type: boolean (or Expression with resultType boolean).
   */
  detectDataType?: Record<unknown>;

  /**
   * Indicates whether namespace is enabled when reading the xml files. Type: boolean (or Expression with resultType boolean).
   */
  namespaces?: Record<unknown>;

  /**
   * Namespace uri to prefix mappings to override the prefixes in column names when namespace is enabled, if no prefix is defined for a namespace uri, the prefix of xml element/attribute name in the xml data file will be used. Example: "{"http://www.example.com/xml":"prefix"}" Type: object (or Expression with resultType object).
   */
  namespacePrefixes?: Record<unknown>;

  /**
   * The read setting type.
   */
  type: "XmlReadSettings";
}

/**
 * Binary read settings.
 */
model BinaryReadSettings extends FormatReadSettings {
  /**
   * Compression settings.
   */
  compressionProperties?: CompressionReadSettings;

  /**
   * The read setting type.
   */
  type: "BinaryReadSettings";
}

/**
 * Format write settings.
 */
@discriminator("type")
model FormatWriteSettings extends Record<Record<unknown>> {}

/**
 * Avro write settings.
 */
model AvroWriteSettings extends FormatWriteSettings {
  /**
   * Top level record name in write result, which is required in AVRO spec.
   */
  recordName?: string;

  /**
   * Record namespace in the write result.
   */
  recordNamespace?: string;

  /**
   * Limit the written file's row count to be smaller than or equal to the specified count. Type: integer (or Expression with resultType integer).
   */
  maxRowsPerFile?: Record<unknown>;

  /**
   * Specifies the file name pattern <fileNamePrefix>_<fileIndex>.<fileExtension> when copy from non-file based store without partitionOptions. Type: string (or Expression with resultType string).
   */
  fileNamePrefix?: Record<unknown>;

  /**
   * The write setting type.
   */
  type: "AvroWriteSettings";
}

/**
 * Orc write settings.
 */
model OrcWriteSettings extends FormatWriteSettings {
  /**
   * Limit the written file's row count to be smaller than or equal to the specified count. Type: integer (or Expression with resultType integer).
   */
  maxRowsPerFile?: Record<unknown>;

  /**
   * Specifies the file name pattern <fileNamePrefix>_<fileIndex>.<fileExtension> when copy from non-file based store without partitionOptions. Type: string (or Expression with resultType string).
   */
  fileNamePrefix?: Record<unknown>;

  /**
   * The write setting type.
   */
  type: "OrcWriteSettings";
}

/**
 * Parquet write settings.
 */
model ParquetWriteSettings extends FormatWriteSettings {
  /**
   * Limit the written file's row count to be smaller than or equal to the specified count. Type: integer (or Expression with resultType integer).
   */
  maxRowsPerFile?: Record<unknown>;

  /**
   * Specifies the file name pattern <fileNamePrefix>_<fileIndex>.<fileExtension> when copy from non-file based store without partitionOptions. Type: string (or Expression with resultType string).
   */
  fileNamePrefix?: Record<unknown>;

  /**
   * The write setting type.
   */
  type: "ParquetWriteSettings";
}

/**
 * Delimited text write settings.
 */
model DelimitedTextWriteSettings extends FormatWriteSettings {
  /**
   * Indicates whether string values should always be enclosed with quotes. Type: boolean (or Expression with resultType boolean).
   */
  quoteAllText?: Record<unknown>;

  /**
   * The file extension used to create the files. Type: string (or Expression with resultType string).
   */
  fileExtension: Record<unknown>;

  /**
   * Limit the written file's row count to be smaller than or equal to the specified count. Type: integer (or Expression with resultType integer).
   */
  maxRowsPerFile?: Record<unknown>;

  /**
   * Specifies the file name pattern <fileNamePrefix>_<fileIndex>.<fileExtension> when copy from non-file based store without partitionOptions. Type: string (or Expression with resultType string).
   */
  fileNamePrefix?: Record<unknown>;

  /**
   * The write setting type.
   */
  type: "DelimitedTextWriteSettings";
}

/**
 * Json write settings.
 */
model JsonWriteSettings extends FormatWriteSettings {
  /**
   * File pattern of JSON. This setting controls the way a collection of JSON objects will be treated. The default value is 'setOfObjects'. It is case-sensitive.
   */
  filePattern?: Record<unknown>;

  /**
   * The write setting type.
   */
  type: "JsonWriteSettings";
}

/**
 * A copy activity Avro source.
 */
model AvroSource extends CopySource {
  /**
   * Avro store settings.
   */
  storeSettings?: StoreReadSettings;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "AvroSource";
}

/**
 * A copy activity source.
 */
@discriminator("type")
model CopySource extends Record<Record<unknown>> {
  /**
   * Source retry count. Type: integer (or Expression with resultType integer).
   */
  sourceRetryCount?: Record<unknown>;

  /**
   * Source retry wait. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  sourceRetryWait?: Record<unknown>;

  /**
   * The maximum concurrent connection count for the source data store. Type: integer (or Expression with resultType integer).
   */
  maxConcurrentConnections?: Record<unknown>;

  /**
   * If true, disable data store metrics collection. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  disableMetricsCollection?: Record<unknown>;
}

/**
 * A copy activity excel source.
 */
model ExcelSource extends CopySource {
  /**
   * Excel store settings.
   */
  storeSettings?: StoreReadSettings;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "ExcelSource";
}

/**
 * A copy activity Parquet source.
 */
model ParquetSource extends CopySource {
  /**
   * Parquet store settings.
   */
  storeSettings?: StoreReadSettings;

  /**
   * Parquet format settings.
   */
  formatSettings?: ParquetReadSettings;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "ParquetSource";
}

/**
 * A copy activity DelimitedText source.
 */
model DelimitedTextSource extends CopySource {
  /**
   * DelimitedText store settings.
   */
  storeSettings?: StoreReadSettings;

  /**
   * DelimitedText format settings.
   */
  formatSettings?: DelimitedTextReadSettings;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "DelimitedTextSource";
}

/**
 * A copy activity Json source.
 */
model JsonSource extends CopySource {
  /**
   * Json store settings.
   */
  storeSettings?: StoreReadSettings;

  /**
   * Json format settings.
   */
  formatSettings?: JsonReadSettings;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "JsonSource";
}

/**
 * A copy activity Xml source.
 */
model XmlSource extends CopySource {
  /**
   * Xml store settings.
   */
  storeSettings?: StoreReadSettings;

  /**
   * Xml format settings.
   */
  formatSettings?: XmlReadSettings;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "XmlSource";
}

/**
 * A copy activity ORC source.
 */
model OrcSource extends CopySource {
  /**
   * ORC store settings.
   */
  storeSettings?: StoreReadSettings;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "OrcSource";
}

/**
 * A copy activity DelimitedText sink.
 */
model DelimitedTextSink extends CopySink {
  /**
   * DelimitedText store settings.
   */
  storeSettings?: StoreWriteSettings;

  /**
   * DelimitedText format settings.
   */
  formatSettings?: DelimitedTextWriteSettings;

  /**
   * Copy sink type.
   */
  type: "DelimitedTextSink";
}

/**
 * A copy activity sink.
 */
@discriminator("type")
model CopySink extends Record<Record<unknown>> {
  /**
   * Write batch size. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  writeBatchSize?: Record<unknown>;

  /**
   * Write batch timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  writeBatchTimeout?: Record<unknown>;

  /**
   * Sink retry count. Type: integer (or Expression with resultType integer).
   */
  sinkRetryCount?: Record<unknown>;

  /**
   * Sink retry wait. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  sinkRetryWait?: Record<unknown>;

  /**
   * The maximum concurrent connection count for the sink data store. Type: integer (or Expression with resultType integer).
   */
  maxConcurrentConnections?: Record<unknown>;

  /**
   * If true, disable data store metrics collection. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  disableMetricsCollection?: Record<unknown>;
}

/**
 * A copy activity Json sink.
 */
model JsonSink extends CopySink {
  /**
   * Json store settings.
   */
  storeSettings?: StoreWriteSettings;

  /**
   * Json format settings.
   */
  formatSettings?: JsonWriteSettings;

  /**
   * Copy sink type.
   */
  type: "JsonSink";
}

/**
 * A copy activity ORC sink.
 */
model OrcSink extends CopySink {
  /**
   * ORC store settings.
   */
  storeSettings?: StoreWriteSettings;

  /**
   * ORC format settings.
   */
  formatSettings?: OrcWriteSettings;

  /**
   * Copy sink type.
   */
  type: "OrcSink";
}

/**
 * Copy activity.
 */
model CopyActivity extends ExecutionActivity {
  /**
   * Copy activity properties.
   */
  typeProperties: CopyActivityTypeProperties;

  /**
   * List of inputs for the activity.
   */
  inputs?: DatasetReference[];

  /**
   * List of outputs for the activity.
   */
  outputs?: DatasetReference[];

  /**
   * Type of activity.
   */
  type: "Copy";
}

/**
 * Copy activity properties.
 */
model CopyActivityTypeProperties {
  /**
   * Copy activity source.
   */
  source: CopySource;

  /**
   * Copy activity sink.
   */
  sink: CopySink;

  /**
   * Copy activity translator. If not specified, tabular translator is used.
   */
  translator?: Record<unknown>;

  /**
   * Specifies whether to copy data via an interim staging. Default value is false. Type: boolean (or Expression with resultType boolean).
   */
  enableStaging?: Record<unknown>;

  /**
   * Specifies interim staging settings when EnableStaging is true.
   */
  stagingSettings?: StagingSettings;

  /**
   * Maximum number of concurrent sessions opened on the source or sink to avoid overloading the data store. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  parallelCopies?: Record<unknown>;

  /**
   * Maximum number of data integration units that can be used to perform this data movement. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  dataIntegrationUnits?: Record<unknown>;

  /**
   * Whether to skip incompatible row. Default value is false. Type: boolean (or Expression with resultType boolean).
   */
  enableSkipIncompatibleRow?: Record<unknown>;

  /**
   * Redirect incompatible row settings when EnableSkipIncompatibleRow is true.
   */
  redirectIncompatibleRowSettings?: RedirectIncompatibleRowSettings;

  /**
   * (Deprecated. Please use LogSettings) Log storage settings customer need to provide when enabling session log.
   */
  logStorageSettings?: LogStorageSettings;

  /**
   * Log settings customer needs provide when enabling log.
   */
  logSettings?: LogSettings;

  /**
   * Preserve Rules.
   */
  preserveRules?: Record<unknown>[];

  /**
   * Preserve rules.
   */
  preserve?: Record<unknown>[];

  /**
   * Whether to enable Data Consistency validation. Type: boolean (or Expression with resultType boolean).
   */
  validateDataConsistency?: Record<unknown>;

  /**
   * Specify the fault tolerance for data consistency.
   */
  skipErrorFile?: SkipErrorFile;
}

/**
 * Staging settings.
 */
model StagingSettings extends Record<Record<unknown>> {
  /**
   * Staging linked service reference.
   */
  linkedServiceName: LinkedServiceReference;

  /**
   * The path to storage for storing the interim data. Type: string (or Expression with resultType string).
   */
  path?: Record<unknown>;

  /**
   * Specifies whether to use compression when copying data via an interim staging. Default value is false. Type: boolean (or Expression with resultType boolean).
   */
  enableCompression?: Record<unknown>;
}

/**
 * Redirect incompatible row settings
 */
model RedirectIncompatibleRowSettings extends Record<Record<unknown>> {
  /**
   * Name of the Azure Storage, Storage SAS, or Azure Data Lake Store linked service used for redirecting incompatible row. Must be specified if redirectIncompatibleRowSettings is specified. Type: string (or Expression with resultType string).
   */
  linkedServiceName: Record<unknown>;

  /**
   * The path for storing the redirect incompatible row data. Type: string (or Expression with resultType string).
   */
  path?: Record<unknown>;
}

/**
 * (Deprecated. Please use LogSettings) Log storage settings.
 */
model LogStorageSettings extends Record<Record<unknown>> {
  /**
   * Log storage linked service reference.
   */
  linkedServiceName: LinkedServiceReference;

  /**
   * The path to storage for storing detailed logs of activity execution. Type: string (or Expression with resultType string).
   */
  path?: Record<unknown>;

  /**
   * Gets or sets the log level, support: Info, Warning. Type: string (or Expression with resultType string).
   */
  logLevel?: Record<unknown>;

  /**
   * Specifies whether to enable reliable logging. Type: boolean (or Expression with resultType boolean).
   */
  enableReliableLogging?: Record<unknown>;
}

/**
 * Log settings.
 */
model LogSettings {
  /**
   * Specifies whether to enable copy activity log. Type: boolean (or Expression with resultType boolean).
   */
  enableCopyActivityLog?: Record<unknown>;

  /**
   * Specifies settings for copy activity log.
   */
  copyActivityLogSettings?: CopyActivityLogSettings;

  /**
   * Log location settings customer needs to provide when enabling log.
   */
  logLocationSettings: LogLocationSettings;
}

/**
 * Settings for copy activity log.
 */
model CopyActivityLogSettings {
  /**
   * Gets or sets the log level, support: Info, Warning. Type: string (or Expression with resultType string).
   */
  logLevel?: Record<unknown>;

  /**
   * Specifies whether to enable reliable logging. Type: boolean (or Expression with resultType boolean).
   */
  enableReliableLogging?: Record<unknown>;
}

/**
 * Log location settings.
 */
model LogLocationSettings {
  /**
   * Log storage linked service reference.
   */
  linkedServiceName: LinkedServiceReference;

  /**
   * The path to storage for storing detailed logs of activity execution. Type: string (or Expression with resultType string).
   */
  path?: Record<unknown>;
}

/**
 * Skip error file.
 */
model SkipErrorFile {
  /**
   * Skip if file is deleted by other client during copy. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  fileMissing?: Record<unknown>;

  /**
   * Skip if source/sink file changed by other concurrent write. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  dataInconsistency?: Record<unknown>;
}

/**
 * A copy activity Binary source.
 */
model BinarySource extends CopySource {
  /**
   * Binary store settings.
   */
  storeSettings?: StoreReadSettings;

  /**
   * Binary format settings.
   */
  formatSettings?: BinaryReadSettings;

  /**
   * Copy source type.
   */
  type: "BinarySource";
}

/**
 * Copy activity sources of tabular type.
 */
@discriminator("type")
model TabularSource extends CopySource {
  /**
   * Query timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  queryTimeout?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;
}

/**
 * A copy activity Azure Table source.
 */
model AzureTableSource extends TabularSource {
  /**
   * Azure Table source query. Type: string (or Expression with resultType string).
   */
  azureTableSourceQuery?: Record<unknown>;

  /**
   * Azure Table source ignore table not found. Type: boolean (or Expression with resultType boolean).
   */
  azureTableSourceIgnoreTableNotFound?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "AzureTableSource";
}

/**
 * A copy activity Azure Blob source.
 */
model BlobSource extends CopySource {
  /**
   * Treat empty as null. Type: boolean (or Expression with resultType boolean).
   */
  treatEmptyAsNull?: Record<unknown>;

  /**
   * Number of header lines to skip from each blob. Type: integer (or Expression with resultType integer).
   */
  skipHeaderLineCount?: Record<unknown>;

  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "BlobSource";
}

/**
 * A copy activity Document Database Collection source.
 */
model DocumentDbCollectionSource extends CopySource {
  /**
   * Documents query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Nested properties separator. Type: string (or Expression with resultType string).
   */
  nestingSeparator?: Record<unknown>;

  /**
   * Query timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  queryTimeout?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "DocumentDbCollectionSource";
}

/**
 * A copy activity Azure CosmosDB (SQL API) Collection source.
 */
model CosmosDbSqlApiSource extends CopySource {
  /**
   * SQL API query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Page size of the result. Type: integer (or Expression with resultType integer).
   */
  pageSize?: Record<unknown>;

  /**
   * Preferred regions. Type: array of strings (or Expression with resultType array of strings).
   */
  preferredRegions?: Record<unknown>;

  /**
   * Whether detect primitive values as datetime values. Type: boolean (or Expression with resultType boolean).
   */
  detectDatetime?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "CosmosDbSqlApiSource";
}

/**
 * A copy activity Dynamics source.
 */
model DynamicsSource extends CopySource {
  /**
   * FetchXML is a proprietary query language that is used in Microsoft Dynamics (online & on-premises). Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "DynamicsSource";
}

/**
 * A copy activity Dynamics CRM source.
 */
model DynamicsCrmSource extends CopySource {
  /**
   * FetchXML is a proprietary query language that is used in Microsoft Dynamics CRM (online & on-premises). Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "DynamicsCrmSource";
}

/**
 * A copy activity Common Data Service for Apps source.
 */
model CommonDataServiceForAppsSource extends CopySource {
  /**
   * FetchXML is a proprietary query language that is used in Microsoft Common Data Service for Apps (online & on-premises). Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "CommonDataServiceForAppsSource";
}

/**
 * A copy activity source for various relational databases.
 */
model RelationalSource extends CopySource {
  /**
   * Database query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "RelationalSource";
}

/**
 * A copy activity source for Informix.
 */
model InformixSource extends TabularSource {
  /**
   * Database query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "InformixSource";
}

/**
 * A copy activity source for Microsoft Access.
 */
model MicrosoftAccessSource extends CopySource {
  /**
   * Database query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "MicrosoftAccessSource";
}

/**
 * A copy activity source for Db2 databases.
 */
model Db2Source extends TabularSource {
  /**
   * Database query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "Db2Source";
}

/**
 * A copy activity source for ODBC databases.
 */
model OdbcSource extends TabularSource {
  /**
   * Database query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "OdbcSource";
}

/**
 * A copy activity source for MySQL databases.
 */
model MySqlSource extends TabularSource {
  /**
   * Database query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "MySqlSource";
}

/**
 * A copy activity source for PostgreSQL databases.
 */
model PostgreSqlSource extends TabularSource {
  /**
   * Database query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "PostgreSqlSource";
}

/**
 * A copy activity source for Sybase databases.
 */
model SybaseSource extends TabularSource {
  /**
   * Database query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "SybaseSource";
}

/**
 * A copy activity source for SapBW server via MDX.
 */
model SapBwSource extends TabularSource {
  /**
   * MDX query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "SapBwSource";
}

/**
 * A copy activity source for OData source.
 */
model ODataSource extends CopySource {
  /**
   * OData query. For example, "$top=1". Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:05:00. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  httpRequestTimeout?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "ODataSource";
}

/**
 * A copy activity Salesforce source.
 */
model SalesforceSource extends TabularSource {
  /**
   * Database query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * The read behavior for the operation. Default is Query. Allowed values: Query/QueryAll. Type: string (or Expression with resultType string).
   */
  readBehavior?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "SalesforceSource";
}

/**
 * A copy activity Salesforce Service Cloud source.
 */
model SalesforceServiceCloudSource extends CopySource {
  /**
   * Database query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * The read behavior for the operation. Default is Query. Allowed values: Query/QueryAll. Type: string (or Expression with resultType string).
   */
  readBehavior?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "SalesforceServiceCloudSource";
}

/**
 * A copy activity source for SAP Cloud for Customer source.
 */
model SapCloudForCustomerSource extends TabularSource {
  /**
   * SAP Cloud for Customer OData query. For example, "$top=1". Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:05:00. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  httpRequestTimeout?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "SapCloudForCustomerSource";
}

/**
 * A copy activity source for SAP ECC source.
 */
model SapEccSource extends TabularSource {
  /**
   * SAP ECC OData query. For example, "$top=1". Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:05:00. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  httpRequestTimeout?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "SapEccSource";
}

/**
 * A copy activity source for SAP HANA source.
 */
model SapHanaSource extends TabularSource {
  /**
   * SAP HANA Sql query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * The packet size of data read from SAP HANA. Type: integer(or Expression with resultType integer).
   */
  packetSize?: Record<unknown>;

  /**
   * The partition mechanism that will be used for SAP HANA read in parallel. Possible values include: "None", "PhysicalPartitionsOfTable", "SapHanaDynamicRange".
   */
  partitionOption?: Record<unknown>;

  /**
   * The settings that will be leveraged for SAP HANA source partitioning.
   */
  partitionSettings?: SapHanaPartitionSettings;

  /**
   * Copy source type.
   */
  type: "SapHanaSource";
}

/**
 * The settings that will be leveraged for SAP HANA source partitioning.
 */
model SapHanaPartitionSettings {
  /**
   * The name of the column that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  partitionColumnName?: Record<unknown>;
}

/**
 * A copy activity source for SAP Business Warehouse Open Hub Destination source.
 */
model SapOpenHubSource extends TabularSource {
  /**
   * Whether to exclude the records of the last request. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  excludeLastRequest?: Record<unknown>;

  /**
   * The ID of request for delta loading. Once it is set, only data with requestId larger than the value of this property will be retrieved. The default value is 0. Type: integer (or Expression with resultType integer ).
   */
  baseRequestId?: Record<unknown>;

  /**
   * Specifies the custom RFC function module that will be used to read data from SAP Table. Type: string (or Expression with resultType string).
   */
  customRfcReadTableFunctionModule?: Record<unknown>;

  /**
   * The single character that will be used as delimiter passed to SAP RFC as well as splitting the output data retrieved. Type: string (or Expression with resultType string).
   */
  sapDataColumnDelimiter?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "SapOpenHubSource";
}

/**
 * A copy activity source for SAP ODP source.
 */
model SapOdpSource extends TabularSource {
  /**
   * The extraction mode. Allowed value include: Full, Delta and Recovery. The default value is Full. Type: string (or Expression with resultType string).
   */
  extractionMode?: Record<unknown>;

  /**
   * The subscriber process to manage the delta process. Type: string (or Expression with resultType string).
   */
  subscriberProcess?: Record<unknown>;

  /**
   * Specifies the selection conditions from source data. Type: array of objects(selection) (or Expression with resultType array of objects).
   */
  selection?: Record<unknown>;

  /**
   * Specifies the columns to be selected from source data. Type: array of objects(projection) (or Expression with resultType array of objects).
   */
  `projection`?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "SapOdpSource";
}

/**
 * A copy activity source for SAP Table source.
 */
model SapTableSource extends TabularSource {
  /**
   * The number of rows to be retrieved. Type: integer(or Expression with resultType integer).
   */
  rowCount?: Record<unknown>;

  /**
   * The number of rows that will be skipped. Type: integer (or Expression with resultType integer).
   */
  rowSkips?: Record<unknown>;

  /**
   * The fields of the SAP table that will be retrieved. For example, column0, column1. Type: string (or Expression with resultType string).
   */
  rfcTableFields?: Record<unknown>;

  /**
   * The options for the filtering of the SAP Table. For example, COLUMN0 EQ SOME VALUE. Type: string (or Expression with resultType string).
   */
  rfcTableOptions?: Record<unknown>;

  /**
   * Specifies the maximum number of rows that will be retrieved at a time when retrieving data from SAP Table. Type: integer (or Expression with resultType integer).
   */
  batchSize?: Record<unknown>;

  /**
   * Specifies the custom RFC function module that will be used to read data from SAP Table. Type: string (or Expression with resultType string).
   */
  customRfcReadTableFunctionModule?: Record<unknown>;

  /**
   * The single character that will be used as delimiter passed to SAP RFC as well as splitting the output data retrieved. Type: string (or Expression with resultType string).
   */
  sapDataColumnDelimiter?: Record<unknown>;

  /**
   * The partition mechanism that will be used for SAP table read in parallel. Possible values include: "None", "PartitionOnInt", "PartitionOnCalendarYear", "PartitionOnCalendarMonth", "PartitionOnCalendarDate", "PartitionOnTime".
   */
  partitionOption?: Record<unknown>;

  /**
   * The settings that will be leveraged for SAP table source partitioning.
   */
  partitionSettings?: SapTablePartitionSettings;

  /**
   * Copy source type.
   */
  type: "SapTableSource";
}

/**
 * The settings that will be leveraged for SAP table source partitioning.
 */
model SapTablePartitionSettings {
  /**
   * The name of the column that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  partitionColumnName?: Record<unknown>;

  /**
   * The maximum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  partitionUpperBound?: Record<unknown>;

  /**
   * The minimum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  partitionLowerBound?: Record<unknown>;

  /**
   * The maximum value of partitions the table will be split into. Type: integer (or Expression with resultType string).
   */
  maxPartitionsNumber?: Record<unknown>;
}

/**
 * A copy activity Rest service Sink.
 */
model RestSink extends CopySink {
  /**
   * The HTTP method used to call the RESTful API. The default is POST. Type: string (or Expression with resultType string).
   */
  requestMethod?: Record<unknown>;

  /**
   * The additional HTTP headers in the request to the RESTful API. Type: string (or Expression with resultType string).
   */
  additionalHeaders?: Record<unknown>;

  /**
   * The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:01:40. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  httpRequestTimeout?: Record<unknown>;

  /**
   * The time to await before sending next request, in milliseconds
   */
  requestInterval?: Record<unknown>;

  /**
   * Http Compression Type to Send data in compressed format with Optimal Compression Level, Default is None. And The Only Supported option is Gzip.
   */
  httpCompressionType?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "RestSink";
}

/**
 * A copy activity Rest service source.
 */
model RestSource extends CopySource {
  /**
   * The HTTP method used to call the RESTful API. The default is GET. Type: string (or Expression with resultType string).
   */
  requestMethod?: Record<unknown>;

  /**
   * The HTTP request body to the RESTful API if requestMethod is POST. Type: string (or Expression with resultType string).
   */
  requestBody?: Record<unknown>;

  /**
   * The additional HTTP headers in the request to the RESTful API. Type: string (or Expression with resultType string).
   */
  additionalHeaders?: Record<unknown>;

  /**
   * The pagination rules to compose next page requests. Type: string (or Expression with resultType string).
   */
  paginationRules?: Record<unknown>;

  /**
   * The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:01:40. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  httpRequestTimeout?: Record<unknown>;

  /**
   * The time to await before sending next page request.
   */
  requestInterval?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "RestSource";
}

/**
 * A copy activity SQL source.
 */
model SqlSource extends TabularSource {
  /**
   * SQL reader query. Type: string (or Expression with resultType string).
   */
  sqlReaderQuery?: Record<unknown>;

  /**
   * Name of the stored procedure for a SQL Database source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).
   */
  sqlReaderStoredProcedureName?: Record<unknown>;

  /**
   * Value and type setting for stored procedure parameters. Example: "{Parameter1: {value: "1", type: "int"}}".
   */
  storedProcedureParameters?: Record<unknown>;

  /**
   * Specifies the transaction locking behavior for the SQL source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).
   */
  isolationLevel?: Record<unknown>;

  /**
   * The partition mechanism that will be used for Sql read in parallel. Possible values include: "None", "PhysicalPartitionsOfTable", "DynamicRange".
   */
  partitionOption?: Record<unknown>;

  /**
   * The settings that will be leveraged for Sql source partitioning.
   */
  partitionSettings?: SqlPartitionSettings;

  /**
   * Copy source type.
   */
  type: "SqlSource";
}

/**
 * The settings that will be leveraged for Sql source partitioning.
 */
model SqlPartitionSettings {
  /**
   * The name of the column in integer or datetime type that will be used for proceeding partitioning. If not specified, the primary key of the table is auto-detected and used as the partition column. Type: string (or Expression with resultType string).
   */
  partitionColumnName?: Record<unknown>;

  /**
   * The maximum value of the partition column for partition range splitting. This value is used to decide the partition stride, not for filtering the rows in table. All rows in the table or query result will be partitioned and copied. Type: string (or Expression with resultType string).
   */
  partitionUpperBound?: Record<unknown>;

  /**
   * The minimum value of the partition column for partition range splitting. This value is used to decide the partition stride, not for filtering the rows in table. All rows in the table or query result will be partitioned and copied. Type: string (or Expression with resultType string).
   */
  partitionLowerBound?: Record<unknown>;
}

/**
 * A copy activity SQL server source.
 */
model SqlServerSource extends TabularSource {
  /**
   * SQL reader query. Type: string (or Expression with resultType string).
   */
  sqlReaderQuery?: Record<unknown>;

  /**
   * Name of the stored procedure for a SQL Database source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).
   */
  sqlReaderStoredProcedureName?: Record<unknown>;

  /**
   * Value and type setting for stored procedure parameters. Example: "{Parameter1: {value: "1", type: "int"}}".
   */
  storedProcedureParameters?: Record<unknown>;

  /**
   * Specifies the transaction locking behavior for the SQL source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).
   */
  isolationLevel?: Record<unknown>;

  /**
   * Which additional types to produce.
   */
  produceAdditionalTypes?: Record<unknown>;

  /**
   * The partition mechanism that will be used for Sql read in parallel. Possible values include: "None", "PhysicalPartitionsOfTable", "DynamicRange".
   */
  partitionOption?: Record<unknown>;

  /**
   * The settings that will be leveraged for Sql source partitioning.
   */
  partitionSettings?: SqlPartitionSettings;

  /**
   * Copy source type.
   */
  type: "SqlServerSource";
}

/**
 * A copy activity Amazon RDS for SQL Server source.
 */
model AmazonRdsForSqlServerSource extends TabularSource {
  /**
   * SQL reader query. Type: string (or Expression with resultType string).
   */
  sqlReaderQuery?: Record<unknown>;

  /**
   * Name of the stored procedure for a SQL Database source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).
   */
  sqlReaderStoredProcedureName?: Record<unknown>;

  /**
   * Value and type setting for stored procedure parameters. Example: "{Parameter1: {value: "1", type: "int"}}".
   */
  storedProcedureParameters?: Record<unknown>;

  /**
   * Specifies the transaction locking behavior for the SQL source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).
   */
  isolationLevel?: Record<unknown>;

  /**
   * Which additional types to produce.
   */
  produceAdditionalTypes?: Record<unknown>;

  /**
   * The partition mechanism that will be used for Sql read in parallel. Possible values include: "None", "PhysicalPartitionsOfTable", "DynamicRange".
   */
  partitionOption?: Record<unknown>;

  /**
   * The settings that will be leveraged for Sql source partitioning.
   */
  partitionSettings?: SqlPartitionSettings;

  /**
   * Copy source type.
   */
  type: "AmazonRdsForSqlServerSource";
}

/**
 * A copy activity Azure SQL source.
 */
model AzureSqlSource extends TabularSource {
  /**
   * SQL reader query. Type: string (or Expression with resultType string).
   */
  sqlReaderQuery?: Record<unknown>;

  /**
   * Name of the stored procedure for a SQL Database source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).
   */
  sqlReaderStoredProcedureName?: Record<unknown>;

  /**
   * Value and type setting for stored procedure parameters. Example: "{Parameter1: {value: "1", type: "int"}}".
   */
  storedProcedureParameters?: Record<unknown>;

  /**
   * Specifies the transaction locking behavior for the SQL source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).
   */
  isolationLevel?: Record<unknown>;

  /**
   * Which additional types to produce.
   */
  produceAdditionalTypes?: Record<unknown>;

  /**
   * The partition mechanism that will be used for Sql read in parallel. Possible values include: "None", "PhysicalPartitionsOfTable", "DynamicRange".
   */
  partitionOption?: Record<unknown>;

  /**
   * The settings that will be leveraged for Sql source partitioning.
   */
  partitionSettings?: SqlPartitionSettings;

  /**
   * Copy source type.
   */
  type: "AzureSqlSource";
}

/**
 * A copy activity Azure SQL Managed Instance source.
 */
model SqlMISource extends TabularSource {
  /**
   * SQL reader query. Type: string (or Expression with resultType string).
   */
  sqlReaderQuery?: Record<unknown>;

  /**
   * Name of the stored procedure for a Azure SQL Managed Instance source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).
   */
  sqlReaderStoredProcedureName?: Record<unknown>;

  /**
   * Value and type setting for stored procedure parameters. Example: "{Parameter1: {value: "1", type: "int"}}".
   */
  storedProcedureParameters?: Record<unknown>;

  /**
   * Specifies the transaction locking behavior for the SQL source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).
   */
  isolationLevel?: Record<unknown>;

  /**
   * Which additional types to produce.
   */
  produceAdditionalTypes?: Record<unknown>;

  /**
   * The partition mechanism that will be used for Sql read in parallel. Possible values include: "None", "PhysicalPartitionsOfTable", "DynamicRange".
   */
  partitionOption?: Record<unknown>;

  /**
   * The settings that will be leveraged for Sql source partitioning.
   */
  partitionSettings?: SqlPartitionSettings;

  /**
   * Copy source type.
   */
  type: "SqlMISource";
}

/**
 * A copy activity SQL Data Warehouse source.
 */
model SqlDWSource extends TabularSource {
  /**
   * SQL Data Warehouse reader query. Type: string (or Expression with resultType string).
   */
  sqlReaderQuery?: Record<unknown>;

  /**
   * Name of the stored procedure for a SQL Data Warehouse source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).
   */
  sqlReaderStoredProcedureName?: Record<unknown>;

  /**
   * Value and type setting for stored procedure parameters. Example: "{Parameter1: {value: "1", type: "int"}}". Type: object (or Expression with resultType object), itemType: StoredProcedureParameter.
   */
  storedProcedureParameters?: Record<unknown>;

  /**
   * Specifies the transaction locking behavior for the SQL source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).
   */
  isolationLevel?: Record<unknown>;

  /**
   * The partition mechanism that will be used for Sql read in parallel. Possible values include: "None", "PhysicalPartitionsOfTable", "DynamicRange".
   */
  partitionOption?: Record<unknown>;

  /**
   * The settings that will be leveraged for Sql source partitioning.
   */
  partitionSettings?: SqlPartitionSettings;

  /**
   * Copy source type.
   */
  type: "SqlDWSource";
}

/**
 * A copy activity file system source.
 */
model FileSystemSource extends CopySource {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "FileSystemSource";
}

/**
 * A copy activity HDFS source.
 */
model HdfsSource extends CopySource {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * Specifies Distcp-related settings.
   */
  distcpSettings?: DistcpSettings;

  /**
   * Copy source type.
   */
  type: "HdfsSource";
}

/**
 * A copy activity Azure MySQL source.
 */
model AzureMySqlSource extends TabularSource {
  /**
   * Database query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "AzureMySqlSource";
}

/**
 * A copy activity Azure Data Explorer (Kusto) source.
 */
model AzureDataExplorerSource extends CopySource {
  /**
   * Database query. Should be a Kusto Query Language (KQL) query. Type: string (or Expression with resultType string).
   */
  query: Record<unknown>;

  /**
   * The name of the Boolean option that controls whether truncation is applied to result-sets that go beyond a certain row-count limit.
   */
  noTruncation?: Record<unknown>;

  /**
   * Query timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9]))..
   */
  queryTimeout?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "AzureDataExplorerSource";
}

/**
 * A copy activity Oracle source.
 */
model OracleSource extends CopySource {
  /**
   * Oracle reader query. Type: string (or Expression with resultType string).
   */
  oracleReaderQuery?: Record<unknown>;

  /**
   * Query timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  queryTimeout?: Record<unknown>;

  /**
   * The partition mechanism that will be used for Oracle read in parallel. Possible values include: "None", "PhysicalPartitionsOfTable", "DynamicRange".
   */
  partitionOption?: Record<unknown>;

  /**
   * The settings that will be leveraged for Oracle source partitioning.
   */
  partitionSettings?: OraclePartitionSettings;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "OracleSource";
}

/**
 * The settings that will be leveraged for Oracle source partitioning.
 */
model OraclePartitionSettings {
  /**
   * Names of the physical partitions of Oracle table.
   */
  partitionNames?: Record<unknown>;

  /**
   * The name of the column in integer type that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  partitionColumnName?: Record<unknown>;

  /**
   * The maximum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  partitionUpperBound?: Record<unknown>;

  /**
   * The minimum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  partitionLowerBound?: Record<unknown>;
}

/**
 * A copy activity AmazonRdsForOracle source.
 */
model AmazonRdsForOracleSource extends CopySource {
  /**
   * AmazonRdsForOracle reader query. Type: string (or Expression with resultType string).
   */
  oracleReaderQuery?: Record<unknown>;

  /**
   * Query timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  queryTimeout?: Record<unknown>;

  /**
   * The partition mechanism that will be used for AmazonRdsForOracle read in parallel. Type: string (or Expression with resultType string).
   */
  partitionOption?: Record<unknown>;

  /**
   * The settings that will be leveraged for AmazonRdsForOracle source partitioning.
   */
  partitionSettings?: AmazonRdsForOraclePartitionSettings;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "AmazonRdsForOracleSource";
}

/**
 * The settings that will be leveraged for AmazonRdsForOracle source partitioning.
 */
model AmazonRdsForOraclePartitionSettings {
  /**
   * Names of the physical partitions of AmazonRdsForOracle table.
   */
  partitionNames?: Record<unknown>;

  /**
   * The name of the column in integer type that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  partitionColumnName?: Record<unknown>;

  /**
   * The maximum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  partitionUpperBound?: Record<unknown>;

  /**
   * The minimum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  partitionLowerBound?: Record<unknown>;
}

/**
 * A copy activity Teradata source.
 */
model TeradataSource extends TabularSource {
  /**
   * Teradata query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * The partition mechanism that will be used for teradata read in parallel. Possible values include: "None", "Hash", "DynamicRange".
   */
  partitionOption?: Record<unknown>;

  /**
   * The settings that will be leveraged for teradata source partitioning.
   */
  partitionSettings?: TeradataPartitionSettings;

  /**
   * Copy source type.
   */
  type: "TeradataSource";
}

/**
 * The settings that will be leveraged for teradata source partitioning.
 */
model TeradataPartitionSettings {
  /**
   * The name of the column that will be used for proceeding range or hash partitioning. Type: string (or Expression with resultType string).
   */
  partitionColumnName?: Record<unknown>;

  /**
   * The maximum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  partitionUpperBound?: Record<unknown>;

  /**
   * The minimum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  partitionLowerBound?: Record<unknown>;
}

/**
 * A copy activity source for web page table.
 */
model WebSource extends CopySource {
  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "WebSource";
}

/**
 * A copy activity source for a Cassandra database.
 */
model CassandraSource extends TabularSource {
  /**
   * Database query. Should be a SQL-92 query expression or Cassandra Query Language (CQL) command. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * The consistency level specifies how many Cassandra servers must respond to a read request before returning data to the client application. Cassandra checks the specified number of Cassandra servers for data to satisfy the read request. Must be one of cassandraSourceReadConsistencyLevels. The default value is 'ONE'. It is case-insensitive.
   */
  consistencyLevel?: CassandraSourceReadConsistencyLevels;

  /**
   * Copy source type.
   */
  type: "CassandraSource";
}

/**
 * A copy activity source for a MongoDB database.
 */
model MongoDbSource extends CopySource {
  /**
   * Database query. Should be a SQL-92 query expression. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "MongoDbSource";
}

/**
 * A copy activity source for a MongoDB Atlas database.
 */
model MongoDbAtlasSource extends CopySource {
  /**
   * Specifies selection filter using query operators. To return all documents in a collection, omit this parameter or pass an empty document ({}). Type: string (or Expression with resultType string).
   */
  filter?: Record<unknown>;

  /**
   * Cursor methods for Mongodb query
   */
  cursorMethods?: MongoDbCursorMethodsProperties;

  /**
   * Specifies the number of documents to return in each batch of the response from MongoDB Atlas instance. In most cases, modifying the batch size will not affect the user or the application. This property's main purpose is to avoid hit the limitation of response size. Type: integer (or Expression with resultType integer).
   */
  batchSize?: Record<unknown>;

  /**
   * Query timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  queryTimeout?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "MongoDbAtlasSource";
}

/**
 * Cursor methods for Mongodb query
 */
model MongoDbCursorMethodsProperties extends Record<Record<unknown>> {
  /**
   * Specifies the fields to return in the documents that match the query filter. To return all fields in the matching documents, omit this parameter. Type: string (or Expression with resultType string).
   */
  project?: Record<unknown>;

  /**
   * Specifies the order in which the query returns matching documents. Type: string (or Expression with resultType string). Type: string (or Expression with resultType string).
   */
  sort?: Record<unknown>;

  /**
   * Specifies the how many documents skipped and where MongoDB begins returning results. This approach may be useful in implementing paginated results. Type: integer (or Expression with resultType integer).
   */
  skip?: Record<unknown>;

  /**
   * Specifies the maximum number of documents the server returns. limit() is analogous to the LIMIT statement in a SQL database. Type: integer (or Expression with resultType integer).
   */
  limit?: Record<unknown>;
}

/**
 * A copy activity source for a MongoDB database.
 */
model MongoDbV2Source extends CopySource {
  /**
   * Specifies selection filter using query operators. To return all documents in a collection, omit this parameter or pass an empty document ({}). Type: string (or Expression with resultType string).
   */
  filter?: Record<unknown>;

  /**
   * Cursor methods for Mongodb query
   */
  cursorMethods?: MongoDbCursorMethodsProperties;

  /**
   * Specifies the number of documents to return in each batch of the response from MongoDB instance. In most cases, modifying the batch size will not affect the user or the application. This property's main purpose is to avoid hit the limitation of response size. Type: integer (or Expression with resultType integer).
   */
  batchSize?: Record<unknown>;

  /**
   * Query timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  queryTimeout?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "MongoDbV2Source";
}

/**
 * A copy activity source for a CosmosDB (MongoDB API) database.
 */
model CosmosDbMongoDbApiSource extends CopySource {
  /**
   * Specifies selection filter using query operators. To return all documents in a collection, omit this parameter or pass an empty document ({}). Type: string (or Expression with resultType string).
   */
  filter?: Record<unknown>;

  /**
   * Cursor methods for Mongodb query.
   */
  cursorMethods?: MongoDbCursorMethodsProperties;

  /**
   * Specifies the number of documents to return in each batch of the response from MongoDB instance. In most cases, modifying the batch size will not affect the user or the application. This property's main purpose is to avoid hit the limitation of response size. Type: integer (or Expression with resultType integer).
   */
  batchSize?: Record<unknown>;

  /**
   * Query timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  queryTimeout?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "CosmosDbMongoDbApiSource";
}

/**
 * A copy activity source for an Office 365 service.
 */
model Office365Source extends CopySource {
  /**
   * The groups containing all the users. Type: array of strings (or Expression with resultType array of strings).
   */
  allowedGroups?: Record<unknown>;

  /**
   * The user scope uri. Type: string (or Expression with resultType string).
   */
  userScopeFilterUri?: Record<unknown>;

  /**
   * The Column to apply the <paramref name="StartTime"/> and <paramref name="EndTime"/>. Type: string (or Expression with resultType string).
   */
  dateFilterColumn?: Record<unknown>;

  /**
   * Start time of the requested range for this dataset. Type: string (or Expression with resultType string).
   */
  startTime?: Record<unknown>;

  /**
   * End time of the requested range for this dataset. Type: string (or Expression with resultType string).
   */
  endTime?: Record<unknown>;

  /**
   * The columns to be read out from the Office 365 table. Type: array of objects (or Expression with resultType array of objects). itemType: OutputColumn. Example: [ { "name": "Id" }, { "name": "CreatedDateTime" } ]
   */
  outputColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "Office365Source";
}

/**
 * The columns to be read out from the Office 365 table.
 */
model OutputColumn {
  /**
   * Name of the table column. Type: string.
   */
  name?: string;
}

/**
 * A copy activity Azure Data Lake source.
 */
model AzureDataLakeStoreSource extends CopySource {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "AzureDataLakeStoreSource";
}

/**
 * A copy activity Azure BlobFS source.
 */
model AzureBlobFSSource extends CopySource {
  /**
   * Treat empty as null. Type: boolean (or Expression with resultType boolean).
   */
  treatEmptyAsNull?: Record<unknown>;

  /**
   * Number of header lines to skip from each blob. Type: integer (or Expression with resultType integer).
   */
  skipHeaderLineCount?: Record<unknown>;

  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "AzureBlobFSSource";
}

/**
 * A copy activity source for an HTTP file.
 */
model HttpSource extends CopySource {
  /**
   * Specifies the timeout for a HTTP client to get HTTP response from HTTP server. The default value is equivalent to System.Net.HttpWebRequest.Timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  httpRequestTimeout?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "HttpSource";
}

/**
 * A copy activity Amazon Marketplace Web Service source.
 */
model AmazonMWSSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "AmazonMWSSource";
}

/**
 * A copy activity Azure PostgreSQL source.
 */
model AzurePostgreSqlSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "AzurePostgreSqlSource";
}

/**
 * A copy activity Azure PostgreSQL sink.
 */
model AzurePostgreSqlSink extends CopySink {
  /**
   * A query to execute before starting the copy. Type: string (or Expression with resultType string).
   */
  preCopyScript?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "AzurePostgreSqlSink";
}

/**
 * A copy activity Azure MySql sink.
 */
model AzureMySqlSink extends CopySink {
  /**
   * A query to execute before starting the copy. Type: string (or Expression with resultType string).
   */
  preCopyScript?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "AzureMySqlSink";
}

/**
 * A copy activity Concur Service source.
 */
model ConcurSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "ConcurSource";
}

/**
 * A copy activity Couchbase server source.
 */
model CouchbaseSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "CouchbaseSource";
}

/**
 * A copy activity Drill server source.
 */
model DrillSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "DrillSource";
}

/**
 * A copy activity Eloqua server source.
 */
model EloquaSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "EloquaSource";
}

/**
 * A copy activity Google BigQuery service source.
 */
model GoogleBigQuerySource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "GoogleBigQuerySource";
}

/**
 * A copy activity Greenplum Database source.
 */
model GreenplumSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "GreenplumSource";
}

/**
 * A copy activity HBase server source.
 */
model HBaseSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "HBaseSource";
}

/**
 * A copy activity Hive Server source.
 */
model HiveSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "HiveSource";
}

/**
 * A copy activity Hubspot Service source.
 */
model HubspotSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "HubspotSource";
}

/**
 * A copy activity Impala server source.
 */
model ImpalaSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "ImpalaSource";
}

/**
 * A copy activity Jira Service source.
 */
model JiraSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "JiraSource";
}

/**
 * A copy activity Magento server source.
 */
model MagentoSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "MagentoSource";
}

/**
 * A copy activity MariaDB server source.
 */
model MariaDBSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "MariaDBSource";
}

/**
 * A copy activity Azure MariaDB source.
 */
model AzureMariaDBSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "AzureMariaDBSource";
}

/**
 * A copy activity Marketo server source.
 */
model MarketoSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "MarketoSource";
}

/**
 * A copy activity Paypal Service source.
 */
model PaypalSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "PaypalSource";
}

/**
 * A copy activity Phoenix server source.
 */
model PhoenixSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "PhoenixSource";
}

/**
 * A copy activity Presto server source.
 */
model PrestoSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "PrestoSource";
}

/**
 * A copy activity QuickBooks server source.
 */
model QuickBooksSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "QuickBooksSource";
}

/**
 * A copy activity ServiceNow server source.
 */
model ServiceNowSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "ServiceNowSource";
}

/**
 * A copy activity Shopify Service source.
 */
model ShopifySource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "ShopifySource";
}

/**
 * A copy activity Spark Server source.
 */
model SparkSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "SparkSource";
}

/**
 * A copy activity Square Service source.
 */
model SquareSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "SquareSource";
}

/**
 * A copy activity Xero Service source.
 */
model XeroSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "XeroSource";
}

/**
 * A copy activity Zoho server source.
 */
model ZohoSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "ZohoSource";
}

/**
 * A copy activity Netezza source.
 */
model NetezzaSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * The partition mechanism that will be used for Netezza read in parallel. Possible values include: "None", "DataSlice", "DynamicRange".
   */
  partitionOption?: Record<unknown>;

  /**
   * The settings that will be leveraged for Netezza source partitioning.
   */
  partitionSettings?: NetezzaPartitionSettings;

  /**
   * Copy source type.
   */
  type: "NetezzaSource";
}

/**
 * The settings that will be leveraged for Netezza source partitioning.
 */
model NetezzaPartitionSettings {
  /**
   * The name of the column in integer type that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  partitionColumnName?: Record<unknown>;

  /**
   * The maximum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  partitionUpperBound?: Record<unknown>;

  /**
   * The minimum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  partitionLowerBound?: Record<unknown>;
}

/**
 * A copy activity Vertica source.
 */
model VerticaSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "VerticaSource";
}

/**
 * A copy activity Salesforce Marketing Cloud source.
 */
model SalesforceMarketingCloudSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "SalesforceMarketingCloudSource";
}

/**
 * A copy activity Responsys source.
 */
model ResponsysSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "ResponsysSource";
}

/**
 * A copy activity Dynamics AX source.
 */
model DynamicsAXSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:05:00. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  httpRequestTimeout?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "DynamicsAXSource";
}

/**
 * A copy activity Oracle Service Cloud source.
 */
model OracleServiceCloudSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "OracleServiceCloudSource";
}

/**
 * A copy activity Google AdWords service source.
 */
model GoogleAdWordsSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "GoogleAdWordsSource";
}

/**
 * A copy activity source for Amazon Redshift Source.
 */
model AmazonRedshiftSource extends TabularSource {
  /**
   * Database query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * The Amazon S3 settings needed for the interim Amazon S3 when copying from Amazon Redshift with unload. With this, data from Amazon Redshift source will be unloaded into S3 first and then copied into the targeted sink from the interim S3.
   */
  redshiftUnloadSettings?: RedshiftUnloadSettings;

  /**
   * Copy source type.
   */
  type: "AmazonRedshiftSource";
}

/**
 * The Amazon S3 settings needed for the interim Amazon S3 when copying from Amazon Redshift with unload. With this, data from Amazon Redshift source will be unloaded into S3 first and then copied into the targeted sink from the interim S3.
 */
model RedshiftUnloadSettings {
  /**
   * The name of the Amazon S3 linked service which will be used for the unload operation when copying from the Amazon Redshift source.
   */
  s3LinkedServiceName: LinkedServiceReference;

  /**
   * The bucket of the interim Amazon S3 which will be used to store the unloaded data from Amazon Redshift source. The bucket must be in the same region as the Amazon Redshift source. Type: string (or Expression with resultType string).
   */
  bucketName: Record<unknown>;
}

/**
 * A copy activity source for Microsoft Fabric LakeHouse Table.
 */
model LakeHouseTableSource extends CopySource {
  /**
   * Query an older snapshot by timestamp. Type: string (or Expression with resultType string).
   */
  timestampAsOf?: Record<unknown>;

  /**
   * Query an older snapshot by version. Type: integer (or Expression with resultType integer).
   */
  versionAsOf?: Record<unknown>;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  additionalColumns?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "LakeHouseTableSource";
}

/**
 * A copy activity snowflake source.
 */
model SnowflakeSource extends CopySource {
  /**
   * Snowflake Sql query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Snowflake export settings.
   */
  exportSettings: SnowflakeExportCopyCommand;

  /**
   * Copy source type.
   */
  type: "SnowflakeSource";
}

/**
 * Snowflake export command settings.
 */
model SnowflakeExportCopyCommand extends ExportSettings {
  /**
   * Additional copy options directly passed to snowflake Copy Command. Type: key value pairs (value should be string type) (or Expression with resultType object). Example: "additionalCopyOptions": { "DATE_FORMAT": "MM/DD/YYYY", "TIME_FORMAT": "'HH24:MI:SS.FF'" }
   */
  additionalCopyOptions?: Record<Record<unknown>>;

  /**
   * Additional format options directly passed to snowflake Copy Command. Type: key value pairs (value should be string type) (or Expression with resultType object). Example: "additionalFormatOptions": { "OVERWRITE": "TRUE", "MAX_FILE_SIZE": "'FALSE'" }
   */
  additionalFormatOptions?: Record<Record<unknown>>;

  /**
   * The export setting type.
   */
  type: "SnowflakeExportCopyCommand";
}

/**
 * Export command settings.
 */
@discriminator("type")
model ExportSettings extends Record<Record<unknown>> {}

/**
 * A copy activity Azure Databricks Delta Lake source.
 */
model AzureDatabricksDeltaLakeSource extends CopySource {
  /**
   * Azure Databricks Delta Lake Sql query. Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * Azure Databricks Delta Lake export settings.
   */
  exportSettings?: AzureDatabricksDeltaLakeExportCommand;

  /**
   * Copy source type.
   */
  type: "AzureDatabricksDeltaLakeSource";
}

/**
 * Azure Databricks Delta Lake export command settings.
 */
model AzureDatabricksDeltaLakeExportCommand extends ExportSettings {
  /**
   * Specify the date format for the csv in Azure Databricks Delta Lake Copy. Type: string (or Expression with resultType string).
   */
  dateFormat?: Record<unknown>;

  /**
   * Specify the timestamp format for the csv in Azure Databricks Delta Lake Copy. Type: string (or Expression with resultType string).
   */
  timestampFormat?: Record<unknown>;

  /**
   * The export setting type.
   */
  type: "AzureDatabricksDeltaLakeExportCommand";
}

/**
 * A copy activity Azure Databricks Delta Lake sink.
 */
model AzureDatabricksDeltaLakeSink extends CopySink {
  /**
   * SQL pre-copy script. Type: string (or Expression with resultType string).
   */
  preCopyScript?: Record<unknown>;

  /**
   * Azure Databricks Delta Lake import settings.
   */
  importSettings?: AzureDatabricksDeltaLakeImportCommand;

  /**
   * Copy sink type.
   */
  type: "AzureDatabricksDeltaLakeSink";
}

/**
 * Azure Databricks Delta Lake import command settings.
 */
model AzureDatabricksDeltaLakeImportCommand extends ImportSettings {
  /**
   * Specify the date format for csv in Azure Databricks Delta Lake Copy. Type: string (or Expression with resultType string).
   */
  dateFormat?: Record<unknown>;

  /**
   * Specify the timestamp format for csv in Azure Databricks Delta Lake Copy. Type: string (or Expression with resultType string).
   */
  timestampFormat?: Record<unknown>;

  /**
   * The import setting type.
   */
  type: "AzureDatabricksDeltaLakeImportCommand";
}

/**
 * Import command settings.
 */
@discriminator("type")
model ImportSettings extends Record<Record<unknown>> {}

/**
 * SQL stored procedure parameter.
 */
model StoredProcedureParameter {
  /**
   * Stored procedure parameter value. Type: string (or Expression with resultType string).
   */
  value?: Record<unknown>;

  /**
   * Stored procedure parameter type.
   */
  type?: StoredProcedureParameterType;
}

/**
 * A copy activity SAP Cloud for Customer sink.
 */
model SapCloudForCustomerSink extends CopySink {
  /**
   * The write behavior for the operation. Default is 'Insert'.
   */
  writeBehavior?: SapCloudForCustomerSinkWriteBehavior;

  /**
   * The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:05:00. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  httpRequestTimeout?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "SapCloudForCustomerSink";
}

/**
 * A copy activity Azure Queue sink.
 */
model AzureQueueSink extends CopySink {
  /**
   * Copy sink type.
   */
  type: "AzureQueueSink";
}

/**
 * A copy activity Azure Table sink.
 */
model AzureTableSink extends CopySink {
  /**
   * Azure Table default partition key value. Type: string (or Expression with resultType string).
   */
  azureTableDefaultPartitionKeyValue?: Record<unknown>;

  /**
   * Azure Table partition key name. Type: string (or Expression with resultType string).
   */
  azureTablePartitionKeyName?: Record<unknown>;

  /**
   * Azure Table row key name. Type: string (or Expression with resultType string).
   */
  azureTableRowKeyName?: Record<unknown>;

  /**
   * Azure Table insert type. Type: string (or Expression with resultType string).
   */
  azureTableInsertType?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "AzureTableSink";
}

/**
 * A copy activity Avro sink.
 */
model AvroSink extends CopySink {
  /**
   * Avro store settings.
   */
  storeSettings?: StoreWriteSettings;

  /**
   * Avro format settings.
   */
  formatSettings?: AvroWriteSettings;

  /**
   * Copy sink type.
   */
  type: "AvroSink";
}

/**
 * A copy activity Parquet sink.
 */
model ParquetSink extends CopySink {
  /**
   * Parquet store settings.
   */
  storeSettings?: StoreWriteSettings;

  /**
   * Parquet format settings.
   */
  formatSettings?: ParquetWriteSettings;

  /**
   * Copy sink type.
   */
  type: "ParquetSink";
}

/**
 * A copy activity Binary sink.
 */
model BinarySink extends CopySink {
  /**
   * Binary store settings.
   */
  storeSettings?: StoreWriteSettings;

  /**
   * Copy sink type.
   */
  type: "BinarySink";
}

/**
 * A copy activity Azure Blob sink.
 */
model BlobSink extends CopySink {
  /**
   * Blob writer overwrite files. Type: boolean (or Expression with resultType boolean).
   */
  blobWriterOverwriteFiles?: Record<unknown>;

  /**
   * Blob writer date time format. Type: string (or Expression with resultType string).
   */
  blobWriterDateTimeFormat?: Record<unknown>;

  /**
   * Blob writer add header. Type: boolean (or Expression with resultType boolean).
   */
  blobWriterAddHeader?: Record<unknown>;

  /**
   * The type of copy behavior for copy sink.
   */
  copyBehavior?: Record<unknown>;

  /**
   * Specify the custom metadata to be added to sink data. Type: array of objects (or Expression with resultType array of objects).
   */
  metadata?: MetadataItem[];

  /**
   * Copy sink type.
   */
  type: "BlobSink";
}

/**
 * Specify the name and value of custom metadata item.
 */
model MetadataItem {
  /**
   * Metadata item key name. Type: string (or Expression with resultType string).
   */
  name?: Record<unknown>;

  /**
   * Metadata item value. Type: string (or Expression with resultType string).
   */
  value?: Record<unknown>;
}

/**
 * A copy activity file system sink.
 */
model FileSystemSink extends CopySink {
  /**
   * The type of copy behavior for copy sink.
   */
  copyBehavior?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "FileSystemSink";
}

/**
 * A copy activity Document Database Collection sink.
 */
model DocumentDbCollectionSink extends CopySink {
  /**
   * Nested properties separator. Default is . (dot). Type: string (or Expression with resultType string).
   */
  nestingSeparator?: Record<unknown>;

  /**
   * Describes how to write data to Azure Cosmos DB. Type: string (or Expression with resultType string). Allowed values: insert and upsert.
   */
  writeBehavior?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "DocumentDbCollectionSink";
}

/**
 * A copy activity Azure CosmosDB (SQL API) Collection sink.
 */
model CosmosDbSqlApiSink extends CopySink {
  /**
   * Describes how to write data to Azure Cosmos DB. Type: string (or Expression with resultType string). Allowed values: insert and upsert.
   */
  writeBehavior?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "CosmosDbSqlApiSink";
}

/**
 * A copy activity SQL sink.
 */
model SqlSink extends CopySink {
  /**
   * SQL writer stored procedure name. Type: string (or Expression with resultType string).
   */
  sqlWriterStoredProcedureName?: Record<unknown>;

  /**
   * SQL writer table type. Type: string (or Expression with resultType string).
   */
  sqlWriterTableType?: Record<unknown>;

  /**
   * SQL pre-copy script. Type: string (or Expression with resultType string).
   */
  preCopyScript?: Record<unknown>;

  /**
   * SQL stored procedure parameters.
   */
  storedProcedureParameters?: Record<unknown>;

  /**
   * The stored procedure parameter name of the table type. Type: string (or Expression with resultType string).
   */
  storedProcedureTableTypeParameterName?: Record<unknown>;

  /**
   * The option to handle sink table, such as autoCreate. For now only 'autoCreate' value is supported. Type: string (or Expression with resultType string).
   */
  tableOption?: Record<unknown>;

  /**
   * Whether to use table lock during bulk copy. Type: boolean (or Expression with resultType boolean).
   */
  sqlWriterUseTableLock?: Record<unknown>;

  /**
   * Write behavior when copying data into sql. Type: SqlWriteBehaviorEnum (or Expression with resultType SqlWriteBehaviorEnum)
   */
  writeBehavior?: Record<unknown>;

  /**
   * SQL upsert settings.
   */
  upsertSettings?: SqlUpsertSettings;

  /**
   * Copy sink type.
   */
  type: "SqlSink";
}

/**
 * Sql upsert option settings
 */
model SqlUpsertSettings {
  /**
   * Specifies whether to use temp db for upsert interim table. Type: boolean (or Expression with resultType boolean).
   */
  useTempDB?: Record<unknown>;

  /**
   * Schema name for interim table. Type: string (or Expression with resultType string).
   */
  interimSchemaName?: Record<unknown>;

  /**
   * Key column names for unique row identification. Type: array of strings (or Expression with resultType array of strings).
   */
  keys?: Record<unknown>;
}

/**
 * A copy activity SQL server sink.
 */
model SqlServerSink extends CopySink {
  /**
   * SQL writer stored procedure name. Type: string (or Expression with resultType string).
   */
  sqlWriterStoredProcedureName?: Record<unknown>;

  /**
   * SQL writer table type. Type: string (or Expression with resultType string).
   */
  sqlWriterTableType?: Record<unknown>;

  /**
   * SQL pre-copy script. Type: string (or Expression with resultType string).
   */
  preCopyScript?: Record<unknown>;

  /**
   * SQL stored procedure parameters.
   */
  storedProcedureParameters?: Record<unknown>;

  /**
   * The stored procedure parameter name of the table type. Type: string (or Expression with resultType string).
   */
  storedProcedureTableTypeParameterName?: Record<unknown>;

  /**
   * The option to handle sink table, such as autoCreate. For now only 'autoCreate' value is supported. Type: string (or Expression with resultType string).
   */
  tableOption?: Record<unknown>;

  /**
   * Whether to use table lock during bulk copy. Type: boolean (or Expression with resultType boolean).
   */
  sqlWriterUseTableLock?: Record<unknown>;

  /**
   * Write behavior when copying data into sql server. Type: SqlWriteBehaviorEnum (or Expression with resultType SqlWriteBehaviorEnum)
   */
  writeBehavior?: Record<unknown>;

  /**
   * SQL upsert settings.
   */
  upsertSettings?: SqlUpsertSettings;

  /**
   * Copy sink type.
   */
  type: "SqlServerSink";
}

/**
 * A copy activity Azure SQL sink.
 */
model AzureSqlSink extends CopySink {
  /**
   * SQL writer stored procedure name. Type: string (or Expression with resultType string).
   */
  sqlWriterStoredProcedureName?: Record<unknown>;

  /**
   * SQL writer table type. Type: string (or Expression with resultType string).
   */
  sqlWriterTableType?: Record<unknown>;

  /**
   * SQL pre-copy script. Type: string (or Expression with resultType string).
   */
  preCopyScript?: Record<unknown>;

  /**
   * SQL stored procedure parameters.
   */
  storedProcedureParameters?: Record<unknown>;

  /**
   * The stored procedure parameter name of the table type. Type: string (or Expression with resultType string).
   */
  storedProcedureTableTypeParameterName?: Record<unknown>;

  /**
   * The option to handle sink table, such as autoCreate. For now only 'autoCreate' value is supported. Type: string (or Expression with resultType string).
   */
  tableOption?: Record<unknown>;

  /**
   * Whether to use table lock during bulk copy. Type: boolean (or Expression with resultType boolean).
   */
  sqlWriterUseTableLock?: Record<unknown>;

  /**
   * Write behavior when copying data into Azure SQL. Type: SqlWriteBehaviorEnum (or Expression with resultType SqlWriteBehaviorEnum)
   */
  writeBehavior?: Record<unknown>;

  /**
   * SQL upsert settings.
   */
  upsertSettings?: SqlUpsertSettings;

  /**
   * Copy sink type.
   */
  type: "AzureSqlSink";
}

/**
 * A copy activity Azure SQL Managed Instance sink.
 */
model SqlMISink extends CopySink {
  /**
   * SQL writer stored procedure name. Type: string (or Expression with resultType string).
   */
  sqlWriterStoredProcedureName?: Record<unknown>;

  /**
   * SQL writer table type. Type: string (or Expression with resultType string).
   */
  sqlWriterTableType?: Record<unknown>;

  /**
   * SQL pre-copy script. Type: string (or Expression with resultType string).
   */
  preCopyScript?: Record<unknown>;

  /**
   * SQL stored procedure parameters.
   */
  storedProcedureParameters?: Record<unknown>;

  /**
   * The stored procedure parameter name of the table type. Type: string (or Expression with resultType string).
   */
  storedProcedureTableTypeParameterName?: Record<unknown>;

  /**
   * The option to handle sink table, such as autoCreate. For now only 'autoCreate' value is supported. Type: string (or Expression with resultType string).
   */
  tableOption?: Record<unknown>;

  /**
   * Whether to use table lock during bulk copy. Type: boolean (or Expression with resultType boolean).
   */
  sqlWriterUseTableLock?: Record<unknown>;

  /**
   * White behavior when copying data into azure SQL MI. Type: SqlWriteBehaviorEnum (or Expression with resultType SqlWriteBehaviorEnum)
   */
  writeBehavior?: Record<unknown>;

  /**
   * SQL upsert settings.
   */
  upsertSettings?: SqlUpsertSettings;

  /**
   * Copy sink type.
   */
  type: "SqlMISink";
}

/**
 * A copy activity SQL Data Warehouse sink.
 */
model SqlDWSink extends CopySink {
  /**
   * SQL pre-copy script. Type: string (or Expression with resultType string).
   */
  preCopyScript?: Record<unknown>;

  /**
   * Indicates to use PolyBase to copy data into SQL Data Warehouse when applicable. Type: boolean (or Expression with resultType boolean).
   */
  allowPolyBase?: Record<unknown>;

  /**
   * Specifies PolyBase-related settings when allowPolyBase is true.
   */
  polyBaseSettings?: PolybaseSettings;

  /**
   * Indicates to use Copy Command to copy data into SQL Data Warehouse. Type: boolean (or Expression with resultType boolean).
   */
  allowCopyCommand?: Record<unknown>;

  /**
   * Specifies Copy Command related settings when allowCopyCommand is true.
   */
  copyCommandSettings?: DWCopyCommandSettings;

  /**
   * The option to handle sink table, such as autoCreate. For now only 'autoCreate' value is supported. Type: string (or Expression with resultType string).
   */
  tableOption?: Record<unknown>;

  /**
   * Whether to use table lock during bulk copy. Type: boolean (or Expression with resultType boolean).
   */
  sqlWriterUseTableLock?: Record<unknown>;

  /**
   * Write behavior when copying data into azure SQL DW. Type: SqlDWWriteBehaviorEnum (or Expression with resultType SqlDWWriteBehaviorEnum)
   */
  writeBehavior?: Record<unknown>;

  /**
   * SQL DW upsert settings.
   */
  upsertSettings?: SqlDWUpsertSettings;

  /**
   * Copy sink type.
   */
  type: "SqlDWSink";
}

/**
 * PolyBase settings.
 */
model PolybaseSettings extends Record<Record<unknown>> {
  /**
   * Reject type.
   */
  rejectType?: PolybaseSettingsRejectType;

  /**
   * Specifies the value or the percentage of rows that can be rejected before the query fails. Type: number (or Expression with resultType number), minimum: 0.
   */
  rejectValue?: Record<unknown>;

  /**
   * Determines the number of rows to attempt to retrieve before the PolyBase recalculates the percentage of rejected rows. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  rejectSampleValue?: Record<unknown>;

  /**
   * Specifies how to handle missing values in delimited text files when PolyBase retrieves data from the text file. Type: boolean (or Expression with resultType boolean).
   */
  useTypeDefault?: Record<unknown>;
}

/**
 * DW Copy Command settings.
 */
model DWCopyCommandSettings {
  /**
   * Specifies the default values for each target column in SQL DW. The default values in the property overwrite the DEFAULT constraint set in the DB, and identity column cannot have a default value. Type: array of objects (or Expression with resultType array of objects).
   */
  defaultValues?: DWCopyCommandDefaultValue[];

  /**
   * Additional options directly passed to SQL DW in Copy Command. Type: key value pairs (value should be string type) (or Expression with resultType object). Example: "additionalOptions": { "MAXERRORS": "1000", "DATEFORMAT": "'ymd'" }
   */
  additionalOptions?: Record<string>;
}

/**
 * Default value.
 */
model DWCopyCommandDefaultValue {
  /**
   * Column name. Type: object (or Expression with resultType string).
   */
  columnName?: Record<unknown>;

  /**
   * The default value of the column. Type: object (or Expression with resultType string).
   */
  defaultValue?: Record<unknown>;
}

/**
 * Sql DW upsert option settings
 */
model SqlDWUpsertSettings {
  /**
   * Schema name for interim table. Type: string (or Expression with resultType string).
   */
  interimSchemaName?: Record<unknown>;

  /**
   * Key column names for unique row identification. Type: array of strings (or Expression with resultType array of strings).
   */
  keys?: Record<unknown>;
}

/**
 * A copy activity snowflake sink.
 */
model SnowflakeSink extends CopySink {
  /**
   * SQL pre-copy script. Type: string (or Expression with resultType string).
   */
  preCopyScript?: Record<unknown>;

  /**
   * Snowflake import settings.
   */
  importSettings?: SnowflakeImportCopyCommand;

  /**
   * Copy sink type.
   */
  type: "SnowflakeSink";
}

/**
 * Snowflake import command settings.
 */
model SnowflakeImportCopyCommand extends ImportSettings {
  /**
   * Additional copy options directly passed to snowflake Copy Command. Type: key value pairs (value should be string type) (or Expression with resultType object). Example: "additionalCopyOptions": { "DATE_FORMAT": "MM/DD/YYYY", "TIME_FORMAT": "'HH24:MI:SS.FF'" }
   */
  additionalCopyOptions?: Record<Record<unknown>>;

  /**
   * Additional format options directly passed to snowflake Copy Command. Type: key value pairs (value should be string type) (or Expression with resultType object). Example: "additionalFormatOptions": { "FORCE": "TRUE", "LOAD_UNCERTAIN_FILES": "'FALSE'" }
   */
  additionalFormatOptions?: Record<Record<unknown>>;

  /**
   * The import setting type.
   */
  type: "SnowflakeImportCopyCommand";
}

/**
 * Specify the column name and value of additional columns.
 */
model AdditionalColumns {
  /**
   * Additional column name. Type: string (or Expression with resultType string).
   */
  name?: Record<unknown>;

  /**
   * Additional column value. Type: string (or Expression with resultType string).
   */
  value?: Record<unknown>;
}

/**
 * A copy activity Oracle sink.
 */
model OracleSink extends CopySink {
  /**
   * SQL pre-copy script. Type: string (or Expression with resultType string).
   */
  preCopyScript?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "OracleSink";
}

/**
 * A copy activity Azure Data Lake Store sink.
 */
model AzureDataLakeStoreSink extends CopySink {
  /**
   * The type of copy behavior for copy sink. Type: string (or Expression with resultType string).
   */
  copyBehavior?: Record<unknown>;

  /**
   * Single File Parallel.
   */
  enableAdlsSingleFileParallel?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "AzureDataLakeStoreSink";
}

/**
 * A copy activity Azure Data Lake Storage Gen2 sink.
 */
model AzureBlobFSSink extends CopySink {
  /**
   * The type of copy behavior for copy sink. Type: string (or Expression with resultType string).
   */
  copyBehavior?: Record<unknown>;

  /**
   * Specify the custom metadata to be added to sink data. Type: array of objects (or Expression with resultType array of objects).
   */
  metadata?: MetadataItem[];

  /**
   * Copy sink type.
   */
  type: "AzureBlobFSSink";
}

/**
 * A copy activity Azure Search Index sink.
 */
model AzureSearchIndexSink extends CopySink {
  /**
   * Specify the write behavior when upserting documents into Azure Search Index.
   */
  writeBehavior?: AzureSearchIndexWriteBehaviorType;

  /**
   * Copy sink type.
   */
  type: "AzureSearchIndexSink";
}

/**
 * A copy activity ODBC sink.
 */
model OdbcSink extends CopySink {
  /**
   * A query to execute before starting the copy. Type: string (or Expression with resultType string).
   */
  preCopyScript?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "OdbcSink";
}

/**
 * A copy activity Informix sink.
 */
model InformixSink extends CopySink {
  /**
   * A query to execute before starting the copy. Type: string (or Expression with resultType string).
   */
  preCopyScript?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "InformixSink";
}

/**
 * A copy activity Microsoft Access sink.
 */
model MicrosoftAccessSink extends CopySink {
  /**
   * A query to execute before starting the copy. Type: string (or Expression with resultType string).
   */
  preCopyScript?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "MicrosoftAccessSink";
}

/**
 * A copy activity Dynamics sink.
 */
model DynamicsSink extends CopySink {
  /**
   * The write behavior for the operation.
   */
  writeBehavior: DynamicsSinkWriteBehavior;

  /**
   * The flag indicating whether ignore null values from input dataset (except key fields) during write operation. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  ignoreNullValues?: Record<unknown>;

  /**
   * The logical name of the alternate key which will be used when upserting records. Type: string (or Expression with resultType string).
   */
  alternateKeyName?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "DynamicsSink";
}

/**
 * A copy activity Dynamics CRM sink.
 */
model DynamicsCrmSink extends CopySink {
  /**
   * The write behavior for the operation.
   */
  writeBehavior: DynamicsSinkWriteBehavior;

  /**
   * The flag indicating whether to ignore null values from input dataset (except key fields) during write operation. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  ignoreNullValues?: Record<unknown>;

  /**
   * The logical name of the alternate key which will be used when upserting records. Type: string (or Expression with resultType string).
   */
  alternateKeyName?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "DynamicsCrmSink";
}

/**
 * A copy activity Common Data Service for Apps sink.
 */
model CommonDataServiceForAppsSink extends CopySink {
  /**
   * The write behavior for the operation.
   */
  writeBehavior: DynamicsSinkWriteBehavior;

  /**
   * The flag indicating whether to ignore null values from input dataset (except key fields) during write operation. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  ignoreNullValues?: Record<unknown>;

  /**
   * The logical name of the alternate key which will be used when upserting records. Type: string (or Expression with resultType string).
   */
  alternateKeyName?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "CommonDataServiceForAppsSink";
}

/**
 * A copy activity Azure Data Explorer sink.
 */
model AzureDataExplorerSink extends CopySink {
  /**
   * A name of a pre-created csv mapping that was defined on the target Kusto table. Type: string.
   */
  ingestionMappingName?: Record<unknown>;

  /**
   * An explicit column mapping description provided in a json format. Type: string.
   */
  ingestionMappingAsJson?: Record<unknown>;

  /**
   * If set to true, any aggregation will be skipped. Default is false. Type: boolean.
   */
  flushImmediately?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "AzureDataExplorerSink";
}

/**
 * A copy activity Salesforce sink.
 */
model SalesforceSink extends CopySink {
  /**
   * The write behavior for the operation. Default is Insert.
   */
  writeBehavior?: SalesforceSinkWriteBehavior;

  /**
   * The name of the external ID field for upsert operation. Default value is 'Id' column. Type: string (or Expression with resultType string).
   */
  externalIdFieldName?: Record<unknown>;

  /**
   * The flag indicating whether or not to ignore null values from input dataset (except key fields) during write operation. Default value is false. If set it to true, it means ADF will leave the data in the destination object unchanged when doing upsert/update operation and insert defined default value when doing insert operation, versus ADF will update the data in the destination object to NULL when doing upsert/update operation and insert NULL value when doing insert operation. Type: boolean (or Expression with resultType boolean).
   */
  ignoreNullValues?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "SalesforceSink";
}

/**
 * A copy activity Salesforce Service Cloud sink.
 */
model SalesforceServiceCloudSink extends CopySink {
  /**
   * The write behavior for the operation. Default is Insert.
   */
  writeBehavior?: SalesforceSinkWriteBehavior;

  /**
   * The name of the external ID field for upsert operation. Default value is 'Id' column. Type: string (or Expression with resultType string).
   */
  externalIdFieldName?: Record<unknown>;

  /**
   * The flag indicating whether or not to ignore null values from input dataset (except key fields) during write operation. Default value is false. If set it to true, it means ADF will leave the data in the destination object unchanged when doing upsert/update operation and insert defined default value when doing insert operation, versus ADF will update the data in the destination object to NULL when doing upsert/update operation and insert NULL value when doing insert operation. Type: boolean (or Expression with resultType boolean).
   */
  ignoreNullValues?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "SalesforceServiceCloudSink";
}

/**
 * A copy activity MongoDB Atlas sink.
 */
model MongoDbAtlasSink extends CopySink {
  /**
   * Specifies whether the document with same key to be overwritten (upsert) rather than throw exception (insert). The default value is "insert". Type: string (or Expression with resultType string). Type: string (or Expression with resultType string).
   */
  writeBehavior?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "MongoDbAtlasSink";
}

/**
 * A copy activity MongoDB sink.
 */
model MongoDbV2Sink extends CopySink {
  /**
   * Specifies whether the document with same key to be overwritten (upsert) rather than throw exception (insert). The default value is "insert". Type: string (or Expression with resultType string). Type: string (or Expression with resultType string).
   */
  writeBehavior?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "MongoDbV2Sink";
}

/**
 * A copy activity sink for a CosmosDB (MongoDB API) database.
 */
model CosmosDbMongoDbApiSink extends CopySink {
  /**
   * Specifies whether the document with same key to be overwritten (upsert) rather than throw exception (insert). The default value is "insert". Type: string (or Expression with resultType string). Type: string (or Expression with resultType string).
   */
  writeBehavior?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "CosmosDbMongoDbApiSink";
}

/**
 * A copy activity for Microsoft Fabric LakeHouse Table sink.
 */
model LakeHouseTableSink extends CopySink {
  /**
   * The type of table action for LakeHouse Table sink. Possible values include: "None", "Append", "Overwrite".
   */
  tableActionOption?: Record<unknown>;

  /**
   * Create partitions in folder structure based on one or multiple columns. Each distinct column value (pair) will be a new partition. Possible values include: "None", "PartitionByKey".
   */
  partitionOption?: Record<unknown>;

  /**
   * Specify the partition column names from sink columns. Type: array of objects (or Expression with resultType array of objects).
   */
  partitionNameList?: Record<unknown>;

  /**
   * Copy sink type.
   */
  type: "LakeHouseTableSink";
}

/**
 * A copy activity translator.
 */
@discriminator("type")
model CopyTranslator extends Record<Record<unknown>> {}

/**
 * A copy activity tabular translator.
 */
model TabularTranslator extends CopyTranslator {
  /**
   * Column mappings. Example: "UserId: MyUserId, Group: MyGroup, Name: MyName" Type: string (or Expression with resultType string). This property will be retired. Please use mappings property.
   */
  columnMappings?: Record<unknown>;

  /**
   * The schema mapping to map between tabular data and hierarchical data. Example: {"Column1": "$.Column1", "Column2": "$.Column2.Property1", "Column3": "$.Column2.Property2"}. Type: object (or Expression with resultType object). This property will be retired. Please use mappings property.
   */
  schemaMapping?: Record<unknown>;

  /**
   * The JSON Path of the Nested Array that is going to do cross-apply. Type: object (or Expression with resultType object).
   */
  collectionReference?: Record<unknown>;

  /**
   * Whether to map complex (array and object) values to simple strings in json format. Type: boolean (or Expression with resultType boolean).
   */
  mapComplexValuesToString?: Record<unknown>;

  /**
   * Column mappings with logical types. Tabular->tabular example: [{"source":{"name":"CustomerName","type":"String"},"sink":{"name":"ClientName","type":"String"}},{"source":{"name":"CustomerAddress","type":"String"},"sink":{"name":"ClientAddress","type":"String"}}].  Hierarchical->tabular example: [{"source":{"path":"$.CustomerName","type":"String"},"sink":{"name":"ClientName","type":"String"}},{"source":{"path":"$.CustomerAddress","type":"String"},"sink":{"name":"ClientAddress","type":"String"}}]. Type: object (or Expression with resultType object).
   */
  mappings?: Record<unknown>;

  /**
   * Whether to enable the advanced type conversion feature in the Copy activity. Type: boolean (or Expression with resultType boolean).
   */
  typeConversion?: Record<unknown>;

  /**
   * Type conversion settings
   */
  typeConversionSettings?: TypeConversionSettings;

  /**
   * Copy translator type.
   */
  type: "TabularTranslator";
}

/**
 * Type conversion settings
 */
model TypeConversionSettings {
  /**
   * Whether to allow data truncation when converting the data. Type: boolean (or Expression with resultType boolean).
   */
  allowDataTruncation?: Record<unknown>;

  /**
   * Whether to treat boolean values as numbers. Type: boolean (or Expression with resultType boolean).
   */
  treatBooleanAsNumber?: Record<unknown>;

  /**
   * The format for DateTime values. Type: string (or Expression with resultType string).
   */
  dateTimeFormat?: Record<unknown>;

  /**
   * The format for DateTimeOffset values. Type: string (or Expression with resultType string).
   */
  dateTimeOffsetFormat?: Record<unknown>;

  /**
   * The format for TimeSpan values. Type: string (or Expression with resultType string).
   */
  timeSpanFormat?: Record<unknown>;

  /**
   * The culture used to convert data from/to string. Type: string (or Expression with resultType string).
   */
  culture?: Record<unknown>;
}

/**
 * HDInsight Hive activity type.
 */
model HDInsightHiveActivity extends ExecutionActivity {
  /**
   * HDInsight Hive activity properties.
   */
  typeProperties: HDInsightHiveActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "HDInsightHive";
}

/**
 * HDInsight Hive activity properties.
 */
model HDInsightHiveActivityTypeProperties {
  /**
   * Storage linked service references.
   */
  storageLinkedServices?: LinkedServiceReference[];

  /**
   * User specified arguments to HDInsightActivity.
   */
  arguments?: Record<unknown>[];

  /**
   * Debug info option.
   */
  getDebugInfo?: HDInsightActivityDebugInfoOption;

  /**
   * Script path. Type: string (or Expression with resultType string).
   */
  scriptPath?: Record<unknown>;

  /**
   * Script linked service reference.
   */
  scriptLinkedService?: LinkedServiceReference;

  /**
   * Allows user to specify defines for Hive job request.
   */
  defines?: Record<Record<unknown>>;

  /**
   * User specified arguments under hivevar namespace.
   */
  variables?: Record<Record<unknown>>;

  /**
   * Query timeout value (in minutes).  Effective when the HDInsight cluster is with ESP (Enterprise Security Package)
   */
  queryTimeout?: int32;
}

/**
 * HDInsight Pig activity type.
 */
model HDInsightPigActivity extends ExecutionActivity {
  /**
   * HDInsight Pig activity properties.
   */
  typeProperties: HDInsightPigActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "HDInsightPig";
}

/**
 * HDInsight Pig activity properties.
 */
model HDInsightPigActivityTypeProperties {
  /**
   * Storage linked service references.
   */
  storageLinkedServices?: LinkedServiceReference[];

  /**
   * User specified arguments to HDInsightActivity. Type: array (or Expression with resultType array).
   */
  arguments?: Record<unknown>;

  /**
   * Debug info option.
   */
  getDebugInfo?: HDInsightActivityDebugInfoOption;

  /**
   * Script path. Type: string (or Expression with resultType string).
   */
  scriptPath?: Record<unknown>;

  /**
   * Script linked service reference.
   */
  scriptLinkedService?: LinkedServiceReference;

  /**
   * Allows user to specify defines for Pig job request.
   */
  defines?: Record<Record<unknown>>;
}

/**
 * HDInsight MapReduce activity type.
 */
model HDInsightMapReduceActivity extends ExecutionActivity {
  /**
   * HDInsight MapReduce activity properties.
   */
  typeProperties: HDInsightMapReduceActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "HDInsightMapReduce";
}

/**
 * HDInsight MapReduce activity properties.
 */
model HDInsightMapReduceActivityTypeProperties {
  /**
   * Storage linked service references.
   */
  storageLinkedServices?: LinkedServiceReference[];

  /**
   * User specified arguments to HDInsightActivity.
   */
  arguments?: Record<unknown>[];

  /**
   * Debug info option.
   */
  getDebugInfo?: HDInsightActivityDebugInfoOption;

  /**
   * Class name. Type: string (or Expression with resultType string).
   */
  className: Record<unknown>;

  /**
   * Jar path. Type: string (or Expression with resultType string).
   */
  jarFilePath: Record<unknown>;

  /**
   * Jar linked service reference.
   */
  jarLinkedService?: LinkedServiceReference;

  /**
   * Jar libs.
   */
  jarLibs?: Record<unknown>[];

  /**
   * Allows user to specify defines for the MapReduce job request.
   */
  defines?: Record<Record<unknown>>;
}

/**
 * HDInsight streaming activity type.
 */
model HDInsightStreamingActivity extends ExecutionActivity {
  /**
   * HDInsight streaming activity properties.
   */
  typeProperties: HDInsightStreamingActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "HDInsightStreaming";
}

/**
 * HDInsight streaming activity properties.
 */
model HDInsightStreamingActivityTypeProperties {
  /**
   * Storage linked service references.
   */
  storageLinkedServices?: LinkedServiceReference[];

  /**
   * User specified arguments to HDInsightActivity.
   */
  arguments?: Record<unknown>[];

  /**
   * Debug info option.
   */
  getDebugInfo?: HDInsightActivityDebugInfoOption;

  /**
   * Mapper executable name. Type: string (or Expression with resultType string).
   */
  mapper: Record<unknown>;

  /**
   * Reducer executable name. Type: string (or Expression with resultType string).
   */
  reducer: Record<unknown>;

  /**
   * Input blob path. Type: string (or Expression with resultType string).
   */
  input: Record<unknown>;

  /**
   * Output blob path. Type: string (or Expression with resultType string).
   */
  output: Record<unknown>;

  /**
   * Paths to streaming job files. Can be directories.
   */
  filePaths: Record<unknown>[];

  /**
   * Linked service reference where the files are located.
   */
  fileLinkedService?: LinkedServiceReference;

  /**
   * Combiner executable name. Type: string (or Expression with resultType string).
   */
  combiner?: Record<unknown>;

  /**
   * Command line environment values.
   */
  commandEnvironment?: Record<unknown>[];

  /**
   * Allows user to specify defines for streaming job request.
   */
  defines?: Record<Record<unknown>>;
}

/**
 * HDInsight Spark activity.
 */
model HDInsightSparkActivity extends ExecutionActivity {
  /**
   * HDInsight spark activity properties.
   */
  typeProperties: HDInsightSparkActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "HDInsightSpark";
}

/**
 * HDInsight spark activity properties.
 */
model HDInsightSparkActivityTypeProperties {
  /**
   * The root path in 'sparkJobLinkedService' for all the job’s files. Type: string (or Expression with resultType string).
   */
  rootPath: Record<unknown>;

  /**
   * The relative path to the root folder of the code/package to be executed. Type: string (or Expression with resultType string).
   */
  entryFilePath: Record<unknown>;

  /**
   * The user-specified arguments to HDInsightSparkActivity.
   */
  arguments?: Record<unknown>[];

  /**
   * Debug info option.
   */
  getDebugInfo?: HDInsightActivityDebugInfoOption;

  /**
   * The storage linked service for uploading the entry file and dependencies, and for receiving logs.
   */
  sparkJobLinkedService?: LinkedServiceReference;

  /**
   * The application's Java/Spark main class.
   */
  className?: string;

  /**
   * The user to impersonate that will execute the job. Type: string (or Expression with resultType string).
   */
  proxyUser?: Record<unknown>;

  /**
   * Spark configuration property.
   */
  sparkConfig?: Record<Record<unknown>>;
}

/**
 * Execute SSIS package activity.
 */
model ExecuteSsisPackageActivity extends ExecutionActivity {
  /**
   * Execute SSIS package activity properties.
   */
  typeProperties: ExecuteSsisPackageActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "ExecuteSSISPackage";
}

/**
 * Execute SSIS package activity properties.
 */
model ExecuteSsisPackageActivityTypeProperties {
  /**
   * SSIS package location.
   */
  packageLocation: SsisPackageLocation;

  /**
   * Specifies the runtime to execute SSIS package. The value should be "x86" or "x64". Type: string (or Expression with resultType string).
   */
  runtime?: Record<unknown>;

  /**
   * The logging level of SSIS package execution. Type: string (or Expression with resultType string).
   */
  loggingLevel?: Record<unknown>;

  /**
   * The environment path to execute the SSIS package. Type: string (or Expression with resultType string).
   */
  environmentPath?: Record<unknown>;

  /**
   * The package execution credential.
   */
  executionCredential?: SsisExecutionCredential;

  /**
   * The integration runtime reference.
   */
  connectVia: IntegrationRuntimeReference;

  /**
   * The project level parameters to execute the SSIS package.
   */
  projectParameters?: Record<SsisExecutionParameter>;

  /**
   * The package level parameters to execute the SSIS package.
   */
  packageParameters?: Record<SsisExecutionParameter>;

  /**
   * The project level connection managers to execute the SSIS package.
   */
  projectConnectionManagers?: Record<Record<SsisExecutionParameter>>;

  /**
   * The package level connection managers to execute the SSIS package.
   */
  packageConnectionManagers?: Record<Record<SsisExecutionParameter>>;

  /**
   * The property overrides to execute the SSIS package.
   */
  propertyOverrides?: Record<SsisPropertyOverride>;

  /**
   * SSIS package execution log location.
   */
  logLocation?: SsisLogLocation;
}

/**
 * SSIS package location.
 */
model SsisPackageLocation {
  /**
   * The SSIS package path. Type: string (or Expression with resultType string).
   */
  packagePath?: Record<unknown>;

  /**
   * The type of SSIS package location.
   */
  type?: SsisPackageLocationType;

  /**
   * SSIS package location properties.
   */
  typeProperties?: SsisPackageLocationTypeProperties;
}

/**
 * SSIS package location properties.
 */
model SsisPackageLocationTypeProperties {
  /**
   * Password of the package.
   */
  packagePassword?: SecretBase;

  /**
   * The package access credential.
   */
  accessCredential?: SsisAccessCredential;

  /**
   * The configuration file of the package execution. Type: string (or Expression with resultType string).
   */
  configurationPath?: Record<unknown>;

  /**
   * The configuration file access credential.
   */
  configurationAccessCredential?: SsisAccessCredential;

  /**
   * The package name.
   */
  packageName?: string;

  /**
   * The embedded package content. Type: string (or Expression with resultType string).
   */
  packageContent?: Record<unknown>;

  /**
   * The embedded package last modified date.
   */
  packageLastModifiedDate?: string;

  /**
   * The embedded child package list.
   */
  childPackages?: SsisChildPackage[];
}

/**
 * SSIS access credential.
 */
model SsisAccessCredential {
  /**
   * Domain for windows authentication. Type: string (or Expression with resultType string).
   */
  domain: Record<unknown>;

  /**
   * UseName for windows authentication. Type: string (or Expression with resultType string).
   */
  userName: Record<unknown>;

  /**
   * Password for windows authentication.
   */
  password: SecretBase;
}

/**
 * SSIS embedded child package.
 */
model SsisChildPackage {
  /**
   * Path for embedded child package. Type: string (or Expression with resultType string).
   */
  packagePath: Record<unknown>;

  /**
   * Name for embedded child package.
   */
  packageName?: string;

  /**
   * Content for embedded child package. Type: string (or Expression with resultType string).
   */
  packageContent: Record<unknown>;

  /**
   * Last modified date for embedded child package.
   */
  packageLastModifiedDate?: string;
}

/**
 * SSIS package execution credential.
 */
model SsisExecutionCredential {
  /**
   * Domain for windows authentication. Type: string (or Expression with resultType string).
   */
  domain: Record<unknown>;

  /**
   * UseName for windows authentication. Type: string (or Expression with resultType string).
   */
  userName: Record<unknown>;

  /**
   * Password for windows authentication.
   */
  password: SecureString;
}

/**
 * SSIS execution parameter.
 */
model SsisExecutionParameter {
  /**
   * SSIS package execution parameter value. Type: string (or Expression with resultType string).
   */
  value: Record<unknown>;
}

/**
 * SSIS property override.
 */
model SsisPropertyOverride {
  /**
   * SSIS package property override value. Type: string (or Expression with resultType string).
   */
  value: Record<unknown>;

  /**
   * Whether SSIS package property override value is sensitive data. Value will be encrypted in SSISDB if it is true
   */
  isSensitive?: boolean;
}

/**
 * SSIS package execution log location
 */
model SsisLogLocation {
  /**
   * The SSIS package execution log path. Type: string (or Expression with resultType string).
   */
  logPath: Record<unknown>;

  /**
   * The type of SSIS log location.
   */
  type: SsisLogLocationType;

  /**
   * SSIS package execution log location properties.
   */
  typeProperties: SsisLogLocationTypeProperties;
}

/**
 * SSIS package execution log location properties.
 */
model SsisLogLocationTypeProperties {
  /**
   * The package execution log access credential.
   */
  accessCredential?: SsisAccessCredential;

  /**
   * Specifies the interval to refresh log. The default interval is 5 minutes. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  logRefreshInterval?: Record<unknown>;
}

/**
 * Custom activity type.
 */
model CustomActivity extends ExecutionActivity {
  /**
   * Custom activity properties.
   */
  typeProperties: CustomActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "Custom";
}

/**
 * Custom activity properties.
 */
model CustomActivityTypeProperties {
  /**
   * Command for custom activity Type: string (or Expression with resultType string).
   */
  command: Record<unknown>;

  /**
   * Resource linked service reference.
   */
  resourceLinkedService?: LinkedServiceReference;

  /**
   * Folder path for resource files Type: string (or Expression with resultType string).
   */
  folderPath?: Record<unknown>;

  /**
   * Reference objects
   */
  referenceObjects?: CustomActivityReferenceObject;

  /**
   * User defined property bag. There is no restriction on the keys or values that can be used. The user specified custom activity has the full responsibility to consume and interpret the content defined.
   */
  extendedProperties?: Record<Record<unknown>>;

  /**
   * The retention time for the files submitted for custom activity. Type: double (or Expression with resultType double).
   */
  retentionTimeInDays?: Record<unknown>;

  /**
   * Elevation level and scope for the user, default is nonadmin task. Type: string (or Expression with resultType double).
   */
  autoUserSpecification?: Record<unknown>;
}

/**
 * Reference objects for custom activity
 */
model CustomActivityReferenceObject {
  /**
   * Linked service references.
   */
  linkedServices?: LinkedServiceReference[];

  /**
   * Dataset references.
   */
  datasets?: DatasetReference[];
}

/**
 * SQL stored procedure activity type.
 */
model SqlServerStoredProcedureActivity extends ExecutionActivity {
  /**
   * SQL stored procedure activity properties.
   */
  typeProperties: SqlServerStoredProcedureActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "SqlServerStoredProcedure";
}

/**
 * SQL stored procedure activity properties.
 */
model SqlServerStoredProcedureActivityTypeProperties {
  /**
   * Stored procedure name. Type: string (or Expression with resultType string).
   */
  storedProcedureName: Record<unknown>;

  /**
   * Value and type setting for stored procedure parameters. Example: "{Parameter1: {value: "1", type: "int"}}".
   */
  storedProcedureParameters?: Record<unknown>;
}

/**
 * Execute pipeline activity.
 */
model ExecutePipelineActivity extends ControlActivity {
  /**
   * Execute pipeline activity policy.
   */
  policy?: ExecutePipelineActivityPolicy;

  /**
   * Execute pipeline activity properties.
   */
  typeProperties: ExecutePipelineActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "ExecutePipeline";
}

/**
 * Execution policy for an execute pipeline activity.
 */
model ExecutePipelineActivityPolicy extends Record<Record<unknown>> {
  /**
   * When set to true, Input from activity is considered as secure and will not be logged to monitoring.
   */
  secureInput?: boolean;
}

/**
 * Execute pipeline activity properties.
 */
model ExecutePipelineActivityTypeProperties {
  /**
   * Pipeline reference.
   */
  pipeline: PipelineReference;

  /**
   * Pipeline parameters.
   */
  parameters?: Record<Record<unknown>>;

  /**
   * Defines whether activity execution will wait for the dependent pipeline execution to finish. Default is false.
   */
  waitOnCompletion?: boolean;
}

/**
 * Delete activity.
 */
model DeleteActivity extends ExecutionActivity {
  /**
   * Delete activity properties.
   */
  typeProperties: DeleteActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "Delete";
}

/**
 * Delete activity properties.
 */
model DeleteActivityTypeProperties {
  /**
   * If true, files or sub-folders under current folder path will be deleted recursively. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  recursive?: Record<unknown>;

  /**
   * The max concurrent connections to connect data source at the same time.
   */
  @minValue(1)
  maxConcurrentConnections?: int32;

  /**
   * Whether to record detailed logs of delete-activity execution. Default value is false. Type: boolean (or Expression with resultType boolean).
   */
  enableLogging?: Record<unknown>;

  /**
   * Log storage settings customer need to provide when enableLogging is true.
   */
  logStorageSettings?: LogStorageSettings;

  /**
   * Delete activity dataset reference.
   */
  dataset: DatasetReference;

  /**
   * Delete activity store settings.
   */
  storeSettings?: StoreReadSettings;
}

/**
 * Azure Data Explorer command activity.
 */
model AzureDataExplorerCommandActivity extends ExecutionActivity {
  /**
   * Azure Data Explorer command activity properties.
   */
  typeProperties: AzureDataExplorerCommandActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "AzureDataExplorerCommand";
}

/**
 * Azure Data Explorer command activity properties.
 */
model AzureDataExplorerCommandActivityTypeProperties {
  /**
   * A control command, according to the Azure Data Explorer command syntax. Type: string (or Expression with resultType string).
   */
  command: Record<unknown>;

  /**
   * Control command timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9]))..)
   */
  commandTimeout?: Record<unknown>;
}

/**
 * Lookup activity.
 */
model LookupActivity extends ExecutionActivity {
  /**
   * Lookup activity properties.
   */
  typeProperties: LookupActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "Lookup";
}

/**
 * Lookup activity properties.
 */
model LookupActivityTypeProperties {
  /**
   * Dataset-specific source properties, same as copy activity source.
   */
  source: CopySource;

  /**
   * Lookup activity dataset reference.
   */
  dataset: DatasetReference;

  /**
   * Whether to return first row or all rows. Default value is true. Type: boolean (or Expression with resultType boolean).
   */
  firstRowOnly?: Record<unknown>;
}

/**
 * Web activity.
 */
model WebActivity extends ExecutionActivity {
  /**
   * Web activity properties.
   */
  typeProperties: WebActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "WebActivity";
}

/**
 * Web activity type properties.
 */
model WebActivityTypeProperties {
  /**
   * Rest API method for target endpoint.
   */
  method: WebActivityMethod;

  /**
   * Web activity target endpoint and path. Type: string (or Expression with resultType string).
   */
  url: Record<unknown>;

  /**
   * Represents the headers that will be sent to the request. For example, to set the language and type on a request: "headers" : { "Accept-Language": "en-us", "Content-Type": "application/json" }. Type: string (or Expression with resultType string).
   */
  headers?: Record<unknown>;

  /**
   * Represents the payload that will be sent to the endpoint. Required for POST/PUT method, not allowed for GET method Type: string (or Expression with resultType string).
   */
  body?: Record<unknown>;

  /**
   * Authentication method used for calling the endpoint.
   */
  authentication?: WebActivityAuthentication;

  /**
   * When set to true, Certificate validation will be disabled.
   */
  disableCertValidation?: boolean;

  /**
   * List of datasets passed to web endpoint.
   */
  datasets?: DatasetReference[];

  /**
   * List of linked services passed to web endpoint.
   */
  linkedServices?: LinkedServiceReference[];

  /**
   * The integration runtime reference.
   */
  connectVia?: IntegrationRuntimeReference;
}

/**
 * Web activity authentication properties.
 */
model WebActivityAuthentication {
  /**
   * Web activity authentication (Basic/ClientCertificate/MSI/ServicePrincipal)
   */
  type?: string;

  /**
   * Base64-encoded contents of a PFX file or Certificate when used for ServicePrincipal
   */
  pfx?: SecretBase;

  /**
   * Web activity authentication user name for basic authentication or ClientID when used for ServicePrincipal. Type: string (or Expression with resultType string).
   */
  username?: Record<unknown>;

  /**
   * Password for the PFX file or basic authentication / Secret when used for ServicePrincipal
   */
  password?: SecretBase;

  /**
   * Resource for which Azure Auth token will be requested when using MSI Authentication. Type: string (or Expression with resultType string).
   */
  resource?: Record<unknown>;

  /**
   * TenantId for which Azure Auth token will be requested when using ServicePrincipal Authentication. Type: string (or Expression with resultType string).
   */
  userTenant?: Record<unknown>;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * Activity to get metadata of dataset
 */
model GetMetadataActivity extends ExecutionActivity {
  /**
   * GetMetadata activity properties.
   */
  typeProperties: GetMetadataActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "GetMetadata";
}

/**
 * GetMetadata activity properties.
 */
model GetMetadataActivityTypeProperties {
  /**
   * GetMetadata activity dataset reference.
   */
  dataset: DatasetReference;

  /**
   * Fields of metadata to get from dataset.
   */
  fieldList?: Record<unknown>[];

  /**
   * GetMetadata activity store settings.
   */
  storeSettings?: StoreReadSettings;

  /**
   * GetMetadata activity format settings.
   */
  formatSettings?: FormatReadSettings;
}

/**
 * This activity evaluates a boolean expression and executes either the activities under the ifTrueActivities property or the ifFalseActivities property depending on the result of the expression.
 */
model IfConditionActivity extends ControlActivity {
  /**
   * IfCondition activity properties.
   */
  typeProperties: IfConditionActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "IfCondition";
}

/**
 * IfCondition activity properties.
 */
model IfConditionActivityTypeProperties {
  /**
   * An expression that would evaluate to Boolean. This is used to determine the block of activities (ifTrueActivities or ifFalseActivities) that will be executed.
   */
  expression: Expression;

  /**
   * List of activities to execute if expression is evaluated to true. This is an optional property and if not provided, the activity will exit without any action.
   */
  ifTrueActivities?: Activity[];

  /**
   * List of activities to execute if expression is evaluated to false. This is an optional property and if not provided, the activity will exit without any action.
   */
  ifFalseActivities?: Activity[];
}

/**
 * This activity evaluates an expression and executes activities under the cases property that correspond to the expression evaluation expected in the equals property.
 */
model SwitchActivity extends ControlActivity {
  /**
   * Switch activity properties.
   */
  typeProperties: SwitchActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "Switch";
}

/**
 * Switch activity properties.
 */
model SwitchActivityTypeProperties {
  /**
   * An expression that would evaluate to a string or integer. This is used to determine the block of activities in cases that will be executed.
   */
  on: Expression;

  /**
   * List of cases that correspond to expected values of the 'on' property. This is an optional property and if not provided, the activity will execute activities provided in defaultActivities.
   */
  cases?: SwitchCase[];

  /**
   * List of activities to execute if no case condition is satisfied. This is an optional property and if not provided, the activity will exit without any action.
   */
  defaultActivities?: Activity[];
}

/**
 * Switch cases with have a value and corresponding activities.
 */
model SwitchCase {
  /**
   * Expected value that satisfies the expression result of the 'on' property.
   */
  value?: string;

  /**
   * List of activities to execute for satisfied case condition.
   */
  activities?: Activity[];
}

/**
 * This activity is used for iterating over a collection and execute given activities.
 */
model ForEachActivity extends ControlActivity {
  /**
   * ForEach activity properties.
   */
  typeProperties: ForEachActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "ForEach";
}

/**
 * ForEach activity properties.
 */
model ForEachActivityTypeProperties {
  /**
   * Should the loop be executed in sequence or in parallel (max 50)
   */
  isSequential?: boolean;

  /**
   * Batch count to be used for controlling the number of parallel execution (when isSequential is set to false).
   */
  @maxValue(50)
  batchCount?: int32;

  /**
   * Collection to iterate.
   */
  items: Expression;

  /**
   * List of activities to execute .
   */
  activities: Activity[];
}

/**
 * Azure ML Batch Execution activity.
 */
model AzureMLBatchExecutionActivity extends ExecutionActivity {
  /**
   * Azure ML Batch Execution activity properties.
   */
  typeProperties: AzureMLBatchExecutionActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "AzureMLBatchExecution";
}

/**
 * Azure ML Batch Execution activity properties.
 */
model AzureMLBatchExecutionActivityTypeProperties {
  /**
   * Key,Value pairs to be passed to the Azure ML Batch Execution Service endpoint. Keys must match the names of web service parameters defined in the published Azure ML web service. Values will be passed in the GlobalParameters property of the Azure ML batch execution request.
   */
  globalParameters?: Record<Record<unknown>>;

  /**
   * Key,Value pairs, mapping the names of Azure ML endpoint's Web Service Outputs to AzureMLWebServiceFile objects specifying the output Blob locations. This information will be passed in the WebServiceOutputs property of the Azure ML batch execution request.
   */
  webServiceOutputs?: Record<AzureMLWebServiceFile>;

  /**
   * Key,Value pairs, mapping the names of Azure ML endpoint's Web Service Inputs to AzureMLWebServiceFile objects specifying the input Blob locations.. This information will be passed in the WebServiceInputs property of the Azure ML batch execution request.
   */
  webServiceInputs?: Record<AzureMLWebServiceFile>;
}

/**
 * Azure ML WebService Input/Output file
 */
model AzureMLWebServiceFile {
  /**
   * The relative file path, including container name, in the Azure Blob Storage specified by the LinkedService. Type: string (or Expression with resultType string).
   */
  filePath: Record<unknown>;

  /**
   * Reference to an Azure Storage LinkedService, where Azure ML WebService Input/Output file located.
   */
  linkedServiceName: LinkedServiceReference;
}

/**
 * Azure ML Update Resource management activity.
 */
model AzureMLUpdateResourceActivity extends ExecutionActivity {
  /**
   * Azure ML Update Resource management activity properties.
   */
  typeProperties: AzureMLUpdateResourceActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "AzureMLUpdateResource";
}

/**
 * Azure ML Update Resource activity properties.
 */
model AzureMLUpdateResourceActivityTypeProperties {
  /**
   * Name of the Trained Model module in the Web Service experiment to be updated. Type: string (or Expression with resultType string).
   */
  trainedModelName: Record<unknown>;

  /**
   * Name of Azure Storage linked service holding the .ilearner file that will be uploaded by the update operation.
   */
  trainedModelLinkedServiceName: LinkedServiceReference;

  /**
   * The relative file path in trainedModelLinkedService to represent the .ilearner file that will be uploaded by the update operation.  Type: string (or Expression with resultType string).
   */
  trainedModelFilePath: Record<unknown>;
}

/**
 * Azure ML Execute Pipeline activity.
 */
model AzureMLExecutePipelineActivity extends ExecutionActivity {
  /**
   * Azure ML Execute Pipeline activity properties.
   */
  typeProperties: AzureMLExecutePipelineActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "AzureMLExecutePipeline";
}

/**
 * Azure ML Execute Pipeline activity properties.
 */
model AzureMLExecutePipelineActivityTypeProperties {
  /**
   * ID of the published Azure ML pipeline. Type: string (or Expression with resultType string).
   */
  mlPipelineId?: Record<unknown>;

  /**
   * ID of the published Azure ML pipeline endpoint. Type: string (or Expression with resultType string).
   */
  mlPipelineEndpointId?: Record<unknown>;

  /**
   * Version of the published Azure ML pipeline endpoint. Type: string (or Expression with resultType string).
   */
  version?: Record<unknown>;

  /**
   * Run history experiment name of the pipeline run. This information will be passed in the ExperimentName property of the published pipeline execution request. Type: string (or Expression with resultType string).
   */
  experimentName?: Record<unknown>;

  /**
   * Key,Value pairs to be passed to the published Azure ML pipeline endpoint. Keys must match the names of pipeline parameters defined in the published pipeline. Values will be passed in the ParameterAssignments property of the published pipeline execution request. Type: object with key value pairs (or Expression with resultType object).
   */
  mlPipelineParameters?: Record<unknown>;

  /**
   * Dictionary used for changing data path assignments without retraining. Values will be passed in the dataPathAssignments property of the published pipeline execution request. Type: object with key value pairs (or Expression with resultType object).
   */
  dataPathAssignments?: Record<unknown>;

  /**
   * The parent Azure ML Service pipeline run id. This information will be passed in the ParentRunId property of the published pipeline execution request. Type: string (or Expression with resultType string).
   */
  mlParentRunId?: Record<unknown>;

  /**
   * Whether to continue execution of other steps in the PipelineRun if a step fails. This information will be passed in the continueOnStepFailure property of the published pipeline execution request. Type: boolean (or Expression with resultType boolean).
   */
  continueOnStepFailure?: Record<unknown>;
}

/**
 * Data Lake Analytics U-SQL activity.
 */
model DataLakeAnalyticsUsqlActivity extends ExecutionActivity {
  /**
   * Data Lake Analytics U-SQL activity properties.
   */
  typeProperties: DataLakeAnalyticsUsqlActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "DataLakeAnalyticsU-SQL";
}

/**
 * DataLakeAnalyticsU-SQL activity properties.
 */
model DataLakeAnalyticsUsqlActivityTypeProperties {
  /**
   * Case-sensitive path to folder that contains the U-SQL script. Type: string (or Expression with resultType string).
   */
  scriptPath: Record<unknown>;

  /**
   * Script linked service reference.
   */
  scriptLinkedService: LinkedServiceReference;

  /**
   * The maximum number of nodes simultaneously used to run the job. Default value is 1. Type: integer (or Expression with resultType integer), minimum: 1.
   */
  degreeOfParallelism?: Record<unknown>;

  /**
   * Determines which jobs out of all that are queued should be selected to run first. The lower the number, the higher the priority. Default value is 1000. Type: integer (or Expression with resultType integer), minimum: 1.
   */
  priority?: Record<unknown>;

  /**
   * Parameters for U-SQL job request.
   */
  parameters?: Record<Record<unknown>>;

  /**
   * Runtime version of the U-SQL engine to use. Type: string (or Expression with resultType string).
   */
  runtimeVersion?: Record<unknown>;

  /**
   * Compilation mode of U-SQL. Must be one of these values : Semantic, Full and SingleBox. Type: string (or Expression with resultType string).
   */
  compilationMode?: Record<unknown>;
}

/**
 * This activity suspends pipeline execution for the specified interval.
 */
model WaitActivity extends ControlActivity {
  /**
   * Wait activity properties.
   */
  typeProperties: WaitActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "Wait";
}

/**
 * Wait activity properties.
 */
model WaitActivityTypeProperties {
  /**
   * Duration in seconds. Type: integer (or Expression with resultType integer).
   */
  waitTimeInSeconds: Record<unknown>;
}

/**
 * This activity will fail within its own scope and output a custom error message and error code. The error message and code can provided either as a string literal or as an expression that can be evaluated to a string at runtime. The activity scope can be the whole pipeline or a control activity (e.g. foreach, switch, until), if the fail activity is contained in it.
 */
model FailActivity extends ControlActivity {
  /**
   * Fail activity properties.
   */
  typeProperties: FailActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "Fail";
}

/**
 * Fail activity properties.
 */
model FailActivityTypeProperties {
  /**
   * The error message that surfaced in the Fail activity. It can be dynamic content that's evaluated to a non empty/blank string at runtime. Type: string (or Expression with resultType string).
   */
  message: Record<unknown>;

  /**
   * The error code that categorizes the error type of the Fail activity. It can be dynamic content that's evaluated to a non empty/blank string at runtime. Type: string (or Expression with resultType string).
   */
  errorCode: Record<unknown>;
}

/**
 * This activity executes inner activities until the specified boolean expression results to true or timeout is reached, whichever is earlier.
 */
model UntilActivity extends ControlActivity {
  /**
   * Until activity properties.
   */
  typeProperties: UntilActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "Until";
}

/**
 * Until activity properties.
 */
model UntilActivityTypeProperties {
  /**
   * An expression that would evaluate to Boolean. The loop will continue until this expression evaluates to true
   */
  expression: Expression;

  /**
   * Specifies the timeout for the activity to run. If there is no value specified, it takes the value of TimeSpan.FromDays(7) which is 1 week as default. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  timeout?: Record<unknown>;

  /**
   * List of activities to execute.
   */
  activities: Activity[];
}

/**
 * This activity verifies that an external resource exists.
 */
model ValidationActivity extends ControlActivity {
  /**
   * Validation activity properties.
   */
  typeProperties: ValidationActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "Validation";
}

/**
 * Validation activity properties.
 */
model ValidationActivityTypeProperties {
  /**
   * Specifies the timeout for the activity to run. If there is no value specified, it takes the value of TimeSpan.FromDays(7) which is 1 week as default. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  timeout?: Record<unknown>;

  /**
   * A delay in seconds between validation attempts. If no value is specified, 10 seconds will be used as the default. Type: integer (or Expression with resultType integer).
   */
  sleep?: Record<unknown>;

  /**
   * Can be used if dataset points to a file. The file must be greater than or equal in size to the value specified. Type: integer (or Expression with resultType integer).
   */
  minimumSize?: Record<unknown>;

  /**
   * Can be used if dataset points to a folder. If set to true, the folder must have at least one file. If set to false, the folder must be empty. Type: boolean (or Expression with resultType boolean).
   */
  childItems?: Record<unknown>;

  /**
   * Validation activity dataset reference.
   */
  dataset: DatasetReference;
}

/**
 * Filter and return results from input array based on the conditions.
 */
model FilterActivity extends ControlActivity {
  /**
   * Filter activity properties.
   */
  typeProperties: FilterActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "Filter";
}

/**
 * Filter activity properties.
 */
model FilterActivityTypeProperties {
  /**
   * Input array on which filter should be applied.
   */
  items: Expression;

  /**
   * Condition to be used for filtering the input.
   */
  condition: Expression;
}

/**
 * DatabricksNotebook activity.
 */
model DatabricksNotebookActivity extends ExecutionActivity {
  /**
   * Databricks Notebook activity properties.
   */
  typeProperties: DatabricksNotebookActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "DatabricksNotebook";
}

/**
 * Databricks Notebook activity properties.
 */
model DatabricksNotebookActivityTypeProperties {
  /**
   * The absolute path of the notebook to be run in the Databricks Workspace. This path must begin with a slash. Type: string (or Expression with resultType string).
   */
  notebookPath: Record<unknown>;

  /**
   * Base parameters to be used for each run of this job.If the notebook takes a parameter that is not specified, the default value from the notebook will be used.
   */
  baseParameters?: Record<Record<unknown>>;

  /**
   * A list of libraries to be installed on the cluster that will execute the job.
   */
  libraries?: Record<Record<unknown>>[];
}

/**
 * DatabricksSparkJar activity.
 */
model DatabricksSparkJarActivity extends ExecutionActivity {
  /**
   * Databricks SparkJar activity properties.
   */
  typeProperties: DatabricksSparkJarActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "DatabricksSparkJar";
}

/**
 * Databricks SparkJar activity properties.
 */
model DatabricksSparkJarActivityTypeProperties {
  /**
   * The full name of the class containing the main method to be executed. This class must be contained in a JAR provided as a library. Type: string (or Expression with resultType string).
   */
  mainClassName: Record<unknown>;

  /**
   * Parameters that will be passed to the main method.
   */
  parameters?: Record<unknown>[];

  /**
   * A list of libraries to be installed on the cluster that will execute the job.
   */
  libraries?: Record<Record<unknown>>[];
}

/**
 * DatabricksSparkPython activity.
 */
model DatabricksSparkPythonActivity extends ExecutionActivity {
  /**
   * Databricks SparkPython activity properties.
   */
  typeProperties: DatabricksSparkPythonActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "DatabricksSparkPython";
}

/**
 * Databricks SparkPython activity properties.
 */
model DatabricksSparkPythonActivityTypeProperties {
  /**
   * The URI of the Python file to be executed. DBFS paths are supported. Type: string (or Expression with resultType string).
   */
  pythonFile: Record<unknown>;

  /**
   * Command line parameters that will be passed to the Python file.
   */
  parameters?: Record<unknown>[];

  /**
   * A list of libraries to be installed on the cluster that will execute the job.
   */
  libraries?: Record<Record<unknown>>[];
}

/**
 * Set value for a Variable.
 */
model SetVariableActivity extends ControlActivity {
  /**
   * Set Variable activity properties.
   */
  typeProperties: SetVariableActivityTypeProperties;

  /**
   * Activity policy.
   */
  policy?: SecureInputOutputPolicy;

  /**
   * Type of activity.
   */
  type: "SetVariable";
}

/**
 * SetVariable activity properties.
 */
model SetVariableActivityTypeProperties {
  /**
   * Name of the variable whose value needs to be set.
   */
  variableName?: string;

  /**
   * Value to be set. Could be a static value or Expression.
   */
  value?: Record<unknown>;

  /**
   * If set to true, it sets the pipeline run return value.
   */
  setSystemVariable?: boolean;
}

/**
 * Execution policy for an activity that supports secure input and output.
 */
model SecureInputOutputPolicy {
  /**
   * When set to true, Input from activity is considered as secure and will not be logged to monitoring.
   */
  secureInput?: boolean;

  /**
   * When set to true, Output from activity is considered as secure and will not be logged to monitoring.
   */
  secureOutput?: boolean;
}

/**
 * Append value for a Variable of type Array.
 */
model AppendVariableActivity extends ControlActivity {
  /**
   * Append Variable activity properties.
   */
  typeProperties: AppendVariableActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "AppendVariable";
}

/**
 * AppendVariable activity properties.
 */
model AppendVariableActivityTypeProperties {
  /**
   * Name of the variable whose value needs to be appended to.
   */
  variableName?: string;

  /**
   * Value to be appended. Type: could be a static value matching type of the variable item or Expression with resultType matching type of the variable item
   */
  value?: Record<unknown>;
}

/**
 * Azure Function activity.
 */
model AzureFunctionActivity extends ExecutionActivity {
  /**
   * Azure Function activity properties.
   */
  typeProperties: AzureFunctionActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "AzureFunctionActivity";
}

/**
 * Azure Function activity type properties.
 */
model AzureFunctionActivityTypeProperties {
  /**
   * Rest API method for target endpoint.
   */
  method: AzureFunctionActivityMethod;

  /**
   * Name of the Function that the Azure Function Activity will call. Type: string (or Expression with resultType string)
   */
  functionName: Record<unknown>;

  /**
   * Represents the headers that will be sent to the request. For example, to set the language and type on a request: "headers" : { "Accept-Language": "en-us", "Content-Type": "application/json" }. Type: string (or Expression with resultType string).
   */
  headers?: Record<unknown>;

  /**
   * Represents the payload that will be sent to the endpoint. Required for POST/PUT method, not allowed for GET method Type: string (or Expression with resultType string).
   */
  body?: Record<unknown>;
}

/**
 * WebHook activity.
 */
model WebHookActivity extends ControlActivity {
  /**
   * WebHook activity properties.
   */
  typeProperties: WebHookActivityTypeProperties;

  /**
   * Activity policy.
   */
  policy?: SecureInputOutputPolicy;

  /**
   * Type of activity.
   */
  type: "WebHook";
}

/**
 * WebHook activity type properties.
 */
model WebHookActivityTypeProperties {
  /**
   * Rest API method for target endpoint.
   */
  method: WebHookActivityMethod;

  /**
   * WebHook activity target endpoint and path. Type: string (or Expression with resultType string).
   */
  url: Record<unknown>;

  /**
   * The timeout within which the webhook should be called back. If there is no value specified, it defaults to 10 minutes. Type: string. Pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  timeout?: string;

  /**
   * Represents the headers that will be sent to the request. For example, to set the language and type on a request: "headers" : { "Accept-Language": "en-us", "Content-Type": "application/json" }. Type: string (or Expression with resultType string).
   */
  headers?: Record<unknown>;

  /**
   * Represents the payload that will be sent to the endpoint. Required for POST/PUT method, not allowed for GET method Type: string (or Expression with resultType string).
   */
  body?: Record<unknown>;

  /**
   * Authentication method used for calling the endpoint.
   */
  authentication?: WebActivityAuthentication;

  /**
   * When set to true, statusCode, output and error in callback request body will be consumed by activity. The activity can be marked as failed by setting statusCode >= 400 in callback request. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  reportStatusOnCallBack?: Record<unknown>;
}

/**
 * Execute data flow activity.
 */
model ExecuteDataFlowActivity extends ExecutionActivity {
  /**
   * Execute data flow activity properties.
   */
  typeProperties: ExecuteDataFlowActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "ExecuteDataFlow";
}

/**
 * Execute data flow activity properties.
 */
model ExecuteDataFlowActivityTypeProperties {
  /**
   * Data flow reference.
   */
  dataFlow: DataFlowReference;

  /**
   * Staging info for execute data flow activity.
   */
  staging?: DataFlowStagingInfo;

  /**
   * The integration runtime reference.
   */
  integrationRuntime?: IntegrationRuntimeReference;

  /**
   * Compute properties for data flow activity.
   */
  compute?: ExecuteDataFlowActivityTypePropertiesCompute;

  /**
   * Trace level setting used for data flow monitoring output. Supported values are: 'coarse', 'fine', and 'none'. Type: string (or Expression with resultType string)
   */
  traceLevel?: Record<unknown>;

  /**
   * Continue on error setting used for data flow execution. Enables processing to continue if a sink fails. Type: boolean (or Expression with resultType boolean)
   */
  continueOnError?: Record<unknown>;

  /**
   * Concurrent run setting used for data flow execution. Allows sinks with the same save order to be processed concurrently. Type: boolean (or Expression with resultType boolean)
   */
  runConcurrently?: Record<unknown>;

  /**
   * Specify number of parallel staging for sources applicable to the sink. Type: integer (or Expression with resultType integer)
   */
  sourceStagingConcurrency?: Record<unknown>;
}

/**
 * Compute properties for data flow activity.
 */
model ExecuteDataFlowActivityTypePropertiesCompute {
  /**
   * Compute type of the cluster which will execute data flow job. Possible values include: 'General', 'MemoryOptimized', 'ComputeOptimized'. Type: string (or Expression with resultType string)
   */
  computeType?: Record<unknown>;

  /**
   * Core count of the cluster which will execute data flow job. Supported values are: 8, 16, 32, 48, 80, 144 and 272. Type: integer (or Expression with resultType integer)
   */
  coreCount?: Record<unknown>;
}

/**
 * Execute power query activity.
 */
model ExecuteWranglingDataflowActivity extends Activity {
  /**
   * Execute power query activity properties.
   */
  typeProperties: ExecutePowerQueryActivityTypeProperties;

  /**
   * Activity policy.
   */
  policy?: ActivityPolicy;

  /**
   * Type of activity.
   */
  type: "ExecuteWranglingDataflow";
}

/**
 * Execute power query data flow activity properties.
 */
model ExecutePowerQueryActivityTypeProperties
  extends ExecuteDataFlowActivityTypeProperties {
  /**
   * (Deprecated. Please use Queries). List of Power Query activity sinks mapped to a queryName.
   */
  sinks?: Record<PowerQuerySink>;

  /**
   * List of mapping for Power Query mashup query to sink dataset(s).
   */
  queries?: PowerQuerySinkMapping[];
}

/**
 * Map Power Query mashup query to sink dataset(s).
 */
model PowerQuerySinkMapping {
  /**
   * Name of the query in Power Query mashup document.
   */
  queryName?: string;

  /**
   * List of sinks mapped to Power Query mashup query.
   */
  dataflowSinks?: PowerQuerySink[];
}

/**
 * Script activity type.
 */
model ScriptActivity extends ExecutionActivity {
  /**
   * Script activity properties.
   */
  typeProperties: ScriptActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "Script";
}

/**
 * Script activity properties.
 */
model ScriptActivityTypeProperties {
  /**
   * ScriptBlock execution timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  scriptBlockExecutionTimeout?: Record<unknown>;

  /**
   * Array of script blocks. Type: array.
   */
  scripts?: ScriptActivityScriptBlock[];

  /**
   * Log settings of script activity.
   */
  logSettings?: ScriptActivityTypePropertiesLogSettings;
}

/**
 * Script block of scripts.
 */
model ScriptActivityScriptBlock {
  /**
   * The query text. Type: string (or Expression with resultType string).
   */
  text: Record<unknown>;

  /**
   * The type of the query. Type: string.
   */
  type: ScriptType;

  /**
   * Array of script parameters. Type: array.
   */
  parameters?: ScriptActivityParameter[];
}

/**
 * Parameters of a script block.
 */
model ScriptActivityParameter {
  /**
   * The name of the parameter. Type: string (or Expression with resultType string).
   */
  name?: Record<unknown>;

  /**
   * The type of the parameter.
   */
  type?: ScriptActivityParameterType;

  /**
   * The value of the parameter. Type: string (or Expression with resultType string).
   */
  value?: Record<unknown>;

  /**
   * The direction of the parameter.
   */
  direction?: ScriptActivityParameterDirection;

  /**
   * The size of the output direction parameter.
   */
  size?: int32;
}

/**
 * Log settings of script activity.
 */
model ScriptActivityTypePropertiesLogSettings {
  /**
   * The destination of logs. Type: string.
   */
  logDestination: ScriptActivityLogDestination;

  /**
   * Log location settings customer needs to provide when enabling log.
   */
  logLocationSettings?: LogLocationSettings;
}

/**
 * A copy activity source for sharePoint online list source.
 */
model SharePointOnlineListSource extends CopySource {
  /**
   * The OData query to filter the data in SharePoint Online list. For example, "$top=1". Type: string (or Expression with resultType string).
   */
  query?: Record<unknown>;

  /**
   * The wait time to get a response from SharePoint Online. Default value is 5 minutes (00:05:00). Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  httpRequestTimeout?: Record<unknown>;

  /**
   * Copy source type.
   */
  type: "SharePointOnlineListSource";
}

/**
 * Execute Synapse notebook activity.
 */
model SynapseNotebookActivity extends ExecutionActivity {
  /**
   * Execute Synapse notebook activity properties.
   */
  typeProperties: SynapseNotebookActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "SynapseNotebook";
}

/**
 * Execute Synapse notebook activity properties.
 */
model SynapseNotebookActivityTypeProperties {
  /**
   * Synapse notebook reference.
   */
  notebook: SynapseNotebookReference;

  /**
   * The name of the big data pool which will be used to execute the notebook.
   */
  sparkPool?: BigDataPoolParametrizationReference;

  /**
   * Notebook parameters.
   */
  parameters?: Record<NotebookParameter>;

  /**
   * Number of core and memory to be used for executors allocated in the specified Spark pool for the session, which will be used for overriding 'executorCores' and 'executorMemory' of the notebook you provide. Type: string (or Expression with resultType string).
   */
  executorSize?: Record<unknown>;

  /**
   * Spark configuration properties, which will override the 'conf' of the notebook you provide.
   */
  conf?: Record<unknown>;

  /**
   * Number of core and memory to be used for driver allocated in the specified Spark pool for the session, which will be used for overriding 'driverCores' and 'driverMemory' of the notebook you provide. Type: string (or Expression with resultType string).
   */
  driverSize?: Record<unknown>;

  /**
   * Number of executors to launch for this session, which will override the 'numExecutors' of the notebook you provide. Type: integer (or Expression with resultType integer).
   */
  numExecutors?: Record<unknown>;

  /**
   * The type of the spark config.
   */
  configurationType?: ConfigurationType;

  /**
   * The spark configuration of the spark job.
   */
  targetSparkConfiguration?: SparkConfigurationParametrizationReference;

  /**
   * Spark configuration property.
   */
  sparkConfig?: Record<Record<unknown>>;
}

/**
 * Synapse notebook reference type.
 */
model SynapseNotebookReference {
  /**
   * Synapse notebook reference type.
   */
  type: NotebookReferenceType;

  /**
   * Reference notebook name. Type: string (or Expression with resultType string).
   */
  referenceName: Record<unknown>;
}

/**
 * Big data pool reference type.
 */
model BigDataPoolParametrizationReference {
  /**
   * Big data pool reference type.
   */
  type: BigDataPoolReferenceType;

  /**
   * Reference big data pool name. Type: string (or Expression with resultType string).
   */
  referenceName: Record<unknown>;
}

/**
 * Notebook parameter.
 */
model NotebookParameter {
  /**
   * Notebook parameter value. Type: string (or Expression with resultType string).
   */
  value?: Record<unknown>;

  /**
   * Notebook parameter type.
   */
  type?: NotebookParameterType;
}

/**
 * Spark configuration reference.
 */
model SparkConfigurationParametrizationReference {
  /**
   * Spark configuration reference type.
   */
  type: SparkConfigurationReferenceType;

  /**
   * Reference spark configuration name. Type: string (or Expression with resultType string).
   */
  referenceName: Record<unknown>;
}

/**
 * Execute spark job activity.
 */
model SynapseSparkJobDefinitionActivity extends ExecutionActivity {
  /**
   * Execute spark job activity properties.
   */
  typeProperties: SynapseSparkJobActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "SparkJob";
}

/**
 * Execute spark job activity properties.
 */
model SynapseSparkJobActivityTypeProperties {
  /**
   * Synapse spark job reference.
   */
  sparkJob: SynapseSparkJobReference;

  /**
   * User specified arguments to SynapseSparkJobDefinitionActivity.
   */
  @projectedName("json", "args")
  arguments?: unknown[];

  /**
   * The main file used for the job, which will override the 'file' of the spark job definition you provide. Type: string (or Expression with resultType string).
   */
  file?: Record<unknown>;

  /**
   * Scanning subfolders from the root folder of the main definition file, these files will be added as reference files. The folders named 'jars', 'pyFiles', 'files' or 'archives' will be scanned, and the folders name are case sensitive. Type: boolean (or Expression with resultType boolean).
   */
  scanFolder?: Record<unknown>;

  /**
   * The fully-qualified identifier or the main class that is in the main definition file, which will override the 'className' of the spark job definition you provide. Type: string (or Expression with resultType string).
   */
  className?: Record<unknown>;

  /**
   * (Deprecated. Please use pythonCodeReference and filesV2) Additional files used for reference in the main definition file, which will override the 'files' of the spark job definition you provide.
   */
  files?: Record<unknown>[];

  /**
   * Additional python code files used for reference in the main definition file, which will override the 'pyFiles' of the spark job definition you provide.
   */
  pythonCodeReference?: Record<unknown>[];

  /**
   * Additional files used for reference in the main definition file, which will override the 'jars' and 'files' of the spark job definition you provide.
   */
  filesV2?: Record<unknown>[];

  /**
   * The name of the big data pool which will be used to execute the spark batch job, which will override the 'targetBigDataPool' of the spark job definition you provide.
   */
  targetBigDataPool?: BigDataPoolParametrizationReference;

  /**
   * Number of core and memory to be used for executors allocated in the specified Spark pool for the job, which will be used for overriding 'executorCores' and 'executorMemory' of the spark job definition you provide. Type: string (or Expression with resultType string).
   */
  executorSize?: Record<unknown>;

  /**
   * Spark configuration properties, which will override the 'conf' of the spark job definition you provide.
   */
  conf?: Record<unknown>;

  /**
   * Number of core and memory to be used for driver allocated in the specified Spark pool for the job, which will be used for overriding 'driverCores' and 'driverMemory' of the spark job definition you provide. Type: string (or Expression with resultType string).
   */
  driverSize?: Record<unknown>;

  /**
   * Number of executors to launch for this job, which will override the 'numExecutors' of the spark job definition you provide. Type: integer (or Expression with resultType integer).
   */
  numExecutors?: Record<unknown>;

  /**
   * The type of the spark config.
   */
  configurationType?: ConfigurationType;

  /**
   * The spark configuration of the spark job.
   */
  targetSparkConfiguration?: SparkConfigurationParametrizationReference;

  /**
   * Spark configuration property.
   */
  sparkConfig?: Record<Record<unknown>>;
}

/**
 * Synapse spark job reference type.
 */
model SynapseSparkJobReference {
  /**
   * Synapse spark job reference type.
   */
  type: SparkJobReferenceType;

  /**
   * Reference spark job name. Expression with resultType string.
   */
  referenceName: Record<unknown>;
}

/**
 * Base class for all triggers that support one to many model for trigger to pipeline.
 */
@discriminator("type")
model MultiplePipelineTrigger extends Trigger {
  /**
   * Pipelines that need to be started.
   */
  pipelines?: TriggerPipelineReference[];
}

/**
 * Trigger that creates pipeline runs periodically, on schedule.
 */
model ScheduleTrigger extends MultiplePipelineTrigger {
  /**
   * Schedule Trigger properties.
   */
  typeProperties: ScheduleTriggerTypeProperties;

  /**
   * Trigger type.
   */
  type: "ScheduleTrigger";
}

/**
 * Schedule Trigger properties.
 */
model ScheduleTriggerTypeProperties {
  /**
   * Recurrence schedule configuration.
   */
  recurrence: ScheduleTriggerRecurrence;
}

/**
 * The workflow trigger recurrence.
 */
model ScheduleTriggerRecurrence extends Record<Record<unknown>> {
  /**
   * The frequency.
   */
  frequency?: RecurrenceFrequency;

  /**
   * The interval.
   */
  interval?: int32;

  /**
   * The start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The time zone.
   */
  timeZone?: string;

  /**
   * The recurrence schedule.
   */
  schedule?: RecurrenceSchedule;
}

/**
 * The recurrence schedule.
 */
model RecurrenceSchedule extends Record<Record<unknown>> {
  /**
   * The minutes.
   */
  minutes?: int32[];

  /**
   * The hours.
   */
  hours?: int32[];

  /**
   * The days of the week.
   */
  weekDays?: DaysOfWeek[];

  /**
   * The month days.
   */
  monthDays?: int32[];

  /**
   * The monthly occurrences.
   */
  monthlyOccurrences?: RecurrenceScheduleOccurrence[];
}

/**
 * The recurrence schedule occurrence.
 */
model RecurrenceScheduleOccurrence extends Record<Record<unknown>> {
  /**
   * The day of the week.
   */
  day?: DayOfWeek;

  /**
   * The occurrence.
   */
  occurrence?: int32;
}

/**
 * Trigger that runs every time the selected Blob container changes.
 */
model BlobTrigger extends MultiplePipelineTrigger {
  /**
   * Blob Trigger properties.
   */
  typeProperties: BlobTriggerTypeProperties;

  /**
   * Trigger type.
   */
  type: "BlobTrigger";
}

/**
 * Blob Trigger properties.
 */
model BlobTriggerTypeProperties {
  /**
   * The path of the container/folder that will trigger the pipeline.
   */
  folderPath: string;

  /**
   * The max number of parallel files to handle when it is triggered.
   */
  maxConcurrency: int32;

  /**
   * The Azure Storage linked service reference.
   */
  linkedService: LinkedServiceReference;
}

/**
 * Trigger that runs every time a Blob event occurs.
 */
model BlobEventsTrigger extends MultiplePipelineTrigger {
  /**
   * Blob Events Trigger properties.
   */
  typeProperties: BlobEventsTriggerTypeProperties;

  /**
   * Trigger type.
   */
  type: "BlobEventsTrigger";
}

/**
 * Blob Events Trigger properties.
 */
model BlobEventsTriggerTypeProperties {
  /**
   * The blob path must begin with the pattern provided for trigger to fire. For example, '/records/blobs/december/' will only fire the trigger for blobs in the december folder under the records container. At least one of these must be provided: blobPathBeginsWith, blobPathEndsWith.
   */
  blobPathBeginsWith?: string;

  /**
   * The blob path must end with the pattern provided for trigger to fire. For example, 'december/boxes.csv' will only fire the trigger for blobs named boxes in a december folder. At least one of these must be provided: blobPathBeginsWith, blobPathEndsWith.
   */
  blobPathEndsWith?: string;

  /**
   * If set to true, blobs with zero bytes will be ignored.
   */
  ignoreEmptyBlobs?: boolean;

  /**
   * The type of events that cause this trigger to fire.
   */
  events: BlobEventTypes[];

  /**
   * The ARM resource ID of the Storage Account.
   */
  scope: string;
}

/**
 * Trigger that runs every time a custom event is received.
 */
model CustomEventsTrigger extends MultiplePipelineTrigger {
  /**
   * Custom Events Trigger properties.
   */
  typeProperties: CustomEventsTriggerTypeProperties;

  /**
   * Trigger type.
   */
  type: "CustomEventsTrigger";
}

/**
 * Custom Events Trigger properties.
 */
model CustomEventsTriggerTypeProperties {
  /**
   * The event subject must begin with the pattern provided for trigger to fire. At least one of these must be provided: subjectBeginsWith, subjectEndsWith.
   */
  subjectBeginsWith?: string;

  /**
   * The event subject must end with the pattern provided for trigger to fire. At least one of these must be provided: subjectBeginsWith, subjectEndsWith.
   */
  subjectEndsWith?: string;

  /**
   * The list of event types that cause this trigger to fire.
   */
  events: Record<unknown>[];

  /**
   * The ARM resource ID of the Azure Event Grid Topic.
   */
  scope: string;
}

/**
 * Trigger that schedules pipeline runs for all fixed time interval windows from a start time without gaps and also supports backfill scenarios (when start time is in the past).
 */
model TumblingWindowTrigger extends Trigger {
  /**
   * Pipeline for which runs are created when an event is fired for trigger window that is ready.
   */
  pipeline: TriggerPipelineReference;

  /**
   * Tumbling Window Trigger properties.
   */
  typeProperties: TumblingWindowTriggerTypeProperties;

  /**
   * Trigger type.
   */
  type: "TumblingWindowTrigger";
}

/**
 * Tumbling Window Trigger properties.
 */
model TumblingWindowTriggerTypeProperties {
  /**
   * The frequency of the time windows.
   */
  frequency: TumblingWindowFrequency;

  /**
   * The interval of the time windows. The minimum interval allowed is 15 Minutes.
   */
  interval: int32;

  /**
   * The start time for the time period for the trigger during which events are fired for windows that are ready. Only UTC time is currently supported.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  /**
   * The end time for the time period for the trigger during which events are fired for windows that are ready. Only UTC time is currently supported.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Specifies how long the trigger waits past due time before triggering new run. It doesn't alter window start and end time. The default is 0. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  delay?: Record<unknown>;

  /**
   * The max number of parallel time windows (ready for execution) for which a new run is triggered.
   */
  @maxValue(50)
  @minValue(1)
  maxConcurrency: int32;

  /**
   * Retry policy that will be applied for failed pipeline runs.
   */
  retryPolicy?: RetryPolicy;

  /**
   * Triggers that this trigger depends on. Only tumbling window triggers are supported.
   */
  dependsOn?: DependencyReference[];
}

/**
 * Execution policy for an activity.
 */
model RetryPolicy {
  /**
   * Maximum ordinary retry attempts. Default is 0. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  count?: Record<unknown>;

  /**
   * Interval between retries in seconds. Default is 30.
   */
  @maxValue(86400)
  @minValue(30)
  intervalInSeconds?: int32;
}

/**
 * Referenced dependency.
 */
@discriminator("type")
model DependencyReference {}

/**
 * Trigger reference type.
 */
model TriggerReference {
  /**
   * Trigger reference type.
   */
  type: TriggerReferenceType;

  /**
   * Reference trigger name.
   */
  referenceName: string;
}

/**
 * Trigger referenced dependency.
 */
@discriminator("type")
model TriggerDependencyReference extends DependencyReference {
  /**
   * Referenced trigger.
   */
  referenceTrigger: TriggerReference;
}

/**
 * Referenced tumbling window trigger dependency.
 */
model TumblingWindowTriggerDependencyReference
  extends TriggerDependencyReference {
  /**
   * Timespan applied to the start time of a tumbling window when evaluating dependency.
   */
  @maxLength(15)
  @minLength(8)
  @pattern("-?((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9]))")
  offset?: string;

  /**
   * The size of the window when evaluating the dependency. If undefined the frequency of the tumbling window will be used.
   */
  @maxLength(15)
  @minLength(8)
  @pattern("((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9]))")
  size?: string;

  /**
   * The type of dependency reference.
   */
  type: "TumblingWindowTriggerDependencyReference";
}

/**
 * Self referenced tumbling window trigger dependency.
 */
model SelfDependencyTumblingWindowTriggerReference extends DependencyReference {
  /**
   * Timespan applied to the start time of a tumbling window when evaluating dependency.
   */
  @maxLength(15)
  @minLength(8)
  @pattern("-((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9]))")
  offset: string;

  /**
   * The size of the window when evaluating the dependency. If undefined the frequency of the tumbling window will be used.
   */
  @maxLength(15)
  @minLength(8)
  @pattern("((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9]))")
  size?: string;

  /**
   * The type of dependency reference.
   */
  type: "SelfDependencyTumblingWindowTriggerReference";
}

/**
 * Trigger that schedules pipeline reruns for all fixed time interval windows from a requested start time to requested end time.
 */
model RerunTumblingWindowTrigger extends Trigger {
  /**
   * Rerun Trigger properties.
   */
  typeProperties: RerunTumblingWindowTriggerTypeProperties;

  /**
   * Trigger type.
   */
  type: "RerunTumblingWindowTrigger";
}

/**
 * Rerun Trigger properties.
 */
model RerunTumblingWindowTriggerTypeProperties {
  /**
   * The parent trigger reference.
   */
  parentTrigger: Record<unknown>;

  /**
   * The start time for the time period for which restatement is initiated. Only UTC time is currently supported.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestedStartTime: utcDateTime;

  /**
   * The end time for the time period for which restatement is initiated. Only UTC time is currently supported.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestedEndTime: utcDateTime;

  /**
   * The max number of parallel time windows (ready for execution) for which a rerun is triggered.
   */
  @maxValue(50)
  @minValue(1)
  rerunConcurrency: int32;
}

/**
 * Trigger that allows the referenced pipeline to depend on other pipeline runs based on runDimension Name/Value pairs. Upstream pipelines should declare the same runDimension Name and their runs should have the values for those runDimensions. The referenced pipeline run would be triggered if the values for the runDimension match for all upstream pipeline runs.
 */
model ChainingTrigger extends Trigger {
  /**
   * Pipeline for which runs are created when all upstream pipelines complete successfully.
   */
  pipeline: TriggerPipelineReference;

  /**
   * Chaining Trigger properties.
   */
  typeProperties: ChainingTriggerTypeProperties;

  /**
   * Trigger type.
   */
  type: "ChainingTrigger";
}

/**
 * Chaining Trigger properties.
 */
model ChainingTriggerTypeProperties {
  /**
   * Upstream Pipelines.
   */
  dependsOn: PipelineReference[];

  /**
   * Run Dimension property that needs to be emitted by upstream pipelines.
   */
  runDimension: string;
}

/**
 * Service principal credential.
 */
model ServicePrincipalCredential extends Credential {
  /**
   * Service Principal credential properties.
   */
  typeProperties: ServicePrincipalCredentialTypeProperties;

  /**
   * Type of credential.
   */
  type: "ServicePrincipal";
}

/**
 * Service Principal credential type properties.
 */
model ServicePrincipalCredentialTypeProperties {
  /**
   * The app ID of the service principal used to authenticate
   */
  servicePrincipalId?: Record<unknown>;

  /**
   * The key of the service principal used to authenticate.
   */
  servicePrincipalKey?: AzureKeyVaultSecretReference;

  /**
   * The ID of the tenant to which the service principal belongs
   */
  tenant?: Record<unknown>;
}
