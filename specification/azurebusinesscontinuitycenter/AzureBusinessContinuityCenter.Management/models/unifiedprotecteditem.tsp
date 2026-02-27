import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.AzureBusinessContinuity;

@doc("enum for UPI protection status.")
union UPIProtectionStatus {
  @doc("Resource is not Protected.")
  NotProtected: "NotProtected",

  string,

  @doc("Resource is Protected.")
  Protected: "Protected",

  string,

  @doc("Protection configured but first backup is pending.")
  PendingProtection: "PendingProtection",

  string,

  @doc("Protection paused.")
  ProtectionPaused: "ProtectionPaused",

  string,
}

@doc("enum for UPI schema version.")
union UPISchemaVersion {
  @doc("V1 schema version.")
  V1: "V1",

  string,
}

@doc("enum for Supported data source types.")
union DataSourceType {
  @doc("Azure Virtual Machine.")
  AzureVirtualMachine: "AzureVirtualMachine",

  string,

  @doc("SQL running on Azure Virtual Machine.")
  AzureVmSQL: "AzureVmSQL",

  string,

  @doc("Azure file share.")
  AzureFileshare: "AzureFileshare",

  string,

  @doc("SAP Hana running on Azure Virtual Machine.")
  AzureVmSAPHana: "AzureVmSAPHana",

  string,

  @doc("AzureDatabase for PostgreSql.")
  AzureDatabaseForPostgreSql: "AzureDatabaseForPostgreSql",

  string,

  @doc("Azure Disks.")
  AzureDisks: "AzureDisks",

  string,

  @doc("Azure Blobs.")
  AzureBlobs: "AzureBlobs",

  string,

  @doc("Azure Kubernetes Services.")
  KubernetesServices: "KubernetesServices",

  string,

  @doc("VMware Machine.")
  VMwareMachine: "VMwareMachine",

  string,
}

@doc("enum for Supported cluster based data source types.")
union ClusterType {
  @doc("Not a cluster.")
  NotAvailable: "NotAvailable",

  string,

  @doc("SQL AlwaysOn Availability Group.")
  AzureVmWorkloadSQLAvailabilityGroup: "AzureVmWorkloadSQLAvailabilityGroup",

  string,

  @doc("SAP Hana System Replication.")
  AzureVmWorkloadSAPHanaHSR: "AzureVmWorkloadSAPHanaHSR",

  string,
}

@doc("Enum for BCDR security level.")
union BCDRDataSecurityLevel {
  @doc("Not available.")
  NotAvailable: "NotAvailable",

  string,

  @doc("Protected item is not secured.")
  None: "None",

  string,

  @doc("Protected item is secured with minimum security.")
  Minimum: "Minimum",

  string,

  @doc("Protected item is secured with adequate security.")
  Adequate: "Adequate",

  string,

  @doc("Protected item is secured with maximum security.")
  Maximum: "Maximum",

  string,
}

@doc("Enum for protection status.")
union ProtectionStatus {
  @doc("Resource is protected.")
  Protected: "Protected",

  string,

  @doc("Protection configured but first backup is pending.")
  PendingProtection: "PendingProtection",

  string,

  @doc("Protection paused.")
  ProtectionPaused: "ProtectionPaused",

  string,
}

@added(Versions.v2025_11_01_preview)
@doc("Enum for source side scan status.")
union SourceSideScanStatus {
  @doc("Not Applicable.")
  NotApplicable: "NotApplicable",

  string,

  @doc("Source side scan is configured.")
  Configured: "Configured",

  string,

  @doc("Source side scan is not configured.")
  NotConfigured: "NotConfigured",

  string,

  @doc("Source side scan configuration has failed.")
  ConfigurationFailed: "ConfigurationFailed",

  string,
}

@added(Versions.v2025_11_01_preview)
@doc("Enum for source side scan summary.")
union SourceSideScanSummary {
  @doc("Not Applicable.")
  NotApplicable: "NotApplicable",

  string,

  @doc("Scan status is unknown.")
  Unknown: "Unknown",

  string,

  @doc("Suspicious activity detected.")
  Suspicious: "Suspicious",

  string,

  @doc("No issues detected, status is healthy.")
  Healthy: "Healthy",

  string,

  @doc("No threats reported.")
  NoThreatsReported: "NoThreatsReported",

  string,
}

@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key.")
  key?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

@doc("Definition of solution specific protected item.")
model SolutionSpecificProtectionProperties {
  @doc("List of allowed operations.")
  allowedOperationsPerSolution: string[];
}

@doc("Definition of Data source information.")
model DataSourceInformation {
  @doc("Datasource type.")
  dataSourceType: DataSourceType;

  @doc("Data source id.")
  dataSourceId: string;
}

