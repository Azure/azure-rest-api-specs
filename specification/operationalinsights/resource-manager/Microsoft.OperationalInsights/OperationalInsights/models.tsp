import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.Foundations;

namespace Microsoft.OperationalInsights;

/**
 * The name of the Service Tier.
 */
union SkuNameEnum {
  string,

  /**
   * Free
   */
  Free: "Free",

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * Premium
   */
  Premium: "Premium",

  /**
   * PerNode
   */
  PerNode: "PerNode",

  /**
   * PerGB2018
   */
  PerGB2018: "PerGB2018",

  /**
   * Standalone
   */
  Standalone: "Standalone",

  /**
   * CapacityReservation
   */
  CapacityReservation: "CapacityReservation",
}

/**
 * The SKU (tier) of a cluster.
 */
union ClusterSkuNameEnum {
  string,

  /**
   * CapacityReservation
   */
  CapacityReservation: "CapacityReservation",
}

/**
 * The provisioning state of the cluster.
 */
union ClusterEntityStatus {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

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

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * ProvisioningAccount
   */
  ProvisioningAccount: "ProvisioningAccount",

  /**
   * Updating
   */
  Updating: "Updating",
}

/**
 * Configures whether billing will be only on the cluster or each workspace will be billed by its proportional use. This does not change the overall billing, only how it will be distributed. Default value is 'Cluster'
 */
union BillingType {
  string,

  /**
   * Cluster
   */
  Cluster: "Cluster",

  /**
   * Workspaces
   */
  Workspaces: "Workspaces",
}

/**
 * The provisioning state of the cluster replication.
 */
union ClusterReplicationState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * EnableRequested
   */
  EnableRequested: "EnableRequested",

  /**
   * Enabling
   */
  Enabling: "Enabling",

  /**
   * DisableRequested
   */
  DisableRequested: "DisableRequested",

  /**
   * Disabling
   */
  Disabling: "Disabling",

  /**
   * RollbackRequested
   */
  RollbackRequested: "RollbackRequested",

  /**
   * RollingBack
   */
  RollingBack: "RollingBack",

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
 * The type of the destination resource
 */
union Type {
  string,

  /**
   * StorageAccount
   */
  StorageAccount: "StorageAccount",

  /**
   * EventHub
   */
  EventHub: "EventHub",
}

/**
 * The kind of the DataSource.
 */
union DataSourceKind {
  string,

  /**
   * WindowsEvent
   */
  WindowsEvent: "WindowsEvent",

  /**
   * WindowsPerformanceCounter
   */
  WindowsPerformanceCounter: "WindowsPerformanceCounter",

  /**
   * IISLogs
   */
  IISLogs: "IISLogs",

  /**
   * LinuxSyslog
   */
  LinuxSyslog: "LinuxSyslog",

  /**
   * LinuxSyslogCollection
   */
  LinuxSyslogCollection: "LinuxSyslogCollection",

  /**
   * LinuxPerformanceObject
   */
  LinuxPerformanceObject: "LinuxPerformanceObject",

  /**
   * LinuxPerformanceCollection
   */
  LinuxPerformanceCollection: "LinuxPerformanceCollection",

  /**
   * CustomLog
   */
  CustomLog: "CustomLog",

  /**
   * CustomLogCollection
   */
  CustomLogCollection: "CustomLogCollection",

  /**
   * AzureAuditLog
   */
  AzureAuditLog: "AzureAuditLog",

  /**
   * AzureActivityLog
   */
  AzureActivityLog: "AzureActivityLog",

  /**
   * GenericDataSource
   */
  GenericDataSource: "GenericDataSource",

  /**
   * ChangeTrackingCustomPath
   */
  ChangeTrackingCustomPath: "ChangeTrackingCustomPath",

  /**
   * ChangeTrackingPath
   */
  ChangeTrackingPath: "ChangeTrackingPath",

  /**
   * ChangeTrackingServices
   */
  ChangeTrackingServices: "ChangeTrackingServices",

  /**
   * ChangeTrackingDataTypeConfiguration
   */
  ChangeTrackingDataTypeConfiguration: "ChangeTrackingDataTypeConfiguration",

  /**
   * ChangeTrackingDefaultRegistry
   */
  ChangeTrackingDefaultRegistry: "ChangeTrackingDefaultRegistry",

  /**
   * ChangeTrackingRegistry
   */
  ChangeTrackingRegistry: "ChangeTrackingRegistry",

  /**
   * ChangeTrackingLinuxPath
   */
  ChangeTrackingLinuxPath: "ChangeTrackingLinuxPath",

  /**
   * LinuxChangeTrackingPath
   */
  LinuxChangeTrackingPath: "LinuxChangeTrackingPath",

  /**
   * ChangeTrackingContentLocation
   */
  ChangeTrackingContentLocation: "ChangeTrackingContentLocation",

  /**
   * WindowsTelemetry
   */
  WindowsTelemetry: "WindowsTelemetry",

  /**
   * Office365
   */
  Office365: "Office365",

  /**
   * SecurityWindowsBaselineConfiguration
   */
  SecurityWindowsBaselineConfiguration: "SecurityWindowsBaselineConfiguration",

  /**
   * SecurityCenterSecurityWindowsBaselineConfiguration
   */
  SecurityCenterSecurityWindowsBaselineConfiguration: "SecurityCenterSecurityWindowsBaselineConfiguration",

  /**
   * SecurityEventCollectionConfiguration
   */
  SecurityEventCollectionConfiguration: "SecurityEventCollectionConfiguration",

  /**
   * SecurityInsightsSecurityEventCollectionConfiguration
   */
  SecurityInsightsSecurityEventCollectionConfiguration: "SecurityInsightsSecurityEventCollectionConfiguration",

  /**
   * ImportComputerGroup
   */
  ImportComputerGroup: "ImportComputerGroup",

  /**
   * NetworkMonitoring
   */
  NetworkMonitoring: "NetworkMonitoring",

  /**
   * Itsm
   */
  Itsm: "Itsm",

  /**
   * DnsAnalytics
   */
  DnsAnalytics: "DnsAnalytics",

  /**
   * ApplicationInsights
   */
  ApplicationInsights: "ApplicationInsights",

  /**
   * SqlDataClassification
   */
  SqlDataClassification: "SqlDataClassification",
}

/**
 * The provisioning state of the linked service.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union LinkedServiceEntityStatus {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * ProvisioningAccount
   */
  ProvisioningAccount: "ProvisioningAccount",

  /**
   * Updating
   */
  Updating: "Updating",
}

