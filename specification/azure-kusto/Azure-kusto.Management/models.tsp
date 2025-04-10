import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Kusto;

/**
 * SKU name.
 */
union AzureSkuName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Dev(No SLA)_Standard_D11_v2`: "Dev(No SLA)_Standard_D11_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Dev(No SLA)_Standard_E2a_v4`: "Dev(No SLA)_Standard_E2a_v4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D11_v2: "Standard_D11_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D12_v2: "Standard_D12_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D13_v2: "Standard_D13_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D14_v2: "Standard_D14_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D32d_v4: "Standard_D32d_v4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D16d_v5: "Standard_D16d_v5",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D32d_v5: "Standard_D32d_v5",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_DS13_v2+1TB_PS`: "Standard_DS13_v2+1TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_DS13_v2+2TB_PS`: "Standard_DS13_v2+2TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_DS14_v2+3TB_PS`: "Standard_DS14_v2+3TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_DS14_v2+4TB_PS`: "Standard_DS14_v2+4TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_L4s: "Standard_L4s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_L8s: "Standard_L8s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_L16s: "Standard_L16s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_L8s_v2: "Standard_L8s_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_L16s_v2: "Standard_L16s_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_L8s_v3: "Standard_L8s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_L16s_v3: "Standard_L16s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_L32s_v3: "Standard_L32s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_L8as_v3: "Standard_L8as_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_L16as_v3: "Standard_L16as_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_L32as_v3: "Standard_L32as_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E64i_v3: "Standard_E64i_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E80ids_v4: "Standard_E80ids_v4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E2a_v4: "Standard_E2a_v4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E4a_v4: "Standard_E4a_v4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E8a_v4: "Standard_E8a_v4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E16a_v4: "Standard_E16a_v4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E8as_v4+1TB_PS`: "Standard_E8as_v4+1TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E8as_v4+2TB_PS`: "Standard_E8as_v4+2TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E16as_v4+3TB_PS`: "Standard_E16as_v4+3TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E16as_v4+4TB_PS`: "Standard_E16as_v4+4TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E8as_v5+1TB_PS`: "Standard_E8as_v5+1TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E8as_v5+2TB_PS`: "Standard_E8as_v5+2TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E16as_v5+3TB_PS`: "Standard_E16as_v5+3TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E16as_v5+4TB_PS`: "Standard_E16as_v5+4TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E2ads_v5: "Standard_E2ads_v5",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E4ads_v5: "Standard_E4ads_v5",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E8ads_v5: "Standard_E8ads_v5",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E16ads_v5: "Standard_E16ads_v5",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_EC8as_v5+1TB_PS`: "Standard_EC8as_v5+1TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_EC8as_v5+2TB_PS`: "Standard_EC8as_v5+2TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_EC16as_v5+3TB_PS`: "Standard_EC16as_v5+3TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_EC16as_v5+4TB_PS`: "Standard_EC16as_v5+4TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_EC8ads_v5: "Standard_EC8ads_v5",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_EC16ads_v5: "Standard_EC16ads_v5",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E8s_v4+1TB_PS`: "Standard_E8s_v4+1TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E8s_v4+2TB_PS`: "Standard_E8s_v4+2TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E16s_v4+3TB_PS`: "Standard_E16s_v4+3TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E16s_v4+4TB_PS`: "Standard_E16s_v4+4TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E8s_v5+1TB_PS`: "Standard_E8s_v5+1TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E8s_v5+2TB_PS`: "Standard_E8s_v5+2TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E16s_v5+3TB_PS`: "Standard_E16s_v5+3TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E16s_v5+4TB_PS`: "Standard_E16s_v5+4TB_PS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E2d_v4: "Standard_E2d_v4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E4d_v4: "Standard_E4d_v4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E8d_v4: "Standard_E8d_v4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E16d_v4: "Standard_E16d_v4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E2d_v5: "Standard_E2d_v5",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E4d_v5: "Standard_E4d_v5",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E8d_v5: "Standard_E8d_v5",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E16d_v5: "Standard_E16d_v5",
}

/**
 * SKU tier.
 */
union AzureSkuTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard: "Standard",
}

/**
 * The type of managed identity used. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user-assigned identities. The type 'None' will remove all identities.
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
  `SystemAssigned, UserAssigned`: "SystemAssigned, UserAssigned",
}

/**
 * The state of the resource.
 */
union State {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unavailable: "Unavailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Stopping: "Stopping",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Stopped: "Stopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Starting: "Starting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Migrated: "Migrated",
}

/**
 * The provisioned state of the resource.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * When enabled, the cluster is deployed into the configured subnet, when disabled it will be removed from the subnet.
 */
union VnetState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Language extension that can run within KQL query.
 */
union LanguageExtensionName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PYTHON: "PYTHON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  R: "R",
}

/**
 * Language extension image name.
 */
union LanguageExtensionImageName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  R: "R",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Python3_6_5: "Python3_6_5",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Python3_10_8: "Python3_10_8",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Python3_10_8_DL: "Python3_10_8_DL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PythonCustomImage: "PythonCustomImage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Python3_11_7: "Python3_11_7",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Python3_11_7_DL: "Python3_11_7_DL",
}

/**
 * Public network access to the cluster is enabled by default. When disabled, only private endpoint connection to the cluster is allowed
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * The engine type
 */
union EngineType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  V2: "V2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  V3: "V3",
}

/**
 * Whether or not to restrict outbound network access.  Value is optional but if passed in, must be 'Enabled' or 'Disabled'
 */
union ClusterNetworkAccessFlag {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Type of the callout service, specifying the kind of external resource or service being accessed.
 */
union CalloutType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  kusto: "kusto",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  sql: "sql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  cosmosdb: "cosmosdb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  external_data: "external_data",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  azure_digital_twins: "azure_digital_twins",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  sandbox_artifacts: "sandbox_artifacts",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  webapi: "webapi",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  mysql: "mysql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  postgresql: "postgresql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  genevametrics: "genevametrics",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  azure_openai: "azure_openai",
}

/**
 * Indicates whether outbound access is permitted for the specified URI pattern.
 */
union OutboundAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deny: "Deny",
}

/**
 * Indicates what public IP type to create - IPv4 (default), or DualStack (both IPv4 and IPv6)
 */
union PublicIPType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IPv4: "IPv4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DualStack: "DualStack",
}

/**
 * The role of the cluster in the migration process.
 */