@doc("Information of linked resource.")
model LinkedResourceInformation {
  @doc("Id of linked resource.")
  linkedResourceId: string;

  @doc("Type of linked resource.")
  linkedResourceType: string;

  @doc("Is data source managed by azure or not.")
  isAzureManagedLinkedResource: boolean;

  @doc("Is data source is cluster resource or not.")
  isCluster: boolean;

  @doc("Cluster Name.")
  clusterName?: string;

  @doc("Cluster Type.")
  clusterType?: ClusterType;

  @doc("List of cluster nodes.")
  clusterNodes?: string[];

  @doc("Resource location of linked resource.")
  resourceLocation?: string;
}

@added(Versions.v2025_11_01_preview)
@doc("Source side scan information.")
model SourceSideScanInfo {
  @doc("Source side scan status.")
  sourceSideScanStatus: SourceSideScanStatus;

  @doc("Source side scan summary.")
  sourceSideScanSummary: SourceSideScanSummary;
}

@doc("Definition of nullable date time property info.")
model NullableDateTimePropertyInfo {
  @doc("Value of the property if its available.")
  propertyValue: utcDateTime;

  @doc("Flag, if property has value or not.")
  isAvailable: boolean;
}

@doc("Definition of nullable int property info.")
model NullableIntPropertyInfo {
  @doc("Value of the property if its available.")
  propertyValue: int64;

  @doc("Flag, if property has value or not.")
  isAvailable: boolean;
}

@doc("UPI property.")
model RegionSpecificPropertiesForUnifiedProtectedItem {
  @doc("Configured RPO for UPI in minutes.")
  configuredRpoInMinutes?: int64;

  @doc("Latest recoverypoint time.")
  latestRecoveryPoint: NullableDateTimePropertyInfo;

  @doc("Oldest recoverypoint time.")
  oldestRecoveryPoint: NullableDateTimePropertyInfo;

  @doc("Minimum retention period in days.")
  minimumConfiguredRetentionInDays: NullableIntPropertyInfo;

  @doc("Maximum retention period in days.")
  maximumConfiguredRetentionInDays: NullableIntPropertyInfo;
}

