import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.CognitiveServices;

/**
 * Gets the status of the cognitive services account at the time the operation was called.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResolvingDNS: "ResolvingDNS",
}

/**
 * The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.
 */
union NetworkRuleAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deny: "Deny",
}

/**
 * Setting for trusted services.
 */
union ByPassSelection {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureServices: "AzureServices",
}

/**
 * Enumerates the possible value of keySource for Encryption
 */
union KeySource {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.CognitiveServices`: "Microsoft.CognitiveServices",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.KeyVault`: "Microsoft.KeyVault",
}

/**
 * The private endpoint connection status.
 */
union PrivateEndpointServiceConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Rejected: "Rejected",
}

/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union PrivateEndpointConnectionProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * Whether or not public endpoint access is allowed for this account.
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Multiregion routing methods.
 */
union RoutingMethods {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Priority: "Priority",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Weighted: "Weighted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Performance: "Performance",
}

/**
 * The action of AbusePenalty.
 */
union AbusePenaltyAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Throttle: "Throttle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Block: "Block",
}

/**
 * The reason for restriction.
 */
union ResourceSkuRestrictionsReasonCode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  QuotaId: "QuotaId",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotAvailableForSubscription: "NotAvailableForSubscription",
}

/**
 * The unit of the metric.
 */
union UnitType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Count: "Count",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Bytes: "Bytes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Seconds: "Seconds",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Percent: "Percent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CountPerSecond: "CountPerSecond",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  BytesPerSecond: "BytesPerSecond",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Milliseconds: "Milliseconds",
}

/**
 * Cognitive Services account quota usage status.
 */
union QuotaUsageStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Included: "Included",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Blocked: "Blocked",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InOverage: "InOverage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
}

/**
 * Model lifecycle status.
 */
union ModelLifecycleStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Stable: "Stable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Preview: "Preview",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GenerallyAvailable: "GenerallyAvailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deprecating: "Deprecating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deprecated: "Deprecated",
}

/**
 * Account hosting model.
 */
union HostingModel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Web: "Web",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ConnectedContainer: "ConnectedContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DisconnectedContainer: "DisconnectedContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ProvisionedWeb: "ProvisionedWeb",
}

/**
 * Gets the status of the resource at the time the operation was called.
 */
union DeploymentProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * Deployment scale type.
 */
union DeploymentScaleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Manual: "Manual",
}

/**
 * Deployment model version upgrade option.
 */
union DeploymentModelVersionUpgradeOption {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OnceNewDefaultVersionAvailable: "OnceNewDefaultVersionAvailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OnceCurrentVersionExpired: "OnceCurrentVersionExpired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NoAutoUpgrade: "NoAutoUpgrade",
}

/**
 * Gets the status of the resource at the time the operation was called.
 */
union CommitmentPlanProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * Gets the status of the resource at the time the operation was called.
 */
union EncryptionScopeProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * The encryptionScope state.
 */
union EncryptionScopeState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * Content Filters policy type.
 */
union RaiPolicyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserManaged: "UserManaged",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemManaged: "SystemManaged",
}

/**
 * Rai policy mode. The enum value mapping is as below: Default = 0, Deferred=1, Blocking=2, Asynchronous_filter =3. Please use 'Asynchronous_filter' after 2025-04-01-preview. It is the same as 'Deferred' in previous version.
 */
union RaiPolicyMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deferred: "Deferred",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Blocking: "Blocking",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Asynchronous_filter: "Asynchronous_filter",
}

/**
 * Level at which content is filtered.
 */
union ContentLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Low: "Low",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Medium: "Medium",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  High: "High",
}

/**
 * Content source to apply the Content Filters.
 */
union RaiPolicyContentSource {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Prompt: "Prompt",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Completion: "Completion",
}

/**
 * Direction of Access Rule
 */
union NspAccessRuleDirection {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Inbound: "Inbound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Outbound: "Outbound",
}

/**
 * Defender for AI state on the AI resource.
 */
union DefenderForAISettingState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * Authentication type of the connection target
 */
union ConnectionAuthType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PAT: "PAT",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UsernamePassword: "UsernamePassword",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SAS: "SAS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AccountKey: "AccountKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ServicePrincipal: "ServicePrincipal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AccessKey: "AccessKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ApiKey: "ApiKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CustomKeys: "CustomKeys",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OAuth2: "OAuth2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AAD: "AAD",
}

/**
 * Category of the connection
 */
union ConnectionCategory {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PythonFeed: "PythonFeed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ContainerRegistry: "ContainerRegistry",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Git: "Git",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S3: "S3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Snowflake: "Snowflake",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureSqlDb: "AzureSqlDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureSynapseAnalytics: "AzureSynapseAnalytics",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureMySqlDb: "AzureMySqlDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzurePostgresDb: "AzurePostgresDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ADLSGen2: "ADLSGen2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Redis: "Redis",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ApiKey: "ApiKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureOpenAI: "AzureOpenAI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AIServices: "AIServices",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CognitiveSearch: "CognitiveSearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CognitiveService: "CognitiveService",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CustomKeys: "CustomKeys",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureBlob: "AzureBlob",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureOneLake: "AzureOneLake",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CosmosDb: "CosmosDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CosmosDbMongoDbApi: "CosmosDbMongoDbApi",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureDataExplorer: "AzureDataExplorer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureMariaDb: "AzureMariaDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureDatabricksDeltaLake: "AzureDatabricksDeltaLake",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureSqlMi: "AzureSqlMi",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureTableStorage: "AzureTableStorage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AmazonRdsForOracle: "AmazonRdsForOracle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AmazonRdsForSqlServer: "AmazonRdsForSqlServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AmazonRedshift: "AmazonRedshift",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Db2: "Db2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Drill: "Drill",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GoogleBigQuery: "GoogleBigQuery",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Greenplum: "Greenplum",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Hbase: "Hbase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Hive: "Hive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Impala: "Impala",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Informix: "Informix",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MariaDb: "MariaDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MicrosoftAccess: "MicrosoftAccess",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MySql: "MySql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Netezza: "Netezza",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Oracle: "Oracle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Phoenix: "Phoenix",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PostgreSql: "PostgreSql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Presto: "Presto",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SapOpenHub: "SapOpenHub",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SapBw: "SapBw",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SapHana: "SapHana",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SapTable: "SapTable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Spark: "Spark",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SqlServer: "SqlServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Sybase: "Sybase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Teradata: "Teradata",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Vertica: "Vertica",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pinecone: "Pinecone",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Cassandra: "Cassandra",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Couchbase: "Couchbase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MongoDbV2: "MongoDbV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MongoDbAtlas: "MongoDbAtlas",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AmazonS3Compatible: "AmazonS3Compatible",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  FileServer: "FileServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  FtpServer: "FtpServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GoogleCloudStorage: "GoogleCloudStorage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Hdfs: "Hdfs",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OracleCloudStorage: "OracleCloudStorage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Sftp: "Sftp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GenericHttp: "GenericHttp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ODataRest: "ODataRest",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Odbc: "Odbc",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GenericRest: "GenericRest",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AmazonMws: "AmazonMws",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Concur: "Concur",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Dynamics: "Dynamics",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DynamicsAx: "DynamicsAx",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DynamicsCrm: "DynamicsCrm",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GoogleAdWords: "GoogleAdWords",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Hubspot: "Hubspot",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Jira: "Jira",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Magento: "Magento",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Marketo: "Marketo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Office365: "Office365",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Eloqua: "Eloqua",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Responsys: "Responsys",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OracleServiceCloud: "OracleServiceCloud",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PayPal: "PayPal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  QuickBooks: "QuickBooks",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Salesforce: "Salesforce",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SalesforceServiceCloud: "SalesforceServiceCloud",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SalesforceMarketingCloud: "SalesforceMarketingCloud",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SapCloudForCustomer: "SapCloudForCustomer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SapEcc: "SapEcc",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ServiceNow: "ServiceNow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SharePointOnlineList: "SharePointOnlineList",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Shopify: "Shopify",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Square: "Square",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WebTable: "WebTable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Xero: "Xero",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Zoho: "Zoho",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GenericContainerRegistry: "GenericContainerRegistry",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Elasticsearch: "Elasticsearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OpenAI: "OpenAI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Serp: "Serp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  BingLLMSearch: "BingLLMSearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Serverless: "Serverless",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedOnlineEndpoint: "ManagedOnlineEndpoint",
}