/**
 * The sort order of the search.
 */
union SearchSortEnum {
  string,

  /**
   * asc
   */
  asc: "asc",

  /**
   * desc
   */
  desc: "desc",
}

/**
 * The state of the storage insight connection to the workspace
 */
union StorageInsightState {
  string,

  /**
   * OK
   */
  OK: "OK",

  /**
   * ERROR
   */
  ERROR: "ERROR",
}

/**
 * Instruct the system how to handle and charge the logs ingested to this table.
 */
union TablePlanEnum {
  string,

  /**
   * Medium-touch logs needed for troubleshooting and incident response.
   */
  Basic: "Basic",

  /**
   * High-value logs used for continuous monitoring, real-time detection, and performance analytics.
   */
  Analytics: "Analytics",

  /**
   * Low-touch logs, such as verbose logs, and data required for auditing and compliance.
   */
  Auxiliary: "Auxiliary",
}

/**
 * Column data type.
 */
union ColumnTypeEnum {
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
   * long
   */
  long: "long",

  /**
   * real
   */
  real: "real",

  /**
   * boolean
   */
  boolean: "boolean",

  /**
   * dateTime
   */
  dateTime: "dateTime",

  /**
   * guid
   */
  guid: "guid",

  /**
   * dynamic
   */
  dynamic: "dynamic",
}

/**
 * Column data type logical hint.
 */
union ColumnDataTypeHintEnum {
  string,

  @doc("A string that matches the pattern of a URI, for example, scheme://username:password@host:1234/this/is/a/path?k1=v1&k2=v2#fragment")
  uri: "uri",

  /**
   * A standard 128-bit GUID following the standard shape, xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
   */
  guid: "guid",

  /**
   * An Azure Resource Model (ARM) path: /subscriptions/{...}/resourceGroups/{...}/providers/Microsoft.{...}/{...}/{...}/{...}...
   */
  armPath: "armPath",

  /**
   * A standard V4/V6 ip address following the standard shape, x.x.x.x/y:y:y:y:y:y:y:y
   */
  ip: "ip",
}

/**
 * Table's creator.
 */
union SourceEnum {
  string,

  /**
   * Tables provisioned by the system, as collected via Diagnostic Settings, the Agents, or any other standard data collection means.
   */
  microsoft: "microsoft",

  /**
   * Tables created by the owner of the Workspace, and only found in this Workspace.
   */
  customer: "customer",
}

/**
 * Table's creator.
 */
union TableTypeEnum {
  string,

  /**
   * Standard data collected by Azure Monitor.
   */
  Microsoft: "Microsoft",

  /**
   * Custom log table.
   */
  CustomLog: "CustomLog",

  /**
   * Restored data.
   */
  RestoredLogs: "RestoredLogs",

  /**
   * Data collected by a search job.
   */
  SearchResults: "SearchResults",
}

/**
 * The subtype describes what APIs can be used to interact with the table, and what features are available against it.
 */
union TableSubTypeEnum {
  string,

  /**
   * The default subtype with which built-in tables are created.
   */
  Any: "Any",

  /**
   * Indicates a table created through the Data Collector API or with the custom logs feature of the MMA agent, or any table against which Custom Fields were created.
   */
  Classic: "Classic",

  /**
   * A table eligible to have data sent into it via any of the means supported by Data Collection Rules: the Data Collection Endpoint API, ingestion-time transformations, or any other mechanism provided by Data Collection Rules
   */
  DataCollectionRuleBased: "DataCollectionRuleBased",
}

/**
 * Table's current provisioning state. If set to 'updating', indicates a resource lock due to ongoing operation, forbidding any update to the table until the ongoing operation is concluded.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union OperationalInsightsTableProvisioningState {
  string,

  /**
   * Table schema is still being built and updated, table is currently locked for any changes till the procedure is done.
   */
  Updating: "Updating",

  /**
   * Table schema is stable and without changes, table data is being updated.
   */
  InProgress: "InProgress",

  /**
   * Table state is stable and without changes, table is unlocked and open for new updates.
   */
  Succeeded: "Succeeded",

  /**
   * Table state is deleting.
   */
  Deleting: "Deleting",

  /**
   * Table state is failed.
   */
  Failed: "Failed",

  /**
   * Table state is canceled.
   */
  Canceled: "Canceled",
}

/**
 * Status of the operation represented by the requested Id.
 */
union PurgeState {
  string,

  /**
   * pending
   */
  pending: "pending",

  /**
   * completed
   */
  completed: "completed",
}

/**
 * The provisioning state of the workspace.
 */
union WorkspaceEntityStatus {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

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

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * ProvisioningAccount
   */
  ProvisioningAccount: "ProvisioningAccount",

  /**
   * Updating
   */
  Updating: "Updating",
}

/**
 * The name of the SKU.
 */
union WorkspaceSkuNameEnum {
  string,

  /**
   * Free
   */
  Free: "Free",

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * Premium
   */
  Premium: "Premium",

  /**
   * PerNode
   */
  PerNode: "PerNode",

  /**
   * PerGB2018
   */
  PerGB2018: "PerGB2018",

  /**
   * Standalone
   */
  Standalone: "Standalone",

  /**
   * CapacityReservation
   */
  CapacityReservation: "CapacityReservation",

  /**
   * LACluster
   */
  LACluster: "LACluster",
}

/**
 * The status of data ingestion for this workspace.
 */
union DataIngestionStatus {
  string,

  /**
   * Ingestion enabled following daily cap quota reset, or subscription enablement.
   */
  RespectQuota: "RespectQuota",

  /**
   * Ingestion started following service setting change.
   */
  ForceOn: "ForceOn",

  /**
   * Ingestion stopped following service setting change.
   */
  ForceOff: "ForceOff",

  /**
   * Reached daily cap quota, ingestion stopped.
   */
  OverQuota: "OverQuota",

  /**
   * Ingestion stopped following suspended subscription.
   */
  SubscriptionSuspended: "SubscriptionSuspended",

  /**
   * 80% of daily cap quota reached.
   */
  ApproachingQuota: "ApproachingQuota",
}

/**
 * The network access type for operating on the Log Analytics Workspace. By default it is Enabled
 */
union PublicNetworkAccessType {
  string,

  /**
   * Enables connectivity to Log Analytics through public DNS.
   */
  Enabled: "Enabled",

