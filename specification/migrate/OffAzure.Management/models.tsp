import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.OffAzure;

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,

  /**
   * user
   */
  User: "user",

  /**
   * system
   */
  System: "system",

  /**
   * user,system
   */
  UserSystem: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,

  /**
   * Internal
   */
  Internal: "Internal",
}

/**
 * Site properties DiscoveryScenario
 */
union DiscoveryScenario {
  string,

  /**
   * Migrate value.
   */
  Migrate: "Migrate",

  /**
   * DR value.
   */
  DR: "DR",
}

/**
 * The status of the current operation.
 */
union ProvisioningState {
  string,

  /**
   * Created value.
   */
  Created: "Created",

  /**
   * Updated value.
   */
  Updated: "Updated",

  /**
   * Running value.
   */
  Running: "Running",

  /**
   * Completed value.
   */
  Completed: "Completed",

  /**
   * Failed value.
   */
  Failed: "Failed",

  /**
   * Succeeded value.
   */
  Succeeded: "Succeeded",

  /**
   * Canceled value.
   */
  Canceled: "Canceled",
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
 * PublicNetworkAccess
 */
union MasterSitePropertiesPublicNetworkAccess {
  string,

  /**
   * NotSpecified value.
   */
  NotSpecified: "NotSpecified",

  /**
   * Enabled value.
   */
  Enabled: "Enabled",

  /**
   * Disabled value.
   */
  Disabled: "Disabled",
}

/**
 * PrivateLinkServiceConnectionState
 */
union PrivateLinkServiceConnectionStateStatus {
  string,

  /**
   * Approved value.
   */
  Approved: "Approved",

  /**
   * Pending value.
   */
  Pending: "Pending",

  /**
   * Rejected value.
   */
  Rejected: "Rejected",

  /**
   * Disconnected value.
   */
  Disconnected: "Disconnected",
}

/**
 * Arc site scope type.
 */
union ArcSiteScopeType {
  string,

  /**
   * Scope is based on Subscription or Resource Group IDs.
   */
  SubscriptionOrResourceGroupIds: "SubscriptionOrResourceGroupIds",
}

/**
 * Arc sync type.
 */
union ArcSyncType {
  string,

  /**
   * On-demand sync of arc resources.
   */
  Manual: "Manual",

  /**
   * Periodic sync of arc resources.
   */
  Periodic: "Periodic",
}

/**
 * Tag sync mode.
 */
union TagSyncMode {
  string,

  /**
   * Enable tag sync of arc resources.
   */
  Enabled: "Enabled",

  /**
   * Disable tag sync of arc resources.
   */
  Disabled: "Disabled",
}

/**
 * HealthError Details Source
 */
union HealthErrorDetailsSource {
  string,

  /**
   * RefreshFabricLayout value.
   */
  RefreshFabricLayout: "RefreshFabricLayout",

  /**
   * RefreshFabricLayoutGuest value.
   */
  RefreshFabricLayoutGuest: "RefreshFabricLayoutGuest",

  /**
   * RefreshFabricLayoutDependencyMap value.
   */
  RefreshFabricLayoutDependencyMap: "RefreshFabricLayoutDependencyMap",
}

/**
 * Gets discovery scope for which             error is encountered.
 */
union HealthErrorDetailsDiscoveryScope {
  string,

  /**
   * AppsAndRoles value.
   */
  AppsAndRoles: "AppsAndRoles",

  /**
   * DependencyMap value.
   */
  DependencyMap: "DependencyMap",

  /**
   * StaticData value.
   */
  StaticData: "StaticData",

  /**
   * SQLServerConnectionInfo value.
   */
  SQLServerConnectionInfo: "SQLServerConnectionInfo",

  /**
   * DiscoveryTargets value.
   */
  DiscoveryTargets: "DiscoveryTargets",
}

/**
 * Discovery scopes
 */
union DiscoveryScopes {
  string,

  /**
   * AppsAndRoles value.
   */
  AppsAndRoles: "AppsAndRoles",

  /**
   * DependencyMap value.
   */
  DependencyMap: "DependencyMap",

  /**
   * StaticData value.
   */
  StaticData: "StaticData",

  /**
   * SQLServerConnectionInfo value.
   */
  SQLServerConnectionInfo: "SQLServerConnectionInfo",
}

/**
 * Export Machine Errors Properties
 */
union ExportMachineErrorsProperties {
  string,

  /**
   * AppsAndRoles value.
   */
  AppsAndRoles: "AppsAndRoles",

  /**
   * DependencyMap value.
   */
  DependencyMap: "DependencyMap",

  /**
   * StaticData value.
   */
  StaticData: "StaticData",

  /**
   * SQLServerConnectionInfo value.
   */
  SQLServerConnectionInfo: "SQLServerConnectionInfo",
}

/**
 * SiteHealthSummary FabricLayout UpdateSources
 */
union SiteHealthSummaryFabricLayoutUpdateSourcesItem {
  string,

  /**
   * RefreshFabricLayout value.
   */
  RefreshFabricLayout: "RefreshFabricLayout",

  /**
   * RefreshFabricLayoutGuest value.
   */
  RefreshFabricLayoutGuest: "RefreshFabricLayoutGuest",

  /**
   * RefreshFabricLayoutDependencyMap value.
   */
  RefreshFabricLayoutDependencyMap: "RefreshFabricLayoutDependencyMap",
}

/**
 * Value indicating whether the VM is highly available
 */
union HighAvailability {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * No value.
   */
  No: "No",

  /**
   * Yes value.
   */
  Yes: "Yes",
}

/**
 * Application Discovery Scope Status
 */
union ApplicationDiscoveryScopeStatus {
  string,

  /**
   * DiscoverySucceededAtleastOnce value.
   */
  DiscoverySucceededAtleastOnce: "DiscoverySucceededAtleastOnce",

  /**
   * DiscoveryFailed value.
   */
  DiscoveryFailed: "DiscoveryFailed",

  /**
   * RunAsAccountNotAssociated value.
   */
  RunAsAccountNotAssociated: "RunAsAccountNotAssociated",

  /**
   * DiscoveryNotStarted value.
   */
  DiscoveryNotStarted: "DiscoveryNotStarted",

  /**
   * DiscoveryInProgress value.
   */
  DiscoveryInProgress: "DiscoveryInProgress",

  /**
   * Disabled value.
   */
  Disabled: "Disabled",

  /**
   * DiscoveryPartiallySucceded value.
   */
  DiscoveryPartiallySucceded: "DiscoveryPartiallySucceded",

  /**
   * DiscoverySucceeded value.
   */
  DiscoverySucceeded: "DiscoverySucceeded",
}

/**
 * DependencyMap DiscoveryScope Status
 */
union DependencyMapDiscoveryScopeStatus {
  string,

  /**
   * DiscoverySucceededAtleastOnce value.
   */
  DiscoverySucceededAtleastOnce: "DiscoverySucceededAtleastOnce",

  /**
   * DiscoveryFailed value.
   */
  DiscoveryFailed: "DiscoveryFailed",

  /**
   * RunAsAccountNotAssociated value.
   */
  RunAsAccountNotAssociated: "RunAsAccountNotAssociated",

  /**
   * DiscoveryNotStarted value.
   */
  DiscoveryNotStarted: "DiscoveryNotStarted",

  /**
   * DiscoveryInProgress value.
   */
  DiscoveryInProgress: "DiscoveryInProgress",

  /**
   * Disabled value.
   */
  Disabled: "Disabled",

  /**
   * DiscoveryPartiallySucceded value.
   */
  DiscoveryPartiallySucceded: "DiscoveryPartiallySucceded",

  /**
   * DiscoverySucceeded value.
   */
  DiscoverySucceeded: "DiscoverySucceeded",
}

/**
 * Static DiscoveryScopeStatus
 */
union StaticDiscoveryScopeStatus {
  string,

  /**
   * DiscoverySucceededAtleastOnce value.
   */
  DiscoverySucceededAtleastOnce: "DiscoverySucceededAtleastOnce",

  /**
   * DiscoveryFailed value.
   */
  DiscoveryFailed: "DiscoveryFailed",

  /**
   * RunAsAccountNotAssociated value.
   */
  RunAsAccountNotAssociated: "RunAsAccountNotAssociated",

  /**
   * DiscoveryNotStarted value.
   */
  DiscoveryNotStarted: "DiscoveryNotStarted",

  /**
   * DiscoveryInProgress value.
   */
  DiscoveryInProgress: "DiscoveryInProgress",

  /**
   * Disabled value.
   */
  Disabled: "Disabled",

  /**
   * DiscoveryPartiallySucceded value.
   */
  DiscoveryPartiallySucceded: "DiscoveryPartiallySucceded",

  /**
   * DiscoverySucceeded value.
   */
  DiscoverySucceeded: "DiscoverySucceeded",
}

/**
 * SQL metadata discovery pipe
 */
union SqlMetadataDiscoveryPipe {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * VMware value.
   */
  VMware: "VMware",

  /**
   * PowerShell value.
   */
  PowerShell: "PowerShell",

  /**
   * SSH value.
   */
  SSH: "SSH",

  /**
   * CIM value.
   */
  CIM: "CIM",

  /**
   * Other value.
   */
  Other: "Other",
}

/**
 * SQLDiscoveryScope Status
 */
union SQLDiscoveryScopeStatus {
  string,

  /**
   * DiscoverySucceededAtleastOnce value.
   */
  DiscoverySucceededAtleastOnce: "DiscoverySucceededAtleastOnce",

  /**
   * DiscoveryFailed value.
   */
  DiscoveryFailed: "DiscoveryFailed",

  /**
   * RunAsAccountNotAssociated value.
   */
  RunAsAccountNotAssociated: "RunAsAccountNotAssociated",

  /**
   * DiscoveryNotStarted value.
   */
  DiscoveryNotStarted: "DiscoveryNotStarted",

  /**
   * DiscoveryInProgress value.
   */
  DiscoveryInProgress: "DiscoveryInProgress",

  /**
   * Disabled value.
   */
  Disabled: "Disabled",

  /**
   * DiscoveryPartiallySucceded value.
   */
  DiscoveryPartiallySucceded: "DiscoveryPartiallySucceded",

  /**
   * DiscoverySucceeded value.
   */
  DiscoverySucceeded: "DiscoverySucceeded",
}

/**
 * Discovery Scope.
 */
union DiscoveryScopeStatus {
  string,

  /**
   * DiscoverySucceededAtleastOnce value.
   */
  DiscoverySucceededAtleastOnce: "DiscoverySucceededAtleastOnce",

  /**
   * DiscoveryFailed value.
   */
  DiscoveryFailed: "DiscoveryFailed",

  /**
   * RunAsAccountNotAssociated value.
   */
  RunAsAccountNotAssociated: "RunAsAccountNotAssociated",

  /**
   * DiscoveryNotStarted value.
   */
  DiscoveryNotStarted: "DiscoveryNotStarted",

  /**
   * DiscoveryInProgress value.
   */
  DiscoveryInProgress: "DiscoveryInProgress",

  /**
   * Disabled value.
   */
  Disabled: "Disabled",

  /**
   * DiscoveryPartiallySucceded value.
   */
  DiscoveryPartiallySucceded: "DiscoveryPartiallySucceded",

  /**
   * DiscoverySucceeded value.
   */
  DiscoverySucceeded: "DiscoverySucceeded",
}

/**
 * Shallow Discovery Status.
 */
union ShallowDiscoveryStatus {
  string,

  /**
   * DiscoverySucceededAtleastOnce value.
   */
  DiscoverySucceededAtleastOnce: "DiscoverySucceededAtleastOnce",

  /**
   * DiscoveryFailed value.
   */
  DiscoveryFailed: "DiscoveryFailed",

  /**
   * RunAsAccountNotAssociated value.
   */
  RunAsAccountNotAssociated: "RunAsAccountNotAssociated",

  /**
   * DiscoveryNotStarted value.
   */
  DiscoveryNotStarted: "DiscoveryNotStarted",

  /**
   * DiscoveryInProgress value.
   */
  DiscoveryInProgress: "DiscoveryInProgress",

  /**
   * Disabled value.
   */
  Disabled: "Disabled",

  /**
   * DiscoveryPartiallySucceded value.
   */
  DiscoveryPartiallySucceded: "DiscoveryPartiallySucceded",

  /**
   * DiscoverySucceeded value.
   */
  DiscoverySucceeded: "DiscoverySucceeded",
}

/**
 * esu Status
 */
union esuStatus {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * Active value.
   */
  Active: "Active",

  /**
   * InActive value.
   */
  InActive: "InActive",
}

/**
 * support status
 */
union supportStatus {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * Mainstream value.
   */
  Mainstream: "Mainstream",

  /**
   * Extended value.
   */
  Extended: "Extended",
}

/**
 * esu year
 */
union esuYear {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * FirstYear value.
   */
  FirstYear: "FirstYear",

  /**
   * SecondYear value.
   */
  SecondYear: "SecondYear",

  /**
   * ThirdYear value.
   */
  ThirdYear: "ThirdYear",

  /**
   * UpgradeYear value.
   */
  UpgradeYear: "UpgradeYear",
}

/**
 * azure arc discovery status
 */
union AzureArcStatus {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * Not enabled value.
   */
  NotEnabled: "NotEnabled",

  /**
   * Enabled value.
   */
  Enabled: "Enabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union Default {
  string,

  /**
   * default value.
   */
  Default: "default",
}

/**
 * ImportTypeValues enum.
 */
union ImportTypeValues {
  string,

  /**
   * Azure Migrate CSV format for importing machine inventory data.
   */
  AzureMigrateCSV: "AzureMigrateCSV",

  /**
   * RVTools Excel format for importing VMware virtual machine inventory data.
   */
  RVToolsXlsx: "RVToolsXlsx",
}

/**
 * Cosmos db Imported Machines JobEntity
 */
union DeleteImportedMachinesJobPropertiesJobState {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * Verified value.
   */
  Verified: "Verified",

  /**
   * VerifiedWithErrors value.
   */
  VerifiedWithErrors: "VerifiedWithErrors",

  /**
   * Completed value.
   */
  Completed: "Completed",

  /**
   * Failed value.
   */
  Failed: "Failed",
}

/**
 * JobResultValues
 */
union JobResult {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * Completed value.
   */
  Completed: "Completed",

  /**
   * CompletedWithWarnings value.
   */
  CompletedWithWarnings: "CompletedWithWarnings",

  /**
   * CompletedWithErrors value.
   */
  CompletedWithErrors: "CompletedWithErrors",

  /**
   * Failed value.
   */
  Failed: "Failed",

  /**
   * WaitingForBlobUpload value.
   */
  WaitingForBlobUpload: "WaitingForBlobUpload",

  /**
   * InProgress value.
   */
  InProgress: "InProgress",
}

/**
 * Servers Discovery source.
 */
union DiscoverySource {
  string,

  /**
   * Arc Discovery source.
   */
  Arc: "Arc",

  /**
   * Appliance Discovery Source.
   */
  Appliance: "Appliance",

  /**
   * CSV Server Import Discovery Source.
   */
  ImportCsvServer: "ImportCsvServer",

  /**
   * RV tools Import Discovery Source.
   */
  ImportRvTools: "ImportRvTools",
}

/**
 * SqlSiteProperties DiscoveryScenario
 */
union SqlSitePropertiesDiscoveryScenario {
  string,

  /**
   * Migrate value.
   */
  Migrate: "Migrate",

  /**
   * DR value.
   */
  DR: "DR",
}

/**
 * Import types enum supported for Sql Inventory using import.
 */
union SqlImportType {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * AzureMigrateCsv value.
   */
  AzureMigrateCsv: "AzureMigrateCsv",
}

/**
 * Import SQL inventory job result.
 */
union ImportSqlInventoryJobResult {
  string,

  /**
   * The job result is unknown or not yet determined.
   */
  Unknown: "Unknown",

  /**
   * The SQL inventory import job completed successfully without any issues.
   */
  Completed: "Completed",

  /**
   * The SQL inventory import job completed but encountered non-critical warnings.
   */
  CompletedWithWarnings: "CompletedWithWarnings",

  /**
   * The SQL inventory import job completed but encountered errors with some items.
   */
  CompletedWithErrors: "CompletedWithErrors",

  /**
   * The SQL inventory import job failed to complete due to critical errors.
   */
  Failed: "Failed",

  /**
   * The job is waiting for the SQL inventory data blob to be uploaded.
   */
  WaitingForBlobUpload: "WaitingForBlobUpload",

  /**
   * The SQL inventory import job is currently running and processing data.
   */
  InProgress: "InProgress",
}

/**
 * AvailabilityGroupType
 */
union SqlAvailabilityGroupPropertiesAvailabilityGroupType {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * Traditional value.
   */
  Traditional: "Traditional",

  /**
   * Distributed value.
   */
  Distributed: "Distributed",
}

/**
 * ReplicaType
 */
union SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaType {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * DatabaseReplica value.
   */
  DatabaseReplica: "DatabaseReplica",

  /**
   * AvailabilityGroupReplica value.
   */
  AvailabilityGroupReplica: "AvailabilityGroupReplica",
}

/**
 * ReplicaState
 */
union SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaState {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * Primary value.
   */
  Primary: "Primary",

  /**
   * Secondary value.
   */
  Secondary: "Secondary",
}

/**
 * ReplicaSyncStatus
 */
union SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaSyncStatus {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * Synchronized value.
   */
  Synchronized: "Synchronized",

  /**
   * Unsynchronized value.
   */
  Unsynchronized: "Unsynchronized",
}

/**
 * ReplicaCommitMode
 */
union SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaCommitMode {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * Synchronous value.
   */
  Synchronous: "Synchronous",

  /**
   * Asynchronous value.
   */
  Asynchronous: "Asynchronous",
}

/**
 * ReplicaReadMode
 */
union SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaReadMode {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * None value.
   */
  None: "None",

  /**
   * ReadOnly value.
   */
  ReadOnly: "ReadOnly",

  /**
   * ReadWrite value.
   */
  ReadWrite: "ReadWrite",
}

/**
 * ReplicaSeedMode
 */
union SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaSeedMode {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * Manual value.
   */
  Manual: "Manual",

  /**
   * Automatic value.
   */
  Automatic: "Automatic",
}

/**
 * Overview Replica State
 */
union SqlAvailabilityReplicaOverviewReplicaState {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * Primary value.
   */
  Primary: "Primary",

  /**
   * Secondary value.
   */
  Secondary: "Secondary",
}

/**
 * file type
 */
union FileType {
  string,

  /**
   * Rows value.
   */
  Rows: "Rows",

  /**
   * Log value.
   */
  Log: "Log",

  /**
   * Filestream value.
   */
  Filestream: "Filestream",

  /**
   * NotSpecified value.
   */
  NotSupported: "NotSupported",

  /**
   * Fulltext value.
   */
  Fulltext: "Fulltext",
}

/**
 * HealthError Details Source
 */
union MicrosoftAzureFDSWebRoleHealthErrorDetailsSource {
  string,

  /**
   * RefreshFabricLayout value.
   */
  RefreshFabricLayout: "RefreshFabricLayout",

  /**
   * RefreshFabricLayoutGuest value.
   */
  RefreshFabricLayoutGuest: "RefreshFabricLayoutGuest",

