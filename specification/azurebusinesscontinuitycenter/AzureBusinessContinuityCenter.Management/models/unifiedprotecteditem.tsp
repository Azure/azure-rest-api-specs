import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
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

@doc("Definition of temporary properties.")
model TemporaryProperties {
  @doc("Deferred delete sync time.")
  deferredDeleteSyncTime?: string;

  @doc("Deferred delete time remaining.")
  deferredDeleteTimeRemaining?: string;

  @doc("Scheduled purge time.")
  scheduledPurgeTime?: string;

  @doc("Policy id.")
  policyId?: string;

  @doc("Workload type.")
  workloadType: string;

  @doc("Cluster type.")
  clusterType?: ClusterType;

  @doc("Cluster node names.")
  clusterNodes?: string[];
}

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

  @doc("Temporary properties.")
  temporaryProperties: TemporaryProperties;

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
  @visibility("read")
  upiSchemaVersion: UPISchemaVersion;

  @doc("The friendly name of the protected item.")
  @visibility("read")
  friendlyName: string;

  @doc("Data source information of protected item.")
  @visibility("read")
  dataSourceInformation: DataSourceInformation;

  @doc("Linked resource information of the protected item.")
  @visibility("read")
  linkedResourceInformation: LinkedResourceInformation;

  @doc("Datasource is protected in primary region or not.")
  @visibility("read")
  isProtectedInPrimaryRegion: boolean;

  @doc("Datasource is protected in secondary region or not.")
  @visibility("read")
  isProtectedInSecondaryRegion: boolean;

  @doc("Protection status of Datasource in primary region.")
  @visibility("read")
  protectionStatusInPrimaryRegion: UPIProtectionStatus;

  @doc("Protection status of Datasource in secondary region.")
  @visibility("read")
  protectionStatusInSecondaryRegion: UPIProtectionStatus;

  @doc("Security Level of protected item")
  @visibility("read")
  maximumBcdrDataSecurity: BCDRDataSecurityLevel;

  @doc("Primary region properties of protected item.")
  @visibility("read")
  primaryRegionProtectionDetails: RegionSpecificPropertiesForUnifiedProtectedItem;

  @doc("Secondary region properties of protected item.")
  @visibility("read")
  secondaryRegionProtectionDetails?: RegionSpecificPropertiesForUnifiedProtectedItem;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
  @doc("Dictionary for solution specific properties.")
  @visibility("read")
  solutionSpecificProtectionProperties: Record<SolutionSpecificProtectionProperties>;

  @doc("Detail of protected item.")
  @extension("x-ms-identifiers", [])
  @visibility("read")
  protectedItems: SolutionSpecificProtectedItem[];

  @doc("List of distinct solution provider names.")
  @visibility("read")
  distinctBcdrSolutionProviderNames: string[];

  @doc("List of distinct solution names.")
  @visibility("read")
  distinctSolutionNames: string[];

  @doc("TenantId of the protected items.")
  @visibility("read")
  tenantId: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
  @doc("Map of deleted protected item Id to last event time.")
  @visibility("read")
  deletedPiLastEventTimeMap: Record<utcDateTime>;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("A UnifiedProtectedItem represents a protected item by backup or replication solution.")
model UnifiedProtectedItemResource
  is ExtensionResource<UnifiedProtectedItemProperties> {
  @key("unifiedProtectedItemsName")
  @segment("unifiedProtectedItems")
  @path
  @visibility("read")
  @doc("The name of the unified protected item.")
  @pattern("^[a-zA-Z0-9;/_]+$")
  name: string;
}