/**
 * Group based on connection category
 */
union ConnectionGroup {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Azure: "Azure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureAI: "AzureAI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Database: "Database",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NoSQL: "NoSQL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  File: "File",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GenericProtocol: "GenericProtocol",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ServicesAndApps: "ServicesAndApps",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ManagedPERequirement {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Required: "Required",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotRequired: "NotRequired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotApplicable: "NotApplicable",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ManagedPEStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Inactive: "Inactive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotApplicable: "NotApplicable",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union CapabilityHostKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Agents: "Agents",
}

/**
 * Provisioning state of capability host.
 */
union CapabilityHostProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
}

/**
 * The identity type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

/**
 * key name to generate (Key1|Key2)
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum KeyName {
  Key1,
  Key2,
}

/**
 * The type of restrictions.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceSkuRestrictionsType {
  Location,
  Zone,
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
 * Identity for the resource.
 */
model Identity {
  /**
   * The identity type.
   */
  type?: ResourceIdentityType;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The principal ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The list of user assigned identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Properties of Cognitive Services account.
 */
model AccountProperties {
  /**
   * Gets the status of the cognitive services account at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Endpoint of the created account.
   */
  @visibility(Lifecycle.Read)
  endpoint?: string;

  /**
   * The internal identifier (deprecated, do not use this property).
   */
  @visibility(Lifecycle.Read)
  internalId?: string;

  /**
   * Gets the capabilities of the cognitive services account. Each item indicates the capability of a specific feature. The values are read-only and for reference only.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  capabilities?: SkuCapability[];

  /**
   * If the resource is migrated from an existing key.
   */
  @visibility(Lifecycle.Read)
  isMigrated?: boolean;

  /**
   * Resource migration token.
   */
  migrationToken?: string;

  /**
   * Sku change info of account.
   */
  @visibility(Lifecycle.Read)
  skuChangeInfo?: SkuChangeInfo;

  /**
   * Optional subdomain name used for token-based authentication.
   */
  customSubDomainName?: string;

  /**
   * A collection of rules governing the accessibility from specific network locations.
   */
  networkAcls?: NetworkRuleSet;

  /**
   * The encryption properties for this resource.
   */
  encryption?: Encryption;

  /**
   * The storage accounts for this resource.
   */
  @OpenAPI.extension("x-ms-identifiers", #["resourceId"])
  userOwnedStorage?: UserOwnedStorage[];

  /**
   * The user owned AML account properties.
   */
  amlWorkspace?: UserOwnedAmlWorkspace;

  /**
   * The private endpoint connection associated with the Cognitive Services account.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Whether or not public endpoint access is allowed for this account.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * The api properties for special APIs.
   */
  apiProperties?: ApiProperties;

  /**
   * Gets the date of cognitive services account creation.
   */
  @visibility(Lifecycle.Read)
  dateCreated?: string;

  /**
   * The call rate limit Cognitive Services account.
   */
  @visibility(Lifecycle.Read)
  callRateLimit?: CallRateLimit;

  /**
   * The flag to enable dynamic throttling.
   */
  dynamicThrottlingEnabled?: boolean;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  quotaLimit?: QuotaLimit;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  restrictOutboundNetworkAccess?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  allowedFqdnList?: string[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  disableLocalAuth?: boolean;

  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  endpoints?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Create, Lifecycle.Update)
  restore?: boolean;

  /**
   * The deletion date, only available for deleted account.
   */
  @visibility(Lifecycle.Read)
  deletionDate?: string;

  /**
   * The scheduled purge date, only available for deleted account.
   */
  @visibility(Lifecycle.Read)
  scheduledPurgeDate?: string;

  /**
   * The multiregion settings of Cognitive Services account.
   */
  locations?: MultiRegionSettings;

  /**
   * The commitment plan associations of Cognitive Services account.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["commitmentPlanId"])
  commitmentPlanAssociations?: CommitmentPlanAssociation[];

  /**
   * The abuse penalty.
   */
  @visibility(Lifecycle.Read)
  abusePenalty?: AbusePenalty;

  /**
   * Cognitive Services Rai Monitor Config.
   */
  raiMonitorConfig?: RaiMonitorConfig;
}

/**
 * SkuCapability indicates the capability of a certain feature.
 */
model SkuCapability {
  /**
   * The name of the SkuCapability.
   */
  name?: string;

  /**
   * The value of the SkuCapability.
   */
  value?: string;
}

/**
 * Sku change info of account.
 */
model SkuChangeInfo {
  /**
   * Gets the count of downgrades.
   */
  countOfDowngrades?: float32;

  /**
   * Gets the count of upgrades after downgrades.
   */
  countOfUpgradesAfterDowngrades?: float32;

  /**
   * Gets the last change date.
   */
  lastChangeDate?: string;
}

/**
 * A set of rules governing the network accessibility.
 */
model NetworkRuleSet {
  /**
   * The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.
   */
  defaultAction?: NetworkRuleAction;

  /**
   * Setting for trusted services.
   */
  bypass?: ByPassSelection;

  /**
   * The list of IP address rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  ipRules?: IpRule[];

  /**
   * The list of virtual network rules.
   */
  virtualNetworkRules?: VirtualNetworkRule[];
}

/**
 * A rule governing the accessibility from a specific ip address or ip range.
 */
model IpRule {
  /**
   * An IPv4 address range in CIDR notation, such as '124.56.78.91' (simple IP address) or '124.56.78.0/24' (all addresses that start with 124.56.78).
   */
  value: string;
}

/**
 * A rule governing the accessibility from a specific virtual network.
 */
model VirtualNetworkRule {
  /**
   * Full resource id of a vnet subnet, such as '/subscriptions/subid/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/subnet1'.
   */
  id: string;

  /**
   * Gets the state of virtual network rule.
   */
  state?: string;

  /**
   * Ignore missing vnet service endpoint or not.
   */
  ignoreMissingVnetServiceEndpoint?: boolean;
}

/**
 * Properties to configure Encryption
 */
model Encryption {
  /**
   * Properties of KeyVault
   */
  keyVaultProperties?: KeyVaultProperties;

  /**
   * Enumerates the possible value of keySource for Encryption
   */
  keySource?: KeySource = KeySource.`Microsoft.KeyVault`;
}

/**
 * Properties to configure keyVault Properties
 */
model KeyVaultProperties {
  /**
   * Name of the Key from KeyVault
   */
  keyName?: string;

  /**
   * Version of the Key from KeyVault
   */
  keyVersion?: string;

  /**
   * Uri of KeyVault
   */
  keyVaultUri?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  identityClientId?: string;
}

/**
 * The user owned storage for Cognitive Services account.
 */
model UserOwnedStorage {
  /**
   * Full resource id of a Microsoft.Storage resource.
   */
  resourceId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  identityClientId?: string;
}

/**
 * The user owned AML account for Cognitive Services account.
 */
model UserOwnedAmlWorkspace {
  /**
   * Full resource id of a AML account resource.
   */
  resourceId?: string;

  /**
   * Identity Client id of a AML account resource.
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

  /**
   * The private link resource group ids.
   */
  groupIds?: string[];
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

/**
 * The resource model definition for an Azure Resource Manager resource with an etag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AzureEntityResource extends Resource {
  /**
   * Resource Etag.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
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
 * The api properties for special APIs.
 */
model ApiProperties {
  ...Record<Record<unknown>>;

  /**
   * (QnAMaker Only) The runtime endpoint of QnAMaker.
   */
  qnaRuntimeEndpoint?: string;

  /**
   * (QnAMaker Only) The Azure Search endpoint key of QnAMaker.
   */
  qnaAzureSearchEndpointKey?: string;

  /**
   * (QnAMaker Only) The Azure Search endpoint id of QnAMaker.
   */
  qnaAzureSearchEndpointId?: string;

  /**
   * (Bing Search Only) The flag to enable statistics of Bing Search.
   */
  statisticsEnabled?: boolean;

  /**
   * (Personalization Only) The flag to enable statistics of Bing Search.
   */
  @maxLength(1000)
  @pattern("^( *)Endpoint=sb://(.*);( *)SharedAccessKeyName=(.*);( *)SharedAccessKey=(.*)$")
  eventHubConnectionString?: string;

  /**
   * (Personalization Only) The storage account connection string.
   */
  @maxLength(1000)
  @pattern("^(( *)DefaultEndpointsProtocol=(http|https)( *);( *))?AccountName=(.*)AccountKey=(.*)EndpointSuffix=(.*)$")
  storageAccountConnectionString?: string;

  /**
   * (Metrics Advisor Only) The Azure AD Client Id (Application Id).
   */
  @maxLength(500)
  aadClientId?: string;

  /**
   * (Metrics Advisor Only) The Azure AD Tenant Id.
   */
  @maxLength(500)
  aadTenantId?: string;

  /**
   * (Metrics Advisor Only) The super user of Metrics Advisor.
   */
  @maxLength(500)
  superUser?: string;

  /**
   * (Metrics Advisor Only) The website name of Metrics Advisor.
   */
  @maxLength(500)
  websiteName?: string;
}

/**
 * The call rate limit Cognitive Services account.
 */
model CallRateLimit {
  /**
   * The count value of Call Rate Limit.
   */
  count?: float32;

  /**
   * The renewal period in seconds of Call Rate Limit.
   */
  renewalPeriod?: float32;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @OpenAPI.extension("x-ms-identifiers", #["key"])
  rules?: ThrottlingRule[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ThrottlingRule {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  key?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  renewalPeriod?: float32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  count?: float32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  minCount?: float32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  dynamicThrottlingEnabled?: boolean;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @OpenAPI.extension("x-ms-identifiers", #["path", "method"])
  matchPatterns?: RequestMatchPattern[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model RequestMatchPattern {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  path?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  method?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model QuotaLimit {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  count?: float32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  renewalPeriod?: float32;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @OpenAPI.extension("x-ms-identifiers", #["key"])
  rules?: ThrottlingRule[];
}

/**
 * The multiregion settings Cognitive Services account.
 */
model MultiRegionSettings {
  /**
   * Multiregion routing methods.
   */
  routingMethod?: RoutingMethods;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  regions?: RegionSetting[];
}

/**
 * The call rate limit Cognitive Services account.
 */
model RegionSetting {
  /**
   * Name of the region.
   */
  name?: string;

  /**
   * A value for priority or weighted routing methods.
   */
  value?: float32;

  /**
   * Maps the region to the regional custom subdomain.
   */
  customsubdomain?: string;
}

/**
 * The commitment plan association.
 */
model CommitmentPlanAssociation {
  /**
   * The Azure resource id of the commitment plan.
   */
  commitmentPlanId?: string;

  /**
   * The location of of the commitment plan.
   */
  commitmentPlanLocation?: string;
}

/**
 * The abuse penalty.
 */
model AbusePenalty {
  /**
   * The action of AbusePenalty.
   */
  action?: AbusePenaltyAction;

  /**
   * The percentage of rate limit.
   */
  rateLimitPercentage?: float32;

  /**
   * The datetime of expiration of the AbusePenalty.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiration?: utcDateTime;
}

/**
 * Cognitive Services Rai Monitor Config.
 */
model RaiMonitorConfig {
  /**
   * The storage resource Id.
   */
  adxStorageResourceId?: string;

  /**
   * The identity client Id to access the storage.
   */
  identityClientId?: string;
}

/**
 * The access keys for the cognitive services account.
 */
model ApiKeys {
  /**
   * Gets the value of key 1.
   */
  key1?: string;

  /**
   * Gets the value of key 2.
   */
  key2?: string;
}

/**
 * Regenerate key parameters.
 */
model RegenerateKeyParameters {
  /**
   * key name to generate (Key1|Key2)
   */
  keyName: KeyName;
}

/**
 * The Get Skus operation response.
 */
model ResourceSkuListResult is Azure.Core.Page<ResourceSku>;

/**
 * Describes restrictions of a SKU.
 */
model ResourceSkuRestrictions {
  /**
   * The type of restrictions.
   */
  type?: ResourceSkuRestrictionsType;

  /**
   * The value of restrictions. If the restriction type is set to location. This would be different locations where the SKU is restricted.
   */
  values?: string[];

  /**
   * The information about the restriction where the SKU cannot be used.
   */
  restrictionInfo?: ResourceSkuRestrictionInfo;

  /**
   * The reason for restriction.
   */
  reasonCode?: ResourceSkuRestrictionsReasonCode;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceSkuRestrictionInfo {
  /**
   * Locations where the SKU is restricted
   */
  locations?: string[];

  /**
   * List of availability zones where the SKU is restricted.
   */
  zones?: string[];
}

/**
 * The list of cognitive services accounts operation response.
 */
model AccountSkuListResult {
  /**
   * Gets the list of Cognitive Services accounts and their properties.
   */
  @OpenAPI.extension("x-ms-identifiers", #["sku/name", "resourceType"])
  value?: AccountSku[];
}

/**
 * Cognitive Services resource type and SKU.
 */
model AccountSku {
  /**
   * Resource Namespace and Type
   */
  resourceType?: string;

  /**
   * The SKU of Cognitive Services account.
   */
  sku?: Sku;
}

/**
 * The response to a list usage request.
 */
model UsageListResult is Azure.Core.Page<Usage>;

/**
 * The usage data for a usage request.
 */
model Usage {
  /**
   * The unit of the metric.
   */
  unit?: UnitType;

  /**
   * The name information for the metric.
   */
  name?: MetricName;

  /**
   * The quota period used to summarize the usage values.
   */
  quotaPeriod?: string;

  /**
   * Maximum value for this metric.
   */
  limit?: float64;

  /**
   * Current value for this metric.
   */
  currentValue?: float64;

  /**
   * Next reset time for current quota.
   */
  nextResetTime?: string;

  /**
   * Cognitive Services account quota usage status.
   */
  status?: QuotaUsageStatus;
}

/**
 * A metric name.
 */
model MetricName {
  /**
   * The name of the metric.
   */
  value?: string;

  /**
   * The friendly name of the metric.
   */
  localizedValue?: string;
}

/**
 * The list of cognitive services accounts operation response.
 */
model AccountModelListResult is Azure.Core.Page<AccountModel>;

/**
 * Cognitive Services account Model.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AccountModel extends DeploymentModel {
  /**
   * Properties of Cognitive Services account deployment model.
   */
  baseModel?: DeploymentModel;

  /**
   * If the model is default version.
   */
  isDefaultVersion?: boolean;

  /**
   * The list of Model Sku.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  skus?: ModelSku[];

  /**
   * The max capacity.
   */
  maxCapacity?: int32;

  /**
   * The capabilities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  capabilities?: Record<string>;

  /**
   * The capabilities for finetune models.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  finetuneCapabilities?: Record<string>;

  /**
   * Cognitive Services account ModelDeprecationInfo.
   */
  deprecation?: ModelDeprecationInfo;

  /**
   * Model lifecycle status.
   */
  lifecycleStatus?: ModelLifecycleStatus;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Properties of Cognitive Services account deployment model.
 */
model DeploymentModel {
  /**
   * Deployment model publisher.
   */
  publisher?: string;

  /**
   * Deployment model format.
   */
  format?: string;

  /**
   * Deployment model name.
   */
  name?: string;

  /**
   * Optional. Deployment model version. If version is not specified, a default version will be assigned. The default version is different for different models and might change when there is new version available for a model. Default version for a model could be found from list models API.
   */
  version?: string;

  /**
   * Optional. Deployment model source ARM resource ID.
   */
  source?: string;

  /**
   * Optional. Source of the model, another Microsoft.CognitiveServices accounts ARM resource ID.
   */
  sourceAccount?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.CognitiveServices/accounts";
    }
  ]>;

  /**
   * The call rate limit Cognitive Services account.
   */
  @visibility(Lifecycle.Read)
  callRateLimit?: CallRateLimit;
}

/**
 * Describes an available Cognitive Services Model SKU.
 */
model ModelSku {
  /**
   * The name of the model SKU.
   */
  name?: string;

  /**
   * The usage name of the model SKU.
   */
  usageName?: string;

  /**
   * The datetime of deprecation of the model SKU.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deprecationDate?: utcDateTime;

  /**
   * The capacity configuration.
   */
  capacity?: CapacityConfig;

  /**
   * The list of rateLimit.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  rateLimits?: CallRateLimit[];

  /**
   * The list of billing meter info.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  cost?: BillingMeterInfo[];
}

/**
 * The capacity configuration.
 */
model CapacityConfig {
  /**
   * The minimum capacity.
   */
  minimum?: int32;

  /**
   * The maximum capacity.
   */
  maximum?: int32;

  /**
   * The minimal incremental between allowed values for capacity.
   */
  step?: int32;

  /**
   * The default capacity.
   */
  default?: int32;

  /**
   * The array of allowed values for capacity.
   */
  allowedValues?: int32[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model BillingMeterInfo {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  meterId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  unit?: string;
}

/**
 * Cognitive Services account ModelDeprecationInfo.
 */
model ModelDeprecationInfo {
  /**
   * The datetime of deprecation of the fineTune Model.
   */
  fineTune?: string;

  /**
   * The datetime of deprecation of the inference Model.
   */
  inference?: string;
}

/**
 * Check SKU availability parameter.
 */
model CheckSkuAvailabilityParameter {
  /**
   * The SKU of the resource.
   */
  skus: string[];

  /**
   * The kind (type) of cognitive service account.
   */
  kind: string;

  /**
   * The Type of the resource.
   */
  type: string;
}

/**
 * Check SKU availability result list.
 */
model SkuAvailabilityListResult {
  /**
   * Check SKU availability result list.
   */
  @OpenAPI.extension("x-ms-identifiers", #["skuName", "type", "kind"])
  value?: SkuAvailability[];
}

/**
 * SKU availability.
 */
model SkuAvailability {
  /**
   * The Kind of the resource.
   */
  kind?: string;

  /**
   * The Type of the resource.
   */
  type?: string;

  /**
   * The SKU of Cognitive Services account.
   */
  skuName?: string;

  /**
   * Indicates the given SKU is available or not.
   */
  skuAvailable?: boolean;

  /**
   * Reason why the SKU is not available.
   */
  reason?: string;

  /**
   * Additional error message.
   */
  message?: string;
}

/**
 * The list of cognitive services accounts operation response.
 */
model CommitmentTierListResult is Azure.Core.Page<CommitmentTier>;

/**
 * Cognitive Services account commitment tier.
 */
model CommitmentTier {
  /**
   * The Kind of the resource.
   */
  kind?: string;

  /**
   * The name of the SKU. Ex - P3. It is typically a letter+number code
   */
  skuName?: string;

  /**
   * Account hosting model.
   */
  hostingModel?: HostingModel;

  /**
   * Commitment plan type.
   */
  planType?: string;

  /**
   * Commitment period commitment tier.
   */
  tier?: string;

  /**
   * Commitment period commitment max count.
   */
  maxCount?: int32;

  /**
   * Cognitive Services account commitment quota.
   */
  quota?: CommitmentQuota;

  /**
   * Cognitive Services account commitment cost.
   */
  cost?: CommitmentCost;
}

/**
 * Cognitive Services account commitment quota.
 */
model CommitmentQuota {
  /**
   * Commitment quota quantity.
   */
  quantity?: int64;

  /**
   * Commitment quota unit.
   */
  unit?: string;
}

/**
 * Cognitive Services account commitment cost.
 */
model CommitmentCost {
  /**
   * Commitment meter Id.
   */
  commitmentMeterId?: string;

  /**
   * Overage meter Id.
   */
  overageMeterId?: string;
}

/**
 * The list of cognitive services models.
 */
model ModelListResult is Azure.Core.Page<Model>;

/**
 * Cognitive Services Model.
 */
model Model {
  /**
   * Cognitive Services account Model.
   */
  `model`?: AccountModel;

  /**
   * The kind (type) of cognitive service account.
   */
  kind?: string;

  /**
   * The name of SKU.
   */
  skuName?: string;

  /**
   * The description of the model.
   */
  description?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ModelCapacityListResultValueItem extends ProxyResource {
  /**
   * The location of the Model Sku Capacity.
   */
  location?: string;

  /**
   * Cognitive Services account ModelSkuCapacity.
   */
  properties?: ModelSkuCapacityProperties;
}

/**
 * Cognitive Services account ModelSkuCapacity.
 */
model ModelSkuCapacityProperties {
  /**
   * Properties of Cognitive Services account deployment model.
   */
  `model`?: DeploymentModel;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  skuName?: string;

  /**
   * The available capacity for deployment with this model and sku.
   */
  availableCapacity?: float32;

  /**
   * The available capacity for deployment with a fine-tune version of this model and sku.
   */
  availableFinetuneCapacity?: float32;
}

/**
 * Check Domain availability parameter.
 */
model CheckDomainAvailabilityParameter {
  /**
   * The subdomain name to use.
   */
  subdomainName: string;

  /**
   * The Type of the resource.
   */
  type: string;

  /**
   * The Kind of the resource.
   */
  kind?: string;
}

/**
 * Domain availability.
 */
model DomainAvailability {
  /**
   * Indicates the given SKU is available or not.
   */
  isSubdomainAvailable?: boolean;

  /**
   * Reason why the SKU is not available.
   */
  reason?: string;

  /**
   * The subdomain name to use.
   */
  subdomainName?: string;

  /**
   * The Type of the resource.
   */
  type?: string;

  /**
   * The Kind of the resource.
   */
  kind?: string;
}

/**
 * Calculate Model Capacity parameter.
 */
model CalculateModelCapacityParameter {
  /**
   * Properties of Cognitive Services account deployment model.
   */
  `model`?: DeploymentModel;

  /**
   * The name of SKU.
   */
  skuName?: string;

  /**
   * List of Model Capacity Calculator Workload.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  workloads?: ModelCapacityCalculatorWorkload[];
}

/**
 * Model Capacity Calculator Workload.
 */
model ModelCapacityCalculatorWorkload {
  /**
   * Request per minute.
   */
  requestPerMinute?: int64;

  /**
   * Dictionary, Model Capacity Calculator Workload Parameters.
   */
  requestParameters?: ModelCapacityCalculatorWorkloadRequestParam;
}

/**
 * Dictionary, Model Capacity Calculator Workload Parameters.
 */
model ModelCapacityCalculatorWorkloadRequestParam {
  /**
   * Average prompt tokens.
   */
  avgPromptTokens?: int64;

  /**
   * Average generated tokens.
   */
  avgGeneratedTokens?: int64;
}

/**
 * Calculate Model Capacity result.
 */
model CalculateModelCapacityResult {
  /**
   * Properties of Cognitive Services account deployment model.
   */
  `model`?: DeploymentModel;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  skuName?: string;

  /**
   * Model Estimated Capacity.
   */
  estimatedCapacity?: CalculateModelCapacityResultEstimatedCapacity;
}

/**
 * Model Estimated Capacity.
 */
model CalculateModelCapacityResultEstimatedCapacity {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  value?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  deployableValue?: int32;
}

/**
 * A list of private endpoint connections
 */
model PrivateEndpointConnectionListResult {
  /**
   * Array of private endpoint connections
   */
  value?: PrivateEndpointConnection[];
}

/**
 * A list of private link resources
 */
model PrivateLinkResourceListResult {
  /**
   * Array of private link resources
   */
  value?: PrivateLinkResource[];
}

/**
 * A private link resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PrivateLinkResource extends Resource {
  /**
   * Resource properties.
   */
  properties?: PrivateLinkResourceProperties;
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

  /**
   * The private link resource display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;
}

/**
 * Properties of Cognitive Services account deployment.
 */
model DeploymentProperties {
  /**
   * Gets the status of the resource at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DeploymentProvisioningState;

  /**
   * Properties of Cognitive Services account deployment model.
   */
  `model`?: DeploymentModel;

  /**
   * Properties of Cognitive Services account deployment model. (Deprecated, please use Deployment.sku instead.)
   */
  scaleSettings?: DeploymentScaleSettings;

  /**
   * The capabilities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  capabilities?: Record<string>;

  /**
   * The name of RAI policy.
   */
  raiPolicyName?: string;

  /**
   * The call rate limit Cognitive Services account.
   */
  @visibility(Lifecycle.Read)
  callRateLimit?: CallRateLimit;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["key"])
  rateLimits?: ThrottlingRule[];

  /**
   * Deployment model version upgrade option.
   */
  versionUpgradeOption?: DeploymentModelVersionUpgradeOption;

  /**
   * If the dynamic throttling is enabled.
   */
  @visibility(Lifecycle.Read)
  dynamicThrottlingEnabled?: boolean;

  /**
   * The current capacity.
   */
  currentCapacity?: int32;

  /**
   * Internal use only.
   */
  capacitySettings?: DeploymentCapacitySettings;

  /**
   * The name of parent deployment.
   */
  parentDeploymentName?: string;
}

/**
 * Properties of Cognitive Services account deployment model. (Deprecated, please use Deployment.sku instead.)
 */
model DeploymentScaleSettings {
  /**
   * Deployment scale type.
   */
  scaleType?: DeploymentScaleType;

  /**
   * Deployment capacity.
   */
  capacity?: int32;

  /**
   * Deployment active capacity. This value might be different from `capacity` if customer recently updated `capacity`.
   */
  @visibility(Lifecycle.Read)
  activeCapacity?: int32;
}

/**
 * Internal use only.
 */
model DeploymentCapacitySettings {
  /**
   * The designated capacity.
   */
  designatedCapacity?: int32;

  /**
   * The priority of this capacity setting.
   */
  priority?: int32;
}

/**
 * The object being used to update tags and sku of a resource, in general used for PATCH operations.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PatchResourceTagsAndSku extends PatchResourceTags {
  /**
   * The resource model definition representing SKU
   */
  sku?: Sku;
}

/**
 * The object being used to update tags of a resource, in general used for PATCH operations.
 */
model PatchResourceTags {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * The list of cognitive services accounts operation response.
 */
model DeploymentSkuListResult is Azure.Core.Page<SkuResource>;

/**
 * Properties of Cognitive Services account resource sku resource properties.
 */
model SkuResource {
  /**
   * The resource type name.
   */
  resourceType?: string;

  /**
   * The resource model definition representing SKU
   */
  sku?: Sku;

  /**
   * The capacity configuration.
   */
  capacity?: CapacityConfig;
}

/**
 * Properties of Cognitive Services account commitment plan.
 */
model CommitmentPlanProperties {
  /**
   * Gets the status of the resource at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: CommitmentPlanProvisioningState;

  /**
   * Commitment plan guid.
   */
  commitmentPlanGuid?: string;

  /**
   * Account hosting model.
   */
  hostingModel?: HostingModel;

  /**
   * Commitment plan type.
   */
  planType?: string;

  /**
   * Cognitive Services account commitment period.
   */
  current?: CommitmentPeriod;

  /**
   * AutoRenew commitment plan.
   */
  autoRenew?: boolean;

  /**
   * Cognitive Services account commitment period.
   */
  next?: CommitmentPeriod;

  /**
   * Cognitive Services account commitment period.
   */
  @visibility(Lifecycle.Read)
  last?: CommitmentPeriod;

  /**
   * The list of ProvisioningIssue.
   */
  @visibility(Lifecycle.Read)
  provisioningIssues?: string[];
}

/**
 * Cognitive Services account commitment period.
 */
model CommitmentPeriod {
  /**
   * Commitment period commitment tier.
   */
  tier?: string;

  /**
   * Commitment period commitment count.
   */
  count?: int32;

  /**
   * Cognitive Services account commitment quota.
   */
  @visibility(Lifecycle.Read)
  quota?: CommitmentQuota;

  /**
   * Commitment period start date.
   */
  @visibility(Lifecycle.Read)
  startDate?: string;

  /**
   * Commitment period end date.
   */
  @visibility(Lifecycle.Read)
  endDate?: string;
}

/**
 * Properties to EncryptionScope
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model EncryptionScopeProperties extends Encryption {
  /**
   * Gets the status of the resource at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: EncryptionScopeProvisioningState;

  /**
   * The encryptionScope state.
   */
  state?: EncryptionScopeState;
}

/**
 * Azure OpenAI Content Filters properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model RaiPolicyProperties {
  /**
   * Content Filters policy type.
   */
  @visibility(Lifecycle.Read)
  type?: RaiPolicyType;

  /**
   * Rai policy mode. The enum value mapping is as below: Default = 0, Deferred=1, Blocking=2, Asynchronous_filter =3. Please use 'Asynchronous_filter' after 2025-04-01-preview. It is the same as 'Deferred' in previous version.
   */
  mode?: RaiPolicyMode;

  /**
   * Name of Rai policy.
   */
  basePolicyName?: string;

  /**
   * The list of Content Filters.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  contentFilters?: RaiPolicyContentFilter[];

  /**
   * The list of custom Blocklist.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  customBlocklists?: CustomBlocklistConfig[];
}

/**
 * Azure OpenAI Content Filter.
 */
model RaiPolicyContentFilter {
  /**
   * Name of ContentFilter.
   */
  name?: string;

  /**
   * If the ContentFilter is enabled.
   */
  enabled?: boolean;

  /**
   * Level at which content is filtered.
   */
  severityThreshold?: ContentLevel;

  /**
   * If blocking would occur.
   */
  blocking?: boolean;

  /**
   * Content source to apply the Content Filters.
   */
  source?: RaiPolicyContentSource;
}

/**
 * Gets or sets the source to which filter applies.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model CustomBlocklistConfig extends RaiBlocklistConfig {
  /**
   * Content source to apply the Content Filters.
   */
  source?: RaiPolicyContentSource;
}

/**
 * Azure OpenAI blocklist config.
 */
model RaiBlocklistConfig {
  /**
   * Name of ContentFilter.
   */
  blocklistName?: string;

  /**
   * If blocking would occur.
   */
  blocking?: boolean;
}

/**
 * RAI Custom Blocklist properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model RaiBlocklistProperties {
  /**
   * Description of the block list.
   */
  description?: string;
}

/**
 * The list of cognitive services RAI Blocklist Items.
 */
model RaiBlockListItemsResult is Azure.Core.Page<RaiBlocklistItem>;

/**
 * RAI Custom Blocklist Item properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model RaiBlocklistItemProperties {
  /**
   * Pattern to match against.
   */
  pattern?: string;

  /**
   * If the pattern is a regex pattern.
   */
  isRegex?: boolean;
}

/**
 * The Cognitive Services RaiBlocklist Item request body.
 */
model RaiBlocklistItemBulkRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  name?: string;

  /**
   * Properties of Cognitive Services RaiBlocklist Item.
   */
  properties?: RaiBlocklistItemProperties;
}

/**
 * Azure OpenAI Content Filter Properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model RaiContentFilterProperties {
  /**
   * Name of Content Filter.
   */
  name?: string;

  /**
   * If the Content Filter has multi severity levels(Low, Medium, or High).
   */
  isMultiLevelFilter?: boolean;

  /**
   * Content source to apply the Content Filters.
   */
  source?: RaiPolicyContentSource;
}

/**
 * The commitment plan account association properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model CommitmentPlanAccountAssociationProperties {
  /**
   * The Azure resource id of the account.
   */
  accountId?: string;
}

/**
 * A list of NSP configurations for an Cognitive Services account.
 */
model NetworkSecurityPerimeterConfigurationList
  is Azure.Core.Page<NetworkSecurityPerimeterConfiguration>;

/**
 * The properties of an NSP Configuration.
 */
model NetworkSecurityPerimeterConfigurationProperties {
  /**
   * Provisioning state of NetworkSecurityPerimeter configuration
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * List of Provisioning Issues
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  provisioningIssues?: ProvisioningIssue[];

  /**
   * Information about a linked Network Security Perimeter
   */
  networkSecurityPerimeter?: NetworkSecurityPerimeter;

  /**
   * Network Security Perimeter Configuration Association Information
   */
  resourceAssociation?: NetworkSecurityPerimeterConfigurationAssociationInfo;

  /**
   * Network Security Perimeter Profile Information
   */
  profile?: NetworkSecurityPerimeterProfileInfo;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ProvisioningIssue {
  /**
   * Name of the NSP provisioning issue
   */
  name?: string;

  /**
   * Properties of Provisioning Issue
   */
  properties?: ProvisioningIssueProperties;
}

/**
 * Properties of Provisioning Issue
 */
model ProvisioningIssueProperties {
  /**
   * Type of Issue
   */
  issueType?: string;

  /**
   * Severity of the issue
   */
  severity?: string;

  /**
   * Description of the issue
   */
  description?: string;

  /**
   * IDs of resources that can be associated to the same perimeter to remediate the issue.
   */
  suggestedResourceIds?: Azure.Core.armResourceIdentifier[];

  /**
   * Optional array, suggested access rules
   */
  suggestedAccessRules?: NetworkSecurityPerimeterAccessRule[];
}

/**
 * Network Security Perimeter Access Rule
 */
model NetworkSecurityPerimeterAccessRule {
  /**
   * Network Security Perimeter Access Rule Name
   */
  name?: string;

  /**
   * Properties of Network Security Perimeter Access Rule
   */
  properties?: NetworkSecurityPerimeterAccessRuleProperties;
}

/**
 * The Properties of Network Security Perimeter Rule
 */
model NetworkSecurityPerimeterAccessRuleProperties {
  /**
   * Direction of Access Rule
   */
  direction?: NspAccessRuleDirection;

  /**
   * Address prefixes for inbound rules
   */
  addressPrefixes?: string[];

  /**
   * Subscriptions for inbound rules
   */
  subscriptions?: NetworkSecurityPerimeterAccessRulePropertiesSubscriptionsItem[];

  /**
   * NetworkSecurityPerimeters for inbound rules
   */
  networkSecurityPerimeters?: NetworkSecurityPerimeter[];

  /**
   * Fully qualified domain name for outbound rules
   */
  fullyQualifiedDomainNames?: string[];
}

/**
 * Subscription for inbound rule
 */
model NetworkSecurityPerimeterAccessRulePropertiesSubscriptionsItem {
  /**
   * Fully qualified identifier of subscription
   */
  id?: string;
}

/**
 * Information about a linked Network Security Perimeter
 */
model NetworkSecurityPerimeter {
  /**
   * Fully qualified identifier of the resource
   */
  id?: Azure.Core.armResourceIdentifier;

  /**
   * Guid of the resource
   */
  perimeterGuid?: string;

  /**
   * Location of the resource
   */
  location?: string;
}

/**
 * Network Security Perimeter Configuration Association Information
 */
model NetworkSecurityPerimeterConfigurationAssociationInfo {
  /**
   * Name of the resource association
   */
  name?: string;

  /**
   * Access Mode of the resource association
   */
  accessMode?: string;
}

/**
 * Network Security Perimeter Profile Information
 */
model NetworkSecurityPerimeterProfileInfo {
  /**
   * Name of the resource profile
   */
  name?: string;

  /**
   * Access rules version of the resource profile
   */
  accessRulesVersion?: int64;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @OpenAPI.extension("x-ms-identifiers", #[])
  accessRules?: NetworkSecurityPerimeterAccessRule[];

  /**
   * Current diagnostic settings version
   */
  diagnosticSettingsVersion?: int64;

  /**
   * List of enabled log categories
   */
  enabledLogCategories?: string[];
}

/**
 * The list of cognitive services Defender for AI Settings.
 */
model DefenderForAISettingResult is Azure.Core.Page<DefenderForAISetting>;

/**
 * The Defender for AI resource properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DefenderForAISettingProperties {
  /**
   * Defender for AI state on the AI resource.
   */
  state?: DefenderForAISettingState;
}

/**
 * Connection property base schema.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
@discriminator("authType")
model ConnectionPropertiesV2 {
  /**
   * Authentication type of the connection target
   */
  authType: ConnectionAuthType;

  /**
   * Category of the connection
   */
  category?: ConnectionCategory;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  createdByWorkspaceArmId?: Azure.Core.armResourceIdentifier;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  error?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  expiryTime?: utcDateTime;

  /**
   * Group based on connection category
   */
  @visibility(Lifecycle.Read)
  group?: ConnectionGroup;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  isSharedToAll?: boolean;

  /**
   * Store user metadata for this connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  metadata?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  peRequirement?: ManagedPERequirement;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  peStatus?: ManagedPEStatus;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  sharedUserList?: string[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  target?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  useWorkspaceManagedIdentity?: boolean;
}

/**
 * The properties that the Cognitive services connection will be updated with.
 */
model ConnectionUpdateContent {
  /**
   * The properties that the Cognitive services connection will be updated with.
   */
  properties?: ConnectionPropertiesV2;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ConnectionPropertiesV2BasicResourceArmPaginatedResult
  is Azure.Core.Page<ConnectionPropertiesV2BasicResource>;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CapabilityHostProperties extends ResourceBase {
  /**
   * List of AI services connections.
   */
  aiServicesConnections?: string[];

  /**
   * Kind of this capability host.
   */
  capabilityHostKind?: CapabilityHostKind;

  /**
   * Customer subnet info to help set up this capability host.
   */
  customerSubnet?: string;

  /**
   * Provisioning state for the CapabilityHost.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: CapabilityHostProvisioningState;

  /**
   * List of Storage connections.
   */
  storageConnections?: string[];

  /**
   * List of Thread storage connections.
   */
  threadStorageConnections?: string[];

  /**
   * List of VectorStore connections.
   */
  vectorStoreConnections?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceBase {
  /**
   * The asset description text.
   */
  description?: string;

  /**
   * Tag dictionary. Tags can be added, removed, and updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model PATAuthTypeConnectionProperties extends ConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  credentials?: ConnectionPersonalAccessToken;

  /**
   * Authentication type of the connection target
   */
  authType: "PAT";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ConnectionPersonalAccessToken {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  pat?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ManagedIdentityAuthTypeConnectionProperties
  extends ConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  credentials?: ConnectionManagedIdentity;

  /**
   * Authentication type of the connection target
   */
  authType: "ManagedIdentity";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ConnectionManagedIdentity {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  clientId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  resourceId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UsernamePasswordAuthTypeConnectionProperties
  extends ConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  credentials?: ConnectionUsernamePassword;

  /**
   * Authentication type of the connection target
   */
  authType: "UsernamePassword";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ConnectionUsernamePassword {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  password?: string;

  /**
   * Optional, required by connections like SalesForce for extra security in addition to UsernamePassword
   */
  securityToken?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  username?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model NoneAuthTypeConnectionProperties extends ConnectionPropertiesV2 {
  /**
   * Authentication type of the connection target
   */
  authType: "None";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SASAuthTypeConnectionProperties extends ConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  credentials?: ConnectionSharedAccessSignature;

  /**
   * Authentication type of the connection target
   */
  authType: "SAS";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ConnectionSharedAccessSignature {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  sas?: string;
}

/**
 * This connection type covers the account key connection for Azure storage
 */
model AccountKeyAuthTypeConnectionProperties extends ConnectionPropertiesV2 {
  /**
   * Account key object for connection credential.
   */
  credentials?: ConnectionAccountKey;

  /**
   * Authentication type of the connection target
   */
  authType: "AccountKey";
}

/**
 * Account key object for connection credential.
 */
model ConnectionAccountKey {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  key?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ServicePrincipalAuthTypeConnectionProperties
  extends ConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  credentials?: ConnectionServicePrincipal;

  /**
   * Authentication type of the connection target
   */
  authType: "ServicePrincipal";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ConnectionServicePrincipal {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  clientId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  clientSecret?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  tenantId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AccessKeyAuthTypeConnectionProperties extends ConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  credentials?: ConnectionAccessKey;

  /**
   * Authentication type of the connection target
   */
  authType: "AccessKey";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ConnectionAccessKey {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  accessKeyId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  secretAccessKey?: string;
}

/**
 * This connection type covers the generic ApiKey auth connection categories, for examples:
 * AzureOpenAI:
 *     Category:= AzureOpenAI
 *     AuthType:= ApiKey (as type discriminator)
 *     Credentials:= {ApiKey} as .ApiKey
 *     Target:= {ApiBase}
 *
 * CognitiveService:
 *     Category:= CognitiveService
 *     AuthType:= ApiKey (as type discriminator)
 *     Credentials:= {SubscriptionKey} as ApiKey
 *     Target:= ServiceRegion={serviceRegion}
 *
 * CognitiveSearch:
 *     Category:= CognitiveSearch
 *     AuthType:= ApiKey (as type discriminator)
 *     Credentials:= {Key} as ApiKey
 *     Target:= {Endpoint}
 *
 * Use Metadata property bag for ApiType, ApiVersion, Kind and other metadata fields
 */
model ApiKeyAuthConnectionProperties extends ConnectionPropertiesV2 {
  /**
   * Api key object for connection credential.
   */
  credentials?: ConnectionApiKey;

  /**
   * Authentication type of the connection target
   */
  authType: "ApiKey";
}

/**
 * Api key object for connection credential.
 */
model ConnectionApiKey {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  key?: string;
}

/**
 * Category:= CustomKeys
 * AuthType:= CustomKeys (as type discriminator)
 * Credentials:= {CustomKeys} as CustomKeys
 * Target:= {any value}
 * Use Metadata property bag for ApiVersion and other metadata fields
 */
model CustomKeysConnectionProperties extends ConnectionPropertiesV2 {
  /**
   * Custom Keys credential object
   */
  credentials?: CustomKeys;

  /**
   * Authentication type of the connection target
   */
  authType: "CustomKeys";
}

/**
 * Custom Keys credential object
 */
model CustomKeys {
  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  keys?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model OAuth2AuthTypeConnectionProperties extends ConnectionPropertiesV2 {
  /**
   * ClientId and ClientSecret are required. Other properties are optional
   * depending on each OAuth2 provider's implementation.
   */
  credentials?: ConnectionOAuth2;

  /**
   * Authentication type of the connection target
   */
  authType: "OAuth2";
}

/**
 * ClientId and ClientSecret are required. Other properties are optional
 * depending on each OAuth2 provider's implementation.
 */
model ConnectionOAuth2 {
  /**
   * Required by Concur connection category
   */
  authUrl?: url;

  /**
   * Client id in the format of UUID
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  clientId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  clientSecret?: string;

  /**
   * Required by GoogleAdWords connection category
   */
  developerToken?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  password?: string;

  /**
   * Required by GoogleBigQuery, GoogleAdWords, Hubspot, QuickBooks, Square, Xero, Zoho
   * where user needs to get RefreshToken offline
   */
  refreshToken?: string;

  /**
   * Required by QuickBooks and Xero connection categories
   */
  tenantId?: string;

  /**
   * Concur, ServiceNow auth server AccessToken grant type is 'Password'
   * which requires UsernamePassword
   */
  username?: string;
}

/**
 * This connection type covers the AAD auth for any applicable Azure service
 */
model AADAuthTypeConnectionProperties extends ConnectionPropertiesV2 {
  /**
   * Authentication type of the connection target
   */
  authType: "AAD";
}