union MigrationClusterRole {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Source: "Source",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Destination: "Destination",
}

/**
 * Indicates whether the cluster is zonal or non-zonal.
 */
union ZoneStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NonZonal: "NonZonal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ZonalInconsistency: "ZonalInconsistency",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Zonal: "Zonal",
}

/**
 * Message providing the reason why the given name is invalid.
 */
union Reason {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AlreadyExists: "AlreadyExists",
}

/**
 * Cluster principal role.
 */
union ClusterPrincipalRole {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AllDatabasesAdmin: "AllDatabasesAdmin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AllDatabasesViewer: "AllDatabasesViewer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AllDatabasesMonitor: "AllDatabasesMonitor",
}

/**
 * Principal type.
 */
union PrincipalType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  App: "App",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Group: "Group",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
}

/**
 * The origin of the following setup.
 */
union DatabaseShareOrigin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Direct: "Direct",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DataShare: "DataShare",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Other: "Other",
}

/**
 * Scale type.
 */
union AzureScaleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  automatic: "automatic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  manual: "manual",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  none: "none",
}

/**
 * Kind of the database
 */
union Kind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ReadWrite: "ReadWrite",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ReadOnlyFollowing: "ReadOnlyFollowing",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union CallerRole {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Admin: "Admin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * Database principal role.
 */
union DatabasePrincipalRole {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Admin: "Admin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Ingestor: "Ingestor",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Monitor: "Monitor",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UnrestrictedViewer: "UnrestrictedViewer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Viewer: "Viewer",
}

/**
 * Database principal type.
 */
union DatabasePrincipalType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  App: "App",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Group: "Group",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
}

/**
 * Differentiates between the type of script commands included - Database or Cluster. The default is Database.
 */
union ScriptLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Database: "Database",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Cluster: "Cluster",
}

/**
 * Indicates if the permissions for the script caller are kept following completion of the script.
 */
union PrincipalPermissionsAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RetainPermissionOnScriptCompletion: "RetainPermissionOnScriptCompletion",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RemovePermissionOnScriptCompletion: "RemovePermissionOnScriptCompletion",
}

/**
 * The language name, for example Python.
 */
union Language {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Python: "Python",
}

/**
 * The default principals modification kind
 */
union DefaultPrincipalsModificationKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Union: "Union",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Replace: "Replace",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * Kind of the endpoint for the data connection
 */
union DataConnectionKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EventHub: "EventHub",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EventGrid: "EventGrid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IotHub: "IotHub",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CosmosDb: "CosmosDb",
}

/**
 * The status of operation.
 */
union Status {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
}

/**
 * The principals modification kind of the database
 */
union PrincipalsModificationKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Union: "Union",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Replace: "Replace",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * The data format of the message. Optionally the data format can be added to each message.
 */
union EventHubDataFormat {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MULTIJSON: "MULTIJSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  JSON: "JSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CSV: "CSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TSV: "TSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SCSV: "SCSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SOHSV: "SOHSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PSV: "PSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TXT: "TXT",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RAW: "RAW",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SINGLEJSON: "SINGLEJSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AVRO: "AVRO",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TSVE: "TSVE",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PARQUET: "PARQUET",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ORC: "ORC",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  APACHEAVRO: "APACHEAVRO",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  W3CLOGFILE: "W3CLOGFILE",
}

/**
 * The compression type
 */
union Compression {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GZip: "GZip",
}

/**
 * Indication for database routing information from the data connection, by default only database routing information is allowed
 */
union DatabaseRouting {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Single: "Single",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Multi: "Multi",
}

/**
 * The data format of the message. Optionally the data format can be added to each message.
 */
union IotHubDataFormat {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MULTIJSON: "MULTIJSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  JSON: "JSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CSV: "CSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TSV: "TSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SCSV: "SCSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SOHSV: "SOHSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PSV: "PSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TXT: "TXT",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RAW: "RAW",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SINGLEJSON: "SINGLEJSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AVRO: "AVRO",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TSVE: "TSVE",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PARQUET: "PARQUET",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ORC: "ORC",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  APACHEAVRO: "APACHEAVRO",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  W3CLOGFILE: "W3CLOGFILE",
}

/**
 * The data format of the message. Optionally the data format can be added to each message.
 */
union EventGridDataFormat {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MULTIJSON: "MULTIJSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  JSON: "JSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CSV: "CSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TSV: "TSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SCSV: "SCSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SOHSV: "SOHSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PSV: "PSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TXT: "TXT",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RAW: "RAW",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SINGLEJSON: "SINGLEJSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AVRO: "AVRO",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TSVE: "TSVE",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PARQUET: "PARQUET",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ORC: "ORC",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  APACHEAVRO: "APACHEAVRO",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  W3CLOGFILE: "W3CLOGFILE",
}

/**
 * The name of blob storage event type to process.
 */
union BlobStorageEventType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.Storage.BlobCreated`: "Microsoft.Storage.BlobCreated",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.Storage.BlobRenamed`: "Microsoft.Storage.BlobRenamed",
}

/**
 * The type of resource, for instance Microsoft.Kusto/clusters/databases.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum Type {
  `Microsoft.Kusto/clusters/databases`,
  `Microsoft.Kusto/clusters/attachedDatabaseConfigurations`,
}

/**
 * Azure SKU definition.
 */
