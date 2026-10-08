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
  @doc("A SQL Server workload hosted in an Azure virtual machine.")
  SqlInAzureVm: "SqlInAzureVm",

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
  LatestRecoveryPoint: "LatestRecoveryPoint",

  @added(Versions.v2026_11_30_preview)
  @doc("Use a recovery point for a specific point in time.")
  PointInTime: "PointInTime",

  @added(Versions.v2026_11_30_preview)
  @doc("Use the most recent application-consistent recovery point.")
  MostRecentApplicationConsistentRecoveryPoint: "MostRecentApplicationConsistentRecoveryPoint",

  @added(Versions.v2026_11_30_preview)
  @doc("Use the most recent crash-consistent recovery point.")
  MostRecentCrashConsistentRecoveryPoint: "MostRecentCrashConsistentRecoveryPoint",

  string,
}

@added(Versions.v2026_11_30_preview)
@doc("The disk restore performance mode.")
union DiskRestoreMode {
  @added(Versions.v2026_11_30_preview)
  @doc("Use standard disk restore performance.")
  Standard: "Standard",

  @added(Versions.v2026_11_30_preview)
  @doc("Use ultra-high disk restore performance.")
  UltraHigh: "UltraHigh",

  @added(Versions.v2026_11_30_preview)
  @doc("Use premium disk restore performance.")
  Premium: "Premium",

  string,
}

@added(Versions.v2026_11_30_preview)
@doc("The desired database recovery state.")
union RecoveryState {
  @added(Versions.v2026_11_30_preview)
  @doc("Commit the recovered database.")
  Committed: "Committed",

  @added(Versions.v2026_11_30_preview)
  @doc("Leave the recovered database in standby.")
  Standby: "Standby",

  @added(Versions.v2026_11_30_preview)
  @doc("Do not recover the database.")
  NoRecovery: "NoRecovery",

  string,
}

@added(Versions.v2026_11_30_preview)
@doc("The behavior when a database target already exists.")
union OverwriteOptions {
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
@doc("The behavior when a copied file already exists.")
union CopyOptions {
  @added(Versions.v2026_11_30_preview)
  @doc("Overwrite the existing file.")
  Overwrite: "Overwrite",

  @added(Versions.v2026_11_30_preview)
  @doc("Skip the file when it exists.")
  SkipIfExists: "SkipIfExists",

  @added(Versions.v2026_11_30_preview)
  @doc("Fail recovery when the file exists.")
  Fail: "Fail",

  string,
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
@doc("The binding state of a resolved target resource.")
union BindingState {
  @added(Versions.v2026_11_30_preview)
  @doc("The target resource is bound.")
  Bound: "Bound",

  string,
}

@added(Versions.v2026_11_30_preview)
@doc("The conformance state of a resolved target resource.")
union ConformanceState {
  @added(Versions.v2026_11_30_preview)
  @doc("Target conformance has not been checked.")
  NotChecked: "NotChecked",