  /**
   * RefreshFabricLayoutDependencyMap value.
   */
  RefreshFabricLayoutDependencyMap: "RefreshFabricLayoutDependencyMap",
}

/**
 * sql fci role
 */
union SqlMachineOverviewFciRole {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * NotApplicable value.
   */
  NotApplicable: "NotApplicable",

  /**
   * ActiveNode value.
   */
  ActiveNode: "ActiveNode",

  /**
   * PossibleOwnerNode value.
   */
  PossibleOwnerNode: "PossibleOwnerNode",
}

/**
 * fci instance state
 */
union FCIInstanceState {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * Inherited value.
   */
  Inherited: "Inherited",

  /**
   * Initializing value.
   */
  Initializing: "Initializing",

  /**
   * Online value.
   */
  Online: "Online",

  /**
   * Offline value.
   */
  Offline: "Offline",

  /**
   * Failed value.
   */
  Failed: "Failed",

  /**
   * Pending value.
   */
  Pending: "Pending",

  /**
   * OnlinePending value.
   */
  OnlinePending: "OnlinePending",

  /**
   * OfflinePending value.
   */
  OfflinePending: "OfflinePending",
}

/**
 * sql server status
 */
union SqlServerStatus {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * ContinuePending value.
   */
  ContinuePending: "ContinuePending",

  /**
   * Paused value.
   */
  Paused: "Paused",

  /**
   * PausePending value.
   */
  PausePending: "PausePending",

  /**
   * Running value.
   */
  Running: "Running",

  /**
   * StartPending value.
   */
  StartPending: "StartPending",

  /**
   * Stopped value.
   */
  Stopped: "Stopped",

  /**
   * StopPending value.
   */
  StopPending: "StopPending",
}

/**
 * Discovery Scenario
 */
union WebAppSitePropertiesDiscoveryScenario {
  string,

  /**
   * Migrate value.
   */
  Migrate: "Migrate",

  /**
   * DR value.
   */
  DR: "DR",
}

/**
 * vmware datastore type
 */
union VMwareDatastoreType {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * CIFS value.
   */
  Cifs: "CIFS",

  /**
   * NFS value.
   */
  NFS: "NFS",

  /**
   * NFS41 value.
   */
  NFS41: "NFS41",

  /**
   * PMEM value.
   */
  Pmem: "PMEM",

  /**
   * VFFS value.
   */
  Vffs: "VFFS",

  /**
   * VMFS value.
   */
  Vmfs: "VMFS",

  /**
   * VSAN value.
   */
  Vsan: "VSAN",

  /**
   * VVOL value.
   */
  Vvol: "VVOL",
}

/**
 * HealthError Details Source
 */
union DefaultAutoGenerated {
  string,

  /**
   * default value.
   */
  Default: "default",
}

/**
 * HealthError Details Source
 */
union DefaultValues {
  string,

  /**
   * default value.
   */
  Default: "default",
}

/**
 * Value indicating whether the VM is highly available
 */
union HighAvailabilityValues {
  string,

  /**
   * Unknown value.
   */
  Unknown: "Unknown",

  /**
   * No value.
   */
  No: "No",

