import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;

namespace Microsoft.RecoveryServices;

/**
 * Storage type
 */
union StorageType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GeoRedundant: "GeoRedundant",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LocallyRedundant: "LocallyRedundant",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ZoneRedundant: "ZoneRedundant",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReadAccessGeoZoneRedundant: "ReadAccessGeoZoneRedundant",
}

/**
 * Locked or Unlocked. Once a machine is registered against a resource, the storageTypeState is always Locked.
 */
union StorageTypeState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Locked: "Locked",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unlocked: "Unlocked",
}

/**
 * Vault Dedup state
 */
union DedupState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Vault x-cool state
 */
union XcoolState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Type of workload this item represents.
 */
union DataSourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VM: "VM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FileFolder: "FileFolder",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureSqlDb: "AzureSqlDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SQLDB: "SQLDB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Exchange: "Exchange",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Sharepoint: "Sharepoint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VMwareVM: "VMwareVM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemState: "SystemState",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Client: "Client",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GenericDataSource: "GenericDataSource",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SQLDataBase: "SQLDataBase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureFileShare: "AzureFileShare",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SAPHanaDatabase: "SAPHanaDatabase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SAPAseDatabase: "SAPAseDatabase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SAPHanaDBInstance: "SAPHanaDBInstance",
}

/**
 * Validation Status
 */
union ValidationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * Specifies whether the container is registered or not
 */
union ProtectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotProtected: "NotProtected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Protecting: "Protecting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Protected: "Protected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProtectionFailed: "ProtectionFailed",
}

/**
 * Specifies the fabric name - Azure or AD
 */
union FabricName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Azure: "Azure",
}

/**
 * Whether storage account lock is to be acquired for this container or not.
 */
union AcquireStorageAccountLock {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Acquire: "Acquire",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotAcquire: "NotAcquire",
}

/**
 * Support status of feature
 */
union SupportStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Supported: "Supported",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DefaultOFF: "DefaultOFF",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DefaultON: "DefaultON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotSupported: "NotSupported",
}

/**
 * backup protectionIntent type.
 */
union ProtectionIntentItemType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureResourceItem: "AzureResourceItem",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RecoveryServiceVaultItem: "RecoveryServiceVaultItem",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureWorkloadContainerAutoProtectionIntent: "AzureWorkloadContainerAutoProtectionIntent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureWorkloadAutoProtectionIntent: "AzureWorkloadAutoProtectionIntent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureWorkloadSQLAutoProtectionIntent: "AzureWorkloadSQLAutoProtectionIntent",
}

/**
 * Backup management type to execute the current job.
 */
union BackupManagementType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureIaasVM: "AzureIaasVM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MAB: "MAB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DPM: "DPM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureBackupServer: "AzureBackupServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureSql: "AzureSql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureStorage: "AzureStorage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureWorkload: "AzureWorkload",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DefaultBackup: "DefaultBackup",
}

/**
 * Unit of the usage.
 */
union UsagesUnit {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Count: "Count",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Bytes: "Bytes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Seconds: "Seconds",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Percent: "Percent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CountPerSecond: "CountPerSecond",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BytesPerSecond: "BytesPerSecond",
}

/**
 * Enabled or Disabled.
 */
union EnhancedSecurityState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Soft Delete feature state
 */
union SoftDeleteFeatureState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AlwaysON: "AlwaysON",
}

/**
 * Threat status of the container
 */
@added(Versions.v2026_01_01_preview)
union SourceSideScanStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Configured: "Configured",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotConfigured: "NotConfigured",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotApplicable: "NotApplicable",
}

/**
 * Threat summary for the container
 */
@added(Versions.v2026_01_01_preview)
union SourceSideScanSummary {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotApplicable: "NotApplicable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Suspicious: "Suspicious",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Healthy: "Healthy",
}

/**
 * Source side threat information
 */
@added(Versions.v2026_01_01_preview)
model SourceSideScanInfo {
  /**
   * Threat status of the container
   */
  sourceSideScanStatus?: SourceSideScanStatus;

  /**
   * Threat summary for the container
   */
  sourceSideScanSummary?: SourceSideScanSummary;
}

/**
 * Threat status of the recovery point
 */
@added(Versions.v2026_01_01_preview)
union ThreatStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Healthy: "Healthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UnHealthy: "UnHealthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotAvailable: "NotAvailable",
}

/**
 * Threat Status Types
 */
@added(Versions.v2026_01_01_preview)
union ThreatState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ignored: "Ignored",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Resolved: "Resolved",
}

/**
 * Threat Severity Types
 */
@added(Versions.v2026_01_01_preview)
union ThreatSeverity {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Critical: "Critical",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  High: "High",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Informational: "Informational",
}

/**
 * Recovery Point Threat information
 */
@added(Versions.v2026_01_01_preview)
model ThreatInfo {
  /**
   * Threat Subject
   */
  @visibility(Lifecycle.Read)
  threatTitle?: string;

  /**
   * Threat Description
   */
  @visibility(Lifecycle.Read)
  threatDescription?: string;

  /**
   * Timestamp when the last (latest)threat information was sent
   */
  @visibility(Lifecycle.Read)
  lastUpdatedTime?: utcDateTime;

  /**
   * Threat Status Types
   */
  threatState?: ThreatState;

  /**
   * Start timestamp of the threat
   */
  @visibility(Lifecycle.Read)
  threatStartTime?: utcDateTime;

  /**
   * End timestamp of the threat
   */
  @visibility(Lifecycle.Read)
  threatEndTime?: utcDateTime;

  /**
   * threat details link
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API uses threatURI"
  @visibility(Lifecycle.Read)
  threatURI?: url;

  /**
   * Threat Severity Types
   */
  threatSeverity?: ThreatSeverity;
}

/**
 * Encryption At Rest Type
 */
union EncryptionAtRestType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MicrosoftManaged: "MicrosoftManaged",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CustomerManaged: "CustomerManaged",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union LastUpdateStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotEnabled: "NotEnabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PartiallySucceeded: "PartiallySucceeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PartiallyFailed: "PartiallyFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Initialized: "Initialized",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FirstInitialization: "FirstInitialization",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union InfrastructureEncryptionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
}

/**
 * Gets or sets provisioning state of the private endpoint connection
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
}

/**
 * GroupId for the PrivateEndpointConnection - AzureBackup, AzureBackup_secondary or AzureSiteRecovery
 */
union VaultSubResourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureBackup: "AzureBackup",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureBackup_secondary: "AzureBackup_secondary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureSiteRecovery: "AzureSiteRecovery",
}

/**
 * Gets or sets the status
 */
union PrivateEndpointConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disconnected: "Disconnected",
}

/**
 * Operation status.
 */
union OperationStatusValues {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
}

/**
 * DataMove Level
 */
union DataMoveLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Vault: "Vault",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Container: "Container",
}

/**
 * Create mode to indicate recovery of existing soft deleted data source or creation of new data source.
 */
union CreateMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Recover: "Recover",
}

/**
 * Type of the backup engine.
 */
union BackupEngineType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DpmBackupEngine: "DpmBackupEngine",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureBackupServerEngine: "AzureBackupServerEngine",
}

/**
 * Backup state of this backup item.
 */
union ProtectionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IRPending: "IRPending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Protected: "Protected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProtectionError: "ProtectionError",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProtectionStopped: "ProtectionStopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProtectionPaused: "ProtectionPaused",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BackupsSuspended: "BackupsSuspended",
}

/**
 * Resource Health Status
 */
union ResourceHealthStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Healthy: "Healthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TransientDegraded: "TransientDegraded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PersistentDegraded: "PersistentDegraded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TransientUnhealthy: "TransientUnhealthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PersistentUnhealthy: "PersistentUnhealthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
}

/**
 * Type of this recovery.
 */
union RecoveryType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OriginalLocation: "OriginalLocation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AlternateLocation: "AlternateLocation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RestoreDisks: "RestoreDisks",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Offline: "Offline",
}

/**
 * Options to resolve copy conflicts.
 */
union CopyOptions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CreateCopy: "CreateCopy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Skip: "Skip",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Overwrite: "Overwrite",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FailOnConflict: "FailOnConflict",
}

/**
 * Restore Type (FullShareRestore or ItemLevelRestore)
 */
union RestoreRequestType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FullShareRestore: "FullShareRestore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ItemLevelRestore: "ItemLevelRestore",
}

/**
 * Type of workload for the backup management
 */
union WorkloadType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VM: "VM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FileFolder: "FileFolder",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureSqlDb: "AzureSqlDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SQLDB: "SQLDB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Exchange: "Exchange",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Sharepoint: "Sharepoint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VMwareVM: "VMwareVM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemState: "SystemState",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Client: "Client",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GenericDataSource: "GenericDataSource",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SQLDataBase: "SQLDataBase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureFileShare: "AzureFileShare",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SAPHanaDatabase: "SAPHanaDatabase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SAPAseDatabase: "SAPAseDatabase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SAPHanaDBInstance: "SAPHanaDBInstance",
}

/**
 * Type of backup policy type
 */
union PolicyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Full: "Full",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Differential: "Differential",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Log: "Log",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CopyOnlyFull: "CopyOnlyFull",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Incremental: "Incremental",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SnapshotFull: "SnapshotFull",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SnapshotCopyOnlyFull: "SnapshotCopyOnlyFull",
}

/**
 * Type of the protection policy
 */
@added(Versions.v2026_01_01_preview)
union VMWorkloadPolicyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SnapshotV1: "SnapshotV1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SnapshotV2: "SnapshotV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Streaming: "Streaming",
}

/**
 * Tiering Mode to control automatic tiering of recovery points. Supported values are:
 * 1. TierRecommended: Tier all recovery points recommended to be tiered
 * 2. TierAfter: Tier all recovery points after a fixed period, as specified in duration + durationType below.
 * 3. DoNotTier: Do not tier any recovery points
 */
union TieringMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TierRecommended: "TierRecommended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TierAfter: "TierAfter",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DoNotTier: "DoNotTier",
}

/**
 * Retention duration type of retention policy.
 */
union RetentionDurationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Days: "Days",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Weeks: "Weeks",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Months: "Months",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Years: "Years",
}

/**
 * Health status of protected item.
 */
union HealthStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Passed: "Passed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ActionRequired: "ActionRequired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ActionSuggested: "ActionSuggested",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union IAASVMPolicyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  V1: "V1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  V2: "V2",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union IaasVMSnapshotConsistencyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OnlyCrashConsistent: "OnlyCrashConsistent",
}

/**
 * Backup state of the backed up item.
 */
union ProtectedItemState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IRPending: "IRPending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Protected: "Protected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProtectionError: "ProtectionError",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProtectionStopped: "ProtectionStopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProtectionPaused: "ProtectionPaused",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BackupsSuspended: "BackupsSuspended",
}

/**
 * Protection type in case protected as part of a parent.
 */
@added(Versions.v2026_01_01_preview)
union ProtectionLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Database: "Database",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DatabaseUnderInstance: "DatabaseUnderInstance",
}

/**
 * The state of instance protection.
 */
@added(Versions.v2026_01_01_preview)
union InstanceProtectionReadiness {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ready: "Ready",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ScheduleDisabled: "ScheduleDisabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PartialProtection: "PartialProtection",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProtectionError: "ProtectionError",
}

/**
 * Last backup operation status. Possible values: Healthy, Unhealthy.
 */
union LastBackupStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Healthy: "Healthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unhealthy: "Unhealthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IRPending: "IRPending",
}

/**
 * Health status of the backup item, evaluated based on last heartbeat received
 */
union ProtectedItemHealthStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Healthy: "Healthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unhealthy: "Unhealthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotReachable: "NotReachable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IRPending: "IRPending",
}

/**
 * Type of restore point
 */
union RestorePointType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Full: "Full",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Log: "Log",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Differential: "Differential",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Incremental: "Incremental",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SnapshotFull: "SnapshotFull",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SnapshotCopyOnlyFull: "SnapshotCopyOnlyFull",
}

/**
 * Can Overwrite if Target DataBase already exists
 */
union OverwriteOptions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FailOnConflict: "FailOnConflict",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Overwrite: "Overwrite",
}

/**
 * Defines whether the current recovery mode is file restore or database restore
 */
union RecoveryMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FileRecovery: "FileRecovery",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WorkloadRecovery: "WorkloadRecovery",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SnapshotAttach: "SnapshotAttach",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RecoveryUsingSnapshot: "RecoveryUsingSnapshot",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SnapshotAttachAndRecover: "SnapshotAttachAndRecover",
}

/**
 * Type of data directory mapping
 */
union SQLDataDirectoryType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Data: "Data",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Log: "Log",
}

/**
 * RestorePoint type
 */
union RestorePointQueryType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Full: "Full",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Log: "Log",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Differential: "Differential",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FullAndDifferential: "FullAndDifferential",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  All: "All",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Incremental: "Incremental",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SnapshotFull: "SnapshotFull",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SnapshotCopyOnlyFull: "SnapshotCopyOnlyFull",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2026_01_01_preview)
  Snapshot: "Snapshot",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2026_01_01_preview)
  FullDifferentialAndSnapshot: "FullDifferentialAndSnapshot",
}

/**
 * Status of the job.
 */
union JobStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CompletedWithWarnings: "CompletedWithWarnings",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cancelled: "Cancelled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cancelling: "Cancelling",
}

/**
 * Type of operation.
 */
union JobOperationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Register: "Register",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UnRegister: "UnRegister",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ConfigureBackup: "ConfigureBackup",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Backup: "Backup",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Restore: "Restore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DisableBackup: "DisableBackup",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DeleteBackupData: "DeleteBackupData",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CrossRegionRestore: "CrossRegionRestore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Undelete: "Undelete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UpdateCustomerManagedKey: "UpdateCustomerManagedKey",
}

/**
 * Retention schedule format type for monthly retention policy.
 */
union RetentionScheduleFormat {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Daily: "Daily",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Weekly: "Weekly",
}

/**
 * Server type of MAB container.
 */
union MabServerType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IaasVMContainer: "IaasVMContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IaasVMServiceContainer: "IaasVMServiceContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DPMContainer: "DPMContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureBackupServerContainer: "AzureBackupServerContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MABContainer: "MABContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cluster: "Cluster",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureSqlContainer: "AzureSqlContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Windows: "Windows",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VCenter: "VCenter",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VMAppContainer: "VMAppContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SQLAGWorkLoadContainer: "SQLAGWorkLoadContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  StorageContainer: "StorageContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GenericContainer: "GenericContainer",
}

/**
 * Health State for the backed up item.
 */
union HealthState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Passed: "Passed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ActionRequired: "ActionRequired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ActionSuggested: "ActionSuggested",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
}

/**
 * Frequency of the schedule operation of this policy.
 */
union ScheduleRunType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Daily: "Daily",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Weekly: "Weekly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Hourly: "Hourly",
}

/**
 * File Share type XSync or XSMB.
 */
union AzureFileShareType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  XSMB: "XSMB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  XSync: "XSync",
}

/**
 * Re-Do Operation
 */
union OperationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Register: "Register",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Reregister: "Reregister",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Rehydrate: "Rehydrate",
}

/**
 * Status of protectable item, i.e. InProgress,Succeeded,Failed
 */
union InquiryStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Success: "Success",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * Type of backup, viz. Full, Differential, Log or CopyOnlyFull
 */
union BackupType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Full: "Full",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Differential: "Differential",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Log: "Log",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CopyOnlyFull: "CopyOnlyFull",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Incremental: "Incremental",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SnapshotFull: "SnapshotFull",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SnapshotCopyOnlyFull: "SnapshotCopyOnlyFull",
}

/**
 * Workload item type of the item for which intent is to be set
 */
union WorkloadItemType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SQLInstance: "SQLInstance",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SQLDataBase: "SQLDataBase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SAPHanaSystem: "SAPHanaSystem",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SAPHanaDatabase: "SAPHanaDatabase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SAPAseSystem: "SAPAseSystem",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SAPAseDatabase: "SAPAseDatabase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SAPHanaDBInstance: "SAPHanaDBInstance",
}

/**
 * Backup management type for this container.
 */
union Type {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BackupProtectedItemCountSummary: "BackupProtectedItemCountSummary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BackupProtectionContainerCountSummary: "BackupProtectionContainerCountSummary",
}

/**
 * Type of workload this item represents
 */
union IntentItemType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SQLInstance: "SQLInstance",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SQLAvailabilityGroupContainer: "SQLAvailabilityGroupContainer",
}

/**
 * Type of container for filter
 */
union ContainerType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IaasVMContainer: "IaasVMContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IaasVMServiceContainer: "IaasVMServiceContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DPMContainer: "DPMContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureBackupServerContainer: "AzureBackupServerContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MABContainer: "MABContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cluster: "Cluster",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureSqlContainer: "AzureSqlContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Windows: "Windows",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VCenter: "VCenter",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VMAppContainer: "VMAppContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SQLAGWorkLoadContainer: "SQLAGWorkLoadContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  StorageContainer: "StorageContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GenericContainer: "GenericContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  HanaHSRContainer: "HanaHSRContainer",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2026_01_01_preview)
  HanaScaleoutContainer: "HanaScaleoutContainer",
}

/**
 * Type of backup items associated with this container.
 */
union BackupItemType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VM: "VM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FileFolder: "FileFolder",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureSqlDb: "AzureSqlDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SQLDB: "SQLDB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Exchange: "Exchange",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Sharepoint: "Sharepoint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VMwareVM: "VMwareVM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemState: "SystemState",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Client: "Client",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GenericDataSource: "GenericDataSource",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SQLDataBase: "SQLDataBase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureFileShare: "AzureFileShare",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SAPHanaDatabase: "SAPHanaDatabase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SAPAseDatabase: "SAPAseDatabase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SAPHanaDBInstance: "SAPHanaDBInstance",
}

/**
 * Rehydration Priority
 */
union RehydrationPriority {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  High: "High",
}

/**
 * HTTP Status Code of the operation.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum HttpStatusCode {
  Continue,
  SwitchingProtocols,
  OK,
  Created,
  Accepted,
  NonAuthoritativeInformation,
  NoContent,
  ResetContent,
  PartialContent,
  MultipleChoices,
  Ambiguous,
  MovedPermanently,
  Moved,
  Found,
  Redirect,
  SeeOther,
  RedirectMethod,
  NotModified,
  UseProxy,
  Unused,
  TemporaryRedirect,
  RedirectKeepVerb,
  BadRequest,
  Unauthorized,
  PaymentRequired,
  Forbidden,
  NotFound,
  MethodNotAllowed,
  NotAcceptable,
  ProxyAuthenticationRequired,
  RequestTimeout,
  Conflict,
  Gone,
  LengthRequired,
  PreconditionFailed,
  RequestEntityTooLarge,
  RequestUriTooLong,
  UnsupportedMediaType,
  RequestedRangeNotSatisfiable,
  ExpectationFailed,
  UpgradeRequired,
  InternalServerError,
  NotImplemented,
  BadGateway,
  ServiceUnavailable,
  GatewayTimeout,
  HttpVersionNotSupported,
}

/**
 * Type of the container. The value of this property for
 * 1. Compute Azure VM is Microsoft.Compute/virtualMachines
 * 2. Classic Compute Azure VM is Microsoft.ClassicCompute/virtualMachines
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ProtectableContainerType {
  Invalid,
  Unknown,
  IaasVMContainer,
  IaasVMServiceContainer,
  DPMContainer,
  AzureBackupServerContainer,
  MABContainer,
  Cluster,
  AzureSqlContainer,
  Windows,
  VCenter,
  VMAppContainer,
  SQLAGWorkLoadContainer,
  StorageContainer,
  GenericContainer,
  `Microsoft.ClassicCompute/virtualMachines`,
  `Microsoft.Compute/virtualMachines`,
  AzureWorkloadContainer,
}

/**
 * Recovery point tier type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum RecoveryPointTierType {
  Invalid,
  InstantRP,
  HardenedRP,
  ArchivedRP,
}

/**
 * Recovery point tier status.
 */
