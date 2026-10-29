import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../../main.tsp";
import "./recoveryPlan.tsp";
import "./recoveryResource.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@added(Versions.v2026_11_30_preview)
@doc("The workload protected by a recovery configuration profile.")
union WorkloadType {
  @added(Versions.v2026_11_30_preview)
  @doc("An Azure virtual machine workload.")
  AzureVm: "AzureVm",

  @added(Versions.v2026_11_30_preview)
  @doc("A SQL database workload hosted in an Azure virtual machine.")
  SqlDatabaseInAzureVm: "SqlDatabaseInAzureVm",

  @added(Versions.v2026_11_30_preview)
  @doc("A SQL Server instance workload hosted in an Azure virtual machine.")
  SqlServerInAzureVm: "SqlServerInAzureVm",

  @added(Versions.v2026_11_30_preview)
  @doc("An SAP HANA workload hosted in an Azure virtual machine.")
  SapHanaInAzureVm: "SapHanaInAzureVm",

  @added(Versions.v2026_11_30_preview)
  @doc("An SAP ASE workload hosted in an Azure virtual machine.")
  SapAseInAzureVm: "SapAseInAzureVm",

  @added(Versions.v2026_11_30_preview)
  @doc("An Oracle workload hosted in an Azure virtual machine.")
  OracleInAzureVm: "OracleInAzureVm",

  @added(Versions.v2026_11_30_preview)
  @doc("An Azure Files workload.")
  AzureFileShare: "AzureFileShare",

  string,
}

@added(Versions.v2026_11_30_preview)
@doc("The supported recovery location behavior.")
union RecoveryType {
  @added(Versions.v2026_11_30_preview)
  @doc("Recovery targets an alternate location.")
  AlternateLocation: "AlternateLocation",

  string,
}

@added(Versions.v2026_11_30_preview)
@doc("How a target resource is provisioned.")
union TargetProvisioningMode {
  @added(Versions.v2026_11_30_preview)
  @doc("An existing target resource is used.")
  Existing: "Existing",

  @added(Versions.v2026_11_30_preview)
  @doc("A new target resource is created during recovery.")
  Created: "Created",

  @added(Versions.v2026_11_30_preview)
  @doc("A target resource is provisioned outside the recovery orchestration service.")
  ExternallyProvisioned: "ExternallyProvisioned",

  string,
}

@added(Versions.v2026_11_30_preview)
@doc("A full Azure resource type used as a recovery target.")
union TargetResourceType {
  @added(Versions.v2026_11_30_preview)
  @doc("An Azure virtual machine.")
  VirtualMachine: "Microsoft.Compute/virtualMachines",

  @added(Versions.v2026_11_30_preview)
  @doc("An Azure virtual network.")
  VirtualNetwork: "Microsoft.Network/virtualNetworks",

  @added(Versions.v2026_11_30_preview)
  @doc("An Azure virtual network subnet.")
  Subnet: "Microsoft.Network/virtualNetworks/subnets",

  @added(Versions.v2026_11_30_preview)
  @doc("An Azure storage account.")
  StorageAccount: "Microsoft.Storage/storageAccounts",

  @added(Versions.v2026_11_30_preview)
  @doc("An Azure disk encryption set.")
  DiskEncryptionSet: "Microsoft.Compute/diskEncryptionSets",

  @added(Versions.v2026_11_30_preview)
  @doc("An Azure Key Vault vault.")
  KeyVault: "Microsoft.KeyVault/vaults",

  @added(Versions.v2026_11_30_preview)
  @doc("An Azure network security group.")
  NetworkSecurityGroup: "Microsoft.Network/networkSecurityGroups",

  string,
}

@added(Versions.v2026_11_30_preview)
@doc("A policy for selecting a recovery point.")
union RecoveryPointPolicyType {
  @added(Versions.v2026_11_30_preview)
  @doc("Use the latest available recovery point.")
  Latest: "Latest",

  @added(Versions.v2026_11_30_preview)
  @doc("Use a random recovery point within the specified time bounds.")
  Random: "Random",

  string,
}

@added(Versions.v2026_11_30_preview)
@doc("The backup mechanism used to select recovery points.")
union BackupType {
  @added(Versions.v2026_11_30_preview)
  @doc("Streaming backups, including full, differential, incremental, and other supported backup categories.")
  Streaming: "Streaming",

  @added(Versions.v2026_11_30_preview)
  @doc("Log backups that provide point-in-time recovery candidates.")
  Log: "Log",

  @added(Versions.v2026_11_30_preview)
  @doc("Snapshot backups.")
  Snapshot: "Snapshot",