  /**
   * Yes value.
   */
  Yes: "Yes",
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * The properties of VMwareSiteResource
 */
model SiteProperties {
  /**
   * Gets the Master Site this site is linked to.
   */
  @visibility(Lifecycle.Read)
  masterSiteId?: string;

  /**
   * Gets or sets the service principal identity details used by agent for
   * communication
   *             to the service.
   */
  servicePrincipalIdentityDetails?: SiteSpnProperties;

  /**
   * Gets or sets the on-premises agent details.
   */
  agentDetails?: SiteAgentProperties;

  /**
   * Gets or sets the Appliance Name.
   */
  applianceName?: string;

  /**
   * Gets or sets the ARM ID of migration hub solution for SDS.
   */
  discoverySolutionId?: string;

  /**
   * Gets the service endpoint.
   */
  @visibility(Lifecycle.Read)
  serviceEndpoint?: string;

  /**
   * Gets or sets the appliance details used by service to communicate to the appliance.
   */
  @identifiers(#[])
  siteAppliancePropertiesCollection?: SiteApplianceProperties[];

  /**
   * Gets or sets the discovery scenario.
   */
  discoveryScenario?: DiscoveryScenario;

  /**
   * The status of the last operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: ProvisioningState;
}

/**
 * Class for site properties.
 */
model SiteSpnProperties {
  /**
   * Gets or sets the tenant Id for the service principal with which the
   * on-premise
   *             management/data plane components would communicate with
   * our Azure services.
   */
  tenantId?: string;

  /**
   * Gets or sets the application/client Id for the service principal with which
   * the
   *             on-premise management/data plane components would communicate
   * with our Azure
   *             services.
   */
  applicationId?: string;

  /**
   * Gets or sets the object Id of the service principal with which the on-premise
   *
   *            management/data plane components would communicate with our Azure
   * services.
   */
  objectId?: string;

  /**
   * Gets or sets the intended audience for the service principal.
   */
  audience?: string;

  /**
   * Gets or sets the AAD Authority URL which was used to request the token for
   * the
   *             service principal.
   */
  aadAuthority?: string;

  /**
   * Gets or sets the raw certificate data for building certificate expiry flows.
   */
  rawCertData?: string;

  /**
   * Gets or sets the ARM ID of the arc for servers resource.
   */
  machineResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.HybridCompute/machines";
    }
  ]>;
}

/**
 * Class for site agent properties.
 */
model SiteAgentProperties {
  /**
   * Gets the ID of the agent.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Gets the version of the agent.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Gets the last heartbeat time of the agent in UTC.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartBeatUtc?: utcDateTime;

  /**
   * Gets or sets the key vault URI.
   */
  keyVaultUri?: string;

  /**
   * Gets or sets the key vault ARM Id.
   */
  keyVaultId?: string;
}

/**
 * Class for site appliance properties.
 */
model SiteApplianceProperties {
  /**
   *  Gets or sets the service principal identity details used by agent for  communication              to the service.
   */
  servicePrincipalIdentityDetails?: SiteSpnProperties;

  /**
   * Gets or sets the on-premises agent details.
   */
  agentDetails?: SiteAgentProperties;

  /**
   * Gets or sets the Appliance Name.
   */
  applianceName?: string;
}

/**
 * The properties of ImportSiteResource
 */
model ImportSiteProperties {
  /**
   * Gets or sets the ARM ID of migration hub solution for SDS.
   */
  discoverySolutionId?: string;

  /**
   * Gets the Master Site this site is linked to.
   */
  @visibility(Lifecycle.Read)
  masterSiteId?: string;

  /**
   * Gets the service endpoint.
   */
  @visibility(Lifecycle.Read)
  serviceEndpoint?: string;

  /**
   * The status of the last operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: ProvisioningState;
}

/**
 * Class for site properties.
 */
model MasterSiteProperties {
  /**
   * Gets or sets the state of public network access.
   */
  publicNetworkAccess?: MasterSitePropertiesPublicNetworkAccess;

  /**
   * Gets or sets a value indicating whether multiple sites per site type are
   * allowed.
   */
  allowMultipleSites?: boolean;

  /**
   * Gets or sets the sites that are a part of Master Site.
   *             The key
   * should contain the Site ARM name.
   */
  sites?: string[];

  /**
   * Gets or sets a value for customer storage account ARM id.
   */
  customerStorageAccountArmId?: string;

  /**
   * Gets the private endpoint connections.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Gets the nested sites under Master Site.
   */
  @visibility(Lifecycle.Read)
  nestedSites?: string[];

  /**
   * provisioning state enum
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Gets the last refresh time of arc status in UTC.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRefreshArcStatusTime?: utcDateTime;
}

/**
 * PrivateEndpointConnectionProperties V2
 */
model PrivateEndpointConnectionPropertiesV2 {
  /**
   * array of group ids
   */
  @visibility(Lifecycle.Read)
  groupIds?: string[];

  /**
   * provisioning state enum
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * private endpoints
   */
  @visibility(Lifecycle.Read)
  privateEndpoint?: ResourceId;

  /**
   * private endpoints connection state
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;
}

/**
 * PrivateEndpointModelsResourceId
 */
model ResourceId {
  /**
   * id name
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * Service Connection State
 */
model PrivateLinkServiceConnectionState {
  /**
   * state status
   */
  status?: PrivateLinkServiceConnectionStateStatus;

  /**
   * description string
   */
  description?: string;

  /**
   * actions required
   */
  actionsRequired?: string;
}

/**
 * The properties of ServerSiteResource.
 */
model ServerSitesProperties {
  /**
   * Gets the Master Site this site is linked to.
   */
  @visibility(Lifecycle.Read)
  masterSiteId?: string;

  /**
   * Gets or sets the service principal identity details used by agent for communication to the service.
   */
  servicePrincipalIdentityDetails?: SiteSpnProperties;

  /**
   * Gets or sets the on-premises agent details.
   */
  agentDetails?: SiteAgentProperties;

  /**
   * Gets or sets the Appliance Name.
   */
  applianceName?: string;

  /**
   * Gets or sets the ARM ID of migration hub solution for SDS.
   */
  discoverySolutionId?: string;

  /**
   * Gets the service endpoint.
   */
  @visibility(Lifecycle.Read)
  serviceEndpoint?: string;

  /**
   * Gets or sets the appliance details used by service to communicate to the appliance.
   */
  @identifiers(#[])
  siteAppliancePropertiesCollection?: SiteApplianceProperties[];

  /**
   * Gets or sets the discovery scenario.
   */
  discoveryScenario?: DiscoveryScenario;

  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets the Arc scope properties for the server site.
   */
  arcScope?: ArcScopeProperties;
}

/**
 * Properties for defining Arc scope.
 */
model ArcScopeProperties {
  /**
   * Locations to discover Arc resources from.
   */
  locations?: string[];

  /**
   * The type of scope, currently supporting SubscriptionOrResourceGroupIds only.
   */
  scopeType: ArcSiteScopeType;

  /**
   * List of subscription or resource group ARM IDs. Allowed only if scopeType is SubscriptionOrResourceGroupIds.
   */
  subscriptionOrResourceGroupIds?: Azure.Core.armResourceIdentifier[];

  /**
   * The type of sync, currently supporting Manual and Periodic.
   */
  syncType?: ArcSyncType;

  /**
   * Tag Sync Confirmation. If Enabled, tags on Arc resources will be synced to Azure Migrate resources.
   */
  tagSyncMode?: TagSyncMode;

  /**
   * Gets the last successful sync time of arc site in UTC.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulSyncTime?: utcDateTime;
}

/**
 * The properties of SiteResource
 */
model SitesProperties {
  /**
   * Gets the Master Site this site is linked to.
   */
  @visibility(Lifecycle.Read)
  masterSiteId?: string;

  /**
   * Gets or sets the service principal identity details used by agent for
   * communication
   *             to the service.
   */
  servicePrincipalIdentityDetails?: SiteSpnProperties;

  /**
   * Gets or sets the on-premises agent details.
   */
  agentDetails?: SiteAgentProperties;

  /**
   * Gets or sets the Appliance Name.
   */
  applianceName?: string;

  /**
   * Gets or sets the ARM ID of migration hub solution for SDS.
   */
  discoverySolutionId?: string;

  /**
   * Gets the service endpoint.
   */
  @visibility(Lifecycle.Read)
  serviceEndpoint?: string;

  /**
   * Gets or sets the appliance details used by service to communicate to the appliance.
   */
  @identifiers(#[])
  siteAppliancePropertiesCollection?: SiteApplianceProperties[];

  /**
   * Gets or sets the discovery scenario.
   */
  discoveryScenario?: DiscoveryScenario;

  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The type used for update operations of the HypervSite.
 */
model HypervSiteUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The updatable properties of the HypervSite.
   */
  properties?: HypervSiteUpdateProperties;
}

/**
 * The updatable properties of the HypervSite.
 */
model HypervSiteUpdateProperties {
  /**
   * Gets or sets the service principal identity details used by agent for
   * communication
   *             to the service.
   */
  servicePrincipalIdentityDetails?: SiteSpnProperties;

  /**
   * Gets or sets the on-premises agent details.
   */
  agentDetails?: SiteAgentProperties;

  /**
   * Gets or sets the Appliance Name.
   */
  applianceName?: string;

  /**
   * Gets or sets the ARM ID of migration hub solution for SDS.
   */
  discoverySolutionId?: string;

  /**
   * Gets or sets the appliance details used by service to communicate to the appliance.
   */
  @identifiers(#[])
  siteAppliancePropertiesCollection?: SiteApplianceProperties[];

  /**
   * The status of the last operation.
   */
  provisioningState?: ProvisioningState;
}

/**
 * DependencyMap ServiceMap extensions Client GroupMembers Request
 */
model DependencyMapServiceMapextensionsClientGroupMembersRequest {
  /**
   * id of machine
   */
  machineId?: string;

  /**
   * process group name
   */
  processGroupName?: string;

  /**
   * name of process
   */
  processName?: string;

  /**
   * start time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * end time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * optional filters
   */
  filters?: DependencyMapServiceMapextensionsDependencyMapRequestFilters;
}

/**
 * DependencyMap Service Map extensions Dependency Map Request Filters
 */
model DependencyMapServiceMapextensionsDependencyMapRequestFilters {
  /**
   * array of machine ids
   */
  machineIds?: string[];

  /**
   * array of process Ids
   */
  processIds?: string[];
}

/**
 * The properties of Hyperv Cluster
 */
model HypervClusterProperties {
  /**
   * Gets the timestamp marking Hyper-V cluster creation.
   */
  @visibility(Lifecycle.Read)
  createdTimestamp?: string;

  /**
   * Gets the timestamp marking last updated on the Hyper-V cluster.
   */
  @visibility(Lifecycle.Read)
  updatedTimestamp?: string;

  /**
   * Gets or sets the FQDN/IPAddress of the Hyper-V cluster.
   */
  fqdn?: string;

  /**
   * Gets the functional level of the Hyper-V cluster.
   */
  @visibility(Lifecycle.Read)
  functionalLevel?: int32;

  /**
   * Gets the status of the Hyper-V cluster.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Gets or sets Run as account ID of the Hyper-V cluster.
   */
  runAsAccountId?: string;

  /**
   * Gets or sets list of hosts (FQDN) currently being tracked by the cluster.
   */
  hostFqdnList?: string[];

  /**
   * Gets the errors.
   */
  @visibility(Lifecycle.Read)
  errors?: HealthErrorDetails[];

  /**
   * The status of the last operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: ProvisioningState;
}

/**
 * Error contract returned when some exception occurs in Rest API.
 */
model HealthErrorDetails {
  /**
   * Gets the error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Gets the message parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  messageParameters?: Record<string>;

  /**
   * Gets the appliance name.
   */
  @visibility(Lifecycle.Read)
  applianceName?: string;

  /**
   * Gets the error ID.
   */
  @visibility(Lifecycle.Read)
  id?: int64;

  /**
   * Gets the error name.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Gets the possible causes of error.
   */
  @visibility(Lifecycle.Read)
  possibleCauses?: string;

  /**
   * Gets the recommended action to resolve error.
   */
  @visibility(Lifecycle.Read)
  recommendedAction?: string;

  /**
   * Gets the error severity.
   */
  @visibility(Lifecycle.Read)
  severity?: string;

  /**
   * Gets the error summary message.
   */
  @visibility(Lifecycle.Read)
  summaryMessage?: string;

  /**
   * Gets the error source.
   */
  @visibility(Lifecycle.Read)
  source?: HealthErrorDetailsSource;

  /**
   * Gets the time stamp when the error was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedTimeStamp?: utcDateTime;

  /**
   * Gets run as account id used while performing discovery             of entity.
   */
  @visibility(Lifecycle.Read)
  runAsAccountId?: string;

  /**
   * Gets discovery scope for which             error is encountered.
   */
  @visibility(Lifecycle.Read)
  discoveryScope?: HealthErrorDetailsDiscoveryScope;
}

/**
 * Site error summary.
 */
model SiteErrorSummary {
  /**
   * Appliance Name.
   */
  applianceName: string;

  /**
   * Gets the error message.
   */
  discoveryScopeErrorSummaries: DiscoveryScopeErrorSummary;

  /**
   * The link to fetch more models.
   */
  nextLink?: string;
}

/**
 * The site error summary model.
 */
model DiscoveryScopeErrorSummary {
  /**
   * Gets or sets the affected resource type.
   */
  affectedResourceType: string;

  /**
   * Count of affected objects.
   */
  affectedObjectsCount: int64;

  /**
   * Gets or sets the count of affected objects.
   */
  discoveryScope: DiscoveryScopes;
}

/**
 * Hyper-V site usage.
 */
model HypervSiteUsage {
  /**
   * Gets or sets the number of machines discovered in the site.
   */
  machineCount?: int32;

  /**
   * Gets or sets the number of run as accounts in the site.
   */
  runAsAccountCount?: int32;

  /**
   * Gets or sets the number of hosts part of the site.
   */
  hostCount?: int32;

  /**
   * Gets or sets the number of clusters part of the site.
   */
  clusterCount?: int32;
}

/**
 * DependencyMap ServiceMap extensions ExportDependencies Request
 */
model DependencyMapServiceMapextensionsExportDependenciesRequest {
  /**
   * start time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * end time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;
}

/**
 * The body of export machine errors request.
 */
model ExportMachineErrorsRequest {
  /**
   * Gets or sets the properties.
   */
  properties?: RequestExportMachineErrorsProperties;
}

/**
 * The Properties class for export machine errors request body.
 */
model RequestExportMachineErrorsProperties {
  /**
   * Gets or sets the discovery scope.
   */
  discoveryScope?: ExportMachineErrorsProperties;
}

/**
 * DependencyMap ServiceMapextensions Scope MapRequest
 */
model DependencyMapServiceMapextensionsScopeMapRequest {
  /**
   * start time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * end time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * optional filters
   */
  filters?: DependencyMapServiceMapextensionsDependencyMapRequestFilters;
}

/**
 * DependencyMap ServiceMap extensions SingleMachine DetailedMap Request
 */
model DependencyMapServiceMapextensionsSingleMachineDetailedMapRequest {
  /**
   * id of machine
   */
  machineId?: string;

  /**
   * start time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * end time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * optional filters
   */
  filters?: DependencyMapServiceMapextensionsDependencyMapRequestFilters;
}

/**
 * The properties of Hyperv Host
 */
model HypervHostProperties {
  /**
   * Gets the timestamp marking Hyper-V host creation.
   */
  @visibility(Lifecycle.Read)
  createdTimestamp?: string;

  /**
   * Gets the timestamp marking last updated on the Hyper-V host.
   */
  @visibility(Lifecycle.Read)
  updatedTimestamp?: string;

  /**
   * Gets or sets the FQDN/IPAddress of the Hyper-V host.
   */
  fqdn?: string;

  /**
   * Gets or sets the run as account ID of the Hyper-V host.
   */
  runAsAccountId?: string;

  /**
   * Gets the version of the Hyper-V host.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Gets the errors.
   */
  @visibility(Lifecycle.Read)
  errors?: HealthErrorDetails[];

  /**
   * The status of the last operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: ProvisioningState;
}

/**
 * Job REST Resource.
 */
model JobProperties {
  /**
   * Gets operation status.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Gets operation start time.
   */
  @visibility(Lifecycle.Read)
  startTime?: string;

  /**
   * Gets operation end time.
   */
  @visibility(Lifecycle.Read)
  endTime?: string;

  /**
   * Gets or sets the display name of the Job.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Gets the client request Id used in the operation execution context.
   */
  @visibility(Lifecycle.Read)
  clientRequestId?: string;

  /**
   * Gets the activity Id used in the operation execution context.
   */
  @visibility(Lifecycle.Read)
  activityId?: string;

  /**
   * Gets the errors.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errors?: ErrorDetails[];

  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Error contract returned when some exception occurs in Rest API.
 */
model ErrorDetails {
  /**
   * Gets the error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Gets the error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Gets the possible causes of error.
   */
  @visibility(Lifecycle.Read)
  possibleCauses?: string;

  /**
   * Gets the recommended action to resolve error.
   */
  @visibility(Lifecycle.Read)
  recommendedAction?: string;

  /**
   * Gets the error severity.
   */
  @visibility(Lifecycle.Read)
  severity?: string;

  /**
   * Gets a value indicating whether the error originated from a agent or not.
   */
  @visibility(Lifecycle.Read)
  isAgentReportedError?: boolean;

  /**
   * Gets the agent error code.
   */
  @visibility(Lifecycle.Read)
  agentErrorCode?: string;

  /**
   * Gets the error message from the agent.
   */
  @visibility(Lifecycle.Read)
  agentErrorMessage?: string;

  /**
   * Gets possible causes for the agent error.
   */
  @visibility(Lifecycle.Read)
  agentErrorPossibleCauses?: string;

  /**
   * Gets the recommended action for the agent error.
   */
  @visibility(Lifecycle.Read)
  agentErrorRecommendedAction?: string;
}

/**
 * Collection of SiteHealthSummary.
 */
model SiteHealthSummaryCollection is Azure.Core.Page<SiteHealthSummary>;

/**
 * The properties of ServerSiteResource.
 */
model SiteHealthSummary {
  /**
   * Gets the appliance name.
   */
  @visibility(Lifecycle.Read)
  applianceName?: string;

  /**
   * Gets the error message.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * Gets the summary message.
   */
  @visibility(Lifecycle.Read)
  summaryMessage?: string;

  /**
   * Gets the error Id.
   */
  @visibility(Lifecycle.Read)
  errorId?: int64;

  /**
   * Gets the error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /**
   * Gets or sets the count of affected objects.
   */
  affectedObjectsCount?: int64;

  /**
   * Gets or sets the hit count of the error.
   */
  hitCount?: int64;

  /**
   * Gets the severity of error.
   */
  @visibility(Lifecycle.Read)
  severity?: string;

  /**
   * Gets the remediation guidance.
   */
  @visibility(Lifecycle.Read)
  remediationGuidance?: string;

  /**
   * Gets the affected resource type.
   */
  @visibility(Lifecycle.Read)
  affectedResourceType?: string;

  /**
   * Gets or sets the affected resources.
   */
  affectedResources?: string[];

  /**
   * Gets or sets sources of the exception.
   */
  fabricLayoutUpdateSources?: SiteHealthSummaryFabricLayoutUpdateSourcesItem[];
}

/**
 * The properties of AddressResource
 */
model HypervMachineProperties {
  /**
   * On-premise Instance UUID of the machine.
   */
  @visibility(Lifecycle.Read)
  instanceUuid?: string;

  /**
   * Host FQDN/IPAddress.
   */
  @visibility(Lifecycle.Read)
  hostFqdn?: string;

  /**
   * Host ARM ID.
   */
  @visibility(Lifecycle.Read)
  hostId?: string;

  /**
   * Generation of the virtual machine.
   */
  @visibility(Lifecycle.Read)
  generation?: int32;

  /**
   * VM version.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Value indicating whether the VM is highly available.
   */
  @visibility(Lifecycle.Read)
  highAvailability?: HighAvailability;

  /**
   * Cluster FQDN/IPAddress.
   */
  @visibility(Lifecycle.Read)
  clusterFqdn?: string;

  /**
   * Cluster ARM ID.
   */
  @visibility(Lifecycle.Read)
  clusterId?: string;

  /**
   * Max memory of the virtual machine in MB.
   */
  @visibility(Lifecycle.Read)
  maxMemoryMb?: int32;

  /**
   * Value indicating whether dynamic memory is enabled for the VM.
   */
  @visibility(Lifecycle.Read)
  isDynamicMemoryEnabled?: boolean;

  /**
   * Disks attached to the machine.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  disks?: HypervDisk[];

  /**
   * Network adapters attached to the machine.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  networkAdapters?: HypervNetworkAdapter[];

  /**
   * Management server type captured as a string representation of the
   *
   * {Microsoft.Azure.FDS.WebRole.HyperVMachineBase.HyperVMachineBaseProperties.ManagementServerType}
   * enumeration.
   */
  @visibility(Lifecycle.Read)
  managementServerType?: string;

  /**
   * Gets or sets the SecureBootTemplateId setting of the VM.
   */
  @visibility(Lifecycle.Read)
  secureBootTemplateId?: string;

  /**
   * Gets or sets a value indicating whether Secure boot is enabled for the VM.
   */
  @visibility(Lifecycle.Read)
  secureBootEnabled?: boolean;

  /**
   * Gets or sets the SecureBootTemplateId setting of the VM.
   */
  @visibility(Lifecycle.Read)
  secureBootTemplate?: string;

  /**
   * Gets or sets a value indicating whether trusted platform module is enabled on
   * the VM.
   */
  @visibility(Lifecycle.Read)
  tpmEnabled?: boolean;

  /**
   * Gets or sets a value indicating whether key storage device is enabled on the VM.
   */
  @visibility(Lifecycle.Read)
  ksdEnabled?: boolean;

  /**
   * Gets or sets a value indicating whether shielding is enabled for the VM.
   */
  @visibility(Lifecycle.Read)
  shieldingRequested?: boolean;

  /**
   * Gets or sets a value indicating whether data protection is requested for a VM.
   */
  @visibility(Lifecycle.Read)
  dataProtectionRequested?: boolean;

  /**
   * Gets or sets a value indicating whether encryption of state and migration
   * traffic is enabled for the VM.
   */
  @visibility(Lifecycle.Read)
  encryptStateAndVmMigrationTraffic?: boolean;

  /**
   * Gets or sets a value indicating whether VM virtualization based security is
   * enabled for the VM.
   */
  @visibility(Lifecycle.Read)
  virtualizationBasedSecurityOptOut?: boolean;

  /**
   * Gets the Machine power status.
   */
  @visibility(Lifecycle.Read)
  powerStatus?: string;

  /**
   * Gets the VM FQDN.
   */
  @visibility(Lifecycle.Read)
  vmFqdn?: string;

  /**
   * Gets the Root location of the VM configuration file.
   */
  @visibility(Lifecycle.Read)
  vmConfigurationFileLocation?: string;

  /**
   * Gets or sets the firmware.
   */
  firmware?: string;

  /**
   * Operating System Details extracted from the guest             bu executing script inside the guest VM.
   */
  @visibility(Lifecycle.Read)
  guestOsDetails?: GuestOsDetails;

  /**
   * Number of applications installed in the guest VM.
   */
  @visibility(Lifecycle.Read)
  numberOfApplications?: int32;

  /**
   * Number of software installed in the guest VM.
   */
  @visibility(Lifecycle.Read)
  numberOfSoftware?: int32;

  /**
   * Number of security risks identified on the guest VM.
   */
  @visibility(Lifecycle.Read)
  numberOfSecurityRisks?: int32;

  /**
   * The last time at which the Guest Details was discovered
   *             or the
   * error while discovering guest details based discovery
   *             of the
   * machine.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  guestDetailsDiscoveryTimestamp?: utcDateTime;

  /**
   * Whether Refresh Fabric Layout Guest Details has been completed once.
   *
   *   Portal will show discovery in progress, if this value is true.
   */
  @visibility(Lifecycle.Read)
  isGuestDetailsDiscoveryInProgress?: boolean;

  /**
   * Gets or sets if dependency mapping feature is enabled or not
   *             for
   * the VM.
   */
  @visibility(Lifecycle.Read)
  dependencyMapping?: string;

  /**
   * Gets or sets when dependency mapping collection is last started.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dependencyMappingStartTime?: utcDateTime;

  /**
   * Gets or sets when dependency mapping collection was last disabled.
   */
  @visibility(Lifecycle.Read)
  dependencyMappingEndTime?: string;

  /**
   * Gets or sets the run as account ID of the machine.
   */
  runAsAccountId?: string;

  /**
   * Gets the appliance names.
   */
  @visibility(Lifecycle.Read)
  applianceNames?: string[];

  /**
   * Errors for machine.
   */
  @visibility(Lifecycle.Read)
  errors?: HealthErrorDetails[];

  /**
   * Gets the data related to application discovery.
   */
  @visibility(Lifecycle.Read)
  applicationDiscovery?: ApplicationDiscovery;

  /**
   * Gets the data related to dependency map discovery.
   */
  @visibility(Lifecycle.Read)
  dependencyMapDiscovery?: DependencyMapDiscovery;

  /**
   * Gets the data related to static discovery.
   */
  @visibility(Lifecycle.Read)
  staticDiscovery?: StaticDiscovery;

  /**
   * Gets the data related to SQL discovery.
   */
  @visibility(Lifecycle.Read)
  sqlDiscovery?: SqlDiscovery;

  /**
   * Gets the data related to Web application discovery.
   */
  @visibility(Lifecycle.Read)
  webAppDiscovery?: WebAppDiscovery;

  /**
   * Gets the data related to Oracle discovery.
   */
  @visibility(Lifecycle.Read)
  oracleDiscovery?: OracleDiscovery;

  /**
   * Gets the data related to SpringBoot discovery.
   */
  @visibility(Lifecycle.Read)
  springBootDiscovery?: SpringBootDiscovery;

  /**
   * Gets the data related to iis discovery.
   */
  @visibility(Lifecycle.Read)
  iisDiscovery?: WebAppDiscovery;

  /**
   * Gets the data related to tomcat discovery.
   */
  @visibility(Lifecycle.Read)
  tomcatDiscovery?: WebAppDiscovery;

  /**
   * Apps And Roles of the Server.
   */
  @visibility(Lifecycle.Read)
  appsAndRoles?: AppsAndRoles;

  /**
   * product support status.
   */
  productSupportStatus?: ProductSupportStatus;

  /**
   * Gets or sets the Number of Processor Cores
   *             allocated for the
   * machine.
   */
  numberOfProcessorCore?: int32;

  /**
   * Gets or sets the allocated Memory in MB.
   */
  allocatedMemoryInMb?: float64;

  /**
   * Gets or sets the Operating System Details installed on the machine.
   */
  operatingSystemDetails?: OperatingSystem;

  /**
   * Gets or sets the Machine BIOS serial number.
   */
  biosSerialNumber?: string;

  /**
   * Gets or sets the BIOS GUID.
   */
  biosGuid?: string;

  /**
   * Gets the Display name of the machine.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Value indicating whether VM is deleted.
   */
  @visibility(Lifecycle.Read)
  isDeleted?: boolean;

  /**
   * Gets the marking machine creation.
   */
  @visibility(Lifecycle.Read)
  createdTimestamp?: string;

  /**
   * Gets or sets tags on the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Gets the timestamp marking last updated on the machine.
   */
  @visibility(Lifecycle.Read)
  updatedTimestamp?: string;

  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Gets the data related to Azure arc discovery.
   */
  @visibility(Lifecycle.Read)
  arcDiscovery?: ArcDiscovery;
}

/**
 * Second level object returned as part of Machine REST resource.
 */
model HypervDisk {
  /**
   * Id of the disk.
   */
  @visibility(Lifecycle.Read)
  instanceId?: string;

  /**
   * VHD Id of the disk.
   */
  @visibility(Lifecycle.Read)
  vhdId?: string;

  /**
   * Gets or sets Bytes allocated for the disk.
   */
  maxSizeInBytes?: int64;

  /**
   * Gets or sets Name of the disk.
   */
  name?: string;

  /**
   * Gets or sets Type of the disk.
   */
  diskType?: string;

  /**
   * Gets or sets LUN of the disk.
   */
  lun?: int32;

  /**
   * Gets or sets a value indicating whether disk is os disk.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isOSDisk?: string;

  /**
   * Gets or sets Path of the disk.
   */
  path?: string;
}

/**
 * Second level object represented in responses as part of Machine REST resource.
 */
model HypervNetworkAdapter {
  /**
   * Network Id.
   */
  @visibility(Lifecycle.Read)
  networkId?: string;

  /**
   * Name of the VM subnet within the virtual network the NIC is attached to.
   */
  @visibility(Lifecycle.Read)
  subnetName?: string;

  /**
   * Static IP address.
   */
  @visibility(Lifecycle.Read)
  staticIpAddress?: string;

  /**
   * Mac address of the NIC.
   */
  @visibility(Lifecycle.Read)
  nicType?: string;

  /**
   * Gets or sets the NIC Id.
   */
  nicId?: string;

  /**
   * Gets or sets Mac address of the NIC.
   */
  macAddress?: string;

  /**
   * Gets IP addresses for the machine.
   */
  @visibility(Lifecycle.Read)
  ipAddressList?: string[];

  /**
   * Gets or sets Network Name.
   */
  networkName?: string;

  /**
   * Gets or sets Type of the IP address.
   */
  ipAddressType?: string;
}

/**
 * Second level object.  Data related to a machine's operating system.             Serialized and stored as part of Machine Rest object.
 */
model GuestOsDetails {
  /**
   * Gets or sets the type of the operating system.
   */
  osType?: string;

  /**
   * Gets or sets the Name of the operating system.
   */
  osName?: string;

  /**
   * Gets or sets the Version of the operating system.
   */
  osVersion?: string;

  /**
   * Gets or sets the Architecture of the operating system.
   */
  osArchitecture?: string;

  /**
   * Gets or sets the Distro of the operating system.
   */
  osDistro?: string;

  /**
   * Gets or sets the Major Version of the operating system.
   */
  osMajorVersion?: string;

  /**
   * Gets or sets the Variant of the operating system.
   */
  osVariant?: string;

  /**
   * Gets or sets the Kernel Version of the operating system.
   */
  kernelVersion?: string;
}

/**
 * Contains data related application and roles discovery scope.
 */
model ApplicationDiscovery {
  /**
   * Gets discovery scope status.
   */
  @visibility(Lifecycle.Read)
  discoveryScopeStatus?: ApplicationDiscoveryScopeStatus;

  /**
   * Gets errors for discovery scope.
   */
  @visibility(Lifecycle.Read)
  errors?: HealthErrorDetails[];

  /**
   * Gets the run as account ID with which feature worked successfully.
   *
   * It is discovered by the agent from the list of credentials.
   */
  @visibility(Lifecycle.Read)
  hydratedRunAsAccountId?: string;
}

/**
 * Contains data related dependency map discovery scope.
 */
model DependencyMapDiscovery {
  /**
   * Gets discovery scope status.
   */
  @visibility(Lifecycle.Read)
  discoveryScopeStatus?: DependencyMapDiscoveryScopeStatus;

  /**
   * Gets errors for discovery scope.
   */
  @visibility(Lifecycle.Read)
  errors?: HealthErrorDetails[];

  /**
   * Gets the run as account ID with which feature worked successfully.
   *
   * It is discovered by the agent from the list of credentials.
   */
  @visibility(Lifecycle.Read)
  hydratedRunAsAccountId?: string;
}

/**
 * Contains data related static data discovery scope.
 */
model StaticDiscovery {
  /**
   * Gets discovery scope status.
   */
  @visibility(Lifecycle.Read)
  discoveryScopeStatus?: StaticDiscoveryScopeStatus;

  /**
   * Gets errors for discovery scope.
   */
  @visibility(Lifecycle.Read)
  errors?: HealthErrorDetails[];

  /**
   * Gets the run as account ID with which feature worked successfully.
   *
   * It is discovered by the agent from the list of credentials.
   */
  @visibility(Lifecycle.Read)
  hydratedRunAsAccountId?: string;
}

/**
 * Contains data related SQL discovery.
 */
model SqlDiscovery {
  /**
   *  successfully Discovered ServerCount
   */
  successfullyDiscoveredServerCount?: int32;

  /**
   * total Server Count
   */
  totalServerCount?: int32;

  /**
   * sql Metadata Hydrated RunAsAccountId
   */
  sqlMetadataHydratedRunAsAccountId?: string;

  /**
   * sql Metadata DiscoveryPipe
   */
  sqlMetadataDiscoveryPipe?: SqlMetadataDiscoveryPipe;

  /**
   * discovery Scope Status
   */
  discoveryScopeStatus?: SQLDiscoveryScopeStatus;
}

/**
 * Data related to a machine's WebApps discovery.
 */
model WebAppDiscovery {
  /**
   * Gets or sets number of successfully discovered web servers..
   */
  totalWebServerCount?: int64;

  /**
   * Gets or sets number of successfully discovered web applications.
   */
  totalWebApplicationCount?: int64;

  /**
   * Gets or sets status of partner discovery.
   */
  discoveryScopeStatus?: DiscoveryScopeStatus;
}

/**
 * Data related to a machine's Oracle discovery.
 */
model OracleDiscovery {
  /**
   * Gets or sets number of successfully discovered instances.
   */
  totalInstanceCount?: int64;

  /**
   * Gets or sets number of successfully discovered databases.
   */
  totalDatabaseCount?: int64;

  /**
   * Gets or sets status of partner shallow discovery.
   */
  shallowDiscoveryStatus?: ShallowDiscoveryStatus;

  /**
   * Gets or sets status of partner discovery.
   */
  discoveryScopeStatus?: DiscoveryScopeStatus;
}

/**
 * Data related to a machine's spring boot discovery.
 */
model SpringBootDiscovery {
  /**
   * Gets or sets number of successfully discovered instances.
   */
  totalInstanceCount?: int64;

  /**
   * Gets or sets number of successfully discovered applications.
   */
  totalApplicationCount?: int64;

  /**
   * Gets or sets status of partner shallow discovery.
   */
  shallowDiscoveryStatus?: ShallowDiscoveryStatus;

  /**
   * Gets or sets status of partner discovery.
   */
  discoveryScopeStatus?: DiscoveryScopeStatus;
}

/**
 * AppsAndRoles in the guest virtual machine.
 */
model AppsAndRoles {
  /**
   * Gets or sets Applications of the AppsAndRoles.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  applications?: Application[];

  /**
   * Gets or sets WebApplications of the AppsAndRoles.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  webApplications?: WebApplicationAppsAndRolesModel[];

  /**
   * Gets or sets Features of the AppsAndRoles.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  features?: Feature[];

  /**
   * Gets or sets SQLServers of the AppsAndRoles.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  sqlServers?: SqlServerApplication[];

  /**
   * Gets or sets SharePointServers of the AppsAndRoles.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  sharePointServers?: SharePointServer[];

  /**
   * Gets or sets SystemCenters of the AppsAndRoles.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  systemCenters?: SystemCenter[];

  /**
   * Gets or sets BizTalkServers of the AppsAndRoles.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  bizTalkServers?: BizTalkServer[];

  /**
   * Gets or sets ExchangeServers of the AppsAndRoles.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  exchangeServers?: ExchangeServer[];

  /**
   * Gets or sets OtherDatabaseServers of the AppsAndRoles.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  otherDatabases?: OtherDatabase[];
}

/**
 * Application in the guest virtual machine.
 */
model Application {
  /**
   * Gets or sets Name of the Application.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Gets or sets Version of the Application.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Gets or sets Provider of the Application.
   */
  @visibility(Lifecycle.Read)
  provider?: string;
}

/**
 * WebApplication in the guest virtual machine.
 */
model WebApplicationAppsAndRolesModel {
  /**
   * Gets or sets Name of the WebApplication.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Gets or sets Status of the WebApplication.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Gets or sets Platform of the WebApplication.
   */
  @visibility(Lifecycle.Read)
  platform?: string;

  /**
   * Gets or sets GroupName of the WebApplication.
   */
  @visibility(Lifecycle.Read)
  groupName?: string;

  /**
   * Gets or sets WebServer of the WebApplication.
   */
  @visibility(Lifecycle.Read)
  webServer?: string;

  /**
   * Gets or sets ApplicationPool of the WebApplication.
   */
  @visibility(Lifecycle.Read)
  applicationPool?: string;
}

/**
 * Feature in the guest virtual machine.
 */
model Feature {
  /**
   * Gets or sets Name of the Feature.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Gets or sets FeatureType of the Feature.
   */
  @visibility(Lifecycle.Read)
  featureType?: string;

  /**
   * Gets or sets Parent of the Feature.
   */
  @visibility(Lifecycle.Read)
  parent?: string;

  /**
   * Gets or sets Status of the Feature.
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * SQLServer in the guest virtual machine.
 */
model SqlServerApplication {
  /**
   * Gets or sets Name of the SQLServer.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Gets or sets Edition of the SQLServer.
   */
  @visibility(Lifecycle.Read)
  edition?: string;

  /**
   * Gets or sets ServicePack of the SQLServer.
   */
  @visibility(Lifecycle.Read)
  servicePack?: string;

  /**
   * Gets or sets Version of the SQLServer.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Gets or sets Clustered of the SQLServer.
   */
  @visibility(Lifecycle.Read)
  clustered?: string;

  /**
   * Gets or sets ClusterName of the SQLServer.
   */
  @visibility(Lifecycle.Read)
  clusterName?: string;

  /**
   * Gets or sets the DNS host name of SQLServer.
   */
  @visibility(Lifecycle.Read)
  dnsHostName?: string;

  /**
   * Gets or sets the port of the SQLServer.
   */
  @visibility(Lifecycle.Read)
  port?: string;

  /**
   * Gets or sets the comma separated IPs of the SQLServer.
   */
  @visibility(Lifecycle.Read)
  commaSeparatedIps?: string;

  /**
   * Gets the status.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Gets or sets the value which reflects if Named Pipe is enabled or not.
   */
  @visibility(Lifecycle.Read)
  isNamedPipeEnabled?: boolean;

  /**
   * Gets or sets the value which reflects if Named Pipe is enabled or not.
   */
  @visibility(Lifecycle.Read)
  isTcpIpEnabled?: boolean;

  /**
   * Gets the status.
   */
  @visibility(Lifecycle.Read)
  namedPipeName?: string;
}

/**
 * SharePointServer in the guest virtual machine.
 */
model SharePointServer {
  /**
   * Gets or sets ProductName of the SharePointServer.
   */
  @visibility(Lifecycle.Read)
  productName?: string;

  /**
   * Gets or sets a value indicating whether the SharePointServer is Enterprise.
   */
  @visibility(Lifecycle.Read)
  isEnterprise?: boolean;

  /**
   * Gets or sets Status of the SharePointServer.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Gets or sets Version of the SharePointServer.
   */
  @visibility(Lifecycle.Read)
  version?: string;
}

/**
 * SystemCenter in the guest virtual machine.
 */
model SystemCenter {
  /**
   * Gets or sets ProductName of the SystemCenter.
   */
  @visibility(Lifecycle.Read)
  productName?: string;

  /**
   * Gets or sets Status of the SystemCenter.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Gets or sets Version of the SystemCenter.
   */
  @visibility(Lifecycle.Read)
  version?: string;
}

/**
 * BizTalkServer in the guest virtual machine.
 */
model BizTalkServer {
  /**
   * Gets or sets ProductName of the BizTalkServer.
   */
  @visibility(Lifecycle.Read)
  productName?: string;

  /**
   * Gets or sets Status of the BizTalkServer.
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * ExchangeServer in the guest virtual machine.
 */
model ExchangeServer {
  /**
   * Gets or sets ProductName of the ExchangeServer.
   */
  @visibility(Lifecycle.Read)
  productName?: string;

  /**
   * Gets or sets Edition of the ExchangeServer.
   */
  @visibility(Lifecycle.Read)
  edition?: string;

  /**
   * Gets or sets Roles of the ExchangeServer.
   */
  @visibility(Lifecycle.Read)
  roles?: string;

  /**
   * Gets or sets ServicePack of the ExchangeServer.
   */
  @visibility(Lifecycle.Read)
  servicePack?: string;

  /**
   * Gets or sets Version of the ExchangeServer.
   */
  @visibility(Lifecycle.Read)
  version?: string;
}

/**
 * OtherDatabase in the guest virtual machine.
 */
model OtherDatabase {
  /**
   * Gets or sets DatabaseType of the OtherDatabase.
   */
  @visibility(Lifecycle.Read)
  databaseType?: string;

  /**
   * Gets or sets Instance of the OtherDatabase.
   */
  @visibility(Lifecycle.Read)
  instance?: string;

  /**
   * Gets or sets Version of the OtherDatabase.
   */
  @visibility(Lifecycle.Read)
  version?: string;
}

/**
 * product support status.
 */
model ProductSupportStatus {
  /**
   * current version.
   */
  currentVersion?: string;

  /**
   * esu status.
   */
  esuStatus?: esuStatus;

  /**
   * support status.
   */
  supportStatus?: supportStatus;

  /**
   * support end date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  supportEndDate?: utcDateTime;

  /**
   * esu year.
   */
  esuYear?: esuYear;
}

/**
 * Second level object returned as part of Machine REST resource.
 */
model OperatingSystem {
  /**
   * Gets or sets the type of the operating system.
   */
  osType?: string;

  /**
   * Gets or sets the Name of the operating system.
   */
  osName?: string;

  /**
   * Gets or sets the Version of the operating system.
   */
  osVersion?: string;

  /**
   * Gets or sets the Architecture of the operating system.
   */
  osArchitecture?: string;

  /**
   * Gets or sets the Distro of the operating system.
   */
  osDistro?: string;

  /**
   * Gets or sets the Major Version of the operating system.
   */
  osMajorVersion?: string;

  /**
   * Gets or sets the Variant of the operating system.
   */
  osVariant?: string;
}

/**
 * Contains data related to Azure arc discovery.
 */
model ArcDiscovery {
  /**
   * AzureArc status indicates whether arc discovery has successfully completed or not.
   */
  @visibility(Lifecycle.Read)
  status: AzureArcStatus;

  /**
   * Machine Resource Id.
   */
  @visibility(Lifecycle.Read)
  machineResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.HybridCompute/machines";
    }
  ]>;
}

/**
 * The type used for update operations of the HypervMachine.
 */
model HypervMachineUpdate {
  /**
   * The updatable properties of the HypervMachine.
   */
  properties?: HypervMachineUpdateProperties;
}

/**
 * The updatable properties of the HypervMachine.
 */
model HypervMachineUpdateProperties {
  /**
   * Gets or sets the firmware.
   */
  firmware?: string;

  /**
   * Gets or sets the run as account ID of the machine.
   */
  runAsAccountId?: string;

  /**
   * product support status.
   */
  productSupportStatus?: ProductSupportStatus;

  /**
   * Gets or sets the Number of Processor Cores
   *             allocated for the
   * machine.
   */
  numberOfProcessorCore?: int32;

  /**
   * Gets or sets the allocated Memory in MB.
   */
  allocatedMemoryInMb?: float64;

  /**
   * Gets or sets the Operating System Details installed on the machine.
   */
  operatingSystemDetails?: OperatingSystem;

  /**
   * Gets or sets the Machine BIOS serial number.
   */
  biosSerialNumber?: string;

  /**
   * Gets or sets the BIOS GUID.
   */
  biosGuid?: string;

  /**
   * Gets or sets tags on the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Class for machine software inventory properties.
 */
model MachineSoftwareInventoryProperties {
  /**
   * Apps And Roles of the machine entity.
   */
  @visibility(Lifecycle.Read)
  appsAndRoles?: AppsAndRoles;

  /**
   * provisioning state enum
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Operation status REST resource.
 */
model OperationStatus {
  /**
   * Gets the Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Gets the operation name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Gets the status of the operation. ARM expects the terminal status to be one
   * of
   *             Succeeded/ Failed/ Canceled. All other values imply that the
   * operation is still running.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Gets the start time.
   */
  @visibility(Lifecycle.Read)
  startTime?: string;

  /**
   * Gets the start time.
   */
  @visibility(Lifecycle.Read)
  endTime?: string;

  /**
   * Gets the error.
   */
  @visibility(Lifecycle.Read)
  error?: OperationStatusError;

  /**
   * Operation status properties
   */
  @visibility(Lifecycle.Read)
  properties?: OperationStatusProperties;
}

/**
 * Class for operation status errors.
 */
model OperationStatusError {
  /**
   * Gets the error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Gets the error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Class for operation result properties.
 */
model OperationStatusProperties {
  /**
   * Gets or sets the result or output of the workflow.
   */
  result?: string;
}

/**
 * Class for run as account properties.
 */
model RunAsAccountProperties {
  /**
   * Display name of the run as account.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Gets the credential type of the run as account.
   */
  @visibility(Lifecycle.Read)
  credentialType?: string;

  /**
   * Timestamp marking run as account creation.
   */
  @visibility(Lifecycle.Read)
  createdTimestamp?: string;

  /**
   * Timestamp marking last updated on the run as account.
   */
  @visibility(Lifecycle.Read)
  updatedTimestamp?: string;

  /**
   * Gets the appliance name of the run as account.
   */
  @visibility(Lifecycle.Read)
  applianceName?: string;

  /**
   * provisioning state enum
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * DependencyMap ServiceMap extensions ServerGroup Members Request
 */
model DependencyMapServiceMapextensionsServerGroupMembersRequest {
  /**
   * port of server
   */
  serverPort?: int32;

  /**
   * start time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * end time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * optional filters
   */
  filters?: DependencyMapServiceMapextensionsDependencyMapRequestFilters;
}

/**
 * Defines class that represents input to enable or disable DMP on machine
 *
 *       for cosmos entity operation.
 */
model UpdateMachineDepMapStatus {
  /**
   * Gets or sets the machine collection.
   */
  @identifiers(#[])
  machines?: DependencyMapMachineInput[];
}

/**
 * Machine class.
 */
model DependencyMapMachineInput {
  /**
   * Gets or sets the ARM id of the machine.
   */
  machineId?: string;

  /**
   * Gets or sets a value indicating whether
   *             dependency mapping is to
   * be enabled or not.
   */
  isDependencyMapToBeEnabled?: boolean;
}

/**
 * The list of Machine MetaData.
 */
model MachineMetadataCollection {
  /**
   * The list of Machine MetaData.
   */
  @identifiers(#[])
  value: MachineMetadata[];
}

/**
 * The properties of Machine MetaData
 */
model MachineMetadata {
  /**
   * arm id of the machine.
   */
  machineArmId: string;

  /**
   * value representing state of dependency mapping (enabled/disabled).
   */
  dependencyMapping: string;

  /**
   * machine tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags: Record<string>;
}

/**
 * The type used for update operations of the ImportSite.
 */
model ImportSiteUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The updatable properties of the ImportSite.
   */
  properties?: ImportSiteUpdateProperties;
}

/**
 * The updatable properties of the ImportSite.
 */
model ImportSiteUpdateProperties {
  /**
   * Gets or sets the ARM ID of migration hub solution for SDS.
   */
  discoverySolutionId?: string;

  /**
   * The status of the last operation.
   */
  provisioningState?: ProvisioningState;
}

/**
 * Import URI response class.
 */
model SasUriResponse {
  /**
   * Gets or sets the job ARM ID.
   */
  jobArmId?: string;

  /**
   * Gets or sets the SAS URI.
   */
  uri?: string;

  /**
   * Gets or sets the import type.
   */
  importType?: ImportTypeValues = ImportTypeValues.AzureMigrateCSV;
}

/**
 * Paged collection of DeleteImportMachinesJob items
 */
model PagedDeleteImportMachinesJob {
  /**
   * The DeleteImportMachinesJob items on this page
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: DeleteImportMachinesJob[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: url;
}

/**
 * Delete Imported Machines Job Properties
 */
model DeleteImportedMachinesJobProperties {
  /**
   * blob name
   */
  blobName?: string;

  /**
   * error Sas Uri
   */
  errorSasUri?: string;

  /**
   * job State
   */
  jobState?: DeleteImportedMachinesJobPropertiesJobState;

  /**
   * number Of Machines Deleted
   */
  numberOfMachinesDeleted?: int32;

  /**
   * deletion Confirmation
   */
  deletionConfirmation?: boolean;

  /**
   * errors list
   */
  @visibility(Lifecycle.Read)
  errors?: string[];

  /**
   * Gets or sets the Job status.
   */
  status?: string;

  /**
   * Gets or sets the Job start time.
   */
  startTime?: string;

  /**
   * Gets or sets the Job end time.
   */
  endTime?: string;

  /**
   * Gets or sets the Display name.
   */
  displayName?: string;

  /**
   * The status of the last operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: ProvisioningState;
}

/**
 * Paged collection of ExportImportedMachinesJob items
 */
model PagedExportImportedMachinesJob {
  /**
   * The ExportImportedMachinesJob items on this page
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ExportImportedMachinesJob[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: url;
}

/**
 *  Export Imported Machines JobEntity Properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ExportImportedMachinesJobEntityProperties {
  /**
   * blob name
   */
  blobName?: string;

  /**
   * sas uri
   */
  sasUri?: string;
}

/**
 * Paged collection of ImportMachinesJob items
 */
model PagedImportMachinesJob {
  /**
   * The ImportMachinesJob items on this page
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ImportMachinesJob[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: url;
}

/**
 * ImportMachines JobProperties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ImportMachinesJobProperties {
  /**
   * blob name
   */
  blobName?: string;

  /**
   * blob sasUri
   */
  blobSasUri?: string;

  /**
   * job Result
   */
  jobResult?: JobResult;

  /**
   * number Of Machines Imported
   */
  numberOfMachinesImported?: int32;

  /**
   * blob Creation TimeStamp
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  blobCreationTimeStamp?: utcDateTime;

  /**
   * error summary
   */
  errorSummary?: JobErrorSummary;
}

/**
 * Summary of errors and warnings encountered during a job execution
 */
model JobErrorSummary {
  /**
   * List of error messages encountered during job execution
   */
  errors?: string[];

  /**
   * Total number of errors encountered during job execution
   */
  errorCount?: int32;

  /**
   * Total number of warnings generated during job execution
   */
  warningCount?: int32;
}

/**
 * Class for machine properties.
 */
model ImportMachineProperties {
  /**
   * Firmware of the machine.
   */
  @visibility(Lifecycle.Read)
  firmware?: string;

  /**
   * CPU utilization.
   */
  @visibility(Lifecycle.Read)
  percentageCpuUtilization?: float32;

  /**
   * Memory utilization.
   */
  @visibility(Lifecycle.Read)
  percentageMemoryUtilization?: float32;

  /**
   * Number of disks.
   */
  @visibility(Lifecycle.Read)
  numberOfDisks?: int32;

  /**
   * Total disk read operations per second.
   */
  @visibility(Lifecycle.Read)
  totalDiskReadOperationsPerSecond?: float32;

  /**
   * Total disk write operations per second.
   */
  @visibility(Lifecycle.Read)
  totalDiskWriteOperationsPerSecond?: float32;

  /**
   * Total disk write throughput.
   */
  @visibility(Lifecycle.Read)
  totalDiskWriteThroughput?: float32;

  /**
   * Total disk read throughput.
   */
  @visibility(Lifecycle.Read)
  totalDiskReadThroughput?: float32;

  /**
   * MAC Address.
   */
  @visibility(Lifecycle.Read)
  macAddress?: string;

  /**
   * IP Addresses.
   */
  @visibility(Lifecycle.Read)
  ipAddresses?: string[];

  /**
   * Machine ID.
   */
  @visibility(Lifecycle.Read)
  machineId?: string;

  /**
   * Machine manager ID.
   */
  @visibility(Lifecycle.Read)
  machineManagerId?: string;

  /**
   * Number of network adapters.
   */
  @visibility(Lifecycle.Read)
  numberOfNetworkAdapters?: int32;

  /**
   * Network in throughput.
   */
  @visibility(Lifecycle.Read)
  networkInThroughput?: float32;

  /**
   * Network out throughput.
   */
  @visibility(Lifecycle.Read)
  networkOutThroughput?: float32;

  /**
   * Server type.
   */
  @visibility(Lifecycle.Read)
  serverType?: string;

  /**
   * Fabric type.
   */
  @visibility(Lifecycle.Read)
  hypervisor?: string;

  /**
   * Hypervisor version number.
   */
  @visibility(Lifecycle.Read)
  hypervisorVersionNumber?: string;

  /**
   * Disks attached to the machine.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  disks?: WebRoleImportDisk[];

  /**
   * Server FQDN.
   */
  @visibility(Lifecycle.Read)
  vmFqdn?: string;

  /**
   * Total storage in use.
   */
  @visibility(Lifecycle.Read)
  storageInUseGb?: float32;

  /**
   * Gets or sets the Number of Processor Cores
   *             allocated for the
   * machine.
   */
  numberOfProcessorCore?: int32;

  /**
   * Gets or sets the allocated Memory in MB.
   */
  allocatedMemoryInMb?: float64;

  /**
   * Gets or sets the Operating System Details installed on the machine.
   */
  operatingSystemDetails?: WebRoleOperatingSystem;

  /**
   * Gets or sets the Machine BIOS serial number.
   */
  biosSerialNumber?: string;

  /**
   * Gets or sets the BIOS GUID.
   */
  biosGuid?: string;

  /**
   * Gets the Display name of the machine.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Gets the discovery state of the server.
   */
  @visibility(Lifecycle.Read)
  discoverySource?: DiscoverySource;

  /**
   * Value indicating whether VM is deleted.
   */
  @visibility(Lifecycle.Read)
  isDeleted?: boolean;

  /**
   * Gets the marking machine creation.
   */
  @visibility(Lifecycle.Read)
  createdTimestamp?: string;

  /**
   * Gets the timestamp marking last updated on the machine.
   */
  @visibility(Lifecycle.Read)
  updatedTimestamp?: string;

  /**
   * machine tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags: Record<string>;

  /**
   * The status of the last operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: ProvisioningState;
}

/**
 * Class representing the imported machine web model.
 */
model WebRoleImportDisk {
  /**
   * Disk read throughput.
   */
  @visibility(Lifecycle.Read)
  megabytesPerSecondOfRead?: float32;

  /**
   * Disk write throughput.
   */
  @visibility(Lifecycle.Read)
  megabytesPerSecondOfWrite?: float32;

  /**
   * Disk read IOPS.
   */
  @visibility(Lifecycle.Read)
  numberOfReadOperationsPerSecond?: float32;

  /**
   * Disk write IOPS.
   */
  @visibility(Lifecycle.Read)
  numberOfWriteOperationsPerSecond?: float32;

  /**
   * Gets or sets Bytes allocated for the disk.
   */
  maxSizeInBytes?: int64;

  /**
   * Gets or sets Name of the disk.
   */
  name?: string;

  /**
   * Gets or sets Type of the disk.
   */
  diskType?: string;

  /**
   * Gets or sets LUN of the disk.
   */
  lun?: int32;

  /**
   * Gets or sets Path of the disk.
   */
  path?: string;
}

/**
 * Second level object returned as part of Machine REST resource.
 */
model WebRoleOperatingSystem {
  /**
   * Gets or sets the type of the operating system.
   */
  osType?: string;

  /**
   * Gets or sets the Name of the operating system.
   */
  osName?: string;

  /**
   * Gets or sets the Version of the operating system.
   */
  osVersion?: string;

  /**
   * Gets or sets the Architecture of the operating system.
   */
  osArchitecture?: string;
}

/**
 * The type used for update operations of the MasterSite.
 */
model MasterSiteUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The updatable properties of the MasterSite.
   */
  properties?: MasterSiteUpdateProperties;
}

/**
 * The updatable properties of the MasterSite.
 */
model MasterSiteUpdateProperties {
  /**
   * Gets or sets the state of public network access.
   */
  publicNetworkAccess?: MasterSitePropertiesPublicNetworkAccess;

  /**
   * Gets or sets a value indicating whether multiple sites per site type are
   * allowed.
   */
  allowMultipleSites?: boolean;

  /**
   * Gets or sets the sites that are a part of Master Site.
   *             The key
   * should contain the Site ARM name.
   */
  sites?: string[];

  /**
   * Gets or sets a value for customer storage account ARM id.
   */
  customerStorageAccountArmId?: string;
}

/**
 * ErrorSummaryRequest body
 */
model ErrorSummaryRequest {
  /**
   * Gets or sets the Appliance Name.
   */
  applianceName?: string;
}

/**
 * private link resource properties model
 */
model PrivateLinkResourceProperties {
  /**
   * required members
   */
  requiredMembers?: string[];

  /**
   * required zone names
   */
  requiredZoneNames?: string[];

  /**
   * group id
   */
  groupId?: string;

  /**
   * provisioning state enum
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Class for SQL site properties.
 */
model SqlSiteProperties {
  /**
   * Gets or sets the appliance details used by service to communicate
   *
   * to the appliance.
   */
  @identifiers(#[])
  siteAppliancePropertiesCollection?: SiteApplianceProperties[];

  /**
   * Gets or sets the discovery scenario.
   */
  discoveryScenario?: SqlSitePropertiesDiscoveryScenario;

  /**
   * Gets the service endpoint.
   */
  @visibility(Lifecycle.Read)
  serviceEndpoint?: string;

  /**
   * provisioning state enum
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets the Arc scope properties for the sql site.
   */
  arcScope?: ArcScopeProperties;
}

/**
 * The type used for update operations of the SqlSite.
 */
model SqlSiteUpdate {
  /**
   * The updatable properties of the SqlSite.
   */
  properties?: SqlSiteUpdateProperties;
}

/**
 * The updatable properties of the SqlSite.
 */
model SqlSiteUpdateProperties {
  /**
   * Gets or sets the appliance details used by service to communicate
   *
   * to the appliance.
   */
  @identifiers(#[])
  siteAppliancePropertiesCollection?: SiteApplianceProperties[];

  /**
   * Gets or sets the discovery scenario.
   */
  discoveryScenario?: SqlSitePropertiesDiscoveryScenario;

  /**
   * Gets or sets the Arc scope properties for the sql site.
   */
  arcScope?: ArcScopePropertiesUpdate;
}

/**
 * Properties for defining Arc scope.
 */
model ArcScopePropertiesUpdate {
  /**
   * Locations to discover Arc resources from.
   */
  locations?: string[];

  /**
   * The type of scope, currently supporting SubscriptionOrResourceGroupIds only.
   */
  scopeType?: ArcSiteScopeType;

  /**
   * List of subscription or resource group ARM IDs. Allowed only if scopeType is SubscriptionOrResourceGroupIds.
   */
  subscriptionOrResourceGroupIds?: Azure.Core.armResourceIdentifier[];

  /**
   * The type of sync, currently supporting Manual and Periodic only.
   */
  syncType?: ArcSyncType;

  /**
   * Tag Sync Confirmation. If true, tags on Arc resources will be synced to Azure Migrate resources.
   */
  tagSyncMode?: TagSyncMode;
}

/**
 * Discovery site data source properties class.
 */
model SqlDiscoverySiteDataSourceProperties {
  /**
   * Gets or sets the discovery site Id.
   */
  discoverySiteId?: string;

  /**
   * provisioning state enum
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * SQL Inventory Import URI response object model.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SQLInventoryImportBody {
  /**
   * Gets or sets the job ARM ID.
   */
  jobArmId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks";
    }
  ]>;

  /**
   * Gets or sets the SAS URI.
   */
  uri?: string;

  /**
   * Gets or sets the import type.
   */
  importType?: SqlImportType;
}

/**
 * ExportSqlServerRequest body
 */
model ExportSqlServersRequest {
  /**
   * Gets or sets the Appliance Name.
   */
  applianceName?: string;

  /**
   * filter options.
   */
  filter?: string;
}

/**
 * Paged collection of ImportSqlInventoryJob items
 */
model PagedImportSqlInventoryJob {
  /**
   * The ImportSqlInventoryJob items on this page
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ImportSqlInventoryJob[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: url;
}

/**
 * Import SQL inventory job properties web model
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ImportSqlInventoryJobProperties {
  /**
   * Gets the Blob name for the blob to fetch Import file from.
   */
  blobName?: string;

  /**
   * Gets the blob SAS Uri of the input import file.
   */
  @secret
  blobSasUri?: string;

  /**
   * Gets the Job Result status.
   */
  jobResult?: ImportSqlInventoryJobResult;

  /**
   * Gets the Number of servers imported.
   */
  numberOfServersImported?: int32;

  /**
   * Gets the Number of databases imported.
   */
  numberOfDatabasesImported?: int32;

  /**
   * Gets the Number of availability groups imported.
   */
  numberOfAvailabilityGroupsImported?: int32;

  /**
   * Gets the Blob creation time stamp.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  blobCreationTimeStamp?: utcDateTime;

  /**
   * Gets the Job Error Summary.
   */
  errorSummary?: SqlImportJobErrorSummary;
}

/**
 * Job Error Summary
 */
model SqlImportJobErrorSummary {
  /**
   * Collection of errors encountered during the SQL import operation
   */
  errors?: ErrorResponse[];

  /**
   * Gets or sets the Number of errors while trying to import SQL Inventory from CSV.
   */
  errorCount?: int32;

  /**
   * Gets or sets the Number of warnings while trying to import SQL Inventory from CSV. Warnings are included in the 'errors' array.
   */
  warningCount?: int32;
}

/**
 * SQL site refresh.
 */
model SqlSiteRefreshBody {
  /**
   * Gets or sets the appliance name of the agent in the site.
   */
  applianceName?: string;
}

/**
 * Class for SQL Server availability group properties.
 */
model SqlAvailabilityGroupProperties {
  /**
   * Gets or sets the SQL Availability Group Name.
   */
  availabilityGroupName?: string;

  /**
   * Gets or sets the type of availability group.             Currently there are two types of AGs Traditional and Distributed.
   */
  availabilityGroupType?: SqlAvailabilityGroupPropertiesAvailabilityGroupType;

  /**
   * Gets or sets a value indicating whether AG is multi subnet or not.
   */
  isMultiSubNet?: boolean;

  /**
   * Gets or sets the Cluster name where AG is hosted.
   */
  clusterName?: string;

  /**
   * Gets the list of availability replica properties which together forms this availability group.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  availabilityReplicas?: SqlAvailabilityReplicaProperties[];

  /**
   * Gets the parent availability replica overview if any.
   *             This would be
   * set with details of parent AG and AR for cases where this availability group is
   * a part of a distributed AG.
   *             Currently, we do not populate this
   * since discovery and linking of DAG(Distributed Availability Group) is not
   * implemented.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  parentReplicaOverviewList?: SqlAvailabilityReplicaOverview[];

  /**
   * Gets or sets a value indicating whether this Availability group is part of a
   * distributed AG.
   */
  isPartOfDistributedAvailabilityGroup?: boolean;

  /**
   * Gets or sets a value indicating whether the entity is deleted.
   */
  isDeleted?: boolean;

  /**
   * Gets or sets the marking machine creation.
   */
  createdTimestamp?: string;

  /**
   * Gets or sets the timestamp marking last updated on the machine.
   */
  updatedTimestamp?: string;

  /**
   * provisioning state enum
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Gets the data related to Azure arc discovery.
   */
  @visibility(Lifecycle.Read)
  arcDiscovery?: GenericArcDiscovery;

  /**
   * Gets the discovery source.
   */
  @visibility(Lifecycle.Read)
  discoverySource?: DiscoverySource;
}

/**
 * Class for SQL Server availability replica properties.
 */
model SqlAvailabilityReplicaProperties {
  /**
   * Gets or sets the SQL Availability Replica Name.
   */
  availabilityReplicaName?: string;

  /**
   * Gets or sets the SQL Availability Replica Id.
   */
  availabilityReplicaId?: string;

  /**
   * Gets or sets the replica type of the availability group.
   */
  replicaType?: SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaType;

  /**
   * Gets or sets the state of the availability replica.
   */
  replicaState?: SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaState;

  /**
   * Gets or sets the synchronization status of the replica.
   */
  replicaSyncStatus?: SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaSyncStatus;

  /**
   * Gets or sets the commit mode of the replica.
   */
  replicaCommitMode?: SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaCommitMode;

  /**
   * Gets or sets the read mode of the replica.
   */
  replicaReadMode?: SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaReadMode;

  /**
   * Gets or sets the seed mode of the replica.
   */
  replicaSeedMode?: SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaSeedMode;

  /**
   * Gets or sets the Availability Replica object if Replica is of type database.
   * This is null in case Replica is
   *             of type AG. This is to be populated
   * in case of normal AG.
   */
  sqlDatabaseReplicaInfo?: SqlDatabaseReplicaInfo;

  /**
   * Gets or sets the Availability Replica object if Replica is of type AG. This is
   * null in case Replica is
   *             of type database. This is to be populated
   * in case AG is of type DAG.
   */
  sqlAvailabilityGroupReplicaInfo?: SqlAvailabilityGroupReplicaInfo;
}

/**
 * Class which represents the SQL availability replica properties of type
 * databases.
 */
model SqlDatabaseReplicaInfo {
  /**
   * Gets or sets the host name of the availability replica.
   */
  hostName?: string;

  /**
   * Gets or sets the SQL Server name of the availability replica.
   */
  sqlServerName?: string;

  /**
   * Gets or sets the SQL Server name of the availability replica.
   */
  sqlServerArmId?: string;
}

/**
 * Class which represents the SQL availability replica properties of type AG.
 */
model SqlAvailabilityGroupReplicaInfo {
  /**
   * Gets or sets the name of the cluster on which this replica is hosted.
   */
  clusterName?: string;

  /**
   * Gets or sets the name of the availability replica.
   */
  availabilityGroupName?: string;

  /**
   * Gets or sets the AG ARM ID which are part of this Replica.
   */
  availabilityGroupArmId?: string;
}

/**
 * Web model for SQL replica overview.
 */
model SqlAvailabilityReplicaOverview {
  /**
   * Gets or sets the state of the availability replica.
   */
  replicaState?: SqlAvailabilityReplicaOverviewReplicaState;

  /**
   * Gets or sets the SQL Availability Replica Id within the Availability Group this
   * database is a part of.
   */
  availabilityReplicaId?: string;

  /**
   * Gets or sets the Availability Group Id in which this database participates if
   * any. It would be set if the database has
   * {Microsoft.Azure.FDS.CosmosDB.SqlDatabaseEntity.IsDatabaseHighlyAvailable} has
   * a value "true".
   */
  availabilityGroupArmId?: string;

  /**
   * Gets or sets the SQL Availability group name.
   */
  availabilityGroupName?: string;
}

/**
 * Contains data related to Azure Generic Arc Discovery.
 */
model GenericArcDiscovery {
  /**
   * AzureArc status indicates whether arc discovery has successfully completed or not.
   */
  @visibility(Lifecycle.Read)
  status: AzureArcStatus;

  /**
   * Resource Id.
   */
  @visibility(Lifecycle.Read)
  resourceId: Azure.Core.armResourceIdentifier;
}

/**
 * Class for SQL Server database properties.
 */
model SqlDatabasePropertiesV2 {
  /**
   * Gets or sets the Replica overview.
   */
  parentReplicaOverview?: SqlAvailabilityReplicaOverview;

  /**
   * Gets or sets a value indicating whether this database is a part of an HA setup.
   */
  isDatabaseHighlyAvailable?: boolean;

  /**
   * Gets the file metadata list.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  fileMetadataList?: FileMetaData[];

  /**
   * Gets or sets the hostname.
   */
  hostname?: string;

  /**
   * Gets or sets the SQL Server Id in which the database resides.
   */
  sqlServerName?: string;

  /**
   * Gets or sets the status.
   */
  status?: string;

  /**
   * Gets or sets the size in Mb.
   */
  sizeMb?: float32;

  /**
   * Gets or sets the SQL database name.
   */
  databaseName?: string;

  /**
   * Gets or sets the SQL Server ARM Id in which the database resides.
   */
  sqlServerArmId?: string;

  /**
   * Gets or sets the database compatibility level.
   */
  compatibilityLevel?: string;

  /**
   * Gets or sets a value indicating whether the entity is deleted.
   */
  isDeleted?: boolean;

  /**
   * Gets the errors.
   */
  @visibility(Lifecycle.Read)
  errors?: Errors[];

  /**
   * Gets or sets the marking machine creation.
   */
  createdTimestamp?: string;

  /**
   * Gets or sets the timestamp marking last updated on the machine.
   */
  updatedTimestamp?: string;

  /**
   * The status of the last operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: ProvisioningState;

  /**
   * Gets the data related to Azure arc discovery.
   */
  @visibility(Lifecycle.Read)
  arcDiscovery?: GenericArcDiscovery;

  /**
   * Gets the discovery source.
   */
  @visibility(Lifecycle.Read)
  discoverySource?: DiscoverySource;
}

/**
 * File Metadata web model.
 */
model FileMetaData {
  /**
   * Gets or sets the logical name of the file.
   */
  logicalName?: string;

  /**
   * Gets or sets the operating-system full path of the file.
   */
  physicalFullName?: string;

  /**
   * Gets or sets the database file type.
   */
  fileType?: FileType;

  /**
   * Gets or sets the size of the file in MB.
   */
  sizeInMb?: float32;

  /**
   * Gets or sets a value indicating whether memory optimized data option is enabled.
   */
  isMemoryOptimizedDataOptionEnabled?: boolean;
}

/**
 * The properties of a server machine tracked resource
 */
model Errors {
  /**
   * Gets the error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Gets the message parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  messageParameters?: Record<string>;

  /**
   * Gets the appliance name.
   */
  @visibility(Lifecycle.Read)
  applianceName?: string;

  /**
   * Gets the error ID.
   */
  @visibility(Lifecycle.Read)
  id?: int32;

  /**
   * Gets the error name.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Gets the possible causes of error.
   */
  @visibility(Lifecycle.Read)
  possibleCauses?: string;

  /**
   * Gets the recommended action to resolve error.
   */
  @visibility(Lifecycle.Read)
  recommendedAction?: string;

  /**
   * Gets the error severity.
   */
  @visibility(Lifecycle.Read)
  severity?: string;

  /**
   * Gets the error summary message.
   */
  @visibility(Lifecycle.Read)
  summaryMessage?: string;

  /**
   * Gets the error source.
   */
  @visibility(Lifecycle.Read)
  source?: MicrosoftAzureFDSWebRoleHealthErrorDetailsSource;

  /**
   * Gets the time stamp when the error was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedTimeStamp?: utcDateTime;

  /**
   * Gets run as account id used while performing discovery             of entity.
   */
  @visibility(Lifecycle.Read)
  runAsAccountId?: string;

  /**
   * Gets discovery scope for which             error is encountered.
   */
  @visibility(Lifecycle.Read)
  discoveryScope?: HealthErrorDetailsDiscoveryScope;
}

/**
 * Class for SQL Server properties.
 */
model SqlServerProperties {
  /**
   * Gets the Machine Overview properties of all machines on which the SQL server is deployed.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  machineOverviewList?: SqlMachineOverview[];

  /**
   * Gets or sets the number of databases part of availability group on this SQL instance.
   */
  numberOfAgDatabases?: int32;

  /**
   * Gets or sets the FCI properties if the instance is an FCI instance. This would be populated if IsClustered is true.
   */
  sqlFciProperties?: SqlFciProperties;

  /**
   * product support status.
   */
  productSupportStatus?: ProductSupportStatus;

  /**
   * Gets or sets the SQL server version.
   */
  version?: string;

  /**
   * Gets or sets total number of users databases.
   */
  numberOfUserDatabases?: int32;

  /**
   * Gets or sets total size of all user databases.
   */
  sumOfUserDatabasesSizeInMb?: float32;

  /**
   * Gets or sets size of temp database.
   */
  tempDbSizeInMb?: float32;

  /**
   * Gets or sets maximum server memory in use.
   */
  maxServerMemoryInUseInMb?: float32;

  /**
   * Gets or sets the SQL server number of cores that have visible online status.
   */
  visibleOnlineCoreCount?: int32;

  /**
   * Gets or sets number of logins.
   */
  numOfLogins?: int32;

  /**
   * Gets or sets physical CPU count.
   */
  physicalCpuCount?: float32;

  /**
   * Gets or sets logical CPU count.
   */
  logicalCpuCount?: int32;

  /**
   * Gets or sets the SQL server engine edition.
   */
  engineEdition?: string;

  /**
   * Gets or sets the SQL server edition.
   */
  edition?: string;

  /**
   * Gets or sets a value indicating whether High Availability is enabled or not.
   */
  isHighAvailabilityEnabled?: boolean;

  /**
   * Gets or sets a value indicating whether failover cluster is configured or not.
   */
  isClustered?: boolean;

  /**
   * Gets or sets the Hyper thread ratio.
   */
  hyperthreadRatio?: int32;

  /**
   * Gets or sets the SQL start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sqlStartTime?: utcDateTime;

  /**
   * Gets the list of machine ARM Ids on which the SQL server is deployed.
   */
  @visibility(Lifecycle.Read)
  machineArmIds?: string[];

  /**
   * Gets or sets the run as account ID of the SQL server.
   */
  runAsAccountId?: string;

  /**
   * Gets or sets the hydrated run as account ID of the SQL server.
   */
  hydratedRunAsAccountId?: string;

  /**
   * Gets or sets hostname.
   */
  hostName?: string;

  /**
   * Gets or sets the SQL server instance name.
   */
  sqlServerName?: string;

  /**
   * Gets or sets the Preferred Port Number.
   */
  portNumber?: int32;

  /**
   * Gets the errors.
   */
  @visibility(Lifecycle.Read)
  errors?: Errors[];

  /**
   * Gets or sets tags on the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<unknown>;

  /**
   * Gets or sets a value indicating whether the entity is deleted.
   */
  isDeleted?: boolean;

  /**
   * Gets or sets the marking machine creation.
   */
  createdTimestamp?: string;

  /**
   * Gets or sets the timestamp marking last updated on the machine.
   */
  updatedTimestamp?: string;

  /**
   * Gets or sets the powered on status.
   */
  status?: SqlServerStatus;

  /**
   * The status of the last operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: ProvisioningState;

  /**
   * Gets the data related to Azure arc discovery.
   */
  @visibility(Lifecycle.Read)
  arcDiscovery?: GenericArcDiscovery;

  /**
   * Gets the discovery source.
   */
  @visibility(Lifecycle.Read)
  discoverySource?: DiscoverySource;
}

/**
 * Gets or sets SQL machine overview data.
 */
model SqlMachineOverview {
  /**
   * Gets or sets SQL machine ARM ID.
   */
  machineArmId?: string;

  /**
   * Gets or sets SQL machine display name.
   */
  displayName?: string;

  /**
   * Gets or sets SQL machine FCI role.
   */
  fciRole?: SqlMachineOverviewFciRole;
}

/**
 * The class representing the properties for an FCI instance.
 */
model SqlFciProperties {
  /**
   * Gets or sets the state of the FCI instance.
   */
  state?: FCIInstanceState;

  /**
   * Gets or sets the FCI Network Name used to connect to this FCI instance.
   */
  networkName?: string;

  /**
   * Gets or sets a value indicating whether the FCI is hosted on possible owners
   * which are in multiple subnets.
   */
  isMultiSubnet?: boolean;

  /**
   * Gets or sets the count of Shared Disks for SQL FCI.
   */
  sharedDiskCount?: int32;
}

/**
 * The type used for update operations of the SqlServerV2.
 */
model SqlServerV2Update {
  /**
   * The updatable properties of the SqlServerV2.
   */
  properties?: SqlServerV2UpdateProperties;
}

/**
 * The updatable properties of the SqlServerV2.
 */
model SqlServerV2UpdateProperties {
  /**
   * Gets or sets the number of databases part of availability group on this SQL instance.
   */
  numberOfAgDatabases?: int32;

  /**
   * Gets or sets the FCI properties if the instance is an FCI instance. This would be populated if IsClustered is true.
   */
  sqlFciProperties?: SqlFciProperties;

  /**
   * product support status.
   */
  productSupportStatus?: ProductSupportStatus;

  /**
   * Gets or sets the SQL server version.
   */
  version?: string;

  /**
   * Gets or sets total number of users databases.
   */
  numberOfUserDatabases?: int32;

  /**
   * Gets or sets total size of all user databases.
   */
  sumOfUserDatabasesSizeInMb?: float32;

  /**
   * Gets or sets size of temp database.
   */
  tempDbSizeInMb?: float32;

  /**
   * Gets or sets maximum server memory in use.
   */
  maxServerMemoryInUseInMb?: float32;

  /**
   * Gets or sets the SQL server number of cores that have visible online status.
   */
  visibleOnlineCoreCount?: int32;

  /**
   * Gets or sets number of logins.
   */
  numOfLogins?: int32;

  /**
   * Gets or sets physical CPU count.
   */
  physicalCpuCount?: float32;

  /**
   * Gets or sets logical CPU count.
   */
  logicalCpuCount?: int32;

  /**
   * Gets or sets the SQL server engine edition.
   */
  engineEdition?: string;

  /**
   * Gets or sets the SQL server edition.
   */
  edition?: string;

  /**
   * Gets or sets a value indicating whether High Availability is enabled or not.
   */
  isHighAvailabilityEnabled?: boolean;

  /**
   * Gets or sets a value indicating whether failover cluster is configured or not.
   */
  isClustered?: boolean;

  /**
   * Gets or sets the Hyper thread ratio.
   */
  hyperthreadRatio?: int32;

  /**
   * Gets or sets the SQL start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sqlStartTime?: utcDateTime;

  /**
   * Gets or sets the run as account ID of the SQL server.
   */
  runAsAccountId?: string;

  /**
   * Gets or sets the hydrated run as account ID of the SQL server.
   */
  hydratedRunAsAccountId?: string;

  /**
   * Gets or sets hostname.
   */
  hostName?: string;

  /**
   * Gets or sets the SQL server instance name.
   */
  sqlServerName?: string;

  /**
   * Gets or sets the Preferred Port Number.
   */
  portNumber?: int32;

  /**
   * Gets or sets tags on the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<unknown>;

  /**
   * Gets or sets a value indicating whether the entity is deleted.
   */
  isDeleted?: boolean;

  /**
   * Gets or sets the marking machine creation.
   */
  createdTimestamp?: string;

  /**
   * Gets or sets the timestamp marking last updated on the machine.
   */
  updatedTimestamp?: string;

  /**
   * Gets or sets the powered on status.
   */
  status?: SqlServerStatus;

  /**
   * The status of the last operation.
   */
  provisioningState?: ProvisioningState;
}

/**
 * SQL site usage.
 */
model SqlSiteUsage {
  /**
   * Gets or sets the number of servers discovered in the site.
   */
  serverCount?: int32;

  /**
   * Gets or sets the number of databases discovered in the site.
   */
  databaseCount?: int32;

  /**
   * Gets or sets the number of run as accounts in the site.
   */
  runAsAccountCount?: int32;
}

/**
 * Class for Web app site properties.
 */
model WebAppSiteProperties {
  /**
   * Gets or sets the appliance details used by service to communicate
   *
   * to the appliance.
   */
  @identifiers(#[])
  siteAppliancePropertiesCollection?: SiteApplianceProperties[];

  /**
   * Gets or sets the discovery scenario.
   */
  discoveryScenario?: WebAppSitePropertiesDiscoveryScenario;

  /**
   * Gets the service endpoint.
   */
  @visibility(Lifecycle.Read)
  serviceEndpoint?: string;

  /**
   * provisioning state enum
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The type used for update operations of the WebAppSite.
 */
model WebAppSiteUpdate {
  /**
   * The updatable properties of the WebAppSite.
   */
  properties?: WebAppSiteUpdateProperties;
}

/**
 * The updatable properties of the WebAppSite.
 */
model WebAppSiteUpdateProperties {
  /**
   * Gets or sets the appliance details used by service to communicate
   *
   * to the appliance.
   */
  @identifiers(#[])
  siteAppliancePropertiesCollection?: SiteApplianceProperties[];

  /**
   * Gets or sets the discovery scenario.
   */
  discoveryScenario?: WebAppSitePropertiesDiscoveryScenario;
}

/**
 * Discovery site data source properties class.
 */
model DiscoverySiteDataSourceProperties {
  /**
   * Gets or sets the discovery site Id.
   */
  discoverySiteId?: string;

  /**
   * provisioning state enum
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * ExportWebAppsRequest body
 */
model ExportWebAppsRequest {
  /**
   * filter options.
   */
  filter?: string;
}

/**
 * Class for web extended machine properties.
 */
model WebAppExtendedMachineProperties {
  /**
   * Gets a value indicating whether application is deleted.
   */
  @visibility(Lifecycle.Read)
  isDeleted?: boolean;

  /**
   * Gets the timestamp marking creation of the entity.
   */
  @visibility(Lifecycle.Read)
  createdTimestamp?: string;

  /**
   * Gets the timestamp marking last update operation.
   */
  @visibility(Lifecycle.Read)
  updatedTimestamp?: string;

  /**
   * Gets the Error details.
   */
  @visibility(Lifecycle.Read)
  errors?: HealthErrorDetails[];

  /**
   * Gets the hydrated host name.
   */
  @visibility(Lifecycle.Read)
  hostName?: string;

  /**
   * Gets the Name of the extended machine.
   */
  @visibility(Lifecycle.Read)
  machineDisplayName?: string;

  /**
   * Gets the machine ARM id.
   */
  @visibility(Lifecycle.Read)
  machineId?: string;

  /**
   * Gets the run as account ID of the machine used for web app discovery.
   */
  @visibility(Lifecycle.Read)
  runAsAccountId?: string;

  /**
   * Gets the agent hydrated run as account.
   */
  @visibility(Lifecycle.Read)
  hydratedRunAsAccountId?: string;

  /**
   * provisioning state enum
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Class for web application properties.
 */
model IisWebApplicationProperties {
  /**
   * Gets the list of application units for the web site.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  applications?: IisApplicationUnit[];

  /**
   * Gets the list of application units for the web site.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  virtualApplications?: IisVirtualApplicationUnit[];

  /**
   * Gets the web server id.
   */
  @visibility(Lifecycle.Read)
  webServerId?: string;

  /**
   * Gets the web server name.
   */
  @visibility(Lifecycle.Read)
  webServerName?: string;

  /**
   * Gets the list of machine ARM Ids on which the SQL server is deployed.
   */
  @visibility(Lifecycle.Read)
  machineArmIds?: string[];

  /**
   * Gets the virtual path of the application.
   */
  @visibility(Lifecycle.Read)
  virtualPath?: string;

  /**
   * Gets the physical path of the application.
   */
  @visibility(Lifecycle.Read)
  physicalPath?: string;

  /**
   * Gets the front end bindings for the application.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  bindings?: FrontEndBinding[];

  /**
   * Gets the Error details.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  frameworks?: WebApplicationFramework[];

  /**
   * Gets the configuration.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  configurations?: WebApplicationConfigurationUnit[];

  /**
   * Gets the directories.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  directories?: WebApplicationDirectoryUnit[];

  /**
   * Gets the display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Gets or sets tags on the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Static folders.
   */
  @visibility(Lifecycle.Read)
  staticFolders?: string[];

  /**
   * Machine display name
   */
  @visibility(Lifecycle.Read)
  machineDisplayName?: string;

  /**
   * Gets a value indicating whether application is deleted.
   */
  @visibility(Lifecycle.Read)
  isDeleted?: boolean;

  /**
   * Gets the timestamp marking creation of the entity.
   */
  @visibility(Lifecycle.Read)
  createdTimestamp?: string;

  /**
   * Gets the timestamp marking last update operation.
   */
  @visibility(Lifecycle.Read)
  updatedTimestamp?: string;

  /**
   * Gets the server type.
   */
  @visibility(Lifecycle.Read)
  serverType?: string;

  /**
   * Gets the Error details.
   */
  @visibility(Lifecycle.Read)
  errors?: HealthErrorDetails[];

  /**
   * Gets the appliance names.
   */
  @visibility(Lifecycle.Read)
  applianceNames?: string[];

  /**
   * Gets a value indicating whether the WebApp has errors or not.
   */
  @visibility(Lifecycle.Read)
  hasErrors?: boolean;

  /**
   * provisioning state enum
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Second-level object for identification of application units in a web site
 * hosted on IIS.
 */
model IisApplicationUnit {
  /**
   * Gets or sets the path of the directory.
   */
  applicationPoolName?: string;

  /**
   * Gets or sets the managed pipeline mode.
   */
  managedPipelineMode?: string;

  /**
   * Gets or sets the runtime version.
   */
  runtimeVersion?: string;

  /**
   * Gets or sets a value indicating whether 32 bit applications are allowed to run
   * on 64 bit.
   */
  enable32BitApiOnWin64?: boolean;

  /**
   * Gets or sets the path of the directory.
   */
  path?: DirectoryPath;

  /**
   * Gets or sets the list of directories.
   */
  @identifiers(#[])
  directories?: DirectoryPath[];
}

/**
 * Second level entity for virtual directories.
 */
model DirectoryPath {
  /**
   * Gets or sets the virtual path for the directory.
   */
  virtual?: string;

  /**
   * Gets or sets the physical path of the directory on the web server.
   */
  physical?: string;
}

/**
 * Second-level object for identification of virtual applications in a web site
 * hosted on IIS.
 */
model IisVirtualApplicationUnit {
  /**
   * Gets a value indicating whether the application corresponds to a directory.
   */
  @visibility(Lifecycle.Read)
  isVirtualDirectory?: boolean;

  /**
   * Gets or sets the path of the directory.
   */
  path?: DirectoryPath;

  /**
   * Gets or sets the list of directories.
   */
  @identifiers(#[])
  directories?: DirectoryPath[];
}

/**
 * Frontend bindings for a web application.
 */
model FrontEndBinding {
  /**
   * Gets or sets the Binding protocol.
   */
  protocol?: string;

  /**
   * Gets or sets the Host name.
   */
  hostName?: string;

  /**
   * Gets or sets the Port number.
   */
  port?: string;

  /**
   * Gets or sets the IP Address.
   */
  ipAddress?: string;
}

/**
 * Framework specific data for a web application.
 */
model WebApplicationFramework {
  /**
   * Gets or sets Name of the framework.
   */
  name?: string;

  /**
   * Gets or sets Version of the framework.
   */
  version?: string;
}

/**
 * Web Application configuration unit.
 */
model WebApplicationConfigurationUnit {
  /**
   * Gets or sets the configuration name.
   */
  name?: string;

  /**
   * Gets or sets the configuration file path.
   */
  filePath?: string;

  /**
   * Gets or sets the configuration local file path.
   */
  localFilePath?: string;

  /**
   * Gets or sets the configuration target file path.
   */
  targetFilePath?: string;

  /**
   * Gets or sets the configuration section in the file.
   */
  section?: string;

  /**
   * Gets or sets the configuration type.
   */
  type?: string;

  /**
   * Gets or sets a value indicating whether the configuration is edited or not by
   * the user.
   */
  isDeploymentTimeEditable?: boolean;

  /**
   * Gets or sets the identifier for the configuration.
   */
  identifier?: string;
}

/**
 * Web Application directory unit.
 */
model WebApplicationDirectoryUnit {
  /**
   * Gets or sets the unique id corresponding to the application directory.
   */
  id?: string;

  /**
   * Gets or sets a value indicating whether the directory object is editable.
   *
   *       True when the directory is added as an optional directory, false when
   * discovery is done
   *             manually.
   */
  isEditable?: boolean;

  /**
   * Gets or sets the paths of the directory on the source machine.
   */
  sourcePaths?: string[];

  /**
   * Gets or sets the local scratch path at which the directories has been copied.
   */
  localScratchPath?: string;

  /**
   * Gets or sets the mount path of the application directory.
   */
  mountPath?: string;

  /**
   * Gets or sets the size of the directory on the source machine.
   */
  sourceSize?: string;
}

/**
 * The type used for update operations of the IisWebApplications.
 */
model IisWebApplicationsUpdate {
  /**
   * The updatable properties of the IisWebApplications.
   */
  properties?: IisWebApplicationsUpdateProperties;
}

/**
 * The updatable properties of the IisWebApplications.
 */
model IisWebApplicationsUpdateProperties {
  /**
   * Gets or sets tags on the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Class for web server properties.
 */
model IisWebServerProperties {
  /**
   * Gets the configuration location.
   */
  @visibility(Lifecycle.Read)
  configurationLocation?: string;

  /**
   * Gets the configuration location.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Gets the list of machines.
   */
  @visibility(Lifecycle.Read)
  machineIds?: string[];

  /**
   * Gets the list of web applications.
   */
  @visibility(Lifecycle.Read)
  webApplications?: string[];

  /**
   * Gets the display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Gets the server FQDN.
   */
  @visibility(Lifecycle.Read)
  serverFqdn?: string;

  /**
   * Gets the run as account id.
   */
  @visibility(Lifecycle.Read)
  runAsAccountId?: string;

  /**
   * Gets a value indicating whether application is deleted.
   */
  @visibility(Lifecycle.Read)
  isDeleted?: boolean;

  /**
   * Gets the timestamp marking creation of the entity.
   */
  @visibility(Lifecycle.Read)
  createdTimestamp?: string;

  /**
   * Gets the timestamp marking last update operation.
   */
  @visibility(Lifecycle.Read)
  updatedTimestamp?: string;

  /**
   * Gets the server type.
   */
  @visibility(Lifecycle.Read)
  serverType?: string;

  /**
   * Gets the Error details.
   */
  @visibility(Lifecycle.Read)
  errors?: HealthErrorDetails[];

  /**
   * Gets the appliance names.
   */
  @visibility(Lifecycle.Read)
  applianceNames?: string[];

  /**
   * Gets a value indicating whether the WebApp has errors or not.
   */
  @visibility(Lifecycle.Read)
  hasErrors?: boolean;

  /**
   * provisioning state enum
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Request body for Proxy site refresh action.
 */
model ProxySiteRefreshBody {
  /**
   * Gets or sets the appliance name of the agent in the site.
   */
  applianceName?: string;
}

/**
 * Web app site usage.
 */
model WebAppSiteUsage {
  /**
   * Gets or sets the number of web servers discovered in the site.
   */
  webServerCount?: int32;

  /**
   * Gets or sets the number of web applications discovered in the site.
   */
  webApplicationCount?: int32;

  /**
   * Gets or sets the number of run as accounts in the site.
   */
  runAsAccountCount?: int32;
}

/**
 * Class for web application properties.
 */
model TomcatWebApplicationProperties {
  /**
   * Boolean value having true if the application has database dependency.
   */
  @visibility(Lifecycle.Read)
  hasDatabaseDependency?: boolean;

  /**
   * Boolean value having true if the application has file dependency.
   */
  @visibility(Lifecycle.Read)
  isExternalLoggingConfigured?: boolean;

  /**
   * Gets the web server id.
   */
  @visibility(Lifecycle.Read)
  webServerId?: string;

  /**
   * Gets the web server name.
   */
  @visibility(Lifecycle.Read)
  webServerName?: string;

  /**
   * Gets the list of machine ARM Ids on which the web application is deployed.
   */
  @visibility(Lifecycle.Read)
  machineArmIds?: string[];

  /**
   * Gets the virtual path of the application.
   */
  @visibility(Lifecycle.Read)
  virtualPath?: string;

  /**
   * Gets the physical path of the application.
   */
  @visibility(Lifecycle.Read)
  physicalPath?: string;

  /**
   * Gets the front end bindings for the application.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  bindings?: FrontEndBinding[];

  /**
   * Gets the Error details.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  frameworks?: WebApplicationFramework[];

  /**
   * Gets the configuration.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  configurations?: WebApplicationConfigurationUnit[];

  /**
   * Gets the directories.
   */
  @visibility(Lifecycle.Read)
  directories?: WebApplicationDirectoryUnit[];

  /**
   * Gets the display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Gets tags that can be used with ODATA.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;

  /**
   * Static folders.
   */
  @visibility(Lifecycle.Read)
  staticFolders?: string[];

  /**
   * Machine display name
   */
  @visibility(Lifecycle.Read)
  machineDisplayName?: string;

  /**
   * Gets a value indicating whether application is deleted.
   */
  @visibility(Lifecycle.Read)
  isDeleted?: boolean;

  /**
   * Gets the timestamp marking creation of the entity.
   */
  @visibility(Lifecycle.Read)
  createdTimestamp?: string;

  /**
   * Gets the timestamp marking last update operation.
   */
  @visibility(Lifecycle.Read)
  updatedTimestamp?: string;

  /**
   * Gets the server type.
   */
  @visibility(Lifecycle.Read)
  serverType?: string;

  /**
   * Gets the Error details.
   */
  @visibility(Lifecycle.Read)
  errors?: HealthErrorDetails[];

  /**
   * Gets the appliance names.
   */
  @visibility(Lifecycle.Read)
  applianceNames?: string[];

  /**
   * Gets a value indicating whether the WebApp has errors or not.
   */
  @visibility(Lifecycle.Read)
  hasErrors?: boolean;

  /**
   * provisioning state enum
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Class for web server properties.
 */
model TomcatWebServerProperties {
  /**
   * Gets or sets the services defined in the server.
   */
  @identifiers(#[])
  services?: TomcatServiceUnit[];

  /**
   * Catalina Home
   */
  @visibility(Lifecycle.Read)
  catalinaHome?: string;

  /**
   * Version  of the JVM
   */
  @visibility(Lifecycle.Read)
  jvmVersion?: string;

  /**
   * session persistence mechanism
   */
  @visibility(Lifecycle.Read)
  sessionPersistenceMechanism?: string;

  /**
   * Gets a value indicating whether application is deleted.
   */
  isClusteringPresent?: boolean;

  /**
   * Gets a value indicating whether application is deleted.
   */
  @visibility(Lifecycle.Read)
  isMemoryRealmPresent?: boolean;

  /**
   * is session tracking present
   */
  @visibility(Lifecycle.Read)
  isSessionTrackingPresent?: boolean;

  /**
   * is access log valve present
   */
  @visibility(Lifecycle.Read)
  isAccessLogValvePresent?: boolean;

  /**
   * max memory usage in mb
   */
  @visibility(Lifecycle.Read)
  maxMemoryUsageInMb?: string;

  /**
   * Gets the configuration location.
   */
  @visibility(Lifecycle.Read)
  configurationLocation?: string;

  /**
   * Gets the configuration location.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Gets the list of machines.
   */
  @visibility(Lifecycle.Read)
  machineIds?: string[];

  /**
   * Gets the list of web applications.
   */
  @visibility(Lifecycle.Read)
  webApplications?: string[];

  /**
   * Gets the display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Gets the server FQDN.
   */
  @visibility(Lifecycle.Read)
  serverFqdn?: string;

  /**
   * Gets the run as account id.
   */
  @visibility(Lifecycle.Read)
  runAsAccountId?: string;

  /**
   * Gets or sets the Operating System Details installed on the machine.
   */
  operatingSystemDetails?: OperatingSystem;

  /**
   * Gets a value indicating whether application is deleted.
   */
  @visibility(Lifecycle.Read)
  isDeleted?: boolean;

  /**
   * Gets the timestamp marking creation of the entity.
   */
  @visibility(Lifecycle.Read)
  createdTimestamp?: string;

  /**
   * Gets the timestamp marking last update operation.
   */
  @visibility(Lifecycle.Read)
  updatedTimestamp?: string;

  /**
   * Gets the server type.
   */
  @visibility(Lifecycle.Read)
  serverType?: string;

  /**
   * Gets the Error details.
   */
  @visibility(Lifecycle.Read)
  errors?: HealthErrorDetails[];

  /**
   * Gets the appliance names.
   */
  @visibility(Lifecycle.Read)
  applianceNames?: string[];

  /**
   * Gets a value indicating whether the WebApp has errors or not.
   */
  @visibility(Lifecycle.Read)
  hasErrors?: boolean;

  /**
   * provisioning state enum
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Tomcat service data.
 */
model TomcatServiceUnit {
  /**
   * Gets or sets the name of the service.
   */
  name?: string;

  /**
   * Gets or sets the connectors defined for the service component.
   */
  @identifiers(#[])
  connectors?: ConnectorUnit[];

  /**
   * Gets or sets the engine defined for the service component.
   */
  engine?: TomcatEngineUnit;
}

/**
 * The connectors of the web server.
 */
model ConnectorUnit {
  /**
   * Gets or sets the bindings for the connector.
   */
  @identifiers(#[])
  bindings?: FrontEndBinding[];
}

/**
 * Tomcat engine data.
 */
model TomcatEngineUnit {
  /**
   * Gets or sets the name of the engine.
   */
  name?: string;

  /**
   * Gets or sets the hosts defined for the engine.
   */
  @identifiers(#[])
  hosts?: TomcatHostUnit[];
}

/**
 * Tomcat host data.
 */
model TomcatHostUnit {
  /**
   * Gets or sets the name of the host.
   */
  name?: string;

  /**
   * Gets or sets the app base path for the host.
   */
  appBasePath?: string;

  /**
   * Gets or sets the app base value configured for the host.
   */
  appBase?: string;
}

/**
 * Collection of web app properties.
 */
model WebAppPropertiesCollection {
  /**
   * Gets or sets the list of web app properties.
   */
  @identifiers(#[])
  webApps?: WebAppProperties[];
}

/**
 * Class representing web app properties web model.
 */
model WebAppProperties {
  /**
   * Gets or sets the arm id of the web app.
   */
  webAppArmId?: string;

  /**
   * Gets or sets Tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Web application REST Resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WebApplication extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * The resource-specific properties for this resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  properties?: WebApplicationProperties;
}

/**
 * Class for web application properties.
 */
model WebApplicationProperties {
  /**
   * Gets the web server id.
   */
  @visibility(Lifecycle.Read)
  webServerId?: string;

  /**
   * Gets the web server name.
   */
  @visibility(Lifecycle.Read)
  webServerName?: string;

  /**
   * Gets the list of machine ARM Ids on which the SQL server is deployed.
   */
  @visibility(Lifecycle.Read)
  machineArmIds?: string[];

  /**
   * Gets the virtual path of the application.
   */
  @visibility(Lifecycle.Read)
  virtualPath?: string;

  /**
   * Gets the physical path of the application.
   */
  @visibility(Lifecycle.Read)
  physicalPath?: string;

  /**
   * Gets the front end bindings for the application.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  bindings?: FrontEndBinding[];

  /**
   * Gets the Error details.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  frameworks?: WebApplicationFramework[];

  /**
   * Gets the configuration.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  configurations?: WebApplicationConfigurationUnit[];

  /**
   * Gets the directories.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  directories?: WebApplicationDirectoryUnit[];

  /**
   * Gets the display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Gets tags that can be used with ODATA.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;

  /**
   * Static folders.
   */
  @visibility(Lifecycle.Read)
  staticFolders?: string[];

  /**
   * Machine display name
   */
  @visibility(Lifecycle.Read)
  machineDisplayName?: string;

  /**
   * Gets a value indicating whether application is deleted.
   */
  @visibility(Lifecycle.Read)
  isDeleted?: boolean;

  /**
   * Gets the timestamp marking creation of the entity.
   */
  @visibility(Lifecycle.Read)
  createdTimestamp?: string;

  /**
   * Gets the timestamp marking last update operation.
   */
  @visibility(Lifecycle.Read)
  updatedTimestamp?: string;

  /**
   * Gets the server type.
   */
  @visibility(Lifecycle.Read)
  serverType?: string;

  /**
   * Gets the Error details.
   */
  @visibility(Lifecycle.Read)
  errors?: HealthErrorDetails[];

  /**
   * Gets the appliance names.
   */
  @visibility(Lifecycle.Read)
  applianceNames?: string[];

  /**
   * Gets a value indicating whether the WebApp has errors or not.
   */
  @visibility(Lifecycle.Read)
  hasErrors?: boolean;

  /**
   * provisioning state enum
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Web application REST Resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WebServer extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * The resource-specific properties for this resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  properties?: WebServerProperties;
}

/**
 * Class for web server properties.
 */
model WebServerProperties {
  /**
   * Gets the configuration location.
   */
  @visibility(Lifecycle.Read)
  configurationLocation?: string;

  /**
   * Gets the configuration location.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Gets the list of machines.
   */
  @visibility(Lifecycle.Read)
  machineIds?: string[];

  /**
   * Gets the list of web applications.
   */
  @visibility(Lifecycle.Read)
  webApplications?: string[];

  /**
   * Gets the display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Gets the server FQDN.
   */
  @visibility(Lifecycle.Read)
  serverFqdn?: string;

  /**
   * Gets the run as account id.
   */
  @visibility(Lifecycle.Read)
  runAsAccountId?: string;

  /**
   * Gets a value indicating whether application is deleted.
   */
  @visibility(Lifecycle.Read)
  isDeleted?: boolean;

  /**
   * Gets the timestamp marking creation of the entity.
   */
  @visibility(Lifecycle.Read)
  createdTimestamp?: string;

  /**
   * Gets the timestamp marking last update operation.
   */
  @visibility(Lifecycle.Read)
  updatedTimestamp?: string;

  /**
   * Gets the server type.
   */
  @visibility(Lifecycle.Read)
  serverType?: string;

  /**
   * Gets the Error details.
   */
  @visibility(Lifecycle.Read)
  errors?: HealthErrorDetails[];

  /**
   * Gets the appliance names.
   */
  @visibility(Lifecycle.Read)
  applianceNames?: string[];

  /**
   * Gets a value indicating whether the WebApp has errors or not.
   */
  @visibility(Lifecycle.Read)
  hasErrors?: boolean;

  /**
   * provisioning state enum
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The type used for update operations of the ServerSiteResource.
 */
model ServerSiteResourceUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The updatable properties of the ServerSiteResource.
   */
  properties?: ServerSiteResourceUpdateProperties;
}

/**
 * The updatable properties of the ServerSiteResource.
 */
model ServerSiteResourceUpdateProperties {
  /**
   * Gets or sets the service principal identity details used by agent for
   * communication
   *             to the service.
   */
  servicePrincipalIdentityDetails?: SiteSpnProperties;

  /**
   * Gets or sets the on-premises agent details.
   */
  agentDetails?: SiteAgentProperties;

  /**
   * Gets or sets the Appliance Name.
   */
  applianceName?: string;

  /**
   * Gets or sets the ARM ID of migration hub solution for SDS.
   */
  discoverySolutionId?: string;

  /**
   * Gets or sets the appliance details used by service to communicate to the appliance.
   */
  @identifiers(#[])
  siteAppliancePropertiesCollection?: SiteApplianceProperties[];

  /**
   * Gets or sets the Arc scope properties for the server site.
   */
  arcScope?: ArcScopePropertiesUpdate;
}

/**
 * The properties of ServerSiteUsageResponse.
 */
model ServerSiteUsageResponse {
  /**
   * Gets or sets the number of run as accounts in the site.
   */
  runAsAccounts: int32;

  /**
   * Gets or sets the number of servers part of the site.
   */
  serverCount: int32;
}

/**
 * Server REST resource.
 */
model ServerProperties {
  /**
   * Gets the Display name of the machine.
   *             For server entity hydrated
   * FQDN is set as display name
   *             as the server id and server name are
   * same.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Gets or sets the FQDN/IPAddress of the server.
   */
  fqdn?: string;

  /**
   * Gets or sets the network adapters of the server.
   */
  @identifiers(#[])
  networkAdapters?: ServerNetworkAdapter[];

  /**
   * Gets or sets the FQDN of machine which can be changed.
   */
  hydratedFqdn?: string;

  /**
   * Gets or sets the disk details of server.
   */
  disks?: ServerDisk[];

  /**
   * Gets or sets the validation required for the machine.
   */
  validationRequired?: string;

  /**
   * Processor Info of the Server machine.
   */
  @visibility(Lifecycle.Read)
  processorInfo?: ProcessorInfo;

  /**
   * Gets or sets the firmware.
   */
  firmware?: string;

  /**
   * Gets or sets a value indicating whether Secure boot is enabled for the VM.
   */
  @visibility(Lifecycle.Read)
  secureBootEnabled?: boolean;

  /**
   * Operating System Details extracted from the guest
   *             bu executing
   * script inside the guest VM.
   */
  @visibility(Lifecycle.Read)
  guestOsDetails?: GuestOsDetails;

  /**
   * Number of applications installed in the guest VM.
   */
  @visibility(Lifecycle.Read)
  numberOfApplications?: int32;

  /**
   * Number of software installed in the guest VM.
   */
  @visibility(Lifecycle.Read)
  numberOfSoftware?: int32;

  /**
   * Number of security risks identified on the guest VM.
   */
  @visibility(Lifecycle.Read)
  numberOfSecurityRisks?: int32;

  /**
   * The last time at which the Guest Details was discovered
   *             or the
   * error while discovering guest details based discovery
   *             of the
   * machine.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  guestDetailsDiscoveryTimestamp?: utcDateTime;

  /**
   * Whether Refresh Fabric Layout Guest Details has been completed once.
   *
   *   Portal will show discovery in progress, if this value is true.
   */
  @visibility(Lifecycle.Read)
  isGuestDetailsDiscoveryInProgress?: boolean;

  /**
   * Gets or sets if dependency mapping feature is enabled or not
   *             for
   * the VM.
   */
  @visibility(Lifecycle.Read)
  dependencyMapping?: string;

  /**
   * Gets or sets when dependency mapping collection is last started.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dependencyMappingStartTime?: utcDateTime;

  /**
   * Gets or sets when dependency mapping collection was last disabled.
   */
  @visibility(Lifecycle.Read)
  dependencyMappingEndTime?: string;

  /**
   * Gets or sets the run as account ID of the machine.
   */
  runAsAccountId?: string;

  /**
   * Gets the appliance names.
   */
  @visibility(Lifecycle.Read)
  applianceNames?: string[];

  /**
   * Errors for machine.
   */
  @visibility(Lifecycle.Read)
  errors?: HealthErrorDetails[];

  /**
   * Gets the data related to application discovery.
   */
  @visibility(Lifecycle.Read)
  applicationDiscovery?: ApplicationDiscovery;

  /**
   * Gets the data related to dependency map discovery.
   */
  @visibility(Lifecycle.Read)
  dependencyMapDiscovery?: DependencyMapDiscovery;

  /**
   * Gets the data related to static discovery.
   */
  @visibility(Lifecycle.Read)
  staticDiscovery?: StaticDiscovery;

  /**
   * Gets the data related to SQL discovery.
   */
  @visibility(Lifecycle.Read)
  sqlDiscovery?: SqlDiscovery;

  /**
   * Gets the data related to Web application discovery.
   */
  @visibility(Lifecycle.Read)
  webAppDiscovery?: WebAppDiscovery;

  /**
   * Gets the data related to Oracle discovery.
   */
  @visibility(Lifecycle.Read)
  oracleDiscovery?: OracleDiscovery;

  /**
   * Gets the data related to SpringBoot discovery.
   */
  @visibility(Lifecycle.Read)
  springBootDiscovery?: SpringBootDiscovery;

  /**
   * Gets the data related to iis discovery.
   */
  @visibility(Lifecycle.Read)
  iisDiscovery?: WebAppDiscovery;

  /**
   * Gets the data related to tomcat discovery.
   */
  @visibility(Lifecycle.Read)
  tomcatDiscovery?: WebAppDiscovery;

  /**
   * Apps And Roles of the Server.
   */
  @visibility(Lifecycle.Read)
  appsAndRoles?: AppsAndRoles;

  /**
   * product support status.
   */
  productSupportStatus?: ProductSupportStatus;

  /**
   * Gets or sets the Number of Processor Cores
   *             allocated for the
   * machine.
   */
  numberOfProcessorCore?: int32;

  /**
   * Gets or sets the allocated Memory in MB.
   */
  allocatedMemoryInMb?: float32;

  /**
   * Gets or sets the Operating System Details installed on the machine.
   */
  operatingSystemDetails?: OperatingSystem;

  /**
   * Gets or sets the Machine BIOS serial number.
   */
  biosSerialNumber?: string;

  /**
   * Gets or sets the BIOS GUID.
   */
  biosGuid?: string;

  /**
   * Value indicating whether VM is deleted.
   */
  @visibility(Lifecycle.Read)
  isDeleted?: boolean;

  /**
   * Gets the marking machine creation.
   */
  @visibility(Lifecycle.Read)
  createdTimestamp?: string;

  /**
   * Gets or sets tags on the Server machine.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<unknown>;

  /**
   * Gets the timestamp marking last updated on the machine.
   */
  @visibility(Lifecycle.Read)
  updatedTimestamp?: string;

  /**
   * Provisioning state of the server resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: ProvisioningState;

  /**
   * Gets the data related to Azure arc discovery.
   */
  @visibility(Lifecycle.Read)
  arcDiscovery?: ArcDiscovery;

  /**
   * Gets the discovery state of the server.
   */
  @visibility(Lifecycle.Read)
  discoverySource?: DiscoverySource;

  /**
   * Gets or sets the hypervisor type of the server.
   */
  @visibility(Lifecycle.Read)
  hypervisor?: string;
}

/**
 * Second level object represented in responses as part of Machine REST resource.
 */
model ServerNetworkAdapter {
  /**
   * Gets or sets the NIC Id.
   */
  nicId?: string;

  /**
   * Gets or sets Mac address of the NIC.
   */
  macAddress?: string;

  /**
   * Gets IP addresses for the machine.
   */
  @visibility(Lifecycle.Read)
  ipAddressList?: string[];

  /**
   * Gets or sets Network Name.
   */
  networkName?: string;

  /**
   * Gets or sets Type of the IP address.
   */
  ipAddressType?: string;
}

/**
 * Server disk details.
 */
model ServerDisk {
  /**
   * Gets or sets Id of the disk.
   */
  id?: string;

  /**
   * Gets or sets generated Id of the disk.
   */
  generatedId?: string;

  /**
   * Gets or sets Bytes allocated for the disk.
   */
  maxSizeInBytes?: int32;

  /**
   * Gets or sets Name of the disk.
   */
  name?: string;

  /**
   * Gets or sets Type of the disk.
   */
  diskType?: string;

  /**
   * Gets or sets LUN of the disk.
   */
  lun?: int32;

  /**
   * Gets or sets guid for GPT disks or Signature for MBR disks.
   */
  diskId?: string;

  /**
   * Gets or sets a value indicating whether disk is os disk.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isOSDisk?: string;

  /**
   * Gets or sets Path of the disk.
   */
  path?: string;
}

/**
 * Processor Information.
 */
model ProcessorInfo {
  /**
   * Gets or sets the name\model of a processor.
   */
  name?: string;

  /**
   * Gets or sets the number of sockets.
   */
  numberOfSockets?: int32;

  /**
   * Gets or sets the total number of cores in a socket.
   */
  numberOfCoresPerSocket?: int32;
}

/**
 * The type used for update operations of the Server.
 */
model ServerUpdate {
  /**
   * The updatable properties of the Server.
   */
  properties?: ServerUpdateProperties;
}

/**
 * The updatable properties of the Server.
 */
model ServerUpdateProperties {
  /**
   * Gets or sets the FQDN/IPAddress of the server.
   */
  fqdn?: string;

  /**
   * Gets or sets the network adapters of the server.
   */
  @identifiers(#[])
  networkAdapters?: ServerNetworkAdapter[];

  /**
   * Gets or sets the FQDN of machine which can be changed.
   */
  hydratedFqdn?: string;

  /**
   * Gets or sets the disk details of server.
   */
  disks?: ServerDisk[];

  /**
   * Gets or sets the validation required for the machine.
   */
  validationRequired?: string;

  /**
   * Gets or sets the firmware.
   */
  firmware?: string;

  /**
   * Gets or sets the run as account ID of the machine.
   */
  runAsAccountId?: string;

  /**
   * product support status.
   */
  productSupportStatus?: ProductSupportStatus;

  /**
   * Gets or sets the Number of Processor Cores
   *             allocated for the
   * machine.
   */
  numberOfProcessorCore?: int32;

  /**
   * Gets or sets the allocated Memory in MB.
   */
  allocatedMemoryInMb?: float32;

  /**
   * Gets or sets the Operating System Details installed on the machine.
   */
  operatingSystemDetails?: OperatingSystem;

  /**
   * Gets or sets the Machine BIOS serial number.
   */
  biosSerialNumber?: string;

  /**
   * Gets or sets the BIOS GUID.
   */
  biosGuid?: string;

  /**
   * Gets or sets tags on the Server machine.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<unknown>;

  /**
   * Provisioning state of the server resource.
   */
  provisioningState?: ProvisioningState;
}

/**
 * Server site usage.
 */
model ServerSiteUsage {
  /**
   * Gets or sets the number of run as accounts in the site.
   */
  runAsAccountCount?: int32;

  /**
   * Gets or sets the number of servers part of the site.
   */
  serverCount?: int32;
}

/**
 * The type used for update operations of the VmwareSite.
 */
model VmwareSiteUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The updatable properties of the VmwareSite.
   */
  properties?: VmwareSiteUpdateProperties;
}

/**
 * The updatable properties of the VmwareSite.
 */
model VmwareSiteUpdateProperties {
  /**
   * Gets or sets the service principal identity details used by agent for
   * communication
   *             to the service.
   */
  servicePrincipalIdentityDetails?: SiteSpnProperties;

  /**
   * Gets or sets the on-premises agent details.
   */
  agentDetails?: SiteAgentProperties;

  /**
   * Gets or sets the Appliance Name.
   */
  applianceName?: string;

  /**
   * Gets or sets the ARM ID of migration hub solution for SDS.
   */
  discoverySolutionId?: string;

  /**
   * Gets or sets the appliance details used by service to communicate to the appliance.
   */
  @identifiers(#[])
  siteAppliancePropertiesCollection?: SiteApplianceProperties[];

  /**
   * The status of the last operation.
   */
  provisioningState?: ProvisioningState;
}

/**
 * VMware site usage.
 */
model VmwareSiteUsage {
  /**
   * Gets or sets the number of machines discovered in the site.
   */
  machineCount?: int32;

  /**
   * Gets or sets the number of run as accounts in the site.
   */
  runAsAccountCount?: int32;

  /**
   * Gets or sets the number of vCenters part of the site.
   */
  vCenterCount?: int32;
}

/**
 * ExportMachinesRequest body
 */
model ExportMachinesRequest {
  /**
   * filter options.
   */
  filter?: string;
}

/**
 * Class for host properties.
 */
model VmwareHostProperties {
  /**
   * Gets the timestamp marking VMware host creation.
   */
  @visibility(Lifecycle.Read)
  createdTimestamp?: string;

  /**
   * Gets the timestamp marking last updated on the VMware host.
   */
  @visibility(Lifecycle.Read)
  updatedTimestamp?: string;

  /**
   * Gets the data stores.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  datastores?: VmwareDatastore[];

  /**
   * Gets the V-center ID.
   */
  @visibility(Lifecycle.Read)
  vcenterId?: string;

  /**
   * Gets the instance UUID of the vmware host.
   */
  @visibility(Lifecycle.Read)
  uuid?: string;

  /**
   * Gets the appliance names.
   */
  @visibility(Lifecycle.Read)
  applianceNames?: string[];

  /**
   * provisioning state enum
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Second level object returned as part of VMware host REST resource.
 */
model VmwareDatastore {
  /**
   * Data store UUID.
   */
  @visibility(Lifecycle.Read)
  uuid?: string;

  /**
   * Capacity of the data store.
   */
  @visibility(Lifecycle.Read)
  capacityInGb?: float32;

  /**
   * Free space of the data store.
   */
  @visibility(Lifecycle.Read)
  freeSpaceInGb?: float32;

  /**
   * Type of the data store.
   */
  @visibility(Lifecycle.Read)
  type?: VMwareDatastoreType;

  /**
   * Symbolic name of the data store.
   */
  @visibility(Lifecycle.Read)
  symbolicName?: string;
}

/**
 * Class for machine properties.
 */
model VmwareMachineProperties {
  /**
   * VCenter FQDN/IPAddress.
   */
  @visibility(Lifecycle.Read)
  vCenterFqdn?: string;

  /**
   * VCenter ARM ID.
   */
  @visibility(Lifecycle.Read)
  vCenterId?: string;

  /**
   * On-premise Instance UUID of the machine.
   */
  @visibility(Lifecycle.Read)
  instanceUuid?: string;

  /**
   * Scope of the data center.
   */
  @visibility(Lifecycle.Read)
  dataCenterScope?: string;

  /**
   * User description of the machine.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Disks attached to the machine.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  disks?: VmwareDisk[];

  /**
   * Indicates whether the host is in maintenance mode.
   */
  @visibility(Lifecycle.Read)
  hostInMaintenanceMode?: boolean;

  /**
   * The host name.
   */
  @visibility(Lifecycle.Read)
  hostName?: string;

  /**
   * The host power state.
   */
  @visibility(Lifecycle.Read)
  hostPowerState?: string;

  /**
   * The host version.
   */
  @visibility(Lifecycle.Read)
  hostVersion?: string;

  /**
   * Network adapters attached to the machine.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  networkAdapters?: VmwareNetworkAdapter[];

  /**
   * VMware tools status.
   */
  @visibility(Lifecycle.Read)
  vMwareToolsStatus?: string;

  /**
   * VMware tools version.
   */
  @visibility(Lifecycle.Read)
  vMwareToolsVersion?: string;

  /**
   * Value indicating whether change tracking is supported.
   */
  @visibility(Lifecycle.Read)
  changeTrackingSupported?: boolean;

  /**
   * Value indicating whether change tracking is enabled.
   */
  @visibility(Lifecycle.Read)
  changeTrackingEnabled?: boolean;

  /**
   * Gets or sets a value indicating whether Secure boot is enabled for the VM.
   */
  @visibility(Lifecycle.Read)
  secureBootEnabled?: boolean;

  /**
   * Maximum number of snapshots for the VM.            Default value is -1.
   */
  @visibility(Lifecycle.Read)
  maxSnapshots?: int32;

  /**
   * Gets or sets whether Disk Enabled UUID is set or not.
   */
  @visibility(Lifecycle.Read)
  diskEnabledUuid?: string;

  /**
   * Number of snapshots for the VM.             Default value is -1.
   */
  @visibility(Lifecycle.Read)
  numberOfSnapshots?: int32;

  /**
   * Gets or sets the machine alt guest name.
   */
  @visibility(Lifecycle.Read)
  altGuestName?: string;

  /**
   * Gets the Machine power status.
   */
  @visibility(Lifecycle.Read)
  powerStatus?: string;

  /**
   * Gets the VM FQDN.
   */
  @visibility(Lifecycle.Read)
  vmFqdn?: string;

  /**
   * Gets the Root location of the VM configuration file.
   */
  @visibility(Lifecycle.Read)
  vmConfigurationFileLocation?: string;

  /**
   * Gets or sets the firmware.
   */
  firmware?: string;

  /**
   * Operating System Details extracted from the guest
   *             bu executing
   * script inside the guest VM.
   */
  @visibility(Lifecycle.Read)
  guestOsDetails?: GuestOsDetails;

  /**
   * Number of applications installed in the guest VM.
   */
  @visibility(Lifecycle.Read)
  numberOfApplications?: int32;

  /**
   * Number of software installed in the guest VM.
   */
  @visibility(Lifecycle.Read)
  numberOfSoftware?: int32;

  /**
   * Number of security risks identified on the guest VM.
   */
  @visibility(Lifecycle.Read)
  numberOfSecurityRisks?: int32;

  /**
   * The last time at which the Guest Details was discovered
   *             or the
   * error while discovering guest details based discovery
   *             of the
   * machine.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  guestDetailsDiscoveryTimestamp?: utcDateTime;

  /**
   * Whether Refresh Fabric Layout Guest Details has been completed once.
   *
   *   Portal will show discovery in progress, if this value is true.
   */
  @visibility(Lifecycle.Read)
  isGuestDetailsDiscoveryInProgress?: boolean;

  /**
   * Gets or sets if dependency mapping feature is enabled or not
   *             for
   * the VM.
   */
  @visibility(Lifecycle.Read)
  dependencyMapping?: string;

  /**
   * Gets or sets when dependency mapping collection is last started.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dependencyMappingStartTime?: utcDateTime;

  /**
   * Gets or sets when dependency mapping collection was last disabled.
   */
  @visibility(Lifecycle.Read)
  dependencyMappingEndTime?: string;

  /**
   * Gets or sets the run as account ID of the machine.
   */
  runAsAccountId?: string;

  /**
   * Gets the appliance names.
   */
  @visibility(Lifecycle.Read)
  applianceNames?: string[];

  /**
   * Errors for machine.
   */
  @visibility(Lifecycle.Read)
  errors?: HealthErrorDetails[];

  /**
   * Gets the data related to application discovery.
   */
  @visibility(Lifecycle.Read)
  applicationDiscovery?: ApplicationDiscovery;

  /**
   * Gets the data related to dependency map discovery.
   */
  @visibility(Lifecycle.Read)
  dependencyMapDiscovery?: DependencyMapDiscovery;

  /**
   * Gets the data related to static discovery.
   */
  @visibility(Lifecycle.Read)
  staticDiscovery?: StaticDiscovery;

  /**
   * Gets the data related to SQL discovery.
   */
  @visibility(Lifecycle.Read)
  sqlDiscovery?: SqlDiscovery;

  /**
   * Gets the data related to Web application discovery.
   */
  @visibility(Lifecycle.Read)
  webAppDiscovery?: WebAppDiscovery;

  /**
   * Gets the data related to Oracle discovery.
   */
  @visibility(Lifecycle.Read)
  oracleDiscovery?: OracleDiscovery;

  /**
   * Gets the data related to SpringBoot discovery.
   */
  @visibility(Lifecycle.Read)
  springBootDiscovery?: SpringBootDiscovery;

  /**
   * Gets the data related to iis discovery.
   */
  @visibility(Lifecycle.Read)
  iisDiscovery?: WebAppDiscovery;

  /**
   * Gets the data related to tomcat discovery.
   */
  @visibility(Lifecycle.Read)
  tomcatDiscovery?: WebAppDiscovery;

  /**
   * Apps And Roles of the Server.
   */
  @visibility(Lifecycle.Read)
  appsAndRoles?: AppsAndRoles;

  /**
   * product support status.
   */
  productSupportStatus?: ProductSupportStatus;

  /**
   * Gets or sets the Number of Processor Cores
   *             allocated for the
   * machine.
   */
  numberOfProcessorCore?: int32;

  /**
   * Gets or sets the allocated Memory in MB.
   */
  allocatedMemoryInMb?: float64;

  /**
   * Gets or sets the Operating System Details installed on the machine.
   */
  operatingSystemDetails?: OperatingSystem;

  /**
   * Gets or sets the Machine BIOS serial number.
   */
  biosSerialNumber?: string;

  /**
   * Gets or sets the BIOS GUID.
   */
  biosGuid?: string;

  /**
   * Gets the Display name of the machine.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Value indicating whether VM is deleted.
   */
  @visibility(Lifecycle.Read)
  isDeleted?: boolean;

  /**
   * Gets the marking machine creation.
   */
  @visibility(Lifecycle.Read)
  createdTimestamp?: string;

  /**
   * Gets or sets tags on the VMware machine.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Gets the timestamp marking last updated on the machine.
   */
  @visibility(Lifecycle.Read)
  updatedTimestamp?: string;

  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Gets the data related to Azure arc discovery.
   */
  @visibility(Lifecycle.Read)
  arcDiscovery?: ArcDiscovery;
}

/**
 * Second level object returned as part of Machine REST resource.
 */
model VmwareDisk {
  /**
   * Disk UUID.
   */
  @visibility(Lifecycle.Read)
  uuid?: string;

  /**
   * Label of the disk.
   */
  @visibility(Lifecycle.Read)
  label?: string;

  /**
   * The provisioning policy of the disk.
   *             It is Thin or Thick or
   * Unknown for the VMWare VMDK.
   */
  @visibility(Lifecycle.Read)
  diskProvisioningPolicy?: string;

  /**
   * The scrubbing policy of disks which can be
   *             eagerly zeroed or
   * lazily zeroed.
   */
  @visibility(Lifecycle.Read)
  diskScrubbingPolicy?: string;

  /**
   * Disk mode property used for identifying independent disks.
   */
  @visibility(Lifecycle.Read)
  diskMode?: string;

  /**
   * Gets or sets a value indicating the type of the disk controller type.
   */
  @visibility(Lifecycle.Read)
  controllerType?: string;

  /**
   * Gets or sets Bytes allocated for the disk.
   */
  maxSizeInBytes?: int64;

  /**
   * Gets or sets Name of the disk.
   */
  name?: string;

  /**
   * Gets or sets Type of the disk.
   */
  diskType?: string;

  /**
   * Gets or sets LUN of the disk.
   */
  lun?: int32;

  /**
   * Gets or sets a value indicating whether disk is os disk.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isOSDisk?: string;

  /**
   * Gets or sets Path of the disk.
   */
  path?: string;
}

/**
 * Second level object represented in responses as part of Machine REST resource.
 */
model VmwareNetworkAdapter {
  /**
   * Label of the NIC.
   */
  @visibility(Lifecycle.Read)
  label?: string;

  /**
   * Gets or sets the adapter type.
   */
  @visibility(Lifecycle.Read)
  adapterType?: string;

  /**
   * Gets or sets the NIC Id.
   */
  nicId?: string;

  /**
   * Gets or sets Mac address of the NIC.
   */
  macAddress?: string;

  /**
   * Gets IP addresses for the machine.
   */
  @visibility(Lifecycle.Read)
  ipAddressList?: string[];

  /**
   * Gets or sets Network Name.
   */
  networkName?: string;

  /**
   * Gets or sets Type of the IP address.
   */
  ipAddressType?: string;
}

/**
 * The type used for update operations of the MachineResource.
 */
model MachineResourceUpdate {
  /**
   * The updatable properties of the MachineResource.
   */
  properties?: MachineResourceUpdateProperties;
}

/**
 * The updatable properties of the MachineResource.
 */
model MachineResourceUpdateProperties {
  /**
   * Gets or sets the firmware.
   */
  firmware?: string;

  /**
   * Gets or sets the run as account ID of the machine.
   */
  runAsAccountId?: string;

  /**
   * product support status.
   */
  productSupportStatus?: ProductSupportStatus;

  /**
   * Gets or sets the Number of Processor Cores
   *             allocated for the
   * machine.
   */
  numberOfProcessorCore?: int32;

  /**
   * Gets or sets the allocated Memory in MB.
   */
  allocatedMemoryInMb?: float64;

  /**
   * Gets or sets the Operating System Details installed on the machine.
   */
  operatingSystemDetails?: OperatingSystem;

  /**
   * Gets or sets the Machine BIOS serial number.
   */
  biosSerialNumber?: string;

  /**
   * Gets or sets the BIOS GUID.
   */
  biosGuid?: string;

  /**
   * Gets or sets tags on the VMware machine.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Defines class that represents input to update RunAsAccount on machine
 *
 *       for cosmos entity operation.
 */
model UpdateMachineRunAsAccount {
  /**
   * Gets or sets the machine collection.
   */
  @identifiers(#[])
  machines?: RunAsAccountMachineInput[];
}

/**
 * Machine class.
 */
model RunAsAccountMachineInput {
  /**
   * Gets or sets the ARM id of the machine.
   */
  machineId?: string;

  /**
   * run as AccountId
   */
  runAsAccountId?: string;
}

/**
 * Defines class that represents input to update Tags on machine
 *
 *       for cosmos entity operation.
 */
model UpdateMachineTags {
  /**
   * Gets or sets the machine collection.
   */
  @identifiers(#[])
  machines?: TagsMachineInput[];
}

/**
 * Machine class.
 */
model TagsMachineInput {
  /**
   * Gets or sets the ARM id of the machine.
   */
  machineId?: string;

  /**
   * run as AccountId
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * The properties of VMwareSiteResource
 */
model VcenterProperties {
  /**
   * Gets or sets the run as account ID of the vCenter.
   */
  runAsAccountId?: string;

  /**
   * Gets the errors.
   */
  @visibility(Lifecycle.Read)
  errors?: HealthErrorDetails[];

  /**
   * Gets the timestamp marking vCenter creation.
   */
  @visibility(Lifecycle.Read)
  createdTimestamp?: string;

  /**
   * Gets the timestamp marking last updated on the vCenter.
   */
  @visibility(Lifecycle.Read)
  updatedTimestamp?: string;

  /**
   * Gets or sets the FQDN/IPAddress of the vCenter.
   */
  fqdn?: string;

  /**
   * Gets or sets the port of the vCenter.
   */
  port?: string;

  /**
   * Gets the version of the vCenter.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Gets the performance statistics enabled on the vCenter.
   */
  @visibility(Lifecycle.Read)
  perfStatisticsLevel?: string;

  /**
   * Gets the instance UUID of the vCenter.
   */
  @visibility(Lifecycle.Read)
  instanceUuid?: string;

  /**
   * Gets or sets the friendly name of the vCenter.
   */
  friendlyName?: string;

  /**
   * The status of the last operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: ProvisioningState;
}

/**
 * Delete import machines job collection.
 */
model DeleteImportMachinesJobCollection
  is Azure.Core.Page<DeleteImportMachinesJob>;

/**
 * A cluster resource belonging to a site resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HypervOperationsStatusResource
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * The resource-specific properties for this resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  properties?: HypervClusterProperties;
}

/**
 * Run as account REST Resource.
 */
model V20180501PreviewVmwareRunAsAccount {
  /**
   * Relative URL to get this run as account.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Gets the Name of the Run as account.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Handled by resource provider. Type =
   * Microsoft.OffAzure/VMWareSites/RunAsAccounts.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Gets nested properties.
   */
  @visibility(Lifecycle.Read)
  properties?: RunAsAccountProperties;
}

/**
 * Collection of VMware run as accounts.
 */
model V20180501PreviewVmwareRunAsAccountVmwareRunAsAccountCollection
  is Azure.Core.Page<V20180501PreviewVmwareRunAsAccount>;