union RecoveryPointTierStatus {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  "Valid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  "Rehydrated",
  string,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum JobSupportedAction {
  Invalid,
  Cancellable,
  Retriable,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * Network access settings to be used for restored disks
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum TargetDiskNetworkAccessOption {
  SameAsOnSourceDisks,
  EnablePrivateAccessForAllDisks,
  EnablePublicAccessForAllDisks,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum WeekOfMonth {
  First,
  Second,
  Third,
  Fourth,
  Last,
  Invalid,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum MonthOfYear {
  Invalid,
  January,
  February,
  March,
  April,
  May,
  June,
  July,
  August,
  September,
  October,
  November,
  December,
}

/**
 * The resource storage details.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupResourceConfig {
  /**
   * Storage type
   */
  storageModelType?: StorageType;

  /**
   * Storage type.
   */
  storageType?: StorageType;

  /**
   * Locked or Unlocked. Once a machine is registered against a resource, the storageTypeState is always Locked.
   */
  storageTypeState?: StorageTypeState;

  /**
   * Opt in details of Cross Region Restore feature.
   */
  crossRegionRestoreFlag?: boolean;

  /**
   * Vault Dedup state
   */
  dedupState?: DedupState;

  /**
   * Vault x-cool state
   */
  xcoolState?: XcoolState;
}

/**
 * Contract to validate if backup can be enabled on the given resource in a given vault and given configuration.
 * It will validate followings
 * 1. Vault capacity
 * 2. VM is already protected
 * 3. Any VM related configuration passed in properties.
 */
model PreValidateEnableBackupRequest {
  /**
   * ProtectedItem Type- VM, SqlDataBase, AzureFileShare etc
   */
  resourceType?: DataSourceType;

  /**
   * ARM Virtual Machine Id
   */
  resourceId?: string;

  /**
   * ARM id of the Recovery Services Vault
   */
  vaultId?: string;

  /**
   * Configuration of VM if any needs to be validated like OS type etc
   */
  properties?: string;
}

/**
 * Response contract for enable backup validation request
 */
model PreValidateEnableBackupResponse {
  /**
   * Validation Status
   */
  status?: ValidationStatus;

  /**
   * Response error code
   */
  errorCode?: string;

  /**
   * Response error message
   */
  errorMessage?: string;

  /**
   * Recommended action for user
   */
  recommendation?: string;

  /**
   * Specifies the product specific container name. E.g. iaasvmcontainer;iaasvmcontainer;rgname;vmname. This is required
   * for portal
   */
  containerName?: string;

  /**
   * Specifies the product specific ds name. E.g. vm;iaasvmcontainer;rgname;vmname. This is required for portal
   */
  protectedItemName?: string;
}

/**
 * BackupStatus request.
 */
model BackupStatusRequest {
  /**
   * Container Type - VM, SQLPaaS, DPM, AzureFileShare...
   */
  resourceType?: DataSourceType;

  /**
   * Entire ARM resource id of the resource
   */
  resourceId?: string;

  /**
   * Protectable Item Logical Name
   */
  poLogicalName?: string;
}

/**
 * BackupStatus response.
 */
model BackupStatusResponse {
  /**
   * Specifies whether the container is registered or not
   */
  protectionStatus?: ProtectionStatus;

  /**
   * Specifies the arm resource id of the vault
   */
  vaultId?: string;

  /**
   * Specifies the fabric name - Azure or AD
   */
  fabricName?: FabricName;

  /**
   * Specifies the product specific container name. E.g. iaasvmcontainer;iaasvmcontainer;csname;vmname.
   */
  containerName?: string;

  /**
   * Specifies the product specific ds name. E.g. vm;iaasvmcontainer;csname;vmname.
   */
  protectedItemName?: string;

  /**
   * ErrorCode in case of intent failed
   */
  errorCode?: string;

  /**
   * ErrorMessage in case of intent failed.
   */
  errorMessage?: string;

  /**
   * Specifies the policy name which is used for protection
   */
  policyName?: string;

  /**
   * Container registration status
   */
  registrationStatus?: string;

  /**
   * Number of protected items
   */
  protectedItemsCount?: int32;

  /**
   * Specifies whether the storage account lock has been acquired or not
   */
  acquireStorageAccountLock?: AcquireStorageAccountLock;
}

/**
 * Base class for feature request
 */
@discriminator("featureType")
model FeatureSupportRequest {
  /**
   * backup support feature type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  featureType: string;
}

/**
 * Response for feature support requests for Azure IaasVm
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVMResourceFeatureSupportResponse {
  /**
   * Support status of feature
   */
  supportStatus?: SupportStatus;
}

/**
 * Base class for backup ProtectionIntent.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("protectionIntentItemType")
model ProtectionIntent {
  /**
   * backup protectionIntent type.
   */
  protectionIntentItemType: ProtectionIntentItemType;

  /**
   * Type of backup management for the backed up item.
   */
  backupManagementType?: BackupManagementType;

  /**
   * ARM ID of the resource to be backed up.
   */
  sourceResourceId?: string;

  /**
   * ID of the item which is getting protected, In case of Azure Vm , it is ProtectedItemId
   */
  itemId?: string;

  /**
   * ID of the backup policy with which this item is backed up.
   */
  policyId?: string;

  /**
   * Backup state of this backup item.
   */
  protectionState?: ProtectionStatus;
}

/**
 * List of ProtectionIntent resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProtectionIntentResourceList extends ResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: ProtectionIntentResource[];
}

/**
 * Base for all lists of resources.
 */
model ResourceList {
  /**
   * The URI to fetch the next page of resources, with each API call returning up to 200 resources per page. Use ListNext() to fetch the next page if the total number of resources exceeds 200.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Backup management usage for vault.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupManagementUsageList extends ResourceList {
  /**
   * The list of backup management usages for the given vault.
   */
  @pageItems
  @identifiers(#[])
  value?: BackupManagementUsage[];
}

/**
 * Backup management usages of a vault.
 */
model BackupManagementUsage {
  /**
   * Unit of the usage.
   */
  unit?: UsagesUnit;

  /**
   * Quota period of usage.
   */
  quotaPeriod?: string;

  /**
   * Next reset time of usage.
   */
  nextResetTime?: utcDateTime;

  /**
   * Current value of usage.
   */
  currentValue?: int64;

  /**
   * Limit of usage.
   */
  limit?: int64;

  /**
   * Name of usage.
   */
  name?: NameInfo;
}

/**
 * The name of usage.
 */
model NameInfo {
  /**
   * Value of usage.
   */
  value?: string;

  /**
   * Localized value of usage.
   */
  localizedValue?: string;
}

/**
 * Available operation details.
 */
model ClientDiscoveryValueForSingleApi {
  /**
   * Name of the Operation.
   */
  name?: string;

  /**
   * Contains the localized display information for this particular operation
   */
  display?: ClientDiscoveryDisplay;

  /**
   * The intended executor of the operation;governs the display of the operation in the RBAC UX and the audit logs UX
   */
  origin?: string;

  /**
   * ShoeBox properties for the given operation.
   */
  properties?: ClientDiscoveryForProperties;
}

/**
 * Localized display information of an operation.
 */
model ClientDiscoveryDisplay {
  /**
   * Name of the provider for display purposes
   */
  provider?: string;

  /**
   * ResourceType for which this Operation can be performed.
   */
  resource?: string;

  /**
   * Operations Name itself.
   */
  operation?: string;

  /**
   * Description of the operation having details of what operation is about.
   */
  description?: string;
}

/**
 * Class to represent shoebox properties in json client discovery.
 */
model ClientDiscoveryForProperties {
  /**
   * Operation properties.
   */
  serviceSpecification?: ClientDiscoveryForServiceSpecification;
}

/**
 * Class to represent shoebox service specification in json client discovery.
 */
model ClientDiscoveryForServiceSpecification {
  /**
   * List of log specifications of this operation.
   */
  @identifiers(#[])
  logSpecifications?: ClientDiscoveryForLogSpecification[];
}

/**
 * Class to represent shoebox log specification in json client discovery.
 */
model ClientDiscoveryForLogSpecification {
  /**
   * Name for shoebox log specification.
   */
  name?: string;

  /**
   * Localized display name
   */
  displayName?: string;

  /**
   * blob duration of shoebox log specification
   */
  blobDuration?: string;
}

/**
 * Backup resource vault config details.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupResourceVaultConfig {
  /**
   * Storage type.
   */
  storageModelType?: StorageType;

  /**
   * Storage type.
   */
  storageType?: StorageType;

  /**
   * Locked or Unlocked. Once a machine is registered against a resource, the storageTypeState is always Locked.
   */
  storageTypeState?: StorageTypeState;

  /**
   * Enabled or Disabled.
   */
  enhancedSecurityState?: EnhancedSecurityState;

  /**
   * Soft Delete feature state
   */
  softDeleteFeatureState?: SoftDeleteFeatureState;

  /**
   * Soft delete retention period in days
   */
  softDeleteRetentionPeriodInDays?: int32;

  /**
   * ResourceGuard Operation Requests
   */
  resourceGuardOperationRequests?: string[];

  /**
   * This flag is no longer in use. Please use 'softDeleteFeatureState' to set the soft delete state for the vault
   */
  isSoftDeleteFeatureStateEditable?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupResourceEncryptionConfigExtended
  extends BackupResourceEncryptionConfig {
  /**
   * User Assigned Identity Id
   */
  userAssignedIdentity?: string;

  /**
   * bool to indicate whether to use system Assigned Identity or not
   */
  useSystemAssignedIdentity?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupResourceEncryptionConfig {
  /**
   * Encryption At Rest Type
   */
  encryptionAtRestType?: EncryptionAtRestType;

  /**
   * Key Vault Key URI
   */
  keyUri?: string;

  /**
   * Key Vault Subscription Id
   */
  subscriptionId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  lastUpdateStatus?: LastUpdateStatus;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  infrastructureEncryptionState?: InfrastructureEncryptionState;
}

/**
 * Private Endpoint Connection Response Properties
 */
model PrivateEndpointConnection {
  /**
   * Gets or sets provisioning state of the private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets private endpoint associated with the private endpoint connection
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * Group Ids for the Private Endpoint
   */
  groupIds?: VaultSubResourceType[];

  /**
   * Gets or sets private link service connection state
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;
}

/**
 * The Private Endpoint network resource that is linked to the Private Endpoint connection
 */
model PrivateEndpoint {
  /**
   * Gets or sets id
   */
  id?: string;
}

/**
 * Private Link Service Connection State
 */
model PrivateLinkServiceConnectionState {
  /**
   * Gets or sets the status
   */
  status?: PrivateEndpointConnectionStatus;

  /**
   * Gets or sets description
   */
  description?: string;

  /**
   * Gets or sets actions required
   */
  actionsRequired?: string;
}

/**
 * An error response from the Container Instance service.
 */
@error
model CloudError {
  /**
   * The error object.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the Container Instance service.
 */
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * A list of additional details about the error.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["code"])
  details?: CloudErrorBody[];

  /**
   * The error additional info.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * Operation status.
 */
model OperationStatus {
  /**
   * ID of the operation.
   */
  id?: string;

  /**
   * Name of the operation.
   */
  name?: string;

  /**
   * Operation status.
   */
  status?: OperationStatusValues;

  /**
   * Operation start time. Format: ISO-8601.
   */
  startTime?: utcDateTime;

  /**
   * Operation end time. Format: ISO-8601.
   */
  endTime?: utcDateTime;

  /**
   * Error information related to this operation.
   */
  error?: OperationStatusError;

  /**
   * Additional information associated with this operation.
   */
  properties?: OperationStatusExtendedInfo;
}

/**
 * Error information associated with operation status call.
 */
model OperationStatusError {
  /**
   * Error code of the operation failure.
   */
  code?: string;

  /**
   * Error message displayed if the operation failure.
   */
  message?: string;
}

/**
 * Base class for additional information of operation status.
 */
@discriminator("objectType")
model OperationStatusExtendedInfo {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * Prepare DataMove Request
 */
model PrepareDataMoveRequest {
  /**
   * ARM Id of target vault
   */
  targetResourceId: string;

  /**
   * Target Region
   */
  targetRegion: string;

  /**
   * DataMove Level
   */
  dataMoveLevel: DataMoveLevel;

  /**
   * Source Container ArmIds
   * This needs to be populated only if DataMoveLevel is set to container
   */
  sourceContainerArmIds?: string[];

  /**
   * Ignore the artifacts which are already moved.
   */
  ignoreMoved?: boolean;
}

/**
 * Operation result response for Vault Storage Config
 */
@discriminator("objectType")
model VaultStorageConfigOperationResultResponse {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * Trigger DataMove Request
 */
model TriggerDataMoveRequest {
  /**
   * ARM Id of source vault
   */
  sourceResourceId: string;

  /**
   * Source Region
   */
  sourceRegion: string;

  /**
   * DataMove Level
   */
  dataMoveLevel: DataMoveLevel;

  /**
   * Correlation Id
   */
  correlationId: string;

  /**
   * Source Container ArmIds
   */
  sourceContainerArmIds?: string[];

  /**
   * Pause GC
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  pauseGC?: boolean;
}

/**
 * Base class for backup items.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("protectedItemType")
model ProtectedItem {
  /**
   * backup item type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protectedItemType: string;

  /**
   * Type of backup management for the backed up item.
   */
  @visibility(Lifecycle.Read)
  backupManagementType?: BackupManagementType;

  /**
   * Type of workload this item represents.
   */
  @visibility(Lifecycle.Read)
  workloadType?: DataSourceType;

  /**
   * Unique name of container
   */
  containerName?: string;

  /**
   * ARM ID of the resource to be backed up.
   */
  sourceResourceId?: string;

  /**
   * ID of the backup policy with which this item is backed up.
   */
  policyId?: string;

  /**
   * Timestamp when the last (latest) backup copy was created for this backup item.
   */
  lastRecoveryPoint?: utcDateTime;

  /**
   * Name of the backup set the backup item belongs to
   */
  backupSetName?: string;

  /**
   * Create mode to indicate recovery of existing soft deleted data source or creation of new data source.
   */
  createMode?: CreateMode;

  /**
   * Time for deferred deletion in UTC
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deferredDeleteTimeInUTC?: utcDateTime;

  /**
   * Flag to identify whether the DS is scheduled for deferred delete
   */
  isScheduledForDeferredDelete?: boolean;

  /**
   * Time remaining before the DS marked for deferred delete is permanently deleted
   */
  deferredDeleteTimeRemaining?: string;

  /**
   * Flag to identify whether the deferred deleted DS is to be purged soon
   */
  isDeferredDeleteScheduleUpcoming?: boolean;

  /**
   * Flag to identify that deferred deleted DS is to be moved into Pause state
   */
  isRehydrate?: boolean;

  /**
   * ResourceGuardOperationRequests on which LAC check will be performed
   */
  resourceGuardOperationRequests?: string[];

  /**
   * Flag to identify whether datasource is protected in archive
   */
  isArchiveEnabled?: boolean;

  /**
   * Name of the policy used for protection
   */
  policyName?: string;

  /**
   * Soft delete retention period in days
   */
  softDeleteRetentionPeriodInDays?: int32;

  /**
   * ID of the vault which protects this item
   */
  @visibility(Lifecycle.Read)
  vaultId?: string;

  /**
   * Source side threat information
   */
  @added(Versions.v2026_01_01_preview)
  sourceSideScanInfo?: SourceSideScanInfo;
}

/**
 * List of RecoveryPoint resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecoveryPointResourceList extends ResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: RecoveryPointResource[];
}

/**
 * Base class for backup copies. Workload-specific backup copies are derived from this class.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("objectType")
model RecoveryPoint {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;

  /**
   * Threat status of the recovery point
   */
  @added(Versions.v2026_01_01_preview)
  threatStatus?: ThreatStatus;

  /**
   * Recovery point threat information.
   */
  @added(Versions.v2026_01_01_preview)
  @identifiers(#[])
  threatInfo?: ThreatInfo[];
}

alias ResourceProperties = {
  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: string;
};

/**
 * Base class for restore request. Workload-specific restore requests are derived from this class.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RestoreRequestResource extends Resource {
  ...ResourceProperties;

  /**
   * RestoreRequestResource properties
   */
  properties?: RestoreRequest;
}

/**
 * Base class for restore request. Workload-specific restore requests are derived from this class.
 */
@discriminator("objectType")
model RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;

  /**
   * ResourceGuardOperationRequests on which LAC check will be performed
   */
  resourceGuardOperationRequests?: string[];
}

/**
 * List of ProtectionPolicy resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProtectionPolicyResourceList extends ResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: ProtectionPolicyResource[];
}

/**
 * Base class for backup policy. Workload-specific backup policies are derived from this class.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("backupManagementType")
model ProtectionPolicy {
  /**
   * Number of items associated with this policy.
   */
  protectedItemsCount?: int32;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  backupManagementType: string;

  /**
   * ResourceGuard Operation Requests
   */
  resourceGuardOperationRequests?: string[];
}

/**
 * List of Job resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JobResourceList extends ResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: JobResource[];
}

/**
 * Defines workload agnostic properties for a job.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("jobType")
model Job {
  /**
   * Friendly name of the entity on which the current job is executing.
   */
  entityFriendlyName?: string;

  /**
   * Backup management type to execute the current job.
   */
  backupManagementType?: BackupManagementType;

  /**
   * The operation name.
   */
  operation?: string;

  /**
   * Job status.
   */
  status?: string;

  /**
   * The start time.
   */
  startTime?: utcDateTime;

  /**
   * The end time.
   */
  endTime?: utcDateTime;

  /**
   * ActivityId of job.
   */
  activityId?: string;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  jobType: string;
}

/**
 * Base class for operation result info.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OperationResultInfoBaseResource extends OperationWorkerResponse {
  /**
   * OperationResultInfoBaseResource operation
   */
  operation?: OperationResultInfoBase;
}

/**
 * Base class for operation result info.
 */
@discriminator("objectType")
model OperationResultInfoBase {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * This is the base class for operation result responses.
 */
model OperationWorkerResponse {
  /**
   * HTTP Status Code of the operation.
   */
  statusCode?: HttpStatusCode;

  /**
   * HTTP headers associated with this operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  headers?: Record<string[]>;
}

/**
 * List of ProtectedItem resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProtectedItemResourceList extends ResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: ProtectedItemResource[];
}

/**
 * Base class for validate operation request.
 */
model ValidateOperationRequestResource {
  /**
   * Recovery point ID.
   */
  id: string;

  /**
   * ValidateOperationRequestResource properties
   */
  properties: ValidateOperationRequest;
}

/**
 * Base class for validate operation request.
 */
@discriminator("objectType")
model ValidateOperationRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ValidateOperationsResponse {
  /**
   * Base class for validate operation response.
   */
  validateOperationResponse?: ValidateOperationResponse;
}

/**
 * Base class for validate operation response.
 */
model ValidateOperationResponse {
  /**
   * Gets the validation result
   */
  @identifiers(#["code"])
  validationResults?: ErrorDetail[];
}

/**
 * Error Detail class which encapsulates Code, Message and Recommendations.
 */
model ErrorDetail {
  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Error Message related to the Code.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * List of recommendation strings.
   */
  @visibility(Lifecycle.Read)
  recommendations?: string[];
}

/**
 * List of BackupEngineBase resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupEngineBaseResourceList extends ResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: BackupEngineBaseResource[];
}

/**
 * The base backup engine class. All workload specific backup engines derive from this class.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("backupEngineType")
model BackupEngineBase {
  /**
   * Friendly name of the backup engine.
   */
  friendlyName?: string;

  /**
   * Type of backup management for the backup engine.
   */
  backupManagementType?: BackupManagementType;

  /**
   * Registration status of the backup engine with the Recovery Services Vault.
   */
  registrationStatus?: string;

  /**
   * Status of the backup engine with the Recovery Services Vault. = {Active/Deleting/DeleteFailed}
   */
  backupEngineState?: string;

  /**
   * Backup status of the backup engine.
   */
  healthStatus?: string;

  /**
   * Type of the backup engine.
   */
  backupEngineType: BackupEngineType;

  /**
   * Flag indicating if the backup engine be registered, once already registered.
   */
  canReRegister?: boolean;

  /**
   * ID of the backup engine.
   */
  backupEngineId?: string;

  /**
   * Backup engine version
   */
  dpmVersion?: string;

  /**
   * Backup agent version
   */
  azureBackupAgentVersion?: string;

  /**
   * To check if backup agent upgrade available
   */
  isAzureBackupAgentUpgradeAvailable?: boolean;

  /**
   * To check if backup engine upgrade available
   */
  isDpmUpgradeAvailable?: boolean;

  /**
   * Extended info of the backupengine
   */
  extendedInfo?: BackupEngineExtendedInfo;
}

/**
 * Additional information on backup engine.
 */
model BackupEngineExtendedInfo {
  /**
   * Database name of backup engine.
   */
  databaseName?: string;

  /**
   * Number of protected items in the backup engine.
   */
  protectedItemsCount?: int32;

  /**
   * Number of protected servers in the backup engine.
   */
  protectedServersCount?: int32;

  /**
   * Number of disks in the backup engine.
   */
  diskCount?: int32;

  /**
   * Disk space used in the backup engine.
   */
  usedDiskSpace?: float64;

  /**
   * Disk space currently available in the backup engine.
   */
  availableDiskSpace?: float64;

  /**
   * Last refresh time in the backup engine.
   */
  refreshedAt?: utcDateTime;

  /**
   * Protected instances in the backup engine.
   */
  azureProtectedInstances?: int32;
}

/**
 * List of ProtectableContainer resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProtectableContainerResourceList extends ResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: ProtectableContainerResource[];
}

/**
 * Protectable Container Class.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProtectableContainerResource extends Resource {
  ...ResourceProperties;

  /**
   * ProtectableContainerResource properties
   */
  properties?: ProtectableContainer;
}

/**
 * Protectable Container Class.
 */
@discriminator("protectableContainerType")
model ProtectableContainer {
  /**
   * Friendly name of the container.
   */
  friendlyName?: string;

  /**
   * Type of backup management for the container.
   */
  backupManagementType?: BackupManagementType;

  /**
   * Type of the container. The value of this property for
   * 1. Compute Azure VM is Microsoft.Compute/virtualMachines
   * 2. Classic Compute Azure VM is Microsoft.ClassicCompute/virtualMachines
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protectableContainerType: ProtectableContainerType;

  /**
   * Status of health of the container.
   */
  healthStatus?: string;

  /**
   * Fabric Id of the container such as ARM Id.
   */
  containerId?: string;
}

/**
 * Base class for container with backup items. Containers with specific workloads are derived from this class.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("containerType")
model ProtectionContainer {
  /**
   * Friendly name of the container.
   */
  friendlyName?: string;

  /**
   * Type of backup management for the container.
   */
  backupManagementType?: BackupManagementType;

  /**
   * Status of registration of the container with the Recovery Services Vault.
   */
  registrationStatus?: string;

  /**
   * Status of health of the container.
   */
  healthStatus?: string;

  /**
   * Type of the container. The value of this property for: 1. Compute Azure VM is Microsoft.Compute/virtualMachines 2.
   * Classic Compute Azure VM is Microsoft.ClassicCompute/virtualMachines 3. Windows machines (like MAB, DPM etc) is
   * Windows 4. Azure SQL instance is AzureSqlContainer. 5. Storage containers is StorageContainer. 6. Azure workload
   * Backup is VMAppContainer
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  containerType: ProtectableContainerType;

  /**
   * Type of the protectable object associated with this container
   */
  protectableObjectType?: string;
}

/**
 * List of WorkloadItem resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkloadItemResourceList extends ResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: WorkloadItemResource[];
}

/**
 * Base class for backup item. Workload-specific backup items are derived from this class.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkloadItemResource extends Resource {
  ...ResourceProperties;

  /**
   * WorkloadItemResource properties
   */
  properties?: WorkloadItem;
}

/**
 * Base class for backup item. Workload-specific backup items are derived from this class.
 */
@discriminator("workloadItemType")
model WorkloadItem {
  /**
   * Type of backup management to backup an item.
   */
  backupManagementType?: string;

  /**
   * Type of workload for the backup management
   */
  workloadType?: string;

  /**
   * Type of the backup item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  workloadItemType: string;

  /**
   * Friendly name of the backup item.
   */
  friendlyName?: string;

  /**
   * State of the back up item.
   */
  protectionState?: ProtectionStatus;
}

/**
 * Base class for backup request. Workload-specific backup requests are derived from this class.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupRequestResource extends Resource {
  ...ResourceProperties;

  /**
   * BackupRequestResource properties
   */
  properties?: BackupRequest;
}

/**
 * Base class for backup request. Workload-specific backup requests are derived from this class.
 */
@discriminator("objectType")
model BackupRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * Parameters to Provision ILR API.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ILRRequestResource extends Resource {
  ...ResourceProperties;

  /**
   * ILRRequestResource properties
   */
  properties?: ILRRequest;
}

/**
 * Parameters to Provision ILR API.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("objectType")
model ILRRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * List of WorkloadProtectableItem resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkloadProtectableItemResourceList extends ResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: WorkloadProtectableItemResource[];
}

/**
 * Base class for backup item. Workload-specific backup items are derived from this class.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkloadProtectableItemResource extends Resource {
  ...ResourceProperties;

  /**
   * WorkloadProtectableItemResource properties
   */
  properties?: WorkloadProtectableItem;
}