  string,
}

@added(Versions.v2026_11_30_preview)
@doc("The health eligibility filter for discrete recovery points. This filter does not apply to log or point-in-time recovery candidates.")
union RecoveryPointHealthStatus {
  @added(Versions.v2026_11_30_preview)
  @doc("Include only recovery points with a Healthy threat status.")
  HealthyOnly: "HealthyOnly",

  @added(Versions.v2026_11_30_preview)
  @doc("Include recovery points with Healthy, Unknown, unspecified, or NotAvailable threat statuses, excluding Warning and UnHealthy.")
  HealthyAndUnknown: "HealthyAndUnknown",

  @added(Versions.v2026_11_30_preview)
  @doc("Include all threat statuses without health-based ordering.")
  All: "All",

  string,
}

@added(Versions.v2026_11_30_preview)
@doc("The behavior when a recovery target already exists.")
union ExistingTargetBehavior {
  @added(Versions.v2026_11_30_preview)
  @doc("Overwrite the existing target.")
  Overwrite: "Overwrite",

  @added(Versions.v2026_11_30_preview)
  @doc("Skip recovery when the target exists.")
  SkipIfExists: "SkipIfExists",

  @added(Versions.v2026_11_30_preview)
  @doc("Fail recovery when the target exists.")
  Fail: "Fail",

  string,
}

@added(Versions.v2026_11_30_preview)
@doc("The behavior when a database restore target already exists.")
union OverwriteOptions {
  @added(Versions.v2026_11_30_preview)
  @doc("The overwrite option is invalid or unspecified.")
  Invalid: 0,

  @added(Versions.v2026_11_30_preview)
  @doc("Fail the restore when the target conflicts with an existing resource.")
  FailOnConflict: 1,

  @added(Versions.v2026_11_30_preview)
  @doc("Overwrite the existing restore target.")
  Overwrite: 2,

  int32,
}

@added(Versions.v2026_11_30_preview)
@doc("The scope of an Azure Files restore.")
union FileRestoreType {
  @added(Versions.v2026_11_30_preview)
  @doc("Restore the complete file share.")
  FullShare: "FullShare",

  string,
}

@added(Versions.v2026_11_30_preview)
@doc("The recovery point rehydration priority.")
union RehydrationPriority {
  @added(Versions.v2026_11_30_preview)
  @doc("Use standard rehydration priority.")
  Standard: "Standard",

  @added(Versions.v2026_11_30_preview)
  @doc("Use high rehydration priority.")
  High: "High",

  string,
}

@added(Versions.v2026_11_30_preview)
@doc("The subscription and location targeted by a recovery configuration profile.")
model TargetScope {
  @added(Versions.v2026_11_30_preview)
  @doc("The target Azure subscription identifier.")
  subscriptionId: uuid;

  @added(Versions.v2026_11_30_preview)
  @doc("The target Azure location.")
  location: string;
}

@added(Versions.v2026_11_30_preview)
@doc("Default recovery point selection for a recovery configuration profile.")
model RecoveryPointPolicy {
  @added(Versions.v2026_11_30_preview)
  @doc("The recovery point selection policy type.")
  type: RecoveryPointPolicyType;

  @added(Versions.v2026_11_30_preview)
  @doc("The inclusive lower time bound. Required with endTime for Random selection when lookbackDuration is omitted; optional for Latest selection. Mutually exclusive with lookbackDuration.")
  startTime?: utcDateTime;

  @added(Versions.v2026_11_30_preview)
  @doc("The inclusive upper time bound. Required with startTime for Random selection when lookbackDuration is omitted; optional for Latest selection. Mutually exclusive with lookbackDuration.")
  endTime?: utcDateTime;

  @added(Versions.v2026_11_30_preview)
  @doc("A positive, fixed ISO 8601 duration for relative Random selection, such as P10D or PT12H. Only days, hours, minutes, and seconds are supported; calendar-dependent months and years are not supported. Mutually exclusive with startTime and endTime. The service resolves the duration to absolute bounds at execution time without modifying the saved profile.")
  lookbackDuration?: duration;

  @added(Versions.v2026_11_30_preview)
  @minItems(1)
  @doc("The explicit, non-empty list of unique backup mechanisms to consider. Random selection cannot include Log, even when other mechanisms are also selected.")
  backupType: BackupType[];

  @added(Versions.v2026_11_30_preview)
  @doc("The health filter for discrete recovery points. Omission means All. Log and point-in-time recovery candidates are not health-filtered.")
  recoveryPointHealthStatus?: RecoveryPointHealthStatus;
}

