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

@doc("The identity type.")
enum FactoryIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

@doc("Global Parameter type.")
enum GlobalParameterType {
  Object,
  String,
  Int,
  Float,
  Bool,
  Array,
}

@doc("Whether or not public network access is allowed for the data factory.")
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

@doc("The type of integration runtime.")
enum IntegrationRuntimeType {
  Managed,
  SelfHosted,
}

@doc("The state of integration runtime auto update.")
enum IntegrationRuntimeAutoUpdate {
  On,
  Off,
}

@doc("The state of integration runtime.")
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

@doc("The name of the authentication key to regenerate.")
enum IntegrationRuntimeAuthKeyName {
  authKey1,
  authKey2,
}

@doc("The type of SSIS object metadata.")
enum SsisObjectMetadataType {
  Folder,
  Project,
  Package,
  Environment,
}

@doc("Status of the integration runtime node.")
enum SelfHostedIntegrationRuntimeNodeStatus {
  NeedRegistration,
  Online,
  Limited,
  Offline,
  Upgrading,
  Initializing,
  InitializeFailed,
}

@doc("The result of the last integration runtime node update.")
enum IntegrationRuntimeUpdateResult {
  None,
  Succeed,
  Fail,
}

@doc("Type of integration runtime.")
enum IntegrationRuntimeReferenceType {
  IntegrationRuntimeReference,
}

@doc("Parameter type.")
enum ParameterType {
  Object,
  String,
  Int,
  Float,
  Bool,
  Array,
  SecureString,
}

@doc("Linked service reference type.")
enum LinkedServiceReferenceType {
  LinkedServiceReference,
}

@doc("Activity state. This is an optional property and if not provided, the state will be Active by default.")
enum ActivityState {
  Active,
  Inactive,
}

@doc("Status result of the activity when the state is set to Inactive. This is an optional property and if not provided when the activity is inactive, the status will be Succeeded by default.")
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

@doc("Variable type.")
enum VariableType {
  String,
  Bool,
  Array,
}

@doc("Parameter name to be used for filter. The allowed operands to query pipeline runs are PipelineName, RunStart, RunEnd and Status; to query activity runs are ActivityName, ActivityRunStart, ActivityRunEnd, ActivityType and Status, and to query trigger runs are TriggerName, TriggerRunTimestamp and Status.")
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

@doc("Operator to be used for filter.")
enum RunQueryFilterOperator {
  Equals,
  NotEquals,
  In,
  NotIn,
}

@doc("Parameter name to be used for order by. The allowed parameters to order by for pipeline runs are PipelineName, RunStart, RunEnd and Status; for activity runs are ActivityName, ActivityRunStart, ActivityRunEnd and Status; for trigger runs are TriggerName, TriggerRunTimestamp and Status.")
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

@doc("Sorting order of the parameter.")
enum RunQueryOrder {
  ASC,
  DESC,
}

@doc("Enumerates possible state of Triggers.")
enum TriggerRuntimeState {
  Started,
  Stopped,
  Disabled,
}

@doc("Event Subscription Status.")
enum EventSubscriptionStatus {
  Enabled,
  Provisioning,
  Deprovisioning,
  Disabled,
  Unknown,
}

@doc("Trigger run status.")
enum TriggerRunStatus {
  Succeeded,
  Failed,
  Inprogress,
}

@doc("The command type.")
enum DataFlowDebugCommandType {
  executePreviewQuery,
  executeStatisticsQuery,
  executeExpressionQuery,
}

@doc("Type of connection via linked service or dataset.")
enum ConnectionType {
  linkedservicetype,
}

@doc("Type of the CDC attribute mapping. Note: 'Advanced' mapping type is also saved as 'Derived'.")
enum MappingType {
  Direct,
  Derived,
  Aggregate,
}

@doc("Frequency of period in terms of 'Hour', 'Minute' or 'Second'.")
enum FrequencyType {
  Hour,
  Minute,
  Second,
}

@doc("Expression type.")
enum ExpressionType {
  Expression,
}

@doc("Pipeline reference type.")
enum PipelineReferenceType {
  PipelineReference,
}

@doc("Dataset reference type.")
enum DatasetReferenceType {
  DatasetReference,
}

@doc("Data flow reference type.")
enum DataFlowReferenceType {
  DataFlowReference,
}

@doc("Managed Virtual Network reference type.")
enum ManagedVirtualNetworkReferenceType {
  ManagedVirtualNetworkReference,
}

@doc("Credential reference type.")
enum CredentialReferenceType {
  CredentialReference,
}

@doc("Compute type of the cluster which will execute data flow job.")
enum DataFlowComputeType {
  General,
  MemoryOptimized,
  ComputeOptimized,
}

@doc("The pricing tier for the catalog database. The valid values could be found in https://azure.microsoft.com/en-us/pricing/details/sql-database/")
enum IntegrationRuntimeSsisCatalogPricingTier {
  Basic,
  Standard,
  Premium,
  PremiumRS,
}

@doc("License type for bringing your own license scenario.")
enum IntegrationRuntimeLicenseType {
  BasePrice,
  LicenseIncluded,
}

@doc("The type of this referenced entity.")
enum IntegrationRuntimeEntityReferenceType {
  IntegrationRuntimeReference,
  LinkedServiceReference,
}

@doc("The edition for the SSIS Integration Runtime")
enum IntegrationRuntimeEdition {
  Standard,
  Enterprise,
}

@doc("The managed integration runtime node status.")
enum ManagedIntegrationRuntimeNodeStatus {
  Starting,
  Available,
  Recycling,
  Unavailable,
}

@doc("It is used to set the encryption mode for node-node communication channel (when more than 2 self-hosted integration runtime nodes exist).")
enum IntegrationRuntimeInternalChannelEncryptionMode {
  NotSet,
  SslEncrypted,
  NotEncrypted,
}

@doc("The type used for authentication. Type: string.")
enum AzureStorageAuthenticationType {
  Anonymous,
  AccountKey,
  SasUri,
  ServicePrincipal,
  Msi,
}

@doc("Sql always encrypted AKV authentication type. Type: string.")
enum SqlAlwaysEncryptedAkvAuthType {
  ServicePrincipal,
  ManagedIdentity,
  UserAssignedManagedIdentity,
}

@doc("The connection mode used to access CosmosDB account. Type: string.")
enum CosmosDbConnectionMode {
  Gateway,
  Direct,
}

@doc("AuthenticationType to be used for connection.")
enum SybaseAuthenticationType {
  Basic,
  Windows,
}

@doc("AuthenticationType to be used for connection. It is mutually exclusive with connectionString property.")
enum Db2AuthenticationType {
  Basic,
}

@doc("AuthenticationType to be used for connection.")
enum TeradataAuthenticationType {
  Basic,
  Windows,
}

@doc("Type of authentication used to connect to the OData service.")
enum ODataAuthenticationType {
  Basic,
  Anonymous,
  Windows,
  AadServicePrincipal,
  ManagedServiceIdentity,
}

@doc("Specify the credential type (key or cert) is used for service principal.")
enum ODataAadServicePrincipalCredentialType {
  ServicePrincipalKey,
  ServicePrincipalCert,
}

@doc("Type of authentication used to connect to the web table source.")
enum WebAuthenticationType {
  Basic,
  Anonymous,
  ClientCertificate,
}

@doc("The authentication type to be used to connect to the MongoDB database.")
enum MongoDbAuthenticationType {
  Basic,
  Anonymous,
}

@doc("Type of authentication used to connect to the REST service.")
enum RestServiceAuthenticationType {
  Anonymous,
  Basic,
  AadServicePrincipal,
  ManagedServiceIdentity,
  OAuth2ClientCredential,
}

@doc("The authentication type to use.")
enum TeamDeskAuthenticationType {
  Basic,
  Token,
}

@doc("The authentication type to use.")
enum ZendeskAuthenticationType {
  Basic,
  Token,
}

@doc("The authentication type to be used to connect to the HTTP server.")
enum HttpAuthenticationType {
  Basic,
  Anonymous,
  Digest,
  Windows,
  ClientCertificate,
}

@doc("The authentication type to be used to connect to the FTP server.")
enum FtpAuthenticationType {
  Basic,
  Anonymous,
}

@doc("The authentication type to be used to connect to the FTP server.")
enum SftpAuthenticationType {
  Basic,
  SshPublicKey,
  MultiFactor,
}

@doc("The authentication type to be used to connect to the SAP HANA server.")
enum SapHanaAuthenticationType {
  Basic,
  Windows,
}

@doc("The OAuth 2.0 authentication mechanism used for authentication. ServiceAuthentication can only be used on self-hosted IR.")
enum GoogleBigQueryAuthenticationType {
  ServiceAuthentication,
  UserAuthentication,
}

@doc("The authentication mechanism to use to connect to the HBase server.")
enum HBaseAuthenticationType {
  Anonymous,
  Basic,
}

@doc("The type of Hive server.")
enum HiveServerType {
  HiveServer1,
  HiveServer2,
  HiveThriftServer,
}

@doc("The transport protocol to use in the Thrift layer.")
enum HiveThriftTransportProtocol {
  Binary,
  SASL,
  `HTTP `,
}

@doc("The authentication method used to access the Hive server.")
enum HiveAuthenticationType {
  Anonymous,
  Username,
  UsernameAndPassword,
  WindowsAzureHDInsightService,
}

@doc("The authentication type to use.")
enum ImpalaAuthenticationType {
  Anonymous,
  SASLUsername,
  UsernameAndPassword,
}

@doc("The authentication mechanism used to connect to the Phoenix server.")
enum PhoenixAuthenticationType {
  Anonymous,
  UsernameAndPassword,
  WindowsAzureHDInsightService,
}

@doc("The authentication mechanism used to connect to the Presto server.")
enum PrestoAuthenticationType {
  Anonymous,
  LDAP,
}

@doc("The authentication type to use.")
enum ServiceNowAuthenticationType {
  Basic,
  OAuth2,
}

@doc("The type of Spark server.")
enum SparkServerType {
  SharkServer,
  SharkServer2,
  SparkThriftServer,
}

@doc("The transport protocol to use in the Thrift layer.")
enum SparkThriftTransportProtocol {
  Binary,
  SASL,
  `HTTP `,
}

@doc("The authentication method used to access the Spark server.")
enum SparkAuthenticationType {
  Anonymous,
  Username,
  UsernameAndPassword,
  WindowsAzureHDInsightService,
}

@doc("The OAuth 2.0 authentication mechanism used for authentication. ServiceAuthentication can only be used on self-hosted IR.")
enum GoogleAdWordsAuthenticationType {
  ServiceAuthentication,
  UserAuthentication,
}

@doc("The consistency level specifies how many Cassandra servers must respond to a read request before returning data to the client application. Cassandra checks the specified number of Cassandra servers for data to satisfy the read request. Must be one of cassandraSourceReadConsistencyLevels. The default value is 'ONE'. It is case-insensitive.")
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

@doc("Stored procedure parameter type.")
enum StoredProcedureParameterType {
  String,
  Int,
  Int64,
  Decimal,
  Guid,
  Boolean,
  Date,
}

@doc("The write behavior for the operation. Default is 'Insert'.")
enum SapCloudForCustomerSinkWriteBehavior {
  Insert,
  Update,
}

@doc("Indicates whether the RejectValue property is specified as a literal value or a percentage.")
enum PolybaseSettingsRejectType {
  value,
  percentage,
}

@doc("Specify the write behavior when upserting documents into Azure Search Index.")
enum AzureSearchIndexWriteBehaviorType {
  Merge,
  Upload,
}

@doc("Defines values for DynamicsSinkWriteBehavior.")
enum DynamicsSinkWriteBehavior {
  Upsert,
}

@doc("The write behavior for the operation. Default is Insert.")
enum SalesforceSinkWriteBehavior {
  Insert,
  Upsert,
}

@doc("The HDInsightActivityDebugInfoOption settings to use.")
enum HDInsightActivityDebugInfoOption {
  None,
  Always,
  Failure,
}

@doc("The type of SSIS package location.")
enum SsisPackageLocationType {
  SSISDB,
  File,
  InlinePackage,
  PackageStore,
}

@doc("The type of SSIS log location.")
enum SsisLogLocationType {
  File,
}

@doc("The list of HTTP methods supported by a WebActivity.")
enum WebActivityMethod {
  GET,
  POST,
  PUT,
  DELETE,
}

@doc("The list of HTTP methods supported by a AzureFunctionActivity.")
enum AzureFunctionActivityMethod {
  GET,
  POST,
  PUT,
  DELETE,
  OPTIONS,
  HEAD,
  TRACE,
}

@doc("The list of HTTP methods supported by a WebHook activity.")
enum WebHookActivityMethod {
  POST,
}

@doc("The type of the query. Type: string.")
enum ScriptType {
  Query,
  NonQuery,
}

@doc("The type of the parameter.")
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

@doc("The direction of the parameter.")
enum ScriptActivityParameterDirection {
  Input,
  Output,
  InputOutput,
}

@doc("The destination of logs. Type: string.")
enum ScriptActivityLogDestination {
  ActivityOutput,
  ExternalStore,
}

@doc("Synapse notebook reference type.")
enum NotebookReferenceType {
  NotebookReference,
}

@doc("Big data pool reference type.")
enum BigDataPoolReferenceType {
  BigDataPoolReference,
}

@doc("Notebook parameter type.")
enum NotebookParameterType {
  string,
  int,
  float,
  bool,
}

@doc("The type of the spark config.")
enum ConfigurationType {
  Default,
  Customized,
  Artifact,
}

@doc("Spark configuration reference type.")
enum SparkConfigurationReferenceType {
  SparkConfigurationReference,
}

@doc("Synapse spark job reference type.")
enum SparkJobReferenceType {
  SparkJobDefinitionReference,
}

@doc("Enumerates possible frequency option for the schedule trigger.")
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

@doc("Enumerates possible frequency option for the tumbling window trigger.")
enum TumblingWindowFrequency {
  Minute,
  Hour,
  Month,
}

@doc("Trigger reference type.")
enum TriggerReferenceType {
  TriggerReference,
}

@doc("JSON format file pattern. A property of JsonFormat.")
enum JsonFormatFilePattern {
  setOfObjects,
  arrayOfObjects,
}

@doc("All available compression levels.")
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

@doc("All available compressionCodec values.")
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

@doc("All available dynamicsDeploymentType values.")
enum DynamicsDeploymentType {
  Online,
  OnPremisesWithIfd,
}

@doc("All available dynamicsAuthenticationType values.")
enum DynamicsAuthenticationType {
  Office365,
  Ifd,
  AADServicePrincipal,
}

@doc("All available servicePrincipalCredentialType values.")
enum ServicePrincipalCredentialType {
  ServicePrincipalKey,
  ServicePrincipalCert,
}

@doc("All available HdiNodeTypes values.")
enum HdiNodeTypes {
  Headnode,
  Workernode,
  Zookeeper,
}

@doc("All available filePatterns.")
enum JsonWriteFilePattern {
  setOfObjects,
  arrayOfObjects,
}

@doc("The Salesforce read behavior for the operation")
enum SalesforceSourceReadBehavior {
  Query,
  QueryAll,
}

enum AmazonRdsForOraclePartitionOption {
  None,
  PhysicalPartitionsOfTable,
  DynamicRange,
}

@doc("All available types of copy behavior.")
enum CopyBehaviorType {
  PreserveHierarchy,
  FlattenHierarchy,
  MergeFiles,
}

@doc("Specify the write behavior when copying data into sql.")
enum SqlWriteBehaviorEnum {
  Insert,
  Upsert,
  StoredProcedure,
}

@doc("Specify the write behavior when copying data into sql dw.")
enum SqlDWWriteBehaviorEnum {
  Insert,
  Upsert,
}

@doc("The partition mechanism that will be used for Sql read in parallel.")
enum SqlPartitionOption {
  None,
  PhysicalPartitionsOfTable,
  DynamicRange,
}

@doc("The partition mechanism that will be used for SAP HANA read in parallel.")
enum SapHanaPartitionOption {
  None,
  PhysicalPartitionsOfTable,
  SapHanaDynamicRange,
}

@doc("The partition mechanism that will be used for SAP table read in parallel.")
enum SapTablePartitionOption {
  None,
  PartitionOnInt,
  PartitionOnCalendarYear,
  PartitionOnCalendarMonth,
  PartitionOnCalendarDate,
  PartitionOnTime,
}

@doc("The partition mechanism that will be used for Oracle read in parallel.")
enum OraclePartitionOption {
  None,
  PhysicalPartitionsOfTable,
  DynamicRange,
}

@doc("The partition mechanism that will be used for teradata read in parallel.")
enum TeradataPartitionOption {
  None,
  Hash,
  DynamicRange,
}

@doc("The partition mechanism that will be used for Netezza read in parallel.")
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

@doc("The days of the week.")
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

@doc("Additional details about an operation.")
model OperationProperties {
  @doc("Details about a service operation.")
  serviceSpecification?: OperationServiceSpecification;
}

@doc("Details about a service operation.")
model OperationServiceSpecification {
  @doc("Details about operations related to logs.")
  logSpecifications?: OperationLogSpecification[];

  @doc("Details about operations related to metrics.")
  metricSpecifications?: OperationMetricSpecification[];
}

@doc("Details about an operation related to logs.")
model OperationLogSpecification {
  @doc("The name of the log category.")
  name?: string;

  @doc("Localized display name.")
  displayName?: string;

  @doc("Blobs created in the customer storage account, per hour.")
  blobDuration?: string;
}

@doc("Details about an operation related to metrics.")
model OperationMetricSpecification {
  @doc("The name of the metric.")
  name?: string;

  @doc("Localized display name of the metric.")
  displayName?: string;

  @doc("The description of the metric.")
  displayDescription?: string;

  @doc("The unit that the metric is measured in.")
  unit?: string;

  @doc("The type of metric aggregation.")
  aggregationType?: string;

  @doc("Whether or not the service is using regional MDM accounts.")
  enableRegionalMdmAccount?: string;

  @doc("The name of the MDM account.")
  sourceMdmAccount?: string;

  @doc("The name of the MDM namespace.")
  sourceMdmNamespace?: string;

  @doc("Defines how often data for metrics becomes available.")
  availabilities?: OperationMetricAvailability[];

  @doc("Defines the metric dimension.")
  dimensions?: OperationMetricDimension[];
}

@doc("Defines how often data for a metric becomes available.")
model OperationMetricAvailability {
  @doc("The granularity for the metric.")
  timeGrain?: string;

  @doc("Blob created in the customer storage account, per hour.")
  blobDuration?: string;
}

@doc("Defines the metric dimension.")
model OperationMetricDimension {
  @doc("The name of the dimension for the metric.")
  name?: string;

  @doc("The display name of the metric dimension.")
  displayName?: string;

  @doc("Whether the dimension should be exported to Azure Monitor.")
  toBeExportedForShoebox?: boolean;
}

@doc("The object that defines the structure of an Azure Data Factory error response.")
@error
model CloudError {
  @doc("Error data")
  error: CloudErrorBody;
}

@doc("The object that defines the structure of an Azure Data Factory error.")
model CloudErrorBody {
  @doc("Error code.")
  code: string;

  @doc("Error message.")
  message: string;

  @doc("Property name/path in request associated with error.")
  target?: string;

  @doc("Array with additional error details.")
  details?: CloudError[];
}

@doc("Identity properties of the factory resource.")
model FactoryIdentity {
  @doc("The identity type.")
  type: FactoryIdentityType;

  @doc("The principal id of the identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client tenant id of the identity.")
  @visibility("read")
  tenantId?: string;
}

@doc("Factory resource properties.")
model FactoryProperties {
  @doc("Factory provisioning state, example Succeeded.")
  @visibility("read")
  provisioningState?: string;

  @doc("Time the factory was created in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  @doc("Version of the factory.")
  @visibility("read")
  version?: string;

  @doc("Purview information of the factory.")
  purviewConfiguration?: PurviewConfiguration;

  @doc("Git repo information of the factory.")
  repoConfiguration?: FactoryRepoConfiguration;

  @doc("List of parameters for factory.")
  globalParameters?: Record<GlobalParameterSpecification>;

  @doc("Properties to enable Customer Managed Key for the factory.")
  encryption?: EncryptionConfiguration;

  @doc("Whether or not public network access is allowed for the data factory.")
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("Purview configuration.")
model PurviewConfiguration {
  @doc("Purview resource id.")
  purviewResourceId?: string;
}

@doc("Factory's git repo information.")
@discriminator("type")
model FactoryRepoConfiguration {
  @doc("Account name.")
  accountName: string;

  @doc("Repository name.")
  repositoryName: string;

  @doc("Collaboration branch.")
  collaborationBranch: string;

  @doc("Root folder.")
  rootFolder: string;

  @doc("Last commit id.")
  lastCommitId?: string;

  @doc("Disable manual publish operation in ADF studio to favor automated publish.")
  disablePublish?: boolean;
}

@doc("Definition of a single parameter for an entity.")
model GlobalParameterSpecification {
  @doc("Global Parameter type.")
  type: GlobalParameterType;

  @doc("Value of parameter.")
  value: Record<unknown>;
}

@doc("Definition of CMK for the factory.")
model EncryptionConfiguration {
  @doc("The name of the key in Azure Key Vault to use as Customer Managed Key.")
  keyName: string;

  @doc("The url of the Azure Key Vault used for CMK.")
  vaultBaseUrl: string;

  @doc("The version of the key used for CMK. If not provided, latest version will be used.")
  keyVersion?: string;

  @doc("User assigned identity to use to authenticate to customer's key vault. If not provided Managed Service Identity will be used.")
  identity?: CMKIdentityDefinition;
}

@doc("Managed Identity used for CMK.")
model CMKIdentityDefinition {
  @doc("The resource id of the user assigned identity to authenticate to customer's key vault.")
  userAssignedIdentity?: string;
}

@doc("Azure Data Factory top-level resource.")
model Resource {
  @doc("The resource identifier.")
  @visibility("read")
  id?: string;

  @doc("The resource name.")
  @visibility("read")
  name?: string;

  @doc("The resource type.")
  @visibility("read")
  type?: string;

  @doc("The resource location.")
  @visibility("read", "create")
  location?: string;

  @doc("The resource tags.")
  tags?: Record<string>;

  @doc("Etag identifies change in the resource.")
  @visibility("read")
  eTag?: string;
}

@doc("Factory's git repo information.")
model FactoryRepoUpdate {
  @doc("The factory resource id.")
  factoryResourceId?: string;

  @doc("Git repo information of the factory.")
  repoConfiguration?: FactoryRepoConfiguration;
}

@doc("The exposure control request.")
model ExposureControlRequest {
  @doc("The feature name.")
  featureName?: string;

  @doc("The feature type.")
  featureType?: string;
}

@doc("The exposure control response.")
model ExposureControlResponse {
  @doc("The feature name.")
  @visibility("read")
  featureName?: string;

  @doc("The feature value.")
  @visibility("read")
  value?: string;
}

@doc("A list of exposure control features.")
model ExposureControlBatchRequest {
  @doc("List of exposure control features.")
  exposureControlRequests: ExposureControlRequest[];
}

@doc("A list of exposure control feature values.")
model ExposureControlBatchResponse {
  @doc("List of exposure control feature values.")
  exposureControlResponses: ExposureControlResponse[];
}

@doc("Parameters for updating a factory resource.")
model FactoryUpdateParameters {
  @doc("The resource tags.")
  tags?: Record<string>;

  @doc("Managed service identity of the factory.")
  identity?: FactoryIdentity;

  @doc("Properties of update the factory.")
  properties?: FactoryUpdateProperties;
}

@doc("Factory update resource properties.")
model FactoryUpdateProperties {
  @doc("Whether or not public network access is allowed for the data factory.")
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("Get GitHub access token request definition.")
model GitHubAccessTokenRequest {
  @doc("GitHub access code.")
  gitHubAccessCode: string;

  @doc("GitHub application client ID.")
  gitHubClientId?: string;

  @doc("GitHub bring your own app client secret information.")
  gitHubClientSecret?: GitHubClientSecret;

  @doc("GitHub access token base URL.")
  gitHubAccessTokenBaseUrl: string;
}

@doc("Client secret information for factory's bring your own app repository configuration.")
model GitHubClientSecret {
  @doc("Bring your own app client secret AKV URL.")
  byoaSecretAkvUrl?: string;

  @doc("Bring your own app client secret name in AKV.")
  byoaSecretName?: string;
}

@doc("Get GitHub access token response definition.")
model GitHubAccessTokenResponse {
  @doc("GitHub access token.")
  gitHubAccessToken?: string;
}

@doc("Get Data Plane read only token request definition.")
model UserAccessPolicy {
  @doc("The string with permissions for Data Plane access. Currently only 'r' is supported which grants read only access.")
  permissions?: string;

  @doc("The resource path to get access relative to factory. Currently only empty string is supported which corresponds to the factory resource.")
  accessResourcePath?: string;

  @doc("The name of the profile. Currently only the default is supported. The default value is DefaultProfile.")
  profileName?: string;

  @doc("Start time for the token. If not specified the current time will be used.")
  startTime?: string;

  @doc("Expiration time for the token. Maximum duration for the token is eight hours and by default the token will expire in eight hours.")
  expireTime?: string;
}

@doc("Get Data Plane read only token response definition.")
model AccessPolicyResponse {
  @doc("The user access policy.")
  policy?: UserAccessPolicy;

  @doc("Data Plane read only access token.")
  accessToken?: string;

  @doc("Data Plane service base URL.")
  dataPlaneUrl?: string;
}

@doc("Azure Data Factory nested object which serves as a compute resource for activities.")
@discriminator("type")
model IntegrationRuntime extends Record<Record<unknown>> {
  @doc("Integration runtime description.")
  description?: string;
}

@doc("Azure Data Factory nested resource, which belongs to a factory.")
model SubResource {
  @doc("The resource identifier.")
  @visibility("read")
  id?: string;

  @doc("The resource name.")
  @visibility("read")
  name?: string;

  @doc("The resource type.")
  @visibility("read")
  type?: string;

  @doc("Etag identifies change in the resource.")
  @visibility("read")
  etag?: string;
}

@doc("Update integration runtime request.")
model UpdateIntegrationRuntimeRequest {
  @doc("Enables or disables the auto-update feature of the self-hosted integration runtime. See https://go.microsoft.com/fwlink/?linkid=854189.")
  autoUpdate?: IntegrationRuntimeAutoUpdate;

  @doc("The time offset (in hours) in the day, e.g., PT03H is 3 hours. The integration runtime auto update will happen on that time.")
  updateDelayOffset?: duration;
}

@doc("Integration runtime status response.")
model IntegrationRuntimeStatusResponse {
  @doc("The integration runtime name.")
  @visibility("read")
  name?: string;

  @doc("Integration runtime properties.")
  properties: IntegrationRuntimeStatus;
}

@doc("Integration runtime status.")
@discriminator("type")
model IntegrationRuntimeStatus extends Record<Record<unknown>> {
  @doc("The data factory name which the integration runtime belong to.")
  @visibility("read")
  dataFactoryName?: string;

  @doc("The state of integration runtime.")
  @visibility("read")
  state?: IntegrationRuntimeState;
}

@doc("Azure-SSIS integration runtime outbound network dependency endpoints.")
model IntegrationRuntimeOutboundNetworkDependenciesEndpointsResponse {
  @doc("The list of outbound network dependency endpoints.")
  value?: IntegrationRuntimeOutboundNetworkDependenciesCategoryEndpoint[];
}

@doc("Azure-SSIS integration runtime outbound network dependency endpoints for one category.")
model IntegrationRuntimeOutboundNetworkDependenciesCategoryEndpoint {
  @doc("The category of outbound network dependency.")
  category?: string;

  @doc("The endpoints for outbound network dependency.")
  endpoints?: IntegrationRuntimeOutboundNetworkDependenciesEndpoint[];
}

@doc("The endpoint for Azure-SSIS integration runtime outbound network dependency.")
model IntegrationRuntimeOutboundNetworkDependenciesEndpoint {
  @doc("The domain name of endpoint.")
  domainName?: string;

  @doc("The details of endpoint.")
  endpointDetails?: IntegrationRuntimeOutboundNetworkDependenciesEndpointDetails[];
}

@doc("The details of Azure-SSIS integration runtime outbound network dependency endpoint.")
model IntegrationRuntimeOutboundNetworkDependenciesEndpointDetails {
  @doc("The port of endpoint.")
  port?: int32;
}

@doc("Connection information for encrypting the on-premises data source credentials.")
model IntegrationRuntimeConnectionInfo extends Record<Record<unknown>> {
  @doc("The token generated in service. Callers use this token to authenticate to integration runtime.")
  @visibility("read")
  serviceToken?: string;

  @doc("The integration runtime SSL certificate thumbprint. Click-Once application uses it to do server validation.")
  @visibility("read")
  identityCertThumbprint?: string;

  @doc("The on-premises integration runtime host URL.")
  @visibility("read")
  hostServiceUri?: string;

  @doc("The integration runtime version.")
  @visibility("read")
  version?: string;

  @doc("The public key for encrypting a credential when transferring the credential to the integration runtime.")
  @visibility("read")
  publicKey?: string;

  @doc("Whether the identity certificate is expired.")
  @visibility("read")
  isIdentityCertExprired?: boolean;
}

@doc("Parameters to regenerate the authentication key.")
model IntegrationRuntimeRegenerateKeyParameters {
  @doc("The name of the authentication key to regenerate.")
  keyName?: IntegrationRuntimeAuthKeyName;
}

@doc("The integration runtime authentication keys.")
model IntegrationRuntimeAuthKeys {
  @doc("The primary integration runtime authentication key.")
  authKey1?: string;

  @doc("The secondary integration runtime authentication key.")
  authKey2?: string;
}

@doc("Get monitoring data response.")
model IntegrationRuntimeMonitoringData {
  @doc("Integration runtime name.")
  name?: string;

  @doc("Integration runtime node monitoring data.")
  nodes?: IntegrationRuntimeNodeMonitoringData[];
}

@doc("Monitoring data for integration runtime node.")
model IntegrationRuntimeNodeMonitoringData extends Record<Record<unknown>> {
  @doc("Name of the integration runtime node.")
  @visibility("read")
  nodeName?: string;

  @doc("Available memory (MB) on the integration runtime node.")
  @visibility("read")
  availableMemoryInMB?: int32;

  @doc("CPU percentage on the integration runtime node.")
  @visibility("read")
  cpuUtilization?: int32;

  @doc("Maximum concurrent jobs on the integration runtime node.")
  @visibility("read")
  concurrentJobsLimit?: int32;

  @doc("The number of jobs currently running on the integration runtime node.")
  @visibility("read")
  concurrentJobsRunning?: int32;

  @doc("The maximum concurrent jobs in this integration runtime.")
  @visibility("read")
  maxConcurrentJobs?: int32;

  @doc("Sent bytes on the integration runtime node.")
  @visibility("read")
  sentBytes?: float32;

  @doc("Received bytes on the integration runtime node.")
  @visibility("read")
  receivedBytes?: float32;
}

@doc("Data factory name for linked integration runtime request.")
model LinkedIntegrationRuntimeRequest {
  @doc("The data factory name for linked integration runtime.")
  @projectedName("json", "factoryName")
  linkedFactoryName: string;
}

@doc("The linked integration runtime information.")
model CreateLinkedIntegrationRuntimeRequest {
  @doc("The name of the linked integration runtime.")
  name?: string;

  @doc("The ID of the subscription that the linked integration runtime belongs to.")
  subscriptionId?: string;

  @doc("The name of the data factory that the linked integration runtime belongs to.")
  dataFactoryName?: string;

  @doc("The location of the data factory that the linked integration runtime belongs to.")
  dataFactoryLocation?: string;
}

@doc("The status of the operation.")
model SsisObjectMetadataStatusResponse {
  @doc("The status of the operation.")
  status?: string;

  @doc("The operation name.")
  name?: string;

  @doc("The operation properties.")
  properties?: string;

  @doc("The operation error message.")
  error?: string;
}

@doc("The request payload of get SSIS object metadata.")
model GetSsisObjectMetadataRequest {
  @doc("Metadata path.")
  metadataPath?: string;
}

@doc("A list of SSIS object metadata.")
model SsisObjectMetadataListResponse {
  @doc("List of SSIS object metadata.")
  value?: SsisObjectMetadata[];

  @doc("The link to the next page of results, if any remaining results exist.")
  nextLink?: string;
}

@doc("SSIS object metadata.")
@discriminator("type")
model SsisObjectMetadata {
  @doc("Metadata id.")
  id?: int32;

  @doc("Metadata name.")
  name?: string;

  @doc("Metadata description.")
  description?: string;
}

@doc("Properties of Self-hosted integration runtime node.")
model SelfHostedIntegrationRuntimeNode extends Record<Record<unknown>> {
  @doc("Name of the integration runtime node.")
  @visibility("read")
  nodeName?: string;

  @doc("Machine name of the integration runtime node.")
  @visibility("read")
  machineName?: string;

  @doc("URI for the host machine of the integration runtime.")
  @visibility("read")
  hostServiceUri?: string;

  @doc("Status of the integration runtime node.")
  @visibility("read")
  status?: SelfHostedIntegrationRuntimeNodeStatus;

  @doc("The integration runtime capabilities dictionary")
  @visibility("read")
  capabilities?: Record<string>;

  @doc("Status of the integration runtime node version.")
  @visibility("read")
  versionStatus?: string;

  @doc("Version of the integration runtime node.")
  @visibility("read")
  version?: string;

  @doc("The time at which the integration runtime node was registered in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  registerTime?: utcDateTime;

  @doc("The most recent time at which the integration runtime was connected in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastConnectTime?: utcDateTime;

  @doc("The time at which the integration runtime will expire in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  @doc("The time the node last started up.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStartTime?: utcDateTime;

  @doc("The integration runtime node last stop time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStopTime?: utcDateTime;

  @doc("The result of the last integration runtime node update.")
  @visibility("read")
  lastUpdateResult?: IntegrationRuntimeUpdateResult;

  @doc("The last time for the integration runtime node update start.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStartUpdateTime?: utcDateTime;

  @doc("The last time for the integration runtime node update end.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastEndUpdateTime?: utcDateTime;

  @doc("Indicates whether this node is the active dispatcher for integration runtime requests.")
  @visibility("read")
  isActiveDispatcher?: boolean;

  @doc("Maximum concurrent jobs on the integration runtime node.")
  @visibility("read")
  concurrentJobsLimit?: int32;

  @doc("The maximum concurrent jobs in this integration runtime.")
  @visibility("read")
  maxConcurrentJobs?: int32;
}

@doc("Update integration runtime node request.")
model UpdateIntegrationRuntimeNodeRequest {
  @doc("The number of concurrent jobs permitted to run on the integration runtime node. Values between 1 and maxConcurrentJobs(inclusive) are allowed.")
  @minValue(1)
  concurrentJobsLimit?: int32;
}

@doc("The IP address of self-hosted integration runtime node.")
model IntegrationRuntimeNodeIpAddress {
  @doc("The IP address of self-hosted integration runtime node.")
  @visibility("read")
  ipAddress?: string;
}

@doc("The nested object which contains the information and credential which can be used to connect with related store or compute resource.")
@discriminator("type")
model LinkedService extends Record<Record<unknown>> {
  @doc("The integration runtime reference.")
  connectVia?: IntegrationRuntimeReference;

  @doc("Linked service description.")
  description?: string;

  @doc("Parameters for linked service.")
  parameters?: Record<ParameterSpecification>;

  @doc("List of tags that can be used for describing the linked service.")
  annotations?: Record<unknown>[];
}

@doc("Integration runtime reference type.")
model IntegrationRuntimeReference {
  @doc("Type of integration runtime.")
  type: IntegrationRuntimeReferenceType;

  @doc("Reference integration runtime name.")
  referenceName: string;

  @doc("Arguments for integration runtime.")
  parameters?: Record<Record<unknown>>;
}

@doc("Definition of a single parameter for an entity.")
model ParameterSpecification {
  @doc("Parameter type.")
  type: ParameterType;

  @doc("Default value of parameter.")
  defaultValue?: Record<unknown>;
}

@doc("The Azure Data Factory nested object which identifies data within different data stores, such as tables, files, folders, and documents.")
@discriminator("type")
model Dataset extends Record<Record<unknown>> {
  @doc("Dataset description.")
  description?: string;

  @doc("Columns that define the structure of the dataset. Type: array (or Expression with resultType array), itemType: DatasetDataElement.")
  structure?: Record<unknown>;

  @doc("Columns that define the physical type schema of the dataset. Type: array (or Expression with resultType array), itemType: DatasetSchemaDataElement.")
  schema?: Record<unknown>;

  @doc("Linked service reference.")
  linkedServiceName: LinkedServiceReference;

  @doc("Parameters for dataset.")
  parameters?: Record<ParameterSpecification>;

  @doc("List of tags that can be used for describing the Dataset.")
  annotations?: Record<unknown>[];

  @doc("The folder that this Dataset is in. If not specified, Dataset will appear at the root level.")
  folder?: DatasetFolder;
}

@doc("Linked service reference type.")
model LinkedServiceReference {
  @doc("Linked service reference type.")
  type: LinkedServiceReferenceType;

  @doc("Reference LinkedService name.")
  referenceName: string;

  @doc("Arguments for LinkedService.")
  parameters?: Record<Record<unknown>>;
}

@doc("The folder that this Dataset is in. If not specified, Dataset will appear at the root level.")
model DatasetFolder {
  @doc("The name of the folder that this Dataset is in.")
  name?: string;
}

@doc("A data factory pipeline.")
model Pipeline {
  @doc("The description of the pipeline.")
  description?: string;

  @doc("List of activities in pipeline.")
  activities?: Activity[];

  @doc("List of parameters for pipeline.")
  parameters?: Record<ParameterSpecification>;

  @doc("List of variables for pipeline.")
  variables?: Record<VariableSpecification>;

  @doc("The max number of concurrent runs for the pipeline.")
  @minValue(1)
  concurrency?: int32;

  @doc("List of tags that can be used for describing the Pipeline.")
  annotations?: Record<unknown>[];

  @doc("Dimensions emitted by Pipeline.")
  runDimensions?: Record<Record<unknown>>;

  @doc("The folder that this Pipeline is in. If not specified, Pipeline will appear at the root level.")
  folder?: PipelineFolder;

  @doc("Pipeline Policy.")
  policy?: PipelinePolicy;
}

@doc("A pipeline activity.")
@discriminator("type")
model Activity extends Record<Record<unknown>> {
  @doc("Activity name.")
  name: string;

  @doc("Activity description.")
  description?: string;

  @doc("Activity state. This is an optional property and if not provided, the state will be Active by default.")
  state?: ActivityState;

  @doc("Status result of the activity when the state is set to Inactive. This is an optional property and if not provided when the activity is inactive, the status will be Succeeded by default.")
  onInactiveMarkAs?: ActivityOnInactiveMarkAs;

  @doc("Activity depends on condition.")
  dependsOn?: ActivityDependency[];

  @doc("Activity user properties.")
  userProperties?: UserProperty[];
}

@doc("Activity dependency information.")
model ActivityDependency extends Record<Record<unknown>> {
  @doc("Activity name.")
  activity: string;

  @doc("Match-Condition for the dependency.")
  dependencyConditions: DependencyCondition[];
}

@doc("User property.")
model UserProperty {
  @doc("User property name.")
  name: string;

  @doc("User property value. Type: string (or Expression with resultType string).")
  value: Record<unknown>;
}

@doc("Definition of a single variable for a Pipeline.")
model VariableSpecification {
  @doc("Variable type.")
  type: VariableType;

  @doc("Default value of variable.")
  defaultValue?: Record<unknown>;
}

@doc("The folder that this Pipeline is in. If not specified, Pipeline will appear at the root level.")
model PipelineFolder {
  @doc("The name of the folder that this Pipeline is in.")
  name?: string;
}

@doc("Pipeline Policy.")
model PipelinePolicy {
  @doc("Pipeline ElapsedTime Metric Policy.")
  elapsedTimeMetric?: PipelineElapsedTimeMetricPolicy;
}

@doc("Pipeline ElapsedTime Metric Policy.")
model PipelineElapsedTimeMetricPolicy {
  @doc("TimeSpan value, after which an Azure Monitoring Metric is fired.")
  duration?: Record<unknown>;
}

@doc("Response body with a run identifier.")
model CreateRunResponse {
  @doc("Identifier of a run.")
  runId: string;
}

@doc("Query parameters for listing runs.")
model RunFilterParameters {
  @doc("The continuation token for getting the next page of results. Null for first page.")
  continuationToken?: string;

  @doc("The time at or after which the run event was updated in 'ISO 8601' format.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedAfter: utcDateTime;

  @doc("The time at or before which the run event was updated in 'ISO 8601' format.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedBefore: utcDateTime;

  @doc("List of filters.")
  filters?: RunQueryFilter[];

  @doc("List of OrderBy option.")
  orderBy?: RunQueryOrderBy[];
}

@doc("Query filter option for listing runs.")
model RunQueryFilter {
  @doc("Parameter name to be used for filter. The allowed operands to query pipeline runs are PipelineName, RunStart, RunEnd and Status; to query activity runs are ActivityName, ActivityRunStart, ActivityRunEnd, ActivityType and Status, and to query trigger runs are TriggerName, TriggerRunTimestamp and Status.")
  operand: RunQueryFilterOperand;

  @doc("Operator to be used for filter.")
  operator: RunQueryFilterOperator;

  @doc("List of filter values.")
  values: string[];
}

@doc("An object to provide order by options for listing runs.")
model RunQueryOrderBy {
  @doc("Parameter name to be used for order by. The allowed parameters to order by for pipeline runs are PipelineName, RunStart, RunEnd and Status; for activity runs are ActivityName, ActivityRunStart, ActivityRunEnd and Status; for trigger runs are TriggerName, TriggerRunTimestamp and Status.")
  orderBy: RunQueryOrderByField;

  @doc("Sorting order of the parameter.")
  order: RunQueryOrder;
}

@doc("A list pipeline runs.")
model PipelineRunsQueryResponse {
  @doc("List of pipeline runs.")
  value: PipelineRun[];

  @doc("The continuation token for getting the next page of results, if any remaining results exist, null otherwise.")
  continuationToken?: string;
}

@doc("Information about a pipeline run.")
model PipelineRun extends Record<Record<unknown>> {
  @doc("Identifier of a run.")
  @visibility("read")
  runId?: string;

  @doc("Identifier that correlates all the recovery runs of a pipeline run.")
  @visibility("read")
  runGroupId?: string;

  @doc("Indicates if the recovered pipeline run is the latest in its group.")
  @visibility("read")
  isLatest?: boolean;

  @doc("The pipeline name.")
  @visibility("read")
  pipelineName?: string;

  @doc("The full or partial list of parameter name, value pair used in the pipeline run.")
  @visibility("read")
  parameters?: Record<string>;

  @doc("Run dimensions emitted by Pipeline run.")
  @visibility("read")
  runDimensions?: Record<string>;

  @doc("Entity that started the pipeline run.")
  @visibility("read")
  invokedBy?: PipelineRunInvokedBy;

  @doc("The last updated timestamp for the pipeline run event in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  @doc("The start time of a pipeline run in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  runStart?: utcDateTime;

  @doc("The end time of a pipeline run in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  runEnd?: utcDateTime;

  @doc("The duration of a pipeline run.")
  @visibility("read")
  durationInMs?: int32;

  @doc("The status of a pipeline run. Possible values: Queued, InProgress, Succeeded, Failed, Canceling, Cancelled")
  @visibility("read")
  status?: string;

  @doc("The message from a pipeline run.")
  @visibility("read")
  message?: string;
}

@doc("Provides entity name and id that started the pipeline run.")
model PipelineRunInvokedBy {
  @doc("Name of the entity that started the pipeline run.")
  @visibility("read")
  name?: string;

  @doc("The ID of the entity that started the run.")
  @visibility("read")
  id?: string;

  @doc("The type of the entity that started the run.")
  @visibility("read")
  invokedByType?: string;

  @doc("The name of the pipeline that triggered the run, if any.")
  @visibility("read")
  pipelineName?: string;

  @doc("The run id of the pipeline that triggered the run, if any.")
  @visibility("read")
  pipelineRunId?: string;
}

@doc("A list activity runs.")
model ActivityRunsQueryResponse {
  @doc("List of activity runs.")
  value: ActivityRun[];

  @doc("The continuation token for getting the next page of results, if any remaining results exist, null otherwise.")
  continuationToken?: string;
}

@doc("Information about an activity run in a pipeline.")
model ActivityRun extends Record<Record<unknown>> {
  @doc("The name of the pipeline.")
  @visibility("read")
  pipelineName?: string;

  @doc("The id of the pipeline run.")
  @visibility("read")
  pipelineRunId?: string;

  @doc("The name of the activity.")
  @visibility("read")
  activityName?: string;

  @doc("The type of the activity.")
  @visibility("read")
  activityType?: string;

  @doc("The id of the activity run.")
  @visibility("read")
  activityRunId?: string;

  @doc("The name of the compute linked service.")
  @visibility("read")
  linkedServiceName?: string;

  @doc("The status of the activity run.")
  @visibility("read")
  status?: string;

  @doc("The start time of the activity run in 'ISO 8601' format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  activityRunStart?: utcDateTime;

  @doc("The end time of the activity run in 'ISO 8601' format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  activityRunEnd?: utcDateTime;

  @doc("The duration of the activity run.")
  @visibility("read")
  durationInMs?: int32;

  @doc("The input for the activity.")
  @visibility("read")
  input?: Record<unknown>;

  @doc("The output for the activity.")
  @visibility("read")
  output?: Record<unknown>;

  @doc("The error if any from the activity run.")
  @visibility("read")
  error?: Record<unknown>;
}

@doc("Azure data factory nested object which contains information about creating pipeline run")
@discriminator("type")
model Trigger extends Record<Record<unknown>> {
  @doc("Trigger description.")
  description?: string;

  @doc("Indicates if trigger is running or not. Updated when Start/Stop APIs are called on the Trigger.")
  @visibility("read")
  runtimeState?: TriggerRuntimeState;

  @doc("List of tags that can be used for describing the trigger.")
  annotations?: Record<unknown>[];
}

@doc("Query parameters for triggers.")
model TriggerFilterParameters {
  @doc("The continuation token for getting the next page of results. Null for first page.")
  continuationToken?: string;

  @doc("The name of the parent TumblingWindowTrigger to get the child rerun triggers")
  parentTriggerName?: string;
}

@doc("A query of triggers.")
model TriggerQueryResponse {
  @doc("List of triggers.")
  value: TriggerResource[];

  @doc("The continuation token for getting the next page of results, if any remaining results exist, null otherwise.")
  continuationToken?: string;
}

@doc("Defines the response of a trigger subscription operation.")
model TriggerSubscriptionOperationStatus {
  @doc("Trigger name.")
  @visibility("read")
  triggerName?: string;

  @doc("Event Subscription Status.")
  @visibility("read")
  status?: EventSubscriptionStatus;
}

@doc("A list of trigger runs.")
model TriggerRunsQueryResponse {
  @doc("List of trigger runs.")
  value: TriggerRun[];

  @doc("The continuation token for getting the next page of results, if any remaining results exist, null otherwise.")
  continuationToken?: string;
}

@doc("Trigger runs.")
model TriggerRun extends Record<Record<unknown>> {
  @doc("Trigger run id.")
  @visibility("read")
  triggerRunId?: string;

  @doc("Trigger name.")
  @visibility("read")
  triggerName?: string;

  @doc("Trigger type.")
  @visibility("read")
  triggerType?: string;

  @doc("Trigger run start time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  triggerRunTimestamp?: utcDateTime;

  @doc("Trigger run status.")
  @visibility("read")
  status?: TriggerRunStatus;

  @doc("Trigger error message.")
  @visibility("read")
  message?: string;

  @doc("List of property name and value related to trigger run. Name, value pair depends on type of trigger.")
  @visibility("read")
  properties?: Record<string>;

  @doc("List of pipeline name and run Id triggered by the trigger run.")
  @visibility("read")
  triggeredPipelines?: Record<string>;

  @doc("Run dimension for which trigger was fired.")
  @visibility("read")
  runDimension?: Record<string>;

  @doc("Status of the upstream pipelines.")
  @visibility("read")
  dependencyStatus?: Record<Record<unknown>>;
}

@doc("Azure Data Factory nested object which contains a flow with data movements and transformations.")
@discriminator("type")
model DataFlow {
  @doc("The description of the data flow.")
  description?: string;

  @doc("List of tags that can be used for describing the data flow.")
  annotations?: Record<unknown>[];

  @doc("The folder that this data flow is in. If not specified, Data flow will appear at the root level.")
  folder?: DataFlowFolder;
}

@doc("The folder that this data flow is in. If not specified, Data flow will appear at the root level.")
model DataFlowFolder {
  @doc("The name of the folder that this data flow is in.")
  name?: string;
}

@doc("Request body structure for creating data flow debug session.")
model CreateDataFlowDebugSessionRequest {
  @doc("Compute type of the cluster. The value will be overwritten by the same setting in integration runtime if provided.")
  computeType?: string;

  @doc("Core count of the cluster. The value will be overwritten by the same setting in integration runtime if provided.")
  coreCount?: int32;

  @doc("Time to live setting of the cluster in minutes.")
  timeToLive?: int32;

  @doc("Set to use integration runtime setting for data flow debug session.")
  integrationRuntime?: IntegrationRuntimeDebugResource;
}

@doc("Integration runtime debug resource.")
model IntegrationRuntimeDebugResource extends SubResourceDebugResource {
  @doc("Integration runtime properties.")
  properties: IntegrationRuntime;
}

@doc("Azure Data Factory nested debug resource.")
model SubResourceDebugResource {
  @doc("The resource name.")
  name?: string;
}

@doc("Response body structure for creating data flow debug session.")
model CreateDataFlowDebugSessionResponse {
  @doc("The state of the debug session.")
  status?: string;

  @doc("The ID of data flow debug session.")
  sessionId?: string;
}

@doc("A list of active debug sessions.")
model QueryDataFlowDebugSessionsResponse
  is Azure.Core.Page<DataFlowDebugSessionInfo>;

@doc("Data flow debug session info.")
model DataFlowDebugSessionInfo extends Record<Record<unknown>> {
  @doc("The name of the data flow.")
  dataFlowName?: string;

  @doc("Compute type of the cluster.")
  computeType?: string;

  @doc("Core count of the cluster.")
  coreCount?: int32;

  @doc("Node count of the cluster. (deprecated property)")
  nodeCount?: int32;

  @doc("Attached integration runtime name of data flow debug session.")
  integrationRuntimeName?: string;

  @doc("The ID of data flow debug session.")
  sessionId?: string;

  @doc("Start time of data flow debug session.")
  startTime?: string;

  @doc("Compute type of the cluster.")
  timeToLiveInMinutes?: int32;

  @doc("Last activity time of data flow debug session.")
  lastActivityTime?: string;
}

@doc("Request body structure for starting data flow debug session.")
model DataFlowDebugPackage extends Record<Record<unknown>> {
  @doc("The ID of data flow debug session.")
  sessionId?: string;

  @doc("Data flow instance.")
  dataFlow?: DataFlowDebugResource;

  @doc("List of Data flows")
  dataFlows?: DataFlowDebugResource[];

  @doc("List of datasets.")
  datasets?: DatasetDebugResource[];

  @doc("List of linked services.")
  linkedServices?: LinkedServiceDebugResource[];

  @doc("Staging info for debug session.")
  staging?: DataFlowStagingInfo;

  @doc("Data flow debug settings.")
  debugSettings?: DataFlowDebugPackageDebugSettings;
}

@doc("Data flow debug resource.")
model DataFlowDebugResource extends SubResourceDebugResource {
  @doc("Data flow properties.")
  properties: DataFlow;
}

@doc("Dataset debug resource.")
model DatasetDebugResource extends SubResourceDebugResource {
  @doc("Dataset properties.")
  properties: Dataset;
}

@doc("Linked service debug resource.")
model LinkedServiceDebugResource extends SubResourceDebugResource {
  @doc("Properties of linked service.")
  properties: LinkedService;
}

@doc("Staging info for execute data flow activity.")
model DataFlowStagingInfo {
  @doc("Staging linked service reference.")
  linkedService?: LinkedServiceReference;

  @doc("Folder path for staging blob. Type: string (or Expression with resultType string)")
  folderPath?: Record<unknown>;
}

@doc("Data flow debug settings.")
model DataFlowDebugPackageDebugSettings {
  @doc("Source setting for data flow debug.")
  sourceSettings?: DataFlowSourceSetting[];

  @doc("Data flow parameters.")
  parameters?: Record<Record<unknown>>;

  @doc("Parameters for dataset.")
  datasetParameters?: Record<unknown>;
}

@doc("Definition of data flow source setting for debug.")
model DataFlowSourceSetting extends Record<Record<unknown>> {
  @doc("The data flow source name.")
  sourceName?: string;

  @doc("Defines the row limit of data flow source in debug.")
  rowLimit?: int32;
}

@doc("Response body structure for starting data flow debug session.")
model AddDataFlowToDebugSessionResponse {
  @doc("The ID of data flow debug job version.")
  jobVersion?: string;
}

@doc("Request body structure for deleting data flow debug session.")
model DeleteDataFlowDebugSessionRequest {
  @doc("The ID of data flow debug session.")
  sessionId?: string;
}

@doc("Request body structure for data flow debug command.")
model DataFlowDebugCommandRequest {
  @doc("The ID of data flow debug session.")
  sessionId?: string;

  @doc("The command type.")
  command?: DataFlowDebugCommandType;

  @doc("The command payload object.")
  commandPayload?: DataFlowDebugCommandPayload;
}

@doc("Structure of command payload.")
model DataFlowDebugCommandPayload {
  @doc("The stream name which is used for preview.")
  streamName: string;

  @doc("Row limits for preview response.")
  rowLimits?: int32;

  @doc("Array of column names.")
  columns?: string[];

  @doc("The expression which is used for preview.")
  expression?: string;
}

@doc("Response body structure of data flow result for data preview, statistics or expression preview.")
model DataFlowDebugCommandResponse {
  @doc("The run status of data preview, statistics or expression preview.")
  status?: string;

  @doc("The result data of data preview, statistics or expression preview.")
  data?: string;
}

@doc("A managed Virtual Network associated with the Azure Data Factory")
model ManagedVirtualNetwork extends Record<Record<unknown>> {
  @doc("Managed Virtual Network ID.")
  @visibility("read")
  vNetId?: string;

  @doc("Managed Virtual Network alias.")
  @visibility("read")
  `alias`?: string;
}

@doc("Properties of a managed private endpoint")
model ManagedPrivateEndpoint extends Record<Record<unknown>> {
  @doc("The managed private endpoint connection state")
  connectionState?: ConnectionStateProperties;

  @doc("Fully qualified domain names")
  fqdns?: string[];

  @doc("The groupId to which the managed private endpoint is created")
  groupId?: string;

  @doc("Denotes whether the managed private endpoint is reserved")
  @visibility("read")
  isReserved?: boolean;

  @doc("The ARM resource ID of the resource to which the managed private endpoint is created")
  privateLinkResourceId?: string;

  @doc("The managed private endpoint provisioning state")
  @visibility("read")
  provisioningState?: string;
}

@doc("The connection state of a managed private endpoint")
model ConnectionStateProperties {
  @doc("The actions required on the managed private endpoint")
  @visibility("read")
  actionsRequired?: string;

  @doc("The managed private endpoint description")
  @visibility("read")
  description?: string;

  @doc("The approval status")
  @visibility("read")
  status?: string;
}

@doc("Managed identity credential.")
model ManagedIdentityCredential extends Credential {
  @doc("Managed identity credential properties.")
  typeProperties?: ManagedIdentityTypeProperties;

  @doc("Type of credential.")
  type: "ManagedIdentity";
}

@doc("Managed identity type properties.")
model ManagedIdentityTypeProperties {
  @doc("The resource id of user assigned managed identity")
  resourceId?: string;
}

@doc("The Azure Data Factory nested object which contains the information and credential which can be used to connect with related store or compute resource.")
@discriminator("type")
model Credential extends Record<Record<unknown>> {
  @doc("Credential description.")
  description?: string;

  @doc("List of tags that can be used for describing the Credential.")
  annotations?: Record<unknown>[];
}

@doc("A remote private endpoint connection")
model RemotePrivateEndpointConnection {
  @visibility("read")
  provisioningState?: string;

  @doc("PrivateEndpoint of a remote private endpoint connection")
  privateEndpoint?: ArmIdWrapper;

  @doc("The state of a private link connection")
  privateLinkServiceConnectionState?: PrivateLinkConnectionState;
}

@doc("A wrapper for an ARM resource id")
model ArmIdWrapper {
  @visibility("read")
  id?: string;
}

@doc("The state of a private link connection")
model PrivateLinkConnectionState {
  @doc("Status of a private link connection")
  status?: string;

  @doc("Description of a private link connection")
  description?: string;

  @doc("ActionsRequired for a private link connection")
  actionsRequired?: string;
}

@doc("Private Endpoint Connection Approval ARM resource.")
model PrivateLinkConnectionApprovalRequestResource extends SubResource {
  @doc("Core resource properties")
  properties?: PrivateLinkConnectionApprovalRequest;
}

@doc("A request to approve or reject a private endpoint connection")
model PrivateLinkConnectionApprovalRequest {
  @doc("The state of a private link connection")
  privateLinkServiceConnectionState?: PrivateLinkConnectionState;

  @doc("The resource of private endpoint.")
  privateEndpoint?: PrivateEndpoint;
}

@doc("Private endpoint which a connection belongs to.")
model PrivateEndpoint {
  @doc("The resource Id for private endpoint")
  id?: string;
}

@doc("Wrapper for a collection of private link resources")
model PrivateLinkResourcesWrapper {
  value: PrivateLinkResource[];
}

@doc("A private link resource")
model PrivateLinkResource extends SubResource {
  @doc("Core resource properties")
  properties?: PrivateLinkResourceProperties;
}

@doc("Properties of a private link resource")
model PrivateLinkResourceProperties {
  @doc("GroupId of a private link resource")
  @visibility("read")
  groupId?: string;

  @doc("RequiredMembers of a private link resource")
  @visibility("read")
  requiredMembers?: string[];

  @doc("RequiredZoneNames of a private link resource")
  @visibility("read")
  requiredZoneNames?: string[];
}

@doc("A Azure Data Factory object which automatically detects data changes at the source and then sends the updated data to the destination.")
model ChangeDataCapture {
  @doc("The folder that this CDC is in. If not specified, CDC will appear at the root level.")
  folder?: ChangeDataCaptureFolder;

  @doc("The description of the change data capture.")
  description?: string;

  @doc("List of sources connections that can be used as sources in the CDC.")
  sourceConnectionsInfo: MapperSourceConnectionsInfo[];

  @doc("List of target connections that can be used as sources in the CDC.")
  targetConnectionsInfo: MapperTargetConnectionsInfo[];

  @doc("CDC policy")
  policy: MapperPolicy;

  @doc("A boolean to determine if the vnet configuration needs to be overwritten.")
  allowVNetOverride?: boolean;

  @doc("Status of the CDC as to if it is running or stopped.")
  status?: string;
}

@doc("The folder that this CDC is in. If not specified, CDC will appear at the root level.")
model ChangeDataCaptureFolder {
  @doc("The name of the folder that this CDC is in.")
  name?: string;
}

@doc("A object which contains list of tables and connection details for a source connection.")
model MapperSourceConnectionsInfo {
  @doc("List of source tables for a source connection.")
  sourceEntities?: MapperTable[];

  @doc("Source connection details.")
  connection?: MapperConnection;
}

@doc("CDC table details.")
model MapperTable {
  @doc("Name of the table.")
  name?: string;

  @doc("Table properties.")
  properties?: MapperTableProperties;
}

@doc("Properties for a CDC table.")
model MapperTableProperties {
  @doc("List of columns for the source table.")
  schema?: MapperTableSchema[];

  @doc("List of name/value pairs for connection properties.")
  dslConnectorProperties?: MapperDslConnectorProperties[];
}

@doc("Schema of a CDC table in terms of column names and their corresponding data types.")
model MapperTableSchema {
  @doc("Name of the column.")
  name?: string;

  @doc("Data type of the column.")
  dataType?: string;
}

@doc("Connector properties of a CDC table in terms of name / value pairs.")
model MapperDslConnectorProperties {
  @doc("Name of the property.")
  name?: string;

  @doc("Value of the property.")
  value?: Record<unknown>;
}

@doc("Source connection details.")
model MapperConnection {
  @doc("Linked service reference.")
  linkedService?: LinkedServiceReference;

  @doc("Type of the linked service e.g.: AzureBlobFS.")
  linkedServiceType?: string;

  @doc("Type of connection via linked service or dataset.")
  type: ConnectionType;

  @doc("A boolean indicating whether linked service is of type inline dataset. Currently only inline datasets are supported.")
  isInlineDataset?: boolean;

  @doc("List of name/value pairs for connection properties.")
  commonDslConnectorProperties?: MapperDslConnectorProperties[];
}

@doc("A object which contains list of tables and connection details for a target connection.")
model MapperTargetConnectionsInfo {
  @doc("List of source tables for a target connection.")
  targetEntities?: MapperTable[];

  @doc("Source connection details.")
  connection?: MapperConnection;

  @doc("List of table mappings.")
  dataMapperMappings?: DataMapperMapping[];

  @doc("List of relationship info among the tables.")
  relationships?: Record<unknown>[];
}

@doc("Source and target table mapping details.")
model DataMapperMapping {
  @doc("Name of the target table")
  targetEntityName?: string;

  @doc("Name of the source table")
  sourceEntityName?: string;

  @doc("The connection reference for the source connection.")
  sourceConnectionReference?: MapperConnectionReference;

  @doc("This holds the user provided attribute mapping information.")
  attributeMappingInfo?: MapperAttributeMappings;

  @doc("This holds the source denormalization information used while joining multiple sources.")
  sourceDenormalizeInfo?: Record<unknown>;
}

@doc("Source or target connection reference details.")
model MapperConnectionReference {
  @doc("Name of the connection")
  connectionName?: string;

  @doc("Type of connection via linked service or dataset.")
  type?: ConnectionType;
}

@doc("Attribute mapping details.")
model MapperAttributeMappings {
  @doc("List of attribute mappings.")
  attributeMappings?: MapperAttributeMapping[];
}

@doc("Source and target column mapping details.")
model MapperAttributeMapping {
  @doc("Name of the target column.")
  name?: string;

  @doc("Type of the CDC attribute mapping. Note: 'Advanced' mapping type is also saved as 'Derived'.")
  type?: MappingType;

  @doc("Name of the function used for 'Aggregate' and 'Derived' (except 'Advanced') type mapping.")
  functionName?: string;

  @doc("Expression used for 'Aggregate' and 'Derived' type mapping.")
  expression?: string;

  @doc("Reference of the source column used in the mapping. It is used for 'Direct' mapping type only.")
  attributeReference?: MapperAttributeReference;

  @doc("List of references for source columns. It is used for 'Derived' and 'Aggregate' type mappings only.")
  attributeReferences?: MapperAttributeReference[];
}

@doc("Attribute reference details for the referred column.")
model MapperAttributeReference {
  @doc("Name of the column.")
  name?: string;

  @doc("Name of the table.")
  entity?: string;

  @doc("The connection reference for the connection.")
  entityConnectionReference?: MapperConnectionReference;
}

@doc("CDC Policy.")
model MapperPolicy {
  @doc("Mode of running the CDC: batch vs continuous.")
  mode?: string;

  @doc("Defines the frequency and interval for running the CDC for batch mode.")
  recurrence?: MapperPolicyRecurrence;
}

@doc("CDC policy recurrence details.")
model MapperPolicyRecurrence {
  @doc("Frequency of period in terms of 'Hour', 'Minute' or 'Second'.")
  frequency?: FrequencyType;

  @doc("Actual interval value as per chosen frequency.")
  interval?: int32;
}

@doc("Azure Data Factory expression definition.")
model Expression {
  @doc("Expression type.")
  type: ExpressionType;

  @doc("Expression value.")
  value: string;
}

@doc("Azure Data Factory secure string definition. The string value will be masked with asterisks '*' during Get or List API calls.")
model SecureString extends SecretBase {
  @doc("Value of secure string.")
  value: string;

  @doc("Type of the secret.")
  type: "SecureString";
}

@doc("The base definition of a secret type.")
@discriminator("type")
model SecretBase {}

@doc("Azure Key Vault secret reference.")
model AzureKeyVaultSecretReference extends SecretBase {
  @doc("The Azure Key Vault linked service reference.")
  store: LinkedServiceReference;

  @doc("The name of the secret in Azure Key Vault. Type: string (or Expression with resultType string).")
  secretName: Record<unknown>;

  @doc("The version of the secret in Azure Key Vault. The default value is the latest version of the secret. Type: string (or Expression with resultType string).")
  secretVersion?: Record<unknown>;

  @doc("Type of the secret.")
  type: "AzureKeyVaultSecret";
}

@doc("A list of integration runtime status.")
model IntegrationRuntimeStatusListResponse {
  @doc("List of integration runtime status.")
  value: IntegrationRuntimeStatusResponse[];

  @doc("The link to the next page of results, if any remaining results exist.")
  nextLink?: string;
}

@doc("Factory's VSTS repo information.")
model FactoryVstsConfiguration extends FactoryRepoConfiguration {
  @doc("VSTS project name.")
  projectName: string;

  @doc("VSTS tenant id.")
  tenantId?: string;

  @doc("Type of repo configuration.")
  type: "FactoryVSTSConfiguration";
}

@doc("Factory's GitHub repo information.")
model FactoryGitHubConfiguration extends FactoryRepoConfiguration {
  @doc("GitHub Enterprise host name. For example: `https://github.mydomain.com`")
  hostName?: string;

  @doc("GitHub bring your own app client id.")
  clientId?: string;

  @doc("GitHub bring your own app client secret information.")
  clientSecret?: GitHubClientSecret;

  @doc("Type of repo configuration.")
  type: "FactoryGitHubConfiguration";
}

@doc("Pipeline reference type.")
model PipelineReference {
  @doc("Pipeline reference type.")
  type: PipelineReferenceType;

  @doc("Reference pipeline name.")
  referenceName: string;

  @doc("Reference name.")
  name?: string;
}

@doc("Pipeline that needs to be triggered with the given parameters.")
model TriggerPipelineReference {
  @doc("Pipeline reference.")
  pipelineReference?: PipelineReference;

  @doc("Pipeline parameters.")
  parameters?: Record<Record<unknown>>;
}

@doc("Dataset reference type.")
model DatasetReference {
  @doc("Dataset reference type.")
  type: DatasetReferenceType;

  @doc("Reference dataset name.")
  referenceName: string;

  @doc("Arguments for dataset.")
  parameters?: Record<Record<unknown>>;
}

@doc("Response body structure for get data factory operation status.")
model GetDataFactoryOperationStatusResponse extends Record<Record<unknown>> {
  @doc("Status of the operation.")
  status?: string;
}

@doc("Data flow reference type.")
model DataFlowReference extends Record<Record<unknown>> {
  @doc("Data flow reference type.")
  type: DataFlowReferenceType;

  @doc("Reference data flow name.")
  referenceName: string;

  @doc("Reference data flow parameters from dataset.")
  datasetParameters?: Record<unknown>;

  @doc("Data flow parameters")
  parameters?: Record<Record<unknown>>;
}

@doc("Managed Virtual Network reference type.")
model ManagedVirtualNetworkReference {
  @doc("Managed Virtual Network reference type.")
  type: ManagedVirtualNetworkReferenceType;

  @doc("Reference ManagedVirtualNetwork name.")
  referenceName: string;
}

@doc("Credential reference type.")
model CredentialReference extends Record<Record<unknown>> {
  @doc("Credential reference type.")
  type: CredentialReferenceType;

  @doc("Reference credential name.")
  referenceName: string;
}

@doc("Credential resource type.")
model CredentialResource extends SubResource {
  @doc("Properties of credentials.")
  properties: Credential;
}

@doc("Mapping data flow.")
model MappingDataFlow extends DataFlow {
  @doc("Mapping data flow type properties.")
  typeProperties?: MappingDataFlowTypeProperties;

  @doc("Type of data flow.")
  type: "MappingDataFlow";
}

@doc("Mapping data flow type properties.")
model MappingDataFlowTypeProperties {
  @doc("List of sources in data flow.")
  sources?: DataFlowSource[];

  @doc("List of sinks in data flow.")
  sinks?: DataFlowSink[];

  @doc("List of transformations in data flow.")
  transformations?: Transformation[];

  @doc("DataFlow script.")
  script?: string;

  @doc("Data flow script lines.")
  scriptLines?: string[];
}

@doc("Transformation for data flow source.")
model DataFlowSource extends Transformation {
  @doc("Schema linked service reference.")
  schemaLinkedService?: LinkedServiceReference;
}

@doc("A data flow transformation.")
model Transformation {
  @doc("Transformation name.")
  name: string;

  @doc("Transformation description.")
  description?: string;

  @doc("Dataset reference.")
  dataset?: DatasetReference;

  @doc("Linked service reference.")
  linkedService?: LinkedServiceReference;

  @doc("Flowlet Reference")
  flowlet?: DataFlowReference;
}

@doc("Transformation for data flow sink.")
model DataFlowSink extends Transformation {
  @doc("Schema linked service reference.")
  schemaLinkedService?: LinkedServiceReference;

  @doc("Rejected data linked service reference.")
  rejectedDataLinkedService?: LinkedServiceReference;
}

@doc("Data flow flowlet")
model Flowlet extends DataFlow {
  @doc("Flowlet type properties.")
  typeProperties?: FlowletTypeProperties;

  @doc("Type of data flow.")
  type: "Flowlet";
}

@doc("Flowlet type properties.")
model FlowletTypeProperties {
  @doc("List of sources in Flowlet.")
  sources?: DataFlowSource[];

  @doc("List of sinks in Flowlet.")
  sinks?: DataFlowSink[];

  @doc("List of transformations in Flowlet.")
  transformations?: Transformation[];

  @doc("Flowlet script.")
  script?: string;

  @doc("Flowlet script lines.")
  scriptLines?: string[];
}

@doc("Power Query data flow.")
model WranglingDataFlow extends DataFlow {
  @doc("PowerQuery data flow type properties.")
  typeProperties?: PowerQueryTypeProperties;

  @doc("Type of data flow.")
  type: "WranglingDataFlow";
}

@doc("Power Query data flow type properties.")
model PowerQueryTypeProperties {
  @doc("List of sources in Power Query.")
  sources?: PowerQuerySource[];

  @doc("Power query mashup script.")
  script?: string;

  @doc("Locale of the Power query mashup document.")
  documentLocale?: string;
}

@doc("Power query source.")
model PowerQuerySource extends DataFlowSource {
  @doc("source script.")
  script?: string;
}

@doc("Power query sink.")
model PowerQuerySink extends DataFlowSink {
  @doc("sink script.")
  script?: string;
}

@doc("Dataset location.")
@discriminator("type")
model DatasetLocation extends Record<Record<unknown>> {
  @doc("Specify the folder path of dataset. Type: string (or Expression with resultType string)")
  folderPath?: Record<unknown>;

  @doc("Specify the file name of dataset. Type: string (or Expression with resultType string).")
  fileName?: Record<unknown>;
}

@doc("The location of azure blob dataset.")
model AzureBlobStorageLocation extends DatasetLocation {
  @doc("Specify the container of azure blob. Type: string (or Expression with resultType string).")
  container?: Record<unknown>;

  @doc("Type of dataset storage location.")
  type: "AzureBlobStorageLocation";
}

@doc("The location of azure blobFS dataset.")
model AzureBlobFSLocation extends DatasetLocation {
  @doc("Specify the fileSystem of azure blobFS. Type: string (or Expression with resultType string).")
  fileSystem?: Record<unknown>;

  @doc("Type of dataset storage location.")
  type: "AzureBlobFSLocation";
}

@doc("The location of azure data lake store dataset.")
model AzureDataLakeStoreLocation extends DatasetLocation {
  @doc("Type of dataset storage location.")
  type: "AzureDataLakeStoreLocation";
}

@doc("The location of amazon S3 dataset.")
model AmazonS3Location extends DatasetLocation {
  @doc("Specify the bucketName of amazon S3. Type: string (or Expression with resultType string)")
  bucketName?: Record<unknown>;

  @doc("Specify the version of amazon S3. Type: string (or Expression with resultType string).")
  version?: Record<unknown>;

  @doc("Type of dataset storage location.")
  type: "AmazonS3Location";
}

@doc("The location of file server dataset.")
model FileServerLocation extends DatasetLocation {
  @doc("Type of dataset storage location.")
  type: "FileServerLocation";
}

@doc("The location of file server dataset.")
model AzureFileStorageLocation extends DatasetLocation {
  @doc("Type of dataset storage location.")
  type: "AzureFileStorageLocation";
}

@doc("The location of Amazon S3 Compatible dataset.")
model AmazonS3CompatibleLocation extends DatasetLocation {
  @doc("Specify the bucketName of Amazon S3 Compatible. Type: string (or Expression with resultType string)")
  bucketName?: Record<unknown>;

  @doc("Specify the version of Amazon S3 Compatible. Type: string (or Expression with resultType string).")
  version?: Record<unknown>;

  @doc("Type of dataset storage location.")
  type: "AmazonS3CompatibleLocation";
}

@doc("The location of Oracle Cloud Storage dataset.")
model OracleCloudStorageLocation extends DatasetLocation {
  @doc("Specify the bucketName of Oracle Cloud Storage. Type: string (or Expression with resultType string)")
  bucketName?: Record<unknown>;

  @doc("Specify the version of Oracle Cloud Storage. Type: string (or Expression with resultType string).")
  version?: Record<unknown>;

  @doc("Type of dataset storage location.")
  type: "OracleCloudStorageLocation";
}

@doc("The location of Google Cloud Storage dataset.")
model GoogleCloudStorageLocation extends DatasetLocation {
  @doc("Specify the bucketName of Google Cloud Storage. Type: string (or Expression with resultType string)")
  bucketName?: Record<unknown>;

  @doc("Specify the version of Google Cloud Storage. Type: string (or Expression with resultType string).")
  version?: Record<unknown>;

  @doc("Type of dataset storage location.")
  type: "GoogleCloudStorageLocation";
}

@doc("The location of ftp server dataset.")
model FtpServerLocation extends DatasetLocation {
  @doc("Type of dataset storage location.")
  type: "FtpServerLocation";
}

@doc("The location of SFTP dataset.")
model SftpLocation extends DatasetLocation {
  @doc("Type of dataset storage location.")
  type: "SftpLocation";
}

@doc("The location of http server.")
model HttpServerLocation extends DatasetLocation {
  @doc("Specify the relativeUrl of http server. Type: string (or Expression with resultType string)")
  relativeUrl?: Record<unknown>;

  @doc("Type of dataset storage location.")
  type: "HttpServerLocation";
}

@doc("The location of HDFS.")
model HdfsLocation extends DatasetLocation {
  @doc("Type of dataset storage location.")
  type: "HdfsLocation";
}

@doc("The location of Microsoft Fabric LakeHouse Files dataset.")
model LakeHouseLocation extends DatasetLocation {
  @doc("Type of dataset storage location.")
  type: "LakeHouseLocation";
}

@doc("Columns that define the structure of the dataset.")
model DatasetDataElement {
  @doc("Name of the column. Type: string (or Expression with resultType string).")
  name?: Record<unknown>;

  @doc("Type of the column. Type: string (or Expression with resultType string).")
  type?: Record<unknown>;
}

@doc("Columns that define the physical type schema of the dataset.")
model DatasetSchemaDataElement extends Record<Record<unknown>> {
  @doc("Name of the schema column. Type: string (or Expression with resultType string).")
  name?: Record<unknown>;

  @doc("Type of the schema column. Type: string (or Expression with resultType string).")
  type?: Record<unknown>;
}

@doc("The format definition of a storage.")
@discriminator("type")
model DatasetStorageFormat extends Record<Record<unknown>> {
  @doc("Serializer. Type: string (or Expression with resultType string).")
  serializer?: Record<unknown>;

  @doc("Deserializer. Type: string (or Expression with resultType string).")
  deserializer?: Record<unknown>;
}

@doc("The data stored in text format.")
model TextFormat extends DatasetStorageFormat {
  @doc("The column delimiter. Type: string (or Expression with resultType string).")
  columnDelimiter?: Record<unknown>;

  @doc("The row delimiter. Type: string (or Expression with resultType string).")
  rowDelimiter?: Record<unknown>;

  @doc("The escape character. Type: string (or Expression with resultType string).")
  escapeChar?: Record<unknown>;

  @doc("The quote character. Type: string (or Expression with resultType string).")
  quoteChar?: Record<unknown>;

  @doc("The null value string. Type: string (or Expression with resultType string).")
  nullValue?: Record<unknown>;

  @doc("The code page name of the preferred encoding. If miss, the default value is ΓÇ£utf-8ΓÇ¥, unless BOM denotes another Unicode encoding. Refer to the ΓÇ£NameΓÇ¥ column of the table in the following link to set supported values: https://msdn.microsoft.com/library/system.text.encoding.aspx. Type: string (or Expression with resultType string).")
  encodingName?: Record<unknown>;

  @doc("Treat empty column values in the text file as null. The default value is true. Type: boolean (or Expression with resultType boolean).")
  treatEmptyAsNull?: Record<unknown>;

  @doc("The number of lines/rows to be skipped when parsing text files. The default value is 0. Type: integer (or Expression with resultType integer).")
  skipLineCount?: Record<unknown>;

  @doc("When used as input, treat the first row of data as headers. When used as output,write the headers into the output as the first row of data. The default value is false. Type: boolean (or Expression with resultType boolean).")
  firstRowAsHeader?: Record<unknown>;

  @doc("Type of dataset storage format.")
  type: "TextFormat";
}

@doc("The data stored in JSON format.")
model JsonFormat extends DatasetStorageFormat {
  @doc("File pattern of JSON. To be more specific, the way of separating a collection of JSON objects. The default value is 'setOfObjects'. It is case-sensitive.")
  filePattern?: Record<unknown>;

  @doc("The character used to separate nesting levels. Default value is '.' (dot). Type: string (or Expression with resultType string).")
  nestingSeparator?: Record<unknown>;

  @doc("The code page name of the preferred encoding. If not provided, the default value is 'utf-8', unless the byte order mark (BOM) denotes another Unicode encoding. The full list of supported values can be found in the 'Name' column of the table of encodings in the following reference: https://go.microsoft.com/fwlink/?linkid=861078. Type: string (or Expression with resultType string).")
  encodingName?: Record<unknown>;

  @doc("The JSONPath of the JSON array element to be flattened. Example: \"$.ArrayPath\". Type: string (or Expression with resultType string).")
  jsonNodeReference?: Record<unknown>;

  @doc("The JSONPath definition for each column mapping with a customized column name to extract data from JSON file. For fields under root object, start with \"$\"; for fields inside the array chosen by jsonNodeReference property, start from the array element. Example: {\"Column1\": \"$.Column1Path\", \"Column2\": \"Column2PathInArray\"}. Type: object (or Expression with resultType object).")
  jsonPathDefinition?: Record<unknown>;

  @doc("Type of dataset storage format.")
  type: "JsonFormat";
}

@doc("The data stored in Avro format.")
model AvroFormat extends DatasetStorageFormat {
  @doc("Type of dataset storage format.")
  type: "AvroFormat";
}

@doc("The data stored in Optimized Row Columnar (ORC) format.")
model OrcFormat extends DatasetStorageFormat {
  @doc("Type of dataset storage format.")
  type: "OrcFormat";
}

@doc("The data stored in Parquet format.")
model ParquetFormat extends DatasetStorageFormat {
  @doc("Type of dataset storage format.")
  type: "ParquetFormat";
}

@doc("The compression method used on a dataset.")
model DatasetCompression extends Record<Record<unknown>> {
  @doc("Type of dataset compression. Type: string (or Expression with resultType string).")
  type: Record<unknown>;

  @doc("The dataset compression level. Type: string (or Expression with resultType string).")
  level?: Record<unknown>;
}

@doc("A single Amazon Simple Storage Service (S3) object or a set of S3 objects.")
model AmazonS3Dataset extends Dataset {
  @doc("Amazon S3 dataset properties.")
  typeProperties: AmazonS3DatasetTypeProperties;

  @doc("Type of dataset.")
  type: "AmazonS3Object";
}

@doc("Amazon S3 dataset properties.")
model AmazonS3DatasetTypeProperties {
  @doc("The name of the Amazon S3 bucket. Type: string (or Expression with resultType string).")
  bucketName: Record<unknown>;

  @doc("The key of the Amazon S3 object. Type: string (or Expression with resultType string).")
  key?: Record<unknown>;

  @doc("The prefix filter for the S3 object name. Type: string (or Expression with resultType string).")
  prefix?: Record<unknown>;

  @doc("The version for the S3 object. Type: string (or Expression with resultType string).")
  version?: Record<unknown>;

  @doc("The start of S3 object's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeStart?: Record<unknown>;

  @doc("The end of S3 object's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeEnd?: Record<unknown>;

  @doc("The format of files.")
  format?: DatasetStorageFormat;

  @doc("The data compression method used for the Amazon S3 object.")
  compression?: DatasetCompression;
}

@doc("Avro dataset.")
model AvroDataset extends Dataset {
  @doc("Avro dataset properties.")
  typeProperties?: AvroDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "Avro";
}

@doc("Avro dataset properties.")
model AvroDatasetTypeProperties {
  @doc("The location of the avro storage.")
  location: DatasetLocation;

  @doc("The data avroCompressionCodec. Type: string (or Expression with resultType string).")
  avroCompressionCodec?: Record<unknown>;

  @maxValue(9)
  @minValue(1)
  avroCompressionLevel?: int32;
}

@doc("Excel dataset.")
model ExcelDataset extends Dataset {
  @doc("Excel dataset properties.")
  typeProperties?: ExcelDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "Excel";
}

@doc("Excel dataset properties.")
model ExcelDatasetTypeProperties {
  @doc("The location of the excel storage.")
  location: DatasetLocation;

  @doc("The sheet name of excel file. Type: string (or Expression with resultType string).")
  sheetName?: Record<unknown>;

  @doc("The sheet index of excel file and default value is 0. Type: integer (or Expression with resultType integer)")
  sheetIndex?: Record<unknown>;

  @doc("The partial data of one sheet. Type: string (or Expression with resultType string).")
  range?: Record<unknown>;

  @doc("When used as input, treat the first row of data as headers. When used as output,write the headers into the output as the first row of data. The default value is false. Type: boolean (or Expression with resultType boolean).")
  firstRowAsHeader?: Record<unknown>;

  @doc("The data compression method used for the json dataset.")
  compression?: DatasetCompression;

  @doc("The null value string. Type: string (or Expression with resultType string).")
  nullValue?: Record<unknown>;
}

@doc("Parquet dataset.")
model ParquetDataset extends Dataset {
  @doc("Parquet dataset properties.")
  typeProperties?: ParquetDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "Parquet";
}

@doc("Parquet dataset properties.")
model ParquetDatasetTypeProperties {
  @doc("The location of the parquet storage.")
  location: DatasetLocation;

  @doc("The data compressionCodec. Type: string (or Expression with resultType string).")
  compressionCodec?: Record<unknown>;
}

@doc("Delimited text dataset.")
model DelimitedTextDataset extends Dataset {
  @doc("Delimited text dataset properties.")
  typeProperties?: DelimitedTextDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "DelimitedText";
}

@doc("DelimitedText dataset properties.")
model DelimitedTextDatasetTypeProperties {
  @doc("The location of the delimited text storage.")
  location: DatasetLocation;

  @doc("The column delimiter. Type: string (or Expression with resultType string).")
  columnDelimiter?: Record<unknown>;

  @doc("The row delimiter. Type: string (or Expression with resultType string).")
  rowDelimiter?: Record<unknown>;

  @doc("The code page name of the preferred encoding. If miss, the default value is UTF-8, unless BOM denotes another Unicode encoding. Refer to the name column of the table in the following link to set supported values: https://msdn.microsoft.com/library/system.text.encoding.aspx. Type: string (or Expression with resultType string).")
  encodingName?: Record<unknown>;

  @doc("The data compressionCodec. Type: string (or Expression with resultType string).")
  compressionCodec?: Record<unknown>;

  @doc("The data compression method used for DelimitedText.")
  compressionLevel?: Record<unknown>;

  @doc("The quote character. Type: string (or Expression with resultType string).")
  quoteChar?: Record<unknown>;

  @doc("The escape character. Type: string (or Expression with resultType string).")
  escapeChar?: Record<unknown>;

  @doc("When used as input, treat the first row of data as headers. When used as output,write the headers into the output as the first row of data. The default value is false. Type: boolean (or Expression with resultType boolean).")
  firstRowAsHeader?: Record<unknown>;

  @doc("The null value string. Type: string (or Expression with resultType string).")
  nullValue?: Record<unknown>;
}

@doc("Json dataset.")
model JsonDataset extends Dataset {
  @doc("Json dataset properties.")
  typeProperties?: JsonDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "Json";
}

@doc("Json dataset properties.")
model JsonDatasetTypeProperties {
  @doc("The location of the json data storage.")
  location: DatasetLocation;

  @doc("The code page name of the preferred encoding. If not specified, the default value is UTF-8, unless BOM denotes another Unicode encoding. Refer to the name column of the table in the following link to set supported values: https://msdn.microsoft.com/library/system.text.encoding.aspx. Type: string (or Expression with resultType string).")
  encodingName?: Record<unknown>;

  @doc("The data compression method used for the json dataset.")
  compression?: DatasetCompression;
}

@doc("Xml dataset.")
model XmlDataset extends Dataset {
  @doc("Xml dataset properties.")
  typeProperties?: XmlDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "Xml";
}

@doc("Xml dataset properties.")
model XmlDatasetTypeProperties {
  @doc("The location of the json data storage.")
  location: DatasetLocation;

  @doc("The code page name of the preferred encoding. If not specified, the default value is UTF-8, unless BOM denotes another Unicode encoding. Refer to the name column of the table in the following link to set supported values: https://msdn.microsoft.com/library/system.text.encoding.aspx. Type: string (or Expression with resultType string).")
  encodingName?: Record<unknown>;

  @doc("The null value string. Type: string (or Expression with resultType string).")
  nullValue?: Record<unknown>;

  @doc("The data compression method used for the json dataset.")
  compression?: DatasetCompression;
}

@doc("ORC dataset.")
model OrcDataset extends Dataset {
  @doc("ORC dataset properties.")
  typeProperties?: OrcDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "Orc";
}

@doc("ORC dataset properties.")
model OrcDatasetTypeProperties {
  @doc("The location of the ORC data storage.")
  location: DatasetLocation;

  @doc("The data orcCompressionCodec. Type: string (or Expression with resultType string).")
  orcCompressionCodec?: Record<unknown>;
}

@doc("Binary dataset.")
model BinaryDataset extends Dataset {
  @doc("Binary dataset properties.")
  typeProperties?: BinaryDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "Binary";
}

@doc("Binary dataset properties.")
model BinaryDatasetTypeProperties {
  @doc("The location of the Binary storage.")
  location: DatasetLocation;

  @doc("The data compression method used for the binary dataset.")
  compression?: DatasetCompression;
}

@doc("The Azure Blob storage.")
model AzureBlobDataset extends Dataset {
  @doc("Azure Blob dataset properties.")
  typeProperties?: AzureBlobDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "AzureBlob";
}

@doc("Azure Blob dataset properties.")
model AzureBlobDatasetTypeProperties {
  @doc("The path of the Azure Blob storage. Type: string (or Expression with resultType string).")
  folderPath?: Record<unknown>;

  @doc("The root of blob path. Type: string (or Expression with resultType string).")
  tableRootLocation?: Record<unknown>;

  @doc("The name of the Azure Blob. Type: string (or Expression with resultType string).")
  fileName?: Record<unknown>;

  @doc("The start of Azure Blob's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeStart?: Record<unknown>;

  @doc("The end of Azure Blob's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeEnd?: Record<unknown>;

  @doc("The format of the Azure Blob storage.")
  format?: DatasetStorageFormat;

  @doc("The data compression method used for the blob storage.")
  compression?: DatasetCompression;
}

@doc("The Azure Table storage dataset.")
model AzureTableDataset extends Dataset {
  @doc("Azure Table dataset properties.")
  typeProperties: AzureTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "AzureTable";
}

@doc("Azure Table dataset properties.")
model AzureTableDatasetTypeProperties {
  @doc("The table name of the Azure Table storage. Type: string (or Expression with resultType string).")
  tableName: Record<unknown>;
}

@doc("The Azure SQL Server database dataset.")
model AzureSqlTableDataset extends Dataset {
  @doc("Azure SQL dataset properties.")
  typeProperties?: AzureSqlTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "AzureSqlTable";
}

@doc("Azure SQL dataset properties.")
model AzureSqlTableDatasetTypeProperties {
  @doc("This property will be retired. Please consider using schema + table properties instead.")
  tableName?: Record<unknown>;

  @doc("The schema name of the Azure SQL database. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;

  @doc("The table name of the Azure SQL database. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;
}

@doc("The Azure SQL Managed Instance dataset.")
model AzureSqlMITableDataset extends Dataset {
  @doc("Azure SQL Managed Instance dataset properties.")
  typeProperties?: AzureSqlMITableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "AzureSqlMITable";
}

@doc("Azure SQL Managed Instance dataset properties.")
model AzureSqlMITableDatasetTypeProperties {
  @doc("This property will be retired. Please consider using schema + table properties instead.")
  tableName?: Record<unknown>;

  @doc("The schema name of the Azure SQL Managed Instance. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;

  @doc("The table name of the Azure SQL Managed Instance dataset. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;
}

@doc("The Azure SQL Data Warehouse dataset.")
model AzureSqlDWTableDataset extends Dataset {
  @doc("Azure SQL Data Warehouse dataset properties.")
  typeProperties?: AzureSqlDWTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "AzureSqlDWTable";
}

@doc("Azure SQL Data Warehouse dataset properties.")
model AzureSqlDWTableDatasetTypeProperties {
  @doc("This property will be retired. Please consider using schema + table properties instead.")
  tableName?: Record<unknown>;

  @doc("The schema name of the Azure SQL Data Warehouse. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;

  @doc("The table name of the Azure SQL Data Warehouse. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;
}

@doc("The Cassandra database dataset.")
model CassandraTableDataset extends Dataset {
  @doc("Cassandra dataset properties.")
  typeProperties?: CassandraTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "CassandraTable";
}

@doc("Cassandra dataset properties.")
model CassandraTableDatasetTypeProperties {
  @doc("The table name of the Cassandra database. Type: string (or Expression with resultType string).")
  tableName?: Record<unknown>;

  @doc("The keyspace of the Cassandra database. Type: string (or Expression with resultType string).")
  keyspace?: Record<unknown>;
}

@doc("The custom dataset.")
model CustomDataset extends Dataset {
  @doc("Custom dataset properties.")
  typeProperties?: Record<unknown>;

  @doc("Type of dataset.")
  type: "CustomDataset";
}

@doc("Microsoft Azure CosmosDB (SQL API) Collection dataset.")
model CosmosDbSqlApiCollectionDataset extends Dataset {
  @doc("CosmosDB (SQL API) Collection dataset properties.")
  typeProperties: CosmosDbSqlApiCollectionDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "CosmosDbSqlApiCollection";
}

@doc("CosmosDB (SQL API) Collection dataset properties.")
model CosmosDbSqlApiCollectionDatasetTypeProperties {
  @doc("CosmosDB (SQL API) collection name. Type: string (or Expression with resultType string).")
  collectionName: Record<unknown>;
}

@doc("Microsoft Azure Document Database Collection dataset.")
model DocumentDbCollectionDataset extends Dataset {
  @doc("DocumentDB Collection dataset properties.")
  typeProperties: DocumentDbCollectionDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "DocumentDbCollection";
}

@doc("DocumentDB Collection dataset properties.")
model DocumentDbCollectionDatasetTypeProperties {
  @doc("Document Database collection name. Type: string (or Expression with resultType string).")
  collectionName: Record<unknown>;
}

@doc("The Dynamics entity dataset.")
model DynamicsEntityDataset extends Dataset {
  @doc("Dynamics entity dataset properties.")
  typeProperties?: DynamicsEntityDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "DynamicsEntity";
}

@doc("Dynamics entity dataset properties.")
model DynamicsEntityDatasetTypeProperties {
  @doc("The logical name of the entity. Type: string (or Expression with resultType string).")
  entityName?: Record<unknown>;
}

@doc("The Dynamics CRM entity dataset.")
model DynamicsCrmEntityDataset extends Dataset {
  @doc("Dynamics CRM entity dataset properties.")
  typeProperties?: DynamicsCrmEntityDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "DynamicsCrmEntity";
}

@doc("Dynamics CRM entity dataset properties.")
model DynamicsCrmEntityDatasetTypeProperties {
  @doc("The logical name of the entity. Type: string (or Expression with resultType string).")
  entityName?: Record<unknown>;
}

@doc("The Common Data Service for Apps entity dataset.")
model CommonDataServiceForAppsEntityDataset extends Dataset {
  @doc("Common Data Service for Apps entity dataset properties.")
  typeProperties?: CommonDataServiceForAppsEntityDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "CommonDataServiceForAppsEntity";
}

@doc("Common Data Service for Apps entity dataset properties.")
model CommonDataServiceForAppsEntityDatasetTypeProperties {
  @doc("The logical name of the entity. Type: string (or Expression with resultType string).")
  entityName?: Record<unknown>;
}

@doc("Azure Data Lake Store dataset.")
model AzureDataLakeStoreDataset extends Dataset {
  @doc("Azure Data Lake Store dataset properties.")
  typeProperties?: AzureDataLakeStoreDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "AzureDataLakeStoreFile";
}

@doc("Azure Data Lake Store dataset properties.")
model AzureDataLakeStoreDatasetTypeProperties {
  @doc("Path to the folder in the Azure Data Lake Store. Type: string (or Expression with resultType string).")
  folderPath?: Record<unknown>;

  @doc("The name of the file in the Azure Data Lake Store. Type: string (or Expression with resultType string).")
  fileName?: Record<unknown>;

  @doc("The format of the Data Lake Store.")
  format?: DatasetStorageFormat;

  @doc("The data compression method used for the item(s) in the Azure Data Lake Store.")
  compression?: DatasetCompression;
}

@doc("The Azure Data Lake Storage Gen2 storage.")
model AzureBlobFSDataset extends Dataset {
  @doc("Azure Data Lake Storage Gen2 dataset properties.")
  typeProperties?: AzureBlobFSDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "AzureBlobFSFile";
}

@doc("Azure Data Lake Storage Gen2 dataset properties.")
model AzureBlobFSDatasetTypeProperties {
  @doc("The path of the Azure Data Lake Storage Gen2 storage. Type: string (or Expression with resultType string).")
  folderPath?: Record<unknown>;

  @doc("The name of the Azure Data Lake Storage Gen2. Type: string (or Expression with resultType string).")
  fileName?: Record<unknown>;

  @doc("The format of the Azure Data Lake Storage Gen2 storage.")
  format?: DatasetStorageFormat;

  @doc("The data compression method used for the blob storage.")
  compression?: DatasetCompression;
}

@doc("The Office365 account.")
model Office365Dataset extends Dataset {
  @doc("Office365 dataset properties.")
  typeProperties: Office365DatasetTypeProperties;

  @doc("Type of dataset.")
  type: "Office365Table";
}

@doc("Office365 dataset properties.")
model Office365DatasetTypeProperties {
  @doc("Name of the dataset to extract from Office 365. Type: string (or Expression with resultType string).")
  tableName: Record<unknown>;

  @doc("A predicate expression that can be used to filter the specific rows to extract from Office 365. Type: string (or Expression with resultType string).")
  predicate?: Record<unknown>;
}

@doc("An on-premises file system dataset.")
model FileShareDataset extends Dataset {
  @doc("On-premises file system dataset properties.")
  typeProperties?: FileShareDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "FileShare";
}

@doc("On-premises file system dataset properties.")
model FileShareDatasetTypeProperties {
  @doc("The path of the on-premises file system. Type: string (or Expression with resultType string).")
  folderPath?: Record<unknown>;

  @doc("The name of the on-premises file system. Type: string (or Expression with resultType string).")
  fileName?: Record<unknown>;

  @doc("The start of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeStart?: Record<unknown>;

  @doc("The end of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeEnd?: Record<unknown>;

  @doc("The format of the files.")
  format?: DatasetStorageFormat;

  @doc("Specify a filter to be used to select a subset of files in the folderPath rather than all files. Type: string (or Expression with resultType string).")
  fileFilter?: Record<unknown>;

  @doc("The data compression method used for the file system.")
  compression?: DatasetCompression;
}

@doc("The MongoDB database dataset.")
model MongoDbCollectionDataset extends Dataset {
  @doc("MongoDB database dataset properties.")
  typeProperties: MongoDbCollectionDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "MongoDbCollection";
}

@doc("MongoDB database dataset properties.")
model MongoDbCollectionDatasetTypeProperties {
  @doc("The table name of the MongoDB database. Type: string (or Expression with resultType string).")
  collectionName: Record<unknown>;
}

@doc("The MongoDB Atlas database dataset.")
model MongoDbAtlasCollectionDataset extends Dataset {
  @doc("MongoDB Atlas database dataset properties.")
  typeProperties: MongoDbAtlasCollectionDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "MongoDbAtlasCollection";
}

@doc("MongoDB Atlas database dataset properties.")
model MongoDbAtlasCollectionDatasetTypeProperties {
  @doc("The collection name of the MongoDB Atlas database. Type: string (or Expression with resultType string).")
  collection: Record<unknown>;
}

@doc("The MongoDB database dataset.")
model MongoDbV2CollectionDataset extends Dataset {
  @doc("MongoDB database dataset properties.")
  typeProperties: MongoDbV2CollectionDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "MongoDbV2Collection";
}

@doc("MongoDB database dataset properties.")
model MongoDbV2CollectionDatasetTypeProperties {
  @doc("The collection name of the MongoDB database. Type: string (or Expression with resultType string).")
  collection: Record<unknown>;
}

@doc("The CosmosDB (MongoDB API) database dataset.")
model CosmosDbMongoDbApiCollectionDataset extends Dataset {
  @doc("CosmosDB (MongoDB API) database dataset properties.")
  typeProperties: CosmosDbMongoDbApiCollectionDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "CosmosDbMongoDbApiCollection";
}

@doc("CosmosDB (MongoDB API) database dataset properties.")
model CosmosDbMongoDbApiCollectionDatasetTypeProperties {
  @doc("The collection name of the CosmosDB (MongoDB API) database. Type: string (or Expression with resultType string).")
  collection: Record<unknown>;
}

@doc("The Open Data Protocol (OData) resource dataset.")
model ODataResourceDataset extends Dataset {
  @doc("OData dataset properties.")
  typeProperties?: ODataResourceDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "ODataResource";
}

@doc("OData dataset properties.")
model ODataResourceDatasetTypeProperties {
  @doc("The OData resource path. Type: string (or Expression with resultType string).")
  path?: Record<unknown>;
}

@doc("The on-premises Oracle database dataset.")
model OracleTableDataset extends Dataset {
  @doc("On-premises Oracle dataset properties.")
  typeProperties?: OracleTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "OracleTable";
}

@doc("On-premises Oracle dataset properties.")
model OracleTableDatasetTypeProperties {
  @doc("This property will be retired. Please consider using schema + table properties instead.")
  tableName?: Record<unknown>;

  @doc("The schema name of the on-premises Oracle database. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;

  @doc("The table name of the on-premises Oracle database. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;
}

@doc("The AmazonRdsForOracle database dataset.")
model AmazonRdsForOracleTableDataset extends Dataset {
  @doc("AmazonRdsForOracle dataset properties.")
  typeProperties?: AmazonRdsForOracleTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "AmazonRdsForOracleTable";
}

@doc("AmazonRdsForOracle dataset properties.")
model AmazonRdsForOracleTableDatasetTypeProperties {
  @doc("The schema name of the AmazonRdsForOracle database. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;

  @doc("The table name of the AmazonRdsForOracle database. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;
}

@doc("The Teradata database dataset.")
model TeradataTableDataset extends Dataset {
  @doc("Teradata dataset properties.")
  typeProperties?: TeradataTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "TeradataTable";
}

@doc("Teradata dataset properties.")
model TeradataTableDatasetTypeProperties {
  @doc("The database name of Teradata. Type: string (or Expression with resultType string).")
  database?: Record<unknown>;

  @doc("The table name of Teradata. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;
}

@doc("The Azure MySQL database dataset.")
model AzureMySqlTableDataset extends Dataset {
  @doc("Azure MySQL database dataset properties.")
  typeProperties: AzureMySqlTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "AzureMySqlTable";
}

@doc("Azure MySQL database dataset properties.")
model AzureMySqlTableDatasetTypeProperties {
  @doc("The Azure MySQL database table name. Type: string (or Expression with resultType string).")
  tableName?: Record<unknown>;

  @doc("The name of Azure MySQL database table. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;
}

@doc("The Amazon Redshift table dataset.")
model AmazonRedshiftTableDataset extends Dataset {
  @doc("Amazon Redshift table dataset properties.")
  typeProperties?: AmazonRedshiftTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "AmazonRedshiftTable";
}

@doc("Amazon Redshift table dataset properties.")
model AmazonRedshiftTableDatasetTypeProperties {
  @doc("This property will be retired. Please consider using schema + table properties instead.")
  tableName?: Record<unknown>;

  @doc("The Amazon Redshift table name. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;

  @doc("The Amazon Redshift schema name. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;
}

@doc("The Db2 table dataset.")
model Db2TableDataset extends Dataset {
  @doc("Db2 table dataset properties.")
  typeProperties?: Db2TableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "Db2Table";
}

@doc("Db2 table dataset properties.")
model Db2TableDatasetTypeProperties {
  @doc("This property will be retired. Please consider using schema + table properties instead.")
  tableName?: Record<unknown>;

  @doc("The Db2 schema name. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;

  @doc("The Db2 table name. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;
}

@doc("The relational table dataset.")
model RelationalTableDataset extends Dataset {
  @doc("Relational table dataset properties.")
  typeProperties?: RelationalTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "RelationalTable";
}

@doc("Relational table dataset properties.")
model RelationalTableDatasetTypeProperties {
  @doc("The relational table name. Type: string (or Expression with resultType string).")
  tableName?: Record<unknown>;
}

@doc("The Informix table dataset.")
model InformixTableDataset extends Dataset {
  @doc("Informix table dataset properties.")
  typeProperties?: InformixTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "InformixTable";
}

@doc("Informix table dataset properties.")
model InformixTableDatasetTypeProperties {
  @doc("The Informix table name. Type: string (or Expression with resultType string).")
  tableName?: Record<unknown>;
}

@doc("The ODBC table dataset.")
model OdbcTableDataset extends Dataset {
  @doc("ODBC table dataset properties.")
  typeProperties?: OdbcTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "OdbcTable";
}

@doc("ODBC table dataset properties.")
model OdbcTableDatasetTypeProperties {
  @doc("The ODBC table name. Type: string (or Expression with resultType string).")
  tableName?: Record<unknown>;
}

@doc("The MySQL table dataset.")
model MySqlTableDataset extends Dataset {
  @doc("MySQL table dataset properties.")
  typeProperties?: MySqlTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "MySqlTable";
}

@doc("MySql table dataset properties.")
model MySqlTableDatasetTypeProperties {
  @doc("The MySQL table name. Type: string (or Expression with resultType string).")
  tableName?: Record<unknown>;
}

@doc("The PostgreSQL table dataset.")
model PostgreSqlTableDataset extends Dataset {
  @doc("PostgreSQL table dataset properties.")
  typeProperties?: PostgreSqlTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "PostgreSqlTable";
}

@doc("PostgreSQL table dataset properties.")
model PostgreSqlTableDatasetTypeProperties {
  @doc("This property will be retired. Please consider using schema + table properties instead.")
  tableName?: Record<unknown>;

  @doc("The PostgreSQL table name. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;

  @doc("The PostgreSQL schema name. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;
}

@doc("The Microsoft Access table dataset.")
model MicrosoftAccessTableDataset extends Dataset {
  @doc("Microsoft Access table dataset properties.")
  typeProperties?: MicrosoftAccessTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "MicrosoftAccessTable";
}

@doc("Microsoft Access table dataset properties.")
model MicrosoftAccessTableDatasetTypeProperties {
  @doc("The Microsoft Access table name. Type: string (or Expression with resultType string).")
  tableName?: Record<unknown>;
}

@doc("The Salesforce object dataset.")
model SalesforceObjectDataset extends Dataset {
  @doc("Salesforce object dataset properties.")
  typeProperties?: SalesforceObjectDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "SalesforceObject";
}

@doc("Salesforce object dataset properties.")
model SalesforceObjectDatasetTypeProperties {
  @doc("The Salesforce object API name. Type: string (or Expression with resultType string).")
  objectApiName?: Record<unknown>;
}

@doc("The Salesforce Service Cloud object dataset.")
model SalesforceServiceCloudObjectDataset extends Dataset {
  @doc("Salesforce Service Cloud object dataset properties.")
  typeProperties?: SalesforceServiceCloudObjectDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "SalesforceServiceCloudObject";
}

@doc("Salesforce Service Cloud object dataset properties.")
model SalesforceServiceCloudObjectDatasetTypeProperties {
  @doc("The Salesforce Service Cloud object API name. Type: string (or Expression with resultType string).")
  objectApiName?: Record<unknown>;
}

@doc("The Sybase table dataset.")
model SybaseTableDataset extends Dataset {
  @doc("Sybase table dataset properties.")
  typeProperties?: SybaseTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "SybaseTable";
}

@doc("Sybase table dataset properties.")
model SybaseTableDatasetTypeProperties {
  @doc("The Sybase table name. Type: string (or Expression with resultType string).")
  tableName?: Record<unknown>;
}

@doc("The SAP BW cube dataset.")
model SapBwCubeDataset extends Dataset {
  @doc("Type of dataset.")
  type: "SapBwCube";
}

@doc("The path of the SAP Cloud for Customer OData entity.")
model SapCloudForCustomerResourceDataset extends Dataset {
  @doc("SAP Cloud For Customer OData resource dataset properties.")
  typeProperties: SapCloudForCustomerResourceDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "SapCloudForCustomerResource";
}

@doc("Sap Cloud For Customer OData resource dataset properties.")
model SapCloudForCustomerResourceDatasetTypeProperties {
  @doc("The path of the SAP Cloud for Customer OData entity. Type: string (or Expression with resultType string).")
  path: Record<unknown>;
}

@doc("The path of the SAP ECC OData entity.")
model SapEccResourceDataset extends Dataset {
  @doc("SAP ECC OData resource dataset properties.")
  typeProperties: SapEccResourceDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "SapEccResource";
}

@doc("Sap ECC OData resource dataset properties.")
model SapEccResourceDatasetTypeProperties {
  @doc("The path of the SAP ECC OData entity. Type: string (or Expression with resultType string).")
  path: Record<unknown>;
}

@doc("SAP HANA Table properties.")
model SapHanaTableDataset extends Dataset {
  @doc("SAP HANA Table properties.")
  typeProperties?: SapHanaTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "SapHanaTable";
}

@doc("SAP HANA Table properties.")
model SapHanaTableDatasetTypeProperties {
  @doc("The schema name of SAP HANA. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;

  @doc("The table name of SAP HANA. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;
}

@doc("Sap Business Warehouse Open Hub Destination Table properties.")
model SapOpenHubTableDataset extends Dataset {
  @doc("Sap Business Warehouse Open Hub Destination Table properties.")
  typeProperties: SapOpenHubTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "SapOpenHubTable";
}

@doc("Sap Business Warehouse Open Hub Destination Table properties.")
model SapOpenHubTableDatasetTypeProperties {
  @doc("The name of the Open Hub Destination with destination type as Database Table. Type: string (or Expression with resultType string).")
  openHubDestinationName: Record<unknown>;

  @doc("Whether to exclude the records of the last request. The default value is true. Type: boolean (or Expression with resultType boolean).")
  excludeLastRequest?: Record<unknown>;

  @doc("The ID of request for delta loading. Once it is set, only data with requestId larger than the value of this property will be retrieved. The default value is 0. Type: integer (or Expression with resultType integer ).")
  baseRequestId?: Record<unknown>;
}

@doc("The on-premises SQL Server dataset.")
model SqlServerTableDataset extends Dataset {
  @doc("On-premises SQL Server dataset properties.")
  typeProperties?: SqlServerTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "SqlServerTable";
}

@doc("On-premises SQL Server dataset properties.")
model SqlServerTableDatasetTypeProperties {
  @doc("This property will be retired. Please consider using schema + table properties instead.")
  tableName?: Record<unknown>;

  @doc("The schema name of the SQL Server dataset. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;

  @doc("The table name of the SQL Server dataset. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;
}

@doc("The Amazon RDS for SQL Server dataset.")
model AmazonRdsForSqlServerTableDataset extends Dataset {
  @doc("The Amazon RDS for SQL Server dataset properties.")
  typeProperties?: AmazonRdsForSqlServerTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "AmazonRdsForSqlServerTable";
}

@doc("The Amazon RDS for SQL Server dataset properties.")
model AmazonRdsForSqlServerTableDatasetTypeProperties {
  @doc("The schema name of the SQL Server dataset. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;

  @doc("The table name of the SQL Server dataset. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;
}

@doc("A Rest service dataset.")
model RestResourceDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: RestResourceDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "RestResource";
}

@doc("Properties specific to this dataset type.")
model RestResourceDatasetTypeProperties {
  @doc("The relative URL to the resource that the RESTful API provides. Type: string (or Expression with resultType string).")
  relativeUrl?: Record<unknown>;

  @doc("The HTTP method used to call the RESTful API. The default is GET. Type: string (or Expression with resultType string).")
  requestMethod?: Record<unknown>;

  @doc("The HTTP request body to the RESTful API if requestMethod is POST. Type: string (or Expression with resultType string).")
  requestBody?: Record<unknown>;

  @doc("The additional HTTP headers in the request to the RESTful API.")
  additionalHeaders?: Record<Record<unknown>>;

  @doc("The pagination rules to compose next page requests.")
  paginationRules?: Record<Record<unknown>>;
}

@doc("SAP Table Resource properties.")
model SapTableResourceDataset extends Dataset {
  @doc("SAP Table Resource properties.")
  typeProperties: SapTableResourceDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "SapTableResource";
}

@doc("SAP Table Resource properties.")
model SapTableResourceDatasetTypeProperties {
  @doc("The name of the SAP Table. Type: string (or Expression with resultType string).")
  tableName: Record<unknown>;
}

@doc("SAP ODP Resource properties.")
model SapOdpResourceDataset extends Dataset {
  @doc("SAP ODP Resource properties.")
  typeProperties: SapOdpResourceDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "SapOdpResource";
}

@doc("SAP ODP Resource properties.")
model SapOdpResourceDatasetTypeProperties {
  @doc("The context of the SAP ODP Object. Type: string (or Expression with resultType string).")
  context: Record<unknown>;

  @doc("The name of the SAP ODP Object. Type: string (or Expression with resultType string).")
  objectName: Record<unknown>;
}

@doc("The dataset points to a HTML table in the web page.")
model WebTableDataset extends Dataset {
  @doc("Web table dataset properties.")
  typeProperties: WebTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "WebTable";
}

@doc("Web table dataset properties.")
model WebTableDatasetTypeProperties {
  @doc("The zero-based index of the table in the web page. Type: integer (or Expression with resultType integer), minimum: 0.")
  index: Record<unknown>;

  @doc("The relative URL to the web page from the linked service URL. Type: string (or Expression with resultType string).")
  path?: Record<unknown>;
}

@doc("The Azure Search Index.")
model AzureSearchIndexDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties: AzureSearchIndexDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "AzureSearchIndex";
}

@doc("Properties specific to this dataset type.")
model AzureSearchIndexDatasetTypeProperties {
  @doc("The name of the Azure Search Index. Type: string (or Expression with resultType string).")
  indexName: Record<unknown>;
}

@doc("A file in an HTTP web server.")
model HttpDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: HttpDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "HttpFile";
}

@doc("Properties specific to this dataset type.")
model HttpDatasetTypeProperties {
  @doc("The relative URL based on the URL in the HttpLinkedService refers to an HTTP file Type: string (or Expression with resultType string).")
  relativeUrl?: Record<unknown>;

  @doc("The HTTP method for the HTTP request. Type: string (or Expression with resultType string).")
  requestMethod?: Record<unknown>;

  @doc("The body for the HTTP request. Type: string (or Expression with resultType string).")
  requestBody?: Record<unknown>;

  @doc("""
The headers for the HTTP Request. e.g. request-header-name-1:request-header-value-1
...
request-header-name-n:request-header-value-n Type: string (or Expression with resultType string).
""")
  additionalHeaders?: Record<unknown>;

  @doc("The format of files.")
  format?: DatasetStorageFormat;

  @doc("The data compression method used on files.")
  compression?: DatasetCompression;
}

@doc("Properties specific to this dataset type.")
model GenericDatasetTypeProperties {
  @doc("The table name. Type: string (or Expression with resultType string).")
  tableName?: Record<unknown>;
}

@doc("Amazon Marketplace Web Service dataset.")
model AmazonMWSObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "AmazonMWSObject";
}

@doc("Azure PostgreSQL dataset.")
model AzurePostgreSqlTableDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: AzurePostgreSqlTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "AzurePostgreSqlTable";
}

@doc("Azure PostgreSQL dataset properties.")
model AzurePostgreSqlTableDatasetTypeProperties {
  @doc("The table name of the Azure PostgreSQL database which includes both schema and table. Type: string (or Expression with resultType string).")
  tableName?: Record<unknown>;

  @doc("The table name of the Azure PostgreSQL database. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;

  @doc("The schema name of the Azure PostgreSQL database. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;
}

@doc("Concur Service dataset.")
model ConcurObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "ConcurObject";
}

@doc("Couchbase server dataset.")
model CouchbaseTableDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "CouchbaseTable";
}

@doc("Drill server dataset.")
model DrillTableDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: DrillDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "DrillTable";
}

@doc("Drill Dataset Properties")
model DrillDatasetTypeProperties {
  @doc("This property will be retired. Please consider using schema + table properties instead.")
  tableName?: Record<unknown>;

  @doc("The table name of the Drill. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;

  @doc("The schema name of the Drill. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;
}

@doc("Eloqua server dataset.")
model EloquaObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "EloquaObject";
}

@doc("Google BigQuery service dataset.")
model GoogleBigQueryObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GoogleBigQueryDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "GoogleBigQueryObject";
}

@doc("Google BigQuery Dataset Properties")
model GoogleBigQueryDatasetTypeProperties {
  @doc("This property will be retired. Please consider using database + table properties instead.")
  tableName?: Record<unknown>;

  @doc("The table name of the Google BigQuery. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;

  @doc("The database name of the Google BigQuery. Type: string (or Expression with resultType string).")
  dataset?: Record<unknown>;
}

@doc("Greenplum Database dataset.")
model GreenplumTableDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GreenplumDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "GreenplumTable";
}

@doc("Greenplum Dataset Properties")
model GreenplumDatasetTypeProperties {
  @doc("This property will be retired. Please consider using schema + table properties instead.")
  tableName?: Record<unknown>;

  @doc("The table name of Greenplum. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;

  @doc("The schema name of Greenplum. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;
}

@doc("HBase server dataset.")
model HBaseObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "HBaseObject";
}

@doc("Hive Server dataset.")
model HiveObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: HiveDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "HiveObject";
}

@doc("Hive Properties")
model HiveDatasetTypeProperties {
  @doc("This property will be retired. Please consider using schema + table properties instead.")
  tableName?: Record<unknown>;

  @doc("The table name of the Hive. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;

  @doc("The schema name of the Hive. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;
}

@doc("Hubspot Service dataset.")
model HubspotObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "HubspotObject";
}

@doc("Impala server dataset.")
model ImpalaObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: ImpalaDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "ImpalaObject";
}

@doc("Impala Dataset Properties")
model ImpalaDatasetTypeProperties {
  @doc("This property will be retired. Please consider using schema + table properties instead.")
  tableName?: Record<unknown>;

  @doc("The table name of the Impala. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;

  @doc("The schema name of the Impala. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;
}

@doc("Jira Service dataset.")
model JiraObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "JiraObject";
}

@doc("Magento server dataset.")
model MagentoObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "MagentoObject";
}

@doc("MariaDB server dataset.")
model MariaDBTableDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "MariaDBTable";
}

@doc("Azure Database for MariaDB dataset.")
model AzureMariaDBTableDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "AzureMariaDBTable";
}

@doc("Marketo server dataset.")
model MarketoObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "MarketoObject";
}

@doc("Paypal Service dataset.")
model PaypalObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "PaypalObject";
}

@doc("Phoenix server dataset.")
model PhoenixObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: PhoenixDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "PhoenixObject";
}

@doc("Phoenix Dataset Properties")
model PhoenixDatasetTypeProperties {
  @doc("This property will be retired. Please consider using schema + table properties instead.")
  tableName?: Record<unknown>;

  @doc("The table name of the Phoenix. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;

  @doc("The schema name of the Phoenix. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;
}

@doc("Presto server dataset.")
model PrestoObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: PrestoDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "PrestoObject";
}

@doc("Presto Dataset Properties")
model PrestoDatasetTypeProperties {
  @doc("This property will be retired. Please consider using schema + table properties instead.")
  tableName?: Record<unknown>;

  @doc("The table name of the Presto. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;

  @doc("The schema name of the Presto. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;
}

@doc("QuickBooks server dataset.")
model QuickBooksObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "QuickBooksObject";
}

@doc("ServiceNow server dataset.")
model ServiceNowObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "ServiceNowObject";
}

@doc("Shopify Service dataset.")
model ShopifyObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "ShopifyObject";
}

@doc("Spark Server dataset.")
model SparkObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: SparkDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "SparkObject";
}

@doc("Spark Properties")
model SparkDatasetTypeProperties {
  @doc("This property will be retired. Please consider using schema + table properties instead.")
  tableName?: Record<unknown>;

  @doc("The table name of the Spark. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;

  @doc("The schema name of the Spark. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;
}

@doc("Square Service dataset.")
model SquareObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "SquareObject";
}

@doc("Xero Service dataset.")
model XeroObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "XeroObject";
}

@doc("Zoho server dataset.")
model ZohoObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "ZohoObject";
}

@doc("Netezza dataset.")
model NetezzaTableDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: NetezzaTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "NetezzaTable";
}

@doc("Netezza dataset properties.")
model NetezzaTableDatasetTypeProperties {
  @doc("This property will be retired. Please consider using schema + table properties instead.")
  tableName?: Record<unknown>;

  @doc("The table name of the Netezza. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;

  @doc("The schema name of the Netezza. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;
}

@doc("Vertica dataset.")
model VerticaTableDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: VerticaDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "VerticaTable";
}

@doc("Vertica Properties")
model VerticaDatasetTypeProperties {
  @doc("This property will be retired. Please consider using schema + table properties instead.")
  tableName?: Record<unknown>;

  @doc("The table name of the Vertica. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;

  @doc("The schema name of the Vertica. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;
}

@doc("Salesforce Marketing Cloud dataset.")
model SalesforceMarketingCloudObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "SalesforceMarketingCloudObject";
}

@doc("Responsys dataset.")
model ResponsysObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "ResponsysObject";
}

@doc("The path of the Dynamics AX OData entity.")
model DynamicsAXResourceDataset extends Dataset {
  @doc("Dynamics AX OData resource dataset properties.")
  typeProperties: DynamicsAXResourceDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "DynamicsAXResource";
}

@doc("Dynamics AX OData resource dataset properties.")
model DynamicsAXResourceDatasetTypeProperties {
  @doc("The path of the Dynamics AX OData entity. Type: string (or Expression with resultType string).")
  path: Record<unknown>;
}

@doc("Oracle Service Cloud dataset.")
model OracleServiceCloudObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "OracleServiceCloudObject";
}

@doc("The Azure Data Explorer (Kusto) dataset.")
model AzureDataExplorerTableDataset extends Dataset {
  @doc("Azure Data Explorer (Kusto) dataset properties.")
  typeProperties: AzureDataExplorerDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "AzureDataExplorerTable";
}

@doc("Azure Data Explorer (Kusto) dataset properties.")
model AzureDataExplorerDatasetTypeProperties {
  @doc("The table name of the Azure Data Explorer database. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;
}

@doc("Google AdWords service dataset.")
model GoogleAdWordsObjectDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: GenericDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "GoogleAdWordsObject";
}

@doc("The snowflake dataset.")
model SnowflakeDataset extends Dataset {
  @doc("Snowflake dataset properties.")
  typeProperties: SnowflakeDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "SnowflakeTable";
}

@doc("Snowflake dataset properties.")
model SnowflakeDatasetTypeProperties {
  @doc("The schema name of the Snowflake database. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;

  @doc("The table name of the Snowflake database. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;
}

@doc("The sharepoint online list resource dataset.")
model SharePointOnlineListResourceDataset extends Dataset {
  @doc("Sharepoint online list dataset properties.")
  typeProperties?: SharePointOnlineListDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "SharePointOnlineListResource";
}

@doc("Sharepoint online list dataset properties.")
model SharePointOnlineListDatasetTypeProperties {
  @doc("The name of the SharePoint Online list. Type: string (or Expression with resultType string).")
  listName?: Record<unknown>;
}

@doc("Azure Databricks Delta Lake dataset.")
model AzureDatabricksDeltaLakeDataset extends Dataset {
  @doc("Properties specific to this dataset type.")
  typeProperties?: AzureDatabricksDeltaLakeDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "AzureDatabricksDeltaLakeDataset";
}

@doc("Azure Databricks Delta Lake Dataset Properties")
model AzureDatabricksDeltaLakeDatasetTypeProperties {
  @doc("The name of delta table. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;

  @doc("The database name of delta table. Type: string (or Expression with resultType string).")
  database?: Record<unknown>;
}

@doc("Microsoft Fabric LakeHouse Table.")
model LakeHouseTableDataset extends Dataset {
  @doc("Microsoft Fabric LakeHouse Table dataset properties.")
  typeProperties?: LakeHouseTableDatasetTypeProperties;

  @doc("Type of dataset.")
  type: "LakeHouseTable";
}

@doc("Microsoft Fabric LakeHouse Table dataset properties.")
model LakeHouseTableDatasetTypeProperties {
  @doc("The name of Microsoft Fabric LakeHouse Table. Type: string (or Expression with resultType string).")
  table?: Record<unknown>;
}

@doc("Managed integration runtime, including managed elastic and managed dedicated integration runtimes.")
model ManagedIntegrationRuntime extends IntegrationRuntime {
  @doc("Integration runtime state, only valid for managed dedicated integration runtime.")
  @visibility("read")
  state?: IntegrationRuntimeState;

  @doc("Managed integration runtime properties.")
  typeProperties: ManagedIntegrationRuntimeTypeProperties;

  @doc("Managed Virtual Network reference.")
  managedVirtualNetwork?: ManagedVirtualNetworkReference;

  @doc("Type of integration runtime.")
  type: "Managed";
}

@doc("Managed integration runtime type properties.")
model ManagedIntegrationRuntimeTypeProperties {
  @doc("The compute resource for managed integration runtime.")
  computeProperties?: IntegrationRuntimeComputeProperties;

  @doc("SSIS properties for managed integration runtime.")
  ssisProperties?: IntegrationRuntimeSsisProperties;

  @doc("The name of virtual network to which Azure-SSIS integration runtime will join")
  customerVirtualNetwork?: IntegrationRuntimeCustomerVirtualNetwork;
}

@doc("The compute resource properties for managed integration runtime.")
model IntegrationRuntimeComputeProperties extends Record<Record<unknown>> {
  @doc("The location for managed integration runtime. The supported regions could be found on https://docs.microsoft.com/en-us/azure/data-factory/data-factory-data-movement-activities")
  location?: string;

  @doc("The node size requirement to managed integration runtime.")
  nodeSize?: string;

  @doc("The required number of nodes for managed integration runtime.")
  @minValue(1)
  numberOfNodes?: int32;

  @doc("Maximum parallel executions count per node for managed integration runtime.")
  @minValue(1)
  maxParallelExecutionsPerNode?: int32;

  @doc("Data flow properties for managed integration runtime.")
  dataFlowProperties?: IntegrationRuntimeDataFlowProperties;

  @doc("VNet properties for managed integration runtime.")
  vNetProperties?: IntegrationRuntimeVNetProperties;

  @doc("CopyComputeScale properties for managed integration runtime.")
  copyComputeScaleProperties?: CopyComputeScaleProperties;

  @doc("PipelineExternalComputeScale properties for managed integration runtime.")
  pipelineExternalComputeScaleProperties?: PipelineExternalComputeScaleProperties;
}

@doc("Data flow properties for managed integration runtime.")
model IntegrationRuntimeDataFlowProperties extends Record<Record<unknown>> {
  @doc("Compute type of the cluster which will execute data flow job.")
  computeType?: DataFlowComputeType;

  @doc("Core count of the cluster which will execute data flow job. Supported values are: 8, 16, 32, 48, 80, 144 and 272.")
  coreCount?: int32;

  @doc("Time to live (in minutes) setting of the cluster which will execute data flow job.")
  timeToLive?: int32;

  @doc("Cluster will not be recycled and it will be used in next data flow activity run until TTL (time to live) is reached if this is set as false. Default is true.")
  cleanup?: boolean;

  @doc("Custom properties are used to tune the data flow runtime performance.")
  customProperties?: IntegrationRuntimeDataFlowPropertiesCustomPropertiesItem[];
}

model IntegrationRuntimeDataFlowPropertiesCustomPropertiesItem {
  @doc("Name of custom property.")
  name?: string;

  @doc("Value of custom property.")
  value?: string;
}

@doc("VNet properties for managed integration runtime.")
model IntegrationRuntimeVNetProperties extends Record<Record<unknown>> {
  @doc("The ID of the VNet that this integration runtime will join.")
  vNetId?: string;

  @doc("The name of the subnet this integration runtime will join.")
  subnet?: string;

  @doc("Resource IDs of the public IP addresses that this integration runtime will use.")
  publicIPs?: string[];

  @doc("The ID of subnet, to which this Azure-SSIS integration runtime will be joined.")
  subnetId?: string;
}

@doc("CopyComputeScale properties for managed integration runtime.")
model CopyComputeScaleProperties extends Record<Record<unknown>> {
  @doc("DIU number setting reserved for copy activity execution. Supported values are multiples of 4 in range 4-256.")
  @minValue(4)
  dataIntegrationUnit?: int32;

  @doc("Time to live (in minutes) setting of integration runtime which will execute copy activity.")
  @minValue(5)
  timeToLive?: int32;
}

@doc("PipelineExternalComputeScale properties for managed integration runtime.")
model PipelineExternalComputeScaleProperties extends Record<Record<unknown>> {
  @doc("Time to live (in minutes) setting of integration runtime which will execute pipeline and external activity.")
  @minValue(5)
  timeToLive?: int32;

  @doc("Number of the pipeline nodes, which should be greater than 0 and less than 11.")
  @maxValue(10)
  @minValue(1)
  numberOfPipelineNodes?: int32;

  @doc("Number of the the external nodes, which should be greater than 0 and less than 11.")
  @maxValue(10)
  @minValue(1)
  numberOfExternalNodes?: int32;
}

@doc("SSIS properties for managed integration runtime.")
model IntegrationRuntimeSsisProperties extends Record<Record<unknown>> {
  @doc("Catalog information for managed dedicated integration runtime.")
  catalogInfo?: IntegrationRuntimeSsisCatalogInfo;

  @doc("License type for bringing your own license scenario.")
  licenseType?: IntegrationRuntimeLicenseType;

  @doc("Custom setup script properties for a managed dedicated integration runtime.")
  customSetupScriptProperties?: IntegrationRuntimeCustomSetupScriptProperties;

  @doc("Data proxy properties for a managed dedicated integration runtime.")
  dataProxyProperties?: IntegrationRuntimeDataProxyProperties;

  @doc("The edition for the SSIS Integration Runtime")
  edition?: IntegrationRuntimeEdition;

  @doc("Custom setup without script properties for a SSIS integration runtime.")
  expressCustomSetupProperties?: CustomSetupBase[];

  @doc("Package stores for the SSIS Integration Runtime.")
  packageStores?: PackageStore[];

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;
}

@doc("Catalog information for managed dedicated integration runtime.")
model IntegrationRuntimeSsisCatalogInfo extends Record<Record<unknown>> {
  @doc("The catalog database server URL.")
  catalogServerEndpoint?: string;

  @doc("The administrator user name of catalog database.")
  @maxLength(128)
  @minLength(1)
  catalogAdminUserName?: string;

  @doc("The password of the administrator user account of the catalog database.")
  catalogAdminPassword?: SecureString;

  @doc("The pricing tier for the catalog database. The valid values could be found in https://azure.microsoft.com/en-us/pricing/details/sql-database/")
  catalogPricingTier?: IntegrationRuntimeSsisCatalogPricingTier;

  @doc("The dual standby pair name of Azure-SSIS Integration Runtimes to support SSISDB failover.")
  dualStandbyPairName?: string;
}

@doc("Custom setup script properties for a managed dedicated integration runtime.")
model IntegrationRuntimeCustomSetupScriptProperties {
  @doc("The URI of the Azure blob container that contains the custom setup script.")
  blobContainerUri?: string;

  @doc("The SAS token of the Azure blob container.")
  sasToken?: SecureString;
}

@doc("Data proxy properties for a managed dedicated integration runtime.")
model IntegrationRuntimeDataProxyProperties {
  @doc("The self-hosted integration runtime reference.")
  connectVia?: EntityReference;

  @doc("The staging linked service reference.")
  stagingLinkedService?: EntityReference;

  @doc("The path to contain the staged data in the Blob storage.")
  path?: string;
}

@doc("The entity reference.")
model EntityReference {
  @doc("The type of this referenced entity.")
  type?: IntegrationRuntimeEntityReferenceType;

  @doc("The name of this referenced entity.")
  referenceName?: string;
}

@doc("The base definition of the custom setup.")
@discriminator("type")
model CustomSetupBase {}

@doc("Package store for the SSIS integration runtime.")
model PackageStore {
  @doc("The name of the package store")
  name: string;

  @doc("The package store linked service reference.")
  packageStoreLinkedService: EntityReference;
}

@doc("The definition and properties of virtual network to which Azure-SSIS integration runtime will join.")
model IntegrationRuntimeCustomerVirtualNetwork {
  @doc("The ID of subnet to which Azure-SSIS integration runtime will join.")
  subnetId?: string;
}

@doc("The custom setup of running cmdkey commands.")
model CmdkeySetup extends CustomSetupBase {
  @doc("Cmdkey command custom setup type properties.")
  typeProperties: CmdkeySetupTypeProperties;

  @doc("The type of custom setup.")
  type: "CmdkeySetup";
}

@doc("Cmdkey command custom setup type properties.")
model CmdkeySetupTypeProperties {
  @doc("The server name of data source access.")
  targetName: Record<unknown>;

  @doc("The user name of data source access.")
  userName: Record<unknown>;

  @doc("The password of data source access.")
  password: SecretBase;
}

@doc("The custom setup of setting environment variable.")
model EnvironmentVariableSetup extends CustomSetupBase {
  @doc("Add environment variable type properties.")
  typeProperties: EnvironmentVariableSetupTypeProperties;

  @doc("The type of custom setup.")
  type: "EnvironmentVariableSetup";
}

@doc("Environment variable custom setup type properties.")
model EnvironmentVariableSetupTypeProperties {
  @doc("The name of the environment variable.")
  variableName: string;

  @doc("The value of the environment variable.")
  variableValue: string;
}

@doc("The custom setup of installing 3rd party components.")
model ComponentSetup extends CustomSetupBase {
  @doc("Install 3rd party component type properties.")
  typeProperties: LicensedComponentSetupTypeProperties;

  @doc("The type of custom setup.")
  type: "ComponentSetup";
}

@doc("Installation of licensed component setup type properties.")
model LicensedComponentSetupTypeProperties {
  @doc("The name of the 3rd party component.")
  componentName: string;

  @doc("The license key to activate the component.")
  licenseKey?: SecretBase;
}

@doc("The express custom setup of installing Azure PowerShell.")
model AzPowerShellSetup extends CustomSetupBase {
  @doc("Install Azure PowerShell type properties.")
  typeProperties: AzPowerShellSetupTypeProperties;

  @doc("The type of custom setup.")
  type: "AzPowerShellSetup";
}

@doc("Installation of Azure PowerShell type properties.")
model AzPowerShellSetupTypeProperties {
  @doc("The required version of Azure PowerShell to install.")
  version: string;
}

@doc("Self-hosted integration runtime.")
model SelfHostedIntegrationRuntime extends IntegrationRuntime {
  @doc("When this property is not null, means this is a linked integration runtime. The property is used to access original integration runtime.")
  typeProperties?: SelfHostedIntegrationRuntimeTypeProperties;

  @doc("Type of integration runtime.")
  type: "SelfHosted";
}

@doc("The self-hosted integration runtime properties.")
model SelfHostedIntegrationRuntimeTypeProperties {
  @doc("The base definition of a linked integration runtime.")
  linkedInfo?: LinkedIntegrationRuntimeType;

  @doc("An alternative option to ensure interactive authoring function when your self-hosted integration runtime is unable to establish a connection with Azure Relay.")
  selfContainedInteractiveAuthoringEnabled?: boolean;
}

@doc("The base definition of a linked integration runtime.")
@discriminator("authorizationType")
model LinkedIntegrationRuntimeType {}

@doc("The key authorization type integration runtime.")
model LinkedIntegrationRuntimeKeyAuthorization
  extends LinkedIntegrationRuntimeType {
  @doc("The key used for authorization.")
  key: SecureString;

  @doc("The authorization type for integration runtime sharing.")
  authorizationType: "Key";
}

@doc("The role based access control (RBAC) authorization type integration runtime.")
model LinkedIntegrationRuntimeRbacAuthorization
  extends LinkedIntegrationRuntimeType {
  @doc("The resource identifier of the integration runtime to be shared.")
  resourceId: string;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;

  @doc("The authorization type for integration runtime sharing.")
  authorizationType: "RBAC";
}

@doc("Managed integration runtime status.")
model ManagedIntegrationRuntimeStatus extends IntegrationRuntimeStatus {
  @doc("Managed integration runtime status type properties.")
  typeProperties: ManagedIntegrationRuntimeStatusTypeProperties;

  @doc("Type of integration runtime.")
  type: "Managed";
}

@doc("Managed integration runtime status type properties.")
model ManagedIntegrationRuntimeStatusTypeProperties {
  @doc("The time at which the integration runtime was created, in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  @doc("The list of nodes for managed integration runtime.")
  @visibility("read")
  nodes?: ManagedIntegrationRuntimeNode[];

  @doc("The errors that occurred on this integration runtime.")
  @visibility("read")
  otherErrors?: ManagedIntegrationRuntimeError[];

  @doc("The last operation result that occurred on this integration runtime.")
  @visibility("read")
  lastOperation?: ManagedIntegrationRuntimeOperationResult;
}

@doc("Properties of integration runtime node.")
model ManagedIntegrationRuntimeNode extends Record<Record<unknown>> {
  @doc("The managed integration runtime node id.")
  @visibility("read")
  nodeId?: string;

  @doc("The managed integration runtime node status.")
  @visibility("read")
  status?: ManagedIntegrationRuntimeNodeStatus;

  @doc("The errors that occurred on this integration runtime node.")
  errors?: ManagedIntegrationRuntimeError[];
}

@doc("Error definition for managed integration runtime.")
model ManagedIntegrationRuntimeError extends Record<Record<unknown>> {
  @doc("The time when the error occurred.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  @doc("Error code.")
  @visibility("read")
  code?: string;

  @doc("Managed integration runtime error parameters.")
  @visibility("read")
  parameters?: string[];

  @doc("Error message.")
  @visibility("read")
  message?: string;
}

@doc("Properties of managed integration runtime operation result.")
model ManagedIntegrationRuntimeOperationResult extends Record<Record<unknown>> {
  @doc("The operation type. Could be start or stop.")
  @visibility("read")
  type?: string;

  @doc("The start time of the operation.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The operation result.")
  @visibility("read")
  result?: string;

  @doc("The error code.")
  @visibility("read")
  errorCode?: string;

  @doc("Managed integration runtime error parameters.")
  @visibility("read")
  parameters?: string[];

  @doc("The activity id for the operation request.")
  @visibility("read")
  activityId?: string;
}

@doc("Self-hosted integration runtime status.")
model SelfHostedIntegrationRuntimeStatus extends IntegrationRuntimeStatus {
  @doc("Self-hosted integration runtime status type properties.")
  typeProperties: SelfHostedIntegrationRuntimeStatusTypeProperties;

  @doc("Type of integration runtime.")
  type: "SelfHosted";
}

@doc("Self-hosted integration runtime status type properties.")
model SelfHostedIntegrationRuntimeStatusTypeProperties {
  @doc("The time at which the integration runtime was created, in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  @doc("The task queue id of the integration runtime.")
  @visibility("read")
  taskQueueId?: string;

  @doc("It is used to set the encryption mode for node-node communication channel (when more than 2 self-hosted integration runtime nodes exist).")
  @visibility("read")
  internalChannelEncryption?: IntegrationRuntimeInternalChannelEncryptionMode;

  @doc("Version of the integration runtime.")
  @visibility("read")
  version?: string;

  @doc("The list of nodes for this integration runtime.")
  nodes?: SelfHostedIntegrationRuntimeNode[];

  @doc("The date at which the integration runtime will be scheduled to update, in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledUpdateDate?: utcDateTime;

  @doc("The time in the date scheduled by service to update the integration runtime, e.g., PT03H is 3 hours")
  @visibility("read")
  updateDelayOffset?: duration;

  @doc("The local time zone offset in hours.")
  @visibility("read")
  localTimeZoneOffset?: duration;

  @doc("Object with additional information about integration runtime capabilities.")
  @visibility("read")
  capabilities?: Record<string>;

  @doc("The URLs for the services used in integration runtime backend service.")
  @visibility("read")
  serviceUrls?: string[];

  @doc("Whether Self-hosted integration runtime auto update has been turned on.")
  @visibility("read")
  autoUpdate?: IntegrationRuntimeAutoUpdate;

  @doc("Status of the integration runtime version.")
  @visibility("read")
  versionStatus?: string;

  @doc("The list of linked integration runtimes that are created to share with this integration runtime.")
  links?: LinkedIntegrationRuntime[];

  @doc("The version that the integration runtime is going to update to.")
  @visibility("read")
  pushedVersion?: string;

  @doc("The latest version on download center.")
  @visibility("read")
  latestVersion?: string;

  @doc("The estimated time when the self-hosted integration runtime will be updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  autoUpdateETA?: utcDateTime;

  @doc("An alternative option to ensure interactive authoring function when your self-hosted integration runtime is unable to establish a connection with Azure Relay.")
  @visibility("read")
  selfContainedInteractiveAuthoringEnabled?: boolean;
}

@doc("The linked integration runtime information.")
model LinkedIntegrationRuntime {
  @doc("The name of the linked integration runtime.")
  @visibility("read")
  name?: string;

  @doc("The subscription ID for which the linked integration runtime belong to.")
  @visibility("read")
  subscriptionId?: string;

  @doc("The name of the data factory for which the linked integration runtime belong to.")
  @visibility("read")
  dataFactoryName?: string;

  @doc("The location of the data factory for which the linked integration runtime belong to.")
  @visibility("read")
  dataFactoryLocation?: string;

  @doc("The creating time of the linked integration runtime.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;
}

@doc("Ssis folder.")
model SsisFolder extends SsisObjectMetadata {
  @doc("Type of metadata.")
  type: "Folder";
}

@doc("Ssis project.")
model SsisProject extends SsisObjectMetadata {
  @doc("Folder id which contains project.")
  folderId?: int32;

  @doc("Project version.")
  version?: int32;

  @doc("Environment reference in project")
  environmentRefs?: SsisEnvironmentReference[];

  @doc("Parameters in project")
  parameters?: SsisParameter[];

  @doc("Type of metadata.")
  type: "Project";
}

@doc("Ssis environment reference.")
model SsisEnvironmentReference {
  @doc("Environment reference id.")
  id?: int32;

  @doc("Environment folder name.")
  environmentFolderName?: string;

  @doc("Environment name.")
  environmentName?: string;

  @doc("Reference type")
  referenceType?: string;
}

@doc("Ssis parameter.")
model SsisParameter {
  @doc("Parameter id.")
  id?: int32;

  @doc("Parameter name.")
  name?: string;

  @doc("Parameter description.")
  description?: string;

  @doc("Parameter type.")
  dataType?: string;

  @doc("Whether parameter is required.")
  required?: boolean;

  @doc("Whether parameter is sensitive.")
  sensitive?: boolean;

  @doc("Design default value of parameter.")
  designDefaultValue?: string;

  @doc("Default value of parameter.")
  defaultValue?: string;

  @doc("Default sensitive value of parameter.")
  sensitiveDefaultValue?: string;

  @doc("Parameter value type.")
  valueType?: string;

  @doc("Parameter value set.")
  valueSet?: boolean;

  @doc("Parameter reference variable.")
  variable?: string;
}

@doc("Ssis Package.")
model SsisPackage extends SsisObjectMetadata {
  @doc("Folder id which contains package.")
  folderId?: int32;

  @doc("Project version which contains package.")
  projectVersion?: int32;

  @doc("Project id which contains package.")
  projectId?: int32;

  @doc("Parameters in package")
  parameters?: SsisParameter[];

  @doc("Type of metadata.")
  type: "Package";
}

@doc("Ssis environment.")
model SsisEnvironment extends SsisObjectMetadata {
  @doc("Folder id which contains environment.")
  folderId?: int32;

  @doc("Variable in environment")
  variables?: SsisVariable[];

  @doc("Type of metadata.")
  type: "Environment";
}

@doc("Ssis variable.")
model SsisVariable {
  @doc("Variable id.")
  id?: int32;

  @doc("Variable name.")
  name?: string;

  @doc("Variable description.")
  description?: string;

  @doc("Variable type.")
  dataType?: string;

  @doc("Whether variable is sensitive.")
  sensitive?: boolean;

  @doc("Variable value.")
  value?: string;

  @doc("Variable sensitive value.")
  sensitiveValue?: string;
}

@doc("The storage account linked service.")
model AzureStorageLinkedService extends LinkedService {
  @doc("Azure Storage linked service properties.")
  typeProperties: AzureStorageLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureStorage";
}

@doc("Azure Storage linked service properties.")
model AzureStorageLinkedServiceTypeProperties {
  @doc("The connection string. It is mutually exclusive with sasUri property. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString?: Record<unknown>;

  @doc("The Azure key vault secret reference of accountKey in connection string.")
  accountKey?: AzureKeyVaultSecretReference;

  @doc("SAS URI of the Azure Storage resource. It is mutually exclusive with connectionString property. Type: string, SecureString or AzureKeyVaultSecretReference.")
  sasUri?: Record<unknown>;

  @doc("The Azure key vault secret reference of sasToken in sas uri.")
  sasToken?: AzureKeyVaultSecretReference;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("The azure blob storage linked service.")
model AzureBlobStorageLinkedService extends LinkedService {
  @doc("Azure Blob Storage linked service properties.")
  typeProperties: AzureBlobStorageLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureBlobStorage";
}

@doc("Azure Blob Storage linked service properties.")
model AzureBlobStorageLinkedServiceTypeProperties {
  @doc("The connection string. It is mutually exclusive with sasUri, serviceEndpoint property. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString?: Record<unknown>;

  @doc("The Azure key vault secret reference of accountKey in connection string.")
  accountKey?: AzureKeyVaultSecretReference;

  @doc("SAS URI of the Azure Blob Storage resource. It is mutually exclusive with connectionString, serviceEndpoint property. Type: string, SecureString or AzureKeyVaultSecretReference.")
  sasUri?: Record<unknown>;

  @doc("The Azure key vault secret reference of sasToken in sas uri.")
  sasToken?: AzureKeyVaultSecretReference;

  @doc("Blob service endpoint of the Azure Blob Storage resource. It is mutually exclusive with connectionString, sasUri property.")
  serviceEndpoint?: Record<unknown>;

  @doc("The ID of the service principal used to authenticate against Azure SQL Data Warehouse. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("The key of the service principal used to authenticate against Azure SQL Data Warehouse.")
  servicePrincipalKey?: SecretBase;

  @doc("The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).")
  tenant?: Record<unknown>;

  @doc("Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).")
  azureCloudType?: Record<unknown>;

  @doc("Specify the kind of your storage account. Allowed values are: Storage (general purpose v1), StorageV2 (general purpose v2), BlobStorage, or BlockBlobStorage. Type: string (or Expression with resultType string).")
  accountKind?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;

  @doc("The type used for authentication. Type: string.")
  authenticationType?: AzureStorageAuthenticationType;

  @doc("Container uri of the Azure Blob Storage resource only support for anonymous access. Type: string (or Expression with resultType string).")
  containerUri?: Record<unknown>;
}

@doc("The azure table storage linked service.")
model AzureTableStorageLinkedService extends LinkedService {
  @doc("Azure Table Storage linked service properties.")
  typeProperties: AzureStorageLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureTableStorage";
}

@doc("Azure SQL Data Warehouse linked service.")
model AzureSqlDWLinkedService extends LinkedService {
  @doc("Azure SQL Data Warehouse linked service properties.")
  typeProperties: AzureSqlDWLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureSqlDW";
}

@doc("Azure SQL Data Warehouse linked service properties.")
model AzureSqlDWLinkedServiceTypeProperties {
  @doc("The connection string. Type: string, SecureString or AzureKeyVaultSecretReference. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString: Record<unknown>;

  @doc("The Azure key vault secret reference of password in connection string.")
  password?: AzureKeyVaultSecretReference;

  @doc("The ID of the service principal used to authenticate against Azure SQL Data Warehouse. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("The key of the service principal used to authenticate against Azure SQL Data Warehouse.")
  servicePrincipalKey?: SecretBase;

  @doc("The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).")
  tenant?: Record<unknown>;

  @doc("Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).")
  azureCloudType?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;
}

@doc("SQL Server linked service.")
model SqlServerLinkedService extends LinkedService {
  @doc("SQL Server linked service properties.")
  typeProperties: SqlServerLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "SqlServer";
}

@doc("SQL Server linked service properties.")
model SqlServerLinkedServiceTypeProperties {
  @doc("The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString: Record<unknown>;

  @doc("The on-premises Windows authentication user name. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("The on-premises Windows authentication password.")
  password?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("Sql always encrypted properties.")
  alwaysEncryptedSettings?: SqlAlwaysEncryptedProperties;
}

@doc("Sql always encrypted properties.")
model SqlAlwaysEncryptedProperties {
  @doc("Sql always encrypted AKV authentication type. Type: string.")
  alwaysEncryptedAkvAuthType: SqlAlwaysEncryptedAkvAuthType;

  @doc("The client ID of the application in Azure Active Directory used for Azure Key Vault authentication. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("The key of the service principal used to authenticate against Azure Key Vault.")
  servicePrincipalKey?: SecretBase;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;
}

@doc("Amazon RDS for SQL Server linked service.")
model AmazonRdsForSqlServerLinkedService extends LinkedService {
  @doc("Amazon RDS for SQL Server linked service properties.")
  typeProperties: AmazonRdsForSqlServerLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AmazonRdsForSqlServer";
}

@doc("Amazon Rds for SQL Server linked service properties.")
model AmazonRdsForSqlServerLinkedServiceTypeProperties {
  @doc("The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString: Record<unknown>;

  @doc("The on-premises Windows authentication user name. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("The on-premises Windows authentication password.")
  password?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("Sql always encrypted properties.")
  alwaysEncryptedSettings?: SqlAlwaysEncryptedProperties;
}

@doc("Microsoft Azure SQL Database linked service.")
model AzureSqlDatabaseLinkedService extends LinkedService {
  @doc("Azure SQL Database linked service properties.")
  typeProperties: AzureSqlDatabaseLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureSqlDatabase";
}

@doc("Azure SQL Database linked service properties.")
model AzureSqlDatabaseLinkedServiceTypeProperties {
  @doc("The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString: Record<unknown>;

  @doc("The Azure key vault secret reference of password in connection string.")
  password?: AzureKeyVaultSecretReference;

  @doc("The ID of the service principal used to authenticate against Azure SQL Database. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("The key of the service principal used to authenticate against Azure SQL Database.")
  servicePrincipalKey?: SecretBase;

  @doc("The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).")
  tenant?: Record<unknown>;

  @doc("Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).")
  azureCloudType?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("Sql always encrypted properties.")
  alwaysEncryptedSettings?: SqlAlwaysEncryptedProperties;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;
}

@doc("Azure SQL Managed Instance linked service.")
model AzureSqlMILinkedService extends LinkedService {
  @doc("Azure SQL Managed Instance linked service properties.")
  typeProperties: AzureSqlMILinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureSqlMI";
}

@doc("Azure SQL Managed Instance linked service properties.")
model AzureSqlMILinkedServiceTypeProperties {
  @doc("The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString: Record<unknown>;

  @doc("The Azure key vault secret reference of password in connection string.")
  password?: AzureKeyVaultSecretReference;

  @doc("The ID of the service principal used to authenticate against Azure SQL Managed Instance. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("The key of the service principal used to authenticate against Azure SQL Managed Instance.")
  servicePrincipalKey?: SecretBase;

  @doc("The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).")
  tenant?: Record<unknown>;

  @doc("Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).")
  azureCloudType?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("Sql always encrypted properties.")
  alwaysEncryptedSettings?: SqlAlwaysEncryptedProperties;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;
}

@doc("Azure Batch linked service.")
model AzureBatchLinkedService extends LinkedService {
  @doc("Azure Batch linked service properties.")
  typeProperties: AzureBatchLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureBatch";
}

@doc("Azure Batch linked service properties.")
model AzureBatchLinkedServiceTypeProperties {
  @doc("The Azure Batch account name. Type: string (or Expression with resultType string).")
  accountName: Record<unknown>;

  @doc("The Azure Batch account access key.")
  accessKey?: SecretBase;

  @doc("The Azure Batch URI. Type: string (or Expression with resultType string).")
  batchUri: Record<unknown>;

  @doc("The Azure Batch pool name. Type: string (or Expression with resultType string).")
  poolName: Record<unknown>;

  @doc("The Azure Storage linked service reference.")
  linkedServiceName: LinkedServiceReference;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;
}

@doc("Azure Key Vault linked service.")
model AzureKeyVaultLinkedService extends LinkedService {
  @doc("Azure Key Vault linked service properties.")
  typeProperties: AzureKeyVaultLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureKeyVault";
}

@doc("Azure Key Vault linked service properties.")
model AzureKeyVaultLinkedServiceTypeProperties {
  @doc("The base URL of the Azure Key Vault. e.g. https://myakv.vault.azure.net Type: string (or Expression with resultType string).")
  baseUrl: Record<unknown>;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;
}

@doc("Microsoft Azure Cosmos Database (CosmosDB) linked service.")
model CosmosDbLinkedService extends LinkedService {
  @doc("CosmosDB linked service properties.")
  typeProperties: CosmosDbLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "CosmosDb";
}

@doc("CosmosDB linked service properties.")
model CosmosDbLinkedServiceTypeProperties {
  @doc("The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString?: Record<unknown>;

  @doc("The endpoint of the Azure CosmosDB account. Type: string (or Expression with resultType string)")
  accountEndpoint?: Record<unknown>;

  @doc("The name of the database. Type: string (or Expression with resultType string)")
  database?: Record<unknown>;

  @doc("The account key of the Azure CosmosDB account. Type: SecureString or AzureKeyVaultSecretReference.")
  accountKey?: SecretBase;

  @doc("The client ID of the application in Azure Active Directory used for Server-To-Server authentication. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string.")
  servicePrincipalCredentialType?: Record<unknown>;

  @doc("The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.")
  servicePrincipalCredential?: SecretBase;

  @doc("The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).")
  tenant?: Record<unknown>;

  @doc("Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).")
  azureCloudType?: Record<unknown>;

  @doc("The connection mode used to access CosmosDB account. Type: string.")
  connectionMode?: CosmosDbConnectionMode;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;
}

@doc("Dynamics linked service.")
model DynamicsLinkedService extends LinkedService {
  @doc("Dynamics linked service properties.")
  typeProperties: DynamicsLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Dynamics";
}

@doc("Dynamics linked service properties.")
model DynamicsLinkedServiceTypeProperties {
  @doc("The deployment type of the Dynamics instance. 'Online' for Dynamics Online and 'OnPremisesWithIfd' for Dynamics on-premises with Ifd. Type: string (or Expression with resultType string).")
  deploymentType: Record<unknown>;

  @doc("The host name of the on-premises Dynamics server. The property is required for on-prem and not allowed for online. Type: string (or Expression with resultType string).")
  hostName?: Record<unknown>;

  @doc("The port of on-premises Dynamics server. The property is required for on-prem and not allowed for online. Default is 443. Type: integer (or Expression with resultType integer), minimum: 0.")
  port?: Record<unknown>;

  @doc("The URL to the Microsoft Dynamics server. The property is required for on-line and not allowed for on-prem. Type: string (or Expression with resultType string).")
  serviceUri?: Record<unknown>;

  @doc("The organization name of the Dynamics instance. The property is required for on-prem and required for online when there are more than one Dynamics instances associated with the user. Type: string (or Expression with resultType string).")
  organizationName?: Record<unknown>;

  @doc("The authentication type to connect to Dynamics server. 'Office365' for online scenario, 'Ifd' for on-premises with Ifd scenario, 'AADServicePrincipal' for Server-To-Server authentication in online scenario. Type: string (or Expression with resultType string).")
  authenticationType: Record<unknown>;

  @doc("User name to access the Dynamics instance. Type: string (or Expression with resultType string).")
  username?: Record<unknown>;

  @doc("Password to access the Dynamics instance.")
  password?: SecretBase;

  @doc("The client ID of the application in Azure Active Directory used for Server-To-Server authentication. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).")
  servicePrincipalCredentialType?: Record<unknown>;

  @doc("The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.")
  servicePrincipalCredential?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;
}

@doc("Dynamics CRM linked service.")
model DynamicsCrmLinkedService extends LinkedService {
  @doc("Dynamics CRM linked service properties.")
  typeProperties: DynamicsCrmLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "DynamicsCrm";
}

@doc("Dynamics CRM linked service properties.")
model DynamicsCrmLinkedServiceTypeProperties {
  @doc("The deployment type of the Dynamics CRM instance. 'Online' for Dynamics CRM Online and 'OnPremisesWithIfd' for Dynamics CRM on-premises with Ifd. Type: string (or Expression with resultType string).")
  deploymentType: Record<unknown>;

  @doc("The host name of the on-premises Dynamics CRM server. The property is required for on-prem and not allowed for online. Type: string (or Expression with resultType string).")
  hostName?: Record<unknown>;

  @doc("The port of on-premises Dynamics CRM server. The property is required for on-prem and not allowed for online. Default is 443. Type: integer (or Expression with resultType integer), minimum: 0.")
  port?: Record<unknown>;

  @doc("The URL to the Microsoft Dynamics CRM server. The property is required for on-line and not allowed for on-prem. Type: string (or Expression with resultType string).")
  serviceUri?: Record<unknown>;

  @doc("The organization name of the Dynamics CRM instance. The property is required for on-prem and required for online when there are more than one Dynamics CRM instances associated with the user. Type: string (or Expression with resultType string).")
  organizationName?: Record<unknown>;

  @doc("The authentication type to connect to Dynamics CRM server. 'Office365' for online scenario, 'Ifd' for on-premises with Ifd scenario, 'AADServicePrincipal' for Server-To-Server authentication in online scenario. Type: string (or Expression with resultType string).")
  authenticationType: Record<unknown>;

  @doc("User name to access the Dynamics CRM instance. Type: string (or Expression with resultType string).")
  username?: Record<unknown>;

  @doc("Password to access the Dynamics CRM instance.")
  password?: SecretBase;

  @doc("The client ID of the application in Azure Active Directory used for Server-To-Server authentication. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).")
  servicePrincipalCredentialType?: Record<unknown>;

  @doc("The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.")
  servicePrincipalCredential?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Common Data Service for Apps linked service.")
model CommonDataServiceForAppsLinkedService extends LinkedService {
  @doc("Common Data Service for Apps linked service properties.")
  typeProperties: CommonDataServiceForAppsLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "CommonDataServiceForApps";
}

@doc("Common Data Service for Apps linked service properties.")
model CommonDataServiceForAppsLinkedServiceTypeProperties {
  @doc("The deployment type of the Common Data Service for Apps instance. 'Online' for Common Data Service for Apps Online and 'OnPremisesWithIfd' for Common Data Service for Apps on-premises with Ifd. Type: string (or Expression with resultType string).")
  deploymentType: Record<unknown>;

  @doc("The host name of the on-premises Common Data Service for Apps server. The property is required for on-prem and not allowed for online. Type: string (or Expression with resultType string).")
  hostName?: Record<unknown>;

  @doc("The port of on-premises Common Data Service for Apps server. The property is required for on-prem and not allowed for online. Default is 443. Type: integer (or Expression with resultType integer), minimum: 0.")
  port?: Record<unknown>;

  @doc("The URL to the Microsoft Common Data Service for Apps server. The property is required for on-line and not allowed for on-prem. Type: string (or Expression with resultType string).")
  serviceUri?: Record<unknown>;

  @doc("The organization name of the Common Data Service for Apps instance. The property is required for on-prem and required for online when there are more than one Common Data Service for Apps instances associated with the user. Type: string (or Expression with resultType string).")
  organizationName?: Record<unknown>;

  @doc("The authentication type to connect to Common Data Service for Apps server. 'Office365' for online scenario, 'Ifd' for on-premises with Ifd scenario. 'AADServicePrincipal' for Server-To-Server authentication in online scenario. Type: string (or Expression with resultType string).")
  authenticationType: Record<unknown>;

  @doc("User name to access the Common Data Service for Apps instance. Type: string (or Expression with resultType string).")
  username?: Record<unknown>;

  @doc("Password to access the Common Data Service for Apps instance.")
  password?: SecretBase;

  @doc("The client ID of the application in Azure Active Directory used for Server-To-Server authentication. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).")
  servicePrincipalCredentialType?: Record<unknown>;

  @doc("The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.")
  servicePrincipalCredential?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("HDInsight linked service.")
model HDInsightLinkedService extends LinkedService {
  @doc("HDInsight linked service properties.")
  typeProperties: HDInsightLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "HDInsight";
}

@doc("HDInsight linked service properties.")
model HDInsightLinkedServiceTypeProperties {
  @doc("HDInsight cluster URI. Type: string (or Expression with resultType string).")
  clusterUri: Record<unknown>;

  @doc("HDInsight cluster user name. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("HDInsight cluster password.")
  password?: SecretBase;

  @doc("The Azure Storage linked service reference.")
  linkedServiceName?: LinkedServiceReference;

  @doc("A reference to the Azure SQL linked service that points to the HCatalog database.")
  hcatalogLinkedServiceName?: LinkedServiceReference;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("Specify if the HDInsight is created with ESP (Enterprise Security Package). Type: Boolean.")
  isEspEnabled?: Record<unknown>;

  @doc("Specify the FileSystem if the main storage for the HDInsight is ADLS Gen2. Type: string (or Expression with resultType string).")
  fileSystem?: Record<unknown>;
}

@doc("File system linked service.")
model FileServerLinkedService extends LinkedService {
  @doc("File system linked service properties.")
  typeProperties: FileServerLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "FileServer";
}

@doc("File system linked service properties.")
model FileServerLinkedServiceTypeProperties {
  @doc("Host name of the server. Type: string (or Expression with resultType string).")
  host: Record<unknown>;

  @doc("User ID to logon the server. Type: string (or Expression with resultType string).")
  userId?: Record<unknown>;

  @doc("Password to logon the server.")
  password?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Azure File Storage linked service.")
model AzureFileStorageLinkedService extends LinkedService {
  @doc("Azure File Storage linked service properties.")
  typeProperties: AzureFileStorageLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureFileStorage";
}

@doc("Azure File Storage linked service properties.")
model AzureFileStorageLinkedServiceTypeProperties {
  @doc("Host name of the server. Type: string (or Expression with resultType string).")
  host?: Record<unknown>;

  @doc("User ID to logon the server. Type: string (or Expression with resultType string).")
  userId?: Record<unknown>;

  @doc("Password to logon the server.")
  password?: SecretBase;

  @doc("The connection string. It is mutually exclusive with sasUri property. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString?: Record<unknown>;

  @doc("The Azure key vault secret reference of accountKey in connection string.")
  accountKey?: AzureKeyVaultSecretReference;

  @doc("SAS URI of the Azure File resource. It is mutually exclusive with connectionString property. Type: string, SecureString or AzureKeyVaultSecretReference.")
  sasUri?: Record<unknown>;

  @doc("The Azure key vault secret reference of sasToken in sas uri.")
  sasToken?: AzureKeyVaultSecretReference;

  @doc("The azure file share name. It is required when auth with accountKey/sasToken. Type: string (or Expression with resultType string).")
  fileShare?: Record<unknown>;

  @doc("The azure file share snapshot version. Type: string (or Expression with resultType string).")
  snapshot?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for Amazon S3 Compatible.")
model AmazonS3CompatibleLinkedService extends LinkedService {
  @doc("Amazon S3 Compatible linked service properties.")
  typeProperties: AmazonS3CompatibleLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AmazonS3Compatible";
}

@doc("Amazon S3 Compatible linked service properties.")
model AmazonS3CompatibleLinkedServiceTypeProperties {
  @doc("The access key identifier of the Amazon S3 Compatible Identity and Access Management (IAM) user. Type: string (or Expression with resultType string).")
  accessKeyId?: Record<unknown>;

  @doc("The secret access key of the Amazon S3 Compatible Identity and Access Management (IAM) user.")
  secretAccessKey?: SecretBase;

  @doc("This value specifies the endpoint to access with the Amazon S3 Compatible Connector. This is an optional property; change it only if you want to try a different service endpoint or want to switch between https and http. Type: string (or Expression with resultType string).")
  serviceUrl?: Record<unknown>;

  @doc("If true, use S3 path-style access instead of virtual hosted-style access. Default value is false. Type: boolean (or Expression with resultType boolean).")
  forcePathStyle?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for Oracle Cloud Storage.")
model OracleCloudStorageLinkedService extends LinkedService {
  @doc("Oracle Cloud Storage linked service properties.")
  typeProperties: OracleCloudStorageLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "OracleCloudStorage";
}

@doc("Oracle Cloud Storage linked service properties.")
model OracleCloudStorageLinkedServiceTypeProperties {
  @doc("The access key identifier of the Oracle Cloud Storage Identity and Access Management (IAM) user. Type: string (or Expression with resultType string).")
  accessKeyId?: Record<unknown>;

  @doc("The secret access key of the Oracle Cloud Storage Identity and Access Management (IAM) user.")
  secretAccessKey?: SecretBase;

  @doc("This value specifies the endpoint to access with the Oracle Cloud Storage Connector. This is an optional property; change it only if you want to try a different service endpoint or want to switch between https and http. Type: string (or Expression with resultType string).")
  serviceUrl?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for Google Cloud Storage.")
model GoogleCloudStorageLinkedService extends LinkedService {
  @doc("Google Cloud Storage linked service properties.")
  typeProperties: GoogleCloudStorageLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "GoogleCloudStorage";
}

@doc("Google Cloud Storage linked service properties.")
model GoogleCloudStorageLinkedServiceTypeProperties {
  @doc("The access key identifier of the Google Cloud Storage Identity and Access Management (IAM) user. Type: string (or Expression with resultType string).")
  accessKeyId?: Record<unknown>;

  @doc("The secret access key of the Google Cloud Storage Identity and Access Management (IAM) user.")
  secretAccessKey?: SecretBase;

  @doc("This value specifies the endpoint to access with the Google Cloud Storage Connector. This is an optional property; change it only if you want to try a different service endpoint or want to switch between https and http. Type: string (or Expression with resultType string).")
  serviceUrl?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Oracle database.")
model OracleLinkedService extends LinkedService {
  @doc("Oracle database linked service properties.")
  typeProperties: OracleLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Oracle";
}

@doc("Oracle database linked service properties.")
model OracleLinkedServiceTypeProperties {
  @doc("The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString: Record<unknown>;

  @doc("The Azure key vault secret reference of password in connection string.")
  password?: AzureKeyVaultSecretReference;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("AmazonRdsForOracle database.")
model AmazonRdsForOracleLinkedService extends LinkedService {
  @doc("AmazonRdsForOracle database linked service properties.")
  typeProperties: AmazonRdsForLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AmazonRdsForOracle";
}

@doc("AmazonRdsForOracle database linked service properties.")
model AmazonRdsForLinkedServiceTypeProperties {
  @doc("The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString: Record<unknown>;

  @doc("The Azure key vault secret reference of password in connection string.")
  password?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Azure MySQL database linked service.")
model AzureMySqlLinkedService extends LinkedService {
  @doc("Azure MySQL database linked service properties.")
  typeProperties: AzureMySqlLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureMySql";
}

@doc("Azure MySQL database linked service properties.")
model AzureMySqlLinkedServiceTypeProperties {
  @doc("The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString: Record<unknown>;

  @doc("The Azure key vault secret reference of password in connection string.")
  password?: AzureKeyVaultSecretReference;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for MySQL data source.")
model MySqlLinkedService extends LinkedService {
  @doc("MySQL linked service properties.")
  typeProperties: MySqlLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "MySql";
}

@doc("MySQL linked service properties.")
model MySqlLinkedServiceTypeProperties {
  @doc("The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString: Record<unknown>;

  @doc("The Azure key vault secret reference of password in connection string.")
  password?: AzureKeyVaultSecretReference;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for PostgreSQL data source.")
model PostgreSqlLinkedService extends LinkedService {
  @doc("PostgreSQL linked service properties.")
  typeProperties: PostgreSqlLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "PostgreSql";
}

@doc("PostgreSQL linked service properties.")
model PostgreSqlLinkedServiceTypeProperties {
  @doc("The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString: Record<unknown>;

  @doc("The Azure key vault secret reference of password in connection string.")
  password?: AzureKeyVaultSecretReference;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for Sybase data source.")
model SybaseLinkedService extends LinkedService {
  @doc("Sybase linked service properties.")
  typeProperties: SybaseLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Sybase";
}

@doc("Sybase linked service properties.")
model SybaseLinkedServiceTypeProperties {
  @doc("Server name for connection. Type: string (or Expression with resultType string).")
  server: Record<unknown>;

  @doc("Database name for connection. Type: string (or Expression with resultType string).")
  database: Record<unknown>;

  @doc("Schema name for connection. Type: string (or Expression with resultType string).")
  schema?: Record<unknown>;

  @doc("AuthenticationType to be used for connection.")
  authenticationType?: SybaseAuthenticationType;

  @doc("Username for authentication. Type: string (or Expression with resultType string).")
  username?: Record<unknown>;

  @doc("Password for authentication.")
  password?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for DB2 data source.")
model Db2LinkedService extends LinkedService {
  @doc("DB2 linked service properties.")
  typeProperties: Db2LinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Db2";
}

@doc("DB2 linked service properties.")
model Db2LinkedServiceTypeProperties {
  @doc("The connection string. It is mutually exclusive with server, database, authenticationType, userName, packageCollection and certificateCommonName property. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString?: Record<unknown>;

  @doc("Server name for connection. It is mutually exclusive with connectionString property. Type: string (or Expression with resultType string).")
  server?: Record<unknown>;

  @doc("Database name for connection. It is mutually exclusive with connectionString property. Type: string (or Expression with resultType string).")
  database?: Record<unknown>;

  @doc("AuthenticationType to be used for connection. It is mutually exclusive with connectionString property.")
  authenticationType?: Db2AuthenticationType;

  @doc("Username for authentication. It is mutually exclusive with connectionString property. Type: string (or Expression with resultType string).")
  username?: Record<unknown>;

  @doc("Password for authentication.")
  password?: SecretBase;

  @doc("Under where packages are created when querying database. It is mutually exclusive with connectionString property. Type: string (or Expression with resultType string).")
  packageCollection?: Record<unknown>;

  @doc("Certificate Common Name when TLS is enabled. It is mutually exclusive with connectionString property. Type: string (or Expression with resultType string).")
  certificateCommonName?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. It is mutually exclusive with connectionString property. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for Teradata data source.")
model TeradataLinkedService extends LinkedService {
  @doc("Teradata linked service properties.")
  typeProperties: TeradataLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Teradata";
}

@doc("Teradata linked service properties.")
model TeradataLinkedServiceTypeProperties {
  @doc("Teradata ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString?: Record<unknown>;

  @doc("Server name for connection. Type: string (or Expression with resultType string).")
  server?: Record<unknown>;

  @doc("AuthenticationType to be used for connection.")
  authenticationType?: TeradataAuthenticationType;

  @doc("Username for authentication. Type: string (or Expression with resultType string).")
  username?: Record<unknown>;

  @doc("Password for authentication.")
  password?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Azure ML Studio Web Service linked service.")
model AzureMLLinkedService extends LinkedService {
  @doc("Azure ML Studio Web Service linked service properties.")
  typeProperties: AzureMLLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureML";
}

@doc("Azure ML Studio Web Service linked service properties.")
model AzureMLLinkedServiceTypeProperties {
  @doc("The Batch Execution REST URL for an Azure ML Studio Web Service endpoint. Type: string (or Expression with resultType string).")
  mlEndpoint: Record<unknown>;

  @doc("The API key for accessing the Azure ML model endpoint.")
  apiKey: SecretBase;

  @doc("The Update Resource REST URL for an Azure ML Studio Web Service endpoint. Type: string (or Expression with resultType string).")
  updateResourceEndpoint?: Record<unknown>;

  @doc("The ID of the service principal used to authenticate against the ARM-based updateResourceEndpoint of an Azure ML Studio web service. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("The key of the service principal used to authenticate against the ARM-based updateResourceEndpoint of an Azure ML Studio web service.")
  servicePrincipalKey?: SecretBase;

  @doc("The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).")
  tenant?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("Type of authentication (Required to specify MSI) used to connect to AzureML. Type: string (or Expression with resultType string).")
  authentication?: Record<unknown>;
}

@doc("Azure ML Service linked service.")
model AzureMLServiceLinkedService extends LinkedService {
  @doc("Azure ML Service linked service properties.")
  typeProperties: AzureMLServiceLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureMLService";
}

@doc("Azure ML Service linked service properties.")
model AzureMLServiceLinkedServiceTypeProperties {
  @doc("Azure ML Service workspace subscription ID. Type: string (or Expression with resultType string).")
  subscriptionId: Record<unknown>;

  @doc("Azure ML Service workspace resource group name. Type: string (or Expression with resultType string).")
  resourceGroupName: Record<unknown>;

  @doc("Azure ML Service workspace name. Type: string (or Expression with resultType string).")
  mlWorkspaceName: Record<unknown>;

  @doc("Type of authentication (Required to specify MSI) used to connect to AzureML. Type: string (or Expression with resultType string).")
  authentication?: Record<unknown>;

  @doc("The ID of the service principal used to authenticate against the endpoint of a published Azure ML Service pipeline. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("The key of the service principal used to authenticate against the endpoint of a published Azure ML Service pipeline.")
  servicePrincipalKey?: SecretBase;

  @doc("The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).")
  tenant?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Open Database Connectivity (ODBC) linked service.")
model OdbcLinkedService extends LinkedService {
  @doc("ODBC linked service properties.")
  typeProperties: OdbcLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Odbc";
}

@doc("ODBC linked service properties.")
model OdbcLinkedServiceTypeProperties {
  @doc("The non-access credential portion of the connection string as well as an optional encrypted credential. Type: string, or SecureString, or AzureKeyVaultSecretReference, or Expression with resultType string.")
  connectionString: Record<unknown>;

  @doc("Type of authentication used to connect to the ODBC data store. Possible values are: Anonymous and Basic. Type: string (or Expression with resultType string).")
  authenticationType?: Record<unknown>;

  @doc("The access credential portion of the connection string specified in driver-specific property-value format.")
  credential?: SecretBase;

  @doc("User name for Basic authentication. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("Password for Basic authentication.")
  password?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Informix linked service.")
model InformixLinkedService extends LinkedService {
  @doc("Informix linked service properties.")
  typeProperties: InformixLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Informix";
}

@doc("Informix linked service properties.")
model InformixLinkedServiceTypeProperties {
  @doc("The non-access credential portion of the connection string as well as an optional encrypted credential. Type: string, or SecureString, or AzureKeyVaultSecretReference, or Expression with resultType string.")
  connectionString: Record<unknown>;

  @doc("Type of authentication used to connect to the Informix as ODBC data store. Possible values are: Anonymous and Basic. Type: string (or Expression with resultType string).")
  authenticationType?: Record<unknown>;

  @doc("The access credential portion of the connection string specified in driver-specific property-value format.")
  credential?: SecretBase;

  @doc("User name for Basic authentication. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("Password for Basic authentication.")
  password?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Microsoft Access linked service.")
model MicrosoftAccessLinkedService extends LinkedService {
  @doc("Microsoft Access linked service properties.")
  typeProperties: MicrosoftAccessLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "MicrosoftAccess";
}

@doc("Microsoft Access linked service properties.")
model MicrosoftAccessLinkedServiceTypeProperties {
  @doc("The non-access credential portion of the connection string as well as an optional encrypted credential. Type: string, or SecureString, or AzureKeyVaultSecretReference, or Expression with resultType string.")
  connectionString: Record<unknown>;

  @doc("Type of authentication used to connect to the Microsoft Access as ODBC data store. Possible values are: Anonymous and Basic. Type: string (or Expression with resultType string).")
  authenticationType?: Record<unknown>;

  @doc("The access credential portion of the connection string specified in driver-specific property-value format.")
  credential?: SecretBase;

  @doc("User name for Basic authentication. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("Password for Basic authentication.")
  password?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Hadoop Distributed File System (HDFS) linked service.")
model HdfsLinkedService extends LinkedService {
  @doc("HDFS linked service properties.")
  typeProperties: HdfsLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Hdfs";
}

@doc("HDFS linked service properties.")
model HdfsLinkedServiceTypeProperties {
  @doc("The URL of the HDFS service endpoint, e.g. http://myhostname:50070/webhdfs/v1 . Type: string (or Expression with resultType string).")
  url: Record<unknown>;

  @doc("Type of authentication used to connect to the HDFS. Possible values are: Anonymous and Windows. Type: string (or Expression with resultType string).")
  authenticationType?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("User name for Windows authentication. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("Password for Windows authentication.")
  password?: SecretBase;
}

@doc("Open Data Protocol (OData) linked service.")
model ODataLinkedService extends LinkedService {
  @doc("OData linked service properties.")
  typeProperties: ODataLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "OData";
}

@doc("OData linked service properties.")
model ODataLinkedServiceTypeProperties {
  @doc("The URL of the OData service endpoint. Type: string (or Expression with resultType string).")
  url: Record<unknown>;

  @doc("Type of authentication used to connect to the OData service.")
  authenticationType?: ODataAuthenticationType;

  @doc("User name of the OData service. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("Password of the OData service.")
  password?: SecretBase;

  @doc("The additional HTTP headers in the request to RESTful API used for authorization. Type: object (or Expression with resultType object).")
  authHeaders?: Record<unknown>;

  @doc("Specify the tenant information (domain name or tenant ID) under which your application resides. Type: string (or Expression with resultType string).")
  tenant?: Record<unknown>;

  @doc("Specify the application id of your application registered in Azure Active Directory. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).")
  azureCloudType?: Record<unknown>;

  @doc("Specify the resource you are requesting authorization to use Directory. Type: string (or Expression with resultType string).")
  aadResourceId?: Record<unknown>;

  @doc("Specify the credential type (key or cert) is used for service principal.")
  aadServicePrincipalCredentialType?: ODataAadServicePrincipalCredentialType;

  @doc("Specify the secret of your application registered in Azure Active Directory. Type: string (or Expression with resultType string).")
  servicePrincipalKey?: SecretBase;

  @doc("Specify the base64 encoded certificate of your application registered in Azure Active Directory. Type: string (or Expression with resultType string).")
  servicePrincipalEmbeddedCert?: SecretBase;

  @doc("Specify the password of your certificate if your certificate has a password and you are using AadServicePrincipal authentication. Type: string (or Expression with resultType string).")
  servicePrincipalEmbeddedCertPassword?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Web linked service.")
model WebLinkedService extends LinkedService {
  @doc("Web linked service properties.")
  typeProperties: WebLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Web";
}

@doc("Base definition of WebLinkedServiceTypeProperties, this typeProperties is polymorphic based on authenticationType, so not flattened in SDK models.")
@discriminator("authenticationType")
model WebLinkedServiceTypeProperties {
  @doc("The URL of the web service endpoint, e.g. https://www.microsoft.com . Type: string (or Expression with resultType string).")
  url: Record<unknown>;
}

@doc("A WebLinkedService that uses anonymous authentication to communicate with an HTTP endpoint.")
model WebAnonymousAuthentication extends WebLinkedServiceTypeProperties {
  @doc("Type of authentication used to connect to the web table source.")
  authenticationType: "Anonymous";
}

@doc("A WebLinkedService that uses basic authentication to communicate with an HTTP endpoint.")
model WebBasicAuthentication extends WebLinkedServiceTypeProperties {
  @doc("User name for Basic authentication. Type: string (or Expression with resultType string).")
  username: Record<unknown>;

  @doc("The password for Basic authentication.")
  password: SecretBase;

  @doc("Type of authentication used to connect to the web table source.")
  authenticationType: "Basic";
}

@doc("A WebLinkedService that uses client certificate based authentication to communicate with an HTTP endpoint. This scheme follows mutual authentication; the server must also provide valid credentials to the client.")
model WebClientCertificateAuthentication
  extends WebLinkedServiceTypeProperties {
  @doc("Base64-encoded contents of a PFX file.")
  pfx: SecretBase;

  @doc("Password for the PFX file.")
  password: SecretBase;

  @doc("Type of authentication used to connect to the web table source.")
  authenticationType: "ClientCertificate";
}

@doc("Linked service for Cassandra data source.")
model CassandraLinkedService extends LinkedService {
  @doc("Cassandra linked service properties.")
  typeProperties: CassandraLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Cassandra";
}

@doc("Cassandra linked service properties.")
model CassandraLinkedServiceTypeProperties {
  @doc("Host name for connection. Type: string (or Expression with resultType string).")
  host: Record<unknown>;

  @doc("AuthenticationType to be used for connection. Type: string (or Expression with resultType string).")
  authenticationType?: Record<unknown>;

  @doc("The port for the connection. Type: integer (or Expression with resultType integer).")
  port?: Record<unknown>;

  @doc("Username for authentication. Type: string (or Expression with resultType string).")
  username?: Record<unknown>;

  @doc("Password for authentication.")
  password?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for MongoDb data source.")
model MongoDbLinkedService extends LinkedService {
  @doc("MongoDB linked service properties.")
  typeProperties: MongoDbLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "MongoDb";
}

@doc("MongoDB linked service properties.")
model MongoDbLinkedServiceTypeProperties {
  @doc("The IP address or server name of the MongoDB server. Type: string (or Expression with resultType string).")
  server: Record<unknown>;

  @doc("The authentication type to be used to connect to the MongoDB database.")
  authenticationType?: MongoDbAuthenticationType;

  @doc("The name of the MongoDB database that you want to access. Type: string (or Expression with resultType string).")
  databaseName: Record<unknown>;

  @doc("Username for authentication. Type: string (or Expression with resultType string).")
  username?: Record<unknown>;

  @doc("Password for authentication.")
  password?: SecretBase;

  @doc("Database to verify the username and password. Type: string (or Expression with resultType string).")
  authSource?: Record<unknown>;

  @doc("The TCP port number that the MongoDB server uses to listen for client connections. The default value is 27017. Type: integer (or Expression with resultType integer), minimum: 0.")
  port?: Record<unknown>;

  @doc("Specifies whether the connections to the server are encrypted using SSL. The default value is false. Type: boolean (or Expression with resultType boolean).")
  enableSsl?: Record<unknown>;

  @doc("Specifies whether to allow self-signed certificates from the server. The default value is false. Type: boolean (or Expression with resultType boolean).")
  allowSelfSignedServerCert?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for MongoDB Atlas data source.")
model MongoDbAtlasLinkedService extends LinkedService {
  @doc("MongoDB Atlas linked service properties.")
  typeProperties: MongoDbAtlasLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "MongoDbAtlas";
}

@doc("MongoDB Atlas linked service properties.")
model MongoDbAtlasLinkedServiceTypeProperties {
  @doc("The MongoDB Atlas connection string. Type: string, SecureString or AzureKeyVaultSecretReference. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString: Record<unknown>;

  @doc("The name of the MongoDB Atlas database that you want to access. Type: string (or Expression with resultType string).")
  database: Record<unknown>;

  @doc("The driver version that you want to choose. Allowed value are v1 and v2. Type: string (or Expression with resultType string).")
  driverVersion?: Record<unknown>;
}

@doc("Linked service for MongoDB data source.")
model MongoDbV2LinkedService extends LinkedService {
  @doc("MongoDB linked service properties.")
  typeProperties: MongoDbV2LinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "MongoDbV2";
}

@doc("MongoDB linked service properties.")
model MongoDbV2LinkedServiceTypeProperties {
  @doc("The MongoDB connection string. Type: string, SecureString or AzureKeyVaultSecretReference. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString: Record<unknown>;

  @doc("The name of the MongoDB database that you want to access. Type: string (or Expression with resultType string).")
  database: Record<unknown>;
}

@doc("Linked service for CosmosDB (MongoDB API) data source.")
model CosmosDbMongoDbApiLinkedService extends LinkedService {
  @doc("CosmosDB (MongoDB API) linked service properties.")
  typeProperties: CosmosDbMongoDbApiLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "CosmosDbMongoDbApi";
}

@doc("CosmosDB (MongoDB API) linked service properties.")
model CosmosDbMongoDbApiLinkedServiceTypeProperties {
  @doc("Whether the CosmosDB (MongoDB API) server version is higher than 3.2. The default value is false. Type: boolean (or Expression with resultType boolean).")
  isServerVersionAbove32?: Record<unknown>;

  @doc("The CosmosDB (MongoDB API) connection string. Type: string, SecureString or AzureKeyVaultSecretReference. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString: Record<unknown>;

  @doc("The name of the CosmosDB (MongoDB API) database that you want to access. Type: string (or Expression with resultType string).")
  database: Record<unknown>;
}

@doc("Azure Data Lake Store linked service.")
model AzureDataLakeStoreLinkedService extends LinkedService {
  @doc("Azure Data Lake Store linked service properties.")
  typeProperties: AzureDataLakeStoreLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureDataLakeStore";
}

@doc("Azure Data Lake Store linked service properties.")
model AzureDataLakeStoreLinkedServiceTypeProperties {
  @doc("Data Lake Store service URI. Type: string (or Expression with resultType string).")
  dataLakeStoreUri: Record<unknown>;

  @doc("The ID of the application used to authenticate against the Azure Data Lake Store account. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("The Key of the application used to authenticate against the Azure Data Lake Store account.")
  servicePrincipalKey?: SecretBase;

  @doc("The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).")
  tenant?: Record<unknown>;

  @doc("Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).")
  azureCloudType?: Record<unknown>;

  @doc("Data Lake Store account name. Type: string (or Expression with resultType string).")
  accountName?: Record<unknown>;

  @doc("Data Lake Store account subscription ID (if different from Data Factory account). Type: string (or Expression with resultType string).")
  subscriptionId?: Record<unknown>;

  @doc("Data Lake Store account resource group name (if different from Data Factory account). Type: string (or Expression with resultType string).")
  resourceGroupName?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;
}

@doc("Azure Data Lake Storage Gen2 linked service.")
model AzureBlobFSLinkedService extends LinkedService {
  @doc("Azure Data Lake Storage Gen2 linked service properties.")
  typeProperties: AzureBlobFSLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureBlobFS";
}

@doc("Azure Data Lake Storage Gen2 linked service properties.")
model AzureBlobFSLinkedServiceTypeProperties {
  @doc("Endpoint for the Azure Data Lake Storage Gen2 service. Type: string (or Expression with resultType string).")
  url?: Record<unknown>;

  @doc("Account key for the Azure Data Lake Storage Gen2 service. Type: string (or Expression with resultType string).")
  accountKey?: Record<unknown>;

  @doc("The ID of the application used to authenticate against the Azure Data Lake Storage Gen2 account. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("The Key of the application used to authenticate against the Azure Data Lake Storage Gen2 account.")
  servicePrincipalKey?: SecretBase;

  @doc("The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).")
  tenant?: Record<unknown>;

  @doc("Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).")
  azureCloudType?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;

  @doc("The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).")
  servicePrincipalCredentialType?: Record<unknown>;

  @doc("The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.")
  servicePrincipalCredential?: SecretBase;

  @doc("SAS URI of the Azure Data Lake Storage Gen2 service. Type: string, SecureString or AzureKeyVaultSecretReference.")
  sasUri?: Record<unknown>;

  @doc("The Azure key vault secret reference of sasToken in sas uri.")
  sasToken?: SecretBase;
}

@doc("Office365 linked service.")
model Office365LinkedService extends LinkedService {
  @doc("Office365 linked service properties.")
  typeProperties: Office365LinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Office365";
}

@doc("Office365 linked service properties.")
model Office365LinkedServiceTypeProperties {
  @doc("Azure tenant ID to which the Office 365 account belongs. Type: string (or Expression with resultType string).")
  office365TenantId: Record<unknown>;

  @doc("Specify the tenant information under which your Azure AD web application resides. Type: string (or Expression with resultType string).")
  servicePrincipalTenantId: Record<unknown>;

  @doc("Specify the application's client ID. Type: string (or Expression with resultType string).")
  servicePrincipalId: Record<unknown>;

  @doc("Specify the application's key.")
  servicePrincipalKey: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for Salesforce.")
model SalesforceLinkedService extends LinkedService {
  @doc("Salesforce linked service properties.")
  typeProperties: SalesforceLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Salesforce";
}

@doc("Salesforce linked service properties.")
model SalesforceLinkedServiceTypeProperties {
  @doc("The URL of Salesforce instance. Default is 'https://login.salesforce.com'. To copy data from sandbox, specify 'https://test.salesforce.com'. To copy data from custom domain, specify, for example, 'https://[domain].my.salesforce.com'. Type: string (or Expression with resultType string).")
  environmentUrl?: Record<unknown>;

  @doc("The username for Basic authentication of the Salesforce instance. Type: string (or Expression with resultType string).")
  username?: Record<unknown>;

  @doc("The password for Basic authentication of the Salesforce instance.")
  password?: SecretBase;

  @doc("The security token is optional to remotely access Salesforce instance.")
  securityToken?: SecretBase;

  @doc("The Salesforce API version used in ADF. Type: string (or Expression with resultType string).")
  apiVersion?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for Salesforce Service Cloud.")
model SalesforceServiceCloudLinkedService extends LinkedService {
  @doc("Salesforce Service Cloud linked service properties.")
  typeProperties: SalesforceServiceCloudLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "SalesforceServiceCloud";
}

@doc("Salesforce Service Cloud linked service properties.")
model SalesforceServiceCloudLinkedServiceTypeProperties {
  @doc("The URL of Salesforce Service Cloud instance. Default is 'https://login.salesforce.com'. To copy data from sandbox, specify 'https://test.salesforce.com'. To copy data from custom domain, specify, for example, 'https://[domain].my.salesforce.com'. Type: string (or Expression with resultType string).")
  environmentUrl?: Record<unknown>;

  @doc("The username for Basic authentication of the Salesforce instance. Type: string (or Expression with resultType string).")
  username?: Record<unknown>;

  @doc("The password for Basic authentication of the Salesforce instance.")
  password?: SecretBase;

  @doc("The security token is optional to remotely access Salesforce instance.")
  securityToken?: SecretBase;

  @doc("The Salesforce API version used in ADF. Type: string (or Expression with resultType string).")
  apiVersion?: Record<unknown>;

  @doc("Extended properties appended to the connection string. Type: string (or Expression with resultType string).")
  extendedProperties?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for SAP Cloud for Customer.")
model SapCloudForCustomerLinkedService extends LinkedService {
  @doc("SAP Cloud for Customer linked service properties.")
  typeProperties: SapCloudForCustomerLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "SapCloudForCustomer";
}

@doc("SAP Cloud for Customer linked service properties.")
model SapCloudForCustomerLinkedServiceTypeProperties {
  @doc("The URL of SAP Cloud for Customer OData API. For example, '[https://[tenantname].crm.ondemand.com/sap/c4c/odata/v1]'. Type: string (or Expression with resultType string).")
  url: Record<unknown>;

  @doc("The username for Basic authentication. Type: string (or Expression with resultType string).")
  username?: Record<unknown>;

  @doc("The password for Basic authentication.")
  password?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Either encryptedCredential or username/password must be provided. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for SAP ERP Central Component(SAP ECC).")
model SapEccLinkedService extends LinkedService {
  @doc("SAP ECC linked service properties.")
  typeProperties: SapEccLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "SapEcc";
}

@doc("SAP ECC linked service properties.")
model SapEccLinkedServiceTypeProperties {
  @doc("The URL of SAP ECC OData API. For example, '[https://hostname:port/sap/opu/odata/sap/servicename/]'. Type: string (or Expression with resultType string).")
  url: Record<unknown>;

  @doc("The username for Basic authentication. Type: string (or Expression with resultType string).")
  username?: Record<unknown>;

  @doc("The password for Basic authentication.")
  password?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Either encryptedCredential or username/password must be provided. Type: string.")
  encryptedCredential?: string;
}

@doc("SAP Business Warehouse Open Hub Destination Linked Service.")
model SapOpenHubLinkedService extends LinkedService {
  @doc("Properties specific to SAP Business Warehouse Open Hub Destination linked service type.")
  typeProperties: SapOpenHubLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "SapOpenHub";
}

@doc("Properties specific to SAP Business Warehouse Open Hub Destination linked service type.")
model SapOpenHubLinkedServiceTypeProperties {
  @doc("Host name of the SAP BW instance where the open hub destination is located. Type: string (or Expression with resultType string).")
  server?: Record<unknown>;

  @doc("System number of the BW system where the open hub destination is located. (Usually a two-digit decimal number represented as a string.) Type: string (or Expression with resultType string).")
  systemNumber?: Record<unknown>;

  @doc("Client ID of the client on the BW system where the open hub destination is located. (Usually a three-digit decimal number represented as a string) Type: string (or Expression with resultType string).")
  clientId?: Record<unknown>;

  @doc("Language of the BW system where the open hub destination is located. The default value is EN. Type: string (or Expression with resultType string).")
  language?: Record<unknown>;

  @doc("SystemID of the SAP system where the table is located. Type: string (or Expression with resultType string).")
  systemId?: Record<unknown>;

  @doc("Username to access the SAP BW server where the open hub destination is located. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("Password to access the SAP BW server where the open hub destination is located.")
  password?: SecretBase;

  @doc("The hostname of the SAP Message Server. Type: string (or Expression with resultType string).")
  messageServer?: Record<unknown>;

  @doc("The service name or port number of the Message Server. Type: string (or Expression with resultType string).")
  messageServerService?: Record<unknown>;

  @doc("The Logon Group for the SAP System. Type: string (or Expression with resultType string).")
  logonGroup?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("SAP ODP Linked Service.")
model SapOdpLinkedService extends LinkedService {
  @doc("Properties specific to SAP ODP linked service type.")
  typeProperties: SapOdpLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "SapOdp";
}

@doc("Properties specific to this linked service type.")
model SapOdpLinkedServiceTypeProperties {
  @doc("Host name of the SAP instance where the table is located. Type: string (or Expression with resultType string).")
  server?: Record<unknown>;

  @doc("System number of the SAP system where the table is located. (Usually a two-digit decimal number represented as a string.) Type: string (or Expression with resultType string).")
  systemNumber?: Record<unknown>;

  @doc("Client ID of the client on the SAP system where the table is located. (Usually a three-digit decimal number represented as a string) Type: string (or Expression with resultType string).")
  clientId?: Record<unknown>;

  @doc("Language of the SAP system where the table is located. The default value is EN. Type: string (or Expression with resultType string).")
  language?: Record<unknown>;

  @doc("SystemID of the SAP system where the table is located. Type: string (or Expression with resultType string).")
  systemId?: Record<unknown>;

  @doc("Username to access the SAP server where the table is located. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("Password to access the SAP server where the table is located.")
  password?: SecretBase;

  @doc("The hostname of the SAP Message Server. Type: string (or Expression with resultType string).")
  messageServer?: Record<unknown>;

  @doc("The service name or port number of the Message Server. Type: string (or Expression with resultType string).")
  messageServerService?: Record<unknown>;

  @doc("SNC activation indicator to access the SAP server where the table is located. Must be either 0 (off) or 1 (on). Type: string (or Expression with resultType string).")
  sncMode?: Record<unknown>;

  @doc("Initiator's SNC name to access the SAP server where the table is located. Type: string (or Expression with resultType string).")
  sncMyName?: Record<unknown>;

  @doc("Communication partner's SNC name to access the SAP server where the table is located. Type: string (or Expression with resultType string).")
  sncPartnerName?: Record<unknown>;

  @doc("External security product's library to access the SAP server where the table is located. Type: string (or Expression with resultType string).")
  sncLibraryPath?: Record<unknown>;

  @doc("SNC Quality of Protection. Allowed value include: 1, 2, 3, 8, 9. Type: string (or Expression with resultType string).")
  sncQop?: Record<unknown>;

  @doc("SNC X509 certificate file path. Type: string (or Expression with resultType string).")
  x509CertificatePath?: Record<unknown>;

  @doc("The Logon Group for the SAP System. Type: string (or Expression with resultType string).")
  logonGroup?: Record<unknown>;

  @doc("The subscriber name. Type: string (or Expression with resultType string).")
  subscriberName?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Rest Service linked service.")
model RestServiceLinkedService extends LinkedService {
  @doc("Rest Service linked service properties.")
  typeProperties: RestServiceLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "RestService";
}

@doc("Rest Service linked service properties.")
model RestServiceLinkedServiceTypeProperties {
  @doc("The base URL of the REST service. Type: string (or Expression with resultType string).")
  url: Record<unknown>;

  @doc("Whether to validate server side SSL certificate when connecting to the endpoint.The default value is true. Type: boolean (or Expression with resultType boolean).")
  enableServerCertificateValidation?: Record<unknown>;

  @doc("Type of authentication used to connect to the REST service.")
  authenticationType: RestServiceAuthenticationType;

  @doc("The user name used in Basic authentication type. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("The password used in Basic authentication type.")
  password?: SecretBase;

  @doc("The additional HTTP headers in the request to RESTful API used for authorization. Type: object (or Expression with resultType object).")
  authHeaders?: Record<unknown>;

  @doc("The application's client ID used in AadServicePrincipal authentication type. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("The application's key used in AadServicePrincipal authentication type.")
  servicePrincipalKey?: SecretBase;

  @doc("The tenant information (domain name or tenant ID) used in AadServicePrincipal authentication type under which your application resides. Type: string (or Expression with resultType string).")
  tenant?: Record<unknown>;

  @doc("Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).")
  azureCloudType?: Record<unknown>;

  @doc("The resource you are requesting authorization to use. Type: string (or Expression with resultType string).")
  aadResourceId?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;

  @doc("The client ID associated with your application. Type: string (or Expression with resultType string).")
  clientId?: Record<unknown>;

  @doc("The client secret associated with your application.")
  clientSecret?: SecretBase;

  @doc("The token endpoint of the authorization server to acquire access token. Type: string (or Expression with resultType string).")
  tokenEndpoint?: Record<unknown>;

  @doc("The target service or resource to which the access will be requested. Type: string (or Expression with resultType string).")
  resource?: Record<unknown>;

  @doc("The scope of the access required. It describes what kind of access will be requested. Type: string (or Expression with resultType string).")
  scope?: Record<unknown>;
}

@doc("Linked service for TeamDesk.")
model TeamDeskLinkedService extends LinkedService {
  @doc("TeamDesk linked service properties.")
  typeProperties: TeamDeskLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "TeamDesk";
}

@doc("TeamDesk linked service type properties.")
model TeamDeskLinkedServiceTypeProperties {
  @doc("The authentication type to use.")
  authenticationType: TeamDeskAuthenticationType;

  @doc("The url to connect TeamDesk source. Type: string (or Expression with resultType string).")
  url: Record<unknown>;

  @doc("The username of the TeamDesk source. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("The password of the TeamDesk source.")
  password?: SecretBase;

  @doc("The api token for the TeamDesk source.")
  apiToken?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for Quickbase.")
model QuickbaseLinkedService extends LinkedService {
  @doc("Quickbase linked service properties.")
  typeProperties: QuickbaseLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Quickbase";
}

@doc("Quickbase linked service type properties.")
model QuickbaseLinkedServiceTypeProperties {
  @doc("The url to connect Quickbase source. Type: string (or Expression with resultType string).")
  url: Record<unknown>;

  @doc("The user token for the Quickbase source.")
  userToken: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for Smartsheet.")
model SmartsheetLinkedService extends LinkedService {
  @doc("Smartsheet linked service properties.")
  typeProperties: SmartsheetLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Smartsheet";
}

@doc("Smartsheet linked service type properties.")
model SmartsheetLinkedServiceTypeProperties {
  @doc("The api token for the Smartsheet source.")
  apiToken: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for Zendesk.")
model ZendeskLinkedService extends LinkedService {
  @doc("Zendesk linked service properties.")
  typeProperties: ZendeskLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Zendesk";
}

@doc("Zendesk linked service type properties.")
model ZendeskLinkedServiceTypeProperties {
  @doc("The authentication type to use.")
  authenticationType: ZendeskAuthenticationType;

  @doc("The url to connect Zendesk source. Type: string (or Expression with resultType string).")
  url: Record<unknown>;

  @doc("The username of the Zendesk source. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("The password of the Zendesk source.")
  password?: SecretBase;

  @doc("The api token for the Zendesk source.")
  apiToken?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for Dataworld.")
model DataworldLinkedService extends LinkedService {
  @doc("Dataworld linked service properties.")
  typeProperties: DataworldLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Dataworld";
}

@doc("Dataworld linked service type properties.")
model DataworldLinkedServiceTypeProperties {
  @doc("The api token for the Dataworld source.")
  apiToken: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for AppFigures.")
model AppFiguresLinkedService extends LinkedService {
  @doc("AppFigures linked service properties.")
  typeProperties: AppFiguresLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AppFigures";
}

@doc("AppFigures linked service type properties.")
model AppFiguresLinkedServiceTypeProperties {
  @doc("The username of the Appfigures source. Type: string (or Expression with resultType string).")
  userName: Record<unknown>;

  @doc("The password of the AppFigures source.")
  password: SecretBase;

  @doc("The client key for the AppFigures source.")
  clientKey: SecretBase;
}

@doc("Linked service for Asana.")
model AsanaLinkedService extends LinkedService {
  @doc("Asana linked service properties.")
  typeProperties: AsanaLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Asana";
}

@doc("Asana linked service type properties.")
model AsanaLinkedServiceTypeProperties {
  @doc("The api token for the Asana source.")
  apiToken: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for Twilio.")
model TwilioLinkedService extends LinkedService {
  @doc("Twilio linked service properties.")
  typeProperties: TwilioLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Twilio";
}

@doc("Twilio linked service type properties.")
model TwilioLinkedServiceTypeProperties {
  @doc("The Account SID of Twilio service. Type: string (or Expression with resultType string).")
  userName: Record<unknown>;

  @doc("The auth token of Twilio service.")
  password: SecretBase;
}

@doc("Linked service for GoogleSheets.")
model GoogleSheetsLinkedService extends LinkedService {
  @doc("GoogleSheets linked service properties.")
  typeProperties: GoogleSheetsLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "GoogleSheets";
}

@doc("GoogleSheets linked service type properties.")
model GoogleSheetsLinkedServiceTypeProperties {
  @doc("The api token for the GoogleSheets source.")
  apiToken: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for Amazon S3.")
model AmazonS3LinkedService extends LinkedService {
  @doc("Amazon S3 linked service properties.")
  typeProperties: AmazonS3LinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AmazonS3";
}

@doc("Amazon S3 linked service properties.")
model AmazonS3LinkedServiceTypeProperties {
  @doc("The authentication type of S3. Allowed value: AccessKey (default) or TemporarySecurityCredentials. Type: string (or Expression with resultType string).")
  authenticationType?: Record<unknown>;

  @doc("The access key identifier of the Amazon S3 Identity and Access Management (IAM) user. Type: string (or Expression with resultType string).")
  accessKeyId?: Record<unknown>;

  @doc("The secret access key of the Amazon S3 Identity and Access Management (IAM) user.")
  secretAccessKey?: SecretBase;

  @doc("This value specifies the endpoint to access with the S3 Connector. This is an optional property; change it only if you want to try a different service endpoint or want to switch between https and http. Type: string (or Expression with resultType string).")
  serviceUrl?: Record<unknown>;

  @doc("The session token for the S3 temporary security credential.")
  sessionToken?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for Amazon Redshift.")
model AmazonRedshiftLinkedService extends LinkedService {
  @doc("Amazon Redshift linked service properties.")
  typeProperties: AmazonRedshiftLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AmazonRedshift";
}

@doc("Amazon Redshift linked service properties.")
model AmazonRedshiftLinkedServiceTypeProperties {
  @doc("The name of the Amazon Redshift server. Type: string (or Expression with resultType string).")
  server: Record<unknown>;

  @doc("The username of the Amazon Redshift source. Type: string (or Expression with resultType string).")
  username?: Record<unknown>;

  @doc("The password of the Amazon Redshift source.")
  password?: SecretBase;

  @doc("The database name of the Amazon Redshift source. Type: string (or Expression with resultType string).")
  database: Record<unknown>;

  @doc("The TCP port number that the Amazon Redshift server uses to listen for client connections. The default value is 5439. Type: integer (or Expression with resultType integer).")
  port?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Custom linked service.")
model CustomDataSourceLinkedService extends LinkedService {
  @doc("Custom linked service properties.")
  typeProperties: Record<unknown>;

  @doc("Type of linked service.")
  type: "CustomDataSource";
}

@doc("Linked service for Windows Azure Search Service.")
model AzureSearchLinkedService extends LinkedService {
  @doc("Windows Azure Search Service linked service properties.")
  typeProperties: AzureSearchLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureSearch";
}

@doc("Windows Azure Search Service linked service properties.")
model AzureSearchLinkedServiceTypeProperties {
  @doc("URL for Azure Search service. Type: string (or Expression with resultType string).")
  url: Record<unknown>;

  @doc("Admin Key for Azure Search service")
  key?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Linked service for an HTTP source.")
model HttpLinkedService extends LinkedService {
  @doc("Properties specific to this linked service type.")
  typeProperties: HttpLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "HttpServer";
}

@doc("Properties specific to this linked service type.")
model HttpLinkedServiceTypeProperties {
  @doc("The base URL of the HTTP endpoint, e.g. https://www.microsoft.com. Type: string (or Expression with resultType string).")
  url: Record<unknown>;

  @doc("The authentication type to be used to connect to the HTTP server.")
  authenticationType?: HttpAuthenticationType;

  @doc("User name for Basic, Digest, or Windows authentication. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("Password for Basic, Digest, Windows, or ClientCertificate with EmbeddedCertData authentication.")
  password?: SecretBase;

  @doc("The additional HTTP headers in the request to RESTful API used for authorization. Type: object (or Expression with resultType object).")
  authHeaders?: Record<unknown>;

  @doc("Base64 encoded certificate data for ClientCertificate authentication. For on-premises copy with ClientCertificate authentication, either CertThumbprint or EmbeddedCertData/Password should be specified. Type: string (or Expression with resultType string).")
  embeddedCertData?: Record<unknown>;

  @doc("Thumbprint of certificate for ClientCertificate authentication. Only valid for on-premises copy. For on-premises copy with ClientCertificate authentication, either CertThumbprint or EmbeddedCertData/Password should be specified. Type: string (or Expression with resultType string).")
  certThumbprint?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("If true, validate the HTTPS server SSL certificate. Default value is true. Type: boolean (or Expression with resultType boolean).")
  enableServerCertificateValidation?: Record<unknown>;
}

@doc("A FTP server Linked Service.")
model FtpServerLinkedService extends LinkedService {
  @doc("Properties specific to this linked service type.")
  typeProperties: FtpServerLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "FtpServer";
}

@doc("Properties specific to this linked service type.")
model FtpServerLinkedServiceTypeProperties {
  @doc("Host name of the FTP server. Type: string (or Expression with resultType string).")
  host: Record<unknown>;

  @doc("The TCP port number that the FTP server uses to listen for client connections. Default value is 21. Type: integer (or Expression with resultType integer), minimum: 0.")
  port?: Record<unknown>;

  @doc("The authentication type to be used to connect to the FTP server.")
  authenticationType?: FtpAuthenticationType;

  @doc("Username to logon the FTP server. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("Password to logon the FTP server.")
  password?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("If true, connect to the FTP server over SSL/TLS channel. Default value is true. Type: boolean (or Expression with resultType boolean).")
  enableSsl?: Record<unknown>;

  @doc("If true, validate the FTP server SSL certificate when connect over SSL/TLS channel. Default value is true. Type: boolean (or Expression with resultType boolean).")
  enableServerCertificateValidation?: Record<unknown>;
}

@doc("A linked service for an SSH File Transfer Protocol (SFTP) server. ")
model SftpServerLinkedService extends LinkedService {
  @doc("Properties specific to this linked service type.")
  typeProperties: SftpServerLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Sftp";
}

@doc("Properties specific to this linked service type.")
model SftpServerLinkedServiceTypeProperties {
  @doc("The SFTP server host name. Type: string (or Expression with resultType string).")
  host: Record<unknown>;

  @doc("The TCP port number that the SFTP server uses to listen for client connections. Default value is 22. Type: integer (or Expression with resultType integer), minimum: 0.")
  port?: Record<unknown>;

  @doc("The authentication type to be used to connect to the FTP server.")
  authenticationType?: SftpAuthenticationType;

  @doc("The username used to log on to the SFTP server. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("Password to logon the SFTP server for Basic authentication.")
  password?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("The SSH private key file path for SshPublicKey authentication. Only valid for on-premises copy. For on-premises copy with SshPublicKey authentication, either PrivateKeyPath or PrivateKeyContent should be specified. SSH private key should be OpenSSH format. Type: string (or Expression with resultType string).")
  privateKeyPath?: Record<unknown>;

  @doc("Base64 encoded SSH private key content for SshPublicKey authentication. For on-premises copy with SshPublicKey authentication, either PrivateKeyPath or PrivateKeyContent should be specified. SSH private key should be OpenSSH format.")
  privateKeyContent?: SecretBase;

  @doc("The password to decrypt the SSH private key if the SSH private key is encrypted.")
  passPhrase?: SecretBase;

  @doc("If true, skip the SSH host key validation. Default value is false. Type: boolean (or Expression with resultType boolean).")
  skipHostKeyValidation?: Record<unknown>;

  @doc("The host key finger-print of the SFTP server. When SkipHostKeyValidation is false, HostKeyFingerprint should be specified. Type: string (or Expression with resultType string).")
  hostKeyFingerprint?: Record<unknown>;
}

@doc("SAP Business Warehouse Linked Service.")
model SapBWLinkedService extends LinkedService {
  @doc("Properties specific to this linked service type.")
  typeProperties: SapBWLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "SapBW";
}

@doc("Properties specific to this linked service type.")
model SapBWLinkedServiceTypeProperties {
  @doc("Host name of the SAP BW instance. Type: string (or Expression with resultType string).")
  server: Record<unknown>;

  @doc("System number of the BW system. (Usually a two-digit decimal number represented as a string.) Type: string (or Expression with resultType string).")
  systemNumber: Record<unknown>;

  @doc("Client ID of the client on the BW system. (Usually a three-digit decimal number represented as a string) Type: string (or Expression with resultType string).")
  clientId: Record<unknown>;

  @doc("Username to access the SAP BW server. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("Password to access the SAP BW server.")
  password?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("SAP HANA Linked Service.")
model SapHanaLinkedService extends LinkedService {
  @doc("Properties specific to this linked service type.")
  typeProperties: SapHanaLinkedServiceProperties;

  @doc("Type of linked service.")
  type: "SapHana";
}

@doc("Properties specific to this linked service type.")
model SapHanaLinkedServiceProperties {
  @doc("SAP HANA ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString?: Record<unknown>;

  @doc("Host name of the SAP HANA server. Type: string (or Expression with resultType string).")
  server?: Record<unknown>;

  @doc("The authentication type to be used to connect to the SAP HANA server.")
  authenticationType?: SapHanaAuthenticationType;

  @doc("Username to access the SAP HANA server. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("Password to access the SAP HANA server.")
  password?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Amazon Marketplace Web Service linked service.")
model AmazonMWSLinkedService extends LinkedService {
  @doc("Amazon Marketplace Web Service linked service properties.")
  typeProperties: AmazonMWSLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AmazonMWS";
}

@doc("Amazon Marketplace Web Service linked service properties.")
model AmazonMWSLinkedServiceTypeProperties {
  @doc("The endpoint of the Amazon MWS server, (i.e. mws.amazonservices.com)")
  endpoint: Record<unknown>;

  @doc("The Amazon Marketplace ID you want to retrieve data from. To retrieve data from multiple Marketplace IDs, separate them with a comma (,). (i.e. A2EUQ1WTGCTBG2)")
  marketplaceID: Record<unknown>;

  @doc("The Amazon seller ID.")
  sellerID: Record<unknown>;

  @doc("The Amazon MWS authentication token.")
  mwsAuthToken?: SecretBase;

  @doc("The access key id used to access data.")
  accessKeyId: Record<unknown>;

  @doc("The secret key used to access data.")
  secretKey?: SecretBase;

  @doc("Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.")
  useEncryptedEndpoints?: Record<unknown>;

  @doc("Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.")
  useHostVerification?: Record<unknown>;

  @doc("Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.")
  usePeerVerification?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Azure PostgreSQL linked service.")
model AzurePostgreSqlLinkedService extends LinkedService {
  @doc("Azure PostgreSQL linked service properties.")
  typeProperties: AzurePostgreSqlLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzurePostgreSql";
}

@doc("Azure PostgreSQL linked service properties.")
model AzurePostgreSqlLinkedServiceTypeProperties {
  @doc("An ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString?: Record<unknown>;

  @doc("The Azure key vault secret reference of password in connection string.")
  password?: AzureKeyVaultSecretReference;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Concur Service linked service.")
model ConcurLinkedService extends LinkedService {
  @doc("Concur Service linked service properties.")
  typeProperties: ConcurLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Concur";
}

@doc("Concur Service linked service properties.")
model ConcurLinkedServiceTypeProperties {
  @doc("Properties used to connect to Concur. It is mutually exclusive with any other properties in the linked service. Type: object.")
  connectionProperties?: Record<unknown>;

  @doc("Application client_id supplied by Concur App Management.")
  clientId: Record<unknown>;

  @doc("The user name that you use to access Concur Service.")
  username: Record<unknown>;

  @doc("The password corresponding to the user name that you provided in the username field.")
  password?: SecretBase;

  @doc("Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.")
  useEncryptedEndpoints?: Record<unknown>;

  @doc("Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.")
  useHostVerification?: Record<unknown>;

  @doc("Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.")
  usePeerVerification?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Couchbase server linked service.")
model CouchbaseLinkedService extends LinkedService {
  @doc("Couchbase server linked service properties.")
  typeProperties: CouchbaseLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Couchbase";
}

@doc("Couchbase server linked service properties.")
model CouchbaseLinkedServiceTypeProperties {
  @doc("An ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString?: Record<unknown>;

  @doc("The Azure key vault secret reference of credString in connection string.")
  credString?: AzureKeyVaultSecretReference;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Drill server linked service.")
model DrillLinkedService extends LinkedService {
  @doc("Drill server linked service properties.")
  typeProperties: DrillLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Drill";
}

@doc("Drill server linked service properties.")
model DrillLinkedServiceTypeProperties {
  @doc("An ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString?: Record<unknown>;

  @doc("The Azure key vault secret reference of password in connection string.")
  pwd?: AzureKeyVaultSecretReference;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Eloqua server linked service.")
model EloquaLinkedService extends LinkedService {
  @doc("Eloqua server linked service properties.")
  typeProperties: EloquaLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Eloqua";
}

@doc("Eloqua server linked service properties.")
model EloquaLinkedServiceTypeProperties {
  @doc("The endpoint of the Eloqua server. (i.e. eloqua.example.com)")
  endpoint: Record<unknown>;

  @doc("The site name and user name of your Eloqua account in the form: sitename/username. (i.e. Eloqua/Alice)")
  username: Record<unknown>;

  @doc("The password corresponding to the user name.")
  password?: SecretBase;

  @doc("Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.")
  useEncryptedEndpoints?: Record<unknown>;

  @doc("Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.")
  useHostVerification?: Record<unknown>;

  @doc("Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.")
  usePeerVerification?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Google BigQuery service linked service.")
model GoogleBigQueryLinkedService extends LinkedService {
  @doc("Google BigQuery service linked service properties.")
  typeProperties: GoogleBigQueryLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "GoogleBigQuery";
}

@doc("Google BigQuery service linked service properties.")
model GoogleBigQueryLinkedServiceTypeProperties {
  @doc("The default BigQuery project to query against. Type: string (or Expression with resultType string).")
  project: Record<unknown>;

  @doc("A comma-separated list of public BigQuery projects to access. Type: string (or Expression with resultType string).")
  additionalProjects?: Record<unknown>;

  @doc("Whether to request access to Google Drive. Allowing Google Drive access enables support for federated tables that combine BigQuery data with data from Google Drive. The default value is false. Type: string (or Expression with resultType string).")
  requestGoogleDriveScope?: Record<unknown>;

  @doc("The OAuth 2.0 authentication mechanism used for authentication. ServiceAuthentication can only be used on self-hosted IR.")
  authenticationType: GoogleBigQueryAuthenticationType;

  @doc("The refresh token obtained from Google for authorizing access to BigQuery for UserAuthentication.")
  refreshToken?: SecretBase;

  @doc("The client id of the google application used to acquire the refresh token. Type: string (or Expression with resultType string).")
  clientId?: Record<unknown>;

  @doc("The client secret of the google application used to acquire the refresh token.")
  clientSecret?: SecretBase;

  @doc("The service account email ID that is used for ServiceAuthentication and can only be used on self-hosted IR. Type: string (or Expression with resultType string).")
  email?: Record<unknown>;

  @doc("The full path to the .p12 key file that is used to authenticate the service account email address and can only be used on self-hosted IR. Type: string (or Expression with resultType string).")
  keyFilePath?: Record<unknown>;

  @doc("The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR. Type: string (or Expression with resultType string).")
  trustedCertPath?: Record<unknown>;

  @doc("Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false.Type: boolean (or Expression with resultType boolean).")
  useSystemTrustStore?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Greenplum Database linked service.")
model GreenplumLinkedService extends LinkedService {
  @doc("Greenplum Database linked service properties.")
  typeProperties: GreenplumLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Greenplum";
}

@doc("Greenplum Database linked service properties.")
model GreenplumLinkedServiceTypeProperties {
  @doc("An ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString?: Record<unknown>;

  @doc("The Azure key vault secret reference of password in connection string.")
  pwd?: AzureKeyVaultSecretReference;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("HBase server linked service.")
model HBaseLinkedService extends LinkedService {
  @doc("HBase server linked service properties.")
  typeProperties: HBaseLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "HBase";
}

@doc("HBase server linked service properties.")
model HBaseLinkedServiceTypeProperties {
  @doc("The IP address or host name of the HBase server. (i.e. 192.168.222.160)")
  host: Record<unknown>;

  @doc("The TCP port that the HBase instance uses to listen for client connections. The default value is 9090.")
  port?: Record<unknown>;

  @doc("The partial URL corresponding to the HBase server. (i.e. /gateway/sandbox/hbase/version)")
  httpPath?: Record<unknown>;

  @doc("The authentication mechanism to use to connect to the HBase server.")
  authenticationType: HBaseAuthenticationType;

  @doc("The user name used to connect to the HBase instance.")
  username?: Record<unknown>;

  @doc("The password corresponding to the user name.")
  password?: SecretBase;

  @doc("Specifies whether the connections to the server are encrypted using SSL. The default value is false.")
  enableSsl?: Record<unknown>;

  @doc("The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR.")
  trustedCertPath?: Record<unknown>;

  @doc("Specifies whether to require a CA-issued SSL certificate name to match the host name of the server when connecting over SSL. The default value is false.")
  allowHostNameCNMismatch?: Record<unknown>;

  @doc("Specifies whether to allow self-signed certificates from the server. The default value is false.")
  allowSelfSignedServerCert?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Hive Server linked service.")
model HiveLinkedService extends LinkedService {
  @doc("Hive Server linked service properties.")
  typeProperties: HiveLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Hive";
}

@doc("Hive Server linked service properties.")
model HiveLinkedServiceTypeProperties {
  @doc("IP address or host name of the Hive server, separated by ';' for multiple hosts (only when serviceDiscoveryMode is enable).")
  host: Record<unknown>;

  @doc("The TCP port that the Hive server uses to listen for client connections.")
  port?: Record<unknown>;

  @doc("The type of Hive server.")
  serverType?: HiveServerType;

  @doc("The transport protocol to use in the Thrift layer.")
  thriftTransportProtocol?: HiveThriftTransportProtocol;

  @doc("The authentication method used to access the Hive server.")
  authenticationType: HiveAuthenticationType;

  @doc("true to indicate using the ZooKeeper service, false not.")
  serviceDiscoveryMode?: Record<unknown>;

  @doc("The namespace on ZooKeeper under which Hive Server 2 nodes are added.")
  zooKeeperNameSpace?: Record<unknown>;

  @doc("Specifies whether the driver uses native HiveQL queries,or converts them into an equivalent form in HiveQL.")
  useNativeQuery?: Record<unknown>;

  @doc("The user name that you use to access Hive Server.")
  username?: Record<unknown>;

  @doc("The password corresponding to the user name that you provided in the Username field")
  password?: SecretBase;

  @doc("The partial URL corresponding to the Hive server.")
  httpPath?: Record<unknown>;

  @doc("Specifies whether the connections to the server are encrypted using SSL. The default value is false.")
  enableSsl?: Record<unknown>;

  @doc("The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR.")
  trustedCertPath?: Record<unknown>;

  @doc("Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false.")
  useSystemTrustStore?: Record<unknown>;

  @doc("Specifies whether to require a CA-issued SSL certificate name to match the host name of the server when connecting over SSL. The default value is false.")
  allowHostNameCNMismatch?: Record<unknown>;

  @doc("Specifies whether to allow self-signed certificates from the server. The default value is false.")
  allowSelfSignedServerCert?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Hubspot Service linked service.")
model HubspotLinkedService extends LinkedService {
  @doc("Hubspot Service linked service properties.")
  typeProperties: HubspotLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Hubspot";
}

@doc("Hubspot Service linked service properties.")
model HubspotLinkedServiceTypeProperties {
  @doc("The client ID associated with your Hubspot application.")
  clientId: Record<unknown>;

  @doc("The client secret associated with your Hubspot application.")
  clientSecret?: SecretBase;

  @doc("The access token obtained when initially authenticating your OAuth integration.")
  accessToken?: SecretBase;

  @doc("The refresh token obtained when initially authenticating your OAuth integration.")
  refreshToken?: SecretBase;

  @doc("Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.")
  useEncryptedEndpoints?: Record<unknown>;

  @doc("Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.")
  useHostVerification?: Record<unknown>;

  @doc("Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.")
  usePeerVerification?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Impala server linked service.")
model ImpalaLinkedService extends LinkedService {
  @doc("Impala server linked service properties.")
  typeProperties: ImpalaLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Impala";
}

@doc("Impala server linked service properties.")
model ImpalaLinkedServiceTypeProperties {
  @doc("The IP address or host name of the Impala server. (i.e. 192.168.222.160)")
  host: Record<unknown>;

  @doc("The TCP port that the Impala server uses to listen for client connections. The default value is 21050.")
  port?: Record<unknown>;

  @doc("The authentication type to use.")
  authenticationType: ImpalaAuthenticationType;

  @doc("The user name used to access the Impala server. The default value is anonymous when using SASLUsername.")
  username?: Record<unknown>;

  @doc("The password corresponding to the user name when using UsernameAndPassword.")
  password?: SecretBase;

  @doc("Specifies whether the connections to the server are encrypted using SSL. The default value is false.")
  enableSsl?: Record<unknown>;

  @doc("The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR.")
  trustedCertPath?: Record<unknown>;

  @doc("Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false.")
  useSystemTrustStore?: Record<unknown>;

  @doc("Specifies whether to require a CA-issued SSL certificate name to match the host name of the server when connecting over SSL. The default value is false.")
  allowHostNameCNMismatch?: Record<unknown>;

  @doc("Specifies whether to allow self-signed certificates from the server. The default value is false.")
  allowSelfSignedServerCert?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Jira Service linked service.")
model JiraLinkedService extends LinkedService {
  @doc("Jira Service linked service properties.")
  typeProperties: JiraLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Jira";
}

@doc("Jira Service linked service properties.")
model JiraLinkedServiceTypeProperties {
  @doc("The IP address or host name of the Jira service. (e.g. jira.example.com)")
  host: Record<unknown>;

  @doc("The TCP port that the Jira server uses to listen for client connections. The default value is 443 if connecting through HTTPS, or 8080 if connecting through HTTP.")
  port?: Record<unknown>;

  @doc("The user name that you use to access Jira Service.")
  username: Record<unknown>;

  @doc("The password corresponding to the user name that you provided in the username field.")
  password?: SecretBase;

  @doc("Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.")
  useEncryptedEndpoints?: Record<unknown>;

  @doc("Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.")
  useHostVerification?: Record<unknown>;

  @doc("Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.")
  usePeerVerification?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Magento server linked service.")
model MagentoLinkedService extends LinkedService {
  @doc("Magento server linked service properties.")
  typeProperties: MagentoLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Magento";
}

@doc("Magento server linked service properties.")
model MagentoLinkedServiceTypeProperties {
  @doc("The URL of the Magento instance. (i.e. 192.168.222.110/magento3)")
  host: Record<unknown>;

  @doc("The access token from Magento.")
  accessToken?: SecretBase;

  @doc("Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.")
  useEncryptedEndpoints?: Record<unknown>;

  @doc("Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.")
  useHostVerification?: Record<unknown>;

  @doc("Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.")
  usePeerVerification?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("MariaDB server linked service.")
model MariaDBLinkedService extends LinkedService {
  @doc("MariaDB server linked service properties.")
  typeProperties: MariaDBLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "MariaDB";
}

@doc("MariaDB server linked service properties.")
model MariaDBLinkedServiceTypeProperties {
  @doc("An ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString?: Record<unknown>;

  @doc("The Azure key vault secret reference of password in connection string.")
  pwd?: AzureKeyVaultSecretReference;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Azure Database for MariaDB linked service.")
model AzureMariaDBLinkedService extends LinkedService {
  @doc("Azure Database for MariaDB linked service properties.")
  typeProperties: AzureMariaDBLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureMariaDB";
}

@doc("Azure Database for MariaDB linked service properties.")
model AzureMariaDBLinkedServiceTypeProperties {
  @doc("An ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString?: Record<unknown>;

  @doc("The Azure key vault secret reference of password in connection string.")
  pwd?: AzureKeyVaultSecretReference;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Marketo server linked service.")
model MarketoLinkedService extends LinkedService {
  @doc("Marketo server linked service properties.")
  typeProperties: MarketoLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Marketo";
}

@doc("Marketo server linked service properties.")
model MarketoLinkedServiceTypeProperties {
  @doc("The endpoint of the Marketo server. (i.e. 123-ABC-321.mktorest.com)")
  endpoint: Record<unknown>;

  @doc("The client Id of your Marketo service.")
  clientId: Record<unknown>;

  @doc("The client secret of your Marketo service.")
  clientSecret?: SecretBase;

  @doc("Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.")
  useEncryptedEndpoints?: Record<unknown>;

  @doc("Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.")
  useHostVerification?: Record<unknown>;

  @doc("Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.")
  usePeerVerification?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Paypal Service linked service.")
model PaypalLinkedService extends LinkedService {
  @doc("Paypal Service linked service properties.")
  typeProperties: PaypalLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Paypal";
}

@doc("Paypal Service linked service properties.")
model PaypalLinkedServiceTypeProperties {
  @doc("The URL of the PayPal instance. (i.e. api.sandbox.paypal.com)")
  host: Record<unknown>;

  @doc("The client ID associated with your PayPal application.")
  clientId: Record<unknown>;

  @doc("The client secret associated with your PayPal application.")
  clientSecret?: SecretBase;

  @doc("Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.")
  useEncryptedEndpoints?: Record<unknown>;

  @doc("Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.")
  useHostVerification?: Record<unknown>;

  @doc("Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.")
  usePeerVerification?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Phoenix server linked service.")
model PhoenixLinkedService extends LinkedService {
  @doc("Phoenix server linked service properties.")
  typeProperties: PhoenixLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Phoenix";
}

@doc("Phoenix server linked service properties.")
model PhoenixLinkedServiceTypeProperties {
  @doc("The IP address or host name of the Phoenix server. (i.e. 192.168.222.160)")
  host: Record<unknown>;

  @doc("The TCP port that the Phoenix server uses to listen for client connections. The default value is 8765.")
  port?: Record<unknown>;

  @doc("The partial URL corresponding to the Phoenix server. (i.e. /gateway/sandbox/phoenix/version). The default value is hbasephoenix if using WindowsAzureHDInsightService.")
  httpPath?: Record<unknown>;

  @doc("The authentication mechanism used to connect to the Phoenix server.")
  authenticationType: PhoenixAuthenticationType;

  @doc("The user name used to connect to the Phoenix server.")
  username?: Record<unknown>;

  @doc("The password corresponding to the user name.")
  password?: SecretBase;

  @doc("Specifies whether the connections to the server are encrypted using SSL. The default value is false.")
  enableSsl?: Record<unknown>;

  @doc("The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR.")
  trustedCertPath?: Record<unknown>;

  @doc("Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false.")
  useSystemTrustStore?: Record<unknown>;

  @doc("Specifies whether to require a CA-issued SSL certificate name to match the host name of the server when connecting over SSL. The default value is false.")
  allowHostNameCNMismatch?: Record<unknown>;

  @doc("Specifies whether to allow self-signed certificates from the server. The default value is false.")
  allowSelfSignedServerCert?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Presto server linked service.")
model PrestoLinkedService extends LinkedService {
  @doc("Presto server linked service properties.")
  typeProperties: PrestoLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Presto";
}

@doc("Presto server linked service properties.")
model PrestoLinkedServiceTypeProperties {
  @doc("The IP address or host name of the Presto server. (i.e. 192.168.222.160)")
  host: Record<unknown>;

  @doc("The version of the Presto server. (i.e. 0.148-t)")
  serverVersion: Record<unknown>;

  @doc("The catalog context for all request against the server.")
  catalog: Record<unknown>;

  @doc("The TCP port that the Presto server uses to listen for client connections. The default value is 8080.")
  port?: Record<unknown>;

  @doc("The authentication mechanism used to connect to the Presto server.")
  authenticationType: PrestoAuthenticationType;

  @doc("The user name used to connect to the Presto server.")
  username?: Record<unknown>;

  @doc("The password corresponding to the user name.")
  password?: SecretBase;

  @doc("Specifies whether the connections to the server are encrypted using SSL. The default value is false.")
  enableSsl?: Record<unknown>;

  @doc("The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR.")
  trustedCertPath?: Record<unknown>;

  @doc("Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false.")
  useSystemTrustStore?: Record<unknown>;

  @doc("Specifies whether to require a CA-issued SSL certificate name to match the host name of the server when connecting over SSL. The default value is false.")
  allowHostNameCNMismatch?: Record<unknown>;

  @doc("Specifies whether to allow self-signed certificates from the server. The default value is false.")
  allowSelfSignedServerCert?: Record<unknown>;

  @doc("The local time zone used by the connection. Valid values for this option are specified in the IANA Time Zone Database. The default value is the system time zone.")
  timeZoneID?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("QuickBooks server linked service.")
model QuickBooksLinkedService extends LinkedService {
  @doc("QuickBooks server linked service properties.")
  typeProperties: QuickBooksLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "QuickBooks";
}

@doc("QuickBooks server linked service properties.")
model QuickBooksLinkedServiceTypeProperties {
  @doc("Properties used to connect to QuickBooks. It is mutually exclusive with any other properties in the linked service. Type: object.")
  connectionProperties?: Record<unknown>;

  @doc("The endpoint of the QuickBooks server. (i.e. quickbooks.api.intuit.com)")
  endpoint?: Record<unknown>;

  @doc("The company ID of the QuickBooks company to authorize.")
  companyId?: Record<unknown>;

  @doc("The consumer key for OAuth 1.0 authentication.")
  consumerKey?: Record<unknown>;

  @doc("The consumer secret for OAuth 1.0 authentication.")
  consumerSecret?: SecretBase;

  @doc("The access token for OAuth 1.0 authentication.")
  accessToken?: SecretBase;

  @doc("The access token secret for OAuth 1.0 authentication.")
  accessTokenSecret?: SecretBase;

  @doc("Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.")
  useEncryptedEndpoints?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("ServiceNow server linked service.")
model ServiceNowLinkedService extends LinkedService {
  @doc("ServiceNow server linked service properties.")
  typeProperties: ServiceNowLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "ServiceNow";
}

@doc("ServiceNow server linked service properties.")
model ServiceNowLinkedServiceTypeProperties {
  @doc("The endpoint of the ServiceNow server. (i.e. <instance>.service-now.com)")
  endpoint: Record<unknown>;

  @doc("The authentication type to use.")
  authenticationType: ServiceNowAuthenticationType;

  @doc("The user name used to connect to the ServiceNow server for Basic and OAuth2 authentication.")
  username?: Record<unknown>;

  @doc("The password corresponding to the user name for Basic and OAuth2 authentication.")
  password?: SecretBase;

  @doc("The client id for OAuth2 authentication.")
  clientId?: Record<unknown>;

  @doc("The client secret for OAuth2 authentication.")
  clientSecret?: SecretBase;

  @doc("Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.")
  useEncryptedEndpoints?: Record<unknown>;

  @doc("Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.")
  useHostVerification?: Record<unknown>;

  @doc("Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.")
  usePeerVerification?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Shopify Service linked service.")
model ShopifyLinkedService extends LinkedService {
  @doc("Shopify Service linked service properties.")
  typeProperties: ShopifyLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Shopify";
}

@doc("Shopify Service linked service properties.")
model ShopifyLinkedServiceTypeProperties {
  @doc("The endpoint of the Shopify server. (i.e. mystore.myshopify.com)")
  host: Record<unknown>;

  @doc("The API access token that can be used to access Shopify’s data. The token won't expire if it is offline mode.")
  accessToken?: SecretBase;

  @doc("Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.")
  useEncryptedEndpoints?: Record<unknown>;

  @doc("Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.")
  useHostVerification?: Record<unknown>;

  @doc("Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.")
  usePeerVerification?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Spark Server linked service.")
model SparkLinkedService extends LinkedService {
  @doc("Spark Server linked service properties.")
  typeProperties: SparkLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Spark";
}

@doc("Spark Server linked service properties.")
model SparkLinkedServiceTypeProperties {
  @doc("IP address or host name of the Spark server")
  host: Record<unknown>;

  @doc("The TCP port that the Spark server uses to listen for client connections.")
  port: Record<unknown>;

  @doc("The type of Spark server.")
  serverType?: SparkServerType;

  @doc("The transport protocol to use in the Thrift layer.")
  thriftTransportProtocol?: SparkThriftTransportProtocol;

  @doc("The authentication method used to access the Spark server.")
  authenticationType: SparkAuthenticationType;

  @doc("The user name that you use to access Spark Server.")
  username?: Record<unknown>;

  @doc("The password corresponding to the user name that you provided in the Username field")
  password?: SecretBase;

  @doc("The partial URL corresponding to the Spark server.")
  httpPath?: Record<unknown>;

  @doc("Specifies whether the connections to the server are encrypted using SSL. The default value is false.")
  enableSsl?: Record<unknown>;

  @doc("The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR.")
  trustedCertPath?: Record<unknown>;

  @doc("Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false.")
  useSystemTrustStore?: Record<unknown>;

  @doc("Specifies whether to require a CA-issued SSL certificate name to match the host name of the server when connecting over SSL. The default value is false.")
  allowHostNameCNMismatch?: Record<unknown>;

  @doc("Specifies whether to allow self-signed certificates from the server. The default value is false.")
  allowSelfSignedServerCert?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Square Service linked service.")
model SquareLinkedService extends LinkedService {
  @doc("Square Service linked service properties.")
  typeProperties: SquareLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Square";
}

@doc("Square Service linked service properties.")
model SquareLinkedServiceTypeProperties {
  @doc("Properties used to connect to Square. It is mutually exclusive with any other properties in the linked service. Type: object.")
  connectionProperties?: Record<unknown>;

  @doc("The URL of the Square instance. (i.e. mystore.mysquare.com)")
  host?: Record<unknown>;

  @doc("The client ID associated with your Square application.")
  clientId?: Record<unknown>;

  @doc("The client secret associated with your Square application.")
  clientSecret?: SecretBase;

  @doc("The redirect URL assigned in the Square application dashboard. (i.e. http://localhost:2500)")
  redirectUri?: Record<unknown>;

  @doc("Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.")
  useEncryptedEndpoints?: Record<unknown>;

  @doc("Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.")
  useHostVerification?: Record<unknown>;

  @doc("Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.")
  usePeerVerification?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Xero Service linked service.")
model XeroLinkedService extends LinkedService {
  @doc("Xero Service linked service properties.")
  typeProperties: XeroLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Xero";
}

@doc("Xero Service linked service properties.")
model XeroLinkedServiceTypeProperties {
  @doc("Properties used to connect to Xero. It is mutually exclusive with any other properties in the linked service. Type: object.")
  connectionProperties?: Record<unknown>;

  @doc("The endpoint of the Xero server. (i.e. api.xero.com)")
  host?: Record<unknown>;

  @doc("The consumer key associated with the Xero application.")
  consumerKey?: SecretBase;

  @doc("""
The private key from the .pem file that was generated for your Xero private application. You must include all the text from the .pem file, including the Unix line endings(
).
""")
  privateKey?: SecretBase;

  @doc("Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.")
  useEncryptedEndpoints?: Record<unknown>;

  @doc("Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.")
  useHostVerification?: Record<unknown>;

  @doc("Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.")
  usePeerVerification?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Zoho server linked service.")
model ZohoLinkedService extends LinkedService {
  @doc("Zoho server linked service properties.")
  typeProperties: ZohoLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Zoho";
}

@doc("Zoho server linked service properties.")
model ZohoLinkedServiceTypeProperties {
  @doc("Properties used to connect to Zoho. It is mutually exclusive with any other properties in the linked service. Type: object.")
  connectionProperties?: Record<unknown>;

  @doc("The endpoint of the Zoho server. (i.e. crm.zoho.com/crm/private)")
  endpoint?: Record<unknown>;

  @doc("The access token for Zoho authentication.")
  accessToken?: SecretBase;

  @doc("Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.")
  useEncryptedEndpoints?: Record<unknown>;

  @doc("Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.")
  useHostVerification?: Record<unknown>;

  @doc("Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.")
  usePeerVerification?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Vertica linked service.")
model VerticaLinkedService extends LinkedService {
  @doc("Vertica linked service properties.")
  typeProperties: VerticaLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Vertica";
}

@doc("Vertica linked service properties.")
model VerticaLinkedServiceTypeProperties {
  @doc("An ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString?: Record<unknown>;

  @doc("The Azure key vault secret reference of password in connection string.")
  pwd?: AzureKeyVaultSecretReference;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Netezza linked service.")
model NetezzaLinkedService extends LinkedService {
  @doc("Netezza linked service properties.")
  typeProperties: NetezzaLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Netezza";
}

@doc("Netezza linked service properties.")
model NetezzaLinkedServiceTypeProperties {
  @doc("An ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.")
  connectionString?: Record<unknown>;

  @doc("The Azure key vault secret reference of password in connection string.")
  pwd?: AzureKeyVaultSecretReference;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Salesforce Marketing Cloud linked service.")
model SalesforceMarketingCloudLinkedService extends LinkedService {
  @doc("Salesforce Marketing Cloud linked service properties.")
  typeProperties: SalesforceMarketingCloudLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "SalesforceMarketingCloud";
}

@doc("Salesforce Marketing Cloud linked service properties.")
model SalesforceMarketingCloudLinkedServiceTypeProperties {
  @doc("Properties used to connect to Salesforce Marketing Cloud. It is mutually exclusive with any other properties in the linked service. Type: object.")
  connectionProperties?: Record<unknown>;

  @doc("The client ID associated with the Salesforce Marketing Cloud application. Type: string (or Expression with resultType string).")
  clientId?: Record<unknown>;

  @doc("The client secret associated with the Salesforce Marketing Cloud application. Type: string (or Expression with resultType string).")
  clientSecret?: SecretBase;

  @doc("Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true. Type: boolean (or Expression with resultType boolean).")
  useEncryptedEndpoints?: Record<unknown>;

  @doc("Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true. Type: boolean (or Expression with resultType boolean).")
  useHostVerification?: Record<unknown>;

  @doc("Specifies whether to verify the identity of the server when connecting over SSL. The default value is true. Type: boolean (or Expression with resultType boolean).")
  usePeerVerification?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("HDInsight ondemand linked service.")
model HDInsightOnDemandLinkedService extends LinkedService {
  @doc("HDInsight ondemand linked service properties.")
  typeProperties: HDInsightOnDemandLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "HDInsightOnDemand";
}

@doc("HDInsight ondemand linked service properties.")
model HDInsightOnDemandLinkedServiceTypeProperties {
  @doc("Number of worker/data nodes in the cluster. Suggestion value: 4. Type: string (or Expression with resultType string).")
  clusterSize: Record<unknown>;

  @doc("The allowed idle time for the on-demand HDInsight cluster. Specifies how long the on-demand HDInsight cluster stays alive after completion of an activity run if there are no other active jobs in the cluster. The minimum value is 5 mins. Type: string (or Expression with resultType string).")
  timeToLive: Record<unknown>;

  @doc("Version of the HDInsight cluster.  Type: string (or Expression with resultType string).")
  version: Record<unknown>;

  @doc("Azure Storage linked service to be used by the on-demand cluster for storing and processing data.")
  linkedServiceName: LinkedServiceReference;

  @doc("The customer’s subscription to host the cluster. Type: string (or Expression with resultType string).")
  hostSubscriptionId: Record<unknown>;

  @doc("The service principal id for the hostSubscriptionId. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("The key for the service principal id.")
  servicePrincipalKey?: SecretBase;

  @doc("The Tenant id/name to which the service principal belongs. Type: string (or Expression with resultType string).")
  tenant: Record<unknown>;

  @doc("The resource group where the cluster belongs. Type: string (or Expression with resultType string).")
  clusterResourceGroup: Record<unknown>;

  @doc("The prefix of cluster name, postfix will be distinct with timestamp. Type: string (or Expression with resultType string).")
  clusterNamePrefix?: Record<unknown>;

  @doc("The username to access the cluster. Type: string (or Expression with resultType string).")
  clusterUserName?: Record<unknown>;

  @doc("The password to access the cluster.")
  clusterPassword?: SecretBase;

  @doc("The username to SSH remotely connect to cluster’s node (for Linux). Type: string (or Expression with resultType string).")
  clusterSshUserName?: Record<unknown>;

  @doc("The password to SSH remotely connect cluster’s node (for Linux).")
  clusterSshPassword?: SecretBase;

  @doc("Specifies additional storage accounts for the HDInsight linked service so that the Data Factory service can register them on your behalf.")
  additionalLinkedServiceNames?: LinkedServiceReference[];

  @doc("The name of Azure SQL linked service that point to the HCatalog database. The on-demand HDInsight cluster is created by using the Azure SQL database as the metastore.")
  hcatalogLinkedServiceName?: LinkedServiceReference;

  @doc("The cluster type. Type: string (or Expression with resultType string).")
  clusterType?: Record<unknown>;

  @doc("The version of spark if the cluster type is 'spark'. Type: string (or Expression with resultType string).")
  sparkVersion?: Record<unknown>;

  @doc("Specifies the core configuration parameters (as in core-site.xml) for the HDInsight cluster to be created.")
  coreConfiguration?: Record<unknown>;

  @doc("Specifies the HBase configuration parameters (hbase-site.xml) for the HDInsight cluster.")
  hBaseConfiguration?: Record<unknown>;

  @doc("Specifies the HDFS configuration parameters (hdfs-site.xml) for the HDInsight cluster.")
  hdfsConfiguration?: Record<unknown>;

  @doc("Specifies the hive configuration parameters (hive-site.xml) for the HDInsight cluster.")
  hiveConfiguration?: Record<unknown>;

  @doc("Specifies the MapReduce configuration parameters (mapred-site.xml) for the HDInsight cluster.")
  mapReduceConfiguration?: Record<unknown>;

  @doc("Specifies the Oozie configuration parameters (oozie-site.xml) for the HDInsight cluster.")
  oozieConfiguration?: Record<unknown>;

  @doc("Specifies the Storm configuration parameters (storm-site.xml) for the HDInsight cluster.")
  stormConfiguration?: Record<unknown>;

  @doc("Specifies the Yarn configuration parameters (yarn-site.xml) for the HDInsight cluster.")
  yarnConfiguration?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("Specifies the size of the head node for the HDInsight cluster.")
  headNodeSize?: Record<unknown>;

  @doc("Specifies the size of the data node for the HDInsight cluster.")
  dataNodeSize?: Record<unknown>;

  @doc("Specifies the size of the Zoo Keeper node for the HDInsight cluster.")
  zookeeperNodeSize?: Record<unknown>;

  @doc("Custom script actions to run on HDI ondemand cluster once it's up. Please refer to https://docs.microsoft.com/en-us/azure/hdinsight/hdinsight-hadoop-customize-cluster-linux?toc=%2Fen-us%2Fazure%2Fhdinsight%2Fr-server%2FTOC.json&bc=%2Fen-us%2Fazure%2Fbread%2Ftoc.json#understanding-script-actions.")
  scriptActions?: ScriptAction[];

  @doc("The ARM resource ID for the vNet to which the cluster should be joined after creation. Type: string (or Expression with resultType string).")
  virtualNetworkId?: Record<unknown>;

  @doc("The ARM resource ID for the subnet in the vNet. If virtualNetworkId was specified, then this property is required. Type: string (or Expression with resultType string).")
  subnetName?: Record<unknown>;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;
}

@doc("Custom script action to run on HDI ondemand cluster once it's up.")
model ScriptAction {
  @doc("The user provided name of the script action.")
  name: string;

  @doc("The URI for the script action.")
  uri: string;

  @doc("The node types on which the script action should be executed.")
  roles: Record<unknown>;

  @doc("The parameters for the script action.")
  parameters?: string;
}

@doc("Azure Data Lake Analytics linked service.")
model AzureDataLakeAnalyticsLinkedService extends LinkedService {
  @doc("Azure Data Lake Analytics linked service properties.")
  typeProperties: AzureDataLakeAnalyticsLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureDataLakeAnalytics";
}

@doc("Azure Data Lake Analytics linked service properties.")
model AzureDataLakeAnalyticsLinkedServiceTypeProperties {
  @doc("The Azure Data Lake Analytics account name. Type: string (or Expression with resultType string).")
  accountName: Record<unknown>;

  @doc("The ID of the application used to authenticate against the Azure Data Lake Analytics account. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("The Key of the application used to authenticate against the Azure Data Lake Analytics account.")
  servicePrincipalKey?: SecretBase;

  @doc("The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).")
  tenant: Record<unknown>;

  @doc("Data Lake Analytics account subscription ID (if different from Data Factory account). Type: string (or Expression with resultType string).")
  subscriptionId?: Record<unknown>;

  @doc("Data Lake Analytics account resource group name (if different from Data Factory account). Type: string (or Expression with resultType string).")
  resourceGroupName?: Record<unknown>;

  @doc("Azure Data Lake Analytics URI Type: string (or Expression with resultType string).")
  dataLakeAnalyticsUri?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Azure Databricks linked service.")
model AzureDatabricksLinkedService extends LinkedService {
  @doc("Azure Databricks linked service properties.")
  typeProperties: AzureDatabricksLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureDatabricks";
}

@doc("Azure Databricks linked service properties.")
model AzureDatabricksLinkedServiceTypeProperties {
  @doc("<REGION>.azuredatabricks.net, domain name of your Databricks deployment. Type: string (or Expression with resultType string).")
  domain: Record<unknown>;

  @doc("Access token for databricks REST API. Refer to https://docs.azuredatabricks.net/api/latest/authentication.html. Type: string (or Expression with resultType string).")
  accessToken?: SecretBase;

  @doc("Required to specify MSI, if using Workspace resource id for databricks REST API. Type: string (or Expression with resultType string).")
  authentication?: Record<unknown>;

  @doc("Workspace resource id for databricks REST API. Type: string (or Expression with resultType string).")
  workspaceResourceId?: Record<unknown>;

  @doc("The id of an existing interactive cluster that will be used for all runs of this activity. Type: string (or Expression with resultType string).")
  existingClusterId?: Record<unknown>;

  @doc("The id of an existing instance pool that will be used for all runs of this activity. Type: string (or Expression with resultType string).")
  instancePoolId?: Record<unknown>;

  @doc("If not using an existing interactive cluster, this specifies the Spark version of a new job cluster or instance pool nodes created for each run of this activity. Required if instancePoolId is specified. Type: string (or Expression with resultType string).")
  newClusterVersion?: Record<unknown>;

  @doc("If not using an existing interactive cluster, this specifies the number of worker nodes to use for the new job cluster or instance pool. For new job clusters, this a string-formatted Int32, like '1' means numOfWorker is 1 or '1:10' means auto-scale from 1 (min) to 10 (max). For instance pools, this is a string-formatted Int32, and can only specify a fixed number of worker nodes, such as '2'. Required if newClusterVersion is specified. Type: string (or Expression with resultType string).")
  newClusterNumOfWorker?: Record<unknown>;

  @doc("The node type of the new job cluster. This property is required if newClusterVersion is specified and instancePoolId is not specified. If instancePoolId is specified, this property is ignored. Type: string (or Expression with resultType string).")
  newClusterNodeType?: Record<unknown>;

  @doc("A set of optional, user-specified Spark configuration key-value pairs.")
  newClusterSparkConf?: Record<Record<unknown>>;

  @doc("A set of optional, user-specified Spark environment variables key-value pairs.")
  newClusterSparkEnvVars?: Record<Record<unknown>>;

  @doc("Additional tags for cluster resources. This property is ignored in instance pool configurations.")
  newClusterCustomTags?: Record<Record<unknown>>;

  @doc("Specify a location to deliver Spark driver, worker, and event logs. Type: string (or Expression with resultType string).")
  newClusterLogDestination?: Record<unknown>;

  @doc("The driver node type for the new job cluster. This property is ignored in instance pool configurations. Type: string (or Expression with resultType string).")
  newClusterDriverNodeType?: Record<unknown>;

  @doc("User-defined initialization scripts for the new cluster. Type: array of strings (or Expression with resultType array of strings).")
  newClusterInitScripts?: Record<unknown>;

  @doc("Enable the elastic disk on the new cluster. This property is now ignored, and takes the default elastic disk behavior in Databricks (elastic disks are always enabled). Type: boolean (or Expression with resultType boolean).")
  newClusterEnableElasticDisk?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("The policy id for limiting the ability to configure clusters based on a user defined set of rules. Type: string (or Expression with resultType string).")
  policyId?: Record<unknown>;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;
}

@doc("Azure Databricks Delta Lake linked service.")
model AzureDatabricksDeltaLakeLinkedService extends LinkedService {
  @doc("Azure Databricks Delta Lake linked service properties.")
  typeProperties: AzureDatabricksDetltaLakeLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureDatabricksDeltaLake";
}

@doc("Azure Databricks Delta Lake linked service properties.")
model AzureDatabricksDetltaLakeLinkedServiceTypeProperties {
  @doc("<REGION>.azuredatabricks.net, domain name of your Databricks deployment. Type: string (or Expression with resultType string).")
  domain: Record<unknown>;

  @doc("Access token for databricks REST API. Refer to https://docs.azuredatabricks.net/api/latest/authentication.html. Type: string, SecureString or AzureKeyVaultSecretReference.")
  accessToken?: SecretBase;

  @doc("The id of an existing interactive cluster that will be used for all runs of this job. Type: string (or Expression with resultType string).")
  clusterId?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;

  @doc("Workspace resource id for databricks REST API. Type: string (or Expression with resultType string).")
  workspaceResourceId?: Record<unknown>;
}

@doc("Responsys linked service.")
model ResponsysLinkedService extends LinkedService {
  @doc("Responsys linked service properties.")
  typeProperties: ResponsysLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Responsys";
}

@doc("Responsys linked service properties.")
model ResponsysLinkedServiceTypeProperties {
  @doc("The endpoint of the Responsys server.")
  endpoint: Record<unknown>;

  @doc("The client ID associated with the Responsys application. Type: string (or Expression with resultType string).")
  clientId: Record<unknown>;

  @doc("The client secret associated with the Responsys application. Type: string (or Expression with resultType string).")
  clientSecret?: SecretBase;

  @doc("Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true. Type: boolean (or Expression with resultType boolean).")
  useEncryptedEndpoints?: Record<unknown>;

  @doc("Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true. Type: boolean (or Expression with resultType boolean).")
  useHostVerification?: Record<unknown>;

  @doc("Specifies whether to verify the identity of the server when connecting over SSL. The default value is true. Type: boolean (or Expression with resultType boolean).")
  usePeerVerification?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Dynamics AX linked service.")
model DynamicsAXLinkedService extends LinkedService {
  @doc("Dynamics AX linked service properties.")
  typeProperties: DynamicsAXLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "DynamicsAX";
}

@doc("Dynamics AX linked service properties.")
model DynamicsAXLinkedServiceTypeProperties {
  @doc("The Dynamics AX (or Dynamics 365 Finance and Operations) instance OData endpoint.")
  url: Record<unknown>;

  @doc("Specify the application's client ID. Type: string (or Expression with resultType string).")
  servicePrincipalId: Record<unknown>;

  @doc("Specify the application's key. Mark this field as a SecureString to store it securely in Data Factory, or reference a secret stored in Azure Key Vault. Type: string (or Expression with resultType string).")
  servicePrincipalKey: SecretBase;

  @doc("Specify the tenant information (domain name or tenant ID) under which your application resides. Retrieve it by hovering the mouse in the top-right corner of the Azure portal. Type: string (or Expression with resultType string).")
  tenant: Record<unknown>;

  @doc("Specify the resource you are requesting authorization. Type: string (or Expression with resultType string).")
  aadResourceId: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Oracle Service Cloud linked service.")
model OracleServiceCloudLinkedService extends LinkedService {
  @doc("Oracle Service Cloud linked service properties.")
  typeProperties: OracleServiceCloudLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "OracleServiceCloud";
}

@doc("Oracle Service Cloud linked service properties.")
model OracleServiceCloudLinkedServiceTypeProperties {
  @doc("The URL of the Oracle Service Cloud instance.")
  host: Record<unknown>;

  @doc("The user name that you use to access Oracle Service Cloud server.")
  username: Record<unknown>;

  @doc("The password corresponding to the user name that you provided in the username key.")
  password: SecretBase;

  @doc("Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true. Type: boolean (or Expression with resultType boolean).")
  useEncryptedEndpoints?: Record<unknown>;

  @doc("Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true. Type: boolean (or Expression with resultType boolean).")
  useHostVerification?: Record<unknown>;

  @doc("Specifies whether to verify the identity of the server when connecting over SSL. The default value is true. Type: boolean (or Expression with resultType boolean).")
  usePeerVerification?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Google AdWords service linked service.")
model GoogleAdWordsLinkedService extends LinkedService {
  @doc("Google AdWords service linked service properties.")
  typeProperties: GoogleAdWordsLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "GoogleAdWords";
}

@doc("Google AdWords service linked service properties.")
model GoogleAdWordsLinkedServiceTypeProperties {
  @doc("(Deprecated) Properties used to connect to GoogleAds. It is mutually exclusive with any other properties in the linked service. Type: object.")
  connectionProperties?: Record<unknown>;

  @doc("The Client customer ID of the AdWords account that you want to fetch report data for. Type: string (or Expression with resultType string).")
  clientCustomerID?: Record<unknown>;

  @doc("The developer token associated with the manager account that you use to grant access to the AdWords API.")
  developerToken?: SecretBase;

  @doc("The OAuth 2.0 authentication mechanism used for authentication. ServiceAuthentication can only be used on self-hosted IR.")
  authenticationType?: GoogleAdWordsAuthenticationType;

  @doc("The refresh token obtained from Google for authorizing access to AdWords for UserAuthentication.")
  refreshToken?: SecretBase;

  @doc("The client id of the google application used to acquire the refresh token. Type: string (or Expression with resultType string).")
  clientId?: Record<unknown>;

  @doc("The client secret of the google application used to acquire the refresh token.")
  clientSecret?: SecretBase;

  @doc("The service account email ID that is used for ServiceAuthentication and can only be used on self-hosted IR. Type: string (or Expression with resultType string).")
  email?: Record<unknown>;

  @doc("(Deprecated) The full path to the .p12 key file that is used to authenticate the service account email address and can only be used on self-hosted IR. Type: string (or Expression with resultType string).")
  keyFilePath?: Record<unknown>;

  @doc("(Deprecated) The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR. Type: string (or Expression with resultType string).")
  trustedCertPath?: Record<unknown>;

  @doc("(Deprecated) Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false. Type: boolean (or Expression with resultType boolean).")
  useSystemTrustStore?: Record<unknown>;

  @doc("The private key that is used to authenticate the service account email address and can only be used on self-hosted IR.")
  privateKey?: SecretBase;

  @doc("The customer ID of the Google Ads Manager account through which you want to fetch report data of specific Customer. Type: string (or Expression with resultType string).")
  loginCustomerID?: Record<unknown>;

  @doc("The Google Ads API major version such as v14. The supported major versions could be found on https://developers.google.com/google-ads/api/docs/release-notes. Type: string (or Expression with resultType string).")
  googleAdsApiVersion?: Record<unknown>;

  @doc("Specifies whether to use the legacy data type mappings, which maps float, int32 and int64 from Google to string. Do not set this to true unless you want to keep backward compatibility with legacy driver's data type mappings. Type: boolean (or Expression with resultType boolean).")
  supportLegacyDataTypes?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("SAP Table Linked Service.")
model SapTableLinkedService extends LinkedService {
  @doc("Properties specific to this linked service type.")
  typeProperties: SapTableLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "SapTable";
}

@doc("Properties specific to this linked service type.")
model SapTableLinkedServiceTypeProperties {
  @doc("Host name of the SAP instance where the table is located. Type: string (or Expression with resultType string).")
  server?: Record<unknown>;

  @doc("System number of the SAP system where the table is located. (Usually a two-digit decimal number represented as a string.) Type: string (or Expression with resultType string).")
  systemNumber?: Record<unknown>;

  @doc("Client ID of the client on the SAP system where the table is located. (Usually a three-digit decimal number represented as a string) Type: string (or Expression with resultType string).")
  clientId?: Record<unknown>;

  @doc("Language of the SAP system where the table is located. The default value is EN. Type: string (or Expression with resultType string).")
  language?: Record<unknown>;

  @doc("SystemID of the SAP system where the table is located. Type: string (or Expression with resultType string).")
  systemId?: Record<unknown>;

  @doc("Username to access the SAP server where the table is located. Type: string (or Expression with resultType string).")
  userName?: Record<unknown>;

  @doc("Password to access the SAP server where the table is located.")
  password?: SecretBase;

  @doc("The hostname of the SAP Message Server. Type: string (or Expression with resultType string).")
  messageServer?: Record<unknown>;

  @doc("The service name or port number of the Message Server. Type: string (or Expression with resultType string).")
  messageServerService?: Record<unknown>;

  @doc("SNC activation indicator to access the SAP server where the table is located. Must be either 0 (off) or 1 (on). Type: string (or Expression with resultType string).")
  sncMode?: Record<unknown>;

  @doc("Initiator's SNC name to access the SAP server where the table is located. Type: string (or Expression with resultType string).")
  sncMyName?: Record<unknown>;

  @doc("Communication partner's SNC name to access the SAP server where the table is located. Type: string (or Expression with resultType string).")
  sncPartnerName?: Record<unknown>;

  @doc("External security product's library to access the SAP server where the table is located. Type: string (or Expression with resultType string).")
  sncLibraryPath?: Record<unknown>;

  @doc("SNC Quality of Protection. Allowed value include: 1, 2, 3, 8, 9. Type: string (or Expression with resultType string).")
  sncQop?: Record<unknown>;

  @doc("The Logon Group for the SAP System. Type: string (or Expression with resultType string).")
  logonGroup?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Azure Data Explorer (Kusto) linked service.")
model AzureDataExplorerLinkedService extends LinkedService {
  @doc("Azure Data Explorer (Kusto) linked service properties.")
  typeProperties: AzureDataExplorerLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureDataExplorer";
}

@doc("Azure Data Explorer (Kusto) linked service properties.")
model AzureDataExplorerLinkedServiceTypeProperties {
  @doc("The endpoint of Azure Data Explorer (the engine's endpoint). URL will be in the format https://<clusterName>.<regionName>.kusto.windows.net. Type: string (or Expression with resultType string)")
  endpoint: Record<unknown>;

  @doc("The ID of the service principal used to authenticate against Azure Data Explorer. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("The key of the service principal used to authenticate against Kusto.")
  servicePrincipalKey?: SecretBase;

  @doc("Database name for connection. Type: string (or Expression with resultType string).")
  database: Record<unknown>;

  @doc("The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).")
  tenant?: Record<unknown>;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;
}

@doc("Azure Function linked service.")
model AzureFunctionLinkedService extends LinkedService {
  @doc("Azure Function linked service properties.")
  typeProperties: AzureFunctionLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureFunction";
}

@doc("Azure Function linked service properties.")
model AzureFunctionLinkedServiceTypeProperties {
  @doc("The endpoint of the Azure Function App. URL will be in the format https://<accountName>.azurewebsites.net.")
  functionAppUrl: Record<unknown>;

  @doc("Function or Host key for Azure Function App.")
  functionKey?: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;

  @doc("Allowed token audiences for azure function.")
  resourceId?: Record<unknown>;

  @doc("Type of authentication (Required to specify MSI) used to connect to AzureFunction. Type: string (or Expression with resultType string).")
  authentication?: Record<unknown>;
}

@doc("Snowflake linked service.")
model SnowflakeLinkedService extends LinkedService {
  @doc("Snowflake linked service properties.")
  typeProperties: SnowflakeLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "Snowflake";
}

@doc("Snowflake linked service properties.")
model SnowflakeLinkedServiceTypeProperties {
  @doc("The connection string of snowflake. Type: string, SecureString.")
  connectionString: Record<unknown>;

  @doc("The Azure key vault secret reference of password in connection string.")
  password?: AzureKeyVaultSecretReference;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("SharePoint Online List linked service.")
model SharePointOnlineListLinkedService extends LinkedService {
  @doc("SharePoint Online List linked service properties.")
  typeProperties: SharePointOnlineListLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "SharePointOnlineList";
}

@doc("SharePoint Online List linked service properties.")
model SharePointOnlineListLinkedServiceTypeProperties {
  @doc("The URL of the SharePoint Online site. For example, https://contoso.sharepoint.com/sites/siteName. Type: string (or Expression with resultType string).")
  siteUrl: Record<unknown>;

  @doc("The tenant ID under which your application resides. You can find it from Azure portal Active Directory overview page. Type: string (or Expression with resultType string).")
  tenantId: Record<unknown>;

  @doc("The application (client) ID of your application registered in Azure Active Directory. Make sure to grant SharePoint site permission to this application. Type: string (or Expression with resultType string).")
  servicePrincipalId: Record<unknown>;

  @doc("The client secret of your application registered in Azure Active Directory. Type: string (or Expression with resultType string).")
  servicePrincipalKey: SecretBase;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;
}

@doc("Azure Synapse Analytics (Artifacts) linked service.")
model AzureSynapseArtifactsLinkedService extends LinkedService {
  @doc("Azure Synapse Analytics (Artifacts) linked service properties.")
  typeProperties: AzureSynapseArtifactsLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "AzureSynapseArtifacts";
}

@doc("Azure Synapse Analytics (Artifacts) linked service properties.")
model AzureSynapseArtifactsLinkedServiceTypeProperties {
  @doc("https://<workspacename>.dev.azuresynapse.net, Azure Synapse Analytics workspace URL. Type: string (or Expression with resultType string).")
  endpoint: Record<unknown>;

  @doc("Required to specify MSI, if using system assigned managed identity as authentication method. Type: string (or Expression with resultType string).")
  authentication?: Record<unknown>;

  @doc("The resource ID of the Synapse workspace. The format should be: /subscriptions/{subscriptionID}/resourceGroups/{resourceGroup}/providers/Microsoft.Synapse/workspaces/{workspaceName}. Type: string (or Expression with resultType string).")
  workspaceResourceId?: Record<unknown>;
}

@doc("Microsoft Fabric LakeHouse linked service.")
model LakeHouseLinkedService extends LinkedService {
  @doc("Microsoft Fabric LakeHouse linked service properties.")
  typeProperties: LakeHouseLinkedServiceTypeProperties;

  @doc("Type of linked service.")
  type: "LakeHouse";
}

@doc("Microsoft Fabric LakeHouse linked service properties.")
model LakeHouseLinkedServiceTypeProperties {
  @doc("The ID of Microsoft Fabric workspace. Type: string (or Expression with resultType string).")
  workspaceId?: Record<unknown>;

  @doc("The ID of Microsoft Fabric LakeHouse artifact. Type: string (or Expression with resultType string).")
  artifactId?: Record<unknown>;

  @doc("The ID of the application used to authenticate against Microsoft Fabric LakeHouse. Type: string (or Expression with resultType string).")
  servicePrincipalId?: Record<unknown>;

  @doc("The Key of the application used to authenticate against Microsoft Fabric LakeHouse.")
  servicePrincipalKey?: SecretBase;

  @doc("The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).")
  tenant?: Record<unknown>;

  @doc("The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.")
  encryptedCredential?: string;

  @doc("The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).")
  servicePrincipalCredentialType?: Record<unknown>;

  @doc("The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.")
  servicePrincipalCredential?: SecretBase;
}

@doc("Base class for all control activities like IfCondition, ForEach , Until.")
@discriminator("type")
model ControlActivity extends Activity {}

@doc("Base class for all execution activities.")
@discriminator("type")
model ExecutionActivity extends Activity {
  @doc("Linked service reference.")
  linkedServiceName?: LinkedServiceReference;

  @doc("Activity policy.")
  policy?: ActivityPolicy;
}

@doc("Execution policy for an activity.")
model ActivityPolicy extends Record<Record<unknown>> {
  @doc("Specifies the timeout for the activity to run. The default timeout is 7 days. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  timeout?: Record<unknown>;

  @doc("Maximum ordinary retry attempts. Default is 0. Type: integer (or Expression with resultType integer), minimum: 0.")
  retry?: Record<unknown>;

  @doc("Interval between each retry attempt (in seconds). The default is 30 sec.")
  @maxValue(86400)
  @minValue(30)
  retryIntervalInSeconds?: int32;

  @doc("When set to true, Input from activity is considered as secure and will not be logged to monitoring.")
  secureInput?: boolean;

  @doc("When set to true, Output from activity is considered as secure and will not be logged to monitoring.")
  secureOutput?: boolean;
}

@doc("Connector read setting.")
@discriminator("type")
model StoreReadSettings extends Record<Record<unknown>> {
  @doc("The maximum concurrent connection count for the source data store. Type: integer (or Expression with resultType integer).")
  maxConcurrentConnections?: Record<unknown>;

  @doc("If true, disable data store metrics collection. Default is false. Type: boolean (or Expression with resultType boolean).")
  disableMetricsCollection?: Record<unknown>;
}

@doc("Azure blob read settings.")
model AzureBlobStorageReadSettings extends StoreReadSettings {
  @doc("If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("Azure blob wildcardFolderPath. Type: string (or Expression with resultType string).")
  wildcardFolderPath?: Record<unknown>;

  @doc("Azure blob wildcardFileName. Type: string (or Expression with resultType string).")
  wildcardFileName?: Record<unknown>;

  @doc("The prefix filter for the Azure Blob name. Type: string (or Expression with resultType string).")
  prefix?: Record<unknown>;

  @doc("Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).")
  fileListPath?: Record<unknown>;

  @doc("Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).")
  enablePartitionDiscovery?: Record<unknown>;

  @doc("Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).")
  partitionRootPath?: Record<unknown>;

  @doc("Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).")
  deleteFilesAfterCompletion?: Record<unknown>;

  @doc("The start of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeStart?: Record<unknown>;

  @doc("The end of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeEnd?: Record<unknown>;

  @doc("The read setting type.")
  type: "AzureBlobStorageReadSettings";
}

@doc("Azure blobFS read settings.")
model AzureBlobFSReadSettings extends StoreReadSettings {
  @doc("If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("Azure blobFS wildcardFolderPath. Type: string (or Expression with resultType string).")
  wildcardFolderPath?: Record<unknown>;

  @doc("Azure blobFS wildcardFileName. Type: string (or Expression with resultType string).")
  wildcardFileName?: Record<unknown>;

  @doc("Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).")
  fileListPath?: Record<unknown>;

  @doc("Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).")
  enablePartitionDiscovery?: Record<unknown>;

  @doc("Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).")
  partitionRootPath?: Record<unknown>;

  @doc("Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).")
  deleteFilesAfterCompletion?: Record<unknown>;

  @doc("The start of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeStart?: Record<unknown>;

  @doc("The end of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeEnd?: Record<unknown>;

  @doc("The read setting type.")
  type: "AzureBlobFSReadSettings";
}

@doc("Azure data lake store read settings.")
model AzureDataLakeStoreReadSettings extends StoreReadSettings {
  @doc("If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("ADLS wildcardFolderPath. Type: string (or Expression with resultType string).")
  wildcardFolderPath?: Record<unknown>;

  @doc("ADLS wildcardFileName. Type: string (or Expression with resultType string).")
  wildcardFileName?: Record<unknown>;

  @doc("Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).")
  fileListPath?: Record<unknown>;

  @doc("Lists files after the value (exclusive) based on file/folder names’ lexicographical order. Applies under the folderPath in data set, and filter files/sub-folders under the folderPath. Type: string (or Expression with resultType string).")
  listAfter?: Record<unknown>;

  @doc("Lists files before the value (inclusive) based on file/folder names’ lexicographical order. Applies under the folderPath in data set, and filter files/sub-folders under the folderPath. Type: string (or Expression with resultType string).")
  listBefore?: Record<unknown>;

  @doc("Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).")
  enablePartitionDiscovery?: Record<unknown>;

  @doc("Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).")
  partitionRootPath?: Record<unknown>;

  @doc("Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).")
  deleteFilesAfterCompletion?: Record<unknown>;

  @doc("The start of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeStart?: Record<unknown>;

  @doc("The end of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeEnd?: Record<unknown>;

  @doc("The read setting type.")
  type: "AzureDataLakeStoreReadSettings";
}

@doc("Amazon S3 read settings.")
model AmazonS3ReadSettings extends StoreReadSettings {
  @doc("If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("AmazonS3 wildcardFolderPath. Type: string (or Expression with resultType string).")
  wildcardFolderPath?: Record<unknown>;

  @doc("AmazonS3 wildcardFileName. Type: string (or Expression with resultType string).")
  wildcardFileName?: Record<unknown>;

  @doc("The prefix filter for the S3 object name. Type: string (or Expression with resultType string).")
  prefix?: Record<unknown>;

  @doc("Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).")
  fileListPath?: Record<unknown>;

  @doc("Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).")
  enablePartitionDiscovery?: Record<unknown>;

  @doc("Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).")
  partitionRootPath?: Record<unknown>;

  @doc("Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).")
  deleteFilesAfterCompletion?: Record<unknown>;

  @doc("The start of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeStart?: Record<unknown>;

  @doc("The end of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeEnd?: Record<unknown>;

  @doc("The read setting type.")
  type: "AmazonS3ReadSettings";
}

@doc("File server read settings.")
model FileServerReadSettings extends StoreReadSettings {
  @doc("If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("FileServer wildcardFolderPath. Type: string (or Expression with resultType string).")
  wildcardFolderPath?: Record<unknown>;

  @doc("FileServer wildcardFileName. Type: string (or Expression with resultType string).")
  wildcardFileName?: Record<unknown>;

  @doc("Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).")
  fileListPath?: Record<unknown>;

  @doc("Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).")
  enablePartitionDiscovery?: Record<unknown>;

  @doc("Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).")
  partitionRootPath?: Record<unknown>;

  @doc("Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).")
  deleteFilesAfterCompletion?: Record<unknown>;

  @doc("The start of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeStart?: Record<unknown>;

  @doc("The end of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeEnd?: Record<unknown>;

  @doc("Specify a filter to be used to select a subset of files in the folderPath rather than all files. Type: string (or Expression with resultType string).")
  fileFilter?: Record<unknown>;

  @doc("The read setting type.")
  type: "FileServerReadSettings";
}

@doc("Azure File Storage read settings.")
model AzureFileStorageReadSettings extends StoreReadSettings {
  @doc("If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("Azure File Storage wildcardFolderPath. Type: string (or Expression with resultType string).")
  wildcardFolderPath?: Record<unknown>;

  @doc("Azure File Storage wildcardFileName. Type: string (or Expression with resultType string).")
  wildcardFileName?: Record<unknown>;

  @doc("The prefix filter for the Azure File name starting from root path. Type: string (or Expression with resultType string).")
  prefix?: Record<unknown>;

  @doc("Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).")
  fileListPath?: Record<unknown>;

  @doc("Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).")
  enablePartitionDiscovery?: Record<unknown>;

  @doc("Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).")
  partitionRootPath?: Record<unknown>;

  @doc("Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).")
  deleteFilesAfterCompletion?: Record<unknown>;

  @doc("The start of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeStart?: Record<unknown>;

  @doc("The end of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeEnd?: Record<unknown>;

  @doc("The read setting type.")
  type: "AzureFileStorageReadSettings";
}

@doc("Sftp write settings.")
model SftpWriteSettings extends StoreWriteSettings {
  @doc("Specifies the timeout for writing each chunk to SFTP server. Default value: 01:00:00 (one hour). Type: string (or Expression with resultType string).")
  operationTimeout?: Record<unknown>;

  @doc("Upload to temporary file(s) and rename. Disable this option if your SFTP server doesn't support rename operation. Type: boolean (or Expression with resultType boolean).")
  useTempFileRename?: Record<unknown>;

  @doc("The write setting type.")
  type: "SftpWriteSettings";
}

@doc("Connector write settings.")
@discriminator("type")
model StoreWriteSettings extends Record<Record<unknown>> {
  @doc("The maximum concurrent connection count for the source data store. Type: integer (or Expression with resultType integer).")
  maxConcurrentConnections?: Record<unknown>;

  @doc("If true, disable data store metrics collection. Default is false. Type: boolean (or Expression with resultType boolean).")
  disableMetricsCollection?: Record<unknown>;

  @doc("The type of copy behavior for copy sink.")
  copyBehavior?: Record<unknown>;
}

@doc("Amazon S3 Compatible read settings.")
model AmazonS3CompatibleReadSettings extends StoreReadSettings {
  @doc("If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("Amazon S3 Compatible wildcardFolderPath. Type: string (or Expression with resultType string).")
  wildcardFolderPath?: Record<unknown>;

  @doc("Amazon S3 Compatible wildcardFileName. Type: string (or Expression with resultType string).")
  wildcardFileName?: Record<unknown>;

  @doc("The prefix filter for the S3 Compatible object name. Type: string (or Expression with resultType string).")
  prefix?: Record<unknown>;

  @doc("Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).")
  fileListPath?: Record<unknown>;

  @doc("Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).")
  enablePartitionDiscovery?: Record<unknown>;

  @doc("Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).")
  partitionRootPath?: Record<unknown>;

  @doc("Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).")
  deleteFilesAfterCompletion?: Record<unknown>;

  @doc("The start of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeStart?: Record<unknown>;

  @doc("The end of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeEnd?: Record<unknown>;

  @doc("The read setting type.")
  type: "AmazonS3CompatibleReadSettings";
}

@doc("Oracle Cloud Storage read settings.")
model OracleCloudStorageReadSettings extends StoreReadSettings {
  @doc("If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("Oracle Cloud Storage wildcardFolderPath. Type: string (or Expression with resultType string).")
  wildcardFolderPath?: Record<unknown>;

  @doc("Oracle Cloud Storage wildcardFileName. Type: string (or Expression with resultType string).")
  wildcardFileName?: Record<unknown>;

  @doc("The prefix filter for the Oracle Cloud Storage object name. Type: string (or Expression with resultType string).")
  prefix?: Record<unknown>;

  @doc("Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).")
  fileListPath?: Record<unknown>;

  @doc("Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).")
  enablePartitionDiscovery?: Record<unknown>;

  @doc("Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).")
  partitionRootPath?: Record<unknown>;

  @doc("Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).")
  deleteFilesAfterCompletion?: Record<unknown>;

  @doc("The start of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeStart?: Record<unknown>;

  @doc("The end of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeEnd?: Record<unknown>;

  @doc("The read setting type.")
  type: "OracleCloudStorageReadSettings";
}

@doc("Google Cloud Storage read settings.")
model GoogleCloudStorageReadSettings extends StoreReadSettings {
  @doc("If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("Google Cloud Storage wildcardFolderPath. Type: string (or Expression with resultType string).")
  wildcardFolderPath?: Record<unknown>;

  @doc("Google Cloud Storage wildcardFileName. Type: string (or Expression with resultType string).")
  wildcardFileName?: Record<unknown>;

  @doc("The prefix filter for the Google Cloud Storage object name. Type: string (or Expression with resultType string).")
  prefix?: Record<unknown>;

  @doc("Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).")
  fileListPath?: Record<unknown>;

  @doc("Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).")
  enablePartitionDiscovery?: Record<unknown>;

  @doc("Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).")
  partitionRootPath?: Record<unknown>;

  @doc("Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).")
  deleteFilesAfterCompletion?: Record<unknown>;

  @doc("The start of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeStart?: Record<unknown>;

  @doc("The end of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeEnd?: Record<unknown>;

  @doc("The read setting type.")
  type: "GoogleCloudStorageReadSettings";
}

@doc("Ftp read settings.")
model FtpReadSettings extends StoreReadSettings {
  @doc("If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("Ftp wildcardFolderPath. Type: string (or Expression with resultType string).")
  wildcardFolderPath?: Record<unknown>;

  @doc("Ftp wildcardFileName. Type: string (or Expression with resultType string).")
  wildcardFileName?: Record<unknown>;

  @doc("Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).")
  enablePartitionDiscovery?: Record<unknown>;

  @doc("Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).")
  partitionRootPath?: Record<unknown>;

  @doc("Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).")
  deleteFilesAfterCompletion?: Record<unknown>;

  @doc("Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).")
  fileListPath?: Record<unknown>;

  @doc("Specify whether to use binary transfer mode for FTP stores. Type: boolean (or Expression with resultType boolean).")
  useBinaryTransfer?: Record<unknown>;

  @doc("If true, disable parallel reading within each file. Default is false. Type: boolean (or Expression with resultType boolean).")
  disableChunking?: Record<unknown>;

  @doc("The read setting type.")
  type: "FtpReadSettings";
}

@doc("Sftp read settings.")
model SftpReadSettings extends StoreReadSettings {
  @doc("If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("Sftp wildcardFolderPath. Type: string (or Expression with resultType string).")
  wildcardFolderPath?: Record<unknown>;

  @doc("Sftp wildcardFileName. Type: string (or Expression with resultType string).")
  wildcardFileName?: Record<unknown>;

  @doc("Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).")
  enablePartitionDiscovery?: Record<unknown>;

  @doc("Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).")
  partitionRootPath?: Record<unknown>;

  @doc("Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).")
  fileListPath?: Record<unknown>;

  @doc("Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).")
  deleteFilesAfterCompletion?: Record<unknown>;

  @doc("The start of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeStart?: Record<unknown>;

  @doc("The end of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeEnd?: Record<unknown>;

  @doc("If true, disable parallel reading within each file. Default is false. Type: boolean (or Expression with resultType boolean).")
  disableChunking?: Record<unknown>;

  @doc("The read setting type.")
  type: "SftpReadSettings";
}

@doc("Http read settings.")
model HttpReadSettings extends StoreReadSettings {
  @doc("The HTTP method used to call the RESTful API. The default is GET. Type: string (or Expression with resultType string).")
  requestMethod?: Record<unknown>;

  @doc("The HTTP request body to the RESTful API if requestMethod is POST. Type: string (or Expression with resultType string).")
  requestBody?: Record<unknown>;

  @doc("The additional HTTP headers in the request to the RESTful API. Type: string (or Expression with resultType string).")
  additionalHeaders?: Record<unknown>;

  @doc("Specifies the timeout for a HTTP client to get HTTP response from HTTP server. Type: string (or Expression with resultType string).")
  requestTimeout?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("The read setting type.")
  type: "HttpReadSettings";
}

@doc("HDFS read settings.")
model HdfsReadSettings extends StoreReadSettings {
  @doc("If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("HDFS wildcardFolderPath. Type: string (or Expression with resultType string).")
  wildcardFolderPath?: Record<unknown>;

  @doc("HDFS wildcardFileName. Type: string (or Expression with resultType string).")
  wildcardFileName?: Record<unknown>;

  @doc("Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).")
  fileListPath?: Record<unknown>;

  @doc("Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).")
  enablePartitionDiscovery?: Record<unknown>;

  @doc("Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).")
  partitionRootPath?: Record<unknown>;

  @doc("The start of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeStart?: Record<unknown>;

  @doc("The end of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeEnd?: Record<unknown>;

  @doc("Specifies Distcp-related settings.")
  distcpSettings?: DistcpSettings;

  @doc("Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).")
  deleteFilesAfterCompletion?: Record<unknown>;

  @doc("The read setting type.")
  type: "HdfsReadSettings";
}

@doc("Distcp settings.")
model DistcpSettings {
  @doc("Specifies the Yarn ResourceManager endpoint. Type: string (or Expression with resultType string).")
  resourceManagerEndpoint: Record<unknown>;

  @doc("Specifies an existing folder path which will be used to store temp Distcp command script. The script file is generated by ADF and will be removed after Copy job finished. Type: string (or Expression with resultType string).")
  tempScriptPath: Record<unknown>;

  @doc("Specifies the Distcp options. Type: string (or Expression with resultType string).")
  distcpOptions?: Record<unknown>;
}

@doc("Microsoft Fabric LakeHouse Files read settings.")
model LakeHouseReadSettings extends StoreReadSettings {
  @doc("If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("Microsoft Fabric LakeHouse Files wildcardFolderPath. Type: string (or Expression with resultType string).")
  wildcardFolderPath?: Record<unknown>;

  @doc("Microsoft Fabric LakeHouse Files wildcardFileName. Type: string (or Expression with resultType string).")
  wildcardFileName?: Record<unknown>;

  @doc("Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).")
  fileListPath?: Record<unknown>;

  @doc("Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).")
  enablePartitionDiscovery?: Record<unknown>;

  @doc("Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).")
  partitionRootPath?: Record<unknown>;

  @doc("Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).")
  deleteFilesAfterCompletion?: Record<unknown>;

  @doc("The start of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeStart?: Record<unknown>;

  @doc("The end of file's modified datetime. Type: string (or Expression with resultType string).")
  modifiedDatetimeEnd?: Record<unknown>;

  @doc("The read setting type.")
  type: "LakeHouseReadSettings";
}

@doc("Azure blob write settings.")
model AzureBlobStorageWriteSettings extends StoreWriteSettings {
  @doc("Indicates the block size(MB) when writing data to blob. Type: integer (or Expression with resultType integer).")
  blockSizeInMB?: Record<unknown>;

  @doc("The write setting type.")
  type: "AzureBlobStorageWriteSettings";
}

@doc("Azure blobFS write settings.")
model AzureBlobFSWriteSettings extends StoreWriteSettings {
  @doc("Indicates the block size(MB) when writing data to blob. Type: integer (or Expression with resultType integer).")
  blockSizeInMB?: Record<unknown>;

  @doc("The write setting type.")
  type: "AzureBlobFSWriteSettings";
}

@doc("Azure data lake store write settings.")
model AzureDataLakeStoreWriteSettings extends StoreWriteSettings {
  @doc("Specifies the expiry time of the written files. The time is applied to the UTC time zone in the format of \"2018-12-01T05:00:00Z\". Default value is NULL. Type: string (or Expression with resultType string).")
  expiryDateTime?: Record<unknown>;

  @doc("The write setting type.")
  type: "AzureDataLakeStoreWriteSettings";
}

@doc("File server write settings.")
model FileServerWriteSettings extends StoreWriteSettings {
  @doc("The write setting type.")
  type: "FileServerWriteSettings";
}

@doc("Azure File Storage write settings.")
model AzureFileStorageWriteSettings extends StoreWriteSettings {
  @doc("The write setting type.")
  type: "AzureFileStorageWriteSettings";
}

@doc("Microsoft Fabric LakeHouse Files write settings.")
model LakeHouseWriteSettings extends StoreWriteSettings {
  @doc("The write setting type.")
  type: "LakeHouseWriteSettings";
}

@doc("Format read settings.")
@discriminator("type")
model FormatReadSettings extends Record<Record<unknown>> {}

@doc("Compression read settings.")
@discriminator("type")
model CompressionReadSettings extends Record<Record<unknown>> {}

@doc("The ZipDeflate compression read settings.")
model ZipDeflateReadSettings extends CompressionReadSettings {
  @doc("Preserve the zip file name as folder path. Type: boolean (or Expression with resultType boolean).")
  preserveZipFileNameAsFolder?: Record<unknown>;

  @doc("The Compression setting type.")
  type: "ZipDeflateReadSettings";
}

@doc("The Tar compression read settings.")
model TarReadSettings extends CompressionReadSettings {
  @doc("Preserve the compression file name as folder path. Type: boolean (or Expression with resultType boolean).")
  preserveCompressionFileNameAsFolder?: Record<unknown>;

  @doc("The Compression setting type.")
  type: "TarReadSettings";
}

@doc("The TarGZip compression read settings.")
model TarGZipReadSettings extends CompressionReadSettings {
  @doc("Preserve the compression file name as folder path. Type: boolean (or Expression with resultType boolean).")
  preserveCompressionFileNameAsFolder?: Record<unknown>;

  @doc("The Compression setting type.")
  type: "TarGZipReadSettings";
}

@doc("Parquet read settings.")
model ParquetReadSettings extends FormatReadSettings {
  @doc("Compression settings.")
  compressionProperties?: CompressionReadSettings;

  @doc("The read setting type.")
  type: "ParquetReadSettings";
}

@doc("Delimited text read settings.")
model DelimitedTextReadSettings extends FormatReadSettings {
  @doc("Indicates the number of non-empty rows to skip when reading data from input files. Type: integer (or Expression with resultType integer).")
  skipLineCount?: Record<unknown>;

  @doc("Compression settings.")
  compressionProperties?: CompressionReadSettings;

  @doc("The read setting type.")
  type: "DelimitedTextReadSettings";
}

@doc("Json read settings.")
model JsonReadSettings extends FormatReadSettings {
  @doc("Compression settings.")
  compressionProperties?: CompressionReadSettings;

  @doc("The read setting type.")
  type: "JsonReadSettings";
}

@doc("Xml read settings.")
model XmlReadSettings extends FormatReadSettings {
  @doc("Compression settings.")
  compressionProperties?: CompressionReadSettings;

  @doc("Indicates what validation method is used when reading the xml files. Allowed values: 'none', 'xsd', or 'dtd'. Type: string (or Expression with resultType string).")
  validationMode?: Record<unknown>;

  @doc("Indicates whether type detection is enabled when reading the xml files. Type: boolean (or Expression with resultType boolean).")
  detectDataType?: Record<unknown>;

  @doc("Indicates whether namespace is enabled when reading the xml files. Type: boolean (or Expression with resultType boolean).")
  namespaces?: Record<unknown>;

  @doc("Namespace uri to prefix mappings to override the prefixes in column names when namespace is enabled, if no prefix is defined for a namespace uri, the prefix of xml element/attribute name in the xml data file will be used. Example: \"{\"http://www.example.com/xml\":\"prefix\"}\" Type: object (or Expression with resultType object).")
  namespacePrefixes?: Record<unknown>;

  @doc("The read setting type.")
  type: "XmlReadSettings";
}

@doc("Binary read settings.")
model BinaryReadSettings extends FormatReadSettings {
  @doc("Compression settings.")
  compressionProperties?: CompressionReadSettings;

  @doc("The read setting type.")
  type: "BinaryReadSettings";
}

@doc("Format write settings.")
@discriminator("type")
model FormatWriteSettings extends Record<Record<unknown>> {}

@doc("Avro write settings.")
model AvroWriteSettings extends FormatWriteSettings {
  @doc("Top level record name in write result, which is required in AVRO spec.")
  recordName?: string;

  @doc("Record namespace in the write result.")
  recordNamespace?: string;

  @doc("Limit the written file's row count to be smaller than or equal to the specified count. Type: integer (or Expression with resultType integer).")
  maxRowsPerFile?: Record<unknown>;

  @doc("Specifies the file name pattern <fileNamePrefix>_<fileIndex>.<fileExtension> when copy from non-file based store without partitionOptions. Type: string (or Expression with resultType string).")
  fileNamePrefix?: Record<unknown>;

  @doc("The write setting type.")
  type: "AvroWriteSettings";
}

@doc("Orc write settings.")
model OrcWriteSettings extends FormatWriteSettings {
  @doc("Limit the written file's row count to be smaller than or equal to the specified count. Type: integer (or Expression with resultType integer).")
  maxRowsPerFile?: Record<unknown>;

  @doc("Specifies the file name pattern <fileNamePrefix>_<fileIndex>.<fileExtension> when copy from non-file based store without partitionOptions. Type: string (or Expression with resultType string).")
  fileNamePrefix?: Record<unknown>;

  @doc("The write setting type.")
  type: "OrcWriteSettings";
}

@doc("Parquet write settings.")
model ParquetWriteSettings extends FormatWriteSettings {
  @doc("Limit the written file's row count to be smaller than or equal to the specified count. Type: integer (or Expression with resultType integer).")
  maxRowsPerFile?: Record<unknown>;

  @doc("Specifies the file name pattern <fileNamePrefix>_<fileIndex>.<fileExtension> when copy from non-file based store without partitionOptions. Type: string (or Expression with resultType string).")
  fileNamePrefix?: Record<unknown>;

  @doc("The write setting type.")
  type: "ParquetWriteSettings";
}

@doc("Delimited text write settings.")
model DelimitedTextWriteSettings extends FormatWriteSettings {
  @doc("Indicates whether string values should always be enclosed with quotes. Type: boolean (or Expression with resultType boolean).")
  quoteAllText?: Record<unknown>;

  @doc("The file extension used to create the files. Type: string (or Expression with resultType string).")
  fileExtension: Record<unknown>;

  @doc("Limit the written file's row count to be smaller than or equal to the specified count. Type: integer (or Expression with resultType integer).")
  maxRowsPerFile?: Record<unknown>;

  @doc("Specifies the file name pattern <fileNamePrefix>_<fileIndex>.<fileExtension> when copy from non-file based store without partitionOptions. Type: string (or Expression with resultType string).")
  fileNamePrefix?: Record<unknown>;

  @doc("The write setting type.")
  type: "DelimitedTextWriteSettings";
}

@doc("Json write settings.")
model JsonWriteSettings extends FormatWriteSettings {
  @doc("File pattern of JSON. This setting controls the way a collection of JSON objects will be treated. The default value is 'setOfObjects'. It is case-sensitive.")
  filePattern?: Record<unknown>;

  @doc("The write setting type.")
  type: "JsonWriteSettings";
}

@doc("A copy activity Avro source.")
model AvroSource extends CopySource {
  @doc("Avro store settings.")
  storeSettings?: StoreReadSettings;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "AvroSource";
}

@doc("A copy activity source.")
@discriminator("type")
model CopySource extends Record<Record<unknown>> {
  @doc("Source retry count. Type: integer (or Expression with resultType integer).")
  sourceRetryCount?: Record<unknown>;

  @doc("Source retry wait. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  sourceRetryWait?: Record<unknown>;

  @doc("The maximum concurrent connection count for the source data store. Type: integer (or Expression with resultType integer).")
  maxConcurrentConnections?: Record<unknown>;

  @doc("If true, disable data store metrics collection. Default is false. Type: boolean (or Expression with resultType boolean).")
  disableMetricsCollection?: Record<unknown>;
}

@doc("A copy activity excel source.")
model ExcelSource extends CopySource {
  @doc("Excel store settings.")
  storeSettings?: StoreReadSettings;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "ExcelSource";
}

@doc("A copy activity Parquet source.")
model ParquetSource extends CopySource {
  @doc("Parquet store settings.")
  storeSettings?: StoreReadSettings;

  @doc("Parquet format settings.")
  formatSettings?: ParquetReadSettings;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "ParquetSource";
}

@doc("A copy activity DelimitedText source.")
model DelimitedTextSource extends CopySource {
  @doc("DelimitedText store settings.")
  storeSettings?: StoreReadSettings;

  @doc("DelimitedText format settings.")
  formatSettings?: DelimitedTextReadSettings;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "DelimitedTextSource";
}

@doc("A copy activity Json source.")
model JsonSource extends CopySource {
  @doc("Json store settings.")
  storeSettings?: StoreReadSettings;

  @doc("Json format settings.")
  formatSettings?: JsonReadSettings;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "JsonSource";
}

@doc("A copy activity Xml source.")
model XmlSource extends CopySource {
  @doc("Xml store settings.")
  storeSettings?: StoreReadSettings;

  @doc("Xml format settings.")
  formatSettings?: XmlReadSettings;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "XmlSource";
}

@doc("A copy activity ORC source.")
model OrcSource extends CopySource {
  @doc("ORC store settings.")
  storeSettings?: StoreReadSettings;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "OrcSource";
}

@doc("A copy activity DelimitedText sink.")
model DelimitedTextSink extends CopySink {
  @doc("DelimitedText store settings.")
  storeSettings?: StoreWriteSettings;

  @doc("DelimitedText format settings.")
  formatSettings?: DelimitedTextWriteSettings;

  @doc("Copy sink type.")
  type: "DelimitedTextSink";
}

@doc("A copy activity sink.")
@discriminator("type")
model CopySink extends Record<Record<unknown>> {
  @doc("Write batch size. Type: integer (or Expression with resultType integer), minimum: 0.")
  writeBatchSize?: Record<unknown>;

  @doc("Write batch timeout. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  writeBatchTimeout?: Record<unknown>;

  @doc("Sink retry count. Type: integer (or Expression with resultType integer).")
  sinkRetryCount?: Record<unknown>;

  @doc("Sink retry wait. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  sinkRetryWait?: Record<unknown>;

  @doc("The maximum concurrent connection count for the sink data store. Type: integer (or Expression with resultType integer).")
  maxConcurrentConnections?: Record<unknown>;

  @doc("If true, disable data store metrics collection. Default is false. Type: boolean (or Expression with resultType boolean).")
  disableMetricsCollection?: Record<unknown>;
}

@doc("A copy activity Json sink.")
model JsonSink extends CopySink {
  @doc("Json store settings.")
  storeSettings?: StoreWriteSettings;

  @doc("Json format settings.")
  formatSettings?: JsonWriteSettings;

  @doc("Copy sink type.")
  type: "JsonSink";
}

@doc("A copy activity ORC sink.")
model OrcSink extends CopySink {
  @doc("ORC store settings.")
  storeSettings?: StoreWriteSettings;

  @doc("ORC format settings.")
  formatSettings?: OrcWriteSettings;

  @doc("Copy sink type.")
  type: "OrcSink";
}

@doc("Copy activity.")
model CopyActivity extends ExecutionActivity {
  @doc("Copy activity properties.")
  typeProperties: CopyActivityTypeProperties;

  @doc("List of inputs for the activity.")
  inputs?: DatasetReference[];

  @doc("List of outputs for the activity.")
  outputs?: DatasetReference[];

  @doc("Type of activity.")
  type: "Copy";
}

@doc("Copy activity properties.")
model CopyActivityTypeProperties {
  @doc("Copy activity source.")
  source: CopySource;

  @doc("Copy activity sink.")
  sink: CopySink;

  @doc("Copy activity translator. If not specified, tabular translator is used.")
  translator?: Record<unknown>;

  @doc("Specifies whether to copy data via an interim staging. Default value is false. Type: boolean (or Expression with resultType boolean).")
  enableStaging?: Record<unknown>;

  @doc("Specifies interim staging settings when EnableStaging is true.")
  stagingSettings?: StagingSettings;

  @doc("Maximum number of concurrent sessions opened on the source or sink to avoid overloading the data store. Type: integer (or Expression with resultType integer), minimum: 0.")
  parallelCopies?: Record<unknown>;

  @doc("Maximum number of data integration units that can be used to perform this data movement. Type: integer (or Expression with resultType integer), minimum: 0.")
  dataIntegrationUnits?: Record<unknown>;

  @doc("Whether to skip incompatible row. Default value is false. Type: boolean (or Expression with resultType boolean).")
  enableSkipIncompatibleRow?: Record<unknown>;

  @doc("Redirect incompatible row settings when EnableSkipIncompatibleRow is true.")
  redirectIncompatibleRowSettings?: RedirectIncompatibleRowSettings;

  @doc("(Deprecated. Please use LogSettings) Log storage settings customer need to provide when enabling session log.")
  logStorageSettings?: LogStorageSettings;

  @doc("Log settings customer needs provide when enabling log.")
  logSettings?: LogSettings;

  @doc("Preserve Rules.")
  preserveRules?: Record<unknown>[];

  @doc("Preserve rules.")
  preserve?: Record<unknown>[];

  @doc("Whether to enable Data Consistency validation. Type: boolean (or Expression with resultType boolean).")
  validateDataConsistency?: Record<unknown>;

  @doc("Specify the fault tolerance for data consistency.")
  skipErrorFile?: SkipErrorFile;
}

@doc("Staging settings.")
model StagingSettings extends Record<Record<unknown>> {
  @doc("Staging linked service reference.")
  linkedServiceName: LinkedServiceReference;

  @doc("The path to storage for storing the interim data. Type: string (or Expression with resultType string).")
  path?: Record<unknown>;

  @doc("Specifies whether to use compression when copying data via an interim staging. Default value is false. Type: boolean (or Expression with resultType boolean).")
  enableCompression?: Record<unknown>;
}

@doc("Redirect incompatible row settings")
model RedirectIncompatibleRowSettings extends Record<Record<unknown>> {
  @doc("Name of the Azure Storage, Storage SAS, or Azure Data Lake Store linked service used for redirecting incompatible row. Must be specified if redirectIncompatibleRowSettings is specified. Type: string (or Expression with resultType string).")
  linkedServiceName: Record<unknown>;

  @doc("The path for storing the redirect incompatible row data. Type: string (or Expression with resultType string).")
  path?: Record<unknown>;
}

@doc("(Deprecated. Please use LogSettings) Log storage settings.")
model LogStorageSettings extends Record<Record<unknown>> {
  @doc("Log storage linked service reference.")
  linkedServiceName: LinkedServiceReference;

  @doc("The path to storage for storing detailed logs of activity execution. Type: string (or Expression with resultType string).")
  path?: Record<unknown>;

  @doc("Gets or sets the log level, support: Info, Warning. Type: string (or Expression with resultType string).")
  logLevel?: Record<unknown>;

  @doc("Specifies whether to enable reliable logging. Type: boolean (or Expression with resultType boolean).")
  enableReliableLogging?: Record<unknown>;
}

@doc("Log settings.")
model LogSettings {
  @doc("Specifies whether to enable copy activity log. Type: boolean (or Expression with resultType boolean).")
  enableCopyActivityLog?: Record<unknown>;

  @doc("Specifies settings for copy activity log.")
  copyActivityLogSettings?: CopyActivityLogSettings;

  @doc("Log location settings customer needs to provide when enabling log.")
  logLocationSettings: LogLocationSettings;
}

@doc("Settings for copy activity log.")
model CopyActivityLogSettings {
  @doc("Gets or sets the log level, support: Info, Warning. Type: string (or Expression with resultType string).")
  logLevel?: Record<unknown>;

  @doc("Specifies whether to enable reliable logging. Type: boolean (or Expression with resultType boolean).")
  enableReliableLogging?: Record<unknown>;
}

@doc("Log location settings.")
model LogLocationSettings {
  @doc("Log storage linked service reference.")
  linkedServiceName: LinkedServiceReference;

  @doc("The path to storage for storing detailed logs of activity execution. Type: string (or Expression with resultType string).")
  path?: Record<unknown>;
}

@doc("Skip error file.")
model SkipErrorFile {
  @doc("Skip if file is deleted by other client during copy. Default is true. Type: boolean (or Expression with resultType boolean).")
  fileMissing?: Record<unknown>;

  @doc("Skip if source/sink file changed by other concurrent write. Default is false. Type: boolean (or Expression with resultType boolean).")
  dataInconsistency?: Record<unknown>;
}

@doc("A copy activity Binary source.")
model BinarySource extends CopySource {
  @doc("Binary store settings.")
  storeSettings?: StoreReadSettings;

  @doc("Binary format settings.")
  formatSettings?: BinaryReadSettings;

  @doc("Copy source type.")
  type: "BinarySource";
}

@doc("Copy activity sources of tabular type.")
@discriminator("type")
model TabularSource extends CopySource {
  @doc("Query timeout. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  queryTimeout?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;
}

@doc("A copy activity Azure Table source.")
model AzureTableSource extends TabularSource {
  @doc("Azure Table source query. Type: string (or Expression with resultType string).")
  azureTableSourceQuery?: Record<unknown>;

  @doc("Azure Table source ignore table not found. Type: boolean (or Expression with resultType boolean).")
  azureTableSourceIgnoreTableNotFound?: Record<unknown>;

  @doc("Copy source type.")
  type: "AzureTableSource";
}

@doc("A copy activity Azure Blob source.")
model BlobSource extends CopySource {
  @doc("Treat empty as null. Type: boolean (or Expression with resultType boolean).")
  treatEmptyAsNull?: Record<unknown>;

  @doc("Number of header lines to skip from each blob. Type: integer (or Expression with resultType integer).")
  skipHeaderLineCount?: Record<unknown>;

  @doc("If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("Copy source type.")
  type: "BlobSource";
}

@doc("A copy activity Document Database Collection source.")
model DocumentDbCollectionSource extends CopySource {
  @doc("Documents query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Nested properties separator. Type: string (or Expression with resultType string).")
  nestingSeparator?: Record<unknown>;

  @doc("Query timeout. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  queryTimeout?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "DocumentDbCollectionSource";
}

@doc("A copy activity Azure CosmosDB (SQL API) Collection source.")
model CosmosDbSqlApiSource extends CopySource {
  @doc("SQL API query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Page size of the result. Type: integer (or Expression with resultType integer).")
  pageSize?: Record<unknown>;

  @doc("Preferred regions. Type: array of strings (or Expression with resultType array of strings).")
  preferredRegions?: Record<unknown>;

  @doc("Whether detect primitive values as datetime values. Type: boolean (or Expression with resultType boolean).")
  detectDatetime?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "CosmosDbSqlApiSource";
}

@doc("A copy activity Dynamics source.")
model DynamicsSource extends CopySource {
  @doc("FetchXML is a proprietary query language that is used in Microsoft Dynamics (online & on-premises). Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "DynamicsSource";
}

@doc("A copy activity Dynamics CRM source.")
model DynamicsCrmSource extends CopySource {
  @doc("FetchXML is a proprietary query language that is used in Microsoft Dynamics CRM (online & on-premises). Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "DynamicsCrmSource";
}

@doc("A copy activity Common Data Service for Apps source.")
model CommonDataServiceForAppsSource extends CopySource {
  @doc("FetchXML is a proprietary query language that is used in Microsoft Common Data Service for Apps (online & on-premises). Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "CommonDataServiceForAppsSource";
}

@doc("A copy activity source for various relational databases.")
model RelationalSource extends CopySource {
  @doc("Database query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "RelationalSource";
}

@doc("A copy activity source for Informix.")
model InformixSource extends TabularSource {
  @doc("Database query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "InformixSource";
}

@doc("A copy activity source for Microsoft Access.")
model MicrosoftAccessSource extends CopySource {
  @doc("Database query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "MicrosoftAccessSource";
}

@doc("A copy activity source for Db2 databases.")
model Db2Source extends TabularSource {
  @doc("Database query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "Db2Source";
}

@doc("A copy activity source for ODBC databases.")
model OdbcSource extends TabularSource {
  @doc("Database query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "OdbcSource";
}

@doc("A copy activity source for MySQL databases.")
model MySqlSource extends TabularSource {
  @doc("Database query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "MySqlSource";
}

@doc("A copy activity source for PostgreSQL databases.")
model PostgreSqlSource extends TabularSource {
  @doc("Database query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "PostgreSqlSource";
}

@doc("A copy activity source for Sybase databases.")
model SybaseSource extends TabularSource {
  @doc("Database query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "SybaseSource";
}

@doc("A copy activity source for SapBW server via MDX.")
model SapBwSource extends TabularSource {
  @doc("MDX query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "SapBwSource";
}

@doc("A copy activity source for OData source.")
model ODataSource extends CopySource {
  @doc("OData query. For example, \"$top=1\". Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:05:00. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  httpRequestTimeout?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "ODataSource";
}

@doc("A copy activity Salesforce source.")
model SalesforceSource extends TabularSource {
  @doc("Database query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("The read behavior for the operation. Default is Query. Allowed values: Query/QueryAll. Type: string (or Expression with resultType string).")
  readBehavior?: Record<unknown>;

  @doc("Copy source type.")
  type: "SalesforceSource";
}

@doc("A copy activity Salesforce Service Cloud source.")
model SalesforceServiceCloudSource extends CopySource {
  @doc("Database query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("The read behavior for the operation. Default is Query. Allowed values: Query/QueryAll. Type: string (or Expression with resultType string).")
  readBehavior?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "SalesforceServiceCloudSource";
}

@doc("A copy activity source for SAP Cloud for Customer source.")
model SapCloudForCustomerSource extends TabularSource {
  @doc("SAP Cloud for Customer OData query. For example, \"$top=1\". Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:05:00. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  httpRequestTimeout?: Record<unknown>;

  @doc("Copy source type.")
  type: "SapCloudForCustomerSource";
}

@doc("A copy activity source for SAP ECC source.")
model SapEccSource extends TabularSource {
  @doc("SAP ECC OData query. For example, \"$top=1\". Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:05:00. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  httpRequestTimeout?: Record<unknown>;

  @doc("Copy source type.")
  type: "SapEccSource";
}

@doc("A copy activity source for SAP HANA source.")
model SapHanaSource extends TabularSource {
  @doc("SAP HANA Sql query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("The packet size of data read from SAP HANA. Type: integer(or Expression with resultType integer).")
  packetSize?: Record<unknown>;

  @doc("The partition mechanism that will be used for SAP HANA read in parallel. Possible values include: \"None\", \"PhysicalPartitionsOfTable\", \"SapHanaDynamicRange\". ")
  partitionOption?: Record<unknown>;

  @doc("The settings that will be leveraged for SAP HANA source partitioning.")
  partitionSettings?: SapHanaPartitionSettings;

  @doc("Copy source type.")
  type: "SapHanaSource";
}

@doc("The settings that will be leveraged for SAP HANA source partitioning.")
model SapHanaPartitionSettings {
  @doc("The name of the column that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).")
  partitionColumnName?: Record<unknown>;
}

@doc("A copy activity source for SAP Business Warehouse Open Hub Destination source.")
model SapOpenHubSource extends TabularSource {
  @doc("Whether to exclude the records of the last request. The default value is true. Type: boolean (or Expression with resultType boolean).")
  excludeLastRequest?: Record<unknown>;

  @doc("The ID of request for delta loading. Once it is set, only data with requestId larger than the value of this property will be retrieved. The default value is 0. Type: integer (or Expression with resultType integer ).")
  baseRequestId?: Record<unknown>;

  @doc("Specifies the custom RFC function module that will be used to read data from SAP Table. Type: string (or Expression with resultType string).")
  customRfcReadTableFunctionModule?: Record<unknown>;

  @doc("The single character that will be used as delimiter passed to SAP RFC as well as splitting the output data retrieved. Type: string (or Expression with resultType string).")
  sapDataColumnDelimiter?: Record<unknown>;

  @doc("Copy source type.")
  type: "SapOpenHubSource";
}

@doc("A copy activity source for SAP ODP source.")
model SapOdpSource extends TabularSource {
  @doc("The extraction mode. Allowed value include: Full, Delta and Recovery. The default value is Full. Type: string (or Expression with resultType string).")
  extractionMode?: Record<unknown>;

  @doc("The subscriber process to manage the delta process. Type: string (or Expression with resultType string).")
  subscriberProcess?: Record<unknown>;

  @doc("Specifies the selection conditions from source data. Type: array of objects(selection) (or Expression with resultType array of objects).")
  selection?: Record<unknown>;

  @doc("Specifies the columns to be selected from source data. Type: array of objects(projection) (or Expression with resultType array of objects).")
  `projection`?: Record<unknown>;

  @doc("Copy source type.")
  type: "SapOdpSource";
}

@doc("A copy activity source for SAP Table source.")
model SapTableSource extends TabularSource {
  @doc("The number of rows to be retrieved. Type: integer(or Expression with resultType integer).")
  rowCount?: Record<unknown>;

  @doc("The number of rows that will be skipped. Type: integer (or Expression with resultType integer).")
  rowSkips?: Record<unknown>;

  @doc("The fields of the SAP table that will be retrieved. For example, column0, column1. Type: string (or Expression with resultType string).")
  rfcTableFields?: Record<unknown>;

  @doc("The options for the filtering of the SAP Table. For example, COLUMN0 EQ SOME VALUE. Type: string (or Expression with resultType string).")
  rfcTableOptions?: Record<unknown>;

  @doc("Specifies the maximum number of rows that will be retrieved at a time when retrieving data from SAP Table. Type: integer (or Expression with resultType integer).")
  batchSize?: Record<unknown>;

  @doc("Specifies the custom RFC function module that will be used to read data from SAP Table. Type: string (or Expression with resultType string).")
  customRfcReadTableFunctionModule?: Record<unknown>;

  @doc("The single character that will be used as delimiter passed to SAP RFC as well as splitting the output data retrieved. Type: string (or Expression with resultType string).")
  sapDataColumnDelimiter?: Record<unknown>;

  @doc("The partition mechanism that will be used for SAP table read in parallel. Possible values include: \"None\", \"PartitionOnInt\", \"PartitionOnCalendarYear\", \"PartitionOnCalendarMonth\", \"PartitionOnCalendarDate\", \"PartitionOnTime\".")
  partitionOption?: Record<unknown>;

  @doc("The settings that will be leveraged for SAP table source partitioning.")
  partitionSettings?: SapTablePartitionSettings;

  @doc("Copy source type.")
  type: "SapTableSource";
}

@doc("The settings that will be leveraged for SAP table source partitioning.")
model SapTablePartitionSettings {
  @doc("The name of the column that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).")
  partitionColumnName?: Record<unknown>;

  @doc("The maximum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).")
  partitionUpperBound?: Record<unknown>;

  @doc("The minimum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).")
  partitionLowerBound?: Record<unknown>;

  @doc("The maximum value of partitions the table will be split into. Type: integer (or Expression with resultType string).")
  maxPartitionsNumber?: Record<unknown>;
}

@doc("A copy activity Rest service Sink.")
model RestSink extends CopySink {
  @doc("The HTTP method used to call the RESTful API. The default is POST. Type: string (or Expression with resultType string).")
  requestMethod?: Record<unknown>;

  @doc("The additional HTTP headers in the request to the RESTful API. Type: string (or Expression with resultType string).")
  additionalHeaders?: Record<unknown>;

  @doc("The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:01:40. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  httpRequestTimeout?: Record<unknown>;

  @doc("The time to await before sending next request, in milliseconds ")
  requestInterval?: Record<unknown>;

  @doc("Http Compression Type to Send data in compressed format with Optimal Compression Level, Default is None. And The Only Supported option is Gzip. ")
  httpCompressionType?: Record<unknown>;

  @doc("Copy sink type.")
  type: "RestSink";
}

@doc("A copy activity Rest service source.")
model RestSource extends CopySource {
  @doc("The HTTP method used to call the RESTful API. The default is GET. Type: string (or Expression with resultType string).")
  requestMethod?: Record<unknown>;

  @doc("The HTTP request body to the RESTful API if requestMethod is POST. Type: string (or Expression with resultType string).")
  requestBody?: Record<unknown>;

  @doc("The additional HTTP headers in the request to the RESTful API. Type: string (or Expression with resultType string).")
  additionalHeaders?: Record<unknown>;

  @doc("The pagination rules to compose next page requests. Type: string (or Expression with resultType string).")
  paginationRules?: Record<unknown>;

  @doc("The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:01:40. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  httpRequestTimeout?: Record<unknown>;

  @doc("The time to await before sending next page request. ")
  requestInterval?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "RestSource";
}

@doc("A copy activity SQL source.")
model SqlSource extends TabularSource {
  @doc("SQL reader query. Type: string (or Expression with resultType string).")
  sqlReaderQuery?: Record<unknown>;

  @doc("Name of the stored procedure for a SQL Database source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).")
  sqlReaderStoredProcedureName?: Record<unknown>;

  @doc("Value and type setting for stored procedure parameters. Example: \"{Parameter1: {value: \"1\", type: \"int\"}}\".")
  storedProcedureParameters?: Record<unknown>;

  @doc("Specifies the transaction locking behavior for the SQL source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).")
  isolationLevel?: Record<unknown>;

  @doc("The partition mechanism that will be used for Sql read in parallel. Possible values include: \"None\", \"PhysicalPartitionsOfTable\", \"DynamicRange\".")
  partitionOption?: Record<unknown>;

  @doc("The settings that will be leveraged for Sql source partitioning.")
  partitionSettings?: SqlPartitionSettings;

  @doc("Copy source type.")
  type: "SqlSource";
}

@doc("The settings that will be leveraged for Sql source partitioning.")
model SqlPartitionSettings {
  @doc("The name of the column in integer or datetime type that will be used for proceeding partitioning. If not specified, the primary key of the table is auto-detected and used as the partition column. Type: string (or Expression with resultType string).")
  partitionColumnName?: Record<unknown>;

  @doc("The maximum value of the partition column for partition range splitting. This value is used to decide the partition stride, not for filtering the rows in table. All rows in the table or query result will be partitioned and copied. Type: string (or Expression with resultType string).")
  partitionUpperBound?: Record<unknown>;

  @doc("The minimum value of the partition column for partition range splitting. This value is used to decide the partition stride, not for filtering the rows in table. All rows in the table or query result will be partitioned and copied. Type: string (or Expression with resultType string).")
  partitionLowerBound?: Record<unknown>;
}

@doc("A copy activity SQL server source.")
model SqlServerSource extends TabularSource {
  @doc("SQL reader query. Type: string (or Expression with resultType string).")
  sqlReaderQuery?: Record<unknown>;

  @doc("Name of the stored procedure for a SQL Database source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).")
  sqlReaderStoredProcedureName?: Record<unknown>;

  @doc("Value and type setting for stored procedure parameters. Example: \"{Parameter1: {value: \"1\", type: \"int\"}}\".")
  storedProcedureParameters?: Record<unknown>;

  @doc("Specifies the transaction locking behavior for the SQL source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).")
  isolationLevel?: Record<unknown>;

  @doc("Which additional types to produce.")
  produceAdditionalTypes?: Record<unknown>;

  @doc("The partition mechanism that will be used for Sql read in parallel. Possible values include: \"None\", \"PhysicalPartitionsOfTable\", \"DynamicRange\".")
  partitionOption?: Record<unknown>;

  @doc("The settings that will be leveraged for Sql source partitioning.")
  partitionSettings?: SqlPartitionSettings;

  @doc("Copy source type.")
  type: "SqlServerSource";
}

@doc("A copy activity Amazon RDS for SQL Server source.")
model AmazonRdsForSqlServerSource extends TabularSource {
  @doc("SQL reader query. Type: string (or Expression with resultType string).")
  sqlReaderQuery?: Record<unknown>;

  @doc("Name of the stored procedure for a SQL Database source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).")
  sqlReaderStoredProcedureName?: Record<unknown>;

  @doc("Value and type setting for stored procedure parameters. Example: \"{Parameter1: {value: \"1\", type: \"int\"}}\".")
  storedProcedureParameters?: Record<unknown>;

  @doc("Specifies the transaction locking behavior for the SQL source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).")
  isolationLevel?: Record<unknown>;

  @doc("Which additional types to produce.")
  produceAdditionalTypes?: Record<unknown>;

  @doc("The partition mechanism that will be used for Sql read in parallel. Possible values include: \"None\", \"PhysicalPartitionsOfTable\", \"DynamicRange\".")
  partitionOption?: Record<unknown>;

  @doc("The settings that will be leveraged for Sql source partitioning.")
  partitionSettings?: SqlPartitionSettings;

  @doc("Copy source type.")
  type: "AmazonRdsForSqlServerSource";
}

@doc("A copy activity Azure SQL source.")
model AzureSqlSource extends TabularSource {
  @doc("SQL reader query. Type: string (or Expression with resultType string).")
  sqlReaderQuery?: Record<unknown>;

  @doc("Name of the stored procedure for a SQL Database source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).")
  sqlReaderStoredProcedureName?: Record<unknown>;

  @doc("Value and type setting for stored procedure parameters. Example: \"{Parameter1: {value: \"1\", type: \"int\"}}\".")
  storedProcedureParameters?: Record<unknown>;

  @doc("Specifies the transaction locking behavior for the SQL source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).")
  isolationLevel?: Record<unknown>;

  @doc("Which additional types to produce.")
  produceAdditionalTypes?: Record<unknown>;

  @doc("The partition mechanism that will be used for Sql read in parallel. Possible values include: \"None\", \"PhysicalPartitionsOfTable\", \"DynamicRange\".")
  partitionOption?: Record<unknown>;

  @doc("The settings that will be leveraged for Sql source partitioning.")
  partitionSettings?: SqlPartitionSettings;

  @doc("Copy source type.")
  type: "AzureSqlSource";
}

@doc("A copy activity Azure SQL Managed Instance source.")
model SqlMISource extends TabularSource {
  @doc("SQL reader query. Type: string (or Expression with resultType string).")
  sqlReaderQuery?: Record<unknown>;

  @doc("Name of the stored procedure for a Azure SQL Managed Instance source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).")
  sqlReaderStoredProcedureName?: Record<unknown>;

  @doc("Value and type setting for stored procedure parameters. Example: \"{Parameter1: {value: \"1\", type: \"int\"}}\".")
  storedProcedureParameters?: Record<unknown>;

  @doc("Specifies the transaction locking behavior for the SQL source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).")
  isolationLevel?: Record<unknown>;

  @doc("Which additional types to produce.")
  produceAdditionalTypes?: Record<unknown>;

  @doc("The partition mechanism that will be used for Sql read in parallel. Possible values include: \"None\", \"PhysicalPartitionsOfTable\", \"DynamicRange\".")
  partitionOption?: Record<unknown>;

  @doc("The settings that will be leveraged for Sql source partitioning.")
  partitionSettings?: SqlPartitionSettings;

  @doc("Copy source type.")
  type: "SqlMISource";
}

@doc("A copy activity SQL Data Warehouse source.")
model SqlDWSource extends TabularSource {
  @doc("SQL Data Warehouse reader query. Type: string (or Expression with resultType string).")
  sqlReaderQuery?: Record<unknown>;

  @doc("Name of the stored procedure for a SQL Data Warehouse source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).")
  sqlReaderStoredProcedureName?: Record<unknown>;

  @doc("Value and type setting for stored procedure parameters. Example: \"{Parameter1: {value: \"1\", type: \"int\"}}\". Type: object (or Expression with resultType object), itemType: StoredProcedureParameter.")
  storedProcedureParameters?: Record<unknown>;

  @doc("Specifies the transaction locking behavior for the SQL source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).")
  isolationLevel?: Record<unknown>;

  @doc("The partition mechanism that will be used for Sql read in parallel. Possible values include: \"None\", \"PhysicalPartitionsOfTable\", \"DynamicRange\".")
  partitionOption?: Record<unknown>;

  @doc("The settings that will be leveraged for Sql source partitioning.")
  partitionSettings?: SqlPartitionSettings;

  @doc("Copy source type.")
  type: "SqlDWSource";
}

@doc("A copy activity file system source.")
model FileSystemSource extends CopySource {
  @doc("If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "FileSystemSource";
}

@doc("A copy activity HDFS source.")
model HdfsSource extends CopySource {
  @doc("If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("Specifies Distcp-related settings.")
  distcpSettings?: DistcpSettings;

  @doc("Copy source type.")
  type: "HdfsSource";
}

@doc("A copy activity Azure MySQL source.")
model AzureMySqlSource extends TabularSource {
  @doc("Database query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "AzureMySqlSource";
}

@doc("A copy activity Azure Data Explorer (Kusto) source.")
model AzureDataExplorerSource extends CopySource {
  @doc("Database query. Should be a Kusto Query Language (KQL) query. Type: string (or Expression with resultType string).")
  query: Record<unknown>;

  @doc("The name of the Boolean option that controls whether truncation is applied to result-sets that go beyond a certain row-count limit.")
  noTruncation?: Record<unknown>;

  @doc("Query timeout. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9]))..")
  queryTimeout?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "AzureDataExplorerSource";
}

@doc("A copy activity Oracle source.")
model OracleSource extends CopySource {
  @doc("Oracle reader query. Type: string (or Expression with resultType string).")
  oracleReaderQuery?: Record<unknown>;

  @doc("Query timeout. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  queryTimeout?: Record<unknown>;

  @doc("The partition mechanism that will be used for Oracle read in parallel. Possible values include: \"None\", \"PhysicalPartitionsOfTable\", \"DynamicRange\".")
  partitionOption?: Record<unknown>;

  @doc("The settings that will be leveraged for Oracle source partitioning.")
  partitionSettings?: OraclePartitionSettings;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "OracleSource";
}

@doc("The settings that will be leveraged for Oracle source partitioning.")
model OraclePartitionSettings {
  @doc("Names of the physical partitions of Oracle table. ")
  partitionNames?: Record<unknown>;

  @doc("The name of the column in integer type that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).")
  partitionColumnName?: Record<unknown>;

  @doc("The maximum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).")
  partitionUpperBound?: Record<unknown>;

  @doc("The minimum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).")
  partitionLowerBound?: Record<unknown>;
}

@doc("A copy activity AmazonRdsForOracle source.")
model AmazonRdsForOracleSource extends CopySource {
  @doc("AmazonRdsForOracle reader query. Type: string (or Expression with resultType string).")
  oracleReaderQuery?: Record<unknown>;

  @doc("Query timeout. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  queryTimeout?: Record<unknown>;

  @doc("The partition mechanism that will be used for AmazonRdsForOracle read in parallel. Type: string (or Expression with resultType string).")
  partitionOption?: Record<unknown>;

  @doc("The settings that will be leveraged for AmazonRdsForOracle source partitioning.")
  partitionSettings?: AmazonRdsForOraclePartitionSettings;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "AmazonRdsForOracleSource";
}

@doc("The settings that will be leveraged for AmazonRdsForOracle source partitioning.")
model AmazonRdsForOraclePartitionSettings {
  @doc("Names of the physical partitions of AmazonRdsForOracle table. ")
  partitionNames?: Record<unknown>;

  @doc("The name of the column in integer type that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).")
  partitionColumnName?: Record<unknown>;

  @doc("The maximum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).")
  partitionUpperBound?: Record<unknown>;

  @doc("The minimum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).")
  partitionLowerBound?: Record<unknown>;
}

@doc("A copy activity Teradata source.")
model TeradataSource extends TabularSource {
  @doc("Teradata query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("The partition mechanism that will be used for teradata read in parallel. Possible values include: \"None\", \"Hash\", \"DynamicRange\".")
  partitionOption?: Record<unknown>;

  @doc("The settings that will be leveraged for teradata source partitioning.")
  partitionSettings?: TeradataPartitionSettings;

  @doc("Copy source type.")
  type: "TeradataSource";
}

@doc("The settings that will be leveraged for teradata source partitioning.")
model TeradataPartitionSettings {
  @doc("The name of the column that will be used for proceeding range or hash partitioning. Type: string (or Expression with resultType string).")
  partitionColumnName?: Record<unknown>;

  @doc("The maximum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).")
  partitionUpperBound?: Record<unknown>;

  @doc("The minimum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).")
  partitionLowerBound?: Record<unknown>;
}

@doc("A copy activity source for web page table.")
model WebSource extends CopySource {
  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "WebSource";
}

@doc("A copy activity source for a Cassandra database.")
model CassandraSource extends TabularSource {
  @doc("Database query. Should be a SQL-92 query expression or Cassandra Query Language (CQL) command. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("The consistency level specifies how many Cassandra servers must respond to a read request before returning data to the client application. Cassandra checks the specified number of Cassandra servers for data to satisfy the read request. Must be one of cassandraSourceReadConsistencyLevels. The default value is 'ONE'. It is case-insensitive.")
  consistencyLevel?: CassandraSourceReadConsistencyLevels;

  @doc("Copy source type.")
  type: "CassandraSource";
}

@doc("A copy activity source for a MongoDB database.")
model MongoDbSource extends CopySource {
  @doc("Database query. Should be a SQL-92 query expression. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "MongoDbSource";
}

@doc("A copy activity source for a MongoDB Atlas database.")
model MongoDbAtlasSource extends CopySource {
  @doc("Specifies selection filter using query operators. To return all documents in a collection, omit this parameter or pass an empty document ({}). Type: string (or Expression with resultType string).")
  filter?: Record<unknown>;

  @doc("Cursor methods for Mongodb query")
  cursorMethods?: MongoDbCursorMethodsProperties;

  @doc("Specifies the number of documents to return in each batch of the response from MongoDB Atlas instance. In most cases, modifying the batch size will not affect the user or the application. This property's main purpose is to avoid hit the limitation of response size. Type: integer (or Expression with resultType integer).")
  batchSize?: Record<unknown>;

  @doc("Query timeout. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  queryTimeout?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "MongoDbAtlasSource";
}

@doc("Cursor methods for Mongodb query")
model MongoDbCursorMethodsProperties extends Record<Record<unknown>> {
  @doc("Specifies the fields to return in the documents that match the query filter. To return all fields in the matching documents, omit this parameter. Type: string (or Expression with resultType string).")
  project?: Record<unknown>;

  @doc("Specifies the order in which the query returns matching documents. Type: string (or Expression with resultType string). Type: string (or Expression with resultType string).")
  sort?: Record<unknown>;

  @doc("Specifies the how many documents skipped and where MongoDB begins returning results. This approach may be useful in implementing paginated results. Type: integer (or Expression with resultType integer).")
  skip?: Record<unknown>;

  @doc("Specifies the maximum number of documents the server returns. limit() is analogous to the LIMIT statement in a SQL database. Type: integer (or Expression with resultType integer).")
  limit?: Record<unknown>;
}

@doc("A copy activity source for a MongoDB database.")
model MongoDbV2Source extends CopySource {
  @doc("Specifies selection filter using query operators. To return all documents in a collection, omit this parameter or pass an empty document ({}). Type: string (or Expression with resultType string).")
  filter?: Record<unknown>;

  @doc("Cursor methods for Mongodb query")
  cursorMethods?: MongoDbCursorMethodsProperties;

  @doc("Specifies the number of documents to return in each batch of the response from MongoDB instance. In most cases, modifying the batch size will not affect the user or the application. This property's main purpose is to avoid hit the limitation of response size. Type: integer (or Expression with resultType integer).")
  batchSize?: Record<unknown>;

  @doc("Query timeout. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  queryTimeout?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "MongoDbV2Source";
}

@doc("A copy activity source for a CosmosDB (MongoDB API) database.")
model CosmosDbMongoDbApiSource extends CopySource {
  @doc("Specifies selection filter using query operators. To return all documents in a collection, omit this parameter or pass an empty document ({}). Type: string (or Expression with resultType string).")
  filter?: Record<unknown>;

  @doc("Cursor methods for Mongodb query.")
  cursorMethods?: MongoDbCursorMethodsProperties;

  @doc("Specifies the number of documents to return in each batch of the response from MongoDB instance. In most cases, modifying the batch size will not affect the user or the application. This property's main purpose is to avoid hit the limitation of response size. Type: integer (or Expression with resultType integer).")
  batchSize?: Record<unknown>;

  @doc("Query timeout. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  queryTimeout?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "CosmosDbMongoDbApiSource";
}

@doc("A copy activity source for an Office 365 service.")
model Office365Source extends CopySource {
  @doc("The groups containing all the users. Type: array of strings (or Expression with resultType array of strings).")
  allowedGroups?: Record<unknown>;

  @doc("The user scope uri. Type: string (or Expression with resultType string).")
  userScopeFilterUri?: Record<unknown>;

  @doc("The Column to apply the <paramref name=\"StartTime\"/> and <paramref name=\"EndTime\"/>. Type: string (or Expression with resultType string).")
  dateFilterColumn?: Record<unknown>;

  @doc("Start time of the requested range for this dataset. Type: string (or Expression with resultType string).")
  startTime?: Record<unknown>;

  @doc("End time of the requested range for this dataset. Type: string (or Expression with resultType string).")
  endTime?: Record<unknown>;

  @doc("The columns to be read out from the Office 365 table. Type: array of objects (or Expression with resultType array of objects). itemType: OutputColumn. Example: [ { \"name\": \"Id\" }, { \"name\": \"CreatedDateTime\" } ]")
  outputColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "Office365Source";
}

@doc("The columns to be read out from the Office 365 table.")
model OutputColumn {
  @doc("Name of the table column. Type: string.")
  name?: string;
}

@doc("A copy activity Azure Data Lake source.")
model AzureDataLakeStoreSource extends CopySource {
  @doc("If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("Copy source type.")
  type: "AzureDataLakeStoreSource";
}

@doc("A copy activity Azure BlobFS source.")
model AzureBlobFSSource extends CopySource {
  @doc("Treat empty as null. Type: boolean (or Expression with resultType boolean).")
  treatEmptyAsNull?: Record<unknown>;

  @doc("Number of header lines to skip from each blob. Type: integer (or Expression with resultType integer).")
  skipHeaderLineCount?: Record<unknown>;

  @doc("If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("Copy source type.")
  type: "AzureBlobFSSource";
}

@doc("A copy activity source for an HTTP file.")
model HttpSource extends CopySource {
  @doc("Specifies the timeout for a HTTP client to get HTTP response from HTTP server. The default value is equivalent to System.Net.HttpWebRequest.Timeout. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  httpRequestTimeout?: Record<unknown>;

  @doc("Copy source type.")
  type: "HttpSource";
}

@doc("A copy activity Amazon Marketplace Web Service source.")
model AmazonMWSSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "AmazonMWSSource";
}

@doc("A copy activity Azure PostgreSQL source.")
model AzurePostgreSqlSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "AzurePostgreSqlSource";
}

@doc("A copy activity Azure PostgreSQL sink.")
model AzurePostgreSqlSink extends CopySink {
  @doc("A query to execute before starting the copy. Type: string (or Expression with resultType string).")
  preCopyScript?: Record<unknown>;

  @doc("Copy sink type.")
  type: "AzurePostgreSqlSink";
}

@doc("A copy activity Azure MySql sink.")
model AzureMySqlSink extends CopySink {
  @doc("A query to execute before starting the copy. Type: string (or Expression with resultType string).")
  preCopyScript?: Record<unknown>;

  @doc("Copy sink type.")
  type: "AzureMySqlSink";
}

@doc("A copy activity Concur Service source.")
model ConcurSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "ConcurSource";
}

@doc("A copy activity Couchbase server source.")
model CouchbaseSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "CouchbaseSource";
}

@doc("A copy activity Drill server source.")
model DrillSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "DrillSource";
}

@doc("A copy activity Eloqua server source.")
model EloquaSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "EloquaSource";
}

@doc("A copy activity Google BigQuery service source.")
model GoogleBigQuerySource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "GoogleBigQuerySource";
}

@doc("A copy activity Greenplum Database source.")
model GreenplumSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "GreenplumSource";
}

@doc("A copy activity HBase server source.")
model HBaseSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "HBaseSource";
}

@doc("A copy activity Hive Server source.")
model HiveSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "HiveSource";
}

@doc("A copy activity Hubspot Service source.")
model HubspotSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "HubspotSource";
}

@doc("A copy activity Impala server source.")
model ImpalaSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "ImpalaSource";
}

@doc("A copy activity Jira Service source.")
model JiraSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "JiraSource";
}

@doc("A copy activity Magento server source.")
model MagentoSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "MagentoSource";
}

@doc("A copy activity MariaDB server source.")
model MariaDBSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "MariaDBSource";
}

@doc("A copy activity Azure MariaDB source.")
model AzureMariaDBSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "AzureMariaDBSource";
}

@doc("A copy activity Marketo server source.")
model MarketoSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "MarketoSource";
}

@doc("A copy activity Paypal Service source.")
model PaypalSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "PaypalSource";
}

@doc("A copy activity Phoenix server source.")
model PhoenixSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "PhoenixSource";
}

@doc("A copy activity Presto server source.")
model PrestoSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "PrestoSource";
}

@doc("A copy activity QuickBooks server source.")
model QuickBooksSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "QuickBooksSource";
}

@doc("A copy activity ServiceNow server source.")
model ServiceNowSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "ServiceNowSource";
}

@doc("A copy activity Shopify Service source.")
model ShopifySource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "ShopifySource";
}

@doc("A copy activity Spark Server source.")
model SparkSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "SparkSource";
}

@doc("A copy activity Square Service source.")
model SquareSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "SquareSource";
}

@doc("A copy activity Xero Service source.")
model XeroSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "XeroSource";
}

@doc("A copy activity Zoho server source.")
model ZohoSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "ZohoSource";
}

@doc("A copy activity Netezza source.")
model NetezzaSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("The partition mechanism that will be used for Netezza read in parallel. Possible values include: \"None\", \"DataSlice\", \"DynamicRange\".")
  partitionOption?: Record<unknown>;

  @doc("The settings that will be leveraged for Netezza source partitioning.")
  partitionSettings?: NetezzaPartitionSettings;

  @doc("Copy source type.")
  type: "NetezzaSource";
}

@doc("The settings that will be leveraged for Netezza source partitioning.")
model NetezzaPartitionSettings {
  @doc("The name of the column in integer type that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).")
  partitionColumnName?: Record<unknown>;

  @doc("The maximum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).")
  partitionUpperBound?: Record<unknown>;

  @doc("The minimum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).")
  partitionLowerBound?: Record<unknown>;
}

@doc("A copy activity Vertica source.")
model VerticaSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "VerticaSource";
}

@doc("A copy activity Salesforce Marketing Cloud source.")
model SalesforceMarketingCloudSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "SalesforceMarketingCloudSource";
}

@doc("A copy activity Responsys source.")
model ResponsysSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "ResponsysSource";
}

@doc("A copy activity Dynamics AX source.")
model DynamicsAXSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:05:00. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  httpRequestTimeout?: Record<unknown>;

  @doc("Copy source type.")
  type: "DynamicsAXSource";
}

@doc("A copy activity Oracle Service Cloud source.")
model OracleServiceCloudSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "OracleServiceCloudSource";
}

@doc("A copy activity Google AdWords service source.")
model GoogleAdWordsSource extends TabularSource {
  @doc("A query to retrieve data from source. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Copy source type.")
  type: "GoogleAdWordsSource";
}

@doc("A copy activity source for Amazon Redshift Source.")
model AmazonRedshiftSource extends TabularSource {
  @doc("Database query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("The Amazon S3 settings needed for the interim Amazon S3 when copying from Amazon Redshift with unload. With this, data from Amazon Redshift source will be unloaded into S3 first and then copied into the targeted sink from the interim S3.")
  redshiftUnloadSettings?: RedshiftUnloadSettings;

  @doc("Copy source type.")
  type: "AmazonRedshiftSource";
}

@doc("The Amazon S3 settings needed for the interim Amazon S3 when copying from Amazon Redshift with unload. With this, data from Amazon Redshift source will be unloaded into S3 first and then copied into the targeted sink from the interim S3.")
model RedshiftUnloadSettings {
  @doc("The name of the Amazon S3 linked service which will be used for the unload operation when copying from the Amazon Redshift source.")
  s3LinkedServiceName: LinkedServiceReference;

  @doc("The bucket of the interim Amazon S3 which will be used to store the unloaded data from Amazon Redshift source. The bucket must be in the same region as the Amazon Redshift source. Type: string (or Expression with resultType string).")
  bucketName: Record<unknown>;
}

@doc("A copy activity source for Microsoft Fabric LakeHouse Table.")
model LakeHouseTableSource extends CopySource {
  @doc("Query an older snapshot by timestamp. Type: string (or Expression with resultType string).")
  timestampAsOf?: Record<unknown>;

  @doc("Query an older snapshot by version. Type: integer (or Expression with resultType integer).")
  versionAsOf?: Record<unknown>;

  @doc("Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).")
  additionalColumns?: Record<unknown>;

  @doc("Copy source type.")
  type: "LakeHouseTableSource";
}

@doc("A copy activity snowflake source.")
model SnowflakeSource extends CopySource {
  @doc("Snowflake Sql query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Snowflake export settings.")
  exportSettings: SnowflakeExportCopyCommand;

  @doc("Copy source type.")
  type: "SnowflakeSource";
}

@doc("Snowflake export command settings.")
model SnowflakeExportCopyCommand extends ExportSettings {
  @doc("Additional copy options directly passed to snowflake Copy Command. Type: key value pairs (value should be string type) (or Expression with resultType object). Example: \"additionalCopyOptions\": { \"DATE_FORMAT\": \"MM/DD/YYYY\", \"TIME_FORMAT\": \"'HH24:MI:SS.FF'\" }")
  additionalCopyOptions?: Record<Record<unknown>>;

  @doc("Additional format options directly passed to snowflake Copy Command. Type: key value pairs (value should be string type) (or Expression with resultType object). Example: \"additionalFormatOptions\": { \"OVERWRITE\": \"TRUE\", \"MAX_FILE_SIZE\": \"'FALSE'\" }")
  additionalFormatOptions?: Record<Record<unknown>>;

  @doc("The export setting type.")
  type: "SnowflakeExportCopyCommand";
}

@doc("Export command settings.")
@discriminator("type")
model ExportSettings extends Record<Record<unknown>> {}

@doc("A copy activity Azure Databricks Delta Lake source.")
model AzureDatabricksDeltaLakeSource extends CopySource {
  @doc("Azure Databricks Delta Lake Sql query. Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("Azure Databricks Delta Lake export settings.")
  exportSettings?: AzureDatabricksDeltaLakeExportCommand;

  @doc("Copy source type.")
  type: "AzureDatabricksDeltaLakeSource";
}

@doc("Azure Databricks Delta Lake export command settings.")
model AzureDatabricksDeltaLakeExportCommand extends ExportSettings {
  @doc("Specify the date format for the csv in Azure Databricks Delta Lake Copy. Type: string (or Expression with resultType string).")
  dateFormat?: Record<unknown>;

  @doc("Specify the timestamp format for the csv in Azure Databricks Delta Lake Copy. Type: string (or Expression with resultType string).")
  timestampFormat?: Record<unknown>;

  @doc("The export setting type.")
  type: "AzureDatabricksDeltaLakeExportCommand";
}

@doc("A copy activity Azure Databricks Delta Lake sink.")
model AzureDatabricksDeltaLakeSink extends CopySink {
  @doc("SQL pre-copy script. Type: string (or Expression with resultType string).")
  preCopyScript?: Record<unknown>;

  @doc("Azure Databricks Delta Lake import settings.")
  importSettings?: AzureDatabricksDeltaLakeImportCommand;

  @doc("Copy sink type.")
  type: "AzureDatabricksDeltaLakeSink";
}

@doc("Azure Databricks Delta Lake import command settings.")
model AzureDatabricksDeltaLakeImportCommand extends ImportSettings {
  @doc("Specify the date format for csv in Azure Databricks Delta Lake Copy. Type: string (or Expression with resultType string).")
  dateFormat?: Record<unknown>;

  @doc("Specify the timestamp format for csv in Azure Databricks Delta Lake Copy. Type: string (or Expression with resultType string).")
  timestampFormat?: Record<unknown>;

  @doc("The import setting type.")
  type: "AzureDatabricksDeltaLakeImportCommand";
}

@doc("Import command settings.")
@discriminator("type")
model ImportSettings extends Record<Record<unknown>> {}

@doc("SQL stored procedure parameter.")
model StoredProcedureParameter {
  @doc("Stored procedure parameter value. Type: string (or Expression with resultType string).")
  value?: Record<unknown>;

  @doc("Stored procedure parameter type.")
  type?: StoredProcedureParameterType;
}

@doc("A copy activity SAP Cloud for Customer sink.")
model SapCloudForCustomerSink extends CopySink {
  @doc("The write behavior for the operation. Default is 'Insert'.")
  writeBehavior?: SapCloudForCustomerSinkWriteBehavior;

  @doc("The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:05:00. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  httpRequestTimeout?: Record<unknown>;

  @doc("Copy sink type.")
  type: "SapCloudForCustomerSink";
}

@doc("A copy activity Azure Queue sink.")
model AzureQueueSink extends CopySink {
  @doc("Copy sink type.")
  type: "AzureQueueSink";
}

@doc("A copy activity Azure Table sink.")
model AzureTableSink extends CopySink {
  @doc("Azure Table default partition key value. Type: string (or Expression with resultType string).")
  azureTableDefaultPartitionKeyValue?: Record<unknown>;

  @doc("Azure Table partition key name. Type: string (or Expression with resultType string).")
  azureTablePartitionKeyName?: Record<unknown>;

  @doc("Azure Table row key name. Type: string (or Expression with resultType string).")
  azureTableRowKeyName?: Record<unknown>;

  @doc("Azure Table insert type. Type: string (or Expression with resultType string).")
  azureTableInsertType?: Record<unknown>;

  @doc("Copy sink type.")
  type: "AzureTableSink";
}

@doc("A copy activity Avro sink.")
model AvroSink extends CopySink {
  @doc("Avro store settings.")
  storeSettings?: StoreWriteSettings;

  @doc("Avro format settings.")
  formatSettings?: AvroWriteSettings;

  @doc("Copy sink type.")
  type: "AvroSink";
}

@doc("A copy activity Parquet sink.")
model ParquetSink extends CopySink {
  @doc("Parquet store settings.")
  storeSettings?: StoreWriteSettings;

  @doc("Parquet format settings.")
  formatSettings?: ParquetWriteSettings;

  @doc("Copy sink type.")
  type: "ParquetSink";
}

@doc("A copy activity Binary sink.")
model BinarySink extends CopySink {
  @doc("Binary store settings.")
  storeSettings?: StoreWriteSettings;

  @doc("Copy sink type.")
  type: "BinarySink";
}

@doc("A copy activity Azure Blob sink.")
model BlobSink extends CopySink {
  @doc("Blob writer overwrite files. Type: boolean (or Expression with resultType boolean).")
  blobWriterOverwriteFiles?: Record<unknown>;

  @doc("Blob writer date time format. Type: string (or Expression with resultType string).")
  blobWriterDateTimeFormat?: Record<unknown>;

  @doc("Blob writer add header. Type: boolean (or Expression with resultType boolean).")
  blobWriterAddHeader?: Record<unknown>;

  @doc("The type of copy behavior for copy sink.")
  copyBehavior?: Record<unknown>;

  @doc("Specify the custom metadata to be added to sink data. Type: array of objects (or Expression with resultType array of objects).")
  metadata?: MetadataItem[];

  @doc("Copy sink type.")
  type: "BlobSink";
}

@doc("Specify the name and value of custom metadata item.")
model MetadataItem {
  @doc("Metadata item key name. Type: string (or Expression with resultType string).")
  name?: Record<unknown>;

  @doc("Metadata item value. Type: string (or Expression with resultType string).")
  value?: Record<unknown>;
}

@doc("A copy activity file system sink.")
model FileSystemSink extends CopySink {
  @doc("The type of copy behavior for copy sink.")
  copyBehavior?: Record<unknown>;

  @doc("Copy sink type.")
  type: "FileSystemSink";
}

@doc("A copy activity Document Database Collection sink.")
model DocumentDbCollectionSink extends CopySink {
  @doc("Nested properties separator. Default is . (dot). Type: string (or Expression with resultType string).")
  nestingSeparator?: Record<unknown>;

  @doc("Describes how to write data to Azure Cosmos DB. Type: string (or Expression with resultType string). Allowed values: insert and upsert.")
  writeBehavior?: Record<unknown>;

  @doc("Copy sink type.")
  type: "DocumentDbCollectionSink";
}

@doc("A copy activity Azure CosmosDB (SQL API) Collection sink.")
model CosmosDbSqlApiSink extends CopySink {
  @doc("Describes how to write data to Azure Cosmos DB. Type: string (or Expression with resultType string). Allowed values: insert and upsert.")
  writeBehavior?: Record<unknown>;

  @doc("Copy sink type.")
  type: "CosmosDbSqlApiSink";
}

@doc("A copy activity SQL sink.")
model SqlSink extends CopySink {
  @doc("SQL writer stored procedure name. Type: string (or Expression with resultType string).")
  sqlWriterStoredProcedureName?: Record<unknown>;

  @doc("SQL writer table type. Type: string (or Expression with resultType string).")
  sqlWriterTableType?: Record<unknown>;

  @doc("SQL pre-copy script. Type: string (or Expression with resultType string).")
  preCopyScript?: Record<unknown>;

  @doc("SQL stored procedure parameters.")
  storedProcedureParameters?: Record<unknown>;

  @doc("The stored procedure parameter name of the table type. Type: string (or Expression with resultType string).")
  storedProcedureTableTypeParameterName?: Record<unknown>;

  @doc("The option to handle sink table, such as autoCreate. For now only 'autoCreate' value is supported. Type: string (or Expression with resultType string).")
  tableOption?: Record<unknown>;

  @doc("Whether to use table lock during bulk copy. Type: boolean (or Expression with resultType boolean).")
  sqlWriterUseTableLock?: Record<unknown>;

  @doc("Write behavior when copying data into sql. Type: SqlWriteBehaviorEnum (or Expression with resultType SqlWriteBehaviorEnum)")
  writeBehavior?: Record<unknown>;

  @doc("SQL upsert settings.")
  upsertSettings?: SqlUpsertSettings;

  @doc("Copy sink type.")
  type: "SqlSink";
}

@doc("Sql upsert option settings")
model SqlUpsertSettings {
  @doc("Specifies whether to use temp db for upsert interim table. Type: boolean (or Expression with resultType boolean).")
  useTempDB?: Record<unknown>;

  @doc("Schema name for interim table. Type: string (or Expression with resultType string).")
  interimSchemaName?: Record<unknown>;

  @doc("Key column names for unique row identification. Type: array of strings (or Expression with resultType array of strings).")
  keys?: Record<unknown>;
}

@doc("A copy activity SQL server sink.")
model SqlServerSink extends CopySink {
  @doc("SQL writer stored procedure name. Type: string (or Expression with resultType string).")
  sqlWriterStoredProcedureName?: Record<unknown>;

  @doc("SQL writer table type. Type: string (or Expression with resultType string).")
  sqlWriterTableType?: Record<unknown>;

  @doc("SQL pre-copy script. Type: string (or Expression with resultType string).")
  preCopyScript?: Record<unknown>;

  @doc("SQL stored procedure parameters.")
  storedProcedureParameters?: Record<unknown>;

  @doc("The stored procedure parameter name of the table type. Type: string (or Expression with resultType string).")
  storedProcedureTableTypeParameterName?: Record<unknown>;

  @doc("The option to handle sink table, such as autoCreate. For now only 'autoCreate' value is supported. Type: string (or Expression with resultType string).")
  tableOption?: Record<unknown>;

  @doc("Whether to use table lock during bulk copy. Type: boolean (or Expression with resultType boolean).")
  sqlWriterUseTableLock?: Record<unknown>;

  @doc("Write behavior when copying data into sql server. Type: SqlWriteBehaviorEnum (or Expression with resultType SqlWriteBehaviorEnum)")
  writeBehavior?: Record<unknown>;

  @doc("SQL upsert settings.")
  upsertSettings?: SqlUpsertSettings;

  @doc("Copy sink type.")
  type: "SqlServerSink";
}

@doc("A copy activity Azure SQL sink.")
model AzureSqlSink extends CopySink {
  @doc("SQL writer stored procedure name. Type: string (or Expression with resultType string).")
  sqlWriterStoredProcedureName?: Record<unknown>;

  @doc("SQL writer table type. Type: string (or Expression with resultType string).")
  sqlWriterTableType?: Record<unknown>;

  @doc("SQL pre-copy script. Type: string (or Expression with resultType string).")
  preCopyScript?: Record<unknown>;

  @doc("SQL stored procedure parameters.")
  storedProcedureParameters?: Record<unknown>;

  @doc("The stored procedure parameter name of the table type. Type: string (or Expression with resultType string).")
  storedProcedureTableTypeParameterName?: Record<unknown>;

  @doc("The option to handle sink table, such as autoCreate. For now only 'autoCreate' value is supported. Type: string (or Expression with resultType string).")
  tableOption?: Record<unknown>;

  @doc("Whether to use table lock during bulk copy. Type: boolean (or Expression with resultType boolean).")
  sqlWriterUseTableLock?: Record<unknown>;

  @doc("Write behavior when copying data into Azure SQL. Type: SqlWriteBehaviorEnum (or Expression with resultType SqlWriteBehaviorEnum)")
  writeBehavior?: Record<unknown>;

  @doc("SQL upsert settings.")
  upsertSettings?: SqlUpsertSettings;

  @doc("Copy sink type.")
  type: "AzureSqlSink";
}

@doc("A copy activity Azure SQL Managed Instance sink.")
model SqlMISink extends CopySink {
  @doc("SQL writer stored procedure name. Type: string (or Expression with resultType string).")
  sqlWriterStoredProcedureName?: Record<unknown>;

  @doc("SQL writer table type. Type: string (or Expression with resultType string).")
  sqlWriterTableType?: Record<unknown>;

  @doc("SQL pre-copy script. Type: string (or Expression with resultType string).")
  preCopyScript?: Record<unknown>;

  @doc("SQL stored procedure parameters.")
  storedProcedureParameters?: Record<unknown>;

  @doc("The stored procedure parameter name of the table type. Type: string (or Expression with resultType string).")
  storedProcedureTableTypeParameterName?: Record<unknown>;

  @doc("The option to handle sink table, such as autoCreate. For now only 'autoCreate' value is supported. Type: string (or Expression with resultType string).")
  tableOption?: Record<unknown>;

  @doc("Whether to use table lock during bulk copy. Type: boolean (or Expression with resultType boolean).")
  sqlWriterUseTableLock?: Record<unknown>;

  @doc("White behavior when copying data into azure SQL MI. Type: SqlWriteBehaviorEnum (or Expression with resultType SqlWriteBehaviorEnum)")
  writeBehavior?: Record<unknown>;

  @doc("SQL upsert settings.")
  upsertSettings?: SqlUpsertSettings;

  @doc("Copy sink type.")
  type: "SqlMISink";
}

@doc("A copy activity SQL Data Warehouse sink.")
model SqlDWSink extends CopySink {
  @doc("SQL pre-copy script. Type: string (or Expression with resultType string).")
  preCopyScript?: Record<unknown>;

  @doc("Indicates to use PolyBase to copy data into SQL Data Warehouse when applicable. Type: boolean (or Expression with resultType boolean).")
  allowPolyBase?: Record<unknown>;

  @doc("Specifies PolyBase-related settings when allowPolyBase is true.")
  polyBaseSettings?: PolybaseSettings;

  @doc("Indicates to use Copy Command to copy data into SQL Data Warehouse. Type: boolean (or Expression with resultType boolean).")
  allowCopyCommand?: Record<unknown>;

  @doc("Specifies Copy Command related settings when allowCopyCommand is true.")
  copyCommandSettings?: DWCopyCommandSettings;

  @doc("The option to handle sink table, such as autoCreate. For now only 'autoCreate' value is supported. Type: string (or Expression with resultType string).")
  tableOption?: Record<unknown>;

  @doc("Whether to use table lock during bulk copy. Type: boolean (or Expression with resultType boolean).")
  sqlWriterUseTableLock?: Record<unknown>;

  @doc("Write behavior when copying data into azure SQL DW. Type: SqlDWWriteBehaviorEnum (or Expression with resultType SqlDWWriteBehaviorEnum)")
  writeBehavior?: Record<unknown>;

  @doc("SQL DW upsert settings.")
  upsertSettings?: SqlDWUpsertSettings;

  @doc("Copy sink type.")
  type: "SqlDWSink";
}

@doc("PolyBase settings.")
model PolybaseSettings extends Record<Record<unknown>> {
  @doc("Reject type.")
  rejectType?: PolybaseSettingsRejectType;

  @doc("Specifies the value or the percentage of rows that can be rejected before the query fails. Type: number (or Expression with resultType number), minimum: 0.")
  rejectValue?: Record<unknown>;

  @doc("Determines the number of rows to attempt to retrieve before the PolyBase recalculates the percentage of rejected rows. Type: integer (or Expression with resultType integer), minimum: 0.")
  rejectSampleValue?: Record<unknown>;

  @doc("Specifies how to handle missing values in delimited text files when PolyBase retrieves data from the text file. Type: boolean (or Expression with resultType boolean).")
  useTypeDefault?: Record<unknown>;
}

@doc("DW Copy Command settings.")
model DWCopyCommandSettings {
  @doc("Specifies the default values for each target column in SQL DW. The default values in the property overwrite the DEFAULT constraint set in the DB, and identity column cannot have a default value. Type: array of objects (or Expression with resultType array of objects).")
  defaultValues?: DWCopyCommandDefaultValue[];

  @doc("Additional options directly passed to SQL DW in Copy Command. Type: key value pairs (value should be string type) (or Expression with resultType object). Example: \"additionalOptions\": { \"MAXERRORS\": \"1000\", \"DATEFORMAT\": \"'ymd'\" }")
  additionalOptions?: Record<string>;
}

@doc("Default value.")
model DWCopyCommandDefaultValue {
  @doc("Column name. Type: object (or Expression with resultType string).")
  columnName?: Record<unknown>;

  @doc("The default value of the column. Type: object (or Expression with resultType string).")
  defaultValue?: Record<unknown>;
}

@doc("Sql DW upsert option settings")
model SqlDWUpsertSettings {
  @doc("Schema name for interim table. Type: string (or Expression with resultType string).")
  interimSchemaName?: Record<unknown>;

  @doc("Key column names for unique row identification. Type: array of strings (or Expression with resultType array of strings).")
  keys?: Record<unknown>;
}

@doc("A copy activity snowflake sink.")
model SnowflakeSink extends CopySink {
  @doc("SQL pre-copy script. Type: string (or Expression with resultType string).")
  preCopyScript?: Record<unknown>;

  @doc("Snowflake import settings.")
  importSettings?: SnowflakeImportCopyCommand;

  @doc("Copy sink type.")
  type: "SnowflakeSink";
}

@doc("Snowflake import command settings.")
model SnowflakeImportCopyCommand extends ImportSettings {
  @doc("Additional copy options directly passed to snowflake Copy Command. Type: key value pairs (value should be string type) (or Expression with resultType object). Example: \"additionalCopyOptions\": { \"DATE_FORMAT\": \"MM/DD/YYYY\", \"TIME_FORMAT\": \"'HH24:MI:SS.FF'\" }")
  additionalCopyOptions?: Record<Record<unknown>>;

  @doc("Additional format options directly passed to snowflake Copy Command. Type: key value pairs (value should be string type) (or Expression with resultType object). Example: \"additionalFormatOptions\": { \"FORCE\": \"TRUE\", \"LOAD_UNCERTAIN_FILES\": \"'FALSE'\" }")
  additionalFormatOptions?: Record<Record<unknown>>;

  @doc("The import setting type.")
  type: "SnowflakeImportCopyCommand";
}

@doc("Specify the column name and value of additional columns.")
model AdditionalColumns {
  @doc("Additional column name. Type: string (or Expression with resultType string).")
  name?: Record<unknown>;

  @doc("Additional column value. Type: string (or Expression with resultType string).")
  value?: Record<unknown>;
}

@doc("A copy activity Oracle sink.")
model OracleSink extends CopySink {
  @doc("SQL pre-copy script. Type: string (or Expression with resultType string).")
  preCopyScript?: Record<unknown>;

  @doc("Copy sink type.")
  type: "OracleSink";
}

@doc("A copy activity Azure Data Lake Store sink.")
model AzureDataLakeStoreSink extends CopySink {
  @doc("The type of copy behavior for copy sink. Type: string (or Expression with resultType string).")
  copyBehavior?: Record<unknown>;

  @doc("Single File Parallel.")
  enableAdlsSingleFileParallel?: Record<unknown>;

  @doc("Copy sink type.")
  type: "AzureDataLakeStoreSink";
}

@doc("A copy activity Azure Data Lake Storage Gen2 sink.")
model AzureBlobFSSink extends CopySink {
  @doc("The type of copy behavior for copy sink. Type: string (or Expression with resultType string).")
  copyBehavior?: Record<unknown>;

  @doc("Specify the custom metadata to be added to sink data. Type: array of objects (or Expression with resultType array of objects).")
  metadata?: MetadataItem[];

  @doc("Copy sink type.")
  type: "AzureBlobFSSink";
}

@doc("A copy activity Azure Search Index sink.")
model AzureSearchIndexSink extends CopySink {
  @doc("Specify the write behavior when upserting documents into Azure Search Index.")
  writeBehavior?: AzureSearchIndexWriteBehaviorType;

  @doc("Copy sink type.")
  type: "AzureSearchIndexSink";
}

@doc("A copy activity ODBC sink.")
model OdbcSink extends CopySink {
  @doc("A query to execute before starting the copy. Type: string (or Expression with resultType string).")
  preCopyScript?: Record<unknown>;

  @doc("Copy sink type.")
  type: "OdbcSink";
}

@doc("A copy activity Informix sink.")
model InformixSink extends CopySink {
  @doc("A query to execute before starting the copy. Type: string (or Expression with resultType string).")
  preCopyScript?: Record<unknown>;

  @doc("Copy sink type.")
  type: "InformixSink";
}

@doc("A copy activity Microsoft Access sink.")
model MicrosoftAccessSink extends CopySink {
  @doc("A query to execute before starting the copy. Type: string (or Expression with resultType string).")
  preCopyScript?: Record<unknown>;

  @doc("Copy sink type.")
  type: "MicrosoftAccessSink";
}

@doc("A copy activity Dynamics sink.")
model DynamicsSink extends CopySink {
  @doc("The write behavior for the operation.")
  writeBehavior: DynamicsSinkWriteBehavior;

  @doc("The flag indicating whether ignore null values from input dataset (except key fields) during write operation. Default is false. Type: boolean (or Expression with resultType boolean).")
  ignoreNullValues?: Record<unknown>;

  @doc("The logical name of the alternate key which will be used when upserting records. Type: string (or Expression with resultType string).")
  alternateKeyName?: Record<unknown>;

  @doc("Copy sink type.")
  type: "DynamicsSink";
}

@doc("A copy activity Dynamics CRM sink.")
model DynamicsCrmSink extends CopySink {
  @doc("The write behavior for the operation.")
  writeBehavior: DynamicsSinkWriteBehavior;

  @doc("The flag indicating whether to ignore null values from input dataset (except key fields) during write operation. Default is false. Type: boolean (or Expression with resultType boolean).")
  ignoreNullValues?: Record<unknown>;

  @doc("The logical name of the alternate key which will be used when upserting records. Type: string (or Expression with resultType string).")
  alternateKeyName?: Record<unknown>;

  @doc("Copy sink type.")
  type: "DynamicsCrmSink";
}

@doc("A copy activity Common Data Service for Apps sink.")
model CommonDataServiceForAppsSink extends CopySink {
  @doc("The write behavior for the operation.")
  writeBehavior: DynamicsSinkWriteBehavior;

  @doc("The flag indicating whether to ignore null values from input dataset (except key fields) during write operation. Default is false. Type: boolean (or Expression with resultType boolean).")
  ignoreNullValues?: Record<unknown>;

  @doc("The logical name of the alternate key which will be used when upserting records. Type: string (or Expression with resultType string).")
  alternateKeyName?: Record<unknown>;

  @doc("Copy sink type.")
  type: "CommonDataServiceForAppsSink";
}

@doc("A copy activity Azure Data Explorer sink.")
model AzureDataExplorerSink extends CopySink {
  @doc("A name of a pre-created csv mapping that was defined on the target Kusto table. Type: string.")
  ingestionMappingName?: Record<unknown>;

  @doc("An explicit column mapping description provided in a json format. Type: string.")
  ingestionMappingAsJson?: Record<unknown>;

  @doc("If set to true, any aggregation will be skipped. Default is false. Type: boolean.")
  flushImmediately?: Record<unknown>;

  @doc("Copy sink type.")
  type: "AzureDataExplorerSink";
}

@doc("A copy activity Salesforce sink.")
model SalesforceSink extends CopySink {
  @doc("The write behavior for the operation. Default is Insert.")
  writeBehavior?: SalesforceSinkWriteBehavior;

  @doc("The name of the external ID field for upsert operation. Default value is 'Id' column. Type: string (or Expression with resultType string).")
  externalIdFieldName?: Record<unknown>;

  @doc("The flag indicating whether or not to ignore null values from input dataset (except key fields) during write operation. Default value is false. If set it to true, it means ADF will leave the data in the destination object unchanged when doing upsert/update operation and insert defined default value when doing insert operation, versus ADF will update the data in the destination object to NULL when doing upsert/update operation and insert NULL value when doing insert operation. Type: boolean (or Expression with resultType boolean).")
  ignoreNullValues?: Record<unknown>;

  @doc("Copy sink type.")
  type: "SalesforceSink";
}

@doc("A copy activity Salesforce Service Cloud sink.")
model SalesforceServiceCloudSink extends CopySink {
  @doc("The write behavior for the operation. Default is Insert.")
  writeBehavior?: SalesforceSinkWriteBehavior;

  @doc("The name of the external ID field for upsert operation. Default value is 'Id' column. Type: string (or Expression with resultType string).")
  externalIdFieldName?: Record<unknown>;

  @doc("The flag indicating whether or not to ignore null values from input dataset (except key fields) during write operation. Default value is false. If set it to true, it means ADF will leave the data in the destination object unchanged when doing upsert/update operation and insert defined default value when doing insert operation, versus ADF will update the data in the destination object to NULL when doing upsert/update operation and insert NULL value when doing insert operation. Type: boolean (or Expression with resultType boolean).")
  ignoreNullValues?: Record<unknown>;

  @doc("Copy sink type.")
  type: "SalesforceServiceCloudSink";
}

@doc("A copy activity MongoDB Atlas sink.")
model MongoDbAtlasSink extends CopySink {
  @doc("Specifies whether the document with same key to be overwritten (upsert) rather than throw exception (insert). The default value is \"insert\". Type: string (or Expression with resultType string). Type: string (or Expression with resultType string).")
  writeBehavior?: Record<unknown>;

  @doc("Copy sink type.")
  type: "MongoDbAtlasSink";
}

@doc("A copy activity MongoDB sink.")
model MongoDbV2Sink extends CopySink {
  @doc("Specifies whether the document with same key to be overwritten (upsert) rather than throw exception (insert). The default value is \"insert\". Type: string (or Expression with resultType string). Type: string (or Expression with resultType string).")
  writeBehavior?: Record<unknown>;

  @doc("Copy sink type.")
  type: "MongoDbV2Sink";
}

@doc("A copy activity sink for a CosmosDB (MongoDB API) database.")
model CosmosDbMongoDbApiSink extends CopySink {
  @doc("Specifies whether the document with same key to be overwritten (upsert) rather than throw exception (insert). The default value is \"insert\". Type: string (or Expression with resultType string). Type: string (or Expression with resultType string).")
  writeBehavior?: Record<unknown>;

  @doc("Copy sink type.")
  type: "CosmosDbMongoDbApiSink";
}

@doc("A copy activity for Microsoft Fabric LakeHouse Table sink.")
model LakeHouseTableSink extends CopySink {
  @doc("The type of table action for LakeHouse Table sink. Possible values include: \"None\", \"Append\", \"Overwrite\".")
  tableActionOption?: Record<unknown>;

  @doc("Create partitions in folder structure based on one or multiple columns. Each distinct column value (pair) will be a new partition. Possible values include: \"None\", \"PartitionByKey\".")
  partitionOption?: Record<unknown>;

  @doc("Specify the partition column names from sink columns. Type: array of objects (or Expression with resultType array of objects).")
  partitionNameList?: Record<unknown>;

  @doc("Copy sink type.")
  type: "LakeHouseTableSink";
}

@doc("A copy activity translator.")
@discriminator("type")
model CopyTranslator extends Record<Record<unknown>> {}

@doc("A copy activity tabular translator.")
model TabularTranslator extends CopyTranslator {
  @doc("Column mappings. Example: \"UserId: MyUserId, Group: MyGroup, Name: MyName\" Type: string (or Expression with resultType string). This property will be retired. Please use mappings property.")
  columnMappings?: Record<unknown>;

  @doc("The schema mapping to map between tabular data and hierarchical data. Example: {\"Column1\": \"$.Column1\", \"Column2\": \"$.Column2.Property1\", \"Column3\": \"$.Column2.Property2\"}. Type: object (or Expression with resultType object). This property will be retired. Please use mappings property.")
  schemaMapping?: Record<unknown>;

  @doc("The JSON Path of the Nested Array that is going to do cross-apply. Type: object (or Expression with resultType object).")
  collectionReference?: Record<unknown>;

  @doc("Whether to map complex (array and object) values to simple strings in json format. Type: boolean (or Expression with resultType boolean).")
  mapComplexValuesToString?: Record<unknown>;

  @doc("Column mappings with logical types. Tabular->tabular example: [{\"source\":{\"name\":\"CustomerName\",\"type\":\"String\"},\"sink\":{\"name\":\"ClientName\",\"type\":\"String\"}},{\"source\":{\"name\":\"CustomerAddress\",\"type\":\"String\"},\"sink\":{\"name\":\"ClientAddress\",\"type\":\"String\"}}].  Hierarchical->tabular example: [{\"source\":{\"path\":\"$.CustomerName\",\"type\":\"String\"},\"sink\":{\"name\":\"ClientName\",\"type\":\"String\"}},{\"source\":{\"path\":\"$.CustomerAddress\",\"type\":\"String\"},\"sink\":{\"name\":\"ClientAddress\",\"type\":\"String\"}}]. Type: object (or Expression with resultType object).")
  mappings?: Record<unknown>;

  @doc("Whether to enable the advanced type conversion feature in the Copy activity. Type: boolean (or Expression with resultType boolean).")
  typeConversion?: Record<unknown>;

  @doc("Type conversion settings")
  typeConversionSettings?: TypeConversionSettings;

  @doc("Copy translator type.")
  type: "TabularTranslator";
}

@doc("Type conversion settings")
model TypeConversionSettings {
  @doc("Whether to allow data truncation when converting the data. Type: boolean (or Expression with resultType boolean).")
  allowDataTruncation?: Record<unknown>;

  @doc("Whether to treat boolean values as numbers. Type: boolean (or Expression with resultType boolean).")
  treatBooleanAsNumber?: Record<unknown>;

  @doc("The format for DateTime values. Type: string (or Expression with resultType string).")
  dateTimeFormat?: Record<unknown>;

  @doc("The format for DateTimeOffset values. Type: string (or Expression with resultType string).")
  dateTimeOffsetFormat?: Record<unknown>;

  @doc("The format for TimeSpan values. Type: string (or Expression with resultType string).")
  timeSpanFormat?: Record<unknown>;

  @doc("The culture used to convert data from/to string. Type: string (or Expression with resultType string).")
  culture?: Record<unknown>;
}

@doc("HDInsight Hive activity type.")
model HDInsightHiveActivity extends ExecutionActivity {
  @doc("HDInsight Hive activity properties.")
  typeProperties: HDInsightHiveActivityTypeProperties;

  @doc("Type of activity.")
  type: "HDInsightHive";
}

@doc("HDInsight Hive activity properties.")
model HDInsightHiveActivityTypeProperties {
  @doc("Storage linked service references.")
  storageLinkedServices?: LinkedServiceReference[];

  @doc("User specified arguments to HDInsightActivity.")
  arguments?: Record<unknown>[];

  @doc("Debug info option.")
  getDebugInfo?: HDInsightActivityDebugInfoOption;

  @doc("Script path. Type: string (or Expression with resultType string).")
  scriptPath?: Record<unknown>;

  @doc("Script linked service reference.")
  scriptLinkedService?: LinkedServiceReference;

  @doc("Allows user to specify defines for Hive job request.")
  defines?: Record<Record<unknown>>;

  @doc("User specified arguments under hivevar namespace.")
  variables?: Record<Record<unknown>>;

  @doc("Query timeout value (in minutes).  Effective when the HDInsight cluster is with ESP (Enterprise Security Package)")
  queryTimeout?: int32;
}

@doc("HDInsight Pig activity type.")
model HDInsightPigActivity extends ExecutionActivity {
  @doc("HDInsight Pig activity properties.")
  typeProperties: HDInsightPigActivityTypeProperties;

  @doc("Type of activity.")
  type: "HDInsightPig";
}

@doc("HDInsight Pig activity properties.")
model HDInsightPigActivityTypeProperties {
  @doc("Storage linked service references.")
  storageLinkedServices?: LinkedServiceReference[];

  @doc("User specified arguments to HDInsightActivity. Type: array (or Expression with resultType array).")
  arguments?: Record<unknown>;

  @doc("Debug info option.")
  getDebugInfo?: HDInsightActivityDebugInfoOption;

  @doc("Script path. Type: string (or Expression with resultType string).")
  scriptPath?: Record<unknown>;

  @doc("Script linked service reference.")
  scriptLinkedService?: LinkedServiceReference;

  @doc("Allows user to specify defines for Pig job request.")
  defines?: Record<Record<unknown>>;
}

@doc("HDInsight MapReduce activity type.")
model HDInsightMapReduceActivity extends ExecutionActivity {
  @doc("HDInsight MapReduce activity properties.")
  typeProperties: HDInsightMapReduceActivityTypeProperties;

  @doc("Type of activity.")
  type: "HDInsightMapReduce";
}

@doc("HDInsight MapReduce activity properties.")
model HDInsightMapReduceActivityTypeProperties {
  @doc("Storage linked service references.")
  storageLinkedServices?: LinkedServiceReference[];

  @doc("User specified arguments to HDInsightActivity.")
  arguments?: Record<unknown>[];

  @doc("Debug info option.")
  getDebugInfo?: HDInsightActivityDebugInfoOption;

  @doc("Class name. Type: string (or Expression with resultType string).")
  className: Record<unknown>;

  @doc("Jar path. Type: string (or Expression with resultType string).")
  jarFilePath: Record<unknown>;

  @doc("Jar linked service reference.")
  jarLinkedService?: LinkedServiceReference;

  @doc("Jar libs.")
  jarLibs?: Record<unknown>[];

  @doc("Allows user to specify defines for the MapReduce job request.")
  defines?: Record<Record<unknown>>;
}

@doc("HDInsight streaming activity type.")
model HDInsightStreamingActivity extends ExecutionActivity {
  @doc("HDInsight streaming activity properties.")
  typeProperties: HDInsightStreamingActivityTypeProperties;

  @doc("Type of activity.")
  type: "HDInsightStreaming";
}

@doc("HDInsight streaming activity properties.")
model HDInsightStreamingActivityTypeProperties {
  @doc("Storage linked service references.")
  storageLinkedServices?: LinkedServiceReference[];

  @doc("User specified arguments to HDInsightActivity.")
  arguments?: Record<unknown>[];

  @doc("Debug info option.")
  getDebugInfo?: HDInsightActivityDebugInfoOption;

  @doc("Mapper executable name. Type: string (or Expression with resultType string).")
  mapper: Record<unknown>;

  @doc("Reducer executable name. Type: string (or Expression with resultType string).")
  reducer: Record<unknown>;

  @doc("Input blob path. Type: string (or Expression with resultType string).")
  input: Record<unknown>;

  @doc("Output blob path. Type: string (or Expression with resultType string).")
  output: Record<unknown>;

  @doc("Paths to streaming job files. Can be directories.")
  filePaths: Record<unknown>[];

  @doc("Linked service reference where the files are located.")
  fileLinkedService?: LinkedServiceReference;

  @doc("Combiner executable name. Type: string (or Expression with resultType string).")
  combiner?: Record<unknown>;

  @doc("Command line environment values.")
  commandEnvironment?: Record<unknown>[];

  @doc("Allows user to specify defines for streaming job request.")
  defines?: Record<Record<unknown>>;
}

@doc("HDInsight Spark activity.")
model HDInsightSparkActivity extends ExecutionActivity {
  @doc("HDInsight spark activity properties.")
  typeProperties: HDInsightSparkActivityTypeProperties;

  @doc("Type of activity.")
  type: "HDInsightSpark";
}

@doc("HDInsight spark activity properties.")
model HDInsightSparkActivityTypeProperties {
  @doc("The root path in 'sparkJobLinkedService' for all the job’s files. Type: string (or Expression with resultType string).")
  rootPath: Record<unknown>;

  @doc("The relative path to the root folder of the code/package to be executed. Type: string (or Expression with resultType string).")
  entryFilePath: Record<unknown>;

  @doc("The user-specified arguments to HDInsightSparkActivity.")
  arguments?: Record<unknown>[];

  @doc("Debug info option.")
  getDebugInfo?: HDInsightActivityDebugInfoOption;

  @doc("The storage linked service for uploading the entry file and dependencies, and for receiving logs.")
  sparkJobLinkedService?: LinkedServiceReference;

  @doc("The application's Java/Spark main class.")
  className?: string;

  @doc("The user to impersonate that will execute the job. Type: string (or Expression with resultType string).")
  proxyUser?: Record<unknown>;

  @doc("Spark configuration property.")
  sparkConfig?: Record<Record<unknown>>;
}

@doc("Execute SSIS package activity.")
model ExecuteSsisPackageActivity extends ExecutionActivity {
  @doc("Execute SSIS package activity properties.")
  typeProperties: ExecuteSsisPackageActivityTypeProperties;

  @doc("Type of activity.")
  type: "ExecuteSSISPackage";
}

@doc("Execute SSIS package activity properties.")
model ExecuteSsisPackageActivityTypeProperties {
  @doc("SSIS package location.")
  packageLocation: SsisPackageLocation;

  @doc("Specifies the runtime to execute SSIS package. The value should be \"x86\" or \"x64\". Type: string (or Expression with resultType string).")
  runtime?: Record<unknown>;

  @doc("The logging level of SSIS package execution. Type: string (or Expression with resultType string).")
  loggingLevel?: Record<unknown>;

  @doc("The environment path to execute the SSIS package. Type: string (or Expression with resultType string).")
  environmentPath?: Record<unknown>;

  @doc("The package execution credential.")
  executionCredential?: SsisExecutionCredential;

  @doc("The integration runtime reference.")
  connectVia: IntegrationRuntimeReference;

  @doc("The project level parameters to execute the SSIS package.")
  projectParameters?: Record<SsisExecutionParameter>;

  @doc("The package level parameters to execute the SSIS package.")
  packageParameters?: Record<SsisExecutionParameter>;

  @doc("The project level connection managers to execute the SSIS package.")
  projectConnectionManagers?: Record<Record<SsisExecutionParameter>>;

  @doc("The package level connection managers to execute the SSIS package.")
  packageConnectionManagers?: Record<Record<SsisExecutionParameter>>;

  @doc("The property overrides to execute the SSIS package.")
  propertyOverrides?: Record<SsisPropertyOverride>;

  @doc("SSIS package execution log location.")
  logLocation?: SsisLogLocation;
}

@doc("SSIS package location.")
model SsisPackageLocation {
  @doc("The SSIS package path. Type: string (or Expression with resultType string).")
  packagePath?: Record<unknown>;

  @doc("The type of SSIS package location.")
  type?: SsisPackageLocationType;

  @doc("SSIS package location properties.")
  typeProperties?: SsisPackageLocationTypeProperties;
}

@doc("SSIS package location properties.")
model SsisPackageLocationTypeProperties {
  @doc("Password of the package.")
  packagePassword?: SecretBase;

  @doc("The package access credential.")
  accessCredential?: SsisAccessCredential;

  @doc("The configuration file of the package execution. Type: string (or Expression with resultType string).")
  configurationPath?: Record<unknown>;

  @doc("The configuration file access credential.")
  configurationAccessCredential?: SsisAccessCredential;

  @doc("The package name.")
  packageName?: string;

  @doc("The embedded package content. Type: string (or Expression with resultType string).")
  packageContent?: Record<unknown>;

  @doc("The embedded package last modified date.")
  packageLastModifiedDate?: string;

  @doc("The embedded child package list.")
  childPackages?: SsisChildPackage[];
}

@doc("SSIS access credential.")
model SsisAccessCredential {
  @doc("Domain for windows authentication. Type: string (or Expression with resultType string).")
  domain: Record<unknown>;

  @doc("UseName for windows authentication. Type: string (or Expression with resultType string).")
  userName: Record<unknown>;

  @doc("Password for windows authentication.")
  password: SecretBase;
}

@doc("SSIS embedded child package.")
model SsisChildPackage {
  @doc("Path for embedded child package. Type: string (or Expression with resultType string).")
  packagePath: Record<unknown>;

  @doc("Name for embedded child package.")
  packageName?: string;

  @doc("Content for embedded child package. Type: string (or Expression with resultType string).")
  packageContent: Record<unknown>;

  @doc("Last modified date for embedded child package.")
  packageLastModifiedDate?: string;
}

@doc("SSIS package execution credential.")
model SsisExecutionCredential {
  @doc("Domain for windows authentication. Type: string (or Expression with resultType string).")
  domain: Record<unknown>;

  @doc("UseName for windows authentication. Type: string (or Expression with resultType string).")
  userName: Record<unknown>;

  @doc("Password for windows authentication.")
  password: SecureString;
}

@doc("SSIS execution parameter.")
model SsisExecutionParameter {
  @doc("SSIS package execution parameter value. Type: string (or Expression with resultType string).")
  value: Record<unknown>;
}

@doc("SSIS property override.")
model SsisPropertyOverride {
  @doc("SSIS package property override value. Type: string (or Expression with resultType string).")
  value: Record<unknown>;

  @doc("Whether SSIS package property override value is sensitive data. Value will be encrypted in SSISDB if it is true")
  isSensitive?: boolean;
}

@doc("SSIS package execution log location")
model SsisLogLocation {
  @doc("The SSIS package execution log path. Type: string (or Expression with resultType string).")
  logPath: Record<unknown>;

  @doc("The type of SSIS log location.")
  type: SsisLogLocationType;

  @doc("SSIS package execution log location properties.")
  typeProperties: SsisLogLocationTypeProperties;
}

@doc("SSIS package execution log location properties.")
model SsisLogLocationTypeProperties {
  @doc("The package execution log access credential.")
  accessCredential?: SsisAccessCredential;

  @doc("Specifies the interval to refresh log. The default interval is 5 minutes. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  logRefreshInterval?: Record<unknown>;
}

@doc("Custom activity type.")
model CustomActivity extends ExecutionActivity {
  @doc("Custom activity properties.")
  typeProperties: CustomActivityTypeProperties;

  @doc("Type of activity.")
  type: "Custom";
}

@doc("Custom activity properties.")
model CustomActivityTypeProperties {
  @doc("Command for custom activity Type: string (or Expression with resultType string).")
  command: Record<unknown>;

  @doc("Resource linked service reference.")
  resourceLinkedService?: LinkedServiceReference;

  @doc("Folder path for resource files Type: string (or Expression with resultType string).")
  folderPath?: Record<unknown>;

  @doc("Reference objects")
  referenceObjects?: CustomActivityReferenceObject;

  @doc("User defined property bag. There is no restriction on the keys or values that can be used. The user specified custom activity has the full responsibility to consume and interpret the content defined.")
  extendedProperties?: Record<Record<unknown>>;

  @doc("The retention time for the files submitted for custom activity. Type: double (or Expression with resultType double).")
  retentionTimeInDays?: Record<unknown>;

  @doc("Elevation level and scope for the user, default is nonadmin task. Type: string (or Expression with resultType double).")
  autoUserSpecification?: Record<unknown>;
}

@doc("Reference objects for custom activity")
model CustomActivityReferenceObject {
  @doc("Linked service references.")
  linkedServices?: LinkedServiceReference[];

  @doc("Dataset references.")
  datasets?: DatasetReference[];
}

@doc("SQL stored procedure activity type.")
model SqlServerStoredProcedureActivity extends ExecutionActivity {
  @doc("SQL stored procedure activity properties.")
  typeProperties: SqlServerStoredProcedureActivityTypeProperties;

  @doc("Type of activity.")
  type: "SqlServerStoredProcedure";
}

@doc("SQL stored procedure activity properties.")
model SqlServerStoredProcedureActivityTypeProperties {
  @doc("Stored procedure name. Type: string (or Expression with resultType string).")
  storedProcedureName: Record<unknown>;

  @doc("Value and type setting for stored procedure parameters. Example: \"{Parameter1: {value: \"1\", type: \"int\"}}\".")
  storedProcedureParameters?: Record<unknown>;
}

@doc("Execute pipeline activity.")
model ExecutePipelineActivity extends ControlActivity {
  @doc("Execute pipeline activity policy.")
  policy?: ExecutePipelineActivityPolicy;

  @doc("Execute pipeline activity properties.")
  typeProperties: ExecutePipelineActivityTypeProperties;

  @doc("Type of activity.")
  type: "ExecutePipeline";
}

@doc("Execution policy for an execute pipeline activity.")
model ExecutePipelineActivityPolicy extends Record<Record<unknown>> {
  @doc("When set to true, Input from activity is considered as secure and will not be logged to monitoring.")
  secureInput?: boolean;
}

@doc("Execute pipeline activity properties.")
model ExecutePipelineActivityTypeProperties {
  @doc("Pipeline reference.")
  pipeline: PipelineReference;

  @doc("Pipeline parameters.")
  parameters?: Record<Record<unknown>>;

  @doc("Defines whether activity execution will wait for the dependent pipeline execution to finish. Default is false.")
  waitOnCompletion?: boolean;
}

@doc("Delete activity.")
model DeleteActivity extends ExecutionActivity {
  @doc("Delete activity properties.")
  typeProperties: DeleteActivityTypeProperties;

  @doc("Type of activity.")
  type: "Delete";
}

@doc("Delete activity properties.")
model DeleteActivityTypeProperties {
  @doc("If true, files or sub-folders under current folder path will be deleted recursively. Default is false. Type: boolean (or Expression with resultType boolean).")
  recursive?: Record<unknown>;

  @doc("The max concurrent connections to connect data source at the same time.")
  @minValue(1)
  maxConcurrentConnections?: int32;

  @doc("Whether to record detailed logs of delete-activity execution. Default value is false. Type: boolean (or Expression with resultType boolean).")
  enableLogging?: Record<unknown>;

  @doc("Log storage settings customer need to provide when enableLogging is true.")
  logStorageSettings?: LogStorageSettings;

  @doc("Delete activity dataset reference.")
  dataset: DatasetReference;

  @doc("Delete activity store settings.")
  storeSettings?: StoreReadSettings;
}

@doc("Azure Data Explorer command activity.")
model AzureDataExplorerCommandActivity extends ExecutionActivity {
  @doc("Azure Data Explorer command activity properties.")
  typeProperties: AzureDataExplorerCommandActivityTypeProperties;

  @doc("Type of activity.")
  type: "AzureDataExplorerCommand";
}

@doc("Azure Data Explorer command activity properties.")
model AzureDataExplorerCommandActivityTypeProperties {
  @doc("A control command, according to the Azure Data Explorer command syntax. Type: string (or Expression with resultType string).")
  command: Record<unknown>;

  @doc("Control command timeout. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9]))..)")
  commandTimeout?: Record<unknown>;
}

@doc("Lookup activity.")
model LookupActivity extends ExecutionActivity {
  @doc("Lookup activity properties.")
  typeProperties: LookupActivityTypeProperties;

  @doc("Type of activity.")
  type: "Lookup";
}

@doc("Lookup activity properties.")
model LookupActivityTypeProperties {
  @doc("Dataset-specific source properties, same as copy activity source.")
  source: CopySource;

  @doc("Lookup activity dataset reference.")
  dataset: DatasetReference;

  @doc("Whether to return first row or all rows. Default value is true. Type: boolean (or Expression with resultType boolean).")
  firstRowOnly?: Record<unknown>;
}

@doc("Web activity.")
model WebActivity extends ExecutionActivity {
  @doc("Web activity properties.")
  typeProperties: WebActivityTypeProperties;

  @doc("Type of activity.")
  type: "WebActivity";
}

@doc("Web activity type properties.")
model WebActivityTypeProperties {
  @doc("Rest API method for target endpoint.")
  method: WebActivityMethod;

  @doc("Web activity target endpoint and path. Type: string (or Expression with resultType string).")
  url: Record<unknown>;

  @doc("Represents the headers that will be sent to the request. For example, to set the language and type on a request: \"headers\" : { \"Accept-Language\": \"en-us\", \"Content-Type\": \"application/json\" }. Type: string (or Expression with resultType string).")
  headers?: Record<unknown>;

  @doc("Represents the payload that will be sent to the endpoint. Required for POST/PUT method, not allowed for GET method Type: string (or Expression with resultType string).")
  body?: Record<unknown>;

  @doc("Authentication method used for calling the endpoint.")
  authentication?: WebActivityAuthentication;

  @doc("When set to true, Certificate validation will be disabled.")
  disableCertValidation?: boolean;

  @doc("List of datasets passed to web endpoint.")
  datasets?: DatasetReference[];

  @doc("List of linked services passed to web endpoint.")
  linkedServices?: LinkedServiceReference[];

  @doc("The integration runtime reference.")
  connectVia?: IntegrationRuntimeReference;
}

@doc("Web activity authentication properties.")
model WebActivityAuthentication {
  @doc("Web activity authentication (Basic/ClientCertificate/MSI/ServicePrincipal)")
  type?: string;

  @doc("Base64-encoded contents of a PFX file or Certificate when used for ServicePrincipal")
  pfx?: SecretBase;

  @doc("Web activity authentication user name for basic authentication or ClientID when used for ServicePrincipal. Type: string (or Expression with resultType string).")
  username?: Record<unknown>;

  @doc("Password for the PFX file or basic authentication / Secret when used for ServicePrincipal")
  password?: SecretBase;

  @doc("Resource for which Azure Auth token will be requested when using MSI Authentication. Type: string (or Expression with resultType string).")
  resource?: Record<unknown>;

  @doc("TenantId for which Azure Auth token will be requested when using ServicePrincipal Authentication. Type: string (or Expression with resultType string).")
  userTenant?: Record<unknown>;

  @doc("The credential reference containing authentication information.")
  credential?: CredentialReference;
}

@doc("Activity to get metadata of dataset")
model GetMetadataActivity extends ExecutionActivity {
  @doc("GetMetadata activity properties.")
  typeProperties: GetMetadataActivityTypeProperties;

  @doc("Type of activity.")
  type: "GetMetadata";
}

@doc("GetMetadata activity properties.")
model GetMetadataActivityTypeProperties {
  @doc("GetMetadata activity dataset reference.")
  dataset: DatasetReference;

  @doc("Fields of metadata to get from dataset.")
  fieldList?: Record<unknown>[];

  @doc("GetMetadata activity store settings.")
  storeSettings?: StoreReadSettings;

  @doc("GetMetadata activity format settings.")
  formatSettings?: FormatReadSettings;
}

@doc("This activity evaluates a boolean expression and executes either the activities under the ifTrueActivities property or the ifFalseActivities property depending on the result of the expression.")
model IfConditionActivity extends ControlActivity {
  @doc("IfCondition activity properties.")
  typeProperties: IfConditionActivityTypeProperties;

  @doc("Type of activity.")
  type: "IfCondition";
}

@doc("IfCondition activity properties.")
model IfConditionActivityTypeProperties {
  @doc("An expression that would evaluate to Boolean. This is used to determine the block of activities (ifTrueActivities or ifFalseActivities) that will be executed.")
  expression: Expression;

  @doc("List of activities to execute if expression is evaluated to true. This is an optional property and if not provided, the activity will exit without any action.")
  ifTrueActivities?: Activity[];

  @doc("List of activities to execute if expression is evaluated to false. This is an optional property and if not provided, the activity will exit without any action.")
  ifFalseActivities?: Activity[];
}

@doc("This activity evaluates an expression and executes activities under the cases property that correspond to the expression evaluation expected in the equals property.")
model SwitchActivity extends ControlActivity {
  @doc("Switch activity properties.")
  typeProperties: SwitchActivityTypeProperties;

  @doc("Type of activity.")
  type: "Switch";
}

@doc("Switch activity properties.")
model SwitchActivityTypeProperties {
  @doc("An expression that would evaluate to a string or integer. This is used to determine the block of activities in cases that will be executed.")
  on: Expression;

  @doc("List of cases that correspond to expected values of the 'on' property. This is an optional property and if not provided, the activity will execute activities provided in defaultActivities.")
  cases?: SwitchCase[];

  @doc("List of activities to execute if no case condition is satisfied. This is an optional property and if not provided, the activity will exit without any action.")
  defaultActivities?: Activity[];
}

@doc("Switch cases with have a value and corresponding activities.")
model SwitchCase {
  @doc("Expected value that satisfies the expression result of the 'on' property.")
  value?: string;

  @doc("List of activities to execute for satisfied case condition.")
  activities?: Activity[];
}

@doc("This activity is used for iterating over a collection and execute given activities.")
model ForEachActivity extends ControlActivity {
  @doc("ForEach activity properties.")
  typeProperties: ForEachActivityTypeProperties;

  @doc("Type of activity.")
  type: "ForEach";
}

@doc("ForEach activity properties.")
model ForEachActivityTypeProperties {
  @doc("Should the loop be executed in sequence or in parallel (max 50)")
  isSequential?: boolean;

  @doc("Batch count to be used for controlling the number of parallel execution (when isSequential is set to false).")
  @maxValue(50)
  batchCount?: int32;

  @doc("Collection to iterate.")
  items: Expression;

  @doc("List of activities to execute .")
  activities: Activity[];
}

@doc("Azure ML Batch Execution activity.")
model AzureMLBatchExecutionActivity extends ExecutionActivity {
  @doc("Azure ML Batch Execution activity properties.")
  typeProperties: AzureMLBatchExecutionActivityTypeProperties;

  @doc("Type of activity.")
  type: "AzureMLBatchExecution";
}

@doc("Azure ML Batch Execution activity properties.")
model AzureMLBatchExecutionActivityTypeProperties {
  @doc("Key,Value pairs to be passed to the Azure ML Batch Execution Service endpoint. Keys must match the names of web service parameters defined in the published Azure ML web service. Values will be passed in the GlobalParameters property of the Azure ML batch execution request.")
  globalParameters?: Record<Record<unknown>>;

  @doc("Key,Value pairs, mapping the names of Azure ML endpoint's Web Service Outputs to AzureMLWebServiceFile objects specifying the output Blob locations. This information will be passed in the WebServiceOutputs property of the Azure ML batch execution request.")
  webServiceOutputs?: Record<AzureMLWebServiceFile>;

  @doc("Key,Value pairs, mapping the names of Azure ML endpoint's Web Service Inputs to AzureMLWebServiceFile objects specifying the input Blob locations.. This information will be passed in the WebServiceInputs property of the Azure ML batch execution request.")
  webServiceInputs?: Record<AzureMLWebServiceFile>;
}

@doc("Azure ML WebService Input/Output file")
model AzureMLWebServiceFile {
  @doc("The relative file path, including container name, in the Azure Blob Storage specified by the LinkedService. Type: string (or Expression with resultType string).")
  filePath: Record<unknown>;

  @doc("Reference to an Azure Storage LinkedService, where Azure ML WebService Input/Output file located.")
  linkedServiceName: LinkedServiceReference;
}

@doc("Azure ML Update Resource management activity.")
model AzureMLUpdateResourceActivity extends ExecutionActivity {
  @doc("Azure ML Update Resource management activity properties.")
  typeProperties: AzureMLUpdateResourceActivityTypeProperties;

  @doc("Type of activity.")
  type: "AzureMLUpdateResource";
}

@doc("Azure ML Update Resource activity properties.")
model AzureMLUpdateResourceActivityTypeProperties {
  @doc("Name of the Trained Model module in the Web Service experiment to be updated. Type: string (or Expression with resultType string).")
  trainedModelName: Record<unknown>;

  @doc("Name of Azure Storage linked service holding the .ilearner file that will be uploaded by the update operation.")
  trainedModelLinkedServiceName: LinkedServiceReference;

  @doc("The relative file path in trainedModelLinkedService to represent the .ilearner file that will be uploaded by the update operation.  Type: string (or Expression with resultType string).")
  trainedModelFilePath: Record<unknown>;
}

@doc("Azure ML Execute Pipeline activity.")
model AzureMLExecutePipelineActivity extends ExecutionActivity {
  @doc("Azure ML Execute Pipeline activity properties.")
  typeProperties: AzureMLExecutePipelineActivityTypeProperties;

  @doc("Type of activity.")
  type: "AzureMLExecutePipeline";
}

@doc("Azure ML Execute Pipeline activity properties.")
model AzureMLExecutePipelineActivityTypeProperties {
  @doc("ID of the published Azure ML pipeline. Type: string (or Expression with resultType string).")
  mlPipelineId?: Record<unknown>;

  @doc("ID of the published Azure ML pipeline endpoint. Type: string (or Expression with resultType string).")
  mlPipelineEndpointId?: Record<unknown>;

  @doc("Version of the published Azure ML pipeline endpoint. Type: string (or Expression with resultType string).")
  version?: Record<unknown>;

  @doc("Run history experiment name of the pipeline run. This information will be passed in the ExperimentName property of the published pipeline execution request. Type: string (or Expression with resultType string).")
  experimentName?: Record<unknown>;

  @doc("Key,Value pairs to be passed to the published Azure ML pipeline endpoint. Keys must match the names of pipeline parameters defined in the published pipeline. Values will be passed in the ParameterAssignments property of the published pipeline execution request. Type: object with key value pairs (or Expression with resultType object).")
  mlPipelineParameters?: Record<unknown>;

  @doc("Dictionary used for changing data path assignments without retraining. Values will be passed in the dataPathAssignments property of the published pipeline execution request. Type: object with key value pairs (or Expression with resultType object).")
  dataPathAssignments?: Record<unknown>;

  @doc("The parent Azure ML Service pipeline run id. This information will be passed in the ParentRunId property of the published pipeline execution request. Type: string (or Expression with resultType string).")
  mlParentRunId?: Record<unknown>;

  @doc("Whether to continue execution of other steps in the PipelineRun if a step fails. This information will be passed in the continueOnStepFailure property of the published pipeline execution request. Type: boolean (or Expression with resultType boolean).")
  continueOnStepFailure?: Record<unknown>;
}

@doc("Data Lake Analytics U-SQL activity.")
model DataLakeAnalyticsUsqlActivity extends ExecutionActivity {
  @doc("Data Lake Analytics U-SQL activity properties.")
  typeProperties: DataLakeAnalyticsUsqlActivityTypeProperties;

  @doc("Type of activity.")
  type: "DataLakeAnalyticsU-SQL";
}

@doc("DataLakeAnalyticsU-SQL activity properties.")
model DataLakeAnalyticsUsqlActivityTypeProperties {
  @doc("Case-sensitive path to folder that contains the U-SQL script. Type: string (or Expression with resultType string).")
  scriptPath: Record<unknown>;

  @doc("Script linked service reference.")
  scriptLinkedService: LinkedServiceReference;

  @doc("The maximum number of nodes simultaneously used to run the job. Default value is 1. Type: integer (or Expression with resultType integer), minimum: 1.")
  degreeOfParallelism?: Record<unknown>;

  @doc("Determines which jobs out of all that are queued should be selected to run first. The lower the number, the higher the priority. Default value is 1000. Type: integer (or Expression with resultType integer), minimum: 1.")
  priority?: Record<unknown>;

  @doc("Parameters for U-SQL job request.")
  parameters?: Record<Record<unknown>>;

  @doc("Runtime version of the U-SQL engine to use. Type: string (or Expression with resultType string).")
  runtimeVersion?: Record<unknown>;

  @doc("Compilation mode of U-SQL. Must be one of these values : Semantic, Full and SingleBox. Type: string (or Expression with resultType string).")
  compilationMode?: Record<unknown>;
}

@doc("This activity suspends pipeline execution for the specified interval.")
model WaitActivity extends ControlActivity {
  @doc("Wait activity properties.")
  typeProperties: WaitActivityTypeProperties;

  @doc("Type of activity.")
  type: "Wait";
}

@doc("Wait activity properties.")
model WaitActivityTypeProperties {
  @doc("Duration in seconds. Type: integer (or Expression with resultType integer).")
  waitTimeInSeconds: Record<unknown>;
}

@doc("This activity will fail within its own scope and output a custom error message and error code. The error message and code can provided either as a string literal or as an expression that can be evaluated to a string at runtime. The activity scope can be the whole pipeline or a control activity (e.g. foreach, switch, until), if the fail activity is contained in it.")
model FailActivity extends ControlActivity {
  @doc("Fail activity properties.")
  typeProperties: FailActivityTypeProperties;

  @doc("Type of activity.")
  type: "Fail";
}

@doc("Fail activity properties.")
model FailActivityTypeProperties {
  @doc("The error message that surfaced in the Fail activity. It can be dynamic content that's evaluated to a non empty/blank string at runtime. Type: string (or Expression with resultType string).")
  message: Record<unknown>;

  @doc("The error code that categorizes the error type of the Fail activity. It can be dynamic content that's evaluated to a non empty/blank string at runtime. Type: string (or Expression with resultType string).")
  errorCode: Record<unknown>;
}

@doc("This activity executes inner activities until the specified boolean expression results to true or timeout is reached, whichever is earlier.")
model UntilActivity extends ControlActivity {
  @doc("Until activity properties.")
  typeProperties: UntilActivityTypeProperties;

  @doc("Type of activity.")
  type: "Until";
}

@doc("Until activity properties.")
model UntilActivityTypeProperties {
  @doc("An expression that would evaluate to Boolean. The loop will continue until this expression evaluates to true")
  expression: Expression;

  @doc("Specifies the timeout for the activity to run. If there is no value specified, it takes the value of TimeSpan.FromDays(7) which is 1 week as default. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  timeout?: Record<unknown>;

  @doc("List of activities to execute.")
  activities: Activity[];
}

@doc("This activity verifies that an external resource exists.")
model ValidationActivity extends ControlActivity {
  @doc("Validation activity properties.")
  typeProperties: ValidationActivityTypeProperties;

  @doc("Type of activity.")
  type: "Validation";
}

@doc("Validation activity properties.")
model ValidationActivityTypeProperties {
  @doc("Specifies the timeout for the activity to run. If there is no value specified, it takes the value of TimeSpan.FromDays(7) which is 1 week as default. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  timeout?: Record<unknown>;

  @doc("A delay in seconds between validation attempts. If no value is specified, 10 seconds will be used as the default. Type: integer (or Expression with resultType integer).")
  sleep?: Record<unknown>;

  @doc("Can be used if dataset points to a file. The file must be greater than or equal in size to the value specified. Type: integer (or Expression with resultType integer).")
  minimumSize?: Record<unknown>;

  @doc("Can be used if dataset points to a folder. If set to true, the folder must have at least one file. If set to false, the folder must be empty. Type: boolean (or Expression with resultType boolean).")
  childItems?: Record<unknown>;

  @doc("Validation activity dataset reference.")
  dataset: DatasetReference;
}

@doc("Filter and return results from input array based on the conditions.")
model FilterActivity extends ControlActivity {
  @doc("Filter activity properties.")
  typeProperties: FilterActivityTypeProperties;

  @doc("Type of activity.")
  type: "Filter";
}

@doc("Filter activity properties.")
model FilterActivityTypeProperties {
  @doc("Input array on which filter should be applied.")
  items: Expression;

  @doc("Condition to be used for filtering the input.")
  condition: Expression;
}

@doc("DatabricksNotebook activity.")
model DatabricksNotebookActivity extends ExecutionActivity {
  @doc("Databricks Notebook activity properties.")
  typeProperties: DatabricksNotebookActivityTypeProperties;

  @doc("Type of activity.")
  type: "DatabricksNotebook";
}

@doc("Databricks Notebook activity properties.")
model DatabricksNotebookActivityTypeProperties {
  @doc("The absolute path of the notebook to be run in the Databricks Workspace. This path must begin with a slash. Type: string (or Expression with resultType string).")
  notebookPath: Record<unknown>;

  @doc("Base parameters to be used for each run of this job.If the notebook takes a parameter that is not specified, the default value from the notebook will be used.")
  baseParameters?: Record<Record<unknown>>;

  @doc("A list of libraries to be installed on the cluster that will execute the job.")
  libraries?: Record<Record<unknown>>[];
}

@doc("DatabricksSparkJar activity.")
model DatabricksSparkJarActivity extends ExecutionActivity {
  @doc("Databricks SparkJar activity properties.")
  typeProperties: DatabricksSparkJarActivityTypeProperties;

  @doc("Type of activity.")
  type: "DatabricksSparkJar";
}

@doc("Databricks SparkJar activity properties.")
model DatabricksSparkJarActivityTypeProperties {
  @doc("The full name of the class containing the main method to be executed. This class must be contained in a JAR provided as a library. Type: string (or Expression with resultType string).")
  mainClassName: Record<unknown>;

  @doc("Parameters that will be passed to the main method.")
  parameters?: Record<unknown>[];

  @doc("A list of libraries to be installed on the cluster that will execute the job.")
  libraries?: Record<Record<unknown>>[];
}

@doc("DatabricksSparkPython activity.")
model DatabricksSparkPythonActivity extends ExecutionActivity {
  @doc("Databricks SparkPython activity properties.")
  typeProperties: DatabricksSparkPythonActivityTypeProperties;

  @doc("Type of activity.")
  type: "DatabricksSparkPython";
}

@doc("Databricks SparkPython activity properties.")
model DatabricksSparkPythonActivityTypeProperties {
  @doc("The URI of the Python file to be executed. DBFS paths are supported. Type: string (or Expression with resultType string).")
  pythonFile: Record<unknown>;

  @doc("Command line parameters that will be passed to the Python file.")
  parameters?: Record<unknown>[];

  @doc("A list of libraries to be installed on the cluster that will execute the job.")
  libraries?: Record<Record<unknown>>[];
}

@doc("Set value for a Variable.")
model SetVariableActivity extends ControlActivity {
  @doc("Set Variable activity properties.")
  typeProperties: SetVariableActivityTypeProperties;

  @doc("Activity policy.")
  policy?: SecureInputOutputPolicy;

  @doc("Type of activity.")
  type: "SetVariable";
}

@doc("SetVariable activity properties.")
model SetVariableActivityTypeProperties {
  @doc("Name of the variable whose value needs to be set.")
  variableName?: string;

  @doc("Value to be set. Could be a static value or Expression.")
  value?: Record<unknown>;

  @doc("If set to true, it sets the pipeline run return value.")
  setSystemVariable?: boolean;
}

@doc("Execution policy for an activity that supports secure input and output.")
model SecureInputOutputPolicy {
  @doc("When set to true, Input from activity is considered as secure and will not be logged to monitoring.")
  secureInput?: boolean;

  @doc("When set to true, Output from activity is considered as secure and will not be logged to monitoring.")
  secureOutput?: boolean;
}

@doc("Append value for a Variable of type Array.")
model AppendVariableActivity extends ControlActivity {
  @doc("Append Variable activity properties.")
  typeProperties: AppendVariableActivityTypeProperties;

  @doc("Type of activity.")
  type: "AppendVariable";
}

@doc("AppendVariable activity properties.")
model AppendVariableActivityTypeProperties {
  @doc("Name of the variable whose value needs to be appended to.")
  variableName?: string;

  @doc("Value to be appended. Type: could be a static value matching type of the variable item or Expression with resultType matching type of the variable item")
  value?: Record<unknown>;
}

@doc("Azure Function activity.")
model AzureFunctionActivity extends ExecutionActivity {
  @doc("Azure Function activity properties.")
  typeProperties: AzureFunctionActivityTypeProperties;

  @doc("Type of activity.")
  type: "AzureFunctionActivity";
}

@doc("Azure Function activity type properties.")
model AzureFunctionActivityTypeProperties {
  @doc("Rest API method for target endpoint.")
  method: AzureFunctionActivityMethod;

  @doc("Name of the Function that the Azure Function Activity will call. Type: string (or Expression with resultType string)")
  functionName: Record<unknown>;

  @doc("Represents the headers that will be sent to the request. For example, to set the language and type on a request: \"headers\" : { \"Accept-Language\": \"en-us\", \"Content-Type\": \"application/json\" }. Type: string (or Expression with resultType string).")
  headers?: Record<unknown>;

  @doc("Represents the payload that will be sent to the endpoint. Required for POST/PUT method, not allowed for GET method Type: string (or Expression with resultType string).")
  body?: Record<unknown>;
}

@doc("WebHook activity.")
model WebHookActivity extends ControlActivity {
  @doc("WebHook activity properties.")
  typeProperties: WebHookActivityTypeProperties;

  @doc("Activity policy.")
  policy?: SecureInputOutputPolicy;

  @doc("Type of activity.")
  type: "WebHook";
}

@doc("WebHook activity type properties.")
model WebHookActivityTypeProperties {
  @doc("Rest API method for target endpoint.")
  method: WebHookActivityMethod;

  @doc("WebHook activity target endpoint and path. Type: string (or Expression with resultType string).")
  url: Record<unknown>;

  @doc("The timeout within which the webhook should be called back. If there is no value specified, it defaults to 10 minutes. Type: string. Pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  timeout?: string;

  @doc("Represents the headers that will be sent to the request. For example, to set the language and type on a request: \"headers\" : { \"Accept-Language\": \"en-us\", \"Content-Type\": \"application/json\" }. Type: string (or Expression with resultType string).")
  headers?: Record<unknown>;

  @doc("Represents the payload that will be sent to the endpoint. Required for POST/PUT method, not allowed for GET method Type: string (or Expression with resultType string).")
  body?: Record<unknown>;

  @doc("Authentication method used for calling the endpoint.")
  authentication?: WebActivityAuthentication;

  @doc("When set to true, statusCode, output and error in callback request body will be consumed by activity. The activity can be marked as failed by setting statusCode >= 400 in callback request. Default is false. Type: boolean (or Expression with resultType boolean).")
  reportStatusOnCallBack?: Record<unknown>;
}

@doc("Execute data flow activity.")
model ExecuteDataFlowActivity extends ExecutionActivity {
  @doc("Execute data flow activity properties.")
  typeProperties: ExecuteDataFlowActivityTypeProperties;

  @doc("Type of activity.")
  type: "ExecuteDataFlow";
}

@doc("Execute data flow activity properties.")
model ExecuteDataFlowActivityTypeProperties {
  @doc("Data flow reference.")
  dataFlow: DataFlowReference;

  @doc("Staging info for execute data flow activity.")
  staging?: DataFlowStagingInfo;

  @doc("The integration runtime reference.")
  integrationRuntime?: IntegrationRuntimeReference;

  @doc("Compute properties for data flow activity.")
  compute?: ExecuteDataFlowActivityTypePropertiesCompute;

  @doc("Trace level setting used for data flow monitoring output. Supported values are: 'coarse', 'fine', and 'none'. Type: string (or Expression with resultType string)")
  traceLevel?: Record<unknown>;

  @doc("Continue on error setting used for data flow execution. Enables processing to continue if a sink fails. Type: boolean (or Expression with resultType boolean)")
  continueOnError?: Record<unknown>;

  @doc("Concurrent run setting used for data flow execution. Allows sinks with the same save order to be processed concurrently. Type: boolean (or Expression with resultType boolean)")
  runConcurrently?: Record<unknown>;

  @doc("Specify number of parallel staging for sources applicable to the sink. Type: integer (or Expression with resultType integer)")
  sourceStagingConcurrency?: Record<unknown>;
}

@doc("Compute properties for data flow activity.")
model ExecuteDataFlowActivityTypePropertiesCompute {
  @doc("Compute type of the cluster which will execute data flow job. Possible values include: 'General', 'MemoryOptimized', 'ComputeOptimized'. Type: string (or Expression with resultType string)")
  computeType?: Record<unknown>;

  @doc("Core count of the cluster which will execute data flow job. Supported values are: 8, 16, 32, 48, 80, 144 and 272. Type: integer (or Expression with resultType integer)")
  coreCount?: Record<unknown>;
}

@doc("Execute power query activity.")
model ExecuteWranglingDataflowActivity extends Activity {
  @doc("Execute power query activity properties.")
  typeProperties: ExecutePowerQueryActivityTypeProperties;

  @doc("Activity policy.")
  policy?: ActivityPolicy;

  @doc("Type of activity.")
  type: "ExecuteWranglingDataflow";
}

@doc("Execute power query data flow activity properties.")
model ExecutePowerQueryActivityTypeProperties
  extends ExecuteDataFlowActivityTypeProperties {
  @doc("(Deprecated. Please use Queries). List of Power Query activity sinks mapped to a queryName.")
  sinks?: Record<PowerQuerySink>;

  @doc("List of mapping for Power Query mashup query to sink dataset(s).")
  queries?: PowerQuerySinkMapping[];
}

@doc("Map Power Query mashup query to sink dataset(s).")
model PowerQuerySinkMapping {
  @doc("Name of the query in Power Query mashup document.")
  queryName?: string;

  @doc("List of sinks mapped to Power Query mashup query.")
  dataflowSinks?: PowerQuerySink[];
}

@doc("Script activity type.")
model ScriptActivity extends ExecutionActivity {
  @doc("Script activity properties.")
  typeProperties: ScriptActivityTypeProperties;

  @doc("Type of activity.")
  type: "Script";
}

@doc("Script activity properties.")
model ScriptActivityTypeProperties {
  @doc("ScriptBlock execution timeout. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  scriptBlockExecutionTimeout?: Record<unknown>;

  @doc("Array of script blocks. Type: array.")
  scripts?: ScriptActivityScriptBlock[];

  @doc("Log settings of script activity.")
  logSettings?: ScriptActivityTypePropertiesLogSettings;
}

@doc("Script block of scripts.")
model ScriptActivityScriptBlock {
  @doc("The query text. Type: string (or Expression with resultType string).")
  text: Record<unknown>;

  @doc("The type of the query. Type: string.")
  type: ScriptType;

  @doc("Array of script parameters. Type: array.")
  parameters?: ScriptActivityParameter[];
}

@doc("Parameters of a script block.")
model ScriptActivityParameter {
  @doc("The name of the parameter. Type: string (or Expression with resultType string).")
  name?: Record<unknown>;

  @doc("The type of the parameter.")
  type?: ScriptActivityParameterType;

  @doc("The value of the parameter. Type: string (or Expression with resultType string).")
  value?: Record<unknown>;

  @doc("The direction of the parameter.")
  direction?: ScriptActivityParameterDirection;

  @doc("The size of the output direction parameter.")
  size?: int32;
}

@doc("Log settings of script activity.")
model ScriptActivityTypePropertiesLogSettings {
  @doc("The destination of logs. Type: string.")
  logDestination: ScriptActivityLogDestination;

  @doc("Log location settings customer needs to provide when enabling log.")
  logLocationSettings?: LogLocationSettings;
}

@doc("A copy activity source for sharePoint online list source.")
model SharePointOnlineListSource extends CopySource {
  @doc("The OData query to filter the data in SharePoint Online list. For example, \"$top=1\". Type: string (or Expression with resultType string).")
  query?: Record<unknown>;

  @doc("The wait time to get a response from SharePoint Online. Default value is 5 minutes (00:05:00). Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  httpRequestTimeout?: Record<unknown>;

  @doc("Copy source type.")
  type: "SharePointOnlineListSource";
}

@doc("Execute Synapse notebook activity.")
model SynapseNotebookActivity extends ExecutionActivity {
  @doc("Execute Synapse notebook activity properties.")
  typeProperties: SynapseNotebookActivityTypeProperties;

  @doc("Type of activity.")
  type: "SynapseNotebook";
}

@doc("Execute Synapse notebook activity properties.")
model SynapseNotebookActivityTypeProperties {
  @doc("Synapse notebook reference.")
  notebook: SynapseNotebookReference;

  @doc("The name of the big data pool which will be used to execute the notebook.")
  sparkPool?: BigDataPoolParametrizationReference;

  @doc("Notebook parameters.")
  parameters?: Record<NotebookParameter>;

  @doc("Number of core and memory to be used for executors allocated in the specified Spark pool for the session, which will be used for overriding 'executorCores' and 'executorMemory' of the notebook you provide. Type: string (or Expression with resultType string).")
  executorSize?: Record<unknown>;

  @doc("Spark configuration properties, which will override the 'conf' of the notebook you provide.")
  conf?: Record<unknown>;

  @doc("Number of core and memory to be used for driver allocated in the specified Spark pool for the session, which will be used for overriding 'driverCores' and 'driverMemory' of the notebook you provide. Type: string (or Expression with resultType string).")
  driverSize?: Record<unknown>;

  @doc("Number of executors to launch for this session, which will override the 'numExecutors' of the notebook you provide. Type: integer (or Expression with resultType integer).")
  numExecutors?: Record<unknown>;

  @doc("The type of the spark config.")
  configurationType?: ConfigurationType;

  @doc("The spark configuration of the spark job.")
  targetSparkConfiguration?: SparkConfigurationParametrizationReference;

  @doc("Spark configuration property.")
  sparkConfig?: Record<Record<unknown>>;
}

@doc("Synapse notebook reference type.")
model SynapseNotebookReference {
  @doc("Synapse notebook reference type.")
  type: NotebookReferenceType;

  @doc("Reference notebook name. Type: string (or Expression with resultType string).")
  referenceName: Record<unknown>;
}

@doc("Big data pool reference type.")
model BigDataPoolParametrizationReference {
  @doc("Big data pool reference type.")
  type: BigDataPoolReferenceType;

  @doc("Reference big data pool name. Type: string (or Expression with resultType string).")
  referenceName: Record<unknown>;
}

@doc("Notebook parameter.")
model NotebookParameter {
  @doc("Notebook parameter value. Type: string (or Expression with resultType string).")
  value?: Record<unknown>;

  @doc("Notebook parameter type.")
  type?: NotebookParameterType;
}

@doc("Spark configuration reference.")
model SparkConfigurationParametrizationReference {
  @doc("Spark configuration reference type.")
  type: SparkConfigurationReferenceType;

  @doc("Reference spark configuration name. Type: string (or Expression with resultType string).")
  referenceName: Record<unknown>;
}

@doc("Execute spark job activity.")
model SynapseSparkJobDefinitionActivity extends ExecutionActivity {
  @doc("Execute spark job activity properties.")
  typeProperties: SynapseSparkJobActivityTypeProperties;

  @doc("Type of activity.")
  type: "SparkJob";
}

@doc("Execute spark job activity properties.")
model SynapseSparkJobActivityTypeProperties {
  @doc("Synapse spark job reference.")
  sparkJob: SynapseSparkJobReference;

  @doc("User specified arguments to SynapseSparkJobDefinitionActivity.")
  @projectedName("json", "args")
  arguments?: unknown[];

  @doc("The main file used for the job, which will override the 'file' of the spark job definition you provide. Type: string (or Expression with resultType string).")
  file?: Record<unknown>;

  @doc("Scanning subfolders from the root folder of the main definition file, these files will be added as reference files. The folders named 'jars', 'pyFiles', 'files' or 'archives' will be scanned, and the folders name are case sensitive. Type: boolean (or Expression with resultType boolean).")
  scanFolder?: Record<unknown>;

  @doc("The fully-qualified identifier or the main class that is in the main definition file, which will override the 'className' of the spark job definition you provide. Type: string (or Expression with resultType string).")
  className?: Record<unknown>;

  @doc("(Deprecated. Please use pythonCodeReference and filesV2) Additional files used for reference in the main definition file, which will override the 'files' of the spark job definition you provide.")
  files?: Record<unknown>[];

  @doc("Additional python code files used for reference in the main definition file, which will override the 'pyFiles' of the spark job definition you provide.")
  pythonCodeReference?: Record<unknown>[];

  @doc("Additional files used for reference in the main definition file, which will override the 'jars' and 'files' of the spark job definition you provide.")
  filesV2?: Record<unknown>[];

  @doc("The name of the big data pool which will be used to execute the spark batch job, which will override the 'targetBigDataPool' of the spark job definition you provide.")
  targetBigDataPool?: BigDataPoolParametrizationReference;

  @doc("Number of core and memory to be used for executors allocated in the specified Spark pool for the job, which will be used for overriding 'executorCores' and 'executorMemory' of the spark job definition you provide. Type: string (or Expression with resultType string).")
  executorSize?: Record<unknown>;

  @doc("Spark configuration properties, which will override the 'conf' of the spark job definition you provide.")
  conf?: Record<unknown>;

  @doc("Number of core and memory to be used for driver allocated in the specified Spark pool for the job, which will be used for overriding 'driverCores' and 'driverMemory' of the spark job definition you provide. Type: string (or Expression with resultType string).")
  driverSize?: Record<unknown>;

  @doc("Number of executors to launch for this job, which will override the 'numExecutors' of the spark job definition you provide. Type: integer (or Expression with resultType integer).")
  numExecutors?: Record<unknown>;

  @doc("The type of the spark config.")
  configurationType?: ConfigurationType;

  @doc("The spark configuration of the spark job.")
  targetSparkConfiguration?: SparkConfigurationParametrizationReference;

  @doc("Spark configuration property.")
  sparkConfig?: Record<Record<unknown>>;
}

@doc("Synapse spark job reference type.")
model SynapseSparkJobReference {
  @doc("Synapse spark job reference type.")
  type: SparkJobReferenceType;

  @doc("Reference spark job name. Expression with resultType string.")
  referenceName: Record<unknown>;
}

@doc("Base class for all triggers that support one to many model for trigger to pipeline.")
@discriminator("type")
model MultiplePipelineTrigger extends Trigger {
  @doc("Pipelines that need to be started.")
  pipelines?: TriggerPipelineReference[];
}

@doc("Trigger that creates pipeline runs periodically, on schedule.")
model ScheduleTrigger extends MultiplePipelineTrigger {
  @doc("Schedule Trigger properties.")
  typeProperties: ScheduleTriggerTypeProperties;

  @doc("Trigger type.")
  type: "ScheduleTrigger";
}

@doc("Schedule Trigger properties.")
model ScheduleTriggerTypeProperties {
  @doc("Recurrence schedule configuration.")
  recurrence: ScheduleTriggerRecurrence;
}

@doc("The workflow trigger recurrence.")
model ScheduleTriggerRecurrence extends Record<Record<unknown>> {
  @doc("The frequency.")
  frequency?: RecurrenceFrequency;

  @doc("The interval.")
  interval?: int32;

  @doc("The start time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The end time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The time zone.")
  timeZone?: string;

  @doc("The recurrence schedule.")
  schedule?: RecurrenceSchedule;
}

@doc("The recurrence schedule.")
model RecurrenceSchedule extends Record<Record<unknown>> {
  @doc("The minutes.")
  minutes?: int32[];

  @doc("The hours.")
  hours?: int32[];

  @doc("The days of the week.")
  weekDays?: DaysOfWeek[];

  @doc("The month days.")
  monthDays?: int32[];

  @doc("The monthly occurrences.")
  monthlyOccurrences?: RecurrenceScheduleOccurrence[];
}

@doc("The recurrence schedule occurrence.")
model RecurrenceScheduleOccurrence extends Record<Record<unknown>> {
  @doc("The day of the week.")
  day?: DayOfWeek;

  @doc("The occurrence.")
  occurrence?: int32;
}

@doc("Trigger that runs every time the selected Blob container changes.")
model BlobTrigger extends MultiplePipelineTrigger {
  @doc("Blob Trigger properties.")
  typeProperties: BlobTriggerTypeProperties;

  @doc("Trigger type.")
  type: "BlobTrigger";
}

@doc("Blob Trigger properties.")
model BlobTriggerTypeProperties {
  @doc("The path of the container/folder that will trigger the pipeline.")
  folderPath: string;

  @doc("The max number of parallel files to handle when it is triggered.")
  maxConcurrency: int32;

  @doc("The Azure Storage linked service reference.")
  linkedService: LinkedServiceReference;
}

@doc("Trigger that runs every time a Blob event occurs.")
model BlobEventsTrigger extends MultiplePipelineTrigger {
  @doc("Blob Events Trigger properties.")
  typeProperties: BlobEventsTriggerTypeProperties;

  @doc("Trigger type.")
  type: "BlobEventsTrigger";
}

@doc("Blob Events Trigger properties.")
model BlobEventsTriggerTypeProperties {
  @doc("The blob path must begin with the pattern provided for trigger to fire. For example, '/records/blobs/december/' will only fire the trigger for blobs in the december folder under the records container. At least one of these must be provided: blobPathBeginsWith, blobPathEndsWith.")
  blobPathBeginsWith?: string;

  @doc("The blob path must end with the pattern provided for trigger to fire. For example, 'december/boxes.csv' will only fire the trigger for blobs named boxes in a december folder. At least one of these must be provided: blobPathBeginsWith, blobPathEndsWith.")
  blobPathEndsWith?: string;

  @doc("If set to true, blobs with zero bytes will be ignored.")
  ignoreEmptyBlobs?: boolean;

  @doc("The type of events that cause this trigger to fire.")
  events: BlobEventTypes[];

  @doc("The ARM resource ID of the Storage Account.")
  scope: string;
}

@doc("Trigger that runs every time a custom event is received.")
model CustomEventsTrigger extends MultiplePipelineTrigger {
  @doc("Custom Events Trigger properties.")
  typeProperties: CustomEventsTriggerTypeProperties;

  @doc("Trigger type.")
  type: "CustomEventsTrigger";
}

@doc("Custom Events Trigger properties.")
model CustomEventsTriggerTypeProperties {
  @doc("The event subject must begin with the pattern provided for trigger to fire. At least one of these must be provided: subjectBeginsWith, subjectEndsWith.")
  subjectBeginsWith?: string;

  @doc("The event subject must end with the pattern provided for trigger to fire. At least one of these must be provided: subjectBeginsWith, subjectEndsWith.")
  subjectEndsWith?: string;

  @doc("The list of event types that cause this trigger to fire.")
  events: Record<unknown>[];

  @doc("The ARM resource ID of the Azure Event Grid Topic.")
  scope: string;
}

@doc("Trigger that schedules pipeline runs for all fixed time interval windows from a start time without gaps and also supports backfill scenarios (when start time is in the past).")
model TumblingWindowTrigger extends Trigger {
  @doc("Pipeline for which runs are created when an event is fired for trigger window that is ready.")
  pipeline: TriggerPipelineReference;

  @doc("Tumbling Window Trigger properties.")
  typeProperties: TumblingWindowTriggerTypeProperties;

  @doc("Trigger type.")
  type: "TumblingWindowTrigger";
}

@doc("Tumbling Window Trigger properties.")
model TumblingWindowTriggerTypeProperties {
  @doc("The frequency of the time windows.")
  frequency: TumblingWindowFrequency;

  @doc("The interval of the time windows. The minimum interval allowed is 15 Minutes.")
  interval: int32;

  @doc("The start time for the time period for the trigger during which events are fired for windows that are ready. Only UTC time is currently supported.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  @doc("The end time for the time period for the trigger during which events are fired for windows that are ready. Only UTC time is currently supported.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Specifies how long the trigger waits past due time before triggering new run. It doesn't alter window start and end time. The default is 0. Type: string (or Expression with resultType string), pattern: ((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9])).")
  delay?: Record<unknown>;

  @doc("The max number of parallel time windows (ready for execution) for which a new run is triggered.")
  @maxValue(50)
  @minValue(1)
  maxConcurrency: int32;

  @doc("Retry policy that will be applied for failed pipeline runs.")
  retryPolicy?: RetryPolicy;

  @doc("Triggers that this trigger depends on. Only tumbling window triggers are supported.")
  dependsOn?: DependencyReference[];
}

@doc("Execution policy for an activity.")
model RetryPolicy {
  @doc("Maximum ordinary retry attempts. Default is 0. Type: integer (or Expression with resultType integer), minimum: 0.")
  count?: Record<unknown>;

  @doc("Interval between retries in seconds. Default is 30.")
  @maxValue(86400)
  @minValue(30)
  intervalInSeconds?: int32;
}

@doc("Referenced dependency.")
@discriminator("type")
model DependencyReference {}

@doc("Trigger reference type.")
model TriggerReference {
  @doc("Trigger reference type.")
  type: TriggerReferenceType;

  @doc("Reference trigger name.")
  referenceName: string;
}

@doc("Trigger referenced dependency.")
@discriminator("type")
model TriggerDependencyReference extends DependencyReference {
  @doc("Referenced trigger.")
  referenceTrigger: TriggerReference;
}

@doc("Referenced tumbling window trigger dependency.")
model TumblingWindowTriggerDependencyReference
  extends TriggerDependencyReference {
  @doc("Timespan applied to the start time of a tumbling window when evaluating dependency.")
  @maxLength(15)
  @minLength(8)
  @pattern("-?((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9]))")
  offset?: string;

  @doc("The size of the window when evaluating the dependency. If undefined the frequency of the tumbling window will be used.")
  @maxLength(15)
  @minLength(8)
  @pattern("((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9]))")
  size?: string;

  @doc("The type of dependency reference.")
  type: "TumblingWindowTriggerDependencyReference";
}

@doc("Self referenced tumbling window trigger dependency.")
model SelfDependencyTumblingWindowTriggerReference extends DependencyReference {
  @doc("Timespan applied to the start time of a tumbling window when evaluating dependency.")
  @maxLength(15)
  @minLength(8)
  @pattern("-((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9]))")
  offset: string;

  @doc("The size of the window when evaluating the dependency. If undefined the frequency of the tumbling window will be used.")
  @maxLength(15)
  @minLength(8)
  @pattern("((\\d+)\\.)?(\\d\\d):(60|([0-5][0-9])):(60|([0-5][0-9]))")
  size?: string;

  @doc("The type of dependency reference.")
  type: "SelfDependencyTumblingWindowTriggerReference";
}

@doc("Trigger that schedules pipeline reruns for all fixed time interval windows from a requested start time to requested end time.")
model RerunTumblingWindowTrigger extends Trigger {
  @doc("Rerun Trigger properties.")
  typeProperties: RerunTumblingWindowTriggerTypeProperties;

  @doc("Trigger type.")
  type: "RerunTumblingWindowTrigger";
}

@doc("Rerun Trigger properties.")
model RerunTumblingWindowTriggerTypeProperties {
  @doc("The parent trigger reference.")
  parentTrigger: Record<unknown>;

  @doc("The start time for the time period for which restatement is initiated. Only UTC time is currently supported.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestedStartTime: utcDateTime;

  @doc("The end time for the time period for which restatement is initiated. Only UTC time is currently supported.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestedEndTime: utcDateTime;

  @doc("The max number of parallel time windows (ready for execution) for which a rerun is triggered.")
  @maxValue(50)
  @minValue(1)
  rerunConcurrency: int32;
}

@doc("Trigger that allows the referenced pipeline to depend on other pipeline runs based on runDimension Name/Value pairs. Upstream pipelines should declare the same runDimension Name and their runs should have the values for those runDimensions. The referenced pipeline run would be triggered if the values for the runDimension match for all upstream pipeline runs.")
model ChainingTrigger extends Trigger {
  @doc("Pipeline for which runs are created when all upstream pipelines complete successfully.")
  pipeline: TriggerPipelineReference;

  @doc("Chaining Trigger properties.")
  typeProperties: ChainingTriggerTypeProperties;

  @doc("Trigger type.")
  type: "ChainingTrigger";
}

@doc("Chaining Trigger properties.")
model ChainingTriggerTypeProperties {
  @doc("Upstream Pipelines.")
  dependsOn: PipelineReference[];

  @doc("Run Dimension property that needs to be emitted by upstream pipelines.")
  runDimension: string;
}

@doc("Service principal credential.")
model ServicePrincipalCredential extends Credential {
  @doc("Service Principal credential properties.")
  typeProperties: ServicePrincipalCredentialTypeProperties;

  @doc("Type of credential.")
  type: "ServicePrincipal";
}

@doc("Service Principal credential type properties.")
model ServicePrincipalCredentialTypeProperties {
  @doc("The app ID of the service principal used to authenticate")
  servicePrincipalId?: Record<unknown>;

  @doc("The key of the service principal used to authenticate.")
  servicePrincipalKey?: AzureKeyVaultSecretReference;

  @doc("The ID of the tenant to which the service principal belongs")
  tenant?: Record<unknown>;
}