/**
 * Base class for backup item. Workload-specific backup items are derived from this class.
 */
@discriminator("protectableItemType")
model WorkloadProtectableItem {
  /**
   * Type of backup management to backup an item.
   */
  backupManagementType?: string;

  /**
   * Type of workload for the backup management
   */
  workloadType?: string;

  /**
   * Type of the backup item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protectableItemType: string;

  /**
   * Friendly name of the backup item.
   */
  friendlyName?: string;

  /**
   * State of the back up item.
   */
  protectionState?: ProtectionStatus;
}

/**
 * List of ProtectionContainer resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProtectionContainerResourceList extends ResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: ProtectionContainerResource[];
}

/**
 * Base class for get security pin request body
 */
model SecurityPinBase {
  /**
   * ResourceGuard Operation Requests
   */
  resourceGuardOperationRequests?: string[];
}

/**
 * The token information details.
 */
model TokenInformation {
  /**
   * Token value.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  token?: string;

  /**
   * Expiry time of token.
   */
  expiryTimeInUtcTicks?: int64;

  /**
   * Security PIN
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  securityPIN?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MoveRPAcrossTiersRequest {
  /**
   * Gets the class type.
   */
  objectType?: string;

  /**
   * Source tier from where RP needs to be moved
   */
  sourceTierType?: RecoveryPointTierType;

  /**
   * Target tier where RP needs to be moved
   */
  targetTierType?: RecoveryPointTierType;
}

/**
 * ListRecoveryPointsRecommendedForMoveRequest Request
 */
