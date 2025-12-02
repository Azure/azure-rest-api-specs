import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DataFactory;

/** Current status of the change data capture resource. */
@mediaTypeHint("application/json")
scalar ChangeDataCaptureStatusResponse extends string;
/**
 * The identity type.
 */
union FactoryIdentityType {
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
   * SystemAssigned,UserAssigned
   */
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

/**
 * Global Parameter type.
 */
union GlobalParameterType {
  string,

  /**
   * Object
   */
  Object: "Object",

  /**
   * String
   */
  String: "String",

  /**
   * Int
   */
  Int: "Int",

  /**
   * Float
   */
  Float: "Float",

  /**
   * Bool
   */
  Bool: "Bool",

  /**
   * Array
   */
  Array: "Array",
}

/**
 * Whether or not public network access is allowed for the data factory.
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
 * The type of integration runtime.
 */
union IntegrationRuntimeType {
  string,

  /**
   * Managed
   */
  Managed: "Managed",

  /**
   * SelfHosted
   */
  SelfHosted: "SelfHosted",
}

/**
 * The state of integration runtime auto update.
 */
union IntegrationRuntimeAutoUpdate {
  string,

  /**
   * On
   */
  On: "On",

  /**
   * Off
   */
  Off: "Off",
}

/**
 * The state of integration runtime.
 */
union IntegrationRuntimeState {
  string,

  /**
   * Initial
   */
  Initial: "Initial",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Started
   */
  Started: "Started",

  /**
   * Starting
   */
  Starting: "Starting",

  /**
   * Stopping
   */
  Stopping: "Stopping",

  /**
   * NeedRegistration
   */
  NeedRegistration: "NeedRegistration",

  /**
   * Online
   */
  Online: "Online",

  /**
   * Limited
   */
  Limited: "Limited",

  /**
   * Offline
   */
  Offline: "Offline",

  /**
   * AccessDenied
   */
  AccessDenied: "AccessDenied",
}

/**
 * The name of the authentication key to regenerate.
 */
union IntegrationRuntimeAuthKeyName {
  string,

  /**
   * authKey1
   */
  authKey1: "authKey1",

  /**
   * authKey2
   */
  authKey2: "authKey2",
}

/**
 * The type of SSIS object metadata.
 */
union SsisObjectMetadataType {
  string,

  /**
   * Folder
   */
  Folder: "Folder",

  /**
   * Project
   */
  Project: "Project",

  /**
   * Package
   */
  Package: "Package",

  /**
   * Environment
   */
  Environment: "Environment",
}

/**
 * Status of the integration runtime node.
 */
union SelfHostedIntegrationRuntimeNodeStatus {
  string,

  /**
   * NeedRegistration
   */
  NeedRegistration: "NeedRegistration",

  /**
   * Online
   */
  Online: "Online",

  /**
   * Limited
   */
  Limited: "Limited",

  /**
   * Offline
   */
  Offline: "Offline",

  /**
   * Upgrading
   */
  Upgrading: "Upgrading",

  /**
   * Initializing
   */
  Initializing: "Initializing",

  /**
   * InitializeFailed
   */
  InitializeFailed: "InitializeFailed",
}

/**
 * The result of the last integration runtime node update.
 */
union IntegrationRuntimeUpdateResult {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Succeed
   */
  Succeed: "Succeed",

  /**
   * Fail
   */
  Fail: "Fail",
}

/**
 * Type of integration runtime.
 */
union IntegrationRuntimeReferenceType {
  string,

  /**
   * IntegrationRuntimeReference
   */
  IntegrationRuntimeReference: "IntegrationRuntimeReference",
}

/**
 * Parameter type.
 */
union ParameterType {
  string,

  /**
   * Object
   */
  Object: "Object",

  /**
   * String
   */
  String: "String",

  /**
   * Int
   */
  Int: "Int",

  /**
   * Float
   */
  Float: "Float",

  /**
   * Bool
   */
  Bool: "Bool",

  /**
   * Array
   */
  Array: "Array",

  /**
   * SecureString
   */
  SecureString: "SecureString",
}

/**
 * Linked service reference type.
 */
union Type {
  string,

  /**
   * LinkedServiceReference
   */
  LinkedServiceReference: "LinkedServiceReference",
}

/**
 * Activity state. This is an optional property and if not provided, the state will be Active by default.
 */
union ActivityState {
  string,

  /**
   * Active
   */
  Active: "Active",

  /**
   * Inactive
   */
  Inactive: "Inactive",
}

/**
 * Status result of the activity when the state is set to Inactive. This is an optional property and if not provided when the activity is inactive, the status will be Succeeded by default.
 */
union ActivityOnInactiveMarkAs {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Skipped
   */
  Skipped: "Skipped",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union DependencyCondition {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Skipped
   */
  Skipped: "Skipped",

  /**
   * Completed
   */
  Completed: "Completed",
}

/**
 * Variable type.
 */
union VariableType {
  string,

  /**
   * String
   */
  String: "String",

  /**
   * Bool
   */
  Bool: "Bool",

  /**
   * Array
   */
  Array: "Array",
}

/**
 * Parameter name to be used for filter. The allowed operands to query pipeline runs are PipelineName, RunStart, RunEnd and Status; to query activity runs are ActivityName, ActivityRunStart, ActivityRunEnd, ActivityType and Status, and to query trigger runs are TriggerName, TriggerRunTimestamp and Status.
 */
union RunQueryFilterOperand {
  string,

  /**
   * PipelineName
   */
  PipelineName: "PipelineName",

  /**
   * Status
   */
  Status: "Status",

  /**
   * RunStart
   */
  RunStart: "RunStart",

  /**
   * RunEnd
   */
  RunEnd: "RunEnd",

  /**
   * ActivityName
   */
  ActivityName: "ActivityName",

  /**
   * ActivityRunStart
   */
  ActivityRunStart: "ActivityRunStart",

  /**
   * ActivityRunEnd
   */
  ActivityRunEnd: "ActivityRunEnd",

  /**
   * ActivityType
   */
  ActivityType: "ActivityType",

  /**
   * TriggerName
   */
  TriggerName: "TriggerName",

  /**
   * TriggerRunTimestamp
   */
  TriggerRunTimestamp: "TriggerRunTimestamp",

  /**
   * RunGroupId
   */
  RunGroupId: "RunGroupId",

  /**
   * LatestOnly
   */
  LatestOnly: "LatestOnly",
}

/**
 * Operator to be used for filter.
 */
union RunQueryFilterOperator {
  string,

  /**
   * Equals
   */
  Equals: "Equals",

  /**
   * NotEquals
   */
  NotEquals: "NotEquals",

  /**
   * In
   */
  In: "In",

  /**
   * NotIn
   */
  NotIn: "NotIn",
}

/**
 * Parameter name to be used for order by. The allowed parameters to order by for pipeline runs are PipelineName, RunStart, RunEnd and Status; for activity runs are ActivityName, ActivityRunStart, ActivityRunEnd and Status; for trigger runs are TriggerName, TriggerRunTimestamp and Status.
 */
union RunQueryOrderByField {
  string,

  /**
   * RunStart
   */
  RunStart: "RunStart",

  /**
   * RunEnd
   */
  RunEnd: "RunEnd",

  /**
   * PipelineName
   */
  PipelineName: "PipelineName",

  /**
   * Status
   */
  Status: "Status",

  /**
   * ActivityName
   */
  ActivityName: "ActivityName",

  /**
   * ActivityRunStart
   */
  ActivityRunStart: "ActivityRunStart",

  /**
   * ActivityRunEnd
   */
  ActivityRunEnd: "ActivityRunEnd",

  /**
   * TriggerName
   */
  TriggerName: "TriggerName",

  /**
   * TriggerRunTimestamp
   */
  TriggerRunTimestamp: "TriggerRunTimestamp",
}

/**
 * Sorting order of the parameter.
 */
union RunQueryOrder {
  string,

  /**
   * ASC
   */
  ASC: "ASC",

  /**
   * DESC
   */
  DESC: "DESC",
}

/**
 * Enumerates possible state of Triggers.
 */
union TriggerRuntimeState {
  string,

  /**
   * Started
   */
  Started: "Started",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Event Subscription Status.
 */
union EventSubscriptionStatus {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Deprovisioning
   */
  Deprovisioning: "Deprovisioning",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * Trigger run status.
 */
union TriggerRunStatus {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Inprogress
   */
  Inprogress: "Inprogress",
}

/**
 * The command type.
 */
union DataFlowDebugCommandType {
  string,

  /**
   * executePreviewQuery
   */
  executePreviewQuery: "executePreviewQuery",

  /**
   * executeStatisticsQuery
   */
  executeStatisticsQuery: "executeStatisticsQuery",

  /**
   * executeExpressionQuery
   */
  executeExpressionQuery: "executeExpressionQuery",
}

/**
 * Type of connection via linked service or dataset.
 */
union ConnectionType {
  string,

  /**
   * linkedservicetype
   */
  linkedservicetype: "linkedservicetype",
}

/**
 * Type of the CDC attribute mapping. Note: 'Advanced' mapping type is also saved as 'Derived'.
 */
union MappingType {
  string,

  /**
   * Direct
   */
  Direct: "Direct",

  /**
   * Derived
   */
  Derived: "Derived",

  /**
   * Aggregate
   */
  Aggregate: "Aggregate",
}

/**
 * Frequency of period in terms of 'Hour', 'Minute' or 'Second'.
 */
union FrequencyType {
  string,

  /**
   * Hour
   */
  Hour: "Hour",

  /**
   * Minute
   */
  Minute: "Minute",

  /**
   * Second
   */
  Second: "Second",
}

/**
 * Expression type.
 */
union ExpressionType {
  string,

  /**
   * Expression
   */
  Expression: "Expression",
}

/**
 * Pipeline reference type.
 */
union PipelineReferenceType {
  string,

  /**
   * PipelineReference
   */
  PipelineReference: "PipelineReference",
}

/**
 * Dataset reference type.
 */
union DatasetReferenceType {
  string,

  /**
   * DatasetReference
   */
  DatasetReference: "DatasetReference",
}

/**
 * Data flow reference type.
 */
union DataFlowReferenceType {
  string,

  /**
   * DataFlowReference
   */
  DataFlowReference: "DataFlowReference",
}

/**
 * Managed Virtual Network reference type.
 */
union ManagedVirtualNetworkReferenceType {
  string,

  /**
   * ManagedVirtualNetworkReference
   */
  ManagedVirtualNetworkReference: "ManagedVirtualNetworkReference",
}

/**
 * Credential reference type.
 */
union CredentialReferenceType {
  string,

  /**
   * CredentialReference
   */
  CredentialReference: "CredentialReference",
}

/**
 * Type of value copied from source.
 */
union ValueType {
  string,

  /**
   * actual
   */
  actual: "actual",

  /**
   * display
   */
  display: "display",
}

/**
 * Compute type of the cluster which will execute data flow job.
 */
union DataFlowComputeType {
  string,

  /**
   * General
   */
  General: "General",

  /**
   * MemoryOptimized
   */
  MemoryOptimized: "MemoryOptimized",

  /**
   * ComputeOptimized
   */
  ComputeOptimized: "ComputeOptimized",
}

/**
 * The pricing tier for the catalog database. The valid values could be found in https://azure.microsoft.com/en-us/pricing/details/sql-database/
 */
union IntegrationRuntimeSsisCatalogPricingTier {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * Premium
   */
  Premium: "Premium",

  /**
   * PremiumRS
   */
  PremiumRS: "PremiumRS",
}

/**
 * License type for bringing your own license scenario.
 */
union IntegrationRuntimeLicenseType {
  string,

  /**
   * BasePrice
   */
  BasePrice: "BasePrice",

  /**
   * LicenseIncluded
   */
  LicenseIncluded: "LicenseIncluded",
}

/**
 * The type of this referenced entity.
 */
union IntegrationRuntimeEntityReferenceType {
  string,

  /**
   * IntegrationRuntimeReference
   */
  IntegrationRuntimeReference: "IntegrationRuntimeReference",

  /**
   * LinkedServiceReference
   */
  LinkedServiceReference: "LinkedServiceReference",
}

/**
 * The edition for the SSIS Integration Runtime
 */
union IntegrationRuntimeEdition {
  string,

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * Enterprise
   */
  Enterprise: "Enterprise",
}

/**
 * The interactive authoring capability status. Must be one of InteractiveCapabilityStatus. The default value is 'Enabling'.
 */
union InteractiveCapabilityStatus {
  string,

  /**
   * Enabling
   */
  Enabling: "Enabling",

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabling
   */
  Disabling: "Disabling",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * The managed integration runtime node status.
 */
union ManagedIntegrationRuntimeNodeStatus {
  string,

  /**
   * Starting
   */
  Starting: "Starting",

  /**
   * Available
   */
  Available: "Available",

  /**
   * Recycling
   */
  Recycling: "Recycling",

  /**
   * Unavailable
   */
  Unavailable: "Unavailable",
}

/**
 * It is used to set the encryption mode for node-node communication channel (when more than 2 self-hosted integration runtime nodes exist).
 */
union IntegrationRuntimeInternalChannelEncryptionMode {
  string,

  /**
   * NotSet
   */
  NotSet: "NotSet",

  /**
   * SslEncrypted
   */
  SslEncrypted: "SslEncrypted",

  /**
   * NotEncrypted
   */
  NotEncrypted: "NotEncrypted",
}

/**
 * The type used for authentication. Type: string.
 */
union AzureStorageAuthenticationType {
  string,

  /**
   * Anonymous
   */
  Anonymous: "Anonymous",

  /**
   * AccountKey
   */
  AccountKey: "AccountKey",

  /**
   * SasUri
   */
  SasUri: "SasUri",

  /**
   * ServicePrincipal
   */
  ServicePrincipal: "ServicePrincipal",

  /**
   * Msi
   */
  Msi: "Msi",
}

/**
 * The type used for authentication. Type: string.
 */
union AzureSqlDWAuthenticationType {
  string,

  /**
   * SQL
   */
  SQL: "SQL",

  /**
   * ServicePrincipal
   */
  ServicePrincipal: "ServicePrincipal",

  /**
   * SystemAssignedManagedIdentity
   */
  SystemAssignedManagedIdentity: "SystemAssignedManagedIdentity",

  /**
   * UserAssignedManagedIdentity
   */
  UserAssignedManagedIdentity: "UserAssignedManagedIdentity",
}

/**
 * The type used for authentication. Type: string.
 */
union SqlServerAuthenticationType {
  string,

  /**
   * SQL
   */
  SQL: "SQL",

  /**
   * Windows
   */
  Windows: "Windows",

  /**
   * UserAssignedManagedIdentity
   */
  UserAssignedManagedIdentity: "UserAssignedManagedIdentity",
}

/**
 * Sql always encrypted AKV authentication type. Type: string.
 */
union SqlAlwaysEncryptedAkvAuthType {
  string,

  /**
   * ServicePrincipal
   */
  ServicePrincipal: "ServicePrincipal",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * UserAssignedManagedIdentity
   */
  UserAssignedManagedIdentity: "UserAssignedManagedIdentity",
}

/**
 * The type used for authentication. Type: string.
 */
union AmazonRdsForSqlAuthenticationType {
  string,

  /**
   * SQL
   */
  SQL: "SQL",

  /**
   * Windows
   */
  Windows: "Windows",
}

/**
 * The type used for authentication. Type: string.
 */
union AzureSqlDatabaseAuthenticationType {
  string,

  /**
   * SQL
   */
  SQL: "SQL",

  /**
   * ServicePrincipal
   */
  ServicePrincipal: "ServicePrincipal",

  /**
   * SystemAssignedManagedIdentity
   */
  SystemAssignedManagedIdentity: "SystemAssignedManagedIdentity",

  /**
   * UserAssignedManagedIdentity
   */
  UserAssignedManagedIdentity: "UserAssignedManagedIdentity",
}

/**
 * The type used for authentication. Type: string.
 */
union AzureSqlMIAuthenticationType {
  string,

  /**
   * SQL
   */
  SQL: "SQL",

  /**
   * ServicePrincipal
   */
  ServicePrincipal: "ServicePrincipal",

  /**
   * SystemAssignedManagedIdentity
   */
  SystemAssignedManagedIdentity: "SystemAssignedManagedIdentity",

  /**
   * UserAssignedManagedIdentity
   */
  UserAssignedManagedIdentity: "UserAssignedManagedIdentity",
}

/**
 * The connection mode used to access CosmosDB account. Type: string.
 */
union CosmosDbConnectionMode {
  string,

  /**
   * Gateway
   */
  Gateway: "Gateway",

  /**
   * Direct
   */
  Direct: "Direct",
}

/**
 * HDInsight cluster authentication type.
 */
union HDInsightClusterAuthenticationType {
  string,

  /**
   * BasicAuth
   */
  BasicAuth: "BasicAuth",

  /**
   * SystemAssignedManagedIdentity
   */
  SystemAssignedManagedIdentity: "SystemAssignedManagedIdentity",

  /**
   * UserAssignedManagedIdentity
   */
  UserAssignedManagedIdentity: "UserAssignedManagedIdentity",
}

/**
 * Authentication type for connecting to the Oracle database. Only used for Version 2.0.
 */
union OracleAuthenticationType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",
}

/**
 * Authentication type for connecting to the AmazonRdsForOracle database. Only used for Version 2.0.
 */
union AmazonRdsForOracleAuthenticationType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",
}

/**
 * AuthenticationType to be used for connection.
 */
union SybaseAuthenticationType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * Windows
   */
  Windows: "Windows",
}

/**
 * AuthenticationType to be used for connection. It is mutually exclusive with connectionString property.
 */
union Db2AuthenticationType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",
}

/**
 * AuthenticationType to be used for connection.
 */
union TeradataAuthenticationType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * Windows
   */
  Windows: "Windows",
}

/**
 * Type of authentication used to connect to the OData service.
 */
union ODataAuthenticationType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * Anonymous
   */
  Anonymous: "Anonymous",

  /**
   * Windows
   */
  Windows: "Windows",

  /**
   * AadServicePrincipal
   */
  AadServicePrincipal: "AadServicePrincipal",

  /**
   * ManagedServiceIdentity
   */
  ManagedServiceIdentity: "ManagedServiceIdentity",
}

/**
 * Specify the credential type (key or cert) is used for service principal.
 */
union ODataAadServicePrincipalCredentialType {
  string,

  /**
   * ServicePrincipalKey
   */
  ServicePrincipalKey: "ServicePrincipalKey",

  /**
   * ServicePrincipalCert
   */
  ServicePrincipalCert: "ServicePrincipalCert",
}

/**
 * Type of authentication used to connect to the web table source.
 */
union WebAuthenticationType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * Anonymous
   */
  Anonymous: "Anonymous",

  /**
   * ClientCertificate
   */
  ClientCertificate: "ClientCertificate",
}

/**
 * The authentication type to be used to connect to the MongoDB database.
 */
union MongoDbAuthenticationType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * Anonymous
   */
  Anonymous: "Anonymous",
}

/**
 * Type of authentication used to connect to the REST service.
 */
union RestServiceAuthenticationType {
  string,

  /**
   * Anonymous
   */
  Anonymous: "Anonymous",

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * AadServicePrincipal
   */
  AadServicePrincipal: "AadServicePrincipal",

  /**
   * ManagedServiceIdentity
   */
  ManagedServiceIdentity: "ManagedServiceIdentity",

  /**
   * OAuth2ClientCredential
   */
  OAuth2ClientCredential: "OAuth2ClientCredential",
}

/**
 * The authentication type to use.
 */
union TeamDeskAuthenticationType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * Token
   */
  Token: "Token",
}

/**
 * The authentication type to use.
 */
union ZendeskAuthenticationType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * Token
   */
  Token: "Token",
}

/**
 * The authentication type to be used to connect to the HTTP server.
 */
union HttpAuthenticationType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * Anonymous
   */
  Anonymous: "Anonymous",

  /**
   * Digest
   */
  Digest: "Digest",

  /**
   * Windows
   */
  Windows: "Windows",

  /**
   * ClientCertificate
   */
  ClientCertificate: "ClientCertificate",
}

/**
 * The authentication type to be used to connect to the FTP server.
 */
union FtpAuthenticationType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * Anonymous
   */
  Anonymous: "Anonymous",
}

/**
 * The authentication type to be used to connect to the FTP server.
 */
union SftpAuthenticationType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * SshPublicKey
   */
  SshPublicKey: "SshPublicKey",

  /**
   * MultiFactor
   */
  MultiFactor: "MultiFactor",
}

/**
 * The authentication type to be used to connect to the SAP HANA server.
 */
union SapHanaAuthenticationType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * Windows
   */
  Windows: "Windows",
}

/**
 * The OAuth 2.0 authentication mechanism used for authentication. ServiceAuthentication can only be used on self-hosted IR.
 */
union GoogleBigQueryAuthenticationType {
  string,

  /**
   * ServiceAuthentication
   */
  ServiceAuthentication: "ServiceAuthentication",

  /**
   * UserAuthentication
   */
  UserAuthentication: "UserAuthentication",
}

/**
 * The OAuth 2.0 authentication mechanism used for authentication.
 */
union GoogleBigQueryV2AuthenticationType {
  string,

  /**
   * ServiceAuthentication
   */
  ServiceAuthentication: "ServiceAuthentication",

  /**
   * UserAuthentication
   */
  UserAuthentication: "UserAuthentication",
}

/**
 * The authentication type to use. Type: string. Only used for V2.
 */
union GreenplumAuthenticationType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",
}

/**
 * The authentication mechanism to use to connect to the HBase server.
 */
union HBaseAuthenticationType {
  string,

  /**
   * Anonymous
   */
  Anonymous: "Anonymous",

  /**
   * Basic
   */
  Basic: "Basic",
}

/**
 * The type of Hive server.
 */
union HiveServerType {
  string,

  /**
   * HiveServer1
   */
  HiveServer1: "HiveServer1",

  /**
   * HiveServer2
   */
  HiveServer2: "HiveServer2",

  /**
   * HiveThriftServer
   */
  HiveThriftServer: "HiveThriftServer",
}

/**
 * The transport protocol to use in the Thrift layer.
 */
union HiveThriftTransportProtocol {
  string,

  /**
   * Binary
   */
  Binary: "Binary",

  /**
   * SASL
   */
  SASL: "SASL",

  /**
   * HTTP
   */
  `HTTP `: "HTTP ",
}

/**
 * The authentication method used to access the Hive server.
 */
union HiveAuthenticationType {
  string,

  /**
   * Anonymous
   */
  Anonymous: "Anonymous",

  /**
   * Username
   */
  Username: "Username",

  /**
   * UsernameAndPassword
   */
  UsernameAndPassword: "UsernameAndPassword",

  /**
   * WindowsAzureHDInsightService
   */
  WindowsAzureHDInsightService: "WindowsAzureHDInsightService",
}

/**
 * The authentication type to use.
 */
union ImpalaAuthenticationType {
  string,

  /**
   * Anonymous
   */
  Anonymous: "Anonymous",

  /**
   * SASLUsername
   */
  SASLUsername: "SASLUsername",

  /**
   * UsernameAndPassword
   */
  UsernameAndPassword: "UsernameAndPassword",
}

/**
 * The authentication mechanism used to connect to the Phoenix server.
 */
union PhoenixAuthenticationType {
  string,

  /**
   * Anonymous
   */
  Anonymous: "Anonymous",

  /**
   * UsernameAndPassword
   */
  UsernameAndPassword: "UsernameAndPassword",

  /**
   * WindowsAzureHDInsightService
   */
  WindowsAzureHDInsightService: "WindowsAzureHDInsightService",
}

/**
 * The authentication mechanism used to connect to the Presto server.
 */
union PrestoAuthenticationType {
  string,

  /**
   * Anonymous
   */
  Anonymous: "Anonymous",

  /**
   * LDAP
   */
  LDAP: "LDAP",
}

/**
 * The authentication type to use.
 */
union ServiceNowAuthenticationType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * OAuth2
   */
  OAuth2: "OAuth2",
}

/**
 * The type of Spark server.
 */
union SparkServerType {
  string,

  /**
   * SharkServer
   */
  SharkServer: "SharkServer",

  /**
   * SharkServer2
   */
  SharkServer2: "SharkServer2",

  /**
   * SparkThriftServer
   */
  SparkThriftServer: "SparkThriftServer",
}

/**
 * The transport protocol to use in the Thrift layer.
 */
union SparkThriftTransportProtocol {
  string,

  /**
   * Binary
   */
  Binary: "Binary",

  /**
   * SASL
   */
  SASL: "SASL",

  /**
   * HTTP
   */
  `HTTP `: "HTTP ",
}

/**
 * The authentication method used to access the Spark server.
 */
union SparkAuthenticationType {
  string,

  /**
   * Anonymous
   */
  Anonymous: "Anonymous",

  /**
   * Username
   */
  Username: "Username",

  /**
   * UsernameAndPassword
   */
  UsernameAndPassword: "UsernameAndPassword",

  /**
   * WindowsAzureHDInsightService
   */
  WindowsAzureHDInsightService: "WindowsAzureHDInsightService",
}

/**
 * Specifies the security level for the driver connection to the data store. PreferredUnSecured : prefer unsecured, allow fallback to secured connection if required. OnlyUnSecured : strictly unsecured, no fallback.
 */
union NetezzaSecurityLevelType {
  string,

  /**
   * PreferredUnSecured
   */
  PreferredUnSecured: "PreferredUnSecured",

  /**
   * OnlyUnSecured
   */
  OnlyUnSecured: "OnlyUnSecured",
}

/**
 * HDInsight On-demand cluster resource group authentication type.
 */
union HDInsightOndemandClusterResourceGroupAuthenticationType {
  string,

  /**
   * ServicePrincipalKey
   */
  ServicePrincipalKey: "ServicePrincipalKey",

  /**
   * SystemAssignedManagedIdentity
   */
  SystemAssignedManagedIdentity: "SystemAssignedManagedIdentity",

  /**
   * UserAssignedManagedIdentity
   */
  UserAssignedManagedIdentity: "UserAssignedManagedIdentity",
}

/**
 * The OAuth 2.0 authentication mechanism used for authentication. ServiceAuthentication can only be used on self-hosted IR.
 */
union GoogleAdWordsAuthenticationType {
  string,

  /**
   * ServiceAuthentication
   */
  ServiceAuthentication: "ServiceAuthentication",

  /**
   * UserAuthentication
   */
  UserAuthentication: "UserAuthentication",
}

/**
 * The type used for authentication. Type: string.
 */
union SnowflakeAuthenticationType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * KeyPair
   */
  KeyPair: "KeyPair",

  /**
   * AADServicePrincipal
   */
  AADServicePrincipal: "AADServicePrincipal",
}

/**
 * The authentication type to use.
 */
union LakehouseAuthenticationType {
  string,

  /**
   * ServicePrincipal
   */
  ServicePrincipal: "ServicePrincipal",

  /**
   * SystemAssignedManagedIdentity
   */
  SystemAssignedManagedIdentity: "SystemAssignedManagedIdentity",

  /**
   * UserAssignedManagedIdentity
   */
  UserAssignedManagedIdentity: "UserAssignedManagedIdentity",
}

/**
 * The authentication type to use.
 */
union WarehouseAuthenticationType {
  string,

  /**
   * ServicePrincipal
   */
  ServicePrincipal: "ServicePrincipal",

  /**
   * SystemAssignedManagedIdentity
   */
  SystemAssignedManagedIdentity: "SystemAssignedManagedIdentity",

  /**
   * UserAssignedManagedIdentity
   */
  UserAssignedManagedIdentity: "UserAssignedManagedIdentity",
}

/**
 * The authentication type to use.
 */
union ServiceNowV2AuthenticationType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * OAuth2
   */
  OAuth2: "OAuth2",
}

/**
 * The consistency level specifies how many Cassandra servers must respond to a read request before returning data to the client application. Cassandra checks the specified number of Cassandra servers for data to satisfy the read request. Must be one of cassandraSourceReadConsistencyLevels. The default value is 'ONE'. It is case-insensitive.
 */
union CassandraSourceReadConsistencyLevels {
  string,

  /**
   * ALL
   */
  ALL: "ALL",

  /**
   * EACH_QUORUM
   */
  EACH_QUORUM: "EACH_QUORUM",

  /**
   * QUORUM
   */
  QUORUM: "QUORUM",

  /**
   * LOCAL_QUORUM
   */
  LOCAL_QUORUM: "LOCAL_QUORUM",

  /**
   * ONE
   */
  ONE: "ONE",

  /**
   * TWO
   */
  TWO: "TWO",

  /**
   * THREE
   */
  THREE: "THREE",

  /**
   * LOCAL_ONE
   */
  LOCAL_ONE: "LOCAL_ONE",

  /**
   * SERIAL
   */
  SERIAL: "SERIAL",

  /**
   * LOCAL_SERIAL
   */
  LOCAL_SERIAL: "LOCAL_SERIAL",
}

/**
 * The write behavior for the operation. Default is Bulk Insert.
 */
union AzurePostgreSqlWriteMethodEnum {
  string,

  /**
   * BulkInsert
   */
  BulkInsert: "BulkInsert",

  /**
   * CopyCommand
   */
  CopyCommand: "CopyCommand",

  /**
   * Upsert
   */
  Upsert: "Upsert",
}

/**
 * Stored procedure parameter type.
 */
union StoredProcedureParameterType {
  string,

  /**
   * String
   */
  String: "String",

  /**
   * Int
   */
  Int: "Int",

  /**
   * Int64
   */
  Int64: "Int64",

  /**
   * Decimal
   */
  Decimal: "Decimal",

  /**
   * Guid
   */
  Guid: "Guid",

  /**
   * Boolean
   */
  Boolean: "Boolean",

  /**
   * Date
   */
  Date: "Date",
}

/**
 * The write behavior for the operation. Default is 'Insert'.
 */
union SapCloudForCustomerSinkWriteBehavior {
  string,

  /**
   * Insert
   */
  Insert: "Insert",

  /**
   * Update
   */
  Update: "Update",
}

/**
 * Indicates whether the RejectValue property is specified as a literal value or a percentage.
 */
union PolybaseSettingsRejectType {
  string,

  /**
   * value
   */
  value: "value",

  /**
   * percentage
   */
  percentage: "percentage",
}

/**
 * Specify the write behavior when upserting documents into Azure Search Index.
 */
union AzureSearchIndexWriteBehaviorType {
  string,

  /**
   * Merge
   */
  Merge: "Merge",

  /**
   * Upload
   */
  Upload: "Upload",
}

/**
 * Defines values for DynamicsSinkWriteBehavior.
 */
union DynamicsSinkWriteBehavior {
  string,

  /**
   * Upsert
   */
  Upsert: "Upsert",
}

/**
 * The write behavior for the operation. Default is Insert.
 */
union SalesforceSinkWriteBehavior {
  string,

  /**
   * Insert
   */
  Insert: "Insert",

  /**
   * Upsert
   */
  Upsert: "Upsert",
}

/**
 * The HDInsightActivityDebugInfoOption settings to use.
 */
union HDInsightActivityDebugInfoOption {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Always
   */
  Always: "Always",

  /**
   * Failure
   */
  Failure: "Failure",
}

/**
 * The type of SSIS package location.
 */
union SsisPackageLocationType {
  string,

  /**
   * SSISDB
   */
  SSISDB: "SSISDB",

  /**
   * File
   */
  File: "File",

  /**
   * InlinePackage
   */
  InlinePackage: "InlinePackage",

  /**
   * PackageStore
   */
  PackageStore: "PackageStore",
}

/**
 * The type of SSIS log location.
 */
union SsisLogLocationType {
  string,

  /**
   * File
   */
  File: "File",
}

/**
 * The list of HTTP methods supported by a WebActivity.
 */
union WebActivityMethod {
  string,

  /**
   * GET
   */
  GET: "GET",

  /**
   * POST
   */
  POST: "POST",

  /**
   * PUT
   */
  PUT: "PUT",

  /**
   * DELETE
   */
  DELETE: "DELETE",
}

/**
 * The list of HTTP methods supported by a AzureFunctionActivity.
 */
union AzureFunctionActivityMethod {
  string,

  /**
   * GET
   */
  GET: "GET",

  /**
   * POST
   */
  POST: "POST",

  /**
   * PUT
   */
  PUT: "PUT",

  /**
   * DELETE
   */
  DELETE: "DELETE",

  /**
   * OPTIONS
   */
  OPTIONS: "OPTIONS",

  /**
   * HEAD
   */
  HEAD: "HEAD",

  /**
   * TRACE
   */
  TRACE: "TRACE",
}

/**
 * The list of HTTP methods supported by a WebHook activity.
 */
union WebHookActivityMethod {
  string,

  /**
   * POST
   */
  POST: "POST",
}

/**
 * The type of the parameter.
 */
union ScriptActivityParameterType {
  string,

  /**
   * Boolean
   */
  Boolean: "Boolean",

  /**
   * DateTime
   */
  DateTime: "DateTime",

  /**
   * DateTimeOffset
   */
  DateTimeOffset: "DateTimeOffset",

  /**
   * Decimal
   */
  Decimal: "Decimal",