@added(Versions.v2026_11_30_preview)
@doc("A target resource required by a recovery workload.")
model TargetResourceSpec {
  @added(Versions.v2026_11_30_preview)
  @doc("The semantic role of this target resource.")
  role: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The full Azure resource type of the target. The service validates that the resource type is supported for the target role.")
  armResourceType: TargetResourceType;

  @added(Versions.v2026_11_30_preview)
  @doc("How the target resource is provisioned.")
  provisioningMode?: TargetProvisioningMode = TargetProvisioningMode.Existing;

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifier of the target. Required only when provisioningMode is Existing; omit for Created and ExternallyProvisioned.")
  resourceId?: armResourceIdentifier;

  @added(Versions.v2026_11_30_preview)
  @doc("The semantic roles of target resources that this target depends on.")
  dependsOn?: string[];
}

@added(Versions.v2026_11_30_preview)
@doc("A managed identity used for a restore.")
model RestoreIdentity {
  @added(Versions.v2026_11_30_preview)
  @doc("The managed identity type.")
  identityType: Azure.ResourceManager.CommonTypes.ManagedServiceIdentityType;

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifier of the user-assigned identity.")
  userAssignedIdentityId?: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

@added(Versions.v2026_11_30_preview)
@doc("Recovery point rehydration settings.")
model RecoveryPointRehydrationInfo {
  @added(Versions.v2026_11_30_preview)
  @doc("The requested rehydration priority.")
  rehydrationPriority: RehydrationPriority;

  @added(Versions.v2026_11_30_preview)
  @minValue(0)
  @doc("The requested rehydration duration, in hours.")
  rehydrationDurationInHours?: int32;
}

@added(Versions.v2026_11_30_preview)
@discriminator("workloadType")
@doc("Workload-specific recovery configuration.")
model WorkloadConfig {
  @added(Versions.v2026_11_30_preview)
  @doc("The workload type represented by this configuration.")
  workloadType: WorkloadType;
}

@added(Versions.v2026_11_30_preview)
@doc("Recovery configuration for an Azure virtual machine.")
model VmRecoveryConfig extends WorkloadConfig {
  @added(Versions.v2026_11_30_preview)
  @doc("The target resource group.")
  resourceGroup: TargetResourceSpec;

  @added(Versions.v2026_11_30_preview)
  @doc("The target virtual network.")
  virtualNetwork: TargetResourceSpec;

  @added(Versions.v2026_11_30_preview)
  @doc("The target subnet.")
  subnet: TargetResourceSpec;

  @added(Versions.v2026_11_30_preview)
  @doc("The target storage account.")
  storageAccount: TargetResourceSpec;

  @added(Versions.v2026_11_30_preview)
  @doc("The workload type represented by this configuration.")
  workloadType: WorkloadType.AzureVm;

  @added(Versions.v2026_11_30_preview)
  @doc("The target disk encryption set.")
  diskEncryptionSet?: TargetResourceSpec;

  @added(Versions.v2026_11_30_preview)
  @doc("The identity used for restore.")
  identity?: RestoreIdentity;

  @added(Versions.v2026_11_30_preview)
  @doc("The target availability zones.")
  zones?: string[];

  @added(Versions.v2026_11_30_preview)
  @doc("Default recovery point rehydration settings.")
  rehydrationDefault?: RecoveryPointRehydrationInfo;
}

@added(Versions.v2026_11_30_preview)
@doc("Shared recovery configuration fields for database workloads.")
model DatabaseRecoveryConfig extends WorkloadConfig {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Preserves the Dictionary<string, string> contract of DatabaseRecoveryConfig.targetDirectoryMapping, whose keys identify recovery point types."
  @added(Versions.v2026_11_30_preview)
  @doc("The target folder mappings for full, differential, log, and incremental recovery points.")
  targetDirectoryMapping?: Record<string>;

  @added(Versions.v2026_11_30_preview)
  @doc("The target directory location for restoring a database as files.")
  targetDirectoryForFileRestore?: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifier of the target virtual machine.")
  targetVirtualMachineId?: armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachines";
    }
  ]>;

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifier of the target vault.")
  targetVaultId?: armResourceIdentifier;

  @added(Versions.v2026_11_30_preview)
  @doc("The behavior when the restore target already exists.")
  overwriteOption?: OverwriteOptions;

  @added(Versions.v2026_11_30_preview)
  @doc("The target database instance name.")
  instanceName?: string;
}