model ListRecoveryPointsRecommendedForMoveRequest {
  /**
   * Gets the class type.
   */
  objectType?: string;

  /**
   * List of Recovery Points excluded from Move
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  excludedRPList?: string[];
}

/**
 * List of ResourceGuardProxyBase resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceGuardProxyBaseResourceList extends ResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: ResourceGuardProxyBaseResource[];
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceGuardProxyBase {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGuardResourceId: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  resourceGuardOperationDetails?: ResourceGuardOperationDetail[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  lastUpdatedTime?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceGuardOperationDetail {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vaultCriticalOperation?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  defaultResourceRequest?: string;
}

/**
 * Request body of unlock delete API.
 */
model UnlockDeleteRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGuardOperationRequests?: string[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceToBeDeleted?: string;
}

/**
 * Response of Unlock Delete API.
 */
model UnlockDeleteResponse {
  /**
   * This is the time when unlock delete privileges will get expired.
   */
  unlockDeleteExpiryTime?: string;
}

/**
 * Patch Request content to update recovery point for given RecoveryPointId
 */
@added(Versions.v2026_01_01_preview)
model UpdateRecoveryPointRequest {
  /**
   * Resource properties.
   */
  properties?: PatchRecoveryPointInput;
}

/**
 * Recovery Point Contract for Update Recovery Point API.
 */
@added(Versions.v2026_01_01_preview)
model PatchRecoveryPointInput {
  /**
   * Properties of Recovery Point
   */
  recoveryPointProperties?: PatchRecoveryPointPropertiesInput;
}

/**
 * Recovery Point Properties Contract for Update Recovery Point API.
 */
@added(Versions.v2026_01_01_preview)
model PatchRecoveryPointPropertiesInput {
  /**
   * Expiry time of Recovery Point in UTC.
   */
  expiryTime?: utcDateTime;
}

/**
 * Base class for tiering cost request.
 * Specific cost request types are derived from this class.
 */
@discriminator("objectType")
model FetchTieringCostInfoRequest {
  /**
   * Source tier for the request
   */
  sourceTierType: RecoveryPointTierType;

  /**
   * target tier for the request
   */
  targetTierType: RecoveryPointTierType;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * Base class for tiering cost response
 */
@discriminator("objectType")
model TieringCostInfo {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * Azure File Share workload-specific backup item.
 */
model AzureFileshareProtectedItem extends ProtectedItem {
  /**
   * Friendly name of the fileshare represented by this backup item.
   */
  friendlyName?: string;

  /**
   * Backup status of this backup item.
   */
  protectionStatus?: string;

  /**
   * Backup state of this backup item.
   */
  protectionState?: ProtectionState;

  /**
   * Last backup operation status. Possible values: Healthy, Unhealthy.
   */
  lastBackupStatus?: string;

  /**
   * Timestamp of the last backup operation on this backup item.
   */
  lastBackupTime?: utcDateTime;

  /**
   * Health details of different KPIs
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kpisHealths?: Record<KPIResourceHealthDetails>;

  /**
   * Additional information with this backup item.
   */
  extendedInfo?: AzureFileshareProtectedItemExtendedInfo;

  /**
   * backup item type.
   */
  protectedItemType: "AzureFileShareProtectedItem";
}

/**
 * KPI Resource Health Details
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model KPIResourceHealthDetails {
  /**
   * Resource Health Status
   */
  resourceHealthStatus?: ResourceHealthStatus;

  /**
   * Resource Health Status
   */
  @identifiers(#["code"])
  resourceHealthDetails?: ResourceHealthDetails[];
}

/**
 * Health Details for backup items.
 */
model ResourceHealthDetails {
  /**
   * Health Code
   */
  @visibility(Lifecycle.Read)
  code?: int32;

  /**
   * Health Title
   */
  @visibility(Lifecycle.Read)
  title?: string;

  /**
   * Health Message
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Health Recommended Actions
   */
  @visibility(Lifecycle.Read)
  recommendations?: string[];
}

/**
 * Additional information about Azure File Share backup item.
 */
model AzureFileshareProtectedItemExtendedInfo {
  /**
   * The oldest backup copy available for this item in the service.
   */
  oldestRecoveryPoint?: utcDateTime;

  /**
   * Number of available backup copies associated with this backup item.
   */
  recoveryPointCount?: int32;

  /**
   * Indicates consistency of policy object and policy applied to this backup item.
   */
  policyState?: string;

  /**
   * Indicates the state of this resource. Possible values are from enum ResourceState {Invalid, Active, SoftDeleted, Deleted}
   */
  @visibility(Lifecycle.Read)
  resourceState?: string;

  /**
   * The resource state sync time for this backup item.
   */
  @visibility(Lifecycle.Read)
  resourceStateSyncTime?: utcDateTime;
}

/**
 * Azure File Share workload specific backup copy.
 */
model AzureFileShareRecoveryPoint extends RecoveryPoint {
  /**
   * Type of the backup copy. Specifies whether it is a crash consistent backup or app consistent.
   */
  recoveryPointType?: string;

  /**
   * Time at which this backup copy was created.
   */
  recoveryPointTime?: utcDateTime;

  /**
   * Contains Url to the snapshot of fileshare, if applicable
   */
  fileShareSnapshotUri?: string;

  /**
   * Contains recovery point size
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryPointSizeInGB?: int32;

  /**
   * Properties of Recovery Point
   */
  recoveryPointProperties?: RecoveryPointProperties;

  /**
   * Recovery point tier information.
   */
  @identifiers(#[])
  recoveryPointTierDetails?: RecoveryPointTierInformation[];

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureFileShareRecoveryPoint";
}

/**
 * Properties of Recovery Point
 */
model RecoveryPointProperties {
  /**
   * Expiry time of Recovery Point in UTC.
   */
  expiryTime?: string;

  /**
   * Rule name tagged on Recovery Point that governs life cycle
   */
  ruleName?: string;

  /**
   * Bool to indicate whether RP is in soft delete state or not
   */
  isSoftDeleted?: boolean;
}

/**
 * Recovery point tier information.
 */
model RecoveryPointTierInformation {
  /**
   * Recovery point tier type.
   */
  type?: RecoveryPointTierType;

  /**
   * Recovery point tier status.
   */
  status?: RecoveryPointTierStatus;

  /**
   * Recovery point tier status.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedInfo?: Record<string>;
}

/**
 * AzureFileShare Restore Request
 */
model AzureFileShareRestoreRequest extends RestoreRequest {
  /**
   * Type of this recovery.
   */
  recoveryType?: RecoveryType;

  /**
   * Source storage account ARM Id
   */
  sourceResourceId?: string;

  /**
   * Options to resolve copy conflicts.
   */
  copyOptions?: CopyOptions;

  /**
   * Restore Type (FullShareRestore or ItemLevelRestore)
   */
  restoreRequestType?: RestoreRequestType;

  /**
   * List of Source Files/Folders(which need to recover) and TargetFolderPath details
   */
  @identifiers(#[])
  restoreFileSpecs?: RestoreFileSpecs[];

  /**
   * Target File Share Details
   */
  targetDetails?: TargetAFSRestoreInfo;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureFileShareRestoreRequest";
}

/**
 * Restore file specs like file path, type and target folder path info.
 */
model RestoreFileSpecs {
  /**
   * Source File/Folder path
   */
  path?: string;

  /**
   * Indicates what the Path variable stands for
   */
  fileSpecType?: string;

  /**
   * Destination folder path in target FileShare
   */
  targetFolderPath?: string;
}

/**
 * Target Azure File Share Info.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TargetAFSRestoreInfo {
  /**
   * File share name
   */
  name?: string;

  /**
   * Target file share resource ARM ID
   */
  targetResourceId?: string;
}

/**
 * Azure VM (Mercury) workload-specific backup policy.
 */
model AzureVmWorkloadProtectionPolicy extends ProtectionPolicy {
  /**
   * Type of workload for the backup management
   */
  workLoadType?: WorkloadType;

  /**
   * Type of the protection policy
   */
  @added(Versions.v2026_01_01_preview)
  vmWorkloadPolicyType?: VMWorkloadPolicyType;

  /**
   * Common settings for the backup management
   */
  settings?: Settings;

  /**
   * List of sub-protection policies which includes schedule and retention
   */
  @identifiers(#[])
  subProtectionPolicy?: SubProtectionPolicy[];

  /**
   * Fix the policy inconsistency
   */
  makePolicyConsistent?: boolean;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  backupManagementType: "AzureWorkload";
}

/**
 * Common settings field for backup management
 */
model Settings {
  /**
   * TimeZone optional input as string. For example: TimeZone = "Pacific Standard Time".
   */
  timeZone?: string;

  /**
   * SQL compression flag
   */
  issqlcompression?: boolean;

  /**
   * Workload compression flag. This has been added so that 'isSqlCompression'
   * will be deprecated once clients upgrade to consider this flag.
   */
  isCompression?: boolean;
}

/**
 * Sub-protection policy which includes schedule and retention
 */
model SubProtectionPolicy {
  /**
   * Type of backup policy type
   */
  policyType?: PolicyType;

  /**
   * Backup schedule specified as part of backup policy.
   */
  schedulePolicy?: SchedulePolicy;

  /**
   * Retention policy with the details on backup copy retention ranges.
   */
  retentionPolicy?: RetentionPolicy;

  /**
   * Tiering policy to automatically move RPs to another tier.
   * Key is Target Tier, defined in RecoveryPointTierType enum.
   * Tiering policy specifies the criteria to move RP to the target tier.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tieringPolicy?: Record<TieringPolicy>;

  /**
   * Snapshot Backup related fields for WorkloadType SaPHanaSystem
   */
  snapshotBackupAdditionalDetails?: SnapshotBackupAdditionalDetails;
}

/**
 * Base class for backup schedule.
 */
@discriminator("schedulePolicyType")
model SchedulePolicy {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schedulePolicyType: string;
}

/**
 * Base class for retention policy.
 */
@discriminator("retentionPolicyType")
model RetentionPolicy {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  retentionPolicyType: string;
}

/**
 * Tiering Policy for a target tier.
 * If the policy is not specified for a given target tier, service retains the existing configured tiering policy for that tier
 */
model TieringPolicy {
  /**
   * Tiering Mode to control automatic tiering of recovery points. Supported values are:
   * 1. TierRecommended: Tier all recovery points recommended to be tiered
   * 2. TierAfter: Tier all recovery points after a fixed period, as specified in duration + durationType below.
   * 3. DoNotTier: Do not tier any recovery points
   */
  tieringMode?: TieringMode;

  /**
   * Number of days/weeks/months/years to retain backups in current tier before tiering.
   * Used only if TieringMode is set to TierAfter
   */
  duration?: int32;

  /**
   * Retention duration type: days/weeks/months/years
   * Used only if TieringMode is set to TierAfter
   */
  durationType?: RetentionDurationType;
}

/**
 * Snapshot Backup related fields for WorkloadType SaPHanaSystem
 */
model SnapshotBackupAdditionalDetails {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instantRpRetentionRangeInDays?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instantRPDetails?: string;

  /**
   * User assigned managed identity details
   */
  userAssignedManagedIdentityDetails?: UserAssignedManagedIdentityDetails;
}

/**
 * User assigned managed identity details
 */
model UserAssignedManagedIdentityDetails {
  /**
   * The ARM id of the assigned identity.
   */
  identityArmId?: string;

  /**
   * The name of the assigned identity.
   */
  identityName?: string;

  /**
   * User assigned managed identity properties
   */
  userAssignedIdentityProperties?: UserAssignedIdentityProperties;
}

/**
 * User assigned managed identity properties
 */
model UserAssignedIdentityProperties {
  /**
   * The client ID of the assigned identity.
   */
  clientId?: string;

  /**
   * The principal ID of the assigned identity.
   */
  principalId?: string;
}

/**
 * AzureStorage backup policy.
 */
model AzureFileShareProtectionPolicy extends ProtectionPolicy {
  /**
   * Type of workload for the backup management
   */
  workLoadType?: WorkloadType;

  /**
   * Backup schedule specified as part of backup policy.
   */
  schedulePolicy?: SchedulePolicy;

  /**
   * Retention policy with the details on backup copy retention ranges.
   */
  retentionPolicy?: RetentionPolicy;

  /**
   * Retention policy with the details on hardened backup copy retention ranges.
   */
  vaultRetentionPolicy?: VaultRetentionPolicy;

  /**
   * TimeZone optional input as string. For example: TimeZone = "Pacific Standard Time".
   */
  timeZone?: string;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  backupManagementType: "AzureStorage";
}

/**
 * Vault retention policy for AzureFileShare
 */
model VaultRetentionPolicy {
  /**
   * Base class for retention policy.
   */
  vaultRetention: RetentionPolicy;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  snapshotRetentionInDays: int32;
}

/**
 * IaaS VM workload-specific backup item representing the Classic Compute VM.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureIaaSClassicComputeVMProtectedItem extends ProtectedItem {
  /**
   * backup item type.
   */
  protectedItemType: "Microsoft.ClassicCompute/virtualMachines";

  ...AzureIaaSVMProtectedItemProperties;
}

alias AzureIaaSVMProtectedItemProperties = {
  /**
   * Friendly name of the VM represented by this backup item.
   */
  @visibility(Lifecycle.Read)
  friendlyName?: string;

  /**
   * Fully qualified ARM ID of the virtual machine represented by this item.
   */
  @visibility(Lifecycle.Read)
  virtualMachineId?: string;

  /**
   * Backup status of this backup item.
   */
  protectionStatus?: string;

  /**
   * Backup state of this backup item.
   */
  protectionState?: ProtectionState;

  /**
   * Health status of protected item.
   */
  @visibility(Lifecycle.Read)
  healthStatus?: HealthStatus;

  /**
   * Health details on this backup item.
   */
  @identifiers(#["code"])
  healthDetails?: AzureIaaSVMHealthDetails[];

  /**
   * Health details of different KPIs
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kpisHealths?: Record<KPIResourceHealthDetails>;

  /**
   * Last backup operation status.
   */
  lastBackupStatus?: string;

  /**
   * Timestamp of the last backup operation on this backup item.
   */
  @visibility(Lifecycle.Read)
  lastBackupTime?: utcDateTime;

  /**
   * Data ID of the protected item.
   */
  @visibility(Lifecycle.Read)
  protectedItemDataId?: string;

  /**
   * Additional information for this backup item.
   */
  extendedInfo?: AzureIaaSVMProtectedItemExtendedInfo;

  /**
   * Extended Properties for Azure IaasVM Backup.
   */
  extendedProperties?: ExtendedProperties;

  /**
   * Type of the policy used for protection
   */
  @visibility(Lifecycle.Read)
  policyType?: string;
};

/**
 * IaaS VM workload-specific backup item.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureIaaSVMProtectedItem extends ProtectedItem {
  /**
   * backup item type.
   */
  protectedItemType: "AzureIaaSVMProtectedItem";

  ...AzureIaaSVMProtectedItemProperties;
}

/**
 * Azure IaaS VM workload-specific Health Details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureIaaSVMHealthDetails extends ResourceHealthDetails {}

/**
 * Additional information on Azure IaaS VM specific backup item.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureIaaSVMProtectedItemExtendedInfo {
  /**
   * The oldest backup copy available for this backup item across all tiers.
   */
  oldestRecoveryPoint?: utcDateTime;

  /**
   * The oldest backup copy available for this backup item in vault tier
   */
  oldestRecoveryPointInVault?: utcDateTime;

  /**
   * The oldest backup copy available for this backup item in archive tier
   */
  oldestRecoveryPointInArchive?: utcDateTime;

  /**
   * The latest backup copy available for this backup item in archive tier
   */
  newestRecoveryPointInArchive?: utcDateTime;

  /**
   * Number of backup copies available for this backup item.
   */
  recoveryPointCount?: int32;

  /**
   * Specifies if backup policy associated with the backup item is inconsistent.
   */
  policyInconsistent?: boolean;
}

/**
 * Extended Properties for Azure IaasVM Backup.
 */
model ExtendedProperties {
  /**
   * Extended Properties for Disk Exclusion.
   */
  diskExclusionProperties?: DiskExclusionProperties;

  /**
   * Linux VM name
   */
  linuxVmApplicationName?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DiskExclusionProperties {
  /**
   * List of Disks' Logical Unit Numbers (LUN) to be used for VM Protection.
   */
  diskLunList?: int32[];

  /**
   * Flag to indicate whether DiskLunList is to be included/ excluded from backup.
   */
  isInclusionList?: boolean;
}

/**
 * IaaS VM workload-specific backup item representing the Azure Resource Manager VM.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureIaaSComputeVMProtectedItem extends ProtectedItem {
  /**
   * backup item type.
   */
  protectedItemType: "Microsoft.Compute/virtualMachines";

  ...AzureIaaSVMProtectedItemProperties;
}

/**
 * Azure IaaS VM workload-specific error information.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureIaaSVMErrorInfo {
  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: int32;

  /**
   * Title: Typically, the entity that the error pertains to.
   */
  @visibility(Lifecycle.Read)
  errorTitle?: string;

  /**
   * Localized error string.
   */
  @visibility(Lifecycle.Read)
  errorString?: string;

  /**
   * List of localized recommendations for above error code.
   */
  @visibility(Lifecycle.Read)
  recommendations?: string[];
}

/**
 * Azure IaaS VM workload-specific job object.
 */
model AzureIaaSVMJob extends Job {
  /**
   * Time elapsed during the execution of this job.
   */
  duration?: duration;

  /**
   * Gets or sets the state/actions applicable on this job like cancel/retry.
   */
  actionsInfo?: JobSupportedAction[];

  /**
   * Error details on execution of this job.
   */
  @identifiers(#["errorCode"])
  errorDetails?: AzureIaaSVMErrorInfo[];

  /**
   * Specifies whether the backup item is a Classic or an Azure Resource Manager VM.
   */
  virtualMachineVersion?: string;

  /**
   * Additional information for this job.
   */
  extendedInfo?: AzureIaaSVMJobExtendedInfo;

  /**
   * Container name of the entity on which the current job is executing.
   */
  containerName?: string;

  /**
   * Indicated that whether the job is adhoc(true) or scheduled(false)
   */
  isUserTriggered?: boolean;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  jobType: "AzureIaaSVMJob";
}

/**
 * Azure IaaS VM workload-specific additional information for job.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureIaaSVMJobExtendedInfo {
  /**
   * List of tasks associated with this job.
   */
  @identifiers(#["taskId"])
  tasksList?: AzureIaaSVMJobTaskDetails[];

  /**
   * Job properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  propertyBag?: Record<string>;

  /**
   * Job internal properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  internalPropertyBag?: Record<string>;

  /**
   * Indicates progress of the job. Null if it has not started or completed.
   */
  progressPercentage?: float64;

  /**
   * Time remaining for execution of this job.
   */
  estimatedRemainingDuration?: string;

  /**
   * Non localized error message on job execution.
   */
  dynamicErrorMessage?: string;
}

/**
 * Azure IaaS VM workload-specific job task details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureIaaSVMJobTaskDetails {
  /**
   * The task display name.
   */
  taskId?: string;

  /**
   * The start time.
   */
  startTime?: utcDateTime;

  /**
   * The end time.
   */
  endTime?: utcDateTime;

  /**
   * The instanceId.
   */
  instanceId?: string;

  /**
   * Time elapsed for task.
   */
  duration?: duration;

  /**
   * The status.
   */
  status?: string;

  /**
   * Progress of the task.
   */
  progressPercentage?: float64;

  /**
   * Details about execution of the task.
   * eg: number of bytes transferred etc
   */
  taskExecutionDetails?: string;
}

/**
 * Azure IaaS VM workload-specific job object.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureIaaSVMJobV2 extends Job {
  /**
   * Gets or sets the state/actions applicable on this job like cancel/retry.
   */
  actionsInfo?: JobSupportedAction[];

  /**
   * Container name of the entity on which the current job is executing.
   */
  containerName?: string;

  /**
   * Time elapsed during the execution of this job.
   */
  duration?: duration;

  /**
   * Error details on execution of this job.
   */
  @identifiers(#["errorCode"])
  errorDetails?: AzureIaaSVMErrorInfo[];

  /**
   * Specifies whether the backup item is a Classic or an Azure Resource Manager VM.
   */
  virtualMachineVersion?: string;

  /**
   * Additional information for this job.
   */
  extendedInfo?: AzureIaaSVMJobExtendedInfo;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  jobType: "AzureIaaSVMJobV2";
}

/**
 * IaaS VM workload-specific backup policy.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureIaaSVMProtectionPolicy extends ProtectionPolicy {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instantRPDetails?: InstantRPAdditionalDetails;

  /**
   * Backup schedule specified as part of backup policy.
   */
  schedulePolicy?: SchedulePolicy;

  /**
   * Retention policy with the details on backup copy retention ranges.
   */
  retentionPolicy?: RetentionPolicy;

  /**
   * Tiering policy to automatically move RPs to another tier
   * Key is Target Tier, defined in RecoveryPointTierType enum.
   * Tiering policy specifies the criteria to move RP to the target tier.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tieringPolicy?: Record<TieringPolicy>;

  /**
   * Instant RP retention policy range in days
   */
  instantRpRetentionRangeInDays?: int32;

  /**
   * TimeZone optional input as string. For example: TimeZone = "Pacific Standard Time".
   */
  timeZone?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  policyType?: IAASVMPolicyType;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  snapshotConsistencyType?: IaasVMSnapshotConsistencyType;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  backupManagementType: "AzureIaasVM";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InstantRPAdditionalDetails {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureBackupRGNamePrefix?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureBackupRGNameSuffix?: string;
}

/**
 * Azure SQL workload-specific backup item.
 */
model AzureSqlProtectedItem extends ProtectedItem {
  /**
   * Internal ID of a backup item. Used by Azure SQL Backup engine to contact Recovery Services.
   */
  protectedItemDataId?: string;

  /**
   * Backup state of the backed up item.
   */
  protectionState?: ProtectedItemState;

  /**
   * Additional information for this backup item.
   */
  extendedInfo?: AzureSqlProtectedItemExtendedInfo;

  /**
   * backup item type.
   */
  protectedItemType: "Microsoft.Sql/servers/databases";
}

/**
 * Additional information on Azure Sql specific protected item.
 */
model AzureSqlProtectedItemExtendedInfo {
  /**
   * The oldest backup copy available for this item in the service.
   */
  oldestRecoveryPoint?: utcDateTime;

  /**
   * Number of available backup copies associated with this backup item.
   */
  recoveryPointCount?: int32;

  /**
   * State of the backup policy associated with this backup item.
   */
  policyState?: string;
}

/**
 * Azure storage specific error information
 */
model AzureStorageErrorInfo {
  /**
   * Error code.
   */
  errorCode?: int32;

  /**
   * Localized error string.
   */
  errorString?: string;

  /**
   * List of localized recommendations for above error code.
   */
  recommendations?: string[];
}

/**
 * Azure SQL workload-specific backup policy.
 */
model AzureSqlProtectionPolicy extends ProtectionPolicy {
  /**
   * Retention policy details.
   */
  retentionPolicy?: RetentionPolicy;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  backupManagementType: "AzureSql";
}

/**
 * Azure storage specific job.
 */
model AzureStorageJob extends Job {
  /**
   * Time elapsed during the execution of this job.
   */
  duration?: duration;

  /**
   * Gets or sets the state/actions applicable on this job like cancel/retry.
   */
  actionsInfo?: JobSupportedAction[];

  /**
   * Error details on execution of this job.
   */
  @identifiers(#["errorCode"])
  errorDetails?: AzureStorageErrorInfo[];

  /**
   * Specifies friendly name of the storage account.
   */
  storageAccountName?: string;

  /**
   * Specifies whether the Storage account is a Classic or an Azure Resource Manager Storage account.
   */
  storageAccountVersion?: string;

  /**
   * Additional information about the job.
   */
  extendedInfo?: AzureStorageJobExtendedInfo;

  /**
   * Indicated that whether the job is adhoc(true) or scheduled(false)
   */
  isUserTriggered?: boolean;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  jobType: "AzureStorageJob";
}

/**
 * Azure Storage workload-specific additional information for job.
 */
model AzureStorageJobExtendedInfo {
  /**
   * List of tasks for this job
   */
  @identifiers(#["taskId"])
  tasksList?: AzureStorageJobTaskDetails[];

  /**
   * Job properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  propertyBag?: Record<string>;

  /**
   * Non localized error message on job execution.
   */
  dynamicErrorMessage?: string;
}

/**
 * Azure storage workload specific job task details.
 */
model AzureStorageJobTaskDetails {
  /**
   * The task display name.
   */
  taskId?: string;

  /**
   * The status.
   */
  status?: string;
}

alias AzureVmWorkloadProtectedItemProperties = {
  /**
   * Friendly name of the DB represented by this backup item.
   */
  @visibility(Lifecycle.Read)
  friendlyName?: string;

  /**
   * Host/Cluster Name for instance or AG
   */
  serverName?: string;

  /**
   * Parent name of the DB such as Instance or Availability Group.
   */
  parentName?: string;

  /**
   * Parent type of protected item, example: for a DB, standalone server or distributed
   */
  parentType?: string;

  /**
   * Backup status of this backup item.
   */
  @visibility(Lifecycle.Read)
  protectionStatus?: string;

  /**
   * Backup state of this backup item.
   */
  protectionState?: ProtectionState;

  /**
   * Last backup operation status. Possible values: Healthy, Unhealthy.
   */
  lastBackupStatus?: LastBackupStatus;

  /**
   * Timestamp of the last backup operation on this backup item.
   */
  lastBackupTime?: utcDateTime;

  /**
   * Error details in last backup
   */
  lastBackupErrorDetail?: ErrorDetail;

  /**
   * Data ID of the protected item.
   */
  protectedItemDataSourceId?: string;

  /**
   * Health status of the backup item, evaluated based on last heartbeat received
   */
  protectedItemHealthStatus?: ProtectedItemHealthStatus;

  /**
   * Additional information for this backup item.
   */
  extendedInfo?: AzureVmWorkloadProtectedItemExtendedInfo;

  /**
   * Health details of different KPIs
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kpisHealths?: Record<KPIResourceHealthDetails>;

  /**
   * List of the nodes in case of distributed container.
   */
  @identifiers(#[])
  nodesList?: DistributedNodesInfo[];
};
/**
 * Azure VM workload-specific protected item.
 */
model AzureVmWorkloadProtectedItem extends ProtectedItem {
  /**
   * backup item type.
   */
  protectedItemType: "AzureVmWorkloadProtectedItem";

  ...AzureVmWorkloadProtectedItemProperties;
}

/**
 * Additional information on Azure Workload for SQL specific backup item.
 */
model AzureVmWorkloadProtectedItemExtendedInfo {
  /**
   * The oldest backup copy available for this backup item across all tiers.
   */
  oldestRecoveryPoint?: utcDateTime;

  /**
   * The oldest backup copy available for this backup item in vault tier
   */
  oldestRecoveryPointInVault?: utcDateTime;

  /**
   * The oldest backup copy available for this backup item in archive tier
   */
  oldestRecoveryPointInArchive?: utcDateTime;

  /**
   * The latest backup copy available for this backup item in archive tier
   */
  newestRecoveryPointInArchive?: utcDateTime;

  /**
   * Number of backup copies available for this backup item.
   */
  recoveryPointCount?: int32;

  /**
   * Indicates consistency of policy object and policy applied to this backup item.
   */
  policyState?: string;

  /**
   * Indicates consistency of policy object and policy applied to this backup item.
   */
  recoveryModel?: string;
}

/**
 * This is used to represent the various nodes of the distributed container.
 */
model DistributedNodesInfo {
  /**
   * Name of the node under a distributed container.
   */
  nodeName?: string;

  /**
   * Status of this Node.
   * Failed | Succeeded
   */
  status?: string;

  /**
   * Error Details if the Status is non-success.
   */
  errorDetail?: ErrorDetail;

  /**
   * ARM resource id of the node
   */
  sourceResourceId?: string;
}

/**
 * Azure VM workload-specific protected item representing SAP ASE Database.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSAPAseDatabaseProtectedItem extends ProtectedItem {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  protectedItemType: "AzureVmWorkloadSAPAseDatabase";

  ...AzureVmWorkloadProtectedItemProperties;
}

/**
 * Azure VM workload-specific protected item representing SAP HANA Database.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSAPHanaDatabaseProtectedItem extends ProtectedItem {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  protectedItemType: "AzureVmWorkloadSAPHanaDatabase";

  ...AzureVmWorkloadProtectedItemProperties;
}

/**
 * Azure VM workload-specific protected item representing SAP HANA DBInstance.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSAPHanaDBInstanceProtectedItem extends ProtectedItem {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  protectedItemType: "AzureVmWorkloadSAPHanaDBInstance";

  ...AzureVmWorkloadProtectedItemProperties;
}

/**
 * Azure VM workload-specific protected item representing SQL Database.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSQLDatabaseProtectedItem extends ProtectedItem {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  protectedItemType: "AzureVmWorkloadSQLDatabase";

  ...AzureVmWorkloadProtectedItemProperties;

  /**
   * Parent Protected item in case protected as part of a parent.
   */
  @added(Versions.v2026_01_01_preview)
  parentProtectedItem?: string;

  /**
   * Protection type in case protected as part of a parent.
   */
  @added(Versions.v2026_01_01_preview)
  protectionLevel?: ProtectionLevel;
}

/**
 * Azure VM workload-specific protected item representing SQL Instance.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2026_01_01_preview)
model AzureVmWorkloadSQLInstanceProtectedItem extends ProtectedItem {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  protectedItemType: "AzureVmWorkloadSQLInstance";

  ...AzureVmWorkloadProtectedItemProperties;

  /**
   * Name of Child Dbs protected under this parent.
   */
  childDBNames?: string[];

  /**
   * The state of instance protection.
   */
  instanceProtectionReadiness?: InstanceProtectionReadiness;
}

/**
 * Azure storage specific error information
 */
model AzureWorkloadErrorInfo {
  /**
   * Error code.
   */
  errorCode?: int32;

  /**
   * Localized error string.
   */
  errorString?: string;

  /**
   * Title: Typically, the entity that the error pertains to.
   */
  errorTitle?: string;

  /**
   * List of localized recommendations for above error code.
   */
  recommendations?: string[];

  /**
   * Additional details for above error code.
   */
  additionalDetails?: string;
}

/**
 * Azure storage specific job.
 */
model AzureWorkloadJob extends Job {
  /**
   * Workload type of the job
   */
  workloadType?: string;

  /**
   * Time elapsed during the execution of this job.
   */
  duration?: duration;

  /**
   * Gets or sets the state/actions applicable on this job like cancel/retry.
   */
  actionsInfo?: JobSupportedAction[];

  /**
   * Error details on execution of this job.
   */
  @identifiers(#["errorCode"])
  errorDetails?: AzureWorkloadErrorInfo[];

  /**
   * Additional information about the job.
   */
  extendedInfo?: AzureWorkloadJobExtendedInfo;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  jobType: "AzureWorkloadJob";
}

/**
 * Azure VM workload-specific additional information for job.
 */
model AzureWorkloadJobExtendedInfo {
  /**
   * List of tasks for this job
   */
  @identifiers(#["taskId"])
  tasksList?: AzureWorkloadJobTaskDetails[];

  /**
   * Job properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  propertyBag?: Record<string>;

  /**
   * Non localized error message on job execution.
   */
  dynamicErrorMessage?: string;
}

/**
 * Azure VM workload specific job task details.
 */
model AzureWorkloadJobTaskDetails {
  /**
   * The task display name.
   */
  taskId?: string;

  /**

   * The status.
   */
  status?: string;
}

alias AzureWorkloadPointInTimeRecoveryPointProperties = {
  /**
   * List of log ranges
   */
  @identifiers(#[])
  timeRanges?: PointInTimeRange[];
};

/**
 * Recovery point specific to PointInTime
 */
model AzureWorkloadPointInTimeRecoveryPoint extends RecoveryPoint {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadPointInTimeRecoveryPoint";

  ...AzureWorkloadRecoveryPointProperties;
  ...AzureWorkloadPointInTimeRecoveryPointProperties;
}

/**
 * Provides details for log ranges
 */
model PointInTimeRange {
  /**
   * Start time of the time range for log recovery.
   */
  startTime?: utcDateTime;

  /**
   * End time of the time range for log recovery.
   */
  endTime?: utcDateTime;
}

alias AzureWorkloadRecoveryPointProperties = {
  /**
   * UTC time at which recovery point was created
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryPointTimeInUTC?: utcDateTime;

  /**
   * Type of restore point
   */
  type?: RestorePointType;

  /**
   * Recovery point tier information.
   */
  @identifiers(#[])
  recoveryPointTierDetails?: RecoveryPointTierInformationV2[];

  /**
   * Eligibility of RP to be moved to another tier
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryPointMoveReadinessInfo?: Record<RecoveryPointMoveReadinessInfo>;

  /**
   * Properties of Recovery Point
   */
  recoveryPointProperties?: RecoveryPointProperties;
};

/**
 * Workload specific recovery point, specifically encapsulates full/diff recovery point
 */
model AzureWorkloadRecoveryPoint extends RecoveryPoint {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadRecoveryPoint";

  ...AzureWorkloadRecoveryPointProperties;
}

/**
 * RecoveryPoint Tier Information V2
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecoveryPointTierInformationV2 extends RecoveryPointTierInformation {
  /**
   * Recovery point tier type.
   */
  type?: RecoveryPointTierType;

  /**
   * Recovery point tier status.
   */
  status?: RecoveryPointTierStatus;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecoveryPointMoveReadinessInfo {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isReadyForMove?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalInfo?: string;
}

/**
 * AzureWorkload SAP Hana -specific restore. Specifically for PointInTime/Log restore
 */
model AzureWorkloadPointInTimeRestoreRequest extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadPointInTimeRestoreRequest";

  /**
   * PointInTime value
   */
  pointInTime?: utcDateTime;

  ...AzureWorkloadRestoreRequestProperties;
}

alias AzureWorkloadRestoreRequestProperties = {
  /**
   * Type of this recovery.
   */
  recoveryType?: RecoveryType;

  /**
   * Fully qualified ARM ID of the VM on which workload that was running is being recovered.
   */
  sourceResourceId?: string;

  /**
   * Workload specific property bag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  propertyBag?: Record<string>;

  /**
   * Details of target database
   */
  targetInfo?: TargetRestoreInfo;

  /**
   * Defines whether the current recovery mode is file restore or database restore
   */
  recoveryMode?: RecoveryMode;

  /**
   * Defines the Resource group of the Target VM
   */
  targetResourceGroupName?: string;

  /**
   * User Assigned managed identity details
   * Currently used for snapshot.
   */
  userAssignedManagedIdentityDetails?: UserAssignedManagedIdentityDetails;

  /**
   * Additional details for snapshot recovery
   * Currently used for snapshot for SAP Hana.
   */
  snapshotRestoreParameters?: SnapshotRestoreParameters;

  /**
   * This is the complete ARM Id of the target VM
   * For e.g. /subscriptions/{subId}/resourcegroups/{rg}/provider/Microsoft.Compute/virtualmachines/{vm}
   */
  targetVirtualMachineId?: string;
};

/**
 * AzureWorkload-specific restore.
 */
model AzureWorkloadRestoreRequest extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadRestoreRequest";

  ...AzureWorkloadRestoreRequestProperties;
}

/**
 * Details about target workload during restore operation.
 */
model TargetRestoreInfo {
  /**
   * Can Overwrite if Target DataBase already exists
   */
  overwriteOption?: OverwriteOptions;

  /**
   * Resource Id name of the container in which Target DataBase resides
   */
  containerId?: string;

  /**
   * Database name InstanceName/DataBaseName for SQL or System/DbName for SAP Hana
   */
  databaseName?: string;

  /**
   * Target directory location for restore as files.
   */
  targetDirectoryForFileRestore?: string;
}

/**
 * Encapsulates information regarding snapshot recovery for SAP Hana
 */
model SnapshotRestoreParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  skipAttachAndMount?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  logPointInTimeForDBRecovery?: string;
}

/**
 * Recovery point specific to PointInTime in SAPHana
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWorkloadSAPHanaPointInTimeRecoveryPoint extends RecoveryPoint {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSAPHanaPointInTimeRecoveryPoint";

  ...AzureWorkloadRecoveryPointProperties;
  ...AzureWorkloadPointInTimeRecoveryPointProperties;
}

alias AzureWorkloadSAPHanaPointInTimeRestoreRequestProperties = {
  /**
   * PointInTime value
   */
  pointInTime?: utcDateTime;
};

/**
 * AzureWorkload SAP Hana -specific restore. Specifically for PointInTime/Log restore
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWorkloadSAPHanaPointInTimeRestoreRequest extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSAPHanaPointInTimeRestoreRequest";

  ...AzureWorkloadSAPHanaPointInTimeRestoreRequestProperties;
  ...AzureWorkloadRestoreRequestProperties;
}

/**
 * AzureWorkload SAP Hana-specific restore.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWorkloadSAPHanaRestoreRequest extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSAPHanaRestoreRequest";

  ...AzureWorkloadRestoreRequestProperties;
}

/**
 * SAPHana specific recoverypoint, specifically encapsulates full/diff recoverypoints
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWorkloadSAPHanaRecoveryPoint extends RecoveryPoint {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSAPHanaRecoveryPoint";

  ...AzureWorkloadRecoveryPointProperties;
}

/**
 * Recovery point specific to PointInTime in SAPAse
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWorkloadSAPAsePointInTimeRecoveryPoint extends RecoveryPoint {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSAPAsePointInTimeRecoveryPoint";

  ...AzureWorkloadRecoveryPointProperties;
  ...AzureWorkloadPointInTimeRecoveryPointProperties;
}

/**
 * AzureWorkload SAP Ase-specific restore. Specifically for PointInTime/Log restore
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWorkloadSAPAsePointInTimeRestoreRequest extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSAPAsePointInTimeRestoreRequest";

  /**
   * PointInTime value
   */
  pointInTime?: utcDateTime;

  ...AzureWorkloadRestoreRequestProperties;
}

/**
 * AzureWorkload SAP Ase-specific restore.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWorkloadSAPAseRestoreRequest extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSAPAseRestoreRequest";

  ...AzureWorkloadRestoreRequestProperties;
}

/**
 * SAPAse specific recoverypoint, specifically encapsulates full/diff recoverypoints
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWorkloadSAPAseRecoveryPoint extends RecoveryPoint {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSAPAseRecoveryPoint";

  ...AzureWorkloadRecoveryPointProperties;
}

/**
 * Recovery point specific to PointInTime
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWorkloadSQLPointInTimeRecoveryPoint extends RecoveryPoint {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSQLPointInTimeRecoveryPoint";

  /**
   * List of log ranges
   */
  @identifiers(#[])
  timeRanges?: PointInTimeRange[];

  ...AzureWorkloadSQLRecoveryPointProperties;
  ...AzureWorkloadRecoveryPointProperties;
}

alias AzureWorkloadSQLRecoveryPointProperties = {
  /**
   * Extended Info that provides data directory details. Will be populated in two cases:
   * When a specific recovery point is accessed using GetRecoveryPoint
   * Or when ListRecoveryPoints is called for Log RP only with ExtendedInfo query filter
   */
  extendedInfo?: AzureWorkloadSQLRecoveryPointExtendedInfo;
};

/**
 * SQL specific recoverypoint, specifically encapsulates full/diff recoverypoint along with extended info
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWorkloadSQLRecoveryPoint extends RecoveryPoint {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSQLRecoveryPoint";

  ...AzureWorkloadSQLRecoveryPointProperties;
  ...AzureWorkloadRecoveryPointProperties;
}

/**
 * Extended info class details
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWorkloadSQLRecoveryPointExtendedInfo {
  /**
   * UTC time at which data directory info was captured
   */
  dataDirectoryTimeInUTC?: utcDateTime;

  /**
   * List of data directory paths during restore operation.
   */
  @identifiers(#[])
  dataDirectoryPaths?: SQLDataDirectory[];

  /**
   * List of databases included in recovery point.
   */
  @added(Versions.v2026_01_01_preview)
  @identifiers(#[])
  includedDatabases?: DatabaseInRP[];
}

/**
 * SQLDataDirectory info
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SQLDataDirectory {
  /**
   * Type of data directory mapping
   */
  type?: SQLDataDirectoryType;

  /**
   * File path
   */
  path?: string;

  /**
   * Logical name of the file
   */
  logicalName?: string;
}

alias AzureWorkloadSQLPointInTimeRestoreRequestProperties = {
  /**
   * PointInTime value
   */
  pointInTime?: utcDateTime;
};

/**
 * AzureWorkload SQL -specific restore. Specifically for PointInTime/Log restore
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWorkloadSQLPointInTimeRestoreRequest extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSQLPointInTimeRestoreRequest";

  ...AzureWorkloadSQLPointInTimeRestoreRequestProperties;
  ...AzureWorkloadSQLRestoreRequestProperties;
  ...AzureWorkloadRestoreRequestProperties;
}

alias AzureWorkloadSQLRestoreRequestProperties = {
  /**
   * Default option set to true. If this is set to false, alternate data directory must be provided
   */
  shouldUseAlternateTargetLocation?: boolean;

  /**
   * SQL specific property where user can chose to set no-recovery when restore operation is tried
   */
  isNonRecoverable?: boolean;

  /**
   * Data directory details
   */
  @identifiers(#[])
  alternateDirectoryPaths?: SQLDataDirectoryMapping[];
};

/**
 * AzureWorkload SQL -specific restore. Specifically for full/diff restore
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWorkloadSQLRestoreRequest extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSQLRestoreRequest";

  ...AzureWorkloadSQLRestoreRequestProperties;
  ...AzureWorkloadRestoreRequestProperties;
}

/**
 * Encapsulates information regarding data directory
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SQLDataDirectoryMapping {
  /**
   * Type of data directory mapping
   */
  mappingType?: SQLDataDirectoryType;

  /**
   * Restore source logical name path
   */
  sourceLogicalName?: string;

  /**
   * Restore source path
   */
  sourcePath?: string;

  /**
   * Target path
   */
  targetPath?: string;
}

/**
 * BEK is bitlocker encryption key.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BEKDetails {
  /**
   * Secret is BEK.
   */
  secretUrl?: string;

  /**
   * ID of the Key Vault where this Secret is stored.
   */
  secretVaultId?: string;

  /**
   * BEK data.
   */
  secretData?: string;
}

/**
 * Filters to list backup copies.
 */
model BmsrpQueryObject {
  /**
   * Backup copies created after this time.
   */
  startDate?: utcDateTime;

  /**
   * Backup copies created before this time.
   */
  endDate?: utcDateTime;

  /**
   * RestorePoint type
   */
  restorePointQueryType?: RestorePointQueryType;

  /**
   * In Get Recovery Point, it tells whether extended information about recovery point is asked.
   */
  extendedInfo?: boolean;

  /**
   * Whether the RP can be moved to another tier
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  moveReadyRPOnly?: boolean;

  /**
   * Flag to indicate whether Soft Deleted RPs should be included/excluded from result.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  includeSoftDeletedRP?: boolean;

  /**
   * Id of the base snapshot recovery point.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2026_01_01_preview)
  baseSnapshotRPId?: string;

  /**
   * Id of the datasource of the base snapshot recovery point.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2026_01_01_preview)
  baseRPDatasourceId?: string;

  /**
   * Flag to indicate whether to get only the latest recovery point.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2026_01_01_preview)
  getLatestRPOnly?: boolean;
}

/**
 * Disk information
 */
model DiskInformation {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  lun?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;
}

/**
 * Daily retention format.
 */
model DailyRetentionFormat {
  /**
   * List of days of the month.
   */
  @identifiers(#[])
  daysOfTheMonth?: Day[];
}

/**
 * Day of the week.
 */
model Day {
  /**
   * Date of the month
   */
  date?: int32;

  /**
   * Whether Date is last date of month
   */
  isLast?: boolean;
}

/**
 * Daily retention schedule.
 */
model DailyRetentionSchedule {
  /**
   * Retention times of retention policy.
   */
  retentionTimes?: utcDateTime[];

  /**
   * Retention duration of retention Policy.
   */
  retentionDuration?: RetentionDuration;
}

/**
 * Retention duration.
 */
model RetentionDuration {
  /**
   * Count of duration types. Retention duration is obtained by the counting the duration type Count times.
   * For example, when Count = 3 and DurationType = Weeks, retention duration will be three weeks.
   */
  count?: int32;

  /**
   * Retention duration type of retention policy.
   */
  durationType?: RetentionDurationType;
}

/**
 * DPM workload-specific error information.
 */
model DpmErrorInfo {
  /**
   * Localized error string.
   */
  errorString?: string;

  /**
   * List of localized recommendations for above error code.
   */
  recommendations?: string[];
}

/**
 * DPM workload-specific job object.
 */
model DpmJob extends Job {
  /**
   * Time elapsed for job.
   */
  duration?: duration;

  /**
   * DPM server name managing the backup item or backup job.
   */
  dpmServerName?: string;

  /**
   * Name of cluster/server protecting current backup item, if any.
   */
  containerName?: string;

  /**
   * Type of container.
   */
  containerType?: string;

  /**
   * Type of backup item.
   */
  workloadType?: string;

  /**
   * The state/actions applicable on this job like cancel/retry.
   */
  actionsInfo?: JobSupportedAction[];

  /**
   * The errors.
   */
  @identifiers(#[])
  errorDetails?: DpmErrorInfo[];

  /**
   * Additional information for this job.
   */
  extendedInfo?: DpmJobExtendedInfo;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  jobType: "DpmJob";
}

/**
 * Additional information on the DPM workload-specific job.
 */
model DpmJobExtendedInfo {
  /**
   * List of tasks associated with this job.
   */
  @identifiers(#["taskId"])
  tasksList?: DpmJobTaskDetails[];

  /**
   * The job properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  propertyBag?: Record<string>;

  /**
   * Non localized error message on job execution.
   */
  dynamicErrorMessage?: string;
}

/**
 * DPM workload-specific job task details.
 */
model DpmJobTaskDetails {
  /**
   * The task display name.
   */
  taskId?: string;

  /**
   * The start time.
   */
  startTime?: utcDateTime;

  /**
   * The end time.
   */
  endTime?: utcDateTime;

  /**
   * Time elapsed for task.
   */
  duration?: duration;

  /**
   * The status.
   */
  status?: string;
}

/**
 * Additional information on Backup engine specific backup item.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DPMProtectedItem extends ProtectedItem {
  /**
   * Friendly name of the managed item
   */
  friendlyName?: string;

  /**
   * Backup Management server protecting this backup item
   */
  backupEngineName?: string;

  /**
   * Protection state of the backup engine
   */
  protectionState?: ProtectedItemState;

  /**
   * Extended info of the backup item.
   */
  extendedInfo?: DPMProtectedItemExtendedInfo;

  /**
   * backup item type.
   */
  protectedItemType: "DPMProtectedItem";
}

/**
 * Additional information of DPM Protected item.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DPMProtectedItemExtendedInfo {
  /**
   * Attribute to provide information on various DBs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protectableObjectLoadPath?: Record<string>;

  /**
   * To check if backup item is disk protected.
   */
  protected?: boolean;

  /**
   * To check if backup item is cloud protected.
   */
  isPresentOnCloud?: boolean;

  /**
   * Last backup status information on backup item.
   */
  lastBackupStatus?: string;

  /**
   * Last refresh time on backup item.
   */
  lastRefreshedAt?: utcDateTime;

  /**
   * Oldest cloud recovery point time.
   */
  oldestRecoveryPoint?: utcDateTime;

  /**
   * cloud recovery point count.
   */
  recoveryPointCount?: int32;

  /**
   * Oldest disk recovery point time.
   */
  onPremiseOldestRecoveryPoint?: utcDateTime;

  /**
   * latest disk recovery point time.
   */
  onPremiseLatestRecoveryPoint?: utcDateTime;

  /**
   * disk recovery point count.
   */
  onPremiseRecoveryPointCount?: int32;

  /**
   * To check if backup item is collocated.
   */
  isCollocated?: boolean;

  /**
   * Protection group name of the backup item.
   */
  protectionGroupName?: string;

  /**
   * Used Disk storage in bytes.
   */
  diskStorageUsedInBytes?: string;

  /**
   * total Disk storage in bytes.
   */
  totalDiskStorageSizeInBytes?: string;
}

/**
 * Details needed if the VM was encrypted at the time of backup.
 */
model EncryptionDetails {
  /**
   * Identifies whether this backup copy represents an encrypted VM at the time of backup.
   */
  encryptionEnabled?: boolean;

  /**
   * Key Url.
   */
  kekUrl?: string;

  /**
   * Secret Url.
   */
  secretKeyUrl?: string;

  /**
   * ID of Key Vault where KEK is stored.
   */
  kekVaultId?: string;

  /**
   * ID of Key Vault where Secret is stored.
   */
  secretKeyVaultId?: string;
}

/**
 * This class is used to send blob details after exporting jobs.
 */
model ExportJobsOperationResultInfo extends OperationResultInfoBase {
  /**
   * URL of the blob into which the serialized string of list of jobs is exported.
   */
  blobUrl?: string;

  /**
   * SAS key to access the blob. It expires in 15 mins.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  blobSasKey?: string;

  /**
   * URL of the blob into which the ExcelFile is uploaded.
   */
  excelFileBlobUrl?: string;

  /**
   * SAS key to access the blob. It expires in 15 mins.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  excelFileBlobSasKey?: string;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "ExportJobsOperationResultInfo";
}

/**
 * Azure VM (Mercury) workload-specific backup policy.
 */
model GenericProtectionPolicy extends ProtectionPolicy {
  /**
   * List of sub-protection policies which includes schedule and retention
   */
  @identifiers(#[])
  subProtectionPolicy?: SubProtectionPolicy[];

  /**
   * TimeZone optional input as string. For example: TimeZone = "Pacific Standard Time".
   */
  timeZone?: string;

  /**
   * Name of this policy's fabric.
   */
  fabricName?: string;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  backupManagementType: "GenericProtectionPolicy";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HourlySchedule {
  /**
   * Interval at which backup needs to be triggered. For hourly the value
   *  can be 4/6/8/12
   */
  interval?: int32;

  /**
   * To specify start time of the backup window
   */
  scheduleWindowStartTime?: utcDateTime;

  /**
   * To specify duration of the backup window
   */
  scheduleWindowDuration?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DailySchedule {
  /**
   * List of times of day this schedule has to be run.
   */
  scheduleRunTimes?: utcDateTime[];
}

/**
 * Database included in RP.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Preserving original API naming convention"
@added(Versions.v2026_01_01_preview)
model DatabaseInRP {
  /**
   * Datasource Id for the database.
   */
  datasourceId?: string;

  /**
   * Datasource name for the database.
   */
  datasourceName?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WeeklySchedule {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  scheduleRunDays?: DayOfWeek[];

  /**
   * List of times of day this schedule has to be run.
   */
  scheduleRunTimes?: utcDateTime[];
}

/**
 * IaaS VM workload specific restore details for restores using managed identity
 */
model IdentityBasedRestoreDetails {
  /**
   * Gets the class type.
   */
  objectType?: string;

  /**
   * Fully qualified ARM ID of the target storage account.
   */
  targetStorageAccountId?: string;
}

/**
 * Encapsulates Managed Identity related information
 */
model IdentityInfo {
  /**
   * To differentiate if the managed identity is system assigned or user assigned
   */
  isSystemAssignedIdentity?: boolean;

  /**
   * Managed Identity Resource Id
   * Optional: Might not be required in the case of system assigned managed identity
   */
  managedIdentityResourceId?: string;
}

/**
 * Base class for backup items.
 */
model GenericProtectedItem extends ProtectedItem {
  /**
   * Friendly name of the container.
   */
  friendlyName?: string;

  /**
   * Indicates consistency of policy object and policy applied to this backup item.
   */
  policyState?: string;

  /**
   * Backup state of this backup item.
   */
  protectionState?: ProtectionState;

  /**
   * Data Plane Service ID of the protected item.
   */
  protectedItemId?: int64;

  /**
   * Loosely coupled (type, value) associations (example - parent of a protected item)
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceAssociations?: Record<string>;

  /**
   * Name of this backup item's fabric.
   */
  fabricName?: string;

  /**
   * backup item type.
   */
  protectedItemType: "GenericProtectedItem";
}

/**
 * Generic backup copy.
 */
model GenericRecoveryPoint extends RecoveryPoint {
  /**
   * Friendly name of the backup copy.
   */
  friendlyName?: string;

  /**
   * Type of the backup copy.
   */
  recoveryPointType?: string;

  /**
   * Time at which this backup copy was created.
   */
  recoveryPointTime?: utcDateTime;

  /**
   * Additional information associated with this backup copy.
   */
  recoveryPointAdditionalInfo?: string;

  /**
   * Properties of Recovery Point
   */
  recoveryPointProperties?: RecoveryPointProperties;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "GenericRecoveryPoint";
}

/**
 * Filters to list backup items.
 */
model GetProtectedItemQueryObject {
  /**
   * Specifies if the additional information should be provided for this item.
   */
  expand?: string;
}

/**
 * IaaS VM workload specific backup copy.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IaasVMRecoveryPoint extends RecoveryPoint {
  /**
   * Type of the backup copy.
   */
  recoveryPointType?: string;

  /**
   * Time at which this backup copy was created.
   */
  recoveryPointTime?: utcDateTime;

  /**
   * Additional information associated with this backup copy.
   */
  recoveryPointAdditionalInfo?: string;

  /**
   * Storage type of the VM whose backup copy is created.
   */
  sourceVMStorageType?: string;

  /**
   * Identifies whether the VM was encrypted when the backup copy is created.
   */
  isSourceVMEncrypted?: boolean;

  /**
   * Required details for recovering an encrypted VM. Applicable only when IsSourceVMEncrypted is true.
   */
  keyAndSecret?: KeyAndSecretDetails;

  /**
   * Is the session to recover items from this backup copy still active.
   */
  isInstantIlrSessionActive?: boolean;

  /**
   * Recovery point tier information.
   */
  @identifiers(#[])
  recoveryPointTierDetails?: RecoveryPointTierInformationV2[];

  /**
   * Whether VM is with Managed Disks
   */
  isManagedVirtualMachine?: boolean;

  /**
   * Virtual Machine Size
   */
  virtualMachineSize?: string;

  /**
   * Original Storage Account Option
   */
  originalStorageAccountOption?: boolean;

  /**
   * OS type
   */
  osType?: string;

  /**
   * Disk configuration
   */
  recoveryPointDiskConfiguration?: RecoveryPointDiskConfiguration;

  /**
   * Identifies the zone of the VM at the time of backup. Applicable only for zone-pinned Vms
   */
  zones?: string[];

  /**
   * Eligibility of RP to be moved to another tier
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryPointMoveReadinessInfo?: Record<RecoveryPointMoveReadinessInfo>;

  /**
   * Security Type of the Disk
   */
  securityType?: string;

  /**
   * Properties of Recovery Point
   */
  recoveryPointProperties?: RecoveryPointProperties;

  /**
   * This flag denotes if any of the disks in the VM are using Private access network setting
   */
  isPrivateAccessEnabledOnAnyDisk?: boolean;

  /**
   * Extended location of the VM recovery point,
   * should be null if VM is in public cloud
   */
  extendedLocation?: ExtendedLocation;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "IaasVMRecoveryPoint";
}

/**
 * BEK is bitlocker key.
 * KEK is encryption key for BEK
 * If the VM was encrypted then we will store following details :
 * 1. Secret(BEK) - Url + Backup Data + vaultId.
 * 2. Key(KEK) - Url + Backup Data + vaultId.
 * 3. EncryptionMechanism
 * BEK and KEK can potentially have different vault ids.
 */
model KeyAndSecretDetails {
  /**
   * KEK is encryption key for BEK.
   */
  kekDetails?: KEKDetails;

  /**
   * BEK is bitlocker encryption key.
   */
  bekDetails?: BEKDetails;

  /**
   * Encryption mechanism: None/ SinglePass/ DoublePass
   */
  encryptionMechanism?: string;
}

/**
 * KEK is encryption key for BEK.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model KEKDetails {
  /**
   * Key is KEK.
   */
  keyUrl?: string;

  /**
   * Key Vault ID where this Key is stored.
   */
  keyVaultId?: string;

  /**
   * KEK data.
   */
  keyBackupData?: string;
}

/**
 * Disk configuration
 */
model RecoveryPointDiskConfiguration {
  /**
   * Number of disks included in backup
   */
  numberOfDisksIncludedInBackup?: int32;

  /**
   * Number of disks attached to the VM
   */
  numberOfDisksAttachedToVm?: int32;

  /**
   * Information of disks included in backup
   */
  @identifiers(#[])
  includedDiskList?: DiskInformation[];

  /**
   * Information of disks excluded from backup
   */
  @identifiers(#[])
  excludedDiskList?: DiskInformation[];
}

/**
 * The extended location of Recovery point where VM was present.
 */
model ExtendedLocation {
  /**
   * Name of the extended location.
   */
  name?: string;

  /**
   * Type of the extended location. Possible values include: 'EdgeZone'
   */
  type?: string;
}

/**
 * Restore request parameters for Secured VMs
 */
model SecuredVMDetails {
  /**
   * Gets or Sets Disk Encryption Set Id for Secured VM OS Disk
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  securedVMOsDiskEncryptionSetId?: string;
}

/**
 * Specifies target network access settings for disks of VM to be restored.
 */
model TargetDiskNetworkAccessSettings {
  /**
   * Network access settings to be used for restored disks
   */
  targetDiskNetworkAccessOption?: TargetDiskNetworkAccessOption;

  /**
   * Gets or sets the ARM resource ID of the target disk access to be used when TargetDiskNetworkAccessOption is set to TargetDiskNetworkAccessOption.UseNew
   */
  targetDiskAccessId?: string;
}

alias IaasVMRestoreRequestProperties = {
  /**
   * ID of the backup copy to be recovered.
   */
  recoveryPointId?: string;

  /**
   * Type of this recovery.
   */
  recoveryType?: RecoveryType;

  /**
   * Fully qualified ARM ID of the VM which is being recovered.
   */
  sourceResourceId?: string;

  /**
   * This is the complete ARM Id of the VM that will be created.
   * For e.g. /subscriptions/{subId}/resourcegroups/{rg}/provider/Microsoft.Compute/virtualmachines/{vm}
   */
  targetVirtualMachineId?: string;

  /**
   * This is the ARM Id of the resource group that you want to create for this Virtual machine and other artifacts.
   * For e.g. /subscriptions/{subId}/resourcegroups/{rg}
   */
  targetResourceGroupId?: string;

  /**
   * Fully qualified ARM ID of the storage account to which the VM has to be restored.
   */
  storageAccountId?: string;

  /**
   * This is the virtual network Id of the vnet that will be attached to the virtual machine.
   * User will be validated for join action permissions in the linked access.
   */
  virtualNetworkId?: string;

  /**
   * Subnet ID, is the subnet ID associated with the to be restored VM. For Classic VMs it would be
   * {VnetID}/Subnet/{SubnetName} and, for the Azure Resource Manager VMs it would be ARM resource ID used to represent
   * the subnet.
   */
  subnetId?: string;

  /**
   * Fully qualified ARM ID of the domain name to be associated to the VM being restored. This applies only to Classic
   * Virtual Machines.
   */
  targetDomainNameId?: string;

  /**
   * Region in which the virtual machine is restored.
   */
  region?: string;

  /**
   * Affinity group associated to VM to be restored. Used only for Classic Compute Virtual Machines.
   */
  affinityGroup?: string;

  /**
   * Should a new cloud service be created while restoring the VM. If this is false, VM will be restored to the same
   * cloud service as it was at the time of backup.
   */
  createNewCloudService?: boolean;

  /**
   * Original Storage Account Option
   */
  originalStorageAccountOption?: boolean;

  /**
   * Details needed if the VM was encrypted at the time of backup.
   */
  encryptionDetails?: EncryptionDetails;

  /**
   * List of Disk LUNs for partial restore
   */
  restoreDiskLunList?: int32[];

  /**
   * Flag to denote of an Unmanaged disk VM should be restored with Managed disks.
   */
  restoreWithManagedDisks?: boolean;

  /**
   * DiskEncryptionSet's ID - needed if the VM needs to be encrypted at rest during restore with customer managed key.
   */
  diskEncryptionSetId?: string;

  /**
   * Target zone where the VM and its disks should be restored.
   */
  zones?: string[];

  /**
   * Managed Identity information required to access customer storage account.
   */
  identityInfo?: IdentityInfo;

  /**
   * IaaS VM workload specific restore details for restores using managed identity.
   */
  identityBasedRestoreDetails?: IdentityBasedRestoreDetails;

  /**
   * Target extended location where the VM should be restored,
   * should be null if restore is to be done in public cloud
   */
  extendedLocation?: ExtendedLocation;

  /**
   * Stores Secured VM Details
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  securedVMDetails?: SecuredVMDetails;

  /**
   * Specifies target network access settings for disks of VM to be restored,
   */
  targetDiskNetworkAccessSettings?: TargetDiskNetworkAccessSettings;
};

/**
 * IaaS VM workload-specific restore.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IaasVMRestoreRequest extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "IaasVMRestoreRequest";

  ...IaasVMRestoreRequestProperties;
}

/**
 * Filters to list the jobs.
 */
model JobQueryObject {
  /**
   * Status of the job.
   */
  status?: JobStatus;

  /**
   * Type of backup management for the job.
   */
  backupManagementType?: BackupManagementType;

  /**
   * Type of operation.
   */
  operation?: JobOperationType;

  /**
   * JobID represents the job uniquely.
   */
  jobId?: string;

  /**
   * Job has started at this time. Value is in UTC.
   */
  startTime?: utcDateTime;

  /**
   * Job has ended at this time. Value is in UTC.
   */
  endTime?: utcDateTime;
}

/**
 * Log policy schedule.
 */
model LogSchedulePolicy extends SchedulePolicy {
  /**
   * Frequency of the log schedule operation of this policy in minutes.
   */
  scheduleFrequencyInMins?: int32;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  schedulePolicyType: "LogSchedulePolicy";
}

/**
 * Long term retention policy.
 */
model LongTermRetentionPolicy extends RetentionPolicy {
  /**
   * Daily retention schedule of the protection policy.
   */
  dailySchedule?: DailyRetentionSchedule;

  /**
   * Weekly retention schedule of the protection policy.
   */
  weeklySchedule?: WeeklyRetentionSchedule;

  /**
   * Monthly retention schedule of the protection policy.
   */
  monthlySchedule?: MonthlyRetentionSchedule;

  /**
   * Yearly retention schedule of the protection policy.
   */
  yearlySchedule?: YearlyRetentionSchedule;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  retentionPolicyType: "LongTermRetentionPolicy";
}

/**
 * Weekly retention schedule.
 */
model WeeklyRetentionSchedule {
  /**
   * List of days of week for weekly retention policy.
   */
  daysOfTheWeek?: DayOfWeek[];

  /**
   * Retention times of retention policy.
   */
  retentionTimes?: utcDateTime[];

  /**
   * Retention duration of retention Policy.
   */
  retentionDuration?: RetentionDuration;
}

/**
 * Monthly retention schedule.
 */
model MonthlyRetentionSchedule {
  /**
   * Retention schedule format type for monthly retention policy.
   */
  retentionScheduleFormatType?: RetentionScheduleFormat;

  /**
   * Daily retention format for monthly retention policy.
   */
  retentionScheduleDaily?: DailyRetentionFormat;

  /**
   * Weekly retention format for monthly retention policy.
   */
  retentionScheduleWeekly?: WeeklyRetentionFormat;

  /**
   * Retention times of retention policy.
   */
  retentionTimes?: utcDateTime[];

  /**
   * Retention duration of retention Policy.
   */
  retentionDuration?: RetentionDuration;
}

/**
 * Weekly retention format.
 */
model WeeklyRetentionFormat {
  /**
   * List of days of the week.
   */
  daysOfTheWeek?: DayOfWeek[];

  /**
   * List of weeks of month.
   */
  weeksOfTheMonth?: WeekOfMonth[];
}

/**
 * Yearly retention schedule.
 */
model YearlyRetentionSchedule {
  /**
   * Retention schedule format for yearly retention policy.
   */
  retentionScheduleFormatType?: RetentionScheduleFormat;

  /**
   * List of months of year of yearly retention policy.
   */
  monthsOfYear?: MonthOfYear[];

  /**
   * Daily retention format for yearly retention policy.
   */
  retentionScheduleDaily?: DailyRetentionFormat;

  /**
   * Weekly retention format for yearly retention policy.
   */
  retentionScheduleWeekly?: WeeklyRetentionFormat;

  /**
   * Retention times of retention policy.
   */
  retentionTimes?: utcDateTime[];

  /**
   * Retention duration of retention Policy.
   */
  retentionDuration?: RetentionDuration;
}

/**
 * Long term policy schedule.
 */
model LongTermSchedulePolicy extends SchedulePolicy {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  schedulePolicyType: "LongTermSchedulePolicy";
}

/**
 * MAB workload-specific error information.
 */
model MabErrorInfo {
  /**
   * Localized error string.
   */
  @visibility(Lifecycle.Read)
  errorString?: string;

  /**
   * List of localized recommendations.
   */
  @visibility(Lifecycle.Read)
  recommendations?: string[];
}

/**
 * MAB workload-specific backup item.
 */
model MabFileFolderProtectedItem extends ProtectedItem {
  /**
   * Friendly name of this backup item.
   */
  friendlyName?: string;

  /**
   * Name of the computer associated with this backup item.
   */
  computerName?: string;

  /**
   * Status of last backup operation.
   */
  lastBackupStatus?: string;

  /**
   * Timestamp of the last backup operation on this backup item.
   */
  lastBackupTime?: utcDateTime;

  /**
   * Protected, ProtectionStopped, IRPending or ProtectionError
   */
  protectionState?: string;

  /**
   * Sync time for deferred deletion in UTC
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deferredDeleteSyncTimeInUTC?: int64;

  /**
   * Additional information with this backup item.
   */
  extendedInfo?: MabFileFolderProtectedItemExtendedInfo;

  /**
   * backup item type.
   */
  protectedItemType: "MabFileFolderProtectedItem";
}

/**
 * Additional information on the backed up item.
 */
model MabFileFolderProtectedItemExtendedInfo {
  /**
   * Last time when the agent data synced to service.
   */
  lastRefreshedAt?: utcDateTime;

  /**
   * The oldest backup copy available.
   */
  oldestRecoveryPoint?: utcDateTime;

  /**
   * Number of backup copies associated with the backup item.
   */
  recoveryPointCount?: int32;
}

/**
 * MAB workload-specific job.
 */
model MabJob extends Job {
  /**
   * Time taken by job to run.
   */
  duration?: duration;

  /**
   * The state/actions applicable on jobs like cancel/retry.
   */
  actionsInfo?: JobSupportedAction[];

  /**
   * Name of server protecting the DS.
   */
  mabServerName?: string;

  /**
   * Server type of MAB container.
   */
  mabServerType?: MabServerType;

  /**
   * Workload type of backup item.
   */
  workloadType?: WorkloadType;

  /**
   * The errors.
   */
  @identifiers(#[])
  errorDetails?: MabErrorInfo[];

  /**
   * Additional information on the job.
   */
  extendedInfo?: MabJobExtendedInfo;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  jobType: "MabJob";
}

/**
 * Additional information for the MAB workload-specific job.
 */
model MabJobExtendedInfo {
  /**
   * List of tasks for this job.
   */
  @identifiers(#["taskId"])
  tasksList?: MabJobTaskDetails[];

  /**
   * The job properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  propertyBag?: Record<string>;

  /**
   * Non localized error message specific to this job.
   */
  dynamicErrorMessage?: string;
}

/**
 * MAB workload-specific job task details.
 */
model MabJobTaskDetails {
  /**
   * The task display name.
   */
  taskId?: string;

  /**
   * The start time.
   */
  startTime?: utcDateTime;

  /**
   * The end time.
   */
  endTime?: utcDateTime;

  /**
   * Time elapsed for task.
   */
  duration?: duration;

  /**
   * The status.
   */
  status?: string;
}

/**
 * Mab container-specific backup policy.
 */
model MabProtectionPolicy extends ProtectionPolicy {
  /**
   * Backup schedule of backup policy.
   */
  schedulePolicy?: SchedulePolicy;

  /**
   * Retention policy details.
   */
  retentionPolicy?: RetentionPolicy;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  backupManagementType: "MAB";
}

/**
 * Operation result info.
 */
model OperationResultInfo extends OperationResultInfoBase {
  /**
   * List of jobs created by this operation.
   */
  jobList?: string[];

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "OperationResultInfo";
}

/**
 * Prepare DataMove Response
 */
model PrepareDataMoveResponse
  extends VaultStorageConfigOperationResultResponse {
  /**
   * Co-relationId for move operation
   */
  correlationId?: string;

  /**
   * Source Vault Properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceVaultProperties?: Record<string>;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "PrepareDataMoveResponse";
}

/**
 * Filters to list backup items.
 */
model ProtectedItemQueryObject {
  /**
   * Health State for the backed up item.
   */
  healthState?: HealthState;

  /**
   * Backup management type for the backed up item.
   */
  backupManagementType?: BackupManagementType;

  /**
   * Type of workload this item represents.
   */
  itemType?: DataSourceType;

  /**
   * Backup policy name associated with the backup item.
   */
  policyName?: string;

  /**
   * Name of the container.
   */
  containerName?: string;

  /**
   * Backup Engine name
   */
  backupEngineName?: string;

  /**
   * Friendly name of protected item
   */
  friendlyName?: string;

  /**
   * Name of the fabric.
   */
  fabricName?: string;

  /**
   * Name of the backup set.
   */
  backupSetName?: string;
}

/**
 * Filters the list backup policies API.
 */
model ProtectionPolicyQueryObject {
  /**
   * Backup management type for the backup policy.
   */
  backupManagementType?: BackupManagementType;

  /**
   * Fabric name for filter
   */
  fabricName?: string;

  /**
   * Workload type for the backup policy.
   */
  workloadType?: WorkloadType;
}

/**
 * Simple policy retention.
 */
model SimpleRetentionPolicy extends RetentionPolicy {
  /**
   * Retention duration of the protection policy.
   */
  retentionDuration?: RetentionDuration;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  retentionPolicyType: "SimpleRetentionPolicy";
}

/**
 * Simple policy schedule.
 */
model SimpleSchedulePolicy extends SchedulePolicy {
  /**
   * Frequency of the schedule operation of this policy.
   */
  scheduleRunFrequency?: ScheduleRunType;

  /**
   * List of days of week this schedule has to be run.
   */
  scheduleRunDays?: DayOfWeek[];

  /**
   * List of times of day this schedule has to be run.
   */
  scheduleRunTimes?: utcDateTime[];

  /**
   * Hourly Schedule of this Policy
   */
  hourlySchedule?: HourlySchedule;

  /**
   * At every number weeks this schedule has to be run.
   */
  scheduleWeeklyFrequency?: int32;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  schedulePolicyType: "SimpleSchedulePolicy";
}

/**
 * The V2 policy schedule for IaaS that supports hourly backups.
 */
model SimpleSchedulePolicyV2 extends SchedulePolicy {
  /**
   * Frequency of the schedule operation of this policy.
   */
  scheduleRunFrequency?: ScheduleRunType;

  /**
   * hourly schedule of this policy
   */
  hourlySchedule?: HourlySchedule;

  /**
   * Daily schedule of this policy
   */
  dailySchedule?: DailySchedule;

  /**
   * Weekly schedule of this policy
   */
  weeklySchedule?: WeeklySchedule;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  schedulePolicyType: "SimpleSchedulePolicyV2";
}

/**
 * AzureRestoreValidation request.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ValidateIaasVMRestoreOperationRequest extends ValidateOperationRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "ValidateIaasVMRestoreOperationRequest";

  ...ValidateRestoreOperationRequestProperties;
}

alias ValidateRestoreOperationRequestProperties = {
  /**
   * Sets restore request to be validated
   */
  restoreRequest?: RestoreRequest;
};

/**
 * AzureRestoreValidation request.
 */
model ValidateRestoreOperationRequest extends ValidateOperationRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "ValidateRestoreOperationRequest";

  ...ValidateRestoreOperationRequestProperties;
}

/**
 * Vault level Job
 */
model VaultJob extends Job {
  /**
   * Time elapsed during the execution of this job.
   */
  duration?: duration;

  /**
   * Gets or sets the state/actions applicable on this job like cancel/retry.
   */
  actionsInfo?: JobSupportedAction[];

  /**
   * Error details on execution of this job.
   */
  @identifiers(#["errorCode"])
  errorDetails?: VaultJobErrorInfo[];

  /**
   * Additional information about the job.
   */
  extendedInfo?: VaultJobExtendedInfo;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  jobType: "VaultJob";
}

/**
 * Vault Job specific error information
 */
model VaultJobErrorInfo {
  /**
   * Error code.
   */
  errorCode?: int32;

  /**
   * Localized error string.
   */
  errorString?: string;

  /**
   * List of localized recommendations for above error code.
   */
  recommendations?: string[];
}

/**
 * Vault Job for CMK - has CMK specific info.
 */
model VaultJobExtendedInfo {
  /**
   * Job properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  propertyBag?: Record<string>;
}

/**
 * AzureBackupServer (DPMVenus) workload-specific protection container.
 */
model AzureBackupServerContainer extends ProtectionContainer {
  /**
   * Type of the container. The value of this property for: 1. Compute Azure VM is Microsoft.Compute/virtualMachines 2.
   * Classic Compute Azure VM is Microsoft.ClassicCompute/virtualMachines 3. Windows machines (like MAB, DPM etc) is
   * Windows 4. Azure SQL instance is AzureSqlContainer. 5. Storage containers is StorageContainer. 6. Azure workload
   * Backup is VMAppContainer
   */
  containerType: ProtectableContainerType.AzureBackupServerContainer;

  ...DpmContainerProperties;
}

alias DpmContainerProperties = {
  /**
   * Specifies whether the container is re-registrable.
   */
  canReRegister?: boolean;

  /**
   * ID of container.
   */
  containerId?: string;

  /**
   * Number of protected items in the BackupEngine
   */
  protectedItemCount?: int64;

  /**
   * Backup engine Agent version
   */
  dpmAgentVersion?: string;

  /**
   * List of BackupEngines protecting the container
   */
  dpmServers?: string[];

  /**
   * To check if upgrade available
   */
  upgradeAvailable?: boolean;

  /**
   * Protection status of the container.
   */
  protectionStatus?: string;

  /**
   * Extended Info of the container.
   */
  extendedInfo?: DPMContainerExtendedInfo;
};

/**
 * DPM workload-specific protection container.
 */
model DpmContainer extends ProtectionContainer {
  /**
   * Type of the container. The value of this property for: 1. Compute Azure VM is Microsoft.Compute/virtualMachines 2.
   * Classic Compute Azure VM is Microsoft.ClassicCompute/virtualMachines 3. Windows machines (like MAB, DPM etc) is
   * Windows 4. Azure SQL instance is AzureSqlContainer. 5. Storage containers is StorageContainer. 6. Azure workload
   * Backup is VMAppContainer
   */
  containerType: ProtectableContainerType.DPMContainer;

  ...DpmContainerProperties;
}

/**
 * Additional information of the DPMContainer.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DPMContainerExtendedInfo {
  /**
   * Last refresh time of the DPMContainer.
   */
  lastRefreshedAt?: utcDateTime;
}

/**
 * Backup engine type when Azure Backup Server is used to manage the backups.
 */
model AzureBackupServerEngine extends BackupEngineBase {
  /**
   * Type of the backup engine.
   */
  backupEngineType: "AzureBackupServerEngine";
}

/**
 * AzureFileShare workload-specific backup request.
 */
model AzureFileShareBackupRequest extends BackupRequest {
  /**
   * Backup copy will expire after the time specified (UTC).
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryPointExpiryTimeInUTC?: utcDateTime;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureFileShareBackupRequest";
}

/**
 * Protectable item for Azure Fileshare workloads.
 */
model AzureFileShareProtectableItem extends WorkloadProtectableItem {
  /**
   * Full Fabric ID of container to which this protectable item belongs. For example, ARM ID.
   */
  parentContainerFabricId?: string;

  /**
   * Friendly name of container to which this protectable item belongs.
   */
  parentContainerFriendlyName?: string;

  /**
   * File Share type XSync or XSMB.
   */
  azureFileShareType?: AzureFileShareType;

  /**
   * Type of the backup item.
   */
  protectableItemType: "AzureFileShare";
}

/**
 * Update snapshot Uri with the correct friendly Name of the source Azure file share.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureFileShareProvisionILRRequest extends ILRRequest {
  /**
   * Recovery point ID.
   */
  recoveryPointId?: string;

  /**
   * Source Storage account ARM Id
   */
  sourceResourceId?: string;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureFileShareProvisionILRRequest";
}

/**
 * IaaS VM workload-specific backup item representing a classic virtual machine.
 */
model AzureIaaSClassicComputeVMContainer extends ProtectionContainer {
  /**
   * Type of the container. The value of this property for: 1. Compute Azure VM is Microsoft.Compute/virtualMachines 2.
   * Classic Compute Azure VM is Microsoft.ClassicCompute/virtualMachines 3. Windows machines (like MAB, DPM etc) is
   * Windows 4. Azure SQL instance is AzureSqlContainer. 5. Storage containers is StorageContainer. 6. Azure workload
   * Backup is VMAppContainer
   */
  containerType: ProtectableContainerType.`Microsoft.ClassicCompute/virtualMachines`;

  ...IaaSVMContainerProperties;
}

alias IaaSVMContainerProperties = {
  /**
   * Fully qualified ARM url of the virtual machine represented by this Azure IaaS VM container.
   */
  virtualMachineId?: string;

  /**
   * Specifies whether the container represents a Classic or an Azure Resource Manager VM.
   */
  virtualMachineVersion?: string;

  /**
   * Resource group name of Recovery Services Vault.
   */
  resourceGroup?: string;
};

/**
 * IaaS VM workload-specific container.
 */
model IaaSVMContainer extends ProtectionContainer {
  /**
   * Type of the container. The value of this property for: 1. Compute Azure VM is Microsoft.Compute/virtualMachines 2.
   * Classic Compute Azure VM is Microsoft.ClassicCompute/virtualMachines 3. Windows machines (like MAB, DPM etc) is
   * Windows 4. Azure SQL instance is AzureSqlContainer. 5. Storage containers is StorageContainer. 6. Azure workload
   * Backup is VMAppContainer
   */
  containerType: ProtectableContainerType.IaasVMContainer;

  ...IaaSVMContainerProperties;
}

/**
 * IaaS VM workload-specific backup item representing the Classic Compute VM.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureIaaSClassicComputeVMProtectableItem extends WorkloadProtectableItem {
  /**
   * Type of the backup item.
   */
  protectableItemType: "Microsoft.ClassicCompute/virtualMachines";

  ...IaaSVMProtectableItemProperties;
}

alias IaaSVMProtectableItemProperties = {
  /**
   * Fully qualified ARM ID of the virtual machine.
   */
  virtualMachineId?: string;

  /**
   * Specifies whether the container represents a Classic or an Azure Resource Manager VM.
   */
  virtualMachineVersion?: string;

  /**
   * Resource group name of Recovery Services Vault.
   */
  resourceGroup?: string;
};

/**
 * IaaS VM workload-specific backup item.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IaaSVMProtectableItem extends WorkloadProtectableItem {
  /**
   * Type of the backup item.
   */
  protectableItemType: "IaaSVMProtectableItem";

  ...IaaSVMProtectableItemProperties;
}

/**
 * IaaS VM workload-specific backup item representing an Azure Resource Manager virtual machine.
 */
model AzureIaaSComputeVMContainer extends ProtectionContainer {
  /**
   * Type of the container. The value of this property for: 1. Compute Azure VM is Microsoft.Compute/virtualMachines 2.
   * Classic Compute Azure VM is Microsoft.ClassicCompute/virtualMachines 3. Windows machines (like MAB, DPM etc) is
   * Windows 4. Azure SQL instance is AzureSqlContainer. 5. Storage containers is StorageContainer. 6. Azure workload
   * Backup is VMAppContainer
   */
  containerType: ProtectableContainerType.`Microsoft.Compute/virtualMachines`;

  ...IaaSVMContainerProperties;
}

/**
 * IaaS VM workload-specific backup item representing the Azure Resource Manager VM.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureIaaSComputeVMProtectableItem extends WorkloadProtectableItem {
  /**
   * Type of the backup item.
   */
  protectableItemType: "Microsoft.Compute/virtualMachines";

  ...IaaSVMProtectableItemProperties;
}

/**
 * Container for SQL workloads under SQL Availability Group.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureSQLAGWorkloadContainerProtectionContainer
  extends ProtectionContainer {
  /**
   * Type of the container. The value of this property for: 1. Compute Azure VM is Microsoft.Compute/virtualMachines 2.
   * Classic Compute Azure VM is Microsoft.ClassicCompute/virtualMachines 3. Windows machines (like MAB, DPM etc) is
   * Windows 4. Azure SQL instance is AzureSqlContainer. 5. Storage containers is StorageContainer. 6. Azure workload
   * Backup is VMAppContainer
   */
  containerType: ProtectableContainerType.SQLAGWorkLoadContainer;

  ...AzureWorkloadContainerProperties;
}

alias AzureWorkloadContainerProperties = {
  /**
   * ARM ID of the virtual machine represented by this Azure Workload Container
   */
  sourceResourceId?: string;

  /**
   * Time stamp when this container was updated.
   */
  lastUpdatedTime?: utcDateTime;

  /**
   * Additional details of a workload container.
   */
  extendedInfo?: AzureWorkloadContainerExtendedInfo;

  /**
   * Workload type for which registration was sent.
   */
  workloadType?: WorkloadType;

  /**
   * Re-Do Operation
   */
  operationType?: OperationType;
};

/**
 * Container for the workloads running inside Azure Compute or Classic Compute.
 */
model AzureWorkloadContainer extends ProtectionContainer {
  /**
   * Type of the container. The value of this property for: 1. Compute Azure VM is Microsoft.Compute/virtualMachines 2.
   * Classic Compute Azure VM is Microsoft.ClassicCompute/virtualMachines 3. Windows machines (like MAB, DPM etc) is
   * Windows 4. Azure SQL instance is AzureSqlContainer. 5. Storage containers is StorageContainer. 6. Azure workload
   * Backup is VMAppContainer
   */
  containerType: ProtectableContainerType.AzureWorkloadContainer;

  ...AzureWorkloadContainerProperties;
}

/**
 * Extended information of the container.
 */
model AzureWorkloadContainerExtendedInfo {
  /**
   * Host Os Name in case of Stand Alone and Cluster Name in case of distributed container.
   */
  hostServerName?: string;

  /**
   * Inquiry Status for the container.
   */
  inquiryInfo?: InquiryInfo;

  /**
   * List of the nodes in case of distributed container.
   */
  @identifiers(#[])
  nodesList?: DistributedNodesInfo[];
}

/**
 * Details about inquired protectable items under a given container.
 */
model InquiryInfo {
  /**
   * Inquiry Status for this container such as
   * InProgress | Failed | Succeeded
   */
  status?: string;

  /**
   * Error Details if the Status is non-success.
   */
  errorDetail?: ErrorDetail;

  /**
   * Inquiry Details which will have workload specific details.
   * For e.g. - For SQL and oracle this will contain different details.
   */
  @identifiers(#[])
  inquiryDetails?: WorkloadInquiryDetails[];
}

/**
 * Details of an inquired protectable item.
 */
model WorkloadInquiryDetails {
  /**
   * Type of the Workload such as SQL, Oracle etc.
   */
  type?: string;

  /**
   * Contains the protectable item Count inside this Container.
   */
  itemCount?: int64;

  /**
   * Inquiry validation such as permissions and other backup validations.
   */
  inquiryValidation?: InquiryValidation;
}

/**
 * Validation for inquired protectable items under a given container.
 */
model InquiryValidation {
  /**
   * Status for the Inquiry Validation.
   */
  status?: string;

  /**
   * Error Detail in case the status is non-success.
   */
  errorDetail?: ErrorDetail;

  /**
   * Error Additional Detail in case the status is non-success.
   */
  @visibility(Lifecycle.Read)
  additionalDetail?: string;

  /**
   * Dictionary to store the count of ProtectableItems with key POType.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  protectableItemCount?: unknown;
}

/**
 * Azure Sql workload-specific container.
 */
model AzureSqlContainer extends ProtectionContainer {
  /**
   * Type of the container. The value of this property for: 1. Compute Azure VM is Microsoft.Compute/virtualMachines 2.
   * Classic Compute Azure VM is Microsoft.ClassicCompute/virtualMachines 3. Windows machines (like MAB, DPM etc) is
   * Windows 4. Azure SQL instance is AzureSqlContainer. 5. Storage containers is StorageContainer. 6. Azure workload
   * Backup is VMAppContainer
   */
  containerType: ProtectableContainerType.AzureSqlContainer;
}

/**
 * Azure Storage Account workload-specific container.
 */
model AzureStorageContainer extends ProtectionContainer {
  /**
   * Fully qualified ARM url.
   */
  sourceResourceId?: string;

  /**
   * Storage account version.
   */
  storageAccountVersion?: string;

  /**
   * Resource group name of Recovery Services Vault.
   */
  resourceGroup?: string;

  /**
   * Number of items backed up in this container.
   */
  protectedItemCount?: int64;

  /**
   * Whether storage account lock is to be acquired for this container or not.
   */
  acquireStorageAccountLock?: AcquireStorageAccountLock;

  /**
   * Re-Do Operation
   */
  operationType?: OperationType;

  /**
   * Type of the container. The value of this property for: 1. Compute Azure VM is Microsoft.Compute/virtualMachines 2.
   * Classic Compute Azure VM is Microsoft.ClassicCompute/virtualMachines 3. Windows machines (like MAB, DPM etc) is
   * Windows 4. Azure SQL instance is AzureSqlContainer. 5. Storage containers is StorageContainer. 6. Azure workload
   * Backup is VMAppContainer
   */
  containerType: ProtectableContainerType.StorageContainer;
}

/**
 * Azure Storage-specific protectable containers
 */
model AzureStorageProtectableContainer extends ProtectableContainer {
  /**
   * Type of the container. The value of this property for
   * 1. Compute Azure VM is Microsoft.Compute/virtualMachines
   * 2. Classic Compute Azure VM is Microsoft.ClassicCompute/virtualMachines
   */
  @visibility(Lifecycle.Read)
  protectableContainerType: ProtectableContainerType.StorageContainer;
}

/**
 * Azure workload-specific container
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVMAppContainerProtectableContainer extends ProtectableContainer {
  /**
   * Type of the container. The value of this property for
   * 1. Compute Azure VM is Microsoft.Compute/virtualMachines
   * 2. Classic Compute Azure VM is Microsoft.ClassicCompute/virtualMachines
   */
  protectableContainerType: ProtectableContainerType.VMAppContainer;
}

/**
 * Container for SQL workloads under Azure Virtual Machines.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVMAppContainerProtectionContainer extends ProtectionContainer {
  /**
   * Type of the container. The value of this property for: 1. Compute Azure VM is Microsoft.Compute/virtualMachines 2.
   * Classic Compute Azure VM is Microsoft.ClassicCompute/virtualMachines 3. Windows machines (like MAB, DPM etc) is
   * Windows 4. Azure SQL instance is AzureSqlContainer. 5. Storage containers is StorageContainer. 6. Azure workload
   * Backup is VMAppContainer
   */
  containerType: ProtectableContainerType.VMAppContainer;

  ...AzureWorkloadContainerProperties;
}

alias AzureVmWorkloadItemProperties = {
  /**
   * Name for instance or AG
   */
  parentName?: string;

  /**
   * Host/Cluster Name for instance or AG
   */
  serverName?: string;

  /**
   * Indicates if workload item is auto-protectable
   */
  isAutoProtectable?: boolean;

  /**
   * For instance or AG, indicates number of DB's present
   */
  subinquireditemcount?: int32;

  /**
   * For instance or AG, indicates number of DB's to be protected
   */
  subWorkloadItemCount?: int32;
};

/**
 * Azure VM workload-specific workload item.
 */
model AzureVmWorkloadItem extends WorkloadItem {
  /**
   * Type of the backup item.
   */
  workloadItemType: "AzureVmWorkloadItem";

  ...AzureVmWorkloadItemProperties;
}

alias AzureVmWorkloadProtectableItemProperties = {
  /**
   * Name for instance or AG
   */
  parentName?: string;

  /**
   * Parent Unique Name is added to provide the service formatted URI Name of the Parent
   * Only Applicable for data bases where the parent would be either Instance or a SQL AG.
   */
  parentUniqueName?: string;

  /**
   * Host/Cluster Name for instance or AG
   */
  serverName?: string;

  /**
   * Indicates if protectable item is auto-protectable
   */
  isAutoProtectable?: boolean;

  /**
   * Indicates if protectable item is auto-protected
   */
  isAutoProtected?: boolean;

  /**
   * For instance or AG, indicates number of DB's present
   */
  subinquireditemcount?: int32;

  /**
   * For instance or AG, indicates number of DB's to be protected
   */
  subprotectableitemcount?: int32;

  /**
   * Pre-backup validation for protectable objects
   */
  prebackupvalidation?: PreBackupValidation;

  /**
   * Indicates if item is protectable
   */
  isProtectable?: boolean;
};

/**
 * Azure VM workload-specific protectable item.
 */
model AzureVmWorkloadProtectableItem extends WorkloadProtectableItem {
  /**
   * Type of the backup item.
   */
  protectableItemType: "AzureVmWorkloadProtectableItem";

  ...AzureVmWorkloadProtectableItemProperties;
}

/**
 * Pre-backup validation for Azure VM Workload provider.
 */
model PreBackupValidation {
  /**
   * Status of protectable item, i.e. InProgress,Succeeded,Failed
   */
  status?: InquiryStatus;

  /**
   * Error code of protectable item
   */
  code?: string;

  /**
   * Message corresponding to the error code for the protectable item
   */
  message?: string;
}

/**
 * Azure VM workload-specific protectable item representing SAP ASE Database.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSAPAseDatabaseProtectableItem
  extends WorkloadProtectableItem {
  /**
   * Type of the backup item.
   */
  protectableItemType: "SAPAseDatabase";

  ...AzureVmWorkloadProtectableItemProperties;
}

/**
 * Azure VM workload-specific workload item representing SAP ASE Database.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSAPAseDatabaseWorkloadItem extends WorkloadItem {
  /**
   * Type of the backup item.
   */
  workloadItemType: "SAPAseDatabase";

  ...AzureVmWorkloadItemProperties;
}

/**
 * Azure VM workload-specific protectable item representing SAP ASE System.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSAPAseSystemProtectableItem
  extends WorkloadProtectableItem {
  /**
   * Type of the backup item.
   */
  protectableItemType: "SAPAseSystem";

  ...AzureVmWorkloadProtectableItemProperties;
}

/**
 * Azure VM workload-specific workload item representing SAP ASE System.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSAPAseSystemWorkloadItem extends WorkloadItem {
  /**
   * Type of the backup item.
   */
  workloadItemType: "SAPAseSystem";

  ...AzureVmWorkloadItemProperties;
}

/**
 * Azure VM workload-specific protectable item representing SAP HANA Database.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSAPHanaDatabaseProtectableItem
  extends WorkloadProtectableItem {
  /**
   * Type of the backup item.
   */
  protectableItemType: "SAPHanaDatabase";

  ...AzureVmWorkloadProtectableItemProperties;
}

/**
 * Azure VM workload-specific workload item representing SAP HANA Database.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSAPHanaDatabaseWorkloadItem extends WorkloadItem {
  /**
   * Type of the backup item.
   */
  workloadItemType: "SAPHanaDatabase";

  ...AzureVmWorkloadItemProperties;
}

/**
 * Azure VM workload-specific protectable item representing SAP HANA System.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSAPHanaSystemProtectableItem
  extends WorkloadProtectableItem {
  /**
   * Type of the backup item.
   */
  protectableItemType: "SAPHanaSystem";

  ...AzureVmWorkloadProtectableItemProperties;
}

/**
 * Azure VM workload-specific protectable item representing SAP HANA Dbinstance.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSAPHanaDBInstance extends WorkloadProtectableItem {
  /**
   * Type of the backup item.
   */
  protectableItemType: "SAPHanaDBInstance";

  ...AzureVmWorkloadProtectableItemProperties;
}