  /**
   * Double
   */
  Double: "Double",

  /**
   * Guid
   */
  Guid: "Guid",

  /**
   * Int16
   */
  Int16: "Int16",

  /**
   * Int32
   */
  Int32: "Int32",

  /**
   * Int64
   */
  Int64: "Int64",

  /**
   * Single
   */
  Single: "Single",

  /**
   * String
   */
  String: "String",

  /**
   * Timespan
   */
  Timespan: "Timespan",
}

/**
 * The direction of the parameter.
 */
union ScriptActivityParameterDirection {
  string,

  /**
   * Input
   */
  Input: "Input",

  /**
   * Output
   */
  Output: "Output",

  /**
   * InputOutput
   */
  InputOutput: "InputOutput",
}

/**
 * The destination of logs. Type: string.
 */
union ScriptActivityLogDestination {
  string,

  /**
   * ActivityOutput
   */
  ActivityOutput: "ActivityOutput",

  /**
   * ExternalStore
   */
  ExternalStore: "ExternalStore",
}

/**
 * Synapse notebook reference type.
 */
union NotebookReferenceType {
  string,

  /**
   * NotebookReference
   */
  NotebookReference: "NotebookReference",
}

/**
 * Big data pool reference type.
 */
union BigDataPoolReferenceType {
  string,

  /**
   * BigDataPoolReference
   */
  BigDataPoolReference: "BigDataPoolReference",
}

/**
 * Notebook parameter type.
 */
union NotebookParameterType {
  string,

  /**
   * string
   */
  string: "string",

  /**
   * int
   */
  int: "int",

  /**
   * float
   */
  float: "float",

  /**
   * bool
   */
  bool: "bool",
}

/**
 * The type of the spark config.
 */
union ConfigurationType {
  string,

  /**
   * Default
   */
  Default: "Default",

  /**
   * Customized
   */
  Customized: "Customized",

  /**
   * Artifact
   */
  Artifact: "Artifact",
}

/**
 * Spark configuration reference type.
 */
union SparkConfigurationReferenceType {
  string,

  /**
   * SparkConfigurationReference
   */
  SparkConfigurationReference: "SparkConfigurationReference",
}

/**
 * Synapse spark job reference type.
 */
union SparkJobReferenceType {
  string,

  /**
   * SparkJobDefinitionReference
   */
  SparkJobDefinitionReference: "SparkJobDefinitionReference",
}

/**
 * The write behavior for the operation. Default is Insert.
 */
union SalesforceV2SinkWriteBehavior {
  string,

  /**
   * Insert
   */
  Insert: "Insert",

  /**
   * Upsert
   */
  Upsert: "Upsert",
}

/**
 * Type of expressions supported by the system. Type: string.
 */
union ExpressionV2Type {
  string,

  /**
   * Constant
   */
  Constant: "Constant",

  /**
   * Field
   */
  Field: "Field",

  /**
   * Unary
   */
  Unary: "Unary",

  /**
   * Binary
   */
  Binary: "Binary",

  /**
   * NAry
   */
  NAry: "NAry",
}

/**
 * Enumerates possible frequency option for the schedule trigger.
 */
union RecurrenceFrequency {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Minute
   */
  Minute: "Minute",

  /**
   * Hour
   */
  Hour: "Hour",

  /**
   * Day
   */
  Day: "Day",

  /**
   * Week
   */
  Week: "Week",

  /**
   * Month
   */
  Month: "Month",

  /**
   * Year
   */
  Year: "Year",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union BlobEventTypes {
  string,

  /**
   * Microsoft.Storage.BlobCreated
   */
  `Microsoft.Storage.BlobCreated`: "Microsoft.Storage.BlobCreated",

  /**
   * Microsoft.Storage.BlobDeleted
   */
  `Microsoft.Storage.BlobDeleted`: "Microsoft.Storage.BlobDeleted",
}

/**
 * Enumerates possible frequency option for the tumbling window trigger.
 */
union TumblingWindowFrequency {
  string,

  /**
   * Minute
   */
  Minute: "Minute",

  /**
   * Hour
   */
  Hour: "Hour",

  /**
   * Month
   */
  Month: "Month",
}

/**
 * Trigger reference type.
 */
union TriggerReferenceType {
  string,

  /**
   * TriggerReference
   */
  TriggerReference: "TriggerReference",
}

/**
 * JSON format file pattern. A property of JsonFormat.
 */
union JsonFormatFilePattern {
  string,

  /**
   * setOfObjects
   */
  setOfObjects: "setOfObjects",

  /**
   * arrayOfObjects
   */
  arrayOfObjects: "arrayOfObjects",
}

/**
 * All available compression levels.
 */
union DatasetCompressionLevel {
  string,

  /**
   * Optimal
   */
  Optimal: "Optimal",

  /**
   * Fastest
   */
  Fastest: "Fastest",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AvroCompressionCodec {
  string,

  /**
   * none
   */
  none: "none",

  /**
   * deflate
   */
  deflate: "deflate",

  /**
   * snappy
   */
  snappy: "snappy",

  /**
   * xz
   */
  xz: "xz",

  /**
   * bzip2
   */
  bzip2: "bzip2",
}

/**
 * All available compressionCodec values.
 */
union CompressionCodec {
  string,

  /**
   * none
   */
  none: "none",

  /**
   * lzo
   */
  lzo: "lzo",

  /**
   * bzip2
   */
  bzip2: "bzip2",

  /**
   * gzip
   */
  gzip: "gzip",

  /**
   * deflate
   */
  deflate: "deflate",

  /**
   * zipDeflate
   */
  zipDeflate: "zipDeflate",

  /**
   * snappy
   */
  snappy: "snappy",

  /**
   * lz4
   */
  lz4: "lz4",

  /**
   * tar
   */
  tar: "tar",

  /**
   * tarGZip
   */
  tarGZip: "tarGZip",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union OrcCompressionCodec {
  string,

  /**
   * none
   */
  none: "none",

  /**
   * zlib
   */
  zlib: "zlib",

  /**
   * snappy
   */
  snappy: "snappy",

  /**
   * lzo
   */
  lzo: "lzo",
}

/**
 * All available dynamicsDeploymentType values.
 */
union DynamicsDeploymentType {
  string,

  /**
   * Online
   */
  Online: "Online",

  /**
   * OnPremisesWithIfd
   */
  OnPremisesWithIfd: "OnPremisesWithIfd",
}

/**
 * All available dynamicsAuthenticationType values.
 */
union DynamicsAuthenticationType {
  string,

  /**
   * Office365
   */
  Office365: "Office365",

  /**
   * Ifd
   */
  Ifd: "Ifd",

  /**
   * AADServicePrincipal
   */
  AADServicePrincipal: "AADServicePrincipal",

  /**
   * Active Directory
   */
  `Active Directory`: "Active Directory",
}

/**
 * All available servicePrincipalCredentialType values.
 */
union ServicePrincipalCredentialType {
  string,

  /**
   * ServicePrincipalKey
   */
  ServicePrincipalKey: "ServicePrincipalKey",

  /**
   * ServicePrincipalCert
   */
  ServicePrincipalCert: "ServicePrincipalCert",
}

/**
 * All available HdiNodeTypes values.
 */
union HdiNodeTypes {
  string,

  /**
   * Headnode
   */
  Headnode: "Headnode",

  /**
   * Workernode
   */
  Workernode: "Workernode",

  /**
   * Zookeeper
   */
  Zookeeper: "Zookeeper",
}

/**
 * All available filePatterns.
 */
union JsonWriteFilePattern {
  string,

  /**
   * setOfObjects
   */
  setOfObjects: "setOfObjects",

  /**
   * arrayOfObjects
   */
  arrayOfObjects: "arrayOfObjects",
}

/**
 * The Salesforce read behavior for the operation
 */
union SalesforceSourceReadBehavior {
  string,

  /**
   * Query
   */
  Query: "Query",

  /**
   * QueryAll
   */
  QueryAll: "QueryAll",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AmazonRdsForOraclePartitionOption {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * PhysicalPartitionsOfTable
   */
  PhysicalPartitionsOfTable: "PhysicalPartitionsOfTable",

  /**
   * DynamicRange
   */
  DynamicRange: "DynamicRange",
}

/**
 * All available types of copy behavior.
 */
union CopyBehaviorType {
  string,

  /**
   * PreserveHierarchy
   */
  PreserveHierarchy: "PreserveHierarchy",

  /**
   * FlattenHierarchy
   */
  FlattenHierarchy: "FlattenHierarchy",

  /**
   * MergeFiles
   */
  MergeFiles: "MergeFiles",
}

/**
 * Specify the write behavior when copying data into sql.
 */
union SqlWriteBehaviorEnum {
  string,

  /**
   * Insert
   */
  Insert: "Insert",

  /**
   * Upsert
   */
  Upsert: "Upsert",

  /**
   * StoredProcedure
   */
  StoredProcedure: "StoredProcedure",
}

/**
 * Specify the write behavior when copying data into sql dw.
 */
union SqlDWWriteBehaviorEnum {
  string,

  /**
   * Insert
   */
  Insert: "Insert",

  /**
   * Upsert
   */
  Upsert: "Upsert",
}

/**
 * The type of the ScriptActivityScriptBlock.
 */
union ScriptType {
  string,

  /**
   * Query
   */
  Query: "Query",

  /**
   * NonQuery
   */
  NonQuery: "NonQuery",
}

/**
 * The partition mechanism that will be used for Sql read in parallel.
 */
union SqlPartitionOption {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * PhysicalPartitionsOfTable
   */
  PhysicalPartitionsOfTable: "PhysicalPartitionsOfTable",

  /**
   * DynamicRange
   */
  DynamicRange: "DynamicRange",
}

/**
 * The partition mechanism that will be used for SAP HANA read in parallel.
 */
union SapHanaPartitionOption {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * PhysicalPartitionsOfTable
   */
  PhysicalPartitionsOfTable: "PhysicalPartitionsOfTable",

  /**
   * SapHanaDynamicRange
   */
  SapHanaDynamicRange: "SapHanaDynamicRange",
}

/**
 * The partition mechanism that will be used for SAP table read in parallel.
 */
union SapTablePartitionOption {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * PartitionOnInt
   */
  PartitionOnInt: "PartitionOnInt",

  /**
   * PartitionOnCalendarYear
   */
  PartitionOnCalendarYear: "PartitionOnCalendarYear",

  /**
   * PartitionOnCalendarMonth
   */
  PartitionOnCalendarMonth: "PartitionOnCalendarMonth",

  /**
   * PartitionOnCalendarDate
   */
  PartitionOnCalendarDate: "PartitionOnCalendarDate",

  /**
   * PartitionOnTime
   */
  PartitionOnTime: "PartitionOnTime",
}

/**
 * The partition mechanism that will be used for Oracle read in parallel.
 */
union OraclePartitionOption {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * PhysicalPartitionsOfTable
   */
  PhysicalPartitionsOfTable: "PhysicalPartitionsOfTable",

  /**
   * DynamicRange
   */
  DynamicRange: "DynamicRange",
}

/**
 * The partition mechanism that will be used for teradata read in parallel.
 */
union TeradataPartitionOption {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Hash
   */
  Hash: "Hash",

  /**
   * DynamicRange
   */
  DynamicRange: "DynamicRange",
}

/**
 * The partition mechanism that will be used for Netezza read in parallel.
 */
union NetezzaPartitionOption {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * DataSlice
   */
  DataSlice: "DataSlice",

  /**
   * DynamicRange
   */
  DynamicRange: "DynamicRange",
}

/**
 * The transport protocol to use in the Thrift layer (for V2 only). Default value is Binary.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ImpalaThriftTransportProtocol {
  /**
   * Binary
   */
  Binary,

  /**
   * HTTP
   */
  HTTP,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DaysOfWeek {
  /**
   * Sunday
   */
  Sunday,

  /**
   * Monday
   */
  Monday,

  /**
   * Tuesday
   */
  Tuesday,

  /**
   * Wednesday
   */
  Wednesday,

  /**
   * Thursday
   */
  Thursday,

  /**
   * Friday
   */
  Friday,

  /**
   * Saturday
   */
  Saturday,
}

/**
 * The days of the week.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DayOfWeek {
  /**
   * Sunday
   */
  Sunday,

  /**
   * Monday
   */
  Monday,

  /**
   * Tuesday
   */
  Tuesday,

  /**
   * Wednesday
   */
  Wednesday,

  /**
   * Thursday
   */
  Thursday,

  /**
   * Friday
   */
  Friday,