@added(Versions.v2026_11_30_preview)
@doc("A mapping from a SQL restore source directory to a target directory.")
model SqlDataDirectoryMapping {
  @added(Versions.v2026_11_30_preview)
  @doc("The directory mapping type.")
  mappingType: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The source logical name.")
  sourceLogicalName?: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The source directory path.")
  sourcePath?: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The target directory path.")
  targetPath?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance intentionally emits shared database recovery fields through allOf; WorkloadConfig defines the workloadType discriminator."
@added(Versions.v2026_11_30_preview)
@doc("Recovery configuration for a SQL database in an Azure virtual machine.")
model SqlDatabaseInAzureVmRecoveryConfig extends DatabaseRecoveryConfig {
  @added(Versions.v2026_11_30_preview)
  @doc("The workload type represented by this configuration.")
  workloadType: WorkloadType.SqlDatabaseInAzureVm;

  @added(Versions.v2026_11_30_preview)
  @doc("Indicates whether the database is left in the NORECOVERY state after restore.")
  isNonRecoverable?: boolean;

  @added(Versions.v2026_11_30_preview)
  @identifiers(#[])
  @doc("The alternate data directory mappings.")
  alternateDirectoryPaths?: SqlDataDirectoryMapping[];
}

@added(Versions.v2026_11_30_preview)
@doc("Client and principal identifiers of a user-assigned managed identity.")
model UserAssignedIdentityProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The client identifier of the identity.")
  clientId?: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The principal identifier of the identity.")
  principalId?: string;
}

@added(Versions.v2026_11_30_preview)
@doc("Details of a user-assigned managed identity used for restore.")
model UserAssignedManagedIdentityDetails {
  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifier of the identity.")
  identityArmId?: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  @added(Versions.v2026_11_30_preview)
  @doc("The identity name.")
  identityName?: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The client and principal identifiers of the identity.")
  userAssignedIdentityProperties?: UserAssignedIdentityProperties;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance intentionally emits shared database recovery fields through allOf; WorkloadConfig defines the workloadType discriminator."
@added(Versions.v2026_11_30_preview)
@doc("Recovery configuration for a SQL Server instance in an Azure virtual machine.")
model SqlServerInAzureVmRecoveryConfig extends DatabaseRecoveryConfig {
  @added(Versions.v2026_11_30_preview)
  @doc("The workload type represented by this configuration.")
  workloadType: WorkloadType.SqlServerInAzureVm;

  @added(Versions.v2026_11_30_preview)
  @doc("The user-assigned managed identity details used for restore.")
  userAssignedManagedIdentityDetails?: UserAssignedManagedIdentityDetails;

  @added(Versions.v2026_11_30_preview)
  @doc("Indicates whether the restored SQL Server databases are left in the NORECOVERY state.")
  isNonRecoverable?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance intentionally emits shared database recovery fields through allOf; WorkloadConfig defines the workloadType discriminator."
@added(Versions.v2026_11_30_preview)
@doc("Recovery configuration for an SAP HANA workload.")
model SapHanaInAzureVmRecoveryConfig extends DatabaseRecoveryConfig {
  @added(Versions.v2026_11_30_preview)
  @doc("The workload type represented by this configuration.")
  workloadType: WorkloadType.SapHanaInAzureVm;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance intentionally emits shared database recovery fields through allOf; WorkloadConfig defines the workloadType discriminator."
@added(Versions.v2026_11_30_preview)
@doc("Recovery configuration for an SAP ASE workload.")
model SapAseInAzureVmRecoveryConfig extends DatabaseRecoveryConfig {
  @added(Versions.v2026_11_30_preview)
  @doc("The workload type represented by this configuration.")
  workloadType: WorkloadType.SapAseInAzureVm;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance intentionally emits shared database recovery fields through allOf; WorkloadConfig defines the workloadType discriminator."
@added(Versions.v2026_11_30_preview)
@doc("Recovery configuration for an Oracle workload.")
model OracleInAzureVmRecoveryConfig extends DatabaseRecoveryConfig {
  @added(Versions.v2026_11_30_preview)
  @doc("The workload type represented by this configuration.")
  workloadType: WorkloadType.OracleInAzureVm;
}

@added(Versions.v2026_11_30_preview)
@doc("Recovery configuration for an Azure Files workload.")
model FileShareRecoveryConfig extends WorkloadConfig {
  @added(Versions.v2026_11_30_preview)
  @doc("The workload type represented by this configuration.")
  workloadType: WorkloadType.AzureFileShare;

  @added(Versions.v2026_11_30_preview)
  @doc("The target storage account.")
  storageAccount: TargetResourceSpec;

  @added(Versions.v2026_11_30_preview)
  @doc("The destination folder path in the target file share.")
  targetFolderPath?: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The identity used for restore.")
  identity?: RestoreIdentity;

  @added(Versions.v2026_11_30_preview)
  @doc("The default scope of file restore.")
  restoreTypeDefault?: FileRestoreType;

  @added(Versions.v2026_11_30_preview)
  @doc("The behavior when a copied file already exists.")
  copyOptions?: ExistingTargetBehavior;
}

@added(Versions.v2026_11_30_preview)
@doc("The effective, resolved recovery configuration.")
model EffectiveConfiguration {
  @added(Versions.v2026_11_30_preview)
  @visibility(Lifecycle.Read)
  @doc("The effective workload configuration.")
  workloadConfig: WorkloadConfig;
}

@added(Versions.v2026_11_30_preview)
@doc("Properties of a plan-scoped recovery configuration profile.")
model RecoveryConfigProfileProperties {
  @added(Versions.v2026_11_30_preview)
  @visibility(Lifecycle.Read)
  @doc("The workload type configured by this profile. This response-only value is populated by the service from workloadConfig.workloadType.")
  workloadType: WorkloadType;

  @added(Versions.v2026_11_30_preview)
  @doc("The subscription and location targeted by this profile.")
  targetScope: TargetScope;

  @added(Versions.v2026_11_30_preview)
  @doc("The workload-specific recovery configuration.")
  workloadConfig: WorkloadConfig;

  @added(Versions.v2026_11_30_preview)
  @doc("The prefix used when naming recovery targets.")
  targetNamePrefix?: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The recovery location behavior.")
  recoveryType?: RecoveryType = RecoveryType.AlternateLocation;

  @added(Versions.v2026_11_30_preview)
  @doc("Default recovery point selection.")
  recoveryPointPolicy?: RecoveryPointPolicy;

  @added(Versions.v2026_11_30_preview)
  @identifiers(#[])
  @maxItems(10)
  @doc("Infrastructure actions run before restoring resources that use this recovery configuration profile.")
  infrastructurePreparation?: RecoveryGroupBaseAction[];

  @added(Versions.v2026_11_30_preview)
  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the recovery configuration profile.")
  provisioningState?: ProvisioningState;

  @added(Versions.v2026_11_30_preview)
  @visibility(Lifecycle.Read)
  @doc("Indicates whether the profile requires user attention.")
  needsAttention?: boolean;

  @added(Versions.v2026_11_30_preview)
  @visibility(Lifecycle.Read)
  @doc("Structured reasons that the profile requires attention.")
  attentionReasons?: string[];

  @added(Versions.v2026_11_30_preview)
  @visibility(Lifecycle.Read)
  @doc("The effective profile configuration resolved at read time.")
  effectiveConfiguration?: EffectiveConfiguration;
}

@parentResource(RecoveryPlan)
@added(Versions.v2026_11_30_preview)
@doc("A reusable, plan-scoped clean-room recovery configuration.")
model RecoveryConfigProfile is ProxyResource<RecoveryConfigProfileProperties> {
  @doc("The name of the recovery configuration profile.")
  @pattern("^[A-Za-z0-9_]([A-Za-z0-9_.-]{0,126}[A-Za-z0-9_])?$")
  @key("recoveryConfigProfileName")
  @segment("recoveryConfigProfiles")
  @path
  name: string;
}

@added(Versions.v2026_11_30_preview)
@doc("The writable properties of a recovery configuration profile that can be updated.")
model RecoveryConfigProfilePatchProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The subscription and location targeted by this profile.")
  targetScope?: TargetScope;

  @added(Versions.v2026_11_30_preview)
  @doc("The workload-specific recovery configuration.")
  workloadConfig?: WorkloadConfig;

  @added(Versions.v2026_11_30_preview)
  @doc("The prefix used when naming recovery targets.")
  targetNamePrefix?: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The recovery location behavior.")
  recoveryType?: RecoveryType;

  @added(Versions.v2026_11_30_preview)
  @doc("Default recovery point selection.")
  recoveryPointPolicy?: RecoveryPointPolicy;

  @added(Versions.v2026_11_30_preview)
  @identifiers(#[])
  @maxItems(10)
  @doc("Infrastructure actions run before restoring resources that use this recovery configuration profile.")
  infrastructurePreparation?: RecoveryGroupBaseAction[];
}

@added(Versions.v2026_11_30_preview)
@doc("The request body for partially updating a recovery configuration profile.")
model RecoveryConfigProfilePatch {
  @added(Versions.v2026_11_30_preview)
  @doc("The profile properties to update. Omitted properties remain unchanged.")
  properties?: RecoveryConfigProfilePatchProperties;
}