/**
 * Azure VM workload-specific protectable item representing HANA HSR.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSAPHanaHSRProtectableItem extends WorkloadProtectableItem {
  /**
   * Type of the backup item.
   */
  protectableItemType: "HanaHSRContainer";

  ...AzureVmWorkloadProtectableItemProperties;
}

/**
 * Azure VM workload-specific protectable item representing HANA scale out.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2026_01_01_preview)
model AzureVmWorkloadSAPHanaScaleoutProtectableItem
  extends WorkloadProtectableItem {
  /**
   * Type of the backup item.
   */
  protectableItemType: "HanaScaleoutContainer";

  ...AzureVmWorkloadProtectableItemProperties;
}

/**
 * Azure VM workload-specific workload item representing SAP HANA System.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSAPHanaSystemWorkloadItem extends WorkloadItem {
  /**
   * Type of the backup item.
   */
  workloadItemType: "SAPHanaSystem";

  ...AzureVmWorkloadItemProperties;
}

/**
 * Azure VM workload-specific protectable item representing SQL Availability Group.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSQLAvailabilityGroupProtectableItem
  extends WorkloadProtectableItem {
  /**
   * Type of the backup item.
   */
  protectableItemType: "SQLAvailabilityGroupContainer";

  /**
   * List of the nodes in case of distributed container.
   */
  @identifiers(#[])
  nodesList?: DistributedNodesInfo[];

  ...AzureVmWorkloadProtectableItemProperties;
}