  /**
   * Disables public connectivity to Log Analytics through public DNS.
   */
  Disabled: "Disabled",

  /**
   * Resource is only accessible from private networks and access approved by network security perimeter associated to this resource.
   */
  SecuredByPerimeter: "SecuredByPerimeter",
}

/**
 * The provisioning state of the replication.
 */
union WorkspaceReplicationState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * EnableRequested
   */
  EnableRequested: "EnableRequested",

  /**
   * Enabling
   */
  Enabling: "Enabling",

  /**
   * DisableRequested
   */
  DisableRequested: "DisableRequested",

  /**
   * Disabling
   */
  Disabling: "Disabling",

  /**
   * RollbackRequested
   */
  RollbackRequested: "RollbackRequested",

  /**
   * RollingBack
   */
  RollingBack: "RollingBack",

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
 * The failover state of the replication.
 */
union WorkspaceFailoverState {
  string,

  /**
   * Inactive
   */
  Inactive: "Inactive",

  /**
   * Activating
   */
  Activating: "Activating",

  /**
   * Active
   */
  Active: "Active",

  /**
   * Deactivating
   */
  Deactivating: "Deactivating",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Type of issue
 */
union IssueType {
  string,

  /**
   * Unknown issue type
   */
  Unknown: "Unknown",

  /**
   * An error occurred while applying the network security perimeter (NSP) configuration.
   */
  ConfigurationPropagationFailure: "ConfigurationPropagationFailure",

  /**
   * A network connectivity issue is happening on the resource which could be addressed either by adding new resources to the network security perimeter (NSP) or by modifying access rules.
   */
  MissingPerimeterConfiguration: "MissingPerimeterConfiguration",

  /**
   * An managed identity hasn't been associated with the resource. The resource will still be able to validate inbound traffic from the network security perimeter (NSP) or matching inbound access rules, but it won't be able to perform outbound access as a member of the NSP.
   */
  MissingIdentityConfiguration: "MissingIdentityConfiguration",
}

/**
 * Severity of the issue.
 */
union Severity {
  string,

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Error
   */
  Error: "Error",
}

/**
 * SummaryRules rule type: User.
 */
union RuleTypeEnum {
  string,

  /**
   * User defined summary rule. This is the definition for rules created and defined by users.
   */
  User: "User",
}

/**
 * Indicates the reason for rule deactivation.
 */
union StatusCodeEnum {
  string,

  /**
   * Summary rule stop originated from a user action (Stop was called).
   */
  UserAction: "UserAction",

  /**
   * Summary rule stop was caused due to data plane related error.
   */
  DataPlaneError: "DataPlaneError",
}

/**
 * The time cursor used in Summary rules bins processing, e.g. TimeGenerated.
 */
union TimeSelectorEnum {
  string,

  /**
   * TimeGenerated.
   */
  TimeGenerated: "TimeGenerated",
}

/**
 * Linked storage accounts type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DataSourceType {
  /**
   * CustomLogs
   */
  CustomLogs,

  /**
   * AzureWatson
   */
  AzureWatson,

  /**
   * Query
   */
  Query,

  /**
   * Ingestion
   */
  Ingestion,

  /**
   * Alerts
   */
  Alerts,
}

/**
 * Type of managed service identity.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum IdentityType {
  /**
   * SystemAssigned
   */
  SystemAssigned,

  /**
   * UserAssigned
   */
  UserAssigned,

  /**
   * None
   */
  None,
}

/**
 * Service Tier details.
 */
model AvailableServiceTier {
  /**
   * The name of the Service Tier.
   */
  @visibility(Lifecycle.Read)
  serviceTier?: SkuNameEnum;

  /**
   * True if the Service Tier is enabled for the workspace.
   */
  @visibility(Lifecycle.Read)
  enabled?: boolean;

  /**
   * The minimum retention for the Service Tier, in days.
   */
  @visibility(Lifecycle.Read)
  minimumRetention?: int64;

  /**
   * The maximum retention for the Service Tier, in days.
   */
  @visibility(Lifecycle.Read)
  maximumRetention?: int64;

  /**
   * The default retention for the Service Tier, in days.
   */
  @visibility(Lifecycle.Read)
  defaultRetention?: int64;

  /**
   * The capacity reservation level in GB per day. Returned for the Capacity Reservation Service Tier.
   */
  @visibility(Lifecycle.Read)
  capacityReservationLevel?: int64;

  /**
   * Time when the sku was last updated for the workspace. Returned for the Capacity Reservation Service Tier.
   */
  @visibility(Lifecycle.Read)
  lastSkuUpdate?: string;
}

/**
 * The cluster sku definition.
 */
model ClusterSku {
  /**
   * The capacity reservation level in Gigabytes for this cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  capacity?: int64 | null;

  /**
   * The SKU (tier) of a cluster.
   */
  name?: ClusterSkuNameEnum;
}

/**
 * Cluster properties.
 */