model AzureSku {
  /**
   * SKU name.
   */
  name: AzureSkuName;

  /**
   * The number of instances of the cluster.
   */
  capacity?: int32;

  /**
   * SKU tier.
   */
  tier: AzureSkuTier;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of managed identity used. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user-assigned identities. The type 'None' will remove all identities.
   */
  type: IdentityType;

  /**
   * The list of user identities associated with the Kusto cluster. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<ComponentsSgqdofSchemasIdentityPropertiesUserassignedidentitiesAdditionalproperties>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ComponentsSgqdofSchemasIdentityPropertiesUserassignedidentitiesAdditionalproperties {
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
}

/**
 * Class representing the Kusto cluster properties.
 */
model ClusterProperties {
  /**
   * The state of the resource.
   */
  @visibility(Lifecycle.Read)
  state?: State;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The cluster URI.
   */
  @visibility(Lifecycle.Read)
  uri?: string;

  /**
   * The cluster data ingestion URI.
   */
  @visibility(Lifecycle.Read)
  dataIngestionUri?: string;

  /**
   * The reason for the cluster's current state.
   */
  @visibility(Lifecycle.Read)
  stateReason?: string;

  /**
   * The cluster's external tenants.
   */
  trustedExternalTenants?: TrustedExternalTenant[];

  /**
   * Optimized auto scale definition.
   */
  optimizedAutoscale?: OptimizedAutoscale;

  /**
   * A boolean value that indicates if the cluster's disks are encrypted.
   */
  enableDiskEncryption?: boolean;

  /**
   * A boolean value that indicates if the streaming ingest is enabled.
   */
  enableStreamingIngest?: boolean;

  /**
   * Virtual network definition.
   */
  virtualNetworkConfiguration?: VirtualNetworkConfiguration;

  /**
   * KeyVault properties for the cluster encryption.
   */
  keyVaultProperties?: KeyVaultProperties;

  /**
   * A boolean value that indicates if the purge operations are enabled.
   */
  enablePurge?: boolean;

  /**
   * List of the cluster's language extensions.
   */
  languageExtensions?: LanguageExtensionsList;

  /**
   * A boolean value that indicates if double encryption is enabled.
   */
  enableDoubleEncryption?: boolean;

  /**
   * Public network access to the cluster is enabled by default. When disabled, only private endpoint connection to the cluster is allowed
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;

  /**
   * The list of ips in the format of CIDR allowed to connect to the cluster.
   */
  allowedIpRangeList?: string[];

  /**
   * The engine type
   */
  engineType?: EngineType = EngineType.V3;

  /**
   * The cluster's accepted audiences.
   */
  acceptedAudiences?: AcceptedAudiences[];

  /**
   * A boolean value that indicates if the cluster could be automatically stopped (due to lack of data or no activity for many days).
   */
  enableAutoStop?: boolean = true;

  /**
   * Whether or not to restrict outbound network access.  Value is optional but if passed in, must be 'Enabled' or 'Disabled'
   */
  restrictOutboundNetworkAccess?: ClusterNetworkAccessFlag = ClusterNetworkAccessFlag.Disabled;

  /**
   * List of allowed FQDNs(Fully Qualified Domain Name) for egress from Cluster.
   */
  allowedFqdnList?: string[];

  /**
   * List of callout policies for egress from Cluster.
   */
  calloutPolicies?: CalloutPolicy[];

  /**
   * Indicates what public IP type to create - IPv4 (default), or DualStack (both IPv4 and IPv6)
   */
  publicIPType?: PublicIPType = PublicIPType.IPv4;

  /**
   * Virtual Cluster graduation properties
   */
  @visibility(Lifecycle.Create)
  virtualClusterGraduationProperties?: string;

  /**
   * A list of private endpoint connections.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Properties of the peer cluster involved in a migration to/from this cluster.
   */
  @visibility(Lifecycle.Read)
  migrationCluster?: MigrationClusterProperties;

  /**
   * Indicates whether the cluster is zonal or non-zonal.
   */
  @visibility(Lifecycle.Read)
  zoneStatus?: ZoneStatus;
}

/**
 * Represents a tenant ID that is trusted by the cluster.
 */
model TrustedExternalTenant {
  /**
   * GUID representing an external tenant.
   */
  value?: string;
}

/**
 * A class that contains the optimized auto scale definition.
 */
model OptimizedAutoscale {
  /**
   * The version of the template defined, for instance 1.
   */
  version: int32;

  /**
   * A boolean value that indicate if the optimized autoscale feature is enabled or not.
   */
  isEnabled: boolean;

  /**
   * Minimum allowed instances count.
   */
  minimum: int32;

  /**
   * Maximum allowed instances count.
   */
  maximum: int32;
}

/**
 * A class that contains virtual network definition.
 */
model VirtualNetworkConfiguration {
  /**
   * The subnet resource id.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  subnetId: string;

  /**
   * Engine service's public IP address resource id.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  enginePublicIpId: string;

  /**
   * Data management's service public IP address resource id.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataManagementPublicIpId: string;

  /**
   * When enabled, the cluster is deployed into the configured subnet, when disabled it will be removed from the subnet.
   */
  state?: VnetState = VnetState.Enabled;
}

/**
 * Properties of the key vault.
 */
model KeyVaultProperties {
  /**
   * The name of the key vault key.
   */
  keyName?: string;

  /**
   * The version of the key vault key.
   */
  keyVersion?: string;

  /**
   * The Uri of the key vault.
   */
  keyVaultUri?: string;

  /**
   * The user assigned identity (ARM resource id) that has access to the key.
   */
  userIdentity?: string;
}

/**
 * The list of language extension objects.
 */
@pagedResult
model LanguageExtensionsList {
  /**
   * The list of language extensions.
   */
  @items
  value?: LanguageExtension[];
}

/**
 * The language extension object.
 */
model LanguageExtension {
  /**
   * The language extension name.
   */
  languageExtensionName?: LanguageExtensionName;

  /**
   * The language extension image name.
   */
  languageExtensionImageName?: LanguageExtensionImageName;

  /**
   * The language extension custom image name.
   */
  languageExtensionCustomImageName?: string;
}

/**
 * Represents an accepted audience trusted by the cluster.
 */
model AcceptedAudiences {
  /**
   * GUID or valid URL representing an accepted audience.
   */
  value?: string;
}

/**
 * Configuration for external callout policies, including URI patterns, access types, and service types.
 */
model CalloutPolicy {
  /**
   * Regular expression or FQDN pattern for the callout URI.
   */
  calloutUriRegex?: string;

  /**
   * Type of the callout service, specifying the kind of external resource or service being accessed.
   */
  calloutType?: CalloutType;

  /**
   * Indicates whether outbound access is permitted for the specified URI pattern.
   */
  outboundAccess?: OutboundAccess;

  /**
   * Unique identifier for the callout configuration.
   */
  @visibility(Lifecycle.Read)
  calloutId?: string;
}

/**
 * Properties of a private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * Private endpoint which the connection belongs to.
   */
  @visibility(Lifecycle.Read)
  privateEndpoint?: PrivateEndpointProperty;

  /**
   * Connection State of the Private Endpoint Connection.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionStateProperty;

  /**
   * Group id of the private endpoint.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * Provisioning state of the private endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Private endpoint which the connection belongs to.
 */
model PrivateEndpointProperty {
  /**
   * Resource id of the private endpoint.
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * Connection State of the Private Endpoint Connection.
 */
model PrivateLinkServiceConnectionStateProperty {
  /**
   * The private link service connection status.
   */
  status?: string;

  /**
   * The private link service connection description.
   */
  description?: string;

  /**
   * Any action that is required beyond basic workflow (approve/ reject/ disconnect)
   */
  @visibility(Lifecycle.Read)
  actionsRequired?: string;
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
 * Represents a properties of a cluster that is part of a migration.
 */
model MigrationClusterProperties {
  /**
   * The resource ID of the cluster.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The public URL of the cluster.
   */
  @visibility(Lifecycle.Read)
  uri?: string;

  /**
   * The public data ingestion URL of the cluster.
   */
  @visibility(Lifecycle.Read)
  dataIngestionUri?: string;

  /**
   * The role of the cluster in the migration process.
   */
  @visibility(Lifecycle.Read)
  role?: MigrationClusterRole;
}

/**
 * Class representing an update to a Kusto cluster.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ClusterUpdate extends Resource {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * Resource location.
   */
  location?: string;

  /**
   * The SKU of the cluster.
   */
  sku?: AzureSku;

  /**
   * The availability zones of the cluster.
   */
  zones?: string[];

  /**
   * The identity of the cluster, if configured.
   */
  identity?: Identity;

  /**
   * The cluster properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ClusterProperties;
}

/**
 * A cluster migrate request.
 */
model ClusterMigrateRequest {
  /**
   * Resource ID of the destination cluster or kusto pool.
   */
  clusterResourceId: string;
}

/**
 * A principal assignment check name availability request.
 */
model ClusterPrincipalAssignmentCheckNameRequest {
  /**
   * Principal Assignment resource name.
   */
  name: string;

  /**
   * The type of resource, Microsoft.Kusto/clusters/principalAssignments.
   */
  type: "Microsoft.Kusto/clusters/principalAssignments";
}

/**
 * The result returned from a check name availability request.
 */
model CheckNameResult {
  /**
   * Specifies a Boolean value that indicates if the name is available.
   */
  nameAvailable?: boolean;

  /**
   * The name that was checked.
   */
  name?: string;

  /**
   * Message indicating an unavailable name due to a conflict, or a description of the naming rules that are violated.
   */
  message?: string;

  /**
   * Message providing the reason why the given name is invalid.
   */
  reason?: Reason;
}

/**
 * A class representing cluster principal property.
 */
model ClusterPrincipalProperties {
  /**
   * The principal ID assigned to the cluster principal. It can be a user email, application ID, or security group name.
   */
  principalId: string;

  /**
   * Cluster principal role.
   */
  role: ClusterPrincipalRole;

  /**
   * The tenant id of the principal
   */
  tenantId?: string;

  /**
   * Principal type.
   */
  principalType: PrincipalType;

  /**
   * The tenant name of the principal
   */
  @visibility(Lifecycle.Read)
  tenantName?: string;

  /**
   * The principal name
   */
  @visibility(Lifecycle.Read)
  principalName?: string;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The service principal object id in AAD (Azure active directory)
   */
  @visibility(Lifecycle.Read)
  aadObjectId?: string;
}

/**
 * The list Kusto cluster principal assignments operation response.
 */
@pagedResult
model ClusterPrincipalAssignmentListResult {
  /**
   * The list of Kusto cluster principal assignments.
   */
  @items
  value?: ClusterPrincipalAssignment[];
}

/**
 * The list Kusto database principals operation response.
 */
model FollowerDatabaseListResultGet
  is Azure.Core.Page<FollowerDatabaseDefinitionGet>;

/**
 * A class representing follower database object.
 */
model FollowerDatabaseDefinitionGet {
  /**
   * Follower database definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: FollowerDatabaseProperties;
}

/**
 * A class representing the properties of a follower database object.
 */
model FollowerDatabaseProperties {
  /**
   * Resource id of the cluster that follows a database owned by this cluster.
   */
  clusterResourceId: string;

  /**
   * Resource name of the attached database configuration in the follower cluster.
   */
  attachedDatabaseConfigurationName: string;

  /**
   * The database name owned by this cluster that was followed. * in case following all databases.
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Table level sharing specifications
   */
  @visibility(Lifecycle.Read)
  tableLevelSharingProperties?: TableLevelSharingProperties;

  /**
   * The origin of the following setup.
   */
  @visibility(Lifecycle.Read)
  databaseShareOrigin?: DatabaseShareOrigin;
}

/**
 * Tables that will be included and excluded in the follower database
 */
model TableLevelSharingProperties {
  /**
   * List of tables to include in the follower database
   */
  tablesToInclude?: string[];

  /**
   * List of tables to exclude from the follower database
   */
  tablesToExclude?: string[];

  /**
   * List of external tables to include in the follower database
   */
  externalTablesToInclude?: string[];

  /**
   * List of external tables to exclude from the follower database
   */
  externalTablesToExclude?: string[];

  /**
   * List of materialized views to include in the follower database
   */
  materializedViewsToInclude?: string[];

  /**
   * List of materialized views to exclude from the follower database
   */
  materializedViewsToExclude?: string[];

  /**
   * List of functions to include in the follower database
   */
  functionsToInclude?: string[];

  /**
   * List of functions to exclude from the follower database
   */
  functionsToExclude?: string[];
}

/**
 * The list Kusto database principals operation response.
 */
@pagedResult
model FollowerDatabaseListResult {
  /**
   * The list of follower database result.
   */
  @items
  value?: FollowerDatabaseDefinition[];
}

/**
 * A class representing follower database request.
 */
model FollowerDatabaseDefinition {
  /**
   * Resource id of the cluster that follows a database owned by this cluster.
   */
  clusterResourceId: string;

  /**
   * Resource name of the attached database configuration in the follower cluster.
   */
  attachedDatabaseConfigurationName: string;

  /**
   * The database name owned by this cluster that was followed. * in case following all databases.
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Table level sharing specifications
   */
  @visibility(Lifecycle.Read)
  tableLevelSharingProperties?: TableLevelSharingProperties;

  /**
   * The origin of the following setup.
   */
  @visibility(Lifecycle.Read)
  databaseShareOrigin?: DatabaseShareOrigin;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DiagnoseVirtualNetworkResult {
  /**
   * The list of network connectivity diagnostic finding
   */
  findings?: string[];
}

/**
 * The list Kusto clusters operation response.
 */
@pagedResult
model ClusterListResult {
  /**
   * The list of Kusto clusters.
   */
  @items
  value?: Cluster[];
}

/**
 * The list of the EngagementFabric SKU descriptions
 */
@pagedResult
model SkuDescriptionList {
  /**
   * SKU descriptions
   */
  @visibility(Lifecycle.Read)
  @items
  value?: SkuDescription[];
}

/**
 * The Kusto SKU description of given resource type
 */
model SkuDescription {
  /**
   * The resource type
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The name of the SKU
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The tier of the SKU
   */
  @visibility(Lifecycle.Read)
  tier?: string;

  /**
   * The set of locations that the SKU is available
   */
  @visibility(Lifecycle.Read)
  locations?: string[];

  /**
   * Locations and zones
   */
  @visibility(Lifecycle.Read)
  locationInfo?: SkuLocationInfoItem[];

  /**
   * The restrictions because of which SKU cannot be used
   */
  @visibility(Lifecycle.Read)
  restrictions?: Record<unknown>[];
}

/**
 * The locations and zones info for SKU.
 */
model SkuLocationInfoItem {
  /**
   * The available location of the SKU.
   */
  location: string;

  /**
   * The available zone of the SKU.
   */
  zones?: string[];

  /**
   * Gets details of capabilities available to a SKU in specific zones.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  zoneDetails?: ResourceSkuZoneDetails[];
}

/**
 * Describes The zonal capabilities of a SKU.
 */
model ResourceSkuZoneDetails {
  /**
   * The set of zones that the SKU is available in with the specified capabilities.
   */
  @visibility(Lifecycle.Read)
  name?: string[];

  /**
   * A list of capabilities that are available for the SKU in the specified list of zones.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  capabilities?: ResourceSkuCapabilities[];
}

/**
 * Describes The SKU capabilities object.
 */
model ResourceSkuCapabilities {
  /**
   * An invariant to describe the feature.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * An invariant if the feature is measured by quantity.
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * The result returned from a cluster check name availability request.
 */
model ClusterCheckNameRequest {
  /**
   * Cluster name.
   */
  name: string;

  /**
   * The type of resource, Microsoft.Kusto/clusters.
   */
  type: "Microsoft.Kusto/clusters";
}

/**
 * The result returned from a database check name availability request.
 */
model CheckNameRequest {
  /**
   * Resource name.
   */
  name: string;

  /**
   * The type of resource, for instance Microsoft.Kusto/clusters/databases.
   */
  type: Type;
}

/**
 * The result returned from a AttachedDatabaseConfigurations check name availability request.
 */
model AttachedDatabaseConfigurationsCheckNameRequest {
  /**
   * Attached database resource name.
   */
  name: string;

  /**
   * The type of resource, for instance Microsoft.Kusto/clusters/attachedDatabaseConfigurations.
   */
  type: "Microsoft.Kusto/clusters/attachedDatabaseConfigurations";
}

/**
 * The result returned from a managedPrivateEndpoints check name availability request.
 */
model ManagedPrivateEndpointsCheckNameRequest {
  /**
   * Managed private endpoint resource name.
   */
  name: string;

  /**
   * The type of resource, for instance Microsoft.Kusto/clusters/managedPrivateEndpoints.
   */
  type: "Microsoft.Kusto/clusters/managedPrivateEndpoints";
}

/**
 * List of available SKUs for a Kusto Cluster.
 */
@pagedResult
model ListResourceSkusResult {
  /**
   * The collection of available SKUs for an existing resource.
   */
  @items
  value?: AzureResourceSku[];
}

/**
 * Azure resource SKU definition.
 */
model AzureResourceSku {
  /**
   * Resource Namespace and Type.
   */
  resourceType?: string;

  /**
   * The SKU details.
   */
  sku?: AzureSku;

  /**
   * The number of instances of the cluster.
   */
  capacity?: AzureCapacity;
}

/**
 * Azure capacity definition.
 */
model AzureCapacity {
  /**
   * Scale type.
   */
  scaleType: AzureScaleType;

  /**
   * Minimum allowed capacity.
   */
  minimum: int32;

  /**
   * Maximum allowed capacity.
   */
  maximum: int32;

  /**
   * The default capacity that would be used.
   */
  default: int32;
}

/**
 * The request to invite a follower to a database.
 */
model DatabaseInviteFollowerRequest {
  /**
   * The email of the invited user for which the follower invitation is generated.
   */
  inviteeEmail: string;

  /**
   * Table level sharing specifications
   */
  tableLevelSharingProperties?: TableLevelSharingProperties;
}

/**
 * The result returned from a follower invitation generation request.
 */
model DatabaseInviteFollowerResult {
  /**
   * The generated invitation token.
   */
  generatedInvitation?: string;
}

/**
 * A principal assignment check name availability request.
 */
model DatabasePrincipalAssignmentCheckNameRequest {
  /**
   * Principal Assignment resource name.
   */
  name: string;

  /**
   * The type of resource, Microsoft.Kusto/clusters/databases/principalAssignments.
   */
  type: "Microsoft.Kusto/clusters/databases/principalAssignments";
}

/**
 * A class representing database principal property.
 */
model DatabasePrincipalProperties {
  /**
   * The principal ID assigned to the database principal. It can be a user email, application ID, or security group name.
   */
  principalId: string;

  /**
   * Database principal role.
   */
  role: DatabasePrincipalRole;

  /**
   * The tenant id of the principal
   */
  tenantId?: string;

  /**
   * Principal type.
   */
  principalType: PrincipalType;

  /**
   * The tenant name of the principal
   */
  @visibility(Lifecycle.Read)
  tenantName?: string;

  /**
   * The principal name
   */
  @visibility(Lifecycle.Read)
  principalName?: string;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The service principal object id in AAD (Azure active directory)
   */
  @visibility(Lifecycle.Read)
  aadObjectId?: string;
}

/**
 * The list Kusto database principal assignments operation response.
 */
@pagedResult
model DatabasePrincipalAssignmentListResult {
  /**
   * The list of Kusto database principal assignments.
   */
  @items
  value?: DatabasePrincipalAssignment[];
}

/**
 * The list Kusto database principals operation response.
 */
@pagedResult
model DatabasePrincipalListResult {
  /**
   * The list of Kusto database principals.
   */
  @items
  value?: DatabasePrincipal[];
}

/**
 * A class representing database principal entity.
 */
model DatabasePrincipal {
  /**
   * Database principal role.
   */
  role: DatabasePrincipalRole;

  /**
   * Database principal name.
   */
  name: string;

  /**
   * Database principal type.
   */
  type: DatabasePrincipalType;

  /**
   * Database principal fully qualified name.
   */
  fqn?: string;

  /**
   * Database principal email if exists.
   */
  email?: string;

  /**
   * Application id - relevant only for application principal type.
   */
  appId?: string;

  /**
   * The tenant name of the principal
   */
  @visibility(Lifecycle.Read)
  tenantName?: string;
}

/**
 * The list Kusto database principals operation request.
 */
model DatabasePrincipalListRequest {
  /**
   * The list of Kusto database principals.
   */
  value?: DatabasePrincipal[];
}

/**
 * The list Kusto database script operation response.
 */
@pagedResult
model ScriptListResult {
  /**
   * The list of Kusto scripts.
   */
  @items
  value?: Script[];
}

/**
 * A class representing database script property.
 */
model ScriptProperties {
  /**
   * The url to the KQL script blob file. Must not be used together with scriptContent property
   */
  scriptUrl?: string;

  /**
   * The SaS token that provide read access to the file which contain the script. Must be provided when using scriptUrl property.
   */
  @visibility(Lifecycle.Create)
  scriptUrlSasToken?: string;

  /**
   * The script content. This property should be used when the script is provide inline and not through file in a SA. Must not be used together with scriptUrl and scriptUrlSasToken properties.
   */
  @visibility(Lifecycle.Create)
  scriptContent?: string;

  /**
   * A unique string. If changed the script will be applied again.
   */
  forceUpdateTag?: string;

  /**
   * Flag that indicates whether to continue if one of the command fails.
   */
  continueOnErrors?: boolean;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Differentiates between the type of script commands included - Database or Cluster. The default is Database.
   */
  scriptLevel?: ScriptLevel;

  /**
   * Indicates if the permissions for the script caller are kept following completion of the script.
   */
  principalPermissionsAction?: PrincipalPermissionsAction;
}

/**
 * A class representing the properties of a sandbox custom image object.
 */
model SandboxCustomImageProperties {
  /**
   * The language name, for example Python.
   */
  language: Language;

  /**
   * The version of the language. Either this property or baseImageName should be specified.
   */
  languageVersion?: string;

  /**
   * The base image name on which the custom image is built on top of. It can be one of the LanguageExtensionImageName (e.g.: 'Python3_10_8', 'Python3_10_8_DL') or the name of an existing custom image. Either this property or languageVersion should be specified.
   */
  baseImageName?: string;

  /**
   * The requirements file content.
   */
  requirementsFileContent?: string;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The result returned from a sandboxCustomImage check name availability request.
 */
model SandboxCustomImagesCheckNameRequest {
  /**
   * Sandbox custom image resource name.
   */
  name: string;

  /**
   * The type of resource, for instance Microsoft.Kusto/clusters/sandboxCustomImages.
   */
  type: "Microsoft.Kusto/clusters/sandboxCustomImages";
}

/**
 * The list managed private endpoints operation response.
 */
@pagedResult
model ManagedPrivateEndpointListResult {
  /**
   * The list of managed private endpoints.
   */
  @items
  value?: ManagedPrivateEndpoint[];
}

/**
 * A class representing the properties of a managed private endpoint object.
 */
model ManagedPrivateEndpointProperties {
  /**
   * The ARM resource ID of the resource for which the managed private endpoint is created.
   */
  privateLinkResourceId: string;

  /**
   * The region of the resource to which the managed private endpoint is created.
   */
  privateLinkResourceRegion?: string;

  /**
   * The groupId in which the managed private endpoint is created.
   */
  groupId: string;

  /**
   * The user request message.
   */
  requestMessage?: string;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * A list of private endpoint connections
 */
@pagedResult
model PrivateEndpointConnectionListResult {
  /**
   * Array of private endpoint connections
   */
  @items
  value?: PrivateEndpointConnection[];
}

/**
 * A list of private link resources
 */
@pagedResult
model PrivateLinkResourceListResult {
  /**
   * Array of private link resources
   */
  @items
  value?: PrivateLinkResource[];
}

/**
 * Properties of a private link resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
   * The private link resource required zone names.
   */
  @visibility(Lifecycle.Read)
  requiredZoneNames?: string[];
}

/**
 * Endpoints accessed for a common purpose that the Kusto Service Environment requires outbound network access to.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OutboundNetworkDependenciesEndpoint extends ProxyResource {
  /**
   * The outbound environment endpoint properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: OutboundNetworkDependenciesEndpointProperties;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Endpoints accessed for a common purpose that the Kusto Service Environment requires outbound network access to.
 */
model OutboundNetworkDependenciesEndpointProperties {
  /**
   * The type of service accessed by the Kusto Service Environment, e.g., Azure Storage, Azure SQL Database, and Azure Active Directory.
   */
  category?: string;

  /**
   * The endpoints that the Kusto Service Environment reaches the service at.
   */
  endpoints?: EndpointDependency[];

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * A domain name that a service is reached at, including details of the current connection status.
 */
model EndpointDependency {
  /**
   * The domain name of the dependency.
   */
  domainName?: string;

  /**
   * The ports used when connecting to DomainName.
   */
  endpointDetails?: EndpointDetail[];
}

/**
 * Current TCP connectivity information from the Kusto cluster to a single endpoint.
 */
model EndpointDetail {
  /**
   * The port an endpoint is connected to.
   */
  port?: int32;

  /**
   * The ip address of the endpoint.
   */
  ipAddress?: string;
}

/**
 * The list attached database configurations operation response.
 */
@pagedResult
model AttachedDatabaseConfigurationListResult {
  /**
   * The list of attached database configurations.
   */
  @items
  value?: AttachedDatabaseConfiguration[];
}

/**
 * Class representing the an attached database configuration properties of kind specific.
 */
model AttachedDatabaseConfigurationProperties {
  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The name of the database which you would like to attach, use * if you want to follow all current and future databases.
   */
  databaseName: string;

  /**
   * The resource id of the cluster where the databases you would like to attach reside.
   */
  clusterResourceId: string;

  /**
   * The list of databases from the clusterResourceId which are currently attached to the cluster.
   */
  @visibility(Lifecycle.Read)
  attachedDatabaseNames?: string[];

  /**
   * The default principals modification kind
   */
  defaultPrincipalsModificationKind: DefaultPrincipalsModificationKind;

  /**
   * Table level sharing specifications
   */
  tableLevelSharingProperties?: TableLevelSharingProperties;

  /**
   * Overrides the original database name. Relevant only when attaching to a specific database.
   */
  databaseNameOverride?: string;

  /**
   * Adds a prefix to the attached databases name. When following an entire cluster, that prefix would be added to all of the databases original names from leader cluster.
   */
  databaseNamePrefix?: string;
}

/**
 * The list Kusto data connections operation response.
 */
@pagedResult
model DataConnectionListResult {
  /**
   * The list of Kusto data connections.
   */
  @items
  value?: DataConnection[];
}

/**
 * Class representing an data connection validation.
 */
model DataConnectionValidation {
  /**
   * The name of the data connection.
   */
  dataConnectionName?: string;

  /**
   * The data connection properties to validate.
   */
  properties?: DataConnection;
}

/**
 * The list Kusto data connection validation result.
 */
model DataConnectionValidationListResult {
  /**
   * The list of Kusto data connection validation errors.
   */
  value?: DataConnectionValidationResult[];
}

/**
 * The result returned from a data connection validation request.
 */
model DataConnectionValidationResult {
  /**
   * A message which indicates a problem in data connection validation.
   */
  errorMessage?: string;
}

/**
 * A data connection check name availability request.
 */
model DataConnectionCheckNameRequest {
  /**
   * Data Connection name.
   */
  name: string;

  /**
   * The type of resource, Microsoft.Kusto/clusters/databases/dataConnections.
   */
  type: "Microsoft.Kusto/clusters/databases/dataConnections";
}

/**
 * A script name availability request.
 */
model ScriptCheckNameRequest {
  /**
   * Script name.
   */
  name: string;

  /**
   * The type of resource, Microsoft.Kusto/clusters/databases/scripts.
   */
  type: "Microsoft.Kusto/clusters/databases/scripts";
}

/**
 * A list of the service's callout policy objects.
 */
model CalloutPoliciesList is Azure.Core.Page<CalloutPolicy>;

/**
 * Configuration for an external callout policy to remove.
 */
model CalloutPolicyToRemove {
  /**
   * Unique identifier for the callout configuration.
   */
  calloutId?: string;
}

/**
 * Operation Result Entity.
 */
model OperationResult {
  /**
   * ID of the resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * status of the Operation result.
   */
  @visibility(Lifecycle.Read)
  status?: Status;

  /**
   * The operation start time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The operation end time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Percentage completed.
   */
  @maxValue(100)
  percentComplete?: float64;

  /**
   * Properties of the operation results
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: OperationResultProperties;

  /**
   * Object that contains the error code and message if the operation failed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  error?: OperationResultErrorProperties;
}

/**
 * Operation result properties
 */
model OperationResultProperties {
  /**
   * The kind of the operation.
   */
  operationKind?: string;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The state of the operation.
   */
  operationState?: string;
}

/**
 * Operation result error properties
 */
model OperationResultErrorProperties {
  /**
   * The code of the error.
   */
  code?: string;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * A class that contains database statistics information.
 */
model DatabaseStatistics {
  /**
   * The database size - the total size of compressed data and index in bytes.
   */
  size?: float32;
}

/**
 * Class representing the Kusto database properties.
 */
model ReadWriteDatabaseProperties {
  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The time the data should be kept before it stops being accessible to queries in TimeSpan.
   */
  softDeletePeriod?: duration;

  /**
   * The time the data should be kept in cache for fast queries in TimeSpan.
   */
  hotCachePeriod?: duration;

  /**
   * The statistics of the database.
   */
  @visibility(Lifecycle.Read)
  statistics?: DatabaseStatistics;

  /**
   * Indicates whether the database is followed.
   */
  @visibility(Lifecycle.Read)
  isFollowed?: boolean;

  /**
   * KeyVault properties for the database encryption.
   */
  keyVaultProperties?: KeyVaultProperties;

  /**
   * The database suspension details. If the database is suspended, this object contains information related to the database's suspension state.
   */
  @visibility(Lifecycle.Read)
  suspensionDetails?: SuspensionDetails;
}

/**
 * The database suspension details. If the database is suspended, this object contains information related to the database's suspension state.
 */
model SuspensionDetails {
  /**
   * The starting date and time of the suspension state.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  suspensionStartDate?: utcDateTime;
}

/**
 * Class representing the Kusto database properties.
 */
model ReadOnlyFollowingDatabaseProperties {
  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The time the data should be kept before it stops being accessible to queries in TimeSpan.
   */
  @visibility(Lifecycle.Read)
  softDeletePeriod?: duration;

  /**
   * The time the data should be kept in cache for fast queries in TimeSpan.
   */
  hotCachePeriod?: duration;

  /**
   * The statistics of the database.
   */
  @visibility(Lifecycle.Read)
  statistics?: DatabaseStatistics;

  /**
   * The name of the leader cluster
   */
  @visibility(Lifecycle.Read)
  leaderClusterResourceId?: string;

  /**
   * The name of the attached database configuration cluster
   */
  @visibility(Lifecycle.Read)
  attachedDatabaseConfigurationName?: string;

  /**
   * The principals modification kind of the database
   */
  @visibility(Lifecycle.Read)
  principalsModificationKind?: PrincipalsModificationKind;

  /**
   * Table level sharing specifications
   */
  @visibility(Lifecycle.Read)
  tableLevelSharingProperties?: TableLevelSharingProperties;

  /**
   * The original database name, before databaseNameOverride or databaseNamePrefix where applied.
   */
  @visibility(Lifecycle.Read)
  originalDatabaseName?: string;

  /**
   * The origin of the following setup.
   */
  @visibility(Lifecycle.Read)
  databaseShareOrigin?: DatabaseShareOrigin;

  /**
   * The database suspension details. If the database is suspended, this object contains information related to the database's suspension state.
   */
  @visibility(Lifecycle.Read)
  suspensionDetails?: SuspensionDetails;
}

/**
 * Class representing the Kusto event hub connection properties.
 */
model EventHubConnectionProperties {
  /**
   * The resource ID of the event hub to be used to create a data connection.
   */
  eventHubResourceId: string;

  /**
   * The event hub consumer group.
   */
  consumerGroup: string;

  /**
   * The table where the data should be ingested. Optionally the table information can be added to each message.
   */
  tableName?: string;

  /**
   * The mapping rule to be used to ingest the data. Optionally the mapping information can be added to each message.
   */
  mappingRuleName?: string;

  /**
   * The data format of the message. Optionally the data format can be added to each message.
   */
  dataFormat?: EventHubDataFormat;

  /**
   * System properties of the event hub
   */
  eventSystemProperties?: string[];

  /**
   * The event hub messages compression type
   */
  compression?: Compression = Compression.None;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The resource ID of a managed identity (system or user assigned) to be used to authenticate with event hub.
   */
  managedIdentityResourceId?: string;

  /**
   * The object ID of the managedIdentityResourceId
   */
  @visibility(Lifecycle.Read)
  managedIdentityObjectId?: string;

  /**
   * Indication for database routing information from the data connection, by default only database routing information is allowed
   */
  databaseRouting?: DatabaseRouting;

  /**
   * When defined, the data connection retrieves existing Event hub events created since the Retrieval start date. It can only retrieve events retained by the Event hub, based on its retention period.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  retrievalStartDate?: utcDateTime;
}

/**
 * Class representing the Kusto Iot hub connection properties.
 */
model IotHubConnectionProperties {
  /**
   * The resource ID of the Iot hub to be used to create a data connection.
   */
  iotHubResourceId: string;

  /**
   * The iot hub consumer group.
   */
  consumerGroup: string;

  /**
   * The table where the data should be ingested. Optionally the table information can be added to each message.
   */
  tableName?: string;

  /**
   * The mapping rule to be used to ingest the data. Optionally the mapping information can be added to each message.
   */
  mappingRuleName?: string;

  /**
   * The data format of the message. Optionally the data format can be added to each message.
   */
  dataFormat?: IotHubDataFormat;

  /**
   * System properties of the iot hub
   */
  eventSystemProperties?: string[];

  /**
   * The name of the share access policy
   */
  sharedAccessPolicyName: string;

  /**
   * Indication for database routing information from the data connection, by default only database routing information is allowed
   */
  databaseRouting?: DatabaseRouting;

  /**
   * When defined, the data connection retrieves existing Event hub events created since the Retrieval start date. It can only retrieve events retained by the Event hub, based on its retention period.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  retrievalStartDate?: utcDateTime;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Class representing the Kusto event grid connection properties.
 */
model EventGridConnectionProperties {
  /**
   * The resource ID of the storage account where the data resides.
   */
  storageAccountResourceId: string;

  /**
   * The resource ID of the event grid that is subscribed to the storage account events.
   */
  eventGridResourceId?: string;

  /**
   * The resource ID where the event grid is configured to send events.
   */
  eventHubResourceId: string;

  /**
   * The event hub consumer group.
   */
  consumerGroup: string;

  /**
   * The table where the data should be ingested. Optionally the table information can be added to each message.
   */
  tableName?: string;

  /**
   * The mapping rule to be used to ingest the data. Optionally the mapping information can be added to each message.
   */
  mappingRuleName?: string;

  /**
   * The data format of the message. Optionally the data format can be added to each message.
   */
  dataFormat?: EventGridDataFormat;

  /**
   * A Boolean value that, if set to true, indicates that ingestion should ignore the first record of every file
   */
  ignoreFirstRecord?: boolean;

  /**
   * The name of blob storage event type to process.
   */
  blobStorageEventType?: BlobStorageEventType;

  /**
   * The resource ID of a managed identity (system or user assigned) to be used to authenticate with event hub and storage account.
   */
  managedIdentityResourceId?: string;

  /**
   * The object ID of managedIdentityResourceId
   */
  @visibility(Lifecycle.Read)
  managedIdentityObjectId?: string;

  /**
   * Indication for database routing information from the data connection, by default only database routing information is allowed
   */
  databaseRouting?: DatabaseRouting;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Class representing the Kusto CosmosDb data connection properties.
 */
model CosmosDbDataConnectionProperties {
  /**
   * The case-sensitive name of the existing target table in your cluster. Retrieved data is ingested into this table.
   */
  tableName: string;

  /**
   * The name of an existing mapping rule to use when ingesting the retrieved data.
   */
  mappingRuleName?: string;

  /**
   * The resource ID of a managed system or user-assigned identity. The identity is used to authenticate with Cosmos DB.
   */
  managedIdentityResourceId: string;

  /**
   * The object ID of the managed identity resource.
   */
  @visibility(Lifecycle.Read)
  managedIdentityObjectId?: string;

  /**
   * The resource ID of the Cosmos DB account used to create the data connection.
   */
  cosmosDbAccountResourceId: string;

  /**
   * The name of an existing database in the Cosmos DB account.
   */
  cosmosDbDatabase: string;

  /**
   * The name of an existing container in the Cosmos DB database.
   */
  cosmosDbContainer: string;

  /**
   * Optional. If defined, the data connection retrieves Cosmos DB documents created or updated after the specified retrieval start date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  retrievalStartDate?: utcDateTime;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Class representing a read write database.
 */
model ReadWriteDatabase extends Database {
  /**
   * The database properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ReadWriteDatabaseProperties;

  /**
   * Kind of the database
   */
  kind: "ReadWrite";
}

/**
 * Class representing a read only following database.
 */
model ReadOnlyFollowingDatabase extends Database {
  /**
   * The database properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ReadOnlyFollowingDatabaseProperties;

  /**
   * Kind of the database
   */
  kind: "ReadOnlyFollowing";
}

/**
 * Class representing an event hub data connection.
 */
model EventHubDataConnection extends DataConnection {
  /**
   * The Event Hub data connection properties to validate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: EventHubConnectionProperties;

  /**
   * Kind of the endpoint for the data connection
   */
  kind: "EventHub";
}

/**
 * Class representing an iot hub data connection.
 */
model IotHubDataConnection extends DataConnection {
  /**
   * The Iot Hub data connection properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: IotHubConnectionProperties;

  /**
   * Kind of the endpoint for the data connection
   */
  kind: "IotHub";
}

/**
 * Class representing an Event Grid data connection.
 */
model EventGridDataConnection extends DataConnection {
  /**
   * The properties of the Event Grid data connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: EventGridConnectionProperties;

  /**
   * Kind of the endpoint for the data connection
   */
  kind: "EventGrid";
}

/**
 * Class representing a CosmosDb data connection.
 */
model CosmosDbDataConnection extends DataConnection {
  /**
   * The properties of the CosmosDb data connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: CosmosDbDataConnectionProperties;

  /**
   * Kind of the endpoint for the data connection
   */
  kind: "CosmosDb";
}