/**
 * Azure VM workload-specific protectable item representing SQL Database.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSQLDatabaseProtectableItem
  extends WorkloadProtectableItem {
  /**
   * Type of the backup item.
   */
  protectableItemType: "SQLDataBase";

  ...AzureVmWorkloadProtectableItemProperties;
}

/**
 * Azure VM workload-specific workload item representing SQL Database.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSQLDatabaseWorkloadItem extends WorkloadItem {
  /**
   * Type of the backup item.
   */
  workloadItemType: "SQLDataBase";

  ...AzureVmWorkloadItemProperties;
}

/**
 * Azure VM workload-specific protectable item representing SQL Instance.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSQLInstanceProtectableItem
  extends WorkloadProtectableItem {
  /**
   * Type of the backup item.
   */
  protectableItemType: "SQLInstance";

  ...AzureVmWorkloadProtectableItemProperties;
}

/**
 * Azure VM workload-specific workload item representing SQL Instance.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVmWorkloadSQLInstanceWorkloadItem extends WorkloadItem {
  /**
   * Type of the backup item.
   */
  workloadItemType: "SQLInstance";

  /**
   * Data Directory Paths for default directories
   */
  @identifiers(#[])
  dataDirectoryPaths?: SQLDataDirectory[];

  ...AzureVmWorkloadItemProperties;
}