model ClusterProperties {
  /**
   * The ID associated with the cluster.
   */
  @visibility(Lifecycle.Read)
  clusterId?: string;

  /**
   * The provisioning state of the cluster.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ClusterEntityStatus;

  /**
   * Configures whether cluster will use double encryption. This Property can not be modified after cluster creation. Default value is 'true'
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isDoubleEncryptionEnabled?: boolean;

  /**
   * Sets whether the cluster will support availability zones. This can be set as true only in regions where Azure Data Explorer support Availability Zones. This Property can not be modified after cluster creation. Default value is 'true' if region supports Availability Zones.
   */
  isAvailabilityZonesEnabled?: boolean;

  /**
   * The cluster's billing type.
   */
  billingType?: BillingType;

  /**
   * The associated key properties.
   */
  keyVaultProperties?: KeyVaultProperties;

  /**
   * The last time the cluster was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedDate?: utcDateTime;

  /**
   * The cluster creation time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The list of Log Analytics workspaces associated with the cluster
   */
  @identifiers(#["workspaceId"])
  associatedWorkspaces?: AssociatedWorkspace[];

  /**
   * Additional properties for capacity reservation
   */
  capacityReservationProperties?: CapacityReservationProperties;

  /**
   * Cluster's replication properties.
   */
  replication?: ClusterReplicationProperties;
}

/**
 * The key vault properties.
 */
model KeyVaultProperties {
  /**
   * The Key Vault uri which holds they key associated with the Log Analytics cluster.
   */
  keyVaultUri?: string;

  /**
   * The name of the key associated with the Log Analytics cluster.
   */
  keyName?: string;

  /**
   * The version of the key associated with the Log Analytics cluster.
   */
  keyVersion?: string;

  /**
   * Selected key minimum required size.
   */
  keyRsaSize?: int32;
}

/**
 * The list of Log Analytics workspaces associated with the cluster.
 */
model AssociatedWorkspace {
  /**
   * Associated workspace immutable id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  workspaceId?: string;

  /**
   * Associated workspace resource name.
   */
  @visibility(Lifecycle.Read)
  workspaceName?: string;

  /**
   * Associated workspace arm resource id, in the form of: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}.
   */
  @visibility(Lifecycle.Read)
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  /**
   * The time of workspace association.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  associateDate?: utcDateTime;
}

/**
 * The Capacity Reservation properties.
 */
model CapacityReservationProperties {
  /**
   * The last time Sku was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSkuUpdate?: utcDateTime;

  /**
   * Minimum CapacityReservation value in Gigabytes.
   */
  @visibility(Lifecycle.Read)
  minCapacity?: int64;
}

/**
 * Cluster replication properties.
 */
model ClusterReplicationProperties {
  /**
   * The secondary location of the replication. If replication is being enabled, enabled must be provided.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Specifies whether the replication is enabled or not. When true the cluster is replicate to the specified location.
   */
  enabled?: boolean;

  /**
   * Should enable AvailabilityZones for the given replicated cluster
   */
  isAvailabilityZonesEnabled?: boolean;

  /**
   * The provisioning state of the cluster replication.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ClusterReplicationState;

  /**
   * The cluster's replication creation time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The last time the cluster's replication was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedDate?: utcDateTime;
}

/**
 * The top level Log Analytics cluster resource container.
 */
model ClusterPatch {
  /**
   * Log Analytics cluster properties.
   */
  properties?: ClusterPatchProperties;

  /**
   * Resource's identity.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * The sku properties.
   */
  sku?: ClusterSku;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * Log Analytics cluster patch properties.
 */
model ClusterPatchProperties {
  /**
   * The associated key properties.
   */
  keyVaultProperties?: KeyVaultProperties;

  /**
   * The cluster's billing type.
   */
  billingType?: BillingType;
}

/**
 * Result of the request to list data exports.
 */
model DataExportListResult {
  /**
   * List of data export instances within a workspace..
   */
  @pageItems
  value?: DataExport[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Data Export properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DataExportProperties {
  /**
   * The data export rule ID.
   */
  dataExportId?: string;

  /**
   * An array of tables to export, for example: [“Heartbeat, SecurityEvent”].
   */
  tableNames: string[];

  /**
   * destination properties.
   */
  destination?: Destination;

  /**
   * Active when enabled.
   */
  enable?: boolean;

  /**
   * The latest data export rule modification time.
   */
  createdDate?: string;

  /**
   * Date and time when the export was last modified.
   */
  lastModifiedDate?: string;
}

/**
 * Destination properties.
 */
model Destination {
  /**
   * The destination resource ID. This can be copied from the Properties entry of the destination resource in Azure.
   */
  resourceId: string;

  /**
   * The type of the destination resource
   */
  @visibility(Lifecycle.Read)
  type?: Type;

  /**
   * destination meta data.
   */
  metaData?: DestinationMetaData;
}

/**
 * Destination meta data.
 */
model DestinationMetaData {
  /**
   * Optional. Allows to define an Event Hub name. Not applicable when destination is Storage Account.
   */
  eventHubName?: string;
}

/**
 * Intelligence Pack containing a string name and boolean indicating if it's enabled.
 */
model IntelligencePack {
  /**
   * The name of the intelligence pack.
   */
  name?: string;

  /**
   * The enabled boolean for the intelligence pack.
   */
  enabled?: boolean;

  /**
   * The display name of the intelligence pack.
   */
  displayName?: string;
}

/**
 * Linked service properties.
 */
model LinkedServiceProperties {
  /**
   * The resource id of the resource that will be linked to the workspace. This should be used for linking resources which require read access
   */
  resourceId?: string;

  /**
   * The resource id of the resource that will be linked to the workspace. This should be used for linking resources which require write access
   */
  writeAccessResourceId?: string;

  /**
   * The provisioning state of the linked service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: LinkedServiceEntityStatus;
}

/**
 * The list linked service operation response.
 */
model LinkedServiceListResult {
  /**
   * The list of linked service instances
   */
  @pageItems
  value?: LinkedService[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Linked storage accounts properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model LinkedStorageAccountsProperties {
  /**
   * Linked storage accounts type.
   */
  @visibility(Lifecycle.Read)
  dataSourceType?: DataSourceType;

  /**
   * Linked storage accounts resources ids.
   */
  storageAccountIds?: string[];
}

/**
 * The list linked storage accounts service operation response.
 */
model LinkedStorageAccountsListResult {
  /**
   * A list of linked storage accounts instances.
   */
  @pageItems
  value?: LinkedStorageAccountsResource[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The list workspace management groups operation response.
 */
model WorkspaceListManagementGroupsResult {
  /**
   * Gets or sets a list of management groups attached to the workspace.
   */
  @pageItems
  @identifiers(#["/properties/id"])
  value?: ManagementGroup[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * A management group that is connected to a workspace
 */
model ManagementGroup {
  /**
   * The properties of the management group.
   */
  properties?: ManagementGroupProperties;
}

/**
 * Management group properties.
 */
model ManagementGroupProperties {
  /**
   * The number of servers connected to the management group.
   */
  serverCount?: int32;

  /**
   * Gets or sets a value indicating whether the management group is a gateway.
   */
  isGateway?: boolean;

  /**
   * The name of the management group.
   */
  name?: string;

  /**
   * The unique ID of the management group.
   */
  id?: string;

  /**
   * The datetime that the management group was created.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The last datetime that the management group received data.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dataReceived?: utcDateTime;

  /**
   * The version of System Center that is managing the management group.
   */
  version?: string;

  /**
   * The SKU of System Center that is managing the management group.
   */
  sku?: string;
}

model OperationListResult is Azure.Core.Page<Operation>;

/**
 * Supported operation of OperationalInsights resource provider.
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * Display metadata associated with the operation.
   */
  display?: OperationDisplay;
}

/**
 * Display metadata associated with the operation.
 */
model OperationDisplay {
  /**
   * Service provider: Microsoft OperationsManagement.
   */
  provider?: string;

  /**
   * Resource on which the operation is performed etc.
   */
  resource?: string;

  /**
   * Type of operation: get, read, delete, etc.
   */
  operation?: string;

  /**
   * Description of operation
   */
  description?: string;
}

/**
 * The status of operation.
 */
model OperationStatus {
  /**
   * The operation Id.
   */
  id?: string;

  /**
   * The operation name.
   */
  name?: string;

  /**
   * The start time of the operation.
   */
  startTime?: string;

  /**
   * The end time of the operation.
   */
  endTime?: string;

  /**
   * The status of the operation.
   */
  status?: string;

  /**
   * The error detail of the operation if any.
   */
  error?: Azure.ResourceManager.CommonTypes.ErrorResponse;
}

/**
 * Properties that define an Log Analytics QueryPack-Query resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model LogAnalyticsQueryPackQueryProperties {
  /**
   * The unique ID of your application. This field cannot be changed.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Unique display name for your query within the Query Pack.
   */
  displayName: string;

  /**
   * Creation Date for the Log Analytics Query, in ISO 8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeCreated?: utcDateTime;

  /**
   * Last modified date of the Log Analytics Query, in ISO 8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeModified?: utcDateTime;

  /**
   * Object Id of user creating the query.
   */
  @visibility(Lifecycle.Read)
  author?: string;

  /**
   * Description of the query.
   */
  description?: string;

  /**
   * Body of the query.
   */
  body: string;

  /**
   * The related metadata items for the function.
   */
  related?: LogAnalyticsQueryPackQueryPropertiesRelated;

  /**
   * Tags associated with the query.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string[]>;

  /**
   * Additional properties that can be set for the query.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: unknown;
}

/**
 * The related metadata items for the function.
 */
model LogAnalyticsQueryPackQueryPropertiesRelated {
  /**
   * The related categories for the function.
   */
  categories?: string[];

  /**
   * The related resource types for the function.
   */
  resourceTypes?: string[];

  /**
   * The related Log Analytics solutions for the function.
   */
  solutions?: string[];
}

/**
 * Properties that define an Log Analytics QueryPack-Query search properties.
 */
model LogAnalyticsQueryPackQuerySearchProperties {
  /**
   * The related metadata items for the function.
   */
  related?: LogAnalyticsQueryPackQuerySearchPropertiesRelated;

  /**
   * Tags associated with the query.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string[]>;
}

/**
 * The related metadata items for the function.
 */
model LogAnalyticsQueryPackQuerySearchPropertiesRelated {
  /**
   * The related categories for the function.
   */
  categories?: string[];

  /**
   * The related resource types for the function.
   */
  resourceTypes?: string[];

  /**
   * The related Log Analytics solutions for the function.
   */
  solutions?: string[];
}

/**
 * Properties that define a Log Analytics QueryPack resource.
 */
model LogAnalyticsQueryPackProperties {
  /**
   * The unique ID of your application. This field cannot be changed.
   */
  @visibility(Lifecycle.Read)
  queryPackId?: string;

  /**
   * Creation Date for the Log Analytics QueryPack, in ISO 8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeCreated?: utcDateTime;

  /**
   * Last modified date of the Log Analytics QueryPack, in ISO 8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeModified?: utcDateTime;

  /**
   * Current state of this QueryPack: whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it. Values will include Succeeded, Deploying, Canceled, and Failed.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * A container holding only the Tags for a resource, allowing the user to update the tags on a QueryPack instance.
 */
model TagsResource {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Value object for saved search results.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SavedSearchProperties {
  /**
   * The category of the saved search. This helps the user to find a saved search faster.
   */
  category: string;

  /**
   * Saved search display name.
   */
  displayName: string;

  /**
   * The query expression for the saved search.
   */
  query: string;

  /**
   * The function alias if query serves as a function.
   */
  functionAlias?: string;

  /**
   * The optional function parameters if query serves as a function. Value should be in the following format: 'param-name1:type1 = default_value1, param-name2:type2 = default_value2'. For more examples and proper syntax please refer to https://docs.microsoft.com/en-us/azure/kusto/query/functions/user-defined-functions.
   */
  functionParameters?: string;

  /**
   * The version number of the query language. The current version is 2 and is the default.
   */
  version?: int64;

  /**
   * The tags attached to the saved search.
   */
  @identifiers(#["name"])
  tags?: Tag[];
}

/**
 * A tag of a saved search.
 */
model Tag {
  /**
   * The tag name.
   */
  name: string;

  /**
   * The tag value.
   */
  value: string;
}

/**
 * The saved search list operation response.
 */
model SavedSearchesListResult {
  /**
   * The array of result values.
   */
  @pageItems
  value?: SavedSearch[];
}

/**
 * The get schema operation response.
 */
model SearchGetSchemaResponse {
  /**
   * The metadata from search results.
   */
  metadata?: SearchMetadata;

  /**
   * The array of result values.
   */
  @pageItems
  @identifiers(#["name"])
  value?: SearchSchemaValue[];
}

/**
 * Metadata for search results.
 */
model SearchMetadata {
  /**
   * The request id of the search.
   */
  requestId?: string;

  /**
   * The search result type.
   */
  resultType?: string;

  /**
   * The total number of search results.
   */
  total?: int64;

  /**
   * The number of top search results.
   */
  top?: int64;

  /**
   * The id of the search results request.
   */
  id?: string;

  /**
   * The core summaries.
   */
  @identifiers(#[])
  coreSummaries?: CoreSummary[];

  /**
   * The status of the search results.
   */
  status?: string;

  /**
   * The start time for the search.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The time of last update.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  /**
   * The ETag of the search results.
   */
  eTag?: string;

  /**
   * How the results are sorted.
   */
  @identifiers(#["name"])
  sort?: SearchSort[];

  /**
   * The request time.
   */
  requestTime?: int64;

  /**
   * The aggregated value field.
   */
  aggregatedValueField?: string;

  /**
   * The aggregated grouping fields.
   */
  aggregatedGroupingFields?: string;

  /**
   * The sum of all aggregates returned in the result set.
   */
  sum?: int64;

  /**
   * The max of all aggregates returned in the result set.
   */
  max?: int64;

  /**
   * The schema.
   */
  schema?: SearchMetadataSchema;
}

/**
 * The core summary of a search.
 */
model CoreSummary {
  /**
   * The status of a core summary.
   */
  status?: string;

  /**
   * The number of documents of a core summary.
   */
  numberOfDocuments: int64;
}

/**
 * The sort parameters for search.
 */
model SearchSort {
  /**
   * The name of the field the search query is sorted on.
   */
  name?: string;

  /**
   * The sort order of the search.
   */
  order?: SearchSortEnum;
}

/**
 * Schema metadata for search.
 */
model SearchMetadataSchema {
  /**
   * The name of the metadata schema.
   */
  name?: string;

  /**
   * The version of the metadata schema.
   */
  version?: int32;
}

/**
 * Value object for schema results.
 */
model SearchSchemaValue {
  /**
   * The name of the schema.
   */
  name?: string;

  /**
   * The display name of the schema.
   */
  displayName?: string;

  /**
   * The type.
   */
  type?: string;

  /**
   * The boolean that indicates the field is searchable as free text.
   */
  indexed: boolean;

  /**
   * The boolean that indicates whether or not the field is stored.
   */
  stored: boolean;

  /**
   * The boolean that indicates whether or not the field is a facet.
   */
  facet: boolean;

  /**
   * The array of workflows containing the field.
   */
  ownerType?: string[];
}

/**
 * The shared keys for a workspace.
 */
model SharedKeys {
  /**
   * The primary shared key of a workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  primarySharedKey?: string;

  /**
   * The secondary shared key of a workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  secondarySharedKey?: string;
}

/**
 * Storage insight properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model StorageInsightProperties {
  /**
   * The names of the blob containers that the workspace should read
   */
  containers?: string[];

  /**
   * The names of the Azure tables that the workspace should read
   */
  tables?: string[];

  /**
   * The storage account connection details
   */
  storageAccount: StorageAccount;

  /**
   * The status of the storage insight
   */
  @visibility(Lifecycle.Read)
  status?: StorageInsightStatus;
}

/**
 * Describes a storage account connection.
 */
model StorageAccount {
  /**
   * The Azure Resource Manager ID of the storage account resource.
   */
  id: string;

  /**
   * The storage account key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  key: string;
}

/**
 * The status of the storage insight.
 */
model StorageInsightStatus {
  /**
   * The state of the storage insight connection to the workspace
   */
  state: StorageInsightState;

  /**
   * Description of the state of the storage insight.
   */
  description?: string;
}

/**
 * The list storage insights operation response.
 */
model StorageInsightListResult {
  /**
   * A list of storage insight items.
   */
  @pageItems
  value?: StorageInsight[];

  /**
   * The link (url) to the next page of results.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  `@odata.nextLink`?: string;
}

/**
 * The list tables operation response.
 */
model TablesListResult {
  /**
   * A list of data tables.
   */
  @pageItems
  value?: Table[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Table properties.
 */
model TableProperties {
  /**
   * In Analytics table: the tables analytics retention in days, between 4 and 730. Setting this property to -1 will default to the workspace retention. In Basic and Auxiliary table: read only property.
   */
  @maxValue(730)
  @minValue(4)
  retentionInDays?: int32;

  /**
   * The table total retention in days, between 4 and 4383. Setting this property to -1 will default to retentionInDays.
   */
  @maxValue(4383)
  @minValue(4)
  totalRetentionInDays?: int32;

  /**
   * The tables long-term retention in days. Calculated as (totalRetentionInDays-retentionInDays).
   */
  @visibility(Lifecycle.Read)
  archiveRetentionInDays?: int32;

  /**
   * Parameters of the search job that initiated this table.
   */
  searchResults?: SearchResults;

  /**
   * Parameters of the restore operation that initiated this table.
   */
  restoredLogs?: RestoredLogs;

  /**
   * Search job execution statistics.
   */
  @visibility(Lifecycle.Read)
  resultStatistics?: ResultStatistics;

  /**
   * Instruct the system how to handle and charge the logs ingested to this table.
   */
  plan?: TablePlanEnum;

  /**
   * The timestamp that table plan was last modified (UTC).
   */
  @visibility(Lifecycle.Read)
  lastPlanModifiedDate?: string;

  /**
   * Table schema.
   */
  schema?: Schema;

  /**
   * Table's current provisioning state. If set to 'updating', indicates a resource lock due to ongoing operation, forbidding any update to the table until the ongoing operation is concluded.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: OperationalInsightsTableProvisioningState;

  /**
   * True - Value originates from workspace retention in days, False - Customer specific.
   */
  @visibility(Lifecycle.Read)
  retentionInDaysAsDefault?: boolean;

  /**
   * True - Value originates from retention in days, False - Customer specific.
   */
  @visibility(Lifecycle.Read)
  totalRetentionInDaysAsDefault?: boolean;
}

/**
 * Parameters of the search job that initiated this table.
 */
model SearchResults {
  /**
   * Search job query.
   */
  query?: string;

  /**
   * Search job Description.
   */
  description?: string;

  /**
   * Limit the search job to return up to specified number of rows.
   */
  limit?: int32;

  /**
   * The timestamp to start the search from (UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startSearchTime?: utcDateTime;

  /**
   * The timestamp to end the search by (UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endSearchTime?: utcDateTime;

  /**
   * The table used in the search job.
   */
  @visibility(Lifecycle.Read)
  sourceTable?: string;

  /**
   * Search results table async operation id.
   */
  @visibility(Lifecycle.Read)
  azureAsyncOperationId?: string;
}

/**
 * Restore parameters.
 */
model RestoredLogs {
  /**
   * The timestamp to start the restore from (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startRestoreTime?: utcDateTime;

  /**
   * The timestamp to end the restore by (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endRestoreTime?: utcDateTime;

  /**
   * The table to restore data from.
   */
  sourceTable?: string;

  /**
   * Search results table async operation id.
   */
  @visibility(Lifecycle.Read)
  azureAsyncOperationId?: string;
}

/**
 * Search job execution statistics.
 */
model ResultStatistics {
  /**
   * Search job completion percentage.
   */
  @visibility(Lifecycle.Read)
  progress?: float32;

  /**
   * The number of rows that were returned by the search job.
   */
  @visibility(Lifecycle.Read)
  ingestedRecords?: int32;

  /**
   * Search job: Amount of scanned data.
   */
  @visibility(Lifecycle.Read)
  scannedGb?: float32;
}

/**
 * Table's schema.
 */
model Schema {
  /**
   * Table name.
   */
  name?: string;

  /**
   * Table display name.
   */
  displayName?: string;

  /**
   * Table description.
   */
  description?: string;

  /**
   * A list of table custom columns.
   */
  @identifiers(#["name"])
  columns?: Column[];

  /**
   * A list of table standard columns.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  standardColumns?: Column[];

  /**
   * Table category.
   */
  @visibility(Lifecycle.Read)
  categories?: string[];

  /**
   * Table labels.
   */
  @visibility(Lifecycle.Read)
  labels?: string[];

  /**
   * Table's creator.
   */
  @visibility(Lifecycle.Read)
  source?: SourceEnum;

  /**
   * Table's creator.
   */
  @visibility(Lifecycle.Read)
  tableType?: TableTypeEnum;

  /**
   * The subtype describes what APIs can be used to interact with the table, and what features are available against it.
   */
  @visibility(Lifecycle.Read)
  tableSubType?: TableSubTypeEnum;

  /**
   * List of solutions the table is affiliated with
   */
  @visibility(Lifecycle.Read)
  solutions?: string[];
}

/**
 * Table column.
 */
model Column {
  /**
   * Column name.
   */
  name?: string;

  /**
   * Column data type.
   */
  type?: ColumnTypeEnum;

  /**
   * Column data type logical hint.
   */
  dataTypeHint?: ColumnDataTypeHintEnum;

  /**
   * Column display name.
   */
  displayName?: string;

  /**
   * Column description.
   */
  description?: string;

  /**
   * Is displayed by default.
   */
  @visibility(Lifecycle.Read)
  isDefaultDisplay?: boolean;

  /**
   * Is column hidden.
   */
  @visibility(Lifecycle.Read)
  isHidden?: boolean;
}

/**
 * The list workspace usages operation response.
 */
model WorkspaceListUsagesResult {
  /**
   * Gets or sets a list of usage metrics for a workspace.
   */
  @pageItems
  @identifiers(#["name"])
  value?: UsageMetric[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * A metric describing the usage of a resource.
 */
model UsageMetric {
  /**
   * The name of the metric.
   */
  name?: MetricName;

  /**
   * The units used for the metric.
   */
  unit?: string;

  /**
   * The current value of the metric.
   */
  currentValue?: float64;

  /**
   * The quota limit for the metric.
   */
  limit?: float64;

  /**
   * The time that the metric's value will reset.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextResetTime?: utcDateTime;

  /**
   * The quota period that determines the length of time between value resets.
   */
  quotaPeriod?: string;
}

/**
 * The name of a metric.
 */
model MetricName {
  /**
   * The system name of the metric.
   */
  value?: string;

  /**
   * The localized name of the metric.
   */
  localizedValue?: string;
}

/**
 * Describes the body of a purge request for an App Insights Workspace
 */
model WorkspacePurgeBody {
  /**
   * Table from which to purge data.
   */
  table: string;

  /**
   * The set of columns and filters (queries) to run over them to purge the resulting data.
   */
  @identifiers(#[])
  filters: WorkspacePurgeBodyFilters[];
}

/**
 * User-defined filters to return data which will be purged from the table.
 */
model WorkspacePurgeBodyFilters {
  /**
   * The column of the table over which the given query should run
   */
  column?: string;

  /**
   * A query operator to evaluate over the provided column and value(s). Supported operators are ==, =~, in, in~, >, >=, <, <=, between, and have the same behavior as they would in a KQL query.
   */
  operator?: string;

  /**
   * the value for the operator to function over. This can be a number (e.g., > 100), a string (timestamp >= '2017-09-01') or array of values.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: unknown;

  /**
   * When filtering over custom dimensions, this key will be used as the name of the custom dimension.
   */
  key?: string;
}

/**
 * Response containing operationId for a specific purge action.
 */
model WorkspacePurgeResponse {
  /**
   * Id to use when querying for status for a particular purge operation.
   */
  operationId: string;
}

/**
 * Response containing status for a specific purge operation.
 */
model WorkspacePurgeStatusResponse {
  /**
   * Status of the operation represented by the requested Id.
   */
  status: PurgeState;
}

/**
 * The list workspaces operation response.
 */
model WorkspaceListResult {
  /**
   * A list of workspaces.
   */
  @pageItems
  value?: Workspace[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Workspace properties.
 */
model WorkspaceProperties {
  /**
   * The provisioning state of the workspace.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: WorkspaceEntityStatus;

  /**
   * This is a read-only property. Represents the ID associated with the workspace.
   */
  @visibility(Lifecycle.Read)
  customerId?: string;

  /**
   * The SKU of the workspace.
   */
  sku?: WorkspaceSku;

  /**
   * The workspace data retention in days. Allowed values are per pricing plan. See pricing tiers documentation for details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  retentionInDays?: int32 | null;

  /**
   * The daily volume cap for ingestion.
   */
  workspaceCapping?: WorkspaceCapping;

  /**
   * Workspace creation date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * Workspace modification date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedDate?: utcDateTime;

  /**
   * The network access type for accessing Log Analytics ingestion.
   */
  publicNetworkAccessForIngestion?: PublicNetworkAccessType = PublicNetworkAccessType.Enabled;

  /**
   * The network access type for accessing Log Analytics query.
   */
  publicNetworkAccessForQuery?: PublicNetworkAccessType = PublicNetworkAccessType.Enabled;

  /**
   * Indicates whether customer managed storage is mandatory for query management.
   */
  forceCmkForQuery?: boolean;

  /**
   * List of linked private link scope resources.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["resourceId"])
  privateLinkScopedResources?: PrivateLinkScopedResource[];

  /**
   * Workspace features.
   */
  features?: WorkspaceFeatures;

  /**
   * The resource ID of the default Data Collection Rule to use for this workspace. Expected format is - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/dataCollectionRules/{dcrName}.
   */
  defaultDataCollectionRuleResourceId?: string;

  /**
   * workspace replication properties.
   */
  replication?: WorkspaceReplicationProperties;

  /**
   * workspace failover properties.
   */
  failover?: WorkspaceFailoverProperties;
}

/**
 * The SKU (tier) of a workspace.
 */
model WorkspaceSku {
  /**
   * The name of the SKU.
   */
  name: WorkspaceSkuNameEnum;

  /**
   * The capacity reservation level in GB for this workspace, when CapacityReservation sku is selected.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  capacityReservationLevel?: int32 | null;

  /**
   * The last time when the sku was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSkuUpdate?: utcDateTime;
}

/**
 * The daily volume cap for ingestion.
 */
model WorkspaceCapping {
  /**
   * The workspace daily quota for ingestion.
   */
  dailyQuotaGb?: float64;

  /**
   * The time when the quota will be rest.
   */
  @visibility(Lifecycle.Read)
  quotaNextResetTime?: string;

  /**
   * The status of data ingestion for this workspace.
   */
  @visibility(Lifecycle.Read)
  dataIngestionStatus?: DataIngestionStatus;
}

/**
 * The private link scope resource reference.
 */
model PrivateLinkScopedResource {
  /**
   * The full resource Id of the private link scope resource.
   */
  resourceId?: string;

  /**
   * The private link scope unique Identifier.
   */
  scopeId?: string;
}

/**
 * Workspace features.
 */
model WorkspaceFeatures {
  ...Record<unknown>;

  /**
   * Flag that indicate if data should be exported.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableDataExport?: boolean | null;

  /**
   * Flag that describes if we want to remove the data after 30 days.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  immediatePurgeDataOn30Days?: boolean | null;

  /**
   * Flag that indicate which permission to use - resource or workspace or both.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableLogAccessUsingOnlyResourcePermissions?: boolean | null;

  /**
   * Dedicated LA cluster resourceId that is linked to the workspaces.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clusterResourceId?: string | null;

  /**
   * Disable Non-AAD based Auth.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disableLocalAuth?: boolean | null;

  /**
   * An indication if the specify workspace is limited to sentinel's unified billing model only.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  unifiedSentinelBillingOnly?: boolean | null;

  /**
   * List of associations for the workspace. Indicates if the workspace is associated with any of the following experiences: MDC, Sentinel, SentinelGraph, etc.
   */
  @visibility(Lifecycle.Read)
  associations?: string[];
}

/**
 * Workspace replication properties.
 */
model WorkspaceReplicationProperties {
  /**
   * The location of the replication.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Specifies whether the replication is enabled or not. When true, workspace configuration and data is replicated to the specified location. If replication is been enabled, location must be provided.
   */
  enabled?: boolean;

  /**
   * The provisioning state of the replication.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: WorkspaceReplicationState;

  /**
   * The last time when the replication was enabled.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The last time when the replication was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedDate?: utcDateTime;
}

/**
 * The failover state of the replication.
 */
model WorkspaceFailoverProperties {
  /**
   * The failover state of the replication.
   */
  @visibility(Lifecycle.Read)
  state?: WorkspaceFailoverState;

  /**
   * The last time when the failover state was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedDate?: utcDateTime;
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
   * Type of managed service identity.
   */
  type: IdentityType;

  /**
   * The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserIdentityProperties>;
}

/**
 * User assigned identity properties.
 */
model UserIdentityProperties {
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
 * The top level Workspace resource container.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model WorkspacePatch extends AzureEntityResource {
  /**
   * Workspace properties.
   */
  properties?: WorkspaceProperties;

  /**
   * The identity of the resource.
   */
  identity?: Identity;

  /**
   * Resource tags. Optional.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * Subscription identifiers
 */
model AccessRulePropertiesSubscriptionsItem {
  /**
   * The fully qualified Azure resource ID of the subscription e.g. ('/subscriptions/00000000-0000-0000-0000-000000000000')
   */
  id?: Azure.Core.armResourceIdentifier;
}

/**
 * Summary rule properties.
 */
model SummaryLogsProperties {
  /**
   * SummaryRules rule type: User.
   */
  ruleType?: RuleTypeEnum;

  /**
   * The display name of the Summary rule.
   */
  displayName?: string;

  /**
   * The description of the Summary rule.
   */
  description?: string;

  /**
   * Indicates if Summary rule is active. If not, Summary rule execution stops.
   */
  @visibility(Lifecycle.Read)
  isActive?: boolean;

  /**
   * Indicates the reason for rule deactivation.
   */
  @visibility(Lifecycle.Read)
  statusCode?: StatusCodeEnum;

  /**
   * Summary rule is in provisioning state. If set to 'updating' or 'deleting', indicates a resource lock due to an ongoing operation, preventing any update to the Summary rule until the operation is complete.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: OperationalInsightsTableProvisioningState;

  /**
   * Rule definition parameters.
   */
  ruleDefinition?: RuleDefinition;
}

/**
 * Rule definition parameters.
 */
model RuleDefinition {
  /**
   * Summary rule query.
   */
  query?: string;

  /**
   * Scheduled window in minutes. Allowed values: 20, 30, 60, 120, 180, 360, 720, 1440.
   */
  binSize?: int32;

  /**
   * The minimum delay in seconds before bin processing.
   */
  binDelay?: int32;

  /**
   * The start time (UTC) when Summary rule execution starts.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  binStartTime?: utcDateTime;

  /**
   * The time cursor used in Summary rules bins processing, e.g. TimeGenerated.
   */
  timeSelector?: TimeSelectorEnum;

  /**
   * The destination table used for the Summary rule results.
   */
  destinationTable?: string;
}

/**
 * Request to retry a summary logs bin.
 */
model SummaryLogsRetryBin {
  /**
   * Retry bin properties.
   */
  properties?: SummaryLogsRetryBinProperties;
}

/**
 * Properties for retrying a Summary rule bin.
 */
model SummaryLogsRetryBinProperties {
  /**
   * The time (UTC) of the bin to retry.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  retryBinStartTime: utcDateTime;
}

/**
 * DataSource filter. Right now, only filter by kind is supported.
 */
model DataSourceFilter {
  /**
   * The kind of the DataSource.
   */
  kind?: DataSourceKind;
}

/**
 * Workspace replication properties.
 */
model WorkspaceReplicationPatProperties {
  /**
   * The location of the replication.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Specifies whether the replication is enabled or not. When true, workspace configuration and data is replicated to the specified location.
   */
  enabled?: boolean;

  /**
   * The provisioning state of the replication.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: WorkspaceReplicationState;

  /**
   * The last time when the replication was enabled.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The last time when the replication was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedDate?: utcDateTime;
}

@@identifiers(OperationListResult.value, #["name"]);

/**
 * ARM error response body.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
@error
model ARMErrorResponseBody {
  /**
   * Gets or sets the string that describes the error in detail and provides debugging information.
   */
  message?: string;

  /**
   * Gets or sets the string that can be used to programmatically identify the error.
   */
  code?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ArmErrorResponse {
  /**
   * ARM error response body.
   */
  error?: ARMErrorResponseBody;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@error
model ArmNotFoundBodyResponse {
  @body error: ArmErrorResponse;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@doc("ignore")
model ArmNotFoundResponse {
  ...Response<404>;
}