  /**
   * Saturday
   */
  Saturday,
}

/** A list of operations that can be performed by the Data Factory service. */
model OperationListResponse {
  /** List of Data Factory operations supported by the Data Factory resource provider. */
  @pageItems
  @identifiers(#["name"])
  value?: Operation[];

  /** The link to the next page of results, if any remaining results exist. */
  @nextLink
  nextLink?: string;
}

/**
 * Azure Data Factory API operation definition.
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * The intended executor of the operation.
   */
  origin?: string;

  /**
   * Metadata associated with the operation.
   */
  display?: OperationDisplay;

  /**
   * Additional details about the operation.
   */
  properties?: OperationProperties;
}

/**
 * Metadata associated with the operation.
 */
model OperationDisplay {
  /**
   * The description of the operation.
   */
  description?: string;

  /**
   * The name of the provider.
   */
  provider?: string;

  /**
   * The name of the resource type on which the operation is performed.
   */
  resource?: string;

  /**
   * The type of operation: get, read, delete, etc.
   */
  operation?: string;
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
  @identifiers(#["name"])
  logSpecifications?: OperationLogSpecification[];

  /**
   * Details about operations related to metrics.
   */
  @identifiers(#["name"])
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
  @identifiers(#[])
  availabilities?: OperationMetricAvailability[];

  /**
   * Defines the metric dimension.
   */
  @identifiers(#["name"])
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
@Azure.ResourceManager.Legacy.armExternalType
model CloudError {
  /**
   * Error data
   */
  error: CloudErrorBody;
}

/**
 * The object that defines the structure of an Azure Data Factory error.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
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
  @identifiers(#[])
  details?: CloudError[];
}

/**
 * A list of factory resources.
 */
model FactoryListResponse is Azure.Core.Page<Factory>;

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
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @format("uuid")
  principalId?: string;

  /**
   * The client tenant id of the identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @format("uuid")
  tenantId?: string;

  /**
   * List of user assigned identities for the factory.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<unknown>;
}

/**
 * Factory resource properties.
 */
model FactoryProperties {
  /**
   * Factory provisioning state, example Succeeded.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Time the factory was created in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  /**
   * Version of the factory.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("type")
model FactoryRepoConfiguration {
  /**
   * Type of repo configuration.
   */
  type: string;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value: unknown;
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The resource location.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * The resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Etag identifies change in the resource.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  featureName?: string;

  /**
   * The feature value.
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * A list of exposure control features.
 */
model ExposureControlBatchRequest {
  /**
   * List of exposure control features.
   */
  @identifiers(#["featureName"])
  exposureControlRequests: ExposureControlRequest[];
}

/**
 * A list of exposure control feature values.
 */
model ExposureControlBatchResponse {
  /**
   * List of exposure control feature values.
   */
  @identifiers(#["featureName"])
  exposureControlResponses: ExposureControlResponse[];
}

/**
 * Parameters for updating a factory resource.
 */
model FactoryUpdateParameters {
  /**
   * The resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accessToken?: string;

  /**
   * Data Plane service base URL.
   */
  dataPlaneUrl?: string;
}

/**
 * A list of integration runtime resources.
 */
model IntegrationRuntimeListResponse
  is Azure.Core.Page<IntegrationRuntimeResource>;

/**
 * Azure Data Factory nested object which serves as a compute resource for activities.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("type")
model IntegrationRuntime {
  ...Record<unknown>;

  /**
   * Type of integration runtime.
   */
  type: IntegrationRuntimeType;

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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Etag identifies change in the resource.
   */
  @visibility(Lifecycle.Read)
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
  updateDelayOffset?: string;
}

/**
 * Integration runtime status response.
 */
model IntegrationRuntimeStatusResponse {
  /**
   * The integration runtime name.
   */
  @visibility(Lifecycle.Read)
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
model IntegrationRuntimeStatus {
  ...Record<unknown>;

  /**
   * Type of integration runtime.
   */
  type: IntegrationRuntimeType;

  /**
   * The data factory name which the integration runtime belong to.
   */
  @visibility(Lifecycle.Read)
  dataFactoryName?: string;

  /**
   * The state of integration runtime.
   */
  @visibility(Lifecycle.Read)
  state?: IntegrationRuntimeState;
}

/**
 * Azure-SSIS integration runtime outbound network dependency endpoints.
 */
model IntegrationRuntimeOutboundNetworkDependenciesEndpointsResponse {
  /**
   * The list of outbound network dependency endpoints.
   */
  @pageItems
  @identifiers(#["category"])
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
  @identifiers(#["domainName"])
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
  @identifiers(#["port"])
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
model IntegrationRuntimeConnectionInfo {
  ...Record<unknown>;

  /**
   * The token generated in service. Callers use this token to authenticate to integration runtime.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  serviceToken?: string;

  /**
   * The integration runtime SSL certificate thumbprint. Click-Once application uses it to do server validation.
   */
  @visibility(Lifecycle.Read)
  identityCertThumbprint?: string;

  /**
   * The on-premises integration runtime host URL.
   */
  @visibility(Lifecycle.Read)
  hostServiceUri?: string;

  /**
   * The integration runtime version.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The public key for encrypting a credential when transferring the credential to the integration runtime.
   */
  @visibility(Lifecycle.Read)
  publicKey?: string;

  /**
   * Whether the identity certificate is expired.
   */
  @visibility(Lifecycle.Read)
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
  @identifiers(#["nodeName"])
  nodes?: IntegrationRuntimeNodeMonitoringData[];
}

/**
 * Monitoring data for integration runtime node.
 */
model IntegrationRuntimeNodeMonitoringData {
  ...Record<unknown>;

  /**
   * Name of the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  nodeName?: string;

  /**
   * Available memory (MB) on the integration runtime node.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  availableMemoryInMB?: int32;

  /**
   * CPU percentage on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  cpuUtilization?: int32;

  /**
   * Maximum concurrent jobs on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  concurrentJobsLimit?: int32;

  /**
   * The number of jobs currently running on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  concurrentJobsRunning?: int32;

  /**
   * The maximum concurrent jobs in this integration runtime.
   */
  @visibility(Lifecycle.Read)
  maxConcurrentJobs?: int32;

  /**
   * Sent bytes on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  sentBytes?: float32;

  /**
   * Received bytes on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  receivedBytes?: float32;
}

/**
 * Data factory name for linked integration runtime request.
 */
model LinkedIntegrationRuntimeRequest {
  /**
   * The data factory name for linked integration runtime.
   */
  factoryName: string;
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
model SsisObjectMetadataListResponse is Azure.Core.Page<SsisObjectMetadata>;

/**
 * SSIS object metadata.
 */
@discriminator("type")
model SsisObjectMetadata {
  /**
   * Type of metadata.
   */
  type: SsisObjectMetadataType;

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
model SelfHostedIntegrationRuntimeNode {
  ...Record<unknown>;

  /**
   * Name of the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  nodeName?: string;

  /**
   * Machine name of the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  machineName?: string;

  /**
   * URI for the host machine of the integration runtime.
   */
  @visibility(Lifecycle.Read)
  hostServiceUri?: string;

  /**
   * Status of the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  status?: SelfHostedIntegrationRuntimeNodeStatus;

  /**
   * The integration runtime capabilities dictionary
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  capabilities?: Record<string>;

  /**
   * Status of the integration runtime node version.
   */
  @visibility(Lifecycle.Read)
  versionStatus?: string;

  /**
   * Version of the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The time at which the integration runtime node was registered in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  registerTime?: utcDateTime;

  /**
   * The most recent time at which the integration runtime was connected in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastConnectTime?: utcDateTime;

  /**
   * The time at which the integration runtime will expire in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  /**
   * The time the node last started up.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStartTime?: utcDateTime;

  /**
   * The integration runtime node last stop time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStopTime?: utcDateTime;

  /**
   * The result of the last integration runtime node update.
   */
  @visibility(Lifecycle.Read)
  lastUpdateResult?: IntegrationRuntimeUpdateResult;

  /**
   * The last time for the integration runtime node update start.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStartUpdateTime?: utcDateTime;

  /**
   * The last time for the integration runtime node update end.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastEndUpdateTime?: utcDateTime;

  /**
   * Indicates whether this node is the active dispatcher for integration runtime requests.
   */
  @visibility(Lifecycle.Read)
  isActiveDispatcher?: boolean;

  /**
   * Maximum concurrent jobs on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  concurrentJobsLimit?: int32;

  /**
   * The maximum concurrent jobs in this integration runtime.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  ipAddress?: string;
}

/**
 * The enable the interactive authoring information.
 */
model EnableInteractiveQueryRequest {
  /**
   * The allowed idle time for interactive authoring.
   */
  autoTerminationMinutes?: int32;
}

/**
 * A list of linked service resources.
 */
model LinkedServiceListResponse is Azure.Core.Page<LinkedServiceResource>;

/**
 * The nested object which contains the information and credential which can be used to connect with related store or compute resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("type")
model LinkedService {
  ...Record<unknown>;

  /**
   * Type of linked service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;

  /**
   * Version of the linked service.
   */
  version?: string;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<ParameterSpecification>;

  /**
   * List of tags that can be used for describing the linked service.
   */
  annotations?: unknown[];
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<unknown>;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  defaultValue?: unknown;
}

/**
 * A list of dataset resources.
 */
model DatasetListResponse is Azure.Core.Page<DatasetResource>;

/**
 * The Azure Data Factory nested object which identifies data within different data stores, such as tables, files, folders, and documents.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("type")
model Dataset {
  ...Record<unknown>;

  /**
   * Type of dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;

  /**
   * Dataset description.
   */
  description?: string;

  /**
   * Columns that define the structure of the dataset. Type: array (or Expression with resultType array), itemType: DatasetDataElement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  structure?: unknown;

  /**
   * Columns that define the physical type schema of the dataset. Type: array (or Expression with resultType array), itemType: DatasetSchemaDataElement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;

  /**
   * Linked service reference.
   */
  linkedServiceName: LinkedServiceReference;

  /**
   * Parameters for dataset.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<ParameterSpecification>;

  /**
   * List of tags that can be used for describing the Dataset.
   */
  annotations?: unknown[];

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
  type: Type;

  /**
   * Reference LinkedService name.
   */
  referenceName: string;

  /**
   * Arguments for LinkedService.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<unknown>;
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
 * A list of pipeline resources.
 */
model PipelineListResponse is Azure.Core.Page<PipelineResource>;

/**
 * A data factory pipeline.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Pipeline {
  /**
   * The description of the pipeline.
   */
  description?: string;

  /**
   * List of activities in pipeline.
   */
  @identifiers(#["name"])
  activities?: Activity[];

  /**
   * List of parameters for pipeline.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<ParameterSpecification>;

  /**
   * List of variables for pipeline.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  variables?: Record<VariableSpecification>;

  /**
   * The max number of concurrent runs for the pipeline.
   */
  @minValue(1)
  concurrency?: int32;

  /**
   * List of tags that can be used for describing the Pipeline.
   */
  annotations?: unknown[];

  /**
   * Dimensions emitted by Pipeline.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  runDimensions?: Record<unknown>;

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
model Activity {
  ...Record<unknown>;

  /**
   * Activity name.
   */
  name: string;

  /**
   * Type of activity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;

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
  @identifiers(#[])
  dependsOn?: ActivityDependency[];

  /**
   * Activity user properties.
   */
  @identifiers(#["name"])
  userProperties?: UserProperty[];
}

/**
 * Activity dependency information.
 */
model ActivityDependency {
  ...Record<unknown>;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  defaultValue?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  duration?: unknown;
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
  @identifiers(#[])
  filters?: RunQueryFilter[];

  /**
   * List of OrderBy option.
   */
  @identifiers(#[])
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
  @pageItems
  @identifiers(#["runId"])
  value: PipelineRun[];

  /**
   * The continuation token for getting the next page of results, if any remaining results exist, null otherwise.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  continuationToken?: string;
}

/**
 * Information about a pipeline run.
 */
model PipelineRun {
  ...Record<unknown>;

  /**
   * Identifier of a run.
   */
  @visibility(Lifecycle.Read)
  runId?: string;

  /**
   * Identifier that correlates all the recovery runs of a pipeline run.
   */
  @visibility(Lifecycle.Read)
  runGroupId?: string;

  /**
   * Indicates if the recovered pipeline run is the latest in its group.
   */
  @visibility(Lifecycle.Read)
  isLatest?: boolean;

  /**
   * The pipeline name.
   */
  @visibility(Lifecycle.Read)
  pipelineName?: string;

  /**
   * The full or partial list of parameter name, value pair used in the pipeline run.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  parameters?: Record<string>;

  /**
   * Run dimensions emitted by Pipeline run.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  runDimensions?: Record<string>;

  /**
   * Entity that started the pipeline run.
   */
  @visibility(Lifecycle.Read)
  invokedBy?: PipelineRunInvokedBy;

  /**
   * The last updated timestamp for the pipeline run event in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  /**
   * The start time of a pipeline run in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  runStart?: utcDateTime;

  /**
   * The end time of a pipeline run in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  runEnd?: utcDateTime;

  /**
   * The duration of a pipeline run.
   */
  @visibility(Lifecycle.Read)
  durationInMs?: int32;

  /**
   * The status of a pipeline run. Possible values: Queued, InProgress, Succeeded, Failed, Canceling, Cancelled
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The message from a pipeline run.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Provides entity name and id that started the pipeline run.
 */
model PipelineRunInvokedBy {
  /**
   * Name of the entity that started the pipeline run.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The ID of the entity that started the run.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The type of the entity that started the run.
   */
  @visibility(Lifecycle.Read)
  invokedByType?: string;

  /**
   * The name of the pipeline that triggered the run, if any.
   */
  @visibility(Lifecycle.Read)
  pipelineName?: string;

  /**
   * The run id of the pipeline that triggered the run, if any.
   */
  @visibility(Lifecycle.Read)
  pipelineRunId?: string;
}

/**
 * A list activity runs.
 */
model ActivityRunsQueryResponse {
  /**
   * List of activity runs.
   */
  @pageItems
  @identifiers(#["pipelineRunId"])
  value: ActivityRun[];

  /**
   * The continuation token for getting the next page of results, if any remaining results exist, null otherwise.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  continuationToken?: string;
}

/**
 * Information about an activity run in a pipeline.
 */
model ActivityRun {
  ...Record<unknown>;

  /**
   * The name of the pipeline.
   */
  @visibility(Lifecycle.Read)
  pipelineName?: string;

  /**
   * The id of the pipeline run.
   */
  @visibility(Lifecycle.Read)
  pipelineRunId?: string;

  /**
   * The name of the activity.
   */
  @visibility(Lifecycle.Read)
  activityName?: string;

  /**
   * The type of the activity.
   */
  @visibility(Lifecycle.Read)
  activityType?: string;

  /**
   * The id of the activity run.
   */
  @visibility(Lifecycle.Read)
  activityRunId?: string;

  /**
   * The name of the compute linked service.
   */
  @visibility(Lifecycle.Read)
  linkedServiceName?: string;

  /**
   * The status of the activity run.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The start time of the activity run in 'ISO 8601' format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  activityRunStart?: utcDateTime;

  /**
   * The end time of the activity run in 'ISO 8601' format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  activityRunEnd?: utcDateTime;

  /**
   * The duration of the activity run.
   */
  @visibility(Lifecycle.Read)
  durationInMs?: int32;

  /**
   * The input for the activity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  input?: unknown;

  /**
   * The output for the activity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  output?: unknown;

  /**
   * The error if any from the activity run.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  error?: unknown;
}

/**
 * A list of trigger resources.
 */
model TriggerListResponse is Azure.Core.Page<TriggerResource>;

/**
 * Azure data factory nested object which contains information about creating pipeline run
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("type")
model Trigger {
  ...Record<unknown>;

  /**
   * Trigger type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;

  /**
   * Trigger description.
   */
  description?: string;

  /**
   * Indicates if trigger is running or not. Updated when Start/Stop APIs are called on the Trigger.
   */
  @visibility(Lifecycle.Read)
  runtimeState?: TriggerRuntimeState;

  /**
   * List of tags that can be used for describing the trigger.
   */
  annotations?: unknown[];
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
  @pageItems
  value: TriggerResource[];

  /**
   * The continuation token for getting the next page of results, if any remaining results exist, null otherwise.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  continuationToken?: string;
}

/**
 * Defines the response of a trigger subscription operation.
 */
model TriggerSubscriptionOperationStatus {
  /**
   * Trigger name.
   */
  @visibility(Lifecycle.Read)
  triggerName?: string;

  /**
   * Event Subscription Status.
   */
  @visibility(Lifecycle.Read)
  status?: EventSubscriptionStatus;
}

/**
 * A list of trigger runs.
 */
model TriggerRunsQueryResponse {
  /**
   * List of trigger runs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  @identifiers(#["triggerRunId"])
  value: TriggerRun[];

  /**
   * The continuation token for getting the next page of results, if any remaining results exist, null otherwise.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  continuationToken?: string;
}

/**
 * Trigger runs.
 */
model TriggerRun {
  ...Record<unknown>;

  /**
   * Trigger run id.
   */
  @visibility(Lifecycle.Read)
  triggerRunId?: string;

  /**
   * Trigger name.
   */
  @visibility(Lifecycle.Read)
  triggerName?: string;

  /**
   * Trigger type.
   */
  @visibility(Lifecycle.Read)
  triggerType?: string;

  /**
   * Trigger run start time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  triggerRunTimestamp?: utcDateTime;

  /**
   * Trigger run status.
   */
  @visibility(Lifecycle.Read)
  status?: TriggerRunStatus;

  /**
   * Trigger error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * List of property name and value related to trigger run. Name, value pair depends on type of trigger.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  properties?: Record<string>;

  /**
   * List of pipeline name and run Id triggered by the trigger run.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  triggeredPipelines?: Record<string>;

  /**
   * Run dimension for which trigger was fired.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  runDimension?: Record<string>;

  /**
   * Status of the upstream pipelines.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  dependencyStatus?: Record<unknown>;
}

/**
 * Azure Data Factory nested object which contains a flow with data movements and transformations.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("type")
model DataFlow {
  /**
   * Type of data flow.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;

  /**
   * The description of the data flow.
   */
  description?: string;

  /**
   * List of tags that can be used for describing the data flow.
   */
  annotations?: unknown[];

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
 * A list of data flow resources.
 */
model DataFlowListResponse is Azure.Core.Page<DataFlowResource>;

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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
@@identifiers(QueryDataFlowDebugSessionsResponse.value,
  #["dataFlowName", "sessionId"]
);
model QueryDataFlowDebugSessionsResponse
  is Azure.Core.Page<DataFlowDebugSessionInfo>;

/**
 * Data flow debug session info.
 */
model DataFlowDebugSessionInfo {
  ...Record<unknown>;

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
model DataFlowDebugPackage {
  ...Record<unknown>;

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
  @identifiers(#["name"])
  dataFlows?: DataFlowDebugResource[];

  /**
   * List of datasets.
   */
  @identifiers(#["name"])
  datasets?: DatasetDebugResource[];

  /**
   * List of linked services.
   */
  @identifiers(#["name"])
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataFlowDebugResource extends SubResourceDebugResource {
  /**
   * Data flow properties.
   */
  properties: DataFlow;
}

/**
 * Dataset debug resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatasetDebugResource extends SubResourceDebugResource {
  /**
   * Dataset properties.
   */
  properties: Dataset;
}

/**
 * Linked service debug resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  folderPath?: unknown;
}

/**
 * Data flow debug settings.
 */
model DataFlowDebugPackageDebugSettings {
  /**
   * Source setting for data flow debug.
   */
  @identifiers(#["sourceName"])
  sourceSettings?: DataFlowSourceSetting[];

  /**
   * Data flow parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<unknown>;

  /**
   * Parameters for dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  datasetParameters?: unknown;
}

/**
 * Definition of data flow source setting for debug.
 */
model DataFlowSourceSetting {
  ...Record<unknown>;

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
 * A list of managed Virtual Network resources.
 */
model ManagedVirtualNetworkListResponse
  is Azure.Core.Page<ManagedVirtualNetworkResource>;

/**
 * A managed Virtual Network associated with the Azure Data Factory
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedVirtualNetwork {
  ...Record<unknown>;

  /**
   * Managed Virtual Network ID.
   */
  @visibility(Lifecycle.Read)
  vNetId?: string;

  /**
   * Managed Virtual Network alias.
   */
  @visibility(Lifecycle.Read)
  `alias`?: string;
}

/**
 * A list of managed private endpoint resources.
 */
model ManagedPrivateEndpointListResponse
  is Azure.Core.Page<ManagedPrivateEndpointResource>;

/**
 * Properties of a managed private endpoint
 */
model ManagedPrivateEndpoint {
  ...Record<unknown>;

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
  @visibility(Lifecycle.Read)
  isReserved?: boolean;

  /**
   * The ARM resource ID of the resource to which the managed private endpoint is created
   */
  privateLinkResourceId?: string;

  /**
   * The managed private endpoint provisioning state
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * The connection state of a managed private endpoint
 */
model ConnectionStateProperties {
  /**
   * The actions required on the managed private endpoint
   */
  @visibility(Lifecycle.Read)
  actionsRequired?: string;

  /**
   * The managed private endpoint description
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The approval status
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * A list of credential resources.
 */
model CredentialListResponse is Azure.Core.Page<CredentialResource>;

/**
 * The Azure Data Factory nested object which contains the information and credential which can be used to connect with related store or compute resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("type")
model Credential {
  ...Record<unknown>;

  /**
   * Type of credential.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;

  /**
   * Credential description.
   */
  description?: string;

  /**
   * List of tags that can be used for describing the Credential.
   */
  annotations?: unknown[];
}

/**
 * A list of linked service resources.
 */
model PrivateEndpointConnectionListResponse
  is Azure.Core.Page<PrivateEndpointConnectionResource>;

/**
 * A remote private endpoint connection
 */
model RemotePrivateEndpointConnection {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  value: PrivateLinkResource[];
}

/**
 * A private link resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * RequiredMembers of a private link resource
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * RequiredZoneNames of a private link resource
   */
  @visibility(Lifecycle.Read)
  requiredZoneNames?: string[];
}

/**
 * A list of Global parameters.
 */
model GlobalParameterListResponse is Azure.Core.Page<GlobalParameterResource>;

/**
 * A list of change data capture resources.
 */
model ChangeDataCaptureListResponse
  is Azure.Core.Page<ChangeDataCaptureResource>;

/**
 * A Azure Data Factory object which automatically detects data changes at the source and then sends the updated data to the destination.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @identifiers(#[])
  sourceConnectionsInfo: MapperSourceConnectionsInfo[];

  /**
   * List of target connections that can be used as sources in the CDC.
   */
  @identifiers(#[])
  targetConnectionsInfo: MapperTargetConnectionsInfo[];

  /**
   * CDC policy
   */
  policy: MapperPolicy;

  /**
   * A boolean to determine if the vnet configuration needs to be overwritten.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @identifiers(#["name"])
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
  @identifiers(#["name"])
  schema?: MapperTableSchema[];

  /**
   * List of name/value pairs for connection properties.
   */
  @identifiers(#[])
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: unknown;
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
  @identifiers(#[])
  commonDslConnectorProperties?: MapperDslConnectorProperties[];
}

/**
 * A object which contains list of tables and connection details for a target connection.
 */
model MapperTargetConnectionsInfo {
  /**
   * List of source tables for a target connection.
   */
  @identifiers(#["name"])
  targetEntities?: MapperTable[];

  /**
   * Source connection details.
   */
  connection?: MapperConnection;

  /**
   * List of table mappings.
   */
  @identifiers(#["targetEntityName", "sourceEntityName"])
  dataMapperMappings?: DataMapperMapping[];

  /**
   * List of relationship info among the tables.
   */
  relationships?: unknown[];
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceDenormalizeInfo?: unknown;
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
  @identifiers(#["name"])
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
  @identifiers(#["name"])
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
model SecretBase {
  /**
   * Type of the secret.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;
}

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  secretName: unknown;

  /**
   * The version of the secret in Azure Key Vault. The default value is the latest version of the secret. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  secretVersion?: unknown;

  /**
   * Type of the secret.
   */
  type: "AzureKeyVaultSecret";
}

/**
 * A list of integration runtime status.
 */
model IntegrationRuntimeStatusListResponse
  is Azure.Core.Page<IntegrationRuntimeStatusResponse>;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<unknown>;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<unknown>;
}

/**
 * Response body structure for get data factory operation status.
 */
model GetDataFactoryOperationStatusResponse {
  ...Record<unknown>;

  /**
   * Status of the operation.
   */
  status?: string;
}

/**
 * Data flow reference type.
 */
model DataFlowReference {
  ...Record<unknown>;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  datasetParameters?: unknown;

  /**
   * Data flow parameters
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<unknown>;
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
model CredentialReference {
  ...Record<unknown>;

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
  @identifiers(#["name"])
  sources?: DataFlowSource[];

  /**
   * List of sinks in data flow.
   */
  @identifiers(#["name"])
  sinks?: DataFlowSink[];

  /**
   * List of transformations in data flow.
   */
  @identifiers(#["name"])
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @identifiers(#["name"])
  sources?: DataFlowSource[];

  /**
   * List of sinks in Flowlet.
   */
  @identifiers(#["name"])
  sinks?: DataFlowSink[];

  /**
   * List of transformations in Flowlet.
   */
  @identifiers(#["name"])
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
  @identifiers(#["name"])
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PowerQuerySource extends DataFlowSource {
  /**
   * source script.
   */
  script?: string;
}

/**
 * Power query sink.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
model DatasetLocation {
  ...Record<unknown>;

  /**
   * Type of dataset storage location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;

  /**
   * Specify the folder path of dataset. Type: string (or Expression with resultType string)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  folderPath?: unknown;

  /**
   * Specify the file name of dataset. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileName?: unknown;
}

/**
 * The location of azure blob dataset.
 */
model AzureBlobStorageLocation extends DatasetLocation {
  /**
   * Specify the container of azure blob. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  container?: unknown;

  /**
   * Type of dataset storage location.
   */
  type: "AzureBlobStorageLocation";
}

/**
 * The location of azure blobFS dataset.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureBlobFSLocation extends DatasetLocation {
  /**
   * Specify the fileSystem of azure blobFS. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileSystem?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  bucketName?: unknown;

  /**
   * Specify the version of amazon S3. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  version?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  bucketName?: unknown;

  /**
   * Specify the version of Amazon S3 Compatible. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  version?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  bucketName?: unknown;

  /**
   * Specify the version of Oracle Cloud Storage. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  version?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  bucketName?: unknown;

  /**
   * Specify the version of Google Cloud Storage. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  version?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  relativeUrl?: unknown;

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
 * The location of Microsoft Fabric Lakehouse Files dataset.
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: unknown;

  /**
   * Type of the column. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: unknown;
}

/**
 * Columns that define the physical type schema of the dataset.
 */
model DatasetSchemaDataElement {
  ...Record<unknown>;

  /**
   * Name of the schema column. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: unknown;

  /**
   * Type of the schema column. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: unknown;
}

/**
 * The format definition of a storage.
 */
@discriminator("type")
model DatasetStorageFormat {
  ...Record<unknown>;

  /**
   * Type of dataset storage format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;

  /**
   * Serializer. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serializer?: unknown;

  /**
   * Deserializer. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deserializer?: unknown;
}

/**
 * The data stored in text format.
 */
model TextFormat extends DatasetStorageFormat {
  /**
   * The column delimiter. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  columnDelimiter?: unknown;

  /**
   * The row delimiter. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rowDelimiter?: unknown;

  /**
   * The escape character. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  escapeChar?: unknown;

  /**
   * The quote character. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  quoteChar?: unknown;

  /**
   * The null value string. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  nullValue?: unknown;

  /**
   * The code page name of the preferred encoding. If miss, the default value is ΓÇ£utf-8ΓÇ¥, unless BOM denotes another Unicode encoding. Refer to the ΓÇ£NameΓÇ¥ column of the table in the following link to set supported values: https://msdn.microsoft.com/library/system.text.encoding.aspx. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encodingName?: unknown;

  /**
   * Treat empty column values in the text file as null. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  treatEmptyAsNull?: unknown;

  /**
   * The number of lines/rows to be skipped when parsing text files. The default value is 0. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  skipLineCount?: unknown;

  /**
   * When used as input, treat the first row of data as headers. When used as output,write the headers into the output as the first row of data. The default value is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  firstRowAsHeader?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  filePattern?: unknown;

  /**
   * The character used to separate nesting levels. Default value is '.' (dot). Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  nestingSeparator?: unknown;

  /**
   * The code page name of the preferred encoding. If not provided, the default value is 'utf-8', unless the byte order mark (BOM) denotes another Unicode encoding. The full list of supported values can be found in the 'Name' column of the table of encodings in the following reference: https://go.microsoft.com/fwlink/?linkid=861078. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encodingName?: unknown;

  /**
   * The JSONPath of the JSON array element to be flattened. Example: "$.ArrayPath". Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  jsonNodeReference?: unknown;

  /**
   * The JSONPath definition for each column mapping with a customized column name to extract data from JSON file. For fields under root object, start with "$"; for fields inside the array chosen by jsonNodeReference property, start from the array element. Example: {"Column1": "$.Column1Path", "Column2": "Column2PathInArray"}. Type: object (or Expression with resultType object).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  jsonPathDefinition?: unknown;

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
model DatasetCompression {
  ...Record<unknown>;

  /**
   * Type of dataset compression. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: unknown;

  /**
   * The dataset compression level. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  level?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  bucketName: unknown;

  /**
   * The key of the Amazon S3 object. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  key?: unknown;

  /**
   * The prefix filter for the S3 object name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  prefix?: unknown;

  /**
   * The version for the S3 object. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  version?: unknown;

  /**
   * The start of S3 object's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeStart?: unknown;

  /**
   * The end of S3 object's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeEnd?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  avroCompressionCodec?: unknown;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sheetName?: unknown;

  /**
   * The sheet index of excel file and default value is 0. Type: integer (or Expression with resultType integer)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sheetIndex?: unknown;

  /**
   * The partial data of one sheet. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  range?: unknown;

  /**
   * When used as input, treat the first row of data as headers. When used as output,write the headers into the output as the first row of data. The default value is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  firstRowAsHeader?: unknown;

  /**
   * The data compression method used for the json dataset.
   */
  compression?: DatasetCompression;

  /**
   * The null value string. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  nullValue?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  compressionCodec?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  columnDelimiter?: unknown;

  /**
   * The row delimiter. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rowDelimiter?: unknown;

  /**
   * The code page name of the preferred encoding. If miss, the default value is UTF-8, unless BOM denotes another Unicode encoding. Refer to the name column of the table in the following link to set supported values: https://msdn.microsoft.com/library/system.text.encoding.aspx. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encodingName?: unknown;

  /**
   * The data compressionCodec. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  compressionCodec?: unknown;

  /**
   * The data compression method used for DelimitedText.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  compressionLevel?: unknown;

  /**
   * The quote character. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  quoteChar?: unknown;

  /**
   * The escape character. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  escapeChar?: unknown;

  /**
   * When used as input, treat the first row of data as headers. When used as output,write the headers into the output as the first row of data. The default value is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  firstRowAsHeader?: unknown;

  /**
   * The null value string. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  nullValue?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encodingName?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encodingName?: unknown;

  /**
   * The null value string. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  nullValue?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  orcCompressionCodec?: unknown;
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
 * Iceberg dataset.
 */
model IcebergDataset extends Dataset {
  /**
   * Iceberg dataset properties.
   */
  typeProperties?: IcebergDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "Iceberg";
}

/**
 * Iceberg dataset properties.
 */
model IcebergDatasetTypeProperties {
  /**
   * The location of the iceberg storage. Setting a file name is not allowed for iceberg format.
   */
  location: DatasetLocation;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  folderPath?: unknown;

  /**
   * The root of blob path. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableRootLocation?: unknown;

  /**
   * The name of the Azure Blob. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileName?: unknown;

  /**
   * The start of Azure Blob's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeStart?: unknown;

  /**
   * The end of Azure Blob's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeEnd?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The schema name of the Azure SQL database. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;

  /**
   * The table name of the Azure SQL database. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;
}

/**
 * The Azure SQL Managed Instance dataset.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureSqlMITableDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The schema name of the Azure SQL Managed Instance. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;

  /**
   * The table name of the Azure SQL Managed Instance dataset. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;
}

/**
 * The Azure SQL Data Warehouse dataset.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureSqlDWTableDatasetTypeProperties {
  /**
   * This property will be retired. Please consider using schema + table properties instead.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The schema name of the Azure SQL Data Warehouse. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;

  /**
   * The table name of the Azure SQL Data Warehouse. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The keyspace of the Cassandra database. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keyspace?: unknown;
}

/**
 * The custom dataset.
 */
model CustomDataset extends Dataset {
  /**
   * Custom dataset properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  typeProperties?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  collectionName: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  collectionName: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  entityName?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  entityName?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  entityName?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  folderPath?: unknown;

  /**
   * The name of the file in the Azure Data Lake Store. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileName?: unknown;

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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureBlobFSDatasetTypeProperties {
  /**
   * The path of the Azure Data Lake Storage Gen2 storage. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  folderPath?: unknown;

  /**
   * The name of the Azure Data Lake Storage Gen2. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileName?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName: unknown;

  /**
   * A predicate expression that can be used to filter the specific rows to extract from Office 365. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  predicate?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  folderPath?: unknown;

  /**
   * The name of the on-premises file system. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileName?: unknown;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeStart?: unknown;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeEnd?: unknown;

  /**
   * The format of the files.
   */
  format?: DatasetStorageFormat;

  /**
   * Specify a filter to be used to select a subset of files in the folderPath rather than all files. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileFilter?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  collectionName: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  collection: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  collection: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  collection: unknown;
}

/**
 * The Open Data Protocol (OData) resource dataset.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ODataResourceDatasetTypeProperties {
  /**
   * The OData resource path. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  path?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The schema name of the on-premises Oracle database. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;

  /**
   * The table name of the on-premises Oracle database. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;

  /**
   * The table name of the AmazonRdsForOracle database. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database?: unknown;

  /**
   * The table name of Teradata. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The name of Azure MySQL database table. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The Amazon Redshift table name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;

  /**
   * The Amazon Redshift schema name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The Db2 schema name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;

  /**
   * The Db2 table name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The PostgreSQL table name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;

  /**
   * The PostgreSQL schema name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;
}

/**
 * The PostgreSQLV2 table dataset.
 */
model PostgreSqlV2TableDataset extends Dataset {
  /**
   * PostgreSQLV2 table dataset properties.
   */
  typeProperties?: PostgreSqlV2TableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "PostgreSqlV2Table";
}

/**
 * PostgreSQLV2 table dataset properties.
 */
model PostgreSqlV2TableDatasetTypeProperties {
  /**
   * The PostgreSQL table name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;

  /**
   * The PostgreSQL schema name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectApiName?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectApiName?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  path: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  path: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;

  /**
   * The table name of SAP HANA. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  openHubDestinationName: unknown;

  /**
   * Whether to exclude the records of the last request. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  excludeLastRequest?: unknown;

  /**
   * The ID of request for delta loading. Once it is set, only data with requestId larger than the value of this property will be retrieved. The default value is 0. Type: integer (or Expression with resultType integer ).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  baseRequestId?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The schema name of the SQL Server dataset. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;

  /**
   * The table name of the SQL Server dataset. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;

  /**
   * The table name of the SQL Server dataset. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  relativeUrl?: unknown;

  /**
   * The HTTP method used to call the RESTful API. The default is GET. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requestMethod?: unknown;

  /**
   * The HTTP request body to the RESTful API if requestMethod is POST. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requestBody?: unknown;

  /**
   * The additional HTTP headers in the request to the RESTful API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalHeaders?: Record<unknown>;

  /**
   * The pagination rules to compose next page requests.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  paginationRules?: Record<unknown>;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  context: unknown;

  /**
   * The name of the SAP ODP Object. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectName: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  index: unknown;

  /**
   * The relative URL to the web page from the linked service URL. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  path?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  indexName: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  relativeUrl?: unknown;

  /**
   * The HTTP method for the HTTP request. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requestMethod?: unknown;

  /**
   * The body for the HTTP request. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requestBody?: unknown;

  /**
   * The headers for the HTTP Request. e.g. request-header-name-1:request-header-value-1
   * ...
   * request-header-name-n:request-header-value-n Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalHeaders?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;
}

/**
 * Amazon Marketplace Web Service dataset.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The table name of the Azure PostgreSQL database. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;

  /**
   * The schema name of the Azure PostgreSQL database. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The table name of the Drill. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;

  /**
   * The schema name of the Drill. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The table name of the Google BigQuery. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;

  /**
   * The database name of the Google BigQuery. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataset?: unknown;
}

/**
 * Google BigQuery service dataset.
 */
model GoogleBigQueryV2ObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: GoogleBigQueryV2DatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "GoogleBigQueryV2Object";
}

/**
 * Google BigQuery Dataset Properties
 */
model GoogleBigQueryV2DatasetTypeProperties {
  /**
   * The table name of the Google BigQuery. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;

  /**
   * The database name of the Google BigQuery. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataset?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The table name of Greenplum. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;

  /**
   * The schema name of Greenplum. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;
}

/**
 * HBase server dataset.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The table name of the Hive. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;

  /**
   * The schema name of the Hive. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The table name of the Impala. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;

  /**
   * The schema name of the Impala. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;
}

/**
 * Jira Service dataset.
 */
model JiraObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: JiraTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "JiraObject";
}

/**
 * Jira dataset properties.
 */
model JiraTableDatasetTypeProperties {
  /**
   * This property is only supported in Jira V1 Dataset, please consider upgrading to V2 dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The schema name of the Jira, applies only for Jira V2 dataset. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;

  /**
   * The table name of the Jira, applies only for Jira V2 dataset. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The table name of the Phoenix. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;

  /**
   * The schema name of the Phoenix. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The table name of the Presto. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;

  /**
   * The schema name of the Presto. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The table name of the Spark. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;

  /**
   * The schema name of the Spark. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The table name of the Netezza. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;

  /**
   * The schema name of the Netezza. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * The table name of the Vertica. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;

  /**
   * The schema name of the Vertica. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DynamicsAXResourceDatasetTypeProperties {
  /**
   * The path of the Dynamics AX OData entity. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  path: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;

  /**
   * The table name of the Snowflake database. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;
}

/**
 * The snowflake dataset.
 */
model SnowflakeV2Dataset extends Dataset {
  /**
   * Snowflake dataset properties.
   */
  typeProperties: SnowflakeDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "SnowflakeV2Table";
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listName?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;

  /**
   * The database name of delta table. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database?: unknown;
}

/**
 * Microsoft Fabric Lakehouse Table.
 */
model LakeHouseTableDataset extends Dataset {
  /**
   * Microsoft Fabric Lakehouse Table dataset properties.
   */
  typeProperties?: LakeHouseTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "LakehouseTable";
}

/**
 * Microsoft Fabric Lakehouse Table dataset properties.
 */
model LakeHouseTableDatasetTypeProperties {
  /**
   * The schema name of Microsoft Fabric Lakehouse Table. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;

  /**
   * The name of Microsoft Fabric Lakehouse Table. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;
}

/**
 * The Salesforce V2 object dataset.
 */
model SalesforceV2ObjectDataset extends Dataset {
  /**
   * Salesforce V2 object dataset properties.
   */
  typeProperties?: SalesforceV2ObjectDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "SalesforceV2Object";
}

/**
 * Salesforce V2 object dataset properties.
 */
model SalesforceV2ObjectDatasetTypeProperties {
  /**
   * The Salesforce V2 object API name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectApiName?: unknown;

  /**
   * The Salesforce V2 report Id. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  reportId?: unknown;
}

/**
 * The Salesforce Service Cloud V2 object dataset.
 */
model SalesforceServiceCloudV2ObjectDataset extends Dataset {
  /**
   * Salesforce Service Cloud V2 object dataset properties.
   */
  typeProperties?: SalesforceServiceCloudV2ObjectDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "SalesforceServiceCloudV2Object";
}

/**
 * Salesforce Service Cloud V2 object dataset properties.
 */
model SalesforceServiceCloudV2ObjectDatasetTypeProperties {
  /**
   * The Salesforce Service Cloud V2 object API name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectApiName?: unknown;

  /**
   * The Salesforce Service Cloud V2 reportId. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  reportId?: unknown;
}

/**
 * Microsoft Fabric Warehouse dataset.
 */
model WarehouseTableDataset extends Dataset {
  /**
   * Microsoft Fabric Warehouse dataset properties.
   */
  typeProperties?: WarehouseTableDatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "WarehouseTable";
}

/**
 * Microsoft Fabric Warehouse dataset properties.
 */
model WarehouseTableDatasetTypeProperties {
  /**
   * The schema name of the Microsoft Fabric Warehouse. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;

  /**
   * The table name of the Microsoft Fabric Warehouse. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table?: unknown;
}

/**
 * ServiceNowV2 server dataset.
 */
model ServiceNowV2ObjectDataset extends Dataset {
  /**
   * Properties specific to this dataset type.
   */
  typeProperties?: ServiceNowV2DatasetTypeProperties;

  /**
   * Type of dataset.
   */
  type: "ServiceNowV2Object";
}

/**
 * Properties specific to this dataset type.
 */
model ServiceNowV2DatasetTypeProperties {
  /**
   * The table name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName?: unknown;

  /**
   * Type of value copied from source.
   */
  valueType?: ValueType;
}

/**
 * Managed integration runtime, including managed elastic and managed dedicated integration runtimes.
 */
model ManagedIntegrationRuntime extends IntegrationRuntime {
  /**
   * Integration runtime state, only valid for managed dedicated integration runtime.
   */
  @visibility(Lifecycle.Read)
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

  /**
   * Interactive authoring capability reference.
   */
  interactiveQuery?: InteractiveQueryProperties;
}

/**
 * The compute resource properties for managed integration runtime.
 */
model IntegrationRuntimeComputeProperties {
  ...Record<unknown>;

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
model IntegrationRuntimeDataFlowProperties {
  ...Record<unknown>;

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
  @identifiers(#[])
  customProperties?: IntegrationRuntimeDataFlowPropertiesCustomPropertiesItem[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IntegrationRuntimeVNetProperties {
  ...Record<unknown>;

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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicIPs?: string[];

  /**
   * The ID of subnet, to which this Azure-SSIS integration runtime will be joined.
   */
  subnetId?: string;
}

/**
 * CopyComputeScale properties for managed integration runtime.
 */
model CopyComputeScaleProperties {
  ...Record<unknown>;

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
model PipelineExternalComputeScaleProperties {
  ...Record<unknown>;

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
model IntegrationRuntimeSsisProperties {
  ...Record<unknown>;

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
  @identifiers(#[])
  expressCustomSetupProperties?: CustomSetupBase[];

  /**
   * Package stores for the SSIS Integration Runtime.
   */
  @identifiers(#["name"])
  packageStores?: PackageStore[];

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * Catalog information for managed dedicated integration runtime.
 */
model IntegrationRuntimeSsisCatalogInfo {
  ...Record<unknown>;

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
model CustomSetupBase {
  /**
   * The type of custom setup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;
}

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
 * Interactive authoring capability type properties.
 */
model InteractiveQueryProperties {
  /**
   * The interactive authoring capability status. Must be one of InteractiveCapabilityStatus. The default value is 'Enabling'.
   */
  @visibility(Lifecycle.Read)
  status?: InteractiveCapabilityStatus;

  /**
   * The allowed idle time for interactive authoring.
   */
  @visibility(Lifecycle.Read)
  autoTerminationMinutes?: int32;
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
   * The server name of data source access. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetName: unknown;

  /**
   * The user name of data source access. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName: unknown;

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
model LinkedIntegrationRuntimeType {
  /**
   * The authorization type for integration runtime sharing.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authorizationType: string;
}

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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  /**
   * The list of nodes for managed integration runtime.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["nodeId"])
  nodes?: ManagedIntegrationRuntimeNode[];

  /**
   * The errors that occurred on this integration runtime.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  otherErrors?: ManagedIntegrationRuntimeError[];

  /**
   * The last operation result that occurred on this integration runtime.
   */
  @visibility(Lifecycle.Read)
  lastOperation?: ManagedIntegrationRuntimeOperationResult;
}

/**
 * Properties of integration runtime node.
 */
model ManagedIntegrationRuntimeNode {
  ...Record<unknown>;

  /**
   * The managed integration runtime node id.
   */
  @visibility(Lifecycle.Read)
  nodeId?: string;

  /**
   * The managed integration runtime node status.
   */
  @visibility(Lifecycle.Read)
  status?: ManagedIntegrationRuntimeNodeStatus;

  /**
   * The errors that occurred on this integration runtime node.
   */
  @identifiers(#[])
  errors?: ManagedIntegrationRuntimeError[];
}

/**
 * Error definition for managed integration runtime.
 */
model ManagedIntegrationRuntimeError {
  ...Record<unknown>;

  /**
   * The time when the error occurred.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Managed integration runtime error parameters.
   */
  @visibility(Lifecycle.Read)
  parameters?: string[];

  /**
   * Error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Properties of managed integration runtime operation result.
 */
model ManagedIntegrationRuntimeOperationResult {
  ...Record<unknown>;

  /**
   * The operation type. Could be start or stop.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The start time of the operation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The operation result.
   */
  @visibility(Lifecycle.Read)
  result?: string;

  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /**
   * Managed integration runtime error parameters.
   */
  @visibility(Lifecycle.Read)
  parameters?: string[];

  /**
   * The activity id for the operation request.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  /**
   * The task queue id of the integration runtime.
   */
  @visibility(Lifecycle.Read)
  taskQueueId?: string;

  /**
   * It is used to set the encryption mode for node-node communication channel (when more than 2 self-hosted integration runtime nodes exist).
   */
  @visibility(Lifecycle.Read)
  internalChannelEncryption?: IntegrationRuntimeInternalChannelEncryptionMode;

  /**
   * Version of the integration runtime.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The list of nodes for this integration runtime.
   */
  @identifiers(#["nodeName"])
  nodes?: SelfHostedIntegrationRuntimeNode[];

  /**
   * The date at which the integration runtime will be scheduled to update, in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledUpdateDate?: utcDateTime;

  /**
   * The time in the date scheduled by service to update the integration runtime, e.g., PT03H is 3 hours
   */
  @visibility(Lifecycle.Read)
  updateDelayOffset?: string;

  /**
   * The local time zone offset in hours.
   */
  @visibility(Lifecycle.Read)
  localTimeZoneOffset?: string;

  /**
   * Object with additional information about integration runtime capabilities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  capabilities?: Record<string>;

  /**
   * The URLs for the services used in integration runtime backend service.
   */
  @visibility(Lifecycle.Read)
  serviceUrls?: string[];

  /**
   * Whether Self-hosted integration runtime auto update has been turned on.
   */
  @visibility(Lifecycle.Read)
  autoUpdate?: IntegrationRuntimeAutoUpdate;

  /**
   * Status of the integration runtime version.
   */
  @visibility(Lifecycle.Read)
  versionStatus?: string;

  /**
   * The list of linked integration runtimes that are created to share with this integration runtime.
   */
  @identifiers(#["name"])
  links?: LinkedIntegrationRuntime[];

  /**
   * The version that the integration runtime is going to update to.
   */
  @visibility(Lifecycle.Read)
  pushedVersion?: string;

  /**
   * The latest version on download center.
   */
  @visibility(Lifecycle.Read)
  latestVersion?: string;

  /**
   * The estimated time when the self-hosted integration runtime will be updated.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  autoUpdateETA?: utcDateTime;

  /**
   * An alternative option to ensure interactive authoring function when your self-hosted integration runtime is unable to establish a connection with Azure Relay.
   */
  @visibility(Lifecycle.Read)
  selfContainedInteractiveAuthoringEnabled?: boolean;
}

/**
 * The linked integration runtime information.
 */
model LinkedIntegrationRuntime {
  /**
   * The name of the linked integration runtime.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The subscription ID for which the linked integration runtime belong to.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * The name of the data factory for which the linked integration runtime belong to.
   */
  @visibility(Lifecycle.Read)
  dataFactoryName?: string;

  /**
   * The location of the data factory for which the linked integration runtime belong to.
   */
  @visibility(Lifecycle.Read)
  dataFactoryLocation?: string;

  /**
   * The creating time of the linked integration runtime.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * The Azure key vault secret reference of accountKey in connection string.
   */
  accountKey?: AzureKeyVaultSecretReference;

  /**
   * SAS URI of the Azure Storage resource. It is mutually exclusive with connectionString property. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sasUri?: unknown;

  /**
   * The Azure key vault secret reference of sasToken in sas uri.
   */
  sasToken?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * The Azure key vault secret reference of accountKey in connection string.
   */
  accountKey?: AzureKeyVaultSecretReference;

  /**
   * SAS URI of the Azure Blob Storage resource. It is mutually exclusive with connectionString, serviceEndpoint property. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sasUri?: unknown;

  /**
   * The Azure key vault secret reference of sasToken in sas uri.
   */
  sasToken?: AzureKeyVaultSecretReference;

  /**
   * Blob service endpoint of the Azure Blob Storage resource. It is mutually exclusive with connectionString, sasUri property.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceEndpoint?: unknown;

  /**
   * The ID of the service principal used to authenticate against Azure SQL Data Warehouse. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The key of the service principal used to authenticate against Azure SQL Data Warehouse.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant?: unknown;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureCloudType?: unknown;

  /**
   * Specify the kind of your storage account. Allowed values are: Storage (general purpose v1), StorageV2 (general purpose v2), BlobStorage, or BlockBlobStorage. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accountKind?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  containerUri?: unknown;
}

/**
 * The azure table storage linked service.
 */
model AzureTableStorageLinkedService extends LinkedService {
  /**
   * Azure Table Storage linked service properties.
   */
  typeProperties: AzureTableStorageLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "AzureTableStorage";
}

/**
 * Azure Table Storage linked service properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureTableStorageLinkedServiceTypeProperties
  extends AzureStorageLinkedServiceTypeProperties {
  /**
   * Table service endpoint of the Azure Table Storage resource. It is mutually exclusive with connectionString, sasUri property.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceEndpoint?: unknown;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * Sql Server family connector common linked service properties.
 */
model SqlServerBaseLinkedServiceTypeProperties {
  /**
   * The name or network address of the instance of SQL Server to which to connect, used by recommended version. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server?: unknown;

  /**
   * The name of the database, used by recommended version. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database?: unknown;

  /**
   * Indicate whether TLS encryption is required for all data sent between the client and server, used by recommended version. Possible values are true/yes/mandatory, false/no/optional and strict. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encrypt?: unknown;

  /**
   * Indicate whether the channel will be encrypted while bypassing walking the certificate chain to validate trust, used by recommended version. Type: Boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  trustServerCertificate?: unknown;

  /**
   * The host name to use when validating the server certificate for the connection. When not specified, the server name from the Data Source is used for certificate validation, used by recommended version. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hostNameInCertificate?: unknown;

  /**
   * The application workload type when connecting to a server, used by recommended version. Possible values are ReadOnly and ReadWrite. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  applicationIntent?: unknown;

  /**
   * The length of time (in seconds) to wait for a connection to the server before terminating the attempt and generating an error, used by recommended version. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectTimeout?: unknown;

  /**
   * The number of re-connections attempted after identifying that there was an idle connection failure, used by recommended version. This must be an integer between 0 and 255. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectRetryCount?: unknown;

  /**
   * The amount of time (in seconds) between each re-connection attempt after identifying that there was an idle connection failure, used by recommended version. This must be an integer between 1 and 60. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectRetryInterval?: unknown;

  /**
   * The minimum time, in seconds, for the connection to live in the connection pool before being destroyed, used by recommended version. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  loadBalanceTimeout?: unknown;

  /**
   * The default wait time (in seconds) before terminating the attempt to execute a command and generating an error, used by recommended version. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  commandTimeout?: unknown;

  /**
   * Indicate whether User ID and Password are specified in the connection (when false) or whether the current Windows account credentials are used for authentication (when true), used by recommended version. Type: Boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  integratedSecurity?: unknown;

  /**
   * The name or address of the partner server to connect to if the primary server is down, used by recommended version. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  failoverPartner?: unknown;

  /**
   * The maximum number of connections allowed in the connection pool for this specific connection string, used by recommended version. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxPoolSize?: unknown;

  /**
   * The minimum number of connections allowed in the connection pool for this specific connection string, used by recommended version. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  minPoolSize?: unknown;

  /**
   * When true, an application can maintain multiple active result sets (MARS). When false, an application must process or cancel all result sets from one batch before it can execute any other batch on that connection, used by recommended version. Type: Boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  multipleActiveResultSets?: unknown;

  /**
   * If your application is connecting to an AlwaysOn availability group (AG) on different subnets, setting MultiSubnetFailover=true provides faster detection of and connection to the (currently) active server, used by recommended version. Type: Boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  multiSubnetFailover?: unknown;

  /**
   * The size in bytes of the network packets used to communicate with an instance of server, used by recommended version. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  packetSize?: unknown;

  /**
   * Indicate whether the connection will be pooled or explicitly opened every time that the connection is requested, used by recommended version. Type: Boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  pooling?: unknown;
}

/**
 * Azure SQL Data Warehouse linked service.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureSqlDWLinkedServiceTypeProperties
  extends SqlServerBaseLinkedServiceTypeProperties {
  /**
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * The type used for authentication. Type: string.
   */
  authenticationType?: AzureSqlDWAuthenticationType;

  /**
   * The user name to be used when connecting to server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The ID of the service principal used to authenticate against Azure SQL Data Warehouse. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The key of the service principal used to authenticate against Azure SQL Data Warehouse.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalCredentialType?: unknown;

  /**
   * The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.
   */
  servicePrincipalCredential?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant?: unknown;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureCloudType?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlServerLinkedServiceTypeProperties
  extends SqlServerBaseLinkedServiceTypeProperties {
  /**
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * The type used for authentication. Type: string.
   */
  authenticationType?: SqlServerAuthenticationType;

  /**
   * The on-premises Windows authentication user name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * The on-premises Windows authentication password.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AmazonRdsForSqlServerLinkedServiceTypeProperties
  extends SqlServerBaseLinkedServiceTypeProperties {
  /**
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * The type used for authentication. Type: string.
   */
  authenticationType?: AmazonRdsForSqlAuthenticationType;

  /**
   * The on-premises Windows authentication user name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * The on-premises Windows authentication password.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureSqlDatabaseLinkedServiceTypeProperties
  extends SqlServerBaseLinkedServiceTypeProperties {
  /**
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * The type used for authentication. Type: string.
   */
  authenticationType?: AzureSqlDatabaseAuthenticationType;

  /**
   * The user name to be used when connecting to server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The ID of the service principal used to authenticate against Azure SQL Database. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The key of the service principal used to authenticate against Azure SQL Database.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalCredentialType?: unknown;

  /**
   * The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.
   */
  servicePrincipalCredential?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant?: unknown;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureCloudType?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureSqlMILinkedServiceTypeProperties
  extends SqlServerBaseLinkedServiceTypeProperties {
  /**
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * The type used for authentication. Type: string.
   */
  authenticationType?: AzureSqlMIAuthenticationType;

  /**
   * The user name to be used when connecting to server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The ID of the service principal used to authenticate against Azure SQL Managed Instance. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The key of the service principal used to authenticate against Azure SQL Managed Instance.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalCredentialType?: unknown;

  /**
   * The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.
   */
  servicePrincipalCredential?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant?: unknown;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureCloudType?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accountName: unknown;

  /**
   * The Azure Batch account access key.
   */
  accessKey?: SecretBase;

  /**
   * The Azure Batch URI. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  batchUri: unknown;

  /**
   * The Azure Batch pool name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  poolName: unknown;

  /**
   * The Azure Storage linked service reference.
   */
  linkedServiceName: LinkedServiceReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  baseUrl: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * The endpoint of the Azure CosmosDB account. Type: string (or Expression with resultType string)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accountEndpoint?: unknown;

  /**
   * The name of the database. Type: string (or Expression with resultType string)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database?: unknown;

  /**
   * The account key of the Azure CosmosDB account. Type: SecureString or AzureKeyVaultSecretReference.
   */
  accountKey?: SecretBase;

  /**
   * The client ID of the application in Azure Active Directory used for Server-To-Server authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalCredentialType?: unknown;

  /**
   * The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.
   */
  servicePrincipalCredential?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant?: unknown;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureCloudType?: unknown;

  /**
   * The connection mode used to access CosmosDB account. Type: string.
   */
  connectionMode?: CosmosDbConnectionMode;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deploymentType: unknown;

  /**
   * The host name of the on-premises Dynamics server. The property is required for on-prem and not allowed for online. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hostName?: unknown;

  /**
   * The port of on-premises Dynamics server. The property is required for on-prem and not allowed for online. Default is 443. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * The URL to the Microsoft Dynamics server. The property is required for on-line and not allowed for on-prem. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceUri?: unknown;

  /**
   * The organization name of the Dynamics instance. The property is required for on-prem and required for online when there are more than one Dynamics instances associated with the user. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  organizationName?: unknown;

  /**
   * The authentication type to connect to Dynamics server. 'Office365' for online scenario, 'Ifd' for on-premises with Ifd scenario, 'AADServicePrincipal' for Server-To-Server authentication in online scenario, 'Active Directory' for Dynamics on-premises with IFD. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authenticationType: unknown;

  /**
   * The Active Directory domain that will verify user credentials. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  domain?: unknown;

  /**
   * User name to access the Dynamics instance. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * Password to access the Dynamics instance.
   */
  password?: SecretBase;

  /**
   * The client ID of the application in Azure Active Directory used for Server-To-Server authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalCredentialType?: unknown;

  /**
   * The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.
   */
  servicePrincipalCredential?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deploymentType: unknown;

  /**
   * The host name of the on-premises Dynamics CRM server. The property is required for on-prem and not allowed for online. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hostName?: unknown;

  /**
   * The port of on-premises Dynamics CRM server. The property is required for on-prem and not allowed for online. Default is 443. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * The URL to the Microsoft Dynamics CRM server. The property is required for on-line and not allowed for on-prem. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceUri?: unknown;

  /**
   * The organization name of the Dynamics CRM instance. The property is required for on-prem and required for online when there are more than one Dynamics CRM instances associated with the user. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  organizationName?: unknown;

  /**
   * The authentication type to connect to Dynamics CRM server. 'Office365' for online scenario, 'Ifd' for on-premises with Ifd scenario, 'AADServicePrincipal' for Server-To-Server authentication in online scenario, 'Active Directory' for Dynamics on-premises with IFD. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authenticationType: unknown;

  /**
   * The Active Directory domain that will verify user credentials. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  domain?: unknown;

  /**
   * User name to access the Dynamics CRM instance. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * Password to access the Dynamics CRM instance.
   */
  password?: SecretBase;

  /**
   * The client ID of the application in Azure Active Directory used for Server-To-Server authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalCredentialType?: unknown;

  /**
   * The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.
   */
  servicePrincipalCredential?: SecretBase;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deploymentType: unknown;

  /**
   * The host name of the on-premises Common Data Service for Apps server. The property is required for on-prem and not allowed for online. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hostName?: unknown;

  /**
   * The port of on-premises Common Data Service for Apps server. The property is required for on-prem and not allowed for online. Default is 443. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * The URL to the Microsoft Common Data Service for Apps server. The property is required for on-line and not allowed for on-prem. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceUri?: unknown;

  /**
   * The organization name of the Common Data Service for Apps instance. The property is required for on-prem and required for online when there are more than one Common Data Service for Apps instances associated with the user. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  organizationName?: unknown;

  /**
   * The authentication type to connect to Common Data Service for Apps server. 'Office365' for online scenario, 'Ifd' for on-premises with Ifd scenario. 'AADServicePrincipal' for Server-To-Server authentication in online scenario, 'Active Directory' for Dynamics on-premises with IFD. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authenticationType: unknown;

  /**
   * The Active Directory domain that will verify user credentials. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  domain?: unknown;

  /**
   * User name to access the Common Data Service for Apps instance. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * Password to access the Common Data Service for Apps instance.
   */
  password?: SecretBase;

  /**
   * The client ID of the application in Azure Active Directory used for Server-To-Server authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalCredentialType?: unknown;

  /**
   * The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.
   */
  servicePrincipalCredential?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;
}

/**
 * HDInsight linked service.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HDInsightLinkedServiceTypeProperties {
  /**
   * HDInsight cluster URI. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clusterUri: unknown;

  /**
   * HDInsight cluster authentication type.
   */
  clusterAuthType?: HDInsightClusterAuthenticationType;

  /**
   * HDInsight cluster user name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * Specify if the HDInsight is created with ESP (Enterprise Security Package). Type: Boolean.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isEspEnabled?: unknown;

  /**
   * Specify the FileSystem if the main storage for the HDInsight is ADLS Gen2. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileSystem?: unknown;

  /**
   * The credential reference containing MI authentication information for the HDInsight cluster.
   */
  credential?: CredentialReference;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host: unknown;

  /**
   * User ID to logon the server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userId?: unknown;

  /**
   * Password to logon the server.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host?: unknown;

  /**
   * User ID to logon the server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userId?: unknown;

  /**
   * Password to logon the server.
   */
  password?: SecretBase;

  /**
   * The connection string. It is mutually exclusive with sasUri property. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * The Azure key vault secret reference of accountKey in connection string.
   */
  accountKey?: AzureKeyVaultSecretReference;

  /**
   * SAS URI of the Azure File resource. It is mutually exclusive with connectionString property. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sasUri?: unknown;

  /**
   * The Azure key vault secret reference of sasToken in sas uri.
   */
  sasToken?: AzureKeyVaultSecretReference;

  /**
   * The azure file share name. It is required when auth with accountKey/sasToken. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileShare?: unknown;

  /**
   * The azure file share snapshot version. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  snapshot?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * File service endpoint of the Azure File Storage resource. It is mutually exclusive with connectionString, sasUri property.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceEndpoint?: unknown;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accessKeyId?: unknown;

  /**
   * The secret access key of the Amazon S3 Compatible Identity and Access Management (IAM) user.
   */
  secretAccessKey?: SecretBase;

  /**
   * This value specifies the endpoint to access with the Amazon S3 Compatible Connector. This is an optional property; change it only if you want to try a different service endpoint or want to switch between https and http. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceUrl?: unknown;

  /**
   * If true, use S3 path-style access instead of virtual hosted-style access. Default value is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  forcePathStyle?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accessKeyId?: unknown;

  /**
   * The secret access key of the Oracle Cloud Storage Identity and Access Management (IAM) user.
   */
  secretAccessKey?: SecretBase;

  /**
   * This value specifies the endpoint to access with the Oracle Cloud Storage Connector. This is an optional property; change it only if you want to try a different service endpoint or want to switch between https and http. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceUrl?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accessKeyId?: unknown;

  /**
   * The secret access key of the Google Cloud Storage Identity and Access Management (IAM) user.
   */
  secretAccessKey?: SecretBase;

  /**
   * This value specifies the endpoint to access with the Google Cloud Storage Connector. This is an optional property; change it only if you want to try a different service endpoint or want to switch between https and http. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceUrl?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;
}

/**
 * Oracle database. This linked service has supported version property. The Version 1.0 is scheduled for deprecation while your pipeline will continue to run after EOL but without any bug fix or new features.
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
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference. Only used for Version 1.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * The location of Oracle database you want to connect to, the supported forms include connector descriptor, Easy Connect (Plus) Naming and Oracle Net Services Name (Only self-hosted IR). Type: string. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server?: unknown;

  /**
   * Authentication type for connecting to the Oracle database. Only used for Version 2.0.
   */
  authenticationType?: OracleAuthenticationType;

  /**
   * The Oracle database username. Type: string. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * Specifies the encryption client behavior. Supported values are accepted, rejected, requested or required, default value is required. Type: string. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptionClient?: unknown;

  /**
   * Specifies the encryption algorithms that client can use. Supported values are AES128, AES192, AES256, 3DES112, 3DES168, default value is (AES256). Type: string. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptionTypesClient?: unknown;

  /**
   * Specifies the desired data integrity behavior when this client connects to a server. Supported values are accepted, rejected, requested or required, default value is required. Type: string. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  cryptoChecksumClient?: unknown;

  /**
   * Specifies the crypto-checksum algorithms that client can use. Supported values are SHA1, SHA256, SHA384, SHA512, default value is (SHA512). Type: string. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  cryptoChecksumTypesClient?: unknown;

  /**
   * Specifies the amount that the source initially fetches for LOB columns, default value is 0. Type: integer. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  initialLobFetchSize?: unknown;

  /**
   * Specifies the number of bytes that the driver allocates to fetch the data in one database round-trip, default value is 10485760. Type: integer. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fetchSize?: unknown;

  /**
   * Specifies the number of cursors or statements to be cached for each database connection, default value is 0. Type: integer. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  statementCacheSize?: unknown;

  /**
   * Specifies a command that is issued immediately after connecting to the database to manage session settings. Type: string. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  initializationString?: unknown;

  /**
   * Specifies whether to use bulk copy or batch insert when loading data into the database, default value is true. Type: boolean. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableBulkLoad?: unknown;

  /**
   * Specifies whether to use the Version 1.0 data type mappings. Do not set this to true unless you want to keep backward compatibility with Version 1.0's data type mappings, default value is false. Type: boolean. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  supportV1DataTypes?: unknown;

  /**
   * Specifies whether the driver returns column value with the TIMESTAMP WITH TIME ZONE data type as DateTime or string. This setting is ignored if supportV1DataTypes is not true, default value is true. Type: boolean. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fetchTswtzAsTimestamp?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;
}

/**
 * AmazonRdsForOracle database. This linked service has supported version property. The Version 1.0 is scheduled for deprecation while your pipeline will continue to run after EOL but without any bug fix or new features.
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
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference. Only used for Version 1.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * The location of AmazonRdsForOracle database you want to connect to, the supported forms include connector descriptor, Easy Connect (Plus) Naming and Oracle Net Services Name (Only self-hosted IR). Type: string. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server?: unknown;

  /**
   * Authentication type for connecting to the AmazonRdsForOracle database. Only used for Version 2.0.
   */
  authenticationType?: AmazonRdsForOracleAuthenticationType;

  /**
   * The AmazonRdsForOracle database username. Type: string. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: SecretBase;

  /**
   * Specifies the encryption client behavior. Supported values are accepted, rejected, requested or required, default value is required. Type: string. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptionClient?: unknown;

  /**
   * Specifies the encryption algorithms that client can use. Supported values are AES128, AES192, AES256, 3DES112, 3DES168, default value is (AES256). Type: string. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptionTypesClient?: unknown;

  /**
   * Specifies the desired data integrity behavior when this client connects to a server. Supported values are accepted, rejected, requested or required, default value is required. Type: string. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  cryptoChecksumClient?: unknown;

  /**
   * Specifies the crypto-checksum algorithms that client can use. Supported values are SHA1, SHA256, SHA384, SHA512, default value is (SHA512). Type: string. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  cryptoChecksumTypesClient?: unknown;

  /**
   * Specifies the amount that the source initially fetches for LOB columns, default value is 0. Type: integer. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  initialLobFetchSize?: unknown;

  /**
   * Specifies the number of bytes that the driver allocates to fetch the data in one database round-trip, default value is 10485760. Type: integer. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fetchSize?: unknown;

  /**
   * Specifies the number of cursors or statements to be cached for each database connection, default value is 0. Type: integer. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  statementCacheSize?: unknown;

  /**
   * Specifies a command that is issued immediately after connecting to the database to manage session settings. Type: string. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  initializationString?: unknown;

  /**
   * Specifies whether to use bulk copy or batch insert when loading data into the database, default value is true. Type: boolean. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableBulkLoad?: unknown;

  /**
   * Specifies whether to use the Version 1.0 data type mappings. Do not set this to true unless you want to keep backward compatibility with Version 1.0's data type mappings, default value is false. Type: boolean. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  supportV1DataTypes?: unknown;

  /**
   * Specifies whether the driver returns column value with the TIMESTAMP WITH TIME ZONE data type as DateTime or string. This setting is ignored if supportV1DataTypes is not true, default value is true. Type: boolean. Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fetchTswtzAsTimestamp?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString: unknown;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
   * The version of the MySQL driver. Type: string. V1 or empty for legacy driver, V2 for new driver. V1 can support connection string and property bag, V2 can only support connection string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  driverVersion?: unknown;

  /**
   * The connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * Server name for connection. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server?: unknown;

  /**
   * The port for the connection. Type: integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * Username for authentication. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * Database name for connection. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database?: unknown;

  /**
   * SSL mode for connection. Type: integer. 0: disable, 1: prefer, 2: require, 3: verify-ca, 4: verify-full.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sslMode?: unknown;

  /**
   * Use system trust store for connection. Type: integer. 0: enable, 1: disable.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useSystemTrustStore?: unknown;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * This allows the special “zero” date value 0000-00-00 to be retrieved from the database. Type: boolean.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowZeroDateTime?: unknown;

  /**
   * The length of time (in seconds) to wait for a connection to the server before terminating the attempt and generating an error. Type: integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionTimeout?: unknown;

  /**
   * True to return DateTime.MinValue for date or datetime columns that have disallowed values. Type: boolean.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  convertZeroDateTime?: unknown;

  /**
   * Determines which column type (if any) should be read as a GUID. Type: string. None: No column types are automatically read as a Guid; Char36: All CHAR(36) columns are read/written as a Guid using lowercase hex with hyphens, which matches UUID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  guidFormat?: unknown;

  /**
   * The path to the client’s SSL certificate file in PEM format. SslKey must also be specified. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sslCert?: unknown;

  /**
   * The path to the client’s SSL private key in PEM format. SslCert must also be specified. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sslKey?: unknown;

  /**
   * When set to true, TINYINT(1) values are returned as booleans. Type: bool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  treatTinyAsBoolean?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString: unknown;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;
}

/**
 * Linked service for PostgreSQLV2 data source.
 */
model PostgreSqlV2LinkedService extends LinkedService {
  /**
   * PostgreSQLV2 linked service properties.
   */
  typeProperties: PostgreSqlV2LinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "PostgreSqlV2";
}

/**
 * PostgreSqlV2 linked service properties.
 */
model PostgreSqlV2LinkedServiceTypeProperties {
  /**
   * Server name for connection. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server: unknown;

  /**
   * The port for the connection. Type: integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * Username for authentication. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username: unknown;

  /**
   * Database name for connection. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database: unknown;

  /**
   * The authentication type to use. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authenticationType: unknown;

  /**
   * SSL mode for connection. Type: integer. 0: disable, 1:allow, 2: prefer, 3: require, 4: verify-ca, 5: verify-full. Type: integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sslMode: unknown;

  /**
   * Sets the schema search path. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;

  /**
   * Whether connection pooling should be used. Type: boolean.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  pooling?: unknown;

  /**
   * The time to wait (in seconds) while trying to establish a connection before terminating the attempt and generating an error. Type: integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionTimeout?: unknown;

  /**
   * The time to wait (in seconds) while trying to execute a command before terminating the attempt and generating an error. Set to zero for infinity. Type: integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  commandTimeout?: unknown;

  /**
   * Whether to trust the server certificate without validating it. Type: boolean.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  trustServerCertificate?: unknown;

  /**
   * Location of a client certificate to be sent to the server. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sslCertificate?: unknown;

  /**
   * Location of a client key for a client certificate to be sent to the server. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sslKey?: unknown;

  /**
   * Password for a key for a client certificate. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sslPassword?: unknown;

  /**
   * Determines the size of the internal buffer uses when reading. Increasing may improve performance if transferring large values from the database. Type: integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  readBufferSize?: unknown;

  /**
   * When enabled, parameter values are logged when commands are executed. Type: boolean.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  logParameters?: unknown;

  /**
   * Gets or sets the session timezone. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timezone?: unknown;

  /**
   * Gets or sets the .NET encoding that will be used to encode/decode PostgreSQL string data. Type: string
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encoding?: unknown;

  /**
   * The Azure key vault secret reference of password in connection string. Type: string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server: unknown;

  /**
   * Database name for connection. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database: unknown;

  /**
   * Schema name for connection. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;

  /**
   * AuthenticationType to be used for connection.
   */
  authenticationType?: SybaseAuthenticationType;

  /**
   * Username for authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * Password for authentication.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * Server name for connection. It is mutually exclusive with connectionString property. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server?: unknown;

  /**
   * Database name for connection. It is mutually exclusive with connectionString property. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database?: unknown;

  /**
   * AuthenticationType to be used for connection. It is mutually exclusive with connectionString property.
   */
  authenticationType?: Db2AuthenticationType;

  /**
   * Username for authentication. It is mutually exclusive with connectionString property. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * Password for authentication.
   */
  password?: SecretBase;

  /**
   * Under where packages are created when querying database. It is mutually exclusive with connectionString property. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  packageCollection?: unknown;

  /**
   * Certificate Common Name when TLS is enabled. It is mutually exclusive with connectionString property. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  certificateCommonName?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. It is mutually exclusive with connectionString property. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
   * Teradata ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference. Only applied for version 1.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * Server name for connection. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server?: unknown;

  /**
   * AuthenticationType to be used for connection.
   */
  authenticationType?: TeradataAuthenticationType;

  /**
   * Username for authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * Password for authentication.
   */
  password?: SecretBase;

  /**
   * SSL mode for connection. Valid values including: “Disable”, “Allow”, “Prefer”, “Require”, “Verify-CA”, “Verify-Full”. Default value is “Verify-Full”. Type: string (or Expression with resultType string). Only applied for version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sslMode?: unknown;

  /**
   * The port numbers when connecting to server through non HTTPS/TLS connections. Type: integer (or Expression with resultType integer). Only used for V2. Only applied for version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  portNumber?: unknown;

  /**
   * The port numbers when connecting to server through HTTPS/TLS connections. Type: integer (or Expression with resultType integer). Only applied for version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpsPortNumber?: unknown;

  /**
   * Specifies whether to encrypt all communication with the Teradata database. Allowed values are 0 or 1. This setting will be ignored for HTTPS/TLS connections. Type: integer (or Expression with resultType integer). Only applied for version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useDataEncryption?: unknown;

  /**
   * The character set to use for the connection. Type: string (or Expression with resultType string). Only applied for version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  characterSet?: unknown;

  /**
   * The maximum size of the response buffer for SQL requests, in bytes. Type: integer. Only applied for version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxRespSize?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;
}

/**
 * Azure ML Studio Web Service linked service.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureMLLinkedServiceTypeProperties {
  /**
   * The Batch Execution REST URL for an Azure ML Studio Web Service endpoint. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  mlEndpoint: unknown;

  /**
   * The API key for accessing the Azure ML model endpoint.
   */
  apiKey: SecretBase;

  /**
   * The Update Resource REST URL for an Azure ML Studio Web Service endpoint. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updateResourceEndpoint?: unknown;

  /**
   * The ID of the service principal used to authenticate against the ARM-based updateResourceEndpoint of an Azure ML Studio web service. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The key of the service principal used to authenticate against the ARM-based updateResourceEndpoint of an Azure ML Studio web service.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * Type of authentication (Required to specify MSI) used to connect to AzureML. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authentication?: unknown;
}

/**
 * Azure ML Service linked service.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureMLServiceLinkedServiceTypeProperties {
  /**
   * Azure ML Service workspace subscription ID. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: unknown;

  /**
   * Azure ML Service workspace resource group name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: unknown;

  /**
   * Azure ML Service workspace name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  mlWorkspaceName: unknown;

  /**
   * Type of authentication (Required to specify MSI) used to connect to AzureML. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authentication?: unknown;

  /**
   * The ID of the service principal used to authenticate against the endpoint of a published Azure ML Service pipeline. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The key of the service principal used to authenticate against the endpoint of a published Azure ML Service pipeline.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString: unknown;

  /**
   * Type of authentication used to connect to the ODBC data store. Possible values are: Anonymous and Basic. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authenticationType?: unknown;

  /**
   * The access credential portion of the connection string specified in driver-specific property-value format.
   */
  credential?: SecretBase;

  /**
   * User name for Basic authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * Password for Basic authentication.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString: unknown;

  /**
   * Type of authentication used to connect to the Informix as ODBC data store. Possible values are: Anonymous and Basic. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authenticationType?: unknown;

  /**
   * The access credential portion of the connection string specified in driver-specific property-value format.
   */
  credential?: SecretBase;

  /**
   * User name for Basic authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * Password for Basic authentication.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString: unknown;

  /**
   * Type of authentication used to connect to the Microsoft Access as ODBC data store. Possible values are: Anonymous and Basic. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authenticationType?: unknown;

  /**
   * The access credential portion of the connection string specified in driver-specific property-value format.
   */
  credential?: SecretBase;

  /**
   * User name for Basic authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * Password for Basic authentication.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url: unknown;

  /**
   * Type of authentication used to connect to the HDFS. Possible values are: Anonymous and Windows. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authenticationType?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * User name for Windows authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * Password for Windows authentication.
   */
  password?: SecretBase;
}

/**
 * Open Data Protocol (OData) linked service.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ODataLinkedServiceTypeProperties {
  /**
   * The URL of the OData service endpoint. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url: unknown;

  /**
   * Type of authentication used to connect to the OData service.
   */
  authenticationType?: ODataAuthenticationType;

  /**
   * User name of the OData service. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * Password of the OData service.
   */
  password?: SecretBase;

  /**
   * The additional HTTP headers in the request to RESTful API used for authorization. Type: key value pairs (value should be string type).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authHeaders?: unknown;

  /**
   * Specify the tenant information (domain name or tenant ID) under which your application resides. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant?: unknown;

  /**
   * Specify the application id of your application registered in Azure Active Directory. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureCloudType?: unknown;

  /**
   * Specify the resource you are requesting authorization to use Directory. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  aadResourceId?: unknown;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url: unknown;

  /**
   * Type of authentication used to connect to the web table source.
   */
  authenticationType: WebAuthenticationType;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host: unknown;

  /**
   * AuthenticationType to be used for connection. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authenticationType?: unknown;

  /**
   * The port for the connection. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * Username for authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * Password for authentication.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server: unknown;

  /**
   * The authentication type to be used to connect to the MongoDB database.
   */
  authenticationType?: MongoDbAuthenticationType;

  /**
   * The name of the MongoDB database that you want to access. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  databaseName: unknown;

  /**
   * Username for authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * Password for authentication.
   */
  password?: SecretBase;

  /**
   * Database to verify the username and password. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authSource?: unknown;

  /**
   * The TCP port number that the MongoDB server uses to listen for client connections. The default value is 27017. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * Specifies whether the connections to the server are encrypted using SSL. The default value is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableSsl?: unknown;

  /**
   * Specifies whether to allow self-signed certificates from the server. The default value is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowSelfSignedServerCert?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString: unknown;

  /**
   * The name of the MongoDB Atlas database that you want to access. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database: unknown;

  /**
   * The driver version that you want to choose. Allowed value are v1 and v2. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  driverVersion?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString: unknown;

  /**
   * The name of the MongoDB database that you want to access. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isServerVersionAbove32?: unknown;

  /**
   * The CosmosDB (MongoDB API) connection string. Type: string, SecureString or AzureKeyVaultSecretReference. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString: unknown;

  /**
   * The name of the CosmosDB (MongoDB API) database that you want to access. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataLakeStoreUri: unknown;

  /**
   * The ID of the application used to authenticate against the Azure Data Lake Store account. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The Key of the application used to authenticate against the Azure Data Lake Store account.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant?: unknown;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureCloudType?: unknown;

  /**
   * Data Lake Store account name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accountName?: unknown;

  /**
   * Data Lake Store account subscription ID (if different from Data Factory account). Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId?: unknown;

  /**
   * Data Lake Store account resource group name (if different from Data Factory account). Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * Azure Data Lake Storage Gen2 linked service.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureBlobFSLinkedServiceTypeProperties {
  /**
   * Endpoint for the Azure Data Lake Storage Gen2 service. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url?: unknown;

  /**
   * Account key for the Azure Data Lake Storage Gen2 service. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accountKey?: unknown;

  /**
   * The ID of the application used to authenticate against the Azure Data Lake Storage Gen2 account. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The Key of the application used to authenticate against the Azure Data Lake Storage Gen2 account.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant?: unknown;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureCloudType?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalCredentialType?: unknown;

  /**
   * The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.
   */
  servicePrincipalCredential?: SecretBase;

  /**
   * SAS URI of the Azure Data Lake Storage Gen2 service. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sasUri?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  office365TenantId: unknown;

  /**
   * Specify the tenant information under which your Azure AD web application resides. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalTenantId: unknown;

  /**
   * Specify the application's client ID. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId: unknown;

  /**
   * Specify the application's key.
   */
  servicePrincipalKey: SecretBase;

  /**
   * The service principal credential type for authentication.'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. If not specified, 'ServicePrincipalKey' is in use. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalCredentialType?: unknown;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  environmentUrl?: unknown;

  /**
   * The username for Basic authentication of the Salesforce instance. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  apiVersion?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  environmentUrl?: unknown;

  /**
   * The username for Basic authentication of the Salesforce instance. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  apiVersion?: unknown;

  /**
   * Extended properties appended to the connection string. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedProperties?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url: unknown;

  /**
   * The username for Basic authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * The password for Basic authentication.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Either encryptedCredential or username/password must be provided. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url: unknown;

  /**
   * The username for Basic authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * The password for Basic authentication.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Either encryptedCredential or username/password must be provided. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server?: unknown;

  /**
   * System number of the BW system where the open hub destination is located. (Usually a two-digit decimal number represented as a string.) Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  systemNumber?: unknown;

  /**
   * Client ID of the client on the BW system where the open hub destination is located. (Usually a three-digit decimal number represented as a string) Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: unknown;

  /**
   * Language of the BW system where the open hub destination is located. The default value is EN. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  language?: unknown;

  /**
   * SystemID of the SAP system where the table is located. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  systemId?: unknown;

  /**
   * Username to access the SAP BW server where the open hub destination is located. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * Password to access the SAP BW server where the open hub destination is located.
   */
  password?: SecretBase;

  /**
   * The hostname of the SAP Message Server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  messageServer?: unknown;

  /**
   * The service name or port number of the Message Server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  messageServerService?: unknown;

  /**
   * The Logon Group for the SAP System. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  logonGroup?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server?: unknown;

  /**
   * System number of the SAP system where the table is located. (Usually a two-digit decimal number represented as a string.) Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  systemNumber?: unknown;

  /**
   * Client ID of the client on the SAP system where the table is located. (Usually a three-digit decimal number represented as a string) Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: unknown;

  /**
   * Language of the SAP system where the table is located. The default value is EN. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  language?: unknown;

  /**
   * SystemID of the SAP system where the table is located. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  systemId?: unknown;

  /**
   * Username to access the SAP server where the table is located. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * Password to access the SAP server where the table is located.
   */
  password?: SecretBase;

  /**
   * The hostname of the SAP Message Server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  messageServer?: unknown;

  /**
   * The service name or port number of the Message Server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  messageServerService?: unknown;

  /**
   * SNC activation flag (Boolean) to access the SAP server where the table is located. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sncMode?: unknown;

  /**
   * Initiator's SNC name to access the SAP server where the table is located. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sncMyName?: unknown;

  /**
   * Communication partner's SNC name to access the SAP server where the table is located. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sncPartnerName?: unknown;

  /**
   * External security product's library to access the SAP server where the table is located. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sncLibraryPath?: unknown;

  /**
   * SNC Quality of Protection. Allowed value include: 1, 2, 3, 8, 9. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sncQop?: unknown;

  /**
   * SNC X509 certificate file path. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  x509CertificatePath?: unknown;

  /**
   * The Logon Group for the SAP System. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  logonGroup?: unknown;

  /**
   * The subscriber name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriberName?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url: unknown;

  /**
   * Whether to validate server side SSL certificate when connecting to the endpoint.The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableServerCertificateValidation?: unknown;

  /**
   * Type of authentication used to connect to the REST service.
   */
  authenticationType: RestServiceAuthenticationType;

  /**
   * The user name used in Basic authentication type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * The password used in Basic authentication type.
   */
  password?: SecretBase;

  /**
   * The additional HTTP headers in the request to RESTful API used for authorization. Type: object (or Expression with resultType object).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authHeaders?: unknown;

  /**
   * The application's client ID used in AadServicePrincipal authentication type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The application's key used in AadServicePrincipal authentication type.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The tenant information (domain name or tenant ID) used in AadServicePrincipal authentication type under which your application resides. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant?: unknown;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureCloudType?: unknown;

  /**
   * The resource you are requesting authorization to use. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  aadResourceId?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;

  /**
   * The client ID associated with your application. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: unknown;

  /**
   * The client secret associated with your application.
   */
  clientSecret?: SecretBase;

  /**
   * The token endpoint of the authorization server to acquire access token. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tokenEndpoint?: unknown;

  /**
   * The target service or resource to which the access will be requested. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: unknown;

  /**
   * The scope of the access required. It describes what kind of access will be requested. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  scope?: unknown;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalCredentialType?: unknown;

  /**
   * Specify the base64 encoded certificate of your application registered in Azure Active Directory. Type: string (or Expression with resultType string).
   */
  servicePrincipalEmbeddedCert?: SecretBase;

  /**
   * Specify the password of your certificate if your certificate has a password and you are using AadServicePrincipal authentication. Type: string (or Expression with resultType string).
   */
  servicePrincipalEmbeddedCertPassword?: SecretBase;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url: unknown;

  /**
   * The username of the TeamDesk source. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url: unknown;

  /**
   * The user token for the Quickbase source.
   */
  userToken: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url: unknown;

  /**
   * The username of the Zendesk source. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName: unknown;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName: unknown;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authenticationType?: unknown;

  /**
   * The access key identifier of the Amazon S3 Identity and Access Management (IAM) user. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accessKeyId?: unknown;

  /**
   * The secret access key of the Amazon S3 Identity and Access Management (IAM) user.
   */
  secretAccessKey?: SecretBase;

  /**
   * This value specifies the endpoint to access with the S3 Connector. This is an optional property; change it only if you want to try a different service endpoint or want to switch between https and http. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceUrl?: unknown;

  /**
   * The session token for the S3 temporary security credential.
   */
  sessionToken?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server: unknown;

  /**
   * The username of the Amazon Redshift source. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * The password of the Amazon Redshift source.
   */
  password?: SecretBase;

  /**
   * The database name of the Amazon Redshift source. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database: unknown;

  /**
   * The TCP port number that the Amazon Redshift server uses to listen for client connections. The default value is 5439. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;
}

/**
 * Custom linked service.
 */
model CustomDataSourceLinkedService extends LinkedService {
  /**
   * Custom linked service properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  typeProperties: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url: unknown;

  /**
   * Admin Key for Azure Search service
   */
  key?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url: unknown;

  /**
   * The authentication type to be used to connect to the HTTP server.
   */
  authenticationType?: HttpAuthenticationType;

  /**
   * User name for Basic, Digest, or Windows authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * Password for Basic, Digest, Windows, or ClientCertificate with EmbeddedCertData authentication.
   */
  password?: SecretBase;

  /**
   * The additional HTTP headers in the request to RESTful API used for authorization. Type: key value pairs (value should be string type).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authHeaders?: unknown;

  /**
   * Base64 encoded certificate data for ClientCertificate authentication. For on-premises copy with ClientCertificate authentication, either CertThumbprint or EmbeddedCertData/Password should be specified. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  embeddedCertData?: unknown;

  /**
   * Thumbprint of certificate for ClientCertificate authentication. Only valid for on-premises copy. For on-premises copy with ClientCertificate authentication, either CertThumbprint or EmbeddedCertData/Password should be specified. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  certThumbprint?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * If true, validate the HTTPS server SSL certificate. Default value is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableServerCertificateValidation?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host: unknown;

  /**
   * The TCP port number that the FTP server uses to listen for client connections. Default value is 21. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * The authentication type to be used to connect to the FTP server.
   */
  authenticationType?: FtpAuthenticationType;

  /**
   * Username to logon the FTP server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * Password to logon the FTP server.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * If true, connect to the FTP server over SSL/TLS channel. Default value is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableSsl?: unknown;

  /**
   * If true, validate the FTP server SSL certificate when connect over SSL/TLS channel. Default value is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableServerCertificateValidation?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host: unknown;

  /**
   * The TCP port number that the SFTP server uses to listen for client connections. Default value is 22. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * The authentication type to be used to connect to the FTP server.
   */
  authenticationType?: SftpAuthenticationType;

  /**
   * The username used to log on to the SFTP server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * Password to logon the SFTP server for Basic authentication.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * The SSH private key file path for SshPublicKey authentication. Only valid for on-premises copy. For on-premises copy with SshPublicKey authentication, either PrivateKeyPath or PrivateKeyContent should be specified. SSH private key should be OpenSSH format. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateKeyPath?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  skipHostKeyValidation?: unknown;

  /**
   * The host key finger-print of the SFTP server. When SkipHostKeyValidation is false, HostKeyFingerprint should be specified. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hostKeyFingerprint?: unknown;
}

/**
 * SAP Business Warehouse Linked Service.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SapBWLinkedServiceTypeProperties {
  /**
   * Host name of the SAP BW instance. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server: unknown;

  /**
   * System number of the BW system. (Usually a two-digit decimal number represented as a string.) Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  systemNumber: unknown;

  /**
   * Client ID of the client on the BW system. (Usually a three-digit decimal number represented as a string) Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId: unknown;

  /**
   * Username to access the SAP BW server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * Password to access the SAP BW server.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * Host name of the SAP HANA server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server?: unknown;

  /**
   * The authentication type to be used to connect to the SAP HANA server.
   */
  authenticationType?: SapHanaAuthenticationType;

  /**
   * Username to access the SAP HANA server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * Password to access the SAP HANA server.
   */
  password?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;
}

/**
 * Amazon Marketplace Web Service linked service.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AmazonMWSLinkedServiceTypeProperties {
  /**
   * The endpoint of the Amazon MWS server, (i.e. mws.amazonservices.com)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endpoint: unknown;

  /**
   * The Amazon Marketplace ID you want to retrieve data from. To retrieve data from multiple Marketplace IDs, separate them with a comma (,). (i.e. A2EUQ1WTGCTBG2)
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  marketplaceID: unknown;

  /**
   * The Amazon seller ID.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sellerID: unknown;

  /**
   * The Amazon MWS authentication token.
   */
  mwsAuthToken?: SecretBase;

  /**
   * The access key id used to access data.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accessKeyId: unknown;

  /**
   * The secret key used to access data.
   */
  secretKey?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useEncryptedEndpoints?: unknown;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useHostVerification?: unknown;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  usePeerVerification?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * Server name for connection. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server?: unknown;

  /**
   * The port for the connection. Type: integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * Username for authentication. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * Database name for connection. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database?: unknown;

  /**
   * SSL mode for connection. Type: integer. 0: disable, 1:allow, 2: prefer, 3: require, 4: verify-ca, 5: verify-full. Type: integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sslMode?: unknown;

  /**
   * The time to wait (in seconds) while trying to establish a connection before terminating the attempt and generating an error. Type: integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeout?: unknown;

  /**
   * The time to wait (in seconds) while trying to execute a command before terminating the attempt and generating an error. Set to zero for infinity. Type: integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  commandTimeout?: unknown;

  /**
   * Whether to trust the server certificate without validating it. Type: boolean.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  trustServerCertificate?: unknown;

  /**
   * Determines the size of the internal buffer uses when reading. Increasing may improve performance if transferring large values from the database. Type: integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  readBufferSize?: unknown;

  /**
   * Gets or sets the session timezone. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timezone?: unknown;

  /**
   * Gets or sets the .NET encoding that will be used to encode/decode PostgreSQL string data. Type: string
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encoding?: unknown;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * The ID of the service principal used to authenticate against Azure Database for PostgreSQL Flexible server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The key of the service principal used to authenticate against Azure Database for PostgreSQL Flexible server.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalCredentialType?: unknown;

  /**
   * Specify the base64 encoded certificate of your application registered in Azure Active Directory. Type: string (or Expression with resultType string).
   */
  servicePrincipalEmbeddedCert?: SecretBase;

  /**
   * Specify the password of your certificate if your certificate has a password and you are using AadServicePrincipal authentication. Type: string (or Expression with resultType string).
   */
  servicePrincipalEmbeddedCertPassword?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant?: unknown;

  /**
   * Indicates the azure cloud type of the service principle auth. Allowed values are AzurePublic, AzureChina, AzureUsGovernment, AzureGermany. Default value is the data factory regions’ cloud type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureCloudType?: unknown;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionProperties?: unknown;

  /**
   * Application client_id supplied by Concur App Management.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId: unknown;

  /**
   * The user name that you use to access Concur Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username: unknown;

  /**
   * The password corresponding to the user name that you provided in the username field.
   */
  password?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useEncryptedEndpoints?: unknown;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useHostVerification?: unknown;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  usePeerVerification?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * The Azure key vault secret reference of credString in connection string.
   */
  credString?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  pwd?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endpoint: unknown;

  /**
   * The site name and user name of your Eloqua account in the form: sitename/username. (i.e. Eloqua/Alice)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username: unknown;

  /**
   * The password corresponding to the user name.
   */
  password?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useEncryptedEndpoints?: unknown;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useHostVerification?: unknown;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  usePeerVerification?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  project: unknown;

  /**
   * A comma-separated list of public BigQuery projects to access. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalProjects?: unknown;

  /**
   * Whether to request access to Google Drive. Allowing Google Drive access enables support for federated tables that combine BigQuery data with data from Google Drive. The default value is false. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requestGoogleDriveScope?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: unknown;

  /**
   * The client secret of the google application used to acquire the refresh token.
   */
  clientSecret?: SecretBase;

  /**
   * The service account email ID that is used for ServiceAuthentication and can only be used on self-hosted IR. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  email?: unknown;

  /**
   * The full path to the .p12 key file that is used to authenticate the service account email address and can only be used on self-hosted IR. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keyFilePath?: unknown;

  /**
   * The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  trustedCertPath?: unknown;

  /**
   * Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false.Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useSystemTrustStore?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;
}

/**
 * Google BigQuery service linked service.
 */
model GoogleBigQueryV2LinkedService extends LinkedService {
  /**
   * Google BigQuery service linked service properties.
   */
  typeProperties: GoogleBigQueryV2LinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "GoogleBigQueryV2";
}

/**
 * Google BigQuery service linked service properties.
 */
model GoogleBigQueryV2LinkedServiceTypeProperties {
  /**
   * The default BigQuery project id to query against. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  projectId: unknown;

  /**
   * The OAuth 2.0 authentication mechanism used for authentication.
   */
  authenticationType: GoogleBigQueryV2AuthenticationType;

  /**
   * The client id of the google application used to acquire the refresh token. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: unknown;

  /**
   * The client secret of the google application used to acquire the refresh token.
   */
  clientSecret?: SecretBase;

  /**
   * The refresh token obtained from Google for authorizing access to BigQuery for UserAuthentication.
   */
  refreshToken?: SecretBase;

  /**
   * The content of the .json key file that is used to authenticate the service account. Type: string (or Expression with resultType string).
   */
  keyFileContent?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  pwd?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * The authentication type to use. Type: string. Only used for V2.
   */
  authenticationType?: GreenplumAuthenticationType;

  /**
   * Host name for connection. Type: string. Only used for V2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host?: unknown;

  /**
   * The port for the connection. Type: integer. Only used for V2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * Username for authentication. Type: string. Only used for V2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * Database name for connection. Type: string. Only used for V2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database?: unknown;

  /**
   * SSL mode for connection. Type: integer. 0: disable, 1:allow, 2: prefer, 3: require, 4: verify-ca, 5: verify-full. Type: integer. Only used for V2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sslMode?: unknown;

  /**
   * The time to wait (in seconds) while trying to establish a connection before terminating the attempt and generating an error. Type: integer. Only used for V2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionTimeout?: unknown;

  /**
   * The time to wait (in seconds) while trying to execute a command before terminating the attempt and generating an error. Set to zero for infinity. Type: integer. Only used for V2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  commandTimeout?: unknown;
}

/**
 * HBase server linked service.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HBaseLinkedServiceTypeProperties {
  /**
   * The IP address or host name of the HBase server. (i.e. 192.168.222.160)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host: unknown;

  /**
   * The TCP port that the HBase instance uses to listen for client connections. The default value is 9090.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * The partial URL corresponding to the HBase server. (i.e. /gateway/sandbox/hbase/version)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpPath?: unknown;

  /**
   * The authentication mechanism to use to connect to the HBase server.
   */
  authenticationType: HBaseAuthenticationType;

  /**
   * The user name used to connect to the HBase instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * The password corresponding to the user name.
   */
  password?: SecretBase;

  /**
   * Specifies whether the connections to the server are encrypted using SSL. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableSsl?: unknown;

  /**
   * The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  trustedCertPath?: unknown;

  /**
   * Specifies whether to require a CA-issued SSL certificate name to match the host name of the server when connecting over SSL. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowHostNameCNMismatch?: unknown;

  /**
   * Specifies whether to allow self-signed certificates from the server. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowSelfSignedServerCert?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host: unknown;

  /**
   * The TCP port that the Hive server uses to listen for client connections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceDiscoveryMode?: unknown;

  /**
   * The namespace on ZooKeeper under which Hive Server 2 nodes are added.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  zooKeeperNameSpace?: unknown;

  /**
   * Specifies whether the driver uses native HiveQL queries,or converts them into an equivalent form in HiveQL.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useNativeQuery?: unknown;

  /**
   * The user name that you use to access Hive Server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * The password corresponding to the user name that you provided in the Username field
   */
  password?: SecretBase;

  /**
   * The partial URL corresponding to the Hive server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpPath?: unknown;

  /**
   * Specifies whether the connections to the server are encrypted using SSL. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableSsl?: unknown;

  /**
   * Specifies whether the connections to the server will validate server certificate, the default value is True. Only used for Version 2.0
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableServerCertificateValidation?: unknown;

  /**
   * The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  trustedCertPath?: unknown;

  /**
   * Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useSystemTrustStore?: unknown;

  /**
   * Specifies whether to require a CA-issued SSL certificate name to match the host name of the server when connecting over SSL. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowHostNameCNMismatch?: unknown;

  /**
   * Specifies whether to allow self-signed certificates from the server. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowSelfSignedServerCert?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useEncryptedEndpoints?: unknown;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useHostVerification?: unknown;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  usePeerVerification?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host: unknown;

  /**
   * The TCP port that the Impala server uses to listen for client connections. The default value is 21050.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * The authentication type to use.
   */
  authenticationType: ImpalaAuthenticationType;

  /**
   * The user name used to access the Impala server. The default value is anonymous when using SASLUsername.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * The password corresponding to the user name when using UsernameAndPassword.
   */
  password?: SecretBase;

  /**
   * The transport protocol to use in the Thrift layer (for V2 only). Default value is Binary.
   */
  thriftTransportProtocol?: ImpalaThriftTransportProtocol;

  /**
   * Specifies whether the connections to the server are encrypted using SSL. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableSsl?: unknown;

  /**
   * Specify whether to enable server SSL certificate validation when you connect.Always use System Trust Store (for V2 only). The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableServerCertificateValidation?: unknown;

  /**
   * The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  trustedCertPath?: unknown;

  /**
   * Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useSystemTrustStore?: unknown;

  /**
   * Specifies whether to require a CA-issued SSL certificate name to match the host name of the server when connecting over SSL. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowHostNameCNMismatch?: unknown;

  /**
   * Specifies whether to allow self-signed certificates from the server. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowSelfSignedServerCert?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host: unknown;

  /**
   * The TCP port that the Jira server uses to listen for client connections. The default value is 443 if connecting through HTTPS, or 8080 if connecting through HTTP.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * The user name that you use to access Jira Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username: unknown;

  /**
   * The password corresponding to the user name that you provided in the username field.
   */
  password?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useEncryptedEndpoints?: unknown;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useHostVerification?: unknown;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  usePeerVerification?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host: unknown;

  /**
   * The access token from Magento.
   */
  accessToken?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useEncryptedEndpoints?: unknown;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useHostVerification?: unknown;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  usePeerVerification?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;
}

/**
 * MariaDB server linked service.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MariaDBLinkedServiceTypeProperties {
  /**
   * The version of the MariaDB driver. Type: string. V1 or empty for legacy driver, V2 for new driver. V1 can support connection string and property bag, V2 can only support connection string. The legacy driver is scheduled for deprecation by October 2024.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  driverVersion?: unknown;

  /**
   * An ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * Server name for connection. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server?: unknown;

  /**
   * The port for the connection. Type: integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * Username for authentication. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * Database name for connection. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database?: unknown;

  /**
   * This option specifies whether the driver uses TLS encryption and verification when connecting to MariaDB. E.g., SSLMode=<0/1/2/3/4>. Options: DISABLED (0) / PREFERRED (1) (Default) / REQUIRED (2) / VERIFY_CA (3) / VERIFY_IDENTITY (4), REQUIRED (2) is recommended to only allow connections encrypted with SSL/TLS.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sslMode?: unknown;

  /**
   * This option specifies whether to use a CA certificate from the system trust store, or from a specified PEM file. E.g. UseSystemTrustStore=<0/1>; Options: Enabled (1) / Disabled (0) (Default)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useSystemTrustStore?: unknown;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;
}

/**
 * Azure Database for MariaDB linked service.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureMariaDBLinkedServiceTypeProperties {
  /**
   * An ODBC connection string. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  pwd?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endpoint: unknown;

  /**
   * The client Id of your Marketo service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId: unknown;

  /**
   * The client secret of your Marketo service.
   */
  clientSecret?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useEncryptedEndpoints?: unknown;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useHostVerification?: unknown;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  usePeerVerification?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host: unknown;

  /**
   * The client ID associated with your PayPal application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId: unknown;

  /**
   * The client secret associated with your PayPal application.
   */
  clientSecret?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useEncryptedEndpoints?: unknown;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useHostVerification?: unknown;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  usePeerVerification?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host: unknown;

  /**
   * The TCP port that the Phoenix server uses to listen for client connections. The default value is 8765.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * The partial URL corresponding to the Phoenix server. (i.e. /gateway/sandbox/phoenix/version). The default value is hbasephoenix if using WindowsAzureHDInsightService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpPath?: unknown;

  /**
   * The authentication mechanism used to connect to the Phoenix server.
   */
  authenticationType: PhoenixAuthenticationType;

  /**
   * The user name used to connect to the Phoenix server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * The password corresponding to the user name.
   */
  password?: SecretBase;

  /**
   * Specifies whether the connections to the server are encrypted using SSL. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableSsl?: unknown;

  /**
   * The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  trustedCertPath?: unknown;

  /**
   * Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useSystemTrustStore?: unknown;

  /**
   * Specifies whether to require a CA-issued SSL certificate name to match the host name of the server when connecting over SSL. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowHostNameCNMismatch?: unknown;

  /**
   * Specifies whether to allow self-signed certificates from the server. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowSelfSignedServerCert?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;
}

/**
 * Presto server linked service. This linked service has supported version property. The Version 1.0 is scheduled for deprecation while your pipeline will continue to run after EOL but without any bug fix or new features.
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host: unknown;

  /**
   * The version of the Presto server. (i.e. 0.148-t) Only used for Version 1.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serverVersion?: unknown;

  /**
   * The catalog context for all request against the server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  catalog: unknown;

  /**
   * The TCP port that the Presto server uses to listen for client connections. The default value is 8080 when disable SSL, default value is 443 when enable SSL.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * The authentication mechanism used to connect to the Presto server.
   */
  authenticationType: PrestoAuthenticationType;

  /**
   * The user name used to connect to the Presto server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * The password corresponding to the user name.
   */
  password?: SecretBase;

  /**
   * Specifies whether the connections to the server are encrypted using SSL. The default value for legacy version is False. The default value for version 2.0 is True.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableSsl?: unknown;

  /**
   * Specifies whether the connections to the server will validate server certificate, the default value is True. Only used for Version 2.0
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableServerCertificateValidation?: unknown;

  /**
   * The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR. Only used for Version 1.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  trustedCertPath?: unknown;

  /**
   * Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false. Only used for Version 1.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useSystemTrustStore?: unknown;

  /**
   * Specifies whether to require a CA-issued SSL certificate name to match the host name of the server when connecting over SSL. The default value is false. Only used for Version 1.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowHostNameCNMismatch?: unknown;

  /**
   * Specifies whether to allow self-signed certificates from the server. The default value is false. Only used for Version 1.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowSelfSignedServerCert?: unknown;

  /**
   * The local time zone used by the connection. Valid values for this option are specified in the IANA Time Zone Database. The default value for Version 1.0 is the client system time zone. The default value for Version 2.0 is server system timeZone
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeZoneID?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;
}

/**
 * QuickBooks server linked service. This linked service has supported version property. The Version 1.0 is scheduled for deprecation while your pipeline will continue to run after EOL but without any bug fix or new features.
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionProperties?: unknown;

  /**
   * The endpoint of the QuickBooks server. (i.e. quickbooks.api.intuit.com)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endpoint?: unknown;

  /**
   * The company ID of the QuickBooks company to authorize.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  companyId?: unknown;

  /**
   * The consumer key for OAuth 2.0 authentication.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  consumerKey?: unknown;

  /**
   * The consumer secret for OAuth 2.0 authentication.
   */
  consumerSecret?: SecretBase;

  /**
   * The access token for OAuth 2.0 authentication.
   */
  accessToken?: SecretBase;

  /**
   * The access token secret is deprecated for OAuth 1.0 authentication. Only used for version 1.0.
   */
  accessTokenSecret?: SecretBase;

  /**
   * The refresh token for OAuth 2.0 authentication.
   */
  refreshToken?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true. Only used for version 1.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useEncryptedEndpoints?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endpoint: unknown;

  /**
   * The authentication type to use.
   */
  authenticationType: ServiceNowAuthenticationType;

  /**
   * The user name used to connect to the ServiceNow server for Basic and OAuth2 authentication.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * The password corresponding to the user name for Basic and OAuth2 authentication.
   */
  password?: SecretBase;

  /**
   * The client id for OAuth2 authentication.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: unknown;

  /**
   * The client secret for OAuth2 authentication.
   */
  clientSecret?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useEncryptedEndpoints?: unknown;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useHostVerification?: unknown;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  usePeerVerification?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host: unknown;

  /**
   * The API access token that can be used to access Shopify’s data. The token won't expire if it is offline mode.
   */
  accessToken?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useEncryptedEndpoints?: unknown;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useHostVerification?: unknown;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  usePeerVerification?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host: unknown;

  /**
   * The TCP port that the Spark server uses to listen for client connections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * The password corresponding to the user name that you provided in the Username field
   */
  password?: SecretBase;

  /**
   * The partial URL corresponding to the Spark server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpPath?: unknown;

  /**
   * Specifies whether the connections to the server are encrypted using SSL. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableSsl?: unknown;

  /**
   * Specifies whether the connections to the server will validate server certificate, the default value is True. Only used for Version 2.0
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableServerCertificateValidation?: unknown;

  /**
   * The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  trustedCertPath?: unknown;

  /**
   * Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useSystemTrustStore?: unknown;

  /**
   * Specifies whether to require a CA-issued SSL certificate name to match the host name of the server when connecting over SSL. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowHostNameCNMismatch?: unknown;

  /**
   * Specifies whether to allow self-signed certificates from the server. The default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowSelfSignedServerCert?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionProperties?: unknown;

  /**
   * The URL of the Square instance. (i.e. mystore.mysquare.com)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host?: unknown;

  /**
   * The client ID associated with your Square application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: unknown;

  /**
   * The client secret associated with your Square application.
   */
  clientSecret?: SecretBase;

  /**
   * The redirect URL assigned in the Square application dashboard. (i.e. http://localhost:2500)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  redirectUri?: unknown;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useEncryptedEndpoints?: unknown;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useHostVerification?: unknown;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  usePeerVerification?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionProperties?: unknown;

  /**
   * The endpoint of the Xero server. (i.e. api.xero.com)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host?: unknown;

  /**
   * The consumer key associated with the Xero application.
   */
  consumerKey?: SecretBase;

  /**
   * The private key from the .pem file that was generated for your Xero private application. You must include all the text from the .pem file, including the Unix line endings(
   * ).
   */
  privateKey?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useEncryptedEndpoints?: unknown;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useHostVerification?: unknown;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  usePeerVerification?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionProperties?: unknown;

  /**
   * The endpoint of the Zoho server. (i.e. crm.zoho.com/crm/private)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endpoint?: unknown;

  /**
   * The access token for Zoho authentication.
   */
  accessToken?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useEncryptedEndpoints?: unknown;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useHostVerification?: unknown;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  usePeerVerification?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * Server name for connection. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server?: unknown;

  /**
   * The port for the connection. Type: integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * Username for authentication. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  uid?: unknown;

  /**
   * Database name for connection. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database?: unknown;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  pwd?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString?: unknown;

  /**
   * Server name for connection. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server?: unknown;

  /**
   * The port for the connection. Type: integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: unknown;

  /**
   * Username for authentication. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  uid?: unknown;

  /**
   * Database name for connection. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database?: unknown;

  /**
   * Specifies the security level for the driver connection to the data store. PreferredUnSecured : prefer unsecured, allow fallback to secured connection if required. OnlyUnSecured : strictly unsecured, no fallback.
   */
  securityLevel?: NetezzaSecurityLevelType;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  pwd?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionProperties?: unknown;

  /**
   * The client ID associated with the Salesforce Marketing Cloud application. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: unknown;

  /**
   * The client secret associated with the Salesforce Marketing Cloud application. Type: string (or Expression with resultType string).
   */
  clientSecret?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useEncryptedEndpoints?: unknown;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useHostVerification?: unknown;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  usePeerVerification?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;
}

/**
 * HDInsight ondemand linked service.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HDInsightOnDemandLinkedServiceTypeProperties {
  /**
   * Number of worker/data nodes in the cluster. Suggestion value: 4. Type: int (or Expression with resultType int).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clusterSize: unknown;

  /**
   * The allowed idle time for the on-demand HDInsight cluster. Specifies how long the on-demand HDInsight cluster stays alive after completion of an activity run if there are no other active jobs in the cluster. The minimum value is 5 mins. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeToLive: unknown;

  /**
   * Version of the HDInsight cluster.  Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  version: unknown;

  /**
   * Azure Storage linked service to be used by the on-demand cluster for storing and processing data.
   */
  linkedServiceName: LinkedServiceReference;

  /**
   * The customer’s subscription to host the cluster. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hostSubscriptionId: unknown;

  /**
   * The service principal id for the hostSubscriptionId. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The key for the service principal id.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The Tenant id/name to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant: unknown;

  /**
   * The resource group where the cluster belongs. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clusterResourceGroup: unknown;

  /**
   * HDInsight On-demand cluster resource group authentication type.
   */
  clusterResourceGroupAuthType?: HDInsightOndemandClusterResourceGroupAuthenticationType;

  /**
   * The prefix of cluster name, postfix will be distinct with timestamp. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clusterNamePrefix?: unknown;

  /**
   * The username to access the cluster. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clusterUserName?: unknown;

  /**
   * The password to access the cluster.
   */
  clusterPassword?: SecretBase;

  /**
   * The username to SSH remotely connect to cluster’s node (for Linux). Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clusterSshUserName?: unknown;

  /**
   * The password to SSH remotely connect cluster’s node (for Linux).
   */
  clusterSshPassword?: SecretBase;

  /**
   * Specifies additional storage accounts for the HDInsight linked service so that the Data Factory service can register them on your behalf.
   */
  @identifiers(#["referenceName"])
  additionalLinkedServiceNames?: LinkedServiceReference[];

  /**
   * The name of Azure SQL linked service that point to the HCatalog database. The on-demand HDInsight cluster is created by using the Azure SQL database as the metastore.
   */
  hcatalogLinkedServiceName?: LinkedServiceReference;

  /**
   * The cluster type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clusterType?: unknown;

  /**
   * The version of spark if the cluster type is 'spark'. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sparkVersion?: unknown;

  /**
   * Specifies the core configuration parameters (as in core-site.xml) for the HDInsight cluster to be created.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  coreConfiguration?: unknown;

  /**
   * Specifies the HBase configuration parameters (hbase-site.xml) for the HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hBaseConfiguration?: unknown;

  /**
   * Specifies the HDFS configuration parameters (hdfs-site.xml) for the HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hdfsConfiguration?: unknown;

  /**
   * Specifies the hive configuration parameters (hive-site.xml) for the HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hiveConfiguration?: unknown;

  /**
   * Specifies the MapReduce configuration parameters (mapred-site.xml) for the HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  mapReduceConfiguration?: unknown;

  /**
   * Specifies the Oozie configuration parameters (oozie-site.xml) for the HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  oozieConfiguration?: unknown;

  /**
   * Specifies the Storm configuration parameters (storm-site.xml) for the HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  stormConfiguration?: unknown;

  /**
   * Specifies the Yarn configuration parameters (yarn-site.xml) for the HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  yarnConfiguration?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * Specifies the size of the head node for the HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  headNodeSize?: unknown;

  /**
   * Specifies the size of the data node for the HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataNodeSize?: unknown;

  /**
   * Specifies the size of the Zoo Keeper node for the HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  zookeeperNodeSize?: unknown;

  /**
   * Custom script actions to run on HDI ondemand cluster once it's up. Please refer to https://docs.microsoft.com/en-us/azure/hdinsight/hdinsight-hadoop-customize-cluster-linux?toc=%2Fen-us%2Fazure%2Fhdinsight%2Fr-server%2FTOC.json&bc=%2Fen-us%2Fazure%2Fbread%2Ftoc.json#understanding-script-actions.
   */
  @identifiers(#["name"])
  scriptActions?: ScriptAction[];

  /**
   * The ARM resource ID for the vNet to which the cluster should be joined after creation. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  virtualNetworkId?: unknown;

  /**
   * The ARM resource ID for the subnet in the vNet. If virtualNetworkId was specified, then this property is required. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subnetName?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  roles: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accountName: unknown;

  /**
   * The ID of the application used to authenticate against the Azure Data Lake Analytics account. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The Key of the application used to authenticate against the Azure Data Lake Analytics account.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant: unknown;

  /**
   * Data Lake Analytics account subscription ID (if different from Data Factory account). Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId?: unknown;

  /**
   * Data Lake Analytics account resource group name (if different from Data Factory account). Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName?: unknown;

  /**
   * Azure Data Lake Analytics URI Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataLakeAnalyticsUri?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  domain: unknown;

  /**
   * Access token for databricks REST API. Refer to https://docs.azuredatabricks.net/api/latest/authentication.html. Type: string (or Expression with resultType string).
   */
  accessToken?: SecretBase;

  /**
   * Required to specify MSI, if using Workspace resource id for databricks REST API. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authentication?: unknown;

  /**
   * Workspace resource id for databricks REST API. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  workspaceResourceId?: unknown;

  /**
   * The id of an existing interactive cluster that will be used for all runs of this activity. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  existingClusterId?: unknown;

  /**
   * The id of an existing instance pool that will be used for all runs of this activity. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instancePoolId?: unknown;

  /**
   * If not using an existing interactive cluster, this specifies the Spark version of a new job cluster or instance pool nodes created for each run of this activity. Required if instancePoolId is specified. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  newClusterVersion?: unknown;

  /**
   * If not using an existing interactive cluster, this specifies the number of worker nodes to use for the new job cluster or instance pool. For new job clusters, this a string-formatted Int32, like '1' means numOfWorker is 1 or '1:10' means auto-scale from 1 (min) to 10 (max). For instance pools, this is a string-formatted Int32, and can only specify a fixed number of worker nodes, such as '2'. Required if newClusterVersion is specified. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  newClusterNumOfWorker?: unknown;

  /**
   * The node type of the new job cluster. This property is required if newClusterVersion is specified and instancePoolId is not specified. If instancePoolId is specified, this property is ignored. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  newClusterNodeType?: unknown;

  /**
   * A set of optional, user-specified Spark configuration key-value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  newClusterSparkConf?: Record<unknown>;

  /**
   * A set of optional, user-specified Spark environment variables key-value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  newClusterSparkEnvVars?: Record<unknown>;

  /**
   * Additional tags for cluster resources. This property is ignored in instance pool configurations.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  newClusterCustomTags?: Record<unknown>;

  /**
   * Specify a location to deliver Spark driver, worker, and event logs. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  newClusterLogDestination?: unknown;

  /**
   * The driver node type for the new job cluster. This property is ignored in instance pool configurations. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  newClusterDriverNodeType?: unknown;

  /**
   * User-defined initialization scripts for the new cluster. Type: array of strings (or Expression with resultType array of strings).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  newClusterInitScripts?: unknown;

  /**
   * Enable the elastic disk on the new cluster. This property is now ignored, and takes the default elastic disk behavior in Databricks (elastic disks are always enabled). Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  newClusterEnableElasticDisk?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * The policy id for limiting the ability to configure clusters based on a user defined set of rules. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  policyId?: unknown;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;

  /**
   * The data security mode for the Databricks Cluster. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataSecurityMode?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  domain: unknown;

  /**
   * Access token for databricks REST API. Refer to https://docs.azuredatabricks.net/api/latest/authentication.html. Type: string, SecureString or AzureKeyVaultSecretReference.
   */
  accessToken?: SecretBase;

  /**
   * The id of an existing interactive cluster that will be used for all runs of this job. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clusterId?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;

  /**
   * Workspace resource id for databricks REST API. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  workspaceResourceId?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endpoint: unknown;

  /**
   * The client ID associated with the Responsys application. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId: unknown;

  /**
   * The client secret associated with the Responsys application. Type: string (or Expression with resultType string).
   */
  clientSecret?: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useEncryptedEndpoints?: unknown;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useHostVerification?: unknown;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  usePeerVerification?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;
}

/**
 * Dynamics AX linked service.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DynamicsAXLinkedServiceTypeProperties {
  /**
   * The Dynamics AX (or Dynamics 365 Finance and Operations) instance OData endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url: unknown;

  /**
   * Specify the application's client ID. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId: unknown;

  /**
   * Specify the application's key. Mark this field as a SecureString to store it securely in Data Factory, or reference a secret stored in Azure Key Vault. Type: string (or Expression with resultType string).
   */
  servicePrincipalKey: SecretBase;

  /**
   * Specify the tenant information (domain name or tenant ID) under which your application resides. Retrieve it by hovering the mouse in the top-right corner of the Azure portal. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant: unknown;

  /**
   * Specify the resource you are requesting authorization. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  aadResourceId: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host: unknown;

  /**
   * The user name that you use to access Oracle Service Cloud server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username: unknown;

  /**
   * The password corresponding to the user name that you provided in the username key.
   */
  password: SecretBase;

  /**
   * Specifies whether the data source endpoints are encrypted using HTTPS. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useEncryptedEndpoints?: unknown;

  /**
   * Specifies whether to require the host name in the server's certificate to match the host name of the server when connecting over SSL. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useHostVerification?: unknown;

  /**
   * Specifies whether to verify the identity of the server when connecting over SSL. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  usePeerVerification?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionProperties?: unknown;

  /**
   * The Client customer ID of the AdWords account that you want to fetch report data for. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientCustomerID?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: unknown;

  /**
   * The client secret of the google application used to acquire the refresh token.
   */
  clientSecret?: SecretBase;

  /**
   * The service account email ID that is used for ServiceAuthentication and can only be used on self-hosted IR. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  email?: unknown;

  /**
   * (Deprecated) The full path to the .p12 key file that is used to authenticate the service account email address and can only be used on self-hosted IR. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keyFilePath?: unknown;

  /**
   * (Deprecated) The full path of the .pem file containing trusted CA certificates for verifying the server when connecting over SSL. This property can only be set when using SSL on self-hosted IR. The default value is the cacerts.pem file installed with the IR. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  trustedCertPath?: unknown;

  /**
   * (Deprecated) Specifies whether to use a CA certificate from the system trust store or from a specified PEM file. The default value is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useSystemTrustStore?: unknown;

  /**
   * The private key that is used to authenticate the service account email address and can only be used on self-hosted IR.
   */
  privateKey?: SecretBase;

  /**
   * The customer ID of the Google Ads Manager account through which you want to fetch report data of specific Customer. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  loginCustomerID?: unknown;

  /**
   * The Google Ads API major version such as v14. The supported major versions could be found on https://developers.google.com/google-ads/api/docs/release-notes. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  googleAdsApiVersion?: unknown;

  /**
   * Specifies whether to use the legacy data type mappings, which maps float, int32 and int64 from Google to string. Do not set this to true unless you want to keep backward compatibility with legacy driver's data type mappings. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  supportLegacyDataTypes?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  server?: unknown;

  /**
   * System number of the SAP system where the table is located. (Usually a two-digit decimal number represented as a string.) Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  systemNumber?: unknown;

  /**
   * Client ID of the client on the SAP system where the table is located. (Usually a three-digit decimal number represented as a string) Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: unknown;

  /**
   * Language of the SAP system where the table is located. The default value is EN. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  language?: unknown;

  /**
   * SystemID of the SAP system where the table is located. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  systemId?: unknown;

  /**
   * Username to access the SAP server where the table is located. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: unknown;

  /**
   * Password to access the SAP server where the table is located.
   */
  password?: SecretBase;

  /**
   * The hostname of the SAP Message Server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  messageServer?: unknown;

  /**
   * The service name or port number of the Message Server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  messageServerService?: unknown;

  /**
   * SNC activation flag (Boolean) to access the SAP server where the table is located. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sncMode?: unknown;

  /**
   * Initiator's SNC name to access the SAP server where the table is located. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sncMyName?: unknown;

  /**
   * Communication partner's SNC name to access the SAP server where the table is located. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sncPartnerName?: unknown;

  /**
   * External security product's library to access the SAP server where the table is located. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sncLibraryPath?: unknown;

  /**
   * SNC Quality of Protection. Allowed value include: 1, 2, 3, 8, 9. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sncQop?: unknown;

  /**
   * The Logon Group for the SAP System. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  logonGroup?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endpoint: unknown;

  /**
   * The ID of the service principal used to authenticate against Azure Data Explorer. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The key of the service principal used to authenticate against Kusto.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * Database name for connection. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database: unknown;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant?: unknown;

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
   * The endpoint of the Azure Function App. URL will be in the format https://<accountName>.azurewebsites.net. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  functionAppUrl: unknown;

  /**
   * Function or Host key for Azure Function App.
   */
  functionKey?: SecretBase;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;

  /**
   * Allowed token audiences for azure function. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceId?: unknown;

  /**
   * Type of authentication (Required to specify MSI) used to connect to AzureFunction. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authentication?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionString: unknown;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: AzureKeyVaultSecretReference;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;
}

/**
 * Snowflake linked service.
 */
model SnowflakeV2LinkedService extends LinkedService {
  /**
   * Snowflake linked service properties.
   */
  typeProperties: SnowflakeLinkedV2ServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "SnowflakeV2";
}

/**
 * Snowflake linked service properties.
 */
model SnowflakeLinkedV2ServiceTypeProperties {
  /**
   * The account identifier of your Snowflake account, e.g. xy12345.east-us-2.azure
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accountIdentifier: unknown;

  /**
   * The name of the Snowflake user.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  user?: unknown;

  /**
   * The Azure key vault secret reference of password in connection string.
   */
  password?: SecretBase;

  /**
   * The name of the Snowflake database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database: unknown;

  /**
   * The name of the Snowflake warehouse.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  warehouse: unknown;

  /**
   * The type used for authentication. Type: string.
   */
  authenticationType?: SnowflakeAuthenticationType = SnowflakeAuthenticationType.Basic;

  /**
   * The client ID of the application registered in Azure Active Directory for AADServicePrincipal authentication.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: unknown;

  /**
   * The Azure key vault secret reference of client secret for AADServicePrincipal authentication.
   */
  clientSecret?: SecretBase;

  /**
   * The tenant ID of the application registered in Azure Active Directory for AADServicePrincipal authentication.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenantId?: unknown;

  /**
   * The scope of the application registered in Azure Active Directory for AADServicePrincipal authentication.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  scope?: unknown;

  /**
   * The Azure key vault secret reference of privateKey for KeyPair auth.
   */
  privateKey?: SecretBase;

  /**
   * The Azure key vault secret reference of private key password for KeyPair auth with encrypted private key.
   */
  privateKeyPassphrase?: SecretBase;

  /**
   * The default access control role to use in the Snowflake session. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  role?: unknown;

  /**
   * The host name of the Snowflake account. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  host?: unknown;

  /**
   * Schema name for connection. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schema?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * Indicates whether to use UTC timezone for timestamp data types. Type: boolean.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useUtcTimestamps?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  siteUrl: unknown;

  /**
   * The tenant ID under which your application resides. You can find it from Azure portal Active Directory overview page. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenantId: unknown;

  /**
   * The application (client) ID of your application registered in Azure Active Directory. Make sure to grant SharePoint site permission to this application. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId: unknown;

  /**
   * The client secret of your application registered in Azure Active Directory. Type: string (or Expression with resultType string).
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalCredentialType?: unknown;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endpoint: unknown;

  /**
   * Required to specify MSI, if using system assigned managed identity as authentication method. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authentication?: unknown;

  /**
   * The resource ID of the Synapse workspace. The format should be: /subscriptions/{subscriptionID}/resourceGroups/{resourceGroup}/providers/Microsoft.Synapse/workspaces/{workspaceName}. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  workspaceResourceId?: unknown;
}

/**
 * Microsoft Fabric Lakehouse linked service.
 */
model LakeHouseLinkedService extends LinkedService {
  /**
   * Microsoft Fabric Lakehouse linked service properties.
   */
  typeProperties: LakeHouseLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Lakehouse";
}

/**
 * Microsoft Fabric Lakehouse linked service properties.
 */
model LakeHouseLinkedServiceTypeProperties {
  /**
   * The ID of Microsoft Fabric workspace. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  workspaceId?: unknown;

  /**
   * The ID of Microsoft Fabric Lakehouse artifact. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  artifactId?: unknown;

  /**
   * The authentication type to use.
   */
  authenticationType?: LakehouseAuthenticationType;

  /**
   * The ID of the application used to authenticate against Microsoft Fabric Lakehouse. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The Key of the application used to authenticate against Microsoft Fabric Lakehouse.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalCredentialType?: unknown;

  /**
   * The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.
   */
  servicePrincipalCredential?: SecretBase;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * Linked service for Salesforce V2.
 */
model SalesforceV2LinkedService extends LinkedService {
  /**
   * Salesforce V2 linked service properties.
   */
  typeProperties: SalesforceV2LinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "SalesforceV2";
}

/**
 * Salesforce V2 linked service properties.
 */
model SalesforceV2LinkedServiceTypeProperties {
  /**
   * The URL of Salesforce instance. For example, 'https://[domain].my.salesforce.com'. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  environmentUrl?: unknown;

  /**
   * The authentication type to be used to connect to the Salesforce. Currently, we only support OAuth2ClientCredentials, it is also the default value
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authenticationType?: unknown;

  /**
   * The client Id for OAuth 2.0 Client Credentials Flow authentication of the Salesforce instance. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: unknown;

  /**
   * The client secret for OAuth 2.0 Client Credentials Flow authentication of the Salesforce instance.
   */
  clientSecret?: SecretBase;

  /**
   * The Salesforce API version used in ADF. The version must be larger than or equal to 47.0 which is required by Salesforce BULK API 2.0. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  apiVersion?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;
}

/**
 * Linked service for Salesforce Service Cloud V2.
 */
model SalesforceServiceCloudV2LinkedService extends LinkedService {
  /**
   * Salesforce Service Cloud V2 linked service properties.
   */
  typeProperties: SalesforceServiceCloudV2LinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "SalesforceServiceCloudV2";
}

/**
 * Salesforce Service Cloud V2 linked service properties.
 */
model SalesforceServiceCloudV2LinkedServiceTypeProperties {
  /**
   * The URL of Salesforce Service Cloud instance. For example, 'https://[domain].my.salesforce.com'. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  environmentUrl?: unknown;

  /**
   * The authentication type to be used to connect to the Salesforce. Currently, we only support OAuth2ClientCredentials, it is also the default value
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authenticationType?: unknown;

  /**
   * The client Id for OAuth 2.0 Client Credentials Flow authentication of the Salesforce instance. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: unknown;

  /**
   * The client secret for OAuth 2.0 Client Credentials Flow authentication of the Salesforce instance.
   */
  clientSecret?: SecretBase;

  /**
   * The Salesforce API version used in ADF. The version must be larger than or equal to 47.0 which is required by Salesforce BULK API 2.0. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  apiVersion?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;
}

/**
 * Microsoft Fabric Warehouse linked service.
 */
model WarehouseLinkedService extends LinkedService {
  /**
   * Microsoft Fabric Warehouse linked service properties.
   */
  typeProperties: WarehouseLinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "Warehouse";
}

/**
 * Microsoft Fabric Warehouse linked service properties.
 */
model WarehouseLinkedServiceTypeProperties {
  /**
   * The ID of Microsoft Fabric Warehouse artifact. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  artifactId: unknown;

  /**
   * The endpoint of Microsoft Fabric Warehouse server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endpoint: unknown;

  /**
   * The ID of Microsoft Fabric workspace. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  workspaceId?: unknown;

  /**
   * The authentication type to use.
   */
  authenticationType?: WarehouseAuthenticationType;

  /**
   * The ID of the application used to authenticate against Microsoft Fabric Warehouse. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The Key of the application used to authenticate against Microsoft Fabric Warehouse.
   */
  servicePrincipalKey?: SecretBase;

  /**
   * The name or ID of the tenant to which the service principal belongs. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;

  /**
   * The service principal credential type to use in Server-To-Server authentication. 'ServicePrincipalKey' for key/secret, 'ServicePrincipalCert' for certificate. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalCredentialType?: unknown;

  /**
   * The credential of the service principal object in Azure Active Directory. If servicePrincipalCredentialType is 'ServicePrincipalKey', servicePrincipalCredential can be SecureString or AzureKeyVaultSecretReference. If servicePrincipalCredentialType is 'ServicePrincipalCert', servicePrincipalCredential can only be AzureKeyVaultSecretReference.
   */
  servicePrincipalCredential?: SecretBase;

  /**
   * The credential reference containing authentication information.
   */
  credential?: CredentialReference;
}

/**
 * ServiceNowV2 server linked service.
 */
model ServiceNowV2LinkedService extends LinkedService {
  /**
   * ServiceNowV2 server linked service properties.
   */
  typeProperties: ServiceNowV2LinkedServiceTypeProperties;

  /**
   * Type of linked service.
   */
  type: "ServiceNowV2";
}

/**
 * ServiceNowV2 server linked service properties.
 */
model ServiceNowV2LinkedServiceTypeProperties {
  /**
   * The endpoint of the ServiceNowV2 server. (i.e. <instance>.service-now.com)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endpoint: unknown;

  /**
   * The authentication type to use.
   */
  authenticationType: ServiceNowV2AuthenticationType;

  /**
   * The user name used to connect to the ServiceNowV2 server for Basic and OAuth2 authentication.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * The password corresponding to the user name for Basic and OAuth2 authentication.
   */
  password?: SecretBase;

  /**
   * The client id for OAuth2 authentication.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: unknown;

  /**
   * The client secret for OAuth2 authentication.
   */
  clientSecret?: SecretBase;

  /**
   * GrantType for OAuth2 authentication. Default value is password.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  grantType?: unknown;

  /**
   * The encrypted credential used for authentication. Credentials are encrypted using the integration runtime credential manager. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encryptedCredential?: string;
}

/**
 * Base class for all control activities like IfCondition, ForEach , Until.
 */
model ControlActivity is Activity;

/**
 * Base class for all execution activities.
 */
model ExecutionActivity is Activity {
  ...ExecutionActivityProperties;
}

alias ExecutionActivityProperties = {
  /**
   * Linked service reference.
   */
  linkedServiceName?: LinkedServiceReference;

  /**
   * Activity policy.
   */
  policy?: ActivityPolicy;
};
/**
 * Execution policy for an activity.
 */
model ActivityPolicy {
  ...Record<unknown>;

  /**
   * Specifies the timeout for the activity to run. The default timeout is 7 days. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeout?: unknown;

  /**
   * Maximum ordinary retry attempts. Default is 0. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  retry?: unknown;

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
model StoreReadSettings {
  ...Record<unknown>;

  /**
   * The read setting type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;

  /**
   * The maximum concurrent connection count for the source data store. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxConcurrentConnections?: unknown;

  /**
   * If true, disable data store metrics collection. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disableMetricsCollection?: unknown;
}

/**
 * Azure blob read settings.
 */
model AzureBlobStorageReadSettings extends StoreReadSettings {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

  /**
   * Azure blob wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFolderPath?: unknown;

  /**
   * Azure blob wildcardFileName. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFileName?: unknown;

  /**
   * The prefix filter for the Azure Blob name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  prefix?: unknown;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileListPath?: unknown;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enablePartitionDiscovery?: unknown;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionRootPath?: unknown;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteFilesAfterCompletion?: unknown;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeStart?: unknown;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeEnd?: unknown;

  /**
   * The read setting type.
   */
  type: "AzureBlobStorageReadSettings";
}

/**
 * Azure blobFS read settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureBlobFSReadSettings extends StoreReadSettings {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

  /**
   * Azure blobFS wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFolderPath?: unknown;

  /**
   * Azure blobFS wildcardFileName. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFileName?: unknown;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileListPath?: unknown;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enablePartitionDiscovery?: unknown;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionRootPath?: unknown;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteFilesAfterCompletion?: unknown;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeStart?: unknown;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeEnd?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

  /**
   * ADLS wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFolderPath?: unknown;

  /**
   * ADLS wildcardFileName. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFileName?: unknown;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileListPath?: unknown;

  /**
   * Lists files after the value (exclusive) based on file/folder names’ lexicographical order. Applies under the folderPath in data set, and filter files/sub-folders under the folderPath. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listAfter?: unknown;

  /**
   * Lists files before the value (inclusive) based on file/folder names’ lexicographical order. Applies under the folderPath in data set, and filter files/sub-folders under the folderPath. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listBefore?: unknown;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enablePartitionDiscovery?: unknown;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionRootPath?: unknown;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteFilesAfterCompletion?: unknown;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeStart?: unknown;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeEnd?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

  /**
   * AmazonS3 wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFolderPath?: unknown;

  /**
   * AmazonS3 wildcardFileName. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFileName?: unknown;

  /**
   * The prefix filter for the S3 object name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  prefix?: unknown;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileListPath?: unknown;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enablePartitionDiscovery?: unknown;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionRootPath?: unknown;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteFilesAfterCompletion?: unknown;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeStart?: unknown;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeEnd?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

  /**
   * FileServer wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFolderPath?: unknown;

  /**
   * FileServer wildcardFileName. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFileName?: unknown;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileListPath?: unknown;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enablePartitionDiscovery?: unknown;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionRootPath?: unknown;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteFilesAfterCompletion?: unknown;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeStart?: unknown;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeEnd?: unknown;

  /**
   * Specify a filter to be used to select a subset of files in the folderPath rather than all files. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileFilter?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

  /**
   * Azure File Storage wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFolderPath?: unknown;

  /**
   * Azure File Storage wildcardFileName. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFileName?: unknown;

  /**
   * The prefix filter for the Azure File name starting from root path. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  prefix?: unknown;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileListPath?: unknown;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enablePartitionDiscovery?: unknown;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionRootPath?: unknown;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteFilesAfterCompletion?: unknown;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeStart?: unknown;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeEnd?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  operationTimeout?: unknown;

  /**
   * Upload to temporary file(s) and rename. Disable this option if your SFTP server doesn't support rename operation. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useTempFileRename?: unknown;

  /**
   * The write setting type.
   */
  type: "SftpWriteSettings";
}

/**
 * Connector write settings.
 */
@discriminator("type")
model StoreWriteSettings {
  ...Record<unknown>;

  /**
   * The write setting type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;

  /**
   * The maximum concurrent connection count for the source data store. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxConcurrentConnections?: unknown;

  /**
   * If true, disable data store metrics collection. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disableMetricsCollection?: unknown;

  /**
   * The type of copy behavior for copy sink.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  copyBehavior?: unknown;

  /**
   * Specify the custom metadata to be added to sink data. Type: array of objects (or Expression with resultType array of objects).
   */
  @identifiers(#["name"])
  metadata?: MetadataItem[];
}

/**
 * Specify the name and value of custom metadata item.
 */
model MetadataItem {
  /**
   * Metadata item key name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: unknown;

  /**
   * Metadata item value. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: unknown;
}

/**
 * Amazon S3 Compatible read settings.
 */
model AmazonS3CompatibleReadSettings extends StoreReadSettings {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

  /**
   * Amazon S3 Compatible wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFolderPath?: unknown;

  /**
   * Amazon S3 Compatible wildcardFileName. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFileName?: unknown;

  /**
   * The prefix filter for the S3 Compatible object name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  prefix?: unknown;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileListPath?: unknown;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enablePartitionDiscovery?: unknown;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionRootPath?: unknown;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteFilesAfterCompletion?: unknown;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeStart?: unknown;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeEnd?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

  /**
   * Oracle Cloud Storage wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFolderPath?: unknown;

  /**
   * Oracle Cloud Storage wildcardFileName. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFileName?: unknown;

  /**
   * The prefix filter for the Oracle Cloud Storage object name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  prefix?: unknown;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileListPath?: unknown;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enablePartitionDiscovery?: unknown;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionRootPath?: unknown;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteFilesAfterCompletion?: unknown;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeStart?: unknown;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeEnd?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

  /**
   * Google Cloud Storage wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFolderPath?: unknown;

  /**
   * Google Cloud Storage wildcardFileName. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFileName?: unknown;

  /**
   * The prefix filter for the Google Cloud Storage object name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  prefix?: unknown;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileListPath?: unknown;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enablePartitionDiscovery?: unknown;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionRootPath?: unknown;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteFilesAfterCompletion?: unknown;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeStart?: unknown;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeEnd?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

  /**
   * Ftp wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFolderPath?: unknown;

  /**
   * Ftp wildcardFileName. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFileName?: unknown;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enablePartitionDiscovery?: unknown;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionRootPath?: unknown;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteFilesAfterCompletion?: unknown;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileListPath?: unknown;

  /**
   * Specify whether to use binary transfer mode for FTP stores. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useBinaryTransfer?: unknown;

  /**
   * If true, disable parallel reading within each file. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disableChunking?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

  /**
   * Sftp wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFolderPath?: unknown;

  /**
   * Sftp wildcardFileName. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFileName?: unknown;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enablePartitionDiscovery?: unknown;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionRootPath?: unknown;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileListPath?: unknown;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteFilesAfterCompletion?: unknown;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeStart?: unknown;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeEnd?: unknown;

  /**
   * If true, disable parallel reading within each file. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disableChunking?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requestMethod?: unknown;

  /**
   * The HTTP request body to the RESTful API if requestMethod is POST. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requestBody?: unknown;

  /**
   * The additional HTTP headers in the request to the RESTful API. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalHeaders?: unknown;

  /**
   * Specifies the timeout for a HTTP client to get HTTP response from HTTP server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requestTimeout?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

  /**
   * HDFS wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFolderPath?: unknown;

  /**
   * HDFS wildcardFileName. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFileName?: unknown;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileListPath?: unknown;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enablePartitionDiscovery?: unknown;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionRootPath?: unknown;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeStart?: unknown;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeEnd?: unknown;

  /**
   * Specifies Distcp-related settings.
   */
  distcpSettings?: DistcpSettings;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteFilesAfterCompletion?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceManagerEndpoint: unknown;

  /**
   * Specifies an existing folder path which will be used to store temp Distcp command script. The script file is generated by ADF and will be removed after Copy job finished. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tempScriptPath: unknown;

  /**
   * Specifies the Distcp options. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  distcpOptions?: unknown;
}

/**
 * Microsoft Fabric Lakehouse Files read settings.
 */
model LakeHouseReadSettings extends StoreReadSettings {
  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

  /**
   * Microsoft Fabric Lakehouse Files wildcardFolderPath. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFolderPath?: unknown;

  /**
   * Microsoft Fabric Lakehouse Files wildcardFileName. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wildcardFileName?: unknown;

  /**
   * Point to a text file that lists each file (relative path to the path configured in the dataset) that you want to copy. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileListPath?: unknown;

  /**
   * Indicates whether to enable partition discovery. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enablePartitionDiscovery?: unknown;

  /**
   * Specify the root path where partition discovery starts from. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionRootPath?: unknown;

  /**
   * Indicates whether the source files need to be deleted after copy completion. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteFilesAfterCompletion?: unknown;

  /**
   * The start of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeStart?: unknown;

  /**
   * The end of file's modified datetime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modifiedDatetimeEnd?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  blockSizeInMB?: unknown;

  /**
   * The write setting type.
   */
  type: "AzureBlobStorageWriteSettings";
}

/**
 * Azure blobFS write settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureBlobFSWriteSettings extends StoreWriteSettings {
  /**
   * Indicates the block size(MB) when writing data to blob. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  blockSizeInMB?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  expiryDateTime?: unknown;

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
 * Microsoft Fabric Lakehouse Files write settings.
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
model FormatReadSettings {
  ...Record<unknown>;

  /**
   * The read setting type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;
}

/**
 * Compression read settings.
 */
@discriminator("type")
model CompressionReadSettings {
  ...Record<unknown>;

  /**
   * The Compression setting type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;
}

/**
 * The ZipDeflate compression read settings.
 */
model ZipDeflateReadSettings extends CompressionReadSettings {
  /**
   * Preserve the zip file name as folder path. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preserveZipFileNameAsFolder?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preserveCompressionFileNameAsFolder?: unknown;

  /**
   * The Compression setting type.
   */
  type: "TarReadSettings";
}

/**
 * The TarGZip compression read settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TarGZipReadSettings extends CompressionReadSettings {
  /**
   * Preserve the compression file name as folder path. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preserveCompressionFileNameAsFolder?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  skipLineCount?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  validationMode?: unknown;

  /**
   * Indicates whether type detection is enabled when reading the xml files. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  detectDataType?: unknown;

  /**
   * Indicates whether namespace is enabled when reading the xml files. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  namespaces?: unknown;

  /**
   * Namespace uri to prefix mappings to override the prefixes in column names when namespace is enabled, if no prefix is defined for a namespace uri, the prefix of xml element/attribute name in the xml data file will be used. Example: "{"http://www.example.com/xml":"prefix"}" Type: object (or Expression with resultType object).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  namespacePrefixes?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: "BinaryReadSettings";
}

/**
 * Format write settings.
 */
@discriminator("type")
model FormatWriteSettings {
  ...Record<unknown>;

  /**
   * The write setting type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;
}

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxRowsPerFile?: unknown;

  /**
   * Specifies the file name pattern <fileNamePrefix>_<fileIndex>.<fileExtension> when copy from non-file based store without partitionOptions. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileNamePrefix?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxRowsPerFile?: unknown;

  /**
   * Specifies the file name pattern <fileNamePrefix>_<fileIndex>.<fileExtension> when copy from non-file based store without partitionOptions. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileNamePrefix?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxRowsPerFile?: unknown;

  /**
   * Specifies the file name pattern <fileNamePrefix>_<fileIndex>.<fileExtension> when copy from non-file based store without partitionOptions. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileNamePrefix?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  quoteAllText?: unknown;

  /**
   * The file extension used to create the files. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileExtension: unknown;

  /**
   * Limit the written file's row count to be smaller than or equal to the specified count. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxRowsPerFile?: unknown;

  /**
   * Specifies the file name pattern <fileNamePrefix>_<fileIndex>.<fileExtension> when copy from non-file based store without partitionOptions. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileNamePrefix?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  filePattern?: unknown;

  /**
   * The write setting type.
   */
  type: "JsonWriteSettings";
}

/**
 * Iceberg write settings.
 */
model IcebergWriteSettings extends FormatWriteSettings {
  /**
   * The write setting type.
   */
  type: "IcebergWriteSettings";
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

  /**
   * Copy source type.
   */
  type: "AvroSource";
}

/**
 * A copy activity source.
 */
@discriminator("type")
model CopySource {
  ...Record<unknown>;

  /**
   * Copy source type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;

  /**
   * Source retry count. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceRetryCount?: unknown;

  /**
   * Source retry wait. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceRetryWait?: unknown;

  /**
   * The maximum concurrent connection count for the source data store. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxConcurrentConnections?: unknown;

  /**
   * If true, disable data store metrics collection. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disableMetricsCollection?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
model CopySink {
  ...Record<unknown>;

  /**
   * Copy sink type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;

  /**
   * Write batch size. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  writeBatchSize?: unknown;

  /**
   * Write batch timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  writeBatchTimeout?: unknown;

  /**
   * Sink retry count. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sinkRetryCount?: unknown;

  /**
   * Sink retry wait. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sinkRetryWait?: unknown;

  /**
   * The maximum concurrent connection count for the sink data store. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxConcurrentConnections?: unknown;

  /**
   * If true, disable data store metrics collection. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disableMetricsCollection?: unknown;
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
#suppress "@azure-tools/typespec-client-generator-core/legacy-hierarchy-building-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ExecutionActivity)
model CopyActivity extends Activity {
  ...ExecutionActivityProperties;

  /**
   * Copy activity properties.
   */
  typeProperties: CopyActivityTypeProperties;

  /**
   * List of inputs for the activity.
   */
  @identifiers(#["referenceName"])
  inputs?: DatasetReference[];

  /**
   * List of outputs for the activity.
   */
  @identifiers(#["referenceName"])
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  translator?: unknown;

  /**
   * Specifies whether to copy data via an interim staging. Default value is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableStaging?: unknown;

  /**
   * Specifies interim staging settings when EnableStaging is true.
   */
  stagingSettings?: StagingSettings;

  /**
   * Maximum number of concurrent sessions opened on the source or sink to avoid overloading the data store. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parallelCopies?: unknown;

  /**
   * Maximum number of data integration units that can be used to perform this data movement. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataIntegrationUnits?: unknown;

  /**
   * Whether to skip incompatible row. Default value is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableSkipIncompatibleRow?: unknown;

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
  preserveRules?: unknown[];

  /**
   * Preserve rules.
   */
  preserve?: unknown[];

  /**
   * Whether to enable Data Consistency validation. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  validateDataConsistency?: unknown;

  /**
   * Specify the fault tolerance for data consistency.
   */
  skipErrorFile?: SkipErrorFile;
}

/**
 * Staging settings.
 */
model StagingSettings {
  ...Record<unknown>;

  /**
   * Staging linked service reference.
   */
  linkedServiceName: LinkedServiceReference;

  /**
   * The path to storage for storing the interim data. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  path?: unknown;

  /**
   * Specifies whether to use compression when copying data via an interim staging. Default value is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableCompression?: unknown;
}

/**
 * Redirect incompatible row settings
 */
model RedirectIncompatibleRowSettings {
  ...Record<unknown>;

  /**
   * Name of the Azure Storage, Storage SAS, or Azure Data Lake Store linked service used for redirecting incompatible row. Must be specified if redirectIncompatibleRowSettings is specified. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  linkedServiceName: unknown;

  /**
   * The path for storing the redirect incompatible row data. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  path?: unknown;
}

/**
 * (Deprecated. Please use LogSettings) Log storage settings.
 */
model LogStorageSettings {
  ...Record<unknown>;

  /**
   * Log storage linked service reference.
   */
  linkedServiceName: LinkedServiceReference;

  /**
   * The path to storage for storing detailed logs of activity execution. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  path?: unknown;

  /**
   * Gets or sets the log level, support: Info, Warning. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  logLevel?: unknown;

  /**
   * Specifies whether to enable reliable logging. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableReliableLogging?: unknown;
}

/**
 * Log settings.
 */
model LogSettings {
  /**
   * Specifies whether to enable copy activity log. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableCopyActivityLog?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  logLevel?: unknown;

  /**
   * Specifies whether to enable reliable logging. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableReliableLogging?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  path?: unknown;
}

/**
 * Skip error file.
 */
model SkipErrorFile {
  /**
   * Skip if file is deleted by other client during copy. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileMissing?: unknown;

  /**
   * Skip if source/sink file changed by other concurrent write. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataInconsistency?: unknown;
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
model TabularSource is CopySource {
  ...TabularSourceProperties;
}

alias TabularSourceProperties = {
  /**
   * Query timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  queryTimeout?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;
};

/**
 * A copy activity Azure Table source.
 */
#suppress "@azure-tools/typespec-client-generator-core/legacy-hierarchy-building-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(TabularSource)
model AzureTableSource extends CopySource {
  ...TabularSourceProperties;

  /**
   * Azure Table source query. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureTableSourceQuery?: unknown;

  /**
   * Azure Table source ignore table not found. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureTableSourceIgnoreTableNotFound?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  treatEmptyAsNull?: unknown;

  /**
   * Number of header lines to skip from each blob. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  skipHeaderLineCount?: unknown;

  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Nested properties separator. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  nestingSeparator?: unknown;

  /**
   * Query timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  queryTimeout?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Page size of the result. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  pageSize?: unknown;

  /**
   * Preferred regions. Type: array of strings (or Expression with resultType array of strings).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preferredRegions?: unknown;

  /**
   * Whether detect primitive values as datetime values. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  detectDatetime?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Copy source type.
   */
  type: "PostgreSqlSource";
}

/**
 * A copy activity source for PostgreSQL databases.
 */
model PostgreSqlV2Source extends TabularSource {
  /**
   * Database query. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Copy source type.
   */
  type: "PostgreSqlV2Source";
}

/**
 * A copy activity source for Sybase databases.
 */
model SybaseSource extends TabularSource {
  /**
   * Database query. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Copy source type.
   */
  type: "SapBwSource";
}

/**
 * A copy activity source for OData source.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ODataSource extends CopySource {
  /**
   * OData query. For example, "$top=1". Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:05:00. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpRequestTimeout?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * The read behavior for the operation. Default is Query. Allowed values: Query/QueryAll. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  readBehavior?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * The read behavior for the operation. Default is Query. Allowed values: Query/QueryAll. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  readBehavior?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:05:00. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpRequestTimeout?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:05:00. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpRequestTimeout?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * The packet size of data read from SAP HANA. Type: integer(or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  packetSize?: unknown;

  /**
   * The partition mechanism that will be used for SAP HANA read in parallel. Possible values include: "None", "PhysicalPartitionsOfTable", "SapHanaDynamicRange".
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionOption?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionColumnName?: unknown;
}

/**
 * A copy activity source for SAP Business Warehouse Open Hub Destination source.
 */
model SapOpenHubSource extends TabularSource {
  /**
   * Whether to exclude the records of the last request. The default value is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  excludeLastRequest?: unknown;

  /**
   * The ID of request for delta loading. Once it is set, only data with requestId larger than the value of this property will be retrieved. The default value is 0. Type: integer (or Expression with resultType integer ).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  baseRequestId?: unknown;

  /**
   * Specifies the custom RFC function module that will be used to read data from SAP Table. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customRfcReadTableFunctionModule?: unknown;

  /**
   * The single character that will be used as delimiter passed to SAP RFC as well as splitting the output data retrieved. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sapDataColumnDelimiter?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extractionMode?: unknown;

  /**
   * The subscriber process to manage the delta process. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriberProcess?: unknown;

  /**
   * Specifies the selection conditions from source data. Type: array of objects(selection) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  selection?: unknown;

  /**
   * Specifies the columns to be selected from source data. Type: array of objects(projection) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `projection`?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rowCount?: unknown;

  /**
   * The number of rows that will be skipped. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rowSkips?: unknown;

  /**
   * The fields of the SAP table that will be retrieved. For example, column0, column1. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rfcTableFields?: unknown;

  /**
   * The options for the filtering of the SAP Table. For example, COLUMN0 EQ SOME VALUE. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rfcTableOptions?: unknown;

  /**
   * Specifies the maximum number of rows that will be retrieved at a time when retrieving data from SAP Table. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  batchSize?: unknown;

  /**
   * Specifies the custom RFC function module that will be used to read data from SAP Table. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customRfcReadTableFunctionModule?: unknown;

  /**
   * The single character that will be used as delimiter passed to SAP RFC as well as splitting the output data retrieved. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sapDataColumnDelimiter?: unknown;

  /**
   * The partition mechanism that will be used for SAP table read in parallel. Possible values include: "None", "PartitionOnInt", "PartitionOnCalendarYear", "PartitionOnCalendarMonth", "PartitionOnCalendarDate", "PartitionOnTime".
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionOption?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionColumnName?: unknown;

  /**
   * The maximum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionUpperBound?: unknown;

  /**
   * The minimum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionLowerBound?: unknown;

  /**
   * The maximum value of partitions the table will be split into. Type: integer (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxPartitionsNumber?: unknown;
}

/**
 * A copy activity Rest service Sink.
 */
model RestSink extends CopySink {
  /**
   * The HTTP method used to call the RESTful API. The default is POST. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requestMethod?: unknown;

  /**
   * The additional HTTP headers in the request to the RESTful API. Type: key value pairs (value should be string type).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalHeaders?: unknown;

  /**
   * The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:01:40. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpRequestTimeout?: unknown;

  /**
   * The time to await before sending next request, in milliseconds
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requestInterval?: unknown;

  /**
   * Http Compression Type to Send data in compressed format with Optimal Compression Level, Default is None. And The Only Supported option is Gzip. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpCompressionType?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requestMethod?: unknown;

  /**
   * The HTTP request body to the RESTful API if requestMethod is POST. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requestBody?: unknown;

  /**
   * The additional HTTP headers in the request to the RESTful API. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalHeaders?: unknown;

  /**
   * The pagination rules to compose next page requests. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  paginationRules?: unknown;

  /**
   * The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:01:40. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpRequestTimeout?: unknown;

  /**
   * The time to await before sending next page request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requestInterval?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: key value pairs (value should be string type).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlReaderQuery?: unknown;

  /**
   * Name of the stored procedure for a SQL Database source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlReaderStoredProcedureName?: unknown;

  /**
   * Value and type setting for stored procedure parameters. Example: "{Parameter1: {value: "1", type: "int"}}".
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storedProcedureParameters?: unknown;

  /**
   * Specifies the transaction locking behavior for the SQL source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isolationLevel?: unknown;

  /**
   * The partition mechanism that will be used for Sql read in parallel. Possible values include: "None", "PhysicalPartitionsOfTable", "DynamicRange". Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionOption?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionColumnName?: unknown;

  /**
   * The maximum value of the partition column for partition range splitting. This value is used to decide the partition stride, not for filtering the rows in table. All rows in the table or query result will be partitioned and copied. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionUpperBound?: unknown;

  /**
   * The minimum value of the partition column for partition range splitting. This value is used to decide the partition stride, not for filtering the rows in table. All rows in the table or query result will be partitioned and copied. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionLowerBound?: unknown;
}

/**
 * A copy activity SQL server source.
 */
model SqlServerSource extends TabularSource {
  /**
   * SQL reader query. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlReaderQuery?: unknown;

  /**
   * Name of the stored procedure for a SQL Database source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlReaderStoredProcedureName?: unknown;

  /**
   * Value and type setting for stored procedure parameters. Example: "{Parameter1: {value: "1", type: "int"}}".
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storedProcedureParameters?: unknown;

  /**
   * Specifies the transaction locking behavior for the SQL source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isolationLevel?: unknown;

  /**
   * Which additional types to produce.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  produceAdditionalTypes?: unknown;

  /**
   * The partition mechanism that will be used for Sql read in parallel. Possible values include: "None", "PhysicalPartitionsOfTable", "DynamicRange". Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionOption?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlReaderQuery?: unknown;

  /**
   * Name of the stored procedure for a SQL Database source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlReaderStoredProcedureName?: unknown;

  /**
   * Value and type setting for stored procedure parameters. Example: "{Parameter1: {value: "1", type: "int"}}".
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storedProcedureParameters?: unknown;

  /**
   * Specifies the transaction locking behavior for the SQL source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isolationLevel?: unknown;

  /**
   * Which additional types to produce.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  produceAdditionalTypes?: unknown;

  /**
   * The partition mechanism that will be used for Sql read in parallel. Possible values include: "None", "PhysicalPartitionsOfTable", "DynamicRange".
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionOption?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlReaderQuery?: unknown;

  /**
   * Name of the stored procedure for a SQL Database source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlReaderStoredProcedureName?: unknown;

  /**
   * Value and type setting for stored procedure parameters. Example: "{Parameter1: {value: "1", type: "int"}}".
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storedProcedureParameters?: unknown;

  /**
   * Specifies the transaction locking behavior for the SQL source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isolationLevel?: unknown;

  /**
   * Which additional types to produce.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  produceAdditionalTypes?: unknown;

  /**
   * The partition mechanism that will be used for Sql read in parallel. Possible values include: "None", "PhysicalPartitionsOfTable", "DynamicRange". Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionOption?: unknown;

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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlMISource extends TabularSource {
  /**
   * SQL reader query. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlReaderQuery?: unknown;

  /**
   * Name of the stored procedure for a Azure SQL Managed Instance source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlReaderStoredProcedureName?: unknown;

  /**
   * Value and type setting for stored procedure parameters. Example: "{Parameter1: {value: "1", type: "int"}}".
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storedProcedureParameters?: unknown;

  /**
   * Specifies the transaction locking behavior for the SQL source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isolationLevel?: unknown;

  /**
   * Which additional types to produce.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  produceAdditionalTypes?: unknown;

  /**
   * The partition mechanism that will be used for Sql read in parallel. Possible values include: "None", "PhysicalPartitionsOfTable", "DynamicRange". Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionOption?: unknown;

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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlDWSource extends TabularSource {
  /**
   * SQL Data Warehouse reader query. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlReaderQuery?: unknown;

  /**
   * Name of the stored procedure for a SQL Data Warehouse source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlReaderStoredProcedureName?: unknown;

  /**
   * Value and type setting for stored procedure parameters. Example: "{Parameter1: {value: "1", type: "int"}}". Type: object (or Expression with resultType object), itemType: StoredProcedureParameter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storedProcedureParameters?: unknown;

  /**
   * Specifies the transaction locking behavior for the SQL source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isolationLevel?: unknown;

  /**
   * The partition mechanism that will be used for Sql read in parallel. Possible values include: "None", "PhysicalPartitionsOfTable", "DynamicRange". Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionOption?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query: unknown;

  /**
   * The name of the Boolean option that controls whether truncation is applied to result-sets that go beyond a certain row-count limit.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  noTruncation?: unknown;

  /**
   * Query timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9]))..
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  queryTimeout?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  oracleReaderQuery?: unknown;

  /**
   * Query timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  queryTimeout?: unknown;

  /**
   * The partition mechanism that will be used for Oracle read in parallel. Possible values include: "None", "PhysicalPartitionsOfTable", "DynamicRange".
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionOption?: unknown;

  /**
   * The settings that will be leveraged for Oracle source partitioning.
   */
  partitionSettings?: OraclePartitionSettings;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

  /**
   * The decimal precision used to represent Oracle NUMBER type without precision and scale. The range is 1 to 256 and default value is 256 if not specified. Type: integer (or Expression with resultType integer). Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  numberPrecision?: unknown;

  /**
   * The decimal scale used to represent Oracle NUMBER type without precision and scale. The range is 0 to 130 and default value is 130 if not specified. Type: integer (or Expression with resultType integer). Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  numberScale?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionNames?: unknown;

  /**
   * The name of the column in integer type that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionColumnName?: unknown;

  /**
   * The maximum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionUpperBound?: unknown;

  /**
   * The minimum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionLowerBound?: unknown;
}

/**
 * A copy activity AmazonRdsForOracle source.
 */
model AmazonRdsForOracleSource extends CopySource {
  /**
   * AmazonRdsForOracle reader query. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  oracleReaderQuery?: unknown;

  /**
   * Query timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  queryTimeout?: unknown;

  /**
   * The partition mechanism that will be used for AmazonRdsForOracle read in parallel. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionOption?: unknown;

  /**
   * The settings that will be leveraged for AmazonRdsForOracle source partitioning.
   */
  partitionSettings?: AmazonRdsForOraclePartitionSettings;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

  /**
   * The decimal precision used to represent Oracle NUMBER type without precision and scale. The range is 1 to 256 and default value is 256 if not specified. Type: integer (or Expression with resultType integer). Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  numberPrecision?: unknown;

  /**
   * The decimal scale used to represent Oracle NUMBER type without precision and scale. The range is 0 to 130 and default value is 130 if not specified. Type: integer (or Expression with resultType integer). Only used for Version 2.0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  numberScale?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionNames?: unknown;

  /**
   * The name of the column in integer type that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionColumnName?: unknown;

  /**
   * The maximum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionUpperBound?: unknown;

  /**
   * The minimum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionLowerBound?: unknown;
}

/**
 * A copy activity Teradata source.
 */
model TeradataSource extends TabularSource {
  /**
   * Teradata query. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * The partition mechanism that will be used for teradata read in parallel. Possible values include: "None", "Hash", "DynamicRange".
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionOption?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionColumnName?: unknown;

  /**
   * The maximum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionUpperBound?: unknown;

  /**
   * The minimum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionLowerBound?: unknown;
}

/**
 * A copy activity Teradata sink.
 */
model TeradataSink extends CopySink {
  /**
   * Teradata import settings.
   */
  importSettings?: TeradataImportCommand;

  /**
   * Copy sink type.
   */
  type: "TeradataSink";
}

/**
 * Teradata import command settings.
 */
model TeradataImportCommand extends ImportSettings {
  /**
   * Additional format options for Teradata Copy Command. The format options only applies to direct copy from CSV source. Type: key value pairs (value should be string type) (or Expression with resultType object). Example: "additionalFormatOptions": { "timeFormat": "HHhMImSSs" }
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalFormatOptions?: unknown;

  /**
   * The import setting type.
   */
  type: "TeradataImportCommand";
}

/**
 * Import command settings.
 */
@discriminator("type")
model ImportSettings {
  ...Record<unknown>;

  /**
   * The import setting type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;
}

/**
 * A copy activity source for web page table.
 */
model WebSource extends CopySource {
  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  filter?: unknown;

  /**
   * Cursor methods for Mongodb query
   */
  cursorMethods?: MongoDbCursorMethodsProperties;

  /**
   * Specifies the number of documents to return in each batch of the response from MongoDB Atlas instance. In most cases, modifying the batch size will not affect the user or the application. This property's main purpose is to avoid hit the limitation of response size. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  batchSize?: unknown;

  /**
   * Query timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  queryTimeout?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

  /**
   * Copy source type.
   */
  type: "MongoDbAtlasSource";
}

/**
 * Cursor methods for Mongodb query
 */
model MongoDbCursorMethodsProperties {
  ...Record<unknown>;

  /**
   * Specifies the fields to return in the documents that match the query filter. To return all fields in the matching documents, omit this parameter. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  project?: unknown;

  /**
   * Specifies the order in which the query returns matching documents. Type: string (or Expression with resultType string). Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sort?: unknown;

  /**
   * Specifies the how many documents skipped and where MongoDB begins returning results. This approach may be useful in implementing paginated results. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  skip?: unknown;

  /**
   * Specifies the maximum number of documents the server returns. limit() is analogous to the LIMIT statement in a SQL database. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  limit?: unknown;
}

/**
 * A copy activity source for a MongoDB database.
 */
model MongoDbV2Source extends CopySource {
  /**
   * Specifies selection filter using query operators. To return all documents in a collection, omit this parameter or pass an empty document ({}). Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  filter?: unknown;

  /**
   * Cursor methods for Mongodb query
   */
  cursorMethods?: MongoDbCursorMethodsProperties;

  /**
   * Specifies the number of documents to return in each batch of the response from MongoDB instance. In most cases, modifying the batch size will not affect the user or the application. This property's main purpose is to avoid hit the limitation of response size. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  batchSize?: unknown;

  /**
   * Query timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  queryTimeout?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  filter?: unknown;

  /**
   * Cursor methods for Mongodb query.
   */
  cursorMethods?: MongoDbCursorMethodsProperties;

  /**
   * Specifies the number of documents to return in each batch of the response from MongoDB instance. In most cases, modifying the batch size will not affect the user or the application. This property's main purpose is to avoid hit the limitation of response size. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  batchSize?: unknown;

  /**
   * Query timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  queryTimeout?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowedGroups?: unknown;

  /**
   * The user scope uri. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userScopeFilterUri?: unknown;

  /**
   * The Column to apply the <paramref name="StartTime"/> and <paramref name="EndTime"/>. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dateFilterColumn?: unknown;

  /**
   * Start time of the requested range for this dataset. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  startTime?: unknown;

  /**
   * End time of the requested range for this dataset. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endTime?: unknown;

  /**
   * The columns to be read out from the Office 365 table. Type: array of objects (or Expression with resultType array of objects). itemType: OutputColumn. Example: [ { "name": "Id" }, { "name": "CreatedDateTime" } ]
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  outputColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

  /**
   * Copy source type.
   */
  type: "AzureDataLakeStoreSource";
}

/**
 * A copy activity Azure BlobFS source.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureBlobFSSource extends CopySource {
  /**
   * Treat empty as null. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  treatEmptyAsNull?: unknown;

  /**
   * Number of header lines to skip from each blob. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  skipHeaderLineCount?: unknown;

  /**
   * If true, files under the folder path will be read recursively. Default is true. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpRequestTimeout?: unknown;

  /**
   * Copy source type.
   */
  type: "HttpSource";
}

/**
 * A copy activity Amazon Marketplace Web Service source.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AmazonMWSSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Copy source type.
   */
  type: "AmazonMWSSource";
}

/**
 * A copy activity Azure Database for PostgreSQL source.
 */
model AzurePostgreSqlSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Copy source type.
   */
  type: "AzurePostgreSqlSource";
}

/**
 * A copy activity Azure Database for PostgreSQL sink.
 */
model AzurePostgreSqlSink extends CopySink {
  /**
   * A query to execute before starting the copy. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preCopyScript?: unknown;

  /**
   * The write behavior for the operation. Default is Bulk Insert.
   */
  writeMethod?: AzurePostgreSqlWriteMethodEnum;

  /**
   * Azure Database for PostgreSQL upsert option settings
   */
  upsertSettings?: AzurePostgreSqlSinkUpsertSettings;

  /**
   * Copy sink type.
   */
  type: "AzurePostgreSqlSink";
}

/**
 * Azure Database for PostgreSQL upsert option settings
 */
model AzurePostgreSqlSinkUpsertSettings {
  /**
   * Key column names for unique row identification. Type: array of strings (or Expression with resultType array of strings).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keys?: unknown;
}

/**
 * A copy activity Azure MySql sink.
 */
model AzureMySqlSink extends CopySink {
  /**
   * A query to execute before starting the copy. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preCopyScript?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Copy source type.
   */
  type: "GoogleBigQuerySource";
}

/**
 * A copy activity Google BigQuery service source.
 */
model GoogleBigQueryV2Source extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Copy source type.
   */
  type: "GoogleBigQueryV2Source";
}

/**
 * A copy activity Greenplum Database source.
 */
model GreenplumSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Copy source type.
   */
  type: "GreenplumSource";
}

/**
 * A copy activity HBase server source.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HBaseSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Copy source type.
   */
  type: "MagentoSource";
}

/**
 * A copy activity MariaDB server source.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MariaDBSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Copy source type.
   */
  type: "MariaDBSource";
}

/**
 * A copy activity Azure MariaDB source.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureMariaDBSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * The partition mechanism that will be used for Netezza read in parallel. Possible values include: "None", "DataSlice", "DynamicRange".
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionOption?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionColumnName?: unknown;

  /**
   * The maximum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionUpperBound?: unknown;

  /**
   * The minimum value of column specified in partitionColumnName that will be used for proceeding range partitioning. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionLowerBound?: unknown;
}

/**
 * A copy activity Vertica source.
 */
model VerticaSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Copy source type.
   */
  type: "ResponsysSource";
}

/**
 * A copy activity Dynamics AX source.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DynamicsAXSource extends TabularSource {
  /**
   * A query to retrieve data from source. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * The timeout (TimeSpan) to get an HTTP response. It is the timeout to get a response, not the timeout to read response data. Default value: 00:05:00. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpRequestTimeout?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  bucketName: unknown;
}

/**
 * A copy activity source for Microsoft Fabric Lakehouse Table.
 */
model LakeHouseTableSource extends CopySource {
  /**
   * Query an older snapshot by timestamp. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timestampAsOf?: unknown;

  /**
   * Query an older snapshot by version. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  versionAsOf?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalCopyOptions?: Record<unknown>;

  /**
   * Additional format options directly passed to snowflake Copy Command. Type: key value pairs (value should be string type) (or Expression with resultType object). Example: "additionalFormatOptions": { "OVERWRITE": "TRUE", "MAX_FILE_SIZE": "'FALSE'" }
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalFormatOptions?: Record<unknown>;

  /**
   * The name of the snowflake storage integration to use for the copy operation. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageIntegration?: unknown;

  /**
   * The export setting type.
   */
  type: "SnowflakeExportCopyCommand";
}

/**
 * Export command settings.
 */
@discriminator("type")
model ExportSettings {
  ...Record<unknown>;

  /**
   * The export setting type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;
}

/**
 * A copy activity snowflake source.
 */
model SnowflakeV2Source extends CopySource {
  /**
   * Snowflake Sql query. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * Snowflake export settings.
   */
  exportSettings: SnowflakeExportCopyCommand;

  /**
   * Copy source type.
   */
  type: "SnowflakeV2Source";
}

/**
 * A copy activity Azure Databricks Delta Lake source.
 */
model AzureDatabricksDeltaLakeSource extends CopySource {
  /**
   * Azure Databricks Delta Lake Sql query. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dateFormat?: unknown;

  /**
   * Specify the timestamp format for the csv in Azure Databricks Delta Lake Copy. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timestampFormat?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preCopyScript?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dateFormat?: unknown;

  /**
   * Specify the timestamp format for csv in Azure Databricks Delta Lake Copy. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timestampFormat?: unknown;

  /**
   * The import setting type.
   */
  type: "AzureDatabricksDeltaLakeImportCommand";
}

/**
 * A copy activity Microsoft Fabric Warehouse source.
 */
model WarehouseSource extends TabularSource {
  /**
   * Microsoft Fabric Warehouse reader query. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlReaderQuery?: unknown;

  /**
   * Name of the stored procedure for a Microsoft Fabric Warehouse source. This cannot be used at the same time as SqlReaderQuery. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlReaderStoredProcedureName?: unknown;

  /**
   * Value and type setting for stored procedure parameters. Example: "{Parameter1: {value: "1", type: "int"}}". Type: object (or Expression with resultType object), itemType: StoredProcedureParameter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storedProcedureParameters?: unknown;

  /**
   * Specifies the transaction locking behavior for the Microsoft Fabric Warehouse source. Allowed values: ReadCommitted/ReadUncommitted/RepeatableRead/Serializable/Snapshot. The default value is ReadCommitted. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isolationLevel?: unknown;

  /**
   * The partition mechanism that will be used for Sql read in parallel. Possible values include: "None", "PhysicalPartitionsOfTable", "DynamicRange".
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionOption?: unknown;

  /**
   * The settings that will be leveraged for Sql source partitioning.
   */
  partitionSettings?: SqlPartitionSettings;

  /**
   * Copy source type.
   */
  type: "WarehouseSource";
}

/**
 * A copy activity Microsoft Fabric Warehouse sink.
 */
model WarehouseSink extends CopySink {
  /**
   * SQL pre-copy script. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preCopyScript?: unknown;

  /**
   * Indicates to use Copy Command to copy data into SQL Data Warehouse. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowCopyCommand?: unknown;

  /**
   * Specifies Copy Command related settings when allowCopyCommand is true.
   */
  copyCommandSettings?: DWCopyCommandSettings;

  /**
   * The option to handle sink table, such as autoCreate. For now only 'autoCreate' value is supported. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableOption?: unknown;

  /**
   * Write behavior when copying data into azure Microsoft Fabric Data Warehouse. Type: DWWriteBehaviorEnum (or Expression with resultType DWWriteBehaviorEnum)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  writeBehavior?: unknown;

  /**
   * Copy sink type.
   */
  type: "WarehouseSink";
}

/**
 * DW Copy Command settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DWCopyCommandSettings {
  /**
   * Specifies the default values for each target column in SQL DW. The default values in the property overwrite the DEFAULT constraint set in the DB, and identity column cannot have a default value. Type: array of objects (or Expression with resultType array of objects).
   */
  @identifiers(#["columnName"])
  defaultValues?: DWCopyCommandDefaultValue[];

  /**
   * Additional options directly passed to SQL DW in Copy Command. Type: key value pairs (value should be string type) (or Expression with resultType object). Example: "additionalOptions": { "MAXERRORS": "1000", "DATEFORMAT": "'ymd'" }
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalOptions?: Record<string>;
}

/**
 * Default value.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DWCopyCommandDefaultValue {
  /**
   * Column name. Type: object (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  columnName?: unknown;

  /**
   * The default value of the column. Type: object (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  defaultValue?: unknown;
}

/**
 * SQL stored procedure parameter.
 */
model StoredProcedureParameter {
  /**
   * Stored procedure parameter value. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpRequestTimeout?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureTableDefaultPartitionKeyValue?: unknown;

  /**
   * Azure Table partition key name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureTablePartitionKeyName?: unknown;

  /**
   * Azure Table row key name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureTableRowKeyName?: unknown;

  /**
   * Azure Table insert type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureTableInsertType?: unknown;

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
 * A copy activity Iceberg sink.
 */
model IcebergSink extends CopySink {
  /**
   * Iceberg store settings.
   */
  storeSettings?: StoreWriteSettings;

  /**
   * Iceberg format settings.
   */
  formatSettings?: IcebergWriteSettings;

  /**
   * Copy sink type.
   */
  type: "IcebergSink";
}

/**
 * A copy activity Azure Blob sink.
 */
model BlobSink extends CopySink {
  /**
   * Blob writer overwrite files. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  blobWriterOverwriteFiles?: unknown;

  /**
   * Blob writer date time format. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  blobWriterDateTimeFormat?: unknown;

  /**
   * Blob writer add header. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  blobWriterAddHeader?: unknown;

  /**
   * The type of copy behavior for copy sink.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  copyBehavior?: unknown;

  /**
   * Specify the custom metadata to be added to sink data. Type: array of objects (or Expression with resultType array of objects).
   */
  @identifiers(#["name"])
  metadata?: MetadataItem[];

  /**
   * Copy sink type.
   */
  type: "BlobSink";
}

/**
 * A copy activity file system sink.
 */
model FileSystemSink extends CopySink {
  /**
   * The type of copy behavior for copy sink.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  copyBehavior?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  nestingSeparator?: unknown;

  /**
   * Describes how to write data to Azure Cosmos DB. Type: string (or Expression with resultType string). Allowed values: insert and upsert.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  writeBehavior?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  writeBehavior?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlWriterStoredProcedureName?: unknown;

  /**
   * SQL writer table type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlWriterTableType?: unknown;

  /**
   * SQL pre-copy script. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preCopyScript?: unknown;

  /**
   * SQL stored procedure parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storedProcedureParameters?: unknown;

  /**
   * The stored procedure parameter name of the table type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storedProcedureTableTypeParameterName?: unknown;

  /**
   * The option to handle sink table, such as autoCreate. For now only 'autoCreate' value is supported. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableOption?: unknown;

  /**
   * Whether to use table lock during bulk copy. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlWriterUseTableLock?: unknown;

  /**
   * Write behavior when copying data into sql. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  writeBehavior?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useTempDB?: unknown;

  /**
   * Schema name for interim table. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  interimSchemaName?: unknown;

  /**
   * Key column names for unique row identification. Type: array of strings (or Expression with resultType array of strings).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keys?: unknown;
}

/**
 * A copy activity SQL server sink.
 */
model SqlServerSink extends CopySink {
  /**
   * SQL writer stored procedure name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlWriterStoredProcedureName?: unknown;

  /**
   * SQL writer table type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlWriterTableType?: unknown;

  /**
   * SQL pre-copy script. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preCopyScript?: unknown;

  /**
   * SQL stored procedure parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storedProcedureParameters?: unknown;

  /**
   * The stored procedure parameter name of the table type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storedProcedureTableTypeParameterName?: unknown;

  /**
   * The option to handle sink table, such as autoCreate. For now only 'autoCreate' value is supported. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableOption?: unknown;

  /**
   * Whether to use table lock during bulk copy. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlWriterUseTableLock?: unknown;

  /**
   * Write behavior when copying data into sql server. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  writeBehavior?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlWriterStoredProcedureName?: unknown;

  /**
   * SQL writer table type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlWriterTableType?: unknown;

  /**
   * SQL pre-copy script. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preCopyScript?: unknown;

  /**
   * SQL stored procedure parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storedProcedureParameters?: unknown;

  /**
   * The stored procedure parameter name of the table type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storedProcedureTableTypeParameterName?: unknown;

  /**
   * The option to handle sink table, such as autoCreate. For now only 'autoCreate' value is supported. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableOption?: unknown;

  /**
   * Whether to use table lock during bulk copy. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlWriterUseTableLock?: unknown;

  /**
   * Write behavior when copying data into Azure SQL. Type: SqlWriteBehaviorEnum (or Expression with resultType SqlWriteBehaviorEnum)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  writeBehavior?: unknown;

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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlMISink extends CopySink {
  /**
   * SQL writer stored procedure name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlWriterStoredProcedureName?: unknown;

  /**
   * SQL writer table type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlWriterTableType?: unknown;

  /**
   * SQL pre-copy script. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preCopyScript?: unknown;

  /**
   * SQL stored procedure parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storedProcedureParameters?: unknown;

  /**
   * The stored procedure parameter name of the table type. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storedProcedureTableTypeParameterName?: unknown;

  /**
   * The option to handle sink table, such as autoCreate. For now only 'autoCreate' value is supported. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableOption?: unknown;

  /**
   * Whether to use table lock during bulk copy. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlWriterUseTableLock?: unknown;

  /**
   * White behavior when copying data into azure SQL MI. Type: string (or Expression with resultType string)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  writeBehavior?: unknown;

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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlDWSink extends CopySink {
  /**
   * SQL pre-copy script. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preCopyScript?: unknown;

  /**
   * Indicates to use PolyBase to copy data into SQL Data Warehouse when applicable. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowPolyBase?: unknown;

  /**
   * Specifies PolyBase-related settings when allowPolyBase is true.
   */
  polyBaseSettings?: PolybaseSettings;

  /**
   * Indicates to use Copy Command to copy data into SQL Data Warehouse. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowCopyCommand?: unknown;

  /**
   * Specifies Copy Command related settings when allowCopyCommand is true.
   */
  copyCommandSettings?: DWCopyCommandSettings;

  /**
   * The option to handle sink table, such as autoCreate. For now only 'autoCreate' value is supported. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableOption?: unknown;

  /**
   * Whether to use table lock during bulk copy. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlWriterUseTableLock?: unknown;

  /**
   * Write behavior when copying data into azure SQL DW. Type: SqlDWWriteBehaviorEnum (or Expression with resultType SqlDWWriteBehaviorEnum)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  writeBehavior?: unknown;

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
model PolybaseSettings {
  ...Record<unknown>;

  /**
   * Reject type.
   */
  rejectType?: PolybaseSettingsRejectType;

  /**
   * Specifies the value or the percentage of rows that can be rejected before the query fails. Type: number (or Expression with resultType number), minimum: 0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rejectValue?: unknown;

  /**
   * Determines the number of rows to attempt to retrieve before the PolyBase recalculates the percentage of rejected rows. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rejectSampleValue?: unknown;

  /**
   * Specifies how to handle missing values in delimited text files when PolyBase retrieves data from the text file. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useTypeDefault?: unknown;
}

/**
 * Sql DW upsert option settings
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlDWUpsertSettings {
  /**
   * Schema name for interim table. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  interimSchemaName?: unknown;

  /**
   * Key column names for unique row identification. Type: array of strings (or Expression with resultType array of strings).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keys?: unknown;
}

/**
 * A copy activity snowflake sink.
 */
model SnowflakeSink extends CopySink {
  /**
   * SQL pre-copy script. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preCopyScript?: unknown;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalCopyOptions?: Record<unknown>;

  /**
   * Additional format options directly passed to snowflake Copy Command. Type: key value pairs (value should be string type) (or Expression with resultType object). Example: "additionalFormatOptions": { "FORCE": "TRUE", "LOAD_UNCERTAIN_FILES": "'FALSE'" }
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalFormatOptions?: Record<unknown>;

  /**
   * The name of the snowflake storage integration to use for the copy operation. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageIntegration?: unknown;

  /**
   * The import setting type.
   */
  type: "SnowflakeImportCopyCommand";
}

/**
 * A copy activity snowflake sink.
 */
model SnowflakeV2Sink extends CopySink {
  /**
   * SQL pre-copy script. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preCopyScript?: unknown;

  /**
   * Snowflake import settings.
   */
  importSettings?: SnowflakeImportCopyCommand;

  /**
   * Copy sink type.
   */
  type: "SnowflakeV2Sink";
}

/**
 * Specify the column name and value of additional columns.
 */
model AdditionalColumns {
  /**
   * Additional column name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: unknown;

  /**
   * Additional column value. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: unknown;
}

/**
 * A copy activity Oracle sink.
 */
model OracleSink extends CopySink {
  /**
   * SQL pre-copy script. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preCopyScript?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  copyBehavior?: unknown;

  /**
   * Single File Parallel.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableAdlsSingleFileParallel?: unknown;

  /**
   * Copy sink type.
   */
  type: "AzureDataLakeStoreSink";
}

/**
 * A copy activity Azure Data Lake Storage Gen2 sink.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureBlobFSSink extends CopySink {
  /**
   * The type of copy behavior for copy sink. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  copyBehavior?: unknown;

  /**
   * Specify the custom metadata to be added to sink data. Type: array of objects (or Expression with resultType array of objects).
   */
  @identifiers(#["name"])
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preCopyScript?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preCopyScript?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preCopyScript?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ignoreNullValues?: unknown;

  /**
   * The logical name of the alternate key which will be used when upserting records. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  alternateKeyName?: unknown;

  /**
   * Controls the bypass of Dataverse custom business logic. Type: string (or Expression with resultType string). Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  bypassBusinessLogicExecution?: unknown;

  /**
   * Controls the bypass of Power Automate flows. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  bypassPowerAutomateFlows?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ignoreNullValues?: unknown;

  /**
   * The logical name of the alternate key which will be used when upserting records. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  alternateKeyName?: unknown;

  /**
   * Controls the bypass of Dataverse custom business logic. Type: string (or Expression with resultType string). Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  bypassBusinessLogicExecution?: unknown;

  /**
   * Controls the bypass of Power Automate flows. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  bypassPowerAutomateFlows?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ignoreNullValues?: unknown;

  /**
   * The logical name of the alternate key which will be used when upserting records. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  alternateKeyName?: unknown;

  /**
   * Controls the bypass of Dataverse custom business logic. Type: string (or Expression with resultType string). Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  bypassBusinessLogicExecution?: unknown;

  /**
   * Controls the bypass of Power Automate flows. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  bypassPowerAutomateFlows?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ingestionMappingName?: unknown;

  /**
   * An explicit column mapping description provided in a json format. Type: string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ingestionMappingAsJson?: unknown;

  /**
   * If set to true, any aggregation will be skipped. Default is false. Type: boolean.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  flushImmediately?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  externalIdFieldName?: unknown;

  /**
   * The flag indicating whether or not to ignore null values from input dataset (except key fields) during write operation. Default value is false. If set it to true, it means ADF will leave the data in the destination object unchanged when doing upsert/update operation and insert defined default value when doing insert operation, versus ADF will update the data in the destination object to NULL when doing upsert/update operation and insert NULL value when doing insert operation. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ignoreNullValues?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  externalIdFieldName?: unknown;

  /**
   * The flag indicating whether or not to ignore null values from input dataset (except key fields) during write operation. Default value is false. If set it to true, it means ADF will leave the data in the destination object unchanged when doing upsert/update operation and insert defined default value when doing insert operation, versus ADF will update the data in the destination object to NULL when doing upsert/update operation and insert NULL value when doing insert operation. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ignoreNullValues?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  writeBehavior?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  writeBehavior?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  writeBehavior?: unknown;

  /**
   * Copy sink type.
   */
  type: "CosmosDbMongoDbApiSink";
}

/**
 * A copy activity for Microsoft Fabric Lakehouse Table sink.
 */
model LakeHouseTableSink extends CopySink {
  /**
   * The type of table action for Lakehouse Table sink. Possible values include: "None", "Append", "Overwrite".
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableActionOption?: unknown;

  /**
   * Create partitions in folder structure based on one or multiple columns. Each distinct column value (pair) will be a new partition. Possible values include: "None", "PartitionByKey".
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionOption?: unknown;

  /**
   * Specify the partition column names from sink columns. Type: array of objects (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionNameList?: unknown;

  /**
   * Copy sink type.
   */
  type: "LakeHouseTableSink";
}

/**
 * A copy activity translator.
 */
@discriminator("type")
model CopyTranslator {
  ...Record<unknown>;

  /**
   * Copy translator type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;
}

/**
 * A copy activity tabular translator.
 */
model TabularTranslator extends CopyTranslator {
  /**
   * Column mappings. Example: "UserId: MyUserId, Group: MyGroup, Name: MyName" Type: string (or Expression with resultType string). This property will be retired. Please use mappings property.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  columnMappings?: unknown;

  /**
   * The schema mapping to map between tabular data and hierarchical data. Example: {"Column1": "$.Column1", "Column2": "$.Column2.Property1", "Column3": "$.Column2.Property2"}. Type: object (or Expression with resultType object). This property will be retired. Please use mappings property.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schemaMapping?: unknown;

  /**
   * The JSON Path of the Nested Array that is going to do cross-apply. Type: object (or Expression with resultType object).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  collectionReference?: unknown;

  /**
   * Whether to map complex (array and object) values to simple strings in json format. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  mapComplexValuesToString?: unknown;

  /**
   * Column mappings with logical types. Tabular->tabular example: [{"source":{"name":"CustomerName","type":"String"},"sink":{"name":"ClientName","type":"String"}},{"source":{"name":"CustomerAddress","type":"String"},"sink":{"name":"ClientAddress","type":"String"}}].  Hierarchical->tabular example: [{"source":{"path":"$.CustomerName","type":"String"},"sink":{"name":"ClientName","type":"String"}},{"source":{"path":"$.CustomerAddress","type":"String"},"sink":{"name":"ClientAddress","type":"String"}}]. Type: object (or Expression with resultType object).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  mappings?: unknown;

  /**
   * Whether to enable the advanced type conversion feature in the Copy activity. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  typeConversion?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowDataTruncation?: unknown;

  /**
   * Whether to treat boolean values as numbers. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  treatBooleanAsNumber?: unknown;

  /**
   * The format for DateTime values. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dateTimeFormat?: unknown;

  /**
   * The format for DateTimeOffset values. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dateTimeOffsetFormat?: unknown;

  /**
   * The format for TimeSpan values. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeSpanFormat?: unknown;

  /**
   * The format for Time values. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeFormat?: unknown;

  /**
   * The format for Date values. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dateFormat?: unknown;

  /**
   * The culture used to convert data from/to string. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  culture?: unknown;
}

/**
 * HDInsight Hive activity type.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HDInsightHiveActivityTypeProperties {
  /**
   * Storage linked service references.
   */
  @identifiers(#["referenceName"])
  storageLinkedServices?: LinkedServiceReference[];

  /**
   * User specified arguments to HDInsightActivity.
   */
  arguments?: unknown[];

  /**
   * Debug info option.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  getDebugInfo?: HDInsightActivityDebugInfoOption;

  /**
   * Script path. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  scriptPath?: unknown;

  /**
   * Script linked service reference.
   */
  scriptLinkedService?: LinkedServiceReference;

  /**
   * Allows user to specify defines for Hive job request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  defines?: Record<unknown>;

  /**
   * User specified arguments under hivevar namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  variables?: Record<unknown>;

  /**
   * Query timeout value (in minutes).  Effective when the HDInsight cluster is with ESP (Enterprise Security Package)
   */
  queryTimeout?: int32;
}

/**
 * HDInsight Pig activity type.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HDInsightPigActivityTypeProperties {
  /**
   * Storage linked service references.
   */
  @identifiers(#["referenceName"])
  storageLinkedServices?: LinkedServiceReference[];

  /**
   * User specified arguments to HDInsightActivity. Type: array (or Expression with resultType array).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  arguments?: unknown;

  /**
   * Debug info option.
   */
  getDebugInfo?: HDInsightActivityDebugInfoOption;

  /**
   * Script path. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  scriptPath?: unknown;

  /**
   * Script linked service reference.
   */
  scriptLinkedService?: LinkedServiceReference;

  /**
   * Allows user to specify defines for Pig job request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  defines?: Record<unknown>;
}

/**
 * HDInsight MapReduce activity type.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HDInsightMapReduceActivityTypeProperties {
  /**
   * Storage linked service references.
   */
  @identifiers(#["referenceName"])
  storageLinkedServices?: LinkedServiceReference[];

  /**
   * User specified arguments to HDInsightActivity.
   */
  arguments?: unknown[];

  /**
   * Debug info option.
   */
  getDebugInfo?: HDInsightActivityDebugInfoOption;

  /**
   * Class name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  className: unknown;

  /**
   * Jar path. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  jarFilePath: unknown;

  /**
   * Jar linked service reference.
   */
  jarLinkedService?: LinkedServiceReference;

  /**
   * Jar libs.
   */
  jarLibs?: unknown[];

  /**
   * Allows user to specify defines for the MapReduce job request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  defines?: Record<unknown>;
}

/**
 * HDInsight streaming activity type.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HDInsightStreamingActivityTypeProperties {
  /**
   * Storage linked service references.
   */
  @identifiers(#["referenceName"])
  storageLinkedServices?: LinkedServiceReference[];

  /**
   * User specified arguments to HDInsightActivity.
   */
  arguments?: unknown[];

  /**
   * Debug info option.
   */
  getDebugInfo?: HDInsightActivityDebugInfoOption;

  /**
   * Mapper executable name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  mapper: unknown;

  /**
   * Reducer executable name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  reducer: unknown;

  /**
   * Input blob path. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  input: unknown;

  /**
   * Output blob path. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  output: unknown;

  /**
   * Paths to streaming job files. Can be directories.
   */
  filePaths: unknown[];

  /**
   * Linked service reference where the files are located.
   */
  fileLinkedService?: LinkedServiceReference;

  /**
   * Combiner executable name. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  combiner?: unknown;

  /**
   * Command line environment values.
   */
  commandEnvironment?: unknown[];

  /**
   * Allows user to specify defines for streaming job request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  defines?: Record<unknown>;
}

/**
 * HDInsight Spark activity.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HDInsightSparkActivityTypeProperties {
  /**
   * The root path in 'sparkJobLinkedService' for all the job’s files. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rootPath: unknown;

  /**
   * The relative path to the root folder of the code/package to be executed. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  entryFilePath: unknown;

  /**
   * The user-specified arguments to HDInsightSparkActivity.
   */
  arguments?: unknown[];

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  proxyUser?: unknown;

  /**
   * Spark configuration property.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sparkConfig?: Record<unknown>;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  runtime?: unknown;

  /**
   * The logging level of SSIS package execution. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  loggingLevel?: unknown;

  /**
   * The environment path to execute the SSIS package. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  environmentPath?: unknown;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  projectParameters?: Record<SsisExecutionParameter>;

  /**
   * The package level parameters to execute the SSIS package.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  packageParameters?: Record<SsisExecutionParameter>;

  /**
   * The project level connection managers to execute the SSIS package.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  projectConnectionManagers?: Record<Record<SsisExecutionParameter>>;

  /**
   * The package level connection managers to execute the SSIS package.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  packageConnectionManagers?: Record<Record<SsisExecutionParameter>>;

  /**
   * The property overrides to execute the SSIS package.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  packagePath?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  configurationPath?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  packageContent?: unknown;

  /**
   * The embedded package last modified date.
   */
  packageLastModifiedDate?: string;

  /**
   * The embedded child package list.
   */
  @identifiers(#["packagePath", "packageName"])
  childPackages?: SsisChildPackage[];
}

/**
 * SSIS access credential.
 */
model SsisAccessCredential {
  /**
   * Domain for windows authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  domain: unknown;

  /**
   * UseName for windows authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  packagePath: unknown;

  /**
   * Name for embedded child package.
   */
  packageName?: string;

  /**
   * Content for embedded child package. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  packageContent: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  domain: unknown;

  /**
   * UseName for windows authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value: unknown;
}

/**
 * SSIS property override.
 */
model SsisPropertyOverride {
  /**
   * SSIS package property override value. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  logPath: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  logRefreshInterval?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  command: unknown;

  /**
   * Resource linked service reference.
   */
  resourceLinkedService?: LinkedServiceReference;

  /**
   * Folder path for resource files Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  folderPath?: unknown;

  /**
   * Reference objects
   */
  referenceObjects?: CustomActivityReferenceObject;

  /**
   * User defined property bag. There is no restriction on the keys or values that can be used. The user specified custom activity has the full responsibility to consume and interpret the content defined.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedProperties?: Record<unknown>;

  /**
   * The retention time for the files submitted for custom activity. Type: double (or Expression with resultType double).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  retentionTimeInDays?: unknown;

  /**
   * Elevation level and scope for the user, default is nonadmin task. Type: string (or Expression with resultType double).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  autoUserSpecification?: unknown;
}

/**
 * Reference objects for custom activity
 */
model CustomActivityReferenceObject {
  /**
   * Linked service references.
   */
  @identifiers(#["referenceName"])
  linkedServices?: LinkedServiceReference[];

  /**
   * Dataset references.
   */
  @identifiers(#["referenceName"])
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storedProcedureName: unknown;

  /**
   * Value and type setting for stored procedure parameters. Example: "{Parameter1: {value: "1", type: "int"}}".
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storedProcedureParameters?: unknown;
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
model ExecutePipelineActivityPolicy {
  ...Record<unknown>;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<unknown>;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recursive?: unknown;

  /**
   * The max concurrent connections to connect data source at the same time.
   */
  @minValue(1)
  maxConcurrentConnections?: int32;

  /**
   * Whether to record detailed logs of delete-activity execution. Default value is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableLogging?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  command: unknown;

  /**
   * Control command timeout. Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9]))..)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  commandTimeout?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  firstRowOnly?: unknown;

  /**
   * Indicates whether to treat decimal values as strings to avoid value overflow issue. This option is enabled for SnowflakeV2 connector only. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  treatDecimalAsString?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url: unknown;

  /**
   * Represents the headers that will be sent to the request. For example, to set the language and type on a request: "headers" : { "Accept-Language": "en-us", "Content-Type": "application/json" }. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  headers?: Record<unknown>;

  /**
   * Represents the payload that will be sent to the endpoint. Required for POST/PUT method, not allowed for GET method Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  body?: unknown;

  /**
   * Authentication method used for calling the endpoint.
   */
  authentication?: WebActivityAuthentication;

  /**
   * When set to true, Certificate validation will be disabled.
   */
  disableCertValidation?: boolean;

  /**
   * Timeout for the HTTP request to get a response. Format is in TimeSpan (hh:mm:ss). This value is the timeout to get a response, not the activity timeout. The default value is 00:01:00 (1 minute). The range is from 1 to 10 minutes
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpRequestTimeout?: unknown;

  /**
   * Option to disable invoking HTTP GET on location given in response header of a HTTP 202 Response. If set true, it stops invoking HTTP GET on http location given in response header. If set false then continues to invoke HTTP GET call on location given in http response headers.
   */
  turnOffAsync?: boolean;

  /**
   * List of datasets passed to web endpoint.
   */
  @identifiers(#["referenceName"])
  datasets?: DatasetReference[];

  /**
   * List of linked services passed to web endpoint.
   */
  @identifiers(#["referenceName"])
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: unknown;

  /**
   * Password for the PFX file or basic authentication / Secret when used for ServicePrincipal
   */
  password?: SecretBase;

  /**
   * Resource for which Azure Auth token will be requested when using MSI Authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: unknown;

  /**
   * TenantId for which Azure Auth token will be requested when using ServicePrincipal Authentication. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userTenant?: unknown;

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
  fieldList?: unknown[];

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
  @identifiers(#["name"])
  ifTrueActivities?: Activity[];

  /**
   * List of activities to execute if expression is evaluated to false. This is an optional property and if not provided, the activity will exit without any action.
   */
  @identifiers(#["name"])
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
  @identifiers(#["value"])
  cases?: SwitchCase[];

  /**
   * List of activities to execute if no case condition is satisfied. This is an optional property and if not provided, the activity will exit without any action.
   */
  @identifiers(#["name"])
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
  @identifiers(#["name"])
  activities?: Activity[];
}

/**
 * This activity is used for iterating over a collection and execute given activities.
 */
#suppress "@azure-tools/typespec-client-generator-core/legacy-hierarchy-building-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ControlActivity)
model ForEachActivity extends Activity {
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
  @identifiers(#["name"])
  activities: Activity[];
}

/**
 * Azure ML Batch Execution activity.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureMLBatchExecutionActivityTypeProperties {
  /**
   * Key,Value pairs to be passed to the Azure ML Batch Execution Service endpoint. Keys must match the names of web service parameters defined in the published Azure ML web service. Values will be passed in the GlobalParameters property of the Azure ML batch execution request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  globalParameters?: Record<unknown>;

  /**
   * Key,Value pairs, mapping the names of Azure ML endpoint's Web Service Outputs to AzureMLWebServiceFile objects specifying the output Blob locations. This information will be passed in the WebServiceOutputs property of the Azure ML batch execution request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  webServiceOutputs?: Record<AzureMLWebServiceFile>;

  /**
   * Key,Value pairs, mapping the names of Azure ML endpoint's Web Service Inputs to AzureMLWebServiceFile objects specifying the input Blob locations.. This information will be passed in the WebServiceInputs property of the Azure ML batch execution request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  webServiceInputs?: Record<AzureMLWebServiceFile>;
}

/**
 * Azure ML WebService Input/Output file
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureMLWebServiceFile {
  /**
   * The relative file path, including container name, in the Azure Blob Storage specified by the LinkedService. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  filePath: unknown;

  /**
   * Reference to an Azure Storage LinkedService, where Azure ML WebService Input/Output file located.
   */
  linkedServiceName: LinkedServiceReference;
}

/**
 * Azure ML Update Resource management activity.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureMLUpdateResourceActivityTypeProperties {
  /**
   * Name of the Trained Model module in the Web Service experiment to be updated. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  trainedModelName: unknown;

  /**
   * Name of Azure Storage linked service holding the .ilearner file that will be uploaded by the update operation.
   */
  trainedModelLinkedServiceName: LinkedServiceReference;

  /**
   * The relative file path in trainedModelLinkedService to represent the .ilearner file that will be uploaded by the update operation.  Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  trainedModelFilePath: unknown;
}

/**
 * Azure ML Execute Pipeline activity.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureMLExecutePipelineActivityTypeProperties {
  /**
   * ID of the published Azure ML pipeline. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  mlPipelineId?: unknown;

  /**
   * ID of the published Azure ML pipeline endpoint. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  mlPipelineEndpointId?: unknown;

  /**
   * Version of the published Azure ML pipeline endpoint. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  version?: unknown;

  /**
   * Run history experiment name of the pipeline run. This information will be passed in the ExperimentName property of the published pipeline execution request. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  experimentName?: unknown;

  /**
   * Key,Value pairs to be passed to the published Azure ML pipeline endpoint. Keys must match the names of pipeline parameters defined in the published pipeline. Values will be passed in the ParameterAssignments property of the published pipeline execution request. Type: object with key value pairs (or Expression with resultType object).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  mlPipelineParameters?: unknown;

  /**
   * Dictionary used for changing data path assignments without retraining. Values will be passed in the dataPathAssignments property of the published pipeline execution request. Type: object (or Expression with resultType object).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataPathAssignments?: unknown;

  /**
   * The parent Azure ML Service pipeline run id. This information will be passed in the ParentRunId property of the published pipeline execution request. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  mlParentRunId?: unknown;

  /**
   * Whether to continue execution of other steps in the PipelineRun if a step fails. This information will be passed in the continueOnStepFailure property of the published pipeline execution request. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  continueOnStepFailure?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  scriptPath: unknown;

  /**
   * Script linked service reference.
   */
  scriptLinkedService: LinkedServiceReference;

  /**
   * The maximum number of nodes simultaneously used to run the job. Default value is 1. Type: integer (or Expression with resultType integer), minimum: 1.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  degreeOfParallelism?: unknown;

  /**
   * Determines which jobs out of all that are queued should be selected to run first. The lower the number, the higher the priority. Default value is 1000. Type: integer (or Expression with resultType integer), minimum: 1.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  priority?: unknown;

  /**
   * Parameters for U-SQL job request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<unknown>;

  /**
   * Runtime version of the U-SQL engine to use. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  runtimeVersion?: unknown;

  /**
   * Compilation mode of U-SQL. Must be one of these values : Semantic, Full and SingleBox. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  compilationMode?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  waitTimeInSeconds: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  message: unknown;

  /**
   * The error code that categorizes the error type of the Fail activity. It can be dynamic content that's evaluated to a non empty/blank string at runtime. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  errorCode: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeout?: unknown;

  /**
   * List of activities to execute.
   */
  @identifiers(#["name"])
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeout?: unknown;

  /**
   * A delay in seconds between validation attempts. If no value is specified, 10 seconds will be used as the default. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sleep?: unknown;

  /**
   * Can be used if dataset points to a file. The file must be greater than or equal in size to the value specified. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  minimumSize?: unknown;

  /**
   * Can be used if dataset points to a folder. If set to true, the folder must have at least one file. If set to false, the folder must be empty. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  childItems?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  notebookPath: unknown;

  /**
   * Base parameters to be used for each run of this job.If the notebook takes a parameter that is not specified, the default value from the notebook will be used.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  baseParameters?: Record<unknown>;

  /**
   * A list of libraries to be installed on the cluster that will execute the job.
   */
  @identifiers(#[])
  libraries?: Record<unknown>[];
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  mainClassName: unknown;

  /**
   * Parameters that will be passed to the main method.
   */
  parameters?: unknown[];

  /**
   * A list of libraries to be installed on the cluster that will execute the job.
   */
  @identifiers(#[])
  libraries?: Record<unknown>[];
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  pythonFile: unknown;

  /**
   * Command line parameters that will be passed to the Python file.
   */
  parameters?: unknown[];

  /**
   * A list of libraries to be installed on the cluster that will execute the job.
   */
  @identifiers(#[])
  libraries?: Record<unknown>[];
}

/**
 * Databricks Job activity.
 */
model DatabricksJobActivity extends ExecutionActivity {
  /**
   * Databricks Job activity properties.
   */
  typeProperties: DatabricksJobActivityTypeProperties;

  /**
   * Type of activity.
   */
  type: "DatabricksJob";
}

/**
 * Databricks Job activity properties.
 */
model DatabricksJobActivityTypeProperties {
  /**
   * The Id of the Databricks Job to be executed. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  jobId: unknown;

  /**
   * Job parameters to be used for each run of this job. If the job takes a parameter that is not specified, the default value from the job will be used.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  jobParameters?: Record<unknown>;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  functionName: unknown;

  /**
   * Represents the headers that will be sent to the request. For example, to set the language and type on a request: "headers" : { "Accept-Language": "en-us", "Content-Type": "application/json" }. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  headers?: Record<unknown>;

  /**
   * Represents the payload that will be sent to the endpoint. Required for POST/PUT method, not allowed for GET method Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  body?: unknown;
}

/**
 * WebHook activity.
 */
#suppress "@azure-tools/typespec-client-generator-core/legacy-hierarchy-building-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ControlActivity)
model WebHookActivity extends Activity {
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url: unknown;

  /**
   * The timeout within which the webhook should be called back. If there is no value specified, it defaults to 10 minutes. Type: string. Pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  timeout?: string;

  /**
   * Represents the headers that will be sent to the request. For example, to set the language and type on a request: "headers" : { "Accept-Language": "en-us", "Content-Type": "application/json" }. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  headers?: Record<unknown>;

  /**
   * Represents the payload that will be sent to the endpoint. Required for POST/PUT method, not allowed for GET method Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  body?: unknown;

  /**
   * Authentication method used for calling the endpoint.
   */
  authentication?: WebActivityAuthentication;

  /**
   * When set to true, statusCode, output and error in callback request body will be consumed by activity. The activity can be marked as failed by setting statusCode >= 400 in callback request. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  reportStatusOnCallBack?: unknown;
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
   * Continuation settings for execute data flow activity.
   */
  continuationSettings?: ContinuationSettingsReference;

  /**
   * Compute properties for data flow activity.
   */
  compute?: ExecuteDataFlowActivityTypePropertiesCompute;

  /**
   * Trace level setting used for data flow monitoring output. Supported values are: 'coarse', 'fine', and 'none'. Type: string (or Expression with resultType string)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  traceLevel?: unknown;

  /**
   * Continue on error setting used for data flow execution. Enables processing to continue if a sink fails. Type: boolean (or Expression with resultType boolean)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  continueOnError?: unknown;

  /**
   * Concurrent run setting used for data flow execution. Allows sinks with the same save order to be processed concurrently. Type: boolean (or Expression with resultType boolean)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  runConcurrently?: unknown;

  /**
   * Specify number of parallel staging for sources applicable to the sink. Type: integer (or Expression with resultType integer)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceStagingConcurrency?: unknown;
}

/**
 * Continuation settings for execute data flow activity.
 */
model ContinuationSettingsReference {
  /**
   * Continuation TTL in minutes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  continuationTtlInMinutes?: unknown;

  /**
   * Idle condition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  idleCondition?: unknown;

  /**
   * Customized checkpoint key.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customizedCheckpointKey?: unknown;
}

/**
 * Compute properties for data flow activity.
 */
model ExecuteDataFlowActivityTypePropertiesCompute {
  /**
   * Compute type of the cluster which will execute data flow job. Possible values include: 'General', 'MemoryOptimized', 'ComputeOptimized'. Type: string (or Expression with resultType string)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  computeType?: unknown;

  /**
   * Core count of the cluster which will execute data flow job. Supported values are: 8, 16, 32, 48, 80, 144 and 272. Type: integer (or Expression with resultType integer)
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  coreCount?: unknown;
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ExecutePowerQueryActivityTypeProperties
  extends ExecuteDataFlowActivityTypeProperties {
  /**
   * (Deprecated. Please use Queries). List of Power Query activity sinks mapped to a queryName.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sinks?: Record<PowerQuerySink>;

  /**
   * List of mapping for Power Query mashup query to sink dataset(s).
   */
  @identifiers(#["queryName"])
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
  @identifiers(#["name"])
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  scriptBlockExecutionTimeout?: unknown;

  /**
   * Array of script blocks. Type: array.
   */
  @identifiers(#[])
  scripts?: ScriptActivityScriptBlock[];

  /**
   * Log settings of script activity.
   */
  logSettings?: ScriptActivityTypePropertiesLogSettings;

  /**
   * Enable to retrieve result sets from multiple SQL statements and the number of rows affected by the DML statement. Supported connector: SnowflakeV2. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  returnMultistatementResult?: unknown;

  /**
   * Indicates whether to treat decimal values as strings to avoid value overflow issue. This option is enabled for SnowflakeV2 connector only. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  treatDecimalAsString?: unknown;
}

/**
 * Script block of scripts.
 */
model ScriptActivityScriptBlock {
  /**
   * The query text. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  text: unknown;

  /**
   * The type of the query. Please refer to the ScriptType for valid options. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: unknown;

  /**
   * Array of script parameters. Type: array.
   */
  @identifiers(#["name"])
  parameters?: ScriptActivityParameter[];
}

/**
 * Parameters of a script block.
 */
model ScriptActivityParameter {
  /**
   * The name of the parameter. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: unknown;

  /**
   * The type of the parameter.
   */
  type?: ScriptActivityParameterType;

  /**
   * The value of the parameter. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * The wait time to get a response from SharePoint Online. Default value is 5 minutes (00:05:00). Type: string (or Expression with resultType string), pattern: ((\d+)\.)?(\d\d):(60|([0-5][0-9])):(60|([0-5][0-9])).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpRequestTimeout?: unknown;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<NotebookParameter>;

  /**
   * Number of core and memory to be used for executors allocated in the specified Spark pool for the session, which will be used for overriding 'executorCores' and 'executorMemory' of the notebook you provide. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  executorSize?: unknown;

  /**
   * Spark configuration properties, which will override the 'conf' of the notebook you provide.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  conf?: unknown;

  /**
   * Number of core and memory to be used for driver allocated in the specified Spark pool for the session, which will be used for overriding 'driverCores' and 'driverMemory' of the notebook you provide. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  driverSize?: unknown;

  /**
   * Number of executors to launch for this session, which will override the 'numExecutors' of the notebook you provide. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  numExecutors?: unknown;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sparkConfig?: Record<unknown>;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  referenceName: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  referenceName: unknown;
}

/**
 * Notebook parameter.
 */
model NotebookParameter {
  /**
   * Notebook parameter value. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: unknown;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  referenceName: unknown;
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
  args?: unknown[];

  /**
   * The main file used for the job, which will override the 'file' of the spark job definition you provide. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  file?: unknown;

  /**
   * Scanning subfolders from the root folder of the main definition file, these files will be added as reference files. The folders named 'jars', 'pyFiles', 'files' or 'archives' will be scanned, and the folders name are case sensitive. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  scanFolder?: unknown;

  /**
   * The fully-qualified identifier or the main class that is in the main definition file, which will override the 'className' of the spark job definition you provide. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  className?: unknown;

  /**
   * (Deprecated. Please use pythonCodeReference and filesV2) Additional files used for reference in the main definition file, which will override the 'files' of the spark job definition you provide.
   */
  files?: unknown[];

  /**
   * Additional python code files used for reference in the main definition file, which will override the 'pyFiles' of the spark job definition you provide.
   */
  pythonCodeReference?: unknown[];

  /**
   * Additional files used for reference in the main definition file, which will override the 'jars' and 'files' of the spark job definition you provide.
   */
  filesV2?: unknown[];

  /**
   * The name of the big data pool which will be used to execute the spark batch job, which will override the 'targetBigDataPool' of the spark job definition you provide.
   */
  targetBigDataPool?: BigDataPoolParametrizationReference;

  /**
   * Number of core and memory to be used for executors allocated in the specified Spark pool for the job, which will be used for overriding 'executorCores' and 'executorMemory' of the spark job definition you provide. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  executorSize?: unknown;

  /**
   * Spark configuration properties, which will override the 'conf' of the spark job definition you provide.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  conf?: unknown;

  /**
   * Number of core and memory to be used for driver allocated in the specified Spark pool for the job, which will be used for overriding 'driverCores' and 'driverMemory' of the spark job definition you provide. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  driverSize?: unknown;

  /**
   * Number of executors to launch for this job, which will override the 'numExecutors' of the spark job definition you provide. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  numExecutors?: unknown;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sparkConfig?: Record<unknown>;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  referenceName: unknown;
}

/**
 * A copy activity Salesforce V2 source.
 */
model SalesforceV2Source extends TabularSource {
  /**
   * Deprecating, please use 'query' property instead. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SOQLQuery?: unknown;

  /**
   * You can only use Salesforce Object Query Language (SOQL) query with limitations. For SOQL limitations, see this article: https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/queries.htm#SOQL%20Considerations. If query is not specified, all the data of the Salesforce object specified in ObjectApiName/reportId in dataset will be retrieved. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * This property control whether query result contains Deleted objects. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  includeDeletedObjects?: unknown;

  /**
   * Page size for each http request, too large pageSize will caused timeout, default 300,000. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  pageSize?: unknown;

  /**
   * Partition option for the SalesforceV2 connector in copy activity, AutoDetect or None. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partitionOption?: unknown;

  /**
   * Copy source type.
   */
  type: "SalesforceV2Source";
}

/**
 * A copy activity Salesforce Service Cloud V2 source.
 */
model SalesforceServiceCloudV2Source extends CopySource {
  /**
   * Deprecating, please use 'query' property instead. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SOQLQuery?: unknown;

  /**
   * You can only use Salesforce Object Query Language (SOQL) query with limitations. For SOQL limitations, see this article: https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/queries.htm#SOQL%20Considerations. If query is not specified, all the data of the Salesforce object specified in ObjectApiName/reportId in dataset will be retrieved. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query?: unknown;

  /**
   * This property control whether query result contains Deleted objects. Default is false. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  includeDeletedObjects?: unknown;

  /**
   * Specifies the additional columns to be added to source data. Type: array of objects(AdditionalColumns) (or Expression with resultType array of objects).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalColumns?: unknown;

  /**
   * Copy source type.
   */
  type: "SalesforceServiceCloudV2Source";
}

/**
 * A copy activity Salesforce V2 sink.
 */
model SalesforceV2Sink extends CopySink {
  /**
   * The write behavior for the operation. Default is Insert.
   */
  writeBehavior?: SalesforceV2SinkWriteBehavior;

  /**
   * The name of the external ID field for upsert operation. Default value is 'Id' column. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  externalIdFieldName?: unknown;

  /**
   * The flag indicating whether or not to ignore null values from input dataset (except key fields) during write operation. Default value is false. If set it to true, it means ADF will leave the data in the destination object unchanged when doing upsert/update operation and insert defined default value when doing insert operation, versus ADF will update the data in the destination object to NULL when doing upsert/update operation and insert NULL value when doing insert operation. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ignoreNullValues?: unknown;

  /**
   * Copy sink type.
   */
  type: "SalesforceV2Sink";
}

/**
 * A copy activity Salesforce Service Cloud V2 sink.
 */
model SalesforceServiceCloudV2Sink extends CopySink {
  /**
   * The write behavior for the operation. Default is Insert.
   */
  writeBehavior?: SalesforceV2SinkWriteBehavior;

  /**
   * The name of the external ID field for upsert operation. Default value is 'Id' column. Type: string (or Expression with resultType string).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  externalIdFieldName?: unknown;

  /**
   * The flag indicating whether or not to ignore null values from input dataset (except key fields) during write operation. Default value is false. If set it to true, it means ADF will leave the data in the destination object unchanged when doing upsert/update operation and insert defined default value when doing insert operation, versus ADF will update the data in the destination object to NULL when doing upsert/update operation and insert NULL value when doing insert operation. Type: boolean (or Expression with resultType boolean).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ignoreNullValues?: unknown;

  /**
   * Copy sink type.
   */
  type: "SalesforceServiceCloudV2Sink";
}

/**
 * A copy activity ServiceNowV2 server source.
 */
model ServiceNowV2Source extends TabularSource {
  /**
   * Expression to filter data from source.
   */
  expression?: ExpressionV2;

  /**
   * Page size of the result. Type: integer (or Expression with resultType integer).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  pageSize?: unknown;

  /**
   * Copy source type.
   */
  type: "ServiceNowV2Source";
}

/**
 * Nested representation of a complex expression.
 */
model ExpressionV2 {
  /**
   * Type of expressions supported by the system. Type: string.
   */
  type?: ExpressionV2Type;

  /**
   * Value for Constant/Field Type: object.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: unknown;

  /**
   * Expression operator value Type: list of strings.
   */
  operators?: string[];

  /**
   * List of nested expressions.
   */
  @identifiers(#[])
  operands?: ExpressionV2[];
}

/**
 * Base class for all triggers that support one to many model for trigger to pipeline.
 */
model MultiplePipelineTrigger is Trigger {
  ...MultiplePipelineTriggerProperties;
}

alias MultiplePipelineTriggerProperties = {
  /**
   * Pipelines that need to be started.
   */
  @identifiers(#["/pipelineReference/referenceName"])
  pipelines?: TriggerPipelineReference[];
};

/**
 * Trigger that creates pipeline runs periodically, on schedule.
 */
#suppress "@azure-tools/typespec-client-generator-core/legacy-hierarchy-building-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(MultiplePipelineTrigger)
model ScheduleTrigger extends Trigger {
  ...MultiplePipelineTriggerProperties;

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
model ScheduleTriggerRecurrence {
  ...Record<unknown>;

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
model RecurrenceSchedule {
  ...Record<unknown>;

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
  @identifiers(#[])
  monthlyOccurrences?: RecurrenceScheduleOccurrence[];
}

/**
 * The recurrence schedule occurrence.
 */
model RecurrenceScheduleOccurrence {
  ...Record<unknown>;

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
  events: unknown[];

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delay?: unknown;

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
  @identifiers(#[])
  dependsOn?: DependencyReference[];
}

/**
 * Execution policy for an activity.
 */
model RetryPolicy {
  /**
   * Maximum ordinary retry attempts. Default is 0. Type: integer (or Expression with resultType integer), minimum: 0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  count?: unknown;

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
model DependencyReference {
  /**
   * The type of dependency reference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;
}

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
model TriggerDependencyReference is DependencyReference {
  ...TriggerDependencyReferenceProperties;
}

alias TriggerDependencyReferenceProperties = {
  /**
   * Referenced trigger.
   */
  referenceTrigger: TriggerReference;
};
/**
 * Referenced tumbling window trigger dependency.
 */
#suppress "@azure-tools/typespec-client-generator-core/legacy-hierarchy-building-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(TriggerDependencyReference)
model TumblingWindowTriggerDependencyReference extends DependencyReference {
  ...TriggerDependencyReferenceProperties;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parentTrigger: unknown;

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
  @identifiers(#["referenceName"])
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalId?: unknown;

  /**
   * The key of the service principal used to authenticate.
   */
  servicePrincipalKey?: AzureKeyVaultSecretReference;

  /**
   * The ID of the tenant to which the service principal belongs
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenant?: unknown;
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