/**
 * AzureWorkload workload-specific backup request.
 */
model AzureWorkloadBackupRequest extends BackupRequest {
  /**
   * Type of backup, viz. Full, Differential, Log or CopyOnlyFull
   */
  backupType?: BackupType;

  /**
   * Bool for Compression setting
   */
  enableCompression?: boolean;

  /**
   * Backup copy will expire after the time specified (UTC).
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryPointExpiryTimeInUTC?: utcDateTime;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadBackupRequest";
}

/**
 * Azure backup goal feature specific request.
 */
model AzureBackupGoalFeatureSupportRequest extends FeatureSupportRequest {
  /**
   * backup support feature type.
   */
  featureType: "AzureBackupGoals";
}

/**
 * Azure Recovery Services Vault specific protection intent item.
 */
model AzureRecoveryServiceVaultProtectionIntent extends ProtectionIntent {
  /**
   * backup protectionIntent type.
   */
  protectionIntentItemType: ProtectionIntentItemType.RecoveryServiceVaultItem;
}

/**
 * IaaS VM specific backup protection intent item.
 */
model AzureResourceProtectionIntent extends ProtectionIntent {
  /**
   * Friendly name of the VM represented by this backup item.
   */
  friendlyName?: string;

  /**
   * backup protectionIntent type.
   */
  protectionIntentItemType: "AzureResourceItem";
}

/**
 * AzureResource(IaaS VM) Specific feature support request
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureVMResourceFeatureSupportRequest extends FeatureSupportRequest {
  /**
   * Size of the resource: VM size(A/D series etc) in case of IaasVM
   */
  vmSize?: string;

  /**
   * SKUs (Premium/Managed etc) in case of IaasVM
   */
  vmSku?: string;

  /**
   * backup support feature type.
   */
  featureType: "AzureVMResourceBackup";
}