@doc("Definition of Protected item region specific property.")
model RegionSpecificPropertiesForProtectedItem {
  @doc("Protection status of protected item.")
  protectionStatus: ProtectionStatus;

  @doc("Protection state of protected item.")
  protectedItemState: string;

  @doc("Configured RPO for protected item in minutes.")
  configuredRpoInMinutes?: int64;

  @doc("Latest recoverypoint time.")
  latestRecoveryPoint: NullableDateTimePropertyInfo;

  @doc("Oldest recoverypoint time.")
  oldestRecoveryPoint: NullableDateTimePropertyInfo;

  @doc("Minimum retention period in days.")
  configuredMaximumRetentionInDays: NullableIntPropertyInfo;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Back compatibility"
@doc("Definition of provider specific properties.")
model ProviderSpecificProperties {}

@doc("Provider specific property for Azure blob workload for Microsoft Azure backup solution provider.")
@parentResource(ProviderSpecificProperties)
model AzureBackupAzureBlobsPropertyBag {
  @doc("Soft delete time.")
  deletionTime: string;

  @doc("Scheduled purge time.")
  scheduledPurgeTime: string;

  @doc("Backup policy id.")
  policyId: string;

  @doc("Location of the backup vault.")
  vaultLocation: string;

  @doc("Data source type.")
  dataSourceType: string;
}

@doc("Provider specific property for Azure postgre database workload for Microsoft Azure backup solution provider.")
@parentResource(ProviderSpecificProperties)
model AzureBackupAzureDatabaseForPostgreSqlPropertyBag {
  @doc("Soft delete time.")
  deletionTime: string;

  @doc("Scheduled purge time.")
  scheduledPurgeTime: string;

  @doc("Backup policy id.")
  policyId: string;

  @doc("Location of the backup vault.")
  vaultLocation: string;

  @doc("Data source type.")
  dataSourceType: string;
}

@doc("Provider specific property for Azure disk workload for Microsoft Azure backup solution provider.")
@parentResource(ProviderSpecificProperties)
model AzureBackupAzureDisksPropertyBag {
  @doc("Soft delete time.")
  deletionTime: string;

  @doc("Scheduled purge time.")
  scheduledPurgeTime: string;

  @doc("Backup policy id.")
  policyId: string;

  @doc("Location of the backup vault.")
  vaultLocation: string;

  @doc("Data source type.")
  dataSourceType: string;
}

@doc("Provider specific property for AKS workload for Microsoft Azure backup solution provider.")
@parentResource(ProviderSpecificProperties)
model AzureBackupKubernetesServicesPropertyBag {
  @doc("Soft delete time.")
  deletionTime: string;

  @doc("Scheduled purge time.")
  scheduledPurgeTime: string;

  @doc("Backup policy id.")
  policyId: string;

  @doc("Location of the backup vault.")
  vaultLocation: string;

  @doc("Data source type.")
  dataSourceType: string;
}

@doc("Provider specific property for Azure fileshare for Microsoft Azure backup solution provider.")
@parentResource(ProviderSpecificProperties)
model AzureBackupAzureFilesharePropertyBag {
  @doc("Soft delete time.")
  deferredDeleteSyncTime?: string;

  @doc("Time remaining for permanent deletion of softdeleted item.")
  deferredDeleteTimeRemaining?: string;

  @doc("Backup policy id.")
  policyId?: string;

  @doc("Location of the backup vault.")
  vaultLocation: string;

  @doc("Workload type of protected items.")
  workloadType: string;

  @doc("Backup management type of protected items.")
  backupManagementType: string;
}

@doc("Provider specific property for Azure Virtual machine for Microsoft Azure backup solution provider.")
@parentResource(ProviderSpecificProperties)
model AzureBackupAzureVirtualMachinePropertyBag {
  @doc("Soft delete time.")
  deferredDeleteSyncTime?: string;

  @doc("Time remaining for permanent deletion of softdeleted item.")
  deferredDeleteTimeRemaining?: string;

  @doc("Backup policy id.")
  policyId?: string;

  @doc("Location of the backup vault.")
  vaultLocation: string;

  @doc("Workload type of protected items.")
  workloadType: string;

  @doc("Backup management type of protected items.")
  backupManagementType: string;
}

@doc("Provider specific property for SAP Hana on Azure virtual machine for Microsoft Azure backup solution provider.")
@parentResource(ProviderSpecificProperties)
model AzureBackupAzureVmSapHanaPropertyBag {
  @doc("Soft delete time.")
  deferredDeleteSyncTime?: string;

  @doc("Time remaining for permanent deletion of softdeleted item.")
  deferredDeleteTimeRemaining?: string;

  @doc("Backup policy id.")
  policyId?: string;

  @doc("Location of the backup vault.")
  vaultLocation: string;

  @doc("Workload type of protected items.")
  workloadType: string;

  @doc("Backup management type of protected items.")
  backupManagementType: string;
}

@doc("Provider specific property for SAP Hana on Azure virtual machine for Microsoft Azure backup solution provider.")
@parentResource(ProviderSpecificProperties)
model AzureBackupAzureVmSqlPropertyBag {
  @doc("Soft delete time.")
  deferredDeleteSyncTime?: string;

  @doc("Time remaining for permanent deletion of softdeleted item.")
  deferredDeleteTimeRemaining?: string;

  @doc("Backup policy id.")
  policyId?: string;

  @doc("Location of the backup vault.")
  vaultLocation: string;

  @doc("Workload type of protected items.")
  workloadType: string;

  @doc("Backup management type of protected items.")
  backupManagementType: string;
}

@doc("Definition of nullable bool property info.")
model NullableBoolPropertyInfo {
  @doc("Value of the property if its available.")
  propertyValue?: boolean;

  @doc("Flag, if property has value or not.")
  isAvailable: boolean;
}

@doc("Definition of solution specific protected item.")
model SolutionSpecificProtectedItem {
  @doc("Solution display name.")
  solutionDisplayName: string;

  @doc("Solution provider name.")
  solutionProviderName: string;

  @doc("Protected item id.")
  protectedItemId: string;

  @doc("Protected item name.")
  protectedItemFriendlyName: string;

  @doc("Protected item primary region.")
  protectedItemPrimaryRegion?: string;

  @doc("Protected item secondary region.")
  protectedItemSecondaryRegion?: string;

  @doc("Protected item protection details for primary region.")
  primaryRegionProtectionDetails?: RegionSpecificPropertiesForProtectedItem;

  @doc("Protected item protection details for secondary region.")
  secondaryRegionProtectionDetails?: RegionSpecificPropertiesForProtectedItem;

  @doc("Allowed operations on protected item.")
  allowedOperations: string[];

  @doc("BCDR Security score of protected item.")
  bcdrDataSecurityLevel: BCDRDataSecurityLevel;

  @added(Versions.v2025_11_01_preview)
  @doc("Source side scan information of protected item.")
  sourceSideScanInfo: SourceSideScanInfo;

  @doc("Provider specific properties.")
  providerSpecificProperties?: ProviderSpecificProperties;

  @doc("Is deleted resource or not.")
  isDeletedResource?: NullableBoolPropertyInfo;

  @doc("Last updated time of protected item.")
  lastUpdatedTime: utcDateTime;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
  @doc("Dictionary of resource type to last event time.")
  dictionaryOfResourceTypeToLastEventTime: Record<utcDateTime>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
  @doc("Properties for referenced objects.")
  //referencedObjects: Record<Record<string[]>>;
  referencedObjects: ReferencedObjects;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
@doc("Definition of ReferenceObject.")
model ReferencedObject is Record<string[]>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
@doc("Dictionary of reference objects.")
model ReferencedObjects is Record<ReferencedObject>;

@doc("The provisioning state of a resource type.")
@Azure.Core.lroStatus
union ProvisioningState {
  @doc("Resource has been created.")
  Succeeded: "Succeeded",

  string,

  @doc("Resource creation failed.")
  Failed: "Failed",

  string,

  @doc("Resource creation was canceled.")
  Canceled: "Canceled",

  string,
}

@doc("Definition of unified protected item properties.")
model UnifiedProtectedItemProperties {
  @doc("Unified property item schema version.")
  @visibility(Lifecycle.Read)
  upiSchemaVersion: UPISchemaVersion;

  @doc("The friendly name of the protected item.")
  @visibility(Lifecycle.Read)
  friendlyName: string;

  @doc("Computed & aggregated data source information of UPI.")
  @visibility(Lifecycle.Read)
  dataSourceInformation: DataSourceInformation;

  @doc("Computed & aggregated linked resource information of UPI.")
  @visibility(Lifecycle.Read)
  linkedResourceInformation: LinkedResourceInformation;

  @doc("Computed & aggregated flag of UPI whether datasource is protected in primary region or not.")
  @visibility(Lifecycle.Read)
  isProtectedInPrimaryRegion: boolean;

  @doc("Computed & aggregated flag of UPI whether datasource is protected in secondary region or not.")
  @visibility(Lifecycle.Read)
  isProtectedInSecondaryRegion: boolean;

  @doc("Computed & aggregated protection status of UPI for datasource in primary region.")
  @visibility(Lifecycle.Read)
  protectionStatusInPrimaryRegion: UPIProtectionStatus;

  @doc("Computed & aggregated protection status of UPI for datasource in secondary region.")
  @visibility(Lifecycle.Read)
  protectionStatusInSecondaryRegion: UPIProtectionStatus;

  @doc("Computed & aggregated Security Level of UPI")
  @visibility(Lifecycle.Read)
  maximumBcdrDataSecurity: BCDRDataSecurityLevel;

  @added(Versions.v2025_11_01_preview)
  @doc("Computed & aggregated source side scan information on UPI.")
  @visibility(Lifecycle.Read)
  sourceSideScanInfo: SourceSideScanInfo;

  @doc("Primary region properties of UPI.")
  @visibility(Lifecycle.Read)
  primaryRegionProtectionDetails: RegionSpecificPropertiesForUnifiedProtectedItem;

  @doc("Secondary region properties of UPI.")
  @visibility(Lifecycle.Read)
  secondaryRegionProtectionDetails?: RegionSpecificPropertiesForUnifiedProtectedItem;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
  @doc("Dictionary for solution specific properties.")
  @visibility(Lifecycle.Read)
  solutionSpecificProtectionProperties: Record<SolutionSpecificProtectionProperties>;

  @doc("Detail of protected items.")
  @identifiers(#[])
  @visibility(Lifecycle.Read)
  protectedItems: SolutionSpecificProtectedItem[];

  @doc("List of distinct solution provider names.")
  @visibility(Lifecycle.Read)
  distinctBcdrSolutionProviderNames: string[];

  @doc("List of distinct solution names.")
  @visibility(Lifecycle.Read)
  distinctSolutionNames: string[];

  @doc("TenantId of the UPI.")
  @visibility(Lifecycle.Read)
  tenantId: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
  @doc("Map of deleted protected item Id to last event time.")
  @visibility(Lifecycle.Read)
  deletedPiLastEventTimeMap: Record<utcDateTime>;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation of UPI.")
  provisioningState?: ProvisioningState;
}

@doc("A UnifiedProtectedItem represents a protected item by backup or replication solution.")
model UnifiedProtectedItemResource
  is ExtensionResource<UnifiedProtectedItemProperties> {
  @key("unifiedProtectedItemsName")
  @segment("unifiedProtectedItems")
  @path
  @visibility(Lifecycle.Read)
  @doc("The name of the unified protected item.")
  @pattern("^[a-zA-Z0-9;/_]+$")
  name: string;
}