  string,
}

@added(Versions.v2026_11_30_preview)
@doc("The subscription and region targeted by a recovery configuration profile.")
model TargetScope {
  @added(Versions.v2026_11_30_preview)
  @doc("The target Azure subscription identifier.")
  subscriptionId: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The target Azure region.")
  region: string;
}

@added(Versions.v2026_11_30_preview)
@doc("Default recovery point selection for a recovery configuration profile.")
model RecoveryPointPolicy {
  @added(Versions.v2026_11_30_preview)
  @doc("The recovery point selection policy type.")
  type: RecoveryPointPolicyType;

  @added(Versions.v2026_11_30_preview)
  @doc("The requested recovery point time when the policy is PointInTime.")
  pointInTime?: utcDateTime;

  @added(Versions.v2026_11_30_preview)
  @minValue(0)
  @doc("The maximum acceptable recovery point age, in hours.")
  maxAgeHours?: int32;
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
@doc("Default snapshot restore settings.")
model SnapshotRestoreDefault {
  @added(Versions.v2026_11_30_preview)
  @doc("The snapshot restore type.")
  type?: string;

  @added(Versions.v2026_11_30_preview)
  @minValue(0)
  @doc("The snapshot retention period, in days.")
  retentionDays?: int32;
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
  @doc("Indicates whether restored disks are managed disks.")
  restoreWithManagedDisks?: boolean;

  @added(Versions.v2026_11_30_preview)
  @doc("The target availability zones.")
  zones?: string[];

  @added(Versions.v2026_11_30_preview)
  @doc("The default disk restore mode.")
  diskRestoreDefault?: DiskRestoreMode;

  @added(Versions.v2026_11_30_preview)
  @doc("The preferred recovery point tier.")
  recoveryPointTierPreference?: string;

  @added(Versions.v2026_11_30_preview)
  @doc("Default recovery point rehydration settings.")
  rehydrationDefault?: RecoveryPointRehydrationInfo;
}

@added(Versions.v2026_11_30_preview)
@doc("Shared recovery configuration fields for database workloads.")
model DatabaseRecoveryConfig extends WorkloadConfig {
  @added(Versions.v2026_11_30_preview)
  @doc("The target resource group.")
  resourceGroup: TargetResourceSpec;

  @added(Versions.v2026_11_30_preview)
  @doc("The target database host virtual machine.")
  targetHostVm: TargetResourceSpec;

  @added(Versions.v2026_11_30_preview)
  @doc("The identity of the target host virtual machine.")
  hostVmIdentity?: RestoreIdentity;

  @added(Versions.v2026_11_30_preview)
  @doc("The database recovery mode.")
  recoveryMode?: string;

  @added(Versions.v2026_11_30_preview)
  @doc("Indicates whether an alternate target location is used.")
  shouldUseAlternateTargetLocation?: boolean;

  @added(Versions.v2026_11_30_preview)
  @doc("The default database recovery state.")
  recoveryStateDefault?: RecoveryState;

  @added(Versions.v2026_11_30_preview)
  @doc("The behavior when a database target already exists.")
  overwriteOption?: OverwriteOptions;

  @added(Versions.v2026_11_30_preview)
  @doc("The target directory for file restore.")
  targetDirectoryForFileRestore?: string;

  @added(Versions.v2026_11_30_preview)
  @doc("Default snapshot restore settings.")
  snapshotRestoreDefault?: SnapshotRestoreDefault;

  @added(Versions.v2026_11_30_preview)
  @doc("Default recovery point rehydration settings.")
  rehydrationDefault?: RecoveryPointRehydrationInfo;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance intentionally emits shared database recovery fields through allOf; WorkloadConfig defines the workloadType discriminator."
@added(Versions.v2026_11_30_preview)
@doc("Recovery configuration for a SQL Server workload.")
model SqlInAzureVmRecoveryConfig extends DatabaseRecoveryConfig {
  @added(Versions.v2026_11_30_preview)
  @doc("The workload type represented by this configuration.")
  workloadType: WorkloadType.SqlInAzureVm;
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
  @doc("The identity used for restore.")
  identity?: RestoreIdentity;

  @added(Versions.v2026_11_30_preview)
  @doc("The default scope of file restore.")
  restoreTypeDefault?: FileRestoreType;

  @added(Versions.v2026_11_30_preview)
  @doc("The behavior when a copied file already exists.")
  copyOptions?: CopyOptions;
}

@added(Versions.v2026_11_30_preview)
@doc("The effective, resolved recovery configuration.")
model EffectiveConfiguration {
  @added(Versions.v2026_11_30_preview)
  @visibility(Lifecycle.Read)
  @doc("The effective workload configuration.")
  workloadConfig: WorkloadConfig;

  @added(Versions.v2026_11_30_preview)
  @visibility(Lifecycle.Read)
  @identifiers(#["role"])
  @doc("The resolved target resources.")
  resolvedTargets: ResolvedTargetResource[];
}

@added(Versions.v2026_11_30_preview)
@doc("A target resource resolved for effective recovery configuration.")
model ResolvedTargetResource {
  @added(Versions.v2026_11_30_preview)
  @doc("The semantic role of the target.")
  role: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The full Azure resource type of the target. The service validates that the resource type is supported for the target role.")
  armResourceType: TargetResourceType;

  @added(Versions.v2026_11_30_preview)
  @doc("How the target is provisioned.")
  provisioningMode: TargetProvisioningMode;

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifier resolved for the target.")
  resolvedResourceId: armResourceIdentifier;

  @added(Versions.v2026_11_30_preview)
  @doc("The target binding state.")
  bindingState: BindingState;

  @added(Versions.v2026_11_30_preview)
  @doc("The target conformance result.")
  conformance: ConformanceResult;
}

@added(Versions.v2026_11_30_preview)
@doc("The result of checking target resource conformance.")
model ConformanceResult {
  @added(Versions.v2026_11_30_preview)
  @doc("The target conformance state.")
  state: ConformanceState;

  @added(Versions.v2026_11_30_preview)
  @doc("The UTC time when conformance was checked.")
  checkedAt: utcDateTime;

  @added(Versions.v2026_11_30_preview)
  @doc("Conformance error messages.")
  errors: string[];
}

@added(Versions.v2026_11_30_preview)
@doc("Properties of a plan-scoped recovery configuration profile.")
model RecoveryConfigProfileProperties {
  @added(Versions.v2026_11_30_preview)
  @visibility(Lifecycle.Read)
  @doc("The workload type configured by this profile. This response-only value is populated by the service from workloadConfig.workloadType.")
  workloadType: WorkloadType;

  @added(Versions.v2026_11_30_preview)
  @doc("The subscription and region targeted by this profile.")
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
  recoveryPointDefault?: RecoveryPointPolicy;

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