/**
 * Azure workload specific protection intent item.
 */
model AzureWorkloadContainerAutoProtectionIntent extends ProtectionIntent {
  /**
   * backup protectionIntent type.
   */
  protectionIntentItemType: "AzureWorkloadContainerAutoProtectionIntent";
}

/**
 * Azure Recovery Services Vault specific protection intent item.
 */
model AzureWorkloadAutoProtectionIntent extends ProtectionIntent {
  /**
   * backup protectionIntent type.
   */
  protectionIntentItemType: ProtectionIntentItemType.AzureWorkloadAutoProtectionIntent;
}

/**
 * Azure Workload SQL Auto Protection intent item.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWorkloadSQLAutoProtectionIntent extends ProtectionIntent {
  /**
   * backup protectionIntent type.
   */
  protectionIntentItemType: ProtectionIntentItemType.AzureWorkloadSQLAutoProtectionIntent;

  /**
   * Workload item type of the item for which intent is to be set
   */
  workloadItemType?: WorkloadItemType;
}

/**
 * Query parameters to fetch backup summaries.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BMSBackupSummariesQueryObject {
  /**
   * Backup management type for this container.
   */
  type?: Type;
}

/**
 * Filters to list protection intent.
 */
model ProtectionIntentQueryObject {
  /**
   * Backup management type for the backed up item
   */
  backupManagementType?: BackupManagementType;

  /**
   * Type of workload this item represents
   */
  itemType?: IntentItemType;

  /**
   * Parent name of the intent
   */
  parentName?: string;

  /**
   * Item name of the intent
   */
  itemName?: string;
}

/**
 * Query parameters to fetch list of backup engines.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BMSBackupEngineQueryObject {
  /**
   * attribute to add extended info
   */
  expand?: string;
}

/**
 * Query parameters to fetch list of backup engines.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BMSBackupEnginesQueryObject {
  /**
   * Backup management type for the backup engine.
   */
  backupManagementType?: BackupManagementType;

  /**
   * Friendly name of the backup engine.
   */
  friendlyName?: string;

  /**
   * Attribute to add extended info.
   */
  expand?: string;
}

/**
 * The query filters that can be used with the list containers API.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BMSContainerQueryObject {
  /**
   * Backup management type for this container.
   */
  backupManagementType: BackupManagementType;

  /**
   * Type of container for filter
   */
  containerType?: ContainerType;

  /**
   * Backup engine name
   */
  backupEngineName?: string;

  /**
   * Fabric name for filter
   */
  fabricName?: string;

  /**
   * Status of registration of this container with the Recovery Services Vault.
   */
  status?: string;

  /**
   * Friendly name of this container.
   */
  friendlyName?: string;
}

/**
 * The query filters that can be used with the inquire container API.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BMSContainersInquiryQueryObject {
  /**
   * Backup management type for this container.
   */
  backupManagementType?: BackupManagementType;

  /**
   * Workload type for this container.
   */
  workloadType?: WorkloadType;
}

/**
 * Filters to list items that can be backed up.
 */
model BmspoQueryObject {
  /**
   * Backup management type.
   */
  backupManagementType?: BackupManagementType;

  /**
   * Workload type
   */
  workloadType?: WorkloadType;

  /**
   * Full name of the container whose Protectable Objects should be returned.
   */
  containerName?: string;

  /**
   * Backup status query parameter.
   */
  status?: string;

  /**
   * Friendly name.
   */
  friendlyName?: string;
}

/**
 * The query filters that can be used with the refresh container API.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BMSRefreshContainersQueryObject {
  /**
   * Backup management type for this container.
   */
  backupManagementType?: BackupManagementType;
}

/**
 * Filters to list items that can be backed up.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BMSWorkloadItemQueryObject {
  /**
   * Backup management type.
   */
  backupManagementType?: BackupManagementType;

  /**
   * Workload Item type
   */
  workloadItemType?: WorkloadItemType;

  /**
   * Workload type
   */
  workloadType?: WorkloadType;

  /**
   * Backup status query parameter.
   */
  protectionStatus?: ProtectionStatus;
}

/**
 * Client script details for file / folder restore.
 */
model ClientScriptForConnect {
  /**
   * File content of the client script for file / folder restore.
   */
  scriptContent?: string;

  /**
   * File extension of the client script for file / folder restore - .ps1 , .sh , etc.
   */
  scriptExtension?: string;

  /**
   * OS type - Windows, Linux etc. for which this file / folder restore client script works.
   */
  osType?: string;

  /**
   * URL of Executable from where to source the content. If this is not null then ScriptContent should not be used
   */
  url?: string;

  /**
   * Mandatory suffix that should be added to the name of script that is given for download to user.
   * If its null or empty then , ignore it.
   */
  scriptNameSuffix?: string;
}

/**
 * Container identity information
 */
model ContainerIdentityInfo {
  /**
   * Unique name of the container
   */
  uniqueName?: string;

  /**
   * Protection container identity - AAD Tenant
   */
  aadTenantId?: string;

  /**
   * Protection container identity - AAD Service Principal
   */
  servicePrincipalClientId?: string;

  /**
   * Protection container identity - Audience
   */
  audience?: string;
}

/**
 * Data Protection Manager (DPM) specific backup engine.
 */
model DpmBackupEngine extends BackupEngineBase {
  /**
   * Type of the backup engine.
   */
  backupEngineType: "DpmBackupEngine";
}

/**
 * Base class for generic container of backup items
 */
model GenericContainer extends ProtectionContainer {
  /**
   * Name of the container's fabric
   */
  fabricName?: string;

  /**
   * Extended information (not returned in List container API calls)
   */
  extendedInformation?: GenericContainerExtendedInfo;

  /**
   * Type of the container. The value of this property for: 1. Compute Azure VM is Microsoft.Compute/virtualMachines 2.
   * Classic Compute Azure VM is Microsoft.ClassicCompute/virtualMachines 3. Windows machines (like MAB, DPM etc) is
   * Windows 4. Azure SQL instance is AzureSqlContainer. 5. Storage containers is StorageContainer. 6. Azure workload
   * Backup is VMAppContainer
   */
  containerType: ProtectableContainerType.GenericContainer;
}

/**
 * Container extended information
 */
model GenericContainerExtendedInfo {
  /**
   * Public key of container cert
   */
  rawCertData?: string;

  /**
   * Container identity information
   */
  containerIdentityInfo?: ContainerIdentityInfo;

  /**
   * Azure Backup Service Endpoints for the container
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceEndpoints?: Record<string>;
}

/**
 * IaaS VM workload-specific backup request.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IaasVMBackupRequest extends BackupRequest {
  /**
   * Backup copy will expire after the time specified (UTC).
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryPointExpiryTimeInUTC?: utcDateTime;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "IaasVMBackupRequest";
}

/**
 * Restore files/folders from a backup copy of IaaS VM.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IaasVMILRRegistrationRequest extends ILRRequest {
  /**
   * ID of the IaaS VM backup copy from where the files/folders have to be restored.
   */
  recoveryPointId?: string;

  /**
   * Fully qualified ARM ID of the virtual machine whose the files / folders have to be restored.
   */
  virtualMachineId?: string;

  /**
   * iSCSI initiator name.
   */
  initiatorName?: string;

  /**
   * Whether to renew existing registration with the iSCSI server.
   */
  renewExistingRegistration?: boolean;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "IaasVMILRRegistrationRequest";
}

/**
 * Target details for file / folder restore.
 */
model InstantItemRecoveryTarget {
  /**
   * List of client scripts.
   */
  @identifiers(#[])
  clientScripts?: ClientScriptForConnect[];
}

/**
 * Container with items backed up using MAB backup engine.
 */
model MabContainer extends ProtectionContainer {
  /**
   * Can the container be registered one more time.
   */
  canReRegister?: boolean;

  /**
   * ContainerID represents the container.
   */
  containerId?: int64;

  /**
   * Number of items backed up in this container.
   */
  protectedItemCount?: int64;

  /**
   * Agent version of this container.
   */
  agentVersion?: string;

  /**
   * Additional information for this container
   */
  extendedInfo?: MabContainerExtendedInfo;

  /**
   * Health details on this mab container.
   */
  @identifiers(#["code"])
  mabContainerHealthDetails?: MABContainerHealthDetails[];

  /**
   * Health state of mab container.
   */
  containerHealthState?: string;

  /**
   * Type of the container. The value of this property for: 1. Compute Azure VM is Microsoft.Compute/virtualMachines 2.
   * Classic Compute Azure VM is Microsoft.ClassicCompute/virtualMachines 3. Windows machines (like MAB, DPM etc) is
   * Windows 4. Azure SQL instance is AzureSqlContainer. 5. Storage containers is StorageContainer. 6. Azure workload
   * Backup is VMAppContainer
   */
  containerType: ProtectableContainerType.Windows;
}

/**
 * Additional information of the container.
 */
model MabContainerExtendedInfo {
  /**
   * Time stamp when this container was refreshed.
   */
  lastRefreshedAt?: utcDateTime;

  /**
   * Type of backup items associated with this container.
   */
  backupItemType?: BackupItemType;

  /**
   * List of backup items associated with this container.
   */
  backupItems?: string[];

  /**
   * Backup policy associated with this container.
   */
  policyName?: string;

  /**
   * Latest backup status of this container.
   */
  lastBackupStatus?: string;
}

/**
 * MAB workload-specific Health Details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MABContainerHealthDetails {
  /**
   * Health Code
   */
  code?: int32;

  /**
   * Health Title
   */
  title?: string;

  /**
   * Health Message
   */
  message?: string;

  /**
   * Health Recommended Actions
   */
  recommendations?: string[];
}

/**
 * Operation status job extended info.
 */
model OperationStatusJobExtendedInfo extends OperationStatusExtendedInfo {
  /**
   * ID of the job created for this protected item.
   */
  jobId?: string;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "OperationStatusJobExtendedInfo";
}

/**
 * Operation status extended info for list of jobs.
 */
model OperationStatusJobsExtendedInfo extends OperationStatusExtendedInfo {
  /**
   * IDs of the jobs created for the protected item.
   */
  jobIds?: string[];

  /**
   * Stores all the failed jobs along with the corresponding error codes.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  failedJobsError?: Record<string>;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "OperationStatusJobsExtendedInfo";
}

/**
 * Operation status extended info for ILR provision action.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OperationStatusProvisionILRExtendedInfo
  extends OperationStatusExtendedInfo {
  /**
   * Target details for file / folder restore.
   */
  recoveryTarget?: InstantItemRecoveryTarget;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "OperationStatusProvisionILRExtendedInfo";
}

/**
 * Operation status extended info for ValidateOperation action.
 */
model OperationStatusValidateOperationExtendedInfo
  extends OperationStatusExtendedInfo {
  /**
   * Gets the validation operation response
   */
  validateOperationResponse?: ValidateOperationResponse;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "OperationStatusValidateOperationExtendedInfo";
}

/**
 * AzureWorkload SAP Hana-specific restore with integrated rehydration of recovery point.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWorkloadSAPHanaPointInTimeRestoreWithRehydrateRequest
  extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSAPHanaPointInTimeRestoreWithRehydrateRequest";

  /**
   * RP Rehydration Info
   */
  recoveryPointRehydrationInfo?: RecoveryPointRehydrationInfo;

  ...AzureWorkloadSAPHanaPointInTimeRestoreRequestProperties;
  ...AzureWorkloadRestoreRequestProperties;
}

/**
 * RP Rehydration Info
 */
model RecoveryPointRehydrationInfo {
  /**
   * How long the rehydrated RP should be kept
   * Should be ISO8601 Duration format e.g. "P7D"
   */
  rehydrationRetentionDuration?: string;

  /**
   * Rehydration Priority
   */
  rehydrationPriority?: RehydrationPriority;
}

/**
 * AzureWorkload SAP Hana-specific restore with integrated rehydration of recovery point.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWorkloadSAPHanaRestoreWithRehydrateRequest extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSAPHanaRestoreWithRehydrateRequest";

  /**
   * RP Rehydration Info
   */
  recoveryPointRehydrationInfo?: RecoveryPointRehydrationInfo;

  ...AzureWorkloadRestoreRequestProperties;
}

/**
 * AzureWorkload SQL-specific restore with integrated rehydration of recovery point.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest
  extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest";

  /**
   * RP Rehydration Info
   */
  recoveryPointRehydrationInfo?: RecoveryPointRehydrationInfo;

  ...AzureWorkloadSQLPointInTimeRestoreRequestProperties;
  ...AzureWorkloadSQLRestoreRequestProperties;
  ...AzureWorkloadRestoreRequestProperties;
}

/**
 * AzureWorkload SQL-specific restore with integrated rehydration of recovery point
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWorkloadSQLRestoreWithRehydrateRequest extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSQLRestoreWithRehydrateRequest";

  /**
   * RP Rehydration Info
   */
  recoveryPointRehydrationInfo?: RecoveryPointRehydrationInfo;

  ...AzureWorkloadSQLRestoreRequestProperties;
  ...AzureWorkloadRestoreRequestProperties;
}

/**
 * IaaS VM workload-specific restore with integrated rehydration of recovery point.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IaasVMRestoreWithRehydrationRequest extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "IaasVMRestoreWithRehydrationRequest";

  /**
   * RP Rehydration Info
   */
  recoveryPointRehydrationInfo?: RecoveryPointRehydrationInfo;

  ...IaasVMRestoreRequestProperties;
}

/**
 * Request parameters for fetching cost info of rehydration
 */
model FetchTieringCostInfoForRehydrationRequest
  extends FetchTieringCostInfoRequest {
  /**
   * Name of the protected item container
   */
  containerName: string;

  /**
   * Name of the protectedItemName
   */
  protectedItemName: string;

  /**
   * ID of the backup copy for rehydration cost info needs to be fetched.
   */
  recoveryPointId: string;

  /**
   * Rehydration Priority
   */
  rehydrationPriority: RehydrationPriority;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "FetchTieringCostInfoForRehydrationRequest";
}

/**
 * Response parameters for tiering cost info for rehydration
 */
model TieringCostRehydrationInfo extends TieringCostInfo {
  /**
   * Rehydration size in bytes
   */
  rehydrationSizeInBytes: int64;

  /**
   * Source tier to target tier rehydration cost per GB per month
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  retailRehydrationCostPerGBPerMonth: float64;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "TieringCostRehydrationInfo";
}

/**
 * Response parameters for tiering cost info for savings
 */
model TieringCostSavingInfo extends TieringCostInfo {
  /**
   * Source tier size reduction in bytes after moving all the recommended backup points to target tier
   */
  sourceTierSizeReductionInBytes: int64;

  /**
   * Target tier size increase in bytes after moving all the recommended backup points to target tier
   */
  targetTierSizeIncreaseInBytes: int64;

  /**
   * Source tier retail cost per GB per month
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  retailSourceTierCostPerGBPerMonth: float64;

  /**
   * Target tier retail cost per GB per month
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  retailTargetTierCostPerGBPerMonth: float64;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "TieringCostSavingInfo";
}

/**
 * Request parameters for tiering cost info for policy
 */
model FetchTieringCostSavingsInfoForPolicyRequest
  extends FetchTieringCostInfoRequest {
  /**
   * Name of the backup policy for which the cost savings information is requested
   */
  policyName: string;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "FetchTieringCostSavingsInfoForPolicyRequest";
}

/**
 * Request parameters for tiering cost info for protected item
 */
model FetchTieringCostSavingsInfoForProtectedItemRequest
  extends FetchTieringCostInfoRequest {
  /**
   * Name of the protected item container
   */
  containerName: string;

  /**
   * Name of the protectedItemName
   */
  protectedItemName: string;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "FetchTieringCostSavingsInfoForProtectedItemRequest";
}

/**
 * Request parameters for tiering cost info for vault
 */
model FetchTieringCostSavingsInfoForVaultRequest
  extends FetchTieringCostInfoRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "FetchTieringCostSavingsInfoForVaultRequest";
}

/**
 * Operations List response which contains list of available APIs.
 */
model ClientDiscoveryResponse {
  /**
   * List of available operations.
   */
  @pageItems
  @identifiers(#[])
  value?: ClientDiscoveryValueForSingleApi[];

  /**
   * Link to the next chunk of Response.
   */
  @nextLink
  nextLink?: string;
}
